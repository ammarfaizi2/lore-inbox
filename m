Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWFNBNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWFNBNb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWFNBNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:13:31 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27110 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964842AbWFNBN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:13:29 -0400
Date: Tue, 13 Jun 2006 18:13:23 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
cc: ak@suse.de, pj@sgi.com, akpm@osdl.org
Subject: [RFC] Use ZVCs for numa statistics.
Message-ID: <Pine.LNX.4.64.0606131808180.1225@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The numa statistics are really event counters. But they are per
node and therefore we can use the per zone feature to easily
implement what we need.

Remove the special statistics for numa and replace them with
zoned vm counters.

This has the side effect that global sums of these events now show up
in /proc/vmstat.

I am not sure if this is a good approach. It certainly removes a
lot of code and may place the counters more securely into the
pcp cacheline but the implementation may be less efficient than the
original code (not tested yet) since the ZVC require the disabling
of interrupts. 

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-cl/mm/mempolicy.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/mempolicy.c	2006-06-12 12:42:52.033043000 -0700
+++ linux-2.6.17-rc6-cl/mm/mempolicy.c	2006-06-13 18:11:05.961979400 -0700
@@ -1204,10 +1204,8 @@ static struct page *alloc_page_interleav
 
 	zl = NODE_DATA(nid)->node_zonelists + gfp_zone(gfp);
 	page = __alloc_pages(gfp, order, zl);
-	if (page && page_zone(page) == zl->zones[0]) {
-		zone_pcp(zl->zones[0],get_cpu())->interleave_hit++;
-		put_cpu();
-	}
+	if (page && page_zone(page) == zl->zones[0])
+		inc_zone_page_state(page, NUMA_INTERLEAVE_HIT);
 	return page;
 }
 
Index: linux-2.6.17-rc6-cl/mm/vmstat.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/vmstat.c	2006-06-13 18:11:04.797989059 -0700
+++ linux-2.6.17-rc6-cl/mm/vmstat.c	2006-06-13 18:11:05.961979400 -0700
@@ -188,9 +188,8 @@ EXPORT_SYMBOL(mod_zone_page_state);
  * in between and therefore the atomicity vs. interrupt cannot be exploited
  * in a useful way here.
  */
-void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
+void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 {
-	struct zone *zone = page_zone(page);
 	s8 *p = diff_pointer(zone, item);
 
 	(*p)++;
@@ -200,6 +199,11 @@ void __inc_zone_page_state(struct page *
 		*p = 0;
 	}
 }
+
+void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
+{
+	__inc_zone_state(page_zone(page), item);
+}
 EXPORT_SYMBOL(__inc_zone_page_state);
 
 void __dec_zone_page_state(struct page *page, enum zone_stat_item item)
@@ -216,22 +220,23 @@ void __dec_zone_page_state(struct page *
 }
 EXPORT_SYMBOL(__dec_zone_page_state);
 
