Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265039AbTGKSmn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbTGKSh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:37:56 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24452
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264994AbTGKSEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:04:16 -0400
Date: Fri, 11 Jul 2003 19:18:02 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111818.h6BII2kA017410@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: update via audio driver, make it work on esd add new chips
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/via82cxxx_audio.c linux-2.5.75-ac1/sound/oss/via82cxxx_audio.c
--- linux-2.5.75/sound/oss/via82cxxx_audio.c	2003-07-10 21:06:55.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/via82cxxx_audio.c	2003-07-11 17:31:26.000000000 +0100
@@ -2,17 +2,20 @@
  * Support for VIA 82Cxxx Audio Codecs
  * Copyright 1999,2000 Jeff Garzik
  *
+ * Updated to support the VIA 8233/8235 audio subsystem
+ * Alan Cox <alan@redhat.com> (C) Copyright 2002, 2003 Red Hat Inc
+ *
  * Distributed under the GNU GENERAL PUBLIC LICENSE (GPL) Version 2.
  * See the "COPYING" file distributed with this software for more info.
+ * NO WARRANTY
  *
  * For a list of known bugs (errata) and documentation,
  * see via-audio.pdf in linux/Documentation/DocBook.
  * If this documentation does not exist, run "make pdfdocs".
- *
  */
 
 
-#define VIA_VERSION	"1.9.1"
+#define VIA_VERSION	"1.9.1-ac3-2.5"
 
 
 #include <linux/config.h>
@@ -81,10 +84,13 @@
 #define VIA_DEFAULT_FRAG_TIME		20
 #define VIA_DEFAULT_BUFFER_TIME		500
 
+/* the hardware has a 256 fragment limit */
+#define VIA_MIN_FRAG_NUMBER		2
+#define VIA_MAX_FRAG_NUMBER		128
+
 #define VIA_MAX_FRAG_SIZE		PAGE_SIZE
-#define VIA_MIN_FRAG_SIZE		64
+#define VIA_MIN_FRAG_SIZE		(VIA_MAX_BUFFER_DMA_PAGES * PAGE_SIZE / VIA_MAX_FRAG_NUMBER)
 
-#define VIA_MIN_FRAG_NUMBER		2
 
 /* 82C686 function 5 (audio codec) PCI configuration registers */
 #define VIA_ACLINK_STATUS	0x40
@@ -116,7 +122,10 @@
 #define VIA_PCM_STATUS			0x00
 #define VIA_PCM_CONTROL			0x01
 #define VIA_PCM_TYPE			0x02
+#define VIA_PCM_LEFTVOL			0x02
+#define VIA_PCM_RIGHTVOL		0x03
 #define VIA_PCM_TABLE_ADDR		0x04
+#define VIA_PCM_STOPRATE		0x08	/* 8233+ */
 #define VIA_PCM_BLOCK_COUNT		0x0C
 
 /* XXX unused DMA channel for FM PCM data */
@@ -125,6 +134,12 @@
 #define VIA_BASE0_FM_OUT_CHAN_CTRL	0x21
 #define VIA_BASE0_FM_OUT_CHAN_TYPE	0x22
 
+/* Six channel audio output on 8233 */
+#define VIA_BASE0_MULTI_OUT_CHAN		0x40
+#define VIA_BASE0_MULTI_OUT_CHAN_STATUS		0x40
+#define VIA_BASE0_MULTI_OUT_CHAN_CTRL		0x41
+#define VIA_BASE0_MULTI_OUT_CHAN_TYPE		0x42
+
 #define VIA_BASE0_AC97_CTRL		0x80
 #define VIA_BASE0_SGD_STATUS_SHADOW	0x84
 #define VIA_BASE0_GPI_INT_ENABLE	0x8C
@@ -133,6 +148,12 @@
 #define VIA_INTR_FM			((1<<2) |  (1<<6) | (1<<10))
 #define VIA_INTR_MASK		(VIA_INTR_OUT | VIA_INTR_IN | VIA_INTR_FM)
 
+/* Newer VIA we need to monitor the low 3 bits of each channel. This
+   mask covers the channels we don't yet use as well 
+ */
+ 
+#define VIA_NEW_INTR_MASK		0x77077777UL
+
 /* VIA_BASE0_AUDIO_xxx_CHAN_TYPE bits */
 #define VIA_IRQ_ON_FLAG			(1<<0)	/* int on each flagged scatter block */
 #define VIA_IRQ_ON_EOL			(1<<1)	/* int at end of scatter list */
@@ -250,11 +271,15 @@
 	unsigned is_record : 1;
 	unsigned is_mapped : 1;
 	unsigned is_enabled : 1;
+	unsigned is_multi: 1;	/* 8233 6 channel */
 	u8 pcm_fmt;		/* VIA_PCM_FMT_xxx */
+	u8 channels;		/* Channel count */
 
 	unsigned rate;		/* sample rate */
 	unsigned int frag_size;
 	unsigned int frag_number;
+	
+	unsigned char intmask;
 
 	volatile struct via_sgd_table *sgtable;
 	dma_addr_t sgt_handle;
@@ -273,19 +298,31 @@
 	struct pci_dev *pdev;
 	long baseaddr;
 
-	struct ac97_codec ac97;
+	struct ac97_codec *ac97;
+	spinlock_t ac97_lock;
 	spinlock_t lock;
 	int card_num;		/* unique card number, from 0 */
 
 	int dev_dsp;		/* /dev/dsp index from register_sound_dsp() */
 
 	unsigned rev_h : 1;
+	unsigned legacy: 1;	/* Has legacy ports */
+	unsigned intmask: 1;	/* Needs int bits */
+	unsigned sixchannel: 1;	/* 8233/35 with 6 channel support */
+	unsigned volume: 1;
 
 	int locked_rate : 1;
+	
+	int mixer_vol;		/* 8233/35 volume  - not yet implemented */
 
 	struct semaphore syscall_sem;
 	struct semaphore open_sem;
 
+	/* The 8233/8235 have 4 DX audio channels, two record and
+	   one six channel out. We bind ch_in to DX 1, ch_out to multichannel
+	   and ch_fm to DX 2. DX 3 and REC0/REC1 are unused at the
+	   moment */
+	   
 	struct via_channel ch_in;
 	struct via_channel ch_out;
 	struct via_channel ch_fm;
