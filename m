Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbUATBUv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 20:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUATBSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 20:18:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:31177 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265345AbUATBMr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:12:47 -0500
Subject: Re: [PATCH] Driver Core update and fixes for 2.6.1
In-Reply-To: <10745611592235@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 17:12:40 -0800
Message-Id: <10745611602@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1498, 2004/01/19 16:36:04-08:00, greg@kroah.com

[PATCH] TTY: clean up sysfs class support for tty devices

This patch ports the existing tty class support to the class_simple
interface, saving a lot of code in the process.


 drivers/char/tty_io.c |   91 ++++++--------------------------------------------
 1 files changed, 11 insertions(+), 80 deletions(-)


diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Mon Jan 19 17:05:10 2004
+++ b/drivers/char/tty_io.c	Mon Jan 19 17:05:10 2004
@@ -2069,79 +2069,7 @@
 	tty->driver->write(tty, 0, &ch, 1);
 }
 
-struct tty_dev {
-	struct list_head node;
-	dev_t dev;
-	struct class_device class_dev;
-};
-#define to_tty_dev(d) container_of(d, struct tty_dev, class_dev)
-
-static void release_tty_dev(struct class_device *class_dev)
-{
-	struct tty_dev *tty_dev = to_tty_dev(class_dev);
-	kfree(tty_dev);
-}
-
-static struct class tty_class = {
-	.name		= "tty",
-	.release	= &release_tty_dev,
-};
-
-static LIST_HEAD(tty_dev_list);
-static spinlock_t tty_dev_list_lock = SPIN_LOCK_UNLOCKED;
-
-static ssize_t show_dev(struct class_device *class_dev, char *buf)
-{
-	struct tty_dev *tty_dev = to_tty_dev(class_dev);
-	return print_dev_t(buf, tty_dev->dev);
-}
-static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
-
-static void tty_add_class_device(char *name, dev_t dev, struct device *device)
-{
-	struct tty_dev *tty_dev = NULL;
-	int retval;
-
-	tty_dev = kmalloc(sizeof(*tty_dev), GFP_KERNEL);
-	if (!tty_dev)
-		return;
-	memset(tty_dev, 0x00, sizeof(*tty_dev));
-
-	tty_dev->class_dev.dev = device;
-	tty_dev->class_dev.class = &tty_class;
-	snprintf(tty_dev->class_dev.class_id, BUS_ID_SIZE, "%s", name);
-	retval = class_device_register(&tty_dev->class_dev);
-	if (retval)
-		goto error;
-	class_device_create_file (&tty_dev->class_dev, &class_device_attr_dev);
-	tty_dev->dev = dev;
-	spin_lock(&tty_dev_list_lock);
-	list_add(&tty_dev->node, &tty_dev_list);
-	spin_unlock(&tty_dev_list_lock);
-	return;
-error:
-	kfree(tty_dev);
-}
-
-static void tty_remove_class_device(dev_t dev)
-{
-	struct tty_dev *tty_dev = NULL;
-	struct list_head *tmp;
-	int found = 0;
-
-	spin_lock(&tty_dev_list_lock);
-	list_for_each (tmp, &tty_dev_list) {
-		tty_dev = list_entry(tmp, struct tty_dev, node);
-		if (tty_dev->dev == dev) {
-			list_del(&tty_dev->node);
-			found = 1;
-			break;
-		}
-	}
-	spin_unlock(&tty_dev_list_lock);
-	if (found)
-		class_device_unregister(&tty_dev->class_dev);
-}
+static struct class_simple *tty_class;
 
 /**
  * tty_register_device - register a tty device
@@ -2174,7 +2102,7 @@
 	if (driver->type != TTY_DRIVER_TYPE_PTY) {
 		char name[64];
 		tty_line_name(driver, index, name);
-		tty_add_class_device(name, dev, device);
+		class_simple_device_add(tty_class, dev, device, name);
 	}
 }
 
@@ -2189,7 +2117,7 @@
 void tty_unregister_device(struct tty_driver *driver, unsigned index)
 {
 	devfs_remove("%s%d", driver->devfs_name, index + driver->name_base);
-	tty_remove_class_device(MKDEV(driver->major, driver->minor_start) + index);
+	class_simple_device_remove(MKDEV(driver->major, driver->minor_start) + index);
 }
 
 EXPORT_SYMBOL(tty_register_device);
@@ -2406,7 +2334,10 @@
 
 static int __init tty_class_init(void)
 {
-	return class_register(&tty_class);
+	tty_class = class_simple_create(THIS_MODULE, "tty");
+	if (IS_ERR(tty_class))
+		return PTR_ERR(tty_class);
+	return 0;
 }
 
 postcore_initcall(tty_class_init);
@@ -2431,7 +2362,7 @@
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
 		panic("Couldn't register /dev/tty driver\n");
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 0), S_IFCHR|S_IRUGO|S_IWUGO, "tty");
-	tty_add_class_device ("tty", MKDEV(TTYAUX_MAJOR, 0), NULL);
+	class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 0), NULL, "tty");
 
 	strcpy(console_cdev.kobj.name, "dev.console");
 	cdev_init(&console_cdev, &console_fops);
@@ -2439,7 +2370,7 @@
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 1), 1, "/dev/console") < 0)
 		panic("Couldn't register /dev/console driver\n");
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 1), S_IFCHR|S_IRUSR|S_IWUSR, "console");
-	tty_add_class_device ("console", MKDEV(TTYAUX_MAJOR, 1), NULL);
+	class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 1), NULL, "console");
 
 	tty_kobj.kset = tty_cdev.kobj.kset;
 	kobject_register(&tty_kobj);
@@ -2451,7 +2382,7 @@
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 2), 1, "/dev/ptmx") < 0)
 		panic("Couldn't register /dev/ptmx driver\n");
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 2), S_IFCHR|S_IRUGO|S_IWUGO, "ptmx");
-	tty_add_class_device ("ptmx", MKDEV(TTYAUX_MAJOR, 2), NULL);
+	class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 2), NULL, "ptmx");
 #endif
 	
 #ifdef CONFIG_VT
@@ -2461,7 +2392,7 @@
 	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
 		panic("Couldn't register /dev/tty0 driver\n");
 	devfs_mk_cdev(MKDEV(TTY_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR, "vc/0");
-	tty_add_class_device ("tty0", MKDEV(TTY_MAJOR, 0), NULL);
+	class_simple_device_add(tty_class, MKDEV(TTY_MAJOR, 0), NULL, "tty0");
 
 	vty_init();
 #endif

