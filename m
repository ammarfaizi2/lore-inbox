Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTIPRza (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 13:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTIPRza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 13:55:30 -0400
Received: from fmr06.intel.com ([134.134.136.7]:53699 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261965AbTIPRz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 13:55:27 -0400
Date: Tue, 16 Sep 2003 08:50:24 -0700
From: Dely Sy <dlsy@snoqualmie.dp.intel.com>
Message-Id: <200309161550.h8GFoO2X003176@snoqualmie.dp.intel.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       greg@kroah.com
Subject: Patch to get cpqphp working with IOAPIC (2.6.0-test5)
Cc: dely.l.sy@intel.com, tony.luck@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a patch for 2.6.0-test5 to get cpqphp working with IOAPIC. 
My earlier statement that a kernel patch is not needed for 2.6 is 
true only when ACPI is enabled.  A similar patch is needed in 
pcibios_enable_irq() for 2.4 kernel and I will send it out 
later.

The fix is in pirq_enable_irq().  This function is called indirectly
by pci_enable_device().  For device present during boot up, it should 
get the proper dev->irq for pcibios_fixup_irqs() has been called to 
get the dev->irq from MP table. If the value is still zero, then 
this is properly caused by "buggy MP table".  For hot-plug device, 
its dev->irq is 0 when the pci_enable_device() is called for it hasn't 
gone through the fixup.  Therefore, the code (similiar to the code 
in pcibios_fixup_irqs) is needed here.

Thanks,
Dely          


diff -Naur linux-2.6.0-test5/arch/i386/pci/irq.c linux-2.6.0-test5php/arch/i386/pci/irq.c
--- linux-2.6.0-test5/arch/i386/pci/irq.c	2003-09-08 12:50:43.000000000 -0700
+++ linux-2.6.0-test5php/arch/i386/pci/irq.c	2003-09-16 01:00:13.000000000 -0700
@@ -812,9 +812,36 @@
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin && !pcibios_lookup_irq(dev, 1) && !dev->irq) {
 		char *msg;
-		if (io_apic_assign_pci_irqs)
-			msg = " Probably buggy MP table.";
-		else if (pci_probe & PCI_BIOS_IRQ_SCAN)
+		if (io_apic_assign_pci_irqs) {
+			int irq;
+			
+			pin--;		/* interrupt pins are numbered starting from 1 */
+			irq = IO_APIC_get_PCI_irq_vector(dev->bus->number, PCI_SLOT(dev->devfn), pin);
+			/*
+			 * Busses behind bridges are typically not listed in the MP-table.
+			 * In this case we have to look up the IRQ based on the parent bus,
+			 * parent slot, and pin number. The SMP code detects such bridged
+			 * busses itself so we should get into this branch reliably.
+			 */
+			if (irq < 0 && dev->bus->parent) { /* go back to the bridge */
+				struct pci_dev * bridge = dev->bus->self;
+
+				pin = (pin + PCI_SLOT(dev->devfn)) % 4;
+				irq = IO_APIC_get_PCI_irq_vector(bridge->bus->number, 
+						PCI_SLOT(bridge->devfn), pin);
+				if (irq >= 0) {
+					printk(KERN_WARNING "PCI: using PPB(B%d,I%d,P%d) to get irq %d\n", 
+						bridge->bus->number, PCI_SLOT(bridge->devfn), pin, irq);
+				}	
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
diff -Naur linux-2.6.0-test5/drivers/pci/hotplug/cpqphp_ctrl.c linux-2.6.0-test5php/drivers/pci/hotplug/cpqphp_ctrl.c
--- linux-2.6.0-test5/drivers/pci/hotplug/cpqphp_ctrl.c	2003-09-08 12:50:01.000000000 -0700
+++ linux-2.6.0-test5php/drivers/pci/hotplug/cpqphp_ctrl.c	2003-09-15 14:37:41.000000000 -0700
@@ -2446,7 +2446,7 @@
 				   u8 behind_bridge, struct resource_lists * resources)
 {
 	int cloop;
-	u8 IRQ;
+	u8 IRQ = 0;
 	u8 temp_byte;
 	u8 device;
 	u8 class_code;
@@ -3021,6 +3021,7 @@
 			}
 		}		// End of base register loop
 
+#if !defined(CONFIG_X86_IO_APIC)
 		// Figure out which interrupt pin this function uses
 		rc = pci_bus_read_config_byte (pci_bus, devfn, PCI_INTERRUPT_PIN, &temp_byte);
 
@@ -3045,6 +3046,7 @@
 
 		// IRQ Line
 		rc = pci_bus_write_config_byte (pci_bus, devfn, PCI_INTERRUPT_LINE, IRQ);
+#endif
 
 		if (!behind_bridge) {
 			rc = cpqhp_set_irq(func->bus, func->device, temp_byte + 0x09, IRQ);
diff -Naur linux-2.6.0-test5/drivers/pci/hotplug/cpqphp_pci.c linux-2.6.0-test5php/drivers/pci/hotplug/cpqphp_pci.c
--- linux-2.6.0-test5/drivers/pci/hotplug/cpqphp_pci.c	2003-09-08 12:50:29.000000000 -0700
+++ linux-2.6.0-test5php/drivers/pci/hotplug/cpqphp_pci.c	2003-09-15 14:38:27.000000000 -0700
@@ -151,6 +151,7 @@
  */
 int cpqhp_set_irq (u8 bus_num, u8 dev_num, u8 int_pin, u8 irq_num)
 {
+#if !defined(CONFIG_X86_IO_APIC)	
 	int rc;
 	u16 temp_word;
 	struct pci_dev fakedev;
@@ -175,6 +176,7 @@
 	// This should only be for x86 as it sets the Edge Level Control Register
 	outb((u8) (temp_word & 0xFF), 0x4d0);
 	outb((u8) ((temp_word & 0xFF00) >> 8), 0x4d1);
+#endif
 
 	return 0;
 }

