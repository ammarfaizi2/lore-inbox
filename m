Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264387AbUD0WyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264387AbUD0WyM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 18:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbUD0WyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 18:54:12 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:20439 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264387AbUD0WyF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 18:54:05 -0400
Date: Tue, 27 Apr 2004 15:52:28 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-parport@lists.infradead.org
cc: linux-kernel@vger.kernel.org, greg@kroah.com, hannal@us.ibm.com
Subject: [PATCH 2.6.6-rc1] Add class support to drivers/char/ppdev.c
Message-ID: <12810000.1083106348@dyn318071bld.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a patch to add class support to drivers/char/ppdev.c. I have verified
it compiles and works on my system. 

Please test or consider for inclusion.

Thanks

Hanna Linder
IBM Linux Technology Center
--------
diff -Nrup linux-2.6.6-rc1/drivers/char/ppdev.c linux-2.6.6-rc1p/drivers/char/ppdev.c
--- linux-2.6.6-rc1/drivers/char/ppdev.c	2004-04-14 18:36:01.000000000 -0700
+++ linux-2.6.6-rc1p/drivers/char/ppdev.c	2004-04-27 14:56:56.000000000 -0700
@@ -84,6 +84,8 @@ struct pp_struct {
 	long default_inactivity;
 };
 
+static struct class_simple *ppdev_class;
+
 /* pp_struct.flags bitfields */
 #define PP_CLAIMED    (1<<0)
 #define PP_EXCL       (1<<1)
@@ -752,29 +754,53 @@ static struct file_operations pp_fops = 
 
 static int __init ppdev_init (void)
 {
-	int i;
+	int i, err = 0;
 
 	if (register_chrdev (PP_MAJOR, CHRDEV, &pp_fops)) {
 		printk (KERN_WARNING CHRDEV ": unable to get major %d\n",
 			PP_MAJOR);
-		return -EIO;
+		err = -EIO;
+		goto out;
+	}
+	ppdev_class = class_simple_create(THIS_MODULE, CHRDEV);
+	if (IS_ERR(ppdev_class)) {
+		err = PTR_ERR(ppdev_class);
+		goto out_chrdev;
 	}
 	devfs_mk_dir("parports");
 	for (i = 0; i < PARPORT_MAX; i++) {
-		devfs_mk_cdev(MKDEV(PP_MAJOR, i),
+		class_simple_device_add(ppdev_class, MKDEV(PP_MAJOR, i), 
+				NULL, "parport%d", i);
+		err = devfs_mk_cdev(MKDEV(PP_MAJOR, i),
 				S_IFCHR | S_IRUGO | S_IWUGO, "parports/%d", i);
+		if (err) 
+			goto out_class;
 	}
 
 	printk (KERN_INFO PP_VERSION "\n");
-	return 0;
+	err = 0;
+	goto out;
+
+out_class:
+	for (i = 0; i < PARPORT_MAX; i++) 
+		class_simple_device_remove(MKDEV(PP_MAJOR, i));
+	class_simple_destroy(ppdev_class);
+out_chrdev:
+	unregister_chrdev(PP_MAJOR, CHRDEV);
+out:
+	return err;
+
 }
 
 static void __exit ppdev_cleanup (void)
 {
 	int i;
 	/* Clean up all parport stuff */
-	for (i = 0; i < PARPORT_MAX; i++)
+	for (i = 0; i < PARPORT_MAX; i++) {
+		class_simple_device_remove(MKDEV(PP_MAJOR, i));
 		devfs_remove("parports/%d", i);
+	}
+	class_simple_destroy(ppdev_class);
 	devfs_remove("parports");
 	unregister_chrdev (PP_MAJOR, CHRDEV);
 }

