Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131147AbRBRHFz>; Sun, 18 Feb 2001 02:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130282AbRBRHFq>; Sun, 18 Feb 2001 02:05:46 -0500
Received: from [139.134.6.96] ([139.134.6.96]:31440 "EHLO mailin8.bigpond.com")
	by vger.kernel.org with ESMTP id <S131147AbRBRHFf>;
	Sun, 18 Feb 2001 02:05:35 -0500
Message-ID: <3A8F6B30.ECC12B36@zip.com.au>
Date: Sun, 18 Feb 2001 17:26:56 +1100
From: Darren Tucker <dtucker@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: jbinpg@home.com
CC: stefan@hanse.com, linux-kernel@vger.kernel.org
Subject: Re: re. too long mac address for --mac-source netfilter option
In-Reply-To: <20010217194308.GKTJ585.mail2.rdc2.bc.home.com@nonesuch.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbinpg@home.com wrote:
> Jack  Bowling wrote - 
> >> iptables v1.1.1: Bad mac address `xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx'
> >>
> >> to the respective iptable line:
> >>
> >> $IPT -A INPUT -p tcp -s xxx.xxx.xxx.xxx -d $NET -m mac --mac-source xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx --dport 5900:5901 -j ACCEPT
> >>
> >> The idea here is to allow VNC access to my home box with the access filtered by both IP and mac address.> 
> Stefan Hanse writes -
> 
> >Umm..  An ethernet MAC address is 48bit long, ie AA:BB:CC:DD:EE:FF, 6 groups, not 14. Is this really an ethernet
> >interface? (If it really has 14 groups).
 
> All hits on my firewall from cable modem servers other than my own provider also have the 14 group "MAC" address so it looks like this may be a feature of these units.

It looks like it's the entire MAC-level header that is logged:
destination, source and protocol type.

I did a quick test with the PPPoE link down and the upstream cable
unplugged. I telnetted into the modem and generated a single UDP packet
to the echo port on the linux box (using the command "ip sendto
addr=10.0.0.1 count=1 size=10 dstport=7").

The kernel logged:
IN=eth1 OUT= MAC=08:00:2b:e2:a6:a3:00:90:d0:1b:4d:1c:08:00
SRC=10.0.0.138 DST=10.0.0.1 LEN=38 TOS=0x00 PREC=0x00 TTL=64 ID=2693
PROTO=UDP SPT=1032 DPT=7 LEN=18

The tcpdump output from this exchange:
[root@gate dtucker]# tcpdump -i eth1 -vv -x -e -p ! port telnet
Kernel filter, protocol ALL, datagram packet socket
tcpdump: listening on eth1
13:07:04.105231 < 0:90:d0:1b:4d:1c 0:0:0:0:0:1 ip 60: 10.0.0.138.1041 >
10.0.0.1.echo: udp 10 (ttl 64, id 3335)
                         4500 0026 0d07 0000 4011 5936 0a00 008a
                         0a00 0001 0411 0007 0012 8cc8 4142 4344
                         4546 4748 494a 0000 0000 0000 0000
13:07:04.105900 > 0:0:0:0:0:0 8:0:2b:e2:a6:a3 ip 80: 10.0.0.1 >
10.0.0.138: icmp: 10.0.0.1 udp port echo unreachable Offending pkt:
10.0.0.138.1041 > 10.0.0.1.echo: udp 10 (ttl 64, id 3335) (DF) [tos
0xc0]  (ttl 255, id 0)
                         45c0 0042 0000 4000 ff01 6670 0a00 0001
                         0a00 008a 0303 11ab 0000 0000 4500 0026
                         0d07 0000 4011 5936 0a00 008a 0a00 0001
                         0411 0007 0012 8cc8 4142 4344 4546 4748
                         494a

Environment:
Kernel 2.4.2-pre3 running on an AMD K6-3.
eth1 is a DE435 using the de4x5 driver. MAC address 08:00:2B:E2:A6:A3
Alcatel "Speed Touch Home" ADSL modem connected to eth1. MAC address
00:90:D0:1B:4D:1C
The (relevant parts of the) iptables:
iptables -N droplog
iptables -A droplog -j LOG
iptables -A droplog -j REJECT
iptables -A INPUT -i eth1 -m state --state NEW,INVALID -j droplog
iptables -A FORWARD -i eth1 -m state --state NEW,INVALID -j droplog

Further comments:
1) I know that some of the the MAC addresses given by tcpdump are
invalid. Is this a bug? In what?
2) I've also repeated this test with the tulip driver, with the same
results.

		-Daz.
