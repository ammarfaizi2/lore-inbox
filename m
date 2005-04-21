Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVDUIZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVDUIZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 04:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVDUIXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 04:23:54 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:62647 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261458AbVDUHaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:23 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 18/22] W1: cleanup family implementation
Date: Thu, 21 Apr 2005 02:25:05 -0500
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
Message-Id: <200504210225.06313.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1: clean-up family implementation:
    - get rid of w1_family_ops and template attributes in w1_slave
      structure and have family drivers create necessary attributes
      themselves. There are too many different devices using 1-Wire
      interface and it is impossible to fit them all into single
      attribute model. If interface unification is needed it can be
      done by building cross-bus class hierarchy.
    - rename w1_smem to w1_sernum because devices are called Silicon
      serial numbers, they have address (ID) but don't have memory
      in regular sense.
    - rename w1_therm to w1_thermal.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/w1/w1_smem.c         |  103 -----------------------
 drivers/w1/w1_therm.c        |  188 -------------------------------------------
 dtor/drivers/w1/Kconfig      |   13 +-
 dtor/drivers/w1/Makefile     |    4 
 dtor/drivers/w1/w1.c         |  148 +++++++++------------------------
 dtor/drivers/w1/w1.h         |    5 -
 dtor/drivers/w1/w1_family.c  |   37 +++++---
 dtor/drivers/w1/w1_family.h  |   23 +----
 dtor/drivers/w1/w1_sernum.c  |   58 +++++++++++++
 dtor/drivers/w1/w1_thermal.c |  173 +++++++++++++++++++++++++++++++++++++++
 10 files changed, 317 insertions(+), 435 deletions(-)

