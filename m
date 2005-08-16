Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbVHPPtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbVHPPtU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 11:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbVHPPtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 11:49:20 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:14534 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1030195AbVHPPtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 11:49:19 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH,RFC] quirks for VIA VT8237 southbridge
Date: Tue, 16 Aug 2005 09:49:10 -0600
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <200508131710.38569.annabellesgarden@yahoo.de> <200508151631.07717.bjorn.helgaas@hp.com> <200508161726.14149.annabellesgarden@yahoo.de>
In-Reply-To: <200508161726.14149.annabellesgarden@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508160949.10607.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 August 2005 9:26 am, Karsten Wiese wrote:
> What about the following version?
> quirk_via_686irq() only works on pci_devs that are part of the 686.
> Sooner or later there'll be more VIA southbridge types, which will
> not need quirk_via_irq() like the 8237.

Do you have VIA spec references to support this?  I had a quick
look, but couldn't find anything specific about which VIA devices
need the quirk and which don't.

As I understand it, you're not making a functional change here,
only getting rid of some messages in the log.  If that's true,
I'm hesitant about making more changes without information from
VIA.

> > ------ 
> /*
>  * Via 686A/B:  The PCI_INTERRUPT_LINE register for the on-chip
>  * devices, USB0/1, AC97, MC97, and ACPI, has an unusual feature:
>  * when written, it makes an internal connection to the PIC.
>  * For these devices, this register is defined to be 4 bits wide.
>  * Normally this is fine.  However for IO-APIC motherboards, or
>  * non-x86 architectures (yes Via exists on PPC among other places),
>  * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
>  * interrupts delivered properly.
>  */
> static void quirk_via_686irq(struct pci_dev *dev)
> {
> 	u8 irq, new_irq;
> 		/*
> 		 * The ISA bridge is used to identify the 686.
> 		 * It shares it's PCI slot and bus with the device under test
> 		 * and is assigned to function 0.
> 		 */
> 	unsigned int isa_bridge_devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 0);
> 	struct pci_dev * isa_bridge = pci_find_slot(dev->bus->number, isa_bridge_devfn);
> 		
> 	if (isa_bridge == NULL || isa_bridge->vendor != PCI_VENDOR_ID_VIA ||
> 	    isa_bridge->device != PCI_DEVICE_ID_VIA_82C686)
> 		return;		/* We are not on a 686. Lets leave */
> 
> 	new_irq = dev->irq & 0xf;
> 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
> 	if (new_irq != irq) {
> 		printk(KERN_INFO "PCI: Via IRQ fixup for %s, from %d to %d\n",
> 			pci_name(dev), irq, new_irq);
> 		udelay(15);	/* unknown if delay really needed */
> 		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
> 	} 
> }
> DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, quirk_via_686irq);
> DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, quirk_via_686irq);
> DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, quirk_via_686irq);
> DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_686irq);
> DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_6, quirk_via_686irq);
