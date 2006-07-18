Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWGRL4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWGRL4m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 07:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWGRL4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 07:56:42 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:32529 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751321AbWGRL4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 07:56:40 -0400
Date: Tue, 18 Jul 2006 13:56:47 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch 6/6] s390: sysfs_create_xxx return values.
Message-ID: <20060718115647.GF20884@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] sysfs_create_xxx return values.

Take return values of sysfs_create_group & friends into account.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/setup.c       |   46 ++++++++++++++++++++++++++++--------
 drivers/s390/char/raw3270.c    |   52 +++++++++++++++++++++++++++--------------
 drivers/s390/char/tape_class.c |   10 +++++++
 drivers/s390/char/tape_core.c  |   18 ++++++++------
 drivers/s390/net/ctcmain.c     |   21 +++++++++++++---
 drivers/s390/net/qeth_main.c   |    7 +++--
 6 files changed, 112 insertions(+), 42 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2006-07-18 13:40:23.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2006-07-18 13:40:48.000000000 +0200
@@ -877,31 +877,57 @@ static struct bin_attribute ipl_scp_data
 
 static decl_subsys(ipl, NULL, NULL);
 
+static int ipl_register_fcp_files(void)
+{
+	int rc;
+
+	rc = sysfs_create_group(&ipl_subsys.kset.kobj,
+				&ipl_fcp_attr_group);
+	if (rc)
+		goto out;
+	rc = sysfs_create_bin_file(&ipl_subsys.kset.kobj,
+				   &ipl_parameter_attr);
+	if (rc)
+		goto out_ipl_parm;
+	rc = sysfs_create_bin_file(&ipl_subsys.kset.kobj,
+				   &ipl_scp_data_attr);
+	if (!rc)
+		goto out;
+
+	sysfs_remove_bin_file(&ipl_subsys.kset.kobj, &ipl_parameter_attr);
+
+out_ipl_parm:
+	sysfs_remove_group(&ipl_subsys.kset.kobj, &ipl_fcp_attr_group);
+out:
+	return rc;
+}
+
 static int __init
 ipl_device_sysfs_register(void) {
 	int rc;
 
 	rc = firmware_register(&ipl_subsys);
 	if (rc)
-		return rc;
+		goto out;
 
 	switch (get_ipl_type()) {
 	case ipl_type_ccw:
-		sysfs_create_group(&ipl_subsys.kset.kobj, &ipl_ccw_attr_group);
+		rc = sysfs_create_group(&ipl_subsys.kset.kobj,
+					&ipl_ccw_attr_group);
 		break;
 	case ipl_type_fcp:
-		sysfs_create_group(&ipl_subsys.kset.kobj, &ipl_fcp_attr_group);
-		sysfs_create_bin_file(&ipl_subsys.kset.kobj,
-				      &ipl_parameter_attr);
-		sysfs_create_bin_file(&ipl_subsys.kset.kobj,
-				      &ipl_scp_data_attr);
+		rc = ipl_register_fcp_files();
 		break;
 	default:
-		sysfs_create_group(&ipl_subsys.kset.kobj,
-				   &ipl_unknown_attr_group);
+		rc = sysfs_create_group(&ipl_subsys.kset.kobj,
+					&ipl_unknown_attr_group);
 		break;
 	}
-	return 0;
+
+	if (rc)
+		firmware_unregister(&ipl_subsys);
+out:
+	return rc;
 }
 
 __initcall(ipl_device_sysfs_register);
