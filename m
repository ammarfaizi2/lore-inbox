Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVJ3SfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVJ3SfG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 13:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVJ3Sek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 13:34:40 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:43947 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932207AbVJ3SeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 13:34:11 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: linux-mm@kvack.org, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>
Message-Id: <20051030183409.22266.50049.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie>
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 3/7] Fragmentation Avoidance V19: 003_fragcore
Date: Sun, 30 Oct 2005 18:34:10 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the core of the anti-fragmentation strategy. It works by
grouping related allocation types together. The idea is that large groups of
pages that may be reclaimed are placed near each other. The zone->free_area
list is broken into three free lists for each RCLM_TYPE.

This section of the patch looks superflous but it is to surpress a compiler
warning. Suggestions to make this better looking are welcome.

-       struct free_area * area;
+       struct free_area * area = NULL;

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-002_usemap/include/linux/mmzone.h linux-2.6.14-rc5-mm1-003_fragcore/include/linux/mmzone.h
--- linux-2.6.14-rc5-mm1-002_usemap/include/linux/mmzone.h	2005-10-30 13:35:31.000000000 +0000
+++ linux-2.6.14-rc5-mm1-003_fragcore/include/linux/mmzone.h	2005-10-30 13:36:16.000000000 +0000
@@ -33,6 +33,10 @@
 #define RCLM_TYPES    3
 #define BITS_PER_RCLM_TYPE 2
 
+#define for_each_rclmtype_order(type, order) \
+	for (order = 0; order < MAX_ORDER; order++) \
+		for (type = 0; type < RCLM_TYPES; type++)
+
 struct free_area {
 	struct list_head	free_list;
 	unsigned long		nr_free;
@@ -155,7 +159,6 @@ struct zone {
 	/* see spanned/present_pages for more description */
 	seqlock_t		span_seqlock;
 #endif
-	struct free_area	free_area[MAX_ORDER];
 
 #ifndef CONFIG_SPARSEMEM
 	/*
@@ -165,6 +168,8 @@ struct zone {
 	unsigned long		*free_area_usemap;
 #endif
 
+	struct free_area	free_area_lists[RCLM_TYPES][MAX_ORDER];
+
 	ZONE_PADDING(_pad1_)
 
 	/* Fields commonly accessed by the page reclaim scanner */
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-002_usemap/mm/page_alloc.c linux-2.6.14-rc5-mm1-003_fragcore/mm/page_alloc.c
--- linux-2.6.14-rc5-mm1-002_usemap/mm/page_alloc.c	2005-10-30 13:35:31.000000000 +0000
+++ linux-2.6.14-rc5-mm1-003_fragcore/mm/page_alloc.c	2005-10-30 13:36:16.000000000 +0000
@@ -352,6 +352,15 @@ __find_combined_index(unsigned long page
 }
 
 /*
+ * Return the free list for a given page within a zone
+ */
+static inline struct free_area *__page_find_freelist(struct zone *zone,
+							struct page *page)
+{
+	return zone->free_area_lists[get_pageblock_type(zone, page)];
+}
+
+/*
  * This function checks whether a page is free && is the buddy
  * we can do coalesce a page and its buddy if
  * (a) the buddy is free &&
@@ -398,6 +407,8 @@ static inline void __free_pages_bulk (st
 {
 	unsigned long page_idx;
 	int order_size = 1 << order;
+	struct free_area *area;
+	struct free_area *freelist;
 
 	if (unlikely(order))
 		destroy_compound_page(page, order);
@@ -407,10 +418,11 @@ static inline void __free_pages_bulk (st
 	BUG_ON(page_idx & (order_size - 1));
 	BUG_ON(bad_range(zone, page));
 
+	freelist = __page_find_freelist(zone, page);
+
 	zone->free_pages += order_size;
 	while (order < MAX_ORDER-1) {
 		unsigned long combined_idx;
-		struct free_area *area;
 		struct page *buddy;
 
 		combined_idx = __find_combined_index(page_idx, order);
@@ -421,7 +433,7 @@ static inline void __free_pages_bulk (st
 		if (!page_is_buddy(buddy, order))
 			break;		/* Move the buddy up one level. */
 		list_del(&buddy->lru);
-		area = zone->free_area + order;
+		area = &freelist[order];
 		area->nr_free--;
 		rmv_page_order(buddy);
 		page = page + (combined_idx - page_idx);
@@ -429,8 +441,8 @@ static inline void __free_pages_bulk (st
 		order++;
 	}
 	set_page_order(page, order);
-	list_add(&page->lru, &zone->free_area[order].free_list);
-	zone->free_area[order].nr_free++;
+	list_add_tail(&page->lru, &freelist[order].free_list);
+	freelist[order].nr_free++;
 }
 
 static inline void free_pages_check(const char *function, struct page *page)
@@ -587,6 +599,45 @@ static void prep_new_page(struct page *p
 	kernel_map_pages(page, 1 << order, 1);
 }
 
+/*
+ * Find a list that has a 2^MAX_ORDER-1 block of pages available and
+ * return it
+ */
+struct page *steal_maxorder_block(struct zone *zone, int alloctype)
+{
+	struct page *page;
+	struct free_area *area = NULL;
+	int i;
+
+	for(i = 0; i < RCLM_TYPES; i++) {
+		if (i == alloctype)
+			continue;
+
+		area = &zone->free_area_lists[i][MAX_ORDER-1];
+		if (!list_empty(&area->free_list))
+			break;
+	}
+	if (i == RCLM_TYPES)
+		return NULL;
+
+	page = list_entry(area->free_list.next, struct page, lru);
+	area->nr_free--;
+
+	set_pageblock_type(zone, page, alloctype);
+
+	return page;
+}
+
+static inline struct page *
+remove_page(struct zone *zone, struct page *page, unsigned int order,
+		unsigned int current_order, struct free_area *area)
+{
+	list_del(&page->lru);
+	rmv_page_order(page);
+	zone->free_pages -= 1UL << order;
+	return expand(zone, page, order, current_order, area);
+}
+
 /* 
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
@@ -594,31 +645,25 @@ static void prep_new_page(struct page *p
 static struct page *__rmqueue(struct zone *zone, unsigned int order,
 					int alloctype)
 {
-	struct free_area * area;
+	struct free_area * area = NULL;
 	unsigned int current_order;
 	struct page *page;
 
 	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
-		area = zone->free_area + current_order;
+		area = &zone->free_area_lists[alloctype][current_order];
 		if (list_empty(&area->free_list))
 			continue;
 
 		page = list_entry(area->free_list.next, struct page, lru);
-		list_del(&page->lru);
-		rmv_page_order(page);
 		area->nr_free--;
-		zone->free_pages -= 1UL << order;
-
-		/*
-		 * If splitting a large block, record what the block is being
-		 * used for in the usemap
-		 */
-		if (current_order == MAX_ORDER-1)
-			set_pageblock_type(zone, page, alloctype);
-
-		return expand(zone, page, order, current_order, area);
+		return remove_page(zone, page, order, current_order, area);
 	}
 
