Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbUE1MLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUE1MLR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbUE1MJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:09:26 -0400
Received: from mail.donpac.ru ([80.254.111.2]:61620 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S262503AbUE1L4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 07:56:07 -0400
Subject: [PATCH 11/13] 2.6.7-rc1-mm1, Port local APIC quirks to new DMI probing
In-Reply-To: <10857453581556@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 28 May 2004 15:56:02 +0400
Message-Id: <10857453621318@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/apic.c linux-2.6.7-rc1-mm1/arch/i386/kernel/apic.c
--- linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/apic.c	Wed Apr 28 22:56:08 2004
+++ linux-2.6.7-rc1-mm1/arch/i386/kernel/apic.c	Thu Apr 29 00:13:49 2004
@@ -26,6 +26,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
+#include <linux/dmi.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -624,11 +625,66 @@ static int __init lapic_enable(char *str
 }
 __setup("lapic", lapic_enable);
 
+/*
+ * Some machines, usually laptops, can't handle an enabled local APIC.
+ * The symptoms include hangs or reboots when suspending or resuming,
+ * attaching or detaching the power cord, or entering BIOS setup screens
+ * through magic key sequences.
+ */
+static int __init local_apic_kills_bios(struct dmi_system_id *d)
+{
+	if (enable_local_apic == 0) {
+		enable_local_apic = -1;
+		printk(KERN_WARNING "%s with broken BIOS detected. "
+		       "Refusing to enable the local APIC.\n",
+		       d->ident);
+	}
+	return 0;
+}
+
+static struct dmi_system_id __initdata apic_dmi_table[] = {
+	{
+		.callback = local_apic_kills_bios,
+		.ident = "Dell Inspiron",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron"),
+		},
+	},
+	{
+		.callback = local_apic_kills_bios,
+		.ident = "Dell Latitude",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude"),
+		},
+	},
+	{
+		.callback = local_apic_kills_bios,
+		.ident = "IBM Thinkpad T20",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
+			DMI_MATCH(DMI_BOARD_NAME, "264741U"),
+		},
+	},
+	{
+		.callback = local_apic_kills_bios, 
+		.ident = "ASUS L3C",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "P4_L3C"),
+		},
+	},
+	{ }
+};
+
 static int __init detect_init_APIC (void)
 {
 	u32 h, l, features;
 	extern void get_cpu_vendor(struct cpuinfo_x86*);
 
+	dmi_check_system(apic_dmi_table);
+
 	/* Disabled by DMI scan or kernel option? */
 	if (enable_local_apic < 0)
 		return -1;
@@ -1159,6 +1215,8 @@ asmlinkage void smp_error_interrupt(void
  */
 int __init APIC_init_uniprocessor (void)
 {
+	dmi_check_system(apic_dmi_table);
+
 	if (enable_local_apic < 0)
 		clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
 
diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Thu Apr 29 00:13:36 2004
+++ linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c	Thu Apr 29 00:14:26 2004
@@ -156,26 +156,6 @@ static void __init dmi_save_ident(struct
 }
 
 /*
- * Some machines, usually laptops, can't handle an enabled local APIC.
- * The symptoms include hangs or reboots when suspending or resuming,
- * attaching or detaching the power cord, or entering BIOS setup screens
- * through magic key sequences.
- */
-static int __init local_apic_kills_bios(struct dmi_system_id *d)
-{
-#ifdef CONFIG_X86_LOCAL_APIC
-	extern int enable_local_apic;
-	if (enable_local_apic == 0) {
-		enable_local_apic = -1;
-		printk(KERN_WARNING "%s with broken BIOS detected. "
-		       "Refusing to enable the local APIC.\n",
-		       d->ident);
-	}
-#endif
-	return 0;
-}
-
-/*
  * HP Proliant 8500 systems can't use i8042 in mux mode,
  * or they instantly reboot.
  */
@@ -261,28 +241,6 @@ static __init int disable_acpi_pci(struc
  */
  
 static __initdata struct dmi_system_id dmi_blacklist[]={
-
-	/* Machines which have problems handling enabled local APICs */
-
-	{ local_apic_kills_bios, "Dell Inspiron", {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron"),
-			} },
-
-	{ local_apic_kills_bios, "Dell Latitude", {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude"),
-			} },
-
-	{ local_apic_kills_bios, "IBM Thinkpad T20", {
-			DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
-			DMI_MATCH(DMI_BOARD_NAME, "264741U"),
-			} },
-
-	{ local_apic_kills_bios, "ASUS L3C", {
-			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "P4_L3C"),
-			} },
 
 	{ broken_acpi_Sx, "ASUS K7V-RM", {		/* Bad ACPI Sx table */
 			DMI_MATCH(DMI_BIOS_VERSION,"ASUS K7V-RM ACPI BIOS Revision 1003A"),

