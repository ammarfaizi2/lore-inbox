Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUE1MLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUE1MLQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUE1MKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:10:12 -0400
Received: from mail.donpac.ru ([80.254.111.2]:5045 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S262547AbUE1L4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 07:56:16 -0400
Subject: [PATCH 13/13] 2.6.7-rc1-mm1, Port i8042 quirk to new DMI probing
In-Reply-To: <10857453654057@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 28 May 2004 15:56:10 +0400
Message-Id: <10857453703146@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Thu Apr 29 00:18:14 2004
+++ linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c	Thu Apr 29 00:26:56 2004
@@ -155,22 +155,6 @@ static void __init dmi_save_ident(struct
 		printk(KERN_ERR "dmi_save_ident: out of memory.\n");
 }
 
-/*
- * HP Proliant 8500 systems can't use i8042 in mux mode,
- * or they instantly reboot.
- */
-#ifdef CONFIG_SERIO_I8042
-extern unsigned int i8042_nomux;
-static __init int set_8042_nomux(struct dmi_system_id *d)
-{
-	if (i8042_nomux == 0)
-	{
-		i8042_nomux = 1;
-		printk(KERN_INFO "Disabling i8042 mux mode\n");
-	}
-	return 0;
-}
-#endif
 
 /*
  * ASUS K7V-RM has broken ACPI table defining sleep modes
@@ -243,14 +227,6 @@ static __initdata struct dmi_system_id d
 	{ reset_videomode_after_s3, "Toshiba Satellite 4030cdt", { /* Reset video mode after returning from ACPI S3 sleep */
 			DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
 			} },
-#endif
-
-#ifdef CONFIG_SERIO_I8042
-	{ set_8042_nomux, "Compaq Proliant 8500", {
-			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
-			DMI_MATCH(DMI_PRODUCT_NAME , "ProLiant"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "8500"),
-			}},
 #endif
 
 #ifdef	CONFIG_ACPI_PCI
diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/drivers/input/serio/i8042.c linux-2.6.7-rc1-mm1/drivers/input/serio/i8042.c
--- linux-2.6.7-rc1-mm1.vanilla/drivers/input/serio/i8042.c	Wed Apr 28 22:55:59 2004
+++ linux-2.6.7-rc1-mm1/drivers/input/serio/i8042.c	Thu Apr 29 00:29:19 2004
@@ -21,6 +21,7 @@
 #include <linux/sysdev.h>
 #include <linux/pm.h>
 #include <linux/serio.h>
+#include <linux/dmi.h>
 
 #include <asm/io.h>
 
@@ -32,7 +33,7 @@ static unsigned int i8042_noaux;
 module_param_named(noaux, i8042_noaux, bool, 0);
 MODULE_PARM_DESC(noaux, "Do not probe or use AUX (mouse) port.");
 
-unsigned int i8042_nomux;
+static unsigned int i8042_nomux;
 module_param_named(nomux, i8042_nomux, bool, 0);
 MODULE_PARM_DESC(nomux, "Do not check whether an active multiplexing conrtoller is present.");
 
@@ -943,11 +944,39 @@ static void __init i8042_init_mux_values
 	values->mux = index;
 }
 
+/*
+ * HP Proliant 8500 systems can't use i8042 in mux mode,
+ * or they instantly reboot.
+ */
+static int __init set_8042_nomux(struct dmi_system_id *d)
+{
+	if (!i8042_nomux) {
+		i8042_nomux = 1;
+		printk(KERN_INFO "Disabling i8042 mux mode\n");
+	}
+	return 0;
+}
+
+static struct dmi_system_id __initdata i8042_dmi_table[] = {
+	{ 
+		.callback = set_8042_nomux,
+		.ident = "Compaq Proliant 8500",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
+			DMI_MATCH(DMI_PRODUCT_NAME , "ProLiant"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "8500"),
+		},
+	},
+	{ },
+};
+
 int __init i8042_init(void)
 {
 	int i;
 
 	dbg_init();
+
+	dmi_check_system(i8042_dmi_table);
 
 	init_timer(&i8042_timer);
 	i8042_timer.function = i8042_timer_func;

