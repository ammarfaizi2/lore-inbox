Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263844AbTCUTAr>; Fri, 21 Mar 2003 14:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262726AbTCUTAc>; Fri, 21 Mar 2003 14:00:32 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36996
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263827AbTCUS4v>; Fri, 21 Mar 2003 13:56:51 -0500
Date: Fri, 21 Mar 2003 20:12:00 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212012.h2LKC0vt026316@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: update emu10k1 driver (SB Live, Audigy etc)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/audio.c linux-2.5.65-ac2/sound/oss/emu10k1/audio.c
--- linux-2.5.65/sound/oss/emu10k1/audio.c	2003-02-10 18:37:58.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/audio.c	2003-03-14 00:52:26.000000000 +0000
@@ -30,7 +30,6 @@
  **********************************************************************
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
@@ -983,11 +982,11 @@
 	unsigned long pgoff;
 	int rd, wr;
 
-	DPF(4, "emu10k1_mm_nopage()\n");
-	DPD(4, "addr: %#lx\n", address);
+	DPF(3, "emu10k1_mm_nopage()\n");
+	DPD(3, "addr: %#lx\n", address);
 
 	if (address > vma->vm_end) {
-		DPF(2, "EXIT, returning NOPAGE_SIGBUS\n");
+		DPF(1, "EXIT, returning NOPAGE_SIGBUS\n");
 		return NOPAGE_SIGBUS; /* Disallow mremap */
 	}
 
@@ -1009,14 +1008,14 @@
 			pgoff -= woinst->buffer.pages;
 			dmapage = virt_to_page ((u8 *) wiinst->buffer.addr + pgoff * PAGE_SIZE);
 		} else
-			dmapage = virt_to_page (woinst->buffer.mem[0].addr[pgoff]);
+			dmapage = virt_to_page (woinst->voice[0].mem.addr[pgoff]);
 	} else {
 		dmapage = virt_to_page ((u8 *) wiinst->buffer.addr + pgoff * PAGE_SIZE);
 	}
 
 	get_page (dmapage);
 
-	DPD(4, "page: %#lx\n", dmapage);
+	DPD(3, "page: %#lx\n", (unsigned long) dmapage);
 	return dmapage;
 }
 
@@ -1083,8 +1082,8 @@
 	n_pages = ((vma->vm_end - vma->vm_start) + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	pgoffset = vma->vm_pgoff;
 
-	DPD(3, "vma_start: %#lx, vma_end: %#lx, vma_offset: %d\n", vma->vm_start, vma->vm_end, pgoffset);
-	DPD(3, "n_pages: %d, max_pages: %d\n", n_pages, max_pages);
+	DPD(2, "vma_start: %#lx, vma_end: %#lx, vma_offset: %ld\n", vma->vm_start, vma->vm_end, pgoffset);
+	DPD(2, "n_pages: %ld, max_pages: %ld\n", n_pages, max_pages);
 
 	if (pgoffset + n_pages > max_pages)
 		return -EINVAL;
@@ -1092,7 +1091,6 @@
 	vma->vm_flags |= VM_RESERVED;
 	vma->vm_ops = &emu10k1_mm_ops;
 	vma->vm_private_data = wave_dev;
-
 	return 0;
 }
 
@@ -1136,7 +1134,8 @@
 
 		if ((wiinst = (struct wiinst *) kmalloc(sizeof(struct wiinst), GFP_KERNEL)) == NULL) {
 			ERROR();
-			return -ENODEV;
+			kfree(wave_dev);
+			return -ENOMEM;
 		}
 
 		wiinst->recsrc = card->wavein.recsrc;
@@ -1162,6 +1161,8 @@
 			wiinst->format.channels = hweight32(wiinst->fxwc);
 			break;
 		default:
+			kfree(wave_dev);
+			kfree(wiinst);
 			BUG();
 			break;
 		}
@@ -1211,7 +1212,7 @@
 		woinst->num_voices = 1;
 		for (i = 0; i < WAVEOUT_MAXVOICES; i++) {
 			woinst->voice[i].usage = VOICE_USAGE_FREE;
-			woinst->buffer.mem[i].emupageindex = -1;
+			woinst->voice[i].mem.emupageindex = -1;
 		}
 
 		init_waitqueue_head(&woinst->wait_queue);
@@ -1330,23 +1331,13 @@
 	if (file->f_mode & FMODE_READ) {
 		spin_lock_irqsave(&wiinst->lock, flags);
 
-		if (wiinst->state == WAVE_STATE_CLOSED) {
-			calculate_ifrag(wiinst);
-			if (emu10k1_wavein_open(wave_dev) < 0) {
-				spin_unlock_irqrestore(&wiinst->lock, flags);
-				return (mask |= POLLERR);
-			}
-		}
+		if (wiinst->state & WAVE_STATE_OPEN) {
+			emu10k1_wavein_update(wave_dev->card, wiinst);
+			emu10k1_wavein_getxfersize(wiinst, &bytestocopy);
 
-		if (!(wiinst->state & WAVE_STATE_STARTED)) {
-			wave_dev->enablebits |= PCM_ENABLE_INPUT;
-			emu10k1_wavein_start(wave_dev);
+			if (bytestocopy >= wiinst->buffer.fragment_size)
+				mask |= POLLIN | POLLRDNORM;
 		}
-		emu10k1_wavein_update(wave_dev->card, wiinst);
-		emu10k1_wavein_getxfersize(wiinst, &bytestocopy);
-
-		if (bytestocopy >= wiinst->buffer.fragment_size)
-			mask |= POLLIN | POLLRDNORM;
 
 		spin_unlock_irqrestore(&wiinst->lock, flags);
 	}
@@ -1376,6 +1367,13 @@
 
 	buffer->fragment_size = 1 << buffer->ossfragshift;
 
+	while (buffer->fragment_size * WAVEOUT_MINFRAGS > WAVEOUT_MAXBUFSIZE)
+		buffer->fragment_size >>= 1;
+
+	/* now we are sure that:
+	 (2^WAVEOUT_MINFRAGSHIFT) <= (fragment_size = 2^n) <= (WAVEOUT_MAXBUFSIZE / WAVEOUT_MINFRAGS)
+	*/
+
 	if (!buffer->numfrags) {
 		u32 numfrags;
 
@@ -1390,19 +1388,14 @@
 		}
 	}
 
-	if (buffer->numfrags < MINFRAGS)
-		buffer->numfrags = MINFRAGS;
+	if (buffer->numfrags < WAVEOUT_MINFRAGS)
+		buffer->numfrags = WAVEOUT_MINFRAGS;
 
-	if (buffer->numfrags * buffer->fragment_size > WAVEOUT_MAXBUFSIZE) {
+	if (buffer->numfrags * buffer->fragment_size > WAVEOUT_MAXBUFSIZE)
 		buffer->numfrags = WAVEOUT_MAXBUFSIZE / buffer->fragment_size;
 
-		if (buffer->numfrags < MINFRAGS) {
-			buffer->numfrags = MINFRAGS;
-			buffer->fragment_size = WAVEOUT_MAXBUFSIZE / MINFRAGS;
-		}
-
-	} else if (buffer->numfrags * buffer->fragment_size < WAVEOUT_MINBUFSIZE)
-		buffer->numfrags = WAVEOUT_MINBUFSIZE / buffer->fragment_size;
+	if (buffer->numfrags < WAVEOUT_MINFRAGS)
+		BUG();
 
 	buffer->size = buffer->fragment_size * buffer->numfrags;
 	buffer->pages = buffer->size / PAGE_SIZE + ((buffer->size % PAGE_SIZE) ? 1 : 0);
@@ -1436,24 +1429,29 @@
 
 	buffer->fragment_size = 1 << buffer->ossfragshift;
 
+	while (buffer->fragment_size * WAVEIN_MINFRAGS > WAVEIN_MAXBUFSIZE)
+		buffer->fragment_size >>= 1;
+
+	/* now we are sure that:
+	   (2^WAVEIN_MINFRAGSHIFT) <= (fragment_size = 2^n) <= (WAVEIN_MAXBUFSIZE / WAVEIN_MINFRAGS)
+        */
+
+
 	if (!buffer->numfrags)
 		buffer->numfrags = (wiinst->format.bytespersec * WAVEIN_DEFAULTBUFLEN) / (buffer->fragment_size * 1000) - 1;
 
-	if (buffer->numfrags < MINFRAGS)
-		buffer->numfrags = MINFRAGS;
+	if (buffer->numfrags < WAVEIN_MINFRAGS)
+		buffer->numfrags = WAVEIN_MINFRAGS;
 
-	if (buffer->numfrags * buffer->fragment_size > WAVEIN_MAXBUFSIZE) {
+	if (buffer->numfrags * buffer->fragment_size > WAVEIN_MAXBUFSIZE)
 		buffer->numfrags = WAVEIN_MAXBUFSIZE / buffer->fragment_size;
 
-		if (buffer->numfrags < MINFRAGS) {
-			buffer->numfrags = MINFRAGS;
-			buffer->fragment_size = WAVEIN_MAXBUFSIZE / MINFRAGS;
-		}
-	} else if (buffer->numfrags * buffer->fragment_size < WAVEIN_MINBUFSIZE)
-		buffer->numfrags = WAVEIN_MINBUFSIZE / buffer->fragment_size;
+	if (buffer->numfrags < WAVEIN_MINFRAGS)
+		BUG();
 
 	bufsize = buffer->fragment_size * buffer->numfrags;
 
