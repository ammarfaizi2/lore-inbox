Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422791AbWJSH4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422791AbWJSH4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 03:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422804AbWJSH4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 03:56:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:27820 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1422791AbWJSH4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 03:56:49 -0400
Subject: [PATCH] Add device addition/removal notifier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       Deepak Saxena <dsaxena@plexity.net>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 17:56:31 +1000
Message-Id: <1161244591.10524.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a notifier exposed by the device core to be used by
platform code to be notified of the addition and removal of devices
in the system.

It's intended as a replacement for the current platform_notify callbacks
which I'll remove as soon as we have converted the couple of users to
the new notifier.

In addition, that patch moves the remove callback & notification to after
bus_remove_device() where it belongs. The new notifier is also called
with a remove event in cases device addition fails after the platform
was notified of the addition to avoid leaks since I intend to use that
call to allocate auxilliary data structures.

The notifier approach is more interesting that just a pair of global
function pointers. For example, on powerpc, some of the new code I'm
working on involved separate subsystems requesting that to keep track
of various auxilliary informations attached to devices. PCI wants to
maintain some auxilliary data structure and this is the only good
place to actually dispose of it when a device is removed, and I have
at least one other case where the platform code wants to update the
dma operations for some types of platform devices. In addition, in
the future, I might use that to add firmware links to some other
generic bus types like USB etc... 

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Note that we might even want to add more messages to it in the future.
For example, I already have a case where I could use a notification
when a driver binds to a device, when 2 inter-dependant device/drivers
couples need to find each other.

So I'd like that in 2.6.20 if possible and there is no objection.
It should be fairly trivial to update the 2 or so users of the old
callbacks to use that new notifier and remove the old style callbacks
too, I'm waiting for feedback from them though.

Index: linux-cell/drivers/base/core.c
===================================================================
--- linux-cell.orig/drivers/base/core.c	2006-10-19 17:44:02.000000000 +1000
+++ linux-cell/drivers/base/core.c	2006-10-19 17:45:07.000000000 +1000
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/kdev_t.h>
+#include <linux/notifier.h>
 
 #include <asm/semaphore.h>
 
@@ -25,6 +26,7 @@
 
 int (*platform_notify)(struct device * dev) = NULL;
 int (*platform_notify_remove)(struct device * dev) = NULL;
+static BLOCKING_NOTIFIER_HEAD(device_notifier);
 
 /*
  * sysfs bindings for devices.
@@ -427,6 +429,9 @@ int device_add(struct device *dev)
 	/* notify platform of device entry */
 	if (platform_notify)
 		platform_notify(dev);
+	/* notify clients of device entry (new way) */
+	blocking_notifier_call_chain(&device_notifier, DEVICE_NOTIFY_ADD_DEV,
+				     dev);
 
 	dev->uevent_attr.attr.name = "uevent";
 	dev->uevent_attr.attr.mode = S_IWUSR;
@@ -499,6 +504,8 @@ int device_add(struct device *dev)
  BusError:
 	device_pm_remove(dev);
  PMError:
+	blocking_notifier_call_chain(&device_notifier, DEVICE_NOTIFY_DEL_DEV,
+				     dev);
 	device_remove_groups(dev);
  GroupError:
  	device_remove_attrs(dev);
@@ -608,12 +615,14 @@ void device_del(struct device * dev)
 	device_remove_groups(dev);
 	device_remove_attrs(dev);
 
+	bus_remove_device(dev);
 	/* Notify the platform of the removal, in case they
 	 * need to do anything...
 	 */
 	if (platform_notify_remove)
 		platform_notify_remove(dev);
-	bus_remove_device(dev);
+	blocking_notifier_call_chain(&device_notifier, DEVICE_NOTIFY_DEL_DEV,
+				     dev);
 	device_pm_remove(dev);
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	kobject_del(&dev->kobj);
@@ -836,3 +845,15 @@ int device_rename(struct device *dev, ch
 
 	return error;
 }
+
+int register_device_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&device_notifier, nb);
+}
+EXPORT_SYMBOL(register_device_notifier);
+
+int unregister_device_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&device_notifier, nb);
+}
+EXPORT_SYMBOL(unregister_device_notifier);
Index: linux-cell/include/linux/device.h
===================================================================
--- linux-cell.orig/include/linux/device.h	2006-10-19 17:43:58.000000000 +1000
+++ linux-cell/include/linux/device.h	2006-10-19 17:44:24.000000000 +1000
@@ -427,6 +427,22 @@ extern int (*platform_notify)(struct dev
 
 extern int (*platform_notify_remove)(struct device * dev);
 
+/**
+ * Device notifiers. Get notified of addition/removal of devices
+ * and possibly other events in the future. Replacement for the
+ * platform "fixup" functions. This is a low level hook provided
+ * for the platform to initialize private parts of struct device,
+ * like firmware related links. Add is called before the device is
+ * added to a bus (and thus the driver probed) and Remove is called
+ * afterward.
+ */
+struct notifier_block;
+
+extern int register_device_notifier(struct notifier_block *nb);
+extern int unregister_device_notifier(struct notifier_block *nb);
+
+#define DEVICE_NOTIFY_ADD_DEV	0x00000001	/* device added */
+#define DEVICE_NOTIFY_DEL_DEV	0x00000002	/* device removed */
 
 /**
  * get_device - atomically increment the reference count for the device.


