Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287609AbSAHDME>; Mon, 7 Jan 2002 22:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287604AbSAHDL6>; Mon, 7 Jan 2002 22:11:58 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:14701 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S287609AbSAHDLq>; Mon, 7 Jan 2002 22:11:46 -0500
Date: Mon, 7 Jan 2002 22:11:44 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Patch for ymfpci to use "new" DMA API
Message-ID: <20020107221144.C30489@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I figure since the DMA API is only needed on sparc and ppc
I'd throw the endiannes cleanup into it. Kai produced the
core of it by diffing with ALSA. Please consider.

-- Pete

diff -ur -X dontdiff linux-2.4.17/drivers/sound/ymfpci.c linux-2.4.17-niph/drivers/sound/ymfpci.c
--- linux-2.4.17/drivers/sound/ymfpci.c	Fri Dec 21 09:41:55 2001
+++ linux-2.4.17-niph/drivers/sound/ymfpci.c	Mon Jan  7 18:41:49 2002
@@ -1,6 +1,8 @@
 /*
  *  Copyright 1999 Jaroslav Kysela <perex@suse.cz>
  *  Copyright 2000 Alan Cox <alan@redhat.com>
+ *  Copyright 2001 Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
+ *  Copyright 2002 Pete Zaitcev <zaitcev@yahoo.com>
  *
  *  Yamaha YMF7xx driver.
  *
@@ -37,9 +39,16 @@
  *  - Remove prog_dmabuf from read/write, leave it in open.
  *  - 2001/01/07 Replace the OPL3 part of CONFIG_SOUND_YMFPCI_LEGACY code with
  *    native synthesizer through a playback slot.
- *  - Use new 2.3.x cache coherent PCI DMA routines instead of virt_to_bus.
- *  - Make the thing big endian compatible. ALSA has it done.
  *  - 2001/11/29 ac97_save_state
+ *    Talk to Kai to remove ac97_save_state before it's too late!
+ *  - Second AC97
+ *  - Restore S/PDIF - Toshibas have it.
+ *
+ * Kai used pci_alloc_consistent for DMA buffer, which sounds a little
+ * unconventional. However, given how small our fragments can be,
+ * a little uncached access is perhaps better than endless flushing.
+ * On i386 and other I/O-coherent architectures pci_alloc_consistent
+ * is entirely harmless.
  */
 
 #include <linux/config.h>
@@ -280,18 +289,22 @@
 #define DMABUF_DEFAULTORDER (15-PAGE_SHIFT)
 #define DMABUF_MINORDER 1
 
-/* allocate DMA buffer, playback and recording buffer should be allocated seperately */
-static int alloc_dmabuf(struct ymf_dmabuf *dmabuf)
+/*
+ * Allocate DMA buffer
+ */
+static int alloc_dmabuf(ymfpci_t *unit, struct ymf_dmabuf *dmabuf)
 {
 	void *rawbuf = NULL;
+	dma_addr_t dma_addr;
 	int order;
-	struct page * map,  * mapend;
+	struct page *map, *mapend;
 
 	/* alloc as big a chunk as we can */
-	for (order = DMABUF_DEFAULTORDER; order >= DMABUF_MINORDER; order--)
-		if((rawbuf = (void *)__get_free_pages(GFP_KERNEL|GFP_DMA, order)))
+	for (order = DMABUF_DEFAULTORDER; order >= DMABUF_MINORDER; order--) {
+		rawbuf = pci_alloc_consistent(unit->pci, PAGE_SIZE << order, &dma_addr);
+		if (rawbuf)
 			break;
-
+	}
 	if (!rawbuf)
 		return -ENOMEM;
 
@@ -302,6 +315,7 @@
 
 	dmabuf->ready  = dmabuf->mapped = 0;
 	dmabuf->rawbuf = rawbuf;
+	dmabuf->dma_addr = dma_addr;
 	dmabuf->buforder = order;
 
 	/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
@@ -312,8 +326,10 @@
 	return 0;
 }
 
