Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314403AbSDRSXp>; Thu, 18 Apr 2002 14:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314405AbSDRSXo>; Thu, 18 Apr 2002 14:23:44 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:37349 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314403AbSDRSXJ>; Thu, 18 Apr 2002 14:23:09 -0400
Message-Id: <200204181817.g3IIHJQ02901@w-gaughen.des.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: marcelo@conectiva.com.br
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] modularization of setup_arch() for 2.4.19pre7
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 Apr 2002 11:17:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please consider this patch for inclusion into the next 2.4 release.  
It was accepted into the 2.4.19pre6aa1, with slight modifications 
by Andrea that I have incorporated into this version of my patch.

This patch restructures setup_arch() for i386 to make it easier to
include the i386 numa changes (for CONFIG_DISCONTIGMEM) I've been 
working on.  It also makes setup_arch() easier to read.  

I'm also submitting a patch for mem_init(), the two patches do not 
depend on each other, but my discontigmem patches (which I'll be
sending out later today or at the start of next week) do depend on 
both.

Previous postings regarding this patch are available at:

http://marc.theaimsgroup.com/?l=linux-kernel&m=101562204614563&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=101664599417813&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=101565828617899&w=2

I've booted with the patches on the following systems:

UP system
4 Proc SMP system
8 Proc NUMA system

Feedback regarding these patches is greatly appreciated.

Thanks,
Pat

-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/

--- linux-2.4.19pre7/arch/i386/kernel/setup.c	Tue Apr 16 15:07:03 2002
+++ linux-2.4.19pre7-cleanup/arch/i386/kernel/setup.c	Tue Apr 16 17:32:17 2002
@@ -800,49 +800,6 @@
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
 #define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
 #define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
 #define PFN_PHYS(x)	((x) << PAGE_SHIFT)
@@ -853,15 +810,14 @@
 #define MAXMEM_PFN	PFN_DOWN(MAXMEM)
 #define MAX_NONPAE_PFN	(1 << 20)
 
-	/*
-	 * partially used pages are not usable - thus
-	 * we are rounding upwards:
-	 */
-	start_pfn = PFN_UP(__pa(&_end));
+/*
+ * Find the highest page frame number we have available
+ */
+static unsigned long __init find_max_pfn(void)
+{
+	unsigned long max_pfn;
+	int i;
 
-	/*
-	 * Find the highest page frame number we have available
-	 */
 	max_pfn = 0;
 	for (i = 0; i < e820.nr_map; i++) {
 		unsigned long start, end;
@@ -876,17 +832,24 @@
 			max_pfn = end;
 	}
 
-	/*
-	 * Determine low and high memory ranges:
-	 */
-	max_low_pfn = max_pfn;
+	return max_pfn;
+}
+
+/*
+ * Determine low and high memory ranges:
+ */
+static unsigned long __init find_max_low_pfn(unsigned long *max_pfn)
+{
+	unsigned long max_low_pfn;
+
+	max_low_pfn = *max_pfn;
 	if (max_low_pfn > MAXMEM_PFN) {
 		if (highmem_pages == -1)
-			highmem_pages = max_pfn - MAXMEM_PFN;
-		if (highmem_pages + MAXMEM_PFN < max_pfn)
-			max_pfn = MAXMEM_PFN + highmem_pages;
-		if (highmem_pages + MAXMEM_PFN > max_pfn) {
-			printk("only %luMB highmem pages available, ignoring highmem size of 
%uMB.\n", pages_to_mb(max_pfn - MAXMEM_PFN), pages_to_mb(highmem_pages));
+			highmem_pages = *max_pfn - MAXMEM_PFN;
+		if (highmem_pages + MAXMEM_PFN < *max_pfn)
+			*max_pfn = MAXMEM_PFN + highmem_pages;
+		if (highmem_pages + MAXMEM_PFN > *max_pfn) {
+			printk("only %luMB highmem pages available, ignoring highmem size of 
%uMB.\n", pages_to_mb(*max_pfn - MAXMEM_PFN), pages_to_mb(highmem_pages));
 			highmem_pages = 0;
 		}
 		max_low_pfn = MAXMEM_PFN;
@@ -894,14 +857,14 @@
 		/* Maximum memory usable is what is directly addressable */
 		printk(KERN_WARNING "Warning only %ldMB will be used.\n",
 					MAXMEM>>20);
-		if (max_pfn > MAX_NONPAE_PFN)
+		if (*max_pfn > MAX_NONPAE_PFN)
 			printk(KERN_WARNING "Use a PAE enabled kernel.\n");
 		else
 			printk(KERN_WARNING "Use a HIGHMEM enabled kernel.\n");
 #else /* !CONFIG_HIGHMEM */
 #ifndef CONFIG_X86_PAE
-		if (max_pfn > MAX_NONPAE_PFN) {
-			max_pfn = MAX_NONPAE_PFN;
+		if (*max_pfn > MAX_NONPAE_PFN) {
+			*max_pfn = MAX_NONPAE_PFN;
 			printk(KERN_WARNING "Warning only 4GB will be used.\n");
 			printk(KERN_WARNING "Use a PAE enabled kernel.\n");
 		}
@@ -911,8 +874,8 @@
 		if (highmem_pages == -1)
 			highmem_pages = 0;
 #if CONFIG_HIGHMEM
-		if (highmem_pages >= max_pfn) {
-			printk(KERN_ERR "highmem size specified (%uMB) is bigger than pages 
available (%luMB)!.\n", pages_to_mb(highmem_pages), pages_to_mb(max_pfn));
+		if (highmem_pages >= *max_pfn) {
+			printk(KERN_ERR "highmem size specified (%uMB) is bigger than pages 
available (%luMB)!.\n", pages_to_mb(highmem_pages), pages_to_mb(*max_pfn));
 			highmem_pages = 0;
 		}
 		if (highmem_pages) {
@@ -928,27 +891,19 @@
 #endif
 	}
 
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
+	return max_low_pfn;
+}
+
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
@@ -977,6 +932,39 @@
 		size = last_pfn - curr_pfn;
 		free_bootmem(PFN_PHYS(curr_pfn), PFN_PHYS(size));
 	}
+}
+
+static unsigned long __init setup_memory(void)
+{
+	unsigned long bootmap_size, start_pfn, max_low_pfn, max_pfn;
+
+	/*
+	 * partially used pages are not usable - thus
+	 * we are rounding upwards:
+	 */
+	start_pfn = PFN_UP(__pa(&_end));
+
+	max_pfn = find_max_pfn();
+
+	max_low_pfn = find_max_low_pfn(&max_pfn);
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
@@ -1025,29 +1013,18 @@
 	}
 #endif
 
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
+	return max_low_pfn;
+}
 
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
@@ -1084,6 +1061,70 @@
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
+	code_resource.start = virt_to_bus(&_text);
+	code_resource.end = virt_to_bus(&_etext)-1;
+	data_resource.start = virt_to_bus(&_etext);
+	data_resource.end = virt_to_bus(&_edata)-1;
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
+#ifdef CONFIG_X86_LOCAL_APIC
+	/*
+	 * get boot-time SMP configuration:
+	 */
+	if (smp_found_config)
+		get_smp_config();
+	init_apic_mappings();
+#endif
+
+	register_memory(max_low_pfn);
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)


