Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269657AbUJGMvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269657AbUJGMvW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 08:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269714AbUJGMtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 08:49:21 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:21639 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269657AbUJGMbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 08:31:22 -0400
Date: Thu, 07 Oct 2004 21:36:52 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [PATCH]  no buddy bitmap patch : alloc/free [1/2]
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>, LHMS <lhms-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Luck, Tony" <tony.luck@intel.com>, Dave Hansen <haveblue@us.ibm.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>
Message-id: <41653864.703@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patches is for mm/page_alloc.c.

Please tell me if you want precise algorithm description.


Kame <kamezawa.horoyu@jp.fujitsu.com>

==== patch for mm/page_alloc.c ====

This patch removes bitmaps from page allocator in mm/page_alloc.c
This buddy system uses page->private field to record free page's order
instead of using bitmaps.
In this buddy system, 2 pages,a page and its "buddy", can be coalesced when

(buddy->private & PG_private) &&
(page_order(page)) == (page_order(buddy)) &&
!PageReserved(buddy) &&
page_count(buddy) == 0

bad_range() is only a sanity check, it will always return 0 in many archs.

But if zone's memmap has a hole, it sometimes return 1.
An architecture with holes in memmap have to define HOLES_IN_ZONE.
For supprt such holes in memmap, pfn_valid() is used when HOLES_IN_ZONE is
defined.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>





---

 test-kernel-kamezawa/mm/page_alloc.c |  155 +++++++++++++++++------------------
 1 files changed, 76 insertions(+), 79 deletions(-)

