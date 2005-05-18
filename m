Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVERP0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVERP0Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVERPZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:25:14 -0400
Received: from fmr19.intel.com ([134.134.136.18]:10926 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262265AbVERPWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:22:41 -0400
Date: Wed, 18 May 2005 08:26:43 -0700
From: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Message-Id: <200505181526.j4IFQhds026916@snoqualmie.dp.intel.com>
To: ak@muc.de, akpm@osdl.org
Subject: [patch 3/4] reorganize x86-64 NUMA and DISCONTIGMEM config options
Cc: apw@shadowen.org, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In order to use the alternative sparsemem implmentation for NUMA
kernels, we need to reorganize the config options.  This patch
effectively abstracts out the CONFIG_DISCONTIGMEM options to
CONFIG_NUMA in most cases.  Thus, the discontigmem implementation
may be employed as always, but the sparsemem implementation may
be used alternatively.

Signed-off-by: Matt Tolentino <matthew.e.tolentino@intel.com>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 arch/x86_64/kernel/head64.c   |    2 +-
 arch/x86_64/kernel/setup.c    |    6 +++---
 arch/x86_64/mm/Makefile       |    2 +-
 arch/x86_64/mm/init.c         |    9 ++++++---
 arch/x86_64/mm/ioremap.c      |    2 +-
 include/asm-x86_64/io.h       |    5 -----
 include/asm-x86_64/mmzone.h   |   15 +++++++++------
 include/asm-x86_64/page.h     |    4 +++-
 include/asm-x86_64/topology.h |    4 +---
 9 files changed, 25 insertions(+), 24 deletions(-)

diff -urNp linux-2.6.12-rc4-mm2/arch/x86_64/kernel/head64.c linux-2.6.12-rc4-mm2-m/arch/x86_64/kernel/head64.c
--- linux-2.6.12-rc4-mm2/arch/x86_64/kernel/head64.c	2005-05-07 01:20:31.000000000 -0400
+++ linux-2.6.12-rc4-mm2-m/arch/x86_64/kernel/head64.c	2005-05-18 07:48:16.000000000 -0400
@@ -94,7 +94,7 @@ void __init x86_64_start_kernel(char * r
 	s = strstr(saved_command_line, "earlyprintk=");
 	if (s != NULL)
 		setup_early_printk(s);
-#ifdef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_NUMA
 	s = strstr(saved_command_line, "numa=");
 	if (s != NULL)
 		numa_setup(s+5);
diff -urNp linux-2.6.12-rc4-mm2/arch/x86_64/kernel/setup.c linux-2.6.12-rc4-mm2-m/arch/x86_64/kernel/setup.c
--- linux-2.6.12-rc4-mm2/arch/x86_64/kernel/setup.c	2005-05-18 07:43:00.000000000 -0400
+++ linux-2.6.12-rc4-mm2-m/arch/x86_64/kernel/setup.c	2005-05-18 07:48:16.000000000 -0400
@@ -349,7 +349,7 @@ static __init void parse_cmdline_early (
 		if (!memcmp(from, "mem=", 4))
 			parse_memopt(from+4, &from); 
 
-#ifdef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_NUMA
 		if (!memcmp(from, "numa=", 5))
 			numa_setup(from+5); 
 #endif
@@ -399,7 +399,7 @@ static __init void parse_cmdline_early (
 	*cmdline_p = command_line;
 }
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifndef CONFIG_NUMA
 static void __init contig_initmem_init(void)
 {
         unsigned long bootmap_size, bootmap; 
@@ -576,7 +576,7 @@ void __init setup_arch(char **cmdline_p)
 	acpi_numa_init();
 #endif
 
-#ifdef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_NUMA
 	numa_initmem_init(0, end_pfn); 
 #else
 	contig_initmem_init(); 
diff -urNp linux-2.6.12-rc4-mm2/arch/x86_64/mm/Makefile linux-2.6.12-rc4-mm2-m/arch/x86_64/mm/Makefile
--- linux-2.6.12-rc4-mm2/arch/x86_64/mm/Makefile	2005-05-07 01:20:31.000000000 -0400
+++ linux-2.6.12-rc4-mm2-m/arch/x86_64/mm/Makefile	2005-05-18 07:48:16.000000000 -0400
@@ -4,7 +4,7 @@
 
 obj-y	 := init.o fault.o ioremap.o extable.o pageattr.o
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
-obj-$(CONFIG_DISCONTIGMEM) += numa.o
+obj-$(CONFIG_NUMA) += numa.o
 obj-$(CONFIG_K8_NUMA) += k8topology.o
 obj-$(CONFIG_ACPI_NUMA) += srat.o
 
diff -urNp linux-2.6.12-rc4-mm2/arch/x86_64/mm/init.c linux-2.6.12-rc4-mm2-m/arch/x86_64/mm/init.c
--- linux-2.6.12-rc4-mm2/arch/x86_64/mm/init.c	2005-05-07 01:20:31.000000000 -0400
+++ linux-2.6.12-rc4-mm2-m/arch/x86_64/mm/init.c	2005-05-18 07:48:16.000000000 -0400
@@ -318,7 +318,7 @@ void zap_low_mappings(void)
 	flush_tlb_all();
 }
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifndef CONFIG_NUMA
 void __init paging_init(void)
 {
 	{
@@ -427,13 +427,16 @@ void __init mem_init(void)
 	reservedpages = 0;
 
 	/* this will put all low memory onto the freelists */
-#ifdef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_NUMA
 	totalram_pages += numa_free_all_bootmem();
 	tmp = 0;
 	/* should count reserved pages here for all nodes */ 
 #else
+
+#ifdef CONFIG_FLATMEM
 	max_mapnr = end_pfn;
 	if (!mem_map) BUG();
+#endif
 
 	totalram_pages += free_all_bootmem();
 
@@ -515,7 +518,7 @@ void free_initrd_mem(unsigned long start
 void __init reserve_bootmem_generic(unsigned long phys, unsigned len) 
 { 
 	/* Should check here against the e820 map to avoid double free */ 
-#ifdef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_NUMA
 	int nid = phys_to_nid(phys);
   	reserve_bootmem_node(NODE_DATA(nid), phys, len);
 #else       		
diff -urNp linux-2.6.12-rc4-mm2/arch/x86_64/mm/ioremap.c linux-2.6.12-rc4-mm2-m/arch/x86_64/mm/ioremap.c
--- linux-2.6.12-rc4-mm2/arch/x86_64/mm/ioremap.c	2005-05-18 07:38:20.000000000 -0400
+++ linux-2.6.12-rc4-mm2-m/arch/x86_64/mm/ioremap.c	2005-05-18 07:48:16.000000000 -0400
@@ -178,7 +178,7 @@ void __iomem * __ioremap(unsigned long p
 	if (phys_addr >= ISA_START_ADDRESS && last_addr < ISA_END_ADDRESS)
 		return (__force void __iomem *)phys_to_virt(phys_addr);
 
-#ifndef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_FLATMEM
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using..
 	 */
diff -urNp linux-2.6.12-rc4-mm2/include/asm-x86_64/io.h linux-2.6.12-rc4-mm2-m/include/asm-x86_64/io.h
--- linux-2.6.12-rc4-mm2/include/asm-x86_64/io.h	2005-05-07 01:20:31.000000000 -0400
+++ linux-2.6.12-rc4-mm2-m/include/asm-x86_64/io.h	2005-05-18 07:48:17.000000000 -0400
@@ -124,12 +124,7 @@ extern inline void * phys_to_virt(unsign
 /*
  * Change "struct page" to physical address.
  */
-#ifdef CONFIG_DISCONTIGMEM
-#include <asm/mmzone.h>
 #define page_to_phys(page)    ((dma_addr_t)page_to_pfn(page) << PAGE_SHIFT)
-#else
-#define page_to_phys(page)	((page - mem_map) << PAGE_SHIFT)
-#endif
 
 #include <asm-generic/iomap.h>
 
diff -urNp linux-2.6.12-rc4-mm2/include/asm-x86_64/mmzone.h linux-2.6.12-rc4-mm2-m/include/asm-x86_64/mmzone.h
--- linux-2.6.12-rc4-mm2/include/asm-x86_64/mmzone.h	2005-05-18 07:38:28.000000000 -0400
+++ linux-2.6.12-rc4-mm2-m/include/asm-x86_64/mmzone.h	2005-05-18 07:48:17.000000000 -0400
@@ -6,7 +6,7 @@
 
 #include <linux/config.h>
 
-#ifdef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_NUMA
 
 #define VIRTUAL_BUG_ON(x) 
 
@@ -30,17 +30,16 @@ static inline __attribute__((pure)) int 
 	return nid; 
 } 
 
-#define pfn_to_nid(pfn) phys_to_nid((unsigned long)(pfn) << PAGE_SHIFT)
-
-#define kvaddr_to_nid(kaddr)	phys_to_nid(__pa(kaddr))
 #define NODE_DATA(nid)		(node_data[nid])
 
 #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
 #define node_end_pfn(nid)       (NODE_DATA(nid)->node_start_pfn + \
 				 NODE_DATA(nid)->node_spanned_pages)
 
-#define local_mapnr(kvaddr) \
-	( (__pa(kvaddr) >> PAGE_SHIFT) - node_start_pfn(kvaddr_to_nid(kvaddr)) )
+#ifdef CONFIG_DISCONTIGMEM
+
+#define pfn_to_nid(pfn) phys_to_nid((unsigned long)(pfn) << PAGE_SHIFT)
+#define kvaddr_to_nid(kaddr)	phys_to_nid(__pa(kaddr))
 
 /* AK: this currently doesn't deal with invalid addresses. We'll see 
    if the 2.5 kernel doesn't pass them
@@ -57,4 +56,8 @@ static inline __attribute__((pure)) int 
 			({ u8 nid__ = pfn_to_nid(pfn); \
 			   nid__ != 0xff && (pfn) >= node_start_pfn(nid__) && (pfn) <= node_end_pfn(nid__); }))
 #endif
+
+#define local_mapnr(kvaddr) \
+	( (__pa(kvaddr) >> PAGE_SHIFT) - node_start_pfn(kvaddr_to_nid(kvaddr)) )
+#endif
 #endif
diff -urNp linux-2.6.12-rc4-mm2/include/asm-x86_64/page.h linux-2.6.12-rc4-mm2-m/include/asm-x86_64/page.h
--- linux-2.6.12-rc4-mm2/include/asm-x86_64/page.h	2005-05-18 07:38:28.000000000 -0400
+++ linux-2.6.12-rc4-mm2-m/include/asm-x86_64/page.h	2005-05-18 07:48:17.000000000 -0400
@@ -121,7 +121,9 @@ extern __inline__ int get_order(unsigned
 	  __pa(v); })
 
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
-#ifndef CONFIG_DISCONTIGMEM
+#define __boot_va(x)		__va(x)
+#define __boot_pa(x)		__pa(x)
+#ifdef CONFIG_FLATMEM
 #define pfn_to_page(pfn)	(mem_map + (pfn))
 #define page_to_pfn(page)	((unsigned long)((page) - mem_map))
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
diff -urNp linux-2.6.12-rc4-mm2/include/asm-x86_64/topology.h linux-2.6.12-rc4-mm2-m/include/asm-x86_64/topology.h
--- linux-2.6.12-rc4-mm2/include/asm-x86_64/topology.h	2005-05-18 07:38:28.000000000 -0400
+++ linux-2.6.12-rc4-mm2-m/include/asm-x86_64/topology.h	2005-05-18 07:48:17.000000000 -0400
@@ -3,7 +3,7 @@
 
 #include <linux/config.h>
 
-#ifdef CONFIG_DISCONTIGMEM
+#ifdef CONFIG_NUMA
 
 #include <asm/mpspec.h>
 #include <asm/bitops.h>
@@ -28,7 +28,6 @@ extern int __node_distance(int, int);
 #define node_to_cpumask(node)		(node_to_cpumask[node])
 #define pcibus_to_cpumask(bus)		node_to_cpumask(pci_bus_to_node[(bus)->number]);
 
-#ifdef CONFIG_NUMA
 /* sched_domains SD_NODE_INIT for x86_64 machines */
 #define SD_NODE_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
@@ -54,7 +53,6 @@ extern int __node_distance(int, int);
 	.balance_interval	= 1,			\
 	.nr_balance_failed	= 0,			\
 }
-#endif
 
 #endif
 
