Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbUJZEf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbUJZEf3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbUJZEdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 00:33:41 -0400
Received: from ozlabs.org ([203.10.76.45]:24232 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262076AbUJZE3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 00:29:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16765.53949.476160.195101@cargo.ozlabs.ibm.com>
Date: Tue, 26 Oct 2004 14:29:49 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Nathan Lynch <nathanl@austin.ibm.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: cpu hotplug notifier for numa
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Nathan Lynch <nathanl@austin.ibm.com>.

The NUMA properties of all "possible" cpus are not necessarily
available at boot time on ppc64 LPAR.  Only the properties for present
cpus are known.

This patch modifies the ppc64 numa code to map a cpu to its node right
before it is brought up -- this means that secondary cpus are now
mapped to their nodes during smp_init().  Cpus are removed from their
nodes after they have gone offline.

Also some minor cleanups:
- Stash the "minimum common depth" in a global at boot time, so we
  don't have to rediscover it every time something changes.

- Remove unnecessary variable from of_get_associativity() which is
  accessed while possibly uninitialized.

- Remove the cpu portion from dump_numa_topology() since it will show
  only the boot cpu now.  We could display this information from
  smp_cpus_done() if necessary.

Tested on a 4-way 2-node Power5 system.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -puN arch/ppc64/mm/numa.c~ppc64-numa-cpu-hotplug-notifier arch/ppc64/mm/numa.c
--- 2.6.10-rc1/arch/ppc64/mm/numa.c~ppc64-numa-cpu-hotplug-notifier	2004-10-23 15:10:39.000000000 -0500
+++ 2.6.10-rc1-nathanl/arch/ppc64/mm/numa.c	2004-10-23 16:28:58.000000000 -0500
@@ -15,6 +15,8 @@
 #include <linux/mmzone.h>
 #include <linux/module.h>
 #include <linux/nodemask.h>
+#include <linux/cpu.h>
+#include <linux/notifier.h>
 #include <asm/lmb.h>
 #include <asm/machdep.h>
 #include <asm/abs_addr.h>
@@ -39,6 +41,7 @@ int nr_cpus_in_node[MAX_NUMNODES] = { [0
 struct pglist_data *node_data[MAX_NUMNODES];
 bootmem_data_t __initdata plat_node_bdata[MAX_NUMNODES];
 static unsigned long node0_io_hole_size;
+static int min_common_depth;
 
 /*
  * We need somewhere to store start/span for each node until we have
@@ -64,7 +67,24 @@ static inline void map_cpu_to_node(int c
 	}
 }
 
-static struct device_node * __init find_cpu_node(unsigned int cpu)
+#ifdef CONFIG_HOTPLUG_CPU
+static void unmap_cpu_from_node(unsigned long cpu)
+{
+	int node = numa_cpu_lookup_table[cpu];
+
+	dbg("removing cpu %lu from node %d\n", cpu, node);
+
+	if (cpu_isset(cpu, numa_cpumask_lookup_table[node])) {
+		cpu_clear(cpu, numa_cpumask_lookup_table[node]);
+		nr_cpus_in_node[node]--;
+	} else {
+		printk(KERN_ERR "WARNING: cpu %lu not found in node %d\n",
+		       cpu, node);
+	}
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
+static struct device_node * __devinit find_cpu_node(unsigned int cpu)
 {
 	unsigned int hw_cpuid = get_hard_smp_processor_id(cpu);
 	struct device_node *cpu_node = NULL;
@@ -96,26 +116,21 @@ static struct device_node * __init find_
 
 /* must hold reference to node during call */
 static int *of_get_associativity(struct device_node *dev)
- {
-	unsigned int *result;
-	int len;
-
-	result = (unsigned int *)get_property(dev, "ibm,associativity", &len);
-
-	if (len <= 0)
-		return NULL;
-
-	return result;
+{
+	return (unsigned int *)get_property(dev, "ibm,associativity", NULL);
 }
 
-static int of_node_numa_domain(struct device_node *device, int depth)
+static int of_node_numa_domain(struct device_node *device)
 {
 	int numa_domain;
 	unsigned int *tmp;
 
+	if (min_common_depth == -1)
+		return 0;
+
 	tmp = of_get_associativity(device);
-	if (tmp && (tmp[0] >= depth)) {
-		numa_domain = tmp[depth];
+	if (tmp && (tmp[0] >= min_common_depth)) {
+		numa_domain = tmp[min_common_depth];
 	} else {
 		dbg("WARNING: no NUMA information for %s\n",
 		    device->full_name);
@@ -138,7 +153,7 @@ static int of_node_numa_domain(struct de
  *
  * - Dave Hansen <haveblue@us.ibm.com>
  */
-static int find_min_common_depth(void)
+static int __init find_min_common_depth(void)
 {
 	int depth;
 	unsigned int *ref_points;
@@ -185,11 +200,72 @@ static unsigned long read_cell_ul(struct
 	return result;
 }
 
+/*
+ * Figure out to which domain a cpu belongs and stick it there.
+ * Return the id of the domain used.
+ */
+static int numa_setup_cpu(unsigned long lcpu)
+{
+	int numa_domain = 0;
+	struct device_node *cpu = find_cpu_node(lcpu);
+
+	if (!cpu) {
+		WARN_ON(1);
+		goto out;
+	}
+
+	numa_domain = of_node_numa_domain(cpu);
+
+	if (numa_domain >= MAX_NUMNODES) {
+		/*
+		 * POWER4 LPAR uses 0xffff as invalid node,
+		 * dont warn in this case.
+		 */
+		if (numa_domain != 0xffff)
+			printk(KERN_ERR "WARNING: cpu %ld "
+			       "maps to invalid NUMA node %d\n",
+			       lcpu, numa_domain);
+		numa_domain = 0;
+	}
+out:
+	node_set_online(numa_domain);
+
+	map_cpu_to_node(lcpu, numa_domain);
+
+	of_node_put(cpu);
+
+	return numa_domain;
+}
+
+static int cpu_numa_callback(struct notifier_block *nfb,
+			     unsigned long action,
+			     void *hcpu)
+{
+	unsigned long lcpu = (unsigned long)hcpu;
+	int ret = NOTIFY_DONE;
+
+	switch (action) {
+	case CPU_UP_PREPARE:
+		if (min_common_depth == -1 || !numa_enabled)
+			map_cpu_to_node(lcpu, 0);
+		else
+			numa_setup_cpu(lcpu);
+		ret = NOTIFY_OK;
+		break;
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_DEAD:
+	case CPU_UP_CANCELED:
+		unmap_cpu_from_node(lcpu);
+		break;
+		ret = NOTIFY_OK;
+#endif
+	}
+	return ret;
+}
+
 static int __init parse_numa_properties(void)
 {
-	struct device_node *cpu = NULL;
 	struct device_node *memory = NULL;
-	int depth;
 	int max_domain = 0;
 	long entries = lmb_end_of_DRAM() >> MEMORY_INCREMENT_SHIFT;
 	unsigned long i;
@@ -206,44 +282,13 @@ static int __init parse_numa_properties(
 	for (i = 0; i < entries ; i++)
 		numa_memory_lookup_table[i] = ARRAY_INITIALISER;
 
-	depth = find_min_common_depth();
-
-	dbg("NUMA associativity depth for CPU/Memory: %d\n", depth);
-	if (depth < 0)
-		return depth;
-
-	for_each_cpu(i) {
-		int numa_domain;
-
-		cpu = find_cpu_node(i);
-
-		if (cpu) {
-			numa_domain = of_node_numa_domain(cpu, depth);
-			of_node_put(cpu);
-
-			if (numa_domain >= MAX_NUMNODES) {
-				/*
-			 	 * POWER4 LPAR uses 0xffff as invalid node,
-				 * dont warn in this case.
-			 	 */
-				if (numa_domain != 0xffff)
-					printk(KERN_ERR "WARNING: cpu %ld "
-					       "maps to invalid NUMA node %d\n",
-					       i, numa_domain);
-				numa_domain = 0;
-			}
-		} else {
-			dbg("WARNING: no NUMA information for cpu %ld\n", i);
-			numa_domain = 0;
-		}
-
-		node_set_online(numa_domain);
+	min_common_depth = find_min_common_depth();
 
-		if (max_domain < numa_domain)
-			max_domain = numa_domain;
+	dbg("NUMA associativity depth for CPU/Memory: %d\n", min_common_depth);
+	if (min_common_depth < 0)
+		return min_common_depth;
 
-		map_cpu_to_node(i, numa_domain);
-	}
+	max_domain = numa_setup_cpu(boot_cpuid);
 
 	memory = NULL;
 	while ((memory = of_find_node_by_type(memory, "memory")) != NULL) {
@@ -267,7 +312,7 @@ new_range:
 		start = _ALIGN_DOWN(start, MEMORY_INCREMENT);
 		size = _ALIGN_UP(size, MEMORY_INCREMENT);
 
-		numa_domain = of_node_numa_domain(memory, depth);
+		numa_domain = of_node_numa_domain(memory);
 
 		if (numa_domain >= MAX_NUMNODES) {
 			if (numa_domain != 0xffff)
@@ -341,8 +386,7 @@ static void __init setup_nonnuma(void)
 			numa_memory_lookup_table[i] = ARRAY_INITIALISER;
 	}
 
-	for (i = 0; i < NR_CPUS; i++)
-		map_cpu_to_node(i, 0);
+	map_cpu_to_node(boot_cpuid, 0);
 
 	node_set_online(0);
 
@@ -358,35 +402,10 @@ static void __init setup_nonnuma(void)
 static void __init dump_numa_topology(void)
 {
 	unsigned int node;
-	unsigned int cpu, count;
+	unsigned int count;
 
-	for (node = 0; node < MAX_NUMNODES; node++) {
-		if (!node_online(node))
-			continue;
-
-		printk(KERN_INFO "Node %d CPUs:", node);
-
-		count = 0;
-		/*
-		 * If we used a CPU iterator here we would miss printing
-		 * the holes in the cpumap.
-		 */
-		for (cpu = 0; cpu < NR_CPUS; cpu++) {
-			if (cpu_isset(cpu, numa_cpumask_lookup_table[node])) {
-				if (count == 0)
-					printk(" %u", cpu);
-				++count;
-			} else {
-				if (count > 1)
-					printk("-%u", cpu - 1);
-				count = 0;
-			}
-		}
-
-		if (count > 1)
-			printk("-%u", NR_CPUS - 1);
-		printk("\n");
-	}
+	if (min_common_depth == -1 || !numa_enabled)
+		return;
 
 	for (node = 0; node < MAX_NUMNODES; node++) {
 		unsigned long i;
@@ -414,6 +433,7 @@ static void __init dump_numa_topology(vo
 			printk("-0x%lx", i);
 		printk("\n");
 	}
+	return;
 }
 
 /*
@@ -460,6 +480,10 @@ static unsigned long careful_allocation(
 void __init do_init_bootmem(void)
 {
 	int nid;
+	static struct notifier_block ppc64_numa_nb = {
+		.notifier_call = cpu_numa_callback,
+		.priority = 1 /* Must run before sched domains notifier. */
+	};
 
 	min_low_pfn = 0;
 	max_low_pfn = lmb_end_of_DRAM() >> PAGE_SHIFT;
@@ -470,6 +494,8 @@ void __init do_init_bootmem(void)
 	else
 		dump_numa_topology();
 
+	register_cpu_notifier(&ppc64_numa_nb);
+
 	for (nid = 0; nid < numnodes; nid++) {
 		unsigned long start_paddr, end_paddr;
 		int i;
