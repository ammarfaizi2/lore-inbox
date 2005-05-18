Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVERHV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVERHV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 03:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVERHV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 03:21:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:24491 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262120AbVERHTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 03:19:43 -0400
Message-ID: <428AEC89.5040301@suse.de>
Date: Wed, 18 May 2005 09:19:37 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Kay Sievers <Kay.Sievers@vrfy.org>
Subject: Re: [PATCH] fix error handling in bus_add_device
References: <428365EC.80906@suse.de> <20050518055602.GA11123@kroah.com>
In-Reply-To: <20050518055602.GA11123@kroah.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010106050502080108010501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010106050502080108010501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Greg KH wrote:
> On Thu, May 12, 2005 at 04:19:24PM +0200, Hannes Reinecke wrote:
>>Hi Greg,
>>
>>this patch fixes the error handling in bus_add_device() and
>>device_attach(). Previously it was 'interesting'.
>>And totally confusing to boot.
> 
> I agree, that's why it has been rewritten in the -mm tree :)
> 
> Anyway, your patch doesn't take into account that device_attach()'s
> return value is tested in the bus_rescan_devices_helper(), so if you
> change the return value, that also needs to be changed.
> 
> But even in the -mm tree, the bus_add_devices() function has not had the
> error handling added to it that you provided, is there any devices that
> you are seeing that need this?
> 
Not yet :-)

I'm just doing some cleanups here which me and Kay Sievers will be
exploiting in the near future.
My main point is:
either we do an error check in bus_add_device and return a proper
status, or we don't and fix bus_add_device to be of type 'void'.
And as some functions called by bus_add_device may fail I thought it
reasonable to evaluate the return status properly.
Unless you tell me that bus_add_device is a fire-and-forget procedure
and we don't care at all for any failures. But then we should at least
set the type of bus_add_device() to 'void'.
You're the maintainer, you have to decide :-).
I don't care either way, I just want to have it consistent.

But you're correct about the bus_rescan_devices_helper. Fixed and new
patch attached.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------010106050502080108010501
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
@@ -588,7 +594,7 @@ static int bus_rescan_devices_helper(str
 {
 	int *count = data;
 
-	if (!dev->driver && device_attach(dev))
+	if (!dev->driver && !device_attach(dev))
 		(*count)++;
 
 	return 0;

--------------010106050502080108010501--
