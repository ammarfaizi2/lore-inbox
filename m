Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267317AbTGQSri (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271538AbTGQSha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:37:30 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:30108 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S271530AbTGQSfQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:35:16 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 17 Jul 2003 20:47:05 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] drivers/media/video i2c drivers update
Message-ID: <20030717184705.GA22220@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch is a minor fix for two i2c modules -- it makes them catch
kernel_thread() failures correctly.

Please apply,

  Gerd

diff -u linux-2.6.0-test1/drivers/media/video/msp3400.c linux/drivers/media/video/msp3400.c
--- linux-2.6.0-test1/drivers/media/video/msp3400.c	2003-07-17 18:56:17.203335698 +0200
+++ linux/drivers/media/video/msp3400.c	2003-07-17 19:13:34.355333457 +0200
@@ -50,10 +50,6 @@
 #include <asm/semaphore.h>
 #include <asm/pgtable.h>
 
-/* kernel_thread */
-#define __KERNEL_SYSCALLS__
-#include <linux/unistd.h>
-
 #include <media/audiochip.h>
 #include "msp3400.h"
 
@@ -1262,7 +1258,7 @@
 	DECLARE_MUTEX_LOCKED(sem);
 	struct msp3400c *msp;
         struct i2c_client *c;
-	int i;
+	int i, rc;
 
         client_template.adapter = adap;
         client_template.addr = addr;
@@ -1345,9 +1341,12 @@
 
 	/* startup control thread */
 	msp->notify = &sem;
-	kernel_thread(msp->simple ? msp3410d_thread : msp3400c_thread,
-		      (void *)c, 0);
-	down(&sem);
+	rc = kernel_thread(msp->simple ? msp3410d_thread : msp3400c_thread,
+			   (void *)c, 0);
+	if (rc < 0)
+		printk(KERN_WARNING "msp34xx: kernel_thread() failed\n");
+	else
+		down(&sem);
 	msp->notify = NULL;
 	wake_up_interruptible(&msp->wq);
 
diff -u linux-2.6.0-test1/drivers/media/video/tda9887.c linux/drivers/media/video/tda9887.c
--- linux-2.6.0-test1/drivers/media/video/tda9887.c	2003-07-17 18:54:24.901678674 +0200
+++ linux/drivers/media/video/tda9887.c	2003-07-17 19:13:34.360332620 +0200
@@ -439,11 +439,9 @@
 };
 static struct i2c_client client_template =
 {
-	.flags  = I2C_CLIENT_ALLOW_USE,
-        .driver = &driver,
-        .dev	= {
-		.name	= "tda9887",
-	},
+	I2C_DEVNAME("tda9887"),
+	.flags     = I2C_CLIENT_ALLOW_USE,
+        .driver    = &driver,
 };
 
 static int tda9887_init_module(void)
diff -u linux-2.6.0-test1/drivers/media/video/tvaudio.c linux/drivers/media/video/tvaudio.c
--- linux-2.6.0-test1/drivers/media/video/tvaudio.c	2003-07-17 18:55:30.490361140 +0200
+++ linux/drivers/media/video/tvaudio.c	2003-07-17 19:13:34.368331282 +0200
@@ -1420,6 +1420,7 @@
 {
 	struct CHIPSTATE *chip;
 	struct CHIPDESC  *desc;
+	int rc;
 
 	chip = kmalloc(sizeof(*chip),GFP_KERNEL);
 	if (!chip)
@@ -1487,8 +1488,12 @@
 		chip->wt.function = chip_thread_wake;
 		chip->wt.data     = (unsigned long)chip;
 		init_waitqueue_head(&chip->wq);
-		kernel_thread(chip_thread,(void *)chip,0);
-		down(&sem);
+		rc = kernel_thread(chip_thread,(void *)chip,0);
+		if (rc < 0)
+			printk(KERN_WARNING "%s: kernel_thread() failed\n",
+			       i2c_clientname(&chip->c));
+		else
+			down(&sem);
 		chip->notify = NULL;
 		wake_up_interruptible(&chip->wq);
 	}

-- 
sigfault
