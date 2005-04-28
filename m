Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVD1FbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVD1FbL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 01:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVD1FbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 01:31:11 -0400
Received: from colo.lackof.org ([198.49.126.79]:7561 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262015AbVD1Fao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 01:30:44 -0400
Date: Wed, 27 Apr 2005 23:33:11 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, bjorn.helgaas@hp.com,
       "David S. Miller" <davem@redhat.com>
Subject: Re: pci-sysfs resource mmap broken (and PATCH)
Message-ID: <20050428053311.GH21784@colo.lackof.org>
References: <1114493609.7183.55.camel@gaston> <20050426163042.GE2612@colo.lackof.org> <1114555655.7183.81.camel@gaston> <1114643616.7183.183.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114643616.7183.183.camel@gaston>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 09:13:36AM +1000, Benjamin Herrenschmidt wrote:
> (RESENT: Not sure it actually made it yesterday, sorry if you got it twice)

np - got the previous one too...just needed some time to think about it
and write a not-too-long response.

> > No. I don't agree. userspace has no business understanding the kernel
> > resources content. All userspace need to care about is the resource
> > number, and _eventually_ match it to a BAR value (either for using the
> > old /proc interface -> existing code, or to use it with real inx/outx
> > instructions on x86).
> 
> Ok, let me correct myself here... I think you _are_ right, but I also
> think that pci_dev->resource[] is _not_ a CPU address that can be
> exposed to userland, it's is a kernel internal "cookie" whose meaning is
> arch specific.
> 
> What we need here is a way to go from pci_dev->resource to some CPU
> address (typically in most archs that would result in something that can
> be fed through /dev/mem, though that is just an example, doing so is
> definitely not recommended :)

Yes, I think that is the key issue. It just needs to be "adjusted" for
whoever the consumer is (e.g X.org) and how they expect to use it.

In practice, I have used mmap'd (uncached) address space to
access chipset registers from user space. Very easy to test
different parameters which is what I needed for my OLS 2003 paper:
	http://iou.parisc-linux.org/dma-hints/

Hypothetically, such "platform specific tuning" could be done
from userspace if it doesn't require special syncronization
or a reboot.

My use was a much simpler use than the User Space drivers work
done by Peter Chubb at UNSW:
	http://www.gelato.unsw.edu.au/publications.html

I think you could have a very interesting conversation with
Peter about what user driver model needs exported and how
it could be used.

> Additionally, there are a few others issues:
> 
>  - mmap'ing resourceX vs. alignment. I have this video card with a bunch
> of IOs at 0x400, so mmap'ing it will return something that maps the
> first page of IO space (from 0). The userland program must be able to
> recalculate the necessary alignement to know that it has to add 0x400 to
> the mapping obtained via mmap.

Your description seems to confuse "alignment" with "offset".

I would expect the mmap() return value to point at the base of
whatever thing it is that I handed it. And everything is relative
to that within the range that I ask be mmap'd.

> There is nothing in the API preventing it, that is, the user program
> can get that via array exposed in
> "resource" (or rather "resources" as I intend to rename it) ... provided
> those are really CPU _addresses_ and not some kind of weird tokens
> (which they are on some archs).

If it's a token, the arch specific mmap() will know how to deal with it.
parisc does that with IO Port space(s) in the kernel.

>  In the case of IO space, there is the
> additional requirement of actually knowing the real IO address for use
> with inX/outX instructions on architectures that have those.
>
>  - What about architectures that have 32 bits core but > 32 bits
> physical address space, like ppc32 with 440 or e500 processors where
> IO/MMIO space is above 4gb ? The proper fix here is to have struct
> resource to be 64 bits fields but we aren't there ...

This is similar to davem's reminder about 32-bit user space on 64-bit
platform. I expect some form of token will need to be used if user
space can't be taught/forced to use 64-bit values coming from
either /sys or /proc. It's probably best to leave /proc untouched
and only mangle /sys so it always prints 64-bit values.


>  - What is supposed to be passed to /proc/bus/pci mmap ? Should it be a
> BAR value or the output of /proc/bus/pci/devices ? In the later case,
> well, we are exposing the same crap as sysfs, that is a raw kernel
> struct resource, which doesn't make sense out of the kernel. So I'm
> tempted to "fix" /proc/bus/pci/devices the same way (see below) that I'm
> fixing /sys/bus/pci/*/resources to pass a CPU physical address. (this
> will only affect ppc[64] or other archs using my new callback anyway).
> 
> So what do that mean in practice ? Well, a few things :
> 
> 1 - As described above, we need a kind of pci_resource_to_user() arch
> hook so that struct resource can be converted in something that makes
> sense to userland, typically a CPU physical address. It would be easy to
> have a default implementation just using the resource "as-is" as it does
> today, so we only have to fixup archs for which the value in there is
> meaningless outside of the kernel (typically, ppc & ppc64 for IO
> resources)


Can you rename the function to pcibios_resource_to_user() ?

I would like the name to indicate this is an arch specific function
that should only be used by PCI subsystem.
Or did you have other in-kernel callers in mind?


> 2 - The above pci_resource_to_user() might probably need to be defined
> as returning a 64 bits value, and for consistency, we should probably
> always display 64 bits in "resources" to handle the case of 32 bits CPUs
> with > 32 bits IO space.

Yes. And an example in Documentation/filesystems/sysfs-pci.txt of
intended use would probably help alot too.

> 3 - pci_mmap_page_range() beeing called by both sysfs mmap and proc
> mmap, we must clarify what it's "offset" parameter really is.

I didn't know anything about pci_mmap_page_range().
parisc and alpha don't implement it. And both translate the IO View
(BAR values) to CPU view (resource) for MMIO space.

> Is it PCI BAR value or is it a CPU physical address?
> It was defined for the /proc interface, was it ever documented.

sys-fs support also uses it:

grundler <533>fgrep HAVE_PCI_MMAP drivers/pci/*
drivers/pci/pci-sysfs.c:#ifdef HAVE_PCI_MMAP
drivers/pci/pci-sysfs.c:#else /* !HAVE_PCI_MMAP */
drivers/pci/pci-sysfs.c:#endif /* HAVE_PCI_MMAP */

Documentation/filesystems/sysfs-pci.txt at least mentions which
parameters can be passed to mmap and what the arch must provide.

> I though it wanted a BAR value but
> Jesse seems to think it wants something out of /proc/bus/pci/devices.

I agree with Jesse - mmap should want the CPU view of the world.

> The former would mean that either pci-sysfs.c must "convert" the offset
> to a BAR value before calling pci_mmap_page_range(), or we must define a
> different interface since they are non-consistent, but the later means
> they are consistant (which is cool). In both case, current ppc
> implementation is broken.
> 
> 4 - additionally, to avoid future compatibility issues, I added the
> resource number to the output of /sys/bus/pci/*/resources

What is the expected use for the resource number?
I don't understand what compatibility issue you are trying to avoid.

Somehow, I'm not keen on seeing the resource number there.
Since all of the resources are printed regardless of value,
it's easy enough to derive the resource number in case
someone does need it.

> The patch below implements this, with 1 - defaulting to just using the
> resource as-is, plus a pair of imlpementations for ppc and ppc64, with 2
> - returning an u64, and with 3 - taking the approach that /proc/bus/pci
> expects offsets from /proc/bus/pci/devices (and not BAR values), that
> means the interface stays consistent between proc and sysfs (pfiew !)

Yes - that would be good.

> Additional misc question: The new interface doesn't allow to pass in any
> "write combine" parametre like /proc did. In fact, this paremeter was a
> bit limitative, since archs tend to be more varied when it comes to
> relaxed ordering. On ppc & ppc64, I only use this as a hint, and the
> pci_mmap_page_range() implementation (and /dev/mem too, so X benefits
> from it) will in fact use the "prefetchable" attribute of the device
> resource to decide wetehr to mark the space "guarded" or not. "guarded"
> is a PPC specific attribute that disable things like speculation, but in
> practice, also seem to disable write combining on some CPUs. I was
> wondering wether it would make sense to haev pci-sysfs.c pass 1 for
> write_combine when the resource beeing mapped has the prefetchable bit ?

If it's prefetchable, won't the reads/writes automatically be combined?
Since I equate "prefetchable" == "cacheable", I'd think anything
is fair game.

Legacy frame buffers want write combining for efficienct use of
PCI bus bandwidth transferring data to the card. I don't know
if other devices are as performance sensitive or even want any
sort of write combining.

> Ok, here's the patch for comments. It's really on for comments now, I
> has some nasty printk's in there, some useless hunks, etc... :)
> 
> So don't comment on these please :)

Ok. :^)

thanks,
grant
