Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbULJHCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbULJHCN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 02:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbULJHCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 02:02:13 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:27036 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261711AbULJHCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 02:02:02 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.6.10-rc3] Configure the maximum number of loopback devices
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 Dec 2004 18:01:48 +1100
Message-ID: <17387.1102662108@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux juke box servers can have more than 256 images loaded, so make
the maximum number of loopback devices a config option.  The default is
256 (no change).

Signed-off-by: Keith Owens <kaos@ocs.com.au>

Index: linux/drivers/block/Kconfig
===================================================================
--- linux.orig/drivers/block/Kconfig	Thu Dec  9 16:52:50 2004
+++ linux/drivers/block/Kconfig	Fri Dec 10 17:02:14 2004
@@ -251,6 +251,14 @@ config BLK_DEV_LOOP
 
 	  Most users will answer N here.
 
+config BLK_DEV_LOOP_MAX
+	int "Maximum number of loopback devices" if BLK_DEV_LOOP
+	default "256"
+	help
+          The default maximum number of loopback devices is 256. Set a
+          larger maximum if you need more than 256 loopback mounts.
+          Most users should take the default value.
+
 config BLK_DEV_CRYPTOLOOP
 	tristate "Cryptoloop Support"
 	select CRYPTO
Index: linux/drivers/block/loop.c
===================================================================
--- linux.orig/drivers/block/loop.c	Thu Dec  9 16:52:27 2004
+++ linux/drivers/block/loop.c	Fri Dec 10 17:48:49 2004
@@ -43,6 +43,9 @@
  * - Advisory locking is ignored here.
  * - Should use an own CAP_* category instead of CAP_SYS_ADMIN
  *
+ * Make the maximum loop count a config variable.
+ * Keith Owens <kaos@ocs.com.au>, Dec 2004
+ *
  */
 
 #include <linux/config.h>
@@ -67,6 +70,7 @@
 #include <linux/writeback.h>
 #include <linux/buffer_head.h>		/* for invalidate_bdev() */
 #include <linux/completion.h>
+#include <linux/vmalloc.h>
 
 #include <asm/uaccess.h>
 
@@ -1074,7 +1078,7 @@ static struct block_device_operations lo
  * And now the modules code and kernel interface.
  */
 module_param(max_loop, int, 0);
-MODULE_PARM_DESC(max_loop, "Maximum number of loop devices (1-256)");
+MODULE_PARM_DESC(max_loop, "Maximum number of loop devices (1-" __stringify(CONFIG_BLK_DEV_LOOP_MAX) ")");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
 
@@ -1118,21 +1122,21 @@ int __init loop_init(void)
 {
 	int	i;
 
-	if (max_loop < 1 || max_loop > 256) {
+	if (max_loop < 1 || max_loop > CONFIG_BLK_DEV_LOOP_MAX) {
 		printk(KERN_WARNING "loop: invalid max_loop (must be between"
-				    " 1 and 256), using default (8)\n");
+				    " 1 and " __stringify(CONFIG_BLK_DEV_LOOP_MAX) "), using default (8)\n");
 		max_loop = 8;
 	}
 
 	if (register_blkdev(LOOP_MAJOR, "loop"))
 		return -EIO;
 
-	loop_dev = kmalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);
+	loop_dev = vmalloc(max_loop * sizeof(*loop_dev));
 	if (!loop_dev)
 		goto out_mem1;
-	memset(loop_dev, 0, max_loop * sizeof(struct loop_device));
+	memset(loop_dev, 0, max_loop * sizeof(*loop_dev));
 
-	disks = kmalloc(max_loop * sizeof(struct gendisk *), GFP_KERNEL);
+	disks = vmalloc(max_loop * sizeof(*disks));
 	if (!disks)
 		goto out_mem2;
 
@@ -1180,9 +1184,9 @@ out_mem4:
 out_mem3:
 	while (i--)
 		put_disk(disks[i]);
-	kfree(disks);
+	vfree(disks);
 out_mem2:
-	kfree(loop_dev);
+	vfree(loop_dev);
 out_mem1:
 	unregister_blkdev(LOOP_MAJOR, "loop");
 	printk(KERN_ERR "loop: ran out of memory\n");
@@ -1202,8 +1206,8 @@ void loop_exit(void)
 	if (unregister_blkdev(LOOP_MAJOR, "loop"))
 		printk(KERN_WARNING "loop: cannot unregister blkdev\n");
 
-	kfree(disks);
-	kfree(loop_dev);
+	vfree(disks);
+	vfree(loop_dev);
 }
 
 module_init(loop_init);

