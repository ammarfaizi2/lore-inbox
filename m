Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbUKIWiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUKIWiw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 17:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUKIWiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 17:38:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:44431 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261742AbUKIWiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 17:38:12 -0500
Date: Tue, 9 Nov 2004 14:37:29 -0800
From: Greg KH <greg@kroah.com>
To: Tejun Heo <tj@home-tj.org>, Dmitry Torokhov <dtor_core@ameritech.net>,
       dtor@mail.ru
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
Subject: [RFC] [PATCH] driver core: allow userspace to unbind drivers from devices.
Message-ID: <20041109223729.GB7416@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, everone's been back and forth about the whole bind/unbind stuff
lately, so let's just do this a step at a time.

How about the following patch.  It adds a "unbind" file to any device
that is bound to a driver.  Writing any value to that file disconnects
the device from the driver associated with it.

It's small, simple, and it works.

It also can cause bad things to happen if you aren't careful about what
type of device you are unbinding (some i2c chip devices don't really
unbind from the driver fully, but that's an i2c issue, and I'm working
on it.)

Also, unbinding a device from a driver can cause the children devices to
disappear, depending on the type of driver that is bound to the device.

As an example, a usb-storage device, that has a scsi-host, and scsi
devices as children.  If you unbind the usb-storage device, the
scsi-host and devices are all removed from the system (as they should
be.)

I put "Signed-off-by:" for both Tejun and Dmitry, as this patch is taken
from both of their implementations that they have been posting to lkml
recently.  It's just that this one is smaller, and hence, more correct :)

Comments?

If we can agree on this, we can move on to the "bind from userspace"
stuff next.

thanks,

greg k-h

------

 From: greg@kroah.com
 Subject: driver core: allow userspace to unbind drivers from devices.

 Signed-off-by: Tejun Heo <tj@home-tj.org>
 Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
 Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-11-09 14:26:35 -08:00
+++ b/drivers/base/bus.c	2004-11-09 14:26:35 -08:00
@@ -243,6 +243,17 @@
 	return ret;
 }
 
+/* manually detach a device from it's associated driver. */
+/* Any write will cause it to happen. */
+static ssize_t device_unbind(struct device *dev, const char *buf, size_t count)
+{
+	down_write(&dev->bus->subsys.rwsem);
+	device_release_driver(dev);
+	up_write(&dev->bus->subsys.rwsem);
+	return count;
+}
+static DEVICE_ATTR(unbind, S_IWUSR, NULL, device_unbind);
+
 /**
  *	device_bind_driver - bind a driver to one device.
  *	@dev:	device.
@@ -264,6 +275,7 @@
 	sysfs_create_link(&dev->driver->kobj, &dev->kobj,
 			  kobject_name(&dev->kobj));
 	sysfs_create_link(&dev->kobj, &dev->driver->kobj, "driver");
+	device_create_file(dev, &dev_attr_unbind);
 }
 
 
@@ -389,6 +401,7 @@
 	if (drv) {
 		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
 		sysfs_remove_link(&dev->kobj, "driver");
+		device_remove_file(dev, &dev_attr_unbind);
 		list_del_init(&dev->driver_list);
 		device_detach_shutdown(dev);
 		if (drv->remove)
