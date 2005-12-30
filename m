Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbVL3WoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbVL3WoZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbVL3WoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:44:07 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.17]:60450 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S964867AbVL3Wnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:43:46 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051230224322.765.51438.sendpatchset@twins.localnet>
In-Reply-To: <20051230223952.765.21096.sendpatchset@twins.localnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
Subject: [PATCH 7/9] clockpro-remove-old.patch
Date: Fri, 30 Dec 2005 23:43:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Remove the old page replacement code, unused now.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
 
 mm/page_replace.c |  298 ------------------------------------------------------
 1 file changed, 298 deletions(-)

Index: linux-2.6-git/mm/page_replace.c
===================================================================
--- linux-2.6-git.orig/mm/page_replace.c
+++ /dev/null
@@ -1,298 +0,0 @@
-#include <linux/mm_page_replace.h>
-#include <linux/swap.h>
-#include <linux/pagevec.h>
-#include <linux/init.h>
-#include <linux/rmap.h>
-#include <linux/buffer_head.h>	/* for try_to_release_page(),
-					buffer_heads_over_limit */
-
-/*
- * From 0 .. 100.  Higher means more swappy.
- */
-int vm_swappiness = 60;
-static long total_memory;
-
-static void refill_inactive_zone(struct zone *, int);
-
-static int __init page_replace_init(void)
-{
-	total_memory = nr_free_pagecache_pages();
-	return 0;
-}
-
-module_init(page_replace_init)
-
-void __init page_replace_init_zone(struct zone *zone)
-{
-	INIT_LIST_HEAD(&zone->active_list);
-	INIT_LIST_HEAD(&zone->inactive_list);
-	zone->nr_active = 0;
-	zone->nr_inactive = 0;
-	zone->nr_scan_active = 0;
-}
-
-static inline void
-add_page_to_inactive_list(struct zone *zone, struct page *page)
-{
-	list_add(&page->lru, &zone->inactive_list);
-	zone->nr_inactive++;
-}
-
-void __page_replace_insert(struct zone *zone, struct page *page)
-{
-	if (PageActive(page))
-		add_page_to_active_list(zone, page);
-	else
-		add_page_to_inactive_list(zone, page);
-}
-
-/*
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
-void page_replace_candidates(struct zone *zone, int nr_to_scan, struct list_head *page_list)
-{
-	int nr_taken;
-	int nr_scan;
-	unsigned long long nr_scan_active;
-
-	spin_lock_irq(&zone->lru_lock);
-	nr_taken = isolate_lru_pages(nr_to_scan, &zone->inactive_list,
-				     page_list, &nr_scan);
-	zone->nr_inactive -= nr_taken;
-	zone->pages_scanned += nr_scan;
-	spin_unlock_irq(&zone->lru_lock);
-
-	if (current_is_kswapd())
-		mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
-	else
-		mod_page_state_zone(zone, pgscan_direct, nr_scan);
-
-	/*
-	 * Add one to `nr_to_scan' just to make sure that the kernel will
-	 * slowly sift through the active list.
-	 */
-	nr_scan_active = (nr_scan + 1ULL) * zone->nr_active * 1024ULL;
-	do_div(nr_scan_active, zone->nr_inactive + nr_taken + 1UL);
-	zone->nr_scan_active += nr_scan_active;
-	while (zone->nr_scan_active >= SWAP_CLUSTER_MAX * 1024UL) {
-		zone->nr_scan_active -= SWAP_CLUSTER_MAX * 1024UL;
-		refill_inactive_zone(zone, SWAP_CLUSTER_MAX);
-	}
-}
-
-/*
- * Put back any unfreeable pages.
- */
-void page_replace_reinsert(struct zone *zone, struct list_head *page_list)
-{
-	struct pagevec pvec;
-
-	pagevec_init(&pvec, 1);
-	spin_lock_irq(&zone->lru_lock);
-	while (!list_empty(page_list)) {
-		struct page *page = lru_to_page(page_list);
-		BUG_ON(PageLRU(page));
-		SetPageLRU(page);
-		list_del(&page->lru);
-		if (PageActive(page))
-			add_page_to_active_list(zone, page);
-		else
-			add_page_to_inactive_list(zone, page);
-		if (!pagevec_add(&pvec, page)) {
-			spin_unlock_irq(&zone->lru_lock);
-			__pagevec_release(&pvec);
-			spin_lock_irq(&zone->lru_lock);
-		}
-	}
-	spin_unlock_irq(&zone->lru_lock);
-	pagevec_release(&pvec);
-}
-
-/*
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
-static void refill_inactive_zone(struct zone *zone, int nr_pages)
-{
-	int pgmoved;
-	int pgdeactivate = 0;
-	int pgscanned;
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
-	mapped_ratio = (read_page_state(nr_mapped) * 100) / total_memory;
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
-			    page_referenced(page, 0, 0)) {
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
