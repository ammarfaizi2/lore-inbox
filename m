Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265383AbUHSLm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbUHSLm0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 07:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUHSLm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 07:42:26 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:1462 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S265383AbUHSLle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 07:41:34 -0400
Message-ID: <4124950B.1090706@shadowconnect.com>
Date: Thu, 19 Aug 2004 13:54:51 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: alan@lxorguk.ukuu.org.uk, wtogami@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Merge I2O patches from -mm
References: <4123E171.3070104@shadowconnect.com> <20040819002448.A3905@infradead.org> <4123E73F.7040409@shadowconnect.com> <20040819104829.A7705@infradead.org> <41247E0E.8030005@shadowconnect.com> <20040819110635.A7850@infradead.org>
In-Reply-To: <20040819110635.A7850@infradead.org>
Content-Type: multipart/mixed;
 boundary="------------000504020507070000070703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000504020507070000070703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Christoph Hellwig wrote:

> On Thu, Aug 19, 2004 at 12:16:46PM +0200, Markus Lidel wrote:
>>>Then please add more methods.  Multiplexer calls are an extremly bad idea.
>>Okay, i prefer type safety too, but i also don't like too many functions...
> Please just add a function per thing you want to do.  That's how Linux APIs
> work.

I still liked the multiplexer approach more, because there where much 
less copy-and-paste code :-)

But is it okay for you now?



Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com

--------------000504020507070000070703
Content-Type: text/x-patch;
 name="i2o-remove_notify_multiplexer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o-remove_notify_multiplexer.patch"

diff -ur a/drivers/message/i2o/device.c b/drivers/message/i2o/device.c
--- a/drivers/message/i2o/device.c	2004-08-20 12:17:00.000000000 -1000
+++ b/drivers/message/i2o/device.c	2004-08-20 14:33:36.972796000 -1000
@@ -239,6 +239,8 @@
 
 	class_device_register(&dev->classdev);
 
+	i2o_driver_notify_device_add_all(dev);
+
 	pr_debug("I2O device %s added\n", dev->device.bus_id);
 
 	return dev;
