Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284853AbRLKDBj>; Mon, 10 Dec 2001 22:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284849AbRLKDBa>; Mon, 10 Dec 2001 22:01:30 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:61425 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S284853AbRLKDBS>; Mon, 10 Dec 2001 22:01:18 -0500
Subject: [PATCH] ntfs 1.1.21 (important bug fixes)
To: marcelo@conectiva.com.br, torvalds@transmeta.com
Date: Tue, 11 Dec 2001 03:01:11 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E16DdAN-0006WE-00@virgo.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus and Marcelo,

Please apply below patch for your next pre releases. It is against
2.4.17-pre5 but should apply cleanly to both later 2.4.x and 2.5.x
kernels.

Patch has very important ntfs bug fixes.

1. Fix a bogus BUG() call in ntfs readdir().

2. Fix reading of more complicated $MFT inodes. Without the patch some
Win2k partitions would refuse to mount.

This patch is in response to bug reports from Joe Perches and Andreas
Schuldei whom I would like to thank for providing debug output and testing
the patches while they were evolving to verify that the fixes do indeed
solve the problems they experienced with their Win2k NTFS volumes.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

------ linux-2.4.17-pre5-ntfs-1.1.21.diff ------
diff -urN linux-2.4.17-pre5-vanilla/Documentation/filesystems/ntfs.txt linux-2.4.17-pre5/Documentation/filesystems/ntfs.txt
--- linux-2.4.17-pre5-vanilla/Documentation/filesystems/ntfs.txt	Sun Sep 30 19:42:44 2001
+++ linux-2.4.17-pre5/Documentation/filesystems/ntfs.txt	Tue Dec 11 02:24:37 2001
@@ -98,6 +98,16 @@
 ChangeLog
 =========
 
+NTFS 1.1.21:
+	- Fixed bug with reading $MFT where we try to read higher mft records
+	  before having read the $DATA attribute of $MFT. (Note this is only a
+	  partial solution which will only work in the case that the attribute
+	  list is resident or non-resident but $DATA is in the first 1024
+	  bytes. But this should be enough in the majority of cases. I am not
+	  going to bother fixing the general case until someone finds this to
+	  be a problem for them, which I doubt very much will ever happen...)
+	- Fixed bogus BUG() call in readdir().
+
 NTFS 1.1.20:
 	- Fixed two bugs in ntfs_readwrite_attr(). Thanks to Jan Kara for
 	  spotting the out of bounds one.
diff -urN linux-2.4.17-pre5-vanilla/fs/ntfs/Makefile linux-2.4.17-pre5/fs/ntfs/Makefile
--- linux-2.4.17-pre5-vanilla/fs/ntfs/Makefile	Sun Sep 30 19:42:44 2001
+++ linux-2.4.17-pre5/fs/ntfs/Makefile	Mon Dec 10 21:01:12 2001
@@ -5,7 +5,7 @@
 obj-y   := fs.o sysctl.o support.o util.o inode.o dir.o super.o attr.o unistr.o
 obj-m   := $(O_TARGET)
 # New version format started 3 February 2001.
-EXTRA_CFLAGS = -DNTFS_VERSION=\"1.1.20\" #-DDEBUG
+EXTRA_CFLAGS = -DNTFS_VERSION=\"1.1.21\" #-DDEBUG
 
 include $(TOPDIR)/Rules.make
 
diff -urN linux-2.4.17-pre5-vanilla/fs/ntfs/attr.c linux-2.4.17-pre5/fs/ntfs/attr.c
--- linux-2.4.17-pre5-vanilla/fs/ntfs/attr.c	Sat Sep  8 20:24:40 2001
+++ linux-2.4.17-pre5/fs/ntfs/attr.c	Mon Dec 10 20:59:42 2001
@@ -548,7 +548,7 @@
  * attribute.
  */
 static int ntfs_process_runs(ntfs_inode *ino, ntfs_attribute* attr,
-			     unsigned char *data)
+		unsigned char *data)
 {
 	int startvcn, endvcn;
 	int vcn, cnum;
@@ -622,7 +622,7 @@
 }
   
 /* Insert the attribute starting at attr in the inode ino. */
