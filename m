Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264572AbSIVW0a>; Sun, 22 Sep 2002 18:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264574AbSIVW0a>; Sun, 22 Sep 2002 18:26:30 -0400
Received: from smtpout.mac.com ([204.179.120.89]:3786 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S264572AbSIVW0N>;
	Sun, 22 Sep 2002 18:26:13 -0400
Message-ID: <3D8E44F6.EF01B445@mac.com>
Date: Mon, 23 Sep 2002 00:32:22 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@mac.com>
Organization: B16
X-Mailer: Mozilla 4.79 [de] (X11; U; Linux 2.4.20-pre7 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] sound/oss cli() fixup all in one
Content-Type: multipart/mixed;
 boundary="------------88B9403686E84457751D7CA7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dies ist eine mehrteilige Nachricht im MIME-Format.
--------------88B9403686E84457751D7CA7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Another try to get it right - as attachment since Netscape Mail
will break the lines too (configurable in preferences).
--------------88B9403686E84457751D7CA7
Content-Type: text/plain; charset=us-ascii;
 name="patch-oss-cli"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-oss-cli"

--- linux-2.5.36/sound/oss/cs4281/cs4281m.c	2002-09-21 19:02:02.000000000 +0200
+++ linux-2.5-cli-oss/sound/oss/cs4281/cs4281m.c	2002-08-10 17:13:46.000000000 +0200
@@ -3205,7 +3205,7 @@
 			 "cs4281: cs4281_ioctl(): DSP_RESET\n"));
 		if (file->f_mode & FMODE_WRITE) {
 			stop_dac(s);
-			synchronize_irq();
+			synchronize_irq(s->irq);
 			s->dma_dac.swptr = s->dma_dac.hwptr =
 			    s->dma_dac.count = s->dma_dac.total_bytes =
 			    s->dma_dac.blocks = s->dma_dac.wakeup = 0;
@@ -3213,7 +3213,7 @@
 		}
 		if (file->f_mode & FMODE_READ) {
 			stop_adc(s);
-			synchronize_irq();
+			synchronize_irq(s->irq);
 			s->dma_adc.swptr = s->dma_adc.hwptr =
 			    s->dma_adc.count = s->dma_adc.total_bytes =
 			    s->dma_adc.blocks = s->dma_dac.wakeup = 0;
@@ -4452,7 +4452,7 @@
 {
 	struct cs4281_state *s = pci_get_drvdata(pci_dev);
 	// stop DMA controller 
-	synchronize_irq();
+	synchronize_irq(s->irq);
 	free_irq(s->irq, s);
 	unregister_sound_dsp(s->dev_audio);
 	unregister_sound_mixer(s->dev_mixer);
--- vanilla-2.5.36/sound/oss/dmasound/dmasound_atari.c	2002-08-10 00:03:13.000000000 +0200
+++ linux-2.5-cli-oss/sound/oss/dmasound/dmasound_atari.c	2002-09-09 01:30:08.000000000 +0200
@@ -19,7 +19,7 @@
 #include <linux/init.h>
 #include <linux/soundcard.h>
 #include <linux/mm.h>
-
+#include <linux/spinlock.h>
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 #include <asm/atariints.h>
@@ -1262,7 +1262,7 @@
 			return;
 		}
 #endif
-
+	spin_lock(&dmasound.lock);
 	if (write_sq_ignore_int && is_falcon) {
 		/* ++TeSche: Falcon only: ignore first irq because it comes
 		 * immediately after starting a frame. after that, irqs come
@@ -1314,6 +1314,7 @@
 	/* We are not playing after AtaPlay(), so there
 	   is nothing to play any more. Wake up a process
 	   waiting for audio output to drain. */
+	spin_unlock(&dmasound.lock);
 }
 
 
@@ -1349,14 +1350,15 @@
 static int AtaMixerIoctl(u_int cmd, u_long arg)
 {
 	int data;
+	unsigned long flags;
 	switch (cmd) {
 	    case SOUND_MIXER_READ_SPEAKER:
 		    if (is_falcon || MACH_IS_TT) {
 			    int porta;
-			    cli();
+			    spin_lock_irqsave(&dmasound.lock, flags);
 			    sound_ym.rd_data_reg_sel = 14;
 			    porta = sound_ym.rd_data_reg_sel;
-			    sti();
+			    spin_unlock_irqrestore(&dmasound.lock, flags);
 			    return IOCTL_OUT(arg, porta & 0x40 ? 0 : 100);
 		    }
 		    break;
@@ -1367,12 +1369,12 @@
 		    if (is_falcon || MACH_IS_TT) {
 			    int porta;
 			    IOCTL_IN(arg, data);
-			    cli();
+			    spin_lock_irqsave(&dmasound.lock, flags);
 			    sound_ym.rd_data_reg_sel = 14;
 			    porta = (sound_ym.rd_data_reg_sel & ~0x40) |
 				    (data < 50 ? 0x40 : 0);
 			    sound_ym.wd_data = porta;
-			    sti();
+			    spin_unlock_irqrestore(&dmasound.lock, flags);
 			    return IOCTL_OUT(arg, porta & 0x40 ? 0 : 100);
 		    }
 	}
--- vanilla-2.5.36/sound/oss/dmasound/dmasound_awacs.c	2002-08-10 00:03:13.000000000 +0200
+++ linux-2.5-cli-oss/sound/oss/dmasound/dmasound_awacs.c	2002-09-09 00:40:07.000000000 +0200
@@ -66,6 +66,7 @@
 #include <linux/tty.h>
 #include <linux/vt_kern.h>
 #include <linux/irq.h>
+#include <linux/spinlock.h>
 #include <linux/kmod.h>
 #include <asm/semaphore.h>
 #ifdef CONFIG_ADB_CUDA
@@ -397,6 +398,7 @@
 static void
 headphone_intr(int irq, void *devid, struct pt_regs *regs)
 {
+	spin_lock(&dmasound.lock);
 	if (read_audio_gpio(gpio_headphone_detect) == gpio_headphone_detect_pol) {
 		printk(KERN_INFO "Audio jack plugged, muting speakers.\n");
 		write_audio_gpio(gpio_amp_mute, gpio_amp_mute_pol);
@@ -406,6 +408,7 @@
 		write_audio_gpio(gpio_amp_mute, !gpio_amp_mute_pol);
 		write_audio_gpio(gpio_headphone_mute, gpio_headphone_mute_pol);
 	}
+	spin_unlock(&dmasound.lock);
 }
 
 
@@ -804,7 +807,7 @@
 
 	/* CHECK: how much of this *really* needs IRQs masked? */
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&dmasound.lock, flags);
 	count = 300 ; /* > two cycles at the lowest sample rate */
 
 	/* what we want to send next */
@@ -871,7 +874,7 @@
 		out_le32(&awacs_txdma->control, ((RUN|WAKE) << 16) + (RUN|WAKE));
 		++write_sq.active;
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&dmasound.lock, flags);
 }
 
 static void PMacPlay(void)
