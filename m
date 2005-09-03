Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbVICKNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbVICKNu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 06:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbVICKNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 06:13:50 -0400
Received: from web30307.mail.mud.yahoo.com ([68.142.200.100]:9613 "HELO
	web30307.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751403AbVICKNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 06:13:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=q0sC6FMI+qF953XoHmn44IlO19Avmzv1Ssm7R+5fFkqNGCNQ+rtF0K78u31FxUJ8btSxod5xJCOQzsJDeSHuw57rHGWFOxw2KifOaGTpUbfDmaXVXoRcpYzjZ0P8lRRyVyvK4FsFepyoaOtmQQSMLltB5h16nk7iE3/3R7FZBPg=  ;
Message-ID: <20050903101341.23080.qmail@web30307.mail.mud.yahoo.com>
Date: Sat, 3 Sep 2005 11:13:41 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: [RFC][PATCH] SPI subsystem
To: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Cc: dpervushin@ru.mvista.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1340143323-1125742421=:20442"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1340143323-1125742421=:20442
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Here is a SPI framework which tries to use the driver
framework provided by the 2.6 kernel which you can
play around with on any platform, even on your PC :). 
 
This patch only contains a core layer that handles
un/registering of SPI adapters SPI devices and SPI
drivers. It is a work in progress and as yet has no
transfer methods, these will by moved from my old I2C
like core layer in the beginning of next work and I
will send another patch then. 
This framework removes all the platform knowledge from
the SPI adapter and all SPI knowledge (chip selects,
which adapter, etc) from the SPI driver. 
 
This patch still doesn&#8217;t address a couple of
platform abstraction problems. 
 
1) How to handle SPI devices that require an interrupt
line. 
This isn&#8217;t a problem on embedded systems as most
of these will have interrupt pins which are connected
directly to the interrupt controller, but what about
PCI cards which will have one interrupt line to the
interrupt controller and a interrupt status register.
In this case the adapter will have to take the
interrupt and workout if it was for it or for the SPI
device. One idea as to have function pointers for
registering, enabling and disabling interrupts in the
adapter structure. The core layer could fill in the
normal functions if an adapter driver doesn&#8217;t
fill them in, that way most adapter drivers
don&#8217;t have to do any extra work. 
 
2) Extra GPO lines used for reset, etc. 
These could be treated like extra CS lines which can
be changed in a spi_msg.

Mark

 drivers/Kconfig                   |    2 
 drivers/Makefile                  |    1 
 drivers/spi/Kconfig               |   58 +++
 drivers/spi/Makefile              |   10 
 drivers/spi/algos/Kconfig         |   19 +
 drivers/spi/algos/Makefile        |    9 
 drivers/spi/busses/Kconfig        |   17 +
 drivers/spi/busses/Makefile       |    9 
 drivers/spi/busses/spi-bus-test.c |  103 ++++++
 drivers/spi/chips/Kconfig         |   26 +
 drivers/spi/chips/Makefile        |   12 
 drivers/spi/chips/spi-bar.c       |   75 ++++
 drivers/spi/chips/spi-foo.c       |   75 ++++
 drivers/spi/spi-core.c            |  613
++++++++++++++++++++++++++++++++++++++
 drivers/spi/test/Kconfig          |   19 +
 drivers/spi/test/Makefile         |    5 
 drivers/spi/test/my_platform.c    |  133 ++++++++
 include/linux/spi.h               |  259
++++++++++++++++
 18 files changed, 1445 insertions(+)


	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com
--0-1340143323-1125742421=:20442
Content-Type: text/x-diff; name="spi-v1.patch"
Content-Description: 509471718-spi-v1.patch
Content-Disposition: inline; filename="spi-v1.patch"

diff -uprN -X dontdiff linux-2.6.10.orig/drivers/Kconfig linux-2.6.10/drivers/Kconfig
--- linux-2.6.10.orig/drivers/Kconfig	2005-09-02 13:57:42.000000000 +0100
+++ linux-2.6.10/drivers/Kconfig	2005-09-02 14:25:30.000000000 +0100
@@ -42,6 +42,8 @@ source "drivers/char/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 source "drivers/w1/Kconfig"
 
 source "drivers/misc/Kconfig"
diff -uprN -X dontdiff linux-2.6.10.orig/drivers/Makefile linux-2.6.10/drivers/Makefile
--- linux-2.6.10.orig/drivers/Makefile	2005-09-02 13:57:38.000000000 +0100
+++ linux-2.6.10/drivers/Makefile	2005-09-02 14:25:12.000000000 +0100
@@ -50,6 +50,7 @@ obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_I2O)		+= message/
 obj-$(CONFIG_I2C)		+= i2c/
+obj-$(CONFIG_SPI)		+= spi/
 obj-$(CONFIG_W1)		+= w1/
 obj-$(CONFIG_PHONE)		+= telephony/
 obj-$(CONFIG_MD)		+= md/
