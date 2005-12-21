Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbVLUWZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbVLUWZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbVLUWZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:25:26 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:44491 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964836AbVLUWZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:25:25 -0500
Date: Wed, 21 Dec 2005 14:24:50 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: linux-kernel@vger.kernel.org
cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC] Event counters [3/3]: Convert NUMA counters to event
 counters
In-Reply-To: <20051220235744.30925.75616.sendpatchset@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.62.0512211417580.3724@schroedinger.engr.sgi.com>
References: <20051220235733.30925.55642.sendpatchset@schroedinger.engr.sgi.com>
 <20051220235744.30925.75616.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, Christoph Lameter wrote:

> no longer be available (maybe one could improvise one with the stats of
> the processors on the node?)

Here is such an alternate patch. It creates a per cpu vmstat in 
/sys/devices/system/cpu/cpu<nr>/vmstat (omitting the zoned counters which
are per zone and therefore node specific). 
This allows one to observe VM related events occurring on a specific 
processor

It also preserves /sys/devices/system/node/node<nr>/numa_stats which will
contain the summed up event counters for all the processors on the node.

This will preserve the existing numa_miss and numa_other fields and add
lots of other information that may be useful.

There is a global numa_miss and numa_other field available in /proc/vmstat
with both these patches. The fields may be helpful to check for fast 
checks if allocation requests are properly satisfied.

Index: linux-2.6.15-rc5-mm3/include/linux/mmzone.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/include/linux/mmzone.h	2005-12-20 13:15:44.000000000 -0800
+++ linux-2.6.15-rc5-mm3/include/linux/mmzone.h	2005-12-21 13:28:13.000000000 -0800
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
+++ linux-2.6.15-rc5-mm3/include/linux/page-flags.h	2005-12-21 14:03:13.000000000 -0800
@@ -103,6 +103,9 @@ enum event_item { PGPGIN, PGPGOUT, PSWPI
 		FOR_ALL_ZONES(PGSCAN_DIRECT),
 		PGINODESTEAL, SLABS_SCANNED, KSWAPD_STEAL, KSWAPD_INODESTEAL,
 		PAGEOUTRUN, ALLOCSTALL, PGROTATED,
+#ifdef CONFIG_NUMA
+		NUMA_MISS, NUMA_OFF_NODE,
+#endif
 		NR_EVENT_ITEMS
 };
 
@@ -131,6 +134,8 @@ static inline void count_events(enum eve
 	__get_cpu_var(event_states).event[item] += delta;
 }
 
+extern char *vmstat_text[];
+
 #else
 /* Disable counters */
 #define get_cpu_events(e)	0L
Index: linux-2.6.15-rc5-mm3/mm/mempolicy.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/mm/mempolicy.c	2005-12-16 11:44:09.000000000 -0800
+++ linux-2.6.15-rc5-mm3/mm/mempolicy.c	2005-12-21 13:28:13.000000000 -0800
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
+++ linux-2.6.15-rc5-mm3/mm/page_alloc.c	2005-12-21 13:40:34.000000000 -0800
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
@@ -2625,7 +2602,7 @@ struct seq_operations zoneinfo_op = {
 	.show	= zoneinfo_show,
 };
 
-static char *vmstat_text[] = {
+char *vmstat_text[] = {
 	/* Zoned VM counters */
 	"nr_mapped",
 	"nr_pagecache",
@@ -2681,7 +2658,11 @@ static char *vmstat_text[] = {
 	"pageoutrun",
 	"allocstall",
 
-	"pgrotated"
+	"pgrotated",
+#ifdef CONFIG_NUMA
+	"numa_miss",
+	"other_node"
+#endif
 #endif
 };
 
Index: linux-2.6.15-rc5-mm3/drivers/base/node.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/drivers/base/node.c	2005-12-20 13:15:45.000000000 -0800
+++ linux-2.6.15-rc5-mm3/drivers/base/node.c	2005-12-21 14:01:38.000000000 -0800
@@ -93,41 +93,16 @@ static SYSDEV_ATTR(meminfo, S_IRUGO, nod
 
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
+	unsigned long v[NR_EVENT_ITEMS];
+	int i;
+	char *p = buf;
+
+	sum_events(v, &node_to_cpumask(dev->id));
+
+	for (i = 0; i < NR_EVENT_ITEMS; i++)
+		p += sprintf(p, "%s %ld\n", vmstat_text[NR_STAT_ITEMS + i],
+				v[i]);
+	return p - buf;
 }
 static SYSDEV_ATTR(numastat, S_IRUGO, node_read_numastat, NULL);
 
Index: linux-2.6.15-rc5-mm3/drivers/base/cpu.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/drivers/base/cpu.c	2005-12-16 11:44:06.000000000 -0800
+++ linux-2.6.15-rc5-mm3/drivers/base/cpu.c	2005-12-21 13:59:35.000000000 -0800
@@ -8,6 +8,7 @@
 #include <linux/cpu.h>
 #include <linux/topology.h>
 #include <linux/device.h>
+#include <linux/page-flags.h>
 
 #include "base.h"
 
@@ -83,6 +84,26 @@ static inline void register_cpu_control(
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+static ssize_t cpu_read_vmstat(struct sys_device * dev, char * buf)
+{
+	int i;
+	char *p = buf;
+	cpumask_t mask;
+	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
+	unsigned long v[NR_EVENT_ITEMS];
+
+	cpus_clear(mask);
+	cpu_set(cpu->sysdev.id, mask);
+	sum_events(v, &mask);
+
+	for (i = 0; i < NR_EVENT_ITEMS; i++)
+		p += sprintf(p, "%s %ld\n",
+			vmstat_text[NR_STAT_ITEMS + i], v[i]);
+	return p - buf;
+}
+static SYSDEV_ATTR(vmstat, S_IRUGO, cpu_read_vmstat, NULL);
+
+
 #ifdef CONFIG_KEXEC
 #include <linux/kexec.h>
 
@@ -138,6 +159,7 @@ int __devinit register_cpu(struct cpu *c
 	if (!error)
 		error = sysdev_create_file(&cpu->sysdev, &attr_crash_notes);
 #endif
+	sysdev_create_file(&cpu->sysdev, &attr_vmstat);
 	return error;
 }
 
