Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWDYPjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWDYPjk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 11:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWDYPjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 11:39:40 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:13502 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751246AbWDYPjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 11:39:39 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Tue, 25 Apr 2006 17:39:12 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, Linux PM <linux-pm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <nigel@suspend2.net>
References: <200604242355.08111.rjw@sisk.pl> <444DF9B3.7080600@yahoo.com.au>
In-Reply-To: <444DF9B3.7080600@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604251739.13377.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First, thanks for reviewing.

On Tuesday 25 April 2006 12:28, Nick Piggin wrote:
> pageRafael J. Wysocki wrote:
> 
> > Index: linux-2.6.17-rc1-mm3/mm/rmap.c
> > ===================================================================
> > --- linux-2.6.17-rc1-mm3.orig/mm/rmap.c	2006-04-22 10:34:33.000000000 +0200
> > +++ linux-2.6.17-rc1-mm3/mm/rmap.c	2006-04-23 00:41:19.000000000 +0200
> > @@ -851,3 +851,22 @@ int try_to_unmap(struct page *page, int 
> >  	return ret;
> >  }
> >  
> > +#ifdef CONFIG_SOFTWARE_SUSPEND
> > +int page_mapped_by_current(struct page *page)
> > +{
> > +	struct vm_area_struct *vma;
> > +	int ret = 0;
> > +
> > +	spin_lock(&current->mm->page_table_lock);
> > +
> > +	for (vma = current->mm->mmap; vma; vma = vma->vm_next)
> > +		if (page_address_in_vma(page, vma) != -EFAULT) {
> > +			ret = 1;
> > +			break;
> > +		}
> > +
> > +	spin_unlock(&current->mm->page_table_lock);
> > +
> > +	return ret;
> > +}
> > +#endif /* CONFIG_SOFTWARE_SUSPEND */
> 
> Why not just pass in the task struct? It might make the interface more
> useful elsewhere.

Good idea, I'll do that.

> > Index: linux-2.6.17-rc1-mm3/include/linux/rmap.h
> > ===================================================================
> > --- linux-2.6.17-rc1-mm3.orig/include/linux/rmap.h	2006-04-22 10:34:33.000000000 +0200
> > +++ linux-2.6.17-rc1-mm3/include/linux/rmap.h	2006-04-22 10:34:45.000000000 +0200
> > @@ -104,6 +104,12 @@ pte_t *page_check_address(struct page *,
> >   */
> >  unsigned long page_address_in_vma(struct page *, struct vm_area_struct *);
> >  
> > +#ifdef CONFIG_SOFTWARE_SUSPEND
> > +int page_mapped_by_current(struct page *);
> > +#else
> > +static inline int page_mapped_by_current(struct page *page) { return 0; }
> > +#endif /* CONFIG_SOFTWARE_SUSPEND */
> 
> This just wrong. What if some random unrelated code calls
> page_mapped_by_current? You should only fold inlines if their result
> folds accordingly.
> 
> For now just leave it out completely if !CONFIG_SOFTWARE_SUSPEND.

OK

>   > -unsigned int count_data_pages(void)
> > +/**
> > + *	need_to_copy - determine if a page needs to be copied before saving.
> > + *	Returns false if the page can be saved without copying.
> > + */
> > +
> > +static int need_to_copy(struct page *page)
> > +{
> > +	if (!PageLRU(page) || PageCompound(page))
> > +		return 1;
> > +	if (page_mapped(page))
> > +		return page_mapped_by_current(page);
> > +
> > +	return 1;
> > +}
> 
> I'd much rather VM internal type stuff get moved *out* of kernel/power :(

Well, I kind of agree, but I don't know where to place it under mm/.

> It needs more comments too. Also, how important is it for the page to be
> off the LRU?

Hm, I'm not sure if that's what you're asking about, but the pages off the LRU
are handled in a usual way, ie. copied when snapshotting the system.  The
pages _on_ the LRU may be included in the snapshot image without
copying, but I require them additionally to be (a) mapped by someone and
(b) not mapped by the current task.

> What if kswapd has taken it off the LRU temporarily (or is it 
> guanteed not to at this point)? What if it is in an lru_add pagevec?

At this point kswapd is frozen as well as everything else except for the
current task (ie. us).  IOW no one is expected to process the LRU lists.

> > +
> > +unsigned int count_data_pages(unsigned int *total)
> >  {
> >  	struct zone *zone;
> >  	unsigned long zone_pfn;
> > -	unsigned int n = 0;
> > +	unsigned int n, m;
> >  
> > +	n = m = 0;
> >  	for_each_zone (zone) {
> >  		if (is_highmem(zone))
> >  			continue;
> >  		mark_free_pages(zone);
> > -		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
> > -			n += saveable(zone, &zone_pfn);
> > +		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
> > +			unsigned long pfn = zone_pfn + zone->zone_start_pfn;
> > +
> > +			if (saveable(pfn)) {
> > +				n++;
> > +				if (!need_to_copy(pfn_to_page(pfn)))
> > +					m++;
> > +			}
> > +		}
> >  	}
> > -	return n;
> > +	if (total)
> > +		*total = n;
> > +
> > +	return n - m;
> >  }
> 
> Maybe we could add some commenting to these functions while changing them
> around.

