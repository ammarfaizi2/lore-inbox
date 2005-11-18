Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbVKRBDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbVKRBDI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 20:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVKRBDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 20:03:08 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:7352 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751333AbVKRBDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 20:03:07 -0500
Date: Thu, 17 Nov 2005 17:02:57 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: lhms-devel@lists.sourceforge.net, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20051118010257.22328.49524.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 1/4] SwapMig: [resend] CONFIG_MIGRATION fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move move_to_lru, putback_lru_pages and isolate_lru in section surrounded
by CONFIG_MIGRATION saving some codesize for single processor kernels.

[posted earlier in a different form but somehow missing from 2.6.15-rc1-mm1]

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc1-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc1-mm1.orig/mm/vmscan.c	2005-11-17 15:17:32.000000000 -0800
+++ linux-2.6.15-rc1-mm1/mm/vmscan.c	2005-11-17 16:55:49.000000000 -0800
@@ -571,6 +571,40 @@ keep:
 }
 
 #ifdef CONFIG_MIGRATION
+static inline void move_to_lru(struct page *page)
+{
+	list_del(&page->lru);
+	if (PageActive(page)) {
+		/*
+		 * lru_cache_add_active checks that
+		 * the PG_active bit is off.
+		 */
+		ClearPageActive(page);
+		lru_cache_add_active(page);
+	} else {
+		lru_cache_add(page);
+	}
+	put_page(page);
+}
+
+/*
+ * Add isolated pages on the list back to the LRU
+ *
+ * returns the number of pages put back.
+ */
+int putback_lru_pages(struct list_head *l)
+{
+	struct page *page;
+	struct page *page2;
+	int count = 0;
+
+	list_for_each_entry_safe(page, page2, l, lru) {
+		move_to_lru(page);
+		count++;
+	}
+	return count;
+}
+
 /*
  * swapout a single page
  * page is locked upon entry, unlocked on exit
@@ -720,6 +754,48 @@ retry_later:
 
 	return nr_failed + retry;
 }
+
+static void lru_add_drain_per_cpu(void *dummy)
+{
+	lru_add_drain();
+}
+
+/*
+ * Isolate one page from the LRU lists and put it on the
+ * indicated list. Do necessary cache draining if the
+ * page is not on the LRU lists yet.
+ *
+ * Result:
+ *  0 = page not on LRU list
+ *  1 = page removed from LRU list and added to the specified list.
+ * -ENOENT = page is being freed elsewhere.
+ */
+int isolate_lru_page(struct page *page)
+{
+	int rc = 0;
+	struct zone *zone = page_zone(page);
+
+redo:
+	spin_lock_irq(&zone->lru_lock);
+	rc = __isolate_lru_page(page);
+	if (rc == 1) {
+		if (PageActive(page))
+			del_page_from_active_list(zone, page);
+		else
+			del_page_from_inactive_list(zone, page);
+	}
+	spin_unlock_irq(&zone->lru_lock);
+	if (rc == 0) {
+		/*
+		 * Maybe this page is still waiting for a cpu to drain it
+		 * from one of the lru lists?
+		 */
+		on_each_cpu(lru_add_drain_per_cpu, NULL, 0, 1);
+		if (PageLRU(page))
+			goto redo;
+	}
+	return rc;
+}
 #endif
 
 /*
@@ -769,48 +845,6 @@ static int isolate_lru_pages(int nr_to_s
 	return nr_taken;
 }
 
-static void lru_add_drain_per_cpu(void *dummy)
-{
-	lru_add_drain();
-}
-
-/*
- * Isolate one page from the LRU lists and put it on the
- * indicated list. Do necessary cache draining if the
- * page is not on the LRU lists yet.
- *
- * Result:
- *  0 = page not on LRU list
- *  1 = page removed from LRU list and added to the specified list.
- * -ENOENT = page is being freed elsewhere.
- */
-int isolate_lru_page(struct page *page)
-{
-	int rc = 0;
-	struct zone *zone = page_zone(page);
-
-redo:
-	spin_lock_irq(&zone->lru_lock);
-	rc = __isolate_lru_page(page);
-	if (rc == 1) {
-		if (PageActive(page))
-			del_page_from_active_list(zone, page);
-		else
-			del_page_from_inactive_list(zone, page);
-	}
-	spin_unlock_irq(&zone->lru_lock);
-	if (rc == 0) {
-		/*
-		 * Maybe this page is still waiting for a cpu to drain it
-		 * from one of the lru lists?
-		 */
-		on_each_cpu(lru_add_drain_per_cpu, NULL, 0, 1);
-		if (PageLRU(page))
-			goto redo;
-	}
-	return rc;
-}
-
 /*
  * shrink_cache() adds the number of pages reclaimed to sc->nr_reclaimed
  */
@@ -876,40 +910,6 @@ done:
 	pagevec_release(&pvec);
 }
 
-static inline void move_to_lru(struct page *page)
-{
-	list_del(&page->lru);
-	if (PageActive(page)) {
-		/*
-		 * lru_cache_add_active checks that
-		 * the PG_active bit is off.
-		 */
-		ClearPageActive(page);
-		lru_cache_add_active(page);
-	} else {
-		lru_cache_add(page);
-	}
-	put_page(page);
-}
-
-/*
- * Add isolated pages on the list back to the LRU
- *
- * returns the number of pages put back.
- */
-int putback_lru_pages(struct list_head *l)
-{
-	struct page *page;
-	struct page *page2;
-	int count = 0;
-
-	list_for_each_entry_safe(page, page2, l, lru) {
-		move_to_lru(page);
-		count++;
-	}
-	return count;
-}
-
 /*
  * This moves pages from the active list to the inactive list.
  *
Index: linux-2.6.15-rc1-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.15-rc1-mm1.orig/include/linux/swap.h	2005-11-17 16:55:00.000000000 -0800
+++ linux-2.6.15-rc1-mm1/include/linux/swap.h	2005-11-17 16:55:05.000000000 -0800
@@ -176,10 +176,9 @@ extern int zone_reclaim(struct zone *, g
 extern int shrink_all_memory(int);
 extern int vm_swappiness;
 
+#ifdef CONFIG_MIGRATION
 extern int isolate_lru_page(struct page *p);
 extern int putback_lru_pages(struct list_head *l);
-
-#ifdef CONFIG_MIGRATION
 extern int migrate_pages(struct list_head *l, struct list_head *t);
 #endif
 
