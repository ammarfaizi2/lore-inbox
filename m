Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757549AbWKXLPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757549AbWKXLPb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 06:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757687AbWKXLPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 06:15:31 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32403 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1757686AbWKXLP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 06:15:29 -0500
Date: Fri, 24 Nov 2006 12:14:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: tiwai@suse.de, Tony Lindgren <tony@atomide.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>,
       linux-omap <linux-omap-open-source@linux.omap.com>
Subject: sx1 mixer support
Message-ID: <20061124111445.GA5940@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I think this should go in through omap tree, because sx1 support in
mainline is nonexistent for now, but...)

From: Vladimir Ananiev <vovan888@gmail.com>

Support mixer on Siemens SX1. Supporting mixer is quite important,
because it allows doing voice calls, and SX1 is a telephone after all.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index 8f34673..8c035b0 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -63,6 +63,17 @@ config SND_OMAP_TSC2101
  	  To compile this driver as a module, choose M here: the module
  	  will be called snd-omap-tsc2101.
 
+config SND_SX1
+ 	tristate "Siemens SX1 Egold alsa driver"
+ 	depends on ARCH_OMAP && SND
+ 	select SND_PCM
+	select OMAP_MCBSP
+ 	help
+ 	  Say Y here if you have a OMAP310 based Siemens SX1.
+ 
+ 	  To compile this driver as a module, choose M here: the module
+ 	  will be called snd-omap-sx1.
+
 config SND_OMAP_TSC2102
  	tristate "OMAP TSC2102 alsa driver"
  	depends on ARCH_OMAP && SND
diff --git a/sound/arm/omap/Makefile b/sound/arm/omap/Makefile
index 64e341f..c6bebac 100644
--- a/sound/arm/omap/Makefile
+++ b/sound/arm/omap/Makefile
@@ -10,3 +10,6 @@ snd-omap-alsa-tsc2101-objs := omap-alsa.
 
 obj-$(CONFIG_SND_OMAP_TSC2102) += snd-omap-alsa-tsc2102.o
 snd-omap-alsa-tsc2102-objs := omap-alsa.o omap-alsa-dma.o omap-alsa-tsc2102.o omap-alsa-tsc2102-mixer.o
