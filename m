Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262868AbVF3GHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbVF3GHf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 02:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbVF3GHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 02:07:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:31116 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262868AbVF3GE2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 02:04:28 -0400
Cc: gregkh@suse.de
Subject: [PATCH] driver core: change bus_rescan_devices to return void
In-Reply-To: <11201114613610@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 29 Jun 2005 23:04:22 -0700
Message-Id: <1120111462947@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] driver core: change bus_rescan_devices to return void

No one was looking at the return value of bus_rescan_devices, and it
really wasn't anything that anyone in the kernel would ever care about.
So change it which enabled some counting code to be removed also.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 23d3d602cb96addd3c1158424fb01a49ea5e81b1
tree 2daa85579c964bfe3d1a91fe365d202b8f38422b
parent afdce75f1eaebcf358b7594ba7969aade105c3b0
author Greg Kroah-Hartman <gregkh@suse.de> Wed, 22 Jun 2005 16:09:05 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 29 Jun 2005 22:48:04 -0700

 drivers/base/bus.c     |   27 +++++++++------------------
 include/linux/device.h |    2 +-
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -483,31 +483,22 @@ void bus_remove_driver(struct device_dri
 /* Helper for bus_rescan_devices's iter */
 static int bus_rescan_devices_helper(struct device *dev, void *data)
 {
-	int *count = data;
-
-	if (!dev->driver && (device_attach(dev) > 0))
-		(*count)++;
-
+	if (!dev->driver)
+		device_attach(dev);
 	return 0;
 }
 
-
 /**
- *	bus_rescan_devices - rescan devices on the bus for possible drivers
- *	@bus:	the bus to scan.
+ * bus_rescan_devices - rescan devices on the bus for possible drivers
+ * @bus: the bus to scan.
  *
- *	This function will look for devices on the bus with no driver
- *	attached and rescan it against existing drivers to see if it
- *	matches any. Calls device_attach(). Returns the number of devices
- *	that were sucessfully bound to a driver.
+ * This function will look for devices on the bus with no driver
+ * attached and rescan it against existing drivers to see if it matches
+ * any by calling device_attach() for the unbound devices.
  */
-int bus_rescan_devices(struct bus_type * bus)
+void bus_rescan_devices(struct bus_type * bus)
 {
-	int count = 0;
-
-	bus_for_each_dev(bus, NULL, &count, bus_rescan_devices_helper);
-
-	return count;
+	bus_for_each_dev(bus, NULL, NULL, bus_rescan_devices_helper);
 }
 
 
diff --git a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -69,7 +69,7 @@ struct bus_type {
 extern int bus_register(struct bus_type * bus);
 extern void bus_unregister(struct bus_type * bus);
 
-extern int bus_rescan_devices(struct bus_type * bus);
+extern void bus_rescan_devices(struct bus_type * bus);
 
 extern struct bus_type * get_bus(struct bus_type * bus);
 extern void put_bus(struct bus_type * bus);

