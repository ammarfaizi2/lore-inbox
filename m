Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVC3FwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVC3FwG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 00:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVC3FwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 00:52:06 -0500
Received: from graphe.net ([209.204.138.32]:784 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261271AbVC3FvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 00:51:21 -0500
Date: Tue, 29 Mar 2005 21:51:08 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Manfred Spraul <manfred@colorfullife.com>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org, shai@scalex86.org
Subject: [PATCH] Pageset Localization V2
Message-ID: <Pine.LNX.4.58.0503292147200.32571@server.graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the way pagesets in struct zone are allocated. It relocates
the pagesets contained in a zone for each cpu to the node that is nearest to
the cpu instead keeping the pagesets in the (possibly remote) target zone.
This means that the operations to manage caches of pages on remote zones can
be done with information available in the local zone.

The patch depends on the API changes to the slab allocator posted before
this patch.

AIM7 benchmark on a 32 CPU SMP system:

w/o patches:
Tasks    jobs/min  jti  jobs/min/task      real       cpu
    1      484.68  100       484.6769     12.01      1.97   Fri Mar 25 11:01:42 2005
  100    27140.46   89       271.4046     21.44    148.71   Fri Mar 25 11:02:04 2005
  200    30792.02   82       153.9601     37.80    296.72   Fri Mar 25 11:02:42 2005
  300    32209.27   81       107.3642     54.21    451.34   Fri Mar 25 11:03:37 2005
  400    34962.83   78        87.4071     66.59    588.97   Fri Mar 25 11:04:44 2005
  500    31676.92   75        63.3538     91.87    742.71   Fri Mar 25 11:06:16 2005
  600    36032.69   73        60.0545     96.91    885.44   Fri Mar 25 11:07:54 2005
  700    35540.43   77        50.7720    114.63   1024.28   Fri Mar 25 11:09:49 2005
  800    33906.70   74        42.3834    137.32   1181.65   Fri Mar 25 11:12:06 2005
  900    34120.67   73        37.9119    153.51   1325.26   Fri Mar 25 11:14:41 2005
 1000    34802.37   74        34.8024    167.23   1465.26   Fri Mar 25 11:17:28 2005

with Slab API changes and pageset patch:

Tasks    jobs/min  jti  jobs/min/task      real       cpu
    1      485.00  100       485.0000     12.00      1.96   Fri Mar 25 11:46:18 2005
  100    28000.96   89       280.0096     20.79    150.45   Fri Mar 25 11:46:39 2005
  200    32285.80   79       161.4290     36.05    293.37   Fri Mar 25 11:47:16 2005
  300    40424.15   84       134.7472     43.19    438.42   Fri Mar 25 11:47:59 2005
  400    39155.01   79        97.8875     59.46    590.05   Fri Mar 25 11:48:59 2005
  500    37881.25   82        75.7625     76.82    730.19   Fri Mar 25 11:50:16 2005
  600    39083.14   78        65.1386     89.35    872.79   Fri Mar 25 11:51:46 2005
  700    38627.83   77        55.1826    105.47   1022.46   Fri Mar 25 11:53:32 2005
  800    39631.94   78        49.5399    117.48   1169.94   Fri Mar 25 11:55:30 2005
  900    36903.70   79        41.0041    141.94   1310.78   Fri Mar 25 11:57:53 2005
 1000    36201.23   77        36.2012    160.77   1458.31   Fri Mar 25 12:00:34 2005

The major improvement is in the mid range when running 100-600 tasks. For 1 task
there is barely any improvement since most data will be locally allocated. In the high
range other factors seem to become important.

Patch against 2.6.11.6-bk3

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Shobhit Dayal <shobhit@calsoftinc.com>
Signed-off-by: Shai Fultheim <Shai@Scalex86.org>

Index: linux-2.6.11/drivers/base/node.c
===================================================================
--- linux-2.6.11.orig/drivers/base/node.c	2005-03-21 13:18:06.000000000 -0800
+++ linux-2.6.11/drivers/base/node.c	2005-03-21 13:22:06.000000000 -0800
@@ -87,7 +87,7 @@ static ssize_t node_read_numastat(struct
 	for (i = 0; i < MAX_NR_ZONES; i++) {
 		struct zone *z = &pg->node_zones[i];
 		for (cpu = 0; cpu < NR_CPUS; cpu++) {
-			struct per_cpu_pageset *ps = &z->pageset[cpu];
+			struct per_cpu_pageset *ps = z->pageset[cpu];
 			numa_hit += ps->numa_hit;
 			numa_miss += ps->numa_miss;
 			numa_foreign += ps->numa_foreign;
Index: linux-2.6.11/include/linux/mm.h
===================================================================
--- linux-2.6.11.orig/include/linux/mm.h	2005-03-21 13:18:06.000000000 -0800
+++ linux-2.6.11/include/linux/mm.h	2005-03-21 13:22:06.000000000 -0800
@@ -691,6 +691,7 @@ extern void mem_init(void);
 extern void show_mem(void);
 extern void si_meminfo(struct sysinfo * val);
 extern void si_meminfo_node(struct sysinfo *val, int nid);
+extern void setup_per_cpu_pageset(void);

 /* prio_tree.c */
 void vma_prio_tree_add(struct vm_area_struct *, struct vm_area_struct *old);
Index: linux-2.6.11/include/linux/mmzone.h
===================================================================
--- linux-2.6.11.orig/include/linux/mmzone.h	2005-03-21 13:21:59.000000000 -0800
+++ linux-2.6.11/include/linux/mmzone.h	2005-03-21 13:22:06.000000000 -0800
@@ -122,7 +122,7 @@ struct zone {
 	 */
 	unsigned long		lowmem_reserve[MAX_NR_ZONES];

-	struct per_cpu_pageset	pageset[NR_CPUS];
+	struct per_cpu_pageset	*pageset[NR_CPUS];

 	/*
 	 * free areas of different sizes
Index: linux-2.6.11/init/main.c
===================================================================
--- linux-2.6.11.orig/init/main.c	2005-03-21 13:18:06.000000000 -0800
+++ linux-2.6.11/init/main.c	2005-03-21 13:22:06.000000000 -0800
@@ -490,6 +490,7 @@ asmlinkage void __init start_kernel(void
 	vfs_caches_init_early();
 	mem_init();
 	kmem_cache_init();
+	setup_per_cpu_pageset();
 	numa_policy_init();
 	if (late_time_init)
 		late_time_init();
Index: linux-2.6.11/mm/mempolicy.c
===================================================================
--- linux-2.6.11.orig/mm/mempolicy.c	2005-03-21 13:18:06.000000000 -0800
+++ linux-2.6.11/mm/mempolicy.c	2005-03-21 13:22:06.000000000 -0800
@@ -721,7 +721,7 @@ static struct page *alloc_page_interleav
 	zl = NODE_DATA(nid)->node_zonelists + (gfp & GFP_ZONEMASK);
 	page = __alloc_pages(gfp, order, zl);
 	if (page && page_zone(page) == zl->zones[0]) {
-		zl->zones[0]->pageset[get_cpu()].interleave_hit++;
+		zl->zones[0]->pageset[get_cpu()]->interleave_hit++;
 		put_cpu();
 	}
 	return page;
Index: linux-2.6.11/mm/page_alloc.c
===================================================================
--- linux-2.6.11.orig/mm/page_alloc.c	2005-03-21 13:18:06.000000000 -0800
+++ linux-2.6.11/mm/page_alloc.c	2005-03-21 13:22:06.000000000 -0800
@@ -68,6 +68,7 @@ EXPORT_SYMBOL(nr_swap_pages);
  */
 struct zone *zone_table[1 << (ZONES_SHIFT + NODES_SHIFT)];
 EXPORT_SYMBOL(zone_table);
+struct per_cpu_pageset pageset_table[MAX_NR_ZONES*MAX_NUMNODES*NR_CPUS] __initdata;

 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
 int min_free_kbytes = 1024;
@@ -518,7 +519,7 @@ static void __drain_pages(unsigned int c
 	for_each_zone(zone) {
 		struct per_cpu_pageset *pset;

-		pset = &zone->pageset[cpu];
+		pset = zone->pageset[cpu];
 		for (i = 0; i < ARRAY_SIZE(pset->pcp); i++) {
 			struct per_cpu_pages *pcp;

@@ -581,12 +582,12 @@ static void zone_statistics(struct zonel

 	local_irq_save(flags);
 	cpu = smp_processor_id();
-	p = &z->pageset[cpu];
+	p = z->pageset[cpu];
 	if (pg == orig) {
-		z->pageset[cpu].numa_hit++;
+		z->pageset[cpu]->numa_hit++;
 	} else {
 		p->numa_miss++;
-		zonelist->zones[0]->pageset[cpu].numa_foreign++;
+		zonelist->zones[0]->pageset[cpu]->numa_foreign++;
 	}
 	if (pg == NODE_DATA(numa_node_id()))
 		p->local_node++;
@@ -613,7 +614,7 @@ static void fastcall free_hot_cold_page(
 	if (PageAnon(page))
 		page->mapping = NULL;
 	free_pages_check(__FUNCTION__, page);
-	pcp = &zone->pageset[get_cpu()].pcp[cold];
+	pcp = &zone->pageset[get_cpu()]->pcp[cold];
 	local_irq_save(flags);
 	if (pcp->count >= pcp->high)
 		pcp->count -= free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
@@ -657,7 +658,7 @@ buffered_rmqueue(struct zone *zone, int
 	if (order == 0) {
 		struct per_cpu_pages *pcp;

-		pcp = &zone->pageset[get_cpu()].pcp[cold];
+		pcp = &zone->pageset[get_cpu()]->pcp[cold];
 		local_irq_save(flags);
 		if (pcp->count <= pcp->low)
 			pcp->count += rmqueue_bulk(zone, 0,
@@ -1228,7 +1229,7 @@ void show_free_areas(void)
 			if (!cpu_possible(cpu))
 				continue;

-			pageset = zone->pageset + cpu;
+			pageset = zone->pageset[cpu];

 			for (temperature = 0; temperature < 2; temperature++)
 				printk("cpu %d %s: low %d, high %d, batch %d\n",
@@ -1612,6 +1613,122 @@ void zone_init_free_lists(struct pglist_
 	memmap_init_zone((size), (nid), (zone), (start_pfn))
 #endif

+#define MAKE_LIST(list, nlist)  \
+	do {    \
+		if(list_empty(&list))      \
+			INIT_LIST_HEAD(nlist);          \
+		else {  nlist->next->prev = nlist;      \
+			nlist->prev->next = nlist;      \
+		}                                       \
+	}while(0)
+
+/*
+ * Dynamicaly allocate memory for the
+ * per cpu pageset array in struct zone.
+ */
+static inline int __devinit process_zones(int cpu)
+{
+	struct zone *zone, *dzone;
+
+	for_each_zone(zone) {
+		struct per_cpu_pageset *npageset = NULL;
+
+		npageset = kmalloc_node(sizeof(struct per_cpu_pageset),
+					 GFP_KERNEL, cpu_to_node(cpu));
+		if(!npageset) {
+			zone->pageset[cpu] = NULL;
+			goto bad;
+		}
+
+		if(zone->pageset[cpu]) {
+			memcpy(npageset, zone->pageset[cpu], sizeof(struct per_cpu_pageset));
+			MAKE_LIST(zone->pageset[cpu]->pcp[0].list, (&npageset->pcp[0].list));
+			MAKE_LIST(zone->pageset[cpu]->pcp[1].list, (&npageset->pcp[1].list));
+		}
+		else {
+			struct per_cpu_pages *pcp;
+			unsigned long batch;
+
+			batch = zone->present_pages / 1024;
+			if (batch * PAGE_SIZE > 256 * 1024)
+				batch = (256 * 1024) / PAGE_SIZE;
+			batch /= 4;             /* We effectively *= 4 below */
+			if (batch < 1)
+				batch = 1;
+
+			pcp = &npageset->pcp[0];		/* hot */
+			pcp->count = 0;
+			pcp->low = 2 * batch;
+			pcp->high = 6 * batch;
+			pcp->batch = 1 * batch;
+			INIT_LIST_HEAD(&pcp->list);
+
+			pcp = &npageset->pcp[1];		/* cold*/
+			pcp->count = 0;
+			pcp->low = 0;
+			pcp->high = 2 * batch;
+			pcp->batch = 1 * batch;
+			INIT_LIST_HEAD(&pcp->list);
+		}
+		zone->pageset[cpu] = npageset;
+	}
+
+	return 0;
+bad:
+	for_each_zone(dzone) {
+		if(dzone == zone)
+			break;
+		kfree(dzone->pageset[cpu]);
+		dzone->pageset[cpu] = NULL;
+	}
+	return -ENOBUFS;
+}
+
+static int __devinit pageset_cpuup_callback(struct notifier_block *nfb,
+		unsigned long action,
+		void *hcpu)
+{
+	int cpu = (long)hcpu;
+
+	switch(action) {
+		case CPU_UP_PREPARE:
+			if(process_zones(cpu))
+				goto bad;
+			break;
+#ifdef CONFIG_HOTPLUG_CPU
+		case CPU_DEAD:
+			{
+				struct zone *zone;
+				for_each_zone(zone) {
+					struct per_cpu_pageset *pset;
+
+					pset = zone->pageset[cpu];
+					zone->pageset[cpu] = NULL;
+
+					kfree(pset);
+				}
+			}
+			break;
+#endif
+		default:
+			break;
+	}
+	return NOTIFY_OK;
+bad:
+	return NOTIFY_BAD;
+}
+struct notifier_block pageset_notifier = { &pageset_cpuup_callback, NULL, 0 };
+
+void __init setup_per_cpu_pageset()
+{
+	/*Iintialize per_cpu_pageset for cpu 0.
+	  A cpuup callback will do this for every cpu
+	  as it comes online
+	 */
+	BUG_ON(process_zones(smp_processor_id()));
+	register_cpu_notifier(&pageset_notifier);
+}
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -1670,15 +1787,17 @@ static void __init free_area_init_core(s

 		for (cpu = 0; cpu < NR_CPUS; cpu++) {
 			struct per_cpu_pages *pcp;
+			struct per_cpu_pageset *pgset = &pageset_table[nid*MAX_NR_ZONES*NR_CPUS + (j * NR_CPUS) + cpu];

-			pcp = &zone->pageset[cpu].pcp[0];	/* hot */
+			zone->pageset[cpu] = pgset;
+			pcp = &pgset->pcp[0];			/* hot */
 			pcp->count = 0;
 			pcp->low = 2 * batch;
 			pcp->high = 6 * batch;
 			pcp->batch = 1 * batch;
 			INIT_LIST_HEAD(&pcp->list);

-			pcp = &zone->pageset[cpu].pcp[1];	/* cold */
+			pcp = &pgset->pcp[1];			/* cold */
 			pcp->count = 0;
 			pcp->low = 0;
 			pcp->high = 2 * batch;
