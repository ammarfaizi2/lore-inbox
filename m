Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbVERImr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVERImr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 04:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVERImr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 04:42:47 -0400
Received: from cantor.suse.de ([195.135.220.2]:28639 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262117AbVERImZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 04:42:25 -0400
Message-ID: <428AFFEF.7010204@suse.de>
Date: Wed, 18 May 2005 10:42:23 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Kay Sievers <Kay.Sievers@vrfy.org>
Subject: Re: [PATCH] fix error handling in bus_add_device
References: <428365EC.80906@suse.de> <20050518055602.GA11123@kroah.com> <428AEC89.5040301@suse.de> <20050518073230.GA12155@kroah.com>
In-Reply-To: <20050518073230.GA12155@kroah.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060300090609020809020405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060300090609020809020405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Greg KH wrote:
> On Wed, May 18, 2005 at 09:19:37AM +0200, Hannes Reinecke wrote:
>>Greg KH wrote:
>>>On Thu, May 12, 2005 at 04:19:24PM +0200, Hannes Reinecke wrote:
>>>>Hi Greg,
>>>>
>>>>this patch fixes the error handling in bus_add_device() and
>>>>device_attach(). Previously it was 'interesting'.
>>>>And totally confusing to boot.
>>>I agree, that's why it has been rewritten in the -mm tree :)
>>>
>>>Anyway, your patch doesn't take into account that device_attach()'s
>>>return value is tested in the bus_rescan_devices_helper(), so if you
>>>change the return value, that also needs to be changed.
>>>
>>>But even in the -mm tree, the bus_add_devices() function has not had the
>>>error handling added to it that you provided, is there any devices that
>>>you are seeing that need this?
>>>
>>Not yet :-)
>>
>>I'm just doing some cleanups here which me and Kay Sievers will be
>>exploiting in the near future.
>>My main point is:
>>either we do an error check in bus_add_device and return a proper
>>status, or we don't and fix bus_add_device to be of type 'void'.
>>And as some functions called by bus_add_device may fail I thought it
>>reasonable to evaluate the return status properly.
>>Unless you tell me that bus_add_device is a fire-and-forget procedure
>>and we don't care at all for any failures. But then we should at least
>>set the type of bus_add_device() to 'void'.
>>You're the maintainer, you have to decide :-).
>>I don't care either way, I just want to have it consistent.
>>
>>But you're correct about the bus_rescan_devices_helper. Fixed and new
>>patch attached.
> 
> Ok, I agree that we should have error checks in there.  Now, could you
> make your patch against the latest -mm tree instead due to all of the
> changes involved in that area in my trees?  That way I can apply it :)
> 
Whee, innovations.
Which your patches to -mm the whole thing is even easier and now
actually looks quite sane.
New patch attached.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------060300090609020809020405
Content-Type: text/plain;
 name="driver-core-bus_add_device-error-handling"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="driver-core-bus_add_device-error-handling"

From: Hannes Reinecke <hare@suse.de>
Subject: Fix error handling in bus_add_device()

The error handling in bus_add_device() and device_attach() is simply
non-existing. This patch propagates any error from device_attach to
the upper layers to allow for a proper recovery.

--- linux-2.6.12-rc4-mm2/drivers/base/bus.c.orig	2005-05-18 10:26:50.000000000 +0200
+++ linux-2.6.12-rc4-mm2/drivers/base/bus.c	2005-05-18 10:36:08.000000000 +0200
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
--- linux-2.6.12-rc4-mm2/drivers/base/dd.c.orig	2005-05-18 10:29:27.000000000 +0200
+++ linux-2.6.12-rc4-mm2/drivers/base/dd.c	2005-05-18 10:39:45.000000000 +0200
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

--------------060300090609020809020405--
