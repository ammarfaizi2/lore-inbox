Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWAEAvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWAEAvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWAEAux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:53 -0500
Received: from mail.kroah.org ([69.55.234.183]:60089 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750962AbWAEAtv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:51 -0500
Cc: dtor_core@ameritech.net
Subject: [PATCH] Driver Core: Add platform_device_del()
In-Reply-To: <1136422171299@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:31 -0800
Message-Id: <11364221711332@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver Core: Add platform_device_del()

Driver core: add platform_device_del function

Having platform_device_del90 allows more straightforward error
handling code in drivers registering platform devices.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 93ce3061be212f6280e7ccafa9a7f698a95c6d75
tree a451566360fea86ef597fcd2fe693dce65626f93
parent e39b84337b8aed3044683a57741a19e5002225b9
author Dmitry Torokhov <dtor_core@ameritech.net> Sat, 10 Dec 2005 01:36:27 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:09 -0800

 drivers/base/platform.c         |   45 ++++++++++++++++++++++++++-------------
 include/linux/platform_device.h |    1 +
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1091af1..95ecfc4 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
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
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 17e336f..782090c 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -41,6 +41,7 @@ extern struct platform_device *platform_
 extern int platform_device_add_resources(struct platform_device *pdev, struct resource *res, unsigned int num);
 extern int platform_device_add_data(struct platform_device *pdev, void *data, size_t size);
 extern int platform_device_add(struct platform_device *pdev);
+extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);
 
 struct platform_driver {

