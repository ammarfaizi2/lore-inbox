Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTDHA3q (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 20:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263887AbTDHA3T (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 20:29:19 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20353
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263752AbTDGXWC (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:22:02 -0400
Date: Tue, 8 Apr 2003 01:40:53 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080040.h380erPv009318@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix modular gus shared lock
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/gus_midi.c linux-2.5.67-ac1/sound/oss/gus_midi.c
--- linux-2.5.67/sound/oss/gus_midi.c	2003-03-26 20:00:02.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/gus_midi.c	2003-04-03 23:45:12.000000000 +0100
@@ -26,7 +26,6 @@
 static int      my_dev;
 static int      output_used = 0;
 static volatile unsigned char gus_midi_control;
-static spinlock_t lock=SPIN_LOCK_UNLOCKED;
 static void     (*midi_input_intr) (int dev, unsigned char data);
 
 static unsigned char tmp_queue[256];
@@ -35,6 +34,7 @@
 static volatile unsigned char qhead, qtail;
 extern int      gus_base, gus_irq, gus_dma;
 extern int     *gus_osp;
+extern spinlock_t gus_lock;
 
 static int GUS_MIDI_STATUS(void)
 {
@@ -76,7 +76,7 @@
 
 	output_used = 1;
 
-	spin_lock_irqsave(&lock, flags);
+	spin_lock_irqsave(&gus_lock, flags);
 
 	if (GUS_MIDI_STATUS() & MIDI_XMIT_EMPTY)
 	{
@@ -92,7 +92,7 @@
 		outb((gus_midi_control), u_MidiControl);
 	}
 
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 	return ok;
 }
 
@@ -113,14 +113,14 @@
 	/*
 	 * Drain the local queue first
 	 */
-	spin_lock_irqsave(&lock, flags);
+	spin_lock_irqsave(&gus_lock, flags);
 
 	while (qlen && dump_to_midi(tmp_queue[qhead]))
 	{
 		qlen--;
 		qhead++;
 	}
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 
 	/*
 	 *	Output the byte if the local queue is empty.
@@ -140,13 +140,13 @@
 		return 0;	/*
 				 * Local queue full
 				 */
-	spin_lock_irqsave(&lock, flags);
+	spin_lock_irqsave(&gus_lock, flags);
 
 	tmp_queue[qtail] = midi_byte;
 	qlen++;
 	qtail++;
 
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 	return 1;
 }
 
@@ -171,14 +171,14 @@
 	if (!output_used)
 		return 0;
 
-	spin_lock_irqsave(&lock, flags);
+	spin_lock_irqsave(&gus_lock, flags);
 
 	if (qlen && dump_to_midi(tmp_queue[qhead]))
 	{
 		qlen--;
 		qhead++;
 	}
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 	return (qlen > 0) || !(GUS_MIDI_STATUS() & MIDI_XMIT_EMPTY);
 }
 
@@ -188,17 +188,17 @@
 
 static struct midi_operations gus_midi_operations =
 {
-	owner:		THIS_MODULE,
-	info:		{"Gravis UltraSound Midi", 0, 0, SNDCARD_GUS},
-	converter:	&std_midi_synth,
-	in_info:	{0},
-	open:		gus_midi_open,
-	close:		gus_midi_close,
-	outputc:	gus_midi_out,
-	start_read:	gus_midi_start_read,
-	end_read:	gus_midi_end_read,
-	kick:		gus_midi_kick,
-	buffer_status:	gus_midi_buffer_status,
+	.owner		= THIS_MODULE,
+	.info		= {"Gravis UltraSound Midi", 0, 0, SNDCARD_GUS},
+	.converter	= &std_midi_synth,
+	.in_info	= {0},
+	.open		= gus_midi_open,
+	.close		= gus_midi_close,
+	.outputc	= gus_midi_out,
+	.start_read	= gus_midi_start_read,
+	.end_read	= gus_midi_end_read,
+	.kick		= gus_midi_kick,
+	.buffer_status	= gus_midi_buffer_status,
 };
 
 void __init gus_midi_init(struct address_info *hw_config)
@@ -224,7 +224,7 @@
 	volatile unsigned char stat, data;
 	int timeout = 10;
 
-	spin_lock(&lock);
+	spin_lock(&gus_lock);
 
 	while (timeout-- > 0 && (stat = GUS_MIDI_STATUS()) & (MIDI_RCV_FULL | MIDI_XMIT_EMPTY))
 	{
@@ -252,5 +252,5 @@
 			}
 		}
 	}
