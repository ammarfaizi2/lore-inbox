Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVCORN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVCORN4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVCORMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:12:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:50887 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261538AbVCORL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:11:28 -0500
Date: Tue, 15 Mar 2005 09:10:00 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Cc: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Changes to the driver model class code.
Message-ID: <20050315171000.GC25475@kroah.com>
References: <20050315170834.GA25475@kroah.com> <20050315170935.GB25475@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315170935.GB25475@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch 2 of 4

 Subject: tty: move to use the new class code, instead of class_simple

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	2005-03-15 08:54:22 -08:00
+++ b/drivers/char/tty_io.c	2005-03-15 08:54:22 -08:00
@@ -2653,7 +2653,7 @@
 	tty->driver->write(tty, &ch, 1);
 }
 
-static struct class_simple *tty_class;
+static struct class *tty_class;
 
 /**
  * tty_register_device - register a tty device
@@ -2686,7 +2686,7 @@
 		pty_line_name(driver, index, name);
 	else
 		tty_line_name(driver, index, name);
-	class_simple_device_add(tty_class, dev, device, name);
+	class_device_create(tty_class, dev, device, name);
 }
 
 /**
@@ -2700,7 +2700,7 @@
 void tty_unregister_device(struct tty_driver *driver, unsigned index)
 {
 	devfs_remove("%s%d", driver->devfs_name, index + driver->name_base);
-	class_simple_device_remove(MKDEV(driver->major, driver->minor_start) + index);
+	class_device_destroy(tty_class, MKDEV(driver->major, driver->minor_start) + index);
 }
 
 EXPORT_SYMBOL(tty_register_device);
@@ -2917,7 +2917,7 @@
 
 static int __init tty_class_init(void)
 {
-	tty_class = class_simple_create(THIS_MODULE, "tty");
+	tty_class = class_create(THIS_MODULE, "tty");
 	if (IS_ERR(tty_class))
 		return PTR_ERR(tty_class);
 	return 0;
@@ -2946,14 +2946,14 @@
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
 		panic("Couldn't register /dev/tty driver\n");
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 0), S_IFCHR|S_IRUGO|S_IWUGO, "tty");
-	class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 0), NULL, "tty");
+	class_device_create(tty_class, MKDEV(TTYAUX_MAJOR, 0), NULL, "tty");
 
 	cdev_init(&console_cdev, &console_fops);
 	if (cdev_add(&console_cdev, MKDEV(TTYAUX_MAJOR, 1), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 1), 1, "/dev/console") < 0)
 		panic("Couldn't register /dev/console driver\n");
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 1), S_IFCHR|S_IRUSR|S_IWUSR, "console");
-	class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 1), NULL, "console");
+	class_device_create(tty_class, MKDEV(TTYAUX_MAJOR, 1), NULL, "console");
 
 #ifdef CONFIG_UNIX98_PTYS
 	cdev_init(&ptmx_cdev, &ptmx_fops);
@@ -2961,7 +2961,7 @@
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 2), 1, "/dev/ptmx") < 0)
 		panic("Couldn't register /dev/ptmx driver\n");
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 2), S_IFCHR|S_IRUGO|S_IWUGO, "ptmx");
-	class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 2), NULL, "ptmx");
+	class_device_create(tty_class, MKDEV(TTYAUX_MAJOR, 2), NULL, "ptmx");
 #endif
 
 #ifdef CONFIG_VT
@@ -2970,7 +2970,7 @@
 	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
 		panic("Couldn't register /dev/tty0 driver\n");
 	devfs_mk_cdev(MKDEV(TTY_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR, "vc/0");
-	class_simple_device_add(tty_class, MKDEV(TTY_MAJOR, 0), NULL, "tty0");
+	class_device_create(tty_class, MKDEV(TTY_MAJOR, 0), NULL, "tty0");
 
 	vty_init();
 #endif
