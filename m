Return-Path: <linux-kernel-owner+w=401wt.eu-S1425549AbWLHPTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425549AbWLHPTf (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425551AbWLHPTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:19:34 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:46187 "EHLO
	mtagate1.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425549AbWLHPTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:19:31 -0500
Date: Fri, 8 Dec 2006 16:19:21 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [S390] more workqueue fixes.
Message-ID: <20061208151921.GB14596@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] more workqueue fixes.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/tape.h       |    3 +-
 drivers/s390/char/tape_34xx.c  |   23 ++++++++++-----------
 drivers/s390/char/tape_3590.c  |    7 +++---
 drivers/s390/char/tape_block.c |   14 ++++++++-----
 drivers/s390/char/tape_core.c  |   14 ++++++-------
 drivers/s390/cio/css.h         |    2 +
 drivers/s390/cio/device.c      |   43 +++++++++++++++++++++++++----------------
 drivers/s390/cio/device.h      |    4 +--
 drivers/s390/cio/device_fsm.c  |   38 +++++++++++++++++++-----------------
 drivers/s390/cio/qdio.c        |    8 ++++---
 10 files changed, 89 insertions(+), 67 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/tape_34xx.c linux-2.6-patched/drivers/s390/char/tape_34xx.c
--- linux-2.6/drivers/s390/char/tape_34xx.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/tape_34xx.c	2006-12-08 15:52:44.000000000 +0100
@@ -95,6 +95,12 @@ tape_34xx_medium_sense(struct tape_devic
 	return rc;
 }
 
+struct tape_34xx_work {
+	struct tape_device	*device;
+	enum tape_op		 op;
+	struct work_struct	 work;
+};
+
 /*
  * These functions are currently used only to schedule a medium_sense for
  * later execution. This is because we get an interrupt whenever a medium
@@ -103,13 +109,10 @@ tape_34xx_medium_sense(struct tape_devic
  * interrupt handler.
  */
 static void
