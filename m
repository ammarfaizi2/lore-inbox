Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289466AbSBSTbo>; Tue, 19 Feb 2002 14:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289240AbSBSTbg>; Tue, 19 Feb 2002 14:31:36 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:50932 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289377AbSBSTbV>; Tue, 19 Feb 2002 14:31:21 -0500
Message-ID: <3C72A7F4.5060001@redhat.com>
Date: Tue, 19 Feb 2002 14:31:00 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020202
X-Accept-Language: en-us
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        alan@redhat.com, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
In-Reply-To: <20020219120531.A22316@devserv.devel.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------030301010008060305040506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030301010008060305040506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Pete Zaitcev wrote:
>>From:     Linus Torvalds <torvalds@transmeta.com>
>>Date:     2002-02-13 16:47:33
>>Subject:  Re: PATCH 2.5.4 i810_audio, bttv, working at all.
>>
> 
>>On Wed, 13 Feb 2002, Jeff Garzik wrote:
>>
>>>These changes are wrong.  The addresses desired need to be obtained from
>>>the pci_alloc_consistent return values.
>>>
>>Let's face it, people won't care about the complex PCI interfaces unless
>>they give you something useful.
>>
> 
> I cannot believe that I am reading that. The pinhead penguin
> is totally off the thread. The fix for i810 took me less than
> 10 minutes, and it works perfectly! What the hell are you
> talking about here? What complex interfaces?! Is this a list
> for kernel programmers or milksuckers? The interface is
> simple as a pancake!
> 
> -- Pete
> 
> P.S. Doug, for heaven's sake, push the fix upstrem ASAP, please.
> I cannot stand this stupidity and incompetence anymore.
> 
> P.P.S. Posting this FOR THE THIRD TIME in reply for a broken
> patch. Next guy to post a broken "fix" for i810 with
> isa_virt_to_bus or virt_to_phis may suffer very badly.

I agree that the patch is the correct fix. All except for the line changing
the remap_page_range() call it's also totally relevant to the 2.4 kernel driver.


-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

--------------030301010008060305040506
Content-Type: text/plain;
 name="i810-2.5.3-p3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i810-2.5.3-p3.patch"

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


--------------030301010008060305040506--

