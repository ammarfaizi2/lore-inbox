Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbTEZRVL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTEZRVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:21:07 -0400
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:35283 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id S261864AbTEZRTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:19:18 -0400
Date: Mon, 26 May 2003 19:31:31 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (9/10): tape device driver.
Message-ID: <20030526173131.GJ3748@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug fixes for the s390 tape device driver:
 - Remove tapechar_init() from mem.c. It is called via module_init anyway.
 - Remove unnecessary #include <version.h>
 - Make tape_block compile. Add fixme.
 - Export symbols needed by tape discipline drivers.

diffstat:
 drivers/char/mem.c             |    3 ---
 drivers/s390/char/tape_34xx.c  |    5 ++---
 drivers/s390/char/tape_block.c |   17 +++++++++++------
 drivers/s390/char/tape_char.c  |    5 +----
 drivers/s390/char/tape_core.c  |   10 +++++++---
 drivers/s390/char/tape_proc.c  |    1 -
 drivers/s390/char/tape_std.c   |    1 -
 7 files changed, 21 insertions(+), 21 deletions(-)

diff -urN linux-2.5/drivers/char/mem.c linux-2.5-s390/drivers/char/mem.c
--- linux-2.5/drivers/char/mem.c	Mon May 26 19:20:26 2003
+++ linux-2.5-s390/drivers/char/mem.c	Mon May 26 19:20:47 2003
@@ -707,9 +707,6 @@
 #ifdef CONFIG_FTAPE
 	ftape_init();
 #endif
-#if defined(CONFIG_S390_TAPE) && defined(CONFIG_S390_TAPE_CHAR)
-	tapechar_init();
-#endif
 	return 0;
 }
 
diff -urN linux-2.5/drivers/s390/char/tape_34xx.c linux-2.5-s390/drivers/s390/char/tape_34xx.c
--- linux-2.5/drivers/s390/char/tape_34xx.c	Mon May  5 01:53:12 2003
+++ linux-2.5-s390/drivers/s390/char/tape_34xx.c	Mon May 26 19:20:47 2003
@@ -10,7 +10,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/bio.h>
@@ -1042,7 +1041,7 @@
 {
 	int rc;
 
-	DBF_EVENT(3, "34xx init: $Revision: 1.7 $\n");
+	DBF_EVENT(3, "34xx init: $Revision: 1.8 $\n");
 	/* Register driver for 3480/3490 tapes. */
 	rc = ccw_driver_register(&tape_34xx_driver);
 	if (rc)
@@ -1061,7 +1060,7 @@
 MODULE_DEVICE_TABLE(ccw, tape_34xx_ids);
 MODULE_AUTHOR("(C) 2001-2002 IBM Deutschland Entwicklung GmbH");
 MODULE_DESCRIPTION("Linux on zSeries channel attached 3480 tape "
-		   "device driver ($Revision: 1.7 $)");
+		   "device driver ($Revision: 1.8 $)");
 MODULE_LICENSE("GPL");
 
 module_init(tape_34xx_init);
diff -urN linux-2.5/drivers/s390/char/tape_block.c linux-2.5-s390/drivers/s390/char/tape_block.c
--- linux-2.5/drivers/s390/char/tape_block.c	Mon May  5 01:53:36 2003
+++ linux-2.5-s390/drivers/s390/char/tape_block.c	Mon May 26 19:20:47 2003
@@ -237,14 +237,13 @@
 	blk_queue_segment_boundary(q, -1L);
 
 	disk->major = tapeblock_major;
-	disk->first_minor = i;
+	disk->first_minor = device->first_minor;
 	disk->fops = &tapeblock_fops;
 	disk->private_data = device;
 	disk->queue = q;
-	set_capacity(disk, size);
+	//set_capacity(disk, size);
 
-	sprintf(disk->disk_name, "tBLK%d", i);
-	sprintf(disk->disk_name, "tBLK/%d", i);
+	sprintf(disk->disk_name, "tBLK/%d", device->first_minor / TAPE_MINORS_PER_DEV);
 
 	add_disk(disk);
 	d->disk = disk;
