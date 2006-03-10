Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWCJDoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWCJDoP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 22:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbWCJDoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 22:44:15 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:14511 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932322AbWCJDoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 22:44:14 -0500
From: Magnus Damm <magnus@valinux.co.jp>
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: Magnus Damm <magnus@valinux.co.jp>
Message-Id: <20060310034417.8340.49483.sendpatchset@cherry.local>
In-Reply-To: <20060310034412.8340.90939.sendpatchset@cherry.local>
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
Subject: [PATCH 01/03] Unmapped: Implement two LRU:s
Date: Fri, 10 Mar 2006 12:44:13 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use separate LRU:s for mapped and unmapped pages.

This patch creates two instances of "struct lru" per zone, both protected by
zone->lru_lock. A new bit in page->flags named PG_mapped is used to determine
which LRU the page belongs to. The rmap code is changed to move pages to the 
mapped LRU, while the vmscan code moves pages back to the unmapped LRU when 
needed. Pages moved to the mapped LRU are added to the inactive list, while
pages moved back to the unmapped LRU are added to the active list.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 include/linux/mm_inline.h  |   77 ++++++++++++++++++++++++++++++++------
 include/linux/mmzone.h     |   21 +++++++---
 include/linux/page-flags.h |    5 ++
 mm/page_alloc.c            |   44 ++++++++++++++--------
 mm/rmap.c                  |   32 ++++++++++++++++
 mm/swap.c                  |   17 ++++++--
 mm/vmscan.c                |   88 +++++++++++++++++++++++++-------------------
 7 files changed, 208 insertions(+), 76 deletions(-)

--- from-0002/include/linux/mm_inline.h
+++ to-work/include/linux/mm_inline.h	2006-03-06 16:21:30.000000000 +0900
@@ -1,41 +1,94 @@
 
 static inline void
-add_page_to_active_list(struct zone *zone, struct page *page)
+add_page_to_active_list(struct lru *lru, struct page *page)
 {
-	list_add(&page->lru, &zone->active_list);
-	zone->nr_active++;
+	list_add(&page->lru, &lru->active_list);
+	lru->nr_active++;
 }
 
 static inline void
-add_page_to_inactive_list(struct zone *zone, struct page *page)
+add_page_to_inactive_list(struct lru *lru, struct page *page)
 {
-	list_add(&page->lru, &zone->inactive_list);
-	zone->nr_inactive++;
+	list_add(&page->lru, &lru->inactive_list);
+	lru->nr_inactive++;
 }
 
 static inline void
-del_page_from_active_list(struct zone *zone, struct page *page)
+del_page_from_active_list(struct lru *lru, struct page *page)
 {
 	list_del(&page->lru);
-	zone->nr_active--;
+	lru->nr_active--;
 }
 
 static inline void
-del_page_from_inactive_list(struct zone *zone, struct page *page)
+del_page_from_inactive_list(struct lru *lru, struct page *page)
 {
 	list_del(&page->lru);
-	zone->nr_inactive--;
+	lru->nr_inactive--;
+}
+
+static inline struct lru *page_lru(struct zone *zone, struct page *page)
+{
+	return &zone->lru[PageMapped(page) ? LRU_MAPPED : LRU_UNMAPPED];
+}
+
+static inline int may_become_unmapped(struct page *page)
+{
+	if (!page_mapped(page) && PageMapped(page)) {
+		ClearPageMapped(page);
+		return 1;
+	}
+
+	return 0;
 }
 
 static inline void
 del_page_from_lru(struct zone *zone, struct page *page)
 {
+	struct lru *lru = page_lru(zone, page);
+
 	list_del(&page->lru);
 	if (PageActive(page)) {
 		ClearPageActive(page);
-		zone->nr_active--;
+		lru->nr_active--;
 	} else {
-		zone->nr_inactive--;
+		lru->nr_inactive--;
 	}
 }
 
