Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbULWWnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbULWWnt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 17:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbULWWnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 17:43:49 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:7104 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261229AbULWWkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 17:40:42 -0500
Subject: [RFC PATCH 4/10] Replace 'numnodes' with 'node_online_map' - ia64
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: LSE Tech <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1103838712.3945.12.camel@arrakis>
References: <1103838712.3945.12.camel@arrakis>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1103841636.3945.25.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 23 Dec 2004 14:40:36 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

4/10 - Replace numnodes with node_online_map for ia64

[mcd@arrakis node_online_map]$ diffstat arch-ia64.patch
 arch/ia64/kernel/acpi.c                 |   22 +++++-----
 arch/ia64/kernel/topology.c             |    3 -
 arch/ia64/mm/discontig.c                |   70 ++++++++++++++++++--------------
 arch/ia64/sn/kernel/io_init.c           |    2
 arch/ia64/sn/kernel/setup.c             |   16 +++----
 arch/ia64/sn/kernel/sn2/prominfo_proc.c |   13 +++--
 arch/ia64/sn/kernel/sn2/sn2_smp.c       |   14 ++----
 include/asm-ia64/mmzone.h               |   11 ++---
 include/asm-ia64/nodedata.h             |    2
 include/asm-ia64/numa.h                 |    2
 10 files changed, 85 insertions(+), 70 deletions(-)


-Matt

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/ia64/kernel/acpi.c linux-2.6.10-rc3-mm1-nom.ia64/arch/ia64/kernel/acpi.c
--- linux-2.6.10-rc3-mm1/arch/ia64/kernel/acpi.c	2004-12-13 16:22:41.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.ia64/arch/ia64/kernel/acpi.c	2004-12-16 13:12:10.000000000 -0800
@@ -445,16 +445,20 @@ acpi_numa_arch_fixup (void)
 		return;
 	}
 
+	/*
+	 * MCD - This can probably be dropped now.  No need for pxm ID to node ID 
+	 * mapping with sparse node numbering iff MAX_PXM_DOMAINS <= MAX_NUMNODES.
+	 */
 	/* calculate total number of nodes in system from PXM bitmap */
-	numnodes = 0;		/* init total nodes in system */
-
 	memset(pxm_to_nid_map, -1, sizeof(pxm_to_nid_map));
 	memset(nid_to_pxm_map, -1, sizeof(nid_to_pxm_map));
+	nodes_clear(node_online_map);
 	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
 		if (pxm_bit_test(i)) {
-			pxm_to_nid_map[i] = numnodes;
-			node_set_online(numnodes);
-			nid_to_pxm_map[numnodes++] = i;
+			int nid = num_online_nodes();
+			pxm_to_nid_map[i] = nid;
+			nid_to_pxm_map[nid] = i;
+			node_set_online(nid);
 		}
 	}
 
@@ -463,7 +467,7 @@ acpi_numa_arch_fixup (void)
 		node_memblk[i].nid = pxm_to_nid_map[node_memblk[i].nid];
 
 	/* assign memory bank numbers for each chunk on each node */
