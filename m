Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264285AbTEGXbH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264199AbTEGXDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:03:04 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:24966 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264285AbTEGXCB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:01 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493872313@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <1052349387898@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1103, 2003/05/07 15:00:22-07:00, hannal@us.ibm.com

[PATCH] istallion  tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/istallion.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)


diff -Nru a/drivers/char/istallion.c b/drivers/char/istallion.c
--- a/drivers/char/istallion.c	Wed May  7 16:00:56 2003
+++ b/drivers/char/istallion.c	Wed May  7 16:00:56 2003
@@ -1054,7 +1054,6 @@
 	if (portp->devnr < 1)
 		return(-ENODEV);
 
-	MOD_INC_USE_COUNT;
 
 /*
  *	Check if this port is in the middle of closing. If so then wait
@@ -1170,14 +1169,12 @@
 	save_flags(flags);
 	cli();
 	if (tty_hung_up_p(filp)) {
-		MOD_DEC_USE_COUNT;
 		restore_flags(flags);
 		return;
 	}
 	if ((tty->count == 1) && (portp->refcount != 1))
 		portp->refcount = 1;
 	if (portp->refcount-- > 1) {
-		MOD_DEC_USE_COUNT;
 		restore_flags(flags);
 		return;
 	}
@@ -1232,7 +1229,6 @@
 	portp->flags &= ~(ASYNC_CALLOUT_ACTIVE | ASYNC_NORMAL_ACTIVE |
 		ASYNC_CLOSING);
 	wake_up_interruptible(&portp->close_wait);
-	MOD_DEC_USE_COUNT;
 	restore_flags(flags);
 }
 
@@ -2369,7 +2365,6 @@
 			tty_hangup(portp->tty);
 		}
 	}
-	MOD_DEC_USE_COUNT;
 }
 
 /*****************************************************************************/
@@ -3004,9 +2999,7 @@
 					if (! ((portp->flags & ASYNC_CALLOUT_ACTIVE) &&
 					    (portp->flags & ASYNC_CALLOUT_NOHUP))) {
 						if (tty != (struct tty_struct *) NULL) {
-							MOD_INC_USE_COUNT;
-							if (schedule_task(&portp->tqhangup) == 0)
-								MOD_DEC_USE_COUNT;
+							schedule_task(&portp->tqhangup);
 						}
 					}
 				}
@@ -5350,6 +5343,7 @@
  */
 	memset(&stli_serial, 0, sizeof(struct tty_driver));
 	stli_serial.magic = TTY_DRIVER_MAGIC;
+	stli_serial.owner = THIS_MODULE;
 	stli_serial.driver_name = stli_drvname;
 	stli_serial.name = stli_serialname;
 	stli_serial.major = STL_SERIALMAJOR;

