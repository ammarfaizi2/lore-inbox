Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVCQVqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVCQVqv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 16:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVCQVqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 16:46:51 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:15550 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261166AbVCQVnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 16:43:53 -0500
Date: Thu, 17 Mar 2005 13:43:47 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Prezeroing V8
Message-ID: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
- Drop clear_pages and the approach to zero pages of higher order
  first
- Zero a percentage of pages from all orders to avoid fragmentation

Adds management of ZEROED and NOT_ZEROED pages and a background daemon
called scrubd. /proc/sys/vm/scrubd_load, /proc/sys/vm_scrubd_start and
/proc/sys/vm_scrubd_stop control the scrub daemon. See Documentation/vm/
scrubd.txt

In an SMP environment the scrub daemon is typically running on the most
idle cpu. Thus a single threaded application running
on one cpu may have the other cpu zeroing pages for it etc. The scrub
daemon is hardly noticable and usually finishes zeroing quickly since
most processors are optimized for linear memory filling.

Patch against 2.6.11.3-bk3

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.11/mm/page_alloc.c
===================================================================
--- linux-2.6.11.orig/mm/page_alloc.c	2005-03-17 11:31:54.000000000 -0800
+++ linux-2.6.11/mm/page_alloc.c	2005-03-17 12:23:15.000000000 -0800
@@ -12,6 +12,8 @@
  *  Zone balancing, Kanoj Sarcar, SGI, Jan 2000
  *  Per cpu hot/cold page lists, bulk allocation, Martin J. Bligh, Sept 2002
  *          (lots of bits borrowed from Ingo Molnar & Andrew Morton)
+ *  Page zeroing by Christoph Lameter, SGI, Dec 2004 using
+ *	initial code for __GFP_ZERO support by Andrea Arcangeli, Oct 2004.
  */

 #include <linux/config.h>
@@ -34,6 +36,7 @@
 #include <linux/cpuset.h>
 #include <linux/nodemask.h>
 #include <linux/vmalloc.h>
