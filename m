Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbTCGMm7>; Fri, 7 Mar 2003 07:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261569AbTCGMlp>; Fri, 7 Mar 2003 07:41:45 -0500
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:31953 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261559AbTCGMlF> convert rfc822-to-8bit; Fri, 7 Mar 2003 07:41:05 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (7/7): root device waiting.
Date: Fri, 7 Mar 2003 13:42:15 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303071342.15966.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add code to wait for dasd devices given with dasd= parameter. Without it the
system won't boot with the message "unable to mount root" if the root device
is on a slow device.

diffstat:
 block/dasd.c      |   40 ++++++++++++++++++++++++++------
 block/dasd_eckd.c |   21 +++++++++++++++-
 block/dasd_fba.c  |   11 +++++++-
 block/dasd_int.h  |    3 +-
 cio/chsc.c        |   19 +++++++--------
 cio/css.c         |    6 ++--
 cio/device.c      |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 cio/device.h      |    4 ++-
 cio/device_fsm.c  |   10 --------
 9 files changed, 143 insertions(+), 38 deletions(-)

diff -urN linux-2.5.64/drivers/s390/block/dasd.c linux-2.5.64-s390/drivers/s390/block/dasd.c
--- linux-2.5.64/drivers/s390/block/dasd.c	Fri Mar  7 11:40:40 2003
+++ linux-2.5.64-s390/drivers/s390/block/dasd.c	Fri Mar  7 11:41:04 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.79 $
+ * $Revision: 1.81 $
  *
  * History of changes (starts July 2000)
  * 11/09/00 complete redesign after code review
@@ -1826,12 +1826,6 @@
 
 	cdev->handler = &dasd_int_handler;
 
-	if (dasd_autodetect ||
-	    dasd_devmap_from_devno(devno) != 0) {
-		/* => device was in dasd parameter line */
-		ccw_device_set_online(cdev);
-	}
-
 	return ret;
 }
 
@@ -1949,6 +1943,38 @@
 }
 
 /*
+ * Automatically online either all dasd devices (dasd_autodetect) or
+ * all devices specified with dasd= parameters. For dasd_autodetect
+ * dasd_generic_probe has added devmaps for all dasd devices. We
+ * scan all present dasd devmaps and call ccw_device_set_online.
+ */
+void
+dasd_generic_auto_online (struct ccw_driver *dasd_discipline_driver)
+{
+	struct device_driver *drv;
+	struct device *d, *dev;
+	struct ccw_device *cdev;
+	int devno;
+
+	drv = get_driver(&dasd_discipline_driver->driver);
+	down_read(&drv->bus->subsys.rwsem);
+	dev = NULL;
+	list_for_each_entry(d, &drv->devices, driver_list) {
+		dev = get_device(d);
+		if (!dev)
+			continue;
+		cdev = to_ccwdev(dev);
+		devno = _ccw_device_get_device_number(cdev);
+		if (dasd_autodetect ||
+		    dasd_devmap_from_devno(devno) != 0)
+			ccw_device_set_online(cdev);
+		put_device(dev);
+	}
+	up_read(&drv->bus->subsys.rwsem);
+	put_driver(drv);
+}
+
+/*
  * SECTION: files in sysfs
  */
 
diff -urN linux-2.5.64/drivers/s390/block/dasd_eckd.c linux-2.5.64-s390/drivers/s390/block/dasd_eckd.c
--- linux-2.5.64/drivers/s390/block/dasd_eckd.c	Wed Mar  5 04:28:53 2003
+++ linux-2.5.64-s390/drivers/s390/block/dasd_eckd.c	Fri Mar  7 11:41:04 2003
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.36 $
+ * $Revision: 1.38 $
  *
  * History of changes (starts July 2000)
  * 07/11/00 Enabled rotational position sensing
