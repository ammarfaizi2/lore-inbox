Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268130AbUJSJzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268130AbUJSJzj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268132AbUJSJyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:54:01 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:4295 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268131AbUJSJmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:42:02 -0400
Date: Tue, 19 Oct 2004 10:41:56 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 13/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191041290.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191041420.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038250.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038570.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039140.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039510.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040050.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040220.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040360.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040490.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041050.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041180.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041290.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 13/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/03 1.2017)
   NTFS: Add MFT_RECORD_OLD as a copy of MFT_RECORD in fs/ntfs/layout.h
         and change MFT_RECORD to contain the NTFS 3.1+ specific fields.
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:13:53 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:13:53 +01:00
@@ -45,6 +45,8 @@
 	  fs/ntfs/logfile.c::ntfs_empty_logfile() to using it.
 	- Remove unnecessary casts from LCN_* constants.
 	- Implement fs/ntfs/runlist.c::ntfs_rl_truncate_nolock().
+	- Add MFT_RECORD_OLD as a copy of MFT_RECORD in fs/ntfs/layout.h and
+	  change MFT_RECORD to contain the NTFS 3.1+ specific fields.
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/layout.h b/fs/ntfs/layout.h
--- a/fs/ntfs/layout.h	2004-10-19 10:13:53 +01:00
+++ b/fs/ntfs/layout.h	2004-10-19 10:13:53 +01:00
@@ -260,7 +260,7 @@
 enum {
 	MFT_RECORD_IN_USE	= const_cpu_to_le16(0x0001),
 	MFT_RECORD_IS_DIRECTORY = const_cpu_to_le16(0x0002),
-};
+} __attrobite__ ((__packed__));
 
 typedef le16 MFT_RECORD_FLAGS;
 
@@ -385,21 +385,86 @@
 				   NOTE: Every time the mft record is reused
 				   this number is set to zero.  NOTE: The first
 				   instance number is always 0. */
-/* sizeof() = 42 bytes */
-/* NTFS 3.1+ (Windows XP and above) introduce the following additions. */
-/* 42*/ //le16 reserved;	/* Reserved/alignment. */
-/* 44*/ //le32 mft_record_number;/* Number of this mft record. */
+/* The below fields are specific to NTFS 3.1+ (Windows XP and above): */
+/* 42*/ le16 reserved;		/* Reserved/alignment. */
+/* 44*/ le32 mft_record_number;	/* Number of this mft record. */
 /* sizeof() = 48 bytes */
 /*
  * When (re)using the mft record, we place the update sequence array at this
- * offset, i.e. before we start with the attributes. This also makes sense,
+ * offset, i.e. before we start with the attributes.  This also makes sense,
  * otherwise we could run into problems with the update sequence array
  * containing in itself the last two bytes of a sector which would mean that
- * multi sector transfer protection wouldn't work. As you can't protect data
+ * multi sector transfer protection wouldn't work.  As you can't protect data
  * by overwriting it since you then can't get it back...
  * When reading we obviously use the data from the ntfs record header.
  */
 } __attribute__ ((__packed__)) MFT_RECORD;
+
+/* This is the version without the NTFS 3.1+ specific fields. */
+typedef struct {
+/*Ofs*/
+/*  0	NTFS_RECORD; -- Unfolded here as gcc doesn't like unnamed structs. */
+	NTFS_RECORD_TYPE magic;	/* Usually the magic is "FILE". */
+	le16 usa_ofs;		/* See NTFS_RECORD definition above. */
+	le16 usa_count;		/* See NTFS_RECORD definition above. */
+
+/*  8*/	le64 lsn;		/* $LogFile sequence number for this record.
+				   Changed every time the record is modified. */
+/* 16*/	le16 sequence_number;	/* Number of times this mft record has been
+				   reused. (See description for MFT_REF
+				   above.) NOTE: The increment (skipping zero)
+				   is done when the file is deleted. NOTE: If
+				   this is zero it is left zero. */
+/* 18*/	le16 link_count;	/* Number of hard links, i.e. the number of
+				   directory entries referencing this record.
+				   NOTE: Only used in mft base records.
+				   NOTE: When deleting a directory entry we
+				   check the link_count and if it is 1 we
+				   delete the file. Otherwise we delete the
+				   FILE_NAME_ATTR being referenced by the
+				   directory entry from the mft record and
+				   decrement the link_count.
+				   FIXME: Careful with Win32 + DOS names! */
+/* 20*/	le16 attrs_offset;	/* Byte offset to the first attribute in this
+				   mft record from the start of the mft record.
+				   NOTE: Must be aligned to 8-byte boundary. */
+/* 22*/	MFT_RECORD_FLAGS flags;	/* Bit array of MFT_RECORD_FLAGS. When a file
+				   is deleted, the MFT_RECORD_IN_USE flag is
+				   set to zero. */
+/* 24*/	le32 bytes_in_use;	/* Number of bytes used in this mft record.
+				   NOTE: Must be aligned to 8-byte boundary. */
+/* 28*/	le32 bytes_allocated;	/* Number of bytes allocated for this mft
+				   record. This should be equal to the mft
+				   record size. */
+/* 32*/	leMFT_REF base_mft_record;/* This is zero for base mft records.
+				   When it is not zero it is a mft reference
+				   pointing to the base mft record to which
+				   this record belongs (this is then used to
+				   locate the attribute list attribute present
+				   in the base record which describes this
+				   extension record and hence might need
+				   modification when the extension record
+				   itself is modified, also locating the
+				   attribute list also means finding the other
+				   potential extents, belonging to the non-base
+				   mft record). */
+/* 40*/	le16 next_attr_instance;/* The instance number that will be assigned to
+				   the next attribute added to this mft record.
+				   NOTE: Incremented each time after it is used.
+				   NOTE: Every time the mft record is reused
+				   this number is set to zero.  NOTE: The first
+				   instance number is always 0. */
+/* sizeof() = 42 bytes */
+/*
+ * When (re)using the mft record, we place the update sequence array at this
+ * offset, i.e. before we start with the attributes.  This also makes sense,
+ * otherwise we could run into problems with the update sequence array
+ * containing in itself the last two bytes of a sector which would mean that
+ * multi sector transfer protection wouldn't work.  As you can't protect data
+ * by overwriting it since you then can't get it back...
+ * When reading we obviously use the data from the ntfs record header.
+ */
+} __attribute__ ((__packed__)) MFT_RECORD_OLD;
 
 /*
  * System defined attributes (32-bit).  Each attribute type has a corresponding