@@ -352,17 +389,19 @@
 
 static struct pci_device_id via_pci_tbl[] __initdata = {
 	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5,
-	  PCI_ANY_ID, PCI_ANY_ID, },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8233_5,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci,via_pci_tbl);
 
 
 static struct pci_driver via_driver = {
-	.name		= VIA_MODULE_NAME,
-	.id_table	= via_pci_tbl,
-	.probe		= via_init_one,
-	.remove		= __devexit_p(via_remove_one),
+	name:		VIA_MODULE_NAME,
+	id_table:	via_pci_tbl,
+	probe:		via_init_one,
+	remove:		__devexit_p(via_remove_one),
 };
 
 
@@ -426,7 +465,13 @@
 
 static inline void sg_begin (struct via_channel *chan)
 {
-	outb (VIA_SGD_START, chan->iobase + VIA_PCM_CONTROL);
+	DPRINTK("Start with intmask %d\n", chan->intmask);
+	DPRINTK("About to start from %d to %d\n", 
+		inl(chan->iobase + VIA_PCM_BLOCK_COUNT),
+		inb(chan->iobase + VIA_PCM_STOPRATE + 3));
+	outb (VIA_SGD_START|chan->intmask, chan->iobase + VIA_PCM_CONTROL);
+	DPRINTK("Status is now %02X\n", inb(chan->iobase + VIA_PCM_STATUS));
+	DPRINTK("Control is now %02X\n", inb(chan->iobase + VIA_PCM_CONTROL));
 }
 
 
@@ -442,6 +487,10 @@
 	return 0;
 }
 
+static int via_sg_offset(struct via_channel *chan)
+{
+	return inl (chan->iobase + VIA_PCM_BLOCK_COUNT) & 0x00FFFFFF;
+}
 
 /****************************************************************
  *
@@ -505,6 +554,8 @@
 	via_chan_stop (card->baseaddr + VIA_BASE0_PCM_OUT_CHAN);
 	via_chan_stop (card->baseaddr + VIA_BASE0_PCM_IN_CHAN);
 	via_chan_stop (card->baseaddr + VIA_BASE0_FM_OUT_CHAN);
+	if(card->sixchannel)
+		via_chan_stop (card->baseaddr + VIA_BASE0_MULTI_OUT_CHAN);
 
 	/*
 	 * clear any existing stops / flags (sanity check mainly)
@@ -512,6 +563,8 @@
 	via_chan_status_clear (card->baseaddr + VIA_BASE0_PCM_OUT_CHAN);
 	via_chan_status_clear (card->baseaddr + VIA_BASE0_PCM_IN_CHAN);
 	via_chan_status_clear (card->baseaddr + VIA_BASE0_FM_OUT_CHAN);
+	if(card->sixchannel)
+		via_chan_status_clear (card->baseaddr + VIA_BASE0_MULTI_OUT_CHAN);
 
 	/*
 	 * clear any enabled interrupt bits
@@ -531,6 +584,14 @@
 	if (tmp != new_tmp)
 		outb (0, card->baseaddr + VIA_BASE0_FM_OUT_CHAN_TYPE);
 
+	if(card->sixchannel)
+	{
+		tmp = inb (card->baseaddr + VIA_BASE0_MULTI_OUT_CHAN_TYPE);
+		new_tmp = tmp & ~(VIA_IRQ_ON_FLAG|VIA_IRQ_ON_EOL|VIA_RESTART_SGD_ON_EOL);
+		if (tmp != new_tmp)
+			outb (0, card->baseaddr + VIA_BASE0_MULTI_OUT_CHAN_TYPE);
+	}
+
 	udelay(10);
 
 	/*
@@ -561,6 +622,9 @@
 {
 	struct via_info *card = ac97->private_data;
 	int rate_reg;
+	u32 dacp;
+	u32 mast_vol, phone_vol, mono_vol, pcm_vol;
+	u32 mute_vol = 0x8000;	/* The mute volume? -- Seems to work! */
 
 	DPRINTK ("ENTER, rate = %d\n", rate);
 
@@ -577,16 +641,32 @@
 	rate_reg = chan->is_record ? AC97_PCM_LR_ADC_RATE :
 			    AC97_PCM_FRONT_DAC_RATE;
 
-	via_ac97_write_reg (ac97, AC97_POWER_CONTROL,
-		(via_ac97_read_reg (ac97, AC97_POWER_CONTROL) & ~0x0200) |
-		0x0200);
+	/* Save current state */
+	dacp=via_ac97_read_reg(ac97, AC97_POWER_CONTROL);
+	mast_vol = via_ac97_read_reg(ac97, AC97_MASTER_VOL_STEREO);
+	mono_vol = via_ac97_read_reg(ac97, AC97_MASTER_VOL_MONO);
+	phone_vol = via_ac97_read_reg(ac97, AC97_HEADPHONE_VOL);
+	pcm_vol = via_ac97_read_reg(ac97, AC97_PCMOUT_VOL);
+	/* Mute - largely reduces popping */
+	via_ac97_write_reg(ac97, AC97_MASTER_VOL_STEREO, mute_vol);
+	via_ac97_write_reg(ac97, AC97_MASTER_VOL_MONO, mute_vol);
+	via_ac97_write_reg(ac97, AC97_HEADPHONE_VOL, mute_vol);
+       	via_ac97_write_reg(ac97, AC97_PCMOUT_VOL, mute_vol);
+	/* Power down the DAC */
+	via_ac97_write_reg(ac97, AC97_POWER_CONTROL, dacp|0x0200);
 
+        /* Set new rate */
 	via_ac97_write_reg (ac97, rate_reg, rate);
 
