Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262910AbUKYB3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbUKYB3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 20:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUKYB32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 20:29:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42247 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262885AbUKYB2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 20:28:03 -0500
Date: Thu, 25 Nov 2004 00:27:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ALSA ISA drivers: misc cleanups
Message-ID: <20041124232758.GP19873@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes cleanups under sound/isa/ including:
- make needlessly global code static
- ad1816a/ad1816a_lib.c: much code was unused starting with the
                         global function snd_ad1816a_timer
- removed EXPORT_SYMBOL's:
  - cs423x/cs4231_lib.c: snd_cs4231_outm
  - es1688/es1688_lib.c: snd_es1688_mixer_read

Please review this patch.


diffstat output:
 include/sound/ad1848.h                |    4 -
 include/sound/cs4231.h                |    5 -
 include/sound/es1688.h                |    1 
 include/sound/gus.h                   |    4 -
 include/sound/sb.h                    |    4 -
 include/sound/snd_wavefront.h         |    1 
 sound/isa/ad1816a/ad1816a_lib.c       |  100 --------------------------
 sound/isa/ad1848/ad1848_lib.c         |    4 -
 sound/isa/cs423x/cs4231_lib.c         |   11 +-
 sound/isa/es1688/es1688_lib.c         |    5 -
 sound/isa/es18xx.c                    |    6 -
 sound/isa/gus/gus_dma.c               |   12 +--
 sound/isa/opl3sa2.c                   |   10 +-
 sound/isa/opti9xx/opti92x-ad1848.c    |   12 +--
 sound/isa/sb/sb16_main.c              |   10 +-
 sound/isa/sb/sb8_main.c               |    4 -
 sound/isa/sb/sb_common.c              |    2 
 sound/isa/wavefront/wavefront.c       |    6 -
 sound/isa/wavefront/wavefront_fx.c    |   39 +++++-----
 sound/isa/wavefront/wavefront_synth.c |   98 ++++++++++++-------------
 sound/sparc/cs4231.c                  |    4 -
 21 files changed, 116 insertions(+), 226 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/sound/isa/ad1816a/ad1816a_lib.c.old	2004-11-24 22:52:44.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/isa/ad1816a/ad1816a_lib.c	2004-11-24 23:51:01.000000000 +0100
@@ -46,20 +46,20 @@
 	return -EBUSY;
 }
 
-inline unsigned char snd_ad1816a_in(ad1816a_t *chip, unsigned char reg)
+static inline unsigned char snd_ad1816a_in(ad1816a_t *chip, unsigned char reg)
 {
 	snd_ad1816a_busy_wait(chip);
 	return inb(AD1816A_REG(reg));
 }
 
