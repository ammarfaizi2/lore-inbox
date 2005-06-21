Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVFUQX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVFUQX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVFUQX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:23:28 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:37531 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262150AbVFUQWb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:22:31 -0400
Date: Tue, 21 Jun 2005 18:22:32 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, mochel@digitalimplant.org, gregkh@suse.de,
       cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 2/16] s390: use klist in cio.
Message-ID: <20050621162232.GB6053@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 2/16] s390: use klist in cio.

From: Cornelia Huck <cohuck@de.ibm.com>

Convert the common I/O layer to use the klist interfaces.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/cio/ccwgroup.c |   30 ++++-----------
 drivers/s390/cio/css.c      |   36 +++++++++---------
 drivers/s390/cio/device.c   |   85 ++++++++++++++++++++++++--------------------
 3 files changed, 74 insertions(+), 77 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/ccwgroup.c linux-2.6-patched/drivers/s390/cio/ccwgroup.c
--- linux-2.6/drivers/s390/cio/ccwgroup.c	2005-06-21 17:36:39.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/ccwgroup.c	2005-06-21 17:36:45.000000000 +0200
@@ -403,34 +403,22 @@ ccwgroup_driver_register (struct ccwgrou
 	return driver_register(&cdriver->driver);
 }
 
-static inline struct device *
-__get_next_ccwgroup_device(struct device_driver *drv)
+static int
+__ccwgroup_driver_unregister_device(struct device *dev, void *data)
 {
-	struct device *dev, *d;
-
-	down_read(&drv->bus->subsys.rwsem);
-	dev = NULL;
-	list_for_each_entry(d, &drv->devices, driver_list) {
-		dev = get_device(d);
-		if (dev)
-			break;
-	}
-	up_read(&drv->bus->subsys.rwsem);
-	return dev;
+	__ccwgroup_remove_symlinks(to_ccwgroupdev(dev));
+	device_unregister(dev);
+	put_device(dev);
+	return 0;
 }
 
 void
 ccwgroup_driver_unregister (struct ccwgroup_driver *cdriver)
 {
-	struct device *dev;
-
 	/* We don't want ccwgroup devices to live longer than their driver. */
 	get_driver(&cdriver->driver);
-	while ((dev = __get_next_ccwgroup_device(&cdriver->driver))) {
-		__ccwgroup_remove_symlinks(to_ccwgroupdev(dev));
-		device_unregister(dev);
-		put_device(dev);
-	};
+	driver_for_each_device(&cdriver->driver, NULL, NULL,
+			       __ccwgroup_driver_unregister_device);
 	put_driver(&cdriver->driver);
 	driver_unregister(&cdriver->driver);
 }
@@ -449,7 +437,7 @@ __ccwgroup_get_gdev_by_cdev(struct ccw_d
 	if (cdev->dev.driver_data) {
 		gdev = (struct ccwgroup_device *)cdev->dev.driver_data;
 		if (get_device(&gdev->dev)) {
-			if (!list_empty(&gdev->dev.node))
+			if (klist_node_attached(&gdev->dev.knode_bus))
 				return gdev;
 			put_device(&gdev->dev);
 		}
diff -urpN linux-2.6/drivers/s390/cio/css.c linux-2.6-patched/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/css.c	2005-06-21 17:36:45.000000000 +0200
@@ -128,34 +128,34 @@ css_probe_device(int irq)
 	return ret;
 }
 
-struct subchannel *
-get_subchannel_by_schid(int irq)
+static int
+check_subchannel(struct device * dev, void * data)
 {
 	struct subchannel *sch;
-	struct list_head *entry;
-	struct device *dev;
+	int irq = (int)data;
 
-	if (!get_bus(&css_bus_type))
-		return NULL;
-	down_read(&css_bus_type.subsys.rwsem);
-	sch = NULL;
-	list_for_each(entry, &css_bus_type.devices.list) {
-		dev = get_device(container_of(entry,
-					      struct device, bus_list));
-		if (!dev)
-			continue;
+	if (get_device(dev)) {
 		sch = to_subchannel(dev);
 		if (sch->irq == irq)
-			break;
+			return 1;
 		put_device(dev);
-		sch = NULL;
+
 	}
-	up_read(&css_bus_type.subsys.rwsem);
-	put_bus(&css_bus_type);
+	return 0;
+}
 
-	return sch;
+struct subchannel *
+get_subchannel_by_schid(int irq)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&css_bus_type, NULL,
+			      (void *)irq, check_subchannel);
+
+	return dev ? to_subchannel(dev) : NULL;
 }
 
