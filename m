Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319439AbSH2WVR>; Thu, 29 Aug 2002 18:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319392AbSH2WU3>; Thu, 29 Aug 2002 18:20:29 -0400
Received: from smtpout.mac.com ([204.179.120.86]:35028 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319388AbSH2VxM>;
	Thu, 29 Aug 2002 17:53:12 -0400
Message-Id: <200208292157.g7TLvZKN026549@smtp-relay03.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 28/41 sound/oss/wavfront.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/wavfront.c	Sat Aug 10 00:04:15 2002
+++ linux-2.5-cli-oss/sound/oss/wavfront.c	Thu Aug 15 14:34:05 2002
@@ -76,7 +76,7 @@
 #include <linux/ptrace.h>
 #include <linux/fcntl.h>
 #include <linux/ioport.h>    
-
+#include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/config.h>
 
@@ -274,6 +274,7 @@
 	wait_queue_head_t interrupt_sleeper; 
 } dev;
 
+static spinlock_t lock=SPIN_LOCK_UNLOCKED;
 static int  detect_wffx(void);
 static int  wffx_ioctl (wavefront_fx_info *);
 static int  wffx_init (void);
@@ -2202,12 +2203,12 @@
 {
 	unsigned long flags;
 
-	save_flags (flags);
-	cli();
+	/* this will not help on SMP - but at least it compiles */
+	spin_lock_irqsave(&lock, flags);
 	dev.irq_ok = 0;
 	outb (val,port);
 	interruptible_sleep_on_timeout (&dev.interrupt_sleeper, timeout);
-	restore_flags (flags);
+	spin_unlock_irqrestore(&lock,flags);
 }
 
 static int __init wavefront_hw_reset (void)
@@ -2223,8 +2224,6 @@
 
 	printk (KERN_DEBUG LOGNAME "autodetecting WaveFront IRQ\n");
 
-	sti ();
-
 	irq_mask = probe_irq_on ();
 
 	outb (0x0, dev.control_port); 

