Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWGKORE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWGKORE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWGKOQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:16:53 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46354 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750829AbWGKOQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:16:35 -0400
Date: Tue, 11 Jul 2006 16:16:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill sound/oss/*_syms.c
Message-ID: <20060711141634.GR13938@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves all EXPORT_SYMBOL's from sound/oss/*_syms.c to the 
files with the actual functions.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 8 Jul 2006

 sound/oss/Makefile         |    8 ++---
 sound/oss/audio_syms.c     |   14 ----------
 sound/oss/dev_table.c      |   44 +++++++++++++++++++++++++++++++-
 sound/oss/dev_table.h      |   17 ------------
 sound/oss/dmabuf.c         |   10 ++-----
 sound/oss/midi_syms.c      |   29 ---------------------
 sound/oss/midi_synth.c     |   21 ++++++++++++++-
 sound/oss/midibuf.c        |   11 +-------
 sound/oss/sequencer.c      |   14 ++++------
 sound/oss/sequencer_syms.c |   22 ----------------
 sound/oss/sound_calls.h    |    1 
 sound/oss/sound_syms.c     |   50 -------------------------------------
 sound/oss/sound_timer.c    |    4 ++
 sound/oss/soundcard.c      |   16 +++++++----
 14 files changed, 93 insertions(+), 168 deletions(-)

--- linux-2.6.17-mm6-full/sound/oss/Makefile.old	2006-07-08 22:07:21.000000000 +0200
+++ linux-2.6.17-mm6-full/sound/oss/Makefile	2006-07-08 22:07:45.000000000 +0200
@@ -64,10 +64,10 @@
 # Declare multi-part drivers.
 
 sound-objs	:= 							\
-    dev_table.o soundcard.o sound_syms.o		\
-    audio.o audio_syms.o dmabuf.o					\
-    midi_syms.o midi_synth.o midibuf.o					\
-    sequencer.o sequencer_syms.o sound_timer.o sys_timer.o
+    dev_table.o soundcard.o 		\
+    audio.o dmabuf.o					\
+    midi_synth.o midibuf.o					\
+    sequencer.o sound_timer.o sys_timer.o
 
 pas2-objs	:= pas2_card.o pas2_midi.o pas2_mixer.o pas2_pcm.o
 sb-objs		:= sb_card.o
--- linux-2.6.17-mm6-full/sound/oss/dmabuf.c.old	2006-07-08 22:08:56.000000000 +0200
+++ linux-2.6.17-mm6-full/sound/oss/dmabuf.c	2006-07-08 22:10:31.000000000 +0200
@@ -926,6 +926,7 @@
 	sound_start_dma(dmap, physaddr, count, dma_mode);
 	return count;
 }
+EXPORT_SYMBOL(DMAbuf_start_dma);
 
 static int local_start_dma(struct audio_operations *adev, unsigned long physaddr, int count, int dma_mode)
 {
@@ -1055,6 +1056,8 @@
 		do_outputintr(dev, notify_only);
 	spin_unlock_irqrestore(&dmap->lock,flags);
 }
+EXPORT_SYMBOL(DMAbuf_outputintr);
+
 /* called with dmap->lock held in irq context */
 static void do_inputintr(int dev)
 {
@@ -1154,6 +1157,7 @@
 		do_inputintr(dev);
 	spin_unlock_irqrestore(&dmap->lock,flags);
 }
