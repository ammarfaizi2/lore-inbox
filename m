Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272593AbRI3SiK>; Sun, 30 Sep 2001 14:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273904AbRI3SiB>; Sun, 30 Sep 2001 14:38:01 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:10682 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S272593AbRI3Sht>; Sun, 30 Sep 2001 14:37:49 -0400
Subject: [PATCH] NTFS 1.1.20
To: torvalds@transmeta.com
Date: Sun, 30 Sep 2001 19:38:16 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15nlTk-0001PY-00@virgo.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please apply below patch for the 2.4.11-pre1 release. It adds checking of
the new return value for set_blocksize introduced in the
dangerous-dont-use patches and it fixes a few obvious NTFS bugs as well.
Patch is verified to work fine here on top of dangerous-dont-use-4 but it
should apply cleanly to any as it only touches NTFS.

ChangeLog
- Fixed two bugs in ntfs_readwrite_attr(). Thanks to Jan Kara for spotting
the out of bounds one.
- Check return value of set_blocksize() in ntfs_read_super() and make use
of get_hardsect_size() to determine the minimum starting block size.
- Fix return values of ntfs_vcn_to_lcn(). This should stop peoples start
of partition being overwritten at random.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

--- linux-2.4.11-pre1-ntfs-1.1.20.diff ---
diff -u -urN l2410ddu4/Documentation/filesystems/ntfs.txt l2410ddu-ntfs/Documentation/filesystems/ntfs.txt
--- l2410ddu4/Documentation/filesystems/ntfs.txt	Wed Sep 12 01:02:46 2001
+++ l2410ddu-ntfs/Documentation/filesystems/ntfs.txt	Sun Sep 30 16:58:43 2001
@@ -98,6 +98,14 @@
 ChangeLog
 =========
 
+NTFS 1.1.20:
+	- Fixed two bugs in ntfs_readwrite_attr(). Thanks to Jan Kara for
+	  spotting the out of bounds one.
+	- Check return value of set_blocksize() in ntfs_read_super() and make
+	  use of get_hardsect_size() to determine the minimum block size.
+	- Fix return values of ntfs_vcn_to_lcn(). This should stop
+	  peoples start of partition being overwritten at random.
+
 NTFS 1.1.19:
 	- Fixed ntfs_getdir_unsorted(), ntfs_readdir() and ntfs_printcb() to
 	  cope with arbitrary cluster sizes. Very important for Win2k+. Also,
diff -u -urN l2410ddu4/fs/ntfs/Makefile l2410ddu-ntfs/fs/ntfs/Makefile
--- l2410ddu4/fs/ntfs/Makefile	Wed Sep 12 01:02:46 2001
+++ l2410ddu-ntfs/fs/ntfs/Makefile	Sun Sep 30 16:52:53 2001
@@ -5,7 +5,7 @@
 obj-y   := fs.o sysctl.o support.o util.o inode.o dir.o super.o attr.o unistr.o
 obj-m   := $(O_TARGET)
 # New version format started 3 February 2001.
-EXTRA_CFLAGS = -DNTFS_VERSION=\"1.1.19\" #-DDEBUG
+EXTRA_CFLAGS = -DNTFS_VERSION=\"1.1.20\" #-DDEBUG
 
 include $(TOPDIR)/Rules.make
 
diff -u -urN l2410ddu4/fs/ntfs/fs.c l2410ddu-ntfs/fs/ntfs/fs.c
--- l2410ddu4/fs/ntfs/fs.c	Wed Sep 12 01:02:46 2001
+++ l2410ddu-ntfs/fs/ntfs/fs.c	Sun Sep 30 16:52:22 2001
@@ -27,6 +27,7 @@
 #include <linux/locks.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
+#include <linux/blkdev.h>
 #include <asm/page.h>
 #include <linux/nls.h>
 #include <linux/ntfs_fs.h>
