Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263984AbUEXFkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbUEXFkv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 01:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUEXFku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 01:40:50 -0400
Received: from ozlabs.org ([203.10.76.45]:30364 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263984AbUEXFjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 01:39:51 -0400
Date: Mon, 24 May 2004 15:35:25 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, haveblue@us.ibm.com,
       olof@austin.ibm.com
Subject: [PATCH] [ppc64] NUMA fixes
Message-ID: <20040524053524.GA27254@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From Anton Blanchard, Dave Hansen and Olof Johansson:

Fix multiple bugs in the ppc64 NUMA topology probe code.

- We were using HW cpu numbers instead of logical ones. 615, 630, 650,
  some 670 and some 690 SMP will all fail to boot without this patch.
- The old code would BUG() when it got confused (more NUMA zones than
  the kernel is configured for etc).
- The common depth calculation was incorrect. Dave found an OF property
  that gives us exactly what we want.
- Things were broken on SMT machines.

The new code should work on those broken systems and should no longer
BUG() but fall back to a flat topology when it gets confused.

---

 forakpm-anton/arch/ppc64/mm/numa.c       |  260 ++++++++++++++++++++-----------
 forakpm-anton/include/asm-ppc64/mmzone.h |    1 
 2 files changed, 172 insertions(+), 89 deletions(-)

diff -puN arch/ppc64/mm/numa.c~ppc64-numafixes arch/ppc64/mm/numa.c
--- forakpm/arch/ppc64/mm/numa.c~ppc64-numafixes	2004-05-24 15:04:33.918731068 +1000
+++ forakpm-anton/arch/ppc64/mm/numa.c	2004-05-24 15:33:10.234294222 +1000
@@ -19,7 +19,7 @@
 #include <asm/abs_addr.h>
 
 #if 1
-#define dbg(args...) udbg_printf(args)
+#define dbg(args...) printk(KERN_INFO args)
 #else
 #define dbg(args...)
 #endif
@@ -56,16 +56,136 @@ static inline void map_cpu_to_node(int c
 	}
 }
 
