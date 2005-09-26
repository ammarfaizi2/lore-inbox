Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbVIZUNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbVIZUNi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 16:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbVIZUNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 16:13:37 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:21122 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932498AbVIZUNh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 16:13:37 -0400
Message-ID: <4338566B.1000909@austin.ibm.com>
Date: Mon, 26 Sep 2005 15:13:31 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Joel Schopp <jschopp@austin.ibm.com>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Linux Memory Management List <linux-mm@kvack.org>,
       linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>,
       Mike Kravetz <kravetz@us.ibm.com>
Subject: [PATCH 6/9] fragmentation avoidance core
References: <4338537E.8070603@austin.ibm.com>
In-Reply-To: <4338537E.8070603@austin.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------030601050200010907090206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030601050200010907090206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch is the core changes for memory fragmentation avoidance.

__rmqueue() within an alloctype behaves much as it did before on the global
list. If that alloctype has insufficient free blocks it trys to
steal a unallocated 2^MAX_ORDER-1 block from another type.  If there are no
unallocated 2^MAX_ORDER-1 blocks it goes to a more aggressive fallback
allocation detailed in a later patch.

The other functions do basically the same thing they did before, they just get
tidied up to deal with 3 alloctypes.

As this patch replaces all references to free_area[] with free_area_lists[] it
removes free_area[]

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>

--------------030601050200010907090206
Content-Type: text/plain;
 name="6_defrag_core"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="6_defrag_core"

