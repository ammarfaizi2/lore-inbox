Return-Path: <linux-kernel-owner+w=401wt.eu-S932142AbXAQJKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbXAQJKV (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 04:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbXAQJKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 04:10:21 -0500
Received: from [213.46.243.15] ([213.46.243.15]:16155 "EHLO
	amsfep14-int.chello.nl" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932126AbXAQJKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 04:10:18 -0500
Subject: Re: [PATCH 9/9] net: vm deadlock avoidance core
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org,
       David Miller <davem@davemloft.net>
In-Reply-To: <20070117045426.GA20921@2ka.mipt.ru>
References: <20070116094557.494892000@taijtu.programming.kicks-ass.net>
	 <20070116101816.115266000@taijtu.programming.kicks-ass.net>
	 <20070116132503.GA23144@2ka.mipt.ru> <1168955274.22935.47.camel@twins>
	 <20070116153315.GB710@2ka.mipt.ru> <1168963695.22935.78.camel@twins>
	 <20070117045426.GA20921@2ka.mipt.ru>
Content-Type: text/plain
Date: Wed, 17 Jan 2007 10:07:28 +0100
Message-Id: <1169024848.22935.109.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-17 at 07:54 +0300, Evgeniy Polyakov wrote:
> On Tue, Jan 16, 2007 at 05:08:15PM +0100, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > On Tue, 2007-01-16 at 18:33 +0300, Evgeniy Polyakov wrote:
> > > On Tue, Jan 16, 2007 at 02:47:54PM +0100, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > > > > > +	if (unlikely(skb->emergency))
> > > > > > +		current->flags |= PF_MEMALLOC;
> > > > > 
> > > > > Access to 'current' in netif_receive_skb()???
> > > > > Why do you want to work with, for example keventd?
> > > > 
> > > > Can this run in keventd?
> > > 
> > > Initial netchannel implementation by Kelly Daly (IBM) worked in keventd
> > > (or dedicated kernel thread, I do not recall).
> > > 
> > > > I thought this was softirq context and thus this would either run in a
> > > > borrowed context or in ksoftirqd. See patch 3/9.
> > > 
> > > And how are you going to access 'current' in softirq?
> > > 
> > > netif_receive_skb() can also be called from a lot of other places
> > > including keventd and/or different context - it is permitted to call it
> > > everywhere to process packet.
> > > 
> > > I meant that you break the rule accessing 'current' in that context.
> > 
> > Yeah, I know, but as long as we're not actually in hard irq context
> > current does point to the task_struct in charge of current execution and
> > as long as we restore whatever was in the flags field before we started
> > poking, nothing can go wrong.
> > 
> > So, yes this is unconventional, but it does work as expected.
> > 
> > As for breaking, 3/9 makes it legal.
> 
> You operate with 'current' in different contexts without any locks which
> looks racy and even is not allowed. What will be 'current' for
> netif_rx() case, which schedules softirq from hard irq context -
> ksoftirqd, why do you want to set its flags?

I don't touch current in hardirq context, do I (if I did, that is indeed
a mistake)?

In all other contexts, current is valid.

> > > I meant that you can just mark process which created such socket as
> > > PF_MEMALLOC, and clone that flag on forks and other relatest calls without 
> > > all that checks for 'current' in different places.
> > 
> > Ah, thats the wrong level to think here, these processes never reach
> > user-space - nor should these sockets.
> 
> You limit this just to send an ack?
> What about 'level-7' ack as you described in introduction?

Take NFS, it does full data traffic in kernel.

> > Also, I only want the processing of the actual network packet to be able
> > to eat the reserves, not any other thing that might happen in that
> > context.
> > 
> > And since network processing is mostly done in softirq context I must
> > mark these sections like I did.
> 
> You artificially limit system to just add a reserve to generate one ack.
> For that purpose you do not need to have all those flags - just reseve
> some data in network core and use it when system is in OOM (or reclaim)
> for critical data pathes.

How would that end up being different, I would have to replace all
allocations done in the full network processing path.

This seems a much less invasive method, all the (allocation) code can
stay the way it is and use the normal allocation functions.

> > > > > > +		/*
> > > > > > +		   decrease window size..
> > > > > > +		   tcp_enter_quickack_mode(sk);
> > > > > > +		*/
> > > > > 
> > > > > How does this decrease window size?
> > > > > Maybe ack scheduling would be better handled by inet_csk_schedule_ack()
> > > > > or just directly send an ack, which in turn requires allocation, which
> > > > > can be bound to this received frame processing...
> > > > 
> > > > It doesn't, I thought that it might be a good idea doing that, but never
> > > > got around to actually figuring out how to do it.
> > > 
> > > tcp_send_ack()?
> > > 
> > 
> > does that shrink the window automagically?
> 
> Yes, it updates window, but having ack generated in that place is
> actually very wrong. In that place system has not processed incoming
> packet yet, so it can not generate correct ACK for received frame at
> all. And it seems that the only purpose of the whole patchset is to
> generate that poor ack - reseve 2007 ack packets (MAX_TCP_HEADER) 
> in system startup and reuse them when you are under memory pressure.

Right, I suspected something like that; hence I wanted to just shrink
the window. Anyway, this is not a very important issue.

