Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbVAKAlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVAKAlR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbVAKAF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:05:56 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:46807 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262551AbVAJXzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 18:55:20 -0500
Date: Mon, 10 Jan 2005 15:55:01 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Prezeroing V4 [2/4]: Zeroing implementation
In-Reply-To: <Pine.LNX.4.58.0501101552100.25654@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0501101554110.25654@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
 <Pine.LNX.4.58.0501100915200.19135@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501101004230.2373@ppc970.osdl.org>
 <Pine.LNX.4.58.0501101552100.25654@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o Add page zeroing
o Add scrub daemon
o Add ability to view amount of zeroed information in /proc/meninfo

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.10/mm/page_alloc.c
===================================================================
--- linux-2.6.10.orig/mm/page_alloc.c	2005-01-10 13:48:11.000000000 -0800
+++ linux-2.6.10/mm/page_alloc.c	2005-01-10 14:44:22.000000000 -0800
@@ -12,6 +12,7 @@
  *  Zone balancing, Kanoj Sarcar, SGI, Jan 2000
  *  Per cpu hot/cold page lists, bulk allocation, Martin J. Bligh, Sept 2002
  *          (lots of bits borrowed from Ingo Molnar & Andrew Morton)
+ *  Support for page zeroing, Christoph Lameter, SGI, Dec 2004
  */

 #include <linux/config.h>
@@ -33,6 +34,7 @@
 #include <linux/cpu.h>
 #include <linux/nodemask.h>
 #include <linux/vmalloc.h>
+#include <linux/scrub.h>

 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -167,16 +169,16 @@
  * zone->lock is already acquired when we use these.
  * So, we don't need atomic page->flags operations here.
  */
