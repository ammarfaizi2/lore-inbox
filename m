Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbUEFKli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbUEFKli (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 06:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbUEFKja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 06:39:30 -0400
Received: from mail.donpac.ru ([80.254.111.2]:36587 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S261992AbUEFKcb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 06:32:31 -0400
Subject: [PATCH 6/6] Port PIIX4 I2C driver to new DMI probing
In-Reply-To: <10838395553579@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 6 May 2004 14:32:38 +0400
Message-Id: <1083839558750@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN -X /usr/share/dontdiff linux-2.6.6-rc3.vanlila/arch/i386/kernel/dmi_scan.c linux-2.6.6-rc3/arch/i386/kernel/dmi_scan.c
--- linux-2.6.6-rc3.vanlila/arch/i386/kernel/dmi_scan.c	2004-05-05 22:27:49.000000000 +0400
+++ linux-2.6.6-rc3/arch/i386/kernel/dmi_scan.c	2004-05-05 22:28:57.000000000 +0400
@@ -15,7 +15,6 @@
 unsigned long dmi_broken;
 EXPORT_SYMBOL(dmi_broken);
 
-int is_unsafe_smbus;
 int es7000_plat = 0;
 
 struct dmi_header
@@ -221,19 +220,6 @@
 	return 0;
 }
 
-/* 
- * Don't access SMBus on IBM systems which get corrupted eeproms 
- */
-
-static __init int disable_smbus(struct dmi_system_id *d)
-{   
-	if (is_unsafe_smbus == 0) {
-		is_unsafe_smbus = 1;
-		printk(KERN_INFO "%s machine detected. Disabling SMBus accesses.\n", d->ident);
-	}
-	return 0;
-}
-
 /*
  * The Intel 440GX hall of shame. 
  *
@@ -476,14 +462,6 @@
 #endif
 
 	/*
-	 *	SMBus / sensors settings
-	 */
-	 
-	{ disable_smbus, "IBM", {
-			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
-			} },
-
-	/*
 	 * Some Athlon laptops have really fucked PST tables.
 	 * A BIOS update is all that can save them.
 	 * Mention this, and disable cpufreq.
@@ -711,5 +689,3 @@
 	else
 		printk(KERN_INFO "DMI not present.\n");
 }
-
-EXPORT_SYMBOL(is_unsafe_smbus);
diff -urN -X /usr/share/dontdiff linux-2.6.6-rc3.vanlila/drivers/i2c/busses/i2c-piix4.c linux-2.6.6-rc3/drivers/i2c/busses/i2c-piix4.c
--- linux-2.6.6-rc3.vanlila/drivers/i2c/busses/i2c-piix4.c	2004-05-05 20:15:38.000000000 +0400
+++ linux-2.6.6-rc3/drivers/i2c/busses/i2c-piix4.c	2004-05-05 22:32:23.000000000 +0400
@@ -40,6 +40,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/apm_bios.h>
+#include <linux/dmi.h>
 #include <asm/io.h>
 
 
@@ -114,18 +115,13 @@
 static unsigned short piix4_smba = 0;
 static struct i2c_adapter piix4_adapter;
 
-/*
- * Get DMI information.
- */
-static int __devinit ibm_dmi_probe(void)
-{
-#ifdef CONFIG_X86
-	extern int is_unsafe_smbus;
-	return is_unsafe_smbus;
-#else
-	return 0;
-#endif
-}
+static struct dmi_system_id __devinitdata piix4_dmi_table[] = {
+	{
+		.ident		= "IBM",
+		.matches	= { DMI_MATCH(DMI_SYS_VENDOR, "IBM"), },
+	},
+	{ },
+};
 
 static int __devinit piix4_setup(struct pci_dev *PIIX4_dev,
 				const struct pci_device_id *id)
@@ -138,7 +134,8 @@
 
 	dev_info(&PIIX4_dev->dev, "Found %s device\n", pci_name(PIIX4_dev));
 
-	if(ibm_dmi_probe()) {
+	/* Don't access SMBus on IBM systems which get corrupted eeproms */
+	if (dmi_check_system(piix4_dmi_table)) {
 		dev_err(&PIIX4_dev->dev, "IBM Laptop detected; this module "
 			"may corrupt your serial eeprom! Refusing to load "
 			"module!\n");