-/* free DMA buffer */
-static void dealloc_dmabuf(struct ymf_dmabuf *dmabuf)
+/*
+ * Free DMA buffer
+ */
+static void dealloc_dmabuf(ymfpci_t *unit, struct ymf_dmabuf *dmabuf)
 {
 	struct page *map, *mapend;
 
@@ -322,7 +338,9 @@
 		mapend = virt_to_page(dmabuf->rawbuf + (PAGE_SIZE << dmabuf->buforder) - 1);
 		for (map = virt_to_page(dmabuf->rawbuf); map <= mapend; map++)
 			clear_bit(PG_reserved, &map->flags);
-		free_pages((unsigned long)dmabuf->rawbuf,dmabuf->buforder);
+
+		pci_free_consistent(unit->pci, PAGE_SIZE << dmabuf->buforder,
+		    dmabuf->rawbuf, dmabuf->dma_addr);
 	}
 	dmabuf->rawbuf = NULL;
 	dmabuf->mapped = dmabuf->ready = 0;
@@ -348,7 +366,7 @@
 
 	/* allocate DMA buffer if not allocated yet */
 	if (!dmabuf->rawbuf)
-		if ((ret = alloc_dmabuf(dmabuf)))
+		if ((ret = alloc_dmabuf(state->unit, dmabuf)))
 			return ret;
 
 	/*
@@ -588,7 +606,8 @@
 	if (ypcm->running) {
 		YMFDBGI("ymfpci: %d, intr bank %d count %d start 0x%x:%x\n",
 		   voice->number, codec->active_bank, dmabuf->count,
-		   voice->bank[0].start, voice->bank[1].start);
+		   le32_to_cpu(voice->bank[0].start),
+		   le32_to_cpu(voice->bank[1].start));
 		silence = (ymf_pcm_format_width(state->format.format) == 16) ?
 		    0 : 0x80;
 		/* We need actual left-hand-side redzone size here. */
@@ -596,7 +615,7 @@
 		redzone <<= (state->format.shift + 1);
 		swptr = dmabuf->swptr;
 
