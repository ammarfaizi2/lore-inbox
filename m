Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVDUI2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVDUI2b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 04:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVDUI2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 04:28:24 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:440 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261459AbVDUHaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:24 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 19/22] W1: convert families to be proper sysfs rivers
Date: Thu, 21 Apr 2005 02:26:08 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
References: <200504210207.02421.dtor_core@ameritech.net>
In-Reply-To: <200504210207.02421.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504210226.08912.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1: convert family into proper device-model drivers:
    - embed driver structure into w1_family and register with the
      driver core;
    - do not try to manually bind slaves to familes, leave it to
      the driver core;
    - fold w1_family.c into w1.c

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/w1/w1_family.c       |  165 -------------------------------------------
 dtor/drivers/w1/Makefile     |    2 
 dtor/drivers/w1/w1.c         |  118 +++++++++++++++++++++++-------
 dtor/drivers/w1/w1.h         |   16 +++-
 dtor/drivers/w1/w1_family.h  |   28 -------
 dtor/drivers/w1/w1_sernum.c  |    4 +
 dtor/drivers/w1/w1_thermal.c |    6 +
 7 files changed, 114 insertions(+), 225 deletions(-)

Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -37,7 +37,6 @@
 #include "w1.h"
 #include "w1_io.h"
 #include "w1_log.h"
