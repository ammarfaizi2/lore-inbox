Return-Path: <linux-kernel-owner+w=401wt.eu-S1754836AbWL1NQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836AbWL1NQW (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 08:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754840AbWL1NQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 08:16:22 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:43634 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754836AbWL1NQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 08:16:21 -0500
Message-id: <188453909150148968@wsc.cz>
Subject: [PATCH 1/4] Char: mxser_new, remove unused stuff
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Thu, 28 Dec 2006 14:16:25 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, remove unused stuff

- nobody waits on close_wait
- ASYNC_SPLIT_TERMIOS is not set by anybody, so do not test this flag
- process session and pgrp are useless information

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 8fc2346d2eab1a1780c319ddd77d818a270aba02
tree 2e3a0a3726166385ab6aa5a10187ce4bc0594b89
parent 45dc5568e87fb6ce405b57e18cc0eb4a98da073c
author Jiri Slaby <jirislaby@gmail.com> Sat, 23 Dec 2006 01:45:14 +0059
committer Jiri Slaby <jirislaby@gmail.com> Thu, 28 Dec 2006 13:48:49 +0059

 drivers/char/mxser_new.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 13b9072..4d4721e 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -237,8 +237,6 @@ struct mxser_port {
 	long realbaud;
 	int type;		/* UART type */
 	int flags;		/* defined in tty.h */
-	long session;		/* Session of opening process */
-	long pgrp;		/* pgrp of opening process */
 
 	int x_char;		/* xon/xoff character */
 	int IER;		/* Interrupt Enable Register */
@@ -267,14 +265,12 @@ struct mxser_port {
 	int xmit_cnt;
 
 	struct ktermios normal_termios;
-	struct ktermios callout_termios;
 
 	struct mxser_mon mon_data;
 
 	spinlock_t slock;
 	struct work_struct tqueue;
 	wait_queue_head_t open_wait;
-	wait_queue_head_t close_wait;
 	wait_queue_head_t delta_msr_wait;
 };
 
@@ -936,17 +932,6 @@ static int mxser_open(struct tty_struct *tty, struct file *filp)
 	if (retval)
 		return retval;
 
-	if ((info->count == 1) && (info->flags & ASYNC_SPLIT_TERMIOS)) {
-		if (tty->driver->subtype == SERIAL_TYPE_NORMAL)
-			*tty->termios = info->normal_termios;
-		else
-			*tty->termios = info->callout_termios;
-		mxser_change_speed(info, NULL);
-	}
-
-	info->session = process_session(current);
-	info->pgrp = process_group(current);
-
 	/* unmark here for very high baud rate (ex. 921600 bps) used */
 	tty->low_latency = 1;
 	return 0;
@@ -1053,8 +1038,6 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
 	}
 
 	info->flags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_CLOSING);
-	wake_up_interruptible(&info->close_wait);
-
 }
 
 static int mxser_write(struct tty_struct *tty, const unsigned char *buf, int count)
@@ -2420,7 +2403,6 @@ static int __devinit mxser_initbrd(struct mxser_board *brd,
 		INIT_WORK(&info->tqueue, mxser_do_softint);
 		info->normal_termios = mxvar_sdriver->init_termios;
 		init_waitqueue_head(&info->open_wait);
-		init_waitqueue_head(&info->close_wait);
 		init_waitqueue_head(&info->delta_msr_wait);
 		memset(&info->mon_data, 0, sizeof(struct mxser_mon));
 		info->err_shadow = 0;
