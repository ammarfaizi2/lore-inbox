Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261729AbSI2Suz>; Sun, 29 Sep 2002 14:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261731AbSI2SuG>; Sun, 29 Sep 2002 14:50:06 -0400
Received: from gate.perex.cz ([194.212.165.105]:14096 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261737AbSI2Ss2>;
	Sun, 29 Sep 2002 14:48:28 -0400
Date: Sun, 29 Sep 2002 20:53:10 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update [8/10] - 2002/07/31
Message-ID: <Pine.LNX.4.33.0209292052261.591-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.605.2.19, 2002-09-26 11:55:55+02:00, perex@pnote.perex-int.cz
  ALSA 2002/07/31 update :
    - AC'97 codec
      - added reset callback to do reset and skip the standard procedure
      - added limited_regs flag to avoid to touch unexpected registers
      - Fixes for AD1981A and added a special patch for an intel motherboard
    - sequencer
      - check the possible infinite loop in priority queues
      - reset the timer at continue if not initialized yet
    - changed synchronize_irq() for new api with an argument
    - NM256 driver - fixes the lock up on NM256 ZX
    - VIA8233 - implementation of SG buffer


 include/sound/ac97_codec.h    |    2 
 include/sound/version.h       |    2 
 sound/core/seq/seq_prioq.c    |   22 ++--
 sound/core/seq/seq_prioq.h    |    2 
 sound/core/seq/seq_timer.c    |    4 
 sound/isa/dt019x.c            |    2 
 sound/pci/ac97/ac97_codec.c   |   39 +++++--
 sound/pci/ac97/ac97_patch.c   |   14 ++
 sound/pci/ac97/ac97_patch.h   |    1 
 sound/pci/ali5451/ali5451.c   |    5 
 sound/pci/cs4281.c            |    2 
 sound/pci/emu10k1/emumpu401.c |    4 
 sound/pci/emu10k1/emupcm.c    |    6 +
 sound/pci/ens1370.c           |    3 
 sound/pci/ice1712.c           |    4 
 sound/pci/intel8x0.c          |    3 
 sound/pci/maestro3.c          |    2 
 sound/pci/nm256/nm256.c       |   32 ++++--
 sound/pci/via686.c            |   21 ++--
 sound/pci/via8233.c           |  220 +++++++++++++++++++++++++++---------------
 20 files changed, 260 insertions(+), 130 deletions(-)


diff -Nru a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
--- a/include/sound/ac97_codec.h	Sun Sep 29 20:23:22 2002
+++ b/include/sound/ac97_codec.h	Sun Sep 29 20:23:22 2002
@@ -152,6 +152,7 @@
 typedef struct _snd_ac97 ac97_t;
 
 struct _snd_ac97 {
+	void (*reset) (ac97_t *ac97);
 	void (*write) (ac97_t *ac97, unsigned short reg, unsigned short val);
 	unsigned short (*read) (ac97_t *ac97, unsigned short reg);
 	void (*wait) (ac97_t *ac97);
@@ -178,6 +179,7 @@
 	unsigned int rates_mic_adc;
 	unsigned int spdif_status;
 	unsigned short regs[0x80]; /* register cache */
+	unsigned int limited_regs; /* allow limited registers only */
 	bitmap_member(reg_accessed,0x80); /* bit flags */
 	union {			/* vendor specific code */
 		struct {
diff -Nru a/include/sound/version.h b/include/sound/version.h
--- a/include/sound/version.h	Sun Sep 29 20:23:22 2002
+++ b/include/sound/version.h	Sun Sep 29 20:23:22 2002
@@ -1,3 +1,3 @@
 /* include/version.h.  Generated automatically by configure.  */
 #define CONFIG_SND_VERSION "0.9.0rc2"
-#define CONFIG_SND_DATE " (Wed Jul 24 10:42:45 2002 UTC)"
+#define CONFIG_SND_DATE " (Wed Jul 31 15:28:28 2002 UTC)"
diff -Nru a/sound/core/seq/seq_prioq.c b/sound/core/seq/seq_prioq.c
--- a/sound/core/seq/seq_prioq.c	Sun Sep 29 20:23:22 2002
+++ b/sound/core/seq/seq_prioq.c	Sun Sep 29 20:23:22 2002
@@ -146,20 +146,15 @@
 }
 
 /* enqueue cell to prioq */
-void snd_seq_prioq_cell_in(prioq_t * f, snd_seq_event_cell_t * cell)
+int snd_seq_prioq_cell_in(prioq_t * f, snd_seq_event_cell_t * cell)
 {
 	snd_seq_event_cell_t *cur, *prev;
 	unsigned long flags;
+	int count;
 	int prior;
 
-	if (f == NULL) {
-		snd_printd("oops: snd_seq_prioq_cell_in() called with NULL prioq\n");
-		return;
-	}
-	if (cell == NULL) {
-		snd_printd("oops: snd_seq_prioq_cell_in() called with NULL cell\n");
-		return;
-	}
+	snd_assert(f, return -EINVAL);
+	snd_assert(cell, return -EINVAL);
 	
 	/* check flags */
 	prior = (cell->event.flags & SNDRV_SEQ_PRIORITY_MASK);
@@ -177,7 +172,7 @@
 			cell->next = NULL;
 			f->cells++;
 			spin_unlock_irqrestore(&f->lock, flags);
-			return;
+			return 0;
 		}
 	}
 	/* traverse list of elements to find the place where the new cell is
@@ -186,6 +181,7 @@
 	prev = NULL;		/* previous cell */
 	cur = f->head;		/* cursor */
 
+	count = 10000; /* FIXME: enough big, isn't it? */
 	while (cur != NULL) {
 		/* compare timestamps */
 		int rel = compare_timestamp_rel(&cell->event, &cur->event);
@@ -199,6 +195,11 @@
 		/* move cursor to next cell */
 		prev = cur;
 		cur = cur->next;
+		if (! --count) {
+			spin_unlock_irqrestore(&f->lock, flags);
+			snd_printk(KERN_ERR "cannot find a pointer.. infinite loop?\n");
+			return -EINVAL;
+		}
 	}
 
 	/* insert it before cursor */
@@ -212,6 +213,7 @@
 		f->tail = cell;
 	f->cells++;
 	spin_unlock_irqrestore(&f->lock, flags);
+	return 0;
 }
 
 /* dequeue cell from prioq */
diff -Nru a/sound/core/seq/seq_prioq.h b/sound/core/seq/seq_prioq.h
--- a/sound/core/seq/seq_prioq.h	Sun Sep 29 20:23:22 2002
+++ b/sound/core/seq/seq_prioq.h	Sun Sep 29 20:23:22 2002
@@ -41,7 +41,7 @@
 extern void snd_seq_prioq_delete(prioq_t **fifo);
 
 /* enqueue cell to prioq */
-extern void snd_seq_prioq_cell_in(prioq_t *f, snd_seq_event_cell_t *cell);
+extern int snd_seq_prioq_cell_in(prioq_t *f, snd_seq_event_cell_t *cell);
 
 /* dequeue cell from prioq */ 
 extern snd_seq_event_cell_t *snd_seq_prioq_cell_out(prioq_t *f);
diff -Nru a/sound/core/seq/seq_timer.c b/sound/core/seq/seq_timer.c
--- a/sound/core/seq/seq_timer.c	Sun Sep 29 20:23:22 2002
+++ b/sound/core/seq/seq_timer.c	Sun Sep 29 20:23:22 2002
@@ -365,9 +365,11 @@
 		return;
 	if (tmr->running)
 		return;
-	if (! tmr->initialized)
+	if (! tmr->initialized) {
+		snd_seq_timer_reset(tmr);
 		if (initialize_timer(tmr) < 0)
 			return;
+	}
 	snd_timer_start(tmr->timeri, tmr->ticks);
 	tmr->running = 1;
 	do_gettimeofday(&tmr->last_update);
diff -Nru a/sound/isa/dt019x.c b/sound/isa/dt019x.c
--- a/sound/isa/dt019x.c	Sun Sep 29 20:23:22 2002
+++ b/sound/isa/dt019x.c	Sun Sep 29 20:23:22 2002
@@ -168,7 +168,7 @@
 	snd_dma8[dev] = pdev->dma_resource[0].start;
 	snd_irq[dev] = pdev->irq_resource[0].start;
 	snd_printdd("dt019x: found audio interface: port=0x%lx, irq=0x%lx, dma=0x%lx\n",
-			snd_port[dev],snd_irq[dev],smd_dma8[dev]);
+			snd_port[dev],snd_irq[dev],snd_dma8[dev]);
 
 	pdev = acard->devmpu;
 	if (!pdev || pdev->prepare(pdev)<0) 
