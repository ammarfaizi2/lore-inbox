Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263126AbUEOBWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUEOBWq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 21:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbUENXIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:08:51 -0400
Received: from mail.kroah.org ([65.200.24.183]:50908 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263126AbUENXIB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:08:01 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.6
In-Reply-To: <10845760412992@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 14 May 2004 16:07:21 -0700
Message-Id: <10845760411194@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.5.13, 2004/05/02 20:28:38-07:00, sebek64@post.cz

[PATCH] Class support for ppdev.c


 drivers/char/ppdev.c |   45 +++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 43 insertions(+), 2 deletions(-)


diff -Nru a/drivers/char/ppdev.c b/drivers/char/ppdev.c
--- a/drivers/char/ppdev.c	Fri May 14 15:59:42 2004
+++ b/drivers/char/ppdev.c	Fri May 14 15:59:42 2004
@@ -59,6 +59,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/device.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/ioctl.h>
 #include <linux/parport.h>
@@ -739,6 +740,8 @@
 	return mask;
 }
 
+static struct class_simple *ppdev_class;
+
 static struct file_operations pp_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
@@ -750,23 +753,59 @@
 	.release	= pp_release,
 };
 
+static void pp_attach(struct parport *port)
+{
+	class_simple_device_add(ppdev_class, MKDEV(PP_MAJOR, port->number),
+			NULL, "parport%d", port->number);
+}
+
+static void pp_detach(struct parport *port)
+{
+	class_simple_device_remove(MKDEV(PP_MAJOR, port->number));
+}
+
+static struct parport_driver pp_driver = {
+	.name		= CHRDEV,
+	.attach		= pp_attach,
+	.detach		= pp_detach,
+};
+
 static int __init ppdev_init (void)
 {
-	int i;
+	int i, err = 0;
 
 	if (register_chrdev (PP_MAJOR, CHRDEV, &pp_fops)) {
 		printk (KERN_WARNING CHRDEV ": unable to get major %d\n",
 			PP_MAJOR);
 		return -EIO;
 	}
+	ppdev_class = class_simple_create(THIS_MODULE, CHRDEV);
+	if (IS_ERR(ppdev_class)) {
+		err = PTR_ERR(ppdev_class);
+		goto out_chrdev;
+	}
 	devfs_mk_dir("parports");
 	for (i = 0; i < PARPORT_MAX; i++) {
 		devfs_mk_cdev(MKDEV(PP_MAJOR, i),
 				S_IFCHR | S_IRUGO | S_IWUGO, "parports/%d", i);
 	}
+	if (parport_register_driver(&pp_driver)) {
+		printk (KERN_WARNING CHRDEV ": unable to register with parport\n");
+		goto out_class;
+	}
 
 	printk (KERN_INFO PP_VERSION "\n");
-	return 0;
+	goto out;
+
+out_class:
+	for (i = 0; i < PARPORT_MAX; i++)
+		devfs_remove("parports/%d", i);
+	devfs_remove("parports");
+	class_simple_destroy(ppdev_class);
+out_chrdev:
+	unregister_chrdev(PP_MAJOR, CHRDEV);
+out:
+	return err;
 }
 
 static void __exit ppdev_cleanup (void)
@@ -775,7 +814,9 @@
 	/* Clean up all parport stuff */
 	for (i = 0; i < PARPORT_MAX; i++)
 		devfs_remove("parports/%d", i);
+	parport_unregister_driver(&pp_driver);
 	devfs_remove("parports");
+	class_simple_destroy(ppdev_class);
 	unregister_chrdev (PP_MAJOR, CHRDEV);
 }
 

