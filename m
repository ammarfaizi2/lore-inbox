Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262689AbTCTW0B>; Thu, 20 Mar 2003 17:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262711AbTCTWZg>; Thu, 20 Mar 2003 17:25:36 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:45317 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262689AbTCTWVq>;
	Thu, 20 Mar 2003 17:21:46 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.65
In-reply-to: <10481995753053@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 20 Mar 2003 14:32 -0800
Message-id: <10481995763208@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1143.1.16, 2003/03/20 12:07:55-08:00, greg@kroah.com

i2c: add initial driver model support for i2c drivers.


 drivers/i2c/i2c-core.c |   22 ++++++++++++++++++++++
 include/linux/i2c.h    |    3 +++
 2 files changed, 25 insertions(+)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Thu Mar 20 12:52:43 2003
+++ b/drivers/i2c/i2c-core.c	Thu Mar 20 12:52:43 2003
@@ -53,6 +53,16 @@
 #endif /* CONFIG_PROC_FS */
 
 
+int i2c_device_probe(struct device *dev)
+{
+	return -ENODEV;
+}
+
+int i2c_device_remove(struct device *dev)
+{
+	return 0;
+}
+
 /* ---------------------------------------------------
  * registering functions 
  * --------------------------------------------------- 
@@ -204,6 +214,16 @@
 	drivers[i] = driver;
 	
 	DEB(printk(KERN_DEBUG "i2c-core.o: driver %s registered.\n",driver->name));
+
+	/* add the driver to the list of i2c drivers in the driver core */
+	driver->driver.name = driver->name;
+	driver->driver.bus = &i2c_bus_type;
+	driver->driver.probe = i2c_device_probe;
+	driver->driver.remove = i2c_device_remove;
+
+	res = driver_register(&driver->driver);
+	if (res)
+		goto out_unlock;
 	
 	/* now look for instances of driver on our adapters
 	 */
@@ -235,6 +255,8 @@
 		res = -ENODEV;
 		goto out_unlock;
 	}
+
+	driver_unregister(&driver->driver);
 
 	/* Have a look at each adapter, if clients of this driver are still
 	 * attached. If so, detach them to be able to kill the driver 
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Thu Mar 20 12:52:43 2003
+++ b/include/linux/i2c.h	Thu Mar 20 12:52:43 2003
@@ -143,7 +143,10 @@
 	 * with the device.
 	 */
 	int (*command)(struct i2c_client *client,unsigned int cmd, void *arg);
+
+	struct device_driver driver;
 };
+#define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
 
 extern struct bus_type i2c_bus_type;
 

