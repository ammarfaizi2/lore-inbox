Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319391AbSH2WUN>; Thu, 29 Aug 2002 18:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319395AbSH2VxG>; Thu, 29 Aug 2002 17:53:06 -0400
Received: from smtpout.mac.com ([204.179.120.89]:21701 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319390AbSH2Vw3>;
	Thu, 29 Aug 2002 17:52:29 -0400
Message-Id: <200208292156.g7TLur72021645@smtp-relay04-en1.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 23/41 sound/oss/mad16.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/mad16.c	Sat Aug 10 00:08:54 2002
+++ linux-2.5-cli-oss/sound/oss/mad16.c	Tue Aug 13 15:37:01 2002
@@ -43,7 +43,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/gameport.h>
-
+#include <linux/spinlock.h>
 #include "sound_config.h"
 
 #include "ad1848.h"
@@ -53,7 +53,7 @@
 static int      mad16_conf;
 static int      mad16_cdsel;
 static struct gameport gameport;
-
+static spinlock_t lock=SPIN_LOCK_UNLOCKED;
 static int      already_initialized = 0;
 
 #define C928	1
@@ -106,8 +106,7 @@
 	unsigned long flags;
 	unsigned char tmp;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
 
 	switch (board_type)	/* Output password */
 	{
@@ -142,7 +141,7 @@
 		if (!c924pnp)
 			tmp = inb(port); else
 			tmp = inb(port-0x80);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 
 	return tmp;
 }
@@ -151,8 +150,7 @@
 {
 	unsigned long   flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
 
 	switch (board_type)	/* Output password */
 	{
@@ -185,7 +183,7 @@
 		if (!c924pnp)
 			outb(((unsigned char) (value & 0xff)), port); else
 			outb(((unsigned char) (value & 0xff)), port-0x80);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 }
 
 static int __init detect_c930(void)

