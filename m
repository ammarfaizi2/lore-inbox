Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVCTCPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVCTCPY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 21:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVCTCPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 21:15:24 -0500
Received: from mail.dif.dk ([193.138.115.101]:46209 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262004AbVCTCNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 21:13:07 -0500
Date: Sun, 20 Mar 2005 03:14:36 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
       Andrew Morton <akpm@osdl.org>, Jaroslav Kysela <perex@suse.cz>,
       James Courtier-Dutton <James@superbug.demon.co.uk>,
       Thomas Woller <twoller@crystal.cirrus.com>, Zach Brown <zab@zabbo.net>,
       Takashi Iwai <tiwai@suse.de>, Hannu Savolainen <hannu@opensound.com>,
       Randolph Chung <tausq@debian.org>,
       =?ISO-8859-1?Q?Juha_Yrj=F6l=E4?= <jyrjola@cc.hut.fi>,
       Abramo Bagnara <abramo@alsa-project.org>,
       Francisco Moraes <fmoraes@nc.rr.com>,
       Tjeerd Mulder <Tjeerd.Mulder@fujitsu-siemens.com>
Subject: [PATCH] remove redundant NULL checks before kfree() in sound/ and
 avoid casting pointers about to be kfree()'ed
Message-ID: <Pine.LNX.4.62.0503200236570.5507@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Checking a pointer for NULL before calling kfree() on it is redundant,
kfree() deals with NULL pointers just fine.
This patch removes such checks from sound/

This patch also makes another, but closely related, change.
It avoids casting pointers about to be kfree()'ed
 like this for example :
   static void snd_ymfpci_pcm_free_substream(snd_pcm_runtime_t *runtime)
   {
          ymfpci_pcm_t *ypcm = runtime->private_data;
   
          kfree(ypcm);
          kfree(runtime->private_data);
   }
There's no reason for this, we can just as well simply 
kfree(runtime->private_data); and save the creation of a local variable 
and an assignment/cast. Where such code was found that change was made.

Since these are fairly trivial changes (and the same changes are made
everywhere) I've just made a single patch for all modified files and CC
all authors/maintainers of those files I could find.
If spliting this into one patch pr file is prefered, then I can easily do 
that as well.

I don't have access to all these soundcards, so the patch is only compile 
tested, but it should be simple enough to verify by visual inspection that 
these changes are correct.

These files are modified by this patch : 
	sound/core/seq/oss/seq_oss_synth.c
	sound/core/seq/seq_dummy.c
	sound/core/timer.c
	sound/drivers/vx/vx_pcm.c
	sound/i2c/tea6330t.c
	sound/isa/gus/gus_pcm.c
	sound/oss/ad1848.c
	sound/oss/ad1889.c
	sound/oss/dmasound/dmasound_awacs.c
	sound/oss/emu10k1/midi.c
	sound/oss/emu10k1/passthrough.c
	sound/oss/maestro.c
	sound/oss/mpu401.c
	sound/oss/sb_common.c
	sound/pci/ca0106/ca0106_main.c
	sound/pci/cs46xx/cs46xx_lib.c
	sound/pci/emu10k1/emu10k1x.c
	sound/pci/emu10k1/emupcm.c
	sound/pci/via82xx.c
	sound/pci/via82xx_modem.c
	sound/pci/ymfpci/ymfpci_main.c
	sound/pcmcia/vx/vx_entry.c
	sound/synth/emux/emux_effect.c
	sound/usb/usbaudio.c
	sound/usb/usbmixer.c
	sound/usb/usx2y/usbusx2yaudio.c

(Please keep me on CC if you reply since I'm not subscribed to all the 
lists being CC'ed)


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-mm4-orig/sound/core/seq/oss/seq_oss_synth.c	2005-03-16 15:45:42.000000000 +0100
+++ linux-2.6.11-mm4/sound/core/seq/oss/seq_oss_synth.c	2005-03-20 01:23:26.000000000 +0100
@@ -325,14 +325,10 @@ snd_seq_oss_synth_cleanup(seq_oss_devinf
 			}
 			snd_use_lock_free(&rec->use_lock);
 		}
-		if (info->sysex) {
-			kfree(info->sysex);
-			info->sysex = NULL;
-		}
-		if (info->ch) {
-			kfree(info->ch);
-			info->ch = NULL;
-		}
+		kfree(info->sysex);
+		info->sysex = NULL;
+		kfree(info->ch);
+		info->ch = NULL;
 	}
 	dp->synth_opened = 0;
 	dp->max_synthdev = 0;
