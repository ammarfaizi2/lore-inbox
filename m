Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWAZSox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWAZSox (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWAZSox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:44:53 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:167 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751363AbWAZSow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:44:52 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060126184345.8550.50249.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20060126184305.8550.94358.sendpatchset@skynet.csn.ul.ie>
References: <20060126184305.8550.94358.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 2/9] Create the ZONE_EASYRCLM zone
Date: Thu, 26 Jan 2006 18:43:45 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the ZONE_EASYRCLM zone and updates relevant contants and
helper functions. After this patch is applied, memory that is hot-added on
the x86 will be placed in ZONE_EASYRCLM. Memory hot-added on the ppc64 still
goes to ZONE_DMA.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.16-rc1-mm3-101_antifrag_flags/include/linux/mmzone.h linux-2.6.16-rc1-mm3-102_addzone/include/linux/mmzone.h
--- linux-2.6.16-rc1-mm3-101_antifrag_flags/include/linux/mmzone.h	2006-01-25 13:42:46.000000000 +0000
+++ linux-2.6.16-rc1-mm3-102_addzone/include/linux/mmzone.h	2006-01-26 18:09:04.000000000 +0000
@@ -73,9 +73,10 @@ struct per_cpu_pageset {
 #define ZONE_DMA32		1
 #define ZONE_NORMAL		2
 #define ZONE_HIGHMEM		3
+#define ZONE_EASYRCLM		4
 
-#define MAX_NR_ZONES		4	/* Sync this with ZONES_SHIFT */
-#define ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
+#define MAX_NR_ZONES		5	/* Sync this with ZONES_SHIFT */
+#define ZONES_SHIFT		3	/* ceil(log2(MAX_NR_ZONES)) */
 
 
 /*
@@ -103,7 +104,7 @@ struct per_cpu_pageset {
  *
  * NOTE! Make sure this matches the zones in <linux/gfp.h>
  */
-#define GFP_ZONEMASK	0x07
+#define GFP_ZONEMASK	0x0f
 /* #define GFP_ZONETYPES       (GFP_ZONEMASK + 1) */           /* Non-loner */
 #define GFP_ZONETYPES  ((GFP_ZONEMASK + 1) / 2 + 1)            /* Loner */
 
@@ -408,7 +409,7 @@ static inline int populated_zone(struct 
 
 static inline int is_highmem_idx(int idx)
 {
-	return (idx == ZONE_HIGHMEM);
+	return (idx == ZONE_HIGHMEM || idx == ZONE_EASYRCLM);
 }
 
 static inline int is_normal_idx(int idx)
@@ -424,7 +425,8 @@ static inline int is_normal_idx(int idx)
  */
 static inline int is_highmem(struct zone *zone)
 {
-	return zone == zone->zone_pgdat->node_zones + ZONE_HIGHMEM;
+	return zone == zone->zone_pgdat->node_zones + ZONE_HIGHMEM ||
+		zone == zone->zone_pgdat->node_zones + ZONE_EASYRCLM;
 }
 
 static inline int is_normal(struct zone *zone)
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.16-rc1-mm3-101_antifrag_flags/mm/page_alloc.c linux-2.6.16-rc1-mm3-102_addzone/mm/page_alloc.c
--- linux-2.6.16-rc1-mm3-101_antifrag_flags/mm/page_alloc.c	2006-01-25 13:42:46.000000000 +0000
+++ linux-2.6.16-rc1-mm3-102_addzone/mm/page_alloc.c	2006-01-26 18:09:04.000000000 +0000
@@ -66,7 +66,7 @@ int percpu_pagelist_fraction;
  * TBD: should special case ZONE_DMA32 machines here - in those we normally
  * don't need any ZONE_NORMAL reservation
  */
-int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = { 256, 256, 32 };
+int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = { 256, 256, 32, 32 };
 
 EXPORT_SYMBOL(totalram_pages);
 
@@ -77,7 +77,8 @@ EXPORT_SYMBOL(totalram_pages);
 struct zone *zone_table[1 << ZONETABLE_SHIFT] __read_mostly;
 EXPORT_SYMBOL(zone_table);
 
-static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
+static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal",
+						"HighMem", "EasyRclm" };
 int min_free_kbytes = 1024;
 
 unsigned long __initdata nr_kernel_pages;
@@ -753,6 +754,7 @@ static inline void prep_zero_page(struct
 	int i;
 
 	BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_HIGHMEM)) == __GFP_HIGHMEM);
+	BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_EASYRCLM)) == __GFP_EASYRCLM);
 	for(i = 0; i < (1 << order); i++)
 		clear_highpage(page + i);
 }
@@ -1260,7 +1262,7 @@ unsigned int nr_free_buffer_pages(void)
  */
 unsigned int nr_free_pagecache_pages(void)
 {
-	return nr_free_zone_pages(gfp_zone(GFP_HIGHUSER));
+	return nr_free_zone_pages(gfp_zone(GFP_RCLMUSER));
 }
 
 #ifdef CONFIG_HIGHMEM
@@ -1270,7 +1272,7 @@ unsigned int nr_free_highpages (void)
 	unsigned int pages = 0;
 
 	for_each_pgdat(pgdat)
-		pages += pgdat->node_zones[ZONE_HIGHMEM].free_pages;
+		pages += pgdat->node_zones[ZONE_EASYRCLM].free_pages;
 
 	return pages;
 }
@@ -1575,7 +1577,7 @@ static int __init build_zonelists_node(p
 {
 	struct zone *zone;
 
-	BUG_ON(zone_type > ZONE_HIGHMEM);
+	BUG_ON(zone_type > ZONE_EASYRCLM);
 
 	do {
 		zone = pgdat->node_zones + zone_type;
@@ -1595,6 +1597,8 @@ static int __init build_zonelists_node(p
 static inline int highest_zone(int zone_bits)
 {
 	int res = ZONE_NORMAL;
+	if (zone_bits & (__force int)__GFP_EASYRCLM)
+		res = ZONE_EASYRCLM;
 	if (zone_bits & (__force int)__GFP_HIGHMEM)
 		res = ZONE_HIGHMEM;
 	if (zone_bits & (__force int)__GFP_DMA32)
