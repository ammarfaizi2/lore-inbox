Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVFUCvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVFUCvt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVFUCs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:48:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:18404 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261677AbVFTW7l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:41 -0400
Cc: mochel@digitalimplant.org
Subject: [PATCH] Add a semaphore to struct device to synchronize calls to its driver.
In-Reply-To: <11193083641656@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:24 -0700
Message-Id: <1119308364310@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add a semaphore to struct device to synchronize calls to its driver.

This adds a per-device semaphore that is taken before every call from the core to a
driver method. This prevents e.g. simultaneous calls to the ->suspend() or ->resume()
and ->probe() or ->release(), potentially saving a whole lot of headaches.

It also moves us a step closer to removing the bus rwsem, since it protects the fields
in struct device that are modified by the core.

Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit af70316af182f4716cc5eec7e0d27fc731d164bd
tree 22fa4732c8270db8fd3f681355cd83e4b8088847
parent eb51b65005737b777e0709683b061d5f82aefd97
author mochel@digitalimplant.org <mochel@digitalimplant.org> Mon, 21 Mar 2005 10:41:04 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:12 -0700

 drivers/base/bus.c           |   14 +++++++++++---
 drivers/base/core.c          |    1 +
 drivers/base/power/resume.c  |    8 ++++++--
 drivers/base/power/suspend.c |    3 ++-
 include/linux/device.h       |    4 ++++
 5 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -283,18 +283,22 @@ void device_bind_driver(struct device * 
  */
 int driver_probe_device(struct device_driver * drv, struct device * dev)
 {
+	int error = 0;
+
 	if (drv->bus->match && !drv->bus->match(dev, drv))
 		return -ENODEV;
 
+	down(&dev->sem);
 	dev->driver = drv;
 	if (drv->probe) {
-		int error = drv->probe(dev);
+		error = drv->probe(dev);
 		if (error) {
 			dev->driver = NULL;
+			up(&dev->sem);
 			return error;
 		}
 	}
-
+	up(&dev->sem);
 	device_bind_driver(dev);
 	return 0;
 }
@@ -385,7 +389,10 @@ void driver_attach(struct device_driver 
 
 void device_release_driver(struct device * dev)
 {
-	struct device_driver * drv = dev->driver;
+	struct device_driver * drv;
+
+	down(&dev->sem);
+	drv = dev->driver;
 	if (drv) {
 		sysfs_remove_link(&drv->kobj, kobject_name(&dev->kobj));
 		sysfs_remove_link(&dev->kobj, "driver");
@@ -394,6 +401,7 @@ void device_release_driver(struct device
 			drv->remove(dev);
 		dev->driver = NULL;
 	}
+	up(&dev->sem);
 }
 
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -212,6 +212,7 @@ void device_initialize(struct device *de
 	INIT_LIST_HEAD(&dev->driver_list);
 	INIT_LIST_HEAD(&dev->bus_list);
 	INIT_LIST_HEAD(&dev->dma_pools);
+	init_MUTEX(&dev->sem);
 }
 
 /**
diff --git a/drivers/base/power/resume.c b/drivers/base/power/resume.c
--- a/drivers/base/power/resume.c
+++ b/drivers/base/power/resume.c
@@ -22,6 +22,9 @@ extern int sysdev_resume(void);
 
 int resume_device(struct device * dev)
 {
+	int error = 0;
+
+	down(&dev->sem);
 	if (dev->power.pm_parent
 			&& dev->power.pm_parent->power.power_state) {
 		dev_err(dev, "PM: resume from %d, parent %s still %d\n",
@@ -31,9 +34,10 @@ int resume_device(struct device * dev)
 	}
 	if (dev->bus && dev->bus->resume) {
 		dev_dbg(dev,"resuming\n");
-		return dev->bus->resume(dev);
+		error = dev->bus->resume(dev);
 	}
-	return 0;
+	up(&dev->sem);
+	return error;
 }
 
 
diff --git a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -39,6 +39,7 @@ int suspend_device(struct device * dev, 
 {
 	int error = 0;
 
+	down(&dev->sem);
 	if (dev->power.power_state) {
 		dev_dbg(dev, "PM: suspend %d-->%d\n",
 			dev->power.power_state, state);
@@ -58,7 +59,7 @@ int suspend_device(struct device * dev, 
 		dev_dbg(dev, "suspending\n");
 		error = dev->bus->suspend(dev, state);
 	}
-
+	up(&dev->sem);
 	return error;
 }
 
diff --git a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -264,6 +264,10 @@ struct device {
 	struct kobject kobj;
 	char	bus_id[BUS_ID_SIZE];	/* position on parent bus */
 
+	struct semaphore	sem;	/* semaphore to synchronize calls to
+					 * its driver.
+					 */
+
 	struct bus_type	* bus;		/* type of bus device is on */
 	struct device_driver *driver;	/* which driver has allocated this
 					   device */

