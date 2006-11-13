Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755145AbWKMQOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755145AbWKMQOW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755181AbWKMQOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:14:22 -0500
Received: from sd291.sivit.org ([194.146.225.122]:1798 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1755145AbWKMQOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:14:20 -0500
Subject: Re: [PATCH] Apple Motion Sensor driver
From: Stelian Pop <stelian@popies.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Michael Hanselmann <linux-kernel@hansmi.ch>,
       "Aristeu S. Rozanski F." <aris@cathedrallabs.org>,
       Johannes Berg <johannes@sipsolutions.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Robert Love <rml@novell.com>,
       Jean Delvare <khali@linux-fr.org>,
       Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <d120d5000611130753p172c2a69n260482052f623a46@mail.gmail.com>
References: <1163280972.32084.13.camel@localhost.localdomain>
	 <d120d5000611130704r258c8946p3994c5ba1e0187e9@mail.gmail.com>
	 <1163431758.23444.8.camel@localhost.localdomain>
	 <d120d5000611130753p172c2a69n260482052f623a46@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 13 Nov 2006 17:14:14 +0100
Message-Id: <1163434455.23444.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 13 novembre 2006 à 10:53 -0500, Dmitry Torokhov a écrit :

> > +       return IS_ERR(ams_info.kthread) ? -ENODEV : 0;

> Is there a reason why you reporting -ENODEV instead of real error code
> from kthread_run()?

Euh... :)

Here it comes again:

---

This driver adds support for the Apple Motion Sensor (AMS) as found in 2005
revisions of Apple PowerBooks and iBooks.  It implements both the PMU and
I²C variants.  The I²C driver and mouse emulation is based on code by
Stelian Pop <stelian@popies.net>, while the PMU driver has been developped
by Michael Hanselmann <linux-kernel@hansmi.ch>. HD parking support will be
added later.

Various people contributed fixes to this driver, including
Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org> and
Jean Delvare <khali@linux-fr.org>.

Signed-off-by: Stelian Pop <stelian@popies.net>

 Kconfig         |   25 ++++
 Makefile        |    1 
 ams/Makefile    |    8 +
 ams/ams-core.c  |  265 +++++++++++++++++++++++++++++++++++++++++++++++++
 ams/ams-i2c.c   |  299 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ams/ams-mouse.c |  152 ++++++++++++++++++++++++++++
 ams/ams-pmu.c   |  207 ++++++++++++++++++++++++++++++++++++++
 ams/ams.h       |   72 +++++++++++++
 8 files changed, 1029 insertions(+)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index e76d919..797ad7b 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -106,6 +106,31 @@ config SENSORS_K8TEMP
 	  This driver can also be built as a module.  If so, the module
 	  will be called k8temp.
 
+config SENSORS_AMS
+	tristate "Apple Motion Sensor driver"
+	depends on HWMON && PPC_PMAC && !PPC64 && INPUT && ((ADB_PMU && I2C = y) || (ADB_PMU && !I2C) || I2C) && EXPERIMENTAL
+	help
+	  Support for the motion sensor included in PowerBooks. Includes
+	  implementations for PMU and I2C.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called ams.
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
 config SENSORS_ASB100
 	tristate "Asus ASB100 Bach"
 	depends on HWMON && I2C && EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index af01cc6..d4a9ce7 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025
 obj-$(CONFIG_SENSORS_ADM1026)	+= adm1026.o
 obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
 obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
+obj-$(CONFIG_SENSORS_AMS)	+= ams/
 obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
 obj-$(CONFIG_SENSORS_F71805F)	+= f71805f.o
