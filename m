Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTIYRTm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbTIYRTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:19:41 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:22238 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261180AbTIYRQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:16:26 -0400
Date: Thu, 25 Sep 2003 19:15:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (2/19): common i/o layer.
Message-ID: <20030925171542.GC2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Remove initialization of device.name.
 - Don't do put_device after failed get_device in get_ccwdev_by_busid.
 - Fix read_dev_chars and read_conf_data.
 - Call interrupt function of ccw device if path verification has been started.
 - Replace atomic_return_add by atomic_add_return in qdio.
 - Use wait_event instead of homegrown wait loop.
 - Fix reestablish queue problem.
 - Add ungroup attribute to ccw_group devices and add links from each
   ccw device of a group to the group device.
 - Use BUS_ID_SIZE instead of DEVICE_ID_SIZE.
 - Delay path verification if a basic sense is required.
 - Move qdio shutdown code from qdio_free to qdio_shutdown.

diffstat:
 drivers/s390/cio/ccwgroup.c      |  157 ++++++++++++++++-
 drivers/s390/cio/chsc.c          |    6 
 drivers/s390/cio/cio.c           |   18 -
 drivers/s390/cio/css.c           |   17 -
 drivers/s390/cio/css.h           |    1 
 drivers/s390/cio/device.c        |   14 -
 drivers/s390/cio/device.h        |    4 
 drivers/s390/cio/device_fsm.c    |  105 ++---------
 drivers/s390/cio/device_id.c     |    1 
 drivers/s390/cio/device_ops.c    |  214 ++++++++++++++---------
 drivers/s390/cio/device_status.c |   31 ++-
 drivers/s390/cio/qdio.c          |  360 +++++++++++++++++++--------------------
 drivers/s390/cio/qdio.h          |   22 +-
 drivers/s390/net/cu3088.c        |    7 
 include/asm-s390/qdio.h          |    5 
 15 files changed, 540 insertions(+), 422 deletions(-)

diff -urN linux-2.6/drivers/s390/cio/ccwgroup.c linux-2.6-s390/drivers/s390/cio/ccwgroup.c
--- linux-2.6/drivers/s390/cio/ccwgroup.c	Mon Sep  8 21:50:07 2003
+++ linux-2.6-s390/drivers/s390/cio/ccwgroup.c	Thu Sep 25 18:33:22 2003
@@ -1,11 +1,12 @@
 /*
  *  drivers/s390/cio/ccwgroup.c
  *  bus driver for ccwgroup
- *   $Revision: 1.7 $
+ *   $Revision: 1.15 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *                       IBM Corporation
  *    Author(s): Arnd Bergmann (arndb@de.ibm.com)
+ *               Cornelia Huck (cohuck@de.ibm.com)
  */
 #include <linux/module.h>
 #include <linux/errno.h>
@@ -14,6 +15,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/ctype.h>
+#include <linux/dcache.h>
 
 #include <asm/semaphore.h>
 #include <asm/ccwdev.h>
@@ -56,6 +58,45 @@
 	.hotplug = ccwgroup_hotplug,
 };
 
+static inline void
+__ccwgroup_remove_symlinks(struct ccwgroup_device *gdev)
+{
+	int i;
+	char str[8];
+
+	for (i = 0; i < gdev->count; i++) {
+		sprintf(str, "cdev%d", i);
+		sysfs_remove_link(&gdev->dev.kobj, str);
+		/* Hack: Make sure we act on still valid subdirs. */
+		if (atomic_read(&gdev->cdev[i]->dev.kobj.dentry->d_count))
+			sysfs_remove_link(&gdev->cdev[i]->dev.kobj,
+					  "group_device");
+	}
+	
+}
+
+/*
+ * Provide an 'ungroup' attribute so the user can remove group devices no
+ * longer needed or accidentially created. Saves memory :)
+ */
+static ssize_t
+ccwgroup_ungroup_store(struct device *dev, const char *buf, size_t count)
+{
+	struct ccwgroup_device *gdev;
+
+	gdev = to_ccwgroupdev(dev);
+
+	if (gdev->state != CCWGROUP_OFFLINE)
+		return -EINVAL;
+
+	__ccwgroup_remove_symlinks(gdev);
+	device_unregister(dev);
+
+	return count;
+}
+
+static DEVICE_ATTR(ungroup, 0200, NULL, ccwgroup_ungroup_store);
+
 static void
 ccwgroup_release (struct device *dev)
 {
@@ -69,6 +110,40 @@
 	kfree(gdev);
 }
 
+static inline int
+__ccwgroup_create_symlinks(struct ccwgroup_device *gdev)
+{
+	char str[8];
+	int i, rc;
+
+	for (i = 0; i < gdev->count; i++) {
+		rc = sysfs_create_link(&gdev->cdev[i]->dev.kobj, &gdev->dev.kobj,
+				       "group_device");
+		if (rc) {
+			for (--i; i >= 0; i--)
+				sysfs_remove_link(&gdev->cdev[i]->dev.kobj,
+						  "group_device");
+			return rc;
+		}
+	}
+	for (i = 0; i < gdev->count; i++) {
+		sprintf(str, "cdev%d", i);
+		rc = sysfs_create_link(&gdev->dev.kobj, &gdev->cdev[i]->dev.kobj,
+				       str);
+		if (rc) {
+			for (--i; i >= 0; i--) {
+				sprintf(str, "cdev%d", i);
+				sysfs_remove_link(&gdev->dev.kobj, str);
+			}
+			for (i = 0; i < gdev->count; i++)
+				sysfs_remove_link(&gdev->cdev[i]->dev.kobj,
+						  "group_device");
+			return rc;
+		}
+	}
+	return 0;
+}
+
 /*
  * try to add a new ccwgroup device for one driver
  * argc and argv[] are a list of bus_id's of devices
@@ -82,6 +157,7 @@
 {
 	struct ccwgroup_device *gdev;
 	int i;
+	int rc;
 
 	if (argc > 256) /* disallow dumb users */
 		return -EINVAL;
@@ -90,6 +166,8 @@
 	if (!gdev)
 		return -ENOMEM;
 
+	memset(gdev, 0, sizeof(*gdev) + argc*sizeof(gdev->cdev[0]));
+
 	for (i = 0; i < argc; i++) {
 		gdev->cdev[i] = get_ccwdev_by_busid(cdrv, argv[i]);
 
@@ -97,8 +175,10 @@
 		 * order to be grouped */
 		if (!gdev->cdev[i]
 		    || gdev->cdev[i]->id.driver_info !=
-		       gdev->cdev[0]->id.driver_info)
+		    gdev->cdev[0]->id.driver_info) {
+			rc = -EINVAL;
 			goto error;
+		}
 	}
 
 	*gdev = (struct ccwgroup_device) {
@@ -114,9 +194,24 @@
 	snprintf (gdev->dev.bus_id, BUS_ID_SIZE, "%s",
 			gdev->cdev[0]->dev.bus_id);
 
-	/* TODO: make symlinks for sysfs */
-	return device_register(&gdev->dev);
+	rc = device_register(&gdev->dev);
+	
+	if (rc)
+		goto error;
+
+	rc = device_create_file(&gdev->dev, &dev_attr_ungroup);
+
+	if (rc) {
+		device_unregister(&gdev->dev);
+		goto error;
+	}
+
+	rc = __ccwgroup_create_symlinks(gdev);
+	if (!rc)
+		return 0;
 
+	device_remove_file(&gdev->dev, &dev_attr_ungroup);
+	device_unregister(&gdev->dev);
 error:
 	for (i = 0; i < argc; i++)
 		if (gdev->cdev[i])
@@ -124,7 +219,7 @@
 
 	kfree(gdev);
 
-	return -EINVAL;
+	return rc;
 }
 
 static int __init
@@ -213,7 +308,7 @@
 
 	online = (to_ccwgroupdev(dev)->state == CCWGROUP_ONLINE);
 
-	return sprintf(buf, online ? "yes\n" : "no\n");
+	return sprintf(buf, online ? "1\n" : "0\n");
 }
 
 static DEVICE_ATTR(online, 0644, ccwgroup_online_show, ccwgroup_online_store);
@@ -286,9 +381,59 @@
 	return 0;
 }
 