@@ -889,14 +892,14 @@
 	if (read_sq.active)
 		return;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&dmasound.lock, flags);
 
 	/* This is all we have to do......Just start it up.
 	*/
 	out_le32(&awacs_rxdma->control, ((RUN|WAKE) << 16) + (RUN|WAKE));
 	read_sq.active = 1;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&dmasound.lock, flags);
 }
 
 /* if the TX status comes up "DEAD" - reported on some Power Computing machines
@@ -929,6 +932,7 @@
 	/* != 0 when we are dealing with a DEAD xfer */
 	static int emergency_in_use = 0 ;
 
+	spin_lock(&dmasound.lock);
 	while (write_sq.active > 0) { /* we expect to have done something*/
 		if (emergency_in_use) /* we are dealing with DEAD xfer */
 			cp = emergency_dbdma_cmd ;
@@ -1004,6 +1008,7 @@
 	/* make the wake-on-empty conditional on syncing */
 	if (!write_sq.active && (write_sq.syncing & 1))
 		WAKE_UP(write_sq.sync_queue); /* any time we're empty */
+	spin_unlock(&dmasound.lock);
 }
 
 
@@ -1025,6 +1030,7 @@
 	if (read_sq.active == 0)
 		return;
 
+	spin_lock(&dmasound.lock);
 	/* Check multiple buffers in case we were held off from
 	 * interrupt processing for a long time.  Geeze, I really hope
 	 * this doesn't happen.
@@ -1056,6 +1062,7 @@
 			/* should complete clearing the DEAD status */
 			out_le32(&awacs_rxdma->control,
 				((RUN|WAKE) << 16) + (RUN|WAKE));
