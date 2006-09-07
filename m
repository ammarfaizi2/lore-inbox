Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWIGTE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWIGTE1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 15:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWIGTE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 15:04:27 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:46560 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1751283AbWIGTEY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 15:04:24 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Mel Gorman <mel@csn.ul.ie>
Message-Id: <20060907190422.6166.49758.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20060907190342.6166.49732.sendpatchset@skynet.skynet.ie>
References: <20060907190342.6166.49732.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 2/8] Split the free lists into kernel and user parts
Date: Thu,  7 Sep 2006 20:04:22 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the core of the anti-fragmentation strategy. It works by
grouping related allocation types together. The idea is that large groups of
pages that may be reclaimed are placed near each other. The zone->free_area
list is broken into RCLM_TYPES number of lists.


Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
---

 include/linux/mmzone.h     |   10 +++
 include/linux/page-flags.h |    7 ++
 mm/page_alloc.c            |  109 +++++++++++++++++++++++++++++++---------
 3 files changed, 102 insertions(+), 24 deletions(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc5-mm1-001_antifrag_flags/include/linux/mmzone.h linux-2.6.18-rc5-mm1-002_fragcore/include/linux/mmzone.h
--- linux-2.6.18-rc5-mm1-001_antifrag_flags/include/linux/mmzone.h	2006-09-04 18:34:33.000000000 +0100
+++ linux-2.6.18-rc5-mm1-002_fragcore/include/linux/mmzone.h	2006-09-04 18:37:59.000000000 +0100
@@ -24,8 +24,16 @@
 #endif
 #define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
 
+#define RCLM_NORCLM 0
+#define RCLM_EASY   1
+#define RCLM_TYPES  2
+
+#define for_each_rclmtype_order(type, order) \
+	for (order = 0; order < MAX_ORDER; order++) \
+		for (type = 0; type < RCLM_TYPES; type++)
+
 struct free_area {
-	struct list_head	free_list;
+	struct list_head	free_list[RCLM_TYPES];
 	unsigned long		nr_free;
 };
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc5-mm1-001_antifrag_flags/include/linux/page-flags.h linux-2.6.18-rc5-mm1-002_fragcore/include/linux/page-flags.h
--- linux-2.6.18-rc5-mm1-001_antifrag_flags/include/linux/page-flags.h	2006-09-04 18:34:33.000000000 +0100
+++ linux-2.6.18-rc5-mm1-002_fragcore/include/linux/page-flags.h	2006-09-04 18:37:59.000000000 +0100
@@ -92,6 +92,7 @@
 #define PG_buddy		19	/* Page is free, on buddy lists */
 
 #define PG_readahead		20	/* Reminder to do readahead */
+#define PG_easyrclm		21	/* Page is an easy reclaim block */
 
 
 #if (BITS_PER_LONG > 32)
@@ -254,6 +255,12 @@
 #define SetPageReadahead(page)	set_bit(PG_readahead, &(page)->flags)
 #define TestClearPageReadahead(page) test_and_clear_bit(PG_readahead, &(page)->flags)
 
+#define PageEasyRclm(page)	test_bit(PG_easyrclm, &(page)->flags)
+#define SetPageEasyRclm(page)	set_bit(PG_easyrclm, &(page)->flags)
+#define ClearPageEasyRclm(page)	clear_bit(PG_easyrclm, &(page)->flags)
+#define __SetPageEasyRclm(page)	__set_bit(PG_easyrclm, &(page)->flags)
+#define __ClearPageEasyRclm(page) __clear_bit(PG_easyrclm, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.18-rc5-mm1-001_antifrag_flags/mm/page_alloc.c linux-2.6.18-rc5-mm1-002_fragcore/mm/page_alloc.c
--- linux-2.6.18-rc5-mm1-001_antifrag_flags/mm/page_alloc.c	2006-09-04 18:34:33.000000000 +0100
+++ linux-2.6.18-rc5-mm1-002_fragcore/mm/page_alloc.c	2006-09-04 18:37:59.000000000 +0100
@@ -133,6 +133,16 @@ static unsigned long __initdata dma_rese
   unsigned long __initdata arch_zone_highest_possible_pfn[MAX_NR_ZONES];
 #endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
 
+static inline int get_pageblock_type(struct page *page)
+{
+	return (PageEasyRclm(page) != 0);
+}
+
+static inline int gfpflags_to_rclmtype(unsigned long gfp_flags)
+{
+	return ((gfp_flags & __GFP_EASYRCLM) != 0);
+}
+
 #ifdef CONFIG_DEBUG_VM
 static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
 {
@@ -402,11 +412,13 @@ static inline void __free_one_page(struc
 {
 	unsigned long page_idx;
 	int order_size = 1 << order;
+	int rclmtype = get_pageblock_type(page);
 
 	if (unlikely(PageCompound(page)))
 		destroy_compound_page(page, order);
 
 	page_idx = page_to_pfn(page) & ((1 << MAX_ORDER) - 1);
+	__SetPageEasyRclm(page);
 
 	VM_BUG_ON(page_idx & (order_size - 1));
 	VM_BUG_ON(bad_range(zone, page));
@@ -414,7 +426,6 @@ static inline void __free_one_page(struc
 	zone->free_pages += order_size;
 	while (order < MAX_ORDER-1) {
 		unsigned long combined_idx;
-		struct free_area *area;
 		struct page *buddy;
 
 		buddy = __page_find_buddy(page, page_idx, order);
@@ -422,8 +433,7 @@ static inline void __free_one_page(struc
 			break;		/* Move the buddy up one level. */
 
 		list_del(&buddy->lru);
-		area = zone->free_area + order;
-		area->nr_free--;
+		zone->free_area[order].nr_free--;
 		rmv_page_order(buddy);
 		combined_idx = __find_combined_index(page_idx, order);
 		page = page + (combined_idx - page_idx);
@@ -431,7 +441,7 @@ static inline void __free_one_page(struc
 		order++;
 	}
 	set_page_order(page, order);
-	list_add(&page->lru, &zone->free_area[order].free_list);
+	list_add(&page->lru, &zone->free_area[order].free_list[rclmtype]);
 	zone->free_area[order].nr_free++;
 }
 
@@ -567,7 +577,8 @@ void fastcall __init __free_pages_bootme
  * -- wli
  */
 static inline void expand(struct zone *zone, struct page *page,
- 	int low, int high, struct free_area *area)
+ 	int low, int high, struct free_area *area,
+	int rclmtype)
 {
 	unsigned long size = 1 << high;
 
@@ -576,7 +587,7 @@ static inline void expand(struct zone *z
 		high--;
 		size >>= 1;
 		VM_BUG_ON(bad_range(zone, &page[size]));
-		list_add(&page[size].lru, &area->free_list);
+		list_add(&page[size].lru, &area->free_list[rclmtype]);
 		area->nr_free++;
 		set_page_order(&page[size], high);
 	}
@@ -627,31 +638,80 @@ static int prep_new_page(struct page *pa
 	return 0;
 }
 
+/* Remove an element from the buddy allocator from the fallback list */
+static struct page *__rmqueue_fallback(struct zone *zone, int order,
+							gfp_t gfp_flags)
+{
+	struct free_area * area;
+	int current_order;
+	struct page *page;
+	int rclmtype = gfpflags_to_rclmtype(gfp_flags);
+
+	/* Find the largest possible block of pages in the other list */
+	rclmtype = !rclmtype;
+	for (current_order = MAX_ORDER-1; current_order >= order;
+						--current_order) {
+		area = &(zone->free_area[current_order]);
+ 		if (list_empty(&area->free_list[rclmtype]))
+ 			continue;
+
+		page = list_entry(area->free_list[rclmtype].next,
+					struct page, lru);
+		area->nr_free--;
+
+		/*
+		 * If breaking a large block of pages, place the buddies
+		 * on the preferred allocation list
+		 */
+		if (unlikely(current_order >= MAX_ORDER / 2))
+			rclmtype = !rclmtype;
+
+		/* Remove the page from the freelists */
+		list_del(&page->lru);
+		rmv_page_order(page);
+		zone->free_pages -= 1UL << order;
+		expand(zone, page, order, current_order, area, rclmtype);
+		return page;
+	}
+
+	return NULL;
+}
+
 /* 
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
  */
-static struct page *__rmqueue(struct zone *zone, unsigned int order)
+static struct page *__rmqueue(struct zone *zone, unsigned int order,
+						gfp_t gfp_flags)
 {
 	struct free_area * area;
 	unsigned int current_order;
 	struct page *page;
+	int rclmtype = gfpflags_to_rclmtype(gfp_flags);
 
+	/* Find a page of the appropriate size in the preferred list */
 	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
-		area = zone->free_area + current_order;
-		if (list_empty(&area->free_list))
+		area = &(zone->free_area[current_order]);
+		if (list_empty(&area->free_list[rclmtype]))
 			continue;
 
-		page = list_entry(area->free_list.next, struct page, lru);
+		page = list_entry(area->free_list[rclmtype].next,
+					struct page, lru);
 		list_del(&page->lru);
 		rmv_page_order(page);
 		area->nr_free--;
 		zone->free_pages -= 1UL << order;
-		expand(zone, page, order, current_order, area);
-		return page;
+		expand(zone, page, order, current_order, area, rclmtype);
+		goto got_page;
 	}
 
-	return NULL;
+	page = __rmqueue_fallback(zone, order, gfp_flags);
+
+got_page:
+	if (unlikely(rclmtype == RCLM_NORCLM) && page)
+		__ClearPageEasyRclm(page);
+
+	return page;
 }
 
 /* 
@@ -660,13 +720,14 @@ static struct page *__rmqueue(struct zon
  * Returns the number of new pages which were placed at *list.
  */
 static int rmqueue_bulk(struct zone *zone, unsigned int order, 
-			unsigned long count, struct list_head *list)
+			unsigned long count, struct list_head *list,
+			gfp_t gfp_flags)
 {
 	int i;
 	
 	spin_lock(&zone->lock);
 	for (i = 0; i < count; ++i) {
-		struct page *page = __rmqueue(zone, order);
+		struct page *page = __rmqueue(zone, order, gfp_flags);
 		if (unlikely(page == NULL))
 			break;
 		list_add_tail(&page->lru, list);
@@ -741,7 +802,7 @@ void mark_free_pages(struct zone *zone)
 {
 	unsigned long pfn, max_zone_pfn;
 	unsigned long flags;
-	int order;
+	int order, t;
 	struct list_head *curr;
 
 	if (!zone->spanned_pages)
@@ -758,14 +819,15 @@ void mark_free_pages(struct zone *zone)
 				ClearPageNosaveFree(page);
 		}
 
-	for (order = MAX_ORDER - 1; order >= 0; --order)
-		list_for_each(curr, &zone->free_area[order].free_list) {
+	for_each_rclmtype_order(t, order) {
+		list_for_each(curr, &zone->free_area[order].free_list[t]) {
 			unsigned long i;
 
 			pfn = page_to_pfn(list_entry(curr, struct page, lru));
 			for (i = 0; i < (1UL << order); i++)
 				SetPageNosaveFree(pfn_to_page(pfn + i));
 		}
+	}
 
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
@@ -864,7 +926,7 @@ again:
 		local_irq_save(flags);
 		if (!pcp->count) {
 			pcp->count += rmqueue_bulk(zone, 0,
-						pcp->batch, &pcp->list);
+				pcp->batch, &pcp->list, gfp_flags);
 			if (unlikely(!pcp->count))
 				goto failed;
 		}
@@ -873,7 +935,7 @@ again:
 		pcp->count--;
 	} else {
 		spin_lock_irqsave(&zone->lock, flags);
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, gfp_flags);
 		spin_unlock(&zone->lock);
 		if (!page)
 			goto failed;
@@ -1782,6 +1844,7 @@ void __meminit memmap_init_zone(unsigned
 		init_page_count(page);
 		reset_page_mapcount(page);
 		SetPageReserved(page);
+		SetPageEasyRclm(page);
 		INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
 		/* The shift won't overflow because ZONE_NORMAL is below 4G. */
@@ -1797,9 +1860,9 @@ void __meminit memmap_init_zone(unsigned
 void zone_init_free_lists(struct pglist_data *pgdat, struct zone *zone,
 				unsigned long size)
 {
-	int order;
-	for (order = 0; order < MAX_ORDER ; order++) {
-		INIT_LIST_HEAD(&zone->free_area[order].free_list);
+	int order, rclmtype;
+	for_each_rclmtype_order(rclmtype, order) {
+		INIT_LIST_HEAD(&zone->free_area[order].free_list[rclmtype]);
 		zone->free_area[order].nr_free = 0;
 	}
 }
