Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbUATBSk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 20:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265328AbUATBRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 20:17:15 -0500
Received: from mail.kroah.org ([65.200.24.183]:25801 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265335AbUATBMj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:12:39 -0500
Subject: Re: [PATCH] Driver Core update and fixes for 2.6.1
In-Reply-To: <10745611602007@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 17:12:40 -0800
Message-Id: <10745611602245@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500, 2004/01/19 16:39:52-08:00, greg@kroah.com

[PATCH] LP: add sysfs class support for lp devices

Add sysfs class support for lp devices.

Based on a patch from Hanna Linder <hannal@us.ibm.com>


 drivers/char/lp.c |    6 ++++++
 1 files changed, 6 insertions(+)


diff -Nru a/drivers/char/lp.c b/drivers/char/lp.c
--- a/drivers/char/lp.c	Mon Jan 19 17:05:01 2004
+++ b/drivers/char/lp.c	Mon Jan 19 17:05:01 2004
@@ -145,6 +145,7 @@
 struct lp_struct lp_table[LP_NO];
 
 static unsigned int lp_count = 0;
+static struct class_simple *lp_class;
 
 #ifdef CONFIG_LP_CONSOLE
 static struct parport *console_registered; // initially NULL
@@ -795,6 +796,8 @@
 	if (reset)
 		lp_reset(nr);
 
+	class_simple_device_add(lp_class, MKDEV(LP_MAJOR, nr), NULL,
+				"lp%d", nr);
 	devfs_mk_cdev(MKDEV(LP_MAJOR, nr), S_IFCHR | S_IRUGO | S_IWUGO,
 			"printers/%d", nr);
 
@@ -897,6 +900,7 @@
 	}
 
 	devfs_mk_dir("printers");
+	lp_class = class_simple_create(THIS_MODULE, "printer");
 
 	if (parport_register_driver (&lp_driver)) {
 		printk (KERN_ERR "lp: unable to register with parport\n");
@@ -958,8 +962,10 @@
 			continue;
 		parport_unregister_device(lp_table[offset].dev);
 		devfs_remove("printers/%d", offset);
+		class_simple_device_remove(MKDEV(LP_MAJOR, offset));
 	}
 	devfs_remove("printers");
+	class_simple_destroy(lp_class);
 }
 
 __setup("lp=", lp_setup);

