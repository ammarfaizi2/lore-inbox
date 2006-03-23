Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422637AbWCWR31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbWCWR31 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422638AbWCWR30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:29:26 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:40865 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1422637AbWCWR3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:29:25 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 23 Mar 2006 17:29:12 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 12/14] NTFS: Handle the recently introduced -ENAMETOOLONG
 return value
In-Reply-To: <Pine.LNX.4.64.0603231727450.18984@hermes-2.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0603231728310.18984@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0603231713430.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231717460.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231720130.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231721240.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231722330.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231723320.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231724200.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231724570.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231725420.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231726250.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231727040.18984@hermes-2.csi.cam.ac.uk>
 <Pine.LNX.4.64.0603231727450.18984@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Handle the recently introduced -ENAMETOOLONG return value from
      fs/ntfs/unistr.c::ntfs_nlstoucs() in fs/ntfs/namei.c::ntfs_lookup().

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

 fs/ntfs/ChangeLog |    4 ++--
 fs/ntfs/namei.c   |    7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

834ba600cefe6847acaebe5e8e984476dfeebf55
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index d200315..9fb08ef 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -16,8 +16,6 @@ ToDo/Notes:
 	  inode having been discarded already.  Whether this can actually ever
 	  happen is unclear however so it is worth waiting until someone hits
 	  the problem.
-	- Enable the code for setting the NT4 compatibility flag when we start
-	  making NTFS 1.2 specific modifications.
 
 2.1.27 - Various bug fixes and cleanups.
 
@@ -43,6 +41,8 @@ ToDo/Notes:
 	  have an index allocation attribute failed.
 	- Add a missing call to flush_dcache_mft_record_page() in
 	  fs/ntfs/inode.c::ntfs_write_inode().
+	- Handle the recently introduced -ENAMETOOLONG return value from
+	  fs/ntfs/unistr.c::ntfs_nlstoucs() in fs/ntfs/namei.c::ntfs_lookup().
 
 2.1.26 - Minor bug fixes and updates.
 
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 78e0cf7..eddb224 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -115,7 +115,9 @@ static struct dentry *ntfs_lookup(struct
 	uname_len = ntfs_nlstoucs(vol, dent->d_name.name, dent->d_name.len,
 			&uname);
 	if (uname_len < 0) {
-		ntfs_error(vol->sb, "Failed to convert name to Unicode.");
+		if (uname_len != -ENAMETOOLONG)
+			ntfs_error(vol->sb, "Failed to convert name to "
+					"Unicode.");
 		return ERR_PTR(uname_len);
 	}
 	mref = ntfs_lookup_inode_by_name(NTFS_I(dir_ino), uname, uname_len,
@@ -157,7 +159,7 @@ static struct dentry *ntfs_lookup(struct
 		/* Return the error code. */
 		return (struct dentry *)dent_inode;
 	}
-	/* It is guaranteed that name is no longer allocated at this point. */
+	/* It is guaranteed that @name is no longer allocated at this point. */
 	if (MREF_ERR(mref) == -ENOENT) {
 		ntfs_debug("Entry was not found, adding negative dentry.");
 		/* The dcache will handle negative entries. */
@@ -168,7 +170,6 @@ static struct dentry *ntfs_lookup(struct
 	ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error "
 			"code %i.", -MREF_ERR(mref));
 	return ERR_PTR(MREF_ERR(mref));
-
 	// TODO: Consider moving this lot to a separate function! (AIA)
 handle_name:
    {
-- 
1.2.3.g9821

