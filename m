Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269488AbTCDSYF>; Tue, 4 Mar 2003 13:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269493AbTCDSYF>; Tue, 4 Mar 2003 13:24:05 -0500
Received: from fmr06.intel.com ([134.134.136.7]:65216 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S269488AbTCDSXV>; Tue, 4 Mar 2003 13:23:21 -0500
Subject: Re: Watchdog-Drivers
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: lkml <linux-kernel@vger.kernel.org>, rusty.lynch@intel.com
In-Reply-To: <20030302235948.A14867@medelec.uia.ac.be>
References: <20030302235948.A14867@medelec.uia.ac.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Mar 2003 10:31:49 -0800
Message-Id: <1046802710.1429.4.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-02 at 14:59, Wim Van Sebroeck wrote:
> Hi Rusty,
> 
> I was working on the watchdog-drivers in general; creating a generic_watchdog and a generic_temperature module so that the other modules can use this. I incorporated your latest patch (about sysfs) in my code. Could you have a look at it?
> 
> The code is ftp-able at: ftp://medelec.uia.ac.be/pub/linux/kernel-patches/
> the latest patch (that includes the sysfs) is: wd-2.5.63-patch-20030302 .
> 
> Greetings,
> Wim.

(I sent this email earlier today with your patch inlined for comments,
but I think the huge email either chocked my email client and wasn't really
sent, or another link in the email chain dropped it because it doesn't 
look like showed up anywhere.  This version does not include the entire patch.)

Ok, I started looking through your patch and realized that we took some 
rather different approaches to isolating common watchdog code.  I have
comments on code specifics, but I think it is more important to call out 
the big picture differences between our two patches.  

(Let me know if I missed some stuff, or misinterpreted your code.)

big picture differences:
------------------------

* Your code only allows one watchdog_driver device to be registered at a time,
  while mine will allow multiple drivers to be registered, but only one
  of those devices will be exposed via the legacy /dev/watchdog interface.

It seems like the single watchdog device limitation is artificial once
the kernel is able move away from the existing legacy interface. I rather
like the idea of enabling user space to see multiple watchdog devices.

For example I have a bladed architecture that can expose multiple watchdog 
devices over a common management bus where each watchdog is implemented in a 
micro controller that can do thing like send snmp traps on separate networks
regardless of the heath of the cpu blade. Each watchdog could be triggering 
separate actions external to the view of cpu blade that is running the watchdog
deamon.

* Your code removes the temperature related function callbacks from 
  the watchdog_driver, and instead creates a new driver type called
  temperature_driver that follows a consistent usage model to watchdog_driver.

I like the idea of creating a temperature_driver since any piece of hardware
could expose a temperature sensor.  

Although I think if we are going to bother exposing a legacy interface for 
watchdog devices then we need to expose the entire interface, i.e. watchdogs 
should still support the temperature related ioctl calls.  This could be done
by adding a 'struct temperature_driver *' to watchdog_driver, and then
let the miscdevice logic for watchdog drivers call on the temperature_ops
from that pointer (if it is not null.)


* Your code moves more watchdog logic into the common code. 

There are a couple of places where logic has been pushed to the common code 
that I'm not so sure I would like in the common code.  For example I kind of 
like the notion of letting the actual device driver decide when it is 
appropriate to force the 'nowayout' functionality.

I like increasing code reuse, but don't really care for forcing too restrictive
of a programming model for watchdog device drivers.  Maybe others have some
opinions on where the line should be drawn.

A coule of  comments on the code:
---------------------------------

* Everything compiles, but attempting to load the softdog (the only driver
I tried) will cause the kernel to oops.  The problem is you are not 
initializing the embedded device_driver struct in your watchdog_driver
with enough information.

So changing:

static struct watchdog_driver softdog_watchdog_driver = {
	.info =		&softdog_info,
	.ops =		&softdog_ops,
};

to be:

static struct watchdog_driver softdog_watchdog_driver = {
	.info =		&softdog_info,
	.ops =		&softdog_ops,
	.driver = {
		.name		= "softdog",
		.bus		= &system_bus_type,
		.devclass       = &watchdog_devclass,
	}

};

will get you in the game.

* Instead of having two mechanisms for exposing functionality up to the
common code (ie. the old watchdog_info and the new watchdog_ops), I would
rather simplify the device drivers to only expose watchdog_ops, but add
enough functionality in watchdog_ops for the common code to send
watchdog_info to the user using the legacy interface.

* I would rather see the watchdog_ops function pointers return success/failure
so the common code can at least translate a failure into EFAIL or something.
The common code has no way of knowing if the driver had a problem trying to
talk to the hardware.

* If you are touching all the drivers anyway, why not move the code to the 
new module_param() functions and then loose the #ifdefine MODULE code
that parses the command line args?

* Your softdog.c inherited a bug from my first patch where casually looking
at the current timeout value will cause the watchdog to start ticking.  If
you do not happen to have a watchdog deamon running then the watchdog will
sneak a machine_restart on you.

Here is an inlined version of the generic_watchdog.c, generic_temperature.c,
Kconfig, Makefile, and softdog.c parts of your patch.  Still makes a big
email, but it's 10k smaller then my first attempt to send this email:

diff -urN linux-2.5.63/drivers/char/watchdog/generic_temperature.c linux-2.5.63-watchdog-development/drivers/char/watchdog/generic_temperature.c
--- linux-2.5.63/drivers/char/watchdog/generic_temperature.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.63-watchdog-development/drivers/char/watchdog/generic_temperature.c	2003-03-02 15:10:37.000000000 +0100
@@ -0,0 +1,424 @@
+/*
+ *	generic_temperature.c
+ *
+ *	(c) Copyright 2002-2003 Wim Van Sebroeck <wim@iguana.be>.
+ *
+ *	This code is the generic code that can be shared by all the
+ *	temperature drivers.
+ *
+ *	Based on source code of the following authors:
+ *	  Alan Cox <alan@redhat.com>,
+ *	  Matt Domsch <Matt_Domsch@dell.com>,
+ *	  Rob Radez <rob@osinvestor.com>,
+ *	  Rusty Lynch <rusty@linux.co.intel.com>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *	Neither Wim Van Sebroeck nor Iguana vzw. admit liability nor
+ *	provide warranty for any of this software. This material is
+ *	provided "AS-IS" and at no charge.
+ *
+ *	Version 0.01 : 2002/11/01 - Wim Van Sebroeck <wim@iguana.be>
+ *	    Initial version.
+ *	Version 0.02 : 2003/03/02 - Wim Van Sebroeck <wim@iguana.be>
+ *	    Added sysfs support based on Rusty Lynch's code.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/temperature.h>
+#include <linux/miscdevice.h>
+
+#include <asm/uaccess.h>
+
+#define DEBUG
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
+/*
+ * Locally used variables
+ */
+
+static struct temperature_driver *temperaturedev;
+
+static DECLARE_MUTEX(temperature_sem);
+
+/*
+ *	temperature_read: reads from the temperature device.
+ *	@file: file from VFS
+ *	@data: user address of data
+ *	@len: length of data
+ *	@ppos: pointer to the file offset
+ *
+ *	A read to a temperature device returns the current temperature.
+ *	The temperature is in Fahrenheit.
+ */
+
+ssize_t temperature_read(struct file *file, char *data, size_t len, loff_t *ppos)
+{
+	unsigned char cp;
+
+	trace("%p, %p, %i, %p", file, data, len, ppos);
+
+	/*  Can't seek (pread) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	cp = (char) temperaturedev->ops->get_temperature() & 0xFF;
+	if (copy_to_user (data, &cp, 1))
+		return -EFAULT;
+
+	return 1;
+}
+
+/*
+ *	temperature_write: writes to the temperature device.
+ *	@file: file from VFS
+ *	@data: user address of data
+ *	@len: length of data
+ *	@ppos: pointer to the file offset
+ *
+ *	A write to a temperature device does nothing.
+ */
+
+ssize_t temperature_write(struct file *file, const char *data, size_t len, loff_t *ppos)
+{
+	trace("%p, %p, %i, %p", file, data, len, ppos);
+
+	/*  Can't seek (pwrite) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	return len;
+}
+
+/*
+ *	temperature_ioctl: handle the different ioctl's for the temperature device.
+ *	@inode: inode of the device
+ *	@file: file handle to the device
+ *	@cmd: temperature command
+ *	@arg: argument pointer
+ *
+ *	The temperature API defines a common set of functions for all temperature devices
+ *	according to their available features.
+ */
+
+int temperature_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	trace("%p, %p, %i, %li", inode, file, cmd, arg);
+
+	if (!temperaturedev)
+		return -ENODEV;
+
+	switch (cmd) {
+		case TEMPIOC_GETSUPPORT:
+			return copy_to_user((struct temperature_info *)arg, &temperaturedev->info,
+				sizeof(temperaturedev->info)) ? -EFAULT : 0;
+
+		case TEMPIOC_GETTEMP:
+		{
+			int temp;
+
+			if (!temperaturedev || !temperaturedev->ops)
+				return -EFAULT;
+
+			temp = temperaturedev->ops->get_temperature ? temperaturedev->ops->get_temperature() : 0;
+			return put_user(temp,(int *)arg);
+		}
+
+		default:
+			return -ENOIOCTLCMD;
+	}
+}
+
+/*
+ *	temperature_open: open the temperature device.
+ *	@inode: inode of device
+ *	@file: file handle to device
+ *
+ *	Open the temperature device.
+ */
+
+int temperature_open(struct inode *inode, struct file *file)
+{
+	trace("%p, %p", inode, file);
+
+	return 0;
+}
+
+/*
+ *      temperature_release: release the temperature device.
+ *      @inode: inode of device
+ *      @file: file handle to device
+ *
+ *      Close the temperature device.
+ */
+
+int temperature_release(struct inode *inode, struct file *file)
+{
+	trace("%p, %p", inode, file);
+
+	return 0;
+}
+
+/*
+ *	Kernel Interfaces
+ */
+
+static struct file_operations temperature_fops = {
+	.owner =	THIS_MODULE,
+	.llseek =	no_llseek,
+	.read =		temperature_read,
+	.write =	temperature_write,
+	.ioctl =	temperature_ioctl,
+	.open =		temperature_open,
+	.release =	temperature_release,
+};
+
+static struct miscdevice temperature_miscdev = {
+	.minor =	TEMP_MINOR,
+	.name =		"temperature",
+	.fops =		&temperature_fops,
+};
+
+/*
+ *	Sysfs Interfaces
+ */
+
+ssize_t temperature_show(struct device_driver *d, char *buf)
+{
+	int temp;
+	struct temperature_driver *td = to_temperature_driver(d);
+
+	trace("%p, %p", d, buf);
+
+	if (!td || !td->ops)
+		return -EFAULT;
+
+	temp = td->ops->get_temperature ? td->ops->get_temperature() : 0;
+	return sprintf(buf, "0x%08x\n", temp);
+}
+DRIVER_ATTR(temperature,S_IRUGO,temperature_show,NULL);
+
+ssize_t options_show(struct device_driver *d, char *buf)
+{
+	int options;
+	struct temperature_driver *td = to_temperature_driver(d);
+
+	trace("%p, %p", d, buf);
+
+	if (!td || !td->info)
+		return -ENODEV;
+
+	options = td->info->options;
+
+	return sprintf(buf, "0x%08x\n", options);
+}
+DRIVER_ATTR(options,S_IRUGO,options_show,NULL);
+
+ssize_t firmware_version_show(struct device_driver *d, char *buf)
+{
+	int version;
+	struct temperature_driver *td = to_temperature_driver(d);
+
+	trace("%p, %p", d, buf);
+	
+	if (!td || !td->info)
+		return -ENODEV;
+
+	version = td->info->firmware_version;
+
+	return sprintf(buf, "0x%08x\n", version);
+}
+DRIVER_ATTR(firmware_version,S_IRUGO,firmware_version_show,NULL);
+
+static int temperature_create_default_files(struct temperature_driver *td)
+{
+	driver_create_file(&(td->driver), &driver_attr_temperature);
+	driver_create_file(&(td->driver), &driver_attr_options);
+	driver_create_file(&(td->driver), &driver_attr_firmware_version);
+
+	return 0;
+}
+
+static void temperature_remove_default_files(struct temperature_driver *td)
+{
+	driver_remove_file(&(td->driver), &driver_attr_temperature);
+	driver_remove_file(&(td->driver), &driver_attr_options);
+	driver_remove_file(&(td->driver), &driver_attr_firmware_version);
+}
+
+/*
+ *	temperature_driver_register:
+ *
+ *	Set up the temperature device. The temperature device is
+ *	actually a miscdevice and thus we set it up like that.
+ */
+
+int temperature_driver_register(struct temperature_driver *td)
+{
+	int ret;
+	struct temperature_ops *tdo = td->ops;
+
+	dbg("Trying to register new temperature device");
+
+	if (td->info == NULL || td->ops == NULL)
+		return -ENODATA;
+
+	if (tdo->get_temperature == NULL)
+		return -ENODATA;
+
+	down(&temperature_sem);
+
+	if (temperaturedev) {
+		printk (KERN_ERR "%s: another temperature device is allready registered\n",
+			td->info->identity);
+		up(&temperature_sem);
+		return -EBUSY;
+	}
+
+	if (!get_driver(&(td->driver))) {
+		crit("unable to gain reference for %s driver", td->driver.name);
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret = driver_register(&(td->driver));
+	if (ret) {
+		crit("unable to register %s driver", td->driver.name);
+		goto unget_driver;
+	}
+
+	ret = temperature_create_default_files(td);
+	if (ret) {
+		crit("unable to create %s driver sysfs files", td->driver.name);
+		goto unreg_driver;
+	}
+
+	ret = misc_register(&temperature_miscdev);
+	if (ret != 0) {
+		printk (KERN_ERR "%s: cannot register miscdev on minor=%d (err=%d)\n",
+			td->info->identity, temperature_miscdev.minor, ret);
+		goto out;
+	}
+
+	temperaturedev = td;
+
+	printk (KERN_INFO "%s: generic temperature driver v0.02.\n",
+		temperaturedev->info->identity);
+
+out:
+	up(&temperature_sem);
+	return ret;
+
+unreg_driver:
+	driver_unregister(&(td->driver));
+unget_driver:
+	put_driver(&(td->driver));
+	goto out;
+}
+
+/*
+ *	temperature_driver_unregister:
+ *
+ *	Deregister the temperature driver.
+ */
+
+void temperature_driver_unregister(struct temperature_driver *td)
+{
+	down(&temperature_sem);
+
+	dbg("Trying to unregister temperature device\n");
+
+	if (!temperaturedev) {
+		printk (KERN_ERR "generic temperature: there is no temperature device registered\n");
+		up(&temperature_sem);
+		return;
+	}
+
+	if (!td) {
+		printk (KERN_ERR "generic temperature: cannot unregister non-existing temperature-driver\n");
+		up(&temperature_sem);
+		return;
+	}
+
+	if (temperaturedev != td) {
+		printk (KERN_ERR "%s: another temperature device (%s) is running\n",
+			td->info->identity, temperaturedev->info->identity);
+		up(&temperature_sem);
+		return;
+	}
+
+	misc_deregister(&temperature_miscdev);
+
+	temperature_remove_default_files(td);
+	driver_unregister(&(td->driver));
+	put_driver(&(td->driver));
+
+	printk (KERN_INFO "%s: generic temperature unregistered.\n",
+		temperaturedev->info->identity);
+
+	temperaturedev = NULL;
+	up(&temperature_sem);
+}
+
+struct device_class temperature_devclass = {
+	.name          = "temperature",
+};
+
+static int __init temperature_init(void)
+{
+	int ret;
+
+	trace();
+
+	ret = devclass_register(&temperature_devclass);
+	if (ret)
+		return -ENODEV;
+
+	return 0;
+}
+
+static void __exit temperature_exit(void)
+{
+	trace();
+
+	if (temperaturedev)
+		temperature_driver_unregister(temperaturedev);
+
+	devclass_unregister(&temperature_devclass);
+}
+
+module_init(temperature_init);
+module_exit(temperature_exit);
+
+EXPORT_SYMBOL_GPL(temperature_driver_register);
+EXPORT_SYMBOL_GPL(temperature_driver_unregister);
+EXPORT_SYMBOL_GPL(temperature_devclass);
+
+MODULE_AUTHOR("Wim Van Sebroeck");
+MODULE_DESCRIPTION("Generic Temperature driver");
+MODULE_LICENSE("GPL");
+MODULE_SUPPORTED_DEVICE("temperature");
diff -urN linux-2.5.63/drivers/char/watchdog/generic_watchdog.c linux-2.5.63-watchdog-development/drivers/char/watchdog/generic_watchdog.c
--- linux-2.5.63/drivers/char/watchdog/generic_watchdog.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.63-watchdog-development/drivers/char/watchdog/generic_watchdog.c	2003-03-02 19:37:18.000000000 +0100
@@ -0,0 +1,846 @@
+/*
+ *	generic_watchdog.c
+ *
+ *	(c) Copyright 2002-2003 Wim Van Sebroeck <wim@iguana.be>.
+ *
+ *	This code is the generic code that can be shared by all the
+ *	watchdog drivers.
+ *
+ *	Based on source code of the following authors:
+ *	  Alan Cox <alan@redhat.com>,
+ *	  Matt Domsch <Matt_Domsch@dell.com>,
+ *	  Rob Radez <rob@osinvestor.com>,
+ *	  Rusty Lynch <rusty@linux.co.intel.com>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *	Neither Wim Van Sebroeck nor Iguana vzw. admit liability nor
+ *	provide warranty for any of this software. This material is
+ *	provided "AS-IS" and at no charge.
+ *
+ *	Version 0.01 : 2002/10/19 - Wim Van Sebroeck <wim@iguana.be>
+ *	    Initial version.
+ *	Version 0.02 : 2003/03/01 - Wim Van Sebroeck <wim@iguana.be>
+ *	    Added sysfs support based on Rusty Lynch's code.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/watchdog.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/miscdevice.h>
+
+#include <asm/uaccess.h>
+
+#define DEBUG
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
+/*
+ * Locally used variables
+ */
+
+static unsigned long watchdog_is_open;
+static char expect_release;
+static struct watchdog_driver *watchdogdev;
+
+static DECLARE_MUTEX(watchdog_sem);
+
+#define WATCHDOG_TIMEOUT 30		/* 30 sec default timeout */
+static int timeout = WATCHDOG_TIMEOUT;	/* in seconds */
+
+MODULE_PARM(timeout, "i");
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (Default = WATCHDOG_TIMEOUT seconds)");
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+MODULE_PARM(nowayout,"i");
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (Default=CONFIG_WATCHDOG_NOWAYOUT)");
+
+/*
+ *	Kernel methods.
+ */
+
+#ifndef MODULE
+
+static int __init watchdog_setup(char *str)
+{
+	int ints[2];
+
+	str = get_options(str, ARRAY_SIZE(ints), ints);
+
+	if (ints[0] > 0) {
+		timeout = ints[1];
+		if (ints[0] > 1) {
+			nowayout = ints[2];
+		}
+	}
+
+	return 1;
+}
+
+__setup("watchdog=", watchdog_setup);
+
+#endif /* !MODULE */
+
+/*
+ *	watchdog_read: reads from the watchdog.
+ *	@file: file from VFS
+ *	@data: user address of data
+ *	@len: length of data
+ *	@ppos: pointer to the file offset
+ *
+ *	A read to a watchdog device is only usefull if you would have
+ *	interesting data to return. If not we return -EINVAL.
+ */
+
+ssize_t watchdog_read(struct file *file, char *data, size_t len, loff_t *ppos)
+{
+	trace("%p, %p, %i, %p", file, data, len, ppos);
+
+	/* No can do */
+	return -EINVAL;
+}
+
+/*
+ *	watchdog_write: writes to the watchdog.
+ *	@file: file from VFS
+ *	@data: user address of data
+ *	@len: length of data
+ *	@ppos: pointer to the file offset
+ *
+ *	A write to a watchdog device is defined as a keepalive signal.
+ *	Writing the magic 'V' sequence allows the next close to turn
+ *	off the watchdog (if nowayout is not set).
+ */
+
+ssize_t watchdog_write(struct file *file, const char *data, size_t len, loff_t *ppos)
+{
+	trace("%p, %p, %i, %p", file, data, len, ppos);
+
+	/*  Can't seek (pwrite) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	if (!watchdogdev || !watchdogdev->ops->keepalive)
+		return -ENODEV;
+
+	/* See if we got the magic character 'V' and reload the timer */
+	if (len) {
+		if (!nowayout) {
+			size_t i;
+
+			/* note: just in case someone wrote the magic character
+			 * five months ago... */
+			expect_release = 0;
+
+			/* scan to see wether or not we got the magic character */
+			for (i = 0; i != len; i++) {
+				char c;
+				if(get_user(c, data + i))
+					return -EFAULT;
+				if (c == 'V') {
+					expect_release = 42;
+					dbg("received the magic character\n");
+				}
+			}
+		}
+
+		/* someone wrote to us, we should reload the timer */
+		watchdogdev->ops->keepalive();
+	}
+	return len;
+}
+
+/*
+ *	watchdog_ioctl: handle the different ioctl's for the watchdog device.
+ *	@inode: inode of the device
+ *	@file: file handle to the device
+ *	@cmd: watchdog command
+ *	@arg: argument pointer
+ *
+ *	The watchdog API defines a common set of functions for all watchdogs
+ *	according to their available features.
+ */
+
+int watchdog_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	trace("%p, %p, %i, %li", inode, file, cmd, arg);
+
+	if (!watchdogdev)
+		return -ENODEV;
+
+	switch (cmd) {
+		case WDIOC_GETSUPPORT:
+			return copy_to_user((struct watchdog_info *)arg, watchdogdev->info,
+				sizeof(watchdogdev->info)) ? -EFAULT : 0;
+
+		case WDIOC_GETSTATUS:
+		{
+			int status;
+
+			if (!watchdogdev || !watchdogdev->ops)
+				return -EFAULT;
+
+			status = watchdogdev->ops->get_status ? watchdogdev->ops->get_status() : 0;
+			return put_user(status,(int *)arg);
+		}
+
+		case WDIOC_GETBOOTSTATUS:
+		{
+			int bootstatus;
+
+			if (!watchdogdev || !watchdogdev->ops)
+				return -EFAULT;
+
+			bootstatus = watchdogdev->ops->get_bootstatus ? watchdogdev->ops->get_bootstatus() : 0;
+			return put_user(bootstatus, (int *)arg);
+		}
+
+		case WDIOC_KEEPALIVE:
+		{
+			if (!watchdogdev || !watchdogdev->ops || !watchdogdev->ops->keepalive)
+				return -EFAULT;
+
+			watchdogdev->ops->keepalive();
+			return 0;
+		}
+
+		case WDIOC_SETOPTIONS:
+		{
+			int options;
+
+			if (!watchdogdev || !watchdogdev->ops)
+				return -EFAULT;
+
+			if (!watchdogdev->ops->set_options)
+				return -ENOIOCTLCMD;
+
+			if (get_user(options, (int *)arg))
+				return -EFAULT;
+
+			return (watchdogdev->ops->set_options(options));
+		}
+
+		case WDIOC_SETTIMEOUT:
+		{
+			int new_timeout;
+
+			if (!watchdogdev || !watchdogdev->ops)
+				return -EFAULT;
+
+			if (!(watchdogdev->info->options & WDIOF_SETTIMEOUT))
+				return -ENOIOCTLCMD;
+
+			if (!watchdogdev->ops->set_timeout)
+				return -ENOIOCTLCMD;
+
+			if (get_user(new_timeout, (int *)arg))
+				return -EFAULT;
+
+			timeout=watchdogdev->ops->set_timeout(new_timeout);
+
+			if (watchdogdev->ops->keepalive)
+				watchdogdev->ops->keepalive();
+			/* Fall */
+		}
+
+		case WDIOC_GETTIMEOUT:
+			return put_user(timeout, (int *)arg);
+
+		case WDIOC_SETNOWAYOUT:
+		{
+			int new_nowayout;
+
+			if (!watchdogdev || !watchdogdev->ops)
+				return -EFAULT;
+
+			if (get_user(new_nowayout, (int *)arg))
+				return -EFAULT;
+
+			nowayout=new_nowayout;
+			/* Fall */
+		}
+
+		case WDIOC_GETNOWAYOUT:
+			return put_user(nowayout, (int *)arg);
+
+		case WDIOC_GETTIMERVALUE:
+		{
+			int current_timervalue;
+
+			if (!watchdogdev || !watchdogdev->ops)
+				return -EFAULT;
+
+			if (!watchdogdev->ops->get_timervalue)
+				return -ENOIOCTLCMD;
+
+			current_timervalue = watchdogdev->ops->get_timervalue();
+			return put_user(current_timervalue,(int *)arg);
+		}
+
+		default:
+			return -ENOIOCTLCMD;
+	}
+}
+
+/*
+ *	watchdog_open: open the watchdog device.
+ *	@inode: inode of device
+ *	@file: file handle to device
+ *
+ *	The misc device has been opened. The watchdog device is single
+ *	open and on opening we load the counter.
+ */
+
+int watchdog_open(struct inode *inode, struct file *file)
+{
+	trace("%p, %p", inode, file);
+	dbg("watchdog_is_open=%x\n", watchdog_is_open);
+
+	if (!watchdogdev || !watchdogdev->ops || !watchdogdev->ops->start)
+		return -EBUSY;
+
+	if (test_and_set_bit(0, &watchdog_is_open)) {
+		return -EBUSY;
+	}
+
+	/*
+	 *	Activate
+	 */
+	watchdogdev->ops->start();
+	if (watchdogdev->ops->keepalive)
+		watchdogdev->ops->keepalive();
+
+	return 0;
+}
+
+/*
+ *      watchdog_release: release the watchdog device.
+ *      @inode: inode of device
+ *      @file: file handle to device
+ *
+ *      The watchdog has a configurable API. There is a religious dispute
+ *      between people who want their watchdog to be able to shut down and
+ *      those who want to be sure if the watchdog manager dies the machine
+ *      reboots. In the former case we disable the counters, in the latter
+ *      case you have to open it again very soon.
+ */
+
+int watchdog_release(struct inode *inode, struct file *file)
+{
+	trace("%p, %p", inode, file);
+	dbg("expect_release=%d, watchdog_is_open=%x", expect_release, watchdog_is_open);
+
+	if (!watchdogdev)
+		return -ENODEV;
+
+	if (expect_release == 42) {
+		watchdogdev->ops->stop();
+	} else {
+		watchdogdev->ops->keepalive();
+		crit("%s: Unexpected close, not stopping watchdog!",
+		       watchdogdev->info->identity);
+	}
+	clear_bit(0, &watchdog_is_open);
+	expect_release = 0;
+	return 0;
+}
+
+/*
+ *	watchdog_notify_sys:
+ *	@this: our notifier block
+ *	@code: the event being reported
+ *	@unused: unused
+ *
+ *	The notifier is called on system shutdowns. We want to turn the card
+ *	off at reboot otherwise the machine might reboot again during memory
+ *	test or worse yet during the following fsck.
+ *	However: some systems have no way of rebooting themselves. In that
+ *	case we force the reboot.
+ */
+
+int watchdog_notify_sys(struct notifier_block *this, unsigned long code, void *unused)
+{
+	trace("%p, %li", this, code);
+	dbg("code=0x%08x\n", code);
+
+	if (code == SYS_DOWN || code == SYS_HALT) {
+		/* Turn the WDT off */
+		if (watchdogdev && watchdogdev->ops) {
+			watchdogdev->ops->stop();
+		}
+	}
+
+	if (code==SYS_RESTART) {
+		/*
+		 * Some devices have no way of rebooting themselves. So the
+		 * watchdog driver needs to do the restart.
+		 */
+		if (watchdogdev && watchdogdev->ops && watchdogdev->ops->sys_restart) {
+			printk (KERN_INFO "%s: generic watchdog is forcing reboot\n",
+				watchdogdev->info->identity);
+			watchdogdev->ops->sys_restart();
+		}
+	}
+
+	return NOTIFY_DONE;
+}
+
+/*
+ *	Kernel Interfaces
+ */
+
+static struct file_operations watchdog_fops = {
+	.owner =	THIS_MODULE,
+	.llseek =	no_llseek,
+	.read =		watchdog_read,
+	.write =	watchdog_write,
+	.ioctl =	watchdog_ioctl,
+	.open =		watchdog_open,
+	.release =	watchdog_release,
+};
+
+static struct miscdevice watchdog_miscdev = {
+	.minor =	WATCHDOG_MINOR,
+	.name =		"watchdog",
+	.fops =		&watchdog_fops,
+};
+
+static struct notifier_block watchdog_notifier = {
+	.notifier_call =	watchdog_notify_sys,
+	.next =			NULL,
+	.priority =		0,
+};
+
+/*
+ *	Sysfs Interfaces
+ */
+
+ssize_t start_store(struct device_driver *d, const char *buf, size_t count)
+{
+	struct watchdog_driver *wdd = to_watchdog_driver(d);
+
+	trace("%p, %p, %i", d, buf, count);
+
+	if (!wdd || !wdd->ops || !wdd->ops->start)
+		return -ENODEV;
+
+	if (test_and_set_bit(0, &watchdog_is_open)) {
+		return -EBUSY;
+	}
+
+	/*
+	 *	Activate
+	 */
+	wdd->ops->start();
+	if (wdd->ops->keepalive)
+		wdd->ops->keepalive();
+
+	return count;
+}
+DRIVER_ATTR(start,S_IWUSR,NULL,start_store);
+
+ssize_t stop_store(struct device_driver *d, const char *buf, size_t count)
+{
+	struct watchdog_driver *wdd = to_watchdog_driver(d);
+
+	trace("%p, %p, %i", d, buf, count);
+
+	if (!wdd || !wdd->ops || !wdd->ops->stop)
+		return -ENODEV;
+
+	if (expect_release == 42) {
+		wdd->ops->stop();
+	} else {
+		wdd->ops->keepalive();
+		crit("%s: Unexpected close, not stopping watchdog!",
+		       wdd->info->identity);
+	}
+	clear_bit(0, &watchdog_is_open);
+	expect_release = 0;
+
+	return count;
+}
+DRIVER_ATTR(stop,S_IWUSR,NULL,stop_store);
+
+ssize_t keepalive_store(struct device_driver *d, const char *buf, size_t count)
+{
+	struct watchdog_driver *wdd = to_watchdog_driver(d);
+
+	trace("%p, %p, %i", d, buf, count);
+
+	if (!wdd || !wdd->ops || !wdd->ops->keepalive)
+		return -ENODEV;
+
+	wdd->ops->keepalive();
+
+	return count;
+}
+DRIVER_ATTR(keepalive,S_IWUSR,NULL,keepalive_store);
+
+ssize_t timeout_show(struct device_driver *d, char *buf)
+{
+	struct watchdog_driver *wdd = to_watchdog_driver(d);
+
+	trace("%p, %p", d, buf);
+
+	return sprintf(buf, "%i\n", timeout);
+}
+ssize_t timeout_store(struct device_driver *d, const char *buf, size_t count)
+{
+	int new_timeout;
+	struct watchdog_driver *wdd = to_watchdog_driver(d);
+
+	trace("%p, %p, %i", d, buf, count);
+
+	if (!wdd || !wdd->ops)
+		return -ENODEV;
+
+	if (!(wdd->info->options & WDIOF_SETTIMEOUT))
+		return -EFAULT;
+
+	if (!wdd->ops->set_timeout)
+		return -ENODEV;
+
+	if (!sscanf(buf,"%i",&new_timeout))
+		return -EINVAL;
+
+	timeout=wdd->ops->set_timeout(new_timeout);
+
+	if (wdd->ops->keepalive)
+		wdd->ops->keepalive();
+
+	return count;
+}
+DRIVER_ATTR(timeout,S_IRUGO|S_IWUSR,timeout_show,timeout_store);
+
+ssize_t nowayout_show(struct device_driver *d, char *buf)
+{
+	struct watchdog_driver *wdd = to_watchdog_driver(d);
+
+	trace("%p, %p", d, buf);
+
+	return sprintf(buf, "%i\n", nowayout);
+}
+ssize_t nowayout_store(struct device_driver *d, const char *buf, size_t count)
+{
+	int new_nowayout;
+	struct watchdog_driver *wdd = to_watchdog_driver(d);
+
+	trace("%p, %p, %i", d, buf, count);
+
+	if (!sscanf(buf,"%i",&new_nowayout))
+		return -EINVAL;
+
+	nowayout = new_nowayout;
+
+	return count;
+}
+DRIVER_ATTR(nowayout,S_IRUGO|S_IWUSR,nowayout_show,nowayout_store);
+
+ssize_t status_show(struct device_driver *d, char *buf)
+{
+	int status;
+	struct watchdog_driver *wdd = to_watchdog_driver(d);
+
+	trace("%p, %p", d, buf);
+
+	if (!wdd || !wdd->ops)
+		return -EFAULT;
+
+	status = wdd->ops->get_status ? wdd->ops->get_status() : 0;
+	return sprintf(buf, "0x%08x\n", status);
+}
+DRIVER_ATTR(status,S_IRUGO,status_show,NULL);
+
+ssize_t bootstatus_show(struct device_driver *d, char *buf)
+{
+	int bootstatus;
+	struct watchdog_driver *wdd = to_watchdog_driver(d);
+
+	trace("%p, %p", d, buf);
+
+	if (!wdd || !wdd->ops)
+		return -EFAULT;
+
+	bootstatus = wdd->ops->get_bootstatus ? wdd->ops->get_bootstatus() : 0;
+	return sprintf(buf, "0x%08x\n", bootstatus);
+}
+DRIVER_ATTR(bootstatus,S_IRUGO,bootstatus_show,NULL);
+
+ssize_t timer_show(struct device_driver *d, char *buf)
+{
+	int current_timervalue;
+	struct watchdog_driver *wdd = to_watchdog_driver(d);
+
+	trace("%p, %p", d, buf);
+
+	if (!wdd || !wdd->ops)
+		return -EFAULT;
+
+	current_timervalue = wdd->ops->get_timervalue ? wdd->ops->get_timervalue() : 0;
+	return sprintf(buf, "%i\n", current_timervalue);
+}
+DRIVER_ATTR(timer,S_IRUGO,timer_show,NULL);
+
+ssize_t options_show(struct device_driver *d, char *buf)
+{
+	int options;
+	struct watchdog_driver *wdd = to_watchdog_driver(d);
+
+	trace("%p, %p", d, buf);
+
+	if (!wdd || !wdd->info)
+		return -ENODEV;
+
+	options = wdd->info->options;
+
+	return sprintf(buf, "0x%08x\n", options);
+}
+DRIVER_ATTR(options,S_IRUGO,options_show,NULL);
+
+ssize_t firmware_version_show(struct device_driver *d, char *buf)
+{
+	int version;
+	struct watchdog_driver *wdd = to_watchdog_driver(d);
+
+	trace("%p, %p", d, buf);
+	
+	if (!wdd || !wdd->info)
+		return -ENODEV;
+
+	version = wdd->info->firmware_version;
+
+	return sprintf(buf, "0x%08x\n", version);
+}
+DRIVER_ATTR(firmware_version,S_IRUGO,firmware_version_show,NULL);
+
+static int watchdog_create_default_files(struct watchdog_driver *wdd)
+{
+	driver_create_file(&(wdd->driver), &driver_attr_start);
+	driver_create_file(&(wdd->driver), &driver_attr_stop);
+	driver_create_file(&(wdd->driver), &driver_attr_keepalive);
+	driver_create_file(&(wdd->driver), &driver_attr_timeout);
+	driver_create_file(&(wdd->driver), &driver_attr_nowayout);
+	driver_create_file(&(wdd->driver), &driver_attr_status);
+	driver_create_file(&(wdd->driver), &driver_attr_bootstatus);
+	driver_create_file(&(wdd->driver), &driver_attr_timer);
+	driver_create_file(&(wdd->driver), &driver_attr_options);
+	driver_create_file(&(wdd->driver), &driver_attr_firmware_version);
+
+	return 0;
+}
+
+static void watchdog_remove_default_files(struct watchdog_driver *wdd)
+{
+	driver_remove_file(&(wdd->driver), &driver_attr_start);
+	driver_remove_file(&(wdd->driver), &driver_attr_stop);
+	driver_remove_file(&(wdd->driver), &driver_attr_keepalive);
+	driver_remove_file(&(wdd->driver), &driver_attr_timeout);
+	driver_remove_file(&(wdd->driver), &driver_attr_nowayout);
+	driver_remove_file(&(wdd->driver), &driver_attr_status);
+	driver_remove_file(&(wdd->driver), &driver_attr_bootstatus);
+	driver_remove_file(&(wdd->driver), &driver_attr_timer);
+	driver_remove_file(&(wdd->driver), &driver_attr_options);
+	driver_remove_file(&(wdd->driver), &driver_attr_firmware_version);
+}
+
+/*
+ *	watchdog_driver_register:
+ *
+ *	Set up the watchdog device. The watchdog device is
+ *	actually a miscdevice and thus we set it up like that.
+ *	We also take care of the notifier setup.
+ */
+
+int watchdog_driver_register(struct watchdog_driver *wdd)
+{
+	int ret;
+	struct watchdog_ops *wdo = wdd->ops;
+
+	dbg("Trying to register new watchdog device\n");
+
+	if (wdd->info == NULL || wdd->ops == NULL)
+		return -ENODATA;
+
+	if (wdo->start == NULL || wdo->stop == NULL ||
+	    wdo->keepalive == NULL)
+		return -ENODATA;
+
+	down(&watchdog_sem);
+
+	if (watchdogdev) {
+		printk (KERN_ERR "%s: another watchdog device is allready registered\n",
+			wdd->info->identity);
+		up(&watchdog_sem);
+		return -EBUSY;
+	}
+
+	if (!get_driver(&(wdd->driver))) {
+		crit("unable to gain reference for %s driver", wdd->driver.name);
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret = driver_register(&(wdd->driver));
+	if (ret) {
+		crit("unable to register %s driver", wdd->driver.name);
+		goto unget_driver;
+	}
+
+	ret = watchdog_create_default_files(wdd);
+	if (ret) {
+		crit("unable to create %s driver sysfs files", wdd->driver.name);
+		goto unreg_driver;
+	}
+
+	ret = register_reboot_notifier(&watchdog_notifier);
+	if (ret != 0) {
+		printk (KERN_ERR "%s: cannot register reboot notifier (err=%d)\n",
+			wdd->info->identity, ret);
+		goto unreg_driver;
+	}
+
+	ret = misc_register(&watchdog_miscdev);
+	if (ret != 0) {
+		printk (KERN_ERR "%s: cannot register miscdev on minor=%d (err=%d)\n",
+			wdd->info->identity, watchdog_miscdev.minor, ret);
+		goto unreg_reboot;
+	}
+
+	watchdogdev = wdd;
+
+	timeout = watchdogdev->ops->set_timeout ? watchdogdev->ops->set_timeout(timeout) : 0;
+	if (timeout == 0)
+		watchdogdev->info->options &= !WDIOF_SETTIMEOUT;
+
+	printk (KERN_INFO "%s: generic watchdog driver v0.02. timeout=%d sec. nowayout=%d.\n",
+		watchdogdev->info->identity, timeout, nowayout);
+
+out:
+	up(&watchdog_sem);
+	return ret;
+
+unreg_reboot:
+	unregister_reboot_notifier(&watchdog_notifier);
+unreg_driver:
+	driver_unregister(&(wdd->driver));
+unget_driver:
+	put_driver(&(wdd->driver));
+	goto out;
+}
+
+/*
+ *	watchdog_driver_unregister:
+ *
+ *	Deregister the watchdog driver.
+ */
+
+void watchdog_driver_unregister(struct watchdog_driver *wdd)
+{
+	down(&watchdog_sem);
+
+	dbg("Trying to unregister watchdog device\n");
+
+	if (!watchdogdev) {
+		printk (KERN_ERR "generic watchdog: there is no watchdog registered\n");
+		up(&watchdog_sem);
+		return;
+	}
+
+	if (!wdd) {
+		printk (KERN_ERR "generic watchdog: cannot unregister non-existing watchdog-driver\n");
+		up(&watchdog_sem);
+		return;
+	}
+
+	if (watchdogdev != wdd) {
+		printk (KERN_ERR "%s: another watchdog device (%s) is running\n",
+			wdd->info->identity, watchdogdev->info->identity);
+		up(&watchdog_sem);
+		return;
+	}
+
+	/* Reset the timer before we leave */
+	if (!nowayout)
+		watchdogdev->ops->stop();
+
+	misc_deregister(&watchdog_miscdev);
+	unregister_reboot_notifier(&watchdog_notifier);
+
+	watchdog_remove_default_files(wdd);
+	driver_unregister(&(wdd->driver));
+	put_driver(&(wdd->driver));
+
+	printk (KERN_INFO "%s: generic watchdog unregistered.\n",
+		watchdogdev->info->identity);
+
+	watchdogdev = NULL;
+	up(&watchdog_sem);
+}
+
+struct device_class watchdog_devclass = {
+	.name          = "watchdog",
+};
+
+static int __init watchdog_init(void)
+{
+	int ret;
+
+	trace();
+
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
+	if (watchdogdev)
+		watchdog_driver_unregister(watchdogdev);
+
+	devclass_unregister(&watchdog_devclass);
+}
+
+module_init(watchdog_init);
+module_exit(watchdog_exit);
+
+EXPORT_SYMBOL_GPL(watchdog_driver_register);
+EXPORT_SYMBOL_GPL(watchdog_driver_unregister);
+EXPORT_SYMBOL_GPL(watchdog_devclass);
+
+MODULE_AUTHOR("Wim Van Sebroeck");
+MODULE_DESCRIPTION("Generic Watchdog driver");
+MODULE_LICENSE("GPL");
+MODULE_SUPPORTED_DEVICE("watchdog");
diff -urN linux-2.5.63/drivers/char/watchdog/Kconfig linux-2.5.63-watchdog-development/drivers/char/watchdog/Kconfig
--- linux-2.5.63/drivers/char/watchdog/Kconfig	2003-02-24 20:05:36.000000000 +0100
+++ linux-2.5.63-watchdog-development/drivers/char/watchdog/Kconfig	2003-03-01 20:44:30.000000000 +0100
@@ -1,5 +1,5 @@
 #
-# Character device configuration
+# Watchdog Character device configuration
 #
 
 menu "Watchdog Cards"
@@ -41,7 +41,7 @@
 config SOFT_WATCHDOG
 	tristate "Software watchdog"
 	depends on WATCHDOG
-	help
+	---help---
 	  A software monitoring watchdog. This will fail to reboot your system
 	  from some situations that the hardware watchdog will recover
 	  from. Equally it's a lot cheaper to install.
@@ -102,6 +102,17 @@
 	  Enable the Fan Tachometer on the WDT501. Only do this if you have a
 	  fan tachometer actually set up.
 
+config WDT_501_PCI
+	bool "WDT PCI 501 temperature features"
+	depends on WATCHDOG && WDTPCI
+	help
+	  Saying Y here and creating a character special file /dev/temperature
+	  with major number 10 and minor number 131 ("man mknod") will give
+	  you a thermometer inside your computer: reading from
+	  /dev/temperature yields one byte, the temperature in degrees
+	  Fahrenheit. This works only if you have a WDT501P watchdog board
+	  installed.
+
 config PCWATCHDOG
 	tristate "Berkshire Products PC Watchdog"
 	depends on WATCHDOG
@@ -132,7 +143,7 @@
 	  This driver is like the WDT501 driver but for different hardware.
 	  This driver is also available as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want).
-	  The module is called pscwdt.  If you want to compile it as a
+	  The module is called acquirewdt.  If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.  Most
 	  people will say N.
 
@@ -147,7 +158,7 @@
 config 21285_WATCHDOG
 	tristate "DC21285 watchdog"
 	depends on WATCHDOG && FOOTBRIDGE
-	help
+	---help---
 	  The Intel Footbridge chip contains a builtin watchdog circuit. Say Y
 	  here if you wish to use this. Alternatively say M to compile the
 	  driver as a module, which will be called wdt285.
@@ -161,7 +172,7 @@
 config 977_WATCHDOG
 	tristate "NetWinder WB83C977 watchdog"
 	depends on WATCHDOG && FOOTBRIDGE && ARCH_NETWINDER
-	help
+	---help---
 	  Say Y here to include support for the WB977 watchdog included in
 	  NetWinder machines. Alternatively say M to compile the driver as
 	  a module, which will be called wdt977.
@@ -203,14 +214,14 @@
 	  This driver is also available as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want).
 	  The module is called ib700wdt. If you want to compile it as a
-	  module, say M here and read Documentation/modules.txt. Most people
+	  module, say M here and read <file:Documentation/modules.txt>. Most people
 	  will say N.
 
 config I810_TCO
 	tristate "Intel i810 TCO timer / Watchdog"
 	depends on WATCHDOG
 	---help---
-	  Hardware driver for the TCO timer built into the Intel i810 and i815
+	  Hardware driver for the TCO timer built into the Intel i8xx
 	  chipset family.  The TCO (Total Cost of Ownership) timer is a
 	  watchdog timer that will reboot the machine after its second
 	  expiration. The expiration time can be configured by commandline
@@ -245,7 +256,7 @@
 config SCx200_WDT
 	tristate "NatSemi SCx200 Watchdog"
 	depends on WATCHDOG
-	help
+	---help---
 	  Enable the built-in watchdog timer support on the National 
 	  Semiconductor SCx200 processors.
 
@@ -254,7 +265,7 @@
 config 60XX_WDT
 	tristate "SBC-60XX Watchdog Timer"
 	depends on WATCHDOG
-	help
+	---help---
 	  This driver can be used with the watchdog timer found on some
 	  single board computers, namely the 6010 PII based computer.
 	  It may well work with other cards.  It reads port 0x443 to enable
@@ -277,7 +288,7 @@
 
 	  This driver is also available as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want).
