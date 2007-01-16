Return-Path: <linux-kernel-owner+w=401wt.eu-S1751251AbXAPPeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbXAPPeU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 10:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbXAPPeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 10:34:20 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:47560 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251AbXAPPeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 10:34:19 -0500
Date: Tue, 16 Jan 2007 18:33:15 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org,
       David Miller <davem@davemloft.net>
Subject: Re: [PATCH 9/9] net: vm deadlock avoidance core
Message-ID: <20070116153315.GB710@2ka.mipt.ru>
References: <20070116094557.494892000@taijtu.programming.kicks-ass.net> <20070116101816.115266000@taijtu.programming.kicks-ass.net> <20070116132503.GA23144@2ka.mipt.ru> <1168955274.22935.47.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1168955274.22935.47.camel@twins>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 16 Jan 2007 18:33:20 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 02:47:54PM +0100, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > > +	if (unlikely(skb->emergency))
> > > +		current->flags |= PF_MEMALLOC;
> > 
> > Access to 'current' in netif_receive_skb()???
> > Why do you want to work with, for example keventd?
> 
> Can this run in keventd?

Initial netchannel implementation by Kelly Daly (IBM) worked in keventd
(or dedicated kernel thread, I do not recall).

> I thought this was softirq context and thus this would either run in a
> borrowed context or in ksoftirqd. See patch 3/9.

And how are you going to access 'current' in softirq?

netif_receive_skb() can also be called from a lot of other places
including keventd and/or different context - it is permitted to call it
everywhere to process packet.

I meant that you break the rule accessing 'current' in that context.

> > > @@ -1798,6 +1811,8 @@ int netif_receive_skb(struct sk_buff *sk
> > >  		goto ncls;
> > >  	}
> > >  #endif
> > > +	if (unlikely(skb->emergency))
> > > +		goto skip_taps;
> > >  
> > >  	list_for_each_entry_rcu(ptype, &ptype_all, list) {
> > >  		if (!ptype->dev || ptype->dev == skb->dev) {
> > > @@ -1807,6 +1822,7 @@ int netif_receive_skb(struct sk_buff *sk
> > >  		}
> > >  	}
> > >  
> > > +skip_taps:
> > 
> > It is still a 'tap'.
> 
> Not sure what you are saying, I thought this should stop delivery of
> skbs to taps?

Ingres filter can do whatever it wants with skb at that point, likely
you want to skip that hunk too.

> > >  #ifdef CONFIG_NET_CLS_ACT
> > >  	if (pt_prev) {
> > >  		ret = deliver_skb(skb, pt_prev, orig_dev);
> > > @@ -1819,15 +1835,26 @@ int netif_receive_skb(struct sk_buff *sk
> > >  
> > >  	if (ret == TC_ACT_SHOT || (ret == TC_ACT_STOLEN)) {
> > >  		kfree_skb(skb);
> > > -		goto out;
> > > +		goto unlock;
> > >  	}
> > >  
> > >  	skb->tc_verd = 0;
> > >  ncls:
> > >  #endif
> > >  
> > > +	if (unlikely(skb->emergency))
> > > +		switch(skb->protocol) {
> > > +			case __constant_htons(ETH_P_ARP):
> > > +			case __constant_htons(ETH_P_IP):
> > > +			case __constant_htons(ETH_P_IPV6):
> > > +				break;
> > 
> > Poor vlans and appletalk.
> 
> Yeah and all those other too, maybe some day.
> 
> > > Index: linux-2.6-git/net/ipv4/tcp_ipv4.c
> > > ===================================================================
> > > --- linux-2.6-git.orig/net/ipv4/tcp_ipv4.c	2007-01-12 12:20:07.000000000 +0100
> > > +++ linux-2.6-git/net/ipv4/tcp_ipv4.c	2007-01-12 12:21:14.000000000 +0100
> > > @@ -1604,6 +1604,22 @@ csum_err:
> > >  	goto discard;
> > >  }
> > >  
> > > +static int tcp_v4_backlog_rcv(struct sock *sk, struct sk_buff *skb)
> > > +{
> > > +	int ret;
> > > +	unsigned long pflags = current->flags;
> > > +	if (unlikely(skb->emergency)) {
> > > +		BUG_ON(!sk_has_vmio(sk)); /* we dropped those before queueing */
> > > +		if (!(pflags & PF_MEMALLOC))
> > > +			current->flags |= PF_MEMALLOC;
> > > +	}
> > > +
> > > +	ret = tcp_v4_do_rcv(sk, skb);
> > > +
> > > +	current->flags = pflags;
> > > +	return ret;
> > 
> > Why don't you want to just setup PF_MEMALLOC for the socket and all
> > related processes?
> 
> I'm not understanding what you're saying here.
> 
> I want grant the processing of skb->emergency packets access to the
> memory reserves.
> 
> How would I set PF_MEMALLOC on a socket, its a process flag? And which
> related processes?

You use special flag for sockets to mark them as capable of
'reserve-eating', too many flags are a bit confusing.

I meant that you can just mark process which created such socket as
PF_MEMALLOC, and clone that flag on forks and other relatest calls without 
all that checks for 'current' in different places.

> > > +}
> > > +
> > >  /*
> > >   *	From tcp_input.c
> > >   */
> > > @@ -1654,6 +1670,15 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > >  	if (!sk)
> > >  		goto no_tcp_socket;
> > >  
> > > +	if (unlikely(skb->emergency)) {
> > > +	       	if (!sk_has_vmio(sk))
> > > +			goto discard_and_relse;
> > > +		/*
> > > +		   decrease window size..
> > > +		   tcp_enter_quickack_mode(sk);
> > > +		*/
> > 
> > How does this decrease window size?
> > Maybe ack scheduling would be better handled by inet_csk_schedule_ack()
> > or just directly send an ack, which in turn requires allocation, which
> > can be bound to this received frame processing...
> 
> It doesn't, I thought that it might be a good idea doing that, but never
> got around to actually figuring out how to do it.

tcp_send_ack()?

-- 
	Evgeniy Polyakov
