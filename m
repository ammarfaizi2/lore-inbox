Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbVI2SR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVI2SR5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbVI2SRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:17:16 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.27]:29971 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S932348AbVI2SQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:16:57 -0400
Message-Id: <20050929181648.812239399@twins>
References: <20050929180845.910895444@twins>
Date: Thu, 29 Sep 2005 20:08:52 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-mm@kvack.org
Subject: [PATCH 7/7] CART - an advanced page replacement policy
Content-Disposition: inline; filename=cart-use-cart.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove most of the current page replacement code and make use
of the new CART code.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

 fs/exec.c            |    2 
 include/linux/swap.h |    2 
 mm/memory.c          |    7 -
 mm/swap.c            |   55 ----------
 mm/swap_state.c      |    2 
 mm/vmscan.c          |  262 +++------------------------------------------------
 6 files changed, 28 insertions(+), 302 deletions(-)

Index: linux-2.6-git/fs/exec.c
===================================================================
--- linux-2.6-git.orig/fs/exec.c
+++ linux-2.6-git/fs/exec.c
@@ -331,7 +331,7 @@ void install_arg_page(struct vm_area_str
 		goto out;
 	}
 	inc_mm_counter(mm, rss);
-	lru_cache_add_active(page);
+	lru_cache_add(page);
 	set_pte_at(mm, address, pte, pte_mkdirty(pte_mkwrite(mk_pte(
 					page, vma->vm_page_prot))));
 	page_add_anon_rmap(page, vma, address);
Index: linux-2.6-git/include/linux/swap.h
===================================================================
--- linux-2.6-git.orig/include/linux/swap.h
+++ linux-2.6-git/include/linux/swap.h
@@ -201,8 +201,6 @@ extern unsigned int nr_free_pagecache_pa
 
 /* linux/mm/swap.c */
 extern void FASTCALL(lru_cache_add(struct page *));
-extern void FASTCALL(lru_cache_add_active(struct page *));
-extern void FASTCALL(activate_page(struct page *));
 extern void FASTCALL(mark_page_accessed(struct page *));
 extern void lru_add_drain(void);
 extern int rotate_reclaimable_page(struct page *page);
Index: linux-2.6-git/mm/memory.c
===================================================================
--- linux-2.6-git.orig/mm/memory.c
+++ linux-2.6-git/mm/memory.c
@@ -1304,7 +1304,7 @@ static int do_wp_page(struct mm_struct *
 			page_remove_rmap(old_page);
 		flush_cache_page(vma, address, pfn);
 		break_cow(vma, new_page, address, page_table);
-		lru_cache_add_active(new_page);
+		lru_cache_add(new_page);
 		page_add_anon_rmap(new_page, vma, address);
 
 		/* Free the old page.. */
@@ -1782,8 +1782,7 @@ do_anonymous_page(struct mm_struct *mm, 
 		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
 							 vma->vm_page_prot)),
 				      vma);
-		lru_cache_add_active(page);
-		SetPageReferenced(page);
+		lru_cache_add(page);
 		page_add_anon_rmap(page, vma, addr);
 	}
 
@@ -1903,7 +1902,7 @@ retry:
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		set_pte_at(mm, address, page_table, entry);
 		if (anon) {
-			lru_cache_add_active(new_page);
+			lru_cache_add(new_page);
 			page_add_anon_rmap(new_page, vma, address);
 		} else
 			page_add_file_rmap(new_page);