-	  The module is called mixcomwd.  If you want to compile it as a
+	  The module is called w83877f_wdt.  If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.  Most
 	  people will say N.
 
@@ -296,14 +307,10 @@
 	  The module is called machzwd.  If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
 
-config W83877F_WDT
-	tristate "W83877F Computer Watchdog"
-	depends on WATCHDOG
-
 config SC520_WDT
 	tristate "AMD Elan SC520 processor Watchdog"
 	depends on WATCHDOG
-	help
+	---help---
 	  This is the driver for the hardware watchdog built in to the
 	  AMD "Elan" SC520 microcomputer commonly used in embedded systems.
 	  This watchdog simply watches your kernel to make sure it doesn't
@@ -316,20 +323,20 @@
 config ALIM7101_WDT
 	tristate "ALi M7101 PMU Computer Watchdog"
 	depends on WATCHDOG
-	help
+	---help---
 	  This is the driver for the hardware watchdog on the ALi M7101 PMU
 	  as used in the x86 Cobalt servers.
 
 	  This driver is also available as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want).
 	  The module is called alim7101_wdt.  If you want to compile it as a
-	  module, say M here and read Documentation/modules.txt.  Most
+	  module, say M here and read <file:Documentation/modules.txt>.  Most
 	  people will say N.
 
 config SC1200_WDT
 	tristate "National Semiconductor PC87307/PC97307 (ala SC1200) Watchdog"
 	depends on WATCHDOG