@@ -254,6 +256,7 @@
  */
 void i2o_device_remove(struct i2o_device *i2o_dev)
 {
+	i2o_driver_notify_device_remove_all(i2o_dev);
 	class_device_unregister(&i2o_dev->classdev);
 	list_del(&i2o_dev->list);
 	device_unregister(&i2o_dev->device);
diff -ur a/drivers/message/i2o/driver.c b/drivers/message/i2o/driver.c
--- a/drivers/message/i2o/driver.c	2004-08-20 12:32:13.000000000 -1000
+++ b/drivers/message/i2o/driver.c	2004-08-20 14:37:56.871285000 -1000
@@ -110,8 +110,14 @@
 
 	pr_debug("driver %s gets context id %d\n", drv->name, drv->context);
 	
-	list_for_each_entry(c, &i2o_controllers, list)
-		i2o_driver_notify(drv, I2O_DRIVER_NOTIFY_CONTROLLER_ADD, c);
+	list_for_each_entry(c, &i2o_controllers, list) {
+		struct i2o_device *i2o_dev;
+
+		i2o_driver_notify_controller_add(drv, c);
+		list_for_each_entry(i2o_dev, &c->devices, list)
+			i2o_driver_notify_device_add(drv, i2o_dev);
+	}
+
 
 	rc = driver_register(&drv->driver);
 	if (rc)
@@ -136,8 +142,14 @@
 
 	driver_unregister(&drv->driver);
 
-	list_for_each_entry(c, &i2o_controllers, list)
-		i2o_driver_notify(drv, I2O_DRIVER_NOTIFY_CONTROLLER_REMOVE, c);
+	list_for_each_entry(c, &i2o_controllers, list) {
+		struct i2o_device *i2o_dev;
+
+		list_for_each_entry(i2o_dev, &c->devices, list)
+			i2o_driver_notify_device_remove(drv, i2o_dev);
+
+		i2o_driver_notify_controller_remove(drv, c);
+	}
 
 	spin_lock_irqsave(&i2o_drivers_lock, flags);
 	i2o_drivers[drv->context] = NULL;
@@ -228,11 +240,68 @@
 }
 
 /**
- *	i2o_driver_notify_all - Send notification to all I2O drivers
+ *	i2o_driver_notify_controller_add_all - Send notify of added controller
+ *					       to all I2O drivers
+ *
+ *	Send notifications to all registered drivers that a new controller was
+ *	added.
+ */
+void i2o_driver_notify_controller_add_all(struct i2o_controller *c) {
+	int i;
+	struct i2o_driver *drv;
+
+	for(i = 0; i < I2O_MAX_DRIVERS; i ++) {
+		drv = i2o_drivers[i];
+
+		if(drv)
+			i2o_driver_notify_controller_add(drv, c);
+	}
+}
+
+/**
+ *	i2o_driver_notify_controller_remove_all - Send notify of removed
+ *						  controller to all I2O drivers
+ *
+ *	Send notifications to all registered drivers that a controller was
+ *	removed.
+ */
+void i2o_driver_notify_controller_remove_all(struct i2o_controller *c) {
+	int i;
+	struct i2o_driver *drv;
+
+	for(i = 0; i < I2O_MAX_DRIVERS; i ++) {
+		drv = i2o_drivers[i];
+
+		if(drv)
+			i2o_driver_notify_controller_remove(drv, c);
+	}
+}
+
+/**
+ *	i2o_driver_notify_device_add_all - Send notify of added device to all
+ *					   I2O drivers
+ *
+ *	Send notifications to all registered drivers that a device was added.
+ */
+void i2o_driver_notify_device_add_all(struct i2o_device *i2o_dev) {
+	int i;
+	struct i2o_driver *drv;
+
+	for(i = 0; i < I2O_MAX_DRIVERS; i ++) {
+		drv = i2o_drivers[i];
+
+		if(drv)
+			i2o_driver_notify_device_add(drv, i2o_dev);
+	}
+}
+
+/**
+ *	i2o_driver_notify_device_remove_all - Send notify of removed device to
+ *					      all I2O drivers
  *
- *	Send notifications to all registered drivers.
+ *	Send notifications to all registered drivers that a device was removed.
  */
-void i2o_driver_notify_all(enum i2o_driver_notify evt, void *data) {
+void i2o_driver_notify_device_remove_all(struct i2o_device *i2o_dev) {
 	int i;
 	struct i2o_driver *drv;
 
@@ -240,7 +309,7 @@
 		drv = i2o_drivers[i];
 
 		if(drv)
-			i2o_driver_notify(drv, evt, data);
+			i2o_driver_notify_device_remove(drv, i2o_dev);
 	}
 }
 
@@ -292,4 +361,7 @@
 
 EXPORT_SYMBOL(i2o_driver_register);
 EXPORT_SYMBOL(i2o_driver_unregister);
-EXPORT_SYMBOL(i2o_driver_notify_all);
+EXPORT_SYMBOL(i2o_driver_notify_controller_add_all);
+EXPORT_SYMBOL(i2o_driver_notify_controller_remove_all);
+EXPORT_SYMBOL(i2o_driver_notify_device_add_all);
+EXPORT_SYMBOL(i2o_driver_notify_device_remove_all);
diff -ur a/drivers/message/i2o/i2o_scsi.c b/drivers/message/i2o/i2o_scsi.c
--- a/drivers/message/i2o/i2o_scsi.c	2004-08-20 12:32:13.000000000 -1000
+++ b/drivers/message/i2o/i2o_scsi.c	2004-08-20 14:42:19.020433000 -1000
@@ -496,56 +496,58 @@
 };
 
 /**
- *	i2o_scsi_notify - Retrieve notifications of controller added or removed
- *	@notify: the notification event which occurs
- *	@data: pointer to additional data
+ *	i2o_scsi_notify_controller_add - Retrieve notifications of added
+ *					 controllers
+ *	@c: the controller which was added
  *
  *	If a I2O controller is added, we catch the notification to add a
- *	corresponding Scsi_Host. On removal also remove the Scsi_Host.
+ *	corresponding Scsi_Host.
  */