+			spin_unlock(&dmasound.lock);
 			return; /* try this block again */
 		}
 		/* Clear status and move on to next buffer.
@@ -1083,13 +1090,16 @@
 	}
 
 	WAKE_UP(read_sq.action_queue);
+	spin_unlock(&dmasound.lock);
 }
 
 
 static void
 pmac_awacs_intr(int irq, void *devid, struct pt_regs *regs)
 {
-	int ctrl = in_le32(&awacs->control);
+	int ctrl;
+	spin_lock(&dmasound.lock);
+	ctrl = in_le32(&awacs->control);
 
 	if (ctrl & MASK_PORTCHG) {
 		/* do something when headphone is plugged/unplugged? */
@@ -1102,6 +1112,7 @@
 	}
 	/* Writing 1s to the CNTLERR and PORTCHG bits clears them... */
 	out_le32(&awacs->control, ctrl);
+	spin_unlock(&dmasound.lock);
 }
 
 static void
@@ -1125,7 +1136,7 @@
 	unsigned long flags;
 	int count = 600 ; /* > four samples at lowest rate */
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&dmasound.lock, flags);
 	if (beep_playing) {
 		st_le16(&beep_dbdma_cmd->command, DBDMA_STOP);
 		out_le32(&awacs_txdma->control, (RUN|PAUSE|FLUSH|WAKE) << 16);
@@ -1141,7 +1152,7 @@
 			out_le32(&awacs->byteswap, 0);
 		beep_playing = 0;
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&dmasound.lock, flags);
 }
 
 static struct timer_list beep_timer = {
@@ -1189,19 +1200,19 @@
 		return;
 #endif
 	}
-	save_flags(flags); cli();
+	spin_lock_irqsave(&dmasound.lock, flags);
 	del_timer(&beep_timer);
 	if (ticks) {
 		beep_timer.expires = jiffies + ticks;
 		add_timer(&beep_timer);
 	}
 	if (beep_playing || write_sq.active || beep_buf == NULL) {
-		restore_flags(flags);
+		spin_unlock_irqrestore(&dmasound.lock, flags);
 		return;		/* too hard, sorry :-( */
 	}
 	beep_playing = 1;
 	st_le16(&beep_dbdma_cmd->command, OUTPUT_MORE + BR_ALWAYS);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&dmasound.lock, flags);
 
 	if (hz == beep_hz_cache && beep_vol == beep_volume_cache) {
 		nsamples = beep_nsamples_cache;
@@ -1227,7 +1238,7 @@
 	st_le32(&beep_dbdma_cmd->phy_addr, virt_to_bus(beep_buf));
 	awacs_beep_state = 1;
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&dmasound.lock, flags);
 	if (beep_playing) {	/* i.e. haven't been terminated already */
 		int count = 300 ;
 		out_le32(&awacs_txdma->control, (RUN|WAKE|FLUSH|PAUSE) << 16);
@@ -1242,7 +1253,7 @@
 		(void)in_le32(&awacs_txdma->status);
 		out_le32(&awacs_txdma->control, RUN | (RUN << 16));
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&dmasound.lock, flags);
 }
 
 /* used in init and for wake-up */
@@ -1430,7 +1441,7 @@
 	unsigned long flags;
 
 	/* should have timeouts here */
-	save_flags(flags); cli();
+	spin_lock_irqsave(&dmasound.lock, flags);
 
 	out_le32(&awacs->codec_ctrl, addr + 0x100000);
 	awacs_burgundy_busy_wait();
@@ -1452,7 +1463,7 @@
 	awacs_burgundy_extend_wait();
 	val += ((in_le32(&awacs->codec_stat)>>4) & 0xff) <<24;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&dmasound.lock, flags);
 
 	return val;
 }
@@ -1472,14 +1483,14 @@
 	unsigned long flags;
 
 	/* should have timeouts here */
-	save_flags(flags); cli();
+	spin_lock_irqsave(&dmasound.lock, flags);
 
 	out_le32(&awacs->codec_ctrl, addr + 0x100000);
 	awacs_burgundy_busy_wait();
 	awacs_burgundy_extend_wait();
 	val += (in_le32(&awacs->codec_stat) >> 4) & 0xff;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&dmasound.lock, flags);
 
 	return val;
 }
