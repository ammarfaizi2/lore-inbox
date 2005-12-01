Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVLAKNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVLAKNl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 05:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVLAKNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 05:13:40 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:43162 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932119AbVLAKNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 05:13:25 -0500
Message-Id: <20051201102051.210621000@localhost.localdomain>
References: <20051201101810.837245000@localhost.localdomain>
Date: Thu, 01 Dec 2005 18:18:17 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Nick Piggin <npiggin@suse.de>, Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 07/12] mm: remove unnecessary variable and loop
Content-Disposition: inline; filename=mm-remove-unnecessary-variable-and-loop.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shrink_cache() and refill_inactive_zone() do not need loops.

Simplify them to scan one chunk at a time.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/vmscan.c |   92 ++++++++++++++++++++++++++++--------------------------------
 1 files changed, 43 insertions(+), 49 deletions(-)

--- linux.orig/mm/vmscan.c
+++ linux/mm/vmscan.c
@@ -899,63 +899,58 @@ static void shrink_cache(struct zone *zo
 {
 	LIST_HEAD(page_list);
 	struct pagevec pvec;
-	int max_scan = sc->nr_to_scan;
+	struct page *page;
+	int nr_taken;
+	int nr_scan;
+	int nr_freed;
 
 	pagevec_init(&pvec, 1);
 
 	lru_add_drain();
 	spin_lock_irq(&zone->lru_lock);
-	while (max_scan > 0) {
-		struct page *page;
-		int nr_taken;
-		int nr_scan;
-		int nr_freed;
-
-		nr_taken = isolate_lru_pages(sc->nr_to_scan,
-					     &zone->inactive_list,
-					     &page_list, &nr_scan);
-		zone->nr_inactive -= nr_taken;
-		zone->pages_scanned += nr_scan;
-		update_zone_age(zone, nr_scan);
-		spin_unlock_irq(&zone->lru_lock);
+	nr_taken = isolate_lru_pages(sc->nr_to_scan,
+				     &zone->inactive_list,
+				     &page_list, &nr_scan);
+	zone->nr_inactive -= nr_taken;
+	zone->pages_scanned += nr_scan;
+	update_zone_age(zone, nr_scan);
+	spin_unlock_irq(&zone->lru_lock);
 
-		if (nr_taken == 0)
-			goto done;
+	if (nr_taken == 0)
+		return;
 
-		max_scan -= nr_scan;
-		sc->nr_scanned += nr_scan;
-		if (current_is_kswapd())
-			mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
-		else
-			mod_page_state_zone(zone, pgscan_direct, nr_scan);
-		nr_freed = shrink_list(&page_list, sc);
-		if (current_is_kswapd())
-			mod_page_state(kswapd_steal, nr_freed);
-		mod_page_state_zone(zone, pgsteal, nr_freed);
-		sc->nr_to_reclaim -= nr_freed;
+	sc->nr_scanned += nr_scan;
+	if (current_is_kswapd())
+		mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
+	else
+		mod_page_state_zone(zone, pgscan_direct, nr_scan);
+	nr_freed = shrink_list(&page_list, sc);
+	if (current_is_kswapd())
+		mod_page_state(kswapd_steal, nr_freed);
+	mod_page_state_zone(zone, pgsteal, nr_freed);
+	sc->nr_to_reclaim -= nr_freed;
 
-		spin_lock_irq(&zone->lru_lock);
-		/*
-		 * Put back any unfreeable pages.
-		 */
-		while (!list_empty(&page_list)) {
-			page = lru_to_page(&page_list);
-			if (TestSetPageLRU(page))
-				BUG();
-			list_del(&page->lru);
-			if (PageActive(page))
-				add_page_to_active_list(zone, page);
-			else
-				add_page_to_inactive_list(zone, page);
-			if (!pagevec_add(&pvec, page)) {
-				spin_unlock_irq(&zone->lru_lock);
-				__pagevec_release(&pvec);
-				spin_lock_irq(&zone->lru_lock);
-			}
+	spin_lock_irq(&zone->lru_lock);
+	/*
+	 * Put back any unfreeable pages.
+	 */
+	while (!list_empty(&page_list)) {
+		page = lru_to_page(&page_list);
+		if (TestSetPageLRU(page))
+			BUG();
+		list_del(&page->lru);
+		if (PageActive(page))
+			add_page_to_active_list(zone, page);
+		else
+			add_page_to_inactive_list(zone, page);
+		if (!pagevec_add(&pvec, page)) {
+			spin_unlock_irq(&zone->lru_lock);
+			__pagevec_release(&pvec);
+			spin_lock_irq(&zone->lru_lock);
 		}
-  	}
+	}
 	spin_unlock_irq(&zone->lru_lock);
-done:
+
 	pagevec_release(&pvec);
 }
 
@@ -982,7 +977,6 @@ refill_inactive_zone(struct zone *zone, 
 	int pgmoved;
 	int pgdeactivate = 0;
 	int pgscanned;
-	int nr_pages = sc->nr_to_scan;
 	LIST_HEAD(l_hold);	/* The pages which were snipped off */
 	LIST_HEAD(l_inactive);	/* Pages to go onto the inactive_list */
 	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
@@ -995,7 +989,7 @@ refill_inactive_zone(struct zone *zone, 
 
 	lru_add_drain();
 	spin_lock_irq(&zone->lru_lock);
-	pgmoved = isolate_lru_pages(nr_pages, &zone->active_list,
+	pgmoved = isolate_lru_pages(sc->nr_to_scan, &zone->active_list,
 				    &l_hold, &pgscanned);
 	zone->pages_scanned += pgscanned;
 	zone->nr_active -= pgmoved;

--
