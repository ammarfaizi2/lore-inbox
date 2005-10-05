Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965188AbVJEOqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188AbVJEOqA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbVJEOqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:46:00 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:56974 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932635AbVJEOp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:45:59 -0400
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: akpm@osdl.org, Mel Gorman <mel@csn.ul.ie>, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, jschopp@austin.ibm.com,
       lhms-devel@lists.sourceforge.net
Message-Id: <20051005144557.11796.2110.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
References: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 2/7] Fragmentation Avoidance V16: 002_usemap
Date: Wed,  5 Oct 2005 15:45:57 +0100 (IST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a "usemap" to the allocator. When a PAGE_PER_MAXORDER block
of pages (i.e. 2^(MAX_ORDER-1)) is split, the usemap is updated with the
type of allocation when splitting. This information is used in an 
anti-fragmentation patch to group related allocation types together.

The __GFP_USER and __GFP_KERNRCLM bits are used to enumerate three allocation
types;

RCLM_NORLM:	These are kernel allocations that cannot be reclaimed
		on demand.
RCLM_USER:	These are pages allocated with __GFP_USER flag set. They are
		considered to be user and other easily reclaimed pages such
		as buffers
RCLM_KERN:	Allocated for the kernel but for caches that can be reclaimed
		on demand.

gfpflags_to_rclmtype() converts gfp_flags to their corresponding RCLM_TYPE
by masking out irrelevant bits and shifting the result right by RCLM_SHIFT.
Compile-time checks are made on RCLM_SHIFT to ensure gfpflags_to_rclmtype()
keeps working. ffz() could be used to avoid static checks, but it would be
runtime overhead for a compile-time constant.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-001_antidefrag_flags/include/linux/mm.h linux-2.6.14-rc3-002_usemap/include/linux/mm.h
--- linux-2.6.14-rc3-001_antidefrag_flags/include/linux/mm.h	2005-10-04 22:58:34.000000000 +0100
+++ linux-2.6.14-rc3-002_usemap/include/linux/mm.h	2005-10-05 12:14:02.000000000 +0100
@@ -522,6 +522,13 @@ static inline void set_page_links(struct
 extern struct page *mem_map;
 #endif
 
+/*
+ * Return what type of page is being allocated from this 2^MAX_ORDER-1 block
+ * of pages.
+ */
+extern unsigned int get_pageblock_type(struct zone *zone,
+						struct page *page);
+
 static inline void *lowmem_page_address(struct page *page)
 {
 	return __va(page_to_pfn(page) << PAGE_SHIFT);
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-001_antidefrag_flags/include/linux/mmzone.h linux-2.6.14-rc3-002_usemap/include/linux/mmzone.h
--- linux-2.6.14-rc3-001_antidefrag_flags/include/linux/mmzone.h	2005-10-04 22:58:34.000000000 +0100
+++ linux-2.6.14-rc3-002_usemap/include/linux/mmzone.h	2005-10-05 12:14:02.000000000 +0100
@@ -20,6 +20,17 @@
 #else
 #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
 #endif
+#define PAGES_PER_MAXORDER (1 << (MAX_ORDER-1))
+
+/*
+ * The two bit field __GFP_RECLAIMBITS enumerates the following 4 kinds of
+ * page reclaimability.
+ */
+#define RCLM_NORCLM   0
+#define RCLM_USER     1
+#define RCLM_KERN     2
+#define RCLM_TYPES    3
+#define BITS_PER_RCLM_TYPE 2
 
 struct free_area {
 	struct list_head	free_list;
@@ -139,6 +150,13 @@ struct zone {
 	spinlock_t		lock;
 	struct free_area	free_area[MAX_ORDER];
 
+#ifndef CONFIG_SPARSEMEM
+	/*
+	 * The map tracks what each 2^MAX_ORDER-1 sized block is being used for.
+	 * Each 2^MAX_ORDER block of pages uses BITS_PER_RCLM_TYPE bits
+	 */
+	unsigned long		*free_area_usemap;
+#endif
 
 	ZONE_PADDING(_pad1_)
 
@@ -473,6 +491,15 @@ extern struct pglist_data contig_page_da
 #if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
 #error Allocator MAX_ORDER exceeds SECTION_SIZE
 #endif
+#if ((SECTION_SIZE_BITS - MAX_ORDER) * BITS_PER_RCLM_TYPE) > 64
+#error free_area_usemap is not big enough
+#endif
+
+/* Usemap initialisation */
+#ifdef CONFIG_SPARSEMEM
+static inline void setup_usemap(struct pglist_data *pgdat,
+				struct zone *zone, unsigned long zonesize) {}
+#endif /* CONFIG_SPARSEMEM */
 
 struct page;
 struct mem_section {
@@ -485,6 +512,7 @@ struct mem_section {
 	 * before using it wrong.
 	 */
 	unsigned long section_mem_map;
+	DECLARE_BITMAP(free_area_usemap,64);
 };
 
 #ifdef CONFIG_SPARSEMEM_EXTREME
@@ -552,6 +580,17 @@ static inline struct mem_section *__pfn_
 	return __nr_to_section(pfn_to_section_nr(pfn));
 }
 
+static inline unsigned long *pfn_to_usemap(struct zone *zone, unsigned long pfn)
+{
+	return &__pfn_to_section(pfn)->free_area_usemap[0];
+}
+
+static inline int pfn_to_bitidx(struct zone *zone, unsigned long pfn)
+{
+	pfn &= (PAGES_PER_SECTION-1);
+	return (int)((pfn >> (MAX_ORDER-1)) * BITS_PER_RCLM_TYPE);
+}
+
 #define pfn_to_page(pfn) 						\
 ({ 									\
 	unsigned long __pfn = (pfn);					\
@@ -589,6 +628,16 @@ void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
 #define sparse_index_init(_sec, _nid)  do {} while (0)
+static inline unsigned long *pfn_to_usemap(struct zone *zone, 
+						unsigned long pfn)
+{
+	return (zone->free_area_usemap);
+}
+static inline int pfn_to_bitidx(struct zone *zone, unsigned long pfn)
+{
+	pfn = pfn - zone->zone_start_pfn;
+	return (int)((pfn >> (MAX_ORDER-1)) * BITS_PER_RCLM_TYPE);
+}
 #endif /* CONFIG_SPARSEMEM */
 
 #ifdef CONFIG_NODES_SPAN_OTHER_NODES
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc3-001_antidefrag_flags/mm/page_alloc.c linux-2.6.14-rc3-002_usemap/mm/page_alloc.c
--- linux-2.6.14-rc3-001_antidefrag_flags/mm/page_alloc.c	2005-10-04 22:58:34.000000000 +0100
+++ linux-2.6.14-rc3-002_usemap/mm/page_alloc.c	2005-10-05 12:14:02.000000000 +0100
@@ -66,6 +66,90 @@ EXPORT_SYMBOL(totalram_pages);
 EXPORT_SYMBOL(nr_swap_pages);
 
 /*
+ * RCLM_SHIFT is the number of bits that a gfp_mask has to be shifted right
+ * to have just the __GFP_USER and __GFP_KERNRCLM bits. The static check is
+ * made afterwards in case the GFP flags are not updated without updating 
+ * this number
+ */
+#define RCLM_SHIFT 19
+#if (__GFP_USER >> RCLM_SHIFT) != RCLM_USER
+#error __GFP_USER not mapping to RCLM_USER
+#endif
+#if (__GFP_KERNRCLM >> RCLM_SHIFT) != RCLM_KERN
+#error __GFP_KERNRCLM not mapping to RCLM_KERN
+#endif
+
+/*
+ * This function maps gfpflags to their RCLM_TYPE. It makes assumptions
+ * on the location of the GFP flags
+ */
+static inline int gfpflags_to_rclmtype(unsigned long gfp_flags) {
+	return (gfp_flags & __GFP_RCLM_BITS) >> RCLM_SHIFT;
+}
+
+/*
+ * copy_bits - Copy bits between bitmaps
+ * @dstaddr: The destination bitmap to copy to
+ * @srcaddr: The source bitmap to copy from
+ * @sindex_dst: The start bit index within the destination map to copy to
+ * @sindex_src: The start bit index within the source map to copy from
+ * @nr: The number of bits to copy
+ */
+static inline void copy_bits(unsigned long *dstaddr,
+		unsigned long *srcaddr, 
+		int sindex_dst, 
+		int sindex_src,
+		int nr)
+{
+	/*
+	 * Written like this to take advantage of arch-specific 
+	 * set_bit() and clear_bit() functions
+	 */
+	for (nr = nr-1; nr >= 0; nr--) {
+		int bit = test_bit(sindex_src + nr, srcaddr);
+		if (bit)
+			set_bit(sindex_dst + nr, dstaddr);
+		else
+			clear_bit(sindex_dst + nr, dstaddr);
+	}
+}
+
+unsigned int get_pageblock_type(struct zone *zone,
+						struct page *page)
+{
+	unsigned long pfn = page_to_pfn(page);
+	int bitidx;
+	unsigned int type = 0;
+	unsigned long *usemap;
+
+	bitidx = pfn_to_bitidx(zone, pfn);
+	usemap = pfn_to_usemap(zone, pfn);
+
+	copy_bits((unsigned long *)&type, usemap, 
+			0, bitidx, BITS_PER_RCLM_TYPE);
+
+	return type;
+}
+
+/*
+ * Reserve a block of pages for an allocation type & enforce function
+ * being changed if more bits are added to keep track of additional types
+ */
+static inline void set_pageblock_type(struct zone *zone, struct page *page,
+					int type)
+{
+	unsigned long pfn = page_to_pfn(page);
+	int bitidx;
+	unsigned long *usemap;
+
+	bitidx = pfn_to_bitidx(zone, pfn);
+	usemap = pfn_to_usemap(zone, pfn);
+
+	copy_bits(usemap, (unsigned long *)&type, 
+			bitidx, 0, BITS_PER_RCLM_TYPE);
+}
+
+/*
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
  */
@@ -470,7 +554,8 @@ static void prep_new_page(struct page *p
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
  */
-static struct page *__rmqueue(struct zone *zone, unsigned int order)
+static struct page *__rmqueue(struct zone *zone, unsigned int order, 
+		int alloctype)
 {
 	struct free_area * area;
 	unsigned int current_order;
@@ -486,6 +571,14 @@ static struct page *__rmqueue(struct zon
 		rmv_page_order(page);
 		area->nr_free--;
 		zone->free_pages -= 1UL << order;
+
+		/*
+		 * If splitting a large block, record what the block is being
+		 * used for in the usemap
+		 */
+		if (current_order == MAX_ORDER-1)
+			set_pageblock_type(zone, page, alloctype);
+
 		return expand(zone, page, order, current_order, area);
 	}
 
@@ -498,7 +591,8 @@ static struct page *__rmqueue(struct zon
  * Returns the number of new pages which were placed at *list.
  */
 static int rmqueue_bulk(struct zone *zone, unsigned int order, 
-			unsigned long count, struct list_head *list)
+			unsigned long count, struct list_head *list,
+			int alloctype)
 {
 	unsigned long flags;
 	int i;
@@ -507,7 +601,7 @@ static int rmqueue_bulk(struct zone *zon
 	
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, alloctype);
 		if (page == NULL)
 			break;
 		allocated++;
@@ -691,7 +785,8 @@ buffered_rmqueue(struct zone *zone, int 
 	unsigned long flags;
 	struct page *page = NULL;
 	int cold = !!(gfp_flags & __GFP_COLD);
-
+	int alloctype = gfpflags_to_rclmtype(gfp_flags);
+	
 	if (order == 0) {
 		struct per_cpu_pages *pcp;
 
@@ -699,7 +794,8 @@ buffered_rmqueue(struct zone *zone, int 
 		local_irq_save(flags);
 		if (pcp->count <= pcp->low)
 			pcp->count += rmqueue_bulk(zone, 0,
-						pcp->batch, &pcp->list);
+						pcp->batch, &pcp->list,
+						alloctype);
 		if (pcp->count) {
 			page = list_entry(pcp->list.next, struct page, lru);
 			list_del(&page->lru);
@@ -711,7 +807,7 @@ buffered_rmqueue(struct zone *zone, int 
 
 	if (page == NULL) {
 		spin_lock_irqsave(&zone->lock, flags);
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, alloctype);
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
 
@@ -1870,6 +1966,36 @@ void __init setup_per_cpu_pageset()
 
 #endif
 
+#ifndef CONFIG_SPARSEMEM
+#define roundup(x, y) ((((x)+((y)-1))/(y))*(y))
+/*
+ * Calculate the size of the zone->usemap in bytes rounded to an unsigned long
+ * Start by making sure zonesize is a multiple of MAX_ORDER-1 by rounding up
+ * Then figure 1 RCLM_TYPE worth of bits per MAX_ORDER-1, finally round up
+ * what is now in bits to nearest long in bits, then return it in bytes.
+ */
+static unsigned long __init usemap_size(unsigned long zonesize)
+{
+	unsigned long usemapsize;
+
+	usemapsize = roundup(zonesize, PAGES_PER_MAXORDER);
+	usemapsize = usemapsize >> (MAX_ORDER-1);
+	usemapsize *= BITS_PER_RCLM_TYPE;
+	usemapsize = roundup(usemapsize, 8 * sizeof(unsigned long));
+
+	return usemapsize / 8;
+}
+
+static void __init setup_usemap(struct pglist_data *pgdat,
+				struct zone *zone, unsigned long zonesize)
+{
+	unsigned long usemapsize = usemap_size(zonesize);
+	zone->free_area_usemap = alloc_bootmem_node(pgdat, usemapsize);
+	memset(zone->free_area_usemap, RCLM_NORCLM, usemapsize);
+}
+#endif /* CONFIG_SPARSEMEM */
+
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -1955,6 +2081,7 @@ static void __init free_area_init_core(s
 		memmap_init(size, nid, j, zone_start_pfn);
 
 		zonetable_add(zone, nid, j, zone_start_pfn, size);
+		setup_usemap(pgdat, zone, size);
 
 		zone_start_pfn += size;
 
