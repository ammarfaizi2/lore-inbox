Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317544AbSHTXma>; Tue, 20 Aug 2002 19:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317571AbSHTXm3>; Tue, 20 Aug 2002 19:42:29 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:50309 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317544AbSHTXmX>; Tue, 20 Aug 2002 19:42:23 -0400
Subject: [BK-2.5 PATCH] NTFS 2.1.0 4/7: Minor cleanups from 2.4 backport
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 21 Aug 2002 00:46:28 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17hIhg-0001KE-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-2.5

Thanks! And the 4th changeset, minor cleanup while resyncing with 2.4
backport.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 fs/ntfs/aops.c     |    2 +-
 fs/ntfs/attrib.c   |    4 ++--
 fs/ntfs/compress.c |    8 ++++----
 fs/ntfs/dir.c      |    6 ++----
 fs/ntfs/inode.c    |    2 +-
 fs/ntfs/mft.c      |    4 ++--
 fs/ntfs/namei.c    |    4 ++--
 7 files changed, 14 insertions(+), 16 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/08/14 1.456.33.1)
   NTFS: Cleanups, mostly whitespace. Found during resync with 2.4 backport.


diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	Tue Aug 20 23:57:33 2002
+++ b/fs/ntfs/aops.c	Tue Aug 20 23:57:33 2002
@@ -385,7 +385,7 @@
 	else
 		base_ni = ni->_INE(base_ntfs_ino);
 
-	/* Map, pin and lock the mft record. */
+	/* Map, pin, and lock the mft record. */
 	mrec = map_mft_record(base_ni);
 	if (unlikely(IS_ERR(mrec))) {
 		err = PTR_ERR(mrec);
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	Tue Aug 20 23:57:33 2002
+++ b/fs/ntfs/attrib.c	Tue Aug 20 23:57:33 2002
@@ -1676,7 +1676,7 @@
 		return;
 	} /* Attribute list. */
 	if (ctx->ntfs_ino != ctx->base_ntfs_ino)
-		unmap_mft_record(ctx->ntfs_ino);
+		unmap_extent_mft_record(ctx->ntfs_ino);
 	init_attr_search_ctx(ctx, ctx->base_ntfs_ino, ctx->base_mrec);
 	return;
 }
@@ -1709,7 +1709,7 @@
 void put_attr_search_ctx(attr_search_context *ctx)
 {
 	if (ctx->base_ntfs_ino && ctx->ntfs_ino != ctx->base_ntfs_ino)
-		unmap_mft_record(ctx->ntfs_ino);
+		unmap_extent_mft_record(ctx->ntfs_ino);
 	kmem_cache_free(ntfs_attr_ctx_cache, ctx);
 	return;
 }
diff -Nru a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c	Tue Aug 20 23:57:33 2002
+++ b/fs/ntfs/compress.c	Tue Aug 20 23:57:33 2002
@@ -609,18 +609,18 @@
 		if (buffer_uptodate(tbh))
 			continue;
 		wait_on_buffer(tbh);
-		/*      
+		/*
 		 * We need an optimization barrier here, otherwise we start
 		 * hitting the below fixup code when accessing a loopback
 		 * mounted ntfs partition. This indicates either there is a
 		 * race condition in the loop driver or, more likely, gcc
-		 * overoptimises the code without the barrier and it doesn't 
+		 * overoptimises the code without the barrier and it doesn't
 		 * do the Right Thing(TM).
-		 */      
+		 */
 		barrier();
 		if (unlikely(!buffer_uptodate(tbh))) {
 			ntfs_warning(vol->sb, "Buffer is unlocked but not "
-					"uptodate! Unplugging the disk queue " 
+					"uptodate! Unplugging the disk queue "
 					"and rescheduling.");
 			get_bh(tbh);
 			blk_run_queues();
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	Tue Aug 20 23:57:33 2002
+++ b/fs/ntfs/dir.c	Tue Aug 20 23:57:33 2002
@@ -1048,9 +1048,7 @@
 /*
  * VFS calls readdir without BKL but with i_sem held. This protects the VFS
  * parts (e.g. ->f_pos and ->i_size, and it also protects against directory
- * modifications). Together with the rw semaphore taken by the call to
- * map_mft_record(), the directory is truly locked down so we have a race free
- * ntfs_readdir() without the BKL. (-:
+ * modifications).
  *
  * We use the same basic approach as the old NTFS driver, i.e. we parse the
  * index root entries and then the index allocation entries that are marked
@@ -1181,7 +1179,7 @@
 	 */
 	put_attr_search_ctx(ctx);
 	unmap_mft_record(ndir);
-	m = NULL; 
+	m = NULL;
 	ctx = NULL;
 	/* If there is no index allocation attribute we are finished. */
 	if (!NInoIndexAllocPresent(ndir))
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	Tue Aug 20 23:57:33 2002
+++ b/fs/ntfs/inode.c	Tue Aug 20 23:57:33 2002
@@ -844,7 +844,7 @@
 				ctx->attr->_ANR(allocated_size));
 		/*
 		 * We are done with the mft record, so we release it. Otherwise
-		 *
+		 * we would deadlock in ntfs_attr_iget().
 		 */
 		put_attr_search_ctx(ctx);
 		unmap_mft_record(ni);
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	Tue Aug 20 23:57:33 2002
+++ b/fs/ntfs/mft.c	Tue Aug 20 23:57:33 2002
@@ -176,8 +176,8 @@
  * First, take the mrec_lock semaphore. We might now be sleeping, while waiting
  * for the semaphore if it was already locked by someone else.
  *
- * The page of the record is first mapped using map_mft_record_page() before
- * being returned to the caller.
+ * The page of the record is mapped using map_mft_record_page() before being
+ * returned to the caller.
  *
  * This in turn uses ntfs_map_page() to get the page containing the wanted mft
  * record (it in turn calls read_cache_page() which reads it in from disk if
diff -Nru a/fs/ntfs/namei.c b/fs/ntfs/namei.c
--- a/fs/ntfs/namei.c	Tue Aug 20 23:57:33 2002
+++ b/fs/ntfs/namei.c	Tue Aug 20 23:57:33 2002
@@ -139,8 +139,8 @@
 			dent_inode = ERR_PTR(-EIO);
 		} else
 			ntfs_error(vol->sb, "ntfs_iget(0x%lx) failed with "
-				   "error code %li.", dent_ino,
-				   PTR_ERR(dent_inode));
+					"error code %li.", dent_ino,
+					PTR_ERR(dent_inode));
 		if (name)
 			kfree(name);
 		/* Return the error code. */