+
 static inline int
 css_get_subchannel_status(struct subchannel *sch, int schid)
 {
diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2005-06-21 17:36:39.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device.c	2005-06-21 17:36:45.000000000 +0200
@@ -514,36 +514,42 @@ ccw_device_register(struct ccw_device *c
 	return ret;
 }
 
-static struct ccw_device *
-get_disc_ccwdev_by_devno(unsigned int devno, struct ccw_device *sibling)
+struct match_data {
+	unsigned int  devno;
+	struct ccw_device * sibling;
+};
+
+static int
+match_devno(struct device * dev, void * data)
 {
-	struct ccw_device *cdev;
-	struct list_head *entry;
-	struct device *dev;
+	struct match_data * d = (struct match_data *)data;
+	struct ccw_device * cdev;
 
-	if (!get_bus(&ccw_bus_type))
-		return NULL;
-	down_read(&ccw_bus_type.subsys.rwsem);
-	cdev = NULL;
-	list_for_each(entry, &ccw_bus_type.devices.list) {
-		dev = get_device(container_of(entry,
-					      struct device, bus_list));
-		if (!dev)
-			continue;
+	if (get_device(dev)) {
 		cdev = to_ccwdev(dev);
 		if ((cdev->private->state == DEV_STATE_DISCONNECTED) &&
-		    (cdev->private->devno == devno) &&
-		    (cdev != sibling)) {
+		    (cdev->private->devno == d->devno) &&
+		    (cdev != d->sibling)) {
 			cdev->private->state = DEV_STATE_NOT_OPER;
-			break;
+			return 1;
 		}
 		put_device(dev);
-		cdev = NULL;
 	}
-	up_read(&ccw_bus_type.subsys.rwsem);
-	put_bus(&ccw_bus_type);
+	return 0;
+}
+
+static struct ccw_device *
+get_disc_ccwdev_by_devno(unsigned int devno, struct ccw_device *sibling)
+{
+	struct device *dev;
+	struct match_data data = {
+		.devno  = devno,
+		.sibling = sibling,
+	};
+
+	dev = bus_find_device(&css_bus_type, NULL, &data, match_devno);
 
-	return cdev;
+	return dev ? to_ccwdev(dev) : NULL;
 }
 
 static void
@@ -647,7 +653,7 @@ io_subchannel_register(void *data)
 	cdev = (struct ccw_device *) data;
 	sch = to_subchannel(cdev->dev.parent);
 
-	if (!list_empty(&sch->dev.children)) {
+	if (klist_node_attached(&cdev->dev.knode_parent)) {
 		bus_rescan_devices(&ccw_bus_type);
 		goto out;
 	}
@@ -1019,30 +1025,33 @@ ccw_device_probe_console(void)
 /*
  * get ccw_device matching the busid, but only if owned by cdrv
  */
+static int
+__ccwdev_check_busid(struct device *dev, void *id)
+{
+	char *bus_id;
+
+	bus_id = (char *)id;
+	if (get_device(dev)) {
+		if (!strncmp(bus_id, dev->bus_id, BUS_ID_SIZE))
+			return 1;
+		put_device(dev);
+	}
+	return 0;
+}
+
+
 struct ccw_device *
 get_ccwdev_by_busid(struct ccw_driver *cdrv, const char *bus_id)
 {
-	struct device *d, *dev;
+	struct device *dev;
 	struct device_driver *drv;
 
 	drv = get_driver(&cdrv->driver);
 	if (!drv)
-		return 0;
-
-	down_read(&drv->bus->subsys.rwsem);
-
-	dev = NULL;
-	list_for_each_entry(d, &drv->devices, driver_list) {
-		dev = get_device(d);
+		return NULL;
 
-		if (dev && !strncmp(bus_id, dev->bus_id, BUS_ID_SIZE))
-			break;
-		else if (dev) {
-			put_device(dev);
-			dev = NULL;
-		}
-	}
-	up_read(&drv->bus->subsys.rwsem);
+	dev = driver_find_device(drv, NULL, (void *)bus_id,
+				 __ccwdev_check_busid);
 	put_driver(drv);
 
 	return dev ? to_ccwdev(dev) : 0;
