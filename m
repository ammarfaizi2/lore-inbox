Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVIOJJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVIOJJB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 05:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVIOJJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 05:09:01 -0400
Received: from [203.121.86.58] ([203.121.86.58]:44036 "EHLO
	bserver.customer.clipsalportal.com") by vger.kernel.org with ESMTP
	id S932171AbVIOJJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 05:09:00 -0400
Date: Thu, 15 Sep 2005 17:04:23 +0800
From: jayakumar.alsa@gmail.com
Message-Id: <200509150904.j8F94NKP000991@localhost.localdomain>
To: perex@suse.cz, mj@ucw.cz, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [RFC 2.6.13.1 1/1] CS5535 AUDIO ALSA driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaroslav, Martin, alsa and kernel folk,

Appended is my patch adding support for the CS5535 Audio device. I've
done this patch against 2.6.13.1. I didn't find the CS5535 pci id in
pci_ids so I've added those and the remaining pci functions for the 
CS5535 device as defines there. I don't have the ability to test the
chip's SPDIF capability yet. I'll add support for it next. Please let
me know if it looks okay so far and if you have any feedback or
suggestions.

Regards,
Jaya Kumar

Signed-off-by: Jaya Kumar <jayakumar.alsa@gmail.com>

---

 CREDITS                                 |    1 
 MAINTAINERS                             |    5 
 include/linux/pci_ids.h                 |    4 
 include/sound/cs5535audio.h             |  128 +++++++++
 sound/pci/Kconfig                       |   13 
 sound/pci/Makefile                      |    1 
 sound/pci/cs5535audio/Makefile          |    8 
 sound/pci/cs5535audio/cs5535audio.c     |  416 ++++++++++++++++++++++++++++++
 sound/pci/cs5535audio/cs5535audio_pcm.c |  433 ++++++++++++++++++++++++++++++++
 9 files changed, 1009 insertions(+)
diff -uprN -X dontdiff.13.1 linux-2.6.13.1-vanilla/CREDITS linux-2.6.13.1/CREDITS
--- linux-2.6.13.1-vanilla/CREDITS	2005-09-15 14:33:46.000000000 +0800
+++ linux-2.6.13.1/CREDITS	2005-09-15 14:51:10.000000000 +0800
@@ -1884,6 +1884,7 @@ N: Jaya Kumar
 E: jayalk@intworks.biz
 W: http://www.intworks.biz
 D: Arc monochrome LCD framebuffer driver, x86 reboot fixups
+D: pirq addr, CS5535 alsa audio driver
 S: Gurgaon, India
 S: Kuala Lumpur, Malaysia
 
diff -uprN -X dontdiff.13.1 linux-2.6.13.1-vanilla/include/linux/pci_ids.h linux-2.6.13.1/include/linux/pci_ids.h
--- linux-2.6.13.1-vanilla/include/linux/pci_ids.h	2005-09-15 14:36:19.000000000 +0800
+++ linux-2.6.13.1/include/linux/pci_ids.h	2005-09-15 14:47:41.000000000 +0800
@@ -392,6 +392,10 @@
 #define PCI_DEVICE_ID_NS_87560_USB	0x0012
 #define PCI_DEVICE_ID_NS_83815		0x0020
 #define PCI_DEVICE_ID_NS_83820		0x0022
+#define PCI_DEVICE_ID_NS_CS5535_IDE	0x002d
+#define PCI_DEVICE_ID_NS_CS5535_AUDIO	0x002e
+#define PCI_DEVICE_ID_NS_CS5535_USB	0x002f
+#define PCI_DEVICE_ID_NS_CS5535_VIDEO	0x0030
 #define PCI_DEVICE_ID_NS_SCx200_BRIDGE	0x0500
 #define PCI_DEVICE_ID_NS_SCx200_SMI	0x0501
 #define PCI_DEVICE_ID_NS_SCx200_IDE	0x0502
diff -uprN -X dontdiff.13.1 linux-2.6.13.1-vanilla/include/sound/cs5535audio.h linux-2.6.13.1/include/sound/cs5535audio.h
--- linux-2.6.13.1-vanilla/include/sound/cs5535audio.h	1970-01-01 07:30:00.000000000 +0730
+++ linux-2.6.13.1/include/sound/cs5535audio.h	2005-09-15 14:47:41.000000000 +0800
@@ -0,0 +1,128 @@
+#ifndef __SOUND_CS5535AUDIO_H
+#define __SOUND_CS5535AUDIO_H
+
+#ifdef __KERNEL__
+
+#define cs_writel(reg, val) 	outl(val, (int) cs5535au->port + reg)
+#define cs_writeb(reg, val) 	outb(val, (int) cs5535au->port + reg)
+#define cs_readl(reg) 		inl((unsigned short) (cs5535au->port + reg))
+#define cs_readw(reg) 		inw((unsigned short) (cs5535au->port + reg))
+#define cs_readb(reg) 		inb((unsigned short) (cs5535au->port + reg))
+
+#define CS5535AUDIO_MAX_DESCRIPTORS	128	
+
+/* acc_codec bar0 reg addrs */
+#define ACC_GPIO_STATUS			0x00
+#define ACC_CODEC_STATUS		0x08
+#define ACC_CODEC_CNTL			0x0C
+#define ACC_IRQ_STATUS			0x12
+#define ACC_BM0_CMD			0x20
+#define ACC_BM1_CMD			0x28
+#define ACC_BM2_CMD			0x30
+#define ACC_BM3_CMD			0x38
+#define ACC_BM4_CMD			0x40
+#define ACC_BM5_CMD			0x48
+#define ACC_BM6_CMD			0x50
+#define ACC_BM7_CMD			0x58
+#define ACC_BM0_PRD			0x24
+#define ACC_BM1_PRD			0x2C
+#define ACC_BM2_PRD			0x34
+#define ACC_BM3_PRD			0x3C
+#define ACC_BM4_PRD			0x44
+#define ACC_BM5_PRD			0x4C
+#define ACC_BM6_PRD			0x54
+#define ACC_BM7_PRD			0x5C
+#define ACC_BM0_STATUS			0x21
+#define ACC_BM1_STATUS			0x29
+#define ACC_BM2_STATUS			0x31
+#define ACC_BM3_STATUS			0x39
+#define ACC_BM4_STATUS			0x41
+#define ACC_BM5_STATUS			0x49
+#define ACC_BM6_STATUS			0x51
+#define ACC_BM7_STATUS			0x59
+#define ACC_BM0_PNTR			0x60
+#define ACC_BM1_PNTR			0x64
+#define ACC_BM2_PNTR			0x68
+#define ACC_BM3_PNTR			0x6C
+#define ACC_BM4_PNTR			0x70
+#define ACC_BM5_PNTR			0x74
+#define ACC_BM6_PNTR			0x78
+#define ACC_BM7_PNTR			0x7C
+/* acc_codec bar0 reg bits */
+/* ACC_IRQ_STATUS */
+#define IRQ_STS 			0
+#define WU_IRQ_STS 			1
+#define BM0_IRQ_STS 			2
+#define BM1_IRQ_STS 			3
+#define BM2_IRQ_STS 			4
+#define BM3_IRQ_STS 			5
+#define BM4_IRQ_STS 			6
+#define BM5_IRQ_STS		 	7
+#define BM6_IRQ_STS 			8
+#define BM7_IRQ_STS 			9
+/* ACC_BMX_STATUS */
+#define EOP				(1<<0)
+#define BM_EOP_ERR			(1<<1)
+/* ACC_BMX_CTL */
+#define BM_CTL_EN			0x00000001
+#define BM_CTL_PAUSE			0x00000011
+#define BM_CTL_DIS			0x00000000
+#define BM_CTL_BYTE_ORD_LE		0x00000000
+#define BM_CTL_BYTE_ORD_BE		0x00000100
+/* cs5535 specific ac97 codec register defines */
+#define CMD_MASK			0xFF00FFFF
+#define CMD_NEW				0x00010000  
+#define STS_NEW				0x00020000
+#define PRM_RDY_STS			0x00800000  
+#define ACC_CODEC_CNTL_WR_CMD		(~0x80000000)
+#define ACC_CODEC_CNTL_RD_CMD		0x80000000
+
+typedef struct _snd_cs5535audio cs5535audio_t;
+typedef struct snd_cs5535audio_dma cs5535audio_dma_t;
+typedef struct snd_cs5535audio_dma_ops cs5535audio_dma_ops_t;
+
+enum { CS5535AUDIO_DMA_PLAYBACK, CS5535AUDIO_DMA_CAPTURE, NUM_CS5535AUDIO_DMAS }; 
+struct snd_cs5535audio_dma_ops {
+	int type;
+	void (*enable_dma)(cs5535audio_t *cs5535au);
+	void (*disable_dma)(cs5535audio_t *cs5535au);
+	void (*pause_dma)(cs5535audio_t *cs5535au);	
+	void (*setup_prd)(cs5535audio_t *cs5535au, u32 prd_addr); 
+	u32 (*read_dma_pntr)(cs5535audio_t *cs5535au); 
+};
+
+typedef struct cs5535audio_dma_desc {
+	u32 addr;	
+	u16 size;
+	u16 reserved:13;
+	u16 jmp:1;
+	u16 eop:1;
+	u16 eot:1;
+} cs5535audio_dma_desc_t;
+
+struct snd_cs5535audio_dma {
+	const cs5535audio_dma_ops_t *ops;
+	struct snd_dma_buffer desc_buf;
+	snd_pcm_substream_t *substream;	
+	unsigned int buf_addr, buf_bytes;	
+	unsigned int period_bytes, periods;
+	int index;
+};
+
+struct _snd_cs5535audio {
+	snd_card_t *card;
+	ac97_t *ac97;
+	int irq;
+	struct pci_dev *pci;
+	unsigned long port;
+	spinlock_t reg_lock;
+	snd_pcm_substream_t *playback_substream;
+	snd_pcm_substream_t *capture_substream;
+	cs5535audio_dma_t dmas[NUM_CS5535AUDIO_DMAS];
+};
+
+int __devinit snd_cs5535audio_pcm(cs5535audio_t *cs5535audio);
+#endif /* __KERNEL__ */
+
+#endif /* __SOUND_CS5535AUDIO_H */
+
diff -uprN -X dontdiff.13.1 linux-2.6.13.1-vanilla/MAINTAINERS linux-2.6.13.1/MAINTAINERS
--- linux-2.6.13.1-vanilla/MAINTAINERS	2005-09-15 14:34:02.000000000 +0800
+++ linux-2.6.13.1/MAINTAINERS	2005-09-15 15:00:19.000000000 +0800
@@ -621,6 +621,11 @@ M:	davem@davemloft.net
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
 
+CS5535 Audio ALSA driver
+P:	Jaya Kumar
+M:	jayakumar.alsa@gmail.com
+S:	Maintained
+
 CYBERPRO FB DRIVER
 P:	Russell King
 M:	rmk@arm.linux.org.uk
diff -uprN -X dontdiff.13.1 linux-2.6.13.1-vanilla/sound/pci/cs5535audio/cs5535audio.c linux-2.6.13.1/sound/pci/cs5535audio/cs5535audio.c
--- linux-2.6.13.1-vanilla/sound/pci/cs5535audio/cs5535audio.c	1970-01-01 07:30:00.000000000 +0730
+++ linux-2.6.13.1/sound/pci/cs5535audio/cs5535audio.c	2005-09-15 14:47:41.000000000 +0800
@@ -0,0 +1,416 @@
+/*
+ * Driver for audio on multifunction CS5535 companion device
+ * Copyright (C) Jaya Kumar
+ *  
+ * Based on Jaroslav Kysela and Takashi Iwai's examples.
+ * This work was sponsored by CIS(M) Sdn Bhd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include <asm/io.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/moduleparam.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/control.h>
+#include <sound/pcm.h>
+#include <sound/rawmidi.h>
+#include <sound/ac97_codec.h>
+#include <sound/initval.h>
+#include <sound/asoundef.h>
+#include <sound/cs5535audio.h>
+
+#define do_delay() do { \
+        set_current_state(TASK_UNINTERRUPTIBLE); \
+        schedule_timeout(1); \
+} while (0)
+
+#define DRIVER_NAME "cs5535audio"
+
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	
+
+static struct pci_device_id snd_cs5535audio_ids[] = {
+	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO, PCI_ANY_ID, 
+		PCI_ANY_ID, 0, 0, 0, },	
+	{}
+};
+
+MODULE_DEVICE_TABLE(pci, snd_cs5535audio_ids);
+
+static unsigned short snd_cs5535audio_codec_read(cs5535audio_t *cs5535au, 
+							unsigned short reg)
+{
+	unsigned long regdata=0;
+	unsigned long tmp, timeout;
+	unsigned long val;
+
+	regdata = ((unsigned long) reg) << 24;
+	regdata |= ACC_CODEC_CNTL_RD_CMD;
+	regdata |= CMD_NEW;
+ 
+	cs_writel(ACC_CODEC_CNTL, regdata);
+
+	timeout = 500;
+	do {
+		tmp = cs_readl(ACC_CODEC_CNTL);
+		if (!(tmp & CMD_NEW)) 
+			break;
+		do_delay();
+	} while (timeout--);
+	if (!timeout) {
+		snd_printk(KERN_ERR "Failure writing to cs5535 codec\n");
+	}
+
+	timeout = 50;
+	do {
+		val = cs_readl(ACC_CODEC_STATUS);
+		if (	(val & STS_NEW) && 
+			((unsigned long) reg == ((0xFF000000 & val)>>24)) )
+			break;
+		do_delay();
+	} while (timeout--);
+	if (!timeout) {
+		snd_printk(KERN_ERR "Failure reading cs5535 codec\n");
+	}
+
+	return ((unsigned short) val);
+}
+
+static void snd_cs5535audio_codec_write(cs5535audio_t *cs5535au,
+				   unsigned short reg, unsigned short val)
+{
+	unsigned long regdata=0;
+	unsigned long tmp, timeout;
+
+	regdata = ((unsigned long) reg) << 24; 
+	regdata |= (unsigned long) val;
+	regdata &= CMD_MASK;
+	regdata |= CMD_NEW;
+	regdata &= ACC_CODEC_CNTL_WR_CMD;
+
+	cs_writel(ACC_CODEC_CNTL, regdata);
+
+	timeout = 50;
+	do {
+		tmp = cs_readl(ACC_CODEC_CNTL);
+		if (!(tmp & CMD_NEW)) 
+			break;
+		do_delay();
+	} while (timeout--);
+	if (!timeout) {
+		snd_printk(KERN_ERR "Failure writing to cs5535 codec\n");
+	}
+}
+
+static void snd_cs5535audio_ac97_codec_write(ac97_t *ac97,
+				   unsigned short reg, unsigned short val)
+{
+	cs5535audio_t *cs5535au = ac97->private_data;
+	snd_cs5535audio_codec_write(cs5535au,reg,val);
+}
+
+static unsigned short snd_cs5535audio_ac97_codec_read(ac97_t *ac97,
+					    unsigned short reg)
+{
+	cs5535audio_t *cs5535au = ac97->private_data;
+	return snd_cs5535audio_codec_read(cs5535au,reg);
+}
+
+static void snd_cs5535audio_mixer_free_ac97(ac97_t *ac97)
+{
+	cs5535audio_t *cs5535audio = ac97->private_data;
+	cs5535audio->ac97 = NULL;
+}
+
+static int snd_cs5535audio_mixer(cs5535audio_t *cs5535au)
+{
+	snd_card_t *card = cs5535au->card;
+	ac97_bus_t *pbus;
+	ac97_template_t ac97;
+	int err;
+	static ac97_bus_ops_t ops = {
+		.write = snd_cs5535audio_ac97_codec_write,
+		.read = snd_cs5535audio_ac97_codec_read,
+	};
+
+	if ((err = snd_ac97_bus(card, 0, &ops, NULL, &pbus)) < 0)
+		return err;
+
+	memset(&ac97, 0, sizeof(ac97));
+	ac97.scaps = AC97_SCAP_AUDIO|AC97_SCAP_SKIP_MODEM;
+	ac97.private_data = cs5535au;
+	ac97.pci = cs5535au->pci;
+	ac97.private_free = snd_cs5535audio_mixer_free_ac97;
+
+	if ((err = snd_ac97_mixer(pbus, &ac97, &cs5535au->ac97)) < 0) {
+		snd_printk("mixer failed\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static void process_bm0_irq(cs5535audio_t *cs5535au)
+{ 
+	u8 bm_stat;
+	spin_lock(&cs5535au->reg_lock);
+	bm_stat = cs_readb(ACC_BM0_STATUS);
+	spin_unlock(&cs5535au->reg_lock);
+	if (bm_stat & EOP) {
+		cs5535audio_dma_t *dma;
+		dma = (cs5535audio_dma_t *) 
+			cs5535au->playback_substream->runtime->private_data;
+		dma->index = (++(dma->index)) % dma->periods;
+		snd_pcm_period_elapsed(cs5535au->playback_substream);
+	} else {
+		snd_printk(KERN_ERR "unexpected bm0 irq src, bm_stat=%x\n",
+					bm_stat);
+	}
+}
+
+static void process_bm1_irq(cs5535audio_t *cs5535au)
+{ 
+	u8 bm_stat;
+	spin_lock(&cs5535au->reg_lock);
+	bm_stat = cs_readb(ACC_BM1_STATUS);
+	spin_unlock(&cs5535au->reg_lock);
+	if (bm_stat & EOP) {
+		cs5535audio_dma_t *dma;
+		dma = (cs5535audio_dma_t *) 
+			cs5535au->capture_substream->runtime->private_data;
+		dma->index = (++(dma->index)) % dma->periods;
+		snd_pcm_period_elapsed(cs5535au->capture_substream);
+	}
+}
+
+static irqreturn_t snd_cs5535audio_interrupt(int irq, void *dev_id, 
+						struct pt_regs *regs)
+{
+	u16 acc_irq_stat;
+	u8 bm_stat;
+	unsigned char count;
+	cs5535audio_t *cs5535au = dev_id;
+
+	if (cs5535au == NULL)
+		return IRQ_NONE;
+
+	acc_irq_stat = cs_readw(ACC_IRQ_STATUS);
+
+	if (!acc_irq_stat)
+		return IRQ_NONE; 
+	for (count=0; count < 10; count++) {
+		if (acc_irq_stat & (1<<count)) {
+			switch (count) {
+				case IRQ_STS:
+					cs_readl(ACC_GPIO_STATUS);
+					break;
+				case WU_IRQ_STS:
+					cs_readl(ACC_GPIO_STATUS);
+					break;
+				case BM0_IRQ_STS:
+					process_bm0_irq(cs5535au);
+					break;
+				case BM1_IRQ_STS:
+					process_bm1_irq(cs5535au);
+					break;
+				case BM2_IRQ_STS:
+					bm_stat = cs_readb(ACC_BM2_STATUS);
+					break;
+				case BM3_IRQ_STS:
+					bm_stat = cs_readb(ACC_BM3_STATUS);
+					break;
+				case BM4_IRQ_STS:
+					bm_stat = cs_readb(ACC_BM4_STATUS);
+					break;
+				case BM5_IRQ_STS:
+					bm_stat = cs_readb(ACC_BM5_STATUS);
+					break;
+				case BM6_IRQ_STS:
+					bm_stat = cs_readb(ACC_BM6_STATUS);
+					break;
+				case BM7_IRQ_STS:
+					bm_stat = cs_readb(ACC_BM7_STATUS);
+					break;
+				default:
+					snd_printk(KERN_ERR 
+						"Unexpected irq src\n");
+					break;	
+			}
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+static int snd_cs5535audio_free(cs5535audio_t *cs5535au)
+{
+	synchronize_irq(cs5535au->irq);
+	pci_set_power_state(cs5535au->pci, 3);
+
+	if (cs5535au->irq >= 0)
+		free_irq(cs5535au->irq, (void *)cs5535au);
+
+	pci_release_regions(cs5535au->pci);
+	pci_disable_device(cs5535au->pci);
+	kfree(cs5535au);
+	return 0;
+}
+
+static int snd_cs5535audio_dev_free(snd_device_t *device)
+{
+	cs5535audio_t *cs5535au = device->device_data;
+	return snd_cs5535audio_free(cs5535au);
+}
+
+static int __devinit snd_cs5535audio_create(snd_card_t *card,
+				     struct pci_dev *pci,
+				     cs5535audio_t **rcs5535au)
+{
+	cs5535audio_t *cs5535au;
+
+	int err;
+	static snd_device_ops_t ops = {
+		.dev_free =	snd_cs5535audio_dev_free,
+	};
+
+	*rcs5535au = NULL;
+	if ((err = pci_enable_device(pci)) < 0)
+		return err;
+	cs5535au = kcalloc(1, sizeof(*cs5535au), GFP_KERNEL);
+	if (cs5535au == NULL) {
+		pci_disable_device(pci);
+		return -ENOMEM;
+	}
+	spin_lock_init(&cs5535au->reg_lock);
+	cs5535au->card = card;
+	cs5535au->pci = pci;
+	cs5535au->irq = -1;
+	if ((err = pci_request_regions(pci, "CS5535 Audio")) < 0) {
+		kfree(cs5535au);
+		pci_disable_device(pci);
+		return err;
+	}
+	cs5535au->port = pci_resource_start(pci, 0);
+	if (request_irq(pci->irq, snd_cs5535audio_interrupt, 
+		SA_INTERRUPT|SA_SHIRQ, "CS5535 Audio", (void *) cs5535au)) {
+		snd_printk("unable to grab IRQ %d\n", pci->irq);
+		snd_cs5535audio_free(cs5535au);
+		return -EBUSY;
+	}
+
+	cs5535au->irq = pci->irq;
+	pci_set_master(pci);
+
+	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, 
+					cs5535au, &ops)) < 0) {
+		snd_cs5535audio_free(cs5535au);
+		return err;
+	}
+
+	snd_card_set_dev(card, &pci->dev);
+
+	*rcs5535au = cs5535au;
+	return 0;
+}
+
+static int __devinit snd_cs5535audio_probe(struct pci_dev *pci,
+					const struct pci_device_id *pci_id)
+{
+	static int dev;
+	snd_card_t *card;
+	cs5535audio_t *cs5535au;
+	int err;
+
+	if (dev >= SNDRV_CARDS)
+		return -ENODEV;
+	if (!enable[dev]) {
+		dev++;
+		return -ENOENT;
+	}
+
+	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
+	if (card == NULL)
+		return -ENOMEM;
+
+	if ((err = snd_cs5535audio_create(card, pci, &cs5535au)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+	if ((err = snd_cs5535audio_mixer(cs5535au)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+	if ((err = snd_cs5535audio_pcm(cs5535au)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+	strcpy(card->driver, DRIVER_NAME);
+
+	strcpy(card->shortname, "CS5535 Audio");
+	sprintf(card->longname, "%s %s at 0x%lx, irq %i",
+		card->shortname, card->driver,
+		cs5535au->port, cs5535au->irq);
+
+	if ((err = snd_card_register(card)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+	pci_set_drvdata(pci, card);
+	dev++;
+	return 0;
+}
+
+static void __devexit snd_cs5535audio_remove(struct pci_dev *pci)
+{
+	snd_card_free(pci_get_drvdata(pci));
+	pci_set_drvdata(pci, NULL);
+}
+
+static struct pci_driver driver = {
+	.name = DRIVER_NAME,
+	.id_table = snd_cs5535audio_ids,
+	.probe = snd_cs5535audio_probe,
+	.remove = __devexit_p(snd_cs5535audio_remove),
+};
+	
+static int __init alsa_card_cs5535audio_init(void)
+{
+	return pci_module_init(&driver);
+}
+
+static void __exit alsa_card_cs5535audio_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
+module_init(alsa_card_cs5535audio_init)
+module_exit(alsa_card_cs5535audio_exit)
+
+MODULE_AUTHOR("Jaya Kumar");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("CS5535 Audio");
+MODULE_SUPPORTED_DEVICE("CS5535 Audio");
diff -uprN -X dontdiff.13.1 linux-2.6.13.1-vanilla/sound/pci/cs5535audio/cs5535audio_pcm.c linux-2.6.13.1/sound/pci/cs5535audio/cs5535audio_pcm.c
--- linux-2.6.13.1-vanilla/sound/pci/cs5535audio/cs5535audio_pcm.c	1970-01-01 07:30:00.000000000 +0730
+++ linux-2.6.13.1/sound/pci/cs5535audio/cs5535audio_pcm.c	2005-09-15 14:47:41.000000000 +0800
@@ -0,0 +1,433 @@
+/*
+ * Driver for audio on multifunction CS5535 companion device
+ * Copyright (C) Jaya Kumar
+ *  
+ * Based on Jaroslav Kysela and Takashi Iwai's examples.
+ * This work was sponsored by CIS(M) Sdn Bhd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ * todo: add be fmt support, spdif, pm
+ */
+
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/control.h>
+#include <sound/initval.h>
+#include <sound/asoundef.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/ac97_codec.h>
+#include <sound/cs5535audio.h>
+
+static snd_pcm_hardware_t snd_cs5535audio_playback =
+{
+	.info =			(
+				SNDRV_PCM_INFO_MMAP | 
+				SNDRV_PCM_INFO_INTERLEAVED |
+		 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 		SNDRV_PCM_INFO_MMAP_VALID |
+		 		SNDRV_PCM_INFO_PAUSE | 
+				SNDRV_PCM_INFO_SYNC_START
+				),
+	.formats =		(
+				SNDRV_PCM_FMTBIT_S16_LE 
+				),
+	.rates =		(
+				SNDRV_PCM_RATE_CONTINUOUS | 
+				SNDRV_PCM_RATE_8000_48000
+				),
+	.rate_min =		4000,
+	.rate_max =		48000,
+	.channels_min =		2,
+	.channels_max =		2,
+	.buffer_bytes_max =	(128*1024),
+	.period_bytes_min =	64,
+	.period_bytes_max =	(64*1024 - 16),
+	.periods_min =		1,
+	.periods_max =		CS5535AUDIO_MAX_DESCRIPTORS,
+	.fifo_size =		0,
+};
+
+static snd_pcm_hardware_t snd_cs5535audio_capture =
+{
+	.info =			(
+				SNDRV_PCM_INFO_MMAP | 
+				SNDRV_PCM_INFO_INTERLEAVED |
+		 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 		SNDRV_PCM_INFO_MMAP_VALID | 
+				SNDRV_PCM_INFO_SYNC_START
+				),
+	.formats =		(
+				SNDRV_PCM_FMTBIT_S16_LE 
+				),
+	.rates =		(
+				SNDRV_PCM_RATE_CONTINUOUS | 
+				SNDRV_PCM_RATE_8000_48000
+				),
+	.rate_min =		4000,
+	.rate_max =		48000,
+	.channels_min =		2,
+	.channels_max =		2,
+	.buffer_bytes_max =	(128*1024),
+	.period_bytes_min =	64,
+	.period_bytes_max =	(64*1024 - 16),
+	.periods_min =		1,
+	.periods_max =		CS5535AUDIO_MAX_DESCRIPTORS,
+	.fifo_size =		0,
+};
+
+static int snd_cs5535audio_playback_open(snd_pcm_substream_t *substream)
+{
+	int err;
+	cs5535audio_t *cs5535au = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+
+	runtime->hw = snd_cs5535audio_playback;
+	cs5535au->playback_substream = substream;
+	runtime->private_data = &(cs5535au->dmas[CS5535AUDIO_DMA_PLAYBACK]);
+	snd_pcm_set_sync(substream);
+	if ((err = snd_pcm_hw_constraint_integer(runtime, 
+				SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
+		return err;
+
+	return 0;
+}
+
+static int snd_cs5535audio_playback_close(snd_pcm_substream_t *substream)
+{
+	return 0;
+}
+
+#define CS5535AUDIO_DESC_LIST_SIZE \
+	PAGE_ALIGN(CS5535AUDIO_MAX_DESCRIPTORS * sizeof(cs5535audio_dma_desc_t))
+
+static int cs5535audio_build_dma_packets(cs5535audio_t *cs5535au, 
+					cs5535audio_dma_t *dma,
+					snd_pcm_substream_t *substream,
+					unsigned int periods,
+					unsigned int period_bytes)
+{
+	unsigned int i;
+	u32 addr, desc_addr, jmpprd_addr;
+	cs5535audio_dma_desc_t *lastdesc;
+
+	if (periods > CS5535AUDIO_MAX_DESCRIPTORS)
+		return -ENOMEM;
+
+	if (dma->desc_buf.area == NULL) {
+		if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, 
+					snd_dma_pci_data(cs5535au->pci),
+					CS5535AUDIO_DESC_LIST_SIZE+1, 
+					&dma->desc_buf) < 0)
+			return -ENOMEM;
+		dma->period_bytes = dma->periods = 0; 
+	}
+
+	if (dma->periods == periods && dma->period_bytes == period_bytes)
+		return 0;
+
+	addr = (u32)substream->runtime->dma_addr;
+	desc_addr = (u32)dma->desc_buf.addr;
+	for (i = 0; i < periods; i++) {
+		cs5535audio_dma_desc_t *desc = 
+			&((cs5535audio_dma_desc_t *)dma->desc_buf.area)[i];
+		desc->addr = cpu_to_le32(addr);
+		desc->eop = 1;
+		desc->size = period_bytes; 
+		desc_addr += sizeof(cs5535audio_dma_desc_t);
+		addr += period_bytes;
+	}
+	/* we reserved one dummy descriptor at the end to do the PRD jump */
+	lastdesc = &((cs5535audio_dma_desc_t *)dma->desc_buf.area)[periods];
+	lastdesc->addr = cpu_to_le32((u32)dma->desc_buf.addr);
+	lastdesc->eop = 0;
+	lastdesc->jmp = 1;
+	lastdesc->size = 0;
+	jmpprd_addr = cpu_to_le32(lastdesc->addr + 
+				(sizeof(cs5535audio_dma_desc_t)*periods));
+
+	dma->period_bytes = period_bytes;
+	dma->periods = periods;
+	spin_lock(&cs5535au->reg_lock);
+	dma->ops->disable_dma(cs5535au);
+	dma->ops->setup_prd(cs5535au, jmpprd_addr);
+	spin_unlock(&cs5535au->reg_lock);
+	return 0;
+}
+
+static void cs5535audio_playback_enable_dma(cs5535audio_t *cs5535au)
+{
+	cs_writeb(ACC_BM0_CMD, BM_CTL_EN);
+}
+
+static void cs5535audio_playback_disable_dma(cs5535audio_t *cs5535au)
+{
+	cs_writeb(ACC_BM0_CMD, 0);
+}
+
+static void cs5535audio_playback_pause_dma(cs5535audio_t *cs5535au)
+{
+	cs_writeb(ACC_BM0_CMD, BM_CTL_PAUSE);
+}
+
+static void cs5535audio_playback_setup_prd(cs5535audio_t *cs5535au, 
+						u32 prd_addr)
+{
+	cs_writel(ACC_BM0_PRD, prd_addr);
+}
+
+static u32 cs5535audio_playback_read_dma_pntr(cs5535audio_t *cs5535au)
+{
+	return cs_readl(ACC_BM0_PNTR);
+}
+
+static void cs5535audio_capture_enable_dma(cs5535audio_t *cs5535au)
+{
+	cs_writeb(ACC_BM1_CMD, BM_CTL_EN);
+}
+
+static void cs5535audio_capture_disable_dma(cs5535audio_t *cs5535au)
+{
+	cs_writeb(ACC_BM1_CMD, 0);
+}
+
+static void cs5535audio_capture_pause_dma(cs5535audio_t *cs5535au)
+{
+	cs_writeb(ACC_BM1_CMD, BM_CTL_PAUSE);
+}
+
+static void cs5535audio_capture_setup_prd(cs5535audio_t *cs5535au, 
+						u32 prd_addr)
+{
+	cs_writel(ACC_BM1_PRD, prd_addr);
+}
+
+static u32 cs5535audio_capture_read_dma_pntr(cs5535audio_t *cs5535au)
+{
+	return cs_readl(ACC_BM1_PNTR);
+}
+
+static void cs5535audio_clear_dma_packets(cs5535audio_t *cs5535au, 
+					cs5535audio_dma_t *dma, 
+					snd_pcm_substream_t *substream)
+{
+	snd_dma_free_pages(&dma->desc_buf);
+	dma->desc_buf.area = NULL;
+}
+
+static int snd_cs5535audio_hw_params(snd_pcm_substream_t *substream,
+				 snd_pcm_hw_params_t *hw_params)
+{
+	cs5535audio_t *cs5535au = snd_pcm_substream_chip(substream);
+	cs5535audio_dma_t *dma = (cs5535audio_dma_t *)
+					substream->runtime->private_data;
+	int err;
+
+	err = snd_pcm_lib_malloc_pages(substream, 
+					params_buffer_bytes(hw_params));
+	if (err < 0)
+		return err;
+	dma->buf_addr = substream->runtime->dma_addr;
+	dma->buf_bytes = params_buffer_bytes(hw_params);
+
+	err = cs5535audio_build_dma_packets(cs5535au, dma, substream,
+				       params_periods(hw_params),
+				       params_period_bytes(hw_params));
+	return err;
+}
+
+static int snd_cs5535audio_hw_free(snd_pcm_substream_t *substream)
+{
+	cs5535audio_t *cs5535au = snd_pcm_substream_chip(substream);
+	cs5535audio_dma_t *dma = (cs5535audio_dma_t *)
+				substream->runtime->private_data;
+
+	cs5535audio_clear_dma_packets(cs5535au, dma, substream);
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static int snd_cs5535audio_playback_prepare(snd_pcm_substream_t *substream)
+{
+	cs5535audio_t *cs5535au = snd_pcm_substream_chip(substream);
+	return snd_ac97_set_rate(cs5535au->ac97, AC97_PCM_FRONT_DAC_RATE, 
+					substream->runtime->rate);
+}
+
+static int snd_cs5535audio_trigger(snd_pcm_substream_t *substream, int cmd)
+{
+	cs5535audio_t *cs5535au = snd_pcm_substream_chip(substream);
+	cs5535audio_dma_t *dma = (cs5535audio_dma_t *)
+				substream->runtime->private_data;
+
+	switch (cmd) {
+		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+			spin_lock(&cs5535au->reg_lock);
+			dma->ops->pause_dma(cs5535au);
+			spin_unlock(&cs5535au->reg_lock);
+			break;
+		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+			spin_lock(&cs5535au->reg_lock);
+			dma->ops->enable_dma(cs5535au);
+			spin_unlock(&cs5535au->reg_lock);
+			break;
+		case SNDRV_PCM_TRIGGER_START:
+			spin_lock(&cs5535au->reg_lock);
+			dma->ops->enable_dma(cs5535au);
+			spin_unlock(&cs5535au->reg_lock);
+			break;
+		case SNDRV_PCM_TRIGGER_STOP:
+			spin_lock(&cs5535au->reg_lock);
+			dma->ops->disable_dma(cs5535au);
+			spin_unlock(&cs5535au->reg_lock);
+			break;
+		default:
+			snd_printk(KERN_ERR "unhandled trigger\n");
+			return -EINVAL;
+			break;
+	}
+	return 0;
+}
+
+static snd_pcm_uframes_t snd_cs5535audio_pcm_pointer(snd_pcm_substream_t 
+							*substream)
+{
+	cs5535audio_t *cs5535au = snd_pcm_substream_chip(substream);
+	u32 curdma;
+	cs5535audio_dma_t *dma;
+
+	dma = (cs5535audio_dma_t *)substream->runtime->private_data;
+
+	curdma = dma->ops->read_dma_pntr(cs5535au);
+	if (curdma < dma->buf_addr) {
+		snd_printk(KERN_ERR "curdma=%x < %x bufaddr.\n",
+					curdma, dma->buf_addr);
+		return 0;
+	}
+	curdma -= dma->buf_addr;
+	if (curdma >= dma->buf_bytes) {
+		snd_printk(KERN_ERR "diff=%x >= %x buf_bytes.\n",
+					curdma, dma->buf_bytes);
+		return 0;
+	}
+	return bytes_to_frames(substream->runtime, curdma);
+}
+
+static int snd_cs5535audio_capture_open(snd_pcm_substream_t *substream)
+{
+	int err;
+	cs5535audio_t *cs5535au = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+
+	runtime->hw = snd_cs5535audio_capture;
+	cs5535au->capture_substream = substream;
+	runtime->private_data = &(cs5535au->dmas[CS5535AUDIO_DMA_CAPTURE]);
+	snd_pcm_set_sync(substream);
+	if ((err = snd_pcm_hw_constraint_integer(runtime,
+					 SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
+		return err;
+	return 0;
+}
+
+static int snd_cs5535audio_capture_close(snd_pcm_substream_t *substream)
+{
+	return 0;
+}
+
+static int snd_cs5535audio_capture_prepare(snd_pcm_substream_t *substream)
+{
+	cs5535audio_t *cs5535au = snd_pcm_substream_chip(substream);
+	return snd_ac97_set_rate(cs5535au->ac97, AC97_PCM_LR_ADC_RATE, 
+					substream->runtime->rate);
+}
+
+static snd_pcm_ops_t snd_cs5535audio_playback_ops = {
+	.open =		snd_cs5535audio_playback_open,
+	.close =	snd_cs5535audio_playback_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_cs5535audio_hw_params,
+	.hw_free =	snd_cs5535audio_hw_free,
+	.prepare =	snd_cs5535audio_playback_prepare,
+	.trigger =	snd_cs5535audio_trigger,
+	.pointer =	snd_cs5535audio_pcm_pointer,
+};
+
+static snd_pcm_ops_t snd_cs5535audio_capture_ops = {
+	.open =		snd_cs5535audio_capture_open,
+	.close =	snd_cs5535audio_capture_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	snd_cs5535audio_hw_params,
+	.hw_free =	snd_cs5535audio_hw_free,
+	.prepare =	snd_cs5535audio_capture_prepare,
+	.trigger =	snd_cs5535audio_trigger,
+	.pointer =	snd_cs5535audio_pcm_pointer,
+};
+
+static void snd_cs5535audio_pcm_free(snd_pcm_t *pcm)
+{
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+}
+
+static cs5535audio_dma_ops_t snd_cs5535audio_playback_dma_ops = {
+        .type = CS5535AUDIO_DMA_PLAYBACK,
+        .enable_dma = cs5535audio_playback_enable_dma,
+        .disable_dma = cs5535audio_playback_disable_dma,
+        .setup_prd = cs5535audio_playback_setup_prd,
+        .pause_dma = cs5535audio_playback_pause_dma,
+        .read_dma_pntr = cs5535audio_playback_read_dma_pntr,
+};
+        
+static cs5535audio_dma_ops_t snd_cs5535audio_capture_dma_ops = {
+        .type = CS5535AUDIO_DMA_CAPTURE,
+        .enable_dma = cs5535audio_capture_enable_dma,
+        .disable_dma = cs5535audio_capture_disable_dma,
+        .setup_prd = cs5535audio_capture_setup_prd,
+        .pause_dma = cs5535audio_capture_pause_dma,
+        .read_dma_pntr = cs5535audio_capture_read_dma_pntr,
+};
+
+int __devinit snd_cs5535audio_pcm(cs5535audio_t *cs5535au)
+{
+	snd_pcm_t *pcm;
+	int err;
+
+	err = snd_pcm_new(cs5535au->card, "CS5535 Audio", 0, 1, 1, &pcm);
+	if (err < 0)
+		return err;
+
+	cs5535au->dmas[CS5535AUDIO_DMA_PLAYBACK].ops = 
+					&snd_cs5535audio_playback_dma_ops;
+	cs5535au->dmas[CS5535AUDIO_DMA_CAPTURE].ops = 
+					&snd_cs5535audio_capture_dma_ops;
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, 
+					&snd_cs5535audio_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, 
+					&snd_cs5535audio_capture_ops);
+
+	pcm->private_data = cs5535au;
+	pcm->private_free = snd_cs5535audio_pcm_free;
+	pcm->info_flags = 0;
+	strcpy(pcm->name, "CS5535 Audio");
+
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+					snd_dma_pci_data(cs5535au->pci),
+					64*1024, 128*1024);
+
+	return 0;
+}
+
diff -uprN -X dontdiff.13.1 linux-2.6.13.1-vanilla/sound/pci/cs5535audio/Makefile linux-2.6.13.1/sound/pci/cs5535audio/Makefile
--- linux-2.6.13.1-vanilla/sound/pci/cs5535audio/Makefile	1970-01-01 07:30:00.000000000 +0730
+++ linux-2.6.13.1/sound/pci/cs5535audio/Makefile	2005-09-15 14:47:41.000000000 +0800
@@ -0,0 +1,8 @@
+#
+# Makefile for cs5535audio
+#
+
+snd-cs5535audio-objs := cs5535audio.o cs5535audio_pcm.o
+
+# Toplevel Module Dependency
+obj-$(CONFIG_SND_CS5535AUDIO) += snd-cs5535audio.o
diff -uprN -X dontdiff.13.1 linux-2.6.13.1-vanilla/sound/pci/Kconfig linux-2.6.13.1/sound/pci/Kconfig
--- linux-2.6.13.1-vanilla/sound/pci/Kconfig	2005-09-15 14:36:41.000000000 +0800
+++ linux-2.6.13.1/sound/pci/Kconfig	2005-09-15 16:34:18.000000000 +0800
@@ -350,6 +350,19 @@ config SND_ENS1370
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-ens1370.
 
+config SND_CS5535AUDIO
+	tristate "CS5535 Audio"
+	depends on SND
+	select SND_PCM
+	select SND_AC97_CODEC
+	help
+	  Say Y here to include support for audio on CS5535 chips. It is
+	  referred to as NS CS5535 IO or AMD CS5535 IO companion in 
+	  various literature.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-cs5535audio.
+
 config SND_ENS1371
 	tristate "(Creative) Ensoniq AudioPCI 1371/1373"
 	depends on SND
diff -uprN -X dontdiff.13.1 linux-2.6.13.1-vanilla/sound/pci/Makefile linux-2.6.13.1/sound/pci/Makefile
--- linux-2.6.13.1-vanilla/sound/pci/Makefile	2005-09-15 14:36:41.000000000 +0800
+++ linux-2.6.13.1/sound/pci/Makefile	2005-09-15 14:47:41.000000000 +0800
@@ -52,6 +52,7 @@ obj-$(CONFIG_SND) += \
 	au88x0/ \
 	ca0106/ \
 	cs46xx/ \
+	cs5535audio/ \
 	emu10k1/ \
 	hda/ \
 	ice1712/ \
