Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311875AbSCTRfP>; Wed, 20 Mar 2002 12:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311872AbSCTRfI>; Wed, 20 Mar 2002 12:35:08 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:40136 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311875AbSCTRey>; Wed, 20 Mar 2002 12:34:54 -0500
Message-Id: <200203201731.g2KHVlR02671@w-gaughen.des.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: lse-tech@lists.sourceforge.net
Subject: [RFC] modularization of i386 setup_arch in 2.5.7
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 20 Mar 2002 09:31:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is an update to the patch I sent last week (see
http://marc.theaimsgroup.com/?l=linux-kernel&m=101562204614563&w=2 for
that post).  This patch is a port of my 2.4.17 patch.  The changes
that I've made from the 2.4.17 patch are the following:

	1) broke it into 2 patches - patch 1 (this email) is the
setup_arch changes. patch 2 (which I'll send next) is the mem_init
changes.  These patches are can be applied independently.

	2) [specific to the setup_arch patch] removed the struct pfn
data structure (it was introduced in my 2.4.17 patch).  since the
global max_pfn is being used in setup_arch instead of a local variable
also called max_pfn, the use of the data structure didn't make sense
anymore.

As for testing, I've successfully booted and compiled a kernel on a UP
PII box, and a 4 proc IBM NUMAQ box (with CONFIG_MULTIQUAD on and off)

Please let me know if you have any comments.

Thanks,
Pat

-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center

--- virgin-2.5.7/arch/i386/kernel/setup.c	Mon Mar 18 12:37:14 2002
+++ linux-2.5.7/arch/i386/kernel/setup.c	Tue Mar 19 17:39:01 2002
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
@@ -739,10 +685,15 @@
 		if (end > max_pfn)
 			max_pfn = end;
 	}
+}
+
+/*
+ * Determine low and high memory ranges:
+ */
+unsigned long __init find_max_low_pfn(void)
+{
+	unsigned long max_low_pfn;
 
-	/*
-	 * Determine low and high memory ranges:
-	 */
 	max_low_pfn = max_pfn;
 	if (max_low_pfn > MAXMEM_PFN) {
 		if (highmem_pages == -1)
@@ -750,7 +701,8 @@
 		if (highmem_pages + MAXMEM_PFN < max_pfn)
 			max_pfn = MAXMEM_PFN + highmem_pages;
 		if (highmem_pages + MAXMEM_PFN > max_pfn) {
-			printk("only %luMB highmem pages available, ignoring highmem size of 
%uMB.\n", pages_to_mb(max_pfn - MAXMEM_PFN), pages_to_mb(highmem_pages));
+			printk("only %luMB highmem pages available, ignoring highmem size of 
%uMB.\n",
+				pages_to_mb(max_pfn - MAXMEM_PFN), pages_to_mb(highmem_pages));
 			highmem_pages = 0;
 		}
 		max_low_pfn = MAXMEM_PFN;
@@ -777,12 +729,14 @@
 			highmem_pages = 0;
 #if CONFIG_HIGHMEM
 		if (highmem_pages >= max_pfn) {
-			printk(KERN_ERR "highmem size specified (%uMB) is bigger than pages 
available (%luMB)!.\n", pages_to_mb(highmem_pages), pages_to_mb(max_pfn));
+			printk(KERN_ERR "highmem size specified (%uMB) is bigger than pages 
available (%luMB)!.\n",
+				pages_to_mb(highmem_pages), pages_to_mb(max_pfn));
 			highmem_pages = 0;
 		}
 		if (highmem_pages) {
 			if (max_low_pfn-highmem_pages < 64*1024*1024/PAGE_SIZE){
-				printk(KERN_ERR "highmem size %uMB results in smaller than 64MB lowmem, 
ignoring it.\n", pages_to_mb(highmem_pages));
+				printk(KERN_ERR "highmem size %uMB results in smaller than 64MB lowmem, 
ignoring it.\n",
+					pages_to_mb(highmem_pages));
 				highmem_pages = 0;
 			}
 			max_low_pfn -= highmem_pages;
@@ -792,25 +746,16 @@
 			printk(KERN_ERR "ignoring highmem size on non-highmem kernel!\n");
 #endif
 	}
+	return max_low_pfn;
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
@@ -842,6 +787,41 @@
 		size = last_pfn - curr_pfn;
 		free_bootmem(PFN_PHYS(curr_pfn), PFN_PHYS(size));
 	}
+}
+
+static unsigned long __init setup_memory(void)
+{
+	unsigned long bootmap_size;
+	unsigned long start_pfn, max_low_pfn;
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
+	max_low_pfn = find_max_low_pfn();
+
+#ifdef CONFIG_HIGHMEM
+	highstart_pfn = highend_pfn = max_pfn;
+	if (max_pfn > max_low_pfn) {
+		highstart_pfn = max_low_pfn;
+	}
+	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
+		pages_to_mb(highend_pfn - highstart_pfn));
+#endif
+	printk(KERN_NOTICE "%ldMB LOWMEM available.\n",
+			pages_to_mb(max_low_pfn));
+	/*
+	 * Initialize the boot-time allocator (with low memory only):
+	 */
+	bootmap_size = init_bootmem(start_pfn, max_low_pfn);
+
+	register_bootmem_low_pages(max_low_pfn);
+
 	/*
 	 * Reserve the bootmem bitmap itself as well. We do this in two
 	 * steps (first step was init_bootmem()) because this catches
@@ -865,19 +845,12 @@
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
+	return max_low_pfn;
+}     
+
 #ifdef CONFIG_BLK_DEV_INITRD
+static void __init setup_mem_initrd(unsigned long max_low_pfn)
+{
 	if (LOADER_TYPE && INITRD_START) {
 		if (INITRD_START + INITRD_SIZE <= (max_low_pfn << PAGE_SHIFT)) {
 			reserve_bootmem(INITRD_START, INITRD_SIZE);
@@ -893,39 +866,17 @@
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
@@ -962,6 +913,94 @@
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
+	max_low_pfn = setup_memory();
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
+++ linux-2.5.7/include/asm-i386/setup.h	Tue Mar 19 17:49:57 2002
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