diff -Nru a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
--- a/sound/pci/ac97/ac97_codec.c	Sun Sep 29 20:23:22 2002
+++ b/sound/pci/ac97/ac97_codec.c	Sun Sep 29 20:23:22 2002
@@ -91,10 +91,10 @@
 { 0x41445303, 0xffffffff, "AD1819",		patch_ad1819 },
 { 0x41445340, 0xffffffff, "AD1881",		patch_ad1881 },
 { 0x41445348, 0xffffffff, "AD1881A",		patch_ad1881 },
-{ 0x41445360, 0xffffffff, "AD1885",		patch_ad1881 },
+{ 0x41445360, 0xffffffff, "AD1885",		patch_ad1885 },
 { 0x41445361, 0xffffffff, "AD1886",		patch_ad1886 },
 { 0x41445362, 0xffffffff, "AD1887",		patch_ad1881 },
-{ 0x41445372, 0xffffffff, "AD1981A",		NULL },
+{ 0x41445372, 0xffffffff, "AD1981A",		patch_ad1881 },
 { 0x414c4300, 0xfffffff0, "RL5306",	 	NULL },
 { 0x414c4310, 0xfffffff0, "RL5382", 		NULL },
 { 0x414c4320, 0xfffffff0, "RL5383", 		NULL },
@@ -240,12 +240,11 @@
 	set_bit(reg, ac97->reg_accessed);
 }
 
-#ifndef CONFIG_SND_DEBUG
-#define snd_ac97_write_cache_test snd_ac97_write_cache
-#else
 static void snd_ac97_write_cache_test(ac97_t *ac97, unsigned short reg, unsigned short value)
 {
-	return snd_ac97_write_cache(ac97, reg, value);
+	if (ac97->limited_regs && ! test_bit(reg, ac97->reg_accessed))
+  		return;
+#if 0
 	if (!snd_ac97_valid_reg(ac97, reg))
 		return;
 	spin_lock(&ac97->reg_lock);
@@ -254,8 +253,9 @@
 	if (value != ac97->regs[reg])
 		snd_printk("AC97 reg=%02x val=%04x real=%04x\n", reg, value, ac97->regs[reg]);
 	spin_unlock(&ac97->reg_lock);
-}
 #endif
