Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264371AbUHSTkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbUHSTkG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267303AbUHSTkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:40:06 -0400
Received: from vena.lwn.net ([206.168.112.25]:18334 "HELO lwn.net")
	by vger.kernel.org with SMTP id S264371AbUHSTjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:39:54 -0400
Message-ID: <20040819193952.10320.qmail@lwn.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove struct bus_type->add()
cc: mochel@digitalimplant.org, greg@kroah.com
From: Jonathan Corbet <corbet@lwn.net>
Date: Thu, 19 Aug 2004 13:39:52 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently went looking for users of the add() method in struct
bus_type, only to discover that there are none.  A query to Pat
confirmed that it is surplus and should come out.  So here's a patch
that does it.

While I was at it, I updated Documentation/driver-model/bus.txt to at
least get rid of the blatantly untrue stuff; it is still rather far from
being up to date, however.  I may be able to fix that later on.

jon



diff -urNp -X dontdiff 2.6.8.1-vanilla/Documentation/driver-model/bus.txt 2.6.8.1/Documentation/driver-model/bus.txt
--- 2.6.8.1-vanilla/Documentation/driver-model/bus.txt	2003-09-08 13:50:08.000000000 -0600
+++ 2.6.8.1/Documentation/driver-model/bus.txt	2004-08-19 13:32:57.876228616 -0600
@@ -5,20 +5,21 @@ Definition
 ~~~~~~~~~~
 
 struct bus_type {
-        char                    * name;
-        rwlock_t                lock;
-        atomic_t                refcount;
-
-        struct list_head        node;
-        struct list_head        devices;
-        struct list_head        drivers;
-
-        struct driver_dir_entry dir;
-        struct driver_dir_entry device_dir;
-        struct driver_dir_entry driver_dir;
+	char			* name;
 
-        int     (*match)        (struct device * dev, struct device_driver * drv);
-	struct device (*add)	(struct device * parent, char * bus_id);
+	struct subsystem	subsys;
+	struct kset		drivers;
+	struct kset		devices;
+
+	struct bus_attribute	* bus_attrs;
+	struct device_attribute	* dev_attrs;
+	struct driver_attribute	* drv_attrs;
+
+	int		(*match)(struct device * dev, struct device_driver * drv);
+	int		(*hotplug) (struct device *dev, char **envp, 
+				    int num_envp, char *buffer, int buffer_size);
+	int		(*suspend)(struct device * dev, u32 state);
+	int		(*resume)(struct device * dev);
 };
 
 int bus_register(struct bus_type * bus);
@@ -47,7 +48,7 @@ Registration
 When a bus driver is initialized, it calls bus_register. This
 initializes the rest of the fields in the bus object and inserts it
 into a global list of bus types. Once the bus object is registered, 
-the fields in it (e.g. the rwlock_t) are usable by the bus driver. 
+the fields in it are usable by the bus driver. 
 
 
 Callbacks
@@ -71,40 +72,6 @@ When a driver is registered with the bus
 iterated over, and the match callback is called for each device that
 does not have a driver associated with it. 
 
-add(): Adding a child device
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-The add callback is available to notify the bus about a child device
-at a particular location. 
-
-The parent parameter is the parent device of the child to be added. If
-parent == NULL, the bus should add the device as a child of a default
-parent device or as a child of the root. This policy decision is up to
-the bus driver.
-
-The format of the bus_id field should be consistent with the format of
-the bus_id field of the rest of the devices on the bus. This requires
-the caller to know the format.
-
-On return, the bus driver should return a pointer to the device that
-was created. If the device was not created, the bus driver should
-return an appropriate error code. Refer to include/linux/err.h for
-helper functions to encode errors. Some sample code:
-
-struct device * pci_bus_add(struct device * parent, char * bus_id)
-{
-	...
-	/* the device already exists */
-	return ERR_PTR(-EEXIST);
-	...
-}
-
-The caller can check the return value using IS_ERR():
-
-    struct device * newdev = pci_bus_type.add(parent,bus_id);
-    if (IS_ERR(newdev)) {
-	...
-    }
 
 
 Device and Driver Lists
@@ -118,10 +85,11 @@ necessary. 
 
 The LDM core provides helper functions for iterating over each list.
 
-int bus_for_each_dev(struct bus_type * bus, void * data, 
-		     int (*callback)(struct device * dev, void * data));
-int bus_for_each_drv(struct bus_type * bus, void * data,
-		     int (*callback)(struct device_driver * drv, void * data));
+int bus_for_each_dev(struct bus_type * bus, struct device * start, void * data,
+		     int (*fn)(struct device *, void *));
+
+int bus_for_each_drv(struct bus_type * bus, struct device_driver * start, 
+		     void * data, int (*fn)(struct device_driver *, void *));
 
 These helpers iterate over the respective list, and call the callback
 for each device or driver in the list. All list accesses are
@@ -168,9 +136,9 @@ hierarchy:
 Exporting Attributes
 ~~~~~~~~~~~~~~~~~~~~
 struct bus_attribute {
-        struct attribute        attr;
-        ssize_t (*show)(struct bus_type *, char * buf, size_t count, loff_t off);
-        ssize_t (*store)(struct bus_type *, const char * buf, size_t count, loff_t off);
+	struct attribute	attr;
+	ssize_t (*show)(struct bus_type *, char * buf);
+	ssize_t (*store)(struct bus_type *, const char * buf, size_t count);
 };
 
 Bus drivers can export attributes using the BUS_ATTR macro that works
diff -urNp -X dontdiff 2.6.8.1-vanilla/include/linux/device.h 2.6.8.1/include/linux/device.h
--- 2.6.8.1-vanilla/include/linux/device.h	2004-08-19 13:36:08.791205128 -0600
+++ 2.6.8.1/include/linux/device.h	2004-08-19 13:26:00.403694088 -0600
@@ -59,7 +59,6 @@ struct bus_type {
 	struct driver_attribute	* drv_attrs;
 
 	int		(*match)(struct device * dev, struct device_driver * drv);
-	struct device * (*add)	(struct device * parent, char * bus_id);
 	int		(*hotplug) (struct device *dev, char **envp, 
 				    int num_envp, char *buffer, int buffer_size);
 	int		(*suspend)(struct device * dev, u32 state);
