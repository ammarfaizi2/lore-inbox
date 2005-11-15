Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbVKOQvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbVKOQvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbVKOQuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:50:35 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:42412 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S964935AbVKOQuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:50:15 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, mingo@elte.hu, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, lhms-devel@lists.sourceforge.net
Message-Id: <20051115165012.21980.51131.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 5/5] Light Fragmentation Avoidance V20: 005_configurable
Date: Tue, 15 Nov 2005 16:50:14 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The anti-defragmentation strategy has memory overhead. This patch allows
the strategy to be disabled for small memory systems or if it is known the
workload is suffering because of the strategy. It also acts to show where
the anti-defrag strategy interacts with the standard buddy allocator.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-004_percpu/include/linux/gfp.h linux-2.6.14-mm2-005_configurable/include/linux/gfp.h
--- linux-2.6.14-mm2-004_percpu/include/linux/gfp.h	2005-11-15 12:40:42.000000000 +0000
+++ linux-2.6.14-mm2-005_configurable/include/linux/gfp.h	2005-11-15 12:45:06.000000000 +0000
@@ -54,7 +54,11 @@ struct vm_area_struct;
  * Allocation type modifier
  * __GFP_EASYRCLM: Easily reclaimed pages like userspace or buffer pages
  */
+#ifdef CONFIG_PAGEALLOC_ANTIDEFRAG
 #define __GFP_EASYRCLM   0x80000u  /* User and other easily reclaimed pages */
+#else
+#define __GFP_EASYRCLM   0x0u
+#endif /* CONFIG_PAGEALLOC_ANTIDEFRAG */
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-004_percpu/include/linux/mmzone.h linux-2.6.14-mm2-005_configurable/include/linux/mmzone.h
--- linux-2.6.14-mm2-004_percpu/include/linux/mmzone.h	2005-11-15 12:44:23.000000000 +0000
+++ linux-2.6.14-mm2-005_configurable/include/linux/mmzone.h	2005-11-15 12:45:06.000000000 +0000
@@ -23,9 +23,17 @@
 #endif
 #define PAGES_PER_MAXORDER (1 << (MAX_ORDER-1))
 
+#ifdef CONFIG_PAGEALLOC_ANTIDEFRAG
 #define RCLM_NORCLM   0
 #define RCLM_EASY     1
 #define RCLM_TYPES    2
+#define BITS_PER_RCLM_TYPE 1
+#else
+#define RCLM_NORCLM   0
+#define RCLM_EASY     0
+#define RCLM_TYPES    1
+#define BITS_PER_RCLM_TYPE 0
+#endif
 
 #define for_each_rclmtype(type) \
 	for (type = 0; type < RCLM_TYPES; type++)
@@ -76,7 +84,11 @@ struct per_cpu_pageset {
 } ____cacheline_aligned_in_smp;
 
 /* Helpers for per_cpu_pages */
+#ifdef CONFIG_PAGEALLOC_ANTIDEFRAG
 #define pcp_count(pcp) (pcp.count[RCLM_NORCLM] + pcp.count[RCLM_EASY])
+#else
+#define pcp_count(pcp) (pcp.count[RCLM_NORCLM])
+#endif /* CONFIG_PAGEALLOC_ANTIDEFRAG */
 
 #ifdef CONFIG_NUMA
 #define zone_pcp(__z, __cpu) ((__z)->pageset[(__cpu)])
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-004_percpu/init/Kconfig linux-2.6.14-mm2-005_configurable/init/Kconfig
--- linux-2.6.14-mm2-004_percpu/init/Kconfig	2005-11-13 21:22:26.000000000 +0000
+++ linux-2.6.14-mm2-005_configurable/init/Kconfig	2005-11-15 12:45:06.000000000 +0000
@@ -392,6 +392,18 @@ config CC_ALIGN_FUNCTIONS
 	  32-byte boundary only if this can be done by skipping 23 bytes or less.
 	  Zero means use compiler's default.
 
