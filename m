Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262754AbVENMqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbVENMqe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 08:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVENMqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 08:46:33 -0400
Received: from mail.donpac.ru ([80.254.111.2]:4515 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S262754AbVENMo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 08:44:57 -0400
Subject: [PATCH 2.6.12-rc4-mm1 0/3] DMI, move ACPI boot quirk
In-Reply-To: 
Date: Sat, 14 May 2005 16:44:55 +0400
Message-Id: <11160746954181@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch moves ACPI boot quirks out of dmi_scan.c

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 arch/i386/kernel/acpi/boot.c |  219 ++++++++++++++++++++++++++++++++++++++++++-
 arch/i386/kernel/dmi_scan.c  |  163 --------------------------------
 2 files changed, 217 insertions(+), 165 deletions(-)

diff -urdpNX dontdiff linux-2.6.12-rc4-mm1.vanilla/arch/i386/kernel/acpi/boot.c linux-2.6.12-rc4-mm1/arch/i386/kernel/acpi/boot.c
--- linux-2.6.12-rc4-mm1.vanilla/arch/i386/kernel/acpi/boot.c	2005-05-04 14:00:09.000000000 +0400
+++ linux-2.6.12-rc4-mm1/arch/i386/kernel/acpi/boot.c	2005-05-04 14:39:16.000000000 +0400
@@ -29,6 +29,7 @@
 #include <linux/efi.h>
 #include <linux/irq.h>
 #include <linux/module.h>
+#include <linux/dmi.h>
 
 #include <asm/pgtable.h>
 #include <asm/io_apic.h>
@@ -831,6 +832,218 @@ acpi_process_madt(void)
 	return;
 }
 
