Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265684AbUFIHcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265684AbUFIHcO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 03:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265678AbUFIHcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 03:32:14 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:2409 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265689AbUFIHZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 03:25:55 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Add platform_device_simple_release
Date: Wed, 9 Jun 2004 02:25:33 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>
References: <200406090221.24739.dtor_core@ameritech.net> <200406090222.45805.dtor_core@ameritech.net> <200406090224.04876.dtor_core@ameritech.net>
In-Reply-To: <200406090224.04876.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406090225.35891.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1837, 2004-06-09 01:36:36-05:00, dtor_core@ameritech.net
  sysfs: add platform_device_simple_release that just frees memory
         occupied by platform device. The function can be used by
         simple platform devices, when all resources except for memory
         can be deallocated beforehand. By having final release function
         in the driver core module can be unloaded without waiting for
         the last reference to the device to be dropped.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/base/platform.c |   21 +++++++++++++++++++++
 include/linux/device.h  |    1 +
 2 files changed, 22 insertions(+)


===================================================================



diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	2004-06-09 01:40:26 -05:00
+++ b/drivers/base/platform.c	2004-06-09 01:40:26 -05:00
@@ -43,12 +43,32 @@
 	return device_register(&pdev->dev);
 }
 
+/**
+ *	platform_device_unregister - remove a platform-level device
+ *	@dev:	platform device we're removing
+ *
+ */
 void platform_device_unregister(struct platform_device * pdev)
 {
 	if (pdev)
 		device_unregister(&pdev->dev);
 }
 
+/**
+ *	platform_device_simple_release - free a platform-level device
+ *	@dev:	platform device we're freeing
+ *
+ *	This canned release function can be used for simple platform
+ *	devices. By having the function outside of driver module it
+ *	can be unloaded without waiting for the device to be released
+ *	(provided that the device has been dynamically allocated).
+ */
+void platform_device_simple_release(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	kfree(pdev);
+}
 
 /**
  *	platform_match - bind platform device to platform driver.
@@ -117,3 +137,4 @@
 EXPORT_SYMBOL(platform_bus_type);
 EXPORT_SYMBOL(platform_device_register);
 EXPORT_SYMBOL(platform_device_unregister);
+EXPORT_SYMBOL(platform_device_simple_release);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2004-06-09 01:40:26 -05:00
+++ b/include/linux/device.h	2004-06-09 01:40:26 -05:00
@@ -386,6 +386,7 @@
 
 extern int platform_device_register(struct platform_device *);
 extern void platform_device_unregister(struct platform_device *);
+extern void platform_device_simple_release(struct device *);
 
 extern struct bus_type platform_bus_type;
 extern struct device platform_bus;
