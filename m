Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbUCIFf4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 00:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUCIFf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 00:35:56 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:42673 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261215AbUCIFfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 00:35:10 -0500
Message-ID: <404D5784.9080004@cyberone.com.au>
Date: Tue, 09 Mar 2004 16:35:00 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [RFC][PATCH 4/4] vm-mapped-x-active-lists
References: <404D56D8.2000008@cyberone.com.au>
In-Reply-To: <404D56D8.2000008@cyberone.com.au>
Content-Type: multipart/mixed;
 boundary="------------070107060208040106040201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070107060208040106040201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------070107060208040106040201
Content-Type: text/x-patch;
 name="vm-mapped-x-active-lists.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-mapped-x-active-lists.patch"


Split the active list into mapped and unmapped pages.


 linux-2.6-npiggin/include/linux/mm_inline.h  |   33 +++++++++--
 linux-2.6-npiggin/include/linux/mmzone.h     |    9 ++-
 linux-2.6-npiggin/include/linux/page-flags.h |   50 ++++++++++--------
 linux-2.6-npiggin/mm/page_alloc.c            |   24 +++++---
 linux-2.6-npiggin/mm/swap.c                  |   35 +++++++++---
 linux-2.6-npiggin/mm/vmscan.c                |   75 +++++++++++++++++++--------
 6 files changed, 156 insertions(+), 70 deletions(-)

diff -puN include/linux/mmzone.h~vm-mapped-x-active-lists include/linux/mmzone.h
--- linux-2.6/include/linux/mmzone.h~vm-mapped-x-active-lists	2004-03-09 14:16:26.000000000 +1100
+++ linux-2.6-npiggin/include/linux/mmzone.h	2004-03-09 14:27:31.000000000 +1100
@@ -74,11 +74,14 @@ struct zone {
 	ZONE_PADDING(_pad1_)
 
 	spinlock_t		lru_lock;	
-	struct list_head	active_list;
+	struct list_head	active_mapped_list;
+	struct list_head	active_unmapped_list;
 	struct list_head	inactive_list;
-	atomic_t		nr_scan_active;
+	atomic_t		nr_scan_active_mapped;
+	atomic_t		nr_scan_active_unmapped;
 	atomic_t		nr_scan_inactive;
-	unsigned long		nr_active;
+	unsigned long		nr_active_mapped;
+	unsigned long		nr_active_unmapped;
 	unsigned long		nr_inactive;
 	int			all_unreclaimable; /* All pages pinned */
 	unsigned long		pages_scanned;	   /* since last reclaim */
diff -puN include/linux/mm_inline.h~vm-mapped-x-active-lists include/linux/mm_inline.h
--- linux-2.6/include/linux/mm_inline.h~vm-mapped-x-active-lists	2004-03-09 14:16:48.000000000 +1100
+++ linux-2.6-npiggin/include/linux/mm_inline.h	2004-03-09 14:59:35.000000000 +1100
@@ -1,9 +1,16 @@
 
 static inline void
-add_page_to_active_list(struct zone *zone, struct page *page)
+add_page_to_active_mapped_list(struct zone *zone, struct page *page)
 {
-	list_add(&page->lru, &zone->active_list);
-	zone->nr_active++;
+	list_add(&page->lru, &zone->active_mapped_list);
+	zone->nr_active_mapped++;
+}
+
+static inline void
+add_page_to_active_unmapped_list(struct zone *zone, struct page *page)
+{
+	list_add(&page->lru, &zone->active_unmapped_list);
+	zone->nr_active_unmapped++;
 }
 
 static inline void
@@ -14,10 +21,17 @@ add_page_to_inactive_list(struct zone *z
 }
 
 static inline void
-del_page_from_active_list(struct zone *zone, struct page *page)
+del_page_from_active_mapped_list(struct zone *zone, struct page *page)
+{
+	list_del(&page->lru);
+	zone->nr_active_mapped--;
+}
+
+static inline void
+del_page_from_active_unmapped_list(struct zone *zone, struct page *page)
 {
 	list_del(&page->lru);
-	zone->nr_active--;
+	zone->nr_active_unmapped--;
 }
 
 static inline void
@@ -31,9 +45,12 @@ static inline void
 del_page_from_lru(struct zone *zone, struct page *page)
 {
 	list_del(&page->lru);
-	if (PageActive(page)) {
-		ClearPageActive(page);
-		zone->nr_active--;
+	if (PageActiveMapped(page)) {
+		ClearPageActiveMapped(page);
+		zone->nr_active_mapped--;
+	} else if (PageActiveUnmapped(page)) {
+		ClearPageActiveUnmapped(page);
+		zone->nr_active_unmapped--;
 	} else {
 		zone->nr_inactive--;
 	}
diff -puN mm/page_alloc.c~vm-mapped-x-active-lists mm/page_alloc.c
--- linux-2.6/mm/page_alloc.c~vm-mapped-x-active-lists	2004-03-09 14:18:44.000000000 +1100
+++ linux-2.6-npiggin/mm/page_alloc.c	2004-03-09 14:58:32.000000000 +1100
@@ -81,7 +81,7 @@ static void bad_page(const char *functio
 	page->flags &= ~(1 << PG_private	|
 			1 << PG_locked	|
 			1 << PG_lru	|
-			1 << PG_active	|
+			1 << PG_active_mapped	|
 			1 << PG_dirty	|
 			1 << PG_writeback);
 	set_page_count(page, 0);
@@ -217,7 +217,8 @@ static inline void free_pages_check(cons
 			1 << PG_lru	|
 			1 << PG_private |
 			1 << PG_locked	|
-			1 << PG_active	|
+			1 << PG_active_mapped	|
+			1 << PG_active_unmapped	|
 			1 << PG_reclaim	|
 			1 << PG_slab	|
 			1 << PG_writeback )))
@@ -324,7 +325,8 @@ static void prep_new_page(struct page *p
 			1 << PG_private	|
 			1 << PG_locked	|
 			1 << PG_lru	|
-			1 << PG_active	|
+			1 << PG_active_mapped	|
+			1 << PG_active_unmapped	|
 			1 << PG_dirty	|
 			1 << PG_reclaim	|
 			1 << PG_writeback )))
