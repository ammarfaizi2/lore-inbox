Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265826AbTGIIep (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 04:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbTGIIeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 04:34:31 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:53418 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265826AbTGIIcg
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 9 Jul 2003 04:32:36 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16139.54928.435252.933882@laputa.namesys.com>
Date: Wed, 9 Jul 2003 12:47:12 +0400
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: [PATCH] 3/5 VM changes: dont-rotate-active-list.patch
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently, if zone is short on free pages, refill_inactive_zone() starts
moving pages from active_list to inactive_list, rotating active_list as it
goes. That is, pages from the tail of active_list are transferred to its head,
thus destroying lru ordering, exactly when we need it most --- when system is
low on free memory and page replacement has to be performed.

This patch modifies refill_inactive_zone() so that it scans active_list
without rotating it. To achieve this, special dummy page zone->scan_page
is maintained for each zone. This page marks a place in the active_list
reached during scanning.

As an additional bonus, if memory pressure is not so big as to start swapping
mapped pages (reclaim_mapped == 0 in refill_inactive_zone()), then not
referenced mapped pages can be left behind zone->scan_page instead of moving
them to the head of active_list. When reclaim_mapped mode is activated,
zone->scan_page is reset back to the tail of active_list so that these pages
can be re-scanned.



diff -puN include/linux/mmzone.h~dont-rotate-active-list include/linux/mmzone.h
--- i386/include/linux/mmzone.h~dont-rotate-active-list	Wed Jul  9 12:24:51 2003
+++ i386-god/include/linux/mmzone.h	Wed Jul  9 12:24:51 2003
@@ -146,6 +146,12 @@ struct zone {
 	/* zone_start_pfn == zone_start_paddr >> PAGE_SHIFT */
 	unsigned long		zone_start_pfn;
 
+	/* 
+	 * dummy page used as place holder during scanning of
+	 * active_list in refill_inactive_zone()
+	 */
+	struct page *scan_page;
+
 	/*
 	 * rarely used fields:
 	 */
diff -puN mm/page_alloc.c~dont-rotate-active-list mm/page_alloc.c
--- i386/mm/page_alloc.c~dont-rotate-active-list	Wed Jul  9 12:24:51 2003
+++ i386-god/mm/page_alloc.c	Wed Jul  9 12:24:51 2003
@@ -1201,6 +1201,9 @@ void __init memmap_init_zone(struct page
 	memmap_init_zone((start), (size), (nid), (zone), (start_pfn))
 #endif
 
+/* dummy pages used to scan active lists */
+static struct page scan_pages[MAX_NR_NODES][MAX_NR_ZONES];
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -1223,6 +1226,7 @@ static void __init free_area_init_core(s
 		struct zone *zone = pgdat->node_zones + j;
 		unsigned long size, realsize;
 		unsigned long batch;
+		struct page *scan_page;
 
 		zone_table[nid * MAX_NR_ZONES + j] = zone;
 		realsize = size = zones_size[j];
@@ -1275,6 +1279,22 @@ static void __init free_area_init_core(s
 		atomic_set(&zone->refill_counter, 0);
 		zone->nr_active = 0;
 		zone->nr_inactive = 0;
+
+		/* initialize dummy page used for scanning */
+		scan_page = &scan_pages[nid][j];
+		zone->scan_page = scan_page;
+		memset(scan_page, 0, sizeof *scan_page);
+		scan_page->flags = 
+			(1 << PG_locked) |
+			(1 << PG_error) |
+			(1 << PG_lru) |
+			(1 << PG_active) |
+			(1 << PG_reserved);
+		set_page_zone(scan_page, j);
+		page_cache_get(scan_page);
+		INIT_LIST_HEAD(&scan_page->list);
+		list_add(&scan_page->lru, &zone->active_list);
+
 		if (!size)
 			continue;
 
diff -puN mm/vmscan.c~dont-rotate-active-list mm/vmscan.c
--- i386/mm/vmscan.c~dont-rotate-active-list	Wed Jul  9 12:24:51 2003
+++ i386-god/mm/vmscan.c	Wed Jul  9 12:24:51 2003
@@ -49,14 +49,15 @@
 int vm_swappiness = 60;
 static long total_memory;
 
+#define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
+
 #ifdef ARCH_HAS_PREFETCH
 #define prefetch_prev_lru_page(_page, _base, _field)			\
 	do {								\
 		if ((_page)->lru.prev != _base) {			\
 			struct page *prev;				\
 									\
-			prev = list_entry(_page->lru.prev,		\
-					struct page, lru);		\
+			prev = lru_to_page(&(_page)->lru);		\
 			prefetch(&prev->_field);			\
 		}							\
 	} while (0)
@@ -70,8 +71,7 @@ static long total_memory;
 		if ((_page)->lru.prev != _base) {			\
 			struct page *prev;				\
 									\
-			prev = list_entry(_page->lru.prev,		\
-					struct page, lru);		\
+			prev = lru_to_page(&(_page)->lru);		\
 			prefetchw(&prev->_field);			\
 		}							\
 	} while (0)
@@ -350,7 +350,7 @@ shrink_list(struct list_head *page_list,
 		struct page *page;
 		int may_enter_fs;
 
-		page = list_entry(page_list->prev, struct page, lru);
+		page = lru_to_page(page_list);
 		list_del(&page->lru);
 
 		if (TestSetPageLocked(page))
@@ -552,8 +552,7 @@ shrink_cache(const int nr_pages, struct 
 
 		while (nr_scan++ < nr_to_process &&
 				!list_empty(&zone->inactive_list)) {
-			page = list_entry(zone->inactive_list.prev,
-						struct page, lru);
+			page = lru_to_page(&zone->inactive_list);
 
 			prefetchw_prev_lru_page(page,
 						&zone->inactive_list, flags);
@@ -591,7 +590,7 @@ shrink_cache(const int nr_pages, struct 
 		 * Put back any unfreeable pages.
 		 */
 		while (!list_empty(&page_list)) {
-			page = list_entry(page_list.prev, struct page, lru);
+			page = lru_to_page(&page_list);
 			if (TestSetPageLRU(page))
 				BUG();
 			list_del(&page->lru);
@@ -612,6 +611,39 @@ done:
 	return ret;
 }
 
+
+/* move pages from @page_list to the @spot, that should be somewhere on the
+ * @zone->active_list */
+static int
+spill_on_spot(struct zone *zone, 
+	      struct list_head *page_list, struct list_head *spot,
+	      struct pagevec *pvec)
+{
+	struct page *page;
+	int          moved;
+
+	moved = 0;
+	while (!list_empty(page_list)) {
+		page = lru_to_page(page_list);
+		prefetchw_prev_lru_page(page, page_list, flags);
+		if (TestSetPageLRU(page))
+			BUG();
+		BUG_ON(!PageActive(page));
+		list_move(&page->lru, spot);
+		moved++;
+		if (!pagevec_add(pvec, page)) {
+			zone->nr_active += moved;
+			moved = 0;
+			spin_unlock_irq(&zone->lru_lock);
+			__pagevec_release(pvec);
+			spin_lock_irq(&zone->lru_lock);
+		}
+	}
+	return moved;
+}
+
+
+
 /*
  * This moves pages from the active list to the inactive list.
  *
@@ -638,37 +670,17 @@ refill_inactive_zone(struct zone *zone, 
 	int nr_pages = nr_pages_in;
 	LIST_HEAD(l_hold);	/* The pages which were snipped off */
 	LIST_HEAD(l_inactive);	/* Pages to go onto the inactive_list */
-	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
+	LIST_HEAD(l_ignore);	/* Pages to be returned to the active_list */
+	LIST_HEAD(l_active);	/* Pages to go onto the head of the
+				 * active_list */
 	struct page *page;
+	struct page *scan;
 	struct pagevec pvec;
 	int reclaim_mapped = 0;
 	long mapped_ratio;
 	long distress;
 	long swap_tendency;
 
-	lru_add_drain();
-	pgmoved = 0;
-	spin_lock_irq(&zone->lru_lock);
-	while (nr_pages && !list_empty(&zone->active_list)) {
-		page = list_entry(zone->active_list.prev, struct page, lru);
-		prefetchw_prev_lru_page(page, &zone->active_list, flags);
-		if (!TestClearPageLRU(page))
-			BUG();
-		list_del(&page->lru);
-		if (page_count(page) == 0) {
-			/* It is currently in pagevec_release() */
-			SetPageLRU(page);
-			list_add(&page->lru, &zone->active_list);
-		} else {
-			page_cache_get(page);
-			list_add(&page->lru, &l_hold);
-			pgmoved++;
-		}
-		nr_pages--;
-	}
-	zone->nr_active -= pgmoved;
-	spin_unlock_irq(&zone->lru_lock);
-
 	/*
 	 * `distress' is a measure of how much trouble we're having reclaiming
 	 * pages.  0 -> no problems.  100 -> great trouble.
@@ -700,10 +712,53 @@ refill_inactive_zone(struct zone *zone, 
 	if (swap_tendency >= 100)
 		reclaim_mapped = 1;
 
+	scan = zone->scan_page;
+	lru_add_drain();
+	pgmoved = 0;
+	spin_lock_irq(&zone->lru_lock);
+	if (reclaim_mapped) {
+		/*
+		 * When scanning active_list with !reclaim_mapped mapped
+		 * inactive pages are left behind zone->scan_page. If zone is
+		 * switched to reclaim_mapped mode reset zone->scan_page to
+		 * the end of inactive list so that inactive mapped pages are
+		 * re-scanned.
+		 */
+		list_move_tail(&scan->lru, &zone->active_list);
+	}
+	while (nr_pages && zone->active_list.prev != zone->active_list.next) {
+		/*
+		 * if head of active list reached---wrap to the tail
+		 */
+		if (scan->lru.prev == &zone->active_list)
+			list_move_tail(&scan->lru, &zone->active_list);
+		page = lru_to_page(&scan->lru);
+		prefetchw_prev_lru_page(page, &zone->active_list, flags);
+		if (!TestClearPageLRU(page))
+			BUG();
+		list_del(&page->lru);
+		if (page_count(page) == 0) {
+			/* It is currently in pagevec_release() */
+			SetPageLRU(page);
+			list_add(&page->lru, &zone->active_list);
+		} else {
+			page_cache_get(page);
+			list_add(&page->lru, &l_hold);
+			pgmoved++;
+		}
+		nr_pages--;
+	}
+	zone->nr_active -= pgmoved;
+	spin_unlock_irq(&zone->lru_lock);
+
 	while (!list_empty(&l_hold)) {
-		page = list_entry(l_hold.prev, struct page, lru);
+		page = lru_to_page(&l_hold);
 		list_del(&page->lru);
 		if (page_mapped(page)) {
+			/*
+			 * probably it would be useful to transfer dirty bit
+			 * from pte to the @page here.
+			 */
 			pte_chain_lock(page);
 			if (page_mapped(page) && page_referenced(page)) {
 				pte_chain_unlock(page);
@@ -712,7 +767,7 @@ refill_inactive_zone(struct zone *zone, 
 			}
 			pte_chain_unlock(page);
 			if (!reclaim_mapped) {
-				list_add(&page->lru, &l_active);
+				list_add(&page->lru, &l_ignore);
 				continue;
 			}
 		}
@@ -732,7 +787,7 @@ refill_inactive_zone(struct zone *zone, 
 	pgmoved = 0;
 	spin_lock_irq(&zone->lru_lock);
 	while (!list_empty(&l_inactive)) {
-		page = list_entry(l_inactive.prev, struct page, lru);
+		page = lru_to_page(&l_inactive);
 		prefetchw_prev_lru_page(page, &l_inactive, flags);
 		if (TestSetPageLRU(page))
 			BUG();
@@ -760,23 +815,9 @@ refill_inactive_zone(struct zone *zone, 
 		spin_lock_irq(&zone->lru_lock);
 	}
 
-	pgmoved = 0;
-	while (!list_empty(&l_active)) {
-		page = list_entry(l_active.prev, struct page, lru);
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
+	pgmoved = spill_on_spot(zone, &l_active, &zone->active_list, &pvec);
+	zone->nr_active += pgmoved;
+	pgmoved = spill_on_spot(zone, &l_ignore, &scan->lru, &pvec);
 	zone->nr_active += pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
 	pagevec_release(&pvec);

_
