Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUC3WBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUC3WBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:01:13 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:24248 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261449AbUC3V5t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 16:57:49 -0500
Subject: Re: [PATCH] mask ADT: ia64 changes from Matthew's nodemask_t Patch
	6/7 [15/22]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <20040329041537.2c9e6951.pj@sgi.com>
References: <20040329041537.2c9e6951.pj@sgi.com>
Content-Type: multipart/mixed; boundary="=-pkAAZU3ojFWLYWa/dCFB"
Organization: IBM LTC
Message-Id: <1080683809.6742.196.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 30 Mar 2004 13:56:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pkAAZU3ojFWLYWa/dCFB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-03-29 at 04:15, Paul Jackson wrote:
> Patch_15_of_22 - Matthew Dobson's [PATCH]_nodemask_t_ia64_changes_[6_7]
> 	Changes to ia64 specific code.  Untested.
> 	Code review & testing requested.

Yet another updated patch.  Changes are very small, but I've attatched
the whole patch, rather than an incremental diff.  In
include/asm-ia64/sn/sn2/sn_private.h, we can safely drop the externs of
replicate_kernel_text() & setup_replication_mask() as they are unused on
ia64.

-Matt

--=-pkAAZU3ojFWLYWa/dCFB
Content-Disposition: attachment; filename=nodemask_t-06-ia64.patch
Content-Type: text/x-patch; name=nodemask_t-06-ia64.patch; charset=
Content-Transfer-Encoding: 7bit

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/kernel/acpi.c linux-2.6.4-nodemask_t-ia64/arch/ia64/kernel/acpi.c
--- linux-2.6.4-vanilla/arch/ia64/kernel/acpi.c	Wed Mar 10 18:55:27 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/kernel/acpi.c	Thu Mar 11 12:01:24 2004
@@ -450,14 +450,15 @@ acpi_numa_arch_fixup (void)
 	}
 
 	/* calculate total number of nodes in system from PXM bitmap */
-	numnodes = 0;		/* init total nodes in system */
+	nodes_clear(node_online_map);	/* init total nodes in system */
 
 	memset(pxm_to_nid_map, -1, sizeof(pxm_to_nid_map));
 	memset(nid_to_pxm_map, -1, sizeof(nid_to_pxm_map));
 	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
 		if (pxm_bit_test(i)) {
-			pxm_to_nid_map[i] = numnodes;
-			nid_to_pxm_map[numnodes++] = i;
+			pxm_to_nid_map[i] = num_online_nodes();
+			nid_to_pxm_map[num_online_nodes()] = i;
+			node_set_online(num_online_nodes());
 		}
 	}
 
@@ -466,7 +467,7 @@ acpi_numa_arch_fixup (void)
 		node_memblk[i].nid = pxm_to_nid_map[node_memblk[i].nid];
 
 	/* assign memory bank numbers for each chunk on each node */
