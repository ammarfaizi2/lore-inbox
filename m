Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261718AbSI2S13>; Sun, 29 Sep 2002 14:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261719AbSI2S13>; Sun, 29 Sep 2002 14:27:29 -0400
Received: from gate.perex.cz ([194.212.165.105]:6928 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261718AbSI2S0z>;
	Sun, 29 Sep 2002 14:26:55 -0400
Date: Sun, 29 Sep 2002 20:31:40 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update [2/10] - 2002/06/26 
Message-ID: <Pine.LNX.4.33.0209292030180.591-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.605.2.13, 2002-09-25 15:23:53+02:00, perex@pnote.perex-int.cz
  ALSA update 2002/06/26
    - Enhanced bitmasks in PCM - added support for more formats by Takashi and me
    - RME32 driver - added support for ADAT (Digi 32/8)


 include/sound/asound.h        |   41 +++++---
 include/sound/pcm.h           |   90 ++++++++++-------
 include/sound/pcm_params.h    |   88 +++++++++++------
 include/sound/version.h       |    2 
 sound/core/ioctl32/pcm32.c    |   89 +++++++++++++++++
 sound/core/oss/io.c           |    1 
 sound/core/oss/pcm_oss.c      |   21 ++--
 sound/core/oss/pcm_plugin.c   |   26 ++---
 sound/core/oss/pcm_plugin.h   |    4 
 sound/core/pcm.c              |   12 ++
 sound/core/pcm_lib.c          |   26 ++++-
 sound/core/pcm_misc.c         |  116 +++++++++++++++++++++-
 sound/core/pcm_native.c       |  138 ++++++++++++++++++++++++---
 sound/core/seq/oss/Makefile   |    6 -
 sound/isa/Makefile            |    2 
 sound/isa/ad1848/ad1848_lib.c |    2 
 sound/isa/cs423x/cs4231_lib.c |    1 
 sound/isa/es18xx.c            |    1 
 sound/isa/gus/gus_pcm.c       |    1 
 sound/pci/korg1212/korg1212.c |    1 
 sound/pci/rme32.c             |  212 +++++++++++++++++++++++++++++++++++++++---
 sound/pci/rme96.c             |    1 
 sound/pci/via8233.c           |    4 
 23 files changed, 736 insertions(+), 149 deletions(-)


diff -Nru a/include/sound/asound.h b/include/sound/asound.h
--- a/include/sound/asound.h	Sun Sep 29 20:20:12 2002
+++ b/include/sound/asound.h	Sun Sep 29 20:20:12 2002
@@ -128,7 +128,7 @@
  *                                                                           *
  *****************************************************************************/
 
-#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 1)
+#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 2)
 
 typedef unsigned long sndrv_pcm_uframes_t;
 typedef long sndrv_pcm_sframes_t;
@@ -191,7 +191,19 @@
 	SNDRV_PCM_FORMAT_MPEG,
 	SNDRV_PCM_FORMAT_GSM,
 	SNDRV_PCM_FORMAT_SPECIAL = 31,
-	SNDRV_PCM_FORMAT_LAST = 31,
+	SNDRV_PCM_FORMAT_S24_3LE = 32,	/* in three bytes */
+	SNDRV_PCM_FORMAT_S24_3BE,	/* in three bytes */
+	SNDRV_PCM_FORMAT_U24_3LE,	/* in three bytes */
+	SNDRV_PCM_FORMAT_U24_3BE,	/* in three bytes */
+	SNDRV_PCM_FORMAT_S20_3LE,	/* in three bytes */
+	SNDRV_PCM_FORMAT_S20_3BE,	/* in three bytes */
+	SNDRV_PCM_FORMAT_U20_3LE,	/* in three bytes */
+	SNDRV_PCM_FORMAT_U20_3BE,	/* in three bytes */
+	SNDRV_PCM_FORMAT_S18_3LE,	/* in three bytes */
+	SNDRV_PCM_FORMAT_S18_3BE,	/* in three bytes */
+	SNDRV_PCM_FORMAT_U18_3LE,	/* in three bytes */
+	SNDRV_PCM_FORMAT_U18_3BE,	/* in three bytes */
+	SNDRV_PCM_FORMAT_LAST = SNDRV_PCM_FORMAT_U18_3BE,
 
 #ifdef SNDRV_LITTLE_ENDIAN
 	SNDRV_PCM_FORMAT_S16 = SNDRV_PCM_FORMAT_S16_LE,
@@ -284,7 +296,7 @@
 	SNDRV_PCM_HW_PARAM_SUBFORMAT,	/* Subformat */
 	SNDRV_PCM_HW_PARAM_LAST_MASK = SNDRV_PCM_HW_PARAM_SUBFORMAT,
 
-	SNDRV_PCM_HW_PARAM_SAMPLE_BITS, /* Bits per sample */
+	SNDRV_PCM_HW_PARAM_SAMPLE_BITS = 8, /* Bits per sample */
 	SNDRV_PCM_HW_PARAM_FIRST_INTERVAL = SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
 	SNDRV_PCM_HW_PARAM_FRAME_BITS,	/* Bits per frame */
 	SNDRV_PCM_HW_PARAM_CHANNELS,	/* Channels */
@@ -298,8 +310,7 @@
 	SNDRV_PCM_HW_PARAM_BUFFER_SIZE,	/* Size of buffer in frames */
 	SNDRV_PCM_HW_PARAM_BUFFER_BYTES, /* Size of buffer in bytes */
 	SNDRV_PCM_HW_PARAM_TICK_TIME,	/* Approx tick duration in us */
-	SNDRV_PCM_HW_PARAM_LAST_INTERVAL = SNDRV_PCM_HW_PARAM_TICK_TIME,
-	SNDRV_PCM_HW_PARAM_LAST = SNDRV_PCM_HW_PARAM_LAST_INTERVAL,
+	SNDRV_PCM_HW_PARAM_LAST_INTERVAL = SNDRV_PCM_HW_PARAM_TICK_TIME
 };
 
 #define SNDRV_PCM_HW_PARAMS_RUNTIME		(1<<0)
@@ -312,20 +323,28 @@
 		     empty:1;
 };
 
+#define SNDRV_MASK_MAX	256
+
+struct sndrv_mask {
+	u_int32_t bits[(SNDRV_MASK_MAX+31)/32];
+};
+
 struct sndrv_pcm_hw_params {
 	unsigned int flags;
-	unsigned int masks[SNDRV_PCM_HW_PARAM_LAST_MASK - 
-			   SNDRV_PCM_HW_PARAM_FIRST_MASK + 1];
+	struct sndrv_mask masks[SNDRV_PCM_HW_PARAM_LAST_MASK - 
+			       SNDRV_PCM_HW_PARAM_FIRST_MASK + 1];
+	struct sndrv_mask mres[5];	/* reserved masks */
 	struct sndrv_interval intervals[SNDRV_PCM_HW_PARAM_LAST_INTERVAL -
 				        SNDRV_PCM_HW_PARAM_FIRST_INTERVAL + 1];
-	unsigned int rmask;
-	unsigned int cmask;
+	struct sndrv_interval ires[9];	/* reserved intervals */
+	unsigned int rmask;		/* W: requested masks */
+	unsigned int cmask;		/* R: changed masks */
 	unsigned int info;		/* R: Info flags for returned setup */
 	unsigned int msbits;		/* R: used most significant bits */
 	unsigned int rate_num;		/* R: rate numerator */
 	unsigned int rate_den;		/* R: rate denominator */
 	sndrv_pcm_uframes_t fifo_size;	/* R: chip FIFO size in frames */
-	unsigned char reserved[64];
+	unsigned char reserved[64];	/* reserved for future */
 };
 
 enum sndrv_pcm_tstamp {
@@ -345,7 +364,7 @@
 	sndrv_pcm_uframes_t silence_threshold;	/* min distance from noise for silence filling */
 	sndrv_pcm_uframes_t silence_size;	/* silence block size */
 	sndrv_pcm_uframes_t boundary;		/* pointers wrap point */
-	unsigned char reserved[64];
+	unsigned char reserved[64];		/* reserved for future */
 };
 
 struct sndrv_pcm_channel_info {
diff -Nru a/include/sound/pcm.h b/include/sound/pcm.h
--- a/include/sound/pcm.h	Sun Sep 29 20:20:12 2002
+++ b/include/sound/pcm.h	Sun Sep 29 20:20:12 2002
@@ -48,6 +48,7 @@
 typedef struct sndrv_pcm_status snd_pcm_status_t;
 typedef struct sndrv_pcm_mmap_status snd_pcm_mmap_status_t;
 typedef struct sndrv_pcm_mmap_control snd_pcm_mmap_control_t;
+typedef struct sndrv_mask snd_mask_t;
 
 #define _snd_pcm_substream_chip(substream) ((substream)->pcm->private_data)
 #define snd_pcm_substream_chip(substream) snd_magic_cast1(chip_t, _snd_pcm_substream_chip(substream), return -ENXIO)
@@ -67,7 +68,7 @@
 
 typedef struct _snd_pcm_hardware {
 	unsigned int info;		/* SNDRV_PCM_INFO_* */
-	unsigned int formats;		/* SNDRV_PCM_FMTBIT_* */
+	u64 formats;			/* SNDRV_PCM_FMTBIT_* */
 	unsigned int rates;		/* SNDRV_PCM_RATE_* */
 	unsigned int rate_min;		/* min rate */
 	unsigned int rate_max;		/* max rate */
@@ -148,32 +149,44 @@
 					 SNDRV_PCM_RATE_88200|SNDRV_PCM_RATE_96000)
 #define SNDRV_PCM_RATE_8000_192000	(SNDRV_PCM_RATE_8000_96000|SNDRV_PCM_RATE_176400|\
 					 SNDRV_PCM_RATE_192000)
