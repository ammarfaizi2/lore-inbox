Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265445AbUBIXeb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265369AbUBIXcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:32:22 -0500
Received: from mail.kroah.org ([65.200.24.183]:25279 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265494AbUBIX24 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:28:56 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.3-rc1
In-Reply-To: <10763691411688@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:25:41 -0800
Message-Id: <10763691411179@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.19.3, 2004/02/04 13:48:53-08:00, greg@kroah.com

[PATCH] Driver core: remove device_unregister_wait() as it's a very bad idea.


 drivers/base/core.c    |   23 -----------------------
 include/linux/device.h |    2 --
 2 files changed, 25 deletions(-)


diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Mon Feb  9 15:09:04 2004
+++ b/drivers/base/core.c	Mon Feb  9 15:09:04 2004
@@ -76,7 +76,6 @@
 static void device_release(struct kobject * kobj)
 {
 	struct device * dev = to_dev(kobj);
-	struct completion * c = dev->complete;
 
 	if (dev->release)
 		dev->release(dev);
@@ -86,8 +85,6 @@
 			dev->bus_id);
 		WARN_ON(1);
 	}
-	if (c)
-		complete(c);
 }
 
 static struct kobj_type ktype_device = {
@@ -355,25 +352,6 @@
 
 
 /**
- *	device_unregister_wait - Unregister device and wait for it to be freed.
- *	@dev: Device to unregister.
- *
- *	For the cases where the caller needs to wait for all references to
- *	be dropped from the device before continuing (e.g. modules with
- *	statically allocated devices), this function uses a completion struct
- *	to wait, along with a matching complete() in device_release() above.
- */
-
-void device_unregister_wait(struct device * dev)
-{
-	struct completion c;
-	init_completion(&c);
-	dev->complete = &c;
-	device_unregister(dev);
-	wait_for_completion(&c);
-}
-
-/**
  *	device_for_each_child - device child iterator.
  *	@dev:	parent struct device.
  *	@data:	data for the callback.
@@ -421,7 +399,6 @@
 
 EXPORT_SYMBOL(device_del);
 EXPORT_SYMBOL(device_unregister);
-EXPORT_SYMBOL(device_unregister_wait);
 EXPORT_SYMBOL(get_device);
 EXPORT_SYMBOL(put_device);
 EXPORT_SYMBOL(device_find);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Mon Feb  9 15:09:04 2004
+++ b/include/linux/device.h	Mon Feb  9 15:09:04 2004
@@ -265,7 +265,6 @@
 	struct list_head children;
 	struct device 	* parent;
 
-	struct completion * complete;	/* Notification for freeing device. */
 	struct kobject kobj;
 	char	bus_id[BUS_ID_SIZE];	/* position on parent bus */
 
@@ -313,7 +312,6 @@
  */
 extern int device_register(struct device * dev);
 extern void device_unregister(struct device * dev);
-extern void device_unregister_wait(struct device * dev);
 extern void device_initialize(struct device * dev);
 extern int device_add(struct device * dev);
 extern void device_del(struct device * dev);

