Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWDRKDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWDRKDR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 06:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWDRKDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 06:03:17 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:60860 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750802AbWDRKDQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 06:03:16 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] swsusp: rework memory shrinker
Date: Tue, 18 Apr 2006 12:01:52 +0200
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       Con Kolivas <kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604181201.53430.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rework the swsusp's memory shrinker in the following way:

1) Simplify balance_pgdat() by removing all of the swsusp-related code from it.

2) Make shrink_all_memory() use shrink_slab() and a new function
shrink_all_zones() which calls shrink_active_list() and shrink_inactive_list()
directly for each zone in a way that's optimized for suspend.

In shrink_all_memory() we try to free exactly as many pages as the caller
asks for, preferably in one shot, starting from easier targets.  If slab caches
are huge, they are most likely to have enough pages to reclaim.  The
inactive lists are next (the zones with more inactive pages go first) etc. 

Each time shrink_all_memory() attempts to shrink the active and inactive lists
for each zone in 5 passes.  In the first pass, only the inactive lists are
taken into consideration.  In the next two passes the active lists are also
shrunk, but mapped pages are not reclaimed.  In the last two passes the
active and inactive lists are shrunk and mapped pages are reclaimed as well.
The aim of this is to alter the reclaim logic to choose the best pages to keep
on resume and improve the responsiveness of the resumed system.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Con Kolivas <kernel@kolivas.org>
---
 kernel/power/swsusp.c |   10 +-
 mm/vmscan.c           |  213 +++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 166 insertions(+), 57 deletions(-)

Index: linux-2.6.17-rc1-mm2/mm/vmscan.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/vmscan.c	2006-04-12 07:09:20.000000000 +0200
+++ linux-2.6.17-rc1-mm2/mm/vmscan.c	2006-04-13 16:10:03.000000000 +0200
@@ -1031,10 +1031,6 @@ out:
  * For kswapd, balance_pgdat() will work across all this node's zones until
  * they are all at pages_high.
  *
