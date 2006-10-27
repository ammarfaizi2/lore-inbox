Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946469AbWJ0NCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946469AbWJ0NCl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 09:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946468AbWJ0NCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 09:02:41 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:43702 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1946466AbWJ0NCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 09:02:40 -0400
Date: Fri, 27 Oct 2006 15:02:30 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Carsten Otte <cotte@de.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: s390: revert add_active_range() usage patch
Message-ID: <20061027130230.GB7141@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Commit 7676bef9c183fd573822cac9992927ef596d584c breaks DCSS support on
s390. DCSS needs initialized struct pages to work. With the usage of
add_active_range() only the struct pages for physically present pages
are initialized.
This could be fixed if the DCSS driver would initiliaze the struct pages
itself, but this doesn't work too. This is because the mem_map array
does not include holes after the last present memory area and therefore
there is nothing that could be initialized.
To fix this and to avoid some dirty hacks revert this patch for now.
Will be added later when we move to a virtual mem_map.

Cc: Carsten Otte <cotte@de.ibm.com>
Cc: Adrian Bunk <bunk@stusta.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/Kconfig        |    3 --
 arch/s390/defconfig      |    1 
 arch/s390/kernel/setup.c |   53 ++++++++++++++++++++++++++++++++++++-----------
 arch/s390/mm/init.c      |   32 +++++++++++++++++++---------
 4 files changed, 63 insertions(+), 26 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 608193c..245b81b 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -236,9 +236,6 @@ config WARN_STACK_SIZE
 	  This allows you to specify the maximum frame size a function may
 	  have without the compiler complaining about it.
 
-config ARCH_POPULATES_NODE_MAP
-	def_bool y
-
 source "mm/Kconfig"
 
 comment "I/O subsystem configuration"
diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index c313e9a..7cd51e7 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -119,7 +119,6 @@ # CONFIG_SMALL_STACK is not set
 CONFIG_CHECK_STACK=y
 CONFIG_STACK_GUARD=256
 # CONFIG_WARN_STACK is not set
-CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 49f2b68..a31abdd 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -70,6 +70,7 @@ struct {
 #define CHUNK_READ_WRITE 0
 #define CHUNK_READ_ONLY 1
 volatile int __cpu_logical_map[NR_CPUS]; /* logical cpu to cpu address */
+unsigned long __initdata zholes_size[MAX_NR_ZONES];
 static unsigned long __initdata memory_end;
 
 /*
@@ -357,6 +358,21 @@ void machine_power_off(void)
  */
 void (*pm_power_off)(void) = machine_power_off;
 
+static void __init
+add_memory_hole(unsigned long start, unsigned long end)
+{
+	unsigned long dma_pfn = MAX_DMA_ADDRESS >> PAGE_SHIFT;
+
+	if (end <= dma_pfn)
+		zholes_size[ZONE_DMA] += end - start + 1;
+	else if (start > dma_pfn)
+		zholes_size[ZONE_NORMAL] += end - start + 1;
+	else {
+		zholes_size[ZONE_DMA] += dma_pfn - start + 1;
+		zholes_size[ZONE_NORMAL] += end - dma_pfn;
+	}
+}
+
 static int __init early_parse_mem(char *p)
 {
 	memory_end = memparse(p, &p);
@@ -478,6 +494,7 @@ setup_memory(void)
 {
         unsigned long bootmap_size;
 	unsigned long start_pfn, end_pfn, init_pfn;
+	unsigned long last_rw_end;
 	int i;
 
 	/*
@@ -533,27 +550,39 @@ #endif
 	/*
 	 * Register RAM areas with the bootmem allocator.
 	 */
+	last_rw_end = start_pfn;
 
 	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++) {
-		unsigned long start_chunk, end_chunk, pfn;
+		unsigned long start_chunk, end_chunk;
 
 		if (memory_chunk[i].type != CHUNK_READ_WRITE)
 			continue;
-		start_chunk = PFN_DOWN(memory_chunk[i].addr);
-		end_chunk = start_chunk + PFN_DOWN(memory_chunk[i].size) - 1;
-		end_chunk = min(end_chunk, end_pfn);
-		if (start_chunk >= end_chunk)
-			continue;
-		add_active_range(0, start_chunk, end_chunk);
-		pfn = max(start_chunk, start_pfn);
-		for (; pfn <= end_chunk; pfn++)
-			page_set_storage_key(PFN_PHYS(pfn), PAGE_DEFAULT_KEY);
+		start_chunk = (memory_chunk[i].addr + PAGE_SIZE - 1);
+		start_chunk >>= PAGE_SHIFT;
+		end_chunk = (memory_chunk[i].addr + memory_chunk[i].size);
+		end_chunk >>= PAGE_SHIFT;
+		if (start_chunk < start_pfn)
+			start_chunk = start_pfn;
+		if (end_chunk > end_pfn)
+			end_chunk = end_pfn;
+		if (start_chunk < end_chunk) {
+			/* Initialize storage key for RAM pages */
+			for (init_pfn = start_chunk ; init_pfn < end_chunk;
+			     init_pfn++)
+				page_set_storage_key(init_pfn << PAGE_SHIFT,
+						     PAGE_DEFAULT_KEY);
+			free_bootmem(start_chunk << PAGE_SHIFT,
+				     (end_chunk - start_chunk) << PAGE_SHIFT);
+			if (last_rw_end < start_chunk)
+				add_memory_hole(last_rw_end, start_chunk - 1);
+			last_rw_end = end_chunk;
+		}
 	}
 
 	psw_set_key(PAGE_DEFAULT_KEY);
 
-	free_bootmem_with_active_regions(0, max_pfn);
-	reserve_bootmem(0, PFN_PHYS(start_pfn));
+	if (last_rw_end < end_pfn - 1)
+		add_memory_hole(last_rw_end, end_pfn - 1);
 
 	/*
 	 * Reserve the bootmem bitmap itself as well. We do this in two
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index d998917..e1881c3 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -84,6 +84,7 @@ void show_mem(void)
         printk("%d pages swap cached\n",cached);
 }
 
+extern unsigned long __initdata zholes_size[];
 /*
  * paging_init() sets up the page tables
  */
@@ -100,15 +101,16 @@ void __init paging_init(void)
         unsigned long pgdir_k = (__pa(swapper_pg_dir) & PAGE_MASK) | _KERNSEG_TABLE;
         static const int ssm_mask = 0x04000000L;
 	unsigned long ro_start_pfn, ro_end_pfn;
-	unsigned long max_zone_pfns[MAX_NR_ZONES];
+	unsigned long zones_size[MAX_NR_ZONES];
 
 	ro_start_pfn = PFN_DOWN((unsigned long)&__start_rodata);
 	ro_end_pfn = PFN_UP((unsigned long)&__end_rodata);
 
-	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
-	max_zone_pfns[ZONE_DMA] = max_low_pfn;
-	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
-	free_area_init_nodes(max_zone_pfns);
+	memset(zones_size, 0, sizeof(zones_size));
+	zones_size[ZONE_DMA] = max_low_pfn;
+	free_area_init_node(0, &contig_page_data, zones_size,
+			    __pa(PAGE_OFFSET) >> PAGE_SHIFT,
+			    zholes_size);
 
 	/* unmap whole virtual address space */
 	
@@ -168,16 +170,26 @@ void __init paging_init(void)
         unsigned long pgdir_k = (__pa(swapper_pg_dir) & PAGE_MASK) |
           _KERN_REGION_TABLE;
 	static const int ssm_mask = 0x04000000L;
+	unsigned long zones_size[MAX_NR_ZONES];
+	unsigned long dma_pfn, high_pfn;
 	unsigned long ro_start_pfn, ro_end_pfn;
-	unsigned long max_zone_pfns[MAX_NR_ZONES];
 
+	memset(zones_size, 0, sizeof(zones_size));
+	dma_pfn = MAX_DMA_ADDRESS >> PAGE_SHIFT;
+	high_pfn = max_low_pfn;
 	ro_start_pfn = PFN_DOWN((unsigned long)&__start_rodata);
 	ro_end_pfn = PFN_UP((unsigned long)&__end_rodata);
 
-	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
-	max_zone_pfns[ZONE_DMA] = PFN_DOWN(MAX_DMA_ADDRESS);
-	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
-	free_area_init_nodes(max_zone_pfns);
+	if (dma_pfn > high_pfn)
+		zones_size[ZONE_DMA] = high_pfn;
+	else {
+		zones_size[ZONE_DMA] = dma_pfn;
+		zones_size[ZONE_NORMAL] = high_pfn - dma_pfn;
+	}
+
+	/* Initialize mem_map[].  */
+	free_area_init_node(0, &contig_page_data, zones_size,
+			    __pa(PAGE_OFFSET) >> PAGE_SHIFT, zholes_size);
 
 	/*
 	 * map whole physical memory to virtual memory (identity mapping) 