+static struct device_node * __init find_cpu_node(unsigned int cpu)
+{
+	unsigned int hw_cpuid = get_hard_smp_processor_id(cpu);
+	struct device_node *cpu_node = NULL;
+	unsigned int *interrupt_server, *reg;
+	int len;
+
+	while ((cpu_node = of_find_node_by_type(cpu_node, "cpu")) != NULL) {
+		/* Try interrupt server first */
+		interrupt_server = (unsigned int *)get_property(cpu_node,
+					"ibm,ppc-interrupt-server#s", &len);
+
+		if (interrupt_server && (len > 0)) {
+			while (len--) {
+				if (interrupt_server[len-1] == hw_cpuid)
+					return cpu_node;
+			}
+		} else {
+			reg = (unsigned int *)get_property(cpu_node,
+							   "reg", &len);
+			if (reg && (len > 0) && (reg[0] == hw_cpuid))
+				return cpu_node;
+		}
+	}
+
+	return NULL;
+}
+
+/* must hold reference to node during call */
+static int *of_get_associativity(struct device_node *dev)
+ {
+	unsigned int *result;
+	int len;
+	
+	result = (unsigned int *)get_property(dev, "ibm,associativity", &len);
+
+	if (len <= 0)
+		return NULL;
+
+	return result;
+}
+
+static int of_node_numa_domain(struct device_node *device, int depth)
+{
+	int numa_domain;
+	unsigned int *tmp;
+	
+	tmp = of_get_associativity(device);
+	if (tmp && (tmp[0] >= depth)) {
+		numa_domain = tmp[depth];
+	} else {
+		printk(KERN_ERR "WARNING: no NUMA information for "
+		       "%s\n", device->full_name);
+		numa_domain = 0;
+	}
+	return numa_domain;
+}
+
+/*
+ * In theory, the "ibm,associativity" property may contain multiple 
+ * associativity lists because a resource may be multiply connected 
+ * into the machine.  This resource then has different associativity
+ * characteristics relative to its multiple connections.  We ignore
+ * this for now.  We also assume that all cpu and memory sets have
+ * their distances represented at a common level.  This won't be 
+ * true for heirarchical NUMA.
+ *
+ * In any case the ibm,associativity-reference-points should give
+ * the correct depth for a normal NUMA system.
+ *
+ * - Dave Hansen <haveblue@us.ibm.com>
+ */
+static int find_min_common_depth(void)
+{
+	int depth;
+	unsigned int *ref_points;
+	struct device_node *rtas_root;
+	unsigned int len;
+
+	rtas_root = of_find_node_by_path("/rtas");
+
+	if (!rtas_root) {
+		printk(KERN_ERR "WARNING: %s() could not find rtas root\n",
+				__FUNCTION__);
+		return -1;
+	}
+	
+	/*
+	 * this property is 2 32-bit integers, each representing a level of 
+	 * depth in the associativity nodes.  The first is for an SMP 
+	 * configuration (should be all 0's) and the second is for a normal 
+	 * NUMA configuration.
+	 */
+	ref_points = (unsigned int *)get_property(rtas_root, 
+			"ibm,associativity-reference-points", &len);
+
+	if ((len >= 1) && ref_points) {
+		depth = ref_points[1];
+	} else {
+		printk(KERN_ERR "WARNING: could not find NUMA "
+				"associativity reference point\n");
+		depth = -1;
+	}
+	of_node_put(rtas_root);
+
+	return depth;
+}
+
+static unsigned long read_cell_ul(struct device_node *device, unsigned int **buf)
+{
+	int i;
+	unsigned long result = 0;
+
+	i = prom_n_size_cells(device);
+	/* bug on i>2 ?? */
+	while (i--) {
+		result = (result << 32) | **buf;
+		(*buf)++;
+	}
+	return result;
+}
+
 static int __init parse_numa_properties(void)
 {
 	struct device_node *cpu = NULL;
 	struct device_node *memory = NULL;
-	int *cpu_associativity;
-	int *memory_associativity;
 	int depth;
 	int max_domain = 0;
 	long entries = lmb_end_of_DRAM() >> MEMORY_INCREMENT_SHIFT;
-	long i;
+	unsigned long i;
 
 	if (strstr(saved_command_line, "numa=off")) {
 		printk(KERN_WARNING "NUMA disabled by user\n");
@@ -78,112 +198,78 @@ static int __init parse_numa_properties(
 	for (i = 0; i < entries ; i++)
 		numa_memory_lookup_table[i] = ARRAY_INITIALISER;
 
-	cpu = of_find_node_by_type(NULL, "cpu");
-	if (!cpu)
-		goto err;
-
-	memory = of_find_node_by_type(NULL, "memory");
-	if (!memory)
-		goto err;
-
-	cpu_associativity = (int *)get_property(cpu, "ibm,associativity", NULL);
-	if (!cpu_associativity)
-		goto err;
-
-	memory_associativity = (int *)get_property(memory, "ibm,associativity",
-						   NULL);
-	if (!memory_associativity)
-		goto err;
-
-	/* find common depth */
-	if (cpu_associativity[0] < memory_associativity[0])
-		depth = cpu_associativity[0];
-	else
-		depth = memory_associativity[0];
-
-	for (; cpu; cpu = of_find_node_by_type(cpu, "cpu")) {
-		int *tmp;
-		int cpu_nr, numa_domain;
+	depth = find_min_common_depth();
 
-		tmp = (int *)get_property(cpu, "reg", NULL);
-		if (!tmp)
-			continue;
-		cpu_nr = *tmp;
+	printk(KERN_INFO "NUMA associativity depth for CPU/Memory: %d\n", depth);
+	if (depth < 0)
+		return depth;
+	
+	for_each_cpu(i) {
+		int numa_domain;
 
-		tmp = (int *)get_property(cpu, "ibm,associativity",
-					  NULL);
-		if (!tmp)
-			continue;
-		numa_domain = tmp[depth];
+		cpu = find_cpu_node(i);
 
-		/* FIXME */
-		if (numa_domain == 0xffff) {
-			dbg("cpu %d has no numa doman\n", cpu_nr);
+		if (cpu) {
+			numa_domain = of_node_numa_domain(cpu, depth);
+			of_node_put(cpu);
+
+			if (numa_domain >= MAX_NUMNODES) {
+				/*
+			 	 * POWER4 LPAR uses 0xffff as invalid node,
+				 * dont warn in this case.
+			 	 */
+				if (numa_domain != 0xffff)
+					printk(KERN_ERR "WARNING: cpu %ld "
+					       "maps to invalid NUMA node %d\n",
+					       i, numa_domain);
+				numa_domain = 0;
+			}
+		} else {
+			printk(KERN_ERR "WARNING: no NUMA information for "
+			       "cpu %ld\n", i);
 			numa_domain = 0;
 		}
 
-		if (numa_domain >= MAX_NUMNODES)
-			BUG();
-
 		node_set_online(numa_domain);
 
 		if (max_domain < numa_domain)
 			max_domain = numa_domain;
 
-		map_cpu_to_node(cpu_nr, numa_domain);
-		/* register the second thread on an SMT machine */
-		if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
-			map_cpu_to_node(cpu_nr ^ 0x1, numa_domain);
+		map_cpu_to_node(i, numa_domain);
 	}
 
-	for (; memory; memory = of_find_node_by_type(memory, "memory")) {
-		unsigned int *tmp1, *tmp2;
-		unsigned long i;
-		unsigned long start = 0;
-		unsigned long size = 0;
+	memory = NULL;
+	while ((memory = of_find_node_by_type(memory, "memory")) != NULL) {
+		unsigned long start;
+		unsigned long size;
 		int numa_domain;
 		int ranges;
+		unsigned int *memcell_buf;
+		unsigned int len;
 
-		tmp1 = (int *)get_property(memory, "reg", NULL);
-		if (!tmp1)
+		memcell_buf = (unsigned int *)get_property(memory, "reg", &len);
+		if (!memcell_buf || len <= 0)
 			continue;
 
 		ranges = memory->n_addrs;
 new_range:
-
-		i = prom_n_size_cells(memory);
-		while (i--) {
-			start = (start << 32) | *tmp1;
-			tmp1++;
-		}
-
-		i = prom_n_size_cells(memory);
-		while (i--) {
-			size = (size << 32) | *tmp1;
-			tmp1++;
-		}
+		/* these are order-sensitive, and modify the buffer pointer */
+		start = read_cell_ul(memory, &memcell_buf);
+		size = read_cell_ul(memory, &memcell_buf);
 
 		start = _ALIGN_DOWN(start, MEMORY_INCREMENT);
 		size = _ALIGN_UP(size, MEMORY_INCREMENT);
 
-		if ((start + size) > MAX_MEMORY)
-			BUG();
+		numa_domain = of_node_numa_domain(memory, depth);
 
-		tmp2 = (int *)get_property(memory, "ibm,associativity",
-					   NULL);
-		if (!tmp2)
-			continue;
-		numa_domain = tmp2[depth];
-
-		/* FIXME */
-		if (numa_domain == 0xffff) {
-			dbg("memory has no numa doman\n");
+		if (numa_domain >= MAX_NUMNODES) {
+			if (numa_domain != 0xffff)
+				printk(KERN_ERR "WARNING: memory at %lx maps "
+				       "to invalid NUMA node %d\n", start,
+				       numa_domain);
 			numa_domain = 0;
 		}
 
-		if (numa_domain >= MAX_NUMNODES)
-			BUG();
-
 		node_set_online(numa_domain);
 
 		if (max_domain < numa_domain)
@@ -205,11 +291,13 @@ new_range:
 						start, size);
 				continue;
 			}
-			node_data[numa_domain].node_spanned_pages += size / PAGE_SIZE;
+			node_data[numa_domain].node_spanned_pages +=
+				size / PAGE_SIZE;
 		} else {
 			node_data[numa_domain].node_start_pfn =
 				start / PAGE_SIZE;
-			node_data[numa_domain].node_spanned_pages = size / PAGE_SIZE;
+			node_data[numa_domain].node_spanned_pages =
+				size / PAGE_SIZE;
 		}
 
 		for (i = start ; i < (start+size); i += MEMORY_INCREMENT)
@@ -227,10 +315,6 @@ new_range:
 	numnodes = max_domain + 1;
 
 	return 0;
-err:
-	of_node_put(cpu);
-	of_node_put(memory);
-	return -1;
 }
 
 static void __init setup_nonnuma(void)
diff -puN include/asm-ppc64/mmzone.h~ppc64-numafixes include/asm-ppc64/mmzone.h
--- forakpm/include/asm-ppc64/mmzone.h~ppc64-numafixes	2004-05-24 15:04:33.923731005 +1000
+++ forakpm-anton/include/asm-ppc64/mmzone.h	2004-05-24 15:04:33.950730668 +1000
@@ -23,7 +23,6 @@ extern char *numa_memory_lookup_table;
 extern cpumask_t numa_cpumask_lookup_table[];
 extern int nr_cpus_in_node[];
 
-#define MAX_MEMORY (1UL << 41)
 /* 16MB regions */
 #define MEMORY_INCREMENT_SHIFT 24
 #define MEMORY_INCREMENT (1UL << MEMORY_INCREMENT_SHIFT)
diff -puN -L root/SLES9-curr/arch/ppc64/mm/numa.c /dev/null /dev/null

_
