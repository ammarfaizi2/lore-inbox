Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317499AbSFKS0T>; Tue, 11 Jun 2002 14:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317489AbSFKS0S>; Tue, 11 Jun 2002 14:26:18 -0400
Received: from [209.237.59.50] ([209.237.59.50]:37532 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S317499AbSFKS0K>; Tue, 11 Jun 2002 14:26:10 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: oliver@neukum.name, wjhun@ayrnetworks.com, paulus@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
In-Reply-To: <200206111007.19142.oliver@neukum.name>
	<20020611.011525.29963495.davem@redhat.com>
	<200206111406.14274.oliver@neukum.name>
	<20020611.050433.28184805.davem@redhat.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 11 Jun 2002 11:26:05 -0700
Message-ID: <52y9dl65aa.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

    David> Maybe on arch FOO, target X needs no alignment when using
    David> PCI controller Y, but for PCI controller Z it does need
    David> alignment.

I'm not sure I understand this objection.  kmalloc() is will return a
buffer that is safe for DMA for all controllers.  Any compile-time
static alignment of structure members would similarly do worst-case
alignment.  Also I have to admit that I don't quite understand the
issue you're raising here.  Obviously the CPU's cache line size
doesn't change based on the PCI controller.  Are you referring to PCI
device's CLS register?  I don't see how that could matter since the
bus master shouldn't ever write beyond the buffer the CPU gives it.

In any case, given drivers that have:

        struct something {
                int field1;
                char dma_buffer[SMALLER_THAN_CACHELINE];
                int field2;
        };

        struct something *dev = kmalloc(sizeof *dev, GFP_KERNEL);
        /* do DMA into dev->dma_buffer */

I know of several ways to make this safe:

1) Add a static alignment macro and change the declaration to

        struct something {
                int field1;
                char dma_buffer[SMALLER_THAN_CACHELINE] __dma_buffer;
                int field2;
        };

__dma_buffer would be a NOP on cache coherent architectures (i386,
etc) but might introduce some alignment not strictly necessary on
architectures (???)

2) Change the code to

        struct something {
                int field1;
                char *dma_buffer;
                int field2;
        };

        struct something *dev = kmalloc(sizeof *dev, GFP_KERNEL);
        dev->dma_buffer = kmalloc(SMALLER_THAN_CACHELINE, GFP_KERNEL);
        /* do DMA into dev->dma_buffer */

This always uses strictly more memory than 1) above, complicates the
code, may introduce bugs (do we know if anyone did *dev_copy = *dev
anywhere?).

3) Change the code to

        struct something {
                int field1;
                char *dma_buffer;
                int field2;
        };

        struct something *dev = kmalloc(sizeof *dev, GFP_KERNEL);
        /* find pci_device */
        dev->dma_buffer = aligned_pci_alloc(pci_device, SMALLER_THAN_CACHELINE);
        /* do DMA into dev->dma_buffer */

This may use less memory than 1) or 2) above on some architectures but
will use more than 1) on cache-coherent architectures.  It makes the
code even more complex since now the code that allocates the dma
buffer has to know which PCI device will use it (for example, in USB,
the hub driver is separated from the HCD driver, which is who knows
about the PCI bus).

4) David Woodhouse's suggestion of turning off caching for pages where
unaligned DMA is in progress.  This may be doable but seems quite
complex.  Also, drivers will probably some way of aligning their
buffers to avoid turning of caching, which means that this approach
and the above are complementary.

Best,
  Roland
