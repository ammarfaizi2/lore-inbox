Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbVL3Wkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVL3Wkz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbVL3Wky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:40:54 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.23]:12321 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751261AbVL3Wkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:40:47 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051230224022.765.37557.sendpatchset@twins.localnet>
In-Reply-To: <20051230223952.765.21096.sendpatchset@twins.localnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
Subject: [PATCH 03/14] page-replace-remove-sc-from-refill.patch
Date: Fri, 30 Dec 2005 23:40:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Remove the dependency on struct scan_control from
refill_inactive_zone so we can move it into the page replace
file which doesn't know anything about scan_control.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

 mm/vmscan.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

Index: linux-2.6-git/mm/vmscan.c
===================================================================
--- linux-2.6-git.orig/mm/vmscan.c	2005-12-10 17:13:56.000000000 +0100
+++ linux-2.6-git/mm/vmscan.c	2005-12-10 18:19:39.000000000 +0100
@@ -71,8 +71,6 @@ struct scan_control {
 	/* Incremented by the number of pages reclaimed */
 	unsigned long nr_reclaimed;
 
-	unsigned long nr_mapped;	/* From page_state */
-
 	/* How many pages shrink_cache() should reclaim */
 	int nr_to_reclaim;
 
@@ -730,12 +728,11 @@ done:
  * But we had to alter page->flags anyway.
  */
 static void
-refill_inactive_zone(struct zone *zone, struct scan_control *sc)
+refill_inactive_zone(struct zone *zone, int nr_pages)
 {
 	int pgmoved;
 	int pgdeactivate = 0;
 	int pgscanned;
-	int nr_pages = sc->nr_to_scan;
 	LIST_HEAD(l_hold);	/* The pages which were snipped off */
 	LIST_HEAD(l_inactive);	/* Pages to go onto the inactive_list */
 	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
@@ -765,7 +762,7 @@ refill_inactive_zone(struct zone *zone, 
 	 * mapped memory instead of just pagecache.  Work out how much memory
 	 * is mapped.
 	 */
-	mapped_ratio = (sc->nr_mapped * 100) / total_memory;
+	mapped_ratio = (read_page_state(nr_mapped) * 100) / total_memory;
 
 	/*
 	 * Now decide how much we really want to unmap some pages.  The mapped
@@ -892,7 +889,7 @@ shrink_zone(struct zone *zone, struct sc
 			sc->nr_to_scan = min(nr_active,
 					(unsigned long)sc->swap_cluster_max);
 			nr_active -= sc->nr_to_scan;
-			refill_inactive_zone(zone, sc);
+			refill_inactive_zone(zone, sc->nr_to_scan);
 		}
 
 		if (nr_inactive) {
@@ -991,7 +988,6 @@ int try_to_free_pages(struct zone **zone
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
-		sc.nr_mapped = read_page_state(nr_mapped);
 		sc.nr_scanned = 0;
 		sc.nr_reclaimed = 0;
 		sc.priority = priority;
@@ -1080,7 +1076,6 @@ loop_again:
 	sc.gfp_mask = GFP_KERNEL;
 	sc.may_writepage = 0;
 	sc.may_swap = 1;
-	sc.nr_mapped = read_page_state(nr_mapped);
 
 	inc_page_state(pageoutrun);
 
@@ -1397,7 +1392,6 @@ int zone_reclaim(struct zone *zone, gfp_
 	sc.gfp_mask = gfp_mask;
 	sc.may_writepage = 0;
 	sc.may_swap = 0;
-	sc.nr_mapped = read_page_state(nr_mapped);
 	sc.nr_scanned = 0;
 	sc.nr_reclaimed = 0;
 	/* scan at the highest priority */
