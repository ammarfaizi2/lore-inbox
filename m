Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbVCJBKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbVCJBKs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbVCJBIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:08:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:49055 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262617AbVCJAm1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:27 -0500
Cc: Michael.Waychison@Sun.COM
Subject: [PATCH] driver core: clean driver unload
In-Reply-To: <11104148831572@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:44 -0800
Message-Id: <11104148843411@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2045, 2005/03/09 09:52:29-08:00, Michael.Waychison@Sun.COM

[PATCH] driver core: clean driver unload

Get rid of semaphore abuse by converting device_driver->unload_sem
semaphore to device_driver->unloaded completion.

This should get rid of any confusion as well as save a few bytes in the
process.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/base/bus.c     |    2 +-
 drivers/base/driver.c  |   13 ++++++-------
 include/linux/device.h |    2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	2005-03-09 16:29:14 -08:00
+++ b/drivers/base/bus.c	2005-03-09 16:29:14 -08:00
@@ -65,7 +65,7 @@
 static void driver_release(struct kobject * kobj)
 {
 	struct device_driver * drv = to_driver(kobj);
-	up(&drv->unload_sem);
+	complete(&drv->unloaded);
 }
 
 static struct kobj_type ktype_driver = {
diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	2005-03-09 16:29:14 -08:00
+++ b/drivers/base/driver.c	2005-03-09 16:29:14 -08:00
@@ -79,14 +79,14 @@
  *	since most of the things we have to do deal with the bus
  *	structures.
  *
- *	The one interesting aspect is that we initialize @drv->unload_sem
- *	to a locked state here. It will be unlocked when the driver
- *	reference count reaches 0.
+ *	The one interesting aspect is that we setup @drv->unloaded
+ *	as a completion that gets complete when the driver reference
+ *	count reaches 0.
  */
 int driver_register(struct device_driver * drv)
 {
 	INIT_LIST_HEAD(&drv->devices);
-	init_MUTEX_LOCKED(&drv->unload_sem);
+	init_completion(&drv->unloaded);
 	return bus_add_driver(drv);
 }
 
@@ -97,7 +97,7 @@
  *
  *	Again, we pass off most of the work to the bus-level call.
  *
- *	Though, once that is done, we attempt to take @drv->unload_sem.
+ *	Though, once that is done, we wait until @drv->unloaded is completed.
  *	This will block until the driver refcount reaches 0, and it is
  *	released. Only modular drivers will call this function, and we
  *	have to guarantee that it won't complete, letting the driver
@@ -107,8 +107,7 @@
 void driver_unregister(struct device_driver * drv)
 {
 	bus_remove_driver(drv);
-	down(&drv->unload_sem);
-	up(&drv->unload_sem);
+	wait_for_completion(&drv->unloaded);
 }
 
 /**
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2005-03-09 16:29:14 -08:00
+++ b/include/linux/device.h	2005-03-09 16:29:14 -08:00
@@ -102,7 +102,7 @@
 	char			* name;
 	struct bus_type		* bus;
 
-	struct semaphore	unload_sem;
+	struct completion	unloaded;
 	struct kobject		kobj;
 	struct list_head	devices;
 