--- vanilla-2.5.36/sound/oss/dmasound/dmasound_core.c	2002-08-10 00:03:13.000000000 +0200
+++ linux-2.5-cli-oss/sound/oss/dmasound/dmasound_core.c	2002-09-09 00:33:36.000000000 +0200
@@ -597,9 +597,9 @@
 	   is drained - and if we get here in time then it does not apply.
 	*/
 
-	save_flags(flags) ; cli() ;
+	spin_lock_irqsave(&dmasound.lock, flags);
 	write_sq.syncing &= ~2 ; /* take out POST status */
-	restore_flags(flags) ;
+	spin_unlock_irqrestore(&dmasound.lock, flags);
 
 	if (write_sq.count > 0 &&
 	    (bLeft = write_sq.block_size-write_sq.rear_size) > 0) {
@@ -1347,6 +1347,7 @@
 	if (dmasound.mach.record)
 		sq_fops.read = sq_read ;
 #endif
+	spin_lock_init(&dmasound.lock);
 	sq_unit = register_sound_dsp(&sq_fops, -1);
 	if (sq_unit < 0) {
 		printk(KERN_ERR "dmasound_core: couldn't register fops\n") ;
--- vanilla-2.5.36/sound/oss/dmasound/dmasound.h	Sat Apr 20 18:25:19 2002
+++ linux-2.5-cli-oss/sound/oss/dmasound/dmasound.h	Mon Sep  9 01:27:04 2002
@@ -166,6 +166,7 @@
     int treble;
     int gain;
     int minDev;		/* minor device number currently open */
+    spinlock_t lock;
 };
 
 extern struct sound_settings dmasound;
--- vanilla-2.5.36/sound/oss/dmasound/dmasound_q40.c	Sat Aug 10 00:03:13 2002
+++ linux-2.5-cli-oss/sound/oss/dmasound/dmasound_q40.c	Sat Sep 21 18:53:15 2002
@@ -459,28 +459,32 @@
 		  */
 	         return;
 	}
-	save_flags(flags); cli();
+	spin_lock_irqsave(&dmasound.lock, flags);
 	Q40PlayNextFrame(1);
-	restore_flags(flags);
+	spin_unlock_irqrestore_flags(&dmasound.lock, flags);
 }
 
 static void Q40StereoInterrupt(int irq, void *dummy, struct pt_regs *fp)
 {
+	spin_lock(&dmasound.lock);
         if (q40_sc>1){
             *DAC_LEFT=*q40_pp++;
 	    *DAC_RIGHT=*q40_pp++;
 	    q40_sc -=2;
 	    master_outb(1,SAMPLE_CLEAR_REG);
 	}else Q40Interrupt();
+	spin_unlock(&dmasound.lock);
 }
 static void Q40MonoInterrupt(int irq, void *dummy, struct pt_regs *fp)
 {
+	spin_lock(&dmasound.lock);
         if (q40_sc>0){
             *DAC_LEFT=*q40_pp;
 	    *DAC_RIGHT=*q40_pp++;
 	    q40_sc --;
 	    master_outb(1,SAMPLE_CLEAR_REG);
 	}else Q40Interrupt();
+	spin_unlock(&dmasound.lock);
 }
 static void Q40Interrupt(void)
 {
--- vanilla-2.5.36/sound/oss/gus_midi.c	2002-04-20 18:25:20.000000000 +0200
+++ linux-2.5-cli-oss/sound/oss/gus_midi.c	2002-08-16 13:57:28.000000000 +0200
@@ -16,6 +16,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/spinlock.h>
 #include "sound_config.h"
 
 #include "gus.h"
@@ -25,7 +26,7 @@
 static int      my_dev;
 static int      output_used = 0;
 static volatile unsigned char gus_midi_control;
-
+static spinlock_t lock=SPIN_LOCK_UNLOCKED;
 static void     (*midi_input_intr) (int dev, unsigned char data);
 
 static unsigned char tmp_queue[256];
@@ -75,8 +76,7 @@
 
 	output_used = 1;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);
 
 	if (GUS_MIDI_STATUS() & MIDI_XMIT_EMPTY)
 	{
@@ -92,7 +92,7 @@
 		outb((gus_midi_control), u_MidiControl);
 	}
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 	return ok;
 }
 
