Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbUCRXPQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbUCRXI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:08:29 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:32448 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263271AbUCRXF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:05:27 -0500
Subject: [PATCH] nodemask_t i386 changes [3/7]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com
Content-Type: multipart/mixed; boundary="=-1cIvYPOkfa2+zICjX2PO"
Organization: IBM LTC
Message-Id: <1079651077.8149.171.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 18 Mar 2004 15:04:40 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1cIvYPOkfa2+zICjX2PO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

nodemask_t-03-i386.patch - Changes to i386 specific code.  As with most
arch changes, it involves close-coding loops (ie:
for_each_online_node(nid) rather than for(nid=0;nid<numnodes;nid++)) and
replacing the use of numnodes with num_online_nodes() and
node_set_online(nid).

--=-1cIvYPOkfa2+zICjX2PO
Content-Disposition: attachment; filename=nodemask_t-03-i386.patch
Content-Type: text/x-patch; name=nodemask_t-03-i386.patch; charset=
Content-Transfer-Encoding: 7bit

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/i386/kernel/mpparse.c linux-2.6.4-nodemask_t-i386/arch/i386/kernel/mpparse.c
--- linux-2.6.4-vanilla/arch/i386/kernel/mpparse.c	Wed Mar 10 18:55:24 2004
+++ linux-2.6.4-nodemask_t-i386/arch/i386/kernel/mpparse.c	Mon Mar 15 17:32:29 2004
@@ -287,8 +287,8 @@ static void __init MP_translation_info (
 		printk(KERN_ERR "MAX_MPC_ENTRY exceeded!\n");
 	else
 		translation_table[mpc_record] = m; /* stash this for later */
-	if (m->trans_quad+1 > numnodes)
-		numnodes = m->trans_quad+1;
+	if (m->trans_quad+1 > num_online_nodes())
+		node_set_online(m->trans_quad);
 }
 
 /*
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/i386/kernel/numaq.c linux-2.6.4-nodemask_t-i386/arch/i386/kernel/numaq.c
--- linux-2.6.4-vanilla/arch/i386/kernel/numaq.c	Wed Mar 10 18:55:37 2004
+++ linux-2.6.4-nodemask_t-i386/arch/i386/kernel/numaq.c	Thu Mar 11 11:59:30 2004
@@ -39,8 +39,7 @@ extern long node_start_pfn[], node_end_p
  * Function: smp_dump_qct()
  *
  * Description: gets memory layout from the quad config table.  This
- * function also increments numnodes with the number of nodes (quads)
- * present.
+ * function also updates node_online_map with the nodes (quads) present.
  */
 static void __init smp_dump_qct(void)
 {
@@ -49,11 +48,10 @@ static void __init smp_dump_qct(void)
 	struct sys_cfg_data *scd =
 		(struct sys_cfg_data *)__va(SYS_CFG_DATA_PRIV_ADDR);
 
-	numnodes = 0;
-	for(node = 0; node < MAX_NUMNODES; node++) {
+	nodes_clear(node_online_map);
+	for_each_node(node) {
 		if(scd->quads_present31_0 & (1 << node)) {
 			node_set_online(node);
-			numnodes++;
 			eq = &scd->eq[node];
 			/* Convert to pages */
 			node_start_pfn[node] = MB_TO_PAGES(
@@ -86,7 +84,7 @@ static void __init initialize_physnode_m
 		(struct sys_cfg_data *)__va(SYS_CFG_DATA_PRIV_ADDR);
 
 	
-	for(nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		if(scd->quads_present31_0 & (1 << nid)) {
 			eq = &scd->eq[nid];
 			cur = eq->hi_shrd_mem_start;
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/i386/kernel/smpboot.c linux-2.6.4-nodemask_t-i386/arch/i386/kernel/smpboot.c
--- linux-2.6.4-vanilla/arch/i386/kernel/smpboot.c	Wed Mar 10 18:55:27 2004
+++ linux-2.6.4-nodemask_t-i386/arch/i386/kernel/smpboot.c	Thu Mar 11 16:01:41 2004
@@ -520,7 +520,7 @@ static inline void unmap_cpu_to_node(int
 	int node;
 
 	printk("Unmapping cpu %d from all nodes\n", cpu);
-	for (node = 0; node < MAX_NUMNODES; node ++)
+	for_each_node(node)
 		cpu_clear(cpu, node_2_cpu_mask[node]);
 	cpu_2_node[cpu] = -1;
 }
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/i386/kernel/srat.c linux-2.6.4-nodemask_t-i386/arch/i386/kernel/srat.c
--- linux-2.6.4-vanilla/arch/i386/kernel/srat.c	Wed Mar 10 18:55:23 2004
+++ linux-2.6.4-nodemask_t-i386/arch/i386/kernel/srat.c	Thu Mar 11 11:59:30 2004
@@ -248,17 +248,16 @@ static int __init acpi20_parse_srat(stru
 	 * a set of sequential node IDs starting at zero.  (ACPI doesn't seem
 	 * to specify the range of _PXM values.)
 	 */
-	numnodes = 0;		/* init total nodes in system */
+	nodes_clear(node_online_map);	/* init total nodes in system */
 	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
 		if (BMAP_TEST(pxm_bitmap, i)) {
-			pxm_to_nid_map[i] = numnodes;
-			nid_to_pxm_map[numnodes] = i;
-			node_set_online(numnodes);
-			++numnodes;
+			pxm_to_nid_map[i] = num_online_nodes();
+			nid_to_pxm_map[num_online_nodes()] = i;
+			node_set_online(num_online_nodes());
 		}
 	}
 
-	if (numnodes == 0)
+	if (num_online_nodes() == 0)
 		BUG();
 
 	/* set cnode id in memory chunk structure */
@@ -272,7 +271,7 @@ static int __init acpi20_parse_srat(stru
 		printk("%02X ", pxm_bitmap[i]);
 	}
 	printk("\n");
-	printk("Number of logical nodes in system = %d\n", numnodes);
+	printk("Number of logical nodes in system = %d\n", num_online_nodes());
 	printk("Number of memory chunks in system = %d\n", num_memory_chunks);
 
 	for (j = 0; j < num_memory_chunks; j++){
@@ -283,7 +282,7 @@ static int __init acpi20_parse_srat(stru
 	}
  
 	/*calculate node_start_pfn/node_end_pfn arrays*/
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		int been_here_before = 0;
 
 		for (j = 0; j < num_memory_chunks; j++){
@@ -415,7 +414,7 @@ static void __init get_zholes_init(void)
 	int first;
 	unsigned long end = 0;
 
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		first = 1;
 		for (c = 0; c < num_memory_chunks; c++){
 			if (node_memory_chunk[c].nid == nid) {
@@ -443,8 +442,8 @@ unsigned long * __init get_zholes_size(i
 		zholes_size_init++;
 		get_zholes_init();
 	}
-	if((nid >= numnodes) | (nid >= MAX_NUMNODES))
-		printk("%s: nid = %d is invalid. numnodes = %d",
-		       __FUNCTION__, nid, numnodes);
+	if (!node_online(nid))
+		printk("%s: nid = %d is invalid. num_online_nodes() = %d",
+		       __FUNCTION__, nid, num_online_nodes());
 	return &zholes_size[nid * MAX_NR_ZONES];
 }
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/i386/mm/discontig.c linux-2.6.4-nodemask_t-i386/arch/i386/mm/discontig.c
--- linux-2.6.4-vanilla/arch/i386/mm/discontig.c	Wed Mar 10 18:55:28 2004
+++ linux-2.6.4-nodemask_t-i386/arch/i386/mm/discontig.c	Mon Mar 15 17:47:47 2004
@@ -39,7 +39,7 @@ bootmem_data_t node0_bdata;
  * numa interface - we expect the numa architecture specfic code to have
  *                  populated the following initialisation.
  *
- * 1) numnodes         - the total number of nodes configured in the system
+ * 1) node_online_map  - the bitmap of nodes configured in the system
  * 2) physnode_map     - the mapping between a pfn and owning node
  * 3) node_start_pfn   - the starting page frame number for a node
  * 3) node_end_pfn     - the ending page fram number for a node
@@ -107,7 +107,6 @@ int __init get_memcfg_numa_flat(void)
 
          /* Indicate there is one node available. */
 	node_set_online(0);
-	numnodes = 1;
 	return 1;
 }
 
@@ -189,7 +188,7 @@ void __init remap_numa_kva(void)
 	unsigned long pfn;
 	int node;
 
-	for (node = 1; node < numnodes; ++node) {
+	for(node = 1; node < num_online_nodes(); node++) {
 		for (pfn=0; pfn < node_remap_size[node]; pfn += PTRS_PER_PTE) {
 			vaddr = node_remap_start_vaddr[node]+(pfn<<PAGE_SHIFT);
 			set_pmd_pfn((ulong) vaddr, 
@@ -204,7 +203,7 @@ static unsigned long calculate_numa_rema
 	int nid;
 	unsigned long size, reserve_pages = 0;
 
-	for (nid = 1; nid < numnodes; nid++) {
+	for(nid = 1; nid < num_online_nodes(); nid++) {
 		/* calculate the size of the mem_map needed in bytes */
 		size = (node_end_pfn[nid] - node_start_pfn[nid] + 1) 
 			* sizeof(struct page) + sizeof(pg_data_t);
@@ -256,7 +255,7 @@ unsigned long __init setup_memory(void)
 
 	printk("Low memory ends at vaddr %08lx\n",
 			(ulong) pfn_to_kaddr(max_low_pfn));
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		node_remap_start_vaddr[nid] = pfn_to_kaddr(
 			highstart_pfn - node_remap_offset[nid]);
 		allocate_pgdat(nid);
@@ -267,7 +266,7 @@ unsigned long __init setup_memory(void)
 	}
 	printk("High memory starts at vaddr %08lx\n",
 			(ulong) pfn_to_kaddr(highstart_pfn));
-	for (nid = 0; nid < numnodes; nid++)
+	for_each_online_node(nid)
 		find_max_pfn_node(nid);
 
 	NODE_DATA(0)->bdata = &node0_bdata;
@@ -342,14 +341,14 @@ void __init zone_sizes_init(void)
 	 * Clobber node 0's links and NULL out pgdat_list before starting.
 	 */
 	pgdat_list = NULL;
-	for (nid = numnodes - 1; nid >= 0; nid--) {       
+	for(nid = num_online_nodes() - 1; nid >= 0; nid--) {       
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
@@ -405,7 +404,7 @@ void __init set_highmem_pages_init(int b
 #ifdef CONFIG_HIGHMEM
 	int nid;
 
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		unsigned long node_pfn, node_high_size, zone_start_pfn;
 		struct page * zone_mem_map;
 		
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/i386/mm/hugetlbpage.c linux-2.6.4-nodemask_t-i386/arch/i386/mm/hugetlbpage.c
--- linux-2.6.4-vanilla/arch/i386/mm/hugetlbpage.c	Wed Mar 10 18:55:44 2004
+++ linux-2.6.4-nodemask_t-i386/arch/i386/mm/hugetlbpage.c	Mon Mar 15 17:39:42 2004
@@ -39,11 +39,11 @@ static struct page *dequeue_huge_page(vo
 	struct page *page = NULL;
 
 	if (list_empty(&hugepage_freelists[nid])) {
-		for (nid = 0; nid < MAX_NUMNODES; ++nid)
+		for_each_node(nid)
 			if (!list_empty(&hugepage_freelists[nid]))
 				break;
 	}
-	if (nid >= 0 && nid < MAX_NUMNODES && !list_empty(&hugepage_freelists[nid])) {
+	if (node_possible(nid) && !list_empty(&hugepage_freelists[nid])) {
 		page = list_entry(hugepage_freelists[nid].next, struct page, list);
 		list_del(&page->list);
 	}
@@ -55,7 +55,7 @@ static struct page *alloc_fresh_huge_pag
 	static int nid = 0;
 	struct page *page;
 	page = alloc_pages_node(nid, GFP_HIGHUSER, HUGETLB_PAGE_ORDER);
-	nid = (nid + 1) % numnodes;
+	nid = (nid + 1) % num_online_nodes();
 	return page;
 }
 
@@ -494,7 +494,7 @@ static int __init hugetlb_init(void)
 	if (!cpu_has_pse)
 		return -ENODEV;
 
-	for (i = 0; i < MAX_NUMNODES; ++i)
+	for_each_node(i)
 		INIT_LIST_HEAD(&hugepage_freelists[i]);
 
 	for (i = 0; i < htlbpage_max; ++i) {
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/i386/pci/numa.c linux-2.6.4-nodemask_t-i386/arch/i386/pci/numa.c
--- linux-2.6.4-vanilla/arch/i386/pci/numa.c	Wed Mar 10 18:55:23 2004
+++ linux-2.6.4-nodemask_t-i386/arch/i386/pci/numa.c	Mon Mar 15 17:47:01 2004
@@ -115,13 +115,10 @@ static int __init pci_numa_init(void)
 		return 0;
 
 	pci_root_bus = pcibios_scan_root(0);
-	if (numnodes > 1) {
-		for (quad = 1; quad < numnodes; ++quad) {
-			printk("Scanning PCI bus %d for quad %d\n", 
-				QUADLOCAL2BUS(quad,0), quad);
-			pci_scan_bus(QUADLOCAL2BUS(quad,0), 
-				&pci_root_ops, NULL);
-		}
+	for(quad = 1; quad < num_online_nodes(); quad++) {
+		printk("Scanning PCI bus %d for quad %d\n", 
+			QUADLOCAL2BUS(quad,0), quad);
+		pci_scan_bus(QUADLOCAL2BUS(quad,0), &pci_root_ops, NULL);
 	}
 	return 0;
 }
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/include/asm-i386/mach-numaq/mach_apic.h linux-2.6.4-nodemask_t-i386/include/asm-i386/mach-numaq/mach_apic.h
--- linux-2.6.4-vanilla/include/asm-i386/mach-numaq/mach_apic.h	Wed Mar 10 18:55:26 2004
+++ linux-2.6.4-nodemask_t-i386/include/asm-i386/mach-numaq/mach_apic.h	Thu Mar 11 11:59:30 2004
@@ -114,13 +114,15 @@ static inline int mpc_apic_id(struct mpc
 
 static inline void setup_portio_remap(void)
 {
-	if (numnodes <= 1)
+	int num_nodes = num_online_nodes();
+
+	if (num_nodes <= 1)
        		return;
 
-	printk("Remapping cross-quad port I/O for %d quads\n", numnodes);
-	xquad_portio = ioremap (XQUAD_PORTIO_BASE, numnodes*XQUAD_PORTIO_QUAD);
+	printk("Remapping cross-quad port I/O for %d quads\n", num_nodes);
+	xquad_portio = ioremap (XQUAD_PORTIO_BASE, num_nodes*XQUAD_PORTIO_QUAD);
 	printk("xquad_portio vaddr 0x%08lx, len %08lx\n",
-		(u_long) xquad_portio, (u_long) numnodes*XQUAD_PORTIO_QUAD);
+		(u_long) xquad_portio, (u_long) num_nodes*XQUAD_PORTIO_QUAD);
 }
 
 static inline int check_phys_apicid_present(int boot_cpu_physical_apicid)

--=-1cIvYPOkfa2+zICjX2PO--

