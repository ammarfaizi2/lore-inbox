Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUCIFjv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 00:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUCIFiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 00:38:22 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:17859 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261238AbUCIFhl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 00:37:41 -0500
Message-ID: <404D5757.3090404@cyberone.com.au>
Date: Tue, 09 Mar 2004 16:34:15 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [RFC][PATCH 3/4] vm-no-reclaim_mapped
References: <404D56D8.2000008@cyberone.com.au>
In-Reply-To: <404D56D8.2000008@cyberone.com.au>
Content-Type: multipart/mixed;
 boundary="------------040709030602070402080505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040709030602070402080505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------040709030602070402080505
Content-Type: text/x-patch;
 name="vm-no-reclaim_mapped.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-no-reclaim_mapped.patch"


Kill reclaim_mapped and its merry men.


 linux-2.6-npiggin/include/linux/mmzone.h |   19 -------
 linux-2.6-npiggin/mm/page_alloc.c        |    2 
 linux-2.6-npiggin/mm/vmscan.c            |   76 +++----------------------------
 3 files changed, 8 insertions(+), 89 deletions(-)

diff -puN mm/vmscan.c~vm-no-reclaim_mapped mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-no-reclaim_mapped	2004-03-09 14:05:03.000000000 +1100
+++ linux-2.6-npiggin/mm/vmscan.c	2004-03-09 16:31:21.000000000 +1100
@@ -590,10 +590,6 @@ static void shrink_active_list(struct zo
 	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
 	struct page *page;
 	struct pagevec pvec;
-	int reclaim_mapped = 0;
-	long mapped_ratio;
-	long distress;
-	long swap_tendency;
 
 	lru_add_drain();
 	pgmoved = 0;
@@ -618,59 +614,23 @@ static void shrink_active_list(struct zo
 	zone->nr_active -= pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
 
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
-	mapped_ratio = (ps->nr_mapped * 100) / total_memory;
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
 	while (!list_empty(&l_hold)) {
 		page = lru_to_page(&l_hold);
 		list_del(&page->lru);
-		if (page_mapped(page)) {
-			if (!reclaim_mapped) {
-				list_add(&page->lru, &l_active);
-				continue;
-			}
-			pte_chain_lock(page);
-			if (page_referenced(page)) {
-				pte_chain_unlock(page);
-				list_add(&page->lru, &l_active);
-				continue;
-			}
+		pte_chain_lock(page);
+		if (page_referenced(page)) {
 			pte_chain_unlock(page);
+			list_add(&page->lru, &l_active);
+			continue;
 		}
+		pte_chain_unlock(page);
+
 		/*
 		 * FIXME: need to consider page_count(page) here if/when we
 		 * reap orphaned pages via the LRU (Daniel's locking stuff)
 		 */
-		if (total_swap_pages == 0 && !page->mapping &&
-						!PagePrivate(page)) {
+		if (unlikely(total_swap_pages == 0 && !page->mapping &&
+						!PagePrivate(page))) {
 			list_add(&page->lru, &l_active);
 			continue;
 		}
@@ -800,9 +760,6 @@ shrink_caches(struct zone **zones, int p
 		struct zone *zone = zones[i];
 		int max_scan;
 
-		if (zone->free_pages < zone->pages_high)
-			zone->temp_priority = priority;
-
 		if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 			continue;	/* Let kswapd poll it */
 
@@ -840,9 +797,6 @@ int try_to_free_pages(struct zone **zone
 
 	inc_page_state(allocstall);
 
-	for (i = 0; zones[i] != 0; i++)
-		zones[i]->temp_priority = DEF_PRIORITY;
-
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
 		int total_scanned = 0;
 		struct page_state ps;
@@ -875,8 +829,6 @@ int try_to_free_pages(struct zone **zone
 	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
 		out_of_memory();
 out:
-	for (i = 0; zones[i] != 0; i++)
-		zones[i]->prev_priority = zones[i]->temp_priority;
 	return ret;
 }
 
@@ -914,12 +866,6 @@ static int balance_pgdat(pg_data_t *pgda
 
 	inc_page_state(pageoutrun);
 
-	for (i = 0; i < pgdat->nr_zones; i++) {
-		struct zone *zone = pgdat->node_zones + i;
-
-		zone->temp_priority = DEF_PRIORITY;
-	}
-
 	for (priority = DEF_PRIORITY; priority; priority--) {
 		int all_zones_ok = 1;
 		int pages_scanned = 0;
@@ -970,7 +916,6 @@ scan:
 				if (zone->free_pages <= zone->pages_high)
 					all_zones_ok = 0;
 			}
-			zone->temp_priority = priority;
 			max_scan = zone->nr_inactive >> priority;
 			reclaimed = shrink_zone(zone, max_scan, GFP_KERNEL,
 					&total_scanned, ps);
@@ -996,11 +941,6 @@ scan:
 			blk_congestion_wait(WRITE, HZ/10);
 	}
 out:
-	for (i = 0; i < pgdat->nr_zones; i++) {
-		struct zone *zone = pgdat->node_zones + i;
-
-		zone->prev_priority = zone->temp_priority;
-	}
 	return nr_pages - to_free;
 }
 
diff -puN include/linux/mmzone.h~vm-no-reclaim_mapped include/linux/mmzone.h
--- linux-2.6/include/linux/mmzone.h~vm-no-reclaim_mapped	2004-03-09 14:14:39.000000000 +1100
+++ linux-2.6-npiggin/include/linux/mmzone.h	2004-03-09 16:31:21.000000000 +1100
@@ -86,25 +86,6 @@ struct zone {
 	ZONE_PADDING(_pad2_)
 
 	/*
-	 * prev_priority holds the scanning priority for this zone.  It is
-	 * defined as the scanning priority at which we achieved our reclaim
-	 * target at the previous try_to_free_pages() or balance_pgdat()
-	 * invokation.
-	 *
-	 * We use prev_priority as a measure of how much stress page reclaim is
-	 * under - it drives the swappiness decision: whether to unmap mapped
-	 * pages.
-	 *
-	 * temp_priority is used to remember the scanning priority at which
-	 * this zone was successfully refilled to free_pages == pages_high.
-	 *
-	 * Access to both these fields is quite racy even on uniprocessor.  But
-	 * it is expected to average out OK.
-	 */
-	int temp_priority;
-	int prev_priority;
-
-	/*
 	 * free areas of different sizes
 	 */
 	struct free_area	free_area[MAX_ORDER];
diff -puN mm/page_alloc.c~vm-no-reclaim_mapped mm/page_alloc.c
--- linux-2.6/mm/page_alloc.c~vm-no-reclaim_mapped	2004-03-09 14:15:00.000000000 +1100
+++ linux-2.6-npiggin/mm/page_alloc.c	2004-03-09 16:31:21.000000000 +1100
@@ -1408,8 +1408,6 @@ static void __init free_area_init_core(s
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
 
-		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;
-
 		/*
 		 * The per-cpu-pages pools are set to around 1000th of the
 		 * size of the zone.  But no more than 1/4 of a meg - there's

_

--------------040709030602070402080505--
