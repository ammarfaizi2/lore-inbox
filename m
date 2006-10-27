Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946105AbWJ0Bxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946105AbWJ0Bxx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 21:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946094AbWJ0Bxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 21:53:53 -0400
Received: from [84.77.121.105] ([84.77.121.105]:8651 "EHLO
	merak.nimastelecom.com") by vger.kernel.org with ESMTP
	id S1946096AbWJ0Bxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 21:53:52 -0400
Message-ID: <454166A6.1090905@newipnet.com>
Date: Fri, 27 Oct 2006 03:53:42 +0200
From: Carlos Velasco <lkml@newipnet.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Networking messed up, bad checksum, incorrect length
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Before all, sorry for the long mail, but I have stepped into an
intricate problem.

I'm using kernel 2.6.18.1 over Intel EMT64.
Linux Merak 2.6.18.1 #1 SMP Thu Oct 26 16:19:26 CEST 2006 x86_64 x86_64
x86_64 GNU/Linux

I have a really bad behavior in networking. I would appreciate anyone
that can help.

So first of all, I will begin the story from the beginning.

I saw some email sending related problems and tracked down the problem
to Netfilter dropping some packets.

As you can see, all of them are ACK packets in reply to sent packets
related with an email in send process through SMTP:

Oct 26 18:58:04 kern:warning FIREWALL:INPUT IN=eth0 OUT=
MAC=00:13:21:cc:54:a6:00:0d:bc:a0:e2:82:08:00 SRC=193.147.150.12
DST=192.168.128.182 LEN=64 TOS=0x00 PREC=0x00 TTL=54 ID=31520 DF
PROTO=TCP SPT=25 DPT=60596 WINDOW=32448 RES=0x00 ACK URGP=0

Oct 26 18:58:04 kern:warning FIREWALL:INPUT IN=eth0 OUT=
MAC=00:13:21:cc:54:a6:00:0d:bc:a0:e2:82:08:00 SRC=193.147.150.12
DST=192.168.128.182 LEN=64 TOS=0x00 PREC=0x00 TTL=54 ID=31521 DF
PROTO=TCP SPT=25 DPT=60596 WINDOW=32448 RES=0x00 ACK URGP=0


For tracking down the problem, I opened the firewall and all worked fine.

So, I went to track the real problem, and the first thing was to take
sniffer traces, and here's the surprise.

Packets going to destination SMTP server
========================================
# tcpdump -n -e dst flash.cnio.es
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 96 bytes
03:12:15.878929 00:13:21:cc:54:a6 > 00:0d:bc:a0:e2:82, ethertype IPv4
(0x0800), length 74: 192.168.128.182.59061 > 193.147.150.12.25: S
508337957:508337957(0) win 5040 <mss 1260,sackOK,timestamp 9642740
0,nop,wscale 7>
03:12:15.927479 00:13:21:cc:54:a6 > 00:0d:bc:a0:e2:82, ethertype IPv4
(0x0800), length 66: 192.168.128.182.59061 > 193.147.150.12.25: . ack
1032773455 win 40 <nop,nop,timestamp 9642752 425655092>
03:12:16.000764 00:13:21:cc:54:a6 > 00:0d:bc:a0:e2:82, ethertype IPv4
(0x0800), length 66: 192.168.128.182.59061 > 193.147.150.12.25: . ack 39
win 40 <nop,nop,timestamp 9642771 425655100>
03:12:16.000811 00:13:21:cc:54:a6 > 00:0d:bc:a0:e2:82, ethertype IPv4
(0x0800), length 95: 192.168.128.182.59061 > 193.147.150.12.25: P
0:29(29) ack 39 win 40 <nop,nop,timestamp 9642771 425655100>
03:12:16.046904 00:13:21:cc:54:a6 > 00:0d:bc:a0:e2:82, ethertype IPv4
(0x0800), length 183: 192.168.128.182.59061 > 193.147.150.12.25: P
29:146(117) ack 163 win 40 <nop,nop,timestamp 9642782 425655104>
03:12:21.500477 00:13:21:cc:54:a6 > 00:0d:bc:a0:e2:82, ethertype IPv4
(0x0800), length 2562: 192.168.128.182.59061 > 193.147.150.12.25: .
146:2642(2496) ack 228 win 40 <nop,nop,timestamp 9644145 425655650>

LENGTH:2562 !!

But it get worse later and later...

03:12:22.185669 00:13:21:cc:54:a6 > 00:0d:bc:a0:e2:82, ethertype IPv4
(0x0800), length 10050: 192.168.128.182.59061 > 193.147.150.12.25: .
52562:62546(9984) ack 228 win 40 <nop,nop,timestamp 9644317 425655718>

LENGTH: 10050 !!

03:12:22.345090 00:13:21:cc:54:a6 > 00:0d:bc:a0:e2:82, ethertype IPv4
(0x0800), length 6306: 192.168.128.182.59061 > 193.147.150.12.25: .
62546:68786(6240) ack 228 win 40 <nop,nop,timestamp 9644357 425655734>

LENGTH: 6306 !!

03:12:22.484863 00:13:21:cc:54:a6 > 00:0d:bc:a0:e2:82, ethertype IPv4
(0x0800), length 12546: 192.168.128.182.59061 > 193.147.150.12.25: .
68786:81266(12480) ack 228 win 40 <nop,nop,timestamp 9644391 425655748>

LENGTH: 12546 !!

How can be this? The MTU is set to 1300 in the interface:

# ip link show
1: lo: <LOOPBACK,UP,10000> mtu 1300 qdisc noqueue
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,10000> mtu 1300 qdisc pfifo_fast qlen 1000
    link/ether 00:13:21:cc:54:a6 brd ff:ff:ff:ff:ff:ff
3: sit0: <NOARP> mtu 1480 qdisc noop
    link/sit 0.0.0.0 brd 0.0.0.0


And also in the default route:

# ip route show
192.168.128.0/24 dev eth0  proto kernel  scope link  src 192.168.128.182
default via 192.168.128.200 dev eth0  mtu 1300


But still worse, I wrote the full sniffer traces to a file for further
analysis with Ethereal, and there I see that not only these long packets
are above MTU, all they have bad TCP checksums.

But why these packets are traversing the network when I open the
firewall? With that length it's impossible to go through Internet
without being dropped. This can't be real.

So I used port mirroring in the switch attached to this server and took
sniffer traces of the ethernet port to see if tcpdump/libpcap are messed
up or something.... well, the REAL packets are all up to 1300 bytes
length (IP), so this means that sniffer traces taken in the server are
NOT the real packets that go through the network interface.

===
Analysis:
My thinking is that libpcap is taking the packets before being
fragmented in kernel to meet the MTU limits and the same goes for
Netfilter, if netfilter doesn't see the ACKs as RELATED to the packets
sent, they get dropped and that is exactly that I see.
===

Some more info about versions and configurations:

tcpdump version 3.9.5
libpcap version 0.9.5

eth0: Tigon3 [partno(BCM95721) rev 4101 PHY(5750)] (PCI Express)
10/100/1000BaseT Ethernet 00:13:21:cc:54:a6
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1]
TSOcap[1]
eth0: dma_rwctrl[76180000] dma_mask[64-bit]

