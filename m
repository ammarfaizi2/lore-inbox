Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751569AbWGYUei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbWGYUei (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbWGYUei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:34:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:37824 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751566AbWGYUeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:34:37 -0400
Date: Tue, 25 Jul 2006 13:30:28 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: [RFC PATCH] Multi-threaded device probing
Message-ID: <20060725203028.GA1270@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During the kernel summit, I was reminded by the wish by some people to
do device probing in parallel, so I created the following patch.  It
offers up the ability for the driver core to create a new thread for
every driver<->device probe call.  To enable this, the driver needs to
have the multithread_probe flag set to 1, otherwise the "traditional"
sequencial probe happens.

Note that this patch does not actually enable the threaded probe for any
busses, as that's very dangerous at this point in time, without the
different bus authors trying it out and verifying that it does work
properly.

I did enable this for both USB and PCI and shaved .4 seconds off of the
boot time of my tiny little single processor laptop.  The savings of my
4-way workstation is much greater, but things start to happen so fast we
miss the root disk, as init starts before the disks are finished being
initialized.  I have some hacks to work around this right now, but I'll
hold off on posting them before I make sure they work properly (breaking
booting of people's machines isn't the best way to get them to accept
new features...)

Anyway, have fun playing around with this if you want, I'll be adding
this to the next -mm, but you will have to enable the bit on your own if
you want to see any speedups.

thanks,

greg k-h

------------
From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: Driver Core: add ability for drivers to do a threaded probe

This adds the infrastructure for drivers to do a threaded probe.

A new kernel thread will be created when the probe() function for the
driver is called, if the multithread_probe bit is set in the driver
saying it can support this kind of operation.

I have tested this with USB and PCI, and it works, and shaves off a lot
of time in the boot process, but there are issues with finding root boot
disks, and some USB drivers assume that this can never happen, so it is
currently not enabled for any bus type.  Individual drivers can enable
this right now if they wish, and bus authors can selectivly turn it on
as well, once they determine that their subsystem will work properly
with it.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/dd.c      |   91 +++++++++++++++++++++++++++++++++----------------
 include/linux/device.h |    2 +
 2 files changed, 65 insertions(+), 28 deletions(-)

--- gregkh-2.6.orig/drivers/base/dd.c
+++ gregkh-2.6/drivers/base/dd.c
@@ -17,6 +17,7 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/kthread.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -51,53 +52,41 @@ void device_bind_driver(struct device * 
 	sysfs_create_link(&dev->kobj, &dev->driver->kobj, "driver");
 }
 
-/**
- *	driver_probe_device - attempt to bind device & driver.
- *	@drv:	driver.
- *	@dev:	device.
- *
- *	First, we call the bus's match function, if one present, which
- *	should compare the device IDs the driver supports with the
- *	device IDs of the device. Note we don't do this ourselves
- *	because we don't know the format of the ID structures, nor what
- *	is to be considered a match and what is not.
- *
- *	This function returns 1 if a match is found, an error if one
- *	occurs (that is not -ENODEV or -ENXIO), and 0 otherwise.
- *
- *	This function must be called with @dev->sem held.  When called
- *	for a USB interface, @dev->parent->sem must be held as well.
- */
-int driver_probe_device(struct device_driver * drv, struct device * dev)
+struct stupid_thread_structure {
+	struct device_driver *drv;
+	struct device *dev;
+};
+
+static int really_probe(void *void_data)
 {
+	struct stupid_thread_structure *data = void_data;
+	struct device_driver *drv = data->drv;
+	struct device *dev = data->dev;
 	int ret = 0;
 
-	if (drv->bus->match && !drv->bus->match(dev, drv))
-		goto Done;
-
-	pr_debug("%s: Matched Device %s with Driver %s\n",
-		 drv->bus->name, dev->bus_id, drv->name);
+	pr_debug("%s: Probing driver %s with device %s\n",
+		 drv->bus->name, drv->name, dev->bus_id);
 	dev->driver = drv;
 	if (dev->bus->probe) {
 		ret = dev->bus->probe(dev);
 		if (ret) {
 			dev->driver = NULL;
-			goto ProbeFailed;
+			goto probe_failed;
 		}
 	} else if (drv->probe) {
 		ret = drv->probe(dev);
 		if (ret) {
 			dev->driver = NULL;
-			goto ProbeFailed;
+			goto probe_failed;
 		}
 	}
 	device_bind_driver(dev);
 	ret = 1;
 	pr_debug("%s: Bound Device %s to Driver %s\n",
 		 drv->bus->name, dev->bus_id, drv->name);
-	goto Done;
+	goto done;
 
- ProbeFailed:
+probe_failed:
 	if (ret == -ENODEV || ret == -ENXIO) {
 		/* Driver matched, but didn't support device
 		 * or device not found.
@@ -110,7 +99,53 @@ int driver_probe_device(struct device_dr
 		       "%s: probe of %s failed with error %d\n",
 		       drv->name, dev->bus_id, ret);
 	}
- Done:
+done:
+	kfree(data);
+	return ret;
+}
+
+/**
+ * driver_probe_device - attempt to bind device & driver together
+ * @drv: driver to bind a device to
+ * @dev: device to try to bind to the driver
+ *
+ * First, we call the bus's match function, if one present, which should
+ * compare the device IDs the driver supports with the device IDs of the
+ * device. Note we don't do this ourselves because we don't know the
+ * format of the ID structures, nor what is to be considered a match and
+ * what is not.
+ *
+ * This function returns 1 if a match is found, an error if one occurs
+ * (that is not -ENODEV or -ENXIO), and 0 otherwise.
+ *
+ * This function must be called with @dev->sem held.  When called for a
+ * USB interface, @dev->parent->sem must be held as well.
+ */
+int driver_probe_device(struct device_driver * drv, struct device * dev)
+{
+	struct stupid_thread_structure *data;
+	struct task_struct *probe_task;
+	int ret = 0;
+
+	if (drv->bus->match && !drv->bus->match(dev, drv))
+		goto done;
+
+	pr_debug("%s: Matched Device %s with Driver %s\n",
+		 drv->bus->name, dev->bus_id, drv->name);
+
+	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	data->drv = drv;
+	data->dev = dev;
+
+	if (drv->multithread_probe) {
+		probe_task = kthread_run(really_probe, data,
+					 "probe-%s", dev->bus_id);
+		if (IS_ERR(probe_task))
+			ret = PTR_ERR(probe_task);
+	} else
+		ret = really_probe(data);
+
+done:
 	return ret;
 }
 
--- gregkh-2.6.orig/include/linux/device.h
+++ gregkh-2.6/include/linux/device.h
@@ -105,6 +105,8 @@ struct device_driver {
 	void	(*shutdown)	(struct device * dev);
 	int	(*suspend)	(struct device * dev, pm_message_t state);
 	int	(*resume)	(struct device * dev);
+
+	unsigned int multithread_probe:1;
 };
 
 
