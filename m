Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263102AbVFXFQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbVFXFQn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 01:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbVFXFQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 01:16:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:1721 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263102AbVFXFP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 01:15:58 -0400
Date: Thu, 23 Jun 2005 22:14:43 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Patrick Mochel <mochel@digitalimplant.org>
Subject: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Message-ID: <20050624051442.GB24621@kroah.com>
References: <20050624051229.GA24621@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624051229.GA24621@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a single file, "unbind", to the sysfs directory of every
device that is currently bound to a driver.  To unbind the driver from
the device, write anything to this file and they will be disconnected
from each other.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/dd.c |   11 +++++++++++
 1 files changed, 11 insertions(+)

--- gregkh-2.6.orig/drivers/base/dd.c	2005-06-22 17:56:48.000000000 -0700
+++ gregkh-2.6/drivers/base/dd.c	2005-06-22 17:56:59.000000000 -0700
@@ -23,6 +23,15 @@
 
 #define to_drv(node) container_of(node, struct device_driver, kobj.entry)
 
+/* manually detach a device from it's associated driver. */
+/* Any write will cause it to happen. */
+static ssize_t device_unbind(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	device_release_driver(dev);
+	return count;
+}
+static DEVICE_ATTR(unbind, S_IWUSR, NULL, device_unbind);
 
 /**
  *	device_bind_driver - bind a driver to one device.
@@ -46,6 +55,7 @@
 	sysfs_create_link(&dev->driver->kobj, &dev->kobj,
 			  kobject_name(&dev->kobj));
 	sysfs_create_link(&dev->kobj, &dev->driver->kobj, "driver");
+	device_create_file(dev, &dev_attr_unbind);
 }
 
 /**
@@ -191,6 +201,7 @@
 		get_driver(drv);
 		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
 		sysfs_remove_link(&dev->kobj, "driver");
+		device_remove_file(dev, &dev_attr_unbind);
 		klist_remove(&dev->knode_driver);
 
 		if (drv->remove)