+extern int acpi_force;
+
+#ifdef __i386__
+
+#ifdef	CONFIG_ACPI_PCI
+static int __init disable_acpi_irq(struct dmi_system_id *d) 
+{
+	if (!acpi_force) {
+		printk(KERN_NOTICE "%s detected: force use of acpi=noirq\n",
+		       d->ident);
+		acpi_noirq_set();
+	}
+	return 0;
+}
+
+static int __init disable_acpi_pci(struct dmi_system_id *d) 
+{
+	if (!acpi_force) {
+		printk(KERN_NOTICE "%s detected: force use of pci=noacpi\n",
+		       d->ident);
+		acpi_disable_pci();
+	}
+	return 0;
+}  
+#endif
+
+static int __init dmi_disable_acpi(struct dmi_system_id *d) 
+{ 
+	if (!acpi_force) { 
+		printk(KERN_NOTICE "%s detected: acpi off\n",d->ident); 
+		disable_acpi();
+	} else { 
+		printk(KERN_NOTICE 
+		       "Warning: DMI blacklist says broken, but acpi forced\n"); 
+	}
+	return 0;
+} 
+
+/*
+ * Limit ACPI to CPU enumeration for HT
+ */
+static int __init force_acpi_ht(struct dmi_system_id *d) 
+{ 
+	if (!acpi_force) { 
+		printk(KERN_NOTICE "%s detected: force use of acpi=ht\n", d->ident); 
+		disable_acpi();
+		acpi_ht = 1; 
+	} else { 
+		printk(KERN_NOTICE 
+		       "Warning: acpi=force overrules DMI blacklist: acpi=ht\n"); 
+	}
+	return 0;
+} 
+
+/*
+ * If your system is blacklisted here, but you find that acpi=force
+ * works for you, please contact acpi-devel@sourceforge.net
+ */
+static struct dmi_system_id __initdata acpi_dmi_table[] = {
+	/*
+	 * Boxes that need ACPI disabled
+	 */
+	{
+		.callback = dmi_disable_acpi,
+		.ident = "IBM Thinkpad",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
+			DMI_MATCH(DMI_BOARD_NAME, "2629H1G"),
+		},
+	},
+
+	/*
+	 * Boxes that need acpi=ht 
+	 */
+	{
+		.callback = force_acpi_ht,
+		.ident = "FSC Primergy T850",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PRIMERGY T850"),
+		},
+	},
+	{
+		.callback = force_acpi_ht,
+		.ident = "DELL GX240",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Dell Computer Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "OptiPlex GX240"),
+		},
+	},
+	{
+		.callback = force_acpi_ht,
+		.ident = "HP VISUALIZE NT Workstation",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP VISUALIZE NT Workstation"),
+		},
+	},
+	{
+		.callback = force_acpi_ht,
+		.ident = "Compaq Workstation W8000",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Workstation W8000"),
+		},
+	},
+	{
+		.callback = force_acpi_ht,
+		.ident = "ASUS P4B266",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "P4B266"),
+		},
+	},
+	{
+		.callback = force_acpi_ht,
+		.ident = "ASUS P2B-DS",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "P2B-DS"),
+		},
+	},
+	{
+		.callback = force_acpi_ht,
+		.ident = "ASUS CUR-DLS",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "CUR-DLS"),
+		},
+	},
+	{
+		.callback = force_acpi_ht,
+		.ident = "ABIT i440BX-W83977",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ABIT <http://www.abit.com>"),
+			DMI_MATCH(DMI_BOARD_NAME, "i440BX-W83977 (BP6)"),
+		},
+	},
+	{
+		.callback = force_acpi_ht,
+		.ident = "IBM Bladecenter",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
+			DMI_MATCH(DMI_BOARD_NAME, "IBM eServer BladeCenter HS20"),
+		},
+	},
+	{
+		.callback = force_acpi_ht,
+		.ident = "IBM eServer xSeries 360",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
+			DMI_MATCH(DMI_BOARD_NAME, "eServer xSeries 360"),
+		},
+	},
+	{
+		.callback = force_acpi_ht,
+		.ident = "IBM eserver xSeries 330",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
+			DMI_MATCH(DMI_BOARD_NAME, "eserver xSeries 330"),
+		},
+	},
+	{
+		.callback = force_acpi_ht,
+		.ident = "IBM eserver xSeries 440",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "eserver xSeries 440"),
+		},
+	},
+
+#ifdef	CONFIG_ACPI_PCI
+	/*
+	 * Boxes that need ACPI PCI IRQ routing disabled
+	 */
+	{
+		.callback = disable_acpi_irq,
+		.ident = "ASUS A7V",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC"),
+			DMI_MATCH(DMI_BOARD_NAME, "<A7V>"),
+			/* newer BIOS, Revision 1011, does work */
+			DMI_MATCH(DMI_BIOS_VERSION, "ASUS A7V ACPI BIOS Revision 1007"),
+		},
+	},
+
+	/*
+	 * Boxes that need ACPI PCI IRQ routing and PCI scan disabled
+	 */
+	{	/* _BBN 0 bug */
+		.callback = disable_acpi_pci,
+		.ident = "ASUS PR-DLS",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "PR-DLS"),
+			DMI_MATCH(DMI_BIOS_VERSION, "ASUS PR-DLS ACPI BIOS Revision 1010"),
+			DMI_MATCH(DMI_BIOS_DATE, "03/21/2003")
+		},
+	},
+	{
+		.callback = disable_acpi_pci,
+		.ident = "Acer TravelMate 36x Laptop",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+ 			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
+		},
+	},
+#endif
+};
+
+#endif	/* __i386__ */
+
 /*
  * acpi_boot_table_init() and acpi_boot_init()
  *  called from setup_arch(), always.
@@ -859,6 +1072,10 @@ acpi_boot_table_init(void)
 {
 	int error;
 
+#ifdef __i386__
+	dmi_check_system(acpi_dmi_table);
+#endif
+
 	/*
 	 * If acpi_disabled, bail out
 	 * One exception: acpi=ht continues far enough to enumerate LAPICs
@@ -886,8 +1103,6 @@ acpi_boot_table_init(void)
 	 */
 	error = acpi_blacklisted();
 	if (error) {
-		extern int acpi_force;
-
 		if (acpi_force) {
 			printk(KERN_WARNING PREFIX "acpi=force override\n");
 		} else {
diff -urdpNX dontdiff linux-2.6.12-rc4-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.12-rc4-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.12-rc4-mm1.vanilla/arch/i386/kernel/dmi_scan.c	2005-05-04 14:00:09.000000000 +0400
+++ linux-2.6.12-rc4-mm1/arch/i386/kernel/dmi_scan.c	2005-05-04 14:39:16.000000000 +0400
@@ -188,59 +188,6 @@ static __init int reset_videomode_after_
 #endif
 
 
-#ifdef	CONFIG_ACPI_BOOT
-extern int acpi_force;
-
-static __init __attribute__((unused)) int dmi_disable_acpi(struct dmi_blacklist *d) 
-{ 
-	if (!acpi_force) { 
-		printk(KERN_NOTICE "%s detected: acpi off\n",d->ident); 
-		disable_acpi();
-	} else { 
-		printk(KERN_NOTICE 
-		       "Warning: DMI blacklist says broken, but acpi forced\n"); 
-	}
-	return 0;
-} 
-
-/*
- * Limit ACPI to CPU enumeration for HT
- */
-static __init __attribute__((unused)) int force_acpi_ht(struct dmi_blacklist *d) 
-{ 
-	if (!acpi_force) { 
-		printk(KERN_NOTICE "%s detected: force use of acpi=ht\n", d->ident); 
-		disable_acpi();
-		acpi_ht = 1; 
-	} else { 
-		printk(KERN_NOTICE 
-		       "Warning: acpi=force overrules DMI blacklist: acpi=ht\n"); 
-	}
-	return 0;
-} 
-#endif
-
-#ifdef	CONFIG_ACPI_PCI
-static __init int disable_acpi_irq(struct dmi_blacklist *d) 
-{
-	if (!acpi_force) {
-		printk(KERN_NOTICE "%s detected: force use of acpi=noirq\n",
-		       d->ident); 	
-		acpi_noirq_set();
-	}
-	return 0;
-}
-static __init int disable_acpi_pci(struct dmi_blacklist *d) 
-{
-	if (!acpi_force) {
-		printk(KERN_NOTICE "%s detected: force use of pci=noacpi\n",
-		       d->ident); 	
-		acpi_disable_pci();
-	}
-	return 0;
-}  
-#endif
-
 /*
  *	Process the DMI blacklists
  */
@@ -264,116 +211,6 @@ static __initdata struct dmi_blacklist d
 			} },
 #endif
 