+static inline struct ccwgroup_device *
+__ccwgroup_get_gdev_by_cdev(struct ccw_device *cdev)
+{
+	struct ccwgroup_device *gdev;
+	struct list_head *entry;
+	struct device *dev;
+	int i, found;
+
+	/*
+	 * Find groupdevice cdev belongs to.
+	 * Unfortunately, we can't use bus_for_each_dev() because of the
+	 * semaphore (and return value of fn() is int).
+	 */
+	if (!get_bus(&ccwgroup_bus_type))
+		return NULL;
+
+	gdev = NULL;
+	down_read(&ccwgroup_bus_type.subsys.rwsem);
+
+	list_for_each(entry, &ccwgroup_bus_type.devices.list) {
+		dev = get_device(container_of(entry, struct device, bus_list));
+		found = 0;
+		if (!dev)
+			continue;
+		gdev = to_ccwgroupdev(dev);
+		for (i = 0; i < gdev->count && (!found); i++) {
+			if (gdev->cdev[i] == cdev)
+				found = 1;
+		}
+		if (found)
+			break;
+		put_device(dev);
+		gdev = NULL;
+	}
+	up_read(&ccwgroup_bus_type.subsys.rwsem);
+	put_bus(&ccwgroup_bus_type);
+
+	return gdev;
+}
+
 int
 ccwgroup_remove_ccwdev(struct ccw_device *cdev)
 {
+	struct ccwgroup_device *gdev;
+
+	/* If one of its devices is gone, the whole group is done for. */
+	gdev = __ccwgroup_get_gdev_by_cdev(cdev);
+	if (gdev) {
+		ccwgroup_set_offline(gdev);
+		__ccwgroup_remove_symlinks(gdev);
+		device_unregister(&gdev->dev);
+		put_device(&gdev->dev);
+	}
 	return 0;
 }
 
diff -urN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-s390/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	Mon Sep  8 21:50:06 2003
+++ linux-2.6-s390/drivers/s390/cio/chsc.c	Thu Sep 25 18:33:22 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.74 $
+ *   $Revision: 1.77 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -865,9 +865,7 @@
 	chp->state = status;
 	chp->dev.parent = &css_bus_device;
 
-	snprintf(chp->dev.name, DEVICE_NAME_SIZE,
-		 "channel path %x", chpid);
-	snprintf(chp->dev.bus_id, DEVICE_ID_SIZE, "chp%x", chpid);
+	snprintf(chp->dev.bus_id, BUS_ID_SIZE, "chp0.%x", chpid);
 
 	/* make it known to the system */
 	ret = device_register(&chp->dev);
diff -urN linux-2.6/drivers/s390/cio/cio.c linux-2.6-s390/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	Mon Sep  8 21:50:40 2003
+++ linux-2.6-s390/drivers/s390/cio/cio.c	Thu Sep 25 18:33:22 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.100 $
+ *   $Revision: 1.105 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -277,11 +277,6 @@
 	if (!sch)
 		return -ENODEV;
 
-	/*
-	 * we ignore the halt_io() request if ending_status was received but
-	 *  a SENSE operation is waiting for completion.
-	 */
-
 	sprintf (dbf_txt, "haltIO%x", sch->irq);
 	CIO_TRACE_EVENT (2, dbf_txt);
 
@@ -316,10 +311,6 @@
 
 	if (!sch)
 		return -ENODEV;
-	/*
-	 * we ignore the clear_io() request if ending_status was received but
-	 *  a SENSE operation is waiting for completion.
-	 */
 
 	sprintf (dbf_txt, "clearIO%x", sch->irq);
 	CIO_TRACE_EVENT (2, dbf_txt);
@@ -380,7 +371,7 @@
 }
 
 /*
- * Function: cio_cancel
+ * Function: cio_modify
  * Issues a "Modify Subchannel" on the specified subchannel
  */
 static int
@@ -469,11 +460,6 @@
 	sprintf (dbf_txt, "dissch%x", sch->irq);
 	CIO_TRACE_EVENT (2, dbf_txt);
 
-	/*
-	 * If device isn't operational we have to perform delayed
-	 *  disabling when the next interrupt occurs - unless the
-	 *  irq is re-requested prior to the interrupt to occur.
-	 */
 	ccode = stsch (sch->irq, &sch->schib);
 	if (ccode == 3)		/* Not operational. */
 		return -ENODEV;
diff -urN linux-2.6/drivers/s390/cio/css.c linux-2.6-s390/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	Mon Sep  8 21:49:53 2003
+++ linux-2.6-s390/drivers/s390/cio/css.c	Thu Sep 25 18:33:22 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/css.c
  *  driver for channel subsystem
- *   $Revision: 1.43 $
+ *   $Revision: 1.49 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -27,7 +27,6 @@
 int css_init_done = 0;
 
 struct device css_bus_device = {
-	.name	= "Channel Subsystem 0",
 	.bus_id = "css0",
 };
 
@@ -79,17 +78,6 @@
 static int
 css_register_subchannel(struct subchannel *sch)
 {
-	static const char *subchannel_types[] = {
-		"I/O Subchannel",
-		"CHSC Subchannel",
-		"Message Subchannel",
-		"ADM Subchannel",
-		"undefined subchannel type 4",
-		"undefined subchannel type 5",
-		"undefined subchannel type 6",
-		"undefined subchannel type 7",
-		"undefined subchannel type 8",
-	};
 	int ret;
 
 	/* Initialize the subchannel structure */
@@ -97,8 +85,7 @@
 	sch->dev.bus = &css_bus_type;
 
 	/* Set a name for the subchannel */
-	strlcpy (sch->dev.name, subchannel_types[sch->st], DEVICE_NAME_SIZE);
-	snprintf (sch->dev.bus_id, DEVICE_ID_SIZE, "0:%04x", sch->irq);
+	snprintf (sch->dev.bus_id, BUS_ID_SIZE, "0.0.%04x", sch->irq);
 
 	/* make it known to the system */
 	ret = device_register(&sch->dev);
diff -urN linux-2.6/drivers/s390/cio/css.h linux-2.6-s390/drivers/s390/cio/css.h
--- linux-2.6/drivers/s390/cio/css.h	Mon Sep  8 21:51:01 2003
+++ linux-2.6-s390/drivers/s390/cio/css.h	Thu Sep 25 18:33:22 2003
@@ -78,6 +78,7 @@
 		unsigned int pgid_single:1; /* use single path for Set PGID */
 		unsigned int esid:1;        /* Ext. SenseID supported by HW */
 		unsigned int dosense:1;	    /* delayed SENSE required */
+		unsigned int doverify:1;    /* delayed path verification */
 	} __attribute__((packed)) flags;
 	unsigned long intparm;	/* user interruption parameter */
 	struct qdio_irq *qdio_data;
diff -urN linux-2.6/drivers/s390/cio/device.c linux-2.6-s390/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	Mon Sep  8 21:50:18 2003
+++ linux-2.6-s390/drivers/s390/cio/device.c	Thu Sep 25 18:33:22 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.60 $
+ *   $Revision: 1.70 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -229,7 +229,7 @@
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
 
-	return sprintf(buf, cdev->online ? "yes\n" : "no\n");
+	return sprintf(buf, cdev->online ? "1\n" : "0\n");
 }
 
 void
@@ -537,8 +537,7 @@
 	init_timer(&cdev->private->timer);
 
 	/* Set an initial name for the device. */
-	snprintf (cdev->dev.name, DEVICE_NAME_SIZE,"ccw device");
-	snprintf (cdev->dev.bus_id, DEVICE_ID_SIZE, "0:%04x",
+	snprintf (cdev->dev.bus_id, BUS_ID_SIZE, "0.0.%04x",
 		  sch->schib.pmcw.dev);
 
 	/* Increase counter of devices currently in recognition. */
@@ -679,6 +678,7 @@
 		console_cdev_in_use = 0;
 		return ERR_PTR(ret);
 	}
+	console_cdev.online = 1;
 	return &console_cdev;
 }
 #endif
@@ -702,10 +702,12 @@
 	list_for_each_entry(d, &drv->devices, driver_list) {
 		dev = get_device(d);
 
-		if (dev && !strncmp(bus_id, dev->bus_id, DEVICE_ID_SIZE))
+		if (dev && !strncmp(bus_id, dev->bus_id, BUS_ID_SIZE))
 			break;
-		else
+		else if (dev) {
 			put_device(dev);
+			dev = NULL;
+		}
 	}
 	up_read(&drv->bus->subsys.rwsem);
 	put_driver(drv);
diff -urN linux-2.6/drivers/s390/cio/device.h linux-2.6-s390/drivers/s390/cio/device.h
--- linux-2.6/drivers/s390/cio/device.h	Mon Sep  8 21:50:21 2003
+++ linux-2.6-s390/drivers/s390/cio/device.h	Thu Sep 25 18:33:22 2003
@@ -15,8 +15,6 @@
 	DEV_STATE_DISBAND_PGID,
 	DEV_STATE_BOXED,
 	/* states to wait for i/o completion before doing something */
-	DEV_STATE_ONLINE_VERIFY,
-	DEV_STATE_W4SENSE_VERIFY,
 	DEV_STATE_CLEAR_VERIFY,
 	DEV_STATE_TIMEOUT_KILL,
 	/* last element! */
@@ -95,7 +93,7 @@
 void ccw_device_disband_irq(struct ccw_device *, enum dev_event);
 void ccw_device_disband_done(struct ccw_device *, int);
 
-void ccw_device_call_handler(struct ccw_device *);
+int ccw_device_call_handler(struct ccw_device *);
 
 void ccw_device_add_stlck(void *);
 int ccw_device_stlck(struct ccw_device *);
