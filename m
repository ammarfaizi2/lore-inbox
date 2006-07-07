Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWGGXWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWGGXWo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWGGXWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:22:24 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:3536 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932388AbWGGXTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:19:07 -0400
Date: Fri, 7 Jul 2006 16:18:56 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Christoph Hellwig <hch@infradead.org>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20060707231856.3790.25756.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
References: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 09/11] Make ZONE_HIGHMEM optional
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make ZONE_HIGHMEM optional

- ifdef out code and definitions related to CONFIG_HIGHMEM

- __GFP_HIGHMEM falls back to normal allocations if there is no
  ZONE_HIGHMEM

- GFP_ZONEMASK becomes 0x01 if there is no DMA32 and no HIGHMEM
  zone.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/include/linux/gfp.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/gfp.h	2006-07-07 15:07:48.199517409 -0700
+++ linux-2.6.17-mm6/include/linux/gfp.h	2006-07-07 15:07:51.984440142 -0700
@@ -12,7 +12,13 @@ struct vm_area_struct;
  */
 /* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low three bits) */
 #define __GFP_DMA	((__force gfp_t)0x01u)
+
+#ifdef CONFIG_HIGHMEM
 #define __GFP_HIGHMEM	((__force gfp_t)0x02u)
+#else
+#define __GFP_HIGHMEM	((__force gfp_t)0x00)	/* NORMAL is HIGHMEM */
+#endif
+
 #ifndef CONFIG_ZONE_DMA32
 #define __GFP_DMA32	((__force gfp_t)0x01)	/* ZONE_DMA is ZONE_DMA32 */
 #elif BITS_PER_LONG < 64
Index: linux-2.6.17-mm6/mm/page_alloc.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/page_alloc.c	2006-07-07 15:07:48.160457319 -0700
+++ linux-2.6.17-mm6/mm/page_alloc.c	2006-07-07 15:07:51.986393146 -0700
@@ -73,7 +73,9 @@ int sysctl_lowmem_reserve_ratio[MAX_NR_Z
 #ifdef CONFIG_ZONE_DMA32
 	 256,
 #endif
+#ifdef CONFIG_HIGHMEM
 	 32
+#endif
 };
 
 EXPORT_SYMBOL(totalram_pages);
@@ -91,7 +93,9 @@ static char *zone_names[MAX_NR_ZONES] = 
 	 "DMA32",
 #endif
 	 "Normal",
+#ifdef CONFIG_HIGHMEM
 	 "HighMem"
+#endif
 };
 
 int min_free_kbytes = 1024;
@@ -1473,8 +1477,10 @@ static int __meminit build_zonelists_nod
 static inline int highest_zone(int zone_bits)
 {
 	int res = ZONE_NORMAL;
+#ifdef CONFIG_HIGHMEM
 	if (zone_bits & (__force int)__GFP_HIGHMEM)
 		res = ZONE_HIGHMEM;
+#endif
 #ifdef CONFIG_ZONE_DMA32
 	if (zone_bits & (__force int)__GFP_DMA32)
 		res = ZONE_DMA32;
Index: linux-2.6.17-mm6/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/mmzone.h	2006-07-07 15:07:48.161433821 -0700
+++ linux-2.6.17-mm6/include/linux/mmzone.h	2006-07-07 15:07:51.987369648 -0700
@@ -122,6 +122,7 @@ typedef enum {
 	 * transfers to all addressable memory.
 	 */
 	ZONE_NORMAL,
+#ifdef CONFIG_HIGHMEM
 	/*
 	 * A memory area that is only addressable by the kernel through
 	 * mapping portions into its own address space. This is for example
@@ -131,11 +132,10 @@ typedef enum {
 	 * access.
 	 */
 	ZONE_HIGHMEM,
-
+#endif
 	MAX_NR_ZONES
 } zones_t;
 
-#define	ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
 
 /*
  * When a memory allocation must conform to specific limitations (such
@@ -166,8 +166,15 @@ typedef enum {
 
 #ifdef CONFIG_ZONE_DMA32
 #define GFP_ZONEMASK		0x07
+#define	ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
 #else
+#ifdef CONFIG_HIGHMEM
 #define GFP_ZONEMASK		0x03
+#define	ZONES_SHIFT		2
+#else
+#define GFP_ZONEMASK		0x01
+#define ZONES_SHIFT		1
+#endif
 #endif
 
 struct zone {
@@ -414,7 +421,11 @@ static inline int populated_zone(struct 
 
 static inline int is_highmem_idx(zones_t idx)
 {
+#ifdef CONFIG_HIGHMEM
 	return (idx == ZONE_HIGHMEM);
+#else
+	return 0;
+#endif
 }
 
 static inline int is_normal_idx(zones_t idx)
@@ -430,7 +441,11 @@ static inline int is_normal_idx(zones_t 
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
