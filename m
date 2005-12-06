Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbVLFNe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbVLFNe2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbVLFNe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:34:28 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:60630 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932565AbVLFNe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:34:27 -0500
Message-Id: <20051206135718.219205000@localhost.localdomain>
References: <20051206135608.860737000@localhost.localdomain>
Date: Tue, 06 Dec 2005 21:56:10 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Nick Piggin <npiggin@suse.de>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 02/13] mm: simplify kswapd reclaim code
Content-Disposition: inline; filename=mm-simplify-kswapd-reclaim-code.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the kswapd reclaim code for the new balancing logic.

Signed-off-by: Nick Piggin <npiggin@suse.de>
Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


 mm/vmscan.c |  100 ++++++++++++++++++++----------------------------------------
 1 files changed, 34 insertions(+), 66 deletions(-)

--- linux-2.6.15-rc5-mm1.orig/mm/vmscan.c
+++ linux-2.6.15-rc5-mm1/mm/vmscan.c
@@ -1309,47 +1309,18 @@ loop_again:
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
-		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
 		unsigned long lru_pages = 0;
 
+		all_zones_ok = 1;
+		sc.nr_scanned = 0;
+		sc.nr_reclaimed = 0;
+		sc.priority = priority;
+		sc.swap_cluster_max = nr_pages ? nr_pages : SWAP_CLUSTER_MAX;
+
 		/* The swap token gets in the way of swapout... */
 		if (!priority)
 			disable_swap_token();
 
-		all_zones_ok = 1;
-
-		if (nr_pages == 0) {
-			/*
-			 * Scan in the highmem->dma direction for the highest
-			 * zone which needs scanning
-			 */
-			for (i = pgdat->nr_zones - 1; i >= 0; i--) {
-				struct zone *zone = pgdat->node_zones + i;
-
-				if (!populated_zone(zone))
-					continue;
-
-				if (zone->all_unreclaimable &&
-						priority != DEF_PRIORITY)
-					continue;
-
-				if (!zone_watermark_ok(zone, order,
-						zone->pages_high, 0, 0)) {
-					end_zone = i;
-					goto scan;
-				}
-			}
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
 		/*
 		 * Now scan the zone in the dma->highmem direction, stopping
 		 * at the last zone which needs scanning.
@@ -1359,51 +1330,49 @@ scan:
 		 * pages behind kswapd's direction of progress, which would
 		 * cause too much scanning of the lower zones.
 		 */
-		for (i = 0; i <= end_zone; i++) {
+		for (i = 0; i < pgdat->nr_zones; i++) {
 			struct zone *zone = pgdat->node_zones + i;
-			int nr_slab;
 
 			if (!populated_zone(zone))
 				continue;
 
+			if (nr_pages == 0) {	/* Not software suspend */
+				if (zone_watermark_ok(zone, order,
+					zone->pages_high, 0, 0))
+					continue;
+
+				all_zones_ok = 0;
+			}
+
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
-			atomic_inc(&zone->reclaim_in_progress);
+			lru_pages += zone->nr_active + zone->nr_inactive;
+
 			shrink_zone(zone, &sc);
-			atomic_dec(&zone->reclaim_in_progress);
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
@@ -1424,7 +1393,6 @@ scan:
 		if ((total_reclaimed >= SWAP_CLUSTER_MAX) && (!nr_pages))
 			break;
 	}
-out:
 	for (i = 0; i < pgdat->nr_zones; i++) {
 		struct zone *zone = pgdat->node_zones + i;
 

--
