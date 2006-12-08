Return-Path: <linux-kernel-owner+w=401wt.eu-S1425540AbWLHPAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425540AbWLHPAQ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425541AbWLHPAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:00:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47516 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425540AbWLHPAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:00:12 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] WorkStruct: Fix S390 driver workstruct usage
Date: Fri, 08 Dec 2006 14:59:40 +0000
To: torvalds@osdl.org, akpm@osdl.org, schwidefsky@de.ibm.com
Cc: linux390@de.ibm.com, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, dhowells@redhat.com
Message-Id: <20061208145940.21411.77769.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix S390 driver workstruct reduction problems.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 drivers/s390/char/ctrlchar.c   |    9 +++++----
 drivers/s390/char/tape.h       |    3 ++-
 drivers/s390/char/tape_34xx.c  |   26 ++++++++++++--------------
 drivers/s390/char/tape_block.c |   13 ++++++-------
 drivers/s390/char/tape_core.c  |   12 ++++++------
 drivers/s390/cio/css.h         |    1 +
 drivers/s390/cio/device.c      |   33 ++++++++++++++++-----------------
 drivers/s390/cio/device.h      |    4 ++--
 drivers/s390/cio/device_fsm.c  |   34 ++++++++++++++++------------------
 drivers/s390/cio/qdio.c        |    6 +++---
 10 files changed, 69 insertions(+), 72 deletions(-)

diff --git a/drivers/s390/char/ctrlchar.c b/drivers/s390/char/ctrlchar.c
index 49e9628..9fcfe3a 100644
--- a/drivers/s390/char/ctrlchar.c
+++ b/drivers/s390/char/ctrlchar.c
@@ -15,15 +15,16 @@ #include <linux/ctype.h>
 #include "ctrlchar.h"
 
 #ifdef CONFIG_MAGIC_SYSRQ
+static struct tty_struct *ctrlchar_sysrq_tty;
 static int ctrlchar_sysrq_key;
 
 static void
-ctrlchar_handle_sysrq(void *tty)
+ctrlchar_handle_sysrq(struct work_struct *unused)
 {
-	handle_sysrq(ctrlchar_sysrq_key, (struct tty_struct *) tty);
+	handle_sysrq(ctrlchar_sysrq_key, ctrlchar_sysrq_tty);
 }
 
-static DECLARE_WORK(ctrlchar_work, ctrlchar_handle_sysrq, NULL);
+static DECLARE_WORK(ctrlchar_work, ctrlchar_handle_sysrq);
 #endif
 
 
@@ -52,8 +53,8 @@ ctrlchar_handle(const unsigned char *buf
 #ifdef CONFIG_MAGIC_SYSRQ
 	/* racy */
 	if (len == 3 && buf[1] == '-') {
+		ctrlchar_sysrq_tty = tty;
 		ctrlchar_sysrq_key = buf[2];
-		ctrlchar_work.data = tty;
 		schedule_work(&ctrlchar_work);
 		return CTRLCHAR_SYSRQ;
 	}
diff --git a/drivers/s390/char/tape.h b/drivers/s390/char/tape.h
index 1f4c899..1323142 100644
--- a/drivers/s390/char/tape.h
+++ b/drivers/s390/char/tape.h
@@ -185,6 +185,7 @@ struct tape_blk_data
 
 	/* Task to move entries from block request to CCS request queue. */
 	struct work_struct	requeue_task;
+	void *			requeue_task_data;
 	atomic_t		requeue_scheduled;
 
 	/* Current position on the tape. */
@@ -240,7 +241,7 @@ #ifdef CONFIG_S390_TAPE_BLOCK
 #endif
 
 	/* Function to start or stop the next request later. */
-	struct work_struct		tape_dnr;
+	struct delayed_work		tape_dnr;
 };
 
 /* Externals from tape_core.c */
