Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWGGXXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWGGXXK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWGGXTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:19:07 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60093 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932390AbWGGXTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:19:00 -0400
Date: Fri, 7 Jul 2006 16:18:46 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Christoph Hellwig <hch@infradead.org>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20060707231846.3790.10365.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
References: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 07/11] Use enum to define zones, reformat and comment
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use enum for zones and reformat zones dependent information

Add comments explaning the use of zones and add a zones_t type for
zone numbers.

Line up information that will be #ifdefd by the following patches.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/mmzone.h	2006-07-03 13:47:21.738209377 -0700
+++ linux-2.6.17-mm6/include/linux/mmzone.h	2006-07-07 15:07:44.652861225 -0700
@@ -87,14 +87,53 @@ struct per_cpu_pageset {
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
+	/*
+	 * x86_64 needs two ZONE_DMAs because it supports devices that are
+	 * only able to do DMA to the lower 16M but also 32 bit devices that
+	 * can only do DMA areas below 4G.
+	 */
+	ZONE_DMA32,
+	/*
+	 * Normal addressable memory is in ZONE_NORMAL. DMA operations can be
+	 * performed on pages in ZONE_NORMAL if the DMA devices support
+	 * transfers to all addressable memory.
+	 */
+	ZONE_NORMAL,
+	/*
+	 * A memory area that is only addressable by the kernel through
+	 * mapping portions into its own address space. This is for example
+	 * used by i386 to allow the kernel to address the memory beyond
+	 * 900MB. The kernel will set up special mappings (page
+	 * table entries on i386) for each page that the kernel needs to
+	 * access.
+	 */
+	ZONE_HIGHMEM,
 
-#define MAX_NR_ZONES		4	/* Sync this with ZONES_SHIFT */
-#define ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
+	MAX_NR_ZONES
+} zones_t;
 
+#define	ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
 
 /*
  * When a memory allocation must conform to specific limitations (such
@@ -125,16 +164,6 @@ struct per_cpu_pageset {
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
@@ -270,7 +299,6 @@ struct zone {
 	char			*name;
 } ____cacheline_internodealigned_in_smp;
 
-
 /*
  * The "priority" of VM scanning is how much of the queues we will scan in one
  * go. A value of 12 for DEF_PRIORITY implies that we will scan 1/4096th of the
@@ -378,12 +406,12 @@ static inline int populated_zone(struct 
 	return (!!zone->present_pages);
 }
 
-static inline int is_highmem_idx(int idx)
+static inline int is_highmem_idx(zones_t idx)
 {
 	return (idx == ZONE_HIGHMEM);
 }
 
-static inline int is_normal_idx(int idx)
+static inline int is_normal_idx(zones_t idx)
 {
 	return (idx == ZONE_NORMAL);
 }
Index: linux-2.6.17-mm6/mm/page_alloc.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/page_alloc.c	2006-07-07 15:07:41.676482357 -0700
+++ linux-2.6.17-mm6/mm/page_alloc.c	2006-07-07 15:07:44.654814230 -0700
@@ -68,7 +68,11 @@ static void __free_pages_ok(struct page 
  * TBD: should special case ZONE_DMA32 machines here - in those we normally
  * don't need any ZONE_NORMAL reservation
  */
-int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = { 256, 256, 32 };
+int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = {
+	 256,
+	 256,
+	 32
+};
 
 EXPORT_SYMBOL(totalram_pages);
 
@@ -79,7 +83,13 @@ EXPORT_SYMBOL(totalram_pages);
 struct zone *zone_table[1 << ZONETABLE_SHIFT] __read_mostly;
 EXPORT_SYMBOL(zone_table);
 
-static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
+static char *zone_names[MAX_NR_ZONES] = {
+	 "DMA",
+	 "DMA32",
+	 "Normal",
+	 "HighMem"
+};
+
 int min_free_kbytes = 1024;
 
 unsigned long __meminitdata nr_kernel_pages;
@@ -1585,7 +1595,8 @@ static void __meminit build_zonelists(pg
 
 static void __meminit build_zonelists(pg_data_t *pgdat)
 {
-	int i, j, k, node, local_node;
+	int i, node, local_node;
+	zones_t k,j;
 
 	local_node = pgdat->node_id;
 	for (i = 0; i < GFP_ZONETYPES; i++) {
@@ -1776,8 +1787,8 @@ void zone_init_free_lists(struct pglist_
 }
 
 #define ZONETABLE_INDEX(x, zone_nr)	((x << ZONES_SHIFT) | zone_nr)
-void zonetable_add(struct zone *zone, int nid, int zid, unsigned long pfn,
-		unsigned long size)
+void zonetable_add(struct zone *zone, int nid, zones_t zid,
+		unsigned long pfn, unsigned long size)
 {
 	unsigned long snum = pfn_to_section_nr(pfn);
 	unsigned long end = pfn_to_section_nr(pfn + size);
@@ -2059,7 +2070,7 @@ __meminit int init_currently_empty_zone(
 static void __meminit free_area_init_core(struct pglist_data *pgdat,
 		unsigned long *zones_size, unsigned long *zholes_size)
 {
-	unsigned long j;
+	zones_t j;
 	int nid = pgdat->node_id;
 	unsigned long zone_start_pfn = pgdat->node_start_pfn;
 	int ret;
Index: linux-2.6.17-mm6/include/linux/mm.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/mm.h	2006-07-05 23:32:04.193233853 -0700
+++ linux-2.6.17-mm6/include/linux/mm.h	2006-07-07 15:07:44.661649745 -0700
@@ -474,7 +474,7 @@ void split_page(struct page *page, unsig
 #define SECTIONS_MASK		((1UL << SECTIONS_WIDTH) - 1)
 #define ZONETABLE_MASK		((1UL << ZONETABLE_SHIFT) - 1)
 
-static inline unsigned long page_zonenum(struct page *page)
+static inline zones_t page_zonenum(struct page *page)
 {
 	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
 }
@@ -503,11 +503,12 @@ static inline unsigned long page_to_sect
 	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
 }
 
-static inline void set_page_zone(struct page *page, unsigned long zone)
+static inline void set_page_zone(struct page *page, zones_t zone)
 {
 	page->flags &= ~(ZONES_MASK << ZONES_PGSHIFT);
 	page->flags |= (zone & ZONES_MASK) << ZONES_PGSHIFT;
 }
+
 static inline void set_page_node(struct page *page, unsigned long node)
 {
 	page->flags &= ~(NODES_MASK << NODES_PGSHIFT);
@@ -519,7 +520,7 @@ static inline void set_page_section(stru
 	page->flags |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
 }
 
-static inline void set_page_links(struct page *page, unsigned long zone,
+static inline void set_page_links(struct page *page, zones_t zone,
 	unsigned long node, unsigned long pfn)
 {
 	set_page_zone(page, zone);