@@ -113,16 +113,14 @@
 	/*
 	 * Drain the local queue first
 	 */
-
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);
 
 	while (qlen && dump_to_midi(tmp_queue[qhead]))
 	{
 		qlen--;
 		qhead++;
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 
 	/*
 	 *	Output the byte if the local queue is empty.
@@ -142,14 +140,13 @@
 		return 0;	/*
 				 * Local queue full
 				 */
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);
 
 	tmp_queue[qtail] = midi_byte;
 	qlen++;
 	qtail++;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 	return 1;
 }
 
@@ -174,15 +171,14 @@
 	if (!output_used)
 		return 0;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);
 
 	if (qlen && dump_to_midi(tmp_queue[qhead]))
 	{
 		qlen--;
 		qhead++;
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 	return (qlen > 0) | !(GUS_MIDI_STATUS() & MIDI_XMIT_EMPTY);
 }
 
@@ -226,11 +222,9 @@
 void gus_midi_interrupt(int dummy)
 {
 	volatile unsigned char stat, data;
-	unsigned long flags;
 	int timeout = 10;
 
-	save_flags(flags);
-	cli();
+	spin_lock(&lock);
 
 	while (timeout-- > 0 && (stat = GUS_MIDI_STATUS()) & (MIDI_RCV_FULL | MIDI_XMIT_EMPTY))
 	{
@@ -258,5 +252,5 @@
 			}
 		}
 	}
-	restore_flags(flags);
+	spin_unlock(&lock);
 }
--- vanilla-2.5.36/sound/oss/gus_wave.c	2002-08-10 00:04:14.000000000 +0200
+++ linux-2.5-cli-oss/sound/oss/gus_wave.c	2002-08-16 14:34:30.000000000 +0200
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
 
 	if (voices[voice].mode & WAVE_SUSTAIN_ON && voices[voice].env_phase == 2)
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
 	vol = voices[voice].initial_volume * voices[voice].env_offset[phase] / 255;
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
 	is16bits = (samples[instr_no].mode & WAVE_16_BITS) ? 1 : 0;	/* 8 or 16 bits */
 
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
 				freq = compute_finetune(voices[voice].orig_freq, value, voices[voice].bender_range, 0);
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
-	/*************************************************************************
-	 *    CAUTION!        Interrupts disabled. Don't return before enabling
-	 *************************************************************************/
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
+			spin_unlock_irqrestore(&lock,flags);	/* Run temporarily with interrupts enabled */
 			guswave_set_instr(voices[voice].dev_pending, voice, voices[voice].sample_pending);
 			voices[voice].sample_pending = -1;
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock,flags);
 			gus_select_voice(voice);	/* Reselect the voice (just to be sure) */
 		}
 		if ((mode & 0x01) || (int) ((gus_read16(0x09) >> 4) < (unsigned) 2065))
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
 			DMAbuf_start_dma(gus_devnum, audio_devs[gus_devnum]->dmap_out->raw_buf_phys,
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
 	freq = compute_finetune(voices[voice].orig_freq, value - 8192, voices[voice].bender_range, 0);
 	voices[voice].current_freq = freq;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
 	gus_select_voice(voice);
 	gus_voice_freq(freq);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 }
 
 static int guswave_alloc(int dev, int chn, int note, struct voice_alloc_info *alloc)
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
 
 	if (gus_pnp_flag || (val != 0xff && (val & 0x06)))	/* Should be 0x02?? */
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
--- vanilla-2.5.36/sound/oss/ics2101.c	2002-04-20 18:25:20.000000000 +0200
+++ linux-2.5-cli-oss/sound/oss/ics2101.c	2002-08-16 13:59:55.000000000 +0200
@@ -15,6 +15,7 @@
  * Bartlomiej Zolnierkiewicz : added __init to ics2101_mixer_init()
  */
 #include <linux/init.h>
+#include <linux/spinlock.h>
 #include "sound_config.h"
 
 #include <linux/ultrasound.h>
@@ -28,6 +29,7 @@
 
 extern int     *gus_osp;
 extern int      gus_base;