-	help
+	---help---
 	  This is a driver for National Semiconductor PC87307/PC97307 hardware
 	  watchdog cards as found on the SC1200. This watchdog is mainly used
 	  for power management purposes and can be used to power down the device
@@ -338,30 +345,80 @@
 	  This driver is also available as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want).
 	  The module is called sc1200wdt.  If you want to compile it as a
-	  module, say M here and read Documentation/modules.txt.  Most
+	  module, say M here and read <file:Documentation/modules.txt>.  Most
 	  people will say N.
 
 config WAFER_WDT
 	tristate "ICP Wafer 5823 Single Board Computer Watchdog"
 	depends on WATCHDOG
-	help
+	---help---
 	  This is a driver for the hardware watchdog on the ICP Wafer 5823
 	  Single Board Computer (and probably other similar models).
 
 	  This driver is also available as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want).
 	  If you want to compile it as a module, say M here and read
-	  Documentation/modules.txt. The module will be called
-	  wafer5823wdt.o
+	  <file:Documentation/modules.txt>. The module will be called
+	  wafer5823wdt.
 
 config CPU5_WDT
 	tristate "SMA CPU5 Watchdog"
 	depends on WATCHDOG
 	---help---
 	  TBD.
+
 	  This driver is also available as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want).
-	  The module is called cpu5wdt.o.  If you want to compile it as a
+	  The module is called cpu5wdt.  If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
 
