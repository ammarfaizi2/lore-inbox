Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319359AbSH2VuG>; Thu, 29 Aug 2002 17:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319357AbSH2Vtg>; Thu, 29 Aug 2002 17:49:36 -0400
Received: from smtpout.mac.com ([204.179.120.86]:65489 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319353AbSH2VtS>;
	Thu, 29 Aug 2002 17:49:18 -0400
Message-Id: <200208292153.g7TLrfZH003462@smtp-relay02.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 3/41 sound/oss/ad1848.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/ad1848.c	Sat Aug 10 00:08:54 2002
+++ linux-2.5-cli-oss/sound/oss/ad1848.c	Wed Aug 14 22:52:52 2002
@@ -47,6 +47,7 @@
 #include <linux/stddef.h>
 #include <linux/pm.h>
 #include <linux/isapnp.h>
+#include <linux/spinlock.h>
 
 #define DEB(x)
 #define DEB1(x)
@@ -57,6 +58,7 @@
 
 typedef struct
 {
+	spinlock_t		lock;
 	int             base;
 	int             irq;
 	int             dma1, dma2;
@@ -212,8 +214,7 @@
 	while (timeout > 0 && inb(devc->base) == 0x80)	/*Are we initializing */
 		timeout--;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	
 	if(reg < 32)
 	{
@@ -230,7 +231,7 @@
 		outb(((unsigned char) (xra & 0xff)), io_Indexed_Data(devc));
 		x = inb(io_Indexed_Data(devc));
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 
 	return x;
 }
@@ -243,8 +244,7 @@
 	while (timeout > 0 && inb(devc->base) == 0x80)	/* Are we initializing */
 		timeout--;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	
 	if(reg < 32)
 	{
@@ -261,7 +261,7 @@
 		outb(((unsigned char) (xra & 0xff)), io_Indexed_Data(devc));
 		outb((unsigned char) (data & 0xff), io_Indexed_Data(devc));
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 static void wait_for_calibration(ad1848_info * devc)
@@ -324,18 +324,17 @@
 	while (timeout > 0 && inb(devc->base) == 0x80)	/*Are we initializing */
 		timeout--;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 
 	devc->MCE_bit = 0x40;
 	prev = inb(io_Index_Addr(devc));
 	if (prev & 0x40)
 	{
-		restore_flags(flags);
+		spin_unlock_irqrestore(&devc->lock,flags);
 		return;
 	}
 	outb((devc->MCE_bit), io_Index_Addr(devc));
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 static void ad_leave_MCE(ad1848_info * devc)
@@ -347,8 +346,7 @@
 	while (timeout > 0 && inb(devc->base) == 0x80)	/*Are we initializing */
 		timeout--;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 
 	acal = ad_read(devc, 9);
 
@@ -358,13 +356,13 @@
 
 	if ((prev & 0x40) == 0)	/* Not in MCE mode */
 	{
-		restore_flags(flags);
+		spin_unlock_irqrestore(&devc->lock,flags);
 		return;
 	}
 	outb((0x00), io_Index_Addr(devc));	/* Clear the MCE bit */
 	if (acal & 0x08)	/* Auto calibration is enabled */
 		wait_for_calibration(devc);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 static int ad1848_set_recmask(ad1848_info * devc, int mask)
@@ -975,7 +973,7 @@
 
 static int ad1848_open(int dev, int mode)
 {
-	ad1848_info    *devc = NULL;
+	ad1848_info    *devc;
 	ad1848_port_info *portc;
 	unsigned long   flags;
 
@@ -985,11 +983,10 @@
 	devc = (ad1848_info *) audio_devs[dev]->devc;
 	portc = (ad1848_port_info *) audio_devs[dev]->portc;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	if (portc->open_mode || (devc->open_mode & mode))
 	{
-		restore_flags(flags);
+		spin_unlock_irqrestore(&devc->lock,flags);
 		return -EBUSY;
 	}
 	devc->dual_dma = 0;
@@ -1008,7 +1005,7 @@
 		devc->record_dev = dev;
 	if (mode & OPEN_WRITE)
 		devc->playback_dev = dev;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 /*
  * Mute output until the playback really starts. This decreases clicking (hope so).
  */
@@ -1025,8 +1022,7 @@
 
 	DEB(printk("ad1848_close(void)\n"));
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 
 	devc->intr_active = 0;
 	ad1848_halt(dev);
@@ -1036,7 +1032,7 @@
 	portc->open_mode = 0;
 
 	ad_unmute(devc);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 static void ad1848_output_block(int dev, unsigned long buf, int count, int intrflag)
@@ -1070,8 +1066,7 @@
 			 * Auto DMA mode on. No need to react
 			 */
 	}
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 
 	ad_write(devc, 15, (unsigned char) (cnt & 0xff));
 	ad_write(devc, 14, (unsigned char) ((cnt >> 8) & 0xff));
@@ -1079,7 +1074,7 @@
 	devc->xfer_count = cnt;
 	devc->audio_mode |= PCM_ENABLE_OUTPUT;
 	devc->intr_active = 1;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 static void ad1848_start_input(int dev, unsigned long buf, int count, int intrflag)
@@ -1112,8 +1107,7 @@
 			 * Auto DMA mode on. No need to react
 			 */
 	}
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 
 	if (devc->model == MD_1848)
 	{
@@ -1131,7 +1125,7 @@
 	devc->xfer_count = cnt;
 	devc->audio_mode |= PCM_ENABLE_INPUT;
 	devc->intr_active = 1;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 static int ad1848_prepare_for_output(int dev, int bsize, int bcount)
@@ -1144,8 +1138,7 @@
 
 	ad_mute(devc);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	fs = portc->speed_bits | (portc->format_bits << 5);
 
 	if (portc->channels > 1)
@@ -1189,7 +1182,7 @@
 	ad_leave_MCE(devc);	/*
 				 * Starts the calibration process.
 				 */
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 	devc->xfer_count = 0;
 
 #ifndef EXCLUDE_TIMERS
@@ -1214,8 +1207,7 @@
 	if (devc->audio_mode)
 		return 0;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	fs = portc->speed_bits | (portc->format_bits << 5);
 
 	if (portc->channels > 1)
@@ -1303,7 +1295,7 @@
 	ad_leave_MCE(devc);	/*
 				 * Starts the calibration process.
 				 */
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 	devc->xfer_count = 0;
 
 #ifndef EXCLUDE_TIMERS
@@ -1342,8 +1334,7 @@
 	if (!(ad_read(devc, 9) & 0x02))
 		return;		/* Capture not enabled */
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 
 	ad_mute(devc);
 
@@ -1368,7 +1359,7 @@
 
 	devc->audio_mode &= ~PCM_ENABLE_INPUT;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 static void ad1848_halt_output(int dev)
@@ -1379,8 +1370,7 @@
 	if (!(ad_read(devc, 9) & 0x01))
 		return;		/* Playback not enabled */
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 
 	ad_mute(devc);
 	{
@@ -1405,7 +1395,7 @@
 
 	devc->audio_mode &= ~PCM_ENABLE_OUTPUT;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 static void ad1848_trigger(int dev, int state)
@@ -1415,8 +1405,7 @@
 	unsigned long   flags;
 	unsigned char   tmp, old;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	state &= devc->audio_mode;
 
 	tmp = old = ad_read(devc, 9);
@@ -1441,7 +1430,7 @@
 		  ad_write(devc, 9, tmp);
 		  ad_unmute(devc);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 static void ad1848_init_hw(ad1848_info * devc)
@@ -1978,6 +1967,7 @@
 
 	ad1848_port_info *portc = NULL;
 
+	spin_lock_init(&devc->lock);
 	devc->irq = (irq > 0) ? irq : 0;
 	devc->open_mode = 0;
 	devc->timer_ticks = 0;
@@ -2245,10 +2235,8 @@
 	{
 		if (devc->model == MD_C930)
 		{		/* 82C930 has interrupt status register in MAD16 register MC11 */
-			unsigned long   flags;
 
-			save_flags(flags);
-			cli();
+			spin_lock(&devc->lock);
 
 			/* 0xe0e is C930 address port
 			 * 0xe0f is C930 data port
@@ -2257,7 +2245,7 @@
 			c930_stat = inb(0xe0f);
 			outb((~c930_stat), 0xe0f);
 
-			restore_flags(flags);
+			spin_unlock(&devc->lock);
 
 			alt_stat = (c930_stat << 2) & 0x30;
 		}
@@ -2733,8 +2721,7 @@
 	unsigned long   xtal_nsecs;	/* nanoseconds per xtal oscillator tick */
 	unsigned long   divider;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 
 	/*
 	 * Length of the timer interval (in nanoseconds) depends on the
@@ -2766,7 +2753,7 @@
 	ad_write(devc, 20, divider & 0xff);	/* Set lower bits */
 	ad_write(devc, 16, ad_read(devc, 16) | 0x40);	/* Start the timer */
 	devc->timer_running = 1;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 
 	return current_interval = (divider * xtal_nsecs + 500) / 1000;
 }
@@ -2787,11 +2774,10 @@
 	unsigned long   flags;
 	ad1848_info    *devc = (ad1848_info *) audio_devs[dev]->devc;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	ad_write(devc, 16, ad_read(devc, 16) & ~0x40);
 	devc->timer_running = 0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 static void ad1848_tmr_restart(int dev)
@@ -2802,11 +2788,10 @@
 	if (current_interval == 0)
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	ad_write(devc, 16, ad_read(devc, 16) | 0x40);
 	devc->timer_running = 1;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 static struct sound_lowlev_timer ad1848_tmr =
@@ -2834,12 +2819,11 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 
 	ad_mute(devc);
 	
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 	return 0;
 }
 
@@ -2848,8 +2832,7 @@
 	unsigned long flags;
 	int mixer_levels[32], i;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	
 	/* Thinkpad is a bit more of PITA than normal. The BIOS tends to
 	   restore it in a different config to the one we use.  Need to
@@ -2875,7 +2858,7 @@
 		bits = interrupt_bits[devc->irq];
 		if (bits == -1) {
 			printk(KERN_ERR "MSS: Bad IRQ %d\n", devc->irq);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&devc->lock,flags);
 			return -1;
 		}
 
@@ -2890,8 +2873,8 @@
 		outb((bits | dma_bits[devc->dma1] | dma2_bit), config_port);
 	}
 
-	restore_flags(flags);
-      	return 0;
+	spin_unlock_irqrestore(&devc->lock,flags);
+	return 0;
 }
 
 static int ad1848_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data) 

