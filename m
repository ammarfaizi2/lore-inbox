Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWAEO37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWAEO37 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWAEO37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:29:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7434 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750719AbWAEO36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:29:58 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>
Subject: [CFT 1/29] Add bus_type probe, remove, shutdown methods.
Date: Thu, 05 Jan 2006 14:29:51 +0000
Message-ID: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add bus_type probe, remove and shutdown methods to replace the
corresponding methods in struct device_driver.  This matches
the way we handle the suspend/resume methods.

Since the bus methods override the device_driver methods, warn
if a device driver is registered whose methods will not be
called.

The long-term idea is to remove the device_driver methods entirely.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 drivers/base/driver.c         |    5 +++++
 drivers/base/dd.c             |   12 ++++++++++--
 drivers/base/power/shutdown.c |    5 ++++-
 include/linux/device.h        |    3 +++
 4 files changed, 22 insertions(+), 3 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git -r linus/drivers/base/dd.c linux/drivers/base/dd.c
--- linus/drivers/base/dd.c	Fri Sep 23 07:03:13 2005
+++ linux/drivers/base/dd.c	Sun Nov 13 14:02:19 2005
@@ -77,7 +77,13 @@ int driver_probe_device(struct device_dr
 	pr_debug("%s: Matched Device %s with Driver %s\n",
 		 drv->bus->name, dev->bus_id, drv->name);
 	dev->driver = drv;
-	if (drv->probe) {
+	if (dev->bus->probe) {
+		ret = dev->bus->probe(dev);
+		if (ret) {
+			dev->driver = NULL;
+			goto ProbeFailed;
+		}
+	} else if (drv->probe) {
 		ret = drv->probe(dev);
 		if (ret) {
 			dev->driver = NULL;
@@ -194,7 +200,9 @@ static void __device_release_driver(stru
 		sysfs_remove_link(&dev->kobj, "driver");
 		klist_remove(&dev->knode_driver);
 
-		if (drv->remove)
+		if (dev->bus->remove)
+			dev->bus->remove(dev);
+		else if (drv->remove)
 			drv->remove(dev);
 		dev->driver = NULL;
 		put_driver(drv);
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -171,6 +171,11 @@ static void klist_devices_put(struct kli
  */
 int driver_register(struct device_driver * drv)
 {
+	if ((drv->bus->probe && drv->probe) ||
+	    (drv->bus->remove && drv->remove) ||
+	    (drv->bus->shutdown && drv->shutdown)) {
+		printk(KERN_WARNING "Driver '%s' needs updating - please use bus_type methods\n", drv->name);
+	}
 	klist_init(&drv->klist_devices, klist_devices_get, klist_devices_put);
 	init_completion(&drv->unloaded);
 	return bus_add_driver(drv);
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git -r linus/drivers/base/power/shutdown.c linux/drivers/base/power/shutdown.c
--- linus/drivers/base/power/shutdown.c	Sun Nov  6 22:15:23 2005
+++ linux/drivers/base/power/shutdown.c	Sun Nov 13 14:03:05 2005
@@ -40,7 +40,10 @@ void device_shutdown(void)
 	down_write(&devices_subsys.rwsem);
 	list_for_each_entry_reverse(dev, &devices_subsys.kset.list,
 				kobj.entry) {
-		if (dev->driver && dev->driver->shutdown) {
+		if (dev->bus && dev->bus->shutdown) {
+			dev_dbg(dev, "shutdown\n");
+			dev->bus->shutdown(dev);
+		} else if (dev->driver && dev->driver->shutdown) {
 			dev_dbg(dev, "shutdown\n");
 			dev->driver->shutdown(dev);
 		}
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git -r linus/include/linux/device.h linux/include/linux/device.h
--- linus/include/linux/device.h	Sun Nov  6 22:20:07 2005
+++ linux/include/linux/device.h	Sun Nov 13 13:58:17 2005
@@ -49,6 +49,9 @@ struct bus_type {
 	int		(*match)(struct device * dev, struct device_driver * drv);
 	int		(*hotplug) (struct device *dev, char **envp, 
 				    int num_envp, char *buffer, int buffer_size);
+	int		(*probe)(struct device * dev);
+	int		(*remove)(struct device * dev);
+	void		(*shutdown)(struct device * dev);
 	int		(*suspend)(struct device * dev, pm_message_t state);
 	int		(*resume)(struct device * dev);
 };
