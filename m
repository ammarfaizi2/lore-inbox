Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbUKKR2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbUKKR2a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 12:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbUKKRYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:24:38 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:15604 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262301AbUKKRQ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:16:29 -0500
Date: Thu, 11 Nov 2004 18:16:20 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 5/10] s390: 3270 console.
Message-ID: <20041111171620.GG4900@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 5/10] s390: 3270 console.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

3270 console driver changes:
 - Add error handling in 3270 device startup.
 - Do halt_io if startup has been interrupted.
 - Fix reference counting in tty timers.
 - Simplify set_timer functions.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/char/con3270.c |    9 +++------
 drivers/s390/char/raw3270.c |   36 +++++++++++++++++++++++++++---------
 drivers/s390/char/tty3270.c |   10 +++-------
 3 files changed, 33 insertions(+), 22 deletions(-)

diff -urN linux-2.6/drivers/s390/char/con3270.c linux-2.6-patched/drivers/s390/char/con3270.c
--- linux-2.6/drivers/s390/char/con3270.c	2004-10-18 23:53:13.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/con3270.c	2004-11-11 15:06:57.000000000 +0100
@@ -73,14 +73,11 @@
 con3270_set_timer(struct con3270 *cp, int expires)
 {
 	if (expires == 0) {
-		if (timer_pending(&cp->timer))
-			del_timer(&cp->timer);
+		del_timer(&cp->timer);
 		return;
 	}
-	if (timer_pending(&cp->timer)) {
-		if (mod_timer(&cp->timer, jiffies + expires))
-			return;
-	}
+	if (mod_timer(&cp->timer, jiffies + expires))
+		return;
 	cp->timer.function = (void (*)(unsigned long)) con3270_update;
 	cp->timer.data = (unsigned long) cp;
 	cp->timer.expires = jiffies + expires;
diff -urN linux-2.6/drivers/s390/char/raw3270.c linux-2.6-patched/drivers/s390/char/raw3270.c
--- linux-2.6/drivers/s390/char/raw3270.c	2004-10-18 23:54:55.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/raw3270.c	2004-11-11 15:06:57.000000000 +0100
@@ -347,8 +347,11 @@
 
 	if (IS_ERR(irb))
 		rc = RAW3270_IO_RETRY;
-	else if (irb->scsw.dstat ==  (DEV_STAT_CHN_END | DEV_STAT_DEV_END |
-				      DEV_STAT_UNIT_EXCEP)) {
+	else if (irb->scsw.fctl & SCSW_FCTL_HALT_FUNC) {
+		rq->rc = -EIO;
+		rc = RAW3270_IO_DONE;
+	} else if (irb->scsw.dstat ==  (DEV_STAT_CHN_END | DEV_STAT_DEV_END |
+					DEV_STAT_UNIT_EXCEP)) {
 		/* Handle CE-DE-UE and subsequent UDE */
 		set_bit(RAW3270_FLAGS_BUSY, &rp->flags);
 		rc = RAW3270_IO_BUSY;
@@ -552,6 +555,8 @@
 	rc = wait_event_interruptible(wq, raw3270_request_final(rq));
 	if (rc == -ERESTARTSYS) {	/* Interrupted by a signal. */
 		raw3270_halt_io(view->dev, rq);
+		/* No wait for the halt to complete. */
+		wait_event(wq, raw3270_request_final(rq));
 		return -ERESTARTSYS;
 	}
 	return rq->rc;
@@ -809,9 +814,15 @@
 	if (rc)
 		return ERR_PTR(rc);
 	set_bit(RAW3270_FLAGS_CONSOLE, &rp->flags);
-	raw3270_reset_device(rp);
-	raw3270_size_device(rp);
-	raw3270_reset_device(rp);
+	rc = raw3270_reset_device(rp);
+	if (rc)
+		return ERR_PTR(rc);
+	rc = raw3270_size_device(rp);
+	if (rc)
+		return ERR_PTR(rc);
+	rc = raw3270_reset_device(rp);
+	if (rc)
+		return ERR_PTR(rc);
 	set_bit(RAW3270_FLAGS_READY, &rp->flags);
 	return rp;
 }
@@ -1030,7 +1041,7 @@
 	}
 	spin_unlock_irqrestore(get_ccwdev_lock(rp->cdev), flags);
 	/* Wait for reference counter to drop to zero. */
-	atomic_sub(2, &view->ref_count);
+	atomic_dec(&view->ref_count);
 	wait_event(raw3270_wait_queue, atomic_read(&view->ref_count) == 0);
 	if (view->fn->free)
 		view->fn->free(view);
@@ -1165,13 +1176,20 @@
 {
 	struct raw3270 *rp;
 	struct raw3270_notifier *np;
+	int rc;
 
 	rp = raw3270_create_device(cdev);
 	if (IS_ERR(rp))
 		return PTR_ERR(rp);
-	raw3270_reset_device(rp);
-	raw3270_size_device(rp);
-	raw3270_reset_device(rp);
+	rc = raw3270_reset_device(rp);
+	if (rc)
+		return rc;
+	rc = raw3270_size_device(rp);
+	if (rc)
+		return rc;
+	rc = raw3270_reset_device(rp);
+	if (rc)
+		return rc;
 	raw3270_create_attributes(rp);
 	set_bit(RAW3270_FLAGS_READY, &rp->flags);
 	down(&raw3270_sem);
diff -urN linux-2.6/drivers/s390/char/tty3270.c linux-2.6-patched/drivers/s390/char/tty3270.c
--- linux-2.6/drivers/s390/char/tty3270.c	2004-11-11 15:06:39.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/tty3270.c	2004-11-11 15:06:57.000000000 +0100
@@ -124,16 +124,12 @@
 tty3270_set_timer(struct tty3270 *tp, int expires)
 {
 	if (expires == 0) {
-		if (timer_pending(&tp->timer)) {
+		if (del_timer(&tp->timer))
 			raw3270_put_view(&tp->view);
-			del_timer(&tp->timer);
-		}
 		return;
 	}
-	if (timer_pending(&tp->timer)) {
-		if (mod_timer(&tp->timer, jiffies + expires))
-			return;
-	}
+	if (mod_timer(&tp->timer, jiffies + expires))
+		return;
 	raw3270_get_view(&tp->view);
 	tp->timer.function = (void (*)(unsigned long)) tty3270_update;
 	tp->timer.data = (unsigned long) tp;
