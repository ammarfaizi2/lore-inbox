Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbTESW7z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbTESW7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:59:23 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:17910 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263310AbTESW5k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:57:40 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10533859483351@kroah.com>
Subject: Re: [PATCH] Yet more i2c driver changes for 2.5.69
In-Reply-To: <1053385947386@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 May 2003 16:12:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1093.2.4, 2003/05/19 15:32:55-07:00, greg@kroah.com

i2c: fix up i2c-dev driver based on previous core changes.

This fixes the problem that adapter id's are not the minor number for the
i2c-dev devices anymore.  Also adds a i2c-dev class to let userspace know
which i2c-dev device is bound to which i2c adapter.


 drivers/i2c/i2c-dev.c |  228 +++++++++++++++++++++++++++++++++++---------------
 1 files changed, 160 insertions(+), 68 deletions(-)


diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Mon May 19 15:58:41 2003
+++ b/drivers/i2c/i2c-dev.c	Mon May 19 15:58:41 2003
@@ -3,6 +3,7 @@
 
     Copyright (C) 1995-97 Simon G. Vogl
     Copyright (C) 1998-99 Frodo Looijaard <frodol@dds.nl>
+    Copyright (C) 2003 Greg Kroah-Hartman <greg@kroah.com>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -28,8 +29,6 @@
 /* The devfs code is contributed by Philipp Matthias Hahn 
    <pmhahn@titan.lahn.de> */
 
-/* $Id: i2c-dev.c,v 1.53 2003/01/21 08:08:16 kmalkki Exp $ */
-
 /* If you want debugging uncomment: */
 /* #define DEBUG 1 */
 
@@ -44,54 +43,84 @@
 #include <linux/i2c-dev.h>
 #include <asm/uaccess.h>
 
-/* struct file_operations changed too often in the 2.1 series for nice code */
-
-static ssize_t i2cdev_read (struct file *file, char *buf, size_t count, 
-                            loff_t *offset);
-static ssize_t i2cdev_write (struct file *file, const char *buf, size_t count, 
-                             loff_t *offset);
-
-static int i2cdev_ioctl (struct inode *inode, struct file *file, 
-                         unsigned int cmd, unsigned long arg);
-static int i2cdev_open (struct inode *inode, struct file *file);
-
-static int i2cdev_release (struct inode *inode, struct file *file);
-
-static int i2cdev_attach_adapter(struct i2c_adapter *adap);
-static int i2cdev_detach_adapter(struct i2c_adapter *adap);
-static int i2cdev_detach_client(struct i2c_client *client);
-static int i2cdev_command(struct i2c_client *client, unsigned int cmd,
-                           void *arg);
+static struct i2c_client i2cdev_client_template;
 
-static struct file_operations i2cdev_fops = {
-	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
-	.read		= i2cdev_read,
-	.write		= i2cdev_write,
-	.ioctl		= i2cdev_ioctl,
-	.open		= i2cdev_open,
-	.release	= i2cdev_release,
+struct i2c_dev {
+	int minor;
+	struct i2c_adapter *adap;
+	struct class_device class_dev;
 };
+#define to_i2c_dev(d) container_of(d, struct i2c_dev, class_dev)
 
-static struct i2c_driver i2cdev_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "dev driver",
-	.id		= I2C_DRIVERID_I2CDEV,
-	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= i2cdev_attach_adapter,
-	.detach_adapter	= i2cdev_detach_adapter,
-	.detach_client	= i2cdev_detach_client,
-	.command	= i2cdev_command,
-};
+#define I2C_MINORS	256
+static struct i2c_dev *i2c_dev_array[I2C_MINORS];
+static spinlock_t i2c_dev_array_lock = SPIN_LOCK_UNLOCKED;
 
