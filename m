Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261731AbSI2S5x>; Sun, 29 Sep 2002 14:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261738AbSI2S5x>; Sun, 29 Sep 2002 14:57:53 -0400
Received: from gate.perex.cz ([194.212.165.105]:16656 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261731AbSI2S5i>;
	Sun, 29 Sep 2002 14:57:38 -0400
Date: Sun, 29 Sep 2002 21:02:20 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update [10/10] - 2002/08/05 
Message-ID: <Pine.LNX.4.33.0209292101250.591-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.605.2.21, 2002-09-26 16:20:01+02:00, perex@pnote.perex-int.cz
  ALSA update 2002/08/05 :
    - CS46xx
      - fixed capture with new DSP firmware
      - multiple pcm playback streams
      - pcm playback instance is allocated dynamically
      - fixed detection of secondary codec
    - changed ctl/rawmidi/timer read() code to follow POSIX standard - when some data are ready, return immediately
    - RME96 - added 32 bit sample formats for ADAT


 include/sound/cs46xx.h              |   80 ++++++++++++++++++++++-
 include/sound/version.h             |    2 
 sound/core/control.c                |    2 
 sound/core/rawmidi.c                |    2 
 sound/core/timer.c                  |    5 -
 sound/pci/cs46xx/cs46xx_lib.c       |  124 +++++++++++++++++++++++++++++++++---
 sound/pci/cs46xx/dsp_spos.c         |   35 +++++-----
 sound/pci/cs46xx/dsp_spos_scb_lib.c |    4 -
 sound/pci/rme96.c                   |    6 +
 9 files changed, 225 insertions(+), 35 deletions(-)


diff -Nru a/include/sound/cs46xx.h b/include/sound/cs46xx.h
--- a/include/sound/cs46xx.h	Sun Sep 29 20:24:05 2002
+++ b/include/sound/cs46xx.h	Sun Sep 29 20:24:05 2002
@@ -195,6 +195,81 @@
 #define BA1_FRSC                                0x00030038
 #define BA1_OMNI_MEM                            0x000E0000
 
+
+
+
+/*
+ * The following define the offsets of the AC97 shadow registers, which appear
+ * as a virtual extension to the base address register zero memory range.
+ */
+#define AC97_REG_OFFSET_MASK                    0x0000007EL
+#define AC97_CODEC_NUMBER_MASK                  0x00003000L
+
+#define BA0_AC97_RESET                          0x00001000L
+#define BA0_AC97_MASTER_VOLUME                  0x00001002L
+#define BA0_AC97_HEADPHONE_VOLUME               0x00001004L
+#define BA0_AC97_MASTER_VOLUME_MONO             0x00001006L
+#define BA0_AC97_MASTER_TONE                    0x00001008L
+#define BA0_AC97_PC_BEEP_VOLUME                 0x0000100AL
+#define BA0_AC97_PHONE_VOLUME                   0x0000100CL
+#define BA0_AC97_MIC_VOLUME                     0x0000100EL
+#define BA0_AC97_LINE_IN_VOLUME                 0x00001010L
+#define BA0_AC97_CD_VOLUME                      0x00001012L
+#define BA0_AC97_VIDEO_VOLUME                   0x00001014L
+#define BA0_AC97_AUX_VOLUME                     0x00001016L
+#define BA0_AC97_PCM_OUT_VOLUME                 0x00001018L
+#define BA0_AC97_RECORD_SELECT                  0x0000101AL
+#define BA0_AC97_RECORD_GAIN                    0x0000101CL
+#define BA0_AC97_RECORD_GAIN_MIC                0x0000101EL
+#define BA0_AC97_GENERAL_PURPOSE                0x00001020L
+#define BA0_AC97_3D_CONTROL                     0x00001022L
+#define BA0_AC97_MODEM_RATE                     0x00001024L
+#define BA0_AC97_POWERDOWN                      0x00001026L
+#define BA0_AC97_EXT_AUDIO_ID                   0x00001028L
+#define BA0_AC97_EXT_AUDIO_POWER                0x0000102AL
+#define BA0_AC97_PCM_FRONT_DAC_RATE             0x0000102CL
+#define BA0_AC97_PCM_SURR_DAC_RATE              0x0000102EL
+#define BA0_AC97_PCM_LFE_DAC_RATE               0x00001030L
+#define BA0_AC97_PCM_LR_ADC_RATE                0x00001032L
+#define BA0_AC97_MIC_ADC_RATE                   0x00001034L
+#define BA0_AC97_6CH_VOL_C_LFE                  0x00001036L
+#define BA0_AC97_6CH_VOL_SURROUND               0x00001038L
+#define BA0_AC97_RESERVED_3A                    0x0000103AL
+#define BA0_AC97_EXT_MODEM_ID                   0x0000103CL
+#define BA0_AC97_EXT_MODEM_POWER                0x0000103EL
+#define BA0_AC97_LINE1_CODEC_RATE               0x00001040L
+#define BA0_AC97_LINE2_CODEC_RATE               0x00001042L
+#define BA0_AC97_HANDSET_CODEC_RATE             0x00001044L
+#define BA0_AC97_LINE1_CODEC_LEVEL              0x00001046L
+#define BA0_AC97_LINE2_CODEC_LEVEL              0x00001048L
+#define BA0_AC97_HANDSET_CODEC_LEVEL            0x0000104AL
+#define BA0_AC97_GPIO_PIN_CONFIG                0x0000104CL
+#define BA0_AC97_GPIO_PIN_TYPE                  0x0000104EL
+#define BA0_AC97_GPIO_PIN_STICKY                0x00001050L
+#define BA0_AC97_GPIO_PIN_WAKEUP                0x00001052L
+#define BA0_AC97_GPIO_PIN_STATUS                0x00001054L
+#define BA0_AC97_MISC_MODEM_AFE_STAT            0x00001056L
+#define BA0_AC97_RESERVED_58                    0x00001058L
+#define BA0_AC97_CRYSTAL_REV_N_FAB_ID           0x0000105AL
+#define BA0_AC97_TEST_AND_MISC_CTRL             0x0000105CL
+#define BA0_AC97_AC_MODE                        0x0000105EL
+#define BA0_AC97_MISC_CRYSTAL_CONTROL           0x00001060L
+#define BA0_AC97_LINE1_HYPRID_CTRL              0x00001062L
+#define BA0_AC97_VENDOR_RESERVED_64             0x00001064L
+#define BA0_AC97_VENDOR_RESERVED_66             0x00001066L
+#define BA0_AC97_SPDIF_CONTROL                  0x00001068L
+#define BA0_AC97_VENDOR_RESERVED_6A             0x0000106AL
+#define BA0_AC97_VENDOR_RESERVED_6C             0x0000106CL
+#define BA0_AC97_VENDOR_RESERVED_6E             0x0000106EL
+#define BA0_AC97_VENDOR_RESERVED_70             0x00001070L
+#define BA0_AC97_VENDOR_RESERVED_72             0x00001072L
+#define BA0_AC97_VENDOR_RESERVED_74             0x00001074L
+#define BA0_AC97_CAL_ADDRESS                    0x00001076L
+#define BA0_AC97_CAL_DATA                       0x00001078L
+#define BA0_AC97_VENDOR_RESERVED_7A             0x0000107AL
+#define BA0_AC97_VENDOR_ID1                     0x0000107CL
+#define BA0_AC97_VENDOR_ID2                     0x0000107EL
+
 /*
  *  The following defines are for the flags in the host interrupt status
  *  register.
@@ -1629,10 +1704,11 @@
 #define POWER_DOWN_ALL         0x7f0f
 
 /* maxinum number of AC97 codecs connected, AC97 2.0 defined 4 */
-#define MAX_NR_AC97				4
-#define CS46XX_PRIMARY_CODEC_INDEX		0
+#define MAX_NR_AC97				            4
+#define CS46XX_PRIMARY_CODEC_INDEX          0
 #define CS46XX_SECONDARY_CODEC_INDEX		1
 #define CS46XX_SECONDARY_CODEC_OFFSET		0x80
+#define CS46XX_DSP_CAPTURE_CHANNEL          1
 
 /*
  *
diff -Nru a/include/sound/version.h b/include/sound/version.h
--- a/include/sound/version.h	Sun Sep 29 20:24:05 2002
+++ b/include/sound/version.h	Sun Sep 29 20:24:05 2002
@@ -1,3 +1,3 @@
 /* include/version.h.  Generated automatically by configure.  */
 #define CONFIG_SND_VERSION "0.9.0rc2"
-#define CONFIG_SND_DATE " (Thu Aug 01 15:59:56 2002 UTC)"
+#define CONFIG_SND_DATE " (Mon Aug 05 14:24:05 2002 UTC)"
diff -Nru a/sound/core/control.c b/sound/core/control.c
--- a/sound/core/control.c	Sun Sep 29 20:24:05 2002
+++ b/sound/core/control.c	Sun Sep 29 20:24:05 2002
@@ -660,7 +660,7 @@
 		snd_kctl_event_t *kev;
 		while (list_empty(&ctl->events)) {
 			wait_queue_t wait;
-			if (file->f_flags & O_NONBLOCK) {
+			if ((file->f_flags & O_NONBLOCK) != 0 || result > 0) {
 				err = -EAGAIN;
 				goto __end;
 			}
diff -Nru a/sound/core/rawmidi.c b/sound/core/rawmidi.c
--- a/sound/core/rawmidi.c	Sun Sep 29 20:24:05 2002
+++ b/sound/core/rawmidi.c	Sun Sep 29 20:24:05 2002
@@ -943,7 +943,7 @@
 		spin_lock_irq(&runtime->lock);
 		while (!snd_rawmidi_ready(substream)) {
 			wait_queue_t wait;
-			if (file->f_flags & O_NONBLOCK) {
+			if ((file->f_flags & O_NONBLOCK) != 0 || result > 0) {
 				spin_unlock_irq(&runtime->lock);
 				return result > 0 ? result : -EAGAIN;
 			}
diff -Nru a/sound/core/timer.c b/sound/core/timer.c
--- a/sound/core/timer.c	Sun Sep 29 20:24:06 2002
+++ b/sound/core/timer.c	Sun Sep 29 20:24:06 2002
@@ -1270,7 +1270,7 @@
 		while (!tu->qused) {
 			wait_queue_t wait;
 
-			if (file->f_flags & O_NONBLOCK) {
+			if ((file->f_flags & O_NONBLOCK) != 0 || result > 0) {
 				spin_unlock_irq(&tu->qlock);
 				err = -EAGAIN;
 				break;
@@ -1285,6 +1285,7 @@
 			spin_lock_irq(&tu->qlock);
 
 			remove_wait_queue(&tu->qchange_sleep, &wait);
+			set_current_state(TASK_RUNNING);
 
 			if (signal_pending(current)) {
 				err = -ERESTARTSYS;
@@ -1307,7 +1308,7 @@
 		result += sizeof(snd_timer_read_t);
 		buffer += sizeof(snd_timer_read_t);
 	}
-	return err? err: result;
+	return result > 0 ? result : err;
 }
 
 static unsigned int snd_timer_user_poll(struct file *file, poll_table * wait)
diff -Nru a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
--- a/sound/pci/cs46xx/cs46xx_lib.c	Sun Sep 29 20:24:05 2002
+++ b/sound/pci/cs46xx/cs46xx_lib.c	Sun Sep 29 20:24:05 2002
@@ -8,11 +8,12 @@
  *    --
  *
  *  TODO:
- *    We need a DSP code to support multichannel outputs and S/PDIF.
- *    Unfortunately, it seems that Cirrus Logic, Inc. is not willing
- *    to provide us sufficient information about the DSP processor,
- *    so we can't update the driver.
+ *    SPDIF input.
+ *    Secondary CODEC on some soundcards
  *
+ *  NOTE: with CONFIG_SND_CS46XX_NEW_DSP unset uses old DSP image (which
+ *        is default configuration), no SPDIF, no secondary codec, no
+ *        multi channel PCM.  But known to work.
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -334,7 +335,6 @@
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 
-// #include "imgs/cwcemb80.h"
 #include "imgs/cwc4630.h"
 #include "imgs/cwcasync.h"
 #include "imgs/cwcsnoop.h"
@@ -880,12 +880,14 @@
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		if (substream->runtime->periods != CS46XX_FRAGS)
-			snd_cs46xx_playback_transfer(substream, 0);
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 		if (cpcm->pcm_channel->unlinked)
 			cs46xx_dsp_pcm_link(chip,cpcm->pcm_channel);
+		if (substream->runtime->periods != CS46XX_FRAGS)
+			snd_cs46xx_playback_transfer(substream, 0);
 #else
+		if (substream->runtime->periods != CS46XX_FRAGS)
+			snd_cs46xx_playback_transfer(substream, 0);
 		{ unsigned int tmp;
 		tmp = snd_cs46xx_peek(chip, BA1_PCTL);
 		tmp &= 0x0000ffff;
@@ -1165,7 +1167,7 @@
 	for (i = 0; i < DSP_MAX_PCM_CHANNELS; ++i) {
 		if (i <= 15) {
 			if ( status1 & (1 << i) ) {
-				if (i == 1) {
+				if (i == CS46XX_DSP_CAPTURE_CHANNEL) {
 					if (chip->capt.substream)
 						snd_pcm_period_elapsed(chip->capt.substream);
 				} else {
@@ -2447,6 +2449,106 @@
 {	
 }
 
+
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
+static int voyetra_setup_eapd_slot(cs46xx_t *chip)
+{
+	int i;
+    u32 idx;
+    u16 modem_power,pin_config,logic_type,valid_slots,status;
+
+	snd_printd ("cs46xx: cs46xx_setup_eapd_slot()+\n");
+	/*
+	* Clear PRA.  The Bonzo chip will be used for GPIO not for modem
+	* stuff.
+	*/
+	if(chip->nr_ac97_codecs != 2)
+	{
+      snd_printk (KERN_ERR "cs46xx: cs46xx_setup_eapd_slot() - no secondary codec configured\n");
+      return -EINVAL;
+	}
+
+	modem_power = snd_cs46xx_codec_read (chip, 
+                                         BA0_AC97_EXT_MODEM_POWER,
+                                         CS46XX_SECONDARY_CODEC_INDEX);
+	modem_power &=0xFEFF;
+
+	snd_cs46xx_codec_write(chip, 
+                           BA0_AC97_EXT_MODEM_POWER, modem_power,
+                           CS46XX_SECONDARY_CODEC_INDEX);
+
+    /*
+     * Set GPIO pin's 7 and 8 so that they are configured for output.
+     */
+	pin_config = snd_cs46xx_codec_read (chip, 
+                                        BA0_AC97_GPIO_PIN_CONFIG,
+                                        CS46XX_SECONDARY_CODEC_INDEX);
+	pin_config &=0x27F;
+
+	snd_cs46xx_codec_write(chip, 
+                           BA0_AC97_GPIO_PIN_CONFIG, pin_config,
+                           CS46XX_SECONDARY_CODEC_INDEX);
+    
+    /*
+     * Set GPIO pin's 7 and 8 so that they are compatible with CMOS logic.
+     */
+
+	logic_type = snd_cs46xx_codec_read(chip, BA0_AC97_GPIO_PIN_TYPE,
+                                       CS46XX_SECONDARY_CODEC_INDEX);
+	logic_type &=0x27F;
+	snd_cs46xx_codec_write (chip, BA0_AC97_GPIO_PIN_TYPE, logic_type,
+                            CS46XX_SECONDARY_CODEC_INDEX);
+
+	valid_slots = snd_cs46xx_peekBA0(chip, BA0_ACOSV);
+	valid_slots |= 0x200;
+	snd_cs46xx_pokeBA0(chip, BA0_ACOSV, valid_slots);
+
+    /*
+     * Fill slots 12 with the correct value for the GPIO pins. 
+     */
+	for(idx = 0x90; idx <= 0x9F; idx++) {
+
+      /*
+       * Initialize the fifo so that bits 7 and 8 are on.
+       *
+       * Remember that the GPIO pins in bonzo are shifted by 4 bits to
+       * the left.  0x1800 corresponds to bits 7 and 8.
+       */
+      snd_cs46xx_pokeBA0(chip, BA0_SERBWP, 0x1800);
+      
+      /*
+       * Make sure the previous FIFO write operation has completed.
+       */
+      for(i = 0; i < 5; i++){
+        status = snd_cs46xx_peekBA0(chip, BA0_SERBST);
+
+        if( !(status & SERBST_WBSY) ) {
+          break;
+        }
+        mdelay(100);
+      }
+
+      if(status & SERBST_WBSY) {
+        snd_printk( KERN_ERR "cs46xx: cs46xx_setup_eapd_slot() " \
+                             "Failure to write the GPIO pins for slot 12.\n");
+         return -EINVAL;
+      }
+      
+      /*
+       * Write the serial port FIFO index.
+       */
+      snd_cs46xx_pokeBA0(chip, BA0_SERBAD, idx);
+      
+      /*
+       * Tell the serial port to load the new value into the FIFO location.
+       */
+      snd_cs46xx_pokeBA0(chip, BA0_SERBCM, SERBCM_WRC);
+	}
+
+	return 0;
+}
+#endif
+
 /*
  *	Crystal EAPD mode
  */
@@ -2477,6 +2579,12 @@
 			snd_ctl_notify(chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
 				       &chip->eapd_switch->id);
 	}
+
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
+    if (chip->amplifier && !old) {
+      voyetra_setup_eapd_slot(chip);
+    }
+#endif
 }
 
 
diff -Nru a/sound/pci/cs46xx/dsp_spos.c b/sound/pci/cs46xx/dsp_spos.c
--- a/sound/pci/cs46xx/dsp_spos.c	Sun Sep 29 20:24:06 2002
+++ b/sound/pci/cs46xx/dsp_spos.c	Sun Sep 29 20:24:06 2002
@@ -735,7 +735,7 @@
 
 	snd_iprintf(buffer,"\nOUTPUT_SNOOP:\n");
 	col = 0;
-	for (i = 0x1200;i < 0x1240; i += sizeof(u32),col ++) {
+	for (i = OUTPUT_SNOOP_BUFFER;i < OUTPUT_SNOOP_BUFFER + 0x40; i += sizeof(u32),col ++) {
 		if (col == 4) {
 			snd_iprintf(buffer,"\n");
 			col = 0;
@@ -748,9 +748,9 @@
 		snd_iprintf(buffer,"%08X ",readl(dst + i));
 	}
 
-	snd_iprintf(buffer,"\n...\n");
+	snd_iprintf(buffer,"\nCODEC_INPUT_BUF1: \n");
 	col = 0;
-	for (i = 0x12D0;i < 0x1310; i += sizeof(u32),col ++) {
+	for (i = CODEC_INPUT_BUF1;i < CODEC_INPUT_BUF1 + 0x40; i += sizeof(u32),col ++) {
 		if (col == 4) {
 			snd_iprintf(buffer,"\n");
 			col = 0;
@@ -763,20 +763,23 @@
 		snd_iprintf(buffer,"%08X ",readl(dst + i));
 	}
 
-	snd_iprintf(buffer,"\n");
-}
+	snd_iprintf(buffer,"\nWRITE_BACK_BUF1: \n");
+	col = 0;
+	for (i = WRITE_BACK_BUF1;i < WRITE_BACK_BUF1 + 0x40; i += sizeof(u32),col ++) {
+		if (col == 4) {
+			snd_iprintf(buffer,"\n");
+			col = 0;
+		}
 
-#if 0
-static void snd_ac97_proc_regs_read_main(ac97_t *ac97, snd_info_buffer_t * buffer, int subidx)
-{
-	int reg, val;
+		if (col == 0) {
+			snd_iprintf(buffer, "%04X ",i);
+		}
 
-	for (reg = 0; reg < 0x80; reg += 2) {
-		val = snd_ac97_read(ac97, reg);
-		snd_iprintf(buffer, "%i:%02x = %04x\n", subidx, reg, val);
+		snd_iprintf(buffer,"%08X ",readl(dst + i));
 	}
+
+	snd_iprintf(buffer,"\n");
 }
-#endif
 
 int cs46xx_dsp_proc_init (snd_card_t * card, cs46xx_t *chip)
 {
@@ -1349,9 +1352,9 @@
 
 	/* create codec in */
 	codec_in_scb = cs46xx_dsp_create_codec_in_scb(chip,"CodecInSCB",0x0010,0x00A0,
-						       MIX_SAMPLE_BUF1,
-						       CODECIN_SCB_ADDR,codec_out_scb,
-						       SCB_ON_PARENT_NEXT_SCB);
+                                                  CODEC_INPUT_BUF1,
+                                                  CODECIN_SCB_ADDR,codec_out_scb,
+                                                  SCB_ON_PARENT_NEXT_SCB);
 	if (!codec_in_scb) goto _fail_end;
   
 	/* create write back scb */
diff -Nru a/sound/pci/cs46xx/dsp_spos_scb_lib.c b/sound/pci/cs46xx/dsp_spos_scb_lib.c
--- a/sound/pci/cs46xx/dsp_spos_scb_lib.c	Sun Sep 29 20:24:05 2002
+++ b/sound/pci/cs46xx/dsp_spos_scb_lib.c	Sun Sep 29 20:24:05 2002
@@ -697,7 +697,7 @@
 			DMA_RQ_C2_AC_NONE +
 			DMA_RQ_C2_SIGNAL_DEST_PINGPONG + 
       
-			1,                                 
+			CS46XX_DSP_CAPTURE_CHANNEL,                                 
 			DMA_RQ_SD_SP_SAMPLE_ADDR + 
 			mix_buffer_addr, 
 			0x0                   
@@ -1108,7 +1108,7 @@
 
 		/* virtual channel reserved 
 		   for capture */
-		if (i == 1) continue;
+		if (i == CS46XX_DSP_CAPTURE_CHANNEL) continue;
 
 		if (ins->pcm_channels[i].active) {
 			if (!src_scb && ins->pcm_channels[i].sample_rate == sample_rate) {
diff -Nru a/sound/pci/rme96.c b/sound/pci/rme96.c
--- a/sound/pci/rme96.c	Sun Sep 29 20:24:05 2002
+++ b/sound/pci/rme96.c	Sun Sep 29 20:24:05 2002
@@ -437,7 +437,8 @@
 			      SNDRV_PCM_INFO_MMAP_VALID |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
-	formats:             SNDRV_PCM_FMTBIT_S16_LE,
+	formats:	     (SNDRV_PCM_FMTBIT_S16_LE |
+			      SNDRV_PCM_FMTBIT_S32_LE),
 	rates:	             (SNDRV_PCM_RATE_44100 | 
 			      SNDRV_PCM_RATE_48000),
 	rate_min:            44100,
@@ -461,7 +462,8 @@
 			      SNDRV_PCM_INFO_MMAP_VALID |
 			      SNDRV_PCM_INFO_INTERLEAVED |
 			      SNDRV_PCM_INFO_PAUSE),
-	formats:             SNDRV_PCM_FMTBIT_S16_LE,
+	formats:	     (SNDRV_PCM_FMTBIT_S16_LE |
+			      SNDRV_PCM_FMTBIT_S32_LE),
 	rates:	             (SNDRV_PCM_RATE_44100 | 
 			      SNDRV_PCM_RATE_48000),
 	rate_min:            44100,

===================================================================


This BitKeeper patch contains the following changesets:
1.605.2.21
## Wrapped with gzip_uu ##


begin 664 bkpatch2608
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
BA,OU9N1T^0=>['MB/X2SR9EC#45-'&F%_P7#$GX$248`````
`
end

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

