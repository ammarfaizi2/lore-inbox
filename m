Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVEROEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVEROEG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVEROCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:02:18 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:19684 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262197AbVERNx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:53:28 -0400
Subject: [RFC/PATCH 1/5] bdev: execute in place (V2)
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: cotte@freenet.de
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@osdl.org
In-Reply-To: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com>
References: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com>
Content-Type: text/plain
Organization: IBM Deutschland Entwicklung
Date: Wed, 18 May 2005 15:53:22 +0200
Message-Id: <1116424403.2202.16.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[RFC/PATCH 1/5] bdev: execute in place (V2)
This patch introduces a new block device operation called direct_access.
It is used to retrieve a reference to the data on disk behind a given
sector. This reference is supposed to be cpu addressable, physical
address, and remain valid until release is called.
This patch also implements this operation for our dcssblk device driver.
Changes from previous version: none

Signed-off-by: Carsten Otte <cotte@de.ibm.com>
--- 
diff -ruN linux-git/drivers/s390/block/dcssblk.c linux-git-xip/drivers/s390/block/dcssblk.c
--- linux-git/drivers/s390/block/dcssblk.c	2005-05-17 14:23:24.000000000 +0200
+++ linux-git-xip/drivers/s390/block/dcssblk.c	2005-05-17 16:57:07.306779600 +0200
@@ -35,14 +35,17 @@
 static int dcssblk_open(struct inode *inode, struct file *filp);
 static int dcssblk_release(struct inode *inode, struct file *filp);
 static int dcssblk_make_request(struct request_queue *q, struct bio *bio);
+static int dcssblk_direct_access(struct inode *inode, sector_t secnum,
+				 unsigned long *data);
 
 static char dcssblk_segments[DCSSBLK_PARM_LEN] = "\0";
 
 static int dcssblk_major;
 static struct block_device_operations dcssblk_devops = {
-	.owner   = THIS_MODULE,
-	.open    = dcssblk_open,
-	.release = dcssblk_release,
+	.owner   	= THIS_MODULE,
+	.open    	= dcssblk_open,
+	.release 	= dcssblk_release,
+	.direct_access 	= dcssblk_direct_access,
 };
 
 static ssize_t dcssblk_add_store(struct device * dev, const char * buf,
@@ -641,6 +644,20 @@
 		/* Request beyond end of DCSS segment. */
 		goto fail;
 	}
+	/* verify data transfer direction */
+	if (dev_info->is_shared) {
+		switch (dev_info->segment_type) {
+		case SEG_TYPE_SR:
+		case SEG_TYPE_ER:
+		case SEG_TYPE_SC:
+			/* cannot write to these segments */
+			if (bio_data_dir(bio) == WRITE) {
+				PRINT_WARN("rejecting write to ro segment %s\n", dev_info->dev.bus_id);
+				goto fail;
+			}
+		}
+	}
+
 	index = (bio->bi_sector >> 3);
 	bio_for_each_segment(bvec, bio, i) {
 		page_addr = (unsigned long)
@@ -661,7 +678,26 @@
 	bio_endio(bio, bytes_done, 0);
 	return 0;
 fail:
-	bio_io_error(bio, bytes_done);
+	bio_io_error(bio, bio->bi_size);
+	return 0;
+}
+
+static int
+dcssblk_direct_access (struct inode *inode, sector_t secnum,
+			unsigned long *data)
+{
+	struct dcssblk_dev_info *dev_info;
+	unsigned long pgoff;
+
+	dev_info = inode->i_sb->s_bdev->bd_disk->private_data;
+	if (!dev_info)
+		return -ENODEV;
+	if (secnum % (PAGE_SIZE/512))
+		return -EINVAL;
+	pgoff = secnum / (PAGE_SIZE / 512);
+	if ((pgoff+1)*PAGE_SIZE-1 > dev_info->end - dev_info->start)
+		return -ERANGE;
+	*data = (unsigned long) (dev_info->start+pgoff*PAGE_SIZE);
 	return 0;
 }
 
diff -ruN linux-git/include/linux/fs.h linux-git-xip/include/linux/fs.h
--- linux-git/include/linux/fs.h	2005-05-17 14:23:35.000000000 +0200
+++ linux-git-xip/include/linux/fs.h	2005-05-17 16:57:07.308779296 +0200
@@ -884,6 +884,7 @@
 	int (*release) (struct inode *, struct file *);
 	int (*ioctl) (struct inode *, struct file *, unsigned, unsigned long);
 	long (*compat_ioctl) (struct file *, unsigned, unsigned long);
+	int (*direct_access) (struct inode *, sector_t, unsigned long *);
 	int (*media_changed) (struct gendisk *);
 	int (*revalidate_disk) (struct gendisk *);
 	struct module *owner;


