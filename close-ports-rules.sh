#/bin/bash

ALLOWED_SOURCES=${ALLOWED_SOURCES:="10.0.0.0/8 192.168.0.0/16 172.0.0.1/32"}
CLOSED_PORTS=${CLOSED_PORTS:="53 123 5432 27017"}
PROTOCOLS=${PROTOCOLS:="tcp udp"}
ACTION=${ACTION:="-A"}

for PORT in $CLOSED_PORTS
do
	for SOURCE in $ALLOWED_SOURCES
	do
		for PROTOCOL in $PROTOCOLS
		do
			echo "iptables ${ACTION} INPUT -s ${SOURCE} -p ${PROTOCOL} -m ${PROTOCOL} --dport ${PORT} -j ACCEPT"
		done
	done
	for PROTOCOL in $PROTOCOLS
	do
		echo "iptables ${ACTION} INPUT -p ${PROTOCOL} -m ${PROTOCOL} --dport ${PORT} -j DROP"
	done
done
