Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316577AbSE3LDN>; Thu, 30 May 2002 07:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316579AbSE3LDM>; Thu, 30 May 2002 07:03:12 -0400
Received: from holomorphy.com ([66.224.33.161]:60053 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316577AbSE3LDA>;
	Thu, 30 May 2002 07:03:00 -0400
Date: Thu, 30 May 2002 04:02:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, suparna@in.ibm.com, rwhron@earthlink.net,
        akpm@zip.com.au, rsf@us.ibm.com, pavel@ucw.cz
Subject: lazy_buddy-2.5.19-1
Message-ID: <20020530110239.GX21661@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	suparna@in.ibm.com, rwhron@earthlink.net, akpm@zip.com.au,
	rsf@us.ibm.com, pavel@ucw.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deferred coalescing is an important allocator optimization. In the case
of binary buddy system allocators prior implementations have successfully
yielded between 10% and 32% reductions in the average latency of
allocation and freeing operations. The following patch is a rework of
the buddy allocator in page_alloc.c to use deferred coalescing, updated
for algorithmic compliance and to report fragmentation statistics, and
to fix bugs reported by Randy Hron and Andrew Morton.

The results achieved by this specific implementation are as of yet not
entirely known, but some non-rigorous testing seems to reveal approximate
parity with mainline. Ruth, Randy, I'd be much obliged to hear of the
results of more rigorous testing to determine quality of implementation
issues still needing to be addressed.

Martin Bligh contributed the fragmentation statistics reporting, though
adaptation was required to provide useful reporting for this algorithm,
largely due to the additional reporting not relevant to mainline.

TODO
(1)  kill zone_free_pages(), it's useless since ->free_pages has it all now
(2)  get more feedback from Pavel Machek about whether he likes this
	is_head_of_free_region()
(3)  rigorous performance analysis for determining whether this has been
	done properly and may be considered essentially finished
(4)  More concise and to-the-point commentary.
(5)  do some address-ordered queueing
(6)  benchmarking
(7)  audit for unnecessary cacheline dirtying
(8)  port to 2.4.x & rmap
(9)  optimize
(10) collect statistics on the allocation rates for various orders
(11) collect statistics on allocation failures due to fragmentation


The following TODO items essentially fall under the rubric of follow-on
patches building upon this one:

(12)  gang allocation support
(13)  per-cpu pools
(14)  gang preassembly and bulk transfer during gang allocation and refill
	of per-cpu pools


Cheers,
Bill


diff -urN --exclude [xprs].* linux-2.5/fs/proc/proc_misc.c lazy_buddy/fs/proc/proc_misc.c
--- linux-2.5/fs/proc/proc_misc.c	Thu May 30 03:21:31 2002
+++ lazy_buddy/fs/proc/proc_misc.c	Thu May 30 02:16:30 2002
@@ -131,6 +131,7 @@
 	struct sysinfo i;
 	int len;
 	struct page_state ps;
+	extern unsigned long nr_deferred_pages(void);
 
 	get_page_state(&ps);
 /*
@@ -158,7 +159,8 @@
 		"SwapTotal:    %8lu kB\n"
 		"SwapFree:     %8lu kB\n"
 		"Dirty:        %8lu kB\n"
-		"Writeback:    %8lu kB\n",
+		"Writeback:    %8lu kB\n"
+		"Deferred:     %8lu kB\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.sharedram),
@@ -173,13 +175,30 @@
 		K(i.totalswap),
 		K(i.freeswap),
 		K(ps.nr_dirty),
-		K(ps.nr_writeback)
+		K(ps.nr_writeback),
+		K(nr_deferred_pages())
 		);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
 #undef K
 }
 
+extern int fragmentation_stats(char *, int);
+static int fragmentation_read_proc(	char *page,
+					char **start,
+					off_t off,
+					int count,
+					int *eof,
+					void *data)
+{
+	int nid, len = 0;
+
+	for (nid = 0; nid < numnodes; ++nid)
+		len += fragmentation_stats(page + len, nid);
+
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
 static int version_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -543,6 +562,7 @@
 		{"loadavg",     loadavg_read_proc},
 		{"uptime",	uptime_read_proc},
 		{"meminfo",	meminfo_read_proc},
+		{"fraginfo",	fragmentation_read_proc},
 		{"version",	version_read_proc},
 #ifdef CONFIG_PROC_HARDWARE
 		{"hardware",	hardware_read_proc},
diff -urN --exclude [xprs].* linux-2.5/include/linux/mmzone.h lazy_buddy/include/linux/mmzone.h
--- linux-2.5/include/linux/mmzone.h	Thu May 30 03:21:37 2002
+++ lazy_buddy/include/linux/mmzone.h	Thu May 30 03:03:38 2002
@@ -20,8 +20,9 @@
 #endif
 
 typedef struct free_area_struct {
-	struct list_head	free_list;
-	unsigned long		*map;
+	unsigned long	globally_free, active, locally_free;
+	list_t		free_list, deferred_pages;
+	unsigned long	*map;
 } free_area_t;
 
 struct pglist_data;
@@ -142,8 +143,19 @@
 extern int numnodes;
 extern pg_data_t *pgdat_list;
 
-#define memclass(pgzone, classzone)	(((pgzone)->zone_pgdat == (classzone)->zone_pgdat) \
-			&& ((pgzone) <= (classzone)))
+static inline int memclass(zone_t *page_zone, zone_t *classzone)
+{
+	if (page_zone->zone_pgdat != classzone->zone_pgdat)
+		return 0;
+	if (page_zone > classzone)
+		return 0;
+	return 1;
+}
+
+static inline unsigned long zone_free_pages(zone_t *zone)
+{
+	return zone->free_pages;
+}
 
 /*
  * The following two are not meant for general usage. They are here as
diff -urN --exclude [xprs].* linux-2.5/mm/bootmem.c lazy_buddy/mm/bootmem.c
--- linux-2.5/mm/bootmem.c	Tue May 21 08:25:32 2002
+++ lazy_buddy/mm/bootmem.c	Tue May 28 00:54:37 2002
@@ -241,6 +241,7 @@
 	return ret;
 }
 
+extern void forced_coalesce(zone_t *zone);
 static unsigned long __init free_all_bootmem_core(pg_data_t *pgdat)
 {
 	struct page *page = pgdat->node_mem_map;
@@ -287,6 +288,9 @@
 	}
 	total += count;
 	bdata->node_bootmem_map = NULL;
+
+	for (i = 0; i < MAX_NR_ZONES; ++i)
+		forced_coalesce(&pgdat->node_zones[i]);
 
 	return total;
 }
diff -urN --exclude [xprs].* linux-2.5/mm/page_alloc.c lazy_buddy/mm/page_alloc.c
--- linux-2.5/mm/page_alloc.c	Thu May 30 03:21:38 2002
+++ lazy_buddy/mm/page_alloc.c	Thu May 30 02:16:40 2002
@@ -10,6 +10,7 @@
  *  Reshaped it to be a zoned allocator, Ingo Molnar, Red Hat, 1999
  *  Discontiguous memory support, Kanoj Sarcar, SGI, Nov 1999
  *  Zone balancing, Kanoj Sarcar, SGI, Jan 2000
+ *  Lazy buddy allocation, William Irwin, IBM, May 2002
  */
 
 #include <linux/config.h>
@@ -26,9 +27,21 @@
 
 unsigned long totalram_pages;
 unsigned long totalhigh_pages;
+
+/*
+ * Page replacement statistics
+ */
 int nr_swap_pages;
-struct list_head inactive_list;
-struct list_head active_list;
+
+/*
+ * global page replacement queues.
+ */
+list_t inactive_list;
+list_t active_list;
+
+/*
+ * global list of node structures
+ */
 pg_data_t *pgdat_list;
 
 /* Used to look up the address of the struct zone encoded in page->zone */
@@ -36,42 +49,81 @@
 EXPORT_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
+
+/*
+ * Page replacement threshold tables
+ */
 static int zone_balance_ratio[MAX_NR_ZONES] __initdata = { 128, 128, 128, };
 static int zone_balance_min[MAX_NR_ZONES] __initdata = { 20 , 20, 20, };
 static int zone_balance_max[MAX_NR_ZONES] __initdata = { 255 , 255, 255, };
 
 /*
- * Free_page() adds the page to the free lists. This is optimized for
- * fast normal cases (no error jumps taken normally).
- *
- * The way to optimize jumps for gcc-2.2.2 is to:
- *  - select the "normal" case and put it inside the if () { XXX }
- *  - no else-statements if you can avoid them
- *
- * With the above two rules, you get a straight-line execution path
- * for the normal case, giving better asm-code.
+ * Temporary debugging check for pages not lying within a given zone.
+ */
+static inline int BAD_RANGE(zone_t *zone, struct page *page)
+{
+	unsigned long page_mapnr = (unsigned long)(page - mem_map);
+	if (page_mapnr >= zone->zone_start_mapnr + zone->size)
+		return 1;
+	if (page_mapnr < zone->zone_start_mapnr)
+		return 1;
+	if (zone != page_zone(page))
+		return 1;
+	return 0;
+}
+
+/*
+ * Wrappers for manipulations of buddy lists.
+ * TODO: implement address-ordered queueing of buddy block freelists
  */
+static inline void buddy_enqueue(free_area_t *area, struct page *page)
+{
+	list_add(&page->list, &area->free_list);
+	area->globally_free++;
+}
+
+static inline void buddy_remove(free_area_t *area, struct page *page)
+{
+	area->globally_free--;
+	list_del(&page->list);
+}
+
+static inline struct page *buddy_dequeue(free_area_t *area)
+{
+	struct page *page;
+	if (unlikely(list_empty(&area->free_list)))
+		return NULL;
 
-#define memlist_init(x) INIT_LIST_HEAD(x)
-#define memlist_add_head list_add
-#define memlist_add_tail list_add_tail
-#define memlist_del list_del
-#define memlist_entry list_entry
-#define memlist_next(x) ((x)->next)
-#define memlist_prev(x) ((x)->prev)
+	page = list_entry(area->free_list.next, struct page, list);
+	buddy_remove(area, page);
+	return page;
+}
 
 /*
- * Temporary debugging check.
+ * Deferred coalescing page queues
+ * TODO: use a list of preassembled gangs for gang page transfers
  */
-#define BAD_RANGE(zone, page)						\
-(									\
-	(((page) - mem_map) >= ((zone)->zone_start_mapnr+(zone)->size))	\
-	|| (((page) - mem_map) < (zone)->zone_start_mapnr)		\
-	|| ((zone) != page_zone(page))					\
-)
+static inline void deferred_enqueue(free_area_t *area, struct page *page)
+{
+	list_add(&page->list, &area->deferred_pages);
+	area->locally_free++;
+}
+
+static inline struct page *deferred_dequeue(free_area_t *area)
+{
+	struct page *page;
+
+	if (unlikely(list_empty(&area->deferred_pages)))
+		return NULL;
+
+	page = list_entry(area->deferred_pages.next, struct page, list);
+	list_del_init(&page->list);
+	area->locally_free--;
+	return page;
+}
 
 /*
- * Freeing function for a buddy system allocator.
+ * pure buddy system allocator
  *
  * The concept of a buddy system is to maintain direct-mapped table
  * (containing bit values) for memory blocks of various "orders".
@@ -82,61 +134,51 @@
  * at the bottom level available, and propagating the changes upward
  * as necessary, plus some accounting needed to play nicely with other
  * parts of the VM system.
- *
- * TODO: give references to descriptions of buddy system allocators,
- * describe precisely the silly trick buddy allocators use to avoid
- * storing an extra bit, utilizing entry point information.
+ * More precisely, a buddy system for a given level maintains one bit
+ * for each pair of blocks, which is the xor of the "virtual bits"
+ * describing whether or not the individual blocks are available.
+ * While freeing, the block of pages being examined is known to be
+ * already allocated, so its "virtual bit" is 0 and its buddy's bit
+ * may be recovered by xor'ing with 0 (or just checking it). While
+ * allocating, the block of pages to be handed back is chosen from
+ * lists of free pages, and so the page's "virtual bit" is 1 and its
+ * buddy's bit may be recovered by xor'ing with 1 (or just inverting it).
+ * These virtual bits, when recovered, are used only to determine when
+ * to split or coalesce blocks of free pages and do the corresponding
+ * list manipulations. That is, if both were free and a smaller block
+ * is allocated from a free region then the remainder of the region
+ * must be split into blocks, or if a free block's buddy is freed then
+ * this triggers coalescing of blocks on the queues into a block of
+ * larger size.
  *
  * -- wli
  */
 
-static void FASTCALL(__free_pages_ok (struct page *page, unsigned int order));
-static void __free_pages_ok (struct page *page, unsigned int order)
+static void FASTCALL(buddy_free(struct page *, int order));
+static void buddy_free(struct page *page, int order)
 {
-	unsigned long index, page_idx, mask, flags;
+	unsigned long index, page_idx, mask;
 	free_area_t *area;
 	struct page *base;
 	zone_t *zone;
 
-	if (PagePrivate(page))
-		BUG();
-	if (page->mapping)
-		BUG();
-	if (PageLocked(page))
-		BUG();
-	if (PageLRU(page))
-		BUG();
-	if (PageActive(page))
-		BUG();
-	if (PageWriteback(page))
-		BUG();
-	ClearPageDirty(page);
-	page->flags &= ~(1<<PG_referenced);
-
 	if (current->flags & PF_FREE_PAGES)
 		goto local_freelist;
- back_local_freelist:
 
+back_local_freelist:
 	zone = page_zone(page);
-
 	mask = (~0UL) << order;
 	base = zone->zone_mem_map;
 	page_idx = page - base;
-	if (page_idx & ~mask)
-		BUG();
+	BUG_ON(page_idx & ~mask);
 	index = page_idx >> (1 + order);
 
 	area = zone->free_area + order;
 
-	spin_lock_irqsave(&zone->lock, flags);
-
-	zone->free_pages -= mask;
-
 	while (mask + (1 << (MAX_ORDER-1))) {
 		struct page *buddy1, *buddy2;
 
-		if (area >= zone->free_area + MAX_ORDER)
-			BUG();
+		BUG_ON(area >= zone->free_area + MAX_ORDER);
 		if (!__test_and_change_bit(index, area->map))
 			/*
 			 * the buddy page is still allocated.
@@ -149,23 +191,20 @@
 		 */
 		buddy1 = base + (page_idx ^ -mask);
 		buddy2 = base + page_idx;
-		if (BAD_RANGE(zone,buddy1))
-			BUG();
-		if (BAD_RANGE(zone,buddy2))
-			BUG();
+		BUG_ON(BAD_RANGE(zone, buddy1));
+		BUG_ON(BAD_RANGE(zone, buddy2));
 
-		memlist_del(&buddy1->list);
+		buddy_remove(area, buddy1);
 		mask <<= 1;
 		area++;
 		index >>= 1;
 		page_idx &= mask;
 	}
-	memlist_add_head(&(base + page_idx)->list, &area->free_list);
+	buddy_enqueue(area, base + page_idx);
 
-	spin_unlock_irqrestore(&zone->lock, flags);
 	return;
 
- local_freelist:
+local_freelist:
 	if (current->nr_local_pages)
 		goto back_local_freelist;
 	if (in_interrupt())
@@ -176,76 +215,342 @@
 	current->nr_local_pages++;
 }
 
-#define MARK_USED(index, order, area) \
-	__change_bit((index) >> (1+(order)), (area)->map)
+#ifdef CONFIG_SOFTWARE_SUSPEND
+extern void forced_coalesce(zone_t *zone);
+int is_head_of_free_region(struct page *page)
+{
+	zone_t *zone = page_zone(page);
+	int order;
+	list_t *curr;
+	unsigned long flags;
+
+	/*
+	 * Should not matter as we need quiescent system for
+	 * suspend anyway, but...
+	 */
+	spin_lock_irqsave(&zone->lock, flags);
+
+	forced_coalesce(zone);
+
+	for (order = MAX_ORDER - 1; order >= 0; --order)
+		list_for_each(curr, &zone->free_area[order].free_list) {
+			if (page != list_entry(curr, struct page, list))
+				continue;
+			spin_unlock_irqrestore(&zone->lock, flags);
+			return 1 << order;
+		}
+	spin_unlock_irqrestore(&zone->lock, flags);
+
+	return 0;
+}
+#endif /* CONFIG_SOFTWARE_SUSPEND */
+
+/*
+ * Entry point for alloc_pages() -internal routines to obtain pages from
+ * a zone's internal allocator state. Deferred coalescing is implemented
+ * here largely as described in Vahalia.
+ *
+ * The basic concept of the deferred coalescing buddy allocator, or lazy
+ * buddy, is to add freelists for each block class that cache free
+ * memory blocks not yet accounted in the buddy bitmaps in order to
+ * avoid coalescing overhead in the common case, and the following are
+ * the mechanics of cache reclamation:
+ *
+ * There are three state variables per class of free memory blocks:
+ * (1) active
+ *	these memory blocks have been granted to a caller of the
+ *	allocator
+ * (2) locally free
+ *	number of memory blocks on the deferred coalescing freelist
+ * (3) globally free
+ *	number of memory blocks on the buddy freelist
+ *
+ * When expressed in the terms used in Vahalia, the invariant of the
+ * lazy buddy algorithm is:
+ *
+ * area->active >= area->locally_free
+ *
+ * This is described as the invariant being slack >= 0, where
+ * slack = total_pages_of_block_class - 2*locally_free - globally_free
+ * where total_pages_of_block_class = active + locally_free + globally_free
+ * Finally, the slack may be written active - globally_free, and then
+ * slack >= 0 becomes what is presented above.
+ *
+ * Notable here is that the comparison is specific to a single blocksize's
+ * deferred page queue.
+ *
+ * There are three distinct regimes (states) identified by the allocator:
+ *
+ * (1) the lazy regime
+ *          The lazy regime is when area->active > area->locally_free + 1
+ *          or slack > 1. While in this regime the strategy always
+ *          allocates and frees from the deferred page queues while the
+ *          allocations may be satisfied from them.
+ *
+ * (2) the reclaiming regime
+ *          The reclaiming regime is when area->active == area->locally_free+1
+ *          or slack == 1. While in the reclaiming regime, the allocator
+ *          should try to use the buddy system to obtain and esp. free
+ *          its pages and so behaves like strict buddy in this regime.
+ *
+ * (3) the accelerated regime
+ *          The accelerated regime is when area->active == area->locally_free
+ *          or slack == 0. While in the accelerated regime, the allocator
+ *          should use the buddy system to obtain and free pages on behalf
+ *          of the caller, but in addition it should free as many deferred
+ *          coalesced pages as it grants to the caller.
+ *
+ * Vahalia reports that lazy buddy is a 10-32% gain over strict buddy in
+ * latency in the common case over strict buddy.
+ */
+static void FASTCALL(low_level_free(struct page *page, unsigned int order));
+static void low_level_free(struct page *page, unsigned int order)
+{
+	zone_t *zone = page_zone(page);
+	unsigned long offset;
+	unsigned long flags;
+	free_area_t *area;
+	struct page *deferred_page;
+
+	spin_lock_irqsave(&zone->lock, flags);
+
+	offset = page - zone->zone_mem_map;
+	area = &zone->free_area[order];
+
+	switch (area->active - area->locally_free) {
+		case 0:
+			/*
+			 * Free a deferred page; this is the accelerated
+			 * regime for page coalescing.
+			 */
+			deferred_page = deferred_dequeue(area);
+			if (deferred_page)
+				buddy_free(deferred_page, order);
+			/*
+			 * Fall through and also free the page we were
+			 * originally asked to free.
+			 */
+		case 1:
+			buddy_free(page, order);
+			break;
+		default:
+			deferred_enqueue(area, page);
+			break;
+	}
+
+	area->active -= min(area->active, 1UL);
+	zone->free_pages += 1UL << order;
+
+	spin_unlock_irqrestore(&zone->lock, flags);
+}
+
+/*
+ * In order satisfy high-order boottime allocations a further pass is
+ * made at boot-time to fully coalesce all pages. Furthermore, swsusp
+ * also seems to want to be able to detect free regions by making use
+ * of full coalescing, and so the functionality is provided here.
+ */
+void forced_coalesce(zone_t *zone)
+{
+	int order;
+	struct page *page;
+	unsigned int nr_pages;
+	free_area_t *area;
+
+	if (!zone->size)
+		return;
+
+	for (order = MAX_ORDER - 1; order >= 0; --order) {
+		nr_pages = 1UL << order;
+		area = &zone->free_area[order];
+		page = deferred_dequeue(area);
+		while (page) {
+			buddy_free(page, order);
+			page = deferred_dequeue(area);
+		}
+	}
+}
+
+static void FASTCALL(__free_pages_ok (struct page *page, unsigned int order));
+static void __free_pages_ok (struct page *page, unsigned int order)
+{
+	BUG_ON(PagePrivate(page));
+	BUG_ON(page->mapping);
+	BUG_ON(PageLocked(page));
+	BUG_ON(PageLRU(page));
+	BUG_ON(PageActive(page));
+	BUG_ON(PageWriteback(page));
+
+	ClearPageError(page);
+	ClearPageUptodate(page);
+	ClearPageDirty(page);
+	ClearPageSlab(page);
+	ClearPageNosave(page);
+	clear_bit(PG_checked, &page->flags);
 
-static inline struct page * expand (zone_t *zone, struct page *page,
+	low_level_free(page, order);
+}
+
+/*
+ * A small optimization for marking the buddy bitmap is that one
+ * may simply remember the size of the initial free block, the
+ * initial free block itself, and the size actually allocated.
+ */
+static inline struct page *expand(zone_t *zone, struct page *page,
 	 unsigned long index, int low, int high, free_area_t * area)
 {
 	unsigned long size = 1 << high;
 
 	while (high > low) {
-		if (BAD_RANGE(zone,page))
-			BUG();
+		BUG_ON(BAD_RANGE(zone, page));
 		area--;
 		high--;
 		size >>= 1;
-		memlist_add_head(&(page)->list, &(area)->free_list);
-		MARK_USED(index, high, area);
+		buddy_enqueue(area, page);
+		__change_bit(index >> (1+high), area->map);
 		index += size;
 		page += size;
 	}
-	if (BAD_RANGE(zone,page))
-		BUG();
+	BUG_ON(BAD_RANGE(zone, page));
 	return page;
 }
 
-static FASTCALL(struct page * rmqueue(zone_t *zone, unsigned int order));
-static struct page * rmqueue(zone_t *zone, unsigned int order)
+/*
+ * Mark the bitmap checking our buddy, and descend levels breaking off
+ * free fragments in the bitmap along the way. When done, wrap up with
+ * the single pass of expand() to break off the various fragments from
+ * the free lists.
+ */
+static FASTCALL(struct page *buddy_alloc(zone_t *zone, unsigned int order));
+static struct page *buddy_alloc(zone_t *zone, unsigned int order)
 {
 	free_area_t * area = zone->free_area + order;
-	unsigned int curr_order = order;
-	struct list_head *head, *curr;
-	unsigned long flags;
+	unsigned int curr_order;
 	struct page *page;
 
-	spin_lock_irqsave(&zone->lock, flags);
-	do {
-		head = &area->free_list;
-		curr = memlist_next(head);
+	for (curr_order = order; curr_order < MAX_ORDER; ++curr_order, ++area) {
+		unsigned int index;
 
-		if (curr != head) {
-			unsigned int index;
+		page = buddy_dequeue(area);
 
-			page = memlist_entry(curr, struct page, list);
-			if (BAD_RANGE(zone,page))
-				BUG();
-			memlist_del(curr);
-			index = page - zone->zone_mem_map;
-			if (curr_order != MAX_ORDER-1)
-				MARK_USED(index, curr_order, area);
-			zone->free_pages -= 1UL << order;
-
-			page = expand(zone, page, index, order, curr_order, area);
-			spin_unlock_irqrestore(&zone->lock, flags);
+		if (unlikely(!page))
+			continue;
 
-			set_page_count(page, 1);
-			if (BAD_RANGE(zone,page))
-				BUG();
-			if (PageLRU(page))
-				BUG();
-			if (PageActive(page))
-				BUG();
-			return page;	
-		}
-		curr_order++;
-		area++;
-	} while (curr_order < MAX_ORDER);
-	spin_unlock_irqrestore(&zone->lock, flags);
+		BUG_ON(BAD_RANGE(zone, page));
 
+		index = page - zone->zone_mem_map;
+		if (curr_order != MAX_ORDER-1)
+			__change_bit(index >> (1+curr_order), area->map);
+
+		page = expand(zone, page, index, order, curr_order, area);
+		set_page_count(page, 1);
+
+		BUG_ON(BAD_RANGE(zone, page));
+		BUG_ON(PageLRU(page));
+		BUG_ON(PageActive(page));
+		return page;	
+	}
 	return NULL;
 }
 
+/*
+ * split_pages() is much like expand, but operates only on the queues
+ * of deferred coalesced pages.
+ */
+static void FASTCALL(split_pages(zone_t *, struct page *, int, int));
+static void split_pages(zone_t *zone,
+			struct page *page,
+			int page_order,
+			int deferred_order)
+{
+	int split_order;
+	unsigned long split_offset;
+	struct page *split_page;
+
+	split_order = deferred_order - 1;
+	split_offset = 1UL << split_order;
+	while (split_order >= page_order) {
+
+		split_page = &page[split_offset];
+
+		deferred_enqueue(&zone->free_area[split_order], split_page);
+
+		--split_order;
+		split_offset >>= 1;
+	}
+}
+
+/*
+ * low_level_alloc() exports free page search functionality to the
+ * internal VM allocator. It uses the strategy outlined above
+ * low_level_free() in order to decide where to obtain its pages.
+ */
+static FASTCALL(struct page *low_level_alloc(zone_t *, unsigned int));
+static struct page *low_level_alloc(zone_t *zone, unsigned int order)
+{
+	struct page *page;
+	unsigned long flags;
+	free_area_t *area;
+
+	spin_lock_irqsave(&zone->lock, flags);
+
+	area = &zone->free_area[order];
+
+	page = deferred_dequeue(area);
+	if (unlikely(!page))
+		page = buddy_alloc(zone, order);
+	if (unlikely(!page))
+		goto out;
+	set_page_count(page, 1);
+	area->active++;
+	zone->free_pages -= 1UL << order;
+out:
+	spin_unlock_irqrestore(&zone->lock, flags);
+	return page;
+}
+
+/*
+ * Render fragmentation statistics for /proc/ reporting.
+ * It simply formats the counters maintained by the queueing
+ * discipline in the buffer passed to it.
+ */
+int fragmentation_stats(char *buf, int nid)
+{
+	int order, len = 0;
+	unsigned long flags;
+	zone_t *zone, *node_zones;
+
+	node_zones = NODE_DATA(nid)->node_zones;
+
+	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
+		spin_lock_irqsave(&zone->lock, flags);
+		len += sprintf(	buf + len,
+				"Node %d, zone %8s\n",
+				nid,
+				zone->name);
+		len += sprintf(buf + len, "buddy:  ");
+		for (order = 0; order < MAX_ORDER; ++order) {
+			len += sprintf( buf + len,
+					"%6lu ",
+					zone->free_area[order].globally_free);
+		}
+		len += sprintf(buf + len, "\ndefer:  ");
+		for (order = 0; order < MAX_ORDER; ++order) {
+			len += sprintf( buf + len,
+					"%6lu ",
+					zone->free_area[order].locally_free);
+		}
+		len += sprintf(buf + len, "\nactive: ");
+		for (order = 0; order < MAX_ORDER; ++order) {
+			len += sprintf( buf + len,
+					"%6lu ",
+					zone->free_area[order].active);
+		}
+		spin_unlock_irqrestore(&zone->lock, flags);
+		len += sprintf(buf + len, "\n");
+	}
+	return len;
+}
 #ifdef CONFIG_SOFTWARE_SUSPEND
 int is_head_of_free_region(struct page *page)
 {
@@ -281,13 +586,15 @@
 static struct page * FASTCALL(balance_classzone(zone_t *, unsigned int, unsigned int, int *));
 static struct page * balance_classzone(zone_t * classzone, unsigned int gfp_mask, unsigned int order, int * freed)
 {
-	struct page * page = NULL;
+	struct page *page = NULL;
 	int __freed = 0;
+	list_t *entry, *local_pages, *save;
+	struct page * tmp;
+	int nr_pages;
 
 	if (!(gfp_mask & __GFP_WAIT))
 		goto out;
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
 
 	current->allocation_order = order;
 	current->flags |= PF_MEMALLOC | PF_FREE_PAGES;
@@ -296,56 +603,51 @@
 
 	current->flags &= ~(PF_MEMALLOC | PF_FREE_PAGES);
 
-	if (current->nr_local_pages) {
-		struct list_head * entry, * local_pages;
-		struct page * tmp;
-		int nr_pages;
-
-		local_pages = &current->local_pages;
-
-		if (likely(__freed)) {
-			/* pick from the last inserted so we're lifo */
-			entry = local_pages->next;
-			do {
-				tmp = list_entry(entry, struct page, list);
-				if (tmp->index == order && memclass(page_zone(tmp), classzone)) {
-					list_del(entry);
-					current->nr_local_pages--;
-					set_page_count(tmp, 1);
-					page = tmp;
-
-					if (PagePrivate(page))
-						BUG();
-					if (page->mapping)
-						BUG();
-					if (PageLocked(page))
-						BUG();
-					if (PageLRU(page))
-						BUG();
-					if (PageActive(page))
-						BUG();
-					if (PageDirty(page))
-						BUG();
-					if (PageWriteback(page))
-						BUG();
+	if (!current->nr_local_pages)
+		goto out;
 
-					break;
-				}
-			} while ((entry = entry->next) != local_pages);
-		}
+	local_pages = &current->local_pages;
 
-		nr_pages = current->nr_local_pages;
-		/* free in reverse order so that the global order will be lifo */
-		while ((entry = local_pages->prev) != local_pages) {
-			list_del(entry);
-			tmp = list_entry(entry, struct page, list);
-			__free_pages_ok(tmp, tmp->index);
-			if (!nr_pages--)
-				BUG();
-		}
-		current->nr_local_pages = 0;
+	if (unlikely(!__freed))
+		goto reverse_free;
+
+	/* pick from the last inserted so we're lifo */
+	list_for_each_safe(entry, save, local_pages) {
+		tmp = list_entry(entry, struct page, list);
+
+		if (unlikely(tmp->index != order))
+			continue;
+		if (unlikely(!memclass(page_zone(page), classzone)))
+			continue;
+
+		list_del(entry);
+		current->nr_local_pages--;
+		set_page_count(tmp, 1);
+		page = tmp;
+
+		BUG_ON(PagePrivate(page));
+		BUG_ON(page->mapping);
+		BUG_ON(PageLocked(page));
+		BUG_ON(PageLRU(page));
+		BUG_ON(PageActive(page));
+		BUG_ON(PageDirty(page));
+		BUG_ON(PageWriteback(page));
+
+		break;
+	}
+
+reverse_free:
+	nr_pages = current->nr_local_pages;
+	/* free in reverse order so that the global order will be lifo */
+	while (!list_empty(local_pages)) {
+		entry = local_pages->prev;
+		list_del(entry);
+		tmp = list_entry(entry, struct page, list);
+		__free_pages_ok(tmp, tmp->index);
+		BUG_ON(!nr_pages--);
 	}
- out:
+	current->nr_local_pages = 0;
+out:
 	*freed = __freed;
 	return page;
 }
@@ -353,16 +655,16 @@
 /*
  * This is the 'heart' of the zoned buddy allocator:
  */
-struct page * __alloc_pages(unsigned int gfp_mask, unsigned int order, zonelist_t *zonelist)
+struct page *__alloc_pages(unsigned int gfp_mask, unsigned int order, zonelist_t *zonelist)
 {
 	unsigned long min;
-	zone_t **zone, * classzone;
-	struct page * page;
+	zone_t **zone, *classzone;
+	struct page *page;
 	int freed;
 
 	zone = zonelist->zones;
 	classzone = *zone;
-	if (classzone == NULL)
+	if (!classzone)
 		return NULL;
 	min = 1UL << order;
 	for (;;) {
@@ -371,8 +673,8 @@
 			break;
 
 		min += z->pages_low;
-		if (z->free_pages > min) {
-			page = rmqueue(z, order);
+		if (zone_free_pages(z) > min) {
+			page = low_level_alloc(z, order);
 			if (page)
 				return page;
 		}
@@ -395,8 +697,8 @@
 		if (!(gfp_mask & __GFP_WAIT))
 			local_min >>= 2;
 		min += local_min;
-		if (z->free_pages > min) {
-			page = rmqueue(z, order);
+		if (zone_free_pages(z) > min) {
+			page = low_level_alloc(z, order);
 			if (page)
 				return page;
 		}
@@ -412,7 +714,7 @@
 			if (!z)
 				break;
 
-			page = rmqueue(z, order);
+			page = low_level_alloc(z, order);
 			if (page)
 				return page;
 		}
@@ -441,8 +743,8 @@
 			break;
 
 		min += z->pages_min;
-		if (z->free_pages > min) {
-			page = rmqueue(z, order);
+		if (zone_free_pages(z) > min) {
+			page = low_level_alloc(z, order);
 			if (page)
 				return page;
 		}
@@ -513,15 +815,15 @@
 unsigned int nr_free_pages(void)
 {
 	unsigned int sum;
-	zone_t *zone;
-	pg_data_t *pgdat = pgdat_list;
+	int i;
+	pg_data_t *pgdat;
 
 	sum = 0;
-	while (pgdat) {
-		for (zone = pgdat->node_zones; zone < pgdat->node_zones + MAX_NR_ZONES; zone++)
-			sum += zone->free_pages;
-		pgdat = pgdat->node_next;
-	}
+
+	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
+		for (i = 0; i < MAX_NR_ZONES; ++i)
+			sum += zone_free_pages(&pgdat->node_zones[i]);
+
 	return sum;
 }
 
@@ -578,6 +880,23 @@
 }
 #endif
 
+unsigned long nr_deferred_pages(void)
+{
+	pg_data_t *pgdat;
+	zone_t *node_zones;
+	int i, order;
+	unsigned long pages = 0;
+
+	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next) {
+		node_zones = pgdat->node_zones;
+		for (i = 0; i < MAX_NR_ZONES; ++i) {
+			for (order = 0; order < MAX_ORDER; ++order)
+				pages += node_zones[i].free_area[order].locally_free;
+		}
+	}
+	return pages;
+}
+
 /*
  * Accumulate the page_state information across all CPUs.
  * The result is unavoidably approximate - it can change
@@ -654,7 +973,7 @@
 			printk("Zone:%s freepages:%6lukB min:%6lukB low:%6lukB " 
 				       "high:%6lukB\n", 
 					zone->name,
-					K(zone->free_pages),
+					K(zone_free_pages(zone)),
 					K(zone->pages_min),
 					K(zone->pages_low),
 					K(zone->pages_high));
@@ -670,7 +989,7 @@
 		nr_free_pages());
 
 	for (type = 0; type < MAX_NR_ZONES; type++) {
-		struct list_head *head, *curr;
+		list_t *head, *curr;
 		zone_t *zone = pgdat->node_zones + type;
  		unsigned long nr, total, flags;
 
@@ -682,7 +1001,7 @@
 				curr = head;
 				nr = 0;
 				for (;;) {
-					curr = memlist_next(curr);
+					curr = curr->next;
 					if (curr == head)
 						break;
 					nr++;
@@ -812,8 +1131,7 @@
 	unsigned long totalpages, offset, realtotalpages;
 	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
 
-	if (zone_start_paddr & ~PAGE_MASK)
-		BUG();
+	BUG_ON(zone_start_paddr & ~PAGE_MASK);
 
 	totalpages = 0;
 	for (i = 0; i < MAX_NR_ZONES; i++) {
@@ -912,7 +1230,7 @@
 			set_page_zone(page, nid * MAX_NR_ZONES + j);
 			set_page_count(page, 0);
 			SetPageReserved(page);
-			memlist_init(&page->list);
+			INIT_LIST_HEAD(&page->list);
 			if (j != ZONE_HIGHMEM)
 				set_page_address(page, __va(zone_start_paddr));
 			zone_start_paddr += PAGE_SIZE;
@@ -921,8 +1239,9 @@
 		offset += size;
 		for (i = 0; ; i++) {
 			unsigned long bitmap_size;
+			INIT_LIST_HEAD(&zone->free_area[i].deferred_pages);
 
-			memlist_init(&zone->free_area[i].free_list);
+			INIT_LIST_HEAD(&zone->free_area[i].free_list);
 			if (i == MAX_ORDER-1) {
 				zone->free_area[i].map = NULL;
 				break;
diff -urN --exclude [xprs].* linux-2.5/mm/vmscan.c lazy_buddy/mm/vmscan.c
--- linux-2.5/mm/vmscan.c	Thu May 30 03:21:38 2002
+++ lazy_buddy/mm/vmscan.c	Thu May 30 02:16:40 2002
@@ -682,7 +682,7 @@
 
 	first_classzone = classzone->zone_pgdat->node_zones;
 	while (classzone >= first_classzone) {
-		if (classzone->free_pages > classzone->pages_high)
+		if (zone_free_pages(classzone) > classzone->pages_high)
 			return 0;
 		classzone--;
 	}
