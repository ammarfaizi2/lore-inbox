Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSJ1XRw>; Mon, 28 Oct 2002 18:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261440AbSJ1XRv>; Mon, 28 Oct 2002 18:17:51 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:41644 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261356AbSJ1XRn>;
	Mon, 28 Oct 2002 18:17:43 -0500
Message-ID: <3DBDC5C4.3010807@us.ibm.com>
Date: Mon, 28 Oct 2002 15:18:28 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [rfc][patch] MAX_NR_NODES vs. MAX_NUMNODES
References: <3DB8927E.5090909@us.ibm.com> <20021025100028.A19335@flint.arm.linux.org.uk> <3DBD9434.5050601@us.ibm.com> <20021028213700.D11734@flint.arm.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------030407020609020905070404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030407020609020905070404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Russell King wrote:
> On Mon, Oct 28, 2002 at 11:47:00AM -0800, Matthew Dobson wrote:
>>>It would be better if it remained in mmzone.h for non-arm, and the
>>>memory.h files for arm.  I really never understood why numnodes.h was
>>>created when mmzone.h has works adequately well since 2.3.
>>
>>As mentioned in the original post, I was trying 
>>to kill a bunch of (seemingly) unnecessary .h files (the numnodes.h's 
>>specifically), and remove the MAX_[NUM|NR_]NODES duality.  If that can't 
>>be accomplished, then all this would do is move the confusion around, 
>>and I don't want that...
> 
> I'm in agreement with you here.

I knew we must have some motivation in common! ;)

>>If you feel param.h is the wrong place, I originally had the #define's 
>>in asm/topology.h.
> 
> This seems like a good solution - linux/mmzone.h already includes this
> file, so it wouldn't be adding all that much to the #include hell.
> Also, asm-generic/topology.h contains stuff to do with numa/discontig
> already, so it seems perfect.

Ok... I've revised the patch to put the #define's in topology.h.  Please 
have a look and make sure I still haven't butchered things for arm.  I 
think that <asm/topology.h> is a particularly reasonable place to define 
MAX_NR_NODES and other topology things! :)  We'll see if this piques 
anyone's interest.

 >>max_numnodes_fix.patch

Collapse the use of MAX_NUMNODES throughout the kernel into the already 
existing, far less used, yet far more appropriately named MAX_NR_NODES.

[mcd@arrakis src]$ diffstat ~/patches/max_numnodes_fix-2.5.44.patch
  arch/alpha/mm/numa.c                   |    6 +++---
  arch/arm/mm/discontig.c                |    6 +++---
  arch/arm/mm/init.c                     |   12 +++---------
  arch/i386/kernel/numaq.c               |   10 ++++++----
  arch/i386/mm/discontig.c               |   11 +++++------
  arch/ppc64/mm/init.c                   |    2 +-
  arch/ppc64/mm/numa.c                   |   10 +++++-----
  include/asm-alpha/numnodes.h           |   12 ------------
  include/asm-alpha/topology.h           |   10 ++++++++++
  include/asm-arm/arch-clps711x/memory.h |    2 --
  include/asm-arm/arch-sa1100/memory.h   |    2 --
  include/asm-arm/memory.h               |    5 +++--
  include/asm-arm/numnodes.h             |   17 -----------------
  include/asm-arm/topology.h             |    4 ++++
  include/asm-generic/topology.h         |    4 ++++
  include/asm-i386/numaq.h               |    5 ++---
  include/asm-i386/numnodes.h            |   12 ------------
  include/asm-i386/topology.h            |    4 ++++
  include/asm-ppc64/numnodes.h           |    6 ------
  include/asm-ppc64/topology.h           |    6 ++++++
  include/linux/mmzone.h                 |   19 +++++++------------
  21 files changed, 66 insertions(+), 99 deletions(-)

Kills 33 lines of code, and also kills 4 files.  With (apparently) no 
change in functionality and possibly even a positive change in readability.

Cheers!

-Matt

--------------030407020609020905070404
Content-Type: text/plain;
 name="max_numnodes_fix-2.5.44.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="max_numnodes_fix-2.5.44.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/arch/alpha/mm/numa.c linux-2.5.44-max_numnodes_fix/arch/alpha/mm/numa.c
--- linux-2.5.44-vanilla/arch/alpha/mm/numa.c	Fri Oct 18 21:01:08 2002
+++ linux-2.5.44-max_numnodes_fix/arch/alpha/mm/numa.c	Mon Oct 28 14:24:18 2002
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
+++ linux-2.5.44-max_numnodes_fix/arch/arm/mm/discontig.c	Mon Oct 28 14:24:18 2002
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
+++ linux-2.5.44-max_numnodes_fix/arch/arm/mm/init.c	Mon Oct 28 14:24:18 2002
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
+++ linux-2.5.44-max_numnodes_fix/arch/i386/kernel/numaq.c	Mon Oct 28 14:27:49 2002
@@ -26,12 +26,11 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/bootmem.h>
-#include <linux/mmzone.h>
 #include <asm/numaq.h>
 
 /* These are needed before the pgdat's are created */
