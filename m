Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263109AbVG3Skp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263109AbVG3Skp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 14:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbVG3Sk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 14:40:28 -0400
Received: from verein.lst.de ([213.95.11.210]:43908 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263099AbVG3SkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 14:40:05 -0400
Date: Sat, 30 Jul 2005 20:39:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, jeff@uclinux.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] move 68360serial.c over use initcalls
Message-ID: <20050730183953.GA12119@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is the last serial driver not using initcalls.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/drivers/char/tty_io.c
===================================================================
--- linux-2.6.orig/drivers/char/tty_io.c	2005-06-26 13:26:22.000000000 +0200
+++ linux-2.6/drivers/char/tty_io.c	2005-07-30 20:37:17.000000000 +0200
@@ -153,7 +153,6 @@
 int tty_ioctl(struct inode * inode, struct file * file,
 	      unsigned int cmd, unsigned long arg);
 static int tty_fasync(int fd, struct file * filp, int on);
-extern void rs_360_init(void);
 static void release_mem(struct tty_struct *tty, int idx);
 
 
@@ -2911,11 +2910,6 @@
 #ifdef CONFIG_EARLY_PRINTK
 	disable_early_printk();
 #endif
-#ifdef CONFIG_SERIAL_68360
- 	/* This is not a console initcall. I know not what it's doing here.
-	   So I haven't moved it. dwmw2 */
-        rs_360_init();
-#endif
 	call = __con_initcall_start;
 	while (call < __con_initcall_end) {
 		(*call)();
Index: linux-2.6/drivers/serial/68360serial.c
===================================================================
--- linux-2.6.orig/drivers/serial/68360serial.c	2005-06-26 13:26:23.000000000 +0200
+++ linux-2.6/drivers/serial/68360serial.c	2005-07-30 20:36:56.000000000 +0200
@@ -2474,8 +2474,7 @@
 	.tiocmset = rs_360_tiocmset,
 };
 
-/* int __init rs_360_init(void) */
-int rs_360_init(void)
+static int __init rs_360_init(void)
 {
 	struct serial_state * state;
 	ser_info_t	*info;
@@ -2827,10 +2826,7 @@
 
 	return 0;
 }
-
-
-
-
+module_init(rs_360_init);
 
 /* This must always be called before the rs_360_init() function, otherwise
  * it blows away the port control information.