-#include "w1_family.h"
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
@@ -51,14 +50,24 @@ module_param_named(scan_interval, w1_sca
 module_param_named(max_slave_count, w1_max_slave_count, int, 0);
 module_param_named(slave_ttl, w1_max_slave_ttl, int, 0);
 
-static int w1_master_match(struct device *dev, struct device_driver *drv)
+static int w1_bus_match(struct device *dev, struct device_driver *drv)
 {
-	return 1;
+	/*
+	 * Master devices are bound explicitely upon registration
+	 * so we can only get slaves here.
+	 */
+	struct w1_slave *slave = to_w1_slave(dev);
+	struct w1_family *family = to_w1_family(drv);
+
+	if (slave->reg_num.family == family->fid)
+		return 1;
+
+	return 0;
 }
 
 static struct bus_type w1_bus_type = {
 	.name = "w1",
-	.match = w1_master_match,
+	.match = w1_bus_match,
 };
 
 struct device_driver w1_master_driver = {
@@ -102,7 +111,6 @@ static void w1_slave_release(struct devi
 {
 	struct w1_slave *slave = to_w1_slave(dev);
 
-	w1_family_put(slave->family);
 	kfree(slave);
 	module_put(THIS_MODULE);
 }
@@ -127,28 +135,13 @@ static int w1_attach_slave_device(struct
 	set_bit(W1_SLAVE_ACTIVE, &slave->flags);
 	slave->ttl = master->slave_ttl;
 
-	spin_lock(&w1_flock);
-	slave->family = w1_family_registered(rn->family);
-	if (!slave->family) {
-		spin_unlock(&w1_flock);
-		dev_info(&master->dev,
-			 "Family %x for %02x.%012llx.%02x is not registered.\n",
-			 rn->family, rn->family,
-			 (unsigned long long)rn->id, rn->crc);
-		kfree(slave);
-		return -ENODEV;
-	}
-	__w1_family_get(slave->family);
-	spin_unlock(&w1_flock);
-
-	slave->dev.parent = &slave->master->dev;
-	slave->dev.bus = &w1_bus_type;
-	slave->dev.release = &w1_slave_release;
-
 	snprintf(&slave->dev.bus_id[0], sizeof(slave->dev.bus_id),
 		  "%02x-%012llx",
 		  (unsigned int) slave->reg_num.family,
 		  (unsigned long long) slave->reg_num.id);
+	slave->dev.parent = &slave->master->dev;
+	slave->dev.bus = &w1_bus_type;
+	slave->dev.release = &w1_slave_release;
 
 	dev_dbg(&slave->dev, "%s: registering %s.\n", __func__,
 		&slave->dev.bus_id[0]);
@@ -158,7 +151,6 @@ static int w1_attach_slave_device(struct
 		dev_err(&slave->dev,
 			 "Device registration [%s] failed. err=%d\n",
 			 slave->dev.bus_id, error);
-		w1_family_put(slave->family);
 		kfree(slave);
 		return error;
 	}
@@ -174,8 +166,6 @@ static int w1_attach_slave_device(struct
 		return error;
 	}
 
-	w1_family_join(slave);	/* assume it always succeeds for now */
-
 	list_add_tail(&slave->node, &slave->master->slist);
 
 	return 0;
@@ -186,7 +176,6 @@ static void w1_slave_detach(struct w1_sl
 	dev_info(&slave->dev, "%s: detaching %s.\n",
 		 __func__, slave->dev.bus_id);
 
-	w1_family_leave(slave);
 	sysfs_remove_group(&slave->dev.kobj, &w1_slave_defattr_group);
 	device_unregister(&slave->dev);
 }
@@ -464,6 +453,79 @@ void w1_remove_master_device(struct w1_m
 	device_unregister(&master->dev);
 }
 
+static int w1_family_probe(struct device *dev)
+{
+	struct w1_slave *slave = to_w1_slave(dev);
+	struct w1_family *family = to_w1_family(dev->driver);
+	int retval;
+
+	retval = down_interruptible(&slave->mutex);
+	if (retval)
+		return retval;
+
+	if (family->join)
+		retval = family->join(slave);
+
+	up(&slave->mutex);
+	return retval;
+}
+
+static int w1_family_remove(struct device *dev)
+{
+	struct w1_slave *slave = to_w1_slave(dev);
+	struct w1_family *family = to_w1_family(dev->driver);
+
+	down(&slave->mutex);
+
+	if (family->leave)
+		family->leave(slave);
+
+	up(&slave->mutex);
+	return 0;
+}
+
+static ssize_t w1_family_show_name(struct device_driver *drv, char *buf)
+{
+	struct w1_family *family = to_w1_family(drv);
+
+	return sprintf(buf, "%s\n", family->name);
+}
+
+static struct driver_attribute w1_family_attribute_name =
+	__ATTR(name, S_IRUGO, w1_family_show_name, NULL);
+
+int w1_register_family(struct w1_family *family)
+{
+	int error;
+
+	family->driver.bus = &w1_bus_type;
+	family->driver.probe = w1_family_probe;
+	family->driver.remove = w1_family_remove;
+
+	error = driver_register(&family->driver);
+	if (error) {
+		printk(KERN_ERR "w1: Failed to register family. err=%d.\n",
+		       error);
+		return error;
+	}
+
+	error = driver_create_file(&family->driver, &w1_family_attribute_name);
+	if (error) {
+		printk(KERN_ERR
+		       "w1: Failed to create name family attribute. err=%d.\n",
+		       error);
+		driver_unregister(&family->driver);
+		return error;
+	}
+
+	return 0;
+}
+
+void w1_unregister_family(struct w1_family *family)
+{
+	driver_unregister(&family->driver);
+}
+
 static int w1_init(void)
 {
 	int error;
@@ -501,3 +563,5 @@ module_exit(w1_exit);
 EXPORT_SYMBOL(w1_allocate_master_device);
 EXPORT_SYMBOL(w1_add_master_device);
 EXPORT_SYMBOL(w1_remove_master_device);
+EXPORT_SYMBOL(w1_register_family);
+EXPORT_SYMBOL(w1_unregister_family);
Index: dtor/drivers/w1/w1.h
===================================================================
--- dtor.orig/drivers/w1/w1.h
+++ dtor/drivers/w1/w1.h
@@ -44,8 +44,6 @@ struct w1_reg_num
 
 #include <asm/semaphore.h>
 
-#include "w1_family.h"
-
 #define W1_MAXNAMELEN		32
 
 #define W1_SEARCH		0xF0
@@ -68,7 +66,6 @@ struct w1_slave
 	int			ttl;
 
 	struct w1_master	*master;
-	struct w1_family	*family;
 	struct device		dev;
 	struct semaphore	mutex;
 };
@@ -119,6 +116,19 @@ struct w1_master *w1_allocate_master_dev
 int w1_add_master_device(struct w1_master *);
 void w1_remove_master_device(struct w1_master *);
 
+struct w1_family {
+	struct device_driver	driver;
+	u8			fid;
+	const char		*name;
+
+	int (*join)(struct w1_slave *);
+	void (*leave)(struct w1_slave *);
+};
+#define to_w1_family(drv)	container_of((drv), struct w1_family, driver)
+
+int w1_register_family(struct w1_family *f);
+void w1_unregister_family(struct w1_family *f);
+
 #endif /* __KERNEL__ */
 
 #endif /* __W1_H */
Index: dtor/drivers/w1/w1_thermal.c
===================================================================
--- dtor.orig/drivers/w1/w1_thermal.c
+++ dtor/drivers/w1/w1_thermal.c
@@ -51,7 +51,11 @@ static void w1_thermal_leave(struct w1_s
 }
 
 static struct w1_family w1_thermal_family = {
+	.driver		= {
+		.name	= "thermal",
+	},
 	.fid		= W1_FAMILY_THERMAL,
+	.name		= "Digital Thermometer Driver",
 	.join		= w1_thermal_join,
 	.leave		= w1_thermal_leave,
 };
@@ -141,7 +145,7 @@ static ssize_t w1_thermal_show_temp(stru
 	if (error)
 		goto out;
 
-	if (slave->family != &w1_thermal_family) {
+	if (slave->dev.driver != &w1_thermal_family.driver) {
 		error = -ENODEV;
 		goto out;
 	}
Index: dtor/drivers/w1/Makefile
===================================================================
--- dtor.orig/drivers/w1/Makefile
+++ dtor/drivers/w1/Makefile
@@ -7,7 +7,7 @@ EXTRA_CFLAGS	+= -DNETLINK_DISABLED
 endif
 
 obj-$(CONFIG_W1)	+= wire.o
-wire-objs		:= w1.o w1_family.o w1_io.o
+wire-objs		:= w1.o w1_io.o
 
 obj-$(CONFIG_W1_MATROX)		+= matrox_w1.o
 obj-$(CONFIG_W1_THERMAL)	+= w1_thermal.o
Index: dtor/drivers/w1/w1_sernum.c
===================================================================
--- dtor.orig/drivers/w1/w1_sernum.c
+++ dtor/drivers/w1/w1_sernum.c
@@ -41,7 +41,11 @@ MODULE_DESCRIPTION("1-Wire Silicon Seria
  */
 
 static struct w1_family w1_serial_num_family = {
+	.driver		= {
+		.name	= "sernum",
+	},
 	.fid		= W1_FAMILY_SERIAL_NUM,
+	.name		= "Serial Number Driver",
 };
 
 static int __init w1_serial_num_init(void)
Index: dtor/drivers/w1/w1_family.h
===================================================================
--- dtor.orig/drivers/w1/w1_family.h
+++ dtor/drivers/w1/w1_family.h
@@ -22,35 +22,7 @@
 #ifndef __W1_FAMILY_H
 #define __W1_FAMILY_H
 
-#include <linux/types.h>
-#include <linux/device.h>
-#include <asm/atomic.h>
-
 #define W1_FAMILY_SERIAL_NUM	0x01
 #define W1_FAMILY_THERMAL	0x10
 
-struct w1_slave;
-
-struct w1_family
-{
-	struct list_head	family_entry;
-	u8			fid;
-	atomic_t		refcnt;
-	u8			need_exit;
-
-	int (*join)(struct w1_slave *);
-	void (*leave)(struct w1_slave *);
-};
-
-extern spinlock_t w1_flock;
-
-void w1_family_get(struct w1_family *);
-void w1_family_put(struct w1_family *);
-void __w1_family_get(struct w1_family *);
-void __w1_family_put(struct w1_family *);
-struct w1_family * w1_family_registered(u8);
-int w1_family_join(struct w1_slave *);
-void w1_family_leave(struct w1_slave *);
-void w1_unregister_family(struct w1_family *);
-int w1_register_family(struct w1_family *);
 #endif /* __W1_FAMILY_H */
Index: dtor/drivers/w1/w1_family.c
===================================================================
--- dtor.orig/drivers/w1/w1_family.c
+++ /dev/null
@@ -1,165 +0,0 @@
-/*
- *	w1_family.c
- *
- * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#include <linux/spinlock.h>
-#include <linux/list.h>
-#include <linux/delay.h>
-
-#include "w1.h"
-#include "w1_family.h"
-
-DEFINE_SPINLOCK(w1_flock);
-static LIST_HEAD(w1_families);
-
-int w1_register_family(struct w1_family *newf)
-{
-	struct list_head *ent, *n;
-	struct w1_family *f;
-	int ret = 0;
-
-	spin_lock(&w1_flock);
-	list_for_each_safe(ent, n, &w1_families) {
-		f = list_entry(ent, struct w1_family, family_entry);
-
-		if (f->fid == newf->fid) {
-			ret = -EEXIST;
-			break;
-		}
-	}
-
-	if (!ret) {
-		atomic_set(&newf->refcnt, 0);
-		newf->need_exit = 0;
-		list_add_tail(&newf->family_entry, &w1_families);
-	}
-
-	spin_unlock(&w1_flock);
-
-	return ret;
-}
-
-void w1_unregister_family(struct w1_family *fent)
-{
-	struct list_head *ent, *n;
-	struct w1_family *f;
-
-	spin_lock(&w1_flock);
-	list_for_each_safe(ent, n, &w1_families) {
-		f = list_entry(ent, struct w1_family, family_entry);
-
-		if (f->fid == fent->fid) {
-			list_del(&fent->family_entry);
-			break;
-		}
-	}
-
-	fent->need_exit = 1;
-
-	spin_unlock(&w1_flock);
-
-	while (atomic_read(&fent->refcnt)) {
-		printk(KERN_INFO "Waiting for family %u to become free: refcnt=%d.\n",
-				fent->fid, atomic_read(&fent->refcnt));
-
-		if (msleep_interruptible(1000))
-			flush_signals(current);
-	}
-}
-
-/*
- * Should be called under w1_flock held.
- */
-struct w1_family * w1_family_registered(u8 fid)
-{
-	struct list_head *ent, *n;
-	struct w1_family *f = NULL;
-	int ret = 0;
-
-	list_for_each_safe(ent, n, &w1_families) {
-		f = list_entry(ent, struct w1_family, family_entry);
-
-		if (f->fid == fid) {
-			ret = 1;
-			break;
-		}
-	}
-
-	return (ret) ? f : NULL;
-}
-
-int w1_family_join(struct w1_slave *slave)
-{
-	int retval;
-
-	retval = down_interruptible(&slave->mutex);
-	if (retval)
-		return retval;
-
-	if (slave->family->join)
-		retval = slave->family->join(slave);
-
-	up(&slave->mutex);
-	return retval;
-}
-
-void w1_family_leave(struct w1_slave *slave)
-{
-	down(&slave->mutex);
-
-	if (slave->family->leave)
-		slave->family->leave(slave);
-
-	up(&slave->mutex);
-}
-
-void w1_family_put(struct w1_family *f)
-{
-	spin_lock(&w1_flock);
-	__w1_family_put(f);
-	spin_unlock(&w1_flock);
-}
-
-void __w1_family_put(struct w1_family *f)
-{
-	if (atomic_dec_and_test(&f->refcnt))
-		f->need_exit = 1;
-}
-
-void w1_family_get(struct w1_family *f)
-{
-	spin_lock(&w1_flock);
-	__w1_family_get(f);
-	spin_unlock(&w1_flock);
-
-}
-
-void __w1_family_get(struct w1_family *f)
-{
-	smp_mb__before_atomic_inc();
-	atomic_inc(&f->refcnt);
-	smp_mb__after_atomic_inc();
-}
-
-EXPORT_SYMBOL(w1_family_get);
-EXPORT_SYMBOL(w1_family_put);
-EXPORT_SYMBOL(w1_family_registered);
-EXPORT_SYMBOL(w1_unregister_family);
-EXPORT_SYMBOL(w1_register_family);
