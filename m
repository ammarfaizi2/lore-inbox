Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUDHVN7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 17:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbUDHVN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 17:13:59 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:62608 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262215AbUDHVNz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 17:13:55 -0400
Date: Thu, 08 Apr 2004 14:13:01 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org, braam@cs.cmu.edu
cc: Hanna Linder <hannal@us.ibm.com>, greg@kroah.com, coda@cs.cmu.edu
Subject: Re: [PATCH 2.6.5] Add sysfs class support to fs/coda/psdev.c
Message-ID: <7970000.1081458781@dyn318071bld.beaverton.ibm.com>
In-Reply-To: <7290000.1081457670@dyn318071bld.beaverton.ibm.com>
References: <7290000.1081457670@dyn318071bld.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg reminded me you can't put a / in a file name (duh).

> +		class_simple_device_add(coda_psdev_class, MKDEV(CODA_PSDEV_MAJOR,i), 
> +				NULL, "coda/%d", i);

Here is the fixed patch:

diff -Nrup linux-2.6.5/fs/coda/psdev.c linux-2.6.5p/fs/coda/psdev.c
--- linux-2.6.5/fs/coda/psdev.c	2004-04-03 19:37:36.000000000 -0800
+++ linux-2.6.5p/fs/coda/psdev.c	2004-04-08 14:05:51.000000000 -0700
@@ -37,6 +37,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/smp_lock.h>
+#include <linux/device.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/poll.h>
@@ -61,6 +62,7 @@ unsigned long coda_timeout = 30; /* .. s
 
 
 struct venus_comm coda_comms[MAX_CODADEVS];
+static struct class_simple coda_psdev_class;
 
 /*
  * Device operations
@@ -358,20 +360,38 @@ static struct file_operations coda_psdev
 
 static int init_coda_psdev(void)
 {
-	int i;
+	int i, err = 0;
 	if (register_chrdev(CODA_PSDEV_MAJOR,"coda_psdev",
 				 &coda_psdev_fops)) {
               printk(KERN_ERR "coda_psdev: unable to get major %d\n", 
 		     CODA_PSDEV_MAJOR);
               return -EIO;
 	}
+	coda_psdev_class = class_simple_create(THIS_MODULE, "coda_psdev");
+	if (IS_ERR(coda_psdev_class)) {
+		err = PTR_ERR(coda_psdev_class);
+		goto out_chrdev;
+	}		
 	devfs_mk_dir ("coda");
 	for (i = 0; i < MAX_CODADEVS; i++) {
-		devfs_mk_cdev(MKDEV(CODA_PSDEV_MAJOR, i),
+		class_simple_device_add(coda_psdev_class, MKDEV(CODA_PSDEV_MAJOR,i), 
+				NULL, "cfs%d", i);
+		err = devfs_mk_cdev(MKDEV(CODA_PSDEV_MAJOR, i),
 				S_IFCHR|S_IRUSR|S_IWUSR, "coda/%d", i);
+		if (err)
+			goto out_class;
 	}
 	coda_sysctl_init();
-	return 0;
+	goto out;
+
+out_class:
+	for (i = 0; i < MAX_CODADEVS; i++) 
+		class_simple_device_remove(MKDEV(CODA_PSDEV_MAJOR, i));
+	class_simple_destroy(coda_psdev_class);
+out_chrdev:
+	unregister_chrdev(CODA_PSDEV_MAJOR, "coda_psdev");
+out:
+	return err;
 }
 
 
@@ -408,8 +428,11 @@ static int __init init_coda(void)
 	}
 	return 0;
 out:
-	for (i = 0; i < MAX_CODADEVS; i++)
+	for (i = 0; i < MAX_CODADEVS; i++) {
+		class_simple_device_remove(MKDEV(CODA_PSDEV_MAJOR, i));
 		devfs_remove("coda/%d", i);
+	}
+	class_simple_destroy(coda_psdev_class);
 	devfs_remove("coda");
 	unregister_chrdev(CODA_PSDEV_MAJOR,"coda_psdev");
 	coda_sysctl_clean();
@@ -427,8 +450,11 @@ static void __exit exit_coda(void)
         if ( err != 0 ) {
                 printk("coda: failed to unregister filesystem\n");
         }
-	for (i = 0; i < MAX_CODADEVS; i++)
+	for (i = 0; i < MAX_CODADEVS; i++) {
+		class_simple_device_remove(MKDEV(CODA_PSDEV_MAJOR, i));
 		devfs_remove("coda/%d", i);
+	}
+	class_simple_destroy(coda_psdev_class);
 	devfs_remove("coda");
 	unregister_chrdev(CODA_PSDEV_MAJOR, "coda_psdev");
 	coda_sysctl_clean();




