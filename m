Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbULXRhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbULXRhj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 12:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbULXRhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 12:37:17 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:18874 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261234AbULXRgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 12:36:09 -0500
Date: Fri, 24 Dec 2004 18:35:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: VM fixes [2/4]
Message-ID: <20041224173558.GC13747@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the forward port to 2.6 of the lowmem_reserved algorithm I
invented in 2.4.1*, merged in 2.4.2x already and needed to fix workloads
like google (especially without swap) on x86 with >1G of ram, but it's
needed in all sort of workloads with lots of ram on x86, it's also
needed on x86-64 for dma allocations. This brings 2.6 in sync with
latest 2.4.2x.

From: Andrea Arcangeli <andrea@suse.de>
Subject: keep balance between different classzones

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- x/include/linux/mmzone.h.orig	2004-12-04 08:56:32.000000000 +0100
+++ x/include/linux/mmzone.h	2004-12-24 17:59:13.864424040 +0100
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
 
@@ -366,7 +362,8 @@ struct ctl_table;
 struct file;
 int min_free_kbytes_sysctl_handler(struct ctl_table *, int, struct file *, 
 					void __user *, size_t *, loff_t *);
-int lower_zone_protection_sysctl_handler(struct ctl_table *, int, struct file *,
+extern int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1];
+int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *, int, struct file *,
 					void __user *, size_t *, loff_t *);
 
 #include <linux/topology.h>
--- x/include/linux/sysctl.h.orig	2004-12-04 08:56:32.000000000 +0100
+++ x/include/linux/sysctl.h	2004-12-24 17:59:13.865423888 +0100
@@ -159,7 +159,7 @@ enum
 	VM_PAGEBUF=17,		/* struct: Control pagebuf parameters */
 	VM_HUGETLB_PAGES=18,	/* int: Number of available Huge Pages */
 	VM_SWAPPINESS=19,	/* Tendency to steal mapped memory */
-	VM_LOWER_ZONE_PROTECTION=20,/* Amount of protection of lower zones */
+	VM_LOWMEM_RESERVE_RATIO=20,/* reservation ratio for lower memory zones */
 	VM_MIN_FREE_KBYTES=21,	/* Minimum free kilobytes to maintain */
 	VM_MAX_MAP_COUNT=22,	/* int: Maximum number of mmaps/address-space */
 	VM_LAPTOP_MODE=23,	/* vm laptop mode */
--- x/kernel/sysctl.c.orig	2004-12-04 08:56:33.000000000 +0100
+++ x/kernel/sysctl.c	2004-12-24 17:59:13.868423432 +0100
@@ -62,7 +62,6 @@ extern int core_uses_pid;
 extern char core_pattern[];
 extern int cad_pid;
 extern int pid_max;
-extern int sysctl_lower_zone_protection;
 extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
@@ -736,14 +735,13 @@ static ctl_table vm_table[] = {
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
--- x/mm/page_alloc.c.orig	2004-12-04 08:56:33.000000000 +0100
+++ x/mm/page_alloc.c	2004-12-24 17:59:36.182031248 +0100
@@ -42,7 +42,15 @@ unsigned long totalram_pages;
 unsigned long totalhigh_pages;
 long nr_swap_pages;
 int numnodes = 1;
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
@@ -583,19 +591,6 @@ buffered_rmqueue(struct zone *zone, int 
 
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
@@ -608,7 +603,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 	struct reclaim_state reclaim_state;
 	struct task_struct *p = current;
 	int i;
-	int alloc_type;
+	int classzone_idx;
 	int do_retry;
 	int can_try_harder;
 
@@ -628,11 +623,11 @@ __alloc_pages(unsigned int gfp_mask, uns
 		return NULL;
 	}
 
-	alloc_type = zone_idx(zones[0]);
+	classzone_idx = zone_idx(zones[0]);
 
 	/* Go through the zonelist once, looking for a zone with enough free */
 	for (i = 0; (z = zones[i]) != NULL; i++) {
-		min = z->pages_low + (1<<order) + z->protection[alloc_type];
+		min = z->pages_low + (1<<order) + z->lowmem_reserve[classzone_idx];
 
 		if (z->free_pages < min)
 			continue;
@@ -655,7 +650,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 			min /= 2;
 		if (can_try_harder)
 			min -= min / 4;
-		min += (1<<order) + z->protection[alloc_type];
+		min += (1<<order) + z->lowmem_reserve[classzone_idx];
 
 		if (z->free_pages < min)
 			continue;
@@ -698,7 +693,7 @@ rebalance:
 			min /= 2;
 		if (can_try_harder)
 			min -= min / 4;
-		min += (1<<order) + z->protection[alloc_type];
+		min += (1<<order) + z->lowmem_reserve[classzone_idx];
 
 		if (z->free_pages < min)
 			continue;
@@ -1117,9 +1112,9 @@ void show_free_areas(void)
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
 
@@ -1816,87 +1811,29 @@ void __init page_alloc_init(void)
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
@@ -1991,7 +1928,7 @@ static int __init init_per_zone_pages_mi
 	if (min_free_kbytes > 65536)
 		min_free_kbytes = 65536;
 	setup_per_zone_pages_min();
-	setup_per_zone_protection();
+	setup_per_zone_lowmem_reserve();
 	return 0;
 }
 module_init(init_per_zone_pages_min)
@@ -2006,20 +1943,23 @@ int min_free_kbytes_sysctl_handler(ctl_t
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
 
