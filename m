Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbVLJGtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbVLJGtE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 01:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVLJGsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 01:48:42 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:927 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964941AbVLJGsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 01:48:40 -0500
Message-Id: <20051210064750.775640000.dtor_core@ameritech.net>
References: <20051210063626.817047000.dtor_core@ameritech.net>
Date: Sat, 10 Dec 2005 01:36:27 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Jean Delvare <khali@linux-fr.org>
Subject: [patch 1/2] Add platform_device_del()
Content-Disposition: inline; filename=platform-device-del.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Driver core: add platform_device_del function

Having platform_device_del90 allows more straightforward error
handling code in drivers registering platform devices.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/base/platform.c         |   45 ++++++++++++++++++++++++++--------------
 include/linux/platform_device.h |    1 
 2 files changed, 31 insertions(+), 15 deletions(-)

Index: work/drivers/base/platform.c
===================================================================
--- work.orig/drivers/base/platform.c
+++ work/drivers/base/platform.c
@@ -168,7 +168,7 @@ struct platform_device *platform_device_
 		pa->pdev.dev.release = platform_device_release;
 	}
 
-	return pa ? &pa->pdev : NULL;	
+	return pa ? &pa->pdev : NULL;
 }
 EXPORT_SYMBOL_GPL(platform_device_alloc);
 
@@ -282,24 +282,13 @@ int platform_device_add(struct platform_
 EXPORT_SYMBOL_GPL(platform_device_add);
 
 /**
- *	platform_device_register - add a platform-level device
- *	@pdev:	platform device we're adding
- *
- */
-int platform_device_register(struct platform_device * pdev)
-{
-	device_initialize(&pdev->dev);
-	return platform_device_add(pdev);
-}
-
-/**
- *	platform_device_unregister - remove a platform-level device
+ *	platform_device_del - remove a platform-level device
  *	@pdev:	platform device we're removing
  *
  *	Note that this function will also release all memory- and port-based
  *	resources owned by the device (@dev->resource).
  */
-void platform_device_unregister(struct platform_device * pdev)
+void platform_device_del(struct platform_device *pdev)
 {
 	int i;
 
@@ -310,9 +299,35 @@ void platform_device_unregister(struct p
 				release_resource(r);
 		}
 
-		device_unregister(&pdev->dev);
+		device_del(&pdev->dev);
 	}
 }
+EXPORT_SYMBOL_GPL(platform_device_del);
+
+/**
+ *	platform_device_register - add a platform-level device
+ *	@pdev:	platform device we're adding
+ *
+ */
+int platform_device_register(struct platform_device * pdev)
+{
+	device_initialize(&pdev->dev);
+	return platform_device_add(pdev);
+}
+
+/**
+ *	platform_device_unregister - unregister a platform-level device
+ *	@pdev:	platform device we're unregistering
+ *
+ *	Unregistration is done in 2 steps. Fisrt we release all resources
+ *	and remove it from the sybsystem, then we drop reference count by
+ *	calling platform_device_put().
+ */
+void platform_device_unregister(struct platform_device * pdev)
+{
+	platform_device_del(pdev);
+	platform_device_put(pdev);
+}
 
 /**
  *	platform_device_register_simple
Index: work/include/linux/platform_device.h
===================================================================
--- work.orig/include/linux/platform_device.h
+++ work/include/linux/platform_device.h
@@ -41,6 +41,7 @@ extern struct platform_device *platform_
 extern int platform_device_add_resources(struct platform_device *pdev, struct resource *res, unsigned int num);
 extern int platform_device_add_data(struct platform_device *pdev, void *data, size_t size);
 extern int platform_device_add(struct platform_device *pdev);
+extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);
 
 struct platform_driver {

