Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261751AbSI2TYP>; Sun, 29 Sep 2002 15:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261752AbSI2TYP>; Sun, 29 Sep 2002 15:24:15 -0400
Received: from gate.perex.cz ([194.212.165.105]:22800 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261751AbSI2TYN>;
	Sun, 29 Sep 2002 15:24:13 -0400
Date: Sun, 29 Sep 2002 21:28:48 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Arjan van de Ven <arjanv@fenrus.demon.nl>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA update [6/10] - 2002/07/20
In-Reply-To: <1033326744.2419.9.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0209292120171.591-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Sep 2002, Arjan van de Ven wrote:

> On Sun, 2002-09-29 at 20:51, Jaroslav Kysela wrote:
> > +	sgbuf = snd_magic_cast(snd_pcm_sgbuf_t, substream->dma_private, return -EINVAL);
> 
> hummmm magic casts?? why ?

We are trying to check if 'void *' pointers in structures are used 
correctly. It's our tool for debugging.

> > +		ptr = snd_malloc_pci_pages(sgbuf->pci, PAGE_SIZE, &addr);
> 
> what is wrong with the PCI DMA API that makes ALSA wants a private
> interface/implementation ?

These lines (i386 arch):

        if (hwdev == NULL || ((u32)hwdev->dma_mask != 0xffffffff))
                gfp |= GFP_DMA;
        ret = (void *)__get_free_pages(gfp, get_order(size));

Note that some of soundcards have various PCI DMA transfer limits 
(dma_mask is not set to use full 32-bits). In this case, restricting this 
hardware to allocate these buffers in first 16MB is not a very good idea.
Thus, we have own hacks to allocate memory in whole hardware area.

> >  EXPORT_SYMBOL(snd_wrapper_kmalloc);
> >  EXPORT_SYMBOL(snd_wrapper_kfree);
> > +EXPORT_SYMBOL(snd_wrapper_vmalloc);
> > +EXPORT_SYMBOL(snd_wrapper_vfree);
> 
> why do you need a wrapper for vfree? 

Debugging. We enumerate all allocations, so we can check for memory leaks.
I'm happy to say, that our code is very well debugged in this regard.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

