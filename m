Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbUE1MLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUE1MLQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUE1MJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:09:48 -0400
Received: from mail.donpac.ru ([80.254.111.2]:64436 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S262538AbUE1L4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 07:56:12 -0400
Subject: [PATCH 12/13] 2.6.7-rc1-mm1, Port ACPI sleep quirk to new DMI probing
In-Reply-To: <10857453621318@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 28 May 2004 15:56:05 +0400
Message-Id: <10857453654057@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Thu Apr 29 00:15:56 2004
+++ linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c	Thu Apr 29 00:16:13 2004
@@ -193,17 +193,6 @@ static __init int broken_toshiba_keyboar
 	return 0;
 }
 
-/*
- * Toshiba fails to preserve interrupts over S1
- */
-
-static __init int init_ints_after_s1(struct dmi_system_id *d)
-{
-	printk(KERN_WARNING "Toshiba with broken S1 detected.\n");
-	dmi_broken |= BROKEN_INIT_AFTER_S1;
-	return 0;
-}
-
 #ifdef CONFIG_ACPI_SLEEP
 static __init int reset_videomode_after_s3(struct dmi_system_id *d)
 {
@@ -248,9 +237,6 @@ static __initdata struct dmi_system_id d
 			} },
 
 	{ broken_toshiba_keyboard, "Toshiba Satellite 4030cdt", { /* Keyboard generates spurious repeats */
-			DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
-			} },
-	{ init_ints_after_s1, "Toshiba Satellite 4030cdt", { /* Reinitialization of 8259 is needed after S1 resume */
 			DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
 			} },
 #ifdef CONFIG_ACPI_SLEEP
diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/drivers/acpi/sleep/main.c linux-2.6.7-rc1-mm1/drivers/acpi/sleep/main.c
--- linux-2.6.7-rc1-mm1.vanilla/drivers/acpi/sleep/main.c	Wed Apr 28 22:55:43 2004
+++ linux-2.6.7-rc1-mm1/drivers/acpi/sleep/main.c	Thu Apr 29 00:16:13 2004
@@ -10,6 +10,7 @@
 
 #include <linux/delay.h>
 #include <linux/irq.h>
+#include <linux/dmi.h>
 #include <linux/device.h>
 #include <linux/suspend.h>
 #include <acpi/acpi_bus.h>
@@ -30,6 +31,8 @@ static u32 acpi_suspend_states[] = {
 	[PM_SUSPEND_DISK]	= ACPI_STATE_S4,
 };
 
+static int init_8259A_after_S1;
+
 /**
  *	acpi_pm_prepare - Do preliminary suspend work.
  *	@state:		suspend state we're entering.
@@ -138,7 +141,7 @@ static int acpi_pm_finish(u32 state)
 	/* reset firmware waking vector */
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
 
-	if (dmi_broken & BROKEN_INIT_AFTER_S1) {
+	if (init_8259A_after_S1) {
 		printk("Broken toshiba laptop -> kicking interrupts\n");
 		init_8259A(0);
 	}
@@ -159,16 +162,38 @@ int acpi_suspend(u32 acpi_state)
 	return -EINVAL;
 }
 
-
 static struct pm_ops acpi_pm_ops = {
 	.prepare	= acpi_pm_prepare,
 	.enter		= acpi_pm_enter,
 	.finish		= acpi_pm_finish,
 };
 
+
+/*
+ * Toshiba fails to preserve interrupts over S1, reinitialization 
+ * of 8259 is needed after S1 resume.
+ */
+static int __init init_ints_after_s1(struct dmi_system_id *d)
+{
+	printk(KERN_WARNING "%s with broken S1 detected.\n", d->ident);
+	init_8259A_after_S1 = 1;
+	return 0;
+}
+
+static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
+	{	
+		.callback = init_ints_after_s1,
+		.ident = "Toshiba Satellite 4030cdt",
+		.matches = { DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"), },
+	},
+	{ },
+};
+
 static int __init acpi_sleep_init(void)
 {
 	int			i = 0;
+
+	dmi_check_system(acpisleep_dmi_table);
 
 	if (acpi_disabled)
 		return 0;

