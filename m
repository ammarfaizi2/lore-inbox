Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261334AbTC3Xwj>; Sun, 30 Mar 2003 18:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261335AbTC3Xwj>; Sun, 30 Mar 2003 18:52:39 -0500
Received: from smtpout.mac.com ([17.250.248.87]:39619 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S261334AbTC3XwU>;
	Sun, 30 Mar 2003 18:52:20 -0500
Subject: Re: [2.5 patch] fix sound/oss/ics2101.c compilation
From: Peter Waechtler <pwaechtler@mac.com>
To: Adrian Bunk <bunk@fs.tum.de>, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030330093048.GF10005@fs.tum.de>
References: <20030321201012.GO6940@fs.tum.de>
	<1048443066.1936.2.camel@picklock>  <20030330093048.GF10005@fs.tum.de>
Content-Type: multipart/mixed; boundary="=-JaHC49kf/BqH2DNWMjyL"
Message-Id: <1049068012.2798.13.camel@picklock>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Mar 2003 02:04:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JaHC49kf/BqH2DNWMjyL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2003-03-30 at 11:30, Adrian Bunk wrote:
> On Sun, Mar 23, 2003 at 07:11:03PM +0100, Peter Waechtler wrote:
> > Am Fre, 2003-03-21 um 21.10 schrieb Adrian Bunk:
> > > The following patch fixes the problem for me, please check whether it's 
> > > correct:
> > > 
[patch deleted] 
> > With that patch you do not protect anything.
> > The write_mix function should share the spinlock used in the 
> > interrupt handler.
> 
> This sounds reasonable (I have to admit I didn't look deeply into the 
> code).
> 
> > Do you compile for Uniprocessor? Can you post the relevant config?
> > I don't get a link error with SMP.
> 
> Yes, I'm compiling Uniprocessor. The .config is attached.
> 

There's a problem when compiling the GUS driver into the kernel
instead of as a module. I renamed the global "lock" to "gus_lock"
and made sure that it's used (shared by gus_midi, gus_wave, ics2101)

[snippet of sound/oss/Makefile]
obj-$(CONFIG_SOUND_GUS)         += gus.o ad1848.o
gus-objs        := gus_card.o gus_midi.o gus_vol.o gus_wave.o ics2101.o


Adrian: Do you have a GUS and can test this?



--=-JaHC49kf/BqH2DNWMjyL
Content-Description: 
Content-Disposition: attachment; filename=gus.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-15

diff -Nur -X dontdiff vanilla-2.5.66/sound/oss/gus_midi.c linux-2.5.66/soun=
d/oss/gus_midi.c
--- vanilla-2.5.66/sound/oss/gus_midi.c	2003-03-26 19:54:14.000000000 +0100
+++ linux-2.5.66/sound/oss/gus_midi.c	2003-03-31 00:51:33.000000000 +0200
@@ -26,7 +26,6 @@
 static int      my_dev;
 static int      output_used =3D 0;
 static volatile unsigned char gus_midi_control;
-static spinlock_t lock=3DSPIN_LOCK_UNLOCKED;
 static void     (*midi_input_intr) (int dev, unsigned char data);
=20
 static unsigned char tmp_queue[256];
@@ -35,6 +34,7 @@
 static volatile unsigned char qhead, qtail;
 extern int      gus_base, gus_irq, gus_dma;
 extern int     *gus_osp;
+extern spinlock_t gus_lock;
=20
 static int GUS_MIDI_STATUS(void)
 {
@@ -76,7 +76,7 @@
=20
 	output_used =3D 1;
=20
-	spin_lock_irqsave(&lock, flags);
+	spin_lock_irqsave(&gus_lock, flags);
=20
 	if (GUS_MIDI_STATUS() & MIDI_XMIT_EMPTY)
 	{
@@ -92,7 +92,7 @@
 		outb((gus_midi_control), u_MidiControl);
 	}
=20
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 	return ok;
 }
=20
@@ -113,14 +113,14 @@
 	/*
 	 * Drain the local queue first
 	 */
-	spin_lock_irqsave(&lock, flags);
+	spin_lock_irqsave(&gus_lock, flags);
=20
 	while (qlen && dump_to_midi(tmp_queue[qhead]))
 	{
 		qlen--;
 		qhead++;
 	}
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
=20
 	/*
 	 *	Output the byte if the local queue is empty.
@@ -140,13 +140,13 @@
 		return 0;	/*
 				 * Local queue full
 				 */
-	spin_lock_irqsave(&lock, flags);
+	spin_lock_irqsave(&gus_lock, flags);
=20
 	tmp_queue[qtail] =3D midi_byte;
 	qlen++;
 	qtail++;
=20
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 	return 1;
 }
