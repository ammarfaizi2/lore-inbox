Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVBGTqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVBGTqM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVBGTpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:45:22 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:39085 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261274AbVBGTdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:33:23 -0500
Date: Mon, 7 Feb 2005 11:31:54 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: prezeroing V6 [2/3]: ScrubD
In-Reply-To: <Pine.LNX.4.58.0502071127470.27951@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0502071131260.27951@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
 <1106828124.19262.45.camel@hades.cambridge.redhat.com> <20050202153256.GA19615@logos.cnet>
 <Pine.LNX.4.58.0502071127470.27951@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds management of ZEROED and NOT_ZEROED pages and a background daemon
called scrubd. If a page is coalesced of the order specified in /proc
/sys/scrub_start or higher then the scrub daemon will
start zeroing until all pages of order /proc/sys/vm/scrub_stop and
higher are zeroed and then go back to sleep.

In an SMP environment the scrub daemon is typically
running on the most idle cpu. Thus a single threaded application running
on one cpu may have the other cpu zeroing pages for it etc. The scrub
daemon is hardly noticable and usually finishes zeroing quickly since
most processors are optimized for linear memory filling.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.10/mm/page_alloc.c
===================================================================
--- linux-2.6.10.orig/mm/page_alloc.c	2005-02-03 22:51:57.000000000 -0800
+++ linux-2.6.10/mm/page_alloc.c	2005-02-03 22:52:19.000000000 -0800
@@ -12,6 +12,8 @@
  *  Zone balancing, Kanoj Sarcar, SGI, Jan 2000
  *  Per cpu hot/cold page lists, bulk allocation, Martin J. Bligh, Sept 2002
  *          (lots of bits borrowed from Ingo Molnar & Andrew Morton)
+ *  Page zeroing by Christoph Lameter, SGI, Dec 2004 using
+ *	initial code for __GFP_ZERO support by Andrea Arcangeli, Oct 2004.
  */

 #include <linux/config.h>
@@ -33,6 +35,7 @@
 #include <linux/cpu.h>
 #include <linux/nodemask.h>
 #include <linux/vmalloc.h>
