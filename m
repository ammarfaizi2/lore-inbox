Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319381AbSH2Wfc>; Thu, 29 Aug 2002 18:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319380AbSH2VvZ>; Thu, 29 Aug 2002 17:51:25 -0400
Received: from smtpout.mac.com ([204.179.120.88]:3320 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319356AbSH2Vuz>;
	Thu, 29 Aug 2002 17:50:55 -0400
Message-Id: <200208292155.g7TLtI72021485@smtp-relay04-en1.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 11/41 sound/oss/pas2_pcm.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/pas2_pcm.c	Sat Apr 20 18:25:21 2002
+++ linux-2.5-cli-oss/sound/oss/pas2_pcm.c	Thu Aug 15 14:35:07 2002
@@ -16,6 +16,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/spinlock.h>
 #include "sound_config.h"
 
 #include "pas2.h"
@@ -44,6 +45,8 @@
 int             pas_audiodev = -1;
 static int      open_mode = 0;
 
+extern spinlock_t lock;
+
 static int pcm_set_speed(int arg)
 {
 	int foo, tmp;
@@ -101,8 +104,7 @@
 	pcm_filter = tmp;
 #endif
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);
 
 	pas_write(tmp & ~(0x40 | 0x80), 0x0B8A);
 	pas_write(0x00 | 0x30 | 0x04, 0x138B);
@@ -110,7 +112,7 @@
 	pas_write((foo >> 8) & 0xff, 0x1388);
 	pas_write(tmp, 0x0B8A);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock, flags);
 
 	return pcm_speed;
 }
@@ -212,15 +214,14 @@
 
 	DEB(printk("pas2_pcm.c: static int pas_audio_open(int mode = %X)\n", mode));
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);
 	if (pcm_busy)
 	{
-		restore_flags(flags);
+		spin_unlock_irqrestore(&lock, flags);
 		return -EBUSY;
 	}
 	pcm_busy = 1;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock, flags);
 
 	if ((err = pas_set_intr(PAS_PCM_INTRBITS)) < 0)
 		return err;
@@ -238,15 +239,14 @@
 
 	DEB(printk("pas2_pcm.c: static void pas_audio_close(void)\n"));
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);
 
 	pas_audio_reset(dev);
 	pas_remove_intr(PAS_PCM_INTRBITS);
 	pcm_mode = PCM_NON;
 
 	pcm_busy = 0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock, flags);
 }
 
 static void pas_audio_output_block(int dev, unsigned long buf, int count,
@@ -265,8 +265,7 @@
 	    cnt == pcm_count)
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);
 
 	pas_write(pas_read(0xF8A) & ~0x40,
 		  0xF8A);
@@ -293,7 +292,7 @@
 
 	pcm_mode = PCM_DAC;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock, flags);
 }
 
 static void pas_audio_start_input(int dev, unsigned long buf, int count,
@@ -313,8 +312,7 @@
 	    cnt == pcm_count)
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);
 
 	/* DMAbuf_start_dma (dev, buf, count, DMA_MODE_READ); */
 
@@ -338,7 +336,7 @@
 
 	pcm_mode = PCM_ADC;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock, flags);
 }
 
 #ifndef NO_TRIGGER
@@ -346,8 +344,7 @@
 {
 	unsigned long   flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);
 	state &= open_mode;
 
 	if (state & PCM_ENABLE_OUTPUT)
@@ -357,7 +354,7 @@
 	else
 		pas_write(pas_read(0xF8A) & ~0x40, 0xF8A);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock, flags);
 }
 #endif
 

