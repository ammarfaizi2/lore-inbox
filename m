Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVF1S4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVF1S4z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 14:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVF1S4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 14:56:54 -0400
Received: from graphe.net ([209.204.138.32]:64723 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261377AbVF1Sys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 14:54:48 -0400
Date: Tue, 28 Jun 2005 11:54:44 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: akpm@osdl.org, shai@scalex86.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] read_mostly data section
Message-ID: <Pine.LNX.4.62.0506281152060.1116@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new section called ".data.mostly_read" for data items that are
read frequently and rarely written to like cpumaps etc.

If these variables are placed in the .data section then these 
frequenly read items may end up in cachelines with data that is frequently 
updated. In that case all processors in an SMP system must needlessly 
reload the cachelines again and again.

The ability to share these cachelines will allow each cpu in an SMP
system to keep local copies of those shared cachelines thereby
optimizing performance.

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Shobhit Dayal <shobhit@calsoftinc.com>
Signed-off-by: Christoph Lameter <christoph@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.12-mm2/arch/i386/kernel/cpu/intel.c
===================================================================
--- linux-2.6.12-mm2.orig/arch/i386/kernel/cpu/intel.c	2005-06-28 10:57:00.000000000 -0700
+++ linux-2.6.12-mm2/arch/i386/kernel/cpu/intel.c	2005-06-28 11:02:49.000000000 -0700
@@ -25,7 +25,7 @@ extern int trap_init_f00f_bug(void);
 /*
  * Alignment at which movsl is preferred for bulk memory copies.
  */
-struct movsl_mask movsl_mask;
+struct movsl_mask movsl_mask __mostly_read;
 #endif
 
 void __devinit early_intel_workaround(struct cpuinfo_x86 *c)
Index: linux-2.6.12-mm2/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.12-mm2.orig/arch/i386/kernel/smpboot.c	2005-06-28 10:57:00.000000000 -0700
+++ linux-2.6.12-mm2/arch/i386/kernel/smpboot.c	2005-06-28 11:02:49.000000000 -0700
@@ -68,21 +68,21 @@ EXPORT_SYMBOL(smp_num_siblings);
 #endif
 
 /* Package ID of each logical CPU */
-int phys_proc_id[NR_CPUS] = {[0 ... NR_CPUS-1] = BAD_APICID};
+int phys_proc_id[NR_CPUS] __mostly_read = {[0 ... NR_CPUS-1] = BAD_APICID};
 EXPORT_SYMBOL(phys_proc_id);
 
 /* Core ID of each logical CPU */
-int cpu_core_id[NR_CPUS] = {[0 ... NR_CPUS-1] = BAD_APICID};
+int cpu_core_id[NR_CPUS] __mostly_read = {[0 ... NR_CPUS-1] = BAD_APICID};
 EXPORT_SYMBOL(cpu_core_id);
 
-cpumask_t cpu_sibling_map[NR_CPUS];
+cpumask_t cpu_sibling_map[NR_CPUS] __mostly_read;
 EXPORT_SYMBOL(cpu_sibling_map);
 
-cpumask_t cpu_core_map[NR_CPUS];
+cpumask_t cpu_core_map[NR_CPUS] __mostly_read;
 EXPORT_SYMBOL(cpu_core_map);
 
 /* bitmap of online cpus */
-cpumask_t cpu_online_map;
+cpumask_t cpu_online_map __mostly_read;
 EXPORT_SYMBOL(cpu_online_map);
 
 cpumask_t cpu_callin_map;
@@ -100,7 +100,7 @@ static int __devinitdata tsc_sync_disabl
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
 EXPORT_SYMBOL(cpu_data);
 
-u8 x86_cpu_to_apicid[NR_CPUS] =
+u8 x86_cpu_to_apicid[NR_CPUS] __mostly_read =
 			{ [0 ... NR_CPUS-1] = 0xff };
 EXPORT_SYMBOL(x86_cpu_to_apicid);
 
