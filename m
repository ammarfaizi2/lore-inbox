Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWDQTja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWDQTja (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 15:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWDQTja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 15:39:30 -0400
Received: from service.sh.cvut.cz ([147.32.127.214]:22921 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S1750771AbWDQTj3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 15:39:29 -0400
Message-ID: <4443EED9.30603@sh.cvut.cz>
Date: Mon, 17 Apr 2006 21:39:05 +0200
From: Rudolf Marek <r.marek@sh.cvut.cz>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: wim@iguana.be
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] Watchdog device class
Content-Type: multipart/mixed;
 boundary="------------020301030702010501030900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020301030702010501030900
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

I wanted to create a watchdog driver for I2C W83792D chip and I realized
that there is no clean way how to connect the existing I2C device driver
with the watchdog ops. As the consequence of this I created new watchdog
device class.

This class supports all common infrastructure such as char device handling,
sysfs exports and even the infrastructure for too fast watchdogs
(the self ping feature). The class is based on the RTC class which
is fairly similar in some aspects.

The char device of watchdog class is compatible with existing watchdog API,
so no need to change the user applications. There is just one exception
and this is temperature handling. I belive it should be implemented not
via IOCTL but using the HWMON class. (100% compatibility can be restored
with the ioctl class op)

I have defined this class ops so far:

struct watchdog_class_ops {
	int (*enable)(struct device *);
	int (*disable)(struct device *);
	int (*ping)(struct device *);
	int (*set_timeout)(struct device *, int sec);
	int (*notify_reboot)(struct notifier_block *this, unsigned long code,
	        void *unused);
};

Each instance of the class has some predefined variables for common stuff:

	int expect_close;
	int timeout;
	int nowayout;
	unsigned long status;
	unsigned long boot_status;
	/* this may be removed in the future */
	struct watchdog_info legacy_info;

For further details please ask or consult the source code.

I have attached the some code that demonstrates the class usage
in softdog driver and for i2c based driver (w93792d). This code
is not yet to be included, because I dont know if the class interface
has all features you might think of.

So far the software watchdog works for me and also the w83792d driver,
both needs more testing to be sure everything works as expected.

In a meanwhile I would like to hear the comments on the class design
and interface design. This is my first kernel class so I expect
that something might not be correct ;)

I know about this issues:

* I'm not sure if I'm locking the stuff correctly, please take a look
   into this.
* Some lines of code exceeds the 80 collumns, codingstyle is not yet
   perfect
* I created new directory for the class in drivers/watchdog, the Kconfig is only for testing,
   not yet full featured - help is missing, watchdog.h is local only
* The W83792D driver is to be placed in the hwmon directory in final, but it is requested
   for now to be in the watchdog directory.
* the w83792d driver needs improvement in the register banks handling, and watchdog
   integration.
* some stuff in nowayout feature is missing for w83792d (the module can be unloaded)

Please CC me, I'm not subscribed yet.

Thanks,
Regards
Rudolf

--------------020301030702010501030900
Content-Type: text/plain;
 name="wdt_RFC1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wdt_RFC1"

diff -Naur a/drivers/Kconfig watchdog/drivers/Kconfig
--- a/drivers/Kconfig	2006-04-03 05:22:10.000000000 +0200
+++ watchdog/drivers/Kconfig	2006-04-17 21:32:49.202855500 +0200
@@ -74,4 +74,6 @@
 
 source "drivers/rtc/Kconfig"
 
+source "drivers/watchdog/Kconfig"
+
 endmenu
diff -Naur a/drivers/Makefile watchdog/drivers/Makefile
--- a/drivers/Makefile	2006-04-03 05:22:10.000000000 +0200
+++ watchdog/drivers/Makefile	2006-04-17 21:33:35.453746000 +0200
@@ -58,6 +58,7 @@
 obj-$(CONFIG_I2C)		+= i2c/
 obj-$(CONFIG_W1)		+= w1/
 obj-$(CONFIG_HWMON)		+= hwmon/
+obj-$(CONFIG_HWMON)             += watchdog/
 obj-$(CONFIG_PHONE)		+= telephony/
 obj-$(CONFIG_MD)		+= md/
 obj-$(CONFIG_BT)		+= bluetooth/
