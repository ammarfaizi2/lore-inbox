Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268191AbUIBLXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268191AbUIBLXT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 07:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268204AbUIBLXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 07:23:19 -0400
Received: from ozlabs.org ([203.10.76.45]:39312 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268191AbUIBLXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 07:23:06 -0400
Date: Thu, 2 Sep 2004 21:19:03 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [ppc64] quieten NUMA boot messages
Message-ID: <20040902111903.GB26072@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On some machines we would print hundreds of lines of NUMA debug output.
The following patch cleans it up so we only print a summary of cpus and
memory vs nodes:

Node 0 CPUs: 0-1
Node 1 CPUs: 16-17
Node 2 CPUs: 32-33
Node 3 CPUs: 48-49
Node 0 Memory: 0x0-0x400000000
Node 1 Memory: 0x400000000-0x800000000

I lifted the code to do this out of xmon.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/mm/numa.c~quieten_numa arch/ppc64/mm/numa.c
--- foobar2/arch/ppc64/mm/numa.c~quieten_numa	2004-09-02 13:22:05.846031348 +1000
+++ foobar2-anton/arch/ppc64/mm/numa.c	2004-09-02 13:36:28.543366885 +1000
@@ -18,11 +18,8 @@
 #include <asm/machdep.h>
 #include <asm/abs_addr.h>
 
-#if 1
-#define dbg(args...) printk(KERN_INFO args)
-#else
-#define dbg(args...)
-#endif
+static int numa_debug;
+#define dbg(args...) if (numa_debug) { printk(KERN_INFO args); }
 
 #ifdef DEBUG_NUMA
 #define ARRAY_INITIALISER -1
@@ -48,7 +45,6 @@ EXPORT_SYMBOL(nr_cpus_in_node);
 
 static inline void map_cpu_to_node(int cpu, int node)
 {
-	dbg("cpu %d maps to domain %d\n", cpu, node);
 	numa_cpu_lookup_table[cpu] = node;
 	if (!(cpu_isset(cpu, numa_cpumask_lookup_table[node]))) {
 		cpu_set(cpu, numa_cpumask_lookup_table[node]);
@@ -107,8 +103,8 @@ static int of_node_numa_domain(struct de
 	if (tmp && (tmp[0] >= depth)) {
 		numa_domain = tmp[depth];
 	} else {
-		printk(KERN_ERR "WARNING: no NUMA information for "
-		       "%s\n", device->full_name);
+		dbg("WARNING: no NUMA information for %s\n",
+		    device->full_name);
 		numa_domain = 0;
 	}
 	return numa_domain;
@@ -137,11 +133,8 @@ static int find_min_common_depth(void)
 
 	rtas_root = of_find_node_by_path("/rtas");
 
-	if (!rtas_root) {
-		printk(KERN_ERR "WARNING: %s() could not find rtas root\n",
-				__FUNCTION__);
+	if (!rtas_root)
 		return -1;
-	}
 
 	/*
 	 * this property is 2 32-bit integers, each representing a level of
@@ -155,8 +148,8 @@ static int find_min_common_depth(void)
 	if ((len >= 1) && ref_points) {
 		depth = ref_points[1];
 	} else {
-		printk(KERN_ERR "WARNING: could not find NUMA "
-				"associativity reference point\n");
+		dbg("WARNING: could not find NUMA "
+		    "associativity reference point\n");
 		depth = -1;
 	}
 	of_node_put(rtas_root);
@@ -187,6 +180,9 @@ static int __init parse_numa_properties(
 	long entries = lmb_end_of_DRAM() >> MEMORY_INCREMENT_SHIFT;
 	unsigned long i;
 
+	if (strstr(saved_command_line, "numa=debug"))
+		numa_debug = 1;
+
 	if (strstr(saved_command_line, "numa=off")) {
 		printk(KERN_WARNING "NUMA disabled by user\n");
 		return -1;
@@ -200,7 +196,7 @@ static int __init parse_numa_properties(
 
 	depth = find_min_common_depth();
 
-	printk(KERN_INFO "NUMA associativity depth for CPU/Memory: %d\n", depth);
+	dbg("NUMA associativity depth for CPU/Memory: %d\n", depth);
 	if (depth < 0)
 		return depth;
 
@@ -225,8 +221,7 @@ static int __init parse_numa_properties(
 				numa_domain = 0;
 			}
 		} else {
-			printk(KERN_ERR "WARNING: no NUMA information for "
-			       "cpu %ld\n", i);
+			dbg("WARNING: no NUMA information for cpu %ld\n", i);
 			numa_domain = 0;
 		}
 
@@ -286,9 +281,9 @@ new_range:
 				node_data[numa_domain].node_start_pfn + 
 				node_data[numa_domain].node_spanned_pages;
 			if (shouldstart != (start / PAGE_SIZE)) {
-				printk(KERN_ERR "Hole in node, disabling "
-						"region start %lx length %lx\n",
-						start, size);
+				printk(KERN_ERR "WARNING: Hole in node, "
+						"disabling region start %lx "
+						"length %lx\n", start, size);
 				continue;
 			}
 			node_data[numa_domain].node_spanned_pages +=
@@ -304,9 +299,6 @@ new_range:
 			numa_memory_lookup_table[i >> MEMORY_INCREMENT_SHIFT] =
 				numa_domain;
 
-		dbg("memory region %lx to %lx maps to domain %d\n",
-		    start, start+size, numa_domain);
-
 		ranges--;
 		if (ranges)
 			goto new_range;
@@ -350,6 +342,67 @@ static void __init setup_nonnuma(void)
 	node0_io_hole_size = top_of_ram - total_ram;
 }
 
+static void __init dump_numa_topology(void)
+{
+	unsigned int node;
+	unsigned int cpu, count;
+
+	for (node = 0; node < MAX_NUMNODES; node++) {
+		if (!node_online(node))
+			continue;
+
+		printk(KERN_INFO "Node %d CPUs:", node);
+
+		count = 0;
+		/*
+		 * If we used a CPU iterator here we would miss printing
+		 * the holes in the cpumap.
+		 */
+		for (cpu = 0; cpu < NR_CPUS; cpu++) {
+			if (cpu_isset(cpu, numa_cpumask_lookup_table[node])) {
+				if (count == 0)
+					printk(" %u", cpu);
+				++count;
+			} else {
+				if (count > 1)
+					printk("-%u", cpu - 1);
+				count = 0;
+			}
+		}
+
+		if (count > 1)
+			printk("-%u", NR_CPUS - 1);
+		printk("\n");
+	}
+
+	for (node = 0; node < MAX_NUMNODES; node++) {
+		unsigned long i;
+
+		if (!node_online(node))
+			continue;
+
+		printk(KERN_INFO "Node %d Memory:", node);
+
+		count = 0;
+
+		for (i = 0; i < lmb_end_of_DRAM(); i += MEMORY_INCREMENT) {
+			if (numa_memory_lookup_table[i >> MEMORY_INCREMENT_SHIFT] == node) {
+				if (count == 0)
+					printk(" 0x%lx", i);
+				++count;
+			} else {
+				if (count > 0)
+					printk("-0x%lx", i);
+				count = 0;
+			}
+		}
+
+		if (count > 0)
+			printk("-0x%lx", i);
+		printk("\n");
+	}
+}
+
 void __init do_init_bootmem(void)
 {
 	int nid;
@@ -360,6 +413,8 @@ void __init do_init_bootmem(void)
 
 	if (parse_numa_properties())
 		setup_nonnuma();
+	else
+		dump_numa_topology();
 
 	for (nid = 0; nid < numnodes; nid++) {
 		unsigned long start_paddr, end_paddr;
_
