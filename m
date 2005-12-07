Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVLGKZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVLGKZM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVLGKYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:24:51 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:7352 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750796AbVLGKYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:24:40 -0500
Message-Id: <20051207105051.503626000@localhost.localdomain>
References: <20051207104755.177435000@localhost.localdomain>
Date: Wed, 07 Dec 2005 18:48:03 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Nick Piggin <npiggin@suse.de>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 08/16] mm: fine grained scan priority
Content-Disposition: inline; filename=mm-fine-grained-scan-priority.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Limit max scan fraction to 1/64. The scan fractions will be 
	1/4096, 64x1/2048, 64x1/1024, ..., 64x1/64

The old ones are
	1/4096, 1/2048, 1/1024, ..., 1/1
which is too much to create major imbalance of aging rates.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/mmzone.h |    9 ++++++---
 mm/vmscan.c            |   18 ++++++++++++------
 2 files changed, 18 insertions(+), 9 deletions(-)

--- linux.orig/include/linux/mmzone.h
+++ linux/include/linux/mmzone.h
@@ -251,10 +251,13 @@ struct zone {
 
 /*
  * The "priority" of VM scanning is how much of the queues we will scan in one
- * go. A value of 12 for DEF_PRIORITY implies that we will scan 1/4096th of the
- * queues ("queue_length >> 12") during an aging round.
+ * go. A value of 12 for DEF_PRIORITY/PRIORITY_STEPS implies that we will
+ * scan 1/4096th of the queues ("queue_length >> 12") during an aging round.
+ * Typically we will first try to scan 1/4096, then 64 times 1/2048, then 64
+ * times 1/1024, ..., at last 64 times 1/64.
  */
-#define DEF_PRIORITY 12
+#define PRIORITY_STEPS	64
+#define DEF_PRIORITY	(12*PRIORITY_STEPS)
 
 /*
  * One allocation request operates on a zonelist. A zonelist
--- linux.orig/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -1006,7 +1006,7 @@ refill_inactive_zone(struct zone *zone, 
 	 * `distress' is a measure of how much trouble we're having reclaiming
 	 * pages.  0 -> no problems.  100 -> great trouble.
 	 */
-	distress = 100 >> zone->prev_priority;
+	distress = 100 >> (zone->prev_priority / PRIORITY_STEPS);
 
 	/*
 	 * The point of this algorithm is to decide when to start reclaiming
@@ -1128,7 +1128,8 @@ shrink_zone(struct zone *zone, struct sc
 	 * slowly sift through the active list.
 	 */
 	nr_active = zone->nr_scan_active + 1;
-	nr_inactive = (zone->nr_inactive >> sc->priority) + SWAP_CLUSTER_MAX;
+	nr_inactive = ((zone->nr_inactive / PRIORITY_STEPS) >>
+			(sc->priority / PRIORITY_STEPS)) + SWAP_CLUSTER_MAX;
 	nr_inactive &= ~(SWAP_CLUSTER_MAX - 1);
 
 	sc->nr_to_scan = SWAP_CLUSTER_MAX;
@@ -1265,8 +1266,13 @@ int try_to_free_pages(struct zone **zone
 		zone->temp_priority = DEF_PRIORITY;
 	}
 
-	/* The added 10 priorities are for scan rate balancing */
-	for (priority = DEF_PRIORITY + 10; priority >= 0; priority--) {
+	/*
+	 * The first PRIORITY_STEPS priorities are for scan rate balancing.
+	 * One run of shrink_zone() can create at most 1/64 imbalance, here
+	 * we first scan about 64 times 1/4096 for aging, just enough to
+	 * rebalance it, before creating new imbalance.
+	 */
+	for (priority = DEF_PRIORITY + PRIORITY_STEPS; priority >= 0; priority--) {
 		sc.nr_mapped = read_page_state(nr_mapped);
 		sc.nr_scanned = 0;
 		sc.nr_reclaimed = 0;
@@ -1301,7 +1307,7 @@ int try_to_free_pages(struct zone **zone
 		}
 
 		/* Take a nap, wait for some writeback to complete */
-		if (sc.nr_scanned && priority < DEF_PRIORITY)
+		if (sc.nr_scanned && priority < DEF_PRIORITY - PRIORITY_STEPS)
 			blk_congestion_wait(WRITE, HZ/10);
 	}
 out:
@@ -1464,7 +1470,7 @@ scan_swspd:
 		 * OK, kswapd is getting into trouble.  Take a nap, then take
 		 * another pass across the zones.
 		 */
-		if (total_scanned && priority < DEF_PRIORITY - 2)
+		if (total_scanned && priority < DEF_PRIORITY - PRIORITY_STEPS)
 			blk_congestion_wait(WRITE, HZ/10);
 
 		/*

--