@@ -1453,6 +1453,8 @@
 static int __init
 dasd_eckd_init(void)
 {
+	int ret;
+
 	dasd_ioctl_no_register(THIS_MODULE, BIODASDSATTR,
 			       dasd_eckd_set_attrib);
 	dasd_ioctl_no_register(THIS_MODULE, BIODASDPSRD,
@@ -1466,7 +1468,22 @@
 
 	ASCEBC(dasd_eckd_discipline.ebcname, 4);
 
-	ccw_driver_register(&dasd_eckd_driver);
+	ret = ccw_driver_register(&dasd_eckd_driver);
+	if (ret) {
+		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDSATTR,
+					 dasd_eckd_set_attrib);
+		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDPSRD,
+					 dasd_eckd_performance);
+		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDRLSE,
+					 dasd_eckd_release);
+		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDRSRV,
+					 dasd_eckd_reserve);
+		dasd_ioctl_no_unregister(THIS_MODULE, BIODASDSLCK,
+					 dasd_eckd_steal_lock);
+		return ret;
+	}
+
+	dasd_generic_auto_online(&dasd_eckd_driver);
 	return 0;
 }
 
diff -urN linux-2.5.64/drivers/s390/block/dasd_fba.c linux-2.5.64-s390/drivers/s390/block/dasd_fba.c
--- linux-2.5.64/drivers/s390/block/dasd_fba.c	Wed Mar  5 04:29:30 2003
+++ linux-2.5.64-s390/drivers/s390/block/dasd_fba.c	Fri Mar  7 11:41:04 2003
@@ -4,7 +4,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.25 $
+ * $Revision: 1.27 $
  *
  * History of changes
  *	    fixed partition handling and HDIO_GETGEO
@@ -414,9 +414,16 @@
 static int __init
 dasd_fba_init(void)
 {
+	int ret;
+
 	ASCEBC(dasd_fba_discipline.ebcname, 4);
 
-	return ccw_driver_register(&dasd_fba_driver);
+	ret = ccw_driver_register(&dasd_fba_driver);
+	if (ret)
+		return ret;
+
+	dasd_generic_auto_online(&dasd_fba_driver);
+	return 0;
 }
 
 static void __exit
diff -urN linux-2.5.64/drivers/s390/block/dasd_int.h linux-2.5.64-s390/drivers/s390/block/dasd_int.h
--- linux-2.5.64/drivers/s390/block/dasd_int.h	Wed Mar  5 04:29:31 2003
+++ linux-2.5.64-s390/drivers/s390/block/dasd_int.h	Fri Mar  7 11:41:04 2003
@@ -6,7 +6,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.36 $
+ * $Revision: 1.37 $
  *
  * History of changes (starts July 2000)
  * 02/01/01 added dynamic registration of ioctls
@@ -467,6 +467,7 @@
 int dasd_generic_set_online(struct ccw_device *cdev, 
 			    dasd_discipline_t *discipline);
 int dasd_generic_set_offline (struct ccw_device *cdev);
+void dasd_generic_auto_online (struct ccw_driver *);
 
 /* externals in dasd_devmap.c */
 extern int dasd_max_devindex;
diff -urN linux-2.5.64/drivers/s390/cio/chsc.c linux-2.5.64-s390/drivers/s390/cio/chsc.c
--- linux-2.5.64/drivers/s390/cio/chsc.c	Wed Mar  5 04:29:21 2003
+++ linux-2.5.64-s390/drivers/s390/cio/chsc.c	Fri Mar  7 11:41:04 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.57 $
+ *   $Revision: 1.60 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -82,20 +82,19 @@
 	 * allocation or prove that this function does not have to be
 	 * reentrant! */
 	static struct ssd_area chsc_area_ssd 
