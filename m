Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267869AbRGRMlF>; Wed, 18 Jul 2001 08:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267871AbRGRMk4>; Wed, 18 Jul 2001 08:40:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:46464 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267869AbRGRMkk>; Wed, 18 Jul 2001 08:40:40 -0400
Date: Wed, 18 Jul 2001 08:40:39 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alexander Ehlert <alexander.ehlert@uni-tuebingen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Right Semantics for ioremap, remap_page_range
In-Reply-To: <Pine.LNX.4.32.0107181334442.809-100000@frodo.sau98.de>
Message-ID: <Pine.LNX.3.95.1010718082115.17113A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2001, Alexander Ehlert wrote:

> Hi,
> 
> I'm currently trying to write a linux kernel driver for an experimental
> graphics board we're developing at our institute. It's fitted
> with an plx9054 and got some sdram on board connected to the plx.
> Now I come this far, that I actually detect the board, set some modes
> and do an ioremap on pci_resource_start(pdev,2) which is the
> base for 64Mb Ram Onboard. After ioremap() I actually like
> to do remap_page_range through fileops/mmap call. I just copied
> that code from drivers/char/mem.c, but just using the ioremapped
> address as offset in remap_page_range, doesn't seem to work, instead
> I think I just mmap some totally different area... Now, what do I have to
> use for that offset? What I currently do in the init function is
> something like that:
> 
> ...
> priv.pcibar2 = (char*)ioremap(pci_resource_start(pdev,2),
>                               pci_resource_len(pdev,2));
> ...

This is becoming a FAQ. The return value from ioremap() and friends
is not a pointer. It is actually something that from time-to-time
will be poisoned to detect its use as a pointer. It is a 'cookie'
designed to be used with readl() readw() readb(), writel(), etc.
For large arrays, you use copy/to/from_io().  It is possible to
determine the actual virtual address with a runtime code snippit
so you could access your remapped address conventionally, i.e.,
as a pointer, perhaps to a structure, etc., but cheating like
that is frowned upon and makes your driver more non-portable
than it probably already is. The assumption seems to be that
when Apple comes out with a 256 bit machine with 128 bit PCI
and 32, 40 GHz CPUs, you just recompile everything and it will run );

If your driver is never going to be used for anything but
a private experiment, the value of a pointer to the remapped
area is (usually) the (address_you_asked_for) | PAGE_OFFSET.

You have to save the returned cookie anyway because you use
it to release the remapped area when your module exits.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


