Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbUEFKhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUEFKhl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 06:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUEFKfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 06:35:40 -0400
Received: from mail.donpac.ru ([80.254.111.2]:29931 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S261989AbUEFKcV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 06:32:21 -0400
Subject: [PATCH 3/6] Port sonypi driver to new DMI probing
In-Reply-To: <10838395453935@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 6 May 2004 14:32:28 +0400
Message-Id: <10838395481732@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN -X /usr/share/dontdiff linux-2.6.6-rc3.vanlila/arch/i386/kernel/dmi_scan.c linux-2.6.6-rc3/arch/i386/kernel/dmi_scan.c
--- linux-2.6.6-rc3.vanlila/arch/i386/kernel/dmi_scan.c	2004-05-05 21:59:53.000000000 +0400
+++ linux-2.6.6-rc3/arch/i386/kernel/dmi_scan.c	2004-05-05 22:00:57.000000000 +0400
@@ -16,7 +16,6 @@
 unsigned long dmi_broken;
 EXPORT_SYMBOL(dmi_broken);
 
-int is_sony_vaio_laptop;
 int is_unsafe_smbus;
 int es7000_plat = 0;
 
@@ -344,24 +343,6 @@
 }		
 
 /*
- * Check for a Sony Vaio system
- *
- * On a Sony system we want to enable the use of the sonypi
- * driver for Sony-specific goodies like the camera and jogdial.
- * We also want to avoid using certain functions of the PnP BIOS.
- */
-
-static __init int sony_vaio_laptop(struct dmi_system_id *d)
-{
-	if (is_sony_vaio_laptop == 0)
-	{
-		is_sony_vaio_laptop = 1;
-		printk(KERN_INFO "%s laptop detected.\n", d->ident);
-	}
-	return 0;
-}
-
-/*
  * This bios swaps the APM minute reporting bytes over (Many sony laptops
  * have this problem).
  */
@@ -641,10 +622,6 @@
 			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
 			DMI_MATCH(DMI_BIOS_VERSION, "0AASNP05"), 
 			} },
-	{ sony_vaio_laptop, "Sony Vaio", { /* This is a Sony Vaio laptop */
-			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PCG-"),
-			} },
 	{ swab_apm_power_in_minutes, "Sony VAIO", { /* Handle problems with APM on Sony Vaio PCG-N505X(DE) */
 			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
 			DMI_MATCH(DMI_BIOS_VERSION, "R0206H"),
diff -urN -X /usr/share/dontdiff linux-2.6.6-rc3.vanlila/arch/i386/kernel/i386_ksyms.c linux-2.6.6-rc3/arch/i386/kernel/i386_ksyms.c
--- linux-2.6.6-rc3.vanlila/arch/i386/kernel/i386_ksyms.c	2004-05-05 20:15:29.000000000 +0400
+++ linux-2.6.6-rc3/arch/i386/kernel/i386_ksyms.c	2004-05-05 22:00:57.000000000 +0400
@@ -188,9 +188,6 @@
 EXPORT_SYMBOL(atomic_dec_and_lock);
 #endif
 
-extern int is_sony_vaio_laptop;
-EXPORT_SYMBOL(is_sony_vaio_laptop);
-
 EXPORT_SYMBOL(__PAGE_KERNEL);
 
 #ifdef CONFIG_HIGHMEM
diff -urN -X /usr/share/dontdiff linux-2.6.6-rc3.vanlila/drivers/char/sonypi.c linux-2.6.6-rc3/drivers/char/sonypi.c
--- linux-2.6.6-rc3.vanlila/drivers/char/sonypi.c	2004-05-05 20:15:37.000000000 +0400
+++ linux-2.6.6-rc3/drivers/char/sonypi.c	2004-05-05 22:01:50.000000000 +0400
@@ -43,6 +43,7 @@
 #include <linux/delay.h>
 #include <linux/wait.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -818,10 +819,21 @@
 	printk(KERN_INFO "sonypi: removed.\n");
 }
 
-static int __init sonypi_init_module(void) {
-	struct pci_dev *pcidev = NULL;
+static struct dmi_system_id __initdata sonypi_dmi_table[] = {
+	{
+		.ident = "Sony Vaio",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PCG-"),
+		},
+	},
+	{ }
+};
 
-	if (is_sony_vaio_laptop) {
+static int __init sonypi_init_module(void)
+{
+	struct pci_dev *pcidev = NULL;
+	if (dmi_check_system(sonypi_dmi_table)) {
 		pcidev = pci_find_device(PCI_VENDOR_ID_INTEL, 
 					 PCI_DEVICE_ID_INTEL_82371AB_3, 
 					 NULL);

