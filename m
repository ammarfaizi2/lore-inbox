Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262695AbVA0T3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbVA0T3K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 14:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbVA0T3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 14:29:10 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:38050 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262695AbVA0T26
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 14:28:58 -0500
From: David Brownell <david-b@pacbell.net>
To: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>
Subject: Re: 2.6.11-rc2 TCP ignores PMTU ICMP (Re: Linux 2.6.11-rc2)
Date: Thu, 27 Jan 2005 11:28:48 -0800
User-Agent: KMail/1.7.1
Cc: David Ford <david+challenge-response@blue-labs.org>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <200501232251.42394.david-b@pacbell.net> <200501251054.37053.david-b@pacbell.net> <priv$1106815487.koan@shadow.banki.hu>
In-Reply-To: <priv$1106815487.koan@shadow.banki.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501271128.48411.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 January 2005 1:02 am, Janos Farkas wrote:
> On 2005-01-25 at 10:54:36, David Brownell wrote:
> > On Tuesday 25 January 2005 10:35 am, David Ford wrote:
> > > PMTU bug -- or better said, bad firewall admin who blocks all ICMP.
> > 
> > PMTU bug, sure -- but one that came late in RC2.  Remember:  same firewall
> > in both cases, but only RC2 breaks.  The ICMP packet has landed in
> > the RC2 system, which ignores it.  2.6.10 handled it correctly... I
> > suspect one of the TCP cleanups borked this.

And in fact, I'm pretty sure RC1 handled it fine too.  This failure
appeared in a BK pull I did a couple days before RC2, and installing
it clobbered a "more virgin" RC1 install; so it's hard to verify.

It took a while to track the failure mode down to being PMTU related,
but the only TCP-related changes I noticed in what I pulled sure
seemed like cleanups (removing some "duplicated" state).


> > My current workaround is "ifconfig eth0 mtu 1492" but that's not
> > something I'd expect to keep.
> 
> Indeed, I had to shuffle my machines around a bit to get a proof that
> something is broken, but now I can confirm the above with a connection
> to cvs.sourceforge.net:

Thanks for confirming it wasn't just me ... I confess I'm a bit
surprised more folk haven't reported this yet! 

Your symptoms are exactly like those I saw, just with a different
mission-critical application:  CVS, not SMTP.  Did you happen to
notice whether CVS pulls worked, when pushes (like this) failed?

- Dave


> ...
> 
> (the PPPoE gateway notifies the host about the PMTU issue, one for each
> segment)
> 
> 08:05:45.265330 IP (tos 0xc0, ttl 128, id 17970, offset 0, flags [none], length: 576) 192.168.59.1 > 192.168.59.10: icmp 556: 66.35.250.207 unreachable - need to frag (mtu 1492)
> 08:05:45.265453 IP (tos 0xc0, ttl 128, id 17971, offset 0, flags [none], length: 576) 192.168.59.1 > 192.168.59.10: icmp 556: 66.35.250.207 unreachable - need to frag (mtu 1492)
> 
> (the source host sends the full frame again...?)
> 
> 08:05:45.770331 IP (tos 0x0, ttl  64, id 21544, offset 0, flags [DF], length: 1500) 192.168.59.10.29612 > 66.35.250.207.2401: . [tcp sum ok] 499:1947(1448) ack 526 win 1728 <nop,nop,timestamp 2709754 312383166>
> 08:05:45.770900 IP (tos 0xc0, ttl 128, id 17972, offset 0, flags [none], length: 576) 192.168.59.1 > 192.168.59.10: icmp 556: 66.35.250.207 unreachable - need to frag (mtu 1492)
> 
> (and looping goes on..)
> 
> 08:05:46.783148 IP (tos 0x0, ttl  64, id 21546, offset 0, flags [DF], length: 1500) 192.168.59.10.29612 > 66.35.250.207.2401: . [tcp sum ok] 499:1947(1448) ack 526 win 1728 <nop,nop,timestamp 2710768 312383166>
> 08:05:46.783752 IP (tos 0xc0, ttl 128, id 17973, offset 0, flags [none], length: 576) 192.168.59.1 > 192.168.59.10: icmp 556: 66.35.250.207 unreachable - need to frag (mtu 1492)
> 08:05:48.808861 IP (tos 0x0, ttl  64, id 21548, offset 0, flags [DF], length: 1500) 192.168.59.10.29612 > 66.35.250.207.2401: . [tcp sum ok] 499:1947(1448) ack 526 win 1728 <nop,nop,timestamp 2712796 312383166>
> 08:05:48.809882 IP (tos 0xc0, ttl 128, id 17974, offset 0, flags [none], length: 576) 192.168.59.1 > 192.168.59.10: icmp 556: 66.35.250.207 unreachable - need to frag (mtu 1492)
> 
> ...
> 
