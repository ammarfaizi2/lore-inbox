Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261805AbSI2Uao>; Sun, 29 Sep 2002 16:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261809AbSI2Uao>; Sun, 29 Sep 2002 16:30:44 -0400
Received: from gate.perex.cz ([194.212.165.105]:38160 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261805AbSI2Uai>;
	Sun, 29 Sep 2002 16:30:38 -0400
Date: Sun, 29 Sep 2002 22:34:51 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Jeff Garzik <jgarzik@pobox.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA update [6/10] - 2002/07/20
In-Reply-To: <3D9759FF.2050802@pobox.com>
Message-ID: <Pine.LNX.4.33.0209292230500.591-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002, Jeff Garzik wrote:

> Jaroslav Kysela wrote:
> > On 29 Sep 2002, Arjan van de Ven wrote:
> >>what is wrong with the PCI DMA API that makes ALSA wants a private
> >>interface/implementation ?
> > 
> > 
> > These lines (i386 arch):
> > 
> >         if (hwdev == NULL || ((u32)hwdev->dma_mask != 0xffffffff))
> >                 gfp |= GFP_DMA;
> >         ret = (void *)__get_free_pages(gfp, get_order(size));
> > 
> > Note that some of soundcards have various PCI DMA transfer limits 
> > (dma_mask is not set to use full 32-bits). In this case, restricting this 
> > hardware to allocate these buffers in first 16MB is not a very good idea.
> > Thus, we have own hacks to allocate memory in whole hardware area.
> 
> It sounds like it would be reasonable to fix the ia32 arch code, would 
> it not?

We have simple method in our hack:

  - try to allocate memory anywhere
  - try to allocate memory with GFP DMA if first step fails

Here is updated pci-dma.c code for comments:

===== pci-dma.c 1.8 vs edited =====
--- 1.8/arch/i386/kernel/pci-dma.c	Thu May  9 19:24:12 2002
+++ edited/pci-dma.c	Sun Sep 29 22:26:46 2002
@@ -19,14 +19,24 @@
 	void *ret;
 	int gfp = GFP_ATOMIC;
 
-	if (hwdev == NULL || ((u32)hwdev->dma_mask != 0xffffffff))
+	if (hwdev == NULL || (u32)hwdev->dma_mask <= 0x00ffffff)
 		gfp |= GFP_DMA;
 	ret = (void *)__get_free_pages(gfp, get_order(size));
 
-	if (ret != NULL) {
-		memset(ret, 0, size);
-		*dma_handle = virt_to_phys(ret);
+	if (ret == NULL)
+		return NULL;
+
+	/* try to allocate area in first 16MB memory */
+	if ((gfp & GFP_DMA) == 0 && (u32)hwdev->dma_mask != 0xffffffff &&
+	    ((virt_to_phys(ret) + size - 1) & ~(u32)hwdev->dma_mask) != 0) {
+		free_pages(ret, get_order(size));
+		ret = (void *)__get_free_pages(gfp | GFP_DMA, get_order(size));
+		if (ret == NULL)
+			return NULL;
 	}
+
+	memset(ret, 0, size);
+	*dma_handle = virt_to_phys(ret);
 	return ret;
 }
 
						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

