Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbULIPRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbULIPRP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 10:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbULIPRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 10:17:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19913 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261522AbULIPJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 10:09:30 -0500
Date: Thu, 9 Dec 2004 15:08:55 GMT
From: dhowells@redhat.com
To: akpm@osdl.org, davidm@snapgear.com, gerg@snapgear.com, wli@holomorphy.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 1/5] NOMMU: MM cleanups
Message-ID: <3e47b0ba-49f4-11d9-9df1-0002b3163499@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me try these again, this time with the To: line correct...

The attached patch does some cleaning up of the MM code preparatory to
overhauling the high-order page handling:

 (1) Trailing spaces have been cleaned up on lines in page_alloc.c and
     bootmem.c.

 (2) bootmem.c now has a separate path to release pages to the main allocator
     that bypasses many of the checks performed on struct pages.

 (3) __pagevec_free() has moved to swap.c with all the other pagevec
     functions.

 (4) put_page() has moved to page_alloc.c with all the other related
     functions. This could be relegated to a separate file, but since there
     are many other conditionals in page_alloc.c, what's the point?

Signed-Off-By: dhowells@redhat.com
---
diffstat mmcleanup-2610rc2mm3.diff
 bootmem.c    |   35 ++++++++-------
 internal.h   |    3 -
 page_alloc.c |  136 +++++++++++++++++++++++++++++++++++++----------------------
 swap.c       |   29 +++---------
 4 files changed, 116 insertions(+), 87 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.10-rc2-mm3/mm/bootmem.c linux-2.6.10-rc2-mm3-mmcleanup/mm/bootmem.c
