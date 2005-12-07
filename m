Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbVLGKZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVLGKZf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVLGKZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:25:17 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:9401 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750796AbVLGKZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:25:11 -0500
Message-Id: <20051207105122.554509000@localhost.localdomain>
References: <20051207104755.177435000@localhost.localdomain>
Date: Wed, 07 Dec 2005 18:48:05 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 10/16] mm: remove swap_cluster_max from scan_control
Content-Disposition: inline; filename=mm-remove-swap-cluster-max-from-scan-control.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The use of sc.swap_cluster_max is weird and redundant.

The callers should just set sc.priority/sc.nr_to_reclaim, and let
shrink_zone() decide the proper loop parameters.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/vmscan.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

--- linux.orig/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -76,12 +76,6 @@ struct scan_control {
 
 	/* Can pages be swapped as part of reclaim? */
 	int may_swap;
-
-	/* This context's SWAP_CLUSTER_MAX. If freeing memory for
-	 * suspend, we effectively ignore SWAP_CLUSTER_MAX.
-	 * In this context, it doesn't matter that we scan the
-	 * whole list at once. */
-	int swap_cluster_max;
 };
 
 #define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
@@ -1127,7 +1121,6 @@ shrink_zone(struct zone *zone, struct sc
 	nr_inactive &= ~(SWAP_CLUSTER_MAX - 1);
 
 	sc->nr_to_scan = SWAP_CLUSTER_MAX;
-	sc->nr_to_reclaim = sc->swap_cluster_max;
 
 	while (nr_active >= SWAP_CLUSTER_MAX * 1024 || nr_inactive) {
 		if (nr_active >= SWAP_CLUSTER_MAX * 1024) {
@@ -1271,7 +1264,7 @@ int try_to_free_pages(struct zone **zone
 		sc.nr_scanned = 0;
 		sc.nr_reclaimed = 0;
 		sc.priority = priority;
-		sc.swap_cluster_max = SWAP_CLUSTER_MAX;
+		sc.nr_to_reclaim = SWAP_CLUSTER_MAX;
 		if (!priority)
 			disable_swap_token();
 		shrink_caches(zones, &sc);
@@ -1283,7 +1276,7 @@ int try_to_free_pages(struct zone **zone
 		}
 		total_scanned += sc.nr_scanned;
 		total_reclaimed += sc.nr_reclaimed;
-		if (total_reclaimed >= sc.swap_cluster_max) {
+		if (total_reclaimed >= SWAP_CLUSTER_MAX) {
 			ret = 1;
 			goto out;
 		}
@@ -1295,7 +1288,7 @@ int try_to_free_pages(struct zone **zone
 		 * that's undesirable in laptop mode, where we *want* lumpy
 		 * writeout.  So in laptop mode, write out the whole world.
 		 */
-		if (total_scanned > sc.swap_cluster_max + sc.swap_cluster_max/2) {
+		if (total_scanned > SWAP_CLUSTER_MAX * 3 / 2) {
 			wakeup_pdflush(laptop_mode ? 0 : total_scanned);
 			sc.may_writepage = 1;
 		}
@@ -1376,7 +1369,7 @@ loop_again:
 		sc.nr_scanned = 0;
 		sc.nr_reclaimed = 0;
 		sc.priority = priority;
-		sc.swap_cluster_max = nr_pages ? nr_pages : SWAP_CLUSTER_MAX;
+		sc.nr_to_reclaim = nr_pages ? nr_pages : SWAP_CLUSTER_MAX;
 
 		/* The swap token gets in the way of swapout... */
 		if (!priority)

--
