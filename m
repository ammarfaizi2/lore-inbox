Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUDHO3R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 10:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUDHO3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 10:29:17 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:24809 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261851AbUDHO2N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 10:28:13 -0400
Date: Thu, 8 Apr 2004 16:28:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (2/12): common i/o layer.
Message-ID: <20040408142801.GC1793@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Common i/o layer changes:
 - Avoid de-registering a ccwgroup device multiple times.
 - Remove check for channel path objects in get_subchannel_by_schid.
   Channel patch objects are never in the bus list.
 - Avoid NULL pointer deref. in qdio_unmark_q.
 - Fix reference counting on subchannel objects.
 - Add shutdown function to terminate i/o and disable subchannels at reipl.
 - Remove all ccwgroup devices if the ccwgroup driver is unregistered.

diffstat:
 drivers/s390/cio/ccwgroup.c   |   35 ++++++++++++++++--
 drivers/s390/cio/chsc.c       |    6 ++-
 drivers/s390/cio/css.c        |   17 ++++----
 drivers/s390/cio/device.c     |   35 +++++++++++++++++-
 drivers/s390/cio/device.h     |    3 +
 drivers/s390/cio/device_fsm.c |   80 ++++++++++++++++++++++++++++++++++--------
 drivers/s390/cio/qdio.c       |    8 +++-
 7 files changed, 154 insertions(+), 30 deletions(-)

diff -urN linux-2.6/drivers/s390/cio/ccwgroup.c linux-2.6-s390/drivers/s390/cio/ccwgroup.c
--- linux-2.6/drivers/s390/cio/ccwgroup.c	Sun Apr  4 05:37:23 2004
+++ linux-2.6-s390/drivers/s390/cio/ccwgroup.c	Thu Apr  8 15:21:24 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/ccwgroup.c
  *  bus driver for ccwgroup
- *   $Revision: 1.25 $
+ *   $Revision: 1.27 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *                       IBM Corporation
@@ -397,9 +397,35 @@
 	return driver_register(&cdriver->driver);
 }
 
+static inline struct device *
+__get_next_ccwgroup_device(struct device_driver *drv)
+{
+	struct device *dev, *d;
+
+	down_read(&drv->bus->subsys.rwsem);
+	dev = NULL;
+	list_for_each_entry(d, &drv->devices, driver_list) {
+		dev = get_device(d);
+		if (dev)
+			break;
+	}
+	up_read(&drv->bus->subsys.rwsem);
+	return dev;
+}
+
 void
 ccwgroup_driver_unregister (struct ccwgroup_driver *cdriver)
 {
+	struct device *dev;
+
+	/* We don't want ccwgroup devices to live longer than their driver. */
+	get_driver(&cdriver->driver);
+	while ((dev = __get_next_ccwgroup_device(&cdriver->driver))) {
+		__ccwgroup_remove_symlinks(to_ccwgroupdev(dev));
+		device_unregister(dev);
+		put_device(dev);
+	};
+	put_driver(&cdriver->driver);
 	driver_unregister(&cdriver->driver);
 }
 
@@ -416,8 +442,11 @@
 
 	if (cdev->dev.driver_data) {
 		gdev = (struct ccwgroup_device *)cdev->dev.driver_data;
-		if (get_device(&gdev->dev))
-			return gdev;
+		if (get_device(&gdev->dev)) {
+			if (!list_empty(&gdev->dev.node))
+				return gdev;
+			put_device(&gdev->dev);
+		}
 		return NULL;
 	}
 	return NULL;
diff -urN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-s390/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	Sun Apr  4 05:37:23 2004
+++ linux-2.6-s390/drivers/s390/cio/chsc.c	Thu Apr  8 15:21:24 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.105 $
+ *   $Revision: 1.107 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -819,8 +819,10 @@
 		struct schib schib;
 
 		sch = get_subchannel_by_schid(irq);
