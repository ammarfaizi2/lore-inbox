Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbUEFKlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUEFKlj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 06:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUEFKi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 06:38:56 -0400
Received: from mail.donpac.ru ([80.254.111.2]:34795 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S261991AbUEFKc1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 06:32:27 -0400
Subject: [PATCH 5/6] Move HP Pavilion irq workaround where it belongs
In-Reply-To: <10838395512678@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 6 May 2004 14:32:35 +0400
Message-Id: <10838395553579@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN -X /usr/share/dontdiff linux-2.6.6-rc3.vanlila/arch/i386/kernel/dmi_scan.c linux-2.6.6-rc3/arch/i386/kernel/dmi_scan.c
--- linux-2.6.6-rc3.vanlila/arch/i386/kernel/dmi_scan.c	2004-05-05 22:21:10.000000000 +0400
+++ linux-2.6.6-rc3/arch/i386/kernel/dmi_scan.c	2004-05-05 22:22:33.000000000 +0400
@@ -235,23 +235,6 @@
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
  * The Intel 440GX hall of shame. 
  *
  * On many (all we have checked) of these boxes the $PIRQ table is wrong.
@@ -491,14 +474,6 @@
 			DMI_MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
 			} },
 #endif
-	{ fix_broken_hp_bios_irq9, "HP Pavilion N5400 Series Laptop", {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_BIOS_VERSION, "GE.M1.03"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook Model GE"),
-			DMI_MATCH(DMI_BOARD_VERSION, "OmniBook N32N-736"),
-			} },
- 
-
 
 	/*
 	 *	SMBus / sensors settings
diff -urN -X /usr/share/dontdiff linux-2.6.6-rc3.vanlila/arch/i386/pci/irq.c linux-2.6.6-rc3/arch/i386/pci/irq.c
--- linux-2.6.6-rc3.vanlila/arch/i386/pci/irq.c	2004-05-05 22:38:48.000000000 +0400
+++ linux-2.6.6-rc3/arch/i386/pci/irq.c	2004-05-05 22:38:21.000000000 +0400
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
 
@@ -897,6 +898,33 @@
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
+		.callback	= fix_broken_hp_bios_irq9,
+		.ident		= "HP Pavilion N5400 Series Laptop",
+		.matches	= {
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
@@ -904,6 +932,8 @@
 	if (pcibios_enable_irq)
 		return 0;
 
+	dmi_check_system(pciirq_dmi_table);
+
 	pirq_table = pirq_find_routing_table();
 
 #ifdef CONFIG_PCI_BIOS

