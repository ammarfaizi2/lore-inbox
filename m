Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263389AbUEGIxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbUEGIxy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 04:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUEGIlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 04:41:09 -0400
Received: from mail.donpac.ru ([80.254.111.2]:45211 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S263364AbUEGIde convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 04:33:34 -0400
Subject: [PATCH 5/8] 2.6.3-rc3-mm1, Move HP Pavilion and Acer TravelMate 360 irq workarounds where they belong
In-Reply-To: <10839188201449@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 7 May 2004 12:33:44 +0400
Message-Id: <10839188241411@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN -X /usr/share/dontdiff linux-2.6.6-rc3-mm1.vanulla/arch/i386/kernel/dmi_scan.c linux-2.6.6-rc3-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.6-rc3-mm1.vanulla/arch/i386/kernel/dmi_scan.c	2004-05-07 11:22:20.000000000 +0400
+++ linux-2.6.6-rc3-mm1/arch/i386/kernel/dmi_scan.c	2004-05-07 11:17:53.000000000 +0400
@@ -235,40 +235,6 @@ static __init int disable_smbus(struct d
 }
 
 /*
- * Work around broken HP Pavilion Notebooks which assign USB to
- * IRQ 9 even though it is actually wired to IRQ 11
- */
-static __init int fix_broken_hp_bios_irq9(struct dmi_system_id *d)
-{
-#ifdef CONFIG_PCI
-	extern int broken_hp_bios_irq9;
-	if (broken_hp_bios_irq9 == 0)
-	{
-		broken_hp_bios_irq9 = 1;
-		printk(KERN_INFO "%s detected - fixing broken IRQ routing\n", d->ident);
-	}
-#endif
-	return 0;
-}
-
-/*
- * Work around broken Acer TravelMate 360 Notebooks which assign Cardbus to
- * IRQ 11 even though it is actually wired to IRQ 10
- */
-static __init int fix_acer_tm360_irqrouting(struct dmi_system_id *d)
-{
-#ifdef CONFIG_PCI
-	extern int acer_tm360_irqrouting;
-	if (acer_tm360_irqrouting == 0)
-	{
-		acer_tm360_irqrouting = 1;
-		printk(KERN_INFO "%s detected - fixing broken IRQ routing\n", d->ident);
-	}
-#endif
-	return 0;
-}
-
-/*
  * ASUS K7V-RM has broken ACPI table defining sleep modes
  */
 
@@ -466,19 +432,6 @@ static __initdata struct dmi_system_id d
 			DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
 			} },
 #endif
-	{ fix_broken_hp_bios_irq9, "HP Pavilion N5400 Series Laptop", {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_BIOS_VERSION, "GE.M1.03"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook Model GE"),
-			DMI_MATCH(DMI_BOARD_VERSION, "OmniBook N32N-736")
-			} },
-
-	{ fix_acer_tm360_irqrouting, "Acer TravelMate 36x Laptop", {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
-			} },
-
- 
 
 
 	/*
diff -urpN -X /usr/share/dontdiff linux-2.6.6-rc3-mm1.vanulla/arch/i386/pci/irq.c linux-2.6.6-rc3-mm1/arch/i386/pci/irq.c
--- linux-2.6.6-rc3-mm1.vanulla/arch/i386/pci/irq.c	2004-05-07 09:45:23.000000000 +0400
+++ linux-2.6.6-rc3-mm1/arch/i386/pci/irq.c	2004-05-07 11:20:39.000000000 +0400
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/dmi.h>
 #include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/io_apic.h>
@@ -22,8 +23,8 @@
 #define PIRQ_SIGNATURE	(('$' << 0) + ('P' << 8) + ('I' << 16) + ('R' << 24))
 #define PIRQ_VERSION 0x0100
 
-int broken_hp_bios_irq9;
-int acer_tm360_irqrouting;
+static int broken_hp_bios_irq9;
+static int acer_tm360_irqrouting;
 
 static struct irq_routing_table *pirq_table;
 
@@ -902,6 +903,54 @@ static void __init pcibios_fixup_irqs(vo
 	}
 }
 
+/*
+ * Work around broken HP Pavilion Notebooks which assign USB to
+ * IRQ 9 even though it is actually wired to IRQ 11
+ */
+static int __init fix_broken_hp_bios_irq9(struct dmi_system_id *d)
+{
+	if (!broken_hp_bios_irq9) {
+		broken_hp_bios_irq9 = 1;
+		printk(KERN_INFO "%s detected - fixing broken IRQ routing\n", d->ident);
+	}
+	return 0;
+}
+
+/*
+ * Work around broken Acer TravelMate 360 Notebooks which assign Cardbus to
+ * IRQ 11 even though it is actually wired to IRQ 10
+ */
+static int __init fix_acer_tm360_irqrouting(struct dmi_system_id *d)
+{
+	if (!acer_tm360_irqrouting) {
+		acer_tm360_irqrouting = 1;
+		printk(KERN_INFO "%s detected - fixing broken IRQ routing\n", d->ident);
+	}
+	return 0;
+}
+
+static struct dmi_system_id __initdata pciirq_dmi_table[] = {
+	{
+		.callback = fix_broken_hp_bios_irq9,
+		.ident = "HP Pavilion N5400 Series Laptop",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_BIOS_VERSION, "GE.M1.03"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook Model GE"),
+			DMI_MATCH(DMI_BOARD_VERSION, "OmniBook N32N-736"),
+		},
+	},
+	{
+		.callback = fix_acer_tm360_irqrouting,
+		.ident = "Acer TravelMate 36x Laptop",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
+		},
+	},
+	{ }
+};
+
 static int __init pcibios_irq_init(void)
 {
 	DBG("PCI: IRQ init\n");
@@ -909,6 +958,8 @@ static int __init pcibios_irq_init(void)
 	if (pcibios_enable_irq)
 		return 0;
 
+	dmi_check_system(pciirq_dmi_table);
+
 	pirq_table = pirq_find_routing_table();
 
 #ifdef CONFIG_PCI_BIOS

