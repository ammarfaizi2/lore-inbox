Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262187AbSJAQuF>; Tue, 1 Oct 2002 12:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262182AbSJAQtO>; Tue, 1 Oct 2002 12:49:14 -0400
Received: from gate.perex.cz ([194.212.165.105]:35335 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S262176AbSJAQrP>;
	Tue, 1 Oct 2002 12:47:15 -0400
Date: Tue, 1 Oct 2002 18:48:50 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2nd ALSA update [6/12] - 2002/08/21
Message-ID: <Pine.LNX.4.33.0210011847580.20016-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.649, 2002-10-01 10:34:42+02:00, perex@suse.cz
  ALSA update 2002/08/21 :
    - CS46xx
      - SPDIF input fixes
      - fixed missplaced #ifndef
      - amplifier fix for Game Theater XP
      - refine on the PCM multichannel functionality
    - EMU10K1
      - added the support for Audigy spdif controls
    - PCM midlevel
      - fixed hw_free (wrong state for drivers with no callback
      - fixed sw_params (runtime) lock
    - AC'97 codec
      - fixed spin deadlock
    - CS4281
      - fixed wrong mdelays and allowed scheduling in module_init
    - PPC drivers
      - added the missing inclusion of linux/slab.h
    - USB MIDI driver
      - replaced urb_t -> struct urb


 include/sound/cs46xx_dsp_spos.h     |    1 
 include/sound/emu10k1.h             |    4 +
 include/sound/sndmagic.h            |    7 +
 include/sound/version.h             |    2 
 sound/Config.in                     |    5 +
 sound/core/pcm_native.c             |    6 +
 sound/pci/ac97/ac97_codec.c         |   21 +++--
 sound/pci/cs4281.c                  |   11 +--
 sound/pci/cs46xx/cs46xx_lib.c       |   54 ++++++++++-----
 sound/pci/cs46xx/cs46xx_lib.h       |    4 -
 sound/pci/cs46xx/dsp_spos.c         |  129 ++++++------------------------------
 sound/pci/cs46xx/dsp_spos.h         |    6 -
 sound/pci/cs46xx/dsp_spos_scb_lib.c |  107 +++++++++++++++++++++++++++--
 sound/pci/emu10k1/emufx.c           |   30 +++++++-
 sound/ppc/awacs.c                   |   37 +++++++---
 sound/ppc/burgundy.c                |    8 +-
 sound/ppc/daca.c                    |    1 
 sound/ppc/keywest.c                 |    1 
 sound/ppc/pmac.c                    |   10 +-
 sound/ppc/tumbler.c                 |    1 
 sound/usb/usbmidi.c                 |   10 +-
 21 files changed, 280 insertions(+), 175 deletions(-)


diff -Nru a/include/sound/cs46xx_dsp_spos.h b/include/sound/cs46xx_dsp_spos.h
--- a/include/sound/cs46xx_dsp_spos.h	Tue Oct  1 17:07:40 2002
+++ b/include/sound/cs46xx_dsp_spos.h	Tue Oct  1 17:07:40 2002
@@ -177,6 +177,7 @@
 	/* SPDIF status */
 	int spdif_status_out;
 	int spdif_status_in;
+	u32 spdif_input_volume;
 
 	/* SPDIF input sample rate converter */
 	dsp_scb_descriptor_t * spdif_in_src;
diff -Nru a/include/sound/emu10k1.h b/include/sound/emu10k1.h
--- a/include/sound/emu10k1.h	Tue Oct  1 17:07:40 2002
+++ b/include/sound/emu10k1.h	Tue Oct  1 17:07:40 2002
@@ -1195,8 +1195,12 @@
 #define A_EXTIN_AC97_R		0x01	/* AC'97 capture channel - right */
 #define A_EXTIN_SPDIF_CD_L	0x02	/* digital CD left */
 #define A_EXTIN_SPDIF_CD_R	0x03	/* digital CD left */
+#define A_EXTIN_OPT_SPDIF_L     0x04    /* audigy drive Optical SPDIF - left */
+#define A_EXTIN_OPT_SPDIF_R     0x05    /*                              right */ 
 #define A_EXTIN_LINE2_L		0x08	/* audigy drive line2/mic2 - left */
 #define A_EXTIN_LINE2_R		0x09	/*                           right */
+#define A_EXTIN_RCA_SPDIF_L     0x0a    /* audigy drive RCA SPDIF - left */
+#define A_EXTIN_RCA_SPDIF_R     0x0b    /*                          right */
 #define A_EXTIN_AUX2_L		0x0c	/* audigy drive aux2 - left */
 #define A_EXTIN_AUX2_R		0x0d	/*                   - right */
 
diff -Nru a/include/sound/sndmagic.h b/include/sound/sndmagic.h
--- a/include/sound/sndmagic.h	Tue Oct  1 17:07:40 2002
+++ b/include/sound/sndmagic.h	Tue Oct  1 17:07:40 2002
@@ -137,6 +137,13 @@
 #define sa11xx_uda1341_t_magic			0xa15a3b00
 #define uda1341_t_magic                         0xa15a3c00
 #define l3_client_t_magic                       0xa15a3d00
+#define snd_usb_audio_t_magic			0xa15a3e01
+#define usb_mixer_elem_info_t_magic		0xa15a3e02
+#define snd_usb_stream_t_magic			0xa15a3e03
+#define usbmidi_t_magic				0xa15a3f01
+#define usbmidi_out_endpoint_t_magic		0xa15a3f02
+#define usbmidi_in_endpoint_t_magic		0xa15a3f03
+
 
 #else
 
diff -Nru a/include/sound/version.h b/include/sound/version.h
--- a/include/sound/version.h	Tue Oct  1 17:07:40 2002
+++ b/include/sound/version.h	Tue Oct  1 17:07:40 2002
@@ -1,3 +1,3 @@
 /* include/version.h.  Generated automatically by configure.  */
 #define CONFIG_SND_VERSION "0.9.0rc3"
-#define CONFIG_SND_DATE " (Thu Aug 15 19:10:53 2002 UTC)"
+#define CONFIG_SND_DATE " (Wed Aug 21 14:00:18 2002 UTC)"
diff -Nru a/sound/Config.in b/sound/Config.in
--- a/sound/Config.in	Tue Oct  1 17:07:40 2002
+++ b/sound/Config.in	Tue Oct  1 17:07:40 2002
@@ -31,6 +31,11 @@
 if [ "$CONFIG_SND" != "n" -a "$CONFIG_ARM" = "y" ]; then
   source sound/arm/Config.in
 fi
+# the following will depenend on the order of config.
+# here assuming USB is defined before ALSA
+if [ "$CONFIG_SND" != "n" -a "$CONFIG_USB" != "n" ]; then
+  source sound/usb/Config.in
+fi
 if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC32" = "y" ]; then
   source sound/sparc/Config.in
 fi
diff -Nru a/sound/core/pcm_native.c b/sound/core/pcm_native.c
--- a/sound/core/pcm_native.c	Tue Oct  1 17:07:40 2002
+++ b/sound/core/pcm_native.c	Tue Oct  1 17:07:40 2002
@@ -438,8 +438,10 @@
 	}
 	if (atomic_read(&runtime->mmap_count))
 		return -EBADFD;
-	if (substream->ops->hw_free == NULL)
+	if (substream->ops->hw_free == NULL) {
+		runtime->status->state = SNDRV_PCM_STATE_OPEN;
 		return 0;
+	}
 	result = substream->ops->hw_free(substream);
 	runtime->status->state = SNDRV_PCM_STATE_OPEN;
 	return result;
@@ -463,6 +465,7 @@
 		return -EINVAL;
 	if (params->silence_threshold + params->silence_size > runtime->buffer_size)
 		return -EINVAL;
+	spin_lock_irq(&runtime->lock);
 	runtime->tstamp_mode = params->tstamp_mode;
 	runtime->sleep_min = params->sleep_min;
 	runtime->period_step = params->period_step;
@@ -473,7 +476,6 @@
 	runtime->silence_size = params->silence_size;
 	runtime->xfer_align = params->xfer_align;
         params->boundary = runtime->boundary;
-	spin_lock_irq(&runtime->lock);
 	if (snd_pcm_running(substream)) {
 		if (runtime->sleep_min)
 			snd_pcm_tick_prepare(substream);
diff -Nru a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
--- a/sound/pci/ac97/ac97_codec.c	Tue Oct  1 17:07:40 2002
+++ b/sound/pci/ac97/ac97_codec.c	Tue Oct  1 17:07:40 2002
@@ -276,14 +276,13 @@
 	return change;
 }
 
-int snd_ac97_update_bits(ac97_t *ac97, unsigned short reg, unsigned short mask, unsigned short value)
+int snd_ac97_update_bits_nolock(ac97_t *ac97, unsigned short reg, unsigned short mask, unsigned short value)
 {
 	int change;
 	unsigned short old, new;
 
 	if (!snd_ac97_valid_reg(ac97, reg))
 		return -EINVAL;
-	spin_lock(&ac97->reg_lock);
 	old = ac97->regs[reg];
 	new = (old & ~mask) | value;
 	change = old != new;
@@ -291,6 +290,14 @@
 		ac97->write(ac97, reg, new);
 		ac97->regs[reg] = new;
 	}
+	return change;
+}
+
+int snd_ac97_update_bits(ac97_t *ac97, unsigned short reg, unsigned short mask, unsigned short value)
+{
+	int change;
+	spin_lock(&ac97->reg_lock);
+	change = snd_ac97_update_bits_nolock(ac97, reg, mask, value);
 	spin_unlock(&ac97->reg_lock);
 	return change;
 }
