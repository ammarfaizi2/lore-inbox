Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbUB0MHp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 07:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUB0MHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 07:07:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:45242 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261803AbUB0MGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 07:06:55 -0500
Subject: [PATCH] ppc64 iommu rewrite part 1/5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077883082.22215.347.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 22:58:03 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the accounting of physical RAM.

On machines with an IO hole (like Apple G5 with more than 2Gb of RAM,
but also some pSeries) we failed to properly account for the real
amount of physical RAM and inform the zone allocator of our hole size.

During the process, I included Anton slaughtering of the guard page we
had in the first 256Mb kernel segment, thus allowing this segment to be
mapped with large pages as it should be.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/02/27 21:55:55+11:00 benh@kernel.crashing.org 
#   ppc64: Fix physical memory accounting on machines with IO hole and
#   remove guard page, kernel mapping is now 100% large pages
# 
# include/asm-ppc64/page.h
#   2004/02/27 21:43:23+11:00 benh@kernel.crashing.org +3 -0
#   ppc64: Fix physical memory accounting on machines with IO hole and
#   remove guard page, kernel mapping is now 100% large pages
# 
# arch/ppc64/mm/numa.c
#   2004/02/27 21:43:23+11:00 benh@kernel.crashing.org +22 -7
#   ppc64: Fix physical memory accounting on machines with IO hole and
#   remove guard page, kernel mapping is now 100% large pages
# 
# arch/ppc64/mm/init.c
#   2004/02/27 21:43:23+11:00 benh@kernel.crashing.org +76 -18
#   ppc64: Fix physical memory accounting on machines with IO hole and
#   remove guard page, kernel mapping is now 100% large pages
# 
# arch/ppc64/mm/hash_utils.c
#   2004/02/27 21:43:23+11:00 benh@kernel.crashing.org +16 -12
#   ppc64: Fix physical memory accounting on machines with IO hole and
#   remove guard page, kernel mapping is now 100% large pages
# 
# arch/ppc64/kernel/stab.c
#   2004/02/27 21:43:22+11:00 benh@kernel.crashing.org +5 -1
#   ppc64: Fix physical memory accounting on machines with IO hole and
#   remove guard page, kernel mapping is now 100% large pages
# 
# arch/ppc64/kernel/lmb.c
#   2004/02/27 21:43:22+11:00 benh@kernel.crashing.org +10 -10
#   ppc64: Fix physical memory accounting on machines with IO hole and
#   remove guard page, kernel mapping is now 100% large pages
# 
diff -Nru a/arch/ppc64/kernel/lmb.c b/arch/ppc64/kernel/lmb.c
--- a/arch/ppc64/kernel/lmb.c	Fri Feb 27 22:42:19 2004
+++ b/arch/ppc64/kernel/lmb.c	Fri Feb 27 22:42:19 2004
@@ -269,11 +269,13 @@
 	return _lmb->memory.size;
 #else
 	struct lmb_region *_mem = &(_lmb->memory);
-	unsigned long idx = _mem->cnt-1;
-	unsigned long lastbase = _mem->region[idx].physbase;
-	unsigned long lastsize = _mem->region[idx].size;
-	
-	return (lastbase + lastsize);
+	unsigned long total = 0;
+	int i;
+
+	/* add all physical memory to the bootmem map */
+	for (i=0; i < _mem->cnt; i++)
+		total += _mem->region[i].size;
+	return total;
 #endif /* CONFIG_MSCHUNKS */
 }
 
@@ -283,15 +285,13 @@
 	unsigned long offset = reloc_offset();
 	struct lmb *_lmb = PTRRELOC(&lmb);
 	struct lmb_region *_mem = &(_lmb->memory);
-	unsigned long idx;
+	int idx = _mem->cnt - 1;
 
-	for(idx=_mem->cnt-1; idx >= 0; idx--) {
 #ifdef CONFIG_MSCHUNKS
-		return (_mem->region[idx].physbase + _mem->region[idx].size);
+	return (_mem->region[idx].physbase + _mem->region[idx].size);
 #else
-		return (_mem->region[idx].base + _mem->region[idx].size);
+	return (_mem->region[idx].base + _mem->region[idx].size);
 #endif /* CONFIG_MSCHUNKS */
-	}
 
 	return 0;
 }