-static struct i2c_client i2cdev_client_template = {
-	.dev		= {
-		.name	= "I2C /dev entry",
-	},
-	.id		= 1,
-	.addr		= -1,
-	.driver		= &i2cdev_driver,
-};
+struct i2c_dev *i2c_dev_get_by_minor(unsigned index)
+{
+	struct i2c_dev *i2c_dev;
+
+	spin_lock(&i2c_dev_array_lock);
+	i2c_dev = i2c_dev_array[index];
+	spin_unlock(&i2c_dev_array_lock);
+	return i2c_dev;
+}
+
+struct i2c_dev *i2c_dev_get_by_adapter(struct i2c_adapter *adap)
+{
+	struct i2c_dev *i2c_dev = NULL;
+	int i;
+
+	spin_lock(&i2c_dev_array_lock);
+	for (i = 0; i < I2C_MINORS; ++i) {
+		if ((i2c_dev_array[i]) &&
+		    (i2c_dev_array[i]->adap == adap)) {
+			i2c_dev = i2c_dev_array[i];
+			break;
+		}
+	}
+	spin_unlock(&i2c_dev_array_lock);
+	return i2c_dev;
+}
+
+static struct i2c_dev *get_free_i2c_dev(void)
+{
+	struct i2c_dev *i2c_dev;
+	unsigned int i;
+
+	i2c_dev = kmalloc(sizeof(*i2c_dev), GFP_KERNEL);
+	if (!i2c_dev)
+		return ERR_PTR(-ENOMEM);
+	memset(i2c_dev, 0x00, sizeof(*i2c_dev));
+
+	spin_lock(&i2c_dev_array_lock);
+	for (i = 0; i < I2C_MINORS; ++i) {
+		if (i2c_dev_array[i])
+			continue;
+		i2c_dev->minor = i;
+		i2c_dev_array[i] = i2c_dev;
+		spin_unlock(&i2c_dev_array_lock);
+		return i2c_dev;
+	}
+	spin_unlock(&i2c_dev_array_lock);
+	kfree(i2c_dev);
+	return ERR_PTR(-ENODEV);
+}
+
+static void return_i2c_dev(struct i2c_dev *i2c_dev)
+{
+	spin_lock(&i2c_dev_array_lock);
+	i2c_dev_array[i2c_dev->minor] = NULL;
+	spin_unlock(&i2c_dev_array_lock);
+	kfree(i2c_dev);
+}
+
+static ssize_t show_dev(struct class_device *class_dev, char *buf)
+{
+	struct i2c_dev *i2c_dev = to_i2c_dev(class_dev);
+	return sprintf(buf, "%04x\n", MKDEV(I2C_MAJOR, i2c_dev->minor));
+}
+static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
 
 static ssize_t i2cdev_read (struct file *file, char *buf, size_t count,
                             loff_t *offset)
@@ -104,7 +133,6 @@
 	if (count > 8192)
 		count = 8192;
 
-	/* copy user space data to kernel space. */
 	tmp = kmalloc(count,GFP_KERNEL);
 	if (tmp==NULL)
 		return -ENOMEM;
@@ -129,7 +157,6 @@
 	if (count > 8192)
 		count = 8192;
 
-	/* copy user space data to kernel space. */
 	tmp = kmalloc(count,GFP_KERNEL);
 	if (tmp==NULL)
 		return -ENOMEM;
@@ -157,7 +184,7 @@
 	int i,datasize,res;
 	unsigned long funcs;
 
-	pr_debug("i2c-dev.o: i2c-%d ioctl, cmd: 0x%x, arg: %lx.\n",
+	dev_dbg(&client->dev, "i2c-%d ioctl, cmd: 0x%x, arg: %lx.\n",
 		minor(inode->i_rdev),cmd, arg);
 
 	switch ( cmd ) {
@@ -242,13 +269,11 @@
 				rdwr_arg.nmsgs);
 		}
 		while(i-- > 0) {
-			if( res>=0 && (rdwr_pa[i].flags & I2C_M_RD))
-			{
+			if( res>=0 && (rdwr_pa[i].flags & I2C_M_RD)) {
 				if(copy_to_user(
 					rdwr_arg.msgs[i].buf,
 					rdwr_pa[i].buf,
-					rdwr_pa[i].len))
-				{
+					rdwr_pa[i].len)) {
 					res = -EFAULT;
 				}
 			}
@@ -340,9 +365,14 @@
 	unsigned int minor = minor(inode->i_rdev);
 	struct i2c_client *client;
 	struct i2c_adapter *adap;
+	struct i2c_dev *i2c_dev;
 
-	adap = i2c_get_adapter(minor);
-	if (NULL == adap)
+	i2c_dev = i2c_dev_get_by_minor(minor);
+	if (!i2c_dev)
+		return -ENODEV;
+
+	adap = i2c_get_adapter(i2c_dev->adap->nr);
+	if (!adap)
 		return -ENODEV;
 
 	client = kmalloc(sizeof(*client), GFP_KERNEL);
@@ -370,29 +400,68 @@
 	return 0;
 }
 
