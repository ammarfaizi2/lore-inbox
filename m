Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVL3WmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVL3WmA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbVL3Wlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:41:39 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.23]:59952 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S932178AbVL3Wlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:41:36 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051230224112.765.4023.sendpatchset@twins.localnet>
In-Reply-To: <20051230223952.765.21096.sendpatchset@twins.localnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
Subject: [PATCH 08/14] page-replace-candidates.patch
Date: Fri, 30 Dec 2005 23:41:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

page-replace interface function:
  page_replace_candidates()

Abstract the taking of candidate reclaim pages and place the new function
in page_replace.c; the place where all list manupulation happens.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

 include/linux/mm_page_replace.h |    2 ++
 mm/page_replace.c               |   20 ++++++++++++++++++++
 mm/vmscan.c                     |   17 ++---------------
 3 files changed, 24 insertions(+), 15 deletions(-)

Index: linux-2.6-git-2/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git-2.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git-2/include/linux/mm_page_replace.h
@@ -5,6 +5,7 @@
 
 #include <linux/mmzone.h>
 #include <linux/mm.h>
+#include <linux/list.h>
 
 #define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
 
@@ -37,6 +38,7 @@
 #endif
 
 void __page_replace_insert(struct zone *, struct page *);
+void page_replace_candidates(struct zone *, int, struct list_head *);
 static inline void page_replace_activate(struct page *page)
 {
 	SetPageActive(page);
Index: linux-2.6-git-2/mm/page_replace.c
===================================================================
--- linux-2.6-git-2.orig/mm/page_replace.c
+++ linux-2.6-git-2/mm/page_replace.c
@@ -1,5 +1,6 @@
 #include <linux/mm_page_replace.h>
 #include <linux/mm_inline.h>
+#include <linux/swap.h>
 
 
 void __page_replace_insert(struct zone *zone, struct page *page)
@@ -58,3 +59,22 @@ int isolate_lru_pages(int nr_to_scan, st
 	*scanned = scan;
 	return nr_taken;
 }
+
+void page_replace_candidates(struct zone *zone, int nr_to_scan, struct list_head *page_list)
+{
+	int nr_taken;
+	int nr_scan;
+
+	spin_lock_irq(&zone->lru_lock);
+	nr_taken = isolate_lru_pages(nr_to_scan, &zone->inactive_list,
+				     page_list, &nr_scan);
+	zone->nr_inactive -= nr_taken;
+	zone->pages_scanned += nr_scan;
+	spin_unlock_irq(&zone->lru_lock);
+
+	if (current_is_kswapd())
+		mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
+	else
+		mod_page_state_zone(zone, pgscan_direct, nr_scan);
+}
+
Index: linux-2.6-git-2/mm/vmscan.c
===================================================================
--- linux-2.6-git-2.orig/mm/vmscan.c
+++ linux-2.6-git-2/mm/vmscan.c
@@ -575,27 +575,14 @@ static void shrink_cache(struct zone *zo
 	LIST_HEAD(page_list);
 	struct pagevec pvec;
 	struct page *page;
-	int nr_taken;
-	int nr_scan;
 	int nr_freed;
 
 	lru_add_drain();
 
-	spin_lock_irq(&zone->lru_lock);
-	nr_taken = isolate_lru_pages(sc->nr_to_scan,
-				     &zone->inactive_list,
-				     &page_list, &nr_scan);
-	zone->nr_inactive -= nr_taken;
-	zone->pages_scanned += nr_scan;
-	spin_unlock_irq(&zone->lru_lock);
-
-	if (nr_taken == 0)
+	page_replace_candidates(zone, sc->nr_to_scan, &page_list);
+	if (list_empty(&page_list))
 		return;
 
-	if (current_is_kswapd())
-		mod_page_state_zone(zone, pgscan_kswapd, nr_scan);
-	else
-		mod_page_state_zone(zone, pgscan_direct, nr_scan);
 	nr_freed = shrink_list(&page_list, sc);
 	if (current_is_kswapd())
 		mod_page_state(kswapd_steal, nr_freed);
