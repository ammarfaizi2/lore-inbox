Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319370AbSH2VvK>; Thu, 29 Aug 2002 17:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319362AbSH2Vu3>; Thu, 29 Aug 2002 17:50:29 -0400
Received: from smtpout.mac.com ([204.179.120.86]:5842 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319355AbSH2Vt0>;
	Thu, 29 Aug 2002 17:49:26 -0400
Message-Id: <200208292153.g7TLrnKN026074@smtp-relay03.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 4/41 sound/oss/ad1816.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/ad1816.c	Sat Apr 20 18:25:17 2002
+++ linux-2.5-cli-oss/sound/oss/ad1816.c	Tue Aug 13 16:08:27 2002
@@ -37,7 +37,7 @@
 #include <linux/init.h>
 #include <linux/isapnp.h>
 #include <linux/stddef.h>
-
+#include <linux/spinlock.h>
 #include "sound_config.h"
 
 #define DEBUGNOISE(x)
@@ -77,7 +77,7 @@
 				    in ad1816_info */
 	int            irq_ok;
 	int            *osp;
-  
+	spinlock_t	lock;  
 } ad1816_info;
 
 static int nr_ad1816_devs;
@@ -109,12 +109,11 @@
 	
 	CHECK_FOR_POWER;
 
-	save_flags (flags); /* make register access atomic */
-	cli ();
+	spin_lock_irqsave(&devc->lock,flags); /* make register access atomic */
 	outb ((unsigned char) (reg & 0x3f), devc->base+0);
 	result = inb(devc->base+2);
 	result+= inb(devc->base+3)<<8;
-	restore_flags (flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 	
 	return (result);
 }
@@ -126,12 +125,11 @@
 	
 	CHECK_FOR_POWER;
 	
-	save_flags (flags); /* make register access atomic */
-	cli ();
+	spin_lock_irqsave(&devc->lock,flags); /* make register access atomic */
 	outb ((unsigned char) (reg & 0xff), devc->base+0);
 	outb ((unsigned char) (data & 0xff),devc->base+2);
 	outb ((unsigned char) ((data>>8)&0xff),devc->base+3);
-	restore_flags (flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 
 }
 
@@ -147,8 +145,7 @@
 	
 	DEBUGINFO (printk("ad1816: halt_input called\n"));
 	
