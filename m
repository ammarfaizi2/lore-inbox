Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbTIKRXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbTIKRW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:22:56 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:52616 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261432AbTIKRRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:17:34 -0400
Date: Thu, 11 Sep 2003 19:16:45 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (4/7): common i/o layer.
Message-ID: <20030911171645.GE5637@mschwid3.boeblingen.de.ibm.com>
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

diffstat:
 drivers/s390/cio/ccwgroup.c   |  157 ++++++++++++++++++-
 drivers/s390/cio/chsc.c       |    6 
 drivers/s390/cio/css.c        |   17 --
 drivers/s390/cio/device.c     |   13 -
 drivers/s390/cio/device_id.c  |    1 
 drivers/s390/cio/device_ops.c |   77 ++++++---
 drivers/s390/cio/qdio.c       |  340 +++++++++++++++++++++---------------------
 drivers/s390/cio/qdio.h       |   22 +-
 drivers/s390/net/cu3088.c     |    4 
 include/asm-s390/qdio.h       |    5 
 10 files changed, 405 insertions(+), 237 deletions(-)

diff -urN linux-2.6/drivers/s390/cio/ccwgroup.c linux-2.6-s390/drivers/s390/cio/ccwgroup.c
--- linux-2.6/drivers/s390/cio/ccwgroup.c	Mon Sep  8 21:50:07 2003
+++ linux-2.6-s390/drivers/s390/cio/ccwgroup.c	Thu Sep 11 19:21:26 2003
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
+++ linux-2.6-s390/drivers/s390/cio/chsc.c	Thu Sep 11 19:21:26 2003
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
diff -urN linux-2.6/drivers/s390/cio/css.c linux-2.6-s390/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	Mon Sep  8 21:49:53 2003
+++ linux-2.6-s390/drivers/s390/cio/css.c	Thu Sep 11 19:21:26 2003
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
diff -urN linux-2.6/drivers/s390/cio/device.c linux-2.6-s390/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	Mon Sep  8 21:50:18 2003
+++ linux-2.6-s390/drivers/s390/cio/device.c	Thu Sep 11 19:21:26 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.60 $
+ *   $Revision: 1.68 $
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
@@ -702,10 +701,12 @@
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
diff -urN linux-2.6/drivers/s390/cio/device_id.c linux-2.6-s390/drivers/s390/cio/device_id.c
--- linux-2.6/drivers/s390/cio/device_id.c	Mon Sep  8 21:49:50 2003
+++ linux-2.6-s390/drivers/s390/cio/device_id.c	Thu Sep 11 19:21:26 2003
@@ -342,3 +342,4 @@
 	}
 }
 
+EXPORT_SYMBOL(diag210);
diff -urN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-s390/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	Mon Sep  8 21:50:19 2003
+++ linux-2.6-s390/drivers/s390/cio/device_ops.c	Thu Sep 11 19:21:26 2003
@@ -211,11 +211,19 @@
 static void
 ccw_device_wake_up(struct ccw_device *cdev, unsigned long ip, struct irb *irb)
 {
-	struct subchannel *sch;
-
-	sch = to_subchannel(cdev->dev.parent);
-	if (!IS_ERR(irb))
-		memcpy(&sch->schib.scsw, &irb->scsw, sizeof(struct scsw));
+	if (!ip)
+		/* unsolicited interrupt */
+		return;
+
+	/* Abuse intparm for error reporting. */
+	if (IS_ERR(irb))
+		cdev->private->intparm = -EIO;
+	else if ((irb->scsw.dstat !=
+		  (DEV_STAT_CHN_END|DEV_STAT_DEV_END)) ||
+		 (irb->scsw.cstat != 0))
+		cdev->private->intparm = -EIO;
+	else
+		cdev->private->intparm = 0;
 	wake_up(&cdev->private->wait_q);
 }
 
@@ -239,6 +247,7 @@
 	struct subchannel *sch;
 	int retry;
 	int ret;
+	struct ccw1 *rdc_ccw;
 
 	if (!cdev)
 		return -ENODEV;
