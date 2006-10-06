Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWJFLON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWJFLON (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWJFLON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:14:13 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:63606 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750745AbWJFLOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:14:12 -0400
Date: Fri, 6 Oct 2006 13:14:43 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       ALSA development <alsa-devel@alsa-project.org>,
       Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>,
       LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@jikos.cz>,
       Castet Matthieu <castet.matthieu@free.fr>
Subject: Re: [Alsa-devel] [PATCH] Driver core: Don't ignore error returns
 from probing
Message-ID: <20061006131443.473c203c@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <Pine.LNX.4.61.0610061138580.8573@tm8103.perex-int.cz>
References: <20061005175852.GC15180@suse.de>
	<Pine.LNX.4.44L0.0610051656290.7144-100000@iolanthe.rowland.org>
	<20061006095334.3cdebcc0@gondolin.boeblingen.de.ibm.com>
	<Pine.LNX.4.61.0610061138580.8573@tm8103.perex-int.cz>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006 11:41:05 +0200 (CEST),
Jaroslav Kysela <perex@suse.cz> wrote:

> > Hm, I don't think we should call device_release_driver if
> > bus_attach_device failed (and I think calling bus_remove_device if
> > bus_attach_device failed is unintuitive). I did a patch that added a
> > function which undid just the things bus_add_device did (here:
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=115816560424389&w=2),
> > which unfortunately got lost somewhere... (I'll rebase and resend.)
> 
> Yes, but it might be better to check dev->is_registered flag in 
> bus_remove_device() before device_release_driver() call to save some code, 
> rather than reuse most of code in bus_delete_device().

If we undid things (symlinks et al.) in the order we added them, we can
factor out bus_delete_device() from bus_remove_device() and avoid both
code duplication and calling bus_remove_device() if bus_attach_device()
failed. Something like the patch below (untested).


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
@@ -424,29 +424,44 @@ int bus_attach_device(struct device * de
 }
 
 /**
- *	bus_remove_device - remove device from bus
- *	@dev:	device to be removed
+ *     bus_delete_device - undo bus_add_device
+ *     @dev:   device being deleted
  *
- *	- Remove symlink from bus's directory.
- *	- Delete device from bus's list.
- *	- Detach from its driver.
- *	- Drop reference taken in bus_add_device().
+ *     - Remove symlink from bus's directory.
+ *     - Remove attributes.
+ *     - Drop reference taken in bus_add_device().
  */
-void bus_remove_device(struct device * dev)
+void bus_delete_device(struct device * dev)
 {
 	if (dev->bus) {
 		sysfs_remove_link(&dev->kobj, "subsystem");
 		sysfs_remove_link(&dev->kobj, "bus");
 		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
 		device_remove_attrs(dev->bus, dev);
-		dev->is_registered = 0;
-		klist_del(&dev->knode_bus);
-		pr_debug("bus %s: remove device %s\n", dev->bus->name, dev->bus_id);
-		device_release_driver(dev);
 		put_bus(dev->bus);
 	}
 }
 
+/**
+ *	bus_remove_device - remove device from bus
+ *	@dev:	device to be removed
+ *
+ *	- Remove symlink from bus's directory.
+ *	- Delete device from bus's list.
+ *	- Detach from its driver.
+ *	- Drop reference taken in bus_add_device().
+ */
+void bus_remove_device(struct device * dev)
+{
+	if (!dev->bus)
+		return;
+	dev->is_registered = 0;
+	klist_del(&dev->knode_bus);
+	pr_debug("bus %s: remove device %s\n", dev->bus->name, dev->bus_id);
+	device_release_driver(dev);
+	bus_delete_device(dev);
+}
+
 static int driver_add_attrs(struct bus_type * bus, struct device_driver * drv)
 {
 	int error = 0;
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
