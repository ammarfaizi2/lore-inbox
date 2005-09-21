Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbVIUJFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbVIUJFN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 05:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVIUJFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 05:05:13 -0400
Received: from [203.121.86.58] ([203.121.86.58]:58116 "EHLO
	bserver.customer.clipsalportal.com") by vger.kernel.org with ESMTP
	id S1750778AbVIUJFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 05:05:11 -0400
Date: Wed, 21 Sep 2005 17:00:08 +0800
From: jayakumar.alsa@gmail.com
Message-Id: <200509210900.j8L908Qa003404@localhost.localdomain>
To: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13.1 1/1] Cleanup for CS5535 audio driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

This patch is against 2.6.14-rc2 + cs5535-audio-alsa-driver.patch 
( The prior patch is as was at http://lkml.org/lkml/2005/9/19/34 
 and I guess in akpm's -mm tree). I wasn't sure if I should generate 
a diff against the previous patch or if I should just diff against
the real vanilla 2.6.14-rc2. So I just did a diff against the previous
patch.

Thanks,
Jaya Kumar

Signed-off-by: Jaya Kumar <jayakumar.alsa@gmail.com>

---

 cs5535audio.c     |  208 ++++++++++++++++++++++++++----------------------------
 cs5535audio.h     |   11 +-
 cs5535audio_pcm.c |   43 +++++------
 3 files changed, 129 insertions(+), 133 deletions(-)
diff -uprN -X dontdiff.13.1 linux-2.6.14-rc2-vanilla/sound/pci/cs5535audio/cs5535audio.c linux-2.6.14-rc2.alsa/sound/pci/cs5535audio/cs5535audio.c
--- linux-2.6.14-rc2-vanilla/sound/pci/cs5535audio/cs5535audio.c	2005-09-21 10:12:57.000000000 +0800
+++ linux-2.6.14-rc2.alsa/sound/pci/cs5535audio/cs5535audio.c	2005-09-21 16:41:15.000000000 +0800
@@ -21,13 +21,13 @@
  *
  */
 
-#include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
+#include <asm/io.h>
 #include <sound/driver.h>
 #include <sound/core.h>
 #include <sound/control.h>
@@ -53,41 +53,43 @@ static struct pci_device_id snd_cs5535au
 
 MODULE_DEVICE_TABLE(pci, snd_cs5535audio_ids);
 
+static void wait_till_cmd_acked(cs5535audio_t *cs5535au, unsigned long timeout)
+{
+	unsigned long tmp;
+	do {
+		tmp = cs_readl(cs5535au, ACC_CODEC_CNTL);
+		if (!(tmp & CMD_NEW)) 
+			break;
+		msleep(10);
+	} while (--timeout);
+	if (!timeout) 
+		snd_printk(KERN_ERR "Failure writing to cs5535 codec\n");
+}
+
 static unsigned short snd_cs5535audio_codec_read(cs5535audio_t *cs5535au, 
 							unsigned short reg)
 {
 	unsigned long regdata;
-	unsigned long tmp, timeout;
+	unsigned long timeout;
 	unsigned long val;
 
 	regdata = ((unsigned long) reg) << 24;
 	regdata |= ACC_CODEC_CNTL_RD_CMD;
 	regdata |= CMD_NEW;
  
-	cs_writel(ACC_CODEC_CNTL, regdata);
-
-	timeout = 500;
-	do {
-		tmp = cs_readl(ACC_CODEC_CNTL);
-		if (!(tmp & CMD_NEW)) 
-			break;
-		msleep(10);
-	} while (timeout--);
-	if (!timeout) {
-		snd_printk(KERN_ERR "Failure writing to cs5535 codec\n");
-	}
+	cs_writel(cs5535au, ACC_CODEC_CNTL, regdata);
+	wait_till_cmd_acked(cs5535au, 500);
 
 	timeout = 50;
 	do {
-		val = cs_readl(ACC_CODEC_STATUS);
+		val = cs_readl(cs5535au, ACC_CODEC_STATUS);
 		if (	(val & STS_NEW) && 
 			((unsigned long) reg == ((0xFF000000 & val)>>24)) )
 			break;
 		msleep(10);
-	} while (timeout--);
-	if (!timeout) {
+	} while (--timeout);
+	if (!timeout) 
 		snd_printk(KERN_ERR "Failure reading cs5535 codec\n");
-	}
 
 	return ((unsigned short) val);
 }
@@ -96,7 +98,6 @@ static void snd_cs5535audio_codec_write(
 				   unsigned short reg, unsigned short val)
 {
 	unsigned long regdata;
-	unsigned long tmp, timeout;
 
 	regdata = ((unsigned long) reg) << 24; 
 	regdata |= (unsigned long) val;
@@ -104,32 +105,22 @@ static void snd_cs5535audio_codec_write(
 	regdata |= CMD_NEW;
 	regdata &= ACC_CODEC_CNTL_WR_CMD;
 
-	cs_writel(ACC_CODEC_CNTL, regdata);
-
-	timeout = 50;
-	do {
-		tmp = cs_readl(ACC_CODEC_CNTL);
-		if (!(tmp & CMD_NEW)) 
-			break;
-		msleep(10);
-	} while (timeout--);
-	if (!timeout) {
-		snd_printk(KERN_ERR "Failure writing to cs5535 codec\n");
-	}
+	cs_writel(cs5535au, ACC_CODEC_CNTL, regdata);
+	wait_till_cmd_acked(cs5535au, 50);
 }
 
 static void snd_cs5535audio_ac97_codec_write(ac97_t *ac97,
 				   unsigned short reg, unsigned short val)
 {
 	cs5535audio_t *cs5535au = ac97->private_data;
-	snd_cs5535audio_codec_write(cs5535au,reg,val);
+	snd_cs5535audio_codec_write(cs5535au, reg, val);
 }
 
 static unsigned short snd_cs5535audio_ac97_codec_read(ac97_t *ac97,
 					    unsigned short reg)
 {
 	cs5535audio_t *cs5535au = ac97->private_data;
-	return snd_cs5535audio_codec_read(cs5535au,reg);
+	return snd_cs5535audio_codec_read(cs5535au, reg);
 }
 
 static void snd_cs5535audio_mixer_free_ac97(ac97_t *ac97)
@@ -170,13 +161,11 @@ static void process_bm0_irq(cs5535audio_
 { 
 	u8 bm_stat;
 	spin_lock(&cs5535au->reg_lock);
-	bm_stat = cs_readb(ACC_BM0_STATUS);
+	bm_stat = cs_readb(cs5535au, ACC_BM0_STATUS);
 	spin_unlock(&cs5535au->reg_lock);
 	if (bm_stat & EOP) {
 		cs5535audio_dma_t *dma;
-		dma = (cs5535audio_dma_t *) 
-			cs5535au->playback_substream->runtime->private_data;
-		dma->index = (++(dma->index)) % dma->periods;
+		dma = cs5535au->playback_substream->runtime->private_data;
 		snd_pcm_period_elapsed(cs5535au->playback_substream);
 	} else {
 		snd_printk(KERN_ERR "unexpected bm0 irq src, bm_stat=%x\n",
@@ -188,13 +177,11 @@ static void process_bm1_irq(cs5535audio_
 { 
 	u8 bm_stat;
 	spin_lock(&cs5535au->reg_lock);
-	bm_stat = cs_readb(ACC_BM1_STATUS);
+	bm_stat = cs_readb(cs5535au, ACC_BM1_STATUS);
 	spin_unlock(&cs5535au->reg_lock);
 	if (bm_stat & EOP) {
 		cs5535audio_dma_t *dma;
-		dma = (cs5535audio_dma_t *) 
-			cs5535au->capture_substream->runtime->private_data;
-		dma->index = (++(dma->index)) % dma->periods;
+		dma = cs5535au->capture_substream->runtime->private_data;
 		snd_pcm_period_elapsed(cs5535au->capture_substream);
 	}
 }
@@ -210,47 +197,46 @@ static irqreturn_t snd_cs5535audio_inter
 	if (cs5535au == NULL)
 		return IRQ_NONE;
 
-	acc_irq_stat = cs_readw(ACC_IRQ_STATUS);
+	acc_irq_stat = cs_readw(cs5535au, ACC_IRQ_STATUS);
 
 	if (!acc_irq_stat)
 		return IRQ_NONE; 
 	for (count=0; count < 10; count++) {
 		if (acc_irq_stat & (1<<count)) {
 			switch (count) {
-				case IRQ_STS:
-					cs_readl(ACC_GPIO_STATUS);
-					break;
-				case WU_IRQ_STS:
-					cs_readl(ACC_GPIO_STATUS);
-					break;
-				case BM0_IRQ_STS:
-					process_bm0_irq(cs5535au);
-					break;
-				case BM1_IRQ_STS:
-					process_bm1_irq(cs5535au);
-					break;
-				case BM2_IRQ_STS:
-					bm_stat = cs_readb(ACC_BM2_STATUS);
-					break;
-				case BM3_IRQ_STS:
-					bm_stat = cs_readb(ACC_BM3_STATUS);
-					break;
-				case BM4_IRQ_STS:
-					bm_stat = cs_readb(ACC_BM4_STATUS);
-					break;
-				case BM5_IRQ_STS:
-					bm_stat = cs_readb(ACC_BM5_STATUS);
-					break;
-				case BM6_IRQ_STS:
-					bm_stat = cs_readb(ACC_BM6_STATUS);
-					break;
-				case BM7_IRQ_STS:
-					bm_stat = cs_readb(ACC_BM7_STATUS);
-					break;
-				default:
-					snd_printk(KERN_ERR 
-						"Unexpected irq src\n");
-					break;	
+			case IRQ_STS:
+				cs_readl(cs5535au, ACC_GPIO_STATUS);
+				break;
+			case WU_IRQ_STS:
+				cs_readl(cs5535au, ACC_GPIO_STATUS);
+				break;
+			case BM0_IRQ_STS:
+				process_bm0_irq(cs5535au);
+				break;
+			case BM1_IRQ_STS:
+				process_bm1_irq(cs5535au);
+				break;
+			case BM2_IRQ_STS:
+				bm_stat = cs_readb(cs5535au, ACC_BM2_STATUS);
+				break;
+			case BM3_IRQ_STS:
+				bm_stat = cs_readb(cs5535au, ACC_BM3_STATUS);
+				break;
+			case BM4_IRQ_STS:
+				bm_stat = cs_readb(cs5535au, ACC_BM4_STATUS);
+				break;
+			case BM5_IRQ_STS:
+				bm_stat = cs_readb(cs5535au, ACC_BM5_STATUS);
+				break;
+			case BM6_IRQ_STS:
+				bm_stat = cs_readb(cs5535au, ACC_BM6_STATUS);
+				break;
+			case BM7_IRQ_STS:
+				bm_stat = cs_readb(cs5535au, ACC_BM7_STATUS);
+				break;
+			default:
+				snd_printk(KERN_ERR "Unexpected irq src\n");
+				break;	
 			}
 		}
 	}
@@ -263,7 +249,7 @@ static int snd_cs5535audio_free(cs5535au
 	pci_set_power_state(cs5535au->pci, 3);
 
 	if (cs5535au->irq >= 0)
-		free_irq(cs5535au->irq, (void *)cs5535au);
+		free_irq(cs5535au->irq, cs5535au);
 
 	pci_release_regions(cs5535au->pci);
 	pci_disable_device(cs5535au->pci);
@@ -292,41 +278,57 @@ static int __devinit snd_cs5535audio_cre
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 
-	cs5535au = kcalloc(1, sizeof(*cs5535au), GFP_KERNEL);
+	if (pci_set_dma_mask(pci, DMA_32BIT_MASK) < 0 ||
+		pci_set_consistent_dma_mask(pci, DMA_32BIT_MASK) < 0) {
+		printk(KERN_WARNING "unable to get 32bit dma\n");
+		err = -ENXIO;
+		goto pcifail;
+	}
+
+	cs5535au = kzalloc(sizeof(*cs5535au), GFP_KERNEL);
 	if (cs5535au == NULL) {
-		pci_disable_device(pci);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto pcifail;
 	}
+
 	spin_lock_init(&cs5535au->reg_lock);
 	cs5535au->card = card;
 	cs5535au->pci = pci;
 	cs5535au->irq = -1;
+
 	if ((err = pci_request_regions(pci, "CS5535 Audio")) < 0) {
 		kfree(cs5535au);
-		pci_disable_device(pci);
-		return err;
+		goto pcifail;
 	}
+
 	cs5535au->port = pci_resource_start(pci, 0);
+
 	if (request_irq(pci->irq, snd_cs5535audio_interrupt, 
-		SA_INTERRUPT|SA_SHIRQ, "CS5535 Audio", (void *) cs5535au)) {
+		SA_INTERRUPT|SA_SHIRQ, "CS5535 Audio", cs5535au)) {
 		snd_printk("unable to grab IRQ %d\n", pci->irq);
-		snd_cs5535audio_free(cs5535au);
-		return -EBUSY;
+		err = -EBUSY;
+		goto sndfail;
 	}
 
 	cs5535au->irq = pci->irq;
 	pci_set_master(pci);
 
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, 
-					cs5535au, &ops)) < 0) {
-		snd_cs5535audio_free(cs5535au);
-		return err;
-	}
+					cs5535au, &ops)) < 0) 
+		goto sndfail;
 
 	snd_card_set_dev(card, &pci->dev);
 
 	*rcs5535au = cs5535au;
 	return 0;
