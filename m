Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVAUFuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVAUFuQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 00:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbVAUFuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 00:50:15 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31825
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262275AbVAUFtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 00:49:17 -0500
Date: Fri, 21 Jan 2005 06:49:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <npiggin@novell.com>
Subject: OOM fixes 2/5
Message-ID: <20050121054916.GB12647@dualathlon.random>
References: <20050121054840.GA12647@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121054840.GA12647@dualathlon.random>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 38 12 CD 76 E4 82 94 AF 02 0C 0F FA E1 FF 55 9D 9B 4F A5 9B
X-Cpushare-SSL-MD5-Cert: ED A5 F2 DA 1D 32 75 60 5E 07 6C 91 BF FC B8 85
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <andrea@suse.de>
Subject: keep balance between different classzones

This is the forward port to 2.6 of the lowmem_reserved algorithm I
invented in 2.4.1*, merged in 2.4.2x already and needed to fix workloads
like google (especially without swap) on x86 with >1G of ram, but it's
needed in all sort of workloads with lots of ram on x86, it's also
needed on x86-64 for dma allocations. This brings 2.6 in sync with
latest 2.4.2x.

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- mainline-2/include/linux/mmzone.h.orig	2005-01-15 20:45:00.000000000 +0100
+++ mainline-2/include/linux/mmzone.h	2005-01-21 05:55:28.644869648 +0100
@@ -112,18 +112,14 @@ struct zone {
 	unsigned long		free_pages;
 	unsigned long		pages_min, pages_low, pages_high;
 	/*
-	 * protection[] is a pre-calculated number of extra pages that must be
-	 * available in a zone in order for __alloc_pages() to allocate memory
-	 * from the zone. i.e., for a GFP_KERNEL alloc of "order" there must
-	 * be "(1<<order) + protection[ZONE_NORMAL]" free pages in the zone
-	 * for us to choose to allocate the page from that zone.
-	 *
-	 * It uses both min_free_kbytes and sysctl_lower_zone_protection.
-	 * The protection values are recalculated if either of these values
-	 * change.  The array elements are in zonelist order:
-	 *	[0] == GFP_DMA, [1] == GFP_KERNEL, [2] == GFP_HIGHMEM.
+	 * We don't know if the memory that we're going to allocate will be freeable
+	 * or/and it will be released eventually, so to avoid totally wasting several
+	 * GB of ram we must reserve some of the lower zone memory (otherwise we risk
+	 * to run OOM on the lower zones despite there's tons of freeable ram
+	 * on the higher zones). This array is recalculated at runtime if the
+	 * sysctl_lowmem_reserve_ratio sysctl changes.
 	 */
-	unsigned long		protection[MAX_NR_ZONES];
+	unsigned long		lowmem_reserve[MAX_NR_ZONES];
 
 	struct per_cpu_pageset	pageset[NR_CPUS];
 
@@ -368,7 +364,8 @@ struct ctl_table;
 struct file;
 int min_free_kbytes_sysctl_handler(struct ctl_table *, int, struct file *, 
 					void __user *, size_t *, loff_t *);
-int lower_zone_protection_sysctl_handler(struct ctl_table *, int, struct file *,
+extern int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1];
+int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *, int, struct file *,
 					void __user *, size_t *, loff_t *);
 
 #include <linux/topology.h>
--- mainline-2/include/linux/sysctl.h.orig	2005-01-15 20:45:00.000000000 +0100
+++ mainline-2/include/linux/sysctl.h	2005-01-21 05:55:28.646869344 +0100
@@ -160,7 +160,7 @@ enum
 	VM_PAGEBUF=17,		/* struct: Control pagebuf parameters */
 	VM_HUGETLB_PAGES=18,	/* int: Number of available Huge Pages */
 	VM_SWAPPINESS=19,	/* Tendency to steal mapped memory */
-	VM_LOWER_ZONE_PROTECTION=20,/* Amount of protection of lower zones */
+	VM_LOWMEM_RESERVE_RATIO=20,/* reservation ratio for lower memory zones */
 	VM_MIN_FREE_KBYTES=21,	/* Minimum free kilobytes to maintain */
 	VM_MAX_MAP_COUNT=22,	/* int: Maximum number of mmaps/address-space */
 	VM_LAPTOP_MODE=23,	/* vm laptop mode */
