Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276956AbSIVJMO>; Sun, 22 Sep 2002 05:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276882AbSIVJLI>; Sun, 22 Sep 2002 05:11:08 -0400
Received: from smtpout.mac.com ([204.179.120.88]:12277 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S276956AbSIVJIz>;
	Sun, 22 Sep 2002 05:08:55 -0400
Date: Sat, 21 Sep 2002 22:42:44 +0200
Subject: [PATCH] 8/11 sound/oss replace cli()
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: Linus Torvalds <torvalds@transmeta.com>
To: linux-kernel@vger.kernel.org
From: Peter Waechtler <pwaechtler@mac.com>
Content-Transfer-Encoding: 7bit
Message-Id: <AE4D04C5-CDA2-11D6-8873-00039387C942@mac.com>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.36/sound/oss/gus_wave.c	2002-08-10 00:04:14.000000000 
+0200
+++ linux-2.5-cli-oss/sound/oss/gus_wave.c	2002-08-16 
14:34:30.000000000 +0200
@@ -19,6 +19,7 @@

  #include <linux/init.h>
  #include <linux/config.h>
+#include <linux/spinlock.h>

  #define GUSPNP_AUTODETECT

@@ -138,6 +139,7 @@
  static unsigned long pcm_current_buf;
  static int      pcm_current_count;
  static int      pcm_current_intrflag;
+static spinlock_t lock=SPIN_LOCK_UNLOCKED;

  extern int     *gus_osp;

@@ -226,8 +228,6 @@
  {				/* Writes a byte to the DRAM */
  	unsigned long   flags;

-	save_flags(flags);
-	cli();
  	outb((0x43), u_Command);
  	outb((addr & 0xff), u_DataLo);
  	outb(((addr >> 8) & 0xff), u_DataHi);
@@ -235,16 +235,12 @@
  	outb((0x44), u_Command);
  	outb(((addr >> 16) & 0xff), u_DataHi);
  	outb((data), u_DRAMIO);
-	restore_flags(flags);
  }

  static unsigned char gus_peek(long addr)
  {				/* Reads a byte from the DRAM */
-	unsigned long   flags;
  	unsigned char   tmp;

-	save_flags(flags);
-	cli();
  	outb((0x43), u_Command);
  	outb((addr & 0xff), u_DataLo);
  	outb(((addr >> 8) & 0xff), u_DataHi);
@@ -252,35 +248,23 @@
  	outb((0x44), u_Command);
  	outb(((addr >> 16) & 0xff), u_DataHi);
  	tmp = inb(u_DRAMIO);
-	restore_flags(flags);

  	return tmp;
  }

  void gus_write8(int reg, unsigned int data)
  {				/* Writes to an indirect register (8 bit) */
-	unsigned long   flags;
-
-	save_flags(flags);
-	cli();
-
  	outb((reg), u_Command);
  	outb(((unsigned char) (data & 0xff)), u_DataHi);
-
-	restore_flags(flags);
  }

  static unsigned char gus_read8(int reg)
  {				
  	/* Reads from an indirect register (8 bit). Offset 0x80. */
-	unsigned long   flags;
  	unsigned char   val;

-	save_flags(flags);
-	cli();
  	outb((reg | 0x80), u_Command);
  	val = inb(u_DataHi);
-	restore_flags(flags);

  	return val;
  }
@@ -288,14 +272,10 @@
  static unsigned char gus_look8(int reg)
  {
  	/* Reads from an indirect register (8 bit). No additional offset. */
-	unsigned long   flags;
  	unsigned char   val;

-	save_flags(flags);
-	cli();
  	outb((reg), u_Command);
  	val = inb(u_DataHi);
-	restore_flags(flags);

  	return val;
  }
@@ -303,54 +283,35 @@
  static void gus_write16(int reg, unsigned int data)
  {
  	/* Writes to an indirect register (16 bit) */
-	unsigned long   flags;
-
-	save_flags(flags);
-	cli();
-
  	outb((reg), u_Command);

  	outb(((unsigned char) (data & 0xff)), u_DataLo);
  	outb(((unsigned char) ((data >> 8) & 0xff)), u_DataHi);
-
-	restore_flags(flags);
  }

  static unsigned short gus_read16(int reg)
  {
  	/* Reads from an indirect register (16 bit). Offset 0x80. */
-	unsigned long   flags;
  	unsigned char   hi, lo;

-	save_flags(flags);
-	cli();
-
  	outb((reg | 0x80), u_Command);

  	lo = inb(u_DataLo);
  	hi = inb(u_DataHi);

-	restore_flags(flags);
-
  	return ((hi << 8) & 0xff00) | lo;
  }

  static unsigned short gus_look16(int reg)
  {		
  	/* Reads from an indirect register (16 bit). No additional offset. */
-	unsigned long   flags;
  	unsigned char   hi, lo;

-	save_flags(flags);
-	cli();
-
  	outb((reg), u_Command);

  	lo = inb(u_DataLo);
  	hi = inb(u_DataHi);

-	restore_flags(flags);
-
  	return ((hi << 8) & 0xff00) | lo;
  }

@@ -358,10 +319,7 @@
  {
  	/* Writes an 24 bit memory address */
  	unsigned long   hold_address;
-	unsigned long   flags;

-	save_flags(flags);
-	cli();
  	if (is16bit)
  	{
  		if (iw_mode)
@@ -389,7 +347,6 @@
  	gus_write16(reg, (unsigned short) ((address >> 7) & 0xffff));
  	gus_write16(reg + 1, (unsigned short) ((address << 9) & 0xffff)
  		    + (frac << 5));
-	restore_flags(flags);
  }

  static void gus_select_voice(int voice)
@@ -514,8 +471,7 @@
  {
  	unsigned long   flags;

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
  	gus_select_voice(voice);
  	gus_voice_volume(0);
  	gus_voice_off();
@@ -524,7 +480,7 @@
  	gus_write8(0x0d, 0x03);	/* Ramping off */
  	voice_alloc->map[voice] = 0;
  	voice_alloc->alloc_times[voice] = 0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);

  }

@@ -558,11 +514,10 @@

  	if (voices[voice].mode & WAVE_SUSTAIN_ON && 
voices[voice].env_phase == 2)
  	{
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&lock,flags);
  		gus_select_voice(voice);
  		gus_rampoff();
-		restore_flags(flags);
+		spin_unlock_irqrestore(&lock,flags);
  		return;
  		/*
  		 * Sustain phase begins. Continue envelope after receiving note off.
@@ -580,8 +535,7 @@
  	vol = voices[voice].initial_volume * 
voices[voice].env_offset[phase] / 255;
  	rate = voices[voice].env_rate[phase];

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
  	gus_select_voice(voice);

  	gus_voice_volume(prev_vol);
@@ -593,7 +547,7 @@

  	if (((vol - prev_vol) / 64) == 0)	/* No significant volume change */
  	{
-		restore_flags(flags);
+		spin_unlock_irqrestore(&lock,flags);
  		step_envelope(voice);		/* Continue the envelope on the next step */
  		return;
  	}
@@ -612,7 +566,7 @@
  		gus_rampon(0x60);	/* Decreasing volume, with IRQ */
  	}
  	voices[voice].current_volume = vol;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
  }

  static void init_envelope(int voice)
