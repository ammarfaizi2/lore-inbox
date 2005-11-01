Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbVKADNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbVKADNK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 22:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVKADNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 22:13:09 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:13488 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964949AbVKADNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 22:13:08 -0500
Date: Mon, 31 Oct 2005 19:12:44 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: torvalds@osdl.org
Cc: akpm@osdl.org, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mike Kravetz <kravetz@us.ibm.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>,
       Lee Schermerhorn <lee.schermerhorn@hp.com>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>,
       Magnus Damm <magnus.damm@gmail.com>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20051101031244.12488.38211.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 1/5] Swap Migration V5: LRU operations
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

Changes V4-V5:
- Use the caches to return inactive and active pages instead
  of __putback_lru. Remove putback_lru macro
- Add move_to_lru function

Changes V3-V4:

- Remove obsolete second parameter from isolate_lru_page
- Mention the original authors

Signed-off-by: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-rc5-mm1/include/linux/mm_inline.h
===================================================================
--- linux-2.6.14-rc5-mm1.orig/include/linux/mm_inline.h	2005-10-19 23:23:05.000000000 -0700
+++ linux-2.6.14-rc5-mm1/include/linux/mm_inline.h	2005-10-31 13:22:12.000000000 -0800
@@ -38,3 +38,32 @@ del_page_from_lru(struct zone *zone, str
 		zone->nr_inactive--;
 	}
 }
+
+/*
+ * Isolate one page from the LRU lists.
+ *
+ * - zone->lru_lock must be held
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
+			return -ENOENT;
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
Index: linux-2.6.14-rc5-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/mm/vmscan.c	2005-10-24 10:27:30.000000000 -0700
+++ linux-2.6.14-rc5-mm1/mm/vmscan.c	2005-10-31 13:21:57.000000000 -0800
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
+		switch (__isolate_lru_page(zone, page)) {
+		case 1:
+			/* Succeeded to isolate page */
 			list_add(&page->lru, dst);
-			nr_taken++;
+			break;
+		case -1:
+			/* Not possible to isolate */
+			list_move(&page->lru, src);
+			break;
+		default:
+			BUG();
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
@@ -682,6 +711,39 @@ done:
 	pagevec_release(&pvec);
 }
 
+static inline void move_to_lru(struct *page)
+{
+	list_del(&page->lru);
+	if (PageActive(page)) {
+		/*
+		 * lru_cache_add_active checks that
+		 * the PG_active bit is off.
+		 */
+		ClearPageActive(page);
+		lru_cache_add_activE(page);
+	} else {
+		lru_cache_add(page);
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
+	struct page * page;
+	struct page * page2;
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
  * This moves pages from the active list to the inactive list.
  *
@@ -718,10 +780,9 @@ refill_inactive_zone(struct zone *zone, 
 
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
+++ linux-2.6.14-rc5-mm1/include/linux/swap.h	2005-10-31 13:21:57.000000000 -0800
@@ -176,6 +176,9 @@ extern int zone_reclaim(struct zone *, u
 extern int shrink_all_memory(int);
 extern int vm_swappiness;
 
+extern int isolate_lru_page(struct page *p);
+extern int putback_lru_pages(struct list_head *l);
+
 #ifdef CONFIG_MMU
 /* linux/mm/shmem.c */
 extern int shmem_unuse(swp_entry_t entry, struct page *page);
