Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbULWWia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbULWWia (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 17:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbULWWia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 17:38:30 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:22197 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261320AbULWWhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 17:37:47 -0500
Subject: [RFC PATCH 2/10] Replace 'numnodes' with 'node_online_map' - arm
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: LSE Tech <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1103838712.3945.12.camel@arrakis>
References: <1103838712.3945.12.camel@arrakis>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1103841457.3945.20.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 23 Dec 2004 14:37:37 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2/10 - Replace numnodes with node_online_map for arm

[mcd@arrakis node_online_map]$ diffstat arch-arm.patch
 arch/arm/mm/init.c                |   34 +++++++++++++++-------------------
 arch/arm/mm/mm-armv.c             |    2 +-
 arch/arm26/mm/init.c              |    3 ++-
 include/asm-arm/arch-pxa/memory.h |    2 --
 4 files changed, 18 insertions(+), 23 deletions(-)


-Matt

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/arm/mm/init.c linux-2.6.10-rc3-mm1-nom.arm/arch/arm/mm/init.c
--- linux-2.6.10-rc3-mm1/arch/arm/mm/init.c	2004-12-13 16:22:55.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.arm/arch/arm/mm/init.c	2004-12-15 16:17:24.000000000 -0800
@@ -55,7 +55,7 @@ void show_mem(void)
 	show_free_areas();
 	printk("Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		struct page *page, *end;
 
 		page = NODE_MEM_MAP(node);
@@ -178,18 +178,14 @@ find_memend_and_nodes(struct meminfo *mi
 
 		node = mi->bank[i].node;
 
-		if (node >= numnodes) {
-			numnodes = node + 1;
-
-			/*
-			 * Make sure we haven't exceeded the maximum number
-			 * of nodes that we have in this configuration.  If
-			 * we have, we're in trouble.  (maybe we ought to
-			 * limit, instead of bugging?)
-			 */
-			if (numnodes > MAX_NUMNODES)
-				BUG();
-		}
+		/*
+		 * Make sure we haven't exceeded the maximum number of nodes
+		 * that we have in this configuration.  If we have, we're in
+		 * trouble.  (maybe we ought to limit, instead of bugging?)
+		 */
+		if (node >= MAX_NUMNODES)
+			BUG();
+		node_set_online(node);
 
 		/*
 		 * Get the start and end pfns for this bank
@@ -211,7 +207,7 @@ find_memend_and_nodes(struct meminfo *mi
 	 * Calculate the number of pages we require to
 	 * store the bootmem bitmaps.
 	 */
-	for (i = 0; i < numnodes; i++) {
+	for_each_online_node(i) {
 		if (np[i].end == 0)
 			continue;
 
@@ -380,13 +376,13 @@ static void __init bootmem_init(struct m
 	 * (we could also do with rolling bootmem_init and paging_init
 	 * into one generic "memory_init" type function).
 	 */
-	np += numnodes - 1;
-	for (node = numnodes - 1; node >= 0; node--, np--) {
+	np += num_online_nodes() - 1;
+	for (node = num_online_nodes() - 1; node >= 0; node--, np--) {
 		/*
 		 * If there are no pages in this node, ignore it.
 		 * Note that node 0 must always have some pages.
 		 */
-		if (np->end == 0) {
+		if (np->end == 0 || !node_online(node)) {
 			if (node == 0)
 				BUG();
 			continue;
@@ -449,7 +445,7 @@ void __init paging_init(struct meminfo *
 	/*
 	 * initialise the zones within each node
 	 */
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		unsigned long zone_size[MAX_NR_ZONES];
 		unsigned long zhole_size[MAX_NR_ZONES];
 		struct bootmem_data *bdata;
@@ -558,7 +554,7 @@ void __init mem_init(void)
 		create_memmap_holes(&meminfo);
 
 	/* this will put all unused low memory onto the freelists */
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		pg_data_t *pgdat = NODE_DATA(node);
 
 		if (pgdat->node_spanned_pages != 0)
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/arm/mm/mm-armv.c linux-2.6.10-rc3-mm1-nom.arm/arch/arm/mm/mm-armv.c
--- linux-2.6.10-rc3-mm1/arch/arm/mm/mm-armv.c	2004-12-13 16:22:55.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.arm/arch/arm/mm/mm-armv.c	2004-12-14 11:57:16.000000000 -0800
@@ -681,6 +681,6 @@ void __init create_memmap_holes(struct m
 {
 	int node;
 
-	for (node = 0; node < numnodes; node++)
+	for_each_online_node(node)
 		free_unused_memmap_node(node, mi);
 }
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/arm26/mm/init.c linux-2.6.10-rc3-mm1-nom.arm/arch/arm26/mm/init.c
--- linux-2.6.10-rc3-mm1/arch/arm26/mm/init.c	2004-12-13 16:22:26.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.arm/arch/arm26/mm/init.c	2004-12-14 11:57:16.000000000 -0800
@@ -156,7 +156,8 @@ find_memend_and_nodes(struct meminfo *mi
 {
 	unsigned int memend_pfn = 0;
 
-	numnodes = 1;
+	nodes_clear(node_online_map);
+	node_set_online(0);
 
 	np->bootmap_pages = 0;
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/include/asm-arm/arch-pxa/memory.h linux-2.6.10-rc3-mm1-nom.arm/include/asm-arm/arch-pxa/memory.h
--- linux-2.6.10-rc3-mm1/include/asm-arm/arch-pxa/memory.h	2004-12-13 16:23:59.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.arm/include/asm-arm/arch-pxa/memory.h	2004-12-16 14:21:50.000000000 -0800
@@ -37,8 +37,6 @@
  * 	node 3:  0xac000000-0xafffffff	-->  0xcc000000-0xcfffffff
  */
 
-#define NR_NODES	4
-
 /*
  * Given a kernel address, find the home node of the underlying memory.
  */