@@ -623,7 +577,7 @@
  	step_envelope(voice);
  }

-static void start_release(int voice, long int flags)
+static void start_release(int voice)
  {
  	if (gus_read8(0x00) & 0x03)
  		return;		/* Voice already stopped */
@@ -635,7 +589,6 @@

  	voices[voice].mode &= ~WAVE_SUSTAIN_ON;
  	gus_rampoff();
-	restore_flags(flags);
  	step_envelope(voice);
  }

@@ -644,23 +597,22 @@
  	int instr_no = sample_map[voice], is16bits;
  	long int flags;

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
  	gus_select_voice(voice);

  	if (instr_no < 0 || instr_no > MAX_SAMPLE)
  	{
  		gus_write8(0x00, 0x03);	/* Hard stop */
  		voice_alloc->map[voice] = 0;
-		restore_flags(flags);
+		spin_unlock_irqrestore(&lock,flags);
  		return;
  	}
  	is16bits = (samples[instr_no].mode & WAVE_16_BITS) ? 1 : 0;	/* 8 or 16 bits 
*/

  	if (voices[voice].mode & WAVE_ENVELOPES)
  	{
-		start_release(voice, flags);
-		restore_flags(flags);
+		start_release(voice);
+		spin_unlock_irqrestore(&lock,flags);
  		return;
  	}
  	/*
@@ -671,14 +623,14 @@
  		gus_voice_off();
  		gus_rampoff();
  		gus_voice_init(voice);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&lock,flags);
  		return;
  	}
  	gus_ramp_range(65, 4030);
  	gus_ramp_rate(2, 4);
  	gus_rampon(0x40 | 0x20);	/* Down, once, with IRQ */
  	voices[voice].volume_irq_mode = VMODE_HALT;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
  }

  static void gus_reset(void)