--- /warthog/kernels/linux-2.6.10-rc2-mm3/mm/bootmem.c	2004-11-22 10:54:17.000000000 +0000
+++ linux-2.6.10-rc2-mm3-mmcleanup/mm/bootmem.c	2004-11-23 15:32:12.964968405 +0000
@@ -89,7 +89,7 @@ static void __init reserve_bootmem_core(
 	 * fully reserved.
 	 */
 	unsigned long sidx = (addr - bdata->node_boot_start)/PAGE_SIZE;
-	unsigned long eidx = (addr + size - bdata->node_boot_start + 
+	unsigned long eidx = (addr + size - bdata->node_boot_start +
 							PAGE_SIZE-1)/PAGE_SIZE;
 	unsigned long end = (addr + size + PAGE_SIZE-1)/PAGE_SIZE;
 
@@ -174,7 +174,7 @@ __alloc_bootmem_core(struct bootmem_data
 	 * We try to allocate bootmem pages above 'goal'
 	 * first, then we try to allocate lower pages.
 	 */
-	if (goal && (goal >= bdata->node_boot_start) && 
+	if (goal && (goal >= bdata->node_boot_start) &&
 	    ((goal >> PAGE_SHIFT) < bdata->node_low_pfn)) {
 		preferred = goal - bdata->node_boot_start;
 
@@ -264,7 +264,7 @@ static unsigned long __init free_all_boo
 	bootmem_data_t *bdata = pgdat->bdata;
 	unsigned long i, count, total = 0;
 	unsigned long idx;
-	unsigned long *map; 
+	unsigned long *map;
 	int gofast = 0;
 
 	BUG_ON(!bdata->node_bootmem_map);
@@ -274,55 +274,59 @@ static unsigned long __init free_all_boo
 	page = virt_to_page(phys_to_virt(bdata->node_boot_start));
 	idx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
 	map = bdata->node_bootmem_map;
+
 	/* Check physaddr is O(LOG2(BITS_PER_LONG)) page aligned */
 	if (bdata->node_boot_start == 0 ||
 	    ffs(bdata->node_boot_start) - PAGE_SHIFT > ffs(BITS_PER_LONG))
 		gofast = 1;
+
 	for (i = 0; i < idx; ) {
 		unsigned long v = ~map[i / BITS_PER_LONG];
+
 		if (gofast && v == ~0UL) {
 			int j, order;
 
 			count += BITS_PER_LONG;
 			__ClearPageReserved(page);
 			order = ffs(BITS_PER_LONG) - 1;
-			set_page_refs(page, order);
 			for (j = 1; j < BITS_PER_LONG; j++) {
 				if (j + 16 < BITS_PER_LONG)
 					prefetchw(page + j + 16);
 				__ClearPageReserved(page + j);
 			}
-			__free_pages(page, order);
+			__free_pages_bootmem(page, order);
 			i += BITS_PER_LONG;
 			page += BITS_PER_LONG;
+
 		} else if (v) {
 			unsigned long m;
 			for (m = 1; m && i < idx; m<<=1, page++, i++) {
 				if (v & m) {
 					count++;
 					__ClearPageReserved(page);
-					set_page_refs(page, 0);
-					__free_page(page);
+					__free_pages_bootmem(page, 0);
 				}
 			}
+
 		} else {
-			i+=BITS_PER_LONG;
+			i += BITS_PER_LONG;
 			page += BITS_PER_LONG;
 		}
 	}
 	total += count;
 
 	/*
-	 * Now free the allocator bitmap itself, it's not
-	 * needed anymore:
+	 * Now free the allocator bitmap itself, it's not needed anymore:
 	 */
 	page = virt_to_page(bdata->node_bootmem_map);
-	count = 0;
-	for (i = 0; i < ((bdata->node_low_pfn-(bdata->node_boot_start >> PAGE_SHIFT))/8 + PAGE_SIZE-1)/PAGE_SIZE; i++,page++) {
-		count++;
+
+	count = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
+	count = ((count / 8) + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	for (i = count; i > 0; i--) {
 		__ClearPageReserved(page);
-		set_page_count(page, 1);
-		__free_page(page);
+		__free_pages_bootmem(page, 0);
+		page++;
 	}
 	total += count;
 	bdata->node_bootmem_map = NULL;
@@ -402,4 +406,3 @@ void * __init __alloc_bootmem_node (pg_d
 
 	return __alloc_bootmem(size, align, goal);
 }
-
diff -uNrp /warthog/kernels/linux-2.6.10-rc2-mm3/mm/internal.h linux-2.6.10-rc2-mm3-mmcleanup/mm/internal.h
--- /warthog/kernels/linux-2.6.10-rc2-mm3/mm/internal.h	2004-11-22 10:54:18.000000000 +0000
+++ linux-2.6.10-rc2-mm3-mmcleanup/mm/internal.h	2004-11-23 15:31:55.601409553 +0000
@@ -10,4 +10,5 @@
  */
 
 /* page_alloc.c */
-extern void set_page_refs(struct page *page, int order);
+extern void fastcall free_hot_cold_page(struct page *page, int cold);
+extern fastcall void __init __free_pages_bootmem(struct page *page, unsigned int order);
diff -uNrp /warthog/kernels/linux-2.6.10-rc2-mm3/mm/page_alloc.c linux-2.6.10-rc2-mm3-mmcleanup/mm/page_alloc.c
--- /warthog/kernels/linux-2.6.10-rc2-mm3/mm/page_alloc.c	2004-11-22 10:54:18.000000000 +0000
+++ linux-2.6.10-rc2-mm3-mmcleanup/mm/page_alloc.c	2004-11-23 16:13:04.184628888 +0000
@@ -103,6 +103,23 @@ static void bad_page(const char *functio
 	tainted |= TAINT_BAD_PAGE;
 }
 
+void set_page_refs(struct page *page, int order)
+{
+#ifdef CONFIG_MMU
+	set_page_count(page, 1);
+#else
+	int i;
+
+	/*
+	 * We need to reference all the pages for this order, otherwise if
+	 * anyone accesses one of the pages with (get/put) it will be freed.
+	 * - eg: access_process_vm()
+	 */
+	for (i = 0; i < (1 << order); i++)
+		set_page_count(page + i, 1);
+#endif /* CONFIG_MMU */
+}
+
 #ifndef CONFIG_HUGETLB_PAGE
 #define prep_compound_page(page, order) do { } while (0)
 #define destroy_compound_page(page, order) do { } while (0)
@@ -167,11 +184,13 @@ static void destroy_compound_page(struct
  * zone->lock is already acquired when we use these.
  * So, we don't need atomic page->flags operations here.
  */
-static inline unsigned long page_order(struct page *page) {
+static inline unsigned long page_order(struct page *page)
+{
 	return page->private;
 }
 
-static inline void set_page_order(struct page *page, int order) {
+static inline void set_page_order(struct page *page, int order)
+{
 	page->private = order;
 	__SetPagePrivate(page);
 }
@@ -217,10 +236,10 @@ static inline int page_is_buddy(struct p
  * free pages of length of (1 << order) and marked with PG_Private.Page's
  * order is recorded in page->private field.
  * So when we are allocating or freeing one, we can derive the state of the
- * other.  That is, if we allocate a small block, and both were   
- * free, the remainder of the region must be split into blocks.   
+ * other.  That is, if we allocate a small block, and both were
+ * free, the remainder of the region must be split into blocks.
  * If a block is freed, and its buddy is also free, then this
- * triggers coalescing into a block of larger size.            
+ * triggers coalescing into a block of larger size.
  *
  * -- wli
  */
@@ -286,7 +305,7 @@ static inline void free_pages_check(cons
 }
 
 /*
- * Frees a list of pages. 
+ * Frees a list of pages.
  * Assumes all pages on list are in same zone, and of same order.
  * count is the number of pages to free, or 0 for all on the list.
  *
@@ -337,10 +356,33 @@ void __free_pages_ok(struct page *page, 
 	for (i = 0 ; i < (1 << order) ; ++i)
 		free_pages_check(__FUNCTION__, page + i);
 	list_add(&page->lru, &list);
-	kernel_map_pages(page, 1<<order, 0);
+	kernel_map_pages(page, 1 << order, 0);
 	free_pages_bulk(page_zone(page), 1, &list, order);
 }
 
+/*
+ * permit the bootmem allocator to evade page validation on high-order frees
+ */
+fastcall void __init __free_pages_bootmem(struct page *page, unsigned int order)
+{
+	set_page_refs(page, order);
+	set_page_count(page, 0);
+
+	if (order == 0) {
+		free_hot_cold_page(page, 0);
+	} else {
+		LIST_HEAD(list);
+
+		arch_free_page(page, order);
+
+		mod_page_state(pgfree, 1 << order);
+
+		list_add(&page->lru, &list);
+		kernel_map_pages(page, 1 << order, 0);
+		free_pages_bulk(page_zone(page), 1, &list, order);
+	}
+}
+
 
 /*
  * The order of subdivision here is critical for the IO subsystem.
@@ -374,23 +416,6 @@ expand(struct zone *zone, struct page *p
 	return page;
 }
 
-void set_page_refs(struct page *page, int order)
-{
-#ifdef CONFIG_MMU
-	set_page_count(page, 1);
-#else
-	int i;
-
-	/*
-	 * We need to reference all the pages for this order, otherwise if
-	 * anyone accesses one of the pages with (get/put) it will be freed.
-	 * - eg: access_process_vm()
-	 */
-	for (i = 0; i < (1 << order); i++)
-		set_page_count(page + i, 1);
-#endif /* CONFIG_MMU */
-}
-
 /*
  * This page is about to be returned from the page allocator
  */
@@ -415,7 +440,7 @@ static void prep_new_page(struct page *p
 	set_page_refs(page, order);
 }
 
-/* 
+/*
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
  */
@@ -441,19 +466,19 @@ static struct page *__rmqueue(struct zon
 	return NULL;
 }
 
-/* 
+/*
  * Obtain a specified number of elements from the buddy allocator, all under
  * a single hold of the lock, for efficiency.  Add them to the supplied list.
  * Returns the number of new pages which were placed at *list.
  */
-static int rmqueue_bulk(struct zone *zone, unsigned int order, 
+static int rmqueue_bulk(struct zone *zone, unsigned int order,
 			unsigned long count, struct list_head *list)
 {
 	unsigned long flags;
 	int i;
 	int allocated = 0;
 	struct page *page;
-	
+
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
 		page = __rmqueue(zone, order);
@@ -517,9 +542,9 @@ void drain_local_pages(void)
 {
 	unsigned long flags;
 
-	local_irq_save(flags);	
+	local_irq_save(flags);
 	__drain_pages(smp_processor_id());
-	local_irq_restore(flags);	
+	local_irq_restore(flags);
 }
 #endif /* CONFIG_PM */
 
@@ -552,8 +577,7 @@ static void zone_statistics(struct zonel
 /*
  * Free a 0-order page
  */
-static void FASTCALL(free_hot_cold_page(struct page *page, int cold));
-static void fastcall free_hot_cold_page(struct page *page, int cold)
+void fastcall free_hot_cold_page(struct page *page, int cold)
 {
 	struct zone *zone = page_zone(page);
 	struct per_cpu_pages *pcp;
@@ -580,7 +604,7 @@ void fastcall free_hot_page(struct page 
 {
 	free_hot_cold_page(page, 0);
 }
-	
+
 void fastcall free_cold_page(struct page *page)
 {
 	free_hot_cold_page(page, 1);
@@ -957,14 +981,6 @@ fastcall unsigned long get_zeroed_page(u
 
 EXPORT_SYMBOL(get_zeroed_page);
 
-void __pagevec_free(struct pagevec *pvec)
-{
-	int i = pagevec_count(pvec);
-
-	while (--i >= 0)
-		free_hot_cold_page(pvec->pages[i], pvec->cold);
-}
-
 fastcall void __free_pages(struct page *page, unsigned int order)
 {
 	if (!PageReserved(page) && put_page_testzero(page)) {
@@ -987,6 +1003,26 @@ fastcall void free_pages(unsigned long a
 
 EXPORT_SYMBOL(free_pages);
 
+#ifdef CONFIG_HUGETLB_PAGE
+
+void put_page(struct page *page)
+{
+	if (unlikely(PageCompound(page))) {
+		page = (struct page *)page->private;
+		if (put_page_testzero(page)) {
+			void (*dtor)(struct page *page);
+
+			dtor = (void (*)(struct page *))page[1].mapping;
+			(*dtor)(page);
+		}
+		return;
+	}
+	if (!PageReserved(page) && put_page_testzero(page))
+		__page_cache_release(page);
+}
+EXPORT_SYMBOL(put_page);
+#endif
+
 /*
  * Total amount of free (allocatable) RAM:
  */
@@ -1498,7 +1534,7 @@ static void __init build_zonelists(pg_da
  			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
  		for (node = 0; node < local_node; node++)
  			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
- 
+
 		zonelist->zones[j] = NULL;
 	}
 }
@@ -1636,7 +1672,7 @@ static void __init free_area_init_core(s
 	pgdat->nr_zones = 0;
 	init_waitqueue_head(&pgdat->kswapd_wait);
 	pgdat->kswapd_max_order = 0;
-	
+
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
 		unsigned long size, realsize;
@@ -1798,7 +1834,7 @@ static void frag_stop(struct seq_file *m
 {
 }
 
-/* 
+/*
  * This walks the free areas for each zone.
  */
 static int frag_show(struct seq_file *m, void *arg)
@@ -2038,8 +2074,8 @@ static void setup_per_zone_protection(vo
 }
 
 /*
- * setup_per_zone_pages_min - called when min_free_kbytes changes.  Ensures 
- *	that the pages_{min,low,high} values for each zone are set correctly 
+ * setup_per_zone_pages_min - called when min_free_kbytes changes.  Ensures
+ *	that the pages_{min,low,high} values for each zone are set correctly
  *	with respect to min_free_kbytes.
  */
 static void setup_per_zone_pages_min(void)
@@ -2073,10 +2109,10 @@ static void setup_per_zone_pages_min(voi
 				min_pages = 128;
 			zone->pages_min = min_pages;
 		} else {
-			/* if it's a lowmem zone, reserve a number of pages 
+			/* if it's a lowmem zone, reserve a number of pages
 			 * proportionate to the zone's size.
 			 */
-			zone->pages_min = (pages_min * zone->present_pages) / 
+			zone->pages_min = (pages_min * zone->present_pages) /
 			                   lowmem_pages;
 		}
 
@@ -2132,11 +2168,11 @@ static int __init init_per_zone_pages_mi
 module_init(init_per_zone_pages_min)
 
 /*
- * min_free_kbytes_sysctl_handler - just a wrapper around proc_dointvec() so 
+ * min_free_kbytes_sysctl_handler - just a wrapper around proc_dointvec() so
  *	that we can call two helper functions whenever min_free_kbytes
  *	changes.
  */
-int min_free_kbytes_sysctl_handler(ctl_table *table, int write, 
+int min_free_kbytes_sysctl_handler(ctl_table *table, int write,
 		struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
 {
 	proc_dointvec(table, write, file, buffer, length, ppos);
diff -uNrp /warthog/kernels/linux-2.6.10-rc2-mm3/mm/swap.c linux-2.6.10-rc2-mm3-mmcleanup/mm/swap.c
--- /warthog/kernels/linux-2.6.10-rc2-mm3/mm/swap.c	2004-11-22 10:54:18.000000000 +0000
+++ linux-2.6.10-rc2-mm3-mmcleanup/mm/swap.c	2004-11-23 15:31:55.602409470 +0000
@@ -30,30 +30,11 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/init.h>
+#include "internal.h"
 
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
 
-#ifdef CONFIG_HUGETLB_PAGE
-
-void put_page(struct page *page)
-{
-	if (unlikely(PageCompound(page))) {
-		page = (struct page *)page->private;
-		if (put_page_testzero(page)) {
-			void (*dtor)(struct page *page);
-
-			dtor = (void (*)(struct page *))page[1].mapping;
-			(*dtor)(page);
-		}
-		return;
-	}
-	if (!PageReserved(page) && put_page_testzero(page))
-		__page_cache_release(page);
-}
-EXPORT_SYMBOL(put_page);
-#endif
-
 /*
  * Writeback is about to end against a page which has been marked for immediate
  * reclaim.  If it still appears to be reclaimable, move it to the tail of the
@@ -242,6 +223,14 @@ void release_pages(struct page **pages, 
 	pagevec_free(&pages_to_free);
 }
 
+void __pagevec_free(struct pagevec *pvec)
+{
+	int i = pagevec_count(pvec);
+
+	while (--i >= 0)
+		free_hot_cold_page(pvec->pages[i], pvec->cold);
+}
+
 /*
  * The pages which we're about to release may be in the deferred lru-addition
  * queues.  That would prevent them from really being freed right now.  That's
