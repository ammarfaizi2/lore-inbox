Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317760AbSFLSot>; Wed, 12 Jun 2002 14:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317762AbSFLSot>; Wed, 12 Jun 2002 14:44:49 -0400
Received: from [209.237.59.50] ([209.237.59.50]:46640 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S317760AbSFLSos>; Wed, 12 Jun 2002 14:44:48 -0400
To: David Brownell <david-b@pacbell.net>
Cc: "David S. Miller" <davem@redhat.com>, benh@kernel.crashing.org,
        linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
In-Reply-To: <20020611.202553.28822742.davem@redhat.com>
	<20020611173347.21348@smtp.adsl.oleane.com>
	<20020612.024224.60294929.davem@redhat.com>
	<3D075739.7010506@pacbell.net>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 12 Jun 2002 11:44:44 -0700
Message-ID: <52zny049r7.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Brownell <david-b@pacbell.net> writes:

    David> Again using USB for an, one _possible_ change would be to
    David> make urb->transfer_buffer be a dma_addr_t ... where today
    David> it's a void*.  (Discussions of such details belong on the
    David> linux-usb-devel list, for the most part.)  That'd be a
    David> pretty major change to the USB API, since it'd force device
    David> drivers to manage DMA mappings.  While usb-storage might
    David> benefit from sglist support, other drivers might not see
    David> much of a win.

Let's go back to the beginning of this discussion since I think we're
losing sight of the original problem.  In general I certainly support
the idea of making the DMA mapping stuff device generic instead of
tied to PCI.  For example, this would really clean up the handling of
on-chip peripherals for some of the PowerPC 4xx CPUs I work with (in
fact on the linuxppc-embedded list there has been discussion about the
abuse of constants like PCI_DMA_FROMDEVICE in contexts that have
nothing to do with PCI).

However, this discussion started when I fixed some problems I was
having with USB on my IBM PowerPC 440GP system (which is not cache
coherent).  I posted a patch to linux-usb-devel that got rid of the
use of unaligned buffers for DMA.  Most of the changes got rid of DMA
into variables on the stack, which everyone agreed were clear bugs.  I
also changed some code that did DMA into the middle of a struct in
kmalloc()'ed memory.  As a concrete example, in drivers/usb/hub.h I
made the change:

 struct usb_hub {
 	struct usb_device *dev;
 
 	struct urb *urb;		/* Interrupt polling pipe */
 
-	char buffer[(USB_MAXCHILDREN + 1 + 7) / 8]; /* add 1 bit for hub status change */
-					/* and add 7 bits to round up to byte boundary */
+        char *buffer;
 	int error;
 	int nerrors;

and then after the kmalloc of struct usb_hub *hub, I added a kmalloc
of hub->buffer.

There were two objections to this change.  First, there were questions
about whether the change was really needed.  I think we have all
agreed that DMA into buffer is not necessarily safe.  Second, people
felt that splitting the allocation of hub in two introduced needless
complication and that it would be better to align buffer within the
structure.  To this end I proposed a __dma_buffer macro; cache
coherent architectures would just do

        #define __dma_buffer

while non-cache-coherent architectures would define

        #define __dma_buffer __dma_buffer_line(__LINE__)
        #define __dma_buffer_line(line) __dma_buffer_expand_line(line)
        #define __dma_buffer_expand_line(line) \
        	__attribute__ ((aligned(L1_CACHE_BYTES))); \
        	char __dma_pad_ ## line [0] __attribute__ ((aligned(L1_CACHE_BYTES)))

Then the USB hub fix would just amount to changing the declaration of
buffer to

	char buffer[(USB_MAXCHILDREN + 1 + 7) / 8] __dma_buffer; /* add 1 bit for hub status change */

and no other code would change.  This seems to me to be pretty close
to the minimal change to make things correct.  You would get zero
bloat on cache coherent architectures, and only one line of code needs
to be touched.  We can debate about whether this puts too much
knowledge about DMA into the driver; I would argue that
device-specific allocators are worse.

The other objection to __dma_buffer seems to be that alignment
requirements can't be calculated at compile time; however this problem
seems to exist for kmalloc() as well (since slab caches have to be
initialized well before every bus is discovered, not to mention the
fact that we might have new alignment requirements coming from
hot-plugged devices).  It seems to me that both kmalloc() and
__dma_buffer both need to align for the worst possible case, and no
one objects to kmalloc().  (Well, you might say that device drivers
should use device specific allocators, but skbuffs and other generic
buffers don't know what device they'll end up at so they need to come
from a generic allocator)

The current USB driver design seems pretty reasonable: only the HCD
drivers need to know about DMA mappings, and other USB drivers just
pass buffer addresses.  I don't think you would get much support for
forcing every driver to handle its own DMA mapping.

I would like to see both dev_map_xxx etc. and something like
__dma_buffer go into the kernel.  I think they both have their uses.

Best,
  Roland
