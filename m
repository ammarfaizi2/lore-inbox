Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUGOAcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUGOAcm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266105AbUGOAcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:32:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:60139 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266010AbUGOAJP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:09:15 -0400
Subject: Re: [PATCH] I2C update for 2.6.8-rc1
In-Reply-To: <10898500272030@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Jul 2004 17:07:08 -0700
Message-Id: <10898500281194@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1784.13.5, 2004/07/08 16:07:27-07:00, lcapitulino@prefeitura.sp.gov.br

[PATCH] I2C: i2c/i2c-dev.c::i2c_dev_init() cleanup.

 This patch does the fallowing cleanup for
drivers/i2c/i2c-dev.c::i2c_dev_init():

*) in a error condition, return the error code of register_chrdev()
insted of -EIO;
*) adds missing audit for class_register();
*) in a error condition, only prints "Driver Initialisation Failed",
insted printing the cause. (Note that the error will be printed by
the return of the error code, and the information about what function
caused the problem need to be done by a debug code).

 Only compiled, lack of hardware.

Signed-off-by: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/i2c-dev.c |   33 +++++++++++++++++++++------------
 1 files changed, 21 insertions(+), 12 deletions(-)


diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	2004-07-14 17:00:12 -07:00
+++ b/drivers/i2c/i2c-dev.c	2004-07-14 17:00:12 -07:00
@@ -518,20 +518,29 @@
 
 	printk(KERN_INFO "i2c /dev entries driver\n");
 
-	if (register_chrdev(I2C_MAJOR,"i2c",&i2cdev_fops)) {
-		printk(KERN_ERR "i2c-dev.o: unable to get major %d for i2c bus\n",
-		       I2C_MAJOR);
-		return -EIO;
-	}
+	res = register_chrdev(I2C_MAJOR, "i2c", &i2cdev_fops);
+	if (res)
+		goto out;
+
+	res = class_register(&i2c_dev_class);
+	if (res)
+		goto out_unreg_chrdev;
+
+	res = i2c_add_driver(&i2cdev_driver);
+	if (res)
+		goto out_unreg_class;
+
 	devfs_mk_dir("i2c");
-	class_register(&i2c_dev_class);
-	if ((res = i2c_add_driver(&i2cdev_driver))) {
-		printk(KERN_ERR "i2c-dev.o: Driver registration failed, module not inserted.\n");
-		devfs_remove("i2c");
-		unregister_chrdev(I2C_MAJOR,"i2c");
-		return res;
-	}
+
 	return 0;
+
+out_unreg_class:
+	class_unregister(&i2c_dev_class);
+out_unreg_chrdev:
+	unregister_chrdev(I2C_MAJOR, "i2c");
+out:
+	printk(KERN_ERR "%s: Driver Initialisation failed", __FILE__);
+	return res;
 }
 
 static void __exit i2c_dev_exit(void)