-void i2o_scsi_notify(enum i2o_driver_notify notify, void *data)
+void i2o_scsi_notify_controller_add(struct i2o_controller *c)
 {
-	struct i2o_controller *c = data;
 	struct i2o_scsi_host *i2o_shost;
 	int rc;
 
-	switch (notify) {
-	case I2O_DRIVER_NOTIFY_CONTROLLER_ADD:
-		i2o_shost = i2o_scsi_host_alloc(c);
-		if (IS_ERR(i2o_shost)) {
-			printk(KERN_ERR "scsi-osm: Could not initialize"
-			       " SCSI host\n");
-			return;
-		}
-
-		rc = scsi_add_host(i2o_shost->scsi_host, &c->device);
-		if (rc) {
-			printk(KERN_ERR "scsi-osm: Could not add SCSI "
-			       "host\n");
-			scsi_host_put(i2o_shost->scsi_host);
-			return;
-		}
-
-		c->driver_data[i2o_scsi_driver.context] = i2o_shost;
-
-		pr_debug("new I2O SCSI host added\n");
-		break;
+	i2o_shost = i2o_scsi_host_alloc(c);
+	if (IS_ERR(i2o_shost)) {
+		printk(KERN_ERR "scsi-osm: Could not initialize"
+		       " SCSI host\n");
+		return;
+	}
 
-	case I2O_DRIVER_NOTIFY_CONTROLLER_REMOVE:
-		i2o_shost = i2o_scsi_get_host(c);
-		if (!i2o_shost)
-			return;
+	rc = scsi_add_host(i2o_shost->scsi_host, &c->device);
+	if (rc) {
+		printk(KERN_ERR "scsi-osm: Could not add SCSI "
+		       "host\n");
+		scsi_host_put(i2o_shost->scsi_host);
+		return;
+	}
 
-		c->driver_data[i2o_scsi_driver.context] = NULL;
+	c->driver_data[i2o_scsi_driver.context] = i2o_shost;
 
-		scsi_remove_host(i2o_shost->scsi_host);
-		scsi_host_put(i2o_shost->scsi_host);
-		pr_debug("I2O SCSI host removed\n");
-		break;
+	pr_debug("new I2O SCSI host added\n");
+};
 
-	default:
-		break;
-	}
+/**
+ *	i2o_scsi_notify_controller_remove - Retrieve notifications of removed
+ *					    controllers
+ *	@c: the controller which was removed
+ *
+ *	If a I2O controller is removed, we catch the notification to remove the
+ *	corresponding Scsi_Host.
+ */
+void i2o_scsi_notify_controller_remove(struct i2o_controller *c)
+{
+	struct i2o_scsi_host *i2o_shost;
+	i2o_shost = i2o_scsi_get_host(c);
+	if (!i2o_shost)
+		return;
+
+	c->driver_data[i2o_scsi_driver.context] = NULL;
+
+	scsi_remove_host(i2o_shost->scsi_host);
+	scsi_host_put(i2o_shost->scsi_host);
+	pr_debug("I2O SCSI host removed\n");
 };
 
 /* SCSI OSM driver struct */
@@ -553,7 +555,8 @@
 	.name = "scsi-osm",
 	.reply = i2o_scsi_reply,
 	.classes = i2o_scsi_class_id,
