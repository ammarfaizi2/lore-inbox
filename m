Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319435AbSH2WVT>; Thu, 29 Aug 2002 18:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319396AbSH2WUT>; Thu, 29 Aug 2002 18:20:19 -0400
Received: from smtpout.mac.com ([204.179.120.89]:41925 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319383AbSH2Vwy>;
	Thu, 29 Aug 2002 17:52:54 -0400
Message-Id: <200208292157.g7TLvHVw009380@smtp-relay01.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 26/41 sound/oss/opl3sa.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/opl3sa.c	Sat Apr 20 18:25:21 2002
+++ linux-2.5-cli-oss/sound/oss/opl3sa.c	Tue Aug 13 15:36:09 2002
@@ -22,6 +22,7 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/spinlock.h>
 
 #undef  SB_OK
 
@@ -37,7 +38,7 @@
 
 static int kilroy_was_here = 0;	/* Don't detect twice */
 static int mpu_initialized = 0;
-
+static spinlock_t lock=SPIN_LOCK_UNLOCKED;
 static int *opl3sa_osp = NULL;
 
 static unsigned char opl3sa_read(int addr)
@@ -45,12 +46,11 @@
 	unsigned long flags;
 	unsigned char tmp;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
 	outb((0x1d), 0xf86);	/* password */
 	outb(((unsigned char) addr), 0xf86);	/* address */
 	tmp = inb(0xf87);	/* data */
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 
 	return tmp;
 }
@@ -59,12 +59,11 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
 	outb((0x1d), 0xf86);	/* password */
 	outb(((unsigned char) addr), 0xf86);	/* address */
 	outb(((unsigned char) data), 0xf87);	/* data */
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 }
 
 static int __init opl3sa_detect(void)