@@ -740,16 +747,16 @@
 		case 2: x = 0; break;  // 48.0
 		default: x = 0; break; // illegal.
 		}
-		change = snd_ac97_update_bits(ac97, AC97_CSR_SPDIF, 0x3fff, ((val & 0xcfff) | (x << 12)));
+		change = snd_ac97_update_bits_nolock(ac97, AC97_CSR_SPDIF, 0x3fff, ((val & 0xcfff) | (x << 12)));
 	} else if (ac97->flags & AC97_CX_SPDIF) {
 		int v;
 		v = ucontrol->value.iec958.status[0] & (IEC958_AES0_CON_EMPHASIS_5015|IEC958_AES0_CON_NOT_COPYRIGHT) ? 0 : AC97_CXR_COPYRGT;
 		v |= ucontrol->value.iec958.status[0] & IEC958_AES0_NONAUDIO ? AC97_CXR_SPDIF_AC3 : AC97_CXR_SPDIF_PCM;
-		change = snd_ac97_update_bits(ac97, AC97_CXR_AUDIO_MISC, 
-					      AC97_CXR_SPDIF_MASK | AC97_CXR_COPYRGT,
-					      v);
+		change = snd_ac97_update_bits_nolock(ac97, AC97_CXR_AUDIO_MISC, 
+						     AC97_CXR_SPDIF_MASK | AC97_CXR_COPYRGT,
+						     v);
 	} else {
-		change = snd_ac97_update_bits(ac97, AC97_SPDIF, 0x3fff, val);
+		change = snd_ac97_update_bits_nolock(ac97, AC97_SPDIF, 0x3fff, val);
 	}
 
 	change |= ac97->spdif_status != new;
diff -Nru a/sound/pci/cs4281.c b/sound/pci/cs4281.c
--- a/sound/pci/cs4281.c	Tue Oct  1 17:07:40 2002
+++ b/sound/pci/cs4281.c	Tue Oct  1 17:07:40 2002
@@ -549,8 +549,11 @@
 				set_current_state(TASK_UNINTERRUPTIBLE);
 				schedule_timeout(1);
 			} while (end_time - (signed long)jiffies >= 0);
-		} else
-			mdelay(delay);
+		} else {
+			delay += 999;
+			delay /= 1000;
+			mdelay(delay > 0 ? delay : 1);
+		}
 	} else {
 		udelay(delay);
 	}
@@ -562,7 +565,7 @@
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(1);
 	} else
-		mdelay(1999 / HZ);
+		mdelay(10);
 }
 
 static inline void snd_cs4281_pokeBA0(cs4281_t *chip, unsigned long offset, unsigned int val)
@@ -1502,7 +1505,7 @@
 		return -ENOMEM;
 	}
 	
