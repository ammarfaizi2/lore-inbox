Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbTIPAlG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 20:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbTIPAlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 20:41:05 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:30369 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261712AbTIPAkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 20:40:23 -0400
Message-ID: <3F665B35.1090503@us.ibm.com>
Date: Mon, 15 Sep 2003 17:37:09 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@sgi.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, wli@holomorphy.com
Subject: [PATCH] Clean up MAX_NR_NODES/NUMNODES/etc. [4/5]
References: <20030910153601.36219ed8.akpm@osdl.org> <41000000.1063237600@flay> <20030911000303.GA20329@sgi.com> <3F6659DF.1090508@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------080206080104070503020800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080206080104070503020800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Matthew Dobson wrote:
> Ok, I made an attempt to clean up this mess quite a while ago (2.5.47), 
> but that patch is utterly useless now.  At Martin's urging I've created 
> a new series of patches to resolve this.
> 
> 01 - Make sure MAX_NUMNODES is defined in one and only one place. Remove 
> superfluous definitions.  Instead of defining MAX_NUMNODES in 
> asm/numnodes.h, we define NODES_SHIFT there.  Then in linux/mmzone.h we 
> turn that NODES_SHIFT value into MAX_NUMNODES.
> 
> 02 - Remove MAX_NR_NODES.  This value is only used in a couple of 
> places, and it's incorrectly used in all those places as far as I can 
> tell.  Replace with MAX_NUMNODES.  Create MAX_NODES_SHIFT and use this 
> value to check NODES_SHIFT is appropriate.  A possible future patch 
> should make MAX_NODES_SHIFT vary based on 32 vs. 64 bit archs.
> 
> 03 - Fix up the sh arch.  sh defined NR_NODES, change sh to use standard 
> MAX_NUMNODES instead.
> 
> 04 - Fix up the arm arch.  This needs to be reviewed.  Relatively 
> straightforward replacement of NR_NODES with standard MAX_NUMNODES.
> 
> 05 - Fix up the ia64 arch.  This *definitely* needs to be reviewed. This 
> code made my head hurt.  I think I may have gotten it right. Totally 
> untested.

Cheers!

-Matt

--------------080206080104070503020800
Content-Type: text/plain;
 name="04-fix-arm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="04-fix-arm.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5/arch/arm/mm/discontig.c linux-2.6.0-test5-nr_nodes/arch/arm/mm/discontig.c
--- linux-2.6.0-test5/arch/arm/mm/discontig.c	Mon Sep  8 12:50:22 2003
+++ linux-2.6.0-test5-nr_nodes/arch/arm/mm/discontig.c	Mon Sep 15 11:58:03 2003
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 #include <linux/bootmem.h>
 
-#if NR_NODES != 4
+#if MAX_NUMNODES != 4
 #error Fix Me Please
 #endif
 
@@ -23,9 +23,9 @@
  * Our node_data structure for discontiguous memory.
  */
 
-static bootmem_data_t node_bootmem_data[NR_NODES];
+static bootmem_data_t node_bootmem_data[MAX_NUMNODES];
 