diff -Nru a/arch/ppc64/kernel/stab.c b/arch/ppc64/kernel/stab.c
--- a/arch/ppc64/kernel/stab.c	Fri Feb 27 22:42:19 2004
+++ b/arch/ppc64/kernel/stab.c	Fri Feb 27 22:42:19 2004
@@ -32,10 +32,14 @@
 void stab_initialize(unsigned long stab)
 {
 	unsigned long esid, vsid; 
+	int seg0_largepages = 0;
 
 	esid = GET_ESID(KERNELBASE);
 	vsid = get_kernel_vsid(esid << SID_SHIFT); 
 
+	if (cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE)
+		seg0_largepages = 1;
+
 	if (cur_cpu_spec->cpu_features & CPU_FTR_SLB) {
 		/* Invalidate the entire SLB & all the ERATS */
 #ifdef CONFIG_PPC_ISERIES
@@ -44,7 +48,7 @@
 		asm volatile("isync":::"memory");
 		asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
 		asm volatile("isync; slbia; isync":::"memory");
-		make_slbe(esid, vsid, 0, 1);
+		make_slbe(esid, vsid, seg0_largepages, 1);
 		asm volatile("isync":::"memory");
 #endif
 	} else {
diff -Nru a/arch/ppc64/mm/hash_utils.c b/arch/ppc64/mm/hash_utils.c
--- a/arch/ppc64/mm/hash_utils.c	Fri Feb 27 22:42:19 2004
+++ b/arch/ppc64/mm/hash_utils.c	Fri Feb 27 22:42:19 2004
@@ -123,6 +123,7 @@
 	unsigned long table, htab_size_bytes;
 	unsigned long pteg_count;
 	unsigned long mode_rw;
+	int i, use_largepages = 0;
 
 	/*
 	 * Calculate the required size of the htab.  We want the number of
@@ -165,18 +166,21 @@
 
 	mode_rw = _PAGE_ACCESSED | _PAGE_COHERENT | PP_RWXX;
 
-	/* XXX we currently map kernel text rw, should fix this */
-	if ((cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE)
-	    && systemcfg->physicalMemorySize > 256*MB) {
-		create_pte_mapping((unsigned long)KERNELBASE, 
-				   KERNELBASE + 256*MB, mode_rw, 0);
-		create_pte_mapping((unsigned long)KERNELBASE + 256*MB, 
-				   KERNELBASE + (systemcfg->physicalMemorySize), 
-				   mode_rw, 1);
-	} else {
-		create_pte_mapping((unsigned long)KERNELBASE, 
-				   KERNELBASE+(systemcfg->physicalMemorySize), 
-				   mode_rw, 0);
+	/* On U3 based machines, we need to reserve the DART area and
+	 * _NOT_ map it to avoid cache paradoxes as it's remapped non
+	 * cacheable later on
+	 */
+	if (cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE)
+		use_largepages = 1;
+
+	/* add all physical memory to the bootmem map */
+	for (i=0; i < lmb.memory.cnt; i++) {
+		unsigned long base, size;
+
+		base = lmb.memory.region[i].physbase + KERNELBASE;
+		size = lmb.memory.region[i].size;
+
+		create_pte_mapping(base, base + size, mode_rw, use_largepages);
 	}
 }
 #undef KB
diff -Nru a/arch/ppc64/mm/init.c b/arch/ppc64/mm/init.c
--- a/arch/ppc64/mm/init.c	Fri Feb 27 22:42:19 2004
+++ b/arch/ppc64/mm/init.c	Fri Feb 27 22:42:19 2004
@@ -91,6 +91,11 @@
 /* max amount of RAM to use */
 unsigned long __max_memory;
 
+/* info on what we think the IO hole is */
+unsigned long 	io_hole_start;
+unsigned long	io_hole_size;
+unsigned long	top_of_ram;
+
 /* This is declared as we are using the more or less generic 
  * include/asm-ppc64/tlb.h file -- tgall
  */
@@ -647,8 +652,7 @@
  */
 void __init mm_init_ppc64(void)
 {
-	struct paca_struct *lpaca;
-	unsigned long guard_page, index;
+	unsigned long i;
 
 	ppc64_boot_msg(0x100, "MM Init");
 
@@ -660,20 +664,63 @@
 	mmu_context_queue.head = 0;
 	mmu_context_queue.tail = NUM_USER_CONTEXT-1;
 	mmu_context_queue.size = NUM_USER_CONTEXT;
-	for(index=0; index < NUM_USER_CONTEXT ;index++) {
-		mmu_context_queue.elements[index] = index+FIRST_USER_CONTEXT;
-	}
+	for (i = 0; i < NUM_USER_CONTEXT; i++)
+		mmu_context_queue.elements[i] = i + FIRST_USER_CONTEXT;
+
+	/* This is the story of the IO hole... please, keep seated,
+	 * unfortunately, we are out of oxygen masks at the moment.
+	 * So we need some rough way to tell where your big IO hole
+	 * is. On pmac, it's between 2G and 4G, on POWER3, it's around
+	 * that area as well, on POWER4 we don't have one, etc...
+	 * We need that to implement something approx. decent for
+	 * page_is_ram() so that /dev/mem doesn't map cacheable IO space
+	 * when XFree resquest some IO regions witout using O_SYNC, we
+	 * also need that as a "hint" when sizing the TCE table on POWER3
+	 * So far, the simplest way that seem work well enough for us it
+	 * to just assume that the first discontinuity in our physical
+	 * RAM layout is the IO hole. That may not be correct in the future
+	 * (and isn't on iSeries but then we don't care ;)
+	 */
+	top_of_ram = lmb_end_of_DRAM();
 
-	/* Setup guard pages for the Paca's */
-	for (index = 0; index < NR_CPUS; index++) {
-		lpaca = &paca[index];
-		guard_page = ((unsigned long)lpaca) + 0x1000;
-		ppc_md.hpte_updateboltedpp(PP_RXRX, guard_page);
+#ifndef CONFIG_PPC_ISERIES
+	for (i = 1; i < lmb.memory.cnt; i++) {
+		unsigned long base, prevbase, prevsize;
+
+		prevbase = lmb.memory.region[i-1].physbase;
+		prevsize = lmb.memory.region[i-1].size;
+		base = lmb.memory.region[i].physbase;
+		if (base > (prevbase + prevsize)) {
+			io_hole_start = prevbase + prevsize;
+			io_hole_size = base  - (prevbase + prevsize);
+			break;
+		}
 	}
+#endif /* CONFIG_PPC_ISERIES */
+	if (io_hole_start)
+		printk("IO Hole assumed to be %lx -> %lx\n",
+		       io_hole_start, io_hole_start + io_hole_size - 1);
 
 	ppc64_boot_msg(0x100, "MM Init Done");
 }
 
+
+/*
+ * This is called by /dev/mem to know if a given address has to
+ * be mapped non-cacheable or not
+ */
+int page_is_ram(unsigned long physaddr)
+{
+#ifdef CONFIG_PPC_ISERIES
+	return 1;
+#endif
+	if (physaddr >= top_of_ram)
+		return 0;
+	return io_hole_start == 0 ||  physaddr < io_hole_start ||
+		physaddr >= (io_hole_start + io_hole_size);
+}
+
+
 /*
  * Initialize the bootmem system and give it all the memory we
  * have available.
@@ -698,7 +745,7 @@
 
 	boot_mapsize = init_bootmem(start >> PAGE_SHIFT, total_pages);
 
-	/* add all physical memory to the bootmem map */
+	/* add all physical memory to the bootmem map. Also find the first */
 	for (i=0; i < lmb.memory.cnt; i++) {
 		unsigned long physbase, size;
 
@@ -721,17 +768,28 @@
  */
 void __init paging_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES], i;
-
+	unsigned long zones_size[MAX_NR_ZONES];
+	unsigned long zholes_size[MAX_NR_ZONES];
+	unsigned long total_ram = lmb_phys_mem_size();
+
+	printk(KERN_INFO "Top of RAM: 0x%lx, Total RAM: 0x%lx\n",
+	       top_of_ram, total_ram);
+	printk(KERN_INFO "Memory hole size: %ldMB\n",
+	       (top_of_ram - total_ram) >> 20);
 	/*
 	 * All pages are DMA-able so we put them all in the DMA zone.
 	 */
-	zones_size[ZONE_DMA] = lmb_end_of_DRAM() >> PAGE_SHIFT;
-	for (i = 1; i < MAX_NR_ZONES; i++)
-		zones_size[i] = 0;
-	free_area_init(zones_size);
+	memset(zones_size, 0, sizeof(zones_size));
+	memset(zholes_size, 0, sizeof(zholes_size));
+
+	zones_size[ZONE_DMA] = top_of_ram >> PAGE_SHIFT;
+	zholes_size[ZONE_DMA] = (top_of_ram - total_ram) >> PAGE_SHIFT;
+
+	free_area_init_node(0, &contig_page_data, NULL, zones_size,
+			    __pa(PAGE_OFFSET) >> PAGE_SHIFT, zholes_size);
+	mem_map = contig_page_data.node_mem_map;
 }
-#endif
+#endif /* CONFIG_DISCONTIGMEM */
 
 static struct kcore_list kcore_vmem;
 
diff -Nru a/arch/ppc64/mm/numa.c b/arch/ppc64/mm/numa.c
--- a/arch/ppc64/mm/numa.c	Fri Feb 27 22:42:19 2004
+++ b/arch/ppc64/mm/numa.c	Fri Feb 27 22:42:19 2004
@@ -30,6 +30,7 @@
 
 struct pglist_data node_data[MAX_NUMNODES];
 bootmem_data_t plat_node_bdata[MAX_NUMNODES];
+static unsigned long node0_io_hole_size;
 
 EXPORT_SYMBOL(node_data);
 EXPORT_SYMBOL(numa_memory_lookup_table);
@@ -205,8 +206,15 @@
 
 static void __init setup_nonnuma(void)
 {
+	unsigned long top_of_ram = lmb_end_of_DRAM();
+	unsigned long total_ram = lmb_phys_mem_size();
 	unsigned long i;
 
+	printk(KERN_INFO "Top of RAM: 0x%lx, Total RAM: 0x%lx\n",
+	       top_of_ram, total_ram);
+	printk(KERN_INFO "Memory hole size: %ldMB\n",
+	       (top_of_ram - total_ram) >> 20);
+
 	for (i = 0; i < NR_CPUS; i++)
 		map_cpu_to_node(i, 0);
 
@@ -215,8 +223,10 @@
 	node_data[0].node_start_pfn = 0;
 	node_data[0].node_spanned_pages = lmb_end_of_DRAM() / PAGE_SIZE;
 
-	for (i = 0 ; i < lmb_end_of_DRAM(); i += MEMORY_INCREMENT)
+	for (i = 0 ; i < top_of_ram; i += MEMORY_INCREMENT)
 		numa_memory_lookup_table[i >> MEMORY_INCREMENT_SHIFT] = 0;
+
+	node0_io_hole_size = top_of_ram - total_ram;
 }
 
 void __init do_init_bootmem(void)
@@ -309,11 +319,12 @@
 void __init paging_init(void)
 {
 	unsigned long zones_size[MAX_NR_ZONES];
-	int i, nid;
+	unsigned long zholes_size[MAX_NR_ZONES];
 	struct page *node_mem_map; 
+	int nid;
 
-	for (i = 1; i < MAX_NR_ZONES; i++)
-		zones_size[i] = 0;
+	memset(zones_size, 0, sizeof(zones_size));
+	memset(zholes_size, 0, sizeof(zholes_size));
 
 	for (nid = 0; nid < numnodes; nid++) {
 		unsigned long start_pfn;
@@ -323,8 +334,12 @@
 		end_pfn = plat_node_bdata[nid].node_low_pfn;
 
 		zones_size[ZONE_DMA] = end_pfn - start_pfn;
-		dbg("free_area_init node %d %lx %lx\n", nid,
-				zones_size[ZONE_DMA], start_pfn);
+		zholes_size[ZONE_DMA] = 0;
+		if (nid == 0)
+			zholes_size[ZONE_DMA] = node0_io_hole_size;
+
+		dbg("free_area_init node %d %lx %lx (hole: %lx)\n", nid,
+		    zones_size[ZONE_DMA], start_pfn, zholes_size[ZONE_DMA]);
 
 		/* 
 		 * Give this empty node a dummy struct page to avoid
@@ -337,6 +352,6 @@
 			node_mem_map = NULL;
 
 		free_area_init_node(nid, NODE_DATA(nid), node_mem_map,
-				    zones_size, start_pfn, NULL);
+				    zones_size, start_pfn, zholes_size);
 	}
 }
diff -Nru a/include/asm-ppc64/page.h b/include/asm-ppc64/page.h
--- a/include/asm-ppc64/page.h	Fri Feb 27 22:42:19 2004
+++ b/include/asm-ppc64/page.h	Fri Feb 27 22:42:19 2004
@@ -163,6 +163,9 @@
 
 #define __pa(x) ((unsigned long)(x)-PAGE_OFFSET)
 
+/* Not 100% correct, for use by /dev/mem only */
+extern int page_is_ram(unsigned long physaddr);
+
 #endif /* __ASSEMBLY__ */
 
 #ifdef MODULE
 