+	snd_ac97_write_cache(ac97, reg, value);
+}
 
 int snd_ac97_update(ac97_t *ac97, unsigned short reg, unsigned short value)
 {
@@ -911,6 +911,9 @@
 {
 	unsigned short val, mask = 0x8000;
 
+	if (ac97->limited_regs && ! test_bit(reg, ac97->reg_accessed))
+		return 0;
+
 	switch (reg) {
 	case AC97_MASTER_TONE:
 		return ac97->caps & 0x04 ? 1 : 0;
@@ -1461,6 +1464,12 @@
 	*ac97 = *_ac97;
 	ac97->card = card;
 	spin_lock_init(&ac97->reg_lock);
+
+	if (ac97->reset) {
+		ac97->reset(ac97);
+		goto __access_ok;
+	}
+
 	snd_ac97_write(ac97, AC97_RESET, 0);	/* reset to defaults */
 	if (ac97->wait)
 		ac97->wait(ac97);
@@ -1499,6 +1508,10 @@
 		snd_ac97_free(ac97);
 		return -EIO;
 	}
+
+	if (ac97->reset) // FIXME: always skipping?
+		goto __ready_ok;
+
 	/* FIXME: add powerdown control */
 	/* nothing should be in powerdown mode */
 	snd_ac97_write_cache_test(ac97, AC97_POWERDOWN, 0);
@@ -1540,6 +1553,7 @@
 		snd_ac97_determine_rates(ac97, AC97_PCM_LFE_DAC_RATE, &ac97->rates_lfe_dac);
 		ac97->scaps |= AC97_SCAP_CENTER_LFE_DAC;
 	}
+	/* additional initializations */
 	if (ac97->init)
 		ac97->init(ac97);
 	snd_ac97_get_name(ac97, ac97->id, name);
@@ -1738,7 +1752,10 @@
 	int reg, val;
 
 	for (reg = 0; reg < 0x80; reg += 2) {
-		val = snd_ac97_read(ac97, reg);
+		if (ac97->limited_regs && ! test_bit(reg, ac97->reg_accessed))
+			val = 0xffff;
+		else
+			val = snd_ac97_read(ac97, reg);
 		snd_iprintf(buffer, "%i:%02x = %04x\n", subidx, reg, val);
 	}
 }
@@ -1903,6 +1920,11 @@
 {
 	int i;
 
+	if (ac97->reset) {
+		ac97->reset(ac97);
+		goto  __reset_ready;
+	}
+
 	snd_ac97_write(ac97, AC97_POWERDOWN, 0);
 	snd_ac97_write(ac97, AC97_RESET, 0);
 	udelay(100);
@@ -1916,6 +1938,7 @@
 			break;
 		mdelay(1);
 	}
+__reset_ready:
 
 	if (ac97->init)
 		ac97->init(ac97);
diff -Nru a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
--- a/sound/pci/ac97/ac97_patch.c	Sun Sep 29 20:23:22 2002
+++ b/sound/pci/ac97/ac97_patch.c	Sun Sep 29 20:23:22 2002
@@ -300,6 +300,20 @@
 	return 0;
 }
 
+int patch_ad1885(ac97_t * ac97)
+{
+	unsigned short jack;
+
+	patch_ad1881(ac97);
+	/* This is required to deal with the Intel D815EEAL2 */
+	/* i.e. Line out is actually headphone out from codec */
+
+	/* turn off jack sense bits D8 & D9 */
+	jack = snd_ac97_read(ac97, AC97_AD_JACK_SPDIF);
+	snd_ac97_write_cache(ac97, AC97_AD_JACK_SPDIF, jack | 0x0300);
+	return 0;
+}
+
 int patch_ad1886(ac97_t * ac97)
 {
 	patch_ad1881(ac97);
diff -Nru a/sound/pci/ac97/ac97_patch.h b/sound/pci/ac97/ac97_patch.h
--- a/sound/pci/ac97/ac97_patch.h	Sun Sep 29 20:23:22 2002
+++ b/sound/pci/ac97/ac97_patch.h	Sun Sep 29 20:23:22 2002
@@ -35,4 +35,5 @@
 int patch_conexant(ac97_t * ac97);
 int patch_ad1819(ac97_t * ac97);
 int patch_ad1881(ac97_t * ac97);
+int patch_ad1885(ac97_t * ac97);
 int patch_ad1886(ac97_t * ac97);
diff -Nru a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
--- a/sound/pci/ali5451/ali5451.c	Sun Sep 29 20:23:22 2002
+++ b/sound/pci/ali5451/ali5451.c	Sun Sep 29 20:23:22 2002
@@ -1970,9 +1970,10 @@
 static int snd_ali_free(ali_t * codec)
 {
 	snd_ali_disable_address_interrupt(codec);
-	synchronize_irq(codec->irq);
-	if (codec->irq >=0)
+	if (codec->irq >= 0) {
+		synchronize_irq(codec->irq);
 		free_irq(codec->irq, (void *)codec);
+	}
 	if (codec->res_port) {
 		release_resource(codec->res_port);
 		kfree_nocheck(codec->res_port);
diff -Nru a/sound/pci/cs4281.c b/sound/pci/cs4281.c
--- a/sound/pci/cs4281.c	Sun Sep 29 20:23:22 2002
+++ b/sound/pci/cs4281.c	Sun Sep 29 20:23:22 2002
@@ -1300,7 +1300,7 @@
 	}
 #endif
 	snd_cs4281_proc_done(chip);
-	if(chip->irq >= 0)
+	if (chip->irq >= 0)
 		synchronize_irq(chip->irq);
 
 	/* Mask interrupts */
diff -Nru a/sound/pci/emu10k1/emumpu401.c b/sound/pci/emu10k1/emumpu401.c
--- a/sound/pci/emu10k1/emumpu401.c	Sun Sep 29 20:23:22 2002
+++ b/sound/pci/emu10k1/emumpu401.c	Sun Sep 29 20:23:22 2002
@@ -64,7 +64,7 @@
 		mpu401_read_data(emu, mpu);
 #ifdef CONFIG_SND_DEBUG
 	if (timeout <= 0)
-		snd_printk("cmd: clear rx timeout (status = 0x%x)\n", mpu401_read_stat(emu, mpu));
+		snd_printk(KERN_ERR "cmd: clear rx timeout (status = 0x%x)\n", mpu401_read_stat(emu, mpu));
 #endif
 }
 
@@ -143,7 +143,7 @@
 	}
 	spin_unlock_irqrestore(&midi->input_lock, flags);
 	if (!ok)