# ethtool eth0
Settings for eth0:
        Supported ports: [ MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  Not reported
        Advertised auto-negotiation: No
        Speed: 100Mb/s
        Duplex: Full
        Port: Twisted Pair
        PHYAD: 1
        Transceiver: internal
        Auto-negotiation: off
        Supports Wake-on: g
        Wake-on: d
        Current message level: 0x000000ff (255)
        Link detected: yes

# sysctl -a | grep -i mtu
net.ipv6.conf.default.mtu = 1280
net.ipv6.conf.all.mtu = 1280
net.ipv6.conf.eth0.mtu = 1300
net.ipv6.conf.lo.mtu = 1300
error: "Operation not permitted" reading key "net.ipv6.route.flush"
net.ipv6.route.mtu_expires = 600
error: "Operation not permitted" reading key "net.ipv4.route.flush"
net.ipv4.tcp_mtu_probing = 0
net.ipv4.route.min_pmtu = 552
net.ipv4.route.mtu_expires = 600
net.ipv4.ip_no_pmtu_disc = 0


I have uploaded sniffer traces taken to the following urls.

Sniffer traces taken on the server
(tcpdump -s 0 -w smtptrace.merak.pcap host flash.cnio.es):
http://www.nimastelecom.com/smtptraces/smtptrace.merak.pcap

Sniffer traces taken through port mirroring in the switch
(ethereal with filter: host flash.cnio.es):
http://www.nimastelecom.com/smtptraces/smtptrace_portmirror.pcap


Any help will be really apreciated into this problem.

Regards,
Carlos Velasco
CCNP & CCDP Cisco Certified Network Professional.
