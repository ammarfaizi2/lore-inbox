Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbTEGXDq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbTEGXDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:03:39 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:65412 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264310AbTEGXCC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:02 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1052349387898@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493872739@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1102, 2003/05/07 15:00:12-07:00, hannal@us.ibm.com

[PATCH] mxser tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/mxser.c |   19 ++++---------------
 1 files changed, 4 insertions(+), 15 deletions(-)


diff -Nru a/drivers/char/mxser.c b/drivers/char/mxser.c
--- a/drivers/char/mxser.c	Wed May  7 16:01:01 2003
+++ b/drivers/char/mxser.c	Wed May  7 16:01:01 2003
@@ -501,6 +501,7 @@
 
 	memset(&mxvar_sdriver, 0, sizeof(struct tty_driver));
 	mxvar_sdriver.magic = TTY_DRIVER_MAGIC;
+	mxvar_sdriver.owner = THIS_MODULE;
 	mxvar_sdriver.name = "ttyM";
 	mxvar_sdriver.major = ttymajor;
 	mxvar_sdriver.minor_start = 0;
@@ -708,7 +709,6 @@
 			tty_hangup(tty);	/* FIXME: module removal race here - AKPM */
 		}
 	}
-	MOD_DEC_USE_COUNT;
 }
 
 /*
@@ -767,8 +767,6 @@
 	info->session = current->session;
 	info->pgrp = current->pgrp;
 
-	MOD_INC_USE_COUNT;
-
 	return (0);
 }
 
@@ -795,7 +793,6 @@
 
 	if (tty_hung_up_p(filp)) {
 		restore_flags(flags);
-		MOD_DEC_USE_COUNT;
 		return;
 	}
 	if ((tty->count == 1) && (info->count != 1)) {
@@ -817,7 +814,6 @@
 	}
 	if (info->count) {
 		restore_flags(flags);
-		MOD_DEC_USE_COUNT;
 		return;
 	}
 	info->flags |= ASYNC_CLOSING;
@@ -881,7 +877,6 @@
 	wake_up_interruptible(&info->close_wait);
 	restore_flags(flags);
 
-	MOD_DEC_USE_COUNT;
 }
 
 static int mxser_write(struct tty_struct *tty, int from_user,
@@ -1492,9 +1487,7 @@
 
 	if (info->xmit_cnt < WAKEUP_CHARS) {
 		set_bit(MXSER_EVENT_TXLOW, &info->event);
-		MOD_INC_USE_COUNT;
-		if (schedule_work(&info->tqueue) == 0)
-		    MOD_DEC_USE_COUNT;
+		schedule_work(&info->tqueue);
 	}
 	if (info->xmit_cnt <= 0) {
 		info->IER &= ~UART_IER_THRI;
@@ -1523,9 +1516,7 @@
 		else if (!((info->flags & ASYNC_CALLOUT_ACTIVE) &&
 			   (info->flags & ASYNC_CALLOUT_NOHUP)))
 			set_bit(MXSER_EVENT_HANGUP, &info->event);
-		MOD_INC_USE_COUNT;
-		if (schedule_work(&info->tqueue) == 0)
-		    MOD_DEC_USE_COUNT;
+		schedule_work(&info->tqueue);
 	}
 	if (info->flags & ASYNC_CTS_FLOW) {
 		if (info->tty->hw_stopped) {
@@ -1535,9 +1526,7 @@
 				outb(info->IER, info->base + UART_IER);
 
 				set_bit(MXSER_EVENT_TXLOW, &info->event);
-				MOD_INC_USE_COUNT;
-				if (schedule_work(&info->tqueue) == 0)
-					MOD_DEC_USE_COUNT;
+				schedule_work(&info->tqueue);
 			}
 		} else {
 			if (!(status & UART_MSR_CTS)) {

