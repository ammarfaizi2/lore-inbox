Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161398AbWASUOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161398AbWASUOJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161402AbWASUOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:14:08 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:40077 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1161381AbWASUOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:14:01 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Subject: [PATCH 4/5] EFI: keep physical table addresses in efi structure
Date: Thu, 19 Jan 2006 13:13:57 -0700
User-Agent: KMail/1.8.3
Cc: linux-ia64@vger.kernel.org, ak@suse.de,
       openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20060104221627.GA26064@lists.us.dell.com> <20060118181116.GA5537@lists.us.dell.com> <200601191310.57303.bjorn.helgaas@hp.com>
In-Reply-To: <200601191310.57303.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601191313.57282.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Almost all users of the table addresses from the EFI system table
want physical addresses.  So rather than doing the pa->va->pa
conversion, just keep physical addresses in struct efi.

This fixes a DMI bug: the efi structure contained the physical SMBIOS
address on x86 but the virtual address on ia64, so dmi_scan_machine()
used ioremap() on a virtual address on ia64.

This is essentially the same as an earlier patch by Matt Tolentino:
    http://marc.theaimsgroup.com/?l=linux-kernel&m=112130292316281&w=2
except that this changes all table addresses, not just ACPI addresses.

Matt's original patch was backed out because it caused MCAs on HP sx1000
systems.  That problem is resolved by the ioremap() attribute checking
added for ia64.

Depends on the previous ia64 ioremap patch.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm3/arch/i386/kernel/efi.c
===================================================================
--- work-mm3.orig/arch/i386/kernel/efi.c	2006-01-19 11:26:17.000000000 -0700
+++ work-mm3/arch/i386/kernel/efi.c	2006-01-19 11:37:23.000000000 -0700
@@ -377,29 +377,38 @@
 	if (config_tables == NULL)
 		printk(KERN_ERR PFX "Could not map EFI Configuration Table!\n");
 
