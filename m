Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268926AbUHMAdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268926AbUHMAdA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 20:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268925AbUHMAbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 20:31:03 -0400
Received: from waste.org ([209.173.204.2]:45788 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268914AbUHMA3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 20:29:52 -0400
Date: Thu, 12 Aug 2004 19:29:31 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org, Stelian Pop <stelian@popies.net>,
       jgarzik@pobox.com
Subject: Re: [patch] fix netconsole hang with alt-sysrq-t
Message-ID: <20040813002931.GH16310@waste.org>
References: <16659.56343.686372.724218@segfault.boston.redhat.com> <20040806195237.GC16310@waste.org> <16659.58271.979999.616045@segfault.boston.redhat.com> <20040806202649.GE16310@waste.org> <16667.55966.317888.504243@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16667.55966.317888.504243@segfault.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 05:01:18PM -0400, Jeff Moyer wrote:
> ==> Regarding Re: [patch] fix netconsole hang with alt-sysrq-t; Matt Mackall <mpm@selenic.com> adds:
> 
> mpm> On Fri, Aug 06, 2004 at 04:01:35PM -0400, Jeff Moyer wrote:
> >> ==> Regarding Re: [patch] fix netconsole hang with alt-sysrq-t; Matt
> >> Mackall <mpm@selenic.com> adds:
> >> 
> mpm> On Fri, Aug 06, 2004 at 03:29:27PM -0400, Jeff Moyer wrote:
> >> >> Hi, Matt,
> >> >> 
> >> >> Here's the patch.  Sorry it took me so long, been busy with other
> >> work.  >> Two things which need perhaps more thinking, can netpoll_poll
> >> be called >> recursively (it didn't look like it to me)
> >> 
> mpm> It can if the poll function does a printk or the like and wants to
> mpm> recurse via netconsole. We could short-circuit that with an in_netpoll
> mpm> flag, but let's worry about that separately.

We've got about 5 different issues in this thread/patch, and they need to be
broken up. I was going to do this, but I'm moving to another city in 4
days. Jeff, if you'd be so kind (otherwise I'll get to it in about a
week and a half):

>  	spin_lock(&np->dev->xmit_lock);
>  	np->dev->xmit_lock_owner = smp_processor_id();
>  
> +	if (netif_queue_stopped(np->dev)) {
> +		np->dev->xmit_lock_owner = -1;
> +		spin_unlock(&np->dev->xmit_lock);
> +
> +		netpoll_poll(np);
> +		goto repeat;
> +	}
> +

Separate patch to revert this hunk with its own comment, please. This
should go in first.

> Without this test, we would go ahead and call hard_start_xmit even though
> the queue was stopped.
> 
> Thanks!
> 
> Jeff
> 
> --- linux-2.6.7/include/linux/netdevice.h.orig	2004-08-06 13:01:39.000000000 -0400
> +++ linux-2.6.7/include/linux/netdevice.h	2004-08-06 13:01:41.000000000 -0400
> @@ -462,7 +462,7 @@
>  						     unsigned char *haddr);
>  	int			(*neigh_setup)(struct net_device *dev, struct neigh_parms *);
>  	int			(*accept_fastpath)(struct net_device *, struct dst_entry*);
> -#ifdef CONFIG_NETPOLL_RX
> +#ifdef CONFIG_NETPOLL

And a separate bit to kill _RX

>  	int			netpoll_rx;
>  #endif
>  #ifdef CONFIG_NET_POLL_CONTROLLER
> --- linux-2.6.7/net/core/netpoll.c.orig	2004-08-06 11:13:45.000000000 -0400
> +++ linux-2.6.7/net/core/netpoll.c	2004-08-12 16:32:04.151624208 -0400
> @@ -36,7 +36,11 @@
>  static spinlock_t rx_list_lock = SPIN_LOCK_UNLOCKED;
>  static LIST_HEAD(rx_list);
>  
> -static int trapped;
> +static atomic_t trapped;

And one for making trapped atomic.

> +spinlock_t netpoll_poll_lock = SPIN_LOCK_UNLOCKED;

And one for globalizing the lock.

> +
> +#define NETPOLL_RX_ENABLED  1
> +#define NETPOLL_RX_DROP     2
>  
>  #define MAX_SKB_SIZE \
>  		(MAX_UDP_CHUNK + sizeof(struct udphdr) + \
> @@ -61,7 +65,8 @@
>  
>  void netpoll_poll(struct netpoll *np)
>  {
> -	int budget = 1;
> +	int budget = 16;

And this one-liner could use a comment and its own patch as well.

> +	unsigned long flags;
>  
>  	if(!np->dev || !netif_running(np->dev) || !np->dev->poll_controller)
>  		return;
> @@ -70,9 +75,19 @@
>  	np->dev->poll_controller(np->dev);
>  
>  	/* If scheduling is stopped, tickle NAPI bits */
> -	if(trapped && np->dev->poll &&
> -	   test_bit(__LINK_STATE_RX_SCHED, &np->dev->state))
> +	spin_lock_irqsave(&netpoll_poll_lock, flags);
> +	if (np->dev->poll &&
> +	    test_bit(__LINK_STATE_RX_SCHED, &np->dev->state)) {
> +		np->dev->netpoll_rx |= NETPOLL_RX_DROP;
> +		atomic_inc(&trapped);
> +
>  		np->dev->poll(np->dev, &budget);
> +
> +		atomic_dec(&trapped);
> +		np->dev->netpoll_rx &= ~NETPOLL_RX_DROP;
> +	}
> +	spin_unlock_irqrestore(&netpoll_poll_lock, flags);
> +
>  	zap_completion_queue();
>  }

And a new patch that brings in the new RX/trapped logic.

-- 
Mathematics is the supreme nostalgia of our time.
