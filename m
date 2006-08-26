Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751576AbWHZChv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbWHZChv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 22:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWHZChv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 22:37:51 -0400
Received: from helium.samage.net ([83.149.67.129]:65161 "EHLO
	helium.samage.net") by vger.kernel.org with ESMTP id S1750733AbWHZChu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 22:37:50 -0400
Message-ID: <1396.81.207.0.53.1156559843.squirrel@81.207.0.53>
In-Reply-To: <20060825153957.24271.6856.sendpatchset@twins>
References: <20060825153946.24271.42758.sendpatchset@twins>
    <20060825153957.24271.6856.sendpatchset@twins>
Date: Sat, 26 Aug 2006 04:37:23 +0200 (CEST)
Subject: Re: [PATCH 1/4] net: VM deadlock avoidance framework
From: "Indan Zupancic" <indan@nul.nu>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
       "Daniel Phillips" <phillips@google.com>,
       "Rik van Riel" <riel@redhat.com>, "David Miller" <davem@davemloft.net>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, August 25, 2006 17:39, Peter Zijlstra said:
> @@ -282,7 +282,8 @@ struct sk_buff {
>  				nfctinfo:3;
>  	__u8			pkt_type:3,
>  				fclone:2,
> -				ipvs_property:1;
> +				ipvs_property:1,
> +				emerg:1;
>  	__be16			protocol;

Why not 'emergency'? Looks like 'emerge' with a typo now. ;-)


> @@ -391,6 +391,7 @@ enum sock_flags {
>  	SOCK_RCVTSTAMP, /* %SO_TIMESTAMP setting */
>  	SOCK_LOCALROUTE, /* route locally only, %SO_DONTROUTE setting */
>  	SOCK_QUEUE_SHRUNK, /* write queue has been shrunk recently */
> +	SOCK_VMIO, /* promise to never block on receive */

It might be used for IO related to the VM, but that doesn't tell _what_ it does.
It also does much more than just not blocking on receive, so overal, aren't
both the vmio name and the comment slightly misleading?


> +static inline int emerg_rx_pages_try_inc(void)
> +{
> +	return atomic_read(&vmio_socks) &&
> +		atomic_add_unless(&emerg_rx_pages_used, 1, RX_RESERVE_PAGES);
> +}

It looks cleaner to move that first check to the caller, as it is often
redundant and in the other cases makes it more clear what the caller is
really doing.


> @@ -82,6 +82,7 @@ EXPORT_SYMBOL(zone_table);
>
>  static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
>  int min_free_kbytes = 1024;
> +int var_free_kbytes;

Using var_free_pages makes the code slightly simpler, as all that needless
convertion isn't needed anymore. Perhaps the same is true for min_free_kbytes...


> +noskb:
> +	/* Attempt emergency allocation when RX skb. */
> +	if (!(flags & SKB_ALLOC_RX))
> +		goto out;

So only incoming skb allocation is guaranteed? What about outgoing skbs?
What am I missing? Or can we sleep then, and increasing var_free_kbytes is
sufficient to guarantee it?


> +
> +	if (size + sizeof(struct skb_shared_info) > PAGE_SIZE)
> +		goto out;
> +
> +	if (!emerg_rx_pages_try_inc())
> +		goto out;
> +
> +	skb = (void *)__get_free_page(gfp_mask | __GFP_EMERG);
> +	if (!skb) {
> +		WARN_ON(1); /* we were promised memory but didn't get it? */
> +		goto dec_out;
> +	}
> +
> +	if (!emerg_rx_pages_try_inc())
> +		goto skb_free_out;
> +
> +	data = (void *)__get_free_page(gfp_mask | __GFP_EMERG);
> +	if (!data) {
> +		WARN_ON(1); /* we were promised memory but didn't get it? */
> +		emerg_rx_pages_dec();
> +skb_free_out:
> +		free_page((unsigned long)skb);
> +		skb = NULL;
> +dec_out:
> +		emerg_rx_pages_dec();
> +		goto out;
> +	}
> +
> +	cache = NULL;
> +	goto allocated;
>  }
>
>  /**
> @@ -267,7 +304,7 @@ struct sk_buff *__netdev_alloc_skb(struc
>  {
>  	struct sk_buff *skb;
>
> -	skb = alloc_skb(length + NET_SKB_PAD, gfp_mask);
> +	skb = __alloc_skb(length + NET_SKB_PAD, gfp_mask, SKB_ALLOC_RX);
>  	if (likely(skb)) {
>  		skb_reserve(skb, NET_SKB_PAD);
>  		skb->dev = dev;
> @@ -315,10 +352,20 @@ static void skb_release_data(struct sk_b
>  		if (skb_shinfo(skb)->frag_list)
>  			skb_drop_fraglist(skb);
>
> -		kfree(skb->head);
> +		if (skb->emerg) {
> +			free_page((unsigned long)skb->head);
> +			emerg_rx_pages_dec();
> +		} else
> +			kfree(skb->head);
>  	}
>  }
>
> +static void emerg_free_skb(struct kmem_cache *cache, void *objp)
> +{
> +	free_page((unsigned long)objp);
> +	emerg_rx_pages_dec();
> +}
> +
>  /*
>   *	Free an skbuff by memory without cleaning the state.
>   */
> @@ -326,17 +373,21 @@ void kfree_skbmem(struct sk_buff *skb)
>  {
>  	struct sk_buff *other;
>  	atomic_t *fclone_ref;
> +	void (*free_skb)(struct kmem_cache *, void *);
>
>  	skb_release_data(skb);
> +
> +	free_skb = skb->emerg ? emerg_free_skb : kmem_cache_free;
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
> @@ -349,7 +400,7 @@ void kfree_skbmem(struct sk_buff *skb)
>  		skb->fclone = SKB_FCLONE_UNAVAILABLE;
>
>  		if (atomic_dec_and_test(fclone_ref))
> -			kmem_cache_free(skbuff_fclone_cache, other);
> +			free_skb(skbuff_fclone_cache, other);
>  		break;
>  	};
>  }