-#define SNDRV_PCM_FMTBIT_S8		(1 << SNDRV_PCM_FORMAT_S8)
-#define SNDRV_PCM_FMTBIT_U8		(1 << SNDRV_PCM_FORMAT_U8)
-#define SNDRV_PCM_FMTBIT_S16_LE		(1 << SNDRV_PCM_FORMAT_S16_LE)
-#define SNDRV_PCM_FMTBIT_S16_BE		(1 << SNDRV_PCM_FORMAT_S16_BE)
-#define SNDRV_PCM_FMTBIT_U16_LE		(1 << SNDRV_PCM_FORMAT_U16_LE)
-#define SNDRV_PCM_FMTBIT_U16_BE		(1 << SNDRV_PCM_FORMAT_U16_BE)
-#define SNDRV_PCM_FMTBIT_S24_LE		(1 << SNDRV_PCM_FORMAT_S24_LE)
-#define SNDRV_PCM_FMTBIT_S24_BE		(1 << SNDRV_PCM_FORMAT_S24_BE)
-#define SNDRV_PCM_FMTBIT_U24_LE		(1 << SNDRV_PCM_FORMAT_U24_LE)
-#define SNDRV_PCM_FMTBIT_U24_BE		(1 << SNDRV_PCM_FORMAT_U24_BE)
-#define SNDRV_PCM_FMTBIT_S32_LE		(1 << SNDRV_PCM_FORMAT_S32_LE)
-#define SNDRV_PCM_FMTBIT_S32_BE		(1 << SNDRV_PCM_FORMAT_S32_BE)
-#define SNDRV_PCM_FMTBIT_U32_LE		(1 << SNDRV_PCM_FORMAT_U32_LE)
-#define SNDRV_PCM_FMTBIT_U32_BE		(1 << SNDRV_PCM_FORMAT_U32_BE)
-#define SNDRV_PCM_FMTBIT_FLOAT_LE	(1 << SNDRV_PCM_FORMAT_FLOAT_LE)
-#define SNDRV_PCM_FMTBIT_FLOAT_BE	(1 << SNDRV_PCM_FORMAT_FLOAT_BE)
-#define SNDRV_PCM_FMTBIT_FLOAT64_LE	(1 << SNDRV_PCM_FORMAT_FLOAT64_LE)
-#define SNDRV_PCM_FMTBIT_FLOAT64_BE	(1 << SNDRV_PCM_FORMAT_FLOAT64_BE)
-#define SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE (1 << SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE)
-#define SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_BE (1 << SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE)
-#define SNDRV_PCM_FMTBIT_MU_LAW		(1 << SNDRV_PCM_FORMAT_MU_LAW)
-#define SNDRV_PCM_FMTBIT_A_LAW		(1 << SNDRV_PCM_FORMAT_A_LAW)
-#define SNDRV_PCM_FMTBIT_IMA_ADPCM	(1 << SNDRV_PCM_FORMAT_IMA_ADPCM)
-#define SNDRV_PCM_FMTBIT_MPEG		(1 << SNDRV_PCM_FORMAT_MPEG)
-#define SNDRV_PCM_FMTBIT_GSM		(1 << SNDRV_PCM_FORMAT_GSM)
-#define SNDRV_PCM_FMTBIT_SPECIAL	(1 << SNDRV_PCM_FORMAT_SPECIAL)
+#define SNDRV_PCM_FMTBIT_S8		(1ULL << SNDRV_PCM_FORMAT_S8)
+#define SNDRV_PCM_FMTBIT_U8		(1ULL << SNDRV_PCM_FORMAT_U8)
+#define SNDRV_PCM_FMTBIT_S16_LE		(1ULL << SNDRV_PCM_FORMAT_S16_LE)
+#define SNDRV_PCM_FMTBIT_S16_BE		(1ULL << SNDRV_PCM_FORMAT_S16_BE)
+#define SNDRV_PCM_FMTBIT_U16_LE		(1ULL << SNDRV_PCM_FORMAT_U16_LE)
+#define SNDRV_PCM_FMTBIT_U16_BE		(1ULL << SNDRV_PCM_FORMAT_U16_BE)
+#define SNDRV_PCM_FMTBIT_S24_LE		(1ULL << SNDRV_PCM_FORMAT_S24_LE)
+#define SNDRV_PCM_FMTBIT_S24_BE		(1ULL << SNDRV_PCM_FORMAT_S24_BE)
+#define SNDRV_PCM_FMTBIT_U24_LE		(1ULL << SNDRV_PCM_FORMAT_U24_LE)
+#define SNDRV_PCM_FMTBIT_U24_BE		(1ULL << SNDRV_PCM_FORMAT_U24_BE)
+#define SNDRV_PCM_FMTBIT_S32_LE		(1ULL << SNDRV_PCM_FORMAT_S32_LE)
+#define SNDRV_PCM_FMTBIT_S32_BE		(1ULL << SNDRV_PCM_FORMAT_S32_BE)
+#define SNDRV_PCM_FMTBIT_U32_LE		(1ULL << SNDRV_PCM_FORMAT_U32_LE)
+#define SNDRV_PCM_FMTBIT_U32_BE		(1ULL << SNDRV_PCM_FORMAT_U32_BE)
+#define SNDRV_PCM_FMTBIT_FLOAT_LE	(1ULL << SNDRV_PCM_FORMAT_FLOAT_LE)
+#define SNDRV_PCM_FMTBIT_FLOAT_BE	(1ULL << SNDRV_PCM_FORMAT_FLOAT_BE)
+#define SNDRV_PCM_FMTBIT_FLOAT64_LE	(1ULL << SNDRV_PCM_FORMAT_FLOAT64_LE)
+#define SNDRV_PCM_FMTBIT_FLOAT64_BE	(1ULL << SNDRV_PCM_FORMAT_FLOAT64_BE)
+#define SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE (1ULL << SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE)
+#define SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_BE (1ULL << SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE)
+#define SNDRV_PCM_FMTBIT_MU_LAW		(1ULL << SNDRV_PCM_FORMAT_MU_LAW)
+#define SNDRV_PCM_FMTBIT_A_LAW		(1ULL << SNDRV_PCM_FORMAT_A_LAW)
+#define SNDRV_PCM_FMTBIT_IMA_ADPCM	(1ULL << SNDRV_PCM_FORMAT_IMA_ADPCM)
+#define SNDRV_PCM_FMTBIT_MPEG		(1ULL << SNDRV_PCM_FORMAT_MPEG)
+#define SNDRV_PCM_FMTBIT_GSM		(1ULL << SNDRV_PCM_FORMAT_GSM)
+#define SNDRV_PCM_FMTBIT_SPECIAL	(1ULL << SNDRV_PCM_FORMAT_SPECIAL)
+#define SNDRV_PCM_FMTBIT_S24_3LE	(1ULL << SNDRV_PCM_FORMAT_S24_3LE)
+#define SNDRV_PCM_FMTBIT_U24_3LE	(1ULL << SNDRV_PCM_FORMAT_U24_3LE)
+#define SNDRV_PCM_FMTBIT_S24_3BE	(1ULL << SNDRV_PCM_FORMAT_S24_3BE)
+#define SNDRV_PCM_FMTBIT_U24_3BE	(1ULL << SNDRV_PCM_FORMAT_U24_3BE)
+#define SNDRV_PCM_FMTBIT_S20_3LE	(1ULL << SNDRV_PCM_FORMAT_S20_3LE)
+#define SNDRV_PCM_FMTBIT_U20_3LE	(1ULL << SNDRV_PCM_FORMAT_U20_3LE)
+#define SNDRV_PCM_FMTBIT_S20_3BE	(1ULL << SNDRV_PCM_FORMAT_S20_3BE)
+#define SNDRV_PCM_FMTBIT_U20_3BE	(1ULL << SNDRV_PCM_FORMAT_U20_3BE)
+#define SNDRV_PCM_FMTBIT_S18_3LE	(1ULL << SNDRV_PCM_FORMAT_S18_3LE)
+#define SNDRV_PCM_FMTBIT_U18_3LE	(1ULL << SNDRV_PCM_FORMAT_U18_3LE)
+#define SNDRV_PCM_FMTBIT_S18_3BE	(1ULL << SNDRV_PCM_FORMAT_S18_3BE)
+#define SNDRV_PCM_FMTBIT_U18_3BE	(1ULL << SNDRV_PCM_FORMAT_U18_3BE)
 
 #ifdef SNDRV_LITTLE_ENDIAN
 #define SNDRV_PCM_FMTBIT_S16		SNDRV_PCM_FMTBIT_S16_LE
@@ -217,8 +230,8 @@
 };
 
 typedef struct _snd_pcm_hw_constraints {
-	unsigned int masks[SNDRV_PCM_HW_PARAM_LAST_MASK - 
-			   SNDRV_PCM_HW_PARAM_FIRST_MASK + 1];
+	snd_mask_t masks[SNDRV_PCM_HW_PARAM_LAST_MASK - 
+			 SNDRV_PCM_HW_PARAM_FIRST_MASK + 1];
 	snd_interval_t intervals[SNDRV_PCM_HW_PARAM_LAST_INTERVAL -
 			     SNDRV_PCM_HW_PARAM_FIRST_INTERVAL + 1];
 	unsigned int rules_num;
@@ -226,8 +239,8 @@
 	snd_pcm_hw_rule_t *rules;
 } snd_pcm_hw_constraints_t;
 
-static inline unsigned int *constrs_mask(snd_pcm_hw_constraints_t *constrs,
-					snd_pcm_hw_param_t var)
+static inline snd_mask_t *constrs_mask(snd_pcm_hw_constraints_t *constrs,
+				       snd_pcm_hw_param_t var)
 {
 	return &constrs->masks[var - SNDRV_PCM_HW_PARAM_FIRST_MASK];
 }
@@ -648,13 +661,10 @@
 		var <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL;
 }
 
-typedef unsigned int snd_mask_t;
-#define SND_MASK_MAX 32
-
 static inline snd_mask_t *hw_param_mask(snd_pcm_hw_params_t *params,
 				     snd_pcm_hw_param_t var)
 {
-	return (snd_mask_t*)&params->masks[var - SNDRV_PCM_HW_PARAM_FIRST_MASK];
+	return &params->masks[var - SNDRV_PCM_HW_PARAM_FIRST_MASK];
 }
 
 static inline snd_interval_t *hw_param_interval(snd_pcm_hw_params_t *params,
@@ -675,9 +685,9 @@
 	return (const snd_interval_t *)hw_param_interval((snd_pcm_hw_params_t*) params, var);
 }
 
-#define params_access(p) (ffs(*hw_param_mask((p), SNDRV_PCM_HW_PARAM_ACCESS)) - 1)
-#define params_format(p) (ffs(*hw_param_mask((p), SNDRV_PCM_HW_PARAM_FORMAT)) - 1)
-#define params_subformat(p) (ffs(*hw_param_mask((p), SNDRV_PCM_HW_PARAM_SUBFORMAT)) - 1)
+#define params_access(p) snd_mask_min(hw_param_mask((p), SNDRV_PCM_HW_PARAM_ACCESS))
+#define params_format(p) snd_mask_min(hw_param_mask((p), SNDRV_PCM_HW_PARAM_FORMAT))
+#define params_subformat(p) snd_mask_min(hw_param_mask((p), SNDRV_PCM_HW_PARAM_SUBFORMAT))
 #define params_channels(p) hw_param_interval((p), SNDRV_PCM_HW_PARAM_CHANNELS)->min
 #define params_rate(p) hw_param_interval((p), SNDRV_PCM_HW_PARAM_RATE)->min
 #define params_period_size(p) hw_param_interval((p), SNDRV_PCM_HW_PARAM_PERIOD_SIZE)->min
