Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264319AbUENXOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264319AbUENXOl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUENXNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:13:47 -0400
Received: from mail.kroah.org ([65.200.24.183]:59100 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264305AbUENXIN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:08:13 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.6
In-Reply-To: <10845760432011@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 14 May 2004 16:07:23 -0700
Message-Id: <10845760433004@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.5.24, 2004/05/11 14:31:21-07:00, hannal@us.ibm.com

[PATCH] Add class support to drivers/net/wan/cosa.c

This patch adds sysfs class support to the Cosa driver. I have verified it
compiles but do not have the hardware to test it. If someone could that
would be helpful.


 drivers/net/wan/cosa.c |   41 ++++++++++++++++++++++++++++++++++-------
 1 files changed, 34 insertions(+), 7 deletions(-)


diff -Nru a/drivers/net/wan/cosa.c b/drivers/net/wan/cosa.c
--- a/drivers/net/wan/cosa.c	Fri May 14 15:56:57 2004
+++ b/drivers/net/wan/cosa.c	Fri May 14 15:56:57 2004
@@ -93,6 +93,7 @@
 #include <linux/netdevice.h>
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
+#include <linux/device.h>
 
 #undef COSA_SLOW_IO	/* for testing purposes only */
 #undef REALLY_SLOW_IO
@@ -233,6 +234,9 @@
 /* IRQ can be safely autoprobed */
 static int irq[MAX_CARDS+1] = { -1, -1, -1, -1, -1, -1, 0, };
 
+/* for class stuff*/
+static struct class_simple *cosa_class;
+
 #ifdef MODULE
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_CARDS) "i");
 MODULE_PARM_DESC(io, "The I/O bases of the COSA or SRP cards");
@@ -359,7 +363,7 @@
 
 static int __init cosa_init(void)
 {
-	int i;
+	int i, err = 0;
 
 	printk(KERN_INFO "cosa v1.08 (c) 1997-2000 Jan Kasprzak <kas@fi.muni.cz>\n");
 #ifdef CONFIG_SMP
@@ -369,12 +373,14 @@
 		if (register_chrdev(cosa_major, "cosa", &cosa_fops)) {
 			printk(KERN_WARNING "cosa: unable to get major %d\n",
 				cosa_major);
-			return -EIO;
+			err = -EIO;
+			goto out;
 		}
 	} else {
 		if (!(cosa_major=register_chrdev(0, "cosa", &cosa_fops))) {
 			printk(KERN_WARNING "cosa: unable to register chardev\n");
-			return -EIO;
+			err = -EIO;
+			goto out;
 		}
 	}
 	for (i=0; i<MAX_CARDS; i++)
@@ -384,15 +390,33 @@
 	if (!nr_cards) {
 		printk(KERN_WARNING "cosa: no devices found.\n");
 		unregister_chrdev(cosa_major, "cosa");
-		return -ENODEV;
+		err = -ENODEV;
+		goto out;
 	}
 	devfs_mk_dir("cosa");
+	cosa_class = class_simple_create(THIS_MODULE, "cosa");
+	if (IS_ERR(cosa_class)) {
+		err = PTR_ERR(cosa_class);
+		goto out_chrdev;
+	}
 	for (i=0; i<nr_cards; i++) {
-		devfs_mk_cdev(MKDEV(cosa_major, i),
+		class_simple_device_add(cosa_class, MKDEV(cosa_major, i),
+				NULL, "cosa%d", i);
+		err = devfs_mk_cdev(MKDEV(cosa_major, i),
 				S_IFCHR|S_IRUSR|S_IWUSR,
 				"cosa/%d", i);
+		if (err) {
+			class_simple_device_remove(MKDEV(cosa_major, i));
+			goto out_chrdev;		
+		}
 	}
-	return 0;
+	err = 0;
+	goto out;
+	
+out_chrdev:
+	unregister_chrdev(cosa_major, "cosa");
+out:
+	return err;
 }
 module_init(cosa_init);
 
@@ -402,8 +426,11 @@
 	int i;
 	printk(KERN_INFO "Unloading the cosa module\n");
 
-	for (i=0; i<nr_cards; i++)
+	for (i=0; i<nr_cards; i++) {
+		class_simple_device_remove(MKDEV(cosa_major, i));
 		devfs_remove("cosa/%d", i);
+	}
+	class_simple_destroy(cosa_class);
 	devfs_remove("cosa");
 	for (cosa=cosa_cards; nr_cards--; cosa++) {
 		/* Clean up the per-channel data */

