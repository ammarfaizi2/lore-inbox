Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264343AbTEGXhW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbTEGXCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:02:47 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:17060 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264196AbTEGXCB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:01 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493881029@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493881130@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1115, 2003/05/07 15:51:02-07:00, greg@kroah.com

TTY: add tty class support for all tty devices.


 drivers/char/tty_io.c |  146 +++++++++++++++++++++++++++++++++++++++++---------
 include/linux/tty.h   |    3 -
 2 files changed, 122 insertions(+), 27 deletions(-)


diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Wed May  7 16:00:04 2003
+++ b/drivers/char/tty_io.c	Wed May  7 16:00:04 2003
@@ -2088,22 +2088,6 @@
 }
 
 #ifdef CONFIG_DEVFS_FS
-static void tty_register_devfs(struct tty_driver *driver, unsigned index)
-{
-	dev_t dev = MKDEV(driver->major, driver->minor_start) + index;
-	char buf[32];
-
-	if (index >= driver->num) {
-		printk(KERN_ERR "Attempt to register invalid tty line number "
-		       "with devfs (%d).\n", index);
-		return;
-	}
-
-	tty_line_name(driver, index, buf);
-	devfs_register(NULL, buf, 0, MAJOR(dev), MINOR(dev),
-		S_IFCHR | S_IRUSR | S_IWUSR, &tty_fops, NULL);
-}
-
 static void tty_unregister_devfs(struct tty_driver *driver, int index)
 {
 	char path[64];
@@ -2111,21 +2095,131 @@
 	devfs_remove(path);
 }
 #else
-# define tty_register_devfs(driver, index)	do { } while (0)
 # define tty_unregister_devfs(driver, index)	do { } while (0)
 #endif /* CONFIG_DEVFS_FS */
 
-/*
- * Register a tty device described by <driver>, with minor number <minor>.
+static struct class tty_class = {
+	.name	= "tty",
+};
+
+struct tty_dev {
+	struct list_head node;
+	dev_t dev;
+	struct class_device class_dev;
+};
+#define to_tty_dev(d) container_of(d, struct tty_dev, class_dev)
+
+static LIST_HEAD(tty_dev_list);
+
+static ssize_t show_dev(struct class_device *class_dev, char *buf)
+{
+	struct tty_dev *tty_dev = to_tty_dev(class_dev);
+	return sprintf(buf, "%04x\n", tty_dev->dev);
+}
+static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
+
+static void tty_add_class_device(char *name, dev_t dev, struct device *device)
+{
+	struct tty_dev *tty_dev = NULL;
+	char *temp;
+	int retval;
+
+	tty_dev = kmalloc(sizeof(*tty_dev), GFP_KERNEL);
+	if (!tty_dev)
+		return;
+	memset(tty_dev, 0x00, sizeof(*tty_dev));
+
+	/* stupid '/' in tty name strings... */
+	temp = strchr(name, '/');
+	if (temp && (temp[1] != 0x00))
+		++temp;
+	else
+		temp = name;
+
+	tty_dev->class_dev.dev = device;
+	tty_dev->class_dev.class = &tty_class;
+	snprintf(tty_dev->class_dev.class_id, BUS_ID_SIZE, "%s", temp);
+	retval = class_device_register(&tty_dev->class_dev);
+	if (retval)
+		goto error;
+	class_device_create_file (&tty_dev->class_dev, &class_device_attr_dev);
+	tty_dev->dev = dev;
+	list_add(&tty_dev->node, &tty_dev_list);
+	return;
+error:
+	kfree(tty_dev);
+}
+
+void tty_remove_class_device(dev_t dev)
+{
+	struct tty_dev *tty_dev = NULL;
+	struct list_head *tmp;
+	int found = 0;
+
+	list_for_each (tmp, &tty_dev_list) {
+		tty_dev = list_entry(tmp, struct tty_dev, node);
+		if ((MAJOR(tty_dev->dev) == MAJOR(dev)) &&
+		    (MINOR(tty_dev->dev) == MINOR(dev))) {
+			found = 1;
+			break;
+		}
+	}
+	if (found) {
+		list_del(&tty_dev->node);
+		class_device_unregister(&tty_dev->class_dev);
+		kfree(tty_dev);
+	}
+}
+
+/**
+ * tty_register_device - register a tty device
+ * @driver: the tty driver that describes the tty device
+ * @index: the index in the tty driver for this tty device
+ * @device: a struct device that is associated with this tty device.
+ *	This field is optional, if there is no known struct device for this
+ *	tty device it can be set to NULL safely.
+ *
+ * This call is required to be made to register an individual tty device if
+ * the tty driver's flags have the TTY_DRIVER_NO_DEVFS bit set.  If that
+ * bit is not set, this function should not be called.
  */