-		pos = voice->bank[codec->active_bank].start;
+		pos = le32_to_cpu(voice->bank[codec->active_bank].start);
 		pos <<= state->format.shift;
 		if (pos < 0 || pos >= dmabuf->dmasize) {	/* ucode bug */
 			printk(KERN_ERR "ymfpci%d: runaway voice %d: hwptr %d=>%d dmasize %d\n",
@@ -699,7 +718,7 @@
 		redzone = ymf_calc_lend(state->format.rate);
 		redzone <<= (state->format.shift + 1);
 
-		pos = cap->bank[unit->active_bank].start;
+		pos = le32_to_cpu(cap->bank[unit->active_bank].start);
 		// pos <<= state->format.shift;
 		if (pos < 0 || pos >= dmabuf->dmasize) {	/* ucode bug */
 			printk(KERN_ERR "ymfpci%d: runaway capture %d: hwptr %d=>%d dmasize %d\n",
@@ -743,9 +762,11 @@
 		return -EINVAL;
 	}
 	if (cmd != 0) {
-		codec->ctrl_playback[ypcm->voices[0]->number + 1] = virt_to_bus(ypcm->voices[0]->bank);
+		codec->ctrl_playback[ypcm->voices[0]->number + 1] =
+		    cpu_to_le32(ypcm->voices[0]->bank_ba);
 		if (ypcm->voices[1] != NULL)
-			codec->ctrl_playback[ypcm->voices[1]->number + 1] = virt_to_bus(ypcm->voices[1]->bank);
+			codec->ctrl_playback[ypcm->voices[1]->number + 1] =
+			    cpu_to_le32(ypcm->voices[1]->bank_ba);
 		ypcm->running = 1;
 	} else {
 		codec->ctrl_playback[ypcm->voices[0]->number + 1] = 0;
@@ -811,6 +832,7 @@
 	u32 lpfK = ymfpci_calc_lpfK(rate);
 	ymfpci_playback_bank_t *bank;
 	int nbank;
+	unsigned le_0x40000000 = 0x40;
 
 	format = (stereo ? 0x00010000 : 0) | (w_16 ? 0 : 0x80000000);
 	if (stereo)
@@ -819,24 +841,24 @@
 		end >>= 1;
 	for (nbank = 0; nbank < 2; nbank++) {
 		bank = &voice->bank[nbank];
-		bank->format = format;
+		bank->format = cpu_to_le32(format);
 		bank->loop_default = 0;	/* 0-loops forever, otherwise count */
-		bank->base = addr;
+		bank->base = cpu_to_le32(addr);
 		bank->loop_start = 0;
-		bank->loop_end = end;
+		bank->loop_end = cpu_to_le32(end);
 		bank->loop_frac = 0;
-		bank->eg_gain_end = 0x40000000;
-		bank->lpfQ = lpfQ;
+		bank->eg_gain_end = le_0x40000000;
+		bank->lpfQ = cpu_to_le32(lpfQ);
 		bank->status = 0;
 		bank->num_of_frames = 0;
 		bank->loop_count = 0;
 		bank->start = 0;
 		bank->start_frac = 0;
 		bank->delta =
-		bank->delta_end = delta;
+		bank->delta_end = cpu_to_le32(delta);
 		bank->lpfK =
-		bank->lpfK_end = lpfK;
-		bank->eg_gain = 0x40000000;
+		bank->lpfK_end = cpu_to_le32(lpfK);
+		bank->eg_gain = le_0x40000000;
 		bank->lpfD1 =
 		bank->lpfD2 = 0;
 
@@ -856,31 +878,31 @@
 				bank->left_gain = 
 				bank->right_gain =
 				bank->left_gain_end =
-				bank->right_gain_end = 0x40000000;
+				bank->right_gain_end = le_0x40000000;
 			} else {
 				bank->eff2_gain =
 				bank->eff2_gain_end =
 				bank->eff3_gain =
-				bank->eff3_gain_end = 0x40000000;
+				bank->eff3_gain_end = le_0x40000000;
 			}
 		} else {
 			if (!spdif) {
 				if ((voice->number & 1) == 0) {
 					bank->left_gain =
-					bank->left_gain_end = 0x40000000;
+					bank->left_gain_end = le_0x40000000;
 				} else {
-					bank->format |= 1;
+					bank->format |= cpu_to_le32(1);
 					bank->right_gain =
-					bank->right_gain_end = 0x40000000;
+					bank->right_gain_end = le_0x40000000;
 				}
 			} else {
 				if ((voice->number & 1) == 0) {
 					bank->eff2_gain =
-					bank->eff2_gain_end = 0x40000000;
+					bank->eff2_gain_end = le_0x40000000;
 				} else {
-					bank->format |= 1;
+					bank->format |= cpu_to_le32(1);
 					bank->eff3_gain =
-					bank->eff3_gain_end = 0x40000000;
+					bank->eff3_gain_end = le_0x40000000;
 				}
 			}
 		}
@@ -921,7 +943,7 @@
 		ymf_pcm_init_voice(ypcm->voices[nvoice],
 		    state->format.voices == 2, state->format.rate,
 		    ymf_pcm_format_width(state->format.format) == 16,
-		    virt_to_bus(ypcm->dmabuf.rawbuf), ypcm->dmabuf.dmasize,
+		    ypcm->dmabuf.dma_addr, ypcm->dmabuf.dmasize,
 		    ypcm->spdif);
 	}
 	return 0;
@@ -970,9 +992,9 @@
 	}
 	for (nbank = 0; nbank < 2; nbank++) {
 		bank = unit->bank_capture[ypcm->capture_bank_number][nbank];
-		bank->base = virt_to_bus(ypcm->dmabuf.rawbuf);
+		bank->base = cpu_to_le32(ypcm->dmabuf.dma_addr);
 		// bank->loop_end = ypcm->dmabuf.dmasize >> state->format.shift;
-		bank->loop_end = ypcm->dmabuf.dmasize;
+		bank->loop_end = cpu_to_le32(ypcm->dmabuf.dmasize);
 		bank->start = 0;
 		bank->num_of_loops = 0;
 	}
@@ -1809,9 +1831,9 @@
 		    cinfo.ptr, cinfo.bytes);
 		return copy_to_user((void *)arg, &cinfo, sizeof(cinfo)) ? -EFAULT : 0;
 
-	case SNDCTL_DSP_SETDUPLEX:	/* XXX TODO */
+	case SNDCTL_DSP_SETDUPLEX:
 		YMFDBGX("ymf_ioctl: cmd 0x%x(SETDUPLEX)\n", cmd);