-	spin_unlock(&lock);
+	spin_unlock(&gus_lock);
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/oss/gus_wave.c linux-2.5.67-ac1/sound/oss/gus_wave.c
--- linux-2.5.67/sound/oss/gus_wave.c	2003-02-10 18:38:05.000000000 +0000
+++ linux-2.5.67-ac1/sound/oss/gus_wave.c	2003-04-03 23:45:12.000000000 +0100
@@ -139,7 +139,7 @@
 static unsigned long pcm_current_buf;
 static int      pcm_current_count;
 static int      pcm_current_intrflag;
-static spinlock_t lock=SPIN_LOCK_UNLOCKED;
+spinlock_t gus_lock=SPIN_LOCK_UNLOCKED;
 
 extern int     *gus_osp;
 
@@ -469,7 +469,7 @@
 {
 	unsigned long   flags;
 
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	gus_select_voice(voice);
 	gus_voice_volume(0);
 	gus_voice_off();
@@ -478,7 +478,7 @@
 	gus_write8(0x0d, 0x03);	/* Ramping off */
 	voice_alloc->map[voice] = 0;
 	voice_alloc->alloc_times[voice] = 0;
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 
 }
 
@@ -512,10 +512,10 @@
 
 	if (voices[voice].mode & WAVE_SUSTAIN_ON && voices[voice].env_phase == 2)
 	{
-		spin_lock_irqsave(&lock,flags);
+		spin_lock_irqsave(&gus_lock,flags);
 		gus_select_voice(voice);
 		gus_rampoff();
-		spin_unlock_irqrestore(&lock,flags);
+		spin_unlock_irqrestore(&gus_lock,flags);
 		return;
 		/*
 		 * Sustain phase begins. Continue envelope after receiving note off.
@@ -533,7 +533,7 @@
 	vol = voices[voice].initial_volume * voices[voice].env_offset[phase] / 255;
 	rate = voices[voice].env_rate[phase];
 
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	gus_select_voice(voice);
 
 	gus_voice_volume(prev_vol);
@@ -545,7 +545,7 @@
 
 	if (((vol - prev_vol) / 64) == 0)	/* No significant volume change */
 	{
-		spin_unlock_irqrestore(&lock,flags);
+		spin_unlock_irqrestore(&gus_lock,flags);
 		step_envelope(voice);		/* Continue the envelope on the next step */
 		return;
 	}
@@ -564,7 +564,7 @@
 		gus_rampon(0x60);	/* Decreasing volume, with IRQ */
 	}
 	voices[voice].current_volume = vol;
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 }
 
 static void init_envelope(int voice)
@@ -595,14 +595,14 @@
 	int instr_no = sample_map[voice], is16bits;
 	long int flags;
 
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	gus_select_voice(voice);
 
 	if (instr_no < 0 || instr_no > MAX_SAMPLE)
 	{
 		gus_write8(0x00, 0x03);	/* Hard stop */
 		voice_alloc->map[voice] = 0;
-		spin_unlock_irqrestore(&lock,flags);
+		spin_unlock_irqrestore(&gus_lock,flags);
 		return;
 	}
 	is16bits = (samples[instr_no].mode & WAVE_16_BITS) ? 1 : 0;	/* 8 or 16 bits */
@@ -610,7 +610,7 @@
 	if (voices[voice].mode & WAVE_ENVELOPES)
 	{
 		start_release(voice);
-		spin_unlock_irqrestore(&lock,flags);
+		spin_unlock_irqrestore(&gus_lock,flags);
 		return;
 	}
 	/*
@@ -621,14 +621,14 @@
 		gus_voice_off();
 		gus_rampoff();
 		gus_voice_init(voice);
-		spin_unlock_irqrestore(&lock,flags);
+		spin_unlock_irqrestore(&gus_lock,flags);
 		return;
 	}
 	gus_ramp_range(65, 4030);
 	gus_ramp_rate(2, 4);
 	gus_rampon(0x40 | 0x20);	/* Down, once, with IRQ */
 	voices[voice].volume_irq_mode = VMODE_HALT;
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 }
 
 static void gus_reset(void)
