Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267410AbUGNOJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267410AbUGNOJP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267424AbUGNOJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:09:14 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:3516 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267410AbUGNODx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:03:53 -0400
Date: Wed, 14 Jul 2004 23:03:37 +0900 (JST)
Message-Id: <20040714.230337.09771669.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Cc: linux-mm@kvack.org
Subject: [PATCH] memory hotremoval for linux-2.6.7 [4/16]
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040714.224138.95803956.taka@valinux.co.jp>
References: <20040714.224138.95803956.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


$Id: va-emulation_memhotplug.patch,v 1.23 2004/06/17 08:19:45 iwamoto Exp $

diff -dpur linux-2.6.7/arch/i386/Kconfig linux-2.6.7-mh/arch/i386/Kconfig
--- linux-2.6.7/arch/i386/Kconfig	Thu Mar 11 11:55:22 2004
+++ linux-2.6.7-mh/arch/i386/Kconfig	Thu Apr  1 14:46:19 2004
@@ -736,7 +736,7 @@ config DISCONTIGMEM
 
 config HAVE_ARCH_BOOTMEM_NODE
 	bool
-	depends on NUMA
+	depends on NUMA || MEMHOTPLUG
 	default y
 
 config HIGHPTE
diff -dpur linux-2.6.7/arch/i386/mm/discontig.c linux-2.6.7-mh/arch/i386/mm/discontig.c
--- linux-2.6.7/arch/i386/mm/discontig.c	Sun Apr  4 12:37:23 2004
+++ linux-2.6.7-mh/arch/i386/mm/discontig.c	Tue Apr 27 17:41:22 2004
@@ -64,6 +64,7 @@ unsigned long node_end_pfn[MAX_NUMNODES]
 extern unsigned long find_max_low_pfn(void);
 extern void find_max_pfn(void);
 extern void one_highpage_init(struct page *, int, int);
+static unsigned long calculate_blk_remap_pages(void);
 
 extern struct e820map e820;
 extern unsigned long init_pg_tables_end;
@@ -111,6 +112,51 @@ int __init get_memcfg_numa_flat(void)
 	return 1;
 }
 
+int __init get_memcfg_numa_blks(void)
+{
+	int i, pfn;
+
+	printk("NUMA - single node, flat memory mode, but broken in several blocks\n");
+
+	/* Run the memory configuration and find the top of memory. */
+	find_max_pfn();
+	if (max_pfn & (PTRS_PER_PTE - 1)) {
+		pfn = max_pfn & ~(PTRS_PER_PTE - 1);
+		printk("Rounding down maxpfn %ld -> %d\n", max_pfn, pfn);
+		max_pfn = pfn;
+	}
+	for(i = 0; i < MAX_NUMNODES; i++) {
+		pfn = PFN_DOWN(CONFIG_MEMHOTPLUG_BLKSIZE << 20) * i;
+		node_start_pfn[i]  = pfn;
+		printk("node %d start %d\n", i, pfn);
+		pfn += PFN_DOWN(CONFIG_MEMHOTPLUG_BLKSIZE << 20);
+		if (pfn < max_pfn)
+			node_end_pfn[i]	  = pfn;
+		else {
+			node_end_pfn[i]	  = max_pfn;
+			i++;
+			printk("total %d blocks, max %ld\n", i, max_pfn);
+			break;
+		}
+	}
+
+	printk("physnode_map");
+	/* Needed for pfn_to_nid */
+	for (pfn = node_start_pfn[0]; pfn <= max_pfn;
+	       pfn += PAGES_PER_ELEMENT)
+	{
+		physnode_map[pfn / PAGES_PER_ELEMENT] =
+		    pfn / PFN_DOWN(CONFIG_MEMHOTPLUG_BLKSIZE << 20);
+		printk(" %d", physnode_map[pfn / PAGES_PER_ELEMENT]);
+	}
+	printk("\n");
+
+	node_set_online(0);
+	numnodes = i;
+	
+	return 1;
+}
+
 /*
  * Find the highest page frame number we have available for the node
  */
