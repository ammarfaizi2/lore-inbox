Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTFDT4d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbTFDT4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:56:33 -0400
Received: from sj-core-5.cisco.com ([171.71.177.238]:57068 "EHLO
	sj-core-5.cisco.com") by vger.kernel.org with ESMTP id S263997AbTFDT4b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:56:31 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hua Zhong <hzhong@cisco.com>
Organization: Cisco Systems
To: torvalds@transmeta.com, sapan@corewars.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.5] Non-blocking write can block
Date: Wed, 4 Jun 2003 13:09:16 -0700
X-Mailer: KMail [version 1.2]
References: <03060412360802.22925@hzhong-lnx.cisco.com>
In-Reply-To: <03060412360802.22925@hzhong-lnx.cisco.com>
MIME-Version: 1.0
Message-Id: <03060413091600.22968@hzhong-lnx.cisco.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a missing piece in the previous mail. The complete patch is as 
follows. I just googled it and the author is Sapan Bhatia .Cc-ed.

diff -urN linux-old/drivers/char/CVS/Entries linux/drivers/char/CVS/Entries
--- linux-old/drivers/char/CVS/Entries	2003-06-04 12:57:32.000000000 -0700
+++ linux/drivers/char/CVS/Entries	2003-06-04 13:01:35.000000000 -0700
@@ -194,5 +194,5 @@
 D/pcmcia////
 D/rio////
 /tty_io.c/1.3/Wed Jun  4 19:28:08 2003//
-/pty.c/1.1/Wed Jun  4 19:57:20 2003//T1.1
-/n_tty.c/1.1/Wed Jun  4 19:57:32 2003//T1.1
+/n_tty.c/1.2/Wed Jun  4 20:01:32 2003//
+/pty.c/1.2/Wed Jun  4 20:01:32 2003//
diff -urN linux-old/drivers/char/n_tty.c linux/drivers/char/n_tty.c
--- linux-old/drivers/char/n_tty.c	2003-06-04 13:00:51.000000000 -0700
+++ linux/drivers/char/n_tty.c	2003-06-04 13:01:32.000000000 -0700
@@ -711,6 +711,23 @@
 	return 0;
 }
 
+
+/*
+ * Required for the ptys, serial driver etc. since processes
+ * that attach themselves to the master and rely on ASYNC
+ * IO must be woken up
+ */
+
+static void n_tty_write_wakeup(struct tty_struct *tty)
+{
+	if (tty->fasync)
+	{
+ 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
+		kill_fasync(&tty->fasync, SIGIO, POLL_OUT);
+	}
+	return;
+}
+
 static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char 
*cp,
 			      char *fp, int count)
 {
@@ -1157,6 +1174,8 @@
 			while (nr > 0) {
 				ssize_t num = opost_block(tty, b, nr);
 				if (num < 0) {
+					if (num == -EAGAIN)
+						break;
 					retval = num;
 					goto break_out;
 				}
@@ -1236,6 +1255,6 @@
 	normal_poll,		/* poll */
 	n_tty_receive_buf,	/* receive_buf */
 	n_tty_receive_room,	/* receive_room */
-	0			/* write_wakeup */
+ 	n_tty_write_wakeup 	/* write_wakeup */
 };
 
diff -urN linux-old/drivers/char/pty.c linux/drivers/char/pty.c
--- linux-old/drivers/char/pty.c	2003-06-04 13:01:04.000000000 -0700
+++ linux/drivers/char/pty.c	2003-06-04 13:01:32.000000000 -0700
@@ -331,6 +331,7 @@
 	clear_bit(TTY_OTHER_CLOSED, &tty->link->flags);
 	wake_up_interruptible(&pty->open_wait);
 	set_bit(TTY_THROTTLED, &tty->flags);
+	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 	/*  Register a slave for the master  */
 	if (tty->driver.major == PTY_MASTER_MAJOR)
 		tty_register_devfs(&tty->link->driver,
à@

