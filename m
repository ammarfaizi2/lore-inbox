Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbUAOUqR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 15:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbUAOUpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 15:45:02 -0500
Received: from mail.kroah.org ([65.200.24.183]:25819 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262913AbUAOUoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 15:44:21 -0500
Date: Thu, 15 Jan 2004 12:41:38 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] add class support for lp devices [03/10]
Message-ID: <20040115204138.GD22199@kroah.com>
References: <20040115204048.GA22199@kroah.com> <20040115204111.GB22199@kroah.com> <20040115204125.GC22199@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115204125.GC22199@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add class support for lp devices.

Based on a patch from Hanna Linder <hannal@us.ibm.com>

diff -Nru a/drivers/char/lp.c b/drivers/char/lp.c
--- a/drivers/char/lp.c	Thu Jan 15 12:13:07 2004
+++ b/drivers/char/lp.c	Thu Jan 15 12:13:07 2004
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
