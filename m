Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbVHJX1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbVHJX1d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 19:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbVHJX1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 19:27:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42936 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932595AbVHJX1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 19:27:32 -0400
Date: Wed, 10 Aug 2005 20:22:09 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Rik van Riel <riel@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFT 4/5] CLOCK-Pro page replacement
Message-ID: <20050810232209.GA3809@dmt.cnet>
References: <20050810200216.644997000@jumble.boston.redhat.com> <20050810200943.809832000@jumble.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050810200943.809832000@jumble.boston.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rik,

First of all, this is very nice! The code is amazingly easy to read.

Now the usual ranting:

You change the rate of active list scanning, which I suppose won't
change the current reclaiming behaviour much (at least not on the
"stress system to death" tests which most folks use to test page
replacement policies). I'll do some STP benchmarking.

But the fundamental metric for page replacement decision continues to be
recency alone.

IMHO much deeper surgery is needed: actually use inter-reference
distance as the metric for page replacement decision.

As we talked, I've got an ARC variant working, but from what I gather
so far its not as simple as I've imagined. Direct replacement from the
active list seems to screw up most "stress system to death" workloads,
increasing major pagefaults.

Still lack a set of well analyzed pertinent VM tests... 

On Wed, Aug 10, 2005 at 04:02:20PM -0400, Rik van Riel wrote:
> Implement an approximation to Song Jiang's CLOCK-Pro page replacement
> algorithm.  The algorithm has been extended to handle multiple memory
> zones and, consequently, needed some changes in the active page limit
> readjustment.
> 
> TODO:
>  - verify that things work as expected
>  - figure out where to put new anonymous pages
> 
> More information can be found at:
>  - http://www.cs.wm.edu/hpcs/WWW/HTML/publications/abs05-3.html
>  - http://linux-mm.org/wiki/ClockProApproximation
> 
> Signed-off-by: Rik van Riel <riel@redhat.com>
> 
> Index: linux-2.6.12-vm/include/linux/mmzone.h
> ===================================================================
> --- linux-2.6.12-vm.orig/include/linux/mmzone.h
> +++ linux-2.6.12-vm/include/linux/mmzone.h
> @@ -143,6 +143,8 @@ struct zone {
>  	unsigned long		nr_inactive;
>  	unsigned long		pages_scanned;	   /* since last reclaim */
>  	int			all_unreclaimable; /* All pages pinned */
> +	unsigned long		active_limit;
> +	unsigned long		active_scanned;
>  
>  	/*
>  	 * prev_priority holds the scanning priority for this zone.  It is
> Index: linux-2.6.12-vm/include/linux/swap.h
> ===================================================================
> --- linux-2.6.12-vm.orig/include/linux/swap.h
> +++ linux-2.6.12-vm/include/linux/swap.h
> @@ -154,10 +154,15 @@ extern void out_of_memory(unsigned int _
>  extern void swapin_readahead(swp_entry_t, unsigned long, struct vm_area_struct *);
>  
>  /* linux/mm/nonresident.c */
> -extern int remember_page(struct address_space *, unsigned long);
> +extern int do_remember_page(struct address_space *, unsigned long);
>  extern int recently_evicted(struct address_space *, unsigned long);
>  extern void init_nonresident(void);
>  
> +/* linux/mm/clockpro.c */
> +extern void remember_page(struct page *, struct address_space *, unsigned long);
> +extern int page_is_hot(struct page *, struct address_space *, unsigned long);
> +DECLARE_PER_CPU(unsigned long, evicted_pages);
> +
>  /* linux/mm/page_alloc.c */
>  extern unsigned long totalram_pages;
>  extern unsigned long totalhigh_pages;
> @@ -298,6 +303,9 @@ static inline swp_entry_t get_swap_page(
>  #define remember_page(x,y)	0
>  #define recently_evicted(x,y)	0
>  
> +/* linux/mm/clockpro.c */
> +#define page_is_hot(x,y,z)	0
> +
>  #endif /* CONFIG_SWAP */
>  #endif /* __KERNEL__*/
>  #endif /* _LINUX_SWAP_H */
> Index: linux-2.6.12-vm/mm/Makefile
> ===================================================================
> --- linux-2.6.12-vm.orig/mm/Makefile
> +++ linux-2.6.12-vm/mm/Makefile
> @@ -13,7 +13,7 @@ obj-y			:= bootmem.o filemap.o mempool.o
>  			   prio_tree.o $(mmu-y)
>  
>  obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o \
> -			   nonresident.o
> +			   nonresident.o clockpro.o
>  obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
>  obj-$(CONFIG_NUMA) 	+= mempolicy.o
>  obj-$(CONFIG_SHMEM) += shmem.o
> Index: linux-2.6.12-vm/mm/clockpro.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6.12-vm/mm/clockpro.c
> @@ -0,0 +1,102 @@
> +/*
> + * mm/clockpro.c
> + * (C) 2005 Red Hat, Inc
> + * Written by Rik van Riel <riel@redhat.com>
> + * Released under the GPL, see the file COPYING for details.
> + *
> + * Helper functions to implement CLOCK-Pro page replacement policy.
> + * For details see: http://linux-mm.org/wiki/AdvancedPageReplacement
> + */
> +#include <linux/mm.h>
> +#include <linux/mmzone.h>
> +#include <linux/swap.h>
> +
> +DEFINE_PER_CPU(unsigned long, evicted_pages);
> +static unsigned long get_evicted(void)
> +{
> +	unsigned long total = 0;
> +	int cpu;
> +
> +	for (cpu = first_cpu(cpu_online_map); cpu < NR_CPUS; cpu++)
> +		total += per_cpu(evicted_pages, cpu);
> +
> +	return total;
> +}
> +
> +static unsigned long estimate_pageable_memory(void)
> +{
> +	static unsigned long next_check;
> +	static unsigned long total;
> +	unsigned long active, inactive, free;
> +
> +	if (time_after(jiffies, next_check)) {
> +		get_zone_counts(&active, &inactive, &free);
> +		total = active + inactive + free;
> +		next_check = jiffies + HZ/10;
> +	}
> +
> +	return total;
> +}
> +
> +static void decay_clockpro_variables(void)
> +{
> +	struct zone * zone;
> +	int cpu;
> +
> +	for (cpu = first_cpu(cpu_online_map); cpu < NR_CPUS; cpu++)
> +		per_cpu(evicted_pages, cpu) /= 2;
> +
> +	for_each_zone(zone)
> +		zone->active_scanned /= 2;
> +}
> +
> +int page_is_hot(struct page * page, struct address_space * mapping,
> +		unsigned long index)
> +{
> +	unsigned long long distance;
> +	unsigned long long evicted;
> +	int refault_distance;
> +	struct zone *zone;
> +
> +	/* Was the page recently evicted ? */
> +	refault_distance = recently_evicted(mapping, index);
> +	if (refault_distance < 0)
> +		return 0;
> +
> +	distance = estimate_pageable_memory() + refault_distance;
> +	evicted = get_evicted();
> +	zone = page_zone(page);
> +
> +	/* Only consider recent history for the calculation below. */
> +	if (unlikely(evicted > distance))
> +		decay_clockpro_variables();
> +
> +	/*
> +	 * Estimate whether the inter-reference distance of the tested
> +	 * page is smaller than the inter-reference distance of the
> +	 * oldest page on the active list.
> +	 *
> +	 *  distance        zone->nr_active
> +	 * ---------- <  ----------------------
> +	 *  evicted       zone->active_scanned
> +	 */
> +	if (distance * zone->active_scanned < evicted * zone->nr_active) {
> +		if (zone->active_limit > zone->present_pages / 8)
> +			zone->active_limit--;
> +		return 1;
> +	}
> +
> +	/* Increase the active limit more slowly. */
> +	if ((evicted & 1) && zone->active_limit < zone->present_pages * 7 / 8)
> +		zone->active_limit++;
> +	return 0;
> +}
> +
> +void remember_page(struct page * page, struct address_space * mapping,
> +		unsigned long index)
> +{
> +	struct zone * zone = page_zone(page);
> +	if (do_remember_page(mapping, index) && (index & 1) &&
> +			zone->active_limit < zone->present_pages * 7 / 8)
> +		zone->active_limit++;
> +}
> Index: linux-2.6.12-vm/mm/filemap.c
> ===================================================================
> --- linux-2.6.12-vm.orig/mm/filemap.c
> +++ linux-2.6.12-vm/mm/filemap.c
> @@ -401,9 +401,12 @@ int add_to_page_cache_lru(struct page *p
>  				pgoff_t offset, int gfp_mask)
>  {
>  	int ret = add_to_page_cache(page, mapping, offset, gfp_mask);
> -	recently_evicted(mapping, offset);
> -	if (ret == 0)
> -		lru_cache_add(page);
> +	if (ret == 0) {
> +		if (page_is_hot(page, mapping, offset))
> +			lru_cache_add_active(page);
> +		else
> +			lru_cache_add(page);
> +	}
>  	return ret;
>  }
>  
> Index: linux-2.6.12-vm/mm/nonresident.c
> ===================================================================
> --- linux-2.6.12-vm.orig/mm/nonresident.c
> +++ linux-2.6.12-vm/mm/nonresident.c
> @@ -25,6 +25,7 @@
>  #include <linux/prefetch.h>
>  #include <linux/kernel.h>
>  #include <linux/percpu.h>
> +#include <linux/swap.h>
>  
>  /* Number of non-resident pages per hash bucket. Never smaller than 15. */
>  #if (L1_CACHE_BYTES < 64)
> @@ -101,7 +102,7 @@ int recently_evicted(struct address_spac
>  	return -1;
>  }
>  
> -int remember_page(struct address_space * mapping, unsigned long index)
> +int do_remember_page(struct address_space * mapping, unsigned long index)
>  {
>  	struct nr_bucket * nr_bucket;
>  	u32 nrpage;
> @@ -125,6 +126,7 @@ int remember_page(struct address_space *
>  	preempt_enable();
>  
>  	/* Statistics may want to know whether the entry was in use. */
> +	__get_cpu_var(evicted_pages)++;
>  	return xchg(&nr_bucket->page[i], nrpage);
>  }
>  
> Index: linux-2.6.12-vm/mm/page_alloc.c
> ===================================================================
> --- linux-2.6.12-vm.orig/mm/page_alloc.c
> +++ linux-2.6.12-vm/mm/page_alloc.c
> @@ -1715,6 +1715,7 @@ static void __init free_area_init_core(s
>  		zone->nr_scan_inactive = 0;
>  		zone->nr_active = 0;
>  		zone->nr_inactive = 0;
> +		zone->active_limit = zone->present_pages * 2 / 3;
>  		if (!size)
>  			continue;
>  
> Index: linux-2.6.12-vm/mm/swap_state.c
> ===================================================================
> --- linux-2.6.12-vm.orig/mm/swap_state.c
> +++ linux-2.6.12-vm/mm/swap_state.c
> @@ -323,6 +323,7 @@ struct page *read_swap_cache_async(swp_e
>  			struct vm_area_struct *vma, unsigned long addr)
>  {
>  	struct page *found_page, *new_page = NULL;
> +	int active;
>  	int err;
>  
>  	do {
> @@ -344,7 +345,7 @@ struct page *read_swap_cache_async(swp_e
>  				break;		/* Out of memory */
>  		}
>  
> -		recently_evicted(&swapper_space, entry.val);
> +		active = page_is_hot(new_page, &swapper_space, entry.val);
>  
>  		/*
>  		 * Associate the page with swap entry in the swap cache.
> @@ -361,7 +362,10 @@ struct page *read_swap_cache_async(swp_e
>  			/*
>  			 * Initiate read into locked page and return.
>  			 */
> -			lru_cache_add_active(new_page);
> +			if (active) {
> +				lru_cache_add_active(new_page);
> +			} else
> +				lru_cache_add(new_page);
>  			swap_readpage(NULL, new_page);
>  			return new_page;
>  		}
> Index: linux-2.6.12-vm/mm/vmscan.c
> ===================================================================
> --- linux-2.6.12-vm.orig/mm/vmscan.c
> +++ linux-2.6.12-vm/mm/vmscan.c
> @@ -355,12 +355,14 @@ static int shrink_list(struct list_head 
>  	while (!list_empty(page_list)) {
>  		struct address_space *mapping;
>  		struct page *page;
> +		struct zone *zone;
>  		int may_enter_fs;
>  		int referenced;
>  
>  		cond_resched();
>  
>  		page = lru_to_page(page_list);
> +		zone = page_zone(page);
>  		list_del(&page->lru);
>  
>  		if (TestSetPageLocked(page))
> @@ -492,7 +494,7 @@ static int shrink_list(struct list_head 
>  #ifdef CONFIG_SWAP
>  		if (PageSwapCache(page)) {
>  			swp_entry_t swap = { .val = page->private };
> -			remember_page(&swapper_space, page->private);
> +			remember_page(page, &swapper_space, page->private);
>  			__delete_from_swap_cache(page);
>  			write_unlock_irq(&mapping->tree_lock);
>  			swap_free(swap);
> @@ -501,7 +503,7 @@ static int shrink_list(struct list_head 
>  		}
>  #endif /* CONFIG_SWAP */
>  
> -		remember_page(page->mapping, page->index);
> +		remember_page(page, page->mapping, page->index);
>  		__remove_from_page_cache(page);
>  		write_unlock_irq(&mapping->tree_lock);
>  		__put_page(page);
> @@ -684,6 +686,7 @@ refill_inactive_zone(struct zone *zone, 
>  	pgmoved = isolate_lru_pages(nr_pages, &zone->active_list,
>  				    &l_hold, &pgscanned);
>  	zone->pages_scanned += pgscanned;
> +	zone->active_scanned += pgscanned;
>  	zone->nr_active -= pgmoved;
>  	spin_unlock_irq(&zone->lru_lock);
>  
> @@ -799,10 +802,15 @@ shrink_zone(struct zone *zone, struct sc
>  	unsigned long nr_inactive;
>  
>  	/*
> -	 * Add one to `nr_to_scan' just to make sure that the kernel will
> -	 * slowly sift through the active list.
> +	 * Scan the active list if we have too many active pages.
> +	 * The limit is automatically adjusted through refaults
> +	 * measuring how well the VM did in the past.
>  	 */
> -	zone->nr_scan_active += (zone->nr_active >> sc->priority) + 1;
> +	if (zone->nr_active > zone->active_limit)
> +		zone->nr_scan_active += zone->nr_active - zone->active_limit;
> +	else if (sc->priority < DEF_PRIORITY - 2)
> +		zone->nr_scan_active += (zone->nr_active >> sc->priority) + 1;
> +
>  	nr_active = zone->nr_scan_active;
>  	if (nr_active >= sc->swap_cluster_max)
>  		zone->nr_scan_active = 0;
> 
> --
> -- 
> All Rights Reversed
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