-unsigned long node_start_pfn[MAX_NUMNODES];
-unsigned long node_end_pfn[MAX_NUMNODES];
+unsigned long node_start_pfn[MAX_NR_NODES];
+unsigned long node_end_pfn[MAX_NR_NODES];
 
 #define	MB_TO_PAGES(addr) ((addr) << (20 - PAGE_SHIFT))
 
@@ -50,7 +49,10 @@
 		(struct sys_cfg_data *)__va(SYS_CFG_DATA_PRIV_ADDR);
 
 	numnodes = 0;
-	for(node = 0; node < MAX_NUMNODES; node++) {
+	/* FIXME:  This loop is doing bitwise operations with a 32
+	 * bit field, but the bounds are not being checked.
+	 */
+	for(node = 0; node < MAX_NR_NODES; node++) {
 		if(scd->quads_present31_0 & (1 << node)) {
 			numnodes++;
 			eq = &scd->eq[node];
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/arch/i386/mm/discontig.c linux-2.5.44-max_numnodes_fix/arch/i386/mm/discontig.c
--- linux-2.5.44-vanilla/arch/i386/mm/discontig.c	Fri Oct 18 21:01:56 2002
+++ linux-2.5.44-max_numnodes_fix/arch/i386/mm/discontig.c	Mon Oct 28 14:28:10 2002
@@ -25,7 +25,6 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/bootmem.h>
-#include <linux/mmzone.h>
 #include <linux/highmem.h>
 #ifdef CONFIG_BLK_DEV_RAM
 #include <linux/blk.h>
@@ -33,7 +32,7 @@
 #include <asm/e820.h>
 #include <asm/setup.h>
 
-struct pglist_data *node_data[MAX_NUMNODES];
+struct pglist_data *node_data[MAX_NR_NODES];
 bootmem_data_t node0_bdata;
 
 extern unsigned long find_max_low_pfn(void);
@@ -115,10 +114,10 @@
 
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
+++ linux-2.5.44-max_numnodes_fix/arch/ppc64/mm/init.c	Mon Oct 28 14:24:18 2002
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
+++ linux-2.5.44-max_numnodes_fix/arch/ppc64/mm/numa.c	Mon Oct 28 14:24:18 2002
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
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-alpha/topology.h linux-2.5.44-max_numnodes_fix/include/asm-alpha/topology.h
--- linux-2.5.44-vanilla/include/asm-alpha/topology.h	Fri Oct 18 21:01:18 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-alpha/topology.h	Mon Oct 28 14:52:26 2002
@@ -1,6 +1,16 @@
 #ifndef _ASM_ALPHA_TOPOLOGY_H
 #define _ASM_ALPHA_TOPOLOGY_H
 
+/*
+ * Currently the Wildfire is the only discontigmem/NUMA capable Alpha core.
+ */
+#if defined(CONFIG_ALPHA_WILDFIRE) || defined(CONFIG_ALPHA_GENERIC)
+# include <asm/core_wildfire.h>
+# define MAX_NR_NODES	WILDFIRE_MAX_QBB
+#else
+# define MAX_NR_NODES	1
+#endif
+
 #ifdef CONFIG_NUMA
 #ifdef CONFIG_ALPHA_WILDFIRE
 /* With wildfire assume 4 CPUs per node */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-arm/arch-clps711x/memory.h linux-2.5.44-max_numnodes_fix/include/asm-arm/arch-clps711x/memory.h
--- linux-2.5.44-vanilla/include/asm-arm/arch-clps711x/memory.h	Fri Oct 18 21:01:08 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-arm/arch-clps711x/memory.h	Mon Oct 28 14:24:18 2002
@@ -109,8 +109,6 @@
  * 	node 3:  0xd8000000 - 0xdfffffff
  */
 
-#define NR_NODES	4
-
 /*
  * Given a kernel address, find the home node of the underlying memory.
  */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-arm/arch-sa1100/memory.h linux-2.5.44-max_numnodes_fix/include/asm-arm/arch-sa1100/memory.h
--- linux-2.5.44-vanilla/include/asm-arm/arch-sa1100/memory.h	Fri Oct 18 21:01:08 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-arm/arch-sa1100/memory.h	Mon Oct 28 14:24:18 2002
@@ -74,8 +74,6 @@
  * 	node 3:  0xd8000000 - 0xdfffffff
  */
 
-#define NR_NODES	4
-
 /*
  * Given a kernel address, find the home node of the underlying memory.
  */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-arm/memory.h linux-2.5.44-max_numnodes_fix/include/asm-arm/memory.h
--- linux-2.5.44-vanilla/include/asm-arm/memory.h	Fri Oct 18 21:02:30 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-arm/memory.h	Mon Oct 28 14:37:52 2002
@@ -14,6 +14,7 @@
 
 #include <linux/config.h>
 #include <asm/arch/memory.h>
+#include <asm/topology.h>
 
 /*
  * PFNs are used to describe any physical page; this means
@@ -88,12 +89,12 @@
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
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-arm/topology.h linux-2.5.44-max_numnodes_fix/include/asm-arm/topology.h
--- linux-2.5.44-vanilla/include/asm-arm/topology.h	Fri Oct 18 21:01:07 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-arm/topology.h	Mon Oct 28 14:40:27 2002
@@ -1,6 +1,10 @@
 #ifndef _ASM_ARM_TOPOLOGY_H
 #define _ASM_ARM_TOPOLOGY_H
 
+#if defined(CONFIG_DISCONTIGMEM) || defined(CONFIG_ARCH_SA1100) || defined(CONFIG_ARCH_CLPS711X)
+#define MAX_NR_NODES	4
+#endif
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_ARM_TOPOLOGY_H */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-generic/topology.h linux-2.5.44-max_numnodes_fix/include/asm-generic/topology.h
--- linux-2.5.44-vanilla/include/asm-generic/topology.h	Fri Oct 18 21:01:11 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-generic/topology.h	Mon Oct 28 14:48:13 2002
@@ -27,6 +27,10 @@
 #ifndef _ASM_GENERIC_TOPOLOGY_H
 #define _ASM_GENERIC_TOPOLOGY_H
 
+#ifndef MAX_NR_NODES
+#define MAX_NR_NODES	1
+#endif
+
 /* Other architectures wishing to use this simple topology API should fill
    in the below functions as appropriate in their own <asm/topology.h> file. */
 #ifndef __cpu_to_node
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-i386/numaq.h linux-2.5.44-max_numnodes_fix/include/asm-i386/numaq.h
--- linux-2.5.44-vanilla/include/asm-i386/numaq.h	Fri Oct 18 21:01:56 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-i386/numaq.h	Mon Oct 28 14:44:01 2002
@@ -28,7 +28,7 @@
 
 #ifdef CONFIG_X86_NUMAQ
 
-#include <asm/smpboot.h>
+#include <asm/topology.h>
 
 /*
  * for now assume that 64Gb is max amount of RAM for whole system
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
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-i386/topology.h linux-2.5.44-max_numnodes_fix/include/asm-i386/topology.h
--- linux-2.5.44-vanilla/include/asm-i386/topology.h	Fri Oct 18 21:01:16 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-i386/topology.h	Mon Oct 28 15:03:53 2002
@@ -27,6 +27,10 @@
 #ifndef _ASM_I386_TOPOLOGY_H
 #define _ASM_I386_TOPOLOGY_H
 
+#ifdef CONFIG_NUMA
+#define MAX_NR_NODES	16
+#endif
+
 #ifdef CONFIG_X86_NUMAQ
 
 #include <asm/smpboot.h>
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
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-ppc64/topology.h linux-2.5.44-max_numnodes_fix/include/asm-ppc64/topology.h
--- linux-2.5.44-vanilla/include/asm-ppc64/topology.h	Fri Oct 18 21:01:52 2002
+++ linux-2.5.44-max_numnodes_fix/include/asm-ppc64/topology.h	Mon Oct 28 14:46:27 2002
@@ -3,6 +3,12 @@
 
 #include <asm/mmzone.h>
 
+#ifdef CONFIG_DISCONTIGMEM
+#define MAX_NR_NODES	16
+#else
+#define MAX_NR_NODES	1
+#endif
+
 #ifdef CONFIG_NUMA
 
 static inline int __cpu_to_node(int cpu)
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/linux/mmzone.h linux-2.5.44-max_numnodes_fix/include/linux/mmzone.h
--- linux-2.5.44-vanilla/include/linux/mmzone.h	Fri Oct 18 21:01:08 2002
+++ linux-2.5.44-max_numnodes_fix/include/linux/mmzone.h	Mon Oct 28 15:10:17 2002
@@ -10,12 +10,7 @@
 #include <linux/wait.h>
 #include <linux/cache.h>
 #include <asm/atomic.h>
-#ifdef CONFIG_DISCONTIGMEM
-#include <asm/numnodes.h>
-#endif
-#ifndef MAX_NUMNODES
-#define MAX_NUMNODES 1
-#endif
+#include <asm/topology.h>
 
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
@@ -244,7 +244,6 @@
 #define MAX_NR_MEMBLKS	1
 #endif /* CONFIG_NUMA */
 
-#include <asm/topology.h>
 /* Returns the number of the current Node. */
 #define numa_node_id()		(__cpu_to_node(smp_processor_id()))
 
@@ -252,13 +251,9 @@
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
 

--------------030407020609020905070404--

