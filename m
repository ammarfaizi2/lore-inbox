Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318968AbSHFDOt>; Mon, 5 Aug 2002 23:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318970AbSHFDOt>; Mon, 5 Aug 2002 23:14:49 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:53481 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318968AbSHFDOp>; Mon, 5 Aug 2002 23:14:45 -0400
Message-Id: <200208060318.g763I0J25116@w-gaughen.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: marcelo@conectiva.com.br
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] modularization of setup_arch() for 2.4.20pre1
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-19820128880"
Date: Mon, 05 Aug 2002 20:18:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-19820128880
Content-Type: text/plain; charset=us-ascii


Please consider this patch for inclusion into the 2.4.20pre tree.
It was accepted into the 2.4.19pre6aa1, with slight modifications 
by Andrea that I have incorporated those changes into my patch.  
This patch, along with the modularization of mem_init, and the 
{node,zone}_start_paddr to {node,zone}_start_pfn change, are the
patches that my i386 discontigmem patch depends on.

This patch restructures setup_arch() for i386 to make it easier to
include the i386 numa changes (for CONFIG_DISCONTIGMEM) I've been 
working on.  It also makes setup_arch() easier to read.  

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


--==_Exmh_-19820128880
Content-Type: application/x-patch ; name="linux-2.4.20-pre1_setuparch_A2.patch"
Content-Description: linux-2.4.20-pre1_setuparch_A2.patch
Content-Disposition: attachment; filename="linux-2.4.20-pre1_setuparch_A2.patch"

diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Mon Aug  5 18:23:48 2002
+++ b/arch/i386/kernel/setup.c	Mon Aug  5 18:23:48 2002
@@ -868,49 +868,6 @@
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
-	parse_cmdline_early(cmdline_p);
-
 #define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
 #define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
 #define PFN_PHYS(x)	((x) << PAGE_SHIFT)
@@ -921,15 +878,14 @@
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
@@ -944,17 +900,24 @@
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
-			printk("only %luMB highmem pages available, ignoring highmem size of %uMB.\n", pages_to_mb(max_pfn - MAXMEM_PFN), pages_to_mb(highmem_pages));
+			highmem_pages = *max_pfn - MAXMEM_PFN;
+		if (highmem_pages + MAXMEM_PFN < *max_pfn)
+			*max_pfn = MAXMEM_PFN + highmem_pages;
+		if (highmem_pages + MAXMEM_PFN > *max_pfn) {
+			printk("only %luMB highmem pages available, ignoring highmem size of %uMB.\n", pages_to_mb(*max_pfn - MAXMEM_PFN), pages_to_mb(highmem_pages));
 			highmem_pages = 0;
 		}
 		max_low_pfn = MAXMEM_PFN;
@@ -962,14 +925,14 @@
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
@@ -979,8 +942,8 @@
 		if (highmem_pages == -1)
 			highmem_pages = 0;
 #if CONFIG_HIGHMEM
-		if (highmem_pages >= max_pfn) {
-			printk(KERN_ERR "highmem size specified (%uMB) is bigger than pages available (%luMB)!.\n", pages_to_mb(highmem_pages), pages_to_mb(max_pfn));
+		if (highmem_pages >= *max_pfn) {
+			printk(KERN_ERR "highmem size specified (%uMB) is bigger than pages available (%luMB)!.\n", pages_to_mb(highmem_pages), pages_to_mb(*max_pfn));
 			highmem_pages = 0;
 		}
 		if (highmem_pages) {
@@ -996,27 +959,19 @@
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
@@ -1045,6 +1000,39 @@
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
@@ -1093,6 +1081,99 @@
 	}
 #endif
 
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
+
+	probe_roms();
+	for (i = 0; i < e820.nr_map; i++) {
+		struct resource *res;
+		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
+			continue;
+		res = alloc_bootmem_low(sizeof(struct resource));
+		switch (e820.map[i].type) {
+		case E820_RAM:	res->name = "System RAM"; break;
+		case E820_ACPI:	res->name = "ACPI Tables"; break;
+		case E820_NVS:	res->name = "ACPI Non-volatile Storage"; break;
+		default:	res->name = "reserved";
+		}
+		res->start = e820.map[i].addr;
+		res->end = res->start + e820.map[i].size - 1;
+		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+		request_resource(&iomem_resource, res);
+		if (e820.map[i].type == E820_RAM) {
+			/*
+			 *  We dont't know which RAM region contains kernel data,
+			 *  so we try it repeatedly and let the resource manager
+			 *  test it.
+			 */
+			request_resource(res, &code_resource);
+			request_resource(res, &data_resource);
+		}
+	}
+	request_resource(&iomem_resource, &vram_resource);
+
+	/* request I/O space for devices used on all i[345]86 PCs */
+	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
+		request_resource(&ioport_resource, standard_io_resources+i);
+
+	/* Tell the PCI layer not to allocate too close to the RAM area.. */
+	low_mem_size = ((max_low_pfn << PAGE_SHIFT) + 0xfffff) & ~0xfffff;
+	if (low_mem_size > pci_mem_start)
+		pci_mem_start = low_mem_size;
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
+	parse_cmdline_early(cmdline_p);
+
+	max_low_pfn = setup_memory();
+
 	/*
 	 * If enable_acpi_smp_table and HT feature present, acpitable.c
 	 * will find all logical cpus despite disable_x86_ht: so if both
@@ -1133,47 +1214,7 @@
 		get_smp_config();
 #endif
 
-
-	/*
-	 * Request address space for all standard RAM and ROM resources
-	 * and also for regions reported as reserved by the e820.
-	 */
-	probe_roms();
-	for (i = 0; i < e820.nr_map; i++) {
-		struct resource *res;
-		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
-			continue;
-		res = alloc_bootmem_low(sizeof(struct resource));
-		switch (e820.map[i].type) {
-		case E820_RAM:	res->name = "System RAM"; break;
-		case E820_ACPI:	res->name = "ACPI Tables"; break;
-		case E820_NVS:	res->name = "ACPI Non-volatile Storage"; break;
-		default:	res->name = "reserved";
-		}
-		res->start = e820.map[i].addr;
-		res->end = res->start + e820.map[i].size - 1;
-		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-		request_resource(&iomem_resource, res);
-		if (e820.map[i].type == E820_RAM) {
-			/*
-			 *  We dont't know which RAM region contains kernel data,
-			 *  so we try it repeatedly and let the resource manager
-			 *  test it.
-			 */
-			request_resource(res, &code_resource);
-			request_resource(res, &data_resource);
-		}
-	}
-	request_resource(&iomem_resource, &vram_resource);
-
-	/* request I/O space for devices used on all i[345]86 PCs */
-	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
-		request_resource(&ioport_resource, standard_io_resources+i);
-
-	/* Tell the PCI layer not to allocate too close to the RAM area.. */
-	low_mem_size = ((max_low_pfn << PAGE_SHIFT) + 0xfffff) & ~0xfffff;
-	if (low_mem_size > pci_mem_start)
-		pci_mem_start = low_mem_size;
+	register_memory(max_low_pfn);
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)

--==_Exmh_-19820128880--


