Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUE1MG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUE1MG6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUE1MEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:04:47 -0400
Received: from mail.donpac.ru ([80.254.111.2]:47284 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S262451AbUE1Lzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 07:55:49 -0400
Subject: [PATCH 6/13] 2.6.7-rc1-mm1, Port PIIX4 I2C driver to new DMI probing
In-Reply-To: <10857453413454@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 28 May 2004 15:55:45 +0400
Message-Id: <10857453453701@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make PIIX4 I2C use dmi_check_system() function and remove
is_unsafe_smbus global variable.

diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Wed Apr 28 23:56:10 2004
+++ linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c	Wed Apr 28 23:56:17 2004
@@ -15,7 +15,6 @@
 unsigned long dmi_broken;
 EXPORT_SYMBOL(dmi_broken);
 
-int is_unsafe_smbus;
 int es7000_plat = 0;
 
 struct dmi_header
@@ -221,19 +220,6 @@ static int __init local_apic_kills_bios(
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
  * HP Proliant 8500 systems can't use i8042 in mux mode,
  * or they instantly reboot.
@@ -451,14 +437,6 @@ static __initdata struct dmi_system_id d
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
@@ -775,5 +753,3 @@ void __init dmi_scan_machine(void)
 	else
 		printk(KERN_INFO "DMI not present.\n");
 }
-
-EXPORT_SYMBOL(is_unsafe_smbus);
diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/drivers/i2c/busses/i2c-piix4.c linux-2.6.7-rc1-mm1/drivers/i2c/busses/i2c-piix4.c
--- linux-2.6.7-rc1-mm1.vanilla/drivers/i2c/busses/i2c-piix4.c	Wed Apr 28 22:55:24 2004
+++ linux-2.6.7-rc1-mm1/drivers/i2c/busses/i2c-piix4.c	Wed Apr 28 23:56:17 2004
@@ -40,6 +40,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/apm_bios.h>
+#include <linux/dmi.h>
 #include <asm/io.h>
 
 
@@ -114,18 +115,13 @@ static int piix4_transaction(void);
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
+		.ident = "IBM",
+		.matches = { DMI_MATCH(DMI_SYS_VENDOR, "IBM"), },
+	},
+	{ },
+};
 
 static int __devinit piix4_setup(struct pci_dev *PIIX4_dev,
 				const struct pci_device_id *id)
@@ -138,7 +134,8 @@ static int __devinit piix4_setup(struct 
 
 	dev_info(&PIIX4_dev->dev, "Found %s device\n", pci_name(PIIX4_dev));
 
-	if(ibm_dmi_probe()) {
+	/* Don't access SMBus on IBM systems which get corrupted eeproms */
+	if (dmi_check_system(piix4_dmi_table)) {
 		dev_err(&PIIX4_dev->dev, "IBM Laptop detected; this module "
 			"may corrupt your serial eeprom! Refusing to load "
 			"module!\n");

