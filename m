Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132202AbRAQSMT>; Wed, 17 Jan 2001 13:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132274AbRAQSMJ>; Wed, 17 Jan 2001 13:12:09 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:41231
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132202AbRAQSMC>; Wed, 17 Jan 2001 13:12:02 -0500
Date: Wed, 17 Jan 2001 10:11:15 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Petr Matula <pem@informatics.muni.cz>
cc: Linus Torvalds <torvalds@transmeta.com>,
        "Dunlap, Randy" <randy.dunlap@intel.com>,
        MOLNAR Ingo <mingo@chiara.elte.hu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: int. assignment on SMP + ServerWorks chipset
In-Reply-To: <20010117185047.A13171968@aisa.fi.muni.cz>
Message-ID: <Pine.LNX.4.10.10101171010110.17625-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a interrupt transaction delay imposed on all interrupts of 600ns
spacing.  It can be turned on/off but this may not help.

Cheers,

On Wed, 17 Jan 2001, Petr Matula wrote:

> On Mon, Jan 15, 2001 at 08:49:56PM -0800, Linus Torvalds wrote:
> > So what I _think_ is the correct change is to do roughly this in
> > arch/i386/kernel/pci-irq.c:
> > 
> >  - in pcibios_fixup_irqs(), remove the
> > 
> > 	#idef CONFIG_X86_IO_APIC
> > 		...
> > 	#endif
> > 
> >    section entirely.
> > 
> >  - in pcibios_enable_irq(), at the _end_ (after having enabled the irq
> >    with "pcibios_lookup_irq(dev, 1)", do something like
> > 
> > 	irq = IO_APIC_get_PCI_irq_vector(dev->bus->number, PCI_SLOT(dev->devfn), pin);
> > 	if (irq > 0)
> > 		dev->irq = irq;
> > 
> > and add a LOT of debug printk's, and enable DEBUG in pci-i386.h.
> 
> I did the changes above to 2.4.0 source. 
> Kernel with these changes can't detect my SCSI drive. It prints these messages 
> in cycle:
> SCSI host 0 abort (pid 0) timed out - resetting
> SCSI host is being reset for host 0 channel 0
> SCSI host 0 channel 0 reset (pid 0) timed out - trying harder
> SCSI host is being reset for host 0 channel 0
> 
> Same configuration without changes above detects SCSI drive without problem.
> For completness, made changes are attached.
> 
> Could anybody help?
> 
> Petr
> 
> ---------------------------------------------------------------
>  Petr Matula                                    pem@fi.muni.cz
>                                     http://www.fi.muni.cz/~pem
> ---------------------------------------------------------------
> 

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
