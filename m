Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129409AbRCBSlK>; Fri, 2 Mar 2001 13:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129402AbRCBSlA>; Fri, 2 Mar 2001 13:41:00 -0500
Received: from palrel1.hp.com ([156.153.255.242]:51205 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S129393AbRCBSkr>;
	Fri, 2 Mar 2001 13:40:47 -0500
Message-Id: <200103021843.KAA29619@milano.cup.hp.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IO issues vs. multiple busses 
In-Reply-To: Your message of "Fri, 02 Mar 2001 14:05:08 PST."
             <19350125063652.28310@mailhost.mipsys.com> 
Date: Fri, 02 Mar 2001 10:43:37 -0800
From: Grant Grundler <grundler@cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benjamin,
Here are my comments directly responding to your mail.

Benjamin Herrenschmidt wrote:
> Hi Grant !
> 
> My original mail is:
> 
> Here's the return of an oooold problem for which we really need a
> solution asap since it's now biting us in real life configurations...
> 
> So the problem happens when you have a machine with more than one PCI
> host bridge. This is typically the case of all new Apple machines as they
> have 3 host bridges in one chip (2 of them are relevant: the AGP and the
> PCI). I don't think the problem exist on x86 machines with real IO
> cycles, at least in that case, the problem is different.

Large systems have problems with I/O port space and legacy devices.
There just isn't enough I/O port space to support large configs
and ISA aliasing and all the other crud. That's why Intel is (a)
ditching all the legacy crap in IA64 and (b) strongly encouraging
people to use MMIO space on PCI.


> In order to generate IO cycles, the bridge provides us with a region in
> CPU physical memory space (a 16Mb region in our case) that translates
> accesses to IO cycles on the PCI bus. Our implementation of inb/outb
> currently relies on the kernel ioremap'ing one of these regions (the PCI
> one) and using the ioremap result as a base (offset) inside the inb/outb
> functions.

If you only support one type of bridge, you could avoid the indirect
function call (which parisc-linux uses) and encode the access method
directly in the inb/outb macros.

Just note that processor speed is so much faster (and getter faster)
than the ISA bus (and PCI-1X bus), that CPU overhead is mostly
irrelevant to the cost of accessing IO port space. On older x86
boxes it is relevant.

> So that mean that the current design won't allow access to IOs located on
> any bus but the one we arbitrarily choose (the PCI bus). That's fine in
> most case, until you decide to put a 3dfx or nvidia card in the AGP slot.
> Those cards require some IO accesses to be done to the legacy VGA
> addresses, and of course, our inb/outb functions can't do that.

parisc-linux has solved exactly that problem.

> Obviously, we can hack some driver specific thing that would use the
> arch-specific code to retreive the proper io base address for a given
> host bridge, but that's a hack. I'm looking for a solution that would
> cleanly apply to all archs that may potentially face this problem.

I don't believe such a solution exists which is "cleaner" than
what parisc-linux does and meets the same objectives. Right now,
it's important the install be easy in order to make it easy for
people to migrate from HPUX to parisc-linux. :^)

> The problem potentially exist also for any PCI card that has PCI IOs on
> anything but the main PCI bus. 
> 
> One possibility is to limit our IO space to 64k per bus (to avoid
> bloating) and then use a hacked ioremap to create a single virtually
> contiguous kernel region that appends all those IO spaces together.
> Accessing IOs on bus N would just be the matter of calculating an address
> of the type 64k*N+offset and doing normal inb/outb on the result.

This might work for other arches. I'm pretty sure it won't for parisc.
Again, the issue is the IO port space access method varies by HBA.

> The
> arch PCI code could then properly fixup PCI IO resources for PCI drivers,
> and we could add a function of the kind
>
>  unsigned long pci_bus_io_offset(int busno);
> 
> that would return the offset to add to inb/outb when accessing IOs on the
> N'th PCI bus.

Basically, parisc-linux does that but the arch support hides that
from the device drivers.


> If we want to go a bit further, and allow ISA drivers that don't have a
> pci_dev structure to work on legacy devices on any bus, we could provide
> a set of function of the type
> 
>  int isa_get_bus_count();
>  unsigned long isa_get_bus_io_offset(int busno);
> 
> and eventually
> 
>  int isa_bus_to_pci_bus(int isa_busno);
>  int pci_bus_to_isa_bus(int pci_busno);

I don't like this either.
Reserving bus 0 for E/ISA solves the problem.


> I'm, of course open to any comments about this (in fact, I'd really like
> some feedback). One thing is that we also need to find a way to pass
> those infos to userland. Currently, we implement an arch-specific syscall
> that allow to retreive the IO physical base of a given PCI bus. That may
> be enough, but we may also want something that match more closely what we
> do in the kernel.

I agree with davem on this.

But maybe for different reasons.
The issue with exporting IO port regions is the access method.
Access method varies by platform (for parisc arch) and I don't
want to see user apps encoding the access method for specific platforms
by default. If someone intentionally wants to build an app for a
specific platform, that's different.

grant

Grant Grundler
parisc-linux {PCI|IOMMU|SMP} hacker
+1.408.447.7253