diff -urpN linux-2.6/drivers/s390/char/raw3270.c linux-2.6-patched/drivers/s390/char/raw3270.c
--- linux-2.6/drivers/s390/char/raw3270.c	2006-07-18 13:40:28.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/raw3270.c	2006-07-18 13:40:48.000000000 +0200
@@ -1106,10 +1106,10 @@ raw3270_delete_device(struct raw3270 *rp
 
 	/* Remove from device chain. */
 	mutex_lock(&raw3270_mutex);
-	if (rp->clttydev)
+	if (rp->clttydev && !IS_ERR(rp->clttydev))
 		class_device_destroy(class3270,
 				     MKDEV(IBM_TTY3270_MAJOR, rp->minor));
-	if (rp->cltubdev)
+	if (rp->cltubdev && !IS_ERR(rp->cltubdev))
 		class_device_destroy(class3270,
 				     MKDEV(IBM_FS3270_MAJOR, rp->minor));
 	list_del_init(&rp->list);
@@ -1173,21 +1173,37 @@ static struct attribute_group raw3270_at
 	.attrs = raw3270_attrs,
 };
 
-static void
-raw3270_create_attributes(struct raw3270 *rp)
+static int raw3270_create_attributes(struct raw3270 *rp)
 {
-	//FIXME: check return code
-	sysfs_create_group(&rp->cdev->dev.kobj, &raw3270_attr_group);
-	rp->clttydev =
-		class_device_create(class3270, NULL,
-				    MKDEV(IBM_TTY3270_MAJOR, rp->minor),
-				    &rp->cdev->dev, "tty%s",
-				    rp->cdev->dev.bus_id);
-	rp->cltubdev =
-		class_device_create(class3270, NULL,
-				    MKDEV(IBM_FS3270_MAJOR, rp->minor),
-				    &rp->cdev->dev, "tub%s",
-				    rp->cdev->dev.bus_id);
+	int rc;
+
+	rc = sysfs_create_group(&rp->cdev->dev.kobj, &raw3270_attr_group);
+	if (rc)
+		goto out;
+
+	rp->clttydev = class_device_create(class3270, NULL,
+					   MKDEV(IBM_TTY3270_MAJOR, rp->minor),
+					   &rp->cdev->dev, "tty%s",
+					   rp->cdev->dev.bus_id);
+	if (IS_ERR(rp->clttydev)) {
+		rc = PTR_ERR(rp->clttydev);
+		goto out_ttydev;
+	}
+
+	rp->cltubdev = class_device_create(class3270, NULL,
+					   MKDEV(IBM_FS3270_MAJOR, rp->minor),
+					   &rp->cdev->dev, "tub%s",
+					   rp->cdev->dev.bus_id);
+	if (!IS_ERR(rp->cltubdev))
+		goto out;
+
+	rc = PTR_ERR(rp->cltubdev);
+	class_device_destroy(class3270, MKDEV(IBM_TTY3270_MAJOR, rp->minor));
+
+out_ttydev:
+	sysfs_remove_group(&rp->cdev->dev.kobj, &raw3270_attr_group);
+out:
+	return rc;
 }
 
 /*
@@ -1255,7 +1271,9 @@ raw3270_set_online (struct ccw_device *c
 	rc = raw3270_reset_device(rp);
 	if (rc)
 		goto failure;
-	raw3270_create_attributes(rp);
+	rc = raw3270_create_attributes(rp);
+	if (rc)
+		goto failure;
 	set_bit(RAW3270_FLAGS_READY, &rp->flags);
 	mutex_lock(&raw3270_mutex);
 	list_for_each_entry(np, &raw3270_notifier, list)
diff -urpN linux-2.6/drivers/s390/char/tape_class.c linux-2.6-patched/drivers/s390/char/tape_class.c
--- linux-2.6/drivers/s390/char/tape_class.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/tape_class.c	2006-07-18 13:40:48.000000000 +0200
@@ -76,14 +76,22 @@ struct tape_class_device *register_tape_
 				device,
 				"%s", tcd->device_name
 			);
-	sysfs_create_link(
+	rc = PTR_ERR(tcd->class_device);
+	if (rc)
+		goto fail_with_cdev;
+	rc = sysfs_create_link(
 		&device->kobj,
 		&tcd->class_device->kobj,
 		tcd->mode_name
 	);
+	if (rc)
+		goto fail_with_class_device;
 
 	return tcd;
 
+fail_with_class_device:
+	class_device_destroy(tape_class, tcd->char_device->dev);
+
 fail_with_cdev:
 	cdev_del(tcd->char_device);
 
diff -urpN linux-2.6/drivers/s390/char/tape_core.c linux-2.6-patched/drivers/s390/char/tape_core.c
--- linux-2.6/drivers/s390/char/tape_core.c	2006-07-18 13:40:28.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/tape_core.c	2006-07-18 13:40:48.000000000 +0200
@@ -543,20 +543,24 @@ int
 tape_generic_probe(struct ccw_device *cdev)
 {
 	struct tape_device *device;
+	int ret;
 
 	device = tape_alloc_device();
 	if (IS_ERR(device))
 		return -ENODEV;
-	PRINT_INFO("tape device %s found\n", cdev->dev.bus_id);
+	ccw_device_set_options(cdev, CCWDEV_DO_PATHGROUP);
+	ret = sysfs_create_group(&cdev->dev.kobj, &tape_attr_group);
+	if (ret) {
+		tape_put_device(device);
+		PRINT_ERR("probe failed for tape device %s\n", cdev->dev.bus_id);
+		return ret;
+	}
 	cdev->dev.driver_data = device;
+	cdev->handler = __tape_do_irq;
 	device->cdev = cdev;
 	device->cdev_id = busid_to_int(cdev->dev.bus_id);
-	cdev->handler = __tape_do_irq;
-
-	ccw_device_set_options(cdev, CCWDEV_DO_PATHGROUP);
-	sysfs_create_group(&cdev->dev.kobj, &tape_attr_group);
-
-	return 0;
+	PRINT_INFO("tape device %s found\n", cdev->dev.bus_id);
+	return ret;
 }
 
 static inline void
diff -urpN linux-2.6/drivers/s390/net/ctcmain.c linux-2.6-patched/drivers/s390/net/ctcmain.c
--- linux-2.6/drivers/s390/net/ctcmain.c	2006-07-18 13:40:28.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/ctcmain.c	2006-07-18 13:40:48.000000000 +0200
@@ -2686,9 +2686,17 @@ static struct attribute_group ctc_attr_g
 static int
 ctc_add_attributes(struct device *dev)
 {
-	device_create_file(dev, &dev_attr_loglevel);
-	device_create_file(dev, &dev_attr_stats);
-	return 0;
+	int rc;
+
+	rc = device_create_file(dev, &dev_attr_loglevel);
+	if (rc)
+		goto out;
+	rc = device_create_file(dev, &dev_attr_stats);
+	if (!rc)
+		goto out;
+	device_remove_file(dev, &dev_attr_loglevel);
+out:
+	return rc;
 }
 
 static void
@@ -2901,7 +2909,12 @@ ctc_new_device(struct ccwgroup_device *c
 		goto out;
 	}
 
-	ctc_add_attributes(&cgdev->dev);
+	if (ctc_add_attributes(&cgdev->dev)) {
+		ctc_netdev_unregister(dev);
+		dev->priv = NULL;
+		ctc_free_netdevice(dev, 1);
+		goto out;
+	}
 
 	strlcpy(privptr->fsm->name, dev->name, sizeof (privptr->fsm->name));
 
diff -urpN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2006-07-18 13:40:28.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2006-07-18 13:40:48.000000000 +0200
@@ -8451,10 +8451,11 @@ __qeth_reboot_event_card(struct device *
 static int
 qeth_reboot_event(struct notifier_block *this, unsigned long event, void *ptr)
 {
+	int ret;
 
-	driver_for_each_device(&qeth_ccwgroup_driver.driver, NULL, NULL,
-			       __qeth_reboot_event_card);
-	return NOTIFY_DONE;
+	ret = driver_for_each_device(&qeth_ccwgroup_driver.driver, NULL, NULL,
+				     __qeth_reboot_event_card);
+	return ret ? NOTIFY_BAD : NOTIFY_DONE;
 }
 
 
