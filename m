Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270739AbTHOSqy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270730AbTHOSeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:34:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:57220 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270763AbTHOSdO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:33:14 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10609724091170@kroah.com>
Subject: Re: [PATCH] i2c driver changes 2.6.0-test3
In-Reply-To: <10609724081893@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 15 Aug 2003 11:33:29 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1123.18.8, 2003/08/15 11:06:52-07:00, greg@kroah.com

I2C: add adapter and client name files as the driver core no longer provides them.


 drivers/i2c/i2c-core.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Fri Aug 15 11:26:44 2003
+++ b/drivers/i2c/i2c-core.c	Fri Aug 15 11:26:44 2003
@@ -79,12 +79,36 @@
 	.release =	&i2c_adapter_class_dev_release,
 };
 
+static ssize_t show_adapter_name(struct device *dev, char *buf)
+{
+	struct i2c_adapter *adap = dev_to_i2c_adapter(dev);
+	return sprintf(buf, "%s\n", adap->name);
+}
+static DEVICE_ATTR(name, S_IRUGO, show_adapter_name, NULL);
+
+
 static void i2c_client_release(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	complete(&client->released);
 }
 
+static ssize_t show_client_name(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	return sprintf(buf, "%s\n", client->name);
+}
+
+/* 
+ * We can't use the DEVICE_ATTR() macro here as we want the same filename for a
+ * different type of a device.  So beware if the DEVICE_ATTR() macro ever
+ * changes, this definition will also have to change.
+ */
+static struct device_attribute dev_attr_client_name = {
+	.attr	= {.name = "name", .mode = S_IRUGO, .owner = THIS_MODULE },
+	.show	= &show_client_name,
+};
+
 
 /* ---------------------------------------------------
  * registering functions 
@@ -120,6 +144,7 @@
 	adap->dev.driver = &i2c_adapter_driver;
 	adap->dev.release = &i2c_adapter_dev_release;
 	device_register(&adap->dev);
+	device_create_file(&adap->dev, &dev_attr_name);
 
 	/* Add this adapter to the i2c_adapter class */
 	memset(&adap->class_dev, 0x00, sizeof(struct class_device));
@@ -184,6 +209,7 @@
 	init_completion(&adap->dev_released);
 	init_completion(&adap->class_dev_released);
 	class_device_unregister(&adap->class_dev);
+	device_remove_file(&adap->dev, &dev_attr_name);
 	device_unregister(&adap->dev);
 	list_del(&adap->list);
 
@@ -361,6 +387,7 @@
 		"%d-%04x", i2c_adapter_id(adapter), client->addr);
 	printk("registering %s\n", client->dev.bus_id);
 	device_register(&client->dev);
+	device_create_file(&client->dev, &dev_attr_client_name);
 	
 	return 0;
 }
@@ -387,6 +414,7 @@
 	down(&adapter->clist_lock);
 	list_del(&client->list);
 	init_completion(&client->released);
+	device_remove_file(&client->dev, &dev_attr_client_name);
 	device_unregister(&client->dev);
 	up(&adapter->clist_lock);
 	wait_for_completion(&client->released);

