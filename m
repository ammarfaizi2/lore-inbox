Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319497AbSH2Wqz>; Thu, 29 Aug 2002 18:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319503AbSH2WqQ>; Thu, 29 Aug 2002 18:46:16 -0400
Received: from smtpout.mac.com ([204.179.120.97]:60119 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319361AbSH2VvK>;
	Thu, 29 Aug 2002 17:51:10 -0400
Message-Id: <200208292155.g7TLtXVw009183@smtp-relay01.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 13/41 sound/oss/pas2_midi.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/pas2_midi.c	Sat Apr 20 18:25:21 2002
+++ linux-2.5-cli-oss/sound/oss/pas2_midi.c	Wed Aug 14 19:44:58 2002
@@ -14,10 +14,13 @@
  */
 
 #include <linux/init.h>
+#include <linux/spinlock.h>
 #include "sound_config.h"
 
 #include "pas2.h"
 
+extern spinlock_t lock;
+
 static int      midi_busy = 0, input_opened = 0;
 static int      my_dev;
 
@@ -48,12 +51,11 @@
 	pas_write(0x20 | 0x40,
 		  0x178b);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);
 
 	if ((err = pas_set_intr(0x10)) < 0)
 	{
-		restore_flags(flags);
+		spin_unlock_irqrestore(&lock, flags);
 		return err;
 	}
 	/*
@@ -81,7 +83,7 @@
 
 	pas_write(0xff, 0x1B88);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock, flags);
 
 	midi_busy = 1;
 	qlen = qhead = qtail = 0;
@@ -131,8 +133,7 @@
 	 * Drain the local queue first
 	 */
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);
 
 	while (qlen && dump_to_midi(tmp_queue[qhead]))
 	{
@@ -140,7 +141,7 @@
 		qhead++;
 	}
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock, flags);
 
 	/*
 	 *	Output the byte if the local queue is empty.
@@ -157,14 +158,13 @@
 	if (qlen >= 256)
 		return 0;	/* Local queue full */
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);
 
 	tmp_queue[qtail] = midi_byte;
 	qlen++;
 	qtail++;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock, flags);
 
 	return 1;
 }
@@ -226,7 +226,6 @@
 {
 	unsigned char   stat;
 	int             i, incount;
-	unsigned long   flags;
 
 	stat = pas_read(0x1B88);
 
@@ -245,8 +244,7 @@
 	}
 	if (stat & (0x08 | 0x10))
 	{
-		save_flags(flags);
-		cli();
+		spin_lock(&lock);/* called in irq context */
 
 		while (qlen && dump_to_midi(tmp_queue[qhead]))
 		{
@@ -254,7 +252,7 @@
 			qhead++;
 		}
 
-		restore_flags(flags);
+		spin_unlock(&lock);
 	}
 	if (stat & 0x40)
 	{

