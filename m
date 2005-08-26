Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbVHZPSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbVHZPSR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 11:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbVHZPSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 11:18:17 -0400
Received: from peabody.ximian.com ([130.57.169.10]:64956 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S965073AbVHZPSQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 11:18:16 -0400
Subject: [patch] IBM HDAPS accelerometer driver.
From: Robert Love <rml@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 11:18:14 -0400
Message-Id: <1125069494.18155.27.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Of late I have been working on a driver for the IBM Hard Drive Active
Protection System (HDAPS), which provides a two-axis accelerometer and
some other misc. data.  The hardware is found on recent IBM ThinkPad
laptops.

The following patch adds the driver to 2.6.13-rc6-mm2.  It is
self-contained and fairly simple.

Please, apply.

	Robert Love


Driver for the IBM HDAPS, an accelerometer

Signed-off-by: Robert Love <rml@novell.com>

 MAINTAINERS            |    7 
 drivers/hwmon/Kconfig  |   17 +
 drivers/hwmon/Makefile |    1 
 drivers/hwmon/hdaps.c  |  594 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 619 insertions(+)

diff -urN linux-2.6.13-rc6-mm2/drivers/hwmon/hdaps.c linux/drivers/hwmon/hdaps.c
--- linux-2.6.13-rc6-mm2/drivers/hwmon/hdaps.c	1969-12-31 19:00:00.000000000 -0500
+++ linux/drivers/hwmon/hdaps.c	2005-08-26 11:07:53.000000000 -0400
@@ -0,0 +1,594 @@
+/*
+ * drivers/hwmon/hdaps.c - driver for IBM's Hard Drive Active Protection System
+ *
+ * Copyright (C) 2005 Robert Love <rml@novell.com> 
+ * Copyright (C) 2005 Jesper Juhl <jesper.juhl@gmail.com> 
+ *
+ * The HardDisk Active Protection System (hdaps) is present in the IBM ThinkPad
+ * T41, T42, T43, and R51, at least.  It provides a basic two-axis
+ * accelerometer and other misc. data.
+ *
+ * Based on the document by Mark A. Smith available at
+ * http://www.almaden.ibm.com/cs/people/marksmith/tpaps.html and a lot of trial
+ * and error.
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
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/timer.h>
+#include <linux/spinlock.h>
+#include <asm/io.h>
+
+#define HDAPS_LOW_PORT		0x1600	/* first port used by accelerometer */
+#define HDAPS_NR_PORTS		0x30	/* number of ports (0x1600 - 0x162f) */
+
+#define STATE_FRESH		0x50	/* accelerometer data is fresh */
+
+#define REFRESH_ASYNC		0x00	/* do asynchronous refresh */
+#define REFRESH_SYNC		0x01	/* do synchronous refresh */
+
+#define HDAPS_PORT_STATE	0x1611	/* device state */
+#define	HDAPS_PORT_XPOS		0x1612	/* x-axis position */
+#define HDAPS_PORT_YPOS		0x1614	/* y-axis position */
+#define HDAPS_PORT_TEMP		0x1616	/* device temperature, in celcius */
+#define HDAPS_PORT_XVAR		0x1617	/* x-axis variance (what is this?) */
+#define HDAPS_PORT_YVAR		0x1619	/* y-axis variance (what is this?) */
+#define HDAPS_PORT_TEMP2	0x161b	/* device temperature (again?) */
+#define HDAPS_PORT_UNKNOWN	0x161c	/* what is this? */
+#define HDAPS_PORT_KMACT	0x161d	/* keyboard or mouse activity */
+
+#define HDAPS_READ_MASK		0xff	/* some reads have the low 8 bits set */
+
+#define KEYBD_MASK		0x20	/* set if keyboard activity */
+#define MOUSE_MASK		0x40	/* set if mouse activity */
+
+#define KEYBD_ISSET(n)	(!! (n & KEYBD_MASK))
+#define MOUSE_ISSET(n)	(!! (n & MOUSE_MASK))
+
+static spinlock_t hdaps_lock = SPIN_LOCK_UNLOCKED;
+
+
+/*
+ * __get_latch - Get the value from a given port latch.  Callers must hold
+ * hdaps_lock.
+ */
+static inline unsigned short __get_latch(unsigned short port)
+{
+	return inb(port) & HDAPS_READ_MASK;
+}
+
+/*
+ * __check_latch - Check a port latch for a given value.  Callers must hold
+ * hdaps_lock.
+ */
+static inline unsigned int __check_latch(unsigned short port, unsigned char val)
+{
+	if (__get_latch(port) == val)
+		return 1;
+	return 0;
+}
+
+/*
+ * __wait_latch - Wait up to 100us for a port latch to get a certain value,
+ * returning nonzero if the value is obtained and zero otherwise.  Callers
+ * must hold hdaps_lock.
+ */
+static unsigned int __wait_latch(unsigned short port, unsigned char val)
+{
+	unsigned int i;
+
+	for (i = 0; i < 20; i++) {
+		if (__check_latch(port, val))
+			return 1;
+		udelay(5);
+	}
+
+#if 0
+	printk(KERN_WARNING "hdaps: wait on %04x returned %02x, not %02x!\n",
+	       port, __check_latch(port, val), val);
+#endif
+
+	return 0;
+}
+
+/*
+ * __request_refresh - Request a refresh from the accelerometer.
+ *
+ * If sync is REFRESH_SYNC, we perform a synchronous refresh and will wait for
+ * the refresh.  Returns nonzero if successful or zero on error.
+ *
+ * If sync is REFRESH_ASYNC, we merely kick off a new refresh if the device is
+ * not up-to-date.  Always returns true.  On the next read from the device, the
+ * data should be up-to-date but a synchronous wait should be performed to be
+ * sure.
+ * 
+ * Callers must hold hdaps_lock.
+ */
+static int __request_refresh(int sync)
+{
+	unsigned char state;
+
+	state = inb(0x1604);
+	if (state == STATE_FRESH)
+		return 1;
+	else {
+		outb(0x11, 0x1610);
+		outb(0x01, 0x161f);
+		if (sync == REFRESH_ASYNC)
+			return 1;
+	}
+
+	return __wait_latch(0x1604, STATE_FRESH);
+}
+
+/*
+ * __tell_accelerometer_done - Indicate to the accelerometer that we are done
+ * reading data.  Callers must hold hdaps_lock.
+ */
+static inline void __tell_accelerometer_done(void)
+{
+	inb(0x161f);
+	inb(0x1604);
+}
+
+/* internal lockless helper for accelerometer_readb_one */
+static int __accelerometer_readb_one(unsigned int port, u8 *val)
+{
+	int ret = 0;
+
+	/* do a sync refresh - we need to be sure we read fresh data */
+	if (unlikely(!__request_refresh(REFRESH_SYNC))) {
+		ret = -EIO;
+		goto out;
+	}
+
+	*val = inb(port);
+
+	__tell_accelerometer_done();
+
+	if (unlikely(!__request_refresh(REFRESH_ASYNC)))
+		ret = -EIO;
+
+out:
+	return ret;
+}
+
+/*
+ * accelerometer_readb_one - reads a byte from a single given I/O port,
+ * placing the value in the given pointer.  Returns zero on success or a
+ * negative error on failure.
+ */
+static int accelerometer_readb_one(unsigned int port, u8 *val)
+{
+	int ret = 0;
+
+	spin_lock(&hdaps_lock);
+	ret = __accelerometer_readb_one(port, val);
+	spin_unlock(&hdaps_lock);
+	return ret;
+}
+
+/*
+ * accelerometer_read_pair - reads the values from a given pair of I/O ports,
+ * placing the values in the given pointers.  Returns zero on success or a
+ * negative error on failure.
+ */
+static int accelerometer_read_pair(unsigned int port1, unsigned int port2,
+				   int *val1, int *val2)
+{
+	int ret = 0;
+
+	spin_lock(&hdaps_lock);
+
+	/* do a sync refresh - we need to be sure we read fresh data */
+	if (unlikely(!__request_refresh(REFRESH_SYNC))) {
+		ret = -EIO;
+		goto out;
+	}
+
+	*val1 = inw(port1);
+	*val2 = inw(port2);
+
+	__tell_accelerometer_done();
+
+	if (unlikely(!__request_refresh(REFRESH_ASYNC)))
+		ret = -EIO;
+
+out:
+	spin_unlock(&hdaps_lock);
+	return ret;
+}
+
+#define INIT_TIMEOUT_MSECS	4000	/* wait up to 4s for device init ... */
+#define INIT_WAIT_MSECS		200	/* ... in 200ms increments */
+
+/* initialize the accelerometer */
+static int accelerometer_init(void)
+{
+	unsigned int total_msecs = INIT_TIMEOUT_MSECS;
+	unsigned int msecs_per_wait = INIT_WAIT_MSECS;
+	int ret = -EIO;
+
+	spin_lock(&hdaps_lock);
+
+	outb(0x13, 0x1610);
+	outb(0x01, 0x161f);
+	if (unlikely(!__wait_latch(0x161f, 0x00)))
+		goto out;
+
+	/*
+	 * The 0x3 value appears to only work on some thinkpads, such as the
+	 * T42p.  Others return 0x1.
+	 *
+	 * The 0x2 value occurs when the chip has been previously initialized.
+	 */	
+	if (unlikely(!__check_latch(0x1611, 0x03) &&
+			!__check_latch(0x1611, 0x02) &&
+		    	!__check_latch(0x1611, 0x01)))
+		goto out;
+
+	printk(KERN_DEBUG "hdaps: initial latch check good (0x%02x)\n",
+	       __get_latch(0x1611));
+
+	outb(0x17, 0x1610);
+	outb(0x81, 0x1611);
+	outb(0x01, 0x161f);
+	if (unlikely(!__wait_latch(0x161f, 0x00)))
+		goto out;
+	if (unlikely(!__wait_latch(0x1611, 0x00)))
+		goto out;
+	if (unlikely(!__wait_latch(0x1612, 0x60)))
+		goto out;
+	if (unlikely(!__wait_latch(0x1613, 0x00)))
+		goto out;
+	outb(0x14, 0x1610);
+	outb(0x01, 0x1611);
+	outb(0x01, 0x161f);
+	if (unlikely(!__wait_latch(0x161f, 0x00)))
+		goto out;
+	outb(0x10, 0x1610);
+	outb(0xc8, 0x1611);
+	outb(0x00, 0x1612);
+	outb(0x02, 0x1613);
+	outb(0x01, 0x161f);
+	if (unlikely(!__wait_latch(0x161f, 0x00)))
+		goto out;
+	if (unlikely(!__request_refresh(REFRESH_SYNC)))
+		goto out;
+	if (unlikely(!__wait_latch(0x1611, 0x00)))
+		goto out;
+
+	/* we have done our dance, now let's wait for the applause */
+	ret = -ENXIO;
+	while (total_msecs > 0) {
+		u8 ignored;
+
+		/* a read of the device helps push it into action */
+		__accelerometer_readb_one(HDAPS_PORT_TEMP2, &ignored);
+		if (__wait_latch(0x1611, 0x02)) {
+			ret = 0;
+			break;
+		}
+		spin_unlock(&hdaps_lock);
+
+		msleep(msecs_per_wait);
+		total_msecs -= msecs_per_wait;
+
+		spin_lock(&hdaps_lock);
+	}
+
+out:
+	spin_unlock(&hdaps_lock);
+	return ret;
+}
+
+
+/* device class stuff */
+
+static DECLARE_COMPLETION(hdaps_obj_is_free);
+static void hdaps_release_dev(struct device *dev)
+{
+	complete(&hdaps_obj_is_free);
+}
+
+static int hdaps_resume(struct device* dev, u32 level)
+{
+	return accelerometer_init();
+}
+
+static struct device_driver hdaps_driver = {
+	.owner = THIS_MODULE,
+	.name = "hdaps",
+	.bus = &platform_bus_type,
+	.resume = hdaps_resume,
+};
+
+struct platform_device hdaps_plat_dev = {
+	.name = "hdaps",
+	.id = -1,
+	.dev = {
+		.release = hdaps_release_dev,
+		.driver = &hdaps_driver,
+	}
+};
+
+
+/* Input device stuff */
+
+static struct input_dev hdaps_idev;
+static struct timer_list hdaps_poll_timer;
+static unsigned int hdaps_mousedev_threshold = 4;
+static unsigned long hdaps_poll_ms = 25;
+static int hdaps_mousedev_registered;
+static u16 rest_x;
+static u16 rest_y;
+
+static void hdaps_calibrate(void)
+{
+	int x, y, ret;
+
+	ret = accelerometer_read_pair(HDAPS_PORT_XPOS, HDAPS_PORT_YPOS, &x, &y);
+	if (unlikely(ret))
+		return;
+
+	rest_x = x;
+	rest_y = y;
+}
+
+static void hdaps_mousedev_poll(unsigned long unused)
+{
+	int movex, movey, x, y, ret;
+
+	ret = accelerometer_read_pair(HDAPS_PORT_XPOS, HDAPS_PORT_YPOS, &x, &y);
+	if (unlikely(ret))
+		return;
+
+	movex = rest_x - x;
+	movey = rest_y - y;
+	if (abs(movex) > hdaps_mousedev_threshold)
+		input_report_rel(&hdaps_idev, REL_Y, movex);
+	if (abs(movey) > hdaps_mousedev_threshold)
+		input_report_rel(&hdaps_idev, REL_X, movey);
+	input_sync(&hdaps_idev);
+
+	mod_timer(&hdaps_poll_timer, jiffies + msecs_to_jiffies(hdaps_poll_ms));
+}
+
+static void hdaps_mousedev_enable(void)
+{
+	/* calibrate the device before enabling */
+	hdaps_calibrate();
+
+	init_input_dev(&hdaps_idev);
+	hdaps_idev.dev = &hdaps_plat_dev.dev;	
+	hdaps_idev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
+	hdaps_idev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
+	hdaps_idev.keybit[LONG(BTN_LEFT)] = BIT(BTN_LEFT);
+	input_register_device(&hdaps_idev);
+
+	hdaps_mousedev_registered = 1;
+
+	init_timer(&hdaps_poll_timer);
+	hdaps_poll_timer.function = hdaps_mousedev_poll;
+	hdaps_poll_timer.expires = jiffies + msecs_to_jiffies(hdaps_poll_ms);
+	add_timer(&hdaps_poll_timer);
+
+	printk(KERN_INFO "hdaps: input device enabled\n");
+}
+
+static void hdaps_mousedev_disable(void)
+{
+	if (!hdaps_mousedev_registered)
+		return;
+
+	del_timer_sync(&hdaps_poll_timer);
+	input_unregister_device(&hdaps_idev);
+}
+
+
+/* Sysfs Files */
+
+static ssize_t hdaps_position_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	int ret, x, y;
+
+	ret = accelerometer_read_pair(HDAPS_PORT_XPOS, HDAPS_PORT_YPOS, &x, &y);
+	if (unlikely(ret))
+		return ret;
+
+	return sprintf(buf, "(%d,%d)\n", x, y);
+}
+static DEVICE_ATTR(position, 0444, hdaps_position_show, NULL);
+
+static ssize_t hdaps_variance_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	int ret, x, y;
+
+	ret = accelerometer_read_pair(HDAPS_PORT_XVAR, HDAPS_PORT_YVAR, &x, &y);
+	if (unlikely(ret))
+		return ret;
+
+	return sprintf(buf, "(%d,%d)\n", x, y);
+}
+static DEVICE_ATTR(variance, 0444, hdaps_variance_show, NULL);
+
+static ssize_t hdaps_temp_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	u8 temp;
+	int ret;
+
+	ret = accelerometer_readb_one(HDAPS_PORT_TEMP, &temp);
+	if (unlikely(ret < 0))
+		return ret;
+
+	return sprintf(buf, "%u\n", temp);
+}
+static DEVICE_ATTR(temp, 0444, hdaps_temp_show, NULL);
+
+static ssize_t hdaps_mousedev_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", hdaps_mousedev_registered);
+}
+
+static ssize_t hdaps_mousedev_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	int enable;
+
+	if (sscanf(buf, "%d\n", &enable) != 1)
+		return -EINVAL;
+
+	if (enable == 1)
+		hdaps_mousedev_enable();
+	else if (enable == 0)
+		hdaps_mousedev_disable();
+
+	return count;
+}
+
+static DEVICE_ATTR(mousedev, 0644, hdaps_mousedev_show, hdaps_mousedev_store);
+
+static ssize_t hdaps_calibrate_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	hdaps_calibrate();
+	return count;
+}
+static DEVICE_ATTR(calibrate, 0200, NULL, hdaps_calibrate_store);
+
+static ssize_t hdaps_threshold_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", hdaps_mousedev_threshold);
+}
+
+static ssize_t hdaps_threshold_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	unsigned int threshold;
+
+	if (sscanf(buf, "%u\n", &threshold) != 1 || threshold == 0)
+		return -EINVAL;
+	hdaps_mousedev_threshold = threshold;
+
+	return count;
+}
+
+static DEVICE_ATTR(mousedev_threshold, 0644, hdaps_threshold_show,
+		   hdaps_threshold_store);
+
+static ssize_t hdaps_poll_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lu\n", hdaps_poll_ms);
+}
+
+static ssize_t hdaps_poll_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	unsigned int poll;
+
+	if (sscanf(buf, "%u\n", &poll) != 1 || poll == 0)
+		return -EINVAL;
+	hdaps_poll_ms = poll;
+
+	return count;
+}
+
+static DEVICE_ATTR(mousedev_poll_ms, 0644, hdaps_poll_show, hdaps_poll_store);
+
+
+/* Module stuff */
+
+static unsigned int mousedev;
+module_param(mousedev, bool, 0);
+MODULE_PARM_DESC(mousedev, "enable the input class device on module load");
+
+static int __init hdaps_init(void)
+{
+	int ret;
+
+	if (unlikely(!request_region(HDAPS_LOW_PORT, HDAPS_NR_PORTS, "hdaps")))
+		return -ENXIO;
+
+	ret = accelerometer_init();
+	if (unlikely(ret))
+		goto out_release;
+
+	ret = driver_register(&hdaps_driver);
+	if (unlikely(ret))
+		goto out_release;
+
+	ret = platform_device_register(&hdaps_plat_dev);
+	if (unlikely(ret))
+		goto out_driver;
+
+	device_create_file(&hdaps_plat_dev.dev, &dev_attr_position);
+	device_create_file(&hdaps_plat_dev.dev, &dev_attr_variance);
+	device_create_file(&hdaps_plat_dev.dev, &dev_attr_temp);
+	device_create_file(&hdaps_plat_dev.dev, &dev_attr_calibrate);
+	device_create_file(&hdaps_plat_dev.dev, &dev_attr_mousedev);
+	device_create_file(&hdaps_plat_dev.dev, &dev_attr_mousedev_threshold);
+	device_create_file(&hdaps_plat_dev.dev, &dev_attr_mousedev_poll_ms);
+
+	if (mousedev)
+		hdaps_mousedev_enable();
+
+	printk(KERN_INFO "hdaps: initialized.\n");
+
+	return 0;
+
+out_driver:
+	driver_unregister(&hdaps_driver);
+out_release:
+	release_region(HDAPS_LOW_PORT, HDAPS_NR_PORTS);
+	printk(KERN_WARNING "hdaps: initilization failed! ret=%d\n", ret);
+	return ret;
+}
+
+static void __exit hdaps_exit(void)
+{
+	hdaps_mousedev_disable();
+
+	device_remove_file(&hdaps_plat_dev.dev, &dev_attr_mousedev_poll_ms);
+	device_remove_file(&hdaps_plat_dev.dev, &dev_attr_mousedev_threshold);
+	device_remove_file(&hdaps_plat_dev.dev, &dev_attr_mousedev);
+	device_remove_file(&hdaps_plat_dev.dev, &dev_attr_temp);
+	device_remove_file(&hdaps_plat_dev.dev, &dev_attr_calibrate);
+	device_remove_file(&hdaps_plat_dev.dev, &dev_attr_variance);
+	device_remove_file(&hdaps_plat_dev.dev, &dev_attr_position);
+	platform_device_unregister(&hdaps_plat_dev);
+	driver_unregister(&hdaps_driver);
+
+	release_region(HDAPS_LOW_PORT, HDAPS_NR_PORTS);
+}
+
+module_init(hdaps_init);
+module_exit(hdaps_exit);
+
+MODULE_LICENSE("GPL");
diff -urN linux-2.6.13-rc6-mm2/drivers/hwmon/Kconfig linux/drivers/hwmon/Kconfig
--- linux-2.6.13-rc6-mm2/drivers/hwmon/Kconfig	2005-08-26 11:06:49.000000000 -0400
+++ linux/drivers/hwmon/Kconfig	2005-08-26 11:07:53.000000000 -0400
@@ -411,6 +411,23 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83627ehf.
 
