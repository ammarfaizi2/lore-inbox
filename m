Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319489AbSH2Wgp>; Thu, 29 Aug 2002 18:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319380AbSH2Wfj>; Thu, 29 Aug 2002 18:35:39 -0400
Received: from smtpout.mac.com ([204.179.120.89]:56516 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319371AbSH2Vvm>;
	Thu, 29 Aug 2002 17:51:42 -0400
Message-Id: <200208292156.g7TLu5ZH003829@smtp-relay02.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 17/41 sound/oss/maestro.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/maestro.c	Sat Aug 10 00:08:29 2002
+++ linux-2.5-cli-oss/sound/oss/maestro.c	Tue Aug 13 20:29:28 2002
@@ -2552,12 +2552,12 @@
         case SNDCTL_DSP_RESET:
 		if (file->f_mode & FMODE_WRITE) {
 			stop_dac(s);
-			synchronize_irq();
+			synchronize_irq(s->card->pcidev->irq);
 			s->dma_dac.swptr = s->dma_dac.hwptr = s->dma_dac.count = s->dma_dac.total_bytes = 0;
 		}
 		if (file->f_mode & FMODE_READ) {
 			stop_adc(s);
-			synchronize_irq();
+			synchronize_irq(s->card->pcidev->irq);
 			s->dma_adc.swptr = s->dma_adc.hwptr = s->dma_adc.count = s->dma_adc.total_bytes = 0;
 		}
 		return 0;
@@ -3682,8 +3682,7 @@
 	unsigned long flags;
 	int i,j;
 
-	save_flags(flags); 
-	cli(); /* over-kill */
+	spin_lock_irqsave(&card->lock,flags); /* over-kill */
 
 	M_printk("maestro: apm in dev %p\n",card);
 
@@ -3711,7 +3710,7 @@
 
 	card->in_suspend++;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&card->lock,flags);
 
 	/* we trust in the bios to power down the chip on suspend.
 	 * XXX I'm also not sure that in_suspend will protect
@@ -3725,8 +3724,7 @@
 	unsigned long flags;
 	int i;
 
-	save_flags(flags);
-	cli(); /* over-kill */
+	spin_lock_irqsave(&card->lock,flags); /* over-kill */
 
 	card->in_suspend = 0;
 
@@ -3779,7 +3777,7 @@
 		}
 	}
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&card->lock,flags);
 
 	/* all right, we think things are ready, 
 		wake up people who were using the device