+
+obj-$(CONFIG_SND_SX1) += snd-omap-alsa-sx1.o
+snd-omap-alsa-sx1-objs := omap-alsa.o omap-alsa-dma.o omap-alsa-sx1.o omap-alsa-sx1-mixer.o
diff --git a/sound/arm/omap/omap-alsa-sx1-mixer.c b/sound/arm/omap/omap-alsa-sx1-mixer.c
new file mode 100644
index 0000000..b036b3b
--- /dev/null
+++ b/sound/arm/omap/omap-alsa-sx1-mixer.c
@@ -0,0 +1,444 @@
+/*
+ * sound/arm/omap/omap-alsa-sx1-mixer.c
+ *
+ * Alsa codec Driver for Siemens SX1 board.
+ * based on omap-alsa-tsc2101-mixer.c
+ *
+ *  Copyright (C) 2006 Vladimir Ananiev (vovan888 at gmail com)
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include "omap-alsa-sx1.h"
+#include "omap-alsa-sx1-mixer.h"
+
+#include <linux/types.h>
+#include <sound/initval.h>
+#include <sound/control.h>
+
+//#define M_DPRINTK(ARGS...)  printk(KERN_INFO "<%s>: ",__FUNCTION__);printk(ARGS)
+#define M_DPRINTK(ARGS...)  		/* nop */
+
+static int current_playback_target	= PLAYBACK_TARGET_LOUDSPEAKER;
+static int current_rec_src 		= REC_SRC_SINGLE_ENDED_MICIN_HED;
+static int current_volume 		= 0;	/* current volume, we cant read it */
+static int current_fm_volume 		= 0;	/* current FM radio volume, we cant read it */
+
+/* 
+ * Select SX1 recording source.
+ */
+static void set_record_source(int val)
+{
+	/* TODO Recording is done on McBSP2 and Mic only */
+	current_rec_src	= val;
+}
+
+int set_mixer_volume(int mixer_vol)
+{
+	/* FIXME: Alsa has mixer_vol in 0-100 range, while SX1 needs 0-9 range */
+
+	if ((mixer_vol < 0) || (mixer_vol > 9)) {
+		printk(KERN_ERR "Trying a bad mixer volume (%d)!\n", mixer_vol);
+		return -EPERM;
+	}
+	current_volume = mixer_vol;	/* set current volume, we cant read it */
+
+	return cn_sx1snd_send(DAC_VOLUME_UPDATE, mixer_vol, 0);
+}
+
+void set_loudspeaker_to_playback_target(void)
+{
+	/* TODO */
+	cn_sx1snd_send(DAC_SETAUDIODEVICE, SX1_DEVICE_SPEAKER, 0);
+
+	current_playback_target	= PLAYBACK_TARGET_LOUDSPEAKER;
+}
+
+void set_headphone_to_playback_target(void)
+{
+	/* TODO */
+	cn_sx1snd_send(DAC_SETAUDIODEVICE, SX1_DEVICE_HEADPHONE, 0);
+
+	current_playback_target	= PLAYBACK_TARGET_HEADPHONE;
+}
+
+void set_telephone_to_playback_target(void)
+{
+	/* TODO */
+	cn_sx1snd_send(DAC_SETAUDIODEVICE, SX1_DEVICE_PHONE, 0);
+
+	current_playback_target	= PLAYBACK_TARGET_CELLPHONE;
+}
+
+static void set_telephone_to_record_source(void)
+{
+	cn_sx1snd_send(DAC_SETAUDIODEVICE, SX1_DEVICE_PHONE, 0);
+}
+
+void init_playback_targets(void)
+{
+	set_loudspeaker_to_playback_target();
+	set_mixer_volume(DEFAULT_OUTPUT_VOLUME);
+}
+
+/*
+ * Initializes SX1 record source (to mic) and playback target (to loudspeaker)
+ */
+void snd_omap_init_mixer(void)
+{
+	/* Select headset to record source */
+	set_record_source(REC_SRC_SINGLE_ENDED_MICIN_HED);
+	/* Init loudspeaker as a default playback target*/
+	init_playback_targets();
+}
+
+/* ---------------------------------------------------------------------------------------- */
+static int __pcm_playback_target_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	static char *texts[PLAYBACK_TARGET_COUNT] = {
+        	"Loudspeaker", "Headphone", "Cellphone"
+	};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = PLAYBACK_TARGET_COUNT;
+	if (uinfo->value.enumerated.item > PLAYBACK_TARGET_COUNT - 1) {
+        	uinfo->value.enumerated.item = PLAYBACK_TARGET_COUNT - 1;
+	}
+	strcpy(uinfo->value.enumerated.name, 
+	       texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int __pcm_playback_target_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ucontrol->value.integer.value[0] = current_playback_target;
+	return 0;
+}
+
+static int __pcm_playback_target_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	int ret_val = 0;
+	int cur_val = ucontrol->value.integer.value[0];
+
+	if ((cur_val >= 0) &&
+	    (cur_val < PLAYBACK_TARGET_COUNT) &&
+	    (cur_val != current_playback_target)) {
+		if (cur_val == PLAYBACK_TARGET_LOUDSPEAKER) {
+			set_record_source(REC_SRC_SINGLE_ENDED_MICIN_HED);
+			set_loudspeaker_to_playback_target();
+ 		}
+		else if (cur_val == PLAYBACK_TARGET_HEADPHONE) {
+			set_record_source(REC_SRC_SINGLE_ENDED_MICIN_HND);
+ 			set_headphone_to_playback_target();
+ 		}
+		else if (cur_val == PLAYBACK_TARGET_CELLPHONE) {
+			set_telephone_to_record_source();
+			set_telephone_to_playback_target();
+		}
+		ret_val	= 1;
+	}
+	return ret_val;
+}
+
+/*--------------------------------------------------------------------------------------------*/
+static int __pcm_playback_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	uinfo->type			= SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count			= 1;
+	uinfo->value.integer.min	= 0;
+	uinfo->value.integer.max	= 9;
+	return 0;
+}
+
+/*
+ * Alsa mixer interface function for getting the volume read from the SX1 in a
+ * 0-100 alsa mixer format.
+ */
+static int __pcm_playback_volume_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ucontrol->value.integer.value[0] = current_volume;
+	return 0;
+}
+
+static int __pcm_playback_volume_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	return set_mixer_volume(ucontrol->value.integer.value[0]);
+}
+
+static int __pcm_playback_switch_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	uinfo->type			= SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count			= 1;
+	uinfo->value.integer.min	= 0;
+	uinfo->value.integer.max	= 1;
+	return 0;
+}
+
+static int __pcm_playback_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ucontrol->value.integer.value[0] = 1;
+	return 0;
+}
+
+static int __pcm_playback_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	return 0;
+}
+
+/* -------------------------------------------------------------------------------------------- */
+
+static int __headset_playback_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	uinfo->type			= SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count			= 1;
+	uinfo->value.integer.min	= 0;
+	uinfo->value.integer.max	= 9;
+	return 0;
+}
+
+static int __headset_playback_volume_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ucontrol->value.integer.value[0]	= current_volume;
+	return 0;
+}
+
+static int __headset_playback_volume_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	return set_mixer_volume(ucontrol->value.integer.value[0]);
+}
+
+static int __headset_playback_switch_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	uinfo->type 			= SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count			= 1;
+	uinfo->value.integer.min	= 0;
+	uinfo->value.integer.max	= 1;
+	return 0;
+}
+
+static int __headset_playback_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ucontrol->value.integer.value[0] = 1;
+	return 0;
+}
+
+static int __headset_playback_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	/* mute/unmute headset */
+#if 0
+	return adc_pga_unmute_control(ucontrol->value.integer.value[0],
+				TSC2101_HEADSET_GAIN_CTRL,
+				15);
+#endif
+	return 0;
+}
+/* -------------------------------------------------------------------------------------------- */
+static int __fmradio_playback_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	uinfo->type			= SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count			= 1;
+	uinfo->value.integer.min	= 0;
+	uinfo->value.integer.max	= 9;
+	return 0;
+}
+
+static int __fmradio_playback_volume_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ucontrol->value.integer.value[0] = current_fm_volume;
+	return 0;
+}
+
+static int __fmradio_playback_volume_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	current_fm_volume = ucontrol->value.integer.value[0];
+	cn_sx1snd_send(DAC_FMRADIO_OPEN, current_fm_volume, 0);
+	return 0;
+}
+
+static int __fmradio_playback_switch_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	uinfo->type 			= SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count			= 1;
+	uinfo->value.integer.min	= 0;
+	uinfo->value.integer.max	= 1;
+	return 0;
+}
+
+static int __fmradio_playback_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ucontrol->value.integer.value[0] = 1;
+	return 0;
+}
+
+static int __fmradio_playback_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	/* mute/unmute FM radio */
+	if (ucontrol->value.integer.value[0])
+		cn_sx1snd_send(DAC_FMRADIO_OPEN, current_fm_volume, 0);
+	else
+		cn_sx1snd_send(DAC_FMRADIO_CLOSE, 0, 0);
+
+	return 0;
+}
+/* -------------------------------------------------------------------------------------------- */
+static int __cellphone_input_switch_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	uinfo->type 			= SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count			= 1;
+	uinfo->value.integer.min	= 0;
+	uinfo->value.integer.max	= 1;
+	return 0;
+}
+
+static int __cellphone_input_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ucontrol->value.integer.value[0] = 1;
+	return 0;
+}
+
+static int __cellphone_input_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+#if 0
+	return adc_pga_unmute_control(ucontrol->value.integer.value[0],
+				TSC2101_BUZZER_GAIN_CTRL, 15);
+#endif
+	return 0;
+}
+/* -------------------------------------------------------------------------------------------- */
+
+static int __buzzer_input_switch_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	uinfo->type 			= SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count			= 1;
+	uinfo->value.integer.min	= 0;
+	uinfo->value.integer.max	= 1;
+	return 0;
+}
+
+static int __buzzer_input_switch_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	ucontrol->value.integer.value[0] = 1;
+	return 0;
+}
+
+static int __buzzer_input_switch_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+#if 0
+	return adc_pga_unmute_control(ucontrol->value.integer.value[0],
+				TSC2101_BUZZER_GAIN_CTRL, 6);
+#endif
+	return 0;
+}
+/*--------------------------------------------------------------------------------------------*/
+
+static snd_kcontrol_new_t egold_control[] __devinitdata = {
+	{
+		.name  = "Playback Playback Route",
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index = 0,
+		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info  = __pcm_playback_target_info,
+		.get   = __pcm_playback_target_get,
+		.put   = __pcm_playback_target_put,
+	}, {
+		.name  = "Master Playback Volume",
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index = 0,
+		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info  = __pcm_playback_volume_info,
+		.get   = __pcm_playback_volume_get,
+		.put   = __pcm_playback_volume_put,
+	}, {
+		.name  = "Master Playback Switch",
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index = 0,
+		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info  = __pcm_playback_switch_info,
+		.get   = __pcm_playback_switch_get,
+		.put   = __pcm_playback_switch_put,
+	}, {
+		.name  = "Headset Playback Volume",
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index = 1,
+		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info  = __headset_playback_volume_info,
+		.get   = __headset_playback_volume_get,
+		.put   = __headset_playback_volume_put,
+	}, {
+		.name  = "Headset Playback Switch",
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index = 1,
+		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info  = __headset_playback_switch_info,
+		.get   = __headset_playback_switch_get,
+		.put   = __headset_playback_switch_put,
+	}, {
+		.name  = "FM Playback Volume",
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index = 2,
+		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info  = __fmradio_playback_volume_info,
+		.get   = __fmradio_playback_volume_get,
+		.put   = __fmradio_playback_volume_put,
+	}, {
+		.name  = "FM Playback Switch",
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index = 2,
+		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info  = __fmradio_playback_switch_info,
+		.get   = __fmradio_playback_switch_get,
+		.put   = __fmradio_playback_switch_put,
+	}, {
+		.name  = "Cellphone Input Switch",
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index = 0,
+		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info  = __cellphone_input_switch_info,
+		.get   = __cellphone_input_switch_get,
+		.put   = __cellphone_input_switch_put,
+	}, {
+		.name  = "Buzzer Input Switch",
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.index = 0,
+		.access= SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info  = __buzzer_input_switch_info,
+		.get   = __buzzer_input_switch_get,
+		.put   = __buzzer_input_switch_put,
+	}
+};
+
+#ifdef CONFIG_PM
+void snd_omap_suspend_mixer(void)
+{
+}
+
+void snd_omap_resume_mixer(void)
+{
+	snd_omap_init_mixer();
+}
+#endif
+
+int snd_omap_mixer(struct snd_card_omap_codec *egold)
+{
+	int i = 0;
+	int err = 0;
+
+	if (!egold)
+		return -EINVAL;
+
+	for (i=0; i < ARRAY_SIZE(egold_control); i++) {
+		err = snd_ctl_add(egold->card, snd_ctl_new1(&egold_control[i], egold->card));
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
diff --git a/sound/arm/omap/omap-alsa-sx1-mixer.h b/sound/arm/omap/omap-alsa-sx1-mixer.h
new file mode 100644
index 0000000..02b8b6a
--- /dev/null
+++ b/sound/arm/omap/omap-alsa-sx1-mixer.h
@@ -0,0 +1,45 @@
+/*
+ * sound/arm/omap/omap-alsa-sx1-mixer.h
+ *
+ * Alsa codec Driver for Siemens SX1 board.
+ * based on omap-alsa-tsc2101-mixer.c
+ *
+ *  Copyright (C) 2006 Vladimir Ananiev (vovan888 at gmail com)
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#ifndef OMAPALSATSC2101MIXER_H_
+#define OMAPALSATSC2101MIXER_H_
+
+#include "omap-alsa-dma.h"
+
+#define PLAYBACK_TARGET_COUNT		0x03
+#define PLAYBACK_TARGET_LOUDSPEAKER	0x00
+#define PLAYBACK_TARGET_HEADPHONE	0x01
+#define PLAYBACK_TARGET_CELLPHONE	0x02
+
+/* following are used for register 03h Mixer PGA control bits D7-D5 for selecting record source */
+#define REC_SRC_TARGET_COUNT		0x08
+#define REC_SRC_SINGLE_ENDED_MICIN_HED	0x00	/* oss code referred to MIXER_LINE */
+#define REC_SRC_SINGLE_ENDED_MICIN_HND	0x01	/* oss code referred to MIXER_MIC */
+#define REC_SRC_SINGLE_ENDED_AUX1	0x02
+#define REC_SRC_SINGLE_ENDED_AUX2	0x03
+#define REC_SRC_MICIN_HED_AND_AUX1	0x04
+#define REC_SRC_MICIN_HED_AND_AUX2	0x05
+#define REC_SRC_MICIN_HND_AND_AUX1	0x06
+#define REC_SRC_MICIN_HND_AND_AUX2	0x07
+
+#define DEFAULT_OUTPUT_VOLUME		5	/* default output volume to dac dgc */
+#define DEFAULT_INPUT_VOLUME		2	/* default record volume */
+
+#endif
diff --git a/sound/arm/omap/omap-alsa-sx1.c b/sound/arm/omap/omap-alsa-sx1.c
new file mode 100644
index 0000000..64c09dc
--- /dev/null
+++ b/sound/arm/omap/omap-alsa-sx1.c
@@ -0,0 +1,281 @@
+/*
+ * arch/arm/mach-omap1/omap-alsa-sx1.c
+ *
+ * Alsa codec Driver for Siemens SX1 board.
+ * based on omap-alsa-tsc2101.c	and cn_test.c example by Evgeniy Polyakov
+ *
+ * Copyright (C) 2006 Vladimir Ananiev (vovan888 at gmail com)
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/delay.h>
+#include <linux/soundcard.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <asm/io.h>
+#include <asm/arch/mcbsp.h>
+
+#include <linux/slab.h>
+#include <linux/pm.h>
+#include <asm/mach-types.h>
+#include <asm/arch/dma.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/gpio.h>
+
+#include <asm/arch/omap-alsa.h>
+#include "omap-alsa-sx1.h"
+
+#include <linux/connector.h>
+
+/* Connector implementation */
+static struct cb_id cn_sx1snd_id = { CN_IDX_SX1SND, CN_VAL_SX1SND };
+static char cn_sx1snd_name[] = "cn_sx1snd";
+
+void cn_sx1snd_callback(void *data)
+{
+    struct cn_msg *msg = (struct cn_msg *)data;
+
+    printk("%s: %lu: idx=%x, val=%x, seq=%u, ack=%u, len=%d: %s.\n",
+           __func__, jiffies, msg->id.idx, msg->id.val,
+           msg->seq, msg->ack, msg->len, (char *)msg->data);
+}
+
+/* Send IPC message to sound server */
+extern int cn_sx1snd_send(unsigned int cmd, unsigned int arg1, unsigned int arg2)
+{
+	struct cn_msg *m;
+	unsigned short data[3];
+	int err;
+
+	m = kzalloc(sizeof(*m) + sizeof(data), GFP_ATOMIC);
+	if (!m)
+		return -1; 
+
+	memcpy(&m->id, &cn_sx1snd_id, sizeof(m->id));
+	m->seq = 1;
+	m->len = sizeof(data);
+
+	data[0] = (unsigned short)cmd;
+	data[1] = (unsigned short)arg1;
+	data[2] = (unsigned short)arg2;
+
+	memcpy(m + 1, data, m->len);
+
+	err = cn_netlink_send(m, CN_IDX_SX1SND, gfp_any());
+	snd_printd("sent= %02X %02X %02X, err=%d\n", cmd,arg1,arg2,err);
+	kfree(m);
+
+	if (err == -ESRCH)
+		return -1;	/* there are no listeners on socket */
+	return 0;
+}
+
+/* Hardware capabilities
+ *
+ * DAC USB-mode sampling rates (MCLK = 12 MHz)
+ * The rates and rate_reg_into MUST be in the same order
+ */
+static unsigned int rates[] = {
+	 8000, 11025, 12000,
+	 16000, 22050, 24000,
+	 32000, 44100, 48000,
+};
+
+static snd_pcm_hw_constraint_list_t egold_hw_constraints_rates = {
+	.count = ARRAY_SIZE(rates),
+	.list = rates,
+	.mask = 0,
+};
+
+static snd_pcm_hardware_t egold_snd_omap_alsa_playback = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
+ 	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
+	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |
+		  SNDRV_PCM_RATE_16000 |
+		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
+		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+		  SNDRV_PCM_RATE_KNOT),
+	.rate_min = 8000,
+	.rate_max = 48000,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = 128 * 1024,
+	.period_bytes_min = 32,
+	.period_bytes_max = 8 * 1024,
+	.periods_min = 16,
+	.periods_max = 255,
+	.fifo_size = 0,
+};
+
+static snd_pcm_hardware_t egold_snd_omap_alsa_capture = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID),
+	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
+	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |
+		  SNDRV_PCM_RATE_16000 |
+		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
+		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+		  SNDRV_PCM_RATE_KNOT),
+	.rate_min = 8000,
+	.rate_max = 48000,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = 128 * 1024,
+	.period_bytes_min = 32,
+	.period_bytes_max = 8 * 1024,
+	.periods_min = 16,
+	.periods_max = 255,
+	.fifo_size = 0,
+};
+
+static long current_rate = -1; /* current rate in egold format 0..8 */
+/*
+ * ALSA operations according to board file
+ */
+
+/*
+ * Sample rate changing
+ */
+void egold_set_samplerate(long sample_rate)
+{
+	int egold_rate = 0;
+	int clkgdv = 0;
+	u16 srgr1, srgr2;
+
+	/* Set the sample rate */
+#if 0
+	/* fw15: 5005E490 - divs are different !!! */
+	clkgdv	= CODEC_CLOCK / (sample_rate * (DEFAULT_BITPERSAMPLE * 2 - 1));
+#endif
+	switch (sample_rate) {
+		case 8000:	clkgdv = 71; egold_rate = FRQ_8000; break;
+		case 11025:	clkgdv = 51; egold_rate = FRQ_11025; break;
+		case 12000:	clkgdv = 47; egold_rate = FRQ_12000; break;
+		case 16000:	clkgdv = 35; egold_rate = FRQ_16000; break;
+		case 22050:	clkgdv = 25; egold_rate = FRQ_22050; break;
+		case 24000:	clkgdv = 23; egold_rate = FRQ_24000; break;
+		case 32000:	clkgdv = 17; egold_rate = FRQ_32000; break;
+		case 44100:	clkgdv = 12; egold_rate = FRQ_44100; break;
+		case 48000:	clkgdv = 11; egold_rate = FRQ_48000; break;
+	}
+
+	srgr1 = (FWID(DEFAULT_BITPERSAMPLE - 1) | CLKGDV(clkgdv));
+	srgr2 = ((FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1)));
+
+	OMAP_MCBSP_WRITE(OMAP1510_MCBSP1_BASE, SRGR2, srgr2);
+	OMAP_MCBSP_WRITE(OMAP1510_MCBSP1_BASE, SRGR1, srgr1);
+	current_rate = egold_rate;
+	snd_printd("set samplerate=%ld\n", sample_rate);
+
+}
+
+void egold_configure(void)
+{
+}
+
+/*
+ *  Omap MCBSP clock and Power Management configuration
+ *
+ *  Here we have some functions that allows clock to be enabled and
+ *   disabled only when needed. Besides doing clock configuration
+ *   it allows turn on/turn off audio when necessary.
+ */
+
+/*
+ * Do clock framework mclk search
+ */
+void egold_clock_setup(void)
+{
+	omap_request_gpio(OSC_EN);
+	omap_set_gpio_direction(OSC_EN, 0); /* output */
+	snd_printd("\n");
+}
+
+/*
+ * Do some sanity check, set clock rate, starts it and turn codec audio on
+ */
+int egold_clock_on(void)
+{
+	omap_set_gpio_dataout(OSC_EN, 1);
+	egold_set_samplerate(44100); /* TODO */
+	cn_sx1snd_send(DAC_SETAUDIODEVICE, SX1_DEVICE_SPEAKER, 0);
+	cn_sx1snd_send(DAC_OPEN_DEFAULT, current_rate , 4);
+	snd_printd("\n");
+	return 0;
+}
+
+/*
+ * Do some sanity check, turn clock off and then turn codec audio off
+ */
+int egold_clock_off(void)
+{
+	cn_sx1snd_send(DAC_CLOSE, 0 , 0);
+	cn_sx1snd_send(DAC_SETAUDIODEVICE, SX1_DEVICE_PHONE, 0);
+	omap_set_gpio_dataout(OSC_EN, 0);
+	snd_printd("\n");
+	return 0;
+}
+
+int egold_get_default_samplerate(void)
+{
+	snd_printd("\n");
+	return DEFAULT_SAMPLE_RATE;
+}
+
+static int __init snd_omap_alsa_egold_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct omap_alsa_codec_config *codec_cfg;
+
+	codec_cfg = pdev->dev.platform_data;
+	if (!codec_cfg)
+		return -ENODEV;
+
+	codec_cfg->hw_constraints_rates	= &egold_hw_constraints_rates;
+	codec_cfg->snd_omap_alsa_playback  = &egold_snd_omap_alsa_playback;
+	codec_cfg->snd_omap_alsa_capture  = &egold_snd_omap_alsa_capture;
+	codec_cfg->codec_configure_dev	= egold_configure;
+	codec_cfg->codec_set_samplerate	= egold_set_samplerate;
+	codec_cfg->codec_clock_setup	= egold_clock_setup;
+	codec_cfg->codec_clock_on	= egold_clock_on;
+	codec_cfg->codec_clock_off	= egold_clock_off;
+	codec_cfg->get_default_samplerate = egold_get_default_samplerate;
+	ret = snd_omap_alsa_post_probe(pdev, codec_cfg);
+
+	snd_printd("\n");
+	return ret;
+}
+
+static struct platform_driver omap_alsa_driver = {
+	.probe		= snd_omap_alsa_egold_probe,
+	.remove 	= snd_omap_alsa_remove,
+	.suspend	= snd_omap_alsa_suspend,
+	.resume		= snd_omap_alsa_resume,
+	.driver	= {
+		.name =	"omap_alsa_mcbsp",
+	},
+};
+
+static int __init omap_alsa_egold_init(void)
+{
+	int	retval;
+
+	retval = cn_add_callback(&cn_sx1snd_id, cn_sx1snd_name, cn_sx1snd_callback);
+	if(retval)
+		printk(KERN_WARNING "cn_sx1snd failed to register\n");
+	return platform_driver_register(&omap_alsa_driver);
+}
+
+static void __exit omap_alsa_egold_exit(void)
+{
+	cn_del_callback(&cn_sx1snd_id);
+	platform_driver_unregister(&omap_alsa_driver);
+}
+
+module_init(omap_alsa_egold_init);
+module_exit(omap_alsa_egold_exit);
diff --git a/sound/arm/omap/omap-alsa-sx1.h b/sound/arm/omap/omap-alsa-sx1.h
new file mode 100644
index 0000000..34e26fc
--- /dev/null
+++ b/sound/arm/omap/omap-alsa-sx1.h
@@ -0,0 +1,81 @@
+/*
+ * arch/arc/mach-omap1/omap-alsa-sx1.h
+ *
+ * based on omap-alsa-tsc2101.h
+ *
+ * Alsa Driver for Siemens SX1.
+ * Copyright (C) 2006 Vladimir Ananiev (vovan888 at gmail com)
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#ifndef OMAP_ALSA_SX1_H_
+#define OMAP_ALSA_SX1_H_
+
+#include <linux/types.h>
+
+#define NUMBER_SAMPLE_RATES_SUPPORTED	9
+
+/*
+ * AUDIO related MACROS
+ */
+#ifndef DEFAULT_BITPERSAMPLE
+#define DEFAULT_BITPERSAMPLE		16
+#endif
+
+#define DEFAULT_SAMPLE_RATE		44100
+/* fw15: 18356000 */
+#define CODEC_CLOCK 			18359000
+/* McBSP for playing music */
+#define AUDIO_MCBSP        		OMAP_MCBSP1
+/* McBSP for record/play audio from phone and mic */
+#define AUDIO_MCBSP_PCM    		OMAP_MCBSP2
+/* gpio pin for enable/disable clock */
+#define OSC_EN				2
+
+/*
+ * Defines codec specific functions pointers that can be used from the
+ * common omap-alsa base driver for all omap codecs.
+ */
+void egold_configure(void);
+void egold_set_samplerate(long rate);
+void egold_clock_setup(void);
+int egold_clock_on(void);
+int egold_clock_off(void);
+int egold_get_default_samplerate(void);
+
+/* Send IPC message to sound server */
+extern int cn_sx1snd_send(unsigned int cmd, unsigned int arg1, unsigned int arg2);
+/* cmd for IPC_GROUP_DAC */
+#define DAC_VOLUME_UPDATE		0
+#define DAC_SETAUDIODEVICE		1
+#define DAC_OPEN_RING			2
+#define DAC_OPEN_DEFAULT		3
+#define DAC_CLOSE			4
+#define DAC_FMRADIO_OPEN		5
+#define DAC_FMRADIO_CLOSE		6
+#define DAC_PLAYTONE			7
+/* cmd for IPC_GROUP_PCM */
+#define PCM_PLAY			(0+8)
+#define PCM_RECORD			(1+8)
+#define PCM_CLOSE			(2+8)
+
+/* for DAC_SETAUDIODEVICE */
+#define SX1_DEVICE_SPEAKER		0
+#define SX1_DEVICE_HEADPHONE		4
+#define SX1_DEVICE_PHONE		3
+/* frequencies for MdaDacOpenDefaultL,  MdaDacOpenRingL */
+#define FRQ_8000        0
+#define FRQ_11025       1
+#define FRQ_12000       2
+#define FRQ_16000       3
+#define FRQ_22050       4
+#define FRQ_24000       5
+#define FRQ_32000       6
+#define FRQ_44100       7
+#define FRQ_48000       8
+
+#endif

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