+EXPORT_SYMBOL(DMAbuf_inputintr);
 
 void DMAbuf_init(int dev, int dma1, int dma2)
 {
@@ -1162,12 +1166,6 @@
 	 * NOTE! This routine could be called several times.
 	 */
 
-	/* drag in audio_syms.o */
-	{
-		extern char audio_syms_symbol;
-		audio_syms_symbol = 0;
-	}
-
 	if (adev && adev->dmap_out == NULL) {
 		if (adev->d == NULL)
 			panic("OSS: audio_devs[%d]->d == NULL\n", dev);
--- linux-2.6.17-mm6-full/sound/oss/sound_calls.h.old	2006-07-08 22:11:16.000000000 +0200
+++ linux-2.6.17-mm6-full/sound/oss/sound_calls.h	2006-07-08 22:11:22.000000000 +0200
@@ -71,7 +71,6 @@
 int MIDIbuf_avail(int dev);
 
 void MIDIbuf_bytes_received(int dev, unsigned char *buf, int count);
-void MIDIbuf_init(void);
 
 
 /*	From soundcard.c	*/
--- linux-2.6.17-mm6-full/sound/oss/midibuf.c.old	2006-07-08 22:10:43.000000000 +0200
+++ linux-2.6.17-mm6-full/sound/oss/midibuf.c	2006-07-08 22:32:28.000000000 +0200
@@ -414,18 +414,11 @@
 }
 
 
-void MIDIbuf_init(void)
-{
-	/* drag in midi_syms.o */
-	{
-		extern char midi_syms_symbol;
-		midi_syms_symbol = 0;
-	}
-}
-
 int MIDIbuf_avail(int dev)
 {
 	if (midi_in_buf[dev])
 		return DATA_AVAIL (midi_in_buf[dev]);
 	return 0;
 }
+EXPORT_SYMBOL(MIDIbuf_avail);
+
--- linux-2.6.17-mm6-full/sound/oss/sequencer.c.old	2006-07-08 22:11:30.000000000 +0200
+++ linux-2.6.17-mm6-full/sound/oss/sequencer.c	2006-07-08 22:54:02.000000000 +0200
@@ -156,6 +156,7 @@
 	wake_up(&midi_sleeper);
 	spin_unlock_irqrestore(&lock,flags);
 }
+EXPORT_SYMBOL(seq_copy_to_input);
 
 static void sequencer_midi_input(int dev, unsigned char data)
 {
@@ -205,6 +206,7 @@
 	}
 	seq_copy_to_input(event_rec, len);
 }
+EXPORT_SYMBOL(seq_input_event);
 
 int sequencer_write(int dev, struct file *file, const char __user *buf, int count)
 {
@@ -1553,6 +1555,7 @@
 {
 	seq_startplay();
 }
+EXPORT_SYMBOL(sequencer_timer);
 
 int note_to_freq(int note_num)
 {
@@ -1586,6 +1589,7 @@
 
 	return note_freq;
 }
+EXPORT_SYMBOL(note_to_freq);
 
 unsigned long compute_finetune(unsigned long base_freq, int bend, int range,
 		 int vibrato_cents)
@@ -1639,19 +1643,12 @@
 	else
 		return (base_freq * amount) / 10000;	/* Bend up */
 }
-
+EXPORT_SYMBOL(compute_finetune);
 
 void sequencer_init(void)
 {
-	/* drag in sequencer_syms.o */
-	{
-		extern char sequencer_syms_symbol;
-		sequencer_syms_symbol = 0;
-	}
-
 	if (sequencer_ok)
 		return;
-	MIDIbuf_init();
 	queue = (unsigned char *)vmalloc(SEQ_MAX_QUEUE * EV_SZ);
 	if (queue == NULL)
 	{
@@ -1667,6 +1664,7 @@
 	}
 	sequencer_ok = 1;
 }
+EXPORT_SYMBOL(sequencer_init);
 
 void sequencer_unload(void)
 {
--- linux-2.6.17-mm6-full/sound/oss/midi_synth.c.old	2006-07-08 22:16:35.000000000 +0200
+++ linux-2.6.17-mm6-full/sound/oss/midi_synth.c	2006-07-08 22:31:48.000000000 +0200
@@ -84,6 +84,7 @@
 		  ;
 	  }
 }
+EXPORT_SYMBOL(do_midi_msg);
 
 static void
 midi_outc(int midi_dev, int data)
@@ -276,6 +277,7 @@
 		return -EINVAL;
 	}
 }
+EXPORT_SYMBOL(midi_synth_ioctl);
 
 int
 midi_synth_kill_note(int dev, int channel, int note, int velocity)
@@ -342,6 +344,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(midi_synth_kill_note);
 
 int
 midi_synth_set_instr(int dev, int channel, int instr_no)
@@ -364,6 +367,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(midi_synth_set_instr);
 
 int
 midi_synth_start_note(int dev, int channel, int note, int velocity)
@@ -405,6 +409,7 @@
 	  }
 	return 0;
 }
+EXPORT_SYMBOL(midi_synth_start_note);
 
 void
 midi_synth_reset(int dev)
@@ -412,6 +417,7 @@
 
 	leave_sysex(dev);
 }