diff --git a/drivers/hwmon/ams/Makefile b/drivers/hwmon/ams/Makefile
new file mode 100644
index 0000000..c67819c
--- /dev/null
+++ b/drivers/hwmon/ams/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for Apple Motion Sensor driver
+#
+
+ams-y					:= ams-core.o ams-mouse.o
+ams-$(CONFIG_SENSORS_AMS_PMU)		+= ams-pmu.o
+ams-$(CONFIG_SENSORS_AMS_I2C)		+= ams-i2c.o
+obj-$(CONFIG_SENSORS_AMS)		+= ams.o
diff --git a/drivers/hwmon/ams/ams-core.c b/drivers/hwmon/ams/ams-core.c
new file mode 100644
index 0000000..5e9a5e7
--- /dev/null
+++ b/drivers/hwmon/ams/ams-core.c
@@ -0,0 +1,265 @@
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
+struct ams ams_info;
+
+static unsigned int verbose;
+module_param(verbose, bool, 0644);
+MODULE_PARM_DESC(verbose, "Show free falls and shocks in kernel output");
+
+/* Call with ams_info.lock held! */
+void ams_sensors(s8 *x, s8 *y, s8 *z)
+{
+	u32 orient = ams_info.vflag? ams_info.orient1 : ams_info.orient2;
+
+	if (orient & 0x80)
+		/* X and Y swapped */
+		ams_info.get_xyz(y, x, z);
+	else
+		ams_info.get_xyz(x, y, z);
+
+	if (orient & 0x04)
+		*z = ~(*z);
+	if (orient & 0x02)
+		*y = ~(*y);
+	if (orient & 0x01)
+		*x = ~(*x);
+}
+
+static ssize_t ams_show_current(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	s8 x, y, z;
+
+	mutex_lock(&ams_info.lock);
+	ams_sensors(&x, &y, &z);
+	mutex_unlock(&ams_info.lock);
+
+	return snprintf(buf, PAGE_SIZE, "%d %d %d\n", x, y, z);
+}
+
+static DEVICE_ATTR(current, S_IRUGO, ams_show_current, NULL);
+
+static void ams_handle_irq(void *data)
+{
+	enum ams_irq irq = *((enum ams_irq *)data);
+
+	spin_lock(&ams_info.irq_lock);
+
+	ams_info.worker_irqs |= irq;
+	schedule_work(&ams_info.worker);
+
+	spin_unlock(&ams_info.irq_lock);
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
+/* Once hard disk parking is implemented in the kernel, this function can
+ * trigger it.
+ */
+static void ams_worker(void *data)
+{
+	mutex_lock(&ams_info.lock);
+
+	if (ams_info.has_device) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&ams_info.irq_lock, flags);
+
+		if (ams_info.worker_irqs & AMS_IRQ_FREEFALL) {
+			if (verbose)
+				printk(KERN_INFO "ams: freefall detected!\n");
+
+			ams_info.worker_irqs &= ~AMS_IRQ_FREEFALL;
+
+			/* we must call this with interrupts enabled */
+			spin_unlock_irqrestore(&ams_info.irq_lock, flags);
+			ams_info.clear_irq(AMS_IRQ_FREEFALL);
+			spin_lock_irqsave(&ams_info.irq_lock, flags);
+		}
+
+		if (ams_info.worker_irqs & AMS_IRQ_SHOCK) {
+			if (verbose)
+				printk(KERN_INFO "ams: shock detected!\n");
+
+			ams_info.worker_irqs &= ~AMS_IRQ_SHOCK;
+
+			/* we must call this with interrupts enabled */
+			spin_unlock_irqrestore(&ams_info.irq_lock, flags);
+			ams_info.clear_irq(AMS_IRQ_SHOCK);
+			spin_lock_irqsave(&ams_info.irq_lock, flags);
+		}
+
+		spin_unlock_irqrestore(&ams_info.irq_lock, flags);
+	}
+
+	mutex_unlock(&ams_info.lock);
+}
+
+/* Call with ams_info.lock held! */
+int ams_sensor_attach(void)
+{
+	int result;
+	u32 *prop;
+
+	/* Get orientation */
+	prop = (u32*)get_property(ams_info.of_node, "orientation", NULL);
+	if (!prop)
+		return -ENODEV;
+	ams_info.orient1 = *prop;
+	ams_info.orient2 = *(prop + 1);
+
+	/* Register freefall interrupt handler */
+	result = pmf_register_irq_client(ams_info.of_node,
+			"accel-int-1",
+			&ams_freefall_client);
+	if (result < 0)
+		return -ENODEV;
+
+	/* Reset saved irqs */
+	ams_info.worker_irqs = 0;
+
+	/* Register shock interrupt handler */
+	result = pmf_register_irq_client(ams_info.of_node,
+			"accel-int-2",
+			&ams_shock_client);
+	if (result < 0)
+		goto release_freefall;
+
+	/* Create device */
+	ams_info.of_dev = of_platform_device_create(ams_info.of_node, "ams", NULL);
+	if (!ams_info.of_dev) {
+		result = -ENODEV;
+		goto release_shock;
+	}
+
+	/* Create attributes */
+	result = device_create_file(&ams_info.of_dev->dev, &dev_attr_current);
+	if (result)
+		goto release_of;
+
+	ams_info.vflag = !!(ams_info.get_vendor() & 0x10);
+
+	/* Init mouse device */
+	result = ams_mouse_init();
+	if (result)
+		goto release_device_file;
+
+	return result;
+release_device_file:
+	device_remove_file(&ams_info.of_dev->dev, &dev_attr_current);
+release_of:
+	of_device_unregister(ams_info.of_dev);
+release_shock:
+	pmf_unregister_irq_client(&ams_shock_client);
+release_freefall:
+	pmf_unregister_irq_client(&ams_freefall_client);
+	return result;
+}
+
+int __init ams_init(void)
+{
+	struct device_node *np;
+
+	spin_lock_init(&ams_info.irq_lock);
+	mutex_init(&ams_info.lock);
+	INIT_WORK(&ams_info.worker, ams_worker, NULL);
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
+	mutex_lock(&ams_info.lock);
+
+	if (ams_info.has_device) {
+		/* Remove mouse device */
+		ams_mouse_exit();
+
+		/* Shut down implementation */
+		ams_info.exit();
+
+		/* Cancel interrupt worker
+		 *
+		 * We do this after ams_info.exit(), because an interrupt might
+		 * have arrived before disabling them.
+		 */
+		cancel_delayed_work(&ams_info.worker);
+		flush_scheduled_work();
+
+		/* Remove attributes */
+		device_remove_file(&ams_info.of_dev->dev, &dev_attr_current);
+
+		/* Remove device */
+		of_device_unregister(ams_info.of_dev);
+
+		/* Remove handler */
+		pmf_unregister_irq_client(&ams_shock_client);
+		pmf_unregister_irq_client(&ams_freefall_client);
+	}
+
+	mutex_unlock(&ams_info.lock);
+}
+
+MODULE_AUTHOR("Stelian Pop, Michael Hanselmann");
+MODULE_DESCRIPTION("Apple Motion Sensor driver");
+MODULE_LICENSE("GPL");
+
+module_init(ams_init);
+module_exit(ams_exit);
diff --git a/drivers/hwmon/ams/ams-i2c.c b/drivers/hwmon/ams/ams-i2c.c
new file mode 100644
index 0000000..0d24bdf
--- /dev/null
+++ b/drivers/hwmon/ams/ams-i2c.c
@@ -0,0 +1,299 @@
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
+	return i2c_smbus_read_byte_data(&ams_info.i2c_client, reg);
+}
+
+static int ams_i2c_write(u8 reg, u8 value)
+{
+	return i2c_smbus_write_byte_data(&ams_info.i2c_client, reg, value);
+}
+
+static int ams_i2c_cmd(enum ams_i2c_cmd cmd)
+{
+	s32 result;
+	int remaining = HZ / 20;
+
+	ams_i2c_write(AMS_COMMAND, cmd);
+	mdelay(5);
+
+	while (remaining) {
+		result = ams_i2c_read(AMS_COMMAND);
+		if (result == 0 || result & 0x80)
+			return 0;
+
+		remaining = schedule_timeout(remaining);
+	}
+
+	return -1;
+}
+
+static void ams_i2c_set_irq(enum ams_irq reg, char enable)
+{
+	if (reg & AMS_IRQ_FREEFALL) {
+		u8 val = ams_i2c_read(AMS_CTRLX);
+		if (enable)
+			val |= 0x80;
+		else
+			val &= ~0x80;
+		ams_i2c_write(AMS_CTRLX, val);
+	}
+
+	if (reg & AMS_IRQ_SHOCK) {
+		u8 val = ams_i2c_read(AMS_CTRLY);
+		if (enable)
+			val |= 0x80;
+		else
+			val &= ~0x80;
+		ams_i2c_write(AMS_CTRLY, val);
+	}
+
+	if (reg & AMS_IRQ_GLOBAL) {
+		u8 val = ams_i2c_read(AMS_CTRLZ);
+		if (enable)
+			val |= 0x80;
+		else
+			val &= ~0x80;
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
+	/* There can be only one */
+	if (unlikely(ams_info.has_device))
+		return -ENODEV;
+
+	if (strncmp(adapter->name, "uni-n", 5))
+		return -ENODEV;
+
+	bus = simple_strtoul(adapter->name + 6, NULL, 10);
+	if (bus != ams_info.i2c_bus)
+		return -ENODEV;
+
+	ams_info.i2c_client.addr = ams_info.i2c_address;
+	ams_info.i2c_client.adapter = adapter;
+	ams_info.i2c_client.driver = &ams_i2c_driver;
+	strcpy(ams_info.i2c_client.name, "Apple Motion Sensor");
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
+	ams_info.has_device = 1;
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
+	if (ams_info.has_device) {
+		/* Disable interrupts */
+		ams_i2c_set_irq(AMS_IRQ_ALL, 0);
+
+		/* Clear interrupts */
+		ams_i2c_clear_irq(AMS_IRQ_ALL);
+
+		printk(KERN_INFO "ams: Unloading\n");
+
+		ams_info.has_device = 0;
+	}
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
+	mutex_lock(&ams_info.lock);
+
+	/* Set implementation stuff */
+	ams_info.of_node = np;
+	ams_info.exit = ams_i2c_exit;
+	ams_info.get_vendor = ams_i2c_get_vendor;
+	ams_info.get_xyz = ams_i2c_get_xyz;
+	ams_info.clear_irq = ams_i2c_clear_irq;
+	ams_info.bustype = BUS_I2C;
+
+	/* look for bus either using "reg" or by path */
+	prop = (u32*)get_property(ams_info.of_node, "reg", NULL);
+	if (!prop) {
+		result = -ENODEV;
+
+		goto exit;
+	}
+
+	tmp_bus = strstr(ams_info.of_node->full_name, "/i2c-bus@");
+	if (tmp_bus)
+		ams_info.i2c_bus = *(tmp_bus + 9) - '0';
+	else
+		ams_info.i2c_bus = ((*prop) >> 8) & 0x0f;
+	ams_info.i2c_address = ((*prop) & 0xff) >> 1;
+
+	result = i2c_add_driver(&ams_i2c_driver);
+
+exit:
+	mutex_unlock(&ams_info.lock);
+
+	return result;
+}
diff --git a/drivers/hwmon/ams/ams-mouse.c b/drivers/hwmon/ams/ams-mouse.c
new file mode 100644
index 0000000..96c91a3
--- /dev/null
+++ b/drivers/hwmon/ams/ams-mouse.c
@@ -0,0 +1,152 @@
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
+		mutex_lock(&ams_info.lock);
+
+		ams_sensors(&x, &y, &z);
+
+		input_report_abs(ams_info.idev, ABS_X, x - ams_info.xcalib);
+		input_report_abs(ams_info.idev, ABS_Y, y - ams_info.ycalib);
+		input_report_abs(ams_info.idev, ABS_Z, z - ams_info.zcalib);
+
+		input_sync(ams_info.idev);
+
+		mutex_unlock(&ams_info.lock);
+
+		msleep(25);
+	}
+
+	return 0;
+}
+
+static int ams_mouse_open(struct input_dev *dev)
+{
+	ams_info.kthread = kthread_run(ams_mouse_kthread, NULL, "kams");
+	return IS_ERR(ams_info.kthread) ? PTR_ERR(ams_info.kthread) : 0;
+}
+
+static void ams_mouse_close(struct input_dev *dev)
+{
+	kthread_stop(ams_info.kthread);
+}
+
+/* Call with ams_info.lock held! */
+static void ams_mouse_enable(void)
+{
+	s8 x, y, z;
+
+	if (ams_info.idev)
+		return;
+
+	ams_sensors(&x, &y, &z);
+	ams_info.xcalib = x;
+	ams_info.ycalib = y;
+	ams_info.zcalib = z;
+
+	ams_info.idev = input_allocate_device();
+	if (!ams_info.idev)
+		return;
+
+	ams_info.idev->name = "Apple Motion Sensor";
+	ams_info.idev->id.bustype = ams_info.bustype;
+	ams_info.idev->id.vendor = 0;
+	ams_info.idev->open = ams_mouse_open;
+	ams_info.idev->close = ams_mouse_close;
+	ams_info.idev->cdev.dev = &ams_info.of_dev->dev;
+
+	input_set_abs_params(ams_info.idev, ABS_X, -50, 50, 3, 0);
+	input_set_abs_params(ams_info.idev, ABS_Y, -50, 50, 3, 0);
+	input_set_abs_params(ams_info.idev, ABS_Z, -50, 50, 3, 0);
+
+	set_bit(EV_ABS, ams_info.idev->evbit);
+	set_bit(EV_KEY, ams_info.idev->evbit);
+	set_bit(BTN_TOUCH, ams_info.idev->keybit);
+
+	if (input_register_device(ams_info.idev)) {
+		input_free_device(ams_info.idev);
+		ams_info.idev = NULL;
+		return;
+	}
+}
+
+/* Call with ams_info.lock held! */
+static void ams_mouse_disable(void)
+{
+	if (ams_info.idev) {
+		input_unregister_device(ams_info.idev);
+		ams_info.idev = NULL;
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
+	if (sscanf(buf, "%d\n", &mouse) != 1)
+		return -EINVAL;
+
+	mutex_lock(&ams_info.lock);
+
+	if (mouse)
+		ams_mouse_enable();
+	else
+		ams_mouse_disable();
+
+	mutex_unlock(&ams_info.lock);
+
+	return count;
+}
+
+static DEVICE_ATTR(mouse, S_IRUGO | S_IWUSR,
+	ams_mouse_show_mouse, ams_mouse_store_mouse);
+
+/* Call with ams_info.lock held! */
+int ams_mouse_init(void)
+{
+	int result;
+
+	result = device_create_file(&ams_info.of_dev->dev, &dev_attr_mouse);
+
+	if (!result && mouse)
+		ams_mouse_enable();
+	return result;
+}
+
+/* Call with ams_info.lock held! */
+void ams_mouse_exit()
+{
+	ams_mouse_disable();
+	device_remove_file(&ams_info.of_dev->dev, &dev_attr_mouse);
+}
diff --git a/drivers/hwmon/ams/ams-pmu.c b/drivers/hwmon/ams/ams-pmu.c
new file mode 100644
index 0000000..4636ae0
--- /dev/null
+++ b/drivers/hwmon/ams/ams-pmu.c
@@ -0,0 +1,207 @@
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
+		if (enable)
+			val |= 0x80;
+		else
+			val &= ~0x80;
+		ams_pmu_set_register(AMS_FF_ENABLE, val);
+	}
+
+	if (reg & AMS_IRQ_SHOCK) {
+		u8 val = ams_pmu_get_register(AMS_SHOCK_ENABLE);
+		if (enable)
+			val |= 0x80;
+		else
+			val &= ~0x80;
+		ams_pmu_set_register(AMS_SHOCK_ENABLE, val);
+	}
+
+	if (reg & AMS_IRQ_GLOBAL) {
+		u8 val = ams_pmu_get_register(AMS_CONTROL);
+		if (enable)
+			val |= 0x80;
+		else
+			val &= ~0x80;
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
+	ams_info.has_device = 0;
+
+	printk(KERN_INFO "ams: Unloading\n");
+}
+
+int __init ams_pmu_init(struct device_node *np)
+{
+	u32 *prop;
+	int result;
+
+	mutex_lock(&ams_info.lock);
+
+	/* Set implementation stuff */
+	ams_info.of_node = np;
+	ams_info.exit = ams_pmu_exit;
+	ams_info.get_vendor = ams_pmu_get_vendor;
+	ams_info.get_xyz = ams_pmu_get_xyz;
+	ams_info.clear_irq = ams_pmu_clear_irq;
+	ams_info.bustype = BUS_HOST;
+
+	/* Get PMU command, should be 0x4e, but we can never know */
+	prop = (u32*)get_property(ams_info.of_node, "reg", NULL);
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
+	if (result < 0)
+		goto exit;
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
+	ams_info.has_device = 1;
+
+	/* Enable interrupts */
+	ams_pmu_set_irq(AMS_IRQ_ALL, 1);
+
+	printk(KERN_INFO "ams: Found PMU based motion sensor\n");
+
+	result = 0;
+
+exit:
+	mutex_unlock(&ams_info.lock);
+
+	return result;
+}
diff --git a/drivers/hwmon/ams/ams.h b/drivers/hwmon/ams/ams.h
new file mode 100644
index 0000000..8d25f19
--- /dev/null
+++ b/drivers/hwmon/ams/ams.h
@@ -0,0 +1,72 @@
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/kthread.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
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
+#ifdef CONFIG_SENSORS_AMS_I2C
+	/* I2C properties */
+	int i2c_bus;
+	int i2c_address;
+	struct i2c_client i2c_client;
+#endif
+
+	/* Mouse emulation */
+	struct task_struct *kthread;
+	struct input_dev *idev;
+	__u16 bustype;
+
+	/* calibrated null values */
+	int xcalib, ycalib, zcalib;
+};
+
+extern struct ams ams_info;
+
+extern void ams_sensors(s8 *x, s8 *y, s8 *z);
+extern int ams_sensor_attach(void);
+
+extern int ams_pmu_init(struct device_node *np);
+extern int ams_i2c_init(struct device_node *np);
+
+extern int ams_mouse_init(void);
+extern void ams_mouse_exit(void);

-- 
Stelian Pop <stelian@popies.net>

