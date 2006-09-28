Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965280AbWI1Fvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965280AbWI1Fvw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 01:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965286AbWI1Fvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 01:51:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10673 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965280AbWI1Fvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 01:51:51 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ebiederm@xmission.com, ak@suse.de, greg@kroah.com,
       mingo@elte.hu, tglx@linutronix.de, tony.luck@intel.com,
       Michael Ellerman <michaele@au.ibm.com>
Subject: Re: + msi-refactor-and-move-the-msi-irq_chip-into-the-arch-code.patch added to -mm tree
References: <200609272215.k8RMFbuH018967@shell0.pdx.osdl.net>
	<20060927.155035.74747595.davem@davemloft.net>
	<1159398584.18293.101.camel@localhost.localdomain>
Date: Wed, 27 Sep 2006 23:50:09 -0600
In-Reply-To: <1159398584.18293.101.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Thu, 28 Sep 2006 09:09:44 +1000")
Message-ID: <m13bacleum.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

>> Eric, thanks so much for doing this work.
>> 
>> Once this goes in I'll try to add support for MSI on sparc64
>> Niagara boxes.  I suppose the PowerPC folks can make use of
>> this as well.
>
> Well, it's definitely a great step in the right direction. But I have
> some issues with one basic element of the design which is the allocation
> of linux irqs being made generic which I can't see how it can apply to
> us in any shape or form unfortunately without yet another significant
> rework of the ppc interrupt management code (ugh).

So for those architectures where there are not weird ties I think
it makes sense.  One function to allocate a linux irq number and
another function to use it for something.  I just looked and it looks
relatively easy to refactor that part of the code so we do the work
with one architecture call and not too.  Both calls always happen
within close proximity to each other.  So that fact I use two
functions appears to be incidental instead of fundamental. 

> We have our allocation mecanism for interrupts, which involves binding
> them to a controller among other things. 
>
> Unfortunately, we actually wrote something for MSIs, but Michael didn't
> finish yet and didn't post it to lkml yet. We kept the idea of msi_ops
> though that isn't necessary (we could hide them in the arch if
> necessary) because we need different mecanisms for different busses in
> the same machine. We had a pci_get_msi_ops(pdev) provided by the arch
> returning the ops for a given device, and the ops callbacks we had were
> along the lines of:

My apologies for the conflict.  I had hoped to catch you at OLS so
I could get a better understanding of how things look in ppc land but
we never ran into each other.  I also posted a precursor to this design
with the hypertransport irqs and asked for comments.

>  - alloc: allocates linux irqs for MSIs, (on powerpc, that includes
> binds them to a controller) and setup the irq_desc / irq_chip for them.
> This got passed the array of MSI(X) from the pci_enable_msi/x call (we
> use a one entry array for MSI-nonX iirc).
>
>  - setup: returns for one given MSI the address/data to write to the
> device. Could be better named I agree as it doesn't actually setup
> anything, maybe get_data ?
>
>  - free.
>
> The important thing here is that alloc is arch specific. We don't
> absolutely need the msi_ops mecanism exposed generically, it could be
> instead something like pcibios_alloc_msis() and pcibios_setup_msi()
> etc... and internally, powerpc implementation could use per-bus function
> pointers, but the base idea is that allocation is something that is left
> to the platform.

Sure, and I left it to the architecture, so there should be no problem
there.

Mostly it looks like to meet your needs more of msi.c needs to be
turned into library functions that most architectures can use but your
weird cases on ppc can skip.

> Also, another important thing we have to do to be compatible with our
> hypervisor based platforms is to have the option of setup being NULL in
> the ops (which could also be done differently using a special result
> code from alloc). In this case, alloc does everything and is essentially
> a re-implementation at the top level of pci_enable_msi(x). We need that
> because on IBM PAPR at least, the hypervisor does everything: allocating
> hardware vectors, configuring the device, etc... so all the platform
> code does is to allocate linux irq numbers and bind them to the vectors
> returned by HV.

I knew there was a hypervisor issue but I don't have enough visibility
there so I didn't even try. 

I have a weird concern coming from working with the infinipath driver,
and that is what happens if someone almost implements msi and puts the
registers in the wrong location.

> There are additional "nits" with thus patch as I see it. He puts the
> msi_desc in the irq_desc->chip_data. That cannot work for us. MSIs can
> be routed in hardware to various chips like the MPIC, the XICS, etc...
> and thus their irq_chip (as setup by our alloc callback) will be our
> normal MPIC or XICS irq_chips... those controller implementations
> already use irq_desc->chip_data for their own use and having the MSI
> layer hijack it will just blow things up. (Typically we can have
> multiple PIC instances and we put the instance pointer in there).

The problem is simply we have 2 irq controllers in play.  The
one on the chip and the one your the msi is targeted at.  It might
be easiest to add an extra pointer in struct irq to handle the case
of irq controllers on plug in devices.

> I think the msi_desc (or whatever data structure that holds the state of
> the MSI(X), backup LSI, etc... for one device) shall be hanging off
> struct pci_dev instead.

That doesn't feel right when you can have up to 4K irqs per device.
Using using the msi_desc array is a reasonable short term solution
but I am hoping at some point to kill all of the NR_IRQ arrays
so we can more efficiently have a sparsely populated irq space.
But I would really like something like a slot I can use in struct
irq_desc.

> Michael, can you post your current patch somewhere where it can be seen
> as an example of our approach ? Even if it is not complete yet in the
> sense that we haven't tested it with a backend yet, we were in the
> process of doing so...
>
> It should certainly be possible to modify Eric approach to fit our
> needs, but that probably involves not having the irq allocation mecanism
> made generic.

Sounds good to me.  One small step at a time.  As long as we keep
things in terms of linux irq numbers in the generic code.  I really
don't much care.

Let's just take this one small step at a time and fix the issues that
we see and understand well.   All I know is that the original code was
so horrible that when I replicated the code across 3 different
architectures the total number of lines went down.

There are things in that code like msi_lock that I think are totally
unnecessary but haven't been annoying enough for me to kill.

I'm just glad things are now close enough people can imagine
how to go from where we are to where the code needs to be.

Eric
