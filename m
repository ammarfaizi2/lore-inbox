Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312181AbSDCVTl>; Wed, 3 Apr 2002 16:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311917AbSDCVTZ>; Wed, 3 Apr 2002 16:19:25 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27554 "EHLO e1.esmtp.ibm.com")
	by vger.kernel.org with ESMTP id <S311786AbSDCVTG>;
	Wed, 3 Apr 2002 16:19:06 -0500
Message-Id: <200204032116.g33LG0l03006@w-gaughen.des.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] modularization of setup_arch in 2.5.7
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Apr 2002 13:15:59 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch reorganizes a section of code in setup_arch().  This is in
preparation for a discontigmem patch for ia32 numa that I'm finishing
up and want to reusing the existing functionality where appropriate.
It also makes the code a bit more readable.

I've posted regarding this change a couple of times before as RFCs.
Here's pointers to them:

http://marc.theaimsgroup.com/?l=linux-kernel&m=101562204614563&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=101664599417813&w=2

I also posted a work in progress discontigmem patch, here's a pointer
to that email:

http://marc.theaimsgroup.com/?l=linux-kernel&m=101608052903151&w=2

Please consider this modularization of setup_arch() patch for inclusion 
into the 2.5.7 tree.

Thanks,
Pat

-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/

--- virgin-2.5.7/arch/i386/kernel/setup.c	Mon Mar 18 12:37:14 2002
+++ linux-2.5.7-cleanup/arch/i386/kernel/setup.c	Wed Apr  3 10:51:48 2002
@@ -114,6 +114,7 @@
 #include <asm/dma.h>
 #include <asm/mpspec.h>
 #include <asm/mmu_context.h>
+#include <asm/setup.h>
 
 /*
  * Machine setup..
@@ -664,68 +665,13 @@
 	}
 }
 
-void __init setup_arch(char **cmdline_p)
-{
-	unsigned long bootmap_size, low_mem_size;
-	unsigned long start_pfn, max_low_pfn;
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
-	code_resource.start = virt_to_phys(&_text);
-	code_resource.end = virt_to_phys(&_etext)-1;
-	data_resource.start = virt_to_phys(&_etext);
-	data_resource.end = virt_to_phys(&_edata)-1;
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
+void __init find_max_pfn(void)
+{
+	int i;
 
-	/*
-	 * Find the highest page frame number we have available
-	 */
 	max_pfn = 0;
 	for (i = 0; i < e820.nr_map; i++) {
 		unsigned long start, end;
@@ -739,21 +685,25 @@
 		if (end > max_pfn)
 			max_pfn = end;
 	}
+}
 