--- mainline-2/kernel/sysctl.c.orig	2005-01-15 20:45:00.000000000 +0100
+++ mainline-2/kernel/sysctl.c	2005-01-21 05:55:28.648869040 +0100
@@ -61,7 +61,6 @@ extern int core_uses_pid;
 extern char core_pattern[];
 extern int cad_pid;
 extern int pid_max;
-extern int sysctl_lower_zone_protection;
 extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
@@ -745,14 +744,13 @@ static ctl_table vm_table[] = {
 	 },
 #endif
 	{
-		.ctl_name	= VM_LOWER_ZONE_PROTECTION,
-		.procname	= "lower_zone_protection",
-		.data		= &sysctl_lower_zone_protection,
-		.maxlen		= sizeof(sysctl_lower_zone_protection),
+		.ctl_name	= VM_LOWMEM_RESERVE_RATIO,
+		.procname	= "lowmem_reserve_ratio",
+		.data		= &sysctl_lowmem_reserve_ratio,
+		.maxlen		= sizeof(sysctl_lowmem_reserve_ratio),
 		.mode		= 0644,
-		.proc_handler	= &lower_zone_protection_sysctl_handler,
+		.proc_handler	= &lowmem_reserve_ratio_sysctl_handler,
 		.strategy	= &sysctl_intvec,
-		.extra1		= &zero,
 	},
 	{
 		.ctl_name	= VM_MIN_FREE_KBYTES,
--- mainline-2/mm/page_alloc.c.orig	2005-01-15 20:45:00.000000000 +0100
+++ mainline-2/mm/page_alloc.c	2005-01-21 05:58:53.338751448 +0100
@@ -44,7 +44,15 @@ struct pglist_data *pgdat_list;
 unsigned long totalram_pages;
 unsigned long totalhigh_pages;
 long nr_swap_pages;
-int sysctl_lower_zone_protection = 0;
+/*
+ * results with 256, 32 in the lowmem_reserve sysctl:
+ *	1G machine -> (16M dma, 800M-16M normal, 1G-800M high)
+ *	1G machine -> (16M dma, 784M normal, 224M high)
+ *	NORMAL allocation will leave 784M/256 of ram reserved in the ZONE_DMA
+ *	HIGHMEM allocation will leave 224M/32 of ram reserved in ZONE_NORMAL
+ *	HIGHMEM allocation will (224M+784M)/256 of ram reserved in ZONE_DMA
+ */
+int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = { 256, 32 };
 
 EXPORT_SYMBOL(totalram_pages);
 EXPORT_SYMBOL(nr_swap_pages);
@@ -654,7 +662,7 @@ buffered_rmqueue(struct zone *zone, int 
  * of the allocation.
  */
 int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
-		int alloc_type, int can_try_harder, int gfp_high)
+		      int classzone_idx, int can_try_harder, int gfp_high)
 {
 	/* free_pages my go negative - that's OK */
 	long min = mark, free_pages = z->free_pages - (1 << order) + 1;
@@ -665,7 +673,7 @@ int zone_watermark_ok(struct zone *z, in
 	if (can_try_harder)
 		min -= min / 4;
 
-	if (free_pages <= min + z->protection[alloc_type])
+	if (free_pages <= min + z->lowmem_reserve[classzone_idx])
 		return 0;
 	for (o = 0; o < order; o++) {
 		/* At the next order, this order's pages become unavailable */
@@ -682,19 +690,6 @@ int zone_watermark_ok(struct zone *z, in
 
 /*
  * This is the 'heart' of the zoned buddy allocator.
- *
- * Herein lies the mysterious "incremental min".  That's the
- *
- *	local_low = z->pages_low;
- *	min += local_low;
- *
- * thing.  The intent here is to provide additional protection to low zones for
- * allocation requests which _could_ use higher zones.  So a GFP_HIGHMEM
- * request is not allowed to dip as deeply into the normal zone as a GFP_KERNEL
- * request.  This preserves additional space in those lower zones for requests
- * which really do need memory from those zones.  It means that on a decent
- * sized machine, GFP_HIGHMEM and GFP_KERNEL requests basically leave the DMA
- * zone untouched.
  */
 struct page * fastcall
 __alloc_pages(unsigned int gfp_mask, unsigned int order,
@@ -706,7 +701,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 	struct reclaim_state reclaim_state;
 	struct task_struct *p = current;
 	int i;
-	int alloc_type;
+	int classzone_idx;
 	int do_retry;
 	int can_try_harder;
 
@@ -726,13 +721,13 @@ __alloc_pages(unsigned int gfp_mask, uns
 		return NULL;
 	}
 
-	alloc_type = zone_idx(zones[0]);
+	classzone_idx = zone_idx(zones[0]);
 
 	/* Go through the zonelist once, looking for a zone with enough free */
 	for (i = 0; (z = zones[i]) != NULL; i++) {
 
 		if (!zone_watermark_ok(z, order, z->pages_low,
-				alloc_type, 0, 0))
+				       classzone_idx, 0, 0))
 			continue;
 
 		page = buffered_rmqueue(z, order, gfp_mask);
@@ -749,8 +744,8 @@ __alloc_pages(unsigned int gfp_mask, uns
 	 */
 	for (i = 0; (z = zones[i]) != NULL; i++) {
 		if (!zone_watermark_ok(z, order, z->pages_min,
-				alloc_type, can_try_harder,
-				gfp_mask & __GFP_HIGH))
+				       classzone_idx, can_try_harder,
+				       gfp_mask & __GFP_HIGH))
 			continue;
 
 		page = buffered_rmqueue(z, order, gfp_mask);
@@ -787,8 +782,8 @@ rebalance:
 	/* go through the zonelist yet one more time */
 	for (i = 0; (z = zones[i]) != NULL; i++) {
 		if (!zone_watermark_ok(z, order, z->pages_min,
-				alloc_type, can_try_harder,
-				gfp_mask & __GFP_HIGH))
+				       classzone_idx, can_try_harder,
+				       gfp_mask & __GFP_HIGH))
 			continue;
 
 		page = buffered_rmqueue(z, order, gfp_mask);
@@ -1198,9 +1193,9 @@ void show_free_areas(void)
 			zone->pages_scanned,
 			(zone->all_unreclaimable ? "yes" : "no")
 			);
-		printk("protections[]:");
+		printk("lowmem_reserve[]:");
 		for (i = 0; i < MAX_NR_ZONES; i++)
-			printk(" %lu", zone->protection[i]);
+			printk(" %lu", zone->lowmem_reserve[i]);
 		printk("\n");
 	}
 
@@ -1872,87 +1867,29 @@ void __init page_alloc_init(void)
 	hotcpu_notifier(page_alloc_cpu_notify, 0);
 }
 