-tape_34xx_work_handler(void *data)
+tape_34xx_work_handler(struct work_struct *work)
 {
-	struct {
-		struct tape_device	*device;
-		enum tape_op		 op;
-		struct work_struct	 work;
-	} *p = data;
+	struct tape_34xx_work *p =
+		container_of(work, struct tape_34xx_work, work);
 
 	switch(p->op) {
 		case TO_MSEN:
@@ -126,17 +129,13 @@ tape_34xx_work_handler(void *data)
 static int
 tape_34xx_schedule_work(struct tape_device *device, enum tape_op op)
 {
-	struct {
-		struct tape_device	*device;
-		enum tape_op		 op;
-		struct work_struct	 work;
-	} *p;
+	struct tape_34xx_work *p;
 
 	if ((p = kmalloc(sizeof(*p), GFP_ATOMIC)) == NULL)
 		return -ENOMEM;
 
 	memset(p, 0, sizeof(*p));
-	INIT_WORK(&p->work, tape_34xx_work_handler, p);
+	INIT_WORK(&p->work, tape_34xx_work_handler);
 
 	p->device = tape_get_device_reference(device);
 	p->op     = op;
diff -urpN linux-2.6/drivers/s390/char/tape_3590.c linux-2.6-patched/drivers/s390/char/tape_3590.c
--- linux-2.6/drivers/s390/char/tape_3590.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/tape_3590.c	2006-12-08 15:52:44.000000000 +0100
@@ -236,9 +236,10 @@ struct work_handler_data {
 };
 
 static void
-tape_3590_work_handler(void *data)
+tape_3590_work_handler(struct work_struct *work)
 {
-	struct work_handler_data *p = data;
+	struct work_handler_data *p =
+		container_of(work, struct work_handler_data, work);
 
 	switch (p->op) {
 	case TO_MSEN:
@@ -263,7 +264,7 @@ tape_3590_schedule_work(struct tape_devi
 	if ((p = kzalloc(sizeof(*p), GFP_ATOMIC)) == NULL)
 		return -ENOMEM;
 
-	INIT_WORK(&p->work, tape_3590_work_handler, p);
+	INIT_WORK(&p->work, tape_3590_work_handler);
 
 	p->device = tape_get_device_reference(device);
 	p->op = op;
diff -urpN linux-2.6/drivers/s390/char/tape_block.c linux-2.6-patched/drivers/s390/char/tape_block.c
--- linux-2.6/drivers/s390/char/tape_block.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/tape_block.c	2006-12-08 15:52:44.000000000 +0100
@@ -15,6 +15,7 @@
 #include <linux/blkdev.h>
 #include <linux/interrupt.h>
 #include <linux/buffer_head.h>
+#include <linux/kernel.h>
 
 #include <asm/debug.h>
 
@@ -143,7 +144,8 @@ tapeblock_start_request(struct tape_devi
  * queue.
  */
 static void
-tapeblock_requeue(void *data) {
+tapeblock_requeue(struct work_struct *work) {
+	struct tape_blk_data *	blkdat;
 	struct tape_device *	device;
 	request_queue_t *	queue;
 	int			nr_queued;
@@ -151,7 +153,8 @@ tapeblock_requeue(void *data) {
 	struct list_head *	l;
 	int			rc;
 
-	device = (struct tape_device *) data;
+	blkdat = container_of(work, struct tape_blk_data, requeue_task);
+	device = blkdat->device;
 	if (!device)
 		return;
 
@@ -212,6 +215,7 @@ tapeblock_setup_device(struct tape_devic
 	int			rc;
 
 	blkdat = &device->blk_data;
+	blkdat->device = device;
 	spin_lock_init(&blkdat->request_queue_lock);
 	atomic_set(&blkdat->requeue_scheduled, 0);
 
@@ -255,8 +259,8 @@ tapeblock_setup_device(struct tape_devic
 
 	add_disk(disk);
 
-	INIT_WORK(&blkdat->requeue_task, tapeblock_requeue,
-		tape_get_device_reference(device));
+	tape_get_device_reference(device);
+	INIT_WORK(&blkdat->requeue_task, tapeblock_requeue);
 
 	return 0;
 
@@ -271,7 +275,7 @@ void
 tapeblock_cleanup_device(struct tape_device *device)
 {
 	flush_scheduled_work();
-	device->blk_data.requeue_task.data = tape_put_device(device);
+	tape_put_device(device);
 
 	if (!device->blk_data.disk) {
 		PRINT_ERR("(%s): No gendisk to clean up!\n",
diff -urpN linux-2.6/drivers/s390/char/tape_core.c linux-2.6-patched/drivers/s390/char/tape_core.c
--- linux-2.6/drivers/s390/char/tape_core.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/tape_core.c	2006-12-08 15:52:44.000000000 +0100
@@ -28,7 +28,7 @@
 #define PRINTK_HEADER "TAPE_CORE: "
 
 static void __tape_do_irq (struct ccw_device *, unsigned long, struct irb *);
-static void tape_delayed_next_request(void * data);
+static void tape_delayed_next_request(struct work_struct *);
 
 /*
  * One list to contain all tape devices of all disciplines, so
@@ -272,7 +272,7 @@ __tape_cancel_io(struct tape_device *dev
 				return 0;
 			case -EBUSY:
 				request->status	= TAPE_REQUEST_CANCEL;
-				schedule_work(&device->tape_dnr);
+				schedule_delayed_work(&device->tape_dnr, 0);
 				return 0;
 			case -ENODEV:
 				DBF_EXCEPTION(2, "device gone, retry\n");
@@ -470,7 +470,7 @@ tape_alloc_device(void)
 	*device->modeset_byte = 0;
 	device->first_minor = -1;
 	atomic_set(&device->ref_count, 1);
-	INIT_WORK(&device->tape_dnr, tape_delayed_next_request, device);
+	INIT_DELAYED_WORK(&device->tape_dnr, tape_delayed_next_request);
 
 	return device;
 }
@@ -724,7 +724,7 @@ __tape_start_io(struct tape_device *devi
 	} else if (rc == -EBUSY) {
 		/* The common I/O subsystem is currently busy. Retry later. */
 		request->status = TAPE_REQUEST_QUEUED;
-		schedule_work(&device->tape_dnr);
+		schedule_delayed_work(&device->tape_dnr, 0);
 		rc = 0;
 	} else {
 		/* Start failed. Remove request and indicate failure. */
@@ -790,11 +790,11 @@ __tape_start_next_request(struct tape_de
 }
 
 static void
-tape_delayed_next_request(void *data)
+tape_delayed_next_request(struct work_struct *work)
 {
-	struct tape_device *	device;
+	struct tape_device *device =
+		container_of(work, struct tape_device, tape_dnr.work);
 
-	device = (struct tape_device *) data;
 	DBF_LH(6, "tape_delayed_next_request(%p)\n", device);
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	__tape_start_next_request(device);
diff -urpN linux-2.6/drivers/s390/char/tape.h linux-2.6-patched/drivers/s390/char/tape.h
--- linux-2.6/drivers/s390/char/tape.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/tape.h	2006-12-08 15:52:44.000000000 +0100
@@ -179,6 +179,7 @@ struct tape_char_data {
 /* Block Frontend Data */
 struct tape_blk_data
 {
+	struct tape_device *	device;
 	/* Block device request queue. */
 	request_queue_t *	request_queue;
 	spinlock_t		request_queue_lock;
@@ -240,7 +241,7 @@ struct tape_device {
 #endif
 
 	/* Function to start or stop the next request later. */
-	struct work_struct		tape_dnr;
+	struct delayed_work		tape_dnr;
 };
 
 /* Externals from tape_core.c */
diff -urpN linux-2.6/drivers/s390/cio/css.h linux-2.6-patched/drivers/s390/cio/css.h
--- linux-2.6/drivers/s390/cio/css.h	2006-12-08 15:52:24.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/css.h	2006-12-08 15:52:44.000000000 +0100
@@ -73,6 +73,8 @@ struct senseid {
 }  __attribute__ ((packed,aligned(4)));
 
 struct ccw_device_private {
+	struct ccw_device *cdev;
+	struct subchannel *sch;
 	int state;		/* device state */
 	atomic_t onoff;
 	unsigned long registered;
diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2006-12-08 15:52:24.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device.c	2006-12-08 15:52:44.000000000 +0100
@@ -585,12 +585,13 @@ static struct ccw_device * get_disc_ccwd
 }
 
 static void
-ccw_device_add_changed(void *data)
+ccw_device_add_changed(struct work_struct *work)
 {
-
+	struct ccw_device_private *priv;
 	struct ccw_device *cdev;
 
-	cdev = data;
+	priv = container_of(work, struct ccw_device_private, kick_work);
+	cdev = priv->cdev;
 	if (device_add(&cdev->dev)) {
 		put_device(&cdev->dev);
 		return;
@@ -605,13 +606,15 @@ ccw_device_add_changed(void *data)
 extern int css_get_ssd_info(struct subchannel *sch);
 
 void
-ccw_device_do_unreg_rereg(void *data)
+ccw_device_do_unreg_rereg(struct work_struct *work)
 {
+	struct ccw_device_private *priv;
 	struct ccw_device *cdev;
 	struct subchannel *sch;
 	int need_rename;
 
-	cdev = data;
+	priv = container_of(work, struct ccw_device_private, kick_work);
+	cdev = priv->cdev;
 	sch = to_subchannel(cdev->dev.parent);
 	if (cdev->private->dev_id.devno != sch->schib.pmcw.dev) {
 		/*
@@ -659,7 +662,7 @@ ccw_device_do_unreg_rereg(void *data)
 		snprintf (cdev->dev.bus_id, BUS_ID_SIZE, "0.%x.%04x",
 			  sch->schid.ssid, sch->schib.pmcw.dev);
 	PREPARE_WORK(&cdev->private->kick_work,
-		     ccw_device_add_changed, cdev);
+		     ccw_device_add_changed);
 	queue_work(ccw_device_work, &cdev->private->kick_work);
 }
 
@@ -677,14 +680,16 @@ ccw_device_release(struct device *dev)
  * Register recognized device.
  */
 static void
-io_subchannel_register(void *data)
+io_subchannel_register(struct work_struct *work)
 {
+	struct ccw_device_private *priv;
 	struct ccw_device *cdev;
 	struct subchannel *sch;
 	int ret;
 	unsigned long flags;
 
-	cdev = data;
+	priv = container_of(work, struct ccw_device_private, kick_work);
+	cdev = priv->cdev;
 	sch = to_subchannel(cdev->dev.parent);
 
 	/*
@@ -734,11 +739,14 @@ out:
 }
 
 void
-ccw_device_call_sch_unregister(void *data)
+ccw_device_call_sch_unregister(struct work_struct *work)
 {
-	struct ccw_device *cdev = data;
+	struct ccw_device_private *priv;
+	struct ccw_device *cdev;
 	struct subchannel *sch;
 
+	priv = container_of(work, struct ccw_device_private, kick_work);
+	cdev = priv->cdev;
 	sch = to_subchannel(cdev->dev.parent);
 	css_sch_device_unregister(sch);
 	/* Reset intparm to zeroes. */
@@ -768,7 +776,7 @@ io_subchannel_recog_done(struct ccw_devi
 			break;
 		sch = to_subchannel(cdev->dev.parent);
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_call_sch_unregister, cdev);
+			     ccw_device_call_sch_unregister);
 		queue_work(slow_path_wq, &cdev->private->kick_work);
 		if (atomic_dec_and_test(&ccw_device_init_count))
 			wake_up(&ccw_device_init_wq);
@@ -783,7 +791,7 @@ io_subchannel_recog_done(struct ccw_devi
 		if (!get_device(&cdev->dev))
 			break;
 		PREPARE_WORK(&cdev->private->kick_work,
-			     io_subchannel_register, cdev);
+			     io_subchannel_register);
 		queue_work(slow_path_wq, &cdev->private->kick_work);
 		break;
 	}
@@ -865,6 +873,7 @@ io_subchannel_probe (struct subchannel *
 		kfree(cdev);
 		return -ENOMEM;
 	}
+	cdev->private->cdev = cdev;
 	atomic_set(&cdev->private->onoff, 0);
 	cdev->dev.parent = &sch->dev;
 	cdev->dev.release = ccw_device_release;
@@ -890,12 +899,13 @@ io_subchannel_probe (struct subchannel *
 	return rc;
 }
 
-static void
-ccw_device_unregister(void *data)
+static void ccw_device_unregister(struct work_struct *work)
 {
+	struct ccw_device_private *priv;
 	struct ccw_device *cdev;
 
-	cdev = (struct ccw_device *)data;
+	priv = container_of(work, struct ccw_device_private, kick_work);
+	cdev = priv->cdev;
 	if (test_and_clear_bit(1, &cdev->private->registered))
 		device_unregister(&cdev->dev);
 	put_device(&cdev->dev);
@@ -921,7 +931,7 @@ io_subchannel_remove (struct subchannel 
 	 */
 	if (get_device(&cdev->dev)) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_unregister, cdev);
+			     ccw_device_unregister);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 	}
 	return 0;
@@ -1048,6 +1058,7 @@ ccw_device_probe_console(void)
 	memset(&console_cdev, 0, sizeof(struct ccw_device));
 	memset(&console_private, 0, sizeof(struct ccw_device_private));
 	console_cdev.private = &console_private;
+	console_private.cdev = &console_cdev;
 	ret = ccw_device_console_enable(&console_cdev, sch);
 	if (ret) {
 		cio_release_console();
diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2006-12-08 15:52:24.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2006-12-08 15:52:44.000000000 +0100
@@ -194,7 +194,7 @@ ccw_device_handle_oper(struct ccw_device
 	    cdev->id.dev_model != cdev->private->senseid.dev_model ||
 	    cdev->private->dev_id.devno != sch->schib.pmcw.dev) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_do_unreg_rereg, cdev);
+			     ccw_device_do_unreg_rereg);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 		return 0;
 	}
@@ -329,19 +329,21 @@ ccw_device_sense_id_done(struct ccw_devi
 }
 
 static void
-ccw_device_oper_notify(void *data)
+ccw_device_oper_notify(struct work_struct *work)
 {
+	struct ccw_device_private *priv;
 	struct ccw_device *cdev;
 	struct subchannel *sch;
 	int ret;
 
-	cdev = data;
+	priv = container_of(work, struct ccw_device_private, kick_work);
+	cdev = priv->cdev;
 	sch = to_subchannel(cdev->dev.parent);
 	ret = (sch->driver && sch->driver->notify) ?
 		sch->driver->notify(&sch->dev, CIO_OPER) : 0;
 	if (!ret)
 		/* Driver doesn't want device back. */
-		ccw_device_do_unreg_rereg(cdev);
+		ccw_device_do_unreg_rereg(work);
 	else {
 		/* Reenable channel measurements, if needed. */
 		cmf_reenable(cdev);
@@ -377,8 +379,7 @@ ccw_device_done(struct ccw_device *cdev,
 
 	if (cdev->private->flags.donotify) {
 		cdev->private->flags.donotify = 0;
-		PREPARE_WORK(&cdev->private->kick_work, ccw_device_oper_notify,
-			     cdev);
+		PREPARE_WORK(&cdev->private->kick_work, ccw_device_oper_notify);
 		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 	}
 	wake_up(&cdev->private->wait_q);
@@ -528,13 +529,15 @@ ccw_device_recog_timeout(struct ccw_devi
 
 
 static void
-ccw_device_nopath_notify(void *data)
+ccw_device_nopath_notify(struct work_struct *work)
 {
+	struct ccw_device_private *priv;
 	struct ccw_device *cdev;
 	struct subchannel *sch;
 	int ret;
 
-	cdev = data;
+	priv = container_of(work, struct ccw_device_private, kick_work);
+	cdev = priv->cdev;
 	sch = to_subchannel(cdev->dev.parent);
 	/* Extra sanity. */
 	if (sch->lpm)
@@ -547,8 +550,7 @@ ccw_device_nopath_notify(void *data)
 			cio_disable_subchannel(sch);
 			if (get_device(&cdev->dev)) {
 				PREPARE_WORK(&cdev->private->kick_work,
-					     ccw_device_call_sch_unregister,
-					     cdev);
+					     ccw_device_call_sch_unregister);
 				queue_work(ccw_device_work,
 					   &cdev->private->kick_work);
 			} else
@@ -607,7 +609,7 @@ ccw_device_verify_done(struct ccw_device
 		/* Reset oper notify indication after verify error. */
 		cdev->private->flags.donotify = 0;
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_nopath_notify, cdev);
+			     ccw_device_nopath_notify);
 		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 		ccw_device_done(cdev, DEV_STATE_NOT_OPER);
 		break;
@@ -738,7 +740,7 @@ ccw_device_offline_notoper(struct ccw_de
 	sch = to_subchannel(cdev->dev.parent);
 	if (get_device(&cdev->dev)) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_call_sch_unregister, cdev);
+			     ccw_device_call_sch_unregister);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 	}
 	wake_up(&cdev->private->wait_q);
@@ -769,7 +771,7 @@ ccw_device_online_notoper(struct ccw_dev
 	}
 	if (get_device(&cdev->dev)) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_call_sch_unregister, cdev);
+			     ccw_device_call_sch_unregister);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 	}
 	wake_up(&cdev->private->wait_q);
@@ -874,7 +876,7 @@ ccw_device_online_timeout(struct ccw_dev
 		sch = to_subchannel(cdev->dev.parent);
 		if (!sch->lpm) {
 			PREPARE_WORK(&cdev->private->kick_work,
-				     ccw_device_nopath_notify, cdev);
+				     ccw_device_nopath_notify);
 			queue_work(ccw_device_notify_work,
 				   &cdev->private->kick_work);
 		} else
@@ -969,7 +971,7 @@ ccw_device_killing_irq(struct ccw_device
 			      ERR_PTR(-EIO));
 	if (!sch->lpm) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_nopath_notify, cdev);
+			     ccw_device_nopath_notify);
 		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 	} else if (cdev->private->flags.doverify)
 		/* Start delayed path verification. */
@@ -992,7 +994,7 @@ ccw_device_killing_timeout(struct ccw_de
 		sch = to_subchannel(cdev->dev.parent);
 		if (!sch->lpm) {
 			PREPARE_WORK(&cdev->private->kick_work,
-				     ccw_device_nopath_notify, cdev);
+				     ccw_device_nopath_notify);
 			queue_work(ccw_device_notify_work,
 				   &cdev->private->kick_work);
 		} else
@@ -1021,7 +1023,7 @@ void device_kill_io(struct subchannel *s
 	if (ret == -ENODEV) {
 		if (!sch->lpm) {
 			PREPARE_WORK(&cdev->private->kick_work,
-				     ccw_device_nopath_notify, cdev);
+				     ccw_device_nopath_notify);
 			queue_work(ccw_device_notify_work,
 				   &cdev->private->kick_work);
 		} else
@@ -1033,7 +1035,7 @@ void device_kill_io(struct subchannel *s
 			      ERR_PTR(-EIO));
 	if (!sch->lpm) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_nopath_notify, cdev);
+			     ccw_device_nopath_notify);
 		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 	} else
 		/* Start delayed path verification. */
diff -urpN linux-2.6/drivers/s390/cio/device.h linux-2.6-patched/drivers/s390/cio/device.h
--- linux-2.6/drivers/s390/cio/device.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device.h	2006-12-08 15:52:44.000000000 +0100
@@ -78,8 +78,8 @@ void io_subchannel_recog_done(struct ccw
 
 int ccw_device_cancel_halt_clear(struct ccw_device *);
 
-void ccw_device_do_unreg_rereg(void *);
-void ccw_device_call_sch_unregister(void *);
+void ccw_device_do_unreg_rereg(struct work_struct *);
+void ccw_device_call_sch_unregister(struct work_struct *);
 
 int ccw_device_recognition(struct ccw_device *);
 int ccw_device_online(struct ccw_device *);
diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2006-12-08 15:52:24.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2006-12-08 15:52:44.000000000 +0100
@@ -2045,11 +2045,13 @@ omit_handler_call:
 }
 
 static void
-qdio_call_shutdown(void *data)
+qdio_call_shutdown(struct work_struct *work)
 {
+	struct ccw_device_private *priv;
 	struct ccw_device *cdev;
 
-	cdev = (struct ccw_device *)data;
+	priv = container_of(work, struct ccw_device_private, kick_work);
+	cdev = priv->cdev;
 	qdio_shutdown(cdev, QDIO_FLAG_CLEANUP_USING_CLEAR);
 	put_device(&cdev->dev);
 }
@@ -2091,7 +2093,7 @@ qdio_timeout_handler(struct ccw_device *
 		if (get_device(&cdev->dev)) {
 			/* Can't call shutdown from interrupt context. */
 			PREPARE_WORK(&cdev->private->kick_work,
-				     qdio_call_shutdown, (void *)cdev);
+				     qdio_call_shutdown);
 			queue_work(ccw_device_work, &cdev->private->kick_work);
 		}
 		break;
