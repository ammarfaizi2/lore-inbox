Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161107AbVKYPFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbVKYPFs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbVKYPFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:05:48 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:54761 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1161105AbVKYPFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:05:32 -0500
Message-Id: <20051125151347.016081000@localhost.localdomain>
References: <20051125151210.993109000@localhost.localdomain>
Date: Fri, 25 Nov 2005 23:12:12 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <npiggin@suse.de>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 02/19] vm: kswapd incmin
Content-Disposition: inline; filename=vm-kswapd-incmin.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly teach kswapd about the incremental min logic instead of just scanning
all zones under the first low zone. This should keep more even pressure applied
on the zones.

Signed-off-by: Nick Piggin <npiggin@suse.de>
Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


This patch is taken unchanged from Nick Piggin's work.

 mm/vmscan.c |  105 ++++++++++++++++++++----------------------------------------
 1 files changed, 35 insertions(+), 70 deletions(-)

--- linux-2.6.15-rc2-mm1.orig/mm/vmscan.c
+++ linux-2.6.15-rc2-mm1/mm/vmscan.c
@@ -1314,97 +1314,63 @@ loop_again:
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
-		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
 		unsigned long lru_pages = 0;
+		int first_low_zone = 0;
 
 		all_zones_ok = 1;
+		sc.nr_scanned = 0;
+		sc.nr_reclaimed = 0;
+		sc.priority = priority;
+		sc.swap_cluster_max = nr_pages ? nr_pages : SWAP_CLUSTER_MAX;
 
-		if (nr_pages == 0) {
-			/*
-			 * Scan in the highmem->dma direction for the highest
-			 * zone which needs scanning
-			 */
-			for (i = pgdat->nr_zones - 1; i >= 0; i--) {
-				struct zone *zone = pgdat->node_zones + i;
+		/* Scan in the highmem->dma direction */
+		for (i = pgdat->nr_zones - 1; i >= 0; i--) {
+			struct zone *zone = pgdat->node_zones + i;
 
-				if (!populated_zone(zone))
-					continue;
+			if (!populated_zone(zone))
+				continue;
 
-				if (zone->all_unreclaimable &&
-						priority != DEF_PRIORITY)
+			if (nr_pages == 0) {	/* Not software suspend */
+				if (zone_watermark_ok(zone, order,
+					zone->pages_high, first_low_zone, 0))
 					continue;
 
-				if (!zone_watermark_ok(zone, order,
-						zone->pages_high, 0, 0)) {
-					end_zone = i;
-					goto scan;
-				}
+				all_zones_ok = 0;
+				if (first_low_zone < i)
+					first_low_zone = i;
 			}
-			goto out;
-		} else {
-			end_zone = pgdat->nr_zones - 1;
-		}
-scan:
-		for (i = 0; i <= end_zone; i++) {
-			struct zone *zone = pgdat->node_zones + i;
-
-			lru_pages += zone->nr_active + zone->nr_inactive;
-		}
-
-		/*
-		 * Now scan the zone in the dma->highmem direction, stopping
-		 * at the last zone which needs scanning.
-		 *
-		 * We do this because the page allocator works in the opposite
-		 * direction.  This prevents the page allocator from allocating
-		 * pages behind kswapd's direction of progress, which would
-		 * cause too much scanning of the lower zones.
-		 */
-		for (i = 0; i <= end_zone; i++) {
-			struct zone *zone = pgdat->node_zones + i;
-			int nr_slab;
-
-			if (!populated_zone(zone))
-				continue;
 
 			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 				continue;
 
-			if (nr_pages == 0) {	/* Not software suspend */
-				if (!zone_watermark_ok(zone, order,
-						zone->pages_high, end_zone, 0))
-					all_zones_ok = 0;
-			}
 			zone->temp_priority = priority;
 			if (zone->prev_priority > priority)
 				zone->prev_priority = priority;
-			sc.nr_scanned = 0;
-			sc.nr_reclaimed = 0;
-			sc.priority = priority;
-			sc.swap_cluster_max = nr_pages? nr_pages : SWAP_CLUSTER_MAX;
+			lru_pages += zone->nr_active + zone->nr_inactive;
+
 			atomic_inc(&zone->reclaim_in_progress);
 			shrink_zone(zone, &sc);
 			atomic_dec(&zone->reclaim_in_progress);
-			reclaim_state->reclaimed_slab = 0;
-			nr_slab = shrink_slab(sc.nr_scanned, GFP_KERNEL,
-						lru_pages);
-			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
-			total_reclaimed += sc.nr_reclaimed;
-			total_scanned += sc.nr_scanned;
-			if (zone->all_unreclaimable)
-				continue;
-			if (nr_slab == 0 && zone->pages_scanned >=
+
+			if (zone->pages_scanned >=
 				    (zone->nr_active + zone->nr_inactive) * 4)
 				zone->all_unreclaimable = 1;
-			/*
-			 * If we've done a decent amount of scanning and
-			 * the reclaim ratio is low, start doing writepage
-			 * even in laptop mode
-			 */
-			if (total_scanned > SWAP_CLUSTER_MAX * 2 &&
-			    total_scanned > total_reclaimed+total_reclaimed/2)
-				sc.may_writepage = 1;
 		}
+		reclaim_state->reclaimed_slab = 0;
+		shrink_slab(sc.nr_scanned, GFP_KERNEL, lru_pages);
+		sc.nr_reclaimed += reclaim_state->reclaimed_slab;
+		total_reclaimed += sc.nr_reclaimed;
+		total_scanned += sc.nr_scanned;
+
+		/*
+		 * If we've done a decent amount of scanning and
+		 * the reclaim ratio is low, start doing writepage
+		 * even in laptop mode
+		 */
+		if (total_scanned > SWAP_CLUSTER_MAX * 2 &&
+		    total_scanned > total_reclaimed+total_reclaimed/2)
+			sc.may_writepage = 1;
+
 		if (nr_pages && to_free > total_reclaimed)
 			continue;	/* swsusp: need to do more work */
 		if (all_zones_ok)
@@ -1425,7 +1391,6 @@ scan:
 		if ((total_reclaimed >= SWAP_CLUSTER_MAX) && (!nr_pages))
 			break;
 	}
-out:
 	for (i = 0; i < pgdat->nr_zones; i++) {
 		struct zone *zone = pgdat->node_zones + i;
 

--
