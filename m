Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131494AbRCSPga>; Mon, 19 Mar 2001 10:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131514AbRCSPgV>; Mon, 19 Mar 2001 10:36:21 -0500
Received: from gate.perex.cz ([194.212.165.105]:23827 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S131494AbRCSPgA>;
	Mon, 19 Mar 2001 10:36:00 -0500
Date: Mon, 19 Mar 2001 16:35:15 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Dimitri Shlyakhtenko <shlyakht@math.ucla.edu>
cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [alsa-devel] Emu10k memory allocation (PCI DMA trouble)
In-Reply-To: <3AA042A9.5FA0082@math.ucla.edu>
Message-ID: <Pine.LNX.4.31.0103191623210.790-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2001, Dimitri Shlyakhtenko wrote:

> As I have previosly reported in this mailing list, large soundfont files
> cannot be loaded with the alsa-0.9.0beta1 (and I suspect
> alsa-0.9.0beta2, since the underlying problem was not fixed) under
> linux-2.4.2.  The reason for this is that the memory for the soundfont
> file is allocated via pci_malloc_consistent(); this call frequently
> fails, and there is a limit on the amount of memory that can be
> allocated this way (see my earlier posts titled "use of
> pci_malloc_consistent()").
>
> The enclosed patch solves this problem.  [Note: I am not sure if it
> works on a non-i386 architechture].

This patch is wrong by design. The whole problem is that in
pci_alloc_consistent function (linux/arch/i386/kernel/pcm-dma.c) is this
condition:

	if (hwdev == NULL || hwdev->dma_mask != 0xffffffff)
		gfp |= GFP_DMA;

So, you have two changes: hack this function or hack the ALSA code where
the dma_mask is set PCI_SET_DMA_MASK(pci, 0x7fffffff); (emu10k1.c).

Ask hardware vendors who think that the 2GB physical memory limit is good
enough.

Is any chance to fix this code in the official kernel tree? I think that
the x86 machines with <=2GB memory could not use the GFP_DMA flag. Also,
other soundcards have some other limits like 256MB, so I suggest to havea
condition like for the x86 platform:

	if (hwdev == NULL || hwdev->dma_mask < (max_mapnr << PAGE_SHIFT))
		gfp |= GFP_DMA;

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
SuSE Linux    http://www.suse.com
ALSA project  http://www.alsa-project.org


