Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266469AbUFWMq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266469AbUFWMq3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 08:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266471AbUFWMp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 08:45:28 -0400
Received: from mail.donpac.ru ([80.254.111.2]:56201 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S266095AbUFWMor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 08:44:47 -0400
Subject: [PATCH 3/6] 2.6.7-mm1, port PIIX4 SMBUS driver to new DMI probing
In-Reply-To: <10879946781111@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 23 Jun 2004 16:44:42 +0400
Message-Id: <10879946822631@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch ports sonypi driver to new DMI probing API and removes 
is_unsafe_smbus global variable.

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 arch/i386/kernel/dmi_scan.c    |   25 -------------------------
 drivers/i2c/busses/i2c-piix4.c |   23 ++++++++++-------------
 2 files changed, 10 insertions(+), 38 deletions(-)

diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Sun May 23 22:37:40 2004
+++ linux-2.6.7-mm1/arch/i386/kernel/dmi_scan.c	Sun May 23 22:35:49 2004
@@ -19,7 +19,6 @@ EXPORT_SYMBOL(dmi_broken);
 unsigned int i8042_dmi_noloop = 0;
 EXPORT_SYMBOL(i8042_dmi_noloop);
 
-int is_unsafe_smbus;
 int es7000_plat = 0;
 
 struct dmi_header
@@ -302,19 +301,6 @@ static int __init local_apic_kills_bios(
 	return 0;
 }
 
-/* 
- * Don't access SMBus on IBM systems which get corrupted eeproms 
- */
-
-static __init int disable_smbus(struct dmi_blacklist *d)
-{   
-	if (is_unsafe_smbus == 0) {
-		is_unsafe_smbus = 1;
-		printk(KERN_INFO "%s machine detected. Disabling SMBus accesses.\n", d->ident);
-	}
-	return 0;
-}
-
 /*
  *  Check for clue free BIOS implementations who use
  *  the following QA technique
@@ -775,15 +761,6 @@ static __initdata struct dmi_blacklist d
 			} },
 
 	/*
-	 *	SMBus / sensors settings
-	 */
-	 
-	{ disable_smbus, "IBM", {
-			MATCH(DMI_SYS_VENDOR, "IBM"),
-			NO_MATCH, NO_MATCH, NO_MATCH
-			} },
-
-	/*
 	 * Some Athlon laptops have really fucked PST tables.
 	 * A BIOS update is all that can save them.
 	 * Mention this, and disable cpufreq.
@@ -1076,8 +1053,6 @@ void __init dmi_scan_machine(void)
 	else
 		printk(KERN_INFO "DMI not present.\n");
 }
-
-EXPORT_SYMBOL(is_unsafe_smbus);
 
 
 /**
diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm1.vanilla/drivers/i2c/busses/i2c-piix4.c linux-2.6.7-mm1/drivers/i2c/busses/i2c-piix4.c
--- linux-2.6.7-mm1.vanilla/drivers/i2c/busses/i2c-piix4.c	Sun May 23 22:02:22 2004
+++ linux-2.6.7-mm1/drivers/i2c/busses/i2c-piix4.c	Sun May 23 22:34:33 2004
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

