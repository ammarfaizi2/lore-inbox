Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVCUJUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVCUJUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 04:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVCUJT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 04:19:59 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:53651 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261721AbVCUJTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 04:19:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=qO28WUxpzVaVC4L8JtYlDQrreyCeKrb4nTY/bx+CSQIEnQPglANtaTE4H0c0zwMaAc2jElyMkJURC7YB3MsSqopGTnYd6XkDybPCf1aWxXEG7lOAlgf2kwIxxpWlNdSi6GNrWLSqb/pZL7fJo6IU4xucv40Mni6sPHYCCl3fQE4=
Date: Mon, 21 Mar 2005 18:18:46 +0900
From: Tejun Heo <htejun@gmail.com>
To: dtor_core@ameritech.net, mochel@digitalimplant.org,
       James.Bottomley@SteelEye.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] driver model/scsi: synchronize pm calls with probe/remove
Message-ID: <20050321091846.GA25933@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Dmitry, Mochel and James.

 I've been looking at sd code and found seemingly bogus 'if (!sdkp)'
tests with /* this can happen */ comment.  I've digged changelog and
found out that this was to prevent oops which occurs if some driver
gets stuck inside ->probe and the machine goes down and calls back
->remove.  IMHO, we should avoid this problem by fixing driver ->probe
or ->remove callbacks instead of detecting and bypassing
half-initialized/destroyed devices in pm callbacks.

 This patch read-locks a device's bus using device_pm_down_read_bus()
before invoking any pm callback.  The function also periodically
prints out warning messages while waiting for the bus subsys rwsem.
This patch makes the machine wait indefinitely if any driver is stuck
inside ->probe or ->remove.

 In device_shutdown(), devices_subsys.kset.list is walked while
holding devices_subsys.rwsem.  This patch nests each bus's subsys
rwsem inside.


 Signed-off-by: Tejun Heo <htejun@gmail.com>


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/21 17:22:41+09:00 tj@htj.dyndns.org 
#   device_pm_down_read_bus() implemented.
# 
# drivers/scsi/sd.c
#   2005/03/21 17:22:33+09:00 tj@htj.dyndns.org +0 -6
#   device_pm_down_read_bus() implemented.
# 
# drivers/base/power/suspend.c
#   2005/03/21 17:22:33+09:00 tj@htj.dyndns.org +4 -1
#   device_pm_down_read_bus() implemented.
# 
# drivers/base/power/shutdown.c
#   2005/03/21 17:22:33+09:00 tj@htj.dyndns.org +13 -5
#   device_pm_down_read_bus() implemented.
# 
# drivers/base/power/resume.c
#   2005/03/21 17:22:33+09:00 tj@htj.dyndns.org +7 -2
#   device_pm_down_read_bus() implemented.
# 
# drivers/base/power/power.h
#   2005/03/21 17:22:33+09:00 tj@htj.dyndns.org +2 -0
#   device_pm_down_read_bus() implemented.
# 
# drivers/base/power/main.c
#   2005/03/21 17:22:33+09:00 tj@htj.dyndns.org +23 -1
#   device_pm_down_read_bus() implemented.
# 
diff -Nru a/drivers/base/power/main.c b/drivers/base/power/main.c
--- a/drivers/base/power/main.c	2005-03-21 17:25:50 +09:00
+++ b/drivers/base/power/main.c	2005-03-21 17:25:50 +09:00
@@ -21,6 +21,7 @@
 
 #include <linux/config.h>
 #include <linux/device.h>
+#include <linux/delay.h>
 #include "power.h"
 
 LIST_HEAD(dpm_active);
@@ -96,4 +97,25 @@
 	up(&dpm_list_sem);
 }
 
-
+/**
+ *	device_pm_down_read_bus - Read-lock dev->bus's rwsem.
+ *	@dev:		The bus of this dev is read locked on return.
+ *	@opstr:		Error message prefix.
+ *
+ *	Read locks the subsys rwsem of the device's bus.  Generally pm
+ *	calls are made with processes frozen, so there shouldn't be
+ *	any contention; however, the shutdown path is invoked when
+ *	halting the machine and it's possible to have some drivers
+ *	stuck inside ->probe or ->remove method.  In such cases, we
+ *	retry while printing a warning message every 10s.
+ */
+void device_pm_down_read_bus(struct device * dev, const char * opstr)
+{
+	int cnt = 0;
+	while (!down_read_trylock(&dev->bus->subsys.rwsem)) {
+		if (cnt++ % 100 == 0)
+			printk(KERN_WARNING "%s %s%s: waiting on bus subsys "
+			       "rwsem\n", opstr, dev->bus->name, dev->bus_id);
+		msleep(100);
+	}
+}
diff -Nru a/drivers/base/power/power.h b/drivers/base/power/power.h
--- a/drivers/base/power/power.h	2005-03-21 17:25:50 +09:00
+++ b/drivers/base/power/power.h	2005-03-21 17:25:50 +09:00
@@ -53,6 +53,8 @@
 extern int device_pm_add(struct device *);
 extern void device_pm_remove(struct device *);
 
