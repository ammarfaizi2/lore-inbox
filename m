Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWJFH4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWJFH4s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 03:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWJFH4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 03:56:48 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:53809 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750736AbWJFH4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 03:56:47 -0400
Date: Fri, 6 Oct 2006 09:57:18 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg KH <gregkh@suse.de>,
       Jaroslav Kysela <perex@suse.cz>, Jiri Kosina <jikos@jikos.cz>,
       Castet Matthieu <castet.matthieu@free.fr>, Takashi Iwai <tiwai@suse.de>,
       LKML <linux-kernel@vger.kernel.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] driver core: bus_attach_device() retval check
Message-ID: <20061006095718.5c28c809@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061006095334.3cdebcc0@gondolin.boeblingen.de.ibm.com>
References: <20061005175852.GC15180@suse.de>
	<Pine.LNX.4.44L0.0610051656290.7144-100000@iolanthe.rowland.org>
	<20061006095334.3cdebcc0@gondolin.boeblingen.de.ibm.com>
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

---
 drivers/base/base.h |    1 +
 drivers/base/bus.c  |   21 ++++++++++++++++++++-
 drivers/base/core.c |    6 +++++-
 3 files changed, 26 insertions(+), 2 deletions(-)

--- linux-2.6-CH.orig/drivers/base/base.h
+++ linux-2.6-CH/drivers/base/base.h
@@ -17,6 +17,7 @@ extern int attribute_container_init(void
 
 extern int bus_add_device(struct device * dev);
 extern int bus_attach_device(struct device * dev);
+extern void bus_delete_device(struct device * dev);
 extern void bus_remove_device(struct device * dev);
 extern struct bus_type *get_bus(struct bus_type * bus);
 extern void put_bus(struct bus_type * bus);
--- linux-2.6-CH.orig/drivers/base/bus.c
+++ linux-2.6-CH/drivers/base/bus.c
@@ -360,7 +360,7 @@ static void device_remove_attrs(struct b
  *	bus_add_device - add device to bus
  *	@dev:	device being added
  *
- *	- Add the device to its bus's list of devices.
+ *	- Add attributes.
  *	- Create link to device's bus.
  */
 int bus_add_device(struct device * dev)
@@ -424,6 +424,25 @@ int bus_attach_device(struct device * de
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
--- linux-2.6-CH.orig/drivers/base/core.c
+++ linux-2.6-CH/drivers/base/core.c
@@ -479,7 +479,9 @@ int device_add(struct device *dev)
 	if ((error = bus_add_device(dev)))
 		goto BusError;
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
-	bus_attach_device(dev);
+	error = bus_attach_device(dev);
+	if (error)
+		goto attachError;
 	if (parent)
 		klist_add_tail(&dev->knode_parent, &parent->klist_children);
 
@@ -498,6 +500,8 @@ int device_add(struct device *dev)
  	kfree(class_name);
 	put_device(dev);
 	return error;
+ attachError:
+	bus_delete_device(dev);
  BusError:
 	device_pm_remove(dev);
  PMError:
