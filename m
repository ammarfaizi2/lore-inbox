Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVELOTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVELOTf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 10:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVELOTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 10:19:34 -0400
Received: from ns2.suse.de ([195.135.220.15]:43966 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261951AbVELOTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 10:19:25 -0400
Message-ID: <428365EC.80906@suse.de>
Date: Thu, 12 May 2005 16:19:24 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Kay Sievers <Kay.Sievers@vrfy.org>
Subject: [PATCH] fix error handling in bus_add_device
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000907010401040002010909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000907010401040002010909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hi Greg,

this patch fixes the error handling in bus_add_device() and
device_attach(). Previously it was 'interesting'.
And totally confusing to boot.

Please apply.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------000907010401040002010909
Content-Type: text/x-patch;
 name="sysfs-core-bus-check-error.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysfs-core-bus-check-error.patch"

From: Hannes Reinecke <hare@suse.de>
Subject: Fix error handling in bus_add_device()

The error handling in bus_add_device() and device_attach() is simply
non-existing. This patch updates both function to align with the default
driver core convention to return '0' on success and an error code otherwise.
Note that '-ENODEV' is not an error for device_attach and driver_probe_device
as it is quite possible that no matching device was found.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

diff -pur linux-2.6.12-rc4.orig/drivers/base/bus.c linux-2.6.12-rc4/drivers/base/bus.c
--- linux-2.6.12-rc4.orig/drivers/base/bus.c	2005-05-06 23:20:31.000000000 -0600
+++ linux-2.6.12-rc4/drivers/base/bus.c	2005-05-12 08:05:02.000000000 -0600
@@ -312,11 +312,11 @@ int device_attach(struct device * dev)
 {
  	struct bus_type * bus = dev->bus;
 	struct list_head * entry;
-	int error;
+	int error = -ENODEV;
 
 	if (dev->driver) {
 		device_bind_driver(dev);
-		return 1;
+		return 0;
 	}
 
 	if (bus->match) {
@@ -325,7 +325,7 @@ int device_attach(struct device * dev)
 			error = driver_probe_device(drv, dev);
 			if (!error)
 				/* success, driver matched */
-				return 1;
+				return 0;
 			if (error != -ENODEV && error != -ENXIO)
 				/* driver matched but the probe failed */
 				printk(KERN_WARNING
@@ -334,7 +334,7 @@ int device_attach(struct device * dev)
 		}
 	}
 
-	return 0;
+	return error;
 }
 
 
@@ -460,11 +460,17 @@ int bus_add_device(struct device * dev)
 		down_write(&dev->bus->subsys.rwsem);
 		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
 		list_add_tail(&dev->bus_list, &dev->bus->devices.list);
-		device_attach(dev);
+		error = device_attach(dev);
 		up_write(&dev->bus->subsys.rwsem);
-		device_add_attrs(bus, dev);
-		sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
-		sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
+		if (!error || error == -ENODEV)
+			error = device_add_attrs(bus, dev);
+		if (!error) {
+			sysfs_create_link(&bus->devices.kobj, &dev->kobj, dev->bus_id);
+			sysfs_create_link(&dev->kobj, &dev->bus->subsys.kset.kobj, "bus");
+		} else {
+			pr_debug("bus %s: attach device %s failed with %d\n", bus->name, dev->bus_id, error);
+			put_bus(bus);
+		}
 	}
 	return error;
 }

--------------000907010401040002010909--
