Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbUE1MG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUE1MG5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUE1MEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:04:14 -0400
Received: from mail.donpac.ru ([80.254.111.2]:45748 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S262450AbUE1Lzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 07:55:45 -0400
Subject: [PATCH 5/13] 2.6.7-rc1-mm1, Port HP Pavilion irq routing quirk to new DMI probing
In-Reply-To: <10857453372934@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 28 May 2004 15:55:41 +0400
Message-Id: <10857453413454@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make pci irq routing code use
dmi_check_system() function
and make broken_hp_bios_irq9 variable static.

diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-rc1-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Wed Apr 28 23:52:39 2004
+++ linux-2.6.7-rc1-mm1/arch/i386/kernel/dmi_scan.c	Wed Apr 28 23:53:48 2004
@@ -235,23 +235,6 @@ static __init int disable_smbus(struct d
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
  * HP Proliant 8500 systems can't use i8042 in mux mode,
  * or they instantly reboot.
  */
@@ -466,14 +449,6 @@ static __initdata struct dmi_system_id d
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
-
 
 	/*
 	 *	SMBus / sensors settings
diff -urpN -X /usr/share/dontdiff linux-2.6.7-rc1-mm1.vanilla/arch/i386/pci/irq.c linux-2.6.7-rc1-mm1/arch/i386/pci/irq.c
--- linux-2.6.7-rc1-mm1.vanilla/arch/i386/pci/irq.c	Wed Apr 28 22:56:09 2004
+++ linux-2.6.7-rc1-mm1/arch/i386/pci/irq.c	Wed Apr 28 23:53:01 2004
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/dmi.h>
 #include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/io_apic.h>
@@ -22,7 +23,7 @@
 #define PIRQ_SIGNATURE	(('$' << 0) + ('P' << 8) + ('I' << 16) + ('R' << 24))
 #define PIRQ_VERSION 0x0100
 
-int broken_hp_bios_irq9;
+static int broken_hp_bios_irq9;
 
 static struct irq_routing_table *pirq_table;
 
@@ -893,12 +894,41 @@ static void __init pcibios_fixup_irqs(vo
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
+	{ }
+};
+
 static int __init pcibios_irq_init(void)
 {
 	DBG("PCI: IRQ init\n");
 
 	if (pcibios_enable_irq || raw_pci_ops == NULL)
 		return 0;
+
+	dmi_check_system(pciirq_dmi_table);
 
 	pirq_table = pirq_find_routing_table();
 

