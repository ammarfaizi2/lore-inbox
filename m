Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267085AbSL3XJ3>; Mon, 30 Dec 2002 18:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267104AbSL3XJ3>; Mon, 30 Dec 2002 18:09:29 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:62970 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S267085AbSL3XJ1>; Mon, 30 Dec 2002 18:09:27 -0500
Date: Mon, 30 Dec 2002 15:23:59 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFT][PATCH] generic device DMA implementation
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: James.bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com
Message-id: <3E10D58F.6010105@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200212282219.OAA02384@adam.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
 > Odd number of ">" = David Brownell
 > Even number of ">>" = Adam Richter

Toggle that one more time ... ;)

 >
 > 	On the other hand, it might be a convenient shorthand be able to
 > say dma_malloc(usb_device,....) instead of
 > dma_malloc(usb_device->controller, ...).   It's just that the number of
 > callers is small enough so that I don't think that the resulting code
 > shrink would make up for the size of the extra wrapper routines.  So,

Since about 2.5.32 that API has been

     void *usb_buffer_alloc(usb_device *, size, mem_flags, dma_addr_t *)

Sure -- when dma_alloc() is available, we should be able to make it
inline completely.  Done correctly it should be an object code shrink.


 > struct device {
 > 	....
 > 	struct dma_device *dma_dev;
 > }
 >
 > 	device.dma_dev would point back to the device in the case of PCI,
 > ISA and other memory mapped devices, and it would point to the host
 > controller for USB devices, the SCSI host adapter for SCSI devices, etc.

With 'dma_device' being pretty much the 'whatsit' I mentioned:  some state
(from platforms that need it, like u64 dma_mask and maybe a list of pci
pools to use with dma_malloc), plus methods basically like James' signatures
from 'struct bus_dma_ops'.

Yes, that'd be something that might be the platform implementation (often
pci, if it doesn't vanish like on x86), something customized (choose dma
paths on the fly) or just BUG() out.


 > 	BUG() is generally the optimal way to fail due to programmer
 > error, as opposed to program error.  You want to catch the bug as
 > early as possible.

I can agree to that in scenarios like relying on DMA ops with hardware
known not to support them.  If it ever happens, there's deep confusion.

But not in the case of generic dma "map this buffer" operations failing
because of issues like temporary resource starvation; or almost any
other temporary allocation failure that appears after the system booted.


 >>Please look at the 2.5.53 tree with my "usbcore dma updates (and doc)"
 >>patch, which Greg has now merged and submitted to Linus.
 >
 > 	This looks great.  Notice that you're only doing DMA
 > operations on usb_device->controller, which is a memory-mapped device
 > (typically PCI).

Actually it isn't necessarily ... some host controllers talk I/O space
using FIFOs for commands and data, rather than memory mapping registers,
shared memory request schedules, and DMAing to/from the kernel buffers.
Linux would want a small tweak to support those controllers; maybe it'd
be as simple as testing whethere there's a dma_whatsit object pointer.

The usb_buffer_*map*() calls could now be inlined, but I thought I'd rather
only leave one copy of all the "don't go through null pointer" checking.
If we ever reduce such checking in USB, those routines would all be
good candidates for turning into inlined calls to dma_*() calls.

- Dave







