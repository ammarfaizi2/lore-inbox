Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVECGZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVECGZG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 02:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVECGZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 02:25:06 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:24935 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261406AbVECGYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 02:24:13 -0400
Message-ID: <42771904.7020404@yahoo.com.au>
Date: Tue, 03 May 2005 16:24:04 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC] how do we move the VM forward? (was Re: [RFC] cleanup of use-once)
References: <Pine.LNX.4.61.0505030037100.27756@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0505030037100.27756@chimarrao.boston.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------040406030306040206000405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040406030306040206000405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Rik van Riel wrote:
> The special cases in the use-once code have annoyed me for a while,
> and I'd like to see if replacing them with something simpler could
> be worthwhile.
> 
> I haven't actually benchmarked (or even tested) this code yet, but
> the basic idea is that we want to ignore multiple references to the
> same page if they happen really close to each other, and only keep
> a page on the active list if it got accessed again on a time scale
> that matters to the pageout code.  In other words, filtering out
> correlated references in a simpler way.
> 
> Opinions ?
> 

I've had some patches around that do basically exactly the same thing.
I'll attach them just for reference, but they're pretty messy and
depend on other private patches I have here.

I think the biggest problem with our twine and duct tape page reclaim
scheme is that somehow *works* (for some value of works).

And intermediate steps like this are likely to upset its fragile workings
even though they really should be better solutions.

I think we branch a new tree for all interested VM developers to work
on and try to get performing well. Probably try to restrict it to page
reclaim and related fundamentals so it stays as small as possible and
worth testing.

I would be interested in helping to maintain such a tree (we would have
it track 2.6, of course). I have a whole load of patches and things here
that I need to do something with some day (many of them are probabably
crap!).

