Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262154AbSJARBU>; Tue, 1 Oct 2002 13:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262211AbSJARBU>; Tue, 1 Oct 2002 13:01:20 -0400
Received: from gate.perex.cz ([194.212.165.105]:40711 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S262154AbSJAQ67>;
	Tue, 1 Oct 2002 12:58:59 -0400
Date: Tue, 1 Oct 2002 19:00:26 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2nd ALSA update [10/12] - 2002/09/16
Message-ID: <Pine.LNX.4.33.0210011859260.20016-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.653, 2002-10-01 16:00:13+02:00, perex@suse.cz
  ALSA update 2002/09/16 :
    - OSS mixer emulation
      - save the current volume values permanently
    - PCM midlevel
      - fixed 64bit division on non-ix86 32bit architectures
      - exported snd_pcm_new_stream()
    - PCI DMA allocation
      - fixes and updates
    - PCM Scatter-Gather code
      - don't set runtime->dma_bytes if runtime is null
    - CMI8330 - fix nor non-IsaPnP build
    - CMIPCI - added "Mic As Center/LFE" switch for model 039 or later
    - more initialization of structs in C99 style
    - intel8x0 - fixes for nvidia nforce
    - Maestro3 - added quirk for CF72 toughbook
    - VIA82xx - reset codec only when it's not ready
    - USB Audio
      - fixed oops at unloading if non-intialized substream exists
      - show interface number in proc files
      - clean up and fixed the parser of audio streams


 include/sound/mixer_oss.h          |    2 
 include/sound/pcm.h                |    3 
 include/sound/version.h            |    2 
 sound/core/memory.c                |   40 --
 sound/core/oss/mixer_oss.c         |   20 -
 sound/core/pcm.c                   |   11 
 sound/core/pcm_sgbuf.c             |    6 
 sound/core/wrappers.c              |   46 ++
 sound/isa/cmi8330.c                |    5 
 sound/pci/cmipci.c                 |    2 
 sound/pci/emu10k1/emufx.c          |   26 -
 sound/pci/es1968.c                 |   52 +-
 sound/pci/ice1712.c                |   26 -
 sound/pci/intel8x0.c               |    3 
 sound/pci/maestro3.c               |   82 ++--
 sound/pci/nm256/nm256.c            |   48 +-
 sound/pci/rme9652/hammerfall_mem.c |    7 
 sound/pci/via82xx.c                |   30 -
 sound/usb/usbaudio.c               |  735 ++++++++++++++++++-------------------
 19 files changed, 589 insertions(+), 557 deletions(-)


diff -Nru a/include/sound/mixer_oss.h b/include/sound/mixer_oss.h
--- a/include/sound/mixer_oss.h	Tue Oct  1 17:09:52 2002
+++ b/include/sound/mixer_oss.h	Tue Oct  1 17:09:52 2002
@@ -46,6 +46,7 @@
 	unsigned long private_value;
 	void *private_data;
 	void (*private_free)(snd_mixer_oss_slot_t *slot);
+	int volume[2];
 };
 
 struct _snd_oss_mixer {
@@ -65,7 +66,6 @@
 };
 
 struct _snd_oss_file {
-	int volume[32][2];
 	snd_card_t *card;
 	snd_mixer_oss_t *mixer;
 };
diff -Nru a/include/sound/pcm.h b/include/sound/pcm.h
--- a/include/sound/pcm.h	Tue Oct  1 17:09:52 2002
+++ b/include/sound/pcm.h	Tue Oct  1 17:09:52 2002
@@ -460,6 +460,7 @@
 int snd_pcm_new(snd_card_t * card, char *id, int device,
 		int playback_count, int capture_count,
 		snd_pcm_t **rpcm);
+int snd_pcm_new_stream(snd_pcm_t *pcm, int stream, int substream_count);
 
 int snd_pcm_notify(snd_pcm_notify_t *notify, int nfree);
 
@@ -526,7 +527,7 @@
 	int c = 32;
 	while (n > 0xffffffffU) {
 		q1 <<= 1;
-		if (n > d) {
+		if (n >= d) {
 			n -= d;
 			q1 |= 1;
 		}
diff -Nru a/include/sound/version.h b/include/sound/version.h
--- a/include/sound/version.h	Tue Oct  1 17:09:52 2002
+++ b/include/sound/version.h	Tue Oct  1 17:09:52 2002
@@ -1,3 +1,3 @@
 /* include/version.h.  Generated automatically by configure.  */
 #define CONFIG_SND_VERSION "0.9.0rc3"
-#define CONFIG_SND_DATE " (Wed Sep 11 18:36:14 2002 UTC)"
+#define CONFIG_SND_DATE " (Mon Sep 16 18:05:43 2002 UTC)"
diff -Nru a/sound/core/memory.c b/sound/core/memory.c
--- a/sound/core/memory.c	Tue Oct  1 17:09:51 2002
+++ b/sound/core/memory.c	Tue Oct  1 17:09:51 2002
@@ -538,43 +538,3 @@
 	return 0;
 #endif
 }
-
-#ifdef HACK_PCI_ALLOC_CONSISTENT
-/*
- * A dirty hack... when the kernel code is fixed this should be removed.
- *
- * since pci_alloc_consistent always tries GFP_DMA when the requested
- * pci memory region is below 32bit, it happens quite often that even
- * 2 order of pages cannot be allocated.
- *
- * so in the following, we allocate at first without dma_mask, so that
- * allocation will be done without GFP_DMA.  if the area doesn't match
- * with the requested region, then realloate with the original dma_mask
- * again.
- */
-
-#undef pci_alloc_consistent
-
-void *snd_pci_hack_alloc_consistent(struct pci_dev *hwdev, size_t size,
-				    dma_addr_t *dma_handle)
-{
-	void *ret;
-	u64 dma_mask;
-	unsigned long rmask;
-
-	if (hwdev == NULL)
-		return pci_alloc_consistent(hwdev, size, dma_handle);
-	dma_mask = hwdev->dma_mask;
-	rmask = ~((unsigned long)dma_mask);
-	hwdev->dma_mask = 0xffffffff; /* do without masking */
-	ret = pci_alloc_consistent(hwdev, size, dma_handle);
-	if (ret && ((*dma_handle + size - 1) & rmask)) {
-		pci_free_consistent(hwdev, size, ret, *dma_handle);
-		ret = 0;
-	}
-	hwdev->dma_mask = dma_mask; /* restore */
-	if (! ret)
-		ret = pci_alloc_consistent(hwdev, size, dma_handle);
-	return ret;
-}
-#endif /* hack */
diff -Nru a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
--- a/sound/core/oss/mixer_oss.c	Tue Oct  1 17:09:52 2002
+++ b/sound/core/oss/mixer_oss.c	Tue Oct  1 17:09:52 2002
@@ -253,8 +253,8 @@
 	if (mixer == NULL || slot > 30)
 		return -EIO;
 	pslot = &mixer->slots[slot];
-	left = fmixer->volume[slot][0];
-	right = fmixer->volume[slot][1];
+	left = pslot->volume[0];
+	right = pslot->volume[1];
 	if (pslot->get_volume)
 		result = pslot->get_volume(fmixer, pslot, &left, &right);
 	if (!pslot->stereo)
@@ -262,8 +262,8 @@
 	snd_assert(left >= 0 && left <= 100, return -EIO);
 	snd_assert(right >= 0 && right <= 100, return -EIO);
 	if (result >= 0) {
-		fmixer->volume[slot][0] = left;
-		fmixer->volume[slot][1] = right;
+		pslot->volume[0] = left;
+		pslot->volume[1] = right;
 	 	result = (left & 0xff) | ((right & 0xff) << 8);
 	}
 	return result;
@@ -284,13 +284,13 @@
 	if (right > 100)
 		right = 100;
 	if (!pslot->stereo)
-		left = right = left;
+		right = left;
 	if (pslot->put_volume)
 		result = pslot->put_volume(fmixer, pslot, left, right);
 	if (result < 0)
 		return result;
-	fmixer->volume[slot][0] = left;
-	fmixer->volume[slot][1] = right;
+	pslot->volume[0] = left;
+	pslot->volume[1] = right;
  	return (left & 0xff) | ((right & 0xff) << 8);
 }
 
@@ -409,6 +409,7 @@
 	return ((nrange * (val - omin)) + (orange / 2)) / orange + nmin;
 }
 
+/* convert from alsa native to oss values (0-100) */
 static long snd_mixer_oss_conv1(long val, long min, long max, int *old)
 {
 	if (val == snd_mixer_oss_conv(*old, 0, 100, min, max))
@@ -416,6 +417,7 @@
 	return snd_mixer_oss_conv(val, min, max, 0, 100);
 }
 
