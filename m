Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbUKHHa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbUKHHa1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 02:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUKHH3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 02:29:43 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:34152 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261765AbUKHH07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 02:26:59 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Add bind_mode default device/driver attributes
Date: Mon, 8 Nov 2004 02:26:45 -0500
User-Agent: KMail/1.6.2
Cc: Tejun Heo <tj@home-tj.org>, Greg KH <greg@kroah.com>,
       rusty@rustcorp.com.au, mochel@osdl.org
References: <20041104074330.GG25567@home-tj.org> <200411080223.56536.dtor_core@ameritech.net> <200411080225.58532.dtor_core@ameritech.net>
In-Reply-To: <200411080225.58532.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411080226.48296.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1963, 2004-11-08 02:07:15-05:00, dtor_core@ameritech.net
  Driver core: add "bind_mode" default device and driver attribute.
               Calls to device_attach() and driver_attach() will not
               bind device and driver if either one of them is in
               "manual" bind mode. Manual binding is expected to be
               handled by bus's drvctl()
  
           echo -n "manual" > /sus/bus/serio/devices/serio2/bind_mode
           echo -n "auto" > /sys/bus/serio/drivers/serio_raw/bind_mode
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/base/bus.c              |   20 ++++++----
 drivers/base/interface.c        |   79 ++++++++++++++++++++++++++++++++++++----
 drivers/input/serio/serio.c     |   59 ++---------------------------
 drivers/input/serio/serio_raw.c |    4 +-
 include/linux/device.h          |    5 ++
 include/linux/serio.h           |    4 --
 6 files changed, 97 insertions(+), 74 deletions(-)


===================================================================



diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-11-08 02:20:53 -05:00
+++ b/drivers/base/bus.c	2004-11-08 02:20:53 -05:00
@@ -68,9 +68,12 @@
 	up(&drv->unload_sem);
 }
 
+extern struct attribute * drv_default_attrs[];
+
 static struct kobj_type ktype_driver = {
 	.sysfs_ops	= &driver_sysfs_ops,
 	.release	= driver_release,
+	.default_attrs	= drv_default_attrs,
 };
 
 
@@ -319,9 +322,12 @@
 		return 1;
 	}
 
