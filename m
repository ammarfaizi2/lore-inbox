Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263113AbVCDWRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbVCDWRW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263148AbVCDWOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:14:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:42913 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263134AbVCDUyT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:19 -0500
Cc: Mark.Haigh@spirentcom.com
Subject: [PATCH] arch/i386/kernel/pci/irq.c:  Wrong message output
In-Reply-To: <11099696373815@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:57 -0800
Message-Id: <11099696371419@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.14, 2005/02/08 12:22:53-08:00, Mark.Haigh@spirentcom.com

[PATCH] arch/i386/kernel/pci/irq.c:  Wrong message output

The following has been reported in the wild for kernel 2.6.8-24:

PCI: Enabling device 0000:00:05.0 (0000 -> 0002)
PCI: No IRQ known for interrupt pin @ of device 0000:00:05.0. Probably
buggy MP table.

It should read "No IRQ known for interrupt pin A", but the 'pin'
variable has already been decremented (from 1 to 0), so the line:

printk(KERN_WARNING "PCI: No IRQ known for interrupt pin %c of device
%s.%s\n", 'A' + pin - 1, dev->slot_name, msg);

causes "pin @" to be output, because 'A' + 0 - 1 == '@'.

The supplied patch should fix it.  It also removes a redundant check for
a nonzero pin.

Signed-off-by: Mark F. Haigh  <Mark.Haigh@spirentcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 arch/i386/pci/irq.c |   73 +++++++++++++++++++++++++---------------------------
 1 files changed, 36 insertions(+), 37 deletions(-)


diff -Nru a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
--- a/arch/i386/pci/irq.c	2005-03-04 12:42:38 -08:00
+++ b/arch/i386/pci/irq.c	2005-03-04 12:42:38 -08:00
@@ -1031,56 +1031,55 @@
 
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin && !pcibios_lookup_irq(dev, 1) && !dev->irq) {
-		char *msg;
-		msg = "";
+		char *msg = "";
+
+		pin--;		/* interrupt pins are numbered starting from 1 */
+
 		if (io_apic_assign_pci_irqs) {
 			int irq;
 
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
-						printk(KERN_WARNING "PCI: using PPB %s[%c] to get irq %d\n",
-							pci_name(bridge), 'A' + pin, irq);
-					dev = bridge;
-				}
-				dev = temp_dev;
-				if (irq >= 0) {
+			irq = IO_APIC_get_PCI_irq_vector(dev->bus->number, PCI_SLOT(dev->devfn), pin);
+			/*
+			 * Busses behind bridges are typically not listed in the MP-table.
+			 * In this case we have to look up the IRQ based on the parent bus,
+			 * parent slot, and pin number. The SMP code detects such bridged
+			 * busses itself so we should get into this branch reliably.
+			 */
+			temp_dev = dev;
+			while (irq < 0 && dev->bus->parent) { /* go back to the bridge */
+				struct pci_dev * bridge = dev->bus->self;
+
+				pin = (pin + PCI_SLOT(dev->devfn)) % 4;
+				irq = IO_APIC_get_PCI_irq_vector(bridge->bus->number, 
+						PCI_SLOT(bridge->devfn), pin);
+				if (irq >= 0)
+					printk(KERN_WARNING "PCI: using PPB %s[%c] to get irq %d\n",
+						pci_name(bridge), 'A' + pin, irq);
+				dev = bridge;
+			}
+			dev = temp_dev;
+			if (irq >= 0) {
 #ifdef CONFIG_PCI_MSI
-					if (!platform_legacy_irq(irq))
-						irq = IO_APIC_VECTOR(irq);
+				if (!platform_legacy_irq(irq))
+					irq = IO_APIC_VECTOR(irq);
 #endif
-					printk(KERN_INFO "PCI->APIC IRQ transform: %s[%c] -> IRQ %d\n",
-						pci_name(dev), 'A' + pin, irq);
-					dev->irq = irq;
-					return 0;
-				} else
-					msg = " Probably buggy MP table.";
-			}
+				printk(KERN_INFO "PCI->APIC IRQ transform: %s[%c] -> IRQ %d\n",
+					pci_name(dev), 'A' + pin, irq);
+				dev->irq = irq;
+				return 0;
+			} else
+				msg = " Probably buggy MP table.";
 		} else if (pci_probe & PCI_BIOS_IRQ_SCAN)
 			msg = "";
 		else
 			msg = " Please try using pci=biosirq.";
-			
+
 		/* With IDE legacy devices the IRQ lookup failure is not a problem.. */
 		if (dev->class >> 8 == PCI_CLASS_STORAGE_IDE && !(dev->class & 0x5))
 			return 0;
-			
+
 		printk(KERN_WARNING "PCI: No IRQ known for interrupt pin %c of device %s.%s\n",
-		       'A' + pin - 1, pci_name(dev), msg);
+		       'A' + pin, pci_name(dev), msg);
 	}
 	/* VIA bridges use interrupt line for apic/pci steering across
 	   the V-Link */

