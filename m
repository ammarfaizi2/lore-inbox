Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265327AbUFHV2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265327AbUFHV2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 17:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265328AbUFHV2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 17:28:43 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:51938 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S265327AbUFHVZB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 17:25:01 -0400
Date: Wed, 9 Jun 2004 00:25:00 +0300
From: Pekka J Enberg <penberg@cs.helsinki.fi>
Message-Id: <200406082125.i58LP0mh016185@melkki.cs.helsinki.fi>
Subject: [PATCH] ALSA: Remove subsystem-specific malloc (3/8)
To: linux-kernel@vger.kernel.org, tiwai@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace magic allocator in linux/sound/drivers/ with kcalloc() and kfree().

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

 dummy.c              |   14 +++++++-------
 mpu401/mpu401_uart.c |    4 ++--
 mtpav.c              |    4 ++--
 opl3/opl3_lib.c      |    4 ++--
 opl3/opl3_oss.c      |    2 +-
 opl4/opl4_lib.c      |    4 ++--
 serial-u16550.c      |    4 ++--
 vx/vx_core.c         |    2 +-
 vx/vx_pcm.c          |    4 ++--
 9 files changed, 21 insertions(+), 21 deletions(-)

diff -X dontdiff -purN linux-2.6.6/sound/drivers/dummy.c alsa-2.6.6/sound/drivers/dummy.c
--- linux-2.6.6/sound/drivers/dummy.c	2004-06-08 23:57:25.282602592 +0300
+++ alsa-2.6.6/sound/drivers/dummy.c	2004-06-05 21:10:02.000000000 +0300
@@ -338,7 +338,7 @@ static snd_pcm_hardware_t snd_card_dummy
 static void snd_card_dummy_runtime_free(snd_pcm_runtime_t *runtime)
 {
 	snd_card_dummy_pcm_t *dpcm = snd_magic_cast(snd_card_dummy_pcm_t, runtime->private_data, return);
-	snd_magic_kfree(dpcm);
+	kfree(dpcm);
 }
 
 static int snd_card_dummy_playback_open(snd_pcm_substream_t * substream)
