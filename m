Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269176AbTCBKcI>; Sun, 2 Mar 2003 05:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269179AbTCBKcI>; Sun, 2 Mar 2003 05:32:08 -0500
Received: from holomorphy.com ([66.224.33.161]:37005 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S269176AbTCBKbz>;
	Sun, 2 Mar 2003 05:31:55 -0500
Date: Sun, 2 Mar 2003 02:42:04 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: percpu-2.5.63-bk5-1
Message-ID: <20030302104204.GC1399@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does a 3 different things:
(1) shoves per-cpu areas into node-local memory
(2) creates a new per-node thing analogous to per-cpu
(3) uses (1) and (2) to shove several frequently-accessed things into
	node-local memory

Tested, boots, and runs on NUMA-Q. Trims 6s of 41s off kernel compiles.
Compiletested for walmart x86 SMP/UP, and could use runtime testing.
A few non-x86 arches probably need fixups for per_cpu irq_stat[].


-- wli


diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/arch/i386/kernel/apic.c pernode-2.5/arch/i386/kernel/apic.c
--- virgin-2.5/arch/i386/kernel/apic.c	Sat Mar  1 19:50:47 2003
+++ pernode-2.5/arch/i386/kernel/apic.c	Sat Mar  1 22:22:59 2003
@@ -1060,7 +1060,7 @@
 	/*
 	 * the NMI deadlock-detector uses this.
 	 */
-	irq_stat[cpu].apic_timer_irqs++;
+	per_cpu(irq_stat, cpu).apic_timer_irqs++;
 
 	/*
 	 * NOTE! We'd better ACK the irq immediately,
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/arch/i386/kernel/io_apic.c pernode-2.5/arch/i386/kernel/io_apic.c
--- virgin-2.5/arch/i386/kernel/io_apic.c	Sat Mar  1 19:50:47 2003
+++ pernode-2.5/arch/i386/kernel/io_apic.c	Sat Mar  1 22:22:59 2003
@@ -237,7 +237,7 @@
 #define IRQ_DELTA(cpu,irq) 	(irq_cpu_data[cpu].irq_delta[irq])
 
 #define IDLE_ENOUGH(cpu,now) \
-		(idle_cpu(cpu) && ((now) - irq_stat[(cpu)].idle_timestamp > 1))
+		(idle_cpu(cpu) && ((now) - per_cpu(irq_stat, cpu).idle_timestamp > 1))
 
 #define IRQ_ALLOWED(cpu,allowed_mask) \
 		((1 << cpu) & (allowed_mask))
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/arch/i386/kernel/irq.c pernode-2.5/arch/i386/kernel/irq.c
--- virgin-2.5/arch/i386/kernel/irq.c	Sat Mar  1 19:50:47 2003
+++ pernode-2.5/arch/i386/kernel/irq.c	Sat Mar  1 22:22:59 2003
@@ -171,7 +171,7 @@
 	seq_printf(p, "LOC: ");
 	for (j = 0; j < NR_CPUS; j++)
 		if (cpu_online(j))
-			p += seq_printf(p, "%10u ", irq_stat[j].apic_timer_irqs);
+			p += seq_printf(p, "%10u ", per_cpu(irq_stat, j).apic_timer_irqs);
 	seq_putc(p, '\n');
 #endif
 	seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/arch/i386/kernel/nmi.c pernode-2.5/arch/i386/kernel/nmi.c
--- virgin-2.5/arch/i386/kernel/nmi.c	Sat Mar  1 19:50:47 2003
+++ pernode-2.5/arch/i386/kernel/nmi.c	Sat Mar  1 22:22:59 2003
@@ -76,7 +76,7 @@
 	printk(KERN_INFO "testing NMI watchdog ... ");
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
-		prev_nmi_count[cpu] = irq_stat[cpu].__nmi_count;
+		prev_nmi_count[cpu] = per_cpu(irq_stat, cpu).__nmi_count;
 	local_irq_enable();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
@@ -358,7 +358,7 @@
 	 */
 	int sum, cpu = smp_processor_id();
 
-	sum = irq_stat[cpu].apic_timer_irqs;
+	sum = per_cpu(irq_stat, cpu).apic_timer_irqs;
 
 	if (last_irq_sums[cpu] == sum) {
 		/*
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/arch/i386/kernel/process.c pernode-2.5/arch/i386/kernel/process.c
--- virgin-2.5/arch/i386/kernel/process.c	Sat Mar  1 19:50:47 2003
+++ pernode-2.5/arch/i386/kernel/process.c	Sat Mar  1 22:22:59 2003
@@ -141,7 +141,7 @@
 		void (*idle)(void) = pm_idle;
 		if (!idle)
 			idle = default_idle;
-		irq_stat[smp_processor_id()].idle_timestamp = jiffies;
+		per_cpu(irq_stat, smp_processor_id()).idle_timestamp = jiffies;
 		while (!need_resched())
 			idle();
 		schedule();
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/arch/i386/mm/discontig.c pernode-2.5/arch/i386/mm/discontig.c
--- virgin-2.5/arch/i386/mm/discontig.c	Sat Mar  1 19:50:48 2003
+++ pernode-2.5/arch/i386/mm/discontig.c	Sat Mar  1 22:23:00 2003
@@ -48,8 +48,6 @@
 extern unsigned long totalram_pages;
 extern unsigned long totalhigh_pages;
 
-#define LARGE_PAGE_BYTES (PTRS_PER_PTE * PAGE_SIZE)
-
 unsigned long node_remap_start_pfn[MAX_NUMNODES];
 unsigned long node_remap_size[MAX_NUMNODES];
 unsigned long node_remap_offset[MAX_NUMNODES];
@@ -67,6 +65,74 @@
 		node_end_pfn[nid] = max_pfn;
 }
 
+extern char __per_cpu_start[], __per_cpu_end[];
+extern char __per_node_start[], __per_node_end[];
+unsigned long __per_cpu_offset[NR_CPUS], __per_node_offset[MAX_NR_NODES];
+
+#define PER_CPU_PAGES	PFN_UP((unsigned long)(__per_cpu_end-__per_cpu_start))
+#define PER_NODE_PAGES	PFN_UP((unsigned long)(__per_node_end-__per_node_start))
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
+					+ PAGE_SIZE*PER_NODE_PAGES
+					+ PAGE_SIZE*PER_CPU_PAGES*cpu_in_node
+					- (unsigned long)__per_cpu_start;
+	}
+	memcpy(RELOC_HIDE((char *)__per_cpu_start, __per_cpu_offset[cpu]),
+			__per_cpu_start,
+			PER_CPU_PAGES*PAGE_SIZE);
+}
+
+static void __init allocate_per_node_pages(int node)
+{
+	unsigned long vaddr;
+
+	if (!node) {
+		vaddr = (unsigned long)alloc_bootmem(PER_NODE_PAGES*PAGE_SIZE);
+		__per_node_offset[node] = vaddr - (unsigned long)__per_node_start;
+	} else {
+		vaddr = (unsigned long)node_remap_start_vaddr[node];
+		__per_node_offset[node] = vaddr + PAGE_SIZE*MEM_MAP_SIZE(node)
+					+ PAGE_SIZE*PFN_UP(sizeof(pg_data_t))
+					- (unsigned long)__per_node_start;
+	}
+	memcpy(RELOC_HIDE((char *)__per_node_start, __per_node_offset[node]),
+			__per_node_start,
+			PER_NODE_PAGES*PAGE_SIZE);
+}
+
+void __init setup_per_cpu_areas(void)
+{
+	int cpu;
+	for (cpu = 0; cpu < NR_CPUS; ++cpu)
+		allocate_per_cpu_pages(cpu);
+}
+
+void __init setup_per_node_areas(void)
+{
+	int node;
+	void zone_sizes_init(void);
+
+	for (node = 0; node < numnodes; ++node)
+		allocate_per_node_pages(node);
+	zone_sizes_init();
+}
+
 /* 
  * Allocate memory for the pg_data_t via a crude pre-bootmem method
  * We ought to relocate these onto their own node later on during boot.
@@ -144,13 +210,12 @@
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
+			+ PER_NODE_PAGES
+			+ PER_CPU_PAGES*MAX_NODE_CPUS;
+		/* round up to nearest pmd boundary */
+		size = (size + PTRS_PER_PTE - 1) & ~(PTRS_PER_PTE - 1);
 		printk("Reserving %ld pages of KVA for lmem_map of node %d\n",
 				size, nid);
 		node_remap_size[nid] = size;
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/arch/i386/mm/init.c pernode-2.5/arch/i386/mm/init.c
--- virgin-2.5/arch/i386/mm/init.c	Sat Mar  1 19:50:48 2003
+++ pernode-2.5/arch/i386/mm/init.c	Sat Mar  1 22:23:00 2003
@@ -41,7 +41,7 @@
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
 
-struct mmu_gather mmu_gathers[NR_CPUS];
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 unsigned long highstart_pfn, highend_pfn;
 
 /*
@@ -372,7 +372,9 @@
 	__flush_tlb_all();
 
 	kmap_init();
+#ifndef CONFIG_DISCONTIGMEM
 	zone_sizes_init();
+#endif
 }
 
 /*
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/arch/i386/vmlinux.lds.S pernode-2.5/arch/i386/vmlinux.lds.S
--- virgin-2.5/arch/i386/vmlinux.lds.S	Sat Mar  1 19:50:47 2003
+++ pernode-2.5/arch/i386/vmlinux.lds.S	Sat Mar  1 22:22:59 2003
@@ -83,6 +83,10 @@
   .data.percpu  : { *(.data.percpu) }
   __per_cpu_end = .;
   . = ALIGN(4096);
+  __per_node_start = .;
+  .data.pernode  : { *(.data.pernode) }
+  __per_node_end = .;
+  . = ALIGN(4096);
   __init_end = .;
   /* freed after init ends here */
 	
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/include/asm-generic/percpu.h pernode-2.5/include/asm-generic/percpu.h
--- virgin-2.5/include/asm-generic/percpu.h	Sat Mar  1 19:51:11 2003
+++ pernode-2.5/include/asm-generic/percpu.h	Wed Dec 31 16:00:00 1969
@@ -1,38 +0,0 @@
-#ifndef _ASM_GENERIC_PERCPU_H_
-#define _ASM_GENERIC_PERCPU_H_
-#include <linux/compiler.h>
-
-#define __GENERIC_PER_CPU
-#ifdef CONFIG_SMP
-
-extern unsigned long __per_cpu_offset[NR_CPUS];
-
-/* Separate out the type, so (int[3], foo) works. */
-#ifndef MODULE
-#define DEFINE_PER_CPU(type, name) \
-    __attribute__((__section__(".data.percpu"))) __typeof__(type) name##__per_cpu
-#endif
-
-/* var is in discarded region: offset to particular copy we want */
-#define per_cpu(var, cpu) (*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
-#define __get_cpu_var(var) per_cpu(var, smp_processor_id())
-
-#else /* ! SMP */
-
-/* Can't define per-cpu variables in modules.  Sorry --RR */
-#ifndef MODULE
-#define DEFINE_PER_CPU(type, name) \
-    __typeof__(type) name##__per_cpu
-#endif
-
-#define per_cpu(var, cpu)			((void)cpu, var##__per_cpu)
-#define __get_cpu_var(var)			var##__per_cpu
-
-#endif	/* SMP */
-
-#define DECLARE_PER_CPU(type, name) extern __typeof__(type) name##__per_cpu
-
-#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(var##__per_cpu)
-#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(var##__per_cpu)
-
-#endif /* _ASM_GENERIC_PERCPU_H_ */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/include/asm-i386/numaq.h pernode-2.5/include/asm-i386/numaq.h
--- virgin-2.5/include/asm-i386/numaq.h	Sat Mar  1 19:51:11 2003
+++ pernode-2.5/include/asm-i386/numaq.h	Sat Mar  1 22:23:21 2003
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
 
@@ -169,9 +170,9 @@
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
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/include/asm-i386/percpu.h pernode-2.5/include/asm-i386/percpu.h
--- virgin-2.5/include/asm-i386/percpu.h	Sat Mar  1 19:51:11 2003
+++ pernode-2.5/include/asm-i386/percpu.h	Sat Mar  1 22:23:21 2003
@@ -3,4 +3,9 @@
 
 #include <asm-generic/percpu.h>
 
+#ifdef CONFIG_NUMA
+#undef	__GENERIC_PER_CPU
+void setup_per_cpu_areas(void);
+#endif
+
 #endif /* __ARCH_I386_PERCPU__ */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/include/asm-i386/pernode.h pernode-2.5/include/asm-i386/pernode.h
--- virgin-2.5/include/asm-i386/pernode.h	Wed Dec 31 16:00:00 1969
+++ pernode-2.5/include/asm-i386/pernode.h	Sat Mar  1 22:23:21 2003
@@ -0,0 +1,11 @@
+#ifndef __ARCH_I386_PERNODE__
+#define __ARCH_I386_PERNODE__
+
+#include <asm-generic/pernode.h>
+
+#ifdef CONFIG_DISCONTIGMEM
+#undef	__GENERIC_PER_NODE
+void setup_per_node_areas(void);
+#endif
+
+#endif /* __ARCH_I386_PERNODE__ */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/include/asm-i386/srat.h pernode-2.5/include/asm-i386/srat.h
--- virgin-2.5/include/asm-i386/srat.h	Sat Mar  1 19:51:11 2003
+++ pernode-2.5/include/asm-i386/srat.h	Sat Mar  1 22:23:21 2003
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
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/include/asm-i386/tlb.h pernode-2.5/include/asm-i386/tlb.h
--- virgin-2.5/include/asm-i386/tlb.h	Sat Mar  1 19:51:11 2003
+++ pernode-2.5/include/asm-i386/tlb.h	Sat Mar  1 22:23:21 2003
@@ -1,6 +1,10 @@
 #ifndef _I386_TLB_H
 #define _I386_TLB_H
 
+#include <linux/config.h>
+#include <asm/tlbflush.h>
+#include <asm/percpu.h>
+
 /*
  * x86 doesn't need any special per-pte or
  * per-vma handling..
@@ -15,6 +19,128 @@
  */
 #define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
 
-#include <asm-generic/tlb.h>
+/*
+ * For UP we don't need to worry about TLB flush
+ * and page free order so much..
+ */
+#ifdef CONFIG_SMP
+  #define FREE_PTE_NR	506
+  #define tlb_fast_mode(tlb) ((tlb)->nr == ~0U)
+#else
+  #define FREE_PTE_NR	1
+  #define tlb_fast_mode(tlb) 1
+#endif
+
+/* struct mmu_gather is an opaque type used by the mm code for passing around
+ * any data needed by arch specific code for tlb_remove_page.  This structure
+ * can be per-CPU or per-MM as the page table lock is held for the duration of
+ * TLB shootdown.
+ */
+struct mmu_gather {
+	struct mm_struct	*mm;
+	unsigned int		nr;	/* set to ~0U means fast mode */
+	unsigned int		need_flush;/* Really unmapped some ptes? */
+	unsigned int		fullmm; /* non-zero means full mm flush */
+	unsigned long		freed;
+	struct page *		pages[FREE_PTE_NR];
+};
+
+/* Users of the generic TLB shootdown code must declare this storage space. */
+DECLARE_PER_CPU(struct mmu_gather, mmu_gathers);
+
+/* tlb_gather_mmu
+ *	Return a pointer to an initialized struct mmu_gather.
+ */
+static inline struct mmu_gather *
+tlb_gather_mmu(struct mm_struct *mm, unsigned int full_mm_flush)
+{
+	struct mmu_gather *tlb = &per_cpu(mmu_gathers, smp_processor_id());
+
+	tlb->mm = mm;
+
+	/* Use fast mode if only one CPU is online */
+	tlb->nr = num_online_cpus() > 1 ? 0U : ~0U;
+
+	tlb->fullmm = full_mm_flush;
+	tlb->freed = 0;
+
+	return tlb;
+}
+
+static inline void
+tlb_flush_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long end)
+{
+	if (!tlb->need_flush)
+		return;
+	tlb->need_flush = 0;
+	tlb_flush(tlb);
+	if (!tlb_fast_mode(tlb)) {
+		free_pages_and_swap_cache(tlb->pages, tlb->nr);
+		tlb->nr = 0;
+	}
+}
+
+/* tlb_finish_mmu
+ *	Called at the end of the shootdown operation to free up any resources
+ *	that were required.  The page table lock is still held at this point.
+ */
+static inline void
+tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long end)
+{
+	int freed = tlb->freed;
+	struct mm_struct *mm = tlb->mm;
+	int rss = mm->rss;
+
+	if (rss < freed)
+		freed = rss;
+	mm->rss = rss - freed;
+	tlb_flush_mmu(tlb, start, end);
+
+	/* keep the page table cache within bounds */
+	check_pgt_cache();
+}
+
+
+/* void tlb_remove_page(struct mmu_gather *tlb, pte_t *ptep, unsigned long addr)
+ *	Must perform the equivalent to __free_pte(pte_get_and_clear(ptep)), while
+ *	handling the additional races in SMP caused by other CPUs caching valid
+ *	mappings in their TLBs.
+ */
+static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
+{
+	tlb->need_flush = 1;
+	if (tlb_fast_mode(tlb)) {
+		free_page_and_swap_cache(page);
+		return;
+	}
+	tlb->pages[tlb->nr++] = page;
+	if (tlb->nr >= FREE_PTE_NR)
+		tlb_flush_mmu(tlb, 0, 0);
+}
+
+/**
+ * tlb_remove_tlb_entry - remember a pte unmapping for later tlb invalidation.
+ *
+ * Record the fact that pte's were really umapped in ->need_flush, so we can
+ * later optimise away the tlb invalidate.   This helps when userspace is
+ * unmapping already-unmapped pages, which happens quite a lot.
+ */
+#define tlb_remove_tlb_entry(tlb, ptep, address)		\
+	do {							\
+		tlb->need_flush = 1;				\
+		__tlb_remove_tlb_entry(tlb, ptep, address);	\
+	} while (0)
+
+#define pte_free_tlb(tlb, ptep)					\
+	do {							\
+		tlb->need_flush = 1;				\
+		__pte_free_tlb(tlb, ptep);			\
+	} while (0)
+
+#define pmd_free_tlb(tlb, pmdp)					\
+	do {							\
+		tlb->need_flush = 1;				\
+		__pmd_free_tlb(tlb, pmdp);			\
+	} while (0)
 
 #endif
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/include/linux/irq_cpustat.h pernode-2.5/include/linux/irq_cpustat.h
--- virgin-2.5/include/linux/irq_cpustat.h	Sat Mar  1 19:51:17 2003
+++ pernode-2.5/include/linux/irq_cpustat.h	Sat Mar  1 22:23:24 2003
@@ -17,14 +17,12 @@
  * definitions instead of differing sets for each arch.
  */
 
