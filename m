Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319371AbSH2Wgs>; Thu, 29 Aug 2002 18:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319356AbSH2Wfz>; Thu, 29 Aug 2002 18:35:55 -0400
Received: from smtpout.mac.com ([204.179.120.86]:29651 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319375AbSH2VvY>;
	Thu, 29 Aug 2002 17:51:24 -0400
Message-Id: <200208292155.g7TLtlZH003783@smtp-relay02.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 15/41 sound/oss/uart401.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/uart401.c	Sat Apr 20 18:25:21 2002
+++ linux-2.5-cli-oss/sound/oss/uart401.c	Tue Aug 13 15:47:06 2002
@@ -23,7 +23,7 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
-
+#include <linux/spinlock.h>
 #include "sound_config.h"
 
 #include "mpu401.h"
@@ -38,6 +38,7 @@
 	volatile unsigned char input_byte;
 	int             my_dev;
 	int             share_irq;
+	spinlock_t	lock;
 }
 uart401_devc;
 
@@ -152,13 +153,11 @@
 	 * Test for input since pending input seems to block the output.
 	 */
 
-	save_flags(flags);
-	cli();
-
+	spin_lock_irqsave(&devc->lock,flags);	
 	if (input_avail(devc))
 		uart401_input_loop(devc);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 
 	/*
 	 * Sometimes it takes about 13000 loops before the output becomes ready
@@ -222,8 +221,7 @@
 	int ok, timeout;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);	
 	for (timeout = 30000; timeout > 0 && !output_ready(devc); timeout--);
 
 	devc->input_byte = 0;
@@ -237,7 +235,7 @@
 			if (uart401_read(devc) == MPU_ACK)
 				ok = 1;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 }
 
 static int reset_uart401(uart401_devc * devc)
@@ -320,11 +318,11 @@
 	devc->input_byte = 0;
 	devc->my_dev = 0;
 	devc->share_irq = 0;
+	spin_lock_init(&devc->lock);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock,flags);	
 	ok = reset_uart401(devc);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock,flags);
 
 	if (!ok)
 		goto cleanup_devc;