@@ -418,14 +414,10 @@ snd_seq_oss_synth_reset(seq_oss_devinfo_
 					  dp->file_mode) < 0) {
 			midi_synth_dev.opened--;
 			info->opened = 0;
-			if (info->sysex) {
-				kfree(info->sysex);
-				info->sysex = NULL;
-			}
-			if (info->ch) {
-				kfree(info->ch);
-				info->ch = NULL;
-			}
+			kfree(info->sysex);
+			info->sysex = NULL;
+			kfree(info->ch);
+			info->ch = NULL;
 		}
 		return;
 	}
--- linux-2.6.11-mm4-orig/sound/core/seq/seq_dummy.c	2005-03-16 15:45:42.000000000 +0100
+++ linux-2.6.11-mm4/sound/core/seq/seq_dummy.c	2005-03-20 01:37:35.000000000 +0100
@@ -140,10 +140,7 @@ dummy_input(snd_seq_event_t *ev, int dir
 static void
 dummy_free(void *private_data)
 {
-	snd_seq_dummy_port_t *p;
-
-	p = private_data;
-	kfree(p);
+	kfree(private_data);
 }
 
 /*
--- linux-2.6.11-mm4-orig/sound/core/timer.c	2005-03-16 15:45:42.000000000 +0100
+++ linux-2.6.11-mm4/sound/core/timer.c	2005-03-20 01:30:43.000000000 +0100
@@ -1456,14 +1456,10 @@ static int snd_timer_user_tselect(struct
 	if ((err = snd_timer_open(&tu->timeri, str, &tselect.id, current->pid)) < 0)
 		return err;
 
-	if (tu->queue) {
-		kfree(tu->queue);
-		tu->queue = NULL;
-	}
-	if (tu->tqueue) {
-		kfree(tu->tqueue);
-		tu->tqueue = NULL;
-	}
+	kfree(tu->queue);
+	tu->queue = NULL;
+	kfree(tu->tqueue);
+	tu->tqueue = NULL;
 	if (tu->tread) {
 		tu->tqueue = (snd_timer_tread_t *)kmalloc(tu->queue_size * sizeof(snd_timer_tread_t), GFP_KERNEL);
 		if (tu->tqueue == NULL) {
--- linux-2.6.11-mm4-orig/sound/drivers/vx/vx_pcm.c	2005-03-02 08:37:48.000000000 +0100
+++ linux-2.6.11-mm4/sound/drivers/vx/vx_pcm.c	2005-03-20 01:35:23.000000000 +0100
@@ -1264,14 +1264,10 @@ static void snd_vx_pcm_free(snd_pcm_t *p
 {
 	vx_core_t *chip = pcm->private_data;
 	chip->pcm[pcm->device] = NULL;
-	if (chip->playback_pipes) {
-		kfree(chip->playback_pipes);
-		chip->playback_pipes = NULL;
-	}
-	if (chip->capture_pipes) {
-		kfree(chip->capture_pipes);
-		chip->capture_pipes = NULL;
-	}
+	kfree(chip->playback_pipes);
+	chip->playback_pipes = NULL;
+	kfree(chip->capture_pipes);
+	chip->capture_pipes = NULL;
 }
 
 /*
--- linux-2.6.11-mm4-orig/sound/i2c/tea6330t.c	2005-03-02 08:38:09.000000000 +0100
+++ linux-2.6.11-mm4/sound/i2c/tea6330t.c	2005-03-20 01:40:03.000000000 +0100
@@ -266,8 +266,7 @@ TEA6330T_TREBLE("Tone Control - Treble",
 
 static void snd_tea6330_free(snd_i2c_device_t *device)
 {
-	tea6330t_t *tea = device->private_data;
-	kfree(tea);
+	kfree(device->private_data);
 }
                                         
 int snd_tea6330t_update_mixer(snd_card_t * card,
--- linux-2.6.11-mm4-orig/sound/isa/gus/gus_pcm.c	2005-03-16 15:45:42.000000000 +0100
+++ linux-2.6.11-mm4/sound/isa/gus/gus_pcm.c	2005-03-20 01:44:27.000000000 +0100
@@ -656,8 +656,7 @@ static snd_pcm_hardware_t snd_gf1_pcm_ca
 
 static void snd_gf1_pcm_playback_free(snd_pcm_runtime_t *runtime)
 {
-	gus_pcm_private_t * pcmp = runtime->private_data;
-	kfree(pcmp);
+	kfree(runtime->private_data);
 }
 
 static int snd_gf1_pcm_playback_open(snd_pcm_substream_t *substream)
--- linux-2.6.11-mm4-orig/sound/oss/ad1848.c	2005-03-02 08:38:12.000000000 +0100
+++ linux-2.6.11-mm4/sound/oss/ad1848.c	2005-03-20 01:47:37.000000000 +0100
@@ -2178,8 +2178,7 @@ void ad1848_unload(int io_base, int irq,
 		
 	if (devc != NULL)
 	{
-		if(audio_devs[dev]->portc!=NULL)
-			kfree(audio_devs[dev]->portc);
+		kfree(audio_devs[dev]->portc);
 		release_region(devc->base, 4);
 
 		if (!share_dma)
--- linux-2.6.11-mm4-orig/sound/oss/ad1889.c	2005-03-02 08:37:55.000000000 +0100
+++ linux-2.6.11-mm4/sound/oss/ad1889.c	2005-03-20 01:48:11.000000000 +0100
@@ -277,8 +277,7 @@ static void ad1889_free_dev(ad1889_dev_t
 
 	for (j = 0; j < AD_MAX_STATES; j++) {
 		dmabuf = &dev->state[j].dmabuf;
-		if (dmabuf->rawbuf != NULL) 
-			kfree(dmabuf->rawbuf);
+		kfree(dmabuf->rawbuf);
 	}
 
 	kfree(dev);
--- linux-2.6.11-mm4-orig/sound/oss/dmasound/dmasound_awacs.c	2005-03-02 08:37:55.000000000 +0100
+++ linux-2.6.11-mm4/sound/oss/dmasound/dmasound_awacs.c	2005-03-20 01:52:18.000000000 +0100
@@ -671,14 +671,10 @@ static void PMacIrqCleanup(void)
 	release_OF_resource(awacs_node, 1);
 	release_OF_resource(awacs_node, 2);
 
-	if (awacs_tx_cmd_space)
-		kfree(awacs_tx_cmd_space);
-	if (awacs_rx_cmd_space)
-		kfree(awacs_rx_cmd_space);
-	if (beep_dbdma_cmd_space)
-		kfree(beep_dbdma_cmd_space);
-	if (beep_buf)
-		kfree(beep_buf);
+	kfree(awacs_tx_cmd_space);
+	kfree(awacs_rx_cmd_space);
+	kfree(beep_dbdma_cmd_space);
+	kfree(beep_buf);
 #ifdef CONFIG_PMAC_PBOOK
 	pmu_unregister_sleep_notifier(&awacs_sleep_notifier);
 #endif
@@ -2301,8 +2297,7 @@ if (count <= 0)
 #endif
 
 	if ((write_sq.max_count + 1) > number_of_tx_cmd_buffers) {
-		if (awacs_tx_cmd_space)
-			kfree(awacs_tx_cmd_space);
+		kfree(awacs_tx_cmd_space);
 		number_of_tx_cmd_buffers = 0;
 
 		/* we need nbufs + 1 (for the loop) and we should request + 1
@@ -2360,8 +2355,7 @@ if (count <= 0)
 #endif
 
 	if ((read_sq.max_count+1) > number_of_rx_cmd_buffers ) {
-		if (awacs_rx_cmd_space)
-			kfree(awacs_rx_cmd_space);
+		kfree(awacs_rx_cmd_space);
 		number_of_rx_cmd_buffers = 0;
 
 		/* we need nbufs + 1 (for the loop) and we should request + 1 again
@@ -2805,7 +2799,7 @@ __init setup_beep(void)
 	beep_buf = (short *) kmalloc(BEEP_BUFLEN * 4, GFP_KERNEL);
 	if (beep_buf == NULL) {
 		printk(KERN_ERR "dmasound_pmac: no memory for beep buffer\n");
-		if( beep_dbdma_cmd_space ) kfree(beep_dbdma_cmd_space) ;
+		kfree(beep_dbdma_cmd_space) ;
 		return -ENOMEM ;
 	}
 	return 0 ;
--- linux-2.6.11-mm4-orig/sound/oss/emu10k1/midi.c	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.11-mm4/sound/oss/emu10k1/midi.c	2005-03-20 01:55:27.000000000 +0100
@@ -523,10 +523,8 @@ void emu10k1_seq_midi_close(int dev)
 	card = midi_devs[dev]->devc;
 	emu10k1_mpuout_close(card);
 
-	if (card->seq_mididev) {
-		kfree(card->seq_mididev);
-		card->seq_mididev = NULL;
-	}
+	kfree(card->seq_mididev);
+	card->seq_mididev = NULL;
 }
 
 int emu10k1_seq_midi_out(int dev, unsigned char midi_byte)
--- linux-2.6.11-mm4-orig/sound/oss/emu10k1/passthrough.c	2005-03-02 08:38:08.000000000 +0100
+++ linux-2.6.11-mm4/sound/oss/emu10k1/passthrough.c	2005-03-20 01:55:52.000000000 +0100
@@ -213,8 +213,7 @@ void emu10k1_pt_stop(struct emu10k1_card
 				sblive_writeptr(card, SPCS0 + i, 0, pt->old_spcs[i]);
 		}
 		pt->state = PT_STATE_INACTIVE;
-		if(pt->buf)
-			kfree(pt->buf);
+		kfree(pt->buf);
 	}
 }
 
--- linux-2.6.11-mm4-orig/sound/oss/maestro.c	2005-03-02 08:38:25.000000000 +0100
+++ linux-2.6.11-mm4/sound/oss/maestro.c	2005-03-20 01:57:40.000000000 +0100
@@ -2356,7 +2356,7 @@ ess_read(struct file *file, char __user 
 	}
 
 rec_return_free:
-	if(combbuf) kfree(combbuf);
+	kfree(combbuf);
 	return ret;
 }
 
--- linux-2.6.11-mm4-orig/sound/oss/mpu401.c	2005-03-02 08:38:38.000000000 +0100
+++ linux-2.6.11-mm4/sound/oss/mpu401.c	2005-03-20 01:58:06.000000000 +0100
@@ -1240,8 +1240,7 @@ void unload_mpu401(struct address_info *
 		p=mpu401_synth_operations[n];
 		sound_unload_mididev(n);
 		sound_unload_timerdev(hw_config->slots[2]);
-		if(p)
-			kfree(p);
+		kfree(p);
 	}
 }
 
--- linux-2.6.11-mm4-orig/sound/oss/sb_common.c	2005-03-02 08:37:47.000000000 +0100
+++ linux-2.6.11-mm4/sound/oss/sb_common.c	2005-03-20 01:59:29.000000000 +0100
@@ -915,8 +915,8 @@ void sb_dsp_unload(struct address_info *
 	}
 	else
 		release_region(hw_config->io_base, 16);
-	if(detected_devc)
-		kfree(detected_devc);
+
+	kfree(detected_devc);
 }
 
 /*
--- linux-2.6.11-mm4-orig/sound/pci/ca0106/ca0106_main.c	2005-03-16 15:45:43.000000000 +0100
+++ linux-2.6.11-mm4/sound/pci/ca0106/ca0106_main.c	2005-03-20 02:03:25.000000000 +0100
@@ -259,11 +259,7 @@ static void snd_ca0106_intr_enable(ca010
 
 static void snd_ca0106_pcm_free_substream(snd_pcm_runtime_t *runtime)
 {
-	ca0106_pcm_t *epcm = runtime->private_data;
-  
-	if (epcm) {
-		kfree(epcm);
-	}
+	kfree(runtime->private_data);
 }
 
 /* open_playback callback */
--- linux-2.6.11-mm4-orig/sound/pci/cs46xx/cs46xx_lib.c	2005-03-16 15:45:43.000000000 +0100
+++ linux-2.6.11-mm4/sound/pci/cs46xx/cs46xx_lib.c	2005-03-20 02:04:26.000000000 +0100
@@ -1300,8 +1300,7 @@ static snd_pcm_hw_constraint_list_t hw_c
 
 static void snd_cs46xx_pcm_free_substream(snd_pcm_runtime_t *runtime)
 {
-	cs46xx_pcm_t * cpcm = runtime->private_data;
-	kfree(cpcm);
+	kfree(runtime->private_data);
 }
 
 static int _cs46xx_playback_open_channel (snd_pcm_substream_t * substream,int pcm_channel_id)
--- linux-2.6.11-mm4-orig/sound/pci/emu10k1/emu10k1x.c	2005-03-16 15:45:43.000000000 +0100
+++ linux-2.6.11-mm4/sound/pci/emu10k1/emu10k1x.c	2005-03-20 02:05:23.000000000 +0100
@@ -361,10 +361,7 @@ static void snd_emu10k1x_gpio_write(emu1
 
 static void snd_emu10k1x_pcm_free_substream(snd_pcm_runtime_t *runtime)
 {
-	emu10k1x_pcm_t *epcm = runtime->private_data;
-  
-	if (epcm)
-		kfree(epcm);
+	kfree(runtime->private_data);
 }
 
 static void snd_emu10k1x_pcm_interrupt(emu10k1x_t *emu, emu10k1x_voice_t *voice)
--- linux-2.6.11-mm4-orig/sound/pci/emu10k1/emupcm.c	2005-03-16 15:45:43.000000000 +0100
+++ linux-2.6.11-mm4/sound/pci/emu10k1/emupcm.c	2005-03-20 02:06:42.000000000 +0100
@@ -987,9 +987,7 @@ static void snd_emu10k1_pcm_efx_mixer_no
 
 static void snd_emu10k1_pcm_free_substream(snd_pcm_runtime_t *runtime)
 {
-	emu10k1_pcm_t *epcm = runtime->private_data;
-
-	kfree(epcm);
+	kfree(runtime->private_data);
 }
 
 static int snd_emu10k1_efx_playback_close(snd_pcm_substream_t * substream)
--- linux-2.6.11-mm4-orig/sound/pci/via82xx.c	2005-03-16 15:45:43.000000000 +0100
+++ linux-2.6.11-mm4/sound/pci/via82xx.c	2005-03-20 02:12:07.000000000 +0100
@@ -489,10 +489,8 @@ static int clean_via_table(viadev_t *dev
 		snd_dma_free_pages(&dev->table);
 		dev->table.area = NULL;
 	}
-	if (dev->idx_table) {
-		kfree(dev->idx_table);
-		dev->idx_table = NULL;
-	}
+	kfree(dev->idx_table);
+	dev->idx_table = NULL;
 	return 0;
 }
 
--- linux-2.6.11-mm4-orig/sound/pci/via82xx_modem.c	2005-03-16 15:45:43.000000000 +0100
+++ linux-2.6.11-mm4/sound/pci/via82xx_modem.c	2005-03-20 02:12:26.000000000 +0100
@@ -352,10 +352,8 @@ static int clean_via_table(viadev_t *dev
 		snd_dma_free_pages(&dev->table);
 		dev->table.area = NULL;
 	}
-	if (dev->idx_table) {
-		kfree(dev->idx_table);
-		dev->idx_table = NULL;
-	}
+	kfree(dev->idx_table);
+	dev->idx_table = NULL;
 	return 0;
 }
 