-extern irq_cpustat_t irq_stat[];			/* defined in asm/hardirq.h */
+/* defined in kernel/softirq.c */
+DECLARE_PER_CPU(irq_cpustat_t, irq_stat);
 
 #ifndef __ARCH_IRQ_STAT /* Some architectures can do this more efficiently */ 
-#ifdef CONFIG_SMP
-#define __IRQ_STAT(cpu, member)	(irq_stat[cpu].member)
-#else
-#define __IRQ_STAT(cpu, member)	((void)(cpu), irq_stat[0].member)
-#endif	
+
+#define __IRQ_STAT(cpu, member)	(per_cpu(irq_stat, cpu).member)
 #endif
 
   /* arch independent irq_stat fields */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/include/linux/mm.h pernode-2.5/include/linux/mm.h
--- virgin-2.5/include/linux/mm.h	Sat Mar  1 19:51:17 2003
+++ pernode-2.5/include/linux/mm.h	Sat Mar  1 22:17:35 2003
@@ -26,6 +26,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/atomic.h>
+#include <asm/pernode.h>
 
 /*
  * Linux kernel virtual memory manager primitives.
@@ -318,11 +319,12 @@
 #define ZONE_SHIFT (BITS_PER_LONG - 8)
 
 struct zone;
-extern struct zone *zone_table[];
+DECLARE_PER_NODE(struct zone *[MAX_NR_ZONES], zone_table);
 
 static inline struct zone *page_zone(struct page *page)
 {
-	return zone_table[page->flags >> ZONE_SHIFT];
+	unsigned long zone = page->flags >> ZONE_SHIFT;
+	return per_node(zone_table, zone/MAX_NR_ZONES)[zone % MAX_NR_ZONES];
 }
 
 static inline void set_page_zone(struct page *page, unsigned long zone_num)
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/init/main.c pernode-2.5/init/main.c
--- virgin-2.5/init/main.c	Sat Mar  1 19:51:19 2003
+++ pernode-2.5/init/main.c	Sat Mar  1 22:23:25 2003
@@ -29,6 +29,7 @@
 #include <linux/tty.h>
 #include <linux/gfp.h>
 #include <linux/percpu.h>
+#include <asm/pernode.h>
 #include <linux/kernel_stat.h>
 #include <linux/security.h>
 #include <linux/workqueue.h>
@@ -277,6 +278,10 @@
 extern void setup_arch(char **);
 extern void cpu_idle(void);
 
+#ifndef CONFIG_NUMA
+static inline void setup_per_node_areas(void) { }
+#endif
+
 #ifndef CONFIG_SMP
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -317,6 +322,30 @@
 }
 #endif /* !__GENERIC_PER_CPU */
 