diff -urN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-s390/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	Mon Sep  8 21:50:06 2003
+++ linux-2.6-s390/drivers/s390/cio/device_fsm.c	Thu Sep 25 18:33:22 2003
@@ -269,6 +269,7 @@
 void
 ccw_device_verify_done(struct ccw_device *cdev, int err)
 {
+	cdev->private->flags.doverify = 0;
 	switch (err) {
 	case 0:
 		ccw_device_done(cdev, DEV_STATE_ONLINE);
@@ -419,13 +420,21 @@
 {
 	struct subchannel *sch;
 
-	sch = to_subchannel(cdev->dev.parent);
+	if (!cdev->private->options.pgroup)
+		return;
 	if (cdev->private->state == DEV_STATE_W4SENSE) {
-		cdev->private->state = DEV_STATE_W4SENSE_VERIFY;
+		cdev->private->flags.doverify = 1;
 		return;
 	}
-	if (sch->schib.scsw.actl != 0) {
-		cdev->private->state = DEV_STATE_ONLINE_VERIFY;
+	sch = to_subchannel(cdev->dev.parent);
+	if (sch->schib.scsw.actl != 0 ||
+	    (cdev->private->irb.scsw.stctl & SCSW_STCTL_STATUS_PEND)) {
+		/*
+		 * No final status yet or final status not yet delivered
+		 * to the device driver. Can't do path verfication now,
+		 * delay until final status was delivered.
+		 */
+		cdev->private->flags.doverify = 1;
 		return;
 	}
 	/* Device is idle, we can do the path verification. */
@@ -453,19 +462,14 @@
 	ccw_device_accumulate_irb(cdev, irb);
 	if (cdev->private->flags.dosense) {
 		if (ccw_device_do_sense(cdev, irb) == 0) {
-			/* Check if we have to trigger path verification. */
-			if (irb->esw.esw0.erw.pvrf)
-				cdev->private->state = DEV_STATE_W4SENSE_VERIFY;
-			else
-				cdev->private->state = DEV_STATE_W4SENSE;
+			cdev->private->state = DEV_STATE_W4SENSE;
 		}
 		return;
 	}
-	if (irb->esw.esw0.erw.pvrf)
-		/* Try to start path verification. */
+	/* Call the handler. */
+	if (ccw_device_call_handler(cdev) && cdev->private->flags.doverify)
+		/* Start delayed path verification. */
 		ccw_device_online_verify(cdev, 0);
-	/* No basic sense required, call the handler. */
-	ccw_device_call_handler(cdev);
 }
 
 /*
@@ -485,32 +489,6 @@
 			      ERR_PTR(-ETIMEDOUT));
 }
 
-static void
-ccw_device_irq_verify(struct ccw_device *cdev, enum dev_event dev_event)
-{
-	struct irb *irb;
-
-	irb = (struct irb *) __LC_IRB;
-	/* Check for unsolicited interrupt. */
-	if (irb->scsw.stctl ==
-	    		(SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
-		if (cdev->handler)
-			cdev->handler (cdev, 0, irb);
-		return;
-	}
-	/* Accumulate status and find out if a basic sense is needed. */
-	ccw_device_accumulate_irb(cdev, irb);
-	if (cdev->private->flags.dosense) {
-		if (ccw_device_do_sense(cdev, irb) == 0)
-			cdev->private->state = DEV_STATE_W4SENSE_VERIFY;
-		return;
-	}
-	/* Try to start delayed device verification. */
-	ccw_device_online_verify(cdev, 0);
-	/* No basic sense required, call the handler. */
-	ccw_device_call_handler(cdev);
-}
-
 /*
  * Got an interrupt for a basic sense.
  */
@@ -530,46 +508,15 @@
 	/* Add basic sense info to irb. */
 	ccw_device_accumulate_basic_sense(cdev, irb);
 	if (cdev->private->flags.dosense) {
-		/* Check if we have to trigger path verification. */
-		if (irb->esw.esw0.erw.pvrf)
-			cdev->private->state = DEV_STATE_W4SENSE_VERIFY;
 		/* Another basic sense is needed. */
 		ccw_device_do_sense(cdev, irb);
 		return;
 	}
 	cdev->private->state = DEV_STATE_ONLINE;
-	if (irb->esw.esw0.erw.pvrf)
-		/* Try to start path verification. */
-		ccw_device_online_verify(cdev, 0);
 	/* Call the handler. */
-	ccw_device_call_handler(cdev);
-}
-
-static void
-ccw_device_w4sense_verify(struct ccw_device *cdev, enum dev_event dev_event)
-{
-	struct irb *irb;
-
-	irb = (struct irb *) __LC_IRB;
-	/* Check for unsolicited interrupt. */
-	if (irb->scsw.stctl ==
-	    		(SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
-		if (cdev->handler)
-			cdev->handler (cdev, 0, irb);
-		return;
-	}
-	/* Add basic sense info to irb. */
-	ccw_device_accumulate_basic_sense(cdev, irb);
-	if (cdev->private->flags.dosense) {
-		/* Another basic sense is needed. */
-		ccw_device_do_sense(cdev, irb);
-		return;
-	}
-	cdev->private->state = DEV_STATE_ONLINE_VERIFY;
-	/* Start delayed device verification. */
-	ccw_device_online_verify(cdev, 0);
-	/* Call the handler. */
-	ccw_device_call_handler(cdev);
+	if (ccw_device_call_handler(cdev) && cdev->private->flags.doverify)
+		/* Start delayed path verification. */
+		ccw_device_online_verify(cdev, 0);
 }
 
 static void
@@ -718,18 +665,6 @@
 		[DEV_EVENT_VERIFY]	ccw_device_nop,
 	},
 	/* states to wait for i/o completion before doing something */
-	[DEV_STATE_ONLINE_VERIFY] {
-		[DEV_EVENT_NOTOPER]	ccw_device_online_notoper,
-		[DEV_EVENT_INTERRUPT]	ccw_device_irq_verify,
-		[DEV_EVENT_TIMEOUT]	ccw_device_nop,
-		[DEV_EVENT_VERIFY]	ccw_device_nop,
-	},
-	[DEV_STATE_W4SENSE_VERIFY] {
-		[DEV_EVENT_NOTOPER]	ccw_device_online_notoper,
-		[DEV_EVENT_INTERRUPT]	ccw_device_w4sense_verify,
-		[DEV_EVENT_TIMEOUT]	ccw_device_nop,
-		[DEV_EVENT_VERIFY]	ccw_device_nop,
-	},
 	[DEV_STATE_CLEAR_VERIFY] {
 		[DEV_EVENT_NOTOPER]     ccw_device_online_notoper,
 		[DEV_EVENT_INTERRUPT]   ccw_device_clear_verify,
diff -urN linux-2.6/drivers/s390/cio/device_id.c linux-2.6-s390/drivers/s390/cio/device_id.c
--- linux-2.6/drivers/s390/cio/device_id.c	Mon Sep  8 21:49:50 2003
+++ linux-2.6-s390/drivers/s390/cio/device_id.c	Thu Sep 25 18:33:22 2003
@@ -342,3 +342,4 @@
 	}
 }
 
+EXPORT_SYMBOL(diag210);
diff -urN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-s390/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	Mon Sep  8 21:50:19 2003
+++ linux-2.6-s390/drivers/s390/cio/device_ops.c	Thu Sep 25 18:33:22 2003
@@ -50,9 +50,7 @@
 	if (!cdev)
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE &&
-	    cdev->private->state != DEV_STATE_W4SENSE &&
-	    cdev->private->state != DEV_STATE_ONLINE_VERIFY &&
-	    cdev->private->state != DEV_STATE_W4SENSE_VERIFY)
+	    cdev->private->state != DEV_STATE_W4SENSE)
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
 	if (!sch)
@@ -76,7 +74,8 @@
 	if (!sch)
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE ||
-	    sch->schib.scsw.actl != 0)
+	    sch->schib.scsw.actl != 0 ||
+	    cdev->private->flags.doverify)
 		return -EBUSY;
 	ret = cio_set_options (sch, flags);
 	if (ret)
@@ -113,9 +112,7 @@
 	if (!cdev)
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE &&
-	    cdev->private->state != DEV_STATE_W4SENSE &&
-	    cdev->private->state != DEV_STATE_ONLINE_VERIFY &&
-	    cdev->private->state != DEV_STATE_W4SENSE_VERIFY)
+	    cdev->private->state != DEV_STATE_W4SENSE)
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
 	if (!sch)
@@ -145,7 +142,7 @@
 /*
  * Pass interrupt to device driver.
  */
-void
+int
 ccw_device_call_handler(struct ccw_device *cdev)
 {
 	struct subchannel *sch;
@@ -167,7 +164,7 @@
 	    !(stctl & SCSW_STCTL_INTER_STATUS) &&
 	    !(cdev->private->options.fast &&
 	      (stctl & SCSW_STCTL_PRIM_STATUS)))
