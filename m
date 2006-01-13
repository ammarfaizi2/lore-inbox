Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422906AbWAMTvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422906AbWAMTvq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422894AbWAMTvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:51:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:1429 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422896AbWAMTuh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:37 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add bus_type probe, remove, shutdown methods.
In-Reply-To: <20060113194602.GB18262@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:08 -0800
Message-Id: <11371818083867@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add bus_type probe, remove, shutdown methods.

Add bus_type probe, remove and shutdown methods to replace the
corresponding methods in struct device_driver.  This matches
the way we handle the suspend/resume methods.

Since the bus methods override the device_driver methods, warn
if a device driver is registered whose methods will not be
called.

The long-term idea is to remove the device_driver methods entirely.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 594c8281f90560faf9632d91bb9d402cbe560e63
tree abeb32df086cfd204accad33b11040381c31689d
parent bd37e5a951ad2123d3f51f59c407b5242946b6ba
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:29:51 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:04 -0800

 drivers/base/dd.c             |   12 ++++++++++--
 drivers/base/driver.c         |    5 +++++
 drivers/base/power/shutdown.c |    5 ++++-
 include/linux/device.h        |    3 +++
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 2b90501..730a9ce 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -78,7 +78,13 @@ int driver_probe_device(struct device_dr
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
@@ -203,7 +209,9 @@ static void __device_release_driver(stru
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
index 161f3a3..b400314 100644
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
diff --git a/drivers/base/power/shutdown.c b/drivers/base/power/shutdown.c
index f50a08b..a47bb74 100644
--- a/drivers/base/power/shutdown.c
+++ b/drivers/base/power/shutdown.c
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
diff --git a/include/linux/device.h b/include/linux/device.h
index 0cdee78..58df18d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -49,6 +49,9 @@ struct bus_type {
 	int		(*match)(struct device * dev, struct device_driver * drv);
 	int		(*uevent)(struct device *dev, char **envp,
 				  int num_envp, char *buffer, int buffer_size);
+	int		(*probe)(struct device * dev);
+	int		(*remove)(struct device * dev);
+	void		(*shutdown)(struct device * dev);
 	int		(*suspend)(struct device * dev, pm_message_t state);
 	int		(*resume)(struct device * dev);
 };

