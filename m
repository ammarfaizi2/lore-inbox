Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267921AbUHUVqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267921AbUHUVqh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 17:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267926AbUHUVqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 17:46:36 -0400
Received: from frigate.technologeek.org ([62.4.21.148]:2432 "EHLO
	frigate.technologeek.org") by vger.kernel.org with ESMTP
	id S267921AbUHUVp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 17:45:56 -0400
To: linux-kernel@vger.kernel.org
Cc: tiwai@suse.de, perex@suse.cz
Subject: [PATCH 2.6] [SOUND] Add back beep support to snd-powermac
From: Julien BLACHE <jb@jblache.org>
Date: Sat, 21 Aug 2004 23:45:33 +0200
Message-ID: <87fz6g6u82.fsf@frigate.technologeek.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

The attached patch adds back the beep support to sound/ppc/pmac.c, aka
snd-powermac, and adds a dependency on INPUT in sound/ppc/Kconfig (for
obvious reason, read on :).

The patch is based on the code that used to be present in that file,
and got removed in early april last year. I ported it to the input
event interface based on the code used in dmasound_awacs.c.

Attached patch against Linux 2.6.8.1 vanilla. This patch was already
posted to debian-powerpc and to the sound maintainer roughly 2 months
ago, and has been tested extensively without any problem reported.

Please apply,

JB.

-- 
Julien BLACHE                                   <http://www.jblache.org> 
<jb@jblache.org>                                  GPG KeyID 0xF5D65169


Signed-off-by: Julien BLACHE <jb@jblache.org>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=snd-powermac-beep_2.6.8.1.patch
Content-Description: Add back beep support to snd-powermac

diff -u linux-2.6.8.1/sound/ppc/Kconfig linux-2.6.8.1-BEEP/sound/ppc/Kconfig
--- linux-2.6.8.1/sound/ppc/Kconfig	2004-08-14 12:55:20.000000000 +0200
+++ linux-2.6.8.1-BEEP/sound/ppc/Kconfig	2004-08-21 22:11:46.333321112 +0200
@@ -8,7 +8,7 @@
 
 config SND_POWERMAC
 	tristate "PowerMac (AWACS, DACA, Burgundy, Tumbler, Keywest)"
-	depends on SND && I2C
+	depends on SND && I2C && INPUT
 	select SND_PCM
 
 endmenu
diff -u linux-2.6.8.1/sound/ppc/pmac.c linux-2.6.8.1-BEEP/sound/ppc/pmac.c
--- linux-2.6.8.1/sound/ppc/pmac.c	2004-08-14 12:56:24.000000000 +0200
+++ linux-2.6.8.1-BEEP/sound/ppc/pmac.c	2004-08-21 22:10:44.906659384 +0200
@@ -4,6 +4,10 @@
  * Copyright (c) by Takashi Iwai <tiwai@suse.de>
  * code based on dmasound.c.
  *
+ * 20040609 Julien BLACHE <jb@jblache.org>
+ *  * Added back beep support code
+ *  * Updated to the 2.6 input system, based on dmasound_awacs.c
+ *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
  *   the Free Software Foundation; either version 2 of the License, or
@@ -27,6 +31,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/input.h>
 #include <sound/core.h>
 #include "pmac.h"
 #include <sound/pcm_params.h>
@@ -38,7 +43,6 @@
 
 #define chip_t pmac_t
 
-
 #if defined(CONFIG_PM) && defined(CONFIG_PMAC_PBOOK)
 static int snd_pmac_register_sleep_notifier(pmac_t *chip);
 static int snd_pmac_unregister_sleep_notifier(pmac_t *chip);
@@ -259,6 +263,16 @@
 
 
 /*
+ * stop beep (no spinlock!)
+ */
+static void snd_pmac_beep_stop(pmac_t *chip)
+{
+	snd_pmac_dma_stop(&chip->playback);
+	st_le16(&chip->extra_dma.cmds->command, DBDMA_STOP);
+	snd_pmac_pcm_set_format(chip);
+}
+
+/*
  * PCM trigger/stop
  */
 static int snd_pmac_pcm_trigger(pmac_t *chip, pmac_stream_t *rec,
@@ -673,6 +687,226 @@
 }
 
 
+/*
+ * beep stuff
+ */
+
+/*
+ * Stuff for outputting a beep.  The values range from -327 to +327
+ * so we can multiply by an amplitude in the range 0..100 to get a
+ * signed short value to put in the output buffer.
+ */
+static short beep_wform[256] = {
+	0,	40,	79,	117,	153,	187,	218,	245,
+	269,	288,	304,	316,	323,	327,	327,	324,
+	318,	310,	299,	288,	275,	262,	249,	236,
+	224,	213,	204,	196,	190,	186,	183,	182,
+	182,	183,	186,	189,	192,	196,	200,	203,
+	206,	208,	209,	209,	209,	207,	204,	201,
+	197,	193,	188,	183,	179,	174,	170,	166,
+	163,	161,	160,	159,	159,	160,	161,	162,
+	164,	166,	168,	169,	171,	171,	171,	170,
+	169,	167,	163,	159,	155,	150,	144,	139,
+	133,	128,	122,	117,	113,	110,	107,	105,
+	103,	103,	103,	103,	104,	104,	105,	105,
+	105,	103,	101,	97,	92,	86,	78,	68,
+	58,	45,	32,	18,	3,	-11,	-26,	-41,
+	-55,	-68,	-79,	-88,	-95,	-100,	-102,	-102,
+	-99,	-93,	-85,	-75,	-62,	-48,	-33,	-16,
+	0,	16,	33,	48,	62,	75,	85,	93,
+	99,	102,	102,	100,	95,	88,	79,	68,
+	55,	41,	26,	11,	-3,	-18,	-32,	-45,
+	-58,	-68,	-78,	-86,	-92,	-97,	-101,	-103,
+	-105,	-105,	-105,	-104,	-104,	-103,	-103,	-103,
+	-103,	-105,	-107,	-110,	-113,	-117,	-122,	-128,
+	-133,	-139,	-144,	-150,	-155,	-159,	-163,	-167,
+	-169,	-170,	-171,	-171,	-171,	-169,	-168,	-166,
+	-164,	-162,	-161,	-160,	-159,	-159,	-160,	-161,
+	-163,	-166,	-170,	-174,	-179,	-183,	-188,	-193,
+	-197,	-201,	-204,	-207,	-209,	-209,	-209,	-208,
+	-206,	-203,	-200,	-196,	-192,	-189,	-186,	-183,
+	-182,	-182,	-183,	-186,	-190,	-196,	-204,	-213,
+	-224,	-236,	-249,	-262,	-275,	-288,	-299,	-310,
+	-318,	-324,	-327,	-327,	-323,	-316,	-304,	-288,
+	-269,	-245,	-218,	-187,	-153,	-117,	-79,	-40,
+};
+
+#define BEEP_SRATE	22050	/* 22050 Hz sample rate */
+#define BEEP_BUFLEN	512
+#define BEEP_VOLUME	15	/* 0 - 100 */
+
+static int snd_pmac_beep_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+{
+	pmac_t *chip;
+	pmac_stream_t *rec;
+	pmac_beep_t *beep;
+	unsigned long flags;
+	int beep_speed = 0;
+	int srate;
+	int period, ncycles, nsamples;
+	int i, j, f;
+	short *p;
+
+	chip = (pmac_t *)dev->private;
+	beep = &chip->beep;
+
+	if (beep->buf == NULL)
+		return -1;
+
+	rec = &chip->playback;
+
+	if (chip->playback.running || chip->capture.running) {
+		return -1;
+	}
+
+	if (type != EV_SND)
+		return -1;
+
+	switch (code) {
+	case SND_BELL:
+		if (value)
+			value = 1000;
+		break;
+	case SND_TONE:
+		break;
+	default:
+		return -1;
+	}
+
+	beep_speed = snd_pmac_rate_index(chip, rec, BEEP_SRATE);
+	srate = chip->freq_table[beep_speed];
+
+	spin_lock_irqsave(&chip->reg_lock, flags);
+	if (value <= srate / BEEP_BUFLEN || value > srate / 2) {
+		/* cancel beep playing */
+		snd_pmac_beep_stop(chip);
+		return 0;
+	}
+	spin_unlock_irqrestore(&chip->reg_lock, flags);
+
+	if (value == beep->hz && beep->volume == beep->volume_play) {
+		nsamples = beep->nsamples;
+	} else {
+		period = srate * 256 / value;	/* fixed point */
+		ncycles = BEEP_BUFLEN * 256 / period;
+		nsamples = (period * ncycles) >> 8;
+		f = ncycles * 65536 / nsamples;
+		j = 0;
+		p = beep->buf;
+		for (i = 0; i < nsamples; ++i, p += 2) {
+			p[0] = p[1] = beep_wform[j >> 8] * beep->volume;
+			j = (j + f) & 0xffff;
+		}
+		beep->hz = value;
+		beep->volume_play = beep->volume;
+		beep->nsamples = nsamples;
+	}
+
+	spin_lock_irqsave(&chip->reg_lock, flags);
+
+	snd_pmac_beep_stop(chip);
+
+	st_le16(&chip->extra_dma.cmds->req_count, nsamples * 4);
+	st_le16(&chip->extra_dma.cmds->xfer_status, 0);
+	st_le32(&chip->extra_dma.cmds->cmd_dep, chip->extra_dma.addr);
+	st_le32(&chip->extra_dma.cmds->phy_addr, beep->addr);
+	st_le16(&chip->extra_dma.cmds->command, OUTPUT_MORE + BR_ALWAYS);
+	out_le32(&chip->awacs->control,
+		 (in_le32(&chip->awacs->control) & ~0x1f00)
+		 | (beep_speed << 8));
+	out_le32(&chip->awacs->byteswap, 0);
+	snd_pmac_dma_set_command(rec, &chip->extra_dma);
+	snd_pmac_dma_run(rec, RUN);
+
+	spin_unlock_irqrestore(&chip->reg_lock, flags);
+
+	return 0;
+}
+
+/*
+ * beep volume mixer
+ */
+static int snd_pmac_info_beep(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 100;
+	return 0;
+}
+
+static int snd_pmac_get_beep(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	pmac_t *chip = snd_kcontrol_chip(kcontrol);
+	ucontrol->value.integer.value[0] = chip->beep.volume;
+	return 0;
+}
+
+static int snd_pmac_put_beep(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	pmac_t *chip = snd_kcontrol_chip(kcontrol);
+	int oval;
+	oval = chip->beep.volume;
+	chip->beep.volume = ucontrol->value.integer.value[0];
+	return oval != chip->beep.volume;
+}
+
+static snd_kcontrol_new_t snd_pmac_beep_mixer = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Beep Playback Volume",
+	.index = 0,
+	.info = snd_pmac_info_beep,
+	.get = snd_pmac_get_beep,
+	.put = snd_pmac_put_beep,
+};
+
+static void snd_pmac_beep_free(snd_kcontrol_t *control)
+{
+	pmac_t *chip = snd_magic_cast(pmac_t, _snd_kcontrol_chip(control),);
+	kfree(chip->beep.buf);
+	chip->beep.buf = NULL;
+}
+
+/* Initialize beep stuff */
+int __init snd_pmac_attach_beep(pmac_t *chip)
+{
+	pmac_beep_t *beep;
+	int err;
+
+	beep = &chip->beep;
+	beep->buf = (short *) kmalloc(BEEP_BUFLEN * 4, GFP_KERNEL);
+	if (! beep->buf) {
+		return -ENOMEM;
+	}
+	beep->addr = virt_to_bus(beep->buf);
+	beep->volume = BEEP_VOLUME;
+	beep->control = snd_ctl_new1(&snd_pmac_beep_mixer, chip);
+	if (beep->control == NULL) {
+		return -ENOMEM;
+	}
+	beep->control->private_free = snd_pmac_beep_free;
+	if ((err = snd_ctl_add(chip->card, beep->control)) < 0) {
+		return err;
+	}
+
+	/* hook into the input event interface */
+
+	/* better safe than sorry */
+	memset(&beep->indev, 0, sizeof(struct input_dev));
+	/* set up the input_dev struct */
+	beep->indev.evbit[0] = BIT(EV_SND);
+	beep->indev.sndbit[0] = BIT(SND_BELL) | BIT(SND_TONE);
+	beep->indev.event = snd_pmac_beep_event;
+	beep->indev.name = "snd pmac beeper";
+	beep->indev.phys = chip->node->full_name;
+	beep->indev.id.bustype = BUS_HOST;
+	beep->indev.private = chip; /* set the private pointer to the chip pointer */
+	
+	input_register_device(&beep->indev);
+
+	return 0;
+}
+
 static void snd_pmac_dbdma_reset(pmac_t *chip)
 {
 	out_le32(&chip->playback.dma->control, (RUN|PAUSE|FLUSH|WAKE|DEAD) << 16);
@@ -760,6 +994,9 @@
 {
 	int i;
 
+	/* unregister now from the input layer */
+	input_unregister_device(&chip->beep.indev);
+
 	/* stop sounds */
 	if (chip->initialized) {
 		snd_pmac_dbdma_reset(chip);
diff -u linux-2.6.8.1/sound/ppc/pmac.h linux-2.6.8.1-BEEP/sound/ppc/pmac.h
--- linux-2.6.8.1/sound/ppc/pmac.h	2004-08-14 12:55:35.000000000 +0200
+++ linux-2.6.8.1-BEEP/sound/ppc/pmac.h	2004-08-21 22:10:44.911658624 +0200
@@ -36,7 +36,7 @@
 #endif
 #include <linux/nvram.h>
 #include <linux/tty.h>
-#include <linux/vt_kern.h>
+#include <linux/input.h>
 #include <asm/dbdma.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
@@ -90,6 +90,21 @@
 
 
 /*
+ * beep using pcm
+ */
+struct snd_pmac_beep {
+	int volume;	/* mixer volume: 0-100 */
+	int volume_play;	/* currently playing volume */
+	int hz;
+	int nsamples;
+	short *buf;		/* allocated wave buffer */
+	unsigned long addr;	/* physical address of buffer */
+	snd_kcontrol_t *control;	/* mixer element */
+	struct input_dev indev;         /* input device used for beeping */
+};
+
+
+/*
  */
 
 enum snd_pmac_model {
@@ -146,7 +161,7 @@
 
 	snd_pcm_t *pcm;
 
-	pmac_beep_t *beep;
+	pmac_beep_t beep;
 
 	unsigned int control_mask;	/* control mask */
 
@@ -206,9 +221,4 @@
 	schedule_timeout(((msec) * HZ + 999) / 1000);\
 } while (0)
 
-#ifndef PMAC_SUPPORT_PCM_BEEP
-#define snd_pmac_attach_beep(chip) 0
-#define snd_pmac_beep_stop(chip)  /**/
-#endif
-
 #endif /* __PMAC_H */
diff -u linux-2.6.8.1/sound/ppc/powermac.c linux-2.6.8.1-BEEP/sound/ppc/powermac.c
--- linux-2.6.8.1/sound/ppc/powermac.c	2004-08-14 12:56:24.000000000 +0200
+++ linux-2.6.8.1-BEEP/sound/ppc/powermac.c	2004-08-21 22:10:44.919657408 +0200
@@ -37,9 +37,7 @@
 static int index = SNDRV_DEFAULT_IDX1;		/* Index 0-MAX */
 static char *id = SNDRV_DEFAULT_STR1;		/* ID for this card */
 /* static int enable = 1; */
-#ifdef PMAC_SUPPORT_PCM_BEEP
 static int enable_beep = 1;
-#endif
 
 module_param(index, int, 0444);
 MODULE_PARM_DESC(index, "Index value for " CHIP_NAME " soundchip.");
@@ -50,11 +48,9 @@
 /* module_param(enable, bool, 0444);
    MODULE_PARM_DESC(enable, "Enable this soundchip.");
    MODULE_PARM_SYNTAX(enable, SNDRV_ENABLE_DESC); */
-#ifdef PMAC_SUPPORT_PCM_BEEP
 module_param(enable_beep, bool, 0444);
 MODULE_PARM_DESC(enable_beep, "Enable beep using PCM.");
 MODULE_PARM_SYNTAX(enable_beep, SNDRV_ENABLED "," SNDRV_BOOLEAN_TRUE_DESC);
-#endif
 
 
 /*
@@ -133,10 +129,9 @@
 		goto __error;
 
 	chip->initialized = 1;
-#ifdef PMAC_SUPPORT_PCM_BEEP
+
 	if (enable_beep)
 		snd_pmac_attach_beep(chip);
-#endif
 
 	if ((err = snd_card_register(card)) < 0)
 		goto __error;

--=-=-=--