@@ -818,7 +820,8 @@ unsigned int nr_used_zone_pages(void)
 	struct zone *zone;
 
 	for_each_zone(zone)
-		pages += zone->nr_active + zone->nr_inactive;
+		pages += zone->nr_active_mapped + zone->nr_active_unmapped
+			+ zone->nr_inactive;
 
 	return pages;
 }
@@ -955,7 +958,7 @@ void get_zone_counts(unsigned long *acti
 	*inactive = 0;
 	*free = 0;
 	for_each_zone(zone) {
-		*active += zone->nr_active;
+		*active += zone->nr_active_mapped + zone->nr_active_unmapped;
 		*inactive += zone->nr_inactive;
 		*free += zone->free_pages;
 	}
@@ -1068,7 +1071,7 @@ void show_free_areas(void)
 			K(zone->pages_min),
 			K(zone->pages_low),
 			K(zone->pages_high),
-			K(zone->nr_active),
+			K(zone->nr_active_mapped + zone->nr_active_unmapped),
 			K(zone->nr_inactive),
 			K(zone->present_pages)
 			);
@@ -1441,11 +1444,14 @@ static void __init free_area_init_core(s
 		}
 		printk("  %s zone: %lu pages, LIFO batch:%lu\n",
 				zone_names[j], realsize, batch);
-		INIT_LIST_HEAD(&zone->active_list);
+		INIT_LIST_HEAD(&zone->active_mapped_list);
+		INIT_LIST_HEAD(&zone->active_unmapped_list);
 		INIT_LIST_HEAD(&zone->inactive_list);
-		atomic_set(&zone->nr_scan_active, 0);
+		atomic_set(&zone->nr_scan_active_mapped, 0);
+		atomic_set(&zone->nr_scan_active_unmapped, 0);
 		atomic_set(&zone->nr_scan_inactive, 0);
-		zone->nr_active = 0;
+		zone->nr_active_mapped = 0;
+		zone->nr_active_unmapped = 0;
 		zone->nr_inactive = 0;
 		if (!size)
 			continue;
