Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263833AbUDFNpc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 09:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263822AbUDFNn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 09:43:56 -0400
Received: from ns.suse.de ([195.135.220.2]:57760 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263826AbUDFNkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 09:40:46 -0400
Date: Tue, 6 Apr 2004 15:38:12 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] NUMA API for Linux 7/ Add statistics
Message-Id: <20040406153812.38553277.ak@suse.de>
In-Reply-To: <20040406153322.5d6e986e.ak@suse.de>
References: <20040406153322.5d6e986e.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add NUMA hit/miss statistics to page allocation and display them
in sysfs.

This is not 100% required for NUMA API, but without this it is very
difficult to make sure NUMA API works properly.

The overhead is quite low because all counters are per CPU and only
happens when CONFIG_NUMA is defined.

diff -u linux-2.6.5-numa/include/linux/mmzone.h-o linux-2.6.5-numa/include/linux/mmzone.h
--- linux-2.6.5-numa/include/linux/mmzone.h-o	2004-04-06 13:12:23.000000000 +0200
+++ linux-2.6.5-numa/include/linux/mmzone.h	2004-04-06 13:36:12.000000000 +0200
@@ -52,6 +52,14 @@
 
 struct per_cpu_pageset {
 	struct per_cpu_pages pcp[2];	/* 0: hot.  1: cold */
+#ifdef CONFIG_NUMA
+	unsigned long numa_hit;		/* allocated in intended node */
+	unsigned long numa_miss;	/* allocated in non intended node */
+	unsigned long numa_foreign;	/* was intended here, hit elsewhere */
+	unsigned long interleave_hit; 	/* interleaver prefered this zone */
+	unsigned long local_node;	/* allocation from local node */
+	unsigned long other_node;	/* allocation from other node */
+#endif
 } ____cacheline_aligned_in_smp;
 
 /*
diff -u linux-2.6.5-numa/mm/page_alloc.c-o linux-2.6.5-numa/mm/page_alloc.c
--- linux-2.6.5-numa/mm/page_alloc.c-o	2004-04-06 13:12:24.000000000 +0200
+++ linux-2.6.5-numa/mm/page_alloc.c	2004-04-06 13:49:54.000000000 +0200
@@ -447,6 +447,31 @@
 }
 #endif /* CONFIG_PM */
 
+static void zone_statistics(struct zonelist *zonelist, struct zone *z) 
+{ 
+#ifdef CONFIG_NUMA
+	unsigned long flags;
+	int cpu; 
+	pg_data_t *pg = z->zone_pgdat,
+		*orig = zonelist->zones[0]->zone_pgdat;
+	struct per_cpu_pageset *p;
+	local_irq_save(flags); 
+	cpu = smp_processor_id();
+	p = &z->pageset[cpu];
+	if (pg == orig) {
+		z->pageset[cpu].numa_hit++;
+	} else { 
+		p->numa_miss++;
+		zonelist->zones[0]->pageset[cpu].numa_foreign++;
+	}
+	if (pg == NODE_DATA(numa_node_id()))
+		p->local_node++;
+	else
+		p->other_node++;	
+	local_irq_restore(flags);
+#endif
+} 
+
 /*
  * Free a 0-order page
  */
@@ -582,8 +607,10 @@
 		if (z->free_pages >= min ||
 				(!wait && z->free_pages >= z->pages_high)) {
 			page = buffered_rmqueue(z, order, cold);
-			if (page)
+			if (page) { 
+					zone_statistics(zonelist, z); 
 		       		goto got_pg;
+			}
 		}
 		min += z->pages_low * sysctl_lower_zone_protection;
 	}
@@ -607,8 +634,10 @@
 		if (z->free_pages >= min ||
 				(!wait && z->free_pages >= z->pages_high)) {
 			page = buffered_rmqueue(z, order, cold);
-			if (page)
+			if (page) {
+				zone_statistics(zonelist, z); 
 				goto got_pg;
+			}
 		}
 		min += local_min * sysctl_lower_zone_protection;
 	}
@@ -622,8 +651,10 @@
 			struct zone *z = zones[i];
 
 			page = buffered_rmqueue(z, order, cold);
