Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWGaIbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWGaIbE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 04:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWGaIbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 04:31:04 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:28291
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1751358AbWGaIbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 04:31:01 -0400
Message-ID: <44CDBFC4.3030808@ed-soft.at>
Date: Mon, 31 Jul 2006 10:31:00 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/3] add-efi-e820-memory-mapping-on-x86.patch
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch add an efi e820 memory mapping.

Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>


diff -uNr linux-2.6.18-rc3/arch/i386/kernel/setup.c linux-2.6.18-rc3.mactel/arch/i386/kernel/setup.c
--- linux-2.6.18-rc3/arch/i386/kernel/setup.c	2006-07-31 09:24:20.000000000 +0200
+++ linux-2.6.18-rc3.mactel/arch/i386/kernel/setup.c	2006-07-31 09:26:19.000000000 +0200
@@ -414,19 +414,17 @@
 {
 	int x;
 
-	if (!efi_enabled) {
-       		x = e820.nr_map;
+	x = e820.nr_map;
 
-		if (x == E820MAX) {
-		    printk(KERN_ERR "Ooops! Too many entries in the memory map!\n");
-		    return;
-		}
-
-		e820.map[x].addr = start;
-		e820.map[x].size = size;
-		e820.map[x].type = type;
-		e820.nr_map++;
+	if (x == E820MAX) {
+	    printk(KERN_ERR "Ooops! Too many entries in the memory map!\n");
+	    return;
 	}
+
+	e820.map[x].addr = start;
+	e820.map[x].size = size;
+	e820.map[x].type = type;
+	e820.nr_map++;
 } /* add_memory_region */
 
 #define E820_DEBUG	1
@@ -1430,6 +1428,64 @@
 static void set_mca_bus(int x) { }
 #endif
 
+#ifdef CONFIG_EFI
+/*
+ * Make a e820 memory map
+ */
+void __init efi_init_e820_map(void)
+{
+	efi_memory_desc_t *md;
+	unsigned long long start = 0;
+	unsigned long long end = 0;
+	unsigned long long size = 0;
+	void *p;
+
+	e820.nr_map = 0;
+
+	for (p = memmap.map; p < memmap.map_end; p += memmap.desc_size) {
+		md = p;
+		switch (md->type) {
+		case EFI_ACPI_RECLAIM_MEMORY:
+			add_memory_region(md->phys_addr,
+				md->num_pages << EFI_PAGE_SHIFT, E820_ACPI);
+			break;
+		case EFI_RUNTIME_SERVICES_CODE:
+		case EFI_RUNTIME_SERVICES_DATA:
+		case EFI_RESERVED_TYPE:
+		case EFI_MEMORY_MAPPED_IO:
+		case EFI_MEMORY_MAPPED_IO_PORT_SPACE:
+		case EFI_UNUSABLE_MEMORY:
+			add_memory_region(md->phys_addr,
+				md->num_pages << EFI_PAGE_SHIFT, E820_RESERVED);
+			break;
+		case EFI_LOADER_CODE:
+		case EFI_LOADER_DATA:
+		case EFI_BOOT_SERVICES_CODE:
+		case EFI_BOOT_SERVICES_DATA:
+		case EFI_CONVENTIONAL_MEMORY:
+			start = md->phys_addr;
+			size = md->num_pages << EFI_PAGE_SHIFT;
+			end = start + size;
+			if (start < 0x100000ULL && end > 0xA0000ULL) {
+				if (start < 0xA0000ULL)
+					add_memory_region(start,
+						0xA0000ULL-start, E820_RAM);
+				if (end <= 0x100000ULL)
+					continue;
+				start = 0x100000ULL;
+				size = end - start;
+			}
+			add_memory_region(start, size, E820_RAM);
+			break;
+		case EFI_ACPI_MEMORY_NVS:
+			add_memory_region(md->phys_addr,
+				md->num_pages << EFI_PAGE_SHIFT, E820_NVS);
+			break;
+		}
+	}
+}
+#endif
+
 /*
  * Determine if we were loaded by an EFI loader.  If so, then we have also been
  * passed the efi memmap, systab, etc., so we should use these data structures
@@ -1478,9 +1534,11 @@
 	rd_doload = ((RAMDISK_FLAGS & RAMDISK_LOAD_FLAG) != 0);
 #endif
 	ARCH_SETUP
-	if (efi_enabled)
+	if (efi_enabled) {
 		efi_init();
-	else {
+		efi_init_e820_map();
+		print_memory_map("BIOS-EFI");
+	} else {
 		printk(KERN_INFO "BIOS-provided physical RAM map:\n");
 		print_memory_map(machine_specific_memory_setup());
 	}


