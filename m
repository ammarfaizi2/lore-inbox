Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbRBXDij>; Fri, 23 Feb 2001 22:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129279AbRBXDi3>; Fri, 23 Feb 2001 22:38:29 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:64266 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S129166AbRBXDiP>;
	Fri, 23 Feb 2001 22:38:15 -0500
Message-ID: <20010224043813.A14272@win.tue.nl>
Date: Sat, 24 Feb 2001 04:38:13 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Linux390@de.ibm.com, aeb@cwi.nl, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] partitions/ibm.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reading patch-2.4.2 I met a strange amount of crap in
partitions/ibm.c. It is as if the author does not know
where the kernel keeps the starting offset of a partition,
and simulates a HDIO_GETGEO ioctl from user space.
I think the following patch does the same and removes a lot
of cruft. (Warning: (i) untested, uncompiled; (ii) pasted
from another window - tabs will have become spaces.)

Andries

-----

diff -u --recursive --new-file ../linux-2.4.2/linux/fs/partitions/ibm.c ./linux/
fs/partitions/ibm.c
--- ../linux-2.4.2/linux/fs/partitions/ibm.c    Sat Feb 24 03:44:02 2001
+++ ./linux/fs/partitions/ibm.c Sat Feb 24 04:04:33 2001
@@ -60,56 +60,22 @@
 }
 
 int 
-ibm_partition(struct gendisk *hd, kdev_t dev, unsigned long first_sector, int
-first_part_minor)
+ibm_partition(struct gendisk *hd, kdev_t dev, unsigned long first_sector,
+             int first_part_minor)
 {
        struct buffer_head *bh;
        ibm_partition_t partition_type;
        char type[5] = {0,};
        char name[7] = {0,};
-       struct hd_geometry geo;
-       mm_segment_t old_fs;
        int blocksize;
-       struct file *filp = NULL;
-       struct inode *inode = NULL;
-       int offset, size;
+       int start, offset, size;
 
-       blocksize = hardsect_size[MAJOR(dev)][MINOR(dev)];
-       if ( blocksize <= 0 ) {
-               return 0;
-       }
+       blocksize = get_hardsect_size(dev);
        set_blocksize(dev, blocksize);  /* OUCH !! */
 
-       /* find out offset of volume label (partn table) */
-       inode = get_empty_inode();
-       inode -> i_rdev = dev;
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,3,98))
-       inode -> i_bdev = bdget(kdev_t_to_nr(dev));
-#endif /* KERNEL_VERSION */
-       filp = (struct file *)kmalloc (sizeof(struct file),GFP_KERNEL);
-       if (!filp)
-               return 0;
-       memset(filp,0,sizeof(struct file));
-       filp ->f_mode = 1; /* read only */
-       blkdev_open(inode,filp);
-       old_fs=get_fs();
-       set_fs(KERNEL_DS);
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,3,98))
-       inode-> i_bdev -> bd_op->ioctl (inode, filp, HDIO_GETGEO, (unsigned long
)(&geo));
-#else
-       filp->f_op->ioctl (inode, filp, HDIO_GETGEO, (unsigned long)(&geo));
-#endif /* KERNEL_VERSION */
-       set_fs(old_fs);
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0))
-        blkdev_put(inode->i_bdev,BDEV_FILE);
-#elif (LINUX_VERSION_CODE > KERNEL_VERSION(2,3,98))
-       blkdev_close(inode,filp);
-#else
-       blkdev_release(inode);
-#endif /* LINUX_VERSION_CODE */
-
-       size = hd -> sizes[MINOR(dev)]<<1;
-       if ( ( bh = bread( dev, geo.start, blocksize) ) != NULL ) {
+       start = hd->part[MINOR(dev)].start_sect;
+       size = hd->sizes[MINOR(dev)] << 1;
+       if ( ( bh = bread( dev, start, blocksize) ) != NULL ) {
                strncpy ( type,bh -> b_data, 4);
                strncpy ( name,bh -> b_data + 4, 6);
         } else {
@@ -120,7 +86,7 @@
        }
        switch ( partition_type = get_partition_type(type) ) {
        case ibm_partition_lnx1: 
-               offset = (geo.start + 1);
+               offset = start + 1;
                printk ( "(LNX1)/%6s:",name);
                break;
        case ibm_partition_vol1:
@@ -132,7 +98,7 @@
                printk ( "(CMS1)/%6s:",name);
                if (* (((long *)bh->b_data) + 13) == 0) {
                        /* disk holds a CMS filesystem */
-                       offset = (geo.start + 1);
+                       offset = start + 1;
                        printk ("(CMS)");
                } else {
                        /* disk is reserved minidisk */
@@ -148,22 +114,18 @@
                break;
        case ibm_partition_none:
                printk ( "(nonl)/      :");
-               offset = (geo.start+1);
+               offset = start+1;
                break;
        default:
                offset = 0;
                size = 0;
 
        }
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,3,98))
+
        add_gd_partition( hd, MINOR(dev), 0,size);
        add_gd_partition( hd, MINOR(dev) + 1, offset * (blocksize >> 9),
                          size-offset*(blocksize>>9));
-#else
-       add_partition( hd, MINOR(dev), 0,size,0);
-       add_partition( hd, MINOR(dev) + 1, offset * (blocksize >> 9),
-                         size-offset*(blocksize>>9) ,0 );
-#endif /* LINUX_VERSION */
+
        printk ( "\n" );
        bforget(bh);
        return 1;
