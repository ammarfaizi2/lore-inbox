Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbULOI6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbULOI6K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 03:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbULOI6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 03:58:10 -0500
Received: from gate.crashing.org ([63.228.1.57]:18652 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261807AbULOI5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 03:57:54 -0500
Subject: Re: [PATCH] add legacy I/O and memory access routines to
	/proc/bus/pci API
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-pci@atrey.karlin.mff.cu,
       linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200412141655.04416.bjorn.helgaas@hp.com>
References: <200412140941.56116.jbarnes@engr.sgi.com>
	 <200412141655.04416.bjorn.helgaas@hp.com>
Content-Type: text/plain
Date: Wed, 15 Dec 2004 19:57:37 +1100
Message-Id: <1103101057.6246.19.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What about multiple PCI domains?  Should /proc/bus/pci be extended
> somehow to deal with them?
> 
> HP machines are currently configured to compress all PCI bus numbers
> into one domain, but we plan to turn off that compression soon, which
> means we'll have duplicate bus numbers in different domains.

I do the same kind of thing in ppc32 and want to get rid of it too.

> > +read
> > +  reads from either PCI config space or legacy I/O space, using the
> > +  current file postion, depending on the current I/O mode setting.
> 
> I think by "legacy I/O space", you mean specifically "legacy
> I/O *port* space", right?  Maybe there's no current use for it,
> but I can imagine supporting MMIO accesses this way, too.

Legacy IO ports, there should be one space per PCI domain. There is also
legacy ISA memory space though on some ppc's, this doesn't exist at all.
I suspect we want to expose both in a way.

> > +lseek
> > +  Can be used to set the current file position.  Note that the file
> > +  size is limited to 64k as that's how big legacy I/O space is.
> 
> On i386, anyway ;-)  But on ia64, we support multiple 64k I/O port
> spaces (one of them being the 0-64K space that corresponds to the
> i386 "legacy" space).  Shouldn't we be able to access them with this
> interface, too?

We should imho. On ppc, we have a 64k space per domain. One of the main
set of HW that has use for these are VGA cards. It's perfectly possible
to have a Mac with an AGP card in the AGP port and a PCI video card in
one of hte PCI slots, and those are on 2 different domains with
different legacy (0...64k) IO spaces.

We defininitely want whatever interface we define to deal with that.

> > +ioctl
> > +  ioctl is used to set the mode of a subsequent read, write or mmap
> > +  call.  Available ioctls (in linux/pci.h) include
> > +    PCIIOC_CONTROLLER - return PCI domain number
> > +    PCIIOC_MMAP_IS_IO - next mmap maps to I/O space
> > +    PCIIOC_MMAP_IS_MEM - next mmap maps to memory space
> > +    PCIIOC_WRITE_COMBINE - try to use write gathering for the new
> > +                           region if the ioctl argument is true,
> > +      otherwise disable write gathering
> > +    PCIIOC_LEGACY_IO - read/write legacy I/O space if ioctl argument
> > +                       is true, otherwise subsequent read/writes will
> > +         go to config space
> 
> Wouldn't it be nicer to have PCIIOC_{IO,CONFIG_SPACE}?  Then
> PCIIOC_MMIO could be added someday.  Using PCIIOC_LEGACY_IO with a
> boolean kind of locks you into having only two choices, ever.  (Well,
> you could extend the boolean to an int, but the *name* still suggests
> an on/off switch.)

That and legacy memory space, which we may want to mmap as well in a
more portable way than there is now (for platforms where it is
available).

> > +    PCIIOC_MMAP_IS_LEGACY_MEM - next mmap maps to legacy memory space
> 
> I'm always confused about exactly what "legacy memory space" refers
> to.  I guess (from below) that it's MMIO space between 0 and 1M?

I think so, it's an ISA thing, but some video and token ring cards, for
example, still rely on it. Not all host bridges on non-x86 are able to
generate PCI MMIO cycles in that range though. Some do provide a special
window for this tho.

> This seems similar to PCIIOC_MMAP_IS_MEM, except that for MMAP_IS_MEM,
> the user-supplied address is a host address that must be in one of the
> device's memory resources.  For MMAP_IS_LEGACY_MEM, it looks like you
> get a mapping to something in the first megabyte of the memory aperture
> that's routed to the device.
> 
> So for MMAP_IS_LEGACY_MEM, you have no way of knowing whether the
> device will respond to the region you're mapping, right?

Usually, you know the device will before using it. Like using the VGA
memory space on a VGA card etc...

> The comment on ia64_pci_get_legacy_mem() says we want to map the
> first megabyte of bus address space for the device.  But I don't
> think we can generate a bus address between 0-1M on any arbitrary
> PCI bus.  For example, the MMIO apertures on zx1 are rather small
> (on the order of 128-256MB), and we typically map them to non-
> overlapping bus address space to make peer-to-peer transactions
> possible.

Yes, not all bridges allow generations of those cycles, but it's useful
to have an interface letting things like X map this space in a proper
way that can also deal with domains etc... for platforms where this
space exists.

> > + /* Do a legacy read of 1 byte (inb) from port 0x3cc */
> > + int fd = open("/proc/bus/pci/01/01.0", O_RDONLY);
> > + ioctl(fd, PCIIOC_LEGACY_IO, 1); /* enable legacy I/O */
> > + lseek(fd, 0x3cc, SEEK_SET);
> 
> In this example, the particular device ("01/01.0") you open
> makes no difference, right?  The I/O port routing is determined
> by the chipset, not by which /proc/bus/pci/... file you open.
> 
> HP chipsets allow you to change the routing of VGA-related
> MMIO and I/O port space.  X currently twiddles this by hand.
> I've always thought there should be an ioctl that says "please
> route VGA resources to this PCI device", so X could do this
> twiddling in a chipset-independent way.

There is some work done by Jon Smirl in this area (a VGA access
arbitration driver).

> I'd be interested in seeing the X side of your work, too.
> There's currently an ugly mess of figuring out what chipset
> we've got, fiddling with VGA routing and soft-fail settings,
> etc.  Maybe seeing your X support will help me figure out
> how to take advantage of your new kernel hooks to clean
> things up for zx1 and sx1000.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