@@ -710,8 +662,7 @@
  		0, 1, 0, 2, 0, 3, 4, 5
  	};

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
  	gus_write8(0x4c, 0);	/* Reset GF1 */
  	gus_delay();
  	gus_delay();
@@ -850,7 +801,7 @@

  	if (iw_mode)
  		gus_write8(0x19, gus_read8(0x19) | 0x01);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
  }


@@ -1159,17 +1110,16 @@
  {
  	unsigned long flags;

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
  	/* voice_alloc->map[voice] = 0xffff; */
  	if (voices[voice].volume_irq_mode == VMODE_START_NOTE)
  	{
  		voices[voice].kill_pending = 1;
-		restore_flags(flags);
+		spin_unlock_irqrestore(&lock,flags);
  	}
  	else
  	{
-		restore_flags(flags);
+		spin_unlock_irqrestore(&lock,flags);
  		gus_voice_fade(voice);
  	}

@@ -1227,8 +1177,7 @@
  	compute_volume(voice, volume);
  	voices[voice].current_volume = voices[voice].initial_volume;

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
  	/*
  	 * CAUTION! Interrupts disabled. Enable them before returning
  	 */
@@ -1242,7 +1191,7 @@
  	{
  		gus_rampoff();
  		gus_voice_volume(target);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&lock,flags);
  		return;
  	}
  	if (ramp_time == FAST_RAMP)
@@ -1255,7 +1204,7 @@
  	{
  		gus_rampoff();
  		gus_voice_volume(target);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&lock,flags);
  		return;
  	}
  	if (target > curr)
@@ -1273,7 +1222,7 @@
  		gus_ramp_range(target, curr);
  		gus_rampon(0x40);	/* Ramp down, once, no irq */
  	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
  }

  static void dynamic_volume_change(int voice)
@@ -1281,11 +1230,10 @@
  	unsigned char status;
  	unsigned long flags;

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
  	gus_select_voice(voice);
  	status = gus_read8(0x00);	/* Get voice status */
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);

  	if (status & 0x03)
  		return;		/* Voice was not running */
@@ -1300,11 +1248,10 @@
  	 * Voice is running and has envelopes.
  	 */

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
  	gus_select_voice(voice);
  	status = gus_read8(0x0d);	/* Ramping status */
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);

  	if (status & 0x03)	/* Sustain phase? */
  	{
@@ -1336,11 +1283,10 @@
  				freq = compute_finetune(voices[voice].orig_freq, 
value, voices[voice].bender_range, 0);
  				voices[voice].current_freq = freq;

-				save_flags(flags);
-				cli();
+				spin_lock_irqsave(&lock,flags);
  				gus_select_voice(voice);
  				gus_voice_freq(freq);
-				restore_flags(flags);
+				spin_unlock_irqrestore(&lock,flags);
  			}
  			break;

