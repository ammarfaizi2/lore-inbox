Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291796AbSBNRPS>; Thu, 14 Feb 2002 12:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291795AbSBNRPJ>; Thu, 14 Feb 2002 12:15:09 -0500
Received: from Expansa.sns.it ([192.167.206.189]:23305 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S291794AbSBNRO7>;
	Thu, 14 Feb 2002 12:14:59 -0500
Date: Thu, 14 Feb 2002 18:15:08 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: linux-kernel@vger.kernel.org
Subject: cleanup for i810 chipset for 2.5.5-pre1.
Message-ID: <Pine.LNX.4.44.0202141813140.30210-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This allows i810_audio and i810 drm modules to compile cleanly and to
be loaded and used on 2.5.5-pre1 without unresolved symbols.

Luigi

--- linux/sound/oss/i810_audio.c.old    Thu Feb 14 10:33:12 2002
+++ linux/sound/oss/i810_audio.c        Thu Feb 14 12:29:15 2002
@@ -939,7 +939,7 @@

                for(i=0;i<dmabuf->numfrag;i++)
                {
-
sg->busaddr=virt_to_bus(dmabuf->rawbuf+dmabuf->fragsize*i);
+
sg->busaddr=virt_to_phys(dmabuf->rawbuf+dmabuf->fragsize*i);
                        // the card will always be doing 16bit stereo
                        sg->control=dmabuf->fragsamples;
                        if(state->card->pci_id == PCI_DEVICE_ID_SI_7012)
@@ -954,7 +954,7 @@
                }
                spin_lock_irqsave(&state->card->lock, flags);
                outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
-               outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
+               outl(virt_to_phys(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
                outb(0, state->card->iobase+c->port+OFF_CIV);
                outb(0, state->card->iobase+c->port+OFF_LVI);

@@ -1669,7 +1669,7 @@
        if (size > (PAGE_SIZE << dmabuf->buforder))
                goto out;
        ret = -EAGAIN;
-       if (remap_page_range(vma->vm_start, virt_to_phys(dmabuf->rawbuf),
+       if (remap_page_range(vma, vma->vm_start,
virt_to_phys(dmabuf->rawbuf),
                             size, vma->vm_page_prot))
                goto out;
        dmabuf->mapped = 1;
@@ -1722,7 +1722,7 @@
                }
                if (c != NULL) {
                        outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
-                       outl(virt_to_bus(&c->sg[0]),
state->card->iobase+c->port+OFF_BDBAR);
+                       outl(virt_to_phys(&c->sg[0]),
state->card->iobase+c->port+OFF_BDBAR);
                        outb(0, state->card->iobase+c->port+OFF_CIV);
                        outb(0, state->card->iobase+c->port+OFF_LVI);
                }
--- linux/sound/oss/dmabuf.c.old        Thu Feb 14 12:34:45 2002
+++ linux/sound/oss/dmabuf.c    Thu Feb 14 12:35:00 2002
@@ -113,7 +113,7 @@
                }
        }
        dmap->raw_buf = start_addr;
-       dmap->raw_buf_phys = virt_to_bus(start_addr);
+       dmap->raw_buf_phys = virt_to_phys(start_addr);

        for (page = virt_to_page(start_addr); page <= virt_to_page(end_addr); page++)
                mem_map_reserve(page);
--- linux/drivers/char/drm/i810_dma.c.old       Thu Feb 14 12:36:36 2002
+++ linux/drivers/char/drm/i810_dma.c   Thu Feb 14 12:36:53 2002
@@ -491,7 +491,7 @@
        memset((void *) dev_priv->hw_status_page, 0, PAGE_SIZE);
        DRM_DEBUG("hw status page @ %lx\n", dev_priv->hw_status_page);

-       I810_WRITE(0x02080, virt_to_bus((void *)dev_priv->hw_status_page));
+       I810_WRITE(0x02080, virt_to_phys((void *)dev_priv->hw_status_page));
        DRM_DEBUG("Enabled hardware status page\n");

        /* Now we need to init our freelist */
--- linux/sound/oss/i810_audio.c.old    Thu Feb 14 10:33:12 2002
+++ linux/sound/oss/i810_audio.c        Thu Feb 14 12:29:15 2002
@@ -939,7 +939,7 @@

                for(i=0;i<dmabuf->numfrag;i++)
                {
-
sg->busaddr=virt_to_bus(dmabuf->rawbuf+dmabuf->fragsize*i);
+
sg->busaddr=virt_to_phys(dmabuf->rawbuf+dmabuf->fragsize*i);
                        // the card will always be doing 16bit stereo
                        sg->control=dmabuf->fragsamples;
                        if(state->card->pci_id == PCI_DEVICE_ID_SI_7012)
@@ -954,7 +954,7 @@
                }
                spin_lock_irqsave(&state->card->lock, flags);
                outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
-               outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
+               outl(virt_to_phys(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
                outb(0, state->card->iobase+c->port+OFF_CIV);
                outb(0, state->card->iobase+c->port+OFF_LVI);

@@ -1669,7 +1669,7 @@
        if (size > (PAGE_SIZE << dmabuf->buforder))
                goto out;
        ret = -EAGAIN;
-       if (remap_page_range(vma->vm_start, virt_to_phys(dmabuf->rawbuf),
+       if (remap_page_range(vma, vma->vm_start,
virt_to_phys(dmabuf->rawbuf),
                             size, vma->vm_page_prot))
                goto out;
        dmabuf->mapped = 1;
@@ -1722,7 +1722,7 @@
                }
                if (c != NULL) {
                        outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
-                       outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
+                       outl(virt_to_phys(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
                        outb(0, state->card->iobase+c->port+OFF_CIV);
                        outb(0, state->card->iobase+c->port+OFF_LVI);
                }



