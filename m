Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263415AbUEGInS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbUEGInS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 04:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbUEGIm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 04:42:28 -0400
Received: from mail.donpac.ru ([80.254.111.2]:50331 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S263375AbUEGIdm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 04:33:42 -0400
Subject: [PATCH 8/8] 2.6.3-rc3-mm1, Port powernow-k7 driver to new DMI probing
In-Reply-To: <10839188302729@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 7 May 2004 12:33:53 +0400
Message-Id: <10839188332786@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN -X /usr/share/dontdiff linux-2.6.6-rc3-mm1.vanulla/arch/i386/kernel/cpu/cpufreq/powernow-k7.c linux-2.6.6-rc3-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
--- linux-2.6.6-rc3-mm1.vanulla/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2004-05-07 09:44:11.000000000 +0400
+++ linux-2.6.6-rc3-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2004-05-07 12:16:06.000000000 +0400
@@ -22,6 +22,7 @@
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/dmi.h>
 
 #include <asm/msr.h>
 #include <asm/timex.h>
@@ -540,6 +541,31 @@ static int __init fixup_sgtc(void)
 	return sgtc;
 }
 
+static int __init acer_cpufreq_pst(struct dmi_system_id *d)
+{
+	printk(KERN_WARNING "%s laptop with broken PST tables in BIOS detected.\n", d->ident);
+	printk(KERN_WARNING "You need to downgrade to 3A21 (09/09/2002), or try a newer BIOS than 3A71 (01/20/2003)\n");
+	printk(KERN_WARNING "cpufreq scaling has been disabled as a result of this.\n");
+	return 0;
+}
+
+/*
+ * Some Athlon laptops have really fucked PST tables.
+ * A BIOS update is all that can save them.
+ * Mention this, and disable cpufreq.
+ */
+static struct dmi_system_id __initdata powernow_dmi_table[] = {
+	{
+		.callback = acer_cpufreq_pst,
+		.ident = "Acer Aspire",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde Software"),
+			DMI_MATCH(DMI_BIOS_VERSION, "3A71"),
+		},
+	},
+	{ }
+};
+
 static int __init powernow_cpu_init (struct cpufreq_policy *policy)
 {
 	union msr_fidvidstatus fidvidstatus;
@@ -558,7 +584,7 @@ static int __init powernow_cpu_init (str
 	}
 	dprintk(KERN_INFO PFX "FSB: %3d.%03d MHz\n", fsb/1000, fsb%1000);
 
-	if ((dmi_broken & BROKEN_CPUFREQ) || powernow_acpi_force) {
+	if (dmi_check_system(powernow_dmi_table) || powernow_acpi_force) {
 		printk (KERN_INFO PFX "PSB/PST known to be broken.  Trying ACPI instead\n");
 		result = powernow_acpi_init();
 	} else {
diff -urpN -X /usr/share/dontdiff linux-2.6.6-rc3-mm1.vanulla/arch/i386/kernel/dmi_scan.c linux-2.6.6-rc3-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.6-rc3-mm1.vanulla/arch/i386/kernel/dmi_scan.c	2004-05-07 12:00:29.000000000 +0400
+++ linux-2.6.6-rc3-mm1/arch/i386/kernel/dmi_scan.c	2004-05-07 12:16:39.000000000 +0400
@@ -262,27 +262,6 @@ static __init int reset_videomode_after_
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
-
-static __init int acer_cpufreq_pst(struct dmi_system_id *d)
-{
-	printk(KERN_WARNING "%s laptop with broken PST tables in BIOS detected.\n", d->ident);
-	printk(KERN_WARNING "You need to downgrade to 3A21 (09/09/2002), or try a newer BIOS than 3A71 (01/20/2003)\n");
-	printk(KERN_WARNING "cpufreq scaling has been disabled as a result of this.\n");
-	dmi_broken |= BROKEN_CPUFREQ;
-	return 0;
-}
-
 
 #ifdef	CONFIG_ACPI_BOOT
 extern int acpi_force;
@@ -369,17 +348,6 @@ static __initdata struct dmi_system_id d
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
@@ -419,17 +387,6 @@ static __initdata struct dmi_system_id d
 			} },
 #endif
 
-
-	/*
-	 * Some Athlon laptops have really fucked PST tables.
-	 * A BIOS update is all that can save them.
-	 * Mention this, and disable cpufreq.
-	 */
-	{ acer_cpufreq_pst, "Acer Aspire", {
-			DMI_MATCH(DMI_SYS_VENDOR, "Insyde Software"),
-			DMI_MATCH(DMI_BIOS_VERSION, "3A71"),
-			} },
-
 #ifdef	CONFIG_ACPI_BOOT
 	/*
 	 * If your system is blacklisted here, but you find that acpi=force

