Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbULUBva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbULUBva (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 20:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbULUBva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 20:51:30 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:7362 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261159AbULUBu7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 20:50:59 -0500
From: James Nelson <james4765@verizon.net>
To: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@verizon.net>
Message-Id: <20041221015120.29110.98832.48706@localhost.localdomain>
Subject: [PATCH] lcd: fix memory leak, code cleanup
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.220.243] at Mon, 20 Dec 2004 19:50:58 -0600
Date: Mon, 20 Dec 2004 19:50:59 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses the following issues:

Fix log-spamming and cryptic error messages, and add KERN_ constants.
Convert some ints to unsigned ints.
Add checks for CAP_SYS_ADMIN for FLASH_Burn and FLASH_Erase ioctls.
Identify use of global variable.
Fix memory leak in FLASH_Burn ioctl.
Fix error return codes in lcd_ioctl().
Move variable "index" in lcd_ioctl() to smaller scope to reduce memory usage.
Convert cli()/sti() to spin_lock_irqsave()/spin_unlock_irqrestore().
Fix legibility issues in FLASH_Burn ioctl.

Diffstat output:
 lcd.c |   86 +++++++++++++++++++++++++++++++++---------------------------------
 lcd.h |    2 +
 2 files changed, 46 insertions(+), 42 deletions(-)

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-rc3-mm1-original/drivers/char/lcd.c linux-2.6.10-rc3-mm1/drivers/char/lcd.c
--- linux-2.6.10-rc3-mm1-original/drivers/char/lcd.c	2004-12-03 16:53:42.000000000 -0500
+++ linux-2.6.10-rc3-mm1/drivers/char/lcd.c	2004-12-20 20:40:14.922386778 -0500
@@ -33,11 +33,14 @@
 
 #include "lcd.h"
 
+static spinlock_t lcd_lock = SPIN_LOCK_UNLOCKED;
+
 static int lcd_ioctl(struct inode *inode, struct file *file,
 		     unsigned int cmd, unsigned long arg);
 
-static int lcd_present = 1;
+static unsigned int lcd_present = 1;
 
+/* used in arch/mips/cobalt/reset.c */
 int led_state = 0;
 
 #if defined(CONFIG_TULIP) && 0
