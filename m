Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311128AbSCHVLq>; Fri, 8 Mar 2002 16:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311129AbSCHVLj>; Fri, 8 Mar 2002 16:11:39 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:32398 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311128AbSCHVLa>; Fri, 8 Mar 2002 16:11:30 -0500
Message-Id: <200203082108.g28L8I504672@w-gaughen.des.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: lse-tech@lists.sourceforge.net
Subject: [RFC] modularization of i386 setup_arch and mem_init in 2.4.18
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Mar 2002 13:08:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm currently working on a discontigmem patch for IBM NUMAQ (an ia32 
NUMA box) and want to reuse the standard i386 code as much as
possible.  To achieve this, I've modularized setup_arch() and
mem_init().  This modularization is what the patch that I've included 
in this email contains.

Here's a breakdown of the changes I've made and their justification:

	- PFN_{UP,DOWN,PHYS}, MAXMEM_PFN, MAX_NONPAE_PFN macros have
	been moved to include/asm-i386/setup.h to allow use of them in
	my discontigmem code that is located in numa.c (part of my
	discontigmem patch, which is not available yet)

	- Created a structure of the pfns used during initialization
	(struct pfns - see include/asm-i386/setup.h_for ease of
	passing to functions, and to enable reuse of use the structure
	(1 for each node) in my discontig mem code for paging_init().

	- Several blocks of code in mem_init() and setup_arch() where
	moved into functions for reuse in the discontigmem patch
	and also for readability.

Let me know if you have any comments.

Thanks,
Pat

-- 
Patricia Gaughen (gone@us.ibm.com)
Linux Technology Center

--- virgin-2.4.18/arch/i386/kernel/setup.c	Mon Feb 25 11:37:53 2002
+++ linux-2.4.18-cleanup/arch/i386/kernel/setup.c	Sun Mar  3 22:05:39 2002
@@ -113,6 +113,7 @@
 #include <asm/dma.h>
 #include <asm/mpspec.h>
 #include <asm/mmu_context.h>
+#include <asm/setup.h>
 /*
  * Machine setup..
  */
@@ -779,69 +780,14 @@
 	}
 }
 