+EXPORT_SYMBOL(midi_synth_reset);
 
 int
 midi_synth_open(int dev, int mode)
@@ -444,6 +450,7 @@
 
 	return 1;
 }
+EXPORT_SYMBOL(midi_synth_open);
 
 void
 midi_synth_close(int dev)
@@ -459,11 +466,13 @@
 
 	midi_devs[orig_dev]->close(orig_dev);
 }
+EXPORT_SYMBOL(midi_synth_close);
 
 void
 midi_synth_hw_control(int dev, unsigned char *event)
 {
 }
+EXPORT_SYMBOL(midi_synth_hw_control);
 
 int
 midi_synth_load_patch(int dev, int format, const char __user *addr,
@@ -542,11 +551,13 @@
 		midi_outc(orig_dev, 0xf7);
 	return 0;
 }
-  
+EXPORT_SYMBOL(midi_synth_load_patch);
+
 void midi_synth_panning(int dev, int channel, int pressure)
 {
 }
-  
+EXPORT_SYMBOL(midi_synth_panning);
+
 void midi_synth_aftertouch(int dev, int channel, int pressure)
 {
 	int             orig_dev = synth_devs[dev]->midi_dev;
@@ -576,6 +587,7 @@
 
 	midi_outc(orig_dev, pressure);
 }
+EXPORT_SYMBOL(midi_synth_aftertouch);
 
 void
 midi_synth_controller(int dev, int channel, int ctrl_num, int value)
@@ -604,6 +616,7 @@
 	midi_outc(orig_dev, ctrl_num);
 	midi_outc(orig_dev, value & 0x7f);
 }
+EXPORT_SYMBOL(midi_synth_controller);
 
 void
 midi_synth_bender(int dev, int channel, int value)
@@ -635,11 +648,13 @@
 	midi_outc(orig_dev, value & 0x7f);
 	midi_outc(orig_dev, (value >> 7) & 0x7f);
 }
+EXPORT_SYMBOL(midi_synth_bender);
 
 void
 midi_synth_setup_voice(int dev, int voice, int channel)
 {
 }
+EXPORT_SYMBOL(midi_synth_setup_voice);
 
 int
 midi_synth_send_sysex(int dev, unsigned char *bytes, int len)
@@ -695,3 +710,5 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(midi_synth_send_sysex);
+
--- linux-2.6.17-mm6-full/sound/oss/sound_timer.c.old	2006-07-08 22:54:12.000000000 +0200
+++ linux-2.6.17-mm6-full/sound/oss/sound_timer.c	2006-07-08 22:54:49.000000000 +0200
@@ -76,6 +76,7 @@
 	tmr_ctr = 0;
 	usecs_per_tmr = new_usecs;
 }
+EXPORT_SYMBOL(sound_timer_syncinterval);
 
 static void tmr_reset(void)
 {
@@ -300,6 +301,7 @@
 	}
 	spin_unlock_irqrestore(&lock,flags);
 }
+EXPORT_SYMBOL(sound_timer_interrupt);
 
 void  sound_timer_init(struct sound_lowlev_timer *t, char *name)
 {
@@ -321,3 +323,5 @@
 	strcpy(sound_timer.info.name, name);
 	sound_timer_devs[n] = &sound_timer;
 }
+EXPORT_SYMBOL(sound_timer_init);
+
--- linux-2.6.17-mm6-full/sound/oss/soundcard.c.old	2006-07-08 22:55:13.000000000 +0200
+++ linux-2.6.17-mm6-full/sound/oss/soundcard.c	2006-07-08 23:09:30.000000000 +0200
@@ -107,6 +107,7 @@
 		mixer_vols[n].levels[i] = levels[i];
 	return mixer_vols[n].levels;
 }
+EXPORT_SYMBOL(load_mixer_volumes);
 
 static int set_mixer_levels(void __user * arg)
 {
@@ -541,12 +542,6 @@
 	int             err;
 	int i, j;
 	
-	/* drag in sound_syms.o */
-	{
-		extern char sound_syms_symbol;
-		sound_syms_symbol = 0;
-	}
-
 #ifdef CONFIG_PCI
 	if(dmabug)
 		isa_dma_bridge_buggy = dmabug;
@@ -614,6 +609,8 @@
 module_init(oss_init);
 module_exit(oss_cleanup);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("OSS Sound subsystem");
+MODULE_AUTHOR("Hannu Savolainen, et al.");
 
 
 int sound_alloc_dma(int chn, char *deviceID)
@@ -627,6 +624,7 @@
 
 	return 0;
 }