+#if defined(__GENERIC_PER_NODE) && defined(CONFIG_NUMA)
+unsigned long __per_node_offset[MAX_NR_NODES];
+
+static void __init setup_per_node_areas(void)
+{
+	unsigned long size, i;
+	char *ptr;
+	/* Created by linker magic */
+	extern char __per_node_start[], __per_node_end[];
+
+	/* Copy section for each CPU (we discard the original) */
+	size = ALIGN(__per_node_end - __per_node_start, SMP_CACHE_BYTES);
+	if (!size)
+		return;
+
+	ptr = alloc_bootmem(size * MAX_NR_NODES);
+
+	for (i = 0; i < MAX_NR_NODES; i++, ptr += size) {
+		__per_node_offset[i] = ptr - __per_node_start;
+		memcpy(ptr, __per_node_start, size);
+	}
+}
+#endif /* __GENERIC_PER_NODE && CONFIG_NUMA */
+
 /* Called by boot processor to activate the rest. */
 static void __init smp_init(void)
 {
@@ -376,6 +405,7 @@
 	printk(linux_banner);
 	setup_arch(&command_line);
 	setup_per_cpu_areas();
+	setup_per_node_areas();
 
 	/*
 	 * Mark the boot cpu "online" so that it can call console drivers in
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/kernel/fork.c pernode-2.5/kernel/fork.c
--- virgin-2.5/kernel/fork.c	Sat Mar  1 19:51:19 2003
+++ pernode-2.5/kernel/fork.c	Sat Mar  1 22:23:25 2003
@@ -58,7 +58,7 @@
  * the very last portion of sys_exit() is executed with
  * preemption turned off.
  */
-static task_t *task_cache[NR_CPUS] __cacheline_aligned;
+static DEFINE_PER_CPU(task_t *, task_cache);
 
 int nr_processes(void)
 {
@@ -86,12 +86,12 @@
 	} else {
 		int cpu = get_cpu();
 
-		tsk = task_cache[cpu];
+		tsk = per_cpu(task_cache, cpu);
 		if (tsk) {
 			free_thread_info(tsk->thread_info);
 			kmem_cache_free(task_struct_cachep,tsk);
 		}
-		task_cache[cpu] = current;
+		per_cpu(task_cache, cpu) = current;
 		put_cpu();
 	}
 }
