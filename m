Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262846AbVGNA6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbVGNA6W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 20:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbVGNA4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 20:56:14 -0400
Received: from fmr20.intel.com ([134.134.136.19]:25741 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261379AbVGNAyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 20:54:39 -0400
Date: Wed, 13 Jul 2005 18:09:36 -0700
From: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Message-Id: <200507140109.j6E19a58013012@snoqualmie.dp.intel.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] fix ACPI table discovery from EFI for x86
Cc: akpm@osdl.org, linux-ia64@vger.kernel.org, tony.luck@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch addresses a problem on x86 EFI systems with larger memory
configurations.  Up until now, we've relied on the fact that the 
ACPI RSDT would reside somewhere in low memory that could be permanently 
mapped in kernel address space - so __va() has been sufficient.  However,
on EFI systems, the RSDT is often anywhere in the lower 4GB of physical
address space.  So, we may need to remap it on x86 systems.  

Second, this fixes some miscalculations in one of the EFI memmap 
callback functions.  

Lastly, this also removes all of the va->pa->va contortions and 
stores the physical location in the efi struct while preserving the 
validity checks.  This change is the only reason this impacts 
ia64. 

Tested on x86 EFI machines and boot tested on one ia64 machine
thanks to Tony.  Additional testing on ia64 machines would be 
appreciated!  

Problem reported and original patch proposed by Ping Wei.

Signed-off-by: Matt Tolentino <matthew.e.tolentino@intel.com>
---
diff -urNp linux-2.6.13-rc3/arch/i386/kernel/acpi/boot.c linux-2.6.13-rc3-efi/arch/i386/kernel/acpi/boot.c
--- linux-2.6.13-rc3/arch/i386/kernel/acpi/boot.c	2005-07-13 00:46:46.000000000 -0400
+++ linux-2.6.13-rc3-efi/arch/i386/kernel/acpi/boot.c	2005-07-13 10:32:54.073297792 -0400
@@ -682,10 +682,10 @@ acpi_find_rsdp (void)
 	unsigned long		rsdp_phys = 0;
 
 	if (efi_enabled) {
-		if (efi.acpi20)
-			return __pa(efi.acpi20);
-		else if (efi.acpi)
-			return __pa(efi.acpi);
+		if (efi.phys_acpi20 != EFI_INVALID_ACPI_TABLE_ADDR)
+			return efi.phys_acpi20;
+		else if (efi.phys_acpi != EFI_INVALID_ACPI_TABLE_ADDR)
+			return efi.phys_acpi;
 	}
 	/*
 	 * Scan memory looking for the RSDP signature. First search EBDA (low
diff -urNp linux-2.6.13-rc3/arch/i386/kernel/efi.c linux-2.6.13-rc3-efi/arch/i386/kernel/efi.c
--- linux-2.6.13-rc3/arch/i386/kernel/efi.c	2005-07-13 00:46:46.000000000 -0400
+++ linux-2.6.13-rc3-efi/arch/i386/kernel/efi.c	2005-07-13 10:32:04.731798840 -0400
@@ -376,17 +376,20 @@ void __init efi_init(void)
 	if (config_tables == NULL)
 		printk(KERN_ERR PFX "Could not map EFI Configuration Table!\n");
 
+	efi.phys_acpi20 = EFI_INVALID_ACPI_TABLE_ADDR;
+	efi.phys_acpi = EFI_INVALID_ACPI_TABLE_ADDR;
+
 	for (i = 0; i < num_config_tables; i++) {
 		if (efi_guidcmp(config_tables[i].guid, MPS_TABLE_GUID) == 0) {
 			efi.mps = (void *)config_tables[i].table;
 			printk(KERN_INFO " MPS=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, ACPI_20_TABLE_GUID) == 0) {
-			efi.acpi20 = __va(config_tables[i].table);
+			efi.phys_acpi20 = config_tables[i].table;
 			printk(KERN_INFO " ACPI 2.0=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, ACPI_TABLE_GUID) == 0) {
-			efi.acpi = __va(config_tables[i].table);
+			efi.phys_acpi = config_tables[i].table;
 			printk(KERN_INFO " ACPI=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, SMBIOS_TABLE_GUID) == 0) {
diff -urNp linux-2.6.13-rc3/arch/i386/kernel/setup.c linux-2.6.13-rc3-efi/arch/i386/kernel/setup.c
--- linux-2.6.13-rc3/arch/i386/kernel/setup.c	2005-07-13 00:46:46.000000000 -0400
+++ linux-2.6.13-rc3-efi/arch/i386/kernel/setup.c	2005-07-13 10:24:25.149665944 -0400
@@ -1034,10 +1034,10 @@ static int __init
 free_available_memory(unsigned long start, unsigned long end, void *arg)
 {
 	/* check max_low_pfn */