+	/* the buffer size for recording is restricted to certain values, adjust it now */
 	if (bufsize >= 0x10000) {
 		buffer->size = 0x10000;
 		buffer->sizeregval = 0x1f;
@@ -1479,10 +1477,12 @@
 		}
 	}
 
+	/* adjust the fragment size so that buffer size is an integer multiple */
+	while (buffer->size % buffer->fragment_size)
+		buffer->fragment_size >>= 1;
+
 	buffer->numfrags = buffer->size / buffer->fragment_size;
 	buffer->pages =  buffer->size / PAGE_SIZE + ((buffer->size % PAGE_SIZE) ? 1 : 0);
-	if (buffer->size % buffer->fragment_size)
-		BUG();
 
 	DPD(2, " calculated recording fragment_size -> %d\n", buffer->fragment_size);
 	DPD(2, " calculated recording numfrags -> %d\n", buffer->numfrags);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/audio.h linux-2.5.65-ac2/sound/oss/emu10k1/audio.h
--- linux-2.5.65/sound/oss/emu10k1/audio.h	2003-02-10 18:38:54.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/audio.h	2003-02-17 00:30:06.000000000 +0000
@@ -33,8 +33,6 @@
 #ifndef _AUDIO_H
 #define _AUDIO_H
 
-#define MINFRAGS	2	/* _don't_ got bellow 2 */
-
 struct emu10k1_wavedevice
 {
         struct emu10k1_card *card;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/cardwi.c linux-2.5.65-ac2/sound/oss/emu10k1/cardwi.c
--- linux-2.5.65/sound/oss/emu10k1/cardwi.c	2003-02-10 18:38:44.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/cardwi.c	2003-02-17 00:30:06.000000000 +0000
@@ -96,6 +96,7 @@
 	wave_fmt->bytesperchannel = wave_fmt->bitsperchannel >> 3;
 	wave_fmt->bytespersample = wave_fmt->channels * wave_fmt->bytesperchannel;
 	wave_fmt->bytespersec = wave_fmt->bytespersample * wave_fmt->samplingrate;
+	wave_fmt->bytespervoicesample = wave_fmt->bytespersample;
 }
 
 static int alloc_buffer(struct emu10k1_card *card, struct wavein_buffer *buffer)
@@ -120,7 +121,7 @@
 	struct emu10k1_card *card = wave_dev->card;
 	struct wiinst *wiinst = wave_dev->wiinst;
 	struct wiinst **wiinst_tmp = NULL;
-	u32 delay;
+	u16 delay;
 	unsigned long flags;
 
 	DPF(2, "emu10k1_wavein_open()\n");
@@ -169,6 +170,12 @@
 
 	emu10k1_set_record_src(card, wiinst);
 
+	emu10k1_reset_record(card, &wiinst->buffer);
+
+	wiinst->buffer.hw_pos = 0;
+	wiinst->buffer.pos = 0;
+	wiinst->buffer.bytestocopy = 0;
+
 	delay = (48000 * wiinst->buffer.fragment_size) / wiinst->format.bytespersec;
 
 	emu10k1_timer_install(card, &wiinst->timer, delay / 2);
@@ -222,10 +229,6 @@
 	emu10k1_start_record(card, &wiinst->buffer);
 	emu10k1_timer_enable(wave_dev->card, &wiinst->timer);
 
-	wiinst->buffer.hw_pos = 0;
-	wiinst->buffer.pos = 0;
-	wiinst->buffer.bytestocopy = 0;
-
 	wiinst->state |= WAVE_STATE_STARTED;
 }
 