-inline void snd_ad1816a_out(ad1816a_t *chip, unsigned char reg,
+static inline void snd_ad1816a_out(ad1816a_t *chip, unsigned char reg,
 			    unsigned char value)
 {
 	snd_ad1816a_busy_wait(chip);
 	outb(value, AD1816A_REG(reg));
 }
 
-inline void snd_ad1816a_out_mask(ad1816a_t *chip, unsigned char reg,
+static inline void snd_ad1816a_out_mask(ad1816a_t *chip, unsigned char reg,
 				 unsigned char mask, unsigned char value)
 {
 	snd_ad1816a_out(chip, reg,
@@ -372,71 +372,6 @@
 	.fifo_size =		0,
 };
 
-static int snd_ad1816a_timer_close(snd_timer_t *timer)
-{
-	ad1816a_t *chip = snd_timer_chip(timer);
-	snd_ad1816a_close(chip, AD1816A_MODE_TIMER);
-	return 0;
-}
-
-static int snd_ad1816a_timer_open(snd_timer_t *timer)
-{
-	ad1816a_t *chip = snd_timer_chip(timer);
-	snd_ad1816a_open(chip, AD1816A_MODE_TIMER);
-	return 0;
-}
-
-static unsigned long snd_ad1816a_timer_resolution(snd_timer_t *timer)
-{
-	snd_assert(timer != NULL, return 0);
-
-	return 10000;
-}
-
-static int snd_ad1816a_timer_start(snd_timer_t *timer)
-{
-	unsigned short bits;
-	unsigned long flags;
-	ad1816a_t *chip = snd_timer_chip(timer);
-	spin_lock_irqsave(&chip->lock, flags);
-	bits = snd_ad1816a_read(chip, AD1816A_INTERRUPT_ENABLE);
-
-	if (!(bits & AD1816A_TIMER_ENABLE)) {
-		snd_ad1816a_write(chip, AD1816A_TIMER_BASE_COUNT,
-			timer->sticks & 0xffff);
-
-		snd_ad1816a_write_mask(chip, AD1816A_INTERRUPT_ENABLE,
-			AD1816A_TIMER_ENABLE, 0xffff);
-	}
-	spin_unlock_irqrestore(&chip->lock, flags);
-	return 0;
-}
-
-static int snd_ad1816a_timer_stop(snd_timer_t *timer)
-{
-	unsigned long flags;
-	ad1816a_t *chip = snd_timer_chip(timer);
-	spin_lock_irqsave(&chip->lock, flags);
-
-	snd_ad1816a_write_mask(chip, AD1816A_INTERRUPT_ENABLE,
-		AD1816A_TIMER_ENABLE, 0x0000);
-
-	spin_unlock_irqrestore(&chip->lock, flags);
-	return 0;
-}
-
-static struct _snd_timer_hardware snd_ad1816a_timer_table = {
-	.flags =	SNDRV_TIMER_HW_AUTO,
-	.resolution =	10000,
-	.ticks =	65535,
-	.open =		snd_ad1816a_timer_open,
-	.close =	snd_ad1816a_timer_close,
-	.c_resolution =	snd_ad1816a_timer_resolution,
-	.start =	snd_ad1816a_timer_start,
-	.stop =		snd_ad1816a_timer_stop,
-};
-
-
 static int snd_ad1816a_playback_open(snd_pcm_substream_t *substream)
 {
 	ad1816a_t *chip = snd_pcm_substream_chip(substream);
@@ -692,35 +627,6 @@
 	return 0;
 }
 
-static void snd_ad1816a_timer_free(snd_timer_t *timer)
-{
-	ad1816a_t *chip = timer->private_data;
-	chip->timer = NULL;
-}
-
-int snd_ad1816a_timer(ad1816a_t *chip, int device, snd_timer_t **rtimer)
-{
-	snd_timer_t *timer;
-	snd_timer_id_t tid;
-	int error;
-
-	tid.dev_class = SNDRV_TIMER_CLASS_CARD;
-	tid.dev_sclass = SNDRV_TIMER_SCLASS_NONE;
-	tid.card = chip->card->number;
-	tid.device = device;
-	tid.subdevice = 0;
-	if ((error = snd_timer_new(chip->card, "AD1816A", &tid, &timer)) < 0)
-		return error;
-	strcpy(timer->name, snd_ad1816a_chip_id(chip));
-	timer->private_data = chip;
-	timer->private_free = snd_ad1816a_timer_free;
-	chip->timer = timer;
-	timer->hw = snd_ad1816a_timer_table;
-	if (rtimer)
-		*rtimer = timer;
-	return 0;
-}
-
 /*
  *
  */
--- linux-2.6.10-rc2-mm3-full/include/sound/ad1848.h.old	2004-11-24 23:36:26.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/sound/ad1848.h	2004-11-24 23:36:35.000000000 +0100
@@ -203,8 +203,4 @@
 	return snd_ad1848_add_ctl(chip, c->name, c->index, c->type, c->private_value);
 }
 
-#ifdef CONFIG_SND_DEBUG
-void snd_ad1848_debug(ad1848_t *chip);
-#endif
-
 #endif /* __SOUND_AD1848_H */
--- linux-2.6.10-rc2-mm3-full/sound/isa/ad1848/ad1848_lib.c.old	2004-11-24 22:53:45.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/isa/ad1848/ad1848_lib.c	2004-11-24 23:40:34.000000000 +0100
@@ -146,9 +146,9 @@
 	return inb(AD1848P(chip, REG));
 }
 
-#ifdef CONFIG_SND_DEBUG
+#if 0
 
-void snd_ad1848_debug(ad1848_t *chip)
+static void snd_ad1848_debug(ad1848_t *chip)
 {
 	printk("AD1848 REGS:      INDEX = 0x%02x  ", inb(AD1848P(chip, REGSEL)));
 	printk("                 STATUS = 0x%02x\n", inb(AD1848P(chip, STATUS)));
--- linux-2.6.10-rc2-mm3-full/include/sound/cs4231.h.old	2004-11-24 22:56:26.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/sound/cs4231.h	2004-11-24 22:56:45.000000000 +0100
@@ -309,7 +309,6 @@
 
 void snd_cs4231_out(cs4231_t *chip, unsigned char reg, unsigned char val);
 unsigned char snd_cs4231_in(cs4231_t *chip, unsigned char reg);
-void snd_cs4231_outm(cs4231_t *chip, unsigned char reg, unsigned char mask, unsigned char val);
 void snd_cs4236_ext_out(cs4231_t *chip, unsigned char reg, unsigned char val);
 unsigned char snd_cs4236_ext_in(cs4231_t *chip, unsigned char reg);
 void snd_cs4231_mce_up(cs4231_t *chip);
@@ -364,8 +363,4 @@
 int snd_cs4231_get_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol);
 int snd_cs4231_put_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol);
 
