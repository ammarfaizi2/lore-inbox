Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQKOAR3>; Tue, 14 Nov 2000 19:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129188AbQKOART>; Tue, 14 Nov 2000 19:17:19 -0500
Received: from [212.172.23.17] ([212.172.23.17]:20228 "EHLO mail.plan9.de")
	by vger.kernel.org with ESMTP id <S129047AbQKOARD>;
	Tue, 14 Nov 2000 19:17:03 -0500
Date: Wed, 15 Nov 2000 00:20:12 +0100
From: Marc Lehmann <pcg@goof.com>
To: linux-kernel@vger.kernel.org
Subject: routing problems with 2.2
Message-ID: <20001115002012.A8695@cerebro.laendle>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux version 2.2.17 (root@cerebro) (gcc version pgcc-2.95.2 19991024 (release)) 
X-Copyright: copyright 2000 Marc Alexander Lehmann - all rights reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Problem:

the command "telnet 212.172.23.17 80", done from a machine outside my
network generates syn requests on the device tun2 on my machine (a tunnel
device using vtun). tcpdump tun2:

00:04:55.066516 12.4.218.41.4624 > 212.172.23.17.80: S 219810852:219810852(0) win 16384 <mss 1460,nop,wscale 0,nop,nop,timestamp[|tcp]> (DF) [tos 0x10]
00:04:55.119757 129.13.162.254 > 212.172.23.17: icmp: host 12.4.218.41 unreachable - admin prohibited filter

(the second packet is due to the misrouting of the return packet on the
interface tun1, which hits some firewall):

00:04:55.066779 212.172.23.17.80 > 12.4.218.41.4624: S 437426418:437426418(0) ack 219810853 win 15510 <mss 1410,nop,nop,timestamp 7186830[|tcp]> (DF)
00:04:58.100986 212.172.23.17.80 > 12.4.218.41.4624: S 437426418:437426418(0) ack 219810853 win 15510 <mss 1410,nop,nop,timestamp 7187134[|tcp]> (DF)

The problem is that everything works fine at first, but after some time
after starting the network tunnels (between 5 minutes and a few days!)
packets received on one interface get sound on another one, generally the
wrong one.

ifconfig down/up of the device usually works (it happens between tun1/tun2,
tun2/ippp0 and even ippp0 and eth1, for example).

Does anybody have an idea what's going wrong here, and how to fix
this? Thanks a lot in advance, I'd be happy to provide more info.

My config:

linux-2.2.17 with most advanced router functions enabled (I can send my
.config if neccessary).

doom:~# ip rule list
0:      from all lookup local 
32766:  from all lookup main 
32767:  from all lookup default 

doom:~# ip route list table local
local 10.0.0.5 dev eth0  proto kernel  scope host  src 10.0.0.5 
local 10.0.0.5 dev eth1  proto kernel  scope host  src 10.0.0.5 
broadcast 127.255.255.255 dev lo  proto kernel  scope link  src 127.0.0.1 
broadcast 193.0.0.0 dev ippp0  proto kernel  scope link  src 62.224.169.116 
local 62.224.169.116 dev ippp0  proto kernel  scope host  src 62.224.169.116 
broadcast 10.255.255.255 dev eth0  proto kernel  scope link  src 10.0.0.5 
broadcast 10.255.255.255 dev eth1  proto kernel  scope link  src 10.0.0.5 
broadcast 193.255.255.255 dev ippp0  proto kernel  scope link  src 62.224.169.116 
broadcast 127.0.0.0 dev lo  proto kernel  scope link  src 127.0.0.1 
local 127.0.0.1 dev lo  proto kernel  scope host  src 127.0.0.1 
local 129.13.162.92 dev tun1  proto kernel  scope host  src 129.13.162.92 
local 127.0.0.0/8 dev lo  proto kernel  scope host  src 127.0.0.1 

doom:~# ip route list table main 
192.168.255.202 dev tun1  proto kernel  scope link  src 129.13.162.92 
10.0.0.1 dev eth0  scope link 
212.172.23.18 via 10.0.0.1 dev eth0 
192.168.254.1 dev tun2  proto kernel  scope link  src 212.172.23.17 
10.0.0.2 dev eth1  scope link 
129.13.162.8 dev ippp0  scope link 
10.0.0.9 dev eth1  scope link 
129.13.162.93 via 10.0.0.1 dev eth0 
172.16.0.0/12 dev tun1  scope link 
193.0.0.0/8 dev ippp0  proto kernel  scope link  src 62.224.169.116 
default dev ippp0  scope link 
default via 193.158.133.205 dev ippp0 

doom:~# ip route list table default
[empty]

doom:~# ip link list
1: lo: <LOOPBACK,UP> mtu 3924 qdisc noqueue 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: ippp0: <POINTOPOINT,NOARP,UP> mtu 1500 qdisc pfifo_fast qlen 30
    link/ppp 
3: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:e0:7d:03:38:73 brd ff:ff:ff:ff:ff:ff
4: eth1: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:e0:7d:03:38:68 brd ff:ff:ff:ff:ff:ff
29: tun1: <POINTOPOINT,MULTICAST,NOARP,UP> mtu 1450 qdisc pfifo_fast qlen 10
    link/ppp 
30: tun2: <POINTOPOINT,MULTICAST,NOARP,UP> mtu 1450 qdisc pfifo_fast qlen 10
    link/ppp 

doom:~# ip address list
1: lo: <LOOPBACK,UP> mtu 3924 qdisc noqueue 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
2: ippp0: <POINTOPOINT,NOARP,UP> mtu 1500 qdisc pfifo_fast qlen 30
    link/ppp 
    inet 62.224.169.116 peer 193.158.133.205/8 scope global ippp0
3: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:e0:7d:03:38:73 brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.5/32 brd 10.255.255.255 scope global eth0
4: eth1: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:e0:7d:03:38:68 brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.5/32 brd 10.255.255.255 scope global eth1
29: tun1: <POINTOPOINT,MULTICAST,NOARP,UP> mtu 1450 qdisc pfifo_fast qlen 10
    link/ppp 
    inet 129.13.162.92 peer 192.168.255.202/32 scope global tun1
30: tun2: <POINTOPOINT,MULTICAST,NOARP,UP> mtu 1450 qdisc pfifo_fast qlen 10
    link/ppp 
    inet 212.172.23.17 peer 192.168.254.1/32 scope global tun2
    inet 212.172.23.21/32 scope global tun2




-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@opengroup.org |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