-		return;
+		return 0;
 
 	/*
 	 * Now we are ready to call the device driver interrupt handler.
@@ -180,6 +177,8 @@
 	 * Clear the old and now useless interrupt response block.
 	 */
 	memset(&cdev->private->irb, 0, sizeof(struct irb));
+
+	return 1;
 }
 
 /*
@@ -190,6 +189,8 @@
 {
 	int ciw_cnt;
 
+	if (cdev->private->flags.esid == 0)
+		return NULL;
 	for (ciw_cnt = 0; ciw_cnt < MAX_CIWS; ciw_cnt++)
 		if (cdev->private->senseid.ciw[ciw_cnt].ct == ct)
 			return cdev->private->senseid.ciw + ciw_cnt;
@@ -211,25 +212,89 @@
 static void
 ccw_device_wake_up(struct ccw_device *cdev, unsigned long ip, struct irb *irb)
 {
+	if (!ip)
+		/* unsolicited interrupt */
+		return;
+
+	/* Abuse intparm for error reporting. */
+	if (IS_ERR(irb))
+		cdev->private->intparm = -EIO;
+	else if ((irb->scsw.dstat !=
+		  (DEV_STAT_CHN_END|DEV_STAT_DEV_END)) ||
+		 (irb->scsw.cstat != 0)) {
+		/*
+		 * We didn't get channel end / device end. Check if path
+		 * verification has been started; we can retry after it has
+		 * finished. We also retry unit checks except for command reject
+		 * or intervention required.
+		 */
+		 if (cdev->private->flags.doverify ||
+			 cdev->private->state == DEV_STATE_VERIFY)
+			 cdev->private->intparm = -EAGAIN;
+		 if ((irb->scsw.dstat & DEV_STAT_UNIT_CHECK) &&
+		     !(irb->ecw[0] &
+		       (SNS0_CMD_REJECT | SNS0_INTERVENTION_REQ)))
+			 cdev->private->intparm = -EAGAIN;
+		 else
+			 cdev->private->intparm = -EIO;
+			 
+	} else
+		cdev->private->intparm = 0;
+	wake_up(&cdev->private->wait_q);
+}
+
+static inline int
+__ccw_device_retry_loop(struct ccw_device *cdev, struct ccw1 *ccw, long magic,
+			unsigned long flags)
+{
+	int ret;
 	struct subchannel *sch;
 
 	sch = to_subchannel(cdev->dev.parent);
-	if (!IS_ERR(irb))
-		memcpy(&sch->schib.scsw, &irb->scsw, sizeof(struct scsw));
-	wake_up(&cdev->private->wait_q);
+	do {
+		ret = cio_start (sch, ccw, magic, 0);
+		if ((ret == -EBUSY) || (ret == -EACCES)) {
+			/* Try again later. */
+			schedule_timeout(1);
+			continue;
+		}
+		if (ret != 0)
+			/* Non-retryable error. */
+			break;
+		/* Wait for end of request. */
+		cdev->private->intparm = magic;
+		spin_unlock_irqrestore(&sch->lock, flags);
+		wait_event(cdev->private->wait_q,
+			   (cdev->private->intparm == -EIO) ||
+			   (cdev->private->intparm == -EAGAIN) ||
+			   (cdev->private->intparm == 0));
+		spin_lock_irqsave(&sch->lock, flags);
+		/* Check at least for channel end / device end */
+		if (cdev->private->intparm == -EIO) {
+			/* Non-retryable error. */
+			ret = -EIO;
+			break;
+		}
+		if (cdev->private->intparm == 0)
+			/* Success. */
+			break;
+		/* Try again later. */
+		schedule_timeout(1);
+	} while (1);
+
+	return ret;
 }
 
-/*
- * This routine returns the characteristics for the device
- *  specified. Some old devices might not provide the necessary
- *  command code information during SenseID processing. In this
- *  case the function returns -EINVAL. Otherwise the function
- *  allocates a decice specific data buffer and provides the
- *  device characteristics together with the buffer size. Its
- *  the callers responability to release the kernel memory if
- *  not longer needed. In case of persistent I/O problems -EBUSY
- *  is returned.
- */
+/**
+ * read_dev_chars() - read device characteristics
+ * @param cdev   target ccw device
+ * @param buffer pointer to buffer for rdc data
+ * @param length size of rdc data
+ * @returns 0 for success, negative error value on failure
+ *
+ * Context:
+ *   called for online device, lock not held
+ **/
 int
 read_dev_chars (struct ccw_device *cdev, void **buffer, int length)
 {
@@ -237,13 +302,11 @@
 	char dbf_txt[15];
 	unsigned long flags;
 	struct subchannel *sch;
-	int retry;
 	int ret;
+	struct ccw1 *rdc_ccw;
 
 	if (!cdev)
 		return -ENODEV;
-	if (cdev->private->state != DEV_STATE_ONLINE)
-		return -EINVAL;
 	if (!buffer || !length)
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
@@ -251,44 +314,38 @@
 	sprintf (dbf_txt, "rddevch%x", sch->irq);
 	CIO_TRACE_EVENT (4, dbf_txt);
 
-	cdev->private->iccws[0].cmd_code = CCW_CMD_RDC;
-	cdev->private->iccws[0].count = length;
-	cdev->private->iccws[0].flags = CCW_FLAG_SLI;
-	ret = set_normalized_cda (cdev->private->iccws, (*buffer));
-	if (ret != 0)
+	rdc_ccw = kmalloc(sizeof(struct ccw1), GFP_KERNEL | GFP_DMA);
+	if (!rdc_ccw)
+		return -ENOMEM;
+	memset(rdc_ccw, 0, sizeof(struct ccw1));
+	rdc_ccw->cmd_code = CCW_CMD_RDC;
+	rdc_ccw->count = length;
+	rdc_ccw->flags = CCW_FLAG_SLI;
+	ret = set_normalized_cda (rdc_ccw, (*buffer));
+	if (ret != 0) {
+		kfree(rdc_ccw);
 		return ret;
+	}
 
 	spin_lock_irqsave(&sch->lock, flags);
 	/* Save interrupt handler. */
 	handler = cdev->handler;
 	/* Temporarily install own handler. */
 	cdev->handler = ccw_device_wake_up;
-	for (retry = 5; retry > 0; retry--) {
-		/* 0x00524443 == ebcdic "RDC" */
-		ret = cio_start (sch, cdev->private->iccws, 0x00524443, 0);
-		if (ret == -ENODEV)
-			break;
-		if (ret == 0) {
-			/* Wait for end of request. */
-			spin_unlock_irqrestore(&sch->lock, flags);
-			wait_event(cdev->private->wait_q,
-				   sch->schib.scsw.actl == 0);
-			spin_lock_irqsave(&sch->lock, flags);
-			/* Check at least for channel end / device end */
-			if ((sch->schib.scsw.dstat !=
-			     (DEV_STAT_CHN_END|DEV_STAT_DEV_END)) ||
-			    (sch->schib.scsw.cstat != 0)) {
-				ret = -EIO;
-				continue;
-			}
-			break;
-		}
-	}
+	if (cdev->private->state != DEV_STATE_ONLINE)
+		ret = -ENODEV;
+	else if (sch->schib.scsw.actl != 0 || cdev->private->flags.doverify)
+		ret = -EBUSY;
+	else
+		/* 0x00D9C4C3 == ebcdic "RDC" */
+		ret = __ccw_device_retry_loop(cdev, rdc_ccw, 0x00D9C4C3, flags);
+
 	/* Restore interrupt handler. */
 	cdev->handler = handler;
 	spin_unlock_irqrestore(&sch->lock, flags);
 
-	clear_normalized_cda (cdev->private->iccws);
+	clear_normalized_cda (rdc_ccw);
+	kfree(rdc_ccw);
 
 	return ret;
 }
@@ -305,15 +362,11 @@
 	struct ciw *ciw;
 	unsigned long flags;
 	char *rcd_buf;
-	int retry;
 	int ret;
+	struct ccw1 *rcd_ccw;
 
 	if (!cdev)
 		return -ENODEV;
-	if (cdev->private->state != DEV_STATE_ONLINE)
-		return -EINVAL;
-	if (cdev->private->flags.esid == 0)
-		return -EOPNOTSUPP;
 	if (!buffer || !length)
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
@@ -328,40 +381,34 @@
 	if (!ciw || ciw->cmd == 0)
 		return -EOPNOTSUPP;
 
+	rcd_ccw = kmalloc(sizeof(struct ccw1), GFP_KERNEL | GFP_DMA);
+	if (!rcd_ccw)
+		return -ENOMEM;
+	memset(rcd_ccw, 0, sizeof(struct ccw1));
 	rcd_buf = kmalloc(ciw->count, GFP_KERNEL | GFP_DMA);
