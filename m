Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263141AbUDORrL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263801AbUDORqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:46:37 -0400
Received: from mail.kroah.org ([65.200.24.183]:24502 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263141AbUDORmL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:42:11 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core update for 2.6.6-rc1
In-Reply-To: <1082050913417@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 15 Apr 2004 10:41:53 -0700
Message-Id: <10820509132396@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.14, 2004/04/09 11:32:55-07:00, marcel@holtmann.org

[PATCH] Add sysfs class support for CAPI

here is a patch that adds class support to the ISDN CAPI module. Without
it udev won't create the /dev/capi20 device node.


 drivers/isdn/capi/capi.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+)


diff -Nru a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
--- a/drivers/isdn/capi/capi.c	Thu Apr 15 10:20:26 2004
+++ b/drivers/isdn/capi/capi.c	Thu Apr 15 10:20:26 2004
@@ -37,6 +37,7 @@
 #include <linux/capi.h>
 #include <linux/kernelcapi.h>
 #include <linux/init.h>
+#include <linux/device.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/isdn/capiutil.h>
 #include <linux/isdn/capicmd.h>
@@ -56,6 +57,8 @@
 
 /* -------- driver information -------------------------------------- */
 
+static struct class_simple *capi_class;
+
 int capi_major = 68;		/* allocated */
 #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
 #define CAPINC_NR_PORTS	32
@@ -1479,11 +1482,20 @@
 		return -EIO;
 	}
 
+	capi_class = class_simple_create(THIS_MODULE, "capi");
+	if (IS_ERR(capi_class)) {
+		unregister_chrdev(capi_major, "capi20");
+		return PTR_ERR(capi_class);
+	}
+
+	class_simple_device_add(capi_class, MKDEV(capi_major, 0), NULL, "capi20");
 	devfs_mk_cdev(MKDEV(capi_major, 0), S_IFCHR | S_IRUSR | S_IWUSR,
 			"isdn/capi20");
 
 #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
 	if (capinc_tty_init() < 0) {
+		class_simple_device_remove(MKDEV(capi_major, 0));
+		class_simple_destroy(capi_class);
 		unregister_chrdev(capi_major, "capi20");
 		return -ENOMEM;
 	}
@@ -1510,6 +1522,8 @@
 {
 	proc_exit();
 
+	class_simple_device_remove(MKDEV(capi_major, 0));
+	class_simple_destroy(capi_class);
 	unregister_chrdev(capi_major, "capi20");
 	devfs_remove("isdn/capi20");
 

