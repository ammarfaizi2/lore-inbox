Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVLGK2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVLGK2n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVLGKZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:25:35 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:34233 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750796AbVLGKZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:25:27 -0500
Message-Id: <20051207105138.646019000@localhost.localdomain>
References: <20051207104755.177435000@localhost.localdomain>
Date: Wed, 07 Dec 2005 18:48:06 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 11/16] mm: let sc.nr_scanned/sc.nr_reclaimed accumulate
Content-Disposition: inline; filename=mm-accumulate-nr-scanned-reclaimed-in-scan-control.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there's no need to keep track of nr_scanned/nr_reclaimed for every
single round of shrink_zone(), remove the total_scanned/total_reclaimed and
let nr_scanned/nr_reclaimed accumulate between shrink_zone() calls.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/vmscan.c |   36 ++++++++++++++----------------------
 1 files changed, 14 insertions(+), 22 deletions(-)

--- linux.orig/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -1231,7 +1231,6 @@ int try_to_free_pages(struct zone **zone
 {
 	int priority;
 	int ret = 0;
-	int total_scanned = 0, total_reclaimed = 0;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
 	int i;
@@ -1241,6 +1240,8 @@ int try_to_free_pages(struct zone **zone
 	sc.gfp_mask = gfp_mask;
 	sc.may_writepage = 0;
 	sc.may_swap = 1;
+	sc.nr_scanned = 0;
+	sc.nr_reclaimed = 0;
 
 	inc_page_state(allocstall);
 
@@ -1261,8 +1262,6 @@ int try_to_free_pages(struct zone **zone
 	 */
 	for (priority = DEF_PRIORITY + PRIORITY_STEPS; priority >= 0; priority--) {
 		sc.nr_mapped = read_page_state(nr_mapped);
-		sc.nr_scanned = 0;
-		sc.nr_reclaimed = 0;
 		sc.priority = priority;
 		sc.nr_to_reclaim = SWAP_CLUSTER_MAX;
 		if (!priority)
@@ -1274,9 +1273,7 @@ int try_to_free_pages(struct zone **zone
 			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
 			reclaim_state->reclaimed_slab = 0;
 		}
-		total_scanned += sc.nr_scanned;
-		total_reclaimed += sc.nr_reclaimed;
-		if (total_reclaimed >= SWAP_CLUSTER_MAX) {
+		if (sc.nr_reclaimed >= SWAP_CLUSTER_MAX) {
 			ret = 1;
 			goto out;
 		}
@@ -1288,13 +1285,13 @@ int try_to_free_pages(struct zone **zone
 		 * that's undesirable in laptop mode, where we *want* lumpy
 		 * writeout.  So in laptop mode, write out the whole world.
 		 */
-		if (total_scanned > SWAP_CLUSTER_MAX * 3 / 2) {
-			wakeup_pdflush(laptop_mode ? 0 : total_scanned);
+		if (sc.nr_scanned > SWAP_CLUSTER_MAX * 3 / 2) {
+			wakeup_pdflush(laptop_mode ? 0 : sc.nr_scanned);
 			sc.may_writepage = 1;
 		}
 
 		/* Take a nap, wait for some writeback to complete */
-		if (sc.nr_scanned && priority < DEF_PRIORITY - PRIORITY_STEPS)
+		if (priority < DEF_PRIORITY - PRIORITY_STEPS)
 			blk_congestion_wait(WRITE, HZ/10);
 	}
 out:
@@ -1340,18 +1337,17 @@ static int balance_pgdat(pg_data_t *pgda
 	int all_zones_ok;
 	int priority;
 	int i;
-	int total_scanned, total_reclaimed;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
 	struct zone *prev_zone = pgdat->node_zones;
 
 loop_again:
-	total_scanned = 0;
-	total_reclaimed = 0;
 	sc.gfp_mask = GFP_KERNEL;
 	sc.may_writepage = 0;
 	sc.may_swap = 1;
 	sc.nr_mapped = read_page_state(nr_mapped);
+	sc.nr_scanned = 0;
+	sc.nr_reclaimed = 0;
 
 	inc_page_state(pageoutrun);
 
@@ -1366,8 +1362,6 @@ loop_again:
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
 		all_zones_ok = 1;
-		sc.nr_scanned = 0;
-		sc.nr_reclaimed = 0;
 		sc.priority = priority;
 		sc.nr_to_reclaim = nr_pages ? nr_pages : SWAP_CLUSTER_MAX;
 
@@ -1437,19 +1431,17 @@ scan_swspd:
 		reclaim_state->reclaimed_slab = 0;
 		shrink_slab(prev_zone, priority, GFP_KERNEL);
 		sc.nr_reclaimed += reclaim_state->reclaimed_slab;
-		total_reclaimed += sc.nr_reclaimed;
-		total_scanned += sc.nr_scanned;
 
 		/*
 		 * If we've done a decent amount of scanning and
 		 * the reclaim ratio is low, start doing writepage
 		 * even in laptop mode
 		 */
-		if (total_scanned > SWAP_CLUSTER_MAX * 2 &&
-		    total_scanned > total_reclaimed+total_reclaimed/2)
+		if (sc.nr_scanned > SWAP_CLUSTER_MAX * 2 &&
+		    sc.nr_scanned > sc.nr_reclaimed + sc.nr_reclaimed / 2)
 			sc.may_writepage = 1;
 
-		if (nr_pages && to_free > total_reclaimed)
+		if (nr_pages && to_free > sc.nr_reclaimed)
 			continue;	/* swsusp: need to do more work */
 		if (all_zones_ok)
 			break;		/* kswapd: all done */
@@ -1457,7 +1449,7 @@ scan_swspd:
 		 * OK, kswapd is getting into trouble.  Take a nap, then take
 		 * another pass across the zones.
 		 */
-		if (total_scanned && priority < DEF_PRIORITY - PRIORITY_STEPS)
+		if (priority < DEF_PRIORITY - PRIORITY_STEPS)
 			blk_congestion_wait(WRITE, HZ/10);
 
 		/*
@@ -1466,7 +1458,7 @@ scan_swspd:
 		 * matches the direct reclaim path behaviour in terms of impact
 		 * on zone->*_priority.
 		 */
-		if ((total_reclaimed >= SWAP_CLUSTER_MAX) && (!nr_pages))
+		if (sc.nr_reclaimed >= SWAP_CLUSTER_MAX && !nr_pages)
 			break;
 	}
 	for (i = 0; i < pgdat->nr_zones; i++) {
@@ -1479,7 +1471,7 @@ scan_swspd:
 		goto loop_again;
 	}
 
-	return total_reclaimed;
+	return sc.nr_reclaimed;
 }
 
 /*

--
