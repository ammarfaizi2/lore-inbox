Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268520AbTCAHag>; Sat, 1 Mar 2003 02:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268521AbTCAHag>; Sat, 1 Mar 2003 02:30:36 -0500
Received: from holomorphy.com ([66.224.33.161]:31369 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268520AbTCAHac>;
	Sat, 1 Mar 2003 02:30:32 -0500
Date: Fri, 28 Feb 2003 23:40:35 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: percpu-2.5.63-bkcurr
Message-ID: <20030301074035.GB1195@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030301055922.GB1399@holomorphy.com> <20030301073655.GA1195@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030301073655.GA1195@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 09:59:22PM -0800, William Lee Irwin III wrote:
>> Shove per-cpu areas into node-local memory for i386 discontigmem,
>> or at least NUMA-Q. You'll have to plop down early_cpu_to_node()
>> and early_node_to_cpumask() stubs to use it on, say Summit.

On Fri, Feb 28, 2003 at 11:36:55PM -0800, William Lee Irwin III wrote:
> Tentative followup #1 (thanks Zwane!)
> Use per-cpu rq's in the sched.c to avoid remote cache misses there.
> It actually means something now.

Tentative followup #2 -- totally untested, at some point I have to
figure out how to avoid breaking the compile for non-NUMA-Q with this.


diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/i386/mm/discontig.c sched-2.5/arch/i386/mm/discontig.c
--- linux-2.5/arch/i386/mm/discontig.c	Fri Feb 28 21:48:54 2003
+++ sched-2.5/arch/i386/mm/discontig.c	Fri Feb 28 23:12:45 2003
@@ -66,10 +66,12 @@
 }
 
 extern char __per_cpu_start[], __per_cpu_end[];
-unsigned long __per_cpu_offset[NR_CPUS];
+extern char __per_node_start[], __per_node_end[];
+unsigned long __per_cpu_offset[NR_CPUS], __per_node_offset[MAX_NR_NODES];
 
 #define PER_CPU_PAGES	PFN_UP((unsigned long)(__per_cpu_end-__per_cpu_start))
 #define MEM_MAP_SIZE(n)	PFN_UP((node_end_pfn[n]-node_start_pfn[n]+1)*sizeof(struct page))
+#define PER_NODE_PAGES	PFN_UP((unsigned long)(__per_node_end-__per_node_start))
 
 #ifdef CONFIG_X86_NUMAQ
 #define early_cpu_to_node(cpu)		((cpu)/4)
@@ -94,6 +96,26 @@
 	}
 }
 
+static void __init allocate_per_node_area(int node)
+{
+	unsigned long node_vaddr = (unsigned long)node_remap_start_vaddr[node];
+
+	if (!PER_CPU_PAGES)
+		return;
+
+	if (!node) {
+		__per_node_offset[node] = min_low_pfn*PAGE_SIZE
+					+ PAGE_OFFSET
+					- (unsigned long)__per_node_start;
+		min_low_pfn += PER_NODE_PAGES;
+		return;
+	}
+
+	__per_node_offset[node] = node_vaddr + MEM_MAP_SIZE(node)*PAGE_SIZE
+					+ PFN_UP(sizeof(pg_data_t))*PAGE_SIZE
+					- (unsigned long)__per_node_start;
+}
+
 static void __init allocate_one_cpu_area(int cpu)
 {
 	int cpu_in_node, node = early_cpu_to_node(cpu);
@@ -115,9 +137,21 @@
 	__per_cpu_offset[cpu] = node_vaddr + MEM_MAP_SIZE(node)*PAGE_SIZE
 					+ PFN_UP(sizeof(pg_data_t))*PAGE_SIZE
 					+ PER_CPU_PAGES*cpu_in_node*PAGE_SIZE
+					+ PER_NODE_PAGES*PAGE_SIZE
 					- (unsigned long)__per_cpu_start;
 }
 
