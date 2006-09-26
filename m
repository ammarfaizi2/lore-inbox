Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWIZFle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWIZFle (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWIZFlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:41:03 -0400
Received: from ns2.suse.de ([195.135.220.15]:64725 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751412AbWIZFkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:40:22 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 43/47] Driver Core: add ability for drivers to do a threaded probe
Date: Mon, 25 Sep 2006 22:38:03 -0700
Message-Id: <11592492221573-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592492193773-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com> <11592491803904-git-send-email-greg@kroah.com> <11592491833450-git-send-email-greg@kroah.com> <11592491862904-git-send-email-greg@kroah.com> <11592491901464-git-send-email-greg@kroah.com> <11592491924093-git-send-email-greg@kroah.com> <1159249196427-git-send-email-greg@kroah.com> <1159249200793-git-send-email-greg@kroah.com> <11592492023883-git-send-email-greg@kroah.com> <11592492061208-git-send-email-greg@kroah.com> <1159249209773-git-send-email-greg@kroah.com> <11592492123695-git-send-email-greg@kroah.com> <11592492153066-git-send-email-greg@kroah.com> <11592492193773-gi
 t-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This adds the infrastructure for drivers to do a threaded probe, and
waits at init time for all currently outstanding probes to complete.

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
 drivers/base/dd.c      |  108 ++++++++++++++++++++++++++++++++++++------------
 include/linux/device.h |    3 +
 init/do_mounts.c       |    5 ++
 3 files changed, 89 insertions(+), 27 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9f6f11c..319a73b 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -17,6 +17,7 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/kthread.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -63,44 +64,35 @@ int device_bind_driver(struct device *de
 	return ret;
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
+static atomic_t probe_count = ATOMIC_INIT(0);
+static int really_probe(void *void_data)
 {
+	struct stupid_thread_structure *data = void_data;
+	struct device_driver *drv = data->drv;
+	struct device *dev = data->dev;
 	int ret = 0;
 
-	if (drv->bus->match && !drv->bus->match(dev, drv))
-		goto Done;
+	atomic_inc(&probe_count);
+	pr_debug("%s: Probing driver %s with device %s\n",
+		 drv->bus->name, drv->name, dev->bus_id);
 
-	pr_debug("%s: Matched Device %s with Driver %s\n",
-		 drv->bus->name, dev->bus_id, drv->name);
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
 	if (device_bind_driver(dev)) {
@@ -111,9 +103,9 @@ int driver_probe_device(struct device_dr
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
@@ -126,7 +118,69 @@ int driver_probe_device(struct device_dr
 		       "%s: probe of %s failed with error %d\n",
 		       drv->name, dev->bus_id, ret);
 	}
- Done:
+done:
+	kfree(data);
+	atomic_dec(&probe_count);
+	return ret;
+}
+
+/**
+ * driver_probe_done
+ * Determine if the probe sequence is finished or not.
+ *
+ * Should somehow figure out how to use a semaphore, not an atomic variable...
+ */
+int driver_probe_done(void)
+{
+	pr_debug("%s: probe_count = %d\n", __FUNCTION__,
+		 atomic_read(&probe_count));
+	if (atomic_read(&probe_count))
+		return -EBUSY;
+	return 0;
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
 
diff --git a/include/linux/device.h b/include/linux/device.h
index b3da9a8..74246ef 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -106,6 +106,8 @@ struct device_driver {
 	void	(*shutdown)	(struct device * dev);
 	int	(*suspend)	(struct device * dev, pm_message_t state);
 	int	(*resume)	(struct device * dev);
+
+	unsigned int multithread_probe:1;
 };
 
 
@@ -115,6 +117,7 @@ extern void driver_unregister(struct dev
 extern struct device_driver * get_driver(struct device_driver * drv);
 extern void put_driver(struct device_driver * drv);
 extern struct device_driver *driver_find(const char *name, struct bus_type *bus);
+extern int driver_probe_done(void);
 
 /* driverfs interface for exporting driver attributes */
 
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 94aeec7..b290aad 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -8,6 +8,7 @@ #include <linux/root_dev.h>
 #include <linux/security.h>
 #include <linux/delay.h>
 #include <linux/mount.h>
+#include <linux/device.h>
 
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
@@ -403,6 +404,10 @@ void __init prepare_namespace(void)
 		ssleep(root_delay);
 	}
 
+	/* wait for the known devices to complete their probing */
+	while (driver_probe_done() != 0)
+		msleep(100);
+
 	md_run_setup();
 
 	if (saved_root_name[0]) {
-- 
1.4.2.1

