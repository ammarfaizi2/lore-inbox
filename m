Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUFXWIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUFXWIF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265760AbUFXWFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:05:46 -0400
Received: from mail.kroah.org ([65.200.24.183]:41398 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265727AbUFXVre convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:47:34 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.7
User-Agent: Mutt/1.5.6i
In-Reply-To: <10881135671308@kroah.com>
Date: Thu, 24 Jun 2004 14:46:07 -0700
Message-Id: <10881135673488@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.103.2, 2004/06/08 14:28:46-07:00, daniel.ritz@gmx.ch

[PATCH] PCI: fix irq routing on acer travelmate 360 laptop

Fixes interrupt routing on acer travelmate 360 notebooks.  it looks like
the bios assigned the wrong pirq value for the cardbus bridge.  just
assigning irq 10 to all devices with pirq 0x63 would break second usb port.
pirq 0x68 seems to be right one for cardbus.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/kernel/dmi_scan.c |   29 +++++++++++++++++++++++++++++
 arch/i386/pci/irq.c         |    9 +++++++++
 2 files changed, 38 insertions(+)


diff -Nru a/arch/i386/kernel/dmi_scan.c b/arch/i386/kernel/dmi_scan.c
--- a/arch/i386/kernel/dmi_scan.c	2004-06-24 13:51:49 -07:00
+++ b/arch/i386/kernel/dmi_scan.c	2004-06-24 13:51:49 -07:00
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
diff -Nru a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
--- a/arch/i386/pci/irq.c	2004-06-24 13:51:49 -07:00
+++ b/arch/i386/pci/irq.c	2004-06-24 13:51:49 -07:00
@@ -23,6 +23,7 @@
 #define PIRQ_VERSION 0x0100
 
 int broken_hp_bios_irq9;
+int acer_tm360_irqrouting;
 
 static struct irq_routing_table *pirq_table;
 
@@ -743,6 +744,14 @@
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

