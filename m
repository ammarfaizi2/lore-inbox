Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268694AbTCCSfO>; Mon, 3 Mar 2003 13:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268696AbTCCSfO>; Mon, 3 Mar 2003 13:35:14 -0500
Received: from fmr05.intel.com ([134.134.136.6]:9969 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id <S268694AbTCCSfA>;
	Mon, 3 Mar 2003 13:35:00 -0500
Subject: [2.5.63 PATCH][RESUBMIT] Sysfs based watchdog infrastructure
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Mar 2003 10:43:01 -0800
Message-Id: <1046716982.2671.8.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is a resubmit of the sysfs based watchdog driver infrastructure
diff'ed against the 2.5.63 kernel, along with a few fixes for bugs that
I have found will testing the ported softdog watchdog driver and the new
zt55XX watchdog driver.

I also made the sysfs file creation based on the available support for a 
given feature.  For example if your watchdog device doesn't not have the
ability to provide a firmware version, and leaves the get_firmware_version
function pointer as null, then there will be no 'firmware_version' file
in your drivers sysfs directory.

The softdog driver does not support the status, bootstatus,
temppanic (panic on over temperature), or the ability go get
a firmware version.

static struct watchdog_ops softdog_ops = {
	.start                 = softdog_start,
	.stop                  = softdog_stop,
	.keepalive             = softdog_keepalive,
	.get_timeout           = softdog_get_timeout,
	.set_timeout           = softdog_set_timeout,
	.get_nowayout          = softdog_get_nowayout,
	.set_nowayout          = softdog_set_nowayout,
	.get_options           = softdog_get_options,
	/* get_bootstatus not implemented */
	/* get_status not implemented */
	/* get/set_temppanic not implemented */
	/* get_firmware_version not implemented */
 };

Which translates into the following directory listing in sysfs:

[root@penguin2 root]# tree /sys/class/watchdog/drivers/system\:softdog/
/sys/class/watchdog/drivers/system:softdog/
|-- keepalive
|-- nowayout
|-- options
|-- soft_noboot
|-- start
|-- stop
`-- timeout


diff -Nru a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile	Fri Feb 28 20:09:48 2003
+++ b/drivers/char/watchdog/Makefile	Fri Feb 28 20:09:48 2003
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
+++ b/drivers/char/watchdog/base.c	Fri Feb 28 20:09:48 2003
@@ -0,0 +1,623 @@
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
+
+		if (get_user(tmp, (int *)arg))
+			return -EFAULT;
+
+		if (tmp < 1)
+			return -EINVAL;
+
+		if (miscdev->ops->set_timeout(miscdev, tmp))
+			return -EFAULT;
+
+		if (miscdev->ops->keepalive)
+			miscdev->ops->keepalive(miscdev);
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
+	if (d->ops->start) 
+		driver_create_file(&(d->driver), &driver_attr_start);
+	if (d->ops->stop) 
+		driver_create_file(&(d->driver), &driver_attr_stop);
+	if (d->ops->get_timeout || d->ops->set_timeout) 
+		driver_create_file(&(d->driver), &driver_attr_timeout);
+	if (d->ops->keepalive) 
+		driver_create_file(&(d->driver), &driver_attr_keepalive);
+	if (d->ops->get_nowayout || d->ops->set_nowayout) 
+		driver_create_file(&(d->driver), &driver_attr_nowayout);
+	if (d->ops->get_status) 
+		driver_create_file(&(d->driver), &driver_attr_status);
+	if (d->ops->get_bootstatus) 
+		driver_create_file(&(d->driver), &driver_attr_bootstatus);
+	if (d->ops->get_options) 
+		driver_create_file(&(d->driver), &driver_attr_options);
+	if (d->ops->get_temperature) 
+		driver_create_file(&(d->driver), &driver_attr_temperature);
+	if (d->ops->get_temppanic || d->ops->set_temppanic) 
+		driver_create_file(&(d->driver), &driver_attr_temppanic);
+	if (d->ops->get_firmware_version) 
+		driver_create_file(&(d->driver), &driver_attr_firmware_version);
+	return 0;
+}
+
+static void watchdog_remove_default_files(struct watchdog_driver *d)
+{
+	if (d->ops->start) 
+		driver_remove_file(&(d->driver), &driver_attr_start);
+	if (d->ops->stop) 
+		driver_remove_file(&(d->driver), &driver_attr_stop);
+	if (d->ops->get_timeout || d->ops->set_timeout) 
+		driver_remove_file(&(d->driver), &driver_attr_timeout);
+	if (d->ops->keepalive) 
+		driver_remove_file(&(d->driver), &driver_attr_keepalive);
+	if (d->ops->get_nowayout || d->ops->set_nowayout) 
+		driver_remove_file(&(d->driver), &driver_attr_nowayout);
+	if (d->ops->get_status) 
+		driver_remove_file(&(d->driver), &driver_attr_status);
+	if (d->ops->get_bootstatus) 
+		driver_remove_file(&(d->driver), &driver_attr_bootstatus);
+	if (d->ops->get_options) 
+		driver_remove_file(&(d->driver), &driver_attr_options);
+	if (d->ops->get_temperature) 
+		driver_remove_file(&(d->driver), &driver_attr_temperature);
+	if (d->ops->get_temppanic || d->ops->set_temppanic) 
+		driver_remove_file(&(d->driver), &driver_attr_temppanic);
+	if (d->ops->get_firmware_version) 
+		driver_remove_file(&(d->driver), &driver_attr_firmware_version);}
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
--- a/include/linux/watchdog.h	Fri Feb 28 20:34:04 2003
+++ b/include/linux/watchdog.h	Fri Feb 28 20:34:04 2003
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


