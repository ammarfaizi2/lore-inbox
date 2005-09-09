Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbVIIJaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbVIIJaR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbVIIJaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:30:17 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:51152 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030204AbVIIJaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:30:11 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:30:08 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 21/25] NTFS: Fix fs/ntfs/aops.c::ntfs_{read,write}_block()
 to handle the case
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091029520.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 21/25] NTFS: Fix fs/ntfs/aops.c::ntfs_{read,write}_block() to handle the case
      where a concurrent truncate has truncated the runlist under our feet.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    2 ++
 fs/ntfs/aops.c    |   51 ++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 42 insertions(+), 11 deletions(-)

8273d5d4c28a9fde68f830cc6ff61e37e8ae1dca
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -84,6 +84,8 @@ ToDo/Notes:
 	- Optimize fs/ntfs/aops.c::ntfs_write_block() by extending the page
 	  lock protection over the buffer submission for i/o which allows the
 	  removal of the get_bh()/put_bh() pairs for each buffer.
+	- Fix fs/ntfs/aops.c::ntfs_{read,write}_block() to handle the case
+	  where a concurrent truncate has truncated the runlist under our feet.
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -204,6 +204,7 @@ static int ntfs_read_block(struct page *
 	nr = i = 0;
 	do {
 		u8 *kaddr;
+		int err;
 
 		if (unlikely(buffer_uptodate(bh)))
 			continue;
@@ -211,6 +212,7 @@ static int ntfs_read_block(struct page *
 			arr[nr++] = bh;
 			continue;
 		}
+		err = 0;
 		bh->b_bdev = vol->sb->s_bdev;
 		/* Is the block within the allowed limits? */
 		if (iblock < lblock) {
@@ -252,7 +254,6 @@ lock_retry_remap:
 				goto handle_hole;
 			/* If first try and runlist unmapped, map and retry. */
 			if (!is_retry && lcn == LCN_RL_NOT_MAPPED) {
-				int err;
 				is_retry = TRUE;
 				/*
 				 * Attempt to map runlist, dropping lock for
@@ -263,20 +264,30 @@ lock_retry_remap:
 				if (likely(!err))
 					goto lock_retry_remap;
 				rl = NULL;
-				lcn = err;
 			} else if (!rl)
 				up_read(&ni->runlist.lock);
+			/*
+			 * If buffer is outside the runlist, treat it as a
+			 * hole.  This can happen due to concurrent truncate
+			 * for example.
+			 */
+			if (err == -ENOENT || lcn == LCN_ENOENT) {
+				err = 0;
+				goto handle_hole;
+			}
 			/* Hard error, zero out region. */
+			if (!err)
+				err = -EIO;
 			bh->b_blocknr = -1;
 			SetPageError(page);
 			ntfs_error(vol->sb, "Failed to read from inode 0x%lx, "
 					"attribute type 0x%x, vcn 0x%llx, "
 					"offset 0x%x because its location on "
 					"disk could not be determined%s "
-					"(error code %lli).", ni->mft_no,
+					"(error code %i).", ni->mft_no,
 					ni->type, (unsigned long long)vcn,
 					vcn_ofs, is_retry ? " even after "
-					"retrying" : "", (long long)lcn);
+					"retrying" : "", err);
 		}
 		/*
 		 * Either iblock was outside lblock limits or
@@ -289,9 +300,10 @@ handle_hole:
 handle_zblock:
 		kaddr = kmap_atomic(page, KM_USER0);
 		memset(kaddr + i * blocksize, 0, blocksize);
-		flush_dcache_page(page);
 		kunmap_atomic(kaddr, KM_USER0);
-		set_buffer_uptodate(bh);
+		flush_dcache_page(page);
+		if (likely(!err))
+			set_buffer_uptodate(bh);
 	} while (i++, iblock++, (bh = bh->b_this_page) != head);
 
 	/* Release the lock if we took it. */
@@ -711,20 +723,37 @@ lock_retry_remap:
 			if (likely(!err))
 				goto lock_retry_remap;
 			rl = NULL;
-			lcn = err;
 		} else if (!rl)
 			up_read(&ni->runlist.lock);
+		/*
+		 * If buffer is outside the runlist, truncate has cut it out
+		 * of the runlist.  Just clean and clear the buffer and set it
+		 * uptodate so it can get discarded by the VM.
+		 */
+		if (err == -ENOENT || lcn == LCN_ENOENT) {
+			u8 *kaddr;
+
+			bh->b_blocknr = -1;
+			clear_buffer_dirty(bh);
+			kaddr = kmap_atomic(page, KM_USER0);
+			memset(kaddr + bh_offset(bh), 0, blocksize);
+			kunmap_atomic(kaddr, KM_USER0);
+			flush_dcache_page(page);
+			set_buffer_uptodate(bh);
+			err = 0;
+			continue;
+		}
 		/* Failed to map the buffer, even after retrying. */
+		if (!err)
+			err = -EIO;
 		bh->b_blocknr = -1;
 		ntfs_error(vol->sb, "Failed to write to inode 0x%lx, "
 				"attribute type 0x%x, vcn 0x%llx, offset 0x%x "
 				"because its location on disk could not be "
-				"determined%s (error code %lli).", ni->mft_no,
+				"determined%s (error code %i).", ni->mft_no,
 				ni->type, (unsigned long long)vcn,
 				vcn_ofs, is_retry ? " even after "
-				"retrying" : "", (long long)lcn);
-		if (!err)
-			err = -EIO;
+				"retrying" : "", err);
 		break;
 	} while (block++, (bh = bh->b_this_page) != head);
 
