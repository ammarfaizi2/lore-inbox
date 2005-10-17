Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVJQSxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVJQSxc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVJQSxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:53:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30987 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932251AbVJQSxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:53:31 -0400
Date: Mon, 17 Oct 2005 19:53:13 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, discuss@x86-64.org,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, shai@scalex86.org,
       clameter@engr.sgi.com
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051017185313.GA15407@flint.arm.linux.org.uk>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Muli Ben-Yehuda <mulix@mulix.org>, discuss@x86-64.org,
	Ravikiran G Thirumalai <kiran@scalex86.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, shai@scalex86.org,
	clameter@engr.sgi.com
References: <20051017093654.GA7652@localhost.localdomain> <200510172008.24669.ak@suse.de> <20051017182755.GA26239@granada.merseine.nu> <200510172032.45972.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510171802.09708.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 04:02:09PM +0200, Andi Kleen wrote:
> ... but risk breaking other stuff. Unless you can get the ARM and/or IA64 
> people to do some retesting with the proposed fixes it's quite risky.  
> Sometimes you have to make compromises before releases.

Since this issue came up, I have reworked ARM's memory initialisation
as below, which makes us independent of the order in which memory zones
are initialised.  However, this patch is more or less untested, and
does _not_ yet support XIP (which is pretty important for some people
on ARM.)  As such it isn't ready for mainline yet.

Please note that ARM has numerious differing memory setups, so it's
impossible for any one person to sufficiently test it - hence it's
definitely very early release cycle material only.

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -86,15 +86,22 @@ void show_mem(void)
 	printk("%d pages swap cached\n", cached);
 }
 
-struct node_info {
-	unsigned int start;
-	unsigned int end;
-	int bootmap_pages;
-};
+static inline pmd_t *pmd_off(pgd_t *pgd, unsigned long virt)
+{
+	return pmd_offset(pgd, virt);
+}
+
+static inline pmd_t *pmd_off_k(unsigned long virt)
+{
+	return pmd_off(pgd_offset_k(virt), virt);
+}
 
-#define O_PFN_DOWN(x)	((x) >> PAGE_SHIFT)
 #define O_PFN_UP(x)	(PAGE_ALIGN(x) >> PAGE_SHIFT)
 
