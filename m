Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWGBW0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWGBW0z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 18:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWGBW0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 18:26:55 -0400
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:40988 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1751008AbWGBW0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 18:26:54 -0400
Date: Mon, 3 Jul 2006 00:26:49 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: linux-kernel@vger.kernel.org
Cc: lm-sensors@lm-sensors.org, khali@linux-fr.org,
       linux-kernel@killerfox.forkbomb.ch, benh@kernel.crashing.org,
       johannes@sipsolutions.net, stelian@popies.net, chainsaw@gentoo.org
Subject: [RFC] Apple Motion Sensor driver
Message-ID: <20060702222649.GA13411@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Below you find the latest revision of my AMS driver. AMS stands for
Apple Motion Sensor and it's included in the 2005 revisions of Apple
iBooks and PowerBooks. The driver implements the PMU and I2C variants.
MacBooks have another variant, which is not handled by this driver,
mainly because it's totally different and I don't have access to a
MacBook.

Some of the code is based on the I2C ams driver from Stelian Pop, whom
I'd like to thank for his work.

HD parking is marked BROKEN as of now, because it'll need changes to the
block, IDE and SCSI layers. The infrastructure works, tough (tested with
my own HD parking code). That's why I left it in there.

I want this driver to be included in -mm as soon as possible, to get
test feedback and to get it included in 2.6.19 (or maybe 2.6.18? Who
knows. ;)). Thus I'd like to get your comments, suggestions, etc. on it.

Thanks for your feedback,
Michael

