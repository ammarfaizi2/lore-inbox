Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268204AbTBNBxX>; Thu, 13 Feb 2003 20:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268206AbTBNBxX>; Thu, 13 Feb 2003 20:53:23 -0500
Received: from fmr09.intel.com ([192.52.57.35]:40656 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id <S268204AbTBNBw7>;
	Thu, 13 Feb 2003 20:52:59 -0500
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: Matt Porter <porter@cox.net>, Scott Murray <scottm@somanetworks.com>,
       Patrick Mochel <mochel@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1045173941.1009.4.camel@vmhack>
References: <Pine.LNX.4.33.0302131317210.1133-100000@localhost.localdomain>
	<Pine.LNX.4.44.0302131603500.23407-100000@rancor.yyz.somanetworks.com> 
	<20030213155817.B1738@home.com>  <1045173941.1009.4.camel@vmhack>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Feb 2003 16:47:58 -0800
Message-Id: <1045183679.1009.7.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I had to go and read the driver-model documentation a couple of more
times, but after I actually started writing some code it finally started
to make sense.  

The following patch implements a new "watchdog_devclass" and a couple of 
registration functions:

int  watchdog_driver_register(struct watchdog_driver *);
void watchdog_driver_unregister(struct watchdog_driver *);

where ==>

struct watchdog_driver {
	struct watchdog_ops *ops;
	struct device_driver driver;
};

struct watchdog_ops {
	int (*start)(struct watchdog_driver *);
	int (*stop)(struct watchdog_driver *, const char *);
	int (*keepalive)(struct watchdog_driver *);
	int (*get_timeout)(struct watchdog_driver *, int *);
	int (*set_timeout)(struct watchdog_driver *, int);
	int (*get_nowayout)(struct watchdog_driver *, int *);
	int (*set_nowayout)(struct watchdog_driver *, int);
	int (*get_status)(struct watchdog_driver *, int *);
	int (*get_caps)(struct watchdog_driver *, int *);
	int (*get_bootstatus)(struct watchdog_driver *, int *);
	int (*get_temperature)(struct watchdog_driver *, int *);
	int (*get_temppanic)(struct watchdog_driver *, int *);
	int (*set_temppanic)(struct watchdog_driver *, int);
};

So, now instead of artificially making all watchdog drivers popup in
the sys or legacy directories, each driver will be registered with it's
correct bus and will also associate itself with watchdog_devclass.

This is done by ==>

static struct watchdog_ops dummy1_ops = {
	.start = dummy1_start,
	.stop = dummy1_stop,
	.keepalive = dummy1_keepalive,
	.get_timeout = dummy1_get_timeout,
	.set_timeout = dummy1_set_timeout,
	.get_nowayout = dummy1_get_nowayout,
	.set_nowayout = dummy1_set_nowayout,
	.get_status = dummy1_get_status,
	.get_caps = dummy1_get_caps,
	.get_bootstatus = dummy1_get_bootstatus,
	.get_temperature = dummy1_get_temperature,
	.get_temppanic = dummy1_get_temppanic,
	.set_temppanic = dummy1_set_temppanic,
};

static struct watchdog_driver dummy1_driver = {
	.ops = &dummy1_ops,
	.driver = {
		.name		= "dummy1",
		.bus		= &ADD_CORRECT_BUS_HERE,
		.devclass       = &watchdog_devclass,
		.probe		= dummy1_probe,
		.remove		= dummy1_remove,
		.suspend	= dummy1_suspend,
		.resume		= dummy1_resume,
	}
};

And then let the watchdog infrastructure register the driver and
create the sysfs control files by:

watchdog_driver_register(&dummy1_driver);

I created two dummy drivers that I associated with the "system" bus
because they are not really connected to a real bus.  This causes the
following to be created in sysfs:

[root@penguin2 root]# tree /sys/class/watchdog/drivers/
/sys/class/watchdog/drivers/
|-- system:dummy1 -> ../../../bus/system/drivers/dummy1
`-- system:dummy2 -> ../../../bus/system/drivers/dummy2

2 directories, 0 files
[root@penguin2 root]# tree /sys/class/watchdog/drivers/system:dummy1/
/sys/class/watchdog/drivers/system:dummy1/
|-- bootstatus
|-- keepalive
|-- nowayout
|-- start
|-- status
|-- stop
|-- temperature
|-- temppanic
`-- timeout

0 directories, 9 files

Here is a new patch that implements this.

    --rustyl

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1032  -> 1.1036 
#	drivers/char/watchdog/Makefile	1.5     -> 1.7    
#	include/linux/watchdog.h	1.4     -> 1.7    
#	               (new)	        -> 1.2     drivers/char/watchdog/dummy2.c
#	               (new)	        -> 1.2     drivers/char/watchdog/dummy1.c
#	               (new)	        -> 1.3     drivers/char/watchdog/base.c
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
#
diff -Nru a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile	Thu Feb 13 17:38:25 2003
+++ b/drivers/char/watchdog/Makefile	Thu Feb 13 17:38:25 2003
@@ -7,6 +7,8 @@
 # watchdog dies or is 'borrowed' for some reason the software watchdog
 # still gives you some cover.
 
+obj-y += base.o
+
 obj-$(CONFIG_PCWATCHDOG) += pcwd.o
 obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
 obj-$(CONFIG_ADVANTECH_WDT) += advantechwdt.o
@@ -29,3 +31,5 @@
 obj-$(CONFIG_ALIM7101_WDT) += alim7101_wdt.o
 obj-$(CONFIG_SC1200_WDT) += sc1200wdt.o
 obj-$(CONFIG_WAFER_WDT) += wafer5823wdt.o
+obj-y += dummy1.o
+obj-y += dummy2.o
diff -Nru a/drivers/char/watchdog/base.c b/drivers/char/watchdog/base.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/char/watchdog/base.c	Thu Feb 13 17:38:25 2003
@@ -0,0 +1,309 @@
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
+#ifdef DEBUG
+#define trace(format, args...) \
+        printk(KERN_INFO "%s(" format ")\n", __FUNCTION__ , ## arg)
+#else
+#define trace(format, arg...) do { } while (0)
+#endif
+
+static int device_count = 0;
+
+ssize_t start_store(struct device_driver *d, const char *buf, size_t count)
+{
+	struct watchdog_driver *w = to_watchdog_driver(d);
+
+	trace("%p, %p, %i", dev, buf, count);
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
+	trace("%p, %p, %i", dev, buf, count);
+	if (!(w->ops->stop))
+		return -ENODEV;
+
+	if ((w->ops->stop)(w, buf))
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
+	trace("%p, %p", dev, buf);
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
+DRIVER_ATTR(timeout,S_IRUGO|S_IWUSR,timeout_show,timeout_store);
+
+ssize_t keepalive_store(struct device_driver *d, const char *buf, size_t count)
+{
+	struct watchdog_driver *w = to_watchdog_driver(d);
+
+	trace("%p, %p, %i", dev, buf, count);
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
+	trace("%p, %p", dev, buf);
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
+DRIVER_ATTR(nowayout,S_IRUGO|S_IWUSR,nowayout_show,nowayout_store);
+
+ssize_t status_show(struct device_driver *d, char *buf)
+{
+	int status;
+	struct watchdog_driver *w = to_watchdog_driver(d);
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
+DRIVER_ATTR(status,S_IRUGO,status_show,NULL);
+
+ssize_t bootstatus_show(struct device_driver *d, char *buf)
+{
+	int bootstatus;
+	struct watchdog_driver *w = to_watchdog_driver(d);
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
+DRIVER_ATTR(bootstatus,S_IRUGO,bootstatus_show,NULL);
+
+ssize_t temperature_show(struct device_driver *d, char *buf)
+{
+	int temperature;
+	struct watchdog_driver *w = to_watchdog_driver(d);
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
+DRIVER_ATTR(temperature,S_IRUGO,temperature_show,NULL);
+
+ssize_t temppanic_show(struct device_driver *d, char *buf)
+{
+	int temppanic;
+	struct watchdog_driver *w = to_watchdog_driver(d);
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
+ssize_t temppanic_store(struct device_driver *d, const char *buf, size_t count)
+{
+	int temppanic;
+	struct watchdog_driver *w = to_watchdog_driver(d);
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
+DRIVER_ATTR(temppanic,S_IRUGO|S_IWUSR,temppanic_show,temppanic_store);
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
+	driver_create_file(&(d->driver), &driver_attr_temperature);
+	driver_create_file(&(d->driver), &driver_attr_temppanic);
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
+	driver_remove_file(&(d->driver), &driver_attr_temperature);
+	driver_remove_file(&(d->driver), &driver_attr_temppanic);
+}
+
+int watchdog_driver_register(struct watchdog_driver *d) 
+{
+	int rv;
+
+	rv = driver_register(&(d->driver));
+	if (!rv)
+		rv = watchdog_create_default_files(d);
+
+	return rv;
+}
+
+void watchdog_driver_unregister(struct watchdog_driver *d)
+{
+	driver_unregister(&(d->driver));
+	watchdog_remove_default_files(d);
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
+	devclass_unregister(&watchdog_devclass);
+}
+
+module_init(watchdog_init);
+module_exit(watchdog_exit);
+EXPORT_SYMBOL_GPL(watchdog_driver_register);
+EXPORT_SYMBOL_GPL(watchdog_driver_unregister);
+EXPORT_SYMBOL_GPL(watchdog_devclass);
diff -Nru a/drivers/char/watchdog/dummy1.c b/drivers/char/watchdog/dummy1.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/char/watchdog/dummy1.c	Thu Feb 13 17:38:25 2003
@@ -0,0 +1,222 @@
+/*
+ * dummy1.c
+ *
+ * Dummy watchdog timer created for testing base.c
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
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+#include <linux/watchdog.h>
+#include <asm/io.h>
+
+#define dbg(format, arg...)				\
+		 printk (KERN_DEBUG "%s: " format "\n",	\
+			 __FUNCTION__, ## arg);
+#define trace(format, arg...)				 \
+                 printk(KERN_INFO "%s(" format ")\n",    \
+		               __FUNCTION__ , ## arg);
+#define err(format, arg...) \
+                printk(KERN_ERR "%s: " format "\n", \
+		       __FUNCTION__ , ## arg)
+#define info(format, arg...) \
+                printk(KERN_INFO "%s: " format "\n", \
+		       __FUNCTION__ , ## arg)
+#define warn(format, arg...) \
+                printk(KERN_WARNING "%s: " format "\n", \
+		       __FUNCTION__ , ## arg)
+
+
+static int dummy1_start(struct watchdog_driver *d)
+{
+	trace("%s", d->driver.name);
+	return 0;
+}
+
+static int dummy1_stop(struct watchdog_driver *d, const char *m)
+{
+	trace("%s, %p", d->driver.name, m);
+	return 0;
+}
+
+static int dummy1_keepalive(struct watchdog_driver *d) 
+{
+	trace("%s", d->driver.name);
+	return 0;
+}
+
+static int dummy1_get_timeout(struct watchdog_driver *d, int *t)
+{
+	trace("%s, %p", d->driver.name, t);
+	*t = 911;
+	return 0;
+}
+
+static int dummy1_set_timeout(struct watchdog_driver *d, int t)
+{
+	trace("%s, %i", d->driver.name, t);
+
+	return 0;
+}
+
+static int dummy1_get_nowayout(struct watchdog_driver *d, int *n)
+{
+	trace("%s, %p", d->driver.name, n);
+
+	*n = 911;
+	return 0;
+}
+
+static int dummy1_set_nowayout(struct watchdog_driver *d, int n)
+{
+	trace("%s, %i", d->driver.name, n);	
+	return 0;
+}
+
+static int dummy1_get_status(struct watchdog_driver *d, int *s)
+{
+	trace("%s, %p", d->driver.name, s);
+	*s = 911;
+	return 0;
+}
+
+static int dummy1_get_caps(struct watchdog_driver *d, int *c)
+{
+	trace("%s, %p", d->driver.name, c);
+	*c = 911;
+	return 0;
+}
+
+static int dummy1_get_bootstatus(struct watchdog_driver *d, int *b)
+{
+	trace("%s, %p", d->driver.name, b);
+	*b = 911;
+	return 0;
+}
+
+static int dummy1_get_temperature(struct watchdog_driver *d, int *t)
+{
+	trace("%s, %p", d->driver.name, t);
+	*t = 911;
+	return 0;
+}
+
+static int dummy1_get_temppanic(struct watchdog_driver *d, int *p)
+{
+	trace("%s, %p", d->driver.name, p);
+	*p = 911;
+	return 0;
+}
+
+static int dummy1_set_temppanic(struct watchdog_driver *d, int p)
+{
+	trace("%s, %i", d->driver.name, p);
+	return 0;
+}
+
+static int dummy1_probe(struct device * dev)
+{
+	trace("%s", dev->name);
+	return 0;
+}
+static int dummy1_remove(struct device * dev)
+{
+	trace("%s", dev->name);
+	return 0;
+}
+static int dummy1_suspend(struct device * dev, u32 state, u32 level)
+{
+	trace("%s, %i, %i", dev->name, state, level);
+	return 0;
+}
+static int dummy1_resume(struct device * dev, u32 level)
+{
+	trace("%s, %i", dev->name, level);
+	return 0;
+}
+
+static void dummy1_release(struct device_driver * drv)
+{
+	trace("%s", drv->name);
+}
+
+static struct watchdog_ops dummy1_ops = {
+	.start = dummy1_start,
+	.stop = dummy1_stop,
+	.keepalive = dummy1_keepalive,
+	.get_timeout = dummy1_get_timeout,
+	.set_timeout = dummy1_set_timeout,
+	.get_nowayout = dummy1_get_nowayout,
+	.set_nowayout = dummy1_set_nowayout,
+	.get_status = dummy1_get_status,
+	.get_caps = dummy1_get_caps,
+	.get_bootstatus = dummy1_get_bootstatus,
+	.get_temperature = dummy1_get_temperature,
+	.get_temppanic = dummy1_get_temppanic,
+	.set_temppanic = dummy1_set_temppanic,
+};
+
+static struct watchdog_driver dummy1_driver = {
+	.ops = &dummy1_ops,
+	.driver = {
+		.name		= "dummy1",
+		.bus		= &system_bus_type,
+		.devclass       = &watchdog_devclass,
+		.probe		= dummy1_probe,
+		.remove		= dummy1_remove,
+		.suspend	= dummy1_suspend,
+		.resume		= dummy1_resume,
+	}
+};
+
+static int __init dummy1_init(void)
+{
+	int ret = 0;
+
+	trace();
+	ret = watchdog_driver_register(&dummy1_driver);
+	if (ret) {
+		err("failed to register watchdog device");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void __exit dummy1_exit(void)
+{
+	trace();
+	watchdog_driver_unregister(&dummy1_driver);
+}
+
+module_init(dummy1_init);
+module_exit(dummy1_exit);
+MODULE_LICENSE("GPL");
diff -Nru a/drivers/char/watchdog/dummy2.c b/drivers/char/watchdog/dummy2.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/char/watchdog/dummy2.c	Thu Feb 13 17:38:25 2003
@@ -0,0 +1,222 @@
+/*
+ * dummy2.c
+ *
+ * Dummy watchdog timer created for testing base.c
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
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+#include <linux/watchdog.h>
+#include <asm/io.h>
+
+#define dbg(format, arg...)				\
+		 printk (KERN_DEBUG "%s: " format "\n",	\
+			 __FUNCTION__, ## arg);
+#define trace(format, arg...)				 \
+                 printk(KERN_INFO "%s(" format ")\n",    \
+		               __FUNCTION__ , ## arg);
+#define err(format, arg...) \
+                printk(KERN_ERR "%s: " format "\n", \
+		       __FUNCTION__ , ## arg)
+#define info(format, arg...) \
+                printk(KERN_INFO "%s: " format "\n", \
+		       __FUNCTION__ , ## arg)
+#define warn(format, arg...) \
+                printk(KERN_WARNING "%s: " format "\n", \
+		       __FUNCTION__ , ## arg)
+
+
+static int dummy2_start(struct watchdog_driver *d)
+{
+	trace("%s", d->driver.name);
+	return 0;
+}
+
+static int dummy2_stop(struct watchdog_driver *d, const char *m)
+{
+	trace("%s, %p", d->driver.name, m);
+	return 0;
+}
+
+static int dummy2_keepalive(struct watchdog_driver *d) 
+{
+	trace("%s", d->driver.name);
+	return 0;
+}
+
+static int dummy2_get_timeout(struct watchdog_driver *d, int *t)
+{
+	trace("%s, %p", d->driver.name, t);
+	*t = 911;
+	return 0;
+}
+
+static int dummy2_set_timeout(struct watchdog_driver *d, int t)
+{
+	trace("%s, %i", d->driver.name, t);
+
+	return 0;
+}
+
+static int dummy2_get_nowayout(struct watchdog_driver *d, int *n)
+{
+	trace("%s, %p", d->driver.name, n);
+
+	*n = 911;
+	return 0;
+}
+
+static int dummy2_set_nowayout(struct watchdog_driver *d, int n)
+{
+	trace("%s, %i", d->driver.name, n);	
+	return 0;
+}
+
+static int dummy2_get_status(struct watchdog_driver *d, int *s)
+{
+	trace("%s, %p", d->driver.name, s);
+	*s = 911;
+	return 0;
+}
+
+static int dummy2_get_caps(struct watchdog_driver *d, int *c)
+{
+	trace("%s, %p", d->driver.name, c);
+	*c = 911;
+	return 0;
+}
+
+static int dummy2_get_bootstatus(struct watchdog_driver *d, int *b)
+{
+	trace("%s, %p", d->driver.name, b);
+	*b = 911;
+	return 0;
+}
+
+static int dummy2_get_temperature(struct watchdog_driver *d, int *t)
+{
+	trace("%s, %p", d->driver.name, t);
+	*t = 911;
+	return 0;
+}
+
+static int dummy2_get_temppanic(struct watchdog_driver *d, int *p)
+{
+	trace("%s, %p", d->driver.name, p);
+	*p = 911;
+	return 0;
+}
+
+static int dummy2_set_temppanic(struct watchdog_driver *d, int p)
+{
+	trace("%s, %i", d->driver.name, p);
+	return 0;
+}
+
+static int dummy2_probe(struct device * dev)
+{
+	trace("%s", dev->name);
+	return 0;
+}
+static int dummy2_remove(struct device * dev)
+{
+	trace("%s", dev->name);
+	return 0;
+}
+static int dummy2_suspend(struct device * dev, u32 state, u32 level)
+{
+	trace("%s, %i, %i", dev->name, state, level);
+	return 0;
+}
+static int dummy2_resume(struct device * dev, u32 level)
+{
+	trace("%s, %i", dev->name, level);
+	return 0;
+}
+
+static void dummy2_release(struct device_driver * drv)
+{
+	trace("%s", drv->name);
+}
+
+static struct watchdog_ops dummy2_ops = {
+	.start = dummy2_start,
+	.stop = dummy2_stop,
+	.keepalive = dummy2_keepalive,
+	.get_timeout = dummy2_get_timeout,
+	.set_timeout = dummy2_set_timeout,
+	.get_nowayout = dummy2_get_nowayout,
+	.set_nowayout = dummy2_set_nowayout,
+	.get_status = dummy2_get_status,
+	.get_caps = dummy2_get_caps,
+	.get_bootstatus = dummy2_get_bootstatus,
+	.get_temperature = dummy2_get_temperature,
+	.get_temppanic = dummy2_get_temppanic,
+	.set_temppanic = dummy2_set_temppanic,
+};
+
+static struct watchdog_driver dummy2_driver = {
+	.ops = &dummy2_ops,
+	.driver = {
+		.name		= "dummy2",
+		.bus		= &system_bus_type,
+		.devclass       = &watchdog_devclass,
+		.probe		= dummy2_probe,
+		.remove		= dummy2_remove,
+		.suspend	= dummy2_suspend,
+		.resume		= dummy2_resume,
+	}
+};
+
+static int __init dummy2_init(void)
+{
+	int ret = 0;
+
+	trace();
+	ret = watchdog_driver_register(&dummy2_driver);
+	if (ret) {
+		err("failed to register watchdog device");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void __exit dummy2_exit(void)
+{
+	trace();
+	watchdog_driver_unregister(&dummy2_driver);
+}
+
+module_init(dummy2_init);
+module_exit(dummy2_exit);
+MODULE_LICENSE("GPL");
diff -Nru a/include/linux/watchdog.h b/include/linux/watchdog.h
--- a/include/linux/watchdog.h	Thu Feb 13 17:38:25 2003
+++ b/include/linux/watchdog.h	Thu Feb 13 17:38:25 2003
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
@@ -45,5 +53,29 @@
 #define	WDIOS_DISABLECARD	0x0001	/* Turn off the watchdog timer */
 #define	WDIOS_ENABLECARD	0x0002	/* Turn on the watchdog timer */
 #define	WDIOS_TEMPPANIC		0x0004	/* Kernel panic on temperature trip */
+
+struct watchdog_driver {
+	struct watchdog_ops *ops;
+	struct device_driver driver;
+};
+
+struct watchdog_ops {
+	int (*start)(struct watchdog_driver *);
+	int (*stop)(struct watchdog_driver *, const char *);
+	int (*keepalive)(struct watchdog_driver *);
+	int (*get_timeout)(struct watchdog_driver *, int *);
+	int (*set_timeout)(struct watchdog_driver *, int);
+	int (*get_nowayout)(struct watchdog_driver *, int *);
+	int (*set_nowayout)(struct watchdog_driver *, int);
+	int (*get_status)(struct watchdog_driver *, int *);
+	int (*get_caps)(struct watchdog_driver *, int *);
+	int (*get_bootstatus)(struct watchdog_driver *, int *);
+	int (*get_temperature)(struct watchdog_driver *, int *);
+	int (*get_temppanic)(struct watchdog_driver *, int *);
+	int (*set_temppanic)(struct watchdog_driver *, int);
+};
+
+int  watchdog_driver_register(struct watchdog_driver *);
+void watchdog_driver_unregister(struct watchdog_driver *);
 
 #endif  /* ifndef _LINUX_WATCHDOG_H */

