Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422910AbWAMTuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422910AbWAMTuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422907AbWAMTuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:50:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:4501 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422899AbWAMTui convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:38 -0500
Cc: huckc@de.ibm.com
Subject: [PATCH] Add {css,ccw}_bus_type probe, remove, shutdown methods.
In-Reply-To: <11371818122256@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:12 -0800
Message-Id: <11371818121681@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add {css,ccw}_bus_type probe, remove, shutdown methods.

The following patch converts css_bus_type and ccw_bus_type to use
the new bus_type methods.

Signed-off-by: Cornelia Huck <huckc@de.ibm.com>
CC: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 8bbace7e686f1536905c703038a7eddfb1520264
tree 99253fd56bebd7903ac8dd05ee7c236c765e2798
parent 348290a4ae143a692124330942b464ccdb0d0365
author Cornelia Huck <huckc@de.ibm.com> Wed, 11 Jan 2006 10:56:22 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:11 -0800

 drivers/s390/cio/css.c    |   36 +++++++++++++++++++++++++++++++-
 drivers/s390/cio/css.h    |    4 ++++
 drivers/s390/cio/device.c |   50 ++++++++++++++++++++++-----------------------
 3 files changed, 62 insertions(+), 28 deletions(-)

diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index e565193..2d319fb 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -542,9 +542,41 @@ css_bus_match (struct device *dev, struc
 	return 0;
 }
 
+static int
+css_probe (struct device *dev)
+{
+	struct subchannel *sch;
+
+	sch = to_subchannel(dev);
+	sch->driver = container_of (dev->driver, struct css_driver, drv);
+	return (sch->driver->probe ? sch->driver->probe(sch) : 0);
+}
+
+static int
+css_remove (struct device *dev)
+{
+	struct subchannel *sch;
+
+	sch = to_subchannel(dev);
+	return (sch->driver->remove ? sch->driver->remove(sch) : 0);
+}
+
+static void
+css_shutdown (struct device *dev)
+{
+	struct subchannel *sch;
+
+	sch = to_subchannel(dev);
+	if (sch->driver->shutdown)
+		sch->driver->shutdown(sch);
+}
+
 struct bus_type css_bus_type = {
-	.name  = "css",
-	.match = &css_bus_match,
+	.name     = "css",
+	.match    = css_bus_match,
+	.probe    = css_probe,
+	.remove   = css_remove,
+	.shutdown = css_shutdown,
 };
 
 subsys_initcall(init_channel_subsystem);