@@ -735,7 +745,9 @@
 int snd_pcm_hw_constraints_complete(snd_pcm_substream_t *substream);
 
 int snd_pcm_hw_constraint_mask(snd_pcm_runtime_t *runtime, snd_pcm_hw_param_t var,
-			       unsigned int mask);
+			       u_int32_t mask);
+int snd_pcm_hw_constraint_mask64(snd_pcm_runtime_t *runtime, snd_pcm_hw_param_t var,
+				 u_int64_t mask);
 int snd_pcm_hw_constraint_minmax(snd_pcm_runtime_t *runtime, snd_pcm_hw_param_t var,
 				 unsigned int min, unsigned int max);
 int snd_pcm_hw_constraint_integer(snd_pcm_runtime_t *runtime, snd_pcm_hw_param_t var);
diff -Nru a/include/sound/pcm_params.h b/include/sound/pcm_params.h
--- a/include/sound/pcm_params.h	Sun Sep 29 20:20:12 2002
+++ b/include/sound/pcm_params.h	Sun Sep 29 20:20:12 2002
@@ -36,10 +36,14 @@
 				 snd_pcm_hw_param_t var, unsigned int val, int dir);
 
 /* To share the same code we have  alsa-lib */
-#define snd_mask_bits(mask) (*(mask))
 #define INLINE static inline
 #define assert(a) (void)(a)
 
+#define SNDRV_MASK_BITS	64	/* we use so far 64bits only */
+#define SNDRV_MASK_SIZE	(SNDRV_MASK_BITS / 32)
+#define MASK_OFS(i)	((i) >> 5)
+#define MASK_BIT(i)	(1U << ((i) & 31))
+
 INLINE unsigned int ld2(u_int32_t v)
 {
         unsigned r = 0;
@@ -72,91 +76,119 @@
 
 INLINE void snd_mask_none(snd_mask_t *mask)
 {
-	snd_mask_bits(mask) = 0;
+	memset(mask, 0, sizeof(*mask));
 }
 
 INLINE void snd_mask_any(snd_mask_t *mask)
 {
-	snd_mask_bits(mask) = ~0U;
-}
-
-INLINE void snd_mask_load(snd_mask_t *mask, unsigned int msk)
-{
-	snd_mask_bits(mask) = msk;
+	memset(mask, 0xff, SNDRV_MASK_SIZE * sizeof(u_int32_t));
 }
 
 INLINE int snd_mask_empty(const snd_mask_t *mask)
 {
-	return snd_mask_bits(mask) == 0;
+	int i;
+	for (i = 0; i < SNDRV_MASK_SIZE; i++)
+		if (mask->bits[i])
+			return 0;
+	return 1;
 }
 
 INLINE unsigned int snd_mask_min(const snd_mask_t *mask)
 {
+	int i;
 	assert(!snd_mask_empty(mask));
-	return ffs(snd_mask_bits(mask)) - 1;
+	for (i = 0; i < SNDRV_MASK_SIZE; i++) {
+		if (mask->bits[i])
+			return ffs(mask->bits[i]) - 1 + (i << 5);
+	}
+	return 0;
 }
 
 INLINE unsigned int snd_mask_max(const snd_mask_t *mask)
 {
+	int i;
 	assert(!snd_mask_empty(mask));
-	return ld2(snd_mask_bits(mask));
+	for (i = SNDRV_MASK_SIZE - 1; i >= 0; i--) {
+		if (mask->bits[i])
+			return ld2(mask->bits[i]) + (i << 5);
+	}
+	return 0;
 }
 
 INLINE void snd_mask_set(snd_mask_t *mask, unsigned int val)
 {
-	assert(val <= SND_MASK_MAX);
-	snd_mask_bits(mask) |= (1U << val);
+	assert(val <= SNDRV_MASK_BITS);
+	mask->bits[MASK_OFS(val)] |= MASK_BIT(val);
 }
 
 INLINE void snd_mask_reset(snd_mask_t *mask, unsigned int val)
 {
-	assert(val <= SND_MASK_MAX);
-	snd_mask_bits(mask) &= ~(1U << val);
+	assert(val <= SNDRV_MASK_BITS);
+	mask->bits[MASK_OFS(val)] &= ~MASK_BIT(val);
 }
 
 INLINE void snd_mask_set_range(snd_mask_t *mask, unsigned int from, unsigned int to)
 {
-	assert(to <= SND_MASK_MAX && from <= to);
-	snd_mask_bits(mask) |= ((1U << (from - to + 1)) - 1) << from;
+	int i;
+	assert(to <= SNDRV_MASK_BITS && from <= to);
+	for (i = from; i <= to; i++)
+		mask->bits[MASK_OFS(i)] |= MASK_BIT(i);
 }
 
 INLINE void snd_mask_reset_range(snd_mask_t *mask, unsigned int from, unsigned int to)
 {
-	assert(to <= SND_MASK_MAX && from <= to);
-	snd_mask_bits(mask) &= ~(((1U << (from - to + 1)) - 1) << from);
+	int i;
+	assert(to <= SNDRV_MASK_BITS && from <= to);
+	for (i = from; i <= to; i++)
+		mask->bits[MASK_OFS(i)] &= ~MASK_BIT(i);
 }
 
 INLINE void snd_mask_leave(snd_mask_t *mask, unsigned int val)
 {
-	assert(val <= SND_MASK_MAX);
-	snd_mask_bits(mask) &= 1U << val;
+	unsigned int v;
+	assert(val <= SNDRV_MASK_BITS);
+	v = mask->bits[MASK_OFS(val)] & MASK_BIT(val);
+	snd_mask_none(mask);
+	mask->bits[MASK_OFS(val)] = v;
 }
 
 INLINE void snd_mask_intersect(snd_mask_t *mask, const snd_mask_t *v)
 {
-	snd_mask_bits(mask) &= snd_mask_bits(v);
+	int i;
+	for (i = 0; i < SNDRV_MASK_SIZE; i++)
+		mask->bits[i] &= v->bits[i];
 }
 
 INLINE int snd_mask_eq(const snd_mask_t *mask, const snd_mask_t *v)
 {
-	return snd_mask_bits(mask) == snd_mask_bits(v);
+	return ! memcmp(mask, v, SNDRV_MASK_SIZE * sizeof(u_int32_t));
 }
 
 INLINE void snd_mask_copy(snd_mask_t *mask, const snd_mask_t *v)
 {
-	snd_mask_bits(mask) = snd_mask_bits(v);
+	*mask = *v;
 }
 
 INLINE int snd_mask_test(const snd_mask_t *mask, unsigned int val)
 {
-	assert(val <= SND_MASK_MAX);
-	return snd_mask_bits(mask) & (1U << val);
+	assert(val <= SNDRV_MASK_BITS);
+	return mask->bits[MASK_OFS(val)] & MASK_BIT(val);
 }
 
 INLINE int snd_mask_single(const snd_mask_t *mask)
 {
+	int i, c = 0;
 	assert(!snd_mask_empty(mask));
-	return !(snd_mask_bits(mask) & (snd_mask_bits(mask) - 1));
+	for (i = 0; i < SNDRV_MASK_SIZE; i++) {
+		if (! mask->bits[i])
+			continue;
+		if (mask->bits[i] & (mask->bits[i] - 1))
+			return 0;
+		if (c)
+			return 0;
+		c++;
+	}
+	return 1;
 }
 
 INLINE int snd_mask_refine(snd_mask_t *mask, const snd_mask_t *v)
@@ -204,7 +236,7 @@
 	assert(!snd_mask_empty(mask));
 	if (snd_mask_max(mask) <= val)
 		return 0;
-	snd_mask_reset_range(mask, val + 1, SND_MASK_MAX);
+	snd_mask_reset_range(mask, val + 1, SNDRV_MASK_BITS);
 	if (snd_mask_empty(mask))
 		return -EINVAL;
 	return 1;
diff -Nru a/include/sound/version.h b/include/sound/version.h
--- a/include/sound/version.h	Sun Sep 29 20:20:12 2002
+++ b/include/sound/version.h	Sun Sep 29 20:20:12 2002
@@ -1,3 +1,3 @@
 /* include/version.h.  Generated automatically by configure.  */
 #define CONFIG_SND_VERSION "0.9.0rc2"
-#define CONFIG_SND_DATE " (Fri Jun 21 12:21:17 2002 UTC)"
+#define CONFIG_SND_DATE " (Wed Jun 26 18:12:42 2002 UTC)"
diff -Nru a/sound/core/ioctl32/pcm32.c b/sound/core/ioctl32/pcm32.c
--- a/sound/core/ioctl32/pcm32.c	Sun Sep 29 20:20:12 2002
+++ b/sound/core/ioctl32/pcm32.c	Sun Sep 29 20:20:12 2002
@@ -303,12 +303,94 @@
 }
 
 
+struct sndrv_pcm_hw_params_old32 {
+	u32 flags;
+	u32 masks[SNDRV_PCM_HW_PARAM_SUBFORMAT -
+			   SNDRV_PCM_HW_PARAM_ACCESS + 1];
+	struct sndrv_interval32 intervals[SNDRV_PCM_HW_PARAM_TICK_TIME -
+					SNDRV_PCM_HW_PARAM_SAMPLE_BITS + 1];
+	u32 rmask;
+	u32 cmask;
+	u32 info;
+	u32 msbits;
+	u32 rate_num;
+	u32 rate_den;
+	u32 fifo_size;
+	unsigned char reserved[64];
+} __attribute__((packed));
+
+#define __OLD_TO_NEW_MASK(x) ((x&7)|((x&0x07fffff8)<<5))
+#define __NEW_TO_OLD_MASK(x) ((x&7)|((x&0xffffff00)>>5))
+
+static void snd_pcm_hw_convert_from_old_params(snd_pcm_hw_params_t *params, struct sndrv_pcm_hw_params_old32 *oparams)
+{
+	unsigned int i;
+
+	memset(params, 0, sizeof(*params));
+	params->flags = oparams->flags;
+	for (i = 0; i < sizeof(oparams->masks) / sizeof(unsigned int); i++)
+		params->masks[i].bits[0] = oparams->masks[i];
+	memcpy(params->intervals, oparams->intervals, sizeof(oparams->intervals));
+	params->rmask = __OLD_TO_NEW_MASK(oparams->rmask);
+	params->cmask = __OLD_TO_NEW_MASK(oparams->cmask);
+	params->info = oparams->info;
+	params->msbits = oparams->msbits;
+	params->rate_num = oparams->rate_num;
+	params->rate_den = oparams->rate_den;
+	params->fifo_size = oparams->fifo_size;
+}
+
+static void snd_pcm_hw_convert_to_old_params(struct sndrv_pcm_hw_params_old32 *oparams, snd_pcm_hw_params_t *params)
+{
+	unsigned int i;
+
+	memset(oparams, 0, sizeof(*oparams));
+	oparams->flags = params->flags;
+	for (i = 0; i < sizeof(oparams->masks) / sizeof(unsigned int); i++)
+		oparams->masks[i] = params->masks[i].bits[0];
+	memcpy(oparams->intervals, params->intervals, sizeof(oparams->intervals));
+	oparams->rmask = __NEW_TO_OLD_MASK(params->rmask);
+	oparams->cmask = __NEW_TO_OLD_MASK(params->cmask);
+	oparams->info = params->info;
+	oparams->msbits = params->msbits;
+	oparams->rate_num = params->rate_num;
+	oparams->rate_den = params->rate_den;
+	oparams->fifo_size = params->fifo_size;
+}
+
+static int _snd_ioctl32_pcm_hw_params_old(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file, unsigned int native_ctl)
+{
+	struct sndrv_pcm_hw_params_old32 data32;
+	struct sndrv_pcm_hw_params data;
+	mm_segment_t oldseg = get_fs();
+	int err;
+	set_fs(KERNEL_DS);
+	if (copy_from_user(&data32, (void*)arg, sizeof(data32))) {
+		err = -EFAULT;
+		goto __err;
+	}
+	snd_pcm_hw_convert_from_old_params(&data, &data32);
+	err = file->f_op->ioctl(file->f_dentry->d_inode, file, native_ctl, (unsigned long)&data);
+	if (err < 0)
+		goto __err;
+	snd_pcm_hw_convert_to_old_params(&data32, &data);
+	if (copy_to_user((void*)arg, &data32, sizeof(data32))) {
+	  err = -EFAULT;
+	  goto __err;
+	}
+ __err: set_fs(oldseg);
+	return err;
+}
+
+
 /*
  */
 
 DEFINE_ALSA_IOCTL_ENTRY(pcm_hw_refine, pcm_hw_params, SNDRV_PCM_IOCTL_HW_REFINE);