-static unsigned long higherzone_val(struct zone *z, int max_zone,
-					int alloc_type)
-{
-	int z_idx = zone_idx(z);
-	struct zone *higherzone;
-	unsigned long pages;
-
-	/* there is no higher zone to get a contribution from */
-	if (z_idx == MAX_NR_ZONES-1)
-		return 0;
-
-	higherzone = &z->zone_pgdat->node_zones[z_idx+1];
-
-	/* We always start with the higher zone's protection value */
-	pages = higherzone->protection[alloc_type];
-
-	/*
-	 * We get a lower-zone-protection contribution only if there are
-	 * pages in the higher zone and if we're not the highest zone
-	 * in the current zonelist.  e.g., never happens for GFP_DMA. Happens
-	 * only for ZONE_DMA in a GFP_KERNEL allocation and happens for ZONE_DMA
-	 * and ZONE_NORMAL for a GFP_HIGHMEM allocation.
-	 */
-	if (higherzone->present_pages && z_idx < alloc_type)
-		pages += higherzone->pages_low * sysctl_lower_zone_protection;
-
-	return pages;
-}
-
 /*
- * setup_per_zone_protection - called whenver min_free_kbytes or
- *	sysctl_lower_zone_protection changes.  Ensures that each zone
- *	has a correct pages_protected value, so an adequate number of
+ * setup_per_zone_lowmem_reserve - called whenever
+ *	sysctl_lower_zone_reserve_ratio changes.  Ensures that each zone
+ *	has a correct pages reserved value, so an adequate number of
  *	pages are left in the zone after a successful __alloc_pages().
- *
- *	This algorithm is way confusing.  I tries to keep the same behavior
- *	as we had with the incremental min iterative algorithm.
  */