-		if (sch)
+		if (sch) {
+			put_device(&sch->dev);
 			continue;
+		}
 		if (stsch(irq, &schib))
 			/* We're through */
 			break;
diff -urN linux-2.6/drivers/s390/cio/css.c linux-2.6-s390/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	Sun Apr  4 05:36:24 2004
+++ linux-2.6-s390/drivers/s390/cio/css.c	Thu Apr  8 15:21:24 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/css.c
  *  driver for channel subsystem
- *   $Revision: 1.69 $
+ *   $Revision: 1.72 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -163,11 +163,6 @@
 					      struct device, bus_list));
 		if (!dev)
 			continue;
-		/* Skip channel paths. */
-		if (dev->release != &css_subchannel_release) {
-			put_device(dev);
-			continue;
-		}
 		sch = to_subchannel(dev);
 		if (sch->irq == irq)
 			break;
@@ -206,10 +201,16 @@
 
 	sch = get_subchannel_by_schid(irq);
 	disc = sch ? device_is_disconnected(sch) : 0;
-	if (disc && slow)
+	if (disc && slow) {
+		if (sch)
+			put_device(&sch->dev);
 		return 0; /* Already processed. */
-	if (!disc && !slow)
+	}
+	if (!disc && !slow) {
+		if (sch)
+			put_device(&sch->dev);
 		return -EAGAIN; /* Will be done on the slow path. */
+	}
 	event = css_get_subchannel_status(sch, irq);
 	switch (event) {
 	case CIO_GONE:
diff -urN linux-2.6/drivers/s390/cio/device.c linux-2.6-s390/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	Sun Apr  4 05:37:38 2004
+++ linux-2.6-s390/drivers/s390/cio/device.c	Thu Apr  8 15:21:24 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.110 $
+ *   $Revision: 1.113 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -120,6 +120,7 @@
 static int io_subchannel_notify(struct device *, int);
 static void io_subchannel_verify(struct device *);
 static void io_subchannel_ioterm(struct device *);
+static void io_subchannel_shutdown(struct device *);
 
 struct css_driver io_subchannel_driver = {
 	.subchannel_type = SUBCHANNEL_TYPE_IO,
@@ -128,6 +129,7 @@
 		.bus  = &css_bus_type,
 		.probe = &io_subchannel_probe,
 		.remove = &io_subchannel_remove,
+		.shutdown = &io_subchannel_shutdown,
 	},
 	.irq = io_subchannel_irq,
 	.notify = io_subchannel_notify,
@@ -766,6 +768,37 @@
 			      ERR_PTR(-EIO));
 }
 
+static void
+io_subchannel_shutdown(struct device *dev)
+{
+	struct subchannel *sch;
+	struct ccw_device *cdev;
+	int ret;
+
+	sch = to_subchannel(dev);
+	cdev = dev->driver_data;
+
+	if (cio_is_console(sch->irq))
+		return;
+	if (!sch->schib.pmcw.ena)
+		/* Nothing to do. */
+		return;
+	ret = cio_disable_subchannel(sch);
+	if (ret != -EBUSY)
+		/* Subchannel is disabled, we're done. */
+		return;
+	cdev->private->state = DEV_STATE_QUIESCE;
+	if (cdev->handler)
+		cdev->handler(cdev, cdev->private->intparm,
+			      ERR_PTR(-EIO));
+	ret = ccw_device_cancel_halt_clear(cdev);
+	if (ret == -EBUSY) {
+		ccw_device_set_timeout(cdev, HZ/10);
+		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
+	}
+	cio_disable_subchannel(sch);
+}
+
 #ifdef CONFIG_CCW_CONSOLE
 static struct ccw_device console_cdev;
 static struct ccw_device_private console_private;
diff -urN linux-2.6/drivers/s390/cio/device.h linux-2.6-s390/drivers/s390/cio/device.h
--- linux-2.6/drivers/s390/cio/device.h	Sun Apr  4 05:37:42 2004
+++ linux-2.6-s390/drivers/s390/cio/device.h	Thu Apr  8 15:21:24 2004
@@ -18,6 +18,7 @@
 	DEV_STATE_CLEAR_VERIFY,
 	DEV_STATE_TIMEOUT_KILL,
 	DEV_STATE_WAIT4IO,
