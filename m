Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTFOQFo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTFOQFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:05:43 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:10247 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S262323AbTFOQFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:05:42 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.70: raw.c devfs support
Date: Sun, 15 Jun 2003 20:18:52 +0400
User-Agent: KMail/1.5
Cc: devfs@oss.sgi.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sxJ7+u4mjwoEybC"
Message-Id: <200306152018.52602.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_sxJ7+u4mjwoEybC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Trivial patch to add devfs support to raw.c. Similar patch has been posted for 
2.4 but apparently never applied.

-andrey

--Boundary-00=_sxJ7+u4mjwoEybC
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.5.70-raw.devfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.5.70-raw.devfs.patch"

--- linux-2.5.70/drivers/char/raw.c.devfs	2003-06-01 11:49:51.000000000 +0400
+++ linux-2.5.70/drivers/char/raw.c	2003-06-15 19:23:20.000000000 +0400
@@ -10,6 +10,7 @@
 
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/devfs_fs_kernel.h>
 #include <linux/major.h>
 #include <linux/blkdev.h>
 #include <linux/module.h>
@@ -258,12 +259,27 @@ static struct file_operations raw_ctl_fo
 
 static int __init raw_init(void)
 {
+	int i;
+
 	register_chrdev(RAW_MAJOR, "raw", &raw_fops);
+	devfs_mk_cdev(MKDEV(RAW_MAJOR, 0),
+		      S_IFCHR | S_IRUGO | S_IWUGO,
+		      "raw/rawctl");
+	for (i = 0; i < MAX_RAW_MINORS; i++)
+		devfs_mk_cdev(MKDEV(RAW_MAJOR, i),
+			      S_IFCHR | S_IRUGO | S_IWUGO,
+			      "raw/raw%d", i);
 	return 0;
 }
 
 static void __exit raw_exit(void)
 {
+	int i;
+
+	for (i = 0; i < MAX_RAW_MINORS; i++)
+		devfs_remove("raw/raw%d", i);
+	devfs_remove("raw/rawctl");
+	devfs_remove("raw");
 	unregister_chrdev(RAW_MAJOR, "raw");
 }
 

--Boundary-00=_sxJ7+u4mjwoEybC--

