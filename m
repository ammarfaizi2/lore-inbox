Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbVLEUnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbVLEUnq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 15:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbVLEUnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 15:43:46 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:38296 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751407AbVLEUnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 15:43:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=QMoYIrMp5cg42H7V97wqmDYi92UGUxRMf7pgjsSLzZ/bYjEqNFVHFy4PySa8rr8E+vOLowgNm0+zR1cJouMMP26UpFwYLM+Fx3xX7Zs+hG0wQq4lQaADtoh3vYwISU/bv1C4pUo01Sp8z4t8IhRoPIpM+QSs6i3R8UXFOU/7MpI=  ;
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Message-Id: <20051205115921.3480.94122.sendpatchset@didi.local0.net>
In-Reply-To: <20051205115901.3480.60596.sendpatchset@didi.local0.net>
References: <20051205115901.3480.60596.sendpatchset@didi.local0.net>
Subject: [patch 1/4] mm: page refcount use atomic primitives
Date: Mon, 5 Dec 2005 15:43:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The VM has an interesting race where a page refcount can drop to zero, but
it is still on the LRU lists for a short time. This was solved by testing
a 0->1 refcount transition when picking up pages from the LRU, and dropping
the refcount in that case.

Instead, use atomic_inc_not_zero to ensure we never pick up a 0 refcount
page from the LRU (ie. we guarantee the page will not be touched).

This ensures we can test PageLRU without taking the lru_lock, and allows
further optimisations (in later patches).

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -281,49 +281,52 @@ struct page {
  *
  * Also, many kernel routines increase the page count before a critical
  * routine so they can be sure the page doesn't go away from under them.
- *
- * Since 2.6.6 (approx), a free page has ->_count = -1.  This is so that we
- * can use atomic_add_negative(-1, page->_count) to detect when the page
- * becomes free and so that we can also use atomic_inc_and_test to atomically
- * detect when we just tried to grab a ref on a page which some other CPU has
- * already deemed to be freeable.
- *
- * NO code should make assumptions about this internal detail!  Use the provided
- * macros which retain the old rules: page_count(page) == 0 is a free page.
  */
 
 /*
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
+	BUG_ON(atomic_read(&page->_count) == 0);
+	return atomic_dec_and_test(&page->_count);
+}
 
 /*
  * Grab a ref, return true if the page previously had a logical refcount of
  * zero.  ie: returns true if we just grabbed an already-deemed-to-be-free page
  */
-#define get_page_testone(p)	atomic_inc_and_test(&(p)->_count)
+static inline int get_page_unless_zero(struct page *page)
+{
+	return atomic_inc_not_zero(&page->_count);
+}
 
-#define set_page_count(p,v) 	atomic_set(&(p)->_count, v - 1)
-#define __put_page(p)		atomic_dec(&(p)->_count)
+static inline void set_page_count(struct page *page, int v)
+{
+	atomic_set(&page->_count, v);
+}
+
+static inline void __put_page(struct page *page)
+{
+	BUG_ON(atomic_read(&page->_count) == 0);
+	atomic_dec(&page->_count);
+}
 
 extern void FASTCALL(__page_cache_release(struct page *));
 
 static inline int page_count(struct page *page)
 {
-	if (PageCompound(page))
+	if (unlikely(PageCompound(page)))
 		page = (struct page *)page_private(page);
-	return atomic_read(&page->_count) + 1;
+	return atomic_read(&page->_count);
 }
 
 static inline void get_page(struct page *page)
 {
 	if (unlikely(PageCompound(page)))
 		page = (struct page *)page_private(page);
+	BUG_ON(atomic_read(&page->_count) == 0);
 	atomic_inc(&page->_count);
 }
 
Index: linux-2.6/mm/vmscan.c
===================================================================
--- linux-2.6.orig/mm/vmscan.c
+++ linux-2.6/mm/vmscan.c
@@ -599,24 +599,20 @@ static int isolate_lru_pages(int nr_to_s
 	int scan = 0;
 
 	while (scan++ < nr_to_scan && !list_empty(src)) {
+		struct list_head *target;
 		page = lru_to_page(src);
 		prefetchw_prev_lru_page(page, src, flags);
 
-		if (!TestClearPageLRU(page))
-			BUG();
+		BUG_ON(!PageLRU(page));
 		list_del(&page->lru);
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
+		target = src;
+		if (get_page_unless_zero(page)) {
+			ClearPageLRU(page);
+			target = dst;
 			nr_taken++;
-		}
+		} /* else it is being freed elsewhere */
+
+		list_add(&page->lru, target);
 	}
 
 	*scanned = scan;
Index: linux-2.6/mm/swap.c
===================================================================
--- linux-2.6.orig/mm/swap.c
+++ linux-2.6/mm/swap.c
@@ -174,17 +174,19 @@ void lru_add_drain(void)
  */
 void fastcall __page_cache_release(struct page *page)
 {
-	unsigned long flags;
-	struct zone *zone = page_zone(page);
+	if (PageLRU(page)) {
+		unsigned long flags;
 
-	spin_lock_irqsave(&zone->lru_lock, flags);
-	if (TestClearPageLRU(page))
+		struct zone *zone = page_zone(page);
+		spin_lock_irqsave(&zone->lru_lock, flags);
+		if (!TestClearPageLRU(page))
+			BUG();
 		del_page_from_lru(zone, page);
-	if (page_count(page) != 0)
-		page = NULL;
-	spin_unlock_irqrestore(&zone->lru_lock, flags);
-	if (page)
-		free_hot_page(page);
+		spin_unlock_irqrestore(&zone->lru_lock, flags);
+	}
+
+	BUG_ON(page_count(page) != 0);
+	free_hot_page(page);
 }
 
 EXPORT_SYMBOL(__page_cache_release);
@@ -210,27 +212,31 @@ void release_pages(struct page **pages, 
 	pagevec_init(&pages_to_free, cold);
 	for (i = 0; i < nr; i++) {
 		struct page *page = pages[i];
-		struct zone *pagezone;
 
 		if (!put_page_testzero(page))
 			continue;
 
-		pagezone = page_zone(page);
-		if (pagezone != zone) {
-			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
-			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
-		}
-		if (TestClearPageLRU(page))
+		if (PageLRU(page)) {
+			struct zone *pagezone = page_zone(page);
+			if (pagezone != zone) {
+				if (zone)
+					spin_unlock_irq(&zone->lru_lock);
+				zone = pagezone;
+				spin_lock_irq(&zone->lru_lock);
+			}
+			if (!TestClearPageLRU(page))
+				BUG();
 			del_page_from_lru(zone, page);
-		if (page_count(page) == 0) {
-			if (!pagevec_add(&pages_to_free, page)) {
+		}
+		BUG_ON(page_count(page));
+
+		if (!pagevec_add(&pages_to_free, page)) {
+			if (zone) {
 				spin_unlock_irq(&zone->lru_lock);
-				__pagevec_free(&pages_to_free);
-				pagevec_reinit(&pages_to_free);
-				zone = NULL;	/* No lock is held */
+				zone = NULL;
 			}
+			__pagevec_free(&pages_to_free);
+			pagevec_reinit(&pages_to_free);
 		}
 	}
 	if (zone)
Send instant messages to your online friends http://au.messenger.yahoo.com 
