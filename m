Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbUD1T1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUD1T1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUD1T0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:26:38 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:36549 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S264951AbUD1Qtp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:49:45 -0400
Date: Wed, 28 Apr 2004 18:49:34 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (2/6): common i/o layer.
Message-ID: <20040428164934.GC2777@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: common i/o layer.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Common i/o layer changes:
 - Don't use bus ids in crw debug feature.
 - Use cio_oper for oper notification to disconnected devices.
 - Remove __get_subchannel_by_stsch.
 - Make cio workqueue a single threaded workqueue.
 - Introduce addiotnal cio_notify workqueue for device driver notification.
 - Switch off path in vpm if cio_start returned -ENODEV.
 - Fix rescan for new subchannels after a logical vary on.

diffstat:
 drivers/s390/cio/chsc.c        |   13 ++++++-------
 drivers/s390/cio/css.c         |   28 ++--------------------------
 drivers/s390/cio/device.c      |   34 +++++++++++++++++++++++++---------
 drivers/s390/cio/device.h      |    3 ++-
 drivers/s390/cio/device_fsm.c  |   32 +++++++++++++++++++-------------
 drivers/s390/cio/device_pgid.c |    2 +-
 6 files changed, 55 insertions(+), 57 deletions(-)

diff -urN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-s390/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	Wed Apr 28 17:51:15 2004
+++ linux-2.6-s390/drivers/s390/cio/chsc.c	Wed Apr 28 17:51:38 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.107 $
+ *   $Revision: 1.110 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -148,7 +148,7 @@
 	 */
 	if (ssd_area->st > 3) { /* uhm, that looks strange... */
 		CIO_CRW_EVENT(0, "Strange subchannel type %d"
-			      " for sch %s\n", ssd_area->st, sch->dev.bus_id);
+			      " for sch %04x\n", ssd_area->st, sch->irq);
 		/*
 		 * There may have been a new subchannel type defined in the
 		 * time since this code was written; since we don't know which
@@ -157,8 +157,8 @@
 		return 0;
 	} else {
 		const char *type[4] = {"I/O", "chsc", "message", "ADM"};
-		CIO_CRW_EVENT(6, "ssd: sch %s is %s subchannel\n",
-			      sch->dev.bus_id, type[ssd_area->st]);
+		CIO_CRW_EVENT(6, "ssd: sch %04x is %s subchannel\n",
+			      sch->irq, type[ssd_area->st]);
 
 		sch->ssd_info.valid = 1;
 		sch->ssd_info.type = ssd_area->st;
@@ -818,6 +818,8 @@
 	for (irq = 0; irq < __MAX_SUBCHANNELS; irq++) {
 		struct schib schib;
 
+		if (need_rescan)
+			break;
 		sch = get_subchannel_by_schid(irq);
 		if (sch) {
 			put_device(&sch->dev);
@@ -826,15 +828,12 @@
 		if (stsch(irq, &schib))
 			/* We're through */
 			break;
-		if (need_rescan)
-			continue;
 		/* Put it on the slow path. */
 		ret = css_enqueue_subchannel_slow(irq);
 		if (ret) {
 			css_clear_subchannel_slow_list();
 			need_rescan = 1;
 		}
-		continue;
 	}
 	if (need_rescan || css_slow_subchannels_exist())
 		schedule_work(&varyonoff_work);
diff -urN linux-2.6/drivers/s390/cio/css.c linux-2.6-s390/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	Wed Apr 28 17:51:15 2004
+++ linux-2.6-s390/drivers/s390/cio/css.c	Wed Apr 28 17:51:38 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/css.c
  *  driver for channel subsystem
- *   $Revision: 1.72 $
+ *   $Revision: 1.73 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -124,24 +124,6 @@
 	return ret;
 }
 
-static struct subchannel *
-__get_subchannel_by_stsch(int irq)
-{
-	struct subchannel *sch;
-	int cc;
-	struct schib schib;
-
-	cc = stsch(irq, &schib);
-	if (cc || !schib.pmcw.dnv)
-		return NULL;
-	sch = (struct subchannel *)(unsigned long)schib.pmcw.intparm;
-	if (!sch)
-		return NULL;
-	if (get_device(&sch->dev))
-		return sch;
-	return NULL;
-}
-
 struct subchannel *
 get_subchannel_by_schid(int irq)
 {
@@ -151,13 +133,8 @@
 
 	if (!get_bus(&css_bus_type))
 		return NULL;
-
-	/* Try to get subchannel from pmcw first. */ 
-	sch = __get_subchannel_by_stsch(irq);
-	if (sch)
-		goto out;
 	down_read(&css_bus_type.subsys.rwsem);
-
+	sch = NULL;
 	list_for_each(entry, &css_bus_type.devices.list) {
 		dev = get_device(container_of(entry,
 					      struct device, bus_list));
@@ -170,7 +147,6 @@
 		sch = NULL;
 	}
 	up_read(&css_bus_type.subsys.rwsem);
-out:
 	put_bus(&css_bus_type);
 
 	return sch;
diff -urN linux-2.6/drivers/s390/cio/device.c linux-2.6-s390/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	Wed Apr 28 17:51:15 2004
+++ linux-2.6-s390/drivers/s390/cio/device.c	Wed Apr 28 17:51:38 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.113 $
+ *   $Revision: 1.115 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -138,6 +138,7 @@
 };
 
 struct workqueue_struct *ccw_device_work;