+EXPORT_SYMBOL(sound_alloc_dma);
 
 int sound_open_dma(int chn, char *deviceID)
 {
@@ -642,6 +640,7 @@
 	dma_alloc_map[chn] = DMA_MAP_BUSY;
 	return 0;
 }
+EXPORT_SYMBOL(sound_open_dma);
 
 void sound_free_dma(int chn)
 {
@@ -652,6 +651,7 @@
 	free_dma(chn);
 	dma_alloc_map[chn] = DMA_MAP_UNAVAIL;
 }
+EXPORT_SYMBOL(sound_free_dma);
 
 void sound_close_dma(int chn)
 {
@@ -661,6 +661,7 @@
 	}
 	dma_alloc_map[chn] = DMA_MAP_FREE;
 }
+EXPORT_SYMBOL(sound_close_dma);
 
 static void do_sequencer_timer(unsigned long dummy)
 {
@@ -714,6 +715,7 @@
 	printk("\n");
 #endif
 }
+EXPORT_SYMBOL(conf_printf);
 
 void conf_printf2(char *name, int base, int irq, int dma, int dma2)
 {
@@ -734,3 +736,5 @@
 	printk("\n");
 #endif
 }
+EXPORT_SYMBOL(conf_printf2);
+
--- linux-2.6.17-mm6-full/sound/oss/dev_table.h.old	2006-07-08 22:58:16.000000000 +0200
+++ linux-2.6.17-mm6-full/sound/oss/dev_table.h	2006-07-08 22:59:43.000000000 +0200
@@ -352,22 +352,8 @@
 	void (*arm_timer)(int dev, long time);
 };
 
-#ifdef _DEV_TABLE_C_   
-struct audio_operations *audio_devs[MAX_AUDIO_DEV];
-int num_audiodevs;
-struct mixer_operations *mixer_devs[MAX_MIXER_DEV];
-int num_mixers;
-struct synth_operations *synth_devs[MAX_SYNTH_DEV+MAX_MIDI_DEV];
-int num_synths;
-struct midi_operations *midi_devs[MAX_MIDI_DEV];
-int num_midis;
-
 extern struct sound_timer_operations default_sound_timer;
-struct sound_timer_operations *sound_timer_devs[MAX_TIMER_DEV] = {
-	&default_sound_timer, NULL
-}; 
-int num_sound_timers = 1;
-#else
+
 extern struct audio_operations *audio_devs[MAX_AUDIO_DEV];
 extern int num_audiodevs;
 extern struct mixer_operations *mixer_devs[MAX_MIXER_DEV];
@@ -378,7 +364,6 @@
 extern int num_midis;
 extern struct sound_timer_operations * sound_timer_devs[MAX_TIMER_DEV];
 extern int num_sound_timers;
-#endif	/* _DEV_TABLE_C_ */
 
 extern int sound_map_buffer (int dev, struct dma_buffparms *dmap, buffmem_desc *info);
 void sound_timer_init (struct sound_lowlev_timer *t, char *name);
--- linux-2.6.17-mm6-full/sound/oss/dev_table.c.old	2006-07-08 22:58:32.000000000 +0200
+++ linux-2.6.17-mm6-full/sound/oss/dev_table.c	2006-07-08 23:08:36.000000000 +0200
@@ -13,9 +13,39 @@
 
 #include <linux/init.h>
 
-#define _DEV_TABLE_C_
 #include "sound_config.h"
 
+struct audio_operations *audio_devs[MAX_AUDIO_DEV];
+EXPORT_SYMBOL(audio_devs);
+
+int num_audiodevs;
+EXPORT_SYMBOL(num_audiodevs);
+
+struct mixer_operations *mixer_devs[MAX_MIXER_DEV];
+EXPORT_SYMBOL(mixer_devs);
+
+int num_mixers;
+EXPORT_SYMBOL(num_mixers);
+
+struct synth_operations *synth_devs[MAX_SYNTH_DEV+MAX_MIDI_DEV];
+EXPORT_SYMBOL(synth_devs);
+
+int num_synths;
+
+struct midi_operations *midi_devs[MAX_MIDI_DEV];
+EXPORT_SYMBOL(midi_devs);
+
+int num_midis;
+EXPORT_SYMBOL(num_midis);
+
+struct sound_timer_operations *sound_timer_devs[MAX_TIMER_DEV] = {
+	&default_sound_timer, NULL
+}; 
+EXPORT_SYMBOL(sound_timer_devs);
+
+int num_sound_timers = 1;
+
+
 static int sound_alloc_audiodev(void);
 
 int sound_install_audiodrv(int vers, char *name, struct audio_driver *driver,
@@ -75,6 +105,7 @@
 	audio_init_devices();
 	return num;
 }
