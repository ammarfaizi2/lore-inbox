Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWDUV4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWDUV4e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWDUV4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:56:34 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:44710 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751362AbWDUV4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:56:33 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Updated version of shrink_all_memory tweaks.
Date: Fri, 21 Apr 2006 23:55:56 +0200
User-Agent: KMail/1.9.1
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
References: <200604212039.19676.ncunningham@cyclades.com>
In-Reply-To: <200604212039.19676.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tTVSEn9isLU3ofB"
Message-Id: <200604212355.57447.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_tTVSEn9isLU3ofB
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Friday 21 April 2006 12:39, Nigel Cunningham wrote:
> I give the shrink_all_memory tweaks a try today, and fixed a couple of
> mistakes that meant too much memory was still freed. With this version of the
> patch, you get at most exactly what you ask for.

Thanks for testing and fixes.

Could you please make a patch on top of the
swsusp-rework-memory-shrinker-rev-2.patch
that went to -mm?  [Attached for convenience.]

Greetings,
Rafael


--Boundary-00=_tTVSEn9isLU3ofB
Content-Type: text/x-diff;
  charset="utf-8";
  name="swsusp-rework-memory-shrinker-rev-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="swsusp-rework-memory-shrinker-rev-2.patch"

 kernel/power/swsusp.c |   10 +-
 mm/vmscan.c           |  222 +++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 174 insertions(+), 58 deletions(-)

Index: linux-2.6.17-rc1-mm3/mm/vmscan.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/mm/vmscan.c
+++ linux-2.6.17-rc1-mm3/mm/vmscan.c
@@ -62,6 +62,8 @@ struct scan_control {
 	 * In this context, it doesn't matter that we scan the
 	 * whole list at once. */
 	int swap_cluster_max;
+
+	int swappiness;
 };
 
 #define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
@@ -744,7 +746,7 @@ static void shrink_active_list(unsigned 
 		 * A 100% value of vm_swappiness overrides this algorithm
 		 * altogether.
 		 */
-		swap_tendency = mapped_ratio / 2 + distress + vm_swappiness;
+		swap_tendency = mapped_ratio / 2 + distress + sc->swappiness;
 
 		/*
 		 * Now use this metric to decide whether to start moving mapped
@@ -960,6 +962,7 @@ unsigned long try_to_free_pages(struct z
 		.may_writepage = !laptop_mode,
 		.swap_cluster_max = SWAP_CLUSTER_MAX,
 		.may_swap = 1,
+		.swappiness = vm_swappiness,
 	};
 
 	delay_swap_prefetch();
@@ -1026,10 +1029,6 @@ out:
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
@@ -1047,10 +1046,8 @@ out:
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
@@ -1060,7 +1057,8 @@ static unsigned long balance_pgdat(pg_da
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
 		.may_swap = 1,
-		.swap_cluster_max = nr_pages ? nr_pages : SWAP_CLUSTER_MAX,
+		.swap_cluster_max = SWAP_CLUSTER_MAX,
+		.swappiness = vm_swappiness,
 	};
 
 loop_again:
@@ -1087,31 +1085,27 @@ loop_again:
 
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
+
+			if (!populated_zone(zone))
+				continue;
 
-				if (!populated_zone(zone))
-					continue;
+			if (zone->all_unreclaimable &&
+					priority != DEF_PRIORITY)
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
@@ -1138,11 +1132,9 @@ scan:
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
@@ -1167,8 +1159,6 @@ scan:
 			    total_scanned > nr_reclaimed + nr_reclaimed / 2)
 				sc.may_writepage = 1;
 		}
-		if (nr_pages && to_free > nr_reclaimed)
-			continue;	/* swsusp: need to do more work */
 		if (all_zones_ok)
 			break;		/* kswapd: all done */
 		/*
@@ -1184,7 +1174,7 @@ scan:
 		 * matches the direct reclaim path behaviour in terms of impact
 		 * on zone->*_priority.
 		 */
-		if ((nr_reclaimed >= SWAP_CLUSTER_MAX) && !nr_pages)
+		if (nr_reclaimed >= SWAP_CLUSTER_MAX)
 			break;
 	}
 out:
@@ -1266,7 +1256,7 @@ static int kswapd(void *p)
 		}
 		finish_wait(&pgdat->kswapd_wait, &wait);
 
-		balance_pgdat(pgdat, 0, order);
+		balance_pgdat(pgdat, order);
 	}
 	return 0;
 }
@@ -1295,37 +1285,156 @@ void wakeup_kswapd(struct zone *zone, in
 
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
+	int pass;
+	struct reclaim_state reclaim_state;
+	struct zone *zone;
+	struct scan_control sc = {
+		.gfp_mask = GFP_KERNEL,
+		.may_swap = 0,
+		.swap_cluster_max = nr_pages,
+		.may_writepage = 1,
+		.swappiness = vm_swappiness,
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
+
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
+			sc.swappiness = 100;
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
+
 	return ret;
 }
 #endif
@@ -1423,6 +1532,7 @@ static int __zone_reclaim(struct zone *z
 		.swap_cluster_max = max_t(unsigned long, nr_pages,
 					SWAP_CLUSTER_MAX),
 		.gfp_mask = gfp_mask,
+		.swappiness = vm_swappiness,
 	};
 
 	disable_swap_token();
Index: linux-2.6.17-rc1-mm3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/kernel/power/swsusp.c
+++ linux-2.6.17-rc1-mm3/kernel/power/swsusp.c
@@ -165,6 +165,12 @@ void free_all_swap_pages(int swap, struc
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
@@ -187,12 +193,12 @@ int swsusp_shrink_memory(void)
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

--Boundary-00=_tTVSEn9isLU3ofB--
