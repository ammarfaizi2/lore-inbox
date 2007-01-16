Return-Path: <linux-kernel-owner+w=401wt.eu-S1751079AbXAPNZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbXAPNZo (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 08:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbXAPNZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 08:25:44 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:56717 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041AbXAPNZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 08:25:42 -0500
Date: Tue, 16 Jan 2007 16:25:03 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org,
       David Miller <davem@davemloft.net>
Subject: Re: [PATCH 9/9] net: vm deadlock avoidance core
Message-ID: <20070116132503.GA23144@2ka.mipt.ru>
References: <20070116094557.494892000@taijtu.programming.kicks-ass.net> <20070116101816.115266000@taijtu.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20070116101816.115266000@taijtu.programming.kicks-ass.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 16 Jan 2007 16:25:04 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 10:46:06AM +0100, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> In order to provide robust networked storage there must be a guarantee
> of progress. That is, the storage device must never stall because of (physical)
> OOM, because the device itself might be needed to get out of it (reclaim).


>  /* Used by processes to "lock" a socket state, so that
> Index: linux-2.6-git/net/core/dev.c
> ===================================================================
> --- linux-2.6-git.orig/net/core/dev.c	2007-01-12 12:20:07.000000000 +0100
> +++ linux-2.6-git/net/core/dev.c	2007-01-12 12:21:55.000000000 +0100
> @@ -1767,10 +1767,23 @@ int netif_receive_skb(struct sk_buff *sk
>  	struct net_device *orig_dev;
>  	int ret = NET_RX_DROP;
>  	__be16 type;
> +	unsigned long pflags = current->flags;
> +
> +	/* Emergency skb are special, they should
> +	 *  - be delivered to SOCK_VMIO sockets only
> +	 *  - stay away from userspace
> +	 *  - have bounded memory usage
> +	 *
> +	 * Use PF_MEMALLOC as a poor mans memory pool - the grouping kind.
> +	 * This saves us from propagating the allocation context down to all
> +	 * allocation sites.
> +	 */
> +	if (unlikely(skb->emergency))
> +		current->flags |= PF_MEMALLOC;

Access to 'current' in netif_receive_skb()???
Why do you want to work with, for example keventd?

>  	/* if we've gotten here through NAPI, check netpoll */
>  	if (skb->dev->poll && netpoll_rx(skb))
> -		return NET_RX_DROP;
> +		goto out;
>  
>  	if (!skb->tstamp.off_sec)
>  		net_timestamp(skb);
> @@ -1781,7 +1794,7 @@ int netif_receive_skb(struct sk_buff *sk
>  	orig_dev = skb_bond(skb);
>  
>  	if (!orig_dev)
> -		return NET_RX_DROP;
> +		goto out;
>  
>  	__get_cpu_var(netdev_rx_stat).total++;
>  
> @@ -1798,6 +1811,8 @@ int netif_receive_skb(struct sk_buff *sk
>  		goto ncls;
>  	}
>  #endif
> +	if (unlikely(skb->emergency))
> +		goto skip_taps;
>  
>  	list_for_each_entry_rcu(ptype, &ptype_all, list) {
>  		if (!ptype->dev || ptype->dev == skb->dev) {
> @@ -1807,6 +1822,7 @@ int netif_receive_skb(struct sk_buff *sk
>  		}
>  	}
>  
> +skip_taps:

It is still a 'tap'.

>  #ifdef CONFIG_NET_CLS_ACT
>  	if (pt_prev) {
>  		ret = deliver_skb(skb, pt_prev, orig_dev);
> @@ -1819,15 +1835,26 @@ int netif_receive_skb(struct sk_buff *sk
>  
>  	if (ret == TC_ACT_SHOT || (ret == TC_ACT_STOLEN)) {
>  		kfree_skb(skb);
> -		goto out;
> +		goto unlock;
>  	}
>  
>  	skb->tc_verd = 0;
>  ncls:
>  #endif
>  
> +	if (unlikely(skb->emergency))
> +		switch(skb->protocol) {
> +			case __constant_htons(ETH_P_ARP):
> +			case __constant_htons(ETH_P_IP):
> +			case __constant_htons(ETH_P_IPV6):
> +				break;

Poor vlans and appletalk.

> +			default:
> +				goto drop;
> +		}
> +
>  	if (handle_bridge(&skb, &pt_prev, &ret, orig_dev))
> -		goto out;
> +		goto unlock;
>  
>  	type = skb->protocol;
>  	list_for_each_entry_rcu(ptype, &ptype_base[ntohs(type)&15], list) {
> @@ -1842,6 +1869,7 @@ ncls:
>  	if (pt_prev) {
>  		ret = pt_prev->func(skb, skb->dev, pt_prev, orig_dev);
>  	} else {
> +drop:
>  		kfree_skb(skb);
>  		/* Jamal, now you will not able to escape explaining
>  		 * me how you were going to use this. :-)
> @@ -1849,8 +1877,10 @@ ncls:
>  		ret = NET_RX_DROP;
>  	}
>  
> -out:
> +unlock:
>  	rcu_read_unlock();
> +out:
> +	current->flags = pflags;
>  	return ret;
>  }
>  
> Index: linux-2.6-git/net/core/skbuff.c
> ===================================================================
> --- linux-2.6-git.orig/net/core/skbuff.c	2007-01-12 12:20:07.000000000 +0100
> +++ linux-2.6-git/net/core/skbuff.c	2007-01-12 13:29:51.000000000 +0100
> @@ -142,28 +142,34 @@ EXPORT_SYMBOL(skb_truesize_bug);
>   *	%GFP_ATOMIC.
>   */
>  struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
> -			    int fclone, int node)
> +			    int flags, int node)
>  {
>  	struct kmem_cache *cache;
>  	struct skb_shared_info *shinfo;
>  	struct sk_buff *skb;
>  	u8 *data;
> +	int emergency = 0;
>  
> -	cache = fclone ? skbuff_fclone_cache : skbuff_head_cache;
> +	size = SKB_DATA_ALIGN(size);
> +	cache = (flags & SKB_ALLOC_FCLONE)
> +		? skbuff_fclone_cache : skbuff_head_cache;
> +	if (flags & SKB_ALLOC_RX)
> +		gfp_mask |= __GFP_NOMEMALLOC|__GFP_NOWARN;
>  
> +retry_alloc:
>  	/* Get the HEAD */
>  	skb = kmem_cache_alloc_node(cache, gfp_mask & ~__GFP_DMA, node);
>  	if (!skb)
> -		goto out;
> +		goto noskb;
>  
>  	/* Get the DATA. Size must match skb_add_mtu(). */
> -	size = SKB_DATA_ALIGN(size);
>  	data = kmalloc_node_track_caller(size + sizeof(struct skb_shared_info),
>  			gfp_mask, node);
>  	if (!data)
>  		goto nodata;
>  
>  	memset(skb, 0, offsetof(struct sk_buff, truesize));
> +	skb->emergency = emergency;
>  	skb->truesize = size + sizeof(struct sk_buff);
>  	atomic_set(&skb->users, 1);
>  	skb->head = data;
> @@ -180,7 +186,7 @@ struct sk_buff *__alloc_skb(unsigned int
>  	shinfo->ip6_frag_id = 0;
>  	shinfo->frag_list = NULL;
>  
> -	if (fclone) {
> +	if (flags & SKB_ALLOC_FCLONE) {
>  		struct sk_buff *child = skb + 1;
>  		atomic_t *fclone_ref = (atomic_t *) (child + 1);
>  
> @@ -188,12 +194,29 @@ struct sk_buff *__alloc_skb(unsigned int
>  		atomic_set(fclone_ref, 1);
>  
>  		child->fclone = SKB_FCLONE_UNAVAILABLE;
> +		child->emergency = skb->emergency;
>  	}
>  out:
>  	return skb;
> +
>  nodata:
>  	kmem_cache_free(cache, skb);
>  	skb = NULL;
> +noskb:
> +	/* Attempt emergency allocation when RX skb. */
> +	if (likely(!(flags & SKB_ALLOC_RX) || !sk_vmio_socks()))
> +		goto out;
> +
> +	if (!emergency) {
> +		if (sk_emergency_skb_get()) {
> +			gfp_mask &= ~(__GFP_NOMEMALLOC|__GFP_NOWARN);
> +			gfp_mask |= __GFP_EMERGENCY;
> +			emergency = 1;
> +			goto retry_alloc;
> +		}
> +	} else
> +		sk_emergency_skb_put();
> +
>  	goto out;
>  }
>  
> @@ -271,7 +294,7 @@ struct sk_buff *__netdev_alloc_skb(struc
>  	int node = dev->class_dev.dev ? dev_to_node(dev->class_dev.dev) : -1;
>  	struct sk_buff *skb;
>  
> - 	skb = __alloc_skb(length + NET_SKB_PAD, gfp_mask, 0, node);
> + 	skb = __alloc_skb(length + NET_SKB_PAD, gfp_mask, SKB_ALLOC_RX, node);
>  	if (likely(skb)) {
>  		skb_reserve(skb, NET_SKB_PAD);
>  		skb->dev = dev;
> @@ -320,6 +343,8 @@ static void skb_release_data(struct sk_b
>  			skb_drop_fraglist(skb);
>  
>  		kfree(skb->head);
> +		if (unlikely(skb->emergency))
> +			sk_emergency_skb_put();
>  	}
>  }
>  
> @@ -440,6 +465,9 @@ struct sk_buff *skb_clone(struct sk_buff
>  		n->fclone = SKB_FCLONE_CLONE;
>  		atomic_inc(fclone_ref);
>  	} else {
> +		if (unlikely(skb->emergency))
> +			gfp_mask |= __GFP_EMERGENCY;
> +
>  		n = kmem_cache_alloc(skbuff_head_cache, gfp_mask);
>  		if (!n)
>  			return NULL;
> @@ -474,6 +502,7 @@ struct sk_buff *skb_clone(struct sk_buff
>  #if defined(CONFIG_IP_VS) || defined(CONFIG_IP_VS_MODULE)
>  	C(ipvs_property);
>  #endif
> +	C(emergency);
>  	C(protocol);
>  	n->destructor = NULL;
>  	C(mark);
> @@ -689,12 +718,19 @@ int pskb_expand_head(struct sk_buff *skb
>  	u8 *data;
>  	int size = nhead + (skb->end - skb->head) + ntail;
>  	long off;
> +	int emergency = 0;
>  
>  	if (skb_shared(skb))
>  		BUG();
>  
>  	size = SKB_DATA_ALIGN(size);
>  
> +	if (unlikely(skb->emergency) && sk_emergency_skb_get()) {
> +		gfp_mask |= __GFP_EMERGENCY;
> +		emergency = 1;
> +	} else
> +		gfp_mask |= __GFP_NOMEMALLOC;
> +
>  	data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
>  	if (!data)
>  		goto nodata;
> @@ -727,6 +763,8 @@ int pskb_expand_head(struct sk_buff *skb
>  	return 0;
>  
>  nodata:
> +	if (unlikely(emergency))
> +		sk_emergency_skb_put();
>  	return -ENOMEM;
>  }
>  
> Index: linux-2.6-git/net/core/sock.c
> ===================================================================
> --- linux-2.6-git.orig/net/core/sock.c	2007-01-12 12:20:07.000000000 +0100
> +++ linux-2.6-git/net/core/sock.c	2007-01-12 12:21:14.000000000 +0100
> @@ -196,6 +196,120 @@ __u32 sysctl_rmem_default __read_mostly 
>  /* Maximal space eaten by iovec or ancilliary data plus some space */
>  int sysctl_optmem_max __read_mostly = sizeof(unsigned long)*(2*UIO_MAXIOV+512);
>  
> +static DEFINE_SPINLOCK(memalloc_lock);
> +static int rx_net_reserve;
> +
> +atomic_t vmio_socks;
> +atomic_t emergency_rx_skbs;
> +
> +static int ipfrag_threshold;
> +
> +#define ipfrag_mtu()	(1500) /* XXX: should be smallest mtu system wide */
> +#define ipfrag_skbs()	(ipfrag_threshold / ipfrag_mtu())
> +#define ipfrag_pages()	(ipfrag_threshold / (ipfrag_mtu() * (PAGE_SIZE / ipfrag_mtu())))
> +
> +static int iprt_pages;
> +
> +/*
> + * is there room for another emergency skb.
> + */
> +int sk_emergency_skb_get(void)
> +{
> +	int nr = atomic_add_return(1, &emergency_rx_skbs);
> +	int thresh = (3 * ipfrag_skbs()) / 2;
> +	if (nr < thresh)
> +		return 1;
> +
> +	atomic_dec(&emergency_rx_skbs);
> +	return 0;
> +}
> +
> +/**
> + *	sk_adjust_memalloc - adjust the global memalloc reserve for critical RX
> + *	@socks: number of new %SOCK_VMIO sockets
> + *	@tx_resserve_pages: number of pages to (un)reserve for TX
> + *
> + *	This function adjusts the memalloc reserve based on system demand.
> + *	The RX reserve is a limit, and only added once, not for each socket.
> + *
> + *	NOTE:
> + *	   @tx_reserve_pages is an upper-bound of memory used for TX hence
> + *	   we need not account the pages like we do for RX pages.
> + */
> +void sk_adjust_memalloc(int socks, int tx_reserve_pages)
> +{
> +	unsigned long flags;
> +	int reserve = tx_reserve_pages;
> +	int nr_socks;
> +
> +	spin_lock_irqsave(&memalloc_lock, flags);
> +	nr_socks = atomic_add_return(socks, &vmio_socks);
> +	BUG_ON(nr_socks < 0);
> +
> +	if (nr_socks) {
> +		int rx_pages = 2 * ipfrag_pages() + iprt_pages;
> +		reserve += rx_pages - rx_net_reserve;
> +		rx_net_reserve = rx_pages;
> +	} else {
> +		reserve -= rx_net_reserve;
> +		rx_net_reserve = 0;
> +	}
> +
> +	if (reserve)
> +		adjust_memalloc_reserve(reserve);
> +	spin_unlock_irqrestore(&memalloc_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(sk_adjust_memalloc);
> +
> +/*
> + * tiny helper function to track the total ipfragment memory
> + * needed because of modular ipv6
> + */
> +void ipfrag_reserve_memory(int frags)
> +{
> +	ipfrag_threshold += frags;
> +	sk_adjust_memalloc(0, 0);
> +}
> +EXPORT_SYMBOL_GPL(ipfrag_reserve_memory);
> +
> +void iprt_reserve_memory(int pages)
> +{
> +	iprt_pages += pages;
> +	sk_adjust_memalloc(0, 0);
> +}
> +EXPORT_SYMBOL_GPL(iprt_reserve_memory);
> +
> +/**
> + *	sk_set_vmio - sets %SOCK_VMIO
> + *	@sk: socket to set it on
> + *
> + *	Set %SOCK_VMIO on a socket and increase the memalloc reserve
> + *	accordingly.
> + */
> +int sk_set_vmio(struct sock *sk)
> +{
> +	int set = sock_flag(sk, SOCK_VMIO);
> +	if (!set) {
> +		sk_adjust_memalloc(1, 0);
> +		sock_set_flag(sk, SOCK_VMIO);
> +		sk->sk_allocation |= __GFP_EMERGENCY;
> +	}
> +	return !set;
> +}
> +EXPORT_SYMBOL_GPL(sk_set_vmio);
> +
> +int sk_clear_vmio(struct sock *sk)
> +{
> +	int set = sock_flag(sk, SOCK_VMIO);
> +	if (set) {
> +		sk_adjust_memalloc(-1, 0);
> +		sock_reset_flag(sk, SOCK_VMIO);
> +		sk->sk_allocation &= ~__GFP_EMERGENCY;
> +	}
> +	return set;
> +}
> +EXPORT_SYMBOL_GPL(sk_clear_vmio);
> +
>  static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
>  {
>  	struct timeval tv;
> @@ -239,6 +353,12 @@ int sock_queue_rcv_skb(struct sock *sk, 
>  	int err = 0;
>  	int skb_len;
>  
> +	if (unlikely(skb->emergency)) {
> +		if (!sk_has_vmio(sk)) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
> +	} else
>  	/* Cast skb->rcvbuf to unsigned... It's pointless, but reduces
>  	   number of warnings when compiling with -W --ANK
>  	 */
> @@ -868,6 +988,7 @@ void sk_free(struct sock *sk)
>  	struct sk_filter *filter;
>  	struct module *owner = sk->sk_prot_creator->owner;
>  
> +	sk_clear_vmio(sk);
>  	if (sk->sk_destruct)
>  		sk->sk_destruct(sk);
>  
> Index: linux-2.6-git/net/ipv4/ipmr.c
> ===================================================================
> --- linux-2.6-git.orig/net/ipv4/ipmr.c	2007-01-12 12:20:08.000000000 +0100
> +++ linux-2.6-git/net/ipv4/ipmr.c	2007-01-12 12:21:14.000000000 +0100
> @@ -1340,6 +1340,9 @@ int ip_mr_input(struct sk_buff *skb)
>  	struct mfc_cache *cache;
>  	int local = ((struct rtable*)skb->dst)->rt_flags&RTCF_LOCAL;
>  
> +	if (unlikely(skb->emergency))
> +		goto drop;
> +
>  	/* Packet is looped back after forward, it should not be
>  	   forwarded second time, but still can be delivered locally.
>  	 */
> @@ -1411,6 +1414,7 @@ int ip_mr_input(struct sk_buff *skb)
>  dont_forward:
>  	if (local)
>  		return ip_local_deliver(skb);
> +drop:
>  	kfree_skb(skb);
>  	return 0;
>  }
> Index: linux-2.6-git/net/ipv4/sysctl_net_ipv4.c
> ===================================================================
> --- linux-2.6-git.orig/net/ipv4/sysctl_net_ipv4.c	2007-01-12 12:20:08.000000000 +0100
> +++ linux-2.6-git/net/ipv4/sysctl_net_ipv4.c	2007-01-12 12:21:14.000000000 +0100
> @@ -18,6 +18,7 @@
>  #include <net/route.h>
>  #include <net/tcp.h>
>  #include <net/cipso_ipv4.h>
> +#include <net/sock.h>
>  
>  /* From af_inet.c */
>  extern int sysctl_ip_nonlocal_bind;
> @@ -186,6 +187,17 @@ static int strategy_allowed_congestion_c
>  
>  }
>  
> +int proc_dointvec_fragment(ctl_table *table, int write, struct file *filp,
> +		     void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int ret;
> +	int old_thresh = *(int *)table->data;
> +	ret = proc_dointvec(table,write,filp,buffer,lenp,ppos);
> +	ipfrag_reserve_memory(*(int *)table->data - old_thresh);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(proc_dointvec_fragment);
> +
>  ctl_table ipv4_table[] = {
>          {
>  		.ctl_name	= NET_IPV4_TCP_TIMESTAMPS,
> @@ -291,7 +303,7 @@ ctl_table ipv4_table[] = {
>  		.data		= &sysctl_ipfrag_high_thresh,
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
> -		.proc_handler	= &proc_dointvec
> +		.proc_handler	= &proc_dointvec_fragment
>  	},
>  	{
>  		.ctl_name	= NET_IPV4_IPFRAG_LOW_THRESH,
> Index: linux-2.6-git/net/ipv4/tcp_ipv4.c
> ===================================================================
> --- linux-2.6-git.orig/net/ipv4/tcp_ipv4.c	2007-01-12 12:20:07.000000000 +0100
> +++ linux-2.6-git/net/ipv4/tcp_ipv4.c	2007-01-12 12:21:14.000000000 +0100
> @@ -1604,6 +1604,22 @@ csum_err:
>  	goto discard;
>  }
>  
> +static int tcp_v4_backlog_rcv(struct sock *sk, struct sk_buff *skb)
> +{
> +	int ret;
> +	unsigned long pflags = current->flags;
> +	if (unlikely(skb->emergency)) {
> +		BUG_ON(!sk_has_vmio(sk)); /* we dropped those before queueing */
> +		if (!(pflags & PF_MEMALLOC))
> +			current->flags |= PF_MEMALLOC;
> +	}
> +
> +	ret = tcp_v4_do_rcv(sk, skb);
> +
> +	current->flags = pflags;
> +	return ret;

Why don't you want to just setup PF_MEMALLOC for the socket and all
related processes?

> +}
> +
>  /*
>   *	From tcp_input.c
>   */
> @@ -1654,6 +1670,15 @@ int tcp_v4_rcv(struct sk_buff *skb)
>  	if (!sk)
>  		goto no_tcp_socket;
>  
> +	if (unlikely(skb->emergency)) {
> +	       	if (!sk_has_vmio(sk))
> +			goto discard_and_relse;
> +		/*
> +		   decrease window size..
> +		   tcp_enter_quickack_mode(sk);
> +		*/

How does this decrease window size?
Maybe ack scheduling would be better handled by inet_csk_schedule_ack()
or just directly send an ack, which in turn requires allocation, which
can be bound to this received frame processing...


-- 
	Evgeniy Polyakov
