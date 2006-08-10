Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161293AbWHJODa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161293AbWHJODa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 10:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161342AbWHJODa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 10:03:30 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:14284 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1161340AbWHJOD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 10:03:28 -0400
Date: Thu, 10 Aug 2006 18:02:40 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       netdev <netdev@vger.kernel.org>, Daniel Phillips <phillips@google.com>,
       David Miller <davem@davemloft.net>, Thomas Graf <tgraf@suug.ch>,
       Indan Zupancic <indan@nul.nu>
Subject: Re: [RFC][PATCH] VM deadlock prevention core -v3
Message-ID: <20060810140240.GA28989@2ka.mipt.ru>
References: <1155216769.5696.23.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1155216769.5696.23.camel@twins>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 10 Aug 2006 18:02:42 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 03:32:49PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> Hi,

Hello, Peter.

> So I try again, please tell me if I'm still on crack and should go detox.
> However if you do so, I kindly request some words on the how and why of it.

I think you should talk with doctor in that case, but not with kernel
hackers :)

I have some comments about implementation, not overall design, since we
have slightly diametral points of view there.

...

> --- linux-2.6.orig/net/core/skbuff.c
> +++ linux-2.6/net/core/skbuff.c
> @@ -43,6 +43,7 @@
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <linux/mm.h>
> +#include <linux/pagemap.h>
>  #include <linux/interrupt.h>
>  #include <linux/in.h>
>  #include <linux/inet.h>
> @@ -125,6 +126,8 @@ EXPORT_SYMBOL(skb_truesize_bug);
>   *
>   */
>  
> +#define ceiling_log2(x)	fls((x) - 1)
> +
>  /**
>   *	__alloc_skb	-	allocate a network buffer
>   *	@size: size to allocate
> @@ -147,6 +150,59 @@ struct sk_buff *__alloc_skb(unsigned int
>  	struct sk_buff *skb;
>  	u8 *data;
>  
> +	size = SKB_DATA_ALIGN(size);
> +
> +	if (gfp_mask & __GFP_MEMALLOC) {
> +		/*
> +		 * Fallback allocation for memalloc reserves.
> +		 *
> +		 * the page is populated like so:
> +		 *
> +		 *   struct sk_buff
> +		 *   [ struct sk_buff ]
> +		 *   [ atomic_t ]
> +		 *   unsigned int
> +		 *   struct skb_shared_info
> +		 *   char []
> +		 *
> +		 * We have to do higher order allocations for icky jumbo
> +		 * frame drivers :-(. They really should be migrated to
> +		 * scather/gather DMA and use skb fragments.
> +		 */
> +		unsigned int data_offset =
> +			sizeof(struct sk_buff) + sizeof(unsigned int);
> +		unsigned long length = size + data_offset +
> +			sizeof(struct skb_shared_info);
> +		unsigned int pages;
> +		unsigned int order;
> +		struct page *page;
> +		void *kaddr;
> +
> +		/*
> +		 * Force fclone alloc in order to fudge a lacking in skb_clone().
> +		 */
> +		fclone = 1;
> +		if (fclone) {
> +			data_offset += sizeof(struct sk_buff) + sizeof(atomic_t);
> +			length += sizeof(struct sk_buff) + sizeof(atomic_t);
> +		}
> +		pages = (length + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +		order = ceiling_log2(pages);
> +		skb = NULL;
> +		if (!(page = alloc_pages(gfp_mask & ~__GFP_HIGHMEM, order)))
> +			goto out;
> +
> +		kaddr = pfn_to_kaddr(page_to_pfn(page));
> +		skb = (struct sk_buff *)kaddr;
> +
> +		*((unsigned int *)(kaddr + data_offset -
> +					sizeof(unsigned int))) = order;
> +		data = (u8 *)(kaddr + data_offset);
> +

Tricky, but since you are using own allocator here, you could change it to
be not so aggressive - i.e. do not round size to number of pages.

> +		goto allocated;
> +	}
> +
>  	cache = fclone ? skbuff_fclone_cache : skbuff_head_cache;
>  
>  	/* Get the HEAD */
> @@ -155,12 +211,13 @@ struct sk_buff *__alloc_skb(unsigned int
>  		goto out;
>  
>  	/* Get the DATA. Size must match skb_add_mtu(). */
> -	size = SKB_DATA_ALIGN(size);

Bad sign.

>  	data = ____kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
>  	if (!data)
>  		goto nodata;
>  
> +struct sk_buff *__netdev_alloc_skb(struct net_device *dev,
> +		unsigned length, gfp_t gfp_mask)
> +{
> +	struct sk_buff *skb;
> +
> +	WARN_ON(gfp_mask & (__GFP_NOMEMALLOC | __GFP_MEMALLOC));
> +	gfp_mask &= ~(__GFP_NOMEMALLOC | __GFP_MEMALLOC);
> +
> +	skb = ___netdev_alloc_skb(dev, length, gfp_mask | __GFP_NOMEMALLOC);
> +	if (skb)
> +		goto done;
> +
> +	if (atomic_read(&dev->rx_reserve_used) >=
> +			dev->rx_reserve * dev->memalloc_socks)
> +		goto out;
> +
> +	/*
> +	 * pre-inc guards against a race with netdev_wait_memalloc()
> +	 */
> +	atomic_inc(&dev->rx_reserve_used);
> +	skb = ___netdev_alloc_skb(dev, length, gfp_mask | __GFP_MEMALLOC);
> +	if (unlikely(!skb)) {
> +		atomic_dec(&dev->rx_reserve_used);
> +		goto out;
> +	}

Since you have added atomic operation in that path, you can use device's
reference counter instead and do not care that it can dissapear.

> +done:
> +	skb->dev = dev;
> +out:
> +	return skb;
> +}
> +
>  static void skb_drop_list(struct sk_buff **listp)
>  {
>  	struct sk_buff *list = *listp;
> @@ -313,10 +417,35 @@ static void skb_release_data(struct sk_b
>  		if (skb_shinfo(skb)->frag_list)
>  			skb_drop_fraglist(skb);
>  
> -		kfree(skb->head);
> +		if (!skb->memalloc)
> +			kfree(skb->head);
> +		skb->head = NULL;
>  	}
>  }
>  
> +/**
> + *	free_skb_pages - frees a memalloced skbuff
> + *	@cache: fake %kmem_cache argument
> + *	@objp: %sk_buff pointer
> + *
> + *	Function is made to look like %kmem_cache_free so we can easily
> + *	substitue the free function in %kfree_skbmem.
> + */
> +static void free_skb_pages(struct kmem_cache *cache, void *objp)
> +{
> +	struct sk_buff *skb = (struct sk_buff *)objp;
> +	/*
> +	 * The input_dev is the initial input device;
> +	 * we have it pinned by virtue of rx_reserve_used not being zero.
> +	 */
> +	struct net_device *dev = skb->input_dev ?: skb->dev;
> +	unsigned int order =
> +		*(unsigned int *)(skb->head - sizeof(unsigned int));
> +	if (!skb->head)
> +		atomic_dec(&dev->rx_reserve_used);
> +	free_pages((unsigned long)skb, order);
> +}
> +
>  /*
>   *	Free an skbuff by memory without cleaning the state.
>   */
> @@ -324,17 +453,21 @@ void kfree_skbmem(struct sk_buff *skb)
>  {
>  	struct sk_buff *other;
>  	atomic_t *fclone_ref;
> +	void (*free_skb)(struct kmem_cache *, void *);
>  
>  	skb_release_data(skb);
> +
> +	free_skb = skb->memalloc ? free_skb_pages : kmem_cache_free;
> +
>  	switch (skb->fclone) {
>  	case SKB_FCLONE_UNAVAILABLE:
> -		kmem_cache_free(skbuff_head_cache, skb);
> +		free_skb(skbuff_head_cache, skb);
>  		break;
>  
>  	case SKB_FCLONE_ORIG:
>  		fclone_ref = (atomic_t *) (skb + 2);
>  		if (atomic_dec_and_test(fclone_ref))
> -			kmem_cache_free(skbuff_fclone_cache, skb);
> +			free_skb(skbuff_fclone_cache, skb);
>  		break;
>  
>  	case SKB_FCLONE_CLONE:
> @@ -347,7 +480,7 @@ void kfree_skbmem(struct sk_buff *skb)
>  		skb->fclone = SKB_FCLONE_UNAVAILABLE;
>  
>  		if (atomic_dec_and_test(fclone_ref))
> -			kmem_cache_free(skbuff_fclone_cache, other);
> +			free_skb(skbuff_fclone_cache, other);
>  		break;
>  	};
>  }
> @@ -434,6 +567,12 @@ struct sk_buff *skb_clone(struct sk_buff
>  		n->fclone = SKB_FCLONE_CLONE;
>  		atomic_inc(fclone_ref);
>  	} else {
> +		/*
> +		 * should we special-case skb->memalloc cloning?
> +		 * for now fudge it by forcing fast-clone alloc.
> +		 */
> +		BUG_ON(skb->memalloc);
> +
>  		n = kmem_cache_alloc(skbuff_head_cache, gfp_mask);
>  		if (!n)
>  			return NULL;

Ugh... cloning is a one of the shoulders of giant where Linux network
stack is staying...

> @@ -686,6 +825,8 @@ int pskb_expand_head(struct sk_buff *skb
>  	if (skb_shared(skb))
>  		BUG();
>  
> +	BUG_ON(skb->memalloc);
> +
>  	size = SKB_DATA_ALIGN(size);
>  
>  	data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);

And that is a bug.
That operation can happen even with usual receiving processing.

> +/**
> + *	dev_adjust_memalloc - adjust the global memalloc reserve for this device
> + *	@dev: device that has memalloc demands
> + *	@nr_socks: number of new %SOCK_MEMALLOC sockets
> + *
> + *	This function adjusts the memalloc reserve based on device
> + *	demand. For each %SOCK_MEMALLOC socket this device will reserve
> + *	2 * %MAX_PHYS_SEGMENTS pages for outbound traffic (assumption:
> + *	each %SOCK_MEMALLOC socket will have a %request_queue associated)
> + *	and @dev->rx_reserve mtu pages.
> + */
> +int dev_adjust_memalloc(struct net_device *dev, int nr_socks)
> +{
> +	unsigned long flags;
> +	unsigned long reserve;
> +	int err;
> +
> +	spin_lock_irqsave(&dev->memalloc_lock, flags);
> +
> +	dev->memalloc_socks += nr_socks;
> +	BUG_ON(dev->memalloc_socks < 0);
> +
> +	reserve = dev->memalloc_socks *
> +		(2 * MAX_PHYS_SEGMENTS +		 /* outbound */
> +		 dev->rx_reserve * mtu_pages(dev->mtu)); /* inbound */
> +
> +	err = adjust_memalloc_reserve(reserve - dev->memalloc_reserve);
> +	if (err) {
> +		printk(KERN_WARNING
> +			"%s: Unable to change RX reserve to: %lu, error: %d\n",
> +			dev->name, reserve, err);
> +		goto unlock;
> +	}
> +	dev->memalloc_reserve = reserve;
> +
> +unlock:
> +	spin_unlock_irqrestore(&dev->memalloc_lock, flags);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(dev_adjust_memalloc);
>  
>  /*
>   *	Device change register/unregister. These are not inline or static
> @@ -2464,6 +2527,9 @@ int dev_set_mtu(struct net_device *dev, 
>  		err = dev->change_mtu(dev, new_mtu);
>  	else
>  		dev->mtu = new_mtu;
> +
> +	dev_adjust_memalloc(dev, 0);
> +
>  	if (!err && dev->flags & IFF_UP)
>  		raw_notifier_call_chain(&netdev_chain,
>  				NETDEV_CHANGEMTU, dev);
> @@ -2900,6 +2966,7 @@ int register_netdevice(struct net_device
>  #ifdef CONFIG_NET_CLS_ACT
>  	spin_lock_init(&dev->ingress_lock);
>  #endif
> +	spin_lock_init(&dev->memalloc_lock);
>  
>  	ret = alloc_divert_blk(dev);
>  	if (ret)
> @@ -3106,6 +3173,28 @@ static void netdev_wait_allrefs(struct n
>  	}
>  }
>  
> +/* netdev_wait_memalloc - wait for all outstanding memalloc skbs
> + *
> + * This is called when unregistering network devices.
> + *
> + * Better make sure the skb -> dev mapping is correct, if we leak
> + * some this will stall forever.
> + */
> +static void netdev_wait_memalloc(struct net_device *dev)
> +{
> +	unsigned long warning_time = jiffies;
> +	while (atomic_read(&dev->rx_reserve_used) != 0) {
> +		msleep(250);
> +		if (time_after(jiffies, warning_time + 10 * HZ)) {
> +			printk(KERN_EMERG "netdev_wait_memalloc: "
> +			       "waiting for %s to become free. SKB "
> +			       "count = %d\n",
> +			       dev->name, atomic_read(&dev->rx_reserve_used));
> +			warning_time = jiffies;
> +		}
> +	}
> +}
> +
>  /* The sequence is:
>   *
>   *	rtnl_lock();
> @@ -3165,6 +3254,14 @@ void netdev_run_todo(void)
>  
>  		netdev_wait_allrefs(dev);
>  
> +		netdev_wait_memalloc(dev);
> +
> +		/* Get rid of any SOCK_MEMALLOC reserves. */
> +		if (dev->memalloc_reserve) {
> +			BUG_ON(!dev->memalloc_socks);
> +			dev_adjust_memalloc(dev, -dev->memalloc_socks);
> +		}
> +
>  		/* paranoia */
>  		BUG_ON(atomic_read(&dev->refcnt));
>  		BUG_TRAP(!dev->ip_ptr);
> Index: linux-2.6/net/ipv4/af_inet.c
> ===================================================================
> --- linux-2.6.orig/net/ipv4/af_inet.c
> +++ linux-2.6/net/ipv4/af_inet.c
> @@ -132,6 +132,14 @@ void inet_sock_destruct(struct sock *sk)
>  {
>  	struct inet_sock *inet = inet_sk(sk);
>  
> +	if (sk_is_memalloc(sk)) {
> +		struct net_device *dev = ip_dev_find(inet->rcv_saddr);
> +		if (dev) {
> +			dev_adjust_memalloc(dev, -1);
> +			dev_put(dev);
> +		}
> +	}
> +

This looks very strange - you decrement reference counter both in socket
destruction code and in netdevice destruction code.

-- 
	Evgeniy Polyakov