-	via_ac97_write_reg (ac97, AC97_POWER_CONTROL,
-		via_ac97_read_reg (ac97, AC97_POWER_CONTROL) & ~0x0200);
-
-	udelay (10);
+	/* Power DAC back up */
+	via_ac97_write_reg(ac97, AC97_POWER_CONTROL, dacp);
+	udelay (200); /* reduces popping */
+
+	/* Restore volumes */
+	via_ac97_write_reg(ac97, AC97_MASTER_VOL_STEREO, mast_vol);
+	via_ac97_write_reg(ac97, AC97_MASTER_VOL_MONO, mono_vol);
+	via_ac97_write_reg(ac97, AC97_HEADPHONE_VOL, phone_vol);
+	via_ac97_write_reg(ac97, AC97_PCMOUT_VOL, pcm_vol);
 
 	/* the hardware might return a value different than what we
 	 * passed to it, so read the rate value back from hardware
@@ -626,9 +706,19 @@
 {
 	memset (chan, 0, sizeof (*chan));
 
+	if(card->intmask)
+		chan->intmask = 0x23;	/* Turn on the IRQ bits */
+		
 	if (chan == &card->ch_out) {
 		chan->name = "PCM-OUT";
-		chan->iobase = card->baseaddr + VIA_BASE0_PCM_OUT_CHAN;
+		if(card->sixchannel)
+		{
+			chan->iobase = card->baseaddr + VIA_BASE0_MULTI_OUT_CHAN;
+			chan->is_multi = 1;
+			DPRINTK("Using multichannel for pcm out\n");
+		}
+		else
+			chan->iobase = card->baseaddr + VIA_BASE0_PCM_OUT_CHAN;
 	} else if (chan == &card->ch_in) {
 		chan->name = "PCM-IN";
 		chan->iobase = card->baseaddr + VIA_BASE0_PCM_IN_CHAN;
@@ -659,9 +749,8 @@
  *      Performs some of the preparations necessary to begin
  *      using a PCM channel.
  *
- *      Currently the preparations consist in
- *      setting the
- *      PCM channel to a known state.
+ *      Currently the preparations consist of
+ *      setting the PCM channel to a known state.
  */
 
 
@@ -707,6 +796,11 @@
 
 	DPRINTK ("ENTER\n");
 
+
+	chan->intmask = 0;
+	if(card->intmask)
+		chan->intmask = 0x23;	/* Turn on the IRQ bits */
+		
 	if (chan->sgtable != NULL) {
 		DPRINTK ("EXIT\n");
 		return 0;
@@ -777,6 +871,16 @@
 	outl (chan->sgt_handle, chan->iobase + VIA_PCM_TABLE_ADDR);
 	udelay (20);
 	via_ac97_wait_idle (card);
+	/* load no rate adaption, stereo 16bit, set up ring slots */
+	if(card->sixchannel)
+	{
+		if(!chan->is_multi)
+		{
+			outl (0xFFFFF | (0x3 << 20) | (chan->frag_number << 24), chan->iobase + VIA_PCM_STOPRATE);
+			udelay (20);
+			via_ac97_wait_idle (card);
+		}
+	}
 
 	DPRINTK ("inl (0x%lX) = %x\n",
 		chan->iobase + VIA_PCM_TABLE_ADDR,
@@ -880,8 +984,11 @@
 	assert (chan != NULL);
 
 	if (reset)
+	{
 		/* reset to 8-bit mono mode */
 		chan->pcm_fmt = 0;
+		chan->channels = 1;
+	}
 
 	/* enable interrupts on FLAG and EOL */
 	chan->pcm_fmt |= VIA_CHAN_TYPE_MASK;
@@ -892,8 +999,83 @@
 	/* set interrupt select bits where applicable (PCM in & out channels) */
 	if (!chan->is_record)
 		chan->pcm_fmt |= VIA_CHAN_TYPE_INT_SELECT;
+	
+	DPRINTK("SET FMT - %02x %02x\n", chan->intmask , chan->is_multi);
+	
+	if(chan->intmask)
+	{
+		u32 m;
+
+		/*
+		 *	Channel 0x4 is up to 6 x 16bit and has to be
+		 *	programmed differently 
+		 */
+		 		
+		if(chan->is_multi)
+		{
+			u8 c = 0;
+			
+			/*
+			 *	Load the type bit for num channels
+			 *	and 8/16bit
+			 */
+			 
+			if(chan->pcm_fmt & VIA_PCM_FMT_16BIT)
+				c = 1 << 7;
+			if(chan->pcm_fmt & VIA_PCM_FMT_STEREO)
+				c |= (2<<4);
+			else
+				c |= (1<<4);
+				
+			outb(c, chan->iobase + VIA_PCM_TYPE);
+			
+			/*
+			 *	Set the channel steering
+			 *	Mono
+			 *		Channel 0 to slot 3
+			 *		Channel 0 to slot 4
+			 *	Stereo
+			 *		Channel 0 to slot 3
+			 *		Channel 1 to slot 4
+			 */
+			 
+			switch(chan->channels)
+			{
+				case 1:
+					outl(0xFF000000 | (1<<0) | (1<<4) , chan->iobase + VIA_PCM_STOPRATE);
+					break;
+				case 2:
+					outl(0xFF000000 | (1<<0) | (2<<4) , chan->iobase + VIA_PCM_STOPRATE);
+					break;
+				case 4:
+					outl(0xFF000000 | (1<<0) | (2<<4) | (3<<8) | (4<<12), chan->iobase + VIA_PCM_STOPRATE);
+					break;
+				case 6:
+					outl(0xFF000000 | (1<<0) | (2<<4) | (5<<8) | (6<<12) | (3<<16) | (4<<20), chan->iobase + VIA_PCM_STOPRATE);
+					break;
+			}				
+		}
+		else
+		{
+			/*
+			 *	New style, turn off channel volume
+			 *	control, set bits in the right register
+			 */	
+			outb(0x0, chan->iobase + VIA_PCM_LEFTVOL);
+			outb(0x0, chan->iobase + VIA_PCM_RIGHTVOL);
+
+			m = inl(chan->iobase + VIA_PCM_STOPRATE);
+			m &= ~(3<<20);
+			if(chan->pcm_fmt & VIA_PCM_FMT_STEREO)
+				m |= (1 << 20);
+			if(chan->pcm_fmt & VIA_PCM_FMT_16BIT)
+				m |= (1 << 21);
+			outl(m, chan->iobase + VIA_PCM_STOPRATE);
+		}		
+	}
+	else
+		outb (chan->pcm_fmt, chan->iobase + VIA_PCM_TYPE);
 
-	outb (chan->pcm_fmt, chan->iobase + VIA_PCM_TYPE);
 
 	DPRINTK ("EXIT, pcm_fmt = 0x%02X, reg = 0x%02X\n",
 		 chan->pcm_fmt,
@@ -948,7 +1130,7 @@
 
 	via_chan_clear (card, chan);
 
-	val = via_set_rate (&card->ac97, chan, val);
+	val = via_set_rate (card->ac97, chan, val);
 
 	DPRINTK ("EXIT, returning %d\n", val);
 	return val;
@@ -1034,15 +1216,25 @@
 	/* mono */
 	case 1:
 		chan->pcm_fmt &= ~VIA_PCM_FMT_STEREO;
+		chan->channels = 1;
 		via_chan_pcm_fmt (chan, 0);
 		break;
 
 	/* stereo */
 	case 2:
 		chan->pcm_fmt |= VIA_PCM_FMT_STEREO;
+		chan->channels = 2;
 		via_chan_pcm_fmt (chan, 0);
 		break;
 
+	case 4:
+	case 6:
+		if(chan->is_multi)
+		{
+			chan->pcm_fmt |= VIA_PCM_FMT_STEREO;
+			chan->channels = val;
+			break;
+		}
 	/* unknown */
 	default:
 		printk (KERN_WARNING PFX "unknown number of channels\n");
@@ -1076,9 +1268,8 @@
 
 		DPRINTK ("\n");
 
-		chan->frag_size = (VIA_DEFAULT_FRAG_TIME * chan->rate *
-				   ((chan->pcm_fmt & VIA_PCM_FMT_STEREO) ? 2 : 1) *
-				   ((chan->pcm_fmt & VIA_PCM_FMT_16BIT) ? 2 : 1)) / 1000 - 1;
+		chan->frag_size = (VIA_DEFAULT_FRAG_TIME * chan->rate * chan->channels
+				   * ((chan->pcm_fmt & VIA_PCM_FMT_16BIT) ? 2 : 1)) / 1000 - 1;
 
 		shift = 0;
 		while (chan->frag_size) {
@@ -1112,6 +1303,8 @@
 
 	if (chan->frag_number < VIA_MIN_FRAG_NUMBER)
                 chan->frag_number = VIA_MIN_FRAG_NUMBER;
+        if (chan->frag_number > VIA_MAX_FRAG_NUMBER)
+        	chan->frag_number = VIA_MAX_FRAG_NUMBER;
 
 	if ((chan->frag_number * chan->frag_size) / PAGE_SIZE > VIA_MAX_BUFFER_DMA_PAGES)
 		chan->frag_number = (VIA_MAX_BUFFER_DMA_PAGES * PAGE_SIZE) / chan->frag_size;
@@ -1156,7 +1349,7 @@
 
 /**
  *	via_chan_flush_frag - Flush partially-full playback buffer to hardware
- *	@chan: Channel whose DMA table will be displayed
+ *	@chan: Channel whose DMA table will be flushed
  *
  *	Flushes partially-full playback buffer to hardware.
  */
@@ -1194,6 +1387,7 @@
 {
 	assert (chan->is_active == sg_active(chan->iobase));
 
+	DPRINTK ("MAYBE START %s\n", chan->name);
 	if (!chan->is_active && chan->is_enabled) {
 		chan->is_active = 1;
 		sg_begin (chan);
@@ -1267,6 +1461,8 @@
 	assert (codec->private_data != NULL);
 
 	card = codec->private_data;
+	
+	spin_lock(&card->ac97_lock);
 
 	/* Every time we write to register 80 we cause a transaction.
 	   The only safe way to clear the valid bit is to write it at
@@ -1297,6 +1493,7 @@
 	if (((data & 0x007F0000) >> 16) == reg) {
 		DPRINTK ("EXIT, success, data=0x%lx, retval=0x%lx\n",
 			 data, data & 0x0000FFFF);
+		spin_unlock(&card->ac97_lock);
 		return data & 0x0000FFFF;
 	}
 
@@ -1304,6 +1501,7 @@
 		reg, ((data & 0x007F0000) >> 16));
 
 err_out:
+	spin_unlock(&card->ac97_lock);
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
 }
@@ -1335,6 +1533,8 @@
 
 	card = codec->private_data;
 
+	spin_lock(&card->ac97_lock);
+	
 	data = (reg << 16) + value;
 	outl (data, card->baseaddr + VIA_BASE0_AC97_CTRL);
 	udelay (10);
@@ -1349,6 +1549,7 @@
 	printk (KERN_WARNING PFX "timeout after AC97 codec write (0x%X, 0x%X)\n", reg, value);
 
 out:
+	spin_unlock(&card->ac97_lock);
 	DPRINTK ("EXIT\n");
 }
 
@@ -1368,7 +1569,7 @@
 			assert (pci_get_drvdata (pdev) != NULL);
 
 			card = pci_get_drvdata (pdev);
-			if (card->ac97.dev_mixer == minor)
+			if (card->ac97->dev_mixer == minor)
 				goto match;
 		}
 	}
@@ -1377,7 +1578,7 @@
 	return -ENODEV;
 
 match:
-	file->private_data = &card->ac97;
+	file->private_data = card->ac97;
 
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
@@ -1399,7 +1600,30 @@
 
 	rc = via_syscall_down (card, nonblock);
 	if (rc) goto out;
-
+	
+#if 0
+	/*
+	 *	Intercept volume control on 8233 and 8235
+	 */
+	if(card->volume)
+	{
+		switch(cmd)
+		{
+			case SOUND_MIXER_READ_VOLUME:
+				return card->mixer_vol;
+			case SOUND_MIXER_WRITE_VOLUME:
+			{
+				int v;
+				if(get_user(v, (int *)arg))
+				{
+					rc = -EFAULT;
+					goto out;
+				}
+				card->mixer_vol = v;
+			}
+		}
+	}		
+#endif
 	rc = codec->mixer_ioctl(codec, cmd, arg);
 
 	up (&card->syscall_sem);
@@ -1493,25 +1717,28 @@
         	udelay (100);
 	}
 
+	if(card->legacy)
+	{
 #if 0 /* this breaks on K7M */
-	/* disable legacy stuff */
-	pci_write_config_byte (pdev, 0x42, 0x00);
-	udelay(10);
+		/* disable legacy stuff */
+		pci_write_config_byte (pdev, 0x42, 0x00);
+		udelay(10);
 #endif
 
-	/* route FM trap to IRQ, disable FM trap */
-	pci_write_config_byte (pdev, 0x48, 0x05);
-	udelay(10);
-
+		/* route FM trap to IRQ, disable FM trap */
+		pci_write_config_byte (pdev, 0x48, 0x05);
+		udelay(10);
+	}
+	
 	/* disable all codec GPI interrupts */
 	outl (0, pci_resource_start (pdev, 0) + 0x8C);
 
 	/* WARNING: this line is magic.  Remove this
 	 * and things break. */
 	/* enable variable rate */
- 	tmp16 = via_ac97_read_reg (&card->ac97, AC97_EXTENDED_STATUS);
+ 	tmp16 = via_ac97_read_reg (card->ac97, AC97_EXTENDED_STATUS);
  	if ((tmp16 & 1) == 0)
- 		via_ac97_write_reg (&card->ac97, AC97_EXTENDED_STATUS, tmp16 | 1);
+ 		via_ac97_write_reg (card->ac97, AC97_EXTENDED_STATUS, tmp16 | 1);
 
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
@@ -1534,16 +1761,20 @@
 
 	assert (card != NULL);
 
-	memset (&card->ac97, 0, sizeof (card->ac97));
-	card->ac97.private_data = card;
-	card->ac97.codec_read = via_ac97_read_reg;
-	card->ac97.codec_write = via_ac97_write_reg;
-	card->ac97.codec_wait = via_ac97_codec_wait;
+	card->ac97 = ac97_alloc_codec();
+	if(card->ac97 == NULL)
+		return -ENOMEM;
+		
+	card->ac97->private_data = card;
+	card->ac97->codec_read = via_ac97_read_reg;
+	card->ac97->codec_write = via_ac97_write_reg;
+	card->ac97->codec_wait = via_ac97_codec_wait;
 
-	card->ac97.dev_mixer = register_sound_mixer (&via_mixer_fops, -1);
-	if (card->ac97.dev_mixer < 0) {
+	card->ac97->dev_mixer = register_sound_mixer (&via_mixer_fops, -1);
+	if (card->ac97->dev_mixer < 0) {
 		printk (KERN_ERR PFX "unable to register AC97 mixer, aborting\n");
 		DPRINTK ("EXIT, returning -EIO\n");
+		ac97_release_codec(card->ac97);
 		return -EIO;
 	}
 
@@ -1552,25 +1783,27 @@
 		printk (KERN_ERR PFX "unable to reset AC97 codec, aborting\n");
 		goto err_out;
 	}
-
-	if (ac97_probe_codec (&card->ac97) == 0) {
+	
+	mdelay(10);
+	
+	if (ac97_probe_codec (card->ac97) == 0) {
 		printk (KERN_ERR PFX "unable to probe AC97 codec, aborting\n");
 		rc = -EIO;
 		goto err_out;
 	}
 
 	/* enable variable rate */
-	tmp16 = via_ac97_read_reg (&card->ac97, AC97_EXTENDED_STATUS);
-	via_ac97_write_reg (&card->ac97, AC97_EXTENDED_STATUS, tmp16 | 1);
+	tmp16 = via_ac97_read_reg (card->ac97, AC97_EXTENDED_STATUS);
+	via_ac97_write_reg (card->ac97, AC97_EXTENDED_STATUS, tmp16 | 1);
 
  	/*
  	 * If we cannot enable VRA, we have a locked-rate codec.
  	 * We try again to enable VRA before assuming so, however.
  	 */
- 	tmp16 = via_ac97_read_reg (&card->ac97, AC97_EXTENDED_STATUS);
+ 	tmp16 = via_ac97_read_reg (card->ac97, AC97_EXTENDED_STATUS);
  	if ((tmp16 & 1) == 0) {
- 		via_ac97_write_reg (&card->ac97, AC97_EXTENDED_STATUS, tmp16 | 1);
- 		tmp16 = via_ac97_read_reg (&card->ac97, AC97_EXTENDED_STATUS);
+ 		via_ac97_write_reg (card->ac97, AC97_EXTENDED_STATUS, tmp16 | 1);
+ 		tmp16 = via_ac97_read_reg (card->ac97, AC97_EXTENDED_STATUS);
  		if ((tmp16 & 1) == 0) {
  			card->locked_rate = 1;
  			printk (KERN_WARNING PFX "Codec rate locked at 48Khz\n");
@@ -1581,8 +1814,9 @@
 	return 0;
 
 err_out:
-	unregister_sound_mixer (card->ac97.dev_mixer);
+	unregister_sound_mixer (card->ac97->dev_mixer);
 	DPRINTK ("EXIT, returning %d\n", rc);
+	ac97_release_codec(card->ac97);
 	return rc;
 }
 
@@ -1592,9 +1826,10 @@
 	DPRINTK ("ENTER\n");
 
 	assert (card != NULL);
-	assert (card->ac97.dev_mixer >= 0);
+	assert (card->ac97->dev_mixer >= 0);
 
-	unregister_sound_mixer (card->ac97.dev_mixer);
+	unregister_sound_mixer (card->ac97->dev_mixer);
+	ac97_release_codec(card->ac97);
 
 	DPRINTK ("EXIT\n");
 }
@@ -1619,11 +1854,11 @@
  *	Locking: inside card->lock
  */
 
-static void via_intr_channel (struct via_channel *chan)
+static void via_intr_channel (struct via_info *card, struct via_channel *chan)
 {
 	u8 status;
 	int n;
-
+	
 	/* check pertinent bits of status register for action bits */
 	status = inb (chan->iobase) & (VIA_SGD_FLAG | VIA_SGD_EOL | VIA_SGD_STOPPED);
 	if (!status)
@@ -1642,6 +1877,7 @@
 	assert (n >= 0);
 	assert (n < chan->frag_number);
 
+	
 	/* reset SGD data structure in memory to reflect a full buffer,
 	 * and advance the h/w ptr, wrapping around to zero if needed
 	 */
@@ -1656,48 +1892,44 @@
 	/* accounting crap for SNDCTL_DSP_GETxPTR */
 	chan->n_irqs++;
 	chan->bytes += chan->frag_size;
+	/* FIXME - signed overflow is undefined */
 	if (chan->bytes < 0) /* handle overflow of 31-bit value */
 		chan->bytes = chan->frag_size;
-
+	/* all following checks only occur when not in mmap(2) mode */
+	if (!chan->is_mapped)
+	{
+		/* If we are recording, then n_frags represents the number
+		 * of fragments waiting to be handled by userspace.
+		 * If we are playback, then n_frags represents the number
+		 * of fragments remaining to be filled by userspace.
+		 * We increment here.  If we reach max number of fragments,
+		 * this indicates an underrun/overrun.  For this case under OSS,
+		 * we stop the record/playback process.
+		 */
+		if (atomic_read (&chan->n_frags) < chan->frag_number)
+			atomic_inc (&chan->n_frags);
+		assert (atomic_read (&chan->n_frags) <= chan->frag_number);
+		if (atomic_read (&chan->n_frags) == chan->frag_number) {
+			chan->is_active = 0;
+			via_chan_stop (chan->iobase);
+		}
+	}
 	/* wake up anyone listening to see when interrupts occur */
-	if (waitqueue_active (&chan->wait))
-		wake_up_all (&chan->wait);
+	wake_up_all (&chan->wait);
 
 	DPRINTK ("%s intr, status=0x%02X, hwptr=0x%lX, chan->hw_ptr=%d\n",
 		 chan->name, status, (long) inl (chan->iobase + 0x04),
 		 atomic_read (&chan->hw_ptr));
 
-	/* all following checks only occur when not in mmap(2) mode */
-	if (chan->is_mapped)
-		return;
-
-	/* If we are recording, then n_frags represents the number
-	 * of fragments waiting to be handled by userspace.
-	 * If we are playback, then n_frags represents the number
-	 * of fragments remaining to be filled by userspace.
-	 * We increment here.  If we reach max number of fragments,
-	 * this indicates an underrun/overrun.  For this case under OSS,
-	 * we stop the record/playback process.
-	 */
-	if (atomic_read (&chan->n_frags) < chan->frag_number)
-		atomic_inc (&chan->n_frags);
-	assert (atomic_read (&chan->n_frags) <= chan->frag_number);
-
-	if (atomic_read (&chan->n_frags) == chan->frag_number) {
-		chan->is_active = 0;
-		via_chan_stop (chan->iobase);
-	}
-
-	DPRINTK ("%s intr, channel n_frags == %d\n", chan->name,
-		 atomic_read (&chan->n_frags));
+	DPRINTK ("%s intr, channel n_frags == %d, missed %d\n", chan->name,
+		 atomic_read (&chan->n_frags), missed);
 }
 
 
-static irqreturn_t via_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t  via_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct via_info *card = dev_id;
 	u32 status32;
-	int handled = 0;
 
 	/* to minimize interrupt sharing costs, we use the SGD status
 	 * shadow register to check the status of all inputs and
@@ -1708,12 +1940,10 @@
 	if (!(status32 & VIA_INTR_MASK))
         {
 #ifdef CONFIG_MIDI_VIA82CXXX
-	    	 if (card->midi_devc) {
+	    	 if (card->midi_devc)
                     	uart401intr(irq, card->midi_devc, regs);
-			handled = 1;
-		}
 #endif
-		goto out;
+		return IRQ_HANDLED;
     	}
 	DPRINTK ("intr, status32 == 0x%08X\n", status32);
 
@@ -1722,21 +1952,42 @@
 	 */
 	spin_lock (&card->lock);
 
-	if (status32 & VIA_INTR_OUT) {
-		handled = 1;
-		via_intr_channel (&card->ch_out);
-	}
-	if (status32 & VIA_INTR_IN) {
-		handled = 1;
-		via_intr_channel (&card->ch_in);
-	}
-	if (status32 & VIA_INTR_FM) {
-		handled = 1;
-		via_intr_channel (&card->ch_fm);
-	}
+	if (status32 & VIA_INTR_OUT)
+		via_intr_channel (card, &card->ch_out);
+	if (status32 & VIA_INTR_IN)
+		via_intr_channel (card, &card->ch_in);
+	if (status32 & VIA_INTR_FM)
+		via_intr_channel (card, &card->ch_fm);
+
 	spin_unlock (&card->lock);
-out:
-	return IRQ_RETVAL(handled);
+	
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t via_new_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct via_info *card = dev_id;
+	u32 status32;
+
+	/* to minimize interrupt sharing costs, we use the SGD status
+	 * shadow register to check the status of all inputs and
+	 * outputs with a single 32-bit bus read.  If no interrupt
+	 * conditions are flagged, we exit immediately
+	 */
+	status32 = inl (card->baseaddr + VIA_BASE0_SGD_STATUS_SHADOW);
+	if (!(status32 & VIA_NEW_INTR_MASK))
+		return IRQ_NONE;
+	/*
+	 * goes away completely on UP
+	 */
+	spin_lock (&card->lock);
+
+	via_intr_channel (card, &card->ch_out);
+	via_intr_channel (card, &card->ch_in);
+	via_intr_channel (card, &card->ch_fm);
+
+	spin_unlock (&card->lock);
+	return IRQ_HANDLED;
 }
 
 
@@ -1766,18 +2017,32 @@
 		return -EIO;
 	}
 
-	/* make sure FM irq is not routed to us */
-	pci_read_config_byte (card->pdev, VIA_FM_NMI_CTRL, &tmp8);
-	if ((tmp8 & VIA_CR48_FM_TRAP_TO_NMI) == 0) {
-		tmp8 |= VIA_CR48_FM_TRAP_TO_NMI;
-		pci_write_config_byte (card->pdev, VIA_FM_NMI_CTRL, tmp8);
+	/* VIA requires this is done */
+	pci_write_config_byte(card->pdev, PCI_INTERRUPT_LINE, card->pdev->irq);
+	
+	if(card->legacy)
+	{
+		/* make sure FM irq is not routed to us */
+		pci_read_config_byte (card->pdev, VIA_FM_NMI_CTRL, &tmp8);
+		if ((tmp8 & VIA_CR48_FM_TRAP_TO_NMI) == 0) {
+			tmp8 |= VIA_CR48_FM_TRAP_TO_NMI;
+			pci_write_config_byte (card->pdev, VIA_FM_NMI_CTRL, tmp8);
+		}
+		if (request_irq (card->pdev->irq, via_interrupt, SA_SHIRQ, VIA_MODULE_NAME, card)) {
+			printk (KERN_ERR PFX "unable to obtain IRQ %d, aborting\n",
+				card->pdev->irq);
+			DPRINTK ("EXIT, returning -EBUSY\n");
+			return -EBUSY;
+		}
 	}
-
-	if (request_irq (card->pdev->irq, via_interrupt, SA_SHIRQ, VIA_MODULE_NAME, card)) {
-		printk (KERN_ERR PFX "unable to obtain IRQ %d, aborting\n",
-			card->pdev->irq);
-		DPRINTK ("EXIT, returning -EBUSY\n");
-		return -EBUSY;
+	else 
+	{
+		if (request_irq (card->pdev->irq, via_new_interrupt, SA_SHIRQ, VIA_MODULE_NAME, card)) {
+			printk (KERN_ERR PFX "unable to obtain IRQ %d, aborting\n",
+				card->pdev->irq);
+			DPRINTK ("EXIT, returning -EBUSY\n");
+			return -EBUSY;
+		}
 	}
 
 	DPRINTK ("EXIT, returning 0\n");
@@ -1792,15 +2057,15 @@
  */
 
 static struct file_operations via_dsp_fops = {
-	.owner		= THIS_MODULE,
-	.open		= via_dsp_open,
-	.release	= via_dsp_release,
-	.read		= via_dsp_read,
-	.write		= via_dsp_write,
-	.poll		= via_dsp_poll,
-	.llseek		= no_llseek,
-	.ioctl		= via_dsp_ioctl,
-	.mmap		= via_dsp_mmap,
+	owner:		THIS_MODULE,
+	open:		via_dsp_open,
+	release:	via_dsp_release,
+	read:		via_dsp_read,
+	write:		via_dsp_write,
+	poll:		via_dsp_poll,
+	llseek: 	no_llseek,
+	ioctl:		via_dsp_ioctl,
+	mmap:		via_dsp_mmap,
 };
 
 
@@ -1812,11 +2077,14 @@
 
 	assert (card != NULL);
 
-	/* turn off legacy features, if not already */
-	pci_read_config_byte (card->pdev, VIA_FUNC_ENABLE, &tmp8);
-	if (tmp8 & (VIA_CR42_SB_ENABLE |  VIA_CR42_FM_ENABLE)) {
-		tmp8 &= ~(VIA_CR42_SB_ENABLE | VIA_CR42_FM_ENABLE);
-		pci_write_config_byte (card->pdev, VIA_FUNC_ENABLE, tmp8);
+	if(card->legacy)
+	{
+		/* turn off legacy features, if not already */
+		pci_read_config_byte (card->pdev, VIA_FUNC_ENABLE, &tmp8);
+		if (tmp8 & (VIA_CR42_SB_ENABLE |  VIA_CR42_FM_ENABLE)) {
+			tmp8 &= ~(VIA_CR42_SB_ENABLE | VIA_CR42_FM_ENABLE);
+			pci_write_config_byte (card->pdev, VIA_FUNC_ENABLE, tmp8);
+		}
 	}
 
 	via_stop_everything (card);
@@ -1911,10 +2179,10 @@
 
 
 struct vm_operations_struct via_mm_ops = {
-	.nopage		= via_mm_nopage,
+	nopage:		via_mm_nopage,
 
 #ifndef VM_RESERVED
-	.swapout	= via_mm_swapout,
+	swapout:	via_mm_swapout,
 #endif
 };
 
@@ -2129,7 +2397,6 @@
 		 file, buffer, count, ppos ? ((unsigned long)*ppos) : 0);
 
 	assert (file != NULL);
-	assert (buffer != NULL);
 	card = file->private_data;
 	assert (card != NULL);
 
@@ -2287,11 +2554,12 @@
 	DPRINTK ("Flushed block %u, sw_ptr now %u, n_frags now %d\n",
 		n, chan->sw_ptr, atomic_read (&chan->n_frags));
 
-	DPRINTK ("regs==%02X %02X %02X %08X %08X %08X %08X\n",
+	DPRINTK ("regs==S=%02X C=%02X TP=%02X BP=%08X RT=%08X SG=%08X CC=%08X SS=%08X\n",
 		 inb (card->baseaddr + 0x00),
 		 inb (card->baseaddr + 0x01),
 		 inb (card->baseaddr + 0x02),
 		 inl (card->baseaddr + 0x04),
+		 inl (card->baseaddr + 0x08),
 		 inl (card->baseaddr + 0x0C),
 		 inl (card->baseaddr + 0x80),
 		 inl (card->baseaddr + 0x84));
@@ -2300,7 +2568,10 @@
 		goto handle_one_block;
 
 out:
-	return userbuf - orig_userbuf;
+	if (userbuf - orig_userbuf)
+		return userbuf - orig_userbuf;
+	else
+		return ret;
 }
 
 
@@ -2314,7 +2585,6 @@
 		 file, buffer, count, ppos ? ((unsigned long)*ppos) : 0);
 
 	assert (file != NULL);
-	assert (buffer != NULL);
 	card = file->private_data;
 	assert (card != NULL);
 
@@ -2410,6 +2680,7 @@
 
 	add_wait_queue(&chan->wait, &wait);
 	for (;;) {
+		DPRINTK ("FRAGS %d FRAGNUM %d\n", atomic_read(&chan->n_frags), chan->frag_number);
 		__set_current_state(TASK_INTERRUPTIBLE);
 		if (atomic_read (&chan->n_frags) >= chan->frag_number)
 			break;
@@ -2535,7 +2806,7 @@
 		info.fragments,
 		info.bytes);
 
-	return copy_to_user(arg, &info, sizeof (info)) ? -EFAULT : 0;
+	return copy_to_user (arg, &info, sizeof (info))?-EFAULT:0;
 }
 
 
@@ -2567,7 +2838,7 @@
 	if (chan->is_active) {
 		unsigned long extra;
 		info.ptr = atomic_read (&chan->hw_ptr) * chan->frag_size;
-		extra = chan->frag_size - inl (chan->iobase + VIA_PCM_BLOCK_COUNT);
+		extra = chan->frag_size - via_sg_offset(chan);
 		info.ptr += extra;
 		info.bytes += extra;
 	} else {
@@ -2579,7 +2850,7 @@
 		info.blocks,
 		info.ptr);
 
-	return copy_to_user(arg, &info, sizeof (info)) ? -EFAULT : 0;
+	return copy_to_user (arg, &info, sizeof (info))?-EFAULT:0;
 }
 
 
@@ -2688,7 +2959,7 @@
                 rc = put_user (val, (int *)arg);
 		break;
 
-	/* query or set number of channels (1=mono, 2=stereo) */
+	/* query or set number of channels (1=mono, 2=stereo, 4/6 for multichannel) */
         case SNDCTL_DSP_CHANNELS:
 		if (get_user(val, (int *)arg)) {
 			rc = -EFAULT;
@@ -2709,11 +2980,10 @@
 
 			val = rc;
 		} else {
-			if ((rd && (card->ch_in.pcm_fmt & VIA_PCM_FMT_STEREO)) ||
-			    (wr && (card->ch_out.pcm_fmt & VIA_PCM_FMT_STEREO)))
-				val = 2;
+			if (rd)
+				val = card->ch_in.channels;
 			else
-				val = 1;
+				val = card->ch_out.channels;
 		}
 		DPRINTK ("CHANNELS EXIT, returning %d\n", val);
                 rc = put_user (val, (int *)arg);
@@ -2873,10 +3143,11 @@
 
 			val = chan->frag_number - atomic_read (&chan->n_frags);
 
+			assert(val >= 0);
+				
 			if (val > 0) {
 				val *= chan->frag_size;
-				val -= chan->frag_size -
-				       inl (chan->iobase + VIA_PCM_BLOCK_COUNT);
+				val -= chan->frag_size - via_sg_offset(chan);
 			}
 			val += chan->slop_len % chan->frag_size;
 		} else
@@ -2982,7 +3253,7 @@
 static int via_dsp_open (struct inode *inode, struct file *file)
 {
 	int minor = minor(inode->i_rdev);
-	struct via_info *card = NULL;
+	struct via_info *card;
 	struct pci_dev *pdev = NULL;
 	struct via_channel *chan;
 	struct pci_driver *drvr;
@@ -2995,6 +3266,7 @@
 		return -EINVAL;
 	}
 
+	card = NULL;
 	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
 		drvr = pci_dev_driver (pdev);
 		if (drvr == &via_driver) {
@@ -3037,9 +3309,11 @@
 
 		/* why is this forced to 16-bit stereo in all drivers? */
 		chan->pcm_fmt = VIA_PCM_FMT_16BIT | VIA_PCM_FMT_STEREO;
+		chan->channels = 2;
 
+		// TO DO - use FIFO: via_capture_fifo(card, 1);
 		via_chan_pcm_fmt (chan, 0);
-		via_set_rate (&card->ac97, chan, 44100);
+		via_set_rate (card->ac97, chan, 44100);
 	}
 
 	/* handle output to analog source */
@@ -3052,16 +3326,17 @@
 			/* if in duplex mode make the recording and playback channels
 			   have the same settings */
 			chan->pcm_fmt = VIA_PCM_FMT_16BIT | VIA_PCM_FMT_STEREO;
+			chan->channels = 2;
 			via_chan_pcm_fmt (chan, 0);
-                        via_set_rate (&card->ac97, chan, 44100);
+                        via_set_rate (card->ac97, chan, 44100);
 		} else {
 			 if ((minor & 0xf) == SND_DEV_DSP16) {
 				chan->pcm_fmt = VIA_PCM_FMT_16BIT;
 				via_chan_pcm_fmt (chan, 0);
-				via_set_rate (&card->ac97, chan, 44100);
+				via_set_rate (card->ac97, chan, 44100);
 			} else {
 				via_chan_pcm_fmt (chan, 1);
-				via_set_rate (&card->ac97, chan, 8000);
+				via_set_rate (card->ac97, chan, 8000);
 			}
 		}
 	}
@@ -3091,7 +3366,7 @@
 
 	if (file->f_mode & FMODE_WRITE) {
 		rc = via_dsp_drain_playback (card, &card->ch_out, nonblock);
-		if (rc)
+		if (rc && rc != ERESTARTSYS)	/* Nobody needs to know about ^C */
 			printk (KERN_DEBUG "via_audio: ignoring drain playback error %d\n", rc);
 
 		via_chan_free (card, &card->ch_out);
@@ -3130,11 +3405,12 @@
 	DPRINTK ("ENTER\n");
 
 	if (printed_version++ == 0)
-		printk (KERN_INFO "Via 686a audio driver " VIA_VERSION "\n");
+		printk (KERN_INFO "Via 686a/8233/8235 audio driver " VIA_VERSION "\n");
 
 	rc = pci_enable_device (pdev);
 	if (rc)
 		goto err_out;
+		
 
 	rc = pci_request_regions (pdev, "via82cxxx_audio");
 	if (rc)
@@ -3154,6 +3430,7 @@
 	card->baseaddr = pci_resource_start (pdev, 0);
 	card->card_num = via_num_cards++;
 	spin_lock_init (&card->lock);
+	spin_lock_init (&card->ac97_lock);
 	init_MUTEX (&card->syscall_sem);
 	init_MUTEX (&card->open_sem);
 
@@ -3166,7 +3443,15 @@
 	 * which means it has a few extra features */
 	if (pci_resource_start (pdev, 2) > 0)
 		card->rev_h = 1;
-
+		
+	/* Overkill for now, but more flexible done right */
+	
+	card->intmask = id->driver_data;
+	card->legacy = !card->intmask;
+	card->sixchannel = id->driver_data;
+	
+	if(card->sixchannel)
+		printk(KERN_INFO PFX "Six channel audio available\n");
 	if (pdev->irq < 1) {
 		printk (KERN_ERR PFX "invalid PCI IRQ %d, aborting\n", pdev->irq);
 		rc = -ENODEV;
@@ -3179,6 +3464,8 @@
 		goto err_out_kfree;
 	}
 
+	pci_set_master(pdev);
+	
 	/*
 	 * init AC97 mixer and codec
 	 */
@@ -3222,26 +3509,29 @@
 	/* Disable by default */
 	card->midi_info.io_base = 0;
 
-	pci_read_config_byte (pdev, 0x42, &r42);
-	/* Disable MIDI interrupt */
-	pci_write_config_byte (pdev, 0x42, r42 | VIA_CR42_MIDI_IRQMASK);
-	if (r42 & VIA_CR42_MIDI_ENABLE)
+	if(card->legacy)
 	{
-		if (r42 & VIA_CR42_MIDI_PNP) /* Address selected by iobase 2 - not tested */
-			card->midi_info.io_base = pci_resource_start (pdev, 2);
-		else /* Address selected by byte 0x43 */
+		pci_read_config_byte (pdev, 0x42, &r42);
+		/* Disable MIDI interrupt */
+		pci_write_config_byte (pdev, 0x42, r42 | VIA_CR42_MIDI_IRQMASK);
+		if (r42 & VIA_CR42_MIDI_ENABLE)
 		{
-			u8 r43;
-			pci_read_config_byte (pdev, 0x43, &r43);
-			card->midi_info.io_base = 0x300 + ((r43 & 0x0c) << 2);
-		}
+			if (r42 & VIA_CR42_MIDI_PNP) /* Address selected by iobase 2 - not tested */
+				card->midi_info.io_base = pci_resource_start (pdev, 2);
+			else /* Address selected by byte 0x43 */
+			{
+				u8 r43;
+				pci_read_config_byte (pdev, 0x43, &r43);
+				card->midi_info.io_base = 0x300 + ((r43 & 0x0c) << 2);
+			}
 
-		card->midi_info.irq = -pdev->irq;
-		if (probe_uart401(& card->midi_info, THIS_MODULE))
-		{
-			card->midi_devc=midi_devs[card->midi_info.slots[4]]->devc;
-			pci_write_config_byte(pdev, 0x42, r42 & ~VIA_CR42_MIDI_IRQMASK);
-			printk("Enabled Via MIDI\n");
+			card->midi_info.irq = -pdev->irq;
+			if (probe_uart401(& card->midi_info, THIS_MODULE))
+			{
+				card->midi_devc=midi_devs[card->midi_info.slots[4]]->devc;
+				pci_write_config_byte(pdev, 0x42, r42 & ~VIA_CR42_MIDI_IRQMASK);
+				printk("Enabled Via MIDI\n");
+			}
 		}
 	}
 #endif
@@ -3501,7 +3791,7 @@
 	}
 
 	sprintf (s, "driver/via/%d/ac97", card->card_num);
-	if (!create_proc_read_entry (s, 0, 0, ac97_read_proc, &card->ac97)) {
+	if (!create_proc_read_entry (s, 0, 0, ac97_read_proc, card->ac97)) {
 		rc = -EIO;
 		goto err_out_info;
 	}
