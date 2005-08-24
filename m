Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbVHXVpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbVHXVpu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbVHXVpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:45:50 -0400
Received: from serv01.siteground.net ([70.85.91.68]:28379 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932291AbVHXVpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:45:49 -0400
Date: Wed, 24 Aug 2005 14:46:11 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
Subject: [patch] Additions to .data.read_mostly section
Message-ID: <20050824214610.GA3675@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patch moves a few static 'read mostly' variables to the 
.data.read_mostly section.  Typically these are vector - irq tables,
boot_cpu_data, node_maps etc., which are initialized once and read from 
often and rarely written to.  Please include.

Thanks,
Kiran


Patch to mark variables which are usually accessed for reads with __readmostly.

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Shai Fultheim <shai@scalex86.org>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.13-rc6/arch/i386/kernel/io_apic.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/i386/kernel/io_apic.c	2005-08-23 15:05:49.000000000 -0700
+++ linux-2.6.13-rc6/arch/i386/kernel/io_apic.c	2005-08-23 15:09:22.000000000 -0700
@@ -77,7 +77,7 @@
 	int apic, pin, next;
 } irq_2_pin[PIN_MAP_SIZE];
 
-int vector_irq[NR_VECTORS] = { [0 ... NR_VECTORS - 1] = -1};
+int vector_irq[NR_VECTORS] __read_mostly = { [0 ... NR_VECTORS - 1] = -1};
 #ifdef CONFIG_PCI_MSI
 #define vector_to_irq(vector) 	\
 	(platform_legacy_irq(vector) ? vector : vector_irq[vector])
