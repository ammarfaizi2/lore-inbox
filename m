Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbUEANp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUEANp7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 09:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUEANp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 09:45:58 -0400
Received: from chaos.analogic.com ([204.178.40.224]:48001 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262170AbUEANpz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 09:45:55 -0400
Date: Sat, 1 May 2004 09:47:46 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Robert Hancock <hancockr@shaw.ca>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI DMA Address
In-Reply-To: <005701c42f3b$e1ab6aa0$6601a8c0@northbrook>
Message-ID: <Pine.LNX.4.53.0405010915440.6549@chaos>
References: <a826e204.0404282237.6a6b28b0@posting.google.com>
 <005701c42f3b$e1ab6aa0$6601a8c0@northbrook>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2004, Robert Hancock wrote:

> I don't think ioremap is what you want here. ioremap is used to map a PCI
> memory region on the card itself. To allocate a DMA region within system
> memory to transfer to, you want something like pci_alloc_consistent (but
> 128MB seems a rather large amount to use for that function, given that it
> allocates with GFP_ATOMIC..)
>
>
> ----- Original Message -----
> From: "ina" <celina.miranda@eazix.com>
> Newsgroups: fa.linux.kernel
> Sent: Thursday, April 29, 2004 12:37 AM
> Subject: PCI DMA Address
>
>
> > Hi,
> >
> > I need to create a driver for a PCI camera device that uses DMA to
> > transfer the captured images. The system that i use is an x86 board
> > that has 128M of RAM, I reserved the top of the physical RAM during
> > bootup by passing "mem=100".
> >
> > In my driver i claimed the reserved memory by using ioremap call:
> > void* pAdd = ioremap(0x6400000,(1280x1024))
> >

There is a global object called num_physpages. It is already exported
so it can be used by modules. This is the number of pages that the
kernel owns.

The DMA address is, thus, num_physpages * PAGE_SIZE. In versions
2.4.x..., some bad code writes after the last page so you really
need to use:

long bus_address = (num_physpages * PAGE_SIZE) + PAGE_SIZE;

... for the start of the memory you own. This is the bus address
that you will give to your DMA engine. This is also the address
that you would have user-space mmap() in MAP_FIXED, for user's to
read/write directly into that DMA buffer. You make an ioctl()
function that will allow the user code to get this value. You
use the actual values calculated with no conversion. Note that
the user-mode memory-maping needs to start on a PAGE_SIZE boundary
so if you break up this memory for your DMA scatter-list, you need
to use a whole page.

For kernel code to read/write to that space, you need:

	cookie = ioremap_nocache(bus_address, len);

Where cookie is NOT a pointer and needs to be saved to iounmap()
before unloading the module, and bus_address is the address
previously shown. Note that you also need to call request_mem_region()
so somebody else doesn't grab it later. It makes your allocation
show in /proc/iomem. You should not guess at 'len'. You can check
read/writability, once-per-page, to see where real memory ends.

There are macros that allow you to read/write bytes, shorts, longs
using the cookie. Inspection shows that they make a volatile
pointer out of the cookie by using another macro called __io_virt().

In principle, on ix86 machines only, you can make your own pointers
as:

   volatile unsigned char *cp =  __io_virt(cookie);
   volatile unsigned short *sp = __io_virt(cookie);
   volatile unsigned long *lp  = __io_virt(cookie);

The pointers must be of a volatile type to force the compiler
to actually de-reference the underlying data.

These hints will allow you to make a NON-PORTABLE, but straight-
forward module that can DMA to/from memory the user has mmapped.

The new "Linux way" is to use pci_alloc_consistant() and friends.
This is supposed to make things better. You judge.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


