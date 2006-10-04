Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422665AbWJDSAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbWJDSAB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 14:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422631AbWJDR77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:59:59 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:1117 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161905AbWJDR7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:59:52 -0400
Date: Wed, 4 Oct 2006 19:59:53 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Have s390 use add_active_range() and free_area_init_nodes.
Message-ID: <20061004175953.GH26756@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Have s390 use add_active_range() and free_area_init_nodes.

Size zones and holes in an architecture independent manner for s390.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/Kconfig        |    3 ++
 arch/s390/defconfig      |    1 
 arch/s390/kernel/setup.c |   55 +++++++++++------------------------------------
 arch/s390/mm/init.c      |   35 ++++++++---------------------
 4 files changed, 27 insertions(+), 67 deletions(-)

diff -urpN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2006-10-04 19:53:45.000000000 +0200
+++ linux-2.6-patched/arch/s390/defconfig	2006-10-04 19:53:51.000000000 +0200
@@ -118,6 +118,7 @@ CONFIG_PACK_STACK=y
 CONFIG_CHECK_STACK=y
 CONFIG_STACK_GUARD=256
 # CONFIG_WARN_STACK is not set
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
diff -urpN linux-2.6/arch/s390/Kconfig linux-2.6-patched/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2006-10-04 19:53:26.000000000 +0200
+++ linux-2.6-patched/arch/s390/Kconfig	2006-10-04 19:53:51.000000000 +0200
@@ -233,6 +233,9 @@ config WARN_STACK_SIZE
 	  This allows you to specify the maximum frame size a function may
 	  have without the compiler complaining about it.
 
+config ARCH_POPULATES_NODE_MAP
+	def_bool y
+
 source "mm/Kconfig"
 
 comment "I/O subsystem configuration"
diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2006-10-04 19:53:26.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2006-10-04 19:53:51.000000000 +0200
@@ -70,7 +70,6 @@ struct {
 #define CHUNK_READ_WRITE 0
 #define CHUNK_READ_ONLY 1
 volatile int __cpu_logical_map[NR_CPUS]; /* logical cpu to cpu address */
-unsigned long __initdata zholes_size[MAX_NR_ZONES];
 static unsigned long __initdata memory_end;
 
 /*
@@ -358,21 +357,6 @@ void machine_power_off(void)
  */
 void (*pm_power_off)(void) = machine_power_off;
 
-static void __init
-add_memory_hole(unsigned long start, unsigned long end)
-{
-	unsigned long dma_pfn = MAX_DMA_ADDRESS >> PAGE_SHIFT;
-
-	if (end <= dma_pfn)
-		zholes_size[ZONE_DMA] += end - start + 1;
-	else if (start > dma_pfn)
-		zholes_size[ZONE_NORMAL] += end - start + 1;
-	else {
-		zholes_size[ZONE_DMA] += dma_pfn - start + 1;
-		zholes_size[ZONE_NORMAL] += end - dma_pfn;
-	}
-}
-
 static int __init early_parse_mem(char *p)
 {
 	memory_end = memparse(p, &p);
@@ -494,7 +478,6 @@ setup_memory(void)
 {
         unsigned long bootmap_size;
 	unsigned long start_pfn, end_pfn, init_pfn;
-	unsigned long last_rw_end;
 	int i;
 
 	/*
@@ -543,46 +526,34 @@ setup_memory(void)
 #endif
 
 	/*
-	 * Initialize the boot-time allocator (with low memory only):
+	 * Initialize the boot-time allocator
 	 */
 	bootmap_size = init_bootmem(start_pfn, end_pfn);
 
 	/*
 	 * Register RAM areas with the bootmem allocator.
 	 */
-	last_rw_end = start_pfn;
 
 	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++) {
-		unsigned long start_chunk, end_chunk;
+		unsigned long start_chunk, end_chunk, pfn;
 
 		if (memory_chunk[i].type != CHUNK_READ_WRITE)
 			continue;
-		start_chunk = (memory_chunk[i].addr + PAGE_SIZE - 1);
-		start_chunk >>= PAGE_SHIFT;
-		end_chunk = (memory_chunk[i].addr + memory_chunk[i].size);
-		end_chunk >>= PAGE_SHIFT;
-		if (start_chunk < start_pfn)
-			start_chunk = start_pfn;
-		if (end_chunk > end_pfn)
-			end_chunk = end_pfn;
-		if (start_chunk < end_chunk) {
-			/* Initialize storage key for RAM pages */
-			for (init_pfn = start_chunk ; init_pfn < end_chunk;
-			     init_pfn++)
-				page_set_storage_key(init_pfn << PAGE_SHIFT,
-						     PAGE_DEFAULT_KEY);
-			free_bootmem(start_chunk << PAGE_SHIFT,
-				     (end_chunk - start_chunk) << PAGE_SHIFT);
-			if (last_rw_end < start_chunk)
-				add_memory_hole(last_rw_end, start_chunk - 1);
-			last_rw_end = end_chunk;
-		}
+		start_chunk = PFN_DOWN(memory_chunk[i].addr);
+		end_chunk = start_chunk + PFN_DOWN(memory_chunk[i].size) - 1;
+		end_chunk = min(end_chunk, end_pfn);
+		if (start_chunk >= end_chunk)
+			continue;
+		add_active_range(0, start_chunk, end_chunk);
+		pfn = max(start_chunk, start_pfn);
+		for (; pfn <= end_chunk; pfn++)
+			page_set_storage_key(PFN_PHYS(pfn), PAGE_DEFAULT_KEY);
 	}
 
 	psw_set_key(PAGE_DEFAULT_KEY);
 
-	if (last_rw_end < end_pfn - 1)
-		add_memory_hole(last_rw_end, end_pfn - 1);
+	free_bootmem_with_active_regions(0, max_pfn);
+	reserve_bootmem(0, PFN_PHYS(start_pfn));
 
 	/*
 	 * Reserve the bootmem bitmap itself as well. We do this in two
diff -urpN linux-2.6/arch/s390/mm/init.c linux-2.6-patched/arch/s390/mm/init.c
--- linux-2.6/arch/s390/mm/init.c	2006-10-04 19:53:26.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/init.c	2006-10-04 19:53:51.000000000 +0200
@@ -82,7 +82,6 @@ void show_mem(void)
         printk("%d pages swap cached\n",cached);
 }
 
-extern unsigned long __initdata zholes_size[];
 /*
  * paging_init() sets up the page tables
  */
@@ -99,16 +98,15 @@ void __init paging_init(void)
         unsigned long pgdir_k = (__pa(swapper_pg_dir) & PAGE_MASK) | _KERNSEG_TABLE;
         static const int ssm_mask = 0x04000000L;
 	unsigned long ro_start_pfn, ro_end_pfn;
-	unsigned long zones_size[MAX_NR_ZONES];
+	unsigned long max_zone_pfns[MAX_NR_ZONES];
 
 	ro_start_pfn = PFN_DOWN((unsigned long)&__start_rodata);
 	ro_end_pfn = PFN_UP((unsigned long)&__end_rodata);
 
-	memset(zones_size, 0, sizeof(zones_size));
-	zones_size[ZONE_DMA] = max_low_pfn;
-	free_area_init_node(0, &contig_page_data, zones_size,
-			    __pa(PAGE_OFFSET) >> PAGE_SHIFT,
-			    zholes_size);
+	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
+	max_zone_pfns[ZONE_DMA] = max_low_pfn;
+	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
+	free_area_init_nodes(max_zone_pfns);
 
 	/* unmap whole virtual address space */
 	
@@ -153,7 +151,6 @@ void __init paging_init(void)
 	__raw_local_irq_ssm(ssm_mask);
 
         local_flush_tlb();
-        return;
 }
 
 #else /* CONFIG_64BIT */
@@ -169,26 +166,16 @@ void __init paging_init(void)
         unsigned long pgdir_k = (__pa(swapper_pg_dir) & PAGE_MASK) |
           _KERN_REGION_TABLE;
 	static const int ssm_mask = 0x04000000L;
-	unsigned long zones_size[MAX_NR_ZONES];
-	unsigned long dma_pfn, high_pfn;
 	unsigned long ro_start_pfn, ro_end_pfn;
+	unsigned long max_zone_pfns[MAX_NR_ZONES];
 
-	memset(zones_size, 0, sizeof(zones_size));
-	dma_pfn = MAX_DMA_ADDRESS >> PAGE_SHIFT;
-	high_pfn = max_low_pfn;
 	ro_start_pfn = PFN_DOWN((unsigned long)&__start_rodata);
 	ro_end_pfn = PFN_UP((unsigned long)&__end_rodata);
 
-	if (dma_pfn > high_pfn)
-		zones_size[ZONE_DMA] = high_pfn;
-	else {
-		zones_size[ZONE_DMA] = dma_pfn;
-		zones_size[ZONE_NORMAL] = high_pfn - dma_pfn;
-	}
-
-	/* Initialize mem_map[].  */
-	free_area_init_node(0, &contig_page_data, zones_size,
-			    __pa(PAGE_OFFSET) >> PAGE_SHIFT, zholes_size);
+	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
+	max_zone_pfns[ZONE_DMA] = PFN_DOWN(MAX_DMA_ADDRESS);
+	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
+	free_area_init_nodes(max_zone_pfns);
 
 	/*
 	 * map whole physical memory to virtual memory (identity mapping) 
@@ -237,8 +224,6 @@ void __init paging_init(void)
 	__raw_local_irq_ssm(ssm_mask);
 
         local_flush_tlb();
-
-        return;
 }
 #endif /* CONFIG_64BIT */
 