+	efi.mps        = EFI_INVALID_TABLE_ADDR;
+	efi.acpi       = EFI_INVALID_TABLE_ADDR;
+	efi.acpi20     = EFI_INVALID_TABLE_ADDR;
+	efi.smbios     = EFI_INVALID_TABLE_ADDR;
+	efi.sal_systab = EFI_INVALID_TABLE_ADDR;
+	efi.boot_info  = EFI_INVALID_TABLE_ADDR;
+	efi.hcdp       = EFI_INVALID_TABLE_ADDR;
+	efi.uga        = EFI_INVALID_TABLE_ADDR;
+
 	for (i = 0; i < num_config_tables; i++) {
 		if (efi_guidcmp(config_tables[i].guid, MPS_TABLE_GUID) == 0) {
-			efi.mps = (void *)config_tables[i].table;
+			efi.mps = config_tables[i].table;
 			printk(KERN_INFO " MPS=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, ACPI_20_TABLE_GUID) == 0) {
-			efi.acpi20 = __va(config_tables[i].table);
+			efi.acpi20 = config_tables[i].table;
 			printk(KERN_INFO " ACPI 2.0=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, ACPI_TABLE_GUID) == 0) {
-			efi.acpi = __va(config_tables[i].table);
+			efi.acpi = config_tables[i].table;
 			printk(KERN_INFO " ACPI=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, SMBIOS_TABLE_GUID) == 0) {
-			efi.smbios = (void *) config_tables[i].table;
+			efi.smbios = config_tables[i].table;
 			printk(KERN_INFO " SMBIOS=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, HCDP_TABLE_GUID) == 0) {
-			efi.hcdp = (void *)config_tables[i].table;
+			efi.hcdp = config_tables[i].table;
 			printk(KERN_INFO " HCDP=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, UGA_IO_PROTOCOL_GUID) == 0) {
-			efi.uga = (void *)config_tables[i].table;
+			efi.uga = config_tables[i].table;
 			printk(KERN_INFO " UGA=0x%lx ", config_tables[i].table);
 		}
 	}
Index: work-mm3/arch/ia64/kernel/efi.c
===================================================================
--- work-mm3.orig/arch/ia64/kernel/efi.c	2006-01-19 11:36:52.000000000 -0700
+++ work-mm3/arch/ia64/kernel/efi.c	2006-01-19 11:37:23.000000000 -0700
@@ -466,24 +466,33 @@
 	printk(KERN_INFO "EFI v%u.%.02u by %s:",
 	       efi.systab->hdr.revision >> 16, efi.systab->hdr.revision & 0xffff, vendor);
 
+	efi.mps        = EFI_INVALID_TABLE_ADDR;
+	efi.acpi       = EFI_INVALID_TABLE_ADDR;
+	efi.acpi20     = EFI_INVALID_TABLE_ADDR;
+	efi.smbios     = EFI_INVALID_TABLE_ADDR;
+	efi.sal_systab = EFI_INVALID_TABLE_ADDR;
+	efi.boot_info  = EFI_INVALID_TABLE_ADDR;
+	efi.hcdp       = EFI_INVALID_TABLE_ADDR;
+	efi.uga        = EFI_INVALID_TABLE_ADDR;
+
 	for (i = 0; i < (int) efi.systab->nr_tables; i++) {
 		if (efi_guidcmp(config_tables[i].guid, MPS_TABLE_GUID) == 0) {
-			efi.mps = __va(config_tables[i].table);
+			efi.mps = config_tables[i].table;
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
-			efi.smbios = __va(config_tables[i].table);
+			efi.smbios = config_tables[i].table;
 			printk(" SMBIOS=0x%lx", config_tables[i].table);
 		} else if (efi_guidcmp(config_tables[i].guid, SAL_SYSTEM_TABLE_GUID) == 0) {
-			efi.sal_systab = __va(config_tables[i].table);
+			efi.sal_systab = config_tables[i].table;
 			printk(" SALsystab=0x%lx", config_tables[i].table);
 		} else if (efi_guidcmp(config_tables[i].guid, HCDP_TABLE_GUID) == 0) {
-			efi.hcdp = __va(config_tables[i].table);
+			efi.hcdp = config_tables[i].table;
 			printk(" HCDP=0x%lx", config_tables[i].table);
 		}
 	}
Index: work-mm3/drivers/firmware/efivars.c
===================================================================
--- work-mm3.orig/drivers/firmware/efivars.c	2006-01-19 11:26:17.000000000 -0700
+++ work-mm3/drivers/firmware/efivars.c	2006-01-19 11:37:23.000000000 -0700
@@ -568,20 +568,20 @@
 	if (!entry || !buf)
 		return -EINVAL;
 
-	if (efi.mps)
-		str += sprintf(str, "MPS=0x%lx\n", __pa(efi.mps));
-	if (efi.acpi20)
-		str += sprintf(str, "ACPI20=0x%lx\n", __pa(efi.acpi20));
-	if (efi.acpi)
-		str += sprintf(str, "ACPI=0x%lx\n", __pa(efi.acpi));
-	if (efi.smbios)
-		str += sprintf(str, "SMBIOS=0x%lx\n", __pa(efi.smbios));
-	if (efi.hcdp)
-		str += sprintf(str, "HCDP=0x%lx\n", __pa(efi.hcdp));
-	if (efi.boot_info)
-		str += sprintf(str, "BOOTINFO=0x%lx\n", __pa(efi.boot_info));
-	if (efi.uga)
-		str += sprintf(str, "UGA=0x%lx\n", __pa(efi.uga));
+	if (efi.mps != EFI_INVALID_TABLE_ADDR)
+		str += sprintf(str, "MPS=0x%lx\n", efi.mps);
+	if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
+		str += sprintf(str, "ACPI20=0x%lx\n", efi.acpi20);
+	if (efi.acpi != EFI_INVALID_TABLE_ADDR)
+		str += sprintf(str, "ACPI=0x%lx\n", efi.acpi);
+	if (efi.smbios != EFI_INVALID_TABLE_ADDR)
+		str += sprintf(str, "SMBIOS=0x%lx\n", efi.smbios);
+	if (efi.hcdp != EFI_INVALID_TABLE_ADDR)
+		str += sprintf(str, "HCDP=0x%lx\n", efi.hcdp);
+	if (efi.boot_info != EFI_INVALID_TABLE_ADDR)
+		str += sprintf(str, "BOOTINFO=0x%lx\n", efi.boot_info);
+	if (efi.uga != EFI_INVALID_TABLE_ADDR)
+		str += sprintf(str, "UGA=0x%lx\n", efi.uga);
 
 	return str - buf;
 }
Index: work-mm3/include/linux/efi.h
===================================================================
--- work-mm3.orig/include/linux/efi.h	2006-01-19 11:28:43.000000000 -0700
+++ work-mm3/include/linux/efi.h	2006-01-19 11:37:23.000000000 -0700
@@ -240,19 +240,21 @@
 	unsigned long desc_size;
 };
 
+#define EFI_INVALID_TABLE_ADDR		(~0UL)
+
 /*
  * All runtime access to EFI goes through this structure:
  */
 extern struct efi {
 	efi_system_table_t *systab;	/* EFI system table */
-	void *mps;			/* MPS table */
-	void *acpi;			/* ACPI table  (IA64 ext 0.71) */
-	void *acpi20;			/* ACPI table  (ACPI 2.0) */
-	void *smbios;			/* SM BIOS table */
-	void *sal_systab;		/* SAL system table */
-	void *boot_info;		/* boot info table */
-	void *hcdp;			/* HCDP table */
-	void *uga;			/* UGA table */
+	unsigned long mps;		/* MPS table */
+	unsigned long acpi;		/* ACPI table  (IA64 ext 0.71) */
+	unsigned long acpi20;		/* ACPI table  (ACPI 2.0) */
+	unsigned long smbios;		/* SM BIOS table */
+	unsigned long sal_systab;	/* SAL system table */
+	unsigned long boot_info;	/* boot info table */
+	unsigned long hcdp;		/* HCDP table */
+	unsigned long uga;		/* UGA table */
 	efi_get_time_t *get_time;
 	efi_set_time_t *set_time;
 	efi_get_wakeup_time_t *get_wakeup_time;
Index: work-mm3/arch/i386/kernel/acpi/boot.c
===================================================================
--- work-mm3.orig/arch/i386/kernel/acpi/boot.c	2006-01-19 11:26:17.000000000 -0700
+++ work-mm3/arch/i386/kernel/acpi/boot.c	2006-01-19 11:37:23.000000000 -0700
@@ -659,10 +659,10 @@
 	unsigned long rsdp_phys = 0;
 
 	if (efi_enabled) {
-		if (efi.acpi20)
-			return __pa(efi.acpi20);
-		else if (efi.acpi)
-			return __pa(efi.acpi);
+		if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
+			return efi.acpi20;
+		else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
+			return efi.acpi;
 	}
 	/*
 	 * Scan memory looking for the RSDP signature. First search EBDA (low
Index: work-mm3/arch/ia64/kernel/acpi.c
===================================================================
--- work-mm3.orig/arch/ia64/kernel/acpi.c	2006-01-19 11:26:17.000000000 -0700
+++ work-mm3/arch/ia64/kernel/acpi.c	2006-01-19 11:37:23.000000000 -0700
@@ -618,9 +618,9 @@
 {
 	unsigned long rsdp_phys = 0;
 
-	if (efi.acpi20)
-		rsdp_phys = __pa(efi.acpi20);
-	else if (efi.acpi)
+	if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
+		rsdp_phys = efi.acpi20;
+	else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
 		printk(KERN_WARNING PREFIX
 		       "v1.0/r0.71 tables no longer supported\n");
 	return rsdp_phys;
Index: work-mm3/drivers/acpi/osl.c
===================================================================
--- work-mm3.orig/drivers/acpi/osl.c	2006-01-19 11:26:18.000000000 -0700
+++ work-mm3/drivers/acpi/osl.c	2006-01-19 11:37:23.000000000 -0700
@@ -156,12 +156,10 @@
 {
 	if (efi_enabled) {
 		addr->pointer_type = ACPI_PHYSICAL_POINTER;
-		if (efi.acpi20)
-			addr->pointer.physical =
-			    (acpi_physical_address) virt_to_phys(efi.acpi20);
-		else if (efi.acpi)
-			addr->pointer.physical =
-			    (acpi_physical_address) virt_to_phys(efi.acpi);
+		if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
+			addr->pointer.physical = efi.acpi20;
+		else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
+			addr->pointer.physical = efi.acpi;
 		else {
 			printk(KERN_ERR PREFIX
 			       "System description tables not found\n");
Index: work-mm3/arch/i386/kernel/dmi_scan.c
===================================================================
--- work-mm3.orig/arch/i386/kernel/dmi_scan.c	2006-01-19 11:37:04.000000000 -0700
+++ work-mm3/arch/i386/kernel/dmi_scan.c	2006-01-19 11:37:58.000000000 -0700
@@ -216,14 +216,14 @@
 	int rc;
 
 	if (efi_enabled) {
-		if (!efi.smbios)
+		if (efi.smbios == EFI_INVALID_TABLE_ADDR)
 			goto out;
 
                /* This is called as a core_initcall() because it isn't
                 * needed during early boot.  This also means we can
                 * iounmap the space when we're done with it.
 		*/
-		p = ioremap((unsigned long)efi.smbios, 32);
+		p = ioremap(efi.smbios, 32);
 		if (p == NULL)
 			goto out;
 
Index: work-mm3/arch/ia64/kernel/setup.c
===================================================================
--- work-mm3.orig/arch/ia64/kernel/setup.c	2006-01-19 11:26:17.000000000 -0700
+++ work-mm3/arch/ia64/kernel/setup.c	2006-01-19 11:37:23.000000000 -0700
@@ -444,7 +444,7 @@
 	find_memory();
 
 	/* process SAL system table: */
-	ia64_sal_init(efi.sal_systab);
+	ia64_sal_init(__va(efi.sal_systab));
 
 #ifdef CONFIG_SMP
 	cpu_physical_id(0) = hard_smp_processor_id();
Index: work-mm3/arch/ia64/sn/kernel/setup.c
===================================================================
--- work-mm3.orig/arch/ia64/sn/kernel/setup.c	2006-01-19 11:26:17.000000000 -0700
+++ work-mm3/arch/ia64/sn/kernel/setup.c	2006-01-19 11:37:23.000000000 -0700
@@ -339,10 +339,11 @@
 	struct pcdp_interface_pci if_pci;
 	extern struct efi efi;
 
-	pcdp = efi.hcdp;
-	if (! pcdp)
+	if (efi.hcdp == EFI_INVALID_TABLE_ADDR)
 		return;		/* no hcdp/pcdp table */
 
+	pcdp = __va(efi.hcdp);
+
 	if (pcdp->rev < 3)
 		return;		/* only support PCDP (rev >= 3) */
 
Index: work-mm3/drivers/firmware/pcdp.c
===================================================================
--- work-mm3.orig/drivers/firmware/pcdp.c	2006-01-19 11:26:17.000000000 -0700
+++ work-mm3/drivers/firmware/pcdp.c	2006-01-19 11:37:23.000000000 -0700
@@ -89,19 +89,20 @@
 	struct pcdp_uart *uart;
 	struct pcdp_device *dev, *end;
 	int i, serial = 0;
+	int rc = -ENODEV;
 
-	pcdp = efi.hcdp;
-	if (!pcdp)
+	if (efi.hcdp == EFI_INVALID_TABLE_ADDR)
 		return -ENODEV;
 
-	printk(KERN_INFO "PCDP: v%d at 0x%lx\n", pcdp->rev, __pa(pcdp));
+	pcdp = ioremap(efi.hcdp, 4096);
+	printk(KERN_INFO "PCDP: v%d at 0x%lx\n", pcdp->rev, efi.hcdp);
 
 	if (strstr(cmdline, "console=hcdp")) {
 		if (pcdp->rev < 3)
 			serial = 1;
 	} else if (strstr(cmdline, "console=")) {
 		printk(KERN_INFO "Explicit \"console=\"; ignoring PCDP\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	if (pcdp->rev < 3 && efi_uart_console_only())
@@ -110,7 +111,8 @@
 	for (i = 0, uart = pcdp->uart; i < pcdp->num_uarts; i++, uart++) {
 		if (uart->flags & PCDP_UART_PRIMARY_CONSOLE || serial) {
 			if (uart->type == PCDP_CONSOLE_UART) {
-				return setup_serial_console(uart);
+				rc = setup_serial_console(uart);
+				goto out;
 			}
 		}
 	}
@@ -121,10 +123,13 @@
 	     dev = (struct pcdp_device *) ((u8 *) dev + dev->length)) {
 		if (dev->flags & PCDP_PRIMARY_CONSOLE) {
 			if (dev->type == PCDP_CONSOLE_VGA) {
-				return setup_vga_console(dev);
+				rc = setup_vga_console(dev);
+				goto out;
 			}
 		}
 	}
 
-	return -ENODEV;
+out:
+	iounmap(pcdp);
+	return rc;
 }
Index: work-mm3/include/asm-ia64/sn/sn_sal.h
===================================================================
--- work-mm3.orig/include/asm-ia64/sn/sn_sal.h	2006-01-19 11:26:17.000000000 -0700
+++ work-mm3/include/asm-ia64/sn/sn_sal.h	2006-01-19 11:37:23.000000000 -0700
@@ -158,7 +158,7 @@
 static inline u32
 sn_sal_rev(void)
 {
-	struct ia64_sal_systab *systab = efi.sal_systab;
+	struct ia64_sal_systab *systab = __va(efi.sal_systab);
 
 	return (u32)(systab->sal_b_rev_major << 8 | systab->sal_b_rev_minor);
 }