- 	if (!rcd_buf)
+ 	if (!rcd_buf) {
+		kfree(rcd_ccw);
 		return -ENOMEM;
+	}
  	memset (rcd_buf, 0, ciw->count);
-	cdev->private->iccws[0].cmd_code = ciw->cmd;
-	cdev->private->iccws[0].cda = (__u32) __pa (rcd_buf);
-	cdev->private->iccws[0].count = ciw->count;
-	cdev->private->iccws[0].flags = CCW_FLAG_SLI;
+	rcd_ccw->cmd_code = ciw->cmd;
+	rcd_ccw->cda = (__u32) __pa (rcd_buf);
+	rcd_ccw->count = ciw->count;
+	rcd_ccw->flags = CCW_FLAG_SLI;
 
 	spin_lock_irqsave(&sch->lock, flags);
 	/* Save interrupt handler. */
 	handler = cdev->handler;
 	/* Temporarily install own handler. */
 	cdev->handler = ccw_device_wake_up;
-	for (ret = 0, retry = 5; retry > 0; retry--) {
-		/* 0x00524344 == ebcdic "RCD" */
-		ret = cio_start (sch, cdev->private->iccws, 0x00524344, 0);
-		if (ret == -ENODEV)
-			break;
-		if (ret)
-			continue;
-		/* Wait for end of request. */
-		spin_unlock_irqrestore(&sch->lock, flags);
-		wait_event(cdev->private->wait_q, sch->schib.scsw.actl == 0);
-		spin_lock_irqsave(&sch->lock, flags);
-		/* Check at least for channel end / device end */
-		if ((sch->schib.scsw.dstat != 
-		     (DEV_STAT_CHN_END|DEV_STAT_DEV_END)) ||
-		    (sch->schib.scsw.cstat != 0)) {
-			ret = -EIO;
-			continue;
-		}
-		break;
-	}
+	if (cdev->private->state != DEV_STATE_ONLINE)
+		ret = -ENODEV;
+	else if (sch->schib.scsw.actl != 0 || cdev->private->flags.doverify)
+		ret = -EBUSY;
+	else
+		/* 0x00D9C3C4 == ebcdic "RCD" */
+		ret = __ccw_device_retry_loop(cdev, rcd_ccw, 0x00D9C3C4, flags);
+
 	/* Restore interrupt handler. */
 	cdev->handler = handler;
 	spin_unlock_irqrestore(&sch->lock, flags);
@@ -377,6 +424,7 @@
 		*length = ciw->count;
 		*buffer = rcd_buf;
 	}
+	kfree(rcd_ccw);
 
 	return ret;
 }
diff -urN linux-2.6/drivers/s390/cio/device_status.c linux-2.6-s390/drivers/s390/cio/device_status.c
--- linux-2.6/drivers/s390/cio/device_status.c	Mon Sep  8 21:50:03 2003
+++ linux-2.6-s390/drivers/s390/cio/device_status.c	Thu Sep 25 18:33:22 2003
@@ -67,7 +67,8 @@
 		      sch->schib.pmcw.pnom);
 
 	sch->lpm &= ~sch->schib.pmcw.pnom;
-	dev_fsm_event(cdev, DEV_EVENT_VERIFY);
+	if (cdev->private->options.pgroup)
+		cdev->private->flags.doverify = 1;
 }
 
 /*
@@ -93,6 +94,21 @@
 }
 
 /*
+ * Check if extended status word is valid.
+ */
+static inline int
+ccw_device_accumulate_esw_valid(struct irb *irb)
+{
+	if (irb->scsw.eswf && irb->scsw.stctl == SCSW_STCTL_STATUS_PEND)
+		return 0;
+	if (irb->scsw.stctl == 
+	    		(SCSW_STCTL_INTER_STATUS|SCSW_STCTL_STATUS_PEND) &&
+	    !(irb->scsw.actl & SCSW_ACTL_SUSPENDED))
+		return 0;
+	return 1;
+}
+
+/*
  * Copy valid bits from the extended status word to device irb.
  */
 static inline void
@@ -101,12 +117,7 @@
 	struct irb *cdev_irb;
 	struct sublog *cdev_sublog, *sublog;
 
-	/* Check if extended status word is valid. */
-	if (irb->scsw.eswf && irb->scsw.stctl == SCSW_STCTL_STATUS_PEND)
-		return;
-	if (irb->scsw.stctl == 
-	    		(SCSW_STCTL_INTER_STATUS|SCSW_STCTL_STATUS_PEND) &&
-	    !(irb->scsw.actl & SCSW_ACTL_SUSPENDED))
+	if (!ccw_device_accumulate_esw_valid(irb))
 		return;
 
 	cdev_irb = &cdev->private->irb;
@@ -169,6 +180,8 @@
 	cdev_irb->esw.esw0.erw.auth = irb->esw.esw0.erw.auth;
 	/* Copy path verification required flag. */
 	cdev_irb->esw.esw0.erw.pvrf = irb->esw.esw0.erw.pvrf;
+	if (irb->esw.esw0.erw.pvrf && cdev->private->options.pgroup)
+		cdev->private->flags.doverify = 1;
 	/* Copy concurrent sense bit. */
 	cdev_irb->esw.esw0.erw.cons = irb->esw.esw0.erw.cons;
 	if (irb->esw.esw0.erw.cons)
@@ -339,6 +352,10 @@
 		cdev->private->irb.esw.esw0.erw.cons = 1;
 		cdev->private->flags.dosense = 0;
 	}
+	/* Check if path verification is required. */
+	if (ccw_device_accumulate_esw_valid(irb) &&
+	    irb->esw.esw0.erw.pvrf && cdev->private->options.pgroup) 
+		cdev->private->flags.doverify = 1;
 }
 
 /*
diff -urN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-s390/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	Mon Sep  8 21:50:08 2003
+++ linux-2.6-s390/drivers/s390/cio/qdio.c	Thu Sep 25 18:33:22 2003
@@ -55,7 +55,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.55 $"
+#define VERSION_QDIO_C "$Revision: 1.61 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -117,60 +117,6 @@
         asm volatile ("STCK %0" : "=m" (time));
         return time>>12; /* time>>12 is microseconds*/
 }
-static inline unsigned long 
-qdio_get_millis(void)
-{
-	return (unsigned long)(qdio_get_micros()>>12);
-}
-
-static __inline__ int 
-atomic_return_add (int i, atomic_t *v)
-{
-	int old, new;
-	__CS_LOOP(old, new, v, i, "ar");
-	return old;
-}
-
-static void 
-qdio_wait_nonbusy(unsigned int timeout)
-{
-        unsigned int start;
-        char dbf_text[15];
-
-	sprintf(dbf_text,"wtnb%4x",timeout);
-	QDIO_DBF_TEXT3(0,trace,dbf_text);
-
-	start=qdio_get_millis();
-	for (;;) {
-		set_task_state(current,TASK_INTERRUPTIBLE);
-		if (qdio_get_millis()-start>timeout) {
-			goto out;
-		}
-		schedule_timeout(((start+timeout-qdio_get_millis())>>10)*HZ);
-	}
-out:
-	set_task_state(current,TASK_RUNNING);
-}
-
-static int 
-qdio_wait_for_no_use_count(atomic_t *use_count)
-{
-	unsigned long start;
-
-	QDIO_DBF_TEXT3(0,trace,"wtnousec");
-	start=qdio_get_millis();
-	for (;;) {
-		if (qdio_get_millis()-start>QDIO_NO_USE_COUNT_TIMEOUT) {
-			QDIO_DBF_TEXT1(1,trace,"WTNOUSTO");
-			return -ETIME;
-		}
-		if (!atomic_read(use_count)) {
-			QDIO_DBF_TEXT3(0,trace,"wtnoused");
-			return 0;
-		}
-		qdio_wait_nonbusy(QDIO_NO_USE_COUNT_TIME);
-	}
-}
 
 /* 
  * unfortunately, we can't just xchg the values; in do_QDIO we want to reserve
@@ -181,7 +127,7 @@
 static inline int 
 qdio_reserve_q(struct qdio_q *q)
 {
-	return atomic_return_add(1,&q->use_count);
+	return atomic_add_return(1,&q->use_count) - 1;
 }
 
 static inline void 
@@ -1221,21 +1167,18 @@
 qdio_release_irq_memory(struct qdio_irq *irq_ptr)
 {
 	int i;
-	int available;
 
 	for (i=0;i<QDIO_MAX_QUEUES_PER_IRQ;i++) {
 		if (!irq_ptr->input_qs[i])
 			goto next;
-		available=0;
 
 		if (irq_ptr->input_qs[i]->slib)
 			kfree(irq_ptr->input_qs[i]->slib);
-			kfree(irq_ptr->input_qs[i]);
+		kfree(irq_ptr->input_qs[i]);
 
 next:
 		if (!irq_ptr->output_qs[i])
 			continue;
-		available=0;
 
 		if (irq_ptr->output_qs[i]->slib)
 			kfree(irq_ptr->output_qs[i]->slib);
@@ -1285,20 +1228,12 @@
 }
 
 static int
-qdio_alloc_qs(struct qdio_irq *irq_ptr, struct ccw_device *cdev,
-	      int no_input_qs, int no_output_qs,
-	      qdio_handler_t *input_handler,
-	      qdio_handler_t *output_handler,
-	      unsigned long int_parm,int q_format,
-	      unsigned long flags,
-	      void **inbound_sbals_array,
-	      void **outbound_sbals_array)
+qdio_alloc_qs(struct qdio_irq *irq_ptr,
+	      int no_input_qs, int no_output_qs)
 {
+	int i;
 	struct qdio_q *q;
-	int i,j,result=0;
-	char dbf_text[20]; /* see qdio_initialize */
-	void *ptr;
-	int available;
+	int result=-ENOMEM;
 
 	for (i=0;i<no_input_qs;i++) {
 		q=kmalloc(sizeof(struct qdio_q),GFP_KERNEL);
@@ -1307,17 +1242,67 @@
 			QDIO_PRINT_ERR("kmalloc of q failed!\n");
 			goto out;
 		}