-		return -EINVAL;
+		return 0;		/* Always duplex */
 
 	case SOUND_PCM_READ_RATE:
 		YMFDBGX("ymf_ioctl: cmd 0x%x(READ_RATE)\n", cmd);
@@ -1838,6 +1860,7 @@
 		 * Some programs mix up audio devices and ioctls
 		 * or perhaps they expect "universal" ioctls,
 		 * for instance we get SNDCTL_TMR_CONTINUE here.
+		 * (mpg123 -g 100 ends here too - to be fixed.)
 		 */
 		YMFDBGX("ymf_ioctl: cmd 0x%x unknown\n", cmd);
 		break;
@@ -1922,8 +1945,8 @@
 	 * a nestable exception, but here it is not nestable due to semaphore.
 	 * XXX Doubtful technique of self-describing objects....
 	 */
-	dealloc_dmabuf(&state->wpcm.dmabuf);
-	dealloc_dmabuf(&state->rpcm.dmabuf);
+	dealloc_dmabuf(unit, &state->wpcm.dmabuf);
+	dealloc_dmabuf(unit, &state->rpcm.dmabuf);
 	ymf_pcm_free_substream(&state->wpcm);
 	ymf_pcm_free_substream(&state->rpcm);
 
@@ -1951,8 +1974,8 @@
 	 */
 	ymf_wait_dac(state);
 	ymf_stop_adc(state);		/* fortunately, it's immediate */
-	dealloc_dmabuf(&state->wpcm.dmabuf);
-	dealloc_dmabuf(&state->rpcm.dmabuf);
+	dealloc_dmabuf(unit, &state->wpcm.dmabuf);
+	dealloc_dmabuf(unit, &state->rpcm.dmabuf);
 	ymf_pcm_free_substream(&state->wpcm);
 	ymf_pcm_free_substream(&state->rpcm);
 
@@ -2042,11 +2065,6 @@
 
 	unit->suspended = 1;
 
