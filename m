Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUIVMQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUIVMQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 08:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUIVMQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 08:16:27 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:43981 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S264903AbUIVMP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 08:15:26 -0400
Date: Wed, 22 Sep 2004 13:15:22 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 1/7] Re: [2.6-BK-URL] NTFS 2.1.18 release
In-Reply-To: <Pine.LNX.4.60.0409221308540.505@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409221314250.505@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409221308540.505@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 1/7 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/08/27 1.1832.26.1)
   NTFS: Remove vol->nr_mft_records as it was pretty meaningless and optimize
         the calculation of total/free inodes as used by statfs().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-09-22 13:02:33 +01:00
+++ b/fs/ntfs/ChangeLog	2004-09-22 13:02:33 +01:00
@@ -21,6 +21,11 @@
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
+2.1.18-WIP
+
+	- Remove vol->nr_mft_records as it was pretty meaningless and optimize
+	  the calculation of total/free inodes as used by statfs().
+
 2.1.17 - Fix bugs in mount time error code paths and other updates.
 
 	- Implement bitmap modification code (fs/ntfs/bitmap.[hc]).  This
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	2004-09-22 13:02:33 +01:00
+++ b/fs/ntfs/Makefile	2004-09-22 13:02:33 +01:00
@@ -6,7 +6,7 @@
 	     index.o inode.o mft.o mst.o namei.o super.o sysctl.o unistr.o \
 	     upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.17\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.18-WIP\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-09-22 13:02:33 +01:00
+++ b/fs/ntfs/inode.c	2004-09-22 13:02:33 +01:00
@@ -1900,8 +1900,6 @@
 
 		/* Are we in the first extent? */
 		if (!next_vcn) {
-			u64 ll;
-
 			if (attr->data.non_resident.lowest_vcn) {
 				ntfs_error(sb, "First extent of $DATA "
 						"attribute has non zero "
@@ -1920,17 +1918,15 @@
 					non_resident.initialized_size);
 			ni->allocated_size = sle64_to_cpu(
 					attr->data.non_resident.allocated_size);
-			/* Set the number of mft records. */
-			ll = vi->i_size >> vol->mft_record_size_bits;
 			/*
 			 * Verify the number of mft records does not exceed
 			 * 2^32 - 1.
 			 */
-			if (ll >= (1ULL << 32)) {
+			if ((vi->i_size >> vol->mft_record_size_bits) >=
+					(1ULL << 32)) {
 				ntfs_error(sb, "$MFT is too big! Aborting.");
 				goto put_err_out;
 			}
-			vol->nr_mft_records = ll;
 			/*
 			 * We have got the first extent of the runlist for
 			 * $MFT which means it is now relatively safe to call
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-09-22 13:02:33 +01:00
+++ b/fs/ntfs/super.c	2004-09-22 13:02:33 +01:00
@@ -2012,7 +2012,7 @@
  */
 static unsigned long __get_nr_free_mft_records(ntfs_volume *vol)
 {
-	s64 nr_free = vol->nr_mft_records;
+	s64 nr_free;
 	u32 *kaddr;
 	struct address_space *mapping = vol->mftbmp_ino->i_mapping;
 	filler_t *readpage = (filler_t*)mapping->a_ops->readpage;
@@ -2021,13 +2021,16 @@
 	unsigned int max_size;
 
 	ntfs_debug("Entering.");
+	/* Number of mft records in file system (at this point in time). */
+	nr_free = vol->mft_ino->i_size >> vol->mft_record_size_bits;
 	/*
-	 * Convert the number of bits into bytes rounded up, then convert into
-	 * multiples of PAGE_CACHE_SIZE, rounding up so that if we have one
-	 * full and one partial page max_index = 2.
+	 * Convert the maximum number of set bits into bytes rounded up, then
+	 * convert into multiples of PAGE_CACHE_SIZE, rounding up so that if we
+	 * have one full and one partial page max_index = 2.
 	 */
-	max_index = (((vol->nr_mft_records + 7) >> 3) + PAGE_CACHE_SIZE - 1) >>
-			PAGE_CACHE_SHIFT;
+	max_index = ((((NTFS_I(vol->mft_ino)->initialized_size >>
+			vol->mft_record_size_bits) + 7) >> 3) +
+			PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	/* Use multiples of 4 bytes. */
 	max_size = PAGE_CACHE_SIZE >> 2;
 	ntfs_debug("Reading $MFT/$BITMAP, max_index = 0x%lx, max_size = "
@@ -2122,9 +2125,9 @@
 	sfs->f_bavail = sfs->f_bfree = size;
 	/* Serialize accesses to the inode bitmap. */
 	down_read(&vol->mftbmp_lock);
-	/* Total file nodes in file system (at this moment in time). */
-	sfs->f_files  = vol->mft_ino->i_size >> vol->mft_record_size_bits;
-	/* Free file nodes in fs (based on current total count). */
+	/* Number of inodes in file system (at this point in time). */
+	sfs->f_files = vol->mft_ino->i_size >> vol->mft_record_size_bits;
+	/* Free inodes in fs (based on current total count). */
 	sfs->f_ffree = __get_nr_free_mft_records(vol);
 	up_read(&vol->mftbmp_lock);
 	/*
diff -Nru a/fs/ntfs/volume.h b/fs/ntfs/volume.h
--- a/fs/ntfs/volume.h	2004-09-22 13:02:33 +01:00
+++ b/fs/ntfs/volume.h	2004-09-22 13:02:33 +01:00
@@ -95,9 +95,6 @@
 	struct inode *mftbmp_ino;	/* Attribute inode for $MFT/$BITMAP. */
 	struct rw_semaphore mftbmp_lock; /* Lock for serializing accesses to the
 					    mft record bitmap ($MFT/$BITMAP). */
-	unsigned long nr_mft_records;	/* Number of mft records == number of
-					   bits in mft bitmap. */
-
 #ifdef NTFS_RW
 	struct inode *mftmirr_ino;	/* The VFS inode of $MFTMirr. */
 	int mftmirr_size;		/* Size of mft mirror in mft records. */
