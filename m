Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbUCAIxe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 03:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbUCAIxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 03:53:33 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:56209 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262286AbUCAIvq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 03:51:46 -0500
Date: Mon, 1 Mar 2004 09:51:34 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (2/5): common i/o layer.
Message-ID: <20040301085134.GC675@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Common i/o layer fixes:
  - Remove documentation entry for non-existent cio_notoper_msg parameter.
  - Add documentation for availability attritube.
  - Replace function of the steal_lock attribute by "echo force" to the
    online attribute.
  - Trigger device sensing in the online function for unknown devices.
  - Always try to get devices online even if they are marked reserved.
    Someone could have released the device while it was offline.
  - Add try_module_get/module_put pairs to the online function of ccw devices
    and ccwgroup devices.
  - Add owner field to ccwgroup driver structure. Set owner field in ctc, lcs
    and qeth.
  - Fix alignment problems in channel measurement block interface.

diffstat:
 Documentation/s390/CommonIO         |    9 --
 Documentation/s390/driver-model.txt |    3 
 drivers/s390/block/dasd_eckd.c      |    4 -
 drivers/s390/cio/ccwgroup.c         |   16 +++-
 drivers/s390/cio/cmf.c              |   34 ++++++---
 drivers/s390/cio/css.h              |    1 
 drivers/s390/cio/device.c           |  124 ++++++++++++------------------------
 drivers/s390/cio/device.h           |    1 
 drivers/s390/cio/device_fsm.c       |   36 +++-------
 drivers/s390/cio/device_ops.c       |    4 +
 drivers/s390/net/ctcmain.c          |    7 +-
 drivers/s390/net/lcs.c              |    5 -
 drivers/s390/net/qeth.c             |    1 
 include/asm-s390/ccwdev.h           |    2 
 include/asm-s390/ccwgroup.h         |    1 
 15 files changed, 112 insertions(+), 136 deletions(-)

diff -urN linux-2.6/Documentation/s390/CommonIO linux-2.6-s390/Documentation/s390/CommonIO
--- linux-2.6/Documentation/s390/CommonIO	Fri Feb 27 20:04:30 2004
+++ linux-2.6-s390/Documentation/s390/CommonIO	Fri Feb 27 20:05:02 2004
@@ -14,15 +14,6 @@
   Default is off.
 
 
-* cio_notoper_msg = yes | no
-
-  Determines whether messages of the type "Device 0.0.4711 became 'not
-  operational'" should be shown during startup; after startup, they will always
-  be shown.
-  
-  Default is on.
-
-
 * cio_ignore = {all} |
 	       {<device> | <range of devices>} |
 	       {!<device> | !<range of devices>}
diff -urN linux-2.6/Documentation/s390/driver-model.txt linux-2.6-s390/Documentation/s390/driver-model.txt
--- linux-2.6/Documentation/s390/driver-model.txt	Fri Feb 27 20:04:30 2004
+++ linux-2.6-s390/Documentation/s390/driver-model.txt	Fri Feb 27 20:05:02 2004
@@ -31,6 +31,9 @@
 
 devtype:    The device type / model, if applicable.
 
+availability: Can be 'good' or 'boxed'; 'no path' or 'no device' for
+	      disconnected devices.
+
 online:     An interface to set the device online and offline.
 	    In the special case of the device being disconnected (see the
 	    notify function under 1.2), piping 0 to online will focibly delete
diff -urN linux-2.6/drivers/s390/block/dasd_eckd.c linux-2.6-s390/drivers/s390/block/dasd_eckd.c
--- linux-2.6/drivers/s390/block/dasd_eckd.c	Fri Feb 27 20:04:45 2004
+++ linux-2.6-s390/drivers/s390/block/dasd_eckd.c	Fri Feb 27 20:05:02 2004
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
- * $Revision: 1.50 $
+ * $Revision: 1.51 $
  */
 
 #include <linux/config.h>
@@ -85,7 +85,7 @@
 	ret = dasd_generic_probe (cdev, &dasd_eckd_discipline);
 	if (ret)
 		return ret;
-	ccw_device_set_options(cdev, CCWDEV_DO_PATHGROUP);
+	ccw_device_set_options(cdev, CCWDEV_DO_PATHGROUP | CCWDEV_ALLOW_FORCE);
 	return 0;
 }
 
