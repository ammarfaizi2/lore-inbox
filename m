Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263365AbUEGInS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbUEGInS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 04:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbUEGIl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 04:41:58 -0400
Received: from mail.donpac.ru ([80.254.111.2]:49307 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S263366AbUEGIdk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 04:33:40 -0400
Subject: [PATCH 7/8] 2.6.3-rc3-mm1, Port PnP BIOS driver to new DMI probing
In-Reply-To: <10839188271223@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 7 May 2004 12:33:50 +0400
Message-Id: <10839188302729@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN -X /usr/share/dontdiff linux-2.6.6-rc3-mm1.vanulla/arch/i386/kernel/dmi_scan.c linux-2.6.6-rc3-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.6-rc3-mm1.vanulla/arch/i386/kernel/dmi_scan.c	2004-05-07 12:00:29.000000000 +0400
+++ linux-2.6.6-rc3-mm1/arch/i386/kernel/dmi_scan.c	2004-05-07 11:54:35.000000000 +0400
@@ -262,17 +262,6 @@ static __init int reset_videomode_after_
 }
 #endif
 
-/*
- *	Exploding PnPBIOS. Don't yet know if its the BIOS or us for
- *	some entries
- */
-
-static __init int exploding_pnp_bios(struct dmi_system_id *d)
-{
-	printk(KERN_WARNING "%s detected. Disabling PnPBIOS\n", d->ident);
-	dmi_broken |= BROKEN_PNP_BIOS;
-	return 0;
-}
 
 static __init int acer_cpufreq_pst(struct dmi_system_id *d)
 {
@@ -369,17 +358,6 @@ static __initdata struct dmi_system_id d
 			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge 2400"),
 			} },
 			
-	{ exploding_pnp_bios, "Higraded P14H", {	/* PnPBIOS GPF on boot */
-			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
-			DMI_MATCH(DMI_BIOS_VERSION, "07.00T"),
-			DMI_MATCH(DMI_SYS_VENDOR, "Higraded"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "P14H")
-			} },
-	{ exploding_pnp_bios, "ASUS P4P800", {	/* PnPBIOS GPF on boot */
-			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc."),
-			DMI_MATCH(DMI_BOARD_NAME, "P4P800"),
-			} },
-
 	/* Machines which have problems handling enabled local APICs */
 
 	{ local_apic_kills_bios, "Dell Inspiron", {
diff -urpN -X /usr/share/dontdiff linux-2.6.6-rc3-mm1.vanulla/drivers/pnp/pnpbios/core.c linux-2.6.6-rc3-mm1/drivers/pnp/pnpbios/core.c
--- linux-2.6.6-rc3-mm1.vanulla/drivers/pnp/pnpbios/core.c	2004-04-04 07:36:15.000000000 +0400
+++ linux-2.6.6-rc3-mm1/drivers/pnp/pnpbios/core.c	2004-05-07 11:56:59.000000000 +0400
@@ -62,6 +62,7 @@
 #include <linux/kmod.h>
 #include <linux/completion.h>
 #include <linux/spinlock.h>
+#include <linux/dmi.h>
 #include <asm/system.h>
 #include <asm/byteorder.h>
 
@@ -498,10 +499,39 @@ int __init pnpbios_probe_system(void)
 	return 0;
 }
 
+static int __init exploding_pnp_bios(struct dmi_system_id *d)
+{
+	printk(KERN_WARNING "%s detected. Disabling PnPBIOS\n", d->ident);
+	return 0;
+}
+
+static struct dmi_system_id pnpbios_dmi_table[] = {
+	{	/* PnPBIOS GPF on boot */
+		.callback = exploding_pnp_bios,
+		.ident = "Higraded P14H",
+		.matches = {
+			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
+			DMI_MATCH(DMI_BIOS_VERSION, "07.00T"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Higraded"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P14H"),
+		},
+	},
+	{	/* PnPBIOS GPF on boot */
+		.callback = exploding_pnp_bios,
+		.ident = "ASUS P4P800",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "P4P800"),
+		},
+	},
+	{ }
+};
+
 int __init pnpbios_init(void)
 {
 	int ret;
-	if(pnpbios_disabled || (dmi_broken & BROKEN_PNP_BIOS)) {
+
+	if (pnpbios_disabled || dmi_check_system(pnpbios_dmi_table)) {
 		printk(KERN_INFO "PnPBIOS: Disabled\n");
 		return -ENODEV;
 	}

