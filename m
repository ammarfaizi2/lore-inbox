Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbWARQNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWARQNx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbWARQNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:13:53 -0500
Received: from hera.kernel.org ([140.211.167.34]:62596 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030367AbWARQNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:13:52 -0500
Date: Wed, 18 Jan 2006 12:13:46 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       David Miller <davem@davemloft.net>
Subject: Re: [patch 3/3] mm: PageActive no testset
Message-ID: <20060118141346.GB7048@dmt.cnet>
References: <20060118024106.10241.69438.sendpatchset@linux.site> <20060118024139.10241.73020.sendpatchset@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118024139.10241.73020.sendpatchset@linux.site>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Wed, Jan 18, 2006 at 11:40:58AM +0100, Nick Piggin wrote:
> PG_active is protected by zone->lru_lock, it does not need TestSet/TestClear
> operations.

page->flags bits (including PG_active and PG_lru bits) are touched by
several codepaths which do not hold zone->lru_lock. 

AFAICT zone->lru_lock guards access to the LRU list, and no more than
that.

Moreover, what about consistency of the rest of page->flags bits?

PPC for example implements test_and_set_bit() with:

	lwarx	reg, addr   (load and create reservation for 32-bit addr)
	or 	reg, BITOP_MASK(nr)	
	stwcx	reg, addr  (store word upon reservation validation, otherwise loop)

If you don't use atomic operations on page->flags, unrelated bits other
than that you're working with can have their updates lost, given that 
in reality page->flags is not protected by the lru_lock.

For example:

/*
 * shrink_list adds the number of reclaimed pages to sc->nr_reclaimed
 */
static int shrink_list(struct list_head *page_list, struct scan_control *sc)
{
...
                BUG_ON(PageActive(page));
...
activate_locked:
                SetPageActive(page);
                pgactivate++;
keep_locked:
                unlock_page(page);
keep:
                list_add(&page->lru, &ret_pages);
                BUG_ON(PageLRU(page));
}

And recently:

#ifdef CONFIG_MIGRATION
static inline void move_to_lru(struct page *page)
{
        list_del(&page->lru);
        if (PageActive(page)) {
                /*
                 * lru_cache_add_active checks that
                 * the PG_active bit is off.
                 */ 
                ClearPageActive(page);
                lru_cache_add_active(page);

Not relying on zone->lru_lock allows interesting optimizations
such as moving active/inactive pgflag bit setting from inside
__pagevec_lru_add/__pagevec_lru_add_active to the caller, and merging
the two.

Comments?


> Signed-off-by: Nick Piggin <npiggin@suse.de>
> 
> Index: linux-2.6/mm/vmscan.c
> ===================================================================
> --- linux-2.6.orig/mm/vmscan.c
> +++ linux-2.6/mm/vmscan.c
> @@ -997,8 +997,9 @@ refill_inactive_zone(struct zone *zone, 
>  		prefetchw_prev_lru_page(page, &l_inactive, flags);
>  		BUG_ON(PageLRU(page));
>  		SetPageLRU(page);
> -		if (!TestClearPageActive(page))
> -			BUG();
> +		BUG_ON(!PageActive(page));
> +		ClearPageActive(page);
> +
>  		list_move(&page->lru, &zone->inactive_list);
>  		pgmoved++;
>  		if (!pagevec_add(&pvec, page)) {
> Index: linux-2.6/mm/swap.c
> ===================================================================
> --- linux-2.6.orig/mm/swap.c
> +++ linux-2.6/mm/swap.c
> @@ -356,8 +356,8 @@ void __pagevec_lru_add_active(struct pag
>  		}
>  		BUG_ON(PageLRU(page));
>  		SetPageLRU(page);
> -		if (TestSetPageActive(page))
> -			BUG();
> +		BUG_ON(PageActive(page));
> +		SetPageActive(page);
>  		add_page_to_active_list(zone, page);
>  	}
>  	if (zone)
> Index: linux-2.6/include/linux/page-flags.h
> ===================================================================
> --- linux-2.6.orig/include/linux/page-flags.h
> +++ linux-2.6/include/linux/page-flags.h
> @@ -251,8 +251,6 @@ extern void __mod_page_state_offset(unsi
>  #define PageActive(page)	test_bit(PG_active, &(page)->flags)
>  #define SetPageActive(page)	set_bit(PG_active, &(page)->flags)
>  #define ClearPageActive(page)	clear_bit(PG_active, &(page)->flags)
> -#define TestClearPageActive(page) test_and_clear_bit(PG_active, &(page)->flags)
> -#define TestSetPageActive(page) test_and_set_bit(PG_active, &(page)->flags)
>  
>  #define PageSlab(page)		test_bit(PG_slab, &(page)->flags)
>  #define SetPageSlab(page)	set_bit(PG_slab, &(page)->flags)
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
