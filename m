Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268173AbTB1Vc6>; Fri, 28 Feb 2003 16:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268190AbTB1Vc5>; Fri, 28 Feb 2003 16:32:57 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:37627 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268173AbTB1Vcm>; Fri, 28 Feb 2003 16:32:42 -0500
Date: Fri, 28 Feb 2003 13:33:46 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Bill Irwin <wli@holomorphy.com>
Subject: [PATCH] 1/7 Move node pgdat into node's own memory
Message-ID: <361160000.1046468026@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from William Lee Irwin

Patch to move the node's pgdat into the node's own local memory area 
along with the lmem_map.

Only touches arch/i386/mm/discontig.c - ie can only affect NUMA machines.
Has been tested in my tree for over a month on UP, SMP, and NUMA and 
compile tested against a variety of different configs.

Please apply, thanks,

M.

diff -urpN -X /home/fletch/.diff.exclude 000-virgin/arch/i386/mm/discontig.c 010-local_pgdat/arch/i386/mm/discontig.c
--- 000-virgin/arch/i386/mm/discontig.c	Sun Nov 17 20:29:47 2002
+++ 010-local_pgdat/arch/i386/mm/discontig.c	Fri Feb 28 08:05:33 2003
@@ -48,6 +48,14 @@ extern unsigned long max_low_pfn;
 extern unsigned long totalram_pages;
 extern unsigned long totalhigh_pages;
 
+#define LARGE_PAGE_BYTES (PTRS_PER_PTE * PAGE_SIZE)
+
+unsigned long node_remap_start_pfn[MAX_NUMNODES];
+unsigned long node_remap_size[MAX_NUMNODES];
+unsigned long node_remap_offset[MAX_NUMNODES];
+void *node_remap_start_vaddr[MAX_NUMNODES];
+void set_pmd_pfn(unsigned long vaddr, unsigned long pfn, pgprot_t flags);
+
 /*
  * Find the highest page frame number we have available for the node
  */
@@ -65,12 +73,13 @@ static void __init find_max_pfn_node(int
  */
 static void __init allocate_pgdat(int nid)
 {
-	unsigned long node_datasz;
-
-	node_datasz = PFN_UP(sizeof(struct pglist_data));
-	NODE_DATA(nid) = (pg_data_t *)(__va(min_low_pfn << PAGE_SHIFT));
-	min_low_pfn += node_datasz;
-	memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
+	if (nid)
+		NODE_DATA(nid) = (pg_data_t *)node_remap_start_vaddr[nid];
+	else {
+		NODE_DATA(nid) = (pg_data_t *)(__va(min_low_pfn << PAGE_SHIFT));
+		min_low_pfn += PFN_UP(sizeof(pg_data_t));
+		memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
+	}
 }
 
 /*
@@ -113,14 +122,6 @@ static void __init register_bootmem_low_
 	}
 }
 
-#define LARGE_PAGE_BYTES (PTRS_PER_PTE * PAGE_SIZE)
-
-unsigned long node_remap_start_pfn[MAX_NUMNODES];
-unsigned long node_remap_size[MAX_NUMNODES];
-unsigned long node_remap_offset[MAX_NUMNODES];
-void *node_remap_start_vaddr[MAX_NUMNODES];
-extern void set_pmd_pfn(unsigned long vaddr, unsigned long pfn, pgprot_t flags);
-
 void __init remap_numa_kva(void)
 {
 	void *vaddr;
@@ -145,7 +146,7 @@ static unsigned long calculate_numa_rema
 	for (nid = 1; nid < numnodes; nid++) {
 		/* calculate the size of the mem_map needed in bytes */
 		size = (node_end_pfn[nid] - node_start_pfn[nid] + 1) 
-			* sizeof(struct page);
+			* sizeof(struct page) + sizeof(pg_data_t);
 		/* convert size to large (pmd size) pages, rounding up */
 		size = (size + LARGE_PAGE_BYTES - 1) / LARGE_PAGE_BYTES;
 		/* now the roundup is correct, convert to PAGE_SIZE pages */
@@ -195,9 +196,9 @@ unsigned long __init setup_memory(void)
 	printk("Low memory ends at vaddr %08lx\n",
 			(ulong) pfn_to_kaddr(max_low_pfn));
 	for (nid = 0; nid < numnodes; nid++) {
-		allocate_pgdat(nid);
 		node_remap_start_vaddr[nid] = pfn_to_kaddr(
 			highstart_pfn - node_remap_offset[nid]);
+		allocate_pgdat(nid);
 		printk ("node %d will remap to vaddr %08lx - %08lx\n", nid,
 			(ulong) node_remap_start_vaddr[nid],
 			(ulong) pfn_to_kaddr(highstart_pfn
@@ -251,13 +252,6 @@ unsigned long __init setup_memory(void)
 	 */
 	find_smp_config();
 
-	/*insert other nodes into pgdat_list*/
-	for (nid = 1; nid < numnodes; nid++){       
-		NODE_DATA(nid)->pgdat_next = pgdat_list;
-		pgdat_list = NODE_DATA(nid);
-	}
-       
-
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (LOADER_TYPE && INITRD_START) {
 		if (INITRD_START + INITRD_SIZE <= (system_max_low_pfn << PAGE_SHIFT)) {
@@ -282,6 +276,18 @@ void __init zone_sizes_init(void)
 {
 	int nid;
 
+	/*
+	 * Insert nodes into pgdat_list backward so they appear in order.
+	 * Clobber node 0's links and NULL out pgdat_list before starting.
+	 */
+	pgdat_list = NULL;
+	for (nid = numnodes - 1; nid >= 0; nid--) {       
+		if (nid)
+			memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
+		NODE_DATA(nid)->pgdat_next = pgdat_list;
+		pgdat_list = NODE_DATA(nid);
+	}
+
 	for (nid = 0; nid < numnodes; nid++) {
 		unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
 		unsigned int max_dma;
@@ -312,13 +318,18 @@ void __init zone_sizes_init(void)
 		 * normal bootmem allocator, but other nodes come from the
 		 * remapped KVA area - mbligh
 		 */
-		if (nid)
-			free_area_init_node(nid, NODE_DATA(nid), 
-				node_remap_start_vaddr[nid], zones_size, 
-				start, 0);
-		else
+		if (!nid)
 			free_area_init_node(nid, NODE_DATA(nid), 0, 
 				zones_size, start, 0);
+		else {
+			unsigned long lmem_map;
+			lmem_map = (unsigned long)node_remap_start_vaddr[nid];
+			lmem_map += sizeof(pg_data_t) + PAGE_SIZE - 1;
+			lmem_map &= PAGE_MASK;
+			free_area_init_node(nid, NODE_DATA(nid), 
+				(struct page *)lmem_map, zones_size, 
+				start, 0);
+		}
 	}
 	return;
 }