-static inline unsigned long page_order(struct page *page) {
+static inline unsigned long page_zorder(struct page *page) {
 	return page->private;
 }

-static inline void set_page_order(struct page *page, int order) {
-	page->private = order;
+static inline void set_page_zorder(struct page *page, int order, int zero) {
+	page->private = order + (zero << 10);
 	__SetPagePrivate(page);
 }

-static inline void rmv_page_order(struct page *page)
+static inline void rmv_page_zorder(struct page *page)
 {
 	__ClearPagePrivate(page);
 	page->private = 0;
@@ -187,14 +189,15 @@
  * we can do coalesce a page and its buddy if
  * (a) the buddy is free &&
  * (b) the buddy is on the buddy system &&
- * (c) a page and its buddy have the same order.
+ * (c) a page and its buddy have the same order and the same
+ *     zeroing status.
  * for recording page's order, we use page->private and PG_private.
  *
  */
-static inline int page_is_buddy(struct page *page, int order)
+static inline int page_is_buddy(struct page *page, int order, int zero)
 {
        if (PagePrivate(page)           &&
-           (page_order(page) == order) &&
+           (page_zorder(page) == order + (zero << 10)) &&
            !PageReserved(page)         &&
             page_count(page) == 0)
                return 1;
@@ -225,22 +228,20 @@
  * -- wli
  */

-static inline void __free_pages_bulk (struct page *page, struct page *base,
-		struct zone *zone, unsigned int order)
+static inline int __free_pages_bulk (struct page *page, struct page *base,
+		struct zone *zone, unsigned int order, int zero)
 {
 	unsigned long page_idx;
 	struct page *coalesced;
-	int order_size = 1 << order;

 	if (unlikely(order))
 		destroy_compound_page(page, order);

 	page_idx = page - base;

-	BUG_ON(page_idx & (order_size - 1));
+	BUG_ON(page_idx & (( 1 << order) - 1));
 	BUG_ON(bad_range(zone, page));

-	zone->free_pages += order_size;
 	while (order < MAX_ORDER-1) {
 		struct free_area *area;
 		struct page *buddy;
@@ -250,20 +251,21 @@
 		buddy = base + buddy_idx;
 		if (bad_range(zone, buddy))
 			break;
-		if (!page_is_buddy(buddy, order))
+		if (!page_is_buddy(buddy, order, zero))
 			break;
 		/* Move the buddy up one level. */
 		list_del(&buddy->lru);
-		area = zone->free_area + order;
+		area = zone->free_area[zero] + order;
 		area->nr_free--;
-		rmv_page_order(buddy);
+		rmv_page_zorder(buddy);
 		page_idx &= buddy_idx;
 		order++;
 	}
 	coalesced = base + page_idx;
-	set_page_order(coalesced, order);
-	list_add(&coalesced->lru, &zone->free_area[order].free_list);
-	zone->free_area[order].nr_free++;
+	set_page_zorder(coalesced, order, zero);
+	list_add(&coalesced->lru, &zone->free_area[zero][order].free_list);
+	zone->free_area[zero][order].nr_free++;
+	return order;
 }

 static inline void free_pages_check(const char *function, struct page *page)
@@ -312,8 +314,11 @@
 		page = list_entry(list->prev, struct page, lru);
 		/* have to delete it as __free_pages_bulk list manipulates */
 		list_del(&page->lru);
-		__free_pages_bulk(page, base, zone, order);
+		if (__free_pages_bulk(page, base, zone, order, NOT_ZEROED)
+			>= sysctl_scrub_start)
+				wakeup_kscrubd(zone);
 		ret++;
+		zone->free_pages += 1UL << order;
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
 	return ret;
@@ -341,6 +346,18 @@
 	free_pages_bulk(page_zone(page), 1, &list, order);
 }

+void end_zero_page(struct page *page, unsigned int order)
+{
+	unsigned long flags;
+	struct zone * zone = page_zone(page);
+
+	spin_lock_irqsave(&zone->lock, flags);
+
+	__free_pages_bulk(page, zone->zone_mem_map, zone, order, ZEROED);
+	zone->zero_pages += 1UL << order;
+
+	spin_unlock_irqrestore(&zone->lock, flags);
+}

 /*
  * The order of subdivision here is critical for the IO subsystem.
@@ -358,7 +375,7 @@
  */
 static inline struct page *
 expand(struct zone *zone, struct page *page,
- 	int low, int high, struct free_area *area)
+ 	int low, int high, struct free_area *area, int zero)
 {
 	unsigned long size = 1 << high;

@@ -369,7 +386,7 @@
 		BUG_ON(bad_range(zone, &page[size]));
 		list_add(&page[size].lru, &area->free_list);
 		area->nr_free++;
-		set_page_order(&page[size], high);
+		set_page_zorder(&page[size], high, zero);
 	}
 	return page;
 }
@@ -419,23 +436,44 @@
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
  */
-static struct page *__rmqueue(struct zone *zone, unsigned int order)
+static void inline rmpage(struct page *page, struct free_area *area)
+{
+	list_del(&page->lru);
+	rmv_page_zorder(page);
+	area->nr_free--;
+}
+
+struct page *scrubd_rmpage(struct zone *zone, struct free_area *area)
+{
+	unsigned long flags;
+	struct page *page = NULL;
+
+	spin_lock_irqsave(&zone->lock, flags);
+	if (!list_empty(&area->free_list)) {
+		page = list_entry(area->free_list.next, struct page, lru);
+		rmpage(page, area);
+	}
+	spin_unlock_irqrestore(&zone->lock, flags);
+	return page;
+}
+
+static struct page *__rmqueue(struct zone *zone, unsigned int order, int zero)
 {
-	struct free_area * area;
+	struct free_area *area;
 	unsigned int current_order;
 	struct page *page;

 	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
-		area = zone->free_area + current_order;
+		area = zone->free_area[zero] + current_order;
 		if (list_empty(&area->free_list))
 			continue;

 		page = list_entry(area->free_list.next, struct page, lru);
-		list_del(&page->lru);
-		rmv_page_order(page);
-		area->nr_free--;
+		rmpage(page, zone->free_area[zero] + current_order);
 		zone->free_pages -= 1UL << order;
-		return expand(zone, page, order, current_order, area);
+		if (zero)
+			zone->zero_pages -= 1UL << order;
+		return expand(zone, page, order, current_order, area, zero);
 	}

 	return NULL;
@@ -447,7 +485,7 @@
  * Returns the number of new pages which were placed at *list.
  */
 static int rmqueue_bulk(struct zone *zone, unsigned int order,
-			unsigned long count, struct list_head *list)
+			unsigned long count, struct list_head *list, int zero)
 {
 	unsigned long flags;
 	int i;
@@ -456,7 +494,7 @@

 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, zero);
 		if (page == NULL)
 			break;
 		allocated++;
