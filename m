Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263167AbUGBLwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUGBLwV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 07:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUGBLwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 07:52:21 -0400
Received: from mail.donpac.ru ([80.254.111.2]:38115 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S263167AbUGBLwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 07:52:13 -0400
Subject: [PATCH 0/0] 2.6.7-mm5, port reboot workarounds to new DMI probing
In-Reply-To: 
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 2 Jul 2004 15:52:09 +0400
Message-Id: <10887691294047@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch moves reboot related workarounds out of dmi_scan.c
Please consider applying.

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 arch/i386/kernel/dmi_scan.c |   62 ----------------------------------
 arch/i386/kernel/reboot.c   |   78 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 61 deletions(-)

diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm5.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-mm5/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-mm5.vanilla/arch/i386/kernel/dmi_scan.c	Thu Jul  1 20:58:01 2004
+++ linux-2.6.7-mm5/arch/i386/kernel/dmi_scan.c	Thu Jul  1 21:09:47 2004
@@ -164,51 +164,6 @@ static void __init dmi_save_ident(struct
 #define NO_MATCH	{ DMI_NONE, NULL}
 #define MATCH		DMI_MATCH
 
-/* 
- * Reboot options and system auto-detection code provided by
- * Dell Inc. so their systems "just work". :-)
- */
-
-/* 
- * Some machines require the "reboot=b"  commandline option, this quirk makes that automatic.
- */
-static __init int set_bios_reboot(struct dmi_blacklist *d)
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
-static __init int set_smp_reboot(struct dmi_blacklist *d)
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
-static __init int set_smp_bios_reboot(struct dmi_blacklist *d)
-{
-	set_smp_reboot(d);
-	set_bios_reboot(d);
-	return 0;
-}
-
 /*
  * Some machines, usually laptops, can't handle an enabled local APIC.
  * The symptoms include hangs or reboots when suspending or resuming,
@@ -340,22 +295,7 @@ static __init int disable_acpi_pci(struc
  */
  
 static __initdata struct dmi_blacklist dmi_blacklist[]={
-	{ set_smp_bios_reboot, "Dell PowerEdge 1300", {	/* Handle problems with rebooting on Dell 1300's */
-			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "PowerEdge 1300/"),
-			NO_MATCH, NO_MATCH
-			} },
-	{ set_bios_reboot, "Dell PowerEdge 300", {	/* Handle problems with rebooting on Dell 300's */
-			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "PowerEdge 300/"),
-			NO_MATCH, NO_MATCH
-			} },
-	{ set_bios_reboot, "Dell PowerEdge 2400", {  /* Handle problems with rebooting on Dell 2400's */
-			MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_PRODUCT_NAME, "PowerEdge 2400"),
-			NO_MATCH, NO_MATCH
-			} },
-			
+
 	/* Machines which have problems handling enabled local APICs */
 
 	{ local_apic_kills_bios, "Dell Inspiron", {
diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm5.vanilla/arch/i386/kernel/reboot.c linux-2.6.7-mm5/arch/i386/kernel/reboot.c
--- linux-2.6.7-mm5.vanilla/arch/i386/kernel/reboot.c	Mon May 10 06:32:27 2004
+++ linux-2.6.7-mm5/arch/i386/kernel/reboot.c	Thu Jul  1 21:03:59 2004
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