-	save_flags (flags); 
-	cli ();
+	spin_lock_irqsave(&devc->lock,flags); 
 	
 	if(!isa_dma_bridge_buggy) {
 	        disable_dma(audio_devs[dev]->dmap_in->dma);
@@ -168,7 +165,7 @@
 	outb (~0x40, devc->base+1);	
 	
 	devc->audio_mode &= ~PCM_ENABLE_INPUT;
-	restore_flags (flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 static void ad1816_halt_output (int dev)
@@ -180,8 +177,7 @@
 
 	DEBUGINFO (printk("ad1816: halt_output called!\n"));
 
-	save_flags (flags); 
-	cli ();
+	spin_lock_irqsave(&devc->lock,flags); 
 	/* Mute pcm output */
 	ad_write(devc, 4, ad_read(devc,4)|0x8080);
 
@@ -203,7 +199,7 @@
 	outb ((unsigned char)~0x80, devc->base+1);	
 
 	devc->audio_mode &= ~PCM_ENABLE_OUTPUT;
-	restore_flags (flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 static void ad1816_output_block (int dev, unsigned long buf, 
@@ -217,14 +213,13 @@
   
 	cnt = count/4 - 1;
   
-	save_flags (flags);
-	cli ();
+	spin_lock_irqsave(&devc->lock,flags);
 	
 	/* set transfer count */
 	ad_write (devc, 8, cnt & 0xffff); 
 	
 	devc->audio_mode |= PCM_ENABLE_OUTPUT; 
-	restore_flags (flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 
@@ -239,14 +234,13 @@
 
 	cnt = count/4 - 1;
 
-	save_flags (flags); /* make register access atomic */
-	cli ();
+	spin_lock_irqsave(&devc->lock,flags);
 
 	/* set transfer count */
 	ad_write (devc, 10, cnt & 0xffff); 
 
 	devc->audio_mode |= PCM_ENABLE_INPUT;
-	restore_flags (flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 static int ad1816_prepare_for_input (int dev, int bsize, int bcount)
@@ -258,8 +252,7 @@
 	
 	DEBUGINFO (printk ("ad1816: prepare_for_input called: bsize=%d bcount=%d\n",bsize,bcount));
 
-	save_flags (flags); 
-	cli ();
+	spin_lock_irqsave(&devc->lock,flags);
 	
 	fmt_bits= (devc->format_bits&0x7)<<3;
 	
@@ -290,7 +283,7 @@
 	ad_write (devc, 2, freq & 0xffff);	
 	ad_write (devc, 3, freq & 0xffff);	
 
-	restore_flags (flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 
 	ad1816_halt_input(dev);
 	return 0;
@@ -305,8 +298,7 @@
 
 	DEBUGINFO (printk ("ad1816: prepare_for_output called: bsize=%d bcount=%d\n",bsize,bcount));
 
-	save_flags (flags); /* make register access atomic */
-	cli ();
+	spin_lock_irqsave(&devc->lock,flags);
 
 	fmt_bits= (devc->format_bits&0x7)<<3;
 	/* set mono/stereo mode */
@@ -335,7 +327,7 @@
 	ad_write (devc, 2, freq & 0xffff);
 	ad_write (devc, 3, freq & 0xffff);
 
-	restore_flags (flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 	
 	ad1816_halt_output(dev);
 	return 0;
@@ -351,8 +343,7 @@
 
 	/* mode may have changed */
 
-	save_flags (flags); /* make register access atomic */
-	cli ();
+	spin_lock_irqsave(&devc->lock,flags);
 
 	/* mask out modes not specified on open call */
 	state &= devc->audio_mode; 
@@ -377,7 +368,7 @@
 		/* disable capture */
 		outb(inb(devc->base+8)&~0x01, devc->base+8);
 	}
-	restore_flags (flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 
@@ -480,11 +471,10 @@
 	devc = (ad1816_info *) audio_devs[dev]->devc; 
 
 	/* make check if device already open atomic */
-	save_flags (flags); 
-	cli ();
+	spin_lock_irqsave(&devc->lock,flags);
 
 	if (devc->opened) {
-		restore_flags (flags);
+		spin_unlock_irqrestore(&devc->lock,flags);
 		return -(EBUSY);
 	}
 
@@ -497,7 +487,7 @@
 	devc->channels=1;
 
 	ad1816_reset(devc->dev_no); /* halt all pending output */
-	restore_flags (flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 	return 0;
 }
 
@@ -506,8 +496,7 @@
 	unsigned long flags;
 	ad1816_info    *devc = (ad1816_info *) audio_devs[dev]->devc;
 
-	save_flags (flags); 
-	cli ();
+	spin_lock_irqsave(&devc->lock,flags);
 
 	/* halt all pending output */
 	ad1816_reset(devc->dev_no); 
@@ -518,8 +507,7 @@
 	devc->audio_format=AFMT_U8;
 	devc->format_bits = 0;
 
-
-	restore_flags (flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 
@@ -556,7 +544,6 @@
 	unsigned char	status;
 	ad1816_info	*devc;
 	int		dev;
-	unsigned long	flags;
 
 	
 	if (irq < 0 || irq > 15) {
@@ -574,8 +561,7 @@
 
 	devc = (ad1816_info *) audio_devs[dev]->devc;
 	
-	save_flags(flags);
-	cli();
+	spin_lock(&devc->lock);
 
 	/* read interrupt register */
 	status = inb (devc->base+1); 
@@ -595,7 +581,7 @@
 	if (devc->opened && (devc->audio_mode & PCM_ENABLE_OUTPUT) && (status & 128))
 		DMAbuf_outputintr (dev, 1);
 
-	restore_flags(flags);
+	spin_unlock(&devc->lock);
 }
 
 /* ------------------------------------------------------------------- */
@@ -1033,6 +1019,7 @@
 	devc->irq = 0;
 	devc->opened = 0;
 	devc->osp = osp;
+	spin_lock_init(&devc->lock);
 
 	/* base+0: bit 1 must be set but not 255 */
 	tmp=inb(devc->base);

