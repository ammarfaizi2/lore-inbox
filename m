Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbVKOQuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbVKOQuB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbVKOQuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:50:01 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:35500 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S964928AbVKOQuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:50:00 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, mingo@elte.hu,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Message-Id: <20051115164957.21980.8731.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 2/5] Light Fragmentation Avoidance V20: 002_usemap
Date: Tue, 15 Nov 2005 16:49:59 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a "usemap" to the allocator. Each bit in the usemap indicates
whether a block of 2^(MAX_ORDER-1) pages are being used for kernel or
easily-reclaimed allocations. This enumerates two types of allocations;

RCLM_NORLM:	These are kernel allocations that cannot be reclaimed
		on demand.
RCLM_EASY:	These are pages allocated with __GFP_EASYRCLM flag set. They are
		considered to be user and other easily reclaimed pages such
		as buffers

gfpflags_to_rclmtype() converts gfp_flags to their corresponding RCLM_TYPE.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-001_antidefrag_flags/include/linux/mmzone.h linux-2.6.14-mm2-002_usemap/include/linux/mmzone.h
--- linux-2.6.14-mm2-001_antidefrag_flags/include/linux/mmzone.h	2005-11-13 21:22:26.000000000 +0000
+++ linux-2.6.14-mm2-002_usemap/include/linux/mmzone.h	2005-11-15 12:42:15.000000000 +0000
@@ -21,6 +21,11 @@
 #else
 #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
 #endif
+#define PAGES_PER_MAXORDER (1 << (MAX_ORDER-1))
+
+#define RCLM_NORCLM   0
+#define RCLM_EASY     1
+#define RCLM_TYPES    2
 
 struct free_area {
 	struct list_head	free_list;
@@ -147,6 +152,12 @@ struct zone {
 #endif
 	struct free_area	free_area[MAX_ORDER];
 
+#ifndef CONFIG_SPARSEMEM
+	/*
+	 * The map tracks what each 2^MAX_ORDER-1 sized block is being used for.
+	 */
+	unsigned long		*free_area_usemap;
+#endif
 
 	ZONE_PADDING(_pad1_)
 
@@ -502,9 +513,14 @@ extern struct pglist_data contig_page_da
 #define PAGES_PER_SECTION       (1UL << PFN_SECTION_SHIFT)
 #define PAGE_SECTION_MASK	(~(PAGES_PER_SECTION-1))
 
+#define FREE_AREA_BITS		64
+
 #if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
 #error Allocator MAX_ORDER exceeds SECTION_SIZE
 #endif
+#if ((SECTION_SIZE_BITS - MAX_ORDER)) > FREE_AREA_BITS
+#error free_area_usemap is not big enough
+#endif
 
 struct page;
 struct mem_section {
@@ -517,6 +533,7 @@ struct mem_section {
 	 * before using it wrong.
 	 */
 	unsigned long section_mem_map;
+	DECLARE_BITMAP(free_area_usemap, FREE_AREA_BITS);
 };
 
 #ifdef CONFIG_SPARSEMEM_EXTREME
@@ -585,6 +602,18 @@ static inline struct mem_section *__pfn_
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
+	return (pfn >> (MAX_ORDER-1));
+}
+
 #define pfn_to_page(pfn) 						\
 ({ 									\
 	unsigned long __pfn = (pfn);					\
@@ -622,6 +651,17 @@ void sparse_init(void);
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
+	return (pfn >> (MAX_ORDER-1));
+}
 #endif /* CONFIG_SPARSEMEM */
 
 #ifdef CONFIG_NODES_SPAN_OTHER_NODES
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-001_antidefrag_flags/mm/page_alloc.c linux-2.6.14-mm2-002_usemap/mm/page_alloc.c
--- linux-2.6.14-mm2-001_antidefrag_flags/mm/page_alloc.c	2005-11-13 21:22:26.000000000 +0000
+++ linux-2.6.14-mm2-002_usemap/mm/page_alloc.c	2005-11-15 12:42:15.000000000 +0000
@@ -68,6 +68,19 @@ int sysctl_lowmem_reserve_ratio[MAX_NR_Z
 
 EXPORT_SYMBOL(totalram_pages);
 
+static inline int get_pageblock_type(struct zone *zone, struct page *page)
+{
+	unsigned long pfn = page_to_pfn(page);
+	return !!test_bit(pfn_to_bitidx(zone, pfn),
+			pfn_to_usemap(zone, pfn));
+}
+
+static inline void change_pageblock_type(struct zone *zone, struct page *page)
+{
+	unsigned long pfn = page_to_pfn(page);
+	__change_bit(pfn_to_bitidx(zone, pfn), pfn_to_usemap(zone, pfn));
+}
+
 /*
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
@@ -1847,6 +1860,38 @@ inline void setup_pageset(struct per_cpu
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
+	memset(zone->free_area_usemap, ~RCLM_NORCLM, usemapsize);
+	memset(zone->free_area_usemap, RCLM_NORCLM, usemapsize/2);
+}
+#else
+static void inline setup_usemap(struct pglist_data *pgdat,
+				struct zone *zone, unsigned long zonesize) {}
+#endif /* CONFIG_SPARSEMEM */
+
 #ifdef CONFIG_NUMA
 /*
  * Boot pageset table. One per cpu which is going to be used for all
@@ -2060,6 +2105,7 @@ static void __init free_area_init_core(s
 		zonetable_add(zone, nid, j, zone_start_pfn, size);
 		init_currently_empty_zone(zone, zone_start_pfn, size);
 		zone_start_pfn += size;
+		setup_usemap(pgdat, zone, size);
 	}
 }
 
