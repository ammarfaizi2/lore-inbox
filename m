Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267831AbUIBIHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267831AbUIBIHg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 04:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267828AbUIBIHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 04:07:36 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:29846 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267866AbUIBIGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 04:06:21 -0400
Date: Thu, 02 Sep 2004 17:11:30 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [RFC] buddy allocator without bitmap(3) [3/3]
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>, LHMS <lhms-devel@lists.sourceforge.net>
Message-id: <4136D5B2.1070908@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the last part.
There is no big change from the previous version.

--Kame
===

This is 4th.
This patch removes bitmap operation from free_pages().

In main lopp of __free_pages_bulk(), we access a "buddy" page.
It is guaranteed that there is no invalid "buddy" in the buddy system, because
all dangerous pages which has possibility to be coalesced with
out-of-range pages are removed in advance by calculate_aligned_end().



---

 test-kernel-kamezawa/mm/page_alloc.c |   81 ++++++++++++++++++++++-------------
 1 files changed, 51 insertions(+), 30 deletions(-)

diff -puN mm/page_alloc.c~eliminate-bitmap-free mm/page_alloc.c
--- test-kernel/mm/page_alloc.c~eliminate-bitmap-free	2004-09-02 17:03:32.648373272 +0900
+++ test-kernel-kamezawa/mm/page_alloc.c	2004-09-02 17:03:32.653372512 +0900
@@ -157,6 +157,27 @@ static void destroy_compound_page(struct
 #endif		/* CONFIG_HUGETLB_PAGE */

 /*
+ * This function checks whether a page is free && is the buddy
+ * we can do coalesce if
+ * (a) the buddy is free and
+ * (b) the buddy is on the buddy system
+ * (c) the buddy has the same order.
+ * for recording page's order, we use private field and PG_private.
+ *
+ * Because page_count(page) == 0, and zone->lock is aquired.
+ * Atomic page->flags operation is needless here.
+ */
+static inline int page_is_buddy(struct page *page, int order)
+{
+	if (PagePrivate(page)           &&
+	    (page_order(page) == order) &&
+	    !PageReserved(page)         &&
+            page_count(page) == 0)
+		return 1;
+	return 0;
+}
+
+/*
  * Freeing function for a buddy system allocator.
  *
  * The concept of a buddy system is to maintain direct-mapped table
@@ -168,9 +189,12 @@ static void destroy_compound_page(struct
  * at the bottom level available, and propagating the changes upward
  * as necessary, plus some accounting needed to play nicely with other
  * parts of the VM system.
- * At each level, we keep one bit for each pair of blocks, which
- * is set to 1 iff only one of the pair is allocated.  So when we
- * are allocating or freeing one, we can derive the state of the
+ *
+ * At each level, we keep a list of pages, which are head of chunk of
+ * pages at the level. A page, which is a head of chunks, has its order
+ * in page structure itself and PG_private flag is set. we can get an
+ * order of a page by calling  page_order().
+ * So we are allocating or freeing one, we can derive the state of the
  * other.  That is, if we allocate a small block, and both were
  * free, the remainder of the region must be split into blocks.
  * If a block is freed, and its buddy is also free, then this
@@ -180,42 +204,41 @@ static void destroy_compound_page(struct
  */

 static inline void __free_pages_bulk (struct page *page, struct page *base,
-		struct zone *zone, struct free_area *area, unsigned int order)
+		struct zone *zone, unsigned int order)
 {
-	unsigned long page_idx, index, mask;
-
+	unsigned long page_idx;
+	struct page *coalesced_page;
+	int order_len = 1 << order;
 	if (order)
 		destroy_compound_page(page, order);
-	mask = (~0UL) << order;
+
 	page_idx = page - base;
-	if (page_idx & ~mask)
+	if (page_idx & (order_len - 1))
 		BUG();
-	index = page_idx >> (1 + order);
+	zone->free_pages += order_len;
+	BUG_ON(bad_range(zone,page));

-	zone->free_pages += 1 << order;
 	while (order < MAX_ORDER-1) {
-		struct page *buddy1, *buddy2;
-
-		BUG_ON(area >= zone->free_area + MAX_ORDER);
-		if (!__test_and_change_bit(index, area->map))
+		struct page *buddy;
+		int buddy_idx;
+		buddy_idx = (page_idx ^ (1 << order));
+		buddy = base + buddy_idx;
+		if (!page_is_buddy(buddy, order))
 			/*
 			 * the buddy page is still allocated.
 			 */
 			break;
-
-		/* Move the buddy up one level. */
-		buddy1 = base + (page_idx ^ (1 << order));
-		buddy2 = base + page_idx;
-		BUG_ON(bad_range(zone, buddy1));
-		BUG_ON(bad_range(zone, buddy2));
-		list_del(&buddy1->lru);
-		mask <<= 1;
 		order++;
-		area++;
-		index >>= 1;
-		page_idx &= mask;
-	}
-	list_add(&(base + page_idx)->lru, &area->free_list);
+		page_idx &= buddy_idx;
+		list_del(&buddy->lru);
+		/* for propriety of PG_private bit, we clear it */
+		ClearPagePrivate(buddy);
+	}
+	/* record the final order of the page */
+	coalesced_page = base + page_idx;
+	SetPagePrivate(coalesced_page);
+	set_page_order(coalesced_page,order);
+	list_add(&coalesced_page->lru, &zone->free_area[order].free_list);
 }

 static inline void free_pages_check(const char *function, struct page *page)
@@ -253,12 +276,10 @@ free_pages_bulk(struct zone *zone, int c
 		struct list_head *list, unsigned int order)
 {
 	unsigned long flags;
-	struct free_area *area;
 	struct page *base, *page = NULL;
 	int ret = 0;

 	base = zone->zone_mem_map;
-	area = zone->free_area + order;
 	spin_lock_irqsave(&zone->lock, flags);
 	zone->all_unreclaimable = 0;
 	zone->pages_scanned = 0;
@@ -266,7 +287,7 @@ free_pages_bulk(struct zone *zone, int c
 		page = list_entry(list->prev, struct page, lru);
 		/* have to delete it as __free_pages_bulk list manipulates */
 		list_del(&page->lru);
-		__free_pages_bulk(page, base, zone, area, order);
+		__free_pages_bulk(page, base, zone, order);
 		ret++;
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);

_