-void __init setup_arch(char **cmdline_p)
-{
-	unsigned long bootmap_size, low_mem_size;
-	unsigned long start_pfn, max_pfn, max_low_pfn;
-	int i;
-
-#ifdef CONFIG_VISWS
-	visws_get_board_type_and_rev();
-#endif
-
- 	ROOT_DEV = to_kdev_t(ORIG_ROOT_DEV);
- 	drive_info = DRIVE_INFO;
- 	screen_info = SCREEN_INFO;
-	apm_info.bios = APM_BIOS_INFO;
-	if( SYS_DESC_TABLE.length != 0 ) {
-		MCA_bus = SYS_DESC_TABLE.table[3] &0x2;
-		machine_id = SYS_DESC_TABLE.table[0];
-		machine_submodel_id = SYS_DESC_TABLE.table[1];
-		BIOS_revision = SYS_DESC_TABLE.table[2];
-	}
-	aux_device_present = AUX_DEVICE_INFO;
-
-#ifdef CONFIG_BLK_DEV_RAM
-	rd_image_start = RAMDISK_FLAGS & RAMDISK_IMAGE_START_MASK;
-	rd_prompt = ((RAMDISK_FLAGS & RAMDISK_PROMPT_FLAG) != 0);
-	rd_doload = ((RAMDISK_FLAGS & RAMDISK_LOAD_FLAG) != 0);
-#endif
-	setup_memory_region();
-
-	if (!MOUNT_ROOT_RDONLY)
-		root_mountflags &= ~MS_RDONLY;
-	init_mm.start_code = (unsigned long) &_text;
-	init_mm.end_code = (unsigned long) &_etext;
-	init_mm.end_data = (unsigned long) &_edata;
-	init_mm.brk = (unsigned long) &_end;
-
-	code_resource.start = virt_to_bus(&_text);
-	code_resource.end = virt_to_bus(&_etext)-1;
-	data_resource.start = virt_to_bus(&_etext);
-	data_resource.end = virt_to_bus(&_edata)-1;
-
-	parse_mem_cmdline(cmdline_p);
-
-#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
-#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
-#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
-
 /*
- * Reserved space for vmalloc and iomap - defined in asm/page.h
+ * Find the highest page frame number we have available
  */
-#define MAXMEM_PFN	PFN_DOWN(MAXMEM)
-#define MAX_NONPAE_PFN	(1 << 20)
-
-	/*
-	 * partially used pages are not usable - thus
-	 * we are rounding upwards:
-	 */
-	start_pfn = PFN_UP(__pa(&_end));
+void __init find_max_pfn(struct pfns *bootpfns)
+{
+	int i;
 
-	/*
-	 * Find the highest page frame number we have available
-	 */
-	max_pfn = 0;
+	bootpfns->max_pfn = 0;
 	for (i = 0; i < e820.nr_map; i++) {
 		unsigned long start, end;
 		/* RAM? */
@@ -851,51 +797,46 @@
 		end = PFN_DOWN(e820.map[i].addr + e820.map[i].size);
 		if (start >= end)
 			continue;
-		if (end > max_pfn)
-			max_pfn = end;
+		if (end > bootpfns->max_pfn)
+			bootpfns->max_pfn = end;
 	}
+}
 
-	/*
-	 * Determine low and high memory ranges:
-	 */
-	max_low_pfn = max_pfn;
-	if (max_low_pfn > MAXMEM_PFN) {
-		max_low_pfn = MAXMEM_PFN;
+/*
+ * Determine low and high memory ranges:
+ */
+void __init find_max_low_pfn(struct pfns *bootpfns)
+{
+	bootpfns->max_low_pfn = bootpfns->max_pfn;
+	if (bootpfns->max_low_pfn > MAXMEM_PFN) {
+		bootpfns->max_low_pfn = MAXMEM_PFN;
 #ifndef CONFIG_HIGHMEM
 		/* Maximum memory usable is what is directly addressable */
 		printk(KERN_WARNING "Warning only %ldMB will be used.\n",
 					MAXMEM>>20);
-		if (max_pfn > MAX_NONPAE_PFN)
+		if (bootpfns->max_pfn > MAX_NONPAE_PFN)
 			printk(KERN_WARNING "Use a PAE enabled kernel.\n");
 		else
 			printk(KERN_WARNING "Use a HIGHMEM enabled kernel.\n");
 #else /* !CONFIG_HIGHMEM */
 #ifndef CONFIG_X86_PAE
-		if (max_pfn > MAX_NONPAE_PFN) {
-			max_pfn = MAX_NONPAE_PFN;
+		if (bootpfns->max_pfn > MAX_NONPAE_PFN) {
+			bootpfns->max_pfn = MAX_NONPAE_PFN;
 			printk(KERN_WARNING "Warning only 4GB will be used.\n");
 			printk(KERN_WARNING "Use a PAE enabled kernel.\n");
 		}
 #endif /* !CONFIG_X86_PAE */
 #endif /* !CONFIG_HIGHMEM */
 	}
+}
 
-#ifdef CONFIG_HIGHMEM
-	highstart_pfn = highend_pfn = max_pfn;
-	if (max_pfn > MAXMEM_PFN) {
-		highstart_pfn = MAXMEM_PFN;
-		printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
-			pages_to_mb(highend_pfn - highstart_pfn));
-	}
-#endif
-	/*
-	 * Initialize the boot-time allocator (with low memory only):
-	 */
-	bootmap_size = init_bootmem(start_pfn, max_low_pfn);
+/*
+ * Register fully available low RAM pages with the bootmem allocator.
+ */
+static void __init register_bootmem_low_pages(struct pfns *bootpfns)
+{
+	int i;
 
-	/*
-	 * Register fully available low RAM pages with the bootmem allocator.
-	 */
 	for (i = 0; i < e820.nr_map; i++) {
 		unsigned long curr_pfn, last_pfn, size;
  		/*
@@ -907,15 +848,15 @@
 		 * We are rounding up the start address of usable memory:
 		 */
 		curr_pfn = PFN_UP(e820.map[i].addr);
-		if (curr_pfn >= max_low_pfn)
+		if (curr_pfn >= bootpfns->max_low_pfn)
 			continue;
 		/*
 		 * ... and at the end of the usable range downwards:
 		 */
 		last_pfn = PFN_DOWN(e820.map[i].addr + e820.map[i].size);
 
-		if (last_pfn > max_low_pfn)
-			last_pfn = max_low_pfn;
+		if (last_pfn > bootpfns->max_low_pfn)
+			last_pfn = bootpfns->max_low_pfn;
 
 		/*
 		 * .. finally, did all the rounding and playing
@@ -927,13 +868,45 @@
 		size = last_pfn - curr_pfn;
 		free_bootmem(PFN_PHYS(curr_pfn), PFN_PHYS(size));
 	}
+}
+
+static void __init setup_memory(struct pfns *bootpfns)
+{
+	unsigned long bootmap_size;
+
+	/*
+	 * partially used pages are not usable - thus
+	 * we are rounding upwards:
+	 */
+	bootpfns->start_pfn = PFN_UP(__pa(&_end));
+
+	find_max_pfn(bootpfns);
+
+	find_max_low_pfn(bootpfns);
+
+#ifdef CONFIG_HIGHMEM
+	highstart_pfn = highend_pfn = bootpfns->max_pfn;
+	if (bootpfns->max_pfn > MAXMEM_PFN) {
+		highstart_pfn = MAXMEM_PFN;
+		printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
+			pages_to_mb(highend_pfn - highstart_pfn));
+	}
+#endif
+
+	/*
+	 * Initialize the boot-time allocator (with low memory only):
+	 */
+	bootmap_size = init_bootmem(bootpfns->start_pfn, bootpfns->max_low_pfn);
+
+	register_bootmem_low_pages(bootpfns);
+	
 	/*
 	 * Reserve the bootmem bitmap itself as well. We do this in two
 	 * steps (first step was init_bootmem()) because this catches
 	 * the (very unlikely) case of us accidentally initializing the
 	 * bootmem allocator with an invalid RAM area.
 	 */
-	reserve_bootmem(HIGH_MEMORY, (PFN_PHYS(start_pfn) +
+	reserve_bootmem(HIGH_MEMORY, (PFN_PHYS(bootpfns->start_pfn) +
 			 bootmap_size + PAGE_SIZE-1) - (HIGH_MEMORY));
 
 	/*
@@ -950,14 +923,11 @@
 	 */
 	reserve_bootmem(PAGE_SIZE, PAGE_SIZE);
 #endif
+}
 
-#ifdef CONFIG_X86_LOCAL_APIC
-	/*
-	 * Find and reserve possible boot-time SMP configuration:
-	 */
-	find_smp_config();
-#endif
 #ifdef CONFIG_BLK_DEV_INITRD
+static void __init setup_mem_initrd(struct pfns *bootpfns)
+{
 	if (LOADER_TYPE && INITRD_START) {
 		if (INITRD_START + INITRD_SIZE <= (max_low_pfn << PAGE_SHIFT)) {
 			reserve_bootmem(INITRD_START, INITRD_SIZE);
@@ -973,31 +943,18 @@
 			initrd_start = 0;
 		}
 	}
-#endif
-
-	/*
-	 * NOTE: before this point _nobody_ is allowed to allocate
-	 * any memory using the bootmem allocator.
-	 */
-
-#ifdef CONFIG_SMP
-	smp_alloc_memory(); /* AP processor realmode stacks in low memory*/
-#endif
-	paging_init();
-#ifdef CONFIG_X86_LOCAL_APIC
-	/*
-	 * get boot-time SMP configuration:
-	 */
-	if (smp_found_config)
-		get_smp_config();
-	init_apic_mappings();
-#endif
+}
+#endif /* CONFIG_BLK_DEV_INITRD */
 
+/*
+ * Request address space for all standard RAM and ROM resources
+ * and also for regions reported as reserved by the e820.
+ */
+static void __init register_memory(struct pfns *bootpfns)
+{
+	unsigned long low_mem_size;
+	int i;
 
-	/*
-	 * Request address space for all standard RAM and ROM resources
-	 * and also for regions reported as reserved by the e820.
-	 */
 	probe_roms();
 	for (i = 0; i < e820.nr_map; i++) {
 		struct resource *res;
@@ -1031,10 +988,85 @@
 		request_resource(&ioport_resource, standard_io_resources+i);
 
 	/* Tell the PCI layer not to allocate too close to the RAM area.. */
-	low_mem_size = ((max_low_pfn << PAGE_SHIFT) + 0xfffff) & ~0xfffff;
+	low_mem_size = ((bootpfns->max_low_pfn << PAGE_SHIFT) + 0xfffff) & ~0xfffff;
 	if (low_mem_size > pci_mem_start)
 		pci_mem_start = low_mem_size;
 
+}
+
+void __init setup_arch(char **cmdline_p)
+{
+	struct pfns bootpfns;
+
+#ifdef CONFIG_VISWS
+	visws_get_board_type_and_rev();
+#endif
+
+ 	ROOT_DEV = to_kdev_t(ORIG_ROOT_DEV);
+ 	drive_info = DRIVE_INFO;
+ 	screen_info = SCREEN_INFO;
+	apm_info.bios = APM_BIOS_INFO;
+	if( SYS_DESC_TABLE.length != 0 ) {
+		MCA_bus = SYS_DESC_TABLE.table[3] &0x2;
+		machine_id = SYS_DESC_TABLE.table[0];
+		machine_submodel_id = SYS_DESC_TABLE.table[1];
+		BIOS_revision = SYS_DESC_TABLE.table[2];
+	}
+	aux_device_present = AUX_DEVICE_INFO;
+
+#ifdef CONFIG_BLK_DEV_RAM
+	rd_image_start = RAMDISK_FLAGS & RAMDISK_IMAGE_START_MASK;
+	rd_prompt = ((RAMDISK_FLAGS & RAMDISK_PROMPT_FLAG) != 0);
+	rd_doload = ((RAMDISK_FLAGS & RAMDISK_LOAD_FLAG) != 0);
+#endif
+	setup_memory_region();
+
+	if (!MOUNT_ROOT_RDONLY)
+		root_mountflags &= ~MS_RDONLY;
+	init_mm.start_code = (unsigned long) &_text;
+	init_mm.end_code = (unsigned long) &_etext;
+	init_mm.end_data = (unsigned long) &_edata;
+	init_mm.brk = (unsigned long) &_end;
+
+	code_resource.start = virt_to_bus(&_text);
+	code_resource.end = virt_to_bus(&_etext)-1;
+	data_resource.start = virt_to_bus(&_etext);
+	data_resource.end = virt_to_bus(&_edata)-1;
+
+	parse_mem_cmdline(cmdline_p);
+
+	setup_memory(&bootpfns);
+	
+#ifdef CONFIG_X86_LOCAL_APIC
+	/*
+	 * Find and reserve possible boot-time SMP configuration:
+	 */
+	find_smp_config();
+#endif
+#ifdef CONFIG_BLK_DEV_INITRD
+	setup_mem_initrd(&bootpfns);
+#endif
+
+	/*
+	 * NOTE: before this point _nobody_ is allowed to allocate
+	 * any memory using the bootmem allocator.
+	 */
+
+#ifdef CONFIG_SMP
+	smp_alloc_memory(); /* AP processor realmode stacks in low memory*/
+#endif
+	paging_init();
+#ifdef CONFIG_X86_LOCAL_APIC
+	/*
+	 * get boot-time SMP configuration:
+	 */
+	if (smp_found_config)
+		get_smp_config();
+	init_apic_mappings();
+#endif
+
+	register_memory(&bootpfns);
+
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
 	conswitchp = &vga_con;
--- virgin-2.4.18/include/asm-i386/setup.h	Fri Nov 12 10:12:11 1999
+++ linux-2.4.18-cleanup/include/asm-i386/setup.h	Mon Mar  4 17:04:21 2002
@@ -1,10 +1,20 @@
-/*
- *	Just a place holder. We don't want to have to test x86 before
- *	we include stuff
- */
-
 #ifndef _i386_SETUP_H
 #define _i386_SETUP_H
 
+struct pfns {
+	unsigned long start_pfn;
+	unsigned long max_pfn;
+	unsigned long max_low_pfn;
+};
+
+#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
+#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
+#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
+
+/*
+ * Reserved space for vmalloc and iomap - defined in asm/page.h
+ */
+#define MAXMEM_PFN	PFN_DOWN(MAXMEM)
+#define MAX_NONPAE_PFN	(1 << 20)
 
 #endif /* _i386_SETUP_H */
--- virgin-2.4.18/arch/i386/mm/init.c	Fri Dec 21 09:41:53 2001
+++ linux-2.4.18-cleanup/arch/i386/mm/init.c	Tue Mar  5 11:52:22 2002
@@ -447,6 +447,49 @@
 	return 0;
 }
 	
+void __init init_one_highpage(struct page *page, int pfn, int bad_ppro)
+{
+	if (!page_is_ram(pfn)) {
+		SetPageReserved(page);
+		return;
+	}
+	
+	if (bad_ppro && page_kills_ppro(pfn))
+	{
+		SetPageReserved(page);
+		return;
+	}
+	ClearPageReserved(page);
+	set_bit(PG_highmem, &page->flags);
+	atomic_set(&page->count, 1);
+	__free_page(page);
+	totalhigh_pages++;
+}
+
+static int __init mem_init_free_pages(int bad_ppro)
+{
+	int reservedpages;
+	int tmp;
+
+	/* this will put all low memory onto the freelists */
+	totalram_pages += free_all_bootmem();
+
+	reservedpages = 0;
+	for (tmp = 0; tmp < max_low_pfn; tmp++)
+		/*
+		 * Only count reserved RAM pages
+		 */
+		if (page_is_ram(tmp) && PageReserved(mem_map+tmp))
+			reservedpages++;
+#ifdef CONFIG_HIGHMEM
+	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
+		init_one_highpage((struct page *) (mem_map + tmp), tmp, bad_ppro);
+	}
+	totalram_pages += totalhigh_pages;
+#endif
+	return reservedpages;
+}
+
 void __init mem_init(void)
 {
 	extern int ppro_with_ram_bug(void);
@@ -470,37 +513,8 @@
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
 
-	/* this will put all low memory onto the freelists */
-	totalram_pages += free_all_bootmem();
-
-	reservedpages = 0;
-	for (tmp = 0; tmp < max_low_pfn; tmp++)
-		/*
-		 * Only count reserved RAM pages
-		 */
-		if (page_is_ram(tmp) && PageReserved(mem_map+tmp))
-			reservedpages++;
-#ifdef CONFIG_HIGHMEM
-	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
-		struct page *page = mem_map + tmp;
+	reservedpages = mem_init_free_pages(bad_ppro);
 
-		if (!page_is_ram(tmp)) {
-			SetPageReserved(page);
-			continue;
-		}
-		if (bad_ppro && page_kills_ppro(tmp))
-		{
-			SetPageReserved(page);
-			continue;
-		}
-		ClearPageReserved(page);
-		set_bit(PG_highmem, &page->flags);
-		atomic_set(&page->count, 1);
-		__free_page(page);
-		totalhigh_pages++;
-	}
-	totalram_pages += totalhigh_pages;
-#endif
 	codesize =  (unsigned long) &_etext - (unsigned long) &_text;
 	datasize =  (unsigned long) &_edata - (unsigned long) &_etext;
 	initsize =  (unsigned long) &__init_end - (unsigned long) &__init_begin;