Index: dtor/drivers/w1/w1_therm.c
===================================================================
--- dtor.orig/drivers/w1/w1_therm.c
+++ /dev/null
@@ -1,188 +0,0 @@
-/*
- *	w1_therm.c
- *
- * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the therms of the GNU General Public License as published by
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
-#include <asm/types.h>
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/device.h>
-#include <linux/types.h>
-#include <linux/delay.h>
-
-#include "w1.h"
-#include "w1_io.h"
-#include "w1_family.h"
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
-MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol, temperature family.");
-
-static u8 bad_roms[][9] = {
-				{0xaa, 0x00, 0x4b, 0x46, 0xff, 0xff, 0x0c, 0x10, 0x87},
-				{}
-			};
-
-static ssize_t w1_therm_read_temp(struct device *, char *);
-static ssize_t w1_therm_read_bin(struct kobject *, char *, loff_t, size_t);
-
-static struct w1_family_ops w1_therm_fops = {
-	.rbin = &w1_therm_read_bin,
-	.rval = &w1_therm_read_temp,
-	.rvalname = "temp1_input",
-};
-
-static inline int w1_convert_temp(u8 rom[9])
-{
-	int t, h;
-
-	if (rom[1] == 0)
-		t = ((s32)rom[0] >> 1)*1000;
-	else
-		t = 1000*(-1*(s32)(0x100-rom[0]) >> 1);
-
-	t -= 250;
-	h = 1000*((s32)rom[7] - (s32)rom[6]);
-	h /= (s32)rom[7];
-	t += h;
-
-	return t;
-}
-
-static ssize_t w1_therm_read_temp(struct device *dev, char *buf)
-{
-	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
-
-	return sprintf(buf, "%d\n", w1_convert_temp(sl->rom));
-}
-
-static int w1_therm_check_rom(u8 rom[9])
-{
-	int i;
-
-	for (i=0; i<sizeof(bad_roms)/9; ++i)
-		if (!memcmp(bad_roms[i], rom, 9))
-			return 1;
-
-	return 0;
-}
-
-static ssize_t w1_therm_read_bin(struct kobject *kobj, char *buf, loff_t off, size_t count)
-{
-	struct w1_slave *sl = container_of(container_of(kobj, struct device, kobj),
-					   struct w1_slave, dev);
-	struct w1_master *dev = sl->master;
-	u8 rom[9], crc, verdict;
-	int i, max_trying = 10;
-
-	if (down_interruptible(&sl->master->mutex))
-		return 0;
-
-	if (off > W1_SLAVE_DATA_SIZE) {
-		count = 0;
-		goto out;
-	}
-	if (off + count > W1_SLAVE_DATA_SIZE) {
-		count = 0;
-		goto out;
-	}
-
-	memset(buf, 0, count);
-	memset(rom, 0, sizeof(rom));
-
-	count = 0;
-	verdict = 0;
-	crc = 0;
-
-	while (max_trying--) {
-		if (!w1_reset_bus (dev)) {
-			int count = 0;
-			u8 match[9] = {W1_MATCH_ROM, };
-			unsigned int tm = 750;
-
-			memcpy(&match[1], (u64 *) & sl->reg_num, 8);
-
-			w1_write_block(dev, match, 9);
-
-			w1_write_8(dev, W1_CONVERT_TEMP);
-
-			while (tm) {
-				tm = msleep_interruptible(tm);
-				if (signal_pending(current))
-					flush_signals(current);
-			}
-
-			if (!w1_reset_bus (dev)) {
-				w1_write_block(dev, match, 9);
-
-				w1_write_8(dev, W1_READ_SCRATCHPAD);
-				if ((count = w1_read_block(dev, rom, 9)) != 9) {
-					dev_warn(&dev->dev, "w1_read_block() returned %d instead of 9.\n", count);
-				}
-
-				crc = w1_calc_crc8(rom, 8);
-
-				if (rom[8] == crc && rom[0])
-					verdict = 1;
-
-			}
-		}
-
-		if (!w1_therm_check_rom(rom))
-			break;
-	}
-
-	for (i = 0; i < 9; ++i)
-		count += sprintf(buf + count, "%02x ", rom[i]);
-	count += sprintf(buf + count, ": crc=%02x %s\n",
-			   crc, (verdict) ? "YES" : "NO");
-	if (verdict)
-		memcpy(sl->rom, rom, sizeof(sl->rom));
-	else
-		dev_warn(&dev->dev, "18S20 doesn't respond to CONVERT_TEMP.\n");
-
-	for (i = 0; i < 9; ++i)
-		count += sprintf(buf + count, "%02x ", sl->rom[i]);
-
-	count += sprintf(buf + count, "t=%d\n", w1_convert_temp(rom));
-out:
-	up(&dev->mutex);
-
-	return count;
-}
-
-static struct w1_family w1_therm_family = {
-	.fid = W1_FAMILY_THERM,
-	.fops = &w1_therm_fops,
-};
-
-static int __init w1_therm_init(void)
-{
-	return w1_register_family(&w1_therm_family);
-}
-
-static void __exit w1_therm_fini(void)
-{
-	w1_unregister_family(&w1_therm_family);
-}
-
-module_init(w1_therm_init);
-module_exit(w1_therm_fini);
Index: dtor/drivers/w1/w1_smem.c
===================================================================
--- dtor.orig/drivers/w1/w1_smem.c
+++ /dev/null
@@ -1,103 +0,0 @@
-/*
- *	w1_smem.c
- *
- * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the smems of the GNU General Public License as published by
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
-#include <asm/types.h>
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/device.h>
-#include <linux/types.h>
-
-#include "w1.h"
-#include "w1_io.h"
-#include "w1_family.h"
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
-MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol, 64bit memory family.");
-
-static ssize_t w1_smem_read_val(struct device *, char *);
-static ssize_t w1_smem_read_bin(struct kobject *, char *, loff_t, size_t);
-
-static struct w1_family_ops w1_smem_fops = {
-	.rbin = &w1_smem_read_bin,
-	.rval = &w1_smem_read_val,
-	.rvalname = "id",
-};
-
-static ssize_t w1_smem_read_val(struct device *dev, char *buf)
-{
-	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
-	int i;
-	ssize_t count = 0;
-
-	for (i = 0; i < 9; ++i)
-		count += sprintf(buf + count, "%02x ", ((u8 *)&sl->reg_num)[i]);
-	count += sprintf(buf + count, "\n");
-
-	return count;
-}
-
-static ssize_t w1_smem_read_bin(struct kobject *kobj, char *buf, loff_t off, size_t count)
-{
-	struct w1_slave *sl = container_of(container_of(kobj, struct device, kobj),
-					   struct w1_slave, dev);
-	int i;
-
-	if (down_interruptible(&sl->master->mutex))
-		return 0;
-
-	if (off > W1_SLAVE_DATA_SIZE) {
-		count = 0;
-		goto out;
-	}
-	if (off + count > W1_SLAVE_DATA_SIZE) {
-		count = 0;
-		goto out;
-	}
-	for (i = 0; i < 9; ++i)
-		count += sprintf(buf + count, "%02x ", ((u8 *)&sl->reg_num)[i]);
-	count += sprintf(buf + count, "\n");
-
-out:
-	up(&sl->master->mutex);
-
-	return count;
-}
-
-static struct w1_family w1_smem_family = {
-	.fid = W1_FAMILY_SMEM,
-	.fops = &w1_smem_fops,
-};
-
-static int __init w1_smem_init(void)
-{
-	return w1_register_family(&w1_smem_family);
-}
-
-static void __exit w1_smem_fini(void)
-{
-	w1_unregister_family(&w1_smem_family);
-}
-
-module_init(w1_smem_init);
-module_exit(w1_smem_fini);
Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -2,6 +2,7 @@
  *	w1.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * Copyright (c) 2005 Dmitry Torokhov <dtor@mail.ru>
  *
  *
  * This program is free software; you can redistribute it and/or modify
@@ -97,30 +98,6 @@ static struct attribute_group w1_slave_d
 	.attrs = w1_slave_default_attrs,
 };
 
-static ssize_t w1_default_read_name(struct device *dev, char *buf)
-{
-	return sprintf(buf, "No family registered.\n");
-}
-
-static ssize_t w1_default_read_bin(struct kobject *kobj, char *buf, loff_t off,
-		     size_t count)
-{
-	return sprintf(buf, "No family registered.\n");
-}
-
-static struct device_attribute w1_slave_attribute_val =
-	__ATTR(value, S_IRUGO, w1_default_read_name, NULL);
-
-static struct bin_attribute w1_slave_bin_attribute = {
-	.attr = {
-		.name = "w1_slave",
-		.mode = S_IRUGO,
-		.owner = THIS_MODULE,
-	},
-	.size = W1_SLAVE_DATA_SIZE,
-	.read = &w1_default_read_bin,
-};
-
 static void w1_slave_release(struct device *dev)
 {
 	struct w1_slave *slave = to_w1_slave(dev);
@@ -130,79 +107,10 @@ static void w1_slave_release(struct devi
 	module_put(THIS_MODULE);
 }
 
-static int __w1_attach_slave_device(struct w1_slave *slave)
-{
-	int err;
-
-	slave->dev.parent = &slave->master->dev;
-	slave->dev.bus = &w1_bus_type;
-	slave->dev.release = &w1_slave_release;
-
-	snprintf(&slave->dev.bus_id[0], sizeof(slave->dev.bus_id),
-		  "%02x-%012llx",
-		  (unsigned int) slave->reg_num.family,
-		  (unsigned long long) slave->reg_num.id);
-
-	dev_dbg(&slave->dev, "%s: registering %s.\n", __func__,
-		&slave->dev.bus_id[0]);
-
-	err = device_register(&slave->dev);
-	if (err < 0) {
-		dev_err(&slave->dev,
-			 "Device registration [%s] failed. err=%d\n",
-			 slave->dev.bus_id, err);
-		return err;
-	}
-
-	__module_get(THIS_MODULE);
-
-	memcpy(&slave->attr_bin, &w1_slave_bin_attribute, sizeof(slave->attr_bin));
-	memcpy(&slave->attr_val, &w1_slave_attribute_val, sizeof(slave->attr_val));
-
-	slave->attr_bin.read = slave->family->fops->rbin;
-	slave->attr_val.show = slave->family->fops->rval;
-	slave->attr_val.attr.name = slave->family->fops->rvalname;
-
-	err = device_create_file(&slave->dev, &slave->attr_val);
-	if (err < 0) {
-		dev_err(&slave->dev,
-			 "sysfs file creation for [%s] failed. err=%d\n",
-			 slave->dev.bus_id, err);
-		device_unregister(&slave->dev);
-		return err;
-	}
-
-	err = sysfs_create_bin_file(&slave->dev.kobj, &slave->attr_bin);
-	if (err < 0) {
-		dev_err(&slave->dev,
-			 "sysfs file creation for [%s] failed. err=%d\n",
-			 slave->dev.bus_id, err);
-		device_remove_file(&slave->dev, &slave->attr_val);
-		device_unregister(&slave->dev);
-		return err;
-	}
-
-	err = sysfs_create_group(&slave->dev.kobj, &w1_slave_defattr_group);
-	if (err < 0) {
-		dev_err(&slave->dev,
-			 "sysfs group creation for [%s] failed. err=%d\n",
-			 slave->dev.bus_id, err);
-		sysfs_remove_bin_file(&slave->dev.kobj, &slave->attr_bin);
-		device_remove_file(&slave->dev, &slave->attr_val);
-		device_unregister(&slave->dev);
-		return err;
-	}
-
-	list_add_tail(&slave->node, &slave->master->slist);
-
-	return 0;
-}
-
 static int w1_attach_slave_device(struct w1_master *master, struct w1_reg_num *rn)
 {
 	struct w1_slave *slave;
-	struct w1_family *f;
-	int err;
+	int error;
 
 	slave = kcalloc(1, sizeof(struct w1_slave), GFP_KERNEL);
 	if (!slave) {
@@ -212,13 +120,16 @@ static int w1_attach_slave_device(struct
 		return -ENOMEM;
 	}
 
+	init_MUTEX(&slave->mutex);
+	INIT_LIST_HEAD(&slave->node);
 	slave->master = master;
 	slave->reg_num = *rn;
 	set_bit(W1_SLAVE_ACTIVE, &slave->flags);
+	slave->ttl = master->slave_ttl;
 
 	spin_lock(&w1_flock);
-	f = w1_family_registered(rn->family);
-	if (!f) {
+	slave->family = w1_family_registered(rn->family);
+	if (!slave->family) {
 		spin_unlock(&w1_flock);
 		dev_info(&master->dev,
 			 "Family %x for %02x.%012llx.%02x is not registered.\n",
@@ -227,21 +138,45 @@ static int w1_attach_slave_device(struct
 		kfree(slave);
 		return -ENODEV;
 	}
-	__w1_family_get(f);
+	__w1_family_get(slave->family);
 	spin_unlock(&w1_flock);
 
-	slave->family = f;
+	slave->dev.parent = &slave->master->dev;
+	slave->dev.bus = &w1_bus_type;
+	slave->dev.release = &w1_slave_release;
+
+	snprintf(&slave->dev.bus_id[0], sizeof(slave->dev.bus_id),
+		  "%02x-%012llx",
+		  (unsigned int) slave->reg_num.family,
+		  (unsigned long long) slave->reg_num.id);
+
+	dev_dbg(&slave->dev, "%s: registering %s.\n", __func__,
+		&slave->dev.bus_id[0]);
 
-	err = __w1_attach_slave_device(slave);
-	if (err < 0) {
-		dev_err(&master->dev, "%s: Attaching %s failed.\n", __func__,
-			slave->dev.bus_id);
+	error = device_register(&slave->dev);
+	if (error < 0) {
+		dev_err(&slave->dev,
+			 "Device registration [%s] failed. err=%d\n",
+			 slave->dev.bus_id, error);
 		w1_family_put(slave->family);
 		kfree(slave);
-		return err;
+		return error;
 	}
 
-	slave->ttl = master->slave_ttl;
+	__module_get(THIS_MODULE);
+
+	error = sysfs_create_group(&slave->dev.kobj, &w1_slave_defattr_group);
+	if (error < 0) {
+		dev_err(&slave->dev,
+			 "sysfs group creation for [%s] failed. err=%d\n",
+			 slave->dev.bus_id, error);
+		device_unregister(&slave->dev);
+		return error;
+	}
+
+	w1_family_join(slave);	/* assume it always succeeds for now */
+
+	list_add_tail(&slave->node, &slave->master->slist);
 
 	return 0;
 }