-static void setup_per_zone_protection(void)
+static void setup_per_zone_lowmem_reserve(void)
 {
 	struct pglist_data *pgdat;
-	struct zone *zones, *zone;
-	int max_zone;
-	int i, j;
+	int j, idx;
 
 	for_each_pgdat(pgdat) {
-		zones = pgdat->node_zones;
+		for (j = 0; j < MAX_NR_ZONES; j++) {
+			struct zone * zone = pgdat->node_zones + j;
+			unsigned long present_pages = zone->present_pages;
 
-		for (i = 0, max_zone = 0; i < MAX_NR_ZONES; i++)
-			if (zones[i].present_pages)
-				max_zone = i;
+			zone->lowmem_reserve[j] = 0;
 
-		/*
-		 * For each of the different allocation types:
-		 * GFP_DMA -> GFP_KERNEL -> GFP_HIGHMEM
-		 */
-		for (i = 0; i < GFP_ZONETYPES; i++) {
-			/*
-			 * For each of the zones:
-			 * ZONE_HIGHMEM -> ZONE_NORMAL -> ZONE_DMA
-			 */
-			for (j = MAX_NR_ZONES-1; j >= 0; j--) {
-				zone = &zones[j];
+			for (idx = j-1; idx >= 0; idx--) {
+				struct zone * lower_zone = pgdat->node_zones + idx;
 
-				/*
-				 * We never protect zones that don't have memory
-				 * in them (j>max_zone) or zones that aren't in
-				 * the zonelists for a certain type of
-				 * allocation (j>=i).  We have to assign these
-				 * to zero because the lower zones take
-				 * contributions from the higher zones.
-				 */
-				if (j > max_zone || j >= i) {
-					zone->protection[i] = 0;
-					continue;
-				}
-				/*
-				 * The contribution of the next higher zone
-				 */
-				zone->protection[i] = higherzone_val(zone,
-								max_zone, i);
+				lower_zone->lowmem_reserve[j] = present_pages / sysctl_lowmem_reserve_ratio[idx];
+				present_pages += lower_zone->present_pages;
 			}
 		}
 	}
@@ -2047,7 +1984,7 @@ static int __init init_per_zone_pages_mi
 	if (min_free_kbytes > 65536)
 		min_free_kbytes = 65536;
 	setup_per_zone_pages_min();
-	setup_per_zone_protection();
+	setup_per_zone_lowmem_reserve();
 	return 0;
 }
 module_init(init_per_zone_pages_min)
@@ -2062,20 +1999,23 @@ int min_free_kbytes_sysctl_handler(ctl_t
 {
 	proc_dointvec(table, write, file, buffer, length, ppos);
 	setup_per_zone_pages_min();
-	setup_per_zone_protection();
 	return 0;
 }
 
 /*
- * lower_zone_protection_sysctl_handler - just a wrapper around
- *	proc_dointvec() so that we can call setup_per_zone_protection()
- *	whenever sysctl_lower_zone_protection changes.
+ * lowmem_reserve_ratio_sysctl_handler - just a wrapper around
+ *	proc_dointvec() so that we can call setup_per_zone_lowmem_reserve()
+ *	whenever sysctl_lowmem_reserve_ratio changes.
+ *
+ * The reserve ratio obviously has absolutely no relation with the
+ * pages_min watermarks. The lowmem reserve ratio can only make sense
+ * if in function of the boot time zone sizes.
  */
-int lower_zone_protection_sysctl_handler(ctl_table *table, int write,
+int lowmem_reserve_ratio_sysctl_handler(ctl_table *table, int write,
 		 struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
 {
 	proc_dointvec_minmax(table, write, file, buffer, length, ppos);
-	setup_per_zone_protection();
+	setup_per_zone_lowmem_reserve();
 	return 0;
 }
 