-	for (i = 0; i < numnodes; i++) {
+	for_each_online_node(i) {
 		int bank;
 
 		bank = 0;
@@ -479,7 +480,7 @@ acpi_numa_arch_fixup (void)
 	for (i = 0; i < srat_num_cpus; i++)
 		node_cpuid[i].nid = pxm_to_nid_map[node_cpuid[i].nid];
 
-	printk(KERN_INFO "Number of logical nodes in system = %d\n", numnodes);
+	printk(KERN_INFO "Number of logical nodes in system = %d\n", num_online_nodes());
 	printk(KERN_INFO "Number of memory chunks in system = %d\n", num_node_memblks);
 
 	if (!slit_table) return;
@@ -499,8 +500,8 @@ acpi_numa_arch_fixup (void)
 
 #ifdef SLIT_DEBUG
 	printk("ACPI 2.0 SLIT locality table:\n");
-	for (i = 0; i < numnodes; i++) {
-		for (j = 0; j < numnodes; j++)
+	for_each_online_node(i) {
+		for_each_online_node(j)
 			printk("%03d ", node_distance(i,j));
 		printk("\n");
 	}
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/kernel/smpboot.c linux-2.6.4-nodemask_t-ia64/arch/ia64/kernel/smpboot.c
--- linux-2.6.4-vanilla/arch/ia64/kernel/smpboot.c	Wed Mar 10 18:55:24 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/kernel/smpboot.c	Thu Mar 11 16:02:22 2004
@@ -474,7 +474,7 @@ build_cpu_to_node_map (void)
 {
 	int cpu, i, node;
 
-	for(node=0; node<MAX_NUMNODES; node++)
+	for_each_node(node)
 		cpus_clear(node_to_cpu_mask[node]);
 	for(cpu = 0; cpu < NR_CPUS; ++cpu) {
 		/*
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/mm/discontig.c linux-2.6.4-nodemask_t-ia64/arch/ia64/mm/discontig.c
--- linux-2.6.4-vanilla/arch/ia64/mm/discontig.c	Wed Mar 10 18:55:43 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/mm/discontig.c	Thu Mar 11 15:56:26 2004
@@ -68,7 +68,7 @@ static void __init reassign_cpu_only_nod
 	/*
 	 * All nids with memory.
 	 */
-	if (nnode == numnodes)
+	if (nnode == num_online_nodes())
 		return;
 
 	/*
@@ -77,10 +77,11 @@ static void __init reassign_cpu_only_nod
 	 * For reassigned CPU nodes a nid can't be arrived at
 	 * until after this loop because the target nid's new
 	 * identity might not have been established yet. So
-	 * new nid values are fabricated above numnodes and
+	 * new nid values are fabricated above num_online_nodes() and
 	 * mapped back later to their true value.
 	 */
-	for (nid = 0, i = 0; i < numnodes; i++)  {
+	nid = 0;
+	for_each_online_node(i) {
 		if (test_bit(i, (void *) nodes_with_mem)) {
 			/*
 			 * Save original nid value for numa_slit
@@ -100,12 +101,12 @@ static void __init reassign_cpu_only_nod
 			cpunid = nid;
 			nid++;
 		} else
-			cpunid = numnodes;
+			cpunid = num_online_nodes();
 
 		for (cpu = 0; cpu < NR_CPUS; cpu++)
 			if (node_cpuid[cpu].nid == i) {
 				/* For nodes not being reassigned just fix the cpu's nid. */
-				if (cpunid < numnodes) {
+				if (cpunid < num_online_nodes()) {
 					node_cpuid[cpu].nid = cpunid;
 					continue;
 				}
@@ -113,15 +114,17 @@ static void __init reassign_cpu_only_nod
 				/*
 				 * For nodes being reassigned, find best node by
 				 * numa_slit information and then make a temporary
-				 * nid value based on current nid and numnodes.
+				 * nid value based on current nid and num_online_nodes().
 				 */
-				for (slit = 0xff, k = numnodes + numnodes, j = 0; j < numnodes; j++)
+				slit = 0xff;
+				k = 2 * num_online_nodes();
+				for_each_online_node(j)
 					if (i == j)
 						continue;
 					else if (test_bit(j, (void *) nodes_with_mem)) {
-						cslit = numa_slit[i * numnodes + j];
+						cslit = numa_slit[i * num_online_nodes() + j];
 						if (cslit < slit) {
-							k = numnodes + j;
+							k = num_online_nodes() + j;
 							slit = cslit;
 						}
 					}
@@ -134,11 +137,11 @@ static void __init reassign_cpu_only_nod
 	 * Fixup temporary nid values for CPU-only nodes.
 	 */
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
-		if (node_cpuid[cpu].nid == (numnodes + numnodes))
+		if (node_cpuid[cpu].nid == (2 * num_online_nodes()))
 			node_cpuid[cpu].nid = nnode - 1;
 		else
 			for (i = 0; i < nnode; i++)
-				if (node_flip[i] == (node_cpuid[cpu].nid - numnodes)) {
+				if (node_flip[i] == (node_cpuid[cpu].nid - num_online_nodes())) {
 					node_cpuid[cpu].nid = i;
 					break;
 				}
@@ -150,11 +153,12 @@ static void __init reassign_cpu_only_nod
 	for (i = 0; i < nnode; i++)
 		for (j = 0; j < nnode; j++)
 			numa_slit_fix[i * nnode + j] =
-				numa_slit[node_flip[i] * numnodes + node_flip[j]];
+				numa_slit[node_flip[i] * num_online_nodes() + node_flip[j]];
 
 	memcpy(numa_slit, numa_slit_fix, sizeof (numa_slit));
 
-	numnodes = nnode;
+	for(i = 0; i < nnode; i++)
+		node_set_online(i);
 
 	return;
 }
@@ -353,7 +357,7 @@ static void __init reserve_pernode_space
 	struct bootmem_data *bdp;
 	int node;
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		pg_data_t *pdp = mem_data[node].pgdat;
 
 		bdp = pdp->bdata;
@@ -384,11 +388,11 @@ static void __init initialize_pernode_da
 	int cpu, node;
 	pg_data_t *pgdat_list[NR_NODES];
 
-	for (node = 0; node < numnodes; node++)
+	for_each_online_node(node)
 		pgdat_list[node] = mem_data[node].pgdat;
 
 	/* Copy the pg_data_t list to each node and init the node field */
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		memcpy(mem_data[node].node_data->pg_data_ptrs, pgdat_list,
 		       sizeof(pgdat_list));
 	}
@@ -412,15 +416,15 @@ void __init find_memory(void)
 
 	reserve_memory();
 
-	if (numnodes == 0) {
+	if (num_online_nodes() == 0) {
 		printk(KERN_ERR "node info missing!\n");
-		numnodes = 1;
+		node_set_online(0);
 	}
 
 	min_low_pfn = -1;
 	max_low_pfn = 0;
 
-	if (numnodes > 1)
+	if (num_online_nodes() > 1)
 		reassign_cpu_only_nodes();
 
 	/* These actually end up getting called by call_pernode_memory() */
@@ -431,7 +435,7 @@ void __init find_memory(void)
 	 * Initialize the boot memory maps in reverse order since that's
 	 * what the bootmem allocator expects
 	 */
-	for (node = numnodes - 1; node >= 0; node--) {
+	for (node = num_online_nodes() - 1; node >= 0; node--) {
 		unsigned long pernode, pernodesize, map;
 		struct bootmem_data *bdp;
 
@@ -610,12 +614,12 @@ void paging_init(void)
 	efi_memmap_walk(find_largest_hole, &max_gap);
 
 	/* so min() will work in count_node_pages */
-	for (node = 0; node < numnodes; node++)
+	for_each_online_node(node)
 		mem_data[node].min_pfn = ~0UL;
 
 	efi_memmap_walk(filter_rsvd_memory, count_node_pages);
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		memset(zones_size, 0, sizeof(zones_size));
 		memset(zholes_size, 0, sizeof(zholes_size));
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/mm/hugetlbpage.c linux-2.6.4-nodemask_t-ia64/arch/ia64/mm/hugetlbpage.c
--- linux-2.6.4-vanilla/arch/ia64/mm/hugetlbpage.c	Wed Mar 10 18:55:27 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/mm/hugetlbpage.c	Thu Mar 11 16:47:48 2004
@@ -42,12 +42,11 @@ static struct page *dequeue_huge_page(vo
 	struct page *page = NULL;
 
 	if (list_empty(&hugepage_freelists[nid])) {
-		for (nid = 0; nid < MAX_NUMNODES; ++nid)
+		for_each_node(nid)
 			if (!list_empty(&hugepage_freelists[nid]))
 				break;
 	}
-	if (nid >= 0 && nid < MAX_NUMNODES &&
-	    !list_empty(&hugepage_freelists[nid])) {
+	if (node_possible(nid) && !list_empty(&hugepage_freelists[nid])) {
 		page = list_entry(hugepage_freelists[nid].next, struct page, list);
 		list_del(&page->list);
 	}
@@ -59,7 +58,7 @@ static struct page *alloc_fresh_huge_pag
 	static int nid = 0;
 	struct page *page;
 	page = alloc_pages_node(nid, GFP_HIGHUSER, HUGETLB_PAGE_ORDER);
-	nid = (nid + 1) % numnodes;
+	nid = (nid + 1) % num_online_nodes();
 	return page;
 }
 
@@ -557,7 +556,7 @@ static int __init hugetlb_init(void)
 	int i;
 	struct page *page;
 
-	for (i = 0; i < MAX_NUMNODES; ++i)
+	for_each_node(i)
 		INIT_LIST_HEAD(&hugepage_freelists[i]);
 
 	for (i = 0; i < htlbpage_max; ++i) {
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/mm/numa.c linux-2.6.4-nodemask_t-ia64/arch/ia64/mm/numa.c
--- linux-2.6.4-vanilla/arch/ia64/mm/numa.c	Wed Mar 10 18:55:24 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/mm/numa.c	Thu Mar 11 12:01:24 2004
@@ -54,12 +54,12 @@ static int __init topology_init(void)
 {
 	int i, err = 0;
 
-	sysfs_nodes = kmalloc(sizeof(struct node) * numnodes, GFP_KERNEL);
+	sysfs_nodes = kmalloc(sizeof(struct node) * num_online_nodes(), GFP_KERNEL);
 	if (!sysfs_nodes) {
 		err = -ENOMEM;
 		goto out;
 	}
-	memset(sysfs_nodes, 0, sizeof(struct node) * numnodes);
+	memset(sysfs_nodes, 0, sizeof(struct node) * num_online_nodes());
 
 	sysfs_cpus = kmalloc(sizeof(struct cpu) * NR_CPUS, GFP_KERNEL);
 	if (!sysfs_cpus) {
@@ -69,7 +69,7 @@ static int __init topology_init(void)
 	}
 	memset(sysfs_cpus, 0, sizeof(struct cpu) * NR_CPUS);
 
-	for (i = 0; i < numnodes; i++)
+	for_each_online_node(i)
 		if ((err = register_node(&sysfs_nodes[i], i, 0)))
 			goto out;
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/sn/fakeprom/fpmem.c linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/fakeprom/fpmem.c
--- linux-2.6.4-vanilla/arch/ia64/sn/fakeprom/fpmem.c	Wed Mar 10 18:55:26 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/fakeprom/fpmem.c	Thu Mar 11 12:01:24 2004
@@ -26,7 +26,7 @@
  *
  *		32 bit		32 bit
  *
- * 		numnodes	numcpus
+ * 		num_nodes	numcpus
  *
  *		16 bit   16 bit		   32 bit
  *		nasid0	cpuconf		membankdesc0
@@ -59,7 +59,7 @@ sn_config_t	*sn_config ;
 #endif
 
 /*
- * For SN, this may not take an arg and gets the numnodes from 
+ * For SN, this may not take an arg and gets the num_nodes from 
  * the prom variable or by traversing klcfg or promcfg
  */
 int
@@ -144,7 +144,7 @@ build_mem_desc(efi_memory_desc_t *md, in
 int
 build_efi_memmap(void *md, int mdsize)
 {
-	int		numnodes = GetNumNodes() ;
+	int		num_nodes = GetNumNodes() ;
 	int		cnode,bank ;
 	int		nasid ;
 	node_memmap_t	membank_info ;
@@ -153,7 +153,7 @@ build_efi_memmap(void *md, int mdsize)
 	long		paddr, hole, numbytes;
 
 
-	for (cnode=0;cnode<numnodes;cnode++) {
+	for (cnode=0; cnode<num_nodes; cnode++) {
 		nasid = GetNasid(cnode) ;
 		membank_info = GetMemBankInfo(cnode) ;
 		for (bank=0;bank<MD_BANKS_PER_NODE;bank++) {
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/sn/io/machvec/pci_bus_cvlink.c linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/machvec/pci_bus_cvlink.c
--- linux-2.6.4-vanilla/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	Wed Mar 10 18:55:37 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/machvec/pci_bus_cvlink.c	Thu Mar 11 14:42:49 2004
@@ -791,7 +791,6 @@ sn_pci_init (void)
 	struct list_head *ln;
 	struct pci_bus *pci_bus = NULL;
 	struct pci_dev *pci_dev = NULL;
-	extern int numnodes;
 	int cnode, ret;
 #ifdef CONFIG_PROC_FS
 	extern void register_sn_procfs(void);
@@ -814,7 +813,7 @@ sn_pci_init (void)
 
 	sgi_master_io_infr_init();
 
-	for (cnode = 0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		extern void intr_init_vecblk(cnodeid_t);
 		intr_init_vecblk(cnode);
 	}
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/sn/io/sn2/klconflib.c linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/sn2/klconflib.c
--- linux-2.6.4-vanilla/arch/ia64/sn/io/sn2/klconflib.c	Wed Mar 10 18:55:21 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/sn2/klconflib.c	Thu Mar 11 12:01:24 2004
@@ -62,7 +62,7 @@ find_lboard_nasid(lboard_t *start, nasid
 		    (start->brd_nasid == nasid))
 			return start;
 
-		if (numionodes == numnodes)
+		if (numionodes == num_online_nodes())
 			start = KLCF_NEXT_ANY(start);
 		else
 			start = KLCF_NEXT(start);
@@ -95,7 +95,7 @@ find_lboard_class_nasid(lboard_t *start,
 		    (start->brd_nasid == nasid))
 			return start;
 
-		if (numionodes == numnodes)
+		if (numionodes == num_online_nodes())
 			start = KLCF_NEXT_ANY(start);
 		else
 			start = KLCF_NEXT(start);
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/sn/io/sn2/klgraph.c linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/sn2/klgraph.c
--- linux-2.6.4-vanilla/arch/ia64/sn/io/sn2/klgraph.c	Wed Mar 10 18:55:34 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/sn2/klgraph.c	Thu Mar 11 12:01:24 2004
@@ -279,7 +279,7 @@ klhwg_add_all_routers(vertex_hdl_t hwgra
 	char path_buffer[100];
 	int rv;
 
-	for (cnode = 0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		nasid = COMPACT_TO_NASID_NODEID(cnode);
 		brd = find_lboard_class_any((lboard_t *)KL_CONFIG_INFO(nasid),
 				KLTYPE_ROUTER);
@@ -413,7 +413,7 @@ klhwg_connect_routers(vertex_hdl_t hwgra
 	cnodeid_t cnode;
 	lboard_t *brd;
 
-	for (cnode = 0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		nasid = COMPACT_TO_NASID_NODEID(cnode);
 		brd = find_lboard_class_any((lboard_t *)KL_CONFIG_INFO(nasid),
 				KLTYPE_ROUTER);
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/sn/io/sn2/ml_SN_init.c linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/sn2/ml_SN_init.c
--- linux-2.6.4-vanilla/arch/ia64/sn/io/sn2/ml_SN_init.c	Wed Mar 10 18:55:21 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/sn2/ml_SN_init.c	Thu Mar 11 12:01:24 2004
@@ -38,7 +38,7 @@ void init_platform_nodepda(nodepda_t *np
 	/* Allocate per-node platform-dependent data */
 	
 	nasid = COMPACT_TO_NASID_NODEID(node);
-	if (node >= numnodes) /* Headless/memless IO nodes */
+	if (node >= num_online_nodes()) /* Headless/memless IO nodes */
 		hubinfo = (hubinfo_t)alloc_bootmem_node(NODE_DATA(0), sizeof(struct hubinfo_s));
 	else
 		hubinfo = (hubinfo_t)alloc_bootmem_node(NODE_DATA(node), sizeof(struct hubinfo_s));
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/sn/io/sn2/ml_SN_intr.c linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/sn2/ml_SN_intr.c
--- linux-2.6.4-vanilla/arch/ia64/sn/io/sn2/ml_SN_intr.c	Wed Mar 10 18:55:37 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/sn2/ml_SN_intr.c	Thu Mar 11 12:01:24 2004
@@ -256,12 +256,12 @@ static cpuid_t intr_cpu_choose_node(void
 	cnodeid_t candidate_node;
 	cpuid_t cpuid;
 
-	if (last_node >= numnodes)
+	if (last_node >= num_online_nodes())
 		last_node = 0;
 
 	for (candidate_node = last_node + 1; candidate_node != last_node;
 			candidate_node++) {
-		if (candidate_node == numnodes)
+		if (candidate_node == num_online_nodes())
 			candidate_node = 0;
 		cpuid = intr_cpu_choose_from_node(candidate_node);
 		if (cpuid != CPU_NONE)
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/sn/io/sn2/ml_iograph.c linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/sn2/ml_iograph.c
--- linux-2.6.4-vanilla/arch/ia64/sn/io/sn2/ml_iograph.c	Wed Mar 10 18:55:20 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/sn2/ml_iograph.c	Thu Mar 11 12:01:24 2004
@@ -680,7 +680,7 @@ init_all_devices(void)
 		DBG("init_all_devices: Done io_init_node() for cnode %d\n", cnodeid);
 	}
 
-	for (cnodeid = 0; cnodeid < numnodes; cnodeid++) {
+	for_each_online_node(cnodeid) {
 		/*
 	 	 * Update information generated by IO init.
 		 */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/sn/io/sn2/module.c linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/sn2/module.c
--- linux-2.6.4-vanilla/arch/ia64/sn/io/sn2/module.c	Wed Mar 10 18:55:21 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/sn2/module.c	Thu Mar 11 12:01:24 2004
@@ -195,7 +195,7 @@ io_module_init(void)
      * First pass just scan for compute node boards KLTYPE_SNIA.
      * We do not support memoryless compute nodes.
      */
-    for (node = 0; node < numnodes; node++) {
+    for_each_online_node(node) {
 	nasid = COMPACT_TO_NASID_NODEID(node);
 	board = find_lboard_nasid((lboard_t *) KL_CONFIG_INFO(nasid), nasid, KLTYPE_SNIA);
 	ASSERT(board);
@@ -210,7 +210,7 @@ io_module_init(void)
     /*
      * Second scan, look for headless/memless board hosted by compute nodes.
      */
-    for (node = numnodes; node < numionodes; node++) {
+    for (node = num_online_nodes(); node < numionodes; node++) {
 	nasid_t		nasid;
 	char		serial_number[16];
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c
--- linux-2.6.4-vanilla/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c	Wed Mar 10 18:55:54 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c	Thu Mar 11 12:01:24 2004
@@ -2639,7 +2639,7 @@ isIO9(nasid_t nasid)
 		if (brd->brd_flags & LOCAL_MASTER_IO6) {
 			return 1;
 		}
-                if (numionodes == numnodes)
+                if (numionodes == num_online_nodes())
                         brd = KLCF_NEXT_ANY(brd);
                 else
                         brd = KLCF_NEXT(brd);
@@ -2652,7 +2652,7 @@ isIO9(nasid_t nasid)
 		if (brd->brd_flags & LOCAL_MASTER_IO6) {
 			return 1;
 		}
-                if (numionodes == numnodes)
+                if (numionodes == num_online_nodes())
                         brd = KLCF_NEXT_ANY(brd);
                 else
                         brd = KLCF_NEXT(brd);
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/sn/io/sn2/shub.c linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/sn2/shub.c
--- linux-2.6.4-vanilla/arch/ia64/sn/io/sn2/shub.c	Wed Mar 10 18:55:28 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/io/sn2/shub.c	Thu Mar 11 12:01:24 2004
@@ -165,7 +165,7 @@ shubstats_ioctl(struct inode *inode, str
 	int		nasid;
 
         cnode = (cnodeid_t)file->f_dentry->d_fsdata;
-        if (cnode < 0 || cnode >= numnodes)
+        if (cnode < 0 || cnode >= num_online_nodes())
                 return -ENODEV;
 
         switch (cmd) {
@@ -239,8 +239,8 @@ sn_linkstats_reset(unsigned long msecs)
 	uint64_t	    llp_csr_reg;
 
 	spin_lock(&sn_linkstats_lock);
-	memset(sn_linkstats, 0, numnodes * sizeof(struct s_linkstats));
-	for (cnode=0; cnode < numnodes; cnode++) {
+	memset(sn_linkstats, 0, num_online_nodes() * sizeof(struct s_linkstats));
+	for_each_online_node(cnode) {
 	    shub_mmr_write(cnode, SH_NI0_LLP_ERR, 0L);
 	    shub_mmr_write(cnode, SH_NI1_LLP_ERR, 0L);
 	    shub_mmr_write_iospace(cnode, IIO_LLP_LOG, 0L);
@@ -286,7 +286,8 @@ linkstatd_thread(void *unused)
 		spin_lock(&sn_linkstats_lock);
 
 		overflows = 0;
-		for (lsp=sn_linkstats, cnode=0; cnode < numnodes; cnode++, lsp++) {
+		lsp = sn_linkstats;
+		for_each_online_node(cnode) {
 			reg[0] = shub_mmr_read(cnode, SH_NI0_LLP_ERR);
 			reg[1] = shub_mmr_read(cnode, SH_NI1_LLP_ERR);
 			if (lsp->hs_ii_up) {
@@ -349,6 +350,7 @@ linkstatd_thread(void *unused)
 			    iio_wstat &= 0xffffffffff00ffff; /* bits 23:16 */
 			    shub_mmr_write_iospace(cnode, IIO_WSTAT, iio_wstat);
 			}
+			lsp++;
 		}
 
 		sn_linkstats_samples++;
@@ -401,7 +403,8 @@ sn_linkstats_get(char *page)
 	n += sprintf(page+n, "%-37s %8s %8s %8s %8s\n",
 		"# Numalink", "sn errs", "cb errs", "cb/min", "retries");
 
-	for (lsp=sn_linkstats, cnode=0; cnode < numnodes; cnode++, lsp++) {
+	lsp = sn_linkstats;
+	for_each_online_node(cnode) {
 		npda = NODEPDA(cnode);
 
 		/* two NL links on each SHub */
@@ -411,7 +414,7 @@ sn_linkstats_get(char *page)
 			retrysum += lsp->hs_ni_retry_errors[nlport];
 
 			/* avoid buffer overrun (should be using seq_read API) */
-			if (numnodes > 64)
+			if (num_online_nodes() > 64)
 				continue;
 
 			n += sprintf(page + n, "/%s/link/%d  %8lu %8lu %8s %8lu\n",
@@ -432,6 +435,7 @@ sn_linkstats_get(char *page)
 		    cbsum_ii += lsp->hs_ii_cb_errors;
 		    retrysum_ii += lsp->hs_ii_retry_errors;
 		}
+		lsp++;
 	}
 
 	n += sprintf(page + n, "%-37s %8lu %8lu %8s %8lu\n",
@@ -454,7 +458,7 @@ linkstatd_init(void)
 		return -ENODEV;
 
 	spin_lock_init(&sn_linkstats_lock);
-	sn_linkstats = kmalloc(numnodes * sizeof(struct s_linkstats), GFP_KERNEL);
+	sn_linkstats = kmalloc(num_online_nodes() * sizeof(struct s_linkstats), GFP_KERNEL);
 	sn_linkstats_reset(60000UL); /* default 60 second update interval */
 	kernel_thread(linkstatd_thread, NULL, CLONE_KERNEL);
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/sn/kernel/setup.c linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/kernel/setup.c
--- linux-2.6.4-vanilla/arch/ia64/sn/kernel/setup.c	Wed Mar 10 18:55:24 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/kernel/setup.c	Thu Mar 11 12:01:24 2004
@@ -224,7 +224,7 @@ sn_check_for_wars(void)
 {
 	int	cnode;
 
-	for (cnode=0; cnode< numnodes; cnode++)
+	for_each_online_node(cnode)
 		if (is_shub_1_1(cnodeid_to_nasid(cnode)))
 			shub_1_1_found = 1;
 }
@@ -372,16 +372,16 @@ sn_init_pdas(char **cmdline_p)
 		panic("overflow of cpu_data page");
 
 	memset(pda->cnodeid_to_nasid_table, -1, sizeof(pda->cnodeid_to_nasid_table));
-	for (cnode=0; cnode<numnodes; cnode++)
+	for_each_online_node(cnode)
 		pda->cnodeid_to_nasid_table[cnode] = pxm_to_nasid(nid_to_pxm_map[cnode]);
 
-	numionodes = numnodes;
+	numionodes = num_online_nodes();
 	scan_for_ionodes();
 
         /*
          * Allocate & initalize the nodepda for each node.
          */
-        for (cnode=0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		nodepdaindr[cnode] = alloc_bootmem_node(NODE_DATA(cnode), sizeof(nodepda_t));
 		memset(nodepdaindr[cnode], 0, sizeof(nodepda_t));
         }
@@ -398,7 +398,7 @@ sn_init_pdas(char **cmdline_p)
 	 * The following routine actually sets up the hubinfo struct
 	 * in nodepda.
 	 */
-	for (cnode = 0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		init_platform_nodepda(nodepdaindr[cnode], cnode);
 		bte_init_node (nodepdaindr[cnode], cnode);
 	}
@@ -486,7 +486,7 @@ sn_cpu_init(void)
 
 	if (nodepda->node_first_cpu == cpuid) {
 		int	buddy_nasid;
-		buddy_nasid = cnodeid_to_nasid(numa_node_id() == numnodes-1 ? 0 : numa_node_id()+ 1);
+		buddy_nasid = cnodeid_to_nasid(numa_node_id() == num_online_nodes()-1 ? 0 : numa_node_id()+ 1);
 		pda->pio_shub_war_cam_addr = (volatile unsigned long*)GLOBAL_MMR_ADDR(nasid, SH_PI_CAM_CONTROL);
 	}
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/sn/kernel/sn2/prominfo_proc.c linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/kernel/sn2/prominfo_proc.c
--- linux-2.6.4-vanilla/arch/ia64/sn/kernel/sn2/prominfo_proc.c	Wed Mar 10 18:55:23 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/kernel/sn2/prominfo_proc.c	Thu Mar 11 12:01:24 2004
@@ -320,16 +320,15 @@ prominfo_init(void)
 	TRACE();
 
 	DPRINTK("running on cpu %d\n", smp_processor_id());
-	DPRINTK("numnodes %d\n", numnodes);
+	DPRINTK("num_online_nodes() %d\n", num_online_nodes());
 
-	proc_entries = kmalloc(numnodes * sizeof(struct proc_dir_entry *),
+	proc_entries = kmalloc(num_online_nodes() * sizeof(struct proc_dir_entry *),
 			       GFP_KERNEL);
 
 	sgi_prominfo_entry = proc_mkdir("sgi_prominfo", NULL);
 
-	for (cnodeid = 0, entp = proc_entries;
-	     cnodeid < numnodes;
-	     cnodeid++, entp++) {
+	entp = proc_entries;
+	for_each_online_node(cnodeid) {
 		sprintf(name, "node%d", cnodeid);
 		*entp = proc_mkdir(name, sgi_prominfo_entry);
 		nasid = cnodeid_to_nasid(cnodeid);
@@ -339,6 +338,7 @@ prominfo_init(void)
 		create_proc_read_entry(
 			"version", 0, *entp, read_version_entry,
 			lookup_fit(nasid));
+		entp++;
 	}
 
 	return 0;
@@ -353,13 +353,13 @@ prominfo_exit(void)
 
 	TRACE();
 
-	for (cnodeid = 0, entp = proc_entries;
-	     cnodeid < numnodes;
-	     cnodeid++, entp++) {
+	entp = proc_entries;
+	for_each_online_node(cnodeid) {
 		remove_proc_entry("fit", *entp);
 		remove_proc_entry("version", *entp);
 		sprintf(name, "node%d", cnodeid);
 		remove_proc_entry(name, sgi_prominfo_entry);
+		entp++;
 	}
 	remove_proc_entry("sgi_prominfo", NULL);
 	kfree(proc_entries);
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/arch/ia64/sn/kernel/sn2/sn2_smp.c linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/kernel/sn2/sn2_smp.c
--- linux-2.6.4-vanilla/arch/ia64/sn/kernel/sn2/sn2_smp.c	Wed Mar 10 18:55:44 2004
+++ linux-2.6.4-nodemask_t-ia64/arch/ia64/sn/kernel/sn2/sn2_smp.c	Thu Mar 11 12:01:24 2004
@@ -183,7 +183,7 @@ sn2_ptc_deadlock_recovery(unsigned long 
 
 	mycnode = numa_node_id();
 
-	for (cnode = 0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		if (is_headless_node(cnode) || cnode == mycnode)
 			continue;
 		nasid = cnodeid_to_nasid(cnode);
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/include/asm-ia64/numa.h linux-2.6.4-nodemask_t-ia64/include/asm-ia64/numa.h
--- linux-2.6.4-vanilla/include/asm-ia64/numa.h	Wed Mar 10 18:55:25 2004
+++ linux-2.6.4-nodemask_t-ia64/include/asm-ia64/numa.h	Thu Mar 11 12:01:24 2004
@@ -59,7 +59,7 @@ extern struct node_cpuid_s node_cpuid[NR
  */
 
 extern u8 numa_slit[MAX_NUMNODES * MAX_NUMNODES];
-#define node_distance(from,to) (numa_slit[from * numnodes + to])
+#define node_distance(from,to) (numa_slit[from * num_online_nodes() + to])
 
 extern int paddr_to_nid(unsigned long paddr);
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.4-vanilla/include/asm-ia64/sn/sn2/sn_private.h linux-2.6.4-nodemask_t-ia64/include/asm-ia64/sn/sn2/sn_private.h
--- linux-2.6.4-vanilla/include/asm-ia64/sn/sn2/sn_private.h	Wed Mar 10 18:55:22 2004
+++ linux-2.6.4-nodemask_t-ia64/include/asm-ia64/sn/sn2/sn_private.h	Mon Mar 22 13:36:46 2004
@@ -87,9 +87,7 @@ void klhwg_add_all_modules(vertex_hdl_t)
 void install_klidbg_functions(void);
 
 /* klnuma.c */
-extern void replicate_kernel_text(int numnodes);
 extern unsigned long get_freemem_start(cnodeid_t cnode);
-extern void setup_replication_mask(int maxnodes);
 
 /* init.c */
 extern cnodeid_t get_compact_nodeid(void);	/* get compact node id */

--=-pkAAZU3ojFWLYWa/dCFB--

