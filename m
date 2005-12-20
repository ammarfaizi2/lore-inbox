Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVLTX6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVLTX6N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 18:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVLTX5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 18:57:51 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:681 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932221AbVLTX5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 18:57:50 -0500
Date: Tue, 20 Dec 2005 15:57:44 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Christoph Lameter <clameter@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051220235744.30925.75616.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051220235733.30925.55642.sendpatchset@schroedinger.engr.sgi.com>
References: <20051220235733.30925.55642.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC] Event counters [3/3]: Convert NUMA counters to event counters
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use event counters instead of numa statistics

I am not sure if this is such a bright idea. But one could remove the
NUMA statistics and use event counters. This patch reduces the number of
numa counters to two. One for counting allocations that were not able to
follow memory policy (NUMA_MISS) and one for general off node allocations
(NUMA_OFF_NODE).

This would greatly simplify numa counters handling. node/numastat would
no longer be available (maybe one could improvise one with the stats of
the processors on the node?)

Big question: Do we really need these detailed NUMA statistics that are only
reported via numa stats and never used in the VM?

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc5-mm3/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/mmzone.h	2005-12-20 13:15:44.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/mmzone.h	2005-12-20 15:46:53.000000000 -0800
@@ -79,14 +79,6 @@ struct per_cpu_pageset {
 	s8 vm_stat_diff[NR_STAT_ITEMS];
 #endif
 
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
Index: linux-2.6.15-rc5-mm3/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/page-flags.h	2005-12-20 14:55:00.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/page-flags.h	2005-12-20 15:46:53.000000000 -0800
@@ -103,6 +103,9 @@ enum event_item { PGPGIN, PGPGOUT, PSWPI
 		FOR_ALL_ZONES(PGSCAN_DIRECT),
 		PGINODESTEAL, SLABS_SCANNED, KSWAPD_STEAL, KSWAPD_INODESTEAL,
 		PAGEOUTRUN, ALLOCSTALL, PGROTATED,
+#ifdef CONFIG_NUMA
+		NUMA_MISS, NUMA_OFF_NODE,
+#endif
 		NR_EVENT_ITEMS
 };
 
Index: linux-2.6.15-rc5-mm3/mm/mempolicy.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/mempolicy.c	2005-12-16 11:44:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/mempolicy.c	2005-12-20 15:46:53.000000000 -0800
@@ -1072,15 +1072,9 @@ static struct page *alloc_page_interleav
 					unsigned nid)
 {
 	struct zonelist *zl;
-	struct page *page;
 
 	zl = NODE_DATA(nid)->node_zonelists + gfp_zone(gfp);
-	page = __alloc_pages(gfp, order, zl);
-	if (page && page_zone(page) == zl->zones[0]) {
-		zone_pcp(zl->zones[0],get_cpu())->interleave_hit++;
-		put_cpu();
-	}
-	return page;
+	return __alloc_pages(gfp, order, zl);
 }
 
 /**
Index: linux-2.6.15-rc5-mm3/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/page_alloc.c	2005-12-20 15:46:51.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/page_alloc.c	2005-12-20 15:46:53.000000000 -0800
@@ -989,24 +989,16 @@ void mark_free_pages(struct zone *zone)
 
 #endif /* CONFIG_PM */
 
-static void zone_statistics(struct zonelist *zonelist, struct zone *z, int cpu)
+static void zone_statistics(struct zonelist *zonelist, struct zone *z, int pages)
 {
 #ifdef CONFIG_NUMA
 	pg_data_t *pg = z->zone_pgdat;
-	pg_data_t *orig = zonelist->zones[0]->zone_pgdat;
-	struct per_cpu_pageset *p;
 
-	p = zone_pcp(z, cpu);
-	if (pg == orig) {
-		p->numa_hit++;
-	} else {
-		p->numa_miss++;
-		zone_pcp(zonelist->zones[0], cpu)->numa_foreign++;
-	}
-	if (pg == NODE_DATA(numa_node_id()))
-		p->local_node++;
-	else
-		p->other_node++;
+	if (pg != zonelist->zones[0]->zone_pgdat)
+		count_events(NUMA_MISS, pages);
+
+	if (pg != NODE_DATA(numa_node_id()))
+		count_events(NUMA_OFF_NODE, pages);
 #endif
 }
 
@@ -1098,7 +1090,7 @@ again:
 	}
 
 	count_zone_events(PGALLOC, zone, 1 << order);
-	zone_statistics(zonelist, zone, cpu);
+	zone_statistics(zonelist, zone, 1 << order);
 	local_irq_restore(flags);
 	put_cpu();
 
@@ -2586,21 +2578,6 @@ static int zoneinfo_show(struct seq_file
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
@@ -2681,7 +2658,11 @@ static char *vmstat_text[] = {
 	"pageoutrun",
 	"allocstall",
 
-	"pgrotated"
+	"pgrotated",
+#ifdef CONFIG_NUMA
+	"numa_miss",
+	"off_node"
+#endif
 #endif
 };
 
Index: linux-2.6.15-rc5-mm3/drivers/base/node.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/drivers/base/node.c	2005-12-20 13:15:45.000000000 -0800
+++ linux-2.6.15-rc5-mm3/drivers/base/node.c	2005-12-20 15:46:53.000000000 -0800
@@ -91,46 +91,6 @@ static ssize_t node_read_meminfo(struct 
 #undef K
 static SYSDEV_ATTR(meminfo, S_IRUGO, node_read_meminfo, NULL);
 
-static ssize_t node_read_numastat(struct sys_device * dev, char * buf)
-{
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
-		for (cpu = 0; cpu < NR_CPUS; cpu++) {
-			struct per_cpu_pageset *ps = zone_pcp(z,cpu);
-			numa_hit += ps->numa_hit;
-			numa_miss += ps->numa_miss;
-			numa_foreign += ps->numa_foreign;
-			interleave_hit += ps->interleave_hit;
-			local_node += ps->local_node;
-			other_node += ps->other_node;
-		}
-	}
-	return sprintf(buf,
-		       "numa_hit %lu\n"
-		       "numa_miss %lu\n"
-		       "numa_foreign %lu\n"
-		       "interleave_hit %lu\n"
-		       "local_node %lu\n"
-		       "other_node %lu\n",
-		       numa_hit,
-		       numa_miss,
-		       numa_foreign,
-		       interleave_hit,
-		       local_node,
-		       other_node);
-}
-static SYSDEV_ATTR(numastat, S_IRUGO, node_read_numastat, NULL);
-
 static ssize_t node_read_distance(struct sys_device * dev, char * buf)
 {
 	int nid = dev->id;
@@ -166,7 +126,6 @@ int register_node(struct node *node, int
 	if (!error){
 		sysdev_create_file(&node->sysdev, &attr_cpumap);
 		sysdev_create_file(&node->sysdev, &attr_meminfo);
-		sysdev_create_file(&node->sysdev, &attr_numastat);
 		sysdev_create_file(&node->sysdev, &attr_distance);
 	}
 	return error;
@@ -183,7 +142,6 @@ void unregister_node(struct node *node)
 {
 	sysdev_remove_file(&node->sysdev, &attr_cpumap);
 	sysdev_remove_file(&node->sysdev, &attr_meminfo);
-	sysdev_remove_file(&node->sysdev, &attr_numastat);
 	sysdev_remove_file(&node->sysdev, &attr_distance);
 
 	sysdev_unregister(&node->sysdev);
