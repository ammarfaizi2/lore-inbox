Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUDORrN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbUDORo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:44:27 -0400
Received: from mail.kroah.org ([65.200.24.183]:27062 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263172AbUDORmR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:42:17 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core update for 2.6.6-rc1
In-Reply-To: <1082050911678@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 15 Apr 2004 10:41:51 -0700
Message-Id: <10820509111858@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.2, 2004/03/19 13:10:22-08:00, greg@kroah.com

add sysfs support for vc devices.


 drivers/char/vc_screen.c |   10 ++++++++++
 1 files changed, 10 insertions(+)


diff -Nru a/drivers/char/vc_screen.c b/drivers/char/vc_screen.c
--- a/drivers/char/vc_screen.c	Thu Apr 15 10:21:22 2004
+++ b/drivers/char/vc_screen.c	Thu Apr 15 10:21:22 2004
@@ -36,6 +36,7 @@
 #include <linux/kbd_kern.h>
 #include <linux/console.h>
 #include <linux/smp_lock.h>
+#include <linux/device.h>
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
@@ -469,6 +470,8 @@
 	.open		= vcs_open,
 };
 
+static struct class_simple *vc_class;
+
 void vcs_make_devfs(struct tty_struct *tty)
 {
 	devfs_mk_cdev(MKDEV(VCS_MAJOR, tty->index + 1),
@@ -477,19 +480,26 @@
 	devfs_mk_cdev(MKDEV(VCS_MAJOR, tty->index + 129),
 			S_IFCHR|S_IRUSR|S_IWUSR,
 			"vcc/a%u", tty->index + 1);
+	class_simple_device_add(vc_class, MKDEV(VCS_MAJOR, tty->index + 1), NULL, "vcs%u", tty->index + 1);
+	class_simple_device_add(vc_class, MKDEV(VCS_MAJOR, tty->index + 129), NULL, "vcsa%u", tty->index + 1);
 }
 void vcs_remove_devfs(struct tty_struct *tty)
 {
 	devfs_remove("vcc/%u", tty->index + 1);
 	devfs_remove("vcc/a%u", tty->index + 1);
+	class_simple_device_remove(MKDEV(VCS_MAJOR, tty->index + 1));
+	class_simple_device_remove(MKDEV(VCS_MAJOR, tty->index + 129));
 }
 
 int __init vcs_init(void)
 {
 	if (register_chrdev(VCS_MAJOR, "vcs", &vcs_fops))
 		panic("unable to get major %d for vcs device", VCS_MAJOR);
+	vc_class = class_simple_create(THIS_MODULE, "vc");
 
 	devfs_mk_cdev(MKDEV(VCS_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR, "vcc/0");
 	devfs_mk_cdev(MKDEV(VCS_MAJOR, 128), S_IFCHR|S_IRUSR|S_IWUSR, "vcc/a0");
+	class_simple_device_add(vc_class, MKDEV(VCS_MAJOR, 0), NULL, "vcs");
+	class_simple_device_add(vc_class, MKDEV(VCS_MAJOR, 128), NULL, "vcsa");
 	return 0;
 }

