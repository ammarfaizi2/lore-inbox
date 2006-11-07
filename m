Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932688AbWKGP44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbWKGP44 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 10:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWKGPzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 10:55:54 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:32011 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932684AbWKGPzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 10:55:22 -0500
Date: Tue, 7 Nov 2006 16:55:52 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC/Patch 3/5] s390: Prepatory cleanup in common I/O layer.
Message-ID: <20061107165552.00d11781@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061107163730.0c8f3dad@gondolin.boeblingen.de.ibm.com>
References: <20061107163730.0c8f3dad@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Some preparations for the dynamic subchannel mapping patch.

- Move adding subchannel attributes to css_register_subchannel().
- Don't call device_trigger_reprobe() for non-operational devices.
- Introduce io_subchannel_create_ccwdev().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/s390/cio/css.c        |   13 +++--
 drivers/s390/cio/css.h        |    2 
 drivers/s390/cio/device.c     |  102 +++++++++++++++++++++++++-----------------
 drivers/s390/cio/device_fsm.c |    3 -
 4 files changed, 75 insertions(+), 45 deletions(-)

--- linux-2.6-CH.orig/drivers/s390/cio/css.c
+++ linux-2.6-CH/drivers/s390/cio/css.c
@@ -135,14 +135,19 @@ css_register_subchannel(struct subchanne
 	sch->dev.parent = &css[0]->device;
 	sch->dev.bus = &css_bus_type;
 	sch->dev.release = &css_subchannel_release;
-	
+
 	/* make it known to the system */
 	ret = css_sch_device_register(sch);
-	if (ret)
+	if (ret) {
 		printk (KERN_WARNING "%s: could not register %s\n",
 			__func__, sch->dev.bus_id);
-	else
-		css_get_ssd_info(sch);
+		return ret;
+	}
+	css_get_ssd_info(sch);
+	ret = subchannel_add_files(&sch->dev);
+	if (ret)
+		printk(KERN_WARNING "%s: could not add attributes to %s\n",
+		       __func__, sch->dev.bus_id);
 	return ret;
 }
 
--- linux-2.6-CH.orig/drivers/s390/cio/css.h
+++ linux-2.6-CH/drivers/s390/cio/css.h
@@ -184,4 +184,6 @@ extern int need_rescan;
 
 extern struct workqueue_struct *slow_path_wq;
 extern struct work_struct slow_path_work;
+
+int subchannel_add_files (struct device *);
 #endif
--- linux-2.6-CH.orig/drivers/s390/cio/device.c
+++ linux-2.6-CH/drivers/s390/cio/device.c
@@ -294,6 +294,16 @@ online_show (struct device *dev, struct 
 	return sprintf(buf, cdev->online ? "1\n" : "0\n");
 }
 
+static void ccw_device_unregister(void *data)
+{
+	struct ccw_device *cdev;
+
+	cdev = (struct ccw_device *)data;
+	if (test_and_clear_bit(1, &cdev->private->registered))
+		device_unregister(&cdev->dev);
+	put_device(&cdev->dev);
+}
+
 static void
 ccw_device_remove_disconnected(struct ccw_device *cdev)
 {
@@ -498,8 +508,7 @@ static struct attribute_group subch_attr
 	.attrs = subch_attrs,
 };
 
-static inline int
-subchannel_add_files (struct device *dev)
+int subchannel_add_files (struct device *dev)
 {
 	return sysfs_create_group(&dev->kobj, &subch_attr_group);
 }
@@ -673,6 +682,54 @@ ccw_device_release(struct device *dev)
 	kfree(cdev);
 }
 