@@ -214,8 +214,8 @@
 	struct thread_info *ti;
 	int cpu = get_cpu();
 
-	tsk = task_cache[cpu];
-	task_cache[cpu] = NULL;
+	tsk = per_cpu(task_cache, cpu);
+	per_cpu(task_cache, cpu) = NULL;
 	put_cpu();
 	if (!tsk) {
 		ti = alloc_thread_info();
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/kernel/ksyms.c pernode-2.5/kernel/ksyms.c
--- virgin-2.5/kernel/ksyms.c	Sat Mar  1 19:51:19 2003
+++ pernode-2.5/kernel/ksyms.c	Sat Mar  1 22:23:25 2003
@@ -405,7 +405,7 @@
 EXPORT_SYMBOL(del_timer);
 EXPORT_SYMBOL(request_irq);
 EXPORT_SYMBOL(free_irq);
-EXPORT_SYMBOL(irq_stat);
+EXPORT_PER_CPU_SYMBOL(irq_stat);
 
 /* waitqueue handling */
 EXPORT_SYMBOL(add_wait_queue);
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/kernel/sched.c pernode-2.5/kernel/sched.c
--- virgin-2.5/kernel/sched.c	Sat Mar  1 19:51:19 2003
+++ pernode-2.5/kernel/sched.c	Sat Mar  1 22:23:25 2003
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/timer.h>
 #include <linux/rcupdate.h>
+#include <asm/pernode.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -166,9 +167,9 @@
 	atomic_t nr_iowait;
 } ____cacheline_aligned;
 
