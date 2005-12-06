Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbVLFNgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbVLFNgu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbVLFNgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:36:43 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:13530 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932573AbVLFNgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:36:14 -0500
Message-Id: <20051206135906.658120000@localhost.localdomain>
References: <20051206135608.860737000@localhost.localdomain>
Date: Tue, 06 Dec 2005 21:56:17 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 09/13] mm: remove swap_cluster_max from scan_control
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

--- linux-2.6.15-rc5-mm1.orig/mm/vmscan.c
+++ linux-2.6.15-rc5-mm1/mm/vmscan.c
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
@@ -1121,7 +1115,6 @@ shrink_zone(struct zone *zone, struct sc
 	nr_inactive &= ~(SWAP_CLUSTER_MAX - 1);
 
 	sc->nr_to_scan = SWAP_CLUSTER_MAX;
-	sc->nr_to_reclaim = sc->swap_cluster_max;
 
 	while (nr_active >= SWAP_CLUSTER_MAX * 1024 || nr_inactive) {
 		if (nr_active >= SWAP_CLUSTER_MAX * 1024) {
@@ -1260,7 +1253,7 @@ int try_to_free_pages(struct zone **zone
 		sc.nr_scanned = 0;
 		sc.nr_reclaimed = 0;
 		sc.priority = priority;
-		sc.swap_cluster_max = SWAP_CLUSTER_MAX;
+		sc.nr_to_reclaim = SWAP_CLUSTER_MAX;
 		if (!priority)
 			disable_swap_token();
 		shrink_caches(zones, &sc);
@@ -1272,7 +1265,7 @@ int try_to_free_pages(struct zone **zone
 		}
 		total_scanned += sc.nr_scanned;
 		total_reclaimed += sc.nr_reclaimed;
-		if (total_reclaimed >= sc.swap_cluster_max) {
+		if (total_reclaimed >= SWAP_CLUSTER_MAX) {
 			ret = 1;
 			goto out;
 		}
@@ -1284,7 +1277,7 @@ int try_to_free_pages(struct zone **zone
 		 * that's undesirable in laptop mode, where we *want* lumpy
 		 * writeout.  So in laptop mode, write out the whole world.
 		 */
-		if (total_scanned > sc.swap_cluster_max + sc.swap_cluster_max/2) {
+		if (total_scanned > SWAP_CLUSTER_MAX * 3 / 2) {
 			wakeup_pdflush(laptop_mode ? 0 : total_scanned);
 			sc.may_writepage = 1;
 		}
@@ -1365,7 +1358,7 @@ loop_again:
 		sc.nr_scanned = 0;
 		sc.nr_reclaimed = 0;
 		sc.priority = priority;
-		sc.swap_cluster_max = nr_pages ? nr_pages : SWAP_CLUSTER_MAX;
+		sc.nr_to_reclaim = nr_pages ? nr_pages : SWAP_CLUSTER_MAX;
 
 		/* The swap token gets in the way of swapout... */
 		if (!priority)

--