@@ -503,7 +541,7 @@
 		ClearPageNosaveFree(pfn_to_page(zone_pfn + zone->zone_start_pfn));

 	for (order = MAX_ORDER - 1; order >= 0; --order)
-		list_for_each(curr, &zone->free_area[order].free_list) {
+		list_for_each(curr, &zone->free_area[NOT_ZEROED][order].free_list) {
 			unsigned long start_pfn, i;

 			start_pfn = page_to_pfn(list_entry(curr, struct page, lru));
@@ -595,7 +633,7 @@
  * we cheat by calling it from here, in the order > 0 path.  Saves a branch
  * or two.
  */
-static inline void prep_zero_page(struct page *page, int order)
+void prep_zero_page(struct page *page, unsigned int order)
 {
 	int i;

@@ -608,7 +646,9 @@
 {
 	unsigned long flags;
 	struct page *page = NULL;
-	int cold = !!(gfp_flags & __GFP_COLD);
+	int nr_pages = 1 << order;
+	int zero = !!((gfp_flags & __GFP_ZERO) && zone->zero_pages >= nr_pages);
+	int cold = !!(gfp_flags & __GFP_COLD) + 2*zero;

 	if (order == 0) {
 		struct per_cpu_pages *pcp;
@@ -617,7 +657,7 @@
 		local_irq_save(flags);
 		if (pcp->count <= pcp->low)
 			pcp->count += rmqueue_bulk(zone, 0,
-						pcp->batch, &pcp->list);
+						pcp->batch, &pcp->list, zero);
 		if (pcp->count) {
 			page = list_entry(pcp->list.next, struct page, lru);
 			list_del(&page->lru);
@@ -629,16 +669,25 @@

 	if (page == NULL) {
 		spin_lock_irqsave(&zone->lock, flags);
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, zero);
+		/*
+		 * If we failed to obtain a zero and/or unzeroed page
+		 * then we may still be able to obtain the other
+		 * type of page.
+		 */
+		if (!page) {
+			page = __rmqueue(zone, order, !zero);
+			zero = 0;
+		}
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}

 	if (page != NULL) {
 		BUG_ON(bad_range(zone, page));
-		mod_page_state_zone(zone, pgalloc, 1 << order);
+		mod_page_state_zone(zone, pgalloc, nr_pages);
 		prep_new_page(page, order);

-		if (gfp_flags & __GFP_ZERO)
+		if ((gfp_flags & __GFP_ZERO) && !zero)
 			prep_zero_page(page, order);

 		if (order && (gfp_flags & __GFP_COMP))
@@ -667,7 +716,7 @@
 		return 0;
 	for (o = 0; o < order; o++) {
 		/* At the next order, this order's pages become unavailable */
-		free_pages -= z->free_area[o].nr_free << o;
+		free_pages -= (z->free_area[NOT_ZEROED][o].nr_free + z->free_area[ZEROED][o].nr_free)  << o;

 		/* Require fewer higher order pages to be free */
 		min >>= 1;
@@ -1045,7 +1094,7 @@
 }

 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
-			unsigned long *free, struct pglist_data *pgdat)
+			unsigned long *free, unsigned long *zero, struct pglist_data *pgdat)
 {
 	struct zone *zones = pgdat->node_zones;
 	int i;
@@ -1053,27 +1102,31 @@
 	*active = 0;
 	*inactive = 0;
 	*free = 0;
+	*zero = 0;
 	for (i = 0; i < MAX_NR_ZONES; i++) {
 		*active += zones[i].nr_active;
 		*inactive += zones[i].nr_inactive;
 		*free += zones[i].free_pages;
+		*zero += zones[i].zero_pages;
 	}
 }

 void get_zone_counts(unsigned long *active,
-		unsigned long *inactive, unsigned long *free)
+		unsigned long *inactive, unsigned long *free, unsigned long *zero)
 {
 	struct pglist_data *pgdat;

 	*active = 0;
 	*inactive = 0;
 	*free = 0;
+	*zero = 0;
 	for_each_pgdat(pgdat) {
-		unsigned long l, m, n;
-		__get_zone_counts(&l, &m, &n, pgdat);
+		unsigned long l, m, n,o;
+		__get_zone_counts(&l, &m, &n, &o, pgdat);
 		*active += l;
 		*inactive += m;
 		*free += n;
+		*zero += o;
 	}
 }

@@ -1110,6 +1163,7 @@

 #define K(x) ((x) << (PAGE_SHIFT-10))

+const char *temp[3] = { "hot", "cold", "zero" };
 /*
  * Show free area list (used inside shift_scroll-lock stuff)
  * We also calculate the percentage fragmentation. We do this by counting the
@@ -1122,6 +1176,7 @@
 	unsigned long active;
 	unsigned long inactive;
 	unsigned long free;
+	unsigned long zero;
 	struct zone *zone;

 	for_each_zone(zone) {
@@ -1142,10 +1197,10 @@

 			pageset = zone->pageset + cpu;

-			for (temperature = 0; temperature < 2; temperature++)
+			for (temperature = 0; temperature < 3; temperature++)
 				printk("cpu %d %s: low %d, high %d, batch %d\n",
 					cpu,
-					temperature ? "cold" : "hot",
+					temp[temperature],
 					pageset->pcp[temperature].low,
 					pageset->pcp[temperature].high,
 					pageset->pcp[temperature].batch);
@@ -1153,20 +1208,21 @@
 	}

 	get_page_state(&ps);
-	get_zone_counts(&active, &inactive, &free);
+	get_zone_counts(&active, &inactive, &free, &zero);

 	printk("\nFree pages: %11ukB (%ukB HighMem)\n",
 		K(nr_free_pages()),
 		K(nr_free_highpages()));

 	printk("Active:%lu inactive:%lu dirty:%lu writeback:%lu "
-		"unstable:%lu free:%u slab:%lu mapped:%lu pagetables:%lu\n",
+		"unstable:%lu free:%u zero:%lu slab:%lu mapped:%lu pagetables:%lu\n",
 		active,
 		inactive,
 		ps.nr_dirty,
 		ps.nr_writeback,
 		ps.nr_unstable,
 		nr_free_pages(),
+		zero,
 		ps.nr_slab,
 		ps.nr_mapped,
 		ps.nr_page_table_pages);
@@ -1215,7 +1271,7 @@

 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order < MAX_ORDER; order++) {
-			nr = zone->free_area[order].nr_free;
+			nr = zone->free_area[NOT_ZEROED][order].nr_free + zone->free_area[ZEROED][order].nr_free;
 			total += nr << order;
 			printk("%lu*%lukB ", nr, K(1UL) << order);
 		}
@@ -1515,8 +1571,10 @@
 {
 	int order;
 	for (order = 0; order < MAX_ORDER ; order++) {
-		INIT_LIST_HEAD(&zone->free_area[order].free_list);
-		zone->free_area[order].nr_free = 0;
+		INIT_LIST_HEAD(&zone->free_area[NOT_ZEROED][order].free_list);
+		INIT_LIST_HEAD(&zone->free_area[ZEROED][order].free_list);
+		zone->free_area[NOT_ZEROED][order].nr_free = 0;
+		zone->free_area[ZEROED][order].nr_free = 0;
 	}
 }

@@ -1541,6 +1599,7 @@

 	pgdat->nr_zones = 0;
 	init_waitqueue_head(&pgdat->kswapd_wait);
+	init_waitqueue_head(&pgdat->kscrubd_wait);
 	pgdat->kswapd_max_order = 0;

 	for (j = 0; j < MAX_NR_ZONES; j++) {
@@ -1564,6 +1623,7 @@
 		spin_lock_init(&zone->lru_lock);
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
+		zone->zero_pages = 0;

 		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;

@@ -1597,6 +1657,13 @@
 			pcp->high = 2 * batch;
 			pcp->batch = 1 * batch;
 			INIT_LIST_HEAD(&pcp->list);
+
+			pcp = &zone->pageset[cpu].pcp[2];	/* zero pages */
+			pcp->count = 0;
+			pcp->low = 0;
+			pcp->high = 2 * batch;
+			pcp->batch = 1 * batch;
+			INIT_LIST_HEAD(&pcp->list);
 		}
 		printk(KERN_DEBUG "  %s zone: %lu pages, LIFO batch:%lu\n",
 				zone_names[j], realsize, batch);
@@ -1722,7 +1789,7 @@
 		spin_lock_irqsave(&zone->lock, flags);
 		seq_printf(m, "Node %d, zone %8s ", pgdat->node_id, zone->name);
 		for (order = 0; order < MAX_ORDER; ++order)
-			seq_printf(m, "%6lu ", zone->free_area[order].nr_free);
+			seq_printf(m, "%6lu ", zone->free_area[NOT_ZEROED][order].nr_free);
 		spin_unlock_irqrestore(&zone->lock, flags);
 		seq_putc(m, '\n');
 	}