@@ -132,11 +178,21 @@ static void __init find_max_pfn_node(int
  * Allocate memory for the pg_data_t via a crude pre-bootmem method
  * We ought to relocate these onto their own node later on during boot.
  */
-static void __init allocate_pgdat(int nid)
+static void allocate_pgdat(int nid)
 {
-	if (nid)
+	if (nid) {
+#ifndef CONFIG_MEMHOTPLUG
 		NODE_DATA(nid) = (pg_data_t *)node_remap_start_vaddr[nid];
-	else {
+#else
+		int remapsize;
+		unsigned long addr;
+
+		remapsize = calculate_blk_remap_pages();
+		addr = (unsigned long)(pfn_to_kaddr(max_low_pfn +
+		    (nid - 1) * remapsize));
+		NODE_DATA(nid) = (void *)addr;
+#endif
+	} else {
 		NODE_DATA(nid) = (pg_data_t *)(__va(min_low_pfn << PAGE_SHIFT));
 		min_low_pfn += PFN_UP(sizeof(pg_data_t));
 		memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
@@ -185,6 +241,7 @@ static void __init register_bootmem_low_
 
 void __init remap_numa_kva(void)
 {
+#ifndef CONFIG_MEMHOTPLUG
 	void *vaddr;
 	unsigned long pfn;
 	int node;
@@ -197,6 +254,7 @@ void __init remap_numa_kva(void)
 				PAGE_KERNEL_LARGE);
 		}
 	}
+#endif
 }
 
 static unsigned long calculate_numa_remap_pages(void)
@@ -227,6 +285,21 @@ static unsigned long calculate_numa_rema
 	return reserve_pages;
 }
 