@@ -251,12 +260,18 @@
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
@@ -265,19 +280,19 @@
 	cdev->handler = ccw_device_wake_up;
 	for (retry = 5; retry > 0; retry--) {
 		/* 0x00524443 == ebcdic "RDC" */
-		ret = cio_start (sch, cdev->private->iccws, 0x00524443, 0);
+		ret = cio_start (sch, rdc_ccw, 0x00524443, 0);
 		if (ret == -ENODEV)
 			break;
 		if (ret == 0) {
 			/* Wait for end of request. */
+			cdev->private->intparm = 0x00524443;
 			spin_unlock_irqrestore(&sch->lock, flags);
 			wait_event(cdev->private->wait_q,
-				   sch->schib.scsw.actl == 0);
+				   (cdev->private->intparm == -EIO) ||
+				   (cdev->private->intparm == 0));
 			spin_lock_irqsave(&sch->lock, flags);
 			/* Check at least for channel end / device end */
-			if ((sch->schib.scsw.dstat !=
-			     (DEV_STAT_CHN_END|DEV_STAT_DEV_END)) ||
-			    (sch->schib.scsw.cstat != 0)) {
+			if (cdev->private->intparm) {
 				ret = -EIO;
 				continue;
 			}
@@ -288,7 +303,8 @@
 	cdev->handler = handler;
 	spin_unlock_irqrestore(&sch->lock, flags);
 
-	clear_normalized_cda (cdev->private->iccws);
+	clear_normalized_cda (rdc_ccw);
+	kfree(rdc_ccw);
 
 	return ret;
 }
@@ -307,6 +323,7 @@
 	char *rcd_buf;
 	int retry;
 	int ret;
+	struct ccw1 *rcd_ccw;
 
 	if (!cdev)
 		return -ENODEV;
@@ -328,14 +345,20 @@
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
@@ -344,19 +367,20 @@
 	cdev->handler = ccw_device_wake_up;
 	for (ret = 0, retry = 5; retry > 0; retry--) {
 		/* 0x00524344 == ebcdic "RCD" */
-		ret = cio_start (sch, cdev->private->iccws, 0x00524344, 0);
+		ret = cio_start (sch, rcd_ccw, 0x00524344, 0);
 		if (ret == -ENODEV)
 			break;
 		if (ret)
 			continue;
 		/* Wait for end of request. */
+		cdev->private->intparm = 0x00524344; 
 		spin_unlock_irqrestore(&sch->lock, flags);
-		wait_event(cdev->private->wait_q, sch->schib.scsw.actl == 0);
+		wait_event(cdev->private->wait_q,
+			   (cdev->private->intparm == -EIO) ||
+			   (cdev->private->intparm == 0));
 		spin_lock_irqsave(&sch->lock, flags);
 		/* Check at least for channel end / device end */
-		if ((sch->schib.scsw.dstat != 
-		     (DEV_STAT_CHN_END|DEV_STAT_DEV_END)) ||
-		    (sch->schib.scsw.cstat != 0)) {
+		if (cdev->private->intparm) {
 			ret = -EIO;
 			continue;
 		}
@@ -377,6 +401,7 @@
 		*length = ciw->count;
 		*buffer = rcd_buf;
 	}
+	kfree(rcd_ccw);
 
 	return ret;
 }
diff -urN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-s390/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	Mon Sep  8 21:50:08 2003
+++ linux-2.6-s390/drivers/s390/cio/qdio.c	Thu Sep 11 19:21:26 2003
@@ -55,7 +55,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.55 $"
+#define VERSION_QDIO_C "$Revision: 1.60 $"
 
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
@@ -2178,6 +2154,7 @@
 		   irq_ptr->state == QDIO_IRQ_STATE_ERR);
 	/* Ignore errors. */
 	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_INACTIVE);
+	ccw_device_set_timeout(cdev, 0);
 out:
 	up(&irq_ptr->setting_up_sema);
 	return result;
@@ -2234,9 +2211,6 @@
 {
 	char dbf_text[20]; /* if a printf would print out more than 8 chars */
 
-	sprintf(dbf_text,"qalc%4x",init_data->cdev->private->irq);
-	QDIO_DBF_TEXT0(0,setup,dbf_text);
-	QDIO_DBF_TEXT0(0,trace,dbf_text);
 	sprintf(dbf_text,"qfmt:%x",init_data->q_format);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,setup,init_data->adapter_name);
