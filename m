Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUE1MPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUE1MPQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUE1MIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:08:02 -0400
Received: from mail.donpac.ru ([80.254.111.2]:54964 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S262488AbUE1L4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 07:56:00 -0400
Subject: [PATCH 9/13] 2.6.7-rc1-mm1, Port reboot related quirks to new DMI probing
In-Reply-To: <1085745352794@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 28 May 2004 15:55:55 +0400
Message-Id: <1085745355529@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Thu Apr 29 00:08:50 2004
+++ linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c	Thu Apr 29 00:09:08 2004
@@ -155,51 +155,6 @@ static void __init dmi_save_ident(struct
 		printk(KERN_ERR "dmi_save_ident: out of memory.\n");
 }
 
-/* 
- * Reboot options and system auto-detection code provided by
- * Dell Inc. so their systems "just work". :-)
- */
-
-/* 
- * Some machines require the "reboot=b"  commandline option, this quirk makes that automatic.
- */
-static __init int set_bios_reboot(struct dmi_system_id *d)
-{
-	extern int reboot_thru_bios;
-	if (reboot_thru_bios == 0)
-	{
-		reboot_thru_bios = 1;
-		printk(KERN_INFO "%s series board detected. Selecting BIOS-method for reboots.\n", d->ident);
-	}
-	return 0;
-}
-
-/*
- * Some machines require the "reboot=s"  commandline option, this quirk makes that automatic.
- */
-static __init int set_smp_reboot(struct dmi_system_id *d)
-{
-#ifdef CONFIG_SMP
-	extern int reboot_smp;
-	if (reboot_smp == 0)
-	{
-		reboot_smp = 1;
-		printk(KERN_INFO "%s series board detected. Selecting SMP-method for reboots.\n", d->ident);
-	}
-#endif
-	return 0;
-}
-
-/*
- * Some machines require the "reboot=b,s"  commandline option, this quirk makes that automatic.
- */
-static __init int set_smp_bios_reboot(struct dmi_system_id *d)
-{
-	set_smp_reboot(d);
-	set_bios_reboot(d);
-	return 0;
-}
-
 /*
  * Some machines, usually laptops, can't handle an enabled local APIC.
  * The symptoms include hangs or reboots when suspending or resuming,
@@ -316,19 +271,7 @@ static __init int disable_acpi_pci(struc
  */
  
 static __initdata struct dmi_system_id dmi_blacklist[]={
-	{ set_smp_bios_reboot, "Dell PowerEdge 1300", {	/* Handle problems with rebooting on Dell 1300's */
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 1300/"),
-			} },
-	{ set_bios_reboot, "Dell PowerEdge 300", {	/* Handle problems with rebooting on Dell 300's */
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 300/"),
-			} },
-	{ set_bios_reboot, "Dell PowerEdge 2400", {  /* Handle problems with rebooting on Dell 2400's */
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 2400"),
-			} },
-			
+
 	/* Machines which have problems handling enabled local APICs */
 
 	{ local_apic_kills_bios, "Dell Inspiron", {
diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/reboot.c linux-2.6.7-rc1-mm1/arch/i386/kernel/reboot.c
--- linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/reboot.c	Wed Apr 28 22:56:07 2004
+++ linux-2.6.7-rc1-mm1/arch/i386/kernel/reboot.c	Thu Apr 29 00:09:08 2004
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/efi.h>
+#include <linux/dmi.h>
 #include <asm/uaccess.h>
 #include <asm/apic.h>
 #include "mach_reboot.h"
@@ -66,6 +67,83 @@ static int __init reboot_setup(char *str
 }
 
 __setup("reboot=", reboot_setup);
+
+/* 
+ * Reboot options and system auto-detection code provided by
+ * Dell Inc. so their systems "just work". :-)
+ */
+
+/* 
+ * Some machines require the "reboot=b"  commandline option, this quirk makes that automatic.
+ */
+static int __init set_bios_reboot(struct dmi_system_id *d)
+{
+	if (!reboot_thru_bios) {
+		reboot_thru_bios = 1;
+		printk(KERN_INFO "%s series board detected. Selecting BIOS-method for reboots.\n", d->ident);
+	}
+	return 0;
+}
+
+/*
+ * Some machines require the "reboot=s"  commandline option, this quirk makes that automatic.
+ */
+static int __init set_smp_reboot(struct dmi_system_id *d)
+{
+#ifdef CONFIG_SMP
+	if (!reboot_smp) {
+		reboot_smp = 1;
+		printk(KERN_INFO "%s series board detected. Selecting SMP-method for reboots.\n", d->ident);
+	}
+#endif
+	return 0;
+}
+
+/*
+ * Some machines require the "reboot=b,s"  commandline option, this quirk makes that automatic.
+ */
+static int __init set_smp_bios_reboot(struct dmi_system_id *d)
+{
+	set_smp_reboot(d);
+	set_bios_reboot(d);
+	return 0;
+}
+
+static struct dmi_system_id __initdata reboot_dmi_table[] = {
+	{	/* Handle problems with rebooting on Dell 1300's */
+		.callback = set_smp_bios_reboot,
+		.ident = "Dell PowerEdge 1300",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 1300/"),
+		},
+	},
+	{	/* Handle problems with rebooting on Dell 300's */
+		.callback = set_bios_reboot,
+		.ident = "Dell PowerEdge 300",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 300/"),
+		},
+	},
+	{	/* Handle problems with rebooting on Dell 2400's */
+		.callback = set_bios_reboot,
+		.ident = "Dell PowerEdge 2400",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 2400"),
+		},
+	},
+	{ }
+};
+
+static int reboot_init(void)
+{
+	dmi_check_system(reboot_dmi_table);
+	return 0;
+}
+
+core_initcall(reboot_init);
 
 /* The following code and data reboots the machine by switching to real
    mode and jumping to the BIOS reset entry point, as if the CPU has

