Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVFVPCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVFVPCV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVFVPCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:02:21 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:44751 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261425AbVFVO6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:58:52 -0400
Date: Wed, 22 Jun 2005 16:59:51 +0200
From: Cornelia Huck <cohuck@de.ibm.com>
To: Greg KH <gregkh@suse.de>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, mochel@digitalimplant.org
Subject: [patch 1/2] s390: klist bus_find_device & driver_find_device
 callback.
Message-ID: <20050622165951.7d736a16@gondolin.boeblingen.de.ibm.com>
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

[patch 1/2] s390: klist bus_find_device & driver_find_device callback.

Add bus_find_device() and driver_find_device() which allow searching for a
device in the bus's resp. the driver's klist and obtain a reference on it.

This version now increases the reference count for the device to be returned.
Also, the interface has been exported to GPL modules and the comments have
been improved.

Signed-off-by: Cornelia Huck <cohuck@de.ibm.com>

 drivers/base/bus.c     |   33 +++++++++++++++++++++++++++++++++
 drivers/base/driver.c  |   35 +++++++++++++++++++++++++++++++++++
 include/linux/device.h |    7 +++++++
 3 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -177,6 +177,38 @@ int bus_for_each_dev(struct bus_type * b
 	return error;
 }
 
+/**
+ * bus_find_device - device iterator for locating a particular device.
+ * @bus: bus type
+ * @start: Device to begin with
+ * @data: Data to pass to match function
+ * @match: Callback function to check device
+ *
+ * This is similar to the bus_for_each_dev() function above, but it
+ * returns a reference to a device that is 'found' for later use, as determined
+ * by the @match callback. The callback should return a bool - 0 if
+ * the device doesn't match and 1 if it does.
+ * The function will return if a device is found.
+ */
+
+struct device * bus_find_device(struct bus_type * bus,
+				struct device * start, void * data,
+				int (*match)(struct device *, void *))
+{
+	struct klist_iter i;
+	struct device * dev;
+
+	if (!bus)
+		return NULL;
+
+	klist_iter_init_node(&bus->klist_devices, &i,
+			     (start ? &start->knode_bus : NULL));
+	while ((dev = next_device(&i)))
+		if (match(dev, data) && get_device(dev))
+			break;
+	klist_iter_exit(&i);
+	return dev;
+}
 
 
 static struct device_driver * next_driver(struct klist_iter * i)
@@ -558,6 +590,7 @@ int __init buses_init(void)
 
 
 EXPORT_SYMBOL_GPL(bus_for_each_dev);
+EXPORT_SYMBOL_GPL(bus_find_device);
 EXPORT_SYMBOL_GPL(bus_for_each_drv);
 
 EXPORT_SYMBOL_GPL(bus_add_device);
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -56,6 +56,41 @@ EXPORT_SYMBOL_GPL(driver_for_each_device
 
 
 /**
+ * driver_find_device - device iterator for locating a particular device.
+ * @driver: The device's driver
+ * @start: Device to begin with
+ * @data: Data to pass to match function
+ * @match: Callback function to check device
+ *
+ * This is similar to the driver_for_each_device() function above, but it
+ * returns a reference to a device that is 'found' for later use, as determined
+ * by the @match callback. The callback should return a bool - 0 if
+ * the device doesn't match and 1 if it does.
+ * The function will return if a device is found.
+ */
+
+struct device * driver_find_device(struct device_driver *drv,
+				   struct device * start, void * data,
+				   int (*match)(struct device *, void *))
+{
+	struct klist_iter i;
+	struct device * dev;
+
+	if (!drv)
+		return NULL;
+
+	klist_iter_init_node(&drv->klist_devices, &i,
+			     (start ? &start->knode_driver : NULL));
+	while ((dev = next_device(&i)))
+		if (match(dev, data) && get_device(dev))
+			break;
+	klist_iter_exit(&i);
+	return dev;
+}
+
+EXPORT_SYMBOL_GPL(driver_find_device);
+
+/**
  *	driver_create_file - create sysfs file for driver.
  *	@drv:	driver.
  *	@attr:	driver attribute descriptor.
diff --git a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -81,6 +81,9 @@ extern struct bus_type * find_bus(char *
 int bus_for_each_dev(struct bus_type * bus, struct device * start, void * data,
 		     int (*fn)(struct device *, void *));
 
+struct device *  bus_find_device(struct bus_type * bus, struct device * start,
+				 void * data, int (*match)(struct device *, void *));
+
 int bus_for_each_drv(struct bus_type * bus, struct device_driver * start, 
 		     void * data, int (*fn)(struct device_driver *, void *));
 
@@ -143,6 +146,10 @@ extern void driver_remove_file(struct de
 extern int driver_for_each_device(struct device_driver * drv, struct device * start,
 				  void * data, int (*fn)(struct device *, void *));
 
+struct device *  driver_find_device(struct device_driver * drv,
+				    struct device * start, void * data,
+				    int (*match)(struct device *, void *));
+
 
 /*
  * device classes