@@ -2409,6 +2383,8 @@
 	struct qdio_irq *irq_ptr;
 	char dbf_text[15];
 
+	irq_ptr = cdev->private->qdio_data;
+
 	sprintf(dbf_text,"qehi%4x",cdev->private->irq);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,trace,dbf_text);
@@ -2418,28 +2394,6 @@
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
@@ -2456,7 +2410,7 @@
 
 	rc = qdio_allocate(init_data);
 	if (rc == 0) {
-		rc = qdio_establish(init_data->cdev);
+		rc = qdio_establish(init_data);
 		if (rc != 0)
 			qdio_free(init_data->cdev);
 	}
@@ -2468,13 +2422,12 @@
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
@@ -2501,7 +2454,8 @@
 	}
 
 	memset(irq_ptr,0,sizeof(struct qdio_irq));
-        /* wipes qib.ac, required by ar7063 */
+
+	init_MUTEX(&irq_ptr->setting_up_sema);
 
 	irq_ptr->qdr=kmalloc(sizeof(struct qdr), GFP_KERNEL | GFP_DMA);
   	if (!(irq_ptr->qdr)) {
@@ -2510,10 +2464,38 @@
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
@@ -2548,19 +2530,14 @@
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
@@ -2568,10 +2545,6 @@
 		return -EINVAL;
 	}
 
-	init_MUTEX_LOCKED(&irq_ptr->setting_up_sema);
-
-	init_data->cdev->private->qdio_data = irq_ptr;
-
 	qdio_fill_thresholds(irq_ptr,init_data->no_input_qs,
 			     init_data->no_output_qs,
 			     init_data->min_input_threshold,
@@ -2636,31 +2609,21 @@
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
@@ -2670,6 +2633,20 @@
 	
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
@@ -2724,6 +2701,26 @@
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
@@ -2806,10 +2803,23 @@
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
 
@@ -2855,7 +2865,7 @@
 	int used_elements;
 
         /* This is the inbound handling of queues */
-	used_elements=atomic_return_add(count, &q->number_of_buffers_used);
+	used_elements=atomic_add_return(count, &q->number_of_buffers_used) - count;
 	
 	qdio_do_qdio_fill_input(q,qidx,count,buffers);
 	
@@ -2897,7 +2907,7 @@
 
 	qdio_do_qdio_fill_output(q,qidx,count,buffers);
 
-	used_elements=atomic_return_add(count, &q->number_of_buffers_used);
+	used_elements=atomic_add_return(count, &q->number_of_buffers_used) - count;
 
 	if (callflags&QDIO_FLAG_DONT_SIGA) {
 #ifdef QDIO_PERFORMANCE_STATS
diff -urN linux-2.6/drivers/s390/cio/qdio.h linux-2.6-s390/drivers/s390/cio/qdio.h
--- linux-2.6/drivers/s390/cio/qdio.h	Mon Sep  8 21:49:57 2003
+++ linux-2.6-s390/drivers/s390/cio/qdio.h	Thu Sep 11 19:21:26 2003
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
+++ linux-2.6-s390/drivers/s390/net/cu3088.c	Thu Sep 11 19:21:26 2003
@@ -64,7 +64,7 @@
 group_write(struct device_driver *drv, const char *buf, size_t count)
 {
 	const char *start, *end;
-	char bus_ids[2][BUS_ID_SIZE+1], *argv[2];
+	char bus_ids[2][BUS_ID_SIZE], *argv[2];
 	int i;
 	int ret;
 	struct ccwgroup_driver *cdrv;
@@ -79,7 +79,7 @@
 
 		if (!(end = strchr(start, delim[i])))
 			return count;
-		len = min_t(ptrdiff_t, BUS_ID_SIZE, end - start)+1;
+		len = min_t(ptrdiff_t, BUS_ID_SIZE, end - start + 1);
 		strlcpy (bus_ids[i], start, len);
 		argv[i] = bus_ids[i];
 		start = end + 1;
diff -urN linux-2.6/include/asm-s390/qdio.h linux-2.6-s390/include/asm-s390/qdio.h
--- linux-2.6/include/asm-s390/qdio.h	Mon Sep  8 21:49:55 2003
+++ linux-2.6-s390/include/asm-s390/qdio.h	Thu Sep 11 19:21:26 2003
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
 