+config SH_WDT
+	tristate "SuperH Watchdog"
+	depends on WATCHDOG && SUPERH
+	---help---
+	  This driver adds watchdog support for the integrated watchdog in the
+	  SuperH 3, 4 and 5 processors. If you have one of these processors, say
+	  Y, otherwise say N.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  If you want to compile it as a module, say M here and read
+	  <file:Documentation/modules.txt>. The module will be called
+	  shwdt.
+
+config ALIM1535_WDT
+	tristate "ALi M1535 PMU Watchdog Timer"
+	depends on WATCHDOG
+	---help---
+	  This is the driver for the hardware watchdog on the ALi M1535 PMU.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module is called alim1535d_wdt.  If you want to compile it as a
+	  module, say M here and read <file:Documentation/modules.txt>.  Most
+	  people will say N.
+
+config AMD7XX_TCO
+	tristate "AMD 766/768 TCO Timer/Watchdog"
+	depends on WATCHDOG
+	---help---
+	  This is the hardware driver for the TCO timer built into the 
+	  AMD 766/768 chipset family.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module is called amd7xx_tco.  If you want to compile it as a
+	  module, say M here and read <file:Documentation/modules.txt>.  Most
+	  people will say N.
+
+config INDYDOG
+	tristate "Indy/I2 Hardware Watchdog"
+	depends on WATCHDOG && SGI_IP22
+	help
+	  Hardwaredriver for the Indy's/I2's watchdog. This is a
+	  watchdog timer that will reboot the machine after a 60 second
+	  timer expired and no process has written to /dev/watchdog during
+	  that time.
+
 endmenu
