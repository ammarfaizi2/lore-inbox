Return-Path: <linux-kernel-owner+w=401wt.eu-S1751296AbXAPQLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbXAPQLv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbXAPQLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:11:51 -0500
Received: from [213.46.243.15] ([213.46.243.15]:8960 "EHLO
	amsfep18-int.chello.nl" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751252AbXAPQLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:11:50 -0500
X-Greylist: delayed 8483 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 11:11:49 EST
Subject: Re: [PATCH 9/9] net: vm deadlock avoidance core
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org,
       David Miller <davem@davemloft.net>
In-Reply-To: <20070116153315.GB710@2ka.mipt.ru>
References: <20070116094557.494892000@taijtu.programming.kicks-ass.net>
	 <20070116101816.115266000@taijtu.programming.kicks-ass.net>
	 <20070116132503.GA23144@2ka.mipt.ru> <1168955274.22935.47.camel@twins>
	 <20070116153315.GB710@2ka.mipt.ru>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 17:08:15 +0100
Message-Id: <1168963695.22935.78.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-16 at 18:33 +0300, Evgeniy Polyakov wrote:
> On Tue, Jan 16, 2007 at 02:47:54PM +0100, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > > > +	if (unlikely(skb->emergency))
> > > > +		current->flags |= PF_MEMALLOC;
> > > 
> > > Access to 'current' in netif_receive_skb()???
> > > Why do you want to work with, for example keventd?
> > 
> > Can this run in keventd?
> 
> Initial netchannel implementation by Kelly Daly (IBM) worked in keventd
> (or dedicated kernel thread, I do not recall).
> 
> > I thought this was softirq context and thus this would either run in a
> > borrowed context or in ksoftirqd. See patch 3/9.
> 
> And how are you going to access 'current' in softirq?
> 
> netif_receive_skb() can also be called from a lot of other places
> including keventd and/or different context - it is permitted to call it
> everywhere to process packet.
> 
> I meant that you break the rule accessing 'current' in that context.

Yeah, I know, but as long as we're not actually in hard irq context
current does point to the task_struct in charge of current execution and
as long as we restore whatever was in the flags field before we started
poking, nothing can go wrong.

So, yes this is unconventional, but it does work as expected.

As for breaking, 3/9 makes it legal.

> > > > @@ -1798,6 +1811,8 @@ int netif_receive_skb(struct sk_buff *sk
> > > >  		goto ncls;
> > > >  	}
> > > >  #endif
> > > > +	if (unlikely(skb->emergency))
> > > > +		goto skip_taps;
> > > >  
> > > >  	list_for_each_entry_rcu(ptype, &ptype_all, list) {
> > > >  		if (!ptype->dev || ptype->dev == skb->dev) {
> > > > @@ -1807,6 +1822,7 @@ int netif_receive_skb(struct sk_buff *sk
> > > >  		}
> > > >  	}
> > > >  
> > > > +skip_taps:
> > > 
> > > It is still a 'tap'.
> > 
> > Not sure what you are saying, I thought this should stop delivery of
> > skbs to taps?
> 
> Ingres filter can do whatever it wants with skb at that point, likely
> you want to skip that hunk too.

Will look into Ingres filters, thanks for the pointer.

> > > Why don't you want to just setup PF_MEMALLOC for the socket and all
> > > related processes?
> > 
> > I'm not understanding what you're saying here.
> > 
> > I want grant the processing of skb->emergency packets access to the
> > memory reserves.
> > 
> > How would I set PF_MEMALLOC on a socket, its a process flag? And which
> > related processes?
> 
> You use special flag for sockets to mark them as capable of
> 'reserve-eating', too many flags are a bit confusing.

Right, and I use PF_MEMALLOC to implement that reserve-eating. There
must be a link between SOCK_VMIO and all allocations associated with
that socket.

> I meant that you can just mark process which created such socket as
> PF_MEMALLOC, and clone that flag on forks and other relatest calls without 
> all that checks for 'current' in different places.

Ah, thats the wrong level to think here, these processes never reach
user-space - nor should these sockets.

Also, I only want the processing of the actual network packet to be able
to eat the reserves, not any other thing that might happen in that
context.

And since network processing is mostly done in softirq context I must
mark these sections like I did.

> > > > +		/*
> > > > +		   decrease window size..
> > > > +		   tcp_enter_quickack_mode(sk);
> > > > +		*/
> > > 
> > > How does this decrease window size?
> > > Maybe ack scheduling would be better handled by inet_csk_schedule_ack()
> > > or just directly send an ack, which in turn requires allocation, which
> > > can be bound to this received frame processing...
> > 
> > It doesn't, I thought that it might be a good idea doing that, but never
> > got around to actually figuring out how to do it.
> 
> tcp_send_ack()?
> 

does that shrink the window automagically?

