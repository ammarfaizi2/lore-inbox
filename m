Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVAZAgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVAZAgY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVAZAeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:34:22 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:62890 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262264AbVAZAXl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:23:41 -0500
Subject: [RFC][PATCH 1/5] refactor i386 memory setup
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 25 Jan 2005 16:23:33 -0800
Message-Id: <E1Ctay6-0006if-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Refactor the i386 default and CONFIG_DISCONTIG_MEM setup_memory()
functions to share the common bootmem initialisation code.  This code
is intended to be identical, but there are currently some fixes
applied to one and not the other.  This patch extracts this common
initialisation code.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/i386/kernel/setup.c |   28 ++++---
 memhotplug-dave/arch/i386/mm/discontig.c |  118 +------------------------------
 2 files changed, 21 insertions(+), 125 deletions(-)

diff -puN arch/i386/kernel/setup.c~B-sparse-060-refactor-setup_memory-i386 arch/i386/kernel/setup.c
--- memhotplug/arch/i386/kernel/setup.c~B-sparse-060-refactor-setup_memory-i386	2005-01-25 13:04:29.000000000 -0800
+++ memhotplug-dave/arch/i386/kernel/setup.c	2005-01-25 13:44:28.000000000 -0800
@@ -1000,8 +1000,6 @@ unsigned long __init find_max_low_pfn(vo
 	return max_low_pfn;
 }
 
-#ifndef CONFIG_DISCONTIGMEM
-
 /*
  * Free all available memory for boot time allocation.  Used
  * as a callback function by efi_memory_walk()
@@ -1075,15 +1073,15 @@ static void __init reserve_ebda_region(v
 		reserve_bootmem(addr, PAGE_SIZE);	
 }
 
+#ifndef CONFIG_DISCONTIGMEM
+void __init setup_bootmem_allocator(void);
 static unsigned long __init setup_memory(void)
 {
-	unsigned long bootmap_size, start_pfn, max_low_pfn;
-
 	/*
 	 * partially used pages are not usable - thus
 	 * we are rounding upwards:
 	 */
-	start_pfn = PFN_UP(init_pg_tables_end);
+	min_low_pfn = PFN_UP(init_pg_tables_end);
 
 	find_max_pfn();
 
@@ -1099,10 +1097,22 @@ static unsigned long __init setup_memory
 #endif
 	printk(KERN_NOTICE "%ldMB LOWMEM available.\n",
 			pages_to_mb(max_low_pfn));