@@ -1127,7 +1127,7 @@
 }
 
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
-u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
+u8 irq_vector[NR_IRQ_VECTORS] __read_mostly = { FIRST_DEVICE_VECTOR , 0 };
 
 int assign_irq_vector(int irq)
 {
@@ -1992,7 +1992,7 @@
  * edge-triggered handler, without risking IRQ storms and other ugly
  * races.
  */
-static struct hw_interrupt_type ioapic_edge_type = {
+static struct hw_interrupt_type ioapic_edge_type __read_mostly = {
 	.typename 	= "IO-APIC-edge",
 	.startup 	= startup_edge_ioapic,
 	.shutdown 	= shutdown_edge_ioapic,
@@ -2003,7 +2003,7 @@
 	.set_affinity 	= set_ioapic_affinity,
 };
 
-static struct hw_interrupt_type ioapic_level_type = {
+static struct hw_interrupt_type ioapic_level_type __read_mostly = {
 	.typename 	= "IO-APIC-level",
 	.startup 	= startup_level_ioapic,
 	.shutdown 	= shutdown_level_ioapic,
@@ -2074,7 +2074,7 @@
 
 static void end_lapic_irq (unsigned int i) { /* nothing */ }
 
-static struct hw_interrupt_type lapic_irq_type = {
+static struct hw_interrupt_type lapic_irq_type __read_mostly = {
 	.typename 	= "local-APIC-edge",
 	.startup 	= NULL, /* startup_irq() not used for IRQ0 */
 	.shutdown 	= NULL, /* shutdown_irq() not used for IRQ0 */
Index: linux-2.6.13-rc6/arch/i386/kernel/setup.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/i386/kernel/setup.c	2005-08-23 15:05:49.000000000 -0700
+++ linux-2.6.13-rc6/arch/i386/kernel/setup.c	2005-08-23 15:09:22.000000000 -0700
@@ -82,7 +82,7 @@
 /* cpu data as detected by the assembly code in head.S */
 struct cpuinfo_x86 new_cpu_data __initdata = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
 /* common cpu data for all cpus */
-struct cpuinfo_x86 boot_cpu_data = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
+struct cpuinfo_x86 boot_cpu_data __read_mostly = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
 EXPORT_SYMBOL(boot_cpu_data);
 
 unsigned long mmu_cr4_features;
Index: linux-2.6.13-rc6/arch/i386/kernel/timers/timer_hpet.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/i386/kernel/timers/timer_hpet.c	2005-08-23 15:05:49.000000000 -0700
+++ linux-2.6.13-rc6/arch/i386/kernel/timers/timer_hpet.c	2005-08-23 15:09:22.000000000 -0700
@@ -18,8 +18,8 @@
 #include "mach_timer.h"
 #include <asm/hpet.h>
 
-static unsigned long __read_mostly hpet_usec_quotient;	/* convert hpet clks to usec */
-static unsigned long tsc_hpet_quotient;		/* convert tsc to hpet clks */
+static unsigned long hpet_usec_quotient __read_mostly;	/* convert hpet clks to usec */
+static unsigned long tsc_hpet_quotient __read_mostly;		/* convert tsc to hpet clks */
 static unsigned long hpet_last; 	/* hpet counter value at last tick*/
 static unsigned long last_tsc_low;	/* lsb 32 bits of Time Stamp Counter */
 static unsigned long last_tsc_high; 	/* msb 32 bits of Time Stamp Counter */
Index: linux-2.6.13-rc6/arch/i386/mm/discontig.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/i386/mm/discontig.c	2005-08-23 15:05:49.000000000 -0700
+++ linux-2.6.13-rc6/arch/i386/mm/discontig.c	2005-08-23 15:09:22.000000000 -0700
@@ -37,7 +37,7 @@
 #include <asm/mmzone.h>
 #include <bios_ebda.h>
 
-struct pglist_data *node_data[MAX_NUMNODES];
+struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
 EXPORT_SYMBOL(node_data);
 bootmem_data_t node0_bdata;
 
@@ -49,8 +49,8 @@
  * 2) node_start_pfn   - the starting page frame number for a node
  * 3) node_end_pfn     - the ending page fram number for a node
  */
-unsigned long node_start_pfn[MAX_NUMNODES];
-unsigned long node_end_pfn[MAX_NUMNODES];
+unsigned long node_start_pfn[MAX_NUMNODES] __read_mostly;
+unsigned long node_end_pfn[MAX_NUMNODES] __read_mostly;
 
 
 #ifdef CONFIG_DISCONTIGMEM
@@ -66,7 +66,7 @@
  *     physnode_map[4-7] = 1;
  *     physnode_map[8- ] = -1;
  */
-s8 physnode_map[MAX_ELEMENTS] = { [0 ... (MAX_ELEMENTS - 1)] = -1};
+s8 physnode_map[MAX_ELEMENTS] __read_mostly = { [0 ... (MAX_ELEMENTS - 1)] = -1};
 EXPORT_SYMBOL(physnode_map);
 
 void memory_present(int nid, unsigned long start, unsigned long end)
Index: linux-2.6.13-rc6/arch/i386/mm/init.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/i386/mm/init.c	2005-08-23 15:09:22.000000000 -0700
+++ linux-2.6.13-rc6/arch/i386/mm/init.c	2005-08-23 15:09:22.000000000 -0700
@@ -390,7 +390,7 @@
 }
 
 static int disable_nx __initdata = 0;
-u64 __supported_pte_mask = ~_PAGE_NX;
+u64 __supported_pte_mask __read_mostly = ~_PAGE_NX;
 
 /*
  * noexec = on|off
Index: linux-2.6.13-rc6/arch/x86_64/kernel/genapic.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/x86_64/kernel/genapic.c	2005-08-23 12:09:44.000000000 -0700
+++ linux-2.6.13-rc6/arch/x86_64/kernel/genapic.c	2005-08-24 09:55:38.000000000 -0700
@@ -25,7 +25,7 @@
 #endif
 
 /* which logical CPU number maps to which CPU (physical APIC ID) */
-u8 x86_cpu_to_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
+u8 x86_cpu_to_apicid[NR_CPUS] __read_mostly = { [0 ... NR_CPUS-1] = BAD_APICID };
 EXPORT_SYMBOL(x86_cpu_to_apicid);
 u8 x86_cpu_to_log_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 
Index: linux-2.6.13-rc6/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/x86_64/kernel/io_apic.c	2005-08-23 15:05:49.000000000 -0700
+++ linux-2.6.13-rc6/arch/x86_64/kernel/io_apic.c	2005-08-23 15:09:22.000000000 -0700
@@ -70,7 +70,7 @@
 	short apic, pin, next;
 } irq_2_pin[PIN_MAP_SIZE];
 
-int vector_irq[NR_VECTORS] = { [0 ... NR_VECTORS - 1] = -1};
+int vector_irq[NR_VECTORS] __read_mostly = { [0 ... NR_VECTORS - 1] = -1};
 #ifdef CONFIG_PCI_MSI
 #define vector_to_irq(vector) 	\
 	(platform_legacy_irq(vector) ? vector : vector_irq[vector])
@@ -655,7 +655,7 @@
 }
 
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
-u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
+u8 irq_vector[NR_IRQ_VECTORS] __read_mostly = { FIRST_DEVICE_VECTOR , 0 };
 
 int assign_irq_vector(int irq)
 {
@@ -1424,7 +1424,7 @@
  * races.
  */
 
-static struct hw_interrupt_type ioapic_edge_type = {
+static struct hw_interrupt_type ioapic_edge_type __read_mostly = {
 	.typename = "IO-APIC-edge",
 	.startup 	= startup_edge_ioapic,
 	.shutdown 	= shutdown_edge_ioapic,
@@ -1435,7 +1435,7 @@
 	.set_affinity = set_ioapic_affinity,
 };
 
-static struct hw_interrupt_type ioapic_level_type = {
+static struct hw_interrupt_type ioapic_level_type __read_mostly = {
 	.typename = "IO-APIC-level",
 	.startup 	= startup_level_ioapic,
 	.shutdown 	= shutdown_level_ioapic,
@@ -1506,7 +1506,7 @@
 
 static void end_lapic_irq (unsigned int i) { /* nothing */ }
 
-static struct hw_interrupt_type lapic_irq_type = {
+static struct hw_interrupt_type lapic_irq_type __read_mostly = {
 	.typename = "local-APIC-edge",
 	.startup = NULL, /* startup_irq() not used for IRQ0 */
 	.shutdown = NULL, /* shutdown_irq() not used for IRQ0 */
Index: linux-2.6.13-rc6/arch/x86_64/kernel/setup.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/x86_64/kernel/setup.c	2005-08-23 15:05:49.000000000 -0700
+++ linux-2.6.13-rc6/arch/x86_64/kernel/setup.c	2005-08-23 15:09:22.000000000 -0700
@@ -65,7 +65,7 @@
  * Machine setup..
  */
 
-struct cpuinfo_x86 boot_cpu_data;
+struct cpuinfo_x86 boot_cpu_data __read_mostly;
 
 unsigned long mmu_cr4_features;
 
Index: linux-2.6.13-rc6/arch/x86_64/kernel/setup64.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/x86_64/kernel/setup64.c	2005-08-23 15:05:49.000000000 -0700
+++ linux-2.6.13-rc6/arch/x86_64/kernel/setup64.c	2005-08-23 15:09:22.000000000 -0700
@@ -36,7 +36,7 @@
 
 char boot_cpu_stack[IRQSTACKSIZE] __attribute__((section(".bss.page_aligned")));
 
-unsigned long __supported_pte_mask = ~0UL;
+unsigned long __supported_pte_mask __read_mostly = ~0UL;
 static int do_not_nx __initdata = 0;
 
 /* noexec=on|off
Index: linux-2.6.13-rc6/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/x86_64/kernel/smpboot.c	2005-08-23 12:10:04.000000000 -0700
+++ linux-2.6.13-rc6/arch/x86_64/kernel/smpboot.c	2005-08-24 09:55:38.000000000 -0700
@@ -62,13 +62,13 @@
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
 /* Package ID of each logical CPU */
-u8 phys_proc_id[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
-u8 cpu_core_id[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
+u8 phys_proc_id[NR_CPUS] __read_mostly = { [0 ... NR_CPUS-1] = BAD_APICID };
+u8 cpu_core_id[NR_CPUS] __read_mostly = { [0 ... NR_CPUS-1] = BAD_APICID };
 EXPORT_SYMBOL(phys_proc_id);
 EXPORT_SYMBOL(cpu_core_id);
 
 /* Bitmask of currently online CPUs */
-cpumask_t cpu_online_map;
+cpumask_t cpu_online_map __read_mostly;
 
 EXPORT_SYMBOL(cpu_online_map);
 
@@ -88,8 +88,8 @@
 /* Set when the idlers are all forked */
 int smp_threads_ready;
 
-cpumask_t cpu_sibling_map[NR_CPUS] __cacheline_aligned;
-cpumask_t cpu_core_map[NR_CPUS] __cacheline_aligned;
+cpumask_t cpu_sibling_map[NR_CPUS] __read_mostly;
+cpumask_t cpu_core_map[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(cpu_core_map);
 
 /*
Index: linux-2.6.13-rc6/arch/x86_64/mm/numa.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/x86_64/mm/numa.c	2005-08-23 12:09:44.000000000 -0700
+++ linux-2.6.13-rc6/arch/x86_64/mm/numa.c	2005-08-24 09:55:38.000000000 -0700
@@ -22,14 +22,14 @@
 #define Dprintk(x...)
 #endif
 
-struct pglist_data *node_data[MAX_NUMNODES];
+struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
 bootmem_data_t plat_node_bdata[MAX_NUMNODES];
 
 int memnode_shift;
 u8  memnodemap[NODEMAPSIZE];
 
-unsigned char cpu_to_node[NR_CPUS] = { [0 ... NR_CPUS-1] = NUMA_NO_NODE };
-cpumask_t     node_to_cpumask[MAX_NUMNODES];
+unsigned char cpu_to_node[NR_CPUS] __read_mostly = { [0 ... NR_CPUS-1] = NUMA_NO_NODE };
+cpumask_t     node_to_cpumask[MAX_NUMNODES] __read_mostly;
 
 int numa_off __initdata;
 
Index: linux-2.6.13-rc6/fs/namespace.c
===================================================================
--- linux-2.6.13-rc6.orig/fs/namespace.c	2005-08-23 15:05:49.000000000 -0700
+++ linux-2.6.13-rc6/fs/namespace.c	2005-08-23 15:09:22.000000000 -0700
@@ -40,7 +40,7 @@
  __cacheline_aligned_in_smp DEFINE_SPINLOCK(vfsmount_lock);
 
 static struct list_head *mount_hashtable;
-static int hash_mask, hash_bits;
+static int hash_mask __read_mostly, hash_bits __read_mostly;
 static kmem_cache_t *mnt_cache; 
 
 static inline unsigned long hash(struct vfsmount *mnt, struct dentry *dentry)
Index: linux-2.6.13-rc6/mm/mempolicy.c
===================================================================
--- linux-2.6.13-rc6.orig/mm/mempolicy.c	2005-08-23 15:05:49.000000000 -0700
+++ linux-2.6.13-rc6/mm/mempolicy.c	2005-08-23 15:09:22.000000000 -0700
@@ -88,7 +88,7 @@
    policied. */
 static int policy_zone;
 
-static struct mempolicy default_policy = {
+static struct mempolicy default_policy __read_mostly = {
 	.refcnt = ATOMIC_INIT(1), /* never free it */
 	.policy = MPOL_DEFAULT,
 };
Index: linux-2.6.13-rc6/mm/mmap.c
===================================================================
--- linux-2.6.13-rc6.orig/mm/mmap.c	2005-08-23 15:05:49.000000000 -0700
+++ linux-2.6.13-rc6/mm/mmap.c	2005-08-23 15:09:22.000000000 -0700
@@ -61,7 +61,7 @@
 
 int sysctl_overcommit_memory = OVERCOMMIT_GUESS;  /* heuristic overcommit */
 int sysctl_overcommit_ratio = 50;	/* default is 50% */
-int sysctl_max_map_count = DEFAULT_MAX_MAP_COUNT;
+int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
 atomic_t vm_committed_space = ATOMIC_INIT(0);
 
 /*
Index: linux-2.6.13-rc6/mm/page_alloc.c
===================================================================
--- linux-2.6.13-rc6.orig/mm/page_alloc.c	2005-08-23 15:05:49.000000000 -0700
+++ linux-2.6.13-rc6/mm/page_alloc.c	2005-08-23 15:09:22.000000000 -0700
@@ -42,13 +42,13 @@
  * MCD - HACK: Find somewhere to initialize this EARLY, or make this
  * initializer cleaner
  */
-nodemask_t node_online_map = { { [0] = 1UL } };
+nodemask_t node_online_map __read_mostly = { { [0] = 1UL } };
 EXPORT_SYMBOL(node_online_map);
-nodemask_t node_possible_map = NODE_MASK_ALL;
+nodemask_t node_possible_map __read_mostly = NODE_MASK_ALL;
 EXPORT_SYMBOL(node_possible_map);
-struct pglist_data *pgdat_list;
-unsigned long totalram_pages;
-unsigned long totalhigh_pages;
+struct pglist_data *pgdat_list __read_mostly;
+unsigned long totalram_pages __read_mostly;
+unsigned long totalhigh_pages __read_mostly;
 long nr_swap_pages;
 
 /*
@@ -68,7 +68,7 @@
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
  */
-struct zone *zone_table[1 << ZONETABLE_SHIFT];
+struct zone *zone_table[1 << ZONETABLE_SHIFT] __read_mostly;
 EXPORT_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
Index: linux-2.6.13-rc6/mm/shmem.c
===================================================================
--- linux-2.6.13-rc6.orig/mm/shmem.c	2005-08-23 15:05:49.000000000 -0700
+++ linux-2.6.13-rc6/mm/shmem.c	2005-08-23 15:09:22.000000000 -0700
@@ -182,7 +182,7 @@
 static struct inode_operations shmem_special_inode_operations;
 static struct vm_operations_struct shmem_vm_ops;
 
-static struct backing_dev_info shmem_backing_dev_info = {
+static struct backing_dev_info shmem_backing_dev_info  __read_mostly = {
 	.ra_pages	= 0,	/* No readahead */
 	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK,
 	.unplug_io_fn	= default_unplug_io_fn,
