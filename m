Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVCJCkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVCJCkd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 21:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbVCJBN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:13:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:42399 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262607AbVCJAmW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:22 -0500
Cc: kay.sievers@vrfy.org
Subject: [PATCH] Driver core: add "bus" symlink to class/block devices
In-Reply-To: <11104148843411@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:44 -0800
Message-Id: <1110414884411@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2046, 2005/03/09 09:52:48-08:00, kay.sievers@vrfy.org

[PATCH] Driver core: add "bus" symlink to class/block devices

On Tue, Feb 15, 2005 at 09:53:44PM +0100, Kay Sievers wrote:
> Add a "bus" symlink to the class and block devices, just like the "driver"
> and "device" links. This may be a huge speed gain for e.g. udev to determine
> the bus value of a device, as we currently need to do a brute-force scan in
> /sys/bus/* to find this value.

Hmm, while playing around with it, I think we should create the "bus"
link on the physical device on not on the class device.

Also the current "driver" link at the class device should be removed,
cause class devices don't have a driver. Block devices never had this
misleading symlink.

 From the class device we point with the "device" link to the physical
 device, and only the physical device should have the "driver" and the
 "bus" link, as it represents the real relationship.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/base/bus.c   |    2 ++
 drivers/base/class.c |   36 +++++-------------------------------
 2 files changed, 7 insertions(+), 31 deletions(-)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2005-03-09 16:29:06 -08:00
+++ b/drivers/base/bus.c	2005-03-09 16:29:06 -08:00
@@ -465,6 +465,7 @@
 		up_write(&dev->bus->subsys.rwsem);
 		device_add_attrs(bus, dev);
 		sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
+		sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
 	}
 	return error;
 }
@@ -481,6 +482,7 @@
 void bus_remove_device(struct device * dev)
 {
 	if (dev->bus) {
+		sysfs_remove_link(&dev->kobj, "bus");
 		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
 		device_remove_attrs(dev->bus, dev);
 		down_write(&dev->bus->subsys.rwsem);
diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	2005-03-09 16:29:06 -08:00
+++ b/drivers/base/class.c	2005-03-09 16:29:06 -08:00
@@ -196,33 +196,6 @@
 		sysfs_remove_bin_file(&class_dev->kobj, attr);
 }
 
-static int class_device_dev_link(struct class_device * class_dev)
-{
-	if (class_dev->dev)
-		return sysfs_create_link(&class_dev->kobj,
-					 &class_dev->dev->kobj, "device");
-	return 0;
-}
-
-static void class_device_dev_unlink(struct class_device * class_dev)
-{
-	sysfs_remove_link(&class_dev->kobj, "device");
-}
-
-static int class_device_driver_link(struct class_device * class_dev)
-{
-	if ((class_dev->dev) && (class_dev->dev->driver))
-		return sysfs_create_link(&class_dev->kobj,
-					 &class_dev->dev->driver->kobj, "driver");
-	return 0;
-}
-
-static void class_device_driver_unlink(struct class_device * class_dev)
-{
-	sysfs_remove_link(&class_dev->kobj, "driver");
-}
-
-
 static ssize_t
 class_device_attr_show(struct kobject * kobj, struct attribute * attr,
 		       char * buf)
@@ -452,8 +425,9 @@
 		class_device_create_file(class_dev, &class_device_attr_dev);
 
 	class_device_add_attrs(class_dev);
-	class_device_dev_link(class_dev);
-	class_device_driver_link(class_dev);
+	if (class_dev->dev)
+		sysfs_create_link(&class_dev->kobj,
+				  &class_dev->dev->kobj, "device");
 
  register_done:
 	if (error && parent)
@@ -482,8 +456,8 @@
 		up_write(&parent->subsys.rwsem);
 	}
 
-	class_device_dev_unlink(class_dev);
-	class_device_driver_unlink(class_dev);
+	if (class_dev->dev)
+		sysfs_remove_link(&class_dev->kobj, "device");
 	class_device_remove_attrs(class_dev);
 
 	kobject_del(&class_dev->kobj);

