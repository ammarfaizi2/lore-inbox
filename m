Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269130AbUIHLxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269130AbUIHLxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 07:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269137AbUIHLxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 07:53:01 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:7883 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269130AbUIHLug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 07:50:36 -0400
Date: Wed, 08 Sep 2004 20:55:49 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [RFC][PATCH] no bitmap buddy allocator : modifies __free_pages_bulk()
 (3/4)
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>, LHMS <lhms-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>
Message-id: <413EF345.3080004@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part (3/4) and modifies __free_pages_bulk().

In main lopp of __free_pages_bulk(), we access a "buddy" page.
validity of this "buddy" page is guaranteed by bad_range_pfn() and
calculate_buddy_range() in (1/4). Out of range access cannot occur.


Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


---

  test-kernel-kamezawa/mm/page_alloc.c |   85 ++++++++++++++++++++++-------------
  1 files changed, 54 insertions(+), 31 deletions(-)

diff -puN mm/page_alloc.c~eliminate-bitmap-free mm/page_alloc.c
--- test-kernel/mm/page_alloc.c~eliminate-bitmap-free	2004-09-08 18:48:42.145069984 +0900
+++ test-kernel-kamezawa/mm/page_alloc.c	2004-09-08 19:04:04.479853784 +0900
@@ -165,6 +165,27 @@ static void destroy_compound_page(struct
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
@@ -176,9 +197,12 @@ static void destroy_compound_page(struct
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
@@ -188,42 +212,43 @@ static void destroy_compound_page(struct
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
-		BUG();
-	index = page_idx >> (1 + order);
+	BUG_ON(page_idx & (order_len - 1));
+	BUG_ON(bad_range(zone,page));

-	zone->free_pages += 1 << order;
-	while (order < MAX_ORDER-1) {
-		struct page *buddy1, *buddy2;
+	zone->free_pages += order_len;

-		BUG_ON(area >= zone->free_area + MAX_ORDER);
-		if (!__test_and_change_bit(index, area->map))
+	while (order < MAX_ORDER-1) {
+		struct page *buddy;
+		int buddy_idx;
+		buddy_idx = (page_idx ^ (1 << order));
+		if (bad_range_pfn(zone, zone->zone_start_pfn + buddy_idx))
+			break;
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
@@ -261,12 +286,10 @@ free_pages_bulk(struct zone *zone, int c
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
@@ -274,7 +297,7 @@ free_pages_bulk(struct zone *zone, int c
  		page = list_entry(list->prev, struct page, lru);
  		/* have to delete it as __free_pages_bulk list manipulates */
  		list_del(&page->lru);
-		__free_pages_bulk(page, base, zone, area, order);
+		__free_pages_bulk(page, base, zone, order);
  		ret++;
  	}
  	spin_unlock_irqrestore(&zone->lock, flags);

_