-	tmp = snd_cs4281_chip_init(chip, 0);
+	tmp = snd_cs4281_chip_init(chip, 1);
 	if (tmp) {
 		snd_cs4281_free(chip);
 		return tmp;
diff -Nru a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
--- a/sound/pci/cs46xx/cs46xx_lib.c	Tue Oct  1 17:07:40 2002
+++ b/sound/pci/cs46xx/cs46xx_lib.c	Tue Oct  1 17:07:40 2002
@@ -6,9 +6,9 @@
  *
  *  KNOWN BUGS:
  *    - Sometimes the SPDIF input DSP tasks get's unsynchronized
- *      and the SPDIF get somewhat "distorcionated". To get around
- *      this problem when it happens, mute and unmute the SPDIF input 
- *      mixer controll.
+ *      and the SPDIF get somewhat "distorcionated", or/and left right channel
+ *      are swapped. To get around this problem when it happens, mute and unmute 
+ *      the SPDIF input mixer controll.
  *    - On the Hercules Game Theater XP the amplifier are sometimes turned
  *      off on inadecuate moments which causes distorcions on sound.
  *
@@ -16,11 +16,19 @@
  *    - Secondary CODEC on some soundcards
  *    - SPDIF input support for other sample rates then 48khz
  *    - Independent PCM channels for rear output
+ *    - Posibility to mix the SPDIF output with analog sources.
  *
  *  NOTE: with CONFIG_SND_CS46XX_NEW_DSP unset uses old DSP image (which
  *        is default configuration), no SPDIF, no secondary codec, no
  *        multi channel PCM.  But known to work.
  *
+ *  FINALLY: A credit to the developers Tom and Jordan 
+ *           at Cirrus for have helping me out with the DSP, however we
+ *           still dont have sufficient documentation and technical
+ *           references to be able to implement all fancy feutures
+ *           supported by the cs46xx DPS's. 
+ *           Benny <benny@hostmobility.com>
+ *                
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
  *   the Free Software Foundation; either version 2 of the License, or
@@ -839,6 +847,8 @@
 	char *hwbuf;
 	cs46xx_pcm_t *cpcm = snd_magic_cast(cs46xx_pcm_t, substream->runtime->private_data, return -ENXIO);
 
+	snd_assert(runtime->dma_area, return -EINVAL);
+
 	hwoffb = hwoff << cpcm->shift;
 	bytes = frames << cpcm->shift;
 	hwbuf = runtime->dma_area + hwoffb;
@@ -895,6 +905,8 @@
 			cs46xx_dsp_pcm_link(chip,cpcm->pcm_channel);
 		if (substream->runtime->periods != CS46XX_FRAGS)
 			snd_cs46xx_playback_transfer(substream, 0);
+		/* raise playback volume */
+		snd_cs46xx_poke(chip, (cpcm->pcm_channel->pcm_reader_scb->address + 0xE) << 2, 0x80008000);
 #else
 		if (substream->runtime->periods != CS46XX_FRAGS)
 			snd_cs46xx_playback_transfer(substream, 0);
@@ -1028,7 +1040,7 @@
 	    cpcm->pcm_channel->src_scb->ref_count != 1) {
 		cs46xx_dsp_destroy_pcm_channel (chip,cpcm->pcm_channel);
 
-		if ( (cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel (chip,runtime->rate,cpcm)) == NULL) {
+		if ( (cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel (chip, runtime->rate, cpcm, cpcm->hw_addr)) == NULL) {
 			snd_printk(KERN_ERR "cs46xx: failed to re-create virtual PCM channel\n");
 			return -ENXIO;
 		}
@@ -1073,9 +1085,6 @@
 	cpcm->appl_ptr = 0;
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-	/* playback address */
-	snd_cs46xx_poke(chip, (cpcm->pcm_channel->pcm_reader_scb->address + 2) << 2, cpcm->hw_addr);
-
 	tmp = snd_cs46xx_peek(chip, (cpcm->pcm_channel->pcm_reader_scb->address) << 2);
 	tmp &= ~0x000003ff;
 	tmp |= (4 << cpcm->shift) - 1;
@@ -1315,7 +1324,7 @@
 
 	cpcm->substream = substream;
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-	cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel (chip,runtime->rate,cpcm);
+	cpcm->pcm_channel = cs46xx_dsp_create_pcm_channel (chip, runtime->rate, cpcm, cpcm->hw_addr);
 
 	if (cpcm->pcm_channel == NULL) {
 		snd_printk(KERN_ERR "cs46xx: failed to create virtual PCM channel\n");
@@ -1522,7 +1531,7 @@
 	int change = (old != val);
 	if (change) {
 		snd_cs46xx_poke(chip, reg, val);
-#ifndef CONFIG_SND_CS46XX_NEW_DSP
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
 		/* NOTE: this updates the current left and right volume
 		   that should be automatically updated by the DSP and
 		   not touched by the host. But for some strange reason
@@ -1531,6 +1540,14 @@
 		   channel volume. 
 		*/
 		snd_cs46xx_poke(chip, reg + 4, val);
+
+		/* shadow the SPDIF input volume */
+		if (reg == (ASYNCRX_SCB_ADDR + 0xE) << 2) {
+			/* FIXME: I known this is uggly ...
+			   any other suggestion ? 
+			*/
+			chip->dsp_spos_instance->spdif_input_volume = val;
+		}
 #endif
 	}
 	return change;
@@ -1579,8 +1596,10 @@
 		break;
 	case CS46XX_MIXER_SPDIF_INPUT_ELEMENT:
 		change = chip->dsp_spos_instance->spdif_status_in;
-		if (ucontrol->value.integer.value[0] && !change) 
+		if (ucontrol->value.integer.value[0] && !change) {
 			cs46xx_dsp_enable_spdif_in(chip);
+			/* restore volume */
+		}
 		else if (change && !ucontrol->value.integer.value[0])
 			cs46xx_dsp_disable_spdif_in(chip);
 		
@@ -1822,7 +1841,7 @@
 	.info = snd_mixer_boolean_info,
 	.get = snd_cs46xx_iec958_get,
 	.put = snd_cs46xx_iec958_put,
-    .private_value = CS46XX_MIXER_SPDIF_INPUT_ELEMENT,
+	.private_value = CS46XX_MIXER_SPDIF_INPUT_ELEMENT,
 },
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -2742,12 +2761,14 @@
 	snd_cs46xx_poke(chip, BA1_CVOL, 0x80008000);
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
+	/* time countdown enable */
+	cs46xx_poke_via_dsp (chip,SP_ASER_COUNTDOWN, 0x80000000);
+        
+	/* SPDIF input MASTER ENABLE */
+	cs46xx_poke_via_dsp (chip,SP_SPDIN_CONTROL, 0x800003ff);
+
 	/* mute spdif out */
 	cs46xx_dsp_disable_spdif_out(chip);
-
-	/* mute spdif in */
-	cs46xx_poke_via_dsp (chip,SP_ASER_COUNTDOWN, 0x00000000);
-	cs46xx_poke_via_dsp (chip,SP_SPDIN_CONTROL, 0x000003ff);
 #endif
 
 	return 0;
@@ -2943,6 +2964,9 @@
 	snd_printdd ("initializing Hercules mixer\n");
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
+	/* turnon Amplifier and leave it on */
+	chip->amplifier_ctrl(chip, 1);
+
 	for (idx = 0 ; idx < sizeof(snd_hercules_controls) / 
 		     sizeof(snd_hercules_controls[0]) ; idx++) {
 		snd_kcontrol_t *kctl;
diff -Nru a/sound/pci/cs46xx/cs46xx_lib.h b/sound/pci/cs46xx/cs46xx_lib.h
--- a/sound/pci/cs46xx/cs46xx_lib.h	Tue Oct  1 17:07:40 2002
+++ b/sound/pci/cs46xx/cs46xx_lib.h	Tue Oct  1 17:07:40 2002
@@ -185,7 +185,7 @@
                                                           dsp_scb_descriptor_t * snoop_scb,
                                                           dsp_scb_descriptor_t * parent_scb,
                                                           int scb_child_type);
-pcm_channel_descriptor_t * cs46xx_dsp_create_pcm_channel (cs46xx_t * chip,u32 sample_rate, void * private_data);
+pcm_channel_descriptor_t * cs46xx_dsp_create_pcm_channel (cs46xx_t * chip,u32 sample_rate, void * private_data, u32 hw_dma_addr);
 void                       cs46xx_dsp_destroy_pcm_channel (cs46xx_t * chip,
                                                            pcm_channel_descriptor_t * pcm_channel);
 void                       cs46xx_dsp_set_src_sample_rate(cs46xx_t * chip,dsp_scb_descriptor_t * src, 
@@ -194,4 +194,6 @@
 int                        cs46xx_dsp_pcm_link (cs46xx_t * chip,pcm_channel_descriptor_t * pcm_channel);
 dsp_scb_descriptor_t *     cs46xx_add_record_source (cs46xx_t *chip,dsp_scb_descriptor_t * source,
                                                      u16 addr,char * scb_name);
+int                         cs46xx_src_unlink(cs46xx_t *chip,dsp_scb_descriptor_t * src);
+int                         cs46xx_src_link(cs46xx_t *chip,dsp_scb_descriptor_t * src);
 #endif /* __CS46XX_LIB_H__ */
diff -Nru a/sound/pci/cs46xx/dsp_spos.c b/sound/pci/cs46xx/dsp_spos.c
--- a/sound/pci/cs46xx/dsp_spos.c	Tue Oct  1 17:07:40 2002
+++ b/sound/pci/cs46xx/dsp_spos.c	Tue Oct  1 17:07:40 2002
@@ -36,74 +36,6 @@
 #include "cs46xx_lib.h"
 #include "dsp_spos.h"
 
-#if 0
-/* OBSOLETE NOW */
-
-static void handle_goto (cs46xx_t * chip,u32  * hival,u32 * loval,char * format, u32 overlay_begin_address);
-
-typedef struct _dsp_opcode_desc_t {
-	u32 hival,loval;
-	u32 himask,lomask;
-	void (*handler_func)(cs46xx_t * chip,u32 * hival,u32 * loval,char * format, u32 overlay_begin_address);
-	char * format;
-} dsp_opcode_desc_t;
-
-/* NOTE: theese opcodes are known needed to be reallocated,
-   there may be more. */
-dsp_opcode_desc_t dsp_opcodes[] = {
-	{ 0x01000,0x02730, 0xFF000,0x07FFF,handle_goto,"goto %s" },
-	{ 0x01000,0x00730, 0xFF000,0x07FFF,handle_goto,"goto %s after" },
-	{ 0x01000,0x02630, 0xFF000,0x07FFF,handle_goto,"if (tb) goto %s" },
-	{ 0x01000,0x00630, 0xFF000,0x07FFF,handle_goto,"if (tb) goto %s after" },
-	{ 0x01000,0x00530, 0xFF000,0x07FFF,handle_goto,"if (lt) goto %s after" },
-	{ 0x01000,0x02530, 0xFF000,0x07FFF,handle_goto,"if (lt) goto %s" },
-	{ 0x01000,0x006B0, 0xFF000,0x07FFF,handle_goto,"if (!tb) goto %s after" },
-	{ 0x01000,0x026B0, 0xFF000,0x07FFF,handle_goto,"if (!tb) goto %s" },
-	{ 0x01000,0x00FB0, 0xFF000,0x07FFF,handle_goto,"if (gt) goto %s after" },
-	{ 0x01000,0x02FB0, 0xFF000,0x07FFF,handle_goto,"if (gt) goto %s" },
-	{ 0x01000,0x02734, 0xFF000,0x07FFF,NULL,"goto *ind" },
-	{ 0x01000,0x00734, 0xFF000,0x07FFF,NULL,"goto *ind after" },
-	{ 0x01000,0x02130, 0xFF000,0x07FFF,handle_goto,"if (N) goto %s" },
-	{ 0x01000,0x00130, 0xFF000,0x07FFF,handle_goto,"if (N) goto %s after" },
-	{ 0x01000,0x020F2, 0xFF000,0x07FFF,handle_goto,"tb = Z, if(!Z) goto %s" },
-	{ 0x01000,0x000F2, 0xFF000,0x07FFF,handle_goto,"tb = Z, if(!Z) goto %s after" },
-	{ 0x01000,0x04030, 0xFF000,0x07FFF,handle_goto,"if(Z) goto %s" },
-	{ 0x01000,0x00030, 0xFF000,0x07FFF,handle_goto,"if(Z) goto %s after" },
-	{ 0x01000,0x020B0, 0xFF000,0x07FFF,handle_goto,"if(!Z) goto %s" },
-	{ 0x01000,0x000B0, 0xFF000,0x07FFF,handle_goto,"if(!Z) goto %s after" },
-	{ 0x01000,0x02731, 0xFF000,0x07FFF,handle_goto,"%s();" },
-};
-
-static void handle_goto (cs46xx_t * chip,u32  * hival,u32 * loval,
-			 char * format, u32 overlay_begin_address)
-{
-	u32 address ;
-	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
-
-	address  = (*hival & 0x00FFF) << 5;
-	address |=  *loval >> 15;
- 
-	snd_printdd("handle_goto[1]: %05x:%05x addr %04x\n",*hival,*loval,address);
-
-	if ( !(address & 0x8000) ) {
-		address += (ins->code.offset / 2) - overlay_begin_address;
-	} else {
-		snd_printdd("handle_goto[1]: ROM symbol not reallocated\n");
-	}
-
-	*hival &= 0xFF000;
-	*loval &= 0x07FFF;
-
-	*hival |= ( (address >> 5)  & 0x00FFF);
-	*loval |= ( (address << 15) & 0xF8000);
-
-	address  = (*hival & 0x00FFF) << 5;
-	address |=  *loval >> 15;
-
-	snd_printdd("handle_goto:[2] %05x:%05x addr %04x\n",*hival,*loval,address);
-}
-#endif /* #if 0 */
-
 static wide_opcode_t wide_opcodes[] = { 
 	WIDE_FOR_BEGIN_LOOP,
 	WIDE_FOR_BEGIN_LOOP2,
@@ -133,18 +65,6 @@
 		hival = data[i++];
 
 		if (ins->code.offset > 0) {
-#if 0
-			/* OBSOLETE NOW */
-			for (j = 0;j < sizeof(dsp_opcodes) / sizeof(dsp_opcode_desc_t); ++j) {
-				if ( (hival & dsp_opcodes[j].himask) == dsp_opcodes[j].hival &&
-				     (loval & dsp_opcodes[j].lomask) == dsp_opcodes[j].loval &&
-				     dsp_opcodes[j].handler_func != NULL) {
-					dsp_opcodes[j].handler_func (chip,&hival,&loval,dsp_opcodes[j].format, overlay_begin_address);
-					nreallocated ++;
-				}
-			}
-#endif
-
 			mop_operands = (hival >> 6) & 0x03fff;
 			mop_type = mop_operands >> 10;
       
@@ -337,7 +257,10 @@
 
 	/* default SPDIF input sample rate
 	   to 48000 khz */
-	ins->spdif_in_sample_rate = 32000;
+	ins->spdif_in_sample_rate = 48000;
+
+	/* maximize volume */
+	ins->spdif_input_volume = 0x80008000;
 
 	return ins;
 }
@@ -655,7 +578,6 @@
 static void cs46xx_dsp_proc_sample_dump_read (snd_info_entry_t *entry, snd_info_buffer_t * buffer)
 {
 	cs46xx_t *chip = snd_magic_cast(cs46xx_t, entry->private_data, return);
-	/*dsp_spos_instance_t * ins = chip->dsp_spos_instance; */
 	int i,col = 0;
 	unsigned long dst = chip->region.idx[2].remap_addr;
 
@@ -1370,7 +1292,8 @@
 
 	/* create the record mixer SCB */
 	record_mix_scb = cs46xx_dsp_create_mix_only_scb(chip,"RecordMixerSCB",
-							MIX_SAMPLE_BUF2,0x170,
+							MIX_SAMPLE_BUF2,
+							RECORD_MIXER_SCB_ADDR,
 							vari_decimate_scb,
 							SCB_ON_PARENT_SUBLIST_SCB);
 	ins->record_mixer_scb = record_mix_scb;
@@ -1417,8 +1340,7 @@
 		goto _fail_end;
 
 
-	/* the magic snooper */
-
+	/* SPDIF input sampel rate converter */
 	src_task_scb = cs46xx_dsp_create_src_task_scb(chip,"SrcTaskSCB_SPDIFI",
 						      SRC_OUTPUT_BUF1,
 						      SRC_DELAY_BUF1,SRCTASK_SCB_ADDR,
@@ -1427,6 +1349,8 @@
 
 	if (!src_task_scb) goto _fail_end;
 
+	cs46xx_src_unlink(chip,src_task_scb);
+
 	/* NOTE: when we now how to detect the SPDIF input
 	   sample rate we will use this SRC to adjust it */
 	ins->spdif_in_src = src_task_scb;
@@ -1644,19 +1568,14 @@
 int cs46xx_dsp_enable_spdif_in (cs46xx_t *chip)
 {
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
+	unsigned int flags;
 
 	/* turn on amplifier */
 	chip->active_ctrl(chip, 1);
 	chip->amplifier_ctrl(chip, 1);
 
-	/* set SPDIF input sample rate 
-	   NOTE: only 48khz support for SPDIF input this time */
-	cs46xx_dsp_set_src_sample_rate(chip,ins->spdif_in_src,48000);
-
-
 	snd_assert (ins->asynch_rx_scb == NULL,return -EINVAL);
 	snd_assert (ins->spdif_in_src != NULL,return -EINVAL);
-
 	/* create and start the asynchronous receiver SCB */
 	ins->asynch_rx_scb = cs46xx_dsp_create_asynch_fg_rx_scb(chip,"AsynchFGRxSCB",
 								ASYNCRX_SCB_ADDR,
@@ -1665,21 +1584,24 @@
 								ins->spdif_in_src,
 								SCB_ON_PARENT_SUBLIST_SCB);
 
-	if (!ins->asynch_rx_scb) 
-		return -EINVAL;
-
+	save_flags(flags);
+	cli();
 	/* reset SPDIF input sample buffer pointer */
 	snd_cs46xx_poke (chip, (SPDIFI_SCB_INST + 0x0c) << 2,
 			 (SPDIFI_IP_OUTPUT_BUFFER1 << 0x10) | 0xFFFC);
 
-	/* time countdown enable */
-	cs46xx_poke_via_dsp (chip,SP_ASER_COUNTDOWN, 0x80000000);
-
 	/* reset FIFO ptr */
 	cs46xx_poke_via_dsp (chip,SP_SPDIN_FIFOPTR, 0x0);
+	cs46xx_src_link(chip,ins->spdif_in_src);
 
-	/* SPDIF input MASTER ENABLE */
-	cs46xx_poke_via_dsp (chip,SP_SPDIN_CONTROL, 0x800003ff);
+	/* restore SPDIF input volume */
+	snd_cs46xx_poke(chip, (ASYNCRX_SCB_ADDR + 0xE) << 2, ins->spdif_input_volume);
+	snd_cs46xx_poke(chip, (ASYNCRX_SCB_ADDR + 0xF) << 2, ins->spdif_input_volume);
+	restore_flags(flags);
+
+	/* set SPDIF input sample rate and unmute
+	   NOTE: only 48khz support for SPDIF input this time */
+	cs46xx_dsp_set_src_sample_rate(chip,ins->spdif_in_src,48000);
 
 	/* monitor state */
 	ins->spdif_status_in = 1;
@@ -1692,16 +1614,13 @@
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
 
 	snd_assert (ins->asynch_rx_scb != NULL, return -EINVAL);
-
-	/* Time countdown disable */
-	cs46xx_poke_via_dsp (chip,SP_ASER_COUNTDOWN, 0x00000000);
-
-	/* SPDIF input MASTER DISABLE */
-	cs46xx_poke_via_dsp (chip,SP_SPDIN_CONTROL, 0x000003ff);
+	snd_assert (ins->spdif_in_src != NULL,return -EINVAL);
 
 	/* Remove the asynchronous receiver SCB */
 	cs46xx_dsp_remove_scb (chip,ins->asynch_rx_scb);
 	ins->asynch_rx_scb = NULL;
+
+	cs46xx_src_unlink(chip,ins->spdif_in_src);
 
 	/* monitor state */
 	ins->spdif_status_in = 0;
diff -Nru a/sound/pci/cs46xx/dsp_spos.h b/sound/pci/cs46xx/dsp_spos.h
--- a/sound/pci/cs46xx/dsp_spos.h	Tue Oct  1 17:07:40 2002
+++ b/sound/pci/cs46xx/dsp_spos.h	Tue Oct  1 17:07:40 2002
@@ -75,10 +75,6 @@
 #define MIX_SAMPLE_BUF1          0x1400
 #define MIX_SAMPLE_BUF2          0x3000
 
-// #define SPDIFI_IP_OUTPUT_BUFFER1 0x2800
-// #define SRC_OUTPUT_BUF2          0x1280
-// #define SRC_DELAY_BUF2           0x1288
-
 /* Task stack address */
 #define HFG_STACK                0x066A
 #define FG_STACK                 0x066E
@@ -107,6 +103,7 @@
 #define SEC_CODECOUT_SCB_ADDR    0x140
 #define OUTPUTSNOOPII_SCB_ADDR   0x150
 #define PCMSERIALIN_PCM_SCB_ADDR 0x160
+#define RECORD_MIXER_SCB_ADDR    0x170
 
 /* hyperforground SCB's*/
 #define HFG_TREE_SCB             0xBA0
@@ -184,4 +181,3 @@
 
 #endif /* __DSP_SPOS_H__ */
 #endif /* CONFIG_SND_CS46XX_NEW_DSP  */
-
diff -Nru a/sound/pci/cs46xx/dsp_spos_scb_lib.c b/sound/pci/cs46xx/dsp_spos_scb_lib.c
--- a/sound/pci/cs46xx/dsp_spos_scb_lib.c	Tue Oct  1 17:07:40 2002
+++ b/sound/pci/cs46xx/dsp_spos_scb_lib.c	Tue Oct  1 17:07:40 2002
@@ -137,7 +137,7 @@
 				scb->next_scb_ptr = ins->the_null_scb;
 			}
 		} else {
-			snd_assert ( (scb->sub_list_ptr == ins->the_null_scb), return);
+			/* snd_assert ( (scb->sub_list_ptr == ins->the_null_scb), return); */
 			scb->parent_scb_ptr->next_scb_ptr = scb->next_scb_ptr;
 
 			if (scb->next_scb_ptr != ins->the_null_scb) {
@@ -166,6 +166,16 @@
 	}
 }
 
+static void _dsp_clear_sample_buffer (cs46xx_t *chip, u32 sample_buffer_addr, int dword_count) 
+{
+	u32 dst = chip->region.idx[2].remap_addr + sample_buffer_addr;
+	int i;
+  
+	for (i = 0; i < dword_count ; ++i ) {
+		writel(0, dst);
+	}  
+}
+
 void cs46xx_dsp_remove_scb (cs46xx_t *chip, dsp_scb_descriptor_t * scb)
 {
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
@@ -564,9 +574,10 @@
 		/* Fractional increment per output sample in the input sample buffer */
 		0, 
 		{
-			/* Standard stereo volume control */
-			0x8000,0x8000,
-			0x8000,0x8000
+			/* Standard stereo volume control
+			   default muted */
+			0xffff,0xffff,
+			0xffff,0xffff
 		}
 	};
 
@@ -614,8 +625,8 @@
 		src_buffer_addr << 0x10,
 		0x04000000,
 		{ 
-			0x8000,0x8000,
-			0x8000,0x8000
+			0xffff,0xffff,
+			0xffff,0xffff
 		}
 	};
 
@@ -629,6 +640,10 @@
 		}    
 	}
 
+	/* clear buffers */
+	_dsp_clear_sample_buffer (chip,src_buffer_addr,8);
+	_dsp_clear_sample_buffer (chip,src_delay_buffer_addr,32);
+
 	scb = _dsp_create_generic_scb(chip,scb_name,(u32 *)&src_task_scb,
 				      dest,ins->s16_up,parent_scb,
 				      scb_child_type);
@@ -899,8 +914,9 @@
 		/* There is no correct initial value, it will depend upon the detected
 		   rate etc  */
 		0x18000000,         
+		/* Mute stream */
 		0x8000,0x8000,       
-		0xFFFF,0xFFFF
+		0xffff,0xffff
 	};
 
 	scb = cs46xx_dsp_create_generic_scb(chip,scb_name,(u32 *)&asynch_fg_rx_scb,
@@ -1091,7 +1107,7 @@
 };
 
 
-pcm_channel_descriptor_t * cs46xx_dsp_create_pcm_channel (cs46xx_t * chip,u32 sample_rate, void * private_data)
+pcm_channel_descriptor_t * cs46xx_dsp_create_pcm_channel (cs46xx_t * chip,u32 sample_rate, void * private_data, u32 hw_dma_addr)
 {
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
 	dsp_scb_descriptor_t * src_scb = NULL,* pcm_scb;
@@ -1206,7 +1222,7 @@
 						   /* 0x200 - 400 PCMreader SCBs */
 						   (pcm_index * 0x10) + 0x200,
 						   pcm_index, /* virtual channel 0-31 */
-						   0, /* pcm hw addr */
+						   hw_dma_addr, /* pcm hw addr */
 						   pcm_parent_scb,
 						   insert_point);
 
@@ -1386,11 +1402,15 @@
 	 */
 	spin_lock_irqsave(&chip->reg_lock, flags);
 
+	/* mute SCB */
+	snd_cs46xx_poke(chip, (src->address + 0xE) << 2, 0xffffffff);
 	snd_cs46xx_poke(chip, (src->address + SRCCorPerGof) << 2,
 	  ((correctionPerSec << 16) & 0xFFFF0000) | (correctionPerGOF & 0xFFFF));
 
 	snd_cs46xx_poke(chip, (src->address + SRCPhiIncr6Int26Frac) << 2, phiIncr);
 
+	/* raise volume */
+	snd_cs46xx_poke(chip, (src->address + 0xE) << 2, 0x80008000);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
@@ -1418,4 +1438,73 @@
 							   insert_point);
 
 	return pcm_input;
