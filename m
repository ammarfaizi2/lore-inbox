Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbVL3Wmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVL3Wmv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVL3Wmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:42:47 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:22084 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S932158AbVL3Wmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:42:36 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051230224212.765.38527.sendpatchset@twins.localnet>
In-Reply-To: <20051230223952.765.21096.sendpatchset@twins.localnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
Subject: [PATCH 14/14] page-replace-kswapd-incmin.patch
Date: Fri, 30 Dec 2005 23:42:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Nick Piggin <npiggin@suse.de>

Explicitly teach kswapd about the incremental min logic instead of just scanning
all zones under the first low zone. This should keep more even pressure applied
on the zones.

The new shrink_zone() logic exposes the very worst side of the current
balance_pgdat() function. Without this patch reclaim is limited to ZONE_DMA.

Signed-off-by: Nick Piggin <npiggin@suse.de>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

 
 mm/vmscan.c |   97 +++++++++++++++++++++---------------------------------------
 1 file changed, 34 insertions(+), 63 deletions(-)

Index: linux-2.6-git/mm/vmscan.c
===================================================================
--- linux-2.6-git.orig/mm/vmscan.c
+++ linux-2.6-git/mm/vmscan.c
@@ -790,46 +790,18 @@ loop_again:
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
-				if (zone->present_pages == 0)
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
 
 		/*
 		 * Now scan the zone in the dma->highmem direction, stopping
@@ -840,51 +812,51 @@ scan:
 		 * pages behind kswapd's direction of progress, which would
 		 * cause too much scanning of the lower zones.
 		 */
-		for (i = 0; i <= end_zone; i++) {
+		for (i = 0; i <= pgdat->nr_zones; i++) {
 			struct zone *zone = pgdat->node_zones + i;
-			int nr_slab;
 
 			if (zone->present_pages == 0)
 				continue;
 
+			if (nr_pages == 0) {	/* Not software suspend */
+				if (zone_watermark_ok(zone, order,
+						      zone->pages_high, 0, 0))
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
@@ -905,7 +877,6 @@ scan:
 		if ((total_reclaimed >= SWAP_CLUSTER_MAX) && (!nr_pages))
 			break;
 	}
-out:
 	for (i = 0; i < pgdat->nr_zones; i++) {
 		struct zone *zone = pgdat->node_zones + i;
 
