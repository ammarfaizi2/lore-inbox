Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVADX0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVADX0O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVADXXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:23:16 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36059 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262120AbVADXPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:15:32 -0500
Date: Tue, 4 Jan 2005 15:15:21 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, linux-mm@kvack.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Prezeroing V3 [3/4]: Page zeroing through kscrubd 
In-Reply-To: <Pine.LNX.4.58.0501041510430.1536@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0501041514340.1536@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
 <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231133130.31791@schroedinger.engr.sgi.com>
 <Pine.GSO.4.61.0501011123550.27452@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0501041510430.1536@schroedinger.engr.sgi.com>
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
--- linux-2.6.10.orig/mm/page_alloc.c	2005-01-04 14:17:01.000000000 -0800
+++ linux-2.6.10/mm/page_alloc.c	2005-01-04 14:17:02.000000000 -0800
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

@@ -180,7 +182,7 @@
  * -- wli
  */

-static inline void __free_pages_bulk (struct page *page, struct page *base,
+static inline int __free_pages_bulk (struct page *page, struct page *base,
 		struct zone *zone, struct free_area *area, unsigned int order)
 {
 	unsigned long page_idx, index, mask;
@@ -193,11 +195,10 @@
 		BUG();
 	index = page_idx >> (1 + order);

-	zone->free_pages += 1 << order;
 	while (order < MAX_ORDER-1) {
 		struct page *buddy1, *buddy2;

-		BUG_ON(area >= zone->free_area + MAX_ORDER);
+		BUG_ON(area >= zone->free_area[ZEROED] + MAX_ORDER);
 		if (!__test_and_change_bit(index, area->map))
 			/*
 			 * the buddy page is still allocated.
@@ -219,6 +220,7 @@
 	}
 	list_add(&(base + page_idx)->lru, &area->free_list);
 	area->nr_free++;
+	return order;
 }

 static inline void free_pages_check(const char *function, struct page *page)
@@ -261,7 +263,7 @@
 	int ret = 0;

 	base = zone->zone_mem_map;
-	area = zone->free_area + order;
+	area = zone->free_area[NOT_ZEROED] + order;
 	spin_lock_irqsave(&zone->lock, flags);
 	zone->all_unreclaimable = 0;
 	zone->pages_scanned = 0;
@@ -269,7 +271,10 @@
 		page = list_entry(list->prev, struct page, lru);
 		/* have to delete it as __free_pages_bulk list manipulates */
 		list_del(&page->lru);
-		__free_pages_bulk(page, base, zone, area, order);
+		zone->free_pages += 1 << order;
+		if (__free_pages_bulk(page, base, zone, area, order)
+			>= sysctl_scrub_start)
+				wakeup_kscrubd(zone);
 		ret++;
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
@@ -291,6 +296,21 @@
 	free_pages_bulk(page_zone(page), 1, &list, order);
 }

+void end_zero_page(struct page *page)
+{
+	unsigned long flags;
+	int order = page->index;
+	struct zone * zone = page_zone(page);
+
+	spin_lock_irqsave(&zone->lock, flags);
+
+	zone->zero_pages += 1 << order;
+	__free_pages_bulk(page, zone->zone_mem_map, zone, zone->free_area[ZEROED] + order, order);
+
+	spin_unlock_irqrestore(&zone->lock, flags);
+}
+
+
 #define MARK_USED(index, order, area) \
 	__change_bit((index) >> (1+(order)), (area)->map)

@@ -370,26 +390,47 @@
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
  */
-static struct page *__rmqueue(struct zone *zone, unsigned int order)
+static void inline rmpage(struct page *page, struct zone *zone, struct free_area *area, int order)
+{
+	list_del(&page->lru);
+	area->nr_free--;
+	if (order != MAX_ORDER-1)
+		MARK_USED(page - zone->zone_mem_map, order, area);
+}
+
+struct page *scrubd_rmpage(struct zone *zone, struct free_area *area, int order)
+{
+	unsigned long flags;
+	struct page *page = NULL;
+
+	spin_lock_irqsave(&zone->lock, flags);
+
+	if (!list_empty(&area->free_list)) {
+		page = list_entry(area->free_list.next, struct page, lru);
+
+		rmpage(page, zone, area, order);
+	}
+	spin_unlock_irqrestore(&zone->lock, flags);
+	return page;
+}
+
+static struct page *__rmqueue(struct zone *zone, unsigned int order, int zero)
 {
 	struct free_area * area;
 	unsigned int current_order;
 	struct page *page;
-	unsigned int index;

 	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
-		area = zone->free_area + current_order;
+		area = zone->free_area[zero] + current_order;
 		if (list_empty(&area->free_list))
 			continue;

 		page = list_entry(area->free_list.next, struct page, lru);
-		list_del(&page->lru);
-		area->nr_free--;
-		index = page - zone->zone_mem_map;
-		if (current_order != MAX_ORDER-1)
-			MARK_USED(index, current_order, area);
+		rmpage(page, zone, area, current_order);
 		zone->free_pages -= 1UL << order;
-		return expand(zone, page, index, order, current_order, area);
+		if (zero)
+			zone->zero_pages -= 1UL << order;
+		return expand(zone, page, page - zone->zone_mem_map, order, current_order, area);
 	}

 	return NULL;
@@ -401,7 +442,7 @@
  * Returns the number of new pages which were placed at *list.
  */
 static int rmqueue_bulk(struct zone *zone, unsigned int order,
-			unsigned long count, struct list_head *list)
+			unsigned long count, struct list_head *list, int zero)
 {
 	unsigned long flags;
 	int i;
@@ -410,7 +451,7 @@

 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, zero);
 		if (page == NULL)
 			break;
 		allocated++;
@@ -457,7 +498,7 @@
 		ClearPageNosaveFree(pfn_to_page(zone_pfn + zone->zone_start_pfn));

 	for (order = MAX_ORDER - 1; order >= 0; --order)
-		list_for_each(curr, &zone->free_area[order].free_list) {
+		list_for_each(curr, &zone->free_area[NOT_ZEROED][order].free_list) {
 			unsigned long start_pfn, i;

 			start_pfn = page_to_pfn(list_entry(curr, struct page, lru));
@@ -555,7 +596,9 @@
 {
 	unsigned long flags;
 	struct page *page = NULL;
-	int cold = !!(gfp_flags & __GFP_COLD);
+	int nr_pages = 1 << order;
+	int zero = !!((gfp_flags & __GFP_ZERO) && zone->zero_pages >= nr_pages);
+	int cold = !!(gfp_flags & __GFP_COLD) + 2*zero;

 	if (order == 0) {
 		struct per_cpu_pages *pcp;
@@ -564,7 +607,7 @@
 		local_irq_save(flags);
 		if (pcp->count <= pcp->low)
 			pcp->count += rmqueue_bulk(zone, 0,
-						pcp->batch, &pcp->list);
+						pcp->batch, &pcp->list, zero);
 		if (pcp->count) {
 			page = list_entry(pcp->list.next, struct page, lru);
 			list_del(&page->lru);
@@ -576,19 +619,30 @@

 	if (page == NULL) {
 		spin_lock_irqsave(&zone->lock, flags);
-		page = __rmqueue(zone, order);
+
+		page = __rmqueue(zone, order, zero);
+
+		/*
+		 * If we failed to obtain a zero and/or unzeroed page
+		 * then we may still be able to obtain the other
+		 * type of page.
+		 */
+		if (!page) {
+			page = __rmqueue(zone, order, !zero);
+			zero = 0;
+		}
+
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}

 	if (page != NULL) {
 		BUG_ON(bad_range(zone, page));
-		mod_page_state_zone(zone, pgalloc, 1 << order);
-		prep_new_page(page, order);
+		mod_page_state_zone(zone, pgalloc, nr_pages);

-		if (gfp_flags & __GFP_ZERO) {
+		if ((gfp_flags & __GFP_ZERO) && !zero) {
 #ifdef CONFIG_HIGHMEM
 			if (PageHighMem(page)) {
-				int n = 1 << order;
+				int n = nr_pages;

 				while (n-- >0)
 					clear_highpage(page + n);
@@ -596,6 +650,7 @@
 #endif
 			clear_page(page_address(page), order);
 		}
+		prep_new_page(page, order);
 		if (order && (gfp_flags & __GFP_COMP))
 			prep_compound_page(page, order);
 	}
@@ -622,7 +677,7 @@
 		return 0;
 	for (o = 0; o < order; o++) {
 		/* At the next order, this order's pages become unavailable */
-		free_pages -= z->free_area[o].nr_free << o;
+		free_pages -= (z->free_area[NOT_ZEROED][o].nr_free + z->free_area[ZEROED][o].nr_free)  << o;

 		/* Require fewer higher order pages to be free */
 		min >>= 1;
@@ -1000,7 +1055,7 @@
 }

 void __get_zone_counts(unsigned long *active, unsigned long *inactive,
-			unsigned long *free, struct pglist_data *pgdat)
+			unsigned long *free, unsigned long *zero, struct pglist_data *pgdat)
 {
 	struct zone *zones = pgdat->node_zones;
 	int i;
@@ -1008,27 +1063,31 @@
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

@@ -1065,6 +1124,7 @@

 #define K(x) ((x) << (PAGE_SHIFT-10))

+const char *temp[3] = { "hot", "cold", "zero" };
 /*
  * Show free area list (used inside shift_scroll-lock stuff)
  * We also calculate the percentage fragmentation. We do this by counting the
@@ -1077,6 +1137,7 @@
 	unsigned long active;
 	unsigned long inactive;
 	unsigned long free;
+	unsigned long zero;
 	struct zone *zone;

 	for_each_zone(zone) {
@@ -1097,10 +1158,10 @@

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
@@ -1108,20 +1169,21 @@
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
@@ -1170,7 +1232,7 @@

 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order < MAX_ORDER; order++) {
-			nr = zone->free_area[order].nr_free;
+			nr = zone->free_area[NOT_ZEROED][order].nr_free + zone->free_area[ZEROED][order].nr_free;
 			total += nr << order;
 			printk("%lu*%lukB ", nr, K(1UL) << order);
 		}
@@ -1493,16 +1555,21 @@
 	for (order = 0; ; order++) {
 		unsigned long bitmap_size;

-		INIT_LIST_HEAD(&zone->free_area[order].free_list);
+		INIT_LIST_HEAD(&zone->free_area[NOT_ZEROED][order].free_list);
+		INIT_LIST_HEAD(&zone->free_area[ZEROED][order].free_list);
 		if (order == MAX_ORDER-1) {
-			zone->free_area[order].map = NULL;
+			zone->free_area[NOT_ZEROED][order].map = NULL;
+			zone->free_area[ZEROED][order].map = NULL;
 			break;
 		}

 		bitmap_size = pages_to_bitmap_size(order, size);
-		zone->free_area[order].map =
+		zone->free_area[NOT_ZEROED][order].map =
+		  (unsigned long *) alloc_bootmem_node(pgdat, bitmap_size);
+		zone->free_area[ZEROED][order].map =
 		  (unsigned long *) alloc_bootmem_node(pgdat, bitmap_size);
-		zone->free_area[order].nr_free = 0;
+		zone->free_area[NOT_ZEROED][order].nr_free = 0;
+		zone->free_area[ZEROED][order].nr_free = 0;
 	}
 }

@@ -1527,6 +1594,7 @@

 	pgdat->nr_zones = 0;
 	init_waitqueue_head(&pgdat->kswapd_wait);
+	init_waitqueue_head(&pgdat->kscrubd_wait);
 	pgdat->kswapd_max_order = 0;

 	for (j = 0; j < MAX_NR_ZONES; j++) {
@@ -1550,6 +1618,7 @@
 		spin_lock_init(&zone->lru_lock);
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
+		zone->zero_pages = 0;

 		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;

@@ -1583,6 +1652,13 @@
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
@@ -1708,7 +1784,7 @@
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
--- linux-2.6.10.orig/include/linux/mmzone.h	2005-01-04 14:17:01.000000000 -0800
+++ linux-2.6.10/include/linux/mmzone.h	2005-01-04 14:17:02.000000000 -0800
@@ -52,7 +52,7 @@
 };

 struct per_cpu_pageset {
-	struct per_cpu_pages pcp[2];	/* 0: hot.  1: cold */
+	struct per_cpu_pages pcp[3];	/* 0: hot.  1: cold  2: cold zeroed pages */
 #ifdef CONFIG_NUMA
 	unsigned long numa_hit;		/* allocated in intended node */
 	unsigned long numa_miss;	/* allocated in non intended node */
@@ -108,10 +108,14 @@
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
@@ -132,7 +136,7 @@
 	 * free areas of different sizes
 	 */
 	spinlock_t		lock;
-	struct free_area	free_area[MAX_ORDER];
+	struct free_area	free_area[2][MAX_ORDER];


 	ZONE_PADDING(_pad1_)
@@ -267,6 +271,9 @@
 	wait_queue_head_t kswapd_wait;
 	struct task_struct *kswapd;
 	int kswapd_max_order;
+
+	wait_queue_head_t       kscrubd_wait;
+	struct task_struct *kscrubd;
 } pg_data_t;

 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
@@ -276,9 +283,9 @@
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
--- linux-2.6.10.orig/fs/proc/proc_misc.c	2004-12-24 13:34:00.000000000 -0800
+++ linux-2.6.10/fs/proc/proc_misc.c	2005-01-04 14:17:02.000000000 -0800
@@ -158,13 +158,14 @@
 	unsigned long inactive;
 	unsigned long active;
 	unsigned long free;
+	unsigned long zero;
 	unsigned long vmtot;
 	unsigned long committed;
 	unsigned long allowed;
 	struct vmalloc_info vmi;

 	get_page_state(&ps);
-	get_zone_counts(&active, &inactive, &free);
+	get_zone_counts(&active, &inactive, &free, &zero);

 /*
  * display in kilobytes.
@@ -187,6 +188,7 @@
 	len = sprintf(page,
 		"MemTotal:     %8lu kB\n"
 		"MemFree:      %8lu kB\n"
+		"MemZero:      %8lu kB\n"
 		"Buffers:      %8lu kB\n"
 		"Cached:       %8lu kB\n"
 		"SwapCached:   %8lu kB\n"
@@ -210,6 +212,7 @@
 		"VmallocChunk: %8lu kB\n",
 		K(i.totalram),
 		K(i.freeram),
+		K(zero),
 		K(i.bufferram),
 		K(get_page_cache_size()-total_swapcache_pages-i.bufferram),
 		K(total_swapcache_pages),
Index: linux-2.6.10/mm/readahead.c
===================================================================
--- linux-2.6.10.orig/mm/readahead.c	2005-01-04 14:17:01.000000000 -0800
+++ linux-2.6.10/mm/readahead.c	2005-01-04 14:17:02.000000000 -0800
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
--- linux-2.6.10.orig/drivers/base/node.c	2005-01-04 14:17:00.000000000 -0800
+++ linux-2.6.10/drivers/base/node.c	2005-01-04 14:17:02.000000000 -0800
@@ -41,13 +41,15 @@
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
@@ -57,6 +59,7 @@
 		       "Node %d LowFree:      %8lu kB\n",
 		       nid, K(i.totalram),
 		       nid, K(i.freeram),
+		       nid, K(zero),
 		       nid, K(i.totalram - i.freeram),
 		       nid, K(active),
 		       nid, K(inactive),
Index: linux-2.6.10/include/linux/sched.h
===================================================================
--- linux-2.6.10.orig/include/linux/sched.h	2005-01-04 14:17:01.000000000 -0800
+++ linux-2.6.10/include/linux/sched.h	2005-01-04 14:17:02.000000000 -0800
@@ -715,6 +715,7 @@
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
+#define PF_KSCRUBD	0x00800000	/* I am kscrubd */

 #ifdef CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, cpumask_t new_mask);
Index: linux-2.6.10/mm/Makefile
===================================================================
--- linux-2.6.10.orig/mm/Makefile	2004-12-24 13:35:00.000000000 -0800
+++ linux-2.6.10/mm/Makefile	2005-01-04 14:17:02.000000000 -0800
@@ -5,7 +5,7 @@
 mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= fremap.o highmem.o madvise.o memory.o mincore.o \
 			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o \
-			   vmalloc.o
+			   vmalloc.o scrubd.o

 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o prio_tree.o \
Index: linux-2.6.10/mm/scrubd.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.10/mm/scrubd.c	2005-01-04 14:58:46.000000000 -0800
@@ -0,0 +1,147 @@
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/highmem.h>
+#include <linux/file.h>
+#include <linux/suspend.h>
+#include <linux/sysctl.h>
+#include <linux/scrub.h>
+
+unsigned int sysctl_scrub_start = 7;	/* if a page of this order is coalesed then run kscrubd */
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
+			struct page *page = scrubd_rmpage(z, area, order);
+			struct list_head *l;
+
+			if (!page)
+				continue;
+
+			page->index = order;
+
+			list_for_each(l, &zero_drivers) {
+				struct zero_driver *driver = list_entry(l, struct zero_driver, list);
+				unsigned long size = PAGE_SIZE << order;
+
+				if (driver->start(page_address(page), size) == 0) {
+
+					unsigned ticks = (size*HZ)/driver->rate;
+					if (ticks) {
+						/* Wait the minimum time of the transfer */
+						current->state = TASK_INTERRUPTIBLE;
+						schedule_timeout(ticks);
+					}
+					/* Then keep on checking until transfer is complete */
+					while (!driver->check())
+						schedule();
+					goto out;
+				}
+			}
+
+			/* Unable to find a zeroing device that would
+			 * deal with this page so just do it on our own.
+			 * This will likely thrash the cpu caches.
+			 */
+			cond_resched();
+			clear_page(page_address(page), order);
+out:
+			end_zero_page(page);
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
+++ linux-2.6.10/include/linux/scrub.h	2005-01-04 14:17:02.000000000 -0800
@@ -0,0 +1,51 @@
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
+	int (*check)(void);				/* Check if bzero is complete */
+	unsigned long rate;				/* zeroing rate in bytes/sec */
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
+extern struct page *scrubd_rmpage(struct zone *zone, struct free_area *area, int order);
+
+static void inline wakeup_kscrubd(struct zone *zone)
+{
+        if (avenrun[0] >= (unsigned long)sysctl_scrub_load << FSHIFT)
+		return;
+	if (!waitqueue_active(&zone->zone_pgdat->kscrubd_wait))
+                return;
+        wake_up_interruptible(&zone->zone_pgdat->kscrubd_wait);
+}
+
+int scrub_start_handler(struct ctl_table *, int, struct file *,
+				      void __user *, size_t *, loff_t *);
+
+extern void end_zero_page(struct page *page);
+#endif
Index: linux-2.6.10/kernel/sysctl.c
===================================================================
--- linux-2.6.10.orig/kernel/sysctl.c	2005-01-04 14:17:01.000000000 -0800
+++ linux-2.6.10/kernel/sysctl.c	2005-01-04 14:17:02.000000000 -0800
@@ -40,6 +40,7 @@
 #include <linux/times.h>
 #include <linux/limits.h>
 #include <linux/dcache.h>
+#include <linux/scrub.h>
 #include <linux/syscalls.h>

 #include <asm/uaccess.h>
@@ -826,6 +827,33 @@
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
--- linux-2.6.10.orig/include/linux/sysctl.h	2005-01-04 14:17:01.000000000 -0800
+++ linux-2.6.10/include/linux/sysctl.h	2005-01-04 14:17:02.000000000 -0800
@@ -169,6 +169,9 @@
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_SCRUB_START=30,	/* percentage * 10 at which to start scrubd */
+	VM_SCRUB_STOP=31,	/* percentage * 10 at which to stop scrubd */
+	VM_SCRUB_LOAD=31,	/* Load factor at which not to scrub anymore */
 };



