Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319373AbSH2VvG>; Thu, 29 Aug 2002 17:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319369AbSH2Vuv>; Thu, 29 Aug 2002 17:50:51 -0400
Received: from smtpout.mac.com ([204.179.120.86]:8146 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319356AbSH2Vte>;
	Thu, 29 Aug 2002 17:49:34 -0400
Message-Id: <200208292153.g7TLrvVw009029@smtp-relay01.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 5/41 sound/oss/sscape.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/sscape.c	Sat Apr 20 18:25:21 2002
+++ linux-2.5-cli-oss/sound/oss/sscape.c	Tue Aug 13 15:36:38 2002
@@ -40,6 +40,7 @@
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/wrapper.h>
+#include <linux/spinlock.h>
 
 #include "coproc.h"
 
@@ -115,7 +116,7 @@
 	char*	raw_buf;
 	unsigned long	raw_buf_phys;
 	int	buffsize;		/* -------------------------- */
-	
+	spinlock_t lock;
 	int	ok;	/* Properly detected */
 	int	failed;
 	int	dma_allocated;
@@ -164,11 +165,10 @@
 	unsigned long flags;
 	unsigned char val;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	outb(reg, PORT(ODIE_ADDR));
 	val = inb(PORT(ODIE_DATA));
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 	return val;
 }
 
@@ -176,11 +176,10 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	outb(reg, PORT(ODIE_ADDR));
 	outb(data, PORT(ODIE_DATA));
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 static unsigned char sscape_pnp_read_codec(sscape_info* devc, unsigned char reg)
@@ -188,11 +187,10 @@
 	unsigned char res;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();	
+	spin_lock_irqsave(&devc->lock,flags);
 	outb( reg, devc -> codec);
 	res = inb (devc -> codec + 1);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 	return res;
 
 }
@@ -201,11 +199,10 @@
 {
 	unsigned long flags;
 	
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	outb( reg, devc -> codec);
 	outb( data, devc -> codec + 1);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 static void host_open(struct sscape_info *devc)
@@ -223,9 +220,7 @@
 	unsigned long flags;
 	int i, timeout_val;
 
-	save_flags(flags);
-	cli();
-
+	spin_lock_irqsave(&devc->lock,flags);
 	/*
 	 * Send the command and data bytes
 	 */
@@ -238,12 +233,12 @@
 
 		if (timeout_val <= 0)
 		{
-			    restore_flags(flags);
+				spin_unlock_irqrestore(&devc->lock,flags);
 			    return 0;
 		}
 		outb(data[i], PORT(HOST_DATA));
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 	return 1;
 }
 
@@ -253,9 +248,7 @@
 	int timeout_val;
 	unsigned char data;
 
-	save_flags(flags);
-	cli();
-
+	spin_lock_irqsave(&devc->lock,flags);
 	/*
 	 * Read a byte
 	 */
@@ -266,11 +259,11 @@
 
 	if (timeout_val <= 0)
 	{
-		restore_flags(flags);
+		spin_unlock_irqrestore(&devc->lock,flags);
 		return -1;
 	}
 	data = inb(PORT(HOST_DATA));
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 	return data;
 }
 
@@ -391,14 +384,13 @@
 	struct sscape_info *devc = dev_info;
 	unsigned long   flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	if (devc->dma_allocated)
 	{
 		sscape_write(devc, GA_DMAA_REG, 0x20);	/* DMA channel disabled */
 		devc->dma_allocated = 0;
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 	return;
 }
 
@@ -420,14 +412,13 @@
 		 * before continuing.
 		 */
 
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&devc->lock,flags);
 		codec_dma_bits = sscape_read(devc, GA_CDCFG_REG);
 
 		if (devc->dma_allocated == 0)
 			devc->dma_allocated = 1;
 
-		restore_flags(flags);
+		spin_unlock_irqrestore(&devc->lock,flags);
 
 		sscape_write(devc, GA_HMCTL_REG, 
 			(temp = sscape_read(devc, GA_HMCTL_REG)) & 0x3f);	/*Reset */
@@ -449,8 +440,7 @@
 	}
 	memcpy(audio_devs[devc->codec_audiodev]->dmap_out->raw_buf, block, size);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	
 	/******** INTERRUPTS DISABLED NOW ********/
 	
@@ -475,7 +465,7 @@
 			done = 1;
 	}
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 	if (!done)
 		return 0;
 
@@ -494,9 +484,7 @@
 		/*
 		 * Wait until the ODB wakes up
 		 */
-
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&devc->lock,flags);
 		done = 0;
 		timeout_val = 5 * HZ;
 		while (!done && timeout_val-- > 0)
@@ -513,14 +501,13 @@
 		}
 		sscape_write(devc, GA_CDCFG_REG, codec_dma_bits);
 
-		restore_flags(flags);
+		spin_unlock_irqrestore(&devc->lock,flags);
 		if (!done)
 		{
 			printk(KERN_ERR "soundscape: The OBP didn't respond after code download\n");
 			return 0;
 		}
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&devc->lock,flags);
 		done = 0;
 		timeout_val = 5 * HZ;
 		while (!done && timeout_val-- > 0)
@@ -529,7 +516,7 @@
 			if (inb(PORT(HOST_DATA)) == 0xfe)	/* Host startup acknowledge */
 				done = 1;
 		}
-		restore_flags(flags);
+		spin_unlock_irqrestore(&devc->lock,flags);
 		if (!done)
 		{
 			printk(KERN_ERR "soundscape: OBP Initialization failed.\n");
@@ -675,8 +662,7 @@
 	
 	if (!sscape_is_pnp) {
 	
-	    save_flags(flags);
-	    cli();
+		spin_lock_irqsave(&devc->lock,flags);
 	    for (i = 1; i < 10; i++)
 	    {
 		switch (i)
@@ -710,7 +696,7 @@
 				sscape_write(devc, i, regs[i]);
 		}
 	    }
-	    restore_flags(flags);
+		spin_unlock_irqrestore(&devc->lock,flags);
 	}
 #ifdef SSCAPE_DEBUG2
 	/*
@@ -960,8 +946,7 @@
 		    return 0;
 	}
 	dt = data;
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);
 	while ( len > 0 ) {
 		if (len > devc -> buffsize) l = devc->buffsize;
 		else l = len;
@@ -970,12 +955,12 @@
 		sscape_start_dma(devc->dma, devc->raw_buf_phys, l, 0x48);
 		sscape_pnp_start_dma ( devc, 0 );
 		if (sscape_pnp_wait_dma ( devc, 0 ) == 0) {
-			restore_flags(flags);	    
+			spin_unlock_irqrestore(&devc->lock,flags);
 			return 0;
 		}
 	}
 	
-	restore_flags(flags);	    
+	spin_unlock_irqrestore(&devc->lock,flags);
 	vfree(data);
 	
 	outb(0, devc -> base + 2);
@@ -1469,6 +1454,7 @@
 	devc->codec_type = 0;
 	devc->ic_type = 0;
 	devc->raw_buf = NULL;
+	spin_lock_init(&devc->lock);
 
 	if (cfg.dma == -1 || cfg.irq == -1 || cfg.io_base == -1) {
 		printk(KERN_ERR "DMA, IRQ, and IO port must be specified.\n");

