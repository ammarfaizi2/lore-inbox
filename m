Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTJJXVj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 19:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbTJJXUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 19:20:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:27874 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263184AbTJJXTz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 19:19:55 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10658274962859@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test7
In-Reply-To: <10658274951920@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 10 Oct 2003 16:11:36 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1337.1.4, 2003/10/10 14:59:18-07:00, greg@kroah.com

[PATCH] I2C: fix i2c-dev class release function bug.

There was no release function, that was the bug :)
It caused bad messages to show up in the syslog whenever a i2c driver was removed, and could
easily oops.


 drivers/i2c/i2c-dev.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Fri Oct 10 16:00:34 2003
+++ b/drivers/i2c/i2c-dev.c	Fri Oct 10 16:00:34 2003
@@ -49,6 +49,7 @@
 	int minor;
 	struct i2c_adapter *adap;
 	struct class_device class_dev;
+	struct completion released;	/* FIXME, we need a class_device_unregister() */
 };
 #define to_i2c_dev(d) container_of(d, struct i2c_dev, class_dev)
 
@@ -112,7 +113,6 @@
 	spin_lock(&i2c_dev_array_lock);
 	i2c_dev_array[i2c_dev->minor] = NULL;
 	spin_unlock(&i2c_dev_array_lock);
-	kfree(i2c_dev);
 }
 
 static ssize_t show_dev(struct class_device *class_dev, char *buf)
@@ -421,8 +421,15 @@
 	.release	= i2cdev_release,
 };
 
+static void release_i2c_dev(struct class_device *dev)
+{
+	struct i2c_dev *i2c_dev = to_i2c_dev(dev);
+	complete(&i2c_dev->released);
+}
+
 static struct class i2c_dev_class = {
-	.name	= "i2c-dev",
+	.name		= "i2c-dev",
+	.release	= &release_i2c_dev,
 };
 
 static int i2cdev_attach_adapter(struct i2c_adapter *adap)
@@ -453,6 +460,7 @@
 	return 0;
 error:
 	return_i2c_dev(i2c_dev);
+	kfree(i2c_dev);
 	return retval;
 }
 
@@ -464,9 +472,12 @@
 	if (!i2c_dev)
 		return -ENODEV;
 
-	class_device_unregister(&i2c_dev->class_dev);
+	init_completion(&i2c_dev->released);
 	devfs_remove("i2c/%d", i2c_dev->minor);
 	return_i2c_dev(i2c_dev);
+	class_device_unregister(&i2c_dev->class_dev);
+	wait_for_completion(&i2c_dev->released);
+	kfree(i2c_dev);
 
 	dev_dbg(&adap->dev, "Adapter unregistered\n");
 	return 0;

