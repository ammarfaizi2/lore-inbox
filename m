Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbUKJNvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbUKJNvn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 08:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbUKJNtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 08:49:11 -0500
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:41942 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261897AbUKJNoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:44:54 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 10/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsmG-0006Oi-KK@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:44:48 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 10/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/28 1.2026.1.35)
   NTFS: In fs/ntfs/aops.c::ntfs_writepage(), if t he page is fully outside
         i_size, i.e. race with truncate, invalidate the buffers on the page
         so that they become freeable and hence the page does not leak.
   
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
--- a/fs/ntfs/ChangeLog	2004-11-10 13:44:52 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:44:52 +00:00
@@ -42,6 +42,9 @@
 	  mount time as this cannot work with the current implementation.
 	- Check for location of attribute name and improve error handling in
 	  general in fs/ntfs/inode.c::ntfs_read_locked_inode() and friends.
+	- In fs/ntfs/aops.c::ntfs_writepage(), if t he page is fully outside
+	  i_size, i.e. race with truncate, invalidate the buffers on the page
+	  so that they become freeable and hence the page does not leak.
 
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-11-10 13:44:52 +00:00
+++ b/fs/ntfs/aops.c	2004-11-10 13:44:52 +00:00
@@ -1117,7 +1117,8 @@
  * For resident attributes, OTOH, ntfs_writepage() writes the @page by copying
  * the data to the mft record (which at this stage is most likely in memory).
  * The mft record is then marked dirty and written out asynchronously via the
- * vfs inode dirty code path.
+ * vfs inode dirty code path for the inode the mft record belongs to or via the
+ * vm page dirty code path for the page the mft record is in.
  *
  * Based on ntfs_readpage() and fs/buffer.c::block_write_full_page().
  *
@@ -1141,6 +1142,11 @@
 	/* Is the page fully outside i_size? (truncate in progress) */
 	if (unlikely(page->index >= (vi->i_size + PAGE_CACHE_SIZE - 1) >>
 			PAGE_CACHE_SHIFT)) {
+		/*
+		 * The page may have dirty, unmapped buffers.  Make them
+		 * freeable here, so the page does not leak.
+		 */
+		block_invalidatepage(page, 0);
 		unlock_page(page);
 		ntfs_debug("Write outside i_size - truncated?");
 		return 0;