-		snd_printk("midi_cmd: 0x%x failed at 0x%lx (status = 0x%x, data = 0x%x)!!!\n",
+		snd_printk(KERN_ERR "midi_cmd: 0x%x failed at 0x%lx (status = 0x%x, data = 0x%x)!!!\n",
 			   cmd, emu->port,
 			   mpu401_read_stat(emu, midi),
 			   mpu401_read_data(emu, midi));
diff -Nru a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
--- a/sound/pci/emu10k1/emupcm.c	Sun Sep 29 20:23:22 2002
+++ b/sound/pci/emu10k1/emupcm.c	Sun Sep 29 20:23:22 2002
@@ -968,11 +968,13 @@
 {
 	emu10k1_t *emu = snd_magic_cast(emu10k1_t, pcm->private_data, return);
 	emu->pcm = NULL;
+	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
 
 int __devinit snd_emu10k1_pcm(emu10k1_t * emu, int device, snd_pcm_t ** rpcm)
 {
 	snd_pcm_t *pcm;
+	snd_pcm_substream_t *substream;
 	int err;
 
 	if (rpcm)
@@ -991,6 +993,10 @@
 	pcm->dev_subclass = SNDRV_PCM_SUBCLASS_GENERIC_MIX;
 	strcpy(pcm->name, "EMU10K1");
 	emu->pcm = pcm;
+
+	for (substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream; substream; substream = substream->next)
+		snd_pcm_lib_preallocate_pci_pages(emu->pci, substream, 64*1024, 64*1024);
+			return err;
 
 	if (rpcm)
 		*rpcm = pcm;
diff -Nru a/sound/pci/ens1370.c b/sound/pci/ens1370.c
--- a/sound/pci/ens1370.c	Sun Sep 29 20:23:22 2002
+++ b/sound/pci/ens1370.c	Sun Sep 29 20:23:22 2002
@@ -1532,8 +1532,7 @@
 	outl(0, ES_REG(ensoniq, CONTROL));	/* switch everything off */
 	outl(0, ES_REG(ensoniq, SERIAL));	/* clear serial interface */
 #endif
-	if(ensoniq->irq >= 0)
-		synchronize_irq(ensoniq->irq);
+	synchronize_irq(ensoniq->irq);
 	pci_set_power_state(ensoniq->pci, 3);
       __hw_end:
 #ifdef CHIP1370
diff -Nru a/sound/pci/ice1712.c b/sound/pci/ice1712.c
--- a/sound/pci/ice1712.c	Sun Sep 29 20:23:22 2002
+++ b/sound/pci/ice1712.c	Sun Sep 29 20:23:22 2002
@@ -4072,7 +4072,7 @@
 	/* --- */
       __hw_end:
 	snd_ice1712_proc_done(ice);
-	if (ice->irq) {
+	if (ice->irq >= 0) {
 		synchronize_irq(ice->irq);
 		free_irq(ice->irq, (void *) ice);
 	}
@@ -4146,7 +4146,7 @@
 	pci_write_config_word(ice->pci, 0x40, 0x807f);
 	pci_write_config_word(ice->pci, 0x42, 0x0006);
 	snd_ice1712_proc_init(ice);
-	synchronize_irq(ice->irq);
+	synchronize_irq(pci->irq);
 
 	if ((ice->res_port = request_region(ice->port, 32, "ICE1712 - Controller")) == NULL) {
 		snd_ice1712_free(ice);
diff -Nru a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
--- a/sound/pci/intel8x0.c	Sun Sep 29 20:23:22 2002
+++ b/sound/pci/intel8x0.c	Sun Sep 29 20:23:22 2002
@@ -1104,8 +1104,7 @@
 	outb(ICH_RESETREGS, ICHREG(chip, PO_CR));
 	outb(ICH_RESETREGS, ICHREG(chip, MC_CR));
 	/* --- */
-	if(chip->irq >= 0)
-		synchronize_irq(chip->irq);
+	synchronize_irq(chip->irq);
       __hw_end:
 	if (chip->bdbars)
 		snd_free_pci_pages(chip->pci, 3 * sizeof(u32) * ICH_MAX_FRAGS * 2, chip->bdbars, chip->bdbars_addr);
diff -Nru a/sound/pci/maestro3.c b/sound/pci/maestro3.c
--- a/sound/pci/maestro3.c	Sun Sep 29 20:23:22 2002
+++ b/sound/pci/maestro3.c	Sun Sep 29 20:23:22 2002
@@ -2310,7 +2310,7 @@
 		vfree(chip->suspend_mem);
 #endif
 
-	if(chip->irq >= 0)
+	if (chip->irq >= 0)
 		synchronize_irq(chip->irq);
 
 	if (chip->iobase_res) {
diff -Nru a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
--- a/sound/pci/nm256/nm256.c	Sun Sep 29 20:23:22 2002
+++ b/sound/pci/nm256/nm256.c	Sun Sep 29 20:23:22 2002
@@ -892,7 +892,7 @@
 #endif
 };
 
-static int __init
+static int __devinit
 snd_nm256_pcm(nm256_t *chip, int device)
 {
 	snd_pcm_t *pcm;
@@ -1188,21 +1188,31 @@
 }
 
 /* create an ac97 mixer interface */
-static int __init
+static int __devinit
 snd_nm256_mixer(nm256_t *chip)
 {
 	ac97_t ac97;
-	int err;
+	int i;
+	/* looks like nm256 hangs up when unexpected registers are touched... */
+	static int mixer_regs[] = {
+		AC97_MASTER, AC97_HEADPHONE, AC97_MASTER_MONO,
+		AC97_PC_BEEP, AC97_PHONE, AC97_MIC, AC97_LINE,
+		AC97_VIDEO, AC97_AUX, AC97_PCM, AC97_REC_SEL,
+		AC97_REC_GAIN, AC97_GENERAL_PURPOSE, AC97_3D_CONTROL,
+		AC97_EXTENDED_ID, AC97_EXTENDED_STATUS,
+		AC97_VENDOR_ID1, AC97_VENDOR_ID2,
+		-1
+	};
 
 	memset(&ac97, 0, sizeof(ac97));
-	ac97.init = snd_nm256_ac97_reset;
+	ac97.reset = snd_nm256_ac97_reset;
 	ac97.write = snd_nm256_ac97_write;
 	ac97.read = snd_nm256_ac97_read;
+	ac97.limited_regs = 1;
+	for (i = 0; mixer_regs[i] >= 0; i++)
+		set_bit(mixer_regs[i], ac97.reg_accessed);
 	ac97.private_data = chip;
-	if ((err = snd_ac97_mixer(chip->card, &ac97, &chip->ac97)) < 0)
-		return err;
-
-	return 0;
+	return snd_ac97_mixer(chip->card, &ac97, &chip->ac97);
 }
 
 /* 
@@ -1211,7 +1221,7 @@
  * RAM.
  */
 
-static int __init
+static int __devinit
 snd_nm256_peek_for_sig(nm256_t *chip)
 {
 	/* The signature is located 1K below the end of video RAM.  */
@@ -1346,7 +1356,7 @@
 	if (chip->streams[SNDRV_PCM_STREAM_CAPTURE].running)
 		snd_nm256_capture_stop(chip);
 
-	if(chip->irq >= 0)
+	if (chip->irq >= 0)
 		synchronize_irq(chip->irq);
 
 	if (chip->cport)
@@ -1374,7 +1384,7 @@
 	return snd_nm256_free(chip);
 }
 
-static int __init
+static int __devinit
 snd_nm256_create(snd_card_t *card, struct pci_dev *pci,
 		 int play_bufsize, int capt_bufsize,
 		 int force_load,
diff -Nru a/sound/pci/via686.c b/sound/pci/via686.c
--- a/sound/pci/via686.c	Sun Sep 29 20:23:22 2002
+++ b/sound/pci/via686.c	Sun Sep 29 20:23:22 2002
@@ -238,7 +238,7 @@
 	snd_card_t *card;
 
 	snd_pcm_t *pcm;
-	snd_pcm_t *pcm_fm;
+	/*snd_pcm_t *pcm_fm;*/
 	viadev_t playback;
 	viadev_t capture;
 	/*viadev_t playback_fm;*/
@@ -564,8 +564,13 @@
 		val = 0;
 	else
 		val = ((ptr - (unsigned int)viadev->table_addr) / 8 - 1) % viadev->tbl_entries;
-	val *= viadev->tbl_size;
-	val += viadev->tbl_size - count;
+	if (val < viadev->tbl_entries - 1) {
+		val *= viadev->tbl_size;
+		val += viadev->tbl_size - count;
+	} else {
+		val *= viadev->tbl_size;
+		val += (viadev->size % viadev->tbl_size) + 1 - count;
+	}
 	viadev->lastptr = ptr;
 	viadev->lastcount = count;
 	// printk("pointer: ptr = 0x%x (%i), count = 0x%x, val = 0x%x\n", ptr, count, val);
@@ -632,10 +637,10 @@
 	chip->playback.substream = substream;
 	runtime->hw = snd_via686a_playback;
 	runtime->hw.rates = chip->ac97->rates_front_dac;
-	if ((err = snd_pcm_sgbuf_init(substream, chip->pci, 32)) < 0)
-		return err;
 	if (!(runtime->hw.rates & SNDRV_PCM_RATE_8000))
 		runtime->hw.rate_min = 48000;
+	if ((err = snd_pcm_sgbuf_init(substream, chip->pci, 32)) < 0)
+		return err;
 	if ((err = snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES)) < 0)
 		return err;
 #if 0
@@ -658,10 +663,10 @@
 	chip->capture.substream = substream;
 	runtime->hw = snd_via686a_capture;
 	runtime->hw.rates = chip->ac97->rates_adc;
-	if ((err = snd_pcm_sgbuf_init(substream, chip->pci, 32)) < 0)
-		return err;
 	if (!(runtime->hw.rates & SNDRV_PCM_RATE_8000))
 		runtime->hw.rate_min = 48000;
+	if ((err = snd_pcm_sgbuf_init(substream, chip->pci, 32)) < 0)
+		return err;
 	if ((err = snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES)) < 0)
 		return err;
 #if 0
@@ -1020,7 +1025,7 @@
 	if (ac97_clock >= 8000 && ac97_clock <= 48000)
 		chip->ac97_clock = ac97_clock;
 	pci_read_config_byte(pci, PCI_REVISION_ID, &chip->revision);
-	synchronize_irq(pci->irq);
+	synchronize_irq(chip->irq);
 
 	/* initialize offsets */
 	chip->playback.reg_offset = VIA_REG_PLAYBACK_STATUS;
diff -Nru a/sound/pci/via8233.c b/sound/pci/via8233.c
--- a/sound/pci/via8233.c	Sun Sep 29 20:23:22 2002
+++ b/sound/pci/via8233.c	Sun Sep 29 20:23:22 2002
@@ -29,6 +29,8 @@
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
+#include <sound/pcm_sgbuf.h>
+#include <sound/pcm_params.h>
 #include <sound/info.h>
 #include <sound/ac97_codec.h>
 #include <sound/mpu401.h>
@@ -157,11 +159,8 @@
 #define   VIA_REG_AC97_DATA_MASK	0xffff
 #define VIA_REG_SGD_SHADOW		0x84	/* dword */
 
-/*
- *
- */
-
-#define VIA_MAX_FRAGS			32
+#define VIA_TBL_BIT_FLAG	0x40000000
+#define VIA_TBL_BIT_EOL		0x80000000
 
 /*
  *  
@@ -169,15 +168,78 @@
 
 typedef struct {
 	unsigned long reg_offset;
-	unsigned int *table;
-	dma_addr_t table_addr;
         snd_pcm_substream_t *substream;
-	dma_addr_t physbuf;
+	int running;
         unsigned int size;
         unsigned int fragsize;
 	unsigned int frags;
+	unsigned int page_per_frag;
+	unsigned int curidx;
+	unsigned int tbl_entries;	/* number of descriptor table entries */
+	unsigned int tbl_size;		/* size of a table entry */
+	u32 *table; /* physical address + flag */
+	dma_addr_t table_addr;
 } viadev_t;
 
+static int build_via_table(viadev_t *dev, snd_pcm_substream_t *substream,
+			   struct pci_dev *pci)
+{
+	int i, size;
+	struct snd_sg_buf *sgbuf = snd_magic_cast(snd_pcm_sgbuf_t, substream->dma_private, return -EINVAL);
+
+	if (dev->table) {
+		snd_free_pci_pages(pci, PAGE_ALIGN(dev->tbl_entries * 8), dev->table, dev->table_addr);
+		dev->table = NULL;
+	}
+
+	/* allocate buffer descriptor lists */
+	if (dev->fragsize < PAGE_SIZE) {
+		dev->tbl_size = dev->fragsize;
+		dev->tbl_entries = dev->frags;
+		dev->page_per_frag = 1;
+	} else {
+		dev->tbl_size = PAGE_SIZE;
+		dev->tbl_entries = sgbuf->pages;
+		dev->page_per_frag = dev->fragsize >> PAGE_SHIFT;
+	}
+	/* the start of each lists must be aligned to 8 bytes,
+	 * but the kernel pages are much bigger, so we don't care
+	 */
+	dev->table = (u32*)snd_malloc_pci_pages(pci, PAGE_ALIGN(dev->tbl_entries * 8), &dev->table_addr);
+	if (! dev->table)
+		return -ENOMEM;
+
+	if (dev->tbl_size < PAGE_SIZE) {
+		for (i = 0; i < dev->tbl_entries; i++)
+			dev->table[i << 1] = cpu_to_le32((u32)sgbuf->table[0].addr + dev->fragsize * i);
+	} else {
+		for (i = 0; i < dev->tbl_entries; i++)
+			dev->table[i << 1] = cpu_to_le32((u32)sgbuf->table[i].addr);
+	}
+	size = dev->size;
+	for (i = 0; i < dev->tbl_entries - 1; i++) {
+		dev->table[(i << 1) + 1] = cpu_to_le32(VIA_TBL_BIT_FLAG | dev->tbl_size);
+		size -= dev->tbl_size;
+	}
+	dev->table[(dev->tbl_entries << 1) - 1] = cpu_to_le32(VIA_TBL_BIT_EOL | size);
+
+	return 0;
+}
+
+
+static void clean_via_table(viadev_t *dev, snd_pcm_substream_t *substream,
+			    struct pci_dev *pci)
+{
+	if (dev->table) {
+		snd_free_pci_pages(pci, PAGE_ALIGN(dev->tbl_entries * 8), dev->table, dev->table_addr);
+		dev->table = NULL;
+	}
+}
+
+
+/*
+ */
+
 typedef struct _snd_via8233 via8233_t;
 #define chip_t via8233_t
 
@@ -200,9 +262,6 @@
 
 	spinlock_t reg_lock;
 	snd_info_entry_t *proc_entry;
-
-	void *tables;
-	dma_addr_t tables_addr;
 };
 
 static struct pci_device_id snd_via8233_ids[] __devinitdata = {
@@ -323,15 +382,19 @@
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		val = VIA_REG_CTRL_INT | VIA_REG_CTRL_START;
+		viadev->running = 1;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		val = VIA_REG_CTRL_TERMINATE;
+		viadev->running = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		val = VIA_REG_CTRL_INT | VIA_REG_CTRL_PAUSE;
+		viadev->running = 1;
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		val = VIA_REG_CTRL_INT;
+		viadev->running = 0;
 		break;
 	default:
 		return -EINVAL;
@@ -342,21 +405,33 @@
 	return 0;
 }
 
-static void snd_via8233_setup_periods(via8233_t *chip, viadev_t *viadev,
-					snd_pcm_substream_t *substream)
+static int snd_via8233_setup_periods(via8233_t *chip, viadev_t *viadev,
+				     snd_pcm_substream_t *substream)
 {
 	snd_pcm_runtime_t *runtime = substream->runtime;
-	int idx, frags;
-	unsigned int *table = viadev->table;
 	unsigned long port = chip->port + viadev->reg_offset;
+	int v, err;
 
-	viadev->physbuf = runtime->dma_addr;
 	viadev->size = snd_pcm_lib_buffer_bytes(substream);
 	viadev->fragsize = snd_pcm_lib_period_bytes(substream);
 	viadev->frags = runtime->periods;
+	viadev->curidx = 0;
+
+	/* the period size must be in power of 2 */
+	v = ld2(viadev->fragsize);
+	if (viadev->fragsize != (1 << v)) {
+		snd_printd(KERN_ERR "invalid fragment size %d\n", viadev->fragsize);
+		return -EINVAL;
+	}
 
 	snd_via8233_channel_reset(chip, viadev);
-	outl(viadev->table_addr, port + VIA_REG_OFFSET_TABLE_PTR);
+
+	err = build_via_table(viadev, substream, chip->pci);
+	if (err < 0)
+		return err;
+
+	runtime->dma_bytes = viadev->size;
+	outl((u32)viadev->table_addr, port + VIA_REG_OFFSET_TABLE_PTR);
 	if (viadev->reg_offset == VIA_REG_MULTPLAY_STATUS) {
 		unsigned int slots;
 		int fmt = (runtime->format == SNDRV_PCM_FORMAT_S16_LE) ? VIA_REG_MULTPLAY_FMT_16BIT : VIA_REG_MULTPLAY_FMT_8BIT;
@@ -378,27 +453,7 @@
 		     0xff000000,    /* STOP index is never reached */
 		     port + VIA_REG_OFFSET_STOP_IDX);
 	}
-
-	if (viadev->size == viadev->fragsize) {
-		table[0] = cpu_to_le32(viadev->physbuf);
-		table[1] = cpu_to_le32(0xc0000000 | /* EOL + flag */
-				       viadev->fragsize);
-	} else {
-		frags = viadev->size / viadev->fragsize;
-		for (idx = 0; idx < frags - 1; idx++) {
-			table[(idx << 1) + 0] = cpu_to_le32(viadev->physbuf + (idx * viadev->fragsize));
-			table[(idx << 1) + 1] = cpu_to_le32(0x40000000 |	/* flag */
-							    viadev->fragsize);
-		}
-		table[((frags-1) << 1) + 0] = cpu_to_le32(viadev->physbuf + ((frags-1) * viadev->fragsize));
-		table[((frags-1) << 1) + 1] = cpu_to_le32(0x80000000 |	/* EOL */
-							  viadev->fragsize);
-	}
-#if 0
-	printk("%s: size = %d  frags = %d  fragsize = %d\n",  __FUNCTION__, viadev->size, frags, viadev->fragsize);
-	for (idx=0; idx < frags; idx++)
-		printk("    address %x,  count %x\n", table[idx*2], table[idx*2+1]);
-#endif
+	return 0;
 }
 
 /*
@@ -407,18 +462,28 @@
 
 static inline void snd_via8233_update(via8233_t *chip, viadev_t *viadev)
 {
-	snd_pcm_period_elapsed(viadev->substream);
 	outb(VIA_REG_STAT_FLAG | VIA_REG_STAT_EOL, VIAREG(chip, OFFSET_STATUS) + viadev->reg_offset);
+	if (viadev->substream && viadev->running) {
+		viadev->curidx++;
+		if (viadev->curidx >= viadev->page_per_frag) {
+			viadev->curidx = 0;
+			spin_unlock(&chip->reg_lock);
+			snd_pcm_period_elapsed(viadev->substream);
+			spin_lock(&chip->reg_lock);
+		}
+	}
 }
 
 static void snd_via8233_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	via8233_t *chip = snd_magic_cast(via8233_t, dev_id, return);
 
+	spin_lock(&chip->reg_lock);
 	if (inb(chip->port + chip->playback.reg_offset) & (VIA_REG_STAT_EOL|VIA_REG_STAT_FLAG))
 		snd_via8233_update(chip, &chip->playback);
 	if (inb(chip->port + chip->capture.reg_offset) & (VIA_REG_STAT_EOL|VIA_REG_STAT_FLAG))
 		snd_via8233_update(chip, &chip->capture);
+	spin_unlock(&chip->reg_lock);
 }
 
 /*
@@ -443,12 +508,12 @@
 static int snd_via8233_hw_params(snd_pcm_substream_t * substream,
 					  snd_pcm_hw_params_t * hw_params)
 {
-	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
+	return snd_pcm_sgbuf_alloc(substream, params_buffer_bytes(hw_params));
 }
 
 static int snd_via8233_hw_free(snd_pcm_substream_t * substream)
 {
-	return snd_pcm_lib_free_pages(substream);
+	return 0;
 }
 
 static int snd_via8233_playback_prepare(snd_pcm_substream_t * substream)
@@ -457,7 +522,6 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 
 	snd_ac97_set_rate(chip->ac97, AC97_PCM_FRONT_DAC_RATE, runtime->rate);
-	snd_via8233_setup_periods(chip, &chip->playback, substream);
 	if (chip->playback.reg_offset != VIA_REG_MULTPLAY_STATUS) {
 		unsigned int tmp;
 		/* I don't understand this stuff but its from the documentation and this way it works */
@@ -466,7 +530,7 @@
 		tmp = inl(VIAREG(chip, PLAYBACK_STOP_IDX)) & ~0xfffff;
 		outl(tmp | (0xffff * runtime->rate)/(48000/16), VIAREG(chip, PLAYBACK_STOP_IDX));
 	}
