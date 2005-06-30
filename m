Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262877AbVF3GK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbVF3GK3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 02:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbVF3GI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 02:08:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:30092 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262866AbVF3GE1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 02:04:27 -0400
Cc: gregkh@suse.de
Subject: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
In-Reply-To: <11201114612875@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 29 Jun 2005 23:04:21 -0700
Message-Id: <11201114613610@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] driver core: Add the ability to unbind drivers to devices from userspace

This adds a single file, "unbind", to the sysfs directory of every
device that is currently bound to a driver.  To unbind the driver from
the device, write anything to this file and they will be disconnected
from each other.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 151ef38f7c0ec1b0420f04438b0316e3a30bf2e4
tree 3aa6504e12c08f70cacb7f9de6ef5858b45ee86d
parent 0edb586049e57c56e625536476931117a57671e9
author Greg Kroah-Hartman <gregkh@suse.de> Wed, 22 Jun 2005 16:09:05 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 29 Jun 2005 22:48:04 -0700

 drivers/base/bus.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -133,6 +133,34 @@ static struct kobj_type ktype_bus = {
 decl_subsys(bus, &ktype_bus, NULL);
 
 
+/* Manually detach a device from it's associated driver. */
+static int driver_helper(struct device *dev, void *data)
+{
+	const char *name = data;
+
+	if (strcmp(name, dev->bus_id) == 0)
+		return 1;
+	return 0;
+}
+
+static ssize_t driver_unbind(struct device_driver *drv,
+			     const char *buf, size_t count)
+{
+	struct bus_type *bus = get_bus(drv->bus);
+	struct device *dev;
+	int err = -ENODEV;
+
+	dev = bus_find_device(bus, NULL, (void *)buf, driver_helper);
+	if ((dev) &&
+	    (dev->driver == drv)) {
+		device_release_driver(dev);
+		err = count;
+	}
+	return err;
+}
+static DRIVER_ATTR(unbind, S_IWUSR, NULL, driver_unbind);
+
+
 static struct device * next_device(struct klist_iter * i)
 {
 	struct klist_node * n = klist_next(i);
@@ -396,6 +424,7 @@ int bus_add_driver(struct device_driver 
 		module_add_driver(drv->owner, drv);
 
 		driver_add_attrs(bus, drv);
+		driver_create_file(drv, &driver_attr_unbind);
 	}
 	return error;
 }
@@ -413,6 +442,7 @@ int bus_add_driver(struct device_driver 
 void bus_remove_driver(struct device_driver * drv)
 {
 	if (drv->bus) {
+		driver_remove_file(drv, &driver_attr_unbind);
 		driver_remove_attrs(drv->bus, drv);
 		klist_remove(&drv->knode_bus);
 		pr_debug("bus %s: remove driver %s\n", drv->bus->name, drv->name);