=20
@@ -171,14 +171,14 @@
 	if (!output_used)
 		return 0;
=20
-	spin_lock_irqsave(&lock, flags);
+	spin_lock_irqsave(&gus_lock, flags);
=20
 	if (qlen && dump_to_midi(tmp_queue[qhead]))
 	{
 		qlen--;
 		qhead++;
 	}
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 	return (qlen > 0) || !(GUS_MIDI_STATUS() & MIDI_XMIT_EMPTY);
 }
=20
@@ -224,7 +224,7 @@
 	volatile unsigned char stat, data;
 	int timeout =3D 10;
=20
-	spin_lock(&lock);
+	spin_lock(&gus_lock);
=20
 	while (timeout-- > 0 && (stat =3D GUS_MIDI_STATUS()) & (MIDI_RCV_FULL | M=
IDI_XMIT_EMPTY))
 	{
@@ -252,5 +252,5 @@
 			}
 		}
 	}
-	spin_unlock(&lock);
+	spin_unlock(&gus_lock);
 }
diff -Nur -X dontdiff vanilla-2.5.66/sound/oss/gus_wave.c linux-2.5.66/soun=
d/oss/gus_wave.c
--- vanilla-2.5.66/sound/oss/gus_wave.c	2002-12-11 15:00:17.000000000 +0100
+++ linux-2.5.66/sound/oss/gus_wave.c	2003-03-31 00:50:27.000000000 +0200
@@ -139,7 +139,7 @@
 static unsigned long pcm_current_buf;
 static int      pcm_current_count;
 static int      pcm_current_intrflag;
-static spinlock_t lock=3DSPIN_LOCK_UNLOCKED;
+spinlock_t gus_lock=3DSPIN_LOCK_UNLOCKED;
=20
 extern int     *gus_osp;
=20
@@ -469,7 +469,7 @@
 {
 	unsigned long   flags;
=20
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	gus_select_voice(voice);
 	gus_voice_volume(0);
 	gus_voice_off();
@@ -478,7 +478,7 @@
 	gus_write8(0x0d, 0x03);	/* Ramping off */
 	voice_alloc->map[voice] =3D 0;
 	voice_alloc->alloc_times[voice] =3D 0;
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
=20
 }
=20
@@ -512,10 +512,10 @@
=20
 	if (voices[voice].mode & WAVE_SUSTAIN_ON && voices[voice].env_phase =3D=
=3D 2)
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
 	vol =3D voices[voice].initial_volume * voices[voice].env_offset[phase] / =
255;
 	rate =3D voices[voice].env_rate[phase];
=20
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	gus_select_voice(voice);
=20
 	gus_voice_volume(prev_vol);
@@ -545,7 +545,7 @@
=20
 	if (((vol - prev_vol) / 64) =3D=3D 0)	/* No significant volume change */
 	{
-		spin_unlock_irqrestore(&lock,flags);
+		spin_unlock_irqrestore(&gus_lock,flags);
 		step_envelope(voice);		/* Continue the envelope on the next step */
 		return;
 	}
@@ -564,7 +564,7 @@
 		gus_rampon(0x60);	/* Decreasing volume, with IRQ */
 	}
 	voices[voice].current_volume =3D vol;
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 }
=20
 static void init_envelope(int voice)
@@ -595,14 +595,14 @@
 	int instr_no =3D sample_map[voice], is16bits;
 	long int flags;
=20
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	gus_select_voice(voice);
=20
 	if (instr_no < 0 || instr_no > MAX_SAMPLE)
 	{
 		gus_write8(0x00, 0x03);	/* Hard stop */
 		voice_alloc->map[voice] =3D 0;
-		spin_unlock_irqrestore(&lock,flags);
+		spin_unlock_irqrestore(&gus_lock,flags);
 		return;
 	}
 	is16bits =3D (samples[instr_no].mode & WAVE_16_BITS) ? 1 : 0;	/* 8 or 16 =
bits */
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
 	voices[voice].volume_irq_mode =3D VMODE_HALT;
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 }
=20
 static void gus_reset(void)
@@ -660,7 +660,7 @@
 		0, 1, 0, 2, 0, 3, 4, 5
 	};
=20
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	gus_write8(0x4c, 0);	/* Reset GF1 */
 	gus_delay();
 	gus_delay();
