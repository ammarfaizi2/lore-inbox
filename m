Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266475AbUFWMqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266475AbUFWMqZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 08:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266469AbUFWMpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 08:45:05 -0400
Received: from mail.donpac.ru ([80.254.111.2]:52873 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S266055AbUFWMon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 08:44:43 -0400
Subject: [PATCH 2/6] 2.6.7-mm1, port sonypi driver to new DMI probing
In-Reply-To: <10879946751497@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 23 Jun 2004 16:44:38 +0400
Message-Id: <10879946781111@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch ports sonypi driver to new DMI probing API and removes
is_sony_vaio_laptop global variable.

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 arch/i386/kernel/dmi_scan.c   |   24 ------------------------
 arch/i386/kernel/i386_ksyms.c |    3 ---
 drivers/char/sonypi.c         |   18 +++++++++++++++---
 include/asm-i386/system.h     |    1 -
 4 files changed, 15 insertions(+), 31 deletions(-)

diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Sun May 23 22:13:30 2004
+++ linux-2.6.7-mm1/arch/i386/kernel/dmi_scan.c	Sun May 23 22:14:34 2004
@@ -19,7 +19,6 @@ EXPORT_SYMBOL(dmi_broken);
 unsigned int i8042_dmi_noloop = 0;
 EXPORT_SYMBOL(i8042_dmi_noloop);
 
-int is_sony_vaio_laptop;
 int is_unsafe_smbus;
 int es7000_plat = 0;
 
@@ -340,24 +339,6 @@ static __init int broken_apm_power(struc
 }		
 
 /*
- * Check for a Sony Vaio system
- *
- * On a Sony system we want to enable the use of the sonypi
- * driver for Sony-specific goodies like the camera and jogdial.
- * We also want to avoid using certain functions of the PnP BIOS.
- */
-
-static __init int sony_vaio_laptop(struct dmi_blacklist *d)
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
  * Several HP Proliant (and maybe other OSB4/ProFusion) systems
  * shouldn't use the AUX LoopBack command, or they crash or reboot.
  */
@@ -651,11 +632,6 @@ static __initdata struct dmi_blacklist d
 	{ apm_likes_to_melt, "AMI Bios", { /* APM idle hangs */
 			MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
 			MATCH(DMI_BIOS_VERSION, "0AASNP05"), 
-			NO_MATCH, NO_MATCH,
-			} },
-	{ sony_vaio_laptop, "Sony Vaio", { /* This is a Sony Vaio laptop */
-			MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "PCG-"),
 			NO_MATCH, NO_MATCH,
 			} },
 	{ swab_apm_power_in_minutes, "Sony VAIO", { /* Handle problems with APM on Sony Vaio PCG-N505X(DE) */
diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm1.vanilla/arch/i386/kernel/i386_ksyms.c linux-2.6.7-mm1/arch/i386/kernel/i386_ksyms.c
--- linux-2.6.7-mm1.vanilla/arch/i386/kernel/i386_ksyms.c	Sun May 23 22:02:03 2004
+++ linux-2.6.7-mm1/arch/i386/kernel/i386_ksyms.c	Sun May 23 22:14:34 2004
@@ -187,9 +187,6 @@ EXPORT_SYMBOL_NOVERS(memcmp);
 EXPORT_SYMBOL(atomic_dec_and_lock);
 #endif
 
-extern int is_sony_vaio_laptop;
-EXPORT_SYMBOL(is_sony_vaio_laptop);
-
 EXPORT_SYMBOL(__PAGE_KERNEL);
 
 #ifdef CONFIG_HIGHMEM
diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm1.vanilla/drivers/char/sonypi.c linux-2.6.7-mm1/drivers/char/sonypi.c
--- linux-2.6.7-mm1.vanilla/drivers/char/sonypi.c	Sun May 23 22:02:14 2004
+++ linux-2.6.7-mm1/drivers/char/sonypi.c	Sun May 23 22:14:34 2004
@@ -43,6 +43,7 @@
 #include <linux/delay.h>
 #include <linux/wait.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -820,10 +821,21 @@ static void __devexit sonypi_remove(void
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
diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm1.vanilla/include/asm-i386/system.h linux-2.6.7-mm1/include/asm-i386/system.h
--- linux-2.6.7-mm1.vanilla/include/asm-i386/system.h	Sun May 23 22:02:53 2004
+++ linux-2.6.7-mm1/include/asm-i386/system.h	Sun May 23 22:14:34 2004
@@ -466,7 +466,6 @@ void disable_hlt(void);
 void enable_hlt(void);
 
 extern unsigned long dmi_broken;
-extern int is_sony_vaio_laptop;
 extern int es7000_plat;
 
 #define BROKEN_ACPI_Sx		0x0001