diff -Naur a/drivers/watchdog/class.c watchdog/drivers/watchdog/class.c
--- a/drivers/watchdog/class.c	1970-01-01 01:00:00.000000000 +0100
+++ watchdog/drivers/watchdog/class.c	2006-04-17 19:06:00.000000000 +0200
@@ -0,0 +1,174 @@
+/*
+ * Wachdog subsystem, base class
+ *
+ * Copyright (C) 2006 Rudolf Marek <r.marek@sh.cvut.cz>
+ *
+ * Based on the RTC class subsystem
+ *
+ * Copyright (C) 2005 Tower Technologies
+ * Author: Alessandro Zummo <a.zummo@towertech.it>
+ *
+ * class skeleton from drivers/hwmon/hwmon.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include "watchdog.h"
+#include <linux/kdev_t.h>
+#include <linux/idr.h>
+
+static DEFINE_IDR(watchdog_idr);
+static DEFINE_MUTEX(idr_lock);
+struct class *watchdog_class;
+
+static void watchdog_device_release(struct class_device *class_dev)
+{
+	struct watchdog_device *watchdog = to_watchdog_device(class_dev);
+	mutex_lock(&idr_lock);
+	idr_remove(&watchdog_idr, watchdog->id);
+	mutex_unlock(&idr_lock);
+	kfree(watchdog);
+}
+
+/**
+ * watchdog_device_register - register w/ Watchdog class
+ * @dev: the device to register
+ *
+ * watchdog_device_unregister() must be called when the class device is no
+ * longer needed.
+ *
+ * Returns the pointer to the new struct class device.
+ */
+struct watchdog_device *_watchdog_device_register(const char *name, struct device *dev,
+					struct watchdog_class_ops *ops,
+					struct module *owner, int timeout, int sping)
+{
+	struct watchdog_device *watchdog;
+	int id, err;
+
+	if (idr_pre_get(&watchdog_idr, GFP_KERNEL) == 0) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	mutex_lock(&idr_lock);
+	err = idr_get_new(&watchdog_idr, NULL, &id);
+	mutex_unlock(&idr_lock);
+
+	if (err < 0)
+		goto exit;
+
+	id = id & MAX_ID_MASK;
+
+	watchdog = kzalloc(sizeof(struct watchdog_device), GFP_KERNEL);
+	if (watchdog == NULL) {
+		err = -ENOMEM;
+		goto exit_idr;
+	}
+
+	watchdog->id = id;
+	watchdog->ops = ops;
+	watchdog->owner = owner;
+	watchdog->class_dev.dev = dev;
+	watchdog->class_dev.class = watchdog_class;
+	watchdog->class_dev.release = watchdog_device_release;
+	watchdog->expect_close = 0;
+	watchdog->timeout = timeout;
+	watchdog->sping_interval = sping;
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+	watchdog->nowayout = 1;
+#else
+	watchdog->nowayout = 0;
+#endif
+	if (watchdog->ops->notify_reboot) {
+		watchdog->reboot_notifier.notifier_call = ops->notify_reboot;
+		register_reboot_notifier (&watchdog->reboot_notifier);
+	}
+
+	if (watchdog->sping_interval) {
+		init_timer(&watchdog->timer);
+	}
+	mutex_init(&watchdog->ops_lock);
+
+	strlcpy(watchdog->name, name, WATCHDOG_DEVICE_NAME_SIZE);
+	snprintf(watchdog->class_dev.class_id, BUS_ID_SIZE, "watchdog%d", id);
+
+	/* legacy stuff */
+	strlcpy(watchdog->legacy_info.identity, name, 32);
+	watchdog->legacy_info.firmware_version = 1;
+	watchdog->legacy_info.options = WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE;
+	if (watchdog->ops->set_timeout)
+		watchdog->legacy_info.options |= WDIOF_SETTIMEOUT;
+
+	err = class_device_register(&watchdog->class_dev);
+	if (err)
+		goto exit_kfree;
+
+	dev_info(dev, "watchdog core: registered %s as %s\n",
+			watchdog->name, watchdog->class_dev.class_id);
+
+	return watchdog;
+
+exit_kfree:
+	kfree(watchdog);
+
+exit_idr:
+	idr_remove(&watchdog_idr, id);
+
+exit:
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(_watchdog_device_register);
+
+
+/**
+ * watchdog_device_unregister - removes the previously registered watchdog class device
+ *
+ * @watchdog: the watchdog class device to destroy
+ */
+void watchdog_device_unregister(struct watchdog_device *watchdog)
+{
+	if (watchdog->ops->notify_reboot)
+		unregister_reboot_notifier (&watchdog->reboot_notifier);
+	if (watchdog->sping_interval) {
+		del_timer(&watchdog->timer);
+	}
+	mutex_lock(&watchdog->ops_lock);
+	watchdog->ops = NULL;
+	mutex_unlock(&watchdog->ops_lock);
+	class_device_unregister(&watchdog->class_dev);
+}
+
+EXPORT_SYMBOL_GPL(watchdog_device_unregister);
+
+int watchdog_interface_register(struct class_interface *intf)
+{
+	intf->class = watchdog_class;
+	return class_interface_register(intf);
+}
+EXPORT_SYMBOL_GPL(watchdog_interface_register);
+
+static int __init watchdog_init(void)
+{
+	watchdog_class = class_create(THIS_MODULE, "watchdog");	
+	if (IS_ERR(watchdog_class)) {
+		printk(KERN_ERR "%s: couldn't create class\n", __FILE__);
+		return PTR_ERR(watchdog_class);
+	}
+	return 0;
+}
+
+static void __exit watchdog_exit(void)
+{
+	class_destroy(watchdog_class);
+}
+
+module_init(watchdog_init);
+module_exit(watchdog_exit);
+
+MODULE_AUTHOR("Rudolf Marek <r.marek@sh.cvut.cz>");
+MODULE_DESCRIPTION("Watchdog class support");
+MODULE_LICENSE("GPL");
diff -Naur a/drivers/watchdog/Kconfig watchdog/drivers/watchdog/Kconfig
--- a/drivers/watchdog/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ watchdog/drivers/watchdog/Kconfig	2006-04-17 19:04:00.000000000 +0200
@@ -0,0 +1,55 @@
+#
+# Watchdog class/drivers configuration
+#
+
+menu "Watchdog"
+
+config WATCHDOG_CLASS
+	tristate "WATCHDOG class"
+	depends on EXPERIMENTAL
+	default n
+	help
+	  bla bla
+config WATCHDOG_INTF_DEV 
+	tristate "Watchdog /dev"
+	depends on WATCHDOG_CLASS
+	help
+	  ha ha
+config WATCHDOG_INTF_SYSFS
+	tristate "Watchdog sysfs"
+	depends on WATCHDOG_CLASS
+	help
+	  ha ha
+config WATCHDOG_NOWAYOUT
+	bool "Disable watchdog shutdown on close"
+	depends on WATCHDOG_CLASS
+	help
+	  The default watchdog behaviour (which you get if you say N here) is
+	  to stop the timer if the process managing it closes the file
+	  /dev/watchdog. It's always remotely possible that this process might
+	  get killed. If you say Y here, the watchdog cannot be stopped once
+	  it has been started.
+config WATCHDOG_DEFAULT_TIMEOUT
+	int "Default watchdog timeout in seconds (1-65535)"
+	range 1 65535
+	default "60"
+	depends on WATCHDOG_CLASS
+	help
+	  ha ha
+	
+comment "WATCHDOG drivers"
+	depends on WATCHDOG_CLASS
+
+config WATCHDOG_DRV_SOFTDOG
+	tristate "Software watchdog"
+	depends on WATCHDOG_CLASS
+	help
+	  ble ble
+
+config WATCHDOG_DRV_W8379X
+	tristate "W83792D/W83793 Watchdog"
+	depends on WATCHDOG_CLASS && I2C && HWMON
+	help
+	  xx xxx
+
+endmenu
diff -Naur a/drivers/watchdog/Makefile watchdog/drivers/watchdog/Makefile
--- a/drivers/watchdog/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ watchdog/drivers/watchdog/Makefile	2006-04-17 21:34:28.161040000 +0200
@@ -0,0 +1,13 @@
+#
+# Makefile for Watchdog class/drivers.
+#
+
+obj-$(CONFIG_WATCHDOG_CLASS)		+= watchdog-core.o
+watchdog-core-y			:= class.o
+
+obj-$(CONFIG_WATCHDOG_INTF_DEV) += watchdog-dev.o
+obj-$(CONFIG_WATCHDOG_INTF_SYSFS) += watchdog-sysfs.o
+
+
+obj-$(CONFIG_WATCHDOG_DRV_SOFTDOG)	+= softdog.o
+obj-$(CONFIG_WATCHDOG_DRV_W8379X)	+= w83792d.o
diff -Naur a/drivers/watchdog/softdog.c watchdog/drivers/watchdog/softdog.c
--- a/drivers/watchdog/softdog.c	1970-01-01 01:00:00.000000000 +0100
+++ watchdog/drivers/watchdog/softdog.c	2006-04-17 19:10:00.000000000 +0200
@@ -0,0 +1,225 @@
+/*
+ * Wachdog subsystem, software watchdog
+ *
+ * Copyright (C) 2006 Rudolf Marek <r.marek@sh.cvut.cz>
+ *
+ * Based on the SoftDog	0.07:	A Software Watchdog Device
+ *
+ * (C) Copyright 1996 Alan Cox <alan@redhat.com>, All Rights Reserved.
+ *				http://www.redhat.com
+ *
+ * Platform device code based on: rtc-m48t86.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/timer.h>
+#include <linux/miscdevice.h>
+#include <linux/fs.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/platform_device.h>
+
+#include "watchdog.h"
+
+static int soft_margin = CONFIG_WATCHDOG_DEFAULT_TIMEOUT;	/* in seconds */
+module_param(soft_margin, int, 0);
+MODULE_PARM_DESC(soft_margin, "Watchdog soft_margin in seconds. (0<soft_margin<65536, default=" __MODULE_STRING(TIMER_MARGIN) ")");
+
+//#define ONLY_TESTING 1
+
+#ifdef ONLY_TESTING
+static int soft_noboot = 1;
+#else
+static int soft_noboot = 0;
+#endif  /* ONLY_TESTING */
+
+/*
+ *	Our timer
+ */
+
+static void watchdog_fire(unsigned long);
+
+static struct timer_list watchdog_ticktock =
+		TIMER_INITIALIZER(watchdog_fire, 0, 0);
+
+/*
+ *	If the timer expires..
+ */
+
+static void watchdog_fire(unsigned long data)
+{
+	struct watchdog_device *watchdog = (struct watchdog_device *) data;
+
+	if (soft_noboot)
+		dev_err(watchdog->class_dev.dev, "Triggered - Reboot ignored.\n");
+	else
+	{
+		printk(KERN_CRIT "Initiating system reboot.\n");
+		emergency_restart();
+		printk(KERN_CRIT  "Reboot didn't work. Nobody hears you cry...\n");
+	}
+}
+
+/*
+ *	Softdog operations
+ */
+
+static int softdog_keepalive(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct watchdog_device *watchdog = platform_get_drvdata(pdev);
+
+	mutex_lock(&watchdog->ops_lock);
+	mod_timer(&watchdog_ticktock, jiffies+(watchdog->timeout*HZ));
+	mutex_unlock(&watchdog->ops_lock);
+	return 0;
+}
+
+static int softdog_stop(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct watchdog_device *watchdog = platform_get_drvdata(pdev);
+
+	mutex_lock(&watchdog->ops_lock);
+	del_timer(&watchdog_ticktock);
+	mutex_unlock(&watchdog->ops_lock);
+	return 0;
+}
+
+static int softdog_start(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct watchdog_device *watchdog = platform_get_drvdata(pdev);
+	
+	if (watchdog->nowayout) {
+ 	        __module_get(THIS_MODULE);
+	}
+	return 0;
+}
+
+static int softdog_set_heartbeat(struct device *dev, int sec)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct watchdog_device *watchdog = platform_get_drvdata(pdev);
+
+	if ((sec < 0x0001) || (sec > 0xFFFF))
+		return -EINVAL;
+
+	mutex_lock(&watchdog->ops_lock);
+	watchdog->timeout = sec;
+	mutex_unlock(&watchdog->ops_lock);
+	return 0;
+}
+
+/*
+ *	Notifier for system down
+ */
+
+static int softdog_notify_sys(struct notifier_block *this, unsigned long code,
+	void *unused)
+{
+	struct watchdog_device *watchdog;
+
+	watchdog = container_of(this, struct watchdog_device, reboot_notifier);
+	if(code==SYS_DOWN || code==SYS_HALT) {
+	/* Turn the WDT off */
+		softdog_stop(watchdog->class_dev.dev);
+	}
+	return NOTIFY_DONE;
+}
+
+/*
+ *	Kernel Interfaces
+ */
+
+static struct watchdog_class_ops softdog_ops = {
+	.ping		= softdog_keepalive,
+	.enable		= softdog_start,
+	.disable	= softdog_stop,
+	.set_timeout	= softdog_set_heartbeat,
+	.notify_reboot	= softdog_notify_sys,
+};
+
+static int __devinit softdog_probe(struct platform_device *dev)
+{
+	struct watchdog_device *watchdog;
+
+	watchdog = watchdog_device_register_simple("softdog",
+				&dev->dev, &softdog_ops);
+	if (IS_ERR(watchdog)) {
+		dev_err(&dev->dev, "unable to register\n");
+		return PTR_ERR(watchdog);
+	}
+	watchdog_ticktock.data = (unsigned long) watchdog;
+	platform_set_drvdata(dev, watchdog);
+
+	/* Check that the soft_margin value is within it's range ; if not reset to the default */
+	if (softdog_set_heartbeat(&dev->dev, soft_margin) < 0) {
+		dev_warn(&dev->dev, "soft_margin value must be 0<soft_margin<65536\n");
+	} 
+	dev_info(&dev->dev, "Software watchdog started, timeout set to: %d seconds\n", watchdog->timeout);
+
+	return 0;
+}
+
+static int __devexit softdog_remove(struct platform_device *dev)
+{
+	struct watchdog_device *watchdog = platform_get_drvdata(dev);
+
+ 	if (watchdog)
+		watchdog_device_unregister(watchdog);
+ 	del_timer(&watchdog_ticktock);
+	platform_set_drvdata(dev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver softdog_platform_driver = {
+	.driver		= {
+		.name	= "softdog",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= softdog_probe,
+	.remove		= __devexit_p(softdog_remove),
+};
+
+struct platform_device *softdev = NULL;
+
+static int __init watchdog_init(void)
+{
+	int err = platform_driver_register(&softdog_platform_driver);
+	softdev = platform_device_alloc("softdog", 0);
+	if (!softdev) {
+		err = -ENOMEM;
+		printk(KERN_ERR "softdog : Device allocation failed\n");
+		goto exit;
+	}
+
+	return platform_device_add(softdev);
+exit:
+	platform_driver_unregister(&softdog_platform_driver);
+	return err;
+}
+
+static void __exit watchdog_exit(void)
+{
+        platform_device_unregister(softdev);
+	platform_driver_unregister(&softdog_platform_driver);
+}
+
+module_init(watchdog_init);
+module_exit(watchdog_exit);
+
+MODULE_AUTHOR("Rudolf Marek <r.marek@sh.cvut.cz>");
+MODULE_DESCRIPTION("Software watchdog device driver");
+MODULE_LICENSE("GPL");
diff -Naur a/drivers/watchdog/w83792d.c watchdog/drivers/watchdog/w83792d.c
--- a/drivers/watchdog/w83792d.c	2006-04-03 03:22:00.000000000 +0200
+++ watchdog/drivers/watchdog/w83792d.c	2006-04-17 19:04:00.000000000 +0200
@@ -44,6 +44,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include "watchdog.h"
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
@@ -130,6 +131,12 @@
 #define W83792D_REG_BANK		0x4E
 #define W83792D_REG_TEMP2_CONFIG	0xC2
 #define W83792D_REG_TEMP3_CONFIG	0xCA
+#define W83792D_PINCRT 		0x4B
+#define W83792D_CONFIG 		0x40
+#define W83792D_WDT_UNLOCK 	0x01
+#define W83792D_WDT_ENCHK 	0x02
+#define W83792D_WDT_STATUS 	0x03
+#define W83792D_WDT_TIMEOUT 	0x04
 
 static const u8 W83792D_REG_TEMP1[3] = {
 	0x27,	/* TEMP 1 in DataSheet */
@@ -278,6 +285,7 @@
 
 	/* array of 2 pointers to subclients */
 	struct i2c_client *lm75[2];
+	struct watchdog_device *watchdog;
 
 	u8 in[9];		/* Register value */
 	u8 in_max[9];		/* Register value */
@@ -1313,6 +1321,8 @@
 	return err;
 }
 
+static struct watchdog_class_ops watchdog_ops;
+
 static int
 w83792d_detach_client(struct i2c_client *client)
 {
@@ -1320,9 +1330,11 @@
 	int err;
 
 	/* main client */
-	if (data)
+	if (data) {
+	 	if (data->watchdog)
+			watchdog_device_unregister(data->watchdog);
 		hwmon_device_unregister(data->class_dev);
-
+	}
 	if ((err = i2c_detach_client(client)))
 		return err;
 
@@ -1339,7 +1351,8 @@
 static void
 w83792d_init_client(struct i2c_client *client)
 {
-	u8 temp2_cfg, temp3_cfg, vid_in_b;
+	struct w83792d_data *data = i2c_get_clientdata(client);
+	u8 temp2_cfg, temp3_cfg, vid_in_b,tmp;
 
 	if (init) {
 		w83792d_write_value(client, W83792D_REG_CONFIG, 0x80);
@@ -1365,6 +1378,27 @@
 			    (w83792d_read_value(client,
 						W83792D_REG_CONFIG) & 0xf7)
 			    | 0x01);
+
+
+	tmp = w83792d_read_value(client, W83792D_PINCRT);
+    
+	if (tmp & 0x40) {
+		/* watchdog pin is not enabled */
+		dev_err(&client->dev, "Watchdog pin is set to fan6, not enabling\n");
+		return;
+	}
+
+	tmp = w83792d_read_value(client, W83792D_CONFIG);
+	w83792d_write_value(client, W83792D_CONFIG, tmp | 0x10);
+	tmp = w83792d_read_value(client, W83792D_WDT_STATUS);
+
+	w83792d_write_value(client, W83792D_WDT_UNLOCK, 0xCC); /* disable the hard watchdog */
+	w83792d_write_value(client, W83792D_WDT_UNLOCK, 0xAA); /* disable the soft watchdog */
+
+	data->watchdog = watchdog_device_register_simple("w83792d",
+				&client->dev, &watchdog_ops);
+	data->watchdog->boot_status = tmp & 0x1 ? WDIOF_CARDRESET : 0x0;
+	data->watchdog->legacy_info.options |= WDIOF_CARDRESET;
 }
 
 static struct w83792d_data *w83792d_update_device(struct device *dev)
@@ -1534,6 +1568,58 @@
 }
 #endif
 
+static int wdt_ping(struct device *dev)
+{
+//spinlocks
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83792d_data *data = i2c_get_clientdata(client);
+	u8 timeout = data->watchdog->timeout;
+	/* workaround the hardware bug */
+	if (data->watchdog->timeout < 0xff*60) {
+		timeout += 60;
+	}
+	w83792d_write_value(client, W83792D_WDT_TIMEOUT, WATCHDOG_TO_MIN(timeout)); /* timeout */
+	return 0;
+}
+
+
+static int wdt_enable(struct device *dev)
+{
+//spinlocks
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83792d_data *data = i2c_get_clientdata(client);
+	w83792d_write_value(client, W83792D_WDT_TIMEOUT, WATCHDOG_TO_MIN(data->watchdog->timeout)); /* timeout */
+	w83792d_write_value(client, W83792D_WDT_UNLOCK, 0x55); 
+	return 0;
+}
+
+static int wdt_disable(struct device *dev) {
+	struct i2c_client *client = to_i2c_client(dev);
+	w83792d_write_value(client, W83792D_WDT_UNLOCK, 0xAA); /* disable soft watchdog */	
+	return 0;
+}
+
+static int wdt_set_heartbeat(struct device *dev, int sec)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83792d_data *data = i2c_get_clientdata(client);
+
+	if ((sec < 60) || (sec > 0xFF*60))
+		return -EINVAL;
+	data->watchdog->timeout = sec;
+	wdt_ping(dev);
+	return 0;
+}
+
+
+static struct watchdog_class_ops watchdog_ops = {
+	.ping		= wdt_ping,
+	.disable	= wdt_disable,
+	.enable		= wdt_enable,
+	.set_timeout	= wdt_set_heartbeat,
+};
+
+
 static int __init
 sensors_w83792d_init(void)
 {
diff -Naur a/drivers/watchdog/watchdog-dev.c watchdog/drivers/watchdog/watchdog-dev.c
--- a/drivers/watchdog/watchdog-dev.c	1970-01-01 01:00:00.000000000 +0100
+++ watchdog/drivers/watchdog/watchdog-dev.c	2006-04-17 19:07:00.000000000 +0200
@@ -0,0 +1,322 @@
+/*
+ * Wachdog subsystem, base class
+ *
+ * Copyright (C) 2006 Rudolf Marek <r.marek@sh.cvut.cz>
+ *
+ * Based on the RTC class subsystem
+ *
+ * Copyright (C) 2005 Tower Technologies
+ * Author: Alessandro Zummo <a.zummo@towertech.it>
+ *
+ * Based on arch/arm/common/rtctime.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include "watchdog.h"
+
+static struct class *watchdog_dev_class;
+static dev_t watchdog_devt;
+
+#define WATCHDOG_DEV_MAX 8 /* 8 watchdogs should be enough for everyone... */
+
+static void ping_soft_timer(unsigned long data)
+{
+struct watchdog_device *watchdog = (struct watchdog_device *) data;
+int err;
+
+	/* If we got a heartbeat pulse within the interval
+	 * we agree to ping the WDT
+	 */
+	if(time_before(jiffies, watchdog->next_heartbeat))
+	{
+		/* Ping the WDT */
+		err = watchdog->ops->ping ? 
+			watchdog->ops->ping(watchdog->class_dev.dev) : 0;
+
+		/* Re-set the timer interval */
+		watchdog->timer.expires = jiffies + watchdog->sping_interval;
+		add_timer(&watchdog->timer);
+	} else {
+		printk(KERN_WARNING  "Heartbeat lost! Will not ping the watchdog\n");
+	}
+}
+
+
+
+static int watchdog_dev_open(struct inode *inode, struct file *file)
+{
+	int err;
+	struct watchdog_device *watchdog = container_of(inode->i_cdev,
+					struct watchdog_device, char_dev);
+	struct watchdog_class_ops *ops = watchdog->ops;
+
+	/* We keep the lock as long as the device is in use
+	 * and return immediately if busy
+	 */
+	if (!(mutex_trylock(&watchdog->char_lock)))
+		return -EBUSY;
+
+	file->private_data = &watchdog->class_dev;
+
+	if (watchdog->sping_interval != 0) {
+		watchdog->next_heartbeat = jiffies + (watchdog->timeout * HZ);
+		watchdog->timer.function = ping_soft_timer;
+		watchdog->timer.data = (unsigned long) watchdog;
+		
+		/* Start the timer */
+		watchdog->timer.expires = jiffies + watchdog->sping_interval;
+		add_timer(&watchdog->timer);
+	}
+
+	err = ops->enable ? ops->enable(watchdog->class_dev.dev) : 0;
+	if (err == 0) {
+		return nonseekable_open(inode, file);
+	}
+	del_timer(&watchdog->timer);
+	/* something has gone wrong, release the lock */
+	mutex_unlock(&watchdog->char_lock);
+	return err;
+}
+
+
+static ssize_t
+watchdog_dev_write(struct file *file, const char __user *data, size_t len, loff_t *ppos)
+{
+	struct watchdog_device *watchdog = to_watchdog_device(file->private_data);
+	/*
+	 *	Refresh the timer.
+	 */
+	if(len) {
+		if (!watchdog->nowayout) {
+			size_t i;
+
+			/* In case it was set long ago */
+			watchdog->expect_close = 0;
+
+			for (i = 0; i != len; i++) {
+				char c;
+
+				if (get_user(c, data + i))
+					return -EFAULT;
+				if (c == 'V')
+					watchdog->expect_close = 42;
+			}
+		}
+		if (watchdog->sping_interval != 0) {
+			/* user land ping */
+			watchdog->next_heartbeat = jiffies + (watchdog->timeout * HZ);
+		} else {
+			len = watchdog->ops->ping ?
+				watchdog->ops->ping(watchdog->class_dev.dev) : -EFAULT;
+		}
+	}
+	return len;
+}
+
+static int watchdog_dev_ioctl(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	int err = -ENOIOCTLCMD;
+	struct class_device *class_dev = file->private_data;
+	struct watchdog_device *watchdog = to_watchdog_device(class_dev);
+	struct watchdog_class_ops *ops = watchdog->ops;
+	void __user *argp = (void __user *)arg;
+	int __user *p = argp;
+	switch (cmd) {
+		case WDIOC_GETSUPPORT:
+			return copy_to_user(argp, &watchdog->legacy_info,
+				sizeof (watchdog->legacy_info)) ? -EFAULT : 0;
+		case WDIOC_GETSTATUS:
+			return put_user(watchdog->status, p);
+		case WDIOC_GETBOOTSTATUS:
+			return put_user(watchdog->boot_status, p);
+		case WDIOC_KEEPALIVE:
+			if (watchdog->sping_interval != 0) {
+				/* user land ping */
+				watchdog->next_heartbeat = jiffies + (watchdog->timeout * HZ);
+			} else {	
+				err = ops->ping ? ops->ping(watchdog->class_dev.dev) : -EFAULT;
+			}
+			return err;
+		case WDIOC_SETOPTIONS:
+		{
+			int new_options;
+			if (get_user (new_options, p))
+				return -EFAULT;
+			if (new_options & WDIOS_DISABLECARD) {
+				err = ops->disable ? ops->disable(watchdog->class_dev.dev) : -EFAULT;
+			}
+
+			if (new_options & WDIOS_ENABLECARD) {
+				err = ops->enable ? ops->enable(watchdog->class_dev.dev) : -EFAULT;
+			}
+			return err;
+		}
+
+		case WDIOC_SETTIMEOUT:
+		{
+			int new_timeout;
+			if (get_user(new_timeout, p))
+				return -EFAULT;
+			err = ops->set_timeout ? 
+				    ops->set_timeout(watchdog->class_dev.dev, new_timeout) : -EFAULT;
+			/* Fall */
+		}
+
+		case WDIOC_GETTIMEOUT:
+			return put_user(watchdog->timeout, p);
+
+		default:
+			return err;
+	}
+	return err;
+}
+
+static int watchdog_dev_release(struct inode *inode, struct file *file)
+{
+	struct watchdog_device *watchdog = to_watchdog_device(file->private_data);
+	int err;
+	
+	if (watchdog->expect_close == 42) {
+		err = watchdog->ops->disable ? 
+			watchdog->ops->disable(watchdog->class_dev.dev) : -EFAULT;
+	} else {
+		printk(KERN_CRIT "Unexpected close, not stopping watchdog!\n");
+		err = watchdog->ops->ping ? 
+			watchdog->ops->ping(watchdog->class_dev.dev) : -EFAULT;
+	}
+	if (watchdog->sping_interval != 0) {
+		del_timer(&watchdog->timer);
+	}
+	watchdog->expect_close = 0;
+	mutex_unlock(&watchdog->char_lock);
+	return err;
+}
+
+static struct file_operations watchdog_dev_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.ioctl		= watchdog_dev_ioctl,
+	.open		= watchdog_dev_open,
+	.write		= watchdog_dev_write,
+	.release	= watchdog_dev_release,
+};
+
+/* insertion/removal hooks */
+
+static int watchdog_dev_add_device(struct class_device *class_dev,
+				struct class_interface *class_intf)
+{
+	int err = 0;
+	struct watchdog_device *watchdog = to_watchdog_device(class_dev);
+
+	if (watchdog->id >= WATCHDOG_DEV_MAX) {
+		dev_err(class_dev->dev, "too many watchdogs\n");
+		return -EINVAL;
+	}
+
+	mutex_init(&watchdog->char_lock);
+
+	cdev_init(&watchdog->char_dev, &watchdog_dev_fops);
+	watchdog->char_dev.owner = watchdog->owner;
+
+	if (cdev_add(&watchdog->char_dev, MKDEV(MAJOR(watchdog_devt), watchdog->id), 1)) {
+		cdev_del(&watchdog->char_dev);
+		dev_err(class_dev->dev,
+			"failed to add char device %d:%d\n",
+			MAJOR(watchdog_devt), watchdog->id);
+		return -ENODEV;
+	}
+
+	watchdog->watchdog_dev = class_device_create(watchdog_dev_class, NULL,
+						MKDEV(MAJOR(watchdog_devt), watchdog->id),
+						class_dev->dev, "watchdog%d", watchdog->id);
+	if (IS_ERR(watchdog->watchdog_dev)) {
+		dev_err(class_dev->dev, "cannot create watchdog_dev device\n");
+		err = PTR_ERR(watchdog->watchdog_dev);
+		goto err_cdev_del;
+	}
+
+	dev_info(class_dev->dev, "watchdog intf: dev (%d:%d)\n",
+		MAJOR(watchdog->watchdog_dev->devt),
+		MINOR(watchdog->watchdog_dev->devt));
+
+	return 0;
+
+err_cdev_del:
+
+	cdev_del(&watchdog->char_dev);
+	return err;
+}
+
+static void watchdog_dev_remove_device(struct class_device *class_dev,
+					struct class_interface *class_intf)
+{
+	struct watchdog_device *watchdog = to_watchdog_device(class_dev);
+	if (watchdog->watchdog_dev) {
+		dev_dbg(class_dev->dev, "removing char %d:%d\n",
+			MAJOR(watchdog->watchdog_dev->devt),
+			MINOR(watchdog->watchdog_dev->devt));
+
+		class_device_unregister(watchdog->watchdog_dev);
+		cdev_del(&watchdog->char_dev);
+	}
+}
+
+/* interface registration */
+
+static struct class_interface watchdog_dev_interface = {
+	.add = &watchdog_dev_add_device,
+	.remove = &watchdog_dev_remove_device,
+};
+
+static int __init watchdog_dev_init(void)
+{
+	int err;
+
+	watchdog_dev_class = class_create(THIS_MODULE, "watchdog-dev");
+	if (IS_ERR(watchdog_dev_class))
+		return PTR_ERR(watchdog_dev_class);
+
+	err = alloc_chrdev_region(&watchdog_devt, 0, WATCHDOG_DEV_MAX, "watchdog");
+	if (err < 0) {
+		printk(KERN_ERR "%s: failed to allocate char dev region\n",
+			__FILE__);
+		goto err_destroy_class;
+	}
+
+	err = watchdog_interface_register(&watchdog_dev_interface);
+	if (err < 0) {
+		printk(KERN_ERR "%s: failed to register the interface\n",
+			__FILE__);
+		goto err_unregister_chrdev;
+	}
+
+	return 0;
+
+err_unregister_chrdev:
+	unregister_chrdev_region(watchdog_devt, WATCHDOG_DEV_MAX);
+
+err_destroy_class:
+	class_destroy(watchdog_dev_class);
+
+	return err;
+}
+
+static void __exit watchdog_dev_exit(void)
+{
+	class_interface_unregister(&watchdog_dev_interface);
+	class_destroy(watchdog_dev_class);
+	unregister_chrdev_region(watchdog_devt, WATCHDOG_DEV_MAX);
+}
+
+module_init(watchdog_dev_init);
+module_exit(watchdog_dev_exit);
+
+MODULE_AUTHOR("Rudolf Marek <r.marek@sh.cvut.cz>");
+MODULE_DESCRIPTION("Watchdog class dev interface");
+MODULE_LICENSE("GPL");
diff -Naur a/drivers/watchdog/watchdog.h watchdog/drivers/watchdog/watchdog.h
--- a/drivers/watchdog/watchdog.h	1970-01-01 01:00:00.000000000 +0100
+++ watchdog/drivers/watchdog/watchdog.h	2006-04-17 19:04:00.000000000 +0200
@@ -0,0 +1,139 @@
+/*
+ *	Generic watchdog defines. Derived from..
+ *
+ * Berkshire PC Watchdog Defines
+ * by Ken Hollis <khollis@bitgate.com>
+ *
+ */
+
+#ifndef _LINUX_WATCHDOG_H
+#define _LINUX_WATCHDOG_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/poll.h>
+#include <linux/seq_file.h>
+#include <linux/cdev.h>
+#include <linux/mutex.h>
+#include <linux/reboot.h>
+
+#define	WATCHDOG_IOCTL_BASE	'W'
+
+struct watchdog_info {
+	__u32 options;		/* Options the card/driver supports */
+	__u32 firmware_version;	/* Firmware version of the card */
+	__u8  identity[32];	/* Identity of the board */
+};
+
+#define	WDIOC_GETSUPPORT	_IOR(WATCHDOG_IOCTL_BASE, 0, struct watchdog_info)
+#define	WDIOC_GETSTATUS		_IOR(WATCHDOG_IOCTL_BASE, 1, int)
+#define	WDIOC_GETBOOTSTATUS	_IOR(WATCHDOG_IOCTL_BASE, 2, int)
+#define	WDIOC_GETTEMP		_IOR(WATCHDOG_IOCTL_BASE, 3, int)
+#define	WDIOC_SETOPTIONS	_IOR(WATCHDOG_IOCTL_BASE, 4, int)
+#define	WDIOC_KEEPALIVE		_IOR(WATCHDOG_IOCTL_BASE, 5, int)
+#define	WDIOC_SETTIMEOUT        _IOWR(WATCHDOG_IOCTL_BASE, 6, int)
+#define	WDIOC_GETTIMEOUT        _IOR(WATCHDOG_IOCTL_BASE, 7, int)
+
+#define	WDIOF_UNKNOWN		-1	/* Unknown flag error */
+#define	WDIOS_UNKNOWN		-1	/* Unknown status error */
+
+#define	WDIOF_OVERHEAT		0x0001	/* Reset due to CPU overheat */
+#define	WDIOF_FANFAULT		0x0002	/* Fan failed */
+#define	WDIOF_EXTERN1		0x0004	/* External relay 1 */
+#define	WDIOF_EXTERN2		0x0008	/* External relay 2 */
+#define	WDIOF_POWERUNDER	0x0010	/* Power bad/power fault */
+#define	WDIOF_CARDRESET		0x0020	/* Card previously reset the CPU */
+#define WDIOF_POWEROVER		0x0040	/* Power over voltage */
+#define WDIOF_SETTIMEOUT	0x0080  /* Set timeout (in seconds) */
+#define WDIOF_MAGICCLOSE	0x0100	/* Supports magic close char */
+#define	WDIOF_KEEPALIVEPING	0x8000	/* Keep alive ping reply */
+
+#define	WDIOS_DISABLECARD	0x0001	/* Turn off the watchdog timer */
+#define	WDIOS_ENABLECARD	0x0002	/* Turn on the watchdog timer */
+#define	WDIOS_TEMPPANIC		0x0004	/* Kernel panic on temperature trip */
+
+#ifdef __KERNEL__
+
+#include <linux/autoconf.h>
+
+/* The watchdog class supports following operations:
+
+enable - this should just enable the device, with timeout value 
+disable - disable the device
+ping - restart watchdog timer
+set_timeout - set timeout register
+notify_reboot - called when reboot/halt to defuse the watchdog bomb
+
+*/
+
+extern struct class *watchdog_class;
+
+struct watchdog_class_ops {
+	int (*enable)(struct device *);
+	int (*disable)(struct device *);
+	int (*ping)(struct device *);
+	int (*set_timeout)(struct device *, int sec);
+	int (*notify_reboot)(struct notifier_block *this, unsigned long code,                                               
+	        void *unused);
+};
+
+#define WATCHDOG_DEVICE_NAME_SIZE 20
+
+struct watchdog_device {
+	struct class_device class_dev;
+	struct module *owner;
+
+	int id;
+	char name[WATCHDOG_DEVICE_NAME_SIZE];
+
+	struct watchdog_class_ops *ops;
+	struct mutex ops_lock;
+
+	struct class_device *watchdog_dev; 
+	struct cdev char_dev; /* associated /dev/ device */
+	struct mutex char_lock;
+	struct notifier_block reboot_notifier;
+	struct timer_list timer;
+	int expect_close;
+	int timeout;
+	int nowayout;
+	unsigned long status;
+	unsigned long boot_status;
+	unsigned long next_heartbeat;
+	int sping_interval;
+	/* this may be removed in the future */
+	struct watchdog_info legacy_info;
+};
+
+#define to_watchdog_device(d) container_of(d, struct watchdog_device, class_dev)
+
+/* watchdog_device_register_simple, will register device into watchdog class
+   just with default timeout from kernel configuration.
+   
+   watchdog_device_register_selfping, will register the watchdog device same 
+   way as above function, but the device will be pinged every selfping interval
+   (useful for watchdog with damm fast timeouts)
+*/
+
+#define watchdog_device_register_simple(name, dev, ops)  \
+	    _watchdog_device_register(name, dev, ops, THIS_MODULE, CONFIG_WATCHDOG_DEFAULT_TIMEOUT, 0)
+
+#define watchdog_device_register_selfping(name, dev, ops, selfping)  \
+	    _watchdog_device_register(name, dev, ops, THIS_MODULE, CONFIG_WATCHDOG_DEFAULT_TIMEOUT, selfping)
+	    
+extern struct watchdog_device *_watchdog_device_register(const char *name,
+					struct device *dev,
+					struct watchdog_class_ops *ops,
+					struct module *owner, int timeout, int sping);
+extern void watchdog_device_unregister(struct watchdog_device *wdev);
+extern int watchdog_interface_register(struct class_interface *intf);
+
+extern struct class_device *watchdog_class_open(char *name);
+extern void watchdog_class_close(struct class_device *class_dev);
+
+#define WATCHDOG_TO_MIN(x) ((x + 30) / 60)
+
+#endif	/* __KERNEL__ */
+
+#endif  /* ifndef _LINUX_WATCHDOG_H */
diff -Naur a/drivers/watchdog/watchdog-sysfs.c watchdog/drivers/watchdog/watchdog-sysfs.c
--- a/drivers/watchdog/watchdog-sysfs.c	1970-01-01 01:00:00.000000000 +0100
+++ watchdog/drivers/watchdog/watchdog-sysfs.c	2006-04-17 19:09:00.000000000 +0200
@@ -0,0 +1,113 @@
+/*
+ * Watchdog subsystem, sysfs interface
+ *
+ * Copyright (C) 2006 Rudolf Marek <r.marek@sh.cvut.cz>
+ *
+ * Based on the RTC class subsystem
+ *
+ * Copyright (C) 2005 Tower Technologies
+ * Author: Alessandro Zummo <a.zummo@towertech.it>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/module.h>
+#include "watchdog.h"
+
+/* device attributes */
+
+static ssize_t watchdog_sysfs_show_name(struct class_device *dev, char *buf)
+{
+	return sprintf(buf, "%s\n", to_watchdog_device(dev)->name);
+}
+static CLASS_DEVICE_ATTR(name, S_IRUGO, watchdog_sysfs_show_name, NULL);
+
+static ssize_t watchdog_sysfs_show_timeout(struct class_device *dev, char *buf)
+{
+	return sprintf(buf, "%d\n", to_watchdog_device(dev)->timeout);
+}
+
+static ssize_t watchdog_sysfs_store_timeout(struct class_device *dev,
+			    const char *buf, size_t count)
+{
+        struct watchdog_device *watchdog = to_watchdog_device(dev);
+	long val = simple_strtol(buf, NULL, 10);
+	ssize_t err;
+	err = watchdog->ops->set_timeout ? 
+		watchdog->ops->set_timeout(watchdog->class_dev.dev, val) : -EFAULT;
+	return err;
+}
+
+static CLASS_DEVICE_ATTR(timeout, S_IRUGO, watchdog_sysfs_show_timeout,
+				watchdog_sysfs_store_timeout);
+
+static ssize_t watchdog_sysfs_show_status(struct class_device *dev, char *buf)
+{
+	return sprintf(buf, "%ld\n", to_watchdog_device(dev)->status);
+}
+static CLASS_DEVICE_ATTR(status, S_IRUGO, watchdog_sysfs_show_status, NULL);
+
+static ssize_t watchdog_sysfs_show_boot_status(struct class_device *dev, char *buf)
+{
+	return sprintf(buf, "%ld\n", to_watchdog_device(dev)->boot_status);
+}
+static CLASS_DEVICE_ATTR(boot_status, S_IRUGO, watchdog_sysfs_show_boot_status, NULL);
+
+static struct attribute *watchdog_attrs[] = {
+	&class_device_attr_name.attr,
+	&class_device_attr_timeout.attr,
+	&class_device_attr_status.attr,
+	&class_device_attr_boot_status.attr,
+	NULL,
+};
+
+static struct attribute_group watchdog_attr_group = {
+	.attrs = watchdog_attrs,
+};
+
+static int __devinit watchdog_sysfs_add_device(struct class_device *class_dev,
+					struct class_interface *class_intf)
+{
+	int err;
+
+	dev_info(class_dev->dev, "watchdog intf: sysfs\n");
+
+	err = sysfs_create_group(&class_dev->kobj, &watchdog_attr_group);
+	if (err)
+		dev_err(class_dev->dev,
+			"failed to create sysfs attributes\n");
+
+	return err;
+}
+
+static void watchdog_sysfs_remove_device(struct class_device *class_dev,
+				struct class_interface *class_intf)
+{
+	sysfs_remove_group(&class_dev->kobj, &watchdog_attr_group);
+}
+
+/* interface registration */
+
+static struct class_interface watchdog_sysfs_interface = {
+	.add = &watchdog_sysfs_add_device,
+	.remove = &watchdog_sysfs_remove_device,
+};
+
+static int __init watchdog_sysfs_init(void)
+{
+	return watchdog_interface_register(&watchdog_sysfs_interface);
+}
+
+static void __exit watchdog_sysfs_exit(void)
+{
+	class_interface_unregister(&watchdog_sysfs_interface);
+}
+
+module_init(watchdog_sysfs_init);
+module_exit(watchdog_sysfs_exit);
+
+MODULE_AUTHOR("Rudolf Marek <r.marek@sh.cvut.cz>");
+MODULE_DESCRIPTION("Watchdog class sysfs interface");
+MODULE_LICENSE("GPL");

--------------020301030702010501030900--