Any thoughts? If positive, any ideas about what sort of format? Maybe an
akpm style tree (although probably not tracking Linus' head quite so fast)?
Names? Same style as -mm trees? -vm?

Nick

-- 
SUSE Labs, Novell Inc.

--------------040406030306040206000405
Content-Type: text/plain;
 name="vm-mark_page_accessed.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-mark_page_accessed.patch"


Changes mark_page_accessed to only set the PageAccessed bit, and
not move pages around the LRUs. This means we don't have to take
the lru_lock, and it also makes page ageing and scanning more consistient
and all handled in mm/vmscan.c


---

 linux-2.6-npiggin/include/linux/swap.h |    8 +++++--
 linux-2.6-npiggin/mm/filemap.c         |   16 ++------------
 linux-2.6-npiggin/mm/shmem.c           |    6 -----
 linux-2.6-npiggin/mm/swap.c            |   36 ---------------------------------
 linux-2.6-npiggin/mm/swapfile.c        |    6 ++---
 5 files changed, 13 insertions(+), 59 deletions(-)

diff -puN mm/filemap.c~vm-mark_page_accessed mm/filemap.c
--- linux-2.6/mm/filemap.c~vm-mark_page_accessed	2005-02-09 20:47:41.000000000 +1100
+++ linux-2.6-npiggin/mm/filemap.c	2005-02-09 21:02:53.000000000 +1100
@@ -438,10 +438,8 @@ EXPORT_SYMBOL(unlock_page);
  */
 void end_page_writeback(struct page *page)
 {
-	if (!TestClearPageReclaim(page) || rotate_reclaimable_page(page)) {
-		if (!test_clear_page_writeback(page))
-			BUG();
-	}
+	if (!test_clear_page_writeback(page))
+		BUG();
 	smp_mb__after_clear_bit();
 	wake_up_page(page, PG_writeback);
 }
@@ -693,7 +691,6 @@ void do_generic_mapping_read(struct addr
 	unsigned long offset;
 	unsigned long req_size;
 	unsigned long next_index;
-	unsigned long prev_index;
 	loff_t isize;
 	struct page *cached_page;
 	int error;
@@ -702,7 +699,6 @@ void do_generic_mapping_read(struct addr
 	cached_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	next_index = index;
-	prev_index = ra.prev_page;
 	req_size = (desc->count + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
@@ -752,13 +748,7 @@ page_ok:
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_page(page);
 
-		/*
-		 * When (part of) the same page is read multiple times
-		 * in succession, only mark it as accessed the first time.
-		 */
-		if (prev_index != index)
-			mark_page_accessed(page);
-		prev_index = index;
+		mark_page_accessed(page);
 
 		/*
 		 * Ok, we have the page, and it's up-to-date, so
diff -puN mm/swap.c~vm-mark_page_accessed mm/swap.c
--- linux-2.6/mm/swap.c~vm-mark_page_accessed	2005-02-09 20:47:41.000000000 +1100
+++ linux-2.6-npiggin/mm/swap.c	2005-02-11 20:56:44.000000000 +1100
@@ -96,42 +96,6 @@ int rotate_reclaimable_page(struct page 
 	return 0;
 }
 
-/*
- * FIXME: speed this up?
- */
-void fastcall activate_page(struct page *page)
-{
-	struct zone *zone = page_zone(page);
-
-	spin_lock_irq(&zone->lru_lock);
-	if (PageLRU(page) && !PageActive(page)) {
-		del_page_from_inactive_list(zone, page);
-		SetPageActive(page);
-		add_page_to_active_list(zone, page);
-		inc_page_state(pgactivate);
-	}
-	spin_unlock_irq(&zone->lru_lock);
-}
-
-/*
- * Mark a page as having seen activity.
- *
- * inactive,unreferenced	->	inactive,referenced
- * inactive,referenced		->	active,unreferenced
- * active,unreferenced		->	active,referenced
- */
-void fastcall mark_page_accessed(struct page *page)
-{
-	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
-		activate_page(page);
-		ClearPageReferenced(page);
-	} else if (!PageReferenced(page)) {
-		SetPageReferenced(page);
-	}
-}
-
-EXPORT_SYMBOL(mark_page_accessed);
-
 /**
  * lru_cache_add: add a page to the page lists
  * @page: the page to add
diff -puN include/linux/swap.h~vm-mark_page_accessed include/linux/swap.h
--- linux-2.6/include/linux/swap.h~vm-mark_page_accessed	2005-02-09 20:47:41.000000000 +1100
+++ linux-2.6-npiggin/include/linux/swap.h	2005-02-11 20:56:43.000000000 +1100
@@ -165,12 +165,16 @@ extern unsigned int nr_free_pagecache_pa
 /* linux/mm/swap.c */
 extern void FASTCALL(lru_cache_add(struct page *));
 extern void FASTCALL(lru_cache_add_active(struct page *));
-extern void FASTCALL(activate_page(struct page *));
-extern void FASTCALL(mark_page_accessed(struct page *));
 extern void lru_add_drain(void);
 extern int rotate_reclaimable_page(struct page *page);
 extern void swap_setup(void);
 
+/* Mark a page as having seen activity. */
+#define mark_page_accessed(page)	\
+do {					\
+	SetPageReferenced(page);	\
+} while (0)
+
 /* linux/mm/vmscan.c */
 extern int try_to_free_pages(struct zone **, unsigned int, unsigned int);
 extern int shrink_all_memory(int);
diff -puN include/linux/mm_inline.h~vm-mark_page_accessed include/linux/mm_inline.h
diff -puN mm/memory.c~vm-mark_page_accessed mm/memory.c
diff -puN mm/shmem.c~vm-mark_page_accessed mm/shmem.c
--- linux-2.6/mm/shmem.c~vm-mark_page_accessed	2005-02-09 20:47:42.000000000 +1100
+++ linux-2.6-npiggin/mm/shmem.c	2005-02-09 20:47:42.000000000 +1100
@@ -1523,11 +1523,7 @@ static void do_shmem_file_read(struct fi
 			 */
 			if (mapping_writably_mapped(mapping))
 				flush_dcache_page(page);
-			/*
-			 * Mark the page accessed if we read the beginning.
-			 */
-			if (!offset)
-				mark_page_accessed(page);
+			mark_page_accessed(page);
 		} else
 			page = ZERO_PAGE(0);
 
diff -puN include/linux/buffer_head.h~vm-mark_page_accessed include/linux/buffer_head.h
diff -puN mm/swapfile.c~vm-mark_page_accessed mm/swapfile.c
--- linux-2.6/mm/swapfile.c~vm-mark_page_accessed	2005-02-09 20:47:42.000000000 +1100
+++ linux-2.6-npiggin/mm/swapfile.c	2005-02-09 20:47:42.000000000 +1100
@@ -467,10 +467,10 @@ static unsigned long unuse_pmd(struct vm
 			pte_unmap(pte);
 
 			/*
-			 * Move the page to the active list so it is not
-			 * immediately swapped out again after swapon.
+			 * Touch the page so it is not immediately swapped
+			 * out again after swapon.
 			 */
-			activate_page(page);
+			mark_page_accessed(page);
 
 			/* add 1 since address may be 0 */
 			return 1 + address;

_

--------------040406030306040206000405
Content-Type: text/plain;
 name="vm-page-skipped.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-page-skipped.patch"

---

 linux-2.6-npiggin/include/linux/mm_inline.h  |    1 
 linux-2.6-npiggin/include/linux/page-flags.h |    8 +++
 linux-2.6-npiggin/mm/swap.c                  |    2 
 linux-2.6-npiggin/mm/vmscan.c                |   62 ++++++++++++++++-----------
 mm/page_alloc.c                              |    0 
 5 files changed, 49 insertions(+), 24 deletions(-)

diff -puN mm/vmscan.c~vm-page-skipped mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-page-skipped	2005-02-09 20:48:24.000000000 +1100
+++ linux-2.6-npiggin/mm/vmscan.c	2005-02-11 20:56:44.000000000 +1100
@@ -361,8 +361,20 @@ static int shrink_list(struct list_head 
 		if (PageWriteback(page))
 			goto keep_locked;
 
-		if (page_referenced(page, 1, sc->priority <= 0))
-			goto activate_locked;
+		if (page_referenced(page, 1, sc->priority <= 0)) {
+			/*
+			 * Has been referenced.  Activate used twice or
+			 * mapped pages, otherwise give it another chance
+			 * on the inactive list
+			 */
+			if (TestSetPageUsedOnce(page) || mapped)
+				goto activate_locked;
+			if (page_test_clear_pte_dirty(page, 1))
+				set_page_dirty(page);
+			if (PageDirty(page))
+				sc->nr_dirty_inactive++;
+			goto keep_locked;
+		}
 
 #ifdef CONFIG_SWAP
 		/*
@@ -581,9 +593,10 @@ static void shrink_cache(struct zone *zo
 			if (TestSetPageLRU(page))
 				BUG();
 			list_del(&page->lru);
-			if (PageActive(page))
+			if (PageActive(page)) {
+				ClearPageUsedOnce(page);
 				add_page_to_active_list(zone, page);
-			else
+			} else
 				add_page_to_inactive_list(zone, page);
 			if (!pagevec_add(&pvec, page)) {
 				spin_unlock_irq(&zone->lru_lock);
@@ -617,7 +630,7 @@ done:
 static void
 refill_inactive_zone(struct zone *zone, struct scan_control *sc)
 {
-	int pgmoved, pgmoved_dirty;
+	int pgmoved;
 	int pgdeactivate = 0;
 	int pgscanned = 0;
 	int nr_pages = sc->nr_to_scan;
@@ -633,7 +646,6 @@ refill_inactive_zone(struct zone *zone, 
 
 	lru_add_drain();
 	pgmoved = 0;
-	pgmoved_dirty = 0;
 
 	spin_lock_irq(&zone->lru_lock);
 	while (pgscanned < nr_pages && !list_empty(&zone->active_list)) {
@@ -717,24 +729,6 @@ refill_inactive_zone(struct zone *zone, 
 		list_add(&page->lru, &l_inactive);
 	}
 
-	/*
-	 * Try to write back as many pages as the number of dirty ones
-	 * we're adding to the inactive list.  This tends to cause slow
-	 * streaming writers to write data to the disk smoothly, at the
-	 * dirtying rate, which is nice.   But that's undesirable in
-	 * laptop mode, where we *want* lumpy writeout.  So in laptop
-	 * mode, write out the whole world.
-	 */
-	zone->nr_dirty_inactive += pgmoved_dirty;
-	pgmoved_dirty = zone->nr_dirty_inactive;
-	if (pgmoved_dirty > zone->nr_inactive / 2
-		|| (!(laptop_mode && !sc->may_writepage)
-			&& pgmoved_dirty > SWAP_CLUSTER_MAX)) {
-		zone->nr_dirty_inactive = 0;
-		wakeup_bdflush(laptop_mode ? 0 : pgmoved_dirty*2);
-		sc->may_writepage = 1;
-	}
-		
 	pagevec_init(&pvec, 1);
 	pgmoved = 0;
 	spin_lock_irq(&zone->lru_lock);
@@ -799,6 +793,7 @@ shrink_zone(struct zone *zone, struct sc
 {
 	unsigned long nr_active;
 	unsigned long nr_inactive;
+	unsigned long count;
 
 	/*
 	 * Add one to `nr_to_scan' just to make sure that the kernel will
@@ -819,6 +814,7 @@ shrink_zone(struct zone *zone, struct sc
 		nr_inactive = 0;
 
 	sc->nr_to_reclaim = SWAP_CLUSTER_MAX;
+	sc->nr_dirty_inactive = 0;
 
 	while (nr_active || nr_inactive) {
 		if (nr_active) {
@@ -837,6 +833,24 @@ shrink_zone(struct zone *zone, struct sc
 				break;
 		}
 	}
+
+	/*
+	 * Try to write back as many pages as the number of dirty ones
+	 * we're adding to the inactive list.  This tends to cause slow
+	 * streaming writers to write data to the disk smoothly, at the
+	 * dirtying rate, which is nice.   But that's undesirable in
+	 * laptop mode, where we *want* lumpy writeout.  So in laptop
+	 * mode, write out the whole world.
+	 */
+	zone->nr_dirty_inactive += sc->nr_dirty_inactive;
+	count = zone->nr_dirty_inactive;
+	if (count > zone->nr_inactive / 2
+		|| (!(laptop_mode && !sc->may_writepage)
+			&& count > SWAP_CLUSTER_MAX)) {
+		zone->nr_dirty_inactive = 0;
+		wakeup_bdflush(laptop_mode ? 0 : count*2);
+		sc->may_writepage = 1;
+	}
 }
 
 /*
diff -puN include/linux/page-flags.h~vm-page-skipped include/linux/page-flags.h
--- linux-2.6/include/linux/page-flags.h~vm-page-skipped	2005-02-09 20:48:24.000000000 +1100
+++ linux-2.6-npiggin/include/linux/page-flags.h	2005-02-11 20:56:43.000000000 +1100
@@ -76,6 +76,8 @@
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_nosave_free		19	/* Free, should not be written */
 
+#define PG_usedonce		20	/* LRU page has been touched once */
+
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -293,6 +295,12 @@ extern void __mod_page_state(unsigned of
 #define SetPageCompound(page)	set_bit(PG_compound, &(page)->flags)
 #define ClearPageCompound(page)	clear_bit(PG_compound, &(page)->flags)
 
+#define PageUsedOnce(page)	test_bit(PG_usedonce, &(page)->flags)
+#define SetPageUsedOnce(page)	set_bit(PG_usedonce, &(page)->flags)
+#define TestSetPageUsedOnce(page) test_and_set_bit(PG_usedonce, &(page)->flags)
+#define ClearPageUsedOnce(page)	clear_bit(PG_usedonce, &(page)->flags)
+#define TestClearPageUsedOnce(page) test_and_clear_bit(PG_usedonce, &(page)->flags)
+
 #ifdef CONFIG_SWAP
 #define PageSwapCache(page)	test_bit(PG_swapcache, &(page)->flags)
 #define SetPageSwapCache(page)	set_bit(PG_swapcache, &(page)->flags)
diff -puN mm/truncate.c~vm-page-skipped mm/truncate.c
diff -puN mm/swap.c~vm-page-skipped mm/swap.c
--- linux-2.6/mm/swap.c~vm-page-skipped	2005-02-09 20:48:24.000000000 +1100
+++ linux-2.6-npiggin/mm/swap.c	2005-02-11 20:56:43.000000000 +1100
@@ -267,6 +267,7 @@ void __pagevec_lru_add(struct pagevec *p
 		}
 		if (TestSetPageLRU(page))
 			BUG();
+		ClearPageUsedOnce(page);
 		add_page_to_inactive_list(zone, page);
 	}
 	if (zone)
@@ -296,6 +297,7 @@ void __pagevec_lru_add_active(struct pag
 			BUG();
 		if (TestSetPageActive(page))
 			BUG();
+		ClearPageUsedOnce(page);
 		add_page_to_active_list(zone, page);
 	}
 	if (zone)
diff -puN include/linux/swap.h~vm-page-skipped include/linux/swap.h
diff -puN include/linux/mm_inline.h~vm-page-skipped include/linux/mm_inline.h
--- linux-2.6/include/linux/mm_inline.h~vm-page-skipped	2005-02-09 20:48:24.000000000 +1100
+++ linux-2.6-npiggin/include/linux/mm_inline.h	2005-02-11 20:56:43.000000000 +1100
@@ -35,6 +35,7 @@ del_page_from_lru(struct zone *zone, str
 		ClearPageActive(page);
 		zone->nr_active--;
 	} else {
+		ClearPageUsedOnce(page);
 		zone->nr_inactive--;
 	}
 }
diff -puN mm/page_alloc.c~vm-page-skipped mm/page_alloc.c

_

--------------040406030306040206000405--

