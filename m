Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVEDUgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVEDUgx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 16:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVEDUgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 16:36:42 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:60645
	"EHLO pinky.shadowen.org") by vger.kernel.org with ESMTP
	id S261559AbVEDUbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 16:31:05 -0400
To: linuxppc64-dev@ozlabs.org, paulus@samba.org, anton@samba.org
Subject: [3/3] sparsemem memory model for ppc64
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, apw@shadowen.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com
Message-Id: <E1DTQWH-0002We-I9@pinky.shadowen.org>
From: Andy Whitcroft <apw@shadowen.org>
Date: Wed, 04 May 2005 21:30:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the architecture specific implementation for SPARSEMEM for
PPC64 systems.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Mike Kravetz <kravetz@us.ibm.com> (in part)
Signed-off-by: Martin Bligh <mbligh@aracnet.com>
---
 arch/ppc64/Kconfig            |   13 ++++++++++++-
 arch/ppc64/kernel/setup.c     |    1 +
 arch/ppc64/mm/Makefile        |    2 +-
 arch/ppc64/mm/init.c          |   24 +++++++++++++++++++-----
 include/asm-ppc64/mmzone.h    |   36 +++++++++++++++++++++++-------------
 include/asm-ppc64/page.h      |    3 ++-
 include/asm-ppc64/sparsemem.h |   16 ++++++++++++++++
 7 files changed, 74 insertions(+), 21 deletions(-)

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/ppc64/Kconfig current/arch/ppc64/Kconfig
--- reference/arch/ppc64/Kconfig	2005-05-04 20:54:52.000000000 +0100
+++ current/arch/ppc64/Kconfig	2005-05-04 20:54:54.000000000 +0100
@@ -198,6 +198,13 @@ config HMT
 	  This option enables hardware multithreading on RS64 cpus.
 	  pSeries systems p620 and p660 have such a cpu type.
 
+config ARCH_SELECT_MEMORY_MODEL
+	def_bool y
+
+config ARCH_FLATMEM_ENABLE
+       def_bool y
+       depends on !NUMA
+
 config ARCH_DISCONTIGMEM_ENABLE
 	def_bool y
 	depends on SMP && PPC_PSERIES
@@ -209,6 +216,10 @@ config ARCH_DISCONTIGMEM_DEFAULT
 config ARCH_FLATMEM_ENABLE
 	def_bool y
 
+config ARCH_SPARSEMEM_ENABLE
+	def_bool y
+	depends on ARCH_DISCONTIGMEM_ENABLE
+
 source "mm/Kconfig"
 
 config HAVE_ARCH_EARLY_PFN_TO_NID
@@ -229,7 +240,7 @@ config NODES_SPAN_OTHER_NODES
 
 config NUMA
 	bool "NUMA support"
-	depends on DISCONTIGMEM
+	default y if DISCONTIGMEM || SPARSEMEM
 
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/ppc64/kernel/setup.c current/arch/ppc64/kernel/setup.c
--- reference/arch/ppc64/kernel/setup.c	2005-04-11 19:33:15.000000000 +0100
+++ current/arch/ppc64/kernel/setup.c	2005-05-04 20:54:53.000000000 +0100
@@ -1059,6 +1059,7 @@ void __init setup_arch(char **cmdline_p)
 
 	/* set up the bootmem stuff with available memory */
 	do_init_bootmem();
+	sparse_init();
 
 	/* initialize the syscall map in systemcfg */
 	setup_syscall_map();
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/ppc64/mm/init.c current/arch/ppc64/mm/init.c
--- reference/arch/ppc64/mm/init.c	2005-05-04 20:54:20.000000000 +0100
+++ current/arch/ppc64/mm/init.c	2005-05-04 20:54:54.000000000 +0100
@@ -601,13 +601,21 @@ EXPORT_SYMBOL(page_is_ram);
  * Initialize the bootmem system and give it all the memory we
  * have available.
  */