+config PAGEALLOC_ANTIDEFRAG
+	bool "Avoid fragmentation in the page allocator"
+	def_bool n
+	help
+	  The standard allocator will fragment memory over time which means that
+	  high order allocations will fail even if kswapd is running. If this
+	  option is set, the allocator will try and group page types into
+	  two groups, kernel and easy reclaimable. The gain is a best effort
+	  attempt at lowering fragmentation which a few workloads care about.
+	  The loss is a more complex allocactor that performs slower.
+	  If unsure, say N
+
 config CC_ALIGN_LABELS
 	int "Label alignment" if EMBEDDED
 	default 0
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.14-mm2-004_percpu/mm/page_alloc.c linux-2.6.14-mm2-005_configurable/mm/page_alloc.c
--- linux-2.6.14-mm2-004_percpu/mm/page_alloc.c	2005-11-15 12:44:23.000000000 +0000
+++ linux-2.6.14-mm2-005_configurable/mm/page_alloc.c	2005-11-15 12:45:06.000000000 +0000
@@ -73,6 +73,7 @@ static inline int gfpflags_to_alloctype(
 	return ((gfp_flags & __GFP_EASYRCLM) != 0);
 }
 
+#ifdef CONFIG_PAGEALLOC_ANTIDEFRAG
 static inline int get_pageblock_type(struct zone *zone, struct page *page)
 {
 	unsigned long pfn = page_to_pfn(page);
@@ -85,6 +86,9 @@ static inline void change_pageblock_type
 	unsigned long pfn = page_to_pfn(page);
 	__change_bit(pfn_to_bitidx(zone, pfn), pfn_to_usemap(zone, pfn));
 }
+#else
+#define get_pageblock_type(zone, type) RCLM_NORCLM
+#endif /* CONFIG_PAGEALLOC_ANTIDEFRAG */
 
 /*
  * Used by page_zone() to look up the address of the struct zone whose
@@ -279,12 +283,16 @@ __find_combined_index(unsigned long page
 /*
  * Return the free list for a given page within a zone
  */
+#ifdef CONFIG_PAGEALLOC_ANTIDEFRAG
 static inline struct free_area *__page_find_freelist(struct zone *zone,
 							struct page *page,
 							int order)
 {
 	return &zone->free_area_lists[get_pageblock_type(zone, page)][order];
 }
+#else
+#define __page_find_freelist(z, p, o) &zone->free_area_lists[RCLM_NORCLM][o]
+#endif /* CONFIG_PAGEALLOC_ANTIDEFRAG */
 
 /*
  * This function checks whether a page is free && is the buddy
@@ -524,6 +532,7 @@ static void prep_new_page(struct page *p
 	kernel_map_pages(page, 1 << order, 1);
 }
 
+#ifdef CONFIG_PAGEALLOC_ANTIDEFRAG
 /* Remove an element from the buddy allocator from the fallback list */
 static struct page *__rmqueue_fallback(struct zone *zone, int order,
 							int alloctype)
@@ -562,6 +571,13 @@ static struct page *__rmqueue_fallback(s
 
 	return NULL;
 }
+#else
+static struct page *__rmqueue_fallback(struct zone *zone, unsigned int order,
+							int alloctype)
+{
+	return NULL;
+}
+#endif /* CONFIG_PAGEALLOC_ANTIDEFRAG */
 
 /* 
  * Do the hard work of removing an element from the buddy allocator.
@@ -1985,6 +2001,7 @@ static unsigned long __init usemap_size(
 	usemapsize = roundup(zonesize, PAGES_PER_MAXORDER);
 	usemapsize = usemapsize >> (MAX_ORDER-1);
 	usemapsize = roundup(usemapsize, 8 * sizeof(unsigned long));
+	usemapsize *= BITS_PER_RCLM_TYPE;
 
 	return usemapsize / 8;
 }
@@ -1993,9 +2010,11 @@ static void __init setup_usemap(struct p
 				struct zone *zone, unsigned long zonesize)
 {
 	unsigned long usemapsize = usemap_size(zonesize);
-	zone->free_area_usemap = alloc_bootmem_node(pgdat, usemapsize);
-	memset(zone->free_area_usemap, ~RCLM_NORCLM, usemapsize);
-	memset(zone->free_area_usemap, RCLM_NORCLM, usemapsize/2);
+	if (usemapsize != 0) {
+		zone->free_area_usemap = alloc_bootmem_node(pgdat, usemapsize);
+		memset(zone->free_area_usemap, ~RCLM_NORCLM, usemapsize);
+		memset(zone->free_area_usemap, RCLM_NORCLM, usemapsize/2);
+	}
 }
 #else
 static void inline setup_usemap(struct pglist_data *pgdat,
