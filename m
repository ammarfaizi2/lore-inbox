Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318128AbSHICxV>; Thu, 8 Aug 2002 22:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318131AbSHICxV>; Thu, 8 Aug 2002 22:53:21 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:34006 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318128AbSHICxH>; Thu, 8 Aug 2002 22:53:07 -0400
Message-Id: <200208090256.g792uSI05155@w-gaughen.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: akpm@zip.com.au
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (2/4) discontigmem support for i386 against 2.5.30
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-775126470"
Date: Thu, 08 Aug 2002 19:56:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-775126470
Content-Type: text/plain; charset=us-ascii


This patch restructures setup_arch() for i386 to make it easier to
include the i386 numa changes (for CONFIG_DISCONTIGMEM) I've been 
working on.  It also makes setup_arch() easier to read.  A version 
of this patch is the in 2.4 aa tree.

This patch does not depend on the other patches I'm submitting today, but 
my discontigmem patch does depend on this one. 

I've tested this patch on the following configurations: UP, SMP, SMP PAE, 
multiquad, multiquad PAE.

Any and all feedback regarding this patch is greatly appreciated.

Thanks,
Pat

-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/



--==_Exmh_-775126470
Content-Type: application/x-patch ; name="linux-2.5.30-setuparch_A1.patch"
Content-Description: linux-2.5.30-setuparch_A1.patch
Content-Disposition: attachment; filename="linux-2.5.30-setuparch_A1.patch"

diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Thu Aug  8 17:04:51 2002
+++ b/arch/i386/kernel/setup.c	Thu Aug  8 17:04:51 2002
@@ -36,6 +36,7 @@
 #include <linux/highmem.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
+#include <asm/setup.h>
 
 /*
  * Machine setup..
@@ -591,72 +592,13 @@
 	}
 }
 
-void __init setup_arch(char **cmdline_p)
-{
-	unsigned long bootmap_size, low_mem_size;
-	unsigned long start_pfn, max_low_pfn;
-	int i;
-
-	early_cpu_init();
-
-#ifdef CONFIG_VISWS
-	visws_get_board_type_and_rev();
-#endif
-
- 	ROOT_DEV = ORIG_ROOT_DEV;
- 	drive_info = DRIVE_INFO;
- 	screen_info = SCREEN_INFO;
-	apm_info.bios = APM_BIOS_INFO;
-	saved_videomode = VIDEO_MODE;
-	printk("Video mode to be used for restore is %lx\n", saved_videomode);
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
@@ -670,10 +612,15 @@
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
@@ -723,28 +670,19 @@
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
+static void __init register_bootmem_low_pages(unsigned long max_low_pfn)
+{
+	int i;
 
-	/*
-	 * Register fully available low RAM pages with the bootmem allocator.
-	 */
 	for (i = 0; i < e820.nr_map; i++) {
 		unsigned long curr_pfn, last_pfn, size;
- 		/*
+		/*
 		 * Reserve usable low memory
 		 */
 		if (e820.map[i].type != E820_RAM)
@@ -773,6 +711,39 @@
 		size = last_pfn - curr_pfn;
 		free_bootmem(PFN_PHYS(curr_pfn), PFN_PHYS(size));
 	}
+}
+
+static unsigned long __init setup_memory(void)
+{
+	unsigned long bootmap_size, start_pfn, max_low_pfn;
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
@@ -808,6 +779,7 @@
 	 */
 	find_smp_config();
 #endif
+
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (LOADER_TYPE && INITRD_START) {
 		if (INITRD_START + INITRD_SIZE <= (max_low_pfn << PAGE_SHIFT)) {
@@ -825,32 +797,18 @@
 		}
 	}
 #endif
+	return max_low_pfn;
+}
 
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
-	 * Parse the ACPI tables for possible boot-time SMP configuration.
-	 */
-	acpi_boot_init(*cmdline_p);
-#endif
-#ifdef CONFIG_X86_LOCAL_APIC
-	if (smp_found_config)
-		get_smp_config();
-#endif
-
+/*
+ * Request address space for all standard RAM and ROM resources
+ * and also for regions reported as reserved by the e820.
+ */
+static void __init register_memory(unsigned long max_low_pfn)
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
@@ -887,6 +845,76 @@
 	low_mem_size = ((max_low_pfn << PAGE_SHIFT) + 0xfffff) & ~0xfffff;
 	if (low_mem_size > pci_mem_start)
 		pci_mem_start = low_mem_size;
+}
+
+void __init setup_arch(char **cmdline_p)
+{
+	unsigned long max_low_pfn;
+
+	early_cpu_init();
+
+#ifdef CONFIG_VISWS
+	visws_get_board_type_and_rev();
+#endif
+
+ 	ROOT_DEV = ORIG_ROOT_DEV;
+ 	drive_info = DRIVE_INFO;
+ 	screen_info = SCREEN_INFO;
+	apm_info.bios = APM_BIOS_INFO;
+	saved_videomode = VIDEO_MODE;
+	printk("Video mode to be used for restore is %lx\n", saved_videomode);
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
+	 * Parse the ACPI tables for possible boot-time SMP configuration.
+	 */
+	acpi_boot_init(*cmdline_p);
+#endif
+#ifdef CONFIG_X86_LOCAL_APIC
+	if (smp_found_config)
+		get_smp_config();
+#endif
+
+	register_memory(max_low_pfn);
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
diff -Nru a/include/asm-i386/setup.h b/include/asm-i386/setup.h
--- a/include/asm-i386/setup.h	Thu Aug  8 17:04:51 2002
+++ b/include/asm-i386/setup.h	Thu Aug  8 17:04:51 2002
@@ -6,5 +6,14 @@
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

--==_Exmh_-775126470--


