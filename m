Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965272AbVHPPe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965272AbVHPPe2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 11:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030181AbVHPPe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 11:34:28 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:54970 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965272AbVHPPe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 11:34:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=KJfMs94zT57tTiuyWXGB4TTw6NZM1wXGLyjOhqcZuhYW4JOA1o87f6IIOi6fRXj3if5OuZwtT36ltYq3i286WR8Zw6fRlvcDyq3rIwyWrfEIeciQSHiaEqYn2OsmhQ4T3wzwnYXekMLkk0vrvFpl8l/ed7dnz30irOptYSuZfPI=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH,RFC] quirks for VIA VT8237 southbridge
Date: Tue, 16 Aug 2005 17:26:14 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <200508131710.38569.annabellesgarden@yahoo.de> <200508151631.07717.bjorn.helgaas@hp.com>
In-Reply-To: <200508151631.07717.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200508161726.14149.annabellesgarden@yahoo.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 16. August 2005 00:31 schrieb Bjorn Helgaas:
> These patches seem unrelated except that they both contain the
> text "via", so I think you should at least split them.

Will do.

> This quirk_via_irq() change seems like an awful lot of work to
> get rid of a few log messages.  In my opinion, it's just not
> worth it, because it's so hard to debug problems in that area
> already.

What about the following version?
quirk_via_686irq() only works on pci_devs that are part of the 686.
Sooner or later there'll be more VIA southbridge types, which will
not need quirk_via_irq() like the 8237.

------
/*
 * Via 686A/B:  The PCI_INTERRUPT_LINE register for the on-chip
 * devices, USB0/1, AC97, MC97, and ACPI, has an unusual feature:
 * when written, it makes an internal connection to the PIC.
 * For these devices, this register is defined to be 4 bits wide.
 * Normally this is fine.  However for IO-APIC motherboards, or
 * non-x86 architectures (yes Via exists on PPC among other places),
 * we must mask the PCI_INTERRUPT_LINE value versus 0xf to get
 * interrupts delivered properly.
 */
static void quirk_via_686irq(struct pci_dev *dev)
{
	u8 irq, new_irq;
		/*
		 * The ISA bridge is used to identify the 686.
		 * It shares it's PCI slot and bus with the device under test
		 * and is assigned to function 0.
		 */
	unsigned int isa_bridge_devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 0);
	struct pci_dev * isa_bridge = pci_find_slot(dev->bus->number, isa_bridge_devfn);
		
	if (isa_bridge == NULL || isa_bridge->vendor != PCI_VENDOR_ID_VIA ||
	    isa_bridge->device != PCI_DEVICE_ID_VIA_82C686)
		return;		/* We are not on a 686. Lets leave */

	new_irq = dev->irq & 0xf;
	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
	if (new_irq != irq) {
		printk(KERN_INFO "PCI: Via IRQ fixup for %s, from %d to %d\n",
			pci_name(dev), irq, new_irq);
		udelay(15);	/* unknown if delay really needed */
		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
	} 
}
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_1, quirk_via_686irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, quirk_via_686irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, quirk_via_686irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_686irq);
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_6, quirk_via_686irq);
------

We could also add a "pci_dev * housed_in;" to "struct pci_dev"
to get rid of search done above under pci_find_slot().
To fill in "pci_dev * housed_in;", we'd need another quirk though.

Side note 1: IIRC via82xxx IDE code could also make use of such a "pci_dev * housed_in;"

Side note 2: The members
./include/linux/pci.h:542:	unsigned short vendor_compatible[DEVICE_COUNT_COMPATIBLE];
./include/linux/pci.h:543:	unsigned short device_compatible[DEVICE_COUNT_COMPATIBLE];
of "struct pci_dev" are unused in the current kernel and can vanish.
So a new "pci_dev * housed_in;" in "struct pci_dev" wouldn't add code in the sum.

   Karsten

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
