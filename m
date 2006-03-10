Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbWCJDoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbWCJDoi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 22:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWCJDof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 22:44:35 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:15023 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932571AbWCJDoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 22:44:21 -0500
From: Magnus Damm <magnus@valinux.co.jp>
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: Magnus Damm <magnus@valinux.co.jp>
Message-Id: <20060310034422.8340.37232.sendpatchset@cherry.local>
In-Reply-To: <20060310034412.8340.90939.sendpatchset@cherry.local>
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
Subject: [PATCH 02/03] Unmapped: Modify LRU behaviour
Date: Fri, 10 Mar 2006 12:44:18 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move reclaim_mapped logic, sc->nr_mapped, keep active unmapped pages.

This patch moves the reclaim_mapped logic from refill_inactive_zone() to
shrink_zone(), where it is used to determine if the mapped LRU should be
scanned or not. The sc->nr_mapped member is removed and replaced with code
that checks the number of pages placed on the per-zone mapped LRU.
refill_inactive_zone is changed to allow rotate of active unmapped pages.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 vmscan.c |  106 +++++++++++++++++++++++++++++---------------------------------
 1 files changed, 51 insertions(+), 55 deletions(-)

--- from-0003/mm/vmscan.c
+++ to-work/mm/vmscan.c	2006-03-06 16:58:27.000000000 +0900
@@ -61,8 +61,6 @@ struct scan_control {
 	/* Incremented by the number of pages reclaimed */
 	unsigned long nr_reclaimed;
 
-	unsigned long nr_mapped;	/* From page_state */
-
 	/* Ask shrink_caches, or shrink_zone to scan at this priority */
 	unsigned int priority;
 
@@ -1202,48 +1200,6 @@ refill_inactive_zone(struct zone *zone, 
 	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
 	struct page *page;
 	struct pagevec pvec;
-	int reclaim_mapped = 0;
-
-	if (unlikely(sc->may_swap)) {
-		long mapped_ratio;
-		long distress;
-		long swap_tendency;
-
-		/*
-		 * `distress' is a measure of how much trouble we're having
-		 * reclaiming pages.  0 -> no problems.  100 -> great trouble.
-		 */
-		distress = 100 >> zone->prev_priority;
-
-		/*
-		 * The point of this algorithm is to decide when to start
-		 * reclaiming mapped memory instead of just pagecache.  Work out
-		 * how much memory
-		 * is mapped.
-		 */
-		mapped_ratio = (sc->nr_mapped * 100) / total_memory;
-
-		/*
-		 * Now decide how much we really want to unmap some pages.  The
-		 * mapped ratio is downgraded - just because there's a lot of
-		 * mapped memory doesn't necessarily mean that page reclaim
-		 * isn't succeeding.
-		 *
-		 * The distress ratio is important - we don't want to start
-		 * going oom.
-		 *
-		 * A 100% value of vm_swappiness overrides this algorithm
-		 * altogether.
-		 */
-		swap_tendency = mapped_ratio / 2 + distress + vm_swappiness;
-
-		/*
-		 * Now use this metric to decide whether to start moving mapped
-		 * memory onto the inactive list.
-		 */
-		if (swap_tendency >= 100)
-			reclaim_mapped = 1;
-	}
 
 	lru_add_drain();
 	spin_lock_irq(&zone->lru_lock);
@@ -1257,13 +1213,10 @@ refill_inactive_zone(struct zone *zone, 
 		cond_resched();
 		page = lru_to_page(&l_hold);
 		list_del(&page->lru);
-		if (page_mapped(page)) {
-			if (!reclaim_mapped ||
-			    (total_swap_pages == 0 && PageAnon(page)) ||
-			    page_referenced(page, 0)) {
-				list_add(&page->lru, &l_active);
-				continue;
-			}
+		if ((total_swap_pages == 0 && PageAnon(page)) ||
+		    page_referenced(page, 0)) {
+			list_add(&page->lru, &l_active);
+			continue;
 		}
 		list_add(&page->lru, &l_inactive);
 	}
@@ -1378,8 +1331,54 @@ shrink_lru(struct zone *zone, int lru_nr
 static void
 shrink_zone(struct zone *zone, struct scan_control *sc)
 {
+	int reclaim_mapped = 0;
+
+	if (unlikely(sc->may_swap)) {
+		struct lru *lru = &zone->lru[LRU_MAPPED];
+		long mapped_ratio;
+		long distress;
+		long swap_tendency;
+
+		/*
+		 * `distress' is a measure of how much trouble we're having
+		 * reclaiming pages.  0 -> no problems.  100 -> great trouble.
+		 */
+		distress = 100 >> zone->prev_priority;
+
+		/*
+		 * The point of this algorithm is to decide when to start
+		 * reclaiming mapped memory instead of just pagecache.
+		 * Work out how much memory is mapped.
+		 */
+		mapped_ratio = (lru->nr_active + lru->nr_inactive) * 100;
+		mapped_ratio /= zone->present_pages;
+
+		/*
+		 * Now decide how much we really want to unmap some pages.  The
+		 * mapped ratio is downgraded - just because there's a lot of
+		 * mapped memory doesn't necessarily mean that page reclaim
+		 * isn't succeeding.
+		 *
+		 * The distress ratio is important - we don't want to start
+		 * going oom.
+		 *
+		 * A 100% value of vm_swappiness overrides this algorithm
+		 * altogether.
+		 */
+		swap_tendency = mapped_ratio / 2 + distress + vm_swappiness;
+
+		/*
+		 * Now use this metric to decide whether to start moving mapped
+		 * memory onto the inactive list.
+		 */
+		if (swap_tendency >= 100)
+			reclaim_mapped = 1;
+	}
+
 	shrink_lru(zone, LRU_UNMAPPED, sc);
-	shrink_lru(zone, LRU_MAPPED, sc);
+
+	if (reclaim_mapped)
+		shrink_lru(zone, LRU_MAPPED, sc);
 }
 
 /*
@@ -1463,7 +1462,6 @@ int try_to_free_pages(struct zone **zone
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
-		sc.nr_mapped = read_page_state(nr_mapped);
 		sc.nr_scanned = 0;
 		sc.nr_reclaimed = 0;
 		sc.priority = priority;
@@ -1552,7 +1550,6 @@ loop_again:
 	sc.gfp_mask = GFP_KERNEL;
 	sc.may_writepage = !laptop_mode;
 	sc.may_swap = 1;
-	sc.nr_mapped = read_page_state(nr_mapped);
 
 	inc_page_state(pageoutrun);
 
@@ -1910,7 +1907,6 @@ int zone_reclaim(struct zone *zone, gfp_
 	sc.nr_scanned = 0;
 	sc.nr_reclaimed = 0;
 	sc.priority = ZONE_RECLAIM_PRIORITY + 1;
-	sc.nr_mapped = read_page_state(nr_mapped);
 	sc.gfp_mask = gfp_mask;
 
 	disable_swap_token();
