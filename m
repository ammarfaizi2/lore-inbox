Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTLBQ5M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 11:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTLBQ5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 11:57:12 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:14473 "EHLO
	catnet.kabel.utwente.nl") by vger.kernel.org with ESMTP
	id S262188AbTLBQ5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 11:57:01 -0500
Date: Tue, 2 Dec 2003 17:56:53 +0100
From: Wilmer van der Gaast <lintux@lintux.cx>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23 masquerading broken?
Message-ID: <20031202165653.GJ615@gaast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pMCBjikF2xGw87uL"
Content-Disposition: inline
X-Operating-System: Linux 2.4.23 on a i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pMCBjikF2xGw87uL
Content-Type: multipart/mixed; boundary="PWfwoUCx3AFJRUBq"
Content-Disposition: inline


--PWfwoUCx3AFJRUBq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

For security reasons, I upgraded to 2.4.23 last night. Now, suddenly, IP
masquerading seems to be broken. When I use SNAT instead of
masquerading, everything works.

Unfortunately, I think it's hard to reproduce the problem. Right after
booting .23 for the first time, everything seemed to be okay. The
problems started just an hour ago, after having the server running for
fifteen hours without any problems.

Unfortunately there's not much more information I can provide. I can
attach my iptables/rule/route file and keep my machine running in case
anyone needs/wants more information. For now I'll just stick with SNAT.
It works good enough for me.

Just FYI, and maybe someone else will have a similar problem.

Wilmer v/d Gaast. (not on the list)

--=20
+-------- .''`.     - -- ---+  +        - -- --- ---- ----- ------+
| lintux : :'  :  lintux.cx |  | OSS Programmer   www.bitlbee.org |
|   at   `. `~'  debian.org |  | www.algoritme.nl   www.lintux.cx |
+--- -- -  ` ---------------+  +------ ----- ---- --- -- -        +

--PWfwoUCx3AFJRUBq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename=S19router

#!/bin/sh

if [ "$1" != "start" ]; then
	exit;
fi

if ! ifconfig hensema > /dev/null 2> /dev/null; then sleep 1; fi

catnet="130.89.203.37"
utwente="utwente"
hensema="hensema"

echo -n 'Setting up routes and iptables... '

## Without this Linux will reject packets from outside the network
echo 0 > /proc/sys/net/ipv4/conf/eth1/rp_filter

iptables -F
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -t nat -F

iptables -A INPUT -i wlan0 -p tcp --dport ssh -j ACCEPT
iptables -A INPUT -i wlan0 -p tcp --dport tinc -j ACCEPT
iptables -A INPUT -i wlan0 -p udp --dport tinc -j ACCEPT
iptables -A INPUT -i wlan0 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i wlan0 -p icmp -j ACCEPT
iptables -A INPUT -i wlan0 -j REJECT

iptables -A INPUT -i eth1 -p tcp --dport ssh -j ACCEPT
iptables -A INPUT -i eth1 -p tcp --dport smtp -j ACCEPT
iptables -A INPUT -i eth1 -p tcp --dport domain -j ACCEPT
iptables -A INPUT -i eth1 -p udp --dport domain -j ACCEPT
iptables -A INPUT -i eth1 -p tcp --dport www -j ACCEPT
iptables -A INPUT -i eth1 -p tcp --dport imap2 -j ACCEPT
iptables -A INPUT -i eth1 -p tcp --dport imap3 -j ACCEPT
iptables -A INPUT -i eth1 -p tcp --dport imaps -j ACCEPT
iptables -A INPUT -i eth1 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i eth1 -p icmp -j ACCEPT
iptables -A INPUT -i eth1 -j REJECT

iptables -A FORWARD -i wlan0 -j REJECT --reject-with icmp-host-unreachable
#iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
iptables -t nat -A POSTROUTING -o eth1 -j SNAT --to-source $catnet

ip route flush table utwente
ip route flush table hensema

## This is a quick hack to flush the rule table. It's not yet perfect.
ip rule list | \
cut -d '	' -f2 | \
sed s/all/0\\/0/g | \
while read LINE; do
	ip rule del $LINE;
done

ip rule add prio 10 to 192.168.0.0/16 table main
ip rule add prio 12 iif hensema table $utwente ## For the ssh->hensema portfw
ip rule add prio 15 from $catnet table $utwente
ip rule add prio 15 from 192.168.7.2 table $hensema
ip rule add prio 20 to 130.89.0.0/16 table $utwente
ip rule add prio 20 to 212.120.64.0/18 table $hensema
ip rule add prio 40 from 192.168.9.11 table $hensema
ip rule add prio 40 from 192.168.9.13 table $hensema
#ip rule add prio 40 from 192.168.9.14 table $hensema
#ip rule add prio 40 from 192.168.9.17 table $hensema
ip rule add prio 55 from 192.168.9.0/24 table $utwente
ip rule add prio 60 table main

ip route flush cache

ip route add table hensema 192.168.7.0/24 dev hensema
ip route add table hensema default via 192.168.7.1 dev hensema
ip route add table utwente 130.89.192.0/20 dev eth1
ip route add table utwente default via 130.89.192.1 dev eth1

ip route add 192.168.1.0/24 via 192.168.7.1 dev hensema

## Add default routes as fallbacks. The second route seems to be
## necessary to be able to bind() to eth1 and have things work.
while ip route del default; do :; done
ip route add table main default via 192.168.7.1 dev hensema metric 0
ip route add table main default via 130.89.192.1 dev eth1 metric 1

ip route flush cache

## Port forward stuff
iptables -t nat -A PREROUTING -p tcp -d $catnet --dport 2222 -j DNAT --to 192.168.1.1:22
iptables -t nat -A PREROUTING -p tcp -d $catnet --dport 2121 -j DNAT --to 192.168.9.15:21
#iptables -t nat -A PREROUTING -p tcp -d $catnet --dport  222 -j DNAT --to 192.168.9.14:22
#iptables -t nat -s \! 192.168.9.0/24 -A POSTROUTING -o hensema -j MASQUERADE
iptables -t nat -s \! 192.168.9.0/24 -A POSTROUTING -o hensema -j SNAT --to-source 192.168.7.2

echo 'OK'

--PWfwoUCx3AFJRUBq--

--pMCBjikF2xGw87uL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE/zMRVeYWXmuMwQFERAsiDAJ95UJoXiRFnGZCh4gbL03PPSgPHJgCfftuU
BpaNQUOnw50DHCx57MYhv1Q=
=Ggj/
-----END PGP SIGNATURE-----

--pMCBjikF2xGw87uL--
