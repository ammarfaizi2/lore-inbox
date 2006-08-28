Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWH1K2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWH1K2W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 06:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWH1K2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 06:28:22 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:58844 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S964783AbWH1K2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 06:28:19 -0400
Subject: Re: [PATCH 1/4] net: VM deadlock avoidance framework
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Indan Zupancic <indan@nul.nu>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>
In-Reply-To: <1396.81.207.0.53.1156559843.squirrel@81.207.0.53>
References: <20060825153946.24271.42758.sendpatchset@twins>
	 <20060825153957.24271.6856.sendpatchset@twins>
	 <1396.81.207.0.53.1156559843.squirrel@81.207.0.53>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 12:22:44 +0200
Message-Id: <1156760564.23000.31.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-26 at 04:37 +0200, Indan Zupancic wrote:
> On Fri, August 25, 2006 17:39, Peter Zijlstra said:
> > @@ -282,7 +282,8 @@ struct sk_buff {
> >  				nfctinfo:3;
> >  	__u8			pkt_type:3,
> >  				fclone:2,
> > -				ipvs_property:1;
> > +				ipvs_property:1,
> > +				emerg:1;
> >  	__be16			protocol;
> 
> Why not 'emergency'? Looks like 'emerge' with a typo now. ;-)

hehe, me lazy, you gentoo ;-)
sed -i -e 's/emerg/emregency/g' -e 's/EMERG/EMERGENCY/g' *.patch