+#define for_each_nodebank(iter,mi,no)			\
+	for (iter = 0; iter < mi->nr_banks; iter++)	\
+		if (mi->bank[iter].node == no)
+
 /*
  * FIXME: We really want to avoid allocating the bootmap bitmap
  * over the top of the initrd.  Hopefully, this is located towards
@@ -109,12 +116,9 @@ find_bootmap_pfn(int node, struct meminf
 	start_pfn   = O_PFN_UP(__pa(&_end));
 	bootmap_pfn = 0;
 
-	for (bank = 0; bank < mi->nr_banks; bank ++) {
+	for_each_nodebank(bank, mi, node) {
 		unsigned int start, end;
 
-		if (mi->bank[bank].node != node)
-			continue;
-
 		start = mi->bank[bank].start >> PAGE_SHIFT;
 		end   = (mi->bank[bank].size +
 			 mi->bank[bank].start) >> PAGE_SHIFT;
@@ -140,92 +144,6 @@ find_bootmap_pfn(int node, struct meminf
 	return bootmap_pfn;
 }
 
-/*
- * Scan the memory info structure and pull out:
- *  - the end of memory
- *  - the number of nodes
- *  - the pfn range of each node
- *  - the number of bootmem bitmap pages
- */
-static unsigned int __init
-find_memend_and_nodes(struct meminfo *mi, struct node_info *np)
-{
-	unsigned int i, bootmem_pages = 0, memend_pfn = 0;
-
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		np[i].start = -1U;
-		np[i].end = 0;
-		np[i].bootmap_pages = 0;
-	}
-
-	for (i = 0; i < mi->nr_banks; i++) {
-		unsigned long start, end;
-		int node;
-
-		if (mi->bank[i].size == 0) {
-			/*
-			 * Mark this bank with an invalid node number
-			 */
-			mi->bank[i].node = -1;
-			continue;
-		}
-
-		node = mi->bank[i].node;
-
-		/*
-		 * Make sure we haven't exceeded the maximum number of nodes
-		 * that we have in this configuration.  If we have, we're in
-		 * trouble.  (maybe we ought to limit, instead of bugging?)
-		 */
-		if (node >= MAX_NUMNODES)
-			BUG();
-		node_set_online(node);
-
-		/*
-		 * Get the start and end pfns for this bank
-		 */
-		start = mi->bank[i].start >> PAGE_SHIFT;
-		end   = (mi->bank[i].start + mi->bank[i].size) >> PAGE_SHIFT;
-
-		if (np[node].start > start)
-			np[node].start = start;
-
-		if (np[node].end < end)
-			np[node].end = end;
-
-		if (memend_pfn < end)
-			memend_pfn = end;
-	}
-
-	/*
-	 * Calculate the number of pages we require to
-	 * store the bootmem bitmaps.
-	 */
-	for_each_online_node(i) {
-		if (np[i].end == 0)
-			continue;
-
-		np[i].bootmap_pages = bootmem_bootmap_pages(np[i].end -
-							    np[i].start);
-		bootmem_pages += np[i].bootmap_pages;
-	}
-
-	high_memory = __va(memend_pfn << PAGE_SHIFT);
-
-	/*
-	 * This doesn't seem to be used by the Linux memory
-	 * manager any more.  If we can get rid of it, we
-	 * also get rid of some of the stuff above as well.
-	 *
-	 * Note: max_low_pfn and max_pfn reflect the number
-	 * of _pages_ in the system, not the maximum PFN.
-	 */
-	max_low_pfn = memend_pfn - O_PFN_DOWN(PHYS_OFFSET);
-	max_pfn = memend_pfn - O_PFN_DOWN(PHYS_OFFSET);
-
-	return bootmem_pages;
-}
-
 static int __init check_initrd(struct meminfo *mi)
 {
 	int initrd_node = -2;
@@ -266,9 +184,8 @@ static int __init check_initrd(struct me
 /*
  * Reserve the various regions of node 0
  */
-static __init void reserve_node_zero(unsigned int bootmap_pfn, unsigned int bootmap_pages)
+static __init void reserve_node_zero(pg_data_t *pgdat)
 {
-	pg_data_t *pgdat = NODE_DATA(0);
 	unsigned long res_size = 0;
 
 	/*
@@ -289,13 +206,6 @@ static __init void reserve_node_zero(uns
 			     PTRS_PER_PGD * sizeof(pgd_t));
 
 	/*
-	 * And don't forget to reserve the allocator bitmap,
-	 * which will be freed later.
-	 */
-	reserve_bootmem_node(pgdat, bootmap_pfn << PAGE_SHIFT,
-			     bootmap_pages << PAGE_SHIFT);
-
-	/*
 	 * Hmm... This should go elsewhere, but we really really need to
 	 * stop things allocating the low memory; ideally we need a better
 	 * implementation of GFP_DMA which does not assume that DMA-able
@@ -324,183 +234,276 @@ static __init void reserve_node_zero(uns
 		reserve_bootmem_node(pgdat, PHYS_OFFSET, res_size);
 }
 
-/*
- * Register all available RAM in this node with the bootmem allocator.
- */
-static inline void free_bootmem_node_bank(int node, struct meminfo *mi)
+void __init build_mem_type_table(void);
+void __init create_mapping(struct map_desc *md);
+
+static unsigned long __init
+bootmem_init_node(int node, int initrd_node, struct meminfo *mi)
 {
-	pg_data_t *pgdat = NODE_DATA(node);
-	int bank;
+	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
+	unsigned long start_pfn, end_pfn, boot_pfn;
+	unsigned int boot_pages;
+	pg_data_t *pgdat;
+	int i;
 
-	for (bank = 0; bank < mi->nr_banks; bank++)
-		if (mi->bank[bank].node == node)
-			free_bootmem_node(pgdat, mi->bank[bank].start,
-					  mi->bank[bank].size);
-}
+	start_pfn = -1UL;
+	end_pfn = 0;
 
-/*
- * Initialise the bootmem allocator for all nodes.  This is called
- * early during the architecture specific initialisation.
- */
-static void __init bootmem_init(struct meminfo *mi)
-{
-	struct node_info node_info[MAX_NUMNODES], *np = node_info;
-	unsigned int bootmap_pages, bootmap_pfn, map_pg;
-	int node, initrd_node;
+	/*
+	 * Calculate the pfn range, and map the memory banks for this node.
+	 */
+	for_each_nodebank(i, mi, node) {
+		unsigned long start, end;
+		struct map_desc map;
 
-	bootmap_pages = find_memend_and_nodes(mi, np);
-	bootmap_pfn   = find_bootmap_pfn(0, mi, bootmap_pages);
-	initrd_node   = check_initrd(mi);
+		start = mi->bank[i].start >> PAGE_SHIFT;
+		end = (mi->bank[i].start + mi->bank[i].size) >> PAGE_SHIFT;
 
-	map_pg = bootmap_pfn;
+		if (start_pfn > start)
+			start_pfn = start;
+		if (end_pfn < end)
+			end_pfn = end;
+
+		map.physical = mi->bank[i].start;
+		map.virtual = __phys_to_virt(map.physical);
+		map.length = mi->bank[i].size;
+		map.type = MT_MEMORY;
+
+		create_mapping(&map);
+	}
 
 	/*
-	 * Initialise the bootmem nodes.
-	 *
-	 * What we really want to do is:
-	 *
-	 *   unmap_all_regions_except_kernel();
-	 *   for_each_node_in_reverse_order(node) {
-	 *     map_node(node);
-	 *     allocate_bootmem_map(node);
-	 *     init_bootmem_node(node);
-	 *     free_bootmem_node(node);
-	 *   }
-	 *
-	 * but this is a 2.5-type change.  For now, we just set
-	 * the nodes up in reverse order.
-	 *
-	 * (we could also do with rolling bootmem_init and paging_init
-	 * into one generic "memory_init" type function).
+	 * If there is no memory in this node, ignore it.
 	 */
-	np += num_online_nodes() - 1;
-	for (node = num_online_nodes() - 1; node >= 0; node--, np--) {
-		/*
-		 * If there are no pages in this node, ignore it.
-		 * Note that node 0 must always have some pages.
-		 */
-		if (np->end == 0 || !node_online(node)) {
-			if (node == 0)
-				BUG();
-			continue;
-		}
+	if (end_pfn == 0)
+		return end_pfn;
 
-		/*
-		 * Initialise the bootmem allocator.
-		 */
-		init_bootmem_node(NODE_DATA(node), map_pg, np->start, np->end);
-		free_bootmem_node_bank(node, mi);
-		map_pg += np->bootmap_pages;
+	/*
+	 * Allocate the bootmem bitmap page.
+	 */
+	boot_pages = bootmem_bootmap_pages(end_pfn - start_pfn);
+	boot_pfn = find_bootmap_pfn(node, mi, boot_pages);
 
-		/*
-		 * If this is node 0, we need to reserve some areas ASAP -
-		 * we may use bootmem on node 0 to setup the other nodes.
-		 */
-		if (node == 0)
-			reserve_node_zero(bootmap_pfn, bootmap_pages);
-	}
+	/*
+	 * Initialise the bootmem allocator for this node, handing the
+	 * memory banks over to bootmem.
+	 */
+	node_set_online(node);
+	pgdat = NODE_DATA(node);
+	init_bootmem_node(pgdat, boot_pfn, start_pfn, end_pfn);
 
+	for_each_nodebank(i, mi, node)
+		free_bootmem_node(pgdat, mi->bank[i].start, mi->bank[i].size);
+
+	/*
+	 * Reserve the bootmem bitmap for this node.
+	 */
+	reserve_bootmem_node(pgdat, boot_pfn << PAGE_SHIFT,
+			     boot_pages << PAGE_SHIFT);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	if (phys_initrd_size && initrd_node >= 0) {
-		reserve_bootmem_node(NODE_DATA(initrd_node), phys_initrd_start,
+	/*
+	 * If the initrd is in this node, reserve its memory.
+	 */
+	if (node == initrd_node) {
+		reserve_bootmem_node(pgdat, phys_initrd_start,
 				     phys_initrd_size);
 		initrd_start = __phys_to_virt(phys_initrd_start);
 		initrd_end = initrd_start + phys_initrd_size;
 	}
 #endif
 
-	BUG_ON(map_pg != bootmap_pfn + bootmap_pages);
+	/*
+	 * Finally, reserve any node zero regions.
+	 */
+	if (node == 0)
+		reserve_node_zero(pgdat);
+
+	/*
+	 * initialise the zones within this node.
+	 */
+	memset(zone_size, 0, sizeof(zone_size));
+	memset(zhole_size, 0, sizeof(zhole_size));
+
+	/*
+	 * The size of this node has already been determined.  If we need
+	 * to do anything fancy with the allocation of this memory to the
+	 * zones, now is the time to do it.
+	 */
+	zone_size[0] = end_pfn - start_pfn;
+
+	/*
+	 * For each bank in this node, calculate the size of the holes.
+	 *  holes = node_size - sum(bank_sizes_in_node)
+	 */
+	zhole_size[0] = zone_size[0];
+	for_each_nodebank(i, mi, node)
+		zhole_size[0] -= mi->bank[i].size >> PAGE_SHIFT;
+
+	/*
+	 * Adjust the sizes according to any special requirements for
+	 * this machine type.
+	 */
+	arch_adjust_zones(node, zone_size, zhole_size);
+
+	free_area_init_node(node, pgdat, zone_size, start_pfn, zhole_size);
+
+	return end_pfn;
 }
 
-/*
- * paging_init() sets up the page tables, initialises the zone memory
- * maps, and sets up the zero page, bad page and bad page tables.
- */
-void __init paging_init(struct meminfo *mi, struct machine_desc *mdesc)
+static void __init bootmem_init(struct meminfo *mi)
 {
-	void *zero_page;
-	int node;
+	unsigned long addr, memend_pfn = 0;
+	int node, initrd_node, i;
 
-	bootmem_init(mi);
+	/*
+	 * Invalidate the node number for empty or invalid memory banks
+	 */
+	for (i = 0; i < mi->nr_banks; i++)
+		if (mi->bank[i].size == 0 || mi->bank[i].node >= MAX_NUMNODES)
+			mi->bank[i].node = -1;
 
 	memcpy(&meminfo, mi, sizeof(meminfo));
 
+#ifdef CONFIG_XIP_KERNEL
+#error needs fixing
+	p->physical   = CONFIG_XIP_PHYS_ADDR & PMD_MASK;
+	p->virtual    = (unsigned long)&_stext & PMD_MASK;
+	p->length     = ((unsigned long)&_etext - p->virtual + ~PMD_MASK) & PMD_MASK;
+	p->type       = MT_ROM;
+	p ++;
+#endif
+
 	/*
-	 * allocate the zero page.  Note that we count on this going ok.
+	 * Clear out all the mappings below the kernel image.
+	 * FIXME: what about XIP?
 	 */
-	zero_page = alloc_bootmem_low_pages(PAGE_SIZE);
+	for (addr = 0; addr < PAGE_OFFSET; addr += PGDIR_SIZE)
+		pmd_clear(pmd_off_k(addr));
 
 	/*
-	 * initialise the page tables.
+	 * Clear out all the kernel space mappings, except for the first
+	 * memory bank, up to the end of the vmalloc region.
 	 */
-	memtable_init(mi);
-	if (mdesc->map_io)
-		mdesc->map_io();
-	local_flush_tlb_all();
+	for (addr = __phys_to_virt(mi->bank[0].start + mi->bank[0].size);
+	     addr < VMALLOC_END; addr += PGDIR_SIZE)
+		pmd_clear(pmd_off_k(addr));
 
 	/*
-	 * initialise the zones within each node
+	 * Locate which node contains the ramdisk image, if any.
 	 */
-	for_each_online_node(node) {
-		unsigned long zone_size[MAX_NR_ZONES];
-		unsigned long zhole_size[MAX_NR_ZONES];
-		struct bootmem_data *bdata;
-		pg_data_t *pgdat;
-		int i;
+	initrd_node = check_initrd(mi);
 
-		/*
-		 * Initialise the zone size information.
-		 */
-		for (i = 0; i < MAX_NR_ZONES; i++) {
-			zone_size[i]  = 0;
-			zhole_size[i] = 0;
-		}
+	/*
+	 * Run through each node initialising the bootmem allocator.
+	 */
+	for_each_node(node) {
+		unsigned long end_pfn;
 
-		pgdat = NODE_DATA(node);
-		bdata = pgdat->bdata;
+		end_pfn = bootmem_init_node(node, initrd_node, mi);
 
 		/*
-		 * The size of this node has already been determined.
-		 * If we need to do anything fancy with the allocation
-		 * of this memory to the zones, now is the time to do
-		 * it.
+		 * Remember the highest memory PFN.
 		 */
-		zone_size[0] = bdata->node_low_pfn -
-				(bdata->node_boot_start >> PAGE_SHIFT);
+		if (end_pfn > memend_pfn)
+			memend_pfn = end_pfn;
+	}
 
-		/*
-		 * If this zone has zero size, skip it.
-		 */
-		if (!zone_size[0])
-			continue;
+	high_memory = __va(memend_pfn << PAGE_SHIFT);
 
-		/*
-		 * For each bank in this node, calculate the size of the
-		 * holes.  holes = node_size - sum(bank_sizes_in_node)
-		 */
-		zhole_size[0] = zone_size[0];
-		for (i = 0; i < mi->nr_banks; i++) {
-			if (mi->bank[i].node != node)
-				continue;
+	/*
+	 * This doesn't seem to be used by the Linux memory manager any
+	 * more, but is used by ll_rw_block.  If we can get rid of it, we
+	 * also get rid of some of the stuff above as well.
+	 *
+	 * Note: max_low_pfn and max_pfn reflect the number of _pages_ in
+	 * the system, not the maximum PFN.
+	 */
+	max_pfn = max_low_pfn = memend_pfn - PHYS_PFN_OFFSET;
+}
 
-			zhole_size[0] -= mi->bank[i].size >> PAGE_SHIFT;
-		}
+/*
+ * Set up device the mappings.  Since we clear out the page tables for all
+ * mappings above VMALLOC_END, we will remove any debug device mappings.
+ * This means you have to be careful how you debug this function, or any
+ * called function.  (Do it by code inspection!)
+ */
+static void __init devicemaps_init(struct machine_desc *mdesc)
+{
+	struct map_desc map;
+	unsigned long addr;
+	void *vectors;
 
-		/*
-		 * Adjust the sizes according to any special
-		 * requirements for this machine type.
-		 */
-		arch_adjust_zones(node, zone_size, zhole_size);
+	for (addr = VMALLOC_END; addr; addr += PGDIR_SIZE)
+		pmd_clear(pmd_off_k(addr));
+
+	/*
+	 * Map the cache flushing regions.
+	 */
+#ifdef FLUSH_BASE
+	map.physical = FLUSH_BASE_PHYS;
+	map.virtual = FLUSH_BASE;
+	map.length = PGDIR_SIZE;
+	map.type = MT_CACHECLEAN;
+	create_mapping(&map);
+#endif
+#ifdef FLUSH_BASE_MINICACHE
+	map.physical = FLUSH_BASE_PHYS + PGDIR_SIZE;
+	map.virtual = FLUSH_BASE_MINICACHE;
+	map.length = PGDIR_SIZE;
+	map.type = MT_MINICLEAN;
+	create_mapping(&map);
+#endif
 
-		free_area_init_node(node, pgdat, zone_size,
-				bdata->node_boot_start >> PAGE_SHIFT, zhole_size);
+	flush_cache_all();
+	local_flush_tlb_all();
+
+	vectors = alloc_bootmem_low_pages(PAGE_SIZE);
+	BUG_ON(!vectors);
+
+	/*
+	 * Create a mapping for the machine vectors at the high-vectors
+	 * location (0xffff0000).  If we aren't using high-vectors, also
+	 * create a mapping at the low-vectors virtual address.
+	 */
+	map.physical = virt_to_phys(vectors);
+	map.virtual = 0xffff0000;
+	map.length = PAGE_SIZE;
+	map.type = MT_HIGH_VECTORS;
+	create_mapping(&map);
+
+	if (!vectors_high()) {
+		map.virtual = 0;
+		map.type = MT_LOW_VECTORS;
+		create_mapping(&map);
 	}
 
 	/*
-	 * finish off the bad pages once
-	 * the mem_map is initialised
+	 * Ask the machine support to map in the statically mapped devices.
+	 * After this point, we can start to touch devices again.
+	 */
+	if (mdesc->map_io)
+		mdesc->map_io();
+}
+
+/*
+ * paging_init() sets up the page tables, initialises the zone memory
+ * maps, and sets up the zero page, bad page and bad page tables.
+ */
+void __init paging_init(struct meminfo *mi, struct machine_desc *mdesc)
+{
+	void *zero_page;
+
+	build_mem_type_table();
+	bootmem_init(mi);
+	devicemaps_init(mdesc);
+
+	top_pmd = pmd_off_k(0xffff0000);
+
+	/*
+	 * allocate the zero page.  Note that we count on this going ok.
 	 */
+	zero_page = alloc_bootmem_low_pages(PAGE_SIZE);
 	memzero(zero_page, PAGE_SIZE);
 	empty_zero_page = virt_to_page(zero_page);
 	flush_dcache_page(empty_zero_page);
@@ -562,10 +565,7 @@ static void __init free_unused_memmap_no
 	 * may not be the case, especially if the user has provided the
 	 * information on the command line.
 	 */
-	for (i = 0; i < mi->nr_banks; i++) {
-		if (mi->bank[i].size == 0 || mi->bank[i].node != node)
-			continue;
-
+	for_each_nodebank(i, mi, node) {
 		bank_start = mi->bank[i].start >> PAGE_SHIFT;
 		if (bank_start < prev_bank_end) {
 			printk(KERN_ERR "MEM: unordered memory banks.  "
diff --git a/arch/arm/mm/mm-armv.c b/arch/arm/mm/mm-armv.c
--- a/arch/arm/mm/mm-armv.c
+++ b/arch/arm/mm/mm-armv.c
@@ -305,16 +305,6 @@ alloc_init_page(unsigned long virt, unsi
 	set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, prot));
 }
 
-/*
- * Clear any PGD mapping.  On a two-level page table system,
- * the clearance is done by the middle-level functions (pmd)
- * rather than the top-level (pgd) functions.
- */
-static inline void clear_mapping(unsigned long virt)
-{
-	pmd_clear(pmd_off_k(virt));
-}
-
 struct mem_types {
 	unsigned int	prot_pte;
 	unsigned int	prot_l1;
@@ -373,7 +363,7 @@ static struct mem_types mem_types[] __in
 /*
  * Adjust the PMD section entries according to the CPU in use.
  */
-static void __init build_mem_type_table(void)
+void __init build_mem_type_table(void)
 {
 	struct cachepolicy *cp;
 	unsigned int cr = get_cr();
@@ -483,7 +473,7 @@ static void __init build_mem_type_table(
  * offsets, and we take full advantage of sections and
  * supersections.
  */
-static void __init create_mapping(struct map_desc *md)
+void __init create_mapping(struct map_desc *md)
 {
 	unsigned long virt, length;
 	int prot_sect, prot_l1, domain;
@@ -601,100 +591,6 @@ void setup_mm_for_reboot(char mode)
 	}
 }
 
-extern void _stext, _etext;
-
-/*
- * Setup initial mappings.  We use the page we allocated for zero page to hold
- * the mappings, which will get overwritten by the vectors in traps_init().
- * The mappings must be in virtual address order.
- */
-void __init memtable_init(struct meminfo *mi)
-{
-	struct map_desc *init_maps, *p, *q;
-	unsigned long address = 0;
-	int i;
-
-	build_mem_type_table();
-
-	init_maps = p = alloc_bootmem_low_pages(PAGE_SIZE);
-
-#ifdef CONFIG_XIP_KERNEL
-	p->physical   = CONFIG_XIP_PHYS_ADDR & PMD_MASK;
-	p->virtual    = (unsigned long)&_stext & PMD_MASK;
-	p->length     = ((unsigned long)&_etext - p->virtual + ~PMD_MASK) & PMD_MASK;
-	p->type       = MT_ROM;
-	p ++;
-#endif
-
-	for (i = 0; i < mi->nr_banks; i++) {
-		if (mi->bank[i].size == 0)
-			continue;
-
-		p->physical   = mi->bank[i].start;
-		p->virtual    = __phys_to_virt(p->physical);
-		p->length     = mi->bank[i].size;
-		p->type       = MT_MEMORY;
-		p ++;
-	}
-
-#ifdef FLUSH_BASE
-	p->physical   = FLUSH_BASE_PHYS;
-	p->virtual    = FLUSH_BASE;
-	p->length     = PGDIR_SIZE;
-	p->type       = MT_CACHECLEAN;
-	p ++;
-#endif
-
-#ifdef FLUSH_BASE_MINICACHE
-	p->physical   = FLUSH_BASE_PHYS + PGDIR_SIZE;
-	p->virtual    = FLUSH_BASE_MINICACHE;
-	p->length     = PGDIR_SIZE;
-	p->type       = MT_MINICLEAN;
-	p ++;
-#endif
-
-	/*
-	 * Go through the initial mappings, but clear out any
-	 * pgdir entries that are not in the description.
-	 */
-	q = init_maps;
-	do {
-		if (address < q->virtual || q == p) {
-			clear_mapping(address);
-			address += PGDIR_SIZE;
-		} else {
-			create_mapping(q);
-
-			address = q->virtual + q->length;
-			address = (address + PGDIR_SIZE - 1) & PGDIR_MASK;
-
-			q ++;
-		}
-	} while (address != 0);
-
-	/*
-	 * Create a mapping for the machine vectors at the high-vectors
-	 * location (0xffff0000).  If we aren't using high-vectors, also
-	 * create a mapping at the low-vectors virtual address.
-	 */
-	init_maps->physical   = virt_to_phys(init_maps);
-	init_maps->virtual    = 0xffff0000;
-	init_maps->length     = PAGE_SIZE;
-	init_maps->type       = MT_HIGH_VECTORS;
-	create_mapping(init_maps);
-
-	if (!vectors_high()) {
-		init_maps->virtual = 0;
-		init_maps->type = MT_LOW_VECTORS;
-		create_mapping(init_maps);
-	}
-
-	flush_cache_all();
-	local_flush_tlb_all();
-
-	top_pmd = pmd_off_k(0xffff0000);
-}
-
 /*
  * Create the architecture specific mappings
  */

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
