Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264352AbTEGXGb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264332AbTEGXFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:05:39 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:47751 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264335AbTEGXCD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:03 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493873716@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <1052349387730@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1100, 2003/05/07 14:59:52-07:00, hannal@us.ibm.com

[PATCH] riscom8 tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/riscom8.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)


diff -Nru a/drivers/char/riscom8.c b/drivers/char/riscom8.c
--- a/drivers/char/riscom8.c	Wed May  7 16:01:09 2003
+++ b/drivers/char/riscom8.c	Wed May  7 16:01:09 2003
@@ -552,9 +552,7 @@
 			wake_up_interruptible(&port->open_wait);
 		else if (!((port->flags & ASYNC_CALLOUT_ACTIVE) &&
 			   (port->flags & ASYNC_CALLOUT_NOHUP))) {
-			MOD_INC_USE_COUNT;
-			if (schedule_task(&port->tqueue_hangup) == 0)
-				MOD_DEC_USE_COUNT;
+			schedule_task(&port->tqueue_hangup);
 		}
 	}
 	
@@ -676,7 +674,6 @@
 	IRQ_to_board[bp->irq] = bp;
 	bp->flags |= RC_BOARD_ACTIVE;
 	
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -694,7 +691,6 @@
 	bp->DTR = ~0;
 	rc_out(bp, RC_DTR, bp->DTR);	       /* Drop DTR on all ports */
 	
-	MOD_DEC_USE_COUNT;
 }
 
 /*
@@ -1678,7 +1674,6 @@
 	tty = port->tty;
 	if (tty)
 		tty_hangup(tty);	/* FIXME: module removal race still here */
-	MOD_DEC_USE_COUNT;
 }
 
 static void rc_hangup(struct tty_struct * tty)
@@ -1757,6 +1752,7 @@
 	memset(IRQ_to_board, 0, sizeof(IRQ_to_board));
 	memset(&riscom_driver, 0, sizeof(riscom_driver));
 	riscom_driver.magic = TTY_DRIVER_MAGIC;
+	riscom_driver.owner = THIS_MODULE;
 	riscom_driver.name = "ttyL";
 	riscom_driver.major = RISCOM8_NORMAL_MAJOR;
 	riscom_driver.num = RC_NBOARD * RC_NPORT;