+struct workqueue_struct *ccw_device_notify_work;
 static wait_queue_head_t ccw_device_init_wq;
 static atomic_t ccw_device_init_count;
 
@@ -149,20 +150,30 @@
 	init_waitqueue_head(&ccw_device_init_wq);
 	atomic_set(&ccw_device_init_count, 0);
 
-	ccw_device_work = create_workqueue("cio");
+	ccw_device_work = create_singlethread_workqueue("cio");
 	if (!ccw_device_work)
 		return -ENOMEM; /* FIXME: better errno ? */
-
+	ccw_device_notify_work = create_singlethread_workqueue("cio_notify");
+	if (!ccw_device_notify_work) {
+		ret = -ENOMEM; /* FIXME: better errno ? */
+		goto out_err;
+	}
 	if ((ret = bus_register (&ccw_bus_type)))
-		return ret;
+		goto out_err;
 
 	if ((ret = driver_register(&io_subchannel_driver.drv)))
-		return ret;
+		goto out_err;
 
 	wait_event(ccw_device_init_wq,
 		   atomic_read(&ccw_device_init_count) == 0);
 	flush_workqueue(ccw_device_work);
 	return 0;
+out_err:
+	if (ccw_device_work)
+		destroy_workqueue(ccw_device_work);
+	if (ccw_device_notify_work)
+		destroy_workqueue(ccw_device_notify_work);
+	return ret;
 }
 
 static void __exit
@@ -170,6 +181,7 @@
 {
 	driver_unregister(&io_subchannel_driver.drv);
 	bus_unregister(&ccw_bus_type);
+	destroy_workqueue(ccw_device_notify_work);
 	destroy_workqueue(ccw_device_work);
 }
 
@@ -553,18 +565,21 @@
 	wake_up(&cdev->private->wait_q);
 }
 
-static void
-device_call_sch_unregister(void *data)
+void
+ccw_device_call_sch_unregister(void *data)
 {
 	struct ccw_device *cdev = data;
 	struct subchannel *sch;
 
 	sch = to_subchannel(cdev->dev.parent);
-	device_unregister(&sch->dev);
+	/* Check if device is registered. */
+	if (!list_empty(&sch->dev.node))
+		device_unregister(&sch->dev);
 	/* Reset intparm to zeroes. */
 	sch->schib.pmcw.intparm = 0;
 	cio_modify(sch);
 	put_device(&cdev->dev);
+	put_device(&sch->dev);
 }
 
 /*
@@ -587,7 +602,7 @@
 			break;
 		sch = to_subchannel(cdev->dev.parent);
 		INIT_WORK(&cdev->private->kick_work,
-			  device_call_sch_unregister, (void *) cdev);
+			  ccw_device_call_sch_unregister, (void *) cdev);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 		break;
 	case DEV_STATE_BOXED:
@@ -982,3 +997,4 @@
 EXPORT_SYMBOL(get_ccwdev_by_busid);
 EXPORT_SYMBOL(ccw_bus_type);
 EXPORT_SYMBOL(ccw_device_work);
+EXPORT_SYMBOL(ccw_device_notify_work);
diff -urN linux-2.6/drivers/s390/cio/device.h linux-2.6-s390/drivers/s390/cio/device.h
--- linux-2.6/drivers/s390/cio/device.h	Wed Apr 28 17:51:15 2004
+++ linux-2.6-s390/drivers/s390/cio/device.h	Wed Apr 28 17:51:38 2004
@@ -66,6 +66,7 @@
 }
 
 extern struct workqueue_struct *ccw_device_work;
+extern struct workqueue_struct *ccw_device_notify_work;
 
 void io_subchannel_recog_done(struct ccw_device *cdev);
 
@@ -73,7 +74,7 @@
 
 int ccw_device_register(struct ccw_device *);
 void ccw_device_do_unreg_rereg(void *);
-
+void ccw_device_call_sch_unregister(void *);
 
 int ccw_device_recognition(struct ccw_device *);
 int ccw_device_online(struct ccw_device *);
diff -urN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-s390/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	Wed Apr 28 17:51:15 2004
+++ linux-2.6-s390/drivers/s390/cio/device_fsm.c	Wed Apr 28 17:51:38 2004
@@ -328,7 +328,7 @@
 		cdev->private->flags.donotify = 0;
 		PREPARE_WORK(&cdev->private->kick_work, ccw_device_oper_notify,
 			     (void *)cdev);
-		queue_work(ccw_device_work, &cdev->private->kick_work);
+		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 	}
 	wake_up(&cdev->private->wait_q);
 
@@ -441,10 +441,13 @@
 		if (get_device(&sch->dev)) {
 			/* Driver doesn't want to keep device. */
 			cio_disable_subchannel(sch);