+static inline unsigned long active_pages(struct zone *zone)
+{
+	unsigned long sum;
+
+	sum = zone->lru[LRU_MAPPED].nr_active;
+	sum += zone->lru[LRU_UNMAPPED].nr_active;
+	return sum;
+}
+
+static inline unsigned long inactive_pages(struct zone *zone)
+{
+	unsigned long sum;
+
+	sum = zone->lru[LRU_MAPPED].nr_inactive;
+	sum += zone->lru[LRU_UNMAPPED].nr_inactive;
+	return sum;
+}
+
+static inline unsigned long active_pages_scanned(struct zone *zone)
+{
+	unsigned long sum;
+
+	sum = zone->lru[LRU_MAPPED].nr_scan_active;
+	sum += zone->lru[LRU_UNMAPPED].nr_scan_active;
+	return sum;
+}
+
+static inline unsigned long inactive_pages_scanned(struct zone *zone)
+{
+	unsigned long sum;
+
+	sum = zone->lru[LRU_MAPPED].nr_scan_inactive;
+	sum += zone->lru[LRU_UNMAPPED].nr_scan_inactive;
+	return sum;
+}
+
--- from-0002/include/linux/mmzone.h
+++ to-work/include/linux/mmzone.h	2006-03-06 16:21:30.000000000 +0900
@@ -117,6 +117,18 @@ struct per_cpu_pageset {
  * ZONE_HIGHMEM	 > 896 MB	only page cache and user processes
  */
 
+struct lru {
+	struct list_head	active_list;
+	struct list_head	inactive_list;
+	unsigned long		nr_active;
+	unsigned long		nr_inactive;
+	unsigned long		nr_scan_active;
+	unsigned long		nr_scan_inactive;
+};
+
+#define LRU_MAPPED 0
+#define LRU_UNMAPPED 1
+
 struct zone {
 	/* Fields commonly accessed by the page allocator */
 	unsigned long		free_pages;
@@ -150,13 +162,8 @@ struct zone {
 	ZONE_PADDING(_pad1_)
 
 	/* Fields commonly accessed by the page reclaim scanner */
-	spinlock_t		lru_lock;	
-	struct list_head	active_list;
-	struct list_head	inactive_list;
-	unsigned long		nr_scan_active;
-	unsigned long		nr_scan_inactive;
-	unsigned long		nr_active;
-	unsigned long		nr_inactive;
+	spinlock_t		lru_lock;
+	struct lru		lru[2]; /* LRU_MAPPED, LRU_UNMAPPED */
 	unsigned long		pages_scanned;	   /* since last reclaim */
 	int			all_unreclaimable; /* All pages pinned */
 
--- from-0002/include/linux/page-flags.h
+++ to-work/include/linux/page-flags.h	2006-03-06 16:21:30.000000000 +0900
@@ -75,6 +75,7 @@
 #define PG_reclaim		17	/* To be reclaimed asap */
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
+#define PG_mapped		20	/* Page might be mapped in a vma */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -344,6 +345,10 @@ extern void __mod_page_state_offset(unsi
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageMapped(page)	test_bit(PG_mapped, &(page)->flags)
+#define SetPageMapped(page)	set_bit(PG_mapped, &(page)->flags)
+#define ClearPageMapped(page)	clear_bit(PG_mapped, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
--- from-0002/mm/page_alloc.c
+++ to-work/mm/page_alloc.c	2006-03-06 16:22:48.000000000 +0900
@@ -37,6 +37,7 @@
 #include <linux/nodemask.h>
 #include <linux/vmalloc.h>
 #include <linux/mempolicy.h>
+#include <linux/mm_inline.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -1314,8 +1315,8 @@ void __get_zone_counts(unsigned long *ac
 	*inactive = 0;
 	*free = 0;
 	for (i = 0; i < MAX_NR_ZONES; i++) {
-		*active += zones[i].nr_active;
-		*inactive += zones[i].nr_inactive;
+		*active += active_pages(&zones[i]);
+		*inactive += inactive_pages(&zones[i]);
 		*free += zones[i].free_pages;
 	}
 }
@@ -1448,8 +1449,8 @@ void show_free_areas(void)
 			K(zone->pages_min),
 			K(zone->pages_low),
 			K(zone->pages_high),
-			K(zone->nr_active),
-			K(zone->nr_inactive),
+			K(active_pages(zone)),
+			K(inactive_pages(zone)),
 			K(zone->present_pages),
 			zone->pages_scanned,
 			(zone->all_unreclaimable ? "yes" : "no")
@@ -2034,6 +2035,16 @@ static __meminit void init_currently_emp
 	zone_init_free_lists(pgdat, zone, zone->spanned_pages);
 }
 
+static void __init init_lru(struct lru *lru)
+{
+	INIT_LIST_HEAD(&lru->active_list);
+	INIT_LIST_HEAD(&lru->inactive_list);
+	lru->nr_active = 0;
+	lru->nr_inactive = 0;
+	lru->nr_scan_active = 0;
+	lru->nr_scan_inactive = 0;
+}
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -2076,12 +2087,10 @@ static void __init free_area_init_core(s
 		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;
 
 		zone_pcp_init(zone);
-		INIT_LIST_HEAD(&zone->active_list);
-		INIT_LIST_HEAD(&zone->inactive_list);
-		zone->nr_scan_active = 0;
-		zone->nr_scan_inactive = 0;
-		zone->nr_active = 0;
-		zone->nr_inactive = 0;
+
+		init_lru(&zone->lru[LRU_MAPPED]);
+		init_lru(&zone->lru[LRU_UNMAPPED]);
+
 		atomic_set(&zone->reclaim_in_progress, 0);
 		if (!size)
 			continue;
@@ -2228,8 +2237,8 @@ static int zoneinfo_show(struct seq_file
 			   "\n        min      %lu"
 			   "\n        low      %lu"
 			   "\n        high     %lu"
-			   "\n        active   %lu"
-			   "\n        inactive %lu"
+			   "\n        active   %lu (u: %lu m: %lu)"
+			   "\n        inactive %lu (u: %lu m: %lu)"
 			   "\n        scanned  %lu (a: %lu i: %lu)"
 			   "\n        spanned  %lu"
 			   "\n        present  %lu",
@@ -2237,10 +2246,15 @@ static int zoneinfo_show(struct seq_file
 			   zone->pages_min,
 			   zone->pages_low,
 			   zone->pages_high,
-			   zone->nr_active,
-			   zone->nr_inactive,
+			   active_pages(zone),
+			   zone->lru[LRU_UNMAPPED].nr_active,
+			   zone->lru[LRU_MAPPED].nr_active,
+			   inactive_pages(zone),
+			   zone->lru[LRU_UNMAPPED].nr_inactive,
+			   zone->lru[LRU_MAPPED].nr_inactive,
 			   zone->pages_scanned,
-			   zone->nr_scan_active, zone->nr_scan_inactive,
+			   active_pages_scanned(zone),
+			   inactive_pages_scanned(zone),
 			   zone->spanned_pages,
 			   zone->present_pages);
 		seq_printf(m,
--- from-0002/mm/rmap.c
+++ to-work/mm/rmap.c	2006-03-06 16:21:30.000000000 +0900
@@ -45,6 +45,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
@@ -466,6 +467,28 @@ int page_referenced(struct page *page, i
 }
 
 /**
+ * page_move_to_mapped_lru - move page to mapped lru
+ * @page:	the page to add the mapping to
+ */
+static void page_move_to_mapped_lru(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+	struct lru *lru = &zone->lru[LRU_MAPPED];
+	unsigned long flags;
+
+	spin_lock_irqsave(&zone->lru_lock, flags);
+
+	if (PageLRU(page)) {
+		del_page_from_lru(zone, page);
+		add_page_to_inactive_list(lru, page);
+	}
+
+	SetPageMapped(page);
+
+	spin_unlock_irqrestore(&zone->lru_lock, flags);
+}
+
+/**
  * page_set_anon_rmap - setup new anonymous rmap
  * @page:	the page to add the mapping to
  * @vma:	the vm area in which the mapping is added
@@ -503,6 +526,9 @@ void page_add_anon_rmap(struct page *pag
 	if (atomic_inc_and_test(&page->_mapcount))
 		__page_set_anon_rmap(page, vma, address);
 	/* else checking page index and mapping is racy */
+
+	if (!PageMapped(page))
+		page_move_to_mapped_lru(page);
 }
 
 /*
@@ -519,6 +545,9 @@ void page_add_new_anon_rmap(struct page 
 {
 	atomic_set(&page->_mapcount, 0); /* elevate count by 1 (starts at -1) */
 	__page_set_anon_rmap(page, vma, address);
+
+	if (!PageMapped(page))
+		page_move_to_mapped_lru(page);
 }
 
 /**
@@ -534,6 +563,9 @@ void page_add_file_rmap(struct page *pag
 
 	if (atomic_inc_and_test(&page->_mapcount))
 		__inc_page_state(nr_mapped);
+
+	if (!PageMapped(page))
+		page_move_to_mapped_lru(page);
 }
 
 /**
--- from-0002/mm/swap.c
+++ to-work/mm/swap.c	2006-03-06 16:24:17.000000000 +0900
@@ -87,7 +87,8 @@ int rotate_reclaimable_page(struct page 
 	spin_lock_irqsave(&zone->lru_lock, flags);
 	if (PageLRU(page) && !PageActive(page)) {
 		list_del(&page->lru);
-		list_add_tail(&page->lru, &zone->inactive_list);
+		list_add_tail(&page->lru, 
+			      &(page_lru(zone, page)->inactive_list));
 		inc_page_state(pgrotated);
 	}
 	if (!test_clear_page_writeback(page))
@@ -105,9 +106,9 @@ void fastcall activate_page(struct page 
 
 	spin_lock_irq(&zone->lru_lock);
 	if (PageLRU(page) && !PageActive(page)) {
-		del_page_from_inactive_list(zone, page);
+		del_page_from_inactive_list(page_lru(zone, page), page);
 		SetPageActive(page);
-		add_page_to_active_list(zone, page);
+		add_page_to_active_list(page_lru(zone, page), page);
 		inc_page_state(pgactivate);
 	}
 	spin_unlock_irq(&zone->lru_lock);
@@ -215,6 +216,9 @@ void fastcall __page_cache_release(struc
 	spin_lock_irqsave(&zone->lru_lock, flags);
 	if (TestClearPageLRU(page))
 		del_page_from_lru(zone, page);
+
+	ClearPageMapped(page);
+
 	if (page_count(page) != 0)
 		page = NULL;
 	spin_unlock_irqrestore(&zone->lru_lock, flags);
@@ -268,6 +272,9 @@ void release_pages(struct page **pages, 
 		}
 		if (TestClearPageLRU(page))
 			del_page_from_lru(zone, page);
+
+		ClearPageMapped(page);
+
 		if (page_count(page) == 0) {
 			if (!pagevec_add(&pages_to_free, page)) {
 				spin_unlock_irq(&zone->lru_lock);
@@ -345,7 +352,7 @@ void __pagevec_lru_add(struct pagevec *p
 		}
 		if (TestSetPageLRU(page))
 			BUG();
-		add_page_to_inactive_list(zone, page);
+		add_page_to_inactive_list(page_lru(zone, page), page);
 	}
 	if (zone)
 		spin_unlock_irq(&zone->lru_lock);
@@ -374,7 +381,7 @@ void __pagevec_lru_add_active(struct pag
 			BUG();
 		if (TestSetPageActive(page))
 			BUG();
-		add_page_to_active_list(zone, page);
+		add_page_to_active_list(page_lru(zone, page), page);
 	}
 	if (zone)
 		spin_unlock_irq(&zone->lru_lock);
--- from-0002/mm/vmscan.c
+++ to-work/mm/vmscan.c	2006-03-06 16:45:16.000000000 +0900
@@ -1103,8 +1103,11 @@ static int isolate_lru_pages(int nr_to_s
 /*
  * shrink_cache() adds the number of pages reclaimed to sc->nr_reclaimed
  */
-static void shrink_cache(struct zone *zone, struct scan_control *sc)
+static void
+shrink_cache(struct zone *zone, int lru_nr, struct scan_control *sc)
 {
+	struct lru *lru = &zone->lru[lru_nr];
+	struct lru *new_lru;
 	LIST_HEAD(page_list);
 	struct pagevec pvec;
 	int max_scan = sc->nr_to_scan;
@@ -1120,9 +1123,9 @@ static void shrink_cache(struct zone *zo
 		int nr_freed;
 
 		nr_taken = isolate_lru_pages(sc->swap_cluster_max,
-					     &zone->inactive_list,
+					     &lru->inactive_list,
 					     &page_list, &nr_scan);
-		zone->nr_inactive -= nr_taken;
+		lru->nr_inactive -= nr_taken;
 		zone->pages_scanned += nr_scan;
 		spin_unlock_irq(&zone->lru_lock);
 
@@ -1148,11 +1151,14 @@ static void shrink_cache(struct zone *zo
 			page = lru_to_page(&page_list);
 			if (TestSetPageLRU(page))
 				BUG();
+			if (may_become_unmapped(page))
+				SetPageActive(page);
+			new_lru = page_lru(zone, page);
 			list_del(&page->lru);
 			if (PageActive(page))
-				add_page_to_active_list(zone, page);
+				add_page_to_active_list(new_lru, page);
 			else
-				add_page_to_inactive_list(zone, page);
+				add_page_to_inactive_list(new_lru, page);
 			if (!pagevec_add(&pvec, page)) {
 				spin_unlock_irq(&zone->lru_lock);
 				__pagevec_release(&pvec);
@@ -1183,8 +1189,10 @@ done:
  * But we had to alter page->flags anyway.
  */
 static void
-refill_inactive_zone(struct zone *zone, struct scan_control *sc)
+refill_inactive_zone(struct zone *zone, int lru_nr, struct scan_control *sc)
 {
+	struct lru *lru = &zone->lru[lru_nr];
+	struct lru *new_lru;
 	int pgmoved;
 	int pgdeactivate = 0;
 	int pgscanned;
@@ -1239,10 +1247,10 @@ refill_inactive_zone(struct zone *zone, 
 
 	lru_add_drain();
 	spin_lock_irq(&zone->lru_lock);
-	pgmoved = isolate_lru_pages(nr_pages, &zone->active_list,
+	pgmoved = isolate_lru_pages(nr_pages, &lru->active_list,
 				    &l_hold, &pgscanned);
 	zone->pages_scanned += pgscanned;
-	zone->nr_active -= pgmoved;
+	lru->nr_active -= pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
 
 	while (!list_empty(&l_hold)) {
@@ -1261,54 +1269,52 @@ refill_inactive_zone(struct zone *zone, 
 	}
 
 	pagevec_init(&pvec, 1);
-	pgmoved = 0;
 	spin_lock_irq(&zone->lru_lock);
 	while (!list_empty(&l_inactive)) {
 		page = lru_to_page(&l_inactive);
 		prefetchw_prev_lru_page(page, &l_inactive, flags);
+		if (may_become_unmapped(page)) {
+			list_move(&page->lru, &l_active);
+			continue;
+		}
 		if (TestSetPageLRU(page))
 			BUG();
 		if (!TestClearPageActive(page))
 			BUG();
-		list_move(&page->lru, &zone->inactive_list);
-		pgmoved++;
+		new_lru = page_lru(zone, page);
+		list_move(&page->lru, &new_lru->inactive_list);
+		new_lru->nr_inactive++;
+		pgdeactivate++;
 		if (!pagevec_add(&pvec, page)) {
-			zone->nr_inactive += pgmoved;
 			spin_unlock_irq(&zone->lru_lock);
-			pgdeactivate += pgmoved;
-			pgmoved = 0;
 			if (buffer_heads_over_limit)
 				pagevec_strip(&pvec);
 			__pagevec_release(&pvec);
 			spin_lock_irq(&zone->lru_lock);
 		}
 	}
-	zone->nr_inactive += pgmoved;
-	pgdeactivate += pgmoved;
 	if (buffer_heads_over_limit) {
 		spin_unlock_irq(&zone->lru_lock);
 		pagevec_strip(&pvec);
 		spin_lock_irq(&zone->lru_lock);
 	}
 
-	pgmoved = 0;
 	while (!list_empty(&l_active)) {
 		page = lru_to_page(&l_active);
 		prefetchw_prev_lru_page(page, &l_active, flags);
 		if (TestSetPageLRU(page))
 			BUG();
 		BUG_ON(!PageActive(page));
-		list_move(&page->lru, &zone->active_list);
-		pgmoved++;
+		may_become_unmapped(page);
+		new_lru = page_lru(zone, page);
+		list_move(&page->lru, &new_lru->active_list);
+		new_lru->nr_active++;
 		if (!pagevec_add(&pvec, page)) {
-			zone->nr_active += pgmoved;
-			pgmoved = 0;
 			spin_unlock_irq(&zone->lru_lock);
 			__pagevec_release(&pvec);
 			spin_lock_irq(&zone->lru_lock);
 		}
 	}
-	zone->nr_active += pgmoved;
 	spin_unlock(&zone->lru_lock);
 
 	__mod_page_state_zone(zone, pgrefill, pgscanned);
@@ -1318,12 +1324,10 @@ refill_inactive_zone(struct zone *zone, 
 	pagevec_release(&pvec);
 }
 
-/*
- * This is a basic per-zone page freer.  Used by both kswapd and direct reclaim.
- */
 static void
-shrink_zone(struct zone *zone, struct scan_control *sc)
+shrink_lru(struct zone *zone, int lru_nr, struct scan_control *sc)
 {
+	struct lru *lru = &zone->lru[lru_nr];
 	unsigned long nr_active;
 	unsigned long nr_inactive;
 
@@ -1333,17 +1337,17 @@ shrink_zone(struct zone *zone, struct sc
 	 * Add one to `nr_to_scan' just to make sure that the kernel will
 	 * slowly sift through the active list.
 	 */
-	zone->nr_scan_active += (zone->nr_active >> sc->priority) + 1;
-	nr_active = zone->nr_scan_active;
+	lru->nr_scan_active += (lru->nr_active >> sc->priority) + 1;
+	nr_active = lru->nr_scan_active;
 	if (nr_active >= sc->swap_cluster_max)
-		zone->nr_scan_active = 0;
+		lru->nr_scan_active = 0;
 	else
 		nr_active = 0;
 
-	zone->nr_scan_inactive += (zone->nr_inactive >> sc->priority) + 1;
-	nr_inactive = zone->nr_scan_inactive;
+	lru->nr_scan_inactive += (lru->nr_inactive >> sc->priority) + 1;
+	nr_inactive = lru->nr_scan_inactive;
 	if (nr_inactive >= sc->swap_cluster_max)
-		zone->nr_scan_inactive = 0;
+		lru->nr_scan_inactive = 0;
 	else
 		nr_inactive = 0;
 
@@ -1352,14 +1356,14 @@ shrink_zone(struct zone *zone, struct sc
 			sc->nr_to_scan = min(nr_active,
 					(unsigned long)sc->swap_cluster_max);
 			nr_active -= sc->nr_to_scan;
-			refill_inactive_zone(zone, sc);
+			refill_inactive_zone(zone, lru_nr, sc);
 		}
 
 		if (nr_inactive) {
 			sc->nr_to_scan = min(nr_inactive,
 					(unsigned long)sc->swap_cluster_max);
 			nr_inactive -= sc->nr_to_scan;
-			shrink_cache(zone, sc);
+			shrink_cache(zone, lru_nr, sc);
 		}
 	}
 
@@ -1369,6 +1373,16 @@ shrink_zone(struct zone *zone, struct sc
 }
 
 /*
+ * This is a basic per-zone page freer. Used by both kswapd and direct reclaim.
+ */
+static void
+shrink_zone(struct zone *zone, struct scan_control *sc)
+{
+	shrink_lru(zone, LRU_UNMAPPED, sc);
+	shrink_lru(zone, LRU_MAPPED, sc);
+}
+
+/*
  * This is the direct reclaim path, for page-allocating processes.  We only
  * try to reclaim pages from zones which will satisfy the caller's allocation
  * request.
@@ -1445,7 +1459,7 @@ int try_to_free_pages(struct zone **zone
 			continue;
 
 		zone->temp_priority = DEF_PRIORITY;
-		lru_pages += zone->nr_active + zone->nr_inactive;
+		lru_pages += active_pages(zone) + inactive_pages(zone);
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
@@ -1587,7 +1601,7 @@ scan:
 		for (i = 0; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;
 
-			lru_pages += zone->nr_active + zone->nr_inactive;
+			lru_pages += active_pages(zone) + inactive_pages(zone);
 		}
 
 		/*
@@ -1631,7 +1645,7 @@ scan:
 			if (zone->all_unreclaimable)
 				continue;
 			if (nr_slab == 0 && zone->pages_scanned >=
-				    (zone->nr_active + zone->nr_inactive) * 4)
+			    (active_pages(zone) + inactive_pages(zone)) * 4)
 				zone->all_unreclaimable = 1;
 			/*
 			 * If we've done a decent amount of scanning and
