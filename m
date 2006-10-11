Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWJKNgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWJKNgA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 09:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWJKNf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 09:35:59 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:43702 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751303AbWJKNf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 09:35:56 -0400
Date: Wed, 11 Oct 2006 15:36:00 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [S390] cio: Remove grace period for vary off chpid.
Message-ID: <20061011133600.GE9305@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] cio: Remove grace period for vary off chpid.

The grace period handling introduced needless complexity. It didn't
help the dasd driver (which can handle terminated I/O just well),
and it doesn't help for long running channel programs (which won't
complete during the grace period anyway). Terminating I/O using a
path that just disappeared immediately is much more consistent with
what the user expects.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c       |   17 +++-------
 drivers/s390/cio/css.h        |    2 -
 drivers/s390/cio/device.h     |    1 
 drivers/s390/cio/device_fsm.c |   68 ++++--------------------------------------
 drivers/s390/cio/device_ops.c |    2 -
 5 files changed, 14 insertions(+), 76 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-10-11 15:23:22.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-10-11 15:23:38.000000000 +0200
@@ -707,8 +707,7 @@ chp_process_crw(int chpid, int on)
 	return chp_add(chpid);
 }
 
-static inline int
-__check_for_io_and_kill(struct subchannel *sch, int index)
+static inline int check_for_io_on_path(struct subchannel *sch, int index)
 {
 	int cc;
 
@@ -718,10 +717,8 @@ __check_for_io_and_kill(struct subchanne
 	cc = stsch(sch->schid, &sch->schib);
 	if (cc)
 		return 0;
-	if (sch->schib.scsw.actl && sch->schib.pmcw.lpum == (0x80 >> index)) {
-		device_set_waiting(sch);
+	if (sch->schib.scsw.actl && sch->schib.pmcw.lpum == (0x80 >> index))
 		return 1;
-	}
 	return 0;
 }
 
@@ -750,12 +747,10 @@ __s390_subchannel_vary_chpid(struct subc
 		} else {
 			sch->opm &= ~(0x80 >> chp);
 			sch->lpm &= ~(0x80 >> chp);
-			/*
-			 * Give running I/O a grace period in which it
-			 * can successfully terminate, even using the
-			 * just varied off path. Then kill it.
-			 */
-			if (!__check_for_io_and_kill(sch, chp) && !sch->lpm) {
+			if (check_for_io_on_path(sch, chp))
+				/* Path verification is done after killing. */
+				device_kill_io(sch);
+			else if (!sch->lpm) {
 				if (css_enqueue_subchannel_slow(sch->schid)) {
 					css_clear_subchannel_slow_list();
 					need_rescan = 1;
diff -urpN linux-2.6/drivers/s390/cio/css.h linux-2.6-patched/drivers/s390/cio/css.h
--- linux-2.6/drivers/s390/cio/css.h	2006-10-11 15:23:38.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/css.h	2006-10-11 15:23:38.000000000 +0200
@@ -170,7 +170,7 @@ void device_trigger_reprobe(struct subch
 
 /* Helper functions for vary on/off. */
 int device_is_online(struct subchannel *);
-void device_set_waiting(struct subchannel *);
+void device_kill_io(struct subchannel *);
 
 /* Machine check helper function. */
 void device_kill_pending_timer(struct subchannel *);
diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2006-10-11 15:23:38.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2006-10-11 15:23:38.000000000 +0200
@@ -59,18 +59,6 @@ device_set_disconnected(struct subchanne
 	cdev->private->state = DEV_STATE_DISCONNECTED;
 }
 
-void
-device_set_waiting(struct subchannel *sch)
-{
-	struct ccw_device *cdev;
-
-	if (!sch->dev.driver_data)
-		return;
-	cdev = sch->dev.driver_data;
-	ccw_device_set_timeout(cdev, 10*HZ);
-	cdev->private->state = DEV_STATE_WAIT4IO;
-}
-
 /*
  * Timeout function. It just triggers a DEV_EVENT_TIMEOUT.
  */
@@ -947,7 +935,7 @@ ccw_device_killing_irq(struct ccw_device
 	cdev->private->state = DEV_STATE_ONLINE;
 	if (cdev->handler)
 		cdev->handler(cdev, cdev->private->intparm,
-			      ERR_PTR(-ETIMEDOUT));
+			      ERR_PTR(-EIO));
 	if (!sch->lpm) {
 		PREPARE_WORK(&cdev->private->kick_work,
 			     ccw_device_nopath_notify, (void *)cdev);
@@ -984,51 +972,15 @@ ccw_device_killing_timeout(struct ccw_de
 	cdev->private->state = DEV_STATE_ONLINE;
 	if (cdev->handler)
 		cdev->handler(cdev, cdev->private->intparm,
-			      ERR_PTR(-ETIMEDOUT));
+			      ERR_PTR(-EIO));
 }
 
-static void
-ccw_device_wait4io_irq(struct ccw_device *cdev, enum dev_event dev_event)
-{
-	struct irb *irb;
-	struct subchannel *sch;
-
-	irb = (struct irb *) __LC_IRB;
-	/*
-	 * Accumulate status and find out if a basic sense is needed.
-	 * This is fine since we have already adapted the lpm.
-	 */
-	ccw_device_accumulate_irb(cdev, irb);
-	if (cdev->private->flags.dosense) {
-		if (ccw_device_do_sense(cdev, irb) == 0) {
-			cdev->private->state = DEV_STATE_W4SENSE;
-		}
-		return;
-	}
-
-	/* Iff device is idle, reset timeout. */
-	sch = to_subchannel(cdev->dev.parent);
-	if (!stsch(sch->schid, &sch->schib))
-		if (sch->schib.scsw.actl == 0)
-			ccw_device_set_timeout(cdev, 0);
-	/* Call the handler. */
-	ccw_device_call_handler(cdev);
-	if (!sch->lpm) {
-		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_nopath_notify, (void *)cdev);
-		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
-	} else if (cdev->private->flags.doverify)
-		ccw_device_online_verify(cdev, 0);
-}
-
-static void
-ccw_device_wait4io_timeout(struct ccw_device *cdev, enum dev_event dev_event)
+void device_kill_io(struct subchannel *sch)
 {
 	int ret;
-	struct subchannel *sch;
+	struct ccw_device *cdev;
 
-	sch = to_subchannel(cdev->dev.parent);
-	ccw_device_set_timeout(cdev, 0);
+	cdev = sch->dev.driver_data;
 	ret = ccw_device_cancel_halt_clear(cdev);
 	if (ret == -EBUSY) {
 		ccw_device_set_timeout(cdev, 3*HZ);
@@ -1047,12 +999,12 @@ ccw_device_wait4io_timeout(struct ccw_de
 	}
 	if (cdev->handler)
 		cdev->handler(cdev, cdev->private->intparm,
-			      ERR_PTR(-ETIMEDOUT));
+			      ERR_PTR(-EIO));
 	if (!sch->lpm) {
 		PREPARE_WORK(&cdev->private->kick_work,
 			     ccw_device_nopath_notify, (void *)cdev);
 		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
-	} else if (cdev->private->flags.doverify)
+	} else
 		/* Start delayed path verification. */
 		ccw_device_online_verify(cdev, 0);
 }
@@ -1289,12 +1241,6 @@ fsm_func_t *dev_jumptable[NR_DEV_STATES]
 		[DEV_EVENT_TIMEOUT]	= ccw_device_killing_timeout,
 		[DEV_EVENT_VERIFY]	= ccw_device_nop, //FIXME
 	},
-	[DEV_STATE_WAIT4IO] = {
-		[DEV_EVENT_NOTOPER]	= ccw_device_online_notoper,
-		[DEV_EVENT_INTERRUPT]	= ccw_device_wait4io_irq,
-		[DEV_EVENT_TIMEOUT]	= ccw_device_wait4io_timeout,
-		[DEV_EVENT_VERIFY]	= ccw_device_delay_verify,
-	},
 	[DEV_STATE_QUIESCE] = {
 		[DEV_EVENT_NOTOPER]	= ccw_device_quiesce_done,
 		[DEV_EVENT_INTERRUPT]	= ccw_device_quiesce_done,
diff -urpN linux-2.6/drivers/s390/cio/device.h linux-2.6-patched/drivers/s390/cio/device.h
--- linux-2.6/drivers/s390/cio/device.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device.h	2006-10-11 15:23:38.000000000 +0200
@@ -21,7 +21,6 @@ enum dev_state {
 	/* states to wait for i/o completion before doing something */
 	DEV_STATE_CLEAR_VERIFY,
 	DEV_STATE_TIMEOUT_KILL,
-	DEV_STATE_WAIT4IO,
 	DEV_STATE_QUIESCE,
 	/* special states for devices gone not operational */
 	DEV_STATE_DISCONNECTED,
diff -urpN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-patched/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	2006-10-11 15:23:38.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_ops.c	2006-10-11 15:23:38.000000000 +0200
@@ -50,7 +50,6 @@ ccw_device_clear(struct ccw_device *cdev
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE &&
-	    cdev->private->state != DEV_STATE_WAIT4IO &&
 	    cdev->private->state != DEV_STATE_W4SENSE)
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
@@ -155,7 +154,6 @@ ccw_device_halt(struct ccw_device *cdev,
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE &&
-	    cdev->private->state != DEV_STATE_WAIT4IO &&
 	    cdev->private->state != DEV_STATE_W4SENSE)
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
