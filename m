Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVD1GiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVD1GiJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 02:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVD1GiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 02:38:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:30689 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261178AbVD1Ghg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 02:37:36 -0400
Subject: Re: pci-sysfs resource mmap broken (and PATCH)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, bjorn.helgaas@hp.com,
       "David S. Miller" <davem@redhat.com>
In-Reply-To: <20050428053311.GH21784@colo.lackof.org>
References: <1114493609.7183.55.camel@gaston>
	 <20050426163042.GE2612@colo.lackof.org> <1114555655.7183.81.camel@gaston>
	 <1114643616.7183.183.camel@gaston> <20050428053311.GH21784@colo.lackof.org>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 16:35:22 +1000
Message-Id: <1114670123.7182.241.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes, I think that is the key issue. It just needs to be "adjusted" for
> whoever the consumer is (e.g X.org) and how they expect to use it.

I think the key issue is that normally (read: programmatically), user
space should not care. It should either peek the value
in /proc/bus/pci/devices and toss that into mmap, or use the "resourceX"
file representing a BAR. The problem still beeing alignement with BARs,
that require a bit more knowledge, most notably that the values are
actually meaningful as some kind of addresses, at least at the sub-page
boundary. (see below, I do mean _alignment_)

The only additional "issue" here, is that for processors with IO
instructions, that value should be able to be tossed directly into those
IO instructions. That is, those platform have a constraint on what this
user value should be for IO space, but that is fine. It's a platform
constraint.

Having it additionally be "meaninful" by itself (ie. a CPU physical
address) is just a matter of your platform wanting to be nice with ppl
debugging things in userland etc... :) Or using occasionally /dev/mem
because they have some existing hackish tools doing so etc... :)
 
> .../..
>
> I think you could have a very interesting conversation with
> Peter about what user driver model needs exported and how
> it could be used.

I would like Peter to show up here and say what he thinks of my
proposal. The current stuff is broken anyway, so I'm considering pushing
this patch for 2.6.12. The patch will have 0 effect on non-ppc unless
non-ppc maintainers decide to push a custom implementation of
pci_resource_to_user() anyway.

> > Additionally, there are a few others issues:
> > 
> >  - mmap'ing resourceX vs. alignment. I have this video card with a bunch
> > of IOs at 0x400, so mmap'ing it will return something that maps the
> > first page of IO space (from 0). The userland program must be able to
> > recalculate the necessary alignement to know that it has to add 0x400 to
> > the mapping obtained via mmap.
> 
> Your description seems to confuse "alignment" with "offset".

No, I don't mean offset (as in within the mmap), but alignment of the
resource itself.

> I would expect the mmap() return value to point at the base of
> whatever thing it is that I handed it. And everything is relative
> to that within the range that I ask be mmap'd.

mmap is defined to always request page alignement, both for arguments
and return value. I suppose we could hack around and have it map the
whole page, then return an offset'ed value, but I'm not sure this is
very good practice to hack the defined semantics of a POSIX call.

> > There is nothing in the API preventing it, that is, the user program
> > can get that via array exposed in
> > "resource" (or rather "resources" as I intend to rename it) ... provided
> > those are really CPU _addresses_ and not some kind of weird tokens
> > (which they are on some archs).
>
> If it's a token, the arch specific mmap() will know how to deal with it.
> parisc does that with IO Port space(s) in the kernel.

Yes and no ... Anyway, I want to provide something "nicer" than this
kernel specific "token" on ppc, via pci_resource_to_user(), and thus
expect something of that kind to come back to me via mmap. In the case
of the above, there is still this alignent/offset problem to deal with
which, imho, requires those "tokens" to at least represent addresses for
the low X bits  (X = PAGE_SHIFT of the arch).

> This is similar to davem's reminder about 32-bit user space on 64-bit
> platform. I expect some form of token will need to be used if user
> space can't be taught/forced to use 64-bit values coming from
> either /sys or /proc. It's probably best to leave /proc untouched
> and only mangle /sys so it always prints 64-bit values.

Well, /proc is broken, and I don't intend to fix it. sysfs is nice
enough to expose 64 bits values in "resource"/"resources" already.

> Can you rename the function to pcibios_resource_to_user() ?

Yes, I can, but I though we were going away from pcibios_* naming ?

> I would like the name to indicate this is an arch specific function
> that should only be used by PCI subsystem.
> Or did you have other in-kernel callers in mind?

Not specifically in mind, no. 