-	for (i = 0; i < numnodes; i++) {
+	for_each_online_node(i) {
 		int bank;
 
 		bank = 0;
@@ -476,7 +480,7 @@ acpi_numa_arch_fixup (void)
 	for (i = 0; i < srat_num_cpus; i++)
 		node_cpuid[i].nid = pxm_to_nid_map[node_cpuid[i].nid];
 
-	printk(KERN_INFO "Number of logical nodes in system = %d\n", numnodes);
+	printk(KERN_INFO "Number of logical nodes in system = %d\n", num_online_nodes());
 	printk(KERN_INFO "Number of memory chunks in system = %d\n", num_node_memblks);
 
 	if (!slit_table) return;
@@ -496,8 +500,8 @@ acpi_numa_arch_fixup (void)
 
 #ifdef SLIT_DEBUG
 	printk("ACPI 2.0 SLIT locality table:\n");
-	for (i = 0; i < numnodes; i++) {
-		for (j = 0; j < numnodes; j++)
+	for_each_online_node(i) {
+		for_each_online_node(j)
 			printk("%03d ", node_distance(i,j));
 		printk("\n");
 	}
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/ia64/kernel/topology.c linux-2.6.10-rc3-mm1-nom.ia64/arch/ia64/kernel/topology.c
--- linux-2.6.10-rc3-mm1/arch/ia64/kernel/topology.c	2004-12-13 16:22:42.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.ia64/arch/ia64/kernel/topology.c	2004-12-16 13:15:05.000000000 -0800
@@ -68,7 +68,8 @@ static int __init topology_init(void)
 	}
 	memset(sysfs_nodes, 0, sizeof(struct node) * MAX_NUMNODES);
 
-	for (i = 0; i < numnodes; i++)
+	/* MCD - Do we want to register all ONLINE nodes, or all POSSIBLE nodes? */
+	for_each_online_node(i)
 		if ((err = register_node(&sysfs_nodes[i], i, 0)))
 			goto out;
 #endif
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/ia64/mm/discontig.c linux-2.6.10-rc3-mm1-nom.ia64/arch/ia64/mm/discontig.c
--- linux-2.6.10-rc3-mm1/arch/ia64/mm/discontig.c	2004-12-13 16:22:44.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.ia64/arch/ia64/mm/discontig.c	2004-12-16 14:06:06.000000000 -0800
@@ -39,7 +39,7 @@ struct early_node_data {
 	unsigned long max_pfn;
 };
 
-static struct early_node_data mem_data[NR_NODES] __initdata;
+static struct early_node_data mem_data[MAX_NUMNODES] __initdata;
 
 /**
  * reassign_cpu_only_nodes - called from find_memory to move CPU-only nodes to a memory node
@@ -56,9 +56,9 @@ static void __init reassign_cpu_only_nod
 	struct node_memblk_s *p;
 	int i, j, k, nnode, nid, cpu, cpunid, pxm;
 	u8 cslit, slit;
-	static DECLARE_BITMAP(nodes_with_mem, NR_NODES) __initdata;
+	static DECLARE_BITMAP(nodes_with_mem, MAX_NUMNODES) __initdata;
 	static u8 numa_slit_fix[MAX_NUMNODES * MAX_NUMNODES] __initdata;
-	static int node_flip[NR_NODES] __initdata;
+	static int node_flip[MAX_NUMNODES] __initdata;
 	static int old_nid_map[NR_CPUS] __initdata;
 
 	for (nnode = 0, p = &node_memblk[0]; p < &node_memblk[num_node_memblks]; p++)
@@ -70,7 +70,7 @@ static void __init reassign_cpu_only_nod
 	/*
 	 * All nids with memory.
 	 */
-	if (nnode == numnodes)
+	if (nnode == num_online_nodes())
 		return;
 
 	/*
@@ -79,10 +79,17 @@ static void __init reassign_cpu_only_nod
 	 * For reassigned CPU nodes a nid can't be arrived at
 	 * until after this loop because the target nid's new
 	 * identity might not have been established yet. So
-	 * new nid values are fabricated above numnodes and
+	 * new nid values are fabricated above num_online_nodes() and
 	 * mapped back later to their true value.
 	 */
-	for (nid = 0, i = 0; i < numnodes; i++)  {
+	/* MCD - This code is a bit complicated, but may be unnecessary now.
+	 * We can now handle much more interesting node-numbering.
+	 * The old requirement that 0 <= nid <= numnodes <= MAX_NUMNODES
+	 * and that there be no holes in the numbering 0..numnodes
+	 * has become simply 0 <= nid <= MAX_NUMNODES.
+	 */
+	nid = 0;
+	for_each_online_node(i)  {
 		if (test_bit(i, (void *) nodes_with_mem)) {
 			/*
 			 * Save original nid value for numa_slit
@@ -102,7 +109,7 @@ static void __init reassign_cpu_only_nod
 			cpunid = nid;
 			nid++;
 		} else
-			cpunid = numnodes;
+			cpunid = MAX_NUMNODES;
 
 		for (cpu = 0; cpu < NR_CPUS; cpu++)
 			if (node_cpuid[cpu].nid == i) {
@@ -110,7 +117,7 @@ static void __init reassign_cpu_only_nod
 				 * For nodes not being reassigned just
 				 * fix the cpu's nid and reverse pxm map
 				 */
-				if (cpunid < numnodes) {
+				if (cpunid < MAX_NUMNODES) {
 					pxm = nid_to_pxm_map[i];
 					pxm_to_nid_map[pxm] =
 					          node_cpuid[cpu].nid = cpunid;
@@ -120,18 +127,21 @@ static void __init reassign_cpu_only_nod
 				/*
 				 * For nodes being reassigned, find best node by
 				 * numa_slit information and then make a temporary
-				 * nid value based on current nid and numnodes.
+				 * nid value based on current nid and num_online_nodes().
 				 */
-				for (slit = 0xff, k = numnodes + numnodes, j = 0; j < numnodes; j++)
+				slit = 0xff;
+				k = 2*num_online_nodes();
+				for_each_online_node(j) {
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
+				}
 
 				/* save old nid map so we can update the pxm */
 				old_nid_map[cpu] = node_cpuid[cpu].nid;
@@ -143,12 +153,12 @@ static void __init reassign_cpu_only_nod
 	 * Fixup temporary nid values for CPU-only nodes.
 	 */
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
-		if (node_cpuid[cpu].nid == (numnodes + numnodes)) {
+		if (node_cpuid[cpu].nid == (2*num_online_nodes())) {
 			pxm = nid_to_pxm_map[old_nid_map[cpu]];
 			pxm_to_nid_map[pxm] = node_cpuid[cpu].nid = nnode - 1;
 		} else {
 			for (i = 0; i < nnode; i++) {
-				if (node_flip[i] != (node_cpuid[cpu].nid - numnodes))
+				if (node_flip[i] != (node_cpuid[cpu].nid - num_online_nodes()))
 					continue;
 
 				pxm = nid_to_pxm_map[old_nid_map[cpu]];
@@ -164,14 +174,13 @@ static void __init reassign_cpu_only_nod
 	for (i = 0; i < nnode; i++)
 		for (j = 0; j < nnode; j++)
 			numa_slit_fix[i * nnode + j] =
-				numa_slit[node_flip[i] * numnodes + node_flip[j]];
+				numa_slit[node_flip[i] * num_online_nodes() + node_flip[j]];
 
 	memcpy(numa_slit, numa_slit_fix, sizeof (numa_slit));
 
-	for (i = nnode; i < numnodes; i++)
-		node_set_offline(i);
-
-	numnodes = nnode;
+	nodes_clear(node_online_map);
+	for (i = 0; i < nnode; i++)
+		node_set_online(i);
 
 	return;
 }
@@ -370,7 +379,7 @@ static void __init reserve_pernode_space
 	struct bootmem_data *bdp;
 	int node;
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online(node) {
 		pg_data_t *pdp = mem_data[node].pgdat;
 
 		bdp = pdp->bdata;
@@ -399,13 +408,13 @@ static void __init reserve_pernode_space
 static void __init initialize_pernode_data(void)
 {
 	int cpu, node;
-	pg_data_t *pgdat_list[NR_NODES];
+	pg_data_t *pgdat_list[MAX_NUMNODES];
 
-	for (node = 0; node < numnodes; node++)
+	for_each_online_node(node)
 		pgdat_list[node] = mem_data[node].pgdat;
 
 	/* Copy the pg_data_t list to each node and init the node field */
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		memcpy(mem_data[node].node_data->pg_data_ptrs, pgdat_list,
 		       sizeof(pgdat_list));
 	}
@@ -429,15 +438,15 @@ void __init find_memory(void)
 
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
@@ -448,10 +457,13 @@ void __init find_memory(void)
 	 * Initialize the boot memory maps in reverse order since that's
 	 * what the bootmem allocator expects
 	 */
-	for (node = numnodes - 1; node >= 0; node--) {
+	for (node = MAX_NUMNODES - 1; node >= 0; node--) {
 		unsigned long pernode, pernodesize, map;
 		struct bootmem_data *bdp;
 
+		if (!node_online(node))
+			continue;
+
 		bdp = &mem_data[node].bootmem_data;
 		pernode = mem_data[node].pernode_addr;
 		pernodesize = mem_data[node].pernode_size;
@@ -638,12 +650,12 @@ void __init paging_init(void)
 	max_dma = virt_to_phys((void *) MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 
 	/* so min() will work in count_node_pages */
-	for (node = 0; node < numnodes; node++)
+	for_each_online_node(node)
 		mem_data[node].min_pfn = ~0UL;
 
 	efi_memmap_walk(filter_rsvd_memory, count_node_pages);
 
-	for (node = 0; node < numnodes; node++) {
+	for_each_online_node(node) {
 		memset(zones_size, 0, sizeof(zones_size));
 		memset(zholes_size, 0, sizeof(zholes_size));
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/ia64/sn/kernel/io_init.c linux-2.6.10-rc3-mm1-nom.ia64/arch/ia64/sn/kernel/io_init.c
--- linux-2.6.10-rc3-mm1/arch/ia64/sn/kernel/io_init.c	2004-12-13 16:22:43.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.ia64/arch/ia64/sn/kernel/io_init.c	2004-12-14 11:57:17.000000000 -0800
@@ -382,7 +382,7 @@ void hubdev_init_node(nodepda_t * npda, 
 
 	struct hubdev_info *hubdev_info;
 
-	if (node >= numnodes)	/* Headless/memless IO nodes */
+	if (node >= num_online_nodes())	/* Headless/memless IO nodes */
 		hubdev_info =
 		    (struct hubdev_info *)alloc_bootmem_node(NODE_DATA(0),
 							     sizeof(struct
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/ia64/sn/kernel/setup.c linux-2.6.10-rc3-mm1-nom.ia64/arch/ia64/sn/kernel/setup.c
--- linux-2.6.10-rc3-mm1/arch/ia64/sn/kernel/setup.c	2004-12-13 16:22:43.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.ia64/arch/ia64/sn/kernel/setup.c	2004-12-16 14:10:54.000000000 -0800
@@ -224,7 +224,7 @@ static void __init sn_check_for_wars(voi
 {
 	int cnode;
 
-	for (cnode = 0; cnode < numnodes; cnode++)
+	for_each_online_node(cnode)
 		if (is_shub_1_1(cnodeid_to_nasid(cnode)))
 			shub_1_1_found = 1;
 }
@@ -346,17 +346,17 @@ void __init sn_init_pdas(char **cmdline_
 
 	memset(pda->cnodeid_to_nasid_table, -1,
 	       sizeof(pda->cnodeid_to_nasid_table));
-	for (cnode = 0; cnode < numnodes; cnode++)
+	for_each_online_node(cnode)
 		pda->cnodeid_to_nasid_table[cnode] =
 		    pxm_to_nasid(nid_to_pxm_map[cnode]);
 
-	numionodes = numnodes;
+	numionodes = num_online_nodes();
 	scan_for_ionodes();
 
 	/*
 	 * Allocate & initalize the nodepda for each node.
 	 */
-	for (cnode = 0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		nodepdaindr[cnode] =
 		    alloc_bootmem_node(NODE_DATA(cnode), sizeof(nodepda_t));
 		memset(nodepdaindr[cnode], 0, sizeof(nodepda_t));
@@ -367,7 +367,7 @@ void __init sn_init_pdas(char **cmdline_
 	/*
 	 * Allocate & initialize nodepda for TIOs.  For now, put them on node 0.
 	 */
-	for (cnode = numnodes; cnode < numionodes; cnode++) {
+	for (cnode = num_online_nodes(); cnode < numionodes; cnode++) {
 		nodepdaindr[cnode] =
 		    alloc_bootmem_node(NODE_DATA(0), sizeof(nodepda_t));
 		memset(nodepdaindr[cnode], 0, sizeof(nodepda_t));
@@ -385,7 +385,7 @@ void __init sn_init_pdas(char **cmdline_
 	 * The following routine actually sets up the hubinfo struct
 	 * in nodepda.
 	 */
-	for (cnode = 0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		bte_init_node(nodepdaindr[cnode], cnode);
 	}
 
@@ -431,7 +431,7 @@ void __init sn_cpu_init(void)
 	if (ia64_sn_get_sapic_info(cpuphyid, &nasid, &subnode, &slice))
 		BUG();
 
-	for (i=0; i < NR_NODES; i++) {
+	for (i=0; i < MAX_NUMNODES; i++) {
 		if (nodepdaindr[i]) {
 			nodepdaindr[i]->phys_cpuid[cpuid].nasid = nasid;
 			nodepdaindr[i]->phys_cpuid[cpuid].slice = slice;
@@ -484,7 +484,7 @@ void __init sn_cpu_init(void)
 		int buddy_nasid;
 		buddy_nasid =
 		    cnodeid_to_nasid(numa_node_id() ==
-				     numnodes - 1 ? 0 : numa_node_id() + 1);
+				     num_online_nodes() - 1 ? 0 : numa_node_id() + 1);
 		pda->pio_shub_war_cam_addr =
 		    (volatile unsigned long *)GLOBAL_MMR_ADDR(nasid,
 							      SH_PI_CAM_CONTROL);
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/ia64/sn/kernel/sn2/prominfo_proc.c linux-2.6.10-rc3-mm1-nom.ia64/arch/ia64/sn/kernel/sn2/prominfo_proc.c
--- linux-2.6.10-rc3-mm1/arch/ia64/sn/kernel/sn2/prominfo_proc.c	2004-12-13 16:22:43.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.ia64/arch/ia64/sn/kernel/sn2/prominfo_proc.c	2004-12-16 14:13:31.000000000 -0800
@@ -233,14 +233,13 @@ int __init prominfo_init(void)
 	if (!ia64_platform_is("sn2"))
 		return 0;
 
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
@@ -254,6 +253,7 @@ int __init prominfo_init(void)
 			(void *)nasid);
 		if (p)
 			p->owner = THIS_MODULE;
+		entp++;
 	}
 
 	return 0;
@@ -265,12 +265,13 @@ void __exit prominfo_exit(void)
 	unsigned cnodeid;
 	char name[NODE_NAME_LEN];
 
-	for (cnodeid = 0, entp = proc_entries;
-	     cnodeid < numnodes; cnodeid++, entp++) {
+	entp = proc_entries;
+	for (cnodeid) {
 		remove_proc_entry("fit", *entp);
 		remove_proc_entry("version", *entp);
 		sprintf(name, "node%d", cnodeid);
 		remove_proc_entry(name, sgi_prominfo_entry);
+		entp++;
 	}
 	remove_proc_entry("sgi_prominfo", NULL);
 	kfree(proc_entries);
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/ia64/sn/kernel/sn2/sn2_smp.c linux-2.6.10-rc3-mm1-nom.ia64/arch/ia64/sn/kernel/sn2/sn2_smp.c
--- linux-2.6.10-rc3-mm1/arch/ia64/sn/kernel/sn2/sn2_smp.c	2004-12-13 16:22:43.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.ia64/arch/ia64/sn/kernel/sn2/sn2_smp.c	2004-12-16 14:19:59.000000000 -0800
@@ -92,16 +92,15 @@ sn2_global_tlb_purge(unsigned long start
 	volatile unsigned long *ptc0, *ptc1;
 	unsigned long flags = 0, data0, data1;
 	struct mm_struct *mm = current->active_mm;
-	short nasids[NR_NODES], nix;
-	DECLARE_BITMAP(nodes_flushed, NR_NODES);
-
-	bitmap_zero(nodes_flushed, NR_NODES);
+	short nasids[MAX_NUMNODES], nix;
+	nodemask_t nodes_flushed;
 
+	nodes_clear(nodes_flushed);
 	i = 0;
 
 	for_each_cpu_mask(cpu, mm->cpu_vm_mask) {
 		cnode = cpu_to_node(cpu);
-		__set_bit(cnode, nodes_flushed);
+		node_set(cnode, nodes_flushed);
 		lcpu = cpu;
 		i++;
 	}
@@ -125,8 +124,7 @@ sn2_global_tlb_purge(unsigned long start
 	}
 
 	nix = 0;
-	for (cnode = find_first_bit(&nodes_flushed, NR_NODES); cnode < NR_NODES;
-	     cnode = find_next_bit(&nodes_flushed, NR_NODES, ++cnode))
+	for_each_node_mask(cnode, nodes_flushed)
 		nasids[nix++] = cnodeid_to_nasid(cnode);
 
 	data0 = (1UL << SH_PTC_0_A_SHFT) |
@@ -194,7 +192,7 @@ void sn2_ptc_deadlock_recovery(unsigned 
 
 	mycnode = numa_node_id();
 
-	for (cnode = 0; cnode < numnodes; cnode++) {
+	for_each_online_node(cnode) {
 		if (is_headless_node(cnode) || cnode == mycnode)
 			continue;
 		nasid = cnodeid_to_nasid(cnode);
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/include/asm-ia64/mmzone.h linux-2.6.10-rc3-mm1-nom.ia64/include/asm-ia64/mmzone.h
--- linux-2.6.10-rc3-mm1/include/asm-ia64/mmzone.h	2004-12-13 16:23:42.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.ia64/include/asm-ia64/mmzone.h	2004-12-16 13:36:02.000000000 -0800
@@ -11,7 +11,7 @@
 #ifndef _ASM_IA64_MMZONE_H
 #define _ASM_IA64_MMZONE_H
 
-#include <linux/config.h>
+#include <linux/numa.h>
 #include <asm/page.h>
 #include <asm/meminit.h>
 
@@ -19,15 +19,14 @@
 
 #ifdef CONFIG_IA64_DIG /* DIG systems are small */
 # define MAX_PHYSNODE_ID	8
-# define NR_NODES		8
-# define NR_NODE_MEMBLKS	(NR_NODES * 8)
+# define NR_NODE_MEMBLKS	(MAX_NUMNODES * 8)
 #else /* sn2 is the biggest case, so we use that if !DIG */
 # define MAX_PHYSNODE_ID	2048
-# define NR_NODES		256
-# define NR_NODE_MEMBLKS	(NR_NODES * 4)
+# define NR_NODE_MEMBLKS	(MAX_NUMNODES * 4)
 #endif
 
 #else /* CONFIG_DISCONTIGMEM */
-# define NR_NODE_MEMBLKS	4
+# define NR_NODE_MEMBLKS	(MAX_NUMNODES * 4)
 #endif /* CONFIG_DISCONTIGMEM */
+
 #endif /* _ASM_IA64_MMZONE_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/include/asm-ia64/nodedata.h linux-2.6.10-rc3-mm1-nom.ia64/include/asm-ia64/nodedata.h
--- linux-2.6.10-rc3-mm1/include/asm-ia64/nodedata.h	2004-12-13 16:23:42.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.ia64/include/asm-ia64/nodedata.h	2004-12-16 13:23:42.000000000 -0800
@@ -27,7 +27,7 @@ struct pglist_data;
 struct ia64_node_data {
 	short			active_cpu_count;
 	short			node;
-	struct pglist_data	*pg_data_ptrs[NR_NODES];
+	struct pglist_data	*pg_data_ptrs[MAX_NUMNODES];
 };
 
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/include/asm-ia64/numa.h linux-2.6.10-rc3-mm1-nom.ia64/include/asm-ia64/numa.h
--- linux-2.6.10-rc3-mm1/include/asm-ia64/numa.h	2004-12-13 16:23:41.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.ia64/include/asm-ia64/numa.h	2004-12-14 11:57:17.000000000 -0800
@@ -59,7 +59,7 @@ extern struct node_cpuid_s node_cpuid[NR
  */
 
 extern u8 numa_slit[MAX_NUMNODES * MAX_NUMNODES];
-#define node_distance(from,to) (numa_slit[(from) * numnodes + (to)])
+#define node_distance(from,to) (numa_slit[(from) * num_online_nodes() + (to)])
 
 extern int paddr_to_nid(unsigned long paddr);
 