-	return 0;
+	return snd_via8233_setup_periods(chip, &chip->playback, substream);
 }
 
 static int snd_via8233_capture_prepare(snd_pcm_substream_t * substream)
@@ -475,10 +539,9 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 
 	snd_ac97_set_rate(chip->ac97, AC97_PCM_LR_ADC_RATE, runtime->rate);
-	snd_via8233_setup_periods(chip, &chip->capture, substream);
 	outb(VIA_REG_CAPTURE_CHANNEL_LINE, VIAREG(chip, CAPTURE_CHANNEL));
 	outb(VIA_REG_CAPTURE_FIFO_ENABLE, VIAREG(chip, CAPTURE_FIFO));
-	return 0;
+	return snd_via8233_setup_periods(chip, &chip->capture, substream);
 }
 
 static inline unsigned int snd_via8233_cur_ptr(via8233_t *chip, viadev_t *viadev)
@@ -488,9 +551,14 @@
 	count = inl(VIAREG(chip, OFFSET_CURR_COUNT) + viadev->reg_offset) & 0xffffff;
 	/* The via686a does not have this current index register,
 	 * this register makes life easier for us here. */
-	val = inb(VIAREG(chip, OFFSET_CURR_INDEX) + viadev->reg_offset) % viadev->frags;
-	val *= viadev->fragsize;
-	val += viadev->fragsize - count;
+	val = inb(VIAREG(chip, OFFSET_CURR_INDEX) + viadev->reg_offset) % viadev->tbl_entries;
+	if (val < viadev->tbl_entries - 1) {
+		val *= viadev->tbl_size;
+		val += viadev->tbl_size - count;
+	} else {
+		val *= viadev->tbl_size;
+		val += (viadev->size % viadev->tbl_size) + 1 - count;
+	}
 	// printk("pointer: ptr = 0x%x, count = 0x%x, val = 0x%x\n", ptr, count, val);
 	return val;
 }
