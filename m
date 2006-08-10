Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161453AbWHJQum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161453AbWHJQum (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161455AbWHJQum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:50:42 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:1260 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161453AbWHJQul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:50:41 -0400
Subject: Re: [RFC][PATCH] VM deadlock prevention core -v3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       netdev <netdev@vger.kernel.org>, Daniel Phillips <phillips@google.com>,
       David Miller <davem@davemloft.net>, Thomas Graf <tgraf@suug.ch>,
       Indan Zupancic <indan@nul.nu>
In-Reply-To: <20060810162229.GA27364@2ka.mipt.ru>
References: <1155216769.5696.23.camel@twins>
	 <20060810140240.GA28989@2ka.mipt.ru> <1155221191.5696.43.camel@twins>
	 <20060810162229.GA27364@2ka.mipt.ru>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 18:50:40 +0200
Message-Id: <1155228640.5696.55.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > Tricky, but since you are using own allocator here, you could change it to
> > > be not so aggressive - i.e. do not round size to number of pages.
> > 
> > I'm not sure I follow you, I'm explicitly using
> > alloc_pages()/free_page(), if
> > I were to go smart here, I'd loose the whole reason for doing so.
> 
> You can use page to put there several skbs for example or at least add
> there a fclone (fast clone).

fclone support is there.

> > > > +struct sk_buff *__netdev_alloc_skb(struct net_device *dev,
> > > > +		unsigned length, gfp_t gfp_mask)
> > > > +{
> > > > +	struct sk_buff *skb;
> > > > +
> > > > +	WARN_ON(gfp_mask & (__GFP_NOMEMALLOC | __GFP_MEMALLOC));
> > > > +	gfp_mask &= ~(__GFP_NOMEMALLOC | __GFP_MEMALLOC);
> > > > +
> > > > +	skb = ___netdev_alloc_skb(dev, length, gfp_mask | __GFP_NOMEMALLOC);
> > > > +	if (skb)
> > > > +		goto done;
> > > > +
> > > > +	if (atomic_read(&dev->rx_reserve_used) >=
> > > > +			dev->rx_reserve * dev->memalloc_socks)
> > > > +		goto out;
> > > > +
> > > > +	/*
> > > > +	 * pre-inc guards against a race with netdev_wait_memalloc()
> > > > +	 */
> > > > +	atomic_inc(&dev->rx_reserve_used);
> > > > +	skb = ___netdev_alloc_skb(dev, length, gfp_mask | __GFP_MEMALLOC);
> > > > +	if (unlikely(!skb)) {
> > > > +		atomic_dec(&dev->rx_reserve_used);
> > > > +		goto out;
> > > > +	}
> > > 
> > > Since you have added atomic operation in that path, you can use device's
> > > reference counter instead and do not care that it can dissapear.
> > 
> > Is that the sole reason taking a reference on the device is bad?
> 
> Taking a reference is bad due to performance reasons, since atomic
> increment is not that cheap. If you do it for one variable for the
> purpose of reference counting you can use device's refcnt istead, which
> will solve some races.

Yes, I understand you. However I'm not sure if performance is the only
reason not to take a refcount on the device. Anyway, I think I have just
been convinced to abandon the per device thing and go global.

> > > > @@ -434,6 +567,12 @@ struct sk_buff *skb_clone(struct sk_buff
> > > >  		n->fclone = SKB_FCLONE_CLONE;
> > > >  		atomic_inc(fclone_ref);
> > > >  	} else {
> > > > +		/*
> > > > +		 * should we special-case skb->memalloc cloning?
> > > > +		 * for now fudge it by forcing fast-clone alloc.
> > > > +		 */
> > > > +		BUG_ON(skb->memalloc);
> > > > +
> > > >  		n = kmem_cache_alloc(skbuff_head_cache, gfp_mask);
> > > >  		if (!n)
> > > >  			return NULL;
> > > 
> > > Ugh... cloning is a one of the shoulders of giant where Linux network
> > > stack is staying...
> > 
> > Yes, I'm aware of that, I have a plan to fix this, however I haven't had
> > time
> > to implement it. My immediate concern is the point wrt. the net_device
> > mapping.
> > 
> > My idea was: instead of the order, store the size, and allocate clone 
> > skbuffs in the available room at the end of the page(s), allocating
> > extra pages
> > if needed.
> 
> You can check if requested skb with fclone fits allocated pages, and if
> so use fclone magic, otherwise postpone clone allocation until it is
> required.

Yes the fclone magic works, however that will only let you have one
clone.
I'm just not confident no receive path will ever exceed that.

> Sockets can live without network devices at all, I expect it is enough
> to clean up in socket destructor, since packets can come from
> different devices into the same socket.

You are right if the reserve wasn't device bound - which I will abandon 
because you are right that with multi-path routing, bridge device and 
other advanced goodies this scheme is broken in that there is no
unambiguous
mapping from sockets to devices.

