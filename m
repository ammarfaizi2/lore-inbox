Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268711AbUJTRWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268711AbUJTRWZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 13:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268753AbUJTROM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:14:12 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:47266
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S268726AbUJTRMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:12:31 -0400
Subject: [PATCH] Driver Subsystem: Replace abused semaphore
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Patrick Mochel <mochel@digitalimplant.org>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1098291870.12223.1618.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 19:04:30 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use completion instead of the abused semaphore. Semaphores are slower
and trigger owner conflicts during semaphore debugging.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@elte.hu>

---

 2.6.9-bk-041020-thomas/drivers/base/bus.c     |    2 +-
 2.6.9-bk-041020-thomas/drivers/base/driver.c  |   17 +++++++----------
 2.6.9-bk-041020-thomas/include/linux/device.h |    2 +-
 3 files changed, 9 insertions(+), 12 deletions(-)

diff -puN drivers/base/bus.c~driversbase drivers/base/bus.c
--- 2.6.9-bk-041020/drivers/base/bus.c~driversbase	2004-10-20
15:31:33.000000000 +0200
+++ 2.6.9-bk-041020-thomas/drivers/base/bus.c	2004-10-20
15:31:33.000000000 +0200
@@ -65,7 +65,7 @@ static struct sysfs_ops driver_sysfs_ops
 static void driver_release(struct kobject * kobj)
 {
 	struct device_driver * drv = to_driver(kobj);
-	up(&drv->unload_sem);
+	complete(&drv->unload_done);
 }
 
 static struct kobj_type ktype_driver = {
diff -puN drivers/base/driver.c~driversbase drivers/base/driver.c
--- 2.6.9-bk-041020/drivers/base/driver.c~driversbase	2004-10-20
15:31:33.000000000 +0200
+++ 2.6.9-bk-041020-thomas/drivers/base/driver.c	2004-10-20
15:54:47.000000000 +0200
@@ -79,14 +79,13 @@ void put_driver(struct device_driver * d
  *	since most of the things we have to do deal with the bus
  *	structures.
  *
- *	The one interesting aspect is that we initialize @drv->unload_sem
- *	to a locked state here. It will be unlocked when the driver
- *	reference count reaches 0.
+ *	We init the completion struct here. When the reference
+ *	count reaches zero, complete() is called from bus_release().
  */
 int driver_register(struct device_driver * drv)
 {
 	INIT_LIST_HEAD(&drv->devices);
-	init_MUTEX_LOCKED(&drv->unload_sem);
+	init_completion(&drv->unload_done);
 	return bus_add_driver(drv);
 }
 
@@ -97,18 +96,16 @@ int driver_register(struct device_driver
  *
  *	Again, we pass off most of the work to the bus-level call.
  *
- *	Though, once that is done, we attempt to take @drv->unload_sem.
- *	This will block until the driver refcount reaches 0, and it is
- *	released. Only modular drivers will call this function, and we
+ *	Though, once that is done, we wait until the driver refcount
+ *	reaches 0, and complete() is called in bus_release().
+ *	Only modular drivers will call this function, and we
  *	have to guarantee that it won't complete, letting the driver
  *	unload until all references are gone.
  */
-
 void driver_unregister(struct device_driver * drv)
 {
 	bus_remove_driver(drv);
-	down(&drv->unload_sem);
-	up(&drv->unload_sem);
+	wait_for_completion(&drv->unload_done);
 }
 
 /**
diff -puN include/linux/device.h~driversbase include/linux/device.h
--- 2.6.9-bk-041020/include/linux/device.h~driversbase	2004-10-20
15:31:33.000000000 +0200
+++ 2.6.9-bk-041020-thomas/include/linux/device.h	2004-10-20
15:31:33.000000000 +0200
@@ -102,7 +102,7 @@ struct device_driver {
 	char			* name;
 	struct bus_type		* bus;
 
-	struct semaphore	unload_sem;
+	struct completion	unload_done;
 	struct kobject		kobj;
 	struct list_head	devices;
 
_


