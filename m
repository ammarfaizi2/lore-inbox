Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265862AbSKBCZt>; Fri, 1 Nov 2002 21:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbSKBCZt>; Fri, 1 Nov 2002 21:25:49 -0500
Received: from dyn-212-232-60-250.ppp.tiscali.fr ([212.232.60.250]:7442 "EHLO
	LAP") by vger.kernel.org with ESMTP id <S265862AbSKBCZr>;
	Fri, 1 Nov 2002 21:25:47 -0500
Message-ID: <02d101c28217$df39a1b0$0200000a@LAP>
From: "Vadim Lebedev" <vadim@7chips.com>
To: <linux-kernel@vger.kernel.org>
Subject: Network layer mysteries
Date: Sat, 2 Nov 2002 03:30:55 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 02 Nov 2002 02:30:56.0075 (UTC) FILETIME=[DF39A1B0:01C28217]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I need an advize of network subsytem gourus....

I'm running uClinux 2.4.19   on 24Mhz on ATMEL AT75C310 (ARM7TDMI)
processor (without cashes) with  16Bit DRAM attached
The BogoMIPS is 4.59.   HZ = 100


I have very strange phenomenons

1. The ping over "lo" driver is slower then ping over 8390.c based ethernet
interface.
2. The RTTs reported by ping are extremely high :

PING 127.0.0.1 (127.0.0.1): 56 data bytes
64 bytes from 127.0.0.1: icmp_seq=0 ttl=64 time=53.4(11.8) ms
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=50.4(6.1) ms
64 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=50.3(6.1) ms
64 bytes from 127.0.0.1: icmp_seq=3 ttl=64 time=50.4(6.2) ms
64 bytes from 127.0.0.1: icmp_seq=4 ttl=64 time=50.4(6.2) ms
64 bytes from 127.0.0.1: icmp_seq=5 ttl=64 time=50.3(6.1) ms
64 bytes from 127.0.0.1: icmp_seq=6 ttl=64 time=50.2(6.1) ms
64 bytes from 127.0.0.1: icmp_seq=7 ttl=64 time=50.2(6.1) ms

--- 127.0.0.1 ping statistics ---
8 packets transmitted, 8 packets received, 0% packet loss
round-trip min/avg/max = 50.2/50.7/53.4 ms
kround-trip min/avg/max = 6.1/6.8/11.8 ms

/> ping 192.168.0.10
PING 192.168.0.10 (192.168.0.10): 56 data bytes
64 bytes from 192.168.0.10: icmp_seq=0 ttl=255 time=30.5(13.4) ms
64 bytes from 192.168.0.10: icmp_seq=1 ttl=255 time=34.5(6.5) ms
64 bytes from 192.168.0.10: icmp_seq=2 ttl=255 time=34.4(6.5) ms
64 bytes from 192.168.0.10: icmp_seq=3 ttl=255 time=34.4(6.4) ms
64 bytes from 192.168.0.10: icmp_seq=4 ttl=255 time=34.3(6.5) ms
64 bytes from 192.168.0.10: icmp_seq=5 ttl=255 time=34.4(6.5) ms
64 bytes from 192.168.0.10: icmp_seq=6 ttl=255 time=34.3(6.5) ms
64 bytes from 192.168.0.10: icmp_seq=7 ttl=255 time=34.2(6.4) ms
64 bytes from 192.168.0.10: icmp_seq=8 ttl=255 time=34.3(6.5) ms

--- 192.168.0.10 ping statistics ---
9 packets transmitted, 9 packets received, 0% packet loss
round-trip min/avg/max = 30.5/33.9/34.5 ms
kround-trip min/avg/max = 6.4/7.2/13.4 ms



I've hacked ping utility to show between parenthesis the RTT calculated when
using the result
if SIOCGSTAMP ioctl  after reading the incoming packet in addition to normal
behaviour when it uses
gettimeofday syscall.

As you can see there is big delay between the times when packet arrives into
kernel input queue and
the time it is read by application.

What is strange that other uClinux users running on CPUs with similar
processing power does not report
such kind of delays.

Any idea about what happens here and what can be done about it?

Please CC me the responces
Thanks
Vadim
PS.  here are results of ifconfig and route -n
/> route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use
Iface
192.168.0.0     0.0.0.0         255.255.255.0   U     0      0        0 eth0
0.0.0.0         192.168.0.15    0.0.0.0         UG    0      0        0 eth0

/> ifconfig
eth0      Link encap:Ethernet  HWaddr 00:50:56:C3:DB:9F
          inet addr:192.168.0.191  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:13 errors:0 dropped:0 overruns:0 frame:0
          TX packets:13 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:1686 (1.6 kb)  TX bytes:2182 (2.1 kb)
          Interrupt:10 Base address:0x200

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:16 errors:0 dropped:0 overruns:0 frame:0
          TX packets:16 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:1344 (1.3 kb)  TX bytes:1344 (1.3 kb)