Index: linux-2.6.10/include/linux/mmzone.h
===================================================================
--- linux-2.6.10.orig/include/linux/mmzone.h	2005-01-10 13:48:11.000000000 -0800
+++ linux-2.6.10/include/linux/mmzone.h	2005-01-10 13:54:50.000000000 -0800
@@ -51,7 +51,7 @@
 };

 struct per_cpu_pageset {
-	struct per_cpu_pages pcp[2];	/* 0: hot.  1: cold */
+	struct per_cpu_pages pcp[3];	/* 0: hot.  1: cold  2: cold zeroed pages */
 #ifdef CONFIG_NUMA
 	unsigned long numa_hit;		/* allocated in intended node */
 	unsigned long numa_miss;	/* allocated in non intended node */
@@ -107,10 +107,14 @@
  * ZONE_HIGHMEM	 > 896 MB	only page cache and user processes
  */

+#define NOT_ZEROED 0
+#define ZEROED 1
+
 struct zone {
 	/* Fields commonly accessed by the page allocator */
 	unsigned long		free_pages;
 	unsigned long		pages_min, pages_low, pages_high;
+	unsigned long		zero_pages;
 	/*
 	 * protection[] is a pre-calculated number of extra pages that must be
 	 * available in a zone in order for __alloc_pages() to allocate memory
@@ -131,7 +135,7 @@
 	 * free areas of different sizes
 	 */
 	spinlock_t		lock;
-	struct free_area	free_area[MAX_ORDER];
+	struct free_area	free_area[2][MAX_ORDER];


 	ZONE_PADDING(_pad1_)
@@ -266,6 +270,9 @@
 	wait_queue_head_t kswapd_wait;
 	struct task_struct *kswapd;
 	int kswapd_max_order;
+
+	wait_queue_head_t       kscrubd_wait;
+	struct task_struct *kscrubd;
 } pg_data_t;

 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
@@ -274,9 +281,9 @@
 extern struct pglist_data *pgdat_list;

 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
-			unsigned long *free, struct pglist_data *pgdat);
+			unsigned long *free, unsigned long *zero, struct pglist_data *pgdat);
 void get_zone_counts(unsigned long *active, unsigned long *inactive,
-			unsigned long *free);
+			unsigned long *free, unsigned long *zero);
 void build_all_zonelists(void);
 void wakeup_kswapd(struct zone *zone, int order);
 int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