+extern void device_pm_down_read_bus(struct device * dev, const char *opstr);
+
 /*
  * sysfs.c
  */
diff -Nru a/drivers/base/power/resume.c b/drivers/base/power/resume.c
--- a/drivers/base/power/resume.c	2005-03-21 17:25:50 +09:00
+++ b/drivers/base/power/resume.c	2005-03-21 17:25:50 +09:00
@@ -22,8 +22,13 @@
 
 int resume_device(struct device * dev)
 {
-	if (dev->bus && dev->bus->resume)
-		return dev->bus->resume(dev);
+	if (dev->bus && dev->bus->resume) {
+		int ret;
+		device_pm_down_read_bus(dev, "Resuming");
+		ret = dev->bus->resume(dev);
+		up_read(&dev->bus->subsys.rwsem);
+		return ret;
+	}
 	return 0;
 }
 
diff -Nru a/drivers/base/power/shutdown.c b/drivers/base/power/shutdown.c
--- a/drivers/base/power/shutdown.c	2005-03-21 17:25:50 +09:00
+++ b/drivers/base/power/shutdown.c	2005-03-21 17:25:50 +09:00
@@ -25,6 +25,8 @@
 		return 0;
 
 	if (dev->detach_state == DEVICE_PM_OFF) {
+		/* We have bus rwsem write-locked on entry to this
+		 * function.  No need to mess with the bus rwsem. */
 		if (dev->driver && dev->driver->shutdown)
 			dev->driver->shutdown(dev);
 		return 0;
@@ -54,11 +56,17 @@
 	down_write(&devices_subsys.rwsem);
 	list_for_each_entry_reverse(dev, &devices_subsys.kset.list, kobj.entry) {
 		pr_debug("shutting down %s: ", dev->bus_id);
-		if (dev->driver && dev->driver->shutdown) {
-			pr_debug("Ok\n");
-			dev->driver->shutdown(dev);
-		} else
-			pr_debug("Ignored.\n");
+		if (dev->bus) {
+			device_pm_down_read_bus(dev, "Shutting down");
+			if (dev->driver && dev->driver->shutdown) {
+				pr_debug("Ok\n");
+				dev->driver->shutdown(dev);
+				up_read(&dev->bus->subsys.rwsem);
+				continue;
+			}
+			up_read(&dev->bus->subsys.rwsem);
+		}
+		pr_debug("Ignored.\n");
 	}
 	up_write(&devices_subsys.rwsem);
 
diff -Nru a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
--- a/drivers/base/power/suspend.c	2005-03-21 17:25:50 +09:00
+++ b/drivers/base/power/suspend.c	2005-03-21 17:25:50 +09:00
@@ -43,8 +43,11 @@
 
 	dev->power.prev_state = dev->power.power_state;
 
-	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
+	if (dev->bus && dev->bus->suspend && !dev->power.power_state) {
+		device_pm_down_read_bus(dev, "Suspending");
 		error = dev->bus->suspend(dev, state);
+		up_read(&dev->bus->subsys.rwsem);
+	}
 
 	return error;
 }
diff -Nru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	2005-03-21 17:25:50 +09:00
+++ b/drivers/scsi/sd.c	2005-03-21 17:25:50 +09:00
@@ -730,9 +730,6 @@
 	struct scsi_device *sdp = to_scsi_device(dev);
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
 
-	if (!sdkp)
-               return -ENODEV;
-
 	if (!sdkp->WCE)
 		return 0;
 
@@ -1682,9 +1679,6 @@
 {
 	struct scsi_device *sdp = to_scsi_device(dev);
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
-
-	if (!sdkp)
-		return;         /* this can happen */
 
 	if (!sdkp->WCE)
 		return;
