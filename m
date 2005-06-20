Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVFUC4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVFUC4V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVFUCz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:55:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:12260 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261667AbVFTW7i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:38 -0400
Cc: hare@suse.de
Subject: [PATCH] driver core: fix error handling in bus_add_device
In-Reply-To: <11193083681028@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:28 -0700
Message-Id: <11193083682616@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] driver core: fix error handling in bus_add_device

The error handling in bus_add_device() and device_attach() is simply
non-existing. This patch propagates any error from device_attach to
the upper layers to allow for a proper recovery.

From: Hannes Reinecke <hare@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ca2b94ba12f3c36fd3d6ed9d38b3798d4dad0d8b
tree d9b85e0f423d1cd0a9ad1c72cec7464bcf50c126
parent acaefc25d21f850e47ecc5098d1e0bc442c526be
author Hannes Reinecke <hare@suse.de> Wed, 18 May 2005 10:42:23 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:31 -0700

 drivers/base/bus.c |   13 ++++++++-----
 drivers/base/dd.c  |    3 ++-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -270,11 +270,14 @@ int bus_add_device(struct device * dev)
 
 	if (bus) {
 		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
-		device_attach(dev);
+		error = device_attach(dev);
 		klist_add_tail(&bus->klist_devices, &dev->knode_bus);
-		device_add_attrs(bus, dev);
-		sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
-		sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
+		if (error >= 0)
+			error = device_add_attrs(bus, dev);
+		if (!error) {
+			sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
+			sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
+		}
 	}
 	return error;
 }
@@ -394,7 +397,7 @@ static int bus_rescan_devices_helper(str
 {
 	int *count = data;
 
-	if (!dev->driver && device_attach(dev))
+	if (!dev->driver && (device_attach(dev) > 0))
 		(*count)++;
 
 	return 0;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -119,7 +119,8 @@ static int __device_attach(struct device
  *	driver_probe_device() for each pair. If a compatible
  *	pair is found, break out and return.
  *
- *	Returns 1 if the device was bound to a driver; 0 otherwise.
+ *	Returns 1 if the device was bound to a driver;
+ *	0 if no matching device was found; error code otherwise.
  */
 int device_attach(struct device * dev)
 {