@@ -251,9 +186,8 @@ static void w1_slave_detach(struct w1_sl
 	dev_info(&slave->dev, "%s: detaching %s.\n",
 		 __func__, slave->dev.bus_id);
 
+	w1_family_leave(slave);
 	sysfs_remove_group(&slave->dev.kobj, &w1_slave_defattr_group);
-	sysfs_remove_bin_file(&slave->dev.kobj, &slave->attr_bin);
-	device_remove_file(&slave->dev, &slave->attr_val);
 	device_unregister(&slave->dev);
 }
 
@@ -519,10 +453,12 @@ void w1_remove_master_device(struct w1_m
 
 	w1_stop_master_device(master);
 
+	down(&master->mutex);
 	list_for_each_entry_safe(slave, next, &master->slist, node) {
 		list_del(&slave->node);
 		w1_slave_detach(slave);
 	}
+	up(&master->mutex);
 
 	sysfs_remove_group(&master->dev.kobj, &w1_master_defattr_group);
 	device_unregister(&master->dev);
Index: dtor/drivers/w1/w1.h
===================================================================
--- dtor.orig/drivers/w1/w1.h
+++ dtor/drivers/w1/w1.h
@@ -47,7 +47,6 @@ struct w1_reg_num
 #include "w1_family.h"
 
 #define W1_MAXNAMELEN		32
-#define W1_SLAVE_DATA_SIZE	128
 
 #define W1_SEARCH		0xF0
 #define W1_CONDITIONAL_SEARCH	0xEC
@@ -71,9 +70,7 @@ struct w1_slave
 	struct w1_master	*master;
 	struct w1_family	*family;
 	struct device		dev;
-
-	struct bin_attribute	attr_bin;
-	struct device_attribute	attr_name, attr_val;
+	struct semaphore	mutex;
 };
 #define to_w1_slave(dev)	container_of((dev), struct w1_slave, dev)
 
