Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264958AbTGKSkC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbTGKSjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:39:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:23684
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264989AbTGKSDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:03:54 -0400
Date: Fri, 11 Jul 2003 19:17:40 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111817.h6BIHe0p017404@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: update trident driver for new ac97 etc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/trident.c linux-2.5.75-ac1/sound/oss/trident.c
--- linux-2.5.75/sound/oss/trident.c	2003-07-10 21:12:56.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/trident.c	2003-07-11 17:41:49.000000000 +0100
@@ -37,6 +37,12 @@
  *	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
  *  History
+ *  v0.14.10h
+ *	Sept 10 2002 Pascal Schmidt <der.eremit@email.de>
+ *	added support for ALi 5451 joystick port
+ *  v0.14.10g
+ *	Sept 05 2002 Alan Cox <alan@redhat.com>
+ *	adapt to new pci joystick attachment interface
  *  v0.14.10f
  *      July 24 2002 Muli Ben-Yehuda <mulix@actcom.co.il>
  *      patch from Eric Lemar (via Ian Soboroff): in suspend and resume, 
@@ -212,7 +218,7 @@
 
 #include "trident.h"
 
-#define DRIVER_VERSION "0.14.10f"
+#define DRIVER_VERSION "0.14.10h-2.5"
 
 /* magic numbers to protect our data structures */
 #define TRIDENT_CARD_MAGIC	0x5072696E /* "Prin" */
@@ -538,8 +544,8 @@
 
 	outl(global_control, TRID_REG(card, T4D_LFO_GC_CIR));
 
-	pr_debug("trident: Enable Loop Interrupts, globctl = 0x%08X\n",
-		 inl(TRID_REG(card, T4D_LFO_GC_CIR)));
+	TRDBG("trident: Enable Loop Interrupts, globctl = 0x%08X\n",
+	      inl(TRID_REG(card, T4D_LFO_GC_CIR)));
 
 	return (TRUE);
 }
@@ -552,8 +558,8 @@
 	global_control &= ~(ENDLP_IE | MIDLP_IE);
 	outl(global_control, TRID_REG(card, T4D_LFO_GC_CIR));
 
-	pr_debug("trident: Disabled Loop Interrupts, globctl = 0x%08X\n",
-		 global_control);
+	TRDBG("trident: Disabled Loop Interrupts, globctl = 0x%08X\n",
+	      global_control);
 
 	return (TRUE);
 }
@@ -570,8 +576,8 @@
 
 #ifdef DEBUG
 	reg = inl(TRID_REG(card, addr));
-	pr_debug("trident: enabled IRQ on channel %d, %s = 0x%08x(addr:%X)\n",
-		 channel, addr==T4D_AINTEN_B? "AINTEN_B":"AINTEN_A",reg,addr);
+	TRDBG("trident: enabled IRQ on channel %d, %s = 0x%08x(addr:%X)\n",
+	      channel, addr==T4D_AINTEN_B? "AINTEN_B":"AINTEN_A",reg,addr);
 #endif /* DEBUG */ 
 }
 
@@ -590,8 +596,8 @@
 
 #ifdef DEBUG
 	reg = inl(TRID_REG(card, addr));
-	pr_debug("trident: disabled IRQ on channel %d, %s = 0x%08x(addr:%X)\n",
-		 channel, addr==T4D_AINTEN_B? "AINTEN_B":"AINTEN_A",reg,addr);
+	TRDBG("trident: disabled IRQ on channel %d, %s = 0x%08x(addr:%X)\n",
+	      channel, addr==T4D_AINTEN_B? "AINTEN_B":"AINTEN_A",reg,addr);
 #endif /* DEBUG */ 
 }
 
@@ -609,8 +615,8 @@
 
 #ifdef DEBUG 
 	reg = inl(TRID_REG(card, addr));
-	pr_debug("trident: start voice on channel %d, %s = 0x%08x(addr:%X)\n",
-		 channel, addr==T4D_START_B? "START_B":"START_A",reg,addr);
+	TRDBG("trident: start voice on channel %d, %s = 0x%08x(addr:%X)\n",
+	      channel, addr==T4D_START_B? "START_B":"START_A",reg,addr);
 #endif /* DEBUG */ 
 }
 
@@ -628,8 +634,8 @@
 
 #ifdef DEBUG
 	reg = inl(TRID_REG(card, addr));