---
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17-git20.orig/drivers/hwmon/ams-core.c linux-2.6.17-git20/drivers/hwmon/ams-core.c
--- linux-2.6.17-git20.orig/drivers/hwmon/ams-core.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-git20/drivers/hwmon/ams-core.c	2006-07-02 22:19:31.000000000 +0200
@@ -0,0 +1,264 @@
+/*
+ * Apple Motion Sensor driver
+ *
+ * Copyright (C) 2005 Stelian Pop (stelian@popies.net)
+ * Copyright (C) 2006 Michael Hanselmann (linux-kernel@hansmi.ch)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <asm/pmac_pfunc.h>
+
+#include "ams.h"
+
+/* There is only one motion sensor per machine */
+struct ams ams;
+
+static unsigned int verbose;
+module_param(verbose, bool, 0);
+MODULE_PARM_DESC(verbose, "Show free falls and shocks in kernel output");
+
+/* Call with lock held! */
+void ams_sensors(s8 *x, s8 *y, s8 *z)
+{
+	s8 tmpx, tmpy, tmpz;
+	u32 orient;
+
+	orient = ams.vflag? ams.orient1 : ams.orient2;
+
+	if (orient & 0x80)
+		/* X and Y swapped */
+		ams.get_xyz(&tmpy, &tmpx, &tmpz);
+	else
+		ams.get_xyz(&tmpx, &tmpy, &tmpz);
+
+	if (orient & 0x04)
+		tmpz = ~tmpz;
+	if (orient & 0x02)
+		tmpy = ~tmpy;
+	if (orient & 0x01)
+		tmpx = ~tmpx;
+
+	if (x)
+		*x = tmpx;
+	if (y)
+		*y = tmpy;
+	if (z)
+		*z = tmpz;
+}
+
+static ssize_t ams_show_xyz(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	s8 x, y, z;
+
+	mutex_lock(&ams.lock);
+	ams_sensors(&x, &y, &z);
+	mutex_unlock(&ams.lock);
+
+	return snprintf(buf, PAGE_SIZE, "%d %d %d\n", x, y, z);
+}
+
+static DEVICE_ATTR(xyz, S_IRUGO, ams_show_xyz, NULL);
+
+static void ams_handle_irq(void *data)
+{
+	enum ams_irq irq = *((enum ams_irq *)data);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ams.irq_lock, flags);
+
+	ams.worker_irqs |= irq;
+	schedule_work(&ams.worker);
+
+	spin_unlock_irqrestore(&ams.irq_lock, flags);
+}
+
+static enum ams_irq ams_freefall_irq_data = AMS_IRQ_FREEFALL;
+static struct pmf_irq_client ams_freefall_client = {
+	.owner = THIS_MODULE,
+	.handler = ams_handle_irq,
+	.data = &ams_freefall_irq_data,
+};
+
+static enum ams_irq ams_shock_irq_data = AMS_IRQ_SHOCK;
+static struct pmf_irq_client ams_shock_client = {
+	.owner = THIS_MODULE,
+	.handler = ams_handle_irq,
+	.data = &ams_shock_irq_data,
+};
+
+static void ams_worker(void *data)
+{
+	mutex_lock(&ams.lock);
+
+	if (ams.has_device) {
+		int do_park = 0;
+
+		if (ams.worker_irqs & AMS_IRQ_FREEFALL) {
+			if (verbose)
+				printk(KERN_INFO "ams: freefall detected!\n");
+
+			ams.worker_irqs &= ~AMS_IRQ_FREEFALL;
+			ams.clear_irq(AMS_IRQ_FREEFALL);
+
+			do_park = 1;
+		}
+
+		if (ams.worker_irqs & AMS_IRQ_SHOCK) {
+			if (verbose)
+				printk(KERN_INFO "ams: shock detected!\n");
+
+			ams.worker_irqs &= ~AMS_IRQ_SHOCK;
+			ams.clear_irq(AMS_IRQ_SHOCK);
+
+			do_park = 1;
+		}
+
+		if (do_park)
+			ams_hdpark();
+	}
+
+	mutex_unlock(&ams.lock);
+}
+
+/* Call with lock held! */
+int ams_sensor_attach(void)
+{
+	int result;
+	u32 *prop;
+
+	/* Get orientation */
+	prop = (u32*)get_property(ams.of_node, "orientation", NULL);
+	if (!prop)
+		return -ENODEV;
+	ams.orient1 = *prop;
+	ams.orient2 = *(prop + 1);
+
+	/* Register freefall interrupt handler */
+	result = pmf_register_irq_client(ams.of_node,
+			"accel-int-1",
+			&ams_freefall_client);
+	if (result < 0)
+		return -ENODEV;
+
+	/* Reset saved irqs */
+	ams.worker_irqs = 0;
+
+	/* Register shock interrupt handler */
+	result = pmf_register_irq_client(ams.of_node,
+			"accel-int-2",
+			&ams_shock_client);
+	if (result < 0) {
+		pmf_unregister_irq_client(&ams_freefall_client);
+		return -ENODEV;
+	}
+
+	/* Create device */
+	ams.of_dev = of_platform_device_create(ams.of_node, "ams", NULL);
+	if (!ams.of_dev) {
+		pmf_unregister_irq_client(&ams_shock_client);
+		pmf_unregister_irq_client(&ams_freefall_client);
+		return -ENODEV;
+	}
+
+	/* Create attributes */
+	device_create_file(&ams.of_dev->dev, &dev_attr_xyz);
+
+	ams.vflag = !!(ams.get_vendor() & 0x10);
+
+	/* Init hdpark stuff */
+	ams_hdpark_init();
+
+	/* Init mouse device */
+	ams_mouse_init();
+
+	return 0;
+}
+
+int __init ams_init(void)
+{
+	struct device_node *np;
+
+	spin_lock_init(&ams.irq_lock);
+	mutex_init(&ams.lock);
+	INIT_WORK(&ams.worker, ams_worker, NULL);
+
+#ifdef CONFIG_SENSORS_AMS_I2C
+	np = of_find_node_by_name(NULL, "accelerometer");
+	if (np && device_is_compatible(np, "AAPL,accelerometer_1"))
+		/* Found I2C motion sensor */
+		return ams_i2c_init(np);
+#endif
+
+#ifdef CONFIG_SENSORS_AMS_PMU
+	np = of_find_node_by_name(NULL, "sms");
+	if (np && device_is_compatible(np, "sms"))
+		/* Found PMU motion sensor */
+		return ams_pmu_init(np);
+#endif
+
+	printk(KERN_ERR "ams: No motion sensor found.\n");
+
+	return -ENODEV;
+}
+
+void ams_exit(void)
+{
+	mutex_lock(&ams.lock);
+
+	if (ams.has_device) {
+		/* Remove mouse device */
+		ams_mouse_exit();
+
+		/* Shut down implementation */
+		ams.exit();
+
+		/* Cancel interrupt worker
+		 *
+		 * We do this after ams.exit(), because an interrupt might
+		 * have arrived before disabling them.
+		 */
+		cancel_delayed_work(&ams.worker);
+		flush_scheduled_work();
+
+		/* Disable hard disk parking */
+		ams_hdpark_exit();
+
+		/* Remove attributes */
+		device_remove_file(&ams.of_dev->dev, &dev_attr_xyz);
+
+		/* Remove device */
+		of_device_unregister(ams.of_dev);
+
+		/* Remove handler */
+		pmf_unregister_irq_client(&ams_shock_client);
+		pmf_unregister_irq_client(&ams_freefall_client);
+	}
+
+	mutex_unlock(&ams.lock);
+}
+
+MODULE_AUTHOR("Stelian Pop, Michael Hanselmann");
+MODULE_DESCRIPTION("Apple Motion Sensor driver");
+MODULE_LICENSE("GPL");
+
+module_init(ams_init);
+module_exit(ams_exit);
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17-git20.orig/drivers/hwmon/ams.h linux-2.6.17-git20/drivers/hwmon/ams.h
--- linux-2.6.17-git20.orig/drivers/hwmon/ams.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-git20/drivers/hwmon/ams.h	2006-07-02 22:19:12.000000000 +0200
@@ -0,0 +1,92 @@
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/kthread.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <asm/of_device.h>
+
+enum ams_irq {
+	AMS_IRQ_FREEFALL = 0x01,
+	AMS_IRQ_SHOCK = 0x02,
+	AMS_IRQ_GLOBAL = 0x04,
+	AMS_IRQ_ALL =
+		AMS_IRQ_FREEFALL |
+		AMS_IRQ_SHOCK |
+		AMS_IRQ_GLOBAL,
+};
+
+struct ams {
+	/* Locks */
+	spinlock_t irq_lock;
+	struct mutex lock;
+
+	/* General properties */
+	struct device_node *of_node;
+	struct of_device *of_dev;
+	char has_device;
+	char vflag;
+	u32 orient1;
+	u32 orient2;
+
+	/* Interrupt worker */
+	struct work_struct worker;
+	u8 worker_irqs;
+
+	/* Implementation
+	 *
+	 * Only call these functions with the main lock held.
+	 */
+	void (*exit)(void);
+
+	void (*get_xyz)(s8 *x, s8 *y, s8 *z);
+	u8 (*get_vendor)(void);
+
+	void (*clear_irq)(enum ams_irq reg);
+
+	/* I2C properties */
+	int i2c_bus;
+	int i2c_address;
+	struct i2c_client i2c_client;
+
+#ifdef CONFIG_SENSORS_AMS_MOUSE
+	/* Mouse emulation */
+	struct task_struct *kthread;
+	struct input_dev *idev;
+
+	/* calibrated null values */
+	int xcalib, ycalib;
+#endif
+
+#ifdef CONFIG_SENSORS_AMS_HDPARK
+	/* HD parking */
+	int is_parked;
+	unsigned long last_park_jiffies;
+	struct work_struct park_worker;
+#endif
+};
+
+extern struct ams ams;
+
+extern void ams_sensors(s8 *x, s8 *y, s8 *z);
+extern int ams_sensor_attach(void);
+
+extern int ams_pmu_init(struct device_node *np);
+extern int ams_i2c_init(struct device_node *np);
+
+#ifdef CONFIG_SENSORS_AMS_MOUSE
+extern void ams_mouse_init(void);
+extern void ams_mouse_exit(void);
+#else
+static inline void ams_mouse_init(void) {}
+static inline void ams_mouse_exit(void) {}
+#endif
+
+#ifdef CONFIG_SENSORS_AMS_HDPARK
+extern void ams_hdpark_init(void);
+extern void ams_hdpark_exit(void);
+extern void ams_hdpark(void);
+#else
+static inline void ams_hdpark_init(void) {}
+static inline void ams_hdpark_exit(void) {}
+static inline void ams_hdpark(void) {}
+#endif
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17-git20.orig/drivers/hwmon/ams-hdpark.c linux-2.6.17-git20/drivers/hwmon/ams-hdpark.c
--- linux-2.6.17-git20.orig/drivers/hwmon/ams-hdpark.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-git20/drivers/hwmon/ams-hdpark.c	2006-07-02 22:21:46.000000000 +0200
@@ -0,0 +1,72 @@
+/*
+ * Apple Motion Sensor driver (hard disk head parking)
+ *
+ * Copyright (C) 2006 Michael Hanselmann (linux-kernel@hansmi.ch)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This code won't work until the IDE layer allows HD parking. When
+ * that's done, this code needs to be updated accordingly.
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/param.h>
+#include <linux/hdpark.h>
+
+#include "ams.h"
+
+static void ams_park_worker(void *data)
+{
+	mutex_lock(&ams.lock);
+
+	if (ams.is_parked) {
+		if (time_after_eq(jiffies, ams.last_park_jiffies + HZ)) {
+			hdpark_end();
+			ams.is_parked = 0;
+		} else
+			/* Try again */
+			schedule_delayed_work(&ams.park_worker, HZ / 5);
+	}
+
+	mutex_unlock(&ams.lock);
+}
+
+/* Call with lock held! */
+void ams_hdpark()
+{
+	if (!ams.is_parked) {
+		ams.is_parked = 1;
+		hdpark_start();
+	}
+
+	ams.last_park_jiffies = jiffies;
+
+	/* Check in about 1.1 seconds. This is to avoid the time_after_eq
+	 * in ams_park_worker not being true when it runs.
+	 */
+	schedule_delayed_work(&ams.park_worker, HZ * 1.1);
+}
+
+/* Call with lock held! */
+void ams_hdpark_init()
+{
+	INIT_WORK(&ams.park_worker, ams_park_worker, NULL);
+}
+
+/* Call with lock held! */
+void ams_hdpark_exit()
+{
+	cancel_delayed_work(&ams.park_worker);
+	flush_scheduled_work();
+
+	if (ams.is_parked) {
+		hdpark_end();
+		ams.is_parked = 0;
+	}
+}
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17-git20.orig/drivers/hwmon/ams-i2c.c linux-2.6.17-git20/drivers/hwmon/ams-i2c.c
--- linux-2.6.17-git20.orig/drivers/hwmon/ams-i2c.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-git20/drivers/hwmon/ams-i2c.c	2006-07-02 21:57:32.000000000 +0200
@@ -0,0 +1,284 @@
+/*
+ * Apple Motion Sensor driver (I2C variant)
+ *
+ * Copyright (C) 2005 Stelian Pop (stelian@popies.net)
+ * Copyright (C) 2006 Michael Hanselmann (linux-kernel@hansmi.ch)
+ *
+ * Clean room implementation based on the reverse engineered Mac OS X driver by
+ * Johannes Berg <johannes@sipsolutions.net>, documentation available at
+ * http://johannes.sipsolutions.net/PowerBook/Apple_Motion_Sensor_Specification
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+
+#include "ams.h"
+
+/* AMS registers */
+#define AMS_COMMAND	0x00	/* command register */
+#define AMS_STATUS	0x01	/* status register */
+#define AMS_CTRL1	0x02	/* read control 1 (number of values) */
+#define AMS_CTRL2	0x03	/* read control 2 (offset?) */
+#define AMS_CTRL3	0x04	/* read control 3 (size of each value?) */
+#define AMS_DATA1	0x05	/* read data 1 */
+#define AMS_DATA2	0x06	/* read data 2 */
+#define AMS_DATA3	0x07	/* read data 3 */
+#define AMS_DATA4	0x08	/* read data 4 */
+#define AMS_DATAX	0x20	/* data X */
+#define AMS_DATAY	0x21	/* data Y */
+#define AMS_DATAZ	0x22	/* data Z */
+#define AMS_FREEFALL	0x24	/* freefall int control */
+#define AMS_SHOCK	0x25	/* shock int control */
+#define AMS_SENSLOW	0x26	/* sensitivity low limit */
+#define AMS_SENSHIGH	0x27	/* sensitivity high limit */
+#define AMS_CTRLX	0x28	/* control X */
+#define AMS_CTRLY	0x29	/* control Y */
+#define AMS_CTRLZ	0x2A	/* control Z */
+#define AMS_UNKNOWN1	0x2B	/* unknown 1 */
+#define AMS_UNKNOWN2	0x2C	/* unknown 2 */
+#define AMS_UNKNOWN3	0x2D	/* unknown 3 */
+#define AMS_VENDOR	0x2E	/* vendor */
+
+/* AMS commands - use with the AMS_COMMAND register */
+enum ams_i2c_cmd {
+	AMS_CMD_NOOP = 0,
+	AMS_CMD_VERSION,
+	AMS_CMD_READMEM,
+	AMS_CMD_WRITEMEM,
+	AMS_CMD_ERASEMEM,
+	AMS_CMD_READEE,
+	AMS_CMD_WRITEEE,
+	AMS_CMD_RESET,
+	AMS_CMD_START,
+};
+
+static int ams_i2c_attach(struct i2c_adapter *adapter);
+static int ams_i2c_detach(struct i2c_adapter *adapter);
+
+static struct i2c_driver ams_i2c_driver = {
+	.driver = {
+		.name   = "ams",
+		.owner  = THIS_MODULE,
+	},
+	.attach_adapter = ams_i2c_attach,
+	.detach_adapter = ams_i2c_detach,
+};
+
+static s32 ams_i2c_read(u8 reg)
+{
+	return i2c_smbus_read_byte_data(&ams.i2c_client, reg);
+}
+
+static int ams_i2c_write(u8 reg, u8 value)
+{
+	return i2c_smbus_write_byte_data(&ams.i2c_client, reg, value);
+}
+
+static int ams_i2c_cmd(enum ams_i2c_cmd cmd)
+{
+	s32 result;
+	int i;
+
+	ams_i2c_write(AMS_COMMAND, cmd);
+	for (i = 0; i < 10; i++) {
+		mdelay(5);
+		result = ams_i2c_read(AMS_COMMAND);
+		if (result == 0 || result & 0x80)
+			return 0;
+	}
+	return -1;
+}
+
+static void ams_i2c_set_irq(enum ams_irq reg, char enable)
+{
+	if (reg & AMS_IRQ_FREEFALL) {
+		u8 val = ams_i2c_read(AMS_CTRLX);
+		if (enable)     val |= 0x80;
+		else            val &= ~0x80;
+		ams_i2c_write(AMS_CTRLX, val);
+	}
+
+	if (reg & AMS_IRQ_SHOCK) {
+		u8 val = ams_i2c_read(AMS_CTRLY);
+		if (enable)     val |= 0x80;
+		else            val &= ~0x80;
+		ams_i2c_write(AMS_CTRLY, val);
+	}
+
+	if (reg & AMS_IRQ_GLOBAL) {
+		u8 val = ams_i2c_read(AMS_CTRLZ);
+		if (enable)     val |= 0x80;
+		else            val &= ~0x80;
+		ams_i2c_write(AMS_CTRLZ, val);
+	}
+}
+
+static void ams_i2c_clear_irq(enum ams_irq reg)
+{
+	if (reg & AMS_IRQ_FREEFALL)
+		ams_i2c_write(AMS_FREEFALL, 0);
+
+	if (reg & AMS_IRQ_SHOCK)
+		ams_i2c_write(AMS_SHOCK, 0);
+}
+
+static u8 ams_i2c_get_vendor(void)
+{
+	return ams_i2c_read(AMS_VENDOR);
+}
+
+static void ams_i2c_get_xyz(s8 *x, s8 *y, s8 *z)
+{
+	*x = ams_i2c_read(AMS_DATAX);
+	*y = ams_i2c_read(AMS_DATAY);
+	*z = ams_i2c_read(AMS_DATAZ);
+}
+
+static int ams_i2c_attach(struct i2c_adapter *adapter)
+{
+	unsigned long bus;
+	int vmaj, vmin;
+	int result;
+
+	if (strncmp(adapter->name, "uni-n", 5))
+		return -ENODEV;
+
+	bus = simple_strtoul(adapter->name + 6, NULL, 10);
+	if (bus != ams.i2c_bus)
+		return -ENODEV;
+
+	ams.i2c_client.addr = ams.i2c_address;
+	ams.i2c_client.adapter = adapter;
+	ams.i2c_client.driver = &ams_i2c_driver;
+	strcpy(ams.i2c_client.name, "Apple Motion Sensor");
+
+	if (ams_i2c_cmd(AMS_CMD_RESET)) {
+		printk(KERN_INFO "ams: Failed to reset the device\n");
+		return -ENODEV;
+	}
+
+	if (ams_i2c_cmd(AMS_CMD_START)) {
+		printk(KERN_INFO "ams: Failed to start the device\n");
+		return -ENODEV;
+	}
+
+	/* get version/vendor information */
+	ams_i2c_write(AMS_CTRL1, 0x02);
+	ams_i2c_write(AMS_CTRL2, 0x85);
+	ams_i2c_write(AMS_CTRL3, 0x01);
+
+	ams_i2c_cmd(AMS_CMD_READMEM);
+
+	vmaj = ams_i2c_read(AMS_DATA1);
+	vmin = ams_i2c_read(AMS_DATA2);
+	if (vmaj != 1 || vmin != 52) {
+		printk(KERN_INFO "ams: Incorrect device version (%d.%d)\n",
+			vmaj, vmin);
+		return -ENODEV;
+	}
+
+	ams_i2c_cmd(AMS_CMD_VERSION);
+
+	vmaj = ams_i2c_read(AMS_DATA1);
+	vmin = ams_i2c_read(AMS_DATA2);
+	if (vmaj != 0 || vmin != 1) {
+		printk(KERN_INFO "ams: Incorrect firmware version (%d.%d)\n",
+			vmaj, vmin);
+		return -ENODEV;
+	}
+
+	/* Disable interrupts */
+	ams_i2c_set_irq(AMS_IRQ_ALL, 0);
+
+	result = ams_sensor_attach();
+	if (result < 0)
+		return result;
+
+	/* Set default values */
+	ams_i2c_write(AMS_SENSLOW, 0x15);
+	ams_i2c_write(AMS_SENSHIGH, 0x60);
+	ams_i2c_write(AMS_CTRLX, 0x08);
+	ams_i2c_write(AMS_CTRLY, 0x0F);
+	ams_i2c_write(AMS_CTRLZ, 0x4F);
+	ams_i2c_write(AMS_UNKNOWN1, 0x14);
+
+	/* Clear interrupts */
+	ams_i2c_clear_irq(AMS_IRQ_ALL);
+
+	ams.has_device = 1;
+
+	/* Enable interrupts */
+	ams_i2c_set_irq(AMS_IRQ_ALL, 1);
+
+	printk(KERN_INFO "ams: Found I2C based motion sensor\n");
+
+	return 0;
+}
+
+static int ams_i2c_detach(struct i2c_adapter *adapter)
+{
+	i2c_detach_client(&ams.i2c_client);
+
+	/* Disable interrupts */
+	ams_i2c_set_irq(AMS_IRQ_ALL, 0);
+
+	/* Clear interrupts */
+	ams_i2c_clear_irq(AMS_IRQ_ALL);
+
+	ams.has_device = 0;
+
+	printk(KERN_INFO "ams: Unloading\n");
+
+	return 0;
+}
+
+static void ams_i2c_exit(void)
+{
+	i2c_del_driver(&ams_i2c_driver);
+}
+
+int __init ams_i2c_init(struct device_node *np)
+{
+	char *tmp_bus;
+	int result;
+	u32 *prop;
+
+	mutex_lock(&ams.lock);
+
+	/* Set implementation stuff */
+	ams.of_node = np;
+	ams.exit = ams_i2c_exit;
+	ams.get_vendor = ams_i2c_get_vendor;
+	ams.get_xyz = ams_i2c_get_xyz;
+	ams.clear_irq = ams_i2c_clear_irq;
+
+	/* look for bus either by path or using "reg" */
+	prop = (u32*)get_property(ams.of_node, "reg", NULL);
+	if (!prop) {
+		result = -ENODEV;
+
+		goto exit;
+	}
+
+	tmp_bus = strstr(ams.of_node->full_name, "/i2c-bus@");
+	if (tmp_bus)
+		ams.i2c_bus = *(tmp_bus + 9) - '0';
+	else
+		ams.i2c_bus = ((*prop) >> 8) & 0x0f;
+	ams.i2c_address = ((*prop) & 0xff) >> 1;
+
+	result = i2c_add_driver(&ams_i2c_driver);
+
+exit:
+	mutex_unlock(&ams.lock);
+
+	return result;
+}
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17-git20.orig/drivers/hwmon/ams-mouse.c linux-2.6.17-git20/drivers/hwmon/ams-mouse.c
--- linux-2.6.17-git20.orig/drivers/hwmon/ams-mouse.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-git20/drivers/hwmon/ams-mouse.c	2006-07-02 21:57:32.000000000 +0200
@@ -0,0 +1,146 @@
+/*
+ * Apple Motion Sensor driver (mouse emulation)
+ *
+ * Copyright (C) 2005 Stelian Pop (stelian@popies.net)
+ * Copyright (C) 2006 Michael Hanselmann (linux-kernel@hansmi.ch)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+
+#include "ams.h"
+
+static unsigned int mouse;
+module_param(mouse, bool, 0644);
+MODULE_PARM_DESC(mouse, "Enable the input class device on module load");
+
+static int ams_mouse_kthread(void *data)
+{
+	s8 x, y, z;
+
+	while (!kthread_should_stop()) {
+		mutex_lock(&ams.lock);
+
+		ams_sensors(&x, &y, &z);
+
+		input_report_abs(ams.idev, ABS_X, x - ams.xcalib);
+		input_report_abs(ams.idev, ABS_Y, y - ams.ycalib);
+
+		input_sync(ams.idev);
+
+		mutex_unlock(&ams.lock);
+
+		msleep(25);
+	}
+
+	return 0;
+}
+
+/* Call with lock held! */
+static void ams_mouse_enable(void)
+{
+	s8 x, y, z;
+
+	if (ams.idev)
+		return;
+
+	ams_sensors(&x, &y, &z);
+	ams.xcalib = x;
+	ams.ycalib = y;
+
+	ams.idev = input_allocate_device();
+	if (!ams.idev)
+		return;
+
+	ams.idev->name = "Apple Motion Sensor";
+	ams.idev->id.bustype = BUS_I2C;
+	ams.idev->id.vendor = 0;
+
+	input_set_abs_params(ams.idev, ABS_X, -50, 50, 3, 0);
+	input_set_abs_params(ams.idev, ABS_Y, -50, 50, 3, 0);
+
+	set_bit(EV_ABS, ams.idev->evbit);
+	set_bit(EV_KEY, ams.idev->evbit);
+	set_bit(BTN_TOUCH, ams.idev->keybit);
+
+	if (input_register_device(ams.idev)) {
+		input_free_device(ams.idev);
+		ams.idev = NULL;
+		return;
+	}
+
+	ams.kthread = kthread_run(ams_mouse_kthread, NULL, "kams");
+	if (IS_ERR(ams.kthread)) {
+		input_unregister_device(ams.idev);
+		ams.idev = NULL;
+		return;
+	}
+}
+
+/* Call with lock held! */
+static void ams_mouse_disable(void)
+{
+	if (ams.idev) {
+		kthread_stop(ams.kthread);
+		input_unregister_device(ams.idev);
+		ams.idev = NULL;
+	}
+}
+
+static ssize_t ams_mouse_show_mouse(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", mouse);
+}
+
+static ssize_t ams_mouse_store_mouse(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	int oldmouse = mouse;
+
+	if (sscanf(buf, "%d\n", &mouse) != 1)
+		return -EINVAL;
+
+	mouse = !!mouse;
+
+	if (oldmouse != mouse) {
+		mutex_lock(&ams.lock);
+
+		if (mouse)
+			ams_mouse_enable();
+		else
+			ams_mouse_disable();
+
+		mutex_unlock(&ams.lock);
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR(mouse, S_IRUGO | S_IWUSR,
+	ams_mouse_show_mouse, ams_mouse_store_mouse);
+
+/* Call with lock held! */
+void ams_mouse_init()
+{
+	device_create_file(&ams.of_dev->dev, &dev_attr_mouse);
+
+	if (mouse)
+		ams_mouse_enable();
+}
+
+/* Call with lock held! */
+void ams_mouse_exit()
+{
+	ams_mouse_disable();
+	device_remove_file(&ams.of_dev->dev, &dev_attr_mouse);
+}
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17-git20.orig/drivers/hwmon/ams-pmu.c linux-2.6.17-git20/drivers/hwmon/ams-pmu.c
--- linux-2.6.17-git20.orig/drivers/hwmon/ams-pmu.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-git20/drivers/hwmon/ams-pmu.c	2006-07-02 21:57:32.000000000 +0200
@@ -0,0 +1,202 @@
+/*
+ * Apple Motion Sensor driver (PMU variant)
+ *
+ * Copyright (C) 2006 Michael Hanselmann (linux-kernel@hansmi.ch)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/adb.h>
+#include <linux/pmu.h>
+
+#include "ams.h"
+
+/* Attitude */
+#define AMS_X			0x00
+#define AMS_Y			0x01
+#define AMS_Z			0x02
+
+/* Not exactly known, maybe chip vendor */
+#define AMS_VENDOR		0x03
+
+/* Freefall registers */
+#define AMS_FF_CLEAR		0x04
+#define AMS_FF_ENABLE		0x05
+#define AMS_FF_LOW_LIMIT	0x06
+#define AMS_FF_DEBOUNCE		0x07
+
+/* Shock registers */
+#define AMS_SHOCK_CLEAR		0x08
+#define AMS_SHOCK_ENABLE	0x09
+#define AMS_SHOCK_HIGH_LIMIT	0x0a
+#define AMS_SHOCK_DEBOUNCE	0x0b
+
+/* Global interrupt and power control register */
+#define AMS_CONTROL		0x0c
+
+static u8 ams_pmu_cmd;
+
+static void ams_pmu_req_complete(struct adb_request *req)
+{
+	complete((struct completion *)req->arg);
+}
+
+/* Only call this function from task context */
+static void ams_pmu_set_register(u8 reg, u8 value)
+{
+	static struct adb_request req;
+	DECLARE_COMPLETION(req_complete);
+
+	req.arg = &req_complete;
+	if (pmu_request(&req, ams_pmu_req_complete, 4, ams_pmu_cmd, 0x00, reg, value))
+		return;
+
+	wait_for_completion(&req_complete);
+}
+
+/* Only call this function from task context */
+static u8 ams_pmu_get_register(u8 reg)
+{
+	static struct adb_request req;
+	DECLARE_COMPLETION(req_complete);
+
+	req.arg = &req_complete;
+	if (pmu_request(&req, ams_pmu_req_complete, 3, ams_pmu_cmd, 0x01, reg))
+		return 0;
+
+	wait_for_completion(&req_complete);
+
+	if (req.reply_len > 0)
+		return req.reply[0];
+	else
+		return 0;
+}
+
+/* Enables or disables the specified interrupts */
+static void ams_pmu_set_irq(enum ams_irq reg, char enable)
+{
+	if (reg & AMS_IRQ_FREEFALL) {
+		u8 val = ams_pmu_get_register(AMS_FF_ENABLE);
+		if (enable)	val |= 0x80;
+		else		val &= ~0x80;
+		ams_pmu_set_register(AMS_FF_ENABLE, val);
+	}
+
+	if (reg & AMS_IRQ_SHOCK) {
+		u8 val = ams_pmu_get_register(AMS_SHOCK_ENABLE);
+		if (enable)	val |= 0x80;
+		else		val &= ~0x80;
+		ams_pmu_set_register(AMS_SHOCK_ENABLE, val);
+	}
+
+	if (reg & AMS_IRQ_GLOBAL) {
+		u8 val = ams_pmu_get_register(AMS_CONTROL);
+		if (enable)	val |= 0x80;
+		else		val &= ~0x80;
+		ams_pmu_set_register(AMS_CONTROL, val);
+	}
+}
+
+static void ams_pmu_clear_irq(enum ams_irq reg)
+{
+	if (reg & AMS_IRQ_FREEFALL)
+		ams_pmu_set_register(AMS_FF_CLEAR, 0x00);
+
+	if (reg & AMS_IRQ_SHOCK)
+		ams_pmu_set_register(AMS_SHOCK_CLEAR, 0x00);
+}
+
+static u8 ams_pmu_get_vendor(void)
+{
+	return ams_pmu_get_register(AMS_VENDOR);
+}
+
+static void ams_pmu_get_xyz(s8 *x, s8 *y, s8 *z)
+{
+	*x = ams_pmu_get_register(AMS_X);
+	*y = ams_pmu_get_register(AMS_Y);
+	*z = ams_pmu_get_register(AMS_Z);
+}
+
+static void ams_pmu_exit(void)
+{
+	/* Disable interrupts */
+	ams_pmu_set_irq(AMS_IRQ_ALL, 0);
+
+	/* Clear interrupts */
+	ams_pmu_clear_irq(AMS_IRQ_ALL);
+
+	ams.has_device = 0;
+
+	printk(KERN_INFO "ams: Unloading\n");
+}
+
+/* Call with lock held! */
+int __init ams_pmu_init(struct device_node *np)
+{
+	u32 *prop;
+	int result;
+
+	mutex_lock(&ams.lock);
+
+	/* Set implementation stuff */
+	ams.of_node = np;
+	ams.exit = ams_pmu_exit;
+	ams.get_vendor = ams_pmu_get_vendor;
+	ams.get_xyz = ams_pmu_get_xyz;
+	ams.clear_irq = ams_pmu_clear_irq;
+
+	/* Get PMU command, should be 0x4e, but we can never know */
+	prop = (u32*)get_property(ams.of_node, "reg", NULL);
+	if (!prop) {
+		result = -ENODEV;
+		goto exit;
+	}
+	ams_pmu_cmd = ((*prop) >> 8) & 0xff;
+
+	/* Disable interrupts */
+	ams_pmu_set_irq(AMS_IRQ_ALL, 0);
+
+	/* Clear interrupts */
+	ams_pmu_clear_irq(AMS_IRQ_ALL);
+
+	result = ams_sensor_attach();
+	if (result < 0) {
+		goto exit;
+	}
+
+	/* Set default values */
+	ams_pmu_set_register(AMS_FF_LOW_LIMIT, 0x15);
+	ams_pmu_set_register(AMS_FF_ENABLE, 0x08);
+	ams_pmu_set_register(AMS_FF_DEBOUNCE, 0x14);
+
+	ams_pmu_set_register(AMS_SHOCK_HIGH_LIMIT, 0x60);
+	ams_pmu_set_register(AMS_SHOCK_ENABLE, 0x0f);
+	ams_pmu_set_register(AMS_SHOCK_DEBOUNCE, 0x14);
+
+	ams_pmu_set_register(AMS_CONTROL, 0x4f);
+
+	/* Clear interrupts */
+	ams_pmu_clear_irq(AMS_IRQ_ALL);
+
+	ams.has_device = 1;
+
+	/* Enable interrupts */
+	ams_pmu_set_irq(AMS_IRQ_ALL, 1);
+
+	printk(KERN_INFO "ams: Found PMU based motion sensor\n");
+
+	result = 0;
+
+exit:
+	mutex_unlock(&ams.lock);
+
+	return result;
+}
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17-git20.orig/drivers/hwmon/Kconfig linux-2.6.17-git20/drivers/hwmon/Kconfig
--- linux-2.6.17-git20.orig/drivers/hwmon/Kconfig	2006-07-02 21:49:19.000000000 +0200
+++ linux-2.6.17-git20/drivers/hwmon/Kconfig	2006-07-02 22:20:22.000000000 +0200
@@ -507,6 +507,42 @@ config SENSORS_HDAPS
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of hdaps.
 
+config SENSORS_AMS
+	tristate "Motion sensor driver"
+	default y
+	help
+	  Support for the motion sensor included in PowerBooks.
+
+config SENSORS_AMS_PMU
+	bool "PMU variant"
+	depends on SENSORS_AMS && ADB_PMU
+	default y
+	help
+	  PMU variant of motion sensor, found in late 2005 PowerBooks.
+
+config SENSORS_AMS_I2C
+	bool "I2C variant"
+	depends on SENSORS_AMS && I2C
+	default y
+	help
+	  I2C variant of motion sensor, found in early 2005 PowerBooks and
+	  iBooks.
+
+config SENSORS_AMS_MOUSE
+	bool "Support for mouse mode with motion sensor"
+	depends on SENSORS_AMS && INPUT
+	help
+	  Support for mouse emulation with motion sensor.
+
+config SENSORS_AMS_HDPARK
+	bool "Park hard disk heads on freefall or shock"
+	depends on SENSORS_AMS = y && BROKEN
+	default y
+	help
+	  Park the internal hard disk's heads if a free fall or shock is
+	  detected. This can help to prevent data loss in case of a
+	  head crash, altough nobody can guarantee anything.
+
 config HWMON_DEBUG_CHIP
 	bool "Hardware Monitoring Chip debugging messages"
 	depends on HWMON
diff -Nrup --exclude-from linux-exclude-from linux-2.6.17-git20.orig/drivers/hwmon/Makefile linux-2.6.17-git20/drivers/hwmon/Makefile
--- linux-2.6.17-git20.orig/drivers/hwmon/Makefile	2006-07-02 21:49:19.000000000 +0200
+++ linux-2.6.17-git20/drivers/hwmon/Makefile	2006-07-02 22:17:43.000000000 +0200
@@ -49,6 +49,13 @@ obj-$(CONFIG_SENSORS_VT8231)	+= vt8231.o
 obj-$(CONFIG_SENSORS_W83627EHF)	+= w83627ehf.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 
+ams-y					:= ams-core.o
+ams-$(CONFIG_SENSORS_AMS_PMU)		+= ams-pmu.o
+ams-$(CONFIG_SENSORS_AMS_I2C)		+= ams-i2c.o
+ams-$(CONFIG_SENSORS_AMS_MOUSE)		+= ams-mouse.o
+ams-$(CONFIG_SENSORS_AMS_HDPARK)	+= ams-hdpark.o
+obj-$(CONFIG_SENSORS_AMS)		+= ams.o
+
 ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
 endif