Index: dtor/drivers/w1/w1_thermal.c
===================================================================
--- /dev/null
+++ dtor/drivers/w1/w1_thermal.c
@@ -0,0 +1,173 @@
+/*
+ *	w1_thermal.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * Copyright (c) 2005 Dmitry Torokhov <dtor@mail.ru>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the therms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+
+#include "w1.h"
+#include "w1_io.h"
+#include "w1_family.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("1-Wire Digital Thermometer");
+
+static ssize_t w1_thermal_show_temp(struct device *, char *);
+
+static struct device_attribute w1_thermal_temperature_attr =
+	__ATTR(temp, S_IRUGO, w1_thermal_show_temp, NULL);
+
+static int w1_thermal_join(struct w1_slave *slave)
+{
+	return device_create_file(&slave->dev, &w1_thermal_temperature_attr);
+}
+
+static void w1_thermal_leave(struct w1_slave *slave)
+{
+	device_remove_file(&slave->dev, &w1_thermal_temperature_attr);
+}
+
+static struct w1_family w1_thermal_family = {
+	.fid		= W1_FAMILY_THERMAL,
+	.join		= w1_thermal_join,
+	.leave		= w1_thermal_leave,
+};
+
+static u8 bad_roms[][9] = {
+	{ 0xaa, 0x00, 0x4b, 0x46, 0xff, 0xff, 0x0c, 0x10, 0x87 },
+	{ }
+};
+
+static inline int w1_convert_temp(u8 rom[9])
+{
+	int t, h;
+
+	if (rom[1] == 0)
+		t = ((s32)rom[0] >> 1) * 1000;
+	else
+		t = 1000 * (-1 * (s32)(0x100 - rom[0]) >> 1);
+
+	t -= 250;
+	h = 1000 * ((s32)rom[7] - (s32)rom[6]);
+	h /= (s32)rom[7];
+	t += h;
+
+	return t;
+}
+
+static int w1_therm_check_rom(u8 rom[9])
+{
+	int i;
+
+	for (i = 0; i < sizeof(bad_roms) / 9; i++)
+		if (!memcmp(bad_roms[i], rom, 9))
+			return 1;
+
+	return 0;
+}
+
+static int w1_thermal_read_data(struct w1_slave *slave, u8 data[])
+{
+	struct w1_master *dev = slave->master;
+	u8 match[9] = { W1_MATCH_ROM, };
+	u8 crc;
+	int count;
+	int error;
+
+	memset(data, 0, 9);
+
+	error = w1_reset_bus(dev);
+	if (error)
+		return error;
+
+	memcpy(&match[1], (u64 *)&slave->reg_num, sizeof(u64));
+
+	w1_write_block(dev, match, 9);
+	w1_write_8(dev, W1_CONVERT_TEMP);
+	msleep(750);
+
+	error = w1_reset_bus(dev);
+	if (error)
+		return error;
+
+	w1_write_block(dev, match, 9);
+	w1_write_8(dev, W1_READ_SCRATCHPAD);
+	if ((count = w1_read_block(dev, data, 9)) != 9)
+		dev_warn(&dev->dev, "w1_read_block() returned %d instead of 9.\n", count);
+
+	crc = w1_calc_crc8(data, 8);
+	if (data[8] != crc || !data[0] || w1_therm_check_rom(data))
+		return -EIO;
+
+	return 0;
+}
+
+static ssize_t w1_thermal_show_temp(struct device *dev, char *buf)
+{
+	struct w1_slave *slave = to_w1_slave(dev);
+	int attempts = 10;
+	u8 data[9];
+	int error;
+	ssize_t count = 0;
+
+	error = down_interruptible(&slave->master->mutex);
+	if (error)
+		return error;
+
+	error = down_interruptible(&slave->mutex);
+	if (error)
+		goto out;
+
+	if (slave->family != &w1_thermal_family) {
+		error = -ENODEV;
+		goto out;
+	}
+
+	do {
+		error = w1_thermal_read_data(slave, data);
+		if (!error)
+			count = sprintf(buf, "%d\n", w1_convert_temp(data));
+
+	} while (error && attempts-- > 0);
+
+	up(&slave->mutex);
+out:
+	up(&slave->master->mutex);
+	return error ? error : count;
+}
+
+static int __init w1_thermal_init(void)
+{
+	return w1_register_family(&w1_thermal_family);
+}
+
+static void __exit w1_thermal_exit(void)
+{
+	w1_unregister_family(&w1_thermal_family);
+}
+
+module_init(w1_thermal_init);
+module_exit(w1_thermal_exit);
Index: dtor/drivers/w1/Makefile
===================================================================
--- dtor.orig/drivers/w1/Makefile
+++ dtor/drivers/w1/Makefile
@@ -10,8 +10,8 @@ obj-$(CONFIG_W1)	+= wire.o
 wire-objs		:= w1.o w1_family.o w1_io.o
 
 obj-$(CONFIG_W1_MATROX)		+= matrox_w1.o
-obj-$(CONFIG_W1_THERM)		+= w1_therm.o
-obj-$(CONFIG_W1_SMEM)		+= w1_smem.o
+obj-$(CONFIG_W1_THERMAL)	+= w1_thermal.o
+obj-$(CONFIG_W1_SERNUM)		+= w1_sernum.o
 
 obj-$(CONFIG_W1_DS9490)		+= ds9490r.o
 ds9490r-objs    := dscore.o
Index: dtor/drivers/w1/w1_sernum.c
===================================================================
--- /dev/null
+++ dtor/drivers/w1/w1_sernum.c
@@ -0,0 +1,58 @@
+/*
+ *	w1_sernum.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * Copyright (c) 2005 Dmitry Torokhov <dtor@mail.ru>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the smems of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/types.h>
+
+#include "w1.h"
+#include "w1_family.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("1-Wire Silicon Serial Number Driver");
+
+/*
+ * This is a very dumb device. It just has an unique ID and
+ * sits on the bus doing nothing. So the driver does not do
+ * anything fancy either; access to device's ID is provided
+ * by W1 core.
+ */
+
+static struct w1_family w1_serial_num_family = {
+	.fid		= W1_FAMILY_SERIAL_NUM,
+};
+
+static int __init w1_serial_num_init(void)
+{
+	return w1_register_family(&w1_serial_num_family);
+}
+
+static void __exit w1_serial_num_exit(void)
+{
+	w1_unregister_family(&w1_serial_num_family);
+}
+
+module_init(w1_serial_num_init);
+module_exit(w1_serial_num_exit);
Index: dtor/drivers/w1/Kconfig
===================================================================
--- dtor.orig/drivers/w1/Kconfig
+++ dtor/drivers/w1/Kconfig
@@ -40,18 +40,19 @@ config W1_DS9490_BRIDGE
 	  This support is also available as a module.  If so, the module
 	  will be called ds_w1_bridge.ko.
 