+#include <linux/scrub.h>

 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -180,16 +183,16 @@ static void destroy_compound_page(struct
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
@@ -231,14 +234,15 @@ __find_combined_index(unsigned long page
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
@@ -270,7 +274,7 @@ static inline int page_is_buddy(struct p
  */

 static inline void __free_pages_bulk (struct page *page,
-		struct zone *zone, unsigned int order)
+		struct zone *zone, unsigned int order, unsigned int zero)
 {
 	unsigned long page_idx;
 	int order_size = 1 << order;
@@ -283,7 +287,6 @@ static inline void __free_pages_bulk (st
 	BUG_ON(page_idx & (order_size - 1));
 	BUG_ON(bad_range(zone, page));

-	zone->free_pages += order_size;
 	while (order < MAX_ORDER-1) {
 		unsigned long combined_idx;
 		struct free_area *area;
@@ -294,19 +297,19 @@ static inline void __free_pages_bulk (st

 		if (bad_range(zone, buddy))
 			break;
-		if (!page_is_buddy(buddy, order))
+		if (!page_is_buddy(buddy, order, zero))
 			break;		/* Move the buddy up one level. */
 		list_del(&buddy->lru);
-		area = zone->free_area + order;
+		area = zone->free_area[zero] + order;
 		area->nr_free--;
-		rmv_page_order(buddy);
+		rmv_page_zorder(buddy);
 		page = page + (combined_idx - page_idx);
 		page_idx = combined_idx;
 		order++;
 	}
-	set_page_order(page, order);
-	list_add(&page->lru, &zone->free_area[order].free_list);
-	zone->free_area[order].nr_free++;
+	set_page_zorder(page, order, zero);
+	list_add(&page->lru, &zone->free_area[zero][order].free_list);
+	zone->free_area[zero][order].nr_free++;
 }

 static inline void free_pages_check(const char *function, struct page *page)
@@ -354,10 +357,15 @@ free_pages_bulk(struct zone *zone, int c
 		page = list_entry(list->prev, struct page, lru);
 		/* have to delete it as __free_pages_bulk list manipulates */
 		list_del(&page->lru);
-		__free_pages_bulk(page, zone, order);
+		__free_pages_bulk(page, zone, order, NOT_ZEROED);
 		ret++;
+		zone->free_pages += 1UL << order;
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
+#ifdef CONFIG_SCRUBD
+	if (zone->zero_pages < ((zone->free_pages*sysctl_scrub_start) >> 10))
+			wakeup_kscrubd(zone);
+#endif
 	return ret;
 }

@@ -383,6 +391,20 @@ void __free_pages_ok(struct page *page,
 	free_pages_bulk(page_zone(page), 1, &list, order);
 }

+#ifdef CONFIG_SCRUBD
+void end_zero_page(struct page *page, unsigned int order)
+{
+	unsigned long flags;
+	struct zone * zone = page_zone(page);
+
+	spin_lock_irqsave(&zone->lock, flags);
+
+	__free_pages_bulk(page, zone, order, ZEROED);
+	zone->zero_pages += 1UL << order;
+
+	spin_unlock_irqrestore(&zone->lock, flags);
+}
+#endif

 /*
  * The order of subdivision here is critical for the IO subsystem.
@@ -400,7 +422,7 @@ void __free_pages_ok(struct page *page,
  */
 static inline struct page *
 expand(struct zone *zone, struct page *page,
- 	int low, int high, struct free_area *area)
+ 	int low, int high, struct free_area *area, int zero)
 {
 	unsigned long size = 1 << high;

@@ -411,7 +433,7 @@ expand(struct zone *zone, struct page *p
 		BUG_ON(bad_range(zone, &page[size]));
 		list_add(&page[size].lru, &area->free_list);
 		area->nr_free++;
-		set_page_order(&page[size], high);
+		set_page_zorder(&page[size], high, zero);
 	}
 	return page;
 }
@@ -462,23 +484,46 @@ static void prep_new_page(struct page *p
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
+#ifdef CONFIG_SCRUBD
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
+#endif
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
@@ -490,7 +535,7 @@ static struct page *__rmqueue(struct zon
  * Returns the number of new pages which were placed at *list.
  */
 static int rmqueue_bulk(struct zone *zone, unsigned int order,
-			unsigned long count, struct list_head *list)
+			unsigned long count, struct list_head *list, int zero)
 {
 	unsigned long flags;
 	int i;
@@ -499,7 +544,7 @@ static int rmqueue_bulk(struct zone *zon

 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, zero);
 		if (page == NULL)
 			break;
 		allocated++;
@@ -546,7 +591,7 @@ void mark_free_pages(struct zone *zone)
 		ClearPageNosaveFree(pfn_to_page(zone_pfn + zone->zone_start_pfn));

 	for (order = MAX_ORDER - 1; order >= 0; --order)
-		list_for_each(curr, &zone->free_area[order].free_list) {
+		list_for_each(curr, &zone->free_area[NOT_ZEROED][order].free_list) {
 			unsigned long start_pfn, i;

 			start_pfn = page_to_pfn(list_entry(curr, struct page, lru));
@@ -633,7 +678,7 @@ void fastcall free_cold_page(struct page
 	free_hot_cold_page(page, 1);
 }

-static inline void prep_zero_page(struct page *page, int order, int gfp_flags)
+void prep_zero_page(struct page *page, int order, int gfp_flags)
 {
 	int i;

@@ -652,7 +697,9 @@ buffered_rmqueue(struct zone *zone, int
 {
 	unsigned long flags;
 	struct page *page = NULL;
-	int cold = !!(gfp_flags & __GFP_COLD);
+	int nr_pages = 1 << order;
+	int zero = !!((gfp_flags & __GFP_ZERO) && zone->zero_pages >= nr_pages);
+	int cold = !!(gfp_flags & __GFP_COLD) + 2*zero;

 	if (order == 0) {
 		struct per_cpu_pages *pcp;
@@ -661,7 +708,7 @@ buffered_rmqueue(struct zone *zone, int
 		local_irq_save(flags);
 		if (pcp->count <= pcp->low)
 			pcp->count += rmqueue_bulk(zone, 0,
-						pcp->batch, &pcp->list);
+						pcp->batch, &pcp->list, zero);
 		if (pcp->count) {
 			page = list_entry(pcp->list.next, struct page, lru);
 			list_del(&page->lru);
@@ -673,16 +720,25 @@ buffered_rmqueue(struct zone *zone, int

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
 			prep_zero_page(page, order, gfp_flags);

 		if (order && (gfp_flags & __GFP_COMP))
@@ -711,7 +767,7 @@ int zone_watermark_ok(struct zone *z, in
 		return 0;
 	for (o = 0; o < order; o++) {
 		/* At the next order, this order's pages become unavailable */
-		free_pages -= z->free_area[o].nr_free << o;
+		free_pages -= (z->free_area[NOT_ZEROED][o].nr_free + z->free_area[ZEROED][o].nr_free)  << o;

 		/* Require fewer higher order pages to be free */
 		min >>= 1;
@@ -1133,7 +1189,7 @@ void __mod_page_state(unsigned offset, u
 EXPORT_SYMBOL(__mod_page_state);

 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
-			unsigned long *free, struct pglist_data *pgdat)
+			unsigned long *free, unsigned long *zero, struct pglist_data *pgdat)
 {
 	struct zone *zones = pgdat->node_zones;
 	int i;
@@ -1141,27 +1197,31 @@ void __get_zone_counts(unsigned long *ac
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

@@ -1198,6 +1258,7 @@ void si_meminfo_node(struct sysinfo *val

 #define K(x) ((x) << (PAGE_SHIFT-10))

+const char *temp[3] = { "hot", "cold", "zero" };
 /*
  * Show free area list (used inside shift_scroll-lock stuff)
  * We also calculate the percentage fragmentation. We do this by counting the
@@ -1210,6 +1271,7 @@ void show_free_areas(void)
 	unsigned long active;
 	unsigned long inactive;
 	unsigned long free;
+	unsigned long zero;
 	struct zone *zone;

 	for_each_zone(zone) {
@@ -1230,10 +1292,10 @@ void show_free_areas(void)

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
@@ -1241,20 +1303,21 @@ void show_free_areas(void)
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
@@ -1303,7 +1366,7 @@ void show_free_areas(void)

 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order < MAX_ORDER; order++) {
-			nr = zone->free_area[order].nr_free;
+			nr = zone->free_area[NOT_ZEROED][order].nr_free + zone->free_area[ZEROED][order].nr_free;
 			total += nr << order;
 			printk("%lu*%lukB ", nr, K(1UL) << order);
 		}
@@ -1602,8 +1665,10 @@ void zone_init_free_lists(struct pglist_
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

@@ -1628,6 +1693,7 @@ static void __init free_area_init_core(s

 	pgdat->nr_zones = 0;
 	init_waitqueue_head(&pgdat->kswapd_wait);
+	init_waitqueue_head(&pgdat->kscrubd_wait);
 	pgdat->kswapd_max_order = 0;

 	for (j = 0; j < MAX_NR_ZONES; j++) {
@@ -1651,6 +1717,7 @@ static void __init free_area_init_core(s
 		spin_lock_init(&zone->lru_lock);
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
+		zone->zero_pages = 0;

 		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;

@@ -1684,6 +1751,13 @@ static void __init free_area_init_core(s
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
@@ -1819,7 +1893,10 @@ static int frag_show(struct seq_file *m,
 		spin_lock_irqsave(&zone->lock, flags);
 		seq_printf(m, "Node %d, zone %8s ", pgdat->node_id, zone->name);
 		for (order = 0; order < MAX_ORDER; ++order)
-			seq_printf(m, "%6lu ", zone->free_area[order].nr_free);
+			seq_printf(m, "%6lu ", zone->free_area[NOT_ZEROED][order].nr_free);
+		seq_printf(m, "\n        Zeroed Pages  ");
+		for (order = 0; order < MAX_ORDER; ++order)
+			seq_printf(m, "%6lu ", zone->free_area[ZEROED][order].nr_free);
 		spin_unlock_irqrestore(&zone->lock, flags);
 		seq_putc(m, '\n');
 	}
Index: linux-2.6.11/include/linux/mmzone.h
===================================================================
--- linux-2.6.11.orig/include/linux/mmzone.h	2005-03-17 11:31:53.000000000 -0800
+++ linux-2.6.11/include/linux/mmzone.h	2005-03-17 11:55:07.000000000 -0800
@@ -52,7 +52,7 @@ struct per_cpu_pages {
 };

 struct per_cpu_pageset {
-	struct per_cpu_pages pcp[2];	/* 0: hot.  1: cold */
+	struct per_cpu_pages pcp[3];	/* 0: hot.  1: cold  2: cold zeroed pages */
 #ifdef CONFIG_NUMA
 	unsigned long numa_hit;		/* allocated in intended node */
 	unsigned long numa_miss;	/* allocated in non intended node */
@@ -108,10 +108,14 @@ struct per_cpu_pageset {
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
 	 * We don't know if the memory that we're going to allocate will be freeable
 	 * or/and it will be released eventually, so to avoid totally wasting several
@@ -128,7 +132,7 @@ struct zone {
 	 * free areas of different sizes
 	 */
 	spinlock_t		lock;
-	struct free_area	free_area[MAX_ORDER];
+	struct free_area	free_area[2][MAX_ORDER];


 	ZONE_PADDING(_pad1_)
@@ -263,6 +267,9 @@ typedef struct pglist_data {
 	wait_queue_head_t kswapd_wait;
 	struct task_struct *kswapd;
 	int kswapd_max_order;
+
+	wait_queue_head_t       kscrubd_wait;
+	struct task_struct *kscrubd;
 } pg_data_t;

 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
@@ -271,9 +278,9 @@ typedef struct pglist_data {
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
Index: linux-2.6.11/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.11.orig/fs/proc/proc_misc.c	2005-03-17 11:31:53.000000000 -0800
+++ linux-2.6.11/fs/proc/proc_misc.c	2005-03-17 11:55:07.000000000 -0800
@@ -123,12 +123,13 @@ static int meminfo_read_proc(char *page,
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
@@ -148,6 +149,7 @@ static int meminfo_read_proc(char *page,
 	len = sprintf(page,
 		"MemTotal:     %8lu kB\n"
 		"MemFree:      %8lu kB\n"
+		"MemZero:      %8lu kB\n"
 		"Buffers:      %8lu kB\n"
 		"Cached:       %8lu kB\n"
 		"SwapCached:   %8lu kB\n"
@@ -171,6 +173,7 @@ static int meminfo_read_proc(char *page,
 		"VmallocChunk: %8lu kB\n",
 		K(i.totalram),
 		K(i.freeram),
+		K(zero),
 		K(i.bufferram),
 		K(get_page_cache_size()-total_swapcache_pages-i.bufferram),
 		K(total_swapcache_pages),
Index: linux-2.6.11/mm/readahead.c
===================================================================
--- linux-2.6.11.orig/mm/readahead.c	2005-03-17 11:31:54.000000000 -0800
+++ linux-2.6.11/mm/readahead.c	2005-03-17 11:55:07.000000000 -0800
@@ -550,7 +550,8 @@ unsigned long max_sane_readahead(unsigne
 	unsigned long active;
 	unsigned long inactive;
 	unsigned long free;
+	unsigned long zero;

-	__get_zone_counts(&active, &inactive, &free, NODE_DATA(numa_node_id()));
+	__get_zone_counts(&active, &inactive, &free, &zero, NODE_DATA(numa_node_id()));
 	return min(nr, (inactive + free) / 2);
 }
Index: linux-2.6.11/drivers/base/node.c
===================================================================
--- linux-2.6.11.orig/drivers/base/node.c	2005-03-01 23:37:49.000000000 -0800
+++ linux-2.6.11/drivers/base/node.c	2005-03-17 11:55:07.000000000 -0800
@@ -42,13 +42,15 @@ static ssize_t node_read_meminfo(struct
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
@@ -58,6 +60,7 @@ static ssize_t node_read_meminfo(struct
 		       "Node %d LowFree:      %8lu kB\n",
 		       nid, K(i.totalram),
 		       nid, K(i.freeram),
+		       nid, K(zero),
 		       nid, K(i.totalram - i.freeram),
 		       nid, K(active),
 		       nid, K(inactive),
Index: linux-2.6.11/include/linux/sched.h
===================================================================
--- linux-2.6.11.orig/include/linux/sched.h	2005-03-17 11:31:54.000000000 -0800
+++ linux-2.6.11/include/linux/sched.h	2005-03-17 11:55:07.000000000 -0800
@@ -778,7 +778,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
 #define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
-
+#define PF_KSCRUBD	0x01000000      /* I am kscrubd */
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
  * tasks can access tsk->flags in readonly mode for example
Index: linux-2.6.11/mm/Makefile
===================================================================
--- linux-2.6.11.orig/mm/Makefile	2005-03-01 23:38:12.000000000 -0800
+++ linux-2.6.11/mm/Makefile	2005-03-17 11:55:07.000000000 -0800
@@ -17,4 +17,5 @@ obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SHMEM) += shmem.o
 obj-$(CONFIG_TINY_SHMEM) += tiny-shmem.o
+obj-$(CONFIG_SCRUBD) += scrubd.o

Index: linux-2.6.11/mm/scrubd.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11/mm/scrubd.c	2005-03-17 13:12:23.000000000 -0800
@@ -0,0 +1,138 @@
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/highmem.h>
+#include <linux/file.h>
+#include <linux/suspend.h>
+#include <linux/sysctl.h>
+#include <linux/scrub.h>
+
+unsigned int sysctl_scrub_start = 100;	/* Min percentage of zeroed free pages per zone (~10% default) */
+unsigned int sysctl_scrub_stop = 300;	/* Max percentage of zeroed free pages per zone (~30% default) */
+unsigned int sysctl_scrub_load = 1;	/* Do not run scrubd if load > */
+
+/*
+ * sysctl handler for /proc/sys/vm/scrub_start
+ */
+int scrub_start_handler(ctl_table *table, int write,
+	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
+{
+	proc_dointvec(table, write, file, buffer, length, ppos);
+	if (sysctl_scrub_start < 1000) {
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
+static inline void remove_one(struct zone *z, struct free_area *area, int order)
+{
+	struct list_head *l;
+	struct page *page;
+	int size;
+
+	page = scrubd_rmpage(z, area);
+	size = PAGE_SIZE << order;
+
+	if (!page)
+		return;
+
+	list_for_each(l, &zero_drivers) {
+		struct zero_driver *driver = list_entry(l, struct zero_driver, list);
+
+		if (driver->start(page_address(page), size) == 0)
+			goto done;
+	}
+
+	/* Unable to find a zeroing device that would
+	 * deal with this page so just do it on our own.
+	 * This will likely thrash the cpu caches.
+	 */
+	cond_resched();
+	prep_zero_page(page, order, 0);
+done:
+	end_zero_page(page, order);
+	cond_resched();
+}
+
+/*
+ * zero_zone insures that a zone has the wanted percentage
+ * of zeroed pages
+ */
+static inline void zero_zone(struct zone *z)
+{
+	int order;
+
+	/* Zeroed page are typically used as order 0 pages by the page fault
+	 * handler. Start with order zero and then work upward.
+	 */
+	for(order = 0; order < MAX_ORDER; order++) {
+		struct free_area *area = z->free_area[NOT_ZEROED] + order;
+		struct free_area *zarea = z->free_area[ZEROED] + order;
+
+		/* Zero a percentage of the pages of this order */
+		while (!list_empty(&area->free_list) && zarea->nr_free < ((area->nr_free*sysctl_scrub_stop) >> 10))
+			remove_one(z, area,  order);
+	}
+}
+
+/*
+ * scrub_pgdat() will work across all this node's zones.
+ */
+static void scrub_pgdat(pg_data_t *pgdat)
+{
+	int i;
+
+	if (system_state != SYSTEM_RUNNING)
+		return;
+
+        while (avenrun[0] >= ((unsigned long)sysctl_scrub_load << FSHIFT))
+		schedule_timeout(30*HZ);
+
+	for (i = 0; i < pgdat->nr_zones; i++)
+		zero_zone(pgdat->node_zones +i);
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
+	for (;;) {
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
+		pgdat->kscrubd = find_task_by_pid(kernel_thread(kscrubd, pgdat, CLONE_KERNEL));
+	return 0;
+}
+
+module_init(kscrubd_init)
Index: linux-2.6.11/include/linux/scrub.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11/include/linux/scrub.h	2005-03-17 13:20:03.000000000 -0800
@@ -0,0 +1,50 @@
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
+#ifdef CONFIG_SCRUBD
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
+	if (!waitqueue_active(&zone->zone_pgdat->kscrubd_wait))
+                return;
+        wake_up_interruptible(&zone->zone_pgdat->kscrubd_wait);
+}
+
+int scrub_start_handler(struct ctl_table *, int, struct file *,
+				      void __user *, size_t *, loff_t *);
+
+extern void end_zero_page(struct page *page, unsigned int order);
+void prep_zero_page(struct page *page, int order, int gfp_flags);
+
+#endif
+#endif
Index: linux-2.6.11/kernel/sysctl.c
===================================================================
--- linux-2.6.11.orig/kernel/sysctl.c	2005-03-17 11:31:54.000000000 -0800
+++ linux-2.6.11/kernel/sysctl.c	2005-03-17 11:55:07.000000000 -0800
@@ -40,6 +40,7 @@
 #include <linux/times.h>
 #include <linux/limits.h>
 #include <linux/dcache.h>
+#include <linux/scrub.h>
 #include <linux/syscalls.h>

 #include <asm/uaccess.h>
@@ -836,6 +837,35 @@ static ctl_table vm_table[] = {
 		.strategy	= &sysctl_jiffies,
 	},
 #endif
+#ifdef CONFIG_SCRUBD
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
+#endif
 	{ .ctl_name = 0 }
 };

Index: linux-2.6.11/include/linux/sysctl.h
===================================================================
--- linux-2.6.11.orig/include/linux/sysctl.h	2005-03-17 11:31:54.000000000 -0800
+++ linux-2.6.11/include/linux/sysctl.h	2005-03-17 11:55:07.000000000 -0800
@@ -170,6 +170,9 @@ enum
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_SCRUB_START=30,	/* percentage * 10 at which to start scrubd */
+	VM_SCRUB_STOP=31,	/* percentage * 10 at which to stop scrubd */
+	VM_SCRUB_LOAD=32,	/* Load factor at which not to scrub anymore */
 };


Index: linux-2.6.11/init/Kconfig
===================================================================
--- linux-2.6.11.orig/init/Kconfig	2005-03-17 11:31:54.000000000 -0800
+++ linux-2.6.11/init/Kconfig	2005-03-17 12:52:32.000000000 -0800
@@ -256,6 +256,19 @@ config KALLSYMS_ALL

 	   Say N.

+config SCRUBD
+	bool "Scrub Daemon (prezeroing of pages)"
+	depends on EXPERIMENTAL
+	help
+	   The scrub daemon manages a pool of zeroed pages. Pages of higher
+	   order are zeroed when the system is idle (configurable via
+	   /proc/sys/vm/scrubd_load).
+	   If the kernel later needs a zeroed page then a page may be
+	   obtained from these pools instead of hot-zeroing a paged.
+	   Prezeroing will in particular speed up applications allocating
+	   large amounts of memory and will be effective for sparse
+	   matrices (this includes multi-level page tables).
+
 config KALLSYMS_EXTRA_PASS
 	bool "Do an extra kallsyms pass"
 	depends on KALLSYMS
Index: linux-2.6.11/Documentation/vm/scrubd.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11/Documentation/vm/scrubd.txt	2005-03-17 12:57:41.000000000 -0800
@@ -0,0 +1,59 @@
+The SCRUB Daemon
+----------------
+
+The scrub daemon zeroes memory so that later requests for zeroed memory can
+be satisifed without having to zero memory in a hot code path. The operations
+of scrubd may be controlled through 3 variables in /proc/sys/vm:
+
+/proc/sys/vm/scrubd_load	default value	1
+
+	Scrubd is woken up if the system load is lower than this setting and
+	the numer of unzeroed free pages drops below scrub_start*10 percent.
+	The default setting of 1 insures that there will be no performance
+	degradation in single user mode. In an SMP system a cpu is frequently
+	idle despite the load being high. A setting of 9 or 99 may
+	be useful then.
+
+/proc/sys/vm/scrub_start	default value	100
+
+	This represents a percentage *10. If more than this percentage
+	of free pages are unzeroed then invoke the scrub daemon.
+
+/proc/sys/vm/scrub_stop		default value	300
+
+	Once scrubd starts it will zero all pages until scrub_stop*10
+	percent of the free pages are zeroed. Typically it takes too much time to
+	 zero all pages in the system. If all pages in the system should be zeroed
+	 then this needs to be set to 1000.
+
+The amount of memory that is zeroed may be seen in /proc/meminfo or in
+/proc/buddyinfo.
+
+Zeroing Drivers:
+----------------
+
+If hardware is available that can zero memory without the use of the cpu then a
+driver may be written that can then register itself with
+register_zero_driver(). See include/linux/scrubd.h for details and
+arch/ia64/sn/kernel/bte.c for an example of a zeroing driver)
+
+Performance considerations:
+---------------------------
+
+If there is no zeroing hardware available then zeroing may invalidate the
+cpu cache and is therefore something that may cause a minimal performance loss
+especially since scrubd may zero more pages than necessary. In these situations
+(single processor machines?) it is advisable to run scrubd only when the
+system is truly idle. The default configuration has scrub_load set to 1. This
+means that scrubd only runs when the system load is minimal. Scrubd typically
+completes in a fraction of a second since the zeroing speed of processors is
+quite high.
+
+Scrubd is most effective for memory that is only sparsely accessed. Getting a
+prezeroed page for an application that then immediately overwrites all bytes
+in the page does not lead to any performance improvement. However, if the
+application only uses certain cachelines of the page immediately after a page
+fault then scrubd can be of tremendous benefit.
+
+Christoph Lameter, SGI, February 2005.
+
