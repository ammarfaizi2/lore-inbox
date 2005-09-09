Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbVIIJa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbVIIJa4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbVIIJa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:30:56 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:53432 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030189AbVIIJai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:30:38 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:30:28 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 22/25] NTFS: Fixup handling of sparse, compressed, and
 encrypted attributes in
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091030110.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 22/25] NTFS: Fixup handling of sparse, compressed, and encrypted attributes in
      fs/ntfs/aops.c::ntfs_readpage().

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    5 ++---
 fs/ntfs/aops.c    |   41 ++++++++++++++++++++++++-----------------
 2 files changed, 26 insertions(+), 20 deletions(-)

311120eca0013083f5eb0aff13ffb8aa9fdd050c
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -76,11 +76,10 @@ ToDo/Notes:
 	- Truncate {a,c,m}time to the ntfs supported time granularity when
 	  updating the times in the inode in ntfs_setattr().
 	- Fixup handling of sparse, compressed, and encrypted attributes in
-	  fs/ntfs/inode.c::ntfs_read_locked_{,attr_,index_}inode().
+	  fs/ntfs/inode.c::ntfs_read_locked_{,attr_,index_}inode(),
+	  fs/ntfs/aops.c::ntfs_{read,write}page().
 	- Make ntfs_write_block() not instantiate sparse blocks if they contain
 	  only zeroes.
-	- Fixup handling of sparse, compressed, and encrypted attributes in
-	  fs/ntfs/aops.c::ntfs_writepage().
 	- Optimize fs/ntfs/aops.c::ntfs_write_block() by extending the page
 	  lock protection over the buffer submission for i/o which allows the
 	  removal of the get_bh()/put_bh() pairs for each buffer.
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -379,31 +379,38 @@ retry_readpage:
 		return 0;
 	}
 	ni = NTFS_I(page->mapping->host);
-
+	/*
+	 * Only $DATA attributes can be encrypted and only unnamed $DATA
+	 * attributes can be compressed.  Index root can have the flags set but
+	 * this means to create compressed/encrypted files, not that the
+	 * attribute is compressed/encrypted.
+	 */
+	if (ni->type != AT_INDEX_ROOT) {
+		/* If attribute is encrypted, deny access, just like NT4. */
+		if (NInoEncrypted(ni)) {
+			BUG_ON(ni->type != AT_DATA);
+			err = -EACCES;
+			goto err_out;
+		}
+		/* Compressed data streams are handled in compress.c. */
+		if (NInoNonResident(ni) && NInoCompressed(ni)) {
+			BUG_ON(ni->type != AT_DATA);
+			BUG_ON(ni->name_len);
+			return ntfs_read_compressed_block(page);
+		}
+	}
 	/* NInoNonResident() == NInoIndexAllocPresent() */
 	if (NInoNonResident(ni)) {
-		/*
-		 * Only unnamed $DATA attributes can be compressed or
-		 * encrypted.
-		 */
-		if (ni->type == AT_DATA && !ni->name_len) {
-			/* If file is encrypted, deny access, just like NT4. */
-			if (NInoEncrypted(ni)) {
-				err = -EACCES;
-				goto err_out;
-			}
-			/* Compressed data streams are handled in compress.c. */
-			if (NInoCompressed(ni))
-				return ntfs_read_compressed_block(page);
-		}
-		/* Normal data stream. */
+		/* Normal, non-resident data stream. */
 		return ntfs_read_block(page);
 	}
 	/*
 	 * Attribute is resident, implying it is not compressed or encrypted.
 	 * This also means the attribute is smaller than an mft record and
 	 * hence smaller than a page, so can simply zero out any pages with
-	 * index above 0.
+	 * index above 0.  Note the attribute can actually be marked compressed
+	 * but if it is resident the actual data is not compressed so we are
+	 * ok to ignore the compressed flag here.
 	 */
 	if (unlikely(page->index > 0)) {
 		kaddr = kmap_atomic(page, KM_USER0);