@@ -302,10 +301,16 @@
 static int
 tapeblock_open(struct inode *inode, struct file *filp)
 {
-	struct gendisk *disk = inp->i_bdev->bd_disk;
+	struct gendisk *disk = inode->i_bdev->bd_disk;
 	struct tape_device *device = disk->private_data;
 	int rc;
 
+	/*
+	 * FIXME: this new tapeblock_open function is from 2.5.69.
+	 * It doesn't do tape_get_device anymore but picks the device
+	 * pointer from disk->private_data. It is stored in 
+	 * tapeblock_setup_device but WITHOUT proper ref-counting.
+	 */
 	rc = tape_open(device);
 	if (rc)
 		goto put_device;
@@ -333,7 +338,7 @@
 static int
 tapeblock_release(struct inode *inode, struct file *filp)
 {
-	struct gendisk *disk = inp->i_bdev->bd_disk;
+	struct gendisk *disk = inode->i_bdev->bd_disk;
 	struct tape_device *device = disk->private_data;
 
 	tape_release(device);
diff -urN linux-2.5/drivers/s390/char/tape_char.c linux-2.5-s390/drivers/s390/char/tape_char.c
--- linux-2.5/drivers/s390/char/tape_char.c	Mon May  5 01:53:36 2003
+++ linux-2.5-s390/drivers/s390/char/tape_char.c	Mon May 26 19:20:47 2003
@@ -37,6 +37,7 @@
 
 static struct file_operations tape_fops =
 {
+	.owner = THIS_MODULE,
 	.read = tapechar_read,
 	.write = tapechar_write,
 	.ioctl = tapechar_ioctl,
@@ -237,13 +238,11 @@
 	struct tape_device *device;
 	int minor, rc;
 
-	MOD_INC_USE_COUNT;
 	if (major(filp->f_dentry->d_inode->i_rdev) != tapechar_major)
 		return -ENODEV;
 	minor = minor(filp->f_dentry->d_inode->i_rdev);
 	device = tape_get_device(minor / TAPE_MINORS_PER_DEV);
 	if (IS_ERR(device)) {
-		MOD_DEC_USE_COUNT;
 		return PTR_ERR(device);
 	}
 	DBF_EVENT(6, "TCHAR:open: %x\n", minor(inode->i_rdev));
@@ -257,7 +256,6 @@
 		tape_release(device);
 	}
 	tape_put_device(device);
-	MOD_DEC_USE_COUNT;
 	return rc;
 }
 
@@ -293,7 +291,6 @@
 	tape_release(device);
 	tape_unassign(device);
 	tape_put_device(device);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
diff -urN linux-2.5/drivers/s390/char/tape_core.c linux-2.5-s390/drivers/s390/char/tape_core.c
--- linux-2.5/drivers/s390/char/tape_core.c	Mon May  5 01:53:08 2003
+++ linux-2.5-s390/drivers/s390/char/tape_core.c	Mon May 26 19:20:47 2003
@@ -11,7 +11,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>	     // for kernel parameters
 #include <linux/kmod.h>	     // for requesting modules
@@ -904,7 +903,7 @@
 {
 	tape_dbf_area = debug_register ( "tape", 1, 2, 3*sizeof(long));
 	debug_register_view(tape_dbf_area, &debug_sprintf_view);
-	DBF_EVENT(3, "tape init: ($Revision: 1.23 $)\n");
+	DBF_EVENT(3, "tape init: ($Revision: 1.25 $)\n");
 	tape_proc_init();
 	tapechar_init ();
 	tapeblock_init ();
@@ -929,12 +928,17 @@
 MODULE_AUTHOR("(C) 2001 IBM Deutschland Entwicklung GmbH by Carsten Otte and "
 	      "Michael Holzheu (cotte@de.ibm.com,holzheu@de.ibm.com)");
 MODULE_DESCRIPTION("Linux on zSeries channel attached "
-		   "tape device driver ($Revision: 1.23 $)");
+		   "tape device driver ($Revision: 1.25 $)");
 
 module_init(tape_init);
 module_exit(tape_exit);
 
 EXPORT_SYMBOL(tape_dbf_area);
+EXPORT_SYMBOL(tape_generic_remove);
+EXPORT_SYMBOL(tape_disable_device);
+EXPORT_SYMBOL(tape_generic_probe);
+EXPORT_SYMBOL(tape_enable_device);
+EXPORT_SYMBOL(tape_put_device);
 EXPORT_SYMBOL(tape_state_verbose);
 EXPORT_SYMBOL(tape_op_verbose);
 EXPORT_SYMBOL(tape_state_set);
diff -urN linux-2.5/drivers/s390/char/tape_proc.c linux-2.5-s390/drivers/s390/char/tape_proc.c
--- linux-2.5/drivers/s390/char/tape_proc.c	Mon May  5 01:53:13 2003
+++ linux-2.5-s390/drivers/s390/char/tape_proc.c	Mon May 26 19:20:47 2003
@@ -12,7 +12,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/seq_file.h>
diff -urN linux-2.5/drivers/s390/char/tape_std.c linux-2.5-s390/drivers/s390/char/tape_std.c
--- linux-2.5/drivers/s390/char/tape_std.c	Mon May  5 01:52:48 2003
+++ linux-2.5-s390/drivers/s390/char/tape_std.c	Mon May 26 19:20:47 2003
@@ -11,7 +11,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/bio.h>
