Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265682AbUGGX2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265682AbUGGX2K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 19:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbUGGX2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 19:28:09 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:53130 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265682AbUGGX16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 19:27:58 -0400
Date: Thu, 8 Jul 2004 01:27:57 +0200
From: bert hubert <ahu@ds9a.nl>
To: "David S. Miller" <davem@redhat.com>,
       Stephen Hemminger <shemminger@osdl.org>, jamie@shareable.org,
       netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, ALESSANDRO.SUARDI@ORACLE.COM
Subject: preliminary conclusions regarding window size issues
Message-ID: <20040707232757.GA14471@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"David S. Miller" <davem@redhat.com>,
	Stephen Hemminger <shemminger@osdl.org>, jamie@shareable.org,
	netdev@oss.sgi.com, linux-net@vger.kernel.org,
	linux-kernel@vger.kernel.org, ALESSANDRO.SUARDI@ORACLE.COM
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two things:

1) packages.gentoo.org is currently unreachable by 2.6.7-recent.
This has been confirmed from several places, very easy to reproduce. Bug has
been filed with gentoo to fix their firewall.

2) What Alessandro Suardi sees is highly similar, except that he has it with
*all* remotes, except for google.it and a very small number of other
servers.

This is what Alessandro saw going out. We artificially lowered the MTU
because of possible tunelling loss:

01:03:36.323132 192.168.1.3.33992 > 213.244.168.210.10000: S [tcp sum ok] 3497585848:3497585848(0) 
	win 5440 <mss 1360,sackOK,timestamp 2311996 0,nop,wscale 7> 
	(DF) (ttl 64, id 43908, len 60)
01:03:36.396660 213.244.168.210.10000 > 192.168.1.3.33992: S [tcp sum ok] 3030562636:3030562636(0) 
	ack 3497585849 win 5792 <mss 1452,sackOK,timestamp  2142457957 2311996,nop,wscale 0> 
	(DF) (ttl 53, id 0, len 60)
01:03:36.396719 192.168.1.3.33992 > 213.244.168.210.10000: . [tcp sum ok]
	ack 1 win 42 <nop,nop,timestamp 2312084 2142457957> 
	(DF) (ttl 64, id 43909, len 52)

Perfect SYN, SYN|ACK, ACK.

01:03:36.397362 192.168.1.3.33992 > 213.244.168.210.10000: P 1:463(462) ack 1 win 42 
	<nop,nop,timestamp 2312085 2142457957> 
	(DF) (ttl 64, id 43910, len 514)

The GET request.

01:03:36.497588 213.244.168.210.10000 > 192.168.1.3.33992: . [tcp sum ok] ack 463 
	win 6432 <nop,nop,timestamp 2142457967 2312085> 
	(DF) (ttl 53, id 59171, len 52) 

And acked by my server. This trace is identical to what I see on the
receiving end:

29.84 62.211.168.xx.33992 > 213.244.168.210.10000: S [tcp sum ok] 3497585848:3497585848(0) 
	win 5440 <mss 1360,sackOK,timestamp 2311996 0,nop,wscale 7> 
	(DF) (ttl 50, id 43908, len 60)
29.84 213.244.168.210.10000 > 62.211.168.xx.33992: S [tcp sum ok] 3030562636:3030562636(0) 
	ack 3497585849 win 5792 <mss 1460,sackOK,timestamp 2142457957 2311996,nop,wscale 0>  
	(DF) (ttl 64, id 0, len 60)
29.93 62.211.168.xx.33992 > 213.244.168.210.10000: . [tcp sum ok] 1:1(0) 
	ack 1 win 42 <nop,nop,timestamp 2312084 2142457957> 
	(DF) (ttl 50, id 43909, len 52)

29.95 62.211.168.xx.33992 > 213.244.168.210.10000: P [tcp sum ok] 1:463(462)
	ack 1 win 42 <nop,nop,timestamp 2312085 2142457957> 
	(DF) (ttl 50, id 43910, len 514)
29.95 213.244.168.210.10000 > 62.211.168.xx.33992: . [tcp sum ok] 1:1(0) 
	ack 463 win 6432 <nop,nop,timestamp 2142457967 2312085> 
	(DF) (ttl 64, id 59171, len 52)

Except for TTL and NAT, this is identical.

>From here, things start to differ. I measure that I send out:

29.95 213.244.168.210.10000 > 62.211.168.xx.33992: . [tcp sum ok] 1:1349(1348) 
	ack 463 win 6432 <nop,nop,timestamp 2142457967 2312085> 
	(DF) (ttl 64, id 59172, len 1400)
29.95 213.244.168.210.10000 > 62.211.168.xx.33992: P [tcp sum ok] 1349:2697(1348) 
	ack 463 win 6432 <nop,nop,timestamp 2142457967 2312085> 
	(DF) (ttl 64, id 59173, len 1400)

This next packet is a repeat, because no ACK:

30.23 213.244.168.210.10000 > 62.211.168.xx.33992: . [tcp sum ok] 1:1349(1348) 
	ack 463 win 6432 <nop,nop,timestamp 2142457996 2312085> 
	(DF) (ttl 64, id 59174, len 1400)

ad nauseam. Alessandro never sees these packets! After a while, he
disconnects, which happens pretty normally. From another trace (NOTE!):

00:38:21.326397 192.168.1.3.33285 > 213.244.168.210.10000: F 420:420(0) 
	ack 1 win 45 <nop,nop,timestamp 796784 2142304361> 
	(DF)
00:38:21.410353 213.244.168.210.10000 > 192.168.1.3.33285: . 
	ack 421 win 6432 <nop,nop,timestamp 2142306461 796784> 
	(DF)
	
We've tried with wscale=0,1,2 and these all work. Things go wrong for
wscale>=3. My current feeling is that some kind of QoS device is
interfering, and that the 'wscale gets stuffed' theory is wrong in this
case.

I recall that 'Packeteer' QoS devices try to mess with windows.

Alessandro has this DSL modem, which crashed once during testing.
http://www.usr.com/support/product-template.asp?prod=9003

So we're not done debugging.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
