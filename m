Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVB1S4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVB1S4o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 13:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVB1S4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 13:56:10 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:40882 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261713AbVB1Syk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 13:54:40 -0500
Subject: [PATCH 3/5] abstract discontigmem setup
To: linux-mm@kvack.org
Cc: akpm@osdl.org, kmannth@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>, ygoto@us.fujitsu.com,
       apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 28 Feb 2005 10:54:37 -0800
Message-Id: <E1D5q2Q-0007eV-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


memory_present() is how each arch/subarch will tell sparsemem
and discontigmem where all of its memory is.  This is what
triggers sparse to go out and create its mappings for the memory,
as well as allocate the mem_map[].

By: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 sparse-dave/arch/i386/Kconfig        |   10 +++++++
 sparse-dave/arch/i386/kernel/numaq.c |    6 +++-
 sparse-dave/arch/i386/kernel/srat.c  |    9 +++++-
 sparse-dave/arch/i386/mm/discontig.c |   49 ++++++++++++++++++++++-------------
 sparse-dave/arch/ppc64/mm/numa.c     |   19 ++++++++++---
 sparse-dave/include/linux/mmzone.h   |   11 +++++++
 6 files changed, 79 insertions(+), 25 deletions(-)

diff -puN arch/i386/kernel/numaq.c~A3.1-abstract-discontig arch/i386/kernel/numaq.c
--- sparse/arch/i386/kernel/numaq.c~A3.1-abstract-discontig	2005-02-24 08:56:39.000000000 -0800
+++ sparse-dave/arch/i386/kernel/numaq.c	2005-02-24 08:56:39.000000000 -0800
@@ -32,7 +32,7 @@
 #include <asm/numaq.h>
 
 /* These are needed before the pgdat's are created */
-extern long node_start_pfn[], node_end_pfn[];
+extern long node_start_pfn[], node_end_pfn[], node_remap_size[];
 
 #define	MB_TO_PAGES(addr) ((addr) << (20 - PAGE_SHIFT))
 
@@ -59,6 +59,10 @@ static void __init smp_dump_qct(void)
 				eq->hi_shrd_mem_start - eq->priv_mem_size);
 			node_end_pfn[node] = MB_TO_PAGES(
 				eq->hi_shrd_mem_start + eq->hi_shrd_mem_size);
+
+			memory_present(node,
+				node_start_pfn[node], node_end_pfn[node]);
+			node_remap_size[node] = node_memmap_size_bytes(node);
 		}
 	}
 }
diff -puN arch/i386/kernel/srat.c~A3.1-abstract-discontig arch/i386/kernel/srat.c
--- sparse/arch/i386/kernel/srat.c~A3.1-abstract-discontig	2005-02-24 08:56:39.000000000 -0800
+++ sparse-dave/arch/i386/kernel/srat.c	2005-02-24 08:56:39.000000000 -0800
@@ -58,7 +58,7 @@ static int num_memory_chunks;		/* total 
 static int zholes_size_init;
 static unsigned long zholes_size[MAX_NUMNODES * MAX_NR_ZONES];
 
-extern unsigned long node_start_pfn[], node_end_pfn[];
+extern unsigned long node_start_pfn[], node_end_pfn[], node_remap_size[];
 
 extern void * boot_ioremap(unsigned long, unsigned long);
 
@@ -286,6 +286,13 @@ static int __init acpi20_parse_srat(stru
 			}
 		}
 	}
+	for_each_online_node(nid) {
+		unsigned long start = node_start_pfn[nid];
+		unsigned long end = node_end_pfn[nid];
+
+		memory_present(nid, start, end);
+		node_remap_size[nid] = node_memmap_size_bytes(nid, start, end);
+	}
 	return 1;
 out_fail:
 	return 0;
diff -puN arch/i386/mm/discontig.c~A3.1-abstract-discontig arch/i386/mm/discontig.c
--- sparse/arch/i386/mm/discontig.c~A3.1-abstract-discontig	2005-02-24 08:56:39.000000000 -0800
+++ sparse-dave/arch/i386/mm/discontig.c	2005-02-24 08:56:39.000000000 -0800
@@ -60,6 +60,32 @@ bootmem_data_t node0_bdata;
  */
 s8 physnode_map[MAX_ELEMENTS] = { [0 ... (MAX_ELEMENTS - 1)] = -1};
 
