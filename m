Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267640AbTBUXY1>; Fri, 21 Feb 2003 18:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267801AbTBUXY1>; Fri, 21 Feb 2003 18:24:27 -0500
Received: from fmr06.intel.com ([134.134.136.7]:13782 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S267640AbTBUXYP>; Fri, 21 Feb 2003 18:24:15 -0500
Subject: [PATCH][2.5] Sysfs enabling watchdog infrastructure
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Feb 2003 15:21:38 -0800
Message-Id: <1045869699.1037.6.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Inlined at the end of this email is a patch to implement the latest version 
of the sysfs based watchdog infrastructure refereed to in my previous email
thread.  I have been performing more testing (and makeing bug fixes found in
the testing) and also ported the softdog driver to use this infrastructure, 
and ported a driver donated by Scott Murray for the ZT55XX line of CompactPCI 
cpu blades.

By using this infrastructure, a watchdog driver will pop up in the sysfs
topography, with sysfs control files for performing all the actions that
were traditionally performed via ioctl calls.  In addition the infrastructure
will create a miscdevice that implements all the old ioctl functionality
on behalf of the watchdog driver, increasing code reuse and also making it
easier to remove the watchdog ioctl interface for all watchdog drivers once
the community is ready to make that leap.

I will send patches for the ported drivers on this mail thread.

Here is the system view from the command line when using this patch with
the ported softdog driver:

[root@penguin2 root]# tree /sys/class/watchdog/
/sys/class/watchdog/
|-- devices
`-- drivers

2 directories, 0 files
[root@penguin2 root]# /usr/local/sbin/modprobe softdog
[root@penguin2 root]# tree /sys/class/watchdog/
/sys/class/watchdog/
|-- devices
`-- drivers
    `-- system:softdog -> ../../../bus/system/drivers/softdog

3 directories, 0 files
[root@penguin2 root]# tree /sys/class/watchdog/drivers/system:softdog/
/sys/class/watchdog/drivers/system:softdog/
|-- bootstatus
|-- firmware_version
|-- keepalive
|-- nowayout
|-- options
|-- soft_noboot
|-- start
|-- status
|-- stop
|-- temperature
|-- temppanic
`-- timeout

0 directories, 12 files
[root@penguin2 root]# cd /sys/class/watchdog/drivers/system:softdog/
[root@penguin2 system:softdog]# cat timeout 
60
[root@penguin2 system:softdog]# echo 100 > timeout 
[root@penguin2 system:softdog]# cat timeout 
100

    --rustyl

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1032  -> 1.1040 
#	drivers/char/watchdog/Makefile	1.5     -> 1.8    
#	include/linux/watchdog.h	1.4     -> 1.9    
#	               (new)	        -> 1.5     drivers/char/watchdog/base.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/12	rusty@penguin.co.intel.com	1.1033
# Adding a common infrastructure for watchdog timers to implement
# a sysfs interface
# --------------------------------------------
# 03/02/13	rusty@penguin.co.intel.com	1.1034
# Moving wdt_device from a platform_device to a sys_device,
# making stop/start/keepalive be write-only, and removing the get_enable
# and set_enable callbacks.
# --------------------------------------------
# 03/02/13	rusty@penguin.co.intel.com	1.1035
# Changes that should have been adde to the last changeset
# --------------------------------------------
# 03/02/13	rusty@penguin.co.intel.com	1.1036
# Reworked the watchdog infrastructure implementation to use the sysfs
# class concept.
# --------------------------------------------
# 03/02/19	rusty@penguin.co.intel.com	1.1037
# Added support for /dev/watchdog by registering the first watchdog
# as a miscdevice using the watchdog minor.  Also added a new callback
# to enable the firmware version of the watchdog to be queried as 
# specified in watchdog-api.txt.
# --------------------------------------------
# 03/02/19	rusty@penguin.co.intel.com	1.1038
# Removed the dummy1 and dummy2 testing files
# --------------------------------------------
# 03/02/21	rusty@penguin.co.intel.com	1.1039
# * Changed stop callback to not take a string for the watchdog driver
#   to figure out if it contains the magic char, and left all the magic
#   char stuff to the common miscdevice code
# * Fixed code so that module loading and unloading really work.
# --------------------------------------------
# 03/02/21	rusty@penguin.co.intel.com	1.1040
# * changed stop callback to not take a string
# * wrapped kernel specific definitions to only be visible to the kernel
# --------------------------------------------
#
diff -Nru a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile	Fri Feb 21 14:41:04 2003
+++ b/drivers/char/watchdog/Makefile	Fri Feb 21 14:41:04 2003
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
+++ b/drivers/char/watchdog/base.c	Fri Feb 21 14:41:04 2003
@@ -0,0 +1,603 @@
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
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/watchdog.h>
+
+#include <linux/miscdevice.h>
+
+#ifdef DEBUG
+#define trace(format, args...) \
+        printk(KERN_INFO "%s(" format ")\n", __FUNCTION__ , ## args)
+#define dbg(format, arg...)				\
+		 printk (KERN_DEBUG "%s: " format "\n",	\
+			 __FUNCTION__, ## arg);
+#else
+#define trace(format, arg...) do { } while (0)
+#define dbg(format, arg...) do { } while (0)
+#endif
+
+#define crit(format, arg...) \
+                printk(KERN_CRIT "%s: " format "\n", \
+		       __FUNCTION__ , ## arg)
+
+static struct watchdog_driver *miscdev = 0;
+static int expect_close = 0;
+
+static DECLARE_MUTEX(watchdog_sem);
+
+static int miscdev_open(struct inode *inode, struct file *file)
+{
+	trace("%p, %p", inode, file);
+	if (!miscdev || !miscdev->ops->start)
+		return -ENODEV;
+
+	if (miscdev->ops->start(miscdev))
+		return -EBUSY;
+
+	return 0;
+}
+
+static int miscdev_release(struct inode *inode, struct file *file)
+{
+	trace("%p, %p", inode, file);
+	if (!miscdev || !miscdev->ops->stop)
+		return -ENODEV;
+	
+	if (!expect_close) {
+		crit("watchdog device closed unexpectedly, allowing timeout!");
+		return 0;
+	}
+
+	if (miscdev->ops->stop(miscdev))
+		return -EBUSY;
+
+	return 0;
+}
+
+static ssize_t miscdev_write(struct file *file, const char *data, 
+			     size_t len, loff_t *ppos)
+{
+	trace("%p, %p, %i, %p", file, data, len, ppos);
+
+	/*  Can't seek (pwrite) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	if (!miscdev || !miscdev->ops->keepalive)
+		return -ENODEV;
+
+	/*
+	 *	Refresh the timer.
+	 */
+	if(len) {
+		int nowayout = 0;
+		if (miscdev->ops->get_nowayout)
+			miscdev->ops->get_nowayout(miscdev, &nowayout);
+		if (!nowayout) {
+			size_t i;
+
+			/* In case it was set long ago */
+			expect_close = 0;
+
+			for (i = 0; i != len; i++) {
+				char c;
+
+				if (get_user(c, data + i))
+					return -EFAULT;
+				if (c == 'V')
+					expect_close = 1;
+			}
+		}
+		miscdev->ops->keepalive(miscdev);
+		return 1;
+	}
+	return 0;
+}
+
+static int miscdev_ioctl(struct inode *inode, struct file *file,
+			 unsigned int cmd, unsigned long arg)
+{
+	int tmp;
+	static struct watchdog_info ident = {
+		.identity = "Watchdog Device",
+	};
+
+	trace("%p, %p, %i, %li", inode, file, cmd, arg);
+	if (!miscdev)
+		return -ENODEV;	
+
+	switch (cmd) {
+	default:
+		return -ENOTTY;
+	case WDIOC_GETSUPPORT:
+		if (miscdev->ops->get_firmware_version && 
+		    !miscdev->ops->get_firmware_version(miscdev, &tmp))
+			ident.firmware_version = tmp;
+			
+		if (miscdev->ops->get_options && 
+		    !miscdev->ops->get_options(miscdev, &tmp))
+			ident.options = tmp;		
+		
+		if(copy_to_user((struct watchdog_info *)arg, &ident, 
+				sizeof(ident)))
+			return -EFAULT;
+		return 0;		
+	case WDIOC_GETSTATUS:
+		if (!miscdev->ops->get_status || 
+		    miscdev->ops->get_status(miscdev, &tmp))
+			return -EFAULT;
+
+		tmp |= WDIOF_MAGICCLOSE;
+		if(copy_to_user((struct watchdog_info *)arg,&tmp,sizeof(tmp)))
+			return -EFAULT;		
+		return 0;
+	case WDIOC_GETBOOTSTATUS:
+		if (!miscdev->ops->get_bootstatus || 
+		    miscdev->ops->get_bootstatus(miscdev, &tmp))
+			return -EFAULT;
+
+		if(copy_to_user((struct watchdog_info *)arg,&tmp,sizeof(tmp)))
+			return -EFAULT;
+		
+		return 0;
+	case WDIOC_GETTEMP:
+		if (!miscdev->ops->get_temperature || 
+		    miscdev->ops->get_temperature(miscdev, &tmp))
+			return -EFAULT;
+
+		if(copy_to_user((struct watchdog_info *)arg,&tmp,sizeof(tmp)))
+			return -EFAULT;
+		
+		return 0;
+	case WDIOC_SETOPTIONS:
+		if (get_user(tmp, (int *)arg))
+			return -EFAULT;
+
+		if (tmp & WDIOS_DISABLECARD) {
+			if (!miscdev->ops->stop || 
+			    miscdev->ops->stop(miscdev))
+				return -EFAULT;			
+		}
+
+		if (tmp & WDIOS_ENABLECARD) {
+			if (!miscdev->ops->start || 
+			    miscdev->ops->start(miscdev))
+				return -EFAULT;			
+		}
+
+		if (tmp & WDIOS_TEMPPANIC) {
+			if (!miscdev->ops->set_temppanic || 
+			    miscdev->ops->set_temppanic(miscdev, 1))
+				return -EFAULT;			
+		}
+
+		return 0;
+	case WDIOC_KEEPALIVE:
+		if (!miscdev->ops->keepalive || 
+		    miscdev->ops->keepalive(miscdev))
+			return -EFAULT;
+
+		return 0;
+	case WDIOC_SETTIMEOUT:
+		if (!miscdev->ops->set_timeout)
+			return -EFAULT;
+		if (get_user(tmp, (int *)arg))
+			return -EFAULT;
+		if (tmp < 1)
+			return -EINVAL;
+
+		if (miscdev->ops->set_timeout(miscdev, tmp))
+			return -EFAULT;
+
+		if (!miscdev->ops->keepalive || 
+		    miscdev->ops->keepalive(miscdev))
+			return -EFAULT;
+
+		return 0;
+	case WDIOC_GETTIMEOUT:
+		if (!miscdev->ops->get_timeout || 
+		    miscdev->ops->get_timeout(miscdev, &tmp))
+			return -EFAULT;
+
+		if(copy_to_user((struct watchdog_info *)arg,&tmp,sizeof(tmp)))
+			return -EFAULT;
+		
+		return 0;
+	}
+}
+
+static struct file_operations watchdog_fops = {
+	.owner		= THIS_MODULE,
+	.write		= miscdev_write,
+	.ioctl		= miscdev_ioctl,
+	.open		= miscdev_open,
+	.release	= miscdev_release,
+};
+
+static struct miscdevice watchdog_miscdev = {
+	.minor		= WATCHDOG_MINOR,
+	.name		= "Watchdog Timer",
+	.fops		= &watchdog_fops,
+};
+
+ssize_t start_store(struct device_driver *d, const char *buf, size_t count)
+{
+	struct watchdog_driver *w = to_watchdog_driver(d);
+
+	trace("%p, %p, %i", d, buf, count);
+	if (!(w->ops->start))
+		return -ENODEV;
+
+	if ((w->ops->start)(w))
+		return -EFAULT;
+
+	return count;
+}
+DRIVER_ATTR(start,S_IWUSR,NULL,start_store);
+
+ssize_t stop_store(struct device_driver *d, const char *buf, size_t count)
+{
+	int nowayout = 0;
+	struct watchdog_driver *w = to_watchdog_driver(d);
+
+	trace("%p, %p, %i", d, buf, count);
+	if (!(w->ops->stop))
+		return -ENODEV;
+
+	if ((w->ops->stop)(w))
+		return -EFAULT;
+
+	return count;
+}
+DRIVER_ATTR(stop,S_IWUSR,NULL,stop_store);
+
+ssize_t timeout_show(struct device_driver *d, char *buf)
+{
+	int timeout;
+	struct watchdog_driver *w = to_watchdog_driver(d);
+
+	trace("%p, %p", d, buf);
+	if (!(w->ops->get_timeout))
+		return -ENODEV;
+
+	if((w->ops->get_timeout)(w, &timeout))
+		return -EFAULT;
+
+	return sprintf(buf, "%i\n", timeout);
+}
+ssize_t timeout_store(struct device_driver *d, const char *buf, size_t count)
+{
+	int timeout;
+	struct watchdog_driver *w = to_watchdog_driver(d);
+
+	trace("%p, %p, %i", d, buf, count);
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
+DRIVER_ATTR(timeout,S_IRUGO|S_IWUSR,timeout_show,timeout_store);
+
+ssize_t keepalive_store(struct device_driver *d, const char *buf, size_t count)
+{
+	struct watchdog_driver *w = to_watchdog_driver(d);
+
+	trace("%p, %p, %i", d, buf, count);
+	if (!(w->ops->keepalive))
+		return -ENODEV;
+
+	if ((w->ops->keepalive)(w))
+		return -EFAULT;
+
+	return count;
+}
+DRIVER_ATTR(keepalive,S_IWUSR,NULL,keepalive_store);
+
+ssize_t nowayout_show(struct device_driver *d, char *buf)
+{
+	int nowayout;
+	struct watchdog_driver *w = to_watchdog_driver(d);
+
+	trace("%p, %p", d, buf);
+	if (!(w->ops->get_nowayout))
+		return -ENODEV;
+
+	if ((w->ops->get_nowayout)(w, &nowayout))
+		return -EFAULT;
+
+	return sprintf(buf, "%i\n", nowayout);
+}
+ssize_t nowayout_store(struct device_driver *d, const char *buf, size_t count)
+{
+	int nowayout;
+	struct watchdog_driver *w = to_watchdog_driver(d);
+
+	trace("%p, %p, %i", d, buf, count);
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
+DRIVER_ATTR(nowayout,S_IRUGO|S_IWUSR,nowayout_show,nowayout_store);
+
+ssize_t status_show(struct device_driver *d, char *buf)
+{
+	int status;
+	struct watchdog_driver *w = to_watchdog_driver(d);
+
+	trace("%p, %p", d, buf);
+	if (!(w->ops->get_status))
+		return -ENODEV;
+
+	if ((w->ops->get_status)(w, &status))
+		return -EFAULT;
+
+	return sprintf(buf, "0x%08x\n", status);
+}
+DRIVER_ATTR(status,S_IRUGO,status_show,NULL);
+
+ssize_t bootstatus_show(struct device_driver *d, char *buf)
+{
+	int bootstatus;
+	struct watchdog_driver *w = to_watchdog_driver(d);
+
+	trace("%p, %p", d, buf);
+	if (!(w->ops->get_bootstatus))
+		return -ENODEV;
+
+	if ((w->ops->get_bootstatus)(w, &bootstatus))
+		return -EFAULT;
+
+	return sprintf(buf, "0x%08x\n", bootstatus);
+}
+DRIVER_ATTR(bootstatus,S_IRUGO,bootstatus_show,NULL);
+
+ssize_t options_show(struct device_driver *d, char *buf)
+{
+	int options;
+	struct watchdog_driver *w = to_watchdog_driver(d);
+
+	trace("%p, %p", d, buf);
+	if (!(w->ops->get_options))
+		return -ENODEV;
+
+	if ((w->ops->get_options)(w, &options))
+		return -EFAULT;
+
+	return sprintf(buf, "0x%08x\n", options);
+}
+DRIVER_ATTR(options,S_IRUGO,options_show,NULL);
+
+ssize_t temperature_show(struct device_driver *d, char *buf)
+{
+	int temperature;
+	struct watchdog_driver *w = to_watchdog_driver(d);
+
+	trace("%p, %p", d, buf);
+	if (!(w->ops->get_temperature))
+		return -ENODEV;
+
+	if ((w->ops->get_temperature)(w, &temperature))
+		return -EFAULT;
+
+	return sprintf(buf, "%i\n", temperature);
+}
+DRIVER_ATTR(temperature,S_IRUGO,temperature_show,NULL);
+
+ssize_t temppanic_show(struct device_driver *d, char *buf)
+{
+	int temppanic;
+	struct watchdog_driver *w = to_watchdog_driver(d);
+
+	trace("%p, %p", d, buf);
+	if (!(w->ops->get_temppanic))
+		return -ENODEV;
+
+	if ((w->ops->get_temppanic)(w, &temppanic))
+		return -EFAULT;
+
+	return sprintf(buf, "%i\n", temppanic);
+}
+ssize_t temppanic_store(struct device_driver *d, const char *buf, size_t count)
+{
+	int temppanic;
+	struct watchdog_driver *w = to_watchdog_driver(d);
+
+	trace("%p, %p, %i", d, buf, count);
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
+DRIVER_ATTR(temppanic,S_IRUGO|S_IWUSR,temppanic_show,temppanic_store);
+
+ssize_t firmware_version_show(struct device_driver *d, char *buf)
+{
+	int version;
+	struct watchdog_driver *w = to_watchdog_driver(d);
+
+	trace("%p, %p", d, buf);
+	if (!(w->ops->get_firmware_version))
+		return -ENODEV;
+
+	if ((w->ops->get_firmware_version)(w, &version))
+		return -EFAULT;
+
+	return sprintf(buf, "0x%08x\n", version);
+}
+DRIVER_ATTR(firmware_version,S_IRUGO,firmware_version_show,NULL);
+
+static int watchdog_create_default_files(struct watchdog_driver *d)
+{
+	driver_create_file(&(d->driver), &driver_attr_start);
+	driver_create_file(&(d->driver), &driver_attr_stop);
+	driver_create_file(&(d->driver), &driver_attr_timeout);
+	driver_create_file(&(d->driver), &driver_attr_keepalive);
+	driver_create_file(&(d->driver), &driver_attr_nowayout);
+	driver_create_file(&(d->driver), &driver_attr_status);
+	driver_create_file(&(d->driver), &driver_attr_bootstatus);
+	driver_create_file(&(d->driver), &driver_attr_options);
+	driver_create_file(&(d->driver), &driver_attr_temperature);
+	driver_create_file(&(d->driver), &driver_attr_temppanic);
+	driver_create_file(&(d->driver), &driver_attr_firmware_version);
+
+	return 0;
+}
+
+static void watchdog_remove_default_files(struct watchdog_driver *d)
+{
+	driver_remove_file(&(d->driver), &driver_attr_start);
+	driver_remove_file(&(d->driver), &driver_attr_stop);
+	driver_remove_file(&(d->driver), &driver_attr_timeout);
+	driver_remove_file(&(d->driver), &driver_attr_keepalive);
+	driver_remove_file(&(d->driver), &driver_attr_nowayout);
+	driver_remove_file(&(d->driver), &driver_attr_status);
+	driver_remove_file(&(d->driver), &driver_attr_bootstatus);
+	driver_remove_file(&(d->driver), &driver_attr_options);
+	driver_remove_file(&(d->driver), &driver_attr_temperature);
+	driver_remove_file(&(d->driver), &driver_attr_temppanic);
+	driver_remove_file(&(d->driver), &driver_attr_firmware_version);
+}
+
+int watchdog_driver_register(struct watchdog_driver *d) 
+{
+	int rv;
+
+	down(&watchdog_sem);
+
+	if (!get_driver(&(d->driver))) {
+		crit("unable to gain reference for %s driver", d->driver.name);
+		rv = -EFAULT;
+		goto error1;
+	}
+
+	rv = driver_register(&(d->driver));
+	if (rv) {
+		crit("unable to register %s driver", d->driver.name);
+		goto error2;
+	}
+
+	rv = watchdog_create_default_files(d);
+	if (rv) {
+		crit("unable to create %s driver sysfs files", d->driver.name);
+		goto error3;
+	}
+
+	dbg("miscdev  pointing to %s",miscdev? miscdev->driver.name:"nobody");
+	if (!miscdev) { 
+		if (misc_register(&watchdog_miscdev) == 0) {
+			dbg("registered %s as the miscdev", d->driver.name);
+			miscdev = d;
+		} else {
+			crit("%s failed misc_register()", d->driver.name);
+		}
+	}
+	up(&watchdog_sem);
+
+	return rv;
+
+ error3:
+	driver_unregister(&(d->driver));
+ error2:
+	put_driver(&(d->driver));
+ error1:
+	up(&watchdog_sem);
+	return rv;
+
+}
+
+void watchdog_driver_unregister(struct watchdog_driver *d)
+{
+	down(&watchdog_sem);
+	if (d && miscdev == d) {
+		dbg("deregistering %s as the misc device", d->driver.name);
+		miscdev = 0;
+		misc_deregister(&watchdog_miscdev);
+	}
+	
+	watchdog_remove_default_files(d);
+	driver_unregister(&(d->driver));
+	put_driver(&(d->driver));
+	up(&watchdog_sem);
+}
+
+struct device_class watchdog_devclass = {
+        .name		= "watchdog",
+};
+
+static int __init watchdog_init(void)
+{
+	int ret = 0;
+
+	trace();
+	ret = devclass_register(&watchdog_devclass);
+	if (ret)
+		return -ENODEV;
+
+	return 0;
+}
+
+static void __exit watchdog_exit(void)
+{
+	trace();
+	
+	if (miscdev)
+		misc_deregister(&watchdog_miscdev);
+
+	devclass_unregister(&watchdog_devclass);
+}
+
+module_init(watchdog_init);
+module_exit(watchdog_exit);
+EXPORT_SYMBOL_GPL(watchdog_driver_register);
+EXPORT_SYMBOL_GPL(watchdog_driver_unregister);
+EXPORT_SYMBOL_GPL(watchdog_devclass);
diff -Nru a/include/linux/watchdog.h b/include/linux/watchdog.h
--- a/include/linux/watchdog.h	Fri Feb 21 14:41:04 2003
+++ b/include/linux/watchdog.h	Fri Feb 21 14:41:04 2003
@@ -10,9 +10,17 @@
 #define _LINUX_WATCHDOG_H
 
 #include <linux/ioctl.h>
+#include <linux/device.h>
 
 #define	WATCHDOG_IOCTL_BASE	'W'
 
+#define to_watchdog_driver(n) container_of(n, struct watchdog_driver, driver)
+
+struct watchdog_driver;
+struct watchdog_ops;
+
+extern struct device_class watchdog_devclass;
+
 struct watchdog_info {
 	__u32 options;		/* Options the card/driver supports */
 	__u32 firmware_version;	/* Firmware version of the card */
@@ -46,4 +54,32 @@
 #define	WDIOS_ENABLECARD	0x0002	/* Turn on the watchdog timer */
 #define	WDIOS_TEMPPANIC		0x0004	/* Kernel panic on temperature trip */
 
+#ifdef __KERNEL__
+
+struct watchdog_driver {
+	struct watchdog_ops *ops;
+	struct device_driver driver;
+};
+
+struct watchdog_ops {
+	int (*start)(struct watchdog_driver *);
+	int (*stop)(struct watchdog_driver *);
+	int (*keepalive)(struct watchdog_driver *);
+	int (*get_timeout)(struct watchdog_driver *, int *);
+	int (*set_timeout)(struct watchdog_driver *, int);
+	int (*get_nowayout)(struct watchdog_driver *, int *);
+	int (*set_nowayout)(struct watchdog_driver *, int);
+	int (*get_status)(struct watchdog_driver *, int *);
+	int (*get_bootstatus)(struct watchdog_driver *, int *);
+	int (*get_options)(struct watchdog_driver *, int *);
+	int (*get_temperature)(struct watchdog_driver *, int *);
+	int (*get_temppanic)(struct watchdog_driver *, int *);
+	int (*set_temppanic)(struct watchdog_driver *, int);
+	int (*get_firmware_version)(struct watchdog_driver *, int *);
+};
+
+int  watchdog_driver_register(struct watchdog_driver *);
+void watchdog_driver_unregister(struct watchdog_driver *);
+
+#endif /* ifdef __KERNEL__ */
 #endif  /* ifndef _LINUX_WATCHDOG_H */



