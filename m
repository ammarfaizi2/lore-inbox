Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVBARSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVBARSU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 12:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVBARRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 12:17:50 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:16352 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262073AbVBARQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 12:16:42 -0500
To: linux-mm@kvack.org
Subject: [PATCH 2/2] Helping prezoring with reduced fragmentation allocation
Cc: linux-kernel@vger.kernel.org, clameter@sgi.com
Message-Id: <20050201171641.CC15EE5E8@skynet.csn.ul.ie>
Date: Tue,  1 Feb 2005 17:16:41 +0000 (GMT)
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog V1
 o Initial release

This is a patch that makes a step towards tieing the modified allocator
for reducing fragmentation with the prezeroing of pages that is based
on a discussion with Christoph. When a block has to be split to satisfy a
zero-page, both buddies are zero'd, one is allocated and the other is placed
on the free-list for the USERZERO pool. Care is taken to make sure the pools
are not accidently fragmented.

When looking at /proc/buddyinfo, it will seem strange that the number of
blocks free at each order for USERZERO will never get over zero. This is
expected as when a page is freed, it cannot go back into the USERZERO pool
on the assumption it is no longer all zeros.

I would expect that a scrubber daemon would go through the KERNNORCLM pool,
remove pages, scrub them and move them to USERZERO. It is important that pages
not be moved from the USERRCLM or KERNRCLM pools as it'll cause fragmentation
problems over time.

diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.11-rc2-mbuddy/include/linux/mmzone.h linux-2.6.11-rc2-mbuddy-prezero/include/linux/mmzone.h
--- linux-2.6.11-rc2-mbuddy/include/linux/mmzone.h	2005-01-31 12:31:37.000000000 +0000
+++ linux-2.6.11-rc2-mbuddy-prezero/include/linux/mmzone.h	2005-02-01 11:57:57.000000000 +0000
@@ -19,10 +19,11 @@
 #else
 #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
 #endif
-#define ALLOC_TYPES 3
+#define ALLOC_TYPES 4
 #define ALLOC_KERNNORCLM 0
 #define ALLOC_KERNRCLM 1
 #define ALLOC_USERRCLM 2
