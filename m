Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUDMRcH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 13:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263649AbUDMRcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 13:32:07 -0400
Received: from pra69-d130.gd.dial-up.cz ([193.85.69.130]:26496 "EHLO
	penguin.localdomain") by vger.kernel.org with ESMTP id S263646AbUDMR3u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 13:29:50 -0400
Date: Tue, 13 Apr 2004 19:29:24 +0200
To: Greg KH <greg@kroah.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       tim@cyberelk.net
Subject: Re: [PATCH 2.6] Class support for ppdev.c
Message-ID: <20040413172924.GA2466@penguin.localdomain>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
	tim@cyberelk.net
References: <20040410135115.GA3612@penguin.localdomain> <20040410170148.GI1317@kroah.com> <20040410180636.GB3612@penguin.localdomain> <20040410194601.GC3612@penguin.localdomain> <20040410202858.GU31500@parcelfarce.linux.theplanet.co.uk> <20040411082553.GA2499@penguin.localdomain> <20040412185121.GD21502@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040412185121.GD21502@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 11:51:21AM -0700, Greg KH wrote:
> On Sun, Apr 11, 2004 at 10:25:53AM +0200, Marcel Sebek wrote:
> Looks much better, thanks.  But please don't modify the current devfs
> usage, those users will generally not like that.  Can you redo this
> patch to only add the sysfs changes?
> 

diff -urN linux-2.6/drivers/char/ppdev.c linux-2.6-new/drivers/char/ppdev.c
--- linux-2.6/drivers/char/ppdev.c	2004-04-13 19:17:12.000000000 +0200
+++ linux-2.6-new/drivers/char/ppdev.c	2004-04-13 19:25:50.000000000 +0200
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

-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E