+void memory_present(int nid, unsigned long start, unsigned long end)
+{
+	unsigned long pfn;
+
+	printk(KERN_INFO "Node: %d, start_pfn: %ld, end_pfn: %ld\n",
+			nid, start, end);
+	printk(KERN_DEBUG "  Setting physnode_map array to node %d for pfns:\n", nid);
+	printk(KERN_DEBUG "  ");
+	for (pfn = start; pfn < end; pfn += PAGES_PER_ELEMENT) {
+		physnode_map[pfn / PAGES_PER_ELEMENT] = nid;
+		printk(KERN_DEBUG "%ld ", pfn);
+	}
+	printk(KERN_DEBUG "\n");
+}
+
+unsigned long node_memmap_size_bytes(int nid, unsigned long start_pfn,
+					      unsigned long end_pfn)
+{
+	unsigned long nr_pages = end_pfn - start_pfn;
+
+	if (!nr_pages)
+		return 0;
+
+	return (nr_pages + 1) * sizeof(struct page);
+}
+
 unsigned long node_start_pfn[MAX_NUMNODES];
 unsigned long node_end_pfn[MAX_NUMNODES];
 
@@ -162,9 +188,9 @@ static unsigned long calculate_numa_rema
 	for_each_online_node(nid) {
 		if (nid == 0)
 			continue;
-		/* calculate the size of the mem_map needed in bytes */
-		size = (node_end_pfn[nid] - node_start_pfn[nid] + 1) 
-			* sizeof(struct page) + sizeof(pg_data_t);
+		/* ensure the remap includes space for the pgdat. */
+		size = node_remap_size[nid] + sizeof(pg_data_t);
+
 		/* convert size to large (pmd size) pages, rounding up */
 		size = (size + LARGE_PAGE_BYTES - 1) / LARGE_PAGE_BYTES;
 		/* now the roundup is correct, convert to PAGE_SIZE pages */
@@ -189,7 +215,7 @@ unsigned long __init setup_memory(void)
 {
 	int nid;
 	unsigned long system_start_pfn, system_max_low_pfn;
-	unsigned long reserve_pages, pfn;
+	unsigned long reserve_pages;
 
 	/*
 	 * When mapping a NUMA machine we allocate the node_mem_map arrays
@@ -198,22 +224,9 @@ unsigned long __init setup_memory(void)
 	 * this space and use it to adjust the boundry between ZONE_NORMAL
 	 * and ZONE_HIGHMEM.
 	 */
+	find_max_pfn();
 	get_memcfg_numa();
 
-	/* Fill in the physnode_map */
-	for_each_online_node(nid) {
-		printk("Node: %d, start_pfn: %ld, end_pfn: %ld\n",
-				nid, node_start_pfn[nid], node_end_pfn[nid]);
-		printk("  Setting physnode_map array to node %d for pfns:\n  ",
-				nid);
-		for (pfn = node_start_pfn[nid]; pfn < node_end_pfn[nid];
-	       				pfn += PAGES_PER_ELEMENT) {
-			physnode_map[pfn / PAGES_PER_ELEMENT] = nid;
-			printk("%ld ", pfn);
-		}
-		printk("\n");
-	}
-
 	reserve_pages = calculate_numa_remap_pages();
 
 	/* partially used pages are not usable - thus round upwards */
diff -puN arch/ppc64/mm/numa.c~A3.1-abstract-discontig arch/ppc64/mm/numa.c
--- sparse/arch/ppc64/mm/numa.c~A3.1-abstract-discontig	2005-02-24 08:56:39.000000000 -0800
+++ sparse-dave/arch/ppc64/mm/numa.c	2005-02-24 08:56:39.000000000 -0800
@@ -58,6 +58,17 @@ EXPORT_SYMBOL(numa_memory_lookup_table);
 EXPORT_SYMBOL(numa_cpumask_lookup_table);
 EXPORT_SYMBOL(nr_cpus_in_node);
 
+void memory_present(int nid, unsigned long start_pfn,
+			     unsigned long end_pfn)
+{
+	unsigned long i;
+	unsigned long start_addr = start << PAGE_SHIFT;
+	unsigned long end_addr = end << PAGE_SHIFT;
+
+	for (i = start ; i < end; i += MEMORY_INCREMENT)
+		numa_memory_lookup_table[i >> MEMORY_INCREMENT_SHIFT] = nid;
+}
+
 static inline void map_cpu_to_node(int cpu, int node)
 {
 	numa_cpu_lookup_table[cpu] = node;
@@ -378,9 +389,8 @@ new_range:
 				size / PAGE_SIZE;
 		}
 
-		for (i = start ; i < (start+size); i += MEMORY_INCREMENT)
-			numa_memory_lookup_table[i >> MEMORY_INCREMENT_SHIFT] =
-				numa_domain;
+		memory_present(numa_domain, start >> PAGE_SHIFT,
+					       (start + size) >> PAGE_SHIFT);
 
 		ranges--;
 		if (ranges)
@@ -428,8 +438,7 @@ static void __init setup_nonnuma(void)
 	init_node_data[0].node_start_pfn = 0;
 	init_node_data[0].node_spanned_pages = lmb_end_of_DRAM() / PAGE_SIZE;
 
-	for (i = 0 ; i < top_of_ram; i += MEMORY_INCREMENT)
-		numa_memory_lookup_table[i >> MEMORY_INCREMENT_SHIFT] = 0;
+	memory_present(0, 0, init_node_data[0].node_spanned_pages);
 
 	node0_io_hole_size = top_of_ram - total_ram;
 }
diff -puN include/linux/mmzone.h~A3.1-abstract-discontig include/linux/mmzone.h
--- sparse/include/linux/mmzone.h~A3.1-abstract-discontig	2005-02-24 08:56:39.000000000 -0800
+++ sparse-dave/include/linux/mmzone.h	2005-02-24 08:56:39.000000000 -0800
@@ -11,6 +11,7 @@
 #include <linux/cache.h>
 #include <linux/threads.h>
 #include <linux/numa.h>
+#include <linux/init.h>
 #include <asm/atomic.h>
 
 /* Free memory management - zoned buddy allocator.  */
@@ -278,6 +279,16 @@ void wakeup_kswapd(struct zone *zone, in
 int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
 		int alloc_type, int can_try_harder, int gfp_high);
 
+#ifdef CONFIG_HAVE_MEMORY_PRESENT
+void memory_present(int nid, unsigned long start, unsigned long end);
+#else
+static inline void memory_present(int nid, unsigned long start, unsigned long end) {}
+#endif
+
+#ifdef CONFIG_NEED_NODE_MEMMAP_SIZE
+unsigned long __init node_memmap_size_bytes(int, unsigned long, unsigned long);
+#endif
+
 /*
  * zone_idx() returns 0 for the ZONE_DMA zone, 1 for the ZONE_NORMAL zone, etc.
  */
diff -puN arch/i386/Kconfig~A3.1-abstract-discontig arch/i386/Kconfig
--- sparse/arch/i386/Kconfig~A3.1-abstract-discontig	2005-02-24 08:56:39.000000000 -0800
+++ sparse-dave/arch/i386/Kconfig	2005-02-24 08:56:39.000000000 -0800
@@ -769,6 +769,16 @@ config HAVE_ARCH_BOOTMEM_NODE
 	depends on NUMA
 	default y
 
+config HAVE_MEMORY_PRESENT
+	bool
+	depends on DISCONTIGMEM
+	default y
+
+config NEED_NODE_MEMMAP_SIZE
+	bool
+	depends on DISCONTIGMEM
+	default y
+
 config HIGHPTE
 	bool "Allocate 3rd-level pagetables from highmem"
 	depends on HIGHMEM4G || HIGHMEM64G
_
