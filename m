Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162296AbWLAXYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162296AbWLAXYK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162257AbWLAXXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:23:53 -0500
Received: from ns.suse.de ([195.135.220.2]:21133 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162237AbWLAXXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:23:04 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 15/36] I2C: convert i2c-dev to use struct device instead of struct class_device
Date: Fri,  1 Dec 2006 15:21:45 -0800
Message-Id: <11650153733277-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650153704007-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

As class_device is going away eventually...

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/i2c/i2c-dev.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 3f86903..94a4e9a 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -42,7 +42,7 @@ static struct i2c_driver i2cdev_driver;
 struct i2c_dev {
 	struct list_head list;
 	struct i2c_adapter *adap;
-	struct class_device *class_dev;
+	struct device *dev;
 };
 
 #define I2C_MINORS	256
@@ -92,15 +92,16 @@ static void return_i2c_dev(struct i2c_de
 	spin_unlock(&i2c_dev_list_lock);
 }
 
-static ssize_t show_adapter_name(struct class_device *class_dev, char *buf)
+static ssize_t show_adapter_name(struct device *dev,
+				 struct device_attribute *attr, char *buf)
 {
-	struct i2c_dev *i2c_dev = i2c_dev_get_by_minor(MINOR(class_dev->devt));
+	struct i2c_dev *i2c_dev = i2c_dev_get_by_minor(MINOR(dev->devt));
 
 	if (!i2c_dev)
 		return -ENODEV;
 	return sprintf(buf, "%s\n", i2c_dev->adap->name);
 }
-static CLASS_DEVICE_ATTR(name, S_IRUGO, show_adapter_name, NULL);
+static DEVICE_ATTR(name, S_IRUGO, show_adapter_name, NULL);
 
 static ssize_t i2cdev_read (struct file *file, char __user *buf, size_t count,
                             loff_t *offset)
@@ -413,15 +414,14 @@ static int i2cdev_attach_adapter(struct
 		return PTR_ERR(i2c_dev);
 
 	/* register this i2c device with the driver core */
-	i2c_dev->class_dev = class_device_create(i2c_dev_class, NULL,
-						 MKDEV(I2C_MAJOR, adap->nr),
-						 &adap->dev, "i2c-%d",
-						 adap->nr);
-	if (!i2c_dev->class_dev) {
+	i2c_dev->dev = device_create(i2c_dev_class, &adap->dev,
+				     MKDEV(I2C_MAJOR, adap->nr),
+				     "i2c-%d", adap->nr);
+	if (!i2c_dev->dev) {
 		res = -ENODEV;
 		goto error;
 	}
-	res = class_device_create_file(i2c_dev->class_dev, &class_device_attr_name);
+	res = device_create_file(i2c_dev->dev, &dev_attr_name);
 	if (res)
 		goto error_destroy;
 
@@ -429,7 +429,7 @@ static int i2cdev_attach_adapter(struct
 		 adap->name, adap->nr);
 	return 0;
 error_destroy:
-	class_device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
+	device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
 error:
 	return_i2c_dev(i2c_dev);
 	kfree(i2c_dev);
@@ -444,9 +444,9 @@ static int i2cdev_detach_adapter(struct
 	if (!i2c_dev) /* attach_adapter must have failed */
 		return 0;
 
-	class_device_remove_file(i2c_dev->class_dev, &class_device_attr_name);
+	device_remove_file(i2c_dev->dev, &dev_attr_name);
 	return_i2c_dev(i2c_dev);
-	class_device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
+	device_destroy(i2c_dev_class, MKDEV(I2C_MAJOR, adap->nr));
 	kfree(i2c_dev);
 
 	pr_debug("i2c-dev: adapter [%s] unregistered\n", adap->name);
-- 
1.4.4.1

