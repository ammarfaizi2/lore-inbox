Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbUKDHVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbUKDHVU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 02:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbUKDHPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 02:15:05 -0500
Received: from [211.58.254.17] ([211.58.254.17]:57506 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262119AbUKDHDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 02:03:00 -0500
Date: Thu, 4 Nov 2004 16:02:58 +0900
From: Tejun Heo <tj@home-tj.org>
To: mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 2/5] driver-model: bus_recan_devices() locking fix
Message-ID: <20041104070258.GC25567@home-tj.org>
References: <20041104070134.GA25567@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104070134.GA25567@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 df_02_bus_rescan_devcies_fix.patch

 bus_rescan_devices() eventually calls device_attach() and thus
requires write locking the corresponding bus.  The original code just
called bus_for_each_dev() which only read locks the bus.  This patch
separates __bus_for_each_dev() and __bus_for_each_drv(), which don't
do locking themselves, out from the original functions and call them
with read lock in the original functions and with write lock in
bus_rescan_devices().


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/drivers/base/bus.c
===================================================================
--- linux-export.orig/drivers/base/bus.c	2004-11-04 11:04:13.000000000 +0900
+++ linux-export/drivers/base/bus.c	2004-11-04 11:04:13.000000000 +0900
@@ -135,6 +135,54 @@ static struct kobj_type ktype_bus = {
 
 decl_subsys(bus, &ktype_bus, NULL);
 
+static int
+__bus_for_each_dev(struct bus_type * bus, struct device * start,
+		   void * data, int (*fn)(struct device *, void *))
+{
+	struct device *dev;
+	struct list_head * head;
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
+static int
+__bus_for_each_drv(struct bus_type * bus, struct device_driver * start,
+		   void * data, int (*fn)(struct device_driver *, void *))
+{
+	struct list_head * head;
+	struct device_driver *drv;
+	int error = 0;
+
+	if(!(bus = get_bus(bus)))
+		return -EINVAL;
+
+	head = &bus->drivers.list;
+	drv = list_prepare_entry(start, head, kobj.entry);
+	list_for_each_entry_continue(drv, head, kobj.entry) {
+		get_driver(drv);
+		error = fn(drv, data);
+		put_driver(drv);
+		if(error)
+			break;
+	}
+	put_bus(bus);
+	return error;
+}
+
 /**
  *	bus_for_each_dev - device iterator.
  *	@bus:	bus type.
@@ -154,30 +202,15 @@ decl_subsys(bus, &ktype_bus, NULL);
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
-
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
@@ -203,27 +236,11 @@ int bus_for_each_dev(struct bus_type * b
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
-
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
@@ -601,7 +618,9 @@ int bus_rescan_devices(struct bus_type *
 {
 	int count = 0;
 
-	bus_for_each_dev(bus, NULL, &count, bus_rescan_devices_helper);
+	down_write(&bus->subsys.rwsem);
+	__bus_for_each_dev(bus, NULL, &count, bus_rescan_devices_helper);
+	up_write(&bus->subsys.rwsem);
 
 	return count;
 }
