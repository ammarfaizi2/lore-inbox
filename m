Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVAHIGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVAHIGt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVAHIFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:05:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:22149 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261813AbVAHFsA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:00 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632624000@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:42 -0800
Message-Id: <1105163262985@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.444.28, 2004/12/21 16:51:39-08:00, jbarnes@engr.sgi.com

[PATCH] driver core: allow struct bin_attributes in class devices

This small patch adds routines to create and remove bin_attribute files
for class devices.  One intended use is for binary files corresponding to
PCI busses, like bus legacy I/O ports or ISA memory.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>


 drivers/base/class.c   |   18 ++++++++++++++++++
 include/linux/device.h |    5 ++++-
 2 files changed, 22 insertions(+), 1 deletion(-)


diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	2005-01-07 15:40:31 -08:00
+++ b/drivers/base/class.c	2005-01-07 15:40:31 -08:00
@@ -179,6 +179,22 @@
 		sysfs_remove_file(&class_dev->kobj, &attr->attr);
 }
 
+int class_device_create_bin_file(struct class_device *class_dev,
+				 struct bin_attribute *attr)
+{
+	int error = -EINVAL;
+	if (class_dev)
+		error = sysfs_create_bin_file(&class_dev->kobj, attr);
+	return error;
+}
+
+void class_device_remove_bin_file(struct class_device *class_dev,
+				  struct bin_attribute *attr)
+{
+	if (class_dev)
+		sysfs_remove_bin_file(&class_dev->kobj, attr);
+}
+
 static int class_device_dev_link(struct class_device * class_dev)
 {
 	if (class_dev->dev)
@@ -576,6 +592,8 @@
 EXPORT_SYMBOL_GPL(class_device_put);
 EXPORT_SYMBOL_GPL(class_device_create_file);
 EXPORT_SYMBOL_GPL(class_device_remove_file);
+EXPORT_SYMBOL_GPL(class_device_create_bin_file);
+EXPORT_SYMBOL_GPL(class_device_remove_bin_file);
 
 EXPORT_SYMBOL_GPL(class_interface_register);
 EXPORT_SYMBOL_GPL(class_interface_unregister);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	2005-01-07 15:40:31 -08:00
+++ b/include/linux/device.h	2005-01-07 15:40:31 -08:00
@@ -228,7 +228,10 @@
 				    const struct class_device_attribute *);
 extern void class_device_remove_file(struct class_device *, 
 				     const struct class_device_attribute *);
-
+extern int class_device_create_bin_file(struct class_device *,
+					struct bin_attribute *);
+extern void class_device_remove_bin_file(struct class_device *,
+					 struct bin_attribute *);
 
 struct class_interface {
 	struct list_head	node;

