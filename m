Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268889AbUIXQNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268889AbUIXQNq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268894AbUIXQNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:13:46 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:32144 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268889AbUIXQMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:12:54 -0400
Date: Fri, 24 Sep 2004 17:12:47 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 2/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation, cleanups
 and a bugfix
In-Reply-To: <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 2/10 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/22 1.1948)
   NTFS: Get rid of the ugly transparent union in fs/ntfs/dir.c::ntfs_readdir()
         and ntfs_filldir() as per suggestion from Al Viro.
   
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
--- a/fs/ntfs/ChangeLog	2004-09-24 17:06:05 +01:00
+++ b/fs/ntfs/ChangeLog	2004-09-24 17:06:05 +01:00
@@ -28,6 +28,8 @@
 	  ACLs yet.
 	- Remove BKL use from ntfs_setattr() syncing up with the rest of the
 	  kernel.
+	- Get rid of the ugly transparent union in fs/ntfs/dir.c::ntfs_readdir()
+	  and ntfs_filldir() as per suggestion from Al Viro.
 
 2.1.18 - Fix scheduling latencies at mount time as well as an endianness bug.
 
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	2004-09-24 17:06:05 +01:00
+++ b/fs/ntfs/dir.c	2004-09-24 17:06:05 +01:00
@@ -999,23 +999,11 @@
 
 #endif
 
-typedef union {
-	INDEX_ROOT *ir;
-	INDEX_ALLOCATION *ia;
-} index_union __attribute__ ((__transparent_union__));
-
-typedef enum {
-	INDEX_TYPE_ROOT,	/* index root */
-	INDEX_TYPE_ALLOCATION,	/* index allocation */
-} INDEX_TYPE;
-
 /**
  * ntfs_filldir - ntfs specific filldir method
  * @vol:	current ntfs volume
  * @fpos:	position in the directory
  * @ndir:	ntfs inode of current directory
- * @index_type:	specifies whether @iu is an index root or an index allocation
- * @iu:		index root or index allocation attribute to which @ie belongs
  * @ia_page:	page in which the index allocation buffer @ie is in resides
  * @ie:		current index entry
  * @name:	buffer to use for the converted name
@@ -1036,8 +1024,7 @@
  * would need to drop the lock immediately anyway.
  */
 static inline int ntfs_filldir(ntfs_volume *vol, loff_t *fpos,
-		ntfs_inode *ndir, const INDEX_TYPE index_type,
-		index_union iu, struct page *ia_page, INDEX_ENTRY *ie,
+		ntfs_inode *ndir, struct page *ia_page, INDEX_ENTRY *ie,
 		u8 *name, void *dirent, filldir_t filldir)
 {
 	unsigned long mref;
@@ -1045,14 +1032,6 @@
 	unsigned dt_type;
 	FILE_NAME_TYPE_FLAGS name_type;
 
-	/* Advance the position even if going to skip the entry. */
-	if (index_type == INDEX_TYPE_ALLOCATION)
-		*fpos = (u8*)ie - (u8*)iu.ia +
-				(sle64_to_cpu(iu.ia->index_block_vcn) <<
-				ndir->itype.index.vcn_size_bits) +
-				vol->mft_record_size;
-	else /* if (index_type == INDEX_TYPE_ROOT) */
-		*fpos = (u8*)ie - (u8*)iu.ir;
 	name_type = ie->key.file_name.file_name_type;
 	if (name_type == FILE_NAME_DOS) {
 		ntfs_debug("Skipping DOS name space entry.");
@@ -1084,14 +1063,14 @@
 	 * Drop the page lock otherwise we deadlock with NFS when it calls
 	 * ->lookup since ntfs_lookup() will lock the same page.
 	 */
-	if (index_type == INDEX_TYPE_ALLOCATION)
+	if (ia_page)
 		unlock_page(ia_page);
 	ntfs_debug("Calling filldir for %s with len %i, fpos 0x%llx, inode "
 			"0x%lx, DT_%s.", name, name_len, *fpos, mref,
 			dt_type == DT_DIR ? "DIR" : "REG");
 	rc = filldir(dirent, name, name_len, *fpos, mref, dt_type);
 	/* Relock the page but not if we are aborting ->readdir. */
-	if (!rc && index_type == INDEX_TYPE_ALLOCATION)
+	if (!rc && ia_page)
 		lock_page(ia_page);
 	return rc;
 }
@@ -1244,9 +1223,11 @@
 		/* Skip index root entry if continuing previous readdir. */
 		if (ir_pos > (u8*)ie - (u8*)ir)
 			continue;
+		/* Advance the position even if going to skip the entry. */
+		fpos = (u8*)ie - (u8*)ir;
 		/* Submit the name to the filldir callback. */
-		rc = ntfs_filldir(vol, &fpos, ndir, INDEX_TYPE_ROOT, ir, NULL,
-				ie, name, dirent, filldir);
+		rc = ntfs_filldir(vol, &fpos, ndir, NULL, ie, name, dirent,
+				filldir);
 		if (rc) {
 			kfree(ir);
 			goto abort;
@@ -1420,14 +1401,19 @@
 		/* Skip index block entry if continuing previous readdir. */
 		if (ia_pos - ia_start > (u8*)ie - (u8*)ia)
 			continue;
+		/* Advance the position even if going to skip the entry. */
+		fpos = (u8*)ie - (u8*)ia +
+				(sle64_to_cpu(ia->index_block_vcn) <<
+				ndir->itype.index.vcn_size_bits) +
+				vol->mft_record_size;
 		/*
 		 * Submit the name to the @filldir callback.  Note,
 		 * ntfs_filldir() drops the lock on @ia_page but it retakes it
 		 * before returning, unless a non-zero value is returned in
 		 * which case the page is left unlocked.
 		 */
-		rc = ntfs_filldir(vol, &fpos, ndir, INDEX_TYPE_ALLOCATION, ia,
-				ia_page, ie, name, dirent, filldir);
+		rc = ntfs_filldir(vol, &fpos, ndir, ia_page, ie, name, dirent,
+				filldir);
 		if (rc) {
 			/* @ia_page is already unlocked in this case. */
 			ntfs_unmap_page(ia_page);