+/* convert from oss to alsa native values */
 static long snd_mixer_oss_conv2(long val, long min, long max)
 {
 	return snd_mixer_oss_conv(val, 0, 100, min, max);
@@ -502,9 +504,9 @@
 	snd_runtime_check(!kctl->info(kctl, &uinfo), return);
 	snd_runtime_check(!kctl->get(kctl, &uctl), return);
 	snd_runtime_check(uinfo.type != SNDRV_CTL_ELEM_TYPE_BOOLEAN || uinfo.value.integer.min != 0 || uinfo.value.integer.max != 1, return);
-	*left = snd_mixer_oss_conv1(uctl.value.integer.value[0], uinfo.value.integer.min, uinfo.value.integer.max, &fmixer->volume[pslot->number][0]);
+	*left = snd_mixer_oss_conv1(uctl.value.integer.value[0], uinfo.value.integer.min, uinfo.value.integer.max, &pslot->volume[0]);
 	if (uinfo.count > 1)
-		*right = snd_mixer_oss_conv1(uctl.value.integer.value[1], uinfo.value.integer.min, uinfo.value.integer.max, &fmixer->volume[pslot->number][1]);
+		*right = snd_mixer_oss_conv1(uctl.value.integer.value[1], uinfo.value.integer.min, uinfo.value.integer.max, &pslot->volume[1]);
 }
 
 static void snd_mixer_oss_get_volume1_sw(snd_mixer_oss_file_t *fmixer,
diff -Nru a/sound/core/pcm.c b/sound/core/pcm.c
--- a/sound/core/pcm.c	Tue Oct  1 17:09:52 2002
+++ b/sound/core/pcm.c	Tue Oct  1 17:09:52 2002
@@ -541,12 +541,10 @@
 	return 0;
 }
 
-static int snd_pcm_new_stream(snd_pcm_t *pcm,
-			      snd_pcm_str_t *pstr,
-			      int substream_count,
-			      int stream)
+int snd_pcm_new_stream(snd_pcm_t *pcm, int stream, int substream_count)
 {
 	int idx, err;
+	snd_pcm_str_t *pstr = &pcm->streams[stream];
 	snd_pcm_substream_t *substream, *prev;
 
 #if defined(CONFIG_SND_PCM_OSS) || defined(CONFIG_SND_PCM_OSS_MODULE)
@@ -614,11 +612,11 @@
 	if (id) {
 		strncpy(pcm->id, id, sizeof(pcm->id) - 1);
 	}
-	if ((err = snd_pcm_new_stream(pcm, &pcm->streams[SNDRV_PCM_STREAM_PLAYBACK], playback_count, SNDRV_PCM_STREAM_PLAYBACK)) < 0) {
+	if ((err = snd_pcm_new_stream(pcm, SNDRV_PCM_STREAM_PLAYBACK, playback_count)) < 0) {
 		snd_pcm_free(pcm);
 		return err;
 	}
-	if ((err = snd_pcm_new_stream(pcm, &pcm->streams[SNDRV_PCM_STREAM_CAPTURE], capture_count, SNDRV_PCM_STREAM_CAPTURE)) < 0) {
+	if ((err = snd_pcm_new_stream(pcm, SNDRV_PCM_STREAM_CAPTURE, capture_count)) < 0) {
 		snd_pcm_free(pcm);
 		return err;
 	}
@@ -974,6 +972,7 @@
 EXPORT_SYMBOL(snd_pcm_lock);
 EXPORT_SYMBOL(snd_pcm_devices);
 EXPORT_SYMBOL(snd_pcm_new);
+EXPORT_SYMBOL(snd_pcm_new_stream);
 EXPORT_SYMBOL(snd_pcm_notify);
 EXPORT_SYMBOL(snd_pcm_open_substream);
 EXPORT_SYMBOL(snd_pcm_release_substream);
diff -Nru a/sound/core/pcm_sgbuf.c b/sound/core/pcm_sgbuf.c
--- a/sound/core/pcm_sgbuf.c	Tue Oct  1 17:09:52 2002
+++ b/sound/core/pcm_sgbuf.c	Tue Oct  1 17:09:52 2002
@@ -110,7 +110,8 @@
 	if (pages < sgbuf->pages) {
 		/* release unsed pages */
 		sgbuf_shrink(sgbuf, pages);
-		substream->runtime->dma_bytes = size;
+		if (substream->runtime)
+			substream->runtime->dma_bytes = size;
 		return 1; /* changed */
 	} else if (pages > sgbuf->tblsize) {
 		/* bigger than existing one.  reallocate the table. */
@@ -136,7 +137,8 @@
 		changed = 1;
 	}
 	sgbuf->size = size;
-	substream->runtime->dma_bytes = size;
+	if (substream->runtime)
+		substream->runtime->dma_bytes = size;
 	return changed;
 }
 
diff -Nru a/sound/core/wrappers.c b/sound/core/wrappers.c
--- a/sound/core/wrappers.c	Tue Oct  1 17:09:51 2002
+++ b/sound/core/wrappers.c	Tue Oct  1 17:09:51 2002
@@ -59,3 +59,49 @@
 	vfree(obj);
 }
 #endif
+
+
+/* check the condition in <sound/core.h> !! */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
+#if defined(__i386__) || defined(__ppc__) || defined(__x86_64__)
+
+#include <linux/pci.h>
+
+/*
+ * A dirty hack... when the kernel code is fixed this should be removed.
+ *
+ * since pci_alloc_consistent always tries GFP_DMA when the requested
+ * pci memory region is below 32bit, it happens quite often that even
+ * 2 order of pages cannot be allocated.
+ *
+ * so in the following, we allocate at first without dma_mask, so that
+ * allocation will be done without GFP_DMA.  if the area doesn't match
+ * with the requested region, then realloate with the original dma_mask
+ * again.
+ */
+
+void *snd_pci_hack_alloc_consistent(struct pci_dev *hwdev, size_t size,
+				    dma_addr_t *dma_handle)
+{
+	void *ret;
+	u64 dma_mask;
+	unsigned long rmask;
+
+	if (hwdev == NULL)
+		return pci_alloc_consistent(hwdev, size, dma_handle);
+	dma_mask = hwdev->dma_mask;
+	rmask = ~((unsigned long)dma_mask);
+	hwdev->dma_mask = 0xffffffff; /* do without masking */
+	ret = pci_alloc_consistent(hwdev, size, dma_handle);
+	if (ret && ((*dma_handle + size - 1) & rmask)) {
+		pci_free_consistent(hwdev, size, ret, *dma_handle);
+		ret = 0;
+	}
+	hwdev->dma_mask = dma_mask; /* restore */
+	if (! ret)
+		ret = pci_alloc_consistent(hwdev, size, dma_handle);
+	return ret;
+}
+
+#endif
+#endif
diff -Nru a/sound/isa/cmi8330.c b/sound/isa/cmi8330.c
--- a/sound/isa/cmi8330.c	Tue Oct  1 17:09:51 2002
+++ b/sound/isa/cmi8330.c	Tue Oct  1 17:09:51 2002
@@ -46,6 +46,11 @@
 #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#ifndef LINUX_ISAPNP_H
+#include <linux/isapnp.h>
+#define isapnp_card pci_bus
+#define isapnp_dev pci_dev
+#endif
 #include <sound/core.h>
 #include <sound/ad1848.h>
 #include <sound/sb.h>
diff -Nru a/sound/pci/cmipci.c b/sound/pci/cmipci.c
--- a/sound/pci/cmipci.c	Tue Oct  1 17:09:51 2002
+++ b/sound/pci/cmipci.c	Tue Oct  1 17:09:51 2002
@@ -257,6 +257,7 @@
 #define CM_REG_MISC		0x27
 #define CM_XGPO1		0x20
 // #define CM_XGPBIO		0x04
+#define CM_MIC_CENTER_LFE	0x04	/* mic as center/lfe out? (model 039 or later?) */
 #define CM_SPDIF_INVERSE	0x04	/* spdif input phase inverse (model 037) */
 #define CM_SPDVALID		0x02	/* spdif input valid check */
 #define CM_DMAUTO		0x01
@@ -2257,6 +2258,7 @@
 	DEFINE_MIXER_SWITCH("Line-In As Bass", line_bass),
 	DEFINE_MIXER_SWITCH("IEC958 In Select", spdif_in_sel2),
 	DEFINE_MIXER_SWITCH("IEC958 In Phase Inverse", spdi_phase2),
+	DEFINE_MIXER_SWITCH("Mic As Center/LFE", spdi_phase), /* same bit as spdi_phase */
 };
 
 /* card control switches */