diff -puN mm/page_alloc.c~eliminate-bitmap-alloc mm/page_alloc.c
--- test-kernel/mm/page_alloc.c~eliminate-bitmap-alloc	2004-10-07 18:13:49.236999744 +0900
+++ test-kernel-kamezawa/mm/page_alloc.c	2004-10-07 19:02:11.368808648 +0900
@@ -67,6 +67,10 @@ static int bad_range(struct zone *zone,
 		return 1;
 	if (page_to_pfn(page) < zone->zone_start_pfn)
 		return 1;
+#ifdef HOLES_IN_ZONE
+	if (!pfn_valid(page_to_pfn(page)))
+		return 1;
+#endif
 	if (zone != page_zone(page))
 		return 1;
 	return 0;
@@ -154,6 +158,44 @@ static void destroy_compound_page(struct
 #endif		/* CONFIG_HUGETLB_PAGE */

 /*
+ * function for dealing with page's order in buddy system
+ */
+static inline unsigned long page_order(struct page *page) {
+	return page->private;
+}
+
+static inline void set_page_order(struct page *page, int order) {
+	page->private = order;
+	__SetPagePrivate(page);
+}
+
+static inline void rmv_page_order(struct page *page)
+{
+	__ClearPagePrivate(page);
+	page->private = 0;
+}
+/*
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
+       if (PagePrivate(page)           &&
+           (page_order(page) == order) &&
+           !PageReserved(page)         &&
+            page_count(page) == 0)
+               return 1;
+       return 0;
+}
+
+/*
  * Freeing function for a buddy system allocator.
  *
  * The concept of a buddy system is to maintain direct-mapped table
@@ -165,9 +207,10 @@ static void destroy_compound_page(struct
  * at the bottom level available, and propagating the changes upward
  * as necessary, plus some accounting needed to play nicely with other
  * parts of the VM system.
- * At each level, we keep one bit for each pair of blocks, which
- * is set to 1 iff only one of the pair is allocated.  So when we
- * are allocating or freeing one, we can derive the state of the
+ * At each level, we keep a list of pages, which are head of continuous
+ * free page of lenght (1 << order) and marked with PG_Private.page's order
+ * is written in page->private field.
+ * So when we are allocating or freeing one, we can derive the state of the
  * other.  That is, if we allocate a small block, and both were
  * free, the remainder of the region must be split into blocks.
  * If a block is freed, and its buddy is also free, then this
@@ -177,42 +220,39 @@ static void destroy_compound_page(struct
  */

 static inline void __free_pages_bulk (struct page *page, struct page *base,
-		struct zone *zone, struct free_area *area, unsigned int order)
+		struct zone *zone, unsigned int order)
 {
-	unsigned long page_idx, index, mask;
+	unsigned long page_idx;
+	struct page *coalesced;
+	int order_size = 1 << order;

 	if (order)
 		destroy_compound_page(page, order);
-	mask = (~0UL) << order;
+
 	page_idx = page - base;
-	if (page_idx & ~mask)
-		BUG();
-	index = page_idx >> (1 + order);

-	zone->free_pages += 1 << order;
-	while (order < MAX_ORDER-1) {
-		struct page *buddy1, *buddy2;
+	BUG_ON(page_idx & (order_size - 1));
+	BUG_ON(bad_range(zone, page));

-		BUG_ON(area >= zone->free_area + MAX_ORDER);
-		if (!__test_and_change_bit(index, area->map))
-			/*
-			 * the buddy page is still allocated.
-			 */
+	zone->free_pages += order_size;
+	while (order < MAX_ORDER-1) {
+		struct page *buddy;
+		int buddy_idx;
+		buddy_idx = (page_idx ^ (1 << order));
+		buddy = base + buddy_idx;
+		if (bad_range(zone, buddy))
+			break;
+		if (!page_is_buddy(buddy, order))
 			break;
-
 		/* Move the buddy up one level. */
-		buddy1 = base + (page_idx ^ (1 << order));
-		buddy2 = base + page_idx;
-		BUG_ON(bad_range(zone, buddy1));
-		BUG_ON(bad_range(zone, buddy2));
-		list_del(&buddy1->lru);
-		mask <<= 1;
+		list_del(&buddy->lru);
+		rmv_page_order(buddy);
+		page_idx &= buddy_idx;
 		order++;
-		area++;
-		index >>= 1;
-		page_idx &= mask;
 	}
-	list_add(&(base + page_idx)->lru, &area->free_list);
+	coalesced = base + page_idx;
+	set_page_order(coalesced, order);
+	list_add(&coalesced->lru, &zone->free_area[order].free_list);
 }

 static inline void free_pages_check(const char *function, struct page *page)
@@ -250,12 +290,10 @@ free_pages_bulk(struct zone *zone, int c
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
@@ -263,7 +301,7 @@ free_pages_bulk(struct zone *zone, int c
 		page = list_entry(list->prev, struct page, lru);
 		/* have to delete it as __free_pages_bulk list manipulates */
 		list_del(&page->lru);
-		__free_pages_bulk(page, base, zone, area, order);
+		__free_pages_bulk(page, base, zone, order);
 		ret++;
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
@@ -285,8 +323,6 @@ void __free_pages_ok(struct page *page,
 	free_pages_bulk(page_zone(page), 1, &list, order);
 }

-#define MARK_USED(index, order, area) \
-	__change_bit((index) >> (1+(order)), (area)->map)

 /*
  * The order of subdivision here is critical for the IO subsystem.
@@ -304,7 +340,7 @@ void __free_pages_ok(struct page *page,
  */
 static inline struct page *
 expand(struct zone *zone, struct page *page,
-	 unsigned long index, int low, int high, struct free_area *area)
+ 	int low, int high, struct free_area *area)
 {
 	unsigned long size = 1 << high;

@@ -314,7 +350,8 @@ expand(struct zone *zone, struct page *p
 		size >>= 1;
 		BUG_ON(bad_range(zone, &page[size]));
 		list_add(&page[size].lru, &area->free_list);
-		MARK_USED(index + size, high, area);
+		/* this is guarded by zone->lock */
+		set_page_order(&page[size], high);
 	}
 	return page;
 }
@@ -368,7 +405,6 @@ static struct page *__rmqueue(struct zon
 	struct free_area * area;
 	unsigned int current_order;
 	struct page *page;
-	unsigned int index;

 	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
 		area = zone->free_area + current_order;
@@ -377,11 +413,10 @@ static struct page *__rmqueue(struct zon

 		page = list_entry(area->free_list.next, struct page, lru);
 		list_del(&page->lru);
-		index = page - zone->zone_mem_map;
-		if (current_order != MAX_ORDER-1)
-			MARK_USED(index, current_order, area);
+		/* this is guarded by zone->lock */
+		rmv_page_order(page);
 		zone->free_pages -= 1UL << order;
-		return expand(zone, page, index, order, current_order, area);
+		return expand(zone, page, order, current_order, area);
 	}

 	return NULL;
@@ -1414,49 +1449,11 @@ void __init memmap_init_zone(unsigned lo
 	}
 }

-/*
- * Page buddy system uses "index >> (i+1)", where "index" is
- * at most "size-1".
- *
- * The extra "+3" is to round down to byte size (8 bits per byte
- * assumption). Thus we get "(size-1) >> (i+4)" as the last byte
- * we can access.
- *
- * The "+1" is because we want to round the byte allocation up
- * rather than down. So we should have had a "+7" before we shifted
- * down by three. Also, we have to add one as we actually _use_ the
- * last bit (it's [0,n] inclusive, not [0,n[).
- *
- * So we actually had +7+1 before we shift down by 3. But
- * (n+8) >> 3 == (n >> 3) + 1 (modulo overflows, which we do not have).
- *
- * Finally, we LONG_ALIGN because all bitmap operations are on longs.
- */
-unsigned long pages_to_bitmap_size(unsigned long order, unsigned long nr_pages)
-{
-	unsigned long bitmap_size;
-
-	bitmap_size = (nr_pages-1) >> (order+4);
-	bitmap_size = LONG_ALIGN(bitmap_size+1);
-
-	return bitmap_size;
-}
-
 void zone_init_free_lists(struct pglist_data *pgdat, struct zone *zone, unsigned long size)
 {
 	int order;
-	for (order = 0; ; order++) {
-		unsigned long bitmap_size;
-
+	for (order = 0; order < MAX_ORDER ; order++) {
 		INIT_LIST_HEAD(&zone->free_area[order].free_list);
-		if (order == MAX_ORDER-1) {
-			zone->free_area[order].map = NULL;
-			break;
-		}
-
-		bitmap_size = pages_to_bitmap_size(order, size);
-		zone->free_area[order].map =
-		  (unsigned long *) alloc_bootmem_node(pgdat, bitmap_size);
 	}
 }


_