+
 		memset(q,0,sizeof(struct qdio_q));
 
-		sprintf(dbf_text,"in-q%4x",i);
-		QDIO_DBF_TEXT0(0,setup,dbf_text);
-		QDIO_DBF_HEX0(0,setup,&q,sizeof(void*));
+		q->slib=kmalloc(PAGE_SIZE,GFP_KERNEL);
+		if (!q->slib) {
+			QDIO_PRINT_ERR("kmalloc of slib failed!\n");
+			goto out;
+		}
+
+		irq_ptr->input_qs[i]=q;
+	}
+
+	for (i=0;i<no_output_qs;i++) {
+		q=kmalloc(sizeof(struct qdio_q),GFP_KERNEL);
+
+		if (!q) {
+			goto out;
+		}
+
+		memset(q,0,sizeof(struct qdio_q));
 
 		q->slib=kmalloc(PAGE_SIZE,GFP_KERNEL);
 		if (!q->slib) {
 			QDIO_PRINT_ERR("kmalloc of slib failed!\n");
 			goto out;
 		}
+
+		irq_ptr->output_qs[i]=q;
+	}
+
+	result=0;
+out:
+	return result;
+}
+
+static void
+qdio_fill_qs(struct qdio_irq *irq_ptr, struct ccw_device *cdev,
+       	     int no_input_qs, int no_output_qs,
+	     qdio_handler_t *input_handler,
+	     qdio_handler_t *output_handler,
+	     unsigned long int_parm,int q_format,
+	     unsigned long flags,
+	     void **inbound_sbals_array,
+	     void **outbound_sbals_array)
+{
+	struct qdio_q *q;
+	int i,j;
+	char dbf_text[20]; /* see qdio_initialize */
+	void *ptr;
+	int available;
+
+	sprintf(dbf_text,"qfqs%4x",cdev->private->irq);
+	QDIO_DBF_TEXT0(0,setup,dbf_text);
+	for (i=0;i<no_input_qs;i++) {
+		q=irq_ptr->input_qs[i];
+
+		memset(q,0,((char*)&q->slib)-((char*)q));
+		sprintf(dbf_text,"in-q%4x",i);
+		QDIO_DBF_TEXT0(0,setup,dbf_text);
+		QDIO_DBF_HEX0(0,setup,&q,sizeof(void*));
+
 		memset(q->slib,0,PAGE_SIZE);
 		q->sl=(struct sl*)(((char*)q->slib)+PAGE_SIZE/2);
 
@@ -1328,7 +1313,6 @@
 
                 q->queue_type=q_format;
 		q->int_parm=int_parm;
-		irq_ptr->input_qs[i]=q;
 		q->irq=irq_ptr->irq;
 		q->irq_ptr = irq_ptr;
 		q->cdev = cdev;
@@ -1380,22 +1364,13 @@
 	}
 
 	for (i=0;i<no_output_qs;i++) {
-		q=kmalloc(sizeof(struct qdio_q),GFP_KERNEL);
-
-		if (!q) {
-			goto out;
-		}
-		memset(q,0,sizeof(struct qdio_q));
+		q=irq_ptr->output_qs[i];
+		memset(q,0,((char*)&q->slib)-((char*)q));
 
 		sprintf(dbf_text,"outq%4x",i);
 		QDIO_DBF_TEXT0(0,setup,dbf_text);
 		QDIO_DBF_HEX0(0,setup,&q,sizeof(void*));
 
-		q->slib=kmalloc(PAGE_SIZE,GFP_KERNEL);
-		if (!q->slib) {
-			QDIO_PRINT_ERR("kmalloc of slib failed!\n");
-			goto out;
-		}
 		memset(q->slib,0,PAGE_SIZE);
 		q->sl=(struct sl*)(((char*)q->slib)+PAGE_SIZE/2);
 
@@ -1406,7 +1381,6 @@
 
                 q->queue_type=q_format;
 		q->int_parm=int_parm;
-		irq_ptr->output_qs[i]=q;
 		q->is_input_q=0;
 		q->irq=irq_ptr->irq;
 		q->cdev = cdev;
@@ -1446,10 +1420,6 @@
 /*			q->sbal[j]->element[1].sbalf.i1.key=QDIO_STORAGE_KEY;*/
 		}
 	}
-
-	result=1;
-out:
-	return result;
 }
 
 static void
@@ -1645,7 +1615,6 @@
 	}
 	ccw_device_set_timeout(cdev, 0);
 	wake_up(&cdev->private->wait_q);
-
 }
 
 static void
@@ -1703,7 +1672,6 @@
 
 	switch (irq_ptr->state) {
 	case QDIO_IRQ_STATE_INACTIVE:
-		/* FIXME: defer this past interrupt time */
 		qdio_establish_handle_irq(cdev, cstat, dstat);
 		break;
 
@@ -2128,8 +2096,12 @@
 	for (i=0;i<irq_ptr->no_input_qs;i++) {
 		qdio_unmark_q(irq_ptr->input_qs[i]);
 		tasklet_kill(&irq_ptr->input_qs[i]->tasklet);
-		if (qdio_wait_for_no_use_count(&irq_ptr->input_qs[i]->
-					       use_count))
+		wait_event_interruptible_timeout(cdev->private->wait_q,
+						 !atomic_read(&irq_ptr->
+							      input_qs[i]->
+							      use_count),
+						 QDIO_NO_USE_COUNT_TIMEOUT*HZ);
+		if (atomic_read(&irq_ptr->input_qs[i]->use_count))
 			/*
 			 * FIXME:
 			 * nobody cares about such retval,
@@ -2142,8 +2114,12 @@
 
 	for (i=0;i<irq_ptr->no_output_qs;i++) {
 		tasklet_kill(&irq_ptr->output_qs[i]->tasklet);
-		if (qdio_wait_for_no_use_count(&irq_ptr->output_qs[i]->
-					       use_count))
+		wait_event_interruptible_timeout(cdev->private->wait_q,
+						 !atomic_read(&irq_ptr->
+							      output_qs[i]->
+							      use_count),
+						 QDIO_NO_USE_COUNT_TIMEOUT*HZ);
+		if (atomic_read(&irq_ptr->output_qs[i]->use_count))
 			/*
 			 * FIXME:
 			 * nobody cares about such retval,
@@ -2176,16 +2152,7 @@
 	wait_event(cdev->private->wait_q,
 		   irq_ptr->state == QDIO_IRQ_STATE_INACTIVE ||
 		   irq_ptr->state == QDIO_IRQ_STATE_ERR);
-	/* Ignore errors. */
-	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_INACTIVE);
-out:
-	up(&irq_ptr->setting_up_sema);
-	return result;
-}
 
-static inline void
-qdio_cleanup_finish(struct ccw_device *cdev, struct qdio_irq *irq_ptr)
-{
 	if (irq_ptr->is_thinint_irq) {
 		qdio_put_indicator((__u32*)irq_ptr->dev_st_chg_ind);
 		tiqdio_set_subchannel_ind(irq_ptr,1); 
@@ -2196,8 +2163,12 @@
  	if ((void*)cdev->handler == (void*)qdio_handler)
  		cdev->handler=irq_ptr->original_int_handler;
 
-	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_INACTIVE);
-
+	/* Ignore errors. */
+	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_INACTIVE);
+	ccw_device_set_timeout(cdev, 0);
+out:
+	up(&irq_ptr->setting_up_sema);
+	return result;
 }
 
 int
@@ -2216,10 +2187,6 @@
 	QDIO_DBF_TEXT1(0,trace,dbf_text);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 
-	if (cdev->private->state != DEV_STATE_ONLINE)
-		return -EINVAL;
-
-	qdio_cleanup_finish(cdev, irq_ptr);
 	cdev->private->qdio_data = 0;
 
 	up(&irq_ptr->setting_up_sema);
