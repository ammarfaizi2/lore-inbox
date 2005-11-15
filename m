Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbVKOQun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbVKOQun (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbVKOQuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:50:39 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:37292 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S964926AbVKOQuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:50:06 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, mingo@elte.hu, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, lhms-devel@lists.sourceforge.net
Message-Id: <20051115165002.21980.14423.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 3/5] Light Fragmentation Avoidance V20: 003_fragcore
Date: Tue, 15 Nov 2005 16:50:04 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the core of the anti-fragmentation strategy. It works by
grouping related allocation types together. The idea is that large groups of
pages that may be reclaimed are placed near each other. The zone->free_area
list is broken into RCLM_TYPES number of lists.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-002_usemap/include/linux/mmzone.h linux-2.6.14-mm2-003_fragcore/include/linux/mmzone.h
--- linux-2.6.14-mm2-002_usemap/include/linux/mmzone.h	2005-11-15 12:42:15.000000000 +0000
+++ linux-2.6.14-mm2-003_fragcore/include/linux/mmzone.h	2005-11-15 12:43:41.000000000 +0000
@@ -27,6 +27,12 @@
 #define RCLM_EASY     1
 #define RCLM_TYPES    2
 
+#define for_each_rclmtype(type) \
+	for (type = 0; type < RCLM_TYPES; type++)
+#define for_each_rclmtype_order(type, order) \
+	for (order = 0; order < MAX_ORDER; order++) \
+		for (type = 0; type < RCLM_TYPES; type++)
+
 struct free_area {
 	struct list_head	free_list;
 	unsigned long		nr_free;
@@ -150,7 +156,7 @@ struct zone {
 	/* see spanned/present_pages for more description */
 	seqlock_t		span_seqlock;
 #endif
-	struct free_area	free_area[MAX_ORDER];
+	struct free_area	free_area_lists[RCLM_TYPES][MAX_ORDER];
 
 #ifndef CONFIG_SPARSEMEM
 	/*
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-002_usemap/mm/page_alloc.c linux-2.6.14-mm2-003_fragcore/mm/page_alloc.c
--- linux-2.6.14-mm2-002_usemap/mm/page_alloc.c	2005-11-15 12:42:15.000000000 +0000
+++ linux-2.6.14-mm2-003_fragcore/mm/page_alloc.c	2005-11-15 12:44:27.000000000 +0000
@@ -68,6 +68,11 @@ int sysctl_lowmem_reserve_ratio[MAX_NR_Z
 
 EXPORT_SYMBOL(totalram_pages);
 
+static inline int gfpflags_to_alloctype(unsigned long gfp_flags)
+{
+	return ((gfp_flags & __GFP_EASYRCLM) != 0);
+}
+
 static inline int get_pageblock_type(struct zone *zone, struct page *page)
 {
 	unsigned long pfn = page_to_pfn(page);
@@ -272,6 +277,16 @@ __find_combined_index(unsigned long page
 }
 
 /*
+ * Return the free list for a given page within a zone
+ */
+static inline struct free_area *__page_find_freelist(struct zone *zone,
+							struct page *page,
+							int order)
+{
+	return &zone->free_area_lists[get_pageblock_type(zone, page)][order];
+}
+
+/*
  * This function checks whether a page is free && is the buddy
  * we can do coalesce a page and its buddy if
  * (a) the buddy is free &&
@@ -318,6 +333,7 @@ static inline void __free_pages_bulk (st
 {
 	unsigned long page_idx;
 	int order_size = 1 << order;
+	struct free_area *freelist;
 
 	if (unlikely(order))
 		destroy_compound_page(page, order);
@@ -327,10 +343,11 @@ static inline void __free_pages_bulk (st
 	BUG_ON(page_idx & (order_size - 1));
 	BUG_ON(bad_range(zone, page));
 
+	freelist = __page_find_freelist(zone, page, order);
+
 	zone->free_pages += order_size;
 	while (order < MAX_ORDER-1) {
 		unsigned long combined_idx;
-		struct free_area *area;
 		struct page *buddy;
 
 		combined_idx = __find_combined_index(page_idx, order);
@@ -341,16 +358,16 @@ static inline void __free_pages_bulk (st
 		if (!page_is_buddy(buddy, order))
 			break;		/* Move the buddy up one level. */
 		list_del(&buddy->lru);
-		area = zone->free_area + order;
-		area->nr_free--;
+		freelist->nr_free--;
 		rmv_page_order(buddy);
 		page = page + (combined_idx - page_idx);
 		page_idx = combined_idx;
 		order++;
+		freelist++;
 	}
 	set_page_order(page, order);
-	list_add(&page->lru, &zone->free_area[order].free_list);
-	zone->free_area[order].nr_free++;
+	list_add(&page->lru, &freelist->free_list);
+	freelist->nr_free++;
 }
 
 static inline void free_pages_check(const char *function, struct page *page)
