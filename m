Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130633AbRAPEut>; Mon, 15 Jan 2001 23:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130676AbRAPEuj>; Mon, 15 Jan 2001 23:50:39 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:35344 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130633AbRAPEuc>; Mon, 15 Jan 2001 23:50:32 -0500
Date: Mon, 15 Jan 2001 20:49:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Dunlap, Randy" <randy.dunlap@intel.com>
cc: pem@informatics.muni.cz, MOLNAR Ingo <mingo@chiara.elte.hu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: int. assignment on SMP + ServerWorks chipset
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDF24@orsmsx31.jf.intel.com>
Message-ID: <Pine.LNX.4.10.10101152031110.12667-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Jan 2001, Dunlap, Randy wrote:
> 
> Thanks for looking into this.  I'll be out of touch for
> the rest of this week, but Petr (pem@informatics.muni.cz)
> should be able to test patches that Ingo comes up with.
> 
> > Ok. That means that the problem is that we _should_ look at 
> > the pirq table even if we use the IO-APIC.
> 
> How do we know when to do this?

It's kind of nasty. The IO-APIC detection will disable the pirq table
stuff, see pci-irq.c:

                /* If we're using the I/O APIC, avoid using the PCI IRQ routing table */
                if (io_apic_assign_pci_irqs)
                        pirq_table = NULL;

now, you could just remove that logic, but I suspect that you'd get
problems simply because the interrupt will then get routing information,
but either the IO-APIC re-naming logic has already moved the irq and it
will be routed to the wrong entry.

So what I _think_ is the correct change is to do roughly this in
arch/i386/kernel/pci-irq.c:

 - in pcibios_fixup_irqs(), remove the

	#idef CONFIG_X86_IO_APIC
		...
	#endif

   section entirely.

 - in pcibios_enable_irq(), at the _end_ (after having enabled the irq
   with "pcibios_lookup_irq(dev, 1)", do something like

	irq = IO_APIC_get_PCI_irq_vector(dev->bus->number, PCI_SLOT(dev->devfn), pin);
	if (irq > 0)
		dev->irq = irq;

and add a LOT of debug printk's, and enable DEBUG in pci-i386.h.

It probably won't work on the first try (even if I explained the above
well enough), so send me and Ingo dmesg output, and maybe we'll figure out
something.

And if anybody else understands pirq routing, speak up. It's a black art.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