> > 2 - The above pci_resource_to_user() might probably need to be defined
> > as returning a 64 bits value, and for consistency, we should probably
> > always display 64 bits in "resources" to handle the case of 32 bits CPUs
> > with > 32 bits IO space.
> 
> Yes. And an example in Documentation/filesystems/sysfs-pci.txt of
> intended use would probably help alot too.

Yup. Will do.

> > 3 - pci_mmap_page_range() beeing called by both sysfs mmap and proc
> > mmap, we must clarify what it's "offset" parameter really is.
> 
> I didn't know anything about pci_mmap_page_range().
> parisc and alpha don't implement it. And both translate the IO View
> (BAR values) to CPU view (resource) for MMIO space.

Which means that the only way to mmap PCI space is via /dev/mem right ?
In this case, indeed, your resources must be CPU physical addresses.

> > Is it PCI BAR value or is it a CPU physical address?
> > It was defined for the /proc interface, was it ever documented.
> 
> sys-fs support also uses it:

I know it does, that's exactly what I wrote above :) It's used by both,
and I want to make sure it is consistent.

> grundler <533>fgrep HAVE_PCI_MMAP drivers/pci/*
> drivers/pci/pci-sysfs.c:#ifdef HAVE_PCI_MMAP
> drivers/pci/pci-sysfs.c:#else /* !HAVE_PCI_MMAP */
> drivers/pci/pci-sysfs.c:#endif /* HAVE_PCI_MMAP */
> 
> Documentation/filesystems/sysfs-pci.txt at least mentions which
> parameters can be passed to mmap and what the arch must provide.

Yah, well, it's not terribly verbose.

> > I though it wanted a BAR value but
> > Jesse seems to think it wants something out of /proc/bus/pci/devices.
> 
> I agree with Jesse - mmap should want the CPU view of the world.

I tend to agree, which is why I introduce this pci_resource_to_user() to
turn the kernel "tokens" into that (the thing we use for IO space
resources on ppc are really nothing you want to ever see exposed to
userland).

> What is the expected use for the resource number?
> I don't understand what compatibility issue you are trying to avoid.

Matching an entry in "resource" (or "resources" as my patch renames it)
and the resourceX mmap'able file. Since the first one need to be parsed
to figure out the alignement issue, and for other reasons where the user
may be interested (resource flags ? whatever else ..)

Oh well, now that I double check the code, we always display all
resources in order, so that should be ok without a resource number ...
An intermediate version of my patch had pci_resource_to_user() capable
of failing in which case I would have "skipped" the resource. So I
suppose we don't need to change anything to the actual format of
"resource", which means i probably don't need to rename it neither,
though I still don't like the name beeing singular :)

> Somehow, I'm not keen on seeing the resource number there.
> Since all of the resources are printed regardless of value,
> it's easy enough to derive the resource number in case
> someone does need it.

Yes, they are... they weren't with some intermediate patch of mine that
I was toying with, which is why I introduced the resource number, but in
fact, that is not necessary.

> If it's prefetchable, won't the reads/writes automatically be combined?
> Since I equate "prefetchable" == "cacheable", I'd think anything
> is fair game.

No, prefetchable != cacheable. If you mmap your framebuffer cacheable,
good luck with X video drivers & acceleration for example....

However, prefetchable allows use of more relaxed mapping attributes that
don't enforce ordering etc... On ppc, if I map with _PAGE_NOCACHE, I
have the option of also using _PAGE_GUARDED, which enforces ordering,
disable writecombining (on some CPUs at least) and prevents speculative
access (and I suppose prefetch, though I doubt I get much prefetch on
non-cacheable space), or not. In fact, I'd say the opposite ... I have
the option of not setting _PAGE_GUARDED.  I currently do that
transparently for /proc/bus/pci mmap, /sys pci mmap and /dev/mem if it
hits a PCI BAR that is marked prefetchable. Most ppc hardware don't
additionally have separate prefetchable HW ranges (MTRR like thing). 

> Legacy frame buffers want write combining for efficienct use of
> PCI bus bandwidth transferring data to the card. I don't know
> if other devices are as performance sensitive or even want any
> sort of write combining.

Yes, but I think that pretty much fit with the presence of a
prefetchable bit, which typically mean no side effects... it's not
exactly the same concept, but in practice, ti's a good match.

> > Ok, here's the patch for comments. It's really on for comments now, I
> > has some nasty printk's in there, some useless hunks, etc... :)
> > 
> > So don't comment on these please :)
> 
> Ok. :^)
> 
> thanks,
> grant
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