@@ -507,18 +524,59 @@ static void prep_new_page(struct page *p
 	kernel_map_pages(page, 1 << order, 1);
 }
 
+/* Remove an element from the buddy allocator from the fallback list */
+static struct page *__rmqueue_fallback(struct zone *zone, int order,
+							int alloctype)
+{
+	struct free_area * area;
+	int current_order;
+	struct page *page;
+
+	/* Find the largest possible block of pages in the other list */
+	alloctype = !alloctype;
+	for (current_order = MAX_ORDER-1; current_order >= order;
+						--current_order) {
+		area = &(zone->free_area_lists[alloctype][current_order]);
+ 		if (list_empty(&area->free_list))
+ 			continue;
+
+		page = list_entry(area->free_list.next, struct page, lru);
+		area->nr_free--;
+
+		/*
+		 * If breaking a large block of pages, place the buddies
+		 * on the preferred allocation list
+		 */
+		if (unlikely(current_order >= MAX_ORDER / 2)) {
+			alloctype = !alloctype;
+			change_pageblock_type(zone, page);
+			area = &zone->free_area_lists[alloctype][current_order];
+		}
+
+		list_del(&page->lru);
+		rmv_page_order(page);
+		zone->free_pages -= 1UL << order;
+		return expand(zone, page, order, current_order, area);
+
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
+					int alloctype)
 {
 	struct free_area * area;
 	unsigned int current_order;
 	struct page *page;
 
+	/* Find a page of the appropriate size in the preferred list */
 	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
-		area = zone->free_area + current_order;
+		area = &(zone->free_area_lists[alloctype][current_order]);
 		if (list_empty(&area->free_list))
 			continue;
 
@@ -530,16 +588,18 @@ static struct page *__rmqueue(struct zon
 		return expand(zone, page, order, current_order, area);
 	}
 
-	return NULL;
+	return __rmqueue_fallback(zone, order, alloctype);
 }
 
+
 /* 
  * Obtain a specified number of elements from the buddy allocator, all under
  * a single hold of the lock, for efficiency.  Add them to the supplied list.
  * Returns the number of new pages which were placed at *list.
  */
 static int rmqueue_bulk(struct zone *zone, unsigned int order, 
-			unsigned long count, struct list_head *list)
+			unsigned long count, struct list_head *list,
+			int alloctype)
 {
 	unsigned long flags;
 	int i;
@@ -548,7 +608,7 @@ static int rmqueue_bulk(struct zone *zon
 	
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, alloctype);
 		if (page == NULL)
 			break;
 		allocated++;
@@ -614,7 +674,7 @@ static void __drain_pages(unsigned int c
 void mark_free_pages(struct zone *zone)
 {
 	unsigned long zone_pfn, flags;
-	int order;
+	int order, t;
 	struct list_head *curr;
 
 	if (!zone->spanned_pages)
@@ -624,14 +684,13 @@ void mark_free_pages(struct zone *zone)
 	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
 		ClearPageNosaveFree(pfn_to_page(zone_pfn + zone->zone_start_pfn));
 
-	for (order = MAX_ORDER - 1; order >= 0; --order)
-		list_for_each(curr, &zone->free_area[order].free_list) {
+	for_each_rclmtype_order(t, order) {
+		list_for_each(curr,&zone->free_area_lists[t][order].free_list) {
 			unsigned long start_pfn, i;
-
 			start_pfn = page_to_pfn(list_entry(curr, struct page, lru));
-
 			for (i=0; i < (1<<order); i++)
 				SetPageNosaveFree(pfn_to_page(start_pfn+i));
+		}
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
@@ -732,6 +791,7 @@ buffered_rmqueue(struct zone *zone, int 
 	unsigned long flags;
 	struct page *page = NULL;
 	int cold = !!(gfp_flags & __GFP_COLD);
+	int alloctype = gfpflags_to_alloctype(gfp_flags);
 
 	if (order == 0) {
 		struct per_cpu_pages *pcp;
@@ -740,7 +800,8 @@ buffered_rmqueue(struct zone *zone, int 
 		local_irq_save(flags);
 		if (pcp->count <= pcp->low)
 			pcp->count += rmqueue_bulk(zone, 0,
-						pcp->batch, &pcp->list);
+						pcp->batch, &pcp->list,
+						alloctype);
 		if (pcp->count) {
 			page = list_entry(pcp->list.next, struct page, lru);
 			list_del(&page->lru);
@@ -750,7 +811,7 @@ buffered_rmqueue(struct zone *zone, int 
 		put_cpu();
 	} else {
 		spin_lock_irqsave(&zone->lock, flags);
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, alloctype);
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
 
@@ -781,25 +842,32 @@ int zone_watermark_ok(struct zone *z, in
 		      int classzone_idx, int alloc_flags)
 {
 	/* free_pages my go negative - that's OK */
-	long min = mark, free_pages = z->free_pages - (1 << order) + 1;
-	int o;
+	long free_pages = z->free_pages - (1 << order) + 1;
+	long min;
+	int o,t;
 
 	if (alloc_flags & ALLOC_HIGH)
-		min -= min / 2;
+		mark -= mark / 2;
 	if (alloc_flags & ALLOC_HARDER)
-		min -= min / 4;
+		mark -= mark / 4;
 
-	if (free_pages <= min + z->lowmem_reserve[classzone_idx])
+	if (free_pages <= mark + z->lowmem_reserve[classzone_idx])
 		goto out_failed;
-	for (o = 0; o < order; o++) {
-		/* At the next order, this order's pages become unavailable */
-		free_pages -= z->free_area[o].nr_free << o;
+	for_each_rclmtype(t) {
+		min = mark;
+		for (o = 0; o < order; o++) {
+			/*
+			 * At the next order, this order's pages become
+			 * unavailable
+			 */
+			free_pages -= z->free_area_lists[t][o].nr_free << o;
 
-		/* Require fewer higher order pages to be free */
-		min >>= 1;
+			/* Require fewer higher order pages to be free */
+			min >>= 1;
 
-		if (free_pages <= min)
-			goto out_failed;
+			if (free_pages <= min)
+				goto out_failed;
+			}
 	}
 
 	return 1;
@@ -1380,6 +1448,7 @@ void show_free_areas(void)
 	unsigned long inactive;
 	unsigned long free;
 	struct zone *zone;
+	int type;
 
 	for_each_zone(zone) {
 		show_node(zone);
@@ -1459,7 +1528,9 @@ void show_free_areas(void)
 	}
 
 	for_each_zone(zone) {
- 		unsigned long nr, flags, order, total = 0;
+ 		unsigned long nr = 0;
+		unsigned long total = 0;
+		unsigned long flags,order;
 
 		show_node(zone);
 		printk("%s: ", zone->name);
@@ -1469,10 +1540,18 @@ void show_free_areas(void)
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
@@ -1782,9 +1861,14 @@ void zone_init_free_lists(struct pglist_
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
 
@@ -2199,16 +2283,26 @@ static int frag_show(struct seq_file *m,
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
