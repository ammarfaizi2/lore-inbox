Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbVILWKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVILWKm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 18:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbVILWKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 18:10:42 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:15755 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S932289AbVILWKl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 18:10:41 -0400
From: Lion Vollnhals <lion.vollnhals@web.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] use kzalloc instead of malloc+memset
Date: Tue, 13 Sep 2005 00:10:38 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509130010.38483.lion.vollnhals@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.13-mm3 replaces malloc and memset with kzalloc in drivers/base/class.c .
Furthermore this patch fixes actually two bugs:
  The memset arguments were occasionally swaped and therefore wrong.

Usage of kzalloc makes this code shorter and more bugfree.

Please apply.

Signed-off-by: Lion Vollnhals <webmaster@schiggl.de>

--- 2.6.13-mm3/drivers/base/class.c	2005-09-12 23:42:47.000000000 +0200
+++ 2.6.13-mm3-changed/drivers/base/class.c	2005-09-12 23:54:56.000000000 +0200
@@ -190,12 +190,11 @@ struct class *class_create(struct module
 	struct class *cls;
 	int retval;
 
-	cls = kmalloc(sizeof(struct class), GFP_KERNEL);
+	cls = kzalloc(sizeof(struct class), GFP_KERNEL);
 	if (!cls) {
 		retval = -ENOMEM;
 		goto error;
 	}
-	memset(cls, 0x00, sizeof(struct class));
 
 	cls->name = name;
 	cls->owner = owner;
@@ -519,13 +518,13 @@ int class_device_add(struct class_device
 	/* add the needed attributes to this device */
 	if (MAJOR(class_dev->devt)) {
 		struct class_device_attribute *attr;
-		attr = kmalloc(sizeof(*attr), GFP_KERNEL);
+		attr = kzalloc(sizeof(*attr), GFP_KERNEL);
 		if (!attr) {
 			error = -ENOMEM;
 			kobject_del(&class_dev->kobj);
 			goto register_done;
 		}
-		memset(attr, sizeof(*attr), 0x00);
+		
 		attr->attr.name = "dev";
 		attr->attr.mode = S_IRUGO;
 		attr->attr.owner = parent->owner;
@@ -534,13 +533,13 @@ int class_device_add(struct class_device
 		class_device_create_file(class_dev, attr);
 		class_dev->devt_attr = attr;
 
-		attr = kmalloc(sizeof(*attr), GFP_KERNEL);
+		attr = kzalloc(sizeof(*attr), GFP_KERNEL);
 		if (!attr) {
 			error = -ENOMEM;
 			kobject_del(&class_dev->kobj);
 			goto register_done;
 		}
-		memset(attr, sizeof(*attr), 0x00);
+		
 		attr->attr.name = "sample.sh";
 		attr->attr.mode = S_IRUSR | S_IXUSR | S_IRUGO;
 		attr->attr.owner = parent->owner;
@@ -611,12 +610,11 @@ struct class_device *class_device_create
 	if (cls == NULL || IS_ERR(cls))
 		goto error;
 
-	class_dev = kmalloc(sizeof(struct class_device), GFP_KERNEL);
+	class_dev = kzalloc(sizeof(struct class_device), GFP_KERNEL);
 	if (!class_dev) {
 		retval = -ENOMEM;
 		goto error;
 	}
-	memset(class_dev, 0x00, sizeof(struct class_device));
 
 	class_dev->devt = devt;
 	class_dev->dev = device;