Index: 2.6.13-joel2/mm/page_alloc.c
===================================================================
--- 2.6.13-joel2.orig/mm/page_alloc.c	2005-09-20 15:08:05.%N -0500
+++ 2.6.13-joel2/mm/page_alloc.c	2005-09-21 11:13:14.%N -0500
@@ -104,7 +104,9 @@ void assign_bit(int bit_nr, unsigned lon
  * Reserve a block of pages for an allocation type & enforce function
  * being changed if more bits are added to keep track of additional types
  */
-BUILD_BUG_ON(BITS_PER_RCLM_TYPE > 2)
+#if BITS_PER_RCLM_TYPE > 2
+#error
+#endif
 static inline void set_pageblock_type(struct zone *zone, struct page *page,
 				      int type)
 {
@@ -333,6 +335,8 @@ static inline void __free_pages_bulk (st
 {
 	unsigned long page_idx;
 	int order_size = 1 << order;
+	struct free_area *area;
+	struct free_area *freelist;
 
 	if (unlikely(order))
 		destroy_compound_page(page, order);
@@ -342,10 +346,11 @@ static inline void __free_pages_bulk (st
 	BUG_ON(page_idx & (order_size - 1));
 	BUG_ON(bad_range(zone, page));
 
+	freelist = zone->free_area_lists[get_pageblock_type(zone,page)];
+
 	zone->free_pages += order_size;
 	while (order < MAX_ORDER-1) {
 		unsigned long combined_idx;
-		struct free_area *area;
 		struct page *buddy;
 
 		combined_idx = __find_combined_index(page_idx, order);
@@ -356,16 +361,20 @@ static inline void __free_pages_bulk (st
 		if (!page_is_buddy(buddy, order))
 			break;		/* Move the buddy up one level. */
 		list_del(&buddy->lru);
-		area = zone->free_area + order;
+		area = freelist + order;
 		area->nr_free--;
 		rmv_page_order(buddy);
 		page = page + (combined_idx - page_idx);
 		page_idx = combined_idx;
 		order++;
 	}
+	if (unlikely(order == MAX_ORDER-1)) zone->fallback_balance++;
+
 	set_page_order(page, order);
-	list_add(&page->lru, &zone->free_area[order].free_list);
-	zone->free_area[order].nr_free++;
+	area = freelist + order;
+	list_add_tail(&page->lru, &area->free_list);
+	area->nr_free++;
+
 }
 
 static inline void free_pages_check(const char *function, struct page *page)
@@ -555,6 +564,25 @@ static inline struct page* steal_largepa
 	return page;
 }
 
+static inline struct page
+*remove_page(struct zone *zone, struct page *page, unsigned int order,
+	     unsigned int current_order, struct free_area *area)
+{
+	if (unlikely(current_order == MAX_ORDER-1)) zone->fallback_balance--;
+	list_del(&page->lru);
+	rmv_page_order(page);
+	zone->free_pages -= 1UL << order;
+	return expand(zone, page, order, current_order, area);
+}
+
+
+static struct page *
+fallback_alloc(int alloctype, struct zone *zone, unsigned int order)
+{
+	/* Stub out for seperate review, NULL equates to no fallback*/
+	return NULL;
+
+}
 /* 
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
@@ -566,20 +594,24 @@ static struct page *__rmqueue(struct zon
 	unsigned int current_order;
 	struct page *page;
 
-	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
-		area = zone->free_area + current_order;
-		if (list_empty(&area->free_list))
-			continue;
-
+	alloctype >>= RCLM_SHIFT;
+	/* Search the list for the alloctype */
+	area = zone->free_area_lists[alloctype] + order;
+	for (current_order = order; current_order < MAX_ORDER;
+	     current_order++, area++) {
+		if (list_empty(&area->free_list)) continue;
 		page = list_entry(area->free_list.next, struct page, lru);
-		list_del(&page->lru);
-		rmv_page_order(page);
-		area->nr_free--;
-		zone->free_pages -= 1UL << order;
-		return expand(zone, page, order, current_order, area);
+ 		area->nr_free--;
+		return remove_page(zone, page, order, current_order, area);
 	}
 
-	return NULL;
+	page = steal_largepage(zone, alloctype);
+	if (page == NULL)
+		return fallback_alloc(alloctype, zone, order);
+
+	area--;
+	current_order--;
+	return remove_page(zone, page, order, current_order, area);
 }
 
 /* 
@@ -587,25 +619,49 @@ static struct page *__rmqueue(struct zon
  * a single hold of the lock, for efficiency.  Add them to the supplied list.
  * Returns the number of new pages which were placed at *list.
  */
-static int rmqueue_bulk(struct zone *zone, unsigned int order, 
-			unsigned long count, struct list_head *list,
-			int alloctype)
+static int rmqueue_bulk(struct zone *zone, unsigned long count,
+			struct list_head *list, int alloctype)
 {
 	unsigned long flags;
 	int i;
-	int allocated = 0;
+	unsigned long allocated = count;
 	struct page *page;
-	
+	unsigned long current_order = 0;
+	/* Find what order we should start allocating blocks at */
+	current_order = ffs(count) - 1;
+
+
+	/*
+	 * Satisfy the request in as the largest possible physically
+	 * contiguous block
+	 */
 	spin_lock_irqsave(&zone->lock, flags);
-	for (i = 0; i < count; ++i) {
-		page = __rmqueue(zone, order, alloctype);
-		if (page == NULL)
-			break;
-		allocated++;
-		list_add_tail(&page->lru, list);
+	while (allocated) {
+		if ((1 << current_order) > allocated)
+			current_order--;
+
+		/* Allocate a block at the current_order */
+		page = __rmqueue(zone, current_order, alloctype);
+		if (page == NULL) {
+			if (current_order == 0) break;
+			current_order--;
+			continue;
+		}
+		allocated -= 1 << current_order;
+		/* Move to the next block if order is already 0 */
+		if (current_order == 0) {
+			list_add_tail(&page->lru, list);
+			continue;
+		}
+
+		/* Split the large block into order-sized blocks  */
+		for (i = 1 << current_order; i != 0; i--) {
+			list_add_tail(&page->lru, list);
+			page++;
+		}
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
-	return allocated;
+	return count - allocated;
 }
 
 #ifdef CONFIG_NUMA
@@ -664,9 +720,9 @@ static void __drain_pages(unsigned int c
 void mark_free_pages(struct zone *zone)
 {
 	unsigned long zone_pfn, flags;
-	int order;
+	int order, type;
+	unsigned long start_pfn, i;
 	struct list_head *curr;
-
 	if (!zone->spanned_pages)
 		return;
 
@@ -674,14 +730,15 @@ void mark_free_pages(struct zone *zone)
 	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
 		ClearPageNosaveFree(pfn_to_page(zone_pfn + zone->zone_start_pfn));
 
-	for (order = MAX_ORDER - 1; order >= 0; --order)
-		list_for_each(curr, &zone->free_area[order].free_list) {
-			unsigned long start_pfn, i;
-
-			start_pfn = page_to_pfn(list_entry(curr, struct page, lru));
-
+	for (type=0; type < RCLM_TYPES; type++) {
+		for (order = MAX_ORDER - 1; order >= 0; --order)
+			list_for_each(curr, &zone->free_area_lists[type]
+				      [order].free_list) {
+			start_pfn = page_to_pfn(list_entry(curr, struct page,
+							   lru));
 			for (i=0; i < (1<<order); i++)
 				SetPageNosaveFree(pfn_to_page(start_pfn+i));
+		}
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
@@ -790,7 +847,7 @@ buffered_rmqueue(struct zone *zone, int 
 		pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 		local_irq_save(flags);
 		if (pcp->count <= pcp->low)
-			pcp->count += rmqueue_bulk(zone, 0, pcp->batch,
+			pcp->count += rmqueue_bulk(zone, pcp->batch,
 						   &pcp->list, alloctype);
 		if (pcp->count) {
 			page = list_entry(pcp->list.next, struct page, lru);
@@ -831,6 +888,7 @@ int zone_watermark_ok(struct zone *z, in
 	/* free_pages my go negative - that's OK */
 	long min = mark, free_pages = z->free_pages - (1 << order) + 1;
 	int o;
+	struct free_area *kernnorclm, *kernrclm, *userrclm;
 
 	if (gfp_high)
 		min -= min / 2;
@@ -839,15 +897,21 @@ int zone_watermark_ok(struct zone *z, in
 
 	if (free_pages <= min + z->lowmem_reserve[classzone_idx])
 		return 0;
+	kernnorclm = z->free_area_lists[RCLM_NORCLM];
+	kernrclm = z->free_area_lists[RCLM_KERN];
+	userrclm = z->free_area_lists[RCLM_USER];
 	for (o = 0; o < order; o++) {
 		/* At the next order, this order's pages become unavailable */
-		free_pages -= z->free_area[o].nr_free << o;
-
+		free_pages -= (kernnorclm->nr_free + kernrclm->nr_free +
+			       userrclm->nr_free) << o;
 		/* Require fewer higher order pages to be free */
 		min >>= 1;
 
 		if (free_pages <= min)
 			return 0;
+		kernnorclm++;
+		kernrclm++;
+		userrclm++;
 	}
 	return 1;
 }
@@ -1370,6 +1434,7 @@ void show_free_areas(void)
 	unsigned long inactive;
 	unsigned long free;
 	struct zone *zone;
+	int type;
 
 	for_each_zone(zone) {
 		show_node(zone);
@@ -1463,8 +1528,10 @@ void show_free_areas(void)
 
 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order < MAX_ORDER; order++) {
-			nr = zone->free_area[order].nr_free;
-			total += nr << order;
+			for (type=0; type < RCLM_TYPES; type++) {
+				nr = zone->free_area_lists[type][order].nr_free;
+				total += nr << order;
+			}
 			printk("%lu*%lukB ", nr, K(1UL) << order);
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
@@ -2171,16 +2238,36 @@ static int frag_show(struct seq_file *m,
 	struct zone *zone;
 	struct zone *node_zones = pgdat->node_zones;
 	unsigned long flags;
-	int order;
+	int order, type;
+	struct list_head *elem;
+	unsigned long nr_bufs = 0;
 
 	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
 		if (!zone->present_pages)
 			continue;
 
 		spin_lock_irqsave(&zone->lock, flags);
-		seq_printf(m, "Node %d, zone %8s ", pgdat->node_id, zone->name);
-		for (order = 0; order < MAX_ORDER; ++order)
-			seq_printf(m, "%6lu ", zone->free_area[order].nr_free);
+		seq_printf(m, "Node %d, zone %8s", pgdat->node_id, zone->name);
+		for (order = 0; order < MAX_ORDER-1; ++order) {
+			nr_bufs = 0;
+
+			for (type=0; type < RCLM_TYPES; type++) {
+				list_for_each(elem,
+					      &(zone->free_area_lists[type]
+						[order].free_list))
+					++nr_bufs;
+			}
+			seq_printf(m, "%6lu ", nr_bufs);
+		}
+
+		/* Scan global list */
+		nr_bufs = 0;
+		for (type=0; type < RCLM_TYPES; type++) {
+			nr_bufs += zone->free_area_lists[type]
+				[MAX_ORDER-1].nr_free;
+		}
+		seq_printf(m, "%6lu ", nr_bufs);
+
 		spin_unlock_irqrestore(&zone->lock, flags);
 		seq_putc(m, '\n');
 	}
Index: 2.6.13-joel2/include/linux/mmzone.h
===================================================================
--- 2.6.13-joel2.orig/include/linux/mmzone.h	2005-09-20 15:04:47.%N -0500
+++ 2.6.13-joel2/include/linux/mmzone.h	2005-09-21 10:44:00.%N -0500
@@ -152,11 +152,7 @@ struct zone {
 	 * free areas of different sizes
 	 */
 	spinlock_t		lock;
-	/*
-	 *  free_area to be removed in later patch  as it is replaced by
-	 *  free_area_list
-	 */
-	struct free_area	free_area[MAX_ORDER];
+
 #ifndef CONFIG_SPARSEMEM
 	/*
 	 * The map tracks what each 2^MAX_ORDER-1 sized block is being used for.

--------------030601050200010907090206--
