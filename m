Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbVCPQLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbVCPQLi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 11:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbVCPQLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 11:11:38 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:8597 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S262663AbVCPQKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 11:10:53 -0500
Subject: Re: [ACPI] Re: Fw: Anybody? 2.6.11 (stable and -rc) ACPI breaks USB
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Grzegorz Kulewski <kangur@polcom.net>, Andrew Morton <akpm@osdl.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, shaohua.li@intel.com,
       Len Brown <len.brown@intel.com>
In-Reply-To: <Pine.LNX.4.61.0503151543420.23036@montezuma.fsmlabs.com>
References: <20050304234622.63e8a335.akpm@osdl.org>
	 <Pine.LNX.4.62.0503110006260.30687@alpha.polcom.net>
	 <1110559685.4822.15.camel@eeyore>
	 <Pine.LNX.4.62.0503112009070.22293@alpha.polcom.net>
	 <1110574599.4822.54.camel@eeyore>
	 <Pine.LNX.4.62.0503112239580.25254@alpha.polcom.net>
	 <1110580150.4822.75.camel@eeyore>
	 <Pine.LNX.4.62.0503131607330.23588@alpha.polcom.net>
	 <1110915355.5917.41.camel@eeyore>
	 <Pine.LNX.4.61.0503151543420.23036@montezuma.fsmlabs.com>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 09:10:36 -0700
Message-Id: <1110989436.8378.19.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-15 at 16:02 -0700, Zwane Mwaikambo wrote:
> On Tue, 15 Mar 2005, Bjorn Helgaas wrote:
> > That seems awfully suspicious to me.  So the following is
> > probably safe as far as it goes, but not sufficient for all
> > cases.
> 
> VIA bridges allow for IRQ routing updates by programming 
> PCI_INTERRUPT_LINE, so it is supposed to work even if we do it for all the 
> devices, so it appears to be a board/bios specific problem.

This just feels like a sledgehammer approach, i.e., we're
programming PCI_INTERRUPT_LINE in more cases that we actually
need to.  I especially don't like that any Via device with
devfn==0 triggers the quirk.  That doesn't seem like the
right test if we're really looking for a Via bridge.

> > -static void __devinit quirk_via_bridge(struct pci_dev *pdev)
> > +static void __devinit quirk_via_irqpic(struct pci_dev *dev)
> >  {
> > -	if(pdev->devfn == 0) {
> > -		printk(KERN_INFO "PCI: Via IRQ fixup\n");
> > -		via_interrupt_line_quirk = 1;
> > +	u8 irq, new_irq = dev->irq & 0xf;
> > +
> > +	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
> > +	if (new_irq != irq) {
> > +		printk(KERN_INFO "PCI: Via IRQ fixup for %s, from %d to %d\n",
> > +			pci_name(dev), irq, new_irq);
> > +		udelay(15);
> > +		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, new_irq);
> >  	}
> >  }
> > -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_ANY_ID,                     quirk_via_bridge );
> > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_2, quirk_via_irqpic);
> > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irqpic);
> > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_6, quirk_via_irqpic);
> > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8233_5,   quirk_via_irqpic);
> > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8233_7,   quirk_via_irqpic);
> 
> This looks like it'll only affect the PCI device associated with the 
> listed south bridges, which might break systems which relied on the per 
> device setting. Your 'debug' patch actually made sense to me, that is, 
> moving the PCI_INTERRUPT_LINE fixup at gsi register.

Yes, that's what I meant by the above probably not being sufficient.

The main thing the debug patch did was to move the write to after
the IOAPIC programming.  (And I think it added back the mysterious
udelay().)  My point is that the write could just as easily be done
in a pci_enable fixup, because that also happens after the IOAPIC
update.

The quirk would have to be something like this:

	static void __devinit quirk_via_irq(struct pci_dev *dev)
	{
		if  (!via_interrupt_line_quirk)
			return;

		/* update PCI_INTERRUPT_LINE */
		...
	}
	DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, quirk_via_irq);

with a PCI_FIXUP_HEADER quirk that sets via_interrupt_line_quirk when
we find a Via bridge.

But I'm uneasy even about this -- what if there are multiple bridges,
with only one of them being a Via?  Why would we want to apply this
quirk to the devices under the non-Via bridges?  Wouldn't it be better
to search up the hierarchy of each device, looking for a Via bridge,
and apply the quirk only if we find one?