-	pr_debug("trident: stop voice on channel %d, %s = 0x%08x(addr:%X)\n",
-		 channel, addr==T4D_STOP_B? "STOP_B":"STOP_A",reg,addr);
+	TRDBG("trident: stop voice on channel %d, %s = 0x%08x(addr:%X)\n",
+	      channel, addr==T4D_STOP_B? "STOP_B":"STOP_A",reg,addr);
 #endif /* DEBUG */ 
 }
 
@@ -647,8 +653,8 @@
 
 #ifdef DEBUG
 	if (reg & mask)
-		pr_debug("trident: channel %d has interrupt, %s = 0x%08x\n",
-			 channel,reg==T4D_AINT_B? "AINT_B":"AINT_A", reg);
+		TRDBG("trident: channel %d has interrupt, %s = 0x%08x\n",
+		      channel,reg==T4D_AINT_B? "AINT_B":"AINT_A", reg);
 #endif /* DEBUG */ 
 	return (reg & mask) ? TRUE : FALSE;
 }
@@ -665,8 +671,8 @@
 
 #ifdef DEBUG
 	reg = inl(TRID_REG(card, T4D_AINT_B));
-	pr_debug("trident: Ack channel %d interrupt, AINT_B = 0x%08x\n",
-		 channel, reg);
+	TRDBG("trident: Ack channel %d interrupt, AINT_B = 0x%08x\n",
+	      channel, reg);
 #endif /* DEBUG */ 
 }
 
@@ -914,7 +920,7 @@
 
 	trident_write_voice_regs(state);
 
-	pr_debug("trident: called trident_set_dac_rate : rate = %d\n", rate);
+	TRDBG("trident: called trident_set_dac_rate : rate = %d\n", rate);
 
 	return rate;
 }
@@ -934,7 +940,7 @@
 
 	trident_write_voice_regs(state);
 
-	pr_debug("trident: called trident_set_adc_rate : rate = %d\n", rate);
+	TRDBG("trident: called trident_set_adc_rate : rate = %d\n", rate);
 
 	return rate;
 }
@@ -978,9 +984,9 @@
 		/* stereo */
 		channel->control |= CHANNEL_STEREO;
 
-	pr_debug("trident: trident_play_setup, LBA = 0x%08x, "
-		 "Delta = 0x%08x, ESO = 0x%08x, Control = 0x%08x\n",
-		 channel->lba, channel->delta, channel->eso, channel->control);
+	TRDBG("trident: trident_play_setup, LBA = 0x%08x, "
+	      "Delta = 0x%08x, ESO = 0x%08x, Control = 0x%08x\n",
+	      channel->lba, channel->delta, channel->eso, channel->control);
 
 	trident_write_voice_regs(state);
 }
@@ -1064,9 +1070,9 @@
 		/* stereo */
 		channel->control |= CHANNEL_STEREO;
 	
-	pr_debug("trident: trident_rec_setup, LBA = 0x%08x, "
-		 "Delta = 0x%08x, ESO = 0x%08x, Control = 0x%08x\n",
-		 channel->lba, channel->delta, channel->eso, channel->control);
+	TRDBG("trident: trident_rec_setup, LBA = 0x%08x, "
+	      "Delat = 0x%08x, ESO = 0x%08x, Control = 0x%08x\n",
+	      channel->lba, channel->delta, channel->eso, channel->control);
 
 	trident_write_voice_regs(state);
 }
@@ -1101,8 +1107,8 @@
 	}
 
 	
-	pr_debug("trident: trident_get_dma_addr: chip reported channel: %d, "
-		 "cso = 0x%04x\n", dmabuf->channel->num, cso);
+	TRDBG("trident: trident_get_dma_addr: chip reported channel: %d, "
+	      "cso = 0x%04x\n", dmabuf->channel->num, cso);
 
 	/* ESO and CSO are in units of Samples, convert to byte offset */
 	cso <<= sample_shift[dmabuf->fmt];
@@ -1211,8 +1217,8 @@
 					    &dmabuf->dma_handle)))
 		return -ENOMEM;
 
-	pr_debug("trident: allocated %ld (order = %d) bytes at %p\n",
-		 PAGE_SIZE << order, order, rawbuf);
+	TRDBG("trident: allocated %ld (order = %d) bytes at %p\n",
+	      PAGE_SIZE << order, order, rawbuf);
 
 	dmabuf->ready  = dmabuf->mapped = 0;
 	dmabuf->rawbuf = rawbuf;
@@ -1349,11 +1355,10 @@
 		/* set the ready flag for the dma buffer */
 		dmabuf->ready = 1;
 