-config W1_THERM
-	tristate "Thermal family implementation"
+config W1_THERMAL
+	tristate "Thermal sensor devices"
 	depends on W1
 	help
-	  Say Y here if you want to connect 1-wire thermal sensors to you
+	  Say Y here if you want to connect 1-wire thermal sensors to your
 	  wire.
 
-config W1_SMEM
-	tristate "Simple 64bit memory family implementation"
+config W1_SERNUM
+	tristate "Silicon Serial Number devices"
 	depends on W1
 	help
 	  Say Y here if you want to connect 1-wire
-	  simple 64bit memory rom(ds2401/ds2411/ds1990*) to you wire.
+	  simple addressable devices (Silicon Serial Nnumbers -
+	  ds2401/ds2411/ds1990*) to your wire.
 
 endmenu
Index: dtor/drivers/w1/w1_family.c
===================================================================
--- dtor.orig/drivers/w1/w1_family.c
+++ dtor/drivers/w1/w1_family.c
@@ -23,28 +23,18 @@
 #include <linux/list.h>
 #include <linux/delay.h>
 
+#include "w1.h"
 #include "w1_family.h"
 
 DEFINE_SPINLOCK(w1_flock);
 static LIST_HEAD(w1_families);
 
-static int w1_check_family(struct w1_family *f)
-{
-	if (!f->fops->rbin || !f->fops->rval || !f->fops->rvalname)
-		return -EINVAL;
-
-	return 0;
-}
-
 int w1_register_family(struct w1_family *newf)
 {
 	struct list_head *ent, *n;
 	struct w1_family *f;
 	int ret = 0;
 
-	if (w1_check_family(newf))
-		return -EINVAL;
-
 	spin_lock(&w1_flock);
 	list_for_each_safe(ent, n, &w1_families) {
 		f = list_entry(ent, struct w1_family, family_entry);
@@ -115,6 +105,31 @@ struct w1_family * w1_family_registered(
 	return (ret) ? f : NULL;
 }
 
+int w1_family_join(struct w1_slave *slave)
+{
+	int retval;
+
+	retval = down_interruptible(&slave->mutex);
+	if (retval)
+		return retval;
+
+	if (slave->family->join)
+		retval = slave->family->join(slave);
+
+	up(&slave->mutex);
+	return retval;
+}
+
+void w1_family_leave(struct w1_slave *slave)
+{
+	down(&slave->mutex);
+
+	if (slave->family->leave)
+		slave->family->leave(slave);
+
+	up(&slave->mutex);
+}
+
 void w1_family_put(struct w1_family *f)
 {
 	spin_lock(&w1_flock);
Index: dtor/drivers/w1/w1_family.h
===================================================================
--- dtor.orig/drivers/w1/w1_family.h
+++ dtor/drivers/w1/w1_family.h
@@ -26,28 +26,20 @@
 #include <linux/device.h>
 #include <asm/atomic.h>
 
-#define W1_FAMILY_DEFAULT	0
-#define W1_FAMILY_THERM		0x10
-#define W1_FAMILY_SMEM		0x01
+#define W1_FAMILY_SERIAL_NUM	0x01
+#define W1_FAMILY_THERMAL	0x10
 
-#define MAXNAMELEN		32
-
-struct w1_family_ops
-{
-	ssize_t (* rbin)(struct kobject *, char *, loff_t, size_t);
-	ssize_t (* rval)(struct device *, char *);
-	unsigned char rvalname[MAXNAMELEN];
-};
+struct w1_slave;
 
 struct w1_family
 {
 	struct list_head	family_entry;
 	u8			fid;
-
-	struct w1_family_ops	*fops;
-
 	atomic_t		refcnt;
 	u8			need_exit;
+
+	int (*join)(struct w1_slave *);
+	void (*leave)(struct w1_slave *);
 };
 
 extern spinlock_t w1_flock;
@@ -57,7 +49,8 @@ void w1_family_put(struct w1_family *);
 void __w1_family_get(struct w1_family *);
 void __w1_family_put(struct w1_family *);
 struct w1_family * w1_family_registered(u8);
+int w1_family_join(struct w1_slave *);
+void w1_family_leave(struct w1_slave *);
 void w1_unregister_family(struct w1_family *);
 int w1_register_family(struct w1_family *);
-
 #endif /* __W1_FAMILY_H */