+	DEV_STATE_QUIESCE,
 	/* special states for devices gone not operational */
 	DEV_STATE_DISCONNECTED,
 	DEV_STATE_DISCONNECTED_SENSE_ID,
@@ -68,6 +69,8 @@
 
 void io_subchannel_recog_done(struct ccw_device *cdev);
 
+int ccw_device_cancel_halt_clear(struct ccw_device *);
+
 int ccw_device_register(struct ccw_device *);
 void ccw_device_do_unreg_rereg(void *);
 
diff -urN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-s390/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	Sun Apr  4 05:37:07 2004
+++ linux-2.6-s390/drivers/s390/cio/device_fsm.c	Thu Apr  8 15:21:24 2004
@@ -101,7 +101,7 @@
  * -EBUSY if an interrupt is expected (either from halt/clear or from a
  * status pending).
  */
-static int
+int
 ccw_device_cancel_halt_clear(struct ccw_device *cdev)
 {
 	struct subchannel *sch;
@@ -438,10 +438,13 @@
 	ret = (sch->driver && sch->driver->notify) ?
 		sch->driver->notify(&sch->dev, CIO_NO_PATH) : 0;
 	if (!ret) {
-		/* Driver doesn't want to keep device. */
-		device_unregister(&sch->dev);
-		sch->schib.pmcw.intparm = 0;
-		cio_modify(sch);
+		if (get_device(&sch->dev)) {
+			/* Driver doesn't want to keep device. */
+			device_unregister(&sch->dev);
+			sch->schib.pmcw.intparm = 0;
+			cio_modify(sch);
+			put_device(&sch->dev);
+		}
 	} else {
 		ccw_device_set_timeout(cdev, 0);
 		cdev->private->state = DEV_STATE_DISCONNECTED;
@@ -710,9 +713,17 @@
 		cdev->private->state = DEV_STATE_TIMEOUT_KILL;
 		return;
 	}
-	if (ret == -ENODEV)
-		dev_fsm_event(cdev, DEV_EVENT_NOTOPER);
-	else if (cdev->handler)
+	if (ret == -ENODEV) {
+		struct subchannel *sch;
+
+		sch = to_subchannel(cdev->dev.parent);
+		if (!sch->lpm) {
+			PREPARE_WORK(&cdev->private->kick_work,
+				     ccw_device_nopath_notify, (void *)cdev);
+			queue_work(ccw_device_work, &cdev->private->kick_work);
+		} else
+			dev_fsm_event(cdev, DEV_EVENT_NOTOPER);
+	} else if (cdev->handler)
 		cdev->handler(cdev, cdev->private->intparm,
 			      ERR_PTR(-ETIMEDOUT));
 }
@@ -808,8 +819,8 @@
 			PREPARE_WORK(&cdev->private->kick_work,
 				     ccw_device_nopath_notify, (void *)cdev);
 			queue_work(ccw_device_work, &cdev->private->kick_work);
-		}
-		dev_fsm_event(cdev, DEV_EVENT_NOTOPER);
+		} else
+			dev_fsm_event(cdev, DEV_EVENT_NOTOPER);
 		return;
 	}
 	//FIXME: Can we get here?
@@ -868,6 +879,7 @@
 	int ret;
 	struct subchannel *sch;
 
