Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266126AbUHYWxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266126AbUHYWxI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266293AbUHYWwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:52:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:32923 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266223AbUHYWg6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:36:58 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9-rc1
In-Reply-To: <10934733871075@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 25 Aug 2004 15:36:27 -0700
Message-Id: <10934733873951@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1803.64.6, 2004/08/24 00:09:55-07:00, corbet@lwn.net

[PATCH] Remove struct bus_type->add()

I recently went looking for users of the add() method in struct
bus_type, only to discover that there are none.  A query to Pat
confirmed that it is surplus and should come out.  So here's a patch
that does it.

While I was at it, I updated Documentation/driver-model/bus.txt to at
least get rid of the blatantly untrue stuff; it is still rather far from
being up to date, however.  I may be able to fix that later on.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/driver-model/bus.txt |   78 ++++++++++---------------------------
 include/linux/device.h             |    1 
 2 files changed, 23 insertions(+), 56 deletions(-)


diff -Nru a/Documentation/driver-model/bus.txt b/Documentation/driver-model/bus.txt
--- a/Documentation/driver-model/bus.txt	2004-08-25 14:55:33 -07:00
+++ b/Documentation/driver-model/bus.txt	2004-08-25 14:55:33 -07:00
@@ -5,20 +5,21 @@
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
@@ -47,7 +48,7 @@
 When a bus driver is initialized, it calls bus_register. This
 initializes the rest of the fields in the bus object and inserts it
 into a global list of bus types. Once the bus object is registered, 
-the fields in it (e.g. the rwlock_t) are usable by the bus driver. 
+the fields in it are usable by the bus driver. 
 
 
 Callbacks
@@ -71,40 +72,6 @@
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
@@ -118,10 +85,11 @@
 
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
@@ -168,9 +136,9 @@
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
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-08-25 14:55:33 -07:00
+++ b/include/linux/device.h	2004-08-25 14:55:33 -07:00
@@ -59,7 +59,6 @@
 	struct driver_attribute	* drv_attrs;
 
 	int		(*match)(struct device * dev, struct device_driver * drv);
-	struct device * (*add)	(struct device * parent, char * bus_id);
 	int		(*hotplug) (struct device *dev, char **envp, 
 				    int num_envp, char *buffer, int buffer_size);
 	int		(*suspend)(struct device * dev, u32 state);