@@ -660,7 +660,7 @@
 		0, 1, 0, 2, 0, 3, 4, 5
 	};
 
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	gus_write8(0x4c, 0);	/* Reset GF1 */
 	gus_delay();
 	gus_delay();
@@ -799,7 +799,7 @@
 
 	if (iw_mode)
 		gus_write8(0x19, gus_read8(0x19) | 0x01);
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 }
 
 
@@ -1108,16 +1108,16 @@
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	/* voice_alloc->map[voice] = 0xffff; */
 	if (voices[voice].volume_irq_mode == VMODE_START_NOTE)
 	{
 		voices[voice].kill_pending = 1;
-		spin_unlock_irqrestore(&lock,flags);
+		spin_unlock_irqrestore(&gus_lock,flags);
 	}
 	else
 	{
-		spin_unlock_irqrestore(&lock,flags);
+		spin_unlock_irqrestore(&gus_lock,flags);
 		gus_voice_fade(voice);
 	}
 
@@ -1175,7 +1175,7 @@
 	compute_volume(voice, volume);
 	voices[voice].current_volume = voices[voice].initial_volume;
 
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	/*
 	 * CAUTION! Interrupts disabled. Enable them before returning
 	 */
@@ -1189,7 +1189,7 @@
 	{
 		gus_rampoff();
 		gus_voice_volume(target);
-		spin_unlock_irqrestore(&lock,flags);
+		spin_unlock_irqrestore(&gus_lock,flags);
 		return;
 	}
 	if (ramp_time == FAST_RAMP)
@@ -1202,7 +1202,7 @@
 	{
 		gus_rampoff();
 		gus_voice_volume(target);
-		spin_unlock_irqrestore(&lock,flags);
+		spin_unlock_irqrestore(&gus_lock,flags);
 		return;
 	}
 	if (target > curr)
@@ -1220,7 +1220,7 @@
 		gus_ramp_range(target, curr);
 		gus_rampon(0x40);	/* Ramp down, once, no irq */
 	}
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 }
 
 static void dynamic_volume_change(int voice)
@@ -1228,10 +1228,10 @@
 	unsigned char status;
 	unsigned long flags;
 
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	gus_select_voice(voice);
 	status = gus_read8(0x00);	/* Get voice status */
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 
 	if (status & 0x03)
 		return;		/* Voice was not running */
@@ -1246,10 +1246,10 @@
 	 * Voice is running and has envelopes.
 	 */
 
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	gus_select_voice(voice);
 	status = gus_read8(0x0d);	/* Ramping status */
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 
 	if (status & 0x03)	/* Sustain phase? */
 	{
@@ -1281,10 +1281,10 @@
 				freq = compute_finetune(voices[voice].orig_freq, value, voices[voice].bender_range, 0);
 				voices[voice].current_freq = freq;
 
-				spin_lock_irqsave(&lock,flags);
+				spin_lock_irqsave(&gus_lock,flags);
 				gus_select_voice(voice);
 				gus_voice_freq(freq);
-				spin_unlock_irqrestore(&lock,flags);
+				spin_unlock_irqrestore(&gus_lock,flags);
 			}
 			break;
 
@@ -1441,12 +1441,12 @@
 			((sample_ptrs[sample] + samples[sample].len) / GUS_BANK_SIZE))
 				printk(KERN_ERR "GUS: Sample address error\n");
 	}
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	gus_select_voice(voice);
 	gus_voice_off();
 	gus_rampoff();
 
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 
 	if (voices[voice].mode & WAVE_ENVELOPES)
 	{
@@ -1458,7 +1458,7 @@
 		compute_and_set_volume(voice, volume, 0);
 	}
 
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	gus_select_voice(voice);
 
 	if (samples[sample].mode & WAVE_LOOP_BACK)
@@ -1498,7 +1498,7 @@
 	gus_voice_freq(freq);
 	gus_voice_balance(pan);
 	gus_voice_on(mode);
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 
 	return 0;
 }
