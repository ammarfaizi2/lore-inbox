Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbVA0JDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbVA0JDX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 04:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVA0JDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 04:03:23 -0500
Received: from acomp.externet.hu ([212.40.96.68]:15032 "HELO www.acomp.hu")
	by vger.kernel.org with SMTP id S262533AbVA0JDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 04:03:08 -0500
Date: Thu, 27 Jan 2005 10:02:58 +0100
From: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>
To: David Brownell <david-b@pacbell.net>
Cc: David Ford <david+challenge-response@blue-labs.org>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: 2.6.11-rc2 TCP ignores PMTU ICMP (Re: Linux 2.6.11-rc2)
Message-ID: <priv$1106815487.koan@shadow.banki.hu>
Mail-Followup-To: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
	David Brownell <david-b@pacbell.net>,
	David Ford <david+challenge-response@blue-labs.org>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <200501232251.42394.david-b@pacbell.net> <41F6916F.7060000@blue-labs.org> <200501251054.37053.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501251054.37053.david-b@pacbell.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-01-25 at 10:54:36, David Brownell wrote:
> On Tuesday 25 January 2005 10:35 am, David Ford wrote:
> > PMTU bug -- or better said, bad firewall admin who blocks all ICMP.
> 
> PMTU bug, sure -- but one that came late in RC2.  Remember:  same firewall
> in both cases, but only RC2 breaks.  The ICMP packet has landed in
> the RC2 system, which ignores it.  2.6.10 handled it correctly... I
> suspect one of the TCP cleanups borked this.
> 
> My current workaround is "ifconfig eth0 mtu 1492" but that's not
> something I'd expect to keep.

Indeed, I had to shuffle my machines around a bit to get a proof that
something is broken, but now I can confirm the above with a connection
to cvs.sourceforge.net:

192.168.59.10 is the 2.6.11-rc2 host, 192.168.59.1 is the (now pre-rc2)
gateway with a PPPoE 1492 mtu/pmtu host.  59.10 does not run any
firewall/packet filter.

(almost full-fledged perfect three-way handshake)

08:05:43.046546 IP (tos 0x0, ttl  64, id 21526, offset 0, flags [DF], length: 60) 192.168.59.10.29612 > 66.35.250.207.2401: SWE [tcp sum ok] 933042757:933042757(0) win 5840 <mss 1460,sackOK,timestamp 2707027 0,nop,wscale 2>
08:05:43.249819 IP (tos 0x0, ttl  45, id 0, offset 0, flags [DF], length: 60) 66.35.250.207.2401 > 192.168.59.10.29612: S [tcp sum ok] 2956308271:2956308271(0) ack 933042758 win 5792 <mss 1460,sackOK,timestamp 312382981 2707027,nop,wscale 0>
08:05:43.249881 IP (tos 0x0, ttl  64, id 21528, offset 0, flags [DF], length: 52) 192.168.59.10.29612 > 66.35.250.207.2401: . [tcp sum ok] ack 1 win 1460 <nop,nop,timestamp 2707230 312382981>

(CVS protocol starts)

08:05:43.363697 IP (tos 0x0, ttl  64, id 21530, offset 0, flags [DF], length: 116) 192.168.59.10.29612 > 66.35.250.207.2401: P [tcp sum ok] 1:65(64) ack 1 win 1460 <nop,nop,timestamp 2707344 312382981>
08:05:43.568504 IP (tos 0x0, ttl  45, id 14633, offset 0, flags [DF], length: 52) 66.35.250.207.2401 > 192.168.59.10.29612: . [tcp sum ok] ack 65 win 5792 <nop,nop,timestamp 312383013 2707344>
08:05:43.964094 IP (tos 0x0, ttl  45, id 14634, offset 0, flags [DF], length: 63) 66.35.250.207.2401 > 192.168.59.10.29612: P [tcp sum ok] 1:12(11) ack 65 win 5792 <nop,nop,timestamp 312383053 2707344>
08:05:43.964121 IP (tos 0x0, ttl  64, id 21532, offset 0, flags [DF], length: 52) 192.168.59.10.29612 > 66.35.250.207.2401: . [tcp sum ok] ack 12 win 1460 <nop,nop,timestamp 2707945 312383053>
08:05:43.964258 IP (tos 0x0, ttl  64, id 21534, offset 0, flags [DF], length: 440) 192.168.59.10.29612 > 66.35.250.207.2401: P [tcp sum ok] 65:453(388) ack 12 win 1460 <nop,nop,timestamp 2707945 312383053>
08:05:44.184893 IP (tos 0x0, ttl  45, id 14635, offset 0, flags [DF], length: 52) 66.35.250.207.2401 > 192.168.59.10.29612: . [tcp sum ok] ack 453 win 6432 <nop,nop,timestamp 312383075 2707945>
08:05:44.192050 IP (tos 0x0, ttl  45, id 14636, offset 0, flags [DF], length: 566) 66.35.250.207.2401 > 192.168.59.10.29612: P [tcp sum ok] 12:526(514) ack 453 win 6432 <nop,nop,timestamp 312383075 2707945>
08:05:44.192274 IP (tos 0x0, ttl  64, id 21536, offset 0, flags [DF], length: 65) 192.168.59.10.29612 > 66.35.250.207.2401: P [tcp sum ok] 453:466(13) ack 526 win 1728 <nop,nop,timestamp 2708174 312383075>
08:05:44.432709 IP (tos 0x0, ttl  45, id 14637, offset 0, flags [DF], length: 52) 66.35.250.207.2401 > 192.168.59.10.29612: . [tcp sum ok] ack 466 win 6432 <nop,nop,timestamp 312383100 2708174>
08:05:44.893674 IP (tos 0x0, ttl  64, id 21538, offset 0, flags [DF], length: 85) 192.168.59.10.29612 > 66.35.250.207.2401: P [tcp sum ok] 466:499(33) ack 526 win 1728 <nop,nop,timestamp 2708876 312383100>
08:05:45.094985 IP (tos 0x0, ttl  45, id 14638, offset 0, flags [DF], length: 52) 66.35.250.207.2401 > 192.168.59.10.29612: . [tcp sum ok] ack 499 win 6432 <nop,nop,timestamp 312383166 2708876>