diff -urN linux-2.6/drivers/s390/cio/ccwgroup.c linux-2.6-s390/drivers/s390/cio/ccwgroup.c
--- linux-2.6/drivers/s390/cio/ccwgroup.c	Fri Feb 27 20:04:45 2004
+++ linux-2.6-s390/drivers/s390/cio/ccwgroup.c	Fri Feb 27 20:05:02 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/ccwgroup.c
  *  bus driver for ccwgroup
- *   $Revision: 1.23 $
+ *   $Revision: 1.24 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *                       IBM Corporation
@@ -293,22 +293,28 @@
 ccwgroup_online_store (struct device *dev, const char *buf, size_t count)
 {
 	struct ccwgroup_device *gdev;
+	struct ccwgroup_driver *gdrv;
 	unsigned int value;
+	int ret;
 
 	gdev = to_ccwgroupdev(dev);
 	if (!dev->driver)
 		return count;
 
-	value = simple_strtoul(buf, 0, 0);
+	gdrv = to_ccwgroupdrv (gdev->dev.driver);
+	if (!try_module_get(gdrv->owner))
+		return -EINVAL;
 
+	value = simple_strtoul(buf, 0, 0);
+	ret = count;
 	if (value == 1)
 		ccwgroup_set_online(gdev);
 	else if (value == 0)
 		ccwgroup_set_offline(gdev);
 	else
-		return -EINVAL;
-
-	return count;
+		ret = -EINVAL;
+	module_put(gdrv->owner);
+	return ret;
 }
 
 static ssize_t
diff -urN linux-2.6/drivers/s390/cio/cmf.c linux-2.6-s390/drivers/s390/cio/cmf.c
--- linux-2.6/drivers/s390/cio/cmf.c	Fri Feb 27 20:04:45 2004
+++ linux-2.6-s390/drivers/s390/cio/cmf.c	Fri Feb 27 20:05:02 2004
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/s390/cio/cmf.c ($Revision: 1.11 $)
+ * linux/drivers/s390/cio/cmf.c ($Revision: 1.13 $)
  *
  * Linux on zSeries Channel Measurement Facility support
  *
@@ -138,7 +138,7 @@
 	if (count == 0)
 		return 0;
 
-	/* value comes in units of 128 5sec */
+	/* value comes in units of 128 �sec */
 	ret = time_to_nsec(value);
 	do_div(ret, count);
 
@@ -390,12 +390,13 @@
 		WARN_ON(!list_empty(&cmb_area.list));
 
 		spin_unlock(&cmb_area.lock);
-		mem = kmalloc(size, GFP_KERNEL | GFP_DMA);
+		mem = (void*)__get_free_pages(GFP_KERNEL | GFP_DMA,
+				 get_order(size));
 		spin_lock(&cmb_area.lock);
 
 		if (cmb_area.mem) {
 			/* ok, another thread was faster */
-			kfree(mem);
+			free_pages((unsigned long)mem, get_order(size));
 		} else if (!mem) {
 			/* no luck */
 			ret = -ENOMEM;
@@ -435,8 +436,10 @@
 	list_del_init(&priv->cmb_list);
 
 	if (list_empty(&cmb_area.list)) {
+		ssize_t size;
+		size = sizeof(struct cmb) * cmb_area.num_channels;
 		cmf_activate(NULL, 0);
-		kfree(cmb_area.mem);
+		free_pages((unsigned long)cmb_area.mem, get_order(size));
 		cmb_area.mem = NULL;
 	}
 out:
@@ -595,11 +598,22 @@
 	u32 reserved[7];
 };
 
+/* kmalloc only guarantees 8 byte alignment, but we need cmbe
+ * pointers to be naturally aligned. Make sure to allocate
+ * enough space for two cmbes */
+static inline struct cmbe* cmbe_align(struct cmbe *c)
+{
+	unsigned long addr;
+	addr = ((unsigned long)c + sizeof (struct cmbe) - sizeof(long)) &
+				 ~(sizeof (struct cmbe) - sizeof(long));
+	return (struct cmbe*)addr;
+}
+
 static int
 alloc_cmbe (struct ccw_device *cdev)
 {
 	struct cmbe *cmbe;
-	cmbe = kmalloc (sizeof (*cmbe), GFP_KERNEL /* | GFP_DMA ? */);
+	cmbe = kmalloc (sizeof (*cmbe) * 2, GFP_KERNEL);
 	if (!cmbe)
 		return -ENOMEM;
 
@@ -647,7 +661,7 @@
 
 	if (!cdev->private->cmb)
 		return -EINVAL;
-	mba = mme ? (unsigned long)cdev->private->cmb : 0;
+	mba = mme ? (unsigned long) cmbe_align(cdev->private->cmb) : 0;
 
 	return set_schib_wait(cdev, mme, 1, mba);
 }
