Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264724AbUEFAPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264724AbUEFAPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 20:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264741AbUEFAPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 20:15:51 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:20449 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264724AbUEFAPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 20:15:42 -0400
Date: Wed, 05 May 2004 17:13:20 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: linux-net@vger.kernel.org, greg@kroah.com, hannal@us.ibm.com,
       kas@fi.muni.cz
Subject: [PATCH 2.6.6-rc3] Add class support to drivers/net/wan/cosa.c
Message-ID: <39490000.1083802400@dyn318071bld.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds sysfs class support to the Cosa driver. I have verified it
compiles but do not have the hardware to test it. If someone could that
would be helpful.

Thanks.

Hanna Linder
IBM Linux Technology Center
----
diff -Nrup -Xdontdiff linux-2.6.6-rc3/drivers/net/wan/cosa.c linux-2.6.6-rc3pcosa/drivers/net/wan/cosa.c
--- linux-2.6.6-rc3/drivers/net/wan/cosa.c	2004-04-27 18:35:04.000000000 -0700
+++ linux-2.6.6-rc3pcosa/drivers/net/wan/cosa.c	2004-05-05 16:01:56.000000000 -0700
@@ -93,6 +93,7 @@
 #include <linux/netdevice.h>
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
+#include <linux/device.h>
 
 #undef COSA_SLOW_IO	/* for testing purposes only */
 #undef REALLY_SLOW_IO
@@ -233,6 +234,9 @@ static int dma[MAX_CARDS+1];
 /* IRQ can be safely autoprobed */
 static int irq[MAX_CARDS+1] = { -1, -1, -1, -1, -1, -1, 0, };
 
+/* for class stuff*/
+static struct class_simple *cosa_class;
+
 #ifdef MODULE
 MODULE_PARM(io, "1-" __MODULE_STRING(MAX_CARDS) "i");
 MODULE_PARM_DESC(io, "The I/O bases of the COSA or SRP cards");
@@ -359,7 +363,7 @@ static void debug_status_out(struct cosa
 
 static int __init cosa_init(void)
 {
-	int i;
+	int i, err = 0;
 
 	printk(KERN_INFO "cosa v1.08 (c) 1997-2000 Jan Kasprzak <kas@fi.muni.cz>\n");
 #ifdef CONFIG_SMP
@@ -369,12 +373,14 @@ static int __init cosa_init(void)
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
@@ -384,15 +390,33 @@ static int __init cosa_init(void)
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
 
@@ -402,8 +426,11 @@ static void __exit cosa_exit(void)
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