-int ntfs_insert_attribute(ntfs_inode *ino, unsigned char* attrdata)
+int ntfs_insert_attribute(ntfs_inode *ino, unsigned char *attrdata)
 {
 	int i, found;
 	int type;
diff -urN linux-2.4.17-pre5-vanilla/fs/ntfs/fs.c linux-2.4.17-pre5/fs/ntfs/fs.c
--- linux-2.4.17-pre5-vanilla/fs/ntfs/fs.c	Thu Oct 25 08:02:26 2001
+++ linux-2.4.17-pre5/fs/ntfs/fs.c	Tue Dec 11 00:22:01 2001
@@ -303,10 +303,8 @@
 	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): After ntfs_getdir_unsorted()"
 			" calls, f_pos 0x%Lx.\n", filp->f_pos);
 	if (!err) {
-#ifdef DEBUG
-		if (cb.ph != 0x7fff || cb.pl)
-			BUG();
 done:
+#ifdef DEBUG
 		if (!cb.ret_code)
 			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): EOD, f_pos "
 					"0x%Lx, returning 0.\n", filp->f_pos);
@@ -314,8 +312,6 @@
 			ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): filldir "
 					"returned %i, returning 0, f_pos "
 					"0x%Lx.\n", cb.ret_code, filp->f_pos);
-#else
-done:
 #endif
 		return 0;
 	}
