Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbULQX7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbULQX7Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 18:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbULQX7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 18:59:25 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:39143 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S262231AbULQX7H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 18:59:07 -0500
From: James Nelson <james4765@verizon.net>
To: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@verizon.net>
Message-Id: <20041217235927.17998.75228.61750@localhost.localdomain>
Subject: [PATCH] lcd: replace cli()/sti() with spin_lock_irqsave()/spin_unlock_irqrestore()
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [209.158.220.243] at Fri, 17 Dec 2004 17:59:05 -0600
Date: Fri, 17 Dec 2004 17:59:05 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the cli()/sti() calls in drivers/char/lcd.c

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-rc3-mm1-original/drivers/char/lcd.c linux-2.6.10-rc3-mm1/drivers/char/lcd.c
--- linux-2.6.10-rc3-mm1-original/drivers/char/lcd.c	2004-12-03 16:53:42.000000000 -0500
+++ linux-2.6.10-rc3-mm1/drivers/char/lcd.c	2004-12-17 18:57:10.760197439 -0500
@@ -33,6 +33,8 @@
 
 #include "lcd.h"
 
+static spinlock_t lcd_lock = SPIN_LOCK_UNLOCKED;
+
 static int lcd_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg);
 
@@ -464,14 +466,13 @@
 			}
 
 			printk("Churning and Burning -");
-			save_flags(flags);
 			for (i = 0; i < FLASH_SIZE; i = i + 128) {
 
 				if (copy_from_user
 				    (rom, display.RomImage + i, 128))
 					return -EFAULT;
 				burn_addr = kFlashBase + i;
-				cli();
+				spin_lock_irqsave(&lcd_lock, flags);
 				for (index = 0; index < (128); index++) {
 
 					WRITE_FLASH(kFlash_Addr1,
@@ -492,7 +493,7 @@
 					}
 					burn_addr++;
 				}
-				restore_flags(flags);
+				spin_unlock_irqrestore(&lcd_lock, flags);
 				if (*
 				    ((volatile unsigned char *) (burn_addr
 								 - 1)) ==