-int i2cdev_attach_adapter(struct i2c_adapter *adap)
+static struct file_operations i2cdev_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= i2cdev_read,
+	.write		= i2cdev_write,
+	.ioctl		= i2cdev_ioctl,
+	.open		= i2cdev_open,
+	.release	= i2cdev_release,
+};
+
+static struct class i2c_dev_class = {
+	.name	= "i2c-dev",
+};
+
+static int i2cdev_attach_adapter(struct i2c_adapter *adap)
 {
-	int i;
+	struct i2c_dev *i2c_dev;
+	int retval;
 
-	i = i2c_adapter_id(adap);
-	devfs_mk_cdev(MKDEV(I2C_MAJOR, i),
-			S_IFCHR|S_IRUSR|S_IWUSR, "i2c/%d", i);
-	dev_dbg(&adap->dev, "Registered as minor %d\n", i);
+	i2c_dev = get_free_i2c_dev();
+	if (IS_ERR(i2c_dev))
+		return PTR_ERR(i2c_dev);
+
+	devfs_mk_cdev(MKDEV(I2C_MAJOR, i2c_dev->minor),
+			S_IFCHR|S_IRUSR|S_IWUSR, "i2c/%d", i2c_dev->minor);
+	dev_dbg(&adap->dev, "Registered as minor %d\n", i2c_dev->minor);
+
+	/* register this i2c device with the driver core */
+	i2c_dev->adap = adap;
+	if (adap->dev.parent == &legacy_bus)
+		i2c_dev->class_dev.dev = &adap->dev;
+	else
+		i2c_dev->class_dev.dev = adap->dev.parent;
+	i2c_dev->class_dev.class = &i2c_dev_class;
+	snprintf(i2c_dev->class_dev.class_id, BUS_ID_SIZE, "i2c-%d", i2c_dev->minor);
+	retval = class_device_register(&i2c_dev->class_dev);
+	if (retval)
+		goto error;
+	class_device_create_file(&i2c_dev->class_dev, &class_device_attr_dev);
 	return 0;
+error:
+	return_i2c_dev(i2c_dev);
+	return retval;
 }
 
-int i2cdev_detach_adapter(struct i2c_adapter *adap)
+static int i2cdev_detach_adapter(struct i2c_adapter *adap)
 {
-	int i;
+	struct i2c_dev *i2c_dev;
 
-	i = i2c_adapter_id(adap);
+	i2c_dev = i2c_dev_get_by_adapter(adap);
+	if (!i2c_dev)
+		return -ENODEV;
+
+	class_device_unregister(&i2c_dev->class_dev);
+	devfs_remove("i2c/%d", i2c_dev->minor);
+	return_i2c_dev(i2c_dev);
 
-	devfs_remove("i2c/%d", i);
 	dev_dbg(&adap->dev, "Adapter unregistered\n");
 	return 0;
 }
 
-int i2cdev_detach_client(struct i2c_client *client)
+static int i2cdev_detach_client(struct i2c_client *client)
 {
 	return 0;
 }
@@ -403,7 +472,27 @@
 	return -1;
 }
 
-int __init i2c_dev_init(void)
+static struct i2c_driver i2cdev_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "dev driver",
+	.id		= I2C_DRIVERID_I2CDEV,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= i2cdev_attach_adapter,
+	.detach_adapter	= i2cdev_detach_adapter,
+	.detach_client	= i2cdev_detach_client,
+	.command	= i2cdev_command,
+};
+
+static struct i2c_client i2cdev_client_template = {
+	.dev		= {
+		.name	= "I2C /dev entry",
+	},
+	.id		= 1,
+	.addr		= -1,
+	.driver		= &i2cdev_driver,
+};
+
+static int __init i2c_dev_init(void)
 {
 	int res;
 
@@ -416,6 +505,7 @@
 		return -EIO;
 	}
 	devfs_mk_dir("i2c");
+	class_register(&i2c_dev_class);
 	if ((res = i2c_add_driver(&i2cdev_driver))) {
 		printk(KERN_ERR "i2c-dev.o: Driver registration failed, module not inserted.\n");
 		devfs_remove("i2c");
@@ -428,11 +518,13 @@
 static void __exit i2c_dev_exit(void)
 {
 	i2c_del_driver(&i2cdev_driver);
+	class_unregister(&i2c_dev_class);
 	devfs_remove("i2c");
 	unregister_chrdev(I2C_MAJOR,"i2c");
 }
 
-MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and Simon G. Vogl <simon@tk.uni-linz.ac.at>");
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and "
+		"Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C /dev entries driver");
 MODULE_LICENSE("GPL");
 

