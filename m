Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWGCVzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWGCVzz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWGCVzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:55:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46994 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932109AbWGCVzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:55:51 -0400
Date: Mon, 3 Jul 2006 14:55:40 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20060703215540.7566.36862.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 1/8] Rework mmzone.h: Make DMA32 and HIGHMEM optional
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of ZONE_HIGHMEM and ZONE_DMA32 for arches that do not need them.

This patch gets rid of both zones if an arch does not use them. Most 64 bit
arches do not use ZONE_HIGHMEM and only x86_64 uses ZONE_DMA32. So
64 bit arches other than x86_64 will only need 2 zones instead of 4.

With this patch both zones will not be defined. Test operations on the
zones will not do anything but simply return false so that code is not
compiled that first checks if a zone is of this type.

This patch introduces CONFIG_ZONE_DMA32 that must be defined by an
arch to get the ZONE_DMA32 zone defined. The CONFIG_DMA_IS_DMA32 and the
CONFIG_DMA_IS_NORMAL hack used by IA64 to sort out what DMA32 means if
there is no DMA32 zone is removed.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/mmzone.h	2006-07-03 13:47:21.738209377 -0700
+++ linux-2.6.17-mm6/include/linux/mmzone.h	2006-07-03 13:51:27.686865769 -0700
@@ -87,15 +87,57 @@ struct per_cpu_pageset {
 #define zone_pcp(__z, __cpu) (&(__z)->pageset[(__cpu)])
 #endif
 
-#define ZONE_DMA		0
-#define ZONE_DMA32		1
-#define ZONE_NORMAL		2
-#define ZONE_HIGHMEM		3
+typedef enum {
+	/*
+	 * ZONE_DMA is used when there are devices that are not able
+	 * to do DMA to all of addressable memory (ZONE_NORMAL). Then we
+	 * carve out the portion of memory that is needed for these devices.
+	 * The range is arch specific.
+	 *
+	 * Some examples
+	 *
+	 * Architecture		Limit
+	 * ---------------------------
+	 * parisc, ia64, sparc	<4G
+	 * s390			<2G
+	 * arm26		<48M
+	 * arm			Various
+	 * alpha		Unlimited or 0-16MB.
+	 *
+	 * i386, x86_64 and multiple other arches
+	 * 			<16M.
+	 */
+	ZONE_DMA,
+#ifdef CONFIG_ZONE_DMA32
+	/*
+	 * x86_64 needs two ZONE_DMAs because it supports devices that are
+	 * only able to do DMA to the lower 16M but also 32 bit devices that
+	 * can only do DMA to the lower 4G.
+	 */
+	ZONE_DMA32,
+#endif
+	/*
+	 * Normal addressable memory is in ZONE_NORMAL. DMA operations can be
+	 * performed on pages in ZONE_NORMAL if the DMA devices support
+	 * transfers to all addressable memory.
+	 */
+	ZONE_NORMAL,
+#ifdef CONFIG_HIGHMEM
+	/*
+	 * A memory area that is only addressable by the kernel through
+	 * mapping portions into its own address space. This is for example
+	 * used by i386 to allow the kernel to address the memory beyond
+	 * 4G. The kernel will set up special mappings (page
+	 * table entries on i386) for each page that the kernel needs to
+	 * access.
+	 */
+	ZONE_HIGHMEM,
+#endif
+	MAX_NR_ZONES
+} zones_t;
 
-#define MAX_NR_ZONES		4	/* Sync this with ZONES_SHIFT */
 #define ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
 
-
 /*
  * When a memory allocation must conform to specific limitations (such
  * as being suitable for DMA) the caller will pass in hints to the
@@ -125,16 +167,6 @@ struct per_cpu_pageset {
 /* #define GFP_ZONETYPES       (GFP_ZONEMASK + 1) */           /* Non-loner */
 #define GFP_ZONETYPES  ((GFP_ZONEMASK + 1) / 2 + 1)            /* Loner */
 
-/*
- * On machines where it is needed (eg PCs) we divide physical memory
- * into multiple physical zones. On a 32bit PC we have 4 zones:
- *
- * ZONE_DMA	  < 16 MB	ISA DMA capable memory
- * ZONE_DMA32	     0 MB 	Empty
- * ZONE_NORMAL	16-896 MB	direct mapped by the kernel
- * ZONE_HIGHMEM	 > 896 MB	only page cache and user processes
- */
-
 struct zone {
 	/* Fields commonly accessed by the page allocator */
 	unsigned long		free_pages;
@@ -380,7 +412,11 @@ static inline int populated_zone(struct 
 
 static inline int is_highmem_idx(int idx)
 {
+#ifdef CONFIG_HIGHMEM
 	return (idx == ZONE_HIGHMEM);
+#else
+	return 0;
+#endif
 }
 
 static inline int is_normal_idx(int idx)
@@ -396,7 +432,11 @@ static inline int is_normal_idx(int idx)
  */
 static inline int is_highmem(struct zone *zone)
 {
+#ifdef CONFIG_HIGHMEM
 	return zone == zone->zone_pgdat->node_zones + ZONE_HIGHMEM;
+#else
+	return 0;
+#endif
 }
 
 static inline int is_normal(struct zone *zone)
@@ -406,7 +446,11 @@ static inline int is_normal(struct zone 
 
 static inline int is_dma32(struct zone *zone)
 {
+#ifdef CONFIG_ZONE_DMA32
 	return zone == zone->zone_pgdat->node_zones + ZONE_DMA32;
+#else
+	return 0;
+#endif
 }
 
 static inline int is_dma(struct zone *zone)
Index: linux-2.6.17-mm6/mm/page_alloc.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/page_alloc.c	2006-07-03 13:47:22.634638312 -0700
+++ linux-2.6.17-mm6/mm/page_alloc.c	2006-07-03 13:51:27.688818773 -0700
@@ -69,7 +69,15 @@ static void __free_pages_ok(struct page 
  * TBD: should special case ZONE_DMA32 machines here - in those we normally
  * don't need any ZONE_NORMAL reservation
  */
-int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = { 256, 256, 32 };
+int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = {
+	 256
+#ifdef CONFIG_ZONE_DMA32
+	 , 256
+#endif
+#ifdef CONFIG_HIGHMEM
+	 , 32
+#endif
+};
 
 EXPORT_SYMBOL(totalram_pages);
 
@@ -80,7 +88,17 @@ EXPORT_SYMBOL(totalram_pages);
 struct zone *zone_table[1 << ZONETABLE_SHIFT] __read_mostly;
 EXPORT_SYMBOL(zone_table);
 
-static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
+static char *zone_names[MAX_NR_ZONES] = {
+	 "DMA",
+#ifdef CONFIG_ZONE_DMA32
+	 "DMA32",
+#endif
+	 "Normal",
+#ifdef CONFIG_HIGHMEM
+	 "HighMem"
+#endif
+};
+
 int min_free_kbytes = 1024;
 
 unsigned long __meminitdata nr_kernel_pages;
@@ -1323,8 +1341,13 @@ void si_meminfo_node(struct sysinfo *val
 
 	val->totalram = pgdat->node_present_pages;
 	val->freeram = nr_free_pages_pgdat(pgdat);
+#ifdef CONFIG_HIGHMEM
 	val->totalhigh = pgdat->node_zones[ZONE_HIGHMEM].present_pages;
 	val->freehigh = pgdat->node_zones[ZONE_HIGHMEM].free_pages;
+#else
+	val->totalhigh = 0;
+	val->freehigh = 0;
+#endif
 	val->mem_unit = PAGE_SIZE;
 }
 #endif
@@ -1453,14 +1476,12 @@ static int __meminit build_zonelists_nod
 {
 	struct zone *zone;
 
-	BUG_ON(zone_type > ZONE_HIGHMEM);
+	BUG_ON(zone_type >= MAX_NR_ZONES);
 
 	do {
 		zone = pgdat->node_zones + zone_type;
 		if (populated_zone(zone)) {
-#ifndef CONFIG_HIGHMEM
-			BUG_ON(zone_type > ZONE_NORMAL);
-#endif
+			BUG_ON(is_highmem_idx(zone_type));
 			zonelist->zones[nr_zones++] = zone;
 			check_highest_zone(zone_type);
 		}
@@ -1472,14 +1493,17 @@ static int __meminit build_zonelists_nod
 
 static inline int highest_zone(int zone_bits)
 {
-	int res = ZONE_NORMAL;
+#ifdef CONFIG_HIGHMEM
 	if (zone_bits & (__force int)__GFP_HIGHMEM)
-		res = ZONE_HIGHMEM;
+		return ZONE_HIGHMEM;
+#endif
+#ifdef CONFIG_ZONE_DMA32
 	if (zone_bits & (__force int)__GFP_DMA32)
-		res = ZONE_DMA32;
-	if (zone_bits & (__force int)__GFP_DMA)
-		res = ZONE_DMA;
-	return res;
+		return ZONE_DMA32;
+#endif
+	if ((zone_bits & (__force int)__GFP_DMA))
+		return ZONE_DMA;
+	return ZONE_NORMAL;
 }
 
 #ifdef CONFIG_NUMA
@@ -2091,7 +2115,7 @@ static void __meminit free_area_init_cor
 		if (zholes_size)
 			realsize -= zholes_size[j];
 
-		if (j < ZONE_HIGHMEM)
+		if (!is_highmem_idx(j))
 			nr_kernel_pages += realsize;
 		nr_all_pages += realsize;
 
Index: linux-2.6.17-mm6/include/linux/gfp.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/gfp.h	2006-07-03 13:47:21.552673977 -0700
+++ linux-2.6.17-mm6/include/linux/gfp.h	2006-07-03 13:51:39.988839321 -0700
@@ -13,12 +13,13 @@ struct vm_area_struct;
 /* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low three bits) */
 #define __GFP_DMA	((__force gfp_t)0x01u)
 #define __GFP_HIGHMEM	((__force gfp_t)0x02u)
-#ifdef CONFIG_DMA_IS_DMA32
-#define __GFP_DMA32	((__force gfp_t)0x01)	/* ZONE_DMA is ZONE_DMA32 */
+
+#ifdef CONFIG_ZONE_DMA32
+#define __GFP_DMA32	((__force gfp_t)0x04)	/* Has own ZONE_DMA32 */
 #elif BITS_PER_LONG < 64
 #define __GFP_DMA32	((__force gfp_t)0x00)	/* ZONE_NORMAL is ZONE_DMA32 */
 #else
-#define __GFP_DMA32	((__force gfp_t)0x04)	/* Has own ZONE_DMA32 */
+#define __GFP_DMA32	((__force gfp_t)0x01)	/* ZONE_DMA is ZONE_DMA32 */
 #endif
 
 /*
Index: linux-2.6.17-mm6/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.17-mm6.orig/arch/x86_64/Kconfig	2006-07-03 13:47:14.227931665 -0700
+++ linux-2.6.17-mm6/arch/x86_64/Kconfig	2006-07-03 13:51:27.698583794 -0700
@@ -73,6 +73,10 @@ config GENERIC_ISA_DMA
 	bool
 	default y
 
+config ZONE_DMA32
+	bool
+	default y
+
 config GENERIC_IOMAP
 	bool
 	default y
Index: linux-2.6.17-mm6/arch/ia64/Kconfig
===================================================================
--- linux-2.6.17-mm6.orig/arch/ia64/Kconfig	2006-07-03 13:47:12.766108010 -0700
+++ linux-2.6.17-mm6/arch/ia64/Kconfig	2006-07-03 13:55:32.735187140 -0700
@@ -66,15 +66,6 @@ config IA64_UNCACHED_ALLOCATOR
 	bool
 	select GENERIC_ALLOCATOR
 
-config DMA_IS_DMA32
-	bool
-	default y
-
-config DMA_IS_NORMAL
-	bool
-	depends on IA64_SGI_SN2
-	default y
-
 choice
 	prompt "System type"
 	default IA64_GENERIC
Index: linux-2.6.17-mm6/include/linux/vmstat.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/vmstat.h	2006-07-03 13:47:22.185447343 -0700
+++ linux-2.6.17-mm6/include/linux/vmstat.h	2006-07-03 13:55:21.076728479 -0700
@@ -124,16 +124,14 @@ static inline unsigned long node_page_st
 	struct zone *zones = NODE_DATA(node)->node_zones;
 
 	return
-#ifndef CONFIG_DMA_IS_NORMAL
-#if !defined(CONFIG_DMA_IS_DMA32) && BITS_PER_LONG >= 64
+		zone_page_state(&zones[ZONE_DMA], item) +
+#ifdef CONFIG_ZONE_DMA32
 		zone_page_state(&zones[ZONE_DMA32], item) +
 #endif
-		zone_page_state(&zones[ZONE_NORMAL], item) +
-#endif
 #ifdef CONFIG_HIGHMEM
 		zone_page_state(&zones[ZONE_HIGHMEM], item) +
 #endif
-		zone_page_state(&zones[ZONE_DMA], item);
+		zone_page_state(&zones[ZONE_NORMAL], item);
 }
 
 extern void zone_statistics(struct zonelist *, struct zone *);
