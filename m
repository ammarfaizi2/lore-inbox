Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752432AbWKBTef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbWKBTef (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 14:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbWKBTef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 14:34:35 -0500
Received: from bay0-omc3-s29.bay0.hotmail.com ([65.54.246.229]:19232 "EHLO
	bay0-omc3-s29.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1752432AbWKBTed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 14:34:33 -0500
Message-ID: <BAY20-F183478C1EE742A94EEBD3CD8FF0@phx.gbl>
X-Originating-IP: [80.178.122.76]
X-Originating-Email: [yan_952@hotmail.com]
From: "Burman Yan" <yan_952@hotmail.com>
To: alan@lxorguk.ukuu.org.uk
Cc: arjan@infradead.org, davej@redhat.com, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, pazke@donpac.ru
Subject: Re: [PATCH] HP mobile data protection system driver
Date: Thu, 02 Nov 2006 21:34:29 +0200
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_6c0c_4449_3c7d"
X-OriginalArrivalTime: 02 Nov 2006 19:34:32.0809 (UTC) FILETIME=[EBF84590:01C6FEB5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_6c0c_4449_3c7d
Content-Type: text/plain; format=flowed

Hi.

I finally got 2.6.19-rc2 to work on my laptop and it apparently fixed a bug 
related
to MDPS's IRQ handling, so I was able to register the IRQ handler.
I created a newer version of my driver that can now act on interrupts
from the device instead of doing polling on the position that the 
accelerometer
reports.
I wrote an interface that is still compatible with hdapsd + made a misc
device that acts similar to /dev/rtc - I also wrote a user space daemon 
(it's very
easy now) that can print something like "your laptop is falling: press any 
key to catch it"
whenever I drop it 10-15 cm and catch it.

Attached is the patch that applies to 2.6.18 and 2.6.19-rc{2,3}.
I didn't inline the patch, since hotmail screws it up.

Any comments are welcome.

Also, should I send it perhaps to the hwmon maintainer as well?


>From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>To: Burman Yan <yan_952@hotmail.com>
>CC: arjan@infradead.org, davej@redhat.com, jesper.juhl@gmail.com,        
>linux-kernel@vger.kernel.org, pazke@donpac.ru
>Subject: Re: [PATCH] HP mobile data protection system driver
>Date: Fri, 13 Oct 2006 21:34:45 +0100
>
>Ar Gwe, 2006-10-13 am 20:59 +0200, ysgrifennodd Burman Yan:
> > I guess it may be a good idea after all to change the sysfs file it to 
>hdaps
> > for now.
>
>Perhaps it would be better to provide a new they all provide which
>indicates 2 v 3 dimensions and also provides a scaled data source so
>that you don't get confusion or have to adjust the daemon for each user.
>
>If HDAPS is an IBM^WLeonovo mark thats another reason the final generic
>file shouldn't be called HDAPS
>

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

------=_NextPart_000_6c0c_4449_3c7d
Content-Type: text/x-patch; name="mdps-0.4.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="mdps-0.4.patch"

HP Mobile Data Protection System 3D ACPI driver. Similar to hdaps in functionality.
This driver provides 4 kinds of functionality:
1) Creates a misc device /dev/acel that acts similar to /dev/rtc and unblocks
the process reading from it when the device detects free-fall interrupt
2) Functions as an input class device to provide similar functionality to
hdaps, in order to be able to use the laptop as a joystick
3) Provides an interface similar to hdaps, so that hdapsd could work with it
4) A misc character device similar in interface to /dev/rtc that reacts on
free fall interrupts received from the device.

For comments mail to: yan_952@hotmail.com

Signed-off-by: Yan Burman <yan_952@hotmail.com>

diff -Nrubp linux-2.6.18.orig/drivers/hwmon/Kconfig linux-2.6.18.mdps/drivers/hwmon/Kconfig
--- linux-2.6.18.orig/drivers/hwmon/Kconfig	2006-10-11 14:20:08.000000000 +0200
+++ linux-2.6.18.mdps/drivers/hwmon/Kconfig	2006-11-02 21:13:41.000000000 +0200
@@ -507,6 +507,26 @@ config SENSORS_HDAPS
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of hdaps.
 
