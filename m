Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265729AbSJYAg5>; Thu, 24 Oct 2002 20:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265732AbSJYAg4>; Thu, 24 Oct 2002 20:36:56 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:45791 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265729AbSJYAga>;
	Thu, 24 Oct 2002 20:36:30 -0400
Message-ID: <3DB8927E.5090909@us.ibm.com>
Date: Thu, 24 Oct 2002 17:38:22 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Martin Bligh <mjbligh@us.ibm.com>
Subject: [rfc][patch] MAX_NR_NODES vs. MAX_NUMNODES
Content-Type: multipart/mixed;
 boundary="------------090901010506040407070107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090901010506040407070107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

There are two #defines to keep track of the maximum number of nodes in 
the system, and luckily they don't have even remotely similar values!! 
:(  MAX_NR_NODES is about 85, and MAX_NUMNODES is 1, 4, 8, or 16 
depending on config options and architectures.  Maybe this confuses only 
me, in which case, please ignore this patch.  For those who'd like only 
one definition of the maximum number of nodes in a system, read on!

This patch
1) Gets rid of the include/asm-xxx/numnodes.h files
2) Defines MAX_NR_NODES to the appropriate per-arch value in 
include/asm-xxx/param.h
3) changes all remaining occurences MAX_NUMNODES to MAX_NR_NODES 
throughout the kernel

