Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbUE1MPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbUE1MPO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUE1MIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:08:44 -0400
Received: from mail.donpac.ru ([80.254.111.2]:58036 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S262499AbUE1L4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 07:56:03 -0400
Subject: [PATCH 10/13] 2.6.7-rc1-mm1, Port powernow-k7 driver to new DMI probing
In-Reply-To: <1085745355529@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 28 May 2004 15:55:58 +0400
Message-Id: <10857453581556@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/cpu/cpufreq/powernow-k7.c linux-2.6.7-rc1-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
--- linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	Wed Apr 28 22:56:07 2004
+++ linux-2.6.7-rc1-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	Thu Apr 29 00:10:40 2004
@@ -22,6 +22,7 @@
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/dmi.h>
 
 #include <asm/msr.h>
 #include <asm/timex.h>
@@ -554,6 +555,31 @@ static unsigned int powernow_get(unsigne
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
@@ -572,7 +598,7 @@ static int __init powernow_cpu_init (str
 	}
 	dprintk(KERN_INFO PFX "FSB: %3d.%03d MHz\n", fsb/1000, fsb%1000);
 
-	if ((dmi_broken & BROKEN_CPUFREQ) || powernow_acpi_force) {
+	if (dmi_check_system(powernow_dmi_table) || powernow_acpi_force) {
 		printk (KERN_INFO PFX "PSB/PST known to be broken.  Trying ACPI instead\n");
 		result = powernow_acpi_init();
 	} else {
diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Thu Apr 29 00:10:34 2004
+++ linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c	Thu Apr 29 00:10:40 2004
@@ -235,16 +235,6 @@ static __init int reset_videomode_after_
 #endif
 
 
-static __init int acer_cpufreq_pst(struct dmi_system_id *d)
-{
-	printk(KERN_WARNING "%s laptop with broken PST tables in BIOS detected.\n", d->ident);
-	printk(KERN_WARNING "You need to downgrade to 3A21 (09/09/2002), or try a newer BIOS than 3A71 (01/20/2003)\n");
-	printk(KERN_WARNING "cpufreq scaling has been disabled as a result of this.\n");
-	dmi_broken |= BROKEN_CPUFREQ;
-	return 0;
-}
-
-
 #ifdef	CONFIG_ACPI_PCI
 static __init int disable_acpi_irq(struct dmi_system_id *d) 
 { 
@@ -310,16 +300,6 @@ static __initdata struct dmi_system_id d
 			DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
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
 
 #ifdef CONFIG_SERIO_I8042
 	{ set_8042_nomux, "Compaq Proliant 8500", {

