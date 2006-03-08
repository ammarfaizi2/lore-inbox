Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752100AbWCHNmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbWCHNmk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbWCHNmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:42:07 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:23946 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751951AbWCHNl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:41:58 -0500
Date: Wed, 08 Mar 2006 22:41:55 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH: 006/017](RFC) Memory hotplug for new nodes v.3. (move out pgdat array from mem_data for ia64)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org,
       linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060308212845.002E.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is preparing patch for updating of NODE_DATA() to make common code
of ia64 between boottime and hotplug.

Current code remembers pgdat address in mem_data which is used at just boot
time. But its information can be used at hotplug time
by moving to global value.
The following patche use this array.


Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: pgdat6/arch/ia64/mm/discontig.c
===================================================================
--- pgdat6.orig/arch/ia64/mm/discontig.c	2006-03-06 18:25:31.000000000 +0900
+++ pgdat6/arch/ia64/mm/discontig.c	2006-03-06 18:26:07.000000000 +0900
@@ -33,7 +33,6 @@
  */
 struct early_node_data {
 	struct ia64_node_data *node_data;
-	pg_data_t *pgdat;
 	unsigned long pernode_addr;
 	unsigned long pernode_size;
 	struct bootmem_data bootmem_data;
@@ -46,6 +45,8 @@ struct early_node_data {
 static struct early_node_data mem_data[MAX_NUMNODES] __initdata;
 static nodemask_t memory_less_mask __initdata;
 
+static pg_data_t *pgdat_list[MAX_NUMNODES];
+
 /*
  * To prevent cache aliasing effects, align per-node structures so that they
  * start at addresses that are strided by node number.
@@ -175,13 +176,13 @@ static void __init fill_pernode(int node
 	pernode += PERCPU_PAGE_SIZE * cpus;
 	pernode += node * L1_CACHE_BYTES;
 
-	mem_data[node].pgdat = __va(pernode);
+	pgdat_list[node] = __va(pernode);
 	pernode += L1_CACHE_ALIGN(sizeof(pg_data_t));
 
 	mem_data[node].node_data = __va(pernode);
 	pernode += L1_CACHE_ALIGN(sizeof(struct ia64_node_data));
 
-	mem_data[node].pgdat->bdata = bdp;
+	pgdat_list[node]->bdata = bdp;
 	pernode += L1_CACHE_ALIGN(sizeof(pg_data_t));
 
 	cpu_data = per_cpu_node_setup(cpu_data, node);
@@ -268,7 +269,7 @@ static int __init find_pernode_space(uns
 static int __init free_node_bootmem(unsigned long start, unsigned long len,
 				    int node)
 {
-	free_bootmem_node(mem_data[node].pgdat, start, len);
+	free_bootmem_node(pgdat_list[node], start, len);
 
 	return 0;
 }
@@ -287,7 +288,7 @@ static void __init reserve_pernode_space
 	int node;
 
 	for_each_online_node(node) {
-		pg_data_t *pdp = mem_data[node].pgdat;
+		pg_data_t *pdp = pgdat_list[node];
 
 		if (node_isset(node, memory_less_mask))
 			continue;
@@ -317,12 +318,8 @@ static void __init reserve_pernode_space
  */
 static void __init initialize_pernode_data(void)
 {
-	pg_data_t *pgdat_list[MAX_NUMNODES];
 	int cpu, node;
 
-	for_each_online_node(node)
-		pgdat_list[node] = mem_data[node].pgdat;
-
 	/* Copy the pg_data_t list to each node and init the node field */
 	for_each_online_node(node) {
 		memcpy(mem_data[node].node_data->pg_data_ptrs, pgdat_list,
@@ -372,7 +369,7 @@ static void __init *memory_less_node_all
 	if (bestnode == -1)
 		bestnode = anynode;
 
-	ptr = __alloc_bootmem_node(mem_data[bestnode].pgdat, pernodesize,
+	ptr = __alloc_bootmem_node(pgdat_list[bestnode], pernodesize,
 		PERCPU_PAGE_SIZE, __pa(MAX_DMA_ADDRESS));
 
 	return ptr;
@@ -476,7 +473,7 @@ void __init find_memory(void)
 		pernodesize = mem_data[node].pernode_size;
 		map = pernode + pernodesize;
 
-		init_bootmem_node(mem_data[node].pgdat,
+		init_bootmem_node(pgdat_list[node],
 				  map>>PAGE_SHIFT,
 				  bdp->node_boot_start>>PAGE_SHIFT,
 				  bdp->node_low_pfn);

-- 
Yasunori Goto 