+#include <linux/scrub.h>

 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -175,16 +178,16 @@ static void destroy_compound_page(struct
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
@@ -195,14 +198,15 @@ static inline void rmv_page_order(struct
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
@@ -233,22 +237,20 @@ static inline int page_is_buddy(struct p
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
@@ -258,20 +260,21 @@ static inline void __free_pages_bulk (st
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
@@ -320,8 +323,11 @@ free_pages_bulk(struct zone *zone, int c
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
@@ -349,6 +355,18 @@ void __free_pages_ok(struct page *page,
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
@@ -366,7 +384,7 @@ void __free_pages_ok(struct page *page,
  */
 static inline struct page *
 expand(struct zone *zone, struct page *page,
- 	int low, int high, struct free_area *area)
+ 	int low, int high, struct free_area *area, int zero)
 {
 	unsigned long size = 1 << high;

@@ -377,7 +395,7 @@ expand(struct zone *zone, struct page *p
 		BUG_ON(bad_range(zone, &page[size]));
 		list_add(&page[size].lru, &area->free_list);
 		area->nr_free++;
-		set_page_order(&page[size], high);
+		set_page_zorder(&page[size], high, zero);
 	}
 	return page;
 }
@@ -428,23 +446,44 @@ static void prep_new_page(struct page *p
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
 {
-	struct free_area * area;
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
+{
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
@@ -456,7 +495,7 @@ static struct page *__rmqueue(struct zon
  * Returns the number of new pages which were placed at *list.
  */
 static int rmqueue_bulk(struct zone *zone, unsigned int order,
-			unsigned long count, struct list_head *list)
+			unsigned long count, struct list_head *list, int zero)
 {
 	unsigned long flags;
 	int i;
@@ -465,7 +504,7 @@ static int rmqueue_bulk(struct zone *zon

 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, zero);
 		if (page == NULL)
 			break;
 		allocated++;
@@ -512,7 +551,7 @@ void mark_free_pages(struct zone *zone)
 		ClearPageNosaveFree(pfn_to_page(zone_pfn + zone->zone_start_pfn));

 	for (order = MAX_ORDER - 1; order >= 0; --order)
-		list_for_each(curr, &zone->free_area[order].free_list) {
+		list_for_each(curr, &zone->free_area[NOT_ZEROED][order].free_list) {
 			unsigned long start_pfn, i;

 			start_pfn = page_to_pfn(list_entry(curr, struct page, lru));
@@ -618,7 +657,9 @@ buffered_rmqueue(struct zone *zone, int
 {
 	unsigned long flags;
 	struct page *page = NULL;
-	int cold = !!(gfp_flags & __GFP_COLD);
+	int nr_pages = 1 << order;
+	int zero = !!((gfp_flags & __GFP_ZERO) && zone->zero_pages >= nr_pages);
+	int cold = !!(gfp_flags & __GFP_COLD) + 2*zero;

 	if (order == 0) {
 		struct per_cpu_pages *pcp;
@@ -627,7 +668,7 @@ buffered_rmqueue(struct zone *zone, int
 		local_irq_save(flags);
 		if (pcp->count <= pcp->low)
 			pcp->count += rmqueue_bulk(zone, 0,
-						pcp->batch, &pcp->list);
+						pcp->batch, &pcp->list, zero);
 		if (pcp->count) {
 			page = list_entry(pcp->list.next, struct page, lru);
 			list_del(&page->lru);
@@ -639,16 +680,25 @@ buffered_rmqueue(struct zone *zone, int

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
@@ -677,7 +727,7 @@ int zone_watermark_ok(struct zone *z, in
 		return 0;
 	for (o = 0; o < order; o++) {
 		/* At the next order, this order's pages become unavailable */
-		free_pages -= z->free_area[o].nr_free << o;
+		free_pages -= (z->free_area[NOT_ZEROED][o].nr_free + z->free_area[ZEROED][o].nr_free)  << o;

 		/* Require fewer higher order pages to be free */
 		min >>= 1;
@@ -1085,7 +1135,7 @@ void __mod_page_state(unsigned offset, u
 EXPORT_SYMBOL(__mod_page_state);

 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
-			unsigned long *free, struct pglist_data *pgdat)
+			unsigned long *free, unsigned long *zero, struct pglist_data *pgdat)
 {
 	struct zone *zones = pgdat->node_zones;
 	int i;
@@ -1093,27 +1143,31 @@ void __get_zone_counts(unsigned long *ac
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

@@ -1150,6 +1204,7 @@ void si_meminfo_node(struct sysinfo *val

 #define K(x) ((x) << (PAGE_SHIFT-10))

+const char *temp[3] = { "hot", "cold", "zero" };
 /*
  * Show free area list (used inside shift_scroll-lock stuff)
  * We also calculate the percentage fragmentation. We do this by counting the
@@ -1162,6 +1217,7 @@ void show_free_areas(void)
 	unsigned long active;
 	unsigned long inactive;
 	unsigned long free;
+	unsigned long zero;
 	struct zone *zone;

 	for_each_zone(zone) {
@@ -1182,10 +1238,10 @@ void show_free_areas(void)

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
@@ -1193,20 +1249,21 @@ void show_free_areas(void)
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
@@ -1255,7 +1312,7 @@ void show_free_areas(void)

 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order < MAX_ORDER; order++) {
-			nr = zone->free_area[order].nr_free;
+			nr = zone->free_area[NOT_ZEROED][order].nr_free + zone->free_area[ZEROED][order].nr_free;
 			total += nr << order;
 			printk("%lu*%lukB ", nr, K(1UL) << order);
 		}
@@ -1555,8 +1612,10 @@ void zone_init_free_lists(struct pglist_
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

@@ -1581,6 +1640,7 @@ static void __init free_area_init_core(s

 	pgdat->nr_zones = 0;
 	init_waitqueue_head(&pgdat->kswapd_wait);
+	init_waitqueue_head(&pgdat->kscrubd_wait);
 	pgdat->kswapd_max_order = 0;

 	for (j = 0; j < MAX_NR_ZONES; j++) {
@@ -1604,6 +1664,7 @@ static void __init free_area_init_core(s
 		spin_lock_init(&zone->lru_lock);
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
+		zone->zero_pages = 0;

 		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;

@@ -1637,6 +1698,13 @@ static void __init free_area_init_core(s
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
@@ -1762,7 +1830,10 @@ static int frag_show(struct seq_file *m,
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
Index: linux-2.6.10/include/linux/mmzone.h
===================================================================
--- linux-2.6.10.orig/include/linux/mmzone.h	2005-02-03 22:51:48.000000000 -0800
+++ linux-2.6.10/include/linux/mmzone.h	2005-02-03 22:52:19.000000000 -0800
@@ -51,7 +51,7 @@ struct per_cpu_pages {
 };

 struct per_cpu_pageset {
-	struct per_cpu_pages pcp[2];	/* 0: hot.  1: cold */
+	struct per_cpu_pages pcp[3];	/* 0: hot.  1: cold  2: cold zeroed pages */
 #ifdef CONFIG_NUMA
 	unsigned long numa_hit;		/* allocated in intended node */
 	unsigned long numa_miss;	/* allocated in non intended node */
@@ -107,10 +107,14 @@ struct per_cpu_pageset {
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
@@ -127,7 +131,7 @@ struct zone {
 	 * free areas of different sizes
 	 */
 	spinlock_t		lock;
-	struct free_area	free_area[MAX_ORDER];
+	struct free_area	free_area[2][MAX_ORDER];


 	ZONE_PADDING(_pad1_)
@@ -262,6 +266,9 @@ typedef struct pglist_data {
 	wait_queue_head_t kswapd_wait;
 	struct task_struct *kswapd;
 	int kswapd_max_order;
+
+	wait_queue_head_t       kscrubd_wait;
+	struct task_struct *kscrubd;
 } pg_data_t;

 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
@@ -270,9 +277,9 @@ typedef struct pglist_data {
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
--- linux-2.6.10.orig/fs/proc/proc_misc.c	2005-02-03 22:51:20.000000000 -0800
+++ linux-2.6.10/fs/proc/proc_misc.c	2005-02-03 22:52:19.000000000 -0800
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
Index: linux-2.6.10/mm/readahead.c
===================================================================
--- linux-2.6.10.orig/mm/readahead.c	2005-02-03 22:51:57.000000000 -0800
+++ linux-2.6.10/mm/readahead.c	2005-02-03 22:52:19.000000000 -0800
@@ -573,7 +573,8 @@ unsigned long max_sane_readahead(unsigne
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
--- linux-2.6.10.orig/drivers/base/node.c	2005-02-03 22:50:21.000000000 -0800
+++ linux-2.6.10/drivers/base/node.c	2005-02-03 22:52:19.000000000 -0800
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
Index: linux-2.6.10/include/linux/sched.h
===================================================================
--- linux-2.6.10.orig/include/linux/sched.h	2005-02-03 22:51:50.000000000 -0800
+++ linux-2.6.10/include/linux/sched.h	2005-02-03 22:52:19.000000000 -0800
@@ -735,6 +735,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
+#define PF_KSCRUBD	0x00800000	/* I am kscrubd */

 /*
  * Only the _current_ task can read/write to tsk->flags, but other
Index: linux-2.6.10/mm/Makefile
===================================================================
--- linux-2.6.10.orig/mm/Makefile	2005-02-03 22:51:56.000000000 -0800
+++ linux-2.6.10/mm/Makefile	2005-02-03 22:52:19.000000000 -0800
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
+++ linux-2.6.10/mm/scrubd.c	2005-02-03 23:06:41.000000000 -0800
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
+unsigned int sysctl_scrub_start = 6;	/* if a page of this order is coalesed then run kscrubd */
+unsigned int sysctl_scrub_stop = 4;	/* Mininum order of page to zero */
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
+			prep_zero_page(page, order, 0);
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
+++ linux-2.6.10/include/linux/scrub.h	2005-02-03 22:52:19.000000000 -0800
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
--- linux-2.6.10.orig/kernel/sysctl.c	2005-02-03 22:51:56.000000000 -0800
+++ linux-2.6.10/kernel/sysctl.c	2005-02-03 22:52:19.000000000 -0800
@@ -40,6 +40,7 @@
 #include <linux/times.h>
 #include <linux/limits.h>
 #include <linux/dcache.h>
+#include <linux/scrub.h>
 #include <linux/syscalls.h>

 #include <asm/uaccess.h>
@@ -825,6 +826,33 @@ static ctl_table vm_table[] = {
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
--- linux-2.6.10.orig/include/linux/sysctl.h	2005-02-03 22:51:50.000000000 -0800
+++ linux-2.6.10/include/linux/sysctl.h	2005-02-03 22:52:19.000000000 -0800
@@ -169,6 +169,9 @@ enum
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_SCRUB_START=30,	/* percentage * 10 at which to start scrubd */
+	VM_SCRUB_STOP=31,	/* percentage * 10 at which to stop scrubd */
+	VM_SCRUB_LOAD=32,	/* Load factor at which not to scrub anymore */
 };


Index: linux-2.6.10/include/linux/gfp.h
===================================================================
--- linux-2.6.10.orig/include/linux/gfp.h	2005-02-03 22:51:46.000000000 -0800
+++ linux-2.6.10/include/linux/gfp.h	2005-02-03 22:52:19.000000000 -0800
@@ -131,4 +131,5 @@ extern void FASTCALL(free_cold_page(stru

 void page_alloc_init(void);

+void prep_zero_page(struct page *, unsigned int order, unsigned int gfp_flags);
 #endif /* __LINUX_GFP_H */

