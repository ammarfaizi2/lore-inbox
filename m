Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264432AbUEMTWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbUEMTWB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264465AbUEMTTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:19:46 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:17635 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S264432AbUEMTOM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:14:12 -0400
Date: Thu, 13 May 2004 21:14:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (2/6): common i/o layer.
Message-ID: <20040513191408.GC2916@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: cio changes.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Common i/o layer changes:
 - Delay unregister/register of ccw devices reappering on a different
   subchannel. Search for the old ccw_device & subchannel for the
   reattached device and deregister it too to avoid inconsistencies.
 - Fix path grouping for devices that present command reject for
   SetPGID but not for SensePGID.

diffstat:
 drivers/s390/cio/css.c         |   23 +++++++---
 drivers/s390/cio/device.c      |   92 ++++++++++++++++++++++++++++++++++++-----
 drivers/s390/cio/device_fsm.c  |   11 +++-
 drivers/s390/cio/device_pgid.c |    4 +
 4 files changed, 110 insertions(+), 20 deletions(-)

diff -urN linux-2.6/drivers/s390/cio/css.c linux-2.6-s390/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	Mon May 10 04:32:01 2004
+++ linux-2.6-s390/drivers/s390/cio/css.c	Thu May 13 21:00:59 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/css.c
  *  driver for channel subsystem
- *   $Revision: 1.73 $
+ *   $Revision: 1.74 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -218,12 +218,21 @@
 		 * We don't notify the driver since we have to throw the device
 		 * away in any case.
 		 */
-		device_unregister(&sch->dev);
-		/* Reset intparm to zeroes. */
-		sch->schib.pmcw.intparm = 0;
-		cio_modify(sch);
-		put_device(&sch->dev);
-		ret = css_probe_device(irq);
+		if (!disc) {
+			device_unregister(&sch->dev);
+			/* Reset intparm to zeroes. */
+			sch->schib.pmcw.intparm = 0;
+			cio_modify(sch);
+			put_device(&sch->dev);
+			ret = css_probe_device(irq);
+		} else {
+			/*
+			 * We can't immediately deregister the disconnected
+			 * device since it might block.
+			 */
+			device_trigger_reprobe(sch);
+			ret = 0;
+		}
 		break;
 	case CIO_OPER:
 		if (disc)
diff -urN linux-2.6/drivers/s390/cio/device.c linux-2.6-s390/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	Mon May 10 04:32:54 2004
+++ linux-2.6-s390/drivers/s390/cio/device.c	Thu May 13 21:00:59 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.115 $
+ *   $Revision: 1.117 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -26,6 +26,7 @@
 #include "cio.h"
 #include "css.h"
 #include "device.h"
+#include "ioasm.h"
 
 /******************* bus type handling ***********************/
 
@@ -499,20 +500,93 @@
 	return ret;
 }
 
