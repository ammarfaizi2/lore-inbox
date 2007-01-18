Return-Path: <linux-kernel-owner+w=401wt.eu-S1751825AbXARKmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbXARKmO (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 05:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbXARKmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 05:42:14 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:54043 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825AbXARKmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 05:42:13 -0500
Date: Thu, 18 Jan 2007 13:41:44 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org,
       David Miller <davem@davemloft.net>
Subject: Re: [PATCH 9/9] net: vm deadlock avoidance core
Message-ID: <20070118104144.GA20925@2ka.mipt.ru>
References: <20070116094557.494892000@taijtu.programming.kicks-ass.net> <20070116101816.115266000@taijtu.programming.kicks-ass.net> <20070116132503.GA23144@2ka.mipt.ru> <1168955274.22935.47.camel@twins> <20070116153315.GB710@2ka.mipt.ru> <1168963695.22935.78.camel@twins> <20070117045426.GA20921@2ka.mipt.ru> <1169024848.22935.109.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1169024848.22935.109.camel@twins>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 18 Jan 2007 13:41:45 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 10:07:28AM +0100, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > You operate with 'current' in different contexts without any locks which
> > looks racy and even is not allowed. What will be 'current' for
> > netif_rx() case, which schedules softirq from hard irq context -
> > ksoftirqd, why do you want to set its flags?
> 
> I don't touch current in hardirq context, do I (if I did, that is indeed
> a mistake)?
> 
> In all other contexts, current is valid.

Well, if you think that setting PF_MEMALLOC flag for keventd and
ksoftirqd is valid, then probably yes...

> > > > I meant that you can just mark process which created such socket as
> > > > PF_MEMALLOC, and clone that flag on forks and other relatest calls without 
> > > > all that checks for 'current' in different places.
> > > 
> > > Ah, thats the wrong level to think here, these processes never reach
> > > user-space - nor should these sockets.
> > 
> > You limit this just to send an ack?
> > What about 'level-7' ack as you described in introduction?
> 
> Take NFS, it does full data traffic in kernel.

NFS case is exactly the situation, when you only need to generate an ACK.

> > > Also, I only want the processing of the actual network packet to be able
> > > to eat the reserves, not any other thing that might happen in that
> > > context.
> > > 
> > > And since network processing is mostly done in softirq context I must
> > > mark these sections like I did.
> > 
> > You artificially limit system to just add a reserve to generate one ack.
> > For that purpose you do not need to have all those flags - just reseve
> > some data in network core and use it when system is in OOM (or reclaim)
> > for critical data pathes.
> 
> How would that end up being different, I would have to replace all
> allocations done in the full network processing path.
> 
> This seems a much less invasive method, all the (allocation) code can
> stay the way it is and use the normal allocation functions.

Ack is only generated in one place in TCP.

And acutally we are starting to talk about different approach - having
separated allocator for network, which will be turned on on OOM (reclaim
or at any other time). If you do not mind, I would likw to refresh a
discussion about network tree allocator, which utilizes own pool of
pages, performs self-defragmentation of the memeory, is very SMP
friendly in that regard that it is per-cpu like slab and never free
objects on different CPUs, so they always stay in the same cache.
Among other goodies it allows to have full sending/receiving zero-copy.

Here is a link:
http://tservice.net.ru/~s0mbre/old/?section=projects&item=nta

> > > > > > > +		/*
> > > > > > > +		   decrease window size..
> > > > > > > +		   tcp_enter_quickack_mode(sk);
> > > > > > > +		*/
> > > > > > 
> > > > > > How does this decrease window size?
> > > > > > Maybe ack scheduling would be better handled by inet_csk_schedule_ack()
> > > > > > or just directly send an ack, which in turn requires allocation, which
> > > > > > can be bound to this received frame processing...
> > > > > 
> > > > > It doesn't, I thought that it might be a good idea doing that, but never
> > > > > got around to actually figuring out how to do it.
> > > > 
> > > > tcp_send_ack()?
> > > > 
> > > 
> > > does that shrink the window automagically?
> > 
> > Yes, it updates window, but having ack generated in that place is
> > actually very wrong. In that place system has not processed incoming
> > packet yet, so it can not generate correct ACK for received frame at
> > all. And it seems that the only purpose of the whole patchset is to
> > generate that poor ack - reseve 2007 ack packets (MAX_TCP_HEADER) 
> > in system startup and reuse them when you are under memory pressure.
> 
> Right, I suspected something like that; hence I wanted to just shrink
> the window. Anyway, this is not a very important issue.

tcp_enter_quickack_mode() does not update window, it allows to send ack
immediately after packet has been processed, window can be changed in
any way TCP state machine and congestion control want.

-- 
	Evgeniy Polyakov