diff --git a/drivers/s390/char/tape_34xx.c b/drivers/s390/char/tape_34xx.c
index 7b95dab..b5ebc97 100644
--- a/drivers/s390/char/tape_34xx.c
+++ b/drivers/s390/char/tape_34xx.c
@@ -102,14 +102,17 @@ tape_34xx_medium_sense(struct tape_devic
  * Maybe that's useful for other actions we want to start from the
  * interrupt handler.
  */
+struct tape_34xx_work_item {
+	struct tape_device	*device;
+	enum tape_op		 op;
+	struct work_struct	 work;
+};
+
 static void
-tape_34xx_work_handler(void *data)
+tape_34xx_work_handler(struct work_struct *work)
 {
-	struct {
-		struct tape_device	*device;
-		enum tape_op		 op;
-		struct work_struct	 work;
-	} *p = data;
+	struct tape_34xx_work_item *p =
+		container_of(work, struct tape_34xx_work_item, work);
 
 	switch(p->op) {
 		case TO_MSEN:
@@ -126,17 +129,12 @@ tape_34xx_work_handler(void *data)
 static int
 tape_34xx_schedule_work(struct tape_device *device, enum tape_op op)
 {
-	struct {
-		struct tape_device	*device;
-		enum tape_op		 op;
-		struct work_struct	 work;
-	} *p;
+	struct tape_34xx_work_item *p;
 
-	if ((p = kmalloc(sizeof(*p), GFP_ATOMIC)) == NULL)
+	if ((p = kzalloc(sizeof(*p), GFP_ATOMIC)) == NULL)
 		return -ENOMEM;
 
-	memset(p, 0, sizeof(*p));
-	INIT_WORK(&p->work, tape_34xx_work_handler, p);
+	INIT_WORK(&p->work, tape_34xx_work_handler);
 
 	p->device = tape_get_device_reference(device);
 	p->op     = op;
diff --git a/drivers/s390/char/tape_block.c b/drivers/s390/char/tape_block.c
index 3225fcd..f2e0f78 100644
--- a/drivers/s390/char/tape_block.c
+++ b/drivers/s390/char/tape_block.c
@@ -143,7 +143,8 @@ tapeblock_start_request(struct tape_devi
  * queue.
  */
 static void
-tapeblock_requeue(void *data) {
+tapeblock_requeue(struct work_struct *work)
+{
 	struct tape_device *	device;
 	request_queue_t *	queue;
 	int			nr_queued;
@@ -151,9 +152,7 @@ tapeblock_requeue(void *data) {
 	struct list_head *	l;
 	int			rc;
 
-	device = (struct tape_device *) data;
-	if (!device)
-		return;
+	device = container_of(work, struct tape_device, blk_data.requeue_task);
 
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	queue  = device->blk_data.request_queue;
@@ -255,8 +254,8 @@ tapeblock_setup_device(struct tape_devic
 
 	add_disk(disk);
 
-	INIT_WORK(&blkdat->requeue_task, tapeblock_requeue,
-		tape_get_device_reference(device));
+	tape_get_device_reference(device);
+	INIT_WORK(&blkdat->requeue_task, tapeblock_requeue);
 
 	return 0;
 
@@ -271,7 +270,7 @@ void
 tapeblock_cleanup_device(struct tape_device *device)
 {
 	flush_scheduled_work();
-	device->blk_data.requeue_task.data = tape_put_device(device);
+	tape_put_device(device);
 
 	if (!device->blk_data.disk) {
 		PRINT_ERR("(%s): No gendisk to clean up!\n",
diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index 2826aed..0ee5b03 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -28,7 +28,7 @@ #include "tape_std.h"
 #define PRINTK_HEADER "TAPE_CORE: "
 
 static void __tape_do_irq (struct ccw_device *, unsigned long, struct irb *);
-static void tape_delayed_next_request(void * data);
+static void tape_delayed_next_request(struct work_struct *work);
 
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
@@ -724,7 +724,7 @@ #endif
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
 	struct tape_device *	device;
 
-	device = (struct tape_device *) data;
+	device = container_of(work, struct tape_device, tape_dnr.work);
 	DBF_LH(6, "tape_delayed_next_request(%p)\n", device);
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	__tape_start_next_request(device);
diff --git a/drivers/s390/cio/css.h b/drivers/s390/cio/css.h
index 9ff064e..d36440c 100644
--- a/drivers/s390/cio/css.h
+++ b/drivers/s390/cio/css.h
@@ -103,6 +103,7 @@ struct ccw_device_private {
 	struct pgid pgid[8];	/* path group IDs per chpid*/
 	struct ccw1 iccws[2];	/* ccws for SNID/SID/SPGID commands */
 	struct work_struct kick_work;
+	struct ccw_device *cdev;
 	wait_queue_head_t wait_q;
 	struct timer_list timer;
 	void *cmb;			/* measurement information */
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index d3d3716..725ade4 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -585,12 +585,11 @@ static struct ccw_device * get_disc_ccwd
 }
 
 static void
-ccw_device_add_changed(void *data)
+ccw_device_add_changed(struct work_struct *work)
 {
-
 	struct ccw_device *cdev;
 
-	cdev = data;
+	cdev = container_of(work, struct ccw_device_private, kick_work)->cdev;
 	if (device_add(&cdev->dev)) {
 		put_device(&cdev->dev);
 		return;
@@ -605,13 +604,13 @@ ccw_device_add_changed(void *data)
 extern int css_get_ssd_info(struct subchannel *sch);
 
 void
-ccw_device_do_unreg_rereg(void *data)
+ccw_device_do_unreg_rereg(struct work_struct *work)
 {
 	struct ccw_device *cdev;
 	struct subchannel *sch;
 	int need_rename;
 
-	cdev = data;
+	cdev = container_of(work, struct ccw_device_private, kick_work)->cdev;
 	sch = to_subchannel(cdev->dev.parent);
 	if (cdev->private->dev_id.devno != sch->schib.pmcw.dev) {
 		/*
@@ -658,8 +657,7 @@ ccw_device_do_unreg_rereg(void *data)
 	if (need_rename)
 		snprintf (cdev->dev.bus_id, BUS_ID_SIZE, "0.%x.%04x",
 			  sch->schid.ssid, sch->schib.pmcw.dev);
-	PREPARE_WORK(&cdev->private->kick_work,
-		     ccw_device_add_changed, cdev);
+	PREPARE_WORK(&cdev->private->kick_work, ccw_device_add_changed);
 	queue_work(ccw_device_work, &cdev->private->kick_work);
 }
 
@@ -677,14 +675,14 @@ ccw_device_release(struct device *dev)
  * Register recognized device.
  */
 static void
-io_subchannel_register(void *data)
+io_subchannel_register(struct work_struct *work)
 {
 	struct ccw_device *cdev;
 	struct subchannel *sch;
 	int ret;
 	unsigned long flags;
 
-	cdev = data;
+	cdev = container_of(work, struct ccw_device_private, kick_work)->cdev;
 	sch = to_subchannel(cdev->dev.parent);
 
 	/*
@@ -734,11 +732,12 @@ out:
 }
 
 void
-ccw_device_call_sch_unregister(void *data)
+ccw_device_call_sch_unregister(struct work_struct *work)
 {
-	struct ccw_device *cdev = data;
+	struct ccw_device *cdev;
 	struct subchannel *sch;
 
+	cdev = container_of(work, struct ccw_device_private, kick_work)->cdev;
 	sch = to_subchannel(cdev->dev.parent);
 	css_sch_device_unregister(sch);
 	/* Reset intparm to zeroes. */
@@ -768,7 +767,7 @@ io_subchannel_recog_done(struct ccw_devi
 			break;
 		sch = to_subchannel(cdev->dev.parent);
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_call_sch_unregister, cdev);
+			     ccw_device_call_sch_unregister);
 		queue_work(slow_path_wq, &cdev->private->kick_work);
 		if (atomic_dec_and_test(&ccw_device_init_count))
 			wake_up(&ccw_device_init_wq);
@@ -783,7 +782,7 @@ io_subchannel_recog_done(struct ccw_devi
 		if (!get_device(&cdev->dev))
 			break;
 		PREPARE_WORK(&cdev->private->kick_work,
-			     io_subchannel_register, cdev);
+			     io_subchannel_register);
 		queue_work(slow_path_wq, &cdev->private->kick_work);
 		break;
 	}
@@ -868,6 +867,7 @@ io_subchannel_probe (struct subchannel *
 	atomic_set(&cdev->private->onoff, 0);
 	cdev->dev.parent = &sch->dev;
 	cdev->dev.release = ccw_device_release;
+	cdev->private->cdev = cdev;
 	INIT_LIST_HEAD(&cdev->private->kick_work.entry);
 	/* Do first half of device_register. */
 	device_initialize(&cdev->dev);
@@ -891,11 +891,11 @@ io_subchannel_probe (struct subchannel *
 }
 
 static void
-ccw_device_unregister(void *data)
+ccw_device_unregister(struct work_struct *work)
 {
 	struct ccw_device *cdev;
 
-	cdev = (struct ccw_device *)data;
+	cdev = container_of(work, struct ccw_device_private, kick_work)->cdev;
 	if (test_and_clear_bit(1, &cdev->private->registered))
 		device_unregister(&cdev->dev);
 	put_device(&cdev->dev);
@@ -920,8 +920,7 @@ io_subchannel_remove (struct subchannel 
 	 * semaphore.
 	 */
 	if (get_device(&cdev->dev)) {
-		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_unregister, cdev);
+		PREPARE_WORK(&cdev->private->kick_work, ccw_device_unregister);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 	}
 	return 0;
diff --git a/drivers/s390/cio/device.h b/drivers/s390/cio/device.h
index 9233b5c..d5fe95e 100644
--- a/drivers/s390/cio/device.h
+++ b/drivers/s390/cio/device.h
@@ -78,8 +78,8 @@ void io_subchannel_recog_done(struct ccw
 
 int ccw_device_cancel_halt_clear(struct ccw_device *);
 
-void ccw_device_do_unreg_rereg(void *);
-void ccw_device_call_sch_unregister(void *);
+void ccw_device_do_unreg_rereg(struct work_struct *);
+void ccw_device_call_sch_unregister(struct work_struct *);
 
 int ccw_device_recognition(struct ccw_device *);
 int ccw_device_online(struct ccw_device *);
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index 09c7672..b9f6ae6 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -194,7 +194,7 @@ ccw_device_handle_oper(struct ccw_device
 	    cdev->id.dev_model != cdev->private->senseid.dev_model ||
 	    cdev->private->dev_id.devno != sch->schib.pmcw.dev) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_do_unreg_rereg, cdev);
+			     ccw_device_do_unreg_rereg);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 		return 0;
 	}
@@ -329,19 +329,19 @@ ccw_device_sense_id_done(struct ccw_devi
 }
 
 static void
-ccw_device_oper_notify(void *data)
+ccw_device_oper_notify(struct work_struct *work)
 {
 	struct ccw_device *cdev;
 	struct subchannel *sch;
 	int ret;
 
-	cdev = data;
+	cdev = container_of(work, struct ccw_device_private, kick_work)->cdev;
 	sch = to_subchannel(cdev->dev.parent);
 	ret = (sch->driver && sch->driver->notify) ?
 		sch->driver->notify(&sch->dev, CIO_OPER) : 0;
 	if (!ret)
 		/* Driver doesn't want device back. */
-		ccw_device_do_unreg_rereg(cdev);
+		ccw_device_do_unreg_rereg(&cdev->private->kick_work);
 	else {
 		/* Reenable channel measurements, if needed. */
 		cmf_reenable(cdev);
@@ -377,8 +377,7 @@ ccw_device_done(struct ccw_device *cdev,
 
 	if (cdev->private->flags.donotify) {
 		cdev->private->flags.donotify = 0;
-		PREPARE_WORK(&cdev->private->kick_work, ccw_device_oper_notify,
-			     cdev);
+		PREPARE_WORK(&cdev->private->kick_work, ccw_device_oper_notify);
 		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 	}
 	wake_up(&cdev->private->wait_q);
@@ -528,13 +527,13 @@ ccw_device_recog_timeout(struct ccw_devi
 
 
 static void
-ccw_device_nopath_notify(void *data)
+ccw_device_nopath_notify(struct work_struct *work)
 {
 	struct ccw_device *cdev;
 	struct subchannel *sch;
 	int ret;
 
-	cdev = data;
+	cdev = container_of(work, struct ccw_device_private, kick_work)->cdev;
 	sch = to_subchannel(cdev->dev.parent);
 	/* Extra sanity. */
 	if (sch->lpm)
@@ -547,8 +546,7 @@ ccw_device_nopath_notify(void *data)
 			cio_disable_subchannel(sch);
 			if (get_device(&cdev->dev)) {
 				PREPARE_WORK(&cdev->private->kick_work,
-					     ccw_device_call_sch_unregister,
-					     cdev);
+					     ccw_device_call_sch_unregister);
 				queue_work(ccw_device_work,
 					   &cdev->private->kick_work);
 			} else
@@ -607,7 +605,7 @@ ccw_device_verify_done(struct ccw_device
 		/* Reset oper notify indication after verify error. */
 		cdev->private->flags.donotify = 0;
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_nopath_notify, cdev);
+			     ccw_device_nopath_notify);
 		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 		ccw_device_done(cdev, DEV_STATE_NOT_OPER);
 		break;
@@ -738,7 +736,7 @@ ccw_device_offline_notoper(struct ccw_de
 	sch = to_subchannel(cdev->dev.parent);
 	if (get_device(&cdev->dev)) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_call_sch_unregister, cdev);
+			     ccw_device_call_sch_unregister);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 	}
 	wake_up(&cdev->private->wait_q);
@@ -769,7 +767,7 @@ ccw_device_online_notoper(struct ccw_dev
 	}
 	if (get_device(&cdev->dev)) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_call_sch_unregister, cdev);
+			     ccw_device_call_sch_unregister);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 	}
 	wake_up(&cdev->private->wait_q);
@@ -874,7 +872,7 @@ ccw_device_online_timeout(struct ccw_dev
 		sch = to_subchannel(cdev->dev.parent);
 		if (!sch->lpm) {
 			PREPARE_WORK(&cdev->private->kick_work,
-				     ccw_device_nopath_notify, cdev);
+				     ccw_device_nopath_notify);
 			queue_work(ccw_device_notify_work,
 				   &cdev->private->kick_work);
 		} else
@@ -969,7 +967,7 @@ ccw_device_killing_irq(struct ccw_device
 			      ERR_PTR(-EIO));
 	if (!sch->lpm) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_nopath_notify, cdev);
+			     ccw_device_nopath_notify);
 		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 	} else if (cdev->private->flags.doverify)
 		/* Start delayed path verification. */
@@ -992,7 +990,7 @@ ccw_device_killing_timeout(struct ccw_de
 		sch = to_subchannel(cdev->dev.parent);
 		if (!sch->lpm) {
 			PREPARE_WORK(&cdev->private->kick_work,
-				     ccw_device_nopath_notify, cdev);
+				     ccw_device_nopath_notify);
 			queue_work(ccw_device_notify_work,
 				   &cdev->private->kick_work);
 		} else
@@ -1021,7 +1019,7 @@ void device_kill_io(struct subchannel *s
 	if (ret == -ENODEV) {
 		if (!sch->lpm) {
 			PREPARE_WORK(&cdev->private->kick_work,
-				     ccw_device_nopath_notify, cdev);
+				     ccw_device_nopath_notify);
 			queue_work(ccw_device_notify_work,
 				   &cdev->private->kick_work);
 		} else
@@ -1033,7 +1031,7 @@ void device_kill_io(struct subchannel *s
 			      ERR_PTR(-EIO));
 	if (!sch->lpm) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_nopath_notify, cdev);
+			     ccw_device_nopath_notify);
 		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 	} else
 		/* Start delayed path verification. */
diff --git a/drivers/s390/cio/qdio.c b/drivers/s390/cio/qdio.c
index 8d5fa1b..cf07755 100644
--- a/drivers/s390/cio/qdio.c
+++ b/drivers/s390/cio/qdio.c
@@ -2045,11 +2045,11 @@ omit_handler_call:
 }
 
 static void
-qdio_call_shutdown(void *data)
+qdio_call_shutdown(struct work_struct *work)
 {
 	struct ccw_device *cdev;
 
-	cdev = (struct ccw_device *)data;
+	cdev = container_of(work, struct ccw_device_private, kick_work)->cdev;
 	qdio_shutdown(cdev, QDIO_FLAG_CLEANUP_USING_CLEAR);
 	put_device(&cdev->dev);
 }
@@ -2091,7 +2091,7 @@ qdio_timeout_handler(struct ccw_device *
 		if (get_device(&cdev->dev)) {
 			/* Can't call shutdown from interrupt context. */
 			PREPARE_WORK(&cdev->private->kick_work,
-				     qdio_call_shutdown, (void *)cdev);
+				     qdio_call_shutdown);
 			queue_work(ccw_device_work, &cdev->private->kick_work);
 		}
 		break;