-DEFINE_ALSA_IOCTL_ENTRY(pcm_sw_params, pcm_sw_params, SNDRV_PCM_IOCTL_SW_PARAMS);
 DEFINE_ALSA_IOCTL_ENTRY(pcm_hw_params, pcm_hw_params, SNDRV_PCM_IOCTL_HW_PARAMS);
+DEFINE_ALSA_IOCTL_ENTRY(pcm_sw_params, pcm_sw_params, SNDRV_PCM_IOCTL_SW_PARAMS);
+DEFINE_ALSA_IOCTL_ENTRY(pcm_hw_refine_old, pcm_hw_params_old, SNDRV_PCM_IOCTL_HW_REFINE);
+DEFINE_ALSA_IOCTL_ENTRY(pcm_hw_params_old, pcm_hw_params_old, SNDRV_PCM_IOCTL_HW_PARAMS);
 DEFINE_ALSA_IOCTL_ENTRY(pcm_status, pcm_status, SNDRV_PCM_IOCTL_STATUS);
 DEFINE_ALSA_IOCTL_ENTRY(pcm_delay, pcm_sframes_str, SNDRV_PCM_IOCTL_DELAY);
 DEFINE_ALSA_IOCTL_ENTRY(pcm_channel_info, pcm_channel_info, SNDRV_PCM_IOCTL_CHANNEL_INFO);
@@ -335,6 +417,9 @@
 	SNDRV_PCM_IOCTL_READI_FRAMES32 = _IOR('A', 0x51, struct sndrv_xferi32),
 	SNDRV_PCM_IOCTL_WRITEN_FRAMES32 = _IOW('A', 0x52, struct sndrv_xfern32),
 	SNDRV_PCM_IOCTL_READN_FRAMES32 = _IOR('A', 0x53, struct sndrv_xfern32),
