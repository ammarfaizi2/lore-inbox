Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUDLSgD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 14:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbUDLSgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 14:36:02 -0400
Received: from 80-218-57-148.dclient.hispeed.ch ([80.218.57.148]:62981 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S263015AbUDLSft
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 14:35:49 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH 2.4] fix IRQ routing on Acer TravelMate 360
Date: Mon, 12 Apr 2004 20:30:47 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404122030.47958.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi marcelo

the same thing as been included in 2.6.5-mm4. here's the 2.4 version.

rgds
-daniel


---snip---

acer travelmate 360 has a broken interrupt routing. there's an interrupt storm
on irq 10 w/o this patch  as soon as yenta_socket is loaded. the problem
has been seen on different machines (reported on l-k and on pcmcia-cs
list). there's also an USB controller on the same interrupt line as the CB
which also works fine after the patch. and routing via ACPI fails too.



--- 1.43/arch/i386/kernel/dmi_scan.c	Sun Mar 21 05:49:42 2004
+++ edited/arch/i386/kernel/dmi_scan.c	Sat Apr 10 21:59:56 2004
@@ -459,6 +459,23 @@
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
+
+/*
  *	Exploding PnPBIOS. Don't yet know if its the BIOS or us for
  *	some entries
  */
@@ -820,6 +837,12 @@
 			MATCH(DMI_BOARD_VERSION, "OmniBook N32N-736")
 			} },
 
+	{ fix_acer_tm360_irqrouting, "Acer TravelMate 36x Laptop", {
+			MATCH(DMI_SYS_VENDOR, "Acer"),
+			MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
+			NO_MATCH, NO_MATCH
+			} },
+ 
 	/*
 	 *	Generic per vendor APM settings
 	 */
@@ -935,6 +958,13 @@
 			/* newer BIOS, Revision 1011, does work */
 			MATCH(DMI_BIOS_VERSION, "ASUS A7V ACPI BIOS Revision 1007"),
 			NO_MATCH }},
+
+	{ disable_acpi_pci, "Acer TravelMate 36x Laptop", {
+			MATCH(DMI_SYS_VENDOR, "Acer"),
+			MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
+			NO_MATCH, NO_MATCH
+			} },
+ 
 #endif	/* CONFIG_ACPI_PCI */
 
 	{ NULL, }
--- 1.26/arch/i386/kernel/pci-irq.c	Fri Feb 27 06:47:27 2004
+++ edited/arch/i386/kernel/pci-irq.c	Sat Apr 10 21:53:03 2004
@@ -23,6 +23,7 @@
 #define PIRQ_VERSION 0x0100
 
 int broken_hp_bios_irq9;
+int acer_tm360_irqrouting;
 
 static struct irq_routing_table *pirq_table;
 
@@ -892,6 +893,13 @@
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