@@ -1515,7 +1515,7 @@
 	int mode;
 	int ret_val = 0;
 
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	if (note_num == 255)
 	{
 		if (voices[voice].volume_irq_mode == VMODE_START_NOTE)
@@ -1541,10 +1541,10 @@
 
 		if (voices[voice].sample_pending >= 0)
 		{
-			spin_unlock_irqrestore(&lock,flags);	/* Run temporarily with interrupts enabled */
+			spin_unlock_irqrestore(&gus_lock,flags);	/* Run temporarily with interrupts enabled */
 			guswave_set_instr(voices[voice].dev_pending, voice, voices[voice].sample_pending);
 			voices[voice].sample_pending = -1;
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);	/* Reselect the voice (just to be sure) */
 		}
 		if ((mode & 0x01) || (int) ((gus_read16(0x09) >> 4) < (unsigned) 2065))
@@ -1564,7 +1564,7 @@
 			gus_rampon(0x20 | 0x40);	/* Ramp down, once, irq */
 		}
 	}
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 	return ret_val;
 }
 
@@ -1807,7 +1807,7 @@
 					   blk_sz))
 				return -EFAULT;
 
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_write8(0x41, 0);	/* Disable GF1 DMA */
 			DMAbuf_start_dma(gus_devnum, audio_devs[gus_devnum]->dmap_out->raw_buf_phys,
 				blk_sz, DMA_MODE_WRITE);
@@ -1864,7 +1864,7 @@
 			active_device = GUS_DEV_WAVE;
 			gus_write8(0x41, dma_command);	/* Lets go luteet (=bugs) */
 
-			spin_unlock_irqrestore(&lock,flags); /* opens a race */
+			spin_unlock_irqrestore(&gus_lock,flags); /* opens a race */
 			if (!interruptible_sleep_on_timeout(&dram_sleeper, HZ))
 				printk("GUS: DMA Transfer timed out\n");
 		}
@@ -1905,10 +1905,10 @@
 	switch (cmd)
 	{
 		case _GUS_NUMVOICES:
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			gus_select_max_voices(p1);
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
 
 		case _GUS_VOICESAMPLE:
@@ -1916,18 +1916,18 @@
 			break;
 
 		case _GUS_VOICEON:
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			p1 &= ~0x20;	/* Don't allow interrupts */
 			gus_voice_on(p1);
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
 
 		case _GUS_VOICEOFF:
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			gus_voice_off();
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
 
 		case _GUS_VOICEFADE:
@@ -1935,32 +1935,32 @@
 			break;
 
 		case _GUS_VOICEMODE:
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			p1 &= ~0x20;	/* Don't allow interrupts */
 			gus_voice_mode(p1);
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
 
 		case _GUS_VOICEBALA:
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			gus_voice_balance(p1);
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
 
 		case _GUS_VOICEFREQ:
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			gus_voice_freq(plong);
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
 
 		case _GUS_VOICEVOL:
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			gus_voice_volume(p1);
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
 
 		case _GUS_VOICEVOL2:	/* Just update the software voice level */
@@ -1970,48 +1970,48 @@
 		case _GUS_RAMPRANGE:
 			if (voices[voice].mode & WAVE_ENVELOPES)
 				break;	/* NO-NO */
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			gus_ramp_range(p1, p2);
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
 
 		case _GUS_RAMPRATE:
 			if (voices[voice].mode & WAVE_ENVELOPES)
 				break;	/* NJET-NJET */
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			gus_ramp_rate(p1, p2);
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
 
 		case _GUS_RAMPMODE:
 			if (voices[voice].mode & WAVE_ENVELOPES)
 				break;	/* NO-NO */
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			p1 &= ~0x20;	/* Don't allow interrupts */
 			gus_ramp_mode(p1);
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
 
 		case _GUS_RAMPON:
 			if (voices[voice].mode & WAVE_ENVELOPES)
 				break;	/* EI-EI */
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			p1 &= ~0x20;	/* Don't allow interrupts */
 			gus_rampon(p1);
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
 
 		case _GUS_RAMPOFF:
 			if (voices[voice].mode & WAVE_ENVELOPES)
 				break;	/* NEJ-NEJ */
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			gus_rampoff();
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
 
 		case _GUS_VOLUME_SCALE:
@@ -2020,10 +2020,10 @@
 			break;
 
 		case _GUS_VOICE_POS:
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			gus_set_voice_pos(voice, plong);
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
 
 		default:
@@ -2214,12 +2214,12 @@
 	if (pcm_active && pcm_opened)
 		for (voice = 0; voice < gus_audio_channels; voice++)
 		{
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			gus_rampoff();
 			gus_voice_volume(1530 + (25 * gus_pcm_volume));
 			gus_ramp_range(65, 1530 + (25 * gus_pcm_volume));
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 		}
 }
 