@@ -1497,17 +1443,12 @@
  			((sample_ptrs[sample] + samples[sample].len) / GUS_BANK_SIZE))
  				printk(KERN_ERR "GUS: Sample address error\n");
  	}
-
	/************************************************************************
*
-	 *    CAUTION!        Interrupts disabled. Don't return before 
enabling
-	 
*************************************************************************/
-
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
  	gus_select_voice(voice);
  	gus_voice_off();
  	gus_rampoff();

-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);

  	if (voices[voice].mode & WAVE_ENVELOPES)
  	{
@@ -1519,8 +1460,7 @@
  		compute_and_set_volume(voice, volume, 0);
  	}

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
  	gus_select_voice(voice);

  	if (samples[sample].mode & WAVE_LOOP_BACK)
@@ -1560,7 +1500,7 @@
  	gus_voice_freq(freq);
  	gus_voice_balance(pan);
  	gus_voice_on(mode);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);

  	return 0;
  }
@@ -1577,8 +1517,7 @@
  	int mode;
  	int ret_val = 0;

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
  	if (note_num == 255)
  	{
  		if (voices[voice].volume_irq_mode == VMODE_START_NOTE)
@@ -1604,11 +1543,10 @@

  		if (voices[voice].sample_pending >= 0)
  		{
-			restore_flags(flags);	/* Run temporarily with interrupts enabled */
+			spin_unlock_irqrestore(&lock,flags);	/* Run temporarily 
with interrupts enabled */
  			guswave_set_instr(voices[voice].dev_pending, voice, 
voices[voice].sample_pending);
  			voices[voice].sample_pending = -1;
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock,flags);
  			gus_select_voice(voice);	/* Reselect the voice (just to be sure) */
  		}
  		if ((mode & 0x01) || (int) ((gus_read16(0x09) >> 4) < 
(unsigned) 2065))
@@ -1628,7 +1566,7 @@
  			gus_rampon(0x20 | 0x40);	/* Ramp down, once, irq */
  		}
  	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
  	return ret_val;
  }

@@ -1871,9 +1809,7 @@
  					   blk_sz))
  				return -EFAULT;

-			save_flags(flags);
-			cli();
-			/******** INTERRUPTS DISABLED NOW ********/
+			spin_lock_irqsave(&lock,flags);
  			gus_write8(0x41, 0);	/* Disable GF1 DMA */
  			DMAbuf_start_dma(gus_devnum, 
audio_devs[gus_devnum]->dmap_out->raw_buf_phys,
  				blk_sz, DMA_MODE_WRITE);
@@ -1924,16 +1860,15 @@
  			if (audio_devs[gus_devnum]->dmap_out->dma > 3)
  				dma_command |= 0x04;	/* 16 bit DMA _channel_ */
  			
-			gus_write8(0x41, dma_command);	/* Lets go luteet (=bugs) */
-
  			/*
  			 * Sleep here until the DRAM DMA done interrupt is served
  			 */
  			active_device = GUS_DEV_WAVE;
+			gus_write8(0x41, dma_command);	/* Lets go luteet (=bugs) */

+			spin_unlock_irqrestore(&lock,flags); /* opens a race */
  			if (!interruptible_sleep_on_timeout(&dram_sleeper, HZ))
  				printk("GUS: DMA Transfer timed out\n");
-			restore_flags(flags);
  		}

  		/*
@@ -1972,11 +1907,10 @@
  	switch (cmd)
  	{
  		case _GUS_NUMVOICES:
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock,flags);
  			gus_select_voice(voice);
  			gus_select_max_voices(p1);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
  			break;

  		case _GUS_VOICESAMPLE:
@@ -1984,20 +1918,18 @@
  			break;

  		case _GUS_VOICEON:
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock,flags);
  			gus_select_voice(voice);
  			p1 &= ~0x20;	/* Don't allow interrupts */
  			gus_voice_on(p1);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
  			break;

  		case _GUS_VOICEOFF:
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock,flags);
  			gus_select_voice(voice);
  			gus_voice_off();
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
  			break;

  		case _GUS_VOICEFADE:
@@ -2005,36 +1937,32 @@
  			break;

  		case _GUS_VOICEMODE:
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock,flags);
  			gus_select_voice(voice);
  			p1 &= ~0x20;	/* Don't allow interrupts */
  			gus_voice_mode(p1);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
  			break;

  		case _GUS_VOICEBALA:
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock,flags);
  			gus_select_voice(voice);
  			gus_voice_balance(p1);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
  			break;

  		case _GUS_VOICEFREQ:
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock,flags);
  			gus_select_voice(voice);
  			gus_voice_freq(plong);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
  			break;

  		case _GUS_VOICEVOL:
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock,flags);
  			gus_select_voice(voice);
  			gus_voice_volume(p1);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
  			break;

  		case _GUS_VOICEVOL2:	/* Just update the software voice level */
@@ -2044,53 +1972,48 @@
  		case _GUS_RAMPRANGE:
  			if (voices[voice].mode & WAVE_ENVELOPES)
  				break;	/* NO-NO */
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock,flags);
  			gus_select_voice(voice);
  			gus_ramp_range(p1, p2);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
  			break;

  		case _GUS_RAMPRATE:
  			if (voices[voice].mode & WAVE_ENVELOPES)
  				break;	/* NJET-NJET */
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock,flags);
  			gus_select_voice(voice);
  			gus_ramp_rate(p1, p2);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
  			break;

  		case _GUS_RAMPMODE:
  			if (voices[voice].mode & WAVE_ENVELOPES)
  				break;	/* NO-NO */
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock,flags);
  			gus_select_voice(voice);
  			p1 &= ~0x20;	/* Don't allow interrupts */
  			gus_ramp_mode(p1);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
  			break;

  		case _GUS_RAMPON:
  			if (voices[voice].mode & WAVE_ENVELOPES)
  				break;	/* EI-EI */
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock,flags);
  			gus_select_voice(voice);
  			p1 &= ~0x20;	/* Don't allow interrupts */
  			gus_rampon(p1);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
  			break;

  		case _GUS_RAMPOFF:
  			if (voices[voice].mode & WAVE_ENVELOPES)
  				break;	/* NEJ-NEJ */
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock,flags);
  			gus_select_voice(voice);
  			gus_rampoff();
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
  			break;

  		case _GUS_VOLUME_SCALE:
@@ -2099,11 +2022,10 @@
  			break;

  		case _GUS_VOICE_POS:
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock,flags);
  			gus_select_voice(voice);
  			gus_set_voice_pos(voice, plong);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
  			break;

  		default:
@@ -2294,13 +2216,12 @@
  	if (pcm_active && pcm_opened)
  		for (voice = 0; voice < gus_audio_channels; voice++)
  		{
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock,flags);
  			gus_select_voice(voice);
  			gus_rampoff();
  			gus_voice_volume(1530 + (25 * gus_pcm_volume));
  			gus_ramp_range(65, 1530 + (25 * gus_pcm_volume));
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
  		}
  }

@@ -2348,8 +2269,7 @@
  			if (chn == 0)
  				ramp_mode[chn] = 0x04;	/* Enable rollover bit */
  		}
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&lock,flags);
  		gus_select_voice(chn);
  		gus_voice_freq(speed);

@@ -2386,18 +2306,17 @@
  					 0, is16bits);	/* Loop end location */
  		else
  			mode[chn] |= 0x08;	/* Enable looping */
-		restore_flags(flags);
+		spin_unlock_irqrestore(&lock,flags);
  	}
  	for (chn = 0; chn < gus_audio_channels; chn++)
  	{
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&lock,flags);
  		gus_select_voice(chn);
  		gus_write8(0x0d, ramp_mode[chn]);
  		if (iw_mode)
  			gus_write8(0x15, 0x00);	/* Reset voice deactivate bit of SMSI */
  		gus_voice_on(mode[chn]);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&lock,flags);
  	}
  	pcm_active = 1;
  }