-static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
+static DEFINE_PER_CPU(struct runqueue, runqueues) = {{ 0 }};
 
-#define cpu_rq(cpu)		(runqueues + (cpu))
+#define cpu_rq(cpu)		(&per_cpu(runqueues, cpu))
 #define this_rq()		cpu_rq(smp_processor_id())
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
@@ -189,12 +190,11 @@
  * Keep track of running tasks.
  */
 
-static atomic_t node_nr_running[MAX_NUMNODES] ____cacheline_maxaligned_in_smp =
-	{[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)};
+static DEFINE_PER_NODE(atomic_t, node_nr_running) = ATOMIC_INIT(0);
 
 static inline void nr_running_init(struct runqueue *rq)
 {
-	rq->node_nr_running = &node_nr_running[0];
+	rq->node_nr_running = &per_node(node_nr_running, 0);
 }
 
 static inline void nr_running_inc(runqueue_t *rq)
@@ -214,7 +214,7 @@
 	int i;
 
 	for (i = 0; i < NR_CPUS; i++)
-		cpu_rq(i)->node_nr_running = &node_nr_running[cpu_to_node(i)];
+		cpu_rq(i)->node_nr_running = &per_node(node_nr_running, cpu_to_node(i));
 }
 
 #else /* !CONFIG_NUMA */