+}
+
+int cs46xx_src_unlink(cs46xx_t *chip,dsp_scb_descriptor_t * src)
+{
+	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
+	down(&ins->pcm_mutex);
+	down(&ins->scb_mutex);
+
+	snd_assert (src->parent_scb_ptr != NULL,goto _fail_end);
+
+	/* mute SCB */
+	snd_cs46xx_poke(chip, (src->address + 0xE) << 2, 0xffffffff);
+
+	_dsp_unlink_scb (chip,src);
+
+	up(&ins->scb_mutex);
+	up(&ins->pcm_mutex);
+
+	return 0;
+
+ _fail_end:
+	up(&ins->scb_mutex);
+	up(&ins->pcm_mutex);
+
+	return -EINVAL;
+}
+
+int cs46xx_src_link(cs46xx_t *chip,dsp_scb_descriptor_t * src)
+{
+	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
+	dsp_scb_descriptor_t * parent_scb;
+	unsigned int flags;
+
+	down(&ins->pcm_mutex);
+	down(&ins->scb_mutex);
+
+	snd_assert (src->parent_scb_ptr == NULL,goto _fail_end);
+	snd_assert(ins->master_mix_scb !=NULL,goto _fail_end);
+
+	if (ins->master_mix_scb->sub_list_ptr != ins->the_null_scb) {
+		parent_scb = find_next_free_scb (chip,ins->master_mix_scb->sub_list_ptr);
+		parent_scb->next_scb_ptr = src;
+	} else {
+		parent_scb = ins->master_mix_scb;
+		parent_scb->sub_list_ptr = src;
+	}
+
+	src->parent_scb_ptr = parent_scb;
+
+	/* update entry in DSP RAM */
+	spin_lock_irqsave(&chip->reg_lock, flags);
+	snd_cs46xx_poke(chip,
+			(parent_scb->address + SCBsubListPtr) << 2,
+			(parent_scb->sub_list_ptr->address << 0x10) |
+			(parent_scb->next_scb_ptr->address));
+  
+
+	spin_unlock_irqrestore(&chip->reg_lock, flags);
+  
+	up(&ins->scb_mutex);
+	up(&ins->pcm_mutex);
+
+	return 0;
+
+ _fail_end:
+	up(&ins->scb_mutex);
+	up(&ins->pcm_mutex);
+ 
+	return -EINVAL;
 }