@@ -799,7 +799,7 @@
=20
 	if (iw_mode)
 		gus_write8(0x19, gus_read8(0x19) | 0x01);
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 }
=20
=20
@@ -1108,16 +1108,16 @@
 {
 	unsigned long flags;
=20
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	/* voice_alloc->map[voice] =3D 0xffff; */
 	if (voices[voice].volume_irq_mode =3D=3D VMODE_START_NOTE)
 	{
 		voices[voice].kill_pending =3D 1;
-		spin_unlock_irqrestore(&lock,flags);
+		spin_unlock_irqrestore(&gus_lock,flags);
 	}
 	else
 	{
-		spin_unlock_irqrestore(&lock,flags);
+		spin_unlock_irqrestore(&gus_lock,flags);
 		gus_voice_fade(voice);
 	}
=20
@@ -1175,7 +1175,7 @@
 	compute_volume(voice, volume);
 	voices[voice].current_volume =3D voices[voice].initial_volume;
=20
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
 	if (ramp_time =3D=3D FAST_RAMP)
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
=20
 static void dynamic_volume_change(int voice)
@@ -1228,10 +1228,10 @@
 	unsigned char status;
 	unsigned long flags;
=20
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	gus_select_voice(voice);
 	status =3D gus_read8(0x00);	/* Get voice status */
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
=20
 	if (status & 0x03)
 		return;		/* Voice was not running */
@@ -1246,10 +1246,10 @@
 	 * Voice is running and has envelopes.
 	 */
=20
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	gus_select_voice(voice);
 	status =3D gus_read8(0x0d);	/* Ramping status */
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
=20
 	if (status & 0x03)	/* Sustain phase? */
 	{
@@ -1281,10 +1281,10 @@
 				freq =3D compute_finetune(voices[voice].orig_freq, value, voices[voice=
].bender_range, 0);
 				voices[voice].current_freq =3D freq;
=20
-				spin_lock_irqsave(&lock,flags);
+				spin_lock_irqsave(&gus_lock,flags);
 				gus_select_voice(voice);
 				gus_voice_freq(freq);
-				spin_unlock_irqrestore(&lock,flags);
+				spin_unlock_irqrestore(&gus_lock,flags);
 			}
 			break;
=20
@@ -1441,12 +1441,12 @@
 			((sample_ptrs[sample] + samples[sample].len) / GUS_BANK_SIZE))
 				printk(KERN_ERR "GUS: Sample address error\n");
 	}
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	gus_select_voice(voice);
 	gus_voice_off();
 	gus_rampoff();
=20
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
=20
 	if (voices[voice].mode & WAVE_ENVELOPES)
 	{
@@ -1458,7 +1458,7 @@
 		compute_and_set_volume(voice, volume, 0);
 	}
=20
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	gus_select_voice(voice);
=20
 	if (samples[sample].mode & WAVE_LOOP_BACK)
@@ -1498,7 +1498,7 @@
 	gus_voice_freq(freq);
 	gus_voice_balance(pan);
 	gus_voice_on(mode);
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
=20
 	return 0;
 }
@@ -1515,7 +1515,7 @@
 	int mode;
 	int ret_val =3D 0;
=20
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	if (note_num =3D=3D 255)
 	{
 		if (voices[voice].volume_irq_mode =3D=3D VMODE_START_NOTE)
@@ -1541,10 +1541,10 @@
=20
 		if (voices[voice].sample_pending >=3D 0)
 		{
-			spin_unlock_irqrestore(&lock,flags);	/* Run temporarily with interrupts=
 enabled */
+			spin_unlock_irqrestore(&gus_lock,flags);	/* Run temporarily with interr=
upts enabled */
 			guswave_set_instr(voices[voice].dev_pending, voice, voices[voice].sampl=
e_pending);
 			voices[voice].sample_pending =3D -1;
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
=20
@@ -1807,7 +1807,7 @@
 					   blk_sz))
 				return -EFAULT;
=20
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_write8(0x41, 0);	/* Disable GF1 DMA */
 			DMAbuf_start_dma(gus_devnum, audio_devs[gus_devnum]->dmap_out->raw_buf_=
phys,
 				blk_sz, DMA_MODE_WRITE);
@@ -1864,7 +1864,7 @@
 			active_device =3D GUS_DEV_WAVE;
 			gus_write8(0x41, dma_command);	/* Lets go luteet (=3Dbugs) */
=20
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
=20
 		case _GUS_VOICESAMPLE:
@@ -1916,18 +1916,18 @@
 			break;