diff --git a/drivers/s390/cio/css.h b/drivers/s390/cio/css.h
index 251ebd7..aa5ab5d 100644
--- a/drivers/s390/cio/css.h
+++ b/drivers/s390/cio/css.h
@@ -115,6 +115,7 @@ struct ccw_device_private {
  * Currently, we only care about I/O subchannels (type 0), these
  * have a ccw_device connected to them.
  */
+struct subchannel;
 struct css_driver {
 	unsigned int subchannel_type;
 	struct device_driver drv;
@@ -122,6 +123,9 @@ struct css_driver {
 	int (*notify)(struct device *, int);
 	void (*verify)(struct device *);
 	void (*termination)(struct device *);
+	int (*probe)(struct subchannel *);
+	int (*remove)(struct subchannel *);
+	void (*shutdown)(struct subchannel *);
 };
 
 /*
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index fa3e4c0..eb73605 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -107,33 +107,29 @@ ccw_uevent (struct device *dev, char **e
 	return 0;
 }
 
-struct bus_type ccw_bus_type = {
-	.name  = "ccw",
-	.match = &ccw_bus_match,
-	.uevent = &ccw_uevent,
-};
+struct bus_type ccw_bus_type;
 
-static int io_subchannel_probe (struct device *);
-static int io_subchannel_remove (struct device *);
+static int io_subchannel_probe (struct subchannel *);
+static int io_subchannel_remove (struct subchannel *);
 void io_subchannel_irq (struct device *);
 static int io_subchannel_notify(struct device *, int);
 static void io_subchannel_verify(struct device *);
 static void io_subchannel_ioterm(struct device *);
-static void io_subchannel_shutdown(struct device *);
+static void io_subchannel_shutdown(struct subchannel *);
 
 struct css_driver io_subchannel_driver = {
 	.subchannel_type = SUBCHANNEL_TYPE_IO,
 	.drv = {
 		.name = "io_subchannel",
 		.bus  = &css_bus_type,
-		.probe = &io_subchannel_probe,
-		.remove = &io_subchannel_remove,
-		.shutdown = &io_subchannel_shutdown,
 	},
 	.irq = io_subchannel_irq,
 	.notify = io_subchannel_notify,
 	.verify = io_subchannel_verify,
 	.termination = io_subchannel_ioterm,
+	.probe = io_subchannel_probe,
+	.remove = io_subchannel_remove,
+	.shutdown = io_subchannel_shutdown,
 };
 
 struct workqueue_struct *ccw_device_work;
@@ -803,14 +799,12 @@ io_subchannel_recog(struct ccw_device *c
 }
 
 static int
-io_subchannel_probe (struct device *pdev)
+io_subchannel_probe (struct subchannel *sch)
 {
-	struct subchannel *sch;
 	struct ccw_device *cdev;
 	int rc;
 	unsigned long flags;
 
-	sch = to_subchannel(pdev);
 	if (sch->dev.driver_data) {
 		/*
 		 * This subchannel already has an associated ccw_device.
@@ -846,7 +840,7 @@ io_subchannel_probe (struct device *pdev
 	memset(cdev->private, 0, sizeof(struct ccw_device_private));
 	atomic_set(&cdev->private->onoff, 0);
 	cdev->dev = (struct device) {
-		.parent = pdev,
+		.parent = &sch->dev,
 		.release = ccw_device_release,
 	};
 	INIT_LIST_HEAD(&cdev->private->kick_work.entry);
@@ -859,7 +853,7 @@ io_subchannel_probe (struct device *pdev
 		return -ENODEV;
 	}
 
-	rc = io_subchannel_recog(cdev, to_subchannel(pdev));
+	rc = io_subchannel_recog(cdev, sch);
 	if (rc) {
 		spin_lock_irqsave(&sch->lock, flags);
 		sch->dev.driver_data = NULL;
@@ -883,17 +877,17 @@ ccw_device_unregister(void *data)
 }
 
 static int
-io_subchannel_remove (struct device *dev)
+io_subchannel_remove (struct subchannel *sch)
 {
 	struct ccw_device *cdev;
 	unsigned long flags;
 
-	if (!dev->driver_data)
+	if (!sch->dev.driver_data)
 		return 0;
-	cdev = dev->driver_data;
+	cdev = sch->dev.driver_data;
 	/* Set ccw device to not operational and drop reference. */
 	spin_lock_irqsave(cdev->ccwlock, flags);
-	dev->driver_data = NULL;
+	sch->dev.driver_data = NULL;
 	cdev->private->state = DEV_STATE_NOT_OPER;
 	spin_unlock_irqrestore(cdev->ccwlock, flags);
 	/*
@@ -948,14 +942,12 @@ io_subchannel_ioterm(struct device *dev)
 }
 
 static void
-io_subchannel_shutdown(struct device *dev)
+io_subchannel_shutdown(struct subchannel *sch)
 {
-	struct subchannel *sch;
 	struct ccw_device *cdev;
 	int ret;
 
-	sch = to_subchannel(dev);
-	cdev = dev->driver_data;
+	cdev = sch->dev.driver_data;
 
 	if (cio_is_console(sch->schid))
 		return;
@@ -1129,6 +1121,14 @@ ccw_device_remove (struct device *dev)
 	return 0;
 }
 
+struct bus_type ccw_bus_type = {
+	.name   = "ccw",
+	.match  = ccw_bus_match,
+	.uevent = ccw_uevent,
+	.probe  = ccw_device_probe,
+	.remove = ccw_device_remove,
+};
+
 int
 ccw_driver_register (struct ccw_driver *cdriver)
 {
@@ -1136,8 +1136,6 @@ ccw_driver_register (struct ccw_driver *
 
 	drv->bus = &ccw_bus_type;
 	drv->name = cdriver->name;
-	drv->probe = ccw_device_probe;
-	drv->remove = ccw_device_remove;
 
 	return driver_register(drv);
 }

