Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266012AbUFWMos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266012AbUFWMos (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 08:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266453AbUFWMos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 08:44:48 -0400
Received: from mail.donpac.ru ([80.254.111.2]:50057 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S266012AbUFWMoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 08:44:38 -0400
Subject: [PATCH 1/6] 2.6.7-mm1, port PnP BIOS driver to new DMI probing
In-Reply-To: <10879946711727@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 23 Jun 2004 16:44:35 +0400
Message-Id: <10879946751497@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch ports PnP BIOS driver to new DMI probing API.

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 arch/i386/kernel/dmi_scan.c |   24 ------------------------
 drivers/pnp/pnpbios/core.c  |   32 +++++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 25 deletions(-)

diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Sun May 23 22:08:06 2004
+++ linux-2.6.7-mm1/arch/i386/kernel/dmi_scan.c	Sun May 23 22:08:22 2004
@@ -433,18 +433,6 @@ static __init int broken_ps2_resume(stru
 	return 0;
 }
 
-/*
- *	Exploding PnPBIOS. Don't yet know if its the BIOS or us for
- *	some entries
- */
-
-static __init int exploding_pnp_bios(struct dmi_blacklist *d)
-{
-	printk(KERN_WARNING "%s detected. Disabling PnPBIOS\n", d->ident);
-	dmi_broken |= BROKEN_PNP_BIOS;
-	return 0;
-}
-
 static __init int acer_cpufreq_pst(struct dmi_blacklist *d)
 {
 	printk(KERN_WARNING "%s laptop with broken PST tables in BIOS detected.\n", d->ident);
@@ -748,18 +736,6 @@ static __initdata struct dmi_blacklist d
 			MATCH(DMI_BIOS_DATE, "10/26/01"), NO_MATCH
 			} },
 			
-	{ exploding_pnp_bios, "Higraded P14H", {	/* PnPBIOS GPF on boot */
-			MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
-			MATCH(DMI_BIOS_VERSION, "07.00T"),
-			MATCH(DMI_SYS_VENDOR, "Higraded"),
-			MATCH(DMI_PRODUCT_NAME, "P14H")
-			} },
-	{ exploding_pnp_bios, "ASUS P4P800", {	/* PnPBIOS GPF on boot */
-			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc."),
-			MATCH(DMI_BOARD_NAME, "P4P800"),
-			NO_MATCH, NO_MATCH
-			} },
-
 	/* Machines which have problems handling enabled local APICs */
 
 	{ local_apic_kills_bios, "Dell Inspiron", {
diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm1.vanilla/drivers/pnp/pnpbios/core.c linux-2.6.7-mm1/drivers/pnp/pnpbios/core.c
--- linux-2.6.7-mm1.vanilla/drivers/pnp/pnpbios/core.c	Sun May 23 22:02:41 2004
+++ linux-2.6.7-mm1/drivers/pnp/pnpbios/core.c	Sun May 23 22:08:22 2004
@@ -59,6 +59,7 @@
 #include <linux/kmod.h>
 #include <linux/completion.h>
 #include <linux/spinlock.h>
+#include <linux/dmi.h>
 
 #include <asm/page.h>
 #include <asm/desc.h>
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