+static unsigned long calculate_blk_remap_pages(void)
+{
+	unsigned long size;
+
+	/* calculate the size of the mem_map needed in bytes */
+	size = (PFN_DOWN(CONFIG_MEMHOTPLUG_BLKSIZE << 20) + 1)
+		* sizeof(struct page) + sizeof(pg_data_t);
+	/* convert size to large (pmd size) pages, rounding up */
+	size = (size + LARGE_PAGE_BYTES - 1) / LARGE_PAGE_BYTES;
+	/* now the roundup is correct, convert to PAGE_SIZE pages */
+	size = size * PTRS_PER_PTE;
+
+	return size;
+}
+
 unsigned long __init setup_memory(void)
 {
 	int nid;
@@ -234,13 +307,14 @@ unsigned long __init setup_memory(void)
 	unsigned long reserve_pages;
 
 	get_memcfg_numa();
-	reserve_pages = calculate_numa_remap_pages();
+	reserve_pages = calculate_blk_remap_pages() * (numnodes - 1);
 
 	/* partially used pages are not usable - thus round upwards */
 	system_start_pfn = min_low_pfn = PFN_UP(init_pg_tables_end);
 
 	find_max_pfn();
-	system_max_low_pfn = max_low_pfn = find_max_low_pfn();
+	system_max_low_pfn = max_low_pfn = (find_max_low_pfn() &
+	    ~(PTRS_PER_PTE - 1));
 #ifdef CONFIG_HIGHMEM
 	highstart_pfn = highend_pfn = max_pfn;
 	if (max_pfn > system_max_low_pfn)
@@ -256,14 +330,19 @@ unsigned long __init setup_memory(void)
 
 	printk("Low memory ends at vaddr %08lx\n",
 			(ulong) pfn_to_kaddr(max_low_pfn));
+#ifdef CONFIG_MEMHOTPLUG
+	for (nid = 1; nid < numnodes; nid++)
+		NODE_DATA(nid) = NULL;
+	nid = 0;
+	{
+#else
 	for (nid = 0; nid < numnodes; nid++) {
+#endif
 		node_remap_start_vaddr[nid] = pfn_to_kaddr(
-			highstart_pfn - node_remap_offset[nid]);
+			max_low_pfn + calculate_blk_remap_pages() * nid);
 		allocate_pgdat(nid);
-		printk ("node %d will remap to vaddr %08lx - %08lx\n", nid,
-			(ulong) node_remap_start_vaddr[nid],
-			(ulong) pfn_to_kaddr(highstart_pfn
-			    - node_remap_offset[nid] + node_remap_size[nid]));
+		printk ("node %d will remap to vaddr %08lx - \n", nid,
+			(ulong) node_remap_start_vaddr[nid]);
 	}
 	printk("High memory starts at vaddr %08lx\n",
 			(ulong) pfn_to_kaddr(highstart_pfn));
@@ -275,9 +354,12 @@ unsigned long __init setup_memory(void)
 	/*
 	 * Initialize the boot-time allocator (with low memory only):
 	 */
-	bootmap_size = init_bootmem_node(NODE_DATA(0), min_low_pfn, 0, system_max_low_pfn);
+	bootmap_size = init_bootmem_node(NODE_DATA(0), min_low_pfn, 0,
+	    (system_max_low_pfn > node_end_pfn[0]) ?
+	    node_end_pfn[0] : system_max_low_pfn);
 
-	register_bootmem_low_pages(system_max_low_pfn);
+	register_bootmem_low_pages((system_max_low_pfn > node_end_pfn[0]) ?
+	    node_end_pfn[0] : system_max_low_pfn);
 
 	/*
 	 * Reserve the bootmem bitmap itself as well. We do this in two
@@ -342,14 +424,26 @@ void __init zone_sizes_init(void)
 	 * Clobber node 0's links and NULL out pgdat_list before starting.
 	 */
 	pgdat_list = NULL;
-	for (nid = numnodes - 1; nid >= 0; nid--) {       
+#ifndef CONFIG_MEMHOTPLUG
+	for (nid = numnodes - 1; nid >= 0; nid--) {
+#else
+	nid = 0;
+	{
+#endif
 		if (nid)
 			memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
+		if (nid == 0)
+			NODE_DATA(nid)->enabled = 1;
 		NODE_DATA(nid)->pgdat_next = pgdat_list;
 		pgdat_list = NODE_DATA(nid);
 	}
 
+#ifdef CONFIG_MEMHOTPLUG
+	nid = 0;
+	{
+#else
 	for (nid = 0; nid < numnodes; nid++) {
+#endif
 		unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
 		unsigned long *zholes_size;
 		unsigned int max_dma;
@@ -368,14 +462,17 @@ void __init zone_sizes_init(void)
 		} else {
 			if (low < max_dma)
 				zones_size[ZONE_DMA] = low;
-			else {
+			else if (low <= high) {
 				BUG_ON(max_dma > low);
-				BUG_ON(low > high);
 				zones_size[ZONE_DMA] = max_dma;
 				zones_size[ZONE_NORMAL] = low - max_dma;
 #ifdef CONFIG_HIGHMEM
 				zones_size[ZONE_HIGHMEM] = high - low;
 #endif
+			} else {
+				BUG_ON(max_dma > low);
+				zones_size[ZONE_DMA] = max_dma;
+				zones_size[ZONE_NORMAL] = high - max_dma;
 			}
 		}
 		zholes_size = get_zholes_size(nid);
@@ -405,7 +502,11 @@ void __init set_highmem_pages_init(int b
 #ifdef CONFIG_HIGHMEM
 	int nid;
 
+#ifdef CONFIG_MEMHOTPLUG
+	for (nid = 0; nid < 1; nid++) {
+#else
 	for (nid = 0; nid < numnodes; nid++) {
+#endif
 		unsigned long node_pfn, node_high_size, zone_start_pfn;
 		struct page * zone_mem_map;
 		
@@ -423,12 +524,234 @@ void __init set_highmem_pages_init(int b
 #endif
 }
 
-void __init set_max_mapnr_init(void)
+void set_max_mapnr_init(void)
 {
 #ifdef CONFIG_HIGHMEM
+#ifndef CONFIG_MEMHOTPLUG
 	highmem_start_page = NODE_DATA(0)->node_zones[ZONE_HIGHMEM].zone_mem_map;
+#else
+	struct pglist_data *z = NULL;
+	int i;
+
+	for (i = 0; i < numnodes; i++) {
+		if (NODE_DATA(i) == NULL)
+			continue;
+		z = NODE_DATA(i);
+		highmem_start_page = z->node_zones[ZONE_HIGHMEM].zone_mem_map;
+		if (highmem_start_page != NULL)
+			break;
+	}
+	if (highmem_start_page == NULL)
+		highmem_start_page =
+		    z->node_zones[ZONE_NORMAL].zone_mem_map +
+		    z->node_zones[ZONE_NORMAL].spanned_pages;
+#endif
 	num_physpages = highend_pfn;
 #else
 	num_physpages = max_low_pfn;
 #endif
 }
+
+void
+plug_node(int nid)
+{
+	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+	unsigned long *zholes_size, addr, pfn;
+	unsigned long remapsize;
+	unsigned long flags;
+	int i, j;
+	struct page *node_mem_map, *page;
+	pg_data_t **pgdat;
+	struct mm_struct *mm;
+
+	unsigned long start = node_start_pfn[nid];
+	unsigned long high = node_end_pfn[nid];
+
+	BUG_ON(nid == 0);
+
+	allocate_pgdat(nid);
+
+	remapsize = calculate_blk_remap_pages();
+	addr = (unsigned long)(pfn_to_kaddr(max_low_pfn +
+	    (nid - 1) * remapsize));
+	
+	/* shrink size,
+	   which is done in calculate_numa_remap_pages() if normal NUMA */
+	high -= remapsize;
+	BUG_ON(start > high);
+
+	for(pfn = 0; pfn < remapsize; pfn += PTRS_PER_PTE)
+                set_pmd_pfn(addr + (pfn << PAGE_SHIFT), high + pfn,
+                    PAGE_KERNEL_LARGE);
+	spin_lock_irqsave(&pgd_lock, flags);
+	for (page = pgd_list; page; page = (struct page *)page->index) {
+		for(pfn = 0; pfn < remapsize; pfn += PTRS_PER_PTE) {
+			pgd_t *pgd;
+			pmd_t *pmd;
+
+			pgd = (pgd_t *)page_address(page) +
+			    pgd_index(addr + (pfn << PAGE_SHIFT));
+			pmd = pmd_offset(pgd, addr + (pfn << PAGE_SHIFT));
+			set_pmd(pmd, pfn_pmd(high + pfn, PAGE_KERNEL_LARGE));
+		}
+	}
+	spin_unlock_irqrestore(&pgd_lock, flags);
+	flush_tlb_all();
+
+	node_mem_map = (struct page *)((addr + sizeof(pg_data_t) +
+	    PAGE_SIZE - 1) & PAGE_MASK);
+	memset(node_mem_map, 0, (remapsize << PAGE_SHIFT) -
+	    ((char *)node_mem_map - (char *)addr));
+
+	printk("plug_node: %p %p\n", NODE_DATA(nid), node_mem_map);
+	memset(NODE_DATA(nid), 0, sizeof(*NODE_DATA(nid)));
+	printk("zeroed nodedata\n");
+
+	/* XXX defaults to hotremovable */ 
+	NODE_DATA(nid)->removable = 1;
+
+	BUG_ON(virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT > start);
+	if (start <= max_low_pfn)
+		zones_size[ZONE_NORMAL] =
+		    (max_low_pfn > high ? high : max_low_pfn) - start;
+#ifdef CONFIG_HIGHMEM
+	if (high > max_low_pfn)
+		zones_size[ZONE_HIGHMEM] = high -
+		    ((start > max_low_pfn) ? start : max_low_pfn);
+#endif
+	zholes_size = get_zholes_size(nid);
+	free_area_init_node(nid, NODE_DATA(nid), node_mem_map, zones_size,
+	    start, zholes_size);
+
+	/* lock? */
+	for(pgdat = &pgdat_list; *pgdat; pgdat = &(*pgdat)->pgdat_next)
+		if ((*pgdat)->node_id > nid) {
+			NODE_DATA(nid)->pgdat_next = *pgdat;
+			*pgdat = NODE_DATA(nid);
+			break;
+		}
+	if (*pgdat == NULL)
+		*pgdat = NODE_DATA(nid);
+	{
+		struct zone *z;
+		for_each_zone (z)
+			printk("%p ", z);
+		printk("\n");
+	}
+	set_max_mapnr_init();
+
+	for(i = 0; i < MAX_NR_ZONES; i++) {
+		struct zone *z;
+		struct page *p;
+
+		z = &NODE_DATA(nid)->node_zones[i];
+
+		for(j = 0; j < z->spanned_pages; j++) {
+			p = &z->zone_mem_map[j];
+			ClearPageReserved(p);
+			if (i == ZONE_HIGHMEM)
+				set_bit(PG_highmem, &p->flags);
+			set_page_count(p, 1);
+			__free_page(p);
+		}
+	}
+	kswapd_start_one(NODE_DATA(nid));
+	setup_per_zone_pages_min();
+}
+
+void
+enable_node(int node)
+{
+	int i;
+	struct zone *z;
+
+	NODE_DATA(node)->enabled = 1;
+	build_all_zonelists();
+
+	for(i = 0; i < MAX_NR_ZONES; i++) {
+		z = zone_table[NODEZONE(node, i)];
+		totalram_pages += z->present_pages;
+		if (i == ZONE_HIGHMEM)
+			totalhigh_pages += z->present_pages;
+	}
+}
+
+void
+makepermanent_node(int node)
+{
+
+	NODE_DATA(node)->removable = 0;
+	build_all_zonelists();
+}
+	
+void
+disable_node(int node)
+{
+	int i;
+	struct zone *z;
+
+	NODE_DATA(node)->enabled = 0;
+	build_all_zonelists();
+
+	for(i = 0; i < MAX_NR_ZONES; i++) {
+		z = zone_table[NODEZONE(node, i)];
+		totalram_pages -= z->present_pages;
+		if (i == ZONE_HIGHMEM)
+			totalhigh_pages -= z->present_pages;
+	}
+}
+
+int
+unplug_node(int nid)
+{
+	int i;
+	struct zone *z;
+	pg_data_t *pgdat;
+	struct page *page;
+	unsigned long addr, pfn, remapsize;
+	unsigned long flags;
+
+	if (NODE_DATA(nid)->enabled)
+		return -1;
+	for(i = 0; i < MAX_NR_ZONES; i++) {
+		z = zone_table[NODEZONE(nid, i)];
+		if (z->present_pages != z->free_pages)
+			return -1;
+	}
+	kthread_stop(NODE_DATA(nid)->kswapd);
+
+	/* lock? */
+	for(pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
+		if (pgdat->pgdat_next == NODE_DATA(nid)) {
+			pgdat->pgdat_next = pgdat->pgdat_next->pgdat_next;
+			break;
+		}
+	BUG_ON(pgdat == NULL);
+
+	for(i = 0; i < MAX_NR_ZONES; i++)
+		zone_table[NODEZONE(nid, i)] = NULL;
+	NODE_DATA(nid) = NULL;
+
+	/* unmap node_mem_map */
+	remapsize = calculate_blk_remap_pages();
+	addr = (unsigned long)(pfn_to_kaddr(max_low_pfn +
+	    (nid - 1) * remapsize));
+	for(pfn = 0; pfn < remapsize; pfn += PTRS_PER_PTE)
+                set_pmd_pfn(addr + (pfn << PAGE_SHIFT), 0, __pgprot(0));
+	spin_lock_irqsave(&pgd_lock, flags);
+	for (page = pgd_list; page; page = (struct page *)page->index) {
+		for(pfn = 0; pfn < remapsize; pfn += PTRS_PER_PTE) {
+			pgd_t *pgd;
+			pmd_t *pmd;
+
+			pgd = (pgd_t *)page_address(page) +
+			    pgd_index(addr + (pfn << PAGE_SHIFT));
+			pmd = pmd_offset(pgd, addr + (pfn << PAGE_SHIFT));
+			pmd_clear(pmd);
+		}
+	}
+	spin_unlock_irqrestore(&pgd_lock, flags);
+	flush_tlb_all();
+
+	return 0;
+}
diff -dpur linux-2.6.7/arch/i386/mm/init.c linux-2.6.7-mh/arch/i386/mm/init.c
--- linux-2.6.7/arch/i386/mm/init.c	Thu Mar 11 11:55:37 2004
+++ linux-2.6.7-mh/arch/i386/mm/init.c	Wed Mar 31 19:38:26 2004
@@ -43,6 +43,7 @@
 
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 unsigned long highstart_pfn, highend_pfn;
+extern unsigned long node_end_pfn[MAX_NUMNODES];
 
 static int do_test_wp_bit(void);
 
@@ -481,7 +482,11 @@ void __init mem_init(void)
 	totalram_pages += __free_all_bootmem();
 
 	reservedpages = 0;
+#ifdef CONFIG_MEMHOTPLUG
+	for (tmp = 0; tmp < node_end_pfn[0]; tmp++)
+#else
 	for (tmp = 0; tmp < max_low_pfn; tmp++)
+#endif
 		/*
 		 * Only count reserved RAM pages
 		 */
diff -dpur linux-2.6.7/include/asm-i386/mmzone.h linux-2.6.7-mh/include/asm-i386/mmzone.h
--- linux-2.6.7/include/asm-i386/mmzone.h	Thu Mar 11 11:55:27 2004
+++ linux-2.6.7-mh/include/asm-i386/mmzone.h	Wed Mar 31 19:38:26 2004
@@ -17,7 +17,9 @@
 		#include <asm/srat.h>
 	#endif
 #else /* !CONFIG_NUMA */
+#ifndef CONFIG_MEMHOTPLUG
 	#define get_memcfg_numa get_memcfg_numa_flat
+#endif
 	#define get_zholes_size(n) (0)
 #endif /* CONFIG_NUMA */
 
@@ -41,7 +43,7 @@ extern u8 physnode_map[];
 
 static inline int pfn_to_nid(unsigned long pfn)
 {
-#ifdef CONFIG_NUMA
+#if defined(CONFIG_NUMA) || defined (CONFIG_MEMHOTPLUG)
 	return(physnode_map[(pfn) / PAGES_PER_ELEMENT]);
 #else
 	return 0;
@@ -132,6 +134,10 @@ static inline int pfn_valid(int pfn)
 #endif
 
 extern int get_memcfg_numa_flat(void );
+#ifdef CONFIG_MEMHOTPLUG
+extern int get_memcfg_numa_blks(void);
+#endif
+
 /*
  * This allows any one NUMA architecture to be compiled
  * for, and still fall back to the flat function if it
@@ -144,6 +150,9 @@ static inline void get_memcfg_numa(void)
 		return;
 #elif CONFIG_ACPI_SRAT
 	if (get_memcfg_from_srat())
+		return;
+#elif CONFIG_MEMHOTPLUG
+	if (get_memcfg_numa_blks())
 		return;
 #endif
 
diff -dpur linux-2.6.7/include/asm-i386/numnodes.h linux-2.6.7-mh/include/asm-i386/numnodes.h
--- linux-2.6.7/include/asm-i386/numnodes.h	Thu Mar 11 11:55:23 2004
+++ linux-2.6.7-mh/include/asm-i386/numnodes.h	Wed Mar 31 19:38:26 2004
@@ -13,6 +13,8 @@
 /* Max 8 Nodes */
 #define NODES_SHIFT	3
 
-#endif /* CONFIG_X86_NUMAQ */
+#elif defined(CONFIG_MEMHOTPLUG)
+#define NODES_SHIFT	3
+#endif
 
 #endif /* _ASM_MAX_NUMNODES_H */
diff -dpur linux-2.6.7/mm/page_alloc.c linux-2.6.7-mh/mm/page_alloc.c
--- linux-2.6.7/mm/page_alloc.c	Thu Mar 11 11:55:22 2004
+++ linux-2.6.7-mh/mm/page_alloc.c	Thu Apr  1 16:54:26 2004
@@ -1177,7 +1177,12 @@ static inline unsigned long wait_table_b
 
 #define LONG_ALIGN(x) (((x)+(sizeof(long))-1)&~((sizeof(long))-1))
 
-static void __init calculate_zone_totalpages(struct pglist_data *pgdat,
+#ifdef CONFIG_MEMHOTPLUG
+static void
+#else
+static void __init
+#endif
+calculate_zone_totalpages(struct pglist_data *pgdat,
 		unsigned long *zones_size, unsigned long *zholes_size)
 {
 	unsigned long realtotalpages, totalpages = 0;
@@ -1231,8 +1236,13 @@ void __init memmap_init_zone(struct page
  *   - mark all memory queues empty
  *   - clear the memory bitmaps
  */
-static void __init free_area_init_core(struct pglist_data *pgdat,
-		unsigned long *zones_size, unsigned long *zholes_size)
+#ifdef CONFIG_MEMHOTPLUG
+static void
+#else
+static void __init
+#endif
+free_area_init_core(struct pglist_data *pgdat,
+	unsigned long *zones_size, unsigned long *zholes_size)
 {
 	unsigned long i, j;
 	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
@@ -1371,7 +1381,12 @@ static void __init free_area_init_core(s
 	}
 }
 
-void __init free_area_init_node(int nid, struct pglist_data *pgdat,
+#ifdef CONFIG_MEMHOTPLUG
+void
+#else
+void __init
+#endif
+free_area_init_node(int nid, struct pglist_data *pgdat,
 		struct page *node_mem_map, unsigned long *zones_size,
 		unsigned long node_start_pfn, unsigned long *zholes_size)
 {
