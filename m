Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVB1S6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVB1S6Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 13:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVB1S5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 13:57:18 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:48818 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261714AbVB1Syo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 13:54:44 -0500
Subject: [PATCH 4/5] allow SRAT to parse empty nodes
To: linux-mm@kvack.org
Cc: akpm@osdl.org, kmannth@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>, ygoto@us.fujitsu.com,
       apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 28 Feb 2005 10:54:40 -0800
Message-Id: <E1D5q2T-0007if-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is to allow the booting of a numa srat base i386 system
without requiring memory to be in all of it's nodes.  It breaks the
assumption that all nodes have memory during bootup.

Signed-off-by: Keith Mannthey <kmannth@us.ibm.com>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 sparse-dave/arch/i386/kernel/numaq.c    |    4 +---
 sparse-dave/arch/i386/kernel/srat.c     |   14 ++++++++++++--
 sparse-dave/arch/i386/mm/discontig.c    |   32 +++++++++++++++++++-------------
 sparse-dave/include/asm-i386/topology.h |    6 ++++++
 sparse-dave/include/linux/topology.h    |    5 ++++-
 5 files changed, 42 insertions(+), 19 deletions(-)

diff -puN arch/i386/kernel/srat.c~A3.2-fix_nomem_on_node arch/i386/kernel/srat.c
--- sparse/arch/i386/kernel/srat.c~A3.2-fix_nomem_on_node	2005-02-24 08:56:40.000000000 -0800
+++ sparse-dave/arch/i386/kernel/srat.c	2005-02-24 08:56:40.000000000 -0800
@@ -30,6 +30,7 @@
 #include <linux/acpi.h>
 #include <linux/nodemask.h>
 #include <asm/srat.h>
+#include <asm/topology.h>
 
 /*
  * proximity macros and definitions
@@ -58,8 +59,6 @@ static int num_memory_chunks;		/* total 
 static int zholes_size_init;
 static unsigned long zholes_size[MAX_NUMNODES * MAX_NR_ZONES];
 
-extern unsigned long node_start_pfn[], node_end_pfn[], node_remap_size[];
-
 extern void * boot_ioremap(unsigned long, unsigned long);
 
 /* Identify CPU proximity domains */
