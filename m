Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266223AbUFJGtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266223AbUFJGtz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 02:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266212AbUFJGrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 02:47:46 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:26028 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266208AbUFJGqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 02:46:52 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 2/3] Add platform_device_register_simple
Date: Thu, 10 Jun 2004 01:43:51 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200406090221.24739.dtor_core@ameritech.net> <200406100140.30621.dtor_core@ameritech.net> <200406100142.14861.dtor_core@ameritech.net>
In-Reply-To: <200406100142.14861.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406100143.53381.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1767, 2004-06-09 23:58:52-05:00, dtor_core@ameritech.net
  sysfs: add platform_device_register_simple() that creates a simple
         platform device that does not manage any resources. Modules
         using such platform devices can be unloaded without waiting
         for the device to me released (but any additional resources
         allocated by module should be freed beforehand).
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/base/platform.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h  |    1 
 2 files changed, 52 insertions(+)


===================================================================



diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	2004-06-10 01:34:04 -05:00
+++ b/drivers/base/platform.c	2004-06-10 01:34:04 -05:00
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/err.h>
 
 struct device platform_bus = {
 	.bus_id		= "platform",
@@ -43,10 +44,60 @@
 	return device_register(&pdev->dev);
 }
 
+
+/**
+ *	platform_device_unregister - remove a platform-level device
+ *	@dev:	platform device we're removing
+ *
+ */
 void platform_device_unregister(struct platform_device * pdev)
 {
 	if (pdev)
 		device_unregister(&pdev->dev);
+}
+
+
+static void platform_device_release_simple(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	kfree(pdev);
+}
+
+/**
+ *	platform_device_register_simple
+ *	@name:	base name of the device we're adding
+ *	@id:	instance id
+ *
+ *	This function creates a simple platform device that does not
+ *	manage any resources. By having release function in the driver
+ *	core modules that are using such devices can be unloaded without
+ *	waiting for the last reference to the device to be dropped.
+ */
+struct platform_device *platform_device_register_simple(char *name, unsigned int id)
+{
+	struct platform_device *pdev;
+	int retval;
+
+	pdev = kmalloc(sizeof(*pdev), GFP_KERNEL);
+	if (!pdev) {
+		retval = -ENOMEM;
+		goto error;
+	}
+
+	memset(pdev, 0, sizeof(*pdev));
+	pdev->name = name;
+	pdev->id = id;
+	pdev->dev.release = platform_device_release_simple;
+
+	retval = platform_device_register(pdev);
+	if (retval)
+		goto error;
+
+	return pdev;
+
+error:
+	kfree(pdev);
+	return ERR_PTR(retval);
 }
 
 
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-06-10 01:34:04 -05:00
+++ b/include/linux/device.h	2004-06-10 01:34:04 -05:00
@@ -386,6 +386,7 @@
 
 extern int platform_device_register(struct platform_device *);
 extern void platform_device_unregister(struct platform_device *);
+extern struct platform_device *platform_device_register_simple(char *, unsigned int);
 
 extern struct bus_type platform_bus_type;
 extern struct device platform_bus;
