Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVFUC1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVFUC1W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVFUC0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:26:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:28900 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261714AbVFTW7q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:46 -0400
Cc: stern@rowland.harvard.edu
Subject: [PATCH] driver core: Fix races in driver_detach()
In-Reply-To: <11193083672422@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:27 -0700
Message-Id: <11193083672789@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] driver core: Fix races in driver_detach()

This patch is intended for your "driver" tree.  It fixes several subtle
races in driver_detach() and device_release_driver() in the driver-model
core.

The major change is to use klist_remove() rather than klist_del() when
taking a device off its driver's list.  There's no other way to guarantee
that the list pointers will be updated before some other driver binds to
the device.  For this to work driver_detach() can't use a klist iterator,
so the loop over the devices must be written out in full.  In addition the
patch protects against the possibility that, when a driver and a device
are unregistered at the same time, one may be unloaded from memory before
the other is finished using it.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit c95a6b057b108c2b7add35cba1354f9af921349e
tree 5a312f634b0aec295201a93020ba025d840e5f21
parent 6623415687eaffef49429292ab062bb046ee3311
author Alan Stern <stern@rowland.harvard.edu> Fri, 06 May 2005 15:38:33 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:28 -0700

 drivers/base/dd.c |   51 ++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -177,41 +177,66 @@ void driver_attach(struct device_driver 
  *	@dev:	device.
  *
  *	Manually detach device from driver.
- *	Note that this is called without incrementing the bus
- *	reference count nor taking the bus's rwsem. Be sure that
- *	those are accounted for before calling this function.
+ *
+ *	__device_release_driver() must be called with @dev->sem held.
  */
-void device_release_driver(struct device * dev)
+
+static void __device_release_driver(struct device * dev)
 {
 	struct device_driver * drv;
 
-	down(&dev->sem);
-	if (dev->driver) {
-		drv = dev->driver;
+	drv = dev->driver;
+	if (drv) {
+		get_driver(drv);
 		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
 		sysfs_remove_link(&dev->kobj, "driver");
-		klist_del(&dev->knode_driver);
+		klist_remove(&dev->knode_driver);
 
 		if (drv->remove)
 			drv->remove(dev);
 		dev->driver = NULL;
+		put_driver(drv);
 	}
-	up(&dev->sem);
 }
 
-static int __remove_driver(struct device * dev, void * unused)
+void device_release_driver(struct device * dev)
 {
-	device_release_driver(dev);
-	return 0;
+	/*
+	 * If anyone calls device_release_driver() recursively from
+	 * within their ->remove callback for the same device, they
+	 * will deadlock right here.
+	 */
+	down(&dev->sem);
+	__device_release_driver(dev);
+	up(&dev->sem);
 }
 
+
 /**
  * driver_detach - detach driver from all devices it controls.
  * @drv: driver.
  */
 void driver_detach(struct device_driver * drv)
 {
-	driver_for_each_device(drv, NULL, NULL, __remove_driver);
+	struct device * dev;
+
+	for (;;) {
+		spin_lock_irq(&drv->klist_devices.k_lock);
+		if (list_empty(&drv->klist_devices.k_list)) {
+			spin_unlock_irq(&drv->klist_devices.k_lock);
+			break;
+		}
+		dev = list_entry(drv->klist_devices.k_list.prev,
+				struct device, knode_driver.n_node);
+		get_device(dev);
+		spin_unlock_irq(&drv->klist_devices.k_lock);
+
+		down(&dev->sem);
+		if (dev->driver == drv)
+			__device_release_driver(dev);
+		up(&dev->sem);
+		put_device(dev);
+	}
 }
 
 

