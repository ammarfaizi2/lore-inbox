Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263535AbSJGXeX>; Mon, 7 Oct 2002 19:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263537AbSJGXeX>; Mon, 7 Oct 2002 19:34:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:49583 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263535AbSJGXeM>;
	Mon, 7 Oct 2002 19:34:12 -0400
Date: Mon, 7 Oct 2002 19:39:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Adam Kropelin <akropel1@rochester.rr.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.41: cpqarray compile fixes
In-Reply-To: <20021007233627.GB24284@www.kroptech.com>
Message-ID: <Pine.GSO.4.21.0210071936540.29030-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Oct 2002, Adam Kropelin wrote:

> cpqarray in 2.5.41 needs the patch below to compile. 

Yeah, and more than that.  Same typo is in cciss, rd.c sets ->first_minor to
0 for all units and HD_IRQ definition is needed if CONFIG_BLK_DEV_HD is
defined.

diff -urN C41-rd/drivers/block/cciss.c C41-disk_add/drivers/block/cciss.c
--- C41-rd/drivers/block/cciss.c	Mon Oct  7 15:55:57 2002
+++ C41-disk_add/drivers/block/cciss.c	Mon Oct  7 16:45:41 2002
@@ -2274,7 +2274,7 @@
 	struct gendisk *disk[NWD];
 	int i, n;
 	for (n = 0; n < NWD; n++) {
-		disk[n] = disk_alloc();
+		disk[n] = alloc_disk();
 		if (!disk[n])
 			goto out;
 	}
diff -urN C41-rd/drivers/block/cpqarray.c C41-disk_add/drivers/block/cpqarray.c
--- C41-rd/drivers/block/cpqarray.c	Mon Oct  7 15:55:57 2002
+++ C41-disk_add/drivers/block/cpqarray.c	Mon Oct  7 16:45:29 2002
@@ -355,7 +355,7 @@
 		}
 		num_cntlrs_reg++;
 		for (j=0; j<NWD; j++) {
-			ida_gendisk[i][j] = disk_alloc();
+			ida_gendisk[i][j] = alloc_disk();
 			if (!ida_gendisk[i][j])
 				goto Enomem2;
 		}
diff -urN C41-HD_IRQ/drivers/block/rd.c C41-rd/drivers/block/rd.c
--- C41-HD_IRQ/drivers/block/rd.c	Mon Oct  7 15:55:57 2002
+++ C41-rd/drivers/block/rd.c	Mon Oct  7 16:40:43 2002
@@ -459,7 +459,7 @@
 		/* rd_size is given in kB */
 		rd_length[i] = rd_size << 10;
 		disk->major = MAJOR_NR;
-		disk->first_minor = 0;
+		disk->first_minor = i;
 		disk->minor_shift = 0;
 		disk->fops = &rd_bd_op;
 		sprintf(disk->disk_name, "rd%d", i);
diff -urN C41-0/drivers/ide/legacy/hd.c C41-HD_IRQ/drivers/ide/legacy/hd.c
--- C41-0/drivers/ide/legacy/hd.c	Mon Oct  7 15:55:58 2002
+++ C41-HD_IRQ/drivers/ide/legacy/hd.c	Mon Oct  7 16:35:19 2002
@@ -50,8 +50,6 @@
 #define DEVICE_NR(device) (minor(device)>>6)
 #include <linux/blk.h>
 
-#define HD_IRQ 14	/* the standard disk interrupt */
-
 #ifdef __arm__
 #undef  HD_IRQ
 #endif
diff -urN C41-0/include/linux/hdreg.h C41-HD_IRQ/include/linux/hdreg.h
--- C41-0/include/linux/hdreg.h	Wed Sep 18 00:52:23 2002
+++ C41-HD_IRQ/include/linux/hdreg.h	Mon Oct  7 16:35:19 2002
@@ -8,6 +8,8 @@
 
 /* ide.c has its own port definitions in "ide.h" */
 
+#define HD_IRQ		14
+
 /* Hd controller regs. Ref: IBM AT Bios-listing */
 #define HD_DATA		0x1f0		/* _CTL when writing */
 #define HD_ERROR	0x1f1		/* see err-bits */

