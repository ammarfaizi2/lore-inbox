Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbUKJOAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbUKJOAB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbUKJN5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:57:22 -0500
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:32728 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261905AbUKJNpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:45:04 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 12/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsmO-0006PH-PT@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:44:56 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 12/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/29 1.2026.37.1)
   NTFS: Remove unused function fs/ntfs/runlist.c::ntfs_rl_merge().  (Adrian Bunk)
   
   Signed-off-by: Adrian Bunk <bunk@stusta.de>
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
--- a/fs/ntfs/ChangeLog	2004-11-10 13:45:01 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:45:01 +00:00
@@ -12,6 +12,10 @@
 	  OTOH, perhaps i_sem, which is held accross generic_file_write is
 	  sufficient for synchronisation here. We then just need to make sure
 	  ntfs_readpage/writepage/truncate interoperate properly with us.
+	  UPDATE: The above is all ok as it is due to i_sem held.  The only
+	  thing that needs to be checked is ntfs_writepage() which does not
+	  hold i_sem.  It cannot change i_size but it needs to cope with a
+	  concurrent i_size change.
 	- Implement mft.c::sync_mft_mirror_umount().  We currently will just
 	  leave the volume dirty on umount if the final iput(vol->mft_ino)
 	  causes a write of any mirrored mft records due to the mft mirror
@@ -42,7 +46,7 @@
 	  mount time as this cannot work with the current implementation.
 	- Check for location of attribute name and improve error handling in
 	  general in fs/ntfs/inode.c::ntfs_read_locked_inode() and friends.
-	- In fs/ntfs/aops.c::ntfs_writepage(), if t he page is fully outside
+	- In fs/ntfs/aops.c::ntfs_writepage(), if the page is fully outside
 	  i_size, i.e. race with truncate, invalidate the buffers on the page
 	  so that they become freeable and hence the page does not leak.
 	- Implement extension of resident files in the regular file write code
@@ -50,6 +54,8 @@
 	  this only works until the data attribute becomes too big for the mft
 	  record after which we abort the write returning -EOPNOTSUPP from
 	  ntfs_prepare_write().
+	- Remove unused function fs/ntfs/runlist.c::ntfs_rl_merge().  (Adrian
+	  Bunk)
 
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
diff -Nru a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
--- a/fs/ntfs/runlist.c	2004-11-10 13:45:01 +00:00
+++ b/fs/ntfs/runlist.c	2004-11-10 13:45:01 +00:00
@@ -140,30 +140,6 @@
 }
 
 /**
- * ntfs_rl_merge - test if two runlists can be joined together and merge them
- * @dst:	original, destination runlist
- * @src:	new runlist to merge with @dst
- *
- * Test if two runlists can be joined together. For this, their VCNs and LCNs
- * must be adjacent. If they can be merged, perform the merge, writing into
- * the destination runlist @dst.
- *
- * It is up to the caller to serialize access to the runlists @dst and @src.
- *
- * Return: TRUE   Success, the runlists have been merged.
- *	   FALSE  Failure, the runlists cannot be merged and have not been
- *		  modified.
- */
-static inline BOOL ntfs_rl_merge(runlist_element *dst, runlist_element *src)
-{
-	BOOL merge = ntfs_are_rl_mergeable(dst, src);
-
-	if (merge)
-		__ntfs_rl_merge(dst, src);
-	return merge;
-}
-
-/**
  * ntfs_rl_append - append a runlist after a given element
  * @dst:	original runlist to be worked on
  * @dsize:	number of elements in @dst (including end marker)
