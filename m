Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161030AbWI1GRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbWI1GRl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 02:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161031AbWI1GRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 02:17:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:45489 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161030AbWI1GRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 02:17:40 -0400
Subject: Re: +
	msi-refactor-and-move-the-msi-irq_chip-into-the-arch-code.patch added to
	-mm tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ak@suse.de, greg@kroah.com, mingo@elte.hu,
       tglx@linutronix.de, tony.luck@intel.com,
       Michael Ellerman <michaele@au.ibm.com>
In-Reply-To: <m13bacleum.fsf@ebiederm.dsl.xmission.com>
References: <200609272215.k8RMFbuH018967@shell0.pdx.osdl.net>
	 <20060927.155035.74747595.davem@davemloft.net>
	 <1159398584.18293.101.camel@localhost.localdomain>
	 <m13bacleum.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 16:16:06 +1000
Message-Id: <1159424166.9974.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> My apologies for the conflict.  I had hoped to catch you at OLS so
> I could get a better understanding of how things look in ppc land but
> we never ran into each other.  I also posted a precursor to this design
> with the hypertransport irqs and asked for comments.

No worries. We just both got sidetracked and Michael forgot to send you
his preliminary code... anyway, it's not that fundamentally alien to our
needs. I'm tempted to let Michael finish and push what he has so we have
a solution for 2.6.19 (we have some emergency there) and in a second
step, look into reconciling the 2 approaches.

> > The important thing here is that alloc is arch specific. We don't
> > absolutely need the msi_ops mecanism exposed generically, it could be
> > instead something like pcibios_alloc_msis() and pcibios_setup_msi()
> > etc... and internally, powerpc implementation could use per-bus function
> > pointers, but the base idea is that allocation is something that is left
> > to the platform.
> 
> Sure, and I left it to the architecture, so there should be no problem
> there.

Ok. Good.

> Mostly it looks like to meet your needs more of msi.c needs to be
> turned into library functions that most architectures can use but your
> weird cases on ppc can skip.

Sort-of... We didn't that much use the library model though with our
implementation as I didn't expect alloc to be generic on some archs, but
you are right, it could be made that way. (I sort of assume that all
archs have different means of allocating HW vectors and matching them to
linux IRQs, or at least discovering which linux IRQs are not in
potential use by hardware...).

> I knew there was a hypervisor issue but I don't have enough visibility
> there so I didn't even try. 
> 
> I have a weird concern coming from working with the infinipath driver,
> and that is what happens if someone almost implements msi and puts the
> registers in the wrong location.

Heh... well, our hypervisor is nasty in the sense that it will do
everything, and doesn't give us the choice, on MSI-X, of what individual
MSI-X to enable. Only how many (starting with the first one). That
doesn't quite match the linux API, though looking at how that API is
used, I haven't found somebody requesting a discontiguous range of MSIs
to be enabled ...

> The problem is simply we have 2 irq controllers in play.  The
> one on the chip and the one your the msi is targeted at.  It might
> be easiest to add an extra pointer in struct irq to handle the case
> of irq controllers on plug in devices.

Well, our current approach on PPC hides the "MSI controller" part in the
code for the PIC that receives the MSI. In practice, that works fairly
well because we almost never have to handle different combinations: the
Apple U4's PCIe is always driven by MPIC, the HT controllers (HT2000
typically is what we use) too, thus we just added code to the MPIC
driver to also handle MSI for both types of controllers. The Cell stuff
is separate and just a self-contained cascaded controller itself (the
MSI part), etc...

In some cases (like the HT and Apple PCIe), the MSI logic is comletely
transparent, it's just a small decoder that turns MSI writes to a magic
address or HT interrupts into inputs on the MPIC. Thus the irq_chip is
really only the "standard" MPIC irq_chip... Same with hypervisor, where
they just appear as just some more irqs to the existing virtual IRQ
controller, and thus have the exact same irq_chip... those (at least
MPIC does) need to use the chip_data already for other means.

Thus it's the alloc function which is routed to the appropriate
controller code for a given device, which allocates the low level
hardware vectors, binds them to linux irqs, and sets up an appropriate
irq_desc/irq_chip for it. That's all local to the alloc function, and
those alloc functions are currently provided by PIC code.

> > I think the msi_desc (or whatever data structure that holds the state of
> > the MSI(X), backup LSI, etc... for one device) shall be hanging off
> > struct pci_dev instead.
> 
> That doesn't feel right when you can have up to 4K irqs per device.

Why ? I didn't say it shall be embedded in the pci_dev, but hanging off
it (a pointer).

> Using using the msi_desc array is a reasonable short term solution
> but I am hoping at some point to kill all of the NR_IRQ arrays
> so we can more efficiently have a sparsely populated irq space.
> But I would really like something like a slot I can use in struct
> irq_desc.

Might be useful too yes... I think our current implementation carries a
mapping table of IRQs to pci_dev to get to the pointer in pci_dev iirc
(at least that's how we discussed it a while ago with Michael, I don't
know if he actually followed that). It might be better indeed to just
have a pointer off irq_desc for exclusive use by MSIs ... 

> Sounds good to me.  One small step at a time.  As long as we keep
> things in terms of linux irq numbers in the generic code.  I really
> don't much care.

Yes, we all agree there. Hardware number are not visible to non-arch
code.


> Let's just take this one small step at a time and fix the issues that
> we see and understand well.   All I know is that the original code was
> so horrible that when I replicated the code across 3 different
> architectures the total number of lines went down.

Yes, you work as I said is definitely a good step in the right
direction. I don't think the divergences are that fundamental.

> There are things in that code like msi_lock that I think are totally
> unnecessary but haven't been annoying enough for me to kill.
> 
> I'm just glad things are now close enough people can imagine
> how to go from where we are to where the code needs to be.

Yeah :)

Cheers,
Ben.