@@ -2267,7 +2267,7 @@
 			if (chn == 0)
 				ramp_mode[chn] = 0x04;	/* Enable rollover bit */
 		}
-		spin_lock_irqsave(&lock,flags);
+		spin_lock_irqsave(&gus_lock,flags);
 		gus_select_voice(chn);
 		gus_voice_freq(speed);
 
@@ -2304,17 +2304,17 @@
 					 0, is16bits);	/* Loop end location */
 		else
 			mode[chn] |= 0x08;	/* Enable looping */
-		spin_unlock_irqrestore(&lock,flags);
+		spin_unlock_irqrestore(&gus_lock,flags);
 	}
 	for (chn = 0; chn < gus_audio_channels; chn++)
 	{
-		spin_lock_irqsave(&lock,flags);
+		spin_lock_irqsave(&gus_lock,flags);
 		gus_select_voice(chn);
 		gus_write8(0x0d, ramp_mode[chn]);
 		if (iw_mode)
 			gus_write8(0x15, 0x00);	/* Reset voice deactivate bit of SMSI */
 		gus_voice_on(mode[chn]);
-		spin_unlock_irqrestore(&lock,flags);
+		spin_unlock_irqrestore(&gus_lock,flags);
 	}
 	pcm_active = 1;
 }
@@ -2336,7 +2336,7 @@
 	unsigned char dma_command;
 	unsigned long address, hold_address;
 
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 
 	count = total_count / gus_audio_channels;
 
@@ -2401,7 +2401,7 @@
 		active_device = GUS_DEV_PCM_CONTINUE;
 	}
 
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 }
 
 static void gus_uninterleave8(char *buf, int l)
@@ -2463,7 +2463,7 @@
 	unsigned long flags;
 	unsigned char mode;
 
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 
 	DMAbuf_start_dma(dev, buf, count, DMA_MODE_READ);
 	mode = 0xa0;		/* DMA IRQ enabled, invert MSB */
@@ -2475,7 +2475,7 @@
 	mode |= 0x01;		/* DMA enable */
 
 	gus_write8(0x49, mode);
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 }
 
 static int gus_audio_prepare_for_input(int dev, int bsize, int bcount)
@@ -2535,16 +2535,16 @@
 
 static struct audio_driver gus_audio_driver =
 {
-	owner:		THIS_MODULE,
-	open:		gus_audio_open,
-	close:		gus_audio_close,
-	output_block:	gus_audio_output_block,
-	start_input:	gus_audio_start_input,
-	ioctl:		gus_audio_ioctl,
-	prepare_for_input:	gus_audio_prepare_for_input,
-	prepare_for_output:	gus_audio_prepare_for_output,
-	halt_io:	gus_audio_reset,
-	local_qlen:	gus_local_qlen,
+	.owner			= THIS_MODULE,
+	.open			= gus_audio_open,
+	.close			= gus_audio_close,
+	.output_block		= gus_audio_output_block,
+	.start_input		= gus_audio_start_input,
+	.ioctl			= gus_audio_ioctl,
+	.prepare_for_input	= gus_audio_prepare_for_input,
+	.prepare_for_output	= gus_audio_prepare_for_output,
+	.halt_io		= gus_audio_reset,
+	.local_qlen		= gus_local_qlen,
 };
 
 static void guswave_setup_voice(int dev, int voice, int chn)
@@ -2571,10 +2571,10 @@
 	freq = compute_finetune(voices[voice].orig_freq, value - 8192, voices[voice].bender_range, 0);
 	voices[voice].current_freq = freq;
 
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	gus_select_voice(voice);
 	gus_voice_freq(freq);
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 }
 
 static int guswave_alloc(int dev, int chn, int note, struct voice_alloc_info *alloc)
