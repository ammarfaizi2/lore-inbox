Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291835AbSBNSm5>; Thu, 14 Feb 2002 13:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291834AbSBNSms>; Thu, 14 Feb 2002 13:42:48 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:27912 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S291835AbSBNSmk>; Thu, 14 Feb 2002 13:42:40 -0500
Date: Thu, 14 Feb 2002 13:42:38 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200202141842.g1EIgcR12566@devserv.devel.redhat.com>
To: kernel@Expansa.sns.it, linux-kernel@vger.kernel.org
Subject: Re: 2.5.5-pre1 and i810_audio.c
In-Reply-To: <mailman.1013679424.26983.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1013679424.26983.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i810audio.c actually does not compile.
> -       if (remap_page_range(vma->vm_start, virt_to_phys(dmabuf->rawbuf),
> +       if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf),

This is not enough, you must replace virt_to_bus as well.
I made a patch, it is in the queue for Doug. However, if you
are insane enough to try 2.5, you better spend your energy
on fixing ALSA. You know, if you cannot beat them, join them...

-- Pete

--- linux-2.5.3/drivers/sound/i810_audio.c	Mon Jan 28 14:35:13 2002
+++ linux-2.5.3-p3/drivers/sound/i810_audio.c	Fri Feb  8 16:24:05 2002
@@ -335,7 +335,6 @@
 
 
 struct i810_card {
-	struct i810_channel channel[3];
 	unsigned int magic;
 
 	/* We keep i810 cards in a linked list */
@@ -359,6 +358,8 @@
 	/* structures for abstraction of hardware facilities, codecs, banks and channels*/
 	struct ac97_codec *ac97_codec[NR_AC97];
 	struct i810_state *states[NR_HW_CH];
+	struct i810_channel *channel;	/* 1:1 to states[] but diff. lifetime */
+	dma_addr_t chandma;
 
 	u16 ac97_features;
 	u16 ac97_status;
@@ -939,7 +940,7 @@
 	  
 		for(i=0;i<dmabuf->numfrag;i++)
 		{
-			sg->busaddr=virt_to_bus(dmabuf->rawbuf+dmabuf->fragsize*i);
+			sg->busaddr=(u32)dmabuf->dma_handle+dmabuf->fragsize*i;
 			// the card will always be doing 16bit stereo
 			sg->control=dmabuf->fragsamples;
 			if(state->card->pci_id == PCI_DEVICE_ID_SI_7012)
@@ -954,7 +955,9 @@
 		}
 		spin_lock_irqsave(&state->card->lock, flags);
 		outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
-		outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
+		outl((u32)state->card->chandma +
+		    c->num*sizeof(struct i810_channel),
+		    state->card->iobase+c->port+OFF_BDBAR);
 		outb(0, state->card->iobase+c->port+OFF_CIV);
 		outb(0, state->card->iobase+c->port+OFF_LVI);
 
@@ -1669,7 +1672,7 @@
 	if (size > (PAGE_SIZE << dmabuf->buforder))
 		goto out;
 	ret = -EAGAIN;
-	if (remap_page_range(vma->vm_start, virt_to_phys(dmabuf->rawbuf),
+	if (remap_page_range(vma, vma->vm_start, virt_to_phys(dmabuf->rawbuf),
 			     size, vma->vm_page_prot))
 		goto out;
 	dmabuf->mapped = 1;
@@ -1722,7 +1725,9 @@
 		}
 		if (c != NULL) {
 			outb(2, state->card->iobase+c->port+OFF_CR);   /* reset DMA machine */
-			outl(virt_to_bus(&c->sg[0]), state->card->iobase+c->port+OFF_BDBAR);
+			outl((u32)state->card->chandma +
+			    c->num*sizeof(struct i810_channel),
+			    state->card->iobase+c->port+OFF_BDBAR);
 			outb(0, state->card->iobase+c->port+OFF_CIV);
 			outb(0, state->card->iobase+c->port+OFF_LVI);
 		}
@@ -2881,15 +2886,26 @@
 	card->alloc_rec_pcm_channel = i810_alloc_rec_pcm_channel;
 	card->alloc_rec_mic_channel = i810_alloc_rec_mic_channel;
 	card->free_pcm_channel = i810_free_pcm_channel;
-	card->channel[0].offset = 0;
-	card->channel[0].port = 0x00;
-	card->channel[0].num=0;
-	card->channel[1].offset = 0;
-	card->channel[1].port = 0x10;
-	card->channel[1].num=1;
-	card->channel[2].offset = 0;
-	card->channel[2].port = 0x20;
-	card->channel[2].num=2;
+
+	if ((card->channel = pci_alloc_consistent(pci_dev,
+	    sizeof(struct i810_channel)*NR_HW_CH, &card->chandma)) == NULL) {
+		printk(KERN_ERR "i810: cannot allocate channel DMA memory\n");
+		goto out_mem;
+	}
+
+	{ /* We may dispose of this altogether some time soon, so... */
+		struct i810_channel *cp = card->channel;
+
+		cp[0].offset = 0;
+		cp[0].port = 0x00;
+		cp[0].num = 0;
+		cp[1].offset = 0;
+		cp[1].port = 0x10;
+		cp[1].num = 1;
+		cp[2].offset = 0;
+		cp[2].port = 0x20;
+		cp[2].num = 2;
+	}
 
 	/* claim our iospace and irq */
 	request_region(card->iobase, 64, card_names[pci_id->driver_data]);
@@ -2900,8 +2916,7 @@
 		printk(KERN_ERR "i810_audio: unable to allocate irq %d\n", card->irq);
 		release_region(card->iobase, 64);
 		release_region(card->ac97base, 256);
-		kfree(card);
-		return -ENODEV;
+		goto out_chan;
 	}
 
 	/* initialize AC97 codec and register /dev/mixer */
@@ -2909,8 +2924,7 @@
 		release_region(card->iobase, 64);
 		release_region(card->ac97base, 256);
 		free_irq(card->irq, card);
-		kfree(card);
-		return -ENODEV;
+		goto out_chan;
 	}
 	pci_set_drvdata(pci_dev, card);
 
@@ -2931,11 +2945,17 @@
 			unregister_sound_mixer(card->ac97_codec[i]->dev_mixer);
 			kfree (card->ac97_codec[i]);
 		}
-		kfree(card);
-		return -ENODEV;
+		goto out_chan;
 	}
  	card->initializing = 0;
 	return 0;
+
+ out_chan:
+	pci_free_consistent(pci_dev, sizeof(struct i810_channel)*NR_HW_CH,
+	    card->channel, card->chandma);
+ out_mem:
+	kfree(card);
+	return -ENODEV;
 }
 
 static void __exit i810_remove(struct pci_dev *pci_dev)