--- linux-2.6.11-mm4-orig/sound/pci/ymfpci/ymfpci_main.c	2005-03-16 15:45:43.000000000 +0100
+++ linux-2.6.11-mm4/sound/pci/ymfpci/ymfpci_main.c	2005-03-20 02:13:02.000000000 +0100
@@ -829,9 +829,7 @@ static snd_pcm_hardware_t snd_ymfpci_cap
 
 static void snd_ymfpci_pcm_free_substream(snd_pcm_runtime_t *runtime)
 {
-	ymfpci_pcm_t *ypcm = runtime->private_data;
-	
-	kfree(ypcm);
+	kfree(runtime->private_data);
 }
 
 static int snd_ymfpci_playback_open_1(snd_pcm_substream_t * substream)
--- linux-2.6.11-mm4-orig/sound/pcmcia/vx/vx_entry.c	2005-03-16 15:45:43.000000000 +0100
+++ linux-2.6.11-mm4/sound/pcmcia/vx/vx_entry.c	2005-03-20 02:13:43.000000000 +0100
@@ -68,8 +68,7 @@ static int snd_vxpocket_free(vx_core_t *
 	if (hw)
 		hw->card_list[vxp->index] = NULL;
 	chip->card = NULL;
-	if (chip->dev)
-		kfree(chip->dev);
+	kfree(chip->dev);
 
 	snd_vx_free_firmware(chip);
 	kfree(chip);
--- linux-2.6.11-mm4-orig/sound/synth/emux/emux_effect.c	2005-03-02 08:38:07.000000000 +0100
+++ linux-2.6.11-mm4/sound/synth/emux/emux_effect.c	2005-03-20 02:16:18.000000000 +0100
@@ -291,10 +291,8 @@ snd_emux_create_effect(snd_emux_port_t *
 void
 snd_emux_delete_effect(snd_emux_port_t *p)
 {
-	if (p->effect) {
-		kfree(p->effect);
-		p->effect = NULL;
-	}
+	kfree(p->effect);
+	p->effect = NULL;
 }
 
 void
--- linux-2.6.11-mm4-orig/sound/usb/usbaudio.c	2005-03-16 15:45:43.000000000 +0100
+++ linux-2.6.11-mm4/sound/usb/usbaudio.c	2005-03-20 02:17:50.000000000 +0100
@@ -892,10 +892,8 @@ static void release_urb_ctx(snd_urb_ctx_
 		usb_free_urb(u->urb);
 		u->urb = NULL;
 	}
-	if (u->buf) {
-		kfree(u->buf);
-		u->buf = NULL;
-	}
+	kfree(u->buf);
+	u->buf = NULL;
 }
 
 /*
@@ -913,10 +911,8 @@ static void release_substream_urbs(snd_u
 		release_urb_ctx(&subs->dataurb[i]);
 	for (i = 0; i < SYNC_URBS; i++)
 		release_urb_ctx(&subs->syncurb[i]);
-	if (subs->tmpbuf) {
-		kfree(subs->tmpbuf);
-		subs->tmpbuf = NULL;
-	}
+	kfree(subs->tmpbuf);
+	subs->tmpbuf = NULL;
 	subs->nurbs = 0;
 }
 
--- linux-2.6.11-mm4-orig/sound/usb/usbmixer.c	2005-03-16 15:45:43.000000000 +0100
+++ linux-2.6.11-mm4/sound/usb/usbmixer.c	2005-03-20 02:19:25.000000000 +0100
@@ -572,10 +572,8 @@ static struct usb_feature_control_info a
 /* private_free callback */
 static void usb_mixer_elem_free(snd_kcontrol_t *kctl)
 {
-	if (kctl->private_data) {
-		kfree(kctl->private_data);
-		kctl->private_data = NULL;
-	}
+	kfree(kctl->private_data);
+	kctl->private_data = NULL;
 }
 
 
--- linux-2.6.11-mm4-orig/sound/usb/usx2y/usbusx2yaudio.c	2005-03-16 15:45:43.000000000 +0100
+++ linux-2.6.11-mm4/sound/usb/usx2y/usbusx2yaudio.c	2005-03-20 02:20:13.000000000 +0100
@@ -401,10 +401,8 @@ static void usX2Y_urbs_release(snd_usX2Y
 	for (i = 0; i < NRURBS; i++)
 		usX2Y_urb_release(subs->urb + i, subs != subs->usX2Y->subs[SNDRV_PCM_STREAM_PLAYBACK]);
 
-	if (subs->tmpbuf) {
-		kfree(subs->tmpbuf);
-		subs->tmpbuf = NULL;
-	}
+	kfree(subs->tmpbuf);
+	subs->tmpbuf = NULL;
 }
 /*
  * initialize a substream's urbs



