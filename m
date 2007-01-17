Return-Path: <linux-kernel-owner+w=401wt.eu-S1752022AbXAQEyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbXAQEyy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 23:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbXAQEyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 23:54:54 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:54630 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825AbXAQEyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 23:54:53 -0500
Date: Wed, 17 Jan 2007 07:54:26 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org,
       David Miller <davem@davemloft.net>
Subject: Re: [PATCH 9/9] net: vm deadlock avoidance core
Message-ID: <20070117045426.GA20921@2ka.mipt.ru>
References: <20070116094557.494892000@taijtu.programming.kicks-ass.net> <20070116101816.115266000@taijtu.programming.kicks-ass.net> <20070116132503.GA23144@2ka.mipt.ru> <1168955274.22935.47.camel@twins> <20070116153315.GB710@2ka.mipt.ru> <1168963695.22935.78.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1168963695.22935.78.camel@twins>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 17 Jan 2007 07:54:27 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 05:08:15PM +0100, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> On Tue, 2007-01-16 at 18:33 +0300, Evgeniy Polyakov wrote:
> > On Tue, Jan 16, 2007 at 02:47:54PM +0100, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > > > > +	if (unlikely(skb->emergency))
> > > > > +		current->flags |= PF_MEMALLOC;
> > > > 
> > > > Access to 'current' in netif_receive_skb()???
> > > > Why do you want to work with, for example keventd?
> > > 
> > > Can this run in keventd?
> > 
> > Initial netchannel implementation by Kelly Daly (IBM) worked in keventd
> > (or dedicated kernel thread, I do not recall).
> > 
> > > I thought this was softirq context and thus this would either run in a
> > > borrowed context or in ksoftirqd. See patch 3/9.
> > 
> > And how are you going to access 'current' in softirq?
> > 
> > netif_receive_skb() can also be called from a lot of other places
> > including keventd and/or different context - it is permitted to call it
> > everywhere to process packet.
> > 
> > I meant that you break the rule accessing 'current' in that context.
> 
> Yeah, I know, but as long as we're not actually in hard irq context
> current does point to the task_struct in charge of current execution and
> as long as we restore whatever was in the flags field before we started
> poking, nothing can go wrong.
> 
> So, yes this is unconventional, but it does work as expected.
> 
> As for breaking, 3/9 makes it legal.

You operate with 'current' in different contexts without any locks which
looks racy and even is not allowed. What will be 'current' for
netif_rx() case, which schedules softirq from hard irq context -
ksoftirqd, why do you want to set its flags?

> > I meant that you can just mark process which created such socket as
> > PF_MEMALLOC, and clone that flag on forks and other relatest calls without 
> > all that checks for 'current' in different places.
> 
> Ah, thats the wrong level to think here, these processes never reach
> user-space - nor should these sockets.

You limit this just to send an ack?
What about 'level-7' ack as you described in introduction?

> Also, I only want the processing of the actual network packet to be able
> to eat the reserves, not any other thing that might happen in that
> context.
> 
> And since network processing is mostly done in softirq context I must
> mark these sections like I did.

You artificially limit system to just add a reserve to generate one ack.
For that purpose you do not need to have all those flags - just reseve
some data in network core and use it when system is in OOM (or reclaim)
for critical data pathes.

> > > > > +		/*
> > > > > +		   decrease window size..
> > > > > +		   tcp_enter_quickack_mode(sk);
> > > > > +		*/
> > > > 
> > > > How does this decrease window size?
> > > > Maybe ack scheduling would be better handled by inet_csk_schedule_ack()
> > > > or just directly send an ack, which in turn requires allocation, which
> > > > can be bound to this received frame processing...
> > > 
> > > It doesn't, I thought that it might be a good idea doing that, but never
> > > got around to actually figuring out how to do it.
> > 
> > tcp_send_ack()?
> > 
> 
> does that shrink the window automagically?

Yes, it updates window, but having ack generated in that place is
actually very wrong. In that place system has not processed incoming
packet yet, so it can not generate correct ACK for received frame at
all. And it seems that the only purpose of the whole patchset is to
generate that poor ack - reseve 2007 ack packets (MAX_TCP_HEADER) 
in system startup and reuse them when you are under memory pressure.

-- 
	Evgeniy Polyakov