@@ -273,6 +272,17 @@ static int __init acpi20_parse_srat(stru
 		int been_here_before = 0;
 
 		for (j = 0; j < num_memory_chunks; j++){
+			/*
+			 * Only add present memroy to node_end/start_pfn
+			 * There is no guarantee from the srat that the memory
+			 * is present at boot time.
+			 */
+			if (node_memory_chunk[j].start_pfn >= max_pfn) {
+				printk (KERN_INFO "Ignoring chunk of memory reported in the SRAT (could be hot-add zone?)\n");
+				printk (KERN_INFO "chunk is reported from pfn %04x to %04x\n",
+					node_memory_chunk[j].start_pfn, node_memory_chunk[j].end_pfn);
+				continue;
+			}
 			if (node_memory_chunk[j].nid == nid) {
 				if (been_here_before == 0) {
 					node_start_pfn[nid] = node_memory_chunk[j].start_pfn;
diff -puN arch/i386/mm/discontig.c~A3.2-fix_nomem_on_node arch/i386/mm/discontig.c
--- sparse/arch/i386/mm/discontig.c~A3.2-fix_nomem_on_node	2005-02-24 08:56:40.000000000 -0800
+++ sparse-dave/arch/i386/mm/discontig.c	2005-02-24 08:56:40.000000000 -0800
@@ -154,7 +154,7 @@ static void __init find_max_pfn_node(int
  */
 static void __init allocate_pgdat(int nid)
 {
-	if (nid)
+	if (nid && node_has_online_mem(nid))
 		NODE_DATA(nid) = (pg_data_t *)node_remap_start_vaddr[nid];
 	else {
 		NODE_DATA(nid) = (pg_data_t *)(__va(min_low_pfn << PAGE_SHIFT));
@@ -188,6 +188,9 @@ static unsigned long calculate_numa_rema
 	for_each_online_node(nid) {
 		if (nid == 0)
 			continue;
+		if (!node_remap_size[nid])
+			continue;
+
 		/* ensure the remap includes space for the pgdat. */
 		size = node_remap_size[nid] + sizeof(pg_data_t);
 
@@ -299,24 +302,27 @@ void __init zone_sizes_init(void)
 
 		max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 
-		if (start > low) {
+		if (node_has_online_mem(nid)){
+			if (start > low) {
 #ifdef CONFIG_HIGHMEM
-			BUG_ON(start > high);
-			zones_size[ZONE_HIGHMEM] = high - start;
+				BUG_ON(start > high);
+				zones_size[ZONE_HIGHMEM] = high - start;
 #endif
-		} else {
-			if (low < max_dma)
-				zones_size[ZONE_DMA] = low;
-			else {
-				BUG_ON(max_dma > low);
-				BUG_ON(low > high);
-				zones_size[ZONE_DMA] = max_dma;
-				zones_size[ZONE_NORMAL] = low - max_dma;
+			} else {
+				if (low < max_dma)
+					zones_size[ZONE_DMA] = low;
+				else {
+					BUG_ON(max_dma > low);
+					BUG_ON(low > high);
+					zones_size[ZONE_DMA] = max_dma;
+					zones_size[ZONE_NORMAL] = low - max_dma;
 #ifdef CONFIG_HIGHMEM
-				zones_size[ZONE_HIGHMEM] = high - low;
+					zones_size[ZONE_HIGHMEM] = high - low;
 #endif
+				}
 			}
 		}
+
 		zholes_size = get_zholes_size(nid);
 		/*
 		 * We let the lmem_map for node 0 be allocated from the
diff -puN include/asm-i386/topology.h~A3.2-fix_nomem_on_node include/asm-i386/topology.h
--- sparse/include/asm-i386/topology.h~A3.2-fix_nomem_on_node	2005-02-24 08:56:40.000000000 -0800
+++ sparse-dave/include/asm-i386/topology.h	2005-02-24 08:56:40.000000000 -0800
@@ -88,6 +88,12 @@ static inline cpumask_t pcibus_to_cpumas
 	.nr_balance_failed	= 0,			\
 }
 
+extern unsigned long node_start_pfn[];
+extern unsigned long node_end_pfn[];
+extern unsigned long node_remap_size[];
+
+#define node_has_online_mem(nid) (node_start_pfn[nid] != node_end_pfn[nid])
+
 #else /* !CONFIG_NUMA */
 /*
  * Other i386 platforms should define their own version of the 
diff -puN include/linux/topology.h~A3.2-fix_nomem_on_node include/linux/topology.h
--- sparse/include/linux/topology.h~A3.2-fix_nomem_on_node	2005-02-24 08:56:40.000000000 -0800
+++ sparse-dave/include/linux/topology.h	2005-02-24 08:56:40.000000000 -0800
@@ -31,9 +31,12 @@
 #include <linux/bitops.h>
 #include <linux/mmzone.h>
 #include <linux/smp.h>
-
 #include <asm/topology.h>
 
+#ifndef node_has_online_mem
+#define node_has_online_mem(nid) (1)
+#endif
+
 #ifndef nr_cpus_node
 #define nr_cpus_node(node)							\
 	({									\
diff -puN arch/i386/kernel/numaq.c~A3.2-fix_nomem_on_node arch/i386/kernel/numaq.c
--- sparse/arch/i386/kernel/numaq.c~A3.2-fix_nomem_on_node	2005-02-24 08:56:40.000000000 -0800
+++ sparse-dave/arch/i386/kernel/numaq.c	2005-02-24 08:56:40.000000000 -0800
@@ -30,9 +30,7 @@
 #include <linux/module.h>
 #include <linux/nodemask.h>
 #include <asm/numaq.h>
-
-/* These are needed before the pgdat's are created */
-extern long node_start_pfn[], node_end_pfn[], node_remap_size[];
+#include <asm/topology.h>
 
 #define	MB_TO_PAGES(addr) ((addr) << (20 - PAGE_SHIFT))
 
_
