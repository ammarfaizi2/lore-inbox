Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319386AbSH2Vws>; Thu, 29 Aug 2002 17:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319383AbSH2VwA>; Thu, 29 Aug 2002 17:52:00 -0400
Received: from smtpout.mac.com ([204.179.120.88]:53751 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319365AbSH2Vua>;
	Thu, 29 Aug 2002 17:50:30 -0400
Message-Id: <200208292154.g7TLsrVw009107@smtp-relay01.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 8/41 sound/oss/sequencer.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/sequencer.c	Sat Aug 10 00:04:15 2002
+++ linux-2.5-cli-oss/sound/oss/sequencer.c	Wed Aug 14 22:40:34 2002
@@ -15,7 +15,7 @@
  * Alan Cox	   : reformatted and fixed a pair of null pointer bugs
  */
 #include <linux/kmod.h>
-
+#include <linux/spinlock.h>
 #define SEQUENCER_C
 #include "sound_config.h"
 
@@ -28,6 +28,7 @@
 extern unsigned long seq_time;
 
 static int      obsolete_api_used = 0;
+static spinlock_t lock=SPIN_LOCK_UNLOCKED;
 
 /*
  * Local counts for number of synth and MIDI devices. These are initialized
@@ -95,37 +96,38 @@
 
 	ev_len = seq_mode == SEQ_1 ? 4 : 8;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
 
 	if (!iqlen)
 	{
+		spin_unlock_irqrestore(&lock,flags);
  		if (file->f_flags & O_NONBLOCK) {
-  			restore_flags(flags);
   			return -EAGAIN;
   		}
 
  		interruptible_sleep_on_timeout(&midi_sleeper,
 					       pre_event_timeout);
+		spin_lock_irqsave(&lock,flags);
 		if (!iqlen)
 		{
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
 			return 0;
 		}
 	}
 	while (iqlen && c >= ev_len)
 	{
 		char *fixit = (char *) &iqueue[iqhead * IEV_SZ];
+		spin_unlock_irqrestore(&lock,flags);
 		if (copy_to_user(&(buf)[p], fixit, ev_len))
-			goto out;
+			return count - c;
 		p += ev_len;
 		c -= ev_len;
 
+		spin_lock_irqsave(&lock,flags);
 		iqhead = (iqhead + 1) % SEQ_MAX_QUEUE;
 		iqlen--;
 	}
-out:
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 	return count - c;
 }
 
@@ -152,13 +154,12 @@
 	if (iqlen >= (SEQ_MAX_QUEUE - 1))
 		return;		/* Overflow */
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
 	memcpy(&iqueue[iqtail * IEV_SZ], event_rec, len);
 	iqlen++;
 	iqtail = (iqtail + 1) % SEQ_MAX_QUEUE;
 	wake_up(&midi_sleeper);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 }
 
 static void sequencer_midi_input(int dev, unsigned char data)
@@ -869,19 +870,19 @@
 	return 0;
 }
 
+/* called also as timer in irq context */
 static void seq_startplay(void)
 {
-	unsigned long flags;
 	int this_one, action;
+	unsigned long flags;
 
 	while (qlen > 0)
 	{
 
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&lock,flags);
 		qhead = ((this_one = qhead) + 1) % SEQ_MAX_QUEUE;
 		qlen--;
-		restore_flags(flags);
+		spin_unlock_irqrestore(&lock,flags);
 
 		seq_playing = 1;
 
@@ -947,7 +948,6 @@
 {
 	int retval, mode, i;
 	int level, tmp;
-	unsigned long flags;
 
 	if (!sequencer_ok)
 		sequencer_init();
@@ -979,16 +979,12 @@
 			return -ENXIO;
 		}
 	}
-	save_flags(flags);
-	cli();
 	if (sequencer_busy)
 	{
-		restore_flags(flags);
 		return -EBUSY;
 	}
 	sequencer_busy = 1;
 	obsolete_api_used = 0;
-	restore_flags(flags);
 
 	max_mididev = num_midis;
 	max_synthdev = num_synths;
@@ -1203,16 +1199,11 @@
 
 static int seq_sync(void)
 {
-	unsigned long flags;
-
 	if (qlen && !seq_playing && !signal_pending(current))
 		seq_startplay();
 
-	save_flags(flags);
-	cli();
  	if (qlen > 0)
  		interruptible_sleep_on_timeout(&seq_sleeper, HZ);
-	restore_flags(flags);
 	return qlen;
 }
 
@@ -1233,13 +1224,12 @@
 
 	n = 3 * HZ;		/* Timeout */
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
  	while (n && !midi_devs[dev]->outputc(dev, data)) {
  		interruptible_sleep_on_timeout(&seq_sleeper, HZ/25);
   		n--;
   	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 }
 
 static void seq_reset(void)
@@ -1308,14 +1298,13 @@
 
 	seq_playing = 0;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
 
 	if (waitqueue_active(&seq_sleeper)) {
 		/*      printk( "Sequencer Warning: Unexpected sleeping process - Waking up\n"); */
 		wake_up(&seq_sleeper);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 }
 
 static void seq_panic(void)
@@ -1499,10 +1488,9 @@
 		case SNDCTL_SEQ_OUTOFBAND:
 			if (copy_from_user(&event_rec, arg, sizeof(event_rec)))
 				return -EFAULT;
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&lock,flags);
 			play_event(event_rec.arr);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&lock,flags);
 			return 0;
 
 		case SNDCTL_MIDI_INFO:
@@ -1554,8 +1542,7 @@
 
 	dev = dev >> 4;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
 	/* input */
 	poll_wait(file, &midi_sleeper, wait);
 	if (iqlen)
@@ -1565,7 +1552,7 @@
 	poll_wait(file, &seq_sleeper, wait);
 	if ((SEQ_MAX_QUEUE - qlen) >= output_threshold)
 		mask |= POLLOUT | POLLWRNORM;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 	return mask;
 }
 

