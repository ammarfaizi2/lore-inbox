Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277034AbRJQSkx>; Wed, 17 Oct 2001 14:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277046AbRJQSkg>; Wed, 17 Oct 2001 14:40:36 -0400
Received: from kaa.perlsupport.com ([205.245.149.25]:16905 "EHLO
	kaa.perlsupport.com") by vger.kernel.org with ESMTP
	id <S277047AbRJQSkV>; Wed, 17 Oct 2001 14:40:21 -0400
Date: Wed, 17 Oct 2001 11:40:46 -0700
From: Chip Salzenberg <chip@pobox.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.13pre3: loop uses wrong type for blk_size[]
Message-ID: <20011017114046.A3880@perlsupport.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In 2.4.13pre3, the loop device was changed to use an array of unsigned
long for its entry in blk_size[].  This is broken, because blk_size[]
is of type 'int * []'.  A patch is attached which fixes this problem
while still retaining the presumably intended behavior of working
properly with large devices.
-- 
Chip Salzenberg               - a.k.a. -              <chip@pobox.com>
 "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=pre3-loop-blksize-int-fix


Index: linux/drivers/block/loop.c
--- linux/drivers/block/loop.c.old	Tue Oct 16 23:28:20 2001
+++ linux/drivers/block/loop.c	Wed Oct 17 01:09:07 2001
@@ -78,5 +78,5 @@
 static int max_loop = 8;
 static struct loop_device *loop_dev;
-static unsigned long *loop_sizes;
+static int *loop_sizes;
 static int *loop_blksizes;
 static devfs_handle_t devfs_handle;      /*  For the directory */
@@ -152,5 +152,5 @@
 #define MAX_DISK_SIZE 1024*1024*1024
 
-static unsigned long compute_loop_size(struct loop_device *lo, struct dentry * lo_dentry, kdev_t lodev)
+static int compute_loop_size(struct loop_device *lo, struct dentry * lo_dentry, kdev_t lodev)
 {
 	if (S_ISREG(lo_dentry->d_inode->i_mode))
@@ -877,5 +877,5 @@
 			break;
 		}
-		err = put_user(loop_sizes[lo->lo_number] << 1, (unsigned long *) arg);
+		err = put_user((unsigned long)loop_sizes[lo->lo_number] << 1, (unsigned long *) arg);
 		break;
 	case BLKGETSIZE64:
@@ -1019,5 +1019,5 @@
 		return -ENOMEM;
 
-	loop_sizes = kmalloc(max_loop * sizeof(unsigned long), GFP_KERNEL);
+	loop_sizes = kmalloc(max_loop * sizeof(int), GFP_KERNEL);
 	if (!loop_sizes)
 		goto out_sizes;
@@ -1039,5 +1039,5 @@
 	}
 
-	memset(loop_sizes, 0, max_loop * sizeof(unsigned long));
+	memset(loop_sizes, 0, max_loop * sizeof(int));
 	memset(loop_blksizes, 0, max_loop * sizeof(int));
 	blk_size[MAJOR_NR] = loop_sizes;

--ZPt4rx8FFjLCG7dd--
