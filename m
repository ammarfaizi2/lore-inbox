Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWJMJ0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWJMJ0M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 05:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWJMJ0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 05:26:12 -0400
Received: from kagl.donpac.ru ([80.254.111.32]:58055 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S1750986AbWJMJ0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 05:26:10 -0400
Date: Fri, 13 Oct 2006 13:26:03 +0400
To: Burman Yan <yan_952@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HP mobile data protection system driver
Message-ID: <20061013092603.GA26306@pazke.donpac.ru>
Mail-Followup-To: Burman Yan <yan_952@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <BAY20-F7ACD05600A29690DC3CCED80A0@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <BAY20-F7ACD05600A29690DC3CCED80A0@phx.gbl>
X-Uname: Linux 2.6.18-1-amd64 x86_64
User-Agent: Mutt/1.5.12-2006-07-14
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 286, 10 13, 2006 at 10:47:15 +0200, Burman Yan wrote:
> Hi, all.
>=20
> I'm new to the list so forgive me in advance for any netiquette mistakes =
I=20
> make.
>=20
> I wrote a driver for the accelerometer chip on HP nc6400 laptop (I think=
=20
> the same chip is present on
> other NCxxxx models). This driver uses ACPI interface present in the bios=
=20
> and behaves pretty much like
> hdaps. This is a fully functional version - tested on 2.6.17 and 2.6.18=
=20
> (not 2.6.19-rc1 since I have a
> problem with that kernel on my laptop). It applies on 2.6.19-rc1 as well=
=20
> though. I would like your
> remarks and suggestions on this. Also, should I mail this patch to a kern=
el=20
> maintainer? I could not find a maintainer that looks like the address for=
=20
> this patch. The closest one is the lm_sensors maintainer, but
> that's probably wrong.

Some comments:

1. Use hard tabs instead of 8 spaces;
2. C++ comments are tolerated, but not welcomed;
3. You missed Signed-off-by: line.


diff -Nrubp linux-2.6.18.orig/drivers/hwmon/Kconfig linux-2.6.18.mdps/drive=
rs/hwmon/Kconfig
--- linux-2.6.18.orig/drivers/hwmon/Kconfig	2006-10-11 14:20:08.000000000 +=
0200
+++ linux-2.6.18.mdps/drivers/hwmon/Kconfig	2006-10-13 08:52:42.000000000 +=
0200
@@ -507,6 +507,22 @@ config SENSORS_HDAPS
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of hdaps.
=20
+config SENSORS_MDPS
+        tristate "HP Mobile Data Protection System 3D (mdps)"
+        depends on ACPI && HWMON && INPUT && X86
+        default n
+        help
+          This driver provides support for the HP Mobile Data Protection=
=20
+          System 3D (mdps), which is an accelerometer. Only HP nc6400 is s=
upported
+          right now, but it may work on other models as well.  The
+          accelerometer data is readable via /proc/drivers/mdps.
+
+          This driver also provides an absolute input class device, allowi=
ng
+          the laptop to act as a pinball machine-esque joystick.
+
+          This driver can also be built as a module.  If so, the module
+          will be called mdps.
+
 config HWMON_DEBUG_CHIP
 	bool "Hardware Monitoring Chip debugging messages"
 	depends on HWMON
diff -Nrubp linux-2.6.18.orig/drivers/hwmon/Makefile linux-2.6.18.mdps/driv=
ers/hwmon/Makefile
--- linux-2.6.18.orig/drivers/hwmon/Makefile	2006-10-11 14:20:08.000000000 =
+0200
+++ linux-2.6.18.mdps/drivers/hwmon/Makefile	2006-10-13 10:14:10.000000000 =
+0200
@@ -26,6 +26,7 @@ obj-$(CONFIG_SENSORS_FSCPOS)	+=3D fscpos.o
 obj-$(CONFIG_SENSORS_GL518SM)	+=3D gl518sm.o
 obj-$(CONFIG_SENSORS_GL520SM)	+=3D gl520sm.o
 obj-$(CONFIG_SENSORS_HDAPS)	+=3D hdaps.o
+obj-$(CONFIG_SENSORS_MDPS)	+=3D mdps.o
 obj-$(CONFIG_SENSORS_IT87)	+=3D it87.o
 obj-$(CONFIG_SENSORS_LM63)	+=3D lm63.o
 obj-$(CONFIG_SENSORS_LM70)	+=3D lm70.o
diff -Nrubp linux-2.6.18.orig/drivers/hwmon/mdps.c linux-2.6.18.mdps/driver=
s/hwmon/mdps.c
--- linux-2.6.18.orig/drivers/hwmon/mdps.c	1970-01-01 02:00:00.000000000 +0=
200
+++ linux-2.6.18.mdps/drivers/hwmon/mdps.c	2006-10-13 10:13:49.000000000 +0=
200
@@ -0,0 +1,700 @@
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
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/input.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+
+#include <acpi/acpi_drivers.h>
+#include <acpi/acnamesp.h>
+
+#include <asm/uaccess.h>
+
+#define VERSION "0.1"
+
+MODULE_DESCRIPTION("HP three-axis digital accelerometer ACPI driver");
+MODULE_AUTHOR("Yan Burman (yan_952@hotmail.com)");
+MODULE_VERSION(VERSION);
+MODULE_LICENSE("GPL");
+
+#define DRIVER_NAME "mdps"
+#define ACPI_MDPS_CLASS "accelerometer"
+#define ACPI_MDPS_ID    "HPQ0004"
+
+#define MDPS_PROC_ROOT "driver/mdps"
+
+// The actual chip is STMicroelectronics LIS3LV02DL or LIS3LV02DQ
+
+#define MDPS_WHO_AM_I        0x0F //r      00111010
+#define MDPS_OFFSET_X        0x16 //rw
+#define MDPS_OFFSET_Y        0x17 //rw
+#define MDPS_OFFSET_Z        0x18 //rw
+#define MDPS_GAIN_X          0x19 //rw
+#define MDPS_GAIN_Y          0x1A //rw
+#define MDPS_GAIN_Z          0x1B //rw
+#define MDPS_CTRL_REG1       0x20 //rw     00000111
+#define MDPS_CTRL_REG2       0x21 //rw     00000000
+#define MDPS_CTRL_REG3       0x22 //rw     00001000
+#define MDPS_HP_FILTER RESET 0x23 //r
+#define MDPS_STATUS_REG      0x27 //rw     00000000
+#define MDPS_OUTX_L          0x28 //r
+#define MDPS_OUTX_H          0x29 //r
+#define MDPS_OUTY_L          0x2A //r
+#define MDPS_OUTY_H          0x2B //r
+#define MDPS_OUTZ_L          0x2C //r
+#define MDPS_OUTZ_H          0x2D //r
+#define MDPS_FF_WU_CFG       0x30 //rw     00000000
+#define MDPS_FF_WU_SRC       0x31 //rw     00000000
+#define MDPS_FF_WU_ACK       0x32 //r
+#define MDPS_FF_WU_THS_L     0x34 //rw     00000000
+#define MDPS_FF_WU_THS_H     0x35 //rw     00000000
+#define MDPS_FF_WU_DURATION  0x36 //rw     00000000
+#define MDPS_DD_CFG          0x38 //rw     00000000
+#define MDPS_DD_SRC          0x39 //rw     00000000
+#define MDPS_DD_ACK          0x3A //r
+#define MDPS_DD_THSI_L       0x3C //rw     00000000
+#define MDPS_DD_THSI_H       0x3D //rw     00000000
+#define MDPS_DD_THSE_L       0x3E //rw     00000000
+#define MDPS_DD_THSE_H       0x3F //rw     00000000
+
+#define MDPS_ID 0x3A
+
+// mouse device poll interval in milliseconds
+#define MDPS_POLL_INTERVAL 30
+
+static unsigned int mouse;
+module_param(mouse, bool, 0);
+MODULE_PARM_DESC(mouse, "Enable the input class device on module load");
+
+#ifdef CONFIG_PROC_FS
+static unsigned int power_off;
+module_param(power_off, bool, 0);
+MODULE_PARM_DESC(power_off, "Turn off device on module load");
+#endif
+
+struct acpi_mdps
+{
+        struct acpi_device* device;    /* The ACPI device */
+        u32                 irq;       /* IRQ number */
+        struct input_dev*   idev;      /* input device */
+        struct task_struct* kthread;   /* kthread for input */
+        int                 xcalib;    /* calibrated null value for x */
+        int                 ycalib;    /* calibrated null value for y */
+        int                 is_on;     /* whether the device is on or off =
*/
+#ifdef CONFIG_PROC_FS
+        struct proc_dir_entry *dir;
+#endif
+};
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
+static struct acpi_driver mdps_driver =3D
+{
+        .name =3D DRIVER_NAME,
+        .class =3D ACPI_MDPS_CLASS,
+        .ids =3D ACPI_MDPS_ID,
+        .ops =3D {
+                .add     =3D mdps_add,
+                .remove  =3D mdps_remove,
+                .suspend =3D mdps_suspend,
+                .resume  =3D mdps_resume
+               }

Strange indentation.

+};
+
+/** Create a single value from 2 bytes received from the accelerometer
+ * @param hi the high byte
+ * @param lo the low byte
+ * @return the resulting value
+ */

Hmm, kernel doesn't use doxygen...

+static inline s16 mdps_glue_bytes(unsigned long hi, unsigned long lo)
+{
+        // In "12 bit right justified" mode, bit 6, bit 7, bit 8 =3D bit 5
+        if (hi & 0x10)
+                hi |=3D 0xE0;
+        return (s16)(lo | ((hi << 8)));
+}
+
+static acpi_status read_acpi_int_param(acpi_handle handle, acpi_string met=
hod,
+                                       int val, unsigned long* ret)
+{
+        union acpi_object arg0 =3D { ACPI_TYPE_INTEGER };
+        struct acpi_object_list args =3D { 1, &arg0 };
+
+        arg0.integer.value =3D val;
+
+        return acpi_evaluate_integer(handle, method, &args, ret);
+}
+
+/** ACPI _STA method: get device status
+ * @param handle the handle of the device
+ * @param[out] ret result of the operation
+ * @return AE_OK on success
+ */
+static inline acpi_status mdps__STA(acpi_handle handle, unsigned long* ret)
+{
+        return acpi_evaluate_integer(handle, METHOD_NAME__STA, NULL, ret);
+}
+
+/** ACPI ALRD method: read a register
+ * @param handle the handle of the device
+ * @param reg the register to read
+ * @param[out] ret result of the operation
+ * @return AE_OK on success
+ */
+static inline acpi_status mdps_ALRD(acpi_handle handle, int reg,=20
+                                    unsigned long* ret)
+{
+        return read_acpi_int_param(handle, "ALRD", reg, ret);
+}
+
+/** ACPI _INI method: initialize the device.
+ * @param handle the handle of the device
+ * @return 0 on success
+ */
+static inline acpi_status mdps__INI(acpi_handle handle)
+{
+        return acpi_evaluate_object(handle, METHOD_NAME__INI, NULL, NULL);
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
+        union acpi_object in_obj[2];
+        struct acpi_object_list args;
+
+        args.count              =3D 2;
+        args.pointer            =3D in_obj;
+        in_obj[0].type          =3D ACPI_TYPE_INTEGER;
+        in_obj[0].integer.value =3D reg;
+        in_obj[1].type          =3D ACPI_TYPE_INTEGER;
+        in_obj[1].integer.value =3D val;
+
+        return acpi_evaluate_integer(handle, "ALWR", &args, ret);
+}
+
+static int mdps_get_xy(acpi_handle handle, int* x, int* y)
+{
+        unsigned long x_lo, x_hi, y_lo, y_hi;
+
+        mdps_ALRD(mdps.device->handle, MDPS_OUTX_L, &x_lo);
+        mdps_ALRD(mdps.device->handle, MDPS_OUTX_H, &x_hi);
+        mdps_ALRD(mdps.device->handle, MDPS_OUTY_L, &y_lo);
+        mdps_ALRD(mdps.device->handle, MDPS_OUTY_H, &y_hi);
+
+        *x =3D mdps_glue_bytes(x_hi, x_lo);
+        *y =3D mdps_glue_bytes(y_hi, y_lo);
+
+        return 0;
+}
+
+static int mdps_mouse_kthread(void *data)
+{
+        int x, y;
+
+        while (!kthread_should_stop()) {
+                mdps_get_xy(mdps.device->handle, &x, &y);
+
+                // need to invert the X axis for this to look natural
+                input_report_abs(mdps.idev, ABS_X, -(x - mdps.xcalib));
+                input_report_abs(mdps.idev, ABS_Y, y - mdps.ycalib);
+
+                input_sync(mdps.idev);
+
+                msleep_interruptible(MDPS_POLL_INTERVAL);
+        }
+
+        return 0;
+}
+
+static inline int mdps_poweroff(acpi_handle handle)
+{
+        unsigned long ret;
+        mdps.is_on =3D 0;
+        return (mdps_ALWR(handle, MDPS_CTRL_REG1, 0x00, &ret) =3D=3D AE_OK=
);
+}
+
+static inline int mdps_poweron(acpi_handle handle)
+{
+        mdps.is_on =3D 1;
+        return (mdps__INI(handle) =3D=3D AE_OK);
+}
+
+int mdps_suspend(struct acpi_device * device, int state)

This function was declared static earlier.

+{
+        mdps_poweroff(mdps.device->handle);
+
+        mdps_mouse_disable();
+
+        return 0;
+}
+
+int mdps_resume(struct acpi_device * device, int state)

Missing static again.

+{
+        mdps_poweron(mdps.device->handle);
+
+        if (mouse)
+                mdps_mouse_enable();
+
+        return 0;
+}
+
+static acpi_status
+mdps_get_resource(struct acpi_resource *resource, void *context)
+{
+        if (resource->type =3D=3D ACPI_RESOURCE_TYPE_EXTENDED_IRQ) {
+                struct acpi_resource_extended_irq* irq;
+                u32* device_irq =3D context;
+
+                irq =3D &resource->data.extended_irq;
+                *device_irq =3D irq->interrupts[0];
+        }
+
+        return AE_OK;
+}
+
+static void mdps_enum_resources(struct acpi_device * device)
+{
+        acpi_status status;
+
+        status =3D acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+                                     mdps_get_resource, &mdps.irq);
+        if (ACPI_FAILURE(status))
+                printk(KERN_DEBUG "mdps: Error getting resources\n");
+}
+
+int mdps_add(struct acpi_device *device)

