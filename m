Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVBOWEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVBOWEn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 17:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVBOWEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:04:43 -0500
Received: from soundwarez.org ([217.160.171.123]:42400 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261905AbVBOWEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:04:12 -0500
Date: Tue, 15 Feb 2005 23:04:06 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] add "bus" symlink to class/block devices
Message-ID: <20050215220406.GA1419@vrfy.org>
References: <20050215205344.GA1207@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215205344.GA1207@vrfy.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

>From the class device we point with the "device" link to the physical
device, and only the physical device should have the "driver" and the
"bus" link, as it represents the real relationship.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

+++ edited/drivers/base/bus.c	2005-02-15 22:33:37 +01:00
@@ -465,6 +465,7 @@ int bus_add_device(struct device * dev)
 		up_write(&dev->bus->subsys.rwsem);
 		device_add_attrs(bus, dev);
 		sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
+		sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
 	}
 	return error;
 }
@@ -481,6 +482,7 @@ int bus_add_device(struct device * dev)
 void bus_remove_device(struct device * dev)
 {
 	if (dev->bus) {
+		sysfs_remove_link(&dev->kobj, "bus");
 		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
 		device_remove_attrs(dev->bus, dev);
 		down_write(&dev->bus->subsys.rwsem);
===== drivers/base/class.c 1.58 vs edited =====
--- 1.58/drivers/base/class.c	2005-02-05 19:35:12 +01:00
+++ edited/drivers/base/class.c	2005-02-15 22:32:08 +01:00
@@ -196,33 +196,6 @@ void class_device_remove_bin_file(struct
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
@@ -452,8 +425,9 @@ int class_device_add(struct class_device
 		class_device_create_file(class_dev, &class_device_attr_dev);
 
 	class_device_add_attrs(class_dev);
-	class_device_dev_link(class_dev);
-	class_device_driver_link(class_dev);
+	if (class_dev->dev)
+		sysfs_create_link(&class_dev->kobj,
+				  &class_dev->dev->kobj, "device");
 
  register_done:
 	if (error && parent)
@@ -482,8 +456,8 @@ void class_device_del(struct class_devic
 		up_write(&parent->subsys.rwsem);
 	}
 
-	class_device_dev_unlink(class_dev);
-	class_device_driver_unlink(class_dev);
+	if (class_dev->dev)
+		sysfs_remove_link(&class_dev->kobj, "device");
 	class_device_remove_attrs(class_dev);
 
 	kobject_del(&class_dev->kobj);

