Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbULOAXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbULOAXI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbULOAWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:22:16 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:51159 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261740AbULOALh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 19:11:37 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] add legacy I/O and memory access routines to /proc/bus/pci API
Date: Tue, 14 Dec 2004 16:11:32 -0800
User-Agent: KMail/1.7.1
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
References: <200412140941.56116.jbarnes@engr.sgi.com> <200412141655.04416.bjorn.helgaas@hp.com>
In-Reply-To: <200412141655.04416.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412141611.32417.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, December 14, 2004 3:55 pm, Bjorn Helgaas wrote:
> > +/proc/bus/pci contains a list of PCI devices available on the system
> > +and can be used for driving PCI devices from userspace, getting a list
> > +of PCI devices, and hotplug support.  Example:
> > +
> > +  $ tree /proc/bus/pci
> > +  /proc/bus/pci/
> > +  |-- 01  directory for devices on bus 1
> > +  |   |-- 01.0  single fn device in slot 1
>
> What about multiple PCI domains?  Should /proc/bus/pci be extended
> somehow to deal with them?

This might look different on a machine with domains, I ran the tree command on 
a machine /wo them.

> HP machines are currently configured to compress all PCI bus numbers
> into one domain, but we plan to turn off that compression soon, which
> means we'll have duplicate bus numbers in different domains.

Sure, ok.  Domains seem useful in other ways too, so I'm looking forward to 
seeing that.

> > +read
> > +  reads from either PCI config space or legacy I/O space, using the
> > +  current file postion, depending on the current I/O mode setting.
>
> I think by "legacy I/O space", you mean specifically "legacy
> I/O *port* space", right?  Maybe there's no current use for it,
> but I can imagine supporting MMIO accesses this way, too.

Yeah, I could clarify that, legacy memory space is supported via direct mmap.

> > +lseek
> > +  Can be used to set the current file position.  Note that the file
> > +  size is limited to 64k as that's how big legacy I/O space is.
>
> On i386, anyway ;-)  But on ia64, we support multiple 64k I/O port
> spaces (one of them being the 0-64K space that corresponds to the
> i386 "legacy" space).  Shouldn't we be able to access them with this
> interface, too?

Yeah, we could do that, any suggestions?  If I split the ioctl commands into 
PCIIOC_LEGACY_IO and PCIIOC_CONFIG the former could take an argument for the 
domain, would that work?  Then again, isn't having the pci_dev enough?

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

Yeah, proc.c was a little inconsistent here.  Having two separate ioctls is ok 
with me.

> > +    PCIIOC_MMAP_IS_LEGACY_MEM - next mmap maps to legacy memory space
>
> I'm always confused about exactly what "legacy memory space" refers
> to.  I guess (from below) that it's MMIO space between 0 and 1M?

Yep.

> This seems similar to PCIIOC_MMAP_IS_MEM, except that for MMAP_IS_MEM,
> the user-supplied address is a host address that must be in one of the
> device's memory resources.  For MMAP_IS_LEGACY_MEM, it looks like you
> get a mapping to something in the first megabyte of the memory aperture
> that's routed to the device.

Exactly.

> So for MMAP_IS_LEGACY_MEM, you have no way of knowing whether the
> device will respond to the region you're mapping, right?

Correct.

> The comment on ia64_pci_get_legacy_mem() says we want to map the
> first megabyte of bus address space for the device.  But I don't
> think we can generate a bus address between 0-1M on any arbitrary
> PCI bus.  For example, the MMIO apertures on zx1 are rather small
> (on the order of 128-256MB), and we typically map them to non-
> overlapping bus address space to make peer-to-peer transactions
> possible.

Right, you can return -EINVAL or -ENODEV in this case.

> > + /* Do a legacy read of 1 byte (inb) from port 0x3cc */
> > + int fd = open("/proc/bus/pci/01/01.0", O_RDONLY);
> > + ioctl(fd, PCIIOC_LEGACY_IO, 1); /* enable legacy I/O */
> > + lseek(fd, 0x3cc, SEEK_SET);
>
> In this example, the particular device ("01/01.0") you open
> makes no difference, right?  The I/O port routing is determined
> by the chipset, not by which /proc/bus/pci/... file you open.

But the chipset can be programmed to route things correctly or remap the 
correct legacy I/O port domain in the callback routine.

> HP chipsets allow you to change the routing of VGA-related
> MMIO and I/O port space.  X currently twiddles this by hand.
> I've always thought there should be an ioctl that says "please
> route VGA resources to this PCI device", so X could do this
> twiddling in a chipset-independent way.

I think this routine could do that.

> I'd be interested in seeing the X side of your work, too.
> There's currently an ugly mess of figuring out what chipset
> we've got, fiddling with VGA routing and soft-fail settings,
> etc.  Maybe seeing your X support will help me figure out
> how to take advantage of your new kernel hooks to clean
> things up for zx1 and sx1000.

Hopefully we'll be able to post those shortly to xorg@freedesktop.org.  We're 
working through some driver issues atm.

Thanks,
Jesse