And again. And some more below, please check.

+{
+        unsigned long val;
+
+        if (!device)
+                return -EINVAL;
+
+        mdps.device =3D device;
+        strcpy(acpi_device_name(device), "mdps");
+        strcpy(acpi_device_class(device), ACPI_MDPS_CLASS);
+        acpi_driver_data(device) =3D &mdps;
+
+        mdps_ALRD(device->handle, MDPS_WHO_AM_I, &val);
+        if (val !=3D MDPS_ID) {
+                printk(KERN_INFO "mdps: Accelerometer chip not LIS3LV02D{L=
,Q}\n");
+                return -ENODEV;
+        }
+
+        mdps_enum_resources(device);
+        mdps_add_fs(device);
+        mdps_resume(device, 3);
+
+#ifdef CONFIG_PROC_FS
+        if (power_off)
+                mdps_poweroff(mdps.device->handle);
+#endif
+
+        return 0;
+}
+
+int mdps_remove(struct acpi_device *device, int type)
+{
+        if (!device)
+                return -EINVAL;
+
+        if (mouse)
+                mdps_mouse_disable();
+
+        return mdps_remove_fs();
+}
+
+static inline void mdps_calibrate_mouse(void)
+{
+        int x, y;
+        mdps_get_xy(mdps.device->handle, &x, &y);
+
+        mdps.xcalib =3D x;
+        mdps.ycalib =3D y;
+}
+
+#ifdef CONFIG_PROC_FS
+static int mdps_proc_position_show(struct seq_file *seq, void *v)
+{
+        unsigned long z_lo, z_hi;
+        int x, y, z;
+
+        mdps_get_xy(mdps.device->handle, &x, &y);
+
+        mdps_ALRD(mdps.device->handle, MDPS_OUTZ_L, &z_lo);
+        mdps_ALRD(mdps.device->handle, MDPS_OUTZ_H, &z_hi);
+
+        z =3D mdps_glue_bytes(z_hi, z_lo);
+
+        seq_printf(seq, "(%d, %d, %d)\n", x, y, z);
+
+        return 0;
+}
+
+static int mdps_proc_state_show(struct seq_file *seq, void *v)
+{
+        seq_puts(seq, (mdps.is_on ? "on\n" : "off\n"));
+
+        return 0;
+}
+
+static int mdps_proc_calibrate_mouse_show(struct seq_file *seq, void *v)
+{
+        return 0;
+}
+
+static int mdps_proc_mouse_show(struct seq_file *seq, void *v)
+{
+        seq_puts(seq, (mouse ? "enabled\n" : "disabled\n"));
+
+        return 0;
+}
+
+static ssize_t
+mdps_write_calibrate_mouse(struct file *file, const char __user * buffer,
+                           size_t count, loff_t * ppos)
+{
+        mdps_calibrate_mouse();
+
+        return count;
+}
+
+static int mdps_proc_rate_show(struct seq_file *seq, void *v)
+{
+        unsigned long ctrl;
+        int rate =3D 0;
+
+        mdps_ALRD(mdps.device->handle, MDPS_CTRL_REG1, &ctrl);
+
+        switch (ctrl & 0x30)
+        {
+        case 0x00:
+                rate =3D 40;
+                break;
+
+        case 0x10:
+                rate =3D 160;
+                break;
+
+        case 0x20:
+                rate =3D 640;
+                break;
+
+        case 0x30:
+                rate =3D 2560;
+                break;
+        }
+
+        seq_printf(seq, "sampling rate:\t%dHz\n", rate);
+
+        return 0;
+}
+
+static ssize_t
+mdps_write_state(struct file *file, const char __user * buffer,
+                 size_t count, loff_t * ppos)
+{
+        char state_string[12] =3D { '\0' };
+
+        if ((count > sizeof(state_string) - 1))
+                return -EINVAL;
+
+        if (copy_from_user(state_string, buffer, count))
+                return -EFAULT;
+
+        state_string[count] =3D '\0';
+
+        mdps.is_on =3D simple_strtoul(state_string, NULL, 0);
+
+        if (mdps.is_on)
+                mdps_poweron(mdps.device->handle);
+        else
+                mdps_poweroff(mdps.device->handle);
+
+        return count;
+}
+
+static ssize_t mdps_write_mouse(struct file *file, const char __user * buf=
fer,
+                                size_t count, loff_t * ppos)
+{
+        char state_string[12] =3D { '\0' };
+
+        if ((count > sizeof(state_string) - 1))
+                return -EINVAL;
+
+        if (copy_from_user(state_string, buffer, count))
+                return -EFAULT;
+
+        state_string[count] =3D '\0';
+
+        mouse =3D simple_strtoul(state_string, NULL, 0);
+
+        if (mouse)
+                mdps_mouse_enable();
+        else
+                mdps_mouse_disable();
+
+        return count;
+}
+
+static int mdps_proc_position_open(struct inode *inode, struct file *file)
+{
+        return single_open(file, mdps_proc_position_show, NULL);
+}
+
+static int mdps_proc_state_open(struct inode *inode, struct file *file)
+{
+        return single_open(file, mdps_proc_state_show, NULL);
+}
+
+static int mdps_proc_rate_open(struct inode *inode, struct file *file)
+{
+        return single_open(file, mdps_proc_rate_show, NULL);
+}
+
+static int mdps_proc_mouse_open(struct inode *inode, struct file *file)
+{
+        return single_open(file, mdps_proc_mouse_show, NULL);
+}
+
+static int mdps_proc_calibrate_mouse_open(struct inode *inode,
+                                          struct file *file)
+{
+        return single_open(file, mdps_proc_calibrate_mouse_show, NULL);
+}
+
+static const struct file_operations mdps_proc_position_fops =3D
+{
+        .owner   =3D THIS_MODULE,
+        .open    =3D mdps_proc_position_open,
+        .read    =3D seq_read,
+        .llseek  =3D seq_lseek,
+        .release =3D single_release,
+};
+
+static const struct file_operations mdps_proc_state_fops =3D
+{
+        .owner   =3D THIS_MODULE,
+        .open    =3D mdps_proc_state_open,
+        .read    =3D seq_read,
+        .write   =3D mdps_write_state,
+        .llseek  =3D seq_lseek,
+        .release =3D single_release,
+};
+
+static const struct file_operations mdps_proc_mouse_fops =3D
+{
+        .owner   =3D THIS_MODULE,
+        .open    =3D mdps_proc_mouse_open,
+        .read    =3D seq_read,
+        .write   =3D mdps_write_mouse,
+        .llseek  =3D seq_lseek,
+        .release =3D single_release,
+};
+
+static const struct file_operations mdps_proc_calibrate_mouse_fops =3D
+{
+        .owner   =3D THIS_MODULE,
+        .open    =3D mdps_proc_calibrate_mouse_open,
+        .write   =3D mdps_write_calibrate_mouse,
+        .llseek  =3D seq_lseek,
+        .release =3D single_release,
+};
+
+static const struct file_operations mdps_proc_rate_fops =3D
+{
+        .owner   =3D THIS_MODULE,
+        .open    =3D mdps_proc_rate_open,
+        .read    =3D seq_read,
+        .llseek  =3D seq_lseek,
+        .release =3D single_release,
+};
+#endif // CONFIG_PROCFS
+
+void mdps_mouse_enable(void)
+{
+        if (mdps.idev)
+                return;
+
+        mdps.idev =3D input_allocate_device();
+        if (!mdps.idev)
+                return;
+
+        mdps_calibrate_mouse();
+
+        mdps.idev->name       =3D "HP Mobile Data Protection System";
+        mdps.idev->id.bustype =3D BUS_I2C;
+        mdps.idev->id.vendor  =3D 0;
+
+        input_set_abs_params(mdps.idev, ABS_X, -2048, 2048, 3, 0);
+        input_set_abs_params(mdps.idev, ABS_Y, -2048, 2048, 3, 0);
+
+        set_bit(EV_ABS, mdps.idev->evbit);
+        set_bit(EV_KEY, mdps.idev->evbit);
+        set_bit(BTN_TOUCH, mdps.idev->keybit);
+
+        if (input_register_device(mdps.idev)) {
+                input_free_device(mdps.idev);
+                mdps.idev =3D NULL;
+                return;
+        }
+
+        mdps.kthread =3D kthread_run(mdps_mouse_kthread, NULL, "kmdps");
+        if (IS_ERR(mdps.kthread)) {
+                input_unregister_device(mdps.idev);
+                mdps.idev =3D NULL;
+                return;
+        }
+
+        mouse =3D 1;
+
+#ifdef CONFIG_PROC_FS
+        {
+                struct proc_dir_entry *ent;
+                ent =3D create_proc_entry("calibrate_mouse", S_IWUSR, mdps=
=2Edir);
+                if (!ent)
+                {
+                        return;
+                }
+
+                ent->proc_fops =3D &mdps_proc_calibrate_mouse_fops;
+        }
+#endif
+}
+
+void mdps_mouse_disable(void)
+{
+        if (!mdps.idev)
+                return;
+
+        kthread_stop(mdps.kthread);
+
+        input_unregister_device(mdps.idev);
+        mdps.idev =3D NULL;
+
+#ifdef CONFIG_PROC_FS
+        remove_proc_entry("calibrate_mouse", mdps.dir);
+#endif
+}
+
+int mdps_add_fs(struct acpi_device *device)
+{
+#ifdef CONFIG_PROC_FS
+        struct proc_dir_entry *ent;
+
+        mdps.dir =3D proc_mkdir(MDPS_PROC_ROOT, NULL);
+        if (!mdps.dir)
+                return -ENOMEM;
+
+        ent =3D create_proc_entry("position", S_IFREG | S_IRUGO, mdps.dir);
+        if (!ent)
+                return -ENOMEM;
+
+        ent->proc_fops =3D &mdps_proc_position_fops;
+
+        ent =3D create_proc_entry("state", S_IFREG | S_IRUGO | S_IWUSR, md=
ps.dir);
+        if (!ent)
+                return -ENOMEM;
+
+        ent->proc_fops =3D &mdps_proc_state_fops;
+
+        ent =3D create_proc_entry("rate", S_IFREG | S_IRUGO, mdps.dir);
+        if (!ent)
+                return -ENOMEM;
+
+        ent->proc_fops =3D &mdps_proc_rate_fops;
+
+        ent =3D create_proc_entry("mouse", S_IFREG | S_IRUGO | S_IWUSR, md=
ps.dir);
+        if (!ent)
+                return -ENOMEM;
+
+        ent->proc_fops =3D &mdps_proc_mouse_fops;
+#endif
+
+        return 0;
+}
+
+int mdps_remove_fs(void)
+{
+#ifdef CONFIG_PROC_FS
+        remove_proc_entry("position", mdps.dir);
+        remove_proc_entry("state", mdps.dir);
+        remove_proc_entry("rate", mdps.dir);
+        remove_proc_entry("mouse", mdps.dir);
+        remove_proc_entry(MDPS_PROC_ROOT, NULL);
+#endif
+
+        return 0;
+}
+
+static int __init mdps_init_module(void)
+{
+        int ret;
+        acpi_status status;
+        acpi_handle handle =3D 0;
+
+        if (acpi_disabled)
+                return -ENODEV;
+
+        // device detection: see if our device is present
+        status =3D acpi_get_handle(NULL, "\\_SB.C002.ACEL", &handle);
+        if (ACPI_FAILURE(status)) {
+                printk(KERN_INFO "mdps: HP Mobile Data Protection System 3=
D device not found\n");
+                return -ENODEV;
+        }
+
+        ret =3D acpi_bus_register_driver(&mdps_driver);
+        if (ret < 0)
+                return ret;
+
+        return 0;
+}
+
+static void __exit mdps_exit_module(void)
+{
+        mdps_remove(mdps.device, 1);
+
+        acpi_bus_unregister_driver(&mdps_driver);
+}
+
+module_init(mdps_init_module);
+module_exit(mdps_exit_module);




--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFL1urPjHNUy6paxMRAq8CAKCDsASZHMjGQlrrKcLT5Kg2oIQDSgCfd8rC
LkVDZhQMoPgyGGjSYhpqkwk=
=xcbn
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
