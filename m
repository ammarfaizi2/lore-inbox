Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWCWRZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWCWRZs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWCWRZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:25:48 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:63876 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932203AbWCWRZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:25:47 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 23 Mar 2006 17:25:40 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 07/14] NTFS: Remove all the make_bad_inode() calls.
In-Reply-To: <Pine.LNX.4.64.0603231724200.18984@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0603231724570.18984@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0603231713430.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231717460.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231720130.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231721240.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231722330.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231723320.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231724200.18984@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Remove all the make_bad_inode() calls.  This should only be called
      from read inode and new inode code paths.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

 fs/ntfs/ChangeLog |    2 ++
 fs/ntfs/aops.c    |    1 -
 fs/ntfs/attrib.c  |    6 ------
 fs/ntfs/file.c    |   13 +------------
 fs/ntfs/mft.c     |    1 +
 fs/ntfs/mft.h     |    5 +----
 6 files changed, 5 insertions(+), 23 deletions(-)

f95c4018fd4b0bdef9b1bcb4eac7056e2a07282a
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index b577423..13e70d4 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -32,6 +32,8 @@ ToDo/Notes:
 	  unused, invalid mft records which are the same in both $MFT and
 	  $MFTMirr.
 	- Add support for sparse files which have a compression unit of 0.
+	- Remove all the make_bad_inode() calls.  This should only be called
+	  from read inode and new inode code paths.
 
 2.1.26 - Minor bug fixes and updates.
 
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 7c7e313..1cf105b 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1530,7 +1530,6 @@ err_out:
 				"error %i.", err);
 		SetPageError(page);
 		NVolSetErrors(ni->vol);
-		make_bad_inode(vi);
 	}
 	unlock_page(page);
 	if (ctx)
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 7a568eb..1663f5c 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -2438,16 +2438,12 @@ undo_alloc:
 				"chkdsk to recover.", IS_ERR(m) ?
 				"restore attribute search context" :
 				"truncate attribute runlist");
-		make_bad_inode(vi);
-		make_bad_inode(VFS_I(base_ni));
 		NVolSetErrors(vol);
 	} else if (mp_rebuilt) {
 		if (ntfs_attr_record_resize(m, a, attr_len)) {
 			ntfs_error(vol->sb, "Failed to restore attribute "
 					"record in error code path.  Run "
 					"chkdsk to recover.");
-			make_bad_inode(vi);
-			make_bad_inode(VFS_I(base_ni));
 			NVolSetErrors(vol);
 		} else /* if (success) */ {
 			if (ntfs_mapping_pairs_build(vol, (u8*)a + le16_to_cpu(
@@ -2460,8 +2456,6 @@ undo_alloc:
 						"mapping pairs array in error "
 						"code path.  Run chkdsk to "
 						"recover.");
-				make_bad_inode(vi);
-				make_bad_inode(VFS_I(base_ni));
 				NVolSetErrors(vol);
 			}
 			flush_dcache_mft_record_page(ctx->ntfs_ino);
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 2e5ba0c..f5d057e 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1207,8 +1207,6 @@ rl_not_mapped_enoent:
 					"attribute runlist in error code "
 					"path.  Run chkdsk to recover the "
 					"lost cluster.");
-			make_bad_inode(vi);
-			make_bad_inode(VFS_I(base_ni));
 			NVolSetErrors(vol);
 		} else /* if (success) */ {
 			status.runlist_merged = 0;
@@ -1239,8 +1237,6 @@ rl_not_mapped_enoent:
 			ntfs_error(vol->sb, "Failed to restore attribute "
 					"record in error code path.  Run "
 					"chkdsk to recover.");
-			make_bad_inode(vi);
-			make_bad_inode(VFS_I(base_ni));
 			NVolSetErrors(vol);
 		} else /* if (success) */ {
 			if (ntfs_mapping_pairs_build(vol, (u8*)a +
@@ -1253,8 +1249,6 @@ rl_not_mapped_enoent:
 						"mapping pairs array in error "
 						"code path.  Run chkdsk to "
 						"recover.");
-				make_bad_inode(vi);
-				make_bad_inode(VFS_I(base_ni));
 				NVolSetErrors(vol);
 			}
 			flush_dcache_mft_record_page(ctx->ntfs_ino);
@@ -1623,11 +1617,8 @@ err_out:
 		unmap_mft_record(base_ni);
 	ntfs_error(vi->i_sb, "Failed to update initialized_size/i_size (error "
 			"code %i).", err);
-	if (err != -ENOMEM) {
+	if (err != -ENOMEM)
 		NVolSetErrors(ni->vol);
-		make_bad_inode(VFS_I(base_ni));
-		make_bad_inode(vi);
-	}
 	return err;
 }
 
@@ -1802,8 +1793,6 @@ err_out:
 		ntfs_error(vi->i_sb, "Resident attribute commit write failed "
 				"with error %i.", err);
 		NVolSetErrors(ni->vol);
-		make_bad_inode(VFS_I(base_ni));
-		make_bad_inode(vi);
 	}
 	if (ctx)
 		ntfs_attr_put_search_ctx(ctx);
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 6499aaf..7254391 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -93,6 +93,7 @@ static inline MFT_RECORD *map_mft_record
 				"Run chkdsk.", ni->mft_no);
 		ntfs_unmap_page(page);
 		page = ERR_PTR(-EIO);
+		NVolSetErrors(vol);
 	}
 err_out:
 	ni->page = NULL;
diff --git a/fs/ntfs/mft.h b/fs/ntfs/mft.h
index 407de2c..639cd1b 100644
--- a/fs/ntfs/mft.h
+++ b/fs/ntfs/mft.h
@@ -97,10 +97,7 @@ extern int write_mft_record_nolock(ntfs_
  * uptodate.
  *
  * On success, clean the mft record and return 0.  On error, leave the mft
- * record dirty and return -errno.  The caller should call make_bad_inode() on
- * the base inode to ensure no more access happens to this inode.  We do not do
- * it here as the caller may want to finish writing other extent mft records
- * first to minimize on-disk metadata inconsistencies.
+ * record dirty and return -errno.
  */
 static inline int write_mft_record(ntfs_inode *ni, MFT_RECORD *m, int sync)
 {
-- 
1.2.3.g9821

