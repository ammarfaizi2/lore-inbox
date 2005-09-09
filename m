Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbVIIJ0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbVIIJ0e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbVIIJ0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:26:34 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:49040 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S965123AbVIIJ0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:26:32 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:26:22 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 12/25] NTFS: Add fs/ntfs/attrib.[hc]::ntfs_resident_attr_value_resize().
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091025540.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 12/25] NTFS: Add fs/ntfs/attrib.[hc]::ntfs_resident_attr_value_resize().

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    1 +
 fs/ntfs/attrib.c  |   40 ++++++++++++++++++++++++++++++++++++++++
 fs/ntfs/attrib.h  |    2 ++
 3 files changed, 43 insertions(+), 0 deletions(-)

0aacceacf35451ffb771ec825555e98c5dce8b01
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -59,6 +59,7 @@ ToDo/Notes:
 	  index entry is in the index root, we forgot to set the @ir pointer in
 	  the index context.  Thanks to Yura Pakhuchiy for finding this bug.
 	- Remove bogus setting of PageError in ntfs_read_compressed_block().
+	- Add fs/ntfs/attrib.[hc]::ntfs_resident_attr_value_resize().
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1247,6 +1247,46 @@ int ntfs_attr_record_resize(MFT_RECORD *
 }
 
 /**
+ * ntfs_resident_attr_value_resize - resize the value of a resident attribute
+ * @m:		mft record containing attribute record
+ * @a:		attribute record whose value to resize
+ * @new_size:	new size in bytes to which to resize the attribute value of @a
+ *
+ * Resize the value of the attribute @a in the mft record @m to @new_size bytes.
+ * If the value is made bigger, the newly allocated space is cleared.
+ *
+ * Return 0 on success and -errno on error.  The following error codes are
+ * defined:
+ *	-ENOSPC	- Not enough space in the mft record @m to perform the resize.
+ *
+ * Note: On error, no modifications have been performed whatsoever.
+ *
+ * Warning: If you make a record smaller without having copied all the data you
+ *	    are interested in the data may be overwritten.
+ */
+int ntfs_resident_attr_value_resize(MFT_RECORD *m, ATTR_RECORD *a,
+		const u32 new_size)
+{
+	u32 old_size;
+
+	/* Resize the resident part of the attribute record. */
+	if (ntfs_attr_record_resize(m, a,
+			le16_to_cpu(a->data.resident.value_offset) + new_size))
+		return -ENOSPC;
+	/*
+	 * The resize succeeded!  If we made the attribute value bigger, clear
+	 * the area between the old size and @new_size.
+	 */
+	old_size = le32_to_cpu(a->data.resident.value_length);
+	if (new_size > old_size)
+		memset((u8*)a + le16_to_cpu(a->data.resident.value_offset) +
+				old_size, 0, new_size - old_size);
+	/* Finally update the length of the attribute value. */
+	a->data.resident.value_length = cpu_to_le32(new_size);
+	return 0;
+}
+
+/**
  * ntfs_attr_make_non_resident - convert a resident to a non-resident attribute
  * @ni:		ntfs inode describing the attribute to convert
  *
diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
--- a/fs/ntfs/attrib.h
+++ b/fs/ntfs/attrib.h
@@ -99,6 +99,8 @@ extern int ntfs_attr_can_be_resident(con
 		const ATTR_TYPE type);
 
 extern int ntfs_attr_record_resize(MFT_RECORD *m, ATTR_RECORD *a, u32 new_size);
+extern int ntfs_resident_attr_value_resize(MFT_RECORD *m, ATTR_RECORD *a,
+		const u32 new_size);
 
 extern int ntfs_attr_make_non_resident(ntfs_inode *ni);
 