@@ -2234,9 +2201,6 @@
 {
 	char dbf_text[20]; /* if a printf would print out more than 8 chars */
 
-	sprintf(dbf_text,"qalc%4x",init_data->cdev->private->irq);
-	QDIO_DBF_TEXT0(0,setup,dbf_text);
-	QDIO_DBF_TEXT0(0,trace,dbf_text);
 	sprintf(dbf_text,"qfmt:%x",init_data->q_format);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,setup,init_data->adapter_name);
@@ -2409,6 +2373,8 @@
 	struct qdio_irq *irq_ptr;
 	char dbf_text[15];
 
+	irq_ptr = cdev->private->qdio_data;
+
 	sprintf(dbf_text,"qehi%4x",cdev->private->irq);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,trace,dbf_text);
@@ -2418,28 +2384,6 @@
 		return;
 	}
 
-	irq_ptr = cdev->private->qdio_data;
-
-	if (MACHINE_IS_VM)
-		irq_ptr->qdioac=qdio_check_siga_needs(irq_ptr->irq);
-	else
-                irq_ptr->qdioac=CHSC_FLAG_SIGA_INPUT_NECESSARY
-                        | CHSC_FLAG_SIGA_OUTPUT_NECESSARY;
-
-	sprintf(dbf_text,"qdioac%2x",irq_ptr->qdioac);
-	QDIO_DBF_TEXT2(0,setup,dbf_text);
-
-	sprintf(dbf_text,"qib ac%2x",irq_ptr->qib.ac);
-	QDIO_DBF_TEXT2(0,setup,dbf_text);
-
-	irq_ptr->hydra_gives_outbound_pcis=
-		irq_ptr->qib.ac&QIB_AC_OUTBOUND_PCI_SUPPORTED;
-	irq_ptr->sync_done_on_outb_pcis=
-		irq_ptr->qdioac&CHSC_FLAG_SIGA_SYNC_DONE_ON_OUTB_PCIS;
-
-	qdio_initialize_set_siga_flags_input(irq_ptr);
-	qdio_initialize_set_siga_flags_output(irq_ptr);
-
 	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_ESTABLISHED);
 	ccw_device_set_timeout(cdev, 0);
 }
@@ -2456,7 +2400,7 @@
 
 	rc = qdio_allocate(init_data);
 	if (rc == 0) {
-		rc = qdio_establish(init_data->cdev);
+		rc = qdio_establish(init_data);
 		if (rc != 0)
 			qdio_free(init_data->cdev);
 	}
@@ -2468,13 +2412,12 @@
 int
 qdio_allocate(struct qdio_initialize *init_data)
 {
-	int i;
 	struct qdio_irq *irq_ptr;
-	struct ciw *ciw;
-	int result;
-	int is_iqdio;
 	char dbf_text[15];
 
+	sprintf(dbf_text,"qalc%4x",init_data->cdev->private->irq);
+	QDIO_DBF_TEXT0(0,setup,dbf_text);
+	QDIO_DBF_TEXT0(0,trace,dbf_text);
 	if ( (init_data->no_input_qs>QDIO_MAX_QUEUES_PER_IRQ) ||
 	     (init_data->no_output_qs>QDIO_MAX_QUEUES_PER_IRQ) ||
 	     ((init_data->no_input_qs) && (!init_data->input_handler)) ||
@@ -2501,7 +2444,8 @@
 	}
 
 	memset(irq_ptr,0,sizeof(struct qdio_irq));
-        /* wipes qib.ac, required by ar7063 */
+
+	init_MUTEX(&irq_ptr->setting_up_sema);
 
 	irq_ptr->qdr=kmalloc(sizeof(struct qdr), GFP_KERNEL | GFP_DMA);
   	if (!(irq_ptr->qdr)) {
@@ -2510,10 +2454,38 @@
     		QDIO_PRINT_ERR("kmalloc of irq_ptr->qdr failed!\n");
 		return -ENOMEM;
        	}
-	memset(irq_ptr->qdr,0,sizeof(struct qdr));
 	QDIO_DBF_TEXT0(0,setup,"qdr:");
 	QDIO_DBF_HEX0(0,setup,&irq_ptr->qdr,sizeof(void*));
 
+	if (qdio_alloc_qs(irq_ptr,
+       			  init_data->no_input_qs,
+			  init_data->no_output_qs)) {
+		qdio_release_irq_memory(irq_ptr);
+		return -ENOMEM;
+	}
+
+	init_data->cdev->private->qdio_data = irq_ptr;
+
+	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_INACTIVE);
+
+	return 0;
+}
+
+int qdio_fill_irq(struct qdio_initialize *init_data)
+{
+	int i;
+	char dbf_text[15];
+	struct ciw *ciw;
+	int is_iqdio;
+	struct qdio_irq *irq_ptr;
+
+	irq_ptr = init_data->cdev->private->qdio_data;
+
+	memset(irq_ptr,0,((char*)&irq_ptr->qdr)-((char*)irq_ptr));
+
+        /* wipes qib.ac, required by ar7063 */
+	memset(irq_ptr->qdr,0,sizeof(struct qdr));
+
 	irq_ptr->int_parm=init_data->int_parm;
 
 	irq_ptr->irq = init_data->cdev->private->irq;
@@ -2548,19 +2520,14 @@
 	irq_ptr->aqueue.cmd=DEFAULT_ACTIVATE_QS_CMD;
 	irq_ptr->aqueue.count=DEFAULT_ACTIVATE_QS_COUNT;
 
-	if (!qdio_alloc_qs(irq_ptr, init_data->cdev,
-			   init_data->no_input_qs,
-			   init_data->no_output_qs,
-			   init_data->input_handler,
-			   init_data->output_handler,init_data->int_parm,
-			   init_data->q_format,init_data->flags,
-			   init_data->input_sbal_addr_array,
-			   init_data->output_sbal_addr_array)) {
-		qdio_release_irq_memory(irq_ptr);
-		return -ENOMEM;
-	}
-
-	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_INACTIVE);
+	qdio_fill_qs(irq_ptr, init_data->cdev,
+		     init_data->no_input_qs,
+		     init_data->no_output_qs,
+		     init_data->input_handler,
+		     init_data->output_handler,init_data->int_parm,
+		     init_data->q_format,init_data->flags,
+	   	     init_data->input_sbal_addr_array,
+   		     init_data->output_sbal_addr_array);
 
 	if (!try_module_get(THIS_MODULE)) {
 		QDIO_PRINT_CRIT("try_module_get() failed!\n");
@@ -2568,10 +2535,6 @@
 		return -EINVAL;
 	}
 
-	init_MUTEX_LOCKED(&irq_ptr->setting_up_sema);
-
-	init_data->cdev->private->qdio_data = irq_ptr;
-
 	qdio_fill_thresholds(irq_ptr,init_data->no_input_qs,
 			     init_data->no_output_qs,
 			     init_data->min_input_threshold,
@@ -2636,31 +2599,21 @@
 	irq_ptr->original_int_handler = init_data->cdev->handler;
 	init_data->cdev->handler = qdio_handler;
 
-	/* the thinint CHSC stuff */
-	if (irq_ptr->is_thinint_irq) {
-
-		result = tiqdio_set_subchannel_ind(irq_ptr,0);
-		if (result) {
-			up(&irq_ptr->setting_up_sema);
-			qdio_cleanup(init_data->cdev, QDIO_FLAG_CLEANUP_USING_CLEAR);
-			return result;
-		}
-		tiqdio_set_delay_target(irq_ptr,TIQDIO_DELAY_TARGET);
-	}
-
 	up(&irq_ptr->setting_up_sema);
 
 	return 0;
 }
 
 int
-qdio_establish(struct ccw_device *cdev)
+qdio_establish(struct qdio_initialize *init_data)
 {
 	struct qdio_irq *irq_ptr;
 	unsigned long saveflags;
 	int result, result2;
+	struct ccw_device *cdev;
 	char dbf_text[20];
 
+	cdev=init_data->cdev;
 	irq_ptr = cdev->private->qdio_data;
 	if (!irq_ptr)
 		return -EINVAL;
@@ -2670,6 +2623,20 @@
 	
 	down(&irq_ptr->setting_up_sema);
 
+	qdio_fill_irq(init_data);
+
+	/* the thinint CHSC stuff */
+	if (irq_ptr->is_thinint_irq) {
+
+		result = tiqdio_set_subchannel_ind(irq_ptr,0);
+		if (result) {
+			up(&irq_ptr->setting_up_sema);
+			qdio_cleanup(cdev, QDIO_FLAG_CLEANUP_USING_CLEAR);
+			return result;
+		}
+		tiqdio_set_delay_target(irq_ptr,TIQDIO_DELAY_TARGET);
+	}
+
 	sprintf(dbf_text,"qest%4x",cdev->private->irq);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,trace,dbf_text);
@@ -2724,6 +2691,26 @@
 		result = -EIO;
 	}
 
