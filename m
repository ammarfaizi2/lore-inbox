Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUFHLwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUFHLwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 07:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUFHLuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 07:50:17 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:51391 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265063AbUFHLpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 07:45:45 -0400
Date: Tue, 8 Jun 2004 12:45:44 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
       Pawel Kot <pkot@bezsensu.pl>
Subject: Re: [2.6.7-BK] NTFS 2.1.13 patch 5/8
In-Reply-To: <Pine.SOL.4.58.0406081245130.21854@orange.csi.cam.ac.uk>
Message-ID: <Pine.SOL.4.58.0406081245290.21854@orange.csi.cam.ac.uk>
References: <Pine.SOL.4.58.0406081236450.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081243060.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081244330.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081244580.21854@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0406081245130.21854@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 5 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/06/04 1.1743)
   NTFS: Use set_page_writeback()/end_page_writeback() in ntfs_writepage()
         resident attribute write code path as otherwise the radix-tree tag
         PAGECACHE_TAG_DIRTY remains set even though the page is clean.

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
--- a/fs/ntfs/ChangeLog	2004-06-08 12:22:16 +01:00
+++ b/fs/ntfs/ChangeLog	2004-06-08 12:22:16 +01:00
@@ -56,6 +56,10 @@
 	  written out by then and hence no dirty (meta)data will be lost.  We
 	  also check for this case and emit an error message telling the user
 	  to run chkdsk.
+	- Use set_page_writeback() and end_page_writeback() in the resident
+	  attribute code path of fs/ntfs/aops.c::ntfs_writepage() otherwise
+	  the radix-tree tag PAGECACHE_TAG_DIRTY remains set even though the
+	  page is clean.

 2.1.12 - Fix the second fix to the decompression engine and some cleanups.

diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-06-08 12:22:16 +01:00
+++ b/fs/ntfs/aops.c	2004-06-08 12:22:16 +01:00
@@ -478,7 +478,7 @@
 	ni = NTFS_I(vi);
 	vol = ni->vol;

-	ntfs_debug("Entering for inode %li, attribute type 0x%x, page index "
+	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, page index "
 			"0x%lx.", vi->i_ino, ni->type, page->index);

 	BUG_ON(!NInoNonResident(ni));
@@ -923,13 +923,13 @@
 	if (unlikely(bytes > PAGE_CACHE_SIZE))
 		bytes = PAGE_CACHE_SIZE;

-	// TODO: Consider using PageWriteback() + unlock_page() in 2.6 once the
-	// "VM fiddling has ended". Note, don't forget to replace all the
-	// unlock_page() calls further below with end_page_writeback() ones.
-#if 0
+	/*
+	 * Keep the VM happy.  This must be done otherwise the radix-tree tag
+	 * PAGECACHE_TAG_DIRTY remains set even though the page is clean.
+	 */
+	BUG_ON(PageWriteback(page));
 	set_page_writeback(page);
 	unlock_page(page);
-#endif

 	/*
 	 * Here, we don't need to zero the out of bounds area everytime because
@@ -945,7 +945,10 @@
 	 * expose data to userspace/disk which should never have been exposed.
 	 *
 	 * FIXME: Ensure that i_size increases do the zeroing/overwriting and
-	 * if we cannot guarantee that, then enable the zeroing below.
+	 * if we cannot guarantee that, then enable the zeroing below.  If the
+	 * zeroing below is enabled, we MUST move the unlock_page() from above
+	 * to after the kunmap_atomic(), i.e. just before the
+	 * end_page_writeback().
 	 */

 	kaddr = kmap_atomic(page, KM_USER0);
@@ -963,7 +966,7 @@
 #endif
 	kunmap_atomic(kaddr, KM_USER0);

-	unlock_page(page);
+	end_page_writeback(page);

 	/* Mark the mft record dirty, so it gets written back. */
 	mark_mft_record_dirty(ctx->ntfs_ino);
@@ -1018,7 +1021,7 @@
 	ni = NTFS_I(vi);
 	vol = ni->vol;

-	ntfs_debug("Entering for inode %li, attribute type 0x%x, page index "
+	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, page index "
 			"0x%lx, from = %u, to = %u.", vi->i_ino, ni->type,
 			page->index, from, to);

@@ -1375,7 +1378,7 @@
 	struct inode *vi = page->mapping->host;
 	ntfs_inode   *ni = NTFS_I(vi);

-	ntfs_debug("Entering for inode %li, attribute type 0x%x, page index "
+	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, page index "
 			"0x%lx, from = %u, to = %u.", vi->i_ino, ni->type,
 			page->index, from, to);

@@ -1483,7 +1486,7 @@

 	vi = page->mapping->host;

-	ntfs_debug("Entering for inode %li, attribute type 0x%x, page index "
+	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, page index "
 			"0x%lx, from = %u, to = %u.", vi->i_ino,
 			NTFS_I(vi)->type, page->index, from, to);

@@ -1579,7 +1582,7 @@
 	vi = page->mapping->host;
 	ni = NTFS_I(vi);

-	ntfs_debug("Entering for inode %li, attribute type 0x%x, page index "
+	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, page index "
 			"0x%lx, from = %u, to = %u.", vi->i_ino, ni->type,
 			page->index, from, to);