+	SNDRV_PCM_IOCTL_HW_REFINE_OLD32 = _IOWR('A', 0x10, struct sndrv_pcm_hw_params_old32),
+	SNDRV_PCM_IOCTL_HW_PARAMS_OLD32 = _IOWR('A', 0x11, struct sndrv_pcm_hw_params_old32),
+
 };
 
 struct ioctl32_mapper pcm_mappers[] = {
@@ -342,6 +427,8 @@
 	{ SNDRV_PCM_IOCTL_INFO, NULL },
 	{ SNDRV_PCM_IOCTL_HW_REFINE32, AP(pcm_hw_refine) },
 	{ SNDRV_PCM_IOCTL_HW_PARAMS32, AP(pcm_hw_params) },
+	{ SNDRV_PCM_IOCTL_HW_REFINE_OLD32, AP(pcm_hw_refine_old) },
+	{ SNDRV_PCM_IOCTL_HW_PARAMS_OLD32, AP(pcm_hw_params_old) },
 	{ SNDRV_PCM_IOCTL_HW_FREE, NULL },
 	{ SNDRV_PCM_IOCTL_SW_PARAMS32, AP(pcm_sw_params) },
 	{ SNDRV_PCM_IOCTL_STATUS32, AP(pcm_status) },
diff -Nru a/sound/core/oss/io.c b/sound/core/oss/io.c
--- a/sound/core/oss/io.c	Sun Sep 29 20:20:12 2002
+++ b/sound/core/oss/io.c	Sun Sep 29 20:20:12 2002
@@ -24,6 +24,7 @@
 #include <linux/time.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include "pcm_plugin.h"
 
 #define pcm_write(plug,buf,count) snd_pcm_oss_write3(plug,buf,count,1)
diff -Nru a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
--- a/sound/core/oss/pcm_oss.c	Sun Sep 29 20:20:12 2002
+++ b/sound/core/oss/pcm_oss.c	Sun Sep 29 20:20:12 2002
@@ -267,8 +267,8 @@
 	int err;
 	int direct;
 	int format, sformat, n;
-	unsigned int sformat_mask;
-	unsigned int mask;
+	snd_mask_t sformat_mask;
+	snd_mask_t mask;
 
 	if (atomic_read(&runtime->mmap_count)) {
 		direct = 1;
@@ -280,12 +280,13 @@
 	_snd_pcm_hw_params_any(&sparams);
 	_snd_pcm_hw_param_setinteger(&sparams, SNDRV_PCM_HW_PARAM_PERIODS);
 	_snd_pcm_hw_param_min(&sparams, SNDRV_PCM_HW_PARAM_PERIODS, 2, 0);
+	snd_mask_none(&mask);
 	if (atomic_read(&runtime->mmap_count))
-		mask = 1 << SNDRV_PCM_ACCESS_MMAP_INTERLEAVED;
+		snd_mask_set(&mask, SNDRV_PCM_ACCESS_MMAP_INTERLEAVED);
 	else {
-		mask = 1 << SNDRV_PCM_ACCESS_RW_INTERLEAVED;
+		snd_mask_set(&mask, SNDRV_PCM_ACCESS_RW_INTERLEAVED);
 		if (!direct)
-			mask |= 1 << SNDRV_PCM_ACCESS_RW_NONINTERLEAVED;
+			snd_mask_set(&mask, SNDRV_PCM_ACCESS_RW_NONINTERLEAVED);
 	}
 	err = snd_pcm_hw_param_mask(substream, &sparams, SNDRV_PCM_HW_PARAM_ACCESS, &mask);
 	if (err < 0) {
@@ -301,11 +302,11 @@
 	if (direct)
 		sformat = format;
 	else
-		sformat = snd_pcm_plug_slave_format(format, sformat_mask);
+		sformat = snd_pcm_plug_slave_format(format, &sformat_mask);
 
-	if (sformat < 0 || !(sformat_mask & (1 << sformat))) {
+	if (sformat < 0 || !snd_mask_test(&sformat_mask, sformat)) {
 		for (sformat = 0; sformat <= SNDRV_PCM_FORMAT_LAST; sformat++) {
-			if ((sformat_mask & (1 << sformat)) &&
+			if (snd_mask_test(&sformat_mask, sformat) &&
 			    snd_pcm_oss_format_to(sformat) >= 0)
 				break;
 		}
@@ -935,7 +936,7 @@
 	int direct;
 	snd_pcm_hw_params_t params;
 	unsigned int formats = 0;
-	unsigned int format_mask;
+	snd_mask_t format_mask;
 	int fmt;
 	if ((err = snd_pcm_oss_get_active_substream(pcm_oss_file, &substream)) < 0)
 		return err;
@@ -955,7 +956,7 @@
 	snd_assert(err >= 0, return err);
 	format_mask = *hw_param_mask(&params, SNDRV_PCM_HW_PARAM_FORMAT); 
 	for (fmt = 0; fmt < 32; ++fmt) {
-		if (format_mask & (1 << fmt)) {
+		if (snd_mask_test(&format_mask, fmt)) {
 			int f = snd_pcm_oss_format_to(fmt);
 			if (f >= 0)
 				formats |= f;
diff -Nru a/sound/core/oss/pcm_plugin.c b/sound/core/oss/pcm_plugin.c
--- a/sound/core/oss/pcm_plugin.c	Sun Sep 29 20:20:12 2002
+++ b/sound/core/oss/pcm_plugin.c	Sun Sep 29 20:20:12 2002
@@ -31,6 +31,7 @@
 #include <linux/vmalloc.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include "pcm_plugin.h"
 
 #define snd_pcm_plug_first(plug) ((plug)->runtime->oss.plugin_first)
@@ -280,20 +281,23 @@
 	return frames;
 }
 
-unsigned int snd_pcm_plug_formats(unsigned int formats)
+static int snd_pcm_plug_formats(snd_mask_t *mask, int format)
 {
-	int linfmts = (SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
+	snd_mask_t formats = *mask;
+	u64 linfmts = (SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
 		       SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_S16_LE |
 		       SNDRV_PCM_FMTBIT_U16_BE | SNDRV_PCM_FMTBIT_S16_BE |
 		       SNDRV_PCM_FMTBIT_U24_LE | SNDRV_PCM_FMTBIT_S24_LE |
 		       SNDRV_PCM_FMTBIT_U24_BE | SNDRV_PCM_FMTBIT_S24_BE |
 		       SNDRV_PCM_FMTBIT_U32_LE | SNDRV_PCM_FMTBIT_S32_LE |
 		       SNDRV_PCM_FMTBIT_U32_BE | SNDRV_PCM_FMTBIT_S32_BE);
-	formats |= SNDRV_PCM_FMTBIT_MU_LAW;
+	snd_mask_set(&formats, SNDRV_PCM_FORMAT_MU_LAW);
 	
-	if (formats & linfmts)
-		formats |= linfmts;
-	return formats;
+	if (formats.bits[0] & (u32)linfmts)
+		formats.bits[0] |= (u32)linfmts;
+	if (formats.bits[1] & (u32)(linfmts >> 32))
+		formats.bits[1] |= (u32)(linfmts >> 32);
+	return snd_mask_test(&formats, format);
 }
 
 static int preferred_formats[] = {
@@ -313,11 +317,11 @@
 	SNDRV_PCM_FORMAT_U8
 };
 
-int snd_pcm_plug_slave_format(int format, unsigned int format_mask)
+int snd_pcm_plug_slave_format(int format, snd_mask_t *format_mask)
 {
-	if (format_mask & (1 << format))
+	if (snd_mask_test(format_mask, format))
 		return format;
-	if ((snd_pcm_plug_formats(format_mask) & (1 << format)) == 0)
+	if (! snd_pcm_plug_formats(format_mask, format))
 		return -EINVAL;
 	if (snd_pcm_format_linear(format)) {
 		int width = snd_pcm_format_width(format);
@@ -333,7 +337,7 @@
 				for (sgn = 0; sgn < 2; ++sgn) {
 					format1 = snd_pcm_build_linear_format(width1, unsignd1, big1);
 					if (format1 >= 0 &&
-					    format_mask & (1 << format1))
+					    snd_mask_test(format_mask, format1))
 						goto _found;
 					unsignd1 = !unsignd1;
 				}
@@ -354,7 +358,7 @@
 		case SNDRV_PCM_FORMAT_MU_LAW:
 			for (i = 0; i < sizeof(preferred_formats) / sizeof(preferred_formats[0]); ++i) {
 				int format1 = preferred_formats[i];
-				if (format_mask & (1 << format1))
+				if (snd_mask_test(format_mask, format1))
 					return format1;
 			}
 		default:
diff -Nru a/sound/core/oss/pcm_plugin.h b/sound/core/oss/pcm_plugin.h
--- a/sound/core/oss/pcm_plugin.h	Sun Sep 29 20:20:12 2002
+++ b/sound/core/oss/pcm_plugin.h	Sun Sep 29 20:20:12 2002
@@ -197,13 +197,11 @@
 			      snd_pcm_plugin_format_t *dst_format,
 			      snd_pcm_plugin_t **r_plugin);
 
-unsigned int snd_pcm_plug_formats(unsigned int formats);
-
 int snd_pcm_plug_format_plugins(snd_pcm_plug_t *substream,
 				snd_pcm_hw_params_t *params,
 				snd_pcm_hw_params_t *slave_params);
 
-int snd_pcm_plug_slave_format(int format, unsigned int format_mask);
+int snd_pcm_plug_slave_format(int format, snd_mask_t *format_mask);
 
 int snd_pcm_plugin_append(snd_pcm_plugin_t *plugin);
 
diff -Nru a/sound/core/pcm.c b/sound/core/pcm.c
--- a/sound/core/pcm.c	Sun Sep 29 20:20:12 2002
+++ b/sound/core/pcm.c	Sun Sep 29 20:20:13 2002
@@ -184,6 +184,18 @@
 	FORMAT(MPEG),
 	FORMAT(GSM),
 	FORMAT(SPECIAL),
+	FORMAT(S24_3LE),
+	FORMAT(S24_3BE),
+	FORMAT(U24_3LE),
+	FORMAT(U24_3BE),
+	FORMAT(S20_3LE),
+	FORMAT(S20_3BE),
+	FORMAT(U20_3LE),
+	FORMAT(U20_3BE),
+	FORMAT(S18_3LE),
+	FORMAT(S18_3BE),
+	FORMAT(U18_3LE),
+	FORMAT(U18_3BE),
 };
 
 char *snd_pcm_subformat_names[] = {
diff -Nru a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
--- a/sound/core/pcm_lib.c	Sun Sep 29 20:20:12 2002
+++ b/sound/core/pcm_lib.c	Sun Sep 29 20:20:12 2002
@@ -810,12 +810,26 @@
 }				    
 
 int snd_pcm_hw_constraint_mask(snd_pcm_runtime_t *runtime, snd_pcm_hw_param_t var,
-			       unsigned int mask)
+			       u_int32_t mask)
 {
 	snd_pcm_hw_constraints_t *constrs = &runtime->hw_constraints;
-	unsigned int *maskp = constrs_mask(constrs, var);
-	*maskp &= mask;
-	if (*maskp == 0)
+	snd_mask_t *maskp = constrs_mask(constrs, var);
+	*maskp->bits &= mask;
+	memset(maskp->bits + 1, 0, (SNDRV_MASK_MAX-32) / 8); /* clear rest */
+	if (*maskp->bits == 0)
+		return -EINVAL;
+	return 0;
+}
+
+int snd_pcm_hw_constraint_mask64(snd_pcm_runtime_t *runtime, snd_pcm_hw_param_t var,
+				 u_int64_t mask)
+{
+	snd_pcm_hw_constraints_t *constrs = &runtime->hw_constraints;
+	snd_mask_t *maskp = constrs_mask(constrs, var);
+	maskp->bits[0] &= (u_int32_t)mask;
+	maskp->bits[1] &= (u_int32_t)(mask >> 32);
+	memset(maskp->bits + 2, 0, (SNDRV_MASK_MAX-64) / 8); /* clear rest */
+	if (! maskp->bits[0] && ! maskp->bits[1])
 		return -EINVAL;
 	return 0;
 }
@@ -982,7 +996,9 @@
 {
 	unsigned int k;
 	memset(params, 0, sizeof(*params));
-	for (k = 0; k <= SNDRV_PCM_HW_PARAM_LAST; k++)
+	for (k = SNDRV_PCM_HW_PARAM_FIRST_MASK; k <= SNDRV_PCM_HW_PARAM_LAST_MASK; k++)
+		_snd_pcm_hw_param_any(params, k);
+	for (k = SNDRV_PCM_HW_PARAM_FIRST_INTERVAL; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++)
 		_snd_pcm_hw_param_any(params, k);
 	params->info = ~0U;
 }
diff -Nru a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
--- a/sound/core/pcm_misc.c	Sun Sep 29 20:20:12 2002
+++ b/sound/core/pcm_misc.c	Sun Sep 29 20:20:12 2002
@@ -41,6 +41,12 @@
 	case SNDRV_PCM_FORMAT_S24_BE:
 	case SNDRV_PCM_FORMAT_S32_LE:
 	case SNDRV_PCM_FORMAT_S32_BE:
+	case SNDRV_PCM_FORMAT_S24_3LE:
+	case SNDRV_PCM_FORMAT_S24_3BE:
+	case SNDRV_PCM_FORMAT_S20_3LE:
+	case SNDRV_PCM_FORMAT_S20_3BE:
+	case SNDRV_PCM_FORMAT_S18_3LE:
+	case SNDRV_PCM_FORMAT_S18_3BE:
 		return 1;
 	case SNDRV_PCM_FORMAT_U8:
 	case SNDRV_PCM_FORMAT_U16_LE:
@@ -49,6 +55,12 @@
 	case SNDRV_PCM_FORMAT_U24_BE:
 	case SNDRV_PCM_FORMAT_U32_LE:
 	case SNDRV_PCM_FORMAT_U32_BE:
+	case SNDRV_PCM_FORMAT_U24_3LE:
+	case SNDRV_PCM_FORMAT_U24_3BE:
+	case SNDRV_PCM_FORMAT_U20_3LE:
+	case SNDRV_PCM_FORMAT_U20_3BE:
+	case SNDRV_PCM_FORMAT_U18_3LE:
+	case SNDRV_PCM_FORMAT_U18_3BE:
 		return 0;
 	default:
 		return -EINVAL;
@@ -82,6 +94,12 @@
 	case SNDRV_PCM_FORMAT_FLOAT_LE:
 	case SNDRV_PCM_FORMAT_FLOAT64_LE:
 	case SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE:
+	case SNDRV_PCM_FORMAT_S24_3LE:
+	case SNDRV_PCM_FORMAT_S20_3LE:
+	case SNDRV_PCM_FORMAT_S18_3LE:
+	case SNDRV_PCM_FORMAT_U24_3LE:
+	case SNDRV_PCM_FORMAT_U20_3LE:
+	case SNDRV_PCM_FORMAT_U18_3LE:
 		return 1;
 	case SNDRV_PCM_FORMAT_S16_BE:
 	case SNDRV_PCM_FORMAT_U16_BE:
@@ -92,6 +110,12 @@
 	case SNDRV_PCM_FORMAT_FLOAT_BE:
 	case SNDRV_PCM_FORMAT_FLOAT64_BE:
 	case SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE:
+	case SNDRV_PCM_FORMAT_S24_3BE:
+	case SNDRV_PCM_FORMAT_S20_3BE:
+	case SNDRV_PCM_FORMAT_S18_3BE:
+	case SNDRV_PCM_FORMAT_U24_3BE:
+	case SNDRV_PCM_FORMAT_U20_3BE:
+	case SNDRV_PCM_FORMAT_U18_3BE:
 		return 0;
 	default:
 		return -EINVAL;
@@ -128,10 +152,24 @@
 	case SNDRV_PCM_FORMAT_U16_LE:
 	case SNDRV_PCM_FORMAT_U16_BE:
 		return 16;
+	case SNDRV_PCM_FORMAT_S18_3LE:
+	case SNDRV_PCM_FORMAT_S18_3BE:
+	case SNDRV_PCM_FORMAT_U18_3LE:
+	case SNDRV_PCM_FORMAT_U18_3BE:
+		return 18;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+	case SNDRV_PCM_FORMAT_S20_3BE:
+	case SNDRV_PCM_FORMAT_U20_3LE:
+	case SNDRV_PCM_FORMAT_U20_3BE:
+		return 20;
 	case SNDRV_PCM_FORMAT_S24_LE:
 	case SNDRV_PCM_FORMAT_S24_BE:
 	case SNDRV_PCM_FORMAT_U24_LE:
 	case SNDRV_PCM_FORMAT_U24_BE:
+	case SNDRV_PCM_FORMAT_S24_3LE:
+	case SNDRV_PCM_FORMAT_S24_3BE:
+	case SNDRV_PCM_FORMAT_U24_3LE:
+	case SNDRV_PCM_FORMAT_U24_3BE:
 		return 24;
 	case SNDRV_PCM_FORMAT_S32_LE:
 	case SNDRV_PCM_FORMAT_S32_BE:
@@ -167,6 +205,19 @@
 	case SNDRV_PCM_FORMAT_U16_LE:
 	case SNDRV_PCM_FORMAT_U16_BE:
 		return 16;
+	case SNDRV_PCM_FORMAT_S18_3LE:
+	case SNDRV_PCM_FORMAT_S18_3BE:
+	case SNDRV_PCM_FORMAT_U18_3LE:
+	case SNDRV_PCM_FORMAT_U18_3BE:
+	case SNDRV_PCM_FORMAT_S20_3LE:
+	case SNDRV_PCM_FORMAT_S20_3BE:
+	case SNDRV_PCM_FORMAT_U20_3LE:
+	case SNDRV_PCM_FORMAT_U20_3BE:
+	case SNDRV_PCM_FORMAT_S24_3LE:
+	case SNDRV_PCM_FORMAT_S24_3BE:
+	case SNDRV_PCM_FORMAT_U24_3LE:
+	case SNDRV_PCM_FORMAT_U24_3BE:
+		return 24;
 	case SNDRV_PCM_FORMAT_S24_LE:
 	case SNDRV_PCM_FORMAT_S24_BE:
 	case SNDRV_PCM_FORMAT_U24_LE:
@@ -204,6 +255,19 @@
 	case SNDRV_PCM_FORMAT_U16_LE:
 	case SNDRV_PCM_FORMAT_U16_BE:
 		return samples * 2;
+	case SNDRV_PCM_FORMAT_S18_3LE:
+	case SNDRV_PCM_FORMAT_S18_3BE:
+	case SNDRV_PCM_FORMAT_U18_3LE:
+	case SNDRV_PCM_FORMAT_U18_3BE:
+	case SNDRV_PCM_FORMAT_S20_3LE:
+	case SNDRV_PCM_FORMAT_S20_3BE:
+	case SNDRV_PCM_FORMAT_U20_3LE:
+	case SNDRV_PCM_FORMAT_U20_3BE:
+	case SNDRV_PCM_FORMAT_S24_3LE:
+	case SNDRV_PCM_FORMAT_S24_3BE:
+	case SNDRV_PCM_FORMAT_U24_3LE:
+	case SNDRV_PCM_FORMAT_U24_3BE:
+		return samples * 3;
 	case SNDRV_PCM_FORMAT_S24_LE:
 	case SNDRV_PCM_FORMAT_S24_BE:
 	case SNDRV_PCM_FORMAT_U24_LE:
@@ -243,6 +307,12 @@
 	case SNDRV_PCM_FORMAT_S24_BE:
 	case SNDRV_PCM_FORMAT_S32_LE:
 	case SNDRV_PCM_FORMAT_S32_BE:
+	case SNDRV_PCM_FORMAT_S24_3LE:
+	case SNDRV_PCM_FORMAT_S24_3BE:
+	case SNDRV_PCM_FORMAT_S20_3LE:
+	case SNDRV_PCM_FORMAT_S20_3BE:
+	case SNDRV_PCM_FORMAT_S18_3LE:
+	case SNDRV_PCM_FORMAT_S18_3BE:
 		return 0;
 	case SNDRV_PCM_FORMAT_U8:
 		return 0x8080808080808080ULL;
@@ -273,6 +343,15 @@
 	case SNDRV_PCM_FORMAT_U32_BE:
 		return 0x8000000080000000ULL;
 #endif
+	case SNDRV_PCM_FORMAT_U24_3LE:
+	case SNDRV_PCM_FORMAT_U24_3BE:
+		return 0x0000800000800000ULL;
+	case SNDRV_PCM_FORMAT_U20_3LE:
+	case SNDRV_PCM_FORMAT_U20_3BE:
+		return 0x0000080000080000ULL;
+	case SNDRV_PCM_FORMAT_U18_3LE:
+	case SNDRV_PCM_FORMAT_U18_3BE:
+		return 0x0000020000020000ULL;
 	case SNDRV_PCM_FORMAT_FLOAT_LE:
 	{
 		union {
@@ -379,20 +458,45 @@
 	}
 	case 16: {
 		u_int16_t silence = snd_pcm_format_silence_64(format);
-		while (samples-- > 0)
-			*((u_int16_t *)data)++ = silence;
+		if (! silence)
+			memset(data, 0, samples * 2);
+		else {
+			while (samples-- > 0)
+				*((u_int16_t *)data)++ = silence;
+		}
 		break;
 	}
+	case 24: {
+		u_int32_t silence = snd_pcm_format_silence_64(format);
+		if (! silence)
+			memset(data, 0, samples * 3);
+		else {
+			/* FIXME: rewrite in the more better way.. */
+			int i;
+			while (samples-- > 0) {
+				for (i = 0; i < 3; i++)
+					*((u_int8_t *)data)++ = silence >> (i * 8);
+			}
+		}
+	}
 	case 32: {
 		u_int32_t silence = snd_pcm_format_silence_64(format);
-		while (samples-- > 0)
-			*((u_int32_t *)data)++ = silence;
+		if (! silence)
+			memset(data, 0, samples * 4);
+		else {
+			while (samples-- > 0)
+				*((u_int32_t *)data)++ = silence;
+		}
 		break;
 	}
 	case 64: {
 		u_int64_t silence = snd_pcm_format_silence_64(format);
-		while (samples-- > 0)
-			*((u_int64_t *)data)++ = silence;
+		if (! silence)
+			memset(data, 0, samples * 8);
+		else {
+			while (samples-- > 0)
+				*((u_int64_t *)data)++ = silence;
+		}
 		break;
 	}
 	default:
diff -Nru a/sound/core/pcm_native.c b/sound/core/pcm_native.c
--- a/sound/core/pcm_native.c	Sun Sep 29 20:20:12 2002
+++ b/sound/core/pcm_native.c	Sun Sep 29 20:20:12 2002
@@ -32,6 +32,36 @@
 #include <sound/pcm_params.h>
 #include <sound/minors.h>
 
+/*
+ *  Compatibility
+ */
+
+struct sndrv_pcm_hw_params_old {
+	unsigned int flags;
+	unsigned int masks[SNDRV_PCM_HW_PARAM_SUBFORMAT -
+			   SNDRV_PCM_HW_PARAM_ACCESS + 1];
+	struct sndrv_interval intervals[SNDRV_PCM_HW_PARAM_TICK_TIME -
+					SNDRV_PCM_HW_PARAM_SAMPLE_BITS + 1];
+	unsigned int rmask;
+	unsigned int cmask;
+	unsigned int info;
+	unsigned int msbits;
+	unsigned int rate_num;
+	unsigned int rate_den;
+	sndrv_pcm_uframes_t fifo_size;
+	unsigned char reserved[64];
+};
+
+#define SNDRV_PCM_IOCTL_HW_REFINE_OLD _IOWR('A', 0x10, struct sndrv_pcm_hw_params_old)
+#define SNDRV_PCM_IOCTL_HW_PARAMS_OLD _IOWR('A', 0x11, struct sndrv_pcm_hw_params_old)
+
+static int snd_pcm_hw_refine_old_user(snd_pcm_substream_t * substream, struct sndrv_pcm_hw_params_old * _oparams);
+static int snd_pcm_hw_params_old_user(snd_pcm_substream_t * substream, struct sndrv_pcm_hw_params_old * _oparams);
+
+/*
+ *
+ */
+
 static rwlock_t pcm_link_lock = RW_LOCK_UNLOCKED;
 
 static inline mm_segment_t snd_enter_user(void)
@@ -52,6 +82,8 @@
 		__MOD_DEC_USE_COUNT(module);
 }
 
+
+
 int snd_pcm_info(snd_pcm_substream_t * substream, snd_pcm_info_t *info)
 {
 	snd_pcm_runtime_t * runtime;
@@ -121,7 +153,7 @@
 	snd_mask_t *m = NULL;
 	snd_pcm_hw_constraints_t *constrs = &substream->runtime->hw_constraints;
 	unsigned int rstamps[constrs->rules_num];
-	unsigned int vstamps[SNDRV_PCM_HW_PARAM_LAST + 1];
+	unsigned int vstamps[SNDRV_PCM_HW_PARAM_LAST_INTERVAL + 1];
 	unsigned int stamp = 2;
 	int changed, again;
 
@@ -187,7 +219,7 @@
 
 	for (k = 0; k < constrs->rules_num; k++)
 		rstamps[k] = 0;
-	for (k = 0; k <= SNDRV_PCM_HW_PARAM_LAST; k++) 
+	for (k = 0; k <= SNDRV_PCM_HW_PARAM_LAST_INTERVAL; k++) 
 		vstamps[k] = (params->rmask & (1 << k)) ? 1 : 0;
 	do {
 		again = 0;
@@ -211,7 +243,7 @@
 				printk("%s = ", snd_pcm_hw_param_names[r->var]);
 				if (hw_is_mask(r->var)) {
 					m = hw_param_mask(params, r->var);
-					printk("%x", *m);
+					printk("%x", *m->bits);
 				} else {
 					i = hw_param_interval(params, r->var);
 					if (i->empty)
@@ -228,7 +260,7 @@
 			if (r->var >= 0) {
 				printk(" -> ");
 				if (hw_is_mask(r->var))
-					printk("%x", *m);
+					printk("%x", *m->bits);
 				else {
 					if (i->empty)
 						printk("empty");
@@ -1369,16 +1401,17 @@
 {
 	unsigned int k;
 	snd_interval_t *i = hw_param_interval(params, rule->deps[0]);
-	unsigned int m = ~0U;
-	unsigned int *mask = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
+	snd_mask_t m;
+	snd_mask_t *mask = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
+	snd_mask_any(&m);
 	for (k = 0; k <= SNDRV_PCM_FORMAT_LAST; ++k) {
 		int bits;
-		if (!(*mask & (1U << k)))
+		if (! snd_mask_test(mask, k))
 			continue;
 		bits = snd_pcm_format_physical_width(k);
 		snd_assert(bits > 0, continue);
 		if ((unsigned)bits < i->min || (unsigned)bits > i->max)
-			m &= ~(1U << k);
+			snd_mask_reset(&m, k);
 	}
 	return snd_mask_refine(mask, &m);
 }
@@ -1394,7 +1427,7 @@
 	t.openmax = 0;
 	for (k = 0; k <= SNDRV_PCM_FORMAT_LAST; ++k) {
 		int bits;
-		if (!(*hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT) & (1U << k)))
+		if (! snd_mask_test(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT), k))
 			continue;
 		bits = snd_pcm_format_physical_width(k);
 		snd_assert(bits > 0, continue);
@@ -1582,7 +1615,8 @@
 	err = snd_pcm_hw_constraint_mask(runtime, SNDRV_PCM_HW_PARAM_ACCESS, mask);
 	snd_assert(err >= 0, return -EINVAL);
 
-	err = snd_pcm_hw_constraint_mask(runtime, SNDRV_PCM_HW_PARAM_FORMAT, hw->formats);
+	err = snd_pcm_hw_constraint_mask64(runtime, SNDRV_PCM_HW_PARAM_FORMAT, hw->formats);
+	//err = snd_pcm_hw_constraint_mask(runtime, SNDRV_PCM_HW_PARAM_FORMAT, hw->formats);
 	snd_assert(err >= 0, return -EINVAL);
 
 	err = snd_pcm_hw_constraint_mask(runtime, SNDRV_PCM_HW_PARAM_SUBFORMAT, 1 << SNDRV_PCM_SUBFORMAT_STD);
@@ -1808,12 +1842,7 @@
 	snd_assert(substream != NULL, return -ENXIO);
 	snd_assert(!atomic_read(&substream->runtime->mmap_count), );
 	pcm = substream->pcm;
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if ((substream->ffile->f_flags & O_NONBLOCK) ||
-		    snd_pcm_playback_drain(substream) == -ERESTARTSYS)
-			snd_pcm_playback_drop(substream);
-	} else
-		snd_pcm_capture_drop(substream);
+	snd_pcm_capture_drop(substream);
 	fasync_helper(-1, file, 0, &substream->runtime->fasync);
 	down(&pcm->open_mutex);
 	snd_pcm_release_file(pcm_file);
@@ -2053,6 +2082,10 @@
 		return snd_pcm_resume(substream);
 	case SNDRV_PCM_IOCTL_XRUN:
 		return snd_pcm_xrun(substream);
+	case SNDRV_PCM_IOCTL_HW_REFINE_OLD:
+		return snd_pcm_hw_refine_old_user(substream, (struct sndrv_pcm_hw_params_old *) arg);
+	case SNDRV_PCM_IOCTL_HW_PARAMS_OLD:
+		return snd_pcm_hw_params_old_user(substream, (struct sndrv_pcm_hw_params_old *) arg);
 	}
 	snd_printd("unknown ioctl = 0x%x\n", cmd);
 	return -ENOTTY;
@@ -2723,6 +2756,79 @@
 	if (err < 0)
 		return err;
 	return 0;
+}
+
+/*
+ *  To be removed helpers to keep binary compatibility
+ */
+
+#define __OLD_TO_NEW_MASK(x) ((x&7)|((x&0x07fffff8)<<5))
+#define __NEW_TO_OLD_MASK(x) ((x&7)|((x&0xffffff00)>>5))
+
+static void snd_pcm_hw_convert_from_old_params(snd_pcm_hw_params_t *params, struct sndrv_pcm_hw_params_old *oparams)
+{
+	unsigned int i;
+
+	memset(params, 0, sizeof(*params));
+	params->flags = oparams->flags;
+	for (i = 0; i < sizeof(oparams->masks) / sizeof(unsigned int); i++)
+		params->masks[i].bits[0] = oparams->masks[i];
+	memcpy(params->intervals, oparams->intervals, sizeof(oparams->intervals));
+	params->rmask = __OLD_TO_NEW_MASK(oparams->rmask);
+	params->cmask = __OLD_TO_NEW_MASK(oparams->cmask);
+	params->info = oparams->info;
+	params->msbits = oparams->msbits;
+	params->rate_num = oparams->rate_num;
+	params->rate_den = oparams->rate_den;
+	params->fifo_size = oparams->fifo_size;
+}
+
+static void snd_pcm_hw_convert_to_old_params(struct sndrv_pcm_hw_params_old *oparams, snd_pcm_hw_params_t *params)
+{
+	unsigned int i;
+
+	memset(oparams, 0, sizeof(*oparams));
+	oparams->flags = params->flags;
+	for (i = 0; i < sizeof(oparams->masks) / sizeof(unsigned int); i++)
+		oparams->masks[i] = params->masks[i].bits[0];
+	memcpy(oparams->intervals, params->intervals, sizeof(oparams->intervals));
+	oparams->rmask = __NEW_TO_OLD_MASK(params->rmask);
+	oparams->cmask = __NEW_TO_OLD_MASK(params->cmask);
+	oparams->info = params->info;
+	oparams->msbits = params->msbits;
+	oparams->rate_num = params->rate_num;
+	oparams->rate_den = params->rate_den;
+	oparams->fifo_size = params->fifo_size;
+}
+
+static int snd_pcm_hw_refine_old_user(snd_pcm_substream_t * substream, struct sndrv_pcm_hw_params_old * _oparams)
+{
+	snd_pcm_hw_params_t params;
+	struct sndrv_pcm_hw_params_old oparams;
+	int err;
+	if (copy_from_user(&oparams, _oparams, sizeof(oparams)))
+		return -EFAULT;
+	snd_pcm_hw_convert_from_old_params(&params, &oparams);
+	err = snd_pcm_hw_refine(substream, &params);
+	snd_pcm_hw_convert_to_old_params(&oparams, &params);
+	if (copy_to_user(_oparams, &oparams, sizeof(oparams)))
+		return -EFAULT;
+	return err;
+}
+
+static int snd_pcm_hw_params_old_user(snd_pcm_substream_t * substream, struct sndrv_pcm_hw_params_old * _oparams)
+{
+	snd_pcm_hw_params_t params;
+	struct sndrv_pcm_hw_params_old oparams;
+	int err;
+	if (copy_from_user(&oparams, _oparams, sizeof(oparams)))
+		return -EFAULT;
+	snd_pcm_hw_convert_from_old_params(&params, &oparams);
+	err = snd_pcm_hw_params(substream, &params);
+	snd_pcm_hw_convert_to_old_params(&oparams, &params);
+	if (copy_to_user(_oparams, &oparams, sizeof(oparams)))
+		return -EFAULT;
+	return err;
 }
 
 /*
diff -Nru a/sound/core/seq/oss/Makefile b/sound/core/seq/oss/Makefile
--- a/sound/core/seq/oss/Makefile	Sun Sep 29 20:20:12 2002
+++ b/sound/core/seq/oss/Makefile	Sun Sep 29 20:20:12 2002
@@ -7,8 +7,8 @@
 		     seq_oss_event.o seq_oss_rw.o seq_oss_synth.o \
 		     seq_oss_midi.o seq_oss_readq.o seq_oss_writeq.o
 
-obj-$(CONFIG_SND_SEQUENCER) += snd-seq-oss.o
-
 ifeq ($(CONFIG_SND_SEQUENCER_OSS),y)
-  include $(TOPDIR)/Rules.make
+  obj-$(CONFIG_SND_SEQUENCER) += snd-seq-oss.o
 endif
+
+include $(TOPDIR)/Rules.make
diff -Nru a/sound/isa/Makefile b/sound/isa/Makefile
--- a/sound/isa/Makefile	Sun Sep 29 20:20:12 2002
+++ b/sound/isa/Makefile	Sun Sep 29 20:20:12 2002
@@ -3,8 +3,6 @@
 # Copyright (c) 2001 by Jaroslav Kysela <perex@suse.cz>
 #
 
-mod-subdirs  := ad1816a ad1848 cs423x es1688 gus opti9xx sb wavefront
-
 snd-als100-objs := als100.o
 snd-azt2320-objs := azt2320.o
 snd-cmi8330-objs := cmi8330.o
diff -Nru a/sound/isa/ad1848/ad1848_lib.c b/sound/isa/ad1848/ad1848_lib.c
--- a/sound/isa/ad1848/ad1848_lib.c	Sun Sep 29 20:20:12 2002
+++ b/sound/isa/ad1848/ad1848_lib.c	Sun Sep 29 20:20:12 2002
@@ -24,11 +24,13 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <linux/delay.h>
+#include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <sound/core.h>
 #include <sound/ad1848.h>
+#include <sound/pcm_params.h>
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("Routines for control of AD1848/AD1847/CS4248");
diff -Nru a/sound/isa/cs423x/cs4231_lib.c b/sound/isa/cs423x/cs4231_lib.c
--- a/sound/isa/cs423x/cs4231_lib.c	Sun Sep 29 20:20:12 2002
+++ b/sound/isa/cs423x/cs4231_lib.c	Sun Sep 29 20:20:12 2002
@@ -35,6 +35,7 @@
 #include <linux/ioport.h>
 #include <sound/core.h>
 #include <sound/cs4231.h>
+#include <sound/pcm_params.h>
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("Routines for control of CS4231(A)/CS4232/InterWave & compatible chips");
diff -Nru a/sound/isa/es18xx.c b/sound/isa/es18xx.c
--- a/sound/isa/es18xx.c	Sun Sep 29 20:20:12 2002
+++ b/sound/isa/es18xx.c	Sun Sep 29 20:20:12 2002
@@ -78,6 +78,7 @@
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/mpu401.h>
 #include <sound/opl3.h>
 #define SNDRV_LEGACY_AUTO_PROBE
diff -Nru a/sound/isa/gus/gus_pcm.c b/sound/isa/gus/gus_pcm.c
--- a/sound/isa/gus/gus_pcm.c	Sun Sep 29 20:20:12 2002
+++ b/sound/isa/gus/gus_pcm.c	Sun Sep 29 20:20:12 2002
@@ -32,6 +32,7 @@
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/gus.h>
+#include <sound/pcm_params.h>
 #include "gus_tables.h"
 
 #define chip_t snd_gus_card_t
diff -Nru a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
--- a/sound/pci/korg1212/korg1212.c	Sun Sep 29 20:20:12 2002
+++ b/sound/pci/korg1212/korg1212.c	Sun Sep 29 20:20:12 2002
@@ -29,6 +29,7 @@
 #include <sound/info.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
 
diff -Nru a/sound/pci/rme32.c b/sound/pci/rme32.c
--- a/sound/pci/rme32.c	Sun Sep 29 20:20:12 2002
+++ b/sound/pci/rme32.c	Sun Sep 29 20:20:12 2002
@@ -23,8 +23,7 @@
  *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  * 
  * 
- *   ToDo: - ADAT (32/8)
- *         - full duplex (32, 32/8, 32Pro)
+ *   ToDo: full duplex (32, 32/8, 32Pro)
  */
 
 #include <sound/driver.h>
@@ -37,6 +36,7 @@
 #include <sound/info.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/asoundef.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
@@ -327,6 +327,54 @@
 	fifo_size:	0,
 };
 
+/*
+ * Digital output capabilites (ADAT)
+ */
+static snd_pcm_hardware_t snd_rme32_playback_adat_info =
+{
+	info:		     (SNDRV_PCM_INFO_MMAP |
+			      SNDRV_PCM_INFO_MMAP_VALID |
+			      SNDRV_PCM_INFO_INTERLEAVED |
+			      SNDRV_PCM_INFO_PAUSE),
+	formats:             SNDRV_PCM_FMTBIT_S16_LE,
+	rates:	             (SNDRV_PCM_RATE_44100 | 
+			      SNDRV_PCM_RATE_48000),
+	rate_min:            44100,
+	rate_max:            48000,
+	channels_min:        8,
+	channels_max:	     8,
+	buffer_bytes_max:   RME32_BUFFER_SIZE,
+	period_bytes_min:   RME32_BLOCK_SIZE,
+	period_bytes_max:   RME32_BLOCK_SIZE,
+	periods_min:	     RME32_BUFFER_SIZE / RME32_BLOCK_SIZE,
+	periods_max:	     RME32_BUFFER_SIZE / RME32_BLOCK_SIZE,
+	fifo_size:	     0,
+};
+
+/*
+ * Digital input capabilites (ADAT)
+ */
+static snd_pcm_hardware_t snd_rme32_capture_adat_info =
+{
+	info:		     (SNDRV_PCM_INFO_MMAP |
+			      SNDRV_PCM_INFO_MMAP_VALID |
+			      SNDRV_PCM_INFO_INTERLEAVED |
+			      SNDRV_PCM_INFO_PAUSE),
+	formats:             SNDRV_PCM_FMTBIT_S16_LE,
+	rates:	             (SNDRV_PCM_RATE_44100 | 
+			      SNDRV_PCM_RATE_48000),
+	rate_min:            44100,
+	rate_max:            48000,
+	channels_min:        8,
+	channels_max:	     8,
+	buffer_bytes_max:   RME32_BUFFER_SIZE,
+	period_bytes_min:   RME32_BLOCK_SIZE,
+	period_bytes_max:   RME32_BLOCK_SIZE,
+	periods_min:	     RME32_BUFFER_SIZE / RME32_BLOCK_SIZE,
+	periods_max:	     RME32_BUFFER_SIZE / RME32_BLOCK_SIZE,
+	fifo_size:           0,
+};
+
 static void snd_rme32_reset_dac(rme32_t *rme32)
 {
         writel(rme32->wcreg | RME32_WCR_PD,
@@ -359,15 +407,20 @@
 static int snd_rme32_capture_getrate(rme32_t * rme32, int *is_adat)
 {
 	int n;
-	*is_adat = 0;
 
+	*is_adat = 0;
+	if (rme32->rcreg & RME32_RCR_LOCK) { 
+                /* ADAT rate */
+                *is_adat = 1;
+	}
 	if (rme32->rcreg & RME32_RCR_ERF) {
 		return -1;
 	}
 
+        /* S/PDIF rate */
 	n = ((rme32->rcreg >> RME32_RCR_BITPOS_F0) & 1) +
-	    (((rme32->rcreg >> RME32_RCR_BITPOS_F1) & 1) << 1) +
-	    (((rme32->rcreg >> RME32_RCR_BITPOS_F2) & 1) << 2);
+		(((rme32->rcreg >> RME32_RCR_BITPOS_F1) & 1) << 1) +
+		(((rme32->rcreg >> RME32_RCR_BITPOS_F2) & 1) << 2);
 
 	if (RME32_PRO_WITH_8414(rme32))
 		switch (n) {	/* supporting the CS8414 */
@@ -388,7 +441,8 @@
 		default:
 			return -1;
 			break;
-	} else
+		} 
+	else
 		switch (n) {	/* supporting the CS8412 */
 		case 0:
 			return -1;
@@ -816,6 +870,62 @@
 	return 0;
 }
 
+static int
+snd_rme32_playback_adat_open(snd_pcm_substream_t *substream)
+{
+	unsigned long flags;
+	rme32_t *rme32 = _snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	
+	snd_pcm_set_sync(substream);
+
+	spin_lock_irqsave(&rme32->lock, flags);	
+	rme32->wcreg |= RME32_WCR_ADAT;
+	writel(rme32->wcreg, rme32->iobase + RME32_IO_CONTROL_REGISTER);
+	rme32->playback_substream = substream;
+	rme32->playback_last_appl_ptr = 0;
+	rme32->playback_ptr = 0;
+	spin_unlock_irqrestore(&rme32->lock, flags);
+	
+	runtime->hw = snd_rme32_playback_adat_info;
+	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+				     RME32_BUFFER_SIZE, RME32_BUFFER_SIZE);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
+				   &hw_constraints_period_bytes);
+	return 0;
+}
+
+static int
+snd_rme32_capture_adat_open(snd_pcm_substream_t *substream)
+{
+	unsigned long flags;
+	int isadat;
+	rme32_t *rme32 = _snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+
+	rme32->rcreg = readl(rme32->iobase + RME32_IO_CONTROL_REGISTER);
+	if (snd_rme32_capture_getrate(rme32, &isadat) < 0) {
+		/* no input */
+		return -EIO;
+	}
+	if (!isadat) {
+		/* S/PDIF input */
+		return -EBUSY;
+	}
+	snd_pcm_set_sync(substream);
+
+	spin_lock_irqsave(&rme32->lock, flags);	
+	rme32->capture_substream = substream;
+	rme32->capture_ptr = 0;
+	spin_unlock_irqrestore(&rme32->lock, flags);
+
+	runtime->hw = snd_rme32_capture_adat_info;
+	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+				     RME32_BUFFER_SIZE, RME32_BUFFER_SIZE);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
+				   &hw_constraints_period_bytes);
+	return 0;
+}
 
 static int snd_rme32_playback_close(snd_pcm_substream_t * substream)
 {
@@ -1004,7 +1114,31 @@
 snd_rme32_capture_pointer(snd_pcm_substream_t * substream)
 {
 	rme32_t *rme32 = _snd_pcm_substream_chip(substream);
-	return snd_rme32_capture_ptr(rme32);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	snd_pcm_uframes_t frameptr;
+	size_t ptr;
+
+	frameptr = snd_rme32_capture_ptr(rme32);
+	if (runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) {
+		ptr = frameptr << rme32->capture_frlog;
+		if (ptr > rme32->capture_ptr) {
+			memcpy_fromio(runtime->dma_area + rme32->capture_ptr,
+				      rme32->iobase + RME32_IO_DATA_BUFFER +
+				      rme32->capture_ptr,
+				      ptr - rme32->capture_ptr);
+			rme32->capture_ptr += ptr - rme32->capture_ptr;
+		} else if (ptr < rme32->capture_ptr) {
+			memcpy_fromio(runtime->dma_area + rme32->capture_ptr,
+				      rme32->iobase + RME32_IO_DATA_BUFFER +
+				      rme32->capture_ptr,
+				      RME32_BUFFER_SIZE - rme32->capture_ptr);
+			memcpy_fromio(runtime->dma_area,
+				      rme32->iobase + RME32_IO_DATA_BUFFER,
+				      ptr);
+			rme32->capture_ptr = ptr;
+		}
+	}
+	return frameptr;
 }
 
 static snd_pcm_ops_t snd_rme32_playback_spdif_ops = {
@@ -1032,6 +1166,31 @@
 	copy:		snd_rme32_capture_copy,
 };
 
+static snd_pcm_ops_t snd_rme32_playback_adat_ops = {
+	open:		snd_rme32_playback_adat_open,
+	close:		snd_rme32_playback_close,
+	ioctl:		snd_pcm_lib_ioctl,
+	hw_params:	snd_rme32_playback_hw_params,
+	hw_free:	snd_rme32_playback_hw_free,
+	prepare:	snd_rme32_playback_prepare,
+	trigger:	snd_rme32_playback_trigger,
+	pointer:	snd_rme32_playback_pointer,
+	copy:		snd_rme32_playback_copy,
+	silence:	snd_rme32_playback_silence,
+};
+
+static snd_pcm_ops_t snd_rme32_capture_adat_ops = {
+	open:		snd_rme32_capture_adat_open,
+	close:		snd_rme32_capture_close,
+	ioctl:		snd_pcm_lib_ioctl,
+	hw_params:	snd_rme32_capture_hw_params,
+	hw_free:	snd_rme32_capture_hw_free,
+	prepare:	snd_rme32_capture_prepare,
+	trigger:	snd_rme32_capture_trigger,
+	pointer:	snd_rme32_capture_pointer,
+	copy:		snd_rme32_capture_copy,
+};
+
 static void snd_rme32_free(void *private_data)
 {
 	rme32_t *rme32 = (rme32_t *) private_data;
@@ -1063,6 +1222,14 @@
 	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
 
+static void
+snd_rme32_free_adat_pcm(snd_pcm_t *pcm)
+{
+	rme32_t *rme32 = (rme32_t *) pcm->private_data;
+	rme32->adat_pcm = NULL;
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+}
+
 static int __devinit snd_rme32_create(rme32_t * rme32)
 {
 	struct pci_dev *pci = rme32->pci;
@@ -1117,10 +1284,33 @@
 					      GFP_KERNEL);
 
 	/* set up ALSA pcm device for ADAT */
-	if (pci->device == PCI_DEVICE_ID_DIGI32) {
-		/* ADAT is not available on the base model */
+	if ((pci->device == PCI_DEVICE_ID_DIGI32) ||
+	    (pci->device == PCI_DEVICE_ID_DIGI32_PRO)) {
+		/* ADAT is not available on DIGI32 and DIGI32 Pro */
 		rme32->adat_pcm = NULL;
 	}
+	else {
+		if ((err = snd_pcm_new(rme32->card, "Digi32 ADAT", 1,
+				       1, 1, &rme32->adat_pcm)) < 0)
+		{
+			return err;
+		}		
+		rme32->adat_pcm->private_data = rme32;
+		rme32->adat_pcm->private_free = snd_rme32_free_adat_pcm;
+		strcpy(rme32->adat_pcm->name, "Digi32 ADAT");
+		snd_pcm_set_ops(rme32->adat_pcm, SNDRV_PCM_STREAM_PLAYBACK, 
+				&snd_rme32_playback_adat_ops);
+		snd_pcm_set_ops(rme32->adat_pcm, SNDRV_PCM_STREAM_CAPTURE, 
+				&snd_rme32_capture_adat_ops);
+		
+		rme32->adat_pcm->info_flags = 0;
+
+		snd_pcm_lib_preallocate_pages_for_all(rme32->adat_pcm, 
+						      RME32_BUFFER_SIZE, 
+						      RME32_BUFFER_SIZE, 
+						      GFP_KERNEL);
+	}
+
 
 	rme32->playback_periodsize = 0;
 	rme32->capture_periodsize = 0;
@@ -1137,8 +1327,8 @@
 
 	/* set default values in registers */
 	rme32->wcreg = RME32_WCR_SEL |	 /* normal playback */
-		       RME32_WCR_INP_0 | /* input select */
-		       RME32_WCR_MUTE;	 /* setting muting on */
+		RME32_WCR_INP_0 | /* input select */
+		RME32_WCR_MUTE;	 /* muting on */
 	writel(rme32->wcreg, rme32->iobase + RME32_IO_CONTROL_REGISTER);
 
 
diff -Nru a/sound/pci/rme96.c b/sound/pci/rme96.c
--- a/sound/pci/rme96.c	Sun Sep 29 20:20:12 2002
+++ b/sound/pci/rme96.c	Sun Sep 29 20:20:12 2002
@@ -33,6 +33,7 @@
 #include <sound/info.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/asoundef.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
diff -Nru a/sound/pci/via8233.c b/sound/pci/via8233.c
--- a/sound/pci/via8233.c	Sun Sep 29 20:20:12 2002
+++ b/sound/pci/via8233.c	Sun Sep 29 20:20:12 2002
@@ -366,9 +366,9 @@
 		switch (runtime->channels) {
 		case 1: slots = (1<<0); break;
 		case 2: slots = (1<<0) | (2<<4); break;
-		case 4: slots = (1<<0) | (2<<4) | (3<<8) | (4<<12);
+		case 4: slots = (1<<0) | (2<<4) | (3<<8) | (4<<12); break;
 		case 6: slots = (1<<0) | (2<<4) | (5<<8) | (6<<12) | (3<<16) | (4<<20); break;
-		default: slots = 0;
+		default: slots = 0; break;
 		}
 		/* STOP index is never reached */
 		outl(0xff000000 | slots, chip->port + VIA_REG_MULTPLAY_STOP_IDX);

===================================================================


This BitKeeper patch contains the following changesets:
1.605.2.13
## Wrapped with gzip_uu ##


begin 664 bkpatch2308
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
B$`"R]R\VI$VDR;TY^>`M'TZ,M@;L:<I[_P-\2%<MB*X`````
`
end

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

