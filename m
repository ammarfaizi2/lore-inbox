Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267757AbTBMDbb>; Wed, 12 Feb 2003 22:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267758AbTBMDbb>; Wed, 12 Feb 2003 22:31:31 -0500
Received: from fmr01.intel.com ([192.55.52.18]:54263 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267757AbTBMDbT>;
	Wed, 12 Feb 2003 22:31:19 -0500
Subject: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
From: Rusty Lynch <rusty@linux.co.intel.com>
To: wingel@nano-systems.com
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: multipart/mixed; boundary="=-VevvzYngPLbJwRx3iG35"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Feb 2003 19:16:55 -0800
Message-Id: <1045106216.1089.16.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VevvzYngPLbJwRx3iG35
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following is a proposal for a new sysfs based watchdog interface
to be used as a replacement for the current char device w/ ioctl api
as described in Documentation/watchdog-api.txt.

Basically, with the help of some watchdog infrastructure code, we could make 
each watchdog device register as a platform_device named watchdog, so for 
every watchdog on the system there is a /sys/devices/legacy/watchdogN/ 
directory created for it.  

Inside each watchdog's platform device directory, we create a set of files
that corresponds with the IOCTL's used by the existing watchdog drivers.

For example, the first watchdog device registered on the system would add
the following to sysfs ==>

[rusty@penguin2 rusty]$ tree /sys/devices/legacy/watchdog0/
/sys/devices/legacy/watchdog0/
|-- bootstatus
|-- enable
|-- keepalive
|-- name
|-- nowayout
|-- power
|-- start
|-- statistics
|-- status
|-- stop
|-- temperature
|-- temppanic
`-- timeout

[rusty@penguin2 rusty]$ ls -l /sys/devices/legacy/watchdog0/
total 0
-r--r--r--    1 root     root         4096 Feb 12 11:00 bootstatus
-rw-r--r--    1 root     root         4096 Feb 12 11:00 enable
-r--------    1 root     root         4096 Feb 12 11:00 keepalive
-r--r--r--    1 root     root         4096 Feb 12 11:00 name
-rw-r--r--    1 root     root         4096 Feb 12 11:00 nowayout
-rw-r--r--    1 root     root         4096 Feb 12 11:00 power
-r--------    1 root     root         4096 Feb 12 11:00 start
-rw-r--r--    1 root     root         4096 Feb 12 11:00 statistics
-r--r--r--    1 root     root         4096 Feb 12 11:00 status
-rw-------    1 root     root         4096 Feb 12 11:00 stop
-r--r--r--    1 root     root         4096 Feb 12 11:00 temperature
-rw-r--r--    1 root     root         4096 Feb 12 11:00 temppanic
-rw-r--r--    1 root     root         4096 Feb 12 11:00 timeout

Where each these files to the following ==>

start (RO)
  - show: starts watchdog count

stop (RW)
  - store: stops watchdog count, passes input as a magic string
           that a driver might use to determine if it watchdog
           should really be stopped.
  - show: stops the watchdog count

timeout (RW)
  - store: expects an integer, changes timeout
  - show: prints timeout

keepalive (RO)
  - show: pings watchdog, outputs nothing

nowayout (RW)
  - store: expects 0 or 1, changes nowayout flag
  - show: prints nowayout boolean flag

status (RO)
  - show: prints the current status value

bootstatus (RO)
  - show: same as 'status', but valid for just after the last reboot.

temperature (RO)
  - show: prints temperature in degrees Fahrenheit

enable (RW)
  - show: prints 0 or 1 to indicate if the wdt is enabled
  - store: expects 0 or 1 to disable or enable the wdt

temppanic (RW)
  - show: prints 0 or 1 to indicate if an overtemp triggers a panic
  - store: expects 0 or 1 to disable or enable

* The 'statistics' file is an example of the device driver adding additional
  files to it's platform directory.

To keep each driver from having to re-implement all the sysfs code, I created
a simple infrastructure where each watchdog driver would only have to fill
in a structure with function pointers for the features the driver implements.

For example, a driver would have the following:

static struct wdt_ops dummy_ops = {
	.start = dummy_start,
	.stop = dummy_stop,
	.keepalive = dummy_keepalive,
	.get_timeout = dummy_get_timeout,
	.set_timeout = dummy_set_timeout,
	.get_nowayout = dummy_get_nowayout,
	.set_nowayout = dummy_set_nowayout,
	.get_status = dummy_get_status,
	.get_caps = dummy_get_caps,
	.get_bootstatus = dummy_get_bootstatus,
	.get_temperature = dummy_get_temperature,
	.get_enable = dummy_get_enable,
	.set_enable = dummy_set_enable,
	.get_temppanic = dummy_get_temppanic,
	.set_temppanic = dummy_set_temppanic,
};
decl_wdt_device(dummy, dummy_ops, Dummy Watchdog Timer);

where wdt_ops and wdt_device are defined as:

struct wdt_device {
	struct wdt_ops *ops;
	struct platform_device dev;
};

struct wdt_ops {
	int (*start)(struct wdt_device *);
	int (*stop)(struct wdt_device *, const char *);
	int (*keepalive)(struct wdt_device *);
	int (*get_timeout)(struct wdt_device *, int *);
	int (*set_timeout)(struct wdt_device *, int);
	int (*get_nowayout)(struct wdt_device *, int *);
	int (*set_nowayout)(struct wdt_device *, int);
	int (*get_status)(struct wdt_device *, int *);
	int (*get_caps)(struct wdt_device *, int *);
	int (*get_bootstatus)(struct wdt_device *, int *);
	int (*get_temperature)(struct wdt_device *, int *);
	int (*get_enable)(struct wdt_device *, int *);
	int (*set_enable)(struct wdt_device *, int);
	int (*get_temppanic)(struct wdt_device *, int *);
	int (*set_temppanic)(struct wdt_device *, int);
};

The following patch adds the infrastructure to the 2.5.60 kernel.
I am also attaching a dummy watchdog driver file that uses this 
infrastructure.

* NOTE: We could also add code to base.c that would enable one of the
        registered watchdog devices to also be a misc char device using
        the documented watchdog minor number without the driver doing
        anything extra.

    --rustyl

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1032  -> 1.1033 
#	drivers/char/watchdog/Makefile	1.5     -> 1.6    
#	include/linux/watchdog.h	1.4     -> 1.5    
#	               (new)	        -> 1.1     drivers/char/watchdog/base.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/12	rusty@penguin.co.intel.com	1.1033
# Adding a common infrastructure for watchdog timers to implement
# a sysfs interface
# --------------------------------------------
#
diff -Nru a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile	Wed Feb 12 18:50:18 2003
+++ b/drivers/char/watchdog/Makefile	Wed Feb 12 18:50:18 2003
@@ -7,6 +7,8 @@
 # watchdog dies or is 'borrowed' for some reason the software watchdog
 # still gives you some cover.
 
+obj-y += base.o
+
 obj-$(CONFIG_PCWATCHDOG) += pcwd.o
 obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
 obj-$(CONFIG_ADVANTECH_WDT) += advantechwdt.o
diff -Nru a/drivers/char/watchdog/base.c b/drivers/char/watchdog/base.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/char/watchdog/base.c	Wed Feb 12 18:50:18 2003
@@ -0,0 +1,327 @@
+/*
+ * base.c
+ *
+ * Base watchdog timer infrastructure
+ *
+ * Copyright (C) 2003 Rusty Lynch <rusty@linux.co.intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY 
+ * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
+ * THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <rusty@linux.co.intel.com>
+ */
+
+#include <linux/module.h>
+#include <linux/watchdog.h>
+
+#ifdef DEBUG
+#define trace(format, args...) \
+        printk(KERN_INFO "%s(" format ")\n", __FUNCTION__ , ## arg)
+#else
+#define trace(format, arg...) do { } while (0)
+#endif
+
+ssize_t start_show(struct device * dev, char * buf)
+{
+	struct wdt_device *w = to_wdt_device(dev);
+
+	trace("%p, %p", dev, buf);
+	if (!(w->ops->start))
+		return -ENODEV;
+
+	if ((w->ops->start)(w))
+		return -EFAULT;
+
+	return 0;
+}
+DEVICE_ATTR(start,S_IRUSR,start_show,NULL);
+
+ssize_t stop_show(struct device * dev, char * buf)
+{
+	struct wdt_device *w = to_wdt_device(dev);
+
+	trace("%p, %p", dev, buf);
+	if (!(w->ops->stop))
+		return -ENODEV;
+
+	if ((w->ops->stop)(w, 0))
+		return -EFAULT;
+
+	return 0;
+}
+ssize_t stop_store(struct device * dev, const char * buf, size_t count)
+{
+	struct wdt_device *w = to_wdt_device(dev);
+
+	trace("%p, %p, %i", dev, buf, count);
+	if (!(w->ops->stop))
+		return -ENODEV;
+
+	if ((w->ops->stop)(w, buf))
+		return -EFAULT;
+
+	return count;
+}
+DEVICE_ATTR(stop,S_IRUSR|S_IWUSR,stop_show,stop_store);
+
+ssize_t timeout_show(struct device * dev, char * buf)
+{
+	int timeout;
+	struct wdt_device *w = to_wdt_device(dev);
+
+	trace("%p, %p", dev, buf);
+	if (!(w->ops->get_timeout))
+		return -ENODEV;
+
+	if((w->ops->get_timeout)(w, &timeout))
+		return -EFAULT;
+
+	return sprintf(buf, "%i\n", timeout);
+}
+ssize_t timeout_store(struct device * dev, const char * buf, size_t count)
+{
+	int timeout;
+	struct wdt_device *w = to_wdt_device(dev);
+
+	trace("%p, %p, %i", dev, buf, count);
+	if (!(w->ops->set_timeout))
+		return -ENODEV;
+
+	if (!sscanf(buf,"%i",&timeout))
+		return -EINVAL;
+
+	if ((w->ops->set_timeout)(w, timeout))
+		return -EFAULT;
+
+	return count;
+}
+DEVICE_ATTR(timeout,S_IRUGO|S_IWUSR,timeout_show,timeout_store);
+
+ssize_t keepalive_show(struct device * dev, char * buf)
+{
+	struct wdt_device *w = to_wdt_device(dev);
+
+	trace("%p, %p", dev, buf);
+	if (!(w->ops->keepalive))
+		return -ENODEV;
+
+	if ((w->ops->keepalive)(w))
+		return -EFAULT;
+
+	return 0;
+}
+DEVICE_ATTR(keepalive,S_IRUSR,keepalive_show,NULL);
+
+ssize_t nowayout_show(struct device * dev, char * buf)
+{
+	int nowayout;
+	struct wdt_device *w = to_wdt_device(dev);
+
+	trace("%p, %p", dev, buf);
+	if (!(w->ops->get_nowayout))
+		return -ENODEV;
+
+	if ((w->ops->get_nowayout)(w, &nowayout))
+		return -EFAULT;
+
+	return sprintf(buf, "%i\n", nowayout);
+}
+ssize_t nowayout_store(struct device * dev, const char * buf, size_t count)
+{
+	int nowayout;
+	struct wdt_device *w = to_wdt_device(dev);
+
+	trace("%p, %p, %i", dev, buf, count);
+	if (!(w->ops->set_nowayout))
+		return -ENODEV;
+
+	if (!sscanf(buf,"%i",&nowayout))
+		return -EINVAL;
+
+	if ((w->ops->set_nowayout)(w, nowayout))
+		return -EFAULT;
+
+	return count;
+}
+DEVICE_ATTR(nowayout,S_IRUGO|S_IWUSR,nowayout_show,nowayout_store);
+
+ssize_t status_show(struct device * dev, char * buf)
+{
+	int status;
+	struct wdt_device *w = to_wdt_device(dev);
+
+	trace("%p, %p", dev, buf);
+	if (!(w->ops->get_status))
+		return -ENODEV;
+
+	if ((w->ops->get_status)(w, &status))
+		return -EFAULT;
+
+	return sprintf(buf, "0x%08x\n", status);
+}
+DEVICE_ATTR(status,S_IRUGO,status_show,NULL);
+
+ssize_t bootstatus_show(struct device * dev, char * buf)
+{
+	int bootstatus;
+	struct wdt_device *w = to_wdt_device(dev);
+
+	trace("%p, %p", dev, buf);
+	if (!(w->ops->get_bootstatus))
+		return -ENODEV;
+
+	if ((w->ops->get_bootstatus)(w, &bootstatus))
+		return -EFAULT;
+
+	return sprintf(buf, "0x%08x\n", bootstatus);
+}
+DEVICE_ATTR(bootstatus,S_IRUGO,bootstatus_show,NULL);
+
+ssize_t temperature_show(struct device * dev, char * buf)
+{
+	int temperature;
+	struct wdt_device *w = to_wdt_device(dev);
+
+	trace("%p, %p", dev, buf);
+	if (!(w->ops->get_temperature))
+		return -ENODEV;
+
+	if ((w->ops->get_temperature)(w, &temperature))
+		return -EFAULT;
+
+	return sprintf(buf, "%i\n", temperature);
+}
+DEVICE_ATTR(temperature,S_IRUGO,temperature_show,NULL);
+
+ssize_t enable_show(struct device * dev, char * buf)
+{
+	int enable;
+	struct wdt_device *w = to_wdt_device(dev);
+
+	trace("%p, %p", dev, buf);
+	if (!(w->ops->get_enable))
+		return -ENODEV;
+
+	if ((w->ops->get_enable)(w, &enable))
+		return -EFAULT;
+
+	return sprintf(buf, "%i\n", enable);
+}
+ssize_t enable_store(struct device * dev, const char * buf, size_t count)
+{
+	int enable;
+	struct wdt_device *w = to_wdt_device(dev);
+
+	trace("%p, %p, %i", dev, buf, count);
+	if (!(w->ops->set_enable))
+		return -ENODEV;
+
+	if (!sscanf(buf,"%i",&enable))
+		return -EINVAL;
+
+	if ((w->ops->set_enable)(w, enable))
+		return -EFAULT;
+
+	return count;
+}
+DEVICE_ATTR(enable,S_IRUGO|S_IWUSR,enable_show,enable_store);
+
+ssize_t temppanic_show(struct device * dev, char * buf)
+{
+	int temppanic;
+	struct wdt_device *w = to_wdt_device(dev);
+
+	trace("%p, %p", dev, buf);
+	if (!(w->ops->get_temppanic))
+		return -ENODEV;
+
+	if ((w->ops->get_temppanic)(w, &temppanic))
+		return -EFAULT;
+
+	return sprintf(buf, "%i\n", temppanic);
+}
+ssize_t temppanic_store(struct device * dev, const char * buf, size_t count)
+{
+	int temppanic;
+	struct wdt_device *w = to_wdt_device(dev);
+
+	trace("%p, %p, %i", dev, buf, count);
+	if (!(w->ops->set_temppanic))
+		return -ENODEV;
+
+	if (!sscanf(buf,"%i",&temppanic))
+		return -EINVAL;
+
+	if ((w->ops->set_temppanic)(w, temppanic))
+		return -EFAULT;
+
+	return count;
+}
+DEVICE_ATTR(temppanic,S_IRUGO|S_IWUSR,temppanic_show,temppanic_store);
+
+static int wdt_create_default_files(struct wdt_device *d)
+{
+	device_create_file(&(d->dev.dev), &dev_attr_start);
+	device_create_file(&(d->dev.dev), &dev_attr_stop);
+	device_create_file(&(d->dev.dev), &dev_attr_timeout);
+	device_create_file(&(d->dev.dev), &dev_attr_keepalive);
+	device_create_file(&(d->dev.dev), &dev_attr_nowayout);
+	device_create_file(&(d->dev.dev), &dev_attr_status);
+	device_create_file(&(d->dev.dev), &dev_attr_bootstatus);
+	device_create_file(&(d->dev.dev), &dev_attr_temperature);
+	device_create_file(&(d->dev.dev), &dev_attr_enable);
+	device_create_file(&(d->dev.dev), &dev_attr_temppanic);
+
+	return 0;
+}
+
+static void wdt_remove_default_files(struct wdt_device *d)
+{
+	device_remove_file(&(d->dev.dev), &dev_attr_start);
+	device_remove_file(&(d->dev.dev), &dev_attr_stop);
+	device_remove_file(&(d->dev.dev), &dev_attr_timeout);
+	device_remove_file(&(d->dev.dev), &dev_attr_keepalive);
+	device_remove_file(&(d->dev.dev), &dev_attr_nowayout);
+	device_remove_file(&(d->dev.dev), &dev_attr_status);
+	device_remove_file(&(d->dev.dev), &dev_attr_bootstatus);
+	device_remove_file(&(d->dev.dev), &dev_attr_temperature);
+	device_remove_file(&(d->dev.dev), &dev_attr_enable);
+	device_remove_file(&(d->dev.dev), &dev_attr_temppanic);
+}
+
+int wdt_device_register(struct wdt_device *d) 
+{
+	int rv;
+
+	rv = platform_device_register(&(d->dev));
+	if (!rv)
+		rv = wdt_create_default_files(d);
+
+	return rv;
+}
+
+void wdt_device_unregister(struct wdt_device *d)
+{
+	platform_device_unregister(&(d->dev));
+	wdt_remove_default_files(d);
+}
+
+EXPORT_SYMBOL_GPL(wdt_device_register);
+EXPORT_SYMBOL_GPL(wdt_device_unregister);
diff -Nru a/include/linux/watchdog.h b/include/linux/watchdog.h
--- a/include/linux/watchdog.h	Wed Feb 12 18:50:18 2003
+++ b/include/linux/watchdog.h	Wed Feb 12 18:50:18 2003
@@ -10,9 +10,28 @@
 #define _LINUX_WATCHDOG_H
 
 #include <linux/ioctl.h>
+#include <linux/device.h>
 
 #define	WATCHDOG_IOCTL_BASE	'W'
 
+#define decl_wdt_device(_name,_ops,_desc)               \
+static struct wdt_device _name##_device = {             \
+	.ops = &_ops,                                   \
+	.dev = {                                        \
+		.name = "watchdog",                     \
+		.id		= 0,                    \
+		.dev		= {                     \
+			.name	= __stringify(_desc),   \
+		},                                      \
+	},                                              \
+}
+
+#define to_pf_device(n) container_of(n, struct platform_device, dev)
+#define to_wdt_device(n) container_of(to_pf_device(n), struct wdt_device, dev)
+
+struct wdt_device;
+struct wdt_ops;
+
 struct watchdog_info {
 	__u32 options;		/* Options the card/driver supports */
 	__u32 firmware_version;	/* Firmware version of the card */
@@ -45,5 +64,31 @@
 #define	WDIOS_DISABLECARD	0x0001	/* Turn off the watchdog timer */
 #define	WDIOS_ENABLECARD	0x0002	/* Turn on the watchdog timer */
 #define	WDIOS_TEMPPANIC		0x0004	/* Kernel panic on temperature trip */
+
+struct wdt_device {
+	struct wdt_ops *ops;
+	struct platform_device dev;
+};
+
+struct wdt_ops {
+	int (*start)(struct wdt_device *);
+	int (*stop)(struct wdt_device *, const char *);
+	int (*keepalive)(struct wdt_device *);
+	int (*get_timeout)(struct wdt_device *, int *);
+	int (*set_timeout)(struct wdt_device *, int);
+	int (*get_nowayout)(struct wdt_device *, int *);
+	int (*set_nowayout)(struct wdt_device *, int);
+	int (*get_status)(struct wdt_device *, int *);
+	int (*get_caps)(struct wdt_device *, int *);
+	int (*get_bootstatus)(struct wdt_device *, int *);
+	int (*get_temperature)(struct wdt_device *, int *);
+	int (*get_enable)(struct wdt_device *, int *);
+	int (*set_enable)(struct wdt_device *, int);
+	int (*get_temppanic)(struct wdt_device *, int *);
+	int (*set_temppanic)(struct wdt_device *, int);
+};
+
+int  wdt_device_register(struct wdt_device *);
+void wdt_device_unregister(struct wdt_device *);
 
 #endif  /* ifndef _LINUX_WATCHDOG_H */


--=-VevvzYngPLbJwRx3iG35
Content-Disposition: attachment; filename=dummy.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; name=dummy.c; charset=UTF-8

/*
 * dummy.c
 *
 * Dummy watchdog timer created for testing base.c
 *
 * Copyright (C) 2003 Rusty Lynch <rusty@linux.co.intel.com>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY=
=20
 * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL=20
 * THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,=20
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,=20
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR=20
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF=20
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING=20
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS=20
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 * Send feedback to <rusty@linux.co.intel.com>
 */

#include <linux/config.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>
#include <linux/kobject.h>
#include <linux/ioport.h>
#include <linux/device.h>
#include <linux/watchdog.h>
#include <asm/io.h>

#define dbg(format, arg...)				\
		 printk (KERN_DEBUG "%s: " format "\n",	\
			 __FUNCTION__, ## arg);
#define trace(format, arg...)				 \
                 printk(KERN_INFO "%s(" format ")\n",    \
		               __FUNCTION__ , ## arg);
#define err(format, arg...) \
                printk(KERN_ERR "%s: " format "\n", \
		       __FUNCTION__ , ## arg)
#define info(format, arg...) \
                printk(KERN_INFO "%s: " format "\n", \
		       __FUNCTION__ , ## arg)
#define warn(format, arg...) \
                printk(KERN_WARNING "%s: " format "\n", \
		       __FUNCTION__ , ## arg)

int dummy_start(struct wdt_device *d)
{
	trace("%s", d->dev.name);
	return 0;
}

int dummy_stop(struct wdt_device *d, const char *m)
{
	trace("%s, %p", d->dev.name, m);
	return 0;
}

int dummy_keepalive(struct wdt_device *d)=20
{
	trace("%s", d->dev.name);
	return 0;
}

int dummy_get_timeout(struct wdt_device *d, int *t)
{
	trace("%s, %p", d->dev.name, t);
	*t =3D 911;
	return 0;
}

int dummy_set_timeout(struct wdt_device *d, int t)
{
	trace("%s, %i", d->dev.name, t);

	return 0;
}

int dummy_get_nowayout(struct wdt_device *d, int *n)
{
	trace("%s, %p", d->dev.name, n);

	*n =3D 911;
	return 0;
}

int dummy_set_nowayout(struct wdt_device *d, int n)
{
	trace("%s, %i", d->dev.name, n);=09
	return 0;
}

int dummy_get_status(struct wdt_device *d, int *s)
{
	trace("%s, %p", d->dev.name, s);
	*s =3D 911;
	return 0;
}

int dummy_get_caps(struct wdt_device *d, int *c)
{
	trace("%s, %p", d->dev.name, c);
	*c =3D 911;
	return 0;
}

int dummy_get_bootstatus(struct wdt_device *d, int *b)
{
	trace("%s, %p", d->dev.name, b);
	*b =3D 911;
	return 0;
}

int dummy_get_temperature(struct wdt_device *d, int *t)
{
	trace("%s, %p", d->dev.name, t);
	*t =3D 911;
	return 0;
}

int dummy_get_enable(struct wdt_device *d, int *e)
{
	trace("%s, %p", d->dev.name, e);
	*e =3D 911;
	return 0;
}

int dummy_set_enable(struct wdt_device *d, int e)
{
	trace("%s, %i", d->dev.name, e);
	return 0;
}

int dummy_get_temppanic(struct wdt_device *d, int *p)
{
	trace("%s, %p", d->dev.name, p);
	*p =3D 911;
	return 0;
}

int dummy_set_temppanic(struct wdt_device *d, int p)
{
	trace("%s, %i", d->dev.name, p);
	return 0;
}

/* Additional Sysfs Files */
ssize_t statistics_show(struct device * dev, char * buf)
{
	struct wdt_device *w =3D to_wdt_device(dev);

	trace("%p, %p", dev, buf);
	return sprintf(buf, "%s: dummy statistics data", w->dev.name);
}
DEVICE_ATTR(statistics,0644,statistics_show,NULL);

static struct wdt_ops dummy_ops =3D {
	.start =3D dummy_start,
	.stop =3D dummy_stop,
	.keepalive =3D dummy_keepalive,
	.get_timeout =3D dummy_get_timeout,
	.set_timeout =3D dummy_set_timeout,
	.get_nowayout =3D dummy_get_nowayout,
	.set_nowayout =3D dummy_set_nowayout,
	.get_status =3D dummy_get_status,
	.get_caps =3D dummy_get_caps,
	.get_bootstatus =3D dummy_get_bootstatus,
	.get_temperature =3D dummy_get_temperature,
	.get_enable =3D dummy_get_enable,
	.set_enable =3D dummy_set_enable,
	.get_temppanic =3D dummy_get_temppanic,
	.set_temppanic =3D dummy_set_temppanic,
};

decl_wdt_device(dummy, dummy_ops, Dummy Watchdog Timer);

static int __init dummy_init(void)
{
	int ret =3D 0;

	trace();
	ret =3D wdt_device_register(&dummy_device);
	if (ret) {
		err("failed to register watchdog device");
		return -ENODEV;
	}

	device_create_file(&dummy_device.dev.dev, &dev_attr_statistics);
	return 0;
}

static void __exit dummy_exit(void)
{
	trace();
	device_remove_file(&dummy_device.dev.dev, &dev_attr_statistics);
	wdt_device_unregister(&dummy_device);
}

module_init(dummy_init);
module_exit(dummy_exit);
MODULE_LICENSE("GPL");

--=-VevvzYngPLbJwRx3iG35--

