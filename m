Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265782AbRF2Ibv>; Fri, 29 Jun 2001 04:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265787AbRF2Ibl>; Fri, 29 Jun 2001 04:31:41 -0400
Received: from t2.redhat.com ([199.183.24.243]:45556 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S265782AbRF2Ib3>; Fri, 29 Jun 2001 04:31:29 -0400
To: Jes Sorensen <jes@sunsite.dk>
Cc: David Woodhouse <dwmw2@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        dhowells@redhat.com (David Howells), linux-kernel@vger.kernel.org,
        arjanv@redhat.com
Subject: Re: [RFC] I/O Access Abstractions 
In-Reply-To: Your message of "28 Jun 2001 18:02:35 +0200."
             <d3bsn8bnj8.fsf@lxplus015.cern.ch> 
Date: Fri, 29 Jun 2001 09:31:23 +0100
Message-ID: <3652.993803483@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jes Sorensen <jes@sunsite.dk> wrote:
> >>>>> "David" == David Woodhouse <dwmw2@infradead.org> writes:
> 
> David> Having per-resource I/O methods would help us to remove some of
> David> the cruft which is accumulating in various non-x86 code. Note
> David> that the below is the _core_ routines for _one_ board - I'm not
> David> even including the extra indirection through the machine vector
> David> here....
> 
> Have you considered the method used by the 8390 Ethernet driver?
> For each device, add a pointer to the registers and a register shift.

And also flags to specify which address space the I/O ports reside in, and
which how to adjust the host-PCI bridge to bring the appropriate bit of the
PCI address space into view through the CPU address space window. Don't laugh
- it happens.

> I really don't like hacing virtual access functions that makes memory
> mapped I/O look the same as I/O operations.

Why not? It makes drivers a simpler and more flexible if they can treat
different types of resource in the same way. serial.c is a really good example
of this:

| static _INLINE_ unsigned int serial_in(struct async_struct *info, int offset)
| {
|         switch (info->io_type) {
| #ifdef CONFIG_HUB6
|         case SERIAL_IO_HUB6:
|                 outb(info->hub6 - 1 + offset, info->port);
|                 return inb(info->port+1);
| #endif
|         case SERIAL_IO_MEM:
|                 return readb((unsigned long) info->iomem_base +
|                              (offset<<info->iomem_reg_shift));
| #ifdef CONFIG_SERIAL_GSC
|         case SERIAL_IO_GSC:
|                 return gsc_readb(info->iomem_base + offset);
| #endif
|         default:
|                 return inb(info->port + offset);
|         }
| }

The switch has to be performed at runtime - so you get at least one
conditional branch in your code, probably more. My proposal would replace the
conditional branch with a subroutine (which lacks the pipline stall).

Also a number of drivers (eg: ne2k-pci) have to be bound to compile time to
either I/O space or memory space. This would allow you to do it at runtime
without incurring conditional branching.

> For memory mapped I/O you want to be able to smart optimizations to reduce
> the access on the PCI bus (or similar).

I wouldn't have thought you'd want to reduce the number of accesses to the PCI
bus. If, for example, you did to writes to a memory-mapped I/O register, you
don't want the first to be optimised away.

David