-		pr_debug("trident: prog_dmabuf(%d), sample rate = %d, "
-			 "format = %d, numfrag = %d, fragsize = %d "
-			 "dmasize = %d\n", dmabuf->channel->num, dmabuf->rate, 
-			 dmabuf->fmt, dmabuf->numfrag, dmabuf->fragsize, 
-			 dmabuf->dmasize);
+		TRDBG("trident: prog_dmabuf(%d), sample rate = %d, format = %d, numfrag = %d, "
+		      "fragsize = %d dmasize = %d\n",
+		      dmabuf->channel->num, dmabuf->rate, dmabuf->fmt, dmabuf->numfrag,
+		      dmabuf->fragsize, dmabuf->dmasize);
 	}
 	unlock_set_fmt(state);
 	return 0;
@@ -1705,7 +1710,7 @@
 	/* FIXED: read interrupt status only once */
 	irq_status=inl(TRID_REG(card, T4D_AINT_A) );
 
-	pr_debug("cyber_address_interrupt: irq_status 0x%X\n",irq_status);
+	TRDBG("cyber_address_interrupt: irq_status 0x%X\n",irq_status);
 
 	for (i = 0; i < NR_HW_CH; i++) {
 		channel = 31 - i; 
@@ -1713,7 +1718,7 @@
 			/* clear bit by writing a 1, zeroes are ignored */ 		
 			outl( (1 << channel), TRID_REG(card, T4D_AINT_A));
 		
-			pr_debug("cyber_interrupt: channel %d\n", channel);
+			TRDBG("cyber_interrupt: channel %d\n", channel);
 
 			if ((state = card->states[i]) != NULL) {
 				trident_update_ptr(state);
@@ -1736,7 +1741,7 @@
 	spin_lock(&card->lock);
 	event = inl(TRID_REG(card, T4D_MISCINT));
 
-	pr_debug("trident: trident_interrupt called, MISCINT = 0x%08x\n", event);
+	TRDBG("trident: trident_interrupt called, MISCINT = 0x%08x\n", event);
 
 	if (event & ADDRESS_IRQ) {
 		card->address_interrupt(card);
@@ -1775,7 +1780,7 @@
 	unsigned swptr;
 	int cnt;
 
-	pr_debug("trident: trident_read called, count = %d\n", count);
+	TRDBG("trident: trident_read called, count = %d\n", count);
 
 	VALIDATE_STATE(state);
 	if (ppos != &file->f_pos)
@@ -1829,7 +1834,7 @@
 			   which results in a (potential) buffer overrun. And worse, there is
 			   NOTHING we can do to prevent it. */
 			if (!interruptible_sleep_on_timeout(&dmabuf->wait, tmo)) {
-				pr_debug(KERN_ERR "trident: recording schedule timeout, "
+				TRDBG(KERN_ERR "trident: recording schedule timeout, "
 				      "dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
 				      dmabuf->dmasize, dmabuf->fragsize, dmabuf->count,
 				      dmabuf->hwptr, dmabuf->swptr);
@@ -1887,7 +1892,7 @@
 	unsigned int state_cnt;
 	unsigned int copy_count;
 
-	pr_debug("trident: trident_write called, count = %d\n", count);
+	TRDBG("trident: trident_write called, count = %d\n", count);
 
 	VALIDATE_STATE(state);
 	if (ppos != &file->f_pos)
@@ -1956,7 +1961,7 @@
 			   which results in a (potential) buffer underrun. And worse, there is
 			   NOTHING we can do to prevent it. */
 			if (!interruptible_sleep_on_timeout(&dmabuf->wait, tmo)) {
-				pr_debug(KERN_ERR "trident: playback schedule timeout, "
+				TRDBG(KERN_ERR "trident: playback schedule timeout, "
 				      "dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
 				      dmabuf->dmasize, dmabuf->fragsize, dmabuf->count,
 				      dmabuf->hwptr, dmabuf->swptr);
@@ -2139,7 +2144,7 @@
 	VALIDATE_STATE(state);
 	mapped = ((file->f_mode & FMODE_WRITE) && dmabuf->mapped) ||
 		((file->f_mode & FMODE_READ) && dmabuf->mapped);
-	pr_debug("trident: trident_ioctl, command = %2d, arg = 0x%08x\n",
+	TRDBG("trident: trident_ioctl, command = %2d, arg = 0x%08x\n",
 	      _IOC_NR(cmd), arg ? *(int *)arg : 0);
 
 	switch (cmd) 
@@ -2704,7 +2709,7 @@
 	state->open_mode |= file->f_mode & (FMODE_READ | FMODE_WRITE);
 	up(&card->open_sem);
 
-	pr_debug("trident: open virtual channel %d, hard channel %d\n", 
+	TRDBG("trident: open virtual channel %d, hard channel %d\n", 
               state->virt, dmabuf->channel->num);
 
 	return 0;
@@ -2726,7 +2731,7 @@
 		drain_dac(state, file->f_flags & O_NONBLOCK);
 	}
 
-	pr_debug("trident: closing virtual channel %d, hard channel %d\n", 
+	TRDBG("trident: closing virtual channel %d, hard channel %d\n", 
 	      state->virt, dmabuf->channel->num);
 
 	/* stop DMA state machine and free DMA buffers/channels */
@@ -2925,11 +2930,10 @@
 	}
 	if(!block)
 	{
-		pr_debug("accesscodecsemaphore: try unlock\n");
+		TRDBG("accesscodecsemaphore: try unlock\n");
 		block = 1;
 		goto unlock;
 	}
-	printk(KERN_ERR "accesscodecsemaphore: fail\n");
 	return 0;
 }
 
@@ -2954,8 +2958,6 @@
 			break;
 		udelay(50);
 	}
-
-	printk(KERN_NOTICE "waitforstimertick :BIT_CLK is dead\n");
 	return 0;
 }
 
@@ -2967,6 +2969,7 @@
         unsigned long aud_reg;
 	u32 data;
         u16 wcontrol;
+        unsigned long flags;
 
 	if(!card)
 		BUG();
@@ -2979,6 +2982,8 @@
 	if (secondary)
 		mask |= ALI_AC97_SECONDARY;
     
+    	spin_lock_irqsave(&card->lock, flags);
+    	
 	if (!acquirecodecaccess(card))
 		printk(KERN_ERR "access codec fail\n");
 	
@@ -2990,7 +2995,7 @@
 	data = (mask | (reg & AC97_REG_ADDR));
 	
 	if(!waitforstimertick(card)) {
-		printk(KERN_ERR "BIT_CLOCK is dead\n");
+		printk(KERN_ERR "ali_ac97_read: BIT_CLOCK is dead\n");
 		goto releasecodec;
 	}
 	
@@ -3004,7 +3009,7 @@
 		if(ncount <=0)
 			break;
 		if(ncount--==1) {
-			pr_debug("ali_ac97_read :try clear busy flag\n");
+			TRDBG("ali_ac97_read :try clear busy flag\n");
 			aud_reg = inl(TRID_REG(card,  ALI_AC97_WRITE));
 			outl((aud_reg & 0xffff7fff), TRID_REG(card, ALI_AC97_WRITE));
 		}
@@ -3017,7 +3022,8 @@
 
  releasecodec: 
 	releasecodecaccess(card);
-	printk(KERN_ERR "ali: AC97 CODEC read timed out.\n");
+	spin_unlock_irqrestore(&card->lock, flags);
+	printk(KERN_ERR "ali_ac97_read: AC97 CODEC read timed out.\n");
 	return 0;
 }
 
@@ -3029,6 +3035,7 @@
 	unsigned int ncount;
 	u32 data;
         u16 wcontrol;
+        unsigned long flags;
 	
 	data = ((u32) val) << 16;
 	
@@ -3042,8 +3049,9 @@
 	if (card->revision == ALI_5451_V02)
 		mask |= ALI_AC97_WRITE_MIXER_REGISTER;
 		
+	spin_lock_irqsave(&card->lock, flags);
         if (!acquirecodecaccess(card))      
-		printk(KERN_ERR "access codec fail\n");
+		printk(KERN_ERR "ali_ac97_write: access codec fail\n");
 			
 	wcontrol = inw(TRID_REG(card, ALI_AC97_WRITE));
 	wcontrol &= 0xff00;
@@ -3063,7 +3071,7 @@
 		if(ncount <= 0)
 			break;
 		if(ncount-- == 1) {
-			pr_debug("ali_ac97_set :try clear busy flag!!\n");
+			TRDBG("ali_ac97_set :try clear busy flag!!\n");
 			outw(wcontrol & 0x7fff, TRID_REG(card, ALI_AC97_WRITE));
 		}
 		udelay(10);
@@ -3071,6 +3079,7 @@
 	
  releasecodec:
 	releasecodecaccess(card);
+	spin_unlock_irqrestore(&card->lock, flags);
 	return;
 }
 
@@ -3099,6 +3108,9 @@
 	if(!card->mixer_regs_ready)
 		return ali_ac97_get(card, codec->id, reg);
 
+	/*
+	 *	FIXME: need to stop this caching some registers
+	 */
 	if(codec->id)
 		id = 1;
 	else
@@ -3366,15 +3378,17 @@
         pci_dev = pci_find_device(PCI_VENDOR_ID_AL,PCI_DEVICE_ID_AL_M1533, pci_dev);
         if (pci_dev == NULL)
                 return -1;
-	temp = 0x80;
-	pci_write_config_byte(pci_dev, 0x59, ~temp);
+	pci_read_config_byte(pci_dev, 0x59, &temp);
+	temp &= ~0x80;
+	pci_write_config_byte(pci_dev, 0x59, temp);
 	
 	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101, pci_dev);
 	if (pci_dev == NULL)
                 return -1;
 
-	temp = 0x20;
-	pci_write_config_byte(pci_dev, 0xB8, ~temp);
+	pci_read_config_byte(pci_dev, 0xB8, &temp);
+	temp &= ~0x20;
+	pci_write_config_byte(pci_dev, 0xB8, temp);
 
 	return 0;
 }
@@ -3388,13 +3402,15 @@
 	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, pci_dev);
 	if (pci_dev == NULL)
                 return -1;
