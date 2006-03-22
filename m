Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWCVWom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWCVWom (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932871AbWCVWoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:44:24 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:60601 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S932854AbWCVWdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:33:12 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223238.12658.35814.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 09/34] mm: page-replace-move-isolate_lru_pages.patch
Date: Wed, 22 Mar 2006 23:33:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

In anticipation that only the policy implementation will know anything about
the management of the pages, move isolate_lru_pages over to the policy
implementation.

API:
	int page_replace_isolate(struct page*)

isolate a single page from the cache mgmt structures - used by page migration.
NOTE: this function leaves the reclaim page state untouched so that it can be 
reinserted in the dest. zone at the correct place.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/mm_page_replace.h    |    6 ++
 include/linux/mm_use_once_policy.h |    3 +
 include/linux/swap.h               |    2 
 mm/mempolicy.c                     |    2 
 mm/useonce.c                       |   81 +++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                        |   79 ------------------------------------
 6 files changed, 92 insertions(+), 81 deletions(-)

Index: linux-2.6-git/mm/mempolicy.c
===================================================================
--- linux-2.6-git.orig/mm/mempolicy.c
+++ linux-2.6-git/mm/mempolicy.c
@@ -552,7 +552,7 @@ static void migrate_page_add(struct page
 	 * Avoid migrating a page that is shared with others.
 	 */
 	if ((flags & MPOL_MF_MOVE_ALL) || page_mapcount(page) == 1) {
-		if (isolate_lru_page(page))
+		if (page_replace_isolate(page))
 			list_add_tail(&page->lru, pagelist);
 	}
 }
Index: linux-2.6-git/mm/useonce.c
===================================================================
--- linux-2.6-git.orig/mm/useonce.c
+++ linux-2.6-git/mm/useonce.c
@@ -75,3 +75,84 @@ int page_replace_add_drain_all(void)
 	return 0;
 }
 #endif
+
+#ifdef CONFIG_MIGRATION
+/*
+ * Isolate one page from the LRU lists and put it on the
+ * indicated list with elevated refcount.
+ *
+ * Result:
+ *  0 = page not on LRU list
+ *  1 = page removed from LRU list and added to the specified list.
+ */
+int page_replace_isolate(struct page *page)
+{
+	int ret = 0;
+
+	if (PageLRU(page)) {
+		struct zone *zone = page_zone(page);
+		spin_lock_irq(&zone->lru_lock);
+		if (TestClearPageLRU(page)) {
+			ret = 1;
+			get_page(page);
+			if (PageActive(page))
+				del_page_from_active_list(zone, page);
+			else
+				del_page_from_inactive_list(zone, page);
+		}
+		spin_unlock_irq(&zone->lru_lock);
+	}
+
+	return ret;
+}
+#endif
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
+
Index: linux-2.6-git/mm/vmscan.c
===================================================================
--- linux-2.6-git.orig/mm/vmscan.c
+++ linux-2.6-git/mm/vmscan.c
@@ -509,6 +509,7 @@ keep:
 }
 
 #ifdef CONFIG_MIGRATION
+
 static inline void move_to_lru(struct page *page)
 {
 	list_del(&page->lru);
@@ -936,87 +937,9 @@ next:
 
 	return nr_failed + retry;
 }
-
-/*
- * Isolate one page from the LRU lists and put it on the
- * indicated list with elevated refcount.
- *
- * Result:
- *  0 = page not on LRU list
- *  1 = page removed from LRU list and added to the specified list.
- */
-int isolate_lru_page(struct page *page)
-{
-	int ret = 0;
-
-	if (PageLRU(page)) {
-		struct zone *zone = page_zone(page);
-		spin_lock_irq(&zone->lru_lock);
-		if (TestClearPageLRU(page)) {
-			ret = 1;
-			get_page(page);
-			if (PageActive(page))
-				del_page_from_active_list(zone, page);
-			else
-				del_page_from_inactive_list(zone, page);
-		}
-		spin_unlock_irq(&zone->lru_lock);
-	}
-
-	return ret;
-}
 #endif
 
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
Index: linux-2.6-git/include/linux/mm_use_once_policy.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_use_once_policy.h
+++ linux-2.6-git/include/linux/mm_use_once_policy.h
@@ -76,5 +76,8 @@ static inline int page_replace_activate(
 	return 1;
 }
 
+extern int isolate_lru_pages(int nr_to_scan, struct list_head *src,
+			     struct list_head *dst, int *scanned);
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_USEONCE_POLICY_H */
Index: linux-2.6-git/include/linux/mm_page_replace.h
===================================================================
--- linux-2.6-git.orig/include/linux/mm_page_replace.h
+++ linux-2.6-git/include/linux/mm_page_replace.h
@@ -88,6 +88,12 @@ typedef enum {
 /* int page_replace_activate(struct page *page); */
 
 
+#ifdef CONFIG_MIGRATION
+extern int page_replace_isolate(struct page *p);
+#else
+static inline int page_replace_isolate(struct page *p) { return -ENOSYS; }
+#endif
+
 #ifdef CONFIG_MM_POLICY_USEONCE
 #include <linux/mm_use_once_policy.h>
 #else
Index: linux-2.6-git/include/linux/swap.h
===================================================================
--- linux-2.6-git.orig/include/linux/swap.h
+++ linux-2.6-git/include/linux/swap.h
@@ -186,7 +186,6 @@ static inline int zone_reclaim(struct zo
 #endif
 
 #ifdef CONFIG_MIGRATION
-extern int isolate_lru_page(struct page *p);
 extern int putback_lru_pages(struct list_head *l);
 extern int migrate_page(struct page *, struct page *);
 extern void migrate_page_copy(struct page *, struct page *);
@@ -195,7 +194,6 @@ extern int migrate_pages(struct list_hea
 		struct list_head *moved, struct list_head *failed);
 extern int fail_migrate_page(struct page *, struct page *);
 #else
-static inline int isolate_lru_page(struct page *p) { return -ENOSYS; }
 static inline int putback_lru_pages(struct list_head *l) { return 0; }
 static inline int migrate_pages(struct list_head *l, struct list_head *t,
 	struct list_head *moved, struct list_head *failed) { return -ENOSYS; }