-		__attribute__ ((aligned(PAGE_SIZE)));
-
-	typeof (chsc_area_ssd.response_block)
-		*ssd_res = &chsc_area_ssd.response_block;
-
-	chsc_area_ssd = (struct ssd_area) {
+		__attribute__ ((aligned(PAGE_SIZE))) = {
 		.request_block = {
 			.command_code1 = 0x0010,
 			.command_code2 = 0x0004,
-			.f_sch = irq,
-			.l_sch = irq,
 		}
 	};
 
+	typeof (chsc_area_ssd.response_block)
+		*ssd_res = &chsc_area_ssd.response_block;
+	
+	chsc_area_ssd.request_block.f_sch = irq;
+	chsc_area_ssd.request_block.l_sch = irq,
+
 	ccode = chsc(&chsc_area_ssd);
 	if (ccode > 0) {
 		pr_debug("chsc returned with ccode = %d\n", ccode);
@@ -539,7 +538,7 @@
 {
 	static DECLARE_WORK(work, do_process_crw, 0);
 
-	schedule_work(&work);
+	queue_work(ccw_device_work, &work);
 }
 
 static void
diff -urN linux-2.5.64/drivers/s390/cio/css.c linux-2.5.64-s390/drivers/s390/cio/css.c
--- linux-2.5.64/drivers/s390/cio/css.c	Fri Mar  7 11:40:56 2003
+++ linux-2.5.64-s390/drivers/s390/cio/css.c	Fri Mar  7 11:41:04 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/css.c
  *  driver for channel subsystem
- *   $Revision: 1.41 $
+ *   $Revision: 1.43 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -161,7 +161,7 @@
 
 	sch = ioinfo[irq];
 	if (sch == NULL) {
-		schedule_work(&work);
+		queue_work(ccw_device_work, &work);
 		return;
 	}
 	if (!sch->dev.driver_data)
@@ -172,7 +172,7 @@
 	ccode = stsch(irq, &sch->schib);
 	if (!ccode)
 		if (devno != sch->schib.pmcw.dev)
-			schedule_work(&work);
+			queue_work(ccw_device_work, &work);
 }
 
 /*
diff -urN linux-2.5.64/drivers/s390/cio/device.c linux-2.5.64-s390/drivers/s390/cio/device.c
--- linux-2.5.64/drivers/s390/cio/device.c	Fri Mar  7 11:40:56 2003
+++ linux-2.5.64-s390/drivers/s390/cio/device.c	Fri Mar  7 11:41:04 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.51 $
+ *   $Revision: 1.53 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/device.h>
+#include <linux/workqueue.h>
 
 #include <asm/ccwdev.h>
 #include <asm/cio.h>
@@ -126,14 +127,32 @@
 	.irq = io_subchannel_irq,
 };
 
+struct workqueue_struct *ccw_device_work;
+static wait_queue_head_t ccw_device_init_wq;
+static atomic_t ccw_device_init_count;
+
 static int __init
 init_ccw_bus_type (void)
 {
 	int ret;
+
+	init_waitqueue_head(&ccw_device_init_wq);
+	atomic_set(&ccw_device_init_count, 0);
+
+	ccw_device_work = create_workqueue("cio");
+	if (!ccw_device_work)
+		return -ENOMEM; /* FIXME: better errno ? */
+
 	if ((ret = bus_register (&ccw_bus_type)))
 		return ret;
 
-	return driver_register(&io_subchannel_driver.drv);
+	if ((ret = driver_register(&io_subchannel_driver.drv)))
+		return ret;
+
+	wait_event(ccw_device_init_wq,
+		   atomic_read(&ccw_device_init_count) == 0);
+	flush_workqueue(ccw_device_work);
+	return 0;
 }
 
 static void __exit
@@ -141,6 +160,7 @@
 {
 	driver_unregister(&io_subchannel_driver.drv);
 	bus_unregister(&ccw_bus_type);
+	destroy_workqueue(ccw_device_work);
 }
 
 subsys_initcall(init_ccw_bus_type);
@@ -360,7 +380,7 @@
 /*
  * Register recognized device.
  */
-void
+static void
 io_subchannel_register(void *data)
 {
 	struct ccw_device *cdev;
@@ -389,6 +409,42 @@
 	put_device(&sch->dev);
 }
 
