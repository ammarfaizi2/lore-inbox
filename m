Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUDINWW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 09:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUDINWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 09:22:22 -0400
Received: from linux-bt.org ([217.160.111.169]:8399 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S261273AbUDINWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 09:22:19 -0400
Subject: [PATCH] Add sysfs class support for CAPI
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg Kroah-Hartman <greg@kroah.com>, Karsten Keil <kkeil@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux ISDN Mailing List <isdn4linux@listserv.isdn4linux.de>
Content-Type: multipart/mixed; boundary="=-g0Rsep7QcurqfRWq4z3e"
Message-Id: <1081516925.13202.8.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 09 Apr 2004 15:22:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-g0Rsep7QcurqfRWq4z3e
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Greg,

here is a patch that adds class support to the ISDN CAPI module. Without
it udev won't create the /dev/capi20 device node.

Regards

Marcel


--=-g0Rsep7QcurqfRWq4z3e
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

===== drivers/isdn/capi/capi.c 1.51 vs edited =====
--- 1.51/drivers/isdn/capi/capi.c	Mon Mar 29 16:25:54 2004
+++ edited/drivers/isdn/capi/capi.c	Fri Apr  9 00:00:37 2004
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
@@ -1483,11 +1486,20 @@
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
@@ -1514,6 +1526,8 @@
 {
 	proc_exit();
 
+	class_simple_device_remove(MKDEV(capi_major, 0));
+	class_simple_destroy(capi_class);
 	unregister_chrdev(capi_major, "capi20");
 	devfs_remove("isdn/capi20");
 

--=-g0Rsep7QcurqfRWq4z3e--

