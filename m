Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267260AbTGLBqH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 21:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267123AbTGLBqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 21:46:06 -0400
Received: from fmr03.intel.com ([143.183.121.5]:14572 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S267207AbTGLBpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 21:45:21 -0400
Date: Fri, 11 Jul 2003 19:00:02 -0700
From: Matt Tolentino <metolent@unix-os.sc.intel.com>
Message-Id: <200307120200.h6C202f22639@unix-os.sc.intel.com>
To: andrew.grover@intel.com, davidm@napali.hpl.hp.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remove pa->va->pa conversion for efi.acpi
Cc: matthew.e.tolentino@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David, Andy,

During ia64 kernel initialization, the physical address of the ACPI tables is passed via the EFI Configuration Table.  In efi_init() the address is stored as a virtual address in the kernel's efi structure.  Later when ACPI is initialized, these are converted back to physical addresses in acpi_find_rsdp() and acpi_os_get_root_pointer().   

This patch (against 2.5.75) removes the macro to store the address as virtual and removes the macros doing the reverse conversion back to physical.  As I'm currently working on a patch to add support for booting and initializing  IA-32 kernels from EFI, this simplifies the changes to drivers/acpi/osl.c to also get the physical address.  Fwiw, I was able to boot a slightly older 2.5.69 kernel on an Itanium II system w/o issue with this patch...

thanks,
matt


diff -urN linux-2.5.75/arch/ia64/kernel/acpi.c linux-2.5.75-acpi/arch/ia64/kernel/acpi.c
--- linux-2.5.75/arch/ia64/kernel/acpi.c	2003-07-10 13:09:03.000000000 -0700
+++ linux-2.5.75-acpi/arch/ia64/kernel/acpi.c	2003-07-11 15:20:42.000000000 -0700
@@ -568,7 +568,7 @@
 	unsigned long rsdp_phys = 0;
 
 	if (efi.acpi20)
-		rsdp_phys = __pa(efi.acpi20);
+		rsdp_phys = efi.acpi20;
 	else if (efi.acpi)
 		printk(KERN_WARNING PREFIX "v1.0/r0.71 tables no longer supported\n");
 	return rsdp_phys;
diff -urN linux-2.5.75/arch/ia64/kernel/efi.c linux-2.5.75-acpi/arch/ia64/kernel/efi.c
--- linux-2.5.75/arch/ia64/kernel/efi.c	2003-07-10 13:04:43.000000000 -0700
+++ linux-2.5.75-acpi/arch/ia64/kernel/efi.c	2003-07-11 15:20:27.000000000 -0700
@@ -525,10 +525,10 @@
 			efi.mps = __va(config_tables[i].table);
 			printk(" MPS=0x%lx", config_tables[i].table);
 		} else if (efi_guidcmp(config_tables[i].guid, ACPI_20_TABLE_GUID) == 0) {
-			efi.acpi20 = __va(config_tables[i].table);
+			efi.acpi20 = config_tables[i].table;
 			printk(" ACPI 2.0=0x%lx", config_tables[i].table);
 		} else if (efi_guidcmp(config_tables[i].guid, ACPI_TABLE_GUID) == 0) {
-			efi.acpi = __va(config_tables[i].table);
+			efi.acpi = config_tables[i].table;
 			printk(" ACPI=0x%lx", config_tables[i].table);
 		} else if (efi_guidcmp(config_tables[i].guid, SMBIOS_TABLE_GUID) == 0) {
 			efi.smbios = __va(config_tables[i].table);
diff -urN linux-2.5.75/drivers/acpi/osl.c linux-2.5.75-acpi/drivers/acpi/osl.c
--- linux-2.5.75/drivers/acpi/osl.c	2003-07-10 13:13:05.000000000 -0700
+++ linux-2.5.75-acpi/drivers/acpi/osl.c	2003-07-11 15:21:18.000000000 -0700
@@ -142,9 +142,9 @@
 #ifdef CONFIG_ACPI_EFI
 	addr->pointer_type = ACPI_PHYSICAL_POINTER;
 	if (efi.acpi20)
-		addr->pointer.physical = (acpi_physical_address) virt_to_phys(efi.acpi20);
+		addr->pointer.physical = (acpi_physical_address) efi.acpi20;
 	else if (efi.acpi)
-		addr->pointer.physical = (acpi_physical_address) virt_to_phys(efi.acpi);
+		addr->pointer.physical = (acpi_physical_address) efi.acpi;
 	else {
 		printk(KERN_ERR PREFIX "System description tables not found\n");
 		return AE_NOT_FOUND;
