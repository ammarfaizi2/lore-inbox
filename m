Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264973AbUGBWVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbUGBWVX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 18:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUGBWVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 18:21:23 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:10398 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264973AbUGBWVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 18:21:15 -0400
Date: Fri, 02 Jul 2004 15:20:29 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix up physnode_map
Message-ID: <163080000.1088806829@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, we initialise physnode_map from the various BIOS tables,
which can create problems, as holes inside an node return 1 for pfn_valid,
and yet pfn_to_nid is not correct for them. I'd hacked around this in my
tree by defaulting the mapping to 0, not -1, but that's not the correct
fix ... this is.

I consolidated all the code back into 1 place, and use node_start_pfn[]
and node_end_pfn[] to walk over it instead - that means it matches up
perfectly with lmem_map's as we're using the same data. It also cleans
up a lot of the code.

Tested on both NUMA-Q and x440 ... and it only affects i386 NUMA boxen.

diff -purN -X /home/mbligh/.diff.exclude signed_physnode_map/arch/i386/kernel/numaq.c physnode_map/arch/i386/kernel/numaq.c
--- signed_physnode_map/arch/i386/kernel/numaq.c	Thu Jul  1 15:32:09 2004
+++ physnode_map/arch/i386/kernel/numaq.c	Thu Jul  1 15:20:27 2004
@@ -65,41 +65,6 @@ static void __init smp_dump_qct(void)
 }
 
 /*
- * for each node mark the regions
- *        TOPOFMEM = hi_shrd_mem_start + hi_shrd_mem_size
- *
- * need to be very careful to not mark 1024+ as belonging
- * to node 0. will want 1027 to show as belonging to node 1
- * example:
- *  TOPOFMEM = 1024
- * 1024 >> 8 = 4 (subtract 1 for starting at 0]
- * tmpvar = TOPOFMEM - 256 = 768
- * 1024 >> 8 = 4 (subtract 1 for starting at 0]
- * 
- */
-static void __init initialize_physnode_map(void)
-{
-	int nid;
-	unsigned int topofmem, cur;
-	struct eachquadmem *eq;
- 	struct sys_cfg_data *scd =
-		(struct sys_cfg_data *)__va(SYS_CFG_DATA_PRIV_ADDR);
-
-	
-	for(nid = 0; nid < numnodes; nid++) {
-		if(scd->quads_present31_0 & (1 << nid)) {
-			eq = &scd->eq[nid];
-			cur = eq->hi_shrd_mem_start;
-			topofmem = eq->hi_shrd_mem_start + eq->hi_shrd_mem_size;
-			while (cur < topofmem) {
-				physnode_map[cur >> 8] = (s8) nid;
-				cur ++;
-			}
-		}
-	}
-}
-
-/*
  * Unlike Summit, we don't really care to let the NUMA-Q
  * fall back to flat mode.  Don't compile for NUMA-Q
  * unless you really need it!
@@ -107,6 +72,5 @@ static void __init initialize_physnode_m
 int __init get_memcfg_numaq(void)
 {
 	smp_dump_qct();
-	initialize_physnode_map();
 	return 1;
 }
diff -purN -X /home/mbligh/.diff.exclude signed_physnode_map/arch/i386/kernel/srat.c physnode_map/arch/i386/kernel/srat.c
--- signed_physnode_map/arch/i386/kernel/srat.c	Thu Jul  1 15:32:09 2004
+++ physnode_map/arch/i386/kernel/srat.c	Thu Jul  1 15:21:17 2004
@@ -181,23 +181,6 @@ static __init void chunk_to_zones(unsign
 	}
 }
 
-static void __init initialize_physnode_map(void)
-{
-	int i;
-	unsigned long pfn;
-	struct node_memory_chunk_s *nmcp;
-
-	/* Run the list of memory chunks and fill in the phymap. */
-	nmcp = node_memory_chunk;
-	for (i = num_memory_chunks; --i >= 0; nmcp++) {
-		for (pfn = nmcp->start_pfn; pfn <= nmcp->end_pfn;
-						pfn += PAGES_PER_ELEMENT)
-		{
-			physnode_map[pfn / PAGES_PER_ELEMENT] = (s8) nmcp->nid;
-		}
-	}
-}
-
 /* Parse the ACPI Static Resource Affinity Table */
 static int __init acpi20_parse_srat(struct acpi_table_srat *sratp)
 {
@@ -265,8 +248,6 @@ static int __init acpi20_parse_srat(stru
 	for (i = 0; i < num_memory_chunks; i++)
 		node_memory_chunk[i].nid = pxm_to_nid_map[node_memory_chunk[i].pxm];
 
-	initialize_physnode_map();
-	
 	printk("pxm bitmap: ");
 	for (i = 0; i < sizeof(pxm_bitmap); i++) {
 		printk("%02X ", pxm_bitmap[i]);
diff -purN -X /home/mbligh/.diff.exclude signed_physnode_map/arch/i386/mm/discontig.c physnode_map/arch/i386/mm/discontig.c
--- signed_physnode_map/arch/i386/mm/discontig.c	Thu Jul  1 15:32:09 2004
+++ physnode_map/arch/i386/mm/discontig.c	Fri Jul  2 10:19:51 2004
@@ -87,8 +87,6 @@ void set_pmd_pfn(unsigned long vaddr, un
  */
 int __init get_memcfg_numa_flat(void)
 {
-	int pfn;
-
 	printk("NUMA - single node, flat memory mode\n");
 
 	/* Run the memory configuration and find the top of memory. */
@@ -96,16 +94,7 @@ int __init get_memcfg_numa_flat(void)
 	node_start_pfn[0]  = 0;
 	node_end_pfn[0]	  = max_pfn;
 
-	/* Fill in the physnode_map with our simplistic memory model,
-	* all memory is in node 0.
-	*/
-	for (pfn = node_start_pfn[0]; pfn <= node_end_pfn[0];
-	       pfn += PAGES_PER_ELEMENT)
-	{
-		physnode_map[pfn / PAGES_PER_ELEMENT] = 0;
-	}
-
-         /* Indicate there is one node available. */
+        /* Indicate there is one node available. */
 	node_set_online(0);
 	numnodes = 1;
 	return 1;
@@ -231,9 +220,24 @@ unsigned long __init setup_memory(void)
 {
 	int nid;
 	unsigned long bootmap_size, system_start_pfn, system_max_low_pfn;
-	unsigned long reserve_pages;
+	unsigned long reserve_pages, pfn;
 
 	get_memcfg_numa();
+
+	/* Fill in the physnode_map */
+	for (nid = 0; nid < numnodes; nid++) {
+		printk("Node: %d, start_pfn: %ld, end_pfn: %ld\n",
+				nid, node_start_pfn[nid], node_end_pfn[nid]);
+		printk("  Setting physnode_map array to node %d for pfns:\n  ",
+				nid);
+		for (pfn = node_start_pfn[nid]; pfn < node_end_pfn[nid];
+	       				pfn += PAGES_PER_ELEMENT) {
+			physnode_map[pfn / PAGES_PER_ELEMENT] = nid;
+			printk("%ld ", pfn);
+		}
+		printk("\n");
+	}
+
 	reserve_pages = calculate_numa_remap_pages();
 
 	/* partially used pages are not usable - thus round upwards */