+extern spinlock_t lock;
 static int      volumes[ICS_MIXDEVS];
 static int      left_fix[ICS_MIXDEVS] =
 {1, 1, 1, 2, 1, 2};
@@ -85,13 +87,12 @@
 		attn_addr |= 0x03;
 	}
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);
 	outb((ctrl_addr), u_MixSelect);
 	outb((selector[dev]), u_MixData);
 	outb((attn_addr), u_MixSelect);
 	outb(((unsigned char) vol), u_MixData);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 }
 
 static int set_volumes(int dev, int vol)
--- vanilla-2.5.36/sound/oss/v_midi.h	2002-04-20 18:25:21.000000000 +0200
+++ linux-2.5-cli-oss/sound/oss/v_midi.h	2002-08-13 15:55:26.000000000 +0200
@@ -3,7 +3,7 @@
 
 	/* State variables */
  	   int opened;
-
+	   spinlock_t lock;
 	
 	/* MIDI fields */
 	   int my_mididev;
--- vanilla-2.5.36/sound/oss/wf_midi.c	2002-04-20 18:25:22.000000000 +0200
+++ linux-2.5-cli-oss/sound/oss/wf_midi.c	2002-08-16 12:43:47.000000000 +0200
@@ -50,6 +50,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/spinlock.h>
 #include "sound_config.h"
 
 #include <linux/wavefront.h>
@@ -79,6 +80,7 @@
 static struct wf_mpu_config *virt_dev = &devs[1];
 
 static void start_uart_mode (void);
+static spinlock_t lock=SPIN_LOCK_UNLOCKED;
 
 #define	OUTPUT_READY	0x40
 #define	INPUT_AVAIL	0x80
@@ -365,8 +367,8 @@
 	}
 
 	if (mi->m_busy) return;
+	spin_lock(&lock);
 	mi->m_busy = 1;
-	sti (); 
 
 	if (!input_dev) {
 		input_dev = physical_dev;
@@ -406,6 +408,7 @@
 	} while (input_avail() && n-- > 0);
 
 	mi->m_busy = 0;
+	spin_unlock(&lock);
 }
 
 static int
@@ -486,18 +489,17 @@
 		for (timeout = 30000; timeout > 0 && !output_ready ();
 		     timeout--);
       
-		save_flags (flags);
-		cli ();
+		spin_lock_irqsave(&lock,flags);
       
 		if (!output_ready ()) {
 			printk (KERN_WARNING "WF-MPU: Send switch "
 				"byte timeout\n");
-			restore_flags (flags);
+			spin_unlock_irqrestore(&lock,flags);
 			return 0;
 		}
       
 		write_data (switchch);
-		restore_flags (flags);
+		spin_unlock_irqrestore(&lock,flags);
 	} 
 
 	lastoutdev = dev;
@@ -511,16 +513,15 @@
 
 	for (timeout = 30000; timeout > 0 && !output_ready (); timeout--);
 
-	save_flags (flags);
-	cli ();
+	spin_lock_irqsave(&lock,flags);
 	if (!output_ready ()) {
+		spin_unlock_irqrestore(&lock,flags);
 		printk (KERN_WARNING "WF-MPU: Send data timeout\n");
-		restore_flags (flags);
 		return 0;
 	}
 
 	write_data (midi_byte);
-	restore_flags (flags);
+	spin_unlock_irqrestore(&lock,flags);
 
 	return 1;
 }
@@ -768,14 +769,13 @@
 {
 	unsigned long flags;
 
-	save_flags (flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
 
 	wf_mpu_close (virt_dev->devno);
 	/* no synth on virt_dev, so no need to call wf_mpu_synth_close() */
 	phys_dev->isvirtual = 0;
 
-	restore_flags (flags);
+	spin_unlock_irqrestore(&lock,flags);
 
 	return 0;
 }
@@ -858,8 +858,7 @@
 	int             ok, i;
 	unsigned long   flags;
 
-	save_flags (flags);
-	cli ();
+	spin_lock_irqsave(&lock,flags);
 
 	/* XXX fix me */
 
@@ -875,6 +874,6 @@
 		}
 	}
 
-	restore_flags (flags);
+	spin_unlock_irqrestore(&lock,flags);
 }
 #endif

--------------88B9403686E84457751D7CA7--

