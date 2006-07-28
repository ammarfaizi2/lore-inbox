Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161182AbWG1Q5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161182AbWG1Q5e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161181AbWG1Q5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:57:34 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:50634 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161098AbWG1Q5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:57:33 -0400
Subject: Re: [PATCH] mm: use-once cleanup
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mel Gorman <mel@skynet.ie>
Cc: linux-mm <linux-mm@kvack.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       riel <riel@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060728153440.GA23148@skynet.ie>
References: <1153168829.31891.89.camel@lappy>
	 <20060728153440.GA23148@skynet.ie>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 18:57:29 +0200
Message-Id: <1154105849.30621.62.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 16:34 +0100, Mel Gorman wrote:
> On (17/07/06 22:40), Peter Zijlstra didst pronounce:
> > Hi,
> > 
> > This is yet another implementation of the PG_useonce cleanup spoken of
> > during the VM summit.
> > 
> > The idea is to mark a page PG_useonce on pagecache entry and modify the
> > page_referenced() check to retry on the inactive list instead of
> > promotion to the active list when PG_useonce is set. PG_useonce is
> > cleared on first use.
> > 
> 
> It wouldn't hurt to write what problem useonce fixes directly into the source
> somewhere as a comment. "Page is new to the pagecache" doesn't really say a
> whole lot and it takes some brain swizzling to see what's going on.
> 
> Disclaimer reading the patch as well. I haven't been reading through this code
> in a *long* time and I have not been reviewing  the patches that preceeded
> this one. Take the feedback with a grain of salt.

Still appreciated, time is valuable.

> > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > ---
> >  include/linux/mm_inline.h  |    2 ++
> >  include/linux/page-flags.h |    5 +++++
> >  mm/filemap.c               |   22 +++++++++++++---------
> >  mm/page_alloc.c            |    9 ++++++---
> >  mm/shmem.c                 |    7 ++-----
> >  mm/swap.c                  |   11 ++---------
> >  mm/vmscan.c                |   36 +++++++++++-------------------------
> >  7 files changed, 41 insertions(+), 51 deletions(-)
> > 
> > Index: linux-2.6/include/linux/mm_inline.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/mm_inline.h	2006-07-17 22:31:06.000000000 +0200
> > +++ linux-2.6/include/linux/mm_inline.h	2006-07-17 22:35:32.000000000 +0200
> > @@ -37,5 +37,7 @@ del_page_from_lru(struct zone *zone, str
> >  	} else {
> >  		zone->nr_inactive--;
> >  	}
> > +	if (PageUseOnce(page))
> > +		ClearPageUseOnce(page);
> >  }
> >  
> > Index: linux-2.6/include/linux/page-flags.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/page-flags.h	2006-07-17 22:31:09.000000000 +0200
> > +++ linux-2.6/include/linux/page-flags.h	2006-07-17 22:39:14.000000000 +0200
> > @@ -86,6 +86,7 @@
> >  #define PG_nosave_free		18	/* Free, should not be written */
> >  #define PG_buddy		19	/* Page is free, on buddy lists */
> >  
> > +#define PG_useonce		20	/* Page is new to the pagecache */
> >  
> 
> Is there a way the useonce pages can be tracked without using another
> page bit? (I'm guessing not but extra page bits are always worth a
> stare)

't is what we've been trying to fudge for a long time now, alas no known
alternative.

