Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265449AbTLHPmg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 10:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265446AbTLHPla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 10:41:30 -0500
Received: from chaos.analogic.com ([204.178.40.224]:24708 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265445AbTLHPkl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 10:40:41 -0500
Date: Mon, 8 Dec 2003 10:42:47 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?q?moi=20toi?= <mikemaster_f@yahoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Physical address
In-Reply-To: <20031208150713.39743.qmail@web25201.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.53.0312081019410.29539@chaos>
References: <20031208150713.39743.qmail@web25201.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003, [iso-8859-1] moi toi wrote:

> Hi
>
> I am a newbie in the development of Linux driver. I
> have some
> difficulties to understand how the memory management
> works.
>
> I am working on a Pentium IV ( 512M of RAM), with the
> Red Hat 9.0.
> I want to create buffers in the RAM which are
> available for DMA
> transfer, and I want that process can map them.
>
> I reserve at boot time some space in the RAM
> (mem=400M).
> And then I remap a buffer into the driver with the
> following command:
>
> >unsigned long Ram_Buffer_addr;
> >#define       POSITION 0x19000000
> //400*1024*1024=400M
> >#define SIZE  8*1024
> >
> >Ram_Buffer_addr = (unsigned long) ioremap (POSITION,
> SIZE);
>
> The addresses of the buffer are the following:
> Ram_Buffer_addr               = 0xD9DCB000
> Virt_to_phys(Ram_Buffer_addr) = 0x19DCB000
> Virt_to_bus(Ram_Buffer_addr)  = 0x19DCB000
>
> The virtual address is of course different from the
> physical address,
> and the physical address and the bus address are the
> same, because I m
> working on a PC. But I don t understand why the
> physical address is
> different from the one I gave to the function ioremap.
>
> I did a second test: I change the position of the
> buffer instead of
> taking it at the address 0x19000000, the buffer start
> at the address:
> 0x1f400000 (500M).
>
> >unsigned long Ram_Buffer_addr;
> >#define       POSITION 0x1F400000
> //500*1024*1024=500M
> >#define SIZE  8*1024
> >
> >Ram_Buffer_addr = (unsigned long) ioremap (POSITION,
> SIZE);
>
> The addresses of the buffer are the following:
> Ram_Buffer_addr               = 0xD9DCB000
> Virt_to_phys(Ram_Buffer_addr) = 0x19DCB000
> Virt_to_bus(Ram_Buffer_addr)  = 0x19DCB000
>
> The addresses are exactly the same. I m ok for the
> virtual addresses,
> but it sounds pretty weird for the physical and bus
> addresses, they
> shouldn t be the same than in the first test.
>
> ----------------------------------------------------------------------
> When I map the buffer from a process, I use the
> virtual address of the
> buffer with the function mmap, but in the mmap
> call-back function in
> the driver, I use the true physical address with the
> function:
> remap_page_range( vma,  vma->vm_start,
> POSITION,(vma->vm_end -
> vma->vm_start), (pgprot_t) vma->vm_page_prot);
> And it seems work!
> But if instead of POSITION, I set
> Virt_to_phys(Ram_Buffer_addr), it
> doesn t work anymore.
>
> Does that mean that the functions virt_to_phys and
> virt_to_bus don t
> work on virtual addresses? Does anyone know, how to
> get the real
> physical address of the buffer.
>
> Thanks
>
> Francois.

The way pages are set up on Linux makes the virtual address =
physical + PAGE_OFFSET.

So, a __non__portable__ driver can just use that information
to access physical addresses. But, you really should use
the macros provided to make a driver that has a chance of
running on different systems.

In your case, you oremap(0x1f400000) = df400000 which makes
sense. However, depending upon the kernel version you are
using, some "portable pedantics" corrupted the return values
into "cookies", not real addresses. This forces you to use
the macros provided to access these addresses. In other words,
they are __not__ pointers, so they don't make any sense.

A trick to get around all this stuff is to just save the
junk returned from ioremap(). You use this for iounmap().
Then just take the address you asked for (the physical address)
and use that for your hardware, and the virtual address (add
PAGE_OFFSET to it) for your pointer(s). Don't expect any help
from some LK pedantics, but this hack will get you started if
you are not using any special addresses (like high RAM).
Also, don't tell anybody .... <grin>...


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