diff -Nru a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
--- a/sound/pci/emu10k1/emufx.c	Tue Oct  1 17:07:40 2002
+++ b/sound/pci/emu10k1/emufx.c	Tue Oct  1 17:07:40 2002
@@ -91,14 +91,14 @@
 	/* 0x01 */ "AC97 Right",
 	/* 0x02 */ "Audigy CD Left",
 	/* 0x03 */ "Audigy CD Right",
-	/* 0x04 */ NULL,
-	/* 0x05 */ NULL,
+	/* 0x04 */ "Optical IEC958 Left",
+	/* 0x05 */ "Optical IEC958 Right",
 	/* 0x06 */ NULL,
 	/* 0x07 */ NULL,
 	/* 0x08 */ "Line/Mic 2 Left",
 	/* 0x09 */ "Line/Mic 2 Right",
-	/* 0x0a */ NULL,
-	/* 0x0b */ NULL,
+	/* 0x0a */ "SPDIF Left",
+	/* 0x0b */ "SPDIF Right",
 	/* 0x0c */ "Aux2 Left",
 	/* 0x0d */ "Aux2 Right",
 	/* 0x0e */ NULL,
@@ -1313,6 +1313,17 @@
 	snd_emu10k1_init_stereo_control(&controls[nctl++], "Audigy CD Capture Volume", gpr, 0);
 	gpr += 2;
 