-#ifndef CONFIG_DISCONTIGMEM
+#ifndef CONFIG_NEED_MULTIPLE_NODES
 void __init do_init_bootmem(void)
 {
 	unsigned long i;
 	unsigned long start, bootmap_pages;
 	unsigned long total_pages = lmb_end_of_DRAM() >> PAGE_SHIFT;
 	int boot_mapsize;
+	unsigned long start_pfn, end_pfn;
+	/*
+	 * Note presence of first (logical/coalasced) LMB which will
+	 * contain RMO region
+	 */
+	start_pfn = lmb.memory.region[0].physbase >> PAGE_SHIFT;
+	end_pfn = start_pfn + (lmb.memory.region[0].size >> PAGE_SHIFT);
+	memory_present(0, start_pfn, end_pfn);
 
 	/*
 	 * Find an area to use for the bootmem bitmap.  Calculate the size of
@@ -623,12 +631,18 @@ void __init do_init_bootmem(void)
 
 	max_pfn = max_low_pfn;
 
-	/* add all physical memory to the bootmem map. Also find the first */
+	/* add all physical memory to the bootmem map. Also, find the first
+	 * presence of all LMBs*/
 	for (i=0; i < lmb.memory.cnt; i++) {
 		unsigned long physbase, size;
 
 		physbase = lmb.memory.region[i].physbase;
 		size = lmb.memory.region[i].size;
+		if (i) { /* already created mappings for first LMB */
+			start_pfn = physbase >> PAGE_SHIFT;
+			end_pfn = start_pfn + (size >> PAGE_SHIFT);
+		}
+		memory_present(0, start_pfn, end_pfn);
 		free_bootmem(physbase, size);
 	}
 
@@ -667,7 +681,7 @@ void __init paging_init(void)
 	free_area_init_node(0, &contig_page_data, zones_size,
 			    __pa(PAGE_OFFSET) >> PAGE_SHIFT, zholes_size);
 }
-#endif /* CONFIG_DISCONTIGMEM */
+#endif /* ! CONFIG_NEED_MULTIPLE_NODES */
 
 static struct kcore_list kcore_vmem;
 
