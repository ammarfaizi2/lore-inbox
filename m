Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318781AbSHRAlX>; Sat, 17 Aug 2002 20:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318785AbSHRAlX>; Sat, 17 Aug 2002 20:41:23 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:23242 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318781AbSHRAlT>; Sat, 17 Aug 2002 20:41:19 -0400
Message-Id: <200208180044.g7I0ihe02269@w-gaughen.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (1/4) discontigmem support for i386 against 2.4.20pre3
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-11927534680"
Date: Sat, 17 Aug 2002 17:44:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-11927534680
Content-Type: text/plain; charset=us-ascii


This patch restructures setup_arch() for i386 to make it easier to
include the i386 numa changes (for CONFIG_DISCONTIGMEM) I've been
working on.  It also makes setup_arch() easier to read.  A version of
this patch is the in 2.4 aa tree.

The main things that the patch does is moves the code in setup_arch()
that figures out the max_pfn, max_low_pfn, and setups up and uses the
bootmem into a separate function (setup_memory()) so that I can
redefine the function to make use of the _node() routines
(i.e. init_bootmem_node()) and call any other numa specific
functions. I also moved the functionality to find the max_low_pfn and
max_pfn into separate functions (find_max_low_pfn() and
find_max_pfn()) so I could just reuse that code.

This patch does not depend on the other patches I'm submitting today,
but my discontigmem patch does depend on this one.

I've tested this patch on the following configurations: UP, SMP, SMP
PAE, multiquad, multiquad PAE.

Any and all feedback regarding this patch is greatly appreciated.

Thanks,
Pat

-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/


--==_Exmh_-11927534680
Content-Type: application/x-patch ; name="linux-2.4.20-pre3_setuparch_A1.patch"
Content-Description: linux-2.4.20-pre3_setuparch_A1.patch
Content-Disposition: attachment; filename="linux-2.4.20-pre3_setuparch_A1.patch"

diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Sat Aug 17 13:57:06 2002
+++ b/arch/i386/kernel/setup.c	Sat Aug 17 13:57:06 2002
@@ -813,53 +813,6 @@
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
-#ifndef CONFIG_HIGHIO
-	blk_nohighio = 1;
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
-	parse_cmdline_early(cmdline_p);
-
 #define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
 #define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
 #define PFN_PHYS(x)	((x) << PAGE_SHIFT)
@@ -870,15 +823,13 @@
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
+static void __init find_max_pfn(void)
+{
+	int i;
 
-	/*
-	 * Find the highest page frame number we have available
-	 */
 	max_pfn = 0;
 	for (i = 0; i < e820.nr_map; i++) {
 		unsigned long start, end;
@@ -892,10 +843,15 @@
 		if (end > max_pfn)
 			max_pfn = end;
 	}
+}
+
+/*
+ * Determine low and high memory ranges:
+ */
+static unsigned long __init find_max_low_pfn(void)
+{
+	unsigned long max_low_pfn;
 
-	/*
-	 * Determine low and high memory ranges:
-	 */
 	max_low_pfn = max_pfn;
 	if (max_low_pfn > MAXMEM_PFN) {
 		if (highmem_pages == -1)
@@ -945,27 +901,19 @@
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
@@ -994,6 +942,39 @@
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
@@ -1042,43 +1023,18 @@
 	}
 #endif
 
-	/*
-	 * If enable_acpi_smp_table and HT feature present, acpitable.c
-	 * will find all logical cpus despite disable_x86_ht: so if both
-	 * "noht" and "acpismp=force" are specified, let "noht" override
-	 * "acpismp=force" cleanly.  Why retain "acpismp=force"? because
-	 * parsing ACPI SMP table might prove useful on some non-HT cpu.
-	 */
-	if (disable_x86_ht) {
-		clear_bit(X86_FEATURE_HT, &boot_cpu_data.x86_capability[0]);
-		enable_acpi_smp_table = 0;
-	}
-	if (test_bit(X86_FEATURE_HT, &boot_cpu_data.x86_capability[0]))
-		enable_acpi_smp_table = 1;
-	
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
-#endif
-
+	return max_low_pfn;
+}
+ 
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
@@ -1115,6 +1071,88 @@
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
+#ifndef CONFIG_HIGHIO
+	blk_nohighio = 1;
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
+	parse_cmdline_early(cmdline_p);
+
+	max_low_pfn = setup_memory();
+
+	/*
+	 * If enable_acpi_smp_table and HT feature present, acpitable.c
+	 * will find all logical cpus despite disable_x86_ht: so if both
+	 * "noht" and "acpismp=force" are specified, let "noht" override
+	 * "acpismp=force" cleanly.  Why retain "acpismp=force"? because
+	 * parsing ACPI SMP table might prove useful on some non-HT cpu.
+	 */
+	if (disable_x86_ht) {
+		clear_bit(X86_FEATURE_HT, &boot_cpu_data.x86_capability[0]);
+		enable_acpi_smp_table = 0;
+	}
+	if (test_bit(X86_FEATURE_HT, &boot_cpu_data.x86_capability[0]))
+		enable_acpi_smp_table = 1;
+	
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
+#endif
+
+	register_memory(max_low_pfn);
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)

--==_Exmh_-11927534680--


