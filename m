Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUAOUrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 15:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUAOUqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 15:46:37 -0500
Received: from mail.kroah.org ([65.200.24.183]:43483 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263166AbUAOUoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 15:44:37 -0500
Date: Thu, 15 Jan 2004 12:43:56 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] add sysfs class support for vc devices [10/10]
Message-ID: <20040115204356.GK22199@kroah.com>
References: <20040115204048.GA22199@kroah.com> <20040115204111.GB22199@kroah.com> <20040115204125.GC22199@kroah.com> <20040115204138.GD22199@kroah.com> <20040115204153.GE22199@kroah.com> <20040115204209.GF22199@kroah.com> <20040115204241.GG22199@kroah.com> <20040115204259.GH22199@kroah.com> <20040115204311.GI22199@kroah.com> <20040115204329.GJ22199@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115204329.GJ22199@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch add sysfs support for vc char devices.

Note, Andrew Morton has reported some very strange oopses with this
patch, that I can not reproduce at all.  If anyone else also has
problems with this patch, please let me know.



diff -Nru a/drivers/char/vc_screen.c b/drivers/char/vc_screen.c
--- a/drivers/char/vc_screen.c	Thu Jan 15 11:05:48 2004
+++ b/drivers/char/vc_screen.c	Thu Jan 15 11:05:48 2004
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
diff -Nru a/drivers/char/vt.c b/drivers/char/vt.c
--- a/drivers/char/vt.c	Thu Jan 15 11:05:50 2004
+++ b/drivers/char/vt.c	Thu Jan 15 11:05:50 2004
@@ -2539,6 +2539,8 @@
 
 int __init vty_init(void)
 {
+	vcs_init();
+
 	console_driver = alloc_tty_driver(MAX_NR_CONSOLES);
 	if (!console_driver)
 		panic("Couldn't allocate console driver\n");
@@ -2566,7 +2568,6 @@
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE
 	fb_console_init();
 #endif	
-	vcs_init();
 	return 0;
 }
 