@@ -550,10 +550,10 @@ extern struct {
 #ifdef CONFIG_NUMA
 
 /* which logical CPUs are on which nodes */
-cpumask_t node_2_cpu_mask[MAX_NUMNODES] =
+cpumask_t node_2_cpu_mask[MAX_NUMNODES] __mostly_read =
 				{ [0 ... MAX_NUMNODES-1] = CPU_MASK_NONE };
 /* which node each logical CPU is on */
-int cpu_2_node[NR_CPUS] = { [0 ... NR_CPUS-1] = 0 };
+int cpu_2_node[NR_CPUS] __mostly_read = { [0 ... NR_CPUS-1] = 0 };
 EXPORT_SYMBOL(cpu_2_node);
 
 /* set up a mapping between cpu and node. */
@@ -581,7 +581,7 @@ static inline void unmap_cpu_to_node(int
 
 #endif /* CONFIG_NUMA */
 
-u8 cpu_2_logical_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
+u8 cpu_2_logical_apicid[NR_CPUS] __mostly_read = { [0 ... NR_CPUS-1] = BAD_APICID };
 
 static void map_cpu_to_logical_apicid(void)
 {
Index: linux-2.6.12-mm2/arch/i386/kernel/timers/timer_hpet.c
===================================================================
--- linux-2.6.12-mm2.orig/arch/i386/kernel/timers/timer_hpet.c	2005-06-28 10:57:00.000000000 -0700
+++ linux-2.6.12-mm2/arch/i386/kernel/timers/timer_hpet.c	2005-06-28 11:02:49.000000000 -0700
@@ -193,7 +193,7 @@ static int hpet_resume(void)
 /************************************************************/
 
 /* tsc timer_opts struct */
-static struct timer_opts timer_hpet = {
+static struct timer_opts timer_hpet __mostly_read = {
 	.name = 		"hpet",
 	.mark_offset =		mark_offset_hpet,
 	.get_offset =		get_offset_hpet,
Index: linux-2.6.12-mm2/arch/i386/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.12-mm2.orig/arch/i386/kernel/vmlinux.lds.S	2005-06-28 10:57:00.000000000 -0700
+++ linux-2.6.12-mm2/arch/i386/kernel/vmlinux.lds.S	2005-06-28 11:02:49.000000000 -0700
@@ -57,6 +57,9 @@ SECTIONS
 	*(.data.cacheline_aligned)
   }
 
+  /* rarely changed data like cpu maps */
+  . = ALIGN(32);
+  .data.mostly_read : AT(ADDR(.data.mostly_read) - LOAD_OFFSET) { *(.data.mostly_read) }
   _edata = .;			/* End of data section */
 
   . = ALIGN(THREAD_SIZE);	/* init_task */
Index: linux-2.6.12-mm2/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.12-mm2.orig/arch/x86_64/kernel/vmlinux.lds.S	2005-06-28 10:57:00.000000000 -0700
+++ linux-2.6.12-mm2/arch/x86_64/kernel/vmlinux.lds.S	2005-06-28 11:08:25.000000000 -0700
@@ -55,6 +55,8 @@ SECTIONS
   . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
   .data.cacheline_aligned : AT(ADDR(.data.cacheline_aligned) - LOAD_OFFSET) {
 	*(.data.cacheline_aligned)
+  . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
+  .data.mostly_read : { *(.data.mostly_read) }
   }
 
 #define VSYSCALL_ADDR (-10*1024*1024)
Index: linux-2.6.12-mm2/fs/bio.c
===================================================================
--- linux-2.6.12-mm2.orig/fs/bio.c	2005-06-28 10:57:00.000000000 -0700
+++ linux-2.6.12-mm2/fs/bio.c	2005-06-28 11:02:49.000000000 -0700
@@ -53,7 +53,7 @@ struct biovec_slab {
  */
 
 #define BV(x) { .nr_vecs = x, .name = "biovec-"__stringify(x) }
-static struct biovec_slab bvec_slabs[BIOVEC_NR_POOLS] = {
+static struct biovec_slab bvec_slabs[BIOVEC_NR_POOLS] __mostly_read = {
 	BV(1), BV(4), BV(16), BV(64), BV(128), BV(BIO_MAX_PAGES),
 };
 #undef BV
Index: linux-2.6.12-mm2/include/linux/cache.h
===================================================================
--- linux-2.6.12-mm2.orig/include/linux/cache.h	2005-06-28 10:57:00.000000000 -0700
+++ linux-2.6.12-mm2/include/linux/cache.h	2005-06-28 11:02:49.000000000 -0700
@@ -13,6 +13,12 @@
 #define SMP_CACHE_BYTES L1_CACHE_BYTES
 #endif
 
+#ifdef CONFIG_X86
+#define __mostly_read __attribute__((__section__(".data.mostly_read")))
+#else
+#define __mostly_read
+#endif
+
 #ifndef ____cacheline_aligned
 #define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
 #endif
Index: linux-2.6.12-mm2/kernel/profile.c
===================================================================
--- linux-2.6.12-mm2.orig/kernel/profile.c	2005-06-28 10:57:00.000000000 -0700
+++ linux-2.6.12-mm2/kernel/profile.c	2005-06-28 11:24:11.000000000 -0700
@@ -35,11 +35,11 @@ struct profile_hit {
 #define NR_PROFILE_GRP		(NR_PROFILE_HIT/PROFILE_GRPSZ)
 
 /* Oprofile timer tick hook */
-int (*timer_hook)(struct pt_regs *);
+int (*timer_hook)(struct pt_regs *) __mostly_read;
 
 static atomic_t *prof_buffer;
 static unsigned long prof_len, prof_shift;
-static int prof_on;
+static int prof_on __mostly_read;
 static cpumask_t prof_cpu_mask = CPU_MASK_ALL;
 #ifdef CONFIG_SMP
 static DEFINE_PER_CPU(struct profile_hit *[2], cpu_profile_hits);
Index: linux-2.6.12-mm2/lib/radix-tree.c
===================================================================
--- linux-2.6.12-mm2.orig/lib/radix-tree.c	2005-06-28 10:57:00.000000000 -0700
+++ linux-2.6.12-mm2/lib/radix-tree.c	2005-06-28 11:02:49.000000000 -0700
@@ -58,7 +58,7 @@ struct radix_tree_path {
 #define RADIX_TREE_INDEX_BITS  (8 /* CHAR_BIT */ * sizeof(unsigned long))
 #define RADIX_TREE_MAX_PATH (RADIX_TREE_INDEX_BITS/RADIX_TREE_MAP_SHIFT + 2)
 
-static unsigned long height_to_maxindex[RADIX_TREE_MAX_PATH];
+static unsigned long height_to_maxindex[RADIX_TREE_MAX_PATH] __mostly_read;
 
 /*
  * Radix tree node cache.
