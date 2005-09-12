Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVILSAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVILSAA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVILSAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:00:00 -0400
Received: from mail.suse.de ([195.135.220.2]:1744 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750798AbVILR77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:59:59 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [3/3] Use the DMA32 zone for  dma_alloc_coherent()/pci_alloc_consistent on x86-64
Date: Mon, 12 Sep 2005 19:59:42 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <43246267.mailL4Y1GM1RI@suse.de> <Pine.LNX.4.58.0509121040100.3242@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509121040100.3242@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509121959.43259.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 September 2005 19:41, Linus Torvalds wrote:
> On Sun, 11 Sep 2005, Andi Kleen wrote:
> > Use the DMA32 zone for dma_alloc_coherent()/pci_alloc_consistent on
> > x86-64
> >
> > Signed-off-by: Andi Kleen <ak@suse.de>
> >
> > Index: linux/arch/x86_64/kernel/pci-gart.c
> > ===================================================================
> > --- linux.orig/arch/x86_64/kernel/pci-gart.c
> > +++ linux/arch/x86_64/kernel/pci-gart.c
> > @@ -219,6 +219,8 @@ dma_alloc_coherent(struct device *dev, s
> >  	/* Kludge to make it bug-to-bug compatible with i386. i386
> >  	   uses the normal dma_mask for alloc_coherent. */
> >  	dma_mask &= *dev->dma_mask;
> > +	if (dma_mask <= 0xffffffff)
> > +		gfp |= GFP_DMA32;
>
> How can this be right?

No that's intentional. The rationale is that usually the mask is bigger 
than 16MB, so you first try it in the higher zone where you already
have some chance to get the right memory, and then only
if you don't get it fall back to the "precious" zone.

The cost is very low because the allocators are fast enough.

Given for a real 0xfffff allocation it is not very likely it will
work, but most <4GB allocations are bigger than that.

I had the same algorithm previously with GFP_DMA.

> Let's say that dma_mask is 0xfffff (ie 20-bit legacy DMA). It will trigger
> the test, and set the GFP_DMA32 bit. Which can't be right.
>
> I'm going to drop the DMA32 parts of the patches, they seem to be pretty
> raw.

Please don't.


-Andi