-	temp = 0x80;
+	pci_read_config_byte(pci_dev, 0x59, &temp);
+	temp |= 0x80;
 	pci_write_config_byte(pci_dev, 0x59, temp);
 	
 	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101, pci_dev);
  	if (pci_dev == NULL)
                 return -1;
-	temp = 0x20;
+	pci_read_config_byte(pci_dev, (int)0xB8, &temp);
+	temp |= 0x20;
 	pci_write_config_byte(pci_dev, (int)0xB8,(u8) temp);
 	if (chan_nums == 6) {
 		dwValue = inl(TRID_REG(card, ALI_SCTRL)) | 0x000f0000;
@@ -3934,10 +3950,7 @@
 			return 0;
 		udelay(5000);
 	}
-
 	/* This is non fatal if you have a non PM capable codec.. */
-	printk(KERN_ERR "ALi 5451 did not come out of reset "
-	       "- continuing anyway.\n");
 	return 0;
 }
 
@@ -4010,9 +4023,8 @@
 	}
 
 	for (num_ac97 = 0; num_ac97 < NR_AC97; num_ac97++) {
-		if ((codec = kmalloc(sizeof(struct ac97_codec), GFP_KERNEL)) == NULL)
+		if ((codec = ac97_alloc_codec()) == NULL)
 			return -ENOMEM;
-		memset(codec, 0, sizeof(struct ac97_codec));
 
 		/* initialize some basic codec information, other fields will be filled
 		   in ac97_probe_codec */
@@ -4033,7 +4045,7 @@
 
 		if ((codec->dev_mixer = register_sound_mixer(&trident_mixer_fops, -1)) < 0) {
 			printk(KERN_ERR "trident: couldn't register mixer!\n");
-			kfree(codec);
+			ac97_release_codec(codec);
 			break;
 		}
 
@@ -4258,7 +4270,7 @@
 		for (i = 0; i < NR_AC97; i++) {
 			if (card->ac97_codec[i] != NULL) {
 				unregister_sound_mixer(card->ac97_codec[i]->dev_mixer);
-				kfree (card->ac97_codec[i]);
+				ac97_release_codec(card->ac97_codec[i]);
 			}
 		}
 		goto out_unregister_sound_dsp;
@@ -4358,7 +4370,7 @@
 	for (i = 0; i < NR_AC97; i++)
 		if (card->ac97_codec[i] != NULL) {
 			unregister_sound_mixer(card->ac97_codec[i]->dev_mixer);
-			kfree (card->ac97_codec[i]);
+			ac97_release_codec(card->ac97_codec[i]);
 		}
 	unregister_sound_dsp(card->dev_audio);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/trident.h linux-2.5.75-ac1/sound/oss/trident.h
--- linux-2.5.75/sound/oss/trident.h	2003-07-10 21:04:00.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/trident.h	2003-07-11 17:43:02.000000000 +0100
@@ -360,4 +360,16 @@
 	return r;
 }
 
+#ifdef DEBUG
+
+#define TRDBG(msg, args...) do {          \
+        printk(KERN_DEBUG msg , ##args ); \
+} while (0)
+
+#else /* !defined(DEBUG) */ 
+
+#define TRDBG(msg, args...) do { } while (0)
+
+#endif /* DEBUG */ 
+
 #endif /* __TRID4DWAVE_H */
