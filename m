Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263231AbSJIAtu>; Tue, 8 Oct 2002 20:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbSJIAtt>; Tue, 8 Oct 2002 20:49:49 -0400
Received: from air-2.osdl.org ([65.172.181.6]:39852 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S263215AbSJIAtS>;
	Tue, 8 Oct 2002 20:49:18 -0400
Date: Tue, 8 Oct 2002 17:57:23 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210081747180.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210081757150.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.598, 2002-10-08 17:23:05-07:00, mochel@osdl.org
  driver model: and present field to struct device and implement device_unregister().
  
  device_unregister() is intended to be the complement of device_register(), and assumes
  most of the functionality of the current put_device(). It should be called by the bus 
  driver when a device is physically removed from the system. 
  
  It should _not_ be called from a driver's remove() method, as that remove() method is called
  via device_detach() in device_unregister(). 
  
  dev->present is used to flag the physical presence of the device. It is set when the device
  is registered, and cleared when unregistered. get_device() checks this flag, and returns
  a NULL pointer if cleared. This prevents anyone from obtaining a reference to a device
  that has been unregistered (removed), but not yet been freed (e.g. if someone else is 
  holding a reference to it).
  
  put_device() BUG()s if dev->present is set. A device should be unregistered before it is 
  freed. This will catch people doing it in the wrong order. 

diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Tue Oct  8 17:55:22 2002
+++ b/drivers/base/core.c	Tue Oct  8 17:55:22 2002
@@ -175,7 +175,7 @@
 	INIT_LIST_HEAD(&dev->intf_list);
 	spin_lock_init(&dev->lock);
 	atomic_set(&dev->refcount,2);
-	
+	dev->present = 1;
 	spin_lock(&device_lock);
 	if (dev->parent) {
 		get_device_locked(dev->parent);
@@ -219,7 +219,7 @@
 struct device * get_device_locked(struct device * dev)
 {
 	struct device * ret = dev;
-	if (dev && atomic_read(&dev->refcount) > 0)
+	if (dev && dev->present && atomic_read(&dev->refcount) > 0)
 		atomic_inc(&dev->refcount);
 	else
 		ret = NULL;
@@ -241,8 +241,35 @@
  */
 void put_device(struct device * dev)
 {
+	struct device * parent;
 	if (!atomic_dec_and_lock(&dev->refcount,&device_lock))
 		return;
+	parent = dev->parent;
+	dev->parent = NULL;
+	spin_unlock(&device_lock);
+
+	BUG_ON(dev->present);
+
+	if (dev->release)
+		dev->release(dev);
+
+	if (parent)
+		put_device(parent);
+}
+
+/**
+ * device_unregister - unlink device
+ * @dev:	device going away
+ *
+ * The device has been removed from the system, so we disavow knowledge
+ * of it. It might not be the final reference to the device, so we mark
+ * it as !present, so no more references to it can be acquired.
+ * In the end, we decrement the final reference count for it.
+ */
+void device_unregister(struct device * dev)
+{
+	spin_lock(&device_lock);
+	dev->present = 0;
 	list_del_init(&dev->node);
 	list_del_init(&dev->g_list);
 	list_del_init(&dev->bus_list);
@@ -267,11 +294,7 @@
 	/* remove the driverfs directory */
 	device_remove_dir(dev);
 
-	if (dev->release)
-		dev->release(dev);
-
-	if (dev->parent)
-		put_device(dev->parent);
+	put_device(dev);
 }
 
 static int __init device_init(void)
@@ -287,5 +310,6 @@
 core_initcall(device_init);
 
 EXPORT_SYMBOL(device_register);
+EXPORT_SYMBOL(device_unregister);
 EXPORT_SYMBOL(get_device);
 EXPORT_SYMBOL(put_device);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Tue Oct  8 17:55:22 2002
+++ b/include/linux/device.h	Tue Oct  8 17:55:22 2002
@@ -289,6 +289,7 @@
 	void		*platform_data;	/* Platform specific data (e.g. ACPI,
 					   BIOS data relevant to device) */
 
+	u32		present;
 	u32		current_state;  /* Current operating state. In
 					   ACPI-speak, this is D0-D3, D0
 					   being fully functional, and D3
@@ -327,7 +328,7 @@
  * High level routines for use by the bus drivers
  */
 extern int device_register(struct device * dev);
-
+extern void device_unregister(struct device * dev);
 
 /* driverfs interface for exporting device attributes */
 