-	/*
-	 * Determine low and high memory ranges:
-	 */
-	max_low_pfn = max_pfn;
-	if (max_low_pfn > MAXMEM_PFN) {
+/*
+ * Determine low and high memory ranges:
+ */
+void __init find_max_low_pfn(unsigned long *max_low_pfn)
+{
+	*max_low_pfn = max_pfn;
+	if (*max_low_pfn > MAXMEM_PFN) {
 		if (highmem_pages == -1)
 			highmem_pages = max_pfn - MAXMEM_PFN;
 		if (highmem_pages + MAXMEM_PFN < max_pfn)
 			max_pfn = MAXMEM_PFN + highmem_pages;
 		if (highmem_pages + MAXMEM_PFN > max_pfn) {
-			printk("only %luMB highmem pages available, ignoring highmem size of %uMB.\n", pages_to_mb(max_pfn - MAXMEM_PFN), pages_to_mb(highmem_pages));
+			printk("only %luMB highmem pages available, ignoring highmem size of %uMB.\n",
+				pages_to_mb(max_pfn - MAXMEM_PFN), pages_to_mb(highmem_pages));
 			highmem_pages = 0;
 		}
-		max_low_pfn = MAXMEM_PFN;
+		*max_low_pfn = MAXMEM_PFN;
 #ifndef CONFIG_HIGHMEM
 		/* Maximum memory usable is what is directly addressable */
 		printk(KERN_WARNING "Warning only %ldMB will be used.\n",
@@ -777,40 +727,32 @@
 			highmem_pages = 0;
 #if CONFIG_HIGHMEM
 		if (highmem_pages >= max_pfn) {
-			printk(KERN_ERR "highmem size specified (%uMB) is bigger than pages available (%luMB)!.\n", pages_to_mb(highmem_pages), pages_to_mb(max_pfn));
+			printk(KERN_ERR "highmem size specified (%uMB) is bigger than pages available (%luMB)!.\n",
+				pages_to_mb(highmem_pages), pages_to_mb(max_pfn));
 			highmem_pages = 0;
 		}
 		if (highmem_pages) {
-			if (max_low_pfn-highmem_pages < 64*1024*1024/PAGE_SIZE){
-				printk(KERN_ERR "highmem size %uMB results in smaller than 64MB lowmem, ignoring it.\n", pages_to_mb(highmem_pages));
+			if ((*max_low_pfn)-highmem_pages < 64*1024*1024/PAGE_SIZE){
+				printk(KERN_ERR "highmem size %uMB results in smaller than 64MB lowmem, ignoring it.\n",
+					pages_to_mb(highmem_pages));
 				highmem_pages = 0;
 			}
-			max_low_pfn -= highmem_pages;
+			*max_low_pfn -= highmem_pages;
 		}
 #else
 		if (highmem_pages)
 			printk(KERN_ERR "ignoring highmem size on non-highmem kernel!\n");
 #endif
 	}
+}
 
-#ifdef CONFIG_HIGHMEM
-	highstart_pfn = highend_pfn = max_pfn;
-	if (max_pfn > max_low_pfn) {
-		highstart_pfn = max_low_pfn;
-	}
-	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
-		pages_to_mb(highend_pfn - highstart_pfn));
-#endif
-	printk(KERN_NOTICE "%ldMB LOWMEM available.\n",
-			pages_to_mb(max_low_pfn));
-	/*
-	 * Initialize the boot-time allocator (with low memory only):
-	 */
-	bootmap_size = init_bootmem(start_pfn, max_low_pfn);
+/*
+ * Register fully available low RAM pages with the bootmem allocator.
+ */
+void __init register_bootmem_low_pages(unsigned long max_low_pfn)
+{
+	int i;
 
-	/*
-	 * Register fully available low RAM pages with the bootmem allocator.
-	 */
 	for (i = 0; i < e820.nr_map; i++) {
 		unsigned long curr_pfn, last_pfn, size;
  		/*
@@ -842,6 +784,41 @@
 		size = last_pfn - curr_pfn;
 		free_bootmem(PFN_PHYS(curr_pfn), PFN_PHYS(size));
 	}
+}
+
+static void __init setup_memory(unsigned long *max_low_pfn)
+{
+	unsigned long bootmap_size;
+	unsigned long start_pfn;
+	int i;
+
+	/*
+	 * partially used pages are not usable - thus
+	 * we are rounding upwards:
+	 */
+	start_pfn = PFN_UP(__pa(&_end));
+
+	find_max_pfn();
+
+	find_max_low_pfn(max_low_pfn);
+
+#ifdef CONFIG_HIGHMEM
+	highstart_pfn = highend_pfn = max_pfn;
+	if (max_pfn > *max_low_pfn) {
+		highstart_pfn = *max_low_pfn;
+	}
+	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
+		pages_to_mb(highend_pfn - highstart_pfn));
+#endif
+	printk(KERN_NOTICE "%ldMB LOWMEM available.\n",
+			pages_to_mb(*max_low_pfn));
+	/*
+	 * Initialize the boot-time allocator (with low memory only):
+	 */
+	bootmap_size = init_bootmem(start_pfn, *max_low_pfn);
+
+	register_bootmem_low_pages(*max_low_pfn);
+
 	/*
 	 * Reserve the bootmem bitmap itself as well. We do this in two
 	 * steps (first step was init_bootmem()) because this catches
@@ -865,19 +842,11 @@
 	 */
 	reserve_bootmem(PAGE_SIZE, PAGE_SIZE);
 #endif
-#ifdef CONFIG_ACPI_SLEEP
-	/*
-	 * Reserve low memory region for sleep support.
-	 */
-	acpi_reserve_bootmem();
-#endif
-#ifdef CONFIG_X86_LOCAL_APIC
-	/*
-	 * Find and reserve possible boot-time SMP configuration:
-	 */
-	find_smp_config();
-#endif
+}     
+
 #ifdef CONFIG_BLK_DEV_INITRD
+static void __init setup_mem_initrd(unsigned long max_low_pfn)
+{
 	if (LOADER_TYPE && INITRD_START) {
 		if (INITRD_START + INITRD_SIZE <= (max_low_pfn << PAGE_SHIFT)) {
 			reserve_bootmem(INITRD_START, INITRD_SIZE);
@@ -893,39 +862,17 @@
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
-#ifdef CONFIG_ACPI_BOOT
-	/*
-	 * Initialize the ACPI boot-time table parser (gets the RSDP and SDT).
-	 * Must do this after paging_init (due to reliance on fixmap, and thus
-	 * the bootmem allocator) but before get_smp_config (to allow parsing
-	 * of MADT).
-	 */
-	acpi_table_init(*cmdline_p);
-#endif
-#ifdef CONFIG_X86_LOCAL_APIC
-	/*
-	 * get boot-time SMP configuration:
-	 */
-	if (smp_found_config)
-		get_smp_config();
-#endif
-
+}
+#endif /* CONFIG_BLK_DEV_INITRD */
 
-	/*
-	 * Request address space for all standard RAM and ROM resources
-	 * and also for regions reported as reserved by the e820.
-	 */
+/*
+ * Request address space for all standard RAM and ROM resources
+ * and also for regions reported as reserved by the e820.
+ */
+static void __init register_memory(unsigned long max_low_pfn)
+{
+	unsigned long low_mem_size;
+	int i;
 	probe_roms();
 	for (i = 0; i < e820.nr_map; i++) {
 		struct resource *res;
@@ -962,6 +909,94 @@
 	low_mem_size = ((max_low_pfn << PAGE_SHIFT) + 0xfffff) & ~0xfffff;
 	if (low_mem_size > pci_mem_start)
 		pci_mem_start = low_mem_size;
+}
+
+void __init setup_arch(char **cmdline_p)
+{
+	unsigned long max_low_pfn;
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
+	code_resource.start = virt_to_phys(&_text);
+	code_resource.end = virt_to_phys(&_etext)-1;
+	data_resource.start = virt_to_phys(&_etext);
+	data_resource.end = virt_to_phys(&_edata)-1;
+
+	parse_mem_cmdline(cmdline_p);
+
+	setup_memory(&max_low_pfn);
+
+#ifdef CONFIG_ACPI_SLEEP
+	/*
+	 * Reserve low memory region for sleep support.
+	 */
+	acpi_reserve_bootmem();
+#endif
+#ifdef CONFIG_X86_LOCAL_APIC
+	/*
+	 * Find and reserve possible boot-time SMP configuration:
+	 */
+	find_smp_config();
+#endif
+#ifdef CONFIG_BLK_DEV_INITRD
+	setup_mem_initrd(max_low_pfn);
+#endif /* CONFIG_BLK_DEV_INITRD */
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
+#ifdef CONFIG_ACPI_BOOT
+	/*
+	 * Initialize the ACPI boot-time table parser (gets the RSDP and SDT).
+	 * Must do this after paging_init (due to reliance on fixmap, and thus
+	 * the bootmem allocator) but before get_smp_config (to allow parsing
+	 * of MADT).
+	 */
+	acpi_table_init(*cmdline_p);
+#endif
+#ifdef CONFIG_X86_LOCAL_APIC
+	/*
+	 * get boot-time SMP configuration:
+	 */
+	if (smp_found_config)
+		get_smp_config();
+#endif
+
+	register_memory(max_low_pfn);
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
--- virgin-2.5.7/include/asm-i386/setup.h	Mon Mar 18 12:37:17 2002
+++ linux-2.5.7-cleanup/include/asm-i386/setup.h	Wed Mar 20 13:40:35 2002
@@ -1,10 +1,14 @@
-/*
- *	Just a place holder. We don't want to have to test x86 before
- *	we include stuff
- */
-
 #ifndef _i386_SETUP_H
 #define _i386_SETUP_H
 
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