@@ -748,7 +748,7 @@
 
 	minload = 10000000;
 	for (i = 0; i < numnodes; i++) {
-		load = atomic_read(&node_nr_running[i]);
+		load = atomic_read(&per_node(node_nr_running, i));
 		if (load < minload) {
 			minload = load;
 			node = i;
@@ -790,13 +790,13 @@
 	int i, node = -1, load, this_load, maxload;
 	
 	this_load = maxload = (this_rq()->prev_node_load[this_node] >> 1)
-		+ atomic_read(&node_nr_running[this_node]);
+		+ atomic_read(&per_node(node_nr_running, this_node));
 	this_rq()->prev_node_load[this_node] = this_load;
 	for (i = 0; i < numnodes; i++) {
 		if (i == this_node)
 			continue;
 		load = (this_rq()->prev_node_load[i] >> 1)
-			+ atomic_read(&node_nr_running[i]);
+			+ atomic_read(&per_node(node_nr_running, i));
 		this_rq()->prev_node_load[i] = load;
 		if (load > maxload && (100*load > NODE_THRESHOLD*this_load)) {
 			maxload = load;
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/kernel/softirq.c pernode-2.5/kernel/softirq.c
--- virgin-2.5/kernel/softirq.c	Sat Mar  1 19:51:19 2003
+++ pernode-2.5/kernel/softirq.c	Sat Mar  1 22:23:25 2003
@@ -32,7 +32,7 @@
    - Tasklets: serialized wrt itself.
  */
 
-irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned;
+DEFINE_PER_CPU(irq_cpustat_t, irq_stat);
 
 static struct softirq_action softirq_vec[32] __cacheline_aligned_in_smp;
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/mm/page_alloc.c pernode-2.5/mm/page_alloc.c
--- virgin-2.5/mm/page_alloc.c	Sat Mar  1 19:51:20 2003
+++ pernode-2.5/mm/page_alloc.c	Sat Mar  1 22:23:25 2003
@@ -44,8 +44,8 @@
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
  */
-struct zone *zone_table[MAX_NR_ZONES*MAX_NR_NODES];
-EXPORT_SYMBOL(zone_table);
+DEFINE_PER_NODE(struct zone *[MAX_NR_ZONES], zone_table);
+EXPORT_PER_NODE_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
 static int zone_balance_ratio[MAX_NR_ZONES] __initdata = { 128, 128, 128, };
@@ -1170,7 +1170,7 @@
 		unsigned long size, realsize;
 		unsigned long batch;
 
-		zone_table[nid * MAX_NR_ZONES + j] = zone;
+		per_node(zone_table, nid)[j] = zone;
 		realsize = size = zones_size[j];
 		if (zholes_size)
 			realsize -= zholes_size[j];
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet virgin-2.5/mm/slab.c pernode-2.5/mm/slab.c
--- virgin-2.5/mm/slab.c	Sat Mar  1 19:51:20 2003
+++ pernode-2.5/mm/slab.c	Sat Mar  1 22:23:25 2003
@@ -462,7 +462,7 @@
 	FULL
 } g_cpucache_up;
 
-static struct timer_list reap_timers[NR_CPUS];
+static DEFINE_PER_CPU(struct timer_list, reap_timers);
 
 static void reap_timer_fnc(unsigned long data);
 
@@ -516,7 +516,7 @@
  */
 static void start_cpu_timer(int cpu)
 {
-	struct timer_list *rt = &reap_timers[cpu];
+	struct timer_list *rt = &per_cpu(reap_timers, cpu);
 
 	if (rt->function == NULL) {
 		init_timer(rt);
@@ -2180,7 +2180,7 @@
 static void reap_timer_fnc(unsigned long data)
 {
 	int cpu = smp_processor_id();
-	struct timer_list *rt = &reap_timers[cpu];
+	struct timer_list *rt = &per_cpu(reap_timers, cpu);
 
 	cache_reap();
 	mod_timer(rt, jiffies + REAPTIMEOUT_CPUC + cpu);
