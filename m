Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbVHISat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbVHISat (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 14:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbVHISat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 14:30:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22158 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964922AbVHISat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 14:30:49 -0400
Date: Tue, 9 Aug 2005 15:25:17 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Rik van Riel <riel@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/3] non-resident page tracking
Message-ID: <20050809182517.GA20644@dmt.cnet>
References: <20050808201416.450491000@jumble.boston.redhat.com> <20050808202110.744344000@jumble.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808202110.744344000@jumble.boston.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rik,

Two hopefully useful comments:

i) ARC and its variants requires additional information about page
replacement (namely whether the page has been reclaimed from the L1 or
L2 lists).

How costly would it be to add this information to the hash table?

ii) From my reading of the patch, the provided "distance" information is
relative to each hash bucket. I'm unable to understand the distance metric
being useful if measured per-hash-bucket instead of globally?

PS: Since remember_page() is always called with the zone->lru_lock held,
the preempt_disable/enable pair is unecessary at the moment... still, 
might be better to leave it there for safety reasons.

On Mon, Aug 08, 2005 at 04:14:17PM -0400, Rik van Riel wrote:
> Track non-resident pages through a simple hashing scheme.  This way
> the space overhead is limited to 1 u32 per page, or 0.1% space overhead
> and lookups are one cache miss.
> 
> Aside from seeing whether or not a page was recently evicted, we can
> also take a reasonable guess at how many other pages were evicted since
> this page was evicted.
> 
> Signed-off-by: Rik van Riel <riel@redhat.com>
> 
> Index: linux-2.6.12-vm/include/linux/swap.h
> ===================================================================
> --- linux-2.6.12-vm.orig/include/linux/swap.h
> +++ linux-2.6.12-vm/include/linux/swap.h
> @@ -153,6 +153,11 @@ extern void out_of_memory(unsigned int _
>  /* linux/mm/memory.c */
>  extern void swapin_readahead(swp_entry_t, unsigned long, struct vm_area_struct *);
>  
> +/* linux/mm/nonresident.c */
> +extern int remember_page(struct address_space *, unsigned long);
> +extern int recently_evicted(struct address_space *, unsigned long);
> +extern void init_nonresident(void);
> +
>  /* linux/mm/page_alloc.c */
>  extern unsigned long totalram_pages;
>  extern unsigned long totalhigh_pages;
> @@ -288,6 +293,11 @@ static inline swp_entry_t get_swap_page(
>  #define grab_swap_token()  do { } while(0)
>  #define has_swap_token(x) 0
>  
> +/* linux/mm/nonresident.c */
> +#define init_nonresident()	do { } while (0)
> +#define remember_page(x,y)	0
> +#define recently_evicted(x,y)	0
> +
>  #endif /* CONFIG_SWAP */
>  #endif /* __KERNEL__*/
>  #endif /* _LINUX_SWAP_H */
> Index: linux-2.6.12-vm/init/main.c
> ===================================================================
> --- linux-2.6.12-vm.orig/init/main.c
> +++ linux-2.6.12-vm/init/main.c
> @@ -47,6 +47,7 @@
>  #include <linux/rmap.h>
>  #include <linux/mempolicy.h>
>  #include <linux/key.h>
> +#include <linux/swap.h>
>  
>  #include <asm/io.h>
>  #include <asm/bugs.h>
> @@ -488,6 +489,7 @@ asmlinkage void __init start_kernel(void
>  	}
>  #endif
>  	vfs_caches_init_early();
> +	init_nonresident();
>  	mem_init();
>  	kmem_cache_init();
>  	numa_policy_init();
> Index: linux-2.6.12-vm/mm/Makefile
> ===================================================================
> --- linux-2.6.12-vm.orig/mm/Makefile
> +++ linux-2.6.12-vm/mm/Makefile
> @@ -12,7 +12,8 @@ obj-y			:= bootmem.o filemap.o mempool.o
>  			   readahead.o slab.o swap.o truncate.o vmscan.o \
>  			   prio_tree.o $(mmu-y)
>  
> -obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
> +obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o \
> +			   nonresident.o
>  obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
>  obj-$(CONFIG_NUMA) 	+= mempolicy.o
>  obj-$(CONFIG_SHMEM) += shmem.o
> Index: linux-2.6.12-vm/mm/nonresident.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6.12-vm/mm/nonresident.c
> @@ -0,0 +1,157 @@
> +/*
> + * mm/nonresident.c
> + * (C) 2004,2005 Red Hat, Inc
> + * Written by Rik van Riel <riel@redhat.com>
> + * Released under the GPL, see the file COPYING for details.
> + *
> + * Keeps track of whether a non-resident page was recently evicted
> + * and should be immediately promoted to the active list. This also
> + * helps automatically tune the inactive target.
> + *
> + * The pageout code stores a recently evicted page in this cache
> + * by calling remember_page(mapping/mm, index/vaddr, generation)
> + * and can look it up in the cache by calling recently_evicted()
> + * with the same arguments.
> + *
> + * Note that there is no way to invalidate pages after eg. truncate
> + * or exit, we let the pages fall out of the non-resident set through
> + * normal replacement.
> + */
> +#include <linux/mm.h>
> +#include <linux/cache.h>
> +#include <linux/spinlock.h>
> +#include <linux/bootmem.h>
> +#include <linux/hash.h>
> +#include <linux/prefetch.h>
> +#include <linux/kernel.h>
> +
> +/* Number of non-resident pages per hash bucket */
> +#define NUM_NR ((L1_CACHE_BYTES - sizeof(atomic_t))/sizeof(u32))
> +
> +struct nr_bucket
> +{
> +	atomic_t hand;
> +	u32 page[NUM_NR];
> +} ____cacheline_aligned;
> +
> +/* The non-resident page hash table. */
> +static struct nr_bucket * nonres_table;
> +static unsigned int nonres_shift;
> +static unsigned int nonres_mask;
> +
> +struct nr_bucket * nr_hash(void * mapping, unsigned long index)
> +{
> +	unsigned long bucket;
> +	unsigned long hash;
> +
> +	hash = hash_ptr(mapping, BITS_PER_LONG);
> +	hash = 37 * hash + hash_long(index, BITS_PER_LONG);
> +	bucket = hash & nonres_mask;
> +
> +	return nonres_table + bucket;
> +}
> +
> +static u32 nr_cookie(struct address_space * mapping, unsigned long index)
> +{
> +	unsigned long cookie = hash_ptr(mapping, BITS_PER_LONG);
> +	cookie = 37 * cookie + hash_long(index, BITS_PER_LONG);
> +
> +	if (mapping->host) {
> +		cookie = 37 * cookie + hash_long(mapping->host->i_ino, BITS_PER_LONG);
> +	}
> +
> +	return (u32)(cookie >> (BITS_PER_LONG - 32));
> +}
> +
> +int recently_evicted(struct address_space * mapping, unsigned long index)
> +{
> +	struct nr_bucket * nr_bucket;
> +	int distance;
> +	u32 wanted;
> +	int i;
> +
> +	prefetch(mapping->host);
> +	nr_bucket = nr_hash(mapping, index);
> +
> +	prefetch(nr_bucket);
> +	wanted = nr_cookie(mapping, index);
> +
> +	for (i = 0; i < NUM_NR; i++) {
> +		if (nr_bucket->page[i] == wanted) {
> +			nr_bucket->page[i] = 0;
> +			/* Return the distance between entry and clock hand. */
> +			distance = atomic_read(&nr_bucket->hand) + NUM_NR - i;
> +			distance = (distance % NUM_NR) + 1;
> +			return distance * (1 << nonres_shift);
> +		}
> +	}
> +
> +	return -1;
> +}
> +
> +int remember_page(struct address_space * mapping, unsigned long index)
> +{
> +	struct nr_bucket * nr_bucket;
> +	u32 nrpage;
> +	int i;
> +
> +	prefetch(mapping->host);
> +	nr_bucket = nr_hash(mapping, index);
> +
> +	prefetchw(nr_bucket);
> +	nrpage = nr_cookie(mapping, index);
> +
> +	/* Atomically find the next array index. */
> +	preempt_disable();
> +  retry:
> +	i = atomic_inc_return(&nr_bucket->hand);
> +	if (unlikely(i >= NUM_NR)) {
> +		if (i == NUM_NR)
> +			atomic_set(&nr_bucket->hand, -1);
> +		goto retry;
> +	}
> +	preempt_enable();
> +
> +	/* Statistics may want to know whether the entry was in use. */
> +	return xchg(&nr_bucket->page[i], nrpage);
> +}
> +
> +/*
> + * For interactive workloads, we remember about as many non-resident pages
> + * as we have actual memory pages.  For server workloads with large inter-
> + * reference distances we could benefit from remembering more.
> + */
> +static __initdata unsigned long nonresident_factor = 1;
> +void __init init_nonresident(void)
> +{
> +	int target;
> +	int i;
> +
> +	/*
> +	 * Calculate the non-resident hash bucket target. Use a power of
> +	 * two for the division because alloc_large_system_hash rounds up.
> +	 */
> +	target = nr_all_pages * nonresident_factor;
> +	target /= (sizeof(struct nr_bucket) / sizeof(u32));
> +
> +	nonres_table = alloc_large_system_hash("Non-resident page tracking",
> +					sizeof(struct nr_bucket),
> +					target,
> +					0,
> +					HASH_EARLY | HASH_HIGHMEM,
> +					&nonres_shift,
> +					&nonres_mask,
> +					0);
> +
> +	for (i = 0; i < (1 << nonres_shift); i++)
> +		atomic_set(&nonres_table[i].hand, 0);
> +}
> +
> +static int __init set_nonresident_factor(char * str)
> +{
> +	if (!str)
> +		return 0;
> +	nonresident_factor = simple_strtoul(str, &str, 0);
> +	return 1;
> +}
> +__setup("nonresident_factor=", set_nonresident_factor);
> Index: linux-2.6.12-vm/mm/vmscan.c
> ===================================================================
> --- linux-2.6.12-vm.orig/mm/vmscan.c
> +++ linux-2.6.12-vm/mm/vmscan.c
> @@ -509,6 +509,7 @@ static int shrink_list(struct list_head 
>  #ifdef CONFIG_SWAP
>  		if (PageSwapCache(page)) {
>  			swp_entry_t swap = { .val = page->private };
> +			remember_page(&swapper_space, page->private);
>  			__delete_from_swap_cache(page);
>  			write_unlock_irq(&mapping->tree_lock);
>  			swap_free(swap);
> @@ -517,6 +518,7 @@ static int shrink_list(struct list_head 
>  		}
>  #endif /* CONFIG_SWAP */
>  
> +		remember_page(page->mapping, page->index);
>  		__remove_from_page_cache(page);
>  		write_unlock_irq(&mapping->tree_lock);
>  		__put_page(page);
> Index: linux-2.6.12-vm/mm/filemap.c
> ===================================================================
> --- linux-2.6.12-vm.orig/mm/filemap.c
> +++ linux-2.6.12-vm/mm/filemap.c
> @@ -400,8 +400,13 @@ int add_to_page_cache_lru(struct page *p
>  				pgoff_t offset, int gfp_mask)
>  {
>  	int ret = add_to_page_cache(page, mapping, offset, gfp_mask);
> -	if (ret == 0)
> -		lru_cache_add(page);
> +	int activate = recently_evicted(mapping, offset);
> +	if (ret == 0) {
> +		if (activate >= 0)
> +			lru_cache_add_active(page);
> +		else
> +			lru_cache_add(page);
> +	}
>  	return ret;
>  }
>  
> Index: linux-2.6.12-vm/mm/swap_state.c
> ===================================================================
> --- linux-2.6.12-vm.orig/mm/swap_state.c
> +++ linux-2.6.12-vm/mm/swap_state.c
> @@ -323,6 +323,7 @@ struct page *read_swap_cache_async(swp_e
>  			struct vm_area_struct *vma, unsigned long addr)
>  {
>  	struct page *found_page, *new_page = NULL;
> +	int activate;
>  	int err;
>  
>  	do {
> @@ -344,6 +345,8 @@ struct page *read_swap_cache_async(swp_e
>  				break;		/* Out of memory */
>  		}
>  
> +		activate = recently_evicted(&swapper_space, entry.val);
> +
>  		/*
>  		 * Associate the page with swap entry in the swap cache.
>  		 * May fail (-ENOENT) if swap entry has been freed since
> @@ -359,7 +362,10 @@ struct page *read_swap_cache_async(swp_e
>  			/*
>  			 * Initiate read into locked page and return.
>  			 */
> -			lru_cache_add_active(new_page);
> +			if (activate >= 0)
> +				lru_cache_add_active(new_page);
> +			else
> +				lru_cache_add(new_page);
>  			swap_readpage(NULL, new_page);
>  			return new_page;
>  		}
> 
> --
> -- 
> All Rights Reversed
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