@@ -2623,28 +2623,28 @@
 
 static struct synth_operations guswave_operations =
 {
-	owner:		THIS_MODULE,
-	id:		"GUS",
-	info:		&gus_info,
-	midi_dev:	0,
-	synth_type:	SYNTH_TYPE_SAMPLE,
-	synth_subtype:	SAMPLE_TYPE_GUS,
-	open:		guswave_open,
-	close:		guswave_close,
-	ioctl:		guswave_ioctl,
-	kill_note:	guswave_kill_note,
-	start_note:	guswave_start_note,
-	set_instr:	guswave_set_instr,
-	reset:		guswave_reset,
-	hw_control:	guswave_hw_control,
-	load_patch:	guswave_load_patch,
-	aftertouch:	guswave_aftertouch,
-	controller:	guswave_controller,
-	panning:	guswave_panning,
-	volume_method:	guswave_volume_method,
-	bender:		guswave_bender,
-	alloc_voice:	guswave_alloc,
-	setup_voice:	guswave_setup_voice
+	.owner		= THIS_MODULE,
+	.id		= "GUS",
+	.info		= &gus_info,
+	.midi_dev	= 0,
+	.synth_type	= SYNTH_TYPE_SAMPLE,
+	.synth_subtype	= SAMPLE_TYPE_GUS,
+	.open		= guswave_open,
+	.close		= guswave_close,
+	.ioctl		= guswave_ioctl,
+	.kill_note	= guswave_kill_note,
+	.start_note	= guswave_start_note,
+	.set_instr	= guswave_set_instr,
+	.reset		= guswave_reset,
+	.hw_control	= guswave_hw_control,
+	.load_patch	= guswave_load_patch,
+	.aftertouch	= guswave_aftertouch,
+	.controller	= guswave_controller,
+	.panning	= guswave_panning,
+	.volume_method	= guswave_volume_method,
+	.bender		= guswave_bender,
+	.alloc_voice	= guswave_alloc,
+	.setup_voice	= guswave_setup_voice
 };
 
 static void set_input_volumes(void)
@@ -2655,7 +2655,7 @@
 	if (have_gus_max)	/* Don't disturb GUS MAX */
 		return;
 
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 
 	/*
 	 *    Enable channels having vol > 10%
@@ -2681,7 +2681,7 @@
 	mix_image |= mask & 0x07;
 	outb((mix_image), u_Mixer);
 
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 }
 
 #define MIX_DEVS	(SOUND_MASK_MIC|SOUND_MASK_LINE| \
@@ -2815,10 +2815,10 @@
 
 static struct mixer_operations gus_mixer_operations =
 {
-	owner:	THIS_MODULE,
-	id:	"GUS",
-	name:	"Gravis Ultrasound",
-	ioctl:	gus_default_mixer_ioctl
+	.owner	= THIS_MODULE,
+	.id	= "GUS",
+	.name	= "Gravis Ultrasound",
+	.ioctl	= gus_default_mixer_ioctl
 };
 
 static int __init gus_default_mixer_init(void)
@@ -2890,10 +2890,10 @@
 	 *  Versions < 3.6 don't have the digital ASIC. Try to probe it first.
 	 */
 
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	outb((0x20), gus_base + 0x0f);
 	val = inb(gus_base + 0x0f);
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 
 	if (gus_pnp_flag || (val != 0xff && (val & 0x06)))	/* Should be 0x02?? */
 	{
@@ -3124,7 +3124,7 @@
 	unsigned char   tmp;
 	int             mode, parm;
 
-	spin_lock(&lock);
+	spin_lock(&gus_lock);
 	gus_select_voice(voice);
 
 	tmp = gus_read8(0x00);
@@ -3200,7 +3200,7 @@
 		default:
 			break;
 	}
-	spin_unlock(&lock);
+	spin_unlock(&gus_lock);
 }
 
 static void do_volume_irq(int voice)
@@ -3209,7 +3209,7 @@
 	int mode, parm;
 	unsigned long flags;
 
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 
 	gus_select_voice(voice);
 	tmp = gus_read8(0x0d);
@@ -3227,18 +3227,18 @@
 		case VMODE_HALT:	/* Decay phase finished */
 			if (iw_mode)
 				gus_write8(0x15, 0x02);	/* Set voice deactivate bit of SMSI */
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			gus_voice_init(voice);
 			break;
 
 		case VMODE_ENVELOPE:
 			gus_rampoff();
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			step_envelope(voice);
 			break;
 
 		case VMODE_START_NOTE:
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			guswave_start_note2(voices[voice].dev_pending, voice,
 				      voices[voice].note_pending, voices[voice].volume_pending);
 			if (voices[voice].kill_pending)
@@ -3254,7 +3254,7 @@
 			break;
 
 		default:
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 	}
 }
 /* called in irq context */
