Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbUE1MCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUE1MCY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUE1MAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:00:48 -0400
Received: from mail.donpac.ru ([80.254.111.2]:39860 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S262328AbUE1Lzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 07:55:37 -0400
Subject: [PATCH 3/13] 2.6.7-rc1-mm1, Port sonypi driver to new DMI probing
In-Reply-To: <10857453302190@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 28 May 2004 15:55:33 +0400
Message-Id: <1085745333820@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Wed Apr 28 23:29:45 2004
+++ linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c	Wed Apr 28 23:30:37 2004
@@ -16,7 +16,6 @@
 unsigned long dmi_broken;
 EXPORT_SYMBOL(dmi_broken);
 
-int is_sony_vaio_laptop;
 int is_unsafe_smbus;
 int es7000_plat = 0;
 
@@ -344,24 +343,6 @@ static __init int broken_apm_power(struc
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
  * HP Proliant 8500 systems can't use i8042 in mux mode,
  * or they instantly reboot.
  */
@@ -653,10 +634,6 @@ static __initdata struct dmi_system_id d
 	{ apm_likes_to_melt, "AMI Bios", { /* APM idle hangs */
 			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
 			DMI_MATCH(DMI_BIOS_VERSION, "0AASNP05"), 
-			} },
-	{ sony_vaio_laptop, "Sony Vaio", { /* This is a Sony Vaio laptop */
-			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PCG-"),
 			} },
 	{ swab_apm_power_in_minutes, "Sony VAIO", { /* Handle problems with APM on Sony Vaio PCG-N505X(DE) */
 			DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/i386_ksyms.c linux-2.6.7-rc1-mm1/arch/i386/kernel/i386_ksyms.c
--- linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/i386_ksyms.c	Wed Apr 28 22:56:08 2004
+++ linux-2.6.7-rc1-mm1/arch/i386/kernel/i386_ksyms.c	Wed Apr 28 23:29:56 2004
@@ -187,9 +187,6 @@ EXPORT_SYMBOL_NOVERS(memcmp);
 EXPORT_SYMBOL(atomic_dec_and_lock);
 #endif
 
-extern int is_sony_vaio_laptop;
-EXPORT_SYMBOL(is_sony_vaio_laptop);
-
 EXPORT_SYMBOL(__PAGE_KERNEL);
 
 #ifdef CONFIG_HIGHMEM
diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/drivers/char/sonypi.c linux-2.6.7-rc1-mm1/drivers/char/sonypi.c
--- linux-2.6.7-rc1-mm1.vanilla/drivers/char/sonypi.c	Wed Apr 28 22:55:42 2004
+++ linux-2.6.7-rc1-mm1/drivers/char/sonypi.c	Wed Apr 28 23:29:56 2004
@@ -43,6 +43,7 @@
 #include <linux/delay.h>
 #include <linux/wait.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -818,10 +819,21 @@ static void __devexit sonypi_remove(void
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
diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/include/asm-i386/system.h linux-2.6.7-rc1-mm1/include/asm-i386/system.h
--- linux-2.6.7-rc1-mm1.vanilla/include/asm-i386/system.h	Wed Apr 28 22:56:51 2004
+++ linux-2.6.7-rc1-mm1/include/asm-i386/system.h	Wed Apr 28 23:32:33 2004
@@ -466,7 +466,6 @@ void disable_hlt(void);
 void enable_hlt(void);
 
 extern unsigned long dmi_broken;
-extern int is_sony_vaio_laptop;
 extern int es7000_plat;
 
 #define BROKEN_ACPI_Sx		0x0001

