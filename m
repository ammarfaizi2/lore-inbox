Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVLAKOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVLAKOi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 05:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbVLAKOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 05:14:11 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:35739 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932112AbVLAKNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 05:13:55 -0500
Message-Id: <20051201102121.974178000@localhost.localdomain>
References: <20051201101810.837245000@localhost.localdomain>
Date: Thu, 01 Dec 2005 18:18:19 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Nick Piggin <npiggin@suse.de>, Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 09/12] mm: accumulate sc.nr_scanned/sc.nr_reclaimed
Content-Disposition: inline; filename=mm-accumulate-nr-scanned-reclaimed-in-scan-control.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there's no need to keep track of nr_scanned/nr_reclaimed for every
single round of shrink_zone(), remove the total_scanned/total_reclaimed and
let nr_scanned/nr_reclaimed accumulate between rounds.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/vmscan.c |   36 ++++++++++++++----------------------
 1 files changed, 14 insertions(+), 22 deletions(-)

--- linux.orig/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -1229,7 +1229,6 @@ int try_to_free_pages(struct zone **zone
 {
 	int priority;
 	int ret = 0;
-	int total_scanned = 0, total_reclaimed = 0;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
 	int i;
@@ -1239,6 +1238,8 @@ int try_to_free_pages(struct zone **zone
 	sc.gfp_mask = gfp_mask;
 	sc.may_writepage = 0;
 	sc.may_swap = 1;
+	sc.nr_scanned = 0;
+	sc.nr_reclaimed = 0;
 
 	inc_page_state(allocstall);
 
@@ -1254,8 +1255,6 @@ int try_to_free_pages(struct zone **zone
 	/* The added 10 priorities are for scan rate balancing */
 	for (priority = DEF_PRIORITY + 10; priority >= 0; priority--) {
 		sc.nr_mapped = read_page_state(nr_mapped);
-		sc.nr_scanned = 0;
-		sc.nr_reclaimed = 0;
 		sc.priority = priority;
 		sc.nr_to_reclaim = SWAP_CLUSTER_MAX;
 		if (!priority)
@@ -1266,9 +1265,7 @@ int try_to_free_pages(struct zone **zone
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
@@ -1280,13 +1277,13 @@ int try_to_free_pages(struct zone **zone
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
-		if (sc.nr_scanned && priority < DEF_PRIORITY)
+		if (priority < DEF_PRIORITY)
 			blk_congestion_wait(WRITE, HZ/10);
 	}
 out:
@@ -1332,19 +1329,18 @@ static int balance_pgdat(pg_data_t *pgda
 	int all_zones_ok;
 	int priority;
 	int i;
-	int total_scanned, total_reclaimed;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
 	struct scan_control sc;
 	struct zone *youngest_zone = NULL;
 	struct zone *oldest_zone = NULL;
 
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
 
@@ -1421,19 +1415,17 @@ loop_again:
 		reclaim_state->reclaimed_slab = 0;
 		shrink_slab(GFP_KERNEL);
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
@@ -1441,7 +1433,7 @@ loop_again:
 		 * OK, kswapd is getting into trouble.  Take a nap, then take
 		 * another pass across the zones.
 		 */
-		if (total_scanned && priority < DEF_PRIORITY - 2)
+		if (priority < DEF_PRIORITY - 2)
 			blk_congestion_wait(WRITE, HZ/10);
 
 		/*
@@ -1450,7 +1442,7 @@ loop_again:
 		 * matches the direct reclaim path behaviour in terms of impact
 		 * on zone->*_priority.
 		 */
-		if ((total_reclaimed >= SWAP_CLUSTER_MAX) && (!nr_pages))
+		if (sc.nr_reclaimed >= SWAP_CLUSTER_MAX && !nr_pages)
 			break;
 	}
 	for (i = 0; i < pgdat->nr_zones; i++) {
@@ -1463,7 +1455,7 @@ loop_again:
 		goto loop_again;
 	}
 
-	return total_reclaimed;
+	return sc.nr_reclaimed;
 }
 
 /*

--
