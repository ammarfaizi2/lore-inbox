Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWGCDPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWGCDPy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 23:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWGCDPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 23:15:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61315 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750791AbWGCDPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 23:15:53 -0400
Date: Sun, 2 Jul 2006 20:14:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       khali@linux-fr.org, linux-kernel@killerfox.forkbomb.ch,
       benh@kernel.crashing.org, johannes@sipsolutions.net, stelian@popies.net,
       chainsaw@gentoo.org
Subject: Re: [RFC] Apple Motion Sensor driver
Message-Id: <20060702201415.791c6eb2.akpm@osdl.org>
In-Reply-To: <20060702222649.GA13411@hansmi.ch>
References: <20060702222649.GA13411@hansmi.ch>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006 00:26:49 +0200
Michael Hanselmann <linux-kernel@hansmi.ch> wrote:

> Below you find the latest revision of my AMS driver.

I was about to merge the below, then this comes along.  Now what?


From: Stelian Pop <stelian@popies.net>

This driver provides support for the Apple Motion Sensor (ams), which
provides an accelerometer and other misc.  data.  Some Apple PowerBooks
(the series the PowerBook5,6 falls into, later ones have a slightly
different one the driver doesn't handle) are supported.  The accelerometer
data is readable via sysfs.

This driver also provides an absolute input class device, allowing the
laptop to act as a pinball machine-esque joystick.

In the future (once the proper API exist in the block layer) this driver
will tell the laptop disk to protect its heads in the event of a
catastrophic fall.

Signed-off-by: Stelian Pop <stelian@popies.net>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Robert Love <rml@novell.com>
Cc: Jean Delvare <khali@linux-fr.org>


 drivers/hwmon/Kconfig  |   17 +
 drivers/hwmon/Makefile |    1 
 drivers/hwmon/ams.c    |  544 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 562 insertions(+)

diff -puN /dev/null drivers/hwmon/ams.c
--- /dev/null
+++ a/drivers/hwmon/ams.c
@@ -0,0 +1,544 @@
+/*
+ * Apple Motion Sensor driver
+ *
+ * Copyright (C) 2005 Stelian Pop (stelian@popies.net)
+ *
+ * Clean room implementation based on the reverse engineered OSX driver by
+ * Johannes Berg <johannes@sipsolutions.net>, documentation available at
+ * http://johannes.sipsolutions.net/PowerBook/Apple_Motion_Sensor_Specification
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
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
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/kthread.h>
+
+#include <asm/of_device.h>
+#include <asm/pmac_feature.h>
+
+MODULE_DESCRIPTION("Apple Motion Sensor driver");
+MODULE_AUTHOR("Stelian Pop");
+MODULE_LICENSE("GPL");
+
+static unsigned int mouse;
+module_param(mouse, bool, 0);
+MODULE_PARM_DESC(mouse, "enable the input class device on module load");
+
+/* AMS registers */
+#define	AMS_COMMAND	0x00	/* command register */
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
+enum ams_cmd {
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
+struct ams {
+	char			init;		/* has it been initialized ? */
+	int			bus;		/* i2c bus */
+	int			address;	/* i2c address */
+	struct i2c_client	client;		/* i2c client */
+	struct of_device	*of_dev;	/* sysfs device */
+	char			vflag;		/* use orient1 or orient2 ? */
+	u32			orient1;	/* orientation words */
+	u32			orient2;
+	int			irq1;		/* first irq line */
+	int			irq2;		/* second irq line */
+	struct work_struct	worker;		/* worker thread */
+	struct input_dev	*idev;		/* input device */
+	int			xcalib;		/* calibrated null value for x */
+	int			ycalib;		/* calibrated null value for y */
+	int			zcalib;		/* calibrated null value for z */
+	struct mutex		input_mutex;
+	struct task_struct	*kthread;	/* kthread for input */
+};
+
+static struct ams ams;
+
+static int ams_attach(struct i2c_adapter *adapter);
+static int ams_detach(struct i2c_adapter *adapter);
+
+static struct i2c_driver ams_driver = {
+	.driver = {
+		.name	= "ams",
+		.owner	= THIS_MODULE,
+	},
+	.attach_adapter	= ams_attach,
+	.detach_adapter	= ams_detach,
+};
+
+static inline s32 ams_read(u8 reg)
+{
+	return i2c_smbus_read_byte_data(&ams.client, reg);
+}
+
+static inline int ams_write(u8 reg, u8 value)
+{
+	return i2c_smbus_write_byte_data(&ams.client, reg, value);
+}
+
+static int ams_cmd(enum ams_cmd cmd)
+{
+	s32 result;
+	int i;
+
+	ams_write(AMS_COMMAND, cmd);
+	for (i = 0; i < 10; i++) {
+		mdelay(5);
+		result = ams_read(AMS_COMMAND);
+		if (result == 0 || result & 0x80)
+			return 0;
+	}
+	return -1;
+}
+
+static void ams_sensors(s8 *x, s8 *y, s8 *z)
+{
+	u32 orient;
+
+	*x = ams_read(AMS_DATAX);
+	*y = ams_read(AMS_DATAY);
+	*z = ams_read(AMS_DATAZ);
+
+	orient = ams.vflag ? ams.orient2 : ams.orient1;
+	if (orient & 0x80) {
+		s8 tmp = *x;
+		*x = *y;
+		*y = tmp;
+	}
+	if (orient & 0x04)
+		*z = ~*z;
+	if (orient & 0x02)
+		*y = ~*y;
+	if (orient & 0x01)
+		*x = ~*x;
+
+	/* printk(KERN_DEBUG "ams: Sensors (%d, %d, %d)\n", *x, *y, *z); */
+}
+
+static ssize_t ams_show_x(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	int retval;
+	s8 x, y, z;
+
+	ams_sensors(&x, &y, &z);
+	retval = snprintf(buf, PAGE_SIZE, "%d\n", x);
+	return retval;
+}
+static DEVICE_ATTR(x, S_IRUGO, ams_show_x, NULL);
+
+static ssize_t ams_show_y(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	int retval;
+	s8 x, y, z;
+
+	ams_sensors(&x, &y, &z);
+	retval = snprintf(buf, PAGE_SIZE, "%d\n", y);
+	return retval;
+}
+static DEVICE_ATTR(y, S_IRUGO, ams_show_y, NULL);
+
+static ssize_t ams_show_z(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	int retval;
+	s8 x, y, z;
+
+	ams_sensors(&x, &y, &z);
+	retval = snprintf(buf, PAGE_SIZE, "%d\n", z);
+	return retval;
+}
+
+static DEVICE_ATTR(z, S_IRUGO, ams_show_z, NULL);
+
+static int ams_mouse_kthread(void *data)
+{
+	s8 x, y, z;
+
+	while (!kthread_should_stop()) {
+		ams_sensors(&x, &y, &z);
+
+		input_report_abs(ams.idev, ABS_X, x - ams.xcalib);
+		input_report_abs(ams.idev, ABS_Y, y - ams.ycalib);
+		input_report_abs(ams.idev, ABS_Z, z - ams.zcalib);
+
+		input_sync(ams.idev);
+
+		msleep(25);
+	}
+	return 0;
+}
+
+static void ams_mouse_enable(void)
+{
+	s8 x, y, z;
+
+	mutex_lock(&ams.input_mutex);
+
+	if (ams.idev)
+		goto out;
+
+	ams_sensors(&x, &y, &z);
+	ams.xcalib = x;
+	ams.ycalib = y;
+	ams.zcalib = z;
+
+	ams.idev = input_allocate_device();
+	if (!ams.idev)
+		goto out;
+
+	ams.idev->name = "Apple Motion Sensor";
+	ams.idev->id.bustype = BUS_I2C;
+	ams.idev->id.vendor = 0;
+
+	input_set_abs_params(ams.idev, ABS_X, -50, 50, 3, 0);
+	input_set_abs_params(ams.idev, ABS_Y, -50, 50, 3, 0);
+	input_set_abs_params(ams.idev, ABS_Z, -50, 50, 3, 0);
+
+	set_bit(EV_ABS, ams.idev->evbit);
+	set_bit(EV_KEY, ams.idev->evbit);
+	set_bit(BTN_TOUCH, ams.idev->keybit);
+
+	if (input_register_device(ams.idev)) {
+		input_free_device(ams.idev);
+		ams.idev = NULL;
+		goto out;
+	}
+
+	ams.kthread = kthread_run(ams_mouse_kthread, NULL, "kams");
+	if (IS_ERR(ams.kthread)) {
+		input_unregister_device(ams.idev);
+		ams.idev = NULL;
+		goto out;
+	}
+out:
+	mutex_unlock(&ams.input_mutex);
+}
+
+static void ams_mouse_disable(void)
+{
+	mutex_lock(&ams.input_mutex);
+
+	if (!ams.idev)
+		goto out;
+
+	kthread_stop(ams.kthread);
+
+	input_unregister_device(ams.idev);
+
+	ams.idev = NULL;
+out:
+	mutex_unlock(&ams.input_mutex);
+}
+
+static ssize_t ams_show_mouse(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	return sprintf(buf, "%d\n", mouse);
+}
+
+static ssize_t ams_store_mouse(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	if (sscanf(buf, "%d\n", &mouse) != 1)
+		return -EINVAL;
+
+	mouse = !!mouse;
+
+	if (mouse)
+		ams_mouse_enable();
+	else
+		ams_mouse_disable();
+
+	return count;
+}
+static DEVICE_ATTR(mouse, S_IRUGO | S_IWUSR, ams_show_mouse, ams_store_mouse);
+
+static void ams_worker(void *data)
+{
+	/* TODO: park hard disk drives like OSX ? */
+	if (ams_read(AMS_FREEFALL) & 0x80)
+		printk(KERN_INFO "ams: freefall interrupt\n");
+	if (ams_read(AMS_SHOCK) & 0x80)
+		printk(KERN_INFO "ams: shock interrupt\n");
+
+	ams_write(AMS_FREEFALL, 0);
+	ams_write(AMS_SHOCK, 0);
+}
+
+static irqreturn_t ams_interrupt(int irq, void *devid, struct pt_regs *regs)
+{
+	if (ams.init)
+		schedule_work(&ams.worker);
+	return IRQ_HANDLED;
+}
+
+static int ams_attach(struct i2c_adapter *adapter)
+{
+	int vmaj, vmin;
+	unsigned long bus;
+
+	if (ams.init)
+		return 0;
+
+	if (strncmp(adapter->name, "uni-n", 5))
+		return -ENODEV;
+	bus = simple_strtoul(adapter->name + 6, NULL, 10);
+	if (bus != ams.bus)
+		return -ENODEV;
+
+	ams.client.addr = ams.address;
+	ams.client.adapter = adapter;
+	ams.client.driver = &ams_driver;
+	strcpy(ams.client.name, "Apple Motion Sensor");
+
+	if (ams_cmd(AMS_CMD_RESET)) {
+		printk(KERN_INFO "ams: Failed to reset the device\n");
+		return -ENODEV;
+	}
+
+	if (ams_cmd(AMS_CMD_START)) {
+		printk(KERN_INFO "ams: Failed to start the device\n");
+		return -ENODEV;
+	}
+
+	/* get version/vendor information */
+	ams_write(AMS_CTRL1, 0x02);
+	ams_write(AMS_CTRL2, 0x85);
+	ams_write(AMS_CTRL3, 0x01);
+
+	ams_cmd(AMS_CMD_READMEM);
+
+	vmaj = ams_read(AMS_DATA1);
+	vmin = ams_read(AMS_DATA2);
+	if (vmaj != 1 || vmin != 52) {
+		printk(KERN_INFO "ams: Incorrect device version (%d.%d)\n",
+		       vmaj, vmin);
+		return -ENODEV;
+	}
+
+	ams_cmd(AMS_CMD_VERSION);
+
+	vmaj = ams_read(AMS_DATA1);
+	vmin = ams_read(AMS_DATA2);
+	if (vmaj != 0 || vmin != 1) {
+		printk(KERN_INFO "ams: Incorrect firmware version (%d.%d)\n",
+		       vmaj, vmin);
+		return -ENODEV;
+	}
+
+	if (ams_read(AMS_VENDOR) & 0x10)
+		ams.vflag = 1;
+
+	/* write initial values */
+	ams_write(AMS_SENSLOW, 0x15);
+	ams_write(AMS_SENSHIGH, 0x60);
+	ams_write(AMS_CTRLX, 0x08);
+	ams_write(AMS_CTRLY, 0x0F);
+	ams_write(AMS_CTRLZ, 0x4F);
+	ams_write(AMS_UNKNOWN1, 0x14);
+
+	ams_write(AMS_FREEFALL, 0);
+	ams_write(AMS_SHOCK, 0);
+
+	/* enable interrupts */
+	ams_write(AMS_CTRLX, 0x88);
+	ams_write(AMS_CTRLY, 0x8F);
+	ams_write(AMS_CTRLZ, 0xCF);
+
+	if (i2c_attach_client(&ams.client)) {
+		printk(KERN_INFO "ams: Failed to attach the client\n");
+		return -ENODEV;
+	}
+
+	if (mouse)
+		ams_mouse_enable();
+
+	ams.init = 1;
+
+	printk(KERN_INFO "ams: Apple Motion Sensor enabled\n");
+
+	return 0;
+}
+
+static int ams_detach(struct i2c_adapter *adapter)
+{
+	if (!ams.init)
+		return 0;
+
+	if (ams.idev)
+		ams_mouse_disable();
+
+	i2c_detach_client(&ams.client);
+
+	/* disable and ack interrupts */
+	ams_write(AMS_CTRLX, 0x08);
+	ams_write(AMS_CTRLY, 0x0F);
+	ams_write(AMS_CTRLZ, 0x4F);
+	ams_write(AMS_FREEFALL, 0);
+	ams_write(AMS_SHOCK, 0);
+
+	ams.init = 0;
+
+	printk(KERN_INFO "ams: Apple Motion Sensor disabled\n");
+
+	return 0;
+}
+
+static int __init ams_init(void)
+{
+	struct device_node* np;
+	u32 *prop;
+	int retval = -ENODEV;
+
+	np = of_find_node_by_name(NULL, "accelerometer");
+	if (!np)
+		goto out;
+	if (!device_is_compatible(np, "AAPL,accelerometer_1"))
+		goto out;
+
+	prop = (u32 *)get_property(np, "orientation", NULL);
+	if (!prop) {
+		retval = -EIO;
+		goto out;
+	}
+	ams.orient1 = *prop;
+	ams.orient2 = *(prop + 1);
+
+	prop = (u32 *)get_property(np, "reg", NULL);
+	if (!prop)
+		goto out;
+
+	/* look for bus either by path or using "reg" */
+	if (strstr(np->full_name, "/i2c-bus@") != NULL) {
+		const char *tmp_bus = (strstr(np->full_name, "/i2c-bus@") + 9);
+		ams.bus = tmp_bus[0]-'0';
+	} else {
+		ams.bus = ((*prop) >> 8) & 0x0f;
+	}
+	ams.address = ((*prop) & 0xff) >> 1;
+
+	np = of_find_node_by_name(NULL, "accelerometer-1");
+	if (!np || np->n_intrs < 1)
+		goto out;
+
+	ams.irq1 = np->intrs[0].line;
+
+	np = of_find_node_by_name(NULL, "accelerometer-2");
+	if (!np || np->n_intrs < 1)
+		goto out;
+
+	ams.irq2 = np->intrs[0].line;
+
+	if (request_irq(ams.irq1, ams_interrupt, 0, "accelerometer-1",
+			NULL < 0))
+		goto out;
+
+	if (request_irq(ams.irq2, ams_interrupt, 0, "accelerometer-2",
+			NULL < 0))
+		goto free_irq1;
+
+	INIT_WORK(&ams.worker, ams_worker, NULL);
+
+	if ((ams.of_dev = of_platform_device_create(np, "ams", NULL)) == NULL)
+		goto free_irq2;
+
+	mutex_init(&ams.input_mutex);
+
+	device_create_file(&ams.of_dev->dev, &dev_attr_x);
+	device_create_file(&ams.of_dev->dev, &dev_attr_y);
+	device_create_file(&ams.of_dev->dev, &dev_attr_z);
+	device_create_file(&ams.of_dev->dev, &dev_attr_mouse);
+
+	if (i2c_add_driver(&ams_driver) < 0)
+		goto free_device_files;
+
+	return 0;
+
+free_device_files:
+	device_remove_file(&ams.of_dev->dev, &dev_attr_x);
+	device_remove_file(&ams.of_dev->dev, &dev_attr_y);
+	device_remove_file(&ams.of_dev->dev, &dev_attr_z);
+	device_remove_file(&ams.of_dev->dev, &dev_attr_mouse);
+	mutex_destroy(&ams.input_mutex);
+free_irq2:
+	free_irq(ams.irq2, NULL);
+free_irq1:
+	free_irq(ams.irq1, NULL);
+out:
+	return retval;
+}
+
+static void __exit ams_exit(void)
+{
+	i2c_del_driver(&ams_driver);
+
+	free_irq(ams.irq1, NULL);
+	free_irq(ams.irq2, NULL);
+
+	device_remove_file(&ams.of_dev->dev, &dev_attr_x);
+	device_remove_file(&ams.of_dev->dev, &dev_attr_y);
+	device_remove_file(&ams.of_dev->dev, &dev_attr_z);
+	device_remove_file(&ams.of_dev->dev, &dev_attr_mouse);
+
+	mutex_destroy(&ams.input_mutex);
+
+	of_device_unregister(ams.of_dev);
+}
+
+module_init(ams_init);
+module_exit(ams_exit);
diff -puN drivers/hwmon/Kconfig~apple-motion-sensor-driver drivers/hwmon/Kconfig
--- a/drivers/hwmon/Kconfig~apple-motion-sensor-driver
+++ a/drivers/hwmon/Kconfig
@@ -507,6 +507,23 @@ config SENSORS_HDAPS
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of hdaps.
 
+config SENSORS_AMS
+	tristate "Apple Motion Sensor (ams)"
+	depends on HWMON && INPUT && PPC32
+	default n
+	help
+	  This driver provides support for the Apple Motion Sensor (ams),
+	  which provides an accelerometer and other misc. data.
+	  Some Apple PowerBooks (the series the PowerBook5,6 falls into,
+	  later ones have a slightly different one the driver doesn't handle)
+	  are supported. The accelerometer data is readable via sysfs.
+
+	  This driver also provides an absolute input class device, allowing
+	  the laptop to act as a pinball machine-esque joystick.
+
+	  Say Y here if you have an applicable laptop and want to experience
+	  the awesome power of ams.
+
 config HWMON_DEBUG_CHIP
 	bool "Hardware Monitoring Chip debugging messages"
 	depends on HWMON
diff -puN drivers/hwmon/Makefile~apple-motion-sensor-driver drivers/hwmon/Makefile
--- a/drivers/hwmon/Makefile~apple-motion-sensor-driver
+++ a/drivers/hwmon/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025
 obj-$(CONFIG_SENSORS_ADM1026)	+= adm1026.o
 obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
 obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
+obj-$(CONFIG_SENSORS_AMS)	+= ams.o
 obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
 obj-$(CONFIG_SENSORS_F71805F)	+= f71805f.o
_