- * If `nr_pages' is non-zero then it is the number of pages which are to be
- * reclaimed, regardless of the zone occupancies.  This is a software suspend
- * special.
- *
  * Returns the number of pages which were actually freed.
  *
  * There is special handling here for zones which are full of pinned pages.
@@ -1052,10 +1048,8 @@ out:
  * the page allocator fallback scheme to ensure that aging of pages is balanced
  * across the zones.
  */
-static unsigned long balance_pgdat(pg_data_t *pgdat, unsigned long nr_pages,
-				int order)
+static unsigned long balance_pgdat(pg_data_t *pgdat, int order)
 {
-	unsigned long to_free = nr_pages;
 	int all_zones_ok;
 	int priority;
 	int i;
@@ -1065,7 +1059,7 @@ static unsigned long balance_pgdat(pg_da
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
 		.may_swap = 1,
-		.swap_cluster_max = nr_pages ? nr_pages : SWAP_CLUSTER_MAX,
+		.swap_cluster_max = SWAP_CLUSTER_MAX,
 	};
 
 loop_again:
@@ -1092,31 +1086,27 @@ loop_again:
 
 		all_zones_ok = 1;
 
-		if (nr_pages == 0) {
-			/*
-			 * Scan in the highmem->dma direction for the highest
-			 * zone which needs scanning
-			 */
-			for (i = pgdat->nr_zones - 1; i >= 0; i--) {
-				struct zone *zone = pgdat->node_zones + i;
+		/*
+		 * Scan in the highmem->dma direction for the highest
+		 * zone which needs scanning
+		 */
+		for (i = pgdat->nr_zones - 1; i >= 0; i--) {
+			struct zone *zone = pgdat->node_zones + i;
 
-				if (!populated_zone(zone))
-					continue;
+			if (!populated_zone(zone))
+				continue;
 
-				if (zone->all_unreclaimable &&
-						priority != DEF_PRIORITY)
-					continue;
-
-				if (!zone_watermark_ok(zone, order,
-						zone->pages_high, 0, 0)) {
-					end_zone = i;
-					goto scan;
-				}
+			if (zone->all_unreclaimable &&
+					priority != DEF_PRIORITY)
+				continue;
+
+			if (!zone_watermark_ok(zone, order, zone->pages_high,
+					       0, 0)) {
+				end_zone = i;
+				goto scan;
 			}
-			goto out;
-		} else {
-			end_zone = pgdat->nr_zones - 1;
 		}
+		goto out;
 scan:
 		for (i = 0; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;
@@ -1143,11 +1133,9 @@ scan:
 			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 				continue;
 
-			if (nr_pages == 0) {	/* Not software suspend */
-				if (!zone_watermark_ok(zone, order,
-						zone->pages_high, end_zone, 0))
-					all_zones_ok = 0;
-			}
+			if (!zone_watermark_ok(zone, order, zone->pages_high,
+					       end_zone, 0))
+				all_zones_ok = 0;
 			zone->temp_priority = priority;
 			if (zone->prev_priority > priority)
 				zone->prev_priority = priority;
@@ -1172,8 +1160,6 @@ scan:
 			    total_scanned > nr_reclaimed + nr_reclaimed / 2)
 				sc.may_writepage = 1;
 		}
-		if (nr_pages && to_free > nr_reclaimed)
-			continue;	/* swsusp: need to do more work */
 		if (all_zones_ok)
 			break;		/* kswapd: all done */
 		/*
@@ -1189,7 +1175,7 @@ scan:
 		 * matches the direct reclaim path behaviour in terms of impact
 		 * on zone->*_priority.
 		 */
-		if ((nr_reclaimed >= SWAP_CLUSTER_MAX) && !nr_pages)
+		if (nr_reclaimed >= SWAP_CLUSTER_MAX)
 			break;
 	}
 out:
@@ -1271,7 +1257,7 @@ static int kswapd(void *p)
 		}
 		finish_wait(&pgdat->kswapd_wait, &wait);
 
-		balance_pgdat(pgdat, 0, order);
+		balance_pgdat(pgdat, order);
 	}
 	return 0;
 }
@@ -1300,37 +1286,154 @@ void wakeup_kswapd(struct zone *zone, in
 
 #ifdef CONFIG_PM
 /*
- * Try to free `nr_pages' of memory, system-wide.  Returns the number of freed
- * pages.
+ * Helper function for shrink_all_memory().  Tries to reclaim 'nr_pages' pages
+ * from LRU lists system-wide, for given pass and priority, and returns the
+ * number of reclaimed pages
+ *
+ * For pass > 3 we also try to shrink the LRU lists that contain a few pages
+ */
+unsigned long shrink_all_zones(unsigned long nr_pages, int pass, int prio,
+				struct scan_control *sc)
+{
+	struct zone *zone;
+	unsigned long nr_to_scan, ret = 0;
+
+	for_each_zone(zone) {
+
+		if (!populated_zone(zone))
+			continue;
+
+		if (zone->all_unreclaimable && prio != DEF_PRIORITY)
+			continue;
+
+		/* For pass = 0 we don't shrink the active list */
+		if (pass > 0) {
+			zone->nr_scan_active += (zone->nr_active >> prio) + 1;
+			if (zone->nr_scan_active >= nr_pages || pass > 3) {
+				zone->nr_scan_active = 0;
+				nr_to_scan = min(nr_pages, zone->nr_active);
+				shrink_active_list(nr_to_scan, zone, sc);
+			}
+		}
+
+		zone->nr_scan_inactive += (zone->nr_inactive >> prio) + 1;
+		if (zone->nr_scan_inactive >= nr_pages || pass > 3) {
+			zone->nr_scan_inactive = 0;
+			nr_to_scan = min(nr_pages, zone->nr_inactive);
+			ret += shrink_inactive_list(nr_to_scan, zone, sc);
+			if (ret >= nr_pages)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+/*
+ * Try to free `nr_pages' of memory, system-wide, and return the number of
+ * freed pages.
+ *
+ * Rather than trying to age LRUs the aim is to preserve the overall
+ * LRU order by reclaiming preferentially
+ * inactive > active > active referenced > active mapped
  */
 unsigned long shrink_all_memory(unsigned long nr_pages)
 {
-	pg_data_t *pgdat;
-	unsigned long nr_to_free = nr_pages;
+	unsigned long lru_pages, nr_slab;
 	unsigned long ret = 0;
-	unsigned retry = 2;
-	struct reclaim_state reclaim_state = {
-		.reclaimed_slab = 0,
+	int swappiness = vm_swappiness, pass;
+	struct reclaim_state reclaim_state;
+	struct zone *zone;
+	struct scan_control sc = {
+		.gfp_mask = GFP_KERNEL,
+		.may_swap = 0,
+		.swap_cluster_max = nr_pages,
+		.may_writepage = 1,
 	};
 
 	delay_swap_prefetch();
 
 	current->reclaim_state = &reclaim_state;
-repeat:
-	for_each_online_pgdat(pgdat) {
-		unsigned long freed;
 
-		freed = balance_pgdat(pgdat, nr_to_free, 0);
-		ret += freed;
-		nr_to_free -= freed;
-		if ((long)nr_to_free <= 0)
+	lru_pages = 0;
+	for_each_zone(zone)
+		lru_pages += zone->nr_active + zone->nr_inactive;
+	nr_slab = read_page_state(nr_slab);
+	/* If slab caches are huge, it's better to hit them first */
+	while (nr_slab >= lru_pages) {
+		reclaim_state.reclaimed_slab = 0;
+		shrink_slab(nr_pages, sc.gfp_mask, lru_pages);
+		if (!reclaim_state.reclaimed_slab)
 			break;
+
+		ret += reclaim_state.reclaimed_slab;
+		if (ret >= nr_pages)
+			goto out;
+
+		nr_slab -= reclaim_state.reclaimed_slab;
 	}
-	if (retry-- && ret < nr_pages) {
-		blk_congestion_wait(WRITE, HZ/5);
-		goto repeat;
+
+	/*
+	 * We try to shrink LRUs in 5 passes:
+	 * 0 = Reclaim from inactive_list only
+	 * 1 = Reclaim from active list but don't reclaim mapped
+	 * 2 = 2nd pass of type 1
+	 * 3 = Reclaim mapped (normal reclaim)
+	 * 4 = 2nd pass of type 3
+	 */
+	for (pass = 0; pass < 5; pass++) {
+		int prio;
+
+		/* Needed for shrinking slab caches later on */
+		if (!lru_pages)
+			for_each_zone(zone) {
+				lru_pages += zone->nr_active;
+				lru_pages += zone->nr_inactive;
+			}
+
+		/* Force reclaiming mapped pages in the passes #3 and #4 */
+		if (pass > 2) {
+			sc.may_swap = 1;
+			vm_swappiness = 100;
+		}
+
+		for (prio = DEF_PRIORITY; prio >= 0; prio--) {
+			unsigned long nr_to_scan = nr_pages - ret;
+
+			sc.nr_mapped = read_page_state(nr_mapped);
+			sc.nr_scanned = 0;
+
+			ret += shrink_all_zones(nr_to_scan, prio, pass, &sc);
+			if (ret >= nr_pages)
+				goto out;
+
+			reclaim_state.reclaimed_slab = 0;
+			shrink_slab(sc.nr_scanned, sc.gfp_mask, lru_pages);
+			ret += reclaim_state.reclaimed_slab;
+			if (ret >= nr_pages)
+				goto out;
+
+			if (sc.nr_scanned && prio < DEF_PRIORITY - 2)
+				blk_congestion_wait(WRITE, HZ / 10);
+		}
+
+		lru_pages = 0;
 	}
+
+	/*
+	 * If ret = 0, we could not shrink LRUs, but there may be something
+	 * in slab caches
+	 */
+	if (!ret)
+		do {
+			reclaim_state.reclaimed_slab = 0;
+			shrink_slab(nr_pages, sc.gfp_mask, lru_pages);
+			ret += reclaim_state.reclaimed_slab;
+		} while (ret < nr_pages && reclaim_state.reclaimed_slab > 0);
+
+out:
 	current->reclaim_state = NULL;
+	vm_swappiness = swappiness;
 	return ret;
 }
 #endif
Index: linux-2.6.17-rc1-mm2/kernel/power/swsusp.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/kernel/power/swsusp.c	2006-04-12 07:11:09.000000000 +0200
+++ linux-2.6.17-rc1-mm2/kernel/power/swsusp.c	2006-04-12 07:14:06.000000000 +0200
@@ -175,6 +175,12 @@ void free_all_swap_pages(int swap, struc
  */
 
 #define SHRINK_BITE	10000
+static inline unsigned long __shrink_memory(long tmp)
+{
+	if (tmp > SHRINK_BITE)
+		tmp = SHRINK_BITE;
+	return shrink_all_memory(tmp);
+}
 
 int swsusp_shrink_memory(void)
 {
@@ -197,12 +203,12 @@ int swsusp_shrink_memory(void)
 				tmp += zone->lowmem_reserve[ZONE_NORMAL];
 			}
 		if (tmp > 0) {
-			tmp = shrink_all_memory(SHRINK_BITE);
+			tmp = __shrink_memory(tmp);
 			if (!tmp)
 				return -ENOMEM;
 			pages += tmp;
 		} else if (size > image_size / PAGE_SIZE) {
-			tmp = shrink_all_memory(SHRINK_BITE);
+			tmp = __shrink_memory(size - (image_size / PAGE_SIZE));
 			pages += tmp;
 		}
 		printk("\b%c", p[i++%4]);