+
diff -urN linux-2.5.63/drivers/char/watchdog/Makefile linux-2.5.63-watchdog-development/drivers/char/watchdog/Makefile
--- linux-2.5.63/drivers/char/watchdog/Makefile	2003-02-24 20:05:38.000000000 +0100
+++ linux-2.5.63-watchdog-development/drivers/char/watchdog/Makefile	2003-03-01 20:44:30.000000000 +0100
@@ -1,32 +1,40 @@
 #
-# Makefile for the kernel character device drivers.
+# Makefile for the kernel watchdog character device drivers.
 #
 
-# Only one watchdog can succeed. We probe the hardware watchdog
+# All of the (potential) objects that export symbols.
+# This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
+
+export-objs	:=	generic_watchdog.o generic_temperature.o
+
+# Only one watchdog can succeed. You can probe the hardware watchdog
 # drivers first, then the softdog driver.  This means if your hardware
 # watchdog dies or is 'borrowed' for some reason the software watchdog
 # still gives you some cover.
 
-obj-$(CONFIG_PCWATCHDOG) += pcwd.o
-obj-$(CONFIG_ACQUIRE_WDT) += acquirewdt.o
-obj-$(CONFIG_ADVANTECH_WDT) += advantechwdt.o
-obj-$(CONFIG_IB700_WDT) += ib700wdt.o
-obj-$(CONFIG_MIXCOMWD) += mixcomwd.o
-obj-$(CONFIG_SCx200_WDT) += scx200_wdt.o
-obj-$(CONFIG_60XX_WDT) += sbc60xxwdt.o
-obj-$(CONFIG_WDT) += wdt.o
-obj-$(CONFIG_WDTPCI) += wdt_pci.o
-obj-$(CONFIG_21285_WATCHDOG) += wdt285.o
-obj-$(CONFIG_977_WATCHDOG) += wdt977.o
-obj-$(CONFIG_I810_TCO) += i810-tco.o
-obj-$(CONFIG_MACHZ_WDT) += machzwd.o
-obj-$(CONFIG_SH_WDT) += shwdt.o
+obj-$(CONFIG_PCWATCHDOG) += generic_watchdog.o generic_temperature.o pcwd.o
+obj-$(CONFIG_ACQUIRE_WDT) += generic_watchdog.o acquirewdt.o
+obj-$(CONFIG_ADVANTECH_WDT) += generic_watchdog.o advantechwdt.o
+obj-$(CONFIG_IB700_WDT) += generic_watchdog.o ib700wdt.o
+obj-$(CONFIG_MIXCOMWD) += generic_watchdog.o mixcomwd.o
+obj-$(CONFIG_SCx200_WDT) += generic_watchdog.o scx200_wdt.o
+obj-$(CONFIG_60XX_WDT) += generic_watchdog.o sbc60xxwdt.o
+obj-$(CONFIG_WDT) += generic_watchdog.o generic_temperature.o wdt.o
+obj-$(CONFIG_WDTPCI) += generic_watchdog.o generic_temperature.o wdt_pci.o
+obj-$(CONFIG_21285_WATCHDOG) += generic_watchdog.o wdt285.o
+obj-$(CONFIG_977_WATCHDOG) += generic_watchdog.o wdt977.o
+obj-$(CONFIG_I810_TCO) += generic_watchdog.o i810-tco.o
+obj-$(CONFIG_MACHZ_WDT) += generic_watchdog.o machzwd.o
+obj-$(CONFIG_SH_WDT) += generic_watchdog.o shwdt.o
 obj-$(CONFIG_SA1100_WATCHDOG) += sa1100_wdt.o
-obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
-obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
-obj-$(CONFIG_W83877F_WDT) += w83877f_wdt.o
+obj-$(CONFIG_EUROTECH_WDT) += generic_watchdog.o eurotechwdt.o
+obj-$(CONFIG_SOFT_WATCHDOG) += generic_watchdog.o softdog.o
+obj-$(CONFIG_W83877F_WDT) += generic_watchdog.o w83877f_wdt.o
 obj-$(CONFIG_SC520_WDT) += sc520_wdt.o
 obj-$(CONFIG_ALIM7101_WDT) += alim7101_wdt.o
 obj-$(CONFIG_SC1200_WDT) += sc1200wdt.o
 obj-$(CONFIG_WAFER_WDT) += wafer5823wdt.o
 obj-$(CONFIG_CPU5_WDT) += cpu5wdt.o
+obj-$(CONFIG_ALIM1535_WDT) += generic_watchdog.o alim1535d_wdt.o
+#obj-$(CONFIG_AMD7XX_TCO) += amd7xx_tco.o
+#obj-$(CONFIG_INDYDOG) += generic_watchdog.o indydog.o
diff -urN linux-2.5.63/drivers/char/watchdog/softdog.c linux-2.5.63-watchdog-development/drivers/char/watchdog/softdog.c
--- linux-2.5.63/drivers/char/watchdog/softdog.c	2003-02-24 20:05:29.000000000 +0100
+++ linux-2.5.63-watchdog-development/drivers/char/watchdog/softdog.c	2003-03-02 13:08:59.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- *	SoftDog	0.06:	A Software Watchdog Device
+ *	SoftDog	0.07:	A Software Watchdog Device
  *
  *	(c) Copyright 1996 Alan Cox <alan@redhat.com>, All Rights Reserved.
  *				http://www.redhat.com