+	/* Allocate a MAX_ORDER block */
+	page = steal_maxorder_block(zone, alloctype);
+	if (page != NULL)
+		return remove_page(zone, page, order, MAX_ORDER-1, area);
+
 	return NULL;
 }
 
@@ -704,9 +749,9 @@ static void __drain_pages(unsigned int c
 void mark_free_pages(struct zone *zone)
 {
 	unsigned long zone_pfn, flags;
-	int order;
+	int order, t;
+	unsigned long start_pfn, i;
 	struct list_head *curr;
-
 	if (!zone->spanned_pages)
 		return;
 
@@ -714,14 +759,12 @@ void mark_free_pages(struct zone *zone)
 	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
 		ClearPageNosaveFree(pfn_to_page(zone_pfn + zone->zone_start_pfn));
 
-	for (order = MAX_ORDER - 1; order >= 0; --order)
-		list_for_each(curr, &zone->free_area[order].free_list) {
-			unsigned long start_pfn, i;
-
+	for_each_rclmtype_order(t, order) {
+		list_for_each(curr,&zone->free_area_lists[t][order].free_list) {
 			start_pfn = page_to_pfn(list_entry(curr, struct page, lru));
-
 			for (i=0; i < (1<<order); i++)
 				SetPageNosaveFree(pfn_to_page(start_pfn+i));
+		}
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
@@ -876,6 +919,7 @@ int zone_watermark_ok(struct zone *z, in
 	/* free_pages my go negative - that's OK */
 	long min = mark, free_pages = z->free_pages - (1 << order) + 1;
 	int o;
+	struct free_area *kernnorclm, *kernrclm, *easyrclm;
 
 	if (gfp_high)
 		min -= min / 2;
@@ -884,15 +928,22 @@ int zone_watermark_ok(struct zone *z, in
 
 	if (free_pages <= min + z->lowmem_reserve[classzone_idx])
 		goto out_failed;
+	kernnorclm = z->free_area_lists[RCLM_NORCLM];
+	easyrclm = z->free_area_lists[RCLM_EASY];
+	kernrclm = z->free_area_lists[RCLM_KERN];
 	for (o = 0; o < order; o++) {
 		/* At the next order, this order's pages become unavailable */
-		free_pages -= z->free_area[o].nr_free << o;
+		free_pages -= (kernnorclm->nr_free + kernrclm->nr_free +
+				easyrclm->nr_free) << o;
 
 		/* Require fewer higher order pages to be free */
 		min >>= 1;
 
 		if (free_pages <= min)
 			goto out_failed;
+		kernnorclm++;
+		easyrclm++;
+		kernrclm++;
 	}
 
 	return 1;
@@ -1496,6 +1547,7 @@ void show_free_areas(void)
 	unsigned long inactive;
 	unsigned long free;
 	struct zone *zone;
+	int type;
 
 	for_each_zone(zone) {
 		show_node(zone);
@@ -1575,7 +1627,9 @@ void show_free_areas(void)
 	}
 
 	for_each_zone(zone) {
- 		unsigned long nr, flags, order, total = 0;
+ 		unsigned long nr = 0;
+		unsigned long total = 0;
+		unsigned long flags,order;
 
 		show_node(zone);
 		printk("%s: ", zone->name);
@@ -1585,10 +1639,18 @@ void show_free_areas(void)
 		}
 
 		spin_lock_irqsave(&zone->lock, flags);
-		for (order = 0; order < MAX_ORDER; order++) {
-			nr = zone->free_area[order].nr_free;
+		for_each_rclmtype_order(type, order) {
+			nr += zone->free_area_lists[type][order].nr_free;
 			total += nr << order;
-			printk("%lu*%lukB ", nr, K(1UL) << order);
+
+			/*
+			 * If type had reached RCLM_TYPE, the free pages
+			 * for this order have been summed up
+			 */
+			if (type == RCLM_TYPES-1) {
+				printk("%lu*%lukB ", nr, K(1UL) << order);
+				nr = 0;
+			}
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
 		printk("= %lukB\n", K(total));
@@ -1899,9 +1961,14 @@ void zone_init_free_lists(struct pglist_
 				unsigned long size)
 {
 	int order;
-	for (order = 0; order < MAX_ORDER ; order++) {
-		INIT_LIST_HEAD(&zone->free_area[order].free_list);
-		zone->free_area[order].nr_free = 0;
+	int type;
+	struct free_area *area;
+
+	/* Initialse the three size ordered lists of free_areas */
+	for_each_rclmtype_order(type, order) {
+		area = &(zone->free_area_lists[type][order]);
+		INIT_LIST_HEAD(&area->free_list);
+		area->nr_free = 0;
 	}
 }
 
@@ -2314,16 +2381,26 @@ static int frag_show(struct seq_file *m,
 	struct zone *zone;
 	struct zone *node_zones = pgdat->node_zones;
 	unsigned long flags;
-	int order;
+	int order, t;
+	struct free_area *area;
+	unsigned long nr_bufs = 0;
 
 	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
 		if (!zone->present_pages)
 			continue;
 
 		spin_lock_irqsave(&zone->lock, flags);
-		seq_printf(m, "Node %d, zone %8s ", pgdat->node_id, zone->name);
-		for (order = 0; order < MAX_ORDER; ++order)
-			seq_printf(m, "%6lu ", zone->free_area[order].nr_free);
+		seq_printf(m, "Node %d, zone %8s", pgdat->node_id, zone->name);
+		for_each_rclmtype_order(t, order) {
+			area = &(zone->free_area_lists[t][order]);
+			nr_bufs += area->nr_free;
+
+			if (t == RCLM_TYPES-1) {
+				seq_printf(m, "%6lu ", nr_bufs);
+				nr_bufs = 0;
+			}
+		}
+
 		spin_unlock_irqrestore(&zone->lock, flags);
 		seq_putc(m, '\n');
 	}