diff -urN linux-2.4.17-pre5-vanilla/fs/ntfs/inode.c linux-2.4.17-pre5/fs/ntfs/inode.c
--- linux-2.4.17-pre5-vanilla/fs/ntfs/inode.c	Sun Sep 30 19:42:44 2001
+++ linux-2.4.17-pre5/fs/ntfs/inode.c	Mon Dec 10 22:50:05 2001
@@ -159,7 +159,7 @@
  * Return 0 on success or -errno on error.
  */
 static int ntfs_insert_mft_attribute(ntfs_inode* ino, int mftno,
-				     ntfs_u8 *attr)
+		ntfs_u8 *attr)
 {
 	int i, error, present = 0;
 
@@ -207,6 +207,7 @@
 	int mftno, l, error;
 	int last_mft = -1;
 	int len = *plen;
+	int tries = 0;
 	
 	if (!ino->attr) {
 		ntfs_error("parse_attributes: called on inode 0x%x without a "
@@ -230,9 +231,13 @@
 			*   then occur there or the user notified to run
 			*   ntfsck. (AIA) */
 		if (mftno != ino->i_number && mftno != last_mft) {
+continue_after_loading_mft_data:
 			last_mft = mftno;
 			error = ntfs_read_mft_record(ino->vol, mftno, mft);
 			if (error) {
+				if (error == -EINVAL && !tries)
+					goto force_load_mft_data;
+failed_reading_mft_data:
 				ntfs_debug(DEBUG_FILE3, "parse_attributes: "
 					"ntfs_read_mft_record(mftno = 0x%x) "
 					"failed\n", mftno);
@@ -272,9 +277,106 @@
 	ntfs_free(mft);
 	*plen = len;
 	return 0;
+force_load_mft_data:
+{
+	ntfs_u8 *mft2, *attr2;
+	int mftno2;
+	int last_mft2 = last_mft;
+	int len2 = len;
+	int error2;
+	int found2 = 0;
+	ntfs_u8 *alist2 = alist;
+	/*
+	 * We only get here if $DATA wasn't found in $MFT which only happens
+	 * on volume mount when $MFT has an attribute list and there are
+	 * attributes before $DATA which are inside extent mft records. So
+	 * we just skip forward to the $DATA attribute and read that. Then we
+	 * restart which is safe as an attribute will not be inserted twice.
+	 *
+	 * This still will not fix the case where the attribute list is non-
+	 * resident, larger than 1024 bytes, and the $DATA attribute list entry
+	 * is not in the first 1024 bytes. FIXME: This should be implemented
+	 * somehow! Perhaps by passing special error code up to
+	 * ntfs_load_attributes() so it keeps going trying to get to $DATA
+	 * regardless. Then it would have to restart just like we do here.
+	 */
+	mft2 = ntfs_malloc(ino->vol->mft_record_size);
+	if (!mft2) {
+		ntfs_free(mft);
+		return -ENOMEM;
+	}
+	ntfs_memcpy(mft2, mft, ino->vol->mft_record_size);
+	while (len2 > 8) {
+		l = NTFS_GETU16(alist2 + 4);
+		if (l > len2)
+			break;
+		if (NTFS_GETU32(alist2 + 0x0) < ino->vol->at_data) {
+			len2 -= l;
+			alist2 += l;
+			continue;
+		}
+		if (NTFS_GETU32(alist2 + 0x0) > ino->vol->at_data) {
+			if (found2)
+				break;
+			/* Uh-oh! It really isn't there! */
+			ntfs_error("Either the $MFT is corrupt or, equally "
+					"likely, the $MFT is too complex for "
+					"the current driver to handle. Please "
+					"email the ntfs maintainer that you "
+					"saw this message. Thank you.\n");
+			goto failed_reading_mft_data;
+		}
+	        /* Process attribute description. */
+		mftno2 = NTFS_GETU32(alist2 + 0x10); 
+		if (mftno2 != ino->i_number && mftno2 != last_mft2) {
+			last_mft2 = mftno2;
+			error2 = ntfs_read_mft_record(ino->vol, mftno2, mft2);
+			if (error2) {
+				ntfs_debug(DEBUG_FILE3, "parse_attributes: "
+					"ntfs_read_mft_record(mftno2 = 0x%x) "
+					"failed\n", mftno2);
+				ntfs_free(mft2);
+				goto failed_reading_mft_data;
+			}
+		}
+		attr2 = ntfs_find_attr_in_mft_rec(
+				ino->vol,		 /* ntfs volume */
+				mftno2 == ino->i_number ?/* mft record is: */
+					ino->attr:	 /*  base record */
+					mft2,		 /*  extension record */
+				NTFS_GETU32(alist2 + 0),	/* type */
+				(wchar_t*)(alist2 + alist2[7]),	/* name */
+				alist2[6], 		 /* name length */
+				1,			 /* ignore case */
+				NTFS_GETU16(alist2 + 24) /* instance number */
+				);
+		if (!attr2) {
+			ntfs_error("parse_attributes: mft records 0x%x and/or "
+				       "0x%x corrupt!\n", ino->i_number,
+				       mftno2);
+			ntfs_free(mft2);
+			goto failed_reading_mft_data;
+		}
+		error2 = ntfs_insert_mft_attribute(ino, mftno2, attr2);
+		if (error2) {
+			ntfs_debug(DEBUG_FILE3, "parse_attributes: "
+				"ntfs_insert_mft_attribute(mftno2 0x%x, "
+				"attribute2 type 0x%x) failed\n", mftno2,
+				NTFS_GETU32(alist2 + 0));
+			ntfs_free(mft2);
+			goto failed_reading_mft_data;
+		}
+		len2 -= l;
+		alist2 += l;
+		found2 = 1;
+	}
+	ntfs_free(mft2);
+	tries = 1;
+	goto continue_after_loading_mft_data;
+}
 }
 
-static void ntfs_load_attributes(ntfs_inode* ino)
+static void ntfs_load_attributes(ntfs_inode *ino)
 {
 	ntfs_attribute *alist;
 	int datasize;
diff -urN linux-2.4.17-pre5-vanilla/fs/ntfs/support.c linux-2.4.17-pre5/fs/ntfs/support.c
--- linux-2.4.17-pre5-vanilla/fs/ntfs/support.c	Wed Sep 12 01:02:46 2001
+++ linux-2.4.17-pre5/fs/ntfs/support.c	Mon Dec 10 20:17:08 2001
@@ -150,7 +150,7 @@
 		 * now as we just can't handle some on disk structures
 		 * this way. (AIA) */
 		printk(KERN_WARNING "NTFS: Invalid MFT record for 0x%x\n", mftno);
-		return -EINVAL;
+		return -EIO;
 	}
 	ntfs_debug(DEBUG_OTHER, "read_mft_record: Done 0x%x\n", mftno);
 	return 0;