@@ -8,10 +8,10 @@
  *	modify it under the terms of the GNU General Public License
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
- *	
- *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide 
- *	warranty for any of this software. This material is provided 
- *	"AS-IS" and at no charge.	
+ *
+ *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
+ *	warranty for any of this software. This material is provided
+ *	"AS-IS" and at no charge.
  *
  *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
@@ -27,206 +27,191 @@
  *  19980911 Alan Cox
  *	Made SMP safe for 2.3.x
  *
- *  20011127 Joel Becker (jlbec@evilplan.org>
- *	Added soft_noboot; Allows testing the softdog trigger without 
- *	requiring a recompile.
- *	Added WDIOC_GETTIMEOUT and WDIOC_SETTIMOUT.
+ *  20011214 Matt Domsch <Matt_Domsch@dell.com>
+ *      Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
+ *      Didn't add timeout option, as soft_margin option already exists.
  *
- *  20020530 Joel Becker <joel.becker@oracle.com>
- *  	Added Matt Domsch's nowayout module option.
+ *  20021021 Wim Van Sebroeck
+ *	Ported to the generic watchdog driver.
  */
- 
-#include <linux/module.h>
+
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/types.h>
-#include <linux/miscdevice.h>
+#include <linux/kernel.h>
 #include <linux/watchdog.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+
 #include <asm/uaccess.h>
 
+#define WATCHDOG_NAME "Software Watchdog"
+
 #define TIMER_MARGIN	60		/* (secs) Default is 1 minute */
+static int timeout = TIMER_MARGIN;	/* in seconds */
 
-static int expect_close = 0;
-static int soft_margin = TIMER_MARGIN;	/* in seconds */
 #ifdef ONLY_TESTING
-static int soft_noboot = 1;
+static char soft_noboot = 42;
 #else
-static int soft_noboot = 0;
+static char soft_noboot = 0;
 #endif  /* ONLY_TESTING */
 
-MODULE_PARM(soft_margin,"i");
 MODULE_PARM(soft_noboot,"i");
-MODULE_LICENSE("GPL");
+MODULE_PARM_DESC(soft_noboot, "Softdog action, set to 42 to ignore reboots, 0 to reboot (default depends on ONLY_TESTING)");
 
-#ifdef CONFIG_WATCHDOG_NOWAYOUT
-static int nowayout = 1;
-#else
-static int nowayout = 0;
-#endif
+/*
+ *	Kernel methods.
+ */
+
+#ifndef MODULE
+
+static int __init softdog_setup(char *str)
+{
+	int ints[3];
+
+	str = get_options(str, ARRAY_SIZE(ints), ints);
 
-MODULE_PARM(nowayout,"i");
-MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
+	if (ints[0] > 0) {
+		soft_noboot = ints[1];
+	}
+
+	return 1;
+}
+
+__setup("softdog=", softdog_setup);
+
+#endif /* !MODULE */
 
 /*
  *	Our timer
  */
- 
-static void watchdog_fire(unsigned long);
 
-static struct timer_list watchdog_ticktock =
-		TIMER_INITIALIZER(watchdog_fire, 0, 0);
-static unsigned long timer_alive;
+static void watchdog_fire(unsigned long);
 
+static struct timer_list watchdog_ticktock = TIMER_INITIALIZER(watchdog_fire, 0, 0);
 
 /*
  *	If the timer expires..
  */
- 
+
 static void watchdog_fire(unsigned long data)
 {
-	if (soft_noboot)
+	if (soft_noboot == 42)
 		printk(KERN_CRIT "SOFTDOG: Triggered - Reboot ignored.\n");
-	else
-	{
+	else {
 		printk(KERN_CRIT "SOFTDOG: Initiating system reboot.\n");
 		machine_restart(NULL);
-		printk("SOFTDOG: Reboot didn't ?????\n");
+		printk(KERN_CRIT "SOFTDOG: Reboot didn't ?????\n");
 	}
 }
 
 /*
- *	Allow only one person to hold it open
+ *	Start the watchdog
  */
- 
-static int softdog_open(struct inode *inode, struct file *file)
+
+static void softdog_start (void)
 {
-	if(test_and_set_bit(0, &timer_alive))
-		return -EBUSY;
-	if (nowayout) {
-		MOD_INC_USE_COUNT;
-	}
-	/*
-	 *	Activate timer
-	 */
-	mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
-	return 0;
+	mod_timer(&watchdog_ticktock, jiffies+(timeout*HZ));
+}
+
+/*
+ *	Stop the watchdog
+ */
+
+static void softdog_stop (void)
+{
+	del_timer(&watchdog_ticktock);
 }
 
-static int softdog_release(struct inode *inode, struct file *file)
+/*
+ *	Send a keepalive ping to the watchdog
+ */
+
+static void softdog_keepalive (void)
 {
-	/*
-	 *	Shut off the timer.
-	 * 	Lock it in if it's a module and we set nowayout
-	 */
-	if (expect_close) {
-		del_timer(&watchdog_ticktock);
-	} else {
-		printk(KERN_CRIT "SOFTDOG: WDT device closed unexpectedly.  WDT will not stop!\n");
-	}
-	clear_bit(0, &timer_alive);
-	return 0;
+	softdog_start();
 }
 
-static ssize_t softdog_write(struct file *file, const char *data, size_t len, loff_t *ppos)
+/*
+ *	Handle this watchdog's options
+ */
+
+static int softdog_set_options (int opt)
 {
-	/*  Can't seek (pwrite) on this device  */
-	if (ppos != &file->f_pos)
-		return -ESPIPE;
-
-	/*
-	 *	Refresh the timer.
-	 */
-	if(len) {
-		if (!nowayout) {
-			size_t i;
-
-			/* In case it was set long ago */
-			expect_close = 0;
-
-			for (i = 0; i != len; i++) {
-				char c;
-
-				if (get_user(c, data + i))
-					return -EFAULT;
-				if (c == 'V')
-					expect_close = 1;
-			}
-		}
-		mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
-		return 1;
+	int retval = -EINVAL;
+
+	if (opt & WDIOS_DISABLECARD) {
+		softdog_stop();
+		retval = 0;
 	}
-	return 0;
+
+	if (opt & WDIOS_ENABLECARD) {
+		softdog_start();
+		retval = 0;
+	}
+
+	return retval;
 }
 
-static int softdog_ioctl(struct inode *inode, struct file *file,
-	unsigned int cmd, unsigned long arg)
+/*
+ *	Set the watchdog timeout value
+ */
+
+static int softdog_set_timeout (int t)
 {
-	int new_margin;
-	static struct watchdog_info ident = {
-		.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
-		.identity = "Software Watchdog",
-	};
-	switch (cmd) {
-		default:
-			return -ENOTTY;
-		case WDIOC_GETSUPPORT:
-			if(copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident)))
-				return -EFAULT;
-			return 0;
-		case WDIOC_GETSTATUS:
-		case WDIOC_GETBOOTSTATUS:
-			return put_user(0,(int *)arg);
-		case WDIOC_KEEPALIVE:
-			mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
-			return 0;
-		case WDIOC_SETTIMEOUT:
-			if (get_user(new_margin, (int *)arg))
-				return -EFAULT;
-			if (new_margin < 1)
-				return -EINVAL;
-			soft_margin = new_margin;
-			mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
-			/* Fall */
-		case WDIOC_GETTIMEOUT:
-			return put_user(soft_margin, (int *)arg);
-	}
+	timeout = t;
+	return t;
 }
 
-static struct file_operations softdog_fops = {
-	.owner		= THIS_MODULE,
-	.write		= softdog_write,
-	.ioctl		= softdog_ioctl,
-	.open		= softdog_open,
-	.release	= softdog_release,
+/*
+ *	Kernel Interfaces
+ */
+
+static struct watchdog_info softdog_info = {
+	.options =		WDIOF_SETTIMEOUT |
+				WDIOF_MAGICCLOSE |
+				WDIOF_KEEPALIVEPING,
+	.firmware_version =	0,
+	.identity =		WATCHDOG_NAME,
+};
+
+static struct watchdog_ops softdog_ops = {
+	.start =		softdog_start,
+	.stop =			softdog_stop,
+	.keepalive =		softdog_keepalive,
+	.set_options =		softdog_set_options,
+	.set_timeout =		softdog_set_timeout,
 };
 
-static struct miscdevice softdog_miscdev = {
-	.minor		= WATCHDOG_MINOR,
-	.name		= "watchdog",
-	.fops		= &softdog_fops,
+static struct watchdog_driver softdog_watchdog_driver = {
+	.info =		&softdog_info,
+	.ops =		&softdog_ops,
 };
 
-static char banner[] __initdata = KERN_INFO "Software Watchdog Timer: 0.06, soft_margin: %d sec, nowayout: %d\n";
+static char banner[] __initdata = KERN_INFO "Software Watchdog Timer: 0.07\n";
 
 static int __init watchdog_init(void)
 {
 	int ret;
 
-	ret = misc_register(&softdog_miscdev);
-
+	ret = watchdog_driver_register(&softdog_watchdog_driver);
 	if (ret)
 		return ret;
 
-	printk(banner, soft_margin, nowayout);
+	printk(banner);
 
 	return 0;
 }
 
 static void __exit watchdog_exit(void)
 {
-	misc_deregister(&softdog_miscdev);
+	/* Deregister */
+	watchdog_driver_unregister(&softdog_watchdog_driver);
 }
 
 module_init(watchdog_init);
 module_exit(watchdog_exit);
+
+MODULE_AUTHOR("Alan Cox");
+MODULE_DESCRIPTION("Software Watchdog Device Driver");
+MODULE_LICENSE("GPL");
diff -urN linux-2.5.63/include/linux/temperature.h linux-2.5.63-watchdog-development/include/linux/temperature.h
--- linux-2.5.63/include/linux/temperature.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.63-watchdog-development/include/linux/temperature.h	2003-03-02 15:12:24.000000000 +0100
@@ -0,0 +1,59 @@
+/*
+ *	Generic temperature defines (For /dev/temperature).
+ *
+ *	Derived from..
+ *
+ *	Berkshire PC Watchdog Defines
+ *	by Ken Hollis <khollis@bitgate.com>
+ *
+ *	(Note: the temperature device uses the same IOCTL's as the
+ *	watchdog device).
+ */
+
+#ifndef _LINUX_TEMPERATURE_H
+#define _LINUX_TEMPERATURE_H
+
+#include <linux/ioctl.h>
+#include <linux/device.h>
+
+#define	TEMPERATURE_IOCTL_BASE	'W'
+
+#define	TEMPIOC_GETSUPPORT	_IOR(TEMPERATURE_IOCTL_BASE, 0, struct temperature_info)
+#define	TEMPIOC_GETTEMP		_IOR(TEMPERATURE_IOCTL_BASE, 3, int)
+
+#define	TEMPIOF_UNKNOWN		-1	/* Unknown flag error */
+#define	TEMPIOS_UNKNOWN		-1	/* Unknown status error */
+
+#define to_temperature_driver(n) container_of(n, struct temperature_driver, driver)
+
+struct temperature_driver;
+struct temperature_ops;
+
+extern struct device_class temperature_devclass;
+
+struct temperature_info {
+	__u32 options;		/* Options the card/driver supports */
+	__u32 firmware_version;	/* Firmware version of the card */
+	__u8  identity[32];	/* Identity of the board */
+};
+
+#ifdef __KERNEL__
+
+/* Uniform temperature data structures for generic_temperature.c */
+struct temperature_driver {
+	struct temperature_info *info;		/* link to info */
+	struct temperature_ops *ops;		/* link to device_ops */
+	struct device_driver driver;		/* driver info */
+};
+
+struct temperature_ops {
+/* mandatory routines */
+	int (*get_temperature) (void);		/* operation = get temperature in degrees Fahrenheit */
+};
+
+/* the general misc_device operations structure: */
+extern int  temperature_driver_register(struct temperature_driver *);
+extern void temperature_driver_unregister(struct temperature_driver *);
+
+#endif  /* ifdef __KERNEL__ */
+#endif  /* ifndef _LINUX_TEMPERATURE_H */
diff -urN linux-2.5.63/include/linux/watchdog.h linux-2.5.63-watchdog-development/include/linux/watchdog.h
--- linux-2.5.63/include/linux/watchdog.h	2003-02-24 20:05:39.000000000 +0100
+++ linux-2.5.63-watchdog-development/include/linux/watchdog.h	2003-03-02 18:29:50.000000000 +0100
@@ -10,13 +10,14 @@
 #define _LINUX_WATCHDOG_H
 
 #include <linux/ioctl.h>
+#include <linux/device.h>
 
 #define	WATCHDOG_IOCTL_BASE	'W'
 
 struct watchdog_info {
-	__u32 options;		/* Options the card/driver supports */
-	__u32 firmware_version;	/* Firmware version of the card */
-	__u8  identity[32];	/* Identity of the board */
+	__u32 options;				/* Options the card/driver supports */
+	__u32 firmware_version;			/* Firmware version of the card */
+	__u8  identity[32];			/* Identity of the board */
 };
 
 #define	WDIOC_GETSUPPORT	_IOR(WATCHDOG_IOCTL_BASE, 0, struct watchdog_info)
@@ -27,6 +28,9 @@
 #define	WDIOC_KEEPALIVE		_IOR(WATCHDOG_IOCTL_BASE, 5, int)
 #define	WDIOC_SETTIMEOUT        _IOWR(WATCHDOG_IOCTL_BASE, 6, int)
 #define	WDIOC_GETTIMEOUT        _IOR(WATCHDOG_IOCTL_BASE, 7, int)
+#define	WDIOC_SETNOWAYOUT       _IOWR(WATCHDOG_IOCTL_BASE, 8, int)
+#define	WDIOC_GETNOWAYOUT       _IOR(WATCHDOG_IOCTL_BASE, 9, int)
+#define	WDIOC_GETTIMERVALUE     _IOR(WATCHDOG_IOCTL_BASE, 10, int)
 
 #define	WDIOF_UNKNOWN		-1	/* Unknown flag error */
 #define	WDIOS_UNKNOWN		-1	/* Unknown status error */
@@ -46,4 +50,40 @@
 #define	WDIOS_ENABLECARD	0x0002	/* Turn on the watchdog timer */
 #define	WDIOS_TEMPPANIC		0x0004	/* Kernel panic on temperature trip */
 
+#define to_watchdog_driver(n) container_of(n, struct watchdog_driver, driver)
+
+struct watchdog_driver;
+struct watchdog_ops;
+
+extern struct device_class watchdog_devclass;
+
+#ifdef __KERNEL__
+
+/* Uniform watchdog data structures for generic_watchdog.c */
+struct watchdog_driver {
+	struct watchdog_info *info;		/* link to info */
+	struct watchdog_ops *ops;		/* link to device_ops */
+	struct device_driver driver;		/* driver info */
+};
+
+struct watchdog_ops {
+/* mandatory routines */
+	void (*start) (void);			/* operation = start watchdog */
+	void (*stop) (void);			/* operation = stop watchdog */
+	void (*keepalive) (void);		/* operation = send keepalive ping */
+/* optional routines */
+	int (*get_status) (void);		/* operation = return watchdog status */
+	int (*get_bootstatus) (void);		/* operation = return watchdog bootstatus */
+	int (*set_options) (int);		/* operation = set watchdog's options */
+	int (*set_timeout) (int);		/* operation = set watchdog's timeout and return the new timeout
+						   if new timeout=0 then we return the default timeout */
+	int (*get_timervalue) (void);		/* operation = get the watchdog's current timer value */
+	void (*sys_restart) (void);		/* operation = force a system restart using the watchdog */
+};
+
+/* the general misc_device operations structure: */
+extern int  watchdog_driver_register(struct watchdog_driver *);
+extern void watchdog_driver_unregister(struct watchdog_driver *);
+
+#endif  /* ifdef __KERNEL__ */
 #endif  /* ifndef _LINUX_WATCHDOG_H */