diff -Nru a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
--- a/sound/pci/emu10k1/emufx.c	Tue Oct  1 17:09:52 2002
+++ b/sound/pci/emu10k1/emufx.c	Tue Oct  1 17:09:52 2002
@@ -692,20 +692,20 @@
 
 static snd_pcm_hardware_t snd_emu10k1_fx8010_playback =
 {
-	info:			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
+	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 /* SNDRV_PCM_INFO_MMAP_VALID | */ SNDRV_PCM_INFO_PAUSE),
-	formats:		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
-	rates:			SNDRV_PCM_RATE_48000,
-	rate_min:		48000,
-	rate_max:		48000,
-	channels_min:		1,
-	channels_max:		1,
-	buffer_bytes_max:	(128*1024),
-	period_bytes_min:	1024,
-	period_bytes_max:	(128*1024),
-	periods_min:		1,
-	periods_max:		1024,
-	fifo_size:		0,
+	.formats =		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =		SNDRV_PCM_RATE_48000,
+	.rate_min =		48000,
+	.rate_max =		48000,
+	.channels_min =		1,
+	.channels_max =		1,
+	.buffer_bytes_max =	(128*1024),
+	.period_bytes_min =	1024,
+	.period_bytes_max =	(128*1024),
+	.periods_min =		1,
+	.periods_max =		1024,
+	.fifo_size =		0,
 };
 
 static int snd_emu10k1_fx8010_playback_open(snd_pcm_substream_t * substream)