+
+sndfail: /* leave the device alive, just kill the snd */
+	snd_cs5535audio_free(cs5535au);
+	return err;
+
+pcifail: 
+	pci_disable_device(pci);
+	return err;
 }
 
 static int __devinit snd_cs5535audio_probe(struct pci_dev *pci,
@@ -348,20 +350,14 @@ static int __devinit snd_cs5535audio_pro
 	if (card == NULL)
 		return -ENOMEM;
 
-	if ((err = snd_cs5535audio_create(card, pci, &cs5535au)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if ((err = snd_cs5535audio_create(card, pci, &cs5535au)) < 0)
+		goto probefail_out;
 
-	if ((err = snd_cs5535audio_mixer(cs5535au)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if ((err = snd_cs5535audio_mixer(cs5535au)) < 0)
+		goto probefail_out;
 
-	if ((err = snd_cs5535audio_pcm(cs5535au)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if ((err = snd_cs5535audio_pcm(cs5535au)) < 0) 
+		goto probefail_out;
 
 	strcpy(card->driver, DRIVER_NAME);
 
@@ -370,14 +366,16 @@ static int __devinit snd_cs5535audio_pro
 		card->shortname, card->driver,
 		cs5535au->port, cs5535au->irq);
 
-	if ((err = snd_card_register(card)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if ((err = snd_card_register(card)) < 0) 
+		goto probefail_out;
 
 	pci_set_drvdata(pci, card);
 	dev++;
 	return 0;
+
+probefail_out:
+	snd_card_free(card);
+	return err;
 }
 
 static void __devexit snd_cs5535audio_remove(struct pci_dev *pci)
diff -uprN -X dontdiff.13.1 linux-2.6.14-rc2-vanilla/sound/pci/cs5535audio/cs5535audio.h linux-2.6.14-rc2.alsa/sound/pci/cs5535audio/cs5535audio.h
--- linux-2.6.14-rc2-vanilla/sound/pci/cs5535audio/cs5535audio.h	2005-09-21 10:12:57.000000000 +0800
+++ linux-2.6.14-rc2.alsa/sound/pci/cs5535audio/cs5535audio.h	2005-09-21 10:39:13.000000000 +0800
@@ -1,11 +1,11 @@
 #ifndef __SOUND_CS5535AUDIO_H
 #define __SOUND_CS5535AUDIO_H
 
-#define cs_writel(reg, val) 	outl(val, (int) cs5535au->port + reg)
-#define cs_writeb(reg, val) 	outb(val, (int) cs5535au->port + reg)
-#define cs_readl(reg) 		inl((unsigned short) (cs5535au->port + reg))
-#define cs_readw(reg) 		inw((unsigned short) (cs5535au->port + reg))
-#define cs_readb(reg) 		inb((unsigned short) (cs5535au->port + reg))
+#define cs_writel(cs5535au, reg, val) outl(val, (int) cs5535au->port + reg)
+#define cs_writeb(cs5535au, reg, val) outb(val, (int) cs5535au->port + reg)
+#define cs_readl(cs5535au, reg)	inl((unsigned short) (cs5535au->port + reg))
+#define cs_readw(cs5535au, reg)	inw((unsigned short) (cs5535au->port + reg))
+#define cs_readb(cs5535au, reg)	inb((unsigned short) (cs5535au->port + reg))
 
 #define CS5535AUDIO_MAX_DESCRIPTORS	128	
 
@@ -104,7 +104,6 @@ struct snd_cs5535audio_dma {
 	snd_pcm_substream_t *substream;	
 	unsigned int buf_addr, buf_bytes;	
 	unsigned int period_bytes, periods;
-	int index;
 };
 
 struct _snd_cs5535audio {
diff -uprN -X dontdiff.13.1 linux-2.6.14-rc2-vanilla/sound/pci/cs5535audio/cs5535audio_pcm.c linux-2.6.14-rc2.alsa/sound/pci/cs5535audio/cs5535audio_pcm.c
--- linux-2.6.14-rc2-vanilla/sound/pci/cs5535audio/cs5535audio_pcm.c	2005-09-21 10:12:57.000000000 +0800
+++ linux-2.6.14-rc2.alsa/sound/pci/cs5535audio/cs5535audio_pcm.c	2005-09-21 16:48:51.000000000 +0800
@@ -142,11 +142,13 @@ static int cs5535audio_build_dma_packets
 	if (dma->periods == periods && dma->period_bytes == period_bytes)
 		return 0;
 
-	addr = (u32)substream->runtime->dma_addr;
-	desc_addr = (u32)dma->desc_buf.addr;
+	/* the u32 cast is okay because in snd*create we succesfully told 
+   	   pci alloc that we're only 32 bit capable so the uppper will be 0 */
+	addr = (u32) substream->runtime->dma_addr;
+	desc_addr = (u32) dma->desc_buf.addr;
 	for (i = 0; i < periods; i++) {
 		cs5535audio_dma_desc_t *desc = 
-			&((cs5535audio_dma_desc_t *)dma->desc_buf.area)[i];
+			&((cs5535audio_dma_desc_t *) dma->desc_buf.area)[i];
 		desc->addr = cpu_to_le32(addr);
 		desc->size = period_bytes;
 		desc->ctlreserved = PRD_EOP; 
@@ -154,8 +156,8 @@ static int cs5535audio_build_dma_packets
 		addr += period_bytes;
 	}
 	/* we reserved one dummy descriptor at the end to do the PRD jump */
-	lastdesc = &((cs5535audio_dma_desc_t *)dma->desc_buf.area)[periods];
-	lastdesc->addr = cpu_to_le32((u32)dma->desc_buf.addr);
+	lastdesc = &((cs5535audio_dma_desc_t *) dma->desc_buf.area)[periods];
+	lastdesc->addr = cpu_to_le32((u32) dma->desc_buf.addr);
 	lastdesc->size = 0;
 	lastdesc->ctlreserved = PRD_JMP; 
 	jmpprd_addr = cpu_to_le32(lastdesc->addr + 
@@ -172,54 +174,54 @@ static int cs5535audio_build_dma_packets
 
 static void cs5535audio_playback_enable_dma(cs5535audio_t *cs5535au)
 {
-	cs_writeb(ACC_BM0_CMD, BM_CTL_EN);
+	cs_writeb(cs5535au, ACC_BM0_CMD, BM_CTL_EN);
 }
 
 static void cs5535audio_playback_disable_dma(cs5535audio_t *cs5535au)
 {
-	cs_writeb(ACC_BM0_CMD, 0);
+	cs_writeb(cs5535au, ACC_BM0_CMD, 0);
 }
 
 static void cs5535audio_playback_pause_dma(cs5535audio_t *cs5535au)
 {
-	cs_writeb(ACC_BM0_CMD, BM_CTL_PAUSE);
+	cs_writeb(cs5535au, ACC_BM0_CMD, BM_CTL_PAUSE);
 }
 
 static void cs5535audio_playback_setup_prd(cs5535audio_t *cs5535au, 
 						u32 prd_addr)
 {
-	cs_writel(ACC_BM0_PRD, prd_addr);
+	cs_writel(cs5535au, ACC_BM0_PRD, prd_addr);
 }
 
 static u32 cs5535audio_playback_read_dma_pntr(cs5535audio_t *cs5535au)
 {
-	return cs_readl(ACC_BM0_PNTR);
+	return cs_readl(cs5535au, ACC_BM0_PNTR);
 }
 
 static void cs5535audio_capture_enable_dma(cs5535audio_t *cs5535au)
 {
-	cs_writeb(ACC_BM1_CMD, BM_CTL_EN);
+	cs_writeb(cs5535au, ACC_BM1_CMD, BM_CTL_EN);
 }
 
 static void cs5535audio_capture_disable_dma(cs5535audio_t *cs5535au)
 {
-	cs_writeb(ACC_BM1_CMD, 0);
+	cs_writeb(cs5535au, ACC_BM1_CMD, 0);
 }
 
 static void cs5535audio_capture_pause_dma(cs5535audio_t *cs5535au)
 {
-	cs_writeb(ACC_BM1_CMD, BM_CTL_PAUSE);
+	cs_writeb(cs5535au, ACC_BM1_CMD, BM_CTL_PAUSE);
 }
 
 static void cs5535audio_capture_setup_prd(cs5535audio_t *cs5535au, 
 						u32 prd_addr)
 {
-	cs_writel(ACC_BM1_PRD, prd_addr);
+	cs_writel(cs5535au, ACC_BM1_PRD, prd_addr);
 }
 
 static u32 cs5535audio_capture_read_dma_pntr(cs5535audio_t *cs5535au)
 {
-	return cs_readl(ACC_BM1_PNTR);
+	return cs_readl(cs5535au, ACC_BM1_PNTR);
 }
 
 static void cs5535audio_clear_dma_packets(cs5535audio_t *cs5535au, 
@@ -234,8 +236,7 @@ static int snd_cs5535audio_hw_params(snd
 				 snd_pcm_hw_params_t *hw_params)
 {
 	cs5535audio_t *cs5535au = snd_pcm_substream_chip(substream);
-	cs5535audio_dma_t *dma = (cs5535audio_dma_t *)
-					substream->runtime->private_data;
+	cs5535audio_dma_t *dma = substream->runtime->private_data;
 	int err;
 
 	err = snd_pcm_lib_malloc_pages(substream, 
@@ -254,8 +255,7 @@ static int snd_cs5535audio_hw_params(snd
 static int snd_cs5535audio_hw_free(snd_pcm_substream_t *substream)
 {
 	cs5535audio_t *cs5535au = snd_pcm_substream_chip(substream);
-	cs5535audio_dma_t *dma = (cs5535audio_dma_t *)
-				substream->runtime->private_data;
+	cs5535audio_dma_t *dma = substream->runtime->private_data;
 
 	cs5535audio_clear_dma_packets(cs5535au, dma, substream);
 	return snd_pcm_lib_free_pages(substream);
@@ -271,8 +271,7 @@ static int snd_cs5535audio_playback_prep
 static int snd_cs5535audio_trigger(snd_pcm_substream_t *substream, int cmd)
 {
 	cs5535audio_t *cs5535au = snd_pcm_substream_chip(substream);
-	cs5535audio_dma_t *dma = (cs5535audio_dma_t *)
-				substream->runtime->private_data;
+	cs5535audio_dma_t *dma = substream->runtime->private_data;
 
 	switch (cmd) {
 		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
@@ -310,7 +309,7 @@ static snd_pcm_uframes_t snd_cs5535audio
 	u32 curdma;
 	cs5535audio_dma_t *dma;
 
-	dma = (cs5535audio_dma_t *)substream->runtime->private_data;
+	dma = substream->runtime->private_data;
 	curdma = dma->ops->read_dma_pntr(cs5535au);
 	if (curdma < dma->buf_addr) {
 		snd_printk(KERN_ERR "curdma=%x < %x bufaddr.\n",
