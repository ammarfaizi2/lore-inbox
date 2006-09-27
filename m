Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031222AbWI0XKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031222AbWI0XKi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 19:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031228AbWI0XKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 19:10:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:17580 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1031225AbWI0XKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 19:10:37 -0400
Subject: Re: +
	msi-refactor-and-move-the-msi-irq_chip-into-the-arch-code.patch added to
	-mm tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ebiederm@xmission.com,
       ak@suse.de, greg@kroah.com, mingo@elte.hu, tglx@linutronix.de,
       tony.luck@intel.com, Michael Ellerman <michaele@au.ibm.com>
In-Reply-To: <20060927.155035.74747595.davem@davemloft.net>
References: <200609272215.k8RMFbuH018967@shell0.pdx.osdl.net>
	 <20060927.155035.74747595.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 09:09:44 +1000
Message-Id: <1159398584.18293.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Eric, thanks so much for doing this work.
> 
> Once this goes in I'll try to add support for MSI on sparc64
> Niagara boxes.  I suppose the PowerPC folks can make use of
> this as well.

Well, it's definitely a great step in the right direction. But I have
some issues with one basic element of the design which is the allocation
of linux irqs being made generic which I can't see how it can apply to
us in any shape or form unfortunately without yet another significant
rework of the ppc interrupt management code (ugh).

We have our allocation mecanism for interrupts, which involves binding
them to a controller among other things. 

Unfortunately, we actually wrote something for MSIs, but Michael didn't
finish yet and didn't post it to lkml yet. We kept the idea of msi_ops
though that isn't necessary (we could hide them in the arch if
necessary) because we need different mecanisms for different busses in
the same machine. We had a pci_get_msi_ops(pdev) provided by the arch
returning the ops for a given device, and the ops callbacks we had were
along the lines of:

 - alloc: allocates linux irqs for MSIs, (on powerpc, that includes
binds them to a controller) and setup the irq_desc / irq_chip for them.
This got passed the array of MSI(X) from the pci_enable_msi/x call (we
use a one entry array for MSI-nonX iirc).

 - setup: returns for one given MSI the address/data to write to the
device. Could be better named I agree as it doesn't actually setup
anything, maybe get_data ?

 - free.

The important thing here is that alloc is arch specific. We don't
absolutely need the msi_ops mecanism exposed generically, it could be
instead something like pcibios_alloc_msis() and pcibios_setup_msi()
etc... and internally, powerpc implementation could use per-bus function
pointers, but the base idea is that allocation is something that is left
to the platform.

Also, another important thing we have to do to be compatible with our
hypervisor based platforms is to have the option of setup being NULL in
the ops (which could also be done differently using a special result
code from alloc). In this case, alloc does everything and is essentially
a re-implementation at the top level of pci_enable_msi(x). We need that
because on IBM PAPR at least, the hypervisor does everything: allocating
hardware vectors, configuring the device, etc... so all the platform
code does is to allocate linux irq numbers and bind them to the vectors
returned by HV.

There are additional "nits" with thus patch as I see it. He puts the
msi_desc in the irq_desc->chip_data. That cannot work for us. MSIs can
be routed in hardware to various chips like the MPIC, the XICS, etc...
and thus their irq_chip (as setup by our alloc callback) will be our
normal MPIC or XICS irq_chips... those controller implementations
already use irq_desc->chip_data for their own use and having the MSI
layer hijack it will just blow things up. (Typically we can have
multiple PIC instances and we put the instance pointer in there).

I think the msi_desc (or whatever data structure that holds the state of
the MSI(X), backup LSI, etc... for one device) shall be hanging off
struct pci_dev instead.

Michael, can you post your current patch somewhere where it can be seen
as an example of our approach ? Even if it is not complete yet in the
sense that we haven't tested it with a backend yet, we were in the
process of doing so...

It should certainly be possible to modify Eric approach to fit our
needs, but that probably involves not having the irq allocation mecanism
made generic.

Cheers,
Ben.