+#define ALLOC_USERZERO 3
 
 struct free_area {
 	struct list_head	free_list;
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.11-rc2-mbuddy/mm/page_alloc.c linux-2.6.11-rc2-mbuddy-prezero/mm/page_alloc.c
--- linux-2.6.11-rc2-mbuddy/mm/page_alloc.c	2005-02-01 15:10:29.000000000 +0000
+++ linux-2.6.11-rc2-mbuddy-prezero/mm/page_alloc.c	2005-02-01 14:57:47.000000000 +0000
@@ -47,28 +47,39 @@ long nr_swap_pages;
 int sysctl_lower_zone_protection = 0;
 
 /* Bean counters for the per-type buddy allocator */
-int fallback_count[ALLOC_TYPES] = { 0, 0, 0};
+int fallback_count[ALLOC_TYPES] = { 0, 0, 0, 0};
 int global_steal=0;
 int global_refill=0;
 int kernnorclm_count=0;
 int kernrclm_count=0;
 int userrclm_count=0;
+int userzero_count=0;
 
 EXPORT_SYMBOL(totalram_pages);
 EXPORT_SYMBOL(nr_swap_pages);
 
+static inline void prep_zero_page(struct page *page, int order, int gfp_flags);
+
 /**
  * The allocator tries to put allocations of the same type in the
  * same 2^MAX_ORDER blocks of pages. When memory is low, this may
  * not be possible so this describes what order they should fall
  * back on
+ *
+ * The order of the fallback is chosen to keep the userrclm and kernrclm
+ * pools as low as fragmentation as possible. To achieve this, those pools
+ * are only used when they have to be. This seems unusual for USERZERO as
+ * it's name implies it is like USERRCLM but that is not the case. USERZERO
+ * allocations are usually for userspace allocations *but* they are for PTEs
+ * which are difficult to reclaim. Hence the pool is treated more like
+ * KERNNORCLM until such time that PTEs can be reclaimed
  */
 int fallback_allocs[ALLOC_TYPES][ALLOC_TYPES] = { 
-	{ ALLOC_KERNNORCLM, ALLOC_KERNRCLM,   ALLOC_USERRCLM },
-	{ ALLOC_KERNRCLM,   ALLOC_KERNNORCLM, ALLOC_USERRCLM },
-	{ ALLOC_USERRCLM,   ALLOC_KERNNORCLM, ALLOC_KERNRCLM }
+	{ ALLOC_KERNNORCLM,ALLOC_USERZERO,   ALLOC_KERNRCLM,   ALLOC_USERRCLM },
+	{ ALLOC_KERNRCLM,  ALLOC_KERNNORCLM, ALLOC_USERZERO,   ALLOC_USERRCLM },
+	{ ALLOC_USERRCLM,  ALLOC_KERNNORCLM, ALLOC_USERZERO,   ALLOC_KERNRCLM },
+	{ ALLOC_USERZERO,  ALLOC_KERNNORCLM, ALLOC_KERNRCLM,   ALLOC_USERRCLM }
 };
- 
 
 /*
  * Used by page_zone() to look up the address of the struct zone whose
@@ -78,7 +89,8 @@ struct zone *zone_table[1 << (ZONES_SHIF
 EXPORT_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
-static char *type_names[ALLOC_TYPES] = { "KernNoRclm", "KernRclm", "UserRclm"};
+static char *type_names[ALLOC_TYPES] = { "KernNoRclm", "KernRclm", 
+					 "UserRclm", "UserZero"};
 int min_free_kbytes = 1024;
 
 unsigned long __initdata nr_kernel_pages;
@@ -127,14 +139,26 @@ static void bad_page(const char *functio
 
 /*
  * Return what type of use the 2^MAX_ORDER block of pages is in use for
- * that the given page is part of
+ * that the given page is part of. The bitmap is laid out as follows;
+ *
+ * 1. There are two bits to represent the 4 types of allocations.
+ * 2. The index in the bitmap is determined by the page within the mem_map
+ * 3. If no bits are set, it is a kernel non-reclaimable allocation
+ * 4. If bit 0 is set, it is a kernel reclaimable allocation
+ * 5. If bit 1 is set, it is a user reclaimable allocation
+ * 6. If bits 0+1 are set, it is a user allocation of a zero page
  */
 static inline int get_pageblock_type(struct page *page) {
 	struct zone *zone = page_zone(page);
 	int bitidx = ((page - zone->zone_mem_map) >> MAX_ORDER) * 2;
 
 	/* Bit 1 will be set if the block is kernel reclaimable */
-	if (test_bit(bitidx,zone->free_area_usemap)) return ALLOC_KERNRCLM;
+	if (test_bit(bitidx,zone->free_area_usemap)) {
+		if (test_bit(bitidx+1, zone->free_area_usemap))
+			return ALLOC_USERZERO;
+		else
+			return ALLOC_KERNRCLM;
+	}
 
 	/* Bit 2 will be set if the block is user reclaimable */
 	if (test_bit(bitidx+1, zone->free_area_usemap)) return ALLOC_USERRCLM;
@@ -160,6 +184,14 @@ static inline void set_pageblock_type(st
 		return;
 	}
 
+
+	if (type == ALLOC_USERZERO) {
+		set_bit(bitidx,   zone->free_area_usemap);
+		set_bit(bitidx+1, zone->free_area_usemap);
+		return;
+	}
+
+	/* KERNNORCLM allocation */
 	clear_bit(bitidx, zone->free_area_usemap);
 	clear_bit(bitidx+1, zone->free_area_usemap);
 	
@@ -307,6 +339,12 @@ static inline void __free_pages_bulk (st
 
 	/* Select the areas to place free pages on */
 	alloctype = get_pageblock_type(page);
+
+	/*
+	 * Tricky, if the page was originally a zerod page, chances are it
+	 * is not any more
+	 */
+	if (alloctype == ALLOC_USERZERO) alloctype = ALLOC_KERNNORCLM;
 	freelist = zone->free_area_lists[alloctype];
 
 	zone->free_pages += order_size;
@@ -502,7 +540,8 @@ static void prep_new_page(struct page *p
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
  */
-static struct page *__rmqueue(struct zone *zone, unsigned int order, int flags)
+static struct page *__rmqueue(struct zone *zone, unsigned int order, int flags,
+				unsigned long *irq_flags)
 {
 	struct free_area * area;
 	unsigned int current_order;
@@ -514,7 +553,12 @@ static struct page *__rmqueue(struct zon
 	int alloctype;
 	int retry_count=0;
 	int startorder = order;
-	if (flags & __GFP_USERRCLM) {
+
+	if (flags & __GFP_ZERO) {
+		alloctype = ALLOC_USERZERO;
+		userzero_count++;
+	}
+	else if (flags & __GFP_USERRCLM) {
 		alloctype = ALLOC_USERRCLM;
 		userrclm_count++;
 	}
@@ -545,7 +589,45 @@ retry:
 		rmv_page_order(page);
 		area->nr_free--;
 		zone->free_pages -= 1UL << order;
+
+		/*
+		 * If this is a request for a zero page and the page was
+		 * not taken from the USERZERO pool, zero it all
+		 */
+		if ((flags & __GFP_ZERO) && alloctype != ALLOC_USERZERO) {
+			int zero_order=order;
+
+			/*
+			 * This is important. We are about to zero a block
+			 * which may be larger than we need so we have to
+			 * determine do we zero just what we need or do
+			 * we zero the whole block and put the pages in
+			 * the zero page. 
+			 *
+			 * We zero the whole block in the event we are taking
+			 * from the KERNNORCLM pools and otherwise zero just
+			 * what we need. The reason we do not always zero
+			 * everything is because we do not want unreclaimable
+			 * pages to leak into the USERRCLM and KERNRCLM 
+			 * pools
+			 *
+			 */
+			if (alloctype != ALLOC_USERRCLM &&
+			    alloctype != ALLOC_KERNRCLM) {
+				area = zone->free_area_lists[ALLOC_USERZERO] +
+					current_order;
+				zero_order = current_order;
+			}
+
+			
+			spin_unlock_irqrestore(&zone->lock, *irq_flags);
+			prep_zero_page(page, zero_order, flags);
+			spin_lock_irqsave(&zone->lock, *irq_flags);
+
+		}
+
 		return expand(zone, page, order, current_order, area);
+
 	}
 
 	/* Take from the global pool if this is the first attempt */
@@ -562,6 +644,13 @@ retry:
 		global_steal++;
 		global_split=1;
 
+		/* Zero the whole block if this is a __GFP_ZERO allocation */
+		if (alloctype == ALLOC_USERZERO) {
+			spin_unlock_irqrestore(&zone->lock, *irq_flags);
+			prep_zero_page(page, MAX_ORDER-1, flags);
+			spin_lock_irqsave(&zone->lock, *irq_flags);
+		}
+
 		/* Mark this block of pages as for use with this alloc type */
 		set_pageblock_type(page, zone, alloctype);
 		startorder = MAX_ORDER-1;
@@ -597,7 +686,7 @@ static int rmqueue_bulk(struct zone *zon
 	
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
-		page = __rmqueue(zone, order, gfp_flags);
+		page = __rmqueue(zone, order, gfp_flags, &flags);
 		if (page == NULL)
 			break;
 		allocated++;
@@ -775,7 +864,7 @@ buffered_rmqueue(struct zone *zone, int 
 
 	if (page == NULL) {
 		spin_lock_irqsave(&zone->lock, flags);
-		page = __rmqueue(zone, order, gfp_flags);
+		page = __rmqueue(zone, order, gfp_flags, &flags);
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
 
@@ -784,9 +873,6 @@ buffered_rmqueue(struct zone *zone, int 
 		mod_page_state_zone(zone, pgalloc, 1 << order);
 		prep_new_page(page, order);
 
-		if (gfp_flags & __GFP_ZERO)
-			prep_zero_page(page, order, gfp_flags);
-
 		if (order && (gfp_flags & __GFP_COMP))
 			prep_compound_page(page, order);
 	}
@@ -1982,12 +2068,15 @@ static int frag_show(struct seq_file *m,
  	seq_printf(m, "KernNoRclm allocs: %d\n", kernnorclm_count);
  	seq_printf(m, "KernRclm allocs:   %d\n", kernrclm_count);
  	seq_printf(m, "UserRclm allocs:   %d\n", userrclm_count);
+	seq_printf(m, "UserZero allocs:   %d\n", userzero_count);
  	seq_printf(m, "%-10s Fallback count: %d\n", type_names[0], 
 							fallback_count[0]);
  	seq_printf(m, "%-10s Fallback count: %d\n", type_names[1],
 							fallback_count[1]);
  	seq_printf(m, "%-10s Fallback count: %d\n", type_names[2],
 							fallback_count[2]);
+ 	seq_printf(m, "%-10s Fallback count: %d\n", type_names[3],
+							fallback_count[3]);
  
  
 