=20
 		case _GUS_VOICEON:
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			p1 &=3D ~0x20;	/* Don't allow interrupts */
 			gus_voice_on(p1);
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
=20
 		case _GUS_VOICEOFF:
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			gus_voice_off();
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
=20
 		case _GUS_VOICEFADE:
@@ -1935,32 +1935,32 @@
 			break;
=20
 		case _GUS_VOICEMODE:
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			p1 &=3D ~0x20;	/* Don't allow interrupts */
 			gus_voice_mode(p1);
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
=20
 		case _GUS_VOICEBALA:
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			gus_voice_balance(p1);
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
=20
 		case _GUS_VOICEFREQ:
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			gus_voice_freq(plong);
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
=20
 		case _GUS_VOICEVOL:
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			gus_voice_volume(p1);
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
=20
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
=20
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
=20
 		case _GUS_RAMPMODE:
 			if (voices[voice].mode & WAVE_ENVELOPES)
 				break;	/* NO-NO */
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			p1 &=3D ~0x20;	/* Don't allow interrupts */
 			gus_ramp_mode(p1);
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
=20
 		case _GUS_RAMPON:
 			if (voices[voice].mode & WAVE_ENVELOPES)
 				break;	/* EI-EI */
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			p1 &=3D ~0x20;	/* Don't allow interrupts */
 			gus_rampon(p1);
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
=20
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
=20
 		case _GUS_VOLUME_SCALE:
@@ -2020,10 +2020,10 @@
 			break;
=20
 		case _GUS_VOICE_POS:
-			spin_lock_irqsave(&lock,flags);
+			spin_lock_irqsave(&gus_lock,flags);
 			gus_select_voice(voice);
 			gus_set_voice_pos(voice, plong);
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			break;
=20
 		default:
@@ -2214,12 +2214,12 @@
 	if (pcm_active && pcm_opened)
 		for (voice =3D 0; voice < gus_audio_channels; voice++)
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
=20
@@ -2267,7 +2267,7 @@
 			if (chn =3D=3D 0)
 				ramp_mode[chn] =3D 0x04;	/* Enable rollover bit */
 		}
-		spin_lock_irqsave(&lock,flags);
+		spin_lock_irqsave(&gus_lock,flags);
 		gus_select_voice(chn);
 		gus_voice_freq(speed);
=20
@@ -2304,17 +2304,17 @@
 					 0, is16bits);	/* Loop end location */
 		else
 			mode[chn] |=3D 0x08;	/* Enable looping */
-		spin_unlock_irqrestore(&lock,flags);
+		spin_unlock_irqrestore(&gus_lock,flags);
 	}
 	for (chn =3D 0; chn < gus_audio_channels; chn++)
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
 	pcm_active =3D 1;
 }
@@ -2336,7 +2336,7 @@
 	unsigned char dma_command;
 	unsigned long address, hold_address;
=20
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
=20
 	count =3D total_count / gus_audio_channels;
=20
@@ -2401,7 +2401,7 @@
 		active_device =3D GUS_DEV_PCM_CONTINUE;
 	}
=20
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 }
=20
 static void gus_uninterleave8(char *buf, int l)
@@ -2463,7 +2463,7 @@
 	unsigned long flags;
 	unsigned char mode;
=20
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
=20
 	DMAbuf_start_dma(dev, buf, count, DMA_MODE_READ);
 	mode =3D 0xa0;		/* DMA IRQ enabled, invert MSB */
@@ -2475,7 +2475,7 @@
 	mode |=3D 0x01;		/* DMA enable */
=20
 	gus_write8(0x49, mode);
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 }
=20
 static int gus_audio_prepare_for_input(int dev, int bsize, int bcount)
@@ -2571,10 +2571,10 @@
 	freq =3D compute_finetune(voices[voice].orig_freq, value - 8192, voices[v=
oice].bender_range, 0);
 	voices[voice].current_freq =3D freq;
=20
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	gus_select_voice(voice);
 	gus_voice_freq(freq);
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 }
=20
 static int guswave_alloc(int dev, int chn, int note, struct voice_alloc_in=
fo *alloc)
@@ -2655,7 +2655,7 @@
 	if (have_gus_max)	/* Don't disturb GUS MAX */
 		return;
=20
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
=20
 	/*
 	 *    Enable channels having vol > 10%
@@ -2681,7 +2681,7 @@
 	mix_image |=3D mask & 0x07;
 	outb((mix_image), u_Mixer);
=20
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 }
=20
 #define MIX_DEVS	(SOUND_MASK_MIC|SOUND_MASK_LINE| \
@@ -2890,10 +2890,10 @@
 	 *  Versions < 3.6 don't have the digital ASIC. Try to probe it first.
 	 */
