Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265813AbUEZVVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265813AbUEZVVX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 17:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265815AbUEZVVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 17:21:22 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:35735 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265813AbUEZVVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 17:21:06 -0400
Date: Wed, 26 May 2004 22:21:05 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [2.6.7-rc1-bk] NTFS: 2.1.12 release - patch 3/3
In-Reply-To: <Pine.SOL.4.58.0405262217590.15648@orange.csi.cam.ac.uk>
Message-ID: <Pine.SOL.4.58.0405262220000.15648@orange.csi.cam.ac.uk>
References: <Pine.SOL.4.58.0405262214280.15648@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0405262216460.15648@orange.csi.cam.ac.uk>
 <Pine.SOL.4.58.0405262217590.15648@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 3 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/05/26 1.1733)
   NTFS: 2.1.12 release - Fix the second fix to the decompression engine.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	2004-05-26 22:10:16 +01:00
+++ b/Documentation/filesystems/ntfs.txt	2004-05-26 22:10:16 +01:00
@@ -273,6 +273,9 @@

 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.

+2.1.12:
+	- Fix the second fix to the decompression engine from the 2.1.9 release
+	  and some further internals cleanups.
 2.1.11:
 	- Driver internal cleanups.
 2.1.10:
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-05-26 22:10:16 +01:00
+++ b/fs/ntfs/ChangeLog	2004-05-26 22:10:16 +01:00
@@ -25,7 +25,7 @@
 	  sufficient for synchronisation here. We then just need to make sure
 	  ntfs_readpage/writepage/truncate interoperate properly with us.

-2.1.12 - WIP.
+2.1.12 - Fix the second fix to the decompression engine and some cleanups.

 	- Add a new address space operations struct, ntfs_mst_aops, for mst
 	  protected attributes.  This is because the default ntfs_aops do not
@@ -36,6 +36,10 @@
 	  includes an adapted ntfs_commit_inode() and an implementation of
 	  ntfs_write_inode() which for now just cleans dirty inodes without
 	  writing them (it does emit a warning that this is happening).
+	- Undo the second decompression engine fix (see 2.1.9 release ChangeLog
+	  entry) as it was only fixing a theoretical bug but at the same time
+	  it badly broke the handling of sparse and uncompressed compression
+	  blocks.

 2.1.11 - Driver internal cleanups.

diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	2004-05-26 22:10:16 +01:00
+++ b/fs/ntfs/Makefile	2004-05-26 22:10:16 +01:00
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o unistr.o upcase.o

-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.12-WIP\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.12\"

 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c	2004-05-26 22:10:16 +01:00
+++ b/fs/ntfs/compress.c	2004-05-26 22:10:16 +01:00
@@ -507,7 +507,7 @@
 	 */
 	unsigned int nr_pages = (end_vcn - start_vcn) <<
 			vol->cluster_size_bits >> PAGE_CACHE_SHIFT;
-	unsigned int xpage, max_page, max_ofs, cur_page, cur_ofs, i;
+	unsigned int xpage, max_page, cur_page, cur_ofs, i;
 	unsigned int cb_clusters, cb_max_ofs;
 	int block, max_block, cb_max_page, bhs_size, nr_bhs, err = 0;
 	struct page **pages;
@@ -550,11 +550,8 @@
 	 */
 	max_page = ((VFS_I(ni)->i_size + PAGE_CACHE_SIZE - 1) >>
 			PAGE_CACHE_SHIFT) - offset;
-	max_ofs = (VFS_I(ni)->i_size + PAGE_CACHE_SIZE - 1) & ~PAGE_CACHE_MASK;
-	if (nr_pages < max_page) {
+	if (nr_pages < max_page)
 		max_page = nr_pages;
-		max_ofs = 0;
-	}
 	for (i = 0; i < max_page; i++, offset++) {
 		if (i != xpage)
 			pages[i] = grab_cache_page_nowait(mapping, offset);
@@ -722,14 +719,8 @@
 	cb_max_page >>= PAGE_CACHE_SHIFT;

 	/* Catch end of file inside a compression block. */
-	if (cb_max_page >= max_page) {
-		if (cb_max_page > max_page) {
-			cb_max_page = max_page;
-			cb_max_ofs = max_ofs;
-		} else if (cb_max_ofs > max_ofs) {
-			cb_max_ofs = max_ofs;
-		}
-	}
+	if (cb_max_page > max_page)
+		cb_max_page = max_page;

 	if (vcn == start_vcn - cb_clusters) {
 		/* Sparse cb, zero out page range overlapping the cb. */
@@ -897,7 +888,8 @@
 		if (page) {
 			ntfs_error(vol->sb, "Still have pages left! "
 					"Terminating them with extreme "
-					"prejudice.");
+					"prejudice.  Inode 0x%lx, page index "
+					"0x%lx.", ni->mft_no, page->index);
 			if (cur_page == xpage && !xpage_done)
 				SetPageError(page);
 			flush_dcache_page(page);
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-05-26 22:10:16 +01:00
+++ b/fs/ntfs/super.c	2004-05-26 22:10:16 +01:00
@@ -1142,7 +1142,7 @@
 #ifdef NTFS_RW
 	/* Make sure that no unsupported volume flags are set. */
 	if (vol->vol_flags & VOLUME_MUST_MOUNT_RO_MASK) {
-		static const char *es1 = "Volume has unsupported flags set ";
+		static const char *es1 = "Volume has unsupported flags set";
 		static const char *es2 = ".  Run chkdsk and mount in Windows.";

 		/* If a read-write mount, convert it to a read-only mount. */