@@ -522,8 +590,8 @@
 	buffer_bytes_max:	128 * 1024,
 	period_bytes_min:	32,
 	period_bytes_max:	128 * 1024,
-	periods_min:		1,
-	periods_max:		VIA_MAX_FRAGS,
+	periods_min:		2,
+	periods_max:		1024,
 	fifo_size:		0,
 };
 
@@ -541,8 +609,8 @@
 	buffer_bytes_max:	128 * 1024,
 	period_bytes_min:	32,
 	period_bytes_max:	128 * 1024,
-	periods_min:		1,
-	periods_max:		VIA_MAX_FRAGS,
+	periods_min:		2,
+	periods_max:		1024,
 	fifo_size:		0,
 };
 
@@ -569,8 +637,14 @@
 	runtime->hw.rates = chip->ac97->rates_front_dac;
 	if (!(runtime->hw.rates & SNDRV_PCM_RATE_8000))
 		runtime->hw.rate_min = 48000;
+	if ((err = snd_pcm_sgbuf_init(substream, chip->pci, 32)) < 0)
+		return err;
+	if ((err = snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES)) < 0)
+		return err;
+#if 0
 	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
 		return err;
+#endif
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS, &hw_constraints_channels);
 	return 0;
 }
@@ -586,8 +660,14 @@
 	runtime->hw.rates = chip->ac97->rates_adc;
 	if (!(runtime->hw.rates & SNDRV_PCM_RATE_8000))
 		runtime->hw.rate_min = 48000;