-void
-ccw_device_do_unreg_rereg(void *data)
+static struct ccw_device *
+get_disc_ccwdev_by_devno(unsigned int devno, struct ccw_device *sibling)
 {
+	struct ccw_device *cdev;
+	struct list_head *entry;
 	struct device *dev;
 
-	dev = (struct device *)data;
-	device_remove_files(dev);
-	device_del(dev);
-	if (device_add(dev)) {
+	if (!get_bus(&ccw_bus_type))
+		return NULL;
+	down_read(&ccw_bus_type.subsys.rwsem);
+	cdev = NULL;
+	list_for_each(entry, &ccw_bus_type.devices.list) {
+		dev = get_device(container_of(entry,
+					      struct device, bus_list));
+		if (!dev)
+			continue;
+		cdev = to_ccwdev(dev);
+		if ((cdev->private->state == DEV_STATE_DISCONNECTED) &&
+		    (cdev->private->devno == devno) &&
+		    (!strncmp(cdev->dev.bus_id, sibling->dev.bus_id, 4))) {
+			cdev->private->state = DEV_STATE_NOT_OPER;
+			break;
+		}
 		put_device(dev);
+		cdev = NULL;
+	}
+	up_read(&ccw_bus_type.subsys.rwsem);
+	put_bus(&ccw_bus_type);
+
+	return cdev;
+}
+
+void
+ccw_device_do_unreg_rereg(void *data)
+{
+	struct ccw_device *cdev;
+	struct subchannel *sch;
+	int need_rename;
+
+	cdev = (struct ccw_device *)data;
+	sch = to_subchannel(cdev->dev.parent);
+	if (cdev->private->devno != sch->schib.pmcw.dev) {
+		/*
+		 * The device number has changed. This is usually only when
+		 * a device has been detached under VM and then re-appeared
+		 * on another subchannel because of a different attachment
+		 * order than before. Ideally, we should should just switch
+		 * subchannels, but unfortunately, this is not possible with
+		 * the current implementation.
+		 * Instead, we search for the old subchannel for this device
+		 * number and deregister so there are no collisions with the
+		 * newly registered ccw_device.
+		 * FIXME: Find another solution so the block layer doesn't
+		 *        get possibly sick...
+		 */
+		struct ccw_device *other_cdev;
+
+		need_rename = 1;
+		other_cdev = get_disc_ccwdev_by_devno(sch->schib.pmcw.dev,
+						      cdev);
+		if (other_cdev) {
+			struct subchannel *other_sch;
+
+			other_sch = to_subchannel(other_cdev->dev.parent);
+			if (get_device(&other_sch->dev)) {
+				stsch(other_sch->irq, &other_sch->schib);
+				if (other_sch->schib.pmcw.dnv) {
+					other_sch->schib.pmcw.intparm = 0;
+					cio_modify(other_sch);
+				}
+				device_unregister(&other_sch->dev);
+			}
+		}
+		cdev->private->devno = sch->schib.pmcw.dev;
+	} else
+		need_rename = 0;
+	device_remove_files(&cdev->dev);
+	device_del(&cdev->dev);
+	if (need_rename)
+		snprintf (cdev->dev.bus_id, BUS_ID_SIZE, "0.0.%04x",
+			  sch->schib.pmcw.dev);
+	if (device_add(&cdev->dev)) {
+		put_device(&cdev->dev);
 		return;
 	}
-	if (device_add_files(dev))
-		device_unregister(dev);
+	if (device_add_files(&cdev->dev))
+		device_unregister(&cdev->dev);
 }
 
 static void
diff -urN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-s390/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	Mon May 10 04:32:37 2004
+++ linux-2.6-s390/drivers/s390/cio/device_fsm.c	Thu May 13 21:00:59 2004
@@ -152,14 +152,15 @@
 	/*
 	 * Check if cu type and device type still match. If
 	 * not, it is certainly another device and we have to
-	 * de- and re-register.
+	 * de- and re-register. Also check here for non-matching devno.
 	 */
 	if (cdev->id.cu_type != cdev->private->senseid.cu_type ||
 	    cdev->id.cu_model != cdev->private->senseid.cu_model ||
 	    cdev->id.dev_type != cdev->private->senseid.dev_type ||
-	    cdev->id.dev_model != cdev->private->senseid.dev_model) {
+	    cdev->id.dev_model != cdev->private->senseid.dev_model ||
+	    cdev->private->devno != sch->schib.pmcw.dev) {
 		PREPARE_WORK(&cdev->private->kick_work,
-			     ccw_device_do_unreg_rereg, (void *)&cdev->dev);
+			     ccw_device_do_unreg_rereg, (void *)cdev);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
 		return;
 	}
@@ -295,7 +296,7 @@
 		sch->driver->notify(&sch->dev, CIO_OPER) : 0;
 	if (!ret)
 		/* Driver doesn't want device back. */
-		ccw_device_do_unreg_rereg((void *)&cdev->dev);
+		ccw_device_do_unreg_rereg((void *)cdev);
 	else
 		wake_up(&cdev->private->wait_q);
 }
@@ -476,6 +477,8 @@
 {
 	cdev->private->flags.doverify = 0;
 	switch (err) {
+	case -EOPNOTSUPP: /* path grouping not supported, just set online. */
+		cdev->private->options.pgroup = 0;
 	case 0:
 		ccw_device_done(cdev, DEV_STATE_ONLINE);
 		break;
diff -urN linux-2.6/drivers/s390/cio/device_pgid.c linux-2.6-s390/drivers/s390/cio/device_pgid.c
--- linux-2.6/drivers/s390/cio/device_pgid.c	Mon May 10 04:32:38 2004
+++ linux-2.6-s390/drivers/s390/cio/device_pgid.c	Thu May 13 21:00:59 2004
@@ -338,6 +338,10 @@
 		 * One of those strange devices which claim to be able
 		 * to do multipathing but not for Set Path Group ID.
 		 */
+		if (cdev->private->flags.pgid_single) {
+			ccw_device_verify_done(cdev, -EOPNOTSUPP);
+			break;
+		}
 		cdev->private->flags.pgid_single = 1;
 		/* fall through. */
 	case -EAGAIN:		/* Try again. */
