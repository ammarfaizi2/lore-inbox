Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315784AbSFJTD1>; Mon, 10 Jun 2002 15:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315785AbSFJTD0>; Mon, 10 Jun 2002 15:03:26 -0400
Received: from [209.237.59.50] ([209.237.59.50]:38451 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S315784AbSFJTDX>; Mon, 10 Jun 2002 15:03:23 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: Oliver Neukum <oliver@neukum.name>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
In-Reply-To: <52d6v19r9n.fsf@topspin.com> <523cvv9laj.fsf@topspin.com>
	<20020610170309.GC14252@opus.bloom.county>
	<200206101922.26985.oliver@neukum.name>
	<20020610172909.GE14252@opus.bloom.county>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 10 Jun 2002 12:03:19 -0700
Message-ID: <52ptyz7y88.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:

    Tom> No.  We should just make it come out to a nop for arches that
    Tom> don't need it.  Otherwise we'll end up with ugly things like:
    Tom> #ifdef CONFIG_NOT_CACHE_COHERENT ...  #else ...  #endif
    Tom> All over things like USB...

Good point.  How about the following: add a file to each arch named
say, <asm/dma_buffer.h>, that defines a macro __dma_buffer.  This
macro would be used as follows to mark DMA buffers (example taken from
<linux/usb.h>):

struct usb_device {
        /* ... stuff deleted ... */

	struct usb_bus *bus;		/* Bus we're part of */

	struct usb_device_descriptor descriptor __dma_buffer; /* Descriptor */
	struct usb_config_descriptor *config;	/* All of the configs */

        /* ... more stuff deleted ... */
};

Then cache-coherent architectures like i386 can just do

#define __dma_buffer

while PPC can do

#ifdef CONFIG_NOT_CACHE_COHERENT

#define __dma_buffer __dma_buffer_line(__LINE__)
#define __dma_buffer_line(line) __dma_buffer_expand_line(line)
#define __dma_buffer_expand_line(line) \
	__attribute__ ((aligned(SMP_CACHE_BYTES))); \
	char __dma_pad_ ## line [0] __attribute__ ((aligned(SMP_CACHE_BYTES)))

#else /* CONFIG_NOT_CACHE_COHERENT */

#define __dma_buffer

#endif /* CONFIG_NOT_CACHE_COHERENT */

C purists will point out that this is not guaranteed to work since the
compiler can reorder structure members.  However I'm sure that there
are many, many other places in the kernel where we are counting on gcc
not to reorder structures.

Comments?

Thanks,
  Roland
