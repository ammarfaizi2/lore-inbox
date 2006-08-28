Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWH1RiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWH1RiI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 13:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWH1RiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 13:38:08 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:52651 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750859AbWH1RiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 13:38:04 -0400
Subject: Re: [PATCH 1/4] net: VM deadlock avoidance framework
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Indan Zupancic <indan@nul.nu>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>
In-Reply-To: <3720.81.207.0.53.1156780999.squirrel@81.207.0.53>
References: <20060825153946.24271.42758.sendpatchset@twins>
	 <20060825153957.24271.6856.sendpatchset@twins>
	 <1396.81.207.0.53.1156559843.squirrel@81.207.0.53>
	 <1156760564.23000.31.camel@twins>
	 <3720.81.207.0.53.1156780999.squirrel@81.207.0.53>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 19:32:24 +0200
Message-Id: <1156786344.23000.47.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 18:03 +0200, Indan Zupancic wrote:
> On Mon, August 28, 2006 12:22, Peter Zijlstra said:

> >> > @@ -391,6 +391,7 @@ enum sock_flags {
> >> >  	SOCK_RCVTSTAMP, /* %SO_TIMESTAMP setting */
> >> >  	SOCK_LOCALROUTE, /* route locally only, %SO_DONTROUTE setting */
> >> >  	SOCK_QUEUE_SHRUNK, /* write queue has been shrunk recently */
> >> > +	SOCK_VMIO, /* promise to never block on receive */
> >>
> >> It might be used for IO related to the VM, but that doesn't tell _what_ it does.
> >> It also does much more than just not blocking on receive, so overal, aren't
> >> both the vmio name and the comment slightly misleading?
> >
> > I'm so having trouble with this name; I had SOCK_NONBLOCKING for a
> > while, but that is a very bad name because nonblocking has this well
> > defined meaning when talking about sockets, and this is not that.
> >
> > Hence I came up with the VMIO, because that is the only selecting
> > criteria for being special. - I'll fix up the comment.
> 
> It's nice and short, but it might be weird if someone after a while finds another way
> of using this stuff. And it's relation to 'emergency' looks unclear. So maybe calling
> both the same makes most sense, no matter how you name it.

I've tried to come up with another use-case, but failed (of course that
doesn't mean there is no). Also, I'm really past caring what the thing
is called ;-) But if ppl object I guess its easy enough to run yet
another sed command over the patches.

> >> > @@ -82,6 +82,7 @@ EXPORT_SYMBOL(zone_table);
> >> >
> >> >  static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
> >> >  int min_free_kbytes = 1024;
> >> > +int var_free_kbytes;
> >>
> >> Using var_free_pages makes the code slightly simpler, as all that needless
> >> convertion isn't needed anymore. Perhaps the same is true for min_free_kbytes...
> >
> > 't seems I'm a bit puzzled as to what you mean here.
> 
> I mean to store the variable reserve in pages instead of kilobytes. Currently you're
> converting from the one to the other both when setting and when using the value. That
> doesn't make much sense and can be avoided by storing the value in pages from the start.

right, will have a peek.

> void kfree_skbmem(struct sk_buff *skb)
> {
> 	struct sk_buff *other;
> 	atomic_t *fclone_ref;
> 	struct kmem_cache *cache = skbuff_head_cache;
> 	struct sk_buff *free = skb;
> 
> 	skb_release_data(skb);
> 	switch (skb->fclone) {
> 	case SKB_FCLONE_UNAVAILABLE:
> 		goto free;
> 
> 	case SKB_FCLONE_ORIG:
> 		fclone_ref = (atomic_t *) (skb + 2);
> 		if (atomic_dec_and_test(fclone_ref)){
> 			cache = skbuff_fclone_cache;
> 			goto free;
> 		}
> 		break;
> 
> 	case SKB_FCLONE_CLONE:
> 		fclone_ref = (atomic_t *) (skb + 1);
> 		other = skb - 1;
> 
> 		/* The clone portion is available for
> 		 * fast-cloning again.
> 		 */
> 		skb->fclone = SKB_FCLONE_UNAVAILABLE;
> 
> 		if (atomic_dec_and_test(fclone_ref)){
> 			cache = skbuff_fclone_cache;
> 			free = other;
> 			goto free;
> 		}
> 		break;
> 	};
> 	return;
> free:
> 	if (!skb->emergency)
> 		kmem_cache_free(cache, free);
> 	else
> 		emergency_rx_free(free, kmem_cache_size(cache));
> }

Ah, like so, sure, that looks good.

> >> You can get rid of the memalloc_reserve and vmio_request_queues variables
> >> if you want, they aren't really needed for anything. If using them reduces
> >> the total code size I'd keep them though.
> >
> > I find my version easier to read, but that might just be the way my
> > brain works.
> 
> Maybe true, but I believe my version is more natural in the sense that it makes
> more clear what the code is doing. Less bookkeeping, more real work, so to speak.

Ok, I'll have another look at it, perhaps my gray matter has shifted ;-)

> But after another look things seem a bit shaky, in the locking corner anyway.
> 
> sk_adjust_memalloc() calls adjust_memalloc_reserve(), which changes var_free_kbytes
> and then calls setup_per_zone_pages_min(), which does the real work. But it reads
> min_free_kbytes without holding any locks. In mainline that's fine as the function
> is only called by the proc handler and in obscure memory hotplug stuff. But with
> your code it can also be called at any moment when a VMIO socket is made, which now
> races with the proc callback. More a theoretical than a real problem, but still
> slightly messy.

Knew about that, hadn't made up my mind on a fix yet. Good spot never
the less. Time to actually fix it I guess.

> adjust_memalloc_reserve() has no locking at all, while it might be called concurrently
> from different sources. Luckily sk_adjust_memalloc() is the only user, and which uses
> its own spinlock for synchronization, so things go well by accident now. It seems
> cleaner to move that spinlock so that it protects var|min_free_kbytes instead.

Ah, no accident there, I'm fully aware that there would need to be a
spinlock in adjust_memalloc_reserve() if there were another caller.
(I even had it there for some time) - added comment.

> +int adjust_memalloc_reserve(int pages)
> +{
> +	int kbytes;
> +	int err = 0;
> +
> +	kbytes = var_free_kbytes + (pages << (PAGE_SHIFT - 10));
> +	if (kbytes < 0) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> 
> Shouldn't that be a BUG_ON instead?

Yeah, might as well be.

