Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbTLWVdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 16:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTLWVcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 16:32:33 -0500
Received: from mail.kroah.org ([65.200.24.183]:52191 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262610AbTLWVbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 16:31:42 -0500
Date: Tue, 23 Dec 2003 13:31:29 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] add sysfs vc class  [5/5]
Message-ID: <20031223213129.GF15700@kroah.com>
References: <20031223212459.GA15700@kroah.com> <20031223212620.GB15700@kroah.com> <20031223212739.GC15700@kroah.com> <20031223212929.GD15700@kroah.com> <20031223213037.GE15700@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223213037.GE15700@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add sysfs vc class support

diff -Nru a/drivers/char/vc_screen.c b/drivers/char/vc_screen.c
--- a/drivers/char/vc_screen.c	Tue Dec 23 12:53:14 2003
+++ b/drivers/char/vc_screen.c	Tue Dec 23 12:53:14 2003
@@ -36,6 +36,7 @@
 #include <linux/kbd_kern.h>
 #include <linux/console.h>
 #include <linux/smp_lock.h>
+#include <linux/device.h>
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
@@ -469,6 +470,10 @@
 	.open		= vcs_open,
 };
 
+static struct class vc_class = {
+	.name	= "vc",
+};
+
 void vcs_make_devfs(struct tty_struct *tty)
 {
 	devfs_mk_cdev(MKDEV(VCS_MAJOR, tty->index + 1),
@@ -477,19 +482,26 @@
 	devfs_mk_cdev(MKDEV(VCS_MAJOR, tty->index + 129),
 			S_IFCHR|S_IRUSR|S_IWUSR,
 			"vcc/a%u", tty->index + 1);
+	simple_add_class_device(&vc_class, MKDEV(VCS_MAJOR, tty->index + 1), NULL, "vcs%u", tty->index + 1);
+	simple_add_class_device(&vc_class, MKDEV(VCS_MAJOR, tty->index + 129), NULL, "vcsa%u", tty->index + 1);
 }
 void vcs_remove_devfs(struct tty_struct *tty)
 {
 	devfs_remove("vcc/%u", tty->index + 1);
 	devfs_remove("vcc/a%u", tty->index + 1);
+	simple_remove_class_device(MKDEV(VCS_MAJOR, tty->index + 1));
+	simple_remove_class_device(MKDEV(VCS_MAJOR, tty->index + 129));
 }
 
 int __init vcs_init(void)
 {
 	if (register_chrdev(VCS_MAJOR, "vcs", &vcs_fops))
 		panic("unable to get major %d for vcs device", VCS_MAJOR);
+	class_register(&vc_class);
 
 	devfs_mk_cdev(MKDEV(VCS_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR, "vcc/0");
 	devfs_mk_cdev(MKDEV(VCS_MAJOR, 128), S_IFCHR|S_IRUSR|S_IWUSR, "vcc/a0");
+	simple_add_class_device(&vc_class, MKDEV(VCS_MAJOR, 0), NULL, "vcs");
+	simple_add_class_device(&vc_class, MKDEV(VCS_MAJOR, 128), NULL, "vcsa");
 	return 0;
 }