+ 	/* Optical SPDIF Playback Volume */
+	A_ADD_VOLUME_IN(playback, gpr, A_EXTIN_OPT_SPDIF_L);
+	A_ADD_VOLUME_IN(playback+1, gpr+1, A_EXTIN_OPT_SPDIF_R);
+	snd_emu10k1_init_stereo_control(&controls[nctl++], "Optical IEC958 Playback Volume", gpr, 0);
+	gpr += 2;
+	/* Optical SPDIF Capture Volume */
+	A_ADD_VOLUME_IN(capture, gpr, A_EXTIN_OPT_SPDIF_L);
+	A_ADD_VOLUME_IN(capture+1, gpr+1, A_EXTIN_OPT_SPDIF_R);
+	snd_emu10k1_init_stereo_control(&controls[nctl++], "Optical IEC958 Capture Volume", gpr, 0);
+	gpr += 2;
+
 	/* Line2 Playback Volume */
 	A_ADD_VOLUME_IN(playback, gpr, A_EXTIN_LINE2_L);
 	A_ADD_VOLUME_IN(playback+1, gpr+1, A_EXTIN_LINE2_R);
@@ -1322,6 +1333,17 @@
 	A_ADD_VOLUME_IN(capture, gpr, A_EXTIN_LINE2_L);
 	A_ADD_VOLUME_IN(capture+1, gpr+1, A_EXTIN_LINE2_R);
 	snd_emu10k1_init_stereo_control(&controls[nctl++], "Line2 Capture Volume", gpr, 0);
