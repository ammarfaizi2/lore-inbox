Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289887AbSAKGXj>; Fri, 11 Jan 2002 01:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289888AbSAKGXd>; Fri, 11 Jan 2002 01:23:33 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:29010 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S289887AbSAKGXN>; Fri, 11 Jan 2002 01:23:13 -0500
Date: Fri, 11 Jan 2002 01:23:13 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Patch for ymfpci in 2.5.x
Message-ID: <20020111012313.A2853@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sent to Linus separately - cannot get vger to cooperate 8-)]

While 2.5.x was a bit less stable, ymfpci in 2.4 moved ahead.
Most of it is cleanup, but there is a real fix for artsd as well.
ALSA is supposed to supersede this code, but unless it's happening
tomorrow we better update it before the patch grows too big.

-- Pete

diff -ur -X dontdiff linux-2.5.2-pre11/drivers/sound/ymfpci.c linux-2.5.2-pre11-p3/drivers/sound/ymfpci.c
--- linux-2.5.2-pre11/drivers/sound/ymfpci.c	Thu Jan 10 15:52:17 2002
+++ linux-2.5.2-pre11-p3/drivers/sound/ymfpci.c	Thu Jan 10 21:17:13 2002
@@ -1,6 +1,8 @@
 /*
  *  Copyright 1999 Jaroslav Kysela <perex@suse.cz>
  *  Copyright 2000 Alan Cox <alan@redhat.com>
+ *  Copyright 2001 Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
+ *  Copyright 2002 Pete Zaitcev <zaitcev@yahoo.com>
  *
  *  Yamaha YMF7xx driver.
  *
@@ -37,8 +39,16 @@
  *  - Remove prog_dmabuf from read/write, leave it in open.
  *  - 2001/01/07 Replace the OPL3 part of CONFIG_SOUND_YMFPCI_LEGACY code with
  *    native synthesizer through a playback slot.
- *  - Use new 2.3.x cache coherent PCI DMA routines instead of virt_to_bus.
- *  - Make the thing big endian compatible. ALSA has it done.
+ *  - 2001/11/29 ac97_save_state
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
@@ -155,7 +165,7 @@
 			schedule_timeout(1);
 		}
 	} while (end_time - (signed long)jiffies >= 0);
-	printk("ymfpci_codec_ready: codec %i is not ready [0x%x]\n",
+	printk(KERN_ERR "ymfpci_codec_ready: codec %i is not ready [0x%x]\n",
 	    secondary, ymfpci_readw(codec, reg));
 	return -EBUSY;
 }
@@ -173,19 +183,19 @@
 
 static u16 ymfpci_codec_read(struct ac97_codec *dev, u8 reg)
 {
-	ymfpci_t *codec = dev->private_data;
+	ymfpci_t *unit = dev->private_data;
+	int i;
 
-	if (ymfpci_codec_ready(codec, 0, 0))
+	if (ymfpci_codec_ready(unit, 0, 0))
 		return ~0;
-	ymfpci_writew(codec, YDSXGR_AC97CMDADR, YDSXG_AC97READCMD | reg);
-	if (ymfpci_codec_ready(codec, 0, 0))
+	ymfpci_writew(unit, YDSXGR_AC97CMDADR, YDSXG_AC97READCMD | reg);
+	if (ymfpci_codec_ready(unit, 0, 0))
 		return ~0;
-	if (codec->pci->device == PCI_DEVICE_ID_YAMAHA_744 && codec->rev < 2) {
-		int i;
+	if (unit->pci->device == PCI_DEVICE_ID_YAMAHA_744 && unit->rev < 2) {
 		for (i = 0; i < 600; i++)
-			ymfpci_readw(codec, YDSXGR_PRISTATUSDATA);
+			ymfpci_readw(unit, YDSXGR_PRISTATUSDATA);
 	}
-	return ymfpci_readw(codec, YDSXGR_PRISTATUSDATA);
+	return ymfpci_readw(unit, YDSXGR_PRISTATUSDATA);
 }
 
 /*
@@ -279,18 +289,22 @@
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
 
@@ -301,6 +315,7 @@
 
 	dmabuf->ready  = dmabuf->mapped = 0;
 	dmabuf->rawbuf = rawbuf;
+	dmabuf->dma_addr = dma_addr;
 	dmabuf->buforder = order;
 
 	/* now mark the pages as reserved; otherwise remap_page_range doesn't do what we want */
