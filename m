Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbUDORrM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbUDORq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:46:26 -0400
Received: from mail.kroah.org ([65.200.24.183]:25014 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263151AbUDORmM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:42:12 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core update for 2.6.6-rc1
In-Reply-To: <10820509121239@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 15 Apr 2004 10:41:53 -0700
Message-Id: <1082050913417@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.13, 2004/04/08 14:53:05-07:00, hannal@us.ibm.com

[PATCH] Add sysfs class support to fs/coda/psdev.c

Here is a patch to add class support to psdev.c.

I have verified it compiles and works.


 fs/coda/psdev.c |   36 +++++++++++++++++++++++++++++++-----
 1 files changed, 31 insertions(+), 5 deletions(-)


diff -Nru a/fs/coda/psdev.c b/fs/coda/psdev.c
--- a/fs/coda/psdev.c	Thu Apr 15 10:20:31 2004
+++ b/fs/coda/psdev.c	Thu Apr 15 10:20:31 2004
@@ -37,6 +37,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/smp_lock.h>
+#include <linux/device.h>
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/poll.h>
@@ -61,6 +62,7 @@
 
 
 struct venus_comm coda_comms[MAX_CODADEVS];
+static struct class_simple coda_psdev_class;
 
 /*
  * Device operations
@@ -358,20 +360,38 @@
 
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
 
 
@@ -408,8 +428,11 @@
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
@@ -427,8 +450,11 @@
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