@@ -347,11 +347,11 @@ static int snd_card_dummy_playback_open(
 	snd_card_dummy_pcm_t *dpcm;
 	int err;
 
-	dpcm = snd_magic_kcalloc(snd_card_dummy_pcm_t, 0, GFP_KERNEL);
+	dpcm = kcalloc(sizeof(*dpcm), GFP_KERNEL);
 	if (dpcm == NULL)
 		return -ENOMEM;
 	if ((runtime->dma_area = snd_malloc_pages_fallback(MAX_BUFFER_SIZE, GFP_KERNEL, &runtime->dma_bytes)) == NULL) {
-		snd_magic_kfree(dpcm);
+		kfree(dpcm);
 		return -ENOMEM;
 	}
 	init_timer(&dpcm->timer);
@@ -369,7 +369,7 @@ static int snd_card_dummy_playback_open(
 	if (substream->pcm->device & 2)
 		runtime->hw.info &= ~(SNDRV_PCM_INFO_MMAP|SNDRV_PCM_INFO_MMAP_VALID);
 	if ((err = add_playback_constraints(runtime)) < 0) {
-		snd_magic_kfree(dpcm);
+		kfree(dpcm);
 		return err;
 	}
 
@@ -382,11 +382,11 @@ static int snd_card_dummy_capture_open(s
 	snd_card_dummy_pcm_t *dpcm;
 	int err;
 
-	dpcm = snd_magic_kcalloc(snd_card_dummy_pcm_t, 0, GFP_KERNEL);
+	dpcm = kcalloc(sizeof(*dpcm), GFP_KERNEL);
 	if (dpcm == NULL)
 		return -ENOMEM;
 	if ((runtime->dma_area = snd_malloc_pages_fallback(MAX_BUFFER_SIZE, GFP_KERNEL, &runtime->dma_bytes)) == NULL) {
-		snd_magic_kfree(dpcm);
+		kfree(dpcm);
 		return -ENOMEM;
 	}
 	memset(runtime->dma_area, 0, runtime->dma_bytes);
@@ -405,7 +405,7 @@ static int snd_card_dummy_capture_open(s
 	if (substream->pcm->device & 2)
 		runtime->hw.info &= ~(SNDRV_PCM_INFO_MMAP|SNDRV_PCM_INFO_MMAP_VALID);
 	if ((err = add_capture_constraints(runtime)) < 0) {
-		snd_magic_kfree(dpcm);
+		kfree(dpcm);
 		return err;
 	}
 
diff -X dontdiff -purN linux-2.6.6/sound/drivers/mpu401/mpu401_uart.c alsa-2.6.6/sound/drivers/mpu401/mpu401_uart.c
--- linux-2.6.6/sound/drivers/mpu401/mpu401_uart.c	2004-06-08 23:57:25.198615360 +0300
+++ alsa-2.6.6/sound/drivers/mpu401/mpu401_uart.c	2004-06-05 21:10:41.000000000 +0300
@@ -448,7 +448,7 @@ static void snd_mpu401_uart_free(snd_raw
 		release_resource(mpu->res);
 		kfree_nocheck(mpu->res);
 	}
-	snd_magic_kfree(mpu);
+	kfree(mpu);
 }
 
 /**
@@ -484,7 +484,7 @@ int snd_mpu401_uart_new(snd_card_t * car
 		*rrawmidi = NULL;
 	if ((err = snd_rawmidi_new(card, "MPU-401U", device, 1, 1, &rmidi)) < 0)
 		return err;
-	mpu = snd_magic_kcalloc(mpu401_t, 0, GFP_KERNEL);
+	mpu = kcalloc(sizeof(*mpu), GFP_KERNEL);
 	if (mpu == NULL) {
 		snd_device_free(card, rmidi);
 		return -ENOMEM;
diff -X dontdiff -purN linux-2.6.6/sound/drivers/mtpav.c alsa-2.6.6/sound/drivers/mtpav.c
--- linux-2.6.6/sound/drivers/mtpav.c	2004-06-08 23:57:25.259606088 +0300
+++ alsa-2.6.6/sound/drivers/mtpav.c	2004-06-05 21:10:17.000000000 +0300
@@ -695,7 +695,7 @@ static int snd_mtpav_get_RAWMIDI(mtpav_t
 
 static mtpav_t *new_mtpav(void)
 {
-	mtpav_t *ncrd = (mtpav_t *) snd_magic_kcalloc(mtpav_t, 0, GFP_KERNEL);
+	mtpav_t *ncrd = kcalloc(sizeof(*ncrd), GFP_KERNEL);
 	if (ncrd != NULL) {
 		spin_lock_init(&ncrd->spinlock);
 
@@ -728,7 +728,7 @@ static void free_mtpav(mtpav_t * crd)
 		release_resource(crd->res_port);
 		kfree_nocheck(crd->res_port);
 	}
-	snd_magic_kfree(crd);
+	kfree(crd);
 }
 
 /*
diff -X dontdiff -purN linux-2.6.6/sound/drivers/opl3/opl3_lib.c alsa-2.6.6/sound/drivers/opl3/opl3_lib.c
--- linux-2.6.6/sound/drivers/opl3/opl3_lib.c	2004-06-08 23:57:24.904660048 +0300
+++ alsa-2.6.6/sound/drivers/opl3/opl3_lib.c	2004-06-05 21:12:20.000000000 +0300
@@ -354,7 +354,7 @@ static int snd_opl3_free(opl3_t *opl3)
 		release_resource(opl3->res_r_port);
 		kfree_nocheck(opl3->res_r_port);
 	}
-	snd_magic_kfree(opl3);
+	kfree(opl3);
 	return 0;
 }
 
@@ -379,7 +379,7 @@ int snd_opl3_create(snd_card_t * card,
 
 	*ropl3 = NULL;
 
-	opl3 = snd_magic_kcalloc(opl3_t, 0, GFP_KERNEL);
+	opl3 = kcalloc(sizeof(*opl3), GFP_KERNEL);
 	if (opl3 == NULL)
 		return -ENOMEM;
 
diff -X dontdiff -purN linux-2.6.6/sound/drivers/opl3/opl3_oss.c alsa-2.6.6/sound/drivers/opl3/opl3_oss.c
--- linux-2.6.6/sound/drivers/opl3/opl3_oss.c	2004-06-08 23:57:24.888662480 +0300
+++ alsa-2.6.6/sound/drivers/opl3/opl3_oss.c	2004-06-05 20:41:33.000000000 +0300
@@ -241,7 +241,7 @@ static int snd_opl3_load_patch_seq_oss(s
 		}
 
 		size = sizeof(*put) + sizeof(fm_xinstrument_t);
-		put = (snd_seq_instr_header_t *)snd_kcalloc(size, GFP_KERNEL);
+		put = kcalloc(size, GFP_KERNEL);
 		if (put == NULL)
 			return -ENOMEM;
 		/* build header */
diff -X dontdiff -purN linux-2.6.6/sound/drivers/opl4/opl4_lib.c alsa-2.6.6/sound/drivers/opl4/opl4_lib.c
--- linux-2.6.6/sound/drivers/opl4/opl4_lib.c	2004-06-08 23:57:25.072634512 +0300
+++ alsa-2.6.6/sound/drivers/opl4/opl4_lib.c	2004-06-05 21:10:55.000000000 +0300
@@ -172,7 +172,7 @@ static void snd_opl4_free(opl4_t *opl4)
 		release_resource(opl4->res_pcm_port);
 		kfree_nocheck(opl4->res_pcm_port);
 	}
-	snd_magic_kfree(opl4);
+	kfree(opl4);
 }
 
 static int snd_opl4_dev_free(snd_device_t *device)
@@ -199,7 +199,7 @@ int snd_opl4_create(snd_card_t *card,
 	if (ropl4)
 		*ropl4 = NULL;
 
-	opl4 = snd_magic_kcalloc(opl4_t, 0, GFP_KERNEL);
+	opl4 = kcalloc(sizeof(*opl4), GFP_KERNEL);
 	if (!opl4)
 		return -ENOMEM;
 
diff -X dontdiff -purN linux-2.6.6/sound/drivers/serial-u16550.c alsa-2.6.6/sound/drivers/serial-u16550.c
--- linux-2.6.6/sound/drivers/serial-u16550.c	2004-06-08 23:57:25.027641352 +0300
+++ alsa-2.6.6/sound/drivers/serial-u16550.c	2004-06-05 21:11:10.000000000 +0300
@@ -764,7 +764,7 @@ static int snd_uart16550_free(snd_uart16
 		release_resource(uart->res_base);
 		kfree_nocheck(uart->res_base);
 	}
-	snd_magic_kfree(uart);
+	kfree(uart);
 	return 0;
 };
 
@@ -790,7 +790,7 @@ static int __init snd_uart16550_create(s
 	int err;
 
 
-	if ((uart = snd_magic_kcalloc(snd_uart16550_t, 0, GFP_KERNEL)) == NULL)
+	if ((uart = kcalloc(sizeof(*uart), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
 	uart->adaptor = adaptor;
 	uart->card = card;
diff -X dontdiff -purN linux-2.6.6/sound/drivers/vx/vx_core.c alsa-2.6.6/sound/drivers/vx/vx_core.c
--- linux-2.6.6/sound/drivers/vx/vx_core.c	2004-06-08 23:57:25.002645152 +0300
+++ alsa-2.6.6/sound/drivers/vx/vx_core.c	2004-06-05 21:12:07.000000000 +0300
@@ -731,7 +731,7 @@ vx_core_t *snd_vx_create(snd_card_t *car
 
 	snd_assert(card && hw && ops, return NULL);
 
-	chip = snd_magic_kcalloc(vx_core_t, extra_size, GFP_KERNEL);
+	chip = kcalloc(sizeof(chip) + extra_size, GFP_KERNEL);
 	if (! chip) {
 		snd_printk(KERN_ERR "vx_core: no memory\n");
 		return NULL;
diff -X dontdiff -purN linux-2.6.6/sound/drivers/vx/vx_pcm.c alsa-2.6.6/sound/drivers/vx/vx_pcm.c
--- linux-2.6.6/sound/drivers/vx/vx_pcm.c	2004-06-08 23:57:24.957651992 +0300
+++ alsa-2.6.6/sound/drivers/vx/vx_pcm.c	2004-06-05 21:11:29.000000000 +0300
@@ -480,7 +480,7 @@ static int vx_alloc_pipe(vx_core_t *chip
 		return err;
 
 	/* initialize the pipe record */
-	pipe = snd_magic_kcalloc(vx_pipe_t, 0, GFP_KERNEL);
+	pipe = kcalloc(sizeof(*pipe), GFP_KERNEL);
 	if (! pipe) {
 		/* release the pipe */
 		vx_init_rmh(&rmh, CMD_FREE_PIPE);
@@ -514,7 +514,7 @@ static int vx_free_pipe(vx_core_t *chip,
 	vx_set_pipe_cmd_params(&rmh, pipe->is_capture, pipe->number, 0);
 	vx_send_msg(chip, &rmh);
 
-	snd_magic_kfree(pipe);
+	kfree(pipe);
 	return 0;
 }
 
