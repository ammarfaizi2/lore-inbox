Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319356AbSH2Wgt>; Thu, 29 Aug 2002 18:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319375AbSH2WgD>; Thu, 29 Aug 2002 18:36:03 -0400
Received: from smtpout.mac.com ([204.179.120.97]:63447 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319362AbSH2VvR>;
	Thu, 29 Aug 2002 17:51:17 -0400
Message-Id: <200208292155.g7TLteVw009198@smtp-relay01.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 14/41 sound/oss/uart6850.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/uart6850.c	Sat Apr 20 18:25:21 2002
+++ linux-2.5-cli-oss/sound/oss/uart6850.c	Tue Aug 13 15:51:12 2002
@@ -23,7 +23,7 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
-
+#include <linux/spinlock.h>
 /* Mon Nov 22 22:38:35 MET 1993 marco@driq.home.usn.nl:
  *      added 6850 support, used with COVOX SoundMaster II and custom cards.
  */
@@ -71,6 +71,7 @@
 static int uart6850_irq;
 static int uart6850_detected;
 static int my_dev;
+static spinlock_t lock=SPIN_LOCK_UNLOCKED;
 
 static void (*midi_input_intr) (int dev, unsigned char data);
 static void poll_uart6850(unsigned long dummy);
@@ -122,9 +123,7 @@
 	if (!(uart6850_opened & OPEN_READ))
 		return;		/* Device has been closed */
 
-	save_flags(flags);
-	cli();
-
+	spin_lock_irqsave(&lock,flags);
 	if (input_avail())
 		uart6850_input_loop();
 
@@ -135,7 +134,7 @@
 	 *	Come back later
 	 */
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 }
 
 static int uart6850_open(int dev, int mode,
@@ -176,13 +175,12 @@
 	 * Test for input since pending input seems to block the output.
 	 */
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
 
 	if (input_avail())
 		uart6850_input_loop();
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 
 	/*
 	 * Sometimes it takes about 13000 loops before the output becomes ready
@@ -265,15 +263,14 @@
 	uart6850_osp = hw_config->osp;
 	uart6850_irq = hw_config->irq;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
 
 	for (timeout = 30000; timeout > 0 && !output_ready(); timeout--);	/*
 										 * Wait
 										 */
 	uart6850_cmd(UART_MODE_ON);
 	ok = 1;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 
 	conf_printf("6850 Midi Interface", hw_config);
 

