Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263156AbUEOBWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbUEOBWo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 21:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUENXJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:09:26 -0400
Received: from mail.kroah.org ([65.200.24.183]:51420 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263156AbUENXID convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:08:03 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.6
In-Reply-To: <1084576042804@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 14 May 2004 16:07:22 -0700
Message-Id: <1084576042499@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.5.16, 2004/05/02 20:29:41-07:00, hannal@us.ibm.com

[PATCH] add class support to drivers/block/paride/pt.c

This patch adds class support to pt.c which "the high-level driver for parallel
port ATAPI tape drives based on chips supported by the paride module." Which I
dont have in order to test.

I have verified it compiles but can not test it. If someone who has the
hardware could I would appreciate it.


 drivers/block/paride/pt.c |   54 ++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 45 insertions(+), 9 deletions(-)


diff -Nru a/drivers/block/paride/pt.c b/drivers/block/paride/pt.c
--- a/drivers/block/paride/pt.c	Fri May 14 15:58:58 2004
+++ b/drivers/block/paride/pt.c	Fri May 14 15:58:58 2004
@@ -145,6 +145,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/mtio.h>
+#include <linux/device.h>
 
 #include <asm/uaccess.h>
 
@@ -260,6 +261,9 @@
 	.release = pt_release,
 };
 
+/* sysfs class support */
+static struct class_simple *pt_class;
+
 static inline int status_reg(struct pi_adapter *pi)
 {
 	return pi_read_regr(pi, 1, 6);
@@ -959,33 +963,62 @@
 
 static int __init pt_init(void)
 {
-	int unit;
+	int unit, err = 0;
 
-	if (disable)
-		return -1;
+	if (disable) {
+		err = -1;
+		goto out;
+	}
 
-	if (pt_detect())
-		return -1;
+	if (pt_detect()) {
+		err = -1;
+		goto out;
+	}
 
 	if (register_chrdev(major, name, &pt_fops)) {
 		printk("pt_init: unable to get major number %d\n", major);
 		for (unit = 0; unit < PT_UNITS; unit++)
 			if (pt[unit].present)
 				pi_release(pt[unit].pi);
-		return -1;
+		err = -1;
+		goto out;
+	}
+	pt_class = class_simple_create(THIS_MODULE, "pt");
+	if (IS_ERR(pt_class)) {
+		err = PTR_ERR(pt_class);
+		goto out_chrdev;
 	}
 
 	devfs_mk_dir("pt");
 	for (unit = 0; unit < PT_UNITS; unit++)
 		if (pt[unit].present) {
-			devfs_mk_cdev(MKDEV(major, unit),
+			class_simple_device_add(pt_class, MKDEV(major, unit), 
+					NULL, "pt%d", unit);
+			err = devfs_mk_cdev(MKDEV(major, unit),
 				      S_IFCHR | S_IRUSR | S_IWUSR,
 				      "pt/%d", unit);
-			devfs_mk_cdev(MKDEV(major, unit + 128),
+			if (err) {
+				class_simple_device_remove(MKDEV(major, unit));
+				goto out_class;
+			}
+			class_simple_device_add(pt_class, MKDEV(major, unit + 128),
+					NULL, "pt%dn", unit);
+			err = devfs_mk_cdev(MKDEV(major, unit + 128),
 				      S_IFCHR | S_IRUSR | S_IWUSR,
 				      "pt/%dn", unit);
+			if (err) {
+				class_simple_device_remove(MKDEV(major, unit + 128));
+				goto out_class;
+			}
 		}
-	return 0;
+	goto out;
+
+out_class:
+	class_simple_destroy(pt_class);
+out_chrdev:
+	unregister_chrdev(major, "pt");
+out:
+	return err;
 }
 
 static void __exit pt_exit(void)
@@ -993,9 +1026,12 @@
 	int unit;
 	for (unit = 0; unit < PT_UNITS; unit++)
 		if (pt[unit].present) {
+			class_simple_device_remove(MKDEV(major, unit));
 			devfs_remove("pt/%d", unit);
+			class_simple_device_remove(MKDEV(major, unit + 128));
 			devfs_remove("pt/%dn", unit);
 		}
+	class_simple_destroy(pt_class);
 	devfs_remove("pt");
 	unregister_chrdev(major, name);
 	for (unit = 0; unit < PT_UNITS; unit++)