+void __init setup_per_node_areas(void)
+{
+	int node;
+	for (node = 0; node < numnodes; ++node) {
+		memcpy(RELOC_HIDE((char *)__per_node_start,
+						__per_node_offset[node]),
+				__per_node_start,
+				PER_NODE_PAGES*PAGE_SIZE);
+	}
+}
+
 void __init setup_per_cpu_areas(void)
 {
 	int node, cpu;
@@ -248,6 +282,7 @@
 		node_remap_start_vaddr[nid] = pfn_to_kaddr(
 			highstart_pfn - node_remap_offset[nid]);
 		allocate_pgdat(nid);
+		allocate_per_node_area(nid);
 		for (cpu = 0; cpu < NR_CPUS; ++cpu) {
 			if (early_cpu_to_node(cpu) == nid)
 				allocate_one_cpu_area(cpu);
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/arch/i386/vmlinux.lds.S sched-2.5/arch/i386/vmlinux.lds.S
--- linux-2.5/arch/i386/vmlinux.lds.S	Fri Feb 28 18:32:34 2003
+++ sched-2.5/arch/i386/vmlinux.lds.S	Fri Feb 28 23:02:36 2003
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
 	
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/include/asm-i386/pernode.h sched-2.5/include/asm-i386/pernode.h
--- linux-2.5/include/asm-i386/pernode.h	Wed Dec 31 16:00:00 1969
+++ sched-2.5/include/asm-i386/pernode.h	Fri Feb 28 23:08:53 2003
@@ -0,0 +1,29 @@
+#ifndef __ARCH_I386_PERNODE__
+#define __ARCH_I386_PERNODE__
+
+#include <linux/config.h>
+#include <linux/compiler.h>
+
+#ifndef CONFIG_DISCONTIGMEM
+#include <asm-generic/percpu.h>
+#else /* CONFIG_DISCONTIGMEM */
+
+extern unsigned long __per_node_offset[NR_CPUS];
+void setup_per_node_areas(void);
+
+/* Separate out the type, so (int[3], foo) works. */
+#ifndef MODULE
+#define DEFINE_PER_NODE(type, name) \
+    __attribute__((__section__(".data.pernode"))) __typeof__(type) name##__per_node
+#endif
+
+/* var is in discarded region: offset to particular copy we want */
+#define per_node(var, node) (*RELOC_HIDE(&var##__per_node, __per_node_offset[node]))
+
+#define DECLARE_PER_NODE(type, name) extern __typeof__(type) name##__per_node
+#define EXPORT_PER_NODE_SYMBOL(var) EXPORT_SYMBOL(var##__per_node)
+#define EXPORT_PER_NODE_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(var##__per_node)
+
+#endif /* CONFIG_DISCONTIGMEM */
+
+#endif /* __ARCH_I386_PERNODE__ */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/init/main.c sched-2.5/init/main.c
--- linux-2.5/init/main.c	Fri Feb 28 21:49:13 2003
+++ sched-2.5/init/main.c	Fri Feb 28 23:10:12 2003
@@ -38,6 +38,7 @@
 
 #include <asm/io.h>
 #include <asm/bugs.h>
+#include <asm/pernode.h>
 
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/smp.h>
@@ -317,6 +318,10 @@
 }
 #endif /* !__GENERIC_PER_CPU */
 
+#ifndef CONFIG_NUMA
+static inline void setup_per_node_areas(void) { }
+#endif
+
 /* Called by boot processor to activate the rest. */
 static void __init smp_init(void)
 {
@@ -376,6 +381,7 @@
 	printk(linux_banner);
 	setup_arch(&command_line);
 	setup_per_cpu_areas();
+	setup_per_node_areas();
 
 	/*
 	 * Mark the boot cpu "online" so that it can call console drivers in
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/kernel/sched.c sched-2.5/kernel/sched.c
--- linux-2.5/kernel/sched.c	Fri Feb 28 18:33:00 2003
+++ sched-2.5/kernel/sched.c	Fri Feb 28 23:17:19 2003
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