-	.notify = i2o_scsi_notify,
+	.notify_controller_add = i2o_scsi_notify_controller_add,
+	.notify_controller_remove = i2o_scsi_notify_controller_remove,
 	.driver = {
 		   .probe = i2o_scsi_probe,
 		   .remove = i2o_scsi_remove,
diff -ur a/drivers/message/i2o/iop.c b/drivers/message/i2o/iop.c
--- a/drivers/message/i2o/iop.c	2004-08-20 12:32:13.000000000 -1000
+++ b/drivers/message/i2o/iop.c	2004-08-20 14:28:14.070884000 -1000
@@ -815,7 +815,7 @@
 
 	pr_debug("Deleting controller %s\n", c->name);
 
-	i2o_driver_notify_all(I2O_DRIVER_NOTIFY_CONTROLLER_REMOVE, c);
+	i2o_driver_notify_controller_remove_all(c);
 
 	list_del(&c->list);
 
@@ -1133,7 +1133,7 @@
 
 	list_add(&c->list, &i2o_controllers);
 
-	i2o_driver_notify_all(I2O_DRIVER_NOTIFY_CONTROLLER_ADD, c);
+	i2o_driver_notify_controller_add_all(c);
 
 	printk(KERN_INFO "%s: Controller added\n", c->name);
 
diff -ur a/include/linux/i2o.h b/include/linux/i2o.h
--- a/include/linux/i2o.h	2004-08-20 12:37:45.000000000 -1000
+++ b/include/linux/i2o.h	2004-08-20 14:37:07.000000000 -1000
@@ -33,11 +33,6 @@
 /* message queue empty */
 #define I2O_QUEUE_EMPTY		0xffffffff
 
-enum i2o_driver_notify {
-	I2O_DRIVER_NOTIFY_CONTROLLER_ADD = 0,
-	I2O_DRIVER_NOTIFY_CONTROLLER_REMOVE = 1,
-};
-
 /*
  *	Message structures
  */
@@ -115,7 +110,10 @@
 	struct device_driver driver;
 
 	/* notification of changes */
-	void (*notify) (enum i2o_driver_notify, void *);
+	void (*notify_controller_add) (struct i2o_controller *);
+	void (*notify_controller_remove) (struct i2o_controller *);
+	void (*notify_device_add) (struct i2o_device *);
+	void (*notify_device_remove) (struct i2o_device *);
 
 	struct semaphore lock;
 };
@@ -325,18 +323,61 @@
 extern void i2o_driver_unregister(struct i2o_driver *);
 
 /**
- *	i2o_driver_notify - Send notification to a single I2O drivers
+ *	i2o_driver_notify_controller_add - Send notification of added controller
+ *					   to a single I2O driver
  *
- *	Send notifications to a single registered driver.
+ *	Send notification of added controller to a single registered driver.
  */
-static inline void i2o_driver_notify(struct i2o_driver *drv,
-				     enum i2o_driver_notify notify, void *data)
+static inline void i2o_driver_notify_controller_add(struct i2o_driver *drv,
+						    struct i2o_controller *c)
 {
-	if (drv->notify)
-		drv->notify(notify, data);
-}
+	if (drv->notify_controller_add)
+		drv->notify_controller_add(c);
+};
+
+/**
+ *	i2o_driver_notify_controller_remove - Send notification of removed
+ *					      controller to a single I2O driver
+ *
+ *	Send notification of removed controller to a single registered driver.
+ */
+static inline void i2o_driver_notify_controller_remove(struct i2o_driver *drv,
+						       struct i2o_controller *c)
+{
+	if (drv->notify_controller_remove)
+		drv->notify_controller_remove(c);
+};
+
+/**
+ *	i2o_driver_notify_device_add - Send notification of added device to a
+ *				       single I2O driver
+ *
+ *	Send notification of added device to a single registered driver.
+ */
+static inline void i2o_driver_notify_device_add(struct i2o_driver *drv,
+						struct i2o_device *i2o_dev)
+{
+	if (drv->notify_device_add)
+		drv->notify_device_add(i2o_dev);
+};
+
+/**
+ *	i2o_driver_notify_device_remove - Send notification of removed device
+ *					  to a single I2O driver
+ *
+ *	Send notification of removed device to a single registered driver.
+ */
+static inline void i2o_driver_notify_device_remove(struct i2o_driver *drv,
+						   struct i2o_device *i2o_dev)
+{
+	if (drv->notify_device_remove)
+		drv->notify_device_remove(i2o_dev);
+};
 
-extern void i2o_driver_notify_all(enum i2o_driver_notify, void *);
+extern void i2o_driver_notify_controller_add_all(struct i2o_controller *);
+extern void i2o_driver_notify_controller_remove_all(struct i2o_controller *);
+extern void i2o_driver_notify_device_add_all(struct i2o_device *);
+extern void i2o_driver_notify_device_remove_all(struct i2o_device *);
 
 /* I2O device functions */
 extern int i2o_device_claim(struct i2o_device *);

--------------000504020507070000070703--