+config SENSORS_MDPS
+        tristate "HP Mobile Data Protection System 3D (mdps)"
+        depends on ACPI && HWMON && INPUT && X86
+        default n
+        help
+          This driver provides support for the HP Mobile Data Protection 
+          System 3D (mdps), which is an accelerometer. Only HP nc6400 and nc6420
+          is supported right now, but it may work on other models as well.  The
+          accelerometer data is readable via /sys/devices/platform/mdps.
+
+          This driver also provides an absolute input class device, allowing
+          the laptop to act as a pinball machine-esque joystick.
+
+          Another feature of the driver is misc device called mdps that acts
+          similar to /dev/rtc and reacts on free-fall interrupts received from
+          the device.
+
+          This driver can also be built as a module.  If so, the module
+          will be called mdps.
+
 config HWMON_DEBUG_CHIP
 	bool "Hardware Monitoring Chip debugging messages"
 	depends on HWMON
diff -Nrubp linux-2.6.18.orig/drivers/hwmon/Makefile linux-2.6.18.mdps/drivers/hwmon/Makefile
--- linux-2.6.18.orig/drivers/hwmon/Makefile	2006-10-11 14:20:08.000000000 +0200
+++ linux-2.6.18.mdps/drivers/hwmon/Makefile	2006-10-13 10:14:10.000000000 +0200
@@ -26,6 +26,7 @@ obj-$(CONFIG_SENSORS_FSCPOS)	+= fscpos.o
 obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
 obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
 obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
+obj-$(CONFIG_SENSORS_MDPS)	+= mdps.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_LM63)	+= lm63.o
 obj-$(CONFIG_SENSORS_LM70)	+= lm70.o
