Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbVJYTbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVJYTbl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 15:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVJYTb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 15:31:27 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:8356 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932322AbVJYTbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 15:31:08 -0400
Date: Tue, 25 Oct 2005 12:30:28 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mike Kravetz <kravetz@us.ibm.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>,
       Lee Schermerhorn <lee.schermerhorn@hp.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Christoph Lameter <clameter@sgi.com>,
       Magnus Damm <magnus.damm@gmail.com>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20051025193028.6828.27929.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051025193023.6828.89649.sendpatchset@schroedinger.engr.sgi.com>
References: <20051025193023.6828.89649.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 1/5] Swap Migration V4: LRU operations
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isolation of pages from LRU

Implement functions to isolate pages from the LRU and put them back later.

An earlier implementation was provided by
Hirokazu Takahashi <taka@valinux.co.jp> and
IWAMOTO Toshihiro <iwamoto@valinux.co.jp> for the memory
hotplug project.

>From Magnus:

This patch for 2.6.14-rc4-mm1 breaks out isolate_lru_page() and
putpack_lru_page() and makes them inline. I'd like to build my code on
top of this patch, and I think your page eviction code could be built
on top of this patch too - without introducing too much duplicated
code.

Changes V3-V4:

- Remove obsolete second parameter from isolate_lru_page
- Mention the original authors

Signed-off-by: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-rc5-mm1/include/linux/mm_inline.h
===================================================================
--- linux-2.6.14-rc5-mm1.orig/include/linux/mm_inline.h	2005-10-19 23:23:05.000000000 -0700
+++ linux-2.6.14-rc5-mm1/include/linux/mm_inline.h	2005-10-25 08:09:52.000000000 -0700
@@ -38,3 +38,55 @@ del_page_from_lru(struct zone *zone, str
 		zone->nr_inactive--;
 	}
 }
