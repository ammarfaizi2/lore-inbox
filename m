Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbUB2MyO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 07:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbUB2MyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 07:54:14 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:12937 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S262046AbUB2MyK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 07:54:10 -0500
Date: Sun, 29 Feb 2004 13:48:52 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Russell King <rmk+alsa@arm.linux.org.uk>
Cc: Alsa Devel list <alsa-devel@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] 2.6.4-rc1: ALSA makes invalid assumptions about
 memory types
In-Reply-To: <20040229122234.B28963@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0402291338520.1880@pnote.perex-int.cz>
References: <20040229122234.B28963@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Feb 2004, Russell King wrote:

> 1) Memory types.
> 
>    In snd_dma_alloc_pages(), ALSA does this:
> 
>         case SNDRV_DMA_TYPE_PCI:
>                 dmab->area = snd_malloc_pci_pages(dev->dev.pci, size, &dmab->addr);
> 
>    which eventually comes down to this:
> 
>         res = pci_alloc_consistent(pci, PAGE_SIZE * (1 << pg), dma_addr);
> 
>    IOW:
> 
> 	dmab->area = pci_alloc_consistent(dev->dev.pci, size, &dmab->addr);
> 
>    and in snd_pcm_lib_malloc_pages() we copy these into the runtime, thusly:
> 
>         runtime->dma_area = dmab.area;
>         runtime->dma_addr = dmab.addr;
>         runtime->dma_private = dmab.private_data;
>         runtime->dma_bytes = size;
> 
>    However, in snd_pcm_mmap_data_nopage(), ALSA does this:
> 
>                 vaddr = runtime->dma_area + offset;
>                 page = virt_to_page(vaddr);
> 
>    virt_to_page may _only_ be used on memory returned by get_free_page()
>    and kmalloc(), and certainly not on memory returned by
>    pci_alloc_consistent(). The only reason it works on x86 is because
>    x86 is a fully cache coherent architecture, so pci_alloc_consistent()
>    _just happens_ to be equivalent to get_free_pages() on that platform.
>    Note that the same applies to dma_alloc_coherent().
> 
>    In other words, the above code will not work on non-cache coherent
>    architectures without modification.
> 
>    I believe this needs discussing with the DMA API authors on LKML since
>    AFAIK the kernel currently doesn't have a clear API to translate memory
>    returned by either pci_alloc_consistent() or dma_alloc_coherent() back
>    to it's consituent struct page pointers.

We can do some #ifdef hacks in our code, of course, but a function 
doing this abstraction in kernel for given architecture would be much 
better of course.

>    Secondly the user space mapping will be marked as cacheable on some
>    architectures, which would be Real Bad(tm) on architectures which
>    are not DMA coherent.
> 
>    The way architectures mark their mappings uncacheable and/or only
>    writecombining is architecture specific... see drivers/video/fbmem.c
>    as an example.

It's real mess. I think that this setup should be moved to linux/arch 
tree, too.

> 2) PCM mmap control/status mappings
> 
>    These suffer from a similar cache coherency problem - you can not
>    assume that two different mappings of the same page will not alias
>    in the CPUs caches.
> 
>    In my case on ARM, not only must the user space mappings of these
>    structures be marked uncacheable, but also the kernel space mappings
>    of the same to ensure that accesses via both mappings always return
>    up to date information.
> 
>    I have hacks in my tree which work around this using ARM specific
>    functionality, but this is very much architecture specific at the
>    moment, and I suspect requires a new kernel API for creating memory
>    (it's similar to the DMA case above.)

It's same problem. We need that a function in kernel API will do this 
for us to avoid #ifdefs for all architectures.

I'm not sure, if I'm the right person to do these changes in kernel.
Any volunteer? Thanks.

Until this change is done, I accept the #ifdef hacks to fix support for
all architectures in ALSA.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