-pg_data_t discontig_node_data[NR_NODES] = {
+pg_data_t discontig_node_data[MAX_NUMNODES] = {
   { .bdata = &node_bootmem_data[0] },
   { .bdata = &node_bootmem_data[1] },
   { .bdata = &node_bootmem_data[2] },
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5/arch/arm/mm/init.c linux-2.6.0-test5-nr_nodes/arch/arm/mm/init.c
--- linux-2.6.0-test5/arch/arm/mm/init.c	Mon Sep  8 12:49:52 2003
+++ linux-2.6.0-test5-nr_nodes/arch/arm/mm/init.c	Mon Sep 15 11:56:36 2003
@@ -33,12 +33,6 @@
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
@@ -178,7 +172,7 @@ find_memend_and_nodes(struct meminfo *mi
 {
 	unsigned int i, bootmem_pages = 0, memend_pfn = 0;
 
-	for (i = 0; i < NR_NODES; i++) {
+	for (i = 0; i < MAX_NUMNODES; i++) {
 		np[i].start = -1U;
 		np[i].end = 0;
 		np[i].bootmap_pages = 0;
@@ -207,7 +201,7 @@ find_memend_and_nodes(struct meminfo *mi
 			 * we have, we're in trouble.  (maybe we ought to
 			 * limit, instead of bugging?)
 			 */
-			if (numnodes > NR_NODES)
+			if (numnodes > MAX_NUMNODES)
 				BUG();
 		}
 
@@ -365,7 +359,7 @@ static inline void free_bootmem_node_ban
  */
 void __init bootmem_init(struct meminfo *mi)
 {
-	struct node_info node_info[NR_NODES], *np = node_info;
+	struct node_info node_info[MAX_NUMNODES], *np = node_info;
 	unsigned int bootmap_pages, bootmap_pfn, map_pg;
 	int node, initrd_node;
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5/include/asm-arm/arch-clps711x/memory.h linux-2.6.0-test5-nr_nodes/include/asm-arm/arch-clps711x/memory.h
--- linux-2.6.0-test5/include/asm-arm/arch-clps711x/memory.h	Mon Sep  8 12:49:51 2003
+++ linux-2.6.0-test5-nr_nodes/include/asm-arm/arch-clps711x/memory.h	Mon Sep 15 13:12:20 2003
@@ -109,8 +109,6 @@
  * 	node 3:  0xd8000000 - 0xdfffffff
  */
 
-#define NR_NODES	4
-
 /*
  * Given a kernel address, find the home node of the underlying memory.
  */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5/include/asm-arm/arch-sa1100/memory.h linux-2.6.0-test5-nr_nodes/include/asm-arm/arch-sa1100/memory.h
--- linux-2.6.0-test5/include/asm-arm/arch-sa1100/memory.h	Mon Sep  8 12:49:51 2003
+++ linux-2.6.0-test5-nr_nodes/include/asm-arm/arch-sa1100/memory.h	Mon Sep 15 13:12:26 2003
@@ -74,8 +74,6 @@
  * 	node 3:  0xd8000000 - 0xdfffffff
  */
 
-#define NR_NODES	4
-
 /*
  * Given a kernel address, find the home node of the underlying memory.
  */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5/include/asm-arm/memory.h linux-2.6.0-test5-nr_nodes/include/asm-arm/memory.h
--- linux-2.6.0-test5/include/asm-arm/memory.h	Mon Sep  8 12:50:28 2003
+++ linux-2.6.0-test5-nr_nodes/include/asm-arm/memory.h	Mon Sep 15 13:19:21 2003
@@ -89,6 +89,9 @@ static inline void *phys_to_virt(unsigne
  * This is more complex.  We have a set of mem_map arrays spread
  * around in memory.
  */
+#include <asm/numnodes.h>
+#define NUM_NODES	(1 << NODES_SHIFT)
+
 #define page_to_pfn(page)					\
 	(( (page) - page_zone(page)->zone_mem_map)		\
 	  + page_zone(page)->zone_start_pfn)
@@ -96,12 +99,12 @@ static inline void *phys_to_virt(unsigne
 #define pfn_to_page(pfn)					\
 	(PFN_TO_MAPBASE(pfn) + LOCAL_MAP_NR((pfn) << PAGE_SHIFT))
 
-#define pfn_valid(pfn)		(PFN_TO_NID(pfn) < NR_NODES)
+#define pfn_valid(pfn)		(PFN_TO_NID(pfn) < NUM_NODES)
 
 #define virt_to_page(kaddr)					\
 	(ADDR_TO_MAPBASE(kaddr) + LOCAL_MAP_NR(kaddr))
 
-#define virt_addr_valid(kaddr)	(KVADDR_TO_NID(kaddr) < NR_NODES)
+#define virt_addr_valid(kaddr)	(KVADDR_TO_NID(kaddr) < NUM_NODES)
 
 /*
  * Common discontigmem stuff.
@@ -109,6 +112,8 @@ static inline void *phys_to_virt(unsigne
  */
 #define PHYS_TO_NID(addr)	PFN_TO_NID((addr) >> PAGE_SHIFT)
 
+#undef NUM_NODES
+
 #endif
 
 /*
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5/include/asm-arm/numnodes.h linux-2.6.0-test5-nr_nodes/include/asm-arm/numnodes.h
--- linux-2.6.0-test5/include/asm-arm/numnodes.h	Mon Sep  8 12:50:02 2003
+++ linux-2.6.0-test5-nr_nodes/include/asm-arm/numnodes.h	Mon Sep 15 13:19:46 2003
@@ -10,8 +10,7 @@
 #ifndef __ASM_ARM_NUMNODES_H
 #define __ASM_ARM_NUMNODES_H
 
-#include <asm/memory.h>
-
-#define MAX_NUMNODES	NR_NODES
+/* Max 4 Nodes */
+#define NODES_SHIFT	2
 
 #endif

--------------080206080104070503020800--