+	if ((err = snd_pcm_sgbuf_init(substream, chip->pci, 32)) < 0)
+		return err;
+	if ((err = snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES)) < 0)
+		return err;
+#if 0
 	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
 		return err;
+#endif
 	return 0;
 }
 
@@ -596,6 +676,8 @@
 	via8233_t *chip = snd_pcm_substream_chip(substream);
 
 	snd_via8233_channel_reset(chip, &chip->playback);
+	clean_via_table(&chip->playback, substream, chip->pci);
+	snd_pcm_sgbuf_delete(substream);
 	chip->playback.substream = NULL;
 	/* disable DAC power */
 	snd_ac97_update_bits(chip->ac97, AC97_POWERDOWN, 0x0200, 0x0200);
@@ -607,6 +689,8 @@
 	via8233_t *chip = snd_pcm_substream_chip(substream);
 
 	snd_via8233_channel_reset(chip, &chip->capture);
+	clean_via_table(&chip->capture, substream, chip->pci);
+	snd_pcm_sgbuf_delete(substream);
 	chip->capture.substream = NULL;
 	/* disable ADC power */
 	snd_ac97_update_bits(chip->ac97, AC97_POWERDOWN, 0x0100, 0x0100);
@@ -622,6 +706,9 @@
 	prepare:	snd_via8233_playback_prepare,
 	trigger:	snd_via8233_playback_trigger,
 	pointer:	snd_via8233_playback_pointer,
