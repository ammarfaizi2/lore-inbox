Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVL3WmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVL3WmB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVL3Wlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:41:42 -0500
Received: from amsfep11-int.chello.nl ([213.46.243.19]:63526 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S932165AbVL3Wl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:41:26 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051230224102.765.75148.sendpatchset@twins.localnet>
In-Reply-To: <20051230223952.765.21096.sendpatchset@twins.localnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
Subject: [PATCH 07/14] page-replace-move-isolate_lru_pages.patch
Date: Fri, 30 Dec 2005 23:41:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Manipulation of the page lists is done exclusivly in page_replace.c.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

--- linux-2.6-git.orig/include/linux/mm_page_replace.h	2005-12-10 23:41:17.000000000 +0100
+++ linux-2.6-git/include/linux/mm_page_replace.h	2005-12-11 11:27:39.000000000 +0100
@@ -43,4 +43,6 @@
 }
 
+int isolate_lru_pages(int, struct list_head *, struct list_head *, int *);
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_PAGE_REPLACE_H */
--- linux-2.6-git.orig/mm/page_replace.c	2005-12-10 23:41:17.000000000 +0100
+++ linux-2.6-git/mm/page_replace.c	2005-12-11 11:27:39.000000000 +0100
@@ -9,3 +9,52 @@ void __page_replace_insert(struct zone *
 	else
 		add_page_to_inactive_list(zone, page);
 }
+
+/*
+ * zone->lru_lock is heavily contended.  Some of the functions that
+ * shrink the lists perform better by taking out a batch of pages
+ * and working on them outside the LRU lock.
+ *
+ * For pagecache intensive workloads, this function is the hottest
+ * spot in the kernel (apart from copy_*_user functions).
+ *
+ * Appropriate locks must be held before calling this function.
+ *
+ * @nr_to_scan:	The number of pages to look through on the list.
+ * @src:	The LRU list to pull pages off.
+ * @dst:	The temp list to put pages on to.
+ * @scanned:	The number of pages that were scanned.
+ *
+ * returns how many pages were moved onto *@dst.
+ */
+int isolate_lru_pages(int nr_to_scan, struct list_head *src,
+		      struct list_head *dst, int *scanned)
+{
+	int nr_taken = 0;
+	struct page *page;
+	int scan = 0;
+
+	while (scan++ < nr_to_scan && !list_empty(src)) {
+		page = lru_to_page(src);
+		prefetchw_prev_lru_page(page, src, flags);
+
+		if (!TestClearPageLRU(page))
+			BUG();
+		list_del(&page->lru);
+		if (get_page_testone(page)) {
+			/*
+			 * It is being freed elsewhere
+			 */
+			__put_page(page);
+			SetPageLRU(page);
+			list_add(&page->lru, src);
+			continue;
+		} else {
+			list_add(&page->lru, dst);
+			nr_taken++;
+		}
+	}
+
+	*scanned = scan;
+	return nr_taken;
+}
--- linux-2.6-git.orig/mm/vmscan.c	2005-12-10 23:41:17.000000000 +0100
+++ linux-2.6-git/mm/vmscan.c	2005-12-11 11:27:39.000000000 +0100
@@ -568,55 +568,6 @@
 }
 
 /*
- * zone->lru_lock is heavily contended.  Some of the functions that
- * shrink the lists perform better by taking out a batch of pages
- * and working on them outside the LRU lock.
- *
- * For pagecache intensive workloads, this function is the hottest
- * spot in the kernel (apart from copy_*_user functions).
- *
- * Appropriate locks must be held before calling this function.
- *
- * @nr_to_scan:	The number of pages to look through on the list.
- * @src:	The LRU list to pull pages off.
- * @dst:	The temp list to put pages on to.
- * @scanned:	The number of pages that were scanned.
- *
- * returns how many pages were moved onto *@dst.
- */
-static int isolate_lru_pages(int nr_to_scan, struct list_head *src,
-			     struct list_head *dst, int *scanned)
-{
-	int nr_taken = 0;
-	struct page *page;
-	int scan = 0;
-
-	while (scan++ < nr_to_scan && !list_empty(src)) {
-		page = lru_to_page(src);
-		prefetchw_prev_lru_page(page, src, flags);
-
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
-			list_add(&page->lru, dst);
-			nr_taken++;
-		}
-	}
-
-	*scanned = scan;
-	return nr_taken;
-}
-
-/*
  * shrink_cache() adds the number of pages reclaimed to sc->nr_reclaimed
  */
 static void shrink_cache(struct zone *zone, struct scan_control *sc)