+void inc_zone_state(struct zone *zone, enum zone_stat_item item)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__inc_zone_state(zone, item);
+	local_irq_restore(flags);
+}
+
 void inc_zone_page_state(struct page *page, enum zone_stat_item item)
 {
 	unsigned long flags;
 	struct zone *zone;
-	s8 *p;
 
 	zone = page_zone(page);
 	local_irq_save(flags);
-	p = diff_pointer(zone, item);
-
-	(*p)++;
-
-	if (unlikely(*p > STAT_THRESHOLD)) {
-		zone_page_state_add(*p, zone, item);
-		*p = 0;
-	}
+	__inc_zone_state(zone, item);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(inc_zone_page_state);
@@ -428,6 +433,14 @@ static char *vmstat_text[] = {
 	"nr_unstable",
 	"nr_bounce",
 
+#ifdef CONFIG_NUMA
+	"numa_hit",
+	"numa_miss",
+	"numa_foreign",
+	"numa_interleave",
+	"numa_local",
+	"numa_other",
+#endif
 #ifdef CONFIG_VM_EVENT_COUNTERS
 	"pgpgin",
 	"pgpgout",
@@ -550,21 +563,6 @@ static int zoneinfo_show(struct seq_file
 					   pageset->pcp[j].high,
 					   pageset->pcp[j].batch);
 			}
-#ifdef CONFIG_NUMA
-			seq_printf(m,
-				   "\n            numa_hit:       %lu"
-				   "\n            numa_miss:      %lu"
-				   "\n            numa_foreign:   %lu"
-				   "\n            interleave_hit: %lu"
-				   "\n            local_node:     %lu"
-				   "\n            other_node:     %lu",
-				   pageset->numa_hit,
-				   pageset->numa_miss,
-				   pageset->numa_foreign,
-				   pageset->interleave_hit,
-				   pageset->local_node,
-				   pageset->other_node);
-#endif
 		}
 		seq_printf(m,
 			   "\n  all_unreclaimable: %u"
Index: linux-2.6.17-rc6-cl/mm/page_alloc.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/mm/page_alloc.c	2006-06-13 18:11:04.784318032 -0700
+++ linux-2.6.17-rc6-cl/mm/page_alloc.c	2006-06-13 18:11:05.963932404 -0700
@@ -727,21 +727,16 @@ void drain_local_pages(void)
 static void zone_statistics(struct zonelist *zonelist, struct zone *z, int cpu)
 {
 #ifdef CONFIG_NUMA
-	pg_data_t *pg = z->zone_pgdat;
-	pg_data_t *orig = zonelist->zones[0]->zone_pgdat;
-	struct per_cpu_pageset *p;
-
-	p = zone_pcp(z, cpu);
-	if (pg == orig) {
-		p->numa_hit++;
+	if (z->zone_pgdat == zonelist->zones[0]->zone_pgdat) {
+		__inc_zone_state(z, NUMA_HIT);
 	} else {
-		p->numa_miss++;
-		zone_pcp(zonelist->zones[0], cpu)->numa_foreign++;
+		__inc_zone_state(z, NUMA_MISS);
+		__inc_zone_state(zonelist->zones[0], NUMA_FOREIGN);
 	}
-	if (pg == NODE_DATA(numa_node_id()))
-		p->local_node++;
+	if (z->zone_pgdat == NODE_DATA(numa_node_id()))
+		__inc_zone_state(z, NUMA_LOCAL);
 	else
-		p->other_node++;
+		__inc_zone_state(z, NUMA_OTHER);
 #endif
 }
 
Index: linux-2.6.17-rc6-cl/include/linux/mmzone.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/mmzone.h	2006-06-13 17:56:18.000464300 -0700
+++ linux-2.6.17-rc6-cl/include/linux/mmzone.h	2006-06-13 18:11:05.964908906 -0700
@@ -57,6 +57,14 @@ enum zone_stat_item {
 	NR_WRITEBACK,
 	NR_UNSTABLE,	/* NFS unstable pages */
 	NR_BOUNCE,
+#ifdef CONFIG_NUMA
+	NUMA_HIT,
+	NUMA_MISS,
+	NUMA_FOREIGN,
+	NUMA_INTERLEAVE_HIT,
+	NUMA_LOCAL,
+	NUMA_OTHER,
+#endif
 	NR_VM_ZONE_STAT_ITEMS };
 
 struct per_cpu_pages {
@@ -71,15 +79,6 @@ struct per_cpu_pageset {
 #ifdef CONFIG_SMP
 	s8 vm_stat_diff[NR_VM_ZONE_STAT_ITEMS];
 #endif
-
-#ifdef CONFIG_NUMA
-	unsigned long numa_hit;		/* allocated in intended node */
-	unsigned long numa_miss;	/* allocated in non intended node */
-	unsigned long numa_foreign;	/* was intended here, hit elsewhere */
-	unsigned long interleave_hit; 	/* interleaver prefered this zone */
-	unsigned long local_node;	/* allocation from local node */
-	unsigned long other_node;	/* allocation from other node */
-#endif
 } ____cacheline_aligned_in_smp;
 
 #ifdef CONFIG_NUMA
Index: linux-2.6.17-rc6-cl/drivers/base/node.c
===================================================================
--- linux-2.6.17-rc6-cl.orig/drivers/base/node.c	2006-06-13 17:56:17.999487799 -0700
+++ linux-2.6.17-rc6-cl/drivers/base/node.c	2006-06-13 18:11:05.965885408 -0700
@@ -94,28 +94,6 @@ static SYSDEV_ATTR(meminfo, S_IRUGO, nod
 
 static ssize_t node_read_numastat(struct sys_device * dev, char * buf)
 {
-	unsigned long numa_hit, numa_miss, interleave_hit, numa_foreign;
-	unsigned long local_node, other_node;
-	int i, cpu;
-	pg_data_t *pg = NODE_DATA(dev->id);
-	numa_hit = 0;
-	numa_miss = 0;
-	interleave_hit = 0;
-	numa_foreign = 0;
-	local_node = 0;
-	other_node = 0;
-	for (i = 0; i < MAX_NR_ZONES; i++) {
-		struct zone *z = &pg->node_zones[i];
-		for_each_online_cpu(cpu) {
-			struct per_cpu_pageset *ps = zone_pcp(z,cpu);
-			numa_hit += ps->numa_hit;
-			numa_miss += ps->numa_miss;
-			numa_foreign += ps->numa_foreign;
-			interleave_hit += ps->interleave_hit;
-			local_node += ps->local_node;
-			other_node += ps->other_node;
-		}
-	}
 	return sprintf(buf,
 		       "numa_hit %lu\n"
 		       "numa_miss %lu\n"
@@ -123,12 +101,12 @@ static ssize_t node_read_numastat(struct
 		       "interleave_hit %lu\n"
 		       "local_node %lu\n"
 		       "other_node %lu\n",
-		       numa_hit,
-		       numa_miss,
-		       numa_foreign,
-		       interleave_hit,
-		       local_node,
-		       other_node);
+		       node_page_state(dev->id, NUMA_HIT),
+		       node_page_state(dev->id, NUMA_MISS),
+		       node_page_state(dev->id, NUMA_FOREIGN),
+		       node_page_state(dev->id, NUMA_INTERLEAVE_HIT),
+		       node_page_state(dev->id, NUMA_LOCAL),
+		       node_page_state(dev->id, NUMA_OTHER));
 }
 static SYSDEV_ATTR(numastat, S_IRUGO, node_read_numastat, NULL);
 
Index: linux-2.6.17-rc6-cl/include/linux/vmstat.h
===================================================================
--- linux-2.6.17-rc6-cl.orig/include/linux/vmstat.h	2006-06-13 18:11:04.781388526 -0700
+++ linux-2.6.17-rc6-cl/include/linux/vmstat.h	2006-06-13 18:11:08.516508537 -0700
@@ -78,6 +78,9 @@ static inline void zap_zone_vm_stats(str
 	memset(zone->vm_stat, 0, sizeof(zone->vm_stat));
 }
 
+extern void inc_zone_state(struct zone *, enum zone_stat_item);
+extern void __inc_zone_state(struct zone *, enum zone_stat_item);
+
 #ifdef CONFIG_SMP
 void refresh_cpu_vm_stats(int);
 void refresh_vm_stats(void);