+	copy:           snd_pcm_sgbuf_ops_copy_playback,
+	silence:        snd_pcm_sgbuf_ops_silence,
+	page:           snd_pcm_sgbuf_ops_page,
 };
 
 static snd_pcm_ops_t snd_via8233_capture_ops = {
@@ -633,13 +720,15 @@
 	prepare:	snd_via8233_capture_prepare,
 	trigger:	snd_via8233_capture_trigger,
 	pointer:	snd_via8233_capture_pointer,
+	copy:           snd_pcm_sgbuf_ops_copy_capture,
+	silence:        snd_pcm_sgbuf_ops_silence,
+	page:           snd_pcm_sgbuf_ops_page,
 };
 
 static void snd_via8233_pcm_free(snd_pcm_t *pcm)
 {
 	via8233_t *chip = snd_magic_cast(via8233_t, pcm->private_data, return);
 	chip->pcm = NULL;
-	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
 
 static int __devinit snd_via8233_pcm(via8233_t *chip, int device, snd_pcm_t ** rpcm)
@@ -662,8 +751,6 @@
 	strcpy(pcm->name, "VIA 8233");
 	chip->pcm = pcm;
 
-	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 128*1024);
-
 	if (rpcm)
 		*rpcm = NULL;
 	return 0;
@@ -758,14 +845,8 @@
 	snd_via8233_channel_reset(chip, &chip->playback);
 	snd_via8233_channel_reset(chip, &chip->capture);
 	/* --- */
+	synchronize_irq(chip->irq);
       __end_hw:
-	if (chip->irq)
-		synchronize_irq(chip->irq);
-	if (chip->tables)
-		snd_free_pci_pages(chip->pci,
-				   VIA_NUM_OF_DMA_CHANNELS * sizeof(unsigned int) * VIA_MAX_FRAGS * 2,
-				   chip->tables,
-				   chip->tables_addr);
 	if (chip->res_port) {
 		release_resource(chip->res_port);
 		kfree_nocheck(chip->res_port);
@@ -831,21 +912,6 @@
 
 	chip->capture.reg_offset = VIA_REG_CAPTURE_STATUS;
 
-	/* allocate buffer descriptor lists */
-	/* the start of each lists must be aligned to 8 bytes */
-	chip->tables = (unsigned int *)snd_malloc_pci_pages(pci,
-				VIA_NUM_OF_DMA_CHANNELS * sizeof(unsigned int) * VIA_MAX_FRAGS * 2,
-				&chip->tables_addr);
-	if (chip->tables == NULL) {
-		snd_via8233_free(chip);
-		return -ENOMEM;
-	}
-	/* tables must be aligned to 8 bytes, but the kernel pages
-	   are much bigger, so we don't care */
-	chip->playback.table = chip->tables;
-	chip->playback.table_addr = chip->tables_addr;
-	chip->capture.table = chip->playback.table + VIA_MAX_FRAGS * 2;
-	chip->capture.table_addr = chip->playback.table_addr + sizeof(unsigned int) * VIA_MAX_FRAGS * 2;
 	if ((err = snd_via8233_chip_init(chip)) < 0) {
 		snd_via8233_free(chip);
 		return err;

===================================================================


This BitKeeper patch contains the following changesets:
1.605.2.19
## Wrapped with gzip_uu ##


begin 664 bkpatch2542
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
/=<T5K%;G&ZJO<,$G8```
`
end


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