@@ -698,7 +712,7 @@ module_init(setup_kcore);
 
 void __init mem_init(void)
 {
-#ifdef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_NEED_MULTIPLE_NODES
 	int nid;
 #endif
 	pg_data_t *pgdat;
@@ -709,7 +723,7 @@ void __init mem_init(void)
 	num_physpages = max_low_pfn;	/* RAM is assumed contiguous */
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 
-#ifdef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_NEED_MULTIPLE_NODES
         for_each_online_node(nid) {
 		if (NODE_DATA(nid)->node_spanned_pages != 0) {
 			printk("freeing bootmem node %x\n", nid);
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/arch/ppc64/mm/Makefile current/arch/ppc64/mm/Makefile
--- reference/arch/ppc64/mm/Makefile	2005-01-21 14:04:09.000000000 +0000
+++ current/arch/ppc64/mm/Makefile	2005-05-04 20:54:54.000000000 +0100
@@ -6,6 +6,6 @@ EXTRA_CFLAGS += -mno-minimal-toc
 
 obj-y := fault.o init.o imalloc.o hash_utils.o hash_low.o tlb.o \
 	slb_low.o slb.o stab.o mmap.o
-obj-$(CONFIG_DISCONTIGMEM) += numa.o
+obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_PPC_MULTIPLATFORM) += hash_native.o
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/include/asm-ppc64/mmzone.h current/include/asm-ppc64/mmzone.h
--- reference/include/asm-ppc64/mmzone.h	2005-05-04 20:54:50.000000000 +0100
+++ current/include/asm-ppc64/mmzone.h	2005-05-04 20:54:54.000000000 +0100
@@ -10,9 +10,20 @@
 #include <linux/config.h>
 #include <asm/smp.h>
 
-#ifdef CONFIG_DISCONTIGMEM
+/* generic non-linear memory support:
+ *
+ * 1) we will not split memory into more chunks than will fit into the
+ *    flags field of the struct page
+ */
+
+
+#ifdef CONFIG_NEED_MULTIPLE_NODES
 
 extern struct pglist_data *node_data[];
+/*
+ * Return a pointer to the node data for node n.
+ */
+#define NODE_DATA(nid)		(node_data[nid])
 
 /*
  * Following are specific to this numa platform.
@@ -47,30 +58,27 @@ static inline int pa_to_nid(unsigned lon
 	return nid;
 }
 
-#define pfn_to_nid(pfn)		pa_to_nid((pfn) << PAGE_SHIFT)
-
-/*
- * Return a pointer to the node data for node n.
- */
-#define NODE_DATA(nid)		(node_data[nid])
-
 #define node_localnr(pfn, nid)	((pfn) - NODE_DATA(nid)->node_start_pfn)
 
 /*
  * Following are macros that each numa implmentation must define.
  */
 
-/*
- * Given a kernel address, find the home node of the underlying memory.
- */
-#define kvaddr_to_nid(kaddr)	pa_to_nid(__pa(kaddr))
-
 #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
 #define node_end_pfn(nid)	(NODE_DATA(nid)->node_end_pfn)
 
 #define local_mapnr(kvaddr) \
 	( (__pa(kvaddr) >> PAGE_SHIFT) - node_start_pfn(kvaddr_to_nid(kvaddr)) 
 
+#ifdef CONFIG_DISCONTIGMEM
+
+/*
+ * Given a kernel address, find the home node of the underlying memory.
+ */
+#define kvaddr_to_nid(kaddr)	pa_to_nid(__pa(kaddr))
+
+#define pfn_to_nid(pfn)		pa_to_nid((unsigned long)(pfn) << PAGE_SHIFT)
+
 /* Written this way to avoid evaluating arguments twice */
 #define discontigmem_pfn_to_page(pfn) \
 ({ \
@@ -91,6 +99,8 @@ static inline int pa_to_nid(unsigned lon
 
 #endif /* CONFIG_DISCONTIGMEM */
 
+#endif /* CONFIG_NEED_MULTIPLE_NODES */
+
 #ifdef CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID
 #define early_pfn_to_nid(pfn)  pa_to_nid(((unsigned long)pfn) << PAGE_SHIFT)
 #endif
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/include/asm-ppc64/page.h current/include/asm-ppc64/page.h
--- reference/include/asm-ppc64/page.h	2005-04-11 19:33:45.000000000 +0100
+++ current/include/asm-ppc64/page.h	2005-05-04 20:54:54.000000000 +0100
@@ -224,7 +224,8 @@ extern u64 ppc64_pft_size;		/* Log 2 of 
 #define page_to_pfn(page)	discontigmem_page_to_pfn(page)
 #define pfn_to_page(pfn)	discontigmem_pfn_to_page(pfn)
 #define pfn_valid(pfn)		discontigmem_pfn_valid(pfn)
-#else
+#endif
+#ifdef CONFIG_FLATMEM
 #define pfn_to_page(pfn)	(mem_map + (pfn))
 #define page_to_pfn(page)	((unsigned long)((page) - mem_map))
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/include/asm-ppc64/sparsemem.h current/include/asm-ppc64/sparsemem.h
--- reference/include/asm-ppc64/sparsemem.h	1970-01-01 01:00:00.000000000 +0100
+++ current/include/asm-ppc64/sparsemem.h	2005-05-04 20:54:54.000000000 +0100
@@ -0,0 +1,16 @@
+#ifndef _ASM_PPC64_SPARSEMEM_H
+#define _ASM_PPC64_SPARSEMEM_H 1
+
+#ifdef CONFIG_SPARSEMEM
+/*
+ * SECTION_SIZE_BITS		2^N: how big each section will be
+ * MAX_PHYSADDR_BITS		2^N: how much physical address space we have
+ * MAX_PHYSMEM_BITS		2^N: how much memory we can have in that space
+ */
+#define SECTION_SIZE_BITS       24
+#define MAX_PHYSADDR_BITS       38
+#define MAX_PHYSMEM_BITS        36
+
+#endif /* CONFIG_SPARSEMEM */
+
+#endif /* _ASM_PPC64_SPARSEMEM_H */
