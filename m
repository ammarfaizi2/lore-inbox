Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbUKJOuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbUKJOuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbUKJOry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:47:54 -0500
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:40673 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261918AbUKJNpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:45:39 -0500
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 21/26] NTFS 2.1.22 - Bug and race fixes and improved error handling.
Message-Id: <E1CRsmy-0006SA-Lb@imp.csi.cam.ac.uk>
Date: Wed, 10 Nov 2004 13:45:32 +0000
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 21/26 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/11/05 1.2026.1.56)
   NTFS: Fix bug in handling of bad inodes in fs/ntfs/namei.c::ntfs_lookup().
   
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
--- a/fs/ntfs/ChangeLog	2004-11-10 13:45:36 +00:00
+++ b/fs/ntfs/ChangeLog	2004-11-10 13:45:36 +00:00
@@ -83,6 +83,7 @@
 	  the bug report.)
 	- Fix error handling in fs/ntfs/quota.c::ntfs_mark_quotas_out_of_date()
 	  where we failed to release i_sem on the $Quota/$Q attribute inode.
+	- Fix bug in handling of bad inodes in fs/ntfs/namei.c::ntfs_lookup().
 
 2.1.21 - Fix some races and bugs, rewrite mft write code, add mft allocator.
 
diff -Nru a/fs/ntfs/namei.c b/fs/ntfs/namei.c
--- a/fs/ntfs/namei.c	2004-11-10 13:45:36 +00:00
+++ b/fs/ntfs/namei.c	2004-11-10 13:45:36 +00:00
@@ -127,15 +127,16 @@
 		dent_inode = ntfs_iget(vol->sb, dent_ino);
 		if (likely(!IS_ERR(dent_inode))) {
 			/* Consistency check. */
-			if (MSEQNO(mref) == NTFS_I(dent_inode)->seq_no ||
+			if (is_bad_inode(dent_inode) || MSEQNO(mref) ==
+					NTFS_I(dent_inode)->seq_no ||
 					dent_ino == FILE_MFT) {
 				/* Perfect WIN32/POSIX match. -- Case 1. */
 				if (!name) {
-					ntfs_debug("Done.");
+					ntfs_debug("Done.  (Case 1.)");
 					return d_splice_alias(dent_inode, dent);
 				}
 				/*
-				 * We are too indented. Handle imperfect
+				 * We are too indented.  Handle imperfect
 				 * matches and short file names further below.
 				 */
 				goto handle_name;
@@ -181,6 +182,7 @@
 
 	nls_name.name = NULL;
 	if (name->type != FILE_NAME_DOS) {			/* Case 2. */
+		ntfs_debug("Case 2.");
 		nls_name.len = (unsigned)ntfs_ucstonls(vol,
 				(ntfschar*)&name->name, name->len,
 				(unsigned char**)&nls_name.name, 0);
@@ -188,6 +190,7 @@
 	} else /* if (name->type == FILE_NAME_DOS) */ {		/* Case 3. */
 		FILE_NAME_ATTR *fn;
 
+		ntfs_debug("Case 3.");
 		kfree(name);
 
 		/* Find the WIN32 name corresponding to the matched DOS name. */
@@ -271,12 +274,17 @@
 			dput(real_dent);
 		else
 			new_dent = real_dent;
+		ntfs_debug("Done.  (Created new dentry.)");
 		return new_dent;
 	}
 	kfree(nls_name.name);
 	/* Matching dentry exists, check if it is negative. */
 	if (real_dent->d_inode) {
-		BUG_ON(real_dent->d_inode != dent_inode);
+		if (unlikely(real_dent->d_inode != dent_inode)) {
+			/* This can happen because bad inodes are unhashed. */
+			BUG_ON(!is_bad_inode(dent_inode));
+			BUG_ON(!is_bad_inode(real_dent->d_inode));
+		}
 		/*
 		 * Already have the inode and the dentry attached, decrement
 		 * the reference count to balance the ntfs_iget() we did
@@ -285,6 +293,7 @@
 		 * about any NFS/disconnectedness issues here.
 		 */
 		iput(dent_inode);
+		ntfs_debug("Done.  (Already had inode and dentry.)");
 		return real_dent;
 	}
 	/*
@@ -295,6 +304,7 @@
 	if (!S_ISDIR(dent_inode->i_mode)) {
 		/* Not a directory; everything is easy. */
 		d_instantiate(real_dent, dent_inode);
+		ntfs_debug("Done.  (Already had negative file dentry.)");
 		return real_dent;
 	}
 	spin_lock(&dcache_lock);
@@ -308,6 +318,7 @@
 		real_dent->d_inode = dent_inode;
 		spin_unlock(&dcache_lock);
 		security_d_instantiate(real_dent, dent_inode);
+		ntfs_debug("Done.  (Already had negative directory dentry.)");
 		return real_dent;
 	}
 	/*
@@ -327,6 +338,8 @@
 	/* Throw away real_dent. */
 	dput(real_dent);
 	/* Use new_dent as the actual dentry. */
+	ntfs_debug("Done.  (Already had negative, disconnected directory "
+			"dentry.)");
 	return new_dent;
 
 eio_err_out:
@@ -338,6 +351,7 @@
 	if (m)
 		unmap_mft_record(ni);
 	iput(dent_inode);
+	ntfs_error(vol->sb, "Failed, returning error code %i.", err);
 	return ERR_PTR(err);
    }
 }
