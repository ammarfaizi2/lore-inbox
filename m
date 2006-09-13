Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWIMQjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWIMQjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWIMQip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:38:45 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:23636 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750752AbWIMQij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:38:39 -0400
Date: Wed, 13 Sep 2006 18:38:58 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [09/12] driver core fixes: bus_attach_device() retval check
Message-ID: <20060913183858.589a3842@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
References: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Check for return value of bus_attach_device() in device_add(). Add a
function bus_delete_device() that undos the effects of bus_add_device().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

 base.h |    1 +
 bus.c  |   21 ++++++++++++++++++++-
 core.c |    6 +++++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff -Naurp linux-2.6.18-rc6/drivers/base/base.h linux-2.6.18-rc6+CH/drivers/base/base.h
--- linux-2.6.18-rc6/drivers/base/base.h	2006-09-12 14:15:16.000000000 +0200
+++ linux-2.6.18-rc6+CH/drivers/base/base.h	2006-09-12 18:42:08.000000000 +0200
@@ -17,6 +17,7 @@ extern int attribute_container_init(void
 
 extern int bus_add_device(struct device * dev);
 extern int bus_attach_device(struct device * dev);
+extern void bus_delete_device(struct device * dev);
 extern void bus_remove_device(struct device * dev);
 extern struct bus_type *get_bus(struct bus_type * bus);
 extern void put_bus(struct bus_type * bus);
diff -Naurp linux-2.6.18-rc6/drivers/base/bus.c linux-2.6.18-rc6+CH/drivers/base/bus.c
--- linux-2.6.18-rc6/drivers/base/bus.c	2006-09-12 18:28:12.000000000 +0200
+++ linux-2.6.18-rc6+CH/drivers/base/bus.c	2006-09-12 18:44:24.000000000 +0200
@@ -360,7 +360,7 @@ static void device_remove_attrs(struct b
  *	bus_add_device - add device to bus
  *	@dev:	device being added
  *
- *	- Add the device to its bus's list of devices.
+ *	- Add attributes.
  *	- Create link to device's bus.
  */
 int bus_add_device(struct device * dev)
@@ -420,6 +420,25 @@ int bus_attach_device(struct device * de
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
diff -Naurp linux-2.6.18-rc6/drivers/base/core.c linux-2.6.18-rc6+CH/drivers/base/core.c
--- linux-2.6.18-rc6/drivers/base/core.c	2006-09-12 18:40:36.000000000 +0200
+++ linux-2.6.18-rc6+CH/drivers/base/core.c	2006-09-12 18:41:31.000000000 +0200
@@ -456,7 +456,9 @@ int device_add(struct device *dev)
 	if ((error = bus_add_device(dev)))
 		goto BusError;
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
-	bus_attach_device(dev);
+	error = bus_attach_device(dev);
+	if (error)
+		goto attachError;
 	if (parent)
 		klist_add_tail(&dev->knode_parent, &parent->klist_children);
 
@@ -470,6 +472,8 @@ int device_add(struct device *dev)
  	kfree(class_name);
 	put_device(dev);
 	return error;
+ attachError:
+	bus_delete_device(dev);
  BusError:
 	device_pm_remove(dev);
  PMError:
