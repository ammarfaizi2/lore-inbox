Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271070AbTGPSfb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271033AbTGPSbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:31:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:48584 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271044AbTGPSbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:31:19 -0400
Date: Wed, 16 Jul 2003 11:46:09 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-ID: <20030716184609.GA1913@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a patch against 2.6.0-test1-mm that fixes up the different places
where we export a dev_t to userspace.  This fixes all of the compiler
warnings that were previously reported with these files.

If I should put the print_dev_t() function in a different header file,
please let me know.

thanks,

greg k-h


diff -Naur -X /home/greg/linux/dontdiff linux-2.6.0-test1-mm/drivers/block/genhd.c linux-2.6.0-test1-mm-gregkh/drivers/block/genhd.c
--- linux-2.6.0-test1-mm/drivers/block/genhd.c	2003-07-13 20:34:02.000000000 -0700
+++ linux-2.6.0-test1-mm-gregkh/drivers/block/genhd.c	2003-07-16 11:34:34.755238792 -0700
@@ -336,7 +336,7 @@
 static ssize_t disk_dev_read(struct gendisk * disk, char *page)
 {
 	dev_t base = MKDEV(disk->major, disk->first_minor); 
-	return sprintf(page, "%04x\n", (unsigned)base);
+	return print_dev_t(page, base);
 }
 static ssize_t disk_range_read(struct gendisk * disk, char *page)
 {
diff -Naur -X /home/greg/linux/dontdiff linux-2.6.0-test1-mm/drivers/char/tty_io.c linux-2.6.0-test1-mm-gregkh/drivers/char/tty_io.c
--- linux-2.6.0-test1-mm/drivers/char/tty_io.c	2003-07-13 20:34:49.000000000 -0700
+++ linux-2.6.0-test1-mm-gregkh/drivers/char/tty_io.c	2003-07-16 11:35:40.205288872 -0700
@@ -2106,7 +2106,7 @@
 static ssize_t show_dev(struct class_device *class_dev, char *buf)
 {
 	struct tty_dev *tty_dev = to_tty_dev(class_dev);
-	return sprintf(buf, "%04lx\n", (unsigned long)tty_dev->dev);
+	return print_dev_t(buf, tty_dev->dev);
 }
 static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
 
diff -Naur -X /home/greg/linux/dontdiff linux-2.6.0-test1-mm/drivers/i2c/i2c-dev.c linux-2.6.0-test1-mm-gregkh/drivers/i2c/i2c-dev.c
--- linux-2.6.0-test1-mm/drivers/i2c/i2c-dev.c	2003-07-13 20:36:48.000000000 -0700
+++ linux-2.6.0-test1-mm-gregkh/drivers/i2c/i2c-dev.c	2003-07-16 11:36:23.060773848 -0700
@@ -118,7 +118,7 @@
 static ssize_t show_dev(struct class_device *class_dev, char *buf)
 {
 	struct i2c_dev *i2c_dev = to_i2c_dev(class_dev);
-	return sprintf(buf, "%04x\n", MKDEV(I2C_MAJOR, i2c_dev->minor));
+	return print_dev_t(buf, MKDEV(I2C_MAJOR, i2c_dev->minor));
 }
 static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
 
diff -Naur -X /home/greg/linux/dontdiff linux-2.6.0-test1-mm/drivers/usb/core/file.c linux-2.6.0-test1-mm-gregkh/drivers/usb/core/file.c
--- linux-2.6.0-test1-mm/drivers/usb/core/file.c	2003-07-16 11:25:05.269813736 -0700
+++ linux-2.6.0-test1-mm-gregkh/drivers/usb/core/file.c	2003-07-16 11:33:27.193509736 -0700
@@ -93,7 +93,7 @@
 {
 	struct usb_interface *intf = class_dev_to_usb_interface(class_dev);
 	dev_t dev = MKDEV(USB_MAJOR, intf->minor);
-	return sprintf(buf, "%04lx\n", (unsigned long)dev);
+	return print_dev_t(buf, dev);
 }
 static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
 
diff -Naur -X /home/greg/linux/dontdiff linux-2.6.0-test1-mm/include/linux/kdev_t.h linux-2.6.0-test1-mm-gregkh/include/linux/kdev_t.h
--- linux-2.6.0-test1-mm/include/linux/kdev_t.h	2003-07-16 11:25:05.868722688 -0700
+++ linux-2.6.0-test1-mm-gregkh/include/linux/kdev_t.h	2003-07-16 11:33:05.754768920 -0700
@@ -103,6 +103,11 @@
 	return mk_kdev(ma, mi);
 }
 
+static inline int print_dev_t(char *buffer, dev_t dev)
+{
+	return sprintf(buffer, "%04lx\n", (unsigned long)dev);
+}
+
 #else /* __KERNEL__ */
 
 /*
