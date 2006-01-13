Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbWAMB5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWAMB5D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 20:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWAMB5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 20:57:03 -0500
Received: from soundwarez.org ([217.160.171.123]:21389 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S964947AbWAMB5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 20:57:01 -0500
Date: Fri, 13 Jan 2006 02:56:52 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: unify sysfs device tree
Message-ID: <20060113015652.GA30796@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a first test of the unification of the sysfs device tree. As already
discussed to end in the context of stacked class devices, it moves all device
objects into a single device tree at /sys/devices to expose the kernels device
hierarchy to userspace.

All former objects in /sys/class will become only symlinks and are compatible
to our current layout. This approach will not mix classification and device
hierarchy.

The hierarchy in /sys/devices is not necessarily expected to be stable across
kernel versions, it must be allowed to insert devices in the tree if needed,
without breaking userspace applications. But the links in /sys/class are
expected to be kept stable, but that's easy now, cause they will always be
simple flat directories.

Every device event sent to userspace contains its natural dependency path in the
DEVPATH, the ugly "device" symlink can be removed.

This patch is a simple hack, cause I want to prepare userspace to work with
that. It already works without any problems on a recent udev system. (Besides
HAL which needs to be adapted.)

The same way /sys/class is represented, /sys/block should be converted, so we
finally end up with a buch of symlinks in /sys/class/block.

There is a lot of room for improvement in the driver core, cause a whole lot
of infrastructure could be shared between the class / block / device core, if
we only build a single device tree, but that's a different issue and independent
from how it will looks like to userspace.

Here is for illustration the "input" layer as a flat /sys/class directory. All
devices point to /sys/devices which exposes the device hierarchy if userspace
wants to know that:
	/sys/class/
	...
	|-- input
	|   |-- input0 -> ../../devices/platform/i8042/serio1/input0
	|   |-- input1 -> ../../devices/platform/i8042/serio0/input1
	|   |-- input3 -> ../../devices/platform/i8042/serio0/serio2/input3
	|   |-- input4 -> ../../devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/input4
	|   |-- mice -> ../../devices/mice
	|   |-- mouse0 -> ../../devices/platform/i8042/serio0/input1/mouse0
	|   |-- mouse1 -> ../../devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/input4/mouse1
	|   `-- mouse2 -> ../../devices/platform/i8042/serio0/serio2/input3/mouse2
	|-- mem
	|   |-- full -> ../../devices/full
	|   |-- kmem -> ../../devices/kmem
	|   |-- kmsg -> ../../devices/kmsg
	|   |-- mem -> ../../devices/mem
	|   |-- null -> ../../devices/null
	|   |-- port -> ../../devices/port
	|   |-- random -> ../../devices/random
	|   |-- urandom -> ../../devices/urandom
	|   `-- zero -> ../../devices/zero
	...


	/sys/devices/
	|-- platform
	|   |-- i8042
	|   |   |-- bus -> ../../../bus/platform
	|   |   |-- driver -> ../../../bus/platform/drivers/i8042
	|   |   |-- power
	|   |   |   |-- state
	|   |   |   `-- wakeup
	|   |   |-- serio0
	|   |   |   |-- bind_mode
	|   |   |   |-- bus -> ../../../../bus/serio
	|   |   |   |-- description
	|   |   |   |-- driver -> ../../../../bus/serio/drivers/psmouse
	|   |   |   |-- drvctl
	|   |   |   |-- id
	...
	|   |   |   |   `-- type
	|   |   |   |-- input1
	|   |   |   |   |-- capabilities
	...
	|   |   |   |   |   `-- sw
	|   |   |   |   |-- device -> ../../../../../devices/platform/i8042/serio0
	|   |   |   |   |-- id
	...
	|   |   |   |   |   `-- version
	|   |   |   |   |-- modalias
	|   |   |   |   |-- mouse0
	|   |   |   |   |   |-- dev
	|   |   |   |   |   |-- device -> ../../../../../../devices/platform/i8042/serio0
	|   |   |   |   |   |-- subsystem -> ../../../../../../class/input
	|   |   |   |   |   `-- uevent
	...


This is the event sequence for a USB mouse, there are no "class" events
anymore:
	add@/devices/pci0000:00/0000:00:1d.1/usb3/3-2
	add@/devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0
	add@/devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/input5
	add@/devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/input5/mouse1
	add@/devices/pci0000:00/0000:00:1d.1/usb3/3-2/usbdev3.4

Thanks,
Kay

---
Unify sysfs device tree

Move device objects from /sys/class to /sys/devices and add a link
from /sys/class to the device object.

diff --git a/drivers/base/class.c b/drivers/base/class.c
index df7fdab..8818543 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -20,6 +20,8 @@
 #include <linux/slab.h>
 #include "base.h"
 
+extern struct subsystem devices_subsys;
+
 #define to_class_attr(_attr) container_of(_attr, struct class_attribute, attr)
 #define to_class(obj) container_of(obj, struct class, subsys.kset.kobj)
 
@@ -518,15 +520,25 @@ int class_device_add(struct class_device
 
 	/* first, register with generic layer. */
 	kobject_set_name(&class_dev->kobj, "%s", class_dev->class_id);
+
+	/* set parent for sysfs location */
 	if (parent_class_dev)
 		class_dev->kobj.parent = &parent_class_dev->kobj;
+	else if (class_dev->dev)
+		class_dev->kobj.parent = &class_dev->dev->kobj;
 	else
-		class_dev->kobj.parent = &parent_class->subsys.kset.kobj;
+		class_dev->kobj.parent = &devices_subsys.kset.kobj;
 
 	error = kobject_add(&class_dev->kobj);
 	if (error)
 		goto register_done;
 
+	/* create link from class to device object */
+	sysfs_create_link(&parent_class->subsys.kset.kobj, &class_dev->kobj, class_dev->class_id);
+
+	/* create link from device object back to class */
+	sysfs_create_link(&class_dev->kobj, &parent_class->subsys.kset.kobj, "subsystem");
+
 	/* add the needed attributes to this device */
 	class_dev->uevent_attr.attr.name = "uevent";
 	class_dev->uevent_attr.attr.mode = S_IWUSR;
@@ -664,6 +676,8 @@ void class_device_del(struct class_devic
 		up(&parent_class->sem);
 	}
 
+	sysfs_remove_link(&class_dev->kobj, "subsystem");
+
 	if (class_dev->dev) {
 		class_name = make_class_name(class_dev);
 		sysfs_remove_link(&class_dev->kobj, "device");
@@ -675,6 +689,7 @@ void class_device_del(struct class_devic
 	class_device_remove_attrs(class_dev);
 
 	kobject_uevent(&class_dev->kobj, KOBJ_REMOVE);
+	sysfs_remove_link(&parent_class->subsys.kset.kobj, class_dev->class_id);
 	kobject_del(&class_dev->kobj);
 
 	class_device_put(parent_device);
diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 745979f..f78fb1d 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -630,10 +630,6 @@ static struct input_handle *evdev_connec
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
 			dev->cdev.dev, evdev->name);
 
-	/* temporary symlink to keep userspace happy */
-	sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
-			  evdev->name);
-
 	return &evdev->handle;
 }
 
@@ -642,7 +638,6 @@ static void evdev_disconnect(struct inpu
 	struct evdev *evdev = handle->private;
 	struct evdev_list *list;
 
-	sysfs_remove_link(&input_class.subsys.kset.kobj, evdev->name);
 	class_device_destroy(&input_class,
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + evdev->minor));
 	evdev->exist = 0;
diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 20e2972..ecf8919 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -518,10 +518,6 @@ static struct input_handle *joydev_conne
 			MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
 			dev->cdev.dev, joydev->name);
 
-	/* temporary symlink to keep userspace happy */
-	sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
-			  joydev->name);
-
 	return &joydev->handle;
 }
 
@@ -530,7 +526,6 @@ static void joydev_disconnect(struct inp
 	struct joydev *joydev = handle->private;
 	struct joydev_list *list;
 
-	sysfs_remove_link(&input_class.subsys.kset.kobj, joydev->name);
 	class_device_destroy(&input_class, MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + joydev->minor));
 	joydev->exist = 0;
 
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 81fd7a9..4e0881b 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -653,10 +653,6 @@ static struct input_handle *mousedev_con
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
 			dev->cdev.dev, mousedev->name);
 
-	/* temporary symlink to keep userspace happy */
-	sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
-			  mousedev->name);
-
 	return &mousedev->handle;
 }
 
@@ -665,7 +661,6 @@ static void mousedev_disconnect(struct i
 	struct mousedev *mousedev = handle->private;
 	struct mousedev_list *list;
 
-	sysfs_remove_link(&input_class.subsys.kset.kobj, mousedev->name);
 	class_device_destroy(&input_class,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + mousedev->minor));
 	mousedev->exist = 0;
diff --git a/drivers/input/tsdev.c b/drivers/input/tsdev.c
index ca15479..cfd4dee 100644
--- a/drivers/input/tsdev.c
+++ b/drivers/input/tsdev.c
@@ -414,10 +414,6 @@ static struct input_handle *tsdev_connec
 			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
 			dev->cdev.dev, tsdev->name);
 
-	/* temporary symlink to keep userspace happy */
-	sysfs_create_link(&input_class.subsys.kset.kobj, &cdev->kobj,
-			  tsdev->name);
-
 	return &tsdev->handle;
 }
 
@@ -426,7 +422,6 @@ static void tsdev_disconnect(struct inpu
 	struct tsdev *tsdev = handle->private;
 	struct tsdev_list *list;
 
-	sysfs_remove_link(&input_class.subsys.kset.kobj, tsdev->name);
 	class_device_destroy(&input_class,
 			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + tsdev->minor));
 	tsdev->exist = 0;