I chose to keep MAX_NR_NODES because it (more) closely resembles 
NR_CPUS, and MAX_NR_MEMBLKS. (Frankly, I'd like to s/NR_CPUS/MAX_NR_CPUS 
for correctness, but I'd be lynched!! ;)

Anyone who is more familiar with some of the architectures I mucked with 
(arm, alpha, ppc64), please let me know if what I've done looks wrong.

Cheers!

-Matt

--------------090901010506040407070107
Content-Type: text/plain;
 name="max_numnodes_fix-2.5.44.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="max_numnodes_fix-2.5.44.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/arch/alpha/mm/numa.c linux-2.5.44-max_numnodes_fix/arch/alpha/mm/numa.c
--- linux-2.5.44-vanilla/arch/alpha/mm/numa.c	Fri Oct 18 21:01:08 2002
+++ linux-2.5.44-max_numnodes_fix/arch/alpha/mm/numa.c	Thu Oct 24 17:21:31 2002
@@ -19,8 +19,8 @@
 #include <asm/hwrpb.h>
 #include <asm/pgalloc.h>
 
-plat_pg_data_t *plat_node_data[MAX_NUMNODES];
-bootmem_data_t plat_node_bdata[MAX_NUMNODES];
+plat_pg_data_t *plat_node_data[MAX_NR_NODES];
+bootmem_data_t plat_node_bdata[MAX_NR_NODES];
 
 #undef DEBUG_DISCONTIG
 #ifdef DEBUG_DISCONTIG
@@ -243,7 +243,7 @@
 	show_mem_layout();
 
 	numnodes = 0;
-	for (nid = 0; nid < MAX_NUMNODES; nid++)
+	for (nid = 0; nid < MAX_NR_NODES; nid++)
 		setup_memory_node(nid, kernel_end);
 
 #ifdef CONFIG_BLK_DEV_INITRD
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/arch/arm/mm/discontig.c linux-2.5.44-max_numnodes_fix/arch/arm/mm/discontig.c
--- linux-2.5.44-vanilla/arch/arm/mm/discontig.c	Fri Oct 18 21:02:29 2002
+++ linux-2.5.44-max_numnodes_fix/arch/arm/mm/discontig.c	Thu Oct 24 17:21:31 2002
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 #include <linux/bootmem.h>
 
-#if NR_NODES != 4
+#if MAX_NR_NODES != 4
 #error Fix Me Please
 #endif
 
@@ -23,9 +23,9 @@
  * Our node_data structure for discontigous memory.
  */
 
-static bootmem_data_t node_bootmem_data[NR_NODES];
+static bootmem_data_t node_bootmem_data[MAX_NR_NODES];
 
-pg_data_t discontig_node_data[NR_NODES] = {
+pg_data_t discontig_node_data[MAX_NR_NODES] = {
   { bdata: &node_bootmem_data[0] },
   { bdata: &node_bootmem_data[1] },
   { bdata: &node_bootmem_data[2] },
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/arch/arm/mm/init.c linux-2.5.44-max_numnodes_fix/arch/arm/mm/init.c
--- linux-2.5.44-vanilla/arch/arm/mm/init.c	Fri Oct 18 21:01:09 2002
+++ linux-2.5.44-max_numnodes_fix/arch/arm/mm/init.c	Thu Oct 24 17:21:31 2002
@@ -34,12 +34,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#ifndef CONFIG_DISCONTIGMEM
-#define NR_NODES	1
-#else
-#define NR_NODES	4
-#endif
-
 #ifdef CONFIG_CPU_32
 #define TABLE_OFFSET	(PTRS_PER_PTE)
 #else
@@ -179,7 +173,7 @@
 {
 	unsigned int i, bootmem_pages = 0, memend_pfn = 0;
 
-	for (i = 0; i < NR_NODES; i++) {
+	for (i = 0; i < MAX_NR_NODES; i++) {
 		np[i].start = -1U;
 		np[i].end = 0;
 		np[i].bootmap_pages = 0;
@@ -208,7 +202,7 @@
 			 * we have, we're in trouble.  (maybe we ought to
 			 * limit, instead of bugging?)
 			 */
-			if (numnodes > NR_NODES)
+			if (numnodes > MAX_NR_NODES)
 				BUG();
 		}
 
@@ -366,7 +360,7 @@
  */
 void __init bootmem_init(struct meminfo *mi)
 {
-	struct node_info node_info[NR_NODES], *np = node_info;
+	struct node_info node_info[MAX_NR_NODES], *np = node_info;
 	unsigned int bootmap_pages, bootmap_pfn, map_pg;
 	int node, initrd_node;
 
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/arch/i386/kernel/numaq.c linux-2.5.44-max_numnodes_fix/arch/i386/kernel/numaq.c
--- linux-2.5.44-vanilla/arch/i386/kernel/numaq.c	Fri Oct 18 21:01:17 2002
+++ linux-2.5.44-max_numnodes_fix/arch/i386/kernel/numaq.c	Thu Oct 24 17:21:31 2002
@@ -30,8 +30,8 @@
 #include <asm/numaq.h>
 
 /* These are needed before the pgdat's are created */
-unsigned long node_start_pfn[MAX_NUMNODES];
-unsigned long node_end_pfn[MAX_NUMNODES];
+unsigned long node_start_pfn[MAX_NR_NODES];
+unsigned long node_end_pfn[MAX_NR_NODES];
 
 #define	MB_TO_PAGES(addr) ((addr) << (20 - PAGE_SHIFT))
 
@@ -50,7 +50,10 @@
 		(struct sys_cfg_data *)__va(SYS_CFG_DATA_PRIV_ADDR);
 
 	numnodes = 0;
-	for(node = 0; node < MAX_NUMNODES; node++) {
+	/* This should be fixed.  It is doing bitwise arithmetic with a 32
+	 * bit field, but the bounds were not being checked.
+	 */
+	for(node = 0; node < MAX_NR_NODES; node++) {
 		if(scd->quads_present31_0 & (1 << node)) {
 			numnodes++;
 			eq = &scd->eq[node];
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/arch/i386/mm/discontig.c linux-2.5.44-max_numnodes_fix/arch/i386/mm/discontig.c
--- linux-2.5.44-vanilla/arch/i386/mm/discontig.c	Fri Oct 18 21:01:56 2002
+++ linux-2.5.44-max_numnodes_fix/arch/i386/mm/discontig.c	Thu Oct 24 17:21:31 2002
@@ -33,7 +33,7 @@
 #include <asm/e820.h>
 #include <asm/setup.h>
 
-struct pglist_data *node_data[MAX_NUMNODES];
+struct pglist_data *node_data[MAX_NR_NODES];
 bootmem_data_t node0_bdata;
 
 extern unsigned long find_max_low_pfn(void);
@@ -115,10 +115,10 @@
 
 #define LARGE_PAGE_BYTES (PTRS_PER_PTE * PAGE_SIZE)
 
-unsigned long node_remap_start_pfn[MAX_NUMNODES];
-unsigned long node_remap_size[MAX_NUMNODES];
-unsigned long node_remap_offset[MAX_NUMNODES];
-void *node_remap_start_vaddr[MAX_NUMNODES];
+unsigned long node_remap_start_pfn[MAX_NR_NODES];
+unsigned long node_remap_size[MAX_NR_NODES];
+unsigned long node_remap_offset[MAX_NR_NODES];
+void *node_remap_start_vaddr[MAX_NR_NODES];
 extern void set_pmd_pfn(unsigned long vaddr, unsigned long pfn, pgprot_t flags);
 
 void __init remap_numa_kva(void)
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/arch/ppc64/mm/init.c linux-2.5.44-max_numnodes_fix/arch/ppc64/mm/init.c
--- linux-2.5.44-vanilla/arch/ppc64/mm/init.c	Fri Oct 18 21:01:58 2002
+++ linux-2.5.44-max_numnodes_fix/arch/ppc64/mm/init.c	Thu Oct 24 17:21:31 2002
@@ -522,7 +522,7 @@
 {
 	int nid;
 
-        for (nid = 0; nid < MAX_NUMNODES; nid++) {
+        for (nid = 0; nid < MAX_NR_NODES; nid++) {
 		if (numa_node_exists[nid]) {
 			printk("freeing bootmem node %x\n", nid);
 			totalram_pages +=
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/arch/ppc64/mm/numa.c linux-2.5.44-max_numnodes_fix/arch/ppc64/mm/numa.c
--- linux-2.5.44-vanilla/arch/ppc64/mm/numa.c	Fri Oct 18 21:02:26 2002
+++ linux-2.5.44-max_numnodes_fix/arch/ppc64/mm/numa.c	Thu Oct 24 17:21:31 2002
@@ -24,10 +24,10 @@
 int numa_cpu_lookup_table[NR_CPUS] = { [ 0 ... (NR_CPUS - 1)] = -1};
 int numa_memory_lookup_table[MAX_MEMORY >> MEMORY_INCREMENT_SHIFT] =
 	{ [ 0 ... ((MAX_MEMORY >> MEMORY_INCREMENT_SHIFT) - 1)] = -1};
-int numa_node_exists[MAX_NUMNODES];
+int numa_node_exists[MAX_NR_NODES];
 
-struct pglist_data node_data[MAX_NUMNODES];
-bootmem_data_t plat_node_bdata[MAX_NUMNODES];
+struct pglist_data node_data[MAX_NR_NODES];
+bootmem_data_t plat_node_bdata[MAX_NR_NODES];
 
 static int __init parse_numa_properties(void)
 {
@@ -45,7 +45,7 @@
 	if (parse_numa_properties())
 		BUG();
 
-	for (nid = 0; nid < MAX_NUMNODES; nid++) {
+	for (nid = 0; nid < MAX_NR_NODES; nid++) {
 		unsigned long start, end;
 		unsigned long start_paddr, end_paddr;
 		int i;
@@ -152,7 +152,7 @@
 	for (i = 1; i < MAX_NR_ZONES; i++)
 		zones_size[i] = 0;
 
-	for (nid = 0; nid < MAX_NUMNODES; nid++) {
+	for (nid = 0; nid < MAX_NR_NODES; nid++) {
 		unsigned long start_pfn;
 		unsigned long end_pfn;
 
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-alpha/numnodes.h linux-2.5.44-max_numnodes_fix/include/asm-alpha/numnodes.h
--- linux-2.5.44-vanilla/include/asm-alpha/numnodes.h	Fri Oct 18 21:01:12 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-alpha/numnodes.h	Wed Dec 31 16:00:00 1969
@@ -1,12 +0,0 @@
-#ifndef _ASM_MAX_NUMNODES_H
-#define _ASM_MAX_NUMNODES_H
-
-/*
- * Currently the Wildfire is the only discontigmem/NUMA capable Alpha core.
- */
-#if defined(CONFIG_ALPHA_WILDFIRE) || defined(CONFIG_ALPHA_GENERIC)
-# include <asm/core_wildfire.h>
-# define MAX_NUMNODES		WILDFIRE_MAX_QBB
-#endif
-
-#endif /* _ASM_MAX_NUMNODES_H */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-alpha/param.h linux-2.5.44-max_numnodes_fix/include/asm-alpha/param.h
--- linux-2.5.44-vanilla/include/asm-alpha/param.h	Fri Oct 18 21:01:52 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-alpha/param.h	Thu Oct 24 17:21:31 2002
@@ -7,6 +7,14 @@
 
 #include <linux/config.h>
 
+/*
+ * Currently the Wildfire is the only discontigmem/NUMA capable Alpha core.
+ */
+#if defined(CONFIG_ALPHA_WILDFIRE) || defined(CONFIG_ALPHA_GENERIC)
+# include <asm/core_wildfire.h>
+# define MAX_NR_NODES		WILDFIRE_MAX_QBB
+#endif
+
 #ifndef HZ
 # ifndef CONFIG_ALPHA_RAWHIDE
 #  define HZ	1024
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-arm/arch-clps711x/memory.h linux-2.5.44-max_numnodes_fix/include/asm-arm/arch-clps711x/memory.h
--- linux-2.5.44-vanilla/include/asm-arm/arch-clps711x/memory.h	Fri Oct 18 21:01:08 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-arm/arch-clps711x/memory.h	Thu Oct 24 17:21:31 2002
@@ -109,8 +109,6 @@
  * 	node 3:  0xd8000000 - 0xdfffffff
  */
 
-#define NR_NODES	4
-
 /*
  * Given a kernel address, find the home node of the underlying memory.
  */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-arm/arch-clps711x/param.h linux-2.5.44-max_numnodes_fix/include/asm-arm/arch-clps711x/param.h
--- linux-2.5.44-vanilla/include/asm-arm/arch-clps711x/param.h	Fri Oct 18 21:02:59 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-arm/arch-clps711x/param.h	Thu Oct 24 17:21:31 2002
@@ -17,3 +17,4 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#define MAX_NR_NODES	4
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-arm/arch-sa1100/memory.h linux-2.5.44-max_numnodes_fix/include/asm-arm/arch-sa1100/memory.h
--- linux-2.5.44-vanilla/include/asm-arm/arch-sa1100/memory.h	Fri Oct 18 21:01:08 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-arm/arch-sa1100/memory.h	Thu Oct 24 17:21:31 2002
@@ -74,8 +74,6 @@
  * 	node 3:  0xd8000000 - 0xdfffffff
  */
 
-#define NR_NODES	4
-
 /*
  * Given a kernel address, find the home node of the underlying memory.
  */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-arm/arch-sa1100/param.h linux-2.5.44-max_numnodes_fix/include/asm-arm/arch-sa1100/param.h
--- linux-2.5.44-vanilla/include/asm-arm/arch-sa1100/param.h	Fri Oct 18 21:01:50 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-arm/arch-sa1100/param.h	Thu Oct 24 17:21:31 2002
@@ -1,3 +1,4 @@
 /*
  *  linux/include/asm-arm/arch-sa1100/param.h
  */
+#define MAX_NR_NODES	4
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-arm/memory.h linux-2.5.44-max_numnodes_fix/include/asm-arm/memory.h
--- linux-2.5.44-vanilla/include/asm-arm/memory.h	Fri Oct 18 21:02:30 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-arm/memory.h	Thu Oct 24 17:21:31 2002
@@ -88,12 +88,12 @@
 #define pfn_to_page(pfn)					\
 	(PFN_TO_MAPBASE(pfn) + LOCAL_MAP_NR((pfn) << PAGE_SHIFT))
 
-#define pfn_valid(pfn)		(PFN_TO_NID(pfn) < NR_NODES)
+#define pfn_valid(pfn)		(PFN_TO_NID(pfn) < MAX_NR_NODES)
 
 #define virt_to_page(kaddr)					\
 	(ADDR_TO_MAPBASE(kaddr) + LOCAL_MAP_NR(kaddr))
 
-#define virt_addr_valid(kaddr)	(KVADDR_TO_NID(kaddr) < NR_NODES)
+#define virt_addr_valid(kaddr)	(KVADDR_TO_NID(kaddr) < MAX_NR_NODES)
 
 /*
  * Common discontigmem stuff.
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-arm/numnodes.h linux-2.5.44-max_numnodes_fix/include/asm-arm/numnodes.h
--- linux-2.5.44-vanilla/include/asm-arm/numnodes.h	Fri Oct 18 21:01:48 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-arm/numnodes.h	Wed Dec 31 16:00:00 1969
@@ -1,17 +0,0 @@
-/*
- *  linux/include/asm-arm/numnodes.h
- *
- *  Copyright (C) 2002 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef __ASM_ARM_NUMNODES_H
-#define __ASM_ARM_NUMNODES_H
-
-#include <asm/memory.h>
-
-#define MAX_NUMNODES	NR_NODES
-
-#endif
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-arm/param.h linux-2.5.44-max_numnodes_fix/include/asm-arm/param.h
--- linux-2.5.44-vanilla/include/asm-arm/param.h	Fri Oct 18 21:01:55 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-arm/param.h	Thu Oct 24 17:21:31 2002
@@ -13,6 +13,12 @@
 #include <asm/arch/param.h>	/* for HZ */
 #include <asm/proc/page.h>	/* for EXEC_PAGE_SIZE */
 
+#ifdef CONFIG_DISCONTIGMEM
+# ifndef MAX_NR_NODES
+# define MAX_NR_NODES	4
+# endif
+#endif /* CONFIG_DISCONTIGMEM */
+
 #ifndef __KERNEL_HZ
 #define __KERNEL_HZ	100
 #endif
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-i386/numaq.h linux-2.5.44-max_numnodes_fix/include/asm-i386/numaq.h
--- linux-2.5.44-vanilla/include/asm-i386/numaq.h	Fri Oct 18 21:01:56 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-i386/numaq.h	Thu Oct 24 17:21:31 2002
@@ -40,7 +40,6 @@
 
 #define pfn_to_pgdat(pfn) NODE_DATA(pfn_to_nid(pfn))
 #define PHYSADDR_TO_NID(pa) pfn_to_nid(pa >> PAGE_SHIFT)
-#define MAX_NUMNODES		8
 extern int pfn_to_nid(unsigned long);
 extern void get_memcfg_numaq(void);
 #define get_memcfg_numa() get_memcfg_numaq()
@@ -167,7 +166,7 @@
 	/*
 	 *	memory configuration area for each quad
 	 */
-        struct	eachquadmem eq[MAX_NUMNODES];	/* indexed by quad id */
+        struct	eachquadmem eq[MAX_NR_NODES];	/* indexed by quad id */
 };
 
 #endif /* CONFIG_X86_NUMAQ */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-i386/numnodes.h linux-2.5.44-max_numnodes_fix/include/asm-i386/numnodes.h
--- linux-2.5.44-vanilla/include/asm-i386/numnodes.h	Fri Oct 18 21:01:16 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-i386/numnodes.h	Wed Dec 31 16:00:00 1969
@@ -1,12 +0,0 @@
-#ifndef _ASM_MAX_NUMNODES_H
-#define _ASM_MAX_NUMNODES_H
-
-#include <linux/config.h>
-
-#ifdef CONFIG_X86_NUMAQ
-#include <asm/numaq.h>
-#else
-#define MAX_NUMNODES	1
-#endif /* CONFIG_X86_NUMAQ */
-
-#endif /* _ASM_MAX_NUMNODES_H */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-i386/param.h linux-2.5.44-max_numnodes_fix/include/asm-i386/param.h
--- linux-2.5.44-vanilla/include/asm-i386/param.h	Fri Oct 18 21:01:16 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-i386/param.h	Thu Oct 24 17:21:31 2002
@@ -1,6 +1,10 @@
 #ifndef _ASMi386_PARAM_H
 #define _ASMi386_PARAM_H
 
+#ifdef CONFIG_DISCONTIGMEM
+#define MAX_NR_NODES	8
+#endif
+
 #ifdef __KERNEL__
 # define HZ		1000		/* Internal kernel timer frequency */
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-ppc64/numnodes.h linux-2.5.44-max_numnodes_fix/include/asm-ppc64/numnodes.h
--- linux-2.5.44-vanilla/include/asm-ppc64/numnodes.h	Fri Oct 18 21:02:28 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-ppc64/numnodes.h	Wed Dec 31 16:00:00 1969
@@ -1,6 +0,0 @@
-#ifndef _ASM_MAX_NUMNODES_H
-#define _ASM_MAX_NUMNODES_H
-
-#define MAX_NUMNODES 16
-
-#endif /* _ASM_MAX_NUMNODES_H */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-ppc64/param.h linux-2.5.44-max_numnodes_fix/include/asm-ppc64/param.h
--- linux-2.5.44-vanilla/include/asm-ppc64/param.h	Fri Oct 18 21:02:30 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-ppc64/param.h	Thu Oct 24 17:21:31 2002
@@ -8,6 +8,10 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#ifdef CONFIG_DISCONTIGMEM
+#define MAX_NR_NODES	16
+#endif
+
 #ifdef __KERNEL__
 # define HZ		1000		/* Internal kernel timer frequency */
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/linux/mmzone.h linux-2.5.44-max_numnodes_fix/include/linux/mmzone.h
--- linux-2.5.44-vanilla/include/linux/mmzone.h	Fri Oct 18 21:01:08 2002
+++ linux-2.5.44-max_numnodes_fix/include/linux/mmzone.h	Thu Oct 24 17:21:31 2002
@@ -9,13 +9,8 @@
 #include <linux/list.h>
 #include <linux/wait.h>
 #include <linux/cache.h>
+#include <linux/param.h>
 #include <asm/atomic.h>
-#ifdef CONFIG_DISCONTIGMEM
-#include <asm/numnodes.h>
-#endif
-#ifndef MAX_NUMNODES
-#define MAX_NUMNODES 1
-#endif
 
 /* Free memory management - zoned buddy allocator.  */
 #ifndef CONFIG_FORCE_MAX_ZONEORDER
@@ -128,6 +123,11 @@
 #define ZONE_HIGHMEM		2
 #define MAX_NR_ZONES		3
 
+/* page->zone is currently 8 bits ... */
+#if MAX_NR_NODES > (255 / MAX_NR_ZONES)
+#error "MAX_NR_NODES too large!!"
+#endif
+
 /*
  * One allocation request operates on a zonelist. A zonelist
  * is a list of zones, the first one is the 'goal' of the
@@ -140,7 +140,7 @@
  * footprint of this construct is very small.
  */
 struct zonelist {
-	struct zone *zones[MAX_NUMNODES * MAX_NR_ZONES + 1]; // NULL delimited
+	struct zone *zones[MAX_NR_NODES * MAX_NR_ZONES + 1]; // NULL delimited
 };
 
 #define GFP_ZONEMASK	0x0f
@@ -252,13 +252,9 @@
 extern struct pglist_data contig_page_data;
 #define NODE_DATA(nid)		(&contig_page_data)
 #define NODE_MEM_MAP(nid)	mem_map
-#define MAX_NR_NODES		1
 #else /* CONFIG_DISCONTIGMEM */
-
 #include <asm/mmzone.h>
 
-/* page->zone is currently 8 bits ... */
-#define MAX_NR_NODES		(255 / MAX_NR_ZONES)
 
 #endif /* !CONFIG_DISCONTIGMEM */
 
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/linux/param.h linux-2.5.44-max_numnodes_fix/include/linux/param.h
--- linux-2.5.44-vanilla/include/linux/param.h	Fri Oct 18 21:01:16 2002
+++ linux-2.5.44-max_numnodes_fix/include/linux/param.h	Thu Oct 24 17:21:31 2002
@@ -3,4 +3,8 @@
 
 #include <asm/param.h>
 
+#ifndef MAX_NR_NODES
+#define MAX_NR_NODES	1
+#endif
+
 #endif

--------------090901010506040407070107--

