Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVCJCka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVCJCka (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 21:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbVCJBO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:14:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:44191 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262608AbVCJAmX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:23 -0500
Cc: gregkh@suse.de
Subject: [PATCH] sysdev: remove the rwsem usage from this subsystem.
In-Reply-To: <1110414886525@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:46 -0800
Message-Id: <11104148863516@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2054, 2005/03/09 15:39:09-08:00, gregkh@suse.de

[PATCH] sysdev: remove the rwsem usage from this subsystem.

If further finer grained locking is needed, we can add a lock to the sysdev_class to
lock the class drivers list.  But if you do that, remember the global list also is still
there and needs to be protected.  That's why I went with a simple lock for everything.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/base/sys.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)


diff -Nru a/drivers/base/sys.c b/drivers/base/sys.c
--- a/drivers/base/sys.c	2005-03-09 16:28:10 -08:00
+++ b/drivers/base/sys.c	2005-03-09 16:28:10 -08:00
@@ -103,6 +103,7 @@
 
 
 static LIST_HEAD(sysdev_drivers);
+static DECLARE_MUTEX(sysdev_drivers_lock);
 
 /**
  *	sysdev_driver_register - Register auxillary driver
@@ -119,7 +120,7 @@
 int sysdev_driver_register(struct sysdev_class * cls,
 			   struct sysdev_driver * drv)
 {
-	down_write(&system_subsys.rwsem);
+	down(&sysdev_drivers_lock);
 	if (cls && kset_get(&cls->kset)) {
 		list_add_tail(&drv->entry, &cls->drivers);
 
@@ -131,7 +132,7 @@
 		}
 	} else
 		list_add_tail(&drv->entry, &sysdev_drivers);
-	up_write(&system_subsys.rwsem);
+	up(&sysdev_drivers_lock);
 	return 0;
 }
 
@@ -144,7 +145,7 @@
 void sysdev_driver_unregister(struct sysdev_class * cls,
 			      struct sysdev_driver * drv)
 {
-	down_write(&system_subsys.rwsem);
+	down(&sysdev_drivers_lock);
 	list_del_init(&drv->entry);
 	if (cls) {
 		if (drv->remove) {
@@ -154,7 +155,7 @@
 		}
 		kset_put(&cls->kset);
 	}
-	up_write(&system_subsys.rwsem);
+	up(&sysdev_drivers_lock);
 }
 
 EXPORT_SYMBOL_GPL(sysdev_driver_register);
@@ -193,7 +194,7 @@
 	if (!error) {
 		struct sysdev_driver * drv;
 
-		down_write(&system_subsys.rwsem);
+		down(&sysdev_drivers_lock);
 		/* Generic notification is implicit, because it's that
 		 * code that should have called us.
 		 */
@@ -209,7 +210,7 @@
 			if (drv->add)
 				drv->add(sysdev);
 		}
-		up_write(&system_subsys.rwsem);
+		up(&sysdev_drivers_lock);
 	}
 	return error;
 }
@@ -218,7 +219,7 @@
 {
 	struct sysdev_driver * drv;
 
-	down_write(&system_subsys.rwsem);
+	down(&sysdev_drivers_lock);
 	list_for_each_entry(drv, &sysdev_drivers, entry) {
 		if (drv->remove)
 			drv->remove(sysdev);
@@ -228,7 +229,7 @@
 		if (drv->remove)
 			drv->remove(sysdev);
 	}
-	up_write(&system_subsys.rwsem);
+	up(&sysdev_drivers_lock);
 
 	kobject_unregister(&sysdev->kobj);
 }
@@ -255,7 +256,7 @@
 
 	pr_debug("Shutting Down System Devices\n");
 
-	down_write(&system_subsys.rwsem);
+	down(&sysdev_drivers_lock);
 	list_for_each_entry_reverse(cls, &system_subsys.kset.list,
 				    kset.kobj.entry) {
 		struct sys_device * sysdev;
@@ -284,7 +285,7 @@
 				cls->shutdown(sysdev);
 		}
 	}
-	up_write(&system_subsys.rwsem);
+	up(&sysdev_drivers_lock);
 }
 
 

