Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbUKEA7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbUKEA7z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbUKEA4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:56:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:8159 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262533AbUKEAta convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:49:30 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] More Driver Core patches for 2.6.10-rc1
In-Reply-To: <1099615705170@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 4 Nov 2004 16:48:25 -0800
Message-Id: <1099615705183@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2449.2.5, 2004/11/04 10:48:20-08:00, tj@home-tj.org

[PATCH] driver-model: bus_recan_devices() locking fix

 df_02_bus_rescan_devcies_fix.patch

 bus_rescan_devices() eventually calls device_attach() and thus
requires write locking the corresponding bus.  The original code just
called bus_for_each_dev() which only read locks the bus.  This patch
separates __bus_for_each_dev() and __bus_for_each_drv(), which don't
do locking themselves, out from the original functions and call them
with read lock in the original functions and with write lock in
bus_rescan_devices().


Signed-off-by: Tejun Heo <tj@home-tj.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/bus.c |   93 +++++++++++++++++++++++++++++++----------------------
 1 files changed, 56 insertions(+), 37 deletions(-)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2004-11-04 16:30:46 -08:00
+++ b/drivers/base/bus.c	2004-11-04 16:30:46 -08:00
@@ -135,6 +135,52 @@
 
 decl_subsys(bus, &ktype_bus, NULL);
 
+static int __bus_for_each_dev(struct bus_type *bus, struct device *start,
+			      void *data, int (*fn)(struct device *, void *))
+{
+	struct list_head *head;
+	struct device *dev;
+	int error = 0;
+
+	if (!(bus = get_bus(bus)))
+		return -EINVAL;
+
+	head = &bus->devices.list;
+	dev = list_prepare_entry(start, head, bus_list);
+	list_for_each_entry_continue(dev, head, bus_list) {
+		get_device(dev);
+		error = fn(dev, data);
+		put_device(dev);
+		if (error)
+			break;
+	}
+	put_bus(bus);
+	return error;
+}
+
+static int __bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
+			      void * data, int (*fn)(struct device_driver *, void *))
+{
+	struct list_head *head;
+	struct device_driver *drv;
+	int error = 0;
+
+	if (!(bus = get_bus(bus)))
+		return -EINVAL;
+
+	head = &bus->drivers.list;
+	drv = list_prepare_entry(start, head, kobj.entry);
+	list_for_each_entry_continue(drv, head, kobj.entry) {
+		get_driver(drv);
+		error = fn(drv, data);
+		put_driver(drv);
+		if (error)
+			break;
+	}
+	put_bus(bus);
+	return error;
+}
+
 /**
  *	bus_for_each_dev - device iterator.
  *	@bus:	bus type.
@@ -154,30 +200,16 @@
  *	to retain this data, it should do, and increment the reference
  *	count in the supplied callback.
  */
+
 int bus_for_each_dev(struct bus_type * bus, struct device * start,
 		     void * data, int (*fn)(struct device *, void *))
 {
-	struct device *dev;
-	struct list_head * head;
-	int error = 0;
-
-	if (!(bus = get_bus(bus)))
-		return -EINVAL;
-
-	head = &bus->devices.list;
-	dev = list_prepare_entry(start, head, bus_list);
+	int ret;
 
 	down_read(&bus->subsys.rwsem);
-	list_for_each_entry_continue(dev, head, bus_list) {
-		get_device(dev);
-		error = fn(dev, data);
-		put_device(dev);
-		if (error)
-			break;
-	}
+	ret = __bus_for_each_dev(bus, start, data, fn);
 	up_read(&bus->subsys.rwsem);
-	put_bus(bus);
-	return error;
+	return ret;
 }
 
 /**
@@ -203,27 +235,12 @@
 int bus_for_each_drv(struct bus_type * bus, struct device_driver * start,
 		     void * data, int (*fn)(struct device_driver *, void *))
 {
-	struct list_head * head;
-	struct device_driver *drv;
-	int error = 0;
-
-	if(!(bus = get_bus(bus)))
-		return -EINVAL;
-
-	head = &bus->drivers.list;
-	drv = list_prepare_entry(start, head, kobj.entry);
+	int ret;
 
 	down_read(&bus->subsys.rwsem);
-	list_for_each_entry_continue(drv, head, kobj.entry) {
-		get_driver(drv);
-		error = fn(drv, data);
-		put_driver(drv);
-		if(error)
-			break;
-	}
+	ret = __bus_for_each_drv(bus, start, data, fn);
 	up_read(&bus->subsys.rwsem);
-	put_bus(bus);
-	return error;
+	return ret;
 }
 
 /**
@@ -590,7 +607,9 @@
 {
 	int count = 0;
 
-	bus_for_each_dev(bus, NULL, &count, bus_rescan_devices_helper);
+	down_write(&bus->subsys.rwsem);
+	__bus_for_each_dev(bus, NULL, &count, bus_rescan_devices_helper);
+	up_write(&bus->subsys.rwsem);
 
 	return count;
 }

