Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319488AbSH2Wfa>; Thu, 29 Aug 2002 18:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319382AbSH2Vvs>; Thu, 29 Aug 2002 17:51:48 -0400
Received: from smtpout.mac.com ([204.179.120.89]:8900 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319354AbSH2VuW>;
	Thu, 29 Aug 2002 17:50:22 -0400
Message-Id: <200208292154.g7TLsjVw009095@smtp-relay01.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 7/41 sound/oss/mpu401.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/mpu401.c	Sat Apr 20 18:26:22 2002
+++ linux-2.5-cli-oss/sound/oss/mpu401.c	Tue Aug 13 15:33:08 2002
@@ -19,7 +19,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
-
+#include <linux/spinlock.h>
 #define USE_SEQ_MACROS
 #define USE_SIMPLE_MACROS
 
@@ -68,6 +68,7 @@
 	  void            (*inputintr) (int dev, unsigned char data);
 	  int             shared_irq;
 	  int            *osp;
+	  spinlock_t	lock;
   };
 
 #define	DATAPORT(base)   (base)
@@ -408,11 +409,10 @@
 	int busy;
 	int n;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	busy = devc->m_busy;
 	devc->m_busy = 1;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 
 	if (busy)		/* Already inside the scanner */
 		return;
@@ -447,7 +447,6 @@
 	struct mpu_config *devc;
 	int dev = (int) dev_id;
 
-	sti();
 	devc = &dev_conf[dev];
 
 	if (input_avail(devc))
@@ -559,16 +558,15 @@
 
 	for (timeout = 30000; timeout > 0 && !output_ready(devc); timeout--);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	if (!output_ready(devc))
 	{
 		printk(KERN_WARNING "mpu401: Send data timeout\n");
-		restore_flags(flags);
+		spin_unlock_irqrestore(&devc->lock,flags);
 		return 0;
 	}
 	write_data(devc, midi_byte);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 	return 1;
 }
 
@@ -606,13 +604,12 @@
 		printk(KERN_WARNING "mpu401: Command (0x%x) timeout\n", (int) cmd->cmd);
 		return -EIO;
 	}
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 
 	if (!output_ready(devc))
 	{
-		  restore_flags(flags);
-		  goto retry;
+		spin_unlock_irqrestore(&devc->lock,flags);
+		goto retry;
 	}
 	write_command(devc, cmd->cmd);
 
@@ -636,7 +633,7 @@
 	}
 	if (!ok)
 	{
-		restore_flags(flags);
+		spin_unlock_irqrestore(&devc->lock,flags);
 		return -EIO;
 	}
 	if (cmd->nr_args)
@@ -647,7 +644,7 @@
 
 			if (!mpu401_out(dev, cmd->data[i]))
 			{
-				restore_flags(flags);
+				spin_unlock_irqrestore(&devc->lock,flags);
 				printk(KERN_WARNING "mpu401: Command (0x%x), parm send failed.\n", (int) cmd->cmd);
 				return -EIO;
 			}
@@ -669,12 +666,12 @@
 				}
 			if (!ok)
 			{
-				restore_flags(flags);
+				spin_unlock_irqrestore(&devc->lock,flags);
 				return -EIO;
 			}
 		}
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 	return ret;
 }
 
@@ -941,16 +938,15 @@
 
 	devc->version = devc->revision = 0;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	if ((tmp = mpu_cmd(n, 0xAC, 0)) < 0)
 	{
-		restore_flags(flags);
+		spin_unlock_irqrestore(&devc->lock,flags);
 		return;
 	}
 	if ((tmp & 0xf0) > 0x20)	/* Why it's larger than 2.x ??? */
 	{
-		restore_flags(flags);
+		spin_unlock_irqrestore(&devc->lock,flags);
 		return;
 	}
 	devc->version = tmp;
@@ -958,11 +954,11 @@
 	if ((tmp = mpu_cmd(n, 0xAD, 0)) < 0)
 	{
 		devc->version = 0;
-		restore_flags(flags);
+		spin_unlock_irqrestore(&devc->lock,flags);
 		return;
 	}
 	devc->revision = tmp;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 void attach_mpu401(struct address_info *hw_config, struct module *owner)
@@ -995,6 +991,7 @@
 	devc->m_state = ST_INIT;
 	devc->shared_irq = hw_config->always_detect;
 	devc->irq = hw_config->irq;
+	spin_lock_init(&devc->lock);
 
 	if (devc->irq < 0)
 	{
@@ -1020,12 +1017,11 @@
 				return;
 			}
 		}
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&devc->lock,flags);
 		mpu401_chk_version(m, devc);
 		if (devc->version == 0)
 			mpu401_chk_version(m, devc);
-		restore_flags(flags);
+			spin_unlock_irqrestore(&devc->lock,flags);
 	}
 	request_region(hw_config->io_base, 2, "mpu401");
 
@@ -1154,12 +1150,11 @@
 
 		for (timeout = timeout_limit * 2; timeout > 0 && !ok; timeout--)
 		{
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&devc->lock,flags);
 			if (input_avail(devc))
 				if (read_data(devc) == MPU_ACK)
 					ok = 1;
-			restore_flags(flags);
+			spin_unlock_irqrestore(&devc->lock,flags);
 		}
 
 	}
@@ -1289,16 +1284,15 @@
 
 }
 
-static void tmr_reset(void)
+static void tmr_reset(struct mpu_config *devc)
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	next_event_time = (unsigned long) -1;
 	prev_event_time = 0;
 	curr_ticks = curr_clocks = 0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 static void set_timer_mode(int midi_dev)
@@ -1353,7 +1347,9 @@
 
 static int mpu_start_timer(int midi_dev)
 {
-	tmr_reset();
+	struct mpu_config *devc= &dev_conf[midi_dev];
+
+	tmr_reset(devc);
 	set_timer_mode(midi_dev);
 
 	if (tmr_running)
@@ -1378,11 +1374,12 @@
 static int mpu_timer_open(int dev, int mode)
 {
 	int midi_dev = sound_timer_devs[dev]->devlink;
+	struct mpu_config *devc= &dev_conf[midi_dev];
 
 	if (timer_open)
 		return -EBUSY;
 
-	tmr_reset();
+	tmr_reset(devc);
 	curr_tempo = 50;
 	mpu_cmd(midi_dev, 0xE0, 50);
 	curr_timebase = hw_timebase = 120;

