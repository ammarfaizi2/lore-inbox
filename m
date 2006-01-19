Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161368AbWASTzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161368AbWASTzL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161373AbWASTzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:55:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:12248 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161368AbWASTzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:55:10 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <20060119195355.14171.14613.sendpatchset@linux.site>
Subject: [resend][patch 5/6] mm: simplify vmscan vs release refcounting
Date: Thu, 19 Jan 2006 20:55:05 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The VM has an interesting race where a page refcount can drop to zero, but
it is still on the LRU lists for a short time. This was solved by testing
a 0->1 refcount transition when picking up pages from the LRU, and dropping
the refcount in that case.

Instead, use atomic_add_unless to ensure we never pick up a 0 refcount page
from the LRU, thus a 0 refcount page will never have its refcount elevated
until it is allocated again.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -301,17 +301,20 @@ struct page {
  * Drop a ref, return true if the logical refcount fell to zero (the page has
  * no users)
  */
-#define put_page_testzero(p)				\
-	({						\
-		BUG_ON(page_count(p) == 0);		\
-		atomic_add_negative(-1, &(p)->_count);	\
-	})
+static inline int put_page_testzero(struct page *page)
+{
+	BUG_ON(atomic_read(&page->_count) == -1);
+	return atomic_add_negative(-1, &page->_count);
+}
 
 /*
- * Grab a ref, return true if the page previously had a logical refcount of
- * zero.  ie: returns true if we just grabbed an already-deemed-to-be-free page
+ * Try to grab a ref unless the page has a refcount of zero, return false if
+ * that is the case.
  */
-#define get_page_testone(p)	atomic_inc_and_test(&(p)->_count)
+static inline int get_page_unless_zero(struct page *page)
+{
+	return atomic_add_unless(&page->_count, 1, -1);
+}
 
 #define set_page_count(p,v) 	atomic_set(&(p)->_count, (v) - 1)
 #define __put_page(p)		atomic_dec(&(p)->_count)
Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -821,29 +821,26 @@ static int isolate_lru_pages(int nr_to_s
 	int scan = 0;
 
 	while (scan++ < nr_to_scan && !list_empty(src)) {
+		struct list_head *target;
 		page = lru_to_page(src);
 		prefetchw_prev_lru_page(page, src, flags);
 
 		BUG_ON(!PageLRU(page));
 
 		list_del(&page->lru);
-		if (unlikely(get_page_testone(page))) {
+		target = src;
+		if (likely(get_page_unless_zero(page))) {
 			/*
-			 * It is being freed elsewhere
+			 * Be careful not to clear PageLRU until after we're
+			 * sure the page is not being freed elsewhere -- the
+			 * page release code relies on it.
 			 */
-			__put_page(page);
-			list_add(&page->lru, src);
-			continue;
-		}
+			ClearPageLRU(page);
+			target = dst;
+			nr_taken++;
+		} /* else it is being freed elsewhere */
 
-		/*
-		 * Be careful not to clear PageLRU until after we're sure
-		 * the page is not being freed elsewhere -- the page release
-		 * code relies on it.
-		 */
-		ClearPageLRU(page);
-		list_add(&page->lru, dst);
-		nr_taken++;
+		list_add(&page->lru, target);
 	}
 
 	*scanned = scan;
