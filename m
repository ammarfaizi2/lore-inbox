Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268533AbUJSLEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268533AbUJSLEb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 07:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268144AbUJSKDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:03:22 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:1508 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268145AbUJSJnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:43:17 -0400
Date: Tue, 19 Oct 2004 10:43:08 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 18/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191042440.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191042560.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
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
 <Pine.LNX.4.60.0410191041420.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041590.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042200.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042440.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 18/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/07 1.2030)
   NTFS: Remove unused {__,}format_mft_record() from fs/ntfs/mft.c.
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:14:11 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:14:11 +01:00
@@ -58,6 +58,7 @@
 	  include errors.
 	- Move the typedefs for runlist_element and runlist from types.h to
 	  runlist.h and fix resulting include errors.
+	- Remove unused {__,}format_mft_record() from fs/ntfs/mft.c.
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-10-19 10:14:11 +01:00
+++ b/fs/ntfs/mft.c	2004-10-19 10:14:11 +01:00
@@ -32,79 +32,6 @@
 #include "ntfs.h"
 
 /**
- * __format_mft_record - initialize an empty mft record
- * @m:		mapped, pinned and locked for writing mft record
- * @size:	size of the mft record
- * @rec_no:	mft record number / inode number
- *
- * Private function to initialize an empty mft record. Use one of the two
- * provided format_mft_record() functions instead.
- */
-static void __format_mft_record(MFT_RECORD *m, const int size,
-		const unsigned long rec_no)
-{
-	ATTR_RECORD *a;
-
-	memset(m, 0, size);
-	m->magic = magic_FILE;
-	/* Aligned to 2-byte boundary. */
-	m->usa_ofs = cpu_to_le16((sizeof(MFT_RECORD) + 1) & ~1);
-	m->usa_count = cpu_to_le16(size / NTFS_BLOCK_SIZE + 1);
-	/* Set the update sequence number to 1. */
-	*(le16*)((char*)m + ((sizeof(MFT_RECORD) + 1) & ~1)) = cpu_to_le16(1);
-	m->lsn = cpu_to_le64(0LL);
-	m->sequence_number = cpu_to_le16(1);
-	m->link_count = 0;
-	/* Aligned to 8-byte boundary. */
-	m->attrs_offset = cpu_to_le16((le16_to_cpu(m->usa_ofs) +
-			(le16_to_cpu(m->usa_count) << 1) + 7) & ~7);
-	m->flags = 0;
-	/*
-	 * Using attrs_offset plus eight bytes (for the termination attribute),
-	 * aligned to 8-byte boundary.
-	 */
-	m->bytes_in_use = cpu_to_le32((le16_to_cpu(m->attrs_offset) + 8 + 7) &
-			~7);
-	m->bytes_allocated = cpu_to_le32(size);
-	m->base_mft_record = cpu_to_le64((MFT_REF)0);
-	m->next_attr_instance = 0;
-	a = (ATTR_RECORD*)((char*)m + le16_to_cpu(m->attrs_offset));
-	a->type = AT_END;
-	a->length = 0;
-}
-
-/**
- * format_mft_record - initialize an empty mft record
- * @ni:		ntfs inode of mft record
- * @mft_rec:	mapped, pinned and locked mft record (optional)
- *
- * Initialize an empty mft record. This is used when extending the MFT.
- *
- * If @mft_rec is NULL, we call map_mft_record() to obtain the
- * record and we unmap it again when finished.
- *
- * We return 0 on success or -errno on error.
- */
-int format_mft_record(ntfs_inode *ni, MFT_RECORD *mft_rec)
-{
-	MFT_RECORD *m;
-
-	if (mft_rec)
-		m = mft_rec;
-	else {
-		m = map_mft_record(ni);
-		if (IS_ERR(m))
-			return PTR_ERR(m);
-	}
-	__format_mft_record(m, ni->vol->mft_record_size, ni->mft_no);
-	if (!mft_rec) {
-		// FIXME: Need to set the mft record dirty!
-		unmap_mft_record(ni);
-	}
-	return 0;
-}
-
-/**
  * ntfs_readpage - external declaration, function is in fs/ntfs/aops.c
  */
 extern int ntfs_readpage(struct file *, struct page *);