-	if (bus->match) {
-		list_for_each(entry, &bus->drivers.list) {
-			struct device_driver * drv = to_drv(entry);
+	if (dev->manual_bind || !bus->match)
+		return 0;
+
+	list_for_each(entry, &bus->drivers.list) {
+		struct device_driver * drv = to_drv(entry);
+		if (!drv->manual_bind) {
 			error = driver_probe_device(drv, dev);
 			if (!error)
 				/* success, driver matched */
@@ -329,8 +335,8 @@
 			if (error != -ENODEV)
 				/* driver matched but the probe failed */
 				printk(KERN_WARNING
-				    "%s: probe of %s failed with error %d\n",
-				    drv->name, dev->bus_id, error);
+					"%s: probe of %s failed with error %d\n",
+					drv->name, dev->bus_id, error);
 		}
 	}
 
@@ -356,12 +362,12 @@
 	struct list_head * entry;
 	int error;
 
-	if (!bus->match)
+	if (drv->manual_bind || !bus->match)
 		return;
 
 	list_for_each(entry, &bus->devices.list) {
 		struct device * dev = container_of(entry, struct device, bus_list);
-		if (!dev->driver) {
+		if (!dev->driver && !dev->manual_bind) {
 			error = driver_probe_device(drv, dev);
 			if (error && (error != -ENODEV))
 				/* driver matched but the probe failed */
diff -Nru a/drivers/base/interface.c b/drivers/base/interface.c
--- a/drivers/base/interface.c	2004-11-08 02:20:53 -05:00
+++ b/drivers/base/interface.c	2004-11-08 02:20:53 -05:00
@@ -1,6 +1,6 @@
 /*
  * drivers/base/interface.c - common driverfs interface that's exported to
- * 	the world for all devices.
+ * 	the world for all devices and drivers.
  *
  * Copyright (c) 2002-3 Patrick Mochel
  * Copyright (c) 2002-3 Open Source Development Labs
@@ -16,6 +16,35 @@
 #include <linux/ctype.h>
 
 /**
+ *	bind_mode - control the binding mode for the device.
+ *
+ *	When set to "auto" driver core will try to automatically bind the
+ *	device once appropriate driver becomes available. When bind mode
+ *	is "manual" intervention from userspace is required.
+ */
+
+static ssize_t dev_bind_mode_show(struct device * dev, char * buf)
+{
+	return sprintf(buf, "%s\n", dev->manual_bind ? "manual" : "auto");
+}
+
+static ssize_t dev_bind_mode_store(struct device * dev, const char * buf, size_t count)
+{
+	int retval = count;
+
+	if (!strncmp(buf, "manual", count)) {
+		dev->manual_bind = 1;
+	} else if (!strncmp(buf, "auto", count)) {
+		dev->manual_bind = 0;
+	} else {
+		retval = -EINVAL;
+	}
+
+	return retval;
+}
+
+
+/**
  *	detach_state - control the default power state for the device.
  *
  *	This is the state the device enters when it's driver module is
@@ -28,12 +57,12 @@
  *	driver's suspend method.
  */
 
-static ssize_t detach_show(struct device * dev, char * buf)
+static ssize_t dev_detach_show(struct device * dev, char * buf)
 {
 	return sprintf(buf, "%u\n", dev->detach_state);
 }
 
-static ssize_t detach_store(struct device * dev, const char * buf, size_t n)
+static ssize_t dev_detach_store(struct device * dev, const char * buf, size_t n)
 {
 	u32 state;
 	state = simple_strtoul(buf, NULL, 10);
@@ -65,7 +94,7 @@
 	}						\
 } while (0)						\
 
-static ssize_t drvctl_store(struct device * dev, const char * buf, size_t count)
+static ssize_t dev_drvctl_store(struct device * dev, const char * buf, size_t count)
 {
 	int retval = -ENOSYS;
 	struct device_driver *drv = NULL;
@@ -113,11 +142,49 @@
 }
 #undef GET_WORD
 
-static DEVICE_ATTR(detach_state, 0644, detach_show, detach_store);
-static DEVICE_ATTR(drvctl, 0200, NULL, drvctl_store);
+static DEVICE_ATTR(bind_mode, 0644, dev_bind_mode_show, dev_bind_mode_store);
+static DEVICE_ATTR(detach_state, 0644, dev_detach_show, dev_detach_store);
+static DEVICE_ATTR(drvctl, 0200, NULL, dev_drvctl_store);
 
 struct attribute * dev_default_attrs[] = {
+	&dev_attr_bind_mode.attr,
 	&dev_attr_detach_state.attr,
 	&dev_attr_drvctl.attr,
 	NULL,
 };
+
+/**
+ *	bind_mode - control the binding mode for the driver.
+ *
+ *	When set to "auto" driver core will try to automatically bind the
+ *	driver once appropriate device becomes available. When bind mode
+ *	is "manual" intervention from userspace is required.
+ */
+
+static ssize_t drv_bind_mode_show(struct device_driver * drv, char * buf)
+{
+	return sprintf(buf, "%s\n", drv->manual_bind ? "manual" : "auto");
+}
+
+static ssize_t drv_bind_mode_store(struct device_driver * drv, const char * buf, size_t count)
+{
+	int retval = count;
+
+	if (!strncmp(buf, "manual", count)) {
+		drv->manual_bind = 1;
+	} else if (!strncmp(buf, "auto", count)) {
+		drv->manual_bind = 0;
+	} else {
+		retval = -EINVAL;
+	}
+
+	return retval;
+}
+
+static DRIVER_ATTR(bind_mode, 0644, drv_bind_mode_show, drv_bind_mode_store);
+
+struct attribute * drv_default_attrs[] = {
+	&driver_attr_bind_mode.attr,
+	NULL,
+};
+
diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-11-08 02:20:53 -05:00
+++ b/drivers/input/serio/serio.c	2004-11-08 02:20:53 -05:00
@@ -92,7 +92,7 @@
 	struct serio_driver *drv;
 
 	list_for_each_entry(drv, &serio_driver_list, node)
-		if (!drv->manual_bind)
+		if (!drv->driver.manual_bind)
 			if (serio_bind_driver(serio, drv))
 				break;
 }
@@ -246,33 +246,8 @@
 	return sprintf(buf, "%s\n", serio->name);
 }
 
-
-static ssize_t serio_show_bind_mode(struct device *dev, char *buf)
-{
-	struct serio *serio = to_serio_port(dev);
-	return sprintf(buf, "%s\n", serio->manual_bind ? "manual" : "auto");
-}
-
-static ssize_t serio_set_bind_mode(struct device *dev, const char *buf, size_t count)
-{
-	struct serio *serio = to_serio_port(dev);
-	int retval;
-
-	retval = count;
-	if (!strncmp(buf, "manual", count)) {
-		serio->manual_bind = 1;
-	} else if (!strncmp(buf, "auto", count)) {
-		serio->manual_bind = 0;
-	} else {
-		retval = -EINVAL;
-	}
-
-	return retval;
-}
-
 static struct device_attribute serio_device_attrs[] = {
 	__ATTR(description, S_IRUGO, serio_show_description, NULL),
-	__ATTR(bind_mode, S_IWUSR | S_IRUGO, serio_show_bind_mode, serio_set_bind_mode),
 	__ATTR_NULL
 };
 
@@ -347,7 +322,7 @@
 
 	if (drv)
 		serio_bind_driver(serio, drv);
-	else if (!serio->manual_bind)
+	else if (!serio->dev.manual_bind)
 		serio_find_driver(serio);
 
 	/* Ok, now bind children, if any */
@@ -359,7 +334,7 @@
 
 		serio_create_port(serio);
 
-		if (!serio->manual_bind) {
+		if (!serio->dev.manual_bind) {
 			/*
 			 * With children we just _prefer_ passed in driver,
 			 * but we will try other options in case preferred
@@ -481,34 +456,8 @@
 	return sprintf(buf, "%s\n", driver->description ? driver->description : "(none)");
 }
 
-static ssize_t serio_driver_show_bind_mode(struct device_driver *drv, char *buf)
-{
-	struct serio_driver *serio_drv = to_serio_driver(drv);
-	return sprintf(buf, "%s\n", serio_drv->manual_bind ? "manual" : "auto");
-}
-
-static ssize_t serio_driver_set_bind_mode(struct device_driver *drv, const char *buf, size_t count)
-{
-	struct serio_driver *serio_drv = to_serio_driver(drv);
-	int retval;
-
-	retval = count;
-	if (!strncmp(buf, "manual", count)) {
-		serio_drv->manual_bind = 1;
-	} else if (!strncmp(buf, "auto", count)) {
-		serio_drv->manual_bind = 0;
-	} else {
-		retval = -EINVAL;
-	}
-
-	return retval;
-}
-
-
 static struct driver_attribute serio_driver_attrs[] = {
 	__ATTR(description, S_IRUGO, serio_driver_show_description, NULL),
-	__ATTR(bind_mode, S_IWUSR | S_IRUGO,
-		serio_driver_show_bind_mode, serio_driver_set_bind_mode),
 	__ATTR_NULL
 };
 
@@ -523,7 +472,7 @@
 	drv->driver.bus = &serio_bus;
 	driver_register(&drv->driver);
 
-	if (drv->manual_bind)
+	if (drv->driver.manual_bind)
 		goto out;
 
 start_over:
diff -Nru a/drivers/input/serio/serio_raw.c b/drivers/input/serio/serio_raw.c
--- a/drivers/input/serio/serio_raw.c	2004-11-08 02:20:53 -05:00
+++ b/drivers/input/serio/serio_raw.c	2004-11-08 02:20:53 -05:00
@@ -365,14 +365,14 @@
 
 static struct serio_driver serio_raw_drv = {
 	.driver		= {
-		.name	= "serio_raw",
+		.name		= "serio_raw",
+		.manual_bind	= 1,
 	},
 	.description	= DRIVER_DESC,
 	.interrupt	= serio_raw_interrupt,
 	.connect	= serio_raw_connect,
 	.reconnect	= serio_raw_reconnect,
 	.disconnect	= serio_raw_disconnect,
-	.manual_bind	= 1,
 };
 
 int __init serio_raw_init(void)
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-11-08 02:20:53 -05:00
+++ b/include/linux/device.h	2004-11-08 02:20:53 -05:00
@@ -104,6 +104,8 @@
 	char			* name;
 	struct bus_type		* bus;
 
+	unsigned int		manual_bind;
+
 	struct semaphore	unload_sem;
 	struct kobject		kobj;
 	struct list_head	devices;
@@ -266,6 +268,9 @@
 	struct bus_type	* bus;		/* type of bus device is on */
 	struct device_driver *driver;	/* which driver has allocated this
 					   device */
+	unsigned int manual_bind;	/* indicates whether the core will
+					   try to find a driver for the
+					   device automatically */
 	void		*driver_data;	/* data private to the driver */
 	void		*platform_data;	/* Platform specific data (e.g. ACPI,
 					   BIOS data relevant to device) */
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	2004-11-08 02:20:53 -05:00
+++ b/include/linux/serio.h	2004-11-08 02:20:53 -05:00
@@ -27,8 +27,6 @@
 	char name[32];
 	char phys[32];
 
-	unsigned int manual_bind;
-
 	unsigned short idbus;
 	unsigned short idvendor;
 	unsigned short idproduct;
@@ -59,8 +57,6 @@
 struct serio_driver {
 	void *private;
 	char *description;
-
-	unsigned int manual_bind;
 
 	void (*write_wakeup)(struct serio *);
 	irqreturn_t (*interrupt)(struct serio *, unsigned char,