@@ -249,7 +252,7 @@
 {
 	struct emu10k1_card *card = wave_dev->card;
 	struct wiinst *wiinst = wave_dev->wiinst;
-	u32 delay;
+	u16 delay;
 
 	DPF(2, "emu10k1_wavein_setformat()\n");
 
@@ -304,10 +307,9 @@
 
 static void copy_block(u8 *dst, u8 * src, u32 str, u32 len, u8 cov)
 {
-	if (cov == 1) {
-		if (__copy_to_user(dst, src + str, len))
-			return;
-	} else {
+	if (cov == 1)
+		__copy_to_user(dst, src + str, len);
+	else {
 		u8 byte;
 		u32 i;
 
@@ -315,8 +317,7 @@
 
 		for (i = 0; i < len; i++) {
 			byte = src[2 * i] ^ 0x80;
-			if (__copy_to_user(dst + i, &byte, 1))
-				return;
+			__copy_to_user(dst + i, &byte, 1);
 		}
 	}
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/cardwi.h linux-2.5.65-ac2/sound/oss/emu10k1/cardwi.h
--- linux-2.5.65/sound/oss/emu10k1/cardwi.h	2003-02-10 18:38:53.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/cardwi.h	2003-02-17 00:30:06.000000000 +0000
@@ -69,13 +69,14 @@
 	u16 fxwc;
 };
 
-#define WAVEIN_MAXBUFSIZE         65536
-#define WAVEIN_MINBUFSIZE	  368
+#define WAVEIN_MAXBUFSIZE	65536
+#define WAVEIN_MINBUFSIZE	368
 
-#define WAVEIN_DEFAULTFRAGLEN     100 
-#define WAVEIN_DEFAULTBUFLEN      1000
+#define WAVEIN_DEFAULTFRAGLEN	100 
+#define WAVEIN_DEFAULTBUFLEN	1000
 
-#define WAVEIN_MINFRAGSHIFT   	  8 
+#define WAVEIN_MINFRAGSHIFT	8 
+#define WAVEIN_MINFRAGS		2
 
 int emu10k1_wavein_open(struct emu10k1_wavedevice *);
 void emu10k1_wavein_close(struct emu10k1_wavedevice *);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/cardwo.c linux-2.5.65-ac2/sound/oss/emu10k1/cardwo.c
--- linux-2.5.65/sound/oss/emu10k1/cardwo.c	2003-02-10 18:38:49.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/cardwo.c	2003-02-17 00:30:06.000000000 +0000
@@ -108,95 +108,20 @@
 	}
 
 	wave_fmt->bytesperchannel = wave_fmt->bitsperchannel >> 3;
+	wave_fmt->bytespersample = wave_fmt->channels * wave_fmt->bytesperchannel;
+	wave_fmt->bytespersec = wave_fmt->bytespersample * wave_fmt->samplingrate;
 
 	if (wave_fmt->channels == 2)
 		wave_fmt->bytespervoicesample = wave_fmt->channels * wave_fmt->bytesperchannel;
 	else
 		wave_fmt->bytespervoicesample = wave_fmt->bytesperchannel;
-
-	wave_fmt->bytespersample = wave_fmt->channels * wave_fmt->bytesperchannel;
-	wave_fmt->bytespersec = wave_fmt->bytespersample * wave_fmt->samplingrate;
-}
-
-/**
- * alloc_buffer -
- *
- * allocates the memory buffer for a voice. Two page tables are kept for each buffer.
- * One (dma_handle) keeps track of the host memory pages used and the other (virtualpagetable)
- * is passed to the device so that it can do DMA to host memory. 
- *
- */
-static int alloc_buffer(struct emu10k1_card *card, struct waveout_buffer *buffer, unsigned int voicenum)
-{
-	u32 pageindex, pagecount;
-	unsigned long busaddx;
-	int i;
-
-	DPD(2, "requested pages is: %d\n", buffer->pages);
-
-	if ((buffer->mem[voicenum].emupageindex =
-	 emu10k1_addxmgr_alloc(buffer->pages * PAGE_SIZE, card)) < 0)
-		return -1;
-
-	/* Fill in virtual memory table */
-	for (pagecount = 0; pagecount < buffer->pages; pagecount++) {
-		if ((buffer->mem[voicenum].addr[pagecount] =
-		 pci_alloc_consistent(card->pci_dev, PAGE_SIZE,
-		 &buffer->mem[voicenum].dma_handle[pagecount])) == NULL) {
-			buffer->pages = pagecount;
-			return -1;
-		}
-
-		DPD(2, "Virtual Addx: %p\n", buffer->mem[voicenum].addr[pagecount]);
-
-		for (i = 0; i < PAGE_SIZE / EMUPAGESIZE; i++) {
-			busaddx = buffer->mem[voicenum].dma_handle[pagecount] + i * EMUPAGESIZE;
-
-			DPD(3, "Bus Addx: %#lx\n", busaddx);
-
-			pageindex = buffer->mem[voicenum].emupageindex + pagecount * PAGE_SIZE / EMUPAGESIZE + i;
-
-			((u32 *) card->virtualpagetable.addr)[pageindex] = cpu_to_le32((busaddx * 2) | pageindex);
-		}
-	}
-
-	return 0;
-}
-
-/**
- * free_buffer -
- *
- * frees the memory buffer for a voice.
- */
-static void free_buffer(struct emu10k1_card *card, struct waveout_buffer *buffer, unsigned int voicenum)
-{
-	u32 pagecount, pageindex;
-	int i;
-
-	if (buffer->mem[voicenum].emupageindex < 0)
-		return;
-
-	for (pagecount = 0; pagecount < buffer->pages; pagecount++) {
-		pci_free_consistent(card->pci_dev, PAGE_SIZE,
-		 buffer->mem[voicenum].addr[pagecount],
-		 buffer->mem[voicenum].dma_handle[pagecount]);
-
-		for (i = 0; i < PAGE_SIZE / EMUPAGESIZE; i++) {
-			pageindex = buffer->mem[voicenum].emupageindex + pagecount * PAGE_SIZE / EMUPAGESIZE + i;
-			((u32 *) card->virtualpagetable.addr)[pageindex] =
-			 cpu_to_le32((card->silentpage.dma_handle * 2) | pageindex);
-		}
-	}
-
-	emu10k1_addxmgr_free(card, buffer->mem[voicenum].emupageindex);
-	buffer->mem[voicenum].emupageindex = -1;
 }
 
 static int get_voice(struct emu10k1_card *card, struct woinst *woinst, unsigned int voicenum)
 {
 	struct emu_voice *voice = &woinst->voice[voicenum];
-	/* Allocate voices here, if no voices available, return error.
-	 * Init voice_allocdesc first.*/
+
+	/* Allocate voices here, if no voices available, return error. */
 
 	voice->usage = VOICE_USAGE_PLAYBACK;
 
@@ -219,7 +144,7 @@
 
 	DPD(2, "Initial pitch --> %#x\n", voice->initial_pitch);
 
-	voice->startloop = (woinst->buffer.mem[voicenum].emupageindex << 12) /
+	voice->startloop = (voice->mem.emupageindex << 12) /
 	 woinst->format.bytespervoicesample;
 	voice->endloop = voice->startloop + woinst->buffer.size / woinst->format.bytespervoicesample;
 	voice->start = voice->startloop;
@@ -297,12 +222,12 @@
 	struct woinst *woinst = wave_dev->woinst;
 	struct waveout_buffer *buffer = &woinst->buffer;
 	unsigned int voicenum;
-	u32 delay;
+	u16 delay;
 
 	DPF(2, "emu10k1_waveout_open()\n");
 
 	for (voicenum = 0; voicenum < woinst->num_voices; voicenum++) {
-		if (alloc_buffer(card, buffer, voicenum) < 0) {
+		if (emu10k1_voice_alloc_buffer(card, &woinst->voice[voicenum].mem, woinst->buffer.pages) < 0) {
 			ERROR();
 			emu10k1_waveout_close(wave_dev);
 			return -1;
@@ -324,7 +249,7 @@
 	delay = (48000 * woinst->buffer.fragment_size) /
 		 (woinst->format.samplingrate * woinst->format.bytespervoicesample);
 
-	emu10k1_timer_install(card, &woinst->timer, delay / 2);
+	emu10k1_timer_install(card, &woinst->timer, delay);
 
 	woinst->state = WAVE_STATE_OPEN;
 
@@ -345,7 +270,7 @@
 
 	for (voicenum = 0; voicenum < woinst->num_voices; voicenum++) {
 		emu10k1_voice_free(&woinst->voice[voicenum]);
-		free_buffer(card, &woinst->buffer, voicenum);
+		emu10k1_voice_free_buffer(card, &woinst->voice[voicenum].mem);
 	}
 
 	woinst->state = WAVE_STATE_CLOSED;
@@ -371,7 +296,7 @@
 	struct emu10k1_card *card = wave_dev->card;
 	struct woinst *woinst = wave_dev->woinst;
 	unsigned int voicenum;
-	u32 delay;
+	u16 delay;
 
 	DPF(2, "emu10k1_waveout_setformat()\n");
 
@@ -404,7 +329,7 @@
 		delay = (48000 * woinst->buffer.fragment_size) /
 			 (woinst->format.samplingrate * woinst->format.bytespervoicesample);
 
-		emu10k1_timer_install(card, &woinst->timer, delay / 2);
+		emu10k1_timer_install(card, &woinst->timer, delay);
 	}
 
 	return 0;
@@ -449,7 +374,7 @@
 
 	pending_bytes = buffer->size - buffer->free_bytes;
 
-	buffer->fill_silence = (pending_bytes < (signed) buffer->fragment_size) ? 1 : 0;
+	buffer->fill_silence = (pending_bytes < (signed) buffer->fragment_size * 2) ? 1 : 0;
 
 	if (pending_bytes > (signed) buffer->silence_bytes) {
 		*total_free_bytes = (buffer->free_bytes + buffer->silence_bytes);
@@ -483,17 +408,14 @@
 
 	if (len > PAGE_SIZE - pgoff) {
 		k = PAGE_SIZE - pgoff;
-		if (__copy_from_user((u8 *)dst[pg] + pgoff, src, k))
-			return;
+		__copy_from_user((u8 *)dst[pg] + pgoff, src, k);
 		len -= k;
 		while (len > PAGE_SIZE) {
-			if (__copy_from_user(dst[++pg], src + k, PAGE_SIZE))
-				return;
+			__copy_from_user(dst[++pg], src + k, PAGE_SIZE);
 			k += PAGE_SIZE;
 			len -= PAGE_SIZE;
 		}
-		if (__copy_from_user(dst[++pg], src + k, len))
-			return;
+		__copy_from_user(dst[++pg], src + k, len);
 
 	} else
 		__copy_from_user((u8 *)dst[pg] + pgoff, src, len);
@@ -511,15 +433,14 @@
         unsigned int pg;
 	unsigned int pgoff;
 	unsigned int voice_num;
-	struct waveout_mem *mem = woinst->buffer.mem;
+	struct emu_voice *voice = woinst->voice;
 
 	pg = str / PAGE_SIZE;
 	pgoff = str % PAGE_SIZE;
 
 	while (len) { 
 		for (voice_num = 0; voice_num < woinst->num_voices; voice_num++) {
-			if (__copy_from_user((u8 *)(mem[voice_num].addr[pg]) + pgoff, src, woinst->format.bytespervoicesample))
-				return;
+			__copy_from_user((u8 *)(voice[voice_num].mem.addr[pg]) + pgoff, src, woinst->format.bytespervoicesample);
 			src += woinst->format.bytespervoicesample;
 		}
 
@@ -544,7 +465,7 @@
 	unsigned int pg;
 	unsigned int pgoff;
 	unsigned int voice_num;
-        struct waveout_mem *mem = woinst->buffer.mem;
+        struct emu_voice *voice = woinst->voice;
 	unsigned int  k;
 
 	pg = str / PAGE_SIZE;
@@ -553,22 +474,22 @@
 	if (len > PAGE_SIZE - pgoff) {
 		k = PAGE_SIZE - pgoff;
 		for (voice_num = 0; voice_num < woinst->num_voices; voice_num++)
-			memset((u8 *)mem[voice_num].addr[pg] + pgoff, data, k);
+			memset((u8 *)voice[voice_num].mem.addr[pg] + pgoff, data, k);
 		len -= k;
 		while (len > PAGE_SIZE) {
 			pg++;
 			for (voice_num = 0; voice_num < woinst->num_voices; voice_num++)
-				memset(mem[voice_num].addr[pg], data, PAGE_SIZE);
+				memset(voice[voice_num].mem.addr[pg], data, PAGE_SIZE);
 
 			len -= PAGE_SIZE;
 		}
 		pg++;
 		for (voice_num = 0; voice_num < woinst->num_voices; voice_num++)
-			memset(mem[voice_num].addr[pg], data, len);
+			memset(voice[voice_num].mem.addr[pg], data, len);
 
 	} else {
 		for (voice_num = 0; voice_num < woinst->num_voices; voice_num++)
-			memset((u8 *)mem[voice_num].addr[pg] + pgoff, data, len);
+			memset((u8 *)voice[voice_num].mem.addr[pg] + pgoff, data, len);
 	}
 }
 
@@ -582,6 +503,7 @@
 void emu10k1_waveout_xferdata(struct woinst *woinst, u8 *data, u32 *size)
 {
 	struct waveout_buffer *buffer = &woinst->buffer;
+	struct voice_mem *mem = &woinst->voice[0].mem;
 	u32 sizetocopy, sizetocopy_now, start;
 	unsigned long flags;
 
@@ -610,14 +532,14 @@
 			copy_ilv_block(woinst, start, data, sizetocopy_now);
 			copy_ilv_block(woinst, 0, data + sizetocopy_now * woinst->num_voices, sizetocopy);
 		} else {
-			copy_block(buffer->mem[0].addr, start, data, sizetocopy_now);
-			copy_block(buffer->mem[0].addr, 0, data + sizetocopy_now, sizetocopy);
+			copy_block(mem->addr, start, data, sizetocopy_now);
+			copy_block(mem->addr, 0, data + sizetocopy_now, sizetocopy);
 		}
 	} else {
 		if (woinst->num_voices > 1)
 			copy_ilv_block(woinst, start, data, sizetocopy);
 		else
-			copy_block(buffer->mem[0].addr, start, data, sizetocopy);
+			copy_block(mem->addr, start, data, sizetocopy);
 	}
 }
 
@@ -674,7 +596,7 @@
 {
 	u32 hw_pos;
 	u32 diff;
-	
+
 	/* There is no actual start yet */
 	if (!(woinst->state & WAVE_STATE_STARTED)) {
 		hw_pos = woinst->buffer.hw_pos;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/cardwo.h linux-2.5.65-ac2/sound/oss/emu10k1/cardwo.h
--- linux-2.5.65/sound/oss/emu10k1/cardwo.h	2003-02-10 18:38:48.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/cardwo.h	2003-02-17 00:30:06.000000000 +0000
@@ -39,20 +39,13 @@
 
 /* setting this to other than a power of two may break some applications */
 #define WAVEOUT_MAXBUFSIZE	MAXBUFSIZE
-#define WAVEOUT_MINBUFSIZE	64
 
 #define WAVEOUT_DEFAULTFRAGLEN	20 /* Time to play a fragment in ms (latency) */
 #define WAVEOUT_DEFAULTBUFLEN	500 /* Time to play the entire buffer in ms */
 
-#define WAVEOUT_MINFRAGSHIFT	6
-#define WAVEOUT_MAXVOICES 6
-
-/* waveout_mem is cardwo internal */
-struct waveout_mem {
-	int emupageindex;
-	void *addr[BUFMAXPAGES];
-	dma_addr_t dma_handle[BUFMAXPAGES];
-};
+#define WAVEOUT_MINFRAGSHIFT	6 /* Minimum fragment size in bytes is 2^6 */
+#define WAVEOUT_MINFRAGS	3 /* _don't_ go bellow 3, it would break silence filling */
+#define WAVEOUT_MAXVOICES	6
 
 struct waveout_buffer {
 	u16 ossfragshift;
@@ -60,7 +53,6 @@
 	u32 fragment_size;	/* in bytes units */
 	u32 size;		/* in bytes units */
 	u32 pages;		/* buffer size in page units*/
-	struct waveout_mem mem[WAVEOUT_MAXVOICES];
 	u32 silence_pos;	/* software cursor position (including silence bytes) */
 	u32 hw_pos;		/* hardware cursor position */
 	u32 free_bytes;		/* free bytes available on the buffer (not including silence bytes) */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/efxmgr.c linux-2.5.65-ac2/sound/oss/emu10k1/efxmgr.c
--- linux-2.5.65/sound/oss/emu10k1/efxmgr.c	2003-02-10 18:37:57.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/efxmgr.c	2003-02-17 00:30:06.000000000 +0000
@@ -38,7 +38,7 @@
         struct dsp_patch *patch;
 	struct dsp_rpatch *rpatch;
 	char s[PATCH_NAME_SIZE + 4];
-	u32 *gpr_used;
+	unsigned long *gpr_used;
 	int i;
 
 	DPD(2, "emu10k1_find_control_gpr(): %s %s\n", patch_name, gpr_name);
@@ -103,7 +103,7 @@
 
 	card->ac97.mixer_state[oss_mixer] = (right << 8) | left;
 
-	if (!card->isaps)
+	if (!card->is_aps)
 		card->ac97.write_mixer(&card->ac97, oss_mixer, left, right);
 	
 	emu10k1_set_volume_gpr(card, card->mgr.ctrl_gpr[oss_mixer][0], left,
@@ -171,9 +171,8 @@
 {
 	struct patch_manager *mgr = &card->mgr;
 	unsigned long flags;
-	int muting;
 
-	const s32 log2lin[5] ={                  //  attenuation (dB)
+	static const s32 log2lin[4] ={           //  attenuation (dB)
 		0x7fffffff,                      //       0.0         
 		0x7fffffff * 0.840896415253715 , //       1.5          
 		0x7fffffff * 0.707106781186548,  //       3.0
@@ -183,12 +182,10 @@
 	if (addr < 0)
 		return;
 
-	muting = (scale == 0x10) ? 0x7f: scale;
-	
 	vol = (100 - vol ) * scale / 100;
 
 	// Thanks to the comp.dsp newsgroup for this neat trick:
-	vol = (vol >= muting) ? 0 : (log2lin[vol & 3] >> (vol >> 2));
+	vol = (vol >= scale) ? 0 : (log2lin[vol & 3] >> (vol >> 2));
 
 	spin_lock_irqsave(&mgr->lock, flags);
 	emu10k1_set_control_gpr(card, addr, vol, 0);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/efxmgr.h linux-2.5.65-ac2/sound/oss/emu10k1/efxmgr.h
--- linux-2.5.65/sound/oss/emu10k1/efxmgr.h	2003-02-10 18:38:56.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/efxmgr.h	2003-02-17 00:30:06.000000000 +0000
@@ -35,9 +35,9 @@
 #define WRITE_EFX(a, b, c) sblive_writeptr((a), MICROCODEBASE + (b), 0, (c))
 
 #define OP(op, z, w, x, y) \
-        do { WRITE_EFX(card, (pc) * 2, ((x) << 10) | (y)); \
-        WRITE_EFX(card, (pc) * 2 + 1, ((op) << 20) | ((z) << 10) | (w)); \
-        ++pc; } while (0)
+	do { WRITE_EFX(card, (pc) * 2, ((x) << 10) | (y)); \
+	WRITE_EFX(card, (pc) * 2 + 1, ((op) << 20) | ((z) << 10) | (w)); \
+	++pc; } while (0)
 
 #define NUM_INPUTS 0x20
 #define NUM_OUTPUTS 0x20
@@ -47,52 +47,52 @@
 
 struct dsp_rpatch {
 	char name[PATCH_NAME_SIZE];
-        u16 code_start;
-        u16 code_size;
+	u16 code_start;
+	u16 code_size;
 
-        u32 gpr_used[NUM_GPRS / 32];
-        u32 gpr_input[NUM_GPRS / 32];
-        u32 route[NUM_OUTPUTS];
-        u32 route_v[NUM_OUTPUTS];
+	unsigned long gpr_used[NUM_GPRS / (sizeof(unsigned long) * 8) + 1];
+	unsigned long gpr_input[NUM_GPRS / (sizeof(unsigned long) * 8) + 1];
+	unsigned long route[NUM_OUTPUTS];
+	unsigned long route_v[NUM_OUTPUTS];
 };
 
 struct dsp_patch {
-        char name[PATCH_NAME_SIZE];
-        u8 id;
-        u32 input;                      /* bitmap of the lines used as inputs */
-	u32 output;                     /* bitmap of the lines used as outputs */
-        u16 code_start;
-        u16 code_size;
-
-        u32 gpr_used[NUM_GPRS / 32];    /* bitmap of used gprs */
-        u32 gpr_input[NUM_GPRS / 32];
-        u8 traml_istart;  /* starting address of the internal tram lines used */
-        u8 traml_isize;   /* number of internal tram lines used */
-
-        u8 traml_estart;
-        u8 traml_esize;
-
-        u16 tramb_istart;        /* starting address of the internal tram memory used */
-        u16 tramb_isize;         /* amount of internal memory used */
-        u32 tramb_estart;
-        u32 tramb_esize;
+	char name[PATCH_NAME_SIZE];
+	u8 id;
+	unsigned long input;	/* bitmap of the lines used as inputs */
+	unsigned long output;	/* bitmap of the lines used as outputs */
+	u16 code_start;
+	u16 code_size;
+
+	unsigned long gpr_used[NUM_GPRS / (sizeof(unsigned long) * 8) + 1];	/* bitmap of used gprs */
+	unsigned long gpr_input[NUM_GPRS / (sizeof(unsigned long) * 8) + 1];
+	u8 traml_istart;	/* starting address of the internal tram lines used */
+	u8 traml_isize;		/* number of internal tram lines used */
+
+	u8 traml_estart;
+	u8 traml_esize;
+
+	u16 tramb_istart;        /* starting address of the internal tram memory used */
+	u16 tramb_isize;         /* amount of internal memory used */
+	u32 tramb_estart;
+	u32 tramb_esize;
 };
 
 struct dsp_gpr {
-        u8 type;                      /* gpr type, STATIC, DYNAMIC, INPUT, OUTPUT, CONTROL */
-        char name[GPR_NAME_SIZE];       /* gpr value, only valid for control gprs */
-        s32 min, max;         /* value range for this gpr, only valid for control gprs */
-        u8 line;                    /* which input/output line is the gpr attached, only valid for input/output gprs */
-        u8 usage;
+	u8 type;			/* gpr type, STATIC, DYNAMIC, INPUT, OUTPUT, CONTROL */
+	char name[GPR_NAME_SIZE];	/* gpr value, only valid for control gprs */
+	s32 min, max;			/* value range for this gpr, only valid for control gprs */
+	u8 line;			/* which input/output line is the gpr attached, only valid for input/output gprs */
+	u8 usage;
 };
 
 enum {
-        GPR_TYPE_NULL = 0,
-        GPR_TYPE_IO,
-        GPR_TYPE_STATIC,
-        GPR_TYPE_DYNAMIC,
-        GPR_TYPE_CONTROL,
-        GPR_TYPE_CONSTANT
+	GPR_TYPE_NULL = 0,
+	GPR_TYPE_IO,
+	GPR_TYPE_STATIC,
+	GPR_TYPE_DYNAMIC,
+	GPR_TYPE_CONTROL,
+	GPR_TYPE_CONSTANT
 };
 
 #define GPR_BASE 0x100
@@ -101,15 +101,14 @@
 #define MAX_PATCHES_PAGES 32
 
 struct patch_manager {
-        void *patch[MAX_PATCHES_PAGES];
+	void *patch[MAX_PATCHES_PAGES];
 	int current_pages;
-        struct dsp_rpatch rpatch;
-        struct dsp_gpr gpr[NUM_GPRS];   /* gpr usage table */
+	struct dsp_rpatch rpatch;
+	struct dsp_gpr gpr[NUM_GPRS];   /* gpr usage table */
 	spinlock_t lock;
 	s16 ctrl_gpr[SOUND_MIXER_NRDEVICES][2];
 };
 
-
 #define PATCHES_PER_PAGE (PAGE_SIZE / sizeof(struct dsp_patch))
 
 #define PATCH(mgr, i) ((struct dsp_patch *) (mgr)->patch[(i) / PATCHES_PER_PAGE] + (i) % PATCHES_PER_PAGE)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/hwaccess.c linux-2.5.65-ac2/sound/oss/emu10k1/hwaccess.c
--- linux-2.5.65/sound/oss/emu10k1/hwaccess.c	2003-02-10 18:38:17.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/hwaccess.c	2003-02-17 00:30:06.000000000 +0000
@@ -187,6 +187,15 @@
 	}
 }
 
+void emu10k1_timer_set(struct emu10k1_card * card, u16 data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&card->lock, flags);
+	outw(data & TIMER_RATE_MASK, card->iobase + TIMER);
+	spin_unlock_irqrestore(&card->lock, flags);
+}
+
 /************************************************************************
 * write/read Emu10k1 pointer-offset register set, accessed through      *
 *  the PTR and DATA registers                                           *
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/hwaccess.h linux-2.5.65-ac2/sound/oss/emu10k1/hwaccess.h
--- linux-2.5.65/sound/oss/emu10k1/hwaccess.h	2003-02-10 18:38:20.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/hwaccess.h	2003-02-17 00:30:06.000000000 +0000
@@ -126,6 +126,7 @@
 #define CMD_SETMCH_FX		_IOW('D', 17, struct mixer_private_ioctl)
 #define CMD_SETPASSTHROUGH	_IOW('D', 18, struct mixer_private_ioctl)
 #define CMD_PRIVATE3_VERSION	_IOW('D', 19, struct mixer_private_ioctl)
+#define CMD_AC97_BOOST		_IOW('D', 20, struct mixer_private_ioctl)
 
 //up this number when breaking compatibility
 #define PRIVATE3_VERSION 1
@@ -144,7 +145,7 @@
 	u16			emupagetable[MAXPAGES];
 
 	struct list_head	timers;
-	unsigned		timer_delay;
+	u16			timer_delay;
 	spinlock_t		timer_lock;
 
 	struct pci_dev		*pci_dev;
@@ -181,7 +182,7 @@
 
 	u8 chiprev;                    /* Chip revision                */
 
-	int isaps;
+	u8 is_aps;
 
 	struct patch_manager mgr;
 	struct pt_data pt;
@@ -190,8 +191,6 @@
 int emu10k1_addxmgr_alloc(u32, struct emu10k1_card *);
 void emu10k1_addxmgr_free(struct emu10k1_card *, int);
 
-
-
 int emu10k1_find_control_gpr(struct patch_manager *, const char *, const char *);
 void emu10k1_set_control_gpr(struct emu10k1_card *, int , s32, int );
 
@@ -211,12 +210,14 @@
 
 /* Hardware Abstraction Layer access functions */
 
-void emu10k1_writefn0(struct emu10k1_card *, u32 , u32 );
-u32 emu10k1_readfn0(struct emu10k1_card *, u32 );
+void emu10k1_writefn0(struct emu10k1_card *, u32, u32);
+u32 emu10k1_readfn0(struct emu10k1_card *, u32);
+
+void emu10k1_timer_set(struct emu10k1_card *, u16);
 
-void sblive_writeptr(struct emu10k1_card *, u32 , u32 , u32 );
-void sblive_writeptr_tag(struct emu10k1_card *card, u32 channel, ...);
-#define TAGLIST_END 0
+void sblive_writeptr(struct emu10k1_card *, u32, u32, u32);
+void sblive_writeptr_tag(struct emu10k1_card *, u32, ...);
+#define TAGLIST_END	0
 
 u32 sblive_readptr(struct emu10k1_card *, u32 , u32 );
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/irqmgr.c linux-2.5.65-ac2/sound/oss/emu10k1/irqmgr.c
--- linux-2.5.65/sound/oss/emu10k1/irqmgr.c	2003-02-10 18:38:42.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/irqmgr.c	2003-02-17 00:30:06.000000000 +0000
@@ -1,4 +1,3 @@
-
 /*
  **********************************************************************
  *     irqmgr.c - IRQ manager for emu10k1 driver
@@ -41,7 +40,7 @@
 void emu10k1_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct emu10k1_card *card = (struct emu10k1_card *) dev_id;
-	u32 irqstatus;
+	u32 irqstatus, irqstatus_tmp;
 
 	DPD(4, "emu10k1_interrupt called, irq =  %u\n", irq);
 
@@ -60,8 +59,7 @@
 	while ((irqstatus = inl(card->iobase + IPR))) {
 		DPD(4, "irq status %#x\n", irqstatus);
 
-		/* acknowledge interrupt */
-		outl(irqstatus, card->iobase + IPR);
+		irqstatus_tmp = irqstatus;
 
 		if (irqstatus & IRQTYPE_TIMER) {
 			emu10k1_timer_irqhandler(card);
@@ -98,7 +96,15 @@
 			irqstatus &=~IPR_VOLDECR;
 		}
 
-		if (irqstatus)
-			emu10k1_irq_disable(card, irqstatus);
+		if (irqstatus){
+			printk(KERN_ERR "emu10k1: Warning, unhandled interrupt: %#08x\n", irqstatus);
+			//make sure any interrupts we don't handle are disabled:
+			emu10k1_irq_disable(card, ~(INTE_MIDIRXENABLE | INTE_MIDITXENABLE | INTE_INTERVALTIMERENB |
+						INTE_VOLDECRENABLE | INTE_VOLINCRENABLE | INTE_MUTEENABLE |
+						INTE_FXDSPENABLE));
+		}
+
+		/* acknowledge interrupt */
+                outl(irqstatus_tmp, card->iobase + IPR);
 	}
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/main.c linux-2.5.65-ac2/sound/oss/emu10k1/main.c
--- linux-2.5.65/sound/oss/emu10k1/main.c	2003-02-10 18:38:55.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/main.c	2003-02-17 00:30:06.000000000 +0000
@@ -1,4 +1,4 @@
-/*
+ /*
  **********************************************************************
  *     main.c - Creative EMU10K1 audio driver
  *     Copyright 1999, 2000 Creative Labs, Inc.
@@ -69,7 +69,20 @@
  *     0.16 Mixer improvements, added old treble/bass support (Daniel Bertrand)
  *          Small code format cleanup.
  *          Deadlock bug fix for emu10k1_volxxx_irqhandler().
- *
+ *     0.17 Fix for mixer SOUND_MIXER_INFO ioctl.
+ *	    Fix for HIGHMEM machines (emu10k1 can only do 31 bit bus master) 
+ *	    midi poll initial implementation.
+ *	    Small mixer fixes/cleanups.
+ *	    Improved support for 5.1 cards.
+ *     0.18 Fix for possible leak in pci_alloc_consistent()
+ *          Cleaned up poll() functions (audio and midi). Don't start input.
+ *	    Restrict DMA pages used to 512Mib range.
+ *	    New AC97_BOOST mixer ioctl.
+ *     0.19 Real fix for kernel with highmem support (cast dma_handle to u32).
+ *	    Fix recording buffering parameters calculation.
+ *	    Use unsigned long for variables in bit ops.
+ *     0.20 Fixed recording startup
+ *	    Fixed timer rate setting (it's a 16-bit register)
  *********************************************************************/
 
 /* These are only included once per module */
@@ -102,11 +115,10 @@
 #define SNDCARD_EMU10K1 46
 #endif
  
-#define DRIVER_VERSION "0.16"
+#define DRIVER_VERSION "0.20"
 
-/* FIXME: is this right? */
-/* does the card support 32 bit bus master?*/
-#define EMU10K1_DMA_MASK                0xffffffff	/* DMA buffer mask for pci_alloc_consist */
+/* the emu10k1 _seems_ to only supports 29 bit (512MiB) bit bus master */
+#define EMU10K1_DMA_MASK                0x1fffffff	/* DMA buffer mask for pci_alloc_consist */
 
 #ifndef PCI_VENDOR_ID_CREATIVE
 #define PCI_VENDOR_ID_CREATIVE 0x1102
@@ -188,7 +200,7 @@
 
 	/* Assign default recording parameters */
 	/* FIXME */
-	if(card->isaps)
+	if (card->is_aps)
 		card->wavein.recsrc = WAVERECORD_FX;
 	else
 		card->wavein.recsrc = WAVERECORD_AC97;
@@ -211,6 +223,8 @@
 static int __devinit emu10k1_mixer_init(struct emu10k1_card *card)
 {
 	char s[32];
+
+	struct ac97_codec *codec = &card->ac97;
 	card->ac97.dev_mixer = register_sound_mixer(&emu10k1_mixer_fops, -1);
 	if (card->ac97.dev_mixer < 0) {
 		printk(KERN_ERR "emu10k1: cannot register mixer device\n");
@@ -219,7 +233,7 @@
 
 	card->ac97.private_data = card;
 
-	if (!card->isaps) {
+	if (!card->is_aps) {
 		card->ac97.id = 0;
 		card->ac97.codec_read = emu10k1_ac97_read;
         	card->ac97.codec_write = emu10k1_ac97_write;
@@ -228,11 +242,14 @@
 			printk(KERN_ERR "emu10k1: unable to probe AC97 codec\n");
 			goto err_out;
 		}
-		/* 5.1: Enable the additional AC97 Slots. If the emu10k1 version
-			does not support this, it shouldn't do any harm */
-		sblive_writeptr(card, AC97SLOT, 0, AC97SLOT_CNTR | AC97SLOT_LFE);
+		/* 5.1: Enable the additional AC97 Slots and unmute extra channels on AC97 codec */
+		if (codec->codec_read(codec, AC97_EXTENDED_ID) & 0x0080){
+			printk(KERN_INFO "emu10k1: SBLive! 5.1 card detected\n"); 
+			sblive_writeptr(card, AC97SLOT, 0, AC97SLOT_CNTR | AC97SLOT_LFE);
+			codec->codec_write(codec, AC97_SURROUND_MASTER, 0x0);
+		}
 
-		// Force 5bit
+		// Force 5bit:		    
 		//card->ac97.bit_resolution=5;
 
 		if (!proc_mkdir ("driver/emu10k1", 0)) {
@@ -274,7 +291,7 @@
 {
 	char s[32];
 
-	if (!card->isaps) {
+	if (!card->is_aps) {
 		sprintf(s, "driver/emu10k1/%s/ac97", card->pci_dev->slot_name);
 		remove_proc_entry(s, NULL);
 
@@ -586,15 +603,15 @@
 	CONNECT(PCM1_IN_R, ANALOG_REAR_R);
 
 	/* Digital In + PCM + AC97 In + MULTI_FRONT --> Digital out */
-	OP(6, 0x10b, 0x100, 0x102, 0x10c);
-	OP(6, 0x10b, 0x10b, 0x113, 0x40);
+	OP(6, 0x10a, 0x100, 0x102, 0x10c);
+	OP(6, 0x10a, 0x10a, 0x113, 0x40);
 
 	CONNECT(MULTI_FRONT_L, DIGITAL_OUT_L);
 	CONNECT(PCM_IN_L, DIGITAL_OUT_L);
 	CONNECT(AC97_IN_L, DIGITAL_OUT_L);
 	CONNECT(SPDIF_CD_L, DIGITAL_OUT_L);
 
-	OP(6, 0x10a, 0x101, 0x103, 0x10e);
+	OP(6, 0x10b, 0x101, 0x103, 0x10e);
 	OP(6, 0x10b, 0x10b, 0x114, 0x40);
 
 	CONNECT(MULTI_FRONT_R, DIGITAL_OUT_R);
@@ -768,7 +785,7 @@
 				    VTFT, 0xffff,
 				    CVCF, 0xffff,
 				    PTRX, 0,
-				    CPF, 0,
+				    //CPF, 0,
 				    CCR, 0,
 
 				    PSST, 0,
@@ -794,7 +811,9 @@
 				    ENVVOL, 0,
 				    ENVVAL, 0,
                                     TAGLIST_END);
+		sblive_writeptr(card, CPF, nCh, 0);
 	}
+	
 
 	/*
 	 ** Init to 0x02109204 :
@@ -852,19 +871,19 @@
 	}
 
 	for (pagecount = 0; pagecount < MAXPAGES; pagecount++)
-		((u32 *) card->virtualpagetable.addr)[pagecount] = cpu_to_le32((card->silentpage.dma_handle * 2) | pagecount);
+		((u32 *) card->virtualpagetable.addr)[pagecount] = cpu_to_le32(((u32) card->silentpage.dma_handle * 2) | pagecount);
 
 	/* Init page table & tank memory base register */
 	sblive_writeptr_tag(card, 0,
-			    PTB, card->virtualpagetable.dma_handle,
+			    PTB, (u32) card->virtualpagetable.dma_handle,
 			    TCB, 0,
 			    TCBS, 0,
 			    TAGLIST_END);
 
 	for (nCh = 0; nCh < NUM_G; nCh++) {
 		sblive_writeptr_tag(card, nCh,
-				    MAPA, MAP_PTI_MASK | (card->silentpage.dma_handle * 2),
-				    MAPB, MAP_PTI_MASK | (card->silentpage.dma_handle * 2),
+				    MAPA, MAP_PTI_MASK | ((u32) card->silentpage.dma_handle * 2),
+				    MAPB, MAP_PTI_MASK | ((u32) card->silentpage.dma_handle * 2),
 				    TAGLIST_END);
 	}
 
@@ -951,8 +970,9 @@
 				    VTFT, 0,
 				    CVCF, 0,
 				    PTRX, 0,
-				    CPF, 0,
+				    //CPF, 0,
 				    TAGLIST_END);
+		sblive_writeptr(card, CPF, ch, 0);
 	}
 
 	/* Disable audio and lock cache */
@@ -999,7 +1019,7 @@
 	int ret;
 
 	if (pci_set_dma_mask(pci_dev, EMU10K1_DMA_MASK)) {
-		printk(KERN_ERR "emu10k1: architecture does not support 32bit PCI busmaster DMA\n");
+		printk(KERN_ERR "emu10k1: architecture does not support 29bit PCI busmaster DMA\n");
 		return -ENODEV;
 	}
 
@@ -1038,12 +1058,12 @@
 	pci_read_config_byte(pci_dev, PCI_REVISION_ID, &card->chiprev);
 	pci_read_config_word(pci_dev, PCI_SUBSYSTEM_ID, &card->model);
 
-	printk(KERN_INFO "emu10k1: %s rev %d model 0x%x found, IO at 0x%04lx-0x%04lx, IRQ %d\n",
+	printk(KERN_INFO "emu10k1: %s rev %d model %#04x found, IO at %#04lx-%#04lx, IRQ %d\n",
 		card_names[pci_id->driver_data], card->chiprev, card->model, card->iobase,
 		card->iobase + card->length - 1, card->irq);
 
 	pci_read_config_dword(pci_dev, PCI_SUBSYSTEM_VENDOR_ID, &subsysvid);
-	card->isaps = (subsysvid == EMU_APS_SUBID);
+	card->is_aps = (subsysvid == EMU_APS_SUBID);
 
 	spin_lock_init(&card->lock);
 	init_MUTEX(&card->open_sem);
@@ -1074,7 +1094,7 @@
 		goto err_emu10k1_init;
 	}
 
-	if (card->isaps)
+	if (card->is_aps)
 		emu10k1_ecard_init(card);
 
 	list_add(&card->list, &emu10k1_devs);
@@ -1119,7 +1139,7 @@
 	pci_set_drvdata(pci_dev, NULL);
 }
 
-MODULE_AUTHOR("Bertrand Lee, Cai Ying. (Email to: emu10k1-devel@opensource.creative.com)");
+MODULE_AUTHOR("Bertrand Lee, Cai Ying. (Email to: emu10k1-devel@lists.sourceforge.net)");
 MODULE_DESCRIPTION("Creative EMU10K1 PCI Audio Driver v" DRIVER_VERSION "\nCopyright (C) 1999 Creative Technology Ltd.");
 MODULE_LICENSE("GPL");
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/midi.c linux-2.5.65-ac2/sound/oss/emu10k1/midi.c
--- linux-2.5.65/sound/oss/emu10k1/midi.c	2003-02-10 18:39:16.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/midi.c	2003-03-14 00:52:26.000000000 +0000
@@ -29,8 +29,8 @@
  **********************************************************************
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
+#include <linux/poll.h>
 #include <linux/slab.h>
 #include <linux/version.h>
 #include <linux/sched.h>
@@ -371,8 +371,32 @@
 
 static unsigned int emu10k1_midi_poll(struct file *file, struct poll_table_struct *wait)
 {
+	struct emu10k1_mididevice *midi_dev = (struct emu10k1_mididevice *) file->private_data;
+	unsigned long flags;
+	unsigned int mask = 0;
+
 	DPF(4, "emu10k1_midi_poll() called\n");
-	return 0;
+
+	if (file->f_mode & FMODE_WRITE)
+		poll_wait(file, &midi_dev->oWait, wait);
+
+	if (file->f_mode & FMODE_READ)
+		poll_wait(file, &midi_dev->iWait, wait);
+
+	spin_lock_irqsave(&midi_spinlock, flags);
+
+	if (file->f_mode & FMODE_WRITE)
+		mask |= POLLOUT | POLLWRNORM;
+
+	if (file->f_mode & FMODE_READ) {
+		if (midi_dev->mistate == MIDIIN_STATE_STARTED)
+			if (midi_dev->icnt > 0)
+				mask |= POLLIN | POLLRDNORM;
+	}
+
+	spin_unlock_irqrestore(&midi_spinlock, flags);
+
+	return mask;
 }
 
 int emu10k1_midi_callback(unsigned long msg, unsigned long refdata, unsigned long *pmsg)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/mixer.c linux-2.5.65-ac2/sound/oss/emu10k1/mixer.c
--- linux-2.5.65/sound/oss/emu10k1/mixer.c	2003-02-10 18:38:47.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/mixer.c	2003-03-14 00:52:26.000000000 +0000
@@ -30,7 +30,6 @@
  **********************************************************************
  */
 
-#define __NO_VERSION__		/* Kernel version only defined once */
 #include <linux/module.h>
 #include <linux/version.h>
 #include <asm/uaccess.h>
@@ -251,7 +250,7 @@
 		case CMD_SETRECSRC:
 			switch (ctl->val[0]) {
 			case WAVERECORD_AC97:
-				if (card->isaps) {
+				if (card->is_aps) {
 					ret = -EINVAL;
 					break;
 				}
@@ -444,6 +443,7 @@
 
 		case CMD_SETGPR2OSS:
 			id = ctl->val[0];
+			/* 0 == left, 1 == right */
 			ch = ctl->val[1];
 			addr = ctl->val[2];
 
@@ -454,19 +454,19 @@
 
 			card->mgr.ctrl_gpr[id][ch] = addr;
 
-			if (card->isaps)
+			if (card->is_aps)
 				break;
 
 			if (addr >= 0) {
 				unsigned int state = card->ac97.mixer_state[id];
 
-				if (ch) {
+				if (ch == 1) {
 					state >>= 8;
 					card->ac97.stereo_mixers |= (1 << id);
-				} else {
-					card->ac97.supported_mixers |= (1 << id);
 				}
 
+				card->ac97.supported_mixers |= (1 << id);
+
 				if (id == SOUND_MIXER_TREBLE) {
 					set_treble(card, card->ac97.mixer_state[id] & 0xff, (card->ac97.mixer_state[id] >> 8) & 0xff);
 				} else if (id == SOUND_MIXER_BASS) {
@@ -475,10 +475,10 @@
 					emu10k1_set_volume_gpr(card, addr, state & 0xff,
 							       volume_params[id]);
 			} else {
-				if (ch) {
-					card->ac97.stereo_mixers &= ~(1 << id);
-					card->ac97.stereo_mixers |= card->ac97_stereo_mixers;
-				} else {
+				card->ac97.stereo_mixers &= ~(1 << id);
+				card->ac97.stereo_mixers |= card->ac97_stereo_mixers;
+
+				if (ch == 0) {
 					card->ac97.supported_mixers &= ~(1 << id);
 					card->ac97.supported_mixers |= card->ac97_supported_mixers;
 				}
@@ -499,6 +499,12 @@
 				ret = -EFAULT;
 			break;
 
+		case CMD_AC97_BOOST:
+			if(ctl->val[0])
+				emu10k1_ac97_write(&card->ac97, 0x18, 0x0);	
+			else
+				emu10k1_ac97_write(&card->ac97, 0x18, 0x0808);
+			break;
 		default:
 			ret = -EINVAL;
 			break;
@@ -551,7 +557,7 @@
 
 				card->tankmem.size = size;
 
-				sblive_writeptr_tag(card, 0, TCB, card->tankmem.dma_handle, TCBS, size_reg, TAGLIST_END);
+				sblive_writeptr_tag(card, 0, TCB, (u32) card->tankmem.dma_handle, TCBS, size_reg, TAGLIST_END);
 
 				emu10k1_writefn0(card, HCFG_LOCKTANKCACHE, 0);
 			}
@@ -572,6 +578,8 @@
 	int val;
 	int scale;
 
+	card->ac97.modcnt++;
+
 	if (get_user(val, (int *)arg))
 		return -EFAULT;
 
@@ -612,7 +620,7 @@
 	unsigned int oss_mixer = _IOC_NR(cmd);
 	
 	ret = -EINVAL;
-	if (!card->isaps) {
+	if (!card->is_aps) {
 		if (cmd == SOUND_MIXER_INFO) {
 			mixer_info info;
 
@@ -626,7 +634,7 @@
 			return 0;
 		}
 
-		if ((_IOC_DIR(cmd) == (_IOC_WRITE|_IOC_READ)) && oss_mixer <= SOUND_MIXER_NRDEVICES)
+		if ((_SIOC_DIR(cmd) == (_SIOC_WRITE|_SIOC_READ)) && oss_mixer <= SOUND_MIXER_NRDEVICES)
 			ret = emu10k1_dsp_mixer(card, oss_mixer, arg);
 		else
 			ret = card->ac97.mixer_ioctl(&card->ac97, cmd, arg);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/passthrough.c linux-2.5.65-ac2/sound/oss/emu10k1/passthrough.c
--- linux-2.5.65/sound/oss/emu10k1/passthrough.c	2003-02-10 18:38:31.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/passthrough.c	2003-03-14 00:52:26.000000000 +0000
@@ -29,7 +29,6 @@
  **********************************************************************
  */
                        
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
@@ -165,15 +164,12 @@
 
 		DPD(3, "prepend size %d, prepending %d bytes\n", pt->prepend_size, needed);
 		if (count < needed) {
-			if (copy_from_user(pt->buf + pt->prepend_size, buffer,
-					   count))
-				return -EFAULT;
+			copy_from_user(pt->buf + pt->prepend_size, buffer, count);
 			pt->prepend_size += count;
 			DPD(3, "prepend size now %d\n", pt->prepend_size);
 			return count;
 		}
-		if (copy_from_user(pt->buf + pt->prepend_size, buffer, needed))
-			return -EFAULT;
+		copy_from_user(pt->buf + pt->prepend_size, buffer, needed);
 		r = pt_putblock(wave_dev, (u16 *) pt->buf, nonblock);
 		if (r)
 			return r;
@@ -184,8 +180,7 @@
 	blocks_copied = 0;
 	while (blocks > 0) {
 		u16 *bufptr = (u16 *) buffer + (bytes_copied/2);
-		if (copy_from_user(pt->buf, bufptr, PT_BLOCKSIZE))
-			return -EFAULT;
+		copy_from_user(pt->buf, bufptr, PT_BLOCKSIZE);
 		bufptr = (u16 *) pt->buf;
 		r = pt_putblock(wave_dev, bufptr, nonblock);
 		if (r) {
@@ -201,8 +196,7 @@
 	i = count - bytes_copied;
 	if (i) {
 		pt->prepend_size = i;
-		if (copy_from_user(pt->buf, buffer + bytes_copied, i))
-			return -EFAULT;
+		copy_from_user(pt->buf, buffer + bytes_copied, i);
 		bytes_copied += i;
 		DPD(3, "filling prepend buffer with %d bytes", i);
 	}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/recmgr.c linux-2.5.65-ac2/sound/oss/emu10k1/recmgr.c
--- linux-2.5.65/sound/oss/emu10k1/recmgr.c	2003-02-10 18:39:17.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/recmgr.c	2003-02-17 00:30:06.000000000 +0000
@@ -29,19 +29,28 @@
  **********************************************************************
  */
 
+#include <asm/delay.h>
 #include "8010.h"
 #include "recmgr.h"
 
+void emu10k1_reset_record(struct emu10k1_card *card, struct wavein_buffer *buffer)
+{
+	DPF(2, "emu10k1_reset_record()\n");
+
+	sblive_writeptr(card, buffer->sizereg, 0, ADCBS_BUFSIZE_NONE);
+
+	sblive_writeptr(card, buffer->sizereg, 0, buffer->sizeregval);	
+
+	while (sblive_readptr(card, buffer->idxreg, 0))
+		udelay(5);
+}
+
 void emu10k1_start_record(struct emu10k1_card *card, struct wavein_buffer *buffer)
 {
 	DPF(2, "emu10k1_start_record()\n");
 
-	sblive_writeptr(card, buffer->sizereg, 0, buffer->sizeregval);
-
 	if (buffer->adcctl)
 		sblive_writeptr(card, ADCCR, 0, buffer->adcctl);
-
-	return;
 }
 
 void emu10k1_stop_record(struct emu10k1_card *card, struct wavein_buffer *buffer)
@@ -51,10 +60,6 @@
 	/* Disable record transfer */
 	if (buffer->adcctl)
 		sblive_writeptr(card, ADCCR, 0, 0);
-
-	sblive_writeptr(card, buffer->sizereg, 0, ADCBS_BUFSIZE_NONE);
-
-	return;
 }
 
 void emu10k1_set_record_src(struct emu10k1_card *card, struct wiinst *wiinst)
@@ -130,9 +135,7 @@
 		break;
 	}
 
-	DPD(2, "bus addx: %#x\n", buffer->dma_handle);
-
-	sblive_writeptr(card, buffer->addrreg, 0, buffer->dma_handle);
+	DPD(2, "bus addx: %#lx\n", (unsigned long) buffer->dma_handle);
 
-	return;
+	sblive_writeptr(card, buffer->addrreg, 0, (u32)buffer->dma_handle);
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/recmgr.h linux-2.5.65-ac2/sound/oss/emu10k1/recmgr.h
--- linux-2.5.65/sound/oss/emu10k1/recmgr.h	2003-02-10 18:38:54.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/recmgr.h	2003-02-17 00:30:06.000000000 +0000
@@ -40,9 +40,9 @@
 #define WAVERECORD_MIC		0x02
 #define WAVERECORD_FX		0x03
 
+void emu10k1_reset_record(struct emu10k1_card *card, struct wavein_buffer *buffer);
 void emu10k1_start_record(struct emu10k1_card *, struct wavein_buffer *);
 void emu10k1_stop_record(struct emu10k1_card *, struct wavein_buffer *);
 void emu10k1_set_record_src(struct emu10k1_card *, struct wiinst *wiinst);
 
-
 #endif /* _RECORDMGR_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/timer.c linux-2.5.65-ac2/sound/oss/emu10k1/timer.c
--- linux-2.5.65/sound/oss/emu10k1/timer.c	2003-02-10 18:38:02.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/timer.c	2003-02-17 00:30:06.000000000 +0000
@@ -59,7 +59,7 @@
 	return;
 }
 
-void emu10k1_timer_install(struct emu10k1_card *card, struct emu_timer *timer, u32 delay)
+void emu10k1_timer_install(struct emu10k1_card *card, struct emu_timer *timer, u16 delay)
 {
 	struct emu_timer *t;
 	struct list_head *entry;
@@ -85,7 +85,7 @@
 		card->timer_delay = delay;
 		delay = (delay < 1024 ? delay : 1024);
 
-		emu10k1_writefn0(card, TIMER_RATE, delay);
+		emu10k1_timer_set(card, delay);
 
 		list_for_each(entry, &card->timers) {
 			t = list_entry(entry, struct emu_timer, list);
@@ -108,7 +108,7 @@
 {
 	struct emu_timer *t;
 	struct list_head *entry;
-	u32 delay = TIMER_STOPPED;
+	u16 delay = TIMER_STOPPED;
 	unsigned long flags;
 
 	if (timer->state == TIMER_STATE_UNINSTALLED)
@@ -133,7 +133,7 @@
 		else {
 			delay = (delay < 1024 ? delay : 1024);
 
-			emu10k1_writefn0(card, TIMER_RATE, delay);
+			emu10k1_timer_set(card, delay);
 
 			list_for_each(entry, &card->timers) {
 				t = list_entry(entry, struct emu_timer, list);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/timer.h linux-2.5.65-ac2/sound/oss/emu10k1/timer.h
--- linux-2.5.65/sound/oss/emu10k1/timer.h	2003-02-10 18:37:58.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/timer.h	2003-02-17 00:30:06.000000000 +0000
@@ -36,17 +36,17 @@
 	struct list_head list;
 	struct tasklet_struct tasklet;
 	u8 state; 
-	u32 count;				/* current number of interrupts */
-	u32 count_max;				/* number of interrupts needed to schedule the bh */
-	u32 delay;                              /* timer delay */
+	u16 count;				/* current number of interrupts */
+	u16 count_max;				/* number of interrupts needed to schedule the bh */
+	u16 delay;                              /* timer delay */
 };
 
-void emu10k1_timer_install(struct emu10k1_card *, struct emu_timer *, u32);
+void emu10k1_timer_install(struct emu10k1_card *, struct emu_timer *, u16);
 void emu10k1_timer_uninstall(struct emu10k1_card *, struct emu_timer *);
 void emu10k1_timer_enable(struct emu10k1_card *, struct emu_timer *);
 void emu10k1_timer_disable(struct emu10k1_card *, struct emu_timer *);
 
-#define TIMER_STOPPED 			0xffffffff 
+#define TIMER_STOPPED 			0xffff 
 #define TIMER_STATE_INSTALLED 		0x01
 #define TIMER_STATE_ACTIVE		0x02
 #define TIMER_STATE_UNINSTALLED 	0x04
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/voicemgr.c linux-2.5.65-ac2/sound/oss/emu10k1/voicemgr.c
--- linux-2.5.65/sound/oss/emu10k1/voicemgr.c	2003-02-10 18:38:43.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/voicemgr.c	2003-02-17 00:30:06.000000000 +0000
@@ -32,6 +32,84 @@
 #include "voicemgr.h"
 #include "8010.h"
 
+/**
+ * emu10k1_voice_alloc_buffer -
+ *
+ * allocates the memory buffer for a voice. Two page tables are kept for each buffer.
+ * One (dma_handle) keeps track of the host memory pages used and the other (virtualpagetable)
+ * is passed to the device so that it can do DMA to host memory.
+ *
+ */
+int emu10k1_voice_alloc_buffer(struct emu10k1_card *card, struct voice_mem *mem, u32 pages)
+{
+	u32 pageindex, pagecount;
+	u32 busaddx;
+	int i;
+
+	DPD(2, "requested pages is: %d\n", pages);
+
+	if ((mem->emupageindex = emu10k1_addxmgr_alloc(pages * PAGE_SIZE, card)) < 0)
+	{
+		DPF(1, "couldn't allocate emu10k1 address space\n");
+		return -1;
+	}
+
+	/* Fill in virtual memory table */
+	for (pagecount = 0; pagecount < pages; pagecount++) {
+		if ((mem->addr[pagecount] = pci_alloc_consistent(card->pci_dev, PAGE_SIZE, &mem->dma_handle[pagecount]))
+			== NULL) {
+			mem->pages = pagecount;
+			DPF(1, "couldn't allocate dma memory\n");
+			return -1;
+		}
+
+		DPD(2, "Virtual Addx: %p\n", mem->addr[pagecount]);
+
+		for (i = 0; i < PAGE_SIZE / EMUPAGESIZE; i++) {
+			busaddx = (u32) mem->dma_handle[pagecount] + i * EMUPAGESIZE;
+
+			DPD(3, "Bus Addx: %#x\n", busaddx);
+
+			pageindex = mem->emupageindex + pagecount * PAGE_SIZE / EMUPAGESIZE + i;
+
+			((u32 *) card->virtualpagetable.addr)[pageindex] = cpu_to_le32((busaddx * 2) | pageindex);
+		}
+	}
+
+	mem->pages = pagecount;
+
+	return 0;
+}
+
+/**
+ * emu10k1_voice_free_buffer -
+ *
+ * frees the memory buffer for a voice.
+ */
+void emu10k1_voice_free_buffer(struct emu10k1_card *card, struct voice_mem *mem)
+{
+	u32 pagecount, pageindex;
+	int i;
+
+	if (mem->emupageindex < 0)
+		return;
+
+	for (pagecount = 0; pagecount < mem->pages; pagecount++) {
+		pci_free_consistent(card->pci_dev, PAGE_SIZE,
+					mem->addr[pagecount],
+					mem->dma_handle[pagecount]);
+
+		for (i = 0; i < PAGE_SIZE / EMUPAGESIZE; i++) {
+			pageindex = mem->emupageindex + pagecount * PAGE_SIZE / EMUPAGESIZE + i;
+			((u32 *) card->virtualpagetable.addr)[pageindex] =
+				cpu_to_le32(((u32) card->silentpage.dma_handle * 2) | pageindex);
+		}
+	}
+
+	emu10k1_addxmgr_free(card, mem->emupageindex);
+	mem->emupageindex = -1;
+}
+
 int emu10k1_voice_alloc(struct emu10k1_card *card, struct emu_voice *voice)
 {
 	u8 *voicetable = card->voicetable;
@@ -96,8 +174,10 @@
 							VTFT, 0x0000ffff,
 							PTRX_PITCHTARGET, 0,
 							CVCF, 0x0000ffff,
-							CPF, 0,
+							//CPF, 0,
 							TAGLIST_END);
+		
+		sblive_writeptr(card, CPF, voice->num + i, 0);
 	}
 
 	voice->usage = VOICE_USAGE_FREE;
@@ -151,8 +231,8 @@
 				    Z1, 0,
 				    Z2, 0,
 				    /* Invalidate maps */
-				    MAPA, MAP_PTI_MASK | (card->silentpage.dma_handle * 2),
-				    MAPB, MAP_PTI_MASK | (card->silentpage.dma_handle * 2),
+				    MAPA, MAP_PTI_MASK | ((u32) card->silentpage.dma_handle * 2),
+				    MAPB, MAP_PTI_MASK | ((u32) card->silentpage.dma_handle * 2),
 				/* modulation envelope */
 				    CVCF, 0x0000ffff,
 				    VTFT, 0x0000ffff,
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/emu10k1/voicemgr.h linux-2.5.65-ac2/sound/oss/emu10k1/voicemgr.h
--- linux-2.5.65/sound/oss/emu10k1/voicemgr.h	2003-02-10 18:38:43.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/emu10k1/voicemgr.h	2003-02-17 00:30:06.000000000 +0000
@@ -64,6 +64,12 @@
 	u32 byampl_env_decay;
 };
 
+struct voice_mem {
+	int emupageindex;
+	void *addr[BUFMAXPAGES];
+	dma_addr_t dma_handle[BUFMAXPAGES];
+	u32 pages;
+};
 
 struct emu_voice
 {
@@ -72,16 +78,20 @@
 	u8 num;			/* Voice ID */
 	u8 flags;		/* Stereo/mono, 8/16 bit */
 
-        u32 startloop;
-        u32 endloop;
+	u32 startloop;
+	u32 endloop;
 	u32 start;
 
 	u32 initial_pitch;
 	u32 pitch_target;
 
 	struct voice_param params[2];
+
+	struct voice_mem mem;
 };
 
+int emu10k1_voice_alloc_buffer(struct emu10k1_card *, struct voice_mem *, u32);
+void emu10k1_voice_free_buffer(struct emu10k1_card *, struct voice_mem *);
 int emu10k1_voice_alloc(struct emu10k1_card *, struct emu_voice *);
 void emu10k1_voice_free(struct emu_voice *);
 void emu10k1_voice_playback_setup(struct emu_voice *);