(first ethernet frame-sized segment is about to be sent)

08:05:45.264633 IP (tos 0x0, ttl  64, id 21540, offset 0, flags [DF], length: 1500) 192.168.59.10.29612 > 66.35.250.207.2401: . [tcp sum ok] 499:1947(1448) ack 526 win 1728 <nop,nop,timestamp 2709247 312383166>
08:05:45.264694 IP (tos 0x0, ttl  64, id 21542, offset 0, flags [DF], length: 1500) 192.168.59.10.29612 > 66.35.250.207.2401: . [tcp sum ok] 1947:3395(1448) ack 526 win 1728 <nop,nop,timestamp 2709247 312383166>

(the PPPoE gateway notifies the host about the PMTU issue, one for each
segment)

08:05:45.265330 IP (tos 0xc0, ttl 128, id 17970, offset 0, flags [none], length: 576) 192.168.59.1 > 192.168.59.10: icmp 556: 66.35.250.207 unreachable - need to frag (mtu 1492)
08:05:45.265453 IP (tos 0xc0, ttl 128, id 17971, offset 0, flags [none], length: 576) 192.168.59.1 > 192.168.59.10: icmp 556: 66.35.250.207 unreachable - need to frag (mtu 1492)

(the source host sends the full frame again...?)

08:05:45.770331 IP (tos 0x0, ttl  64, id 21544, offset 0, flags [DF], length: 1500) 192.168.59.10.29612 > 66.35.250.207.2401: . [tcp sum ok] 499:1947(1448) ack 526 win 1728 <nop,nop,timestamp 2709754 312383166>
08:05:45.770900 IP (tos 0xc0, ttl 128, id 17972, offset 0, flags [none], length: 576) 192.168.59.1 > 192.168.59.10: icmp 556: 66.35.250.207 unreachable - need to frag (mtu 1492)

(and looping goes on..)

08:05:46.783148 IP (tos 0x0, ttl  64, id 21546, offset 0, flags [DF], length: 1500) 192.168.59.10.29612 > 66.35.250.207.2401: . [tcp sum ok] 499:1947(1448) ack 526 win 1728 <nop,nop,timestamp 2710768 312383166>
08:05:46.783752 IP (tos 0xc0, ttl 128, id 17973, offset 0, flags [none], length: 576) 192.168.59.1 > 192.168.59.10: icmp 556: 66.35.250.207 unreachable - need to frag (mtu 1492)
08:05:48.808861 IP (tos 0x0, ttl  64, id 21548, offset 0, flags [DF], length: 1500) 192.168.59.10.29612 > 66.35.250.207.2401: . [tcp sum ok] 499:1947(1448) ack 526 win 1728 <nop,nop,timestamp 2712796 312383166>
08:05:48.809882 IP (tos 0xc0, ttl 128, id 17974, offset 0, flags [none], length: 576) 192.168.59.1 > 192.168.59.10: icmp 556: 66.35.250.207 unreachable - need to frag (mtu 1492)

...

I don't have now a pre-rc2 host to try this on, but I regularly use
sourceforge anoncvs to at least confess honestly that it did work :)

-- 
Janos | romfs is at http://romfs.sourceforge.net/ | Don't talk about silence.