-			if (page)
+			if (page) {
+				zone_statistics(zonelist, z); 
 				goto got_pg;
+			}
 		}
 		goto nopage;
 	}
@@ -650,8 +681,10 @@
 		if (z->free_pages >= min ||
 				(!wait && z->free_pages >= z->pages_high)) {
 			page = buffered_rmqueue(z, order, cold);
-			if (page)
+			if (page) {
+				zone_statistics(zonelist, z); 
 				goto got_pg;
+			}
 		}
 		min += z->pages_low * sysctl_lower_zone_protection;
 	}
diff -u linux-2.6.5-numa/drivers/base/node.c-o linux-2.6.5-numa/drivers/base/node.c
--- linux-2.6.5-numa/drivers/base/node.c-o	2004-03-17 12:17:46.000000000 +0100
+++ linux-2.6.5-numa/drivers/base/node.c	2004-04-06 13:36:12.000000000 +0200
@@ -30,13 +30,20 @@
 
 static SYSDEV_ATTR(cpumap,S_IRUGO,node_read_cpumap,NULL);
 
+/* Can be overwritten by architecture specific code. */
+int __attribute__((weak)) hugetlb_report_node_meminfo(int node, char *buf)
+{
+	return 0;
+}
+
 #define K(x) ((x) << (PAGE_SHIFT - 10))
 static ssize_t node_read_meminfo(struct sys_device * dev, char * buf)
 {
+	int n;
 	int nid = dev->id;
 	struct sysinfo i;
 	si_meminfo_node(&i, nid);
-	return sprintf(buf, "\n"
+	n = sprintf(buf, "\n"
 		       "Node %d MemTotal:     %8lu kB\n"
 		       "Node %d MemFree:      %8lu kB\n"
 		       "Node %d MemUsed:      %8lu kB\n"
@@ -51,10 +58,52 @@
 		       nid, K(i.freehigh),
 		       nid, K(i.totalram-i.totalhigh),
 		       nid, K(i.freeram-i.freehigh));
+	n += hugetlb_report_node_meminfo(nid, buf + n);
+	return n;
 }
+
 #undef K 
 static SYSDEV_ATTR(meminfo,S_IRUGO,node_read_meminfo,NULL);
 
+static ssize_t node_read_numastat(struct sys_device * dev, char * buf)
+{ 
+	unsigned long numa_hit, numa_miss, interleave_hit, numa_foreign;
+	unsigned long local_node, other_node;
+	int i, cpu;
+	pg_data_t *pg = NODE_DATA(dev->id);
+	numa_hit = 0; 
+	numa_miss = 0; 
+	interleave_hit = 0; 
+	numa_foreign = 0; 
+	local_node = 0;
+	other_node = 0;
+	for (i = 0; i < MAX_NR_ZONES; i++) { 
+		struct zone *z = &pg->node_zones[i]; 
+		for (cpu = 0; cpu < NR_CPUS; cpu++) { 
+			struct per_cpu_pageset *ps = &z->pageset[cpu]; 
+			numa_hit += ps->numa_hit; 
+			numa_miss += ps->numa_miss;
+			numa_foreign += ps->numa_foreign;
+			interleave_hit += ps->interleave_hit;
+			local_node += ps->local_node;
+			other_node += ps->other_node;
+		} 
+	} 
+	return sprintf(buf, 
+		       "numa_hit %lu\n"
+		       "numa_miss %lu\n"
+		       "numa_foreign %lu\n"
+		       "interleave_hit %lu\n"
+		       "local_node %lu\n"
+		       "other_node %lu\n", 
+		       numa_hit,
+		       numa_miss,
+		       numa_foreign,
+		       interleave_hit,
+		       local_node, 
+		       other_node); 
+} 
+static SYSDEV_ATTR(numastat,S_IRUGO,node_read_numastat,NULL);
 
 /*
  * register_node - Setup a driverfs device for a node.
@@ -74,6 +123,7 @@
 	if (!error){
 		sysdev_create_file(&node->sysdev, &attr_cpumap);
 		sysdev_create_file(&node->sysdev, &attr_meminfo);
+		sysdev_create_file(&node->sysdev, &attr_numastat); 
 	}
 	return error;
 }
