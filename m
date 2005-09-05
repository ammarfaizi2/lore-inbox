Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbVIETg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbVIETg5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 15:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbVIETg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 15:36:57 -0400
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:33553 "EHLO
	smtp-vbr1.xs4all.nl") by vger.kernel.org with ESMTP id S932406AbVIETg4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 15:36:56 -0400
Message-ID: <431C9E55.3080709@baanhofman.nl>
Date: Mon, 05 Sep 2005 21:36:53 +0200
From: Wilco Baan Hofman <wilco@baanhofman.nl>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Ramdisks of different sizes
Content-Type: multipart/mixed;
 boundary="------------070702070906070908050203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070702070906070908050203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I've just written a patch for the rd code to allow the user to specify 
more than one ramdisk size. I altered the rd_size parameter for the rd 
module to be of charp type instead of int.

This will still work identically with modprobe/modutils, but you can 
specify multiple sizes by supplying a comma-separated list. The last 
value is used for the remainder of the ram disks you didn't specify, so 
it's backwards-compatible.

This is very useful when you have an initrd of about 4MB, but want to 
use larger ramdisk, for example a 2GB hdd-backed ramdisk.

Regards,

Wilco Baan Hofman


--------------070702070906070908050203
Content-Type: text/plain;
 name="syn-ramdisk_multisize-20050905.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syn-ramdisk_multisize-20050905.patch"

diff -urN linux-2.6.13-rc6.orig/drivers/block/rd.c linux-2.6.13-rc6/drivers/block/rd.c
--- linux-2.6.13-rc6.orig/drivers/block/rd.c	2005-09-05 12:07:59.000000000 +0200
+++ linux-2.6.13-rc6/drivers/block/rd.c	2005-09-05 21:16:22.000000000 +0200
@@ -74,7 +74,8 @@
  * architecture-specific setup routine (from the stored boot sector
  * information).
  */
-int rd_size = CONFIG_BLK_DEV_RAM_SIZE;		/* Size of the RAM disks */
+static char *rd_size = NULL;		/* [SYN] The string with sizes */
+int rd_sizes[CONFIG_BLK_DEV_RAM_COUNT];	/* [SYN] Sizes of the RAM disks */
 /*
  * It would be very desirable to have a soft-blocksize (that in the case
  * of the ramdisk driver is also the hardblocksize ;) of PAGE_SIZE because
@@ -420,8 +421,9 @@
  */
 static int __init rd_init(void)
 {
-	int i;
+	int i, cnt;
 	int err = -ENOMEM;
+	char *size_ptr;
 
 	if (rd_blocksize > PAGE_SIZE || rd_blocksize < 512 ||
 			(rd_blocksize & (rd_blocksize-1))) {
@@ -430,6 +432,47 @@
 		rd_blocksize = BLOCK_SIZE;
 	}
 
+
+	/* [SYN] Extract the ram disk sizes from rd_size if applicable. */
+	if (rd_size != NULL) {
+		size_ptr = rd_size;
+		for (i = 0, cnt = 0; ; i++) {
+			if (rd_size[i] == ',') {
+				rd_size[i] = '\0';
+				printk("rd: ramdisk %d: %sK size\n", cnt,
+						size_ptr);
+				rd_sizes[cnt] = simple_strtol(size_ptr, NULL, 
+						0);
+				
+				cnt++;
+				size_ptr = rd_size + (i+1);
+				continue;
+			}
+			if (rd_size[i] == '\0') {
+				printk("rd: ramdisk %d-%d: %sK size\n", cnt, 
+						CONFIG_BLK_DEV_RAM_COUNT, 
+						size_ptr);
+				rd_sizes[cnt] = simple_strtol(size_ptr, NULL, 
+						0);
+			
+				/* [SYN] The last value changes the size for the
+				 * rest. Backwards compatibility measure. */
+				for (i = cnt + 1; 
+			             i < CONFIG_BLK_DEV_RAM_COUNT;
+				     i++) {
+					
+					rd_sizes[i] = rd_sizes[cnt];
+				}
+				break;
+			}
+		}
+	} else {
+		/* [SYN] Fill the block sizes array with default values. */
+		for (i = 0; i < CONFIG_BLK_DEV_RAM_COUNT; i++) {
+			rd_sizes[i] = CONFIG_BLK_DEV_RAM_SIZE;
+		}
+	}
+	
 	for (i = 0; i < CONFIG_BLK_DEV_RAM_COUNT; i++) {
 		rd_disks[i] = alloc_disk(1);
 		if (!rd_disks[i])
@@ -461,14 +504,14 @@
 		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
 		sprintf(disk->disk_name, "ram%d", i);
 		sprintf(disk->devfs_name, "rd/%d", i);
-		set_capacity(disk, rd_size * 2);
+		set_capacity(disk, rd_sizes[i] * 2);
 		add_disk(rd_disks[i]);
 	}
 
 	/* rd_size is given in kB */
 	printk("RAMDISK driver initialized: "
-		"%d RAM disks of %dK size %d blocksize\n",
-		CONFIG_BLK_DEV_RAM_COUNT, rd_size, rd_blocksize);
+		"%d RAM disks with %d blocksize\n",
+		CONFIG_BLK_DEV_RAM_COUNT, rd_blocksize);
 
 	return 0;
 out_queue:
@@ -488,7 +531,7 @@
 #ifndef MODULE
 static int __init ramdisk_size(char *str)
 {
-	rd_size = simple_strtol(str,NULL,0);
+	rd_size = str;
 	return 1;
 }
 static int __init ramdisk_size2(char *str)	/* kludge */
@@ -506,8 +549,8 @@
 #endif
 
 /* options - modular */
-module_param(rd_size, int, 0);
-MODULE_PARM_DESC(rd_size, "Size of each RAM disk in kbytes.");
+module_param(rd_size, charp, 0);
+MODULE_PARM_DESC(rd_size, "Sizes of the RAM disks.");
 module_param(rd_blocksize, int, 0);
 MODULE_PARM_DESC(rd_blocksize, "Blocksize of each RAM disk in bytes.");
 MODULE_ALIAS_BLOCKDEV_MAJOR(RAMDISK_MAJOR);

--------------070702070906070908050203--
