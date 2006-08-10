Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161286AbWHJOqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161286AbWHJOqa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 10:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161282AbWHJOqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 10:46:30 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:4121 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161283AbWHJOq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 10:46:29 -0400
Subject: Re: [RFC][PATCH] VM deadlock prevention core -v3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       netdev <netdev@vger.kernel.org>, Daniel Phillips <phillips@google.com>,
       David Miller <davem@davemloft.net>, Thomas Graf <tgraf@suug.ch>,
       Indan Zupancic <indan@nul.nu>
In-Reply-To: <20060810140240.GA28989@2ka.mipt.ru>
References: <1155216769.5696.23.camel@twins>
	 <20060810140240.GA28989@2ka.mipt.ru>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 16:46:31 +0200
Message-Id: <1155221191.5696.43.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 18:02 +0400, Evgeniy Polyakov wrote:
> On Thu, Aug 10, 2006 at 03:32:49PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> > Hi,
> 
> Hello, Peter.
> 
> > So I try again, please tell me if I'm still on crack and should go detox.
> > However if you do so, I kindly request some words on the how and why of it.
> 
> I think you should talk with doctor in that case, but not with kernel
> hackers :)
> 
> I have some comments about implementation, not overall design, since we
> have slightly diametral points of view there.
> 
> ....
> 
> > --- linux-2.6.orig/net/core/skbuff.c
> > +++ linux-2.6/net/core/skbuff.c
> > @@ -43,6 +43,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/sched.h>
> >  #include <linux/mm.h>
> > +#include <linux/pagemap.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/in.h>
> >  #include <linux/inet.h>
> > @@ -125,6 +126,8 @@ EXPORT_SYMBOL(skb_truesize_bug);
> >   *
> >   */
> >  
> > +#define ceiling_log2(x)	fls((x) - 1)
> > +
> >  /**
> >   *	__alloc_skb	-	allocate a network buffer
> >   *	@size: size to allocate
> > @@ -147,6 +150,59 @@ struct sk_buff *__alloc_skb(unsigned int
> >  	struct sk_buff *skb;
> >  	u8 *data;
> >  
> > +	size = SKB_DATA_ALIGN(size);

I moved it here.

> > +
> > +	if (gfp_mask & __GFP_MEMALLOC) {
> > +		/*
> > +		 * Fallback allocation for memalloc reserves.
> > +

		 * This allocator is build on alloc_pages() so that freed
		 * skbuffs return to the memalloc reserve imediately. SLAB
		 * memory might not ever be returned.

This was missing,... 

> > +		 * the page is populated like so:
> > +		 *
> > +		 *   struct sk_buff
> > +		 *   [ struct sk_buff ]
> > +		 *   [ atomic_t ]
> > +		 *   unsigned int
> > +		 *   struct skb_shared_info
> > +		 *   char []
> > +		 *
> > +		 * We have to do higher order allocations for icky jumbo
> > +		 * frame drivers :-(. They really should be migrated to
> > +		 * scather/gather DMA and use skb fragments.
> > +		 */
> > +		unsigned int data_offset =
> > +			sizeof(struct sk_buff) + sizeof(unsigned int);
> > +		unsigned long length = size + data_offset +
> > +			sizeof(struct skb_shared_info);
> > +		unsigned int pages;
> > +		unsigned int order;
> > +		struct page *page;
> > +		void *kaddr;
> > +
> > +		/*
> > +		 * Force fclone alloc in order to fudge a lacking in skb_clone().
> > +		 */
> > +		fclone = 1;
> > +		if (fclone) {
> > +			data_offset += sizeof(struct sk_buff) + sizeof(atomic_t);
> > +			length += sizeof(struct sk_buff) + sizeof(atomic_t);
> > +		}
> > +		pages = (length + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > +		order = ceiling_log2(pages);
> > +		skb = NULL;
> > +		if (!(page = alloc_pages(gfp_mask & ~__GFP_HIGHMEM, order)))
> > +			goto out;
> > +
> > +		kaddr = pfn_to_kaddr(page_to_pfn(page));
> > +		skb = (struct sk_buff *)kaddr;
> > +
> > +		*((unsigned int *)(kaddr + data_offset -
> > +					sizeof(unsigned int))) = order;
> > +		data = (u8 *)(kaddr + data_offset);
> > +
> 
> Tricky, but since you are using own allocator here, you could change it to
> be not so aggressive - i.e. do not round size to number of pages.

I'm not sure I follow you, I'm explicitly using
alloc_pages()/free_page(), if
I were to go smart here, I'd loose the whole reason for doing so.

> 
> > +		goto allocated;
> > +	}
> > +
> >  	cache = fclone ? skbuff_fclone_cache : skbuff_head_cache;
> >  
> >  	/* Get the HEAD */
> > @@ -155,12 +211,13 @@ struct sk_buff *__alloc_skb(unsigned int
> >  		goto out;
> >  
> >  	/* Get the DATA. Size must match skb_add_mtu(). */
> > -	size = SKB_DATA_ALIGN(size);
> 
> Bad sign.

See above.

> >  	data = ____kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
> >  	if (!data)
> >  		goto nodata;
> >  
> > +struct sk_buff *__netdev_alloc_skb(struct net_device *dev,
> > +		unsigned length, gfp_t gfp_mask)
> > +{
> > +	struct sk_buff *skb;
> > +
> > +	WARN_ON(gfp_mask & (__GFP_NOMEMALLOC | __GFP_MEMALLOC));
> > +	gfp_mask &= ~(__GFP_NOMEMALLOC | __GFP_MEMALLOC);
> > +
> > +	skb = ___netdev_alloc_skb(dev, length, gfp_mask | __GFP_NOMEMALLOC);
> > +	if (skb)
> > +		goto done;
> > +
> > +	if (atomic_read(&dev->rx_reserve_used) >=
> > +			dev->rx_reserve * dev->memalloc_socks)
> > +		goto out;
> > +
> > +	/*
> > +	 * pre-inc guards against a race with netdev_wait_memalloc()
> > +	 */
> > +	atomic_inc(&dev->rx_reserve_used);
> > +	skb = ___netdev_alloc_skb(dev, length, gfp_mask | __GFP_MEMALLOC);
> > +	if (unlikely(!skb)) {
> > +		atomic_dec(&dev->rx_reserve_used);
> > +		goto out;
> > +	}
> 
> Since you have added atomic operation in that path, you can use device's
> reference counter instead and do not care that it can dissapear.

Is that the sole reason taking a reference on the device is bad?

> > @@ -434,6 +567,12 @@ struct sk_buff *skb_clone(struct sk_buff
> >  		n->fclone = SKB_FCLONE_CLONE;
> >  		atomic_inc(fclone_ref);
> >  	} else {
> > +		/*
> > +		 * should we special-case skb->memalloc cloning?
> > +		 * for now fudge it by forcing fast-clone alloc.
> > +		 */
> > +		BUG_ON(skb->memalloc);
> > +
> >  		n = kmem_cache_alloc(skbuff_head_cache, gfp_mask);
> >  		if (!n)
> >  			return NULL;
> 
> Ugh... cloning is a one of the shoulders of giant where Linux network
> stack is staying...

Yes, I'm aware of that, I have a plan to fix this, however I haven't had
time
to implement it. My immediate concern is the point wrt. the net_device
mapping.

My idea was: instead of the order, store the size, and allocate clone 
skbuffs in the available room at the end of the page(s), allocating
extra pages
if needed.

> > @@ -686,6 +825,8 @@ int pskb_expand_head(struct sk_buff *skb
> >  	if (skb_shared(skb))
> >  		BUG();
> >  
> > +	BUG_ON(skb->memalloc);
> > +
> >  	size = SKB_DATA_ALIGN(size);
> >  
> >  	data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
> 
> And that is a bug.
> That operation can happen even with usual receiving processing.

Yes, more allocator work..

> > Index: linux-2.6/net/ipv4/af_inet.c
> > ===================================================================
> > --- linux-2.6.orig/net/ipv4/af_inet.c
> > +++ linux-2.6/net/ipv4/af_inet.c
> > @@ -132,6 +132,14 @@ void inet_sock_destruct(struct sock *sk)
> >  {
> >  	struct inet_sock *inet = inet_sk(sk);
> >  
> > +	if (sk_is_memalloc(sk)) {
> > +		struct net_device *dev = ip_dev_find(inet->rcv_saddr);
> > +		if (dev) {
> > +			dev_adjust_memalloc(dev, -1);
> > +			dev_put(dev);
> > +		}
> > +	}
> > +
> 
> This looks very strange - you decrement reference counter both in socket
> destruction code and in netdevice destruction code.

This is the right place; however I was not sure net_device destruction
implied
destruction of all related sockets; in case that is not so, you will
have to
clean up there, because this destructor will not find the device any
longer.

Thanks for the feedback.