+	if (MACHINE_IS_VM)
+		irq_ptr->qdioac=qdio_check_siga_needs(irq_ptr->irq);
+	else
+                irq_ptr->qdioac=CHSC_FLAG_SIGA_INPUT_NECESSARY
+                        | CHSC_FLAG_SIGA_OUTPUT_NECESSARY;
+
+	sprintf(dbf_text,"qdioac%2x",irq_ptr->qdioac);
+	QDIO_DBF_TEXT2(0,setup,dbf_text);
+
+	sprintf(dbf_text,"qib ac%2x",irq_ptr->qib.ac);
+	QDIO_DBF_TEXT2(0,setup,dbf_text);
+
+	irq_ptr->hydra_gives_outbound_pcis=
+		irq_ptr->qib.ac&QIB_AC_OUTBOUND_PCI_SUPPORTED;
+	irq_ptr->sync_done_on_outb_pcis=
+		irq_ptr->qdioac&CHSC_FLAG_SIGA_SYNC_DONE_ON_OUTB_PCIS;
+
+	qdio_initialize_set_siga_flags_input(irq_ptr);
+	qdio_initialize_set_siga_flags_output(irq_ptr);
+
 	up(&irq_ptr->setting_up_sema);
 
 	return result;
@@ -2806,10 +2793,23 @@
 		}
 	}
 
-	qdio_wait_nonbusy(QDIO_ACTIVATE_TIMEOUT);
-
-	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ACTIVE);
+	wait_event_interruptible_timeout(cdev->private->wait_q,
+					 ((irq_ptr->state ==
+					  QDIO_IRQ_STATE_STOPPED) ||
+					  (irq_ptr->state ==
+					   QDIO_IRQ_STATE_ERR)),
+					 (QDIO_ACTIVATE_TIMEOUT>>10)*HZ);
 
+	switch (irq_ptr->state) {
+	case QDIO_IRQ_STATE_STOPPED:
+	case QDIO_IRQ_STATE_ERR:
+		qdio_shutdown(cdev, QDIO_FLAG_CLEANUP_USING_CLEAR);
+		result = -EIO;
+		break;
+	default:
+		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ACTIVE);
+		result = 0;
+	}
  out:
 	up(&irq_ptr->setting_up_sema);
 
@@ -2855,7 +2855,7 @@
 	int used_elements;
 
         /* This is the inbound handling of queues */
-	used_elements=atomic_return_add(count, &q->number_of_buffers_used);
+	used_elements=atomic_add_return(count, &q->number_of_buffers_used) - count;
 	
 	qdio_do_qdio_fill_input(q,qidx,count,buffers);
 	
@@ -2897,7 +2897,7 @@
 
 	qdio_do_qdio_fill_output(q,qidx,count,buffers);
 
-	used_elements=atomic_return_add(count, &q->number_of_buffers_used);
+	used_elements=atomic_add_return(count, &q->number_of_buffers_used) - count;
 
 	if (callflags&QDIO_FLAG_DONT_SIGA) {
 #ifdef QDIO_PERFORMANCE_STATS
diff -urN linux-2.6/drivers/s390/cio/qdio.h linux-2.6-s390/drivers/s390/cio/qdio.h
--- linux-2.6/drivers/s390/cio/qdio.h	Mon Sep  8 21:49:57 2003
+++ linux-2.6-s390/drivers/s390/cio/qdio.h	Thu Sep 25 18:33:22 2003
@@ -1,7 +1,7 @@
 #ifndef _CIO_QDIO_H
 #define _CIO_QDIO_H
 
-#define VERSION_CIO_QDIO_H "$Revision: 1.18 $"
+#define VERSION_CIO_QDIO_H "$Revision: 1.20 $"
 
 //#define QDIO_DBF_LIKE_HELL
 
@@ -56,7 +56,6 @@
 #define QDIO_STATS_CLASSES 2
 #define QDIO_STATS_COUNT_NEEDED 2*/
 
-#define QDIO_NO_USE_COUNT_TIME 10
 #define QDIO_NO_USE_COUNT_TIMEOUT 1000 /* wait for 1 sec on each q before
 					  exiting without having use_count
 					  of the queue to 0 */
@@ -577,9 +576,6 @@
 	volatile struct qdio_q *list_next;
 	volatile struct qdio_q *list_prev;
 
-	struct slib *slib; /* a page is allocated under this pointer,
-			      sl points into this page, offset PAGE_SIZE/2
-			      (after slib) */
 	struct sl *sl;
 	volatile struct sbal *sbal[QDIO_MAX_BUFFERS_PER_Q];
 
@@ -605,6 +601,11 @@
 		__u64 last_transfer_time;
 	} timing;
         unsigned int queue_type;
+
+	/* leave this member at the end. won't be cleared in qdio_fill_qs */
+	struct slib *slib; /* a page is allocated under this pointer,
+			      sl points into this page, offset PAGE_SIZE/2
+			      (after slib) */
 } __attribute__ ((aligned(256)));
 
 struct qdio_irq {
@@ -619,20 +620,14 @@
 	unsigned int sync_done_on_outb_pcis;
 
 	enum qdio_irq_states state;
-	struct semaphore setting_up_sema;
 
 	unsigned int no_input_qs;
 	unsigned int no_output_qs;
 
 	unsigned char qdioac;
 
-	struct qdio_q *input_qs[QDIO_MAX_QUEUES_PER_IRQ];
-	struct qdio_q *output_qs[QDIO_MAX_QUEUES_PER_IRQ];
-
 	struct ccw1 ccw;
 
-	struct qdr *qdr;
-
 	struct ciw equeue;
 	struct ciw aqueue;
 
@@ -641,5 +636,10 @@
  	void (*original_int_handler) (struct ccw_device *,
  				      unsigned long, struct irb *);
 
+	/* leave these four members together at the end. won't be cleared in qdio_fill_irq */
+	struct qdr *qdr;
+	struct qdio_q *input_qs[QDIO_MAX_QUEUES_PER_IRQ];
+	struct qdio_q *output_qs[QDIO_MAX_QUEUES_PER_IRQ];
+	struct semaphore setting_up_sema;
 };
 #endif
diff -urN linux-2.6/drivers/s390/net/cu3088.c linux-2.6-s390/drivers/s390/net/cu3088.c
--- linux-2.6/drivers/s390/net/cu3088.c	Mon Sep  8 21:50:00 2003
+++ linux-2.6-s390/drivers/s390/net/cu3088.c	Thu Sep 25 18:33:22 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: cu3088.c,v 1.26 2003/01/17 13:46:13 cohuck Exp $
+ * $Id: cu3088.c,v 1.30 2003/08/28 11:14:11 cohuck Exp $
  *
  * CTC / LCS ccw_device driver
  *
@@ -56,7 +56,6 @@
 static struct ccw_driver cu3088_driver;
 
 struct device cu3088_root_dev = {
-	.name   = "CU3088 Devices",
 	.bus_id = "cu3088",
 };
 
@@ -64,7 +63,7 @@
 group_write(struct device_driver *drv, const char *buf, size_t count)
 {
 	const char *start, *end;
-	char bus_ids[2][BUS_ID_SIZE+1], *argv[2];
+	char bus_ids[2][BUS_ID_SIZE], *argv[2];
 	int i;
 	int ret;
 	struct ccwgroup_driver *cdrv;
@@ -79,7 +78,7 @@
 
 		if (!(end = strchr(start, delim[i])))
 			return count;
-		len = min_t(ptrdiff_t, BUS_ID_SIZE, end - start)+1;
+		len = min_t(ptrdiff_t, BUS_ID_SIZE, end - start + 1);
 		strlcpy (bus_ids[i], start, len);
 		argv[i] = bus_ids[i];
 		start = end + 1;
diff -urN linux-2.6/include/asm-s390/qdio.h linux-2.6-s390/include/asm-s390/qdio.h
--- linux-2.6/include/asm-s390/qdio.h	Mon Sep  8 21:49:55 2003
+++ linux-2.6-s390/include/asm-s390/qdio.h	Thu Sep 25 18:33:22 2003
@@ -76,7 +76,7 @@
 #define QDIO_FLAG_CLEANUP_USING_CLEAR 0x01
 #define QDIO_FLAG_CLEANUP_USING_HALT 0x02
 
-struct qdio_initialize{
+struct qdio_initialize {
 	struct ccw_device *cdev;
 	unsigned char q_format;
 	unsigned char adapter_name[8];
@@ -99,9 +99,10 @@
 	void **input_sbal_addr_array; /* addr of n*128 void ptrs */
 	void **output_sbal_addr_array; /* addr of n*128 void ptrs */
 };
+
 extern int qdio_initialize(struct qdio_initialize *init_data);
 extern int qdio_allocate(struct qdio_initialize *init_data);
-extern int qdio_establish(struct ccw_device *);
+extern int qdio_establish(struct qdio_initialize *init_data);
 
 extern int qdio_activate(struct ccw_device *,int flags);
 
