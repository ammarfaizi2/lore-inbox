Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932686AbWKGPzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbWKGPzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 10:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbWKGPzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 10:55:49 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:34315 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932686AbWKGPzb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 10:55:31 -0500
Date: Tue, 7 Nov 2006 16:56:00 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC/Patch 5/5] s390: Dynamic subchannel mapping of ccw devices.
Message-ID: <20061107165600.613d29cd@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061107163730.0c8f3dad@gondolin.boeblingen.de.ibm.com>
References: <20061107163730.0c8f3dad@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Support for disconnected devices reappearing on another subchannel:
- create a 'pseudo_subchannel' per channel subsystem (the 'orphanage')
- use the orphanage as a shelter for ccw_devices that can't remain on the same
  subchannel

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/s390/cio/cio.c        |    6 
 drivers/s390/cio/cio.h        |    2 
 drivers/s390/cio/css.c        |   37 ++++-
 drivers/s390/cio/css.h        |    4 
 drivers/s390/cio/device.c     |  294 +++++++++++++++++++++++++++++++++++-------
 drivers/s390/cio/device.h     |    2 
 drivers/s390/cio/device_fsm.c |   17 +-
 7 files changed, 306 insertions(+), 56 deletions(-)

--- linux-2.6-CH.orig/drivers/s390/cio/cio.c
+++ linux-2.6-CH/drivers/s390/cio/cio.c
@@ -413,6 +413,8 @@ cio_enable_subchannel (struct subchannel
 	CIO_TRACE_EVENT (2, "ensch");
 	CIO_TRACE_EVENT (2, sch->dev.bus_id);
 
+	if (sch_is_pseudo_sch(sch))
+		return -EINVAL;
 	ccode = stsch (sch->schid, &sch->schib);
 	if (ccode)
 		return -ENODEV;
@@ -460,6 +462,8 @@ cio_disable_subchannel (struct subchanne
 	CIO_TRACE_EVENT (2, "dissch");
 	CIO_TRACE_EVENT (2, sch->dev.bus_id);
 
+	if (sch_is_pseudo_sch(sch))
+		return 0;
 	ccode = stsch (sch->schid, &sch->schib);
 	if (ccode == 3)		/* Not operational. */
 		return -ENODEV;
@@ -494,7 +498,7 @@ cio_disable_subchannel (struct subchanne
 	return ret;
 }
 
-static int cio_create_sch_lock(struct subchannel *sch)
+int cio_create_sch_lock(struct subchannel *sch)
 {
 	sch->lock = kmalloc(sizeof(spinlock_t), GFP_KERNEL);
 	if (!sch->lock)
--- linux-2.6-CH.orig/drivers/s390/cio/css.c
+++ linux-2.6-CH/drivers/s390/cio/css.c
@@ -581,12 +581,24 @@ css_cm_enable_store(struct device *dev, 
 
 static DEVICE_ATTR(cm_enable, 0644, css_cm_enable_show, css_cm_enable_store);
 
-static inline void __init
-setup_css(int nr)
+static inline int __init setup_css(int nr)
 {
 	u32 tod_high;
+	int ret;
 
 	memset(css[nr], 0, sizeof(struct channel_subsystem));
+	css[nr]->pseudo_subchannel =
+		kzalloc(sizeof(*css[nr]->pseudo_subchannel), GFP_KERNEL);
+	if (!css[nr]->pseudo_subchannel)
+		return -ENOMEM;
+	css[nr]->pseudo_subchannel->dev.parent = &css[nr]->device;
+	css[nr]->pseudo_subchannel->dev.release = css_subchannel_release;
+	sprintf(css[nr]->pseudo_subchannel->dev.bus_id, "defunct");
+	ret = cio_create_sch_lock(css[nr]->pseudo_subchannel);
+	if (ret) {
+		kfree(css[nr]->pseudo_subchannel);
+		return ret;
+	}
 	mutex_init(&css[nr]->mutex);
 	css[nr]->valid = 1;
 	css[nr]->cssid = nr;
@@ -594,6 +606,7 @@ setup_css(int nr)
 	css[nr]->device.release = channel_subsystem_release;
 	tod_high = (u32) (get_clock() >> 32);
 	css_generate_pgid(css[nr], tod_high);
+	return 0;
 }
 
 /*
@@ -630,10 +643,12 @@ init_channel_subsystem (void)
 			ret = -ENOMEM;
 			goto out_unregister;
 		}
-		setup_css(i);
-		ret = device_register(&css[i]->device);
+		ret = setup_css(i);
 		if (ret)
 			goto out_free;
+		ret = device_register(&css[i]->device);
+		if (ret)
+			goto out_free_all;
 		if (css_characteristics_avail &&
 		    css_chsc_characteristics.secm) {
 			ret = device_create_file(&css[i]->device,
@@ -641,6 +656,9 @@ init_channel_subsystem (void)
 			if (ret)
 				goto out_device;
 		}
+		ret = device_register(&css[i]->pseudo_subchannel->dev);
+		if (ret)
+			goto out_file;
 	}
 	css_init_done = 1;
 
@@ -648,13 +666,19 @@ init_channel_subsystem (void)
 
 	for_each_subchannel(__init_channel_subsystem, NULL);
 	return 0;
+out_file:
+	device_remove_file(&css[i]->device, &dev_attr_cm_enable);
 out_device:
 	device_unregister(&css[i]->device);
+out_free_all:
+	kfree(css[i]->pseudo_subchannel->lock);
+	kfree(css[i]->pseudo_subchannel);
 out_free:
 	kfree(css[i]);
 out_unregister:
 	while (i > 0) {
 		i--;
+		device_unregister(&css[i]->pseudo_subchannel->dev);
 		if (css_characteristics_avail && css_chsc_characteristics.secm)
 			device_remove_file(&css[i]->device,
 					   &dev_attr_cm_enable);
@@ -666,6 +690,11 @@ out:
 	return ret;
 }
 
+int sch_is_pseudo_sch(struct subchannel *sch)
+{
+	return sch == to_css(sch->dev.parent)->pseudo_subchannel;
+}
+
 /*
  * find a driver for a subchannel. They identify by the subchannel
  * type with the exception that the console subchannel driver has its own
--- linux-2.6-CH.orig/drivers/s390/cio/css.h
+++ linux-2.6-CH/drivers/s390/cio/css.h
@@ -157,6 +157,8 @@ struct channel_subsystem {
 	int cm_enabled;
 	void *cub_addr1;
 	void *cub_addr2;
+	/* for orphaned ccw devices */
+	struct subchannel *pseudo_subchannel;
 };
 #define to_css(dev) container_of(dev, struct channel_subsystem, device)
 
@@ -182,6 +184,8 @@ void css_clear_subchannel_slow_list(void
 int css_slow_subchannels_exist(void);
 extern int need_rescan;
 
+int sch_is_pseudo_sch(struct subchannel *);
+
 extern struct workqueue_struct *slow_path_wq;
 extern struct work_struct slow_path_work;
 
--- linux-2.6-CH.orig/drivers/s390/cio/device.c
+++ linux-2.6-CH/drivers/s390/cio/device.c
@@ -23,6 +23,7 @@
 #include <asm/param.h>		/* HZ */
 
 #include "cio.h"
+#include "cio_debug.h"
 #include "css.h"
 #include "device.h"
 #include "ioasm.h"
@@ -294,6 +295,11 @@ online_show (struct device *dev, struct 
 	return sprintf(buf, cdev->online ? "1\n" : "0\n");
 }
 
+int ccw_device_is_orphan(struct ccw_device *cdev)
+{
+	return sch_is_pseudo_sch(to_subchannel(cdev->dev.parent));
+}
+
 static void ccw_device_unregister(void *data)
 {
 	struct ccw_device *cdev;
@@ -308,10 +314,23 @@ static void
 ccw_device_remove_disconnected(struct ccw_device *cdev)
 {
 	struct subchannel *sch;
+	unsigned long flags;
 	/*
 	 * Forced offline in disconnected state means
 	 * 'throw away device'.
 	 */
+	if (ccw_device_is_orphan(cdev)) {
+		/* Deregister ccw device. */
+		spin_lock_irqsave(cdev->ccwlock, flags);
+		cdev->private->state = DEV_STATE_NOT_OPER;
+		spin_unlock_irqrestore(cdev->ccwlock, flags);
+		if (get_device(&cdev->dev)) {
+			PREPARE_WORK(&cdev->private->kick_work,
+				     ccw_device_unregister, cdev);
+			queue_work(ccw_device_work, &cdev->private->kick_work);
+		}
+		return ;
+	}
 	sch = to_subchannel(cdev->dev.parent);
 	css_sch_device_unregister(sch);
 	/* Reset intparm to zeroes. */
@@ -472,6 +491,8 @@ available_show (struct device *dev, stru
 	struct ccw_device *cdev = to_ccwdev(dev);
 	struct subchannel *sch;
 
+	if (ccw_device_is_orphan(cdev))
+		return sprintf(buf, "no device\n");
 	switch (cdev->private->state) {
 	case DEV_STATE_BOXED:
 		return sprintf(buf, "boxed\n");
@@ -572,11 +593,10 @@ match_devno(struct device * dev, void * 
 
 	cdev = to_ccwdev(dev);
 	if ((cdev->private->state == DEV_STATE_DISCONNECTED) &&
+	    !ccw_device_is_orphan(cdev) &&
 	    ccw_dev_id_is_equal(&cdev->private->dev_id, &d->dev_id) &&
-	    (cdev != d->sibling)) {
-		cdev->private->state = DEV_STATE_NOT_OPER;
+	    (cdev != d->sibling))
 		return 1;
-	}
 	return 0;
 }
 
@@ -593,6 +613,28 @@ static struct ccw_device * get_disc_ccwd
 	return dev ? to_ccwdev(dev) : NULL;
 }
 
+static int match_orphan(struct device *dev, void *data)
+{
+	struct ccw_dev_id *dev_id;
+	struct ccw_device *cdev;
+
+	dev_id = data;
+	cdev = to_ccwdev(dev);
+	return ccw_dev_id_is_equal(&cdev->private->dev_id, dev_id);
+}
+
+static struct ccw_device *
+get_orphaned_ccwdev_by_dev_id(struct channel_subsystem *css,
+			      struct ccw_dev_id *dev_id)
+{
+	struct device *dev;
+
+	dev = device_find_child(&css->pseudo_subchannel->dev, dev_id,
+				match_orphan);
+
+	return dev ? to_ccwdev(dev) : NULL;
+}
+
 static void
 ccw_device_add_changed(void *data)
 {
@@ -611,62 +653,18 @@ ccw_device_add_changed(void *data)
 	}
 }
 
-extern int css_get_ssd_info(struct subchannel *sch);
-
 void
 ccw_device_do_unreg_rereg(void *data)
 {
 	struct ccw_device *cdev;
 	struct subchannel *sch;
-	int need_rename;
 
 	cdev = data;
 	sch = to_subchannel(cdev->dev.parent);
-	if (cdev->private->dev_id.devno != sch->schib.pmcw.dev) {
-		/*
-		 * The device number has changed. This is usually only when
-		 * a device has been detached under VM and then re-appeared
-		 * on another subchannel because of a different attachment
-		 * order than before. Ideally, we should should just switch
-		 * subchannels, but unfortunately, this is not possible with
-		 * the current implementation.
-		 * Instead, we search for the old subchannel for this device
-		 * number and deregister so there are no collisions with the
-		 * newly registered ccw_device.
-		 * FIXME: Find another solution so the block layer doesn't
-		 *        get possibly sick...
-		 */
-		struct ccw_device *other_cdev;
-		struct ccw_dev_id dev_id;
 
-		need_rename = 1;
-		dev_id.devno = sch->schib.pmcw.dev;
-		dev_id.ssid = sch->schid.ssid;
-		other_cdev = get_disc_ccwdev_by_dev_id(&dev_id, cdev);
-		if (other_cdev) {
-			struct subchannel *other_sch;
-
-			other_sch = to_subchannel(other_cdev->dev.parent);
-			if (get_device(&other_sch->dev)) {
-				stsch(other_sch->schid, &other_sch->schib);
-				if (other_sch->schib.pmcw.dnv) {
-					other_sch->schib.pmcw.intparm = 0;
-					cio_modify(other_sch);
-				}
-				css_sch_device_unregister(other_sch);
-			}
-		}
-		/* Update ssd info here. */
-		css_get_ssd_info(sch);
-		cdev->private->dev_id.devno = sch->schib.pmcw.dev;
-	} else
-		need_rename = 0;
 	device_remove_files(&cdev->dev);
 	if (test_and_clear_bit(1, &cdev->private->registered))
 		device_del(&cdev->dev);
-	if (need_rename)
-		snprintf (cdev->dev.bus_id, BUS_ID_SIZE, "0.%x.%04x",
-			  sch->schid.ssid, sch->schib.pmcw.dev);
 	PREPARE_WORK(&cdev->private->kick_work,
 		     ccw_device_add_changed, cdev);
 	queue_work(ccw_device_work, &cdev->private->kick_work);
@@ -730,6 +728,129 @@ static struct ccw_device * io_subchannel
 	return cdev;
 }
 
+static int io_subchannel_recog(struct ccw_device *, struct subchannel *);
+
+static void sch_attach_device(struct subchannel *sch,
+			      struct ccw_device *cdev)
+{
+	spin_lock_irq(sch->lock);
+	sch->dev.driver_data = cdev;
+	cdev->private->schid = sch->schid;
+	cdev->ccwlock = sch->lock;
+	device_trigger_reprobe(sch);
+	spin_unlock_irq(sch->lock);
+}
+
+static void sch_attach_disconnected_device(struct subchannel *sch,
+					   struct ccw_device *cdev)
+{
+	struct subchannel *other_sch;
+	int ret;
+
+	other_sch = to_subchannel(get_device(cdev->dev.parent));
+	ret = device_move(&cdev->dev, &sch->dev);
+	if (ret) {
+		CIO_MSG_EVENT(2, "Moving disconnected device 0.%x.%04x failed "
+			      "(ret=%d)!\n", cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno, ret);
+		put_device(&other_sch->dev);
+		return;
+	}
+	other_sch->dev.driver_data = NULL;
+	/* No need to keep a subchannel without ccw device around. */
+	css_sch_device_unregister(other_sch);
+	put_device(&other_sch->dev);
+	sch_attach_device(sch, cdev);
+}
+
+static void sch_attach_orphaned_device(struct subchannel *sch,
+				       struct ccw_device *cdev)
+{
+	int ret;
+
+	/* Try to move the ccw device to its new subchannel. */
+	ret = device_move(&cdev->dev, &sch->dev);
+	if (ret) {
+		CIO_MSG_EVENT(0, "Moving device 0.%x.%04x from orphanage "
+			      "failed (ret=%d)!\n",
+			      cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno, ret);
+		return;
+	}
+	sch_attach_device(sch, cdev);
+}
+
+static void sch_create_and_recog_new_device(struct subchannel *sch)
+{
+	struct ccw_device *cdev;
+
+	/* Need to allocate a new ccw device. */
+	cdev = io_subchannel_create_ccwdev(sch);
+	if (IS_ERR(cdev)) {
+		/* OK, we did everything we could... */
+		css_sch_device_unregister(sch);
+		return;
+	}
+	spin_lock_irq(sch->lock);
+	sch->dev.driver_data = cdev;
+	spin_unlock_irq(sch->lock);
+	/* Start recognition for the new ccw device. */
+	if (io_subchannel_recog(cdev, sch)) {
+		spin_lock_irq(sch->lock);
+		sch->dev.driver_data = NULL;
+		spin_unlock_irq(sch->lock);
+		if (cdev->dev.release)
+			cdev->dev.release(&cdev->dev);
+		css_sch_device_unregister(sch);
+	}
+}
+
+
+void ccw_device_move_to_orphanage(void *data)
+{
+	struct ccw_device *cdev;
+	struct ccw_device *replacing_cdev;
+	struct subchannel *sch;
+	int ret;
+	struct channel_subsystem *css;
+	struct ccw_dev_id dev_id;
+
+	cdev = (struct ccw_device *) data;
+	sch = to_subchannel(cdev->dev.parent);
+	css = to_css(sch->dev.parent);
+	dev_id.devno = sch->schib.pmcw.dev;
+	dev_id.ssid = sch->schid.ssid;
+
+	/*
+	 * Move the orphaned ccw device to the orphanage so the replacing
+	 * ccw device can take its place on the subchannel.
+	 */
+	ret = device_move(&cdev->dev, &css->pseudo_subchannel->dev);
+	if (ret) {
+		CIO_MSG_EVENT(0, "Moving device 0.%x.%04x to orphanage failed "
+			      "(ret=%d)!\n", cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno, ret);
+		return;
+	}
+	cdev->ccwlock = css->pseudo_subchannel->lock;
+	/*
+	 * Search for the replacing ccw device
+	 * - among the disconnected devices
+	 * - in the orphanage
+	 */
+	replacing_cdev = get_disc_ccwdev_by_dev_id(&dev_id, cdev);
+	if (replacing_cdev) {
+		sch_attach_disconnected_device(sch, replacing_cdev);
+		return;
+	}
+	replacing_cdev = get_orphaned_ccwdev_by_dev_id(css, &dev_id);
+	if (replacing_cdev) {
+		sch_attach_orphaned_device(sch, replacing_cdev);
+		return;
+	}
+	sch_create_and_recog_new_device(sch);
+}
+
 /*
  * Register recognized device.
  */
@@ -867,12 +988,61 @@ io_subchannel_recog(struct ccw_device *c
 	return rc;
 }
 
+struct device_pair_struct {
+	struct ccw_device *cdev;
+	struct subchannel *sch;
+};
+
+static void ccw_device_move_to_sch(void *data)
+{
+	struct device_pair_struct *device_pair;
+	int rc;
+	struct subchannel *sch;
+	struct ccw_device *cdev;
+	struct subchannel *former_parent;
+
+	device_pair = data;
+	sch = device_pair->sch;
+	cdev = device_pair->cdev;
+	former_parent = ccw_device_is_orphan(cdev) ?
+		NULL : to_subchannel(get_device(cdev->dev.parent));
+	mutex_lock(&sch->reg_mutex);
+	/* Try to move the ccw device to its new subchannel. */
+	rc = device_move(&cdev->dev, &sch->dev);
+	mutex_unlock(&sch->reg_mutex);
+	if (rc) {
+		CIO_MSG_EVENT(2, "Moving device 0.%x.%04x to subchannel "
+			      "0.%x.%04x failed (ret=%d)!\n",
+			      cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno, sch->schid.ssid,
+			      sch->schid.sch_no, rc);
+		css_sch_device_unregister(sch);
+		goto out;
+	}
+	if (former_parent) {
+		spin_lock_irq(former_parent->lock);
+		former_parent->dev.driver_data = NULL;
+		spin_unlock_irq(former_parent->lock);
+		css_sch_device_unregister(former_parent);
+		/* Reset intparm to zeroes. */
+		former_parent->schib.pmcw.intparm = 0;
+		cio_modify(former_parent);
+	}
+	sch_attach_device(sch, cdev);
+out:
+	if (former_parent)
+		put_device(&former_parent->dev);
+	put_device(&cdev->dev);
+	kfree(device_pair);
+}
+
 static int
 io_subchannel_probe (struct subchannel *sch)
 {
 	struct ccw_device *cdev;
 	int rc;
 	unsigned long flags;
+	struct ccw_dev_id dev_id;
 
 	if (sch->dev.driver_data) {
 		/*
@@ -895,6 +1065,36 @@ io_subchannel_probe (struct subchannel *
 			get_device(&cdev->dev);
 		return 0;
 	}
+	/*
+	 * First check if a fitting device may be found amongst the
+	 * disconnected devices or in the orphanage.
+	 */
+	dev_id.devno = sch->schib.pmcw.dev;
+	dev_id.ssid = sch->schid.ssid;
+	cdev = get_disc_ccwdev_by_dev_id(&dev_id, NULL);
+	if (!cdev)
+		cdev = get_orphaned_ccwdev_by_dev_id(to_css(sch->dev.parent),
+						     &dev_id);
+	if (cdev) {
+		/*
+		 * Schedule moving the device until when we have a registered
+		 * subchannel to move to and succeed the probe. We can
+		 * unregister later again, when the probe is through.
+		 */
+		struct device_pair_struct *device_pair;
+
+		device_pair = kmalloc(sizeof(*device_pair), GFP_KERNEL);
+		if (!device_pair) {
+			put_device(&cdev->dev);
+			return -ENOMEM;
+		}
+		device_pair->cdev = cdev;
+		device_pair->sch = sch;
+		PREPARE_WORK(&cdev->private->kick_work,
+			     ccw_device_move_to_sch, device_pair);
+		queue_work(slow_path_wq, &cdev->private->kick_work);
+		return 0;
+	}
 	cdev = io_subchannel_create_ccwdev(sch);
 	if (IS_ERR(cdev))
 		return PTR_ERR(cdev);
--- linux-2.6-CH.orig/drivers/s390/cio/device.h
+++ linux-2.6-CH/drivers/s390/cio/device.h
@@ -80,6 +80,8 @@ int ccw_device_cancel_halt_clear(struct 
 
 void ccw_device_do_unreg_rereg(void *);
 void ccw_device_call_sch_unregister(void *);
+void ccw_device_move_to_orphanage(void *);
+int ccw_device_is_orphan(struct ccw_device *);
 
 int ccw_device_recognition(struct ccw_device *);
 int ccw_device_online(struct ccw_device *);
--- linux-2.6-CH.orig/drivers/s390/cio/device_fsm.c
+++ linux-2.6-CH/drivers/s390/cio/device_fsm.c
@@ -165,13 +165,12 @@ ccw_device_handle_oper(struct ccw_device
 	/*
 	 * Check if cu type and device type still match. If
 	 * not, it is certainly another device and we have to
-	 * de- and re-register. Also check here for non-matching devno.
+	 * de- and re-register.
 	 */
 	if (cdev->id.cu_type != cdev->private->senseid.cu_type ||
 	    cdev->id.cu_model != cdev->private->senseid.cu_model ||
 	    cdev->id.dev_type != cdev->private->senseid.dev_type ||
-	    cdev->id.dev_model != cdev->private->senseid.dev_model ||
-	    cdev->private->dev_id.devno != sch->schib.pmcw.dev) {
+	    cdev->id.dev_model != cdev->private->senseid.dev_model) {
 		PREPARE_WORK(&cdev->private->kick_work,
 			     ccw_device_do_unreg_rereg, cdev);
 		queue_work(ccw_device_work, &cdev->private->kick_work);
@@ -653,6 +652,10 @@ ccw_device_offline(struct ccw_device *cd
 {
 	struct subchannel *sch;
 
+	if (ccw_device_is_orphan(cdev)) {
+		ccw_device_done(cdev, DEV_STATE_OFFLINE);
+		return 0;
+	}
 	sch = to_subchannel(cdev->dev.parent);
 	if (stsch(sch->schid, &sch->schib) || !sch->schib.pmcw.dnv)
 		return -ENODEV;
@@ -1092,7 +1095,13 @@ device_trigger_reprobe(struct subchannel
 		sch->schib.pmcw.mp = 1;
 	sch->schib.pmcw.intparm = (__u32)(unsigned long)sch;
 	/* We should also udate ssd info, but this has to wait. */
-	ccw_device_start_id(cdev, 0);
+	/* Check if this is another device which appeared on the same sch. */
+	if (sch->schib.pmcw.dev != cdev->private->dev_id.devno) {
+		PREPARE_WORK(&cdev->private->kick_work,
+			     ccw_device_move_to_orphanage, cdev);
+		queue_work(ccw_device_work, &cdev->private->kick_work);
+	} else
+		ccw_device_start_id(cdev, 0);
 }
 
 static void
--- linux-2.6-CH.orig/drivers/s390/cio/cio.h
+++ linux-2.6-CH/drivers/s390/cio/cio.h
@@ -131,6 +131,8 @@ extern int cio_set_options (struct subch
 extern int cio_get_options (struct subchannel *);
 extern int cio_modify (struct subchannel *);
 
+int cio_create_sch_lock(struct subchannel *);
+
 /* Use with care. */
 #ifdef CONFIG_CCW_CONSOLE
 extern struct subchannel *cio_probe_console(void);
