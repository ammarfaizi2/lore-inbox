Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265816AbSL1WLb>; Sat, 28 Dec 2002 17:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265880AbSL1WLa>; Sat, 28 Dec 2002 17:11:30 -0500
Received: from h-64-105-35-45.SNVACAID.covad.net ([64.105.35.45]:62623 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265816AbSL1WL3>; Sat, 28 Dec 2002 17:11:29 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 28 Dec 2002 14:19:38 -0800
Message-Id: <200212282219.OAA02384@adam.yggdrasil.com>
To: david-b@pacbell.net
Subject: Re: [RFT][PATCH] generic device DMA implementation
Cc: James.bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       manfred@colorfulllife.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Odd number of ">" = David Brownell
Even number of ">>" = Adam Richter

>[...] This [DMA mapping operations] needs to work on more than
>just the "platform bus"; "layered busses" shouldn't need special casing,
>they are just as common. 

	It is not necessarily the case that every non-DMA device has
nexactly one DMA device "parent."  You can have SCSI devices that are
multipathed from multiple scsi controllers.  Software RAID devices can
drive multiple controllers.  Some devices have no DMA in their IO
paths, such as some parallel port devices (and, yes, there is a
parallel bus in that you can daisy chain multiple devices off of one
port, each device having a distinct ID).  If drivers are explicit
about which DMA mapped device they are referring to, it will simplify
things like adding support for multipath failover.

	On the other hand, it might be a convenient shorthand be able to
say dma_malloc(usb_device,....) instead of
dma_malloc(usb_device->controller, ...).   It's just that the number of
callers is small enough so that I don't think that the resulting code
shrink would make up for the size of the extra wrapper routines.  So,
I'd rather have more clarity about exactly which device's the DMA
constrains are being used.

	By the way, one idea that I've mentioned before that might
help catch some memory alocation bugs would be a type scheme so that
the compiler could catch some of mistakes, like so:

/* PCI, ISA, sbus, etc. devices embed this instead of struct device: */
struct dma_device {
	u64		dma_mask;
	/* other stuff? */

	struct device	dev;
};

void *dma_malloc(struct dma_device *dma_dev, size_t nbytes,
		 dma_addr_t *dma_addr, unsigned int flags);


	Also, another separate feature that might be handy would be
a new field in struct device.

struct device {
	....
	struct dma_device *dma_dev;
}

	device.dma_dev would point back to the device in the case of PCI,
ISA and other memory mapped devices, and it would point to the host
controller for USB devices, the SCSI host adapter for SCSI devices, etc.
Devices that do fail over might implement device-specific spinlock to
guard access to this field so that it could be changed on the fly.

	So, for example, the high level networking code could embed
could conslidate mapping of outgoing packets by doing something like:

	skbuff->dma_addr = dma_map_single(netdev->dev->dma_dev,
			                  skbuff->data, ...)

	...and that would even work for USB or SCSI ethernet adapters.

	

>You had mentioned SCSI busses; USB, FireWire,
>and others also exist.  (Though I confess I still don't like BUG() as a
>way to fail much of anything!)

	BUG() is generally the optimal way to fail due to programmer
error, as opposed to program error.  You want to catch the bug as
early as possible.  If you have a system where you want to do
something other exiting the current process with a fake SIGSEGV (say
you want to try to invoke a debugger or do a more graceful system call
return), you can redefine BUG() to your liking.  Writing lots of code
to carefully unwind programmer error usually leads to so much more
complexity that the overall effect is a reduction in reliability, and,
besides, you get into an infinite development cycle of trying to
recover from all possible programmer errors in the recovery code, and
then in the recovery code for the recovery code and so on.

>Please look at the 2.5.53 tree with my "usbcore dma updates (and doc)"
>patch, which Greg has now merged and submitted to Linus.

	This looks great.  Notice that you're only doing DMA
operations on usb_device->controller, which is a memory-mapped device
(typically PCI).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