+	gpr += 2;
+        
+	/* RCA SPDIF Playback Volume */
+	A_ADD_VOLUME_IN(playback, gpr, A_EXTIN_RCA_SPDIF_L);
+	A_ADD_VOLUME_IN(playback+1, gpr+1, A_EXTIN_RCA_SPDIF_R);
+	snd_emu10k1_init_stereo_control(&controls[nctl++], "RCA SPDIF Playback Volume", gpr, 0);
+	gpr += 2;
+	/* RCA SPDIF Capture Volume */
+	A_ADD_VOLUME_IN(capture, gpr, A_EXTIN_RCA_SPDIF_L);
+	A_ADD_VOLUME_IN(capture+1, gpr+1, A_EXTIN_RCA_SPDIF_R);
+	snd_emu10k1_init_stereo_control(&controls[nctl++], "RCA SPDIF Capture Volume", gpr, 0);
 	gpr += 2;
 
 	/* Aux2 Playback Volume */
diff -Nru a/sound/ppc/awacs.c b/sound/ppc/awacs.c
--- a/sound/ppc/awacs.c	Tue Oct  1 17:07:40 2002
+++ b/sound/ppc/awacs.c	Tue Oct  1 17:07:40 2002
@@ -25,6 +25,7 @@
 #include <asm/nvram.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/slab.h>
 #include <sound/core.h>
 #include "pmac.h"
 
@@ -134,12 +135,20 @@
 	pmac_t *chip = snd_kcontrol_chip(kcontrol);
 	int reg = kcontrol->private_value & 0xff;
 	int lshift = (kcontrol->private_value >> 8) & 0xff;
+	int inverted = (kcontrol->private_value >> 16) & 1;
 	unsigned long flags;
+	int vol[2];
 
 	spin_lock_irqsave(&chip->reg_lock, flags);
-	ucontrol->value.integer.value[0] = 0x0f - ((chip->awacs_reg[reg] >> lshift) & 0xf);
-	ucontrol->value.integer.value[1] = 0x0f - (chip->awacs_reg[reg] & 0xf);
+	vol[0] = (chip->awacs_reg[reg] >> lshift) & 0xf;
+	vol[1] = chip->awacs_reg[reg] & 0xf;
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
+	if (inverted) {
+		vol[0] = 0x0f - vol[0];
+		vol[1] = 0x0f - vol[1];
+	}
+	ucontrol->value.integer.value[0] = vol[0];
+	ucontrol->value.integer.value[1] = vol[1];
 	return 0;
 }
 
@@ -148,14 +157,24 @@
 	pmac_t *chip = snd_kcontrol_chip(kcontrol);
 	int reg = kcontrol->private_value & 0xff;
 	int lshift = (kcontrol->private_value >> 8) & 0xff;
+	int inverted = (kcontrol->private_value >> 16) & 1;
 	int val, oldval;
 	unsigned long flags;
+	int vol[2];
 
+	vol[0] = ucontrol->value.integer.value[0];
+	vol[1] = ucontrol->value.integer.value[1];
+	if (inverted) {
+		vol[0] = 0x0f - vol[0];
+		vol[1] = 0x0f - vol[1];
+	}
+	vol[0] &= 0x0f;
+	vol[1] &= 0x0f;
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	oldval = chip->awacs_reg[reg];
 	val = oldval & ~(0xf | (0xf << lshift));
-	val |= ((0x0f - (ucontrol->value.integer.value[0] & 0xf)) << lshift);
-	val |= 0x0f - (ucontrol->value.integer.value[1] & 0xf);
+	val |= vol[0] << lshift;
+	val |= vol[1];
 	if (oldval != val)
 		snd_pmac_awacs_write_reg(chip, reg, val);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
@@ -163,12 +182,12 @@
 }
 
 
-#define AWACS_VOLUME(xname, xreg, xshift) \
+#define AWACS_VOLUME(xname, xreg, xshift, xinverted) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = 0, \
   .info = snd_pmac_awacs_info_volume, \
   .get = snd_pmac_awacs_get_volume, \
   .put = snd_pmac_awacs_put_volume, \
-  .private_value = (xreg) | ((xshift) << 8) }
+  .private_value = (xreg) | ((xshift) << 8) | ((xinverted) << 16) }
 
 /*
  * mute master/ogain for AWACS: mono
@@ -539,9 +558,9 @@
  * lists of mixer elements
  */
 static snd_kcontrol_new_t snd_pmac_awacs_mixers[] __initdata = {
-	AWACS_VOLUME("Master Playback Volume", 2, 6),
+	AWACS_VOLUME("Master Playback Volume", 2, 6, 1),
 	AWACS_SWITCH("Master Capture Switch", 1, SHIFT_LOOPTHRU, 0),
-	AWACS_VOLUME("Capture Volume", 0, 4),
+	AWACS_VOLUME("Capture Volume", 0, 4, 0),
 	AWACS_SWITCH("Line Capture Switch", 0, SHIFT_MUX_LINE, 0),
 	AWACS_SWITCH("CD Capture Switch", 0, SHIFT_MUX_CD, 0),
 	AWACS_SWITCH("Mic Capture Switch", 0, SHIFT_MUX_MIC, 0),
@@ -564,7 +583,7 @@
 };
 
 static snd_kcontrol_new_t snd_pmac_awacs_speaker_vol[] __initdata = {
-	AWACS_VOLUME("PC Speaker Playback Volume", 4, 6),
+	AWACS_VOLUME("PC Speaker Playback Volume", 4, 6, 1),
 };
 static snd_kcontrol_new_t snd_pmac_awacs_speaker_sw __initdata =
 AWACS_SWITCH("PC Speaker Playback Switch", 1, SHIFT_SPKMUTE, 1);
