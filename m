Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbTEGXSb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264309AbTEGXFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:05:12 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:21156 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264330AbTEGXCC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:02 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493864074@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <1052349386555@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1092, 2003/05/07 14:58:32-07:00, hannal@us.ibm.com

[PATCH] stallion tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/stallion.c |   28 +++++++---------------------
 1 files changed, 7 insertions(+), 21 deletions(-)


diff -Nru a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c	Wed May  7 16:01:44 2003
+++ b/drivers/char/stallion.c	Wed May  7 16:01:44 2003
@@ -1044,8 +1044,6 @@
 	if (portp == (stlport_t *) NULL)
 		return(-ENODEV);
 
-	MOD_INC_USE_COUNT;
-
 /*
  *	On the first open of the device setup the port hardware, and
  *	initialize the per port data structure.
@@ -1207,14 +1205,12 @@
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
@@ -1267,7 +1263,6 @@
 	portp->flags &= ~(ASYNC_CALLOUT_ACTIVE | ASYNC_NORMAL_ACTIVE |
 		ASYNC_CLOSING);
 	wake_up_interruptible(&portp->close_wait);
-	MOD_DEC_USE_COUNT;
 	restore_flags(flags);
 }
 
@@ -2241,11 +2236,11 @@
 #endif
 
 	if (portp == (stlport_t *) NULL)
-		goto out;
+		return;
 
 	tty = portp->tty;
 	if (tty == (struct tty_struct *) NULL)
-		goto out;
+		return;
 
 	lock_kernel();
 	if (test_bit(ASYI_TXLOW, &portp->istate)) {
@@ -2270,8 +2265,6 @@
 		}
 	}
 	unlock_kernel();
-out:
-	MOD_DEC_USE_COUNT;
 }
 
 /*****************************************************************************/
@@ -3231,6 +3224,7 @@
  */
 	memset(&stl_serial, 0, sizeof(struct tty_driver));
 	stl_serial.magic = TTY_DRIVER_MAGIC;
+	stl_serial.owner = THIS_MODULE;
 	stl_serial.driver_name = stl_drvname;
 	stl_serial.name = stl_serialname;
 	stl_serial.major = STL_SERIALMAJOR;
@@ -4136,9 +4130,7 @@
 	if ((len == 0) || ((len < STL_TXBUFLOW) &&
 	    (test_bit(ASYI_TXLOW, &portp->istate) == 0))) {
 		set_bit(ASYI_TXLOW, &portp->istate);
-		MOD_INC_USE_COUNT;
-		if (schedule_work(&portp->tqueue) == 0)
-			MOD_DEC_USE_COUNT;
+		schedule_work(&portp->tqueue);
 	}
 
 	if (len == 0) {
@@ -4318,9 +4310,7 @@
 	misr = inb(ioaddr + EREG_DATA);
 	if (misr & MISR_DCD) {
 		set_bit(ASYI_DCDCHANGE, &portp->istate);
-		MOD_INC_USE_COUNT;
-		if (schedule_task(&portp->tqueue) == 0)
-			MOD_DEC_USE_COUNT;
+		schedule_task(&portp->tqueue);
 		portp->stats.modem++;
 	}
 
@@ -5117,9 +5107,7 @@
 	if ((len == 0) || ((len < STL_TXBUFLOW) &&
 	    (test_bit(ASYI_TXLOW, &portp->istate) == 0))) {
 		set_bit(ASYI_TXLOW, &portp->istate);
-		MOD_INC_USE_COUNT;
-		if (schedule_task(&portp->tqueue) == 0)
-			MOD_DEC_USE_COUNT;
+		schedule_task(&portp->tqueue); 
 	}
 
 	if (len == 0) {
@@ -5336,9 +5324,7 @@
 		ipr = stl_sc26198getreg(portp, IPR);
 		if (ipr & IPR_DCDCHANGE) {
 			set_bit(ASYI_DCDCHANGE, &portp->istate);
-			MOD_INC_USE_COUNT;
-			if (schedule_task(&portp->tqueue) == 0)
-				MOD_DEC_USE_COUNT;
+			schedule_task(&portp->tqueue); 
 			portp->stats.modem++;
 		}
 		break;