Index: linux-2.6.10/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.10.orig/fs/proc/proc_misc.c	2005-01-10 13:48:10.000000000 -0800
+++ linux-2.6.10/fs/proc/proc_misc.c	2005-01-10 13:54:50.000000000 -0800
@@ -123,12 +123,13 @@
 	unsigned long inactive;
 	unsigned long active;
 	unsigned long free;
+	unsigned long zero;
 	unsigned long committed;
 	unsigned long allowed;
 	struct vmalloc_info vmi;

 	get_page_state(&ps);
-	get_zone_counts(&active, &inactive, &free);
+	get_zone_counts(&active, &inactive, &free, &zero);

 /*
  * display in kilobytes.
@@ -148,6 +149,7 @@
 	len = sprintf(page,
 		"MemTotal:     %8lu kB\n"
 		"MemFree:      %8lu kB\n"
+		"MemZero:      %8lu kB\n"
 		"Buffers:      %8lu kB\n"
 		"Cached:       %8lu kB\n"
 		"SwapCached:   %8lu kB\n"
@@ -171,6 +173,7 @@
 		"VmallocChunk: %8lu kB\n",
 		K(i.totalram),
 		K(i.freeram),
+		K(zero),
 		K(i.bufferram),
 		K(get_page_cache_size()-total_swapcache_pages-i.bufferram),
 		K(total_swapcache_pages),
Index: linux-2.6.10/mm/readahead.c
===================================================================
--- linux-2.6.10.orig/mm/readahead.c	2005-01-10 13:48:11.000000000 -0800
+++ linux-2.6.10/mm/readahead.c	2005-01-10 13:54:50.000000000 -0800
@@ -573,7 +573,8 @@
 	unsigned long active;
 	unsigned long inactive;
 	unsigned long free;
+	unsigned long zero;

-	__get_zone_counts(&active, &inactive, &free, NODE_DATA(numa_node_id()));
+	__get_zone_counts(&active, &inactive, &free, &zero, NODE_DATA(numa_node_id()));
 	return min(nr, (inactive + free) / 2);
 }
Index: linux-2.6.10/drivers/base/node.c
===================================================================
--- linux-2.6.10.orig/drivers/base/node.c	2005-01-10 13:48:08.000000000 -0800
+++ linux-2.6.10/drivers/base/node.c	2005-01-10 13:54:50.000000000 -0800
@@ -42,13 +42,15 @@
 	unsigned long inactive;
 	unsigned long active;
 	unsigned long free;
+	unsigned long zero;

 	si_meminfo_node(&i, nid);
-	__get_zone_counts(&active, &inactive, &free, NODE_DATA(nid));
+	__get_zone_counts(&active, &inactive, &free, &zero, NODE_DATA(nid));

 	n = sprintf(buf, "\n"
 		       "Node %d MemTotal:     %8lu kB\n"
 		       "Node %d MemFree:      %8lu kB\n"
+		       "Node %d MemZero:      %8lu kB\n"
 		       "Node %d MemUsed:      %8lu kB\n"
 		       "Node %d Active:       %8lu kB\n"
 		       "Node %d Inactive:     %8lu kB\n"
@@ -58,6 +60,7 @@
 		       "Node %d LowFree:      %8lu kB\n",
 		       nid, K(i.totalram),
 		       nid, K(i.freeram),
+		       nid, K(zero),
 		       nid, K(i.totalram - i.freeram),
 		       nid, K(active),
 		       nid, K(inactive),
Index: linux-2.6.10/include/linux/sched.h
===================================================================
--- linux-2.6.10.orig/include/linux/sched.h	2005-01-10 13:48:11.000000000 -0800
+++ linux-2.6.10/include/linux/sched.h	2005-01-10 13:54:50.000000000 -0800
@@ -731,6 +731,7 @@
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
+#define PF_KSCRUBD	0x00800000	/* I am kscrubd */

 #ifdef CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, cpumask_t new_mask);