> > @@ -391,6 +391,7 @@ enum sock_flags {
> >  	SOCK_RCVTSTAMP, /* %SO_TIMESTAMP setting */
> >  	SOCK_LOCALROUTE, /* route locally only, %SO_DONTROUTE setting */
> >  	SOCK_QUEUE_SHRUNK, /* write queue has been shrunk recently */
> > +	SOCK_VMIO, /* promise to never block on receive */
> 
> It might be used for IO related to the VM, but that doesn't tell _what_ it does.
> It also does much more than just not blocking on receive, so overal, aren't
> both the vmio name and the comment slightly misleading?

I'm so having trouble with this name; I had SOCK_NONBLOCKING for a
while, but that is a very bad name because nonblocking has this well
defined meaning when talking about sockets, and this is not that.

Hence I came up with the VMIO, because that is the only selecting
criteria for being special. - I'll fix up the comment.

> > +static inline int emerg_rx_pages_try_inc(void)
> > +{
> > +	return atomic_read(&vmio_socks) &&
> > +		atomic_add_unless(&emerg_rx_pages_used, 1, RX_RESERVE_PAGES);
> > +}
> 
> It looks cleaner to move that first check to the caller, as it is often
> redundant and in the other cases makes it more clear what the caller is
> really doing.

Yes, very good suggestion indeed, what was I thinking?!

> > @@ -82,6 +82,7 @@ EXPORT_SYMBOL(zone_table);
> >
> >  static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
> >  int min_free_kbytes = 1024;
> > +int var_free_kbytes;
> 
> Using var_free_pages makes the code slightly simpler, as all that needless
> convertion isn't needed anymore. Perhaps the same is true for min_free_kbytes...

't seems I'm a bit puzzled as to what you mean here.

> 
> > +noskb:
> > +	/* Attempt emergency allocation when RX skb. */
> > +	if (!(flags & SKB_ALLOC_RX))
> > +		goto out;
> 
> So only incoming skb allocation is guaranteed? What about outgoing skbs?
> What am I missing? Or can we sleep then, and increasing var_free_kbytes is
> sufficient to guarantee it?

->sk_allocation |= __GFP_EMERGENCY - will take care of the outgoing
packets. Also, since one only sends a limited number of packets out and
then will wait for answers, we do not need to worry about fragmentation
issues that much in this case.

> > +static void emerg_free_skb(struct kmem_cache *cache, void *objp)
> > +{
> > +	free_page((unsigned long)objp);
> > +	emerg_rx_pages_dec();
> > +}
> > +
> >  /*
> >   *	Free an skbuff by memory without cleaning the state.
> >   */
> > @@ -326,17 +373,21 @@ void kfree_skbmem(struct sk_buff *skb)
> >  {
> >  	struct sk_buff *other;
> >  	atomic_t *fclone_ref;
> > +	void (*free_skb)(struct kmem_cache *, void *);
> >
> >  	skb_release_data(skb);
> > +
> > +	free_skb = skb->emerg ? emerg_free_skb : kmem_cache_free;
> > +
> >  	switch (skb->fclone) {
> >  	case SKB_FCLONE_UNAVAILABLE:
> > -		kmem_cache_free(skbuff_head_cache, skb);
> > +		free_skb(skbuff_head_cache, skb);
> >  		break;
> >
> >  	case SKB_FCLONE_ORIG:
> >  		fclone_ref = (atomic_t *) (skb + 2);
> >  		if (atomic_dec_and_test(fclone_ref))
> > -			kmem_cache_free(skbuff_fclone_cache, skb);
> > +			free_skb(skbuff_fclone_cache, skb);
> >  		break;
> >
> >  	case SKB_FCLONE_CLONE:
> > @@ -349,7 +400,7 @@ void kfree_skbmem(struct sk_buff *skb)
> >  		skb->fclone = SKB_FCLONE_UNAVAILABLE;
> >
> >  		if (atomic_dec_and_test(fclone_ref))
> > -			kmem_cache_free(skbuff_fclone_cache, other);
> > +			free_skb(skbuff_fclone_cache, other);
> >  		break;
> >  	};
> >  }
> 
> I don't have the original code in front of me, but isn't it possible to
> add a "goto free" which has all the freeing in one place? That would get
> rid of the function pointer stuff and emerg_free_skb.

perhaps, yes, however I prefer this one, it allows access to the size.

> > @@ -435,6 +486,17 @@ struct sk_buff *skb_clone(struct sk_buff
> >  		atomic_t *fclone_ref = (atomic_t *) (n + 1);
> >  		n->fclone = SKB_FCLONE_CLONE;
> >  		atomic_inc(fclone_ref);
> > +	} else if (skb->emerg) {
> > +		if (!emerg_rx_pages_try_inc())
> > +			return NULL;
> > +
> > +		n = (void *)__get_free_page(gfp_mask | __GFP_EMERG);
> > +		if (!n) {
> > +			WARN_ON(1);
> > +			emerg_rx_pages_dec();
> > +			return NULL;
> > +		}
> > +		n->fclone = SKB_FCLONE_UNAVAILABLE;
> >  	} else {
> >  		n = kmem_cache_alloc(skbuff_head_cache, gfp_mask);
> >  		if (!n)
> > @@ -470,6 +532,7 @@ struct sk_buff *skb_clone(struct sk_buff
> >  #if defined(CONFIG_IP_VS) || defined(CONFIG_IP_VS_MODULE)
> >  	C(ipvs_property);
> >  #endif
> > +	C(emerg);
> >  	C(protocol);
> >  	n->destructor = NULL;
> >  #ifdef CONFIG_NETFILTER
> > @@ -690,7 +753,21 @@ int pskb_expand_head(struct sk_buff *skb
> >
> >  	size = SKB_DATA_ALIGN(size);
> >
> > -	data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
> > +	if (skb->emerg) {
> > +		if (size + sizeof(struct skb_shared_info) > PAGE_SIZE)
> > +			goto nodata;
> > +
> > +		if (!emerg_rx_pages_try_inc())
> > +			goto nodata;
> > +
> > +		data = (void *)__get_free_page(gfp_mask | __GFP_EMERG);
> > +		if (!data) {
> > +			WARN_ON(1);
> > +			emerg_rx_pages_dec();
> > +			goto nodata;
> > +		}
> 
> There seems to be some pattern occuring here, what about a new function?

D'oh, thanks for pointing out.

> Are these functions only called for incoming skbs? If not, calling
> emerg_rx_pages_try_inc() is the wrong thing to do. A quick search says
> they aren't. Add a RX check? Or is that fixed by SKB_FCLONE_UNAVAILABLE?
> If so, why are skb_clone() and pskb_expand_head() modified at all?
> (Probably ignorance on my end.)

Well, no, however only incoming skbs can have skb->emergency set to
begin with.

> > +/**
> > + *	sk_adjust_memalloc - adjust the global memalloc reserve for critical RX
> > + *	@nr_socks: number of new %SOCK_VMIO sockets
> 
> I don't see a parameter named nr_socks? request_queues isn't docuemnted?
> 
> > + *
> > + *	This function adjusts the memalloc reserve based on system demand.
> > + *	For each %SOCK_VMIO socket this device will reserve enough
> > + *	to send a few large packets (64k) at a time: %TX_RESERVE_PAGES.
> > + *
> > + *	Assumption:
> > + *	 - each %SOCK_VMIO socket will have a %request_queue associated.
> 
> If this is assumed, then why is the request_queue parameter needed?
> 
> > + *
> > + *	NOTE:
> > + *	   %TX_RESERVE_PAGES is an upper-bound of memory used for TX hence
> > + *	   we need not account the pages like we do for %RX_RESERVE_PAGES.
> > + *
> > + *	On top of this comes a one time charge of:
> > + *	  %RX_RESERVE_PAGES pages -
> > + * 		number of pages alloted for emergency skb service to critical
> > + * 		sockets.
> > + */

Gah, obsolete comment again.

> > +int sk_adjust_memalloc(int socks, int request_queues)
> > +{
> > +	unsigned long flags;
> > +	int reserve;
> > +	int nr_socks;
> > +	int err;
> > +
> > +	spin_lock_irqsave(&memalloc_lock, flags);
> > +
> > +	atomic_add(socks, &vmio_socks);
> > +	nr_socks = atomic_read(&vmio_socks);
> 
> nr_socks = atomic_add_return(socks, &vmio_socks);

Ah, I must've been blind, I even had a quick look for such a function.

> > +	BUG_ON(socks < 0);
> 
> Shouldn't this be nr_socks < 0?

Yes.

> > +	vmio_request_queues += request_queues;
> > +
> > +	reserve = vmio_request_queues * TX_RESERVE_PAGES + /* outbound */
> > +		  (!!socks) * RX_RESERVE_PAGES;            /* inbound */
> 
> If the assumption that each VMIO socket will have a request_queue associated
> is true, then we only need to check if vmio_request_queues !=0, right?

I had to break that assumption.

> > +
> > +	err = adjust_memalloc_reserve(reserve - memalloc_reserve);
> > +	if (err) {
> > +		printk(KERN_WARNING
> > +			"Unable to change reserve to: %d pages, error: %d\n",
> > +			reserve, err);
> > +		goto unlock;
> > +	}
> > +	memalloc_reserve = reserve;
> > +
> > +unlock:
> > +	spin_unlock_irqrestore(&memalloc_lock, flags);
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(sk_adjust_memalloc);
> 
> You can get rid of the memalloc_reserve and vmio_request_queues variables
> if you want, they aren't really needed for anything. If using them reduces
> the total code size I'd keep them though.

I find my version easier to read, but that might just be the way my
brain works.

> > +int sk_clear_vmio(struct sock *sk)
> > +{
> > +	int err = 0;
> > +
> > +	if (sock_flag(sk, SOCK_VMIO) &&
> > +			!(err = sk_adjust_memalloc(-1, 0))) {
> > +		sock_reset_flag(sk, SOCK_VMIO);
> > +		sk->sk_allocation &= ~__GFP_EMERG;
> > +	}
> > +
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(sk_clear_vmio);
> 
> It seems wiser to always reset the flags, even if sk_adjust_memalloc fails.

So much for symmetry.

> This patch looks much better than the previous one, not much cruft left.

You seem to have found enough :-(
Thanks though.

