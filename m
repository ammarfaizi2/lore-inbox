Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUDJU2m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 16:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbUDJU2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 16:28:42 -0400
Received: from 80-218-57-148.dclient.hispeed.ch ([80.218.57.148]:53765 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S261711AbUDJU2i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 16:28:38 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix Acer TravelMate 360 interrupt routing
Date: Sat, 10 Apr 2004 22:24:29 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404102224.29396.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

acer travelmate 360 has a broken interrupt routing. there's an interrupt storm
on irq 10 w/o this patch  as soon as yenta_socket is loaded. the problem
has been seen on different machines (reported on l-k and on pcmcia-cs
list). there's also an USB controller on the same interrupt line as the CB
which also works fine after the patch. and routing via ACPI fails too.

against 2.6.5


--- 1.36/arch/i386/pci/irq.c	Fri Feb 27 06:48:13 2004
+++ edited/arch/i386/pci/irq.c	Wed Apr  7 22:15:11 2004
@@ -22,6 +22,7 @@
 #define PIRQ_VERSION 0x0100
 
 int broken_hp_bios_irq9;
+int acer_tm360_irqrouting;
 
 static struct irq_routing_table *pirq_table;
 
@@ -745,6 +744,13 @@
 		dev->irq = 11;
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
 		r->set(pirq_router_dev, dev, pirq, 11);
+	}
+
+	/* same for Acer Travelmate 360, but with CB and irq 11 -> 10 */
+	if (acer_tm360_irqrouting && pirq == 0x63 && dev->irq == 11) {
+		dev->irq = 10;
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 10);
+		r->set(pirq_router_dev, dev, pirq, 10);
 	}
 
 	/*
--- 1.56/arch/i386/kernel/dmi_scan.c	Sun Mar 21 06:33:07 2004
+++ edited/arch/i386/kernel/dmi_scan.c	Wed Apr  7 22:19:57 2004
@@ -360,6 +360,22 @@
 }
 
 /*
+ * Work around broken Acer TravelMate 360 Notebooks which assign Cardbus to
+ * IRQ 11 even though it is actually wired to IRQ 10
+ */
+static __init int fix_acer_tm360_irqrouting(struct dmi_blacklist *d)
+{
+#ifdef CONFIG_PCI
+	extern int acer_tm360_irqrouting;
+	if (acer_tm360_irqrouting == 0)
+	{
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
@@ -890,6 +906,13 @@
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
@@ -1028,6 +1051,12 @@
 			MATCH(DMI_BIOS_VERSION, "ASUS A7V ACPI BIOS Revision 1007"),
 			NO_MATCH }},
 
+	{ disable_acpi_pci, "Acer TravelMate 36x Laptop", {
+			MATCH(DMI_SYS_VENDOR, "Acer"),
+			MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
+			NO_MATCH, NO_MATCH
+			} },
+ 
 #endif
 
 	{ NULL, }