+	sch = to_subchannel(cdev->dev.parent);
 	ccw_device_set_timeout(cdev, 0);
 	ret = ccw_device_cancel_halt_clear(cdev);
 	if (ret == -EBUSY) {
@@ -876,16 +888,17 @@
 		return;
 	}
 	if (ret == -ENODEV) {
-		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_nopath_notify, (void *)cdev);
-		queue_work(ccw_device_work, &cdev->private->kick_work);
-		dev_fsm_event(cdev, DEV_EVENT_NOTOPER);
+		if (!sch->lpm) {
+			PREPARE_WORK(&cdev->private->kick_work,
+				     ccw_device_nopath_notify, (void *)cdev);
+			queue_work(ccw_device_work, &cdev->private->kick_work);
+		} else
+			dev_fsm_event(cdev, DEV_EVENT_NOTOPER);
 		return;
 	}
 	if (cdev->handler)
 		cdev->handler(cdev, cdev->private->intparm,
 			      ERR_PTR(-ETIMEDOUT));
-	sch = to_subchannel(cdev->dev.parent);
 	if (!sch->lpm) {
 		PREPARE_WORK(&cdev->private->kick_work,
 			     ccw_device_nopath_notify, (void *)cdev);
@@ -1005,6 +1018,37 @@
 }
 
 
+static void
+ccw_device_quiesce_done(struct ccw_device *cdev, enum dev_event dev_event)
+{
+	ccw_device_set_timeout(cdev, 0);
+	if (dev_event == DEV_EVENT_NOTOPER)
+		cdev->private->state = DEV_STATE_NOT_OPER;
+	else
+		cdev->private->state = DEV_STATE_OFFLINE;
+	wake_up(&cdev->private->wait_q);
+}
+
+static void
+ccw_device_quiesce_timeout(struct ccw_device *cdev, enum dev_event dev_event)
+{
+	int ret;
+
+	ret = ccw_device_cancel_halt_clear(cdev);
+	switch (ret) {
+	case 0:
+		cdev->private->state = DEV_STATE_OFFLINE;
+		wake_up(&cdev->private->wait_q);
+		break;
+	case -ENODEV:
+		cdev->private->state = DEV_STATE_NOT_OPER;
+		wake_up(&cdev->private->wait_q);
+		break;
+	default:
+		ccw_device_set_timeout(cdev, HZ/10);
+	}
+}
+
 /*
  * No operation action. This is used e.g. to ignore a timeout event in
  * state offline.
@@ -1102,6 +1146,12 @@
 		[DEV_EVENT_TIMEOUT]	ccw_device_wait4io_timeout,
 		[DEV_EVENT_VERIFY]	ccw_device_wait4io_verify,
 	},
+	[DEV_STATE_QUIESCE] {
+		[DEV_EVENT_NOTOPER]	ccw_device_quiesce_done,
+		[DEV_EVENT_INTERRUPT]	ccw_device_quiesce_done,
+		[DEV_EVENT_TIMEOUT]	ccw_device_quiesce_timeout,
+		[DEV_EVENT_VERIFY]	ccw_device_nop,
+	},
 	/* special states for devices gone not operational */
 	[DEV_STATE_DISCONNECTED] {
 		[DEV_EVENT_NOTOPER]	ccw_device_nop,
diff -urN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-s390/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	Sun Apr  4 05:37:24 2004
+++ linux-2.6-s390/drivers/s390/cio/qdio.c	Thu Apr  8 15:21:24 2004
@@ -56,7 +56,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.78 $"
+#define VERSION_QDIO_C "$Revision: 1.79 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -392,6 +392,11 @@
 	if ((q->is_thinint_q)&&(q->is_input_q)) {
 		/* iQDIO */
 		spin_lock_irqsave(&ttiq_list_lock,flags);
+		/* in case cleanup has done this already and simultanously
+		 * qdio_unmark_q is called from the interrupt handler, we've
+		 * got to check this in this specific case again */
+		if ((!q->list_prev)||(!q->list_next))
+			goto out;
 		if (q->list_next==q) {
 			/* q was the only interesting q */
 			tiq_list=NULL;
@@ -404,6 +409,7 @@
 			q->list_next=NULL;
 			q->list_prev=NULL;
 		}
+out:
 		spin_unlock_irqrestore(&ttiq_list_lock,flags);
 	}
 }