diff -uprN -X dontdiff linux-2.6.10.orig/drivers/spi/Kconfig linux-2.6.10/drivers/spi/Kconfig
--- linux-2.6.10.orig/drivers/spi/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/spi/Kconfig	2005-09-02 17:06:33.000000000 +0100
@@ -0,0 +1,58 @@
+#
+# SPI device configuration
+#
+
+menu "SPI support"
+
+config SPI
+	tristate "SPI support"
+	---help---
+	  SPI  is a simple serial bus protocol used in many micro controller.
+
+	  If you want SPI support, you should say Y here and also to the
+	  specific driver for your bus adapter(s) below.
+
+	  This SPI support can also be built as a module.  If so, the module
+	  will be called spi-core.
+
+source drivers/spi/algos/Kconfig
+source drivers/spi/busses/Kconfig
+source drivers/spi/chips/Kconfig
+source drivers/spi/test/Kconfig
+
+config SPI_DEBUG_CORE
+	bool "SPI Core debugging messages"
+	depends on SPI
+	help
+	  Say Y here if you want the SPI core to produce a bunch of debug
+	  messages to the system log.  Select this if you are having a
+	  problem with SPI support and want to see more of what is going on.
+
+config SPI_DEBUG_ALGO
+	bool "SPI Algorithm debugging messages"
+	depends on SPI
+	help
+	  Say Y here if you want the SPI algorithm drivers to produce a bunch
+	  of debug messages to the system log.  Select this if you are having
+	  a problem with SPI support and want to see more of what is going
+	  on.
+
+config SPI_DEBUG_BUS
+	bool "SPI Bus debugging messages"
+	depends on SPI
+	help
+	  Say Y here if you want the SPI bus drivers to produce a bunch of
+	  debug messages to the system log.  Select this if you are having
+	  a problem with SPI support and want to see more of what is going
+	  on.
+
+config SPI_DEBUG_CHIP
+	bool "SPI Chip debugging messages"
+	depends on SPI
+	help
+	  Say Y here if you want the SPI chip drivers to produce a bunch of
+	  debug messages to the system log.  Select this if you are having
+	  a problem with SPI support and want to see more of what is going
+	  on.
+
+endmenu
diff -uprN -X dontdiff linux-2.6.10.orig/drivers/spi/Makefile linux-2.6.10/drivers/spi/Makefile
--- linux-2.6.10.orig/drivers/spi/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/spi/Makefile	2005-09-02 14:19:15.000000000 +0100
@@ -0,0 +1,10 @@
+#
+# Makefile for the SPI core.
+#
+
+obj-$(CONFIG_SPI)		+= spi-core.o
+obj-y				+= busses/ chips/ algos/ test/
+
+ifeq ($(CONFIG_SPI_DEBUG_CORE),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
diff -uprN -X dontdiff linux-2.6.10.orig/drivers/spi/algos/Kconfig linux-2.6.10/drivers/spi/algos/Kconfig
--- linux-2.6.10.orig/drivers/spi/algos/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/spi/algos/Kconfig	2005-09-02 14:04:49.000000000 +0100
@@ -0,0 +1,19 @@
+#
+# SPI algorithm device configuration
+#
+
+menu "SPI Algorithms"
+	depends on SPI
+
+config SPI_ALGOBIT
+	tristate "SPI bit-banging interfaces"
+	depends on SPI
+	help
+	  This allows you to use a range of SPI adapters called bit-banging
+	  adapters.  Say Y if you own an SPI adapter belonging to this class
+	  and then say Y to the specific driver for you adapter below.
+
+	  This support is also available as a module.  If so, the module 
+	  will be called spi-algo-bit.
+
+endmenu
diff -uprN -X dontdiff linux-2.6.10.orig/drivers/spi/algos/Makefile linux-2.6.10/drivers/spi/algos/Makefile
--- linux-2.6.10.orig/drivers/spi/algos/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/spi/algos/Makefile	2005-09-02 14:05:34.000000000 +0100
@@ -0,0 +1,9 @@
+#
+# Makefile for the spi algorithms
+#
+
+obj-$(CONFIG_SPI_ALGOBIT)	+= spi-algo-bit.o
+
+ifeq ($(CONFIG_SPI_DEBUG_ALGO),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
diff -uprN -X dontdiff linux-2.6.10.orig/drivers/spi/busses/Kconfig linux-2.6.10/drivers/spi/busses/Kconfig
--- linux-2.6.10.orig/drivers/spi/busses/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/spi/busses/Kconfig	2005-09-02 14:10:40.000000000 +0100
@@ -0,0 +1,17 @@
+#
+# SPI adapter(s) configuration
+#
+
+menu "SPI Hardware Bus support"
+	depends on SPI	
+		  
+config SPI_BUS_TEST
+	tristate "Dummy SPI adapter used only for testing the subsystem"
+	depends on SPI
+	help
+	  See above ;)
+
+	  This support is also available as a module.  If so, the module 
+	  will be called spi-bus-test.
+
+endmenu
diff -uprN -X dontdiff linux-2.6.10.orig/drivers/spi/busses/Makefile linux-2.6.10/drivers/spi/busses/Makefile
--- linux-2.6.10.orig/drivers/spi/busses/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/spi/busses/Makefile	2005-09-02 14:11:35.000000000 +0100
@@ -0,0 +1,9 @@
+#
+# Makefile for the spi bus drivers.
+#
+
+obj-$(CONFIG_SPI_BUS_TEST)	+= spi-bus-test.o
+
+ifeq ($(CONFIG_SPI_DEBUG_BUS),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
diff -uprN -X dontdiff linux-2.6.10.orig/drivers/spi/busses/spi-bus-test.c linux-2.6.10/drivers/spi/busses/spi-bus-test.c
--- linux-2.6.10.orig/drivers/spi/busses/spi-bus-test.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/spi/busses/spi-bus-test.c	2005-09-02 17:08:39.000000000 +0100
@@ -0,0 +1,103 @@
+/*
+ *  linux/driver/spi/busses/spi-test_adap.c - dummy example SPI adapter
+ *					for un/registration demo only
+ *
+ *  Copyright (C) 2005 Philips Semicondutors, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Authors:
+ *	Mark Underwood
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/spi.h>
+#include <linux/device.h>
+
+#define DRIVER_NAME "spi-test"
+
+
+static int spi_test_probe(struct device *dev);
+static int spi_test_remove(struct device *dev);
+
+/* Platform structures for 2.6.x */
+static struct device_driver spi_test_driver = {
+	.owner	= THIS_MODULE,
+	.name	= DRIVER_NAME,
+	.bus	= &platform_bus_type,
+	.probe	= spi_test_probe,
+	.remove	= spi_test_remove,
+};
+
+
+static int spi_test_probe(struct device *dev)
+{
+	struct spi_adapter *sadap;
+	struct platform_device *pdev = to_platform_device(dev);	
+	int stat;
+	
+	printk("spi_test_probe\n");
+
+	sadap = kmalloc(sizeof(struct spi_adapter), GFP_KERNEL);
+	if(!sadap)
+	{
+		return -ENOMEM;
+	}
+	memset(sadap, 0, sizeof(struct spi_adapter));
+
+	sadap->spi_adap_cs = NULL;
+	sadap->cs_table = ((struct spi_platform_data*) (pdev->dev.platform_data))->cs_table;
+	sadap->max_cs = ((struct spi_platform_data*) (pdev->dev.platform_data))->max_cs;
+
+	sadap->adapter_dev = dev;
+	dev_set_drvdata(dev,sadap);		
+	stat=spi_add_adapter(sadap);
+	if (stat)
+		return -1;
+
+	return 0;
+}
+
+static int spi_test_remove(struct device *dev)
+{
+	struct spi_adapter *adap = dev_get_drvdata(dev);	
+
+	printk("spi_test_remove\n");
+	/* Unregister the adaptor with the SPI subsystem */
+	if (spi_del_adapter(adap))
+	{
+		printk("Fialed to remove adapter\n");
+		return -1;
+	}
+
+	kfree(adap);
+	return 0;
+}
+
+static int __init spi_test_init(void)
+{
+	int ret = 0;
+
+	ret = driver_register(&spi_test_driver);
+	if (ret)		
+		return -ENODEV;
+
+	return 0;
+}
+
+static void __exit spi_test_cleanup(void)
+{
+	driver_unregister(&spi_test_driver);
+}
+
+module_init(spi_test_init);
+module_exit (spi_test_cleanup);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mark Underwood mark.underwood(at)philips.com");
+MODULE_DESCRIPTION("Test SPI driver for bus layer debugging");
diff -uprN -X dontdiff linux-2.6.10.orig/drivers/spi/chips/Kconfig linux-2.6.10/drivers/spi/chips/Kconfig
--- linux-2.6.10.orig/drivers/spi/chips/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/spi/chips/Kconfig	2005-09-02 14:15:39.000000000 +0100
@@ -0,0 +1,26 @@
+#
+# SPI devices configuration
+#
+
+menu "SPI chip support"
+	depends on SPI
+
+config SPI_FOO
+	tristate "SPI FOO"
+	help
+	  If you say yes here if you want to build the dummy spi device,
+	  spi-foo, for use in spi core debugging only.
+	  
+	  This driver can also be built as a module.  If so, the module
+	  will be called spi_foo.	
+
+config SPI_BAR
+	tristate "SPI BAR"
+	help
+	  If you say yes here if you want to build the dummy spi device,
+	  spi-bar, for use in spi core debugging only.
+	  
+	  This driver can also be built as a module.  If so, the module
+	  will be called spi_bar.
+
+endmenu
diff -uprN -X dontdiff linux-2.6.10.orig/drivers/spi/chips/Makefile linux-2.6.10/drivers/spi/chips/Makefile
--- linux-2.6.10.orig/drivers/spi/chips/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/spi/chips/Makefile	2005-09-02 14:16:38.000000000 +0100
@@ -0,0 +1,12 @@
+#
+# Makefile for the kernel hardware sensors chip drivers.
+#
+
+EXTRA_CFLAGS	:= -Idrivers/misc
+
+obj-$(CONFIG_SPI_FOO)	+= spi-foo.o
+obj-$(CONFIG_SPI_BAR)	+= spi-bar.o
+
+ifeq ($(CONFIG_SPI_DEBUG_CHIP),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
diff -uprN -X dontdiff linux-2.6.10.orig/drivers/spi/chips/spi-bar.c linux-2.6.10/drivers/spi/chips/spi-bar.c
--- linux-2.6.10.orig/drivers/spi/chips/spi-bar.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/spi/chips/spi-bar.c	2005-09-02 17:29:16.000000000 +0100
@@ -0,0 +1,75 @@
+/*
+ *  linux/driver/spi/chips/spi-bar.c - dummy example SPI client for
+ *					un/registration demo only
+ *
+ *  Copyright (C) 2005 Philips Semicondutors, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Authors:
+ *	Mark Underwood
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/spi.h>
+
+#define DRIVER_NAME		"spi-bar"
+
+
+/* Local functions */
+
+static int bar_probe(struct device *dev);
+static int bar_remove(struct device *dev);
+static int __init spi_bar_init(void);
+static void __exit spi_bar_cleanup(void);
+
+
+static struct spi_driver bar_driver = {
+	.owner	= THIS_MODULE,
+	.name	= DRIVER_NAME,
+	.probe	= bar_probe,
+	.remove	= bar_remove,
+};
+
+
+static int bar_probe(struct device *dev)
+{	
+	printk("bar_probe\n");
+
+	return 0;
+}
+
+static int bar_remove(struct device *dev)
+{
+	printk("bar_remove\n");
+	return 0;
+}
+
+
+
+static int __init spi_bar_init(void)
+{
+	int res;
+
+	if ((res = spi_driver_register(&bar_driver))) {
+		printk("spi-bar: Driver registration failed, module not inserted.\n");
+		return res;
+	}
+        return 0;
+}
+
+static void __exit spi_bar_cleanup(void)
+{
+	spi_driver_unregister(&bar_driver);
+}
+
+module_init(spi_bar_init);
+module_exit(spi_bar_cleanup);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mark Underwood mark.underwood(at)philips.com");
+MODULE_DESCRIPTION("SPI bar driver for bus layer debugging");
diff -uprN -X dontdiff linux-2.6.10.orig/drivers/spi/chips/spi-foo.c linux-2.6.10/drivers/spi/chips/spi-foo.c
--- linux-2.6.10.orig/drivers/spi/chips/spi-foo.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/spi/chips/spi-foo.c	2005-09-02 17:29:14.000000000 +0100
@@ -0,0 +1,75 @@
+/*
+ *  linux/driver/spi/chips/spi-foo.c - dummy example SPI client for
+ *					un/registration demo only
+ *
+ *  Copyright (C) 2005 Philips Semicondutors, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Authors:
+ *	Mark Underwood
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/spi.h>
+
+#define DRIVER_NAME		"spi-foo"
+
+
+/* Local functions */
+
+static int foo_probe(struct device *dev);
+static int foo_remove(struct device *dev);
+static int __init spi_foo_init(void);
+static void __exit spi_foo_cleanup(void);
+
+
+static struct spi_driver foo_driver = {
+	.owner	= THIS_MODULE,
+	.name	= DRIVER_NAME,
+	.probe	= foo_probe,
+	.remove	= foo_remove,
+};
+
+
+static int foo_probe(struct device *dev)
+{	
+	printk("foo_probe\n");
+
+	return 0;
+}
+
+static int foo_remove(struct device *dev)
+{
+	printk("foo_remove\n");
+	return 0;
+}
+
+
+
+static int __init spi_foo_init(void)
+{
+	int res;
+
+	if ((res = spi_driver_register(&foo_driver))) {
+		printk("spi-foo: Driver registration failed, module not inserted.\n");
+		return res;
+	}
+        return 0;
+}
+
+static void __exit spi_foo_cleanup(void)
+{
+	spi_driver_unregister(&foo_driver);
+}
+
+module_init(spi_foo_init);
+module_exit(spi_foo_cleanup);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mark Underwood mark.underwood(at)philips.com");
+MODULE_DESCRIPTION("SPI foo driver for bus layer debugging");
diff -uprN -X dontdiff linux-2.6.10.orig/drivers/spi/spi-core.c linux-2.6.10/drivers/spi/spi-core.c
--- linux-2.6.10.orig/drivers/spi/spi-core.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/spi/spi-core.c	2005-09-02 17:29:50.000000000 +0100
@@ -0,0 +1,613 @@
+/*
+ *  linux/driver/spi/spi-core.c - The spi subsystem core layer
+ *
+ *  Copyright (C) 2005 Philips Semicondutors, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Authors:
+ *	Mark Underwood
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/spi.h>
+#include <linux/idr.h>
+
+#define SPI_CORE_NONE	0
+#define SPI_CORE_BUS	1
+#define SPI_CORE_DRIVER	2
+#define SPI_CORE_CLASS	3
+#define SPI_CORE_DONE	4
+
+static DEFINE_IDR(spi_adapter_idr);
+
+void __spi_device_unregister(struct spi_device * sdev);
+int __spi_device_register(struct spi_device * sdev);
+
+/************************/
+/* spi client functions */
+/************************/
+
+static ssize_t show_client_name(struct device *dev, char *buf)
+{
+	struct spi_device *sdev = to_spi_device(dev);
+	return sprintf(buf, "%s\n", sdev->name);
+}
+
+static DEVICE_ATTR(device_name, S_IRUGO, show_client_name, NULL);
+
+static void spi_device_release(struct device *dev)
+{
+	struct spi_device *sdev = to_spi_device(dev);
+
+	kfree(sdev);
+}
+
+
+/* This probe doesn't actually probe, but sets up the
+ * client structure so the spi_drivers probe can do
+ * some transfers if required.
+ */ 
+int spi_device_probe(struct device *dev)
+{
+	struct spi_driver *sdrv = to_spi_driver(dev->driver);
+	int error = -ENODEV;
+		
+	if (!sdrv->probe)
+		return error;
+
+	error = sdrv->probe(dev);
+	
+	return error;
+}
+
+/* This remove doesn't actually remove, calls the
+ * client remove and then frees the client structure.
+ */
+int spi_device_remove(struct device *dev)
+{
+	struct spi_driver *sdrv = to_spi_driver(dev->driver);
+	
+	if (sdrv->remove)
+		sdrv->remove(dev);
+
+	return 0;
+}
+
+/**********************************************/
+/* spi_adapter_class functions and structures */
+/**********************************************/	
+
+static void spi_adapter_class_dev_release(struct class_device *dev)
+{
+}
+
+static struct class spi_adapter_class = {
+	.name		= "spi-adapter",
+	.release	= &spi_adapter_class_dev_release,
+};
+
+static ssize_t show_adap_dev_name(struct device *dev, char *buf)
+{
+	struct spi_adapter *adap = dev_to_spi_adapter(dev);
+
+	return sprintf(buf, "%s\n", adap->adapter_dev->bus_id);
+}
+
+static DEVICE_ATTR(adap_dev_name, S_IRUGO, show_adap_dev_name, NULL);
+
+/* This function gets called every time an spi-adapter
+ * calss device is registered.
+ */
+int spi_add_adapter_if(struct class_device *cd)
+{
+	struct device *dev = cd->dev;
+	struct spi_adapter *adap = dev_to_spi_adapter(dev);
+	struct spi_device *new_device;
+	int i, j;
+	int ret = -EFAULT;
+	
+	up(&adap->bus_lock);
+
+	/* Go though the CS table and add all the devices that
+	 * are sitting on it.
+	 */
+	j = 0;
+	for (i=0;i<adap->max_cs;i++)
+	{
+		new_device = kmalloc(sizeof(struct spi_device), GFP_KERNEL);
+		if (!new_device)
+		{
+			ret = -ENOMEM;
+			goto fail2;
+		}
+		memset(new_device,0,sizeof(struct spi_device));
+
+		strlcpy(new_device->name, adap->cs_table[i].name, SPI_NAME_SIZE);
+		new_device->cs_no = adap->cs_table[i].cs_no;
+		new_device->adapter = adap;
+		new_device->dev.parent = &adap->dev;
+		ret = __spi_device_register(new_device);
+		if (ret)
+			goto fail1;
+	}
+	
+	device_create_file(dev, &dev_attr_adap_dev_name);
+
+	down(&adap->bus_lock);
+	return 0;
+
+fail2:
+	kfree(new_device);
+fail1:
+	for (j=0;j<(i-1);j++)
+		__spi_device_unregister(new_device);
+	down(&adap->bus_lock);
+	return ret;
+}
+
+void spi_remove_adapter_if(struct class_device *cd)
+{
+	struct device *dev = cd->dev;
+	struct device *child, *next_ptr;
+	struct spi_device *sdev;
+	struct spi_adapter *adap = dev_to_spi_adapter(dev);
+
+	device_remove_file(dev, &dev_attr_adap_dev_name);
+	list_for_each_entry_safe(child, next_ptr, &dev->children, node) {
+		sdev = to_spi_device(child);
+		pr_debug("Removing %s from cs %d\n",sdev->name, sdev->cs_no);
+		__spi_device_unregister(sdev);
+	}	
+
+	/* kill off the work queue */
+        flush_workqueue(adap->work_queue);
+	destroy_workqueue(adap->work_queue);
+	
+	idr_remove(&spi_adapter_idr, adap->nr);
+}
+
+static struct class_interface spi_adapter_class_interface = {
+	.class	= &spi_adapter_class,
+	.add	= spi_add_adapter_if,
+	.remove	= spi_remove_adapter_if,
+};
+
+
+/**********************************************/
+/* spi adapter device functions and structure */
+/**********************************************/
+int spi_adapter_probe(struct device *dev)
+{
+	return 0;
+}
+
+int spi_adapter_remove(struct device *dev)
+{
+	return 0;
+}
+
+static struct device_driver spi_adapter_driver = {
+	.name =	"spi_adapter",
+	.bus = &spi_bus_type,
+	.probe = spi_adapter_probe,
+	.remove = spi_adapter_remove,
+};
+ 
+static void spi_adapter_dev_release(struct device *dev)
+{
+}
+
+
+/**************************/
+/* Functions for the core */
+/**************************/
+
+/* This function is called within the work queue context to 
+ * determine the process ID of the work queue context
+ */
+void spi_find_work_queue_current(void * info)
+{
+	struct spi_adapter * adap = (struct spi_adapter *) info;
+
+	if(adap)
+		adap->work_queue_current = get_current();
+}
+
+
+/* return id number for a specific adapter  */
+int spi_adapter_id(struct spi_adapter *adap)
+{
+	return adap->nr;
+}
+
+
+/**
+ *	__spi_device_register - add a spi-level device
+ *	@dev:	spi device we're adding
+ *
+ *	Note that this must be called with the adapters
+ *	bus lock
+ */
+
+int __spi_device_register(struct spi_device * sdev)
+{
+	int ret = 0;
+
+	if (!sdev)
+		return -EINVAL;
+
+	/* Need to sort this out. No-one should have parent undiffined */
+	if (!sdev->dev.parent)
+	{
+		printk("parent pointer must be set to the SPI adapter the the device is on\n");
+		return -EINVAL;
+	}
+
+	sdev->dev.bus = &spi_bus_type;
+	sdev->dev.release = &spi_device_release;
+		
+	snprintf(sdev->dev.bus_id, BUS_ID_SIZE,
+		"%d-%04x", spi_adapter_id(sdev->adapter), sdev->cs_no);
+
+	pr_debug("Registering spi device '%s'. Parent at %s\n",
+		 sdev->dev.bus_id, sdev->dev.parent->bus_id);
+
+	ret = device_register(&sdev->dev);
+
+	if (!ret)
+		device_create_file(&sdev->dev, &dev_attr_device_name);
+
+	return ret;
+}
+
+/**
+ *	__spi_device_unregister - remove a spi-level device
+ *	@sdev:	spi device we're removing
+ *
+ *	Note that this must be called with the adapters
+ *	bus lock
+ */
+
+void __spi_device_unregister(struct spi_device * sdev)
+{
+	if (sdev) {
+		device_remove_file(&sdev->dev, &dev_attr_device_name);
+		device_unregister(&sdev->dev);
+	}
+}
+
+/**
+ *	spi_unravel - unregister the things the core layer uses
+ *	progress:	how far the registration got
+ */
+
+static void spi_unravel(int progress)
+{
+	switch (progress)
+	{
+		case SPI_CORE_DONE:
+			class_interface_unregister(&spi_adapter_class_interface);
+		case SPI_CORE_CLASS:
+			class_unregister(&spi_adapter_class);
+		case SPI_CORE_DRIVER:
+			driver_unregister(&spi_adapter_driver);
+		case SPI_CORE_BUS:
+			bus_unregister(&spi_bus_type);
+	}
+}
+
+/*************************************************/
+/* Exported functions for use by adapter drivers */
+/*************************************************/
+
+/* spi_add_adapter is called from within the algorithm layer,
+ * when a new hw adapter registers. A new device is register to be
+ * available for clients.
+ */
+int spi_add_adapter(struct spi_adapter *adap)
+{
+	int id, res = 0;
+	struct work_struct * find_current;
+
+	if (idr_pre_get(&spi_adapter_idr, GFP_KERNEL) == 0) {
+		res = -ENOMEM;
+		goto fail_pre_idr;
+	}
+
+	res = idr_get_new(&spi_adapter_idr, NULL, &id);
+	if (res < 0) {
+		if (res == -EAGAIN)
+		{
+			res = -ENOMEM;
+			goto fail_pre_idr;
+		}
+	}
+
+	adap->nr =  id & MAX_ID_MASK;
+	init_MUTEX(&adap->bus_lock);
+
+	/* setup the adapter so we can do transfers
+	 * when the spi-adapter device gets registered
+	 */
+
+        /* begin setting up the work queue for each adapter */
+	adap->work_queue = create_workqueue(adap->dev.bus_id);
+
+	/* get the work queue to find its own pid and store it for further use */
+	find_current = kmalloc(sizeof (struct work_struct),GFP_KERNEL);
+	INIT_WORK(find_current,spi_find_work_queue_current, (void *) adap);
+	queue_work(adap->work_queue,find_current);
+	
+	/* Add the adapter to the driver core.
+	 * If the parent pointer is not set up,
+	 * we add this adapter to the host bus.
+	 */
+	if (adap->dev.parent == NULL)
+		adap->dev.parent = &platform_bus;
+	sprintf(adap->dev.bus_id, "spi-%d", adap->nr);
+
+	/* Register the spi adapter which we
+	 * hang spi devices off. After this
+	 * the spi-adapter probe function will
+	 * be called.
+	 */
+	adap->dev.driver = &spi_adapter_driver;
+	adap->dev.release = &spi_adapter_dev_release;
+	device_register(&adap->dev);
+
+	/* Add this adapter to the spi_adapter
+	 * class.
+	 */
+	memset(&adap->class_dev, 0x00, sizeof(struct class_device));
+	adap->class_dev.dev = &adap->dev;
+	adap->class_dev.class = &spi_adapter_class;
+	strlcpy(adap->class_dev.class_id, adap->dev.bus_id, BUS_ID_SIZE);
+	res = class_device_register(&adap->class_dev);
+	if (res)
+	{
+		res = -EFAULT;
+		goto fail;
+	}
+
+	dev_dbg(&adap->dev, "registered as adapter #%d\n", adap->nr);
+
+	return 0;
+fail:
+	idr_remove(&spi_adapter_idr, adap->nr);
+fail_pre_idr:
+	return res;
+}
+EXPORT_SYMBOL(spi_add_adapter);
+
+int spi_del_adapter(struct spi_adapter *adap)
+{
+	up(&adap->bus_lock);
+
+	/* clean up the sysfs representation */
+	class_device_unregister(&adap->class_dev);
+	device_unregister(&adap->dev);
+
+	dev_dbg(&adap->dev, "adapter unregistered\n");
+
+	down(&adap->bus_lock);
+	return 0;
+}
+EXPORT_SYMBOL(spi_del_adapter);
+
+
+/****************************************************/
+/* Exported functions for use by spi device drivers */
+/****************************************************/
+
+int spi_driver_register(struct spi_driver *sdriver)
+{
+	int res = 0;
+
+	/* add the driver to the list of spi drivers in the driver core */
+	sdriver->driver.name = sdriver->name;
+	sdriver->driver.bus = &spi_bus_type;
+	sdriver->driver.probe = spi_device_probe;
+	sdriver->driver.remove = spi_device_remove;
+
+	res = driver_register(&sdriver->driver);
+	if (!res)
+		pr_debug("spi-core: driver %s registered.\n", sdriver->name);
+
+	return res;
+}
+EXPORT_SYMBOL(spi_driver_register);
+
+int spi_driver_unregister(struct spi_driver *sdriver)
+{
+	driver_unregister(&sdriver->driver);
+	/*list_del(&sdriver->list);*/
+	pr_debug("spi-core: driver unregistered: %s\n", sdriver->name);
+
+	return 0;
+}
+EXPORT_SYMBOL(spi_driver_unregister);
+
+/**************************************************************/
+/* Exported functions to register extra devices to an adapter */
+/**************************************************************/
+
+/**
+ *	spi_device_register - add a spi-level device
+ *	@dev:	spi device we're adding
+ */
+
+int spi_device_register(struct spi_device * sdev)
+{
+	struct spi_adapter *adap = dev_to_spi_adapter(&sdev->dev);
+	int ret;
+	
+	up(&adap->bus_lock);
+	ret = __spi_device_register(sdev);
+	down(&adap->bus_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_device_register);
+
+/**
+ *	spi_device_register - add a spi-level device
+ *	@dev:	spi device we're adding
+ */
+
+void spi_device_unregister(struct spi_device * sdev)
+{
+	struct spi_adapter *adap = dev_to_spi_adapter(&sdev->dev);
+
+	up(&adap->bus_lock);
+	__spi_device_unregister(sdev);
+	down(&adap->bus_lock);
+}
+EXPORT_SYMBOL_GPL(spi_device_unregister);
+
+/**
+ *	spi_match - bind spi device to spi driver.
+ *	@dev:	device.
+ *	@drv:	driver.
+ *
+ *	spi device IDs are assumed to be encoded like this:
+ *	"<name><instance>", where <name> is a short description of the
+ *	type of device, like "pci" or "floppy", and <instance> is the
+ *	enumerated instance of the device, like '0' or '42'.
+ *	Driver IDs are simply "<name>".
+ *	So, extract the <name> from the spi_device structure,
+ *	and compare it against the name of the driver. Return whether
+ *	they match or not.
+ */
+
+static int spi_match(struct device * dev, struct device_driver * drv)
+{
+	struct spi_device *sdev = container_of(dev, struct spi_device, dev);
+	int ret;
+	
+	ret = (strncmp(sdev->name, drv->name, SPI_NAME_SIZE) == 0);
+	return ret;
+}
+
+static int spi_suspend(struct device * dev, u32 state)
+{
+	struct device *child;
+	int ret = 0;
+
+	/* First suspend all the children */
+	list_for_each_entry(child, &dev->children, node) {
+		if (child->driver && child->driver->suspend) {
+			ret = child->driver->suspend(child, state, SUSPEND_DISABLE);
+			if (ret == 0)
+				ret = child->driver->suspend(child, state, SUSPEND_SAVE_STATE);
+			if (ret == 0)
+				ret = child->driver->suspend(child, state, SUSPEND_POWER_DOWN);
+		}
+	}
+
+	if (ret)
+		return ret;
+
+	/* Then the adapter */
+	if (dev->driver && dev->driver->suspend) {
+		ret = dev->driver->suspend(dev, state, SUSPEND_DISABLE);
+		if (ret == 0)
+			ret = dev->driver->suspend(dev, state, SUSPEND_SAVE_STATE);
+		if (ret == 0)
+			ret = dev->driver->suspend(dev, state, SUSPEND_POWER_DOWN);
+	}
+
+	return ret;
+}
+
+static int spi_resume(struct device * dev)
+{
+	int ret = 0;
+	struct device *child;
+
+	/* First resume the adapter */
+	if (dev->driver && dev->driver->resume) {
+		ret = dev->driver->resume(dev, RESUME_POWER_ON);
+		if (ret == 0)
+			ret = dev->driver->resume(dev, RESUME_RESTORE_STATE);
+		if (ret == 0)
+			ret = dev->driver->resume(dev, RESUME_ENABLE);
+	}
+
+	if (ret)
+		return ret;
+
+	/* Then all the children */
+	list_for_each_entry(child, &dev->children, node) {
+		if (child->driver && child->driver->resume) {
+			ret = child->driver->resume(child, RESUME_POWER_ON);
+			if (ret == 0)
+				ret = child->driver->resume(child, RESUME_RESTORE_STATE);
+			if (ret == 0)
+				ret = child->driver->resume(child, RESUME_ENABLE);
+			if (ret)
+				break;
+		}
+	}
+
+	return ret;
+}
+
+struct bus_type spi_bus_type = {
+	.name		= "spi",
+	.match		= spi_match,
+	.suspend	= spi_suspend,
+	.resume		= spi_resume,
+};
+
+EXPORT_SYMBOL_GPL(spi_bus_type);
+
+
+int __init spi_bus_init(void)
+{
+	int ret;
+	int progress = SPI_CORE_NONE;
+	
+	ret = bus_register(&spi_bus_type);
+	if (ret)
+		goto fail;
+
+	progress = SPI_CORE_BUS;
+	ret = driver_register(&spi_adapter_driver);
+	if (ret)
+		goto fail;
+
+	progress = SPI_CORE_DRIVER;
+	ret = class_register(&spi_adapter_class);
+	if (ret)
+		goto fail;
+
+	progress = SPI_CORE_CLASS;	
+	ret = class_interface_register(&spi_adapter_class_interface);
+	if (ret)
+		goto fail;
+
+	progress = SPI_CORE_DONE;
+	return 0;
+
+fail:
+	spi_unravel(progress);
+	return ret;
+
+}
+
+static void __exit spi_exit(void)
+{
+	spi_unravel(SPI_CORE_DONE);
+}
+
+subsys_initcall(spi_bus_init);
+module_exit(spi_exit);
+
+MODULE_AUTHOR("Mark Underwood mark.underwood(at)philips.com");
+MODULE_DESCRIPTION("cut down spi-bus core module for bus testing");
+MODULE_LICENSE("GPL");
diff -uprN -X dontdiff linux-2.6.10.orig/drivers/spi/test/Kconfig linux-2.6.10/drivers/spi/test/Kconfig
--- linux-2.6.10.orig/drivers/spi/test/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/spi/test/Kconfig	2005-09-02 14:22:16.000000000 +0100
@@ -0,0 +1,19 @@
+#
+# SPI algorithm device configuration
+#
+
+menu "SPI TEST"
+	depends on SPI
+
+config SPI_TEST_PLAT
+	tristate "SPI test platform"
+	depends on SPI
+	help
+	  !!! This shouldn't be here !!! It is provided only to demo the
+	  spi subsystem. This is an example of how to register platform
+	  information with the subsystem
+
+	  This support is also available as a module.  If so, the module 
+	  will be called my_platform.
+
+endmenu
diff -uprN -X dontdiff linux-2.6.10.orig/drivers/spi/test/Makefile linux-2.6.10/drivers/spi/test/Makefile
--- linux-2.6.10.orig/drivers/spi/test/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/spi/test/Makefile	2005-09-02 17:06:56.000000000 +0100
@@ -0,0 +1,5 @@
+#
+# Makefile for the spi algorithms
+#
+
+obj-$(CONFIG_SPI_TEST_PLAT)	+= my_platform.o
diff -uprN -X dontdiff linux-2.6.10.orig/drivers/spi/test/my_platform.c linux-2.6.10/drivers/spi/test/my_platform.c
--- linux-2.6.10.orig/drivers/spi/test/my_platform.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/drivers/spi/test/my_platform.c	2005-09-02 17:28:02.000000000 +0100
@@ -0,0 +1,133 @@
+/*
+ *  linux/driver/spi/spi-platform.c
+ *
+ *  Copyright (C) 2005 Philips Semicondutors, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Authors:
+ *	Mark Underwood
+ */
+
+ /*
+  * This file contains the registration structures, CS code & unregister
+  * for SPI on the platform.
+  */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/spi.h>
+#include <linux/errno.h>
+
+static const struct spi_cs_table platform_spi1_cs_table[] = {
+	{
+		.name		= "spi-foo",
+		.cs_no		= 0,
+		.platform_data	= NULL,
+		.flags		= SPI_CS_IDLE_HIGH,
+		.cs_data	= 0,
+	},
+	{
+		.name		= "spi-foo",
+		.cs_no		= 1,
+		.platform_data	= NULL,
+		.flags		= SPI_CS_IDLE_HIGH,
+		.cs_data	= 0,
+	},
+};
+
+static const struct spi_cs_table platform_spi2_cs_table[] = {
+	{
+		.name		= "spi-bar",
+		.cs_no		= 0,
+		.platform_data	= NULL,
+		.flags		= SPI_CS_IDLE_HIGH,
+		.cs_data	= 0,
+	},
+	{
+		.name		= "spi-foo",
+		.cs_no		= 1,
+		.platform_data	= NULL,
+		.flags		= SPI_CS_IDLE_HIGH,
+		.cs_data	= 0,
+	},
+	{
+		.name		= "spi-foo",
+		.cs_no		= 2,
+		.platform_data	= NULL,
+		.flags		= SPI_CS_IDLE_HIGH,
+		.cs_data	= 0,
+	},
+};
+
+static struct spi_platform_data platform_spi1_platdat = {
+	.spi_adap_cs = NULL,
+	.cs_table = platform_spi1_cs_table,
+	.max_cs = ARRAY_SIZE(platform_spi1_cs_table),
+};
+
+static struct spi_platform_data platform_spi2_platdat = {
+	.spi_adap_cs = NULL,
+	.cs_table = platform_spi2_cs_table,
+	.max_cs = ARRAY_SIZE(platform_spi2_cs_table),
+};
+
+static void platform_spi_release(struct device *device)
+{
+}
+
+static struct platform_device spi_test_dev1= {
+	.name		= "spi-test",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &platform_spi1_platdat,
+		.release	= platform_spi_release,
+	},
+};
+
+static struct platform_device spi_test_dev2= {
+	.name		= "spi-test",
+	.id		= 1,
+	.dev = {
+		.platform_data	= &platform_spi2_platdat,
+		.release	= platform_spi_release,
+	},
+};
+
+static int __init platform_spi_init(void)
+{
+	int ret = 0;
+
+        ret = platform_device_register(&spi_test_dev1);
+	if (ret)
+		goto fail0;
+
+        ret = platform_device_register(&spi_test_dev2);
+	if (ret)
+		goto fail1;
+
+	return 0;
+
+fail1:
+	platform_device_unregister(&spi_test_dev1);
+fail0:
+	return ret;
+}
+
+static void __exit platform_spi_cleanup(void)
+{
+	/* Release the GPIO lines used for CS */
+	platform_device_unregister(&spi_test_dev1);
+	platform_device_unregister(&spi_test_dev2);
+}
+
+module_init(platform_spi_init);
+module_exit(platform_spi_cleanup);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mark Underwood mark.underwood(at)philips.com");
+MODULE_DESCRIPTION("Example SPI platform");
diff -uprN -X dontdiff linux-2.6.10.orig/include/linux/spi.h linux-2.6.10/include/linux/spi.h
--- linux-2.6.10.orig/include/linux/spi.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/include/linux/spi.h	2005-09-02 14:57:40.000000000 +0100
@@ -0,0 +1,259 @@
+/*
+ *  include/linux/spi.h - The spi subsystem header file
+ *
+ *  Copyright (C) 2005 Philips Semicondutors, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Authors:
+ *	Mark Underwood
+ */
+
+#ifndef _LINUX_spi_H
+#define _LINUX_spi_H
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/device.h>	/* for struct device */
+#include <asm/semaphore.h>
+
+#define SPI_NAME_SIZE 32
+
+/* --- General options ------------------------------------------------	*/
+
+struct spi_msg;
+struct spi_items; /* scatter gather list for SPI */
+
+struct spi_algorithm;
+struct spi_adapter;
+struct spi_client;
+struct spi_driver;
+extern struct bus_type spi_bus_type;
+
+/* Transfer a message, which can be an arbitrary number of
+ * 'items'. An item is an individual block transfer, read
+ * or write, with associated chip select control.
+ */
+extern int spi_transfer(struct spi_msg * msg);
+
+
+/********************************/
+/* spi device/driver structures */
+/********************************/
+
+/* A spi device driver is capable of handling one or more physical devices present
+ * on one or more spi adapters. This information is used to inform the driver of adapter
+ * events.
+ */
+ 
+/* If we drop command then we could drop struct spi_driver and just register a driver */
+struct spi_driver {
+	struct module *owner;
+	char name[SPI_NAME_SIZE];
+
+	int (*probe)(struct device *);
+	int (*remove)(struct device *);
+/* FIXME? Do we need command? */
+	int (*command)(struct device *,unsigned int cmd, void *arg);
+	struct device_driver driver;	/* This is filled in by the subsystem and
+					 * registered with the kernel
+					 */
+};
+#define to_spi_driver(d) container_of(d, struct spi_driver, driver)
+
+
+struct spi_device {
+	unsigned char name[SPI_NAME_SIZE];
+	int 	id;
+	unsigned int	cs_no;		/* The devices cs number        */
+	struct spi_adapter *adapter;	/* the adapter we sit on        */
+/* FIXME? Do we need this? */
+	struct spi_driver *driver;	/* and our access routines      */
+	unsigned int clock;		/* Max clock speed that the     */
+					/* slave can handle in HZ.      */ 
+	unsigned char cs_level;		/* CS level: actice low = 0     */
+					/* actice high = 1              */
+	/* This is used for transfers without callback */
+	struct semaphore  blocking_sem;
+	struct device dev;
+};
+#define to_spi_device(x) container_of((x), struct spi_device, dev)
+
+/**********************************/
+/* spi adapter related structures */
+/**********************************/
+
+/* spi_adapter is the structure used to identify a physical spi bus along
+ * with the access algorithms necessary to access it.
+ */
+struct spi_adapter {
+	struct module *owner;
+	char name[SPI_NAME_SIZE];
+	int nr;
+		
+	struct spi_algorithm *algo;/* the algorithm to access the bus	*/
+	void *algo_data;
+
+	struct semaphore bus_lock;
+
+	int timeout;
+	int retries;
+	struct device *adapter_dev;	/* Pointer to the dev structure */
+					/* of the adapter */
+	struct device dev;		/* the adapter device */
+	struct class_device class_dev;	/* the class device */
+
+/* FIXME? Please can we drop this? */
+#ifdef CONFIG_PROC_FS 
+	int inode;
+#endif
+        
+	/* Assert/release spi chip select line */
+	int (*spi_adap_cs)(struct spi_adapter *,int id,int val);
+        
+        /* Set the SPI clock speed. */
+	void (*set_spi_adap_clock)(struct spi_adapter *, int clock);
+        
+        /* table of assigned spi devices to this adapter */
+	const struct spi_cs_table *cs_table;
+	int max_cs;
+	
+	/* work queue controlling structure */
+	struct workqueue_struct * work_queue;
+	
+	/* PID of work queue current */
+	void * work_queue_current;
+};
+#define dev_to_spi_adapter(d) container_of(d, struct spi_adapter, dev)
+#define class_dev_to_spi_adapter(d) container_of(d, struct spi_adapter, class_dev)
+
+/*
+ * The following structs are for those who like to implement new bus drivers:
+ * spi_algorithm is the interface to a class of hardware solutions which can
+ * be addressed using the same bus algorithms - e.g. bit-banging.
+ */
+struct spi_algorithm {
+	char name[32];     /* textual description 	*/
+	unsigned int id;
+
+	int (*master_xfer)(struct spi_msg * msg);
+
+	/* --- these optional/future use for some adapter types.*/
+	int (*slave_send)(struct spi_adapter *,char*,int);
+	int (*slave_recv)(struct spi_adapter *,char*,int);
+
+	/* To determine what the adapter supports */
+	unsigned int functionality;
+};
+
+/***********************************/
+/* platform abstraction structures */
+/***********************************/
+
+/* struct spi_cs_table contains the information about a device that
+ * is on an adapter. An array of these are passed to the adapter
+ * so it knows what devices are where.
+ */
+
+struct spi_cs_table {
+	char name[SPI_NAME_SIZE];
+	int id;
+	int cs_no;
+	void *platform_data;
+	int flags;	/* starting with CS high or low ? */
+#define SPI_CS_IDLE_HIGH  1
+#define SPI_CS_IDLE_LOW   0 
+	void *cs_data;
+};
+
+
+/* struct spi_platform_data is the structure used to pass the platform
+ * dependent information when registering a spi adapter (in platform_device).
+ */
+ 
+struct spi_platform_data {
+	int (* spi_adap_cs)(struct spi_adapter *,int id,int val);
+	const struct spi_cs_table *cs_table;
+        int max_cs;
+	struct clk *clk;
+	struct spi_adapter *adap;
+};
+
+/********************/
+/* inline functions */
+/********************/
+
+static inline void *spi_get_adapdata (struct spi_adapter *dev)
+{
+	return dev_get_drvdata (&dev->dev);
+}
+
+static inline void spi_set_adapdata (struct spi_adapter *dev, void *data)
+{
+	dev_set_drvdata (&dev->dev, data);
+}
+
+/**********************/
+/* Exported functions */
+/**********************/
+
+extern int spi_device_register(struct spi_device *);
+extern void spi_device_unregister(struct spi_device *);
+
+extern int spi_driver_register(struct spi_driver *);
+extern int spi_driver_unregister(struct spi_driver *);
+
+extern int spi_add_adapter(struct spi_adapter *);
+extern int spi_del_adapter(struct spi_adapter *);
+
+/* A SPI message is an atomic sequence of read/write operations 
+ * (spi items). struct spi_msg describes a message and contains
+ * a variable number of struct spi_items at its end.
+ */
+struct spi_items 
+{
+	unsigned char flags;	/* mode flags                            */	
+#define SPI_M_RD    0x01	/* Read mode flag                        */
+#define SPI_M_WR    0x02	/* Write mode flag                       */
+#define SPI_M_CSREL 0x04	/* CS release level at end of the frame  */
+#define SPI_M_CS    0x08	/* CS active level at begining of frame  */
+#define SPI_M_CPOL  0x10	/* Clock polarity                        */
+#define SPI_M_CPHA  0x20	/* Clock Phase                           */
+
+	unsigned long len;		/* Message length       */
+	unsigned char *read_buf;	/* read buffer address  */
+	unsigned char *write_buf;	/* write buffer address */
+};
+
+/* An SPI message has one items[] entry but can be extended on allocation for more
+ * items[] and for a private data area after that. This structure resides at the
+ * beginning of the allocated memory block
+ */
+struct spi_msg 
+{
+	struct spi_device  *sdev;		/* information about clock and chipselect number */
+	void               *callback_id;	/* pointer argument to callback function. */
+						/* If this is NULL, block until finished  */
+	void               (*callback)(struct spi_msg * id);	/* pointer to callback function, */
+								/* which can see the message     */	
+	unsigned char      default_flags;
+	void               *work;		/* A pointer to the work structure */
+						/* used to launch this message     */
+	void               *priv;		/* A pointer to the private data   */
+						/* area if used                    */
+	int                n_items;		/* how many elements in the        */
+						/* transfer list                   */     
+	struct spi_items   items[1];		/* an array of transfer items.     */
+						/* Note: Must be last element in   */
+						/* structure as this array spills  */
+						/* into further malloc'd memory    */
+	/* After an arbitrary number of items, an optional */
+	/* private user data area may live here.           */
+};
+
+#define spi_priv(msg) (msg->priv)
+
+
+#endif /* _LINUX_spi_H */

--0-1340143323-1125742421=:20442--