Index: linux-2.6.10/mm/Makefile
===================================================================
--- linux-2.6.10.orig/mm/Makefile	2005-01-10 13:48:11.000000000 -0800
+++ linux-2.6.10/mm/Makefile	2005-01-10 13:54:50.000000000 -0800
@@ -5,7 +5,7 @@
 mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= fremap.o highmem.o madvise.o memory.o mincore.o \
 			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o \
-			   vmalloc.o
+			   vmalloc.o scrubd.o

 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o \
Index: linux-2.6.10/mm/scrubd.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10/mm/scrubd.c	2005-01-10 14:56:20.000000000 -0800
@@ -0,0 +1,134 @@
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/highmem.h>
+#include <linux/file.h>
+#include <linux/suspend.h>
+#include <linux/sysctl.h>
+#include <linux/scrub.h>
+
+unsigned int sysctl_scrub_start = 5;	/* if a page of this order is coalesed then run kscrubd */
+unsigned int sysctl_scrub_stop = 2;	/* Mininum order of page to zero */
+unsigned int sysctl_scrub_load = 999;	/* Do not run scrubd if load > */
+
+/*
+ * sysctl handler for /proc/sys/vm/scrub_start
+ */
+int scrub_start_handler(ctl_table *table, int write,
+	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
+{
+	proc_dointvec(table, write, file, buffer, length, ppos);
+	if (sysctl_scrub_start < MAX_ORDER) {
+		struct zone *zone;
+
+		for_each_zone(zone)
+			wakeup_kscrubd(zone);
+	}
+	return 0;
+}
+
+LIST_HEAD(zero_drivers);
+
+/*
+ * zero_highest_order_page takes a page off the freelist
+ * and then hands it off to block zeroing agents.
+ * The cleared pages are added to the back of
+ * the freelist where the page allocator may pick them up.
+ */
+int zero_highest_order_page(struct zone *z)
+{
+	int order;
+
+	for(order = MAX_ORDER-1; order >= sysctl_scrub_stop; order--) {
+		struct free_area *area = z->free_area[NOT_ZEROED] + order;
+		if (!list_empty(&area->free_list)) {
+			struct page *page = scrubd_rmpage(z, area);
+			struct list_head *l;
+			int size = PAGE_SIZE << order;
+
+			if (!page)
+				continue;
+
+			list_for_each(l, &zero_drivers) {
+				struct zero_driver *driver = list_entry(l, struct zero_driver, list);
+
+				if (driver->start(page_address(page), size) == 0)
+					goto done;
+			}
+
+			/* Unable to find a zeroing device that would
+			 * deal with this page so just do it on our own.
+			 * This will likely thrash the cpu caches.
+			 */
+			cond_resched();
+			prep_zero_page(page, order);
+done:
+			end_zero_page(page, order);
+			cond_resched();
+			return 1 << order;
+		}
+	}
+	return 0;
+}
+
+/*
+ * scrub_pgdat() will work across all this node's zones.
+ */
+static void scrub_pgdat(pg_data_t *pgdat)
+{
+	int i;
+	unsigned long pages_zeroed;
+
+	if (system_state != SYSTEM_RUNNING)
+		return;
+
+	do {
+		pages_zeroed = 0;
+		for (i = 0; i < pgdat->nr_zones; i++) {
+			struct zone *zone = pgdat->node_zones + i;
+
+			pages_zeroed += zero_highest_order_page(zone);
+		}
+	} while (pages_zeroed);
+}
+
+/*
+ * The background scrub daemon, started as a kernel thread
+ * from the init process.
+ */
+static int kscrubd(void *p)
+{
+	pg_data_t *pgdat = (pg_data_t*)p;
+	struct task_struct *tsk = current;
+	DEFINE_WAIT(wait);
+	cpumask_t cpumask;
+
+	daemonize("kscrubd%d", pgdat->node_id);
+	cpumask = node_to_cpumask(pgdat->node_id);
+	if (!cpus_empty(cpumask))
+		set_cpus_allowed(tsk, cpumask);
+
+	tsk->flags |= PF_MEMALLOC | PF_KSCRUBD;
+
+	for ( ; ; ) {
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
+		prepare_to_wait(&pgdat->kscrubd_wait, &wait, TASK_INTERRUPTIBLE);
+		schedule();
+		finish_wait(&pgdat->kscrubd_wait, &wait);
+
+		scrub_pgdat(pgdat);
+	}
+	return 0;
+}
+
+static int __init kscrubd_init(void)
+{
+	pg_data_t *pgdat;
+	for_each_pgdat(pgdat)
+		pgdat->kscrubd
+		= find_task_by_pid(kernel_thread(kscrubd, pgdat, CLONE_KERNEL));
+	return 0;
+}
+
+module_init(kscrubd_init)
Index: linux-2.6.10/include/linux/scrub.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10/include/linux/scrub.h	2005-01-10 14:34:25.000000000 -0800
@@ -0,0 +1,49 @@
+#ifndef _LINUX_SCRUB_H
+#define _LINUX_SCRUB_H
+
+/*
+ * Definitions for scrubbing of memory include an interface
+ * for drivers that may that allow the zeroing of memory
+ * without invalidating the caches.
+ *
+ * Christoph Lameter, December 2004.
+ */
+
+struct zero_driver {
+        int (*start)(void *, unsigned long);		/* Start bzero transfer */
+        struct list_head list;
+};
+
+extern struct list_head zero_drivers;
+
+extern unsigned int sysctl_scrub_start;
+extern unsigned int sysctl_scrub_stop;
+extern unsigned int sysctl_scrub_load;
+
+/* Registering and unregistering zero drivers */
+static inline void register_zero_driver(struct zero_driver *z)
+{
+	list_add(&z->list, &zero_drivers);
+}
+
+static inline void unregister_zero_driver(struct zero_driver *z)
+{
+	list_del(&z->list);
+}
+
+extern struct page *scrubd_rmpage(struct zone *zone, struct free_area *area);
+
+static void inline wakeup_kscrubd(struct zone *zone)
+{
+        if (avenrun[0] >= ((unsigned long)sysctl_scrub_load << FSHIFT))
+		return;
+	if (!waitqueue_active(&zone->zone_pgdat->kscrubd_wait))
+                return;
+        wake_up_interruptible(&zone->zone_pgdat->kscrubd_wait);
+}
+
+int scrub_start_handler(struct ctl_table *, int, struct file *,
+				      void __user *, size_t *, loff_t *);
+
+extern void end_zero_page(struct page *page, unsigned int order);
+#endif
Index: linux-2.6.10/kernel/sysctl.c
===================================================================
--- linux-2.6.10.orig/kernel/sysctl.c	2005-01-10 13:48:11.000000000 -0800
+++ linux-2.6.10/kernel/sysctl.c	2005-01-10 13:54:50.000000000 -0800
@@ -40,6 +40,7 @@
 #include <linux/times.h>
 #include <linux/limits.h>
 #include <linux/dcache.h>
+#include <linux/scrub.h>
 #include <linux/syscalls.h>

 #include <asm/uaccess.h>
@@ -827,6 +828,33 @@
 		.strategy	= &sysctl_jiffies,
 	},
 #endif