+EXPORT_SYMBOL(sound_install_audiodrv);
 
 int sound_install_mixer(int vers, char *name, struct mixer_operations *driver,
 	int driver_size, void *devc)
@@ -113,6 +144,7 @@
 	mixer_devs[n] = op;
 	return n;
 }
+EXPORT_SYMBOL(sound_install_mixer);
 
 void sound_unload_audiodev(int dev)
 {
@@ -122,6 +154,7 @@
 		unregister_sound_dsp((dev<<4)+3);
 	}
 }
+EXPORT_SYMBOL(sound_unload_audiodev);
 
 static int sound_alloc_audiodev(void)
 { 
@@ -144,6 +177,7 @@
 		num_midis = i + 1;
 	return i;
 }
+EXPORT_SYMBOL(sound_alloc_mididev);
 
 int sound_alloc_synthdev(void)
 {
@@ -158,6 +192,7 @@
 	}
 	return -1;
 }
+EXPORT_SYMBOL(sound_alloc_synthdev);
 
 int sound_alloc_mixerdev(void)
 {
@@ -169,6 +204,7 @@
 		num_mixers = i + 1;
 	return i;
 }
+EXPORT_SYMBOL(sound_alloc_mixerdev);
 
 int sound_alloc_timerdev(void)
 {
@@ -183,6 +219,7 @@
 	}
 	return -1;
 }
+EXPORT_SYMBOL(sound_alloc_timerdev);
 
 void sound_unload_mixerdev(int dev)
 {
@@ -192,6 +229,7 @@
 		num_mixers--;
 	}
 }
+EXPORT_SYMBOL(sound_unload_mixerdev);
 
 void sound_unload_mididev(int dev)
 {
@@ -200,15 +238,19 @@
 		unregister_sound_midi((dev<<4)+2);
 	}
 }
+EXPORT_SYMBOL(sound_unload_mididev);
 
 void sound_unload_synthdev(int dev)
 {
 	if (dev != -1)
 		synth_devs[dev] = NULL;
 }
+EXPORT_SYMBOL(sound_unload_synthdev);
 
 void sound_unload_timerdev(int dev)
 {
 	if (dev != -1)
 		sound_timer_devs[dev] = NULL;
 }