@@ -1012,22 +1013,27 @@
 {
 	ntfs_volume *vol;
 	struct buffer_head *bh;
-	int i, to_read;
+	int i, to_read, blocksize;
 
 	ntfs_debug(DEBUG_OTHER, "ntfs_read_super\n");
 	vol = NTFS_SB2VOL(sb);
 	init_ntfs_super_block(vol);
 	if (!parse_options(vol, (char*)options))
 		goto ntfs_read_super_vol;
-	/* Assume a 512 bytes block device for now. */
-	set_blocksize(sb->s_dev, 512);
+	blocksize = get_hardsect_size(sb->s_dev);
+	if (blocksize < 512)
+		blocksize = 512;
+	if (set_blocksize(sb->s_dev, blocksize) < 0) {
+		ntfs_error("Unable to set blocksize %d.\n", blocksize);
+		goto ntfs_read_super_vol;
+	}
 	/* Read the super block (boot block). */
-	if (!(bh = bread(sb->s_dev, 0, 512))) {
+	if (!(bh = bread(sb->s_dev, 0, blocksize))) {
 		ntfs_error("Reading super block failed\n");
 		goto ntfs_read_super_unl;
 	}
 	ntfs_debug(DEBUG_OTHER, "Done reading boot block\n");
-	/* Check for 'NTFS' magic number */
+	/* Check for valid 'NTFS' boot sector. */
 	if (!is_boot_sector_ntfs(bh->b_data)) {
 		ntfs_debug(DEBUG_OTHER, "Not a NTFS volume\n");
 		bforget(bh);
@@ -1040,7 +1046,7 @@
 		goto ntfs_read_super_unl;
 	}
 	ntfs_debug(DEBUG_OTHER, "$Mft at cluster 0x%lx\n", vol->mft_lcn);
-	bforget(bh);
+	brelse(bh);
 	NTFS_SB(vol) = sb;
 	if (vol->cluster_size > PAGE_SIZE) {
 		ntfs_error("Partition cluster size is not supported yet (it "
@@ -1050,9 +1056,12 @@
 	ntfs_debug(DEBUG_OTHER, "Done to init volume\n");
 	/* Inform the kernel that a device block is a NTFS cluster. */
 	sb->s_blocksize = vol->cluster_size;
-	for (i = sb->s_blocksize, sb->s_blocksize_bits = 0; i != 1; i >>= 1)
-		sb->s_blocksize_bits++;
-	set_blocksize(sb->s_dev, sb->s_blocksize);
+	sb->s_blocksize_bits = vol->cluster_size_bits;
+	if (blocksize != vol->cluster_size &&
+			set_blocksize(sb->s_dev, sb->s_blocksize) < 0) {
+		ntfs_error("Cluster size too small for device.\n");
+		goto ntfs_read_super_unl;
+	}
 	ntfs_debug(DEBUG_OTHER, "set_blocksize\n");
 	/* Allocate an MFT record (MFT record can be smaller than a cluster). */
 	i = vol->cluster_size;
diff -u -urN l2410ddu4/fs/ntfs/inode.c l2410ddu-ntfs/fs/ntfs/inode.c
--- l2410ddu4/fs/ntfs/inode.c	Sat Sep  8 20:24:40 2001
+++ l2410ddu-ntfs/fs/ntfs/inode.c	Sun Sep 30 16:50:46 2001
@@ -592,18 +592,23 @@
 		 * If write extends beyond _allocated_ size, extend attribute,
 		 * updating attr->allocated and attr->size in the process. (AIA)
 		 */
-		if (offset + l > attr->allocated) {
+		if ((!attr->resident && offset + l > attr->allocated) ||
+				(attr->resident && offset + l > attr->size)) {
 			error = ntfs_resize_attr(ino, attr, offset + l);
 			if (error)
 				return error;
-		} else if (offset + l > attr->size)
-			/* If amount of data has increased: update. */
-			attr->size = offset + l;
-		/* If amount of initialised data has increased: update. */
-		if (offset + l > attr->initialized) {
-			/* FIXME: Zero-out the section between the old
-			 * initialised length and the write start. (AIA) */
-			attr->initialized = offset + l;
+		}
+		if (!attr->resident) {
+			/* Has amount of data increased? */
+			if (offset + l > attr->size)
+				attr->size = offset + l;
+			/* Has amount of initialised data increased? */
+			if (offset + l > attr->initialized) {
+				/* FIXME: Clear the section between the old
+			 	 * initialised length and the write start.
+				 * (AIA) */
+				attr->initialized = offset + l;
+			}
 		}
 	}
 	if (attr->resident) {
@@ -619,10 +624,11 @@
 		if (offset >= attr->initialized)
 			return ntfs_read_zero(dest, l);
 		if (offset + l > attr->initialized) {
-			dest->size = chunk = offset + l - attr->initialized;
+			dest->size = chunk = attr->initialized - offset;
 			error = ntfs_readwrite_attr(ino, attr, offset, dest);
-			if (error)
+			if (error || (dest->size != chunk && (error = -EIO, 1)))
 				return error;
+			dest->size += l - chunk;
 			return ntfs_read_zero(dest, l - chunk);
 		}
 		if (attr->flags & ATTR_IS_COMPRESSED)
@@ -707,31 +713,25 @@
 	return ntfs_readwrite_attr(ino, attr, offset, buf);
 }
 
+/* -2 = error, -1 = hole, >= 0 means real disk cluster (lcn). */
 int ntfs_vcn_to_lcn(ntfs_inode *ino, int vcn)
 {
 	int rnum;
 	ntfs_attribute *data;
 	
 	data = ntfs_find_attr(ino, ino->vol->at_data, 0);
-	/* It's hard to give an error code. */
 	if (!data || data->resident || data->flags & (ATTR_IS_COMPRESSED |
 			ATTR_IS_ENCRYPTED))
-		return -1;
+		return -2;
 	if (data->size <= (__s64)vcn << ino->vol->cluster_size_bits)
-		return -1;
-	/*
-	 * For Linux, block number 0 represents a hole. - No problem as we do
-	 * not support bmap in any form whatsoever. The FIBMAP sys call is
-	 * deprecated anyway and NTFS is not a block based file system so
-	 * allowing bmapping is complete and utter garbage IMO. Use mmap once
-	 * we implement it... (AIA)
-	 */
+		return -2;
 	if (data->initialized <= (__s64)vcn << ino->vol->cluster_size_bits)
-		return 0;
+		return -1;
 	for (rnum = 0; rnum < data->d.r.len &&
-				vcn >= data->d.r.runlist[rnum].len; rnum++)
+			vcn >= data->d.r.runlist[rnum].len; rnum++)
 		vcn -= data->d.r.runlist[rnum].len;
-	/* We need to cope with sparse runs. (AIA) */
+	if (data->d.r.runlist[rnum].lcn >= 0)
+		return data->d.r.runlist[rnum].lcn + vcn;
 	return data->d.r.runlist[rnum].lcn + vcn;
 }
 

