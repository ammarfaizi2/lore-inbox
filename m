Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268513AbTCAFtR>; Sat, 1 Mar 2003 00:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268514AbTCAFtR>; Sat, 1 Mar 2003 00:49:17 -0500
Received: from holomorphy.com ([66.224.33.161]:18057 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268513AbTCAFtO>;
	Sat, 1 Mar 2003 00:49:14 -0500
Date: Fri, 28 Feb 2003 21:59:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: percpu-2.5.63-bkcurr
Message-ID: <20030301055922.GB1399@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shove per-cpu areas into node-local memory for i386 discontigmem,
or at least NUMA-Q. You'll have to plop down early_cpu_to_node()
and early_node_to_cpumask() stubs to use it on, say Summit.


-- wli

===== arch/i386/mm/discontig.c 1.9 vs edited =====
--- 1.9/arch/i386/mm/discontig.c	Fri Feb 28 15:08:58 2003
+++ edited/arch/i386/mm/discontig.c	Fri Feb 28 21:48:54 2003
@@ -48,8 +48,6 @@
 extern unsigned long totalram_pages;
 extern unsigned long totalhigh_pages;
 
-#define LARGE_PAGE_BYTES (PTRS_PER_PTE * PAGE_SIZE)
-
 unsigned long node_remap_start_pfn[MAX_NUMNODES];
 unsigned long node_remap_size[MAX_NUMNODES];
 unsigned long node_remap_offset[MAX_NUMNODES];
@@ -67,6 +65,20 @@
 		node_end_pfn[nid] = max_pfn;
 }
 
+extern char __per_cpu_start[], __per_cpu_end[];
+unsigned long __per_cpu_offset[NR_CPUS];
+
+#define PER_CPU_PAGES	PFN_UP((unsigned long)(__per_cpu_end-__per_cpu_start))
+#define MEM_MAP_SIZE(n)	PFN_UP((node_end_pfn[n]-node_start_pfn[n]+1)*sizeof(struct page))
+
+#ifdef CONFIG_X86_NUMAQ
+#define early_cpu_to_node(cpu)		((cpu)/4)
+#define early_node_to_cpumask(node)	(0xFUL << (4*(node)))
+#else
+#define early_cpu_to_node(cpu)		cpu_to_node(cpu)
+#define early_node_to_cpumask(node)	node_to_cpumask(node)
+#endif
+
 /* 
  * Allocate memory for the pg_data_t via a crude pre-bootmem method
  * We ought to relocate these onto their own node later on during boot.
@@ -82,6 +94,44 @@
 	}
 }
 
+static void __init allocate_one_cpu_area(int cpu)
+{
+	int cpu_in_node, node = early_cpu_to_node(cpu);
+	unsigned long nodemask = early_node_to_cpumask(node);
+	unsigned long node_vaddr = (unsigned long)node_remap_start_vaddr[node];
+
+	if (!PER_CPU_PAGES)
+		return;
+
+	if (!node) {
+		__per_cpu_offset[cpu] = min_low_pfn*PAGE_SIZE
+					+ PAGE_OFFSET
+					- (unsigned long)__per_cpu_start;
+		min_low_pfn += PER_CPU_PAGES;
+		return;
+	}
+
+	cpu_in_node = hweight32(nodemask & ((1UL << cpu) - 1));
+	__per_cpu_offset[cpu] = node_vaddr + MEM_MAP_SIZE(node)*PAGE_SIZE
+					+ PFN_UP(sizeof(pg_data_t))*PAGE_SIZE
+					+ PER_CPU_PAGES*cpu_in_node*PAGE_SIZE
+					- (unsigned long)__per_cpu_start;
+}
+
+void __init setup_per_cpu_areas(void)
+{
+	int node, cpu;
+	for (node = 0; node < numnodes; ++node) {
+		for (cpu = 0; cpu < NR_CPUS; ++cpu) {
+			if (early_cpu_to_node(cpu) == node) {
+				memcpy(RELOC_HIDE((char *)__per_cpu_start, __per_cpu_offset[cpu]),
+						__per_cpu_start,
+						PER_CPU_PAGES*PAGE_SIZE);
+			}
+		}
+	}
+}
+
 /*
  * Register fully available low RAM pages with the bootmem allocator.
  */
