Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268908AbRH0UnK>; Mon, 27 Aug 2001 16:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268861AbRH0UnA>; Mon, 27 Aug 2001 16:43:00 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:19165 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S268908AbRH0Umk>;
	Mon, 27 Aug 2001 16:42:40 -0400
Date: Mon, 27 Aug 2001 16:42:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: patch-2.4.10-pre1
In-Reply-To: <Pine.LNX.4.33.0108271323290.5985-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0108271640590.29700-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Patch fixes the use of ioctls in partitions/ibm.c, removing
a lot of junk in process (fake struct file allocation, set_fs(),
yodda, yodda - we use blkdev_get() and ioctl_by_bdev() instead).
Please, apply

diff -urN S10-pre1/fs/partitions/ibm.c S10-pre1-partition/fs/partitions/ibm.c
--- S10-pre1/fs/partitions/ibm.c	Sat Aug 11 14:59:24 2001
+++ S10-pre1-partition/fs/partitions/ibm.c	Mon Aug 27 16:37:37 2001
@@ -45,67 +45,22 @@
 static int
 get_drive_geometry(int kdev,struct hd_geometry *geo) 
 {
-	int rc = 0;
-	mm_segment_t old_fs;
-	struct file *filp;
-	struct inode *inode;
-        /* find out offset of volume label (partn table) */
-        filp = (struct file *)kmalloc (sizeof(struct file),GFP_KERNEL);
-        if ( filp == NULL ) {
-                printk (KERN_WARNING __FILE__ " ibm_partition: kmalloc failed fo
-r filp\n");
-                return -ENOMEM;
-        }
-        memset(filp,0,sizeof(struct file));
-        filp ->f_mode = 1; /* read only */
-        inode = get_empty_inode();
-	if ( inode == NULL )
-		return -ENOMEM;
-        inode -> i_rdev = kdev;
-	inode -> i_bdev = bdget(kdev_t_to_nr(kdev));
-	rc = blkdev_open(inode,filp);
-        if ( rc == 0 ) {
-		old_fs=get_fs();
-		set_fs(KERNEL_DS);
-		rc = inode-> i_bdev -> bd_op->ioctl (inode, filp, HDIO_GETGEO, 
-						     (unsigned long)(geo))
-			;
-		set_fs(old_fs);
-	}
-	blkdev_put(inode->i_bdev,BDEV_FILE);
+	struct block_device *bdev = bdget(kdev_t_to_nr(kdev));
+	int rc = blkdev_get(bdev, 0, 1, BDEV_FILE);
+        if ( rc == 0 )
+		rc = ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo);
+	blkdev_put(bdev,BDEV_FILE);
 	return rc;
 }
 
 static int
 get_drive_info(int kdev,dasd_information_t *info) 
 {
-	int rc = 0;
-	mm_segment_t old_fs;
-	struct file *filp;
-	struct inode *inode;
-        /* find out offset of volume label (partn table) */
-        filp = (struct file *)kmalloc (sizeof(struct file),GFP_KERNEL);
-        if ( filp == NULL ) {
-                printk (KERN_WARNING __FILE__ " ibm_partition: kmalloc failed fo
-r filp\n");
-                return -ENOMEM;
-        }
-        memset(filp,0,sizeof(struct file));
-        filp ->f_mode = 1; /* read only */
-        inode = get_empty_inode();
-	if ( inode == NULL )
-		return -ENOMEM;
-        inode -> i_rdev = kdev;
-	inode -> i_bdev = bdget(kdev_t_to_nr(kdev));
-        rc = blkdev_open(inode,filp);
-        if ( rc == 0 ) {
-		old_fs=get_fs();
-		set_fs(KERNEL_DS);
-		rc = inode-> i_bdev -> bd_op->ioctl (inode, filp, BIODASDINFO, 
-						     (unsigned long)(info));
-		set_fs(old_fs);
-	}
-	blkdev_put(inode->i_bdev,BDEV_FILE);
+	struct block_device *bdev = bdget(kdev_t_to_nr(kdev));
+	int rc = blkdev_get(bdev, 0, 1, BDEV_FILE);
+        if ( rc == 0 )
+		rc = ioctl_by_bdev(bdev, BIODASDINFO, (unsigned long)(info));
+	blkdev_put(bdev,BDEV_FILE);
 	return rc;
 }
 


