Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbTGKSPT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264888AbTGKSOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:14:30 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16772
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264949AbTGKSAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:00:55 -0400
Date: Fri, 11 Jul 2003 19:14:42 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111814.h6BIEgXZ017350@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: update the i810 audio driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/i810_audio.c linux-2.5.75-ac1/sound/oss/i810_audio.c
--- linux-2.5.75/sound/oss/i810_audio.c	2003-07-10 21:12:55.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/i810_audio.c	2003-07-11 17:34:21.000000000 +0100
@@ -117,6 +117,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_ICH4
 #define PCI_DEVICE_ID_INTEL_ICH4	0x24c5
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_ICH5
+#define PCI_DEVICE_ID_INTEL_ICH5	0x24d5
+#endif
 #ifndef PCI_DEVICE_ID_INTEL_440MX
 #define PCI_DEVICE_ID_INTEL_440MX	0x7195
 #endif
@@ -178,7 +181,7 @@
 struct i810_channel 
 {
 	/* these sg guys should probably be allocated
-	   separately as nocache. Must be 8 byte aligned */
+	   seperately as nocache. Must be 8 byte aligned */
 	struct sg_item sg[SG_LEN];	/* 32*8 */
 	u32 offset;			/* 4 */
 	u32 port;			/* 4 */
@@ -187,7 +190,7 @@
 };
 
 /*
- * we have 3 separate dma engines.  pcm in, pcm out, and mic.
+ * we have 3 seperate dma engines.  pcm in, pcm out, and mic.
  * each dma engine has controlling registers.  These goofy
  * names are from the datasheet, but make it easy to write
  * code while leafing through it.
@@ -272,6 +275,7 @@
 	INTELICH2,
 	INTELICH3,
 	INTELICH4,
+	INTELICH5,
 	SI7012,
 	NVIDIA_NFORCE,
 	AMD768,
@@ -285,6 +289,7 @@
 	"Intel ICH2",
 	"Intel ICH3",
 	"Intel ICH4",
+	"Intel ICH5",
 	"SiS 7012",
 	"NVIDIA nForce Audio",
 	"AMD 768",
@@ -303,7 +308,8 @@
 	{  1, 0x0000 }, /* INTEL440MX */
 	{  1, 0x0000 }, /* INTELICH2 */
 	{  2, 0x0000 }, /* INTELICH3 */
-        {  3, 0x0003 }, /* INTELICH4 */
+ 	{  3, 0x0003 }, /* INTELICH4 */
+	{  3, 0x0003 }, /* INTELICH5 */
 	/*@FIXME to be verified*/	{  2, 0x0000 }, /* SI7012 */
 	/*@FIXME to be verified*/	{  2, 0x0000 }, /* NVIDIA_NFORCE */
 	/*@FIXME to be verified*/	{  2, 0x0000 }, /* AMD768 */
@@ -323,6 +329,8 @@
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH3},
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH4,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH4},
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH5,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH5},
 	{PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_7012,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, SI7012},
 	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_MCP1_AUDIO,
@@ -419,6 +427,9 @@
 	/* The i810 has a certain amount of cross channel interaction
 	   so we use a single per card lock */
 	spinlock_t lock;
+	
+	/* Control AC97 access serialization */
+	spinlock_t ac97_lock;
 
 	/* PCI device stuff */
 	struct pci_dev * pci_dev;
@@ -547,80 +558,42 @@
  *     The DSP sample rate must already be set to a supported
  *     S/PDIF rate (32kHz, 44.1kHz, or 48kHz) or we abort.
  */
