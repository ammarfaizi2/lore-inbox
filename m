Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbVL3WlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbVL3WlM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVL3WlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:41:12 -0500
Received: from amsfep18-int.chello.nl ([213.46.243.13]:44096 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751273AbVL3WlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:41:06 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051230224043.765.91703.sendpatchset@twins.localnet>
In-Reply-To: <20051230223952.765.21096.sendpatchset@twins.localnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
Subject: [PATCH 05/14] page-replace-remove-loop.patch
Date: Fri, 30 Dec 2005 23:41:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

This patch removes the loop in shrink_cache() by directly taking
sc->nr_to_scan pages.

Kudos to Wu Fengguang who did a similair patch.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

 mm/vmscan.c |   88 +++++++++++++++++++++++++++---------------------------------
 1 files changed, 41 insertions(+), 47 deletions(-)

Index: linux-2.6-git/mm/vmscan.c
===================================================================
--- linux-2.6-git.orig/mm/vmscan.c	2005-12-10 17:13:57.000000000 +0100
+++ linux-2.6-git/mm/vmscan.c	2005-12-10 18:19:30.000000000 +0100
@@ -653,61 +653,55 @@ static void shrink_cache(struct zone *zo
 {
 	LIST_HEAD(page_list);
 	struct pagevec pvec;
-	int max_scan = sc->nr_to_scan;
-
-	pagevec_init(&pvec, 1);
+	struct page *page;
+	int nr_taken;
+	int nr_scan;
+	int nr_freed;
 
 	lru_add_drain();
+
 	spin_lock_irq(&zone->lru_lock);
-	while (max_scan > 0) {
-		struct page *page;
-		int nr_taken;
-		int nr_scan;
-		int nr_freed;
-
-		nr_taken = isolate_lru_pages(sc->swap_cluster_max,
-					     &zone->inactive_list,
-					     &page_list, &nr_scan);
-		zone->nr_inactive -= nr_taken;
-		zone->pages_scanned += nr_scan;
-		spin_unlock_irq(&zone->lru_lock);
+	nr_taken = isolate_lru_pages(sc->nr_to_scan,
+				     &zone->inactive_list,
+				     &page_list, &nr_scan);
+	zone->nr_inactive -= nr_taken;
+	zone->pages_scanned += nr_scan;
+	spin_unlock_irq(&zone->lru_lock);
 
-		if (nr_taken == 0)
-			goto done;
+	if (nr_taken == 0)
+		return;
 
-		max_scan -= nr_scan;
-		if (current_is_kswapd())
-			mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
-		else
-			mod_page_state_zone(zone, pgscan_direct, nr_scan);
-		nr_freed = shrink_list(&page_list, sc);
-		if (current_is_kswapd())
-			mod_page_state(kswapd_steal, nr_freed);
-		mod_page_state_zone(zone, pgsteal, nr_freed);
-		sc->nr_to_reclaim -= nr_freed;
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
+	/*
+	 * Put back any unfreeable pages.
+	 */
+	pagevec_init(&pvec, 1);
+	spin_lock_irq(&zone->lru_lock);
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
 	pagevec_release(&pvec);
 }
 
