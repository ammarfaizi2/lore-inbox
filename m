Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUEaVXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUEaVXE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 17:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264796AbUEaVXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 17:23:03 -0400
Received: from 80-218-57-148.dclient.hispeed.ch ([80.218.57.148]:7431 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S264795AbUEaVW6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 17:22:58 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix irq routing on acer travelmate 360 laptop
Date: Mon, 31 May 2004 23:20:22 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405312320.22811.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi andrew

the updated patch that fixes irq routing on acer travelmate 360 laptop.
against 2.6.7-rc2-bk

rgds
-daniel


---------

fixes interrupt routing on acer travelmate 360 notebooks. it looks like the bios
assigned the wrong pirq value for the cardbus bridge. just assigning irq 10 to
all devices with pirq 0x63 would break second usb port. pirq 0x68 seems to be
right one for cardbus.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>


--- 1.59/arch/i386/kernel/dmi_scan.c	Wed Apr 28 09:29:06 2004
+++ edited/arch/i386/kernel/dmi_scan.c	Sat May  8 00:46:42 2004
@@ -360,6 +360,21 @@
 }
 
 /*
+ * Work around broken Acer TravelMate 360 Notebooks which assign Cardbus to
+ * IRQ 11 even though it is actually wired to IRQ 10
+ */
+static __init int fix_acer_tm360_irqrouting(struct dmi_blacklist *d)
+{
+#ifdef CONFIG_PCI
+	extern int acer_tm360_irqrouting;
+	if (acer_tm360_irqrouting == 0) {
+		acer_tm360_irqrouting = 1;
+		printk(KERN_INFO "%s detected - fixing broken IRQ routing\n", d->ident);
+	}
+#endif
+	return 0;
+}
+/*
  *  Check for clue free BIOS implementations who use
  *  the following QA technique
  *
@@ -844,6 +859,13 @@
 			MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook Model GE"),
 			MATCH(DMI_BOARD_VERSION, "OmniBook N32N-736")
 			} },
+
+	{ fix_acer_tm360_irqrouting, "Acer TravelMate 36x Laptop", {
+			MATCH(DMI_SYS_VENDOR, "Acer"),
+			MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
+			NO_MATCH, NO_MATCH
+			} },
+ 
  
 
 	/*
@@ -1033,6 +1055,13 @@
 			MATCH(DMI_BOARD_NAME, "PR-DLS"),
 			MATCH(DMI_BIOS_VERSION, "ASUS PR-DLS ACPI BIOS Revision 1010"),
 			MATCH(DMI_BIOS_DATE, "03/21/2003") }},
+
+ 	{ disable_acpi_pci, "Acer TravelMate 36x Laptop", {
+ 			MATCH(DMI_SYS_VENDOR, "Acer"),
+ 			MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
+ 			NO_MATCH, NO_MATCH
+ 			} },
+  
 #endif
 
 	{ NULL, }
--- 1.39/arch/i386/pci/irq.c	Fri Apr 23 21:43:20 2004
+++ edited/arch/i386/pci/irq.c	Sun May  9 20:53:19 2004
@@ -23,6 +23,7 @@
 #define PIRQ_VERSION 0x0100
 
 int broken_hp_bios_irq9;
+int acer_tm360_irqrouting;
 
 static struct irq_routing_table *pirq_table;
 
@@ -744,6 +745,14 @@
 		dev->irq = 11;
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
 		r->set(pirq_router_dev, dev, pirq, 11);
+	}
+
+	/* same for Acer Travelmate 360, but with CB and irq 11 -> 10 */
+	if (acer_tm360_irqrouting && dev->irq == 11 && dev->vendor == PCI_VENDOR_ID_O2) {
+		pirq = 0x68;
+		mask = 0x400;
+		dev->irq = r->get(pirq_router_dev, dev, pirq);
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
 	}
 
 	/*


