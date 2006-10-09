Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWJILOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWJILOE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 07:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWJILOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 07:14:04 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:6687 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932352AbWJILOD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 07:14:03 -0400
Date: Mon, 9 Oct 2006 13:14:34 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jaroslav Kysela <perex@suse.cz>, Andrew Morton <akpm@osdl.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>,
       Castet Matthieu <castet.matthieu@free.fr>,
       Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH] Driver core: Don't ignore bus_attach_device() retval
Message-ID: <20061009131434.6e3ff0e2@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <Pine.LNX.4.44L0.0610061400180.1311-100000@netrider.rowland.org>
References: <20061006131443.473c203c@gondolin.boeblingen.de.ibm.com>
	<Pine.LNX.4.44L0.0610061400180.1311-100000@netrider.rowland.org>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Check for return value of bus_attach_device() in device_add(). Add a
function bus_delete_device() that undos the effects of bus_add_device().
bus_remove_device() now undos the effects of bus_attach_device() only.
device_del() now calls bus_remove_device(), kobject_uevent(),
bus_delete_device() which makes it symmetric to the call sequence in
device_add().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/base.h |    1 +
 drivers/base/bus.c  |   31 ++++++++++++++++++++++---------
 drivers/base/core.c |    7 ++++++-
 3 files changed, 29 insertions(+), 10 deletions(-)

--- linux.orig/drivers/base/base.h
+++ linux/drivers/base/base.h
@@ -17,6 +17,7 @@ extern int attribute_container_init(void
 
 extern int bus_add_device(struct device * dev);
 extern int bus_attach_device(struct device * dev);
+extern void bus_delete_device(struct device * dev);
 extern void bus_remove_device(struct device * dev);
 extern struct bus_type *get_bus(struct bus_type * bus);
 extern void put_bus(struct bus_type * bus);
--- linux.orig/drivers/base/bus.c
+++ linux/drivers/base/bus.c
@@ -360,7 +360,7 @@ static void device_remove_attrs(struct b
  *	bus_add_device - add device to bus
  *	@dev:	device being added
  *
- *	- Add the device to its bus's list of devices.
+ *	- Add attributes.
  *	- Create link to device's bus.
  */
 int bus_add_device(struct device * dev)
@@ -424,26 +424,39 @@ int bus_attach_device(struct device * de
 }
 
 /**
+ *     bus_delete_device - undo bus_add_device
+ *     @dev:   device being deleted
+ *
+ *     - Remove symlink from bus's directory.
+ *     - Remove attributes.
+ *     - Drop reference taken in bus_add_device().
+ */
+void bus_delete_device(struct device * dev)
+{
+	if (dev->bus) {
+		sysfs_remove_link(&dev->kobj, "subsystem");
+		sysfs_remove_link(&dev->kobj, "bus");
+		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
+		device_remove_attrs(dev->bus, dev);
+		put_bus(dev->bus);
+	}
+}
+
+/**
  *	bus_remove_device - remove device from bus
  *	@dev:	device to be removed
  *
- *	- Remove symlink from bus's directory.
  *	- Delete device from bus's list.
  *	- Detach from its driver.
- *	- Drop reference taken in bus_add_device().
  */
 void bus_remove_device(struct device * dev)
 {
 	if (dev->bus) {
-		sysfs_remove_link(&dev->kobj, "subsystem");
-		sysfs_remove_link(&dev->kobj, "bus");
-		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
-		device_remove_attrs(dev->bus, dev);
 		dev->is_registered = 0;
 		klist_del(&dev->knode_bus);
-		pr_debug("bus %s: remove device %s\n", dev->bus->name, dev->bus_id);
+		pr_debug("bus %s: remove device %s\n", dev->bus->name,
+			 dev->bus_id);
 		device_release_driver(dev);
-		put_bus(dev->bus);
 	}
 }
 
--- linux.orig/drivers/base/core.c
+++ linux/drivers/base/core.c
@@ -479,7 +479,9 @@ int device_add(struct device *dev)
 	if ((error = bus_add_device(dev)))
 		goto BusError;
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
-	bus_attach_device(dev);
+	error = bus_attach_device(dev);
+	if (error)
+		goto AttachError;
 	if (parent)
 		klist_add_tail(&dev->knode_parent, &parent->klist_children);
 
@@ -498,6 +500,8 @@ int device_add(struct device *dev)
  	kfree(class_name);
 	put_device(dev);
 	return error;
+ AttachError:
+	bus_delete_device(dev);
  BusError:
 	device_pm_remove(dev);
  PMError:
@@ -620,6 +624,7 @@ void device_del(struct device * dev)
 	bus_remove_device(dev);
 	device_pm_remove(dev);
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
+	bus_delete_device(dev);
 	kobject_del(&dev->kobj);
 	if (parent)
 		put_device(parent);