@@ -2419,8 +2338,7 @@
  	unsigned char dma_command;
  	unsigned long address, hold_address;

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);

  	count = total_count / gus_audio_channels;

@@ -2485,7 +2403,7 @@
  		active_device = GUS_DEV_PCM_CONTINUE;
  	}

-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
  }

  static void gus_uninterleave8(char *buf, int l)
@@ -2547,8 +2465,7 @@
  	unsigned long flags;
  	unsigned char mode;

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);

  	DMAbuf_start_dma(dev, buf, count, DMA_MODE_READ);
  	mode = 0xa0;		/* DMA IRQ enabled, invert MSB */
@@ -2560,7 +2477,7 @@
  	mode |= 0x01;		/* DMA enable */

  	gus_write8(0x49, mode);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
  }

  static int gus_audio_prepare_for_input(int dev, int bsize, int bcount)
@@ -2656,11 +2573,10 @@
  	freq = compute_finetune(voices[voice].orig_freq, value - 8192, 
voices[voice].bender_range, 0);
  	voices[voice].current_freq = freq;

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
  	gus_select_voice(voice);
  	gus_voice_freq(freq);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
  }

  static int guswave_alloc(int dev, int chn, int note, struct 
voice_alloc_info *alloc)
@@ -2741,8 +2657,7 @@
  	if (have_gus_max)	/* Don't disturb GUS MAX */
  		return;

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);

  	/*
  	 *    Enable channels having vol > 10%
@@ -2768,7 +2683,7 @@
  	mix_image |= mask & 0x07;
  	outb((mix_image), u_Mixer);

-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
  }

  #define MIX_DEVS	(SOUND_MASK_MIC|SOUND_MASK_LINE| \
@@ -2977,11 +2892,10 @@
  	 *  Versions < 3.6 don't have the digital ASIC. Try to probe it first.
  	 */

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
  	outb((0x20), gus_base + 0x0f);
  	val = inb(gus_base + 0x0f);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);

  	if (gus_pnp_flag || (val != 0xff && (val & 0x06)))	/* Should be 
0x02?? */
  	{
@@ -3206,15 +3120,13 @@
  		vfree(samples);
  	samples=NULL;
  }
-
+/* called in interrupt context */
  static void do_loop_irq(int voice)
  {
  	unsigned char   tmp;
  	int             mode, parm;
-	unsigned long   flags;

-	save_flags(flags);
-	cli();
+	spin_lock(&lock);
  	gus_select_voice(voice);

  	tmp = gus_read8(0x00);
@@ -3290,7 +3202,7 @@
  		default:
  			break;
  	}
-	restore_flags(flags);
+	spin_unlock(&lock);
  }

  static void do_volume_irq(int voice)
@@ -3299,8 +3211,7 @@
  	int mode, parm;
  	unsigned long flags;

-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);

  	gus_select_voice(voice);
  	tmp = gus_read8(0x0d);
@@ -3318,18 +3229,18 @@
  		case VMODE_HALT:	/* Decay phase finished */
  			if (iw_mode)
  				gus_write8(0x15, 0x02);	/* Set voice deactivate bit of SMSI */
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
  			gus_voice_init(voice);
  			break;

  		case VMODE_ENVELOPE:
  			gus_rampoff();
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
  			step_envelope(voice);
  			break;

  		case VMODE_START_NOTE:
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
  			guswave_start_note2(voices[voice].dev_pending, voice,
  				      voices[voice].note_pending, voices[voice].volume_pending);
  			if (voices[voice].kill_pending)
@@ -3345,11 +3256,10 @@
  			break;

  		default:
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
  	}
-	restore_flags(flags);
  }
-
+/* called in irq context */
  void gus_voice_irq(void)
  {
  	unsigned long wave_ignore = 0, volume_ignore = 0;

