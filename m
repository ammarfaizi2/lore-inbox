Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268243AbTCCBdM>; Sun, 2 Mar 2003 20:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268244AbTCCBdM>; Sun, 2 Mar 2003 20:33:12 -0500
Received: from holomorphy.com ([66.224.33.161]:54160 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268243AbTCCBdK>;
	Sun, 2 Mar 2003 20:33:10 -0500
Date: Sun, 2 Mar 2003 17:43:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: percpu-2.5.63-bk5-1 (properly generated)
Message-ID: <20030303014320.GM1195@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <47970000.1046629477@[10.10.2.4]> <20030302202451.GJ1195@holomorphy.com> <50380000.1046637959@[10.10.2.4]> <20030302210606.GS24172@holomorphy.com> <85980000.1046642338@[10.10.2.4]> <20030302221037.GK1195@holomorphy.com> <87420000.1046646801@[10.10.2.4]> <20030302234252.GL1195@holomorphy.com> <88060000.1046650020@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88060000.1046650020@[10.10.2.4]>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 04:07:01PM -0800, Martin J. Bligh wrote:
> Failing that, if you can split it into 3 or 4 patches along the lines I
> suggested earlier, I'll try benching each bit seperately for you.

Last ditch effort. No per_node stuff at all, and no new per_cpu users.


-- wli


diff -urpN linux-2.5.63-bk5/arch/i386/mm/discontig.c pernode-2.5.63-bk5-3/arch/i386/mm/discontig.c
--- linux-2.5.63-bk5/arch/i386/mm/discontig.c	2003-03-02 01:05:07.000000000 -0800
+++ pernode-2.5.63-bk5-3/arch/i386/mm/discontig.c	2003-03-02 16:11:07.000000000 -0800
@@ -48,8 +48,6 @@ extern unsigned long max_low_pfn;
 extern unsigned long totalram_pages;
 extern unsigned long totalhigh_pages;
 
-#define LARGE_PAGE_BYTES (PTRS_PER_PTE * PAGE_SIZE)
-
 unsigned long node_remap_start_pfn[MAX_NUMNODES];
 unsigned long node_remap_size[MAX_NUMNODES];
 unsigned long node_remap_offset[MAX_NUMNODES];
@@ -67,6 +65,44 @@ static void __init find_max_pfn_node(int
 		node_end_pfn[nid] = max_pfn;
 }
 
+extern char __per_cpu_start[], __per_cpu_end[];
+unsigned long __per_cpu_offset[NR_CPUS];
+
+#define PER_CPU_PAGES	PFN_UP((unsigned long)(__per_cpu_end-__per_cpu_start))
+#define MEM_MAP_SIZE(n)	PFN_UP((node_end_pfn[n]-node_start_pfn[n]+1)*sizeof(struct page))
+
+static void __init allocate_per_cpu_pages(int cpu)
+{
+	int cpu_in_node, node = cpu_to_node(cpu);
+	unsigned long vaddr, nodemask = node_to_cpumask(node);
+
+	if (!PER_CPU_PAGES || node >= numnodes)
+		return;
+
+	if (!node) {
+		vaddr  = (unsigned long)alloc_bootmem(PER_CPU_PAGES*PAGE_SIZE);
+		__per_cpu_offset[cpu] = vaddr - (unsigned long)__per_cpu_start;
+	} else {
+		vaddr = (unsigned long)node_remap_start_vaddr[node];
+		cpu_in_node = hweight32(nodemask & ((1UL << cpu) - 1));
+		__per_cpu_offset[cpu] = vaddr + PAGE_SIZE*MEM_MAP_SIZE(node)
+					+ PAGE_SIZE*PFN_UP(sizeof(pg_data_t))
+					+ PAGE_SIZE*PER_CPU_PAGES*cpu_in_node
+					- (unsigned long)__per_cpu_start;
+	}
+	memcpy(RELOC_HIDE((char *)__per_cpu_start, __per_cpu_offset[cpu]),
+			__per_cpu_start,
+			PER_CPU_PAGES*PAGE_SIZE);
+}
+
+void __init setup_per_cpu_areas(void)
+{
+	int cpu;
+	for (cpu = 0; cpu < NR_CPUS; ++cpu)
+		allocate_per_cpu_pages(cpu);
+}
+
+
 /* 
  * Allocate memory for the pg_data_t via a crude pre-bootmem method
  * We ought to relocate these onto their own node later on during boot.
@@ -144,13 +180,11 @@ static unsigned long calculate_numa_rema
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
+			+ PER_CPU_PAGES*MAX_NODE_CPUS;
+		/* round up to nearest pmd boundary */
+		size = (size + PTRS_PER_PTE - 1) & ~(PTRS_PER_PTE - 1);
 		printk("Reserving %ld pages of KVA for lmem_map of node %d\n",
 				size, nid);
 		node_remap_size[nid] = size;
diff -urpN linux-2.5.63-bk5/include/asm-generic/percpu.h pernode-2.5.63-bk5-3/include/asm-generic/percpu.h
--- linux-2.5.63-bk5/include/asm-generic/percpu.h	2003-02-24 11:05:13.000000000 -0800
+++ pernode-2.5.63-bk5-3/include/asm-generic/percpu.h	2003-03-02 02:55:14.000000000 -0800
@@ -25,8 +25,8 @@ extern unsigned long __per_cpu_offset[NR
     __typeof__(type) name##__per_cpu
 #endif
 
-#define per_cpu(var, cpu)			((void)cpu, var##__per_cpu)
-#define __get_cpu_var(var)			var##__per_cpu
+#define per_cpu(var, cpu)		( (void)(cpu), var##__per_cpu )
+#define __get_cpu_var(var)		var##__per_cpu
 
 #endif	/* SMP */
 
diff -urpN linux-2.5.63-bk5/include/asm-i386/numaq.h pernode-2.5.63-bk5-3/include/asm-i386/numaq.h
--- linux-2.5.63-bk5/include/asm-i386/numaq.h	2003-03-02 01:05:09.000000000 -0800
+++ pernode-2.5.63-bk5-3/include/asm-i386/numaq.h	2003-03-02 02:55:14.000000000 -0800
@@ -39,8 +39,9 @@
 extern int physnode_map[];
 #define pfn_to_nid(pfn)	({ physnode_map[(pfn) / PAGES_PER_ELEMENT]; })
 #define pfn_to_pgdat(pfn) NODE_DATA(pfn_to_nid(pfn))
-#define PHYSADDR_TO_NID(pa) pfn_to_nid(pa >> PAGE_SHIFT)
-#define MAX_NUMNODES		8
+#define PHYSADDR_TO_NID(pa) pfn_to_nid((pa) >> PAGE_SHIFT)
+#define MAX_NUMNODES		16
+#define MAX_NODE_CPUS		4
 extern void get_memcfg_numaq(void);
 #define get_memcfg_numa() get_memcfg_numaq()
 
@@ -169,9 +170,9 @@ struct sys_cfg_data {
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
diff -urpN linux-2.5.63-bk5/include/asm-i386/percpu.h pernode-2.5.63-bk5-3/include/asm-i386/percpu.h
--- linux-2.5.63-bk5/include/asm-i386/percpu.h	2003-02-24 11:05:44.000000000 -0800
+++ pernode-2.5.63-bk5-3/include/asm-i386/percpu.h	2003-03-02 02:55:14.000000000 -0800
@@ -3,4 +3,9 @@
 
 #include <asm-generic/percpu.h>
 
+#ifdef CONFIG_NUMA
+#undef	__GENERIC_PER_CPU
+void setup_per_cpu_areas(void);
+#endif
+
 #endif /* __ARCH_I386_PERCPU__ */
diff -urpN linux-2.5.63-bk5/include/asm-i386/srat.h pernode-2.5.63-bk5-3/include/asm-i386/srat.h
--- linux-2.5.63-bk5/include/asm-i386/srat.h	2003-03-02 01:05:09.000000000 -0800
+++ pernode-2.5.63-bk5-3/include/asm-i386/srat.h	2003-03-02 02:55:14.000000000 -0800
@@ -37,8 +37,9 @@
 extern int pfnnode_map[];
 #define pfn_to_nid(pfn) ({ pfnnode_map[PFN_TO_ELEMENT(pfn)]; })
 #define pfn_to_pgdat(pfn) NODE_DATA(pfn_to_nid(pfn))
-#define PHYSADDR_TO_NID(pa) pfn_to_nid(pa >> PAGE_SHIFT)
+#define PHYSADDR_TO_NID(pa) pfn_to_nid((pa) >> PAGE_SHIFT)
 #define MAX_NUMNODES		8
+#define MAX_NODE_CPUS		4
 extern void get_memcfg_from_srat(void);
 extern unsigned long *get_zholes_size(int);
 #define get_memcfg_numa() get_memcfg_from_srat()
