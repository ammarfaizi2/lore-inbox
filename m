Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268816AbUHZMNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268816AbUHZMNk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 08:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268805AbUHZMNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 08:13:13 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:21128 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268883AbUHZMFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 08:05:47 -0400
Date: Thu, 26 Aug 2004 21:10:50 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [RFC] buddy allocator without bitmap [3/4]
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>, LHMS <lhms-devel@lists.sourceforge.net>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>
Message-id: <412DD34A.70802@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This part4 is for freeing pages.

Look of function free_pages_bulk() is different from orignal code,
but algorithm is unchanged.

-- Kame

=====


This patch removes bitmap operation from free_pages()

Instead of using bitmap, this patch records page's order in
page struct itself, page->private field.

As a side effect of removing a bitmap, we must test whether a buddy of a page
is existing or not. This is done by zone->aligned_order and bad_range(page,zone).

zone->aligned_order guarantees "a page of an order below zone->aligned_order has
its buddy in the zone".This is calculated in the zone initialization time.

If order > zone->aligned_order, we must call bad_range(zone, page) and
this is enough when zone doesn't contain memory-hole.

But....
In IA64 case, additionally, there can be memory holes in a zone and size of a hole
is smaller than 1 << MAX_ORDER. So pfn_valid() is inserted.
But pfn_valid() looks a bit heavy in ia64 and replacing this with faster one
is desirable.




example) a series of free_pages()

consider these 8 pages

	page  0  1  2  3  4  5  6   7
	     [A][F][F][-][F][A][A2][-]
         page[0] is allocated , order=0
	page[1] is free,       order=0
	page[2-3] is free,     order=1
	page[4] is free,       order=0
	page[5] is allocated , order=0
	page[6-7] is allocated, order=1

0) status
    free_area[3] ->
    free_area[2] ->
    free_area[1] -> page[2-3]
    free_area[0] -> page[1], page[4]
    allocated    -> page[0], page[5], page[6-7]

1) free_pages (page[6],order=1)
1-1) loop 1st
    free_area[3] ->
    free_area[2] ->
    free_area[1] -> page[2-3], page[6-7]
    free_area[0] -> page[1], page[4]
    allocated    -> page[0], page[5]

    buddy of page 6 in order 1 is page[4].
    page[4] is free,but its order is 0
    stop here.

2) free_pages(page[5], order=0)
2-1) loop 1st
    free_area[3] ->
    free_area[2] ->
    free_area[1] -> page[2-3], page[6-7]
    free_area[0] -> page[1], page[4], page[5]
    allocated    -> page[0]

    buddy of page[5] in order 0 is page[4].
    page[4] is free and its order is 0.
    do coalesce page[4] & page[5].

2-2) loop 2nd
    free_area[3] ->
    free_area[2] ->
    free_area[1] -> page[2-3], page[6-7],page[4-5]
    free_area[0] -> page[1]
    allocated    -> page[0]

    buddy of page[4] in order 1 is page[6]
    page[6] is free and its order is 1
    coalesce page[4-5] and page[6-7]

2-3) loop 3rd
    free_area[3] ->
    free_area[2] -> page[4-7]
    free_area[1] -> page[2-3],
    free_area[0] -> page[1]
    allocated    -> page[0]

    buddy of page[4] in order 2 is page[0]
    page[0] is not free.
    stop here.

3) free_pages(page[0],order=0)
3-1) 1st loop
    free_area[3] ->
    free_area[2] -> page[4-7]
    free_area[1] -> page[2-3],
    free_area[0] -> page[1],page[0] -> coalesce
    allocated    ->

3-2) 2nd loop
    free_area[3] ->
    free_area[2] -> page[4-7]
    free_area[1] -> page[0-1],page[2-3] -> coalesce
    free_area[0] ->
    allocated    ->

3-3) 3rd
    free_area[3] ->
    free_area[2] -> page[4-7] , page[0-3] -> coalesce
    free_area[1] ->
    free_area[0] ->
    allocated    ->

