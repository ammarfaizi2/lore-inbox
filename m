Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVEaW1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVEaW1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 18:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVEaW0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 18:26:06 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:60653 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261167AbVEaWZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 18:25:50 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Bernd Schubert <bernd-schubert@gmx.de>
Subject: Re: usb/acpi related: irq 11: nobody cared!
Date: Tue, 31 May 2005 16:03:05 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200505282102.16858.bernd-schubert@gmx.de>
In-Reply-To: <200505282102.16858.bernd-schubert@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505311603.05685.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 May 2005 1:02 pm, Bernd Schubert wrote:
> with 2.6.X we need to give pci=noacpi for some mainboards (gigabyte 7DXE) to 
> get usb working. With 2.4.2X this was no issue with those boards. Any ideas?

Can you try 2.6.12-rc5-mm1 + the following patch, please?

--- 2.6.12-rc5-mm1/drivers/pci/quirks.c.orig	2005-05-31 09:42:17.000000000 -0600
+++ 2.6.12-rc5-mm1/drivers/pci/quirks.c	2005-05-31 09:44:07.000000000 -0600
@@ -499,28 +499,20 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi );
 
-static void __devinit quirk_via_irqpic(struct pci_dev *dev)
+static void quirk_via_irq(struct pci_dev *dev)
 {
 	u8 irq, new_irq;
 
-#ifdef CONFIG_X86_IO_APIC
-	if (nr_ioapics && !skip_ioapic_setup)
-		return;
-#endif
-#ifdef CONFIG_ACPI
-	if (acpi_irq_model != ACPI_IRQ_MODEL_PIC)
-		return;
-#endif
 	new_irq = dev->irq & 0xf;
 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
 	if (new_irq != irq) {
-		printk(KERN_INFO "PCI: Via PIC IRQ fixup for %s, from %d to %d\n",
+		printk(KERN_INFO "PCI: Via IRQ fixup for %s, from %d to %d\n",
 			pci_name(dev), irq, new_irq);
 		udelay(15);	/* unknown if delay really needed */
 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
 	}
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irqpic);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
 
 /*
  * PIIX3 USB: We have to disable USB interrupts that are