@@ -311,8 +326,10 @@
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
 
@@ -321,7 +338,9 @@
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
@@ -347,7 +366,7 @@
 
 	/* allocate DMA buffer if not allocated yet */
 	if (!dmabuf->rawbuf)
-		if ((ret = alloc_dmabuf(dmabuf)))
+		if ((ret = alloc_dmabuf(state->unit, dmabuf)))
 			return ret;
 
 	/*
@@ -404,7 +423,7 @@
 	dmabuf->ready = 1;
 
 #if 0
-	printk("prog_dmabuf: rate %d format 0x%x,"
+	printk(KERN_DEBUG "prog_dmabuf: rate %d format 0x%x,"
 	    " numfrag %d fragsize %d dmasize %d\n",
 	       state->format.rate, state->format.format, dmabuf->numfrag,
 	       dmabuf->fragsize, dmabuf->dmasize);
@@ -587,7 +606,8 @@
 	if (ypcm->running) {
 		YMFDBGI("ymfpci: %d, intr bank %d count %d start 0x%x:%x\n",
 		   voice->number, codec->active_bank, dmabuf->count,
-		   voice->bank[0].start, voice->bank[1].start);
+		   le32_to_cpu(voice->bank[0].start),
+		   le32_to_cpu(voice->bank[1].start));
 		silence = (ymf_pcm_format_width(state->format.format) == 16) ?
 		    0 : 0x80;
 		/* We need actual left-hand-side redzone size here. */
@@ -595,7 +615,7 @@
 		redzone <<= (state->format.shift + 1);
 		swptr = dmabuf->swptr;
 