-#ifdef CONFIG_SND_DEBUG
-void snd_cs4231_debug(cs4231_t *chip);
-#endif
-
 #endif /* __SOUND_CS4231_H */
--- linux-2.6.10-rc2-mm3-full/sound/sparc/cs4231.c.old	2004-11-24 22:54:36.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/sparc/cs4231.c	2004-11-24 22:55:05.000000000 +0100
@@ -390,7 +390,7 @@
  *  Basic I/O functions
  */
 
-void snd_cs4231_outm(cs4231_t *chip, unsigned char reg,
+static void snd_cs4231_outm(cs4231_t *chip, unsigned char reg,
 		     unsigned char mask, unsigned char value)
 {
 	int timeout;
@@ -475,7 +475,7 @@
 
 #ifdef CONFIG_SND_DEBUG
 
-void snd_cs4231_debug(cs4231_t *chip)
+static void snd_cs4231_debug(cs4231_t *chip)
 {
 	printk("CS4231 REGS:      INDEX = 0x%02x  ",
 	       __cs4231_readb(chip, CS4231P(chip, REGSEL)));
--- linux-2.6.10-rc2-mm3-full/sound/isa/cs423x/cs4231_lib.c.old	2004-11-24 22:55:38.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/isa/cs423x/cs4231_lib.c	2004-11-24 23:40:28.000000000 +0100
@@ -166,8 +166,8 @@
 #endif
 }
 
-void snd_cs4231_outm(cs4231_t *chip, unsigned char reg,
-		     unsigned char mask, unsigned char value)
+static void snd_cs4231_outm(cs4231_t *chip, unsigned char reg,
+			    unsigned char mask, unsigned char value)
 {
 	int timeout;
 	unsigned char tmp;
@@ -271,9 +271,9 @@
 #endif
 }
 
-#ifdef CONFIG_SND_DEBUG
+#if 0
 
-void snd_cs4231_debug(cs4231_t *chip)
+static void snd_cs4231_debug(cs4231_t *chip)
 {
 	printk("CS4231 REGS:      INDEX = 0x%02x  ", cs4231_inb(chip, CS4231P(REGSEL)));
 	printk("                 STATUS = 0x%02x\n", cs4231_inb(chip, CS4231P(STATUS)));
@@ -1026,7 +1026,7 @@
 
  */
 
-int snd_cs4231_probe(cs4231_t *chip)
+static int snd_cs4231_probe(cs4231_t *chip)
 {
 	unsigned long flags;
 	int i, id, rev;
@@ -1934,7 +1934,6 @@
 
 EXPORT_SYMBOL(snd_cs4231_out);
 EXPORT_SYMBOL(snd_cs4231_in);
-EXPORT_SYMBOL(snd_cs4231_outm);
 EXPORT_SYMBOL(snd_cs4236_ext_out);
 EXPORT_SYMBOL(snd_cs4236_ext_in);
 EXPORT_SYMBOL(snd_cs4231_mce_up);
--- linux-2.6.10-rc2-mm3-full/include/sound/es1688.h.old	2004-11-24 22:57:54.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/sound/es1688.h	2004-11-24 22:58:02.000000000 +0100
@@ -108,7 +108,6 @@
  */
 
 void snd_es1688_mixer_write(es1688_t *chip, unsigned char reg, unsigned char data);
-unsigned char snd_es1688_mixer_read(es1688_t *chip, unsigned char reg);
 
 int snd_es1688_create(snd_card_t * card,
 		      unsigned long port,
--- linux-2.6.10-rc2-mm3-full/sound/isa/es1688/es1688_lib.c.old	2004-11-24 22:58:12.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/isa/es1688/es1688_lib.c	2004-11-24 22:58:31.000000000 +0100
@@ -70,7 +70,7 @@
 	return snd_es1688_dsp_command(chip, data);
 }
 
-int snd_es1688_read(es1688_t *chip, unsigned char reg)
+static int snd_es1688_read(es1688_t *chip, unsigned char reg)
 {
 	/* Read a byte from an extended mode register of ES1688 */
 	if (!snd_es1688_dsp_command(chip, 0xc0))
@@ -89,7 +89,7 @@
 	udelay(10);
 }
 
-unsigned char snd_es1688_mixer_read(es1688_t *chip, unsigned char reg)
+static unsigned char snd_es1688_mixer_read(es1688_t *chip, unsigned char reg)
 {
 	unsigned char result;
 
@@ -1041,7 +1041,6 @@
 }
 
 EXPORT_SYMBOL(snd_es1688_mixer_write);
-EXPORT_SYMBOL(snd_es1688_mixer_read);
 EXPORT_SYMBOL(snd_es1688_create);
 EXPORT_SYMBOL(snd_es1688_pcm);
 EXPORT_SYMBOL(snd_es1688_mixer);
--- linux-2.6.10-rc2-mm3-full/sound/isa/es18xx.c.old	2004-11-24 22:59:04.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/isa/es18xx.c	2004-11-24 23:00:02.000000000 +0100
@@ -268,7 +268,7 @@
 	return ret;
 }
 
-inline void snd_es18xx_mixer_write(es18xx_t *chip,
+static inline void snd_es18xx_mixer_write(es18xx_t *chip,
 			    unsigned char reg, unsigned char data)
 {
 	unsigned long flags;
@@ -281,7 +281,7 @@
 #endif
 }
 
-inline int snd_es18xx_mixer_read(es18xx_t *chip, unsigned char reg)
+static inline int snd_es18xx_mixer_read(es18xx_t *chip, unsigned char reg)
 {
 	unsigned long flags;
 	int data;
@@ -1569,7 +1569,7 @@
 	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
 
-int __devinit snd_es18xx_pcm(es18xx_t *chip, int device, snd_pcm_t ** rpcm)
+static int __devinit snd_es18xx_pcm(es18xx_t *chip, int device, snd_pcm_t ** rpcm)
 {
         snd_pcm_t *pcm;
 	char str[16];
--- linux-2.6.10-rc2-mm3-full/include/sound/gus.h.old	2004-11-24 23:00:26.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/sound/gus.h	2004-11-24 23:00:36.000000000 +0100
@@ -598,10 +598,6 @@
 
 /* gus_dma.c */
 
-void snd_gf1_dma_program(snd_gus_card_t * gus, unsigned int addr,
-			 unsigned long buf_addr, unsigned int count,
-			 unsigned int cmd);
-void snd_gf1_dma_ack(snd_gus_card_t * gus);
 int snd_gf1_dma_init(snd_gus_card_t * gus);
 int snd_gf1_dma_done(snd_gus_card_t * gus);
 int snd_gf1_dma_transfer_block(snd_gus_card_t * gus,
--- linux-2.6.10-rc2-mm3-full/sound/isa/gus/gus_dma.c.old	2004-11-24 23:00:44.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/isa/gus/gus_dma.c	2004-11-24 23:01:09.000000000 +0100
@@ -25,7 +25,7 @@
 #include <sound/core.h>
 #include <sound/gus.h>
 
-void snd_gf1_dma_ack(snd_gus_card_t * gus)
+static void snd_gf1_dma_ack(snd_gus_card_t * gus)
 {
 	unsigned long flags;
 
@@ -35,11 +35,11 @@
 	spin_unlock_irqrestore(&gus->reg_lock, flags);
 }
 
-void snd_gf1_dma_program(snd_gus_card_t * gus,
-			 unsigned int addr,
-			 unsigned long buf_addr,
-			 unsigned int count,
-			 unsigned int cmd)
+static void snd_gf1_dma_program(snd_gus_card_t * gus,
+				unsigned int addr,
+				unsigned long buf_addr,
+				unsigned int count,
+				unsigned int cmd)
 {
 	unsigned long flags;
 	unsigned int address;
--- linux-2.6.10-rc2-mm3-full/sound/isa/opl3sa2.c.old	2004-11-24 23:09:20.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/isa/opl3sa2.c	2004-11-24 23:10:13.000000000 +0100
@@ -341,7 +341,7 @@
 	return 0;
 }
 
-int snd_opl3sa2_get_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+static int snd_opl3sa2_get_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	opl3sa2_t *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
@@ -358,7 +358,7 @@
 	return 0;
 }
 
-int snd_opl3sa2_put_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+static int snd_opl3sa2_put_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	opl3sa2_t *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
@@ -388,7 +388,7 @@
   .get = snd_opl3sa2_get_double, .put = snd_opl3sa2_put_double, \
   .private_value = left_reg | (right_reg << 8) | (shift_left << 16) | (shift_right << 19) | (mask << 24) | (invert << 22) }
 
-int snd_opl3sa2_info_double(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+static int snd_opl3sa2_info_double(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	int mask = (kcontrol->private_value >> 24) & 0xff;
 
@@ -399,7 +399,7 @@
 	return 0;
 }
 
-int snd_opl3sa2_get_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+static int snd_opl3sa2_get_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	opl3sa2_t *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
@@ -421,7 +421,7 @@
 	return 0;
 }
 
-int snd_opl3sa2_put_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+static int snd_opl3sa2_put_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	opl3sa2_t *chip = snd_kcontrol_chip(kcontrol);
 	unsigned long flags;
--- linux-2.6.10-rc2-mm3-full/sound/isa/opti9xx/opti92x-ad1848.c.old	2004-11-24 23:10:40.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/isa/opti9xx/opti92x-ad1848.c	2004-11-24 23:11:22.000000000 +0100
@@ -1095,7 +1095,7 @@
 	spin_unlock_irqrestore(&chip->lock, flags);
 }
 
-irqreturn_t snd_opti93x_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t snd_opti93x_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	opti93x_t *codec = dev_id;
 	unsigned char status;
@@ -1263,9 +1263,9 @@
 	}
 }
 
-int snd_opti93x_create(snd_card_t *card, opti9xx_t *chip,
-		       int dma1, int dma2,
-		       opti93x_t **rcodec)
+static int snd_opti93x_create(snd_card_t *card, opti9xx_t *chip,
+			      int dma1, int dma2,
+			      opti93x_t **rcodec)
 {
 	static snd_device_ops_t ops = {
 		.dev_free =	snd_opti93x_dev_free,
@@ -1359,7 +1359,7 @@
 	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
 
-int snd_opti93x_pcm(opti93x_t *codec, int device, snd_pcm_t **rpcm)
+static int snd_opti93x_pcm(opti93x_t *codec, int device, snd_pcm_t **rpcm)
 {
 	int error;
 	snd_pcm_t *pcm;
@@ -1603,7 +1603,7 @@
 }
 };
                                         
-int snd_opti93x_mixer(opti93x_t *chip)
+static int snd_opti93x_mixer(opti93x_t *chip)
 {
 	snd_card_t *card;
 	snd_kcontrol_new_t knew;
--- linux-2.6.10-rc2-mm3-full/include/sound/sb.h.old	2004-11-24 23:15:25.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/sound/sb.h	2004-11-24 23:15:48.000000000 +0100
@@ -311,10 +311,6 @@
 int snd_sb16dsp_configure(sb_t *chip);
 /* sb16.c */
 irqreturn_t snd_sb16dsp_interrupt(int irq, void *dev_id, struct pt_regs *regs);
-int snd_sb16_playback_open(snd_pcm_substream_t *substream);
-int snd_sb16_capture_open(snd_pcm_substream_t *substream);
-int snd_sb16_playback_close(snd_pcm_substream_t *substream);
-int snd_sb16_capture_close(snd_pcm_substream_t *substream);
 
 /* exported mixer stuffs */
 enum {
--- linux-2.6.10-rc2-mm3-full/sound/isa/sb/sb16_main.c.old	2004-11-24 23:15:56.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/isa/sb/sb16_main.c	2004-11-24 23:16:37.000000000 +0100
@@ -509,7 +509,7 @@
  *  open/close
  */
 
-int snd_sb16_playback_open(snd_pcm_substream_t * substream)
+static int snd_sb16_playback_open(snd_pcm_substream_t * substream)
 {
 	unsigned long flags;
 	sb_t *chip = snd_pcm_substream_chip(substream);
@@ -566,7 +566,7 @@
 	return 0;
 }
 
-int snd_sb16_playback_close(snd_pcm_substream_t * substream)
+static int snd_sb16_playback_close(snd_pcm_substream_t * substream)
 {
 	unsigned long flags;
 	sb_t *chip = snd_pcm_substream_chip(substream);
@@ -579,7 +579,7 @@
 	return 0;
 }
 
-int snd_sb16_capture_open(snd_pcm_substream_t * substream)
+static int snd_sb16_capture_open(snd_pcm_substream_t * substream)
 {
 	unsigned long flags;
 	sb_t *chip = snd_pcm_substream_chip(substream);
@@ -636,7 +636,7 @@
 	return 0;
 }
 
-int snd_sb16_capture_close(snd_pcm_substream_t * substream)
+static int snd_sb16_capture_close(snd_pcm_substream_t * substream)
 {
 	unsigned long flags;
 	sb_t *chip = snd_pcm_substream_chip(substream);
@@ -728,7 +728,7 @@
 	return change;
 }
 
-snd_kcontrol_new_t snd_sb16_dma_control = {
+static snd_kcontrol_new_t snd_sb16_dma_control = {
 	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 	.name = "16-bit DMA Allocation",
 	.info = snd_sb16_dma_control_info,
--- linux-2.6.10-rc2-mm3-full/sound/isa/sb/sb8_main.c.old	2004-11-24 23:16:59.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/isa/sb/sb8_main.c	2004-11-24 23:17:12.000000000 +0100
@@ -425,7 +425,7 @@
  *
  */
  
-int snd_sb8_open(snd_pcm_substream_t *substream)
+static int snd_sb8_open(snd_pcm_substream_t *substream)
 {
 	sb_t *chip = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
@@ -471,7 +471,7 @@
 	return 0;	
 }
 
-int snd_sb8_close(snd_pcm_substream_t *substream)
+static int snd_sb8_close(snd_pcm_substream_t *substream)
 {
 	unsigned long flags;
 	sb_t *chip = snd_pcm_substream_chip(substream);
--- linux-2.6.10-rc2-mm3-full/sound/isa/sb/sb_common.c.old	2004-11-24 23:17:26.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/isa/sb/sb_common.c	2004-11-24 23:17:37.000000000 +0100
@@ -92,7 +92,7 @@
 	return -ENODEV;
 }
 
-int snd_sbdsp_version(sb_t * chip)
+static int snd_sbdsp_version(sb_t * chip)
 {
 	unsigned int result = -ENODEV;
 
--- linux-2.6.10-rc2-mm3-full/include/sound/snd_wavefront.h.old	2004-11-24 23:29:28.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/sound/snd_wavefront.h	2004-11-24 23:29:43.000000000 +0100
@@ -107,7 +107,6 @@
 };
 
 extern void snd_wavefront_internal_interrupt (snd_wavefront_card_t *card);
-extern int  snd_wavefront_interrupt_bits (int irq);
 extern int  snd_wavefront_detect_irq (snd_wavefront_t *dev) ;
 extern int  snd_wavefront_check_irq (snd_wavefront_t *dev, int irq);
 extern int  snd_wavefront_restart (snd_wavefront_t *dev);
--- linux-2.6.10-rc2-mm3-full/sound/isa/wavefront/wavefront.c.old	2004-11-24 23:20:12.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/isa/wavefront/wavefront.c	2004-11-24 23:20:38.000000000 +0100
@@ -279,7 +279,7 @@
 	return IRQ_HANDLED;
 }
 
-snd_hwdep_t * __devinit
+static snd_hwdep_t * __devinit
 snd_wavefront_new_synth (snd_card_t *card,
 			 int hw_dev,
 			 snd_wavefront_card_t *acard)
@@ -305,7 +305,7 @@
 	return wavefront_synth;
 }
 
-snd_hwdep_t * __devinit
+static snd_hwdep_t * __devinit
 snd_wavefront_new_fx (snd_card_t *card,
 		      int hw_dev,
 		      snd_wavefront_card_t *acard,
@@ -332,7 +332,7 @@
 static snd_wavefront_mpu_id internal_id = internal_mpu;
 static snd_wavefront_mpu_id external_id = external_mpu;
 
-snd_rawmidi_t * __devinit
+static snd_rawmidi_t * __devinit
 snd_wavefront_new_midi (snd_card_t *card,
 			int midi_dev,
 			snd_wavefront_card_t *acard,
--- linux-2.6.10-rc2-mm3-full/sound/isa/wavefront/wavefront_fx.c.old	2004-11-24 23:22:35.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/isa/wavefront/wavefront_fx.c	2004-11-24 23:24:23.000000000 +0100
@@ -34,7 +34,7 @@
 
 /* weird stuff, derived from port I/O tracing with dosemu */
 
-unsigned char page_zero[] __initdata = {
+static unsigned char page_zero[] __initdata = {
 0x01, 0x7c, 0x00, 0x1e, 0x00, 0x00, 0x00, 0x00, 0x00, 0xf5, 0x00,
 0x11, 0x00, 0x20, 0x00, 0x32, 0x00, 0x40, 0x00, 0x13, 0x00, 0x00,
 0x00, 0x14, 0x02, 0x76, 0x00, 0x60, 0x00, 0x80, 0x02, 0x00, 0x00,
@@ -61,7 +61,7 @@
 0x1d, 0x02, 0xdf
 };
 
-unsigned char page_one[] __initdata = {
+static unsigned char page_one[] __initdata = {
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x19, 0x00,
 0x1f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0xd8, 0x00, 0x00,
 0x02, 0x20, 0x00, 0x19, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x01,
@@ -88,7 +88,7 @@
 0x60, 0x00, 0x1b
 };
 
-unsigned char page_two[] __initdata = {
+static unsigned char page_two[] __initdata = {
 0xc4, 0x00, 0x44, 0x07, 0x44, 0x00, 0x40, 0x25, 0x01, 0x06, 0xc4,
 0x07, 0x40, 0x25, 0x01, 0x00, 0x46, 0x46, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -103,7 +103,7 @@
 0x46, 0x05, 0x46, 0x07, 0x46, 0x07, 0x44
 };
 
-unsigned char page_three[] __initdata = {
+static unsigned char page_three[] __initdata = {
 0x07, 0x40, 0x00, 0x00, 0x00, 0x47, 0x00, 0x40, 0x00, 0x40, 0x06,
 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -118,7 +118,7 @@
 0x02, 0x00, 0x42, 0x00, 0xc0, 0x00, 0x40
 };
 
-unsigned char page_four[] __initdata = {
+static unsigned char page_four[] __initdata = {
 0x63, 0x03, 0x26, 0x02, 0x2c, 0x00, 0x24, 0x00, 0x2e, 0x02, 0x02,
 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -133,7 +133,7 @@
 0x02, 0x62, 0x02, 0x20, 0x01, 0x21, 0x01
 };
 
-unsigned char page_six[] __initdata = {
+static unsigned char page_six[] __initdata = {
 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x04, 0x00, 0x00, 0x06, 0x00,
 0x00, 0x08, 0x00, 0x00, 0x0a, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x0e,
 0x00, 0x00, 0x10, 0x00, 0x00, 0x12, 0x00, 0x00, 0x14, 0x00, 0x00,
@@ -154,7 +154,7 @@
 0x80, 0x00, 0x7e, 0x80, 0x80
 };
 
-unsigned char page_seven[] __initdata = {
+static unsigned char page_seven[] __initdata = {
 0x0f, 0xff, 0x00, 0x00, 0x08, 0x00, 0x08, 0x00, 0x02, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x0f, 0xff, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00,
 0x08, 0x00, 0x00, 0x00, 0x0f, 0xff, 0x00, 0x00, 0x00, 0x00, 0x0f,
@@ -181,7 +181,7 @@
 0x00, 0x02, 0x00
 };
 
-unsigned char page_zero_v2[] __initdata = {
+static unsigned char page_zero_v2[] __initdata = {
 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -193,7 +193,7 @@
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
 };
 
-unsigned char page_one_v2[] __initdata = {
+static unsigned char page_one_v2[] __initdata = {
 0x01, 0xc0, 0x01, 0xfa, 0x00, 0x1a, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -205,21 +205,23 @@
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
 };
 
-unsigned char page_two_v2[] __initdata = {
+static unsigned char page_two_v2[] __initdata = {
 0x46, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00
 };
-unsigned char page_three_v2[] __initdata = {
+
+static unsigned char page_three_v2[] __initdata = {
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00
 };
-unsigned char page_four_v2[] __initdata = {
+
+static unsigned char page_four_v2[] __initdata = {
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -227,7 +229,7 @@
 0x00, 0x00, 0x00, 0x00
 };
 
-unsigned char page_seven_v2[] __initdata = {
+static unsigned char page_seven_v2[] __initdata = {
 0x0f, 0xff, 0x0f, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -239,7 +241,7 @@
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
 };
 
-unsigned char mod_v2[] __initdata = {
+static unsigned char mod_v2[] __initdata = {
 0x01, 0x00, 0x02, 0x00, 0x01, 0x01, 0x02, 0x00, 0x01, 0x02, 0x02,
 0x00, 0x01, 0x03, 0x02, 0x00, 0x01, 0x04, 0x02, 0x00, 0x01, 0x05,
 0x02, 0x00, 0x01, 0x06, 0x02, 0x00, 0x01, 0x07, 0x02, 0x00, 0xb0,
@@ -269,7 +271,8 @@
 0x02, 0x01, 0x01, 0x04, 0x02, 0x01, 0x01, 0x05, 0x02, 0x01, 0x01,
 0x06, 0x02, 0x01, 0x01, 0x07, 0x02, 0x01
 };
-unsigned char coefficients[] __initdata = {
+
+static unsigned char coefficients[] __initdata = {
 0x07, 0x46, 0x00, 0x00, 0x07, 0x49, 0x00, 0x00, 0x00, 0x4b, 0x03,
 0x11, 0x00, 0x4d, 0x01, 0x32, 0x07, 0x46, 0x00, 0x00, 0x07, 0x49,
 0x00, 0x00, 0x07, 0x40, 0x00, 0x00, 0x07, 0x41, 0x00, 0x00, 0x01,
@@ -305,14 +308,16 @@
 0x06, 0x6c, 0x4c, 0x6c, 0x06, 0x50, 0x52, 0xe2, 0x06, 0x42, 0x02,
 0xba
 };
-unsigned char coefficients2[] __initdata = {
+
+static unsigned char coefficients2[] __initdata = {
 0x07, 0x46, 0x00, 0x00, 0x07, 0x49, 0x00, 0x00, 0x07, 0x45, 0x0f,
 0xff, 0x07, 0x48, 0x0f, 0xff, 0x07, 0x7b, 0x04, 0xcc, 0x07, 0x7d,
 0x04, 0xcc, 0x07, 0x7c, 0x00, 0x00, 0x07, 0x7e, 0x00, 0x00, 0x07,
 0x46, 0x00, 0x00, 0x07, 0x49, 0x00, 0x00, 0x07, 0x47, 0x00, 0x00,
 0x07, 0x4a, 0x00, 0x00, 0x07, 0x4c, 0x00, 0x00, 0x07, 0x4e, 0x00, 0x00
 };
-unsigned char coefficients3[] __initdata = {
+
+static unsigned char coefficients3[] __initdata = {
 0x00, 0x00, 0x00, 0x00, 0x00, 0x28, 0x00, 0x28, 0x00, 0x51, 0x00,
 0x51, 0x00, 0x7a, 0x00, 0x7a, 0x00, 0xa3, 0x00, 0xa3, 0x00, 0xcc,
 0x00, 0xcc, 0x00, 0xf5, 0x00, 0xf5, 0x01, 0x1e, 0x01, 0x1e, 0x01,
--- linux-2.6.10-rc2-mm3-full/sound/isa/wavefront/wavefront_synth.c.old	2004-11-24 23:25:41.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/isa/wavefront/wavefront_synth.c	2004-11-24 23:29:24.000000000 +0100
@@ -32,58 +32,58 @@
 #include <sound/snd_wavefront.h>
 #include <sound/initval.h>
 
-int wf_raw = 0; /* we normally check for "raw state" to firmware
-		   loading. if non-zero, then during driver loading, the
-		   state of the board is ignored, and we reset the
-		   board and load the firmware anyway.
-		*/
+static int wf_raw = 0; /* we normally check for "raw state" to firmware
+			  loading. if non-zero, then during driver loading, the
+			  state of the board is ignored, and we reset the
+			  board and load the firmware anyway.
+		       */
 		   
-int fx_raw = 1; /* if this is zero, we'll leave the FX processor in
-		   whatever state it is when the driver is loaded.
-		   The default is to download the microprogram and
-		   associated coefficients to set it up for "default"
-		   operation, whatever that means.
-		*/
-
-int debug_default = 0;  /* you can set this to control debugging
-			      during driver loading. it takes any combination
-			      of the WF_DEBUG_* flags defined in
-			      wavefront.h
-			   */
+static int fx_raw = 1; /* if this is zero, we'll leave the FX processor in
+			  whatever state it is when the driver is loaded.
+			  The default is to download the microprogram and
+			  associated coefficients to set it up for "default"
+			  operation, whatever that means.
+		       */
+
+static int debug_default = 0;  /* you can set this to control debugging
+				  during driver loading. it takes any combination
+				  of the WF_DEBUG_* flags defined in
+				  wavefront.h
+			       */
 
 /* XXX this needs to be made firmware and hardware version dependent */
 
-char *ospath = "/etc/sound/wavefront.os"; /* where to find a processed
-					     version of the WaveFront OS
-					  */
-
-int wait_usecs = 150; /* This magic number seems to give pretty optimal
-			 throughput based on my limited experimentation.
-			 If you want to play around with it and find a better
-			 value, be my guest. Remember, the idea is to
-			 get a number that causes us to just busy wait
-			 for as many WaveFront commands as possible, without
-			 coming up with a number so large that we hog the
-			 whole CPU.
-
-			 Specifically, with this number, out of about 134,000
-			 status waits, only about 250 result in a sleep.
-		      */
-
-int sleep_interval = 100;   /* HZ/sleep_interval seconds per sleep */
-int sleep_tries = 50;       /* number of times we'll try to sleep */
-
-int reset_time = 2;        /* hundreths of a second we wait after a HW
-			      reset for the expected interrupt.
-			   */
-
-int ramcheck_time = 20;    /* time in seconds to wait while ROM code
-			      checks on-board RAM.
-			   */
-
-int osrun_time = 10;       /* time in seconds we wait for the OS to
-			      start running.
-			   */
+static char *ospath = "/etc/sound/wavefront.os"; /* where to find a processed
+						    version of the WaveFront OS
+						 */
+
+static int wait_usecs = 150; /* This magic number seems to give pretty optimal
+				throughput based on my limited experimentation.
+				If you want to play around with it and find a better
+				value, be my guest. Remember, the idea is to
+				get a number that causes us to just busy wait
+				for as many WaveFront commands as possible, without
+				coming up with a number so large that we hog the
+				whole CPU.
+
+				Specifically, with this number, out of about 134,000
+				status waits, only about 250 result in a sleep.
+			    */
+
+static int sleep_interval = 100;   /* HZ/sleep_interval seconds per sleep */
+static int sleep_tries = 50;       /* number of times we'll try to sleep */
+
+static int reset_time = 2;        /* hundreths of a second we wait after a HW
+				     reset for the expected interrupt.
+				  */
+
+static int ramcheck_time = 20;    /* time in seconds to wait while ROM code
+				     checks on-board RAM.
+				  */
+
+static int osrun_time = 10;       /* time in seconds we wait for the OS to
+				     start running.
+				  */
 module_param(wf_raw, int, 0444);
 MODULE_PARM_DESC(wf_raw, "if non-zero, assume that we need to boot the OS");
 module_param(fx_raw, int, 0444);
@@ -1709,7 +1709,7 @@
 7 Unused
 */
 
-int __init
+static int __init
 snd_wavefront_interrupt_bits (int irq)
 
 {