@@ -144,13 +194,11 @@
 	unsigned long size, reserve_pages = 0;
 
 	for (nid = 1; nid < numnodes; nid++) {
-		/* calculate the size of the mem_map needed in bytes */
-		size = (node_end_pfn[nid] - node_start_pfn[nid] + 1) 
-			* sizeof(struct page) + sizeof(pg_data_t);
-		/* convert size to large (pmd size) pages, rounding up */
-		size = (size + LARGE_PAGE_BYTES - 1) / LARGE_PAGE_BYTES;
-		/* now the roundup is correct, convert to PAGE_SIZE pages */
-		size = size * PTRS_PER_PTE;
+		/* calculate the size of the mem_map needed in pages */
+		size = MEM_MAP_SIZE(nid) + PFN_UP(sizeof(pg_data_t))
+			+ PER_CPU_PAGES*hweight32(early_node_to_cpumask(nid));
+		/* round up to nearest pmd boundary */
+		size = (size + PTRS_PER_PTE - 1) & ~(PTRS_PER_PTE - 1);
 		printk("Reserving %ld pages of KVA for lmem_map of node %d\n",
 				size, nid);
 		node_remap_size[nid] = size;
@@ -196,9 +244,14 @@
 	printk("Low memory ends at vaddr %08lx\n",
 			(ulong) pfn_to_kaddr(max_low_pfn));
 	for (nid = 0; nid < numnodes; nid++) {
+		int cpu;
 		node_remap_start_vaddr[nid] = pfn_to_kaddr(
 			highstart_pfn - node_remap_offset[nid]);
 		allocate_pgdat(nid);
+		for (cpu = 0; cpu < NR_CPUS; ++cpu) {
+			if (early_cpu_to_node(cpu) == nid)
+				allocate_one_cpu_area(cpu);
+		}
 		printk ("node %d will remap to vaddr %08lx - %08lx\n", nid,
 			(ulong) node_remap_start_vaddr[nid],
 			(ulong) pfn_to_kaddr(highstart_pfn
===== include/asm-i386/numaq.h 1.7 vs edited =====
--- 1.7/include/asm-i386/numaq.h	Fri Feb 28 15:03:59 2003
+++ edited/include/asm-i386/numaq.h	Fri Feb 28 18:37:53 2003
@@ -169,9 +169,9 @@
         struct	eachquadmem eq[MAX_NUMNODES];	/* indexed by quad id */
 };
 
-static inline unsigned long get_zholes_size(int nid)
+static inline unsigned long *get_zholes_size(int nid)
 {
-	return 0;
+	return NULL;
 }
 #endif /* CONFIG_X86_NUMAQ */
 #endif /* NUMAQ_H */
===== include/asm-i386/percpu.h 1.1 vs edited =====
--- 1.1/include/asm-i386/percpu.h	Fri Mar 15 04:55:35 2002
+++ edited/include/asm-i386/percpu.h	Fri Feb 28 18:31:26 2003
@@ -1,6 +1,30 @@
 #ifndef __ARCH_I386_PERCPU__
 #define __ARCH_I386_PERCPU__
 
+#include <linux/config.h>
+#include <linux/compiler.h>
+
+#ifndef CONFIG_DISCONTIGMEM
 #include <asm-generic/percpu.h>
+#else /* CONFIG_DISCONTIGMEM */
+
+extern unsigned long __per_cpu_offset[NR_CPUS];
+void setup_per_cpu_areas(void);
+
+/* Separate out the type, so (int[3], foo) works. */
+#ifndef MODULE
+#define DEFINE_PER_CPU(type, name) \
+    __attribute__((__section__(".data.percpu"))) __typeof__(type) name##__per_cpu
+#endif
+
+/* var is in discarded region: offset to particular copy we want */
+#define per_cpu(var, cpu) (*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
+#define __get_cpu_var(var) per_cpu(var, smp_processor_id())
+
+#define DECLARE_PER_CPU(type, name) extern __typeof__(type) name##__per_cpu
+#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(var##__per_cpu)
+#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(var##__per_cpu)
+
+#endif /* CONFIG_DISCONTIGMEM */
 
 #endif /* __ARCH_I386_PERCPU__ */
