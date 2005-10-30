Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbVJ3Sef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVJ3Sef (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 13:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVJ3SeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 13:34:13 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:41899 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932205AbVJ3SeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 13:34:09 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: akpm@osdl.org
Cc: linux-mm@kvack.org, Mel Gorman <mel@csn.ul.ie>,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Message-Id: <20051030183404.22266.74092.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie>
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 2/7] Fragmentation Avoidance V19: 002_usemap
Date: Sun, 30 Oct 2005 18:34:05 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a "usemap" to the allocator. When a PAGE_PER_MAXORDER block
of pages (i.e. 2^(MAX_ORDER-1)) is split, the usemap is updated with the
type of allocation when splitting. This information is used in an 
anti-fragmentation patch to group related allocation types together.

The __GFP_EASYRCLM and __GFP_KERNRCLM bits are used to enumerate three allocation
types;

RCLM_NORLM:	These are kernel allocations that cannot be reclaimed
		on demand.
RCLM_EASY:	These are pages allocated with __GFP_EASYRCLM flag set. They are
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
Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-001_antidefrag_flags/include/linux/mm.h linux-2.6.14-rc5-mm1-002_usemap/include/linux/mm.h
--- linux-2.6.14-rc5-mm1-001_antidefrag_flags/include/linux/mm.h	2005-10-30 13:20:05.000000000 +0000
+++ linux-2.6.14-rc5-mm1-002_usemap/include/linux/mm.h	2005-10-30 13:35:31.000000000 +0000
@@ -529,6 +529,12 @@ static inline void set_page_links(struct
 extern struct page *mem_map;
 #endif
 
+/*
+ * Return what type of page this 2^(MAX_ORDER-1) block of pages is being
+ * used for. Return value is one of the RCLM_X types
+ */
+extern int get_pageblock_type(struct zone *zone, struct page *page);
+
 static inline void *lowmem_page_address(struct page *page)
 {
 	return __va(page_to_pfn(page) << PAGE_SHIFT);
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-001_antidefrag_flags/include/linux/mmzone.h linux-2.6.14-rc5-mm1-002_usemap/include/linux/mmzone.h
--- linux-2.6.14-rc5-mm1-001_antidefrag_flags/include/linux/mmzone.h	2005-10-30 13:20:05.000000000 +0000
+++ linux-2.6.14-rc5-mm1-002_usemap/include/linux/mmzone.h	2005-10-30 13:35:31.000000000 +0000
@@ -21,6 +21,17 @@
 #else
 #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
 #endif
+#define PAGES_PER_MAXORDER (1 << (MAX_ORDER-1))
+
+/*
+ * The two bit field __GFP_RECLAIMBITS enumerates the following types of
+ * page reclaimability.
+ */
+#define RCLM_NORCLM   0
+#define RCLM_EASY     1
+#define RCLM_KERN     2
+#define RCLM_TYPES    3
+#define BITS_PER_RCLM_TYPE 2
 
 struct free_area {
 	struct list_head	free_list;
@@ -146,6 +157,13 @@ struct zone {
 #endif
 	struct free_area	free_area[MAX_ORDER];
 
+#ifndef CONFIG_SPARSEMEM
+	/*
+	 * The map tracks what each 2^MAX_ORDER-1 sized block is being used for.
+	 * Each PAGES_PER_MAXORDER block of pages use BITS_PER_RCLM_TYPE bits
+	 */
+	unsigned long		*free_area_usemap;
+#endif
 
 	ZONE_PADDING(_pad1_)
 
@@ -501,9 +519,14 @@ extern struct pglist_data contig_page_da
 #define PAGES_PER_SECTION       (1UL << PFN_SECTION_SHIFT)
 #define PAGE_SECTION_MASK	(~(PAGES_PER_SECTION-1))
 
+#define FREE_AREA_BITS		64
+
 #if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
 #error Allocator MAX_ORDER exceeds SECTION_SIZE
 #endif
+#if ((SECTION_SIZE_BITS - MAX_ORDER) * BITS_PER_RCLM_TYPE) > FREE_AREA_BITS
+#error free_area_usemap is not big enough
+#endif
 
 struct page;
 struct mem_section {
@@ -516,6 +539,7 @@ struct mem_section {
 	 * before using it wrong.
 	 */
 	unsigned long section_mem_map;
+	DECLARE_BITMAP(free_area_usemap, FREE_AREA_BITS);
 };
 
 #ifdef CONFIG_SPARSEMEM_EXTREME
@@ -584,6 +608,18 @@ static inline struct mem_section *__pfn_
 	return __nr_to_section(pfn_to_section_nr(pfn));
 }
 
+static inline unsigned long *pfn_to_usemap(struct zone *zone,
+						unsigned long pfn)
+{
+	return &__pfn_to_section(pfn)->free_area_usemap[0];
+}
+
+static inline int pfn_to_bitidx(struct zone *zone, unsigned long pfn)
+{
+	pfn &= (PAGES_PER_SECTION-1);
+	return (pfn >> (MAX_ORDER-1)) * BITS_PER_RCLM_TYPE;
+}
+
 #define pfn_to_page(pfn) 						\
 ({ 									\
 	unsigned long __pfn = (pfn);					\
@@ -621,6 +657,17 @@ void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
 #define sparse_index_init(_sec, _nid)  do {} while (0)
+static inline unsigned long *pfn_to_usemap(struct zone *zone,
+						unsigned long pfn)
+{
+	return zone->free_area_usemap;
+}
+
+static inline int pfn_to_bitidx(struct zone *zone, unsigned long pfn)
+{
+	pfn = pfn - zone->zone_start_pfn;
+	return (pfn >> (MAX_ORDER-1)) * BITS_PER_RCLM_TYPE;
+}
 #endif /* CONFIG_SPARSEMEM */
 
 #ifdef CONFIG_NODES_SPAN_OTHER_NODES
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-rc5-mm1-001_antidefrag_flags/mm/page_alloc.c linux-2.6.14-rc5-mm1-002_usemap/mm/page_alloc.c
--- linux-2.6.14-rc5-mm1-001_antidefrag_flags/mm/page_alloc.c	2005-10-30 13:20:06.000000000 +0000
+++ linux-2.6.14-rc5-mm1-002_usemap/mm/page_alloc.c	2005-10-30 13:35:31.000000000 +0000
@@ -69,6 +69,99 @@ int sysctl_lowmem_reserve_ratio[MAX_NR_Z
 EXPORT_SYMBOL(totalram_pages);
 
 /*
+ * RCLM_SHIFT is the number of bits that a gfp_mask has to be shifted right
+ * to have just the __GFP_EASYRCLM and __GFP_KERNRCLM bits. The static check
+ * is made afterwards in case the GFP flags are not updated without updating
+ * this number
+ */
+#define RCLM_SHIFT 19
+#if (__GFP_EASYRCLM >> RCLM_SHIFT) != RCLM_EASY
+#error __GFP_EASYRCLM not mapping to RCLM_EASY
+#endif
+#if (__GFP_KERNRCLM >> RCLM_SHIFT) != RCLM_KERN
+#error __GFP_KERNRCLM not mapping to RCLM_KERN
+#endif
+
+/*
+ * This function maps gfpflags to their RCLM_TYPE. It makes assumptions
+ * on the location of the GFP flags.
+ */
+static inline int gfpflags_to_rclmtype(gfp_t gfp_flags)
+{
+	unsigned long rclmbits = gfp_flags & __GFP_RCLM_BITS;
+
+	/* Specifying both RCLM flags makes no sense */
+	if (unlikely(rclmbits == __GFP_RCLM_BITS)) {
+		printk(KERN_WARNING "Multiple RCLM GFP flags specified\n");
+		dump_stack();
+		return RCLM_TYPES;
+	}
+
+	return rclmbits >> RCLM_SHIFT;
+}
+
+/*
+ * copy_bits - Copy bits between bitmaps
+ * @dstaddr: The destination bitmap to copy to
+ * @srcaddr: The source bitmap to copy from
+ * @sindex_dst: The start bit index within the destination map to copy to
+ * @sindex_src: The start bit index within the source map to copy from
+ * @nr: The number of bits to copy
+ *
+ * Note that this method is slow and makes no guarantees for atomicity.
+ * It depends on being called with the zone spinlock held to ensure data
+ * safety
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
+	for (nr = nr - 1; nr >= 0; nr--) {
+		int bit = test_bit(sindex_src + nr, srcaddr);
+		if (bit)
+			set_bit(sindex_dst + nr, dstaddr);
+		else
+			clear_bit(sindex_dst + nr, dstaddr);
+	}
+}
+
+int get_pageblock_type(struct zone *zone, struct page *page)
+{
+	unsigned long pfn = page_to_pfn(page);
+	unsigned long type = 0;
+	unsigned long *usemap;
+	int bitidx;
+
+	bitidx = pfn_to_bitidx(zone, pfn);
+	usemap = pfn_to_usemap(zone, pfn);
+
+	copy_bits(&type, usemap, 0, bitidx, BITS_PER_RCLM_TYPE);
+
+	return type;
+}
+
+/* Reserve a block of pages for an allocation type */
+static inline void set_pageblock_type(struct zone *zone, struct page *page,
+					int type)
+{
+	unsigned long pfn = page_to_pfn(page);
+	unsigned long *usemap;
+	unsigned long ltype = type;
+	int bitidx;
+
+	bitidx = pfn_to_bitidx(zone, pfn);
+	usemap = pfn_to_usemap(zone, pfn);
+
+	copy_bits(usemap, &ltype, bitidx, 0, BITS_PER_RCLM_TYPE);
+}
+
+/*
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
  */
@@ -498,7 +591,8 @@ static void prep_new_page(struct page *p
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
  */
-static struct page *__rmqueue(struct zone *zone, unsigned int order)
+static struct page *__rmqueue(struct zone *zone, unsigned int order,
+					int alloctype)
 {
 	struct free_area * area;
 	unsigned int current_order;
@@ -514,6 +608,14 @@ static struct page *__rmqueue(struct zon
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
 
@@ -526,7 +628,8 @@ static struct page *__rmqueue(struct zon
  * Returns the number of new pages which were placed at *list.
  */
 static int rmqueue_bulk(struct zone *zone, unsigned int order, 
-			unsigned long count, struct list_head *list)
+			unsigned long count, struct list_head *list,
+			int alloctype)
 {
 	unsigned long flags;
 	int i;
@@ -535,7 +638,7 @@ static int rmqueue_bulk(struct zone *zon
 	
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, alloctype);
 		if (page == NULL)
 			break;
 		allocated++;
@@ -719,6 +822,11 @@ buffered_rmqueue(struct zone *zone, int 
 	unsigned long flags;
 	struct page *page = NULL;
 	int cold = !!(gfp_flags & __GFP_COLD);
+	int alloctype = gfpflags_to_rclmtype(gfp_flags);
+
+	/* If the alloctype is RCLM_TYPES, the gfp_flags make no sense */
+	if (alloctype == RCLM_TYPES)
+		return NULL;
 
 	if (order == 0) {
 		struct per_cpu_pages *pcp;
@@ -727,7 +835,8 @@ buffered_rmqueue(struct zone *zone, int 
 		local_irq_save(flags);
 		if (pcp->count <= pcp->low)
 			pcp->count += rmqueue_bulk(zone, 0,
-						pcp->batch, &pcp->list);
+						pcp->batch, &pcp->list,
+						alloctype);
 		if (pcp->count) {
 			page = list_entry(pcp->list.next, struct page, lru);
 			list_del(&page->lru);
@@ -739,7 +848,7 @@ buffered_rmqueue(struct zone *zone, int 
 
 	if (page == NULL) {
 		spin_lock_irqsave(&zone->lock, flags);
-		page = __rmqueue(zone, order);
+		page = __rmqueue(zone, order, alloctype);
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
 
@@ -1866,6 +1975,38 @@ inline void setup_pageset(struct per_cpu
 	INIT_LIST_HEAD(&pcp->list);
 }
 
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
+#else
+static void inline setup_usemap(struct pglist_data *pgdat,
+				struct zone *zone, unsigned long zonesize) {}
+#endif /* CONFIG_SPARSEMEM */
+
 #ifdef CONFIG_NUMA
 /*
  * Boot pageset table. One per cpu which is going to be used for all
@@ -2079,6 +2220,7 @@ static void __init free_area_init_core(s
 		zonetable_add(zone, nid, j, zone_start_pfn, size);
 		init_currently_empty_zone(zone, zone_start_pfn, size);
 		zone_start_pfn += size;
+		setup_usemap(pgdat, zone, size);
 	}
 }
 
