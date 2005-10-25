Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbVJYDK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbVJYDK3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 23:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbVJYDK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 23:10:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16038 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751418AbVJYDK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 23:10:28 -0400
Date: Mon, 24 Oct 2005 20:10:18 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com, jglauber@redhat.com,
       xenia@us.ibm.com, wein@de.ibm.com
Subject: dev->release = (void (*)(struct device *))kfree;
Message-Id: <20051024201018.153550d6.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to recall the discussion about this, but very dimly. Would someone
be so kind to remind me, why the attached patch cannot be used?

-- Pete

diff -urp -X dontdiff linux-2.6.14-rc5/drivers/s390/char/vmlogrdr.c linux-2.6.14-rc5-lem/drivers/s390/char/vmlogrdr.c
--- linux-2.6.14-rc5/drivers/s390/char/vmlogrdr.c	2005-09-13 01:06:11.000000000 -0700
+++ linux-2.6.14-rc5-lem/drivers/s390/char/vmlogrdr.c	2005-10-24 20:05:26.000000000 -0700
@@ -74,7 +74,7 @@ struct vmlogrdr_priv_t {
 	int buffer_free;
 	int dev_in_use; /* 1: already opened, 0: not opened*/
 	spinlock_t priv_lock;
-	struct device  *device;
+	struct device device;
 	struct class_device  *class_device;
 	int autorecording;
 	int autopurge;
@@ -756,27 +756,14 @@ vmlogrdr_unregister_driver(void) {
 
 static int
 vmlogrdr_register_device(struct vmlogrdr_priv_t *priv) {
-	struct device *dev;
+	struct device *dev = &priv->device;
 	int ret;
 
-	dev = kmalloc(sizeof(struct device), GFP_KERNEL);
-	if (dev) {
-		memset(dev, 0, sizeof(struct device));
-		snprintf(dev->bus_id, BUS_ID_SIZE, "%s",
-			 priv->internal_name);
-		dev->bus = &iucv_bus;
-		dev->parent = iucv_root;
-		dev->driver = &vmlogrdr_driver;
-		/*
-		 * The release function could be called after the
-		 * module has been unloaded. It's _only_ task is to
-		 * free the struct. Therefore, we specify kfree()
-		 * directly here. (Probably a little bit obfuscating
-		 * but legitime ...).
-		 */
-		dev->release = (void (*)(struct device *))kfree;
-	} else
-		return -ENOMEM;
+	memset(dev, 0, sizeof(struct device));
+	snprintf(dev->bus_id, BUS_ID_SIZE, "%s", priv->internal_name);
+	dev->bus = &iucv_bus;
+	dev->parent = iucv_root;
+	dev->driver = &vmlogrdr_driver;
 	ret = device_register(dev);
 	if (ret)
 		return ret;
@@ -799,7 +786,6 @@ vmlogrdr_register_device(struct vmlogrdr
 		return ret;
 	}
 	dev->driver_data = priv;
-	priv->device = dev;
 	return 0;
 }
 
@@ -807,11 +793,8 @@ vmlogrdr_register_device(struct vmlogrdr
 static int
 vmlogrdr_unregister_device(struct vmlogrdr_priv_t *priv ) {
 	class_device_destroy(vmlogrdr_class, MKDEV(vmlogrdr_major, priv->minor_num));
-	if (priv->device != NULL) {
-		sysfs_remove_group(&priv->device->kobj, &vmlogrdr_attr_group);
-		device_unregister(priv->device);
-		priv->device=NULL;
-	}
+	sysfs_remove_group(&priv->device.kobj, &vmlogrdr_attr_group);
+	device_unregister(&priv->device);
 	return 0;
 }
 