+
+	setup_bootmem_allocator();
+
+	return max_low_pfn;
+}
+#else
+extern unsigned long setup_memory(void);
+#endif /* !CONFIG_DISCONTIGMEM */
+
+void __init setup_bootmem_allocator(void)
+{
+	unsigned long bootmap_size;
 	/*
 	 * Initialize the boot-time allocator (with low memory only):
 	 */
-	bootmap_size = init_bootmem(start_pfn, max_low_pfn);
+	bootmap_size = init_bootmem(min_low_pfn, max_low_pfn);
 
 	register_bootmem_low_pages(max_low_pfn);
 
@@ -1112,7 +1122,7 @@ static unsigned long __init setup_memory
 	 * the (very unlikely) case of us accidentally initializing the
 	 * bootmem allocator with an invalid RAM area.
 	 */
-	reserve_bootmem(HIGH_MEMORY, (PFN_PHYS(start_pfn) +
+	reserve_bootmem(HIGH_MEMORY, (PFN_PHYS(min_low_pfn) +
 			 bootmap_size + PAGE_SIZE-1) - (HIGH_MEMORY));
 
 	/*
@@ -1182,11 +1192,7 @@ static unsigned long __init setup_memory
 		}
 	}
 #endif
-	return max_low_pfn;
 }
-#else
-extern unsigned long setup_memory(void);
-#endif /* !CONFIG_DISCONTIGMEM */
 
 /*
  * Request address space for all standard RAM and ROM resources
diff -puN arch/i386/mm/discontig.c~B-sparse-060-refactor-setup_memory-i386 arch/i386/mm/discontig.c
--- memhotplug/arch/i386/mm/discontig.c~B-sparse-060-refactor-setup_memory-i386	2005-01-25 13:04:29.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/discontig.c	2005-01-25 13:42:10.000000000 -0800
@@ -139,46 +139,6 @@ static void __init allocate_pgdat(int ni
 	}
 }
 
-/*
- * Register fully available low RAM pages with the bootmem allocator.
- */
-static void __init register_bootmem_low_pages(unsigned long system_max_low_pfn)
-{
-	int i;
-
-	for (i = 0; i < e820.nr_map; i++) {
-		unsigned long curr_pfn, last_pfn, size;
-		/*
-		 * Reserve usable low memory
-		 */
-		if (e820.map[i].type != E820_RAM)
-			continue;
-		/*
-		 * We are rounding up the start address of usable memory:
-		 */
-		curr_pfn = PFN_UP(e820.map[i].addr);
-		if (curr_pfn >= system_max_low_pfn)
-			continue;
-		/*
-		 * ... and at the end of the usable range downwards:
-		 */
-		last_pfn = PFN_DOWN(e820.map[i].addr + e820.map[i].size);
-
-		if (last_pfn > system_max_low_pfn)
-			last_pfn = system_max_low_pfn;
-
-		/*
-		 * .. finally, did all the rounding and playing
-		 * around just make the area go away?
-		 */
-		if (last_pfn <= curr_pfn)
-			continue;
-
-		size = last_pfn - curr_pfn;
-		free_bootmem_node(NODE_DATA(0), PFN_PHYS(curr_pfn), PFN_PHYS(size));
-	}
-}
-
 void __init remap_numa_kva(void)
 {
 	void *vaddr;
@@ -227,21 +187,11 @@ static unsigned long calculate_numa_rema
 	return reserve_pages;
 }
 
-/*
- * workaround for Dell systems that neglect to reserve EBDA
- */
-static void __init reserve_ebda_region_node(void)
-{
-	unsigned int addr;
-	addr = get_bios_ebda();
-	if (addr)
-		reserve_bootmem_node(NODE_DATA(0), addr, PAGE_SIZE);
-}
-
+extern void setup_bootmem_allocator(void);
 unsigned long __init setup_memory(void)
 {
 	int nid;
-	unsigned long bootmap_size, system_start_pfn, system_max_low_pfn;
+	unsigned long system_start_pfn, system_max_low_pfn;
 	unsigned long reserve_pages, pfn;
 
 	/*
@@ -308,67 +258,6 @@ unsigned long __init setup_memory(void)
 
 	NODE_DATA(0)->bdata = &node0_bdata;
 
-	/*
-	 * Initialize the boot-time allocator (with low memory only):
-	 */
-	bootmap_size = init_bootmem_node(NODE_DATA(0), min_low_pfn, 0, system_max_low_pfn);
-
-	register_bootmem_low_pages(system_max_low_pfn);
-
-	/*
-	 * Reserve the bootmem bitmap itself as well. We do this in two
-	 * steps (first step was init_bootmem()) because this catches
-	 * the (very unlikely) case of us accidentally initializing the
-	 * bootmem allocator with an invalid RAM area.
-	 */
-	reserve_bootmem_node(NODE_DATA(0), HIGH_MEMORY, (PFN_PHYS(min_low_pfn) +
-		 bootmap_size + PAGE_SIZE-1) - (HIGH_MEMORY));
-
-	/*
-	 * reserve physical page 0 - it's a special BIOS page on many boxes,
-	 * enabling clean reboots, SMP operation, laptop functions.
-	 */
-	reserve_bootmem_node(NODE_DATA(0), 0, PAGE_SIZE);
-
-	/*
-	 * But first pinch a few for the stack/trampoline stuff
-	 * FIXME: Don't need the extra page at 4K, but need to fix
-	 * trampoline before removing it. (see the GDT stuff)
-	 */
-	reserve_bootmem_node(NODE_DATA(0), PAGE_SIZE, PAGE_SIZE);
-
-	/* reserve EBDA region, it's a 4K region */
-	reserve_ebda_region_node();
-
-#ifdef CONFIG_ACPI_SLEEP
-	/*
-	 * Reserve low memory region for sleep support.
-	 */
-	acpi_reserve_bootmem();
-#endif
-
-	/*
-	 * Find and reserve possible boot-time SMP configuration:
-	 */
-	find_smp_config();
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (LOADER_TYPE && INITRD_START) {
-		if (INITRD_START + INITRD_SIZE <= (system_max_low_pfn << PAGE_SHIFT)) {
-			reserve_bootmem_node(NODE_DATA(0), INITRD_START, INITRD_SIZE);
-			initrd_start =
-				INITRD_START ? INITRD_START + PAGE_OFFSET : 0;
-			initrd_end = initrd_start+INITRD_SIZE;
-		}
-		else {
-			printk(KERN_ERR "initrd extends beyond end of memory "
-			    "(0x%08lx > 0x%08lx)\ndisabling initrd\n",
-			    INITRD_START + INITRD_SIZE,
-			    system_max_low_pfn << PAGE_SHIFT);
-			initrd_start = 0;
-		}
-	}
-#endif
 #ifdef CONFIG_KEXEC
 	if (crashk_res.start != crashk_res.end) {
 		reserve_bootmem(crashk_res.start, crashk_res.end - crashk_res.start + 1);
@@ -381,7 +270,8 @@ unsigned long __init setup_memory(void)
 		}
 	}
 #endif
-	return system_max_low_pfn;
+	setup_bootmem_allocator();
+	return max_low_pfn;
 }
 
 void __init zone_sizes_init(void)
_