@@ -669,7 +683,7 @@
 		return 0;
 	}
 
-	cmb = *(struct cmbe*)cdev->private->cmb;
+	cmb = *cmbe_align(cdev->private->cmb);
 	spin_unlock_irqrestore(cdev->ccwlock, flags);
 
 	switch (index) {
@@ -720,7 +734,7 @@
 		return -ENODEV;
 	}
 
-	cmb = *(struct cmbe*)cdev->private->cmb;
+	cmb = *cmbe_align(cdev->private->cmb);
 	time = get_clock() - cdev->private->cmb_start_time;
 	spin_unlock_irqrestore(cdev->ccwlock, flags);
 
@@ -760,7 +774,7 @@
 {
 	struct cmbe *cmb;
 	spin_lock_irq(cdev->ccwlock);
-	cmb = cdev->private->cmb;
+	cmb = cmbe_align(cdev->private->cmb);
 	if (cmb)
 		memset (cmb, 0, sizeof (*cmb));
 	cdev->private->cmb_start_time = get_clock();
diff -urN linux-2.6/drivers/s390/cio/css.h linux-2.6-s390/drivers/s390/cio/css.h
--- linux-2.6/drivers/s390/cio/css.h	Fri Feb 27 20:04:45 2004
+++ linux-2.6-s390/drivers/s390/cio/css.h	Fri Feb 27 20:05:02 2004
@@ -74,6 +74,7 @@
 		unsigned int fast:1;	/* post with "channel end" */
 		unsigned int repall:1;	/* report every interrupt status */
 		unsigned int pgroup:1;  /* do path grouping */
+		unsigned int force:1;   /* allow forced online */
 	} __attribute__ ((packed)) options;
 	struct {
 		unsigned int pgid_single:1; /* use single path for Set PGID */
diff -urN linux-2.6/drivers/s390/cio/device.c linux-2.6-s390/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	Fri Feb 27 20:04:45 2004
+++ linux-2.6-s390/drivers/s390/cio/device.c	Fri Feb 27 20:05:02 2004
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.103 $
+ *   $Revision: 1.107 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -263,10 +263,10 @@
 
 	if (!cdev)
 		return -ENODEV;
-	if (!cdev->online || !cdev->drv)
+	if (!cdev->online)
 		return -EINVAL;
 
-	if (cdev->drv->set_offline) {
+	if (cdev->drv && cdev->drv->set_offline) {
 		ret = cdev->drv->set_offline(cdev);
 		if (ret != 0)
 			return ret;
@@ -292,7 +292,7 @@
 
 	if (!cdev)
 		return -ENODEV;
-	if (cdev->online || !cdev->drv)
+	if (cdev->online)
 		return -EINVAL;
 
 	spin_lock_irq(cdev->ccwlock);
@@ -307,7 +307,8 @@
 	}
 	if (cdev->private->state != DEV_STATE_ONLINE)
 		return -ENODEV;
-	if (!cdev->drv->set_online || cdev->drv->set_online(cdev) == 0) {
+	if (!cdev->drv || !cdev->drv->set_online ||
+	    cdev->drv->set_online(cdev) == 0) {
 		cdev->online = 1;
 		return 0;
 	}
@@ -326,52 +327,54 @@
 online_store (struct device *dev, const char *buf, size_t count)
 {
 	struct ccw_device *cdev = to_ccwdev(dev);
-	int i;
+	int i, force;
 	char *tmp;
 
-	if (!cdev->drv)
-		return count;
 	if (atomic_compare_and_swap(0, 1, &cdev->private->onoff))
 		return -EAGAIN;
 
-	i = simple_strtoul(buf, &tmp, 16);
-	if (i == 1 && cdev->drv->set_online)
+	if (cdev->drv && !try_module_get(cdev->drv->owner)) {
+		atomic_set(&cdev->private->onoff, 0);
+		return -EINVAL;
+	}
+	if (!strncmp(buf, "force\n", count)) {
+		force = 1;
+		i = 1;
+	} else {
+		force = 0;
+		i = simple_strtoul(buf, &tmp, 16);
+	}
+	if (i == 1) {
+		/* Do device recognition, if needed. */
+		if (cdev->id.cu_type == 0) {
+			ccw_device_recognition(cdev);
+			wait_event(cdev->private->wait_q,
+				   dev_fsm_final_state(cdev));
+		}
 		ccw_device_set_online(cdev);
-	else if (i == 0 && cdev->drv->set_offline) {
+	} else if (i == 0) {
 		if (cdev->private->state == DEV_STATE_DISCONNECTED)
 			ccw_device_remove_disconnected(cdev);
 		else
 			ccw_device_set_offline(cdev);
 	}
-	atomic_set(&cdev->private->onoff, 0);
-	return count;
-}
-
-static void ccw_device_unbox_recog(void *data);
-
-static ssize_t
-stlck_store(struct device *dev, const char *buf, size_t count)
-{
-	struct ccw_device *cdev = to_ccwdev(dev);
-	int ret;
-
-	/* We don't care what was piped to the attribute 8) */
-	ret = ccw_device_stlck(cdev);
-	if (ret != 0) {
-		printk(KERN_WARNING
-		       "Unconditional reserve failed on device %s, rc=%d\n",
-		       dev->bus_id, ret);
-		return ret;
+	if (force && cdev->private->state == DEV_STATE_BOXED) {
+		int ret;
+		ret = ccw_device_stlck(cdev);
+		if (ret)
+			goto out;
+		/* Do device recognition, if needed. */
+		if (cdev->id.cu_type == 0) {
+			ccw_device_recognition(cdev);
+			wait_event(cdev->private->wait_q,
+				   dev_fsm_final_state(cdev));
+		}
+		ccw_device_set_online(cdev);
 	}
-
-	/*
-	 * Device was successfully unboxed.
-	 * Trigger removal of stlck attribute and device recognition.
-	 */
-	INIT_WORK(&cdev->private->kick_work,
-		  ccw_device_unbox_recog, (void *) cdev);
-	queue_work(ccw_device_work, &cdev->private->kick_work);
-	
+	out:
+	if (cdev->drv)
+		module_put(cdev->drv->owner);
+	atomic_set(&cdev->private->onoff, 0);
 	return count;
 }
 
@@ -403,33 +406,9 @@
 static DEVICE_ATTR(devtype, 0444, devtype_show, NULL);
 static DEVICE_ATTR(cutype, 0444, cutype_show, NULL);
 static DEVICE_ATTR(online, 0644, online_show, online_store);
-static DEVICE_ATTR(steal_lock, 0200, NULL, stlck_store);
 extern struct device_attribute dev_attr_cmb_enable;
 static DEVICE_ATTR(availability, 0444, available_show, NULL);
 
-/* A device has been unboxed. Start device recognition. */
-static void
-ccw_device_unbox_recog(void *data)
-{
-	struct ccw_device *cdev;
-
-	cdev = (struct ccw_device *)data;
-	if (!cdev)
-		return;
-
-	/* Remove stlck attribute. */
-	device_remove_file(&cdev->dev, &dev_attr_steal_lock);
-
-	spin_lock_irq(cdev->ccwlock);
-
-	/* Device is no longer boxed. */
-	cdev->private->state = DEV_STATE_NOT_OPER;
-
-	/* Finally start device recognition. */
-	ccw_device_recognition(cdev);
-	spin_unlock_irq(cdev->ccwlock);
-}
-
 static struct attribute * subch_attrs[] = {
 	&dev_attr_chpids.attr,
 	&dev_attr_pimpampom.attr,
@@ -471,22 +450,6 @@
 	sysfs_remove_group(&dev->kobj, &ccwdev_attr_group);
 }
 
-/*
- * Add a "steal lock" attribute to boxed devices.
- * This allows to trigger an unconditional reserve ccw to eckd dasds
- * (if the device is something else, there should be no problems more than
- * a command reject; we don't have any means of finding out the device's
- * type if it was boxed at ipl/attach for older devices and under VM).
- */
-void
-ccw_device_add_stlck(void *data)
-{
-	struct ccw_device *cdev;
-
-	cdev = (struct ccw_device *)data;
-	device_create_file(&cdev->dev, &dev_attr_steal_lock);
-}
-
 /* this is a simple abstraction for device_register that sets the
  * correct bus type and adds the bus specific files */
 int
@@ -565,8 +528,6 @@
 	if (ret)
 		printk(KERN_WARNING "%s: could not add attributes to %s\n",
 		       __func__, sch->dev.bus_id);
-	if (cdev->private->state == DEV_STATE_BOXED)
-		device_create_file(&cdev->dev, &dev_attr_steal_lock);
 	put_device(&cdev->dev);
 out:
 	put_device(&sch->dev);
@@ -935,6 +896,7 @@
 			pr_debug("ccw_device_offline returned %d, device %s\n",
 				 ret, cdev->dev.bus_id);
 	}
+	ccw_device_set_timeout(cdev, 0);
 	cdev->drv = 0;
 	return 0;
 }
diff -urN linux-2.6/drivers/s390/cio/device.h linux-2.6-s390/drivers/s390/cio/device.h
--- linux-2.6/drivers/s390/cio/device.h	Fri Feb 27 20:04:45 2004
+++ linux-2.6-s390/drivers/s390/cio/device.h	Fri Feb 27 20:05:02 2004
@@ -102,7 +102,6 @@
 
 int ccw_device_call_handler(struct ccw_device *);
 
-void ccw_device_add_stlck(void *);
 int ccw_device_stlck(struct ccw_device *);
 
 /* qdio needs this. */
diff -urN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-s390/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	Fri Feb 27 20:04:45 2004
+++ linux-2.6-s390/drivers/s390/cio/device_fsm.c	Fri Feb 27 20:05:02 2004
@@ -317,14 +317,10 @@
 	cdev->private->state = state;
 
 
-	if (state == DEV_STATE_BOXED) {
+	if (state == DEV_STATE_BOXED)
 		CIO_DEBUG(KERN_WARNING, 2,
 			  "Boxed device %04x on subchannel %04x\n",
 			  cdev->private->devno, sch->irq);
-		INIT_WORK(&cdev->private->kick_work,
-			  ccw_device_add_stlck, (void *) cdev);
-		queue_work(ccw_device_work, &cdev->private->kick_work);
-	}
 
 	if (cdev->private->flags.donotify) {
 		cdev->private->flags.donotify = 0;
@@ -377,7 +373,8 @@
 	struct subchannel *sch;
 	int ret;
 
-	if (cdev->private->state != DEV_STATE_NOT_OPER)
+	if ((cdev->private->state != DEV_STATE_NOT_OPER) &&
+	    (cdev->private->state != DEV_STATE_BOXED))
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
 	ret = cio_enable_subchannel(sch, sch->schib.pmcw.isc);
@@ -492,7 +489,8 @@
 	struct subchannel *sch;
 	int ret;
 
-	if (cdev->private->state != DEV_STATE_OFFLINE)
+	if ((cdev->private->state != DEV_STATE_OFFLINE) &&
+	    (cdev->private->state != DEV_STATE_BOXED))
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
 	if (css_init_done && !get_device(&cdev->dev))
@@ -615,6 +613,13 @@
 	struct subchannel *sch;
 
 	sch = to_subchannel(cdev->dev.parent);
+	if (sch->driver->notify &&
+	    sch->driver->notify(&sch->dev, sch->lpm ? CIO_GONE : CIO_NO_PATH)) {
+			ccw_device_set_timeout(cdev, 0);
+			cdev->private->state = DEV_STATE_DISCONNECTED;
+			wake_up(&cdev->private->wait_q);
+			return;
+	}
 	cdev->private->state = DEV_STATE_NOT_OPER;
 	cio_disable_subchannel(sch);
 	if (sch->schib.scsw.actl != 0) {
@@ -627,21 +632,6 @@
 	wake_up(&cdev->private->wait_q);
 }
 
-static void
-ccw_device_disconnected_notoper(struct ccw_device *cdev,
-				enum dev_event dev_event)
-{
-	struct subchannel *sch;
-
-	sch = to_subchannel(cdev->dev.parent);
-	cdev->private->state = DEV_STATE_NOT_OPER;
-	cio_disable_subchannel(sch);
-	device_unregister(&sch->dev);
-	sch->schib.pmcw.intparm = 0;
-	cio_modify(sch);
-	wake_up(&cdev->private->wait_q);
-}
-
 /*
  * Handle path verification event.
  */
@@ -1103,7 +1093,7 @@
 	},
 	/* special states for devices gone not operational */
 	[DEV_STATE_DISCONNECTED] {
-		[DEV_EVENT_NOTOPER]	ccw_device_disconnected_notoper,
+		[DEV_EVENT_NOTOPER]	ccw_device_nop,
 		[DEV_EVENT_INTERRUPT]	ccw_device_start_id,
 		[DEV_EVENT_TIMEOUT]	ccw_device_bug,
 		[DEV_EVENT_VERIFY]	ccw_device_nop,
diff -urN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-s390/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	Fri Feb 27 20:04:45 2004
+++ linux-2.6-s390/drivers/s390/cio/device_ops.c	Fri Feb 27 20:05:02 2004
@@ -38,6 +38,7 @@
 	cdev->private->options.fast = (flags & CCWDEV_EARLY_NOTIFICATION) != 0;
 	cdev->private->options.repall = (flags & CCWDEV_REPORT_ALL) != 0;
 	cdev->private->options.pgroup = (flags & CCWDEV_DO_PATHGROUP) != 0;
+	cdev->private->options.force = (flags & CCWDEV_ALLOW_FORCE) != 0;
 	return 0;
 }
 
@@ -453,6 +454,9 @@
 	if (!cdev)
 		return -ENODEV;
 
+	if (cdev->drv && !cdev->private->options.force)
+		return -EINVAL;
+
 	sch = to_subchannel(cdev->dev.parent);
 	
 	CIO_TRACE_EVENT(2, "stl lock");
diff -urN linux-2.6/drivers/s390/net/ctcmain.c linux-2.6-s390/drivers/s390/net/ctcmain.c
--- linux-2.6/drivers/s390/net/ctcmain.c	Fri Feb 27 20:04:45 2004
+++ linux-2.6-s390/drivers/s390/net/ctcmain.c	Fri Feb 27 20:05:02 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.54 2004/02/18 12:35:59 ptiedem Exp $
+ * $Id: ctcmain.c,v 1.56 2004/02/27 17:53:26 mschwide Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.54 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.56 $
  *
  */
 
@@ -319,7 +319,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.54 $";
+	char vbuf[] = "$Revision: 1.56 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -3161,6 +3161,7 @@
 }
 
 static struct ccwgroup_driver ctc_group_driver = {
+	.owner       = THIS_MODULE,
 	.name        = "ctc",
 	.max_slaves  = 2,
 	.driver_id   = 0xC3E3C3,
diff -urN linux-2.6/drivers/s390/net/lcs.c linux-2.6-s390/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	Fri Feb 27 20:04:45 2004
+++ linux-2.6-s390/drivers/s390/net/lcs.c	Fri Feb 27 20:05:02 2004
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.66 $	 $Date: 2004/02/19 13:46:01 $
+ *    $Revision: 1.67 $	 $Date: 2004/02/26 18:26:50 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -58,7 +58,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.66 $"
+#define VERSION_LCS_C  "$Revision: 1.67 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 
@@ -1926,6 +1926,7 @@
  * LCS ccwgroup driver registration
  */
 static struct ccwgroup_driver lcs_group_driver = {
+	.owner       = THIS_MODULE,
 	.name        = "lcs",
 	.max_slaves  = 2,
 	.driver_id   = 0xD3C3E2,
diff -urN linux-2.6/drivers/s390/net/qeth.c linux-2.6-s390/drivers/s390/net/qeth.c
--- linux-2.6/drivers/s390/net/qeth.c	Fri Feb 27 20:04:45 2004
+++ linux-2.6-s390/drivers/s390/net/qeth.c	Fri Feb 27 20:05:02 2004
@@ -10773,6 +10773,7 @@
 }
 
 static struct ccwgroup_driver qeth_ccwgroup_driver = {
+	.owner = THIS_MODULE,
 	.name = "qeth",
 	.driver_id = 0xD8C5E3C8,
 	.probe = qeth_probe_device,
diff -urN linux-2.6/include/asm-s390/ccwdev.h linux-2.6-s390/include/asm-s390/ccwdev.h
--- linux-2.6/include/asm-s390/ccwdev.h	Wed Feb 18 04:59:19 2004
+++ linux-2.6-s390/include/asm-s390/ccwdev.h	Fri Feb 27 20:05:02 2004
@@ -118,6 +118,8 @@
 #define CCWDEV_REPORT_ALL	 	0x0002
 /* Try to perform path grouping. */
 #define CCWDEV_DO_PATHGROUP             0x0004
+/* Allow forced onlining of boxed devices. */
+#define CCWDEV_ALLOW_FORCE              0x0008
 
 /*
  * ccw_device_start()
diff -urN linux-2.6/include/asm-s390/ccwgroup.h linux-2.6-s390/include/asm-s390/ccwgroup.h
--- linux-2.6/include/asm-s390/ccwgroup.h	Fri Feb 27 20:04:46 2004
+++ linux-2.6-s390/include/asm-s390/ccwgroup.h	Fri Feb 27 20:05:02 2004
@@ -17,6 +17,7 @@
 };
 
 struct ccwgroup_driver {
+	struct module *owner;
 	char *name;
 	int max_slaves;
 	unsigned long driver_id;
