Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTFDTWn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTFDTWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:22:43 -0400
Received: from sj-core-3.cisco.com ([171.68.223.137]:46285 "EHLO
	sj-core-3.cisco.com") by vger.kernel.org with ESMTP id S263786AbTFDTWl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:22:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hua Zhong <hzhong@cisco.com>
Organization: Cisco Systems
To: torvalds@transmeta.com
Subject: RE: [PATCH] [2.5] Non-blocking write can block
Date: Wed, 4 Jun 2003 12:36:08 -0700
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <03060412360802.22925@hzhong-lnx.cisco.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do y ou have that other patch handy? It sounds like that is 
> the real cause of the problem, and the patch quoted originally 
> in this thread was a (broken) work-around..
> 
>                Linus
> 

Something like this:

--- n_tty.c.old	2003-06-04 12:28:36.000000000 -0700
+++ n_tty.c	2003-06-04 12:28:51.000000000 -0700
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
 static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
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
 