diff -Nru a/sound/ppc/burgundy.c b/sound/ppc/burgundy.c
--- a/sound/ppc/burgundy.c	Tue Oct  1 17:07:40 2002
+++ b/sound/ppc/burgundy.c	Tue Oct  1 17:07:40 2002
@@ -22,6 +22,7 @@
 #include <sound/driver.h>
 #include <asm/io.h>
 #include <linux/init.h>
+#include <linux/slab.h>
 #include <sound/core.h>
 #include "pmac.h"
 #include "burgundy.h"
@@ -196,9 +197,10 @@
 
 #define BURGUNDY_VOLUME(xname, xindex, addr, shift) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = xindex,\
-  .info = snd_pmac_burgundy_info_volume,\ .get = snd_pmac_burgundy_get_volume,\
-  .put = snd_pmac_burgundy_put_volume,\ .private_value = ((ADDR2BASE(addr) &
-  0xff) | ((shift) << 8)) }
+  .info = snd_pmac_burgundy_info_volume,\
+  .get = snd_pmac_burgundy_get_volume,\
+  .put = snd_pmac_burgundy_put_volume,\
+  .private_value = ((ADDR2BASE(addr) & 0xff) | ((shift) << 8)) }
 
 /* lineout/speaker */
 
diff -Nru a/sound/ppc/daca.c b/sound/ppc/daca.c
--- a/sound/ppc/daca.c	Tue Oct  1 17:07:40 2002
+++ b/sound/ppc/daca.c	Tue Oct  1 17:07:40 2002
@@ -24,6 +24,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 #include <linux/kmod.h>
+#include <linux/slab.h>
 #include <sound/core.h>
 #include "pmac.h"
 
diff -Nru a/sound/ppc/keywest.c b/sound/ppc/keywest.c
--- a/sound/ppc/keywest.c	Tue Oct  1 17:07:40 2002
+++ b/sound/ppc/keywest.c	Tue Oct  1 17:07:40 2002
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
+#include <linux/slab.h>
 #include <sound/core.h>
 #include "pmac.h"
 
diff -Nru a/sound/ppc/pmac.c b/sound/ppc/pmac.c
--- a/sound/ppc/pmac.c	Tue Oct  1 17:07:40 2002
+++ b/sound/ppc/pmac.c	Tue Oct  1 17:07:40 2002
@@ -25,6 +25,7 @@
 #include <asm/irq.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/slab.h>
 #include <sound/core.h>
 #include "pmac.h"
 #include <sound/pcm_params.h>
@@ -243,7 +244,10 @@
 		snd_pmac_dma_set_command(rec, &chip->extra_dma);
 		snd_pmac_dma_run(rec, RUN);
 	}
-	offset = runtime->dma_addr;
+	/* continuous DMA memory type doesn't provide the physical address,
+	 * so we need to resolve the address here...
+	 */
+	offset = virt_to_bus(runtime->dma_area);
 	for (i = 0, cp = rec->cmd.cmds; i < rec->nperiods; i++, cp++) {
 		st_le32(&cp->phy_addr, offset);
 		st_le16(&cp->req_count, rec->period_size);
@@ -650,9 +654,7 @@
 
 static void pmac_pcm_free(snd_pcm_t *pcm)
 {
-#if 0
 	snd_pcm_lib_preallocate_free_for_all(pcm);
-#endif
 }
 
 int __init snd_pmac_pcm_new(pmac_t *chip)
@@ -686,10 +688,8 @@
 	chip->playback.cur_freqs = chip->freqs_ok;
 	chip->capture.cur_freqs = chip->freqs_ok;
 
-#if 0
 	/* preallocate 64k buffer */
 	snd_pcm_lib_preallocate_pages_for_all(pcm, 64 * 1024, 64 * 1024, GFP_KERNEL);
-#endif
 
 	return 0;
 }
diff -Nru a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
--- a/sound/ppc/tumbler.c	Tue Oct  1 17:07:40 2002
+++ b/sound/ppc/tumbler.c	Tue Oct  1 17:07:40 2002
@@ -25,6 +25,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 #include <linux/kmod.h>
+#include <linux/slab.h>
 #include <sound/core.h>
 #include <asm/io.h>
 #include <asm/irq.h>
diff -Nru a/sound/usb/usbmidi.c b/sound/usb/usbmidi.c
--- a/sound/usb/usbmidi.c	Tue Oct  1 17:07:40 2002
+++ b/sound/usb/usbmidi.c	Tue Oct  1 17:07:40 2002
@@ -194,7 +194,7 @@
 
 struct usbmidi_out_endpoint {
 	usbmidi_t* umidi;
-	urb_t* urb;
+	struct urb* urb;
 	int max_transfer;		/* size of urb buffer */
 	struct tasklet_struct tasklet;
 
@@ -214,7 +214,7 @@
 struct usbmidi_in_endpoint {
 	usbmidi_t* umidi;
 	usbmidi_endpoint_t* ep;
-	urb_t* urb;
+	struct urb* urb;
 	struct usbmidi_in_port {
 		int seq_port;
 		snd_midi_event_t* midi_event;
@@ -229,7 +229,7 @@
 /*
  * Submits the URB, with error handling.
  */
-static int snd_usbmidi_submit_urb(urb_t* urb, int flags)
+static int snd_usbmidi_submit_urb(struct urb* urb, int flags)
 {
 	int err = usb_submit_urb(urb, flags);
 	if (err < 0 && err != -ENODEV)
@@ -283,7 +283,7 @@
 /*
  * Processes the data read from the device.
  */
-static void snd_usbmidi_in_urb_complete(urb_t* urb)
+static void snd_usbmidi_in_urb_complete(struct urb* urb)
 {
 	usbmidi_in_endpoint_t* ep = snd_magic_cast(usbmidi_in_endpoint_t, urb->context, return);
 
@@ -305,7 +305,7 @@
 	}
 }
 
-static void snd_usbmidi_out_urb_complete(urb_t* urb)
+static void snd_usbmidi_out_urb_complete(struct urb* urb)
 {
 	usbmidi_out_endpoint_t* ep = snd_magic_cast(usbmidi_out_endpoint_t, urb->context, return);
 	unsigned long flags;

===================================================================


This BitKeeper patch contains the following changesets:
1.649
## Wrapped with gzip_uu ##


begin 664 bkpatch22972
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
=3O[:R\G[V>1FM5Z>SJ8NK7<T[WX#BID&4G%S````
`
end

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