-	if (start >= ((max_low_pfn + 1) << PAGE_SHIFT))
+	if (start >= (max_low_pfn << PAGE_SHIFT))
 		return 0;
-	if (end >= ((max_low_pfn + 1) << PAGE_SHIFT))
-		end = (max_low_pfn + 1) << PAGE_SHIFT;
+	if (end >= (max_low_pfn << PAGE_SHIFT))
+		end = max_low_pfn << PAGE_SHIFT;
 	if (start < end)
 		free_bootmem(start, end - start);
 
diff -urNp linux-2.6.13-rc3/arch/ia64/kernel/acpi.c linux-2.6.13-rc3-efi/arch/ia64/kernel/acpi.c
--- linux-2.6.13-rc3/arch/ia64/kernel/acpi.c	2005-07-13 00:46:46.000000000 -0400
+++ linux-2.6.13-rc3-efi/arch/ia64/kernel/acpi.c	2005-07-13 10:33:51.614550192 -0400
@@ -615,9 +615,9 @@ acpi_find_rsdp (void)
 {
 	unsigned long rsdp_phys = 0;
 
-	if (efi.acpi20)
-		rsdp_phys = __pa(efi.acpi20);
-	else if (efi.acpi)
+	if (efi.phys_acpi20 != EFI_INVALID_ACPI_TABLE_ADDR)
+		rsdp_phys = efi.phys_acpi20;
+	else if (efi.phys_acpi != EFI_INVALID_ACPI_TABLE_ADDR)
 		printk(KERN_WARNING PREFIX "v1.0/r0.71 tables no longer supported\n");
 	return rsdp_phys;
 }
diff -urNp linux-2.6.13-rc3/arch/ia64/kernel/efi.c linux-2.6.13-rc3-efi/arch/ia64/kernel/efi.c
--- linux-2.6.13-rc3/arch/ia64/kernel/efi.c	2005-07-13 00:46:46.000000000 -0400
+++ linux-2.6.13-rc3-efi/arch/ia64/kernel/efi.c	2005-07-13 10:33:32.002531672 -0400
@@ -596,15 +596,18 @@ efi_init (void)
 	printk(KERN_INFO "EFI v%u.%.02u by %s:",
 	       efi.systab->hdr.revision >> 16, efi.systab->hdr.revision & 0xffff, vendor);
 
