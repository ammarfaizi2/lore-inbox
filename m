Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVFUEoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVFUEoz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 00:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVFUCIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:08:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:40932 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261756AbVFTW7w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:52 -0400
Cc: gregkh@suse.de
Subject: [PATCH] class: convert the remaining class_simple users in the kernel to usee the new class api
In-Reply-To: <11193083633233@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:23 -0700
Message-Id: <11193083633382@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] class: convert the remaining class_simple users in the kernel to usee the new class api

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 1db560afe629b682c45a7f4ba7edf98b4ee28518
tree d48ed2d5458b86bf65c78f8e738c6510fdec3917
parent 5cebfb759cc75208c04590ad7f4485cdd822cf46
author gregkh@suse.de <gregkh@suse.de> Wed, 23 Mar 2005 10:02:26 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:11 -0700

 fs/coda/psdev.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -61,7 +61,7 @@ unsigned long coda_timeout = 30; /* .. s
 
 
 struct venus_comm coda_comms[MAX_CODADEVS];
-static struct class_simple *coda_psdev_class;
+static struct class *coda_psdev_class;
 
 /*
  * Device operations
@@ -363,14 +363,14 @@ static int init_coda_psdev(void)
 		     CODA_PSDEV_MAJOR);
               return -EIO;
 	}
-	coda_psdev_class = class_simple_create(THIS_MODULE, "coda");
+	coda_psdev_class = class_create(THIS_MODULE, "coda");
 	if (IS_ERR(coda_psdev_class)) {
 		err = PTR_ERR(coda_psdev_class);
 		goto out_chrdev;
 	}		
 	devfs_mk_dir ("coda");
 	for (i = 0; i < MAX_CODADEVS; i++) {
-		class_simple_device_add(coda_psdev_class, MKDEV(CODA_PSDEV_MAJOR,i), 
+		class_device_create(coda_psdev_class, MKDEV(CODA_PSDEV_MAJOR,i),
 				NULL, "cfs%d", i);
 		err = devfs_mk_cdev(MKDEV(CODA_PSDEV_MAJOR, i),
 				S_IFCHR|S_IRUSR|S_IWUSR, "coda/%d", i);
@@ -382,8 +382,8 @@ static int init_coda_psdev(void)
 
 out_class:
 	for (i = 0; i < MAX_CODADEVS; i++) 
-		class_simple_device_remove(MKDEV(CODA_PSDEV_MAJOR, i));
-	class_simple_destroy(coda_psdev_class);
+		class_device_destroy(coda_psdev_class, MKDEV(CODA_PSDEV_MAJOR, i));
+	class_destroy(coda_psdev_class);
 out_chrdev:
 	unregister_chrdev(CODA_PSDEV_MAJOR, "coda");
 out:
@@ -425,10 +425,10 @@ static int __init init_coda(void)
 	return 0;
 out:
 	for (i = 0; i < MAX_CODADEVS; i++) {
-		class_simple_device_remove(MKDEV(CODA_PSDEV_MAJOR, i));
+		class_device_destroy(coda_psdev_class, MKDEV(CODA_PSDEV_MAJOR, i));
 		devfs_remove("coda/%d", i);
 	}
-	class_simple_destroy(coda_psdev_class);
+	class_destroy(coda_psdev_class);
 	devfs_remove("coda");
 	unregister_chrdev(CODA_PSDEV_MAJOR, "coda");
 	coda_sysctl_clean();
@@ -447,10 +447,10 @@ static void __exit exit_coda(void)
                 printk("coda: failed to unregister filesystem\n");
         }
 	for (i = 0; i < MAX_CODADEVS; i++) {
-		class_simple_device_remove(MKDEV(CODA_PSDEV_MAJOR, i));
+		class_device_destroy(coda_psdev_class, MKDEV(CODA_PSDEV_MAJOR, i));
 		devfs_remove("coda/%d", i);
 	}
-	class_simple_destroy(coda_psdev_class);
+	class_destroy(coda_psdev_class);
 	devfs_remove("coda");
 	unregister_chrdev(CODA_PSDEV_MAJOR, "coda");
 	coda_sysctl_clean();