OK, I will.

> > +static LIST_HEAD(active_pages);
> > +static LIST_HEAD(inactive_pages);
> > +
> > +/**
> > + *	protect_data_pages - move data pages that need to be protected from
> > + *	being reclaimed out of their respective LRU lists
> > + */
> > +
> > +static void protect_data_pages(struct pbe *pblist)
> > +{
> > +	struct pbe *p;
> > +
> > +	for_each_pbe (p, pblist)
> > +		if (p->address == p->orig_address) {
> > +			struct page *page = virt_to_page(p->address);
> > +			struct zone *zone = page_zone(page);
> > +
> > +			spin_lock(&zone->lru_lock);
> > +			if (PageActive(page)) {
> > +				del_page_from_active_list(zone, page);
> > +				list_add(&page->lru, &active_pages);
> > +			} else {
> > +				del_page_from_inactive_list(zone, page);
> > +				list_add(&page->lru, &inactive_pages);
> > +			}
> > +			spin_unlock(&zone->lru_lock);
> > +			ClearPageLRU(page);
> > +		}
> > +}
> 
> a) How do you know the page is on the LRU?

Because in copy_data_pages() p->address is only set to p->orig_address for
pages that are on the LRU.  No one can change the state of the pages in
between because everyone else is frozen and we have local IRQs disabled.

> b) Why are you clearing PageLRU outside the spinlock?

Well, good question. ;-)  Moreover it seems I don't need to acquire the
spinlock at all, because this is done on one CPU with IRQs disabled and the
other tasks frozen.

> c) This code isn't going outside mm/ even if it is correct.

OK, so could you please suggest me where to put it (or a corrected version)
under mm/?

> d) swsusp seems to be quite under documented as far as race conditions
>     vs the rest of the kernel go. In some places only a single CPU is
>     running with interrupts off, in other places all processes have
>     frozen, etc. etc. So it is hard to even know if synchronisation is
>     correct or not.
> 
>     Suggest more documentation goes into this.

OK

> > +
> > +/**
> > + *	restore_active_inactive_lists - if suspend fails, the pages protected
> > + *	with protect_data_pages() have to be moved back to their respective
> > + *	lists
> > + */
> > +
> > +static void restore_active_inactive_lists(void)
> 
> Ditto, mostly.
> 
> > +static int enough_free_mem(unsigned int nr_pages, unsigned int copy_pages)
> >  {
> >  	struct zone *zone;
> > -	unsigned int n = 0;
> > +	long n = 0;
> > +
> > +	pr_debug("swsusp: pages needed: %u + %lu + %lu, free: %u\n",
> > +		 copy_pages,
> > +		 (nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE,
> > +		 EXTRA_PAGES, nr_free_pages());
> >  
> >  	for_each_zone (zone)
> > -		if (!is_highmem(zone))
> > +		if (!is_highmem(zone) && populated_zone(zone)) {
> >  			n += zone->free_pages;
> > -	pr_debug("swsusp: available memory: %u pages\n", n);
> > -	return n > (nr_pages + PAGES_FOR_IO +
> > -		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
> > -}
> > -
> > -static int alloc_data_pages(struct pbe *pblist, gfp_t gfp_mask, int safe_needed)
> > -{
> > -	struct pbe *p;
> > +			n -= zone->lowmem_reserve[ZONE_NORMAL];
> 
> Comment for this? Eg. why are you taking the ZONE_NORMAL watermark
> in particular?

This is to sync enough_free_mem() with swsusp_shrink_memory() (in swsusp.c).
[We allocate with GFP_ATOMIC ie. from the normal zone and the lowmem reserves
in the lower zones are effectively unavailable to us because of the check in
zone_watermark_ok().]

Thanks a lot for the comments.  I'll do my best to follow your suggestions
in the next version of the patch.

Greetings,
Rafael
