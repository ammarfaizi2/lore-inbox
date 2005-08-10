Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbVHJUJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbVHJUJz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 16:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbVHJUJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 16:09:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22677 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030247AbVHJUJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 16:09:53 -0400
Message-Id: <20050810200943.425036000@jumble.boston.redhat.com>
References: <20050810200216.644997000@jumble.boston.redhat.com>
Date: Wed, 10 Aug 2005 16:02:19 -0400
From: Rik van Riel <riel@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH/RFT 3/5] CLOCK-Pro page replacement
Content-Disposition: inline; filename=useonce-cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the use-once code.  I have not benchmarked this change yet,
but I expect it to have little impact on most workloads.  It gets rid
of some magic code though, which is nice.

Signed-off-by: Rik van Riel <riel@surriel.com>

Index: linux-2.6.12-vm/include/linux/page-flags.h
===================================================================
--- linux-2.6.12-vm.orig/include/linux/page-flags.h
+++ linux-2.6.12-vm/include/linux/page-flags.h
@@ -75,7 +75,9 @@
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_nosave_free		19	/* Free, should not be written */
+
 #define PG_uncached		20	/* Page has been mapped as uncached */
+#define PG_new			21	/* Newly allocated page */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -306,6 +308,11 @@ extern void __mod_page_state(unsigned of
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageNew(page)		test_bit(PG_new, &(page)->flags)
+#define SetPageNew(page)	set_bit(PG_new, &(page)->flags)
+#define ClearPageNew(page)	clear_bit(PG_new, &(page)->flags)
+#define TestClearPageNew(page)	test_and_clear_bit(PG_new, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
Index: linux-2.6.12-vm/mm/filemap.c
===================================================================
--- linux-2.6.12-vm.orig/mm/filemap.c
+++ linux-2.6.12-vm/mm/filemap.c
@@ -383,6 +383,7 @@ int add_to_page_cache(struct page *page,
 		if (!error) {
 			page_cache_get(page);
 			SetPageLocked(page);
+			SetPageNew(page);
 			page->mapping = mapping;
 			page->index = offset;
 			mapping->nrpages++;
@@ -723,7 +724,6 @@ void do_generic_mapping_read(struct addr
 	unsigned long offset;
 	unsigned long last_index;
 	unsigned long next_index;
-	unsigned long prev_index;
 	loff_t isize;
 	struct page *cached_page;
 	int error;
@@ -732,7 +732,6 @@ void do_generic_mapping_read(struct addr
 	cached_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	next_index = index;
-	prev_index = ra.prev_page;
 	last_index = (*ppos + desc->count + PAGE_CACHE_SIZE-1) >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
@@ -779,13 +778,7 @@ page_ok:
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
Index: linux-2.6.12-vm/mm/shmem.c
===================================================================
--- linux-2.6.12-vm.orig/mm/shmem.c
+++ linux-2.6.12-vm/mm/shmem.c
@@ -1525,11 +1525,8 @@ static void do_shmem_file_read(struct fi
 			 */
 			if (mapping_writably_mapped(mapping))
 				flush_dcache_page(page);
-			/*
-			 * Mark the page accessed if we read the beginning.
-			 */
-			if (!offset)
-				mark_page_accessed(page);
+
+			mark_page_accessed(page);
 		} else
 			page = ZERO_PAGE(0);
 
Index: linux-2.6.12-vm/mm/swap.c
===================================================================
--- linux-2.6.12-vm.orig/mm/swap.c
+++ linux-2.6.12-vm/mm/swap.c
@@ -115,19 +115,11 @@ void fastcall activate_page(struct page 
 
 /*
  * Mark a page as having seen activity.
- *
- * inactive,unreferenced	->	inactive,referenced
- * inactive,referenced		->	active,unreferenced
- * active,unreferenced		->	active,referenced
  */
 void fastcall mark_page_accessed(struct page *page)
 {
-	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
-		activate_page(page);
-		ClearPageReferenced(page);
-	} else if (!PageReferenced(page)) {
+	if (!PageReferenced(page))
 		SetPageReferenced(page);
-	}
 }
 
 EXPORT_SYMBOL(mark_page_accessed);
@@ -157,6 +149,7 @@ void fastcall lru_cache_add_active(struc
 	if (!pagevec_add(pvec, page))
 		__pagevec_lru_add_active(pvec);
 	put_cpu_var(lru_add_active_pvecs);
+	ClearPageNew(page);
 }
 
 void lru_add_drain(void)
Index: linux-2.6.12-vm/mm/vmscan.c
===================================================================
--- linux-2.6.12-vm.orig/mm/vmscan.c
+++ linux-2.6.12-vm/mm/vmscan.c
@@ -225,27 +225,6 @@ static int shrink_slab(unsigned long sca
 	return 0;
 }
 
-/* Called without lock on whether page is mapped, so answer is unstable */
-static inline int page_mapping_inuse(struct page *page)
-{
-	struct address_space *mapping;
-
-	/* Page is in somebody's page tables. */
-	if (page_mapped(page))
-		return 1;
-
-	/* Be more reluctant to reclaim swapcache than pagecache */
-	if (PageSwapCache(page))
-		return 1;
-
-	mapping = page_mapping(page);
-	if (!mapping)
-		return 0;
-
-	/* File is mmap'd by somebody? */
-	return mapping_mapped(mapping);
-}
-
 static inline int is_page_cache_freeable(struct page *page)
 {
 	return page_count(page) - !!PagePrivate(page) == 2;
@@ -398,9 +377,13 @@ static int shrink_list(struct list_head 
 			goto keep_locked;
 
 		referenced = page_referenced(page, 1, sc->priority <= 0);
-		/* In active use or really unfreeable?  Activate it. */
-		if (referenced && page_mapping_inuse(page))
+
+		if (referenced) {
+			/* New page. Wait and see if it gets used again... */
+			if (TestClearPageNew(page))
+				goto keep_locked;
 			goto activate_locked;
+		}
 
 #ifdef CONFIG_SWAP
 		/*
@@ -694,6 +677,7 @@ refill_inactive_zone(struct zone *zone, 
 	long mapped_ratio;
 	long distress;
 	long swap_tendency;
+	int referenced;
 
 	lru_add_drain();
 	spin_lock_irq(&zone->lru_lock);
@@ -738,10 +722,10 @@ refill_inactive_zone(struct zone *zone, 
 		cond_resched();
 		page = lru_to_page(&l_hold);
 		list_del(&page->lru);
+		referenced = page_referenced(page, 0, sc->priority <= 0);
 		if (page_mapped(page)) {
-			if (!reclaim_mapped ||
-			    (total_swap_pages == 0 && PageAnon(page)) ||
-			    page_referenced(page, 0, sc->priority <= 0)) {
+			if (referenced || !reclaim_mapped ||
+			    (total_swap_pages == 0 && PageAnon(page))) {
 				list_add(&page->lru, &l_active);
 				continue;
 			}

--
-- 
All Rights Reversed