+	efi.phys_acpi20 = EFI_INVALID_ACPI_TABLE_ADDR;
+	efi.phys_acpi = EFI_INVALID_ACPI_TABLE_ADDR;
+
 	for (i = 0; i < (int) efi.systab->nr_tables; i++) {
 		if (efi_guidcmp(config_tables[i].guid, MPS_TABLE_GUID) == 0) {
 			efi.mps = __va(config_tables[i].table);
 			printk(" MPS=0x%lx", config_tables[i].table);
 		} else if (efi_guidcmp(config_tables[i].guid, ACPI_20_TABLE_GUID) == 0) {
-			efi.acpi20 = __va(config_tables[i].table);
+			efi.phys_acpi20 = config_tables[i].table;
 			printk(" ACPI 2.0=0x%lx", config_tables[i].table);
 		} else if (efi_guidcmp(config_tables[i].guid, ACPI_TABLE_GUID) == 0) {
-			efi.acpi = __va(config_tables[i].table);
+			efi.phys_acpi = config_tables[i].table;
 			printk(" ACPI=0x%lx", config_tables[i].table);
 		} else if (efi_guidcmp(config_tables[i].guid, SMBIOS_TABLE_GUID) == 0) {
 			efi.smbios = __va(config_tables[i].table);
diff -urNp linux-2.6.13-rc3/drivers/acpi/osl.c linux-2.6.13-rc3-efi/drivers/acpi/osl.c
--- linux-2.6.13-rc3/drivers/acpi/osl.c	2005-07-13 00:46:46.000000000 -0400
+++ linux-2.6.13-rc3-efi/drivers/acpi/osl.c	2005-07-13 10:34:25.417411376 -0400
@@ -163,12 +163,12 @@ acpi_os_get_root_pointer(u32 flags, stru
 {
 	if (efi_enabled) {
 		addr->pointer_type = ACPI_PHYSICAL_POINTER;
-		if (efi.acpi20)
+		if (efi.phys_acpi20 != EFI_INVALID_ACPI_TABLE_ADDR)
 			addr->pointer.physical =
-				(acpi_physical_address) virt_to_phys(efi.acpi20);
-		else if (efi.acpi)
+				(acpi_physical_address)efi.phys_acpi20;
+		else if (efi.phys_acpi != EFI_INVALID_ACPI_TABLE_ADDR)
 			addr->pointer.physical =
-				(acpi_physical_address) virt_to_phys(efi.acpi);
+				(acpi_physical_address)efi.phys_acpi;
 		else {
 			printk(KERN_ERR PREFIX "System description tables not found\n");
 			return AE_NOT_FOUND;
@@ -187,7 +187,9 @@ acpi_status
 acpi_os_map_memory(acpi_physical_address phys, acpi_size size, void __iomem **virt)
 {
 	if (efi_enabled) {
-		if (EFI_MEMORY_WB & efi_mem_attributes(phys)) {
+		/* determine whether or not we need to call ioremap */
+		if ((EFI_MEMORY_WB & efi_mem_attributes(phys)) && 
+			((unsigned long)phys < (unsigned long)__pa(high_memory))) {
 			*virt = (void __iomem *) phys_to_virt(phys);
 		} else {
 			*virt = ioremap(phys, size);
diff -urNp linux-2.6.13-rc3/drivers/acpi/tables.c linux-2.6.13-rc3-efi/drivers/acpi/tables.c
--- linux-2.6.13-rc3/drivers/acpi/tables.c	2005-07-13 00:46:46.000000000 -0400
+++ linux-2.6.13-rc3-efi/drivers/acpi/tables.c	2005-07-13 10:24:25.180661232 -0400
@@ -581,7 +581,8 @@ acpi_table_init (void)
 		return -ENODEV;
 	}
 
-	rsdp = (struct acpi_table_rsdp *) __va(rsdp_phys);
+	rsdp = (struct acpi_table_rsdp *) __acpi_map_table(rsdp_phys, 
+		sizeof(struct acpi_table_rsdp));
 	if (!rsdp) {
 		printk(KERN_WARNING PREFIX "Unable to map RSDP\n");
 		return -ENODEV;
diff -urNp linux-2.6.13-rc3/drivers/firmware/efivars.c linux-2.6.13-rc3-efi/drivers/firmware/efivars.c
--- linux-2.6.13-rc3/drivers/firmware/efivars.c	2005-07-13 00:46:46.000000000 -0400
+++ linux-2.6.13-rc3-efi/drivers/firmware/efivars.c	2005-07-13 10:24:25.183660776 -0400
@@ -570,10 +570,10 @@ systab_read(struct subsystem *entry, cha
 
 	if (efi.mps)
 		str += sprintf(str, "MPS=0x%lx\n", __pa(efi.mps));
-	if (efi.acpi20)
-		str += sprintf(str, "ACPI20=0x%lx\n", __pa(efi.acpi20));
-	if (efi.acpi)
-		str += sprintf(str, "ACPI=0x%lx\n", __pa(efi.acpi));
+	if (efi.phys_acpi20 != ~0UL)
+		str += sprintf(str, "ACPI20=0x%lx\n", efi.phys_acpi20);
+	if (efi.phys_acpi != ~0UL)
+		str += sprintf(str, "ACPI=0x%lx\n", efi.phys_acpi);
 	if (efi.smbios)
 		str += sprintf(str, "SMBIOS=0x%lx\n", __pa(efi.smbios));
 	if (efi.hcdp)
diff -urNp linux-2.6.13-rc3/include/linux/efi.h linux-2.6.13-rc3-efi/include/linux/efi.h
--- linux-2.6.13-rc3/include/linux/efi.h	2005-07-13 00:46:46.000000000 -0400
+++ linux-2.6.13-rc3-efi/include/linux/efi.h	2005-07-13 10:36:24.999232176 -0400
@@ -246,14 +246,16 @@ struct efi_memory_map {
 	unsigned long desc_version;
 };
 
+#define EFI_INVALID_ACPI_TABLE_ADDR	(~0UL)
+
 /*
  * All runtime access to EFI goes through this structure:
  */
 extern struct efi {
 	efi_system_table_t *systab;	/* EFI system table */
 	void *mps;			/* MPS table */
-	void *acpi;			/* ACPI table  (IA64 ext 0.71) */
-	void *acpi20;			/* ACPI table  (ACPI 2.0) */
+	unsigned long phys_acpi;	/* ACPI table  */
+	unsigned long phys_acpi20;	/* ACPI table  (ACPI 2.0) */
 	void *smbios;			/* SM BIOS table */
 	void *sal_systab;		/* SAL system table */
 	void *boot_info;		/* boot info table */
