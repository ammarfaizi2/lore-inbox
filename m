Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVFUCMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVFUCMI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVFUCKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:10:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:38628 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261753AbVFTW7v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:51 -0400
Cc: gregkh@suse.de
Subject: [PATCH] tty: move to use the new class code, instead of class_simple
In-Reply-To: <11193083621397@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:22 -0700
Message-Id: <11193083622025@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] tty: move to use the new class code, instead of class_simple

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 7fe845d11ad1b4aac098d40c55275569e143c483
tree db94f76a6de7ec45fbdea8dfdb65316a7452b3b5
parent e9ba6365fd4f0d9e7d022c883bd044fbaa48257f
author gregkh@suse.de <gregkh@suse.de> Tue, 15 Mar 2005 14:23:15 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:04 -0700

 drivers/char/tty_io.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -2654,7 +2654,7 @@ static void tty_default_put_char(struct 
 	tty->driver->write(tty, &ch, 1);
 }
 
-static struct class_simple *tty_class;
+static struct class *tty_class;
 
 /**
  * tty_register_device - register a tty device
@@ -2687,7 +2687,7 @@ void tty_register_device(struct tty_driv
 		pty_line_name(driver, index, name);
 	else
 		tty_line_name(driver, index, name);
-	class_simple_device_add(tty_class, dev, device, name);
+	class_device_create(tty_class, dev, device, name);
 }
 
 /**
@@ -2701,7 +2701,7 @@ void tty_register_device(struct tty_driv
 void tty_unregister_device(struct tty_driver *driver, unsigned index)
 {
 	devfs_remove("%s%d", driver->devfs_name, index + driver->name_base);
-	class_simple_device_remove(MKDEV(driver->major, driver->minor_start) + index);
+	class_device_destroy(tty_class, MKDEV(driver->major, driver->minor_start) + index);
 }
 
 EXPORT_SYMBOL(tty_register_device);
@@ -2918,7 +2918,7 @@ extern int vty_init(void);
 
 static int __init tty_class_init(void)
 {
-	tty_class = class_simple_create(THIS_MODULE, "tty");
+	tty_class = class_create(THIS_MODULE, "tty");
 	if (IS_ERR(tty_class))
 		return PTR_ERR(tty_class);
 	return 0;
@@ -2947,14 +2947,14 @@ static int __init tty_init(void)
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
@@ -2962,7 +2962,7 @@ static int __init tty_init(void)
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 2), 1, "/dev/ptmx") < 0)
 		panic("Couldn't register /dev/ptmx driver\n");
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 2), S_IFCHR|S_IRUGO|S_IWUGO, "ptmx");
-	class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 2), NULL, "ptmx");
+	class_device_create(tty_class, MKDEV(TTYAUX_MAJOR, 2), NULL, "ptmx");
 #endif
 
 #ifdef CONFIG_VT
@@ -2971,7 +2971,7 @@ static int __init tty_init(void)
 	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
 		panic("Couldn't register /dev/tty0 driver\n");
 	devfs_mk_cdev(MKDEV(TTY_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR, "vc/0");
-	class_simple_device_add(tty_class, MKDEV(TTY_MAJOR, 0), NULL, "tty0");
+	class_device_create(tty_class, MKDEV(TTY_MAJOR, 0), NULL, "tty0");
 
 	vty_init();
 #endif

