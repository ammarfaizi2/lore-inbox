Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWGGXTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWGGXTp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWGGXTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:19:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61373 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932392AbWGGXTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:19:04 -0400
Date: Fri, 7 Jul 2006 16:18:51 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Christoph Hellwig <hch@infradead.org>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Andi Kleen <ak@suse.de>
Message-Id: <20060707231851.3790.26405.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
References: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 08/11] Make ZONE_DMA32 optional
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make ZONE_DMA32 optional

- Add #ifdefs around ZONE_DMA32 specific code and definitions.

- Add CONFIG_ZONE_DMA32 config option and use that for x86_64
  that alone needs this zone.

- Remove the use of CONFIG_DMA_IS_DMA32 and CONFIG_DMA_IS_NORMAL
  for ia64 and fix up the way per node ZVCs are calculated.

- Fall back to prior GFP_ZONEMASK of 0x03 if there is no
  DMA32 zone.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/mm/page_alloc.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/page_alloc.c	2006-07-07 15:07:44.654814230 -0700
+++ linux-2.6.17-mm6/mm/page_alloc.c	2006-07-07 15:07:48.160457319 -0700
@@ -70,7 +70,9 @@ static void __free_pages_ok(struct page 
  */
 int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = {
 	 256,
+#ifdef CONFIG_ZONE_DMA32
 	 256,
+#endif
 	 32
 };
 
@@ -85,7 +87,9 @@ EXPORT_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = {
 	 "DMA",
+#ifdef CONFIG_ZONE_DMA32
 	 "DMA32",
+#endif
 	 "Normal",
 	 "HighMem"
 };
@@ -1471,8 +1475,10 @@ static inline int highest_zone(int zone_
 	int res = ZONE_NORMAL;
 	if (zone_bits & (__force int)__GFP_HIGHMEM)
 		res = ZONE_HIGHMEM;
+#ifdef CONFIG_ZONE_DMA32
 	if (zone_bits & (__force int)__GFP_DMA32)
 		res = ZONE_DMA32;
+#endif
 	if (zone_bits & (__force int)__GFP_DMA)
 		res = ZONE_DMA;
 	return res;
Index: linux-2.6.17-mm6/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/mmzone.h	2006-07-07 15:07:44.652861225 -0700
+++ linux-2.6.17-mm6/include/linux/mmzone.h	2006-07-07 15:07:48.161433821 -0700
@@ -108,12 +108,14 @@ typedef enum {
 	 * 			<16M.
 	 */
 	ZONE_DMA,
+#ifdef CONFIG_ZONE_DMA32
 	/*
 	 * x86_64 needs two ZONE_DMAs because it supports devices that are
 	 * only able to do DMA to the lower 16M but also 32 bit devices that
 	 * can only do DMA areas below 4G.
 	 */
 	ZONE_DMA32,
+#endif
 	/*
 	 * Normal addressable memory is in ZONE_NORMAL. DMA operations can be
 	 * performed on pages in ZONE_NORMAL if the DMA devices support
@@ -160,9 +162,13 @@ typedef enum {
  *
  * NOTE! Make sure this matches the zones in <linux/gfp.h>
  */
-#define GFP_ZONEMASK	0x07
-/* #define GFP_ZONETYPES       (GFP_ZONEMASK + 1) */           /* Non-loner */
-#define GFP_ZONETYPES  ((GFP_ZONEMASK + 1) / 2 + 1)            /* Loner */
+#define GFP_ZONETYPES		((GFP_ZONEMASK + 1) / 2 + 1)    /* Loner */
+
+#ifdef CONFIG_ZONE_DMA32
+#define GFP_ZONEMASK		0x07
+#else
+#define GFP_ZONEMASK		0x03
+#endif
 
 struct zone {
 	/* Fields commonly accessed by the page allocator */
@@ -434,7 +440,11 @@ static inline int is_normal(struct zone 
 
 static inline int is_dma32(struct zone *zone)
 {
+#ifdef CONFIG_ZONE_DMA32
 	return zone == zone->zone_pgdat->node_zones + ZONE_DMA32;
+#else
+	return 0;
+#endif
 }
 
 static inline int is_dma(struct zone *zone)
Index: linux-2.6.17-mm6/include/linux/gfp.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/gfp.h	2006-07-03 13:47:21.552673977 -0700
+++ linux-2.6.17-mm6/include/linux/gfp.h	2006-07-07 15:07:48.199517409 -0700
@@ -13,7 +13,7 @@ struct vm_area_struct;
 /* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low three bits) */
 #define __GFP_DMA	((__force gfp_t)0x01u)
 #define __GFP_HIGHMEM	((__force gfp_t)0x02u)
-#ifdef CONFIG_DMA_IS_DMA32
+#ifndef CONFIG_ZONE_DMA32
 #define __GFP_DMA32	((__force gfp_t)0x01)	/* ZONE_DMA is ZONE_DMA32 */
 #elif BITS_PER_LONG < 64
 #define __GFP_DMA32	((__force gfp_t)0x00)	/* ZONE_NORMAL is ZONE_DMA32 */
Index: linux-2.6.17-mm6/include/linux/vmstat.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/vmstat.h	2006-07-03 13:47:22.185447343 -0700
+++ linux-2.6.17-mm6/include/linux/vmstat.h	2006-07-07 15:07:48.210258933 -0700
@@ -124,12 +124,10 @@ static inline unsigned long node_page_st
 	struct zone *zones = NODE_DATA(node)->node_zones;
 
 	return
-#ifndef CONFIG_DMA_IS_NORMAL
-#if !defined(CONFIG_DMA_IS_DMA32) && BITS_PER_LONG >= 64
+#ifdef CONFIG_ZONE_DMA32
 		zone_page_state(&zones[ZONE_DMA32], item) +
 #endif
 		zone_page_state(&zones[ZONE_NORMAL], item) +
-#endif
 #ifdef CONFIG_HIGHMEM
 		zone_page_state(&zones[ZONE_HIGHMEM], item) +
 #endif
Index: linux-2.6.17-mm6/arch/ia64/Kconfig
===================================================================
--- linux-2.6.17-mm6.orig/arch/ia64/Kconfig	2006-07-03 13:47:12.766108010 -0700
+++ linux-2.6.17-mm6/arch/ia64/Kconfig	2006-07-07 15:07:48.218070952 -0700
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
Index: linux-2.6.17-mm6/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.17-mm6.orig/arch/x86_64/Kconfig	2006-07-03 13:47:14.227931665 -0700
+++ linux-2.6.17-mm6/arch/x86_64/Kconfig	2006-07-07 15:07:48.240530503 -0700
@@ -24,6 +24,10 @@ config X86
 	bool
 	default y
 
+config ZONE_DMA32
+	bool
+	default y
+
 config LOCKDEP_SUPPORT
 	bool
 	default y