> >  #if (BITS_PER_LONG > 32)
> >  /*
> > @@ -247,6 +248,10 @@
> >  #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
> >  #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
> >  
> > +#define PageUseOnce(page)	test_bit(PG_useonce, &(page)->flags)
> > +#define SetPageUseOnce(page)	set_bit(PG_useonce, &(page)->flags)
> > +#define ClearPageUseOnce(page)	clear_bit(PG_useonce, &(page)->flags)
> > +
> >  struct page;	/* forward declaration */
> >  
> >  int test_clear_page_dirty(struct page *page);
> > Index: linux-2.6/mm/filemap.c
> > ===================================================================
> > --- linux-2.6.orig/mm/filemap.c	2006-07-17 22:31:17.000000000 +0200
> > +++ linux-2.6/mm/filemap.c	2006-07-17 22:35:32.000000000 +0200
> > @@ -444,6 +444,18 @@ int add_to_page_cache(struct page *page,
> >  		error = radix_tree_insert(&mapping->page_tree, offset, page);
> >  		if (!error) {
> >  			page_cache_get(page);
> > +			/*
> > +			 * shmem_getpage()
> > +			 *   lookup_swap_cache()
> > +			 *   TestSetPageLocked()
> > +			 *   move_from_swap_cache()
> > +			 *     add_to_page_cache()
> > +			 *
> > +			 * That path calls us with a LRU page instead of a new
> > +			 * page. Don't set the hint for LRU pages.
> > +			 */
> > +			if (!PageLocked(page))
> > +				SetPageUseOnce(page);
> 
> Ok, I get this part. On insertion into the page cache, mark the page
> useonce so later we'll detect if the really useonce or not.
> 
> >  			SetPageLocked(page);
> >  			page->mapping = mapping;
> >  			page->index = offset;
> > @@ -884,7 +896,6 @@ void do_generic_mapping_read(struct addr
> >  	unsigned long offset;
> >  	unsigned long last_index;
> >  	unsigned long next_index;
> > -	unsigned long prev_index;
> >  	loff_t isize;
> >  	struct page *cached_page;
> >  	int error;
> > @@ -893,7 +904,6 @@ void do_generic_mapping_read(struct addr
> >  	cached_page = NULL;
> >  	index = *ppos >> PAGE_CACHE_SHIFT;
> >  	next_index = index;
> > -	prev_index = ra.prev_page;
> >  	last_index = (*ppos + desc->count + PAGE_CACHE_SIZE-1) >> PAGE_CACHE_SHIFT;
> >  	offset = *ppos & ~PAGE_CACHE_MASK;
> >  
> > @@ -940,13 +950,7 @@ page_ok:
> >  		if (mapping_writably_mapped(mapping))
> >  			flush_dcache_page(page);
> >  
> > -		/*
> > -		 * When (part of) the same page is read multiple times
> > -		 * in succession, only mark it as accessed the first time.
> > -		 */
> > -		if (prev_index != index)
> > -			mark_page_accessed(page);
> > -		prev_index = index;
> > +		mark_page_accessed(page);
> >  
> 
> Ok, I also get this part. Because mark_page_accessed() is now only
> setting the referenced bit, we can call it multiple times without
> messing up LRU ordering.

*nod*

> >  		/*
> >  		 * Ok, we have the page, and it's up-to-date, so
> > Index: linux-2.6/mm/page_alloc.c
> > ===================================================================
> > --- linux-2.6.orig/mm/page_alloc.c	2006-07-17 22:31:17.000000000 +0200
> > +++ linux-2.6/mm/page_alloc.c	2006-07-17 22:38:25.000000000 +0200
> > @@ -154,7 +154,8 @@ static void bad_page(struct page *page)
> >  			1 << PG_slab    |
> >  			1 << PG_swapcache |
> >  			1 << PG_writeback |
> > -			1 << PG_buddy );
> > +			1 << PG_buddy |
> > +			1 << PG_useonce);
> >  	set_page_count(page, 0);
> >  	reset_page_mapcount(page);
> >  	page->mapping = NULL;
> > @@ -389,7 +390,8 @@ static inline int free_pages_check(struc
> >  			1 << PG_swapcache |
> >  			1 << PG_writeback |
> >  			1 << PG_reserved |
> > -			1 << PG_buddy ))))
> > +			1 << PG_buddy |
> > +			1 << PF_useonce ))))
> 
> Looks like a typo there. PF_useonce is not defined anywhere.

Yeah, that's what I get for text editing a patch after testing :-(
PG_useonce was indeed intended. Already fixed in the patch I send to
Andy offlist.

> >  		bad_page(page);
> >  	if (PageDirty(page))
> >  		__ClearPageDirty(page);
> > @@ -538,7 +540,8 @@ static int prep_new_page(struct page *pa
> >  			1 << PG_swapcache |
> >  			1 << PG_writeback |
> >  			1 << PG_reserved |
> > -			1 << PG_buddy ))))
> > +			1 << PG_buddy |
> > +			1 << PG_useonce ))))
> >  		bad_page(page);
> >  
> >  	/*
> > Index: linux-2.6/mm/shmem.c
> > ===================================================================
> > --- linux-2.6.orig/mm/shmem.c	2006-07-17 22:31:17.000000000 +0200
> > +++ linux-2.6/mm/shmem.c	2006-07-17 22:35:32.000000000 +0200
> > @@ -1567,11 +1567,8 @@ static void do_shmem_file_read(struct fi
> >  			 */
> >  			if (mapping_writably_mapped(mapping))
> >  				flush_dcache_page(page);
> > -			/*
> > -			 * Mark the page accessed if we read the beginning.
> > -			 */
> > -			if (!offset)
> > -				mark_page_accessed(page);
> > +
> > +			mark_page_accessed(page);
> 
> Also fine. mark_page_accessed() will not mess up the ordering.
> 
> >  		} else {
> >  			page = ZERO_PAGE(0);
> >  			page_cache_get(page);
> > Index: linux-2.6/mm/swap.c
> > ===================================================================
> > --- linux-2.6.orig/mm/swap.c	2006-07-17 22:31:18.000000000 +0200
> > +++ linux-2.6/mm/swap.c	2006-07-17 22:35:32.000000000 +0200
> > @@ -114,19 +114,11 @@ void fastcall activate_page(struct page 
> >  
> >  /*
> >   * Mark a page as having seen activity.
> > - *
> > - * inactive,unreferenced	->	inactive,referenced
> > - * inactive,referenced		->	active,unreferenced
> > - * active,unreferenced		->	active,referenced
> >   */
> >  void fastcall mark_page_accessed(struct page *page)
> >  {
> > -	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
> > -		activate_page(page);
> > -		ClearPageReferenced(page);
> > -	} else if (!PageReferenced(page)) {
> > +	if (!PageReferenced(page))
> >  		SetPageReferenced(page);
> > -	}
> >  }
> 
> mark_page_accessed() now only marks a page referenced and no longer affects
> LRU ordering, that seems ok. However, the promotion from inactive to inactive
> is now taking a fairly different path and promotion may be happening much
> later if I'm reading things correctly. Promotion now takes place at either
> fault time or when scanning the lists for reclaim in shrink_page_list().
> 
> 1. When it reaches the end of the inactive list, the page is checked
> 2. If it's PG_useonce and referenced, the useonce bit is cleared and it's moved to the
>    start of the inactive list
> 3. If it's not PG_useonce but is referenced, it's moved to the active
>    list
 4. if its neither referenced or PG_useonce its a reclaim candidate and
    we proceed to try and free it.
> 
> Is that correct? 

Yes that is the intended semantics.

> It's fairly different to promotions possibly taking place
> every time mark_page_accessed() is called which a grep of mm/ implies
> can happen a lot. It may not be a problem, but it's a subtle change worth
> thinking about.

It is my understanding that mark_page_accessed() should do just that,
record that this page was touched, and that the current complications
come from the current use-once implementation.

Anyone who knows better, please speak up.

> >  
> >  EXPORT_SYMBOL(mark_page_accessed);
> > @@ -153,6 +145,7 @@ void fastcall lru_cache_add_active(struc
> >  	struct pagevec *pvec = &get_cpu_var(lru_add_active_pvecs);
> >  
> >  	page_cache_get(page);
> > +	ClearPageUseOnce(page);
> >  	if (!pagevec_add(pvec, page))
> >  		__pagevec_lru_add_active(pvec);
> >  	put_cpu_var(lru_add_active_pvecs);
> > Index: linux-2.6/mm/vmscan.c
> > ===================================================================
> > --- linux-2.6.orig/mm/vmscan.c	2006-07-17 22:31:18.000000000 +0200
> > +++ linux-2.6/mm/vmscan.c	2006-07-17 22:35:32.000000000 +0200
> > @@ -227,27 +227,6 @@ unsigned long shrink_slab(unsigned long 
> >  	return ret;
> >  }
> >  
> > -/* Called without lock on whether page is mapped, so answer is unstable */
> > -static inline int page_mapping_inuse(struct page *page)
> > -{
> > -	struct address_space *mapping;
> > -
> > -	/* Page is in somebody's page tables. */
> > -	if (page_mapped(page))
> > -		return 1;
> > -
> > -	/* Be more reluctant to reclaim swapcache than pagecache */
> > -	if (PageSwapCache(page))
> > -		return 1;
> > -
> > -	mapping = page_mapping(page);
> > -	if (!mapping)
> > -		return 0;
> > -
> > -	/* File is mmap'd by somebody? */
> > -	return mapping_mapped(mapping);
> > -}
> > -
> >  static inline int is_page_cache_freeable(struct page *page)
> >  {
> >  	return page_count(page) - !!PagePrivate(page) == 2;
> > @@ -456,8 +435,13 @@ static unsigned long shrink_page_list(st
> >  
> >  		referenced = page_referenced(page, 1);
> >  		/* In active use or really unfreeable?  Activate it. */
> > -		if (referenced && page_mapping_inuse(page))
> > +		if (referenced) {
> > +			if (PageUseOnce(page)) {
> > +				ClearPageUseOnce(page);
> > +				goto keep_locked;
> > +			}
> >  			goto activate_locked;
> > +		}
> >  
> 
> This could do with a comment explaining that this is where inactive
> pages that are not marked UseOnce but are referenced gets promoted to
> the active list.

Hmm perhaps you are right, I might have been looking at this code for
too long to not find it obvious ;-)

> 
> >  #ifdef CONFIG_SWAP
> >  		/*
> > @@ -551,6 +535,7 @@ static unsigned long shrink_page_list(st
> >  			goto keep_locked;
> >  
> >  free_it:
> > +		ClearPageUseOnce(page);
> >  		unlock_page(page);
> >  		nr_reclaimed++;
> >  		if (!pagevec_add(&freed_pvec, page))
> > @@ -724,6 +709,7 @@ static void shrink_active_list(unsigned 
> >  	struct page *page;
> >  	struct pagevec pvec;
> >  	int reclaim_mapped = 0;
> > +	int referenced;
> >  
> >  	if (sc->may_swap) {
> >  		long mapped_ratio;
> > @@ -780,10 +766,10 @@ static void shrink_active_list(unsigned 
> >  		cond_resched();
> >  		page = lru_to_page(&l_hold);
> >  		list_del(&page->lru);
> > +		referenced = page_referenced(page, 0);
> >  		if (page_mapped(page)) {
> > -			if (!reclaim_mapped ||
> > -			    (total_swap_pages == 0 && PageAnon(page)) ||
> > -			    page_referenced(page, 0)) {
> > +			if (referenced || !reclaim_mapped ||
> > +			    (total_swap_pages == 0 && PageAnon(page))) {
> >  				list_add(&page->lru, &l_active);
> >  				continue;
> >  			}
> > 
> 
> I don't get why this reordering is necessary for useonce.

You are right in that its a fairly separate issue; this change would
make the reference bit for all active pages have the same lifetime.
That is, currently mapped pages can have their reference bit stick
for several revolution of the hand. Making them appear hot longer than
intended, OTOH this whole discrimination against mapped pages makes
them last longer anyway. (I would so love to get rid of that)

Perhaps this change should go on its own. It came from the use-once
cleanup Rik did some time ago.