+EXPORT_SYMBOL(sound_unload_timerdev);
+
--- linux-2.6.17-mm6-full/sound/oss/audio_syms.c	2006-07-06 05:50:10.000000000 +0200
+++ /dev/null	2006-04-23 00:42:46.000000000 +0200
@@ -1,14 +0,0 @@
-/*
- * Exported symbols for audio driver.
- */
-
-#include <linux/module.h>
-
-char audio_syms_symbol;
-
-#include "sound_config.h"
-#include "sound_calls.h"
-
-EXPORT_SYMBOL(DMAbuf_start_dma);
-EXPORT_SYMBOL(DMAbuf_inputintr);
-EXPORT_SYMBOL(DMAbuf_outputintr);
--- linux-2.6.17-mm6-full/sound/oss/midi_syms.c	2006-06-18 03:49:35.000000000 +0200
+++ /dev/null	2006-04-23 00:42:46.000000000 +0200
@@ -1,29 +0,0 @@
-/*
- * Exported symbols for midi driver.
- */
-
-#include <linux/module.h>
-
-char midi_syms_symbol;
-
-#include "sound_config.h"
-#define _MIDI_SYNTH_C_
-#include "midi_synth.h"
-
-EXPORT_SYMBOL(do_midi_msg);
-EXPORT_SYMBOL(midi_synth_open);
-EXPORT_SYMBOL(midi_synth_close);
-EXPORT_SYMBOL(midi_synth_ioctl);
-EXPORT_SYMBOL(midi_synth_kill_note);
-EXPORT_SYMBOL(midi_synth_start_note);
-EXPORT_SYMBOL(midi_synth_set_instr);
-EXPORT_SYMBOL(midi_synth_reset);
-EXPORT_SYMBOL(midi_synth_hw_control);
-EXPORT_SYMBOL(midi_synth_aftertouch);
-EXPORT_SYMBOL(midi_synth_controller);
-EXPORT_SYMBOL(midi_synth_panning);
-EXPORT_SYMBOL(midi_synth_setup_voice);
-EXPORT_SYMBOL(midi_synth_send_sysex);
-EXPORT_SYMBOL(midi_synth_bender);
-EXPORT_SYMBOL(midi_synth_load_patch);
-EXPORT_SYMBOL(MIDIbuf_avail);
--- linux-2.6.17-mm6-full/sound/oss/sequencer_syms.c	2006-07-06 05:50:10.000000000 +0200
+++ /dev/null	2006-04-23 00:42:46.000000000 +0200
@@ -1,22 +0,0 @@
-/*
- * Exported symbols for sequencer driver.
- */
-
-#include <linux/module.h>
-
-char sequencer_syms_symbol;
-
-#include "sound_config.h"
-#include "sound_calls.h"
-
-EXPORT_SYMBOL(note_to_freq);
-EXPORT_SYMBOL(compute_finetune);
-EXPORT_SYMBOL(seq_copy_to_input);
-EXPORT_SYMBOL(seq_input_event);
-EXPORT_SYMBOL(sequencer_init);
-EXPORT_SYMBOL(sequencer_timer);
-
-EXPORT_SYMBOL(sound_timer_init);
-EXPORT_SYMBOL(sound_timer_interrupt);
-EXPORT_SYMBOL(sound_timer_syncinterval);
-
--- linux-2.6.17-mm6-full/sound/oss/sound_syms.c	2006-06-18 03:49:35.000000000 +0200
+++ /dev/null	2006-04-23 00:42:46.000000000 +0200
@@ -1,50 +0,0 @@
-/*
- *	The sound core exports the following symbols to the rest of
- *	modulespace.
- *
- *      (C) Copyright 1997      Alan Cox, Licensed under the GNU GPL
- *
- *	Thu May 27 1999 Andrew J. Kroll <ag784@freenet..buffalo..edu>
- *	left out exported symbol... fixed
- */
-
-#include <linux/module.h>
-#include "sound_config.h"
-#include "sound_calls.h"
-
-char sound_syms_symbol;
-
-EXPORT_SYMBOL(mixer_devs);
-EXPORT_SYMBOL(audio_devs);
-EXPORT_SYMBOL(num_mixers);
-EXPORT_SYMBOL(num_audiodevs);
-
-EXPORT_SYMBOL(midi_devs);
-EXPORT_SYMBOL(num_midis);
-EXPORT_SYMBOL(synth_devs);
-
-EXPORT_SYMBOL(sound_timer_devs);
-
-EXPORT_SYMBOL(sound_install_audiodrv);
-EXPORT_SYMBOL(sound_install_mixer);
-EXPORT_SYMBOL(sound_alloc_dma);
-EXPORT_SYMBOL(sound_free_dma);
-EXPORT_SYMBOL(sound_open_dma);
-EXPORT_SYMBOL(sound_close_dma);
-EXPORT_SYMBOL(sound_alloc_mididev);
-EXPORT_SYMBOL(sound_alloc_mixerdev);
-EXPORT_SYMBOL(sound_alloc_timerdev);
-EXPORT_SYMBOL(sound_alloc_synthdev);
-EXPORT_SYMBOL(sound_unload_audiodev);
-EXPORT_SYMBOL(sound_unload_mididev);
-EXPORT_SYMBOL(sound_unload_mixerdev);
-EXPORT_SYMBOL(sound_unload_timerdev);
-EXPORT_SYMBOL(sound_unload_synthdev);
-
-EXPORT_SYMBOL(load_mixer_volumes);
-
-EXPORT_SYMBOL(conf_printf);
-EXPORT_SYMBOL(conf_printf2);
-
-MODULE_DESCRIPTION("OSS Sound subsystem");
-MODULE_AUTHOR("Hannu Savolainen, et al.");

