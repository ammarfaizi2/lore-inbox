Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267354AbUHDSP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUHDSP2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 14:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267365AbUHDSP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 14:15:28 -0400
Received: from 216-99-218-29.dsl.aracnet.com ([216.99.218.29]:57581 "EHLO
	tabla.groveronline.com") by vger.kernel.org with ESMTP
	id S267354AbUHDSPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 14:15:14 -0400
From: agrover <agrover@groveronline.com>
Date: Wed, 4 Aug 2004 11:14:57 -0700
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] pirq_enable_irq cleanup
Message-ID: <20040804181457.GA30739@groveronline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this should apply cleanly against mm2 or rc3.

This is a cleanup of pirq_enable_irq. I couldn't understand this function easily 
so I cleaned it up.

- Hoisted Via quirk to top -- shouldn't break anything but who knows - can someone 
with this chipset test?

- Hoisted legacy IDE check too.

- Reduced indenting, added comments.

Regards -- Andy

===== arch/i386/pci/irq.c 1.47 vs edited =====
--- 1.47/arch/i386/pci/irq.c	2004-08-02 01:00:43 -07:00
+++ edited/arch/i386/pci/irq.c	2004-08-04 10:15:26 -07:00
@@ -1003,64 +1003,68 @@
 	u8 pin;
 	extern int interrupt_line_quirk;
 	struct pci_dev *temp_dev;
+	char *msg;
+	msg = "";
+
+	/* VIA bridges use interrupt line for apic/pci steering across
+	   the V-Link */
+	if (interrupt_line_quirk)
+		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq & 15);
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-	if (pin && !pcibios_lookup_irq(dev, 1) && !dev->irq) {
-		char *msg;
-		msg = "";
-		if (io_apic_assign_pci_irqs) {
-			int irq;
 
-			if (pin) {
-				pin--;		/* interrupt pins are numbered starting from 1 */
-				irq = IO_APIC_get_PCI_irq_vector(dev->bus->number, PCI_SLOT(dev->devfn), pin);
-				/*
-				 * Busses behind bridges are typically not listed in the MP-table.
-				 * In this case we have to look up the IRQ based on the parent bus,
-				 * parent slot, and pin number. The SMP code detects such bridged
-				 * busses itself so we should get into this branch reliably.
-				 */
-				temp_dev = dev;
-				while (irq < 0 && dev->bus->parent) { /* go back to the bridge */
-					struct pci_dev * bridge = dev->bus->self;
-
-					pin = (pin + PCI_SLOT(dev->devfn)) % 4;
-					irq = IO_APIC_get_PCI_irq_vector(bridge->bus->number, 
-							PCI_SLOT(bridge->devfn), pin);
-					if (irq >= 0)
-						printk(KERN_WARNING "PCI: using PPB(B%d,I%d,P%d) to get irq %d\n", 
-							bridge->bus->number, PCI_SLOT(bridge->devfn), pin, irq);
-					dev = bridge;
-				}
-				dev = temp_dev;
-				if (irq >= 0) {
+	/* No irq for devices that don't need them, like legacy IDE. */
+	if (!pin || (dev->class >> 8 == PCI_CLASS_STORAGE_IDE && !(dev->class & 0x5)))
+		return 0;
+
+	/* Try $PIR table first */
+	if (pcibios_lookup_irq(dev, 1) || dev->irq)
+		return 0;
+
+	/* Next, try MPS */
+	if (io_apic_assign_pci_irqs) {
+		int irq;
+
+		pin--;	/* interrupt pins are numbered starting from 1 */
+		irq = IO_APIC_get_PCI_irq_vector(dev->bus->number, PCI_SLOT(dev->devfn), pin);
+		/*
+		 * Busses behind bridges are typically not listed in the MP-table.
+		 * In this case we have to look up the IRQ based on the parent bus,
+		 * parent slot, and pin number. The SMP code detects such bridged
+		 * busses itself so we should get into this branch reliably.
+		 */
+		temp_dev = dev;
+		while (irq < 0 && dev->bus->parent) { /* go back to the bridge */
+			struct pci_dev * bridge = dev->bus->self;
+
+			pin = (pin + PCI_SLOT(dev->devfn)) % 4;
+			irq = IO_APIC_get_PCI_irq_vector(bridge->bus->number, 
+					PCI_SLOT(bridge->devfn), pin);
+			if (irq >= 0)
+				printk(KERN_WARNING "PCI: using PPB(B%d,I%d,P%d) to get irq %d\n", 
+					bridge->bus->number, PCI_SLOT(bridge->devfn), pin, irq);
+			dev = bridge;
+		}
+		dev = temp_dev;
+		if (irq >= 0) {
 #ifdef CONFIG_PCI_MSI
-					if (!platform_legacy_irq(irq))
-						irq = IO_APIC_VECTOR(irq);
+			if (!platform_legacy_irq(irq))
+				irq = IO_APIC_VECTOR(irq);
 #endif
-					printk(KERN_INFO "PCI->APIC IRQ transform: (B%d,I%d,P%d) -> %d\n",
-						dev->bus->number, PCI_SLOT(dev->devfn), pin, irq);
-					dev->irq = irq;
-					return 0;
-				} else
-					msg = " Probably buggy MP table.";
-			}
-		} else if (pci_probe & PCI_BIOS_IRQ_SCAN)
-			msg = "";
-		else
-			msg = " Please try using pci=biosirq.";
-			
-		/* With IDE legacy devices the IRQ lookup failure is not a problem.. */
-		if (dev->class >> 8 == PCI_CLASS_STORAGE_IDE && !(dev->class & 0x5))
+			printk(KERN_INFO "PCI->APIC IRQ transform: (B%d,I%d,P%d) -> %d\n",
+				dev->bus->number, PCI_SLOT(dev->devfn), pin, irq);
+			dev->irq = irq;
 			return 0;
-			
-		printk(KERN_WARNING "PCI: No IRQ known for interrupt pin %c of device %s.%s\n",
-		       'A' + pin - 1, pci_name(dev), msg);
-	}
-	/* VIA bridges use interrupt line for apic/pci steering across
-	   the V-Link */
-	else if (interrupt_line_quirk)
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq & 15);
+		} else
+			msg = " Probably buggy MP table.";
+	} else if (pci_probe & PCI_BIOS_IRQ_SCAN)
+		msg = "";
+	else
+		msg = " Please try using pci=biosirq.";
+
+	printk(KERN_WARNING "PCI: No IRQ known for interrupt pin %c of device %s.%s\n",
+	       'A' + pin - 1, pci_name(dev), msg);
+
 	return 0;
 }
 