-		pos = voice->bank[codec->active_bank].start;
+		pos = le32_to_cpu(voice->bank[codec->active_bank].start);
 		pos <<= state->format.shift;
 		if (pos < 0 || pos >= dmabuf->dmasize) {	/* ucode bug */
 			printk(KERN_ERR "ymfpci%d: runaway voice %d: hwptr %d=>%d dmasize %d\n",
@@ -615,7 +635,7 @@
 		dmabuf->hwptr = pos;
 
 		if (dmabuf->count == 0) {
-			printk("ymfpci%d: %d: strain: hwptr %d\n",
+			printk(KERN_ERR "ymfpci%d: %d: strain: hwptr %d\n",
 			    codec->dev_audio, voice->number, dmabuf->hwptr);
 			ymf_playback_trigger(codec, ypcm, 0);
 		}
@@ -633,7 +653,7 @@
 				/*
 				 * Lost interrupt or other screwage.
 				 */
-				printk("ymfpci%d: %d: lost: delta %d"
+				printk(KERN_ERR "ymfpci%d: %d: lost: delta %d"
 				    " hwptr %d swptr %d distance %d count %d\n",
 				    codec->dev_audio, voice->number, delta,
 				    dmabuf->hwptr, swptr, distance, dmabuf->count);
@@ -641,10 +661,10 @@
 				/*
 				 * Normal end of DMA.
 				 */
-//				printk("ymfpci%d: %d: done: delta %d"
-//				    " hwptr %d swptr %d distance %d count %d\n",
-//				    codec->dev_audio, voice->number, delta,
-//				    dmabuf->hwptr, swptr, distance, dmabuf->count);
+				YMFDBGI("ymfpci%d: %d: done: delta %d"
+				    " hwptr %d swptr %d distance %d count %d\n",
+				    codec->dev_audio, voice->number, delta,
+				    dmabuf->hwptr, swptr, distance, dmabuf->count);
 			}
 			played = dmabuf->count;
 			if (ypcm->running) {
@@ -698,7 +718,7 @@
 		redzone = ymf_calc_lend(state->format.rate);
 		redzone <<= (state->format.shift + 1);
 
-		pos = cap->bank[unit->active_bank].start;
+		pos = le32_to_cpu(cap->bank[unit->active_bank].start);
 		// pos <<= state->format.shift;
 		if (pos < 0 || pos >= dmabuf->dmasize) {	/* ucode bug */
 			printk(KERN_ERR "ymfpci%d: runaway capture %d: hwptr %d=>%d dmasize %d\n",
@@ -742,9 +762,11 @@
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
@@ -810,6 +832,7 @@
 	u32 lpfK = ymfpci_calc_lpfK(rate);
 	ymfpci_playback_bank_t *bank;
 	int nbank;
+	unsigned le_0x40000000 = 0x40;
 
 	format = (stereo ? 0x00010000 : 0) | (w_16 ? 0 : 0x80000000);
 	if (stereo)
@@ -818,24 +841,24 @@
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
 
@@ -855,31 +878,31 @@
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
@@ -920,7 +943,7 @@
 		ymf_pcm_init_voice(ypcm->voices[nvoice],
 		    state->format.voices == 2, state->format.rate,
 		    ymf_pcm_format_width(state->format.format) == 16,
-		    virt_to_bus(ypcm->dmabuf.rawbuf), ypcm->dmabuf.dmasize,
+		    ypcm->dmabuf.dma_addr, ypcm->dmabuf.dmasize,
 		    ypcm->spdif);
 	}
 	return 0;
@@ -969,9 +992,9 @@
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
@@ -1442,13 +1465,14 @@
 {
 	struct ymf_state *state = (struct ymf_state *)file->private_data;
 	struct ymf_dmabuf *dmabuf;
+	int redzone;
 	unsigned long flags;
 	unsigned int mask = 0;
 
 	if (file->f_mode & FMODE_WRITE)
 		poll_wait(file, &state->wpcm.dmabuf.wait, wait);
-	// if (file->f_mode & FMODE_READ)
-	// 	poll_wait(file, &dmabuf->wait, wait);
+	if (file->f_mode & FMODE_READ)
+		poll_wait(file, &state->rpcm.dmabuf.wait, wait);
 
 	spin_lock_irqsave(&state->unit->reg_lock, flags);
 	if (file->f_mode & FMODE_READ) {
@@ -1457,12 +1481,21 @@
 			mask |= POLLIN | POLLRDNORM;
 	}
 	if (file->f_mode & FMODE_WRITE) {
+		redzone = ymf_calc_lend(state->format.rate);
+		redzone <<= state->format.shift;
+		redzone *= 3;
+
 		dmabuf = &state->wpcm.dmabuf;
 		if (dmabuf->mapped) {
 			if (dmabuf->count >= (signed)dmabuf->fragsize)
 				mask |= POLLOUT | POLLWRNORM;
 		} else {
-			if ((signed)dmabuf->dmasize >= dmabuf->count + (signed)dmabuf->fragsize)
+			/*
+			 * Don't select unless a full fragment is available.
+			 * Otherwise artsd does GETOSPACE, sees 0, and loops.
+			 */
+			if (dmabuf->count + redzone + dmabuf->fragsize
+			     <= dmabuf->dmasize)
 				mask |= POLLOUT | POLLWRNORM;
 		}
 	}
@@ -1497,6 +1530,7 @@
 		return -EAGAIN;
 	dmabuf->mapped = 1;
 
+/* P3 */ printk(KERN_INFO "ymfpci: using memory mapped sound, untested!\n");
 	return 0;
 }
 
@@ -1508,13 +1542,16 @@
 	unsigned long flags;
 	audio_buf_info abinfo;
 	count_info cinfo;
+	int redzone;
 	int val;
 
 	switch (cmd) {
 	case OSS_GETVERSION:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(GETVER) arg 0x%lx\n", cmd, arg);
 		return put_user(SOUND_VERSION, (int *)arg);
 
 	case SNDCTL_DSP_RESET:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(RESET)\n", cmd);
 		if (file->f_mode & FMODE_WRITE) {
 			ymf_wait_dac(state);
 			dmabuf = &state->wpcm.dmabuf;
@@ -1536,6 +1573,7 @@
 		return 0;
 
 	case SNDCTL_DSP_SYNC:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(SYNC)\n", cmd);
 		if (file->f_mode & FMODE_WRITE) {
 			dmabuf = &state->wpcm.dmabuf;
 			if (file->f_flags & O_NONBLOCK) {
@@ -1554,6 +1592,7 @@
 	case SNDCTL_DSP_SPEED: /* set smaple rate */
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
+		YMFDBGX("ymf_ioctl: cmd 0x%x(SPEED) sp %d\n", cmd, val);
 		if (val >= 8000 && val <= 48000) {
 			if (file->f_mode & FMODE_WRITE) {
 				ymf_wait_dac(state);
@@ -1585,6 +1624,7 @@
 	case SNDCTL_DSP_STEREO: /* set stereo or mono channel */
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
+		YMFDBGX("ymf_ioctl: cmd 0x%x(STEREO) st %d\n", cmd, val);
 		if (file->f_mode & FMODE_WRITE) {
 			ymf_wait_dac(state); 
 			dmabuf = &state->wpcm.dmabuf;
@@ -1606,24 +1646,31 @@
 		return 0;
 
 	case SNDCTL_DSP_GETBLKSIZE:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(GETBLK)\n", cmd);
 		if (file->f_mode & FMODE_WRITE) {
 			if ((val = prog_dmabuf(state, 0)))
 				return val;
-			return put_user(state->wpcm.dmabuf.fragsize, (int *)arg);
+			val = state->wpcm.dmabuf.fragsize;
+			YMFDBGX("ymf_ioctl: GETBLK w %d\n", val);
+			return put_user(val, (int *)arg);
 		}
 		if (file->f_mode & FMODE_READ) {
 			if ((val = prog_dmabuf(state, 1)))
 				return val;
-			return put_user(state->rpcm.dmabuf.fragsize, (int *)arg);
+			val = state->rpcm.dmabuf.fragsize;
+			YMFDBGX("ymf_ioctl: GETBLK r %d\n", val);
+			return put_user(val, (int *)arg);
 		}
 		return -EINVAL;
 
 	case SNDCTL_DSP_GETFMTS: /* Returns a mask of supported sample format*/
+		YMFDBGX("ymf_ioctl: cmd 0x%x(GETFMTS)\n", cmd);
 		return put_user(AFMT_S16_LE|AFMT_U8, (int *)arg);
 
 	case SNDCTL_DSP_SETFMT: /* Select sample format */
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
+		YMFDBGX("ymf_ioctl: cmd 0x%x(SETFMT) fmt %d\n", cmd, val);
 		if (val == AFMT_S16_LE || val == AFMT_U8) {
 			if (file->f_mode & FMODE_WRITE) {
 				ymf_wait_dac(state);
@@ -1649,6 +1696,7 @@
 	case SNDCTL_DSP_CHANNELS:
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
+		YMFDBGX("ymf_ioctl: cmd 0x%x(CHAN) ch %d\n", cmd, val);
 		if (val != 0) {
 			if (file->f_mode & FMODE_WRITE) {
 				ymf_wait_dac(state);
@@ -1676,6 +1724,7 @@
 		return put_user(state->format.voices, (int *)arg);
 
 	case SNDCTL_DSP_POST:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(POST)\n", cmd);
 		/*
 		 * Quoting OSS PG:
 		 *    The ioctl SNDCTL_DSP_POST is a lightweight version of
@@ -1697,6 +1746,10 @@
 	case SNDCTL_DSP_SETFRAGMENT:
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
+		YMFDBGX("ymf_ioctl: cmd 0x%x(SETFRAG) fr 0x%04x:%04x(%d:%d)\n",
+		    cmd,
+		    (val >> 16) & 0xFFFF, val & 0xFFFF,
+		    (val >> 16) & 0xFFFF, val & 0xFFFF);
 		dmabuf = &state->wpcm.dmabuf;
 		dmabuf->ossfragshift = val & 0xffff;
 		dmabuf->ossmaxfrags = (val >> 16) & 0xffff;
@@ -1707,20 +1760,25 @@
 		return 0;
 
 	case SNDCTL_DSP_GETOSPACE:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(GETOSPACE)\n", cmd);
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
 		dmabuf = &state->wpcm.dmabuf;
 		if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0)
 			return val;
+		redzone = ymf_calc_lend(state->format.rate);
+		redzone <<= state->format.shift;
+		redzone *= 3;
 		spin_lock_irqsave(&state->unit->reg_lock, flags);
 		abinfo.fragsize = dmabuf->fragsize;
-		abinfo.bytes = dmabuf->dmasize - dmabuf->count;
+		abinfo.bytes = dmabuf->dmasize - dmabuf->count - redzone;
 		abinfo.fragstotal = dmabuf->numfrag;
 		abinfo.fragments = abinfo.bytes >> dmabuf->fragshift;
 		spin_unlock_irqrestore(&state->unit->reg_lock, flags);
 		return copy_to_user((void *)arg, &abinfo, sizeof(abinfo)) ? -EFAULT : 0;
 
 	case SNDCTL_DSP_GETISPACE:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(GETISPACE)\n", cmd);
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
 		dmabuf = &state->rpcm.dmabuf;
@@ -1735,15 +1793,18 @@
 		return copy_to_user((void *)arg, &abinfo, sizeof(abinfo)) ? -EFAULT : 0;
 
 	case SNDCTL_DSP_NONBLOCK:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(NONBLOCK)\n", cmd);
 		file->f_flags |= O_NONBLOCK;
 		return 0;
 
 	case SNDCTL_DSP_GETCAPS:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(GETCAPS)\n", cmd);
 		/* return put_user(DSP_CAP_REALTIME|DSP_CAP_TRIGGER|DSP_CAP_MMAP,
 			    (int *)arg); */
 		return put_user(0, (int *)arg);
 
 	case SNDCTL_DSP_GETIPTR:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(GETIPTR)\n", cmd);
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
 		dmabuf = &state->rpcm.dmabuf;
@@ -1751,13 +1812,13 @@
 		cinfo.bytes = dmabuf->total_bytes;
 		cinfo.blocks = dmabuf->count >> dmabuf->fragshift;
 		cinfo.ptr = dmabuf->hwptr;
-		/* XXX fishy - breaks invariant  count=hwptr-swptr */
-		if (dmabuf->mapped)
-			dmabuf->count &= dmabuf->fragsize-1;
 		spin_unlock_irqrestore(&state->unit->reg_lock, flags);
+		YMFDBGX("ymf_ioctl: GETIPTR ptr %d bytes %d\n",
+		    cinfo.ptr, cinfo.bytes);
 		return copy_to_user((void *)arg, &cinfo, sizeof(cinfo)) ? -EFAULT : 0;
 
 	case SNDCTL_DSP_GETOPTR:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(GETOPTR)\n", cmd);
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
 		dmabuf = &state->wpcm.dmabuf;
@@ -1765,22 +1826,25 @@
 		cinfo.bytes = dmabuf->total_bytes;
 		cinfo.blocks = dmabuf->count >> dmabuf->fragshift;
 		cinfo.ptr = dmabuf->hwptr;
-		/* XXX fishy - breaks invariant  count=swptr-hwptr */
-		if (dmabuf->mapped)
-			dmabuf->count &= dmabuf->fragsize-1;
 		spin_unlock_irqrestore(&state->unit->reg_lock, flags);
+		YMFDBGX("ymf_ioctl: GETOPTR ptr %d bytes %d\n",
+		    cinfo.ptr, cinfo.bytes);
 		return copy_to_user((void *)arg, &cinfo, sizeof(cinfo)) ? -EFAULT : 0;
 
-	case SNDCTL_DSP_SETDUPLEX:	/* XXX TODO */
-		return -EINVAL;
+	case SNDCTL_DSP_SETDUPLEX:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(SETDUPLEX)\n", cmd);
+		return 0;		/* Always duplex */
 
 	case SOUND_PCM_READ_RATE:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(READ_RATE)\n", cmd);
 		return put_user(state->format.rate, (int *)arg);
 
 	case SOUND_PCM_READ_CHANNELS:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(READ_CH)\n", cmd);
 		return put_user(state->format.voices, (int *)arg);
 
 	case SOUND_PCM_READ_BITS:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(READ_BITS)\n", cmd);
 		return put_user(AFMT_S16_LE, (int *)arg);
 
 	case SNDCTL_DSP_MAPINBUF:
@@ -1796,6 +1860,7 @@
 		 * Some programs mix up audio devices and ioctls
 		 * or perhaps they expect "universal" ioctls,
 		 * for instance we get SNDCTL_TMR_CONTINUE here.
+		 * (mpg123 -g 100 ends here too - to be fixed.)
 		 */
 		YMFDBGX("ymf_ioctl: cmd 0x%x unknown\n", cmd);
 		break;
@@ -1866,8 +1931,8 @@
 	}
 
 #if 0 /* test if interrupts work */
-	ymfpci_writew(codec, YDSXGR_TIMERCOUNT, 0xfffe);	/* ~ 680ms */
-	ymfpci_writeb(codec, YDSXGR_TIMERCTRL,
+	ymfpci_writew(unit, YDSXGR_TIMERCOUNT, 0xfffe);	/* ~ 680ms */
+	ymfpci_writeb(unit, YDSXGR_TIMERCTRL,
 	    (YDSXGR_TIMERCTRL_TEN|YDSXGR_TIMERCTRL_TIEN));
 #endif
 	up(&unit->open_sem);
@@ -1880,8 +1945,8 @@
 	 * a nestable exception, but here it is not nestable due to semaphore.
 	 * XXX Doubtful technique of self-describing objects....
 	 */
-	dealloc_dmabuf(&state->wpcm.dmabuf);
-	dealloc_dmabuf(&state->rpcm.dmabuf);
+	dealloc_dmabuf(unit, &state->wpcm.dmabuf);
+	dealloc_dmabuf(unit, &state->rpcm.dmabuf);
 	ymf_pcm_free_substream(&state->wpcm);
 	ymf_pcm_free_substream(&state->rpcm);
 
@@ -1895,13 +1960,13 @@
 static int ymf_release(struct inode *inode, struct file *file)
 {
 	struct ymf_state *state = (struct ymf_state *)file->private_data;
-	ymfpci_t *codec = state->unit;
+	ymfpci_t *unit = state->unit;
 
 #if 0 /* test if interrupts work */
-	ymfpci_writeb(codec, YDSXGR_TIMERCTRL, 0);
+	ymfpci_writeb(unit, YDSXGR_TIMERCTRL, 0);
 #endif
 
-	down(&codec->open_sem);
+	down(&unit->open_sem);
 
 	/*
 	 * XXX Solve the case of O_NONBLOCK close - don't deallocate here.
@@ -1909,8 +1974,8 @@
 	 */
 	ymf_wait_dac(state);
 	ymf_stop_adc(state);		/* fortunately, it's immediate */
-	dealloc_dmabuf(&state->wpcm.dmabuf);
-	dealloc_dmabuf(&state->rpcm.dmabuf);
+	dealloc_dmabuf(unit, &state->wpcm.dmabuf);
+	dealloc_dmabuf(unit, &state->rpcm.dmabuf);
 	ymf_pcm_free_substream(&state->wpcm);
 	ymf_pcm_free_substream(&state->rpcm);
 
@@ -1918,7 +1983,7 @@
 	file->private_data = NULL;	/* Can you tell I programmed Solaris */
 	kfree(state);
 
-	up(&codec->open_sem);
+	up(&unit->open_sem);
 
 	return 0;
 }
@@ -1928,10 +1993,10 @@
  */
 static int ymf_open_mixdev(struct inode *inode, struct file *file)
 {
-	int i;
 	int minor = minor(inode->i_rdev);
 	struct list_head *list;
 	ymfpci_t *unit;
+	int i;
 
 	list_for_each(list, &ymf_devs) {
 		unit = list_entry(list, ymfpci_t, ymf_devs);
@@ -1988,23 +2053,21 @@
 
 static int ymf_suspend(struct pci_dev *pcidev, u32 unused)
 {
-	int i;
 	struct ymf_unit *unit = pci_get_drvdata(pcidev);
 	unsigned long flags;
 	struct ymf_dmabuf *dmabuf;
 	struct list_head *p;
 	struct ymf_state *state;
 	struct ac97_codec *codec;
+	int i;
 
 	spin_lock_irqsave(&unit->reg_lock, flags);
 
 	unit->suspended = 1;
 
 	for (i = 0; i < NR_AC97; i++) {
-		codec = unit->ac97_codec[i];
-		if (!codec)
-			continue;
-		ac97_save_state(codec);
+		if ((codec = unit->ac97_codec[i]) != NULL)
+			ac97_save_state(codec);
 	}
 
 	list_for_each(p, &unit->states) {
@@ -2031,12 +2094,12 @@
 
 static int ymf_resume(struct pci_dev *pcidev)
 {
-	int i;
 	struct ymf_unit *unit = pci_get_drvdata(pcidev);
 	unsigned long flags;
 	struct list_head *p;
 	struct ymf_state *state;
 	struct ac97_codec *codec;
+	int i;
 
 	ymfpci_aclink_reset(unit->pci);
 	ymfpci_codec_ready(unit, 0, 1);		/* prints diag if not ready. */
@@ -2057,10 +2120,8 @@
 	}
 
 	for (i = 0; i < NR_AC97; i++) {
-		codec = unit->ac97_codec[i];
-		if (!codec)
-			continue;
-		ac97_restore_state(codec);
+		if ((codec = unit->ac97_codec[i]) != NULL)
+			ac97_restore_state(codec);
 	}
 
 	unit->suspended = 0;
@@ -2160,12 +2221,15 @@
 {
 	u8 cmd;
 
+	/*
+	 * In the 744, 754 only 0x01 exists, 0x02 is undefined.
+	 * It does not seem to hurt to trip both regardless of revision.
+	 */
 	pci_read_config_byte(pci, PCIR_DSXGCTRL, &cmd);
-	if (cmd & 0x03) {
-		pci_write_config_byte(pci, PCIR_DSXGCTRL, cmd & 0xfc);
-		pci_write_config_byte(pci, PCIR_DSXGCTRL, cmd | 0x03);
-		pci_write_config_byte(pci, PCIR_DSXGCTRL, cmd & 0xfc);
-	}
+	pci_write_config_byte(pci, PCIR_DSXGCTRL, cmd & 0xfc);
+	pci_write_config_byte(pci, PCIR_DSXGCTRL, cmd | 0x03);
+	pci_write_config_byte(pci, PCIR_DSXGCTRL, cmd & 0xfc);
+
 	pci_write_config_word(pci, PCIR_DSXPWRCTRL1, 0);
 	pci_write_config_word(pci, PCIR_DSXPWRCTRL2, 0);
 }
@@ -2241,29 +2305,39 @@
 
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
@@ -2271,34 +2345,49 @@
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
@@ -2310,16 +2399,17 @@
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
@@ -2357,7 +2447,7 @@
 	codec->codec_write = ymfpci_codec_write;
 
 	if (ac97_probe_codec(codec) == 0) {
-		printk("ymfpci: ac97_probe_codec failed\n");
+		printk(KERN_ERR "ymfpci: ac97_probe_codec failed\n");
 		goto out_kfree;
 	}
 
@@ -2398,6 +2488,7 @@
 static int __devinit ymf_probe_one(struct pci_dev *pcidev, const struct pci_device_id *ent)
 {
 	u16 ctrl;
+	unsigned long base;
 	ymfpci_t *codec;
 
 	int err;
@@ -2406,6 +2497,7 @@
 		printk(KERN_ERR "ymfpci: pci_enable_device failed\n");
 		return err;
 	}
+	base = pci_resource_start(pcidev, 0);
 
 	if ((codec = kmalloc(sizeof(ymfpci_t), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "ymfpci: no core\n");
@@ -2420,16 +2512,21 @@
 	codec->pci = pcidev;
 
 	pci_read_config_byte(pcidev, PCI_REVISION_ID, &codec->rev);
-	codec->reg_area_virt = ioremap(pci_resource_start(pcidev, 0), 0x8000);
-	if (codec->reg_area_virt == NULL) {
-		printk(KERN_ERR "ymfpci: unable to map registers\n");
+
+	if (request_mem_region(base, 0x8000, "ymfpci") == NULL) {
+		printk(KERN_ERR "ymfpci: unable to request mem region\n");
 		goto out_free;
 	}
 
+	if ((codec->reg_area_virt = ioremap(base, 0x8000)) == NULL) {
+		printk(KERN_ERR "ymfpci: unable to map registers\n");
+		goto out_release_region;
+	}
+
 	pci_set_master(pcidev);
 
 	printk(KERN_INFO "ymfpci: %s at 0x%lx IRQ %d\n",
-	    (char *)ent->driver_data, pci_resource_start(pcidev, 0), pcidev->irq);
+	    (char *)ent->driver_data, base, pcidev->irq);
 
 	ymfpci_aclink_reset(pcidev);
 	if (ymfpci_codec_ready(codec, 0, 1) < 0)
@@ -2459,8 +2556,7 @@
 
 	/* register /dev/dsp */
 	if ((codec->dev_audio = register_sound_dsp(&ymf_fops, -1)) < 0) {
-		printk(KERN_ERR "ymfpci%d: unable to register dsp\n",
-		    codec->dev_audio);
+		printk(KERN_ERR "ymfpci: unable to register dsp\n");
 		goto out_free_irq;
 	}
 
@@ -2478,7 +2574,7 @@
 	codec->opl3_data.irq     = -1;
 
 	codec->mpu_data.io_base  = codec->iomidi;
-	codec->mpu_data.irq      = -1;	/* XXX Make it ours. */
+	codec->mpu_data.irq      = -1;	/* May be different from our PCI IRQ. */
 
 	if (codec->iomidi) {
 		if (!probe_uart401(&codec->mpu_data, THIS_MODULE)) {
@@ -2506,6 +2602,8 @@
 	ymfpci_writel(codec, YDSXGR_STATUS, ~0);
  out_unmap:
 	iounmap(codec->reg_area_virt);
+ out_release_region:
+	release_mem_region(pci_resource_start(pcidev, 0), 0x8000);
  out_free:
 	kfree(codec);
 	return -ENODEV;
@@ -2529,6 +2627,7 @@
 	ctrl = ymfpci_readw(codec, YDSXGR_GLOBALCTRL);
 	ymfpci_writew(codec, YDSXGR_GLOBALCTRL, ctrl & ~0x0007);
 	iounmap(codec->reg_area_virt);
+	release_mem_region(pci_resource_start(pcidev, 0), 0x8000);
 #ifdef CONFIG_SOUND_YMFPCI_LEGACY
 	if (codec->iomidi) {
 		unload_uart401(&codec->mpu_data);
diff -ur -X dontdiff linux-2.5.2-pre11/drivers/sound/ymfpci.h linux-2.5.2-pre11-p3/drivers/sound/ymfpci.h
--- linux-2.5.2-pre11/drivers/sound/ymfpci.h	Sun Aug 12 10:51:42 2001
+++ linux-2.5.2-pre11-p3/drivers/sound/ymfpci.h	Thu Jan 10 21:29:19 2002
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
 
