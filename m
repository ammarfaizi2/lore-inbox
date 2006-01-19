Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161331AbWASTKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161331AbWASTKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161348AbWASTKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:10:10 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:48316 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1161338AbWASTKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:10:05 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Message-Id: <20060119190856.16909.64493.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20060119190846.16909.14133.sendpatchset@skynet.csn.ul.ie>
References: <20060119190846.16909.14133.sendpatchset@skynet.csn.ul.ie>
Subject: [PATCH 2/5] Create the ZONE_EASYRCLM zone
Date: Thu, 19 Jan 2006 19:08:56 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the ZONE_EASYRCLM zone and updates relevant contants and
helper functions. After this patch is applied, memory that is hot-added on
the x86 will be placed in ZONE_EASYRCLM. Memory hot-added on the ppc64 still
goes to ZONE_DMA.

The value of GFP_ZONETYPES is debatable. It should reflect all possible
combinations of the zone modifiers which implies a value of 16. However, the
existing value does not reflect the ability to use zone bits in combination.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc1-mm1-101_antifrag_flags/include/linux/mmzone.h linux-2.6.16-rc1-mm1-102_addzone/include/linux/mmzone.h
--- linux-2.6.16-rc1-mm1-101_antifrag_flags/include/linux/mmzone.h	2006-01-19 11:21:59.000000000 +0000
+++ linux-2.6.16-rc1-mm1-102_addzone/include/linux/mmzone.h	2006-01-19 11:37:52.000000000 +0000
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
@@ -93,8 +94,8 @@ struct per_cpu_pageset {
  *
  * NOTE! Make sure this matches the zones in <linux/gfp.h>
  */
-#define GFP_ZONEMASK	0x07
-#define GFP_ZONETYPES	5
+#define GFP_ZONEMASK	0x0f
+#define GFP_ZONETYPES	9
 
 /*
  * On machines where it is needed (eg PCs) we divide physical memory
@@ -397,7 +398,7 @@ static inline int populated_zone(struct 
 
 static inline int is_highmem_idx(int idx)
 {
-	return (idx == ZONE_HIGHMEM);
+	return (idx == ZONE_HIGHMEM || idx == ZONE_EASYRCLM);
 }
 
 static inline int is_normal_idx(int idx)
@@ -413,7 +414,8 @@ static inline int is_normal_idx(int idx)
  */
 static inline int is_highmem(struct zone *zone)
 {
-	return zone == zone->zone_pgdat->node_zones + ZONE_HIGHMEM;
+	return zone == zone->zone_pgdat->node_zones + ZONE_HIGHMEM ||
+		zone == zone->zone_pgdat->node_zones + ZONE_EASYRCLM;
 }
 
 static inline int is_normal(struct zone *zone)
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.16-rc1-mm1-101_antifrag_flags/mm/page_alloc.c linux-2.6.16-rc1-mm1-102_addzone/mm/page_alloc.c
--- linux-2.6.16-rc1-mm1-101_antifrag_flags/mm/page_alloc.c	2006-01-19 11:21:59.000000000 +0000
+++ linux-2.6.16-rc1-mm1-102_addzone/mm/page_alloc.c	2006-01-19 11:37:52.000000000 +0000
@@ -68,7 +68,7 @@ static void fastcall free_hot_cold_page(
  * TBD: should special case ZONE_DMA32 machines here - in those we normally
  * don't need any ZONE_NORMAL reservation
  */
-int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = { 256, 256, 32 };
+int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = { 256, 256, 32, 32 };
 
 EXPORT_SYMBOL(totalram_pages);
 
@@ -79,7 +79,8 @@ EXPORT_SYMBOL(totalram_pages);
 struct zone *zone_table[1 << ZONETABLE_SHIFT] __read_mostly;
 EXPORT_SYMBOL(zone_table);
 
-static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
+static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal",
+						"HighMem", "EasyRclm" };
 int min_free_kbytes = 1024;
 
 unsigned long __initdata nr_kernel_pages;
@@ -760,6 +761,7 @@ static inline void prep_zero_page(struct
 	int i;
 
 	BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_HIGHMEM)) == __GFP_HIGHMEM);
+	BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_EASYRCLM)) == __GFP_EASYRCLM);
 	for(i = 0; i < (1 << order); i++)
 		clear_highpage(page + i);
 }
@@ -1245,7 +1247,7 @@ unsigned int nr_free_buffer_pages(void)
  */
 unsigned int nr_free_pagecache_pages(void)
 {
-	return nr_free_zone_pages(gfp_zone(GFP_HIGHUSER));
+	return nr_free_zone_pages(gfp_zone(GFP_RCLMUSER));
 }
 
 #ifdef CONFIG_HIGHMEM
@@ -1255,7 +1257,7 @@ unsigned int nr_free_highpages (void)
 	unsigned int pages = 0;
 
 	for_each_pgdat(pgdat)
-		pages += pgdat->node_zones[ZONE_HIGHMEM].free_pages;
+		pages += pgdat->node_zones[ZONE_EASYRCLM].free_pages;
 
 	return pages;
 }
@@ -1560,7 +1562,7 @@ static int __init build_zonelists_node(p
 {
 	struct zone *zone;
 
-	BUG_ON(zone_type > ZONE_HIGHMEM);
+	BUG_ON(zone_type > ZONE_EASYRCLM);
 
 	do {
 		zone = pgdat->node_zones + zone_type;
@@ -1580,6 +1582,8 @@ static int __init build_zonelists_node(p
 static inline int highest_zone(int zone_bits)
 {
 	int res = ZONE_NORMAL;
+	if (zone_bits & (__force int)__GFP_EASYRCLM)
+		res = ZONE_EASYRCLM;
 	if (zone_bits & (__force int)__GFP_HIGHMEM)
 		res = ZONE_HIGHMEM;
 	if (zone_bits & (__force int)__GFP_DMA32)