-static void i810_set_spdif_output(struct i810_state *state, int slots, int rate)
+static int i810_set_spdif_output(struct i810_state *state, int slots, int rate)
 {
 	int	vol;
 	int	aud_reg;
+	int	r = 0;
 	struct ac97_codec *codec = state->card->ac97_codec[0];
 
-	if(!(state->card->ac97_features & 4)) {
-#ifdef DEBUG
-		printk(KERN_WARNING "i810_audio: S/PDIF transmitter not available.\n");
-#endif
+	if(!codec->codec_ops->digital) {
 		state->card->ac97_status &= ~SPDIF_ON;
 	} else {
 		if ( slots == -1 ) { /* Turn off S/PDIF */
-			aud_reg = i810_ac97_get(codec, AC97_EXTENDED_STATUS);
-			i810_ac97_set(codec, AC97_EXTENDED_STATUS, (aud_reg & ~AC97_EA_SPDIF));
-
+			codec->codec_ops->digital(codec, 0, 0, 0);
 			/* If the volume wasn't muted before we turned on S/PDIF, unmute it */
 			if ( !(state->card->ac97_status & VOL_MUTED) ) {
 				aud_reg = i810_ac97_get(codec, AC97_MASTER_VOL_STEREO);
 				i810_ac97_set(codec, AC97_MASTER_VOL_STEREO, (aud_reg & ~VOL_MUTED));
 			}
 			state->card->ac97_status &= ~(VOL_MUTED | SPDIF_ON);
-			return;
+			return 0;
 		}
 
 		vol = i810_ac97_get(codec, AC97_MASTER_VOL_STEREO);
 		state->card->ac97_status = vol & VOL_MUTED;
-
-		/* Set S/PDIF transmitter sample rate */
-		aud_reg = i810_ac97_get(codec, AC97_SPDIF_CONTROL);
-		switch ( rate ) {
-			case 32000:
-				aud_reg = (aud_reg & AC97_SC_SPSR_MASK) | AC97_SC_SPSR_32K; 
-				break;
-			 case 44100:
-			 	aud_reg = (aud_reg & AC97_SC_SPSR_MASK) | AC97_SC_SPSR_44K; 
-				break;
-			case 48000:
-			 	aud_reg = (aud_reg & AC97_SC_SPSR_MASK) | AC97_SC_SPSR_48K; 
-				break;
-			default:
-#ifdef DEBUG
-				printk(KERN_WARNING "i810_audio: %d sample rate not supported by S/PDIF.\n", rate);
-#endif
-				/* turn off S/PDIF */
-				aud_reg = i810_ac97_get(codec, AC97_EXTENDED_STATUS);
-				i810_ac97_set(codec, AC97_EXTENDED_STATUS, (aud_reg & ~AC97_EA_SPDIF));
-				state->card->ac97_status &= ~SPDIF_ON;
-				return;
-		}
-
-		i810_ac97_set(codec, AC97_SPDIF_CONTROL, aud_reg);
 		
-		aud_reg = i810_ac97_get(codec, AC97_EXTENDED_STATUS);
-		aud_reg = (aud_reg & AC97_EA_SLOT_MASK) | slots | AC97_EA_VRA | AC97_EA_SPDIF;
-		i810_ac97_set(codec, AC97_EXTENDED_STATUS, aud_reg);
-		state->card->ac97_status |= SPDIF_ON;
-
-		/* Check to make sure the configuration is valid */
-		aud_reg = i810_ac97_get(codec, AC97_EXTENDED_STATUS);
-		if ( ! (aud_reg & 0x0400) ) {
-#ifdef DEBUG
-			printk(KERN_WARNING "i810_audio: S/PDIF transmitter configuration not valid (0x%04x).\n", aud_reg);
-#endif
+		r = codec->codec_ops->digital(codec, slots, rate, 0);
 
-			/* turn off S/PDIF */
-			i810_ac97_set(codec, AC97_EXTENDED_STATUS, (aud_reg & ~AC97_EA_SPDIF));
+		if(r)
+			state->card->ac97_status |= SPDIF_ON;
+		else
 			state->card->ac97_status &= ~SPDIF_ON;
-			return;
-		}
+
 		/* Mute the analog output */
 		/* Should this only mute the PCM volume??? */
 		i810_ac97_set(codec, AC97_MASTER_VOL_STEREO, (vol | VOL_MUTED));
 	}
+	return r;
 }
 
 /* i810_set_dac_channels
@@ -642,8 +615,9 @@
 {
 	int	aud_reg;
 	struct ac97_codec *codec = state->card->ac97_codec[0];
-
+	
 	/* No codec, no setup */
+	
 	if(codec == NULL)
 		return;
 
@@ -905,7 +879,7 @@
 #define DMABUF_DEFAULTORDER (16-PAGE_SHIFT)
 #define DMABUF_MINORDER 1
 
-/* allocate DMA buffer, playback and recording buffer should be allocated separately */
+/* allocate DMA buffer, playback and recording buffer should be allocated seperately */
 static int alloc_dmabuf(struct i810_state *state)
 {
 	struct dmabuf *dmabuf = &state->dmabuf;
@@ -1835,6 +1809,7 @@
 		}
 
 		spin_unlock_irqrestore(&state->card->lock, flags);
+		synchronize_irq(state->card->pci_dev->irq);
 		dmabuf->ready = 0;
 		dmabuf->swptr = dmabuf->hwptr = 0;
 		dmabuf->count = dmabuf->total_bytes = 0;
@@ -2493,11 +2468,9 @@
 	}
 	if(file->f_mode & FMODE_WRITE) {
 		if((dmabuf->write_channel = card->alloc_pcm_channel(card)) == NULL) {
-			/* free any read channel allocated earlier */
+			/* make sure we free the record channel allocated above */
 			if(file->f_mode & FMODE_READ)
-				card->free_pcm_channel(card,
-						dmabuf->read_channel->num);
-
+				card->free_pcm_channel(card,dmabuf->read_channel->num);
 			kfree (card->states[i]);
 			card->states[i] = NULL;;
 			return -EBUSY;
@@ -2641,23 +2614,32 @@
 static u16 i810_ac97_get(struct ac97_codec *dev, u8 reg)
 {
 	struct i810_card *card = dev->private_data;
+	u16 ret;
+	
+	spin_lock(&card->ac97_lock);
 	if (card->use_mmio) {
-		return i810_ac97_get_mmio(dev, reg);
+		ret = i810_ac97_get_mmio(dev, reg);
 	}
 	else {
-		return i810_ac97_get_io(dev, reg);
+		ret = i810_ac97_get_io(dev, reg);
 	}
+	spin_unlock(&card->ac97_lock);
+	
+	return ret;
 }
 
 static void i810_ac97_set(struct ac97_codec *dev, u8 reg, u16 data)
 {
 	struct i810_card *card = dev->private_data;
+	
+	spin_lock(&card->ac97_lock);
 	if (card->use_mmio) {
 		i810_ac97_set_mmio(dev, reg, data);
 	}
 	else {
 		i810_ac97_set_io(dev, reg, data);
 	}
+	spin_unlock(&card->ac97_lock);
 }
 
 
@@ -2803,7 +2785,7 @@
 	 */	
 	/* see i810_ac97_init for the next 7 lines (jsaw) */
 	inw(card->ac97base);
-	if ((card->pci_id == PCI_DEVICE_ID_INTEL_ICH4)
+	if ((card->pci_id == PCI_DEVICE_ID_INTEL_ICH4 || card->pci_id == PCI_DEVICE_ID_INTEL_ICH5)
 	    && (card->use_mmio)) {
 		primary_codec_id = (int) readl(card->iobase_mmio + SDM) & 0x3;
 		printk(KERN_INFO "i810_audio: Primary codec has ID %d\n",
@@ -2873,7 +2855,7 @@
 		   possible IO channels. Bit 0:1 of SDM then holds the 
 		   last codec ID spoken to. 
 		*/
-		if ((card->pci_id == PCI_DEVICE_ID_INTEL_ICH4)
+		if ((card->pci_id == PCI_DEVICE_ID_INTEL_ICH4 || card->pci_id == PCI_DEVICE_ID_INTEL_ICH5)
 		    && (card->use_mmio)) {
 			ac97_id = (int) readl(card->iobase_mmio + SDM) & 0x3;
 			printk(KERN_INFO "i810_audio: Connection %d with codec id %d\n",
@@ -2892,9 +2874,8 @@
 				printk(KERN_ERR "i810_audio: Primary codec not ready.\n");
 		}
 		
-		if ((codec = kmalloc(sizeof(struct ac97_codec), GFP_KERNEL)) == NULL)
+		if ((codec = ac97_alloc_codec()) == NULL)
 			return -ENOMEM;
-		memset(codec, 0, sizeof(struct ac97_codec));
 
 		/* initialize some basic codec information, other fields will be filled
 		   in ac97_probe_codec */
@@ -2913,7 +2894,7 @@
 	
 		if(!i810_ac97_probe_and_powerup(card,codec)) {
 			printk(KERN_ERR "i810_audio: timed out waiting for codec %d analog ready.\n", ac97_id);
-			kfree(codec);
+			ac97_release_codec(codec);
 			break;	/* it didn't work */
 		}
 		/* Store state information about S/PDIF transmitter */
@@ -2922,32 +2903,22 @@
 		/* Don't attempt to get eid until powerup is complete */
 		eid = i810_ac97_get(codec, AC97_EXTENDED_ID);
 
-		if(eid==0xFFFFFF)
+		if(eid==0xFFFF)
 		{
 			printk(KERN_WARNING "i810_audio: no codec attached ?\n");
-			kfree(codec);
+			ac97_release_codec(codec);
 			break;
 		}
 		
 		/* Check for an AC97 1.0 soft modem (ID1) */
 		
-		if(codec->codec_read(codec, AC97_RESET) & 2)
+		if(codec->modem)
 		{
-			printk(KERN_WARNING "i810_audio: codec %d is an AC97 1.0 softmodem - skipping.\n", ac97_id);
-			kfree(codec);
+			printk(KERN_WARNING "i810_audio: codec %d is a softmodem - skipping.\n", ac97_id);
+			ac97_release_codec(codec);
 			continue;
 		}
 		
-		/* Check for an AC97 2.x soft modem */
-		
-		codec->codec_write(codec, AC97_EXTENDED_MODEM_ID, 0L);
-		if(codec->codec_read(codec, AC97_EXTENDED_MODEM_ID) & 1)
-		{
-			printk(KERN_WARNING "i810_audio: codec %d is an AC97 2.x softmodem - skipping.\n", ac97_id);
-			kfree(codec);
-			continue;
-		}
-	
 		card->ac97_features = eid;
 
 		/* Now check the codec for useful features to make up for
@@ -3027,7 +2998,7 @@
 
 		if ((codec->dev_mixer = register_sound_mixer(&i810_mixer_fops, -1)) < 0) {
 			printk(KERN_ERR "i810_audio: couldn't register mixer!\n");
-			kfree(codec);
+			ac97_release_codec(codec);
 			break;
 		}
 
@@ -3158,6 +3129,7 @@
 	card->pm_suspended=0;
 #endif
 	spin_lock_init(&card->lock);
+	spin_lock_init(&card->ac97_lock);
 	devs = card;
 
 	pci_set_master(pci_dev);
@@ -3253,7 +3225,7 @@
 		for (i = 0; i < NR_AC97; i++)
 		if (card->ac97_codec[i] != NULL) {
 			unregister_sound_mixer(card->ac97_codec[i]->dev_mixer);
-			kfree (card->ac97_codec[i]);
+			ac97_release_codec(card->ac97_codec[i]);
 		}
 		goto out_iospace;
 	}
@@ -3297,7 +3269,7 @@
 	for (i = 0; i < NR_AC97; i++)
 		if (card->ac97_codec[i] != NULL) {
 			unregister_sound_mixer(card->ac97_codec[i]->dev_mixer);
-			kfree (card->ac97_codec[i]);
+			ac97_release_codec(card->ac97_codec[i]);
 			card->ac97_codec[i] = NULL;
 		}
 	unregister_sound_dsp(card->dev_audio);