diff -puN mm/vmscan.c~vm-mapped-x-active-lists mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-mapped-x-active-lists	2004-03-09 14:20:02.000000000 +1100
+++ linux-2.6-npiggin/mm/vmscan.c	2004-03-09 15:20:44.000000000 +1100
@@ -272,7 +272,7 @@ shrink_list(struct list_head *page_list,
 		if (page_mapped(page) || PageSwapCache(page))
 			(*nr_scanned)++;
 
-		BUG_ON(PageActive(page));
+		BUG_ON(PageActiveMapped(page) || PageActiveUnmapped(page));
 
 		if (PageWriteback(page))
 			goto keep_locked;
@@ -450,7 +450,10 @@ free_it:
 		continue;
 
 activate_locked:
-		SetPageActive(page);
+		if (page_mapped(page))
+			SetPageActiveMapped(page);
+		else
+			SetPageActiveUnmapped(page);
 		pgactivate++;
 keep_locked:
 		unlock_page(page);
@@ -545,8 +548,10 @@ shrink_cache(struct zone *zone, unsigned
 			if (TestSetPageLRU(page))
 				BUG();
 			list_del(&page->lru);
-			if (PageActive(page))
-				add_page_to_active_list(zone, page);
+			if (PageActiveMapped(page))
+				add_page_to_active_mapped_list(zone, page);
+			else if (PageActiveUnmapped(page))
+				add_page_to_active_unmapped_list(zone, page);
 			else
 				add_page_to_inactive_list(zone, page);
 			if (!pagevec_add(&pvec, page)) {
@@ -580,9 +585,10 @@ done:
  * But we had to alter page->flags anyway.
  */
 static void shrink_active_list(struct zone *zone, struct list_head *list,
-				const int nr_scan, struct page_state *ps)
+		unsigned long *list_count, const int nr_scan,
+		struct page_state *ps)
 {
-	int pgmoved;
+	int pgmoved, pgmoved_unmapped;
 	int pgdeactivate = 0;
 	int nr_pages = nr_scan;
 	LIST_HEAD(l_hold);	/* The pages which were snipped off */
@@ -611,7 +617,7 @@ static void shrink_active_list(struct zo
 		}
 		nr_pages--;
 	}
-	zone->nr_active -= pgmoved;
+	*list_count -= pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
 
 	while (!list_empty(&l_hold)) {
@@ -645,7 +651,8 @@ static void shrink_active_list(struct zo
 		prefetchw_prev_lru_page(page, &l_inactive, flags);
 		if (TestSetPageLRU(page))
 			BUG();
-		if (!TestClearPageActive(page))
+		if (!TestClearPageActiveMapped(page)
+				&& !TestClearPageActiveUnmapped(page))
 			BUG();
 		list_move(&page->lru, &zone->inactive_list);
 		pgmoved++;
@@ -669,23 +676,37 @@ static void shrink_active_list(struct zo
 	}
 
 	pgmoved = 0;
+	pgmoved_unmapped = 0;
 	while (!list_empty(&l_active)) {
 		page = lru_to_page(&l_active);
 		prefetchw_prev_lru_page(page, &l_active, flags);
 		if (TestSetPageLRU(page))
 			BUG();
-		BUG_ON(!PageActive(page));
-		list_move(&page->lru, list);
-		pgmoved++;
+		if(!TestClearPageActiveMapped(page)
+				&& !TestClearPageActiveUnmapped(page))
+			BUG();
+		if (page_mapped(page)) {
+			SetPageActiveMapped(page);
+			list_move(&page->lru, &zone->active_mapped_list);
+			pgmoved++;
+		} else {
+			SetPageActiveUnmapped(page);
+			list_move(&page->lru, &zone->active_unmapped_list);
+			pgmoved_unmapped++;
+		}
+			
 		if (!pagevec_add(&pvec, page)) {
-			zone->nr_active += pgmoved;
+			zone->nr_active_mapped += pgmoved;
 			pgmoved = 0;
+			zone->nr_active_unmapped += pgmoved_unmapped;
+			pgmoved_unmapped = 0;
 			spin_unlock_irq(&zone->lru_lock);
 			__pagevec_release(&pvec);
 			spin_lock_irq(&zone->lru_lock);
 		}
 	}
-	zone->nr_active += pgmoved;
+	zone->nr_active_mapped += pgmoved;
+	zone->nr_active_unmapped += pgmoved_unmapped;
 	spin_unlock_irq(&zone->lru_lock);
 	pagevec_release(&pvec);
 
@@ -702,6 +723,8 @@ shrink_zone(struct zone *zone, int max_s
 		int *total_scanned, struct page_state *ps)
 {
 	unsigned long ratio;
+	unsigned long long mapped_ratio;
+	unsigned long nr_active;
 	int count;
 
 	/*
@@ -714,14 +737,27 @@ shrink_zone(struct zone *zone, int max_s
 	 * just to make sure that the kernel will slowly sift through the
 	 * active list.
 	 */
-	ratio = (unsigned long)SWAP_CLUSTER_MAX * zone->nr_active /
-				((zone->nr_inactive | 1) * 2);
+	nr_active = zone->nr_active_mapped + zone->nr_active_unmapped;
+	ratio = (unsigned long)SWAP_CLUSTER_MAX * nr_active /
+				(zone->nr_inactive * 2 + 1);
+	mapped_ratio = (unsigned long long)ratio * nr_active;
+	do_div(mapped_ratio, zone->nr_active_mapped+1);
+
+	ratio = ratio - mapped_ratio;
+	atomic_add(ratio+1, &zone->nr_scan_active_unmapped);
+	count = atomic_read(&zone->nr_scan_active_unmapped);
+	if (count >= SWAP_CLUSTER_MAX) {
+		atomic_set(&zone->nr_scan_active_unmapped, 0);
+		shrink_active_list(zone, &zone->active_unmapped_list,
+					&zone->nr_active_unmapped, count, ps);
+	}
 
-	atomic_add(ratio+1, &zone->nr_scan_active);
-	count = atomic_read(&zone->nr_scan_active);
+	atomic_add(mapped_ratio+1, &zone->nr_scan_active_mapped);
+	count = atomic_read(&zone->nr_scan_active_mapped);
 	if (count >= SWAP_CLUSTER_MAX) {
-		atomic_set(&zone->nr_scan_active, 0);
-		shrink_active_list(zone, &zone->active_list, count, ps);
+		atomic_set(&zone->nr_scan_active_mapped, 0);
+		shrink_active_list(zone, &zone->active_mapped_list,
+					&zone->nr_active_mapped, count, ps);
 	}
 
 	atomic_add(max_scan, &zone->nr_scan_inactive);
@@ -793,7 +829,6 @@ int try_to_free_pages(struct zone **zone
 	int ret = 0;
 	int nr_reclaimed = 0;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
-	int i;
 
 	inc_page_state(allocstall);
 
diff -puN include/linux/page-flags.h~vm-mapped-x-active-lists include/linux/page-flags.h
--- linux-2.6/include/linux/page-flags.h~vm-mapped-x-active-lists	2004-03-09 14:28:57.000000000 +1100
+++ linux-2.6-npiggin/include/linux/page-flags.h	2004-03-09 15:01:04.000000000 +1100
@@ -58,23 +58,25 @@
 
 #define PG_dirty	 	 4
 #define PG_lru			 5
-#define PG_active		 6
-#define PG_slab			 7	/* slab debug (Suparna wants this) */
+#define PG_active_mapped	 6
+#define PG_active_unmapped	 7
 
-#define PG_highmem		 8
-#define PG_checked		 9	/* kill me in 2.5.<early>. */
-#define PG_arch_1		10
-#define PG_reserved		11
-
-#define PG_private		12	/* Has something at ->private */
-#define PG_writeback		13	/* Page is under writeback */
-#define PG_nosave		14	/* Used for system suspend/resume */
-#define PG_chainlock		15	/* lock bit for ->pte_chain */
-
-#define PG_direct		16	/* ->pte_chain points directly at pte */
-#define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
-#define PG_reclaim		18	/* To be reclaimed asap */
-#define PG_compound		19	/* Part of a compound page */
+#define PG_slab			 8	/* slab debug (Suparna wants this) */
+#define PG_highmem		 9
+#define PG_checked		10	/* kill me in 2.5.<early>. */
+#define PG_arch_1		11
+
+#define PG_reserved		12
+#define PG_private		13	/* Has something at ->private */
+#define PG_writeback		14	/* Page is under writeback */
+#define PG_nosave		15	/* Used for system suspend/resume */
+
+#define PG_chainlock		16	/* lock bit for ->pte_chain */
+#define PG_direct		17	/* ->pte_chain points directly at pte */
+#define PG_mappedtodisk		18	/* Has blocks allocated on-disk */
+#define PG_reclaim		19	/* To be reclaimed asap */
+
+#define PG_compound		20	/* Part of a compound page */
 
 
 /*
@@ -211,11 +213,17 @@ extern void get_full_page_state(struct p
 #define TestSetPageLRU(page)	test_and_set_bit(PG_lru, &(page)->flags)
 #define TestClearPageLRU(page)	test_and_clear_bit(PG_lru, &(page)->flags)
 
-#define PageActive(page)	test_bit(PG_active, &(page)->flags)
-#define SetPageActive(page)	set_bit(PG_active, &(page)->flags)
-#define ClearPageActive(page)	clear_bit(PG_active, &(page)->flags)
-#define TestClearPageActive(page) test_and_clear_bit(PG_active, &(page)->flags)
-#define TestSetPageActive(page) test_and_set_bit(PG_active, &(page)->flags)
+#define PageActiveMapped(page)		test_bit(PG_active_mapped, &(page)->flags)
+#define SetPageActiveMapped(page)	set_bit(PG_active_mapped, &(page)->flags)
+#define ClearPageActiveMapped(page)	clear_bit(PG_active_mapped, &(page)->flags)
+#define TestClearPageActiveMapped(page) test_and_clear_bit(PG_active_mapped, &(page)->flags)
+#define TestSetPageActiveMapped(page) test_and_set_bit(PG_active_mapped, &(page)->flags)
+
+#define PageActiveUnmapped(page)	test_bit(PG_active_unmapped, &(page)->flags)
+#define SetPageActiveUnmapped(page)	set_bit(PG_active_unmapped, &(page)->flags)
+#define ClearPageActiveUnmapped(page)	clear_bit(PG_active_unmapped, &(page)->flags)
+#define TestClearPageActiveUnmapped(page) test_and_clear_bit(PG_active_unmapped, &(page)->flags)
+#define TestSetPageActiveUnmapped(page) test_and_set_bit(PG_active_unmapped, &(page)->flags)
 
 #define PageSlab(page)		test_bit(PG_slab, &(page)->flags)
 #define SetPageSlab(page)	set_bit(PG_slab, &(page)->flags)
diff -puN mm/swap.c~vm-mapped-x-active-lists mm/swap.c
--- linux-2.6/mm/swap.c~vm-mapped-x-active-lists	2004-03-09 14:33:07.000000000 +1100
+++ linux-2.6-npiggin/mm/swap.c	2004-03-09 15:00:35.000000000 +1100
@@ -58,14 +58,18 @@ int rotate_reclaimable_page(struct page 
 		return 1;
 	if (PageDirty(page))
 		return 1;
-	if (PageActive(page))
+	if (PageActiveMapped(page))
+		return 1;
+	if (PageActiveUnmapped(page))
 		return 1;
 	if (!PageLRU(page))
 		return 1;
 
 	zone = page_zone(page);
 	spin_lock_irqsave(&zone->lru_lock, flags);
-	if (PageLRU(page) && !PageActive(page)) {
+	if (PageLRU(page)
+		&& !PageActiveMapped(page) && !PageActiveUnmapped(page)) {
+
 		list_del(&page->lru);
 		list_add_tail(&page->lru, &zone->inactive_list);
 		inc_page_state(pgrotated);
@@ -84,10 +88,18 @@ void fastcall activate_page(struct page 
 	struct zone *zone = page_zone(page);
 
 	spin_lock_irq(&zone->lru_lock);
-	if (PageLRU(page) && !PageActive(page)) {
+	if (PageLRU(page)
+		&& !PageActiveMapped(page) && !PageActiveUnmapped(page)) {
+
 		del_page_from_inactive_list(zone, page);
-		SetPageActive(page);
-		add_page_to_active_list(zone, page);
+
+		if (page_mapped(page)) {
+			SetPageActiveMapped(page);
+			add_page_to_active_mapped_list(zone, page);
+		} else {
+			SetPageActiveUnmapped(page);
+			add_page_to_active_unmapped_list(zone, page);
+		}
 		inc_page_state(pgactivate);
 	}
 	spin_unlock_irq(&zone->lru_lock);
@@ -102,7 +114,8 @@ void fastcall activate_page(struct page 
  */
 void fastcall mark_page_accessed(struct page *page)
 {
-	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
+	if (!PageActiveMapped(page) && !PageActiveUnmapped(page)
+			&& PageReferenced(page) && PageLRU(page)) {
 		activate_page(page);
 		ClearPageReferenced(page);
 	} else if (!PageReferenced(page)) {
@@ -310,9 +323,13 @@ void __pagevec_lru_add_active(struct pag
 		}
 		if (TestSetPageLRU(page))
 			BUG();
-		if (TestSetPageActive(page))
-			BUG();
-		add_page_to_active_list(zone, page);
+		if (page_mapped(page)) {
+			SetPageActiveMapped(page);
+			add_page_to_active_mapped_list(zone, page);
+		} else {
+			SetPageActiveMapped(page);
+			add_page_to_active_unmapped_list(zone, page);
+		}
 	}
 	if (zone)
 		spin_unlock_irq(&zone->lru_lock);

_

--------------070107060208040106040201--