-			device_unregister(&sch->dev);
-			sch->schib.pmcw.intparm = 0;
-			cio_modify(sch);
-			put_device(&sch->dev);
+			if (get_device(&cdev->dev)) {
+				PREPARE_WORK(&cdev->private->kick_work,
+					     ccw_device_call_sch_unregister,
+					     (void *)cdev);
+				queue_work(ccw_device_work,
+					   &cdev->private->kick_work);
+			}
 		}
 	} else {
 		cio_disable_subchannel(sch);
@@ -464,7 +467,7 @@
 	cdev = sch->dev.driver_data;
 	PREPARE_WORK(&cdev->private->kick_work,
 		     ccw_device_nopath_notify, (void *)cdev);
-	queue_work(ccw_device_work, &cdev->private->kick_work);
+	queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 }
 
 
@@ -482,7 +485,7 @@
 	default:
 		PREPARE_WORK(&cdev->private->kick_work,
 			     ccw_device_nopath_notify, (void *)cdev);
-		queue_work(ccw_device_work, &cdev->private->kick_work);
+		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 		ccw_device_done(cdev, DEV_STATE_NOT_OPER);
 		break;
 	}
@@ -722,7 +725,8 @@
 		if (!sch->lpm) {
 			PREPARE_WORK(&cdev->private->kick_work,
 				     ccw_device_nopath_notify, (void *)cdev);
-			queue_work(ccw_device_work, &cdev->private->kick_work);
+			queue_work(ccw_device_notify_work,
+				   &cdev->private->kick_work);
 		} else
 			dev_fsm_event(cdev, DEV_EVENT_NOTOPER);
 	} else if (cdev->handler)
@@ -798,7 +802,7 @@
 	if (!sch->lpm) {
 		PREPARE_WORK(&cdev->private->kick_work,
 			     ccw_device_nopath_notify, (void *)cdev);
-		queue_work(ccw_device_work, &cdev->private->kick_work);
+		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 	} else if (cdev->private->flags.doverify)
 		/* Start delayed path verification. */
 		ccw_device_online_verify(cdev, 0);
@@ -821,7 +825,8 @@
 		if (!sch->lpm) {
 			PREPARE_WORK(&cdev->private->kick_work,
 				     ccw_device_nopath_notify, (void *)cdev);
-			queue_work(ccw_device_work, &cdev->private->kick_work);
+			queue_work(ccw_device_notify_work,
+				   &cdev->private->kick_work);
 		} else
 			dev_fsm_event(cdev, DEV_EVENT_NOTOPER);
 		return;
@@ -871,7 +876,7 @@
 	if (!sch->lpm) {
 		PREPARE_WORK(&cdev->private->kick_work,
 			     ccw_device_nopath_notify, (void *)cdev);
-		queue_work(ccw_device_work, &cdev->private->kick_work);
+		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 	} else if (cdev->private->flags.doverify)
 		ccw_device_online_verify(cdev, 0);
 }
@@ -894,7 +899,8 @@
 		if (!sch->lpm) {
 			PREPARE_WORK(&cdev->private->kick_work,
 				     ccw_device_nopath_notify, (void *)cdev);
-			queue_work(ccw_device_work, &cdev->private->kick_work);
+			queue_work(ccw_device_notify_work,
+				   &cdev->private->kick_work);
 		} else
 			dev_fsm_event(cdev, DEV_EVENT_NOTOPER);
 		return;
@@ -905,7 +911,7 @@
 	if (!sch->lpm) {
 		PREPARE_WORK(&cdev->private->kick_work,
 			     ccw_device_nopath_notify, (void *)cdev);
-		queue_work(ccw_device_work, &cdev->private->kick_work);
+		queue_work(ccw_device_notify_work, &cdev->private->kick_work);
 	} else if (cdev->private->flags.doverify)
 		/* Start delayed path verification. */
 		ccw_device_online_verify(cdev, 0);
diff -urN linux-2.6/drivers/s390/cio/device_pgid.c linux-2.6-s390/drivers/s390/cio/device_pgid.c
--- linux-2.6/drivers/s390/cio/device_pgid.c	Sun Apr  4 05:37:23 2004
+++ linux-2.6-s390/drivers/s390/cio/device_pgid.c	Wed Apr 28 17:51:38 2004
@@ -227,7 +227,7 @@
 		ret = cio_start (sch, cdev->private->iccws,
 				 cdev->private->imask);
 		/* ret is 0, -EBUSY, -EACCES or -ENODEV */
-		if (ret != -EACCES)
+		if ((ret != -EACCES) && (ret != -ENODEV))
 			return ret;
 	}
 	/* PGID command failed on this path. Switch it off. */
