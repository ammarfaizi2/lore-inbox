Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWH3Mkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWH3Mkv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWH3Mkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:40:51 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:3078 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750887AbWH3Mku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:40:50 -0400
Date: Wed, 30 Aug 2006 14:40:47 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] cio: kernel stack overflow.
Message-ID: <20060830124047.GA22276@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] cio: kernel stack overflow.

Use different kind of assignment to make sure gcc doesn't create code
that creates temp variables on the stack, assigns values to it and
copies the content of the whole temp variable to the destination.
This reduces stack usage of e.g. ccwgroup_driver_register from 976
to 48 bytes instead.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/cio/ccwgroup.c   |   14 +++++---------
 drivers/s390/cio/chsc.c       |    6 ++----
 drivers/s390/cio/device.c     |   19 +++++++------------
 drivers/s390/cio/device_fsm.c |   20 ++++++++------------
 4 files changed, 22 insertions(+), 37 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/ccwgroup.c linux-2.6-patched/drivers/s390/cio/ccwgroup.c
--- linux-2.6/drivers/s390/cio/ccwgroup.c	2006-08-30 14:24:13.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/ccwgroup.c	2006-08-30 14:24:33.000000000 +0200
@@ -183,11 +183,9 @@ ccwgroup_create(struct device *root,
 
 	gdev->creator_id = creator_id;
 	gdev->count = argc;
-	gdev->dev = (struct device ) {
-		.bus = &ccwgroup_bus_type,
-		.parent = root,
-		.release = ccwgroup_release,
-	};
+	gdev->dev.bus = &ccwgroup_bus_type;
+	gdev->dev.parent = root;
+	gdev->dev.release = ccwgroup_release;
 
 	snprintf (gdev->dev.bus_id, BUS_ID_SIZE, "%s",
 			gdev->cdev[0]->dev.bus_id);
@@ -391,10 +389,8 @@ int
 ccwgroup_driver_register (struct ccwgroup_driver *cdriver)
 {
 	/* register our new driver with the core */
-	cdriver->driver = (struct device_driver) {
-		.bus = &ccwgroup_bus_type,
-		.name = cdriver->name,
-	};
+	cdriver->driver.bus = &ccwgroup_bus_type;
+	cdriver->driver.name = cdriver->name;
 
 	return driver_register(&cdriver->driver);
 }
diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-08-30 14:24:13.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-08-30 14:24:33.000000000 +0200
@@ -1391,10 +1391,8 @@ new_channel_path(int chpid)
 	/* fill in status, etc. */
 	chp->id = chpid;
 	chp->state = 1;
-	chp->dev = (struct device) {
-		.parent  = &css[0]->device,
-		.release = chp_release,
-	};
+	chp->dev.parent = &css[0]->device;
+	chp->dev.release = chp_release;
 	snprintf(chp->dev.bus_id, BUS_ID_SIZE, "chp0.%x", chpid);
 
 	/* Obtain channel path description and fill it in. */
diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2006-08-30 14:24:13.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device.c	2006-08-30 14:24:33.000000000 +0200
@@ -556,12 +556,11 @@ get_disc_ccwdev_by_devno(unsigned int de
 			 struct ccw_device *sibling)
 {
 	struct device *dev;
-	struct match_data data = {
-		.devno   = devno,
-		.ssid    = ssid,
-		.sibling = sibling,
-	};
+	struct match_data data;
 
+	data.devno = devno;
+	data.ssid = ssid;
+	data.sibling = sibling;
 	dev = bus_find_device(&ccw_bus_type, NULL, &data, match_devno);
 
 	return dev ? to_ccwdev(dev) : NULL;
@@ -835,10 +834,8 @@ io_subchannel_probe (struct subchannel *
 		return -ENOMEM;
 	}
 	atomic_set(&cdev->private->onoff, 0);
-	cdev->dev = (struct device) {
-		.parent = &sch->dev,
-		.release = ccw_device_release,
-	};
+	cdev->dev.parent = &sch->dev;
+	cdev->dev.release = ccw_device_release;
 	INIT_LIST_HEAD(&cdev->private->kick_work.entry);
 	/* Do first half of device_register. */
 	device_initialize(&cdev->dev);
@@ -977,9 +974,7 @@ ccw_device_console_enable (struct ccw_de
 	int rc;
 
 	/* Initialize the ccw_device structure. */
-	cdev->dev = (struct device) {
-		.parent = &sch->dev,
-	};
+	cdev->dev.parent= &sch->dev;
 	rc = io_subchannel_recog(cdev, sch);
 	if (rc)
 		return rc;
diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2006-08-30 14:24:13.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2006-08-30 14:24:33.000000000 +0200
@@ -267,12 +267,10 @@ ccw_device_recog_done(struct ccw_device 
 			notify = 1;
 		}
 		/* fill out sense information */
-		cdev->id = (struct ccw_device_id) {
-			.cu_type   = cdev->private->senseid.cu_type,
-			.cu_model  = cdev->private->senseid.cu_model,
-			.dev_type  = cdev->private->senseid.dev_type,
-			.dev_model = cdev->private->senseid.dev_model,
-		};
+		cdev->id.cu_type   = cdev->private->senseid.cu_type;
+		cdev->id.cu_model  = cdev->private->senseid.cu_model;
+		cdev->id.dev_type  = cdev->private->senseid.dev_type;
+		cdev->id.dev_model = cdev->private->senseid.dev_model;
 		if (notify) {
 			cdev->private->state = DEV_STATE_OFFLINE;
 			if (same_dev) {
@@ -566,12 +564,10 @@ ccw_device_verify_done(struct ccw_device
 		/* Deliver fake irb to device driver, if needed. */
 		if (cdev->private->flags.fake_irb) {
 			memset(&cdev->private->irb, 0, sizeof(struct irb));
-			cdev->private->irb.scsw = (struct scsw) {
-				.cc = 1,
-				.fctl = SCSW_FCTL_START_FUNC,
-				.actl = SCSW_ACTL_START_PEND,
-				.stctl = SCSW_STCTL_STATUS_PEND,
-			};
+			cdev->private->irb.scsw.cc = 1;
+			cdev->private->irb.scsw.fctl = SCSW_FCTL_START_FUNC;
+			cdev->private->irb.scsw.actl = SCSW_ACTL_START_PEND;
+			cdev->private->irb.scsw.stctl = SCSW_STCTL_STATUS_PEND;
 			cdev->private->flags.fake_irb = 0;
 			if (cdev->handler)
 				cdev->handler(cdev, cdev->private->intparm,