Index: linux-2.6-git/mm/swap.c
===================================================================
--- linux-2.6-git.orig/mm/swap.c
+++ linux-2.6-git/mm/swap.c
@@ -78,16 +78,13 @@ int rotate_reclaimable_page(struct page 
 		return 1;
 	if (PageDirty(page))
 		return 1;
-	if (PageActive(page))
-		return 1;
 	if (!PageLRU(page))
 		return 1;
 
 	zone = page_zone(page);
 	spin_lock_irqsave(&zone->lru_lock, flags);
-	if (PageLRU(page) && !PageActive(page)) {
-		list_del(&page->lru);
-		list_add_tail(&page->lru, &zone->inactive_list);
+	if (PageLRU(page)) {
+		__cart_rotate_reclaimable(zone, page);
 		inc_page_state(pgrotated);
 	}
 	if (!test_clear_page_writeback(page))
@@ -112,7 +109,6 @@ EXPORT_SYMBOL(mark_page_accessed);
  * @page: the page to add
  */
 static DEFINE_PER_CPU(struct pagevec, lru_add_pvecs) = { 0, };
-static DEFINE_PER_CPU(struct pagevec, lru_add_active_pvecs) = { 0, };
 
 void fastcall lru_cache_add(struct page *page)
 {
@@ -124,25 +120,12 @@ void fastcall lru_cache_add(struct page 
 	put_cpu_var(lru_add_pvecs);
 }
 
-void fastcall lru_cache_add_active(struct page *page)
-{
-	struct pagevec *pvec = &get_cpu_var(lru_add_active_pvecs);
-
-	page_cache_get(page);
-	if (!pagevec_add(pvec, page))
-		__pagevec_lru_add_active(pvec);
-	put_cpu_var(lru_add_active_pvecs);
-}
-
 void lru_add_drain(void)
 {
 	struct pagevec *pvec = &get_cpu_var(lru_add_pvecs);
 
 	if (pagevec_count(pvec))
 		__pagevec_lru_add(pvec);
-	pvec = &__get_cpu_var(lru_add_active_pvecs);
-	if (pagevec_count(pvec))
-		__pagevec_lru_add_active(pvec);
 	put_cpu_var(lru_add_pvecs);
 }
 
@@ -278,7 +261,9 @@ void __pagevec_lru_add(struct pagevec *p
 		}
 		if (TestSetPageLRU(page))
 			BUG();
-		add_page_to_inactive_list(zone, page);
+		if (TestClearPageActive(page))
+			BUG();
+		__cart_insert(zone, page);
 	}
 	if (zone)
 		spin_unlock_irq(&zone->lru_lock);
@@ -288,33 +273,6 @@ void __pagevec_lru_add(struct pagevec *p
 
 EXPORT_SYMBOL(__pagevec_lru_add);
 
-void __pagevec_lru_add_active(struct pagevec *pvec)
-{
-	int i;
-	struct zone *zone = NULL;
-
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
-		struct zone *pagezone = page_zone(page);
-
-		if (pagezone != zone) {
-			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
-			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
-		}
-		if (TestSetPageLRU(page))
-			BUG();
-		if (TestSetPageActive(page))
-			BUG();
-		add_page_to_active_list(zone, page);
-	}
-	if (zone)
-		spin_unlock_irq(&zone->lru_lock);
-	release_pages(pvec->pages, pvec->nr, pvec->cold);
-	pagevec_reinit(pvec);
-}
-
 /*
  * Try to drop buffers from the pages in a pagevec
  */
@@ -396,9 +354,6 @@ static void lru_drain_cache(unsigned int
 	/* CPU is dead, so no locking needed. */
 	if (pagevec_count(pvec))
 		__pagevec_lru_add(pvec);
-	pvec = &per_cpu(lru_add_active_pvecs, cpu);
-	if (pagevec_count(pvec))
-		__pagevec_lru_add_active(pvec);
 }
 
 /* Drop the CPU's cached committed space back into the central pool. */
Index: linux-2.6-git/mm/swap_state.c
===================================================================
--- linux-2.6-git.orig/mm/swap_state.c
+++ linux-2.6-git/mm/swap_state.c
@@ -359,7 +359,7 @@ struct page *read_swap_cache_async(swp_e
 			/*
 			 * Initiate read into locked page and return.
 			 */
-			lru_cache_add_active(new_page);
+			lru_cache_add(new_page);
 			swap_readpage(NULL, new_page);
 			return new_page;
 		}
Index: linux-2.6-git/mm/vmscan.c
===================================================================
--- linux-2.6-git.orig/mm/vmscan.c
+++ linux-2.6-git/mm/vmscan.c
@@ -364,6 +364,7 @@ static int shrink_list(struct list_head 
 	pagevec_init(&freed_pvec, 1);
 	while (!list_empty(page_list)) {
 		struct address_space *mapping;
+		struct zone *zone;
 		struct page *page;
 		int may_enter_fs;
 		int referenced;
@@ -376,8 +377,6 @@ static int shrink_list(struct list_head 
 		if (TestSetPageLocked(page))
 			goto keep;
 
-		BUG_ON(PageActive(page));
-
 		sc->nr_scanned++;
 		/* Double the slab pressure for mapped and swapcache pages */
 		if (page_mapped(page) || PageSwapCache(page))
@@ -483,7 +482,9 @@ static int shrink_list(struct list_head 
 		if (!mapping)
 			goto keep_locked;	/* truncate got there first */
 
-		write_lock_irq(&mapping->tree_lock);
+		zone = page_zone(page);
+		spin_lock_irq(&zone->lru_lock);
+		write_lock(&mapping->tree_lock);
 
 		/*
 		 * The non-racy check for busy page.  It is critical to check
@@ -491,26 +492,32 @@ static int shrink_list(struct list_head 
 		 * not in use by anybody. 	(pagecache + us == 2)
 		 */
 		if (page_count(page) != 2 || PageDirty(page)) {
-			write_unlock_irq(&mapping->tree_lock);
+			write_unlock(&mapping->tree_lock);
+			spin_unlock_irq(&zone->lru_lock);
 			goto keep_locked;
 		}
 
 #ifdef CONFIG_SWAP
 		if (PageSwapCache(page)) {
 			swp_entry_t swap = { .val = page->private };
+			__cart_remember(zone, page);
 			__delete_from_swap_cache(page);
-			write_unlock_irq(&mapping->tree_lock);
+			write_unlock(&mapping->tree_lock);
+			spin_unlock_irq(&zone->lru_lock);
 			swap_free(swap);
 			__put_page(page);	/* The pagecache ref */
 			goto free_it;
 		}
 #endif /* CONFIG_SWAP */
 
+		__cart_remember(zone, page);
 		__remove_from_page_cache(page);
-		write_unlock_irq(&mapping->tree_lock);
+		write_unlock(&mapping->tree_lock);
+		spin_unlock_irq(&zone->lru_lock);
 		__put_page(page);
 
 free_it:
+		ClearPageActive(page);
 		unlock_page(page);
 		reclaimed++;
 		if (!pagevec_add(&freed_pvec, page))
@@ -535,55 +542,6 @@ keep:
 }
 
 /*
- * zone->lru_lock is heavily contended.  Some of the functions that
- * shrink the lists perform better by taking out a batch of pages
- * and working on them outside the LRU lock.
- *
- * For pagecache intensive workloads, this function is the hottest
- * spot in the kernel (apart from copy_*_user functions).
- *
- * Appropriate locks must be held before calling this function.
- *
- * @nr_to_scan:	The number of pages to look through on the list.
- * @src:	The LRU list to pull pages off.
- * @dst:	The temp list to put pages on to.
- * @scanned:	The number of pages that were scanned.
- *
- * returns how many pages were moved onto *@dst.
- */
-static int isolate_lru_pages(int nr_to_scan, struct list_head *src,
-			     struct list_head *dst, int *scanned)
-{
-	int nr_taken = 0;
-	struct page *page;
-	int scan = 0;
-
-	while (scan++ < nr_to_scan && !list_empty(src)) {
-		page = lru_to_page(src);
-		prefetchw_prev_lru_page(page, src, flags);
-
-		if (!TestClearPageLRU(page))
-			BUG();
-		list_del(&page->lru);
-		if (get_page_testone(page)) {
-			/*
-			 * It is being freed elsewhere
-			 */
-			__put_page(page);
-			SetPageLRU(page);
-			list_add(&page->lru, src);
-			continue;
-		} else {
-			list_add(&page->lru, dst);
-			nr_taken++;
-		}
-	}
-
-	*scanned = scan;
-	return nr_taken;
-}
-
-/*
  * shrink_cache() adds the number of pages reclaimed to sc->nr_reclaimed
  */
 static void shrink_cache(struct zone *zone, struct scan_control *sc)
@@ -595,19 +553,16 @@ static void shrink_cache(struct zone *zo
 	pagevec_init(&pvec, 1);
 
 	lru_add_drain();
-	spin_lock_irq(&zone->lru_lock);
 	while (max_scan > 0) {
-		struct page *page;
 		int nr_taken;
-		int nr_scan;
+		unsigned long nr_scan = 0;
 		int nr_freed;
 
-		nr_taken = isolate_lru_pages(sc->swap_cluster_max,
-					     &zone->inactive_list,
-					     &page_list, &nr_scan);
-		zone->nr_inactive -= nr_taken;
+		nr_taken = cart_replace(zone, &page_list, sc->swap_cluster_max,
+					&nr_scan, sc->priority <= 0);
+		/* we race a bit, do we care? */
 		zone->pages_scanned += nr_scan;
-		spin_unlock_irq(&zone->lru_lock);
+		mod_page_state_zone(zone, pgrefill, nr_scan);
 
 		if (nr_taken == 0)
 			goto done;
@@ -623,220 +578,44 @@ static void shrink_cache(struct zone *zo
 		mod_page_state_zone(zone, pgsteal, nr_freed);
 		sc->nr_to_reclaim -= nr_freed;
 
-		spin_lock_irq(&zone->lru_lock);
 		/*
 		 * Put back any unfreeable pages.
 		 */
-		while (!list_empty(&page_list)) {
-			page = lru_to_page(&page_list);
-			if (TestSetPageLRU(page))
-				BUG();
-			list_del(&page->lru);
-			if (PageActive(page))
-				add_page_to_active_list(zone, page);
-			else
-				add_page_to_inactive_list(zone, page);
-			if (!pagevec_add(&pvec, page)) {
-				spin_unlock_irq(&zone->lru_lock);
-				__pagevec_release(&pvec);
-				spin_lock_irq(&zone->lru_lock);
-			}
-		}
+		cart_reinsert(zone, &page_list);
   	}
-	spin_unlock_irq(&zone->lru_lock);
 done:
 	pagevec_release(&pvec);
 }
 
 /*
- * This moves pages from the active list to the inactive list.
- *
- * We move them the other way if the page is referenced by one or more
- * processes, from rmap.
- *
- * If the pages are mostly unmapped, the processing is fast and it is
- * appropriate to hold zone->lru_lock across the whole operation.  But if
- * the pages are mapped, the processing is slow (page_referenced()) so we
- * should drop zone->lru_lock around each page.  It's impossible to balance
- * this, so instead we remove the pages from the LRU while processing them.
- * It is safe to rely on PG_active against the non-LRU pages in here because
- * nobody will play with that bit on a non-LRU page.
- *
- * The downside is that we have to touch page->_count against each page.
- * But we had to alter page->flags anyway.
- */
-static void
-refill_inactive_zone(struct zone *zone, struct scan_control *sc)
-{
-	int pgmoved;
-	int pgdeactivate = 0;
-	int pgscanned;
-	int nr_pages = sc->nr_to_scan;
-	LIST_HEAD(l_hold);	/* The pages which were snipped off */
-	LIST_HEAD(l_inactive);	/* Pages to go onto the inactive_list */
-	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
-	struct page *page;
-	struct pagevec pvec;
-	int reclaim_mapped = 0;
-	long mapped_ratio;
-	long distress;
-	long swap_tendency;
-
-	lru_add_drain();
-	spin_lock_irq(&zone->lru_lock);
-	pgmoved = isolate_lru_pages(nr_pages, &zone->active_list,
-				    &l_hold, &pgscanned);
-	zone->pages_scanned += pgscanned;
-	zone->nr_active -= pgmoved;
-	spin_unlock_irq(&zone->lru_lock);
-
-	/*
-	 * `distress' is a measure of how much trouble we're having reclaiming
-	 * pages.  0 -> no problems.  100 -> great trouble.
-	 */
-	distress = 100 >> zone->prev_priority;
-
-	/*
-	 * The point of this algorithm is to decide when to start reclaiming
-	 * mapped memory instead of just pagecache.  Work out how much memory
-	 * is mapped.
-	 */
-	mapped_ratio = (sc->nr_mapped * 100) / total_memory;
-
-	/*
-	 * Now decide how much we really want to unmap some pages.  The mapped
-	 * ratio is downgraded - just because there's a lot of mapped memory
-	 * doesn't necessarily mean that page reclaim isn't succeeding.
-	 *
-	 * The distress ratio is important - we don't want to start going oom.
-	 *
-	 * A 100% value of vm_swappiness overrides this algorithm altogether.
-	 */
-	swap_tendency = mapped_ratio / 2 + distress + vm_swappiness;
-
-	/*
-	 * Now use this metric to decide whether to start moving mapped memory
-	 * onto the inactive list.
-	 */
-	if (swap_tendency >= 100)
-		reclaim_mapped = 1;
-
-	while (!list_empty(&l_hold)) {
-		cond_resched();
-		page = lru_to_page(&l_hold);
-		list_del(&page->lru);
-		if (page_mapped(page)) {
-			if (!reclaim_mapped ||
-			    (total_swap_pages == 0 && PageAnon(page)) ||
-			    page_referenced(page, 0, sc->priority <= 0)) {
-				list_add(&page->lru, &l_active);
-				continue;
-			}
-		}
-		list_add(&page->lru, &l_inactive);
-	}
-
-	pagevec_init(&pvec, 1);
-	pgmoved = 0;
-	spin_lock_irq(&zone->lru_lock);
-	while (!list_empty(&l_inactive)) {
-		page = lru_to_page(&l_inactive);
-		prefetchw_prev_lru_page(page, &l_inactive, flags);
-		if (TestSetPageLRU(page))
-			BUG();
-		if (!TestClearPageActive(page))
-			BUG();
-		list_move(&page->lru, &zone->inactive_list);
-		pgmoved++;
-		if (!pagevec_add(&pvec, page)) {
-			zone->nr_inactive += pgmoved;
-			spin_unlock_irq(&zone->lru_lock);
-			pgdeactivate += pgmoved;
-			pgmoved = 0;
-			if (buffer_heads_over_limit)
-				pagevec_strip(&pvec);
-			__pagevec_release(&pvec);
-			spin_lock_irq(&zone->lru_lock);
-		}
-	}
-	zone->nr_inactive += pgmoved;
-	pgdeactivate += pgmoved;
-	if (buffer_heads_over_limit) {
-		spin_unlock_irq(&zone->lru_lock);
-		pagevec_strip(&pvec);
-		spin_lock_irq(&zone->lru_lock);
-	}
-
-	pgmoved = 0;
-	while (!list_empty(&l_active)) {
-		page = lru_to_page(&l_active);
-		prefetchw_prev_lru_page(page, &l_active, flags);
-		if (TestSetPageLRU(page))
-			BUG();
-		BUG_ON(!PageActive(page));
-		list_move(&page->lru, &zone->active_list);
-		pgmoved++;
-		if (!pagevec_add(&pvec, page)) {
-			zone->nr_active += pgmoved;
-			pgmoved = 0;
-			spin_unlock_irq(&zone->lru_lock);
-			__pagevec_release(&pvec);
-			spin_lock_irq(&zone->lru_lock);
-		}
-	}
-	zone->nr_active += pgmoved;
-	spin_unlock_irq(&zone->lru_lock);
-	pagevec_release(&pvec);
-
-	mod_page_state_zone(zone, pgrefill, pgscanned);
-	mod_page_state(pgdeactivate, pgdeactivate);
-}
-
-/*
  * This is a basic per-zone page freer.  Used by both kswapd and direct reclaim.
  */
 static void
 shrink_zone(struct zone *zone, struct scan_control *sc)
 {
 	unsigned long nr_active;
-	unsigned long nr_inactive;
 
 	/*
 	 * Add one to `nr_to_scan' just to make sure that the kernel will
 	 * slowly sift through the active list.
 	 */
-	zone->nr_scan_active += (zone->nr_active >> sc->priority) + 1;
+	zone->nr_scan_active += ((zone->nr_active + zone->nr_inactive) >> sc->priority) + 1;
 	nr_active = zone->nr_scan_active;
 	if (nr_active >= sc->swap_cluster_max)
 		zone->nr_scan_active = 0;
 	else
 		nr_active = 0;
 
-	zone->nr_scan_inactive += (zone->nr_inactive >> sc->priority) + 1;
-	nr_inactive = zone->nr_scan_inactive;
-	if (nr_inactive >= sc->swap_cluster_max)
-		zone->nr_scan_inactive = 0;
-	else
-		nr_inactive = 0;
 
 	sc->nr_to_reclaim = sc->swap_cluster_max;
 
-	while (nr_active || nr_inactive) {
-		if (nr_active) {
-			sc->nr_to_scan = min(nr_active,
-					(unsigned long)sc->swap_cluster_max);
-			nr_active -= sc->nr_to_scan;
-			refill_inactive_zone(zone, sc);
-		}
-
-		if (nr_inactive) {
-			sc->nr_to_scan = min(nr_inactive,
-					(unsigned long)sc->swap_cluster_max);
-			nr_inactive -= sc->nr_to_scan;
-			shrink_cache(zone, sc);
-			if (sc->nr_to_reclaim <= 0)
-				break;
-		}
+	while (nr_active) {
+		sc->nr_to_scan = min(nr_active,
+				     (unsigned long)sc->swap_cluster_max);
+		nr_active -= sc->nr_to_scan;
+		shrink_cache(zone, sc);
+		if (sc->nr_to_reclaim <= 0)
+			break;
 	}
 
 	throttle_vm_writeout();
@@ -959,6 +738,7 @@ int try_to_free_pages(struct zone **zone
 		if (sc.nr_scanned && priority < DEF_PRIORITY - 2)
 			blk_congestion_wait(WRITE, HZ/10);
 	}
+	ret = !!total_reclaimed;
 out:
 	for (i = 0; zones[i] != 0; i++) {
 		struct zone *zone = zones[i];

--
