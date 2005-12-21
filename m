Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbVLUJLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbVLUJLt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 04:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVLUJLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 04:11:49 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31958 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932322AbVLUJLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 04:11:48 -0500
Date: Wed, 21 Dec 2005 10:11:14 +0100
From: Pavel Machek <pavel@suse.cz>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, mpm@selenic.com, ak@suse.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
Message-ID: <20051221091114.GA8495@elf.ucw.cz>
References: <20051215033937.GC11856@waste.org> <20051214.203023.129054759.davem@davemloft.net> <Pine.LNX.4.58.0512142318410.7197@w-sridhar.beaverton.ibm.com> <20051215.002120.133621586.davem@davemloft.net> <1134698963.10101.43.camel@w-sridhar2.beaverton.ibm.com> <20051216094810.70082caa@dxpl.pdx.osdl.net> <1134758299.10691.28.camel@w-sridhar2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134758299.10691.28.camel@w-sridhar2.beaverton.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If it is only one place, why not pre-allocate one "I'm sick now"
> > skb and hold onto it. Any bigger solution seems to snowball into
> > a huge mess.
> 
> But the problem is even sending/receiving a single packet can cause 
> multiple dynamic allocations in the networking path all the way from
> the sockets layer->transport->ip->driver.
> To successfully send a packet, we may have to do arp, send acks and 
> create cached routes etc. So my patch tried to identify the allocations
> that are needed to succesfully send/receive packets over a pre-established
> socket and adds a new flag GFP_CRITICAL to those calls.
> This doesn't make any difference when we are not in emergency. But when
> we go into emergency, VM will try to satisfy these allocations from a
> critical pool if the normal path leads to failure.
> 
> We go into emergency when some management app detects that a swap device
> is about to fail(we are not yet in OOM, but will enter OOM soon). In order
> to avoid entering OOM, we need to send a message over a critical socket to
> a remote server that can initiate failover and switch to a different swap
> device. The switchover will happen within 2 minutes after it is initiated.
> In a cluster environment, the remote server also sends a message to other
> nodes which are also running the management app so that they also enter
> emergency. Once we successfully switch to a different swap device, the remote
> server sends a message to all the nodes and they come out of emergency.
> 
> During the period of emergency, all other communications can block. But
> guranteeing the successful delivery of the critical messages will help 
> in making sure that we do not enter OOM situation.

Why not do it the other way? "If you don't hear from me for 2 minutes,
do a switchover". Then all you have to do is _not_ to send a packet --
easier to do.

Anything else seems overkill.
								Pavel
-- 
Thanks, Sharp!
