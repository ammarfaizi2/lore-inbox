Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWGEDsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWGEDsc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 23:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWGEDsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 23:48:32 -0400
Received: from colo.lackof.org ([198.49.126.79]:57797 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S932381AbWGEDsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 23:48:31 -0400
Date: Tue, 4 Jul 2006 21:48:29 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Brice Goglin <brice@myri.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/7] Check root chipset no_msi flag instead of all parent busses flags
Message-ID: <20060705034829.GA19937@colo.lackof.org>
References: <20060703003959.942374000@myri.com> <20060703004055.835863000@myri.com> <20060704070643.GA16632@colo.lackof.org> <44AAF5D9.9040908@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AAF5D9.9040908@myri.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 07:12:25PM -0400, Brice Goglin wrote:
> Grant Grundler wrote:
> > If the "root chipset" is not a PCI device and the architecture doesn't
> > fake it, the root chipset (aka "PCI Host bus controller") is not visible
> > to PCI subsystem. Some of the arch code (e.g. drivers/parisc/dino.c)
> > uses "bus->self == NULL" to differentiate between PCI-PCI secondary busses
> > and PCI bus below a "root chipset". ISTR alpha and sparc doing the same.
> >
> > Can you confirm I'm remembering/understanding this bit correctly?
> >   
> 
> I am not familiar enough with these architectures, but I guess somebody
> else is.

I've looked at alpha PCI code in the past (never changed it)
and wrote nearly all of the parisc PCI support.

> Are MSI working on these architectures?

Not yet. But MSI support on parisc will be a summer project for me.
Alpha and SPARC also use transaction based interrupts to get
the attention of the CPU. So I expect MSI is possible on them.

>  The MSI code in Linux seems to
> be very specific so far. And CONFIG_PCI_MSI currently depends on
> (X86_LOCAL_APIC && X86_IO_APIC) || IA64

I believe PPC folks are also working on support.

> > I don't see how this could work for alpha/parisc/sparc (IIRC) or any other
> > architecture that doesn't create "fake" PCI Root busses.
> > I think your previous patch was correct in this regard.
> 
> I don't think it was better. I had the same loop to find the root
> chipset. Only the check afterwards has been changed: instead of checking
> the subordinate bus flags on the root chipset, I checks its no_msi. Both
> patches applied to these architectures would fail to find the root
> chipset in the while loop. They will find a bridge right under the root
> chipset (or the device itself). The flags are then checked on the bridge
> bus, not on the bus that is right under the root chipset.

Right - the "bridge bus" check is different than a "PCI Host bus controller"
device check.

> Anyway, assuming that Linux supports MSI on any of these architectures
> and that we find a root chipset that does not support MSI, how would we
> blacklist it? There's no way to add a quirk if there is no pci_dev
> associated to this root chipset, right?

Right. parisc/ia64/et al don't need a generic black list.
It's x86 or x86-64 specific.
At least until the various "x86-like" architectures use the same
chipsets.

The arch support _could_ mark a flag in the "root" struct pci_bus.
We wouldn't (yet) need a quirk on those arches.
I think I might have a better idea below to implement parisc support
that works with the MSI flag in struct pci_dev like you want it.

> Assuming we find a place to add some code to disable MSI
> (pcibios_fixup_foo?),

Yes, pcibios_fixup_bus is normally the first chance for the arch
specific code to mangle the struct pci_bus allocated by generic PCI code.

> we would have to set a no_msi flag somewhere.
> It might be good to revive the bus flags for this case. But, that's a lot
> of "assuming", I'd rather know whether all this is possible first :)

MSI is certainly possible on parisc. I'm pretty sure it's possible
on ppc, alpha and sparc though I don't know details. This has been
discussed before...but I can't find the references.

Maybe the right "somewhere" is for pcibios_fixup_bus() to enable
(or disable) MSI on each real PCI device if/when the arch can
determine MSI in fact works.
I didn't think of this option last night.

I still don't want the generic PCI code to assume a "root"
PCI Host bus controller was found after that loop.

thanks,
grant