-	/*
-	 * XXX Talk to Kai to remove ac97_save_state before it's too late!
-	 * Other drivers call ac97_reset, which does not have
-	 * a save counterpart. Current ac97_save_state is empty.
-	 */
 	for (i = 0; i < NR_AC97; i++) {
 		if ((codec = unit->ac97_codec[i]) != NULL)
 			ac97_save_state(codec);
@@ -2287,29 +2305,39 @@
 
 static int ymfpci_memalloc(ymfpci_t *codec)
 {
-	long size, playback_ctrl_size;
+	unsigned int playback_ctrl_size;
+	unsigned int bank_size_playback;
+	unsigned int bank_size_capture;
+	unsigned int bank_size_effect;
+	unsigned int size;
+	unsigned int off;
+	char *ptr;
+	dma_addr_t pba;
 	int voice, bank;
-	u8 *ptr;
 
 	playback_ctrl_size = 4 + 4 * YDSXG_PLAYBACK_VOICES;
-	codec->bank_size_playback = ymfpci_readl(codec, YDSXGR_PLAYCTRLSIZE) << 2;
-	codec->bank_size_capture = ymfpci_readl(codec, YDSXGR_RECCTRLSIZE) << 2;
-	codec->bank_size_effect = ymfpci_readl(codec, YDSXGR_EFFCTRLSIZE) << 2;
+	bank_size_playback = ymfpci_readl(codec, YDSXGR_PLAYCTRLSIZE) << 2;
+	bank_size_capture = ymfpci_readl(codec, YDSXGR_RECCTRLSIZE) << 2;
+	bank_size_effect = ymfpci_readl(codec, YDSXGR_EFFCTRLSIZE) << 2;
 	codec->work_size = YDSXG_DEFAULT_WORK_SIZE;
 
 	size = ((playback_ctrl_size + 0x00ff) & ~0x00ff) +
-	    ((codec->bank_size_playback * 2 * YDSXG_PLAYBACK_VOICES + 0xff) & ~0xff) +
-	    ((codec->bank_size_capture * 2 * YDSXG_CAPTURE_VOICES + 0xff) & ~0xff) +
-	    ((codec->bank_size_effect * 2 * YDSXG_EFFECT_VOICES + 0xff) & ~0xff) +
+	    ((bank_size_playback * 2 * YDSXG_PLAYBACK_VOICES + 0xff) & ~0xff) +
+	    ((bank_size_capture * 2 * YDSXG_CAPTURE_VOICES + 0xff) & ~0xff) +
+	    ((bank_size_effect * 2 * YDSXG_EFFECT_VOICES + 0xff) & ~0xff) +
 	    codec->work_size;
 
-	ptr = (u8 *)kmalloc(size + 0x00ff, GFP_KERNEL);
+	ptr = pci_alloc_consistent(codec->pci, size + 0xff, &pba);
 	if (ptr == NULL)
 		return -ENOMEM;
-
-	codec->work_ptr = ptr;
-	ptr += 0x00ff;
-	(long)ptr &= ~0x00ff;
+	codec->dma_area_va = ptr;
+	codec->dma_area_ba = pba;
+	codec->dma_area_size = size + 0xff;
+
+	if ((off = ((uint) ptr) & 0xff) != 0) {
+		ptr += 0x100 - off;
+		pba += 0x100 - off;
+	}
 
 	/*
 	 * Hardware requires only ptr[playback_ctrl_size] zeroed,
@@ -2317,34 +2345,49 @@
 	 */
 	memset(ptr, 0, size);
 
-	codec->bank_base_playback = ptr;
 	codec->ctrl_playback = (u32 *)ptr;
-	codec->ctrl_playback[0] = YDSXG_PLAYBACK_VOICES;
+	codec->ctrl_playback_ba = pba;
+	codec->ctrl_playback[0] = cpu_to_le32(YDSXG_PLAYBACK_VOICES);
 	ptr += (playback_ctrl_size + 0x00ff) & ~0x00ff;
+	pba += (playback_ctrl_size + 0x00ff) & ~0x00ff;
+
+	off = 0;
 	for (voice = 0; voice < YDSXG_PLAYBACK_VOICES; voice++) {
-		for (bank = 0; bank < 2; bank++) {
-			codec->bank_playback[voice][bank] = (ymfpci_playback_bank_t *)ptr;
-			ptr += codec->bank_size_playback;
-		}
 		codec->voices[voice].number = voice;
-		codec->voices[voice].bank = codec->bank_playback[voice][0];
-	}
-	ptr += (codec->bank_size_playback + 0x00ff) & ~0x00ff;
-	codec->bank_base_capture = ptr;
+		codec->voices[voice].bank =
+		    (ymfpci_playback_bank_t *) (ptr + off);
+		codec->voices[voice].bank_ba = pba + off;
+		off += 2 * bank_size_playback;		/* 2 banks */
+	}
+	off = (off + 0xff) & ~0xff;
+	ptr += off;
+	pba += off;
+
+	off = 0;
+	codec->bank_base_capture = pba;
 	for (voice = 0; voice < YDSXG_CAPTURE_VOICES; voice++)
 		for (bank = 0; bank < 2; bank++) {
-			codec->bank_capture[voice][bank] = (ymfpci_capture_bank_t *)ptr;
-			ptr += codec->bank_size_capture;
-		}
-	ptr += (codec->bank_size_capture + 0x00ff) & ~0x00ff;
-	codec->bank_base_effect = ptr;
+			codec->bank_capture[voice][bank] =
+			    (ymfpci_capture_bank_t *) (ptr + off);
+			off += bank_size_capture;
+		}
+	off = (off + 0xff) & ~0xff;
+	ptr += off;
+	pba += off;
+
+	off = 0;
+	codec->bank_base_effect = pba;
 	for (voice = 0; voice < YDSXG_EFFECT_VOICES; voice++)
 		for (bank = 0; bank < 2; bank++) {
-			codec->bank_effect[voice][bank] = (ymfpci_effect_bank_t *)ptr;
-			ptr += codec->bank_size_effect;
-		}
-	ptr += (codec->bank_size_effect + 0x00ff) & ~0x00ff;
-	codec->work_base = ptr;
+			codec->bank_effect[voice][bank] =
+			    (ymfpci_effect_bank_t *) (ptr + off);
+			off += bank_size_effect;
+		}
+	off = (off + 0xff) & ~0xff;
+	ptr += off;
+	pba += off;
+
+	codec->work_base = pba;
 
 	return 0;
 }
