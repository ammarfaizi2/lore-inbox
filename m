Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316996AbSIIKDi>; Mon, 9 Sep 2002 06:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSIIKDU>; Mon, 9 Sep 2002 06:03:20 -0400
Received: from smtpout.mac.com ([204.179.120.89]:20948 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S316935AbSIIKC4>;
	Mon, 9 Sep 2002 06:02:56 -0400
Message-Id: <200209091007.g89A7dOg000967@smtp-relay04-en1.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 10/10 sound/oss/dmasound/dmasound_q40.c
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.33/sound/oss/dmasound/dmasound_q40.c	Sun Sep  8 21:52:50 2002
+++ linux-2.5-cli-oss/sound/oss/dmasound/dmasound_q40.c	Mon Sep  9 00:41:06 2002
@@ -18,7 +18,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/soundcard.h>
-
+#include <linux/spinlock.h>
 #include <asm/uaccess.h>
 #include <asm/q40ints.h>
 #include <asm/q40_master.h>
@@ -49,8 +49,7 @@
 static int Q40SetVolume(int volume);
 static void Q40PlayNextFrame(int index);
 static void Q40Play(void);
-static void Q40StereoInterrupt(int irq, void *dummy, struct pt_regs *fp);
-static void Q40MonoInterrupt(int irq, void *dummy, struct pt_regs *fp);
+static void Q40InterruptHandler(int irq, void *dummy, struct pt_regs *fp);
 static void Q40Interrupt(void);
 
 
@@ -384,7 +383,7 @@
 static int __init Q40IrqInit(void)
 {
 	/* Register interrupt handler. */
-	request_irq(Q40_IRQ_SAMPLE, Q40StereoInterrupt, 0,
+	request_irq(Q40_IRQ_SAMPLE, Q40InterruptHandler, 0,
 		    "DMA sound", Q40Interrupt);
 
 	return(1);
@@ -430,23 +429,13 @@
 	speed=(dmasound.hard.speed==10000 ? 0 : 1);
 
 	master_outb( 0,SAMPLE_ENABLE_REG);
-	free_irq(Q40_IRQ_SAMPLE, Q40Interrupt);
-	if (dmasound.soft.stereo)
-	  	request_irq(Q40_IRQ_SAMPLE, Q40StereoInterrupt, 0,
-		    "Q40 sound", Q40Interrupt);
-	  else
-	        request_irq(Q40_IRQ_SAMPLE, Q40MonoInterrupt, 0,
-		    "Q40 sound", Q40Interrupt);
-
 	master_outb( speed, SAMPLE_RATE_REG);
 	master_outb( 1,SAMPLE_CLEAR_REG);
 	master_outb( 1,SAMPLE_ENABLE_REG);
 }
 
-static void Q40Play(void)
+static void __Q40Play(void)
 {
-        unsigned long flags;
-
 	if (write_sq.active || write_sq.count<=0 ) {
 		/* There's already a frame loaded */
 		return;
@@ -459,29 +448,35 @@
 		  */
 	         return;
 	}
-	save_flags(flags); cli();
 	Q40PlayNextFrame(1);
-	restore_flags(flags);
 }
 
-static void Q40StereoInterrupt(int irq, void *dummy, struct pt_regs *fp)
-{
-        if (q40_sc>1){
-            *DAC_LEFT=*q40_pp++;
-	    *DAC_RIGHT=*q40_pp++;
-	    q40_sc -=2;
-	    master_outb(1,SAMPLE_CLEAR_REG);
-	}else Q40Interrupt();
-}
-static void Q40MonoInterrupt(int irq, void *dummy, struct pt_regs *fp)
+static void Q40Play(void)
 {
-        if (q40_sc>0){
-            *DAC_LEFT=*q40_pp;
-	    *DAC_RIGHT=*q40_pp++;
-	    q40_sc --;
+	unsigned long flags;
+	spin_lock_irqsave(&dmasound.lock, flags);
+	__Q40Play();
+	spin_unlock_irqrestore(&dmasound.lock, flags);
+}
+
+static void Q40InterruptHandler(int irq, void *dummy, struct pt_regs *fp)
+{
+	spin_lock(&dmasound.lock);
+	if (q40_sc>1){
+		if (dmasound.soft.stereo){
+			*DAC_LEFT=*q40_pp++;
+			*DAC_RIGHT=*q40_pp++;
+			q40_sc -=2;
+		} else {
+			*DAC_LEFT=*q40_pp;
+			*DAC_RIGHT=*q40_pp++;
+			q40_sc --;
+		}
 	    master_outb(1,SAMPLE_CLEAR_REG);
 	}else Q40Interrupt();
+	spin_unlock(&dmasound.lock);
 }
+
 static void Q40Interrupt(void)
 {
 	if (!write_sq.active) {
@@ -493,7 +488,7 @@
 		   goto exit;
 	} else write_sq.active=0;
 	write_sq.count--;
-	Q40Play();
+	__Q40Play();
 
 	if (q40_sc<2)
 	      { /* there was nothing to play, disable irq */
