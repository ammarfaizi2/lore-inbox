Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWGHAFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWGHAFz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWGHAFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:05:54 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:1235 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751276AbWGHAFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:05:49 -0400
Date: Fri, 7 Jul 2006 17:05:37 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Martin Bligh <mbligh@google.com>, Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20060708000537.3829.77811.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
References: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 7/8] Single zone optimizations
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Single Zone Optimizations

If we only have a single zone then various macros can be optimized.

We do not need to protect higher zones etc etc.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/mm/vmstat.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/vmstat.c	2006-07-07 16:50:18.434774588 -0700
+++ linux-2.6.17-mm6/mm/vmstat.c	2006-07-07 16:51:50.428110300 -0700
@@ -496,7 +496,7 @@ static int zoneinfo_show(struct seq_file
 		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
 			seq_printf(m, "\n    %-12s %lu", vmstat_text[i],
 					zone_page_state(zone, i));
-
+#ifndef SINGLE_ZONE
 		seq_printf(m,
 			   "\n        protection: (%lu",
 			   zone->lowmem_reserve[0]);
@@ -505,6 +505,7 @@ static int zoneinfo_show(struct seq_file
 		seq_printf(m,
 			   ")"
 			   "\n  pagesets");
+#endif
 		for_each_online_cpu(i) {
 			struct per_cpu_pageset *pageset;
 			int j;
Index: linux-2.6.17-mm6/mm/page_alloc.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/page_alloc.c	2006-07-07 16:50:18.788268357 -0700
+++ linux-2.6.17-mm6/mm/page_alloc.c	2006-07-07 16:51:50.430063305 -0700
@@ -57,6 +57,7 @@ int percpu_pagelist_fraction;
 
 static void __free_pages_ok(struct page *page, unsigned int order);
 
+#ifndef SINGLE_ZONE
 /*
  * results with 256, 32 in the lowmem_reserve sysctl:
  *	1G machine -> (16M dma, 800M-16M normal, 1G-800M high)
@@ -79,6 +80,7 @@ int sysctl_lowmem_reserve_ratio[MAX_NR_Z
 	 32
 #endif
 };
+#endif
 
 EXPORT_SYMBOL(totalram_pages);
 
@@ -878,8 +880,11 @@ int zone_watermark_ok(struct zone *z, in
 		min -= min / 2;
 	if (alloc_flags & ALLOC_HARDER)
 		min -= min / 4;
-
+#ifdef SINGLE_ZONE
+	if (free_pages <= min)
+#else
 	if (free_pages <= min + z->lowmem_reserve[classzone_idx])
+#endif
 		return 0;
 	for (o = 0; o < order; o++) {
 		/* At the next order, this order's pages become unavailable */
@@ -1424,10 +1429,12 @@ void show_free_areas(void)
 			zone->pages_scanned,
 			(zone->all_unreclaimable ? "yes" : "no")
 			);
+#ifndef SINGLE_ZONE
 		printk("lowmem_reserve[]:");
 		for (i = 0; i < MAX_NR_ZONES; i++)
 			printk(" %lu", zone->lowmem_reserve[i]);
 		printk("\n");
+#endif
 	}
 
 	for_each_zone(zone) {
@@ -2243,12 +2250,13 @@ static void calculate_totalreserve_pages
 			struct zone *zone = pgdat->node_zones + i;
 			unsigned long max = 0;
 
+#ifndef SINGLE_ZONE
 			/* Find valid and maximum lowmem_reserve in the zone */
 			for (j = i; j < MAX_NR_ZONES; j++) {
 				if (zone->lowmem_reserve[j] > max)
 					max = zone->lowmem_reserve[j];
 			}
-
+#endif
 			/* we treat pages_high as reserved pages. */
 			max += zone->pages_high;
 
@@ -2268,6 +2276,7 @@ static void calculate_totalreserve_pages
  */
 static void setup_per_zone_lowmem_reserve(void)
 {
+#ifndef SINGLE_ZONE
 	struct pglist_data *pgdat;
 	int j, idx;
 
@@ -2294,6 +2303,7 @@ static void setup_per_zone_lowmem_reserv
 
 	/* update totalreserve_pages */
 	calculate_totalreserve_pages();
+#endif
 }
 
 /*
@@ -2427,6 +2437,7 @@ int sysctl_min_unmapped_ratio_sysctl_han
 }
 #endif
 
+#ifndef SINGLE_ZONE
 /*
  * lowmem_reserve_ratio_sysctl_handler - just a wrapper around
  *	proc_dointvec() so that we can call setup_per_zone_lowmem_reserve()
@@ -2443,6 +2454,7 @@ int lowmem_reserve_ratio_sysctl_handler(
 	setup_per_zone_lowmem_reserve();
 	return 0;
 }
+#endif
 
 /*
  * percpu_pagelist_fraction - changes the pcp->high for each zone on each
Index: linux-2.6.17-mm6/kernel/sysctl.c
===================================================================
--- linux-2.6.17-mm6.orig/kernel/sysctl.c	2006-07-03 13:47:22.500857523 -0700
+++ linux-2.6.17-mm6/kernel/sysctl.c	2006-07-07 16:51:50.432016309 -0700
@@ -903,6 +903,7 @@ static ctl_table vm_table[] = {
 		.proc_handler	= &proc_dointvec,
 	 },
 #endif
+#ifndef SINGLE_ZONE
 	{
 		.ctl_name	= VM_LOWMEM_RESERVE_RATIO,
 		.procname	= "lowmem_reserve_ratio",
@@ -912,6 +913,7 @@ static ctl_table vm_table[] = {
 		.proc_handler	= &lowmem_reserve_ratio_sysctl_handler,
 		.strategy	= &sysctl_intvec,
 	},
+#endif
 	{
 		.ctl_name	= VM_DROP_PAGECACHE,
 		.procname	= "drop_caches",
Index: linux-2.6.17-mm6/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/mmzone.h	2006-07-07 16:50:18.787291855 -0700
+++ linux-2.6.17-mm6/include/linux/mmzone.h	2006-07-07 16:51:50.432992811 -0700
@@ -180,6 +180,7 @@ typedef enum {
 #else
 #define GFP_ZONEMASK		0x00
 #define ZONES_SHIFT		0
+#define SINGLE_ZONE		1
 #endif
 #endif
 #endif
@@ -188,6 +189,7 @@ struct zone {
 	/* Fields commonly accessed by the page allocator */
 	unsigned long		free_pages;
 	unsigned long		pages_min, pages_low, pages_high;
+#ifndef SINGLE_ZONE
 	/*
 	 * We don't know if the memory that we're going to allocate will be freeable
 	 * or/and it will be released eventually, so to avoid totally wasting several
@@ -197,6 +199,7 @@ struct zone {
 	 * sysctl_lowmem_reserve_ratio sysctl changes.
 	 */
 	unsigned long		lowmem_reserve[MAX_NR_ZONES];
+#endif
 
 #ifdef CONFIG_NUMA
 	/*
@@ -419,7 +422,11 @@ unsigned long __init node_memmap_size_by
 /*
  * zone_idx() returns 0 for the ZONE_DMA zone, 1 for the ZONE_NORMAL zone, etc.
  */
+#ifndef SINGLE_ZONE
 #define zone_idx(zone)		((zone) - (zone)->zone_pgdat->node_zones)
+#else
+#define zone_idx(zone)		ZONE_NORMAL
+#endif
 
 static inline int populated_zone(struct zone *zone)
 {
@@ -437,7 +444,11 @@ static inline int is_highmem_idx(zones_t
 
 static inline int is_normal_idx(zones_t idx)
 {
+#ifndef SINGLE_ZONE
 	return (idx == ZONE_NORMAL);
+#else
+	return 1;
+#endif
 }
 
 /**
@@ -457,7 +468,9 @@ static inline int is_highmem(struct zone
 
 static inline int is_normal(struct zone *zone)
 {
+#ifndef SINGLE_ZONE
 	return zone == zone->zone_pgdat->node_zones + ZONE_NORMAL;
+#endif
 }
 
 static inline int is_dma32(struct zone *zone)
@@ -483,9 +496,11 @@ struct ctl_table;
 struct file;
 int min_free_kbytes_sysctl_handler(struct ctl_table *, int, struct file *, 
 					void __user *, size_t *, loff_t *);
+#ifndef SINGLE_ZONE
 extern int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1];
 int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *, int, struct file *,
 					void __user *, size_t *, loff_t *);
+#endif
 int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *, int, struct file *,
 					void __user *, size_t *, loff_t *);
 int sysctl_min_unmapped_ratio_sysctl_handler(struct ctl_table *, int,
