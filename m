Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267797AbUHJWvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267797AbUHJWvN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 18:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267799AbUHJWvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 18:51:13 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:52969 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S267797AbUHJWrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 18:47:05 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: 2.6.8-rc4-mm1 doesn't boot
Date: Tue, 10 Aug 2004 16:46:57 -0600
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040810002110.4fd8de07.akpm@osdl.org> <200408100959.18903.bjorn.helgaas@hp.com> <20040810173223.GQ26174@fs.tum.de>
In-Reply-To: <20040810173223.GQ26174@fs.tum.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408101646.57542.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 August 2004 11:32 am, Adrian Bunk wrote:
> On Tue, Aug 10, 2004 at 09:59:18AM -0600, Bjorn Helgaas wrote:
> > On Tuesday 10 August 2004 9:09 am, Adrian Bunk wrote:
> > > 2.6.8-rc3-mm1 boots fine on my computer.
> > > 2.6.8-rc4-mm1 doesn't boot.
> > > 2.6.8-rc4-mm1 with pci=routeirq boots.

I'm confused.  I think the hang is related to IDE, but that
code all looks OK.  I expected to see a note about ACPI routing
the IDE interrupt, something like this:

> SIS5513: IDE controller at PCI slot 0000:00:02.5
  ACPI: PCI interrupt 0000:00:02.5[A] -> GSI XX (level, low) -> IRQ YY
> SIS5513: chipset revision 0

I don't see a path where the IDE device could be found without
that "ACPI: PCI interrupt ..." message being printed.

I also would have expected the hang to occur somewhere after the
"SIS5513: IDE controller at PCI slot 0000:00:02.5" message, but
apparently it happens *before* that.

Can you apply the following patch to 2.6.8-rc4-mm1 and collect all
the kernel output when booting with "pci=routeirq"?  It won't fix
the problem, but maybe it will give me some ideas.



--- 2.6.8-rc4-mm1/arch/i386/pci/common.c.orig	2004-08-10 16:26:07.430867199 -0600
+++ 2.6.8-rc4-mm1/arch/i386/pci/common.c	2004-08-10 16:26:47.012897964 -0600
@@ -247,5 +247,6 @@
 	if ((err = pcibios_enable_resources(dev, mask)) < 0)
 		return err;
 
+	printk("%s: enable IRQ for %s using 0x%p\n", __FUNCTION__, pci_name(dev), pcibios_enable_irq);
 	return pcibios_enable_irq(dev);
 }
--- 2.6.8-rc4-mm1/drivers/acpi/pci_irq.c.orig	2004-08-10 16:34:49.656446739 -0600
+++ 2.6.8-rc4-mm1/drivers/acpi/pci_irq.c	2004-08-10 16:35:33.155469643 -0600
@@ -338,13 +338,13 @@
 	
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (!pin) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No interrupt pin configured for device %s\n", pci_name(dev)));
+		printk("No interrupt pin configured for device %s\n", pci_name(dev));
 		return_VALUE(0);
 	}
 	pin--;
 
 	if (!dev->bus) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid (NULL) 'bus' field\n"));
+		printk("Invalid (NULL) 'bus' field for %s\n", pci_name(dev));
 		return_VALUE(-ENODEV);
 	}
 
--- 2.6.8-rc4-mm1/arch/i386/pci/irq.c.orig	2004-08-10 16:23:45.801962683 -0600
+++ 2.6.8-rc4-mm1/arch/i386/pci/irq.c	2004-08-10 16:42:52.194526765 -0600
@@ -837,7 +837,7 @@
 	struct pci_dev *dev = NULL;
 	u8 pin;
 
-	DBG("PCI: IRQ fixup\n");
+	printk("PCI: IRQ fixup\n");
 	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		/*
 		 * If the BIOS has set an out of range IRQ number, just ignore it.
@@ -953,10 +953,11 @@
 
 static int __init pcibios_irq_init(void)
 {
-	DBG("PCI: IRQ init\n");
 
-	if (pcibios_enable_irq || raw_pci_ops == NULL)
+	if (pcibios_enable_irq || raw_pci_ops == NULL) {
+		printk("PCI: IRQ init returning early\n");
 		return 0;
+	}
 
 	dmi_check_system(pciirq_dmi_table);
 
@@ -966,6 +967,7 @@
 	if (!pirq_table && (pci_probe & PCI_BIOS_IRQ_SCAN))
 		pirq_table = pcibios_get_irq_routing_table();
 #endif
+	printk("PCI: IRQ init pirq_table 0x%p\n", pirq_table);
 	if (pirq_table) {
 		pirq_peer_trick();
 		pirq_find_router(&pirq_router);
@@ -1004,6 +1006,7 @@
 	extern int interrupt_line_quirk;
 	struct pci_dev *temp_dev;
 
+	printk("%s: PCI slot %s\n", __FUNCTION__, pci_name(dev));
 	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (pin && !pcibios_lookup_irq(dev, 1) && !dev->irq) {
 		char *msg;
