Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVFUAtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVFUAtx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVFUAry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:47:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:41956 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261759AbVFTW7w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:52 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Use bus_for_each_{dev,drv} for driver binding.
In-Reply-To: <11193083653286@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:25 -0700
Message-Id: <11193083653850@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Use bus_for_each_{dev,drv} for driver binding.

- Now possible, since the lists are locked using the klist lock and not the
  global rwsem.

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2287c322b61fced7e0c326a1a9606aa73147e3df
tree 8241c7cab4172969f38d8b55852aca2e071a494f
parent cb85b6f1cc811ecb9ed4b950206d8941ba710e68
author mochel@digitalimplant.org <mochel@digitalimplant.org> Thu, 24 Mar 2005 10:50:24 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:17 -0700

 drivers/base/dd.c |   72 +++++++++++++++++++++++++++++------------------------
 1 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -82,6 +82,28 @@ int driver_probe_device(struct device_dr
 	return 0;
 }
 
+static int __device_attach(struct device_driver * drv, void * data)
+{
+	struct device * dev = data;
+	int error;
+
+	error = driver_probe_device(drv, dev);
+
+	if (error == -ENODEV && error == -ENXIO) {
+		/* Driver matched, but didn't support device
+		 * or device not found.
+		 * Not an error; keep going.
+		 */
+		error = 0;
+	} else {
+		/* driver matched but the probe failed */
+		printk(KERN_WARNING
+		       "%s: probe of %s failed with error %d\n",
+		       drv->name, dev->bus_id, error);
+	}
+	return 0;
+}
+
 /**
  *	device_attach - try to attach device to a driver.
  *	@dev:	device.
@@ -92,30 +114,31 @@ int driver_probe_device(struct device_dr
  */
 int device_attach(struct device * dev)
 {
- 	struct bus_type * bus = dev->bus;
-	struct list_head * entry;
-	int error;
-
 	if (dev->driver) {
 		device_bind_driver(dev);
 		return 1;
 	}
 
-	if (bus->match) {
-		list_for_each(entry, &bus->drivers.list) {
-			struct device_driver * drv = to_drv(entry);
-			error = driver_probe_device(drv, dev);
-			if (!error)
-				/* success, driver matched */
-				return 1;
-			if (error != -ENODEV && error != -ENXIO)
+	return bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
+}
+
+static int __driver_attach(struct device * dev, void * data)
+{
+	struct device_driver * drv = data;
+	int error = 0;
+
+	if (!dev->driver) {
+		error = driver_probe_device(drv, dev);
+		if (error) {
+			if (error != -ENODEV) {
 				/* driver matched but the probe failed */
 				printk(KERN_WARNING
-				    "%s: probe of %s failed with error %d\n",
-				    drv->name, dev->bus_id, error);
+				       "%s: probe of %s failed with error %d\n",
+				       drv->name, dev->bus_id, error);
+			} else
+				error = 0;
 		}
 	}
-
 	return 0;
 }
 
@@ -133,24 +156,7 @@ int device_attach(struct device * dev)
  */
 void driver_attach(struct device_driver * drv)
 {
-	struct bus_type * bus = drv->bus;
-	struct list_head * entry;
-	int error;
-
-	if (!bus->match)
-		return;
-
-	list_for_each(entry, &bus->devices.list) {
-		struct device * dev = container_of(entry, struct device, bus_list);
-		if (!dev->driver) {
-			error = driver_probe_device(drv, dev);
-			if (error && (error != -ENODEV))
-				/* driver matched but the probe failed */
-				printk(KERN_WARNING
-				    "%s: probe of %s failed with error %d\n",
-				    drv->name, dev->bus_id, error);
-		}
-	}
+	bus_for_each_dev(drv->bus, NULL, drv, __driver_attach);
 }
 
 /**