+static struct ccw_device * io_subchannel_allocate_dev(struct subchannel *sch)
+{
+	struct ccw_device *cdev;
+
+	cdev  = kzalloc(sizeof(*cdev), GFP_KERNEL);
+	if (cdev) {
+		cdev->private = kzalloc(sizeof(struct ccw_device_private),
+					GFP_KERNEL | GFP_DMA);
+		if (cdev->private)
+			return cdev;
+	}
+	kfree(cdev);
+	return ERR_PTR(-ENOMEM);
+}
+
+static int io_subchannel_initialize_dev(struct subchannel *sch,
+					struct ccw_device *cdev)
+{
+	atomic_set(&cdev->private->onoff, 0);
+	cdev->dev.parent = &sch->dev;
+	cdev->dev.release = ccw_device_release;
+	INIT_LIST_HEAD(&cdev->private->kick_work.entry);
+	/* Do first half of device_register. */
+	device_initialize(&cdev->dev);
+	if (!get_device(&sch->dev)) {
+		if (cdev->dev.release)
+			cdev->dev.release(&cdev->dev);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static struct ccw_device * io_subchannel_create_ccwdev(struct subchannel *sch)
+{
+	struct ccw_device *cdev;
+	int ret;
+
+	cdev = io_subchannel_allocate_dev(sch);
+	if (!IS_ERR(cdev)) {
+		ret = io_subchannel_initialize_dev(sch, cdev);
+		if (ret) {
+			kfree(cdev);
+			cdev = ERR_PTR(ret);
+		}
+	}
+	return cdev;
+}
+
 /*
  * Register recognized device.
  */
@@ -707,11 +764,6 @@ io_subchannel_register(void *data)
 			wake_up(&ccw_device_init_wq);
 		return;
 	}
-
-	ret = subchannel_add_files(cdev->dev.parent);
-	if (ret)
-		printk(KERN_WARNING "%s: could not add attributes to %s\n",
-		       __func__, sch->dev.bus_id);
 	put_device(&cdev->dev);
 out:
 	cdev->private->flags.recog_done = 1;
@@ -831,7 +883,6 @@ io_subchannel_probe (struct subchannel *
 		cdev = sch->dev.driver_data;
 		device_initialize(&cdev->dev);
 		ccw_device_register(cdev);
-		subchannel_add_files(&sch->dev);
 		/*
 		 * Check if the device is already online. If it is
 		 * the reference count needs to be corrected
@@ -844,27 +895,9 @@ io_subchannel_probe (struct subchannel *
 			get_device(&cdev->dev);
 		return 0;
 	}
-	cdev = kzalloc (sizeof(*cdev), GFP_KERNEL);
-	if (!cdev)
-		return -ENOMEM;
-	cdev->private = kzalloc(sizeof(struct ccw_device_private),
-				GFP_KERNEL | GFP_DMA);
-	if (!cdev->private) {
-		kfree(cdev);
-		return -ENOMEM;
-	}
-	atomic_set(&cdev->private->onoff, 0);
-	cdev->dev.parent = &sch->dev;
-	cdev->dev.release = ccw_device_release;
-	INIT_LIST_HEAD(&cdev->private->kick_work.entry);
-	/* Do first half of device_register. */
-	device_initialize(&cdev->dev);
-
-	if (!get_device(&sch->dev)) {
-		if (cdev->dev.release)
-			cdev->dev.release(&cdev->dev);
-		return -ENODEV;
-	}
+	cdev = io_subchannel_create_ccwdev(sch);
+	if (IS_ERR(cdev))
+		return PTR_ERR(cdev);
 
 	rc = io_subchannel_recog(cdev, sch);
 	if (rc) {
@@ -878,17 +911,6 @@ io_subchannel_probe (struct subchannel *
 	return rc;
 }
 
-static void
-ccw_device_unregister(void *data)
-{
-	struct ccw_device *cdev;
-
-	cdev = (struct ccw_device *)data;
-	if (test_and_clear_bit(1, &cdev->private->registered))
-		device_unregister(&cdev->dev);
-	put_device(&cdev->dev);
-}
-
 static int
 io_subchannel_remove (struct subchannel *sch)
 {
--- linux-2.6-CH.orig/drivers/s390/cio/device_fsm.c
+++ linux-2.6-CH/drivers/s390/cio/device_fsm.c
@@ -1077,7 +1077,8 @@ device_trigger_reprobe(struct subchannel
 	/* Update some values. */
 	if (stsch(sch->schid, &sch->schib))
 		return;
-
+	if (!sch->schib.pmcw.dnv)
+		return;
 	/*
 	 * The pim, pam, pom values may not be accurate, but they are the best
 	 * we have before performing device selection :/
