Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUA3Eoc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 23:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266563AbUA3Eoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 23:44:32 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:41366 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266561AbUA3EoU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 23:44:20 -0500
Message-ID: <4019E11C.9090402@cyberone.com.au>
Date: Fri, 30 Jan 2004 15:44:12 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][CFT] mm swapping improvements
References: <4019CF5D.4050608@cyberone.com.au>
In-Reply-To: <4019CF5D.4050608@cyberone.com.au>
Content-Type: multipart/mixed;
 boundary="------------000607040601010304080300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000607040601010304080300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Nick Piggin wrote:

> Hi list,
>
> Attached is a patchset against 2.6.2-rc2-mm1 which includes two of
> Nikita's patches and one of my own, and backs out the RSS limit patch
> due to some problems (discussion of these patches on linux-mm).
> The patchset improves VM performance under swapping quite significantly
> for kbuild - its now close 2.4 or better in some cases.
>
> I haven't done many other tests so I would like anyone who's had
> swapping related slowdowns when moving from 2.4 to 2.6, and is
> interested in helping improve it to test out the patch please.
> I can make a patch against the -linus kernel if anyone would like.
>
> Some benchmarks: http://www.kerneltrap.org/~npiggin/vm/3/
> Green is 2.6, red is 2.4, purple is 2.6 with this patch.
>

OK here is the patch for 2.6.2-rc2. Only compile tested but there
isn't much difference between -linus and -mm in this area so it
should be fine.


--------------000607040601010304080300
Content-Type: text/plain;
 name="vm-swap-1-linus"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-swap-1-linus"

 linux-2.6-npiggin/include/linux/mmzone.h |    6 +
 linux-2.6-npiggin/mm/page_alloc.c        |   20 ++++
 linux-2.6-npiggin/mm/vmscan.c            |  152 +++++++++++++++++++------------
 3 files changed, 124 insertions(+), 54 deletions(-)

