Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVFUQE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVFUQE5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVFUQE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:04:56 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:46736 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S261682AbVFUQE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:04:28 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Mathieu =?iso-8859-15?q?B=E9rard?= <Mathieu.Berard@crans.org>
Subject: Re: 2.6.12-mm1  irq 21: nobody cared with snd_via82xx
Date: Tue, 21 Jun 2005 10:03:44 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <42B73C04.1010301@crans.org>
In-Reply-To: <42B73C04.1010301@crans.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200506211003.44419.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 June 2005 3:58 pm, Mathieu Bérard wrote:
> I get this while booting linux 2.6.12-mm1 (+ bridge conntrack fix BTW) 
> with a VIA integrated audio ship.
> 
> It worked well at least under 2.6.11-mm1.

Sigh.  Can you reverse the attached patch (apply it with -R)
and see whether it helps?  VIA IRQs are a never-ending headache.


Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date: Tue, 7 Jun 2005 20:22:18 +0000 (-0700)
Source: http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=93cffffa19960464a52f9c78d9a6150270d23785

  [PATCH] PCI: do VIA IRQ fixup always, not just in PIC mode
  
  At least some VIA chipsets require the fixup even in IO-APIC mode.
  
  This was found and debugged with the patient assistance of Stian
  Jordet <liste@jordet.nu> on an Asus CUV266-DLS motherboard.
  
  Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
  Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
  Signed-off-by: Andrew Morton <akpm@osdl.org>
  Signed-off-by: Linus Torvalds <torvalds@osdl.org>

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -460,17 +460,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AM
 
 
 /*
- * Via 686A/B:  The PCI_INTERRUPT_LINE register for the on-chip
- * devices, USB0/1, AC97, MC97, and ACPI, has an unusual feature:
- * when written, it makes an internal connection to the PIC.
- * For these devices, this register is defined to be 4 bits wide.
- * Normally this is fine.  However for IO-APIC motherboards, or
- * non-x86 architectures (yes Via exists on PPC among other places),
- * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
- * interrupts delivered properly.
- */
-
-/*
  * FIXME: it is questionable that quirk_via_acpi
  * is needed.  It shows up as an ISA bridge, and does not
  * support the PCI_INTERRUPT_LINE register at all.  Therefore
@@ -492,28 +481,30 @@ static void __devinit quirk_via_acpi(str
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_3,	quirk_via_acpi );
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_4,	quirk_via_acpi );
 
-static void quirk_via_irqpic(struct pci_dev *dev)
+/*
+ * Via 686A/B:  The PCI_INTERRUPT_LINE register for the on-chip
+ * devices, USB0/1, AC97, MC97, and ACPI, has an unusual feature:
+ * when written, it makes an internal connection to the PIC.
+ * For these devices, this register is defined to be 4 bits wide.
+ * Normally this is fine.  However for IO-APIC motherboards, or
+ * non-x86 architectures (yes Via exists on PPC among other places),
+ * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
+ * interrupts delivered properly.
+ */
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




