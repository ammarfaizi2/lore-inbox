Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbVKWXue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbVKWXue (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVKWXrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:47:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:41666 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751341AbVKWXqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:40 -0500
Date: Wed, 23 Nov 2005 15:43:50 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       stern@rowland.harvard.edu
Subject: [patch 01/22] Small fixes to driver core
Message-ID: <20051123234350.GB527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="small-fixups-to-driver-core.patch"
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>


This patch (as603) makes a few small fixes to the driver core:

Change spin_lock_irq for a klist lock to spin_lock;

Fix reference count leaks;

Minor spelling and formatting changes.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/bus.c |   21 +++++++++------------
 drivers/base/dd.c  |    8 +++-----
 2 files changed, 12 insertions(+), 17 deletions(-)

--- usb-2.6.orig/drivers/base/bus.c
+++ usb-2.6/drivers/base/bus.c
@@ -133,7 +133,7 @@ static struct kobj_type ktype_bus = {
 decl_subsys(bus, &ktype_bus, NULL);
 
 
-/* Manually detach a device from it's associated driver. */
+/* Manually detach a device from its associated driver. */
 static int driver_helper(struct device *dev, void *data)
 {
 	const char *name = data;
@@ -151,14 +151,13 @@ static ssize_t driver_unbind(struct devi
 	int err = -ENODEV;
 
 	dev = bus_find_device(bus, NULL, (void *)buf, driver_helper);
-	if ((dev) &&
-	    (dev->driver == drv)) {
+	if (dev && dev->driver == drv) {
 		device_release_driver(dev);
 		err = count;
 	}
-	if (err)
-		return err;
-	return count;
+	put_device(dev);
+	put_bus(bus);
+	return err;
 }
 static DRIVER_ATTR(unbind, S_IWUSR, NULL, driver_unbind);
 
@@ -175,16 +174,14 @@ static ssize_t driver_bind(struct device
 	int err = -ENODEV;
 
 	dev = bus_find_device(bus, NULL, (void *)buf, driver_helper);
-	if ((dev) &&
-	    (dev->driver == NULL)) {
+	if (dev && dev->driver == NULL) {
 		down(&dev->sem);
 		err = driver_probe_device(drv, dev);
 		up(&dev->sem);
-		put_device(dev);
 	}
-	if (err)
-		return err;
-	return count;
+	put_device(dev);
+	put_bus(bus);
+	return err;
 }
 static DRIVER_ATTR(bind, S_IWUSR, NULL, driver_bind);
 
--- usb-2.6.orig/drivers/base/dd.c
+++ usb-2.6/drivers/base/dd.c
@@ -62,7 +62,6 @@ void device_bind_driver(struct device * 
  *	because we don't know the format of the ID structures, nor what
  *	is to be considered a match and what is not.
  *
- *
  *	This function returns 1 if a match is found, an error if one
  *	occurs (that is not -ENODEV or -ENXIO), and 0 otherwise.
  *
@@ -158,7 +157,6 @@ static int __driver_attach(struct device
 		driver_probe_device(drv, dev);
 	up(&dev->sem);
 
-
 	return 0;
 }
 
@@ -225,15 +223,15 @@ void driver_detach(struct device_driver 
 	struct device * dev;
 
 	for (;;) {
-		spin_lock_irq(&drv->klist_devices.k_lock);
+		spin_lock(&drv->klist_devices.k_lock);
 		if (list_empty(&drv->klist_devices.k_list)) {
-			spin_unlock_irq(&drv->klist_devices.k_lock);
+			spin_unlock(&drv->klist_devices.k_lock);
 			break;
 		}
 		dev = list_entry(drv->klist_devices.k_list.prev,
 				struct device, knode_driver.n_node);
 		get_device(dev);
-		spin_unlock_irq(&drv->klist_devices.k_lock);
+		spin_unlock(&drv->klist_devices.k_lock);
 
 		down(&dev->sem);
 		if (dev->driver == drv)

--
