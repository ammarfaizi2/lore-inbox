Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262812AbVA1WjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbVA1WjY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 17:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbVA1WiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 17:38:16 -0500
Received: from peabody.ximian.com ([130.57.169.10]:25735 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262803AbVA1WgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 17:36:18 -0500
Subject: [RFC][PATCH] add driver matching priorities
From: Adam Belay <abelay@novell.com>
To: greg@kroah.com
Cc: rml@novell.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 28 Jan 2005 17:30:04 -0500
Message-Id: <1106951404.29709.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds initial support for driver matching priorities to the
driver model.  It is needed for my work on converting the pci bridge
driver to use "struct device_driver".  It may also be helpful for driver
with more complex (or long id lists as I've seen in many cases) matching
criteria. 

"match" has been added to "struct device_driver".  There are now two
steps in the matching process.  The first step is a bus specific filter
that determines possible driver candidates.  The second step is a driver
specific match function that verifies if the driver will work with the
hardware, and returns a priority code (how well it is able to handle the
device).  The bus layer could override the driver's match function if
necessary (similar to how it passes *probe through it's layer and then
on to the actual driver).

The current priorities are as follows:

enum {
	MATCH_PRIORITY_FAILURE = 0,
	MATCH_PRIORITY_GENERIC,
	MATCH_PRIORITY_NORMAL,
	MATCH_PRIORITY_VENDOR,
};

let me know if any of this would need to be changed.  For example, the
"struct bus_type" match function could return a priority code.

Of course this patch is not going to be effective alone.  We also need
to change the init order.  If a driver is registered early but isn't the
best available, it will be bound to the device prematurely.  This would
be a problem for carbus (yenta) bridges.

I think we may have to load all in kernel drivers first, and then begin
matching them to hardware.  Do you agree?  If so, I'd be happy to make a
patch for that too.

Thanks,
Adam


--- a/drivers/base/bus.c	2005-01-20 17:37:46.000000000 -0500
+++ b/drivers/base/bus.c	2005-01-28 16:59:00.000000000 -0500
@@ -286,6 +286,9 @@
 	if (drv->bus->match && !drv->bus->match(dev, drv))
 		return -ENODEV;
 
+	if (drv->match && !drv->match(dev))
+		return -ENODEV;
+
 	dev->driver = drv;
 	if (drv->probe) {
 		int error = drv->probe(dev);
@@ -299,6 +302,42 @@
 	return 0;
 }
 
+/**
+ *	driver_probe_device_priority - attempt to bind device & driver with a
+ *				       given match level priority 
+ *	@drv:		driver.
+ *	@dev:		device.
+ *	@priority	the match level priority
+ */
+
+static int driver_probe_device_priority(struct device_driver * drv,
+					struct device * dev, int priority)
+{
+	int matchp;
+
+	if (drv->bus->match && !drv->bus->match(dev, drv))
+		return -ENODEV;
+
+	if (drv->match) {
+		matchp = drv->match(dev);
+	} else
+		matchp = MATCH_PRIORITY_NORMAL;
+
+	if (matchp != priority)
+		return -ENODEV;
+
+	dev->driver = drv;
+	if (drv->probe) {
+		int error = drv->probe(dev);
+		if (error) {
+			dev->driver = NULL;
+			return error;
+		}
+	}
+
+	device_bind_driver(dev);
+	return 0;
+}
 
 /**
  *	device_attach - try to attach device to a driver.
@@ -312,17 +351,20 @@
 {
  	struct bus_type * bus = dev->bus;
 	struct list_head * entry;
-	int error;
+	int error, matchp = MATCH_PRIORITY_VENDOR;
 
 	if (dev->driver) {
 		device_bind_driver(dev);
 		return 1;
 	}
 
-	if (bus->match) {
+	if (!bus->match)
+		return 0;
+		
+	while (matchp > 0) {
 		list_for_each(entry, &bus->drivers.list) {
 			struct device_driver * drv = to_drv(entry);
-			error = driver_probe_device(drv, dev);
+			error = driver_probe_device_priority(drv, dev, matchp);
 			if (!error)
 				/* success, driver matched */
 				return 1;
@@ -332,6 +374,7 @@
 				    "%s: probe of %s failed with error %d\n",
 				    drv->name, dev->bus_id, error);
 		}
+		matchp--;
 	}
 
 	return 0;
--- a/include/linux/device.h	2005-01-20 17:37:26.000000000 -0500
+++ b/include/linux/device.h	2005-01-28 16:40:22.000000000 -0500
@@ -41,6 +41,13 @@
 	RESUME_ENABLE,
 };
 
+enum {
+	MATCH_PRIORITY_FAILURE = 0,
+	MATCH_PRIORITY_GENERIC,
+	MATCH_PRIORITY_NORMAL,
+	MATCH_PRIORITY_VENDOR,
+};
+
 struct device;
 struct device_driver;
 struct class;
@@ -108,6 +115,7 @@
 
 	struct module 		* owner;
 
+	int	(*match)	(struct device * dev);
 	int	(*probe)	(struct device * dev);
 	int 	(*remove)	(struct device * dev);
 	void	(*shutdown)	(struct device * dev);



