Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUBJAD0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 19:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265393AbUBJABi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 19:01:38 -0500
Received: from mail.kroah.org ([65.200.24.183]:54972 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265391AbUBIXW1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:27 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <10763689381296@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:19 -0800
Message-Id: <10763689391232@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.10, 2004/02/02 12:19:50-08:00, dlsy@snoqualmie.dp.intel.com

[PATCH] PCI: Patch to get cpqphp working with IOAPIC

Here is a patch for to get cpqphp working with IOAPIC.
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


 arch/i386/pci/irq.c               |   44 +++++++++++++++++++++++++++++++++++---
 drivers/pci/hotplug/cpqphp_ctrl.c |    4 ++-
 drivers/pci/hotplug/cpqphp_pci.c  |    2 +
 3 files changed, 46 insertions(+), 4 deletions(-)


diff -Nru a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
--- a/arch/i386/pci/irq.c	Mon Feb  9 14:59:09 2004
+++ b/arch/i386/pci/irq.c	Mon Feb  9 14:59:09 2004
@@ -943,12 +943,50 @@
 {
 	u8 pin;
 	extern int interrupt_line_quirk;
+	struct pci_dev *temp_dev;
+
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin && !pcibios_lookup_irq(dev, 1) && !dev->irq) {
 		char *msg;
-		if (io_apic_assign_pci_irqs)
-			msg = " Probably buggy MP table.";
-		else if (pci_probe & PCI_BIOS_IRQ_SCAN)
+		msg = "";
+		if (io_apic_assign_pci_irqs) {
+			int irq;
+
+			if (pin) {
+				pin--;		/* interrupt pins are numbered starting from 1 */
+				irq = IO_APIC_get_PCI_irq_vector(dev->bus->number, PCI_SLOT(dev->devfn), pin);
+				/*
+				 * Busses behind bridges are typically not listed in the MP-table.
+				 * In this case we have to look up the IRQ based on the parent bus,
+				 * parent slot, and pin number. The SMP code detects such bridged
+				 * busses itself so we should get into this branch reliably.
+				 */
+				temp_dev = dev;
+				while (irq < 0 && dev->bus->parent) { /* go back to the bridge */
+					struct pci_dev * bridge = dev->bus->self;
+
+					pin = (pin + PCI_SLOT(dev->devfn)) % 4;
+					irq = IO_APIC_get_PCI_irq_vector(bridge->bus->number, 
+							PCI_SLOT(bridge->devfn), pin);
+					if (irq >= 0)
+						printk(KERN_WARNING "PCI: using PPB(B%d,I%d,P%d) to get irq %d\n", 
+							bridge->bus->number, PCI_SLOT(bridge->devfn), pin, irq);
+					dev = bridge;
+				}
+				dev = temp_dev;
+				if (irq >= 0) {
+#ifdef CONFIG_PCI_USE_VECTOR
+					if (!platform_legacy_irq(irq))
+						irq = IO_APIC_VECTOR(irq);
+#endif
+					printk(KERN_INFO "PCI->APIC IRQ transform: (B%d,I%d,P%d) -> %d\n",
+						dev->bus->number, PCI_SLOT(dev->devfn), pin, irq);
+					dev->irq = irq;
+					return 0;
+				} else
+					msg = " Probably buggy MP table.";
+			}
+		} else if (pci_probe & PCI_BIOS_IRQ_SCAN)
 			msg = "";
 		else
 			msg = " Please try using pci=biosirq.";
diff -Nru a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
--- a/drivers/pci/hotplug/cpqphp_ctrl.c	Mon Feb  9 14:59:09 2004
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c	Mon Feb  9 14:59:09 2004
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
diff -Nru a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
--- a/drivers/pci/hotplug/cpqphp_pci.c	Mon Feb  9 14:59:09 2004
+++ b/drivers/pci/hotplug/cpqphp_pci.c	Mon Feb  9 14:59:09 2004
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

