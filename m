Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbULWWkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbULWWkk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 17:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbULWWkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 17:40:40 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:4749 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261321AbULWWji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 17:39:38 -0500
Subject: [RFC PATCH 3/10] Replace 'numnodes' with 'node_online_map' - i386
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: LSE Tech <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1103838712.3945.12.camel@arrakis>
References: <1103838712.3945.12.camel@arrakis>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1103841575.3945.23.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 23 Dec 2004 14:39:35 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

3/10 - Replace numnodes with node_online_map for i386

[mcd@arrakis node_online_map]$ diffstat arch-i386.patch
 arch/i386/kernel/mpparse.c              |    4 ++--
 arch/i386/kernel/numaq.c                |   10 ++++------
 arch/i386/kernel/srat.c                 |   32 ++++++++++++++++++--------------
 arch/i386/mm/discontig.c                |   28 +++++++++++++++++-----------
 arch/i386/pci/numa.c                    |    7 ++++---
 include/asm-i386/mach-numaq/mach_apic.h |   10 ++++++----
 6 files changed, 51 insertions(+), 40 deletions(-)


-Matt

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/i386/kernel/mpparse.c linux-2.6.10-rc3-mm1-nom.i386/arch/i386/kernel/mpparse.c
--- linux-2.6.10-rc3-mm1/arch/i386/kernel/mpparse.c	2004-12-13 16:21:50.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.i386/arch/i386/kernel/mpparse.c	2004-12-16 11:41:35.000000000 -0800
@@ -309,8 +309,8 @@ static void __init MP_translation_info (
 		printk(KERN_ERR "MAX_MPC_ENTRY exceeded!\n");
 	else
 		translation_table[mpc_record] = m; /* stash this for later */
-	if (m->trans_quad+1 > numnodes)
-		numnodes = m->trans_quad+1;
+	if (m->trans_quad < MAX_NUMNODES && !node_online(m->trans_quad))
+		node_set_online(m->trans_quad);
 }
 
 /*
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/i386/kernel/numaq.c linux-2.6.10-rc3-mm1-nom.i386/arch/i386/kernel/numaq.c
--- linux-2.6.10-rc3-mm1/arch/i386/kernel/numaq.c	2004-12-13 16:21:50.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.i386/arch/i386/kernel/numaq.c	2004-12-16 11:44:44.000000000 -0800
@@ -40,8 +40,7 @@ extern long node_start_pfn[], node_end_p
  * Function: smp_dump_qct()
  *
  * Description: gets memory layout from the quad config table.  This
- * function also increments numnodes with the number of nodes (quads)
- * present.
+ * function also updates node_online_map with the nodes (quads) present.
  */
 static void __init smp_dump_qct(void)
 {
@@ -50,11 +49,10 @@ static void __init smp_dump_qct(void)
 	struct sys_cfg_data *scd =
 		(struct sys_cfg_data *)__va(SYS_CFG_DATA_PRIV_ADDR);
 
-	numnodes = 0;
-	for(node = 0; node < MAX_NUMNODES; node++) {
-		if(scd->quads_present31_0 & (1 << node)) {
+	nodes_clear(node_online_map);
+	for_each_node(node) {
+		if (scd->quads_present31_0 & (1 << node)) {
 			node_set_online(node);
-			numnodes++;
 			eq = &scd->eq[node];
 			/* Convert to pages */
 			node_start_pfn[node] = MB_TO_PAGES(
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/i386/kernel/srat.c linux-2.6.10-rc3-mm1-nom.i386/arch/i386/kernel/srat.c
--- linux-2.6.10-rc3-mm1/arch/i386/kernel/srat.c	2004-12-13 16:21:50.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.i386/arch/i386/kernel/srat.c	2004-12-16 17:12:38.000000000 -0800
@@ -232,18 +232,22 @@ static int __init acpi20_parse_srat(stru
 	 * a set of sequential node IDs starting at zero.  (ACPI doesn't seem
 	 * to specify the range of _PXM values.)
 	 */
-	numnodes = 0;		/* init total nodes in system */
+	/*
+	 * MCD - we no longer HAVE to number nodes sequentially.  PXM domain
+	 * numbers could go as high as 256, and MAX_NUMNODES for i386 is typically
+	 * 32, so we will continue numbering them in this manner until MAX_NUMNODES
+	 * approaches MAX_PXM_DOMAINS for i386.
+	 */
+	nodes_clear(node_online_map);
 	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
 		if (BMAP_TEST(pxm_bitmap, i)) {
-			pxm_to_nid_map[i] = numnodes;
-			nid_to_pxm_map[numnodes] = i;
-			node_set_online(numnodes);
-			++numnodes;
+			nid = num_online_nodes();
+			pxm_to_nid_map[i] = nid;
+			nid_to_pxm_map[nid] = i;
+			node_set_online(nid);
 		}
 	}
-
-	if (numnodes == 0)
-		BUG();
+	BUG_ON(num_online_nodes() == 0);
 
 	/* set cnode id in memory chunk structure */
 	for (i = 0; i < num_memory_chunks; i++)
@@ -254,7 +258,7 @@ static int __init acpi20_parse_srat(stru
 		printk("%02X ", pxm_bitmap[i]);
 	}
 	printk("\n");
-	printk("Number of logical nodes in system = %d\n", numnodes);
+	printk("Number of logical nodes in system = %d\n", num_online_nodes());
 	printk("Number of memory chunks in system = %d\n", num_memory_chunks);
 
 	for (j = 0; j < num_memory_chunks; j++){
@@ -265,7 +269,7 @@ static int __init acpi20_parse_srat(stru
 	}
  
 	/*calculate node_start_pfn/node_end_pfn arrays*/
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		int been_here_before = 0;
 
 		for (j = 0; j < num_memory_chunks; j++){
@@ -397,7 +401,7 @@ static void __init get_zholes_init(void)
 	int first;
 	unsigned long end = 0;
 
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		first = 1;
 		for (c = 0; c < num_memory_chunks; c++){
 			if (node_memory_chunk[c].nid == nid) {
@@ -425,8 +429,8 @@ unsigned long * __init get_zholes_size(i
 		zholes_size_init++;
 		get_zholes_init();
 	}
-	if((nid >= numnodes) | (nid >= MAX_NUMNODES))
-		printk("%s: nid = %d is invalid. numnodes = %d",
-		       __FUNCTION__, nid, numnodes);
+	if (nid >= MAX_NUMNODES || !node_online(nid))
+		printk("%s: nid = %d is invalid/offline. num_online_nodes = %d",
+		       __FUNCTION__, nid, num_online_nodes());
 	return &zholes_size[nid * MAX_NR_ZONES];
 }
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/i386/mm/discontig.c linux-2.6.10-rc3-mm1-nom.i386/arch/i386/mm/discontig.c
--- linux-2.6.10-rc3-mm1/arch/i386/mm/discontig.c	2004-12-13 16:21:52.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.i386/arch/i386/mm/discontig.c	2004-12-16 12:00:52.000000000 -0800
@@ -42,7 +42,7 @@ bootmem_data_t node0_bdata;
  * numa interface - we expect the numa architecture specfic code to have
  *                  populated the following initialisation.
  *
- * 1) numnodes         - the total number of nodes configured in the system
+ * 1) node_online_map  - the map of all nodes configured (online) in the system
  * 2) physnode_map     - the mapping between a pfn and owning node
  * 3) node_start_pfn   - the starting page frame number for a node
  * 3) node_end_pfn     - the ending page fram number for a node
@@ -94,12 +94,12 @@ int __init get_memcfg_numa_flat(void)
 
 	/* Run the memory configuration and find the top of memory. */
 	find_max_pfn();
-	node_start_pfn[0]  = 0;
-	node_end_pfn[0]	  = max_pfn;
+	node_start_pfn[0] = 0;
+	node_end_pfn[0] = max_pfn;
 
         /* Indicate there is one node available. */
+	nodes_clear(node_online_map);
 	node_set_online(0);
-	numnodes = 1;
 	return 1;
 }
 
@@ -184,7 +184,9 @@ void __init remap_numa_kva(void)
 	unsigned long pfn;
 	int node;
 
-	for (node = 1; node < numnodes; ++node) {
+	for_each_online_node(node) {
+		if (node == 0)
+			continue;
 		for (pfn=0; pfn < node_remap_size[node]; pfn += PTRS_PER_PTE) {
 			vaddr = node_remap_start_vaddr[node]+(pfn<<PAGE_SHIFT);
 			set_pmd_pfn((ulong) vaddr, 
@@ -199,7 +201,9 @@ static unsigned long calculate_numa_rema
 	int nid;
 	unsigned long size, reserve_pages = 0;
 
-	for (nid = 1; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
+		if (nid == 0)
+			continue;
 		/* calculate the size of the mem_map needed in bytes */
 		size = (node_end_pfn[nid] - node_start_pfn[nid] + 1) 
 			* sizeof(struct page) + sizeof(pg_data_t);
@@ -249,7 +253,7 @@ unsigned long __init setup_memory(void)
 	get_memcfg_numa();
 
 	/* Fill in the physnode_map */
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		printk("Node: %d, start_pfn: %ld, end_pfn: %ld\n",
 				nid, node_start_pfn[nid], node_end_pfn[nid]);
 		printk("  Setting physnode_map array to node %d for pfns:\n  ",
@@ -286,7 +290,7 @@ unsigned long __init setup_memory(void)
 
 	printk("Low memory ends at vaddr %08lx\n",
 			(ulong) pfn_to_kaddr(max_low_pfn));
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		node_remap_start_vaddr[nid] = pfn_to_kaddr(
 			(highstart_pfn + reserve_pages) - node_remap_offset[nid]);
 		allocate_pgdat(nid);
@@ -298,7 +302,7 @@ unsigned long __init setup_memory(void)
 	printk("High memory starts at vaddr %08lx\n",
 			(ulong) pfn_to_kaddr(highstart_pfn));
 	vmalloc_earlyreserve = reserve_pages * PAGE_SIZE;
-	for (nid = 0; nid < numnodes; nid++)
+	for_each_online_node(nid)
 		find_max_pfn_node(nid);
 
 	NODE_DATA(0)->bdata = &node0_bdata;
@@ -379,14 +383,16 @@ void __init zone_sizes_init(void)
 	 * Clobber node 0's links and NULL out pgdat_list before starting.
 	 */
 	pgdat_list = NULL;
-	for (nid = numnodes - 1; nid >= 0; nid--) {       
+	for (nid = MAX_NUMNODES - 1; nid >= 0; nid--) {
+		if (!node_online(nid))
+			continue;
 		if (nid)
 			memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
 		NODE_DATA(nid)->pgdat_next = pgdat_list;
 		pgdat_list = NODE_DATA(nid);
 	}
 
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
 		unsigned long *zholes_size;
 		unsigned int max_dma;
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/i386/pci/numa.c linux-2.6.10-rc3-mm1-nom.i386/arch/i386/pci/numa.c
--- linux-2.6.10-rc3-mm1/arch/i386/pci/numa.c	2004-12-13 16:21:53.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.i386/arch/i386/pci/numa.c	2004-12-16 12:04:17.000000000 -0800
@@ -112,14 +112,15 @@ static int __init pci_numa_init(void)
 		return 0;
 
 	pci_root_bus = pcibios_scan_root(0);
-	if (numnodes > 1) {
-		for (quad = 1; quad < numnodes; ++quad) {
+	if (num_online_nodes() > 1)
+		for_each_online_node(quad) {
+			if (quad == 0)
+				continue;
 			printk("Scanning PCI bus %d for quad %d\n", 
 				QUADLOCAL2BUS(quad,0), quad);
 			pci_scan_bus(QUADLOCAL2BUS(quad,0), 
 				&pci_root_ops, NULL);
 		}
-	}
 	return 0;
 }
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/include/asm-i386/mach-numaq/mach_apic.h linux-2.6.10-rc3-mm1-nom.i386/include/asm-i386/mach-numaq/mach_apic.h
--- linux-2.6.10-rc3-mm1/include/asm-i386/mach-numaq/mach_apic.h	2004-12-13 16:24:09.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.i386/include/asm-i386/mach-numaq/mach_apic.h	2004-12-16 12:06:26.000000000 -0800
@@ -112,13 +112,15 @@ static inline int mpc_apic_id(struct mpc
 
 static inline void setup_portio_remap(void)
 {
-	if (numnodes <= 1)
+	int num_quads = num_online_nodes();
+
+	if (num_quads <= 1)
        		return;
 
-	printk("Remapping cross-quad port I/O for %d quads\n", numnodes);
-	xquad_portio = ioremap (XQUAD_PORTIO_BASE, numnodes*XQUAD_PORTIO_QUAD);
+	printk("Remapping cross-quad port I/O for %d quads\n", num_quads);
+	xquad_portio = ioremap(XQUAD_PORTIO_BASE, num_quads*XQUAD_PORTIO_QUAD);
 	printk("xquad_portio vaddr 0x%08lx, len %08lx\n",
-		(u_long) xquad_portio, (u_long) numnodes*XQUAD_PORTIO_QUAD);
+		(u_long) xquad_portio, (u_long) num_quads*XQUAD_PORTIO_QUAD);
 }
 
 static inline int check_phys_apicid_present(int boot_cpu_physical_apicid)


