Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUDTSic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUDTSic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 14:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUDTSic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 14:38:32 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:15835 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263664AbUDTSi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 14:38:28 -0400
Date: Tue, 20 Apr 2004 11:36:04 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com, hannal@us.ibm.com, grant@torque.net
Subject: [PATCH 2.6.5 RFT] add class support to drivers/block/paride/pt.c
Message-ID: <451930000.1082486164@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This patch adds class support to pt.c which "the high-level driver for parallel port ATAPI tape
drives based on chips supported by the paride module." Which I dont have in order to test.

I have verified it compiles but can not test it. If someone who has the hardware could
I would appreciate it.

Hanna Linder
IBM Linux Technology Center
------------
diff -Nrup -Xdontdiff linux-2.6.5/drivers/block/paride/pt.c linux-2.6.5p/drivers/block/paride/pt.c
--- linux-2.6.5/drivers/block/paride/pt.c	2004-04-03 19:36:52.000000000 -0800
+++ linux-2.6.5p/drivers/block/paride/pt.c	2004-04-16 16:09:52.000000000 -0700
@@ -145,6 +145,7 @@ static int (*drives[4])[6] = {&drive0, &
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/mtio.h>
+#include <linux/device.h>
 
 #include <asm/uaccess.h>
 
@@ -260,6 +261,9 @@ static struct file_operations pt_fops = 
 	.release = pt_release,
 };
 
+/* sysfs class support */
+static struct class_simple *pt_class;
+
 static inline int status_reg(struct pi_adapter *pi)
 {
 	return pi_read_regr(pi, 1, 6);
@@ -959,33 +963,62 @@ static ssize_t pt_write(struct file *fil
 
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
@@ -993,9 +1026,12 @@ static void __exit pt_exit(void)
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


