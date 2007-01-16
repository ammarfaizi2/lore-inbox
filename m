Return-Path: <linux-kernel-owner+w=401wt.eu-S1750983AbXAPNu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbXAPNu2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 08:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbXAPNu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 08:50:28 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:26390 "EHLO
	amsfep13-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750983AbXAPNu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 08:50:27 -0500
Subject: Re: [PATCH 9/9] net: vm deadlock avoidance core
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org,
       David Miller <davem@davemloft.net>
In-Reply-To: <20070116132503.GA23144@2ka.mipt.ru>
References: <20070116094557.494892000@taijtu.programming.kicks-ass.net>
	 <20070116101816.115266000@taijtu.programming.kicks-ass.net>
	 <20070116132503.GA23144@2ka.mipt.ru>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 14:47:54 +0100
Message-Id: <1168955274.22935.47.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-16 at 16:25 +0300, Evgeniy Polyakov wrote:
> On Tue, Jan 16, 2007 at 10:46:06AM +0100, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:

> > @@ -1767,10 +1767,23 @@ int netif_receive_skb(struct sk_buff *sk
> >  	struct net_device *orig_dev;
> >  	int ret = NET_RX_DROP;
> >  	__be16 type;
> > +	unsigned long pflags = current->flags;
> > +
> > +	/* Emergency skb are special, they should
> > +	 *  - be delivered to SOCK_VMIO sockets only
> > +	 *  - stay away from userspace
> > +	 *  - have bounded memory usage
> > +	 *
> > +	 * Use PF_MEMALLOC as a poor mans memory pool - the grouping kind.
> > +	 * This saves us from propagating the allocation context down to all
> > +	 * allocation sites.
> > +	 */
> > +	if (unlikely(skb->emergency))
> > +		current->flags |= PF_MEMALLOC;
> 
> Access to 'current' in netif_receive_skb()???
> Why do you want to work with, for example keventd?

Can this run in keventd?

I thought this was softirq context and thus this would either run in a
borrowed context or in ksoftirqd. See patch 3/9.

> > @@ -1798,6 +1811,8 @@ int netif_receive_skb(struct sk_buff *sk
> >  		goto ncls;
> >  	}
> >  #endif
> > +	if (unlikely(skb->emergency))
> > +		goto skip_taps;
> >  
> >  	list_for_each_entry_rcu(ptype, &ptype_all, list) {
> >  		if (!ptype->dev || ptype->dev == skb->dev) {
> > @@ -1807,6 +1822,7 @@ int netif_receive_skb(struct sk_buff *sk
> >  		}
> >  	}
> >  
> > +skip_taps:
> 
> It is still a 'tap'.

Not sure what you are saying, I thought this should stop delivery of
skbs to taps?

> >  #ifdef CONFIG_NET_CLS_ACT
> >  	if (pt_prev) {
> >  		ret = deliver_skb(skb, pt_prev, orig_dev);
> > @@ -1819,15 +1835,26 @@ int netif_receive_skb(struct sk_buff *sk
> >  
> >  	if (ret == TC_ACT_SHOT || (ret == TC_ACT_STOLEN)) {
> >  		kfree_skb(skb);
> > -		goto out;
> > +		goto unlock;
> >  	}
> >  
> >  	skb->tc_verd = 0;
> >  ncls:
> >  #endif
> >  
> > +	if (unlikely(skb->emergency))
> > +		switch(skb->protocol) {
> > +			case __constant_htons(ETH_P_ARP):
> > +			case __constant_htons(ETH_P_IP):
> > +			case __constant_htons(ETH_P_IPV6):
> > +				break;
> 
> Poor vlans and appletalk.

Yeah and all those other too, maybe some day.

> > Index: linux-2.6-git/net/ipv4/tcp_ipv4.c
> > ===================================================================
> > --- linux-2.6-git.orig/net/ipv4/tcp_ipv4.c	2007-01-12 12:20:07.000000000 +0100
> > +++ linux-2.6-git/net/ipv4/tcp_ipv4.c	2007-01-12 12:21:14.000000000 +0100
> > @@ -1604,6 +1604,22 @@ csum_err:
> >  	goto discard;
> >  }
> >  
> > +static int tcp_v4_backlog_rcv(struct sock *sk, struct sk_buff *skb)
> > +{
> > +	int ret;
> > +	unsigned long pflags = current->flags;
> > +	if (unlikely(skb->emergency)) {
> > +		BUG_ON(!sk_has_vmio(sk)); /* we dropped those before queueing */
> > +		if (!(pflags & PF_MEMALLOC))
> > +			current->flags |= PF_MEMALLOC;
> > +	}
> > +
> > +	ret = tcp_v4_do_rcv(sk, skb);
> > +
> > +	current->flags = pflags;
> > +	return ret;
> 
> Why don't you want to just setup PF_MEMALLOC for the socket and all
> related processes?

I'm not understanding what you're saying here.

I want grant the processing of skb->emergency packets access to the
memory reserves.

How would I set PF_MEMALLOC on a socket, its a process flag? And which
related processes?

> > +}
> > +
> >  /*
> >   *	From tcp_input.c
> >   */
> > @@ -1654,6 +1670,15 @@ int tcp_v4_rcv(struct sk_buff *skb)
> >  	if (!sk)
> >  		goto no_tcp_socket;
> >  
> > +	if (unlikely(skb->emergency)) {
> > +	       	if (!sk_has_vmio(sk))
> > +			goto discard_and_relse;
> > +		/*
> > +		   decrease window size..
> > +		   tcp_enter_quickack_mode(sk);
> > +		*/
> 
> How does this decrease window size?
> Maybe ack scheduling would be better handled by inet_csk_schedule_ack()
> or just directly send an ack, which in turn requires allocation, which
> can be bound to this received frame processing...

It doesn't, I thought that it might be a good idea doing that, but never
got around to actually figuring out how to do it.

