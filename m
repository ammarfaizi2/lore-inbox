Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbULOAS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbULOAS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbULOASn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:18:43 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:7557 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261714AbULNXzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:55:16 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: [PATCH] add legacy I/O and memory access routines to /proc/bus/pci API
Date: Tue, 14 Dec 2004 16:55:04 -0700
User-Agent: KMail/1.7.1
Cc: linux-pci@atrey.karlin.mff.cu, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
References: <200412140941.56116.jbarnes@engr.sgi.com>
In-Reply-To: <200412140941.56116.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412141655.04416.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/proc/bus/pci contains a list of PCI devices available on the system
> +and can be used for driving PCI devices from userspace, getting a list
> +of PCI devices, and hotplug support.  Example:
> +
> +  $ tree /proc/bus/pci
> +  /proc/bus/pci/
> +  |-- 01  directory for devices on bus 1 
> +  |   |-- 01.0  single fn device in slot 1

What about multiple PCI domains?  Should /proc/bus/pci be extended
somehow to deal with them?

HP machines are currently configured to compress all PCI bus numbers
into one domain, but we plan to turn off that compression soon, which
means we'll have duplicate bus numbers in different domains.

> +read
> +  reads from either PCI config space or legacy I/O space, using the
> +  current file postion, depending on the current I/O mode setting.

I think by "legacy I/O space", you mean specifically "legacy
I/O *port* space", right?  Maybe there's no current use for it,
but I can imagine supporting MMIO accesses this way, too.

> +lseek
> +  Can be used to set the current file position.  Note that the file
> +  size is limited to 64k as that's how big legacy I/O space is.

On i386, anyway ;-)  But on ia64, we support multiple 64k I/O port
spaces (one of them being the 0-64K space that corresponds to the
i386 "legacy" space).  Shouldn't we be able to access them with this
interface, too?

> +ioctl
> +  ioctl is used to set the mode of a subsequent read, write or mmap
> +  call.  Available ioctls (in linux/pci.h) include
> +    PCIIOC_CONTROLLER - return PCI domain number
> +    PCIIOC_MMAP_IS_IO - next mmap maps to I/O space
> +    PCIIOC_MMAP_IS_MEM - next mmap maps to memory space
> +    PCIIOC_WRITE_COMBINE - try to use write gathering for the new
> +                           region if the ioctl argument is true,
> +      otherwise disable write gathering
> +    PCIIOC_LEGACY_IO - read/write legacy I/O space if ioctl argument
> +                       is true, otherwise subsequent read/writes will
> +         go to config space

Wouldn't it be nicer to have PCIIOC_{IO,CONFIG_SPACE}?  Then
PCIIOC_MMIO could be added someday.  Using PCIIOC_LEGACY_IO with a
boolean kind of locks you into having only two choices, ever.  (Well,
you could extend the boolean to an int, but the *name* still suggests
an on/off switch.)

> +    PCIIOC_MMAP_IS_LEGACY_MEM - next mmap maps to legacy memory space

I'm always confused about exactly what "legacy memory space" refers
to.  I guess (from below) that it's MMIO space between 0 and 1M?

This seems similar to PCIIOC_MMAP_IS_MEM, except that for MMAP_IS_MEM,
the user-supplied address is a host address that must be in one of the
device's memory resources.  For MMAP_IS_LEGACY_MEM, it looks like you
get a mapping to something in the first megabyte of the memory aperture
that's routed to the device.

So for MMAP_IS_LEGACY_MEM, you have no way of knowing whether the
device will respond to the region you're mapping, right?

The comment on ia64_pci_get_legacy_mem() says we want to map the
first megabyte of bus address space for the device.  But I don't
think we can generate a bus address between 0-1M on any arbitrary
PCI bus.  For example, the MMIO apertures on zx1 are rather small
(on the order of 128-256MB), and we typically map them to non-
overlapping bus address space to make peer-to-peer transactions
possible.

> + /* Do a legacy read of 1 byte (inb) from port 0x3cc */
> + int fd = open("/proc/bus/pci/01/01.0", O_RDONLY);
> + ioctl(fd, PCIIOC_LEGACY_IO, 1); /* enable legacy I/O */
> + lseek(fd, 0x3cc, SEEK_SET);

In this example, the particular device ("01/01.0") you open
makes no difference, right?  The I/O port routing is determined
by the chipset, not by which /proc/bus/pci/... file you open.

HP chipsets allow you to change the routing of VGA-related
MMIO and I/O port space.  X currently twiddles this by hand.
I've always thought there should be an ioctl that says "please
route VGA resources to this PCI device", so X could do this
twiddling in a chipset-independent way.

I'd be interested in seeing the X side of your work, too.
There's currently an ugly mess of figuring out what chipset
we've got, fiddling with VGA routing and soft-fail settings,
etc.  Maybe seeing your X support will help me figure out
how to take advantage of your new kernel hooks to clean
things up for zx1 and sx1000.