=20
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
 	outb((0x20), gus_base + 0x0f);
 	val =3D inb(gus_base + 0x0f);
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
=20
 	if (gus_pnp_flag || (val !=3D 0xff && (val & 0x06)))	/* Should be 0x02?? =
*/
 	{
@@ -3124,7 +3124,7 @@
 	unsigned char   tmp;
 	int             mode, parm;
=20
-	spin_lock(&lock);
+	spin_lock(&gus_lock);
 	gus_select_voice(voice);
=20
 	tmp =3D gus_read8(0x00);
@@ -3200,7 +3200,7 @@
 		default:
 			break;
 	}
-	spin_unlock(&lock);
+	spin_unlock(&gus_lock);
 }
=20
 static void do_volume_irq(int voice)
@@ -3209,7 +3209,7 @@
 	int mode, parm;
 	unsigned long flags;
=20
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&gus_lock,flags);
=20
 	gus_select_voice(voice);
 	tmp =3D gus_read8(0x0d);
@@ -3227,18 +3227,18 @@
 		case VMODE_HALT:	/* Decay phase finished */
 			if (iw_mode)
 				gus_write8(0x15, 0x02);	/* Set voice deactivate bit of SMSI */
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			gus_voice_init(voice);
 			break;
=20
 		case VMODE_ENVELOPE:
 			gus_rampoff();
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			step_envelope(voice);
 			break;
=20
 		case VMODE_START_NOTE:
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 			guswave_start_note2(voices[voice].dev_pending, voice,
 				      voices[voice].note_pending, voices[voice].volume_pending);
 			if (voices[voice].kill_pending)
@@ -3254,7 +3254,7 @@
 			break;
=20
 		default:
-			spin_unlock_irqrestore(&lock,flags);
+			spin_unlock_irqrestore(&gus_lock,flags);
 	}
 }
 /* called in irq context */
diff -Nur -X dontdiff vanilla-2.5.66/sound/oss/ics2101.c linux-2.5.66/sound=
/oss/ics2101.c
--- vanilla-2.5.66/sound/oss/ics2101.c	2002-10-02 13:49:21.000000000 +0200
+++ linux-2.5.66/sound/oss/ics2101.c	2003-03-31 00:45:59.000000000 +0200
@@ -29,7 +29,7 @@
=20
 extern int     *gus_osp;
 extern int      gus_base;
-extern spinlock_t lock;
+extern spinlock_t gus_lock;
 static int      volumes[ICS_MIXDEVS];
 static int      left_fix[ICS_MIXDEVS] =3D
 {1, 1, 1, 2, 1, 2};
@@ -87,12 +87,12 @@
 		attn_addr |=3D 0x03;
 	}
=20
-	spin_lock_irqsave(&lock, flags);
+	spin_lock_irqsave(&gus_lock, flags);
 	outb((ctrl_addr), u_MixSelect);
 	outb((selector[dev]), u_MixData);
 	outb((attn_addr), u_MixSelect);
 	outb(((unsigned char) vol), u_MixData);
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&gus_lock,flags);
 }
=20
 static int set_volumes(int dev, int vol)
diff -Nur -X dontdiff vanilla-2.5.66/sound/oss/mad16.c linux-2.5.66/sound/o=
ss/mad16.c
--- vanilla-2.5.66/sound/oss/mad16.c	2003-03-26 19:54:14.000000000 +0100
+++ linux-2.5.66/sound/oss/mad16.c	2003-03-30 22:18:51.000000000 +0200
@@ -537,7 +537,7 @@
=20
 	for (i =3D 0xf8d; i <=3D 0xf93; i++) {
 		if (!c924pnp)
-			DDB(printk("port %03x =3D %02x\n", i, mad_read(i)))
+			DDB(printk("port %03x =3D %02x\n", i, mad_read(i)));
 		else
 			DDB(printk("port %03x =3D %02x\n", i-0x80, mad_read(i)));
 	}
@@ -600,7 +600,7 @@
=20
 	for (i =3D 0xf8d; i <=3D 0xf93; i++) {
 		if (!c924pnp)
-			DDB(printk("port %03x after init =3D %02x\n", i, mad_read(i)))
+			DDB(printk("port %03x after init =3D %02x\n", i, mad_read(i)));
 		else
 			DDB(printk("port %03x after init =3D %02x\n", i-0x80, mad_read(i)));
 	}

--=-JaHC49kf/BqH2DNWMjyL--


