Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVFVPAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVFVPAq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVFVO7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 10:59:46 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:31399 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261434AbVFVO6z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:58:55 -0400
Date: Wed, 22 Jun 2005 16:59:55 +0200
From: Cornelia Huck <cohuck@de.ibm.com>
To: Greg KH <gregkh@suse.de>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, mochel@digitalimplant.org
Subject: [patch 2/2] s390: use klist in cio.
Message-ID: <20050622165955.08c0d53e@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20050622081411.GA30791@suse.de>
References: <20050622062627.GA29759@kroah.com>
	<OF6148E781.C94AF99A-ON42257028.002925D7-42257028.002AF389@de.ibm.com>
	<20050622081411.GA30791@suse.de>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 2/2] s390: use klist in cio.

Convert the common I/O layer to use the klist interfaces.

This patch has been adapted from the previous version to the changed interface
semantics. Also, gcc 4.0 compile warnings have been removed.

Signed-off-by: Cornelia Huck <cohuck@de.ibm.com>

 drivers/s390/cio/ccwgroup.c |   30 +++++----------
 drivers/s390/cio/css.c      |   34 +++++++----------
 drivers/s390/cio/device.c   |   84 ++++++++++++++++++++++---------------------
 3 files changed, 66 insertions(+), 82 deletions(-)

diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
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
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -128,34 +128,28 @@ css_probe_device(int irq)
 	return ret;
 }
 
+static int
+check_subchannel(struct device * dev, void * data)
+{
+	struct subchannel *sch;
+	int irq = (unsigned long)data;
+
+	sch = to_subchannel(dev);
+	return (sch->irq == irq);
+}
+
 struct subchannel *
 get_subchannel_by_schid(int irq)
 {
-	struct subchannel *sch;
-	struct list_head *entry;
 	struct device *dev;
 
-	if (!get_bus(&css_bus_type))
-		return NULL;
-	down_read(&css_bus_type.subsys.rwsem);
-	sch = NULL;
-	list_for_each(entry, &css_bus_type.devices.list) {
-		dev = get_device(container_of(entry,
-					      struct device, bus_list));
-		if (!dev)
-			continue;
-		sch = to_subchannel(dev);
-		if (sch->irq == irq)
-			break;
-		put_device(dev);
-		sch = NULL;
-	}
-	up_read(&css_bus_type.subsys.rwsem);
-	put_bus(&css_bus_type);
+	dev = bus_find_device(&css_bus_type, NULL,
+			      (void *)(unsigned long)irq, check_subchannel);
 
-	return sch;
+	return dev ? to_subchannel(dev) : NULL;
 }
 
+
 static inline int
 css_get_subchannel_status(struct subchannel *sch, int schid)
 {
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -514,36 +514,39 @@ ccw_device_register(struct ccw_device *c
 	return ret;
 }
 
+struct match_data {
+	unsigned int  devno;
+	struct ccw_device * sibling;
+};
+
+static int
+match_devno(struct device * dev, void * data)
+{
+	struct match_data * d = (struct match_data *)data;
+	struct ccw_device * cdev;
+
+	cdev = to_ccwdev(dev);
+	if ((cdev->private->state == DEV_STATE_DISCONNECTED) &&
+	    (cdev->private->devno == d->devno) &&
+	    (cdev != d->sibling)) {
+		cdev->private->state = DEV_STATE_NOT_OPER;
+		return 1;
+	}
+	return 0;
+}
+
 static struct ccw_device *
 get_disc_ccwdev_by_devno(unsigned int devno, struct ccw_device *sibling)
 {
-	struct ccw_device *cdev;
-	struct list_head *entry;
 	struct device *dev;
+	struct match_data data = {
+		.devno  = devno,
+		.sibling = sibling,
+	};
 
-	if (!get_bus(&ccw_bus_type))
-		return NULL;
-	down_read(&ccw_bus_type.subsys.rwsem);
-	cdev = NULL;
-	list_for_each(entry, &ccw_bus_type.devices.list) {
-		dev = get_device(container_of(entry,
-					      struct device, bus_list));
-		if (!dev)
-			continue;
-		cdev = to_ccwdev(dev);
-		if ((cdev->private->state == DEV_STATE_DISCONNECTED) &&
-		    (cdev->private->devno == devno) &&
-		    (cdev != sibling)) {
-			cdev->private->state = DEV_STATE_NOT_OPER;
-			break;
-		}
-		put_device(dev);
-		cdev = NULL;
-	}
-	up_read(&ccw_bus_type.subsys.rwsem);
-	put_bus(&ccw_bus_type);
+	dev = bus_find_device(&css_bus_type, NULL, &data, match_devno);
 
-	return cdev;
+	return dev ? to_ccwdev(dev) : NULL;
 }
 
 static void
@@ -647,7 +650,7 @@ io_subchannel_register(void *data)
 	cdev = (struct ccw_device *) data;
 	sch = to_subchannel(cdev->dev.parent);
 
-	if (!list_empty(&sch->dev.children)) {
+	if (klist_node_attached(&cdev->dev.knode_parent)) {
 		bus_rescan_devices(&ccw_bus_type);
 		goto out;
 	}
@@ -1019,30 +1022,29 @@ ccw_device_probe_console(void)
 /*
  * get ccw_device matching the busid, but only if owned by cdrv
  */
+static int
+__ccwdev_check_busid(struct device *dev, void *id)
+{
+	char *bus_id;
+
+	bus_id = (char *)id;
+
+	return (strncmp(bus_id, dev->bus_id, BUS_ID_SIZE) == 0);
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
