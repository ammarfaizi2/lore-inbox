Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVHKCf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVHKCf7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 22:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVHKCf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 22:35:58 -0400
Received: from fmr19.intel.com ([134.134.136.18]:35553 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932229AbVHKCf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 22:35:58 -0400
Subject: [PATCH]hande sysdev suspend failure
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 10:37:39 +0800
Message-Id: <1123727859.2918.4.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This patch adds the return value check for sysdev suspend and does
restore in failure case. Send the patch to pm-list, but seems lost, so I
resend it.


Signed-off-by: Shaohua Li<shaohua.li@intel.com>
---

 linux-2.6.13-rc3-root/drivers/base/sys.c |  110 +++++++++++++++++++++++--------
 1 files changed, 85 insertions(+), 25 deletions(-)

diff -puN drivers/base/sys.c~sysdev drivers/base/sys.c
--- linux-2.6.13-rc3/drivers/base/sys.c~sysdev	2005-07-27 10:49:52.000000000 +0800
+++ linux-2.6.13-rc3-root/drivers/base/sys.c	2005-07-28 10:56:10.373347264 +0800
@@ -288,6 +288,27 @@ void sysdev_shutdown(void)
 	up(&sysdev_drivers_lock);
 }
 
+static void __sysdev_resume(struct sys_device *dev)
+{
+	struct sysdev_class *cls = dev->cls;
+	struct sysdev_driver *drv;
+
+	/* First, call the class-specific one */
+	if (cls->resume)
+		cls->resume(dev);
+
+	/* Call auxillary drivers next. */
+	list_for_each_entry(drv, &cls->drivers, entry) {
+		if (drv->resume)
+			drv->resume(dev);
+	}
+
+	/* Call global drivers. */
+	list_for_each_entry(drv, &sysdev_drivers, entry) {
+		if (drv->resume)
+			drv->resume(dev);
+	}
+}
 
 /**
  *	sysdev_suspend - Suspend all system devices.
@@ -305,38 +326,93 @@ void sysdev_shutdown(void)
 int sysdev_suspend(pm_message_t state)
 {
 	struct sysdev_class * cls;
+	struct sys_device *sysdev, *err_dev;
+	struct sysdev_driver *drv, *err_drv;
+	int ret;
 
 	pr_debug("Suspending System Devices\n");
 
 	list_for_each_entry_reverse(cls, &system_subsys.kset.list,
 				    kset.kobj.entry) {
-		struct sys_device * sysdev;
 
 		pr_debug("Suspending type '%s':\n",
 			 kobject_name(&cls->kset.kobj));
 
 		list_for_each_entry(sysdev, &cls->kset.list, kobj.entry) {
-			struct sysdev_driver * drv;
 			pr_debug(" %s\n", kobject_name(&sysdev->kobj));
 
 			/* Call global drivers first. */
 			list_for_each_entry(drv, &sysdev_drivers, entry) {
-				if (drv->suspend)
-					drv->suspend(sysdev, state);
+				if (drv->suspend) {
+					ret = drv->suspend(sysdev, state);
+					if (ret)
+						goto gbl_driver;
+				}
 			}
 
 			/* Call auxillary drivers next. */
 			list_for_each_entry(drv, &cls->drivers, entry) {
-				if (drv->suspend)
-					drv->suspend(sysdev, state);
+				if (drv->suspend) {
+					ret = drv->suspend(sysdev, state);
+					if (ret)
+						goto aux_driver;
+				}
 			}
 
 			/* Now call the generic one */
-			if (cls->suspend)
-				cls->suspend(sysdev, state);
+			if (cls->suspend) {
+				ret = cls->suspend(sysdev, state);
+				if (ret)
+					goto cls_driver;
+			}
 		}
 	}
 	return 0;
+	/* resume current sysdev */
+cls_driver:
+	drv = NULL;
+	printk(KERN_ERR "Class suspend failed for %s\n",
+		kobject_name(&sysdev->kobj));
+
+aux_driver:
+	if (drv)
+		printk(KERN_ERR "Class driver suspend failed for %s\n",
+				kobject_name(&sysdev->kobj));
+	list_for_each_entry(err_drv, &cls->drivers, entry) {
+		if (err_drv == drv)
+			break;
+		if (err_drv->resume)
+			err_drv->resume(sysdev);
+	}
+	drv = NULL;
+
+gbl_driver:
+	if (drv)
+		printk(KERN_ERR "sysdev driver suspend failed for %s\n",
+				kobject_name(&sysdev->kobj));
+	list_for_each_entry(err_drv, &sysdev_drivers, entry) {
+		if (err_drv == drv)
+			break;
+		if (err_drv->resume)
+			err_drv->resume(sysdev);
+	}
+	/* resume other sysdevs in current class */
+	list_for_each_entry(err_dev, &cls->kset.list, kobj.entry) {
+		if (err_dev == sysdev)
+			break;
+		pr_debug(" %s\n", kobject_name(&err_dev->kobj));
+		__sysdev_resume(err_dev);
+	}
+
+	/* resume other classes */
+	list_for_each_entry_continue(cls, &system_subsys.kset.list,
+					kset.kobj.entry) {
+		list_for_each_entry(err_dev, &cls->kset.list, kobj.entry) {
+			pr_debug(" %s\n", kobject_name(&err_dev->kobj));
+			__sysdev_resume(err_dev);
+		}
+	}
+	return ret;
 }
 
 
@@ -362,25 +438,9 @@ int sysdev_resume(void)
 			 kobject_name(&cls->kset.kobj));
 
 		list_for_each_entry(sysdev, &cls->kset.list, kobj.entry) {
-			struct sysdev_driver * drv;
 			pr_debug(" %s\n", kobject_name(&sysdev->kobj));
 
-			/* First, call the class-specific one */
-			if (cls->resume)
-				cls->resume(sysdev);
-
-			/* Call auxillary drivers next. */
-			list_for_each_entry(drv, &cls->drivers, entry) {
-				if (drv->resume)
-					drv->resume(sysdev);
-			}
-
-			/* Call global drivers. */
-			list_for_each_entry(drv, &sysdev_drivers, entry) {
-				if (drv->resume)
-					drv->resume(sysdev);
-			}
-
+			__sysdev_resume(sysdev);
 		}
 	}
 	return 0;
_