+/*
+ * subchannel recognition done. Called from the state machine.
+ */
+void
+io_subchannel_recog_done(struct ccw_device *cdev)
+{
+	struct subchannel *sch;
+
+	if (css_init_done == 0)
+		return;
+	switch (cdev->private->state) {
+	case DEV_STATE_NOT_OPER:
+		/* Remove device found not operational. */
+		sch = to_subchannel(cdev->dev.parent);
+		sch->dev.driver_data = 0;
+		put_device(&sch->dev);
+		if (cdev->dev.release)
+			cdev->dev.release(&cdev->dev);
+		break;
+	case DEV_STATE_OFFLINE:
+		/* 
+		 * We can't register the device in interrupt context so
+		 * we schedule a work item.
+		 */
+		INIT_WORK(&cdev->private->kick_work,
+			  io_subchannel_register, (void *) cdev);
+		queue_work(ccw_device_work, &cdev->private->kick_work);
+		break;
+	case DEV_STATE_BOXED:
+		/* Device did not respond in time. */
+		break;
+	}
+	if (atomic_dec_and_test(&ccw_device_init_count))
+		wake_up(&ccw_device_init_wq);
+}
+
 static void
 io_subchannel_recog(struct ccw_device *cdev, struct subchannel *sch)
 {
@@ -419,6 +475,9 @@
 	/* Do first half of device_register. */
 	device_initialize(&cdev->dev);
 
+	/* Increase counter of devices currently in recognition. */
+	atomic_inc(&ccw_device_init_count);
+
 	/* Start async. device sensing. */
 	spin_lock_irq(cdev->ccwlock);
 	rc = ccw_device_recognition(cdev);
@@ -428,6 +487,8 @@
 		put_device(&sch->dev);
 		if (cdev->dev.release)
 			cdev->dev.release(&cdev->dev);
+		if (atomic_dec_and_test(&ccw_device_init_count))
+			wake_up(&ccw_device_init_wq);
 	}
 }
 
diff -urN linux-2.5.64/drivers/s390/cio/device.h linux-2.5.64-s390/drivers/s390/cio/device.h
--- linux-2.5.64/drivers/s390/cio/device.h	Wed Mar  5 04:29:33 2003
+++ linux-2.5.64-s390/drivers/s390/cio/device.h	Fri Mar  7 11:41:04 2003
@@ -63,7 +63,9 @@
 		cdev->private->state == DEV_STATE_BOXED);
 }
 
-void io_subchannel_register(void *data);
+extern struct workqueue_struct *ccw_device_work;
+
+void io_subchannel_recog_done(struct ccw_device *cdev);
 
 int ccw_device_recognition(struct ccw_device *);
 int ccw_device_online(struct ccw_device *);
diff -urN linux-2.5.64/drivers/s390/cio/device_fsm.c linux-2.5.64-s390/drivers/s390/cio/device_fsm.c
--- linux-2.5.64/drivers/s390/cio/device_fsm.c	Wed Mar  5 04:29:19 2003
+++ linux-2.5.64-s390/drivers/s390/cio/device_fsm.c	Fri Mar  7 11:41:04 2003
@@ -112,10 +112,6 @@
 		CIO_DEBUG(KERN_WARNING, 2,
 			  "SenseID : unknown device %04X on subchannel %04X\n",
 			  sch->schib.pmcw.dev, sch->irq);
-		sch->dev.driver_data = 0;
-		put_device(&sch->dev);
-		if (cdev->dev.release)
-			cdev->dev.release(&cdev->dev);
 		break;
 	case DEV_STATE_OFFLINE:
 		/* fill out sense information */
@@ -131,11 +127,6 @@
 			  "%04X/%02X\n", sch->schib.pmcw.dev,
 			  cdev->id.cu_type, cdev->id.cu_model,
 			  cdev->id.dev_type, cdev->id.dev_model);
-		if (css_init_done == 0)
-			break;
-		INIT_WORK(&cdev->private->kick_work,
-			  io_subchannel_register, (void *) cdev);
-		schedule_work(&cdev->private->kick_work);
 		break;
 	case DEV_STATE_BOXED:
 		CIO_DEBUG(KERN_WARNING, 2,
@@ -143,6 +134,7 @@
 			  sch->schib.pmcw.dev, sch->irq);
 		break;
 	}
+	io_subchannel_recog_done(cdev);
 	wake_up(&cdev->private->wait_q);
 }
 

