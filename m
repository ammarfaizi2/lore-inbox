Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUDORoV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbUDORoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:44:02 -0400
Received: from mail.kroah.org ([65.200.24.183]:28086 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263184AbUDORmS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:42:18 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core update for 2.6.6-rc1
In-Reply-To: <10820509122120@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 15 Apr 2004 10:41:52 -0700
Message-Id: <1082050912368@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.7, 2004/03/22 11:47:06-08:00, kronos@kronoz.cjb.net

[PATCH] Sysfs for framebuffer

the following patch (against 2.6.5-rc2) teaches fb to use class_simple.
With this patch udev will automagically create device nodes for each
framebuffer registered. Once all drivers are converted to
framebuffer_{alloc,release} we can switch to our own class.

This is what sysfs dir looks like:

notebook:~# tree /sys/class/graphics/
/sys/class/graphics/
`-- fb0
    `-- dev


 drivers/video/fbmem.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+)


diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	Thu Apr 15 10:20:59 2004
+++ b/drivers/video/fbmem.c	Thu Apr 15 10:20:59 2004
@@ -32,6 +32,9 @@
 #include <linux/kmod.h>
 #endif
 #include <linux/devfs_fs_kernel.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
 
 #if defined(__mc68000__) || defined(CONFIG_APUS)
 #include <asm/setup.h>
@@ -1251,6 +1254,8 @@
 #endif
 };
 
+static struct class_simple *fb_class;
+
 /**
  *	register_framebuffer - registers a frame buffer device
  *	@fb_info: frame buffer info structure
@@ -1265,6 +1270,7 @@
 register_framebuffer(struct fb_info *fb_info)
 {
 	int i;
+	struct class_device *c;
 
 	if (num_registered_fb == FB_MAX)
 		return -ENXIO;
@@ -1273,6 +1279,12 @@
 		if (!registered_fb[i])
 			break;
 	fb_info->node = i;
+
+	c = class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i), NULL, "fb%d", i);
+	if (IS_ERR(c)) {
+		/* Not fatal */
+		printk(KERN_WARNING "Unable to create class_device for framebuffer %d; errno = %ld\n", i, PTR_ERR(c));
+	}
 	
 	if (fb_info->pixmap.addr == NULL) {
 		fb_info->pixmap.addr = kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
@@ -1338,6 +1350,7 @@
 		kfree(fb_info->sprite.addr);
 	registered_fb[i]=NULL;
 	num_registered_fb--;
+	class_simple_device_remove(MKDEV(FB_MAJOR, i));
 	return 0;
 }
 
@@ -1398,6 +1411,12 @@
 	devfs_mk_dir("fb");
 	if (register_chrdev(FB_MAJOR,"fb",&fb_fops))
 		printk("unable to get major %d for fb devs\n", FB_MAJOR);
+
+	fb_class = class_simple_create(THIS_MODULE, "graphics");
+	if (IS_ERR(fb_class)) {
+		printk(KERN_WARNING "Unable to create fb class; errno = %ld\n", PTR_ERR(fb_class));
+		fb_class = NULL;
+	}
 
 #ifdef CONFIG_FB_OF
 	if (ofonly) {