diff -puN include/linux/mmzone.h~rollup include/linux/mmzone.h
--- linux-2.6/include/linux/mmzone.h~rollup	2004-01-30 15:40:02.000000000 +1100
+++ linux-2.6-npiggin/include/linux/mmzone.h	2004-01-30 15:40:02.000000000 +1100
@@ -149,6 +149,12 @@ struct zone {
 	unsigned long		zone_start_pfn;
 
 	/*
+	 * dummy page used as place holder during scanning of
+	 * active_list in refill_inactive_zone()
+	 */
+	struct page *scan_page;
+
+	/*
 	 * rarely used fields:
 	 */
 	char			*name;
diff -puN mm/page_alloc.c~rollup mm/page_alloc.c
--- linux-2.6/mm/page_alloc.c~rollup	2004-01-30 15:40:02.000000000 +1100
+++ linux-2.6-npiggin/mm/page_alloc.c	2004-01-30 15:40:02.000000000 +1100
@@ -1230,6 +1230,9 @@ void __init memmap_init_zone(struct page
 	memmap_init_zone((start), (size), (nid), (zone), (start_pfn))
 #endif
 
+/* dummy pages used to scan active lists */
+static struct page scan_pages[MAX_NUMNODES][MAX_NR_ZONES];
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -1252,6 +1255,7 @@ static void __init free_area_init_core(s
 		struct zone *zone = pgdat->node_zones + j;
 		unsigned long size, realsize;
 		unsigned long batch;
+		struct page *scan_page;
 
 		zone_table[NODEZONE(nid, j)] = zone;
 		realsize = size = zones_size[j];
@@ -1306,6 +1310,22 @@ static void __init free_area_init_core(s
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
 
diff -puN mm/vmscan.c~rollup mm/vmscan.c
--- linux-2.6/mm/vmscan.c~rollup	2004-01-30 15:40:02.000000000 +1100
+++ linux-2.6-npiggin/mm/vmscan.c	2004-01-30 15:40:02.000000000 +1100
@@ -43,14 +43,15 @@
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
@@ -64,8 +65,7 @@ static long total_memory;
 		if ((_page)->lru.prev != _base) {			\
 			struct page *prev;				\
 									\
-			prev = list_entry(_page->lru.prev,		\
-					struct page, lru);		\
+			prev = lru_to_page(&(_page)->lru);		\
 			prefetchw(&prev->_field);			\
 		}							\
 	} while (0)
@@ -260,7 +260,7 @@ shrink_list(struct list_head *page_list,
 		int may_enter_fs;
 		int referenced;
 
-		page = list_entry(page_list->prev, struct page, lru);
+		page = lru_to_page(page_list);
 		list_del(&page->lru);
 
 		if (TestSetPageLocked(page))
@@ -504,8 +504,7 @@ shrink_cache(const int nr_pages, struct 
 
 		while (nr_scan++ < nr_to_process &&
 				!list_empty(&zone->inactive_list)) {
-			page = list_entry(zone->inactive_list.prev,
-						struct page, lru);
+			page = lru_to_page(&zone->inactive_list);
 
 			prefetchw_prev_lru_page(page,
 						&zone->inactive_list, flags);
@@ -543,7 +542,7 @@ shrink_cache(const int nr_pages, struct 
 		 * Put back any unfreeable pages.
 		 */
 		while (!list_empty(&page_list)) {
-			page = list_entry(page_list.prev, struct page, lru);
+			page = lru_to_page(&page_list);
 			if (TestSetPageLRU(page))
 				BUG();
 			list_del(&page->lru);
@@ -564,6 +563,39 @@ done:
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
@@ -590,37 +622,18 @@ refill_inactive_zone(struct zone *zone, 
 	int nr_pages = nr_pages_in;
 	LIST_HEAD(l_hold);	/* The pages which were snipped off */
 	LIST_HEAD(l_inactive);	/* Pages to go onto the inactive_list */
-	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
+	LIST_HEAD(l_ignore);	/* Pages to be returned to the active_list */
+	LIST_HEAD(l_active);	/* Pages to go onto the head of the
+				 * active_list */
+
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
@@ -652,10 +665,59 @@ refill_inactive_zone(struct zone *zone, 
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
+
+			if (!reclaim_mapped) {
+				list_add(&page->lru, &l_ignore);
+				continue;
+			}
+
+			/*
+			 * probably it would be useful to transfer dirty bit
+			 * from pte to the @page here.
+			 */
 			pte_chain_lock(page);
 			if (page_mapped(page) && page_referenced(page)) {
 				pte_chain_unlock(page);
@@ -663,10 +725,6 @@ refill_inactive_zone(struct zone *zone, 
 				continue;
 			}
 			pte_chain_unlock(page);
-			if (!reclaim_mapped) {
-				list_add(&page->lru, &l_active);
-				continue;
-			}
 		}
 		/*
 		 * FIXME: need to consider page_count(page) here if/when we
@@ -684,7 +742,7 @@ refill_inactive_zone(struct zone *zone, 
 	pgmoved = 0;
 	spin_lock_irq(&zone->lru_lock);
 	while (!list_empty(&l_inactive)) {
-		page = list_entry(l_inactive.prev, struct page, lru);
+		page = lru_to_page(&l_inactive);
 		prefetchw_prev_lru_page(page, &l_inactive, flags);
 		if (TestSetPageLRU(page))
 			BUG();
@@ -711,23 +769,9 @@ refill_inactive_zone(struct zone *zone, 
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
+	pgmoved = spill_on_spot(zone, &l_active, &zone->active_list, &pvec);
 			zone->nr_active += pgmoved;
-			pgmoved = 0;
-			spin_unlock_irq(&zone->lru_lock);
-			__pagevec_release(&pvec);
-			spin_lock_irq(&zone->lru_lock);
-		}
-	}
+	pgmoved = spill_on_spot(zone, &l_ignore, &scan->lru, &pvec);
 	zone->nr_active += pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
 	pagevec_release(&pvec);

_

--------------000607040601010304080300--
