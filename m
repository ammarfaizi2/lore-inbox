Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266453AbUFWMtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266453AbUFWMtd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 08:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266484AbUFWMrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 08:47:00 -0400
Received: from mail.donpac.ru ([80.254.111.2]:60297 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S266453AbUFWMov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 08:44:51 -0400
Subject: [PATCH 4/6] 2.6.7-mm1, port powernow-k7 driver to new DMI probing
In-Reply-To: <10879946822631@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 23 Jun 2004 16:44:47 +0400
Message-Id: <10879946874140@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch ports powernow-k7 driver to new DMI probing API.

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 arch/i386/kernel/cpu/cpufreq/powernow-k7.c |   28 +++++++++++++++++++++++++++-
 arch/i386/kernel/dmi_scan.c                |   20 --------------------
 2 files changed, 27 insertions(+), 21 deletions(-)

diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm1.vanilla/arch/i386/kernel/cpu/cpufreq/powernow-k7.c linux-2.6.7-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
--- linux-2.6.7-mm1.vanilla/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	Sun May 23 22:02:03 2004
+++ linux-2.6.7-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	Sun May 23 22:47:59 2004
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
 
-	if ((dmi_broken & BROKEN_CPUFREQ) || acpi_force) {
+ 	if (dmi_check_system(powernow_dmi_table) || acpi_force) {
 		printk (KERN_INFO PFX "PSB/PST known to be broken.  Trying ACPI instead\n");
 		result = powernow_acpi_init();
 	} else {
diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Sun May 23 22:43:24 2004
+++ linux-2.6.7-mm1/arch/i386/kernel/dmi_scan.c	Sun May 23 22:48:38 2004
@@ -400,15 +400,6 @@ static __init int broken_ps2_resume(stru
 	return 0;
 }
 
-static __init int acer_cpufreq_pst(struct dmi_blacklist *d)
-{
-	printk(KERN_WARNING "%s laptop with broken PST tables in BIOS detected.\n", d->ident);
-	printk(KERN_WARNING "You need to downgrade to 3A21 (09/09/2002), or try a newer BIOS than 3A71 (01/20/2003)\n");
-	printk(KERN_WARNING "cpufreq scaling has been disabled as a result of this.\n");
-	dmi_broken |= BROKEN_CPUFREQ;
-	return 0;
-}
-
 
 /*
  *	Simple "print if true" callback
@@ -758,17 +749,6 @@ static __initdata struct dmi_blacklist d
 	{ set_apm_ints, "IBM", {	/* Allow interrupts during suspend on IBM laptops */
 			MATCH(DMI_SYS_VENDOR, "IBM"),
 			NO_MATCH, NO_MATCH, NO_MATCH
-			} },
-
-	/*
-	 * Some Athlon laptops have really fucked PST tables.
-	 * A BIOS update is all that can save them.
-	 * Mention this, and disable cpufreq.
-	 */
-	{ acer_cpufreq_pst, "Acer Aspire", {
-			MATCH(DMI_SYS_VENDOR, "Insyde Software"),
-			MATCH(DMI_BIOS_VERSION, "3A71"),
-			NO_MATCH, NO_MATCH,
 			} },
 
 	/*      