I don't have the original code in front of me, but isn't it possible to
add a "goto free" which has all the freeing in one place? That would get
rid of the function pointer stuff and emerg_free_skb.


> @@ -435,6 +486,17 @@ struct sk_buff *skb_clone(struct sk_buff
>  		atomic_t *fclone_ref = (atomic_t *) (n + 1);
>  		n->fclone = SKB_FCLONE_CLONE;
>  		atomic_inc(fclone_ref);
> +	} else if (skb->emerg) {
> +		if (!emerg_rx_pages_try_inc())
> +			return NULL;
> +
> +		n = (void *)__get_free_page(gfp_mask | __GFP_EMERG);
> +		if (!n) {
> +			WARN_ON(1);
> +			emerg_rx_pages_dec();
> +			return NULL;
> +		}
> +		n->fclone = SKB_FCLONE_UNAVAILABLE;
>  	} else {
>  		n = kmem_cache_alloc(skbuff_head_cache, gfp_mask);
>  		if (!n)
> @@ -470,6 +532,7 @@ struct sk_buff *skb_clone(struct sk_buff
>  #if defined(CONFIG_IP_VS) || defined(CONFIG_IP_VS_MODULE)
>  	C(ipvs_property);
>  #endif
> +	C(emerg);
>  	C(protocol);
>  	n->destructor = NULL;
>  #ifdef CONFIG_NETFILTER
> @@ -690,7 +753,21 @@ int pskb_expand_head(struct sk_buff *skb
>
>  	size = SKB_DATA_ALIGN(size);
>
> -	data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
> +	if (skb->emerg) {
> +		if (size + sizeof(struct skb_shared_info) > PAGE_SIZE)
> +			goto nodata;
> +
> +		if (!emerg_rx_pages_try_inc())
> +			goto nodata;
> +
> +		data = (void *)__get_free_page(gfp_mask | __GFP_EMERG);
> +		if (!data) {
> +			WARN_ON(1);
> +			emerg_rx_pages_dec();
> +			goto nodata;
> +		}

There seems to be some pattern occuring here, what about a new function?

Are these functions only called for incoming skbs? If not, calling
emerg_rx_pages_try_inc() is the wrong thing to do. A quick search says
they aren't. Add a RX check? Or is that fixed by SKB_FCLONE_UNAVAILABLE?
If so, why are skb_clone() and pskb_expand_head() modified at all?
(Probably ignorance on my end.)


> +	} else
> +		data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
>  	if (!data)
>  		goto nodata;
>
> Index: linux-2.6/net/ipv4/icmp.c
> ===================================================================
> --- linux-2.6.orig/net/ipv4/icmp.c
> +++ linux-2.6/net/ipv4/icmp.c
> @@ -938,6 +938,9 @@ int icmp_rcv(struct sk_buff *skb)
>  			goto error;
>  	}
>
> +	if (unlikely(skb->emerg))
> +		goto drop;
> +
>  	if (!pskb_pull(skb, sizeof(struct icmphdr)))
>  		goto error;
>
> Index: linux-2.6/net/ipv4/tcp_ipv4.c
> ===================================================================
> --- linux-2.6.orig/net/ipv4/tcp_ipv4.c
> +++ linux-2.6/net/ipv4/tcp_ipv4.c
> @@ -1093,6 +1093,9 @@ int tcp_v4_rcv(struct sk_buff *skb)
>  	if (!sk)
>  		goto no_tcp_socket;
>
> +	if (unlikely(skb->emerg && !sk_is_vmio(sk)))
> +		goto discard_and_relse;
> +
>  process:
>  	if (sk->sk_state == TCP_TIME_WAIT)
>  		goto do_time_wait;
> Index: linux-2.6/net/ipv4/udp.c
> ===================================================================
> --- linux-2.6.orig/net/ipv4/udp.c
> +++ linux-2.6/net/ipv4/udp.c
> @@ -1136,7 +1136,12 @@ int udp_rcv(struct sk_buff *skb)
>  	sk = udp_v4_lookup(saddr, uh->source, daddr, uh->dest, skb->dev->ifindex);
>
>  	if (sk != NULL) {
> -		int ret = udp_queue_rcv_skb(sk, skb);
> +		int ret;
> +
> +		if (unlikely(skb->emerg && !sk_is_vmio(sk)))
> +			goto drop_noncritical;
> +
> +		ret = udp_queue_rcv_skb(sk, skb);
>  		sock_put(sk);
>
>  		/* a return value > 0 means to resubmit the input, but
> @@ -1147,6 +1152,7 @@ int udp_rcv(struct sk_buff *skb)
>  		return 0;
>  	}
>
> +drop_noncritical:
>  	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
>  		goto drop;
>  	nf_reset(skb);
> Index: linux-2.6/net/ipv4/af_inet.c
> ===================================================================
> --- linux-2.6.orig/net/ipv4/af_inet.c
> +++ linux-2.6/net/ipv4/af_inet.c
> @@ -132,6 +132,9 @@ void inet_sock_destruct(struct sock *sk)
>  {
>  	struct inet_sock *inet = inet_sk(sk);
>
> +	if (sk_is_vmio(sk))
> +		sk_clear_vmio(sk);
> +
>  	__skb_queue_purge(&sk->sk_receive_queue);
>  	__skb_queue_purge(&sk->sk_error_queue);
>
> Index: linux-2.6/net/core/sock.c
> ===================================================================
> --- linux-2.6.orig/net/core/sock.c
> +++ linux-2.6/net/core/sock.c
> @@ -111,6 +111,7 @@
>  #include <linux/poll.h>
>  #include <linux/tcp.h>
>  #include <linux/init.h>
> +#include <linux/blkdev.h>
>
>  #include <asm/uaccess.h>
>  #include <asm/system.h>
> @@ -195,6 +196,102 @@ __u32 sysctl_rmem_default = SK_RMEM_MAX;
>  /* Maximal space eaten by iovec or ancilliary data plus some space */
>  int sysctl_optmem_max = sizeof(unsigned long)*(2*UIO_MAXIOV + 512);
>
> +static DEFINE_SPINLOCK(memalloc_lock);
> +static int memalloc_reserve;
> +static unsigned int vmio_request_queues;
> +
> +atomic_t vmio_socks;
> +atomic_t emerg_rx_pages_used;
> +EXPORT_SYMBOL_GPL(vmio_socks);
> +EXPORT_SYMBOL_GPL(emerg_rx_pages_used);
> +
> +/**
> + *	sk_adjust_memalloc - adjust the global memalloc reserve for critical RX
> + *	@nr_socks: number of new %SOCK_VMIO sockets

I don't see a parameter named nr_socks? request_queues isn't docuemnted?

> + *
> + *	This function adjusts the memalloc reserve based on system demand.
> + *	For each %SOCK_VMIO socket this device will reserve enough
> + *	to send a few large packets (64k) at a time: %TX_RESERVE_PAGES.
> + *
> + *	Assumption:
> + *	 - each %SOCK_VMIO socket will have a %request_queue associated.

If this is assumed, then why is the request_queue parameter needed?

> + *
> + *	NOTE:
> + *	   %TX_RESERVE_PAGES is an upper-bound of memory used for TX hence
> + *	   we need not account the pages like we do for %RX_RESERVE_PAGES.
> + *
> + *	On top of this comes a one time charge of:
> + *	  %RX_RESERVE_PAGES pages -
> + * 		number of pages alloted for emergency skb service to critical
> + * 		sockets.
> + */
> +int sk_adjust_memalloc(int socks, int request_queues)
> +{
> +	unsigned long flags;
> +	int reserve;
> +	int nr_socks;
> +	int err;
> +
> +	spin_lock_irqsave(&memalloc_lock, flags);
> +
> +	atomic_add(socks, &vmio_socks);
> +	nr_socks = atomic_read(&vmio_socks);

nr_socks = atomic_add_return(socks, &vmio_socks);

> +	BUG_ON(socks < 0);

Shouldn't this be nr_socks < 0?

> +	vmio_request_queues += request_queues;
> +
> +	reserve = vmio_request_queues * TX_RESERVE_PAGES + /* outbound */
> +		  (!!socks) * RX_RESERVE_PAGES;            /* inbound */

If the assumption that each VMIO socket will have a request_queue associated
is true, then we only need to check if vmio_request_queues !=0, right?

> +
> +	err = adjust_memalloc_reserve(reserve - memalloc_reserve);
> +	if (err) {
> +		printk(KERN_WARNING
> +			"Unable to change reserve to: %d pages, error: %d\n",
> +			reserve, err);
> +		goto unlock;
> +	}
> +	memalloc_reserve = reserve;
> +
> +unlock:
> +	spin_unlock_irqrestore(&memalloc_lock, flags);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(sk_adjust_memalloc);

You can get rid of the memalloc_reserve and vmio_request_queues variables
if you want, they aren't really needed for anything. If using them reduces
the total code size I'd keep them though.

int sk_adjust_memalloc(int socks, int request_queues)
{
	unsigned long flags;
	int reserve;
	int nr_socks;
	int err;

	spin_lock_irqsave(&memalloc_lock, flags);

	nr_socks = atomic_add_return(socks, &vmio_socks);
	BUG_ON(nr_socks < 0);

	reserve = request_queues * TX_RESERVE_PAGES; /* outbound */

	/* Check if this were the first socks: */
	if (nr_socks - socks == 0)
		reserve += RX_RESERVE_PAGES;            /* inbound */
	/* Or the last: */
	else if (nr_socks == 0)
		reserve -= RX_RESERVE_PAGES;

	err = adjust_memalloc_reserve(reserve);
	if (err) {
		printk(KERN_WARNING
			"Unable to adjust reserve by %d pages, error: %d\n",
			reserve, err);
		goto unlock;
	}

unlock:
	spin_unlock_irqrestore(&memalloc_lock, flags);
	return err;
}

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
> +	int err = 0;
> +
> +	if (!sock_flag(sk, SOCK_VMIO) &&
> +			!(err = sk_adjust_memalloc(1, 0))) {
> +		sock_set_flag(sk, SOCK_VMIO);
> +		sk->sk_allocation |= __GFP_EMERG;
> +	}
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(sk_set_vmio);
> +
> +int sk_clear_vmio(struct sock *sk)
> +{
> +	int err = 0;
> +
> +	if (sock_flag(sk, SOCK_VMIO) &&
> +			!(err = sk_adjust_memalloc(-1, 0))) {
> +		sock_reset_flag(sk, SOCK_VMIO);
> +		sk->sk_allocation &= ~__GFP_EMERG;
> +	}
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(sk_clear_vmio);

It seems wiser to always reset the flags, even if sk_adjust_memalloc fails.

This patch looks much better than the previous one, not much cruft left.

Greetings,

Indan