diff -Nrubp linux-2.6.18.orig/drivers/hwmon/mdps.c linux-2.6.18.mdps/drivers/hwmon/mdps.c
--- linux-2.6.18.orig/drivers/hwmon/mdps.c	1970-01-01 02:00:00.000000000 +0200
+++ linux-2.6.18.mdps/drivers/hwmon/mdps.c	2006-11-02 21:11:13.000000000 +0200
@@ -0,0 +1,689 @@
+/*
+ *  mdps.c - HP Mobile Data Protection System 3D ACPI driver
+ *
+ *  Copyright (C) 2006 Yan Burman
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+#include <linux/completion.h>
+#include <linux/spinlock.h>
+#include <linux/miscdevice.h>
+
+#include <acpi/acpi_drivers.h>
+#include <acpi/acnamesp.h>
+
+#include <asm/uaccess.h>
+#include <asm/atomic.h>
+
+#define VERSION "0.4"
+
+#define DRIVER_NAME     "mdps"
+#define ACPI_MDPS_CLASS "accelerometer"
+#define ACPI_MDPS_ID    "HPQ0004"
+
+/* The actual chip is STMicroelectronics LIS3LV02DL or LIS3LV02DQ */
+
+#define MDPS_WHO_AM_I        0x0F /*r      00111010 */
+#define MDPS_OFFSET_X        0x16 /*rw              */
+#define MDPS_OFFSET_Y        0x17 /*rw              */
+#define MDPS_OFFSET_Z        0x18 /*rw              */
+#define MDPS_GAIN_X          0x19 /*rw              */
+#define MDPS_GAIN_Y          0x1A /*rw              */
+#define MDPS_GAIN_Z          0x1B /*rw              */
+#define MDPS_CTRL_REG1       0x20 /*rw     00000111 */
+#define MDPS_CTRL_REG2       0x21 /*rw     00000000 */
+#define MDPS_CTRL_REG3       0x22 /*rw     00001000 */
+#define MDPS_HP_FILTER RESET 0x23 /*r               */
+#define MDPS_STATUS_REG      0x27 /*rw     00000000 */
+#define MDPS_OUTX_L          0x28 /*r               */
+#define MDPS_OUTX_H          0x29 /*r               */
+#define MDPS_OUTY_L          0x2A /*r               */
+#define MDPS_OUTY_H          0x2B /*r               */
+#define MDPS_OUTZ_L          0x2C /*r               */
+#define MDPS_OUTZ_H          0x2D /*r               */
+#define MDPS_FF_WU_CFG       0x30 /*rw     00000000 */
+#define MDPS_FF_WU_SRC       0x31 /*rw     00000000 */
+#define MDPS_FF_WU_ACK       0x32 /*r               */
+#define MDPS_FF_WU_THS_L     0x34 /*rw     00000000 */
+#define MDPS_FF_WU_THS_H     0x35 /*rw     00000000 */
+#define MDPS_FF_WU_DURATION  0x36 /*rw     00000000 */
+#define MDPS_DD_CFG          0x38 /*rw     00000000 */
+#define MDPS_DD_SRC          0x39 /*rw     00000000 */
+#define MDPS_DD_ACK          0x3A /*r               */
+#define MDPS_DD_THSI_L       0x3C /*rw     00000000 */
+#define MDPS_DD_THSI_H       0x3D /*rw     00000000 */
+#define MDPS_DD_THSE_L       0x3E /*rw     00000000 */
+#define MDPS_DD_THSE_H       0x3F /*rw     00000000 */
+
+#define MDPS_ID 0x3A
+
+/* mouse device poll interval in milliseconds */
+#define MDPS_POLL_INTERVAL 30
+
+static unsigned int mouse = 0;
+module_param(mouse, bool, S_IRUGO);
+MODULE_PARM_DESC(mouse, "Enable the input class device on module load");
+
+static unsigned int power_off = 0;
+module_param(power_off, bool, S_IRUGO);
+MODULE_PARM_DESC(power_off, "Turn off device on module load");
+
+struct acpi_mdps
+{
+	struct acpi_device*     device;    /* The ACPI device */
+	u32                     irq;       /* IRQ number */
+	struct input_dev*       idev;      /* input device */
+	struct task_struct*     kthread;   /* kthread for input */
+	int                     xcalib;    /* calibrated null value for x */
+	int                     ycalib;    /* calibrated null value for y */
+	int                     is_on;     /* whether the device is on or off */
+	struct platform_device* pdev;      /* platform device */
+	atomic_t                count;     /* how many times we got interrupts after the last read */
+	struct completion       complete;  /* we wait on this in read */
+	int                     reader_waiting;
+};
+
+static atomic_t mdps_available = ATOMIC_INIT(1);
+
+static struct acpi_mdps mdps;
+
+static int mdps_add(struct acpi_device *device);
+static int mdps_remove(struct acpi_device *device, int type);
+static int mdps_suspend(struct acpi_device * device, int state);
+static int mdps_resume(struct acpi_device * device, int state);
+static int mdps_remove_fs(void);
+static int mdps_add_fs(struct acpi_device *device);
+static void mdps_mouse_enable(void);
+static void mdps_mouse_disable(void);
+
+static struct acpi_driver mdps_driver =
+{
+	.name  = DRIVER_NAME,
+	.class = ACPI_MDPS_CLASS,
+	.ids   = ACPI_MDPS_ID,
+	.ops = {
+		.add     = mdps_add,
+		.remove  = mdps_remove,
+#ifdef CONFIG_PM
+		.suspend = mdps_suspend,
+		.resume  = mdps_resume
+#endif
+	}
+};
+
+static DEFINE_SPINLOCK(mdps_lock);
+
+/** Create a single value from 2 bytes received from the accelerometer
+ * @param hi the high byte
+ * @param lo the low byte
+ * @return the resulting value
+ */
+static inline s16 mdps_glue_bytes(unsigned long hi, unsigned long lo)
+{
+	/* In "12 bit right justified" mode, bit 6, bit 7, bit 8 = bit 5 */
+	if (hi & 0x10)
+		hi |= 0xE0;
+	return (s16)(lo | ((hi << 8)));
+}
+
+static acpi_status read_acpi_int_param(acpi_handle handle, acpi_string method,
+                                       int val, unsigned long* ret)
+{
+	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
+	struct acpi_object_list args = { 1, &arg0 };
+
+	arg0.integer.value = val;
+
+	return acpi_evaluate_integer(handle, method, &args, ret);
+}
+
+/** ACPI _STA method: get device status
+ * @param handle the handle of the device
+ * @param[out] ret result of the operation
+ * @return AE_OK on success
+ */
+static inline acpi_status mdps__STA(acpi_handle handle, unsigned long* ret)
+{
+	return acpi_evaluate_integer(handle, METHOD_NAME__STA, NULL, ret);
+}
+
+/** ACPI ALRD method: read a register
+ * @param handle the handle of the device
+ * @param reg the register to read
+ * @param[out] ret result of the operation
+ * @return AE_OK on success
+ */
+static inline acpi_status mdps_ALRD(acpi_handle handle, int reg,
+                                    unsigned long* ret)
+{
+	return read_acpi_int_param(handle, "ALRD", reg, ret);
+}
+
+/** ACPI _INI method: initialize the device.
+ * @param handle the handle of the device
+ * @return 0 on success
+ */
+static inline acpi_status mdps__INI(acpi_handle handle)
+{
+	return acpi_evaluate_object(handle, METHOD_NAME__INI, NULL, NULL);
+}
+
+/** ACPI ALWR method: write to a register
+ * @param handle the handle of the device
+ * @param reg the register to write to
+ * @param val the value to write
+ * @param[out] ret result of the operation
+ * @return AE_OK on success
+ */
+static acpi_status mdps_ALWR(acpi_handle handle, int reg, int val,
+                             unsigned long* ret)
+{
+	union acpi_object in_obj[2];
+	struct acpi_object_list args;
+
+	args.count              = 2;
+	args.pointer            = in_obj;
+	in_obj[0].type          = ACPI_TYPE_INTEGER;
+	in_obj[0].integer.value = reg;
+	in_obj[1].type          = ACPI_TYPE_INTEGER;
+	in_obj[1].integer.value = val;
+
+	return acpi_evaluate_integer(handle, "ALWR", &args, ret);
+}
+
+static void mdps_get_xy(acpi_handle handle, int* x, int* y)
+{
+	unsigned long x_lo, x_hi, y_lo, y_hi;
+
+	mdps_ALRD(mdps.device->handle, MDPS_OUTX_L, &x_lo);
+	mdps_ALRD(mdps.device->handle, MDPS_OUTX_H, &x_hi);
+	mdps_ALRD(mdps.device->handle, MDPS_OUTY_L, &y_lo);
+	mdps_ALRD(mdps.device->handle, MDPS_OUTY_H, &y_hi);
+
+	*x = mdps_glue_bytes(x_hi, x_lo);
+	*y = mdps_glue_bytes(y_hi, y_lo);
+}
+
+/** Kthread polling function
+ * @param data unused - here to conform to threadfn prototype
+ * @return 0 unused - here to conform to threadfn prototype
+ */
+static int mdps_mouse_kthread(void *data)
+{
+	int x, y;
+
+	while (!kthread_should_stop()) {
+		mdps_get_xy(mdps.device->handle, &x, &y);
+
+		/* need to invert the X axis for this to look natural */
+		input_report_abs(mdps.idev, ABS_X, -(x - mdps.xcalib));
+		input_report_abs(mdps.idev, ABS_Y, y - mdps.ycalib);
+
+		input_sync(mdps.idev);
+
+		msleep(MDPS_POLL_INTERVAL);
+	}
+
+	return 0;
+}
+
+static inline void mdps_poweroff(acpi_handle handle)
+{
+	unsigned long ret;
+	mdps.is_on = 0;
+	mdps_ALWR(handle, MDPS_CTRL_REG1, 0x00, &ret);
+}
+
+static inline void mdps_poweron(acpi_handle handle)
+{
+	mdps.is_on = 1;
+	mdps__INI(handle);
+}
+
+#ifdef CONFIG_PM
+int mdps_suspend(struct acpi_device * device, int state)
+{
+	mdps_poweroff(mdps.device->handle);
+	mdps_mouse_disable();
+
+	return 0;
+}
+#endif
+
+int mdps_resume(struct acpi_device * device, int state)
+{
+	mdps_poweron(mdps.device->handle);
+
+	if (mouse)
+		mdps_mouse_enable();
+
+	return 0;
+}
+
+static irqreturn_t mdps_irq(int irq, void *dev_id)
+{
+	atomic_inc(&mdps.count);
+
+	spin_lock(&mdps_lock);
+	/* If we have a reader waiting, signal him */
+	if (mdps.reader_waiting) {
+		mdps.reader_waiting = 0;
+		complete(&mdps.complete);
+	}
+	spin_unlock(&mdps_lock);
+
+	return IRQ_HANDLED;
+}
+
+static int mdps_misc_release(struct inode *inode, struct file *file)
+{
+	atomic_inc(&mdps_available); /* release the device */
+	return 0;
+}
+
+static int mdps_misc_open(struct inode *inode, struct file *file)
+{
+	if (!atomic_dec_and_test(&mdps_available)) {
+		atomic_inc(&mdps_available);
+		return -EBUSY; /* already open */
+	}
+
+	atomic_set(&mdps.count, 0);
+	return 0;
+}
+
+static ssize_t mdps_misc_read(struct file *file, char __user *buf,
+                                size_t count, loff_t *pos)
+{
+	u32 tmp;
+	int ret;
+	unsigned long flags;
+	u32* user_buf = (u32*)buf;
+
+	if (count != sizeof(u32))
+		return -EINVAL;
+
+	init_completion(&mdps.complete);
+
+	spin_lock_irqsave(&mdps_lock, flags);
+	mdps.reader_waiting = 1;
+	spin_unlock_irqrestore(&mdps_lock, flags);
+
+	ret = wait_for_completion_interruptible(&mdps.complete);
+	if (ret)
+		return ret;
+	tmp = atomic_read(&mdps.count);
+	atomic_set(&mdps.count, 0);
+
+	if (put_user(tmp, user_buf))
+		return -EFAULT;
+
+	return count;
+}
+
+static const struct file_operations mdps_misc_fops = {
+	.owner          = THIS_MODULE,
+	.llseek         = no_llseek,
+	.read           = mdps_misc_read,
+	.open           = mdps_misc_open,
+	.release        = mdps_misc_release
+};
+
+static struct miscdevice mdps_misc_device = {
+	.minor          = MISC_DYNAMIC_MINOR,
+	.name           = "acel",
+	.fops           = &mdps_misc_fops,
+};
+
+static acpi_status
+mdps_get_resource(struct acpi_resource *resource, void *context)
+{
+	if (resource->type == ACPI_RESOURCE_TYPE_EXTENDED_IRQ) {
+		struct acpi_resource_extended_irq* irq;
+		u32* device_irq = context;
+
+		irq = &resource->data.extended_irq;
+		*device_irq = irq->interrupts[0];
+	}
+
+	return AE_OK;
+}
+
+static void mdps_enum_resources(struct acpi_device * device)
+{
+	acpi_status status;
+
+	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+	                             mdps_get_resource, &mdps.irq);
+	if (ACPI_FAILURE(status))
+		printk(KERN_DEBUG "mdps: Error getting resources\n");
+}
+
+int mdps_add(struct acpi_device *device)
+{
+	unsigned long val;
+	int ret;
+
+	if (!device)
+		return -EINVAL;
+
+	mdps.device = device;
+	strcpy(acpi_device_name(device), DRIVER_NAME);
+	strcpy(acpi_device_class(device), ACPI_MDPS_CLASS);
+	acpi_driver_data(device) = &mdps;
+
+	mdps_ALRD(device->handle, MDPS_WHO_AM_I, &val);
+	if (val != MDPS_ID) {
+		printk(KERN_INFO "mdps: Accelerometer chip not LIS3LV02D{L,Q}\n");
+		return -ENODEV;
+	}
+
+	mdps_enum_resources(device);
+	mdps_add_fs(device);
+	mdps_resume(device, 3);
+
+	if (power_off)
+		mdps_poweroff(mdps.device->handle);
+
+	if (mdps.irq) {
+		ret = request_irq(mdps.irq, mdps_irq, 0, "mdps", mdps_irq);
+		if (ret) {
+			printk(KERN_INFO "mdps: (IRQ%d) allocation failed\n", mdps.irq);
+			mdps.irq = 0;
+		} else {
+			ret = misc_register(&mdps_misc_device);
+			if (ret) {
+				free_irq(mdps.irq, mdps_irq);
+				mdps.irq = 0;
+				printk(KERN_ERR "mdps: misc_register failed\n");
+			}
+		}
+	}
+
+	return 0;
+}
+
+int mdps_remove(struct acpi_device *device, int type)
+{
+	if (!device)
+		return -EINVAL;
+
+	if (mdps.irq) {
+		misc_deregister(&mdps_misc_device);
+		free_irq(mdps.irq, mdps_irq);
+		mdps.irq = 0;
+	}
+
+	if (mouse)
+		mdps_mouse_disable();
+
+	return mdps_remove_fs();
+}
+
+static void mdps_calibrate_mouse(void)
+{
+	int x, y;
+	mdps_get_xy(mdps.device->handle, &x, &y);
+
+	mdps.xcalib = x;
+	mdps.ycalib = y;
+}
+
+void mdps_mouse_enable(void)
+{
+	if (mdps.idev)
+		return;
+
+	mdps.idev = input_allocate_device();
+	if (!mdps.idev)
+		return;
+
+	mdps_calibrate_mouse();
+
+	mdps.idev->name       = "HP Mobile Data Protection System";
+	mdps.idev->id.bustype = BUS_HOST;
+	mdps.idev->id.vendor  = 0;
+
+	set_bit(EV_ABS, mdps.idev->evbit);
+	set_bit(EV_KEY, mdps.idev->evbit);
+
+	input_set_abs_params(mdps.idev, ABS_X, -2048, 2048, 3, 0);
+	input_set_abs_params(mdps.idev, ABS_Y, -2048, 2048, 3, 0);
+
+	if (input_register_device(mdps.idev)) {
+		input_free_device(mdps.idev);
+		mdps.idev = NULL;
+		return;
+	}
+
+	mdps.kthread = kthread_run(mdps_mouse_kthread, NULL, "kmdps");
+	if (IS_ERR(mdps.kthread)) {
+		input_unregister_device(mdps.idev);
+		mdps.idev = NULL;
+		return;
+	}
+
+	mouse = 1;
+}
+
+void mdps_mouse_disable(void)
+{
+	if (!mdps.idev)
+		return;
+
+	kthread_stop(mdps.kthread);
+
+	input_unregister_device(mdps.idev);
+	mdps.idev = NULL;
+}
+
+/* Sysfs stuff */
+static ssize_t mdps_position_show(struct device *dev,
+                                  struct device_attribute *attr, char *buf)
+{
+	int x, y;
+	mdps_get_xy(mdps.device->handle, &x, &y);
+	return sprintf(buf, "(%d,%d)\n", x, y);
+}
+
+static ssize_t mdps_position3d_show(struct device *dev,
+                                    struct device_attribute *attr, char *buf)
+{
+	unsigned long z_lo, z_hi;
+	int x, y, z;
+
+	mdps_get_xy(mdps.device->handle, &x, &y);
+
+	mdps_ALRD(mdps.device->handle, MDPS_OUTZ_L, &z_lo);
+	mdps_ALRD(mdps.device->handle, MDPS_OUTZ_H, &z_hi);
+	z = mdps_glue_bytes(z_hi, z_lo);
+
+	return sprintf(buf, "(%d,%d,%d)\n", x, y, z);
+}
+
+static ssize_t mdps_state_show(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s\n", (mdps.is_on ? "on" : "off"));
+}
+
+static ssize_t mdps_mouse_show(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s\n", (mouse ? "enabled" : "disabled"));
+}
+
+static ssize_t mdps_calibrate_show(struct device *dev,
+                                   struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "(%d,%d)\n", mdps.xcalib, mdps.ycalib);
+}
+
+static ssize_t mdps_calibrate_store(struct device *dev,
+                   struct device_attribute *attr, const char *buf, size_t count)
+{
+	mdps_calibrate_mouse();
+	return count;
+}
+
+static ssize_t mdps_rate_show(struct device *dev,
+                              struct device_attribute *attr, char *buf)
+{
+	unsigned long ctrl;
+	int rate = 0;
+
+	mdps_ALRD(mdps.device->handle, MDPS_CTRL_REG1, &ctrl);
+
+	switch (ctrl & 0x30)
+	{
+	case 0x00:
+		rate = 40;
+		break;
+
+	case 0x10:
+		rate = 160;
+		break;
+
+	case 0x20:
+		rate = 640;
+		break;
+
+	case 0x30:
+		rate = 2560;
+		break;
+	}
+
+	return sprintf(buf, "%d\n", rate);
+}
+
+static ssize_t mdps_state_store(struct device *dev,
+                                  struct device_attribute *attr,
+                                  const char *buf, size_t count)
+{
+	int state;
+	if (sscanf(buf, "%d", &state) != 1 || (state != 1 && state != 0))
+		return -EINVAL;
+
+	mdps.is_on = state;
+
+	if (mdps.is_on)
+		mdps_poweron(mdps.device->handle);
+	else
+		mdps_poweroff(mdps.device->handle);
+
+	return count;
+}
+
+static ssize_t mdps_mouse_store(struct device *dev,
+                   struct device_attribute *attr, const char *buf, size_t count)
+{
+	int tmp;
+	if (sscanf(buf, "%d", &tmp) != 1 || (tmp != 1 && tmp != 0))
+		return -EINVAL;
+
+	mouse = tmp;
+
+	if (mouse)
+		mdps_mouse_enable();
+	else
+		mdps_mouse_disable();
+
+	return count;
+}
+
+static DEVICE_ATTR(position, S_IRUGO, mdps_position_show, NULL);
+static DEVICE_ATTR(position3d, S_IRUGO, mdps_position3d_show, NULL);
+static DEVICE_ATTR(calibrate, S_IRUGO|S_IWUSR, mdps_calibrate_show, mdps_calibrate_store);
+static DEVICE_ATTR(rate, S_IRUGO, mdps_rate_show, NULL);
+static DEVICE_ATTR(state, S_IRUGO|S_IWUSR, mdps_state_show, mdps_state_store);
+static DEVICE_ATTR(mouse, S_IRUGO|S_IWUSR, mdps_mouse_show, mdps_mouse_store);
+
+static struct attribute *mdps_attributes[] = {
+	&dev_attr_position.attr,
+	&dev_attr_position3d.attr,
+	&dev_attr_calibrate.attr,
+	&dev_attr_rate.attr,
+	&dev_attr_state.attr,
+	&dev_attr_mouse.attr,
+	NULL
+};
+
+static struct attribute_group mdps_attribute_group = {
+	.attrs = mdps_attributes
+};
+
+int mdps_add_fs(struct acpi_device *device)
+{
+	mdps.pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
+	if (IS_ERR(mdps.pdev))
+		return PTR_ERR(mdps.pdev);
+
+	return sysfs_create_group(&mdps.pdev->dev.kobj, &mdps_attribute_group);
+}
+
+int mdps_remove_fs(void)
+{
+	sysfs_remove_group(&mdps.pdev->dev.kobj, &mdps_attribute_group);
+	platform_device_unregister(mdps.pdev);
+	return 0;
+}
+
+static int __init mdps_init_module(void)
+{
+	int ret;
+	acpi_status status;
+	acpi_handle handle = 0;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	/* device detection: see if our device is present */
+	status = acpi_get_handle(NULL, "\\_SB.C002.ACEL", &handle);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR "mdps: HP Mobile Data Protection System 3D device not found\n");
+		return -ENODEV;
+	}
+
+	ret = acpi_bus_register_driver(&mdps_driver);
+	if (ret < 0)
+		return ret;
+	
+	printk(KERN_INFO "mdps: (" VERSION ") loaded.\n");
+
+	return 0;
+}
+
+static void __exit mdps_exit_module(void)
+{
+	acpi_bus_unregister_driver(&mdps_driver);
+}
+
+MODULE_DESCRIPTION("HP three-axis digital accelerometer ACPI driver");
+MODULE_AUTHOR("Yan Burman (yan_952@hotmail.com)");
+MODULE_VERSION(VERSION);
+MODULE_LICENSE("GPL");
+
+module_init(mdps_init_module);
+module_exit(mdps_exit_module);


------=_NextPart_000_6c0c_4449_3c7d--