@@ -2356,16 +2399,17 @@
 	ymfpci_writel(codec, YDSXGR_EFFCTRLBASE, 0);
 	ymfpci_writel(codec, YDSXGR_WORKBASE, 0);
 	ymfpci_writel(codec, YDSXGR_WORKSIZE, 0);
-	kfree(codec->work_ptr);
+	pci_free_consistent(codec->pci,
+	    codec->dma_area_size, codec->dma_area_va, codec->dma_area_ba);
 }
 
 static void ymf_memload(ymfpci_t *unit)
 {
 
-	ymfpci_writel(unit, YDSXGR_PLAYCTRLBASE, virt_to_bus(unit->bank_base_playback));
-	ymfpci_writel(unit, YDSXGR_RECCTRLBASE, virt_to_bus(unit->bank_base_capture));
-	ymfpci_writel(unit, YDSXGR_EFFCTRLBASE, virt_to_bus(unit->bank_base_effect));
-	ymfpci_writel(unit, YDSXGR_WORKBASE, virt_to_bus(unit->work_base));
+	ymfpci_writel(unit, YDSXGR_PLAYCTRLBASE, unit->ctrl_playback_ba);
+	ymfpci_writel(unit, YDSXGR_RECCTRLBASE, unit->bank_base_capture);
+	ymfpci_writel(unit, YDSXGR_EFFCTRLBASE, unit->bank_base_effect);
+	ymfpci_writel(unit, YDSXGR_WORKBASE, unit->work_base);
 	ymfpci_writel(unit, YDSXGR_WORKSIZE, unit->work_size >> 2);
 
 	/* S/PDIF output initialization */
@@ -2530,7 +2574,7 @@
 	codec->opl3_data.irq     = -1;
 
 	codec->mpu_data.io_base  = codec->iomidi;
-	codec->mpu_data.irq      = -1;	/* XXX Make it ours. */
+	codec->mpu_data.irq      = -1;	/* May be different from our PCI IRQ. */
 
 	if (codec->iomidi) {
 		if (!probe_uart401(&codec->mpu_data, THIS_MODULE)) {
diff -ur -X dontdiff linux-2.4.17/drivers/sound/ymfpci.h linux-2.4.17-niph/drivers/sound/ymfpci.h
--- linux-2.4.17/drivers/sound/ymfpci.h	Sun Aug 12 10:51:42 2001
+++ linux-2.4.17-niph/drivers/sound/ymfpci.h	Thu Jan  3 02:13:50 2002
@@ -227,6 +227,7 @@
 	char use, pcm, synth, midi;	// bool
 	ymfpci_playback_bank_t *bank;
 	struct ymf_pcm *ypcm;
+	dma_addr_t bank_ba;
 };
 
 struct ymf_capture {
@@ -239,19 +240,17 @@
 struct ymf_unit {
 	u8 rev;				/* PCI revision */
 	void *reg_area_virt;
-	void *work_ptr;
-
-	unsigned int bank_size_playback;
-	unsigned int bank_size_capture;
-	unsigned int bank_size_effect;
+	void *dma_area_va;
+	dma_addr_t dma_area_ba;
+	unsigned int dma_area_size;
+
+	dma_addr_t bank_base_capture;
+	dma_addr_t bank_base_effect;
+	dma_addr_t work_base;
 	unsigned int work_size;
 
-	void *bank_base_playback;
-	void *bank_base_capture;
-	void *bank_base_effect;
-	void *work_base;
-
 	u32 *ctrl_playback;
+	dma_addr_t ctrl_playback_ba;
 	ymfpci_playback_bank_t *bank_playback[YDSXG_PLAYBACK_VOICES][2];
 	ymfpci_capture_bank_t *bank_capture[YDSXG_CAPTURE_VOICES][2];
 	ymfpci_effect_bank_t *bank_effect[YDSXG_EFFECT_VOICES][2];
@@ -286,10 +285,11 @@
 };
 
 struct ymf_dmabuf {
-
-	/* OSS buffer management stuff */
+	dma_addr_t dma_addr;
 	void *rawbuf;
 	unsigned buforder;
+
+	/* OSS buffer management stuff */
 	unsigned numfrag;
 	unsigned fragshift;
 