+
+/*
+ * Isolate one page from the LRU lists.
+ *
+ * - zone->lru_lock must be held
+ *
+ * Result:
+ *  0 = page not on LRU list
+ *  1 = page removed from LRU list
+ * -1 = page is being freed elsewhere.
+ */
+static inline int
+__isolate_lru_page(struct zone *zone, struct page *page)
+{
+	if (TestClearPageLRU(page)) {
+		if (get_page_testone(page)) {
+			/*
+			 * It is being freed elsewhere
+			 */
+			__put_page(page);
+			SetPageLRU(page);
+			return -1;
+		} else {
+			if (PageActive(page))
+				del_page_from_active_list(zone, page);
+			else
+				del_page_from_inactive_list(zone, page);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Add isolated page back on the LRU lists
+ *
+ * - zone->lru_lock must be held
+ * - page must already be removed from other list
+ * - additional call to put_page() is needed
+ */
+static inline void
+__putback_lru_page(struct zone *zone, struct page *page)
+{
+	if (TestSetPageLRU(page))
+		BUG();
+
+	if (PageActive(page))
+		add_page_to_active_list(zone, page);
+	else
+		add_page_to_inactive_list(zone, page);
+}
Index: linux-2.6.14-rc5-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/mm/vmscan.c	2005-10-24 10:27:30.000000000 -0700
+++ linux-2.6.14-rc5-mm1/mm/vmscan.c	2005-10-25 08:09:52.000000000 -0700
@@ -578,43 +578,75 @@ keep:
  *
  * Appropriate locks must be held before calling this function.
  *
+ * @zone:	The zone where lru_lock is held.
  * @nr_to_scan:	The number of pages to look through on the list.
  * @src:	The LRU list to pull pages off.
  * @dst:	The temp list to put pages on to.
- * @scanned:	The number of pages that were scanned.
  *
- * returns how many pages were moved onto *@dst.
+ * returns the number of pages that were scanned.
  */
-static int isolate_lru_pages(int nr_to_scan, struct list_head *src,
-			     struct list_head *dst, int *scanned)
+static int isolate_lru_pages(struct zone *zone, int nr_to_scan,
+			     struct list_head *src, struct list_head *dst)
 {
-	int nr_taken = 0;
 	struct page *page;
-	int scan = 0;
+	int scanned = 0;
+	int rc;
 
-	while (scan++ < nr_to_scan && !list_empty(src)) {
+	while (scanned++ < nr_to_scan && !list_empty(src)) {
 		page = lru_to_page(src);
 		prefetchw_prev_lru_page(page, src, flags);
 
-		if (!TestClearPageLRU(page))
-			BUG();
-		list_del(&page->lru);
-		if (get_page_testone(page)) {
-			/*
-			 * It is being freed elsewhere
-			 */
-			__put_page(page);
-			SetPageLRU(page);
-			list_add(&page->lru, src);
-			continue;
-		} else {
+		rc = __isolate_lru_page(zone, page);
+
+		BUG_ON(rc == 0); /* PageLRU(page) must be true */
+
+		if (rc == 1)     /* Succeeded to isolate page */
 			list_add(&page->lru, dst);
-			nr_taken++;
+
+		if (rc == -1) {  /* Not possible to isolate */
+			list_del(&page->lru);
+			list_add(&page->lru, src);
 		}
 	}
 
-	*scanned = scan;
-	return nr_taken;
+	return scanned;
+}
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
+ * -1 = page is being freed elsewhere.
+ */
+int isolate_lru_page(struct page *page)
+{
+	int rc = 0;
+	struct zone *zone = page_zone(page);
+
+redo:
+	spin_lock_irq(&zone->lru_lock);
+	rc = __isolate_lru_page(zone, page);
+	spin_unlock_irq(&zone->lru_lock);
+	if (rc == 0) {
+		/*
+		 * Maybe this page is still waiting for a cpu to drain it
+		 * from one of the lru lists?
+		 */
+		smp_call_function(&lru_add_drain_per_cpu, NULL, 0 , 1);
+		lru_add_drain();
+		if (PageLRU(page))
+			goto redo;
+	}
+	return rc;
 }
 
 /*
@@ -632,18 +664,15 @@ static void shrink_cache(struct zone *zo
 	spin_lock_irq(&zone->lru_lock);
 	while (max_scan > 0) {
 		struct page *page;
-		int nr_taken;
 		int nr_scan;
 		int nr_freed;
 
-		nr_taken = isolate_lru_pages(sc->swap_cluster_max,
-					     &zone->inactive_list,
-					     &page_list, &nr_scan);
-		zone->nr_inactive -= nr_taken;
+		nr_scan = isolate_lru_pages(zone, sc->swap_cluster_max,
+					    &zone->inactive_list, &page_list);
 		zone->pages_scanned += nr_scan;
 		spin_unlock_irq(&zone->lru_lock);
 
-		if (nr_taken == 0)
+		if (list_empty(&page_list))
 			goto done;
 
 		max_scan -= nr_scan;
@@ -663,13 +692,9 @@ static void shrink_cache(struct zone *zo
 		 */
 		while (!list_empty(&page_list)) {
 			page = lru_to_page(&page_list);
-			if (TestSetPageLRU(page))
-				BUG();
 			list_del(&page->lru);
-			if (PageActive(page))
-				add_page_to_active_list(zone, page);
-			else
-				add_page_to_inactive_list(zone, page);
+			__putback_lru_page(zone, page);
+
 			if (!pagevec_add(&pvec, page)) {
 				spin_unlock_irq(&zone->lru_lock);
 				__pagevec_release(&pvec);
@@ -683,6 +708,33 @@ done:
 }
 
 /*
+ * Add isolated pages on the list back to the LRU
+ * Determines the zone for each pages and takes
+ * the necessary lru lock for each page.
+ *
+ * returns the number of pages put back.
+ */
+int putback_lru_pages(struct list_head *l)
+{
+	struct page * page;
+	struct page * page2;
+	int count = 0;
+
+	list_for_each_entry_safe(page, page2, l, lru) {
+		struct zone *zone = page_zone(page);
+
+		list_del(&page->lru);
+		spin_lock_irq(&zone->lru_lock);
+		__putback_lru_page(zone, page);
+		spin_unlock_irq(&zone->lru_lock);
+		count++;
+		/* Undo the get from isolate_lru_page */
+		put_page(page);
+	}
+	return count;
+}
+
+/*
  * This moves pages from the active list to the inactive list.
  *
  * We move them the other way if the page is referenced by one or more
@@ -718,10 +770,9 @@ refill_inactive_zone(struct zone *zone, 
 
 	lru_add_drain();
 	spin_lock_irq(&zone->lru_lock);
-	pgmoved = isolate_lru_pages(nr_pages, &zone->active_list,
-				    &l_hold, &pgscanned);
+	pgscanned = isolate_lru_pages(zone, nr_pages,
+				      &zone->active_list, &l_hold);
 	zone->pages_scanned += pgscanned;
-	zone->nr_active -= pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
 
 	/*
Index: linux-2.6.14-rc5-mm1/include/linux/swap.h
===================================================================
--- linux-2.6.14-rc5-mm1.orig/include/linux/swap.h	2005-10-24 10:27:13.000000000 -0700
+++ linux-2.6.14-rc5-mm1/include/linux/swap.h	2005-10-25 08:09:52.000000000 -0700
@@ -176,6 +176,9 @@ extern int zone_reclaim(struct zone *, u
 extern int shrink_all_memory(int);
 extern int vm_swappiness;
 
+extern int isolate_lru_page(struct page *p);
+extern int putback_lru_pages(struct list_head *l);
+
 #ifdef CONFIG_MMU
 /* linux/mm/shmem.c */
 extern int shmem_unuse(swp_entry_t entry, struct page *page);