diff -Nru a/sound/pci/es1968.c b/sound/pci/es1968.c
--- a/sound/pci/es1968.c	Tue Oct  1 17:09:52 2002
+++ b/sound/pci/es1968.c	Tue Oct  1 17:09:52 2002
@@ -1363,45 +1363,45 @@
 }
 
 static snd_pcm_hardware_t snd_es1968_playback = {
-	info:			(SNDRV_PCM_INFO_MMAP |
+	.info =			(SNDRV_PCM_INFO_MMAP |
                		         SNDRV_PCM_INFO_MMAP_VALID |
 				 SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 /*SNDRV_PCM_INFO_PAUSE |*/
 				 SNDRV_PCM_INFO_RESUME),
-	formats:		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
-	rates:			SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
-	rate_min:		4000,
-	rate_max:		48000,
-	channels_min:		1,
-	channels_max:		2,
-	buffer_bytes_max:	65536,
-	period_bytes_min:	256,
-	period_bytes_max:	65536,
-	periods_min:		1,
-	periods_max:		1024,
-	fifo_size:		0,
+	.formats =		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =		SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
+	.rate_min =		4000,
+	.rate_max =		48000,
+	.channels_min =		1,
+	.channels_max =		2,
+	.buffer_bytes_max =	65536,
+	.period_bytes_min =	256,
+	.period_bytes_max =	65536,
+	.periods_min =		1,
+	.periods_max =		1024,
+	.fifo_size =		0,
 };
 
 static snd_pcm_hardware_t snd_es1968_capture = {
-	info:			(SNDRV_PCM_INFO_NONINTERLEAVED |
+	.info =			(SNDRV_PCM_INFO_NONINTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_MMAP_VALID |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 /*SNDRV_PCM_INFO_PAUSE |*/
 				 SNDRV_PCM_INFO_RESUME),
-	formats:		/*SNDRV_PCM_FMTBIT_U8 |*/ SNDRV_PCM_FMTBIT_S16_LE,
-	rates:			SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
-	rate_min:		4000,
-	rate_max:		48000,
-	channels_min:		1,
-	channels_max:		2,
-	buffer_bytes_max:	65536,
-	period_bytes_min:	256,
-	period_bytes_max:	65536,
-	periods_min:		1,
-	periods_max:		1024,
-	fifo_size:		0,
+	.formats =		/*SNDRV_PCM_FMTBIT_U8 |*/ SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =		SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
+	.rate_min =		4000,
+	.rate_max =		48000,
+	.channels_min =		1,
+	.channels_max =		2,
+	.buffer_bytes_max =	65536,
+	.period_bytes_min =	256,
+	.period_bytes_max =	65536,
+	.periods_min =		1,
+	.periods_max =		1024,
+	.fifo_size =		0,
 };
 
 /* *************************
diff -Nru a/sound/pci/ice1712.c b/sound/pci/ice1712.c
--- a/sound/pci/ice1712.c	Tue Oct  1 17:09:52 2002
+++ b/sound/pci/ice1712.c	Tue Oct  1 17:09:52 2002
@@ -1186,7 +1186,7 @@
 {
 	unsigned long flags;
 	unsigned int rate;
-	unsigned char val, tmp;
+	unsigned char val, tmp, tmp2;
 
 	spin_lock_irqsave(&ice->reg_lock, flags);
 	if (inb(ICEMT(ice, PLAYBACK_CONTROL)) & (ICE1712_CAPTURE_START_SHADOW|
@@ -1224,17 +1224,25 @@
 	case ICE1712_SUBDEVICE_DELTA44:
 	case ICE1712_SUBDEVICE_AUDIOPHILE:
 		spin_unlock_irqrestore(&ice->reg_lock, flags);
-		snd_ice1712_ak4524_reset(ice, 1);
 		down(&ice->gpio_mutex);
 		tmp = snd_ice1712_read(ice, ICE1712_IREG_GPIO_DATA);
-		if (val == 15 || val == 11 || val == 7) {
-			tmp |= ICE1712_DELTA_DFS;
-		} else {
-			tmp &= ~ICE1712_DELTA_DFS;
-		}
-		snd_ice1712_write(ice, ICE1712_IREG_GPIO_DATA, tmp);
 		up(&ice->gpio_mutex);
-		snd_ice1712_ak4524_reset(ice, 0);
+		tmp2 = tmp;
+		tmp2 &= ~ICE1712_DELTA_DFS; 
+		if (val == 15 || val == 11 || val == 7)
+			tmp2 |= ICE1712_DELTA_DFS;
+		if (tmp != tmp2) {
+			snd_ice1712_ak4524_reset(ice, 1);
+			down(&ice->gpio_mutex);
+			tmp = snd_ice1712_read(ice, ICE1712_IREG_GPIO_DATA);
+			if (val == 15 || val == 11 || val == 7)
+				tmp |= ICE1712_DELTA_DFS;
+			else
+				tmp &= ~ICE1712_DELTA_DFS;
+			snd_ice1712_write(ice, ICE1712_IREG_GPIO_DATA, tmp);
+			up(&ice->gpio_mutex);
+			snd_ice1712_ak4524_reset(ice, 0);
+		}
 		return;
 	}
       __end:
diff -Nru a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
--- a/sound/pci/intel8x0.c	Tue Oct  1 17:09:52 2002
+++ b/sound/pci/intel8x0.c	Tue Oct  1 17:09:52 2002
@@ -2147,7 +2147,8 @@
 	chip->pci = pci;
 	chip->irq = -1;
 	snd_intel8x0_proc_init(chip);
-	if (pci_resource_flags(pci, 2) & IORESOURCE_MEM) {	/* ICH4 and higher */
+	if (chip->device_type == DEVICE_INTEL_ICH4 &&
+	    (pci_resource_flags(pci, 2) & IORESOURCE_MEM)) {	/* ICH4 and higher */
 		chip->mmio = chip->bm_mmio = 1;
 		chip->addr = pci_resource_start(pci, 2);
 		sprintf(chip->ac97_name, "%s - AC'97", card->shortname);
diff -Nru a/sound/pci/maestro3.c b/sound/pci/maestro3.c
--- a/sound/pci/maestro3.c	Tue Oct  1 17:09:52 2002
+++ b/sound/pci/maestro3.c	Tue Oct  1 17:09:52 2002
@@ -779,6 +779,7 @@
 
 /* quirk lists */
 struct m3_quirk {
+	const char *name;	/* device name */
 	u16 vendor, device;	/* subsystem ids */
 	int amp_gpio;		/* gpio pin #  for external amp, -1 = default */
 	int irda_workaround;	/* non-zero if avoid to touch 0x10 on GPIO_DIRECTION
@@ -918,23 +919,33 @@
 static struct m3_quirk m3_quirk_list[] = {
 	/* panasonic CF-28 "toughbook" */
 	{
-		vendor: 0x10f7,
-		device: 0x833e,
-		amp_gpio: 0x0d,
+		.name = "Panasonic CF-28",
+		.vendor = 0x10f7,
+		.device = 0x833e,
+		.amp_gpio = 0x0d,
+	},
+	/* panasonic CF-72 "toughbook" */
+	{
+		.name = "Panasonic CF-72",
+		.vendor = 0x10f7,
+		.device = 0x833d,
+		.amp_gpio = 0x0d,
 	},
 	/* Dell Inspiron 4000 */
 	{
-		vendor: 0x1028,
-		device: 0x00b0,
-		amp_gpio: -1,
-		irda_workaround: 1,
+		.name = "Dell Inspiron 4000",
+		.vendor = 0x1028,
+		.device = 0x00b0,
+		.amp_gpio = -1,
+		.irda_workaround = 1,
 	},
 	/* Dell Inspiron 8000 */
 	{
-		vendor: 0x1028,
-		device: 0x00a4,
-		amp_gpio: -1,
-		irda_workaround: 1,
+		.name = "Dell Insprion 8000",
+		.vendor = 0x1028,
+		.device = 0x00a4,
+		.amp_gpio = -1,
+		.irda_workaround = 1,
 	},
 	/* FIXME: Inspiron 8100 and 8200 ids should be here, too */
 	/* END */
@@ -1581,44 +1592,44 @@
 
 static snd_pcm_hardware_t snd_m3_playback =
 {
-	info:			(SNDRV_PCM_INFO_MMAP |
+	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 /*SNDRV_PCM_INFO_PAUSE |*/
 				 SNDRV_PCM_INFO_RESUME),
-	formats:		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
-	rates:			SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
-	rate_min:		8000,
-	rate_max:		48000,
-	channels_min:		1,
-	channels_max:		2,
-	buffer_bytes_max:	(512*1024),
-	period_bytes_min:	64,
-	period_bytes_max:	(512*1024),
-	periods_min:		1,
-	periods_max:		1024,
+	.formats =		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =		SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
+	.rate_min =		8000,
+	.rate_max =		48000,
+	.channels_min =		1,
+	.channels_max =		2,
+	.buffer_bytes_max =	(512*1024),
+	.period_bytes_min =	64,
+	.period_bytes_max =	(512*1024),
+	.periods_min =		1,
+	.periods_max =		1024,
 };
 
 static snd_pcm_hardware_t snd_m3_capture =
 {
-	info:			(SNDRV_PCM_INFO_MMAP |
+	.info =			(SNDRV_PCM_INFO_MMAP |
 				 SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_MMAP_VALID |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 /*SNDRV_PCM_INFO_PAUSE |*/
 				 SNDRV_PCM_INFO_RESUME),
-	formats:		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
-	rates:			SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
-	rate_min:		8000,
-	rate_max:		48000,
-	channels_min:		1,
-	channels_max:		2,
-	buffer_bytes_max:	(512*1024),
-	period_bytes_min:	64,
-	period_bytes_max:	(512*1024),
-	periods_min:		1,
-	periods_max:		1024,
+	.formats =		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =		SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
+	.rate_min =		8000,
+	.rate_max =		48000,
+	.channels_min =		1,
+	.channels_max =		2,
+	.buffer_bytes_max =	(512*1024),
+	.period_bytes_min =	64,
+	.period_bytes_max =	(512*1024),
+	.periods_min =		1,
+	.periods_max =		1024,
 };
 
 
@@ -2547,6 +2558,7 @@
 	for (quirk = m3_quirk_list; quirk->vendor; quirk++) {
 		if (subsystem_vendor == quirk->vendor &&
 		    subsystem_device == quirk->device) {
+			printk(KERN_INFO "maestro3: enabled hack for '%s'\n", quirk->name);
 			chip->quirk = quirk;
 			break;
 		}
diff -Nru a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
--- a/sound/pci/nm256/nm256.c	Tue Oct  1 17:09:52 2002
+++ b/sound/pci/nm256/nm256.c	Tue Oct  1 17:09:52 2002
@@ -751,46 +751,46 @@
  */
 static snd_pcm_hardware_t snd_nm256_playback =
 {
-	info:
+	.info =
 #ifdef __i386__
 				SNDRV_PCM_INFO_MMAP|SNDRV_PCM_INFO_MMAP_VALID|
 #endif
 				SNDRV_PCM_INFO_INTERLEAVED |
 				/*SNDRV_PCM_INFO_PAUSE |*/
 				SNDRV_PCM_INFO_RESUME,
-	formats:		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
-	rates:			SNDRV_PCM_RATE_KNOT/*24k*/ | SNDRV_PCM_RATE_8000_48000,
-	rate_min:		8000,
-	rate_max:		48000,
-	channels_min:		1,
-	channels_max:		2,
-	periods_min:		2,
-	periods_max:		1024,
-	buffer_bytes_max:	128 * 1024,
-	period_bytes_min:	256,
-	period_bytes_max:	128 * 1024,
+	.formats =		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =		SNDRV_PCM_RATE_KNOT/*24k*/ | SNDRV_PCM_RATE_8000_48000,
+	.rate_min =		8000,
+	.rate_max =		48000,
+	.channels_min =		1,
+	.channels_max =		2,
+	.periods_min =		2,
+	.periods_max =		1024,
+	.buffer_bytes_max =	128 * 1024,
+	.period_bytes_min =	256,
+	.period_bytes_max =	128 * 1024,
 };
 
 static snd_pcm_hardware_t snd_nm256_capture =
 {
-	info:
+	.info =
 #ifdef __i386__
 				SNDRV_PCM_INFO_MMAP|SNDRV_PCM_INFO_MMAP_VALID|
 #endif
 				SNDRV_PCM_INFO_INTERLEAVED |
 				/*SNDRV_PCM_INFO_PAUSE |*/
 				SNDRV_PCM_INFO_RESUME,
-	formats:		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
-	rates:			SNDRV_PCM_RATE_KNOT/*24k*/ | SNDRV_PCM_RATE_8000_48000,
-	rate_min:		8000,
-	rate_max:		48000,
-	channels_min:		1,
-	channels_max:		2,
-	periods_min:		2,
-	periods_max:		1024,
-	buffer_bytes_max:	128 * 1024,
-	period_bytes_min:	256,
-	period_bytes_max:	128 * 1024,
+	.formats =		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =		SNDRV_PCM_RATE_KNOT/*24k*/ | SNDRV_PCM_RATE_8000_48000,
+	.rate_min =		8000,
+	.rate_max =		48000,
+	.channels_min =		1,
+	.channels_max =		2,
+	.periods_min =		2,
+	.periods_max =		1024,
+	.buffer_bytes_max =	128 * 1024,
+	.period_bytes_min =	256,
+	.period_bytes_max =	128 * 1024,
 };
 
 
diff -Nru a/sound/pci/rme9652/hammerfall_mem.c b/sound/pci/rme9652/hammerfall_mem.c
--- a/sound/pci/rme9652/hammerfall_mem.c	Tue Oct  1 17:09:51 2002
+++ b/sound/pci/rme9652/hammerfall_mem.c	Tue Oct  1 17:09:51 2002
@@ -25,7 +25,7 @@
     along with this program; if not, write to the Free Software
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 
-    $Id: hammerfall_mem.c,v 1.2 2002/06/19 08:52:11 perex Exp $
+    $Id: hammerfall_mem.c,v 1.3 2002/09/12 09:03:28 tiwai Exp $
 
 
     Tue Oct 17 2000  Jaroslav Kysela <perex@suse.cz>
@@ -92,11 +92,6 @@
    memory after starting things running, that would be very
    undesirable.  
 */
-
-/* remove hack for pci_alloc_consistent to avoid dependecy on snd module */
-#ifdef HACK_PCI_ALLOC_CONSISTENT
-#undef pci_alloc_consistent
-#endif
 
 static void *hammerfall_malloc_pages(struct pci_dev *pci,
 				  unsigned long size,
diff -Nru a/sound/pci/via82xx.c b/sound/pci/via82xx.c
--- a/sound/pci/via82xx.c	Tue Oct  1 17:09:52 2002
+++ b/sound/pci/via82xx.c	Tue Oct  1 17:09:52 2002
@@ -977,20 +977,22 @@
 		/* disable all legacy ports */
 		pci_write_config_byte(chip->pci, 0x42, 0);
 #endif
-
-	/* deassert ACLink reset, force SYNC */
-	pci_write_config_byte(chip->pci, 0x41, 0xe0);
-	udelay(100);
-	/* deassert ACLink reset, force SYNC (warm AC'97 reset) */
-	pci_write_config_byte(chip->pci, 0x41, 0x60);
-	udelay(2);
-	/* pci_write_config_byte(chip->pci, 0x41, 0x00);
-	   udelay(100);
-	*/
-	/* ACLink on, deassert ACLink reset, VSR, SGD data out */
-	/* note - FM data out has trouble with non VRA codecs !! */
-	pci_write_config_byte(chip->pci, 0x41, 0xcc);
-	udelay(100);
+	pci_read_config_byte(chip->pci, 0x40, &pval);
+	if (! (pval & 0x01)) { /* codec not ready? */
+		/* deassert ACLink reset, force SYNC */
+		pci_write_config_byte(chip->pci, 0x41, 0xe0);
+		udelay(100);
+		/* deassert ACLink reset, force SYNC (warm AC'97 reset) */
+		pci_write_config_byte(chip->pci, 0x41, 0x60);
+		udelay(2);
+		/* pci_write_config_byte(chip->pci, 0x41, 0x00);
+		   udelay(100);
+		*/
+		/* ACLink on, deassert ACLink reset, VSR, SGD data out */
+		/* note - FM data out has trouble with non VRA codecs !! */
+		pci_write_config_byte(chip->pci, 0x41, 0xcc);
+		udelay(100);
+	}
 	
 	/* Make sure VRA is enabled, in case we didn't do a
 	 * complete codec reset, above */
diff -Nru a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
--- a/sound/usb/usbaudio.c	Tue Oct  1 17:09:52 2002
+++ b/sound/usb/usbaudio.c	Tue Oct  1 17:09:52 2002
@@ -105,6 +105,7 @@
 	struct list_head list;
 	snd_pcm_format_t format;	/* format type */
 	int channels;			/* # channels */
+	int iface;			/* interface number */
 	unsigned char altsetting;	/* corresponding alternate setting */
 	unsigned char altset_idx;	/* array index of altenate setting */
 	unsigned char attributes;	/* corresponding attributes of cs endpoint */
@@ -136,7 +137,9 @@
 	snd_usb_stream_t *stream;
 	struct usb_device *dev;
 	snd_pcm_substream_t *pcm_substream;
-	int interface;           /* Interface number, -1 means not used */
+	int direction;	/* playback or capture */
+	int interface;	/* current interface */
+	int endpoint;	/* assigned endpoint */
 	unsigned int format;     /* USB data format */
 	unsigned int datapipe;   /* the data i/o pipe */
 	unsigned int syncpipe;   /* 1 - async out or adaptive in */
@@ -492,6 +495,23 @@
 
 
 /*
+ */
+static struct snd_urb_ops audio_urb_ops[2] = {
+	{
+		.prepare =	prepare_playback_urb,
+		.retire =	retire_playback_urb,
+		.prepare_sync =	prepare_playback_sync_urb,
+		.retire_sync =	retire_playback_sync_urb,
+	},
+	{
+		.prepare =	prepare_capture_urb,
+		.retire =	retire_capture_urb,
+		.prepare_sync =	prepare_capture_sync_urb,
+		.retire_sync =	retire_capture_sync_urb,
+	},
+};
+
+/*
  * complete callback from data urb
  */
 static void snd_complete_urb(struct urb *urb)
@@ -738,7 +758,7 @@
 static int init_substream_urbs(snd_usb_substream_t *subs, snd_pcm_runtime_t *runtime)
 {
 	int maxsize, n, i;
-	int is_playback = subs->pcm_substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+	int is_playback = subs->direction == SNDRV_PCM_STREAM_PLAYBACK;
 	int npacks[MAX_URBS], total_packs;
 
 	/* calculate the frequency in 10.14 format */
@@ -907,7 +927,7 @@
 	struct audioformat *fmt;
 	unsigned int ep, attr;
 	unsigned char data[3];
-	int is_playback = subs->pcm_substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+	int is_playback = subs->direction == SNDRV_PCM_STREAM_PLAYBACK;
 	int err;
 
 	fmt = find_format(subs, runtime);
@@ -917,7 +937,7 @@
 		return -EINVAL;
 	}
 
-	iface = &config->interface[subs->interface];
+	iface = &config->interface[fmt->iface];
 	alts = &iface->altsetting[fmt->altset_idx];
 	snd_assert(alts->bAlternateSetting == fmt->altsetting, return -EINVAL);
 
@@ -927,6 +947,7 @@
 		subs->datapipe = usb_sndisocpipe(dev, ep);
 	else
 		subs->datapipe = usb_rcvisocpipe(dev, ep);
+	subs->interface = fmt->iface;
 	subs->format = fmt->altset_idx;
 	subs->syncpipe = subs->syncinterval = 0;
 	subs->maxpacksize = alts->endpoint[0].wMaxPacketSize;
@@ -1126,6 +1147,7 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	snd_usb_substream_t *subs = &as->substream[direction];
 
+	subs->interface = -1;
 	runtime->hw = *hw;
 	runtime->private_data = subs;
 	subs->pcm_substream = substream;
@@ -1139,7 +1161,8 @@
 	snd_usb_stream_t *as = snd_pcm_substream_chip(substream);
 	snd_usb_substream_t *subs = &as->substream[direction];
 	release_substream_urbs(subs);
-	usb_set_interface(subs->dev, subs->interface, 0);
+	if (subs->interface >= 0)
+		usb_set_interface(subs->dev, subs->interface, 0);
 	subs->pcm_substream = NULL;
 	return 0;
 }
@@ -1286,290 +1309,6 @@
 
 
 /*
- * intialize the substream instance.
- */
-
-static void init_substream(snd_usb_stream_t *stream, snd_usb_substream_t *subs,
-			   int iface_no, int is_input,
-			   unsigned char *buffer, int buflen)
-{
-	struct usb_device *dev;
-	struct usb_config_descriptor *config;
-	struct usb_interface *iface;
-	struct usb_interface_descriptor *alts;
-	int i, pcm_format, altno;
-	int format, channels, format_type, nr_rates;
-	struct audioformat *fp;
-	unsigned char *fmt, *csep;
-
-	dev = stream->chip->dev;
-	config = dev->actconfig;
-
-	subs->stream = stream;
-	subs->dev = dev;
-	subs->interface = iface_no;
-	INIT_LIST_HEAD(&subs->fmt_list);
-	spin_lock_init(&subs->lock);
-	if (is_input) {
-		subs->ops.prepare = prepare_capture_urb;
-		subs->ops.retire = retire_capture_urb;
-		subs->ops.prepare_sync = prepare_capture_sync_urb;
-		subs->ops.retire_sync = retire_capture_sync_urb;
-	} else {
-		subs->ops.prepare = prepare_playback_urb;
-		subs->ops.retire = retire_playback_urb;
-		subs->ops.prepare_sync = prepare_playback_sync_urb;
-		subs->ops.retire_sync = retire_playback_sync_urb;
-	}
-
-	if (iface_no < 0)
-		return;
-
-	/* parse the interface's altsettings */
-	iface = &config->interface[iface_no];
-	for (i = 0; i < iface->num_altsetting; i++) {
-		alts = &iface->altsetting[i];
-		/* skip invalid one */
-		if (alts->bInterfaceClass != USB_CLASS_AUDIO ||
-		    alts->bInterfaceSubClass != USB_SUBCLASS_AUDIO_STREAMING ||
-		    alts->bNumEndpoints < 1)
-			continue;
-		/* must be isochronous */
-		if ((alts->endpoint[0].bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) !=
-		    USB_ENDPOINT_XFER_ISOC)
-			continue;
-		/* check direction */
-		if (alts->endpoint[0].bEndpointAddress & USB_DIR_IN) {
-			if (! is_input)
-				continue;
-		} else {
-			if (is_input)
-				continue;
-		}
-
-		altno = alts->bAlternateSetting;
-
-		/* get audio formats */
-		fmt = snd_usb_find_csint_desc(buffer, buflen, NULL, AS_GENERAL, iface_no, altno);
-		if (!fmt) {
-			snd_printk(KERN_ERR "%d:%u:%d : AS_GENERAL descriptor not found\n",
-				   dev->devnum, iface_no, altno);
-			continue;
-		}
-
-		if (fmt[0] < 7) {
-			snd_printk(KERN_ERR "%d:%u:%d : invalid AS_GENERAL desc\n", 
-				   dev->devnum, iface_no, altno);
-			continue;
-		}
-
-		format = (fmt[6] << 8) | fmt[5]; /* remember the format value */
-			
-		/* get format type */
-		fmt = snd_usb_find_csint_desc(buffer, buflen, NULL, FORMAT_TYPE, iface_no, altno);
-		if (!fmt) {
-			snd_printk(KERN_ERR "%d:%u:%d : no FORMAT_TYPE desc\n", 
-				   dev->devnum, iface_no, altno);
-			continue;
-		}
-		if (fmt[0] < 8) {
-			snd_printk(KERN_ERR "%d:%u:%d : invalid FORMAT_TYPE desc\n", 
-				   dev->devnum, iface_no, altno);
-			continue;
-		}
-
-		format_type = fmt[3];
-		/* FIXME: needed support for TYPE II and III */
-		if (format_type != USB_FORMAT_TYPE_I) {
-			snd_printd(KERN_INFO "%d:%u:%d : format type %d is not supported yet\n",
-				   dev->devnum, iface_no, altno, format_type);
-			continue;
-		}
-
-		nr_rates = fmt[7];
-		if (fmt[0] < 8 + 3 * (nr_rates ? nr_rates : 2)) {
-			snd_printk(KERN_ERR "%d:%u:%d : invalid FORMAT_TYPE desc\n", 
-				   dev->devnum, iface_no, altno);
-			continue;
-		}
-
-		/* FIXME: correct endianess and sign? */
-		pcm_format = -1;
-		switch (format) {
-		case USB_AUDIO_FORMAT_PCM:
-			/* check the format byte size */
-			switch (fmt[6]) {
-			case 8:
-				subs->formats |= SNDRV_PCM_FMTBIT_U8;
-				pcm_format = SNDRV_PCM_FORMAT_U8;
-				break;
-			case 16:
-				subs->formats |= SNDRV_PCM_FMTBIT_S16_LE;
-				pcm_format = SNDRV_PCM_FORMAT_S16_LE;
-				break;
-			case 18:
-			case 20:
-				if (fmt[5] == 3) {
-					subs->formats |= SNDRV_PCM_FMTBIT_S24_3LE;
-					pcm_format = SNDRV_PCM_FORMAT_S24_3LE;
-				} else {
-					snd_printk(KERN_ERR "%d:%u:%d : non-supported sample bit %d in %d bytes\n",
-						   dev->devnum, iface_no, altno, fmt[6], fmt[5]);
-				}
-				break;
-			case 24:
-				if (fmt[5] == 4) {
-					/* FIXME: correct?  or S32_LE? */
-					subs->formats |= SNDRV_PCM_FMTBIT_S24_LE;
-					pcm_format = SNDRV_PCM_FORMAT_S24_LE;
-				} else if (fmt[5] == 3) {
-					subs->formats |= SNDRV_PCM_FMTBIT_S24_3LE;
-					pcm_format = SNDRV_PCM_FORMAT_S24_3LE;
-				} else {
-					snd_printk(KERN_ERR "%d:%u:%d : non-supported sample bit %d in %d bytes\n",
-						   dev->devnum, iface_no, altno, format, fmt[5]);
-				}
-				break;
-			case 32:
-				subs->formats |= SNDRV_PCM_FMTBIT_S32_LE;
-				pcm_format = SNDRV_PCM_FORMAT_S32_LE;
-				break;
-			default:
-				snd_printk(KERN_INFO "%d:%u:%d : unsupported sample bitwidth %d in %d bytes\n",
-					   dev->devnum, iface_no, altno, fmt[6], fmt[5]);
-				break;
-			}
-			break;
-		case USB_AUDIO_FORMAT_PCM8:
-			/* Dallas DS4201 workaround */
-			if (dev->descriptor.idVendor == 0x04fa && dev->descriptor.idProduct == 0x4201) {
-				subs->formats |= ~SNDRV_PCM_FMTBIT_S8;
-				pcm_format = SNDRV_PCM_FORMAT_S8;
-			} else {
-				subs->formats |= SNDRV_PCM_FMTBIT_U8;
-				pcm_format = SNDRV_PCM_FORMAT_U8;
-			}
-			break;
-		case USB_AUDIO_FORMAT_IEEE_FLOAT:
-			subs->formats |= SNDRV_PCM_FMTBIT_FLOAT_LE;
-			pcm_format = SNDRV_PCM_FORMAT_FLOAT_LE;
-			break;
-		case USB_AUDIO_FORMAT_ALAW:
-			subs->formats |= SNDRV_PCM_FMTBIT_A_LAW;
-			pcm_format = SNDRV_PCM_FORMAT_A_LAW;
-			break;
-		case USB_AUDIO_FORMAT_MU_LAW:
-			subs->formats |= SNDRV_PCM_FMTBIT_MU_LAW;
-			pcm_format = SNDRV_PCM_FORMAT_MU_LAW;
-			break;
-		default:
-			snd_printk(KERN_INFO "%d:%u:%d : unsupported format type %d\n",
-				   dev->devnum, iface_no, altno, format);
-			break;
-		}
-
-		if (pcm_format < 0)
-			continue;
-
-		channels = fmt[4];
-		if (channels < 1) {
-			snd_printk(KERN_ERR "%d:%u:%d : invalid channels %d\n",
-				   dev->devnum, iface_no, altno, channels);
-			continue;
-		}
-
-		csep = snd_usb_find_desc(buffer, buflen, NULL, USB_DT_CS_ENDPOINT, iface_no, altno);
-		if (!csep || csep[0] < 7 || csep[2] != EP_GENERAL) {
-			snd_printk(KERN_ERR "%d:%u:%d : no or invalid class specific endpoint descriptor\n", 
-				   dev->devnum, iface_no, altno);
-			continue;
-		}
-
-		fp = kmalloc(sizeof(*fp), GFP_KERNEL);
-		if (! fp) {
-			snd_printk(KERN_ERR "cannot malloc\n");
-			break;
-		}
-
-		memset(fp, 0, sizeof(*fp));
-		fp->format = pcm_format;
-		fp->altsetting = altno;
-		fp->altset_idx = i;
-		fp->endpoint = alts->endpoint[0].bEndpointAddress;
-		fp->ep_attr = alts->endpoint[0].bmAttributes;
-		fp->channels = channels;
-		fp->attributes = csep[3];
-
-		if (nr_rates) {
-			/*
-			 * build the rate table and bitmap flags
-			 */
-			int r, idx, c;
-			/* this table corresponds to the SNDRV_PCM_RATE_XXX bit */
-			static int conv_rates[] = {
-				5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000,
-				64000, 88200, 96000, 176400, 192000
-			};
-			fp->rate_table = kmalloc(sizeof(int) * nr_rates, GFP_KERNEL);
-			if (fp->rate_table == NULL) {
-				snd_printk(KERN_ERR "cannot malloc\n");
-				kfree(fp);
-				break;
-			}
-
-			fp->nr_rates = nr_rates;
-			fp->rate_min = fp->rate_max = combine_triple(&fmt[8]);
-			for (r = 0, idx = 8; r < nr_rates; r++, idx += 3) {
-				int rate = fp->rate_table[r] = combine_triple(&fmt[idx]);
-				if (rate < fp->rate_min)
-					fp->rate_min = rate;
-				else if (rate > fp->rate_max)
-					fp->rate_max = rate;
-				for (c = 0; c < 13; c++) {
-					if (rate == conv_rates[c]) {
-						fp->rates |= (1 << c);
-						break;
-					}
-				}
-#if 0 // FIXME - we need to define constraint
-				if (c >= 13)
-					fp->rates |= SNDRV_PCM_KNOT; /* unconventional rate */
-#endif
-			}
-
-		} else {
-			/* continuous rates */
-			fp->rates = SNDRV_PCM_RATE_CONTINUOUS;
-			fp->rate_min = combine_triple(&fmt[8]);
-			fp->rate_max = combine_triple(&fmt[11]);
-		}
-
-		list_add_tail(&fp->list, &subs->fmt_list);
-		subs->num_formats++;
-	}
-}
-
-
-/*
- * free a substream
- */
-static void free_substream(snd_usb_substream_t *subs)
-{
-	struct list_head *p, *n;
-
-	if (subs->interface < 0)
-		return;
-
-	list_for_each_safe(p, n, &subs->fmt_list) {
-		struct audioformat *fp = list_entry(p, struct audioformat, list);
-		if (fp->rate_table)
-			kfree(fp->rate_table);
-		kfree(fp);
-	}
-}
-
-
-/*
  * proc interface for list the supported pcm formats
  */
 static void proc_dump_substream_formats(snd_usb_substream_t *subs, snd_info_buffer_t *buffer)
@@ -1582,7 +1321,8 @@
 	list_for_each(p, &subs->fmt_list) {
 		struct audioformat *fp;
 		fp = list_entry(p, struct audioformat, list);
-		snd_iprintf(buffer, "  Altset %d\n", fp->altset_idx);
+		snd_iprintf(buffer, "  Interface %d\n", fp->iface);
+		snd_iprintf(buffer, "    Altset %d\n", fp->altset_idx);
 		snd_iprintf(buffer, "    Format: %s\n", snd_pcm_format_name(fp->format));
 		snd_iprintf(buffer, "    Channels: %d\n", fp->channels);
 		snd_iprintf(buffer, "    Endpoint: %d %s (%s)\n",
@@ -1610,6 +1350,7 @@
 	if (subs->running) {
 		int i;
 		snd_iprintf(buffer, "  Status: Running\n");
+		snd_iprintf(buffer, "    Interface = %d\n", subs->interface);
 		snd_iprintf(buffer, "    Altset = %d\n", subs->format);
 		snd_iprintf(buffer, "    URBs = %d [ ", subs->nurbs);
 		for (i = 0; i < subs->nurbs; i++)
@@ -1665,6 +1406,52 @@
 
 
 /*
+ * intialize the substream instance.
+ */
+
+static void init_substream(snd_usb_stream_t *as, int stream, struct audioformat *fp)
+{
+	snd_usb_substream_t *subs = &as->substream[stream];
+
+	INIT_LIST_HEAD(&subs->fmt_list);
+	spin_lock_init(&subs->lock);
+
+	subs->stream = as;
+	subs->direction = stream;
+	subs->dev = as->chip->dev;
+	subs->ops = audio_urb_ops[stream];
+	snd_pcm_lib_preallocate_pages(as->pcm->streams[stream].substream,
+				      64 * 1024, 128 * 1024, GFP_ATOMIC);
+	snd_pcm_set_ops(as->pcm, stream,
+			stream == SNDRV_PCM_STREAM_PLAYBACK ?
+			&snd_usb_playback_ops : &snd_usb_capture_ops);
+
+	list_add_tail(&fp->list, &subs->fmt_list);
+	subs->formats |= 1ULL << fp->format;
+	subs->endpoint = fp->endpoint;
+	subs->num_formats++;
+}
+
+
+/*
+ * free a substream
+ */
+static void free_substream(snd_usb_substream_t *subs)
+{
+	struct list_head *p, *n;
+
+	if (! subs->num_formats)
+		return; /* not initialized */
+	list_for_each_safe(p, n, &subs->fmt_list) {
+		struct audioformat *fp = list_entry(p, struct audioformat, list);
+		if (fp->rate_table)
+			kfree(fp->rate_table);
+		kfree(fp);
+	}
+}
+
+
+/*
  * free a usb stream instance
  */
 static void snd_usb_audio_stream_free(snd_usb_stream_t *stream)
@@ -1689,57 +1476,71 @@
 	}
 }
 
-static int snd_usb_audio_stream_new(snd_usb_audio_t *chip, unsigned char *buffer, int buflen, int asifin, int asifout)
+
+/*
+ * add this endpoint to the chip instance.
+ * if a stream with the same endpoint already exists, append to it.
+ * if not, create a new pcm stream.
+ */
+static int add_audio_endpoint(snd_usb_audio_t *chip, int stream, struct audioformat *fp)
 {
+	struct list_head *p;
 	snd_usb_stream_t *as;
+	snd_usb_substream_t *subs;
 	snd_pcm_t *pcm;
-	char name[32];
 	int err;
 
-	as = snd_magic_kmalloc(snd_usb_stream_t, 0, GFP_KERNEL);
-	if (as == NULL) {
-		snd_printk(KERN_ERR "cannot malloc\n");
-		return -ENOMEM;
+	list_for_each(p, &chip->pcm_list) {
+		as = list_entry(p, snd_usb_stream_t, list);
+		subs = &as->substream[stream];
+		if (! subs->endpoint)
+			break;
+		if (subs->endpoint == fp->endpoint) {
+			list_add_tail(&fp->list, &subs->fmt_list);
+			subs->num_formats++;
+			subs->formats |= 1ULL << fp->format;
+			return 0;
+		}
 	}
-	memset(as, 0, sizeof(*as));
-	as->chip = chip;
-	INIT_LIST_HEAD(&as->list);
-
-	init_substream(as, &as->substream[SNDRV_PCM_STREAM_PLAYBACK], asifout, 0, buffer, buflen);
-	init_substream(as, &as->substream[SNDRV_PCM_STREAM_CAPTURE], asifin, 1, buffer, buflen);
-
-	if (as->substream[0].num_formats == 0 && as->substream[1].num_formats == 0) {
-		snd_usb_audio_stream_free(as);
+	/* look for an empty stream */
+	list_for_each(p, &chip->pcm_list) {
+		as = list_entry(p, snd_usb_stream_t, list);
+		subs = &as->substream[stream];
+		if (subs->endpoint)
+			continue;
+		err = snd_pcm_new_stream(as->pcm, stream, 1);
+		if (err < 0)
+			return err;
+		init_substream(as, stream, fp);
 		return 0;
 	}
 
-	if (chip->pcm_devs > 0)
-		sprintf(name, "USB Audio #%d", chip->pcm_devs);
-	else
-		strcpy(name, "USB Audio");
+	/* create a new pcm */
+	as = snd_magic_kmalloc(snd_usb_stream_t, 0, GFP_KERNEL);
+	if (! as)
+		return -ENOMEM;
+	memset(as, 0, sizeof(*as));
+	as->pcm_index = chip->pcm_devs;
+	as->chip = chip;
 	err = snd_pcm_new(chip->card, "USB Audio", chip->pcm_devs,
-			  as->substream[SNDRV_PCM_STREAM_PLAYBACK].num_formats ? 1 : 0,
-			  as->substream[SNDRV_PCM_STREAM_CAPTURE].num_formats ? 1 : 0,
+			  stream == SNDRV_PCM_STREAM_PLAYBACK ? 1 : 0,
+			  stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1,
 			  &pcm);
 	if (err < 0) {
-		snd_usb_audio_stream_free(as);
+		snd_magic_kfree(as);
 		return err;
 	}
-
 	as->pcm = pcm;
-	as->pcm_index = chip->pcm_devs;
-	if (as->substream[SNDRV_PCM_STREAM_PLAYBACK].num_formats)
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_usb_playback_ops);
-	if (as->substream[SNDRV_PCM_STREAM_CAPTURE].num_formats)
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_usb_capture_ops);
-
 	pcm->private_data = as;
 	pcm->private_free = snd_usb_audio_pcm_free;
 	pcm->info_flags = 0;
+	if (chip->pcm_devs > 0)
+		sprintf(pcm->name, "USB Audio #%d", chip->pcm_devs);
+	else
+		strcpy(pcm->name, "USB Audio");
 
-	strcpy(pcm->name, name);
+	init_substream(as, stream, fp);
 
-	snd_pcm_lib_preallocate_pages_for_all(pcm, 64*1024, 128*1024, GFP_ATOMIC);
 	list_add(&as->list, &chip->pcm_list);
 	chip->pcm_devs++;
 
@@ -1750,6 +1551,247 @@
 
 
 /*
+ * parse the audio format type descriptor
+ * and returns the corresponding pcm format
+ */
+static int parse_audio_format_type(struct usb_device *dev, int iface_no, int altno,
+				   int format, unsigned char *fmt)
+{
+	int format_type = fmt[3];
+	int pcm_format;
+
+	/* FIXME: needed support for TYPE II and III */
+	if (format_type != USB_FORMAT_TYPE_I) {
+		snd_printd(KERN_INFO "%d:%u:%d : format type %d is not supported yet\n",
+			   dev->devnum, iface_no, altno, format_type);
+		return -1;
+	}
+	
+	/* FIXME: correct endianess and sign? */
+	pcm_format = -1;
+	switch (format) {
+	case USB_AUDIO_FORMAT_PCM:
+		/* check the format byte size */
+		switch (fmt[6]) {
+		case 8:
+			pcm_format = SNDRV_PCM_FORMAT_U8;
+			break;
+		case 16:
+			pcm_format = SNDRV_PCM_FORMAT_S16_LE;
+			break;
+		case 18:
+		case 20:
+			if (fmt[5] == 3)
+				pcm_format = SNDRV_PCM_FORMAT_S24_3LE;
+			else
+				snd_printk(KERN_ERR "%d:%u:%d : non-supported sample bit %d in %d bytes\n",
+					   dev->devnum, iface_no, altno, fmt[6], fmt[5]);
+			break;
+		case 24:
+			if (fmt[5] == 4)
+				/* FIXME: correct?  or S32_LE? */
+				pcm_format = SNDRV_PCM_FORMAT_S24_LE;
+			else if (fmt[5] == 3)
+				pcm_format = SNDRV_PCM_FORMAT_S24_3LE;
+			else
+				snd_printk(KERN_ERR "%d:%u:%d : non-supported sample bit %d in %d bytes\n",
+					   dev->devnum, iface_no, altno, format, fmt[5]);
+			break;
+		case 32:
+			pcm_format = SNDRV_PCM_FORMAT_S32_LE;
+			break;
+		default:
+			snd_printk(KERN_INFO "%d:%u:%d : unsupported sample bitwidth %d in %d bytes\n",
+				   dev->devnum, iface_no, altno, fmt[6], fmt[5]);
+			break;
+		}
+		break;
+	case USB_AUDIO_FORMAT_PCM8:
+		/* Dallas DS4201 workaround */
+		if (dev->descriptor.idVendor == 0x04fa && dev->descriptor.idProduct == 0x4201)
+			pcm_format = SNDRV_PCM_FORMAT_S8;
+		else
+			pcm_format = SNDRV_PCM_FORMAT_U8;
+		break;
+	case USB_AUDIO_FORMAT_IEEE_FLOAT:
+		pcm_format = SNDRV_PCM_FORMAT_FLOAT_LE;
+		break;
+	case USB_AUDIO_FORMAT_ALAW:
+		pcm_format = SNDRV_PCM_FORMAT_A_LAW;
+		break;
+	case USB_AUDIO_FORMAT_MU_LAW:
+		pcm_format = SNDRV_PCM_FORMAT_MU_LAW;
+		break;
+	default:
+		snd_printk(KERN_INFO "%d:%u:%d : unsupported format type %d\n",
+			   dev->devnum, iface_no, altno, format);
+		break;
+	}
+	return pcm_format;
+}
+
+
+static int parse_audio_endpoints(snd_usb_audio_t *chip, unsigned char *buffer, int buflen, int iface_no)
+{
+	struct usb_device *dev;
+	struct usb_config_descriptor *config;
+	struct usb_interface *iface;
+	struct usb_interface_descriptor *alts;
+	int i, altno, err, stream;
+	int channels, nr_rates, pcm_format, format;
+	struct audioformat *fp;
+	unsigned char *fmt, *csep;
+
+	dev = chip->dev;
+	config = dev->actconfig;
+
+	/* parse the interface's altsettings */
+	iface = &config->interface[iface_no];
+	for (i = 0; i < iface->num_altsetting; i++) {
+		alts = &iface->altsetting[i];
+		/* skip invalid one */
+		if (alts->bInterfaceClass != USB_CLASS_AUDIO ||
+		    alts->bInterfaceSubClass != USB_SUBCLASS_AUDIO_STREAMING ||
+		    alts->bNumEndpoints < 1)
+			continue;
+		/* must be isochronous */
+		if ((alts->endpoint[0].bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) !=
+		    USB_ENDPOINT_XFER_ISOC)
+			continue;
+		/* check direction */
+		stream = (alts->endpoint[0].bEndpointAddress & USB_DIR_IN) ?
+			SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
+		altno = alts->bAlternateSetting;
+
+		/* get audio formats */
+		fmt = snd_usb_find_csint_desc(buffer, buflen, NULL, AS_GENERAL, iface_no, altno);
+		if (!fmt) {
+			snd_printk(KERN_ERR "%d:%u:%d : AS_GENERAL descriptor not found\n",
+				   dev->devnum, iface_no, altno);
+			continue;
+		}
+
+		if (fmt[0] < 7) {
+			snd_printk(KERN_ERR "%d:%u:%d : invalid AS_GENERAL desc\n", 
+				   dev->devnum, iface_no, altno);
+			continue;
+		}
+
+		format = (fmt[6] << 8) | fmt[5]; /* remember the format value */
+			
+		/* get format type */
+		fmt = snd_usb_find_csint_desc(buffer, buflen, NULL, FORMAT_TYPE, iface_no, altno);
+		if (!fmt) {
+			snd_printk(KERN_ERR "%d:%u:%d : no FORMAT_TYPE desc\n", 
+				   dev->devnum, iface_no, altno);
+			continue;
+		}
+		if (fmt[0] < 8) {
+			snd_printk(KERN_ERR "%d:%u:%d : invalid FORMAT_TYPE desc\n", 
+				   dev->devnum, iface_no, altno);
+			continue;
+		}
+
+		pcm_format = parse_audio_format_type(dev, iface_no, altno, format, fmt);
+		if (pcm_format < 0)
+			continue;
+		
+		channels = fmt[4];
+		if (channels < 1) {
+			snd_printk(KERN_ERR "%d:%u:%d : invalid channels %d\n",
+				   dev->devnum, iface_no, altno, channels);
+			continue;
+		}
+
+		nr_rates = fmt[7];
+		if (fmt[0] < 8 + 3 * (nr_rates ? nr_rates : 2)) {
+			snd_printk(KERN_ERR "%d:%u:%d : invalid FORMAT_TYPE desc\n", 
+				   dev->devnum, iface_no, altno);
+			continue;
+		}
+
+		csep = snd_usb_find_desc(buffer, buflen, NULL, USB_DT_CS_ENDPOINT, iface_no, altno);
+		if (!csep || csep[0] < 7 || csep[2] != EP_GENERAL) {
+			snd_printk(KERN_ERR "%d:%u:%d : no or invalid class specific endpoint descriptor\n", 
+				   dev->devnum, iface_no, altno);
+			continue;
+		}
+
+		fp = kmalloc(sizeof(*fp), GFP_KERNEL);
+		if (! fp) {
+			snd_printk(KERN_ERR "cannot malloc\n");
+			return -ENOMEM;
+		}
+
+		memset(fp, 0, sizeof(*fp));
+		fp->iface = iface_no;
+		fp->altsetting = altno;
+		fp->altset_idx = i;
+		fp->format = pcm_format;
+		fp->endpoint = alts->endpoint[0].bEndpointAddress;
+		fp->ep_attr = alts->endpoint[0].bmAttributes;
+		fp->channels = channels;
+		fp->attributes = csep[3];
+
+		if (nr_rates) {
+			/*
+			 * build the rate table and bitmap flags
+			 */
+			int r, idx, c;
+			/* this table corresponds to the SNDRV_PCM_RATE_XXX bit */
+			static int conv_rates[] = {
+				5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000,
+				64000, 88200, 96000, 176400, 192000
+			};
+			fp->rate_table = kmalloc(sizeof(int) * nr_rates, GFP_KERNEL);
+			if (fp->rate_table == NULL) {
+				snd_printk(KERN_ERR "cannot malloc\n");
+				kfree(fp);
+				break;
+			}
+
+			fp->nr_rates = nr_rates;
+			fp->rate_min = fp->rate_max = combine_triple(&fmt[8]);
+			for (r = 0, idx = 8; r < nr_rates; r++, idx += 3) {
+				int rate = fp->rate_table[r] = combine_triple(&fmt[idx]);
+				if (rate < fp->rate_min)
+					fp->rate_min = rate;
+				else if (rate > fp->rate_max)
+					fp->rate_max = rate;
+				for (c = 0; c < 13; c++) {
+					if (rate == conv_rates[c]) {
+						fp->rates |= (1 << c);
+						break;
+					}
+				}
+#if 0 // FIXME - we need to define constraint
+				if (c >= 13)
+					fp->rates |= SNDRV_PCM_KNOT; /* unconventional rate */
+#endif
+			}
+
+		} else {
+			/* continuous rates */
+			fp->rates = SNDRV_PCM_RATE_CONTINUOUS;
+			fp->rate_min = combine_triple(&fmt[8]);
+			fp->rate_max = combine_triple(&fmt[11]);
+		}
+
+		
+		snd_printdd(KERN_INFO "%d:%u:%d: add audio endpoint 0x%x\n", dev->devnum, iface_no, i, fp->endpoint);
+		err = add_audio_endpoint(chip, stream, fp);
+		if (err < 0) {
+			if (fp->rate_table)
+				kfree(fp->rate_table);
+			kfree(fp);
+			return err;
+		}
+	}
+	return 0;
+}
+
+
+/*
  * parse audio control descriptor and create pcm/midi streams
  */
 
@@ -1763,9 +1805,7 @@
 	struct usb_config_descriptor *config;
 	struct usb_interface *iface;
 	unsigned char *p1;
-	unsigned char ifin[USB_MAXINTERFACES], ifout[USB_MAXINTERFACES];
-	int numifin = 0, numifout = 0;
-	int i, j, k;
+	int i, j;
 
 	/* find audiocontrol interface */
 	if (!(p1 = snd_usb_find_csint_desc(buffer, buflen, NULL, HEADER, ctrlif, -1))) {
@@ -1804,52 +1844,9 @@
 			/* skip non-supported classes */
 			continue;
 		}
-		if (iface->num_altsetting < 2) {
-			snd_printdd(KERN_ERR "%d:%u:%d: skipping - no valid interface.\n",
-				    dev->devnum, ctrlif, j);
-			continue;
-		}
-		if (iface->altsetting[0].bNumEndpoints > 0) {
-			/* Check all endpoints; should they all have a bandwidth of 0 ? */
-			for (k = 0; k < iface->altsetting[0].bNumEndpoints; k++) {
-				if (iface->altsetting[0].endpoint[k].wMaxPacketSize > 0) {
-					snd_printk(KERN_ERR "%d:%u:%d ep%d : have no bandwith at alt[0]\n", dev->devnum, ctrlif, j, k);
-					break;
-				}
-			}
-			if (k < iface->altsetting[0].bNumEndpoints)
-				continue;
-		}
-		if (iface->altsetting[1].bNumEndpoints < 1) {
-			snd_printk(KERN_ERR "%d:%u:%d : has no endpoint\n",
-				   dev->devnum, ctrlif, j);
-			continue;
-		}
-		/* note: this requires the data endpoint to be ep0 and
-		 * the optional sync ep to be ep1, which seems to be the case
-		 */
-		if (iface->altsetting[1].endpoint[0].bEndpointAddress & USB_DIR_IN) {
-			if (numifin < USB_MAXINTERFACES) {
-				snd_printdd(KERN_INFO "adding an input interface %d:%u:%d\n", dev->devnum, ctrlif, j);
-				ifin[numifin++] = j;
-				usb_driver_claim_interface(&usb_audio_driver, iface, (void *)-1);
-			}
-		} else {
-			if (numifout < USB_MAXINTERFACES) {
-				snd_printdd(KERN_INFO "adding an output interface %d:%u:%d\n", dev->devnum, ctrlif, j);
-				ifout[numifout++] = j;
-				usb_driver_claim_interface(&usb_audio_driver, iface, (void *)-1);
-			}
-		}
+		parse_audio_endpoints(chip, buffer, buflen, j);
+		usb_driver_claim_interface(&usb_audio_driver, iface, (void *)-1);
 	}
-
-	/* all endpoints are parsed.  now create pcm streams */
-	for (i = 0; i < numifin && i < numifout; i++)
-		snd_usb_audio_stream_new(chip, buffer, buflen, ifin[i], ifout[i]);
-	for (j = i; j < numifin; j++)
-		snd_usb_audio_stream_new(chip, buffer, buflen, ifin[i], -1);
-	for (j = i; j < numifout; j++)
-		snd_usb_audio_stream_new(chip, buffer, buflen, -1, ifout[i]);
 
 	return 0;
 }

===================================================================


This BitKeeper patch contains the following changesets:
1.653
## Wrapped with gzip_uu ##


begin 664 bkpatch23134
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
!````
`
end

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

