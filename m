Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVIUALg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVIUALg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 20:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVIUALf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 20:11:35 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:48009 "HELO
	develer.com") by vger.kernel.org with SMTP id S1750801AbVIUALf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 20:11:35 -0400
Message-ID: <4330A51D.20009@develer.com>
Date: Wed, 21 Sep 2005 02:11:09 +0200
From: Bernardo Innocenti <bernie@develer.com>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
CC: lkml <linux-kernel@vger.kernel.org>, netfilter-devel@lists.netfilter.org
Subject: Re: Intermittent NAT failure when multiple hosts send UDP packets
References: <432B8702.3060801@develer.com> <432CD386.201@develer.com> <43306484.2060103@develer.com> <43307BDC.8060602@trash.net>
In-Reply-To: <43307BDC.8060602@trash.net>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=FC6A66CA;
	url=https://www.develer.com/~bernie/gpgkey.txt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy wrote:
> Bernardo Innocenti wrote:
> 
>>I'm sorry to say that this bug has shown up again on
>>2.6.13 too, so it's not fixed at all.
>>
>>It's quite hard to trigger, but after it does, packets
>>are consistently routed with the source IP untranslated.
> 
> 
> Please try "echo 255 >
> /proc/sys/net/ipv4/netfilter/ip_conntrack_log_invalid"
> and modprobe ipt_LOG to see if conntrack ignores them because
> of invalid checksums or something.

It doesn't seem to be the case.  I only see a few occasional
errors, probably caused by miserable hosts crawling with worms:

 ip_ct_tcp: invalid packet ignored IN= OUT= SRC=83.40.242.177 DST=151.38.19.110 LEN=48 TOS=0x18 PREC=0x20 TTL=114 ID=42553 DF PROTO=TCP SPT=3017 DPT=4662 SEQ=3667342556 ACK=0 WINDOW=65535 RES=0x00 SYN URGP=0 OPT (0204055001010402)
device eth1 left promiscuous mode
 ip_ct_tcp: SEQ is under the lower bound (already ACKed data retransmitted) IN= OUT= SRC=62.241.4.1 DST=151.38.19.110 LEN=40 TOS=0x18 PREC=0x20 TTL=39 ID=62928 PROTO=TCP SPT=995 DPT=41567 SEQ=0 ACK=1313396353 WINDOW=0 RES=0x00 ACK RST URGP=0
 ip_ct_icmp: bad ICMP checksum IN= OUT= SRC=68.192.221.135 DST=151.38.19.110 LEN=81 TOS=0x18 PREC=0x20 TTL=49 ID=30671 PROTO=ICMP TYPE=3 CODE=1 [SRC=151.38.19.110 DST=68.192.221.135 LEN=53 TOS=0x00 PREC=0x00 TTL=52 ID=32600 DF PROTO=UDP SPT=13049 DPT=12464 LEN=33 ]
 ip_ct_tcp: invalid state IN= OUT= SRC=168.226.95.26 DST=151.38.19.110 LEN=52 TOS=0x18 PREC=0x20 TTL=106 ID=26190 DF PROTO=TCP SPT=4662 DPT=40358 SEQ=2466472710 ACK=1425847173 WINDOW=65535 RES=0x00 ACK URGP=0 OPT (0101080A00048B3304B5C54C)
 ip_ct_tcp: invalid packet ignored IN= OUT= SRC=82.224.25.130 DST=151.38.19.110 LEN=48 TOS=0x18 PREC=0x20 TTL=116 ID=17411 DF PROTO=TCP SPT=3565 DPT=4662 SEQ=1051168262 ACK=0 WINDOW=16384 RES=0x00 SYN URGP=0 OPT (0204058401010402)



By the way, all the rest of my TCP and UDP traffic is still
being translated and routed correctly:

 # tcpdump -n -i ppp0 host sip.squillo.it -v -v -v
 01:52:38.020005 IP (tos 0x0, ttl  63, id 0, offset 0, flags [DF], proto 17, length: 454) 151.38.19.110.1024 > 194.185.88.60.5060: UDP, length 426
 01:52:38.096282 IP (tos 0x38, ttl  55, id 23343, offset 0, flags [DF], proto 17, length: 475) 194.185.88.60.5060 > 151.38.19.110.1024: UDP, length 447
 01:52:38.100324 IP (tos 0x38, ttl  55, id 23344, offset 0, flags [DF], proto 17, length: 560) 194.185.88.60.5060 > 151.38.19.110.1024: UDP, length 532
 01:52:38.110865 IP (tos 0x0, ttl  63, id 1, offset 0, flags [DF], proto 17, length: 597) 151.38.19.110.1024 > 194.185.88.60.5060: UDP, length 569
 01:52:38.216213 IP (tos 0x38, ttl  55, id 23353, offset 0, flags [DF], proto 17, length: 475) 194.185.88.60.5060 > 151.38.19.110.1024: UDP, length 447
 01:52:38.238967 IP (tos 0x38, ttl  55, id 23354, offset 0, flags [DF], proto 17, length: 553) 194.185.88.60.5060 > 151.38.19.110.1024: UDP, length 525


It's just this one connection that doesn't:

 # tcpdump -n -i ppp0 host sip.squillo.it -v -v -v
 01:44:04.936695 IP (tos 0x38, ttl  63, id 8416, offset 0, flags [DF], proto 17, length: 564) 10.3.3.2.5060 > 194.185.88.60.5060: UDP, length 536
 01:44:06.937433 IP (tos 0x38, ttl  63, id 8418, offset 0, flags [DF], proto 17, length: 564) 10.3.3.2.5060 > 194.185.88.60.5060: UDP, length 536
 01:44:10.936911 IP (tos 0x38, ttl  63, id 8420, offset 0, flags [DF], proto 17, length: 564) 10.3.3.2.5060 > 194.185.88.60.5060: UDP, length 536


If I stop transmitting packets until the conntrack timer expires,
then everything works again normally for a few hours.

If I read ip_nat_core.c correctly, manip_pkt() is responsible for
doing the IP address translation, while udp_manip_pkt() takes care
of the port in the UDP packet.  I'm staring at this code without a
clue how it could selectively skip one of the tuples.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