-#ifdef	CONFIG_ACPI_BOOT
-	/*
-	 * If your system is blacklisted here, but you find that acpi=force
-	 * works for you, please contact acpi-devel@sourceforge.net
-	 */
-
-	/*
-	 *	Boxes that need ACPI disabled
-	 */
-
-	{ dmi_disable_acpi, "IBM Thinkpad", {
-			MATCH(DMI_BOARD_VENDOR, "IBM"),
-			MATCH(DMI_BOARD_NAME, "2629H1G"),
-			NO_MATCH, NO_MATCH }},
-
-	/*
-	 *	Boxes that need acpi=ht 
-	 */
-
-	{ force_acpi_ht, "FSC Primergy T850", {
-			MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-			MATCH(DMI_PRODUCT_NAME, "PRIMERGY T850"),
-			NO_MATCH, NO_MATCH }},
-
-	{ force_acpi_ht, "DELL GX240", {
-			MATCH(DMI_BOARD_VENDOR, "Dell Computer Corporation"),
-			MATCH(DMI_BOARD_NAME, "OptiPlex GX240"),
-			NO_MATCH, NO_MATCH }},
-
-	{ force_acpi_ht, "HP VISUALIZE NT Workstation", {
-			MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
-			MATCH(DMI_PRODUCT_NAME, "HP VISUALIZE NT Workstation"),
-			NO_MATCH, NO_MATCH }},
-
-	{ force_acpi_ht, "Compaq Workstation W8000", {
-			MATCH(DMI_SYS_VENDOR, "Compaq"),
-			MATCH(DMI_PRODUCT_NAME, "Workstation W8000"),
-			NO_MATCH, NO_MATCH }},
-
-	{ force_acpi_ht, "ASUS P4B266", {
-			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-			MATCH(DMI_BOARD_NAME, "P4B266"),
-			NO_MATCH, NO_MATCH }},
-
-	{ force_acpi_ht, "ASUS P2B-DS", {
-			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-			MATCH(DMI_BOARD_NAME, "P2B-DS"),
-			NO_MATCH, NO_MATCH }},
-
-	{ force_acpi_ht, "ASUS CUR-DLS", {
-			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-			MATCH(DMI_BOARD_NAME, "CUR-DLS"),
-			NO_MATCH, NO_MATCH }},
-
-	{ force_acpi_ht, "ABIT i440BX-W83977", {
-			MATCH(DMI_BOARD_VENDOR, "ABIT <http://www.abit.com>"),
-			MATCH(DMI_BOARD_NAME, "i440BX-W83977 (BP6)"),
-			NO_MATCH, NO_MATCH }},
-
-	{ force_acpi_ht, "IBM Bladecenter", {
-			MATCH(DMI_BOARD_VENDOR, "IBM"),
-			MATCH(DMI_BOARD_NAME, "IBM eServer BladeCenter HS20"),
-			NO_MATCH, NO_MATCH }},
-
-	{ force_acpi_ht, "IBM eServer xSeries 360", {
-			MATCH(DMI_BOARD_VENDOR, "IBM"),
-			MATCH(DMI_BOARD_NAME, "eServer xSeries 360"),
-			NO_MATCH, NO_MATCH }},
-
-	{ force_acpi_ht, "IBM eserver xSeries 330", {
-			MATCH(DMI_BOARD_VENDOR, "IBM"),
-			MATCH(DMI_BOARD_NAME, "eserver xSeries 330"),
-			NO_MATCH, NO_MATCH }},
-
-	{ force_acpi_ht, "IBM eserver xSeries 440", {
-			MATCH(DMI_BOARD_VENDOR, "IBM"),
-			MATCH(DMI_PRODUCT_NAME, "eserver xSeries 440"),
-			NO_MATCH, NO_MATCH }},
-
-#endif	// CONFIG_ACPI_BOOT
-
-#ifdef	CONFIG_ACPI_PCI
-	/*
-	 *	Boxes that need ACPI PCI IRQ routing disabled
-	 */
-
-	{ disable_acpi_irq, "ASUS A7V", {
-			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC"),
-			MATCH(DMI_BOARD_NAME, "<A7V>"),
-			/* newer BIOS, Revision 1011, does work */
-			MATCH(DMI_BIOS_VERSION, "ASUS A7V ACPI BIOS Revision 1007"),
-			NO_MATCH }},
-
-	/*
-	 *	Boxes that need ACPI PCI IRQ routing and PCI scan disabled
-	 */
-	{ disable_acpi_pci, "ASUS PR-DLS", {	/* _BBN 0 bug */
-			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-			MATCH(DMI_BOARD_NAME, "PR-DLS"),
-			MATCH(DMI_BIOS_VERSION, "ASUS PR-DLS ACPI BIOS Revision 1010"),
-			MATCH(DMI_BIOS_DATE, "03/21/2003") }},
-
- 	{ disable_acpi_pci, "Acer TravelMate 36x Laptop", {
- 			MATCH(DMI_SYS_VENDOR, "Acer"),
- 			MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
- 			NO_MATCH, NO_MATCH
- 			} },
-
-#endif
-
 	{ NULL, }
 };
 