+config SENSORS_HDAPS
+	tristate "IBM Hard Drive Active Protection System (hdaps)"
+	depends on HWMON
+	default n
+	help
+	  This driver provides support for the IBM Hard Drive Active Protection
+	  System (hdaps), which provides an accelerometer and other misc. data.
+	  Supported laptops include the IBM ThinkPad T41, T42, T43, and R51.
+	  The accelerometer data is readable via sysfs.
+
+	  This driver also provides an input class device, allowing the
+	  laptop to act as a pinball machine-esque mouse.  This is off by
+	  default but enabled via sysfs or the module parameter "mousedev".
+	  
+	  Say Y here if you have an applicable laptop and want to experience
+	  the awesome power of hdaps.
+
 config HWMON_DEBUG_CHIP
 	bool "Hardware Monitoring Chip debugging messages"
 	depends on HWMON
diff -urN linux-2.6.13-rc6-mm2/drivers/hwmon/Makefile linux/drivers/hwmon/Makefile
--- linux-2.6.13-rc6-mm2/drivers/hwmon/Makefile	2005-08-26 11:06:50.000000000 -0400
+++ linux/drivers/hwmon/Makefile	2005-08-26 11:07:53.000000000 -0400
@@ -22,6 +22,7 @@
 obj-$(CONFIG_SENSORS_FSCPOS)	+= fscpos.o
 obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
 obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
+obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_LM63)	+= lm63.o
 obj-$(CONFIG_SENSORS_LM75)	+= lm75.o
diff -urN linux-2.6.13-rc6-mm2/MAINTAINERS linux/MAINTAINERS
--- linux-2.6.13-rc6-mm2/MAINTAINERS	2005-08-26 11:06:58.000000000 -0400
+++ linux/MAINTAINERS	2005-08-26 11:07:53.000000000 -0400
@@ -984,6 +984,13 @@
 W:	http://www.nyx.net/~arobinso
 S:	Maintained
 
+HDAPS
+P:	Robert Love
+M:	rlove@rlove.org
+M:	linux-kernel@vger.kernel.org
+W:	http://www.kernel.org/pub/linux/kernel/people/rml/hdaps/
+S:	Maintained
+
 HFS FILESYSTEM
 P:	Roman Zippel
 M:	zippel@linux-m68k.org


