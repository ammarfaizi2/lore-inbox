Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbVJaOiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVJaOiT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVJaOiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:38:19 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:16599 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932280AbVJaOiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:38:18 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 31 Oct 2005 14:38:13 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 13/17] NTFS: $EA attributes can be both resident non-resident.
In-Reply-To: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0510311436400.27357@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: $EA attributes can be both resident non-resident.
      Minor tidying.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    1 +
 fs/ntfs/aops.c    |    5 ++---
 fs/ntfs/attrib.c  |    2 +-
 fs/ntfs/file.c    |   14 ++++++++++++++
 fs/ntfs/layout.h  |   27 +++++++++++++++++----------
 5 files changed, 35 insertions(+), 14 deletions(-)

applies-to: 8892cc84dbee2b4387c9f2604a7892b6ef3aab25
7d0ffdb279105d9a87b447758ce4a634496abfd1
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 03015c7..bc6ec16 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -75,6 +75,7 @@ ToDo/Notes:
 	  for highly fragmented files, i.e. ones whose data attribute is split
 	  across multiple extents.   When such a case is encountered,
 	  EOPNOTSUPP is returned.
+	- $EA attributes can be both resident non-resident.
 
 2.1.24 - Lots of bug fixes and support more clean journal states.
 
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 8f23c60..1c0a431 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1391,8 +1391,7 @@ retry_writepage:
 		if (NInoEncrypted(ni)) {
 			unlock_page(page);
 			BUG_ON(ni->type != AT_DATA);
-			ntfs_debug("Denying write access to encrypted "
-					"file.");
+			ntfs_debug("Denying write access to encrypted file.");
 			return -EACCES;
 		}
 		/* Compressed data streams are handled in compress.c. */
@@ -1508,8 +1507,8 @@ retry_writepage:
 	/* Zero out of bounds area in the page cache page. */
 	memset(kaddr + attr_len, 0, PAGE_CACHE_SIZE - attr_len);
 	kunmap_atomic(kaddr, KM_USER0);
-	flush_dcache_mft_record_page(ctx->ntfs_ino);
 	flush_dcache_page(page);
+	flush_dcache_mft_record_page(ctx->ntfs_ino);
 	/* We are done with the page. */
 	end_page_writeback(page);
 	/* Finally, mark the mft record dirty, so it gets written back. */
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 338e471..df2e209 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1411,7 +1411,7 @@ int ntfs_attr_can_be_non_resident(const 
  */
 int ntfs_attr_can_be_resident(const ntfs_volume *vol, const ATTR_TYPE type)
 {
-	if (type == AT_INDEX_ALLOCATION || type == AT_EA)
+	if (type == AT_INDEX_ALLOCATION)
 		return -EPERM;
 	return 0;
 }
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index cf2a0e2..5fb341a 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1857,10 +1857,24 @@ static ssize_t ntfs_file_buffered_write(
 	if (ni->type != AT_INDEX_ALLOCATION) {
 		/* If file is encrypted, deny access, just like NT4. */
 		if (NInoEncrypted(ni)) {
+			/*
+			 * Reminder for later: Encrypted files are _always_
+			 * non-resident so that the content can always be
+			 * encrypted.
+			 */
 			ntfs_debug("Denying write access to encrypted file.");
 			return -EACCES;
 		}
 		if (NInoCompressed(ni)) {
+			/* Only unnamed $DATA attribute can be compressed. */
+			BUG_ON(ni->type != AT_DATA);
+			BUG_ON(ni->name_len);
+			/*
+			 * Reminder for later: If resident, the data is not
+			 * actually compressed.  Only on the switch to non-
+			 * resident does compression kick in.  This is in
+			 * contrast to encrypted files (see above).
+			 */
 			ntfs_error(vi->i_sb, "Writing to compressed files is "
 					"not implemented yet.  Sorry.");
 			return -EOPNOTSUPP;
diff --git a/fs/ntfs/layout.h b/fs/ntfs/layout.h
index 5c248d4..71b25da 100644
--- a/fs/ntfs/layout.h
+++ b/fs/ntfs/layout.h
@@ -1021,10 +1021,17 @@ enum {
 	FILE_NAME_POSIX		= 0x00,
 	/* This is the largest namespace. It is case sensitive and allows all
 	   Unicode characters except for: '\0' and '/'.  Beware that in
-	   WinNT/2k files which eg have the same name except for their case
-	   will not be distinguished by the standard utilities and thus a "del
-	   filename" will delete both "filename" and "fileName" without
-	   warning. */
+	   WinNT/2k/2003 by default files which eg have the same name except
+	   for their case will not be distinguished by the standard utilities
+	   and thus a "del filename" will delete both "filename" and "fileName"
+	   without warning.  However if for example Services For Unix (SFU) are
+	   installed and the case sensitive option was enabled at installation
+	   time, then you can create/access/delete such files.
+	   Note that even SFU places restrictions on the filenames beyond the
+	   '\0' and '/' and in particular the following set of characters is
+	   not allowed: '"', '/', '<', '>', '\'.  All other characters,
+	   including the ones no allowed in WIN32 namespace are allowed.
+	   Tested with SFU 3.5 (this is now free) running on Windows XP. */
 	FILE_NAME_WIN32		= 0x01,
 	/* The standard WinNT/2k NTFS long filenames. Case insensitive.  All
 	   Unicode chars except: '\0', '"', '*', '/', ':', '<', '>', '?', '\',
@@ -2375,20 +2382,20 @@ typedef u8 EA_FLAGS;
 /*
  * Attribute: Extended attribute (EA) (0xe0).
  *
- * NOTE: Always non-resident. (Is this true?)
+ * NOTE: Can be resident or non-resident.
  *
  * Like the attribute list and the index buffer list, the EA attribute value is
  * a sequence of EA_ATTR variable length records.
- *
- * FIXME: It appears weird that the EA name is not unicode. Is it true?
  */
 typedef struct {
 	le32 next_entry_offset;	/* Offset to the next EA_ATTR. */
 	EA_FLAGS flags;		/* Flags describing the EA. */
-	u8 ea_name_length;	/* Length of the name of the EA in bytes. */
+	u8 ea_name_length;	/* Length of the name of the EA in bytes
+				   excluding the '\0' byte terminator. */
 	le16 ea_value_length;	/* Byte size of the EA's value. */
-	u8 ea_name[0];		/* Name of the EA. */
-	u8 ea_value[0];		/* The value of the EA. Immediately follows
+	u8 ea_name[0];		/* Name of the EA.  Note this is ASCII, not
+				   Unicode and it is zero terminated. */
+	u8 ea_value[0];		/* The value of the EA.  Immediately follows
 				   the name. */
 } __attribute__ ((__packed__)) EA_ATTR;
 
---
0.99.9