3-4) 4th
    free_area[3] -> page[0-7]
    free_area[2] ->
    free_area[1] ->
    free_area[0] ->
    allocated    ->


---

  linux-2.6.8.1-mm4-kame-kamezawa/mm/page_alloc.c |  100 +++++++++++++++++-------
  1 files changed, 74 insertions(+), 26 deletions(-)

diff -puN mm/page_alloc.c~eliminate-bitmap-free mm/page_alloc.c
--- linux-2.6.8.1-mm4-kame/mm/page_alloc.c~eliminate-bitmap-free	2004-08-26 11:41:46.000000000 +0900
+++ linux-2.6.8.1-mm4-kame-kamezawa/mm/page_alloc.c	2004-08-26 19:30:58.202099448 +0900
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
+	if ((page->flags & (1 << PG_private)) &&
+	    (page_order(page) == order) &&
+	    !(page->flags & (1 << PG_reserved)) &&
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
@@ -180,42 +204,68 @@ static void destroy_compound_page(struct
   */

  static inline void __free_pages_bulk (struct page *page, struct page *base,
-		struct zone *zone, struct free_area *area, unsigned int order)
+		struct zone *zone, unsigned int order)
  {
-	unsigned long page_idx, index, mask;
-
+	unsigned long page_idx, mask;
+	struct page *coalesced_page;
+	
  	if (order)
  		destroy_compound_page(page, order);
+
  	mask = (~0UL) << order;
  	page_idx = page - base;
  	if (page_idx & ~mask)
  		BUG();
-	index = page_idx >> (1 + order);
-
  	zone->free_pages += 1 << order;
+	BUG_ON(bad_range(zone,page));
+
  	while (order < MAX_ORDER-1) {
-		struct page *buddy1, *buddy2;
+		struct page *buddy;
+		
+		buddy = base + (page_idx ^ (1 << order));

-		BUG_ON(area >= zone->free_area + MAX_ORDER);
-		if (!__test_and_change_bit(index, area->map))
+		/*
+		 * quick check, if order < zone->aligned_order
+		 * every page has its buddy in this order.
+		 * buddy is guaranteed to be valid page.
+		 */
+		if (order >= zone->aligned_order) {
+			if (zone->nr_mem_map > 1) {
+				/*
+				 * there may be hole in zone's memmap &&
+				 * hole is not aligned in this order.
+				 * currently, I think CONFIG_VIRTUAL_MEM_MAP
+				 * case is only case to reach here.
+				 * Is there any other case ?
+				 */
+				/*
+				 * Is there better call than pfn_valid ?
+				 */
+				if (!pfn_valid(zone->zone_start_pfn
+					       + (page_idx ^ (1 << order))))
+					break;
+			}
+			/* we need range check */
+			if (bad_range(zone, buddy))
+				break;
+		}
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
+		mask <<= 1;
  		page_idx &= mask;
-	}
-	list_add(&(base + page_idx)->lru, &area->free_list);
+		list_del(&buddy->lru);
+		/* for propriety of PG_private bit, we clear it */
+		buddy->flags &= ~(1 << PG_private);
+	}
+	/* record the final order of the page */
+	coalesced_page = base + page_idx;
+	coalesced_page->flags |= (1 << PG_private);
+	coalesced_page->private = order;
+	list_add(&coalesced_page->lru, &zone->free_area[order].free_list);
  }

  static inline void free_pages_check(const char *function, struct page *page)
@@ -253,12 +303,10 @@ free_pages_bulk(struct zone *zone, int c
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
@@ -266,7 +314,7 @@ free_pages_bulk(struct zone *zone, int c
  		page = list_entry(list->prev, struct page, lru);
  		/* have to delete it as __free_pages_bulk list manipulates */
  		list_del(&page->lru);
-		__free_pages_bulk(page, base, zone, area, order);
+		__free_pages_bulk(page, base, zone, order);
  		ret++;
  	}
  	spin_unlock_irqrestore(&zone->lock, flags);

_