+	{
+		.ctl_name	= VM_SCRUB_START,
+		.procname	= "scrub_start",
+		.data		= &sysctl_scrub_start,
+		.maxlen		= sizeof(sysctl_scrub_start),
+		.mode		= 0644,
+		.proc_handler	= &scrub_start_handler,
+		.strategy	= &sysctl_intvec,
+	},
+	{
+		.ctl_name	= VM_SCRUB_STOP,
+		.procname	= "scrub_stop",
+		.data		= &sysctl_scrub_stop,
+		.maxlen		= sizeof(sysctl_scrub_stop),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+	},
+	{
+		.ctl_name	= VM_SCRUB_LOAD,
+		.procname	= "scrub_load",
+		.data		= &sysctl_scrub_load,
+		.maxlen		= sizeof(sysctl_scrub_load),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+	},
 	{ .ctl_name = 0 }
 };

Index: linux-2.6.10/include/linux/sysctl.h
===================================================================
--- linux-2.6.10.orig/include/linux/sysctl.h	2005-01-10 13:48:11.000000000 -0800
+++ linux-2.6.10/include/linux/sysctl.h	2005-01-10 13:54:50.000000000 -0800
@@ -169,6 +169,9 @@
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_SCRUB_START=30,	/* percentage * 10 at which to start scrubd */
+	VM_SCRUB_STOP=31,	/* percentage * 10 at which to stop scrubd */
+	VM_SCRUB_LOAD=32,	/* Load factor at which not to scrub anymore */
 };


Index: linux-2.6.10/include/linux/gfp.h
===================================================================
--- linux-2.6.10.orig/include/linux/gfp.h	2005-01-10 13:48:11.000000000 -0800
+++ linux-2.6.10/include/linux/gfp.h	2005-01-10 13:54:50.000000000 -0800
@@ -132,4 +132,5 @@

 void page_alloc_init(void);

+void prep_zero_page(struct page *, unsigned int order);
 #endif /* __LINUX_GFP_H */