-void tty_register_device(struct tty_driver *driver, unsigned index)
+void tty_register_device(struct tty_driver *driver, unsigned index,
+			 struct device *device)
 {
-	tty_register_devfs(driver, index);
+	dev_t dev = MKDEV(driver->major, driver->minor_start) + index;
+	char name[64];
+
+	if (index >= driver->num) {
+		printk(KERN_ERR "Attempt to register invalid tty line number "
+		       " (%d).\n", index);
+		return;
+	}
+
+	tty_line_name(driver, index, name);
+	devfs_register(NULL, name, 0, MAJOR(dev), MINOR(dev),
+		S_IFCHR | S_IRUSR | S_IWUSR, &tty_fops, NULL);
+
+	/* stupid console driver devfs names... change vc/X into ttyX */
+	if (driver->type == TTY_DRIVER_TYPE_CONSOLE)
+		sprintf(name, "tty%d", MINOR(dev));
+
+	/* we don't care about the ptys */
+	if (driver->type != TTY_DRIVER_TYPE_PTY)
+		tty_add_class_device (name, dev, device);
 }
 
+/**
+ * tty_unregister_device - unregister a tty device
+ * @driver: the tty driver that describes the tty device
+ * @index: the index in the tty driver for this tty device
+ *
+ * If a tty device is registered with a call to tty_register_device() then
+ * this function must be made when the tty device is gone.
+ */
 void tty_unregister_device(struct tty_driver *driver, unsigned index)
 {
 	tty_unregister_devfs(driver, index);
+	tty_remove_class_device(MKDEV(driver->major, driver->minor_start) + index);
 }
 
 EXPORT_SYMBOL(tty_register_device);
@@ -2207,7 +2301,7 @@
 	
 	if ( !(driver->flags & TTY_DRIVER_NO_DEVFS) ) {
 		for(i = 0; i < driver->num; i++)
-		    tty_register_device(driver, i);
+		    tty_register_device(driver, i, NULL);
 	}
 	proc_tty_register_driver(driver);
 	return error;
@@ -2288,10 +2382,6 @@
 extern int vty_init(void);
 #endif
 
-static struct class tty_class = {
-	.name	= "tty",
-};
-
 static int __init tty_class_init(void)
 {
 	return class_register(&tty_class);
@@ -2311,6 +2401,7 @@
 
 	devfs_register (NULL, "tty", 0, TTYAUX_MAJOR, 0,
 			S_IFCHR | S_IRUGO | S_IWUGO, &tty_fops, NULL);
+	tty_add_class_device ("tty", MKDEV(TTYAUX_MAJOR, 0), NULL);
 
 	if (register_chrdev_region(TTYAUX_MAJOR, 1, 1,
 				   "/dev/console", &tty_fops) < 0)
@@ -2318,6 +2409,7 @@
 
 	devfs_register (NULL, "console", 0, TTYAUX_MAJOR, 1,
 			S_IFCHR | S_IRUSR | S_IWUSR, &tty_fops, NULL);
+	tty_add_class_device ("console", MKDEV(TTYAUX_MAJOR, 1), NULL);
 
 #ifdef CONFIG_UNIX98_PTYS
 	if (register_chrdev_region(TTYAUX_MAJOR, 2, 1,
@@ -2326,6 +2418,7 @@
 
 	devfs_register (NULL, "ptmx", 0, TTYAUX_MAJOR, 2,
 			S_IFCHR | S_IRUGO | S_IWUGO, &tty_fops, NULL);
+	tty_add_class_device ("ptmx", MKDEV(TTYAUX_MAJOR, 2), NULL);
 #endif
 	
 #ifdef CONFIG_VT
@@ -2335,6 +2428,7 @@
 
 	devfs_register (NULL, "vc/0", 0, TTY_MAJOR, 0,
 			S_IFCHR | S_IRUSR | S_IWUSR, &tty_fops, NULL);
+	tty_add_class_device ("tty0", MKDEV(TTY_MAJOR, 0), NULL);
 
 	vty_init();
 #endif
diff -Nru a/include/linux/tty.h b/include/linux/tty.h
--- a/include/linux/tty.h	Wed May  7 16:00:04 2003
+++ b/include/linux/tty.h	Wed May  7 16:00:04 2003
@@ -243,6 +243,7 @@
 #define L_PENDIN(tty)	_L_FLAG((tty),PENDIN)
 #define L_IEXTEN(tty)	_L_FLAG((tty),IEXTEN)
 
+struct device;
 /*
  * Where all of the state associated with a tty is kept while the tty
  * is open.  Since the termios state should be kept even if the tty
@@ -380,7 +381,7 @@
 extern int tty_register_ldisc(int disc, struct tty_ldisc *new_ldisc);
 extern int tty_register_driver(struct tty_driver *driver);
 extern int tty_unregister_driver(struct tty_driver *driver);
-extern void tty_register_device(struct tty_driver *driver, unsigned index);
+extern void tty_register_device(struct tty_driver *driver, unsigned index, struct device *dev);
 extern void tty_unregister_device(struct tty_driver *driver, unsigned index);
 extern int tty_read_raw_data(struct tty_struct *tty, unsigned char *bufp,
 			     int buflen);

