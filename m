Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316860AbSIIKFS>; Mon, 9 Sep 2002 06:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316935AbSIIKDq>; Mon, 9 Sep 2002 06:03:46 -0400
Received: from smtpout.mac.com ([204.179.120.87]:41706 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S316860AbSIIKC1>;
	Mon, 9 Sep 2002 06:02:27 -0400
Message-Id: <200209091007.g89A77ZH010273@smtp-relay02.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 7/10 sound/oss/dmasound/dmasound_awacs.c
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.33/sound/oss/dmasound/dmasound_awacs.c	Sat Aug 10 00:03:13 2002
+++ linux-2.5-cli-oss/sound/oss/dmasound/dmasound_awacs.c	Mon Sep  9 00:40:07 2002
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

