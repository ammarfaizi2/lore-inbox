Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272164AbTHIAfj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272219AbTHIAdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:33:42 -0400
Received: from mail.kroah.org ([65.200.24.183]:60351 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272163AbTHIAcZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:32:25 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <106038693850@kroah.com>
Subject: Re: [PATCH] More i2c driver changes 2.6.0-test2
In-Reply-To: <10603869373490@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 8 Aug 2003 16:55:38 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1125, 2003/08/08 16:24:32-07:00, greg@kroah.com

I2C: fix up driver model programming error.

There was no release function for the objects.
bad greg, no biscuit...


 drivers/i2c/i2c-core.c |   31 ++++++++++++++++++++++++++++++-
 include/linux/i2c.h    |    6 +++++-
 2 files changed, 35 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Fri Aug  8 16:47:25 2003
+++ b/drivers/i2c/i2c-core.c	Fri Aug  8 16:47:25 2003
@@ -55,6 +55,12 @@
 	return 0;
 }
 
+static void i2c_adapter_dev_release(struct device *dev)
+{
+	struct i2c_adapter *adap = dev_to_i2c_adapter(dev);
+	complete(&adap->dev_released);
+}
+
 static struct device_driver i2c_adapter_driver = {
 	.name =	"i2c_adapter",
 	.bus = &i2c_bus_type,
@@ -62,10 +68,23 @@
 	.remove = i2c_device_remove,
 };
 
+static void i2c_adapter_class_dev_release(struct class_device *dev)
+{
+	struct i2c_adapter *adap = class_dev_to_i2c_adapter(dev);
+	complete(&adap->class_dev_released);
+}
+
 static struct class i2c_adapter_class = {
-	.name =		"i2c-adapter"
+	.name =		"i2c-adapter",
+	.release =	&i2c_adapter_class_dev_release,
 };
 
+static void i2c_client_release(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	complete(&client->released);
+}
+
 
 /* ---------------------------------------------------
  * registering functions 
@@ -99,6 +118,7 @@
 		adap->dev.parent = &legacy_bus;
 	sprintf(adap->dev.bus_id, "i2c-%d", adap->nr);
 	adap->dev.driver = &i2c_adapter_driver;
+	adap->dev.release = &i2c_adapter_dev_release;
 	device_register(&adap->dev);
 
 	/* Add this adapter to the i2c_adapter class */
@@ -161,10 +181,16 @@
 	}
 
 	/* clean up the sysfs representation */
+	init_completion(&adap->dev_released);
+	init_completion(&adap->class_dev_released);
 	class_device_unregister(&adap->class_dev);
 	device_unregister(&adap->dev);
 	list_del(&adap->list);
 
+	/* wait for sysfs to drop all references */
+	wait_for_completion(&adap->dev_released);
+	wait_for_completion(&adap->class_dev_released);
+
 	DEB(dev_dbg(&adap->dev, "adapter unregistered\n"));
 
  out_unlock:
@@ -329,6 +355,7 @@
 	client->dev.parent = &client->adapter->dev;
 	client->dev.driver = &client->driver->driver;
 	client->dev.bus = &i2c_bus_type;
+	client->dev.release = &i2c_client_release;
 	
 	snprintf(&client->dev.bus_id[0], sizeof(client->dev.bus_id),
 		"%d-%04x", i2c_adapter_id(adapter), client->addr);
@@ -359,8 +386,10 @@
 
 	down(&adapter->clist_lock);
 	list_del(&client->list);
+	init_completion(&client->released);
 	device_unregister(&client->dev);
 	up(&adapter->clist_lock);
+	wait_for_completion(&client->released);
 
  out:
 	return res;
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Fri Aug  8 16:47:25 2003
+++ b/include/linux/i2c.h	Fri Aug  8 16:47:25 2003
@@ -167,6 +167,7 @@
 	struct device dev;		/* the device structure		*/
 	struct list_head list;
 	char name[DEVICE_NAME_SIZE];
+	struct completion released;
 };
 #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
 
@@ -253,8 +254,11 @@
 	struct list_head clients;
 	struct list_head list;
 	char name[DEVICE_NAME_SIZE];
+	struct completion dev_released;
+	struct completion class_dev_released;
 };
-#define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
+#define dev_to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
+#define class_dev_to_i2c_adapter(d) container_of(d, struct i2c_adapter, class_dev)
 
 static inline void *i2c_get_adapdata (struct i2c_adapter *dev)
 {

