Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbTISTiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbTISTiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:38:13 -0400
Received: from fmr05.intel.com ([134.134.136.6]:35474 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261708AbTISTiE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:38:04 -0400
Date: Fri, 19 Sep 2003 12:49:27 -0700
From: Dely Sy <dlsy@snoqualmie.dp.intel.com>
Message-Id: <200309191949.h8JJnREv006396@snoqualmie.dp.intel.com>
To: greg@kroah.com, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net
Subject: Patch to get cpqphp working with IOAPIC (2.4.22)
Cc: dely.l.sy@intel.com, tony.luck@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Here is the patch for 2.4.22 to get cpqphp working with IOAPIC. The 
fix is in pcibios_enable_irq().  The reason for this patch is the 
same as that for the patch for 2.6.0-test5, which I sent out on 9/16. 

Thanks,
Dely          


diff -Naur linux-2.4.22/arch/i386/kernel/pci-irq.c linux-2.4.22-php/arch/i386/kernel/pci-irq.c
--- linux-2.4.22/arch/i386/kernel/pci-irq.c	2003-08-25 04:44:39.000000000 -0700
+++ linux-2.4.22-php/arch/i386/kernel/pci-irq.c	2003-09-16 10:17:38.000000000 -0700
@@ -796,9 +796,35 @@
 		if (dev->class >> 8 == PCI_CLASS_STORAGE_IDE && !(dev->class & 0x5))
 			return;
 
-		if (io_apic_assign_pci_irqs)
-			msg = " Probably buggy MP table.";
-		else if (pci_probe & PCI_BIOS_IRQ_SCAN)
+		if (io_apic_assign_pci_irqs) {
+			int irq;
+
+			pin--;		/* interrupt pins are numbered starting from 1 */
+			irq = IO_APIC_get_PCI_irq_vector(dev->bus->number, PCI_SLOT(dev->devfn), pin);
+			/*
+	 		 * Busses behind bridges are typically not listed in the MP-table.
+	 		 * In this case we have to look up the IRQ based on the parent bus,
+	 		 * parent slot, and pin number. The SMP code detects such bridged
+	 		 * busses itself so we should get into this branch reliably.
+	 		 */
+			if (irq < 0 && dev->bus->parent) { /* go back to the bridge */
+				struct pci_dev * bridge = dev->bus->self;
+
+				pin = (pin + PCI_SLOT(dev->devfn)) % 4;
+				irq = IO_APIC_get_PCI_irq_vector(bridge->bus->number, 
+						PCI_SLOT(bridge->devfn), pin);
+				if (irq >= 0)
+					printk(KERN_WARNING "PCI: using PPB(B%d,I%d,P%d) to get irq %d\n", 
+						bridge->bus->number, PCI_SLOT(bridge->devfn), pin, irq);
+			}
+			if (irq >= 0) {
+				printk(KERN_INFO "PCI->APIC IRQ transform: (B%d,I%d,P%d) -> %d\n",
+					dev->bus->number, PCI_SLOT(dev->devfn), pin, irq);
+				dev->irq = irq;
+				return 0;
+			} else
+				msg = " Probably buggy MP table.";
+		} else if (pci_probe & PCI_BIOS_IRQ_SCAN)
 			msg = "";
 		else
 			msg = " Please try using pci=biosirq.";
diff -Naur linux-2.4.22/drivers/hotplug/cpqphp_ctrl.c linux-2.4.22-php/drivers/hotplug/cpqphp_ctrl.c
--- linux-2.4.22/drivers/hotplug/cpqphp_ctrl.c	2003-06-13 07:51:33.000000000 -0700
+++ linux-2.4.22-php/drivers/hotplug/cpqphp_ctrl.c	2003-09-16 10:18:50.000000000 -0700
@@ -2439,7 +2439,7 @@
 				   u8 behind_bridge, struct resource_lists * resources)
 {
 	int cloop;
-	u8 IRQ;
+	u8 IRQ = 0;
 	u8 temp_byte;
 	u8 device;
 	u8 class_code;
@@ -3000,6 +3000,7 @@
 			}
 		}		// End of base register loop
 
+#if !defined(CONFIG_X86_IO_APIC)
 		// Figure out which interrupt pin this function uses
 		rc = pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_INTERRUPT_PIN, &temp_byte);
 
@@ -3025,6 +3026,7 @@
 		// IRQ Line
 		rc = pci_write_config_byte_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_INTERRUPT_LINE, IRQ);
 
+#endif
 		if (!behind_bridge) {
 			rc = cpqhp_set_irq(func->bus, func->device, temp_byte + 0x09, IRQ);
 			if (rc)
diff -Naur linux-2.4.22/drivers/hotplug/cpqphp_pci.c linux-2.4.22-php/drivers/hotplug/cpqphp_pci.c
--- linux-2.4.22/drivers/hotplug/cpqphp_pci.c	2002-11-28 15:53:12.000000000 -0800
+++ linux-2.4.22-php/drivers/hotplug/cpqphp_pci.c	2003-09-16 10:19:22.000000000 -0700
@@ -346,6 +346,7 @@
  */
 int cpqhp_set_irq (u8 bus_num, u8 dev_num, u8 int_pin, u8 irq_num)
 {
+#if !defined(CONFIG_X86_IO_APIC)	
 	int rc;
 	u16 temp_word;
 	struct pci_dev fakedev;
@@ -371,6 +372,7 @@
 	outb((u8) (temp_word & 0xFF), 0x4d0);
 	outb((u8) ((temp_word & 0xFF00) >> 8), 0x4d1);
 
+#endif
 	return 0;
 }
 