@@ -63,7 +66,6 @@
 {
 	struct lcd_display button_display;
 	unsigned long address, a;
-	int index;
 
 	switch (cmd) {
 	case LCD_On:
@@ -220,6 +222,7 @@
 
 	case LCD_Write:{
 			struct lcd_display display;
+			unsigned int index;
 
 
 			if (copy_from_user
@@ -316,7 +319,7 @@
 //  set only bit led_display.leds
 
 	case LED_Bit_Set:{
-			int i;
+			unsigned int i;
 			int bit = 1;
 			struct lcd_display led_display;
 
@@ -338,7 +341,7 @@
 //  clear only bit led_display.leds
 
 	case LED_Bit_Clear:{
-			int i;
+			unsigned int i;
 			int bit = 1;
 			struct lcd_display led_display;
 
@@ -413,6 +416,10 @@
 
 			int ctr = 0;
 
+			if ( !capable(CAP_SYS_ADMIN) ) return -EPERM;
+
+			pr_info(LCD "Erasing Flash\n");
+
 			// Chip Erase Sequence
 			WRITE_FLASH(kFlash_Addr1, kFlash_Data1);
 			WRITE_FLASH(kFlash_Addr2, kFlash_Data2);
@@ -421,21 +428,15 @@
 			WRITE_FLASH(kFlash_Addr2, kFlash_Data2);
 			WRITE_FLASH(kFlash_Addr1, kFlash_Erase6);
 
-			printk("Erasing Flash.\n");
-
 			while ((!dqpoll(0x00000000, 0xFF))
 			       && (!timeout(0x00000000))) {
 				ctr++;
 			}
 
-			printk("\n");
-			printk("\n");
-			printk("\n");
-
 			if (READ_FLASH(0x07FFF0) == 0xFF) {
-				printk("Erase Successful\r\n");
+				pr_info(LCD "Erase Successful\n");
 			} else if (timeout) {
-				printk("Erase Timed Out\r\n");
+				pr_info(LCD "Erase Timed Out\n");
 			}
 
 			break;
@@ -447,31 +448,35 @@
 
 			volatile unsigned long burn_addr;
 			unsigned long flags;
-			int i;
+			unsigned int i, index;
 			unsigned char *rom;
 
 
 			struct lcd_display display;
 
+			if ( !capable(CAP_SYS_ADMIN) ) return -EPERM;
+
 			if (copy_from_user
 			    (&display, (struct lcd_display *) arg,
 			     sizeof(struct lcd_display)))
 				return -EFAULT;
 			rom = (unsigned char *) kmalloc((128), GFP_ATOMIC);
 			if (rom == NULL) {
-				printk("broken\n");
-				return 1;
+				printk(KERN_ERR LCD "kmalloc() failed in %s\n",
+						__FUNCTION__);
+				return -ENOMEM;
 			}
 
-			printk("Churning and Burning -");
-			save_flags(flags);
+			pr_info(LCD "Starting Flash burn\n");
 			for (i = 0; i < FLASH_SIZE; i = i + 128) {
 
 				if (copy_from_user
-				    (rom, display.RomImage + i, 128))
+				    (rom, display.RomImage + i, 128)) {
+					kfree(rom);
 					return -EFAULT;
+				}
 				burn_addr = kFlashBase + i;
-				cli();
+				spin_lock_irqsave(&lcd_lock, flags);
 				for (index = 0; index < (128); index++) {
 
 					WRITE_FLASH(kFlash_Addr1,
@@ -480,32 +485,30 @@
 						    kFlash_Data2);
 					WRITE_FLASH(kFlash_Addr1,
 						    kFlash_Prog);
-					*((volatile unsigned char *)
-					  burn_addr) =
-		 (volatile unsigned char) rom[index];
-
-					while ((!dqpoll
-						(burn_addr,
-						 (volatile unsigned char)
-						 rom[index]))
-					       && (!timeout(burn_addr))) {
-					}
+					*((volatile unsigned char *)burn_addr) =
+					  (volatile unsigned char) rom[index];
+
+					while ((!dqpoll (burn_addr,
+						(volatile unsigned char)
+						rom[index])) &&
+						(!timeout(burn_addr))) { }
 					burn_addr++;
 				}
-				restore_flags(flags);
-				if (*
-				    ((volatile unsigned char *) (burn_addr
-								 - 1)) ==
-				    (volatile unsigned char) rom[index -
-								 1]) {
+				spin_unlock_irqrestore(&lcd_lock, flags);
+				if (* ((volatile unsigned char *)
+					(burn_addr - 1)) ==
+					(volatile unsigned char)
+					rom[index - 1]) {
 				} else if (timeout) {
-					printk("Program timed out\r\n");
+					pr_info(LCD "Flash burn timed out\n");
 				}
 
 
 			}
 			kfree(rom);
 
+			pr_info(LCD "Flash successfully burned\n");
+
 			break;
 		}
 
@@ -515,7 +518,7 @@
 
 			unsigned char *user_bytes;
 			volatile unsigned long read_addr;
-			int i;
+			unsigned int i;
 
 			user_bytes =
 			    &(((struct lcd_display *) arg)->RomImage[0]);
@@ -524,7 +527,7 @@
 			    (VERIFY_WRITE, user_bytes, FLASH_SIZE))
 				return -EFAULT;
 
-			printk("Reading Flash");
+			pr_info(LCD "Reading Flash");
 			for (i = 0; i < FLASH_SIZE; i++) {
 				unsigned char tmp_byte;
 				read_addr = kFlashBase + i;
@@ -540,8 +543,7 @@
 		}
 
 	default:
-		return 0;
-		break;
+		return -EINVAL;
 
 	}
 
@@ -613,7 +615,7 @@
 {
 	unsigned long data;
 
-	printk("%s\n", LCD_DRIVER);
+	pr_info("%s\n", LCD_DRIVER);
 	misc_register(&lcd_dev);
 
 	/* Check region? Naaah! Just snarf it up. */
@@ -623,7 +625,7 @@
 	data = LCDReadData;
 	if ((data & 0x000000FF) == (0x00)) {
 		lcd_present = 0;
-		printk("LCD Not Present\n");
+		pr_info(LCD "LCD Not Present\n");
 	} else {
 		lcd_present = 1;
 		WRITE_GAL(kGal_DevBank2PReg, kGal_DevBank2Cfg);
diff -urN --exclude='*~' linux-2.6.10-rc3-mm1-original/drivers/char/lcd.h linux-2.6.10-rc3-mm1/drivers/char/lcd.h
--- linux-2.6.10-rc3-mm1-original/drivers/char/lcd.h	2004-12-03 16:53:47.000000000 -0500
+++ linux-2.6.10-rc3-mm1/drivers/char/lcd.h	2004-12-20 19:08:10.795163702 -0500
@@ -37,6 +37,8 @@
 
 #define LCD_DRIVER	"Cobalt LCD Driver v2.10"
 
+#define LCD		"lcd: "
+
 #define kLCD_IR		0x0F000000
 #define kLCD_DR		0x0F000010
 #define kGPI		0x0D000000
