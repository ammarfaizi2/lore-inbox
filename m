Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268904AbUIXQPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268904AbUIXQPA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268894AbUIXQOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:14:25 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:60582 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268884AbUIXQMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:12:36 -0400
Date: Fri, 24 Sep 2004 17:12:30 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 1/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation, cleanups
 and a bugfix
In-Reply-To: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 1/10 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/22 1.1947)
   NTFS: - Remove BKL use from ntfs_setattr() syncing up with the rest of the
           kernel.
         - Update ->setattr (fs/ntfs/inode.c::ntfs_setattr()) to refuse to
           change the uid, gid, and mode of an inode as we do not support NTFS
           ACLs yet.
   
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
--- a/fs/ntfs/ChangeLog	2004-09-24 17:06:01 +01:00
+++ b/fs/ntfs/ChangeLog	2004-09-24 17:06:01 +01:00
@@ -21,6 +21,14 @@
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
+2.1.19-WIP
+
+	- Update ->setattr (fs/ntfs/inode.c::ntfs_setattr()) to refuse to
+	  change the uid, gid, and mode of an inode as we do not support NTFS
+	  ACLs yet.
+	- Remove BKL use from ntfs_setattr() syncing up with the rest of the
+	  kernel.
+
 2.1.18 - Fix scheduling latencies at mount time as well as an endianness bug.
 
 	- Remove vol->nr_mft_records as it was pretty meaningless and optimize
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	2004-09-24 17:06:01 +01:00
+++ b/fs/ntfs/Makefile	2004-09-24 17:06:01 +01:00
@@ -6,7 +6,7 @@
 	     index.o inode.o mft.o mst.o namei.o super.o sysctl.o unistr.o \
 	     upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.18\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.19-WIP\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-09-24 17:06:01 +01:00
+++ b/fs/ntfs/inode.c	2004-09-24 17:06:01 +01:00
@@ -2270,7 +2270,11 @@
  *
  * We don't support i_size changes yet.
  *
- * Called with ->i_sem held.
+ * Called with ->i_sem held.  In all but one case ->i_alloc_sem is held for
+ * writing.  The only case where ->i_alloc_sem is not held is
+ * mm/filemap.c::generic_file_buffered_write() where vmtruncate() is called
+ * with the current i_size as the offset which means that it is a noop as far
+ * as ntfs_truncate() is concerned.
  */
 void ntfs_truncate(struct inode *vi)
 {
@@ -2289,67 +2293,62 @@
  * @attr:	structure describing the attributes and the changes
  *
  * We have to trap VFS attempts to truncate the file described by @dentry as
- * soon as possible, because we do not implement changes in i_size yet. So we
+ * soon as possible, because we do not implement changes in i_size yet.  So we
  * abort all i_size changes here.
  *
- * Called with ->i_sem held.
+ * We also abort all changes of user, group, and mode as we do not implement
+ * the NTFS ACLs yet.
+ *
+ * Called with ->i_sem held.  For the ATTR_SIZE (i.e. ->truncate) case, also
+ * called with ->i_alloc_sem held for writing.
  *
  * Basically this is a copy of generic notify_change() and inode_setattr()
  * functionality, except we intercept and abort changes in i_size.
  */
 int ntfs_setattr(struct dentry *dentry, struct iattr *attr)
 {
-	struct inode *vi;
+	struct inode *vi = dentry->d_inode;
 	int err;
 	unsigned int ia_valid = attr->ia_valid;
 
-	vi = dentry->d_inode;
-
 	err = inode_change_ok(vi, attr);
 	if (err)
 		return err;
 
-	if ((ia_valid & ATTR_UID && attr->ia_uid != vi->i_uid) ||
-			(ia_valid & ATTR_GID && attr->ia_gid != vi->i_gid)) {
-		err = DQUOT_TRANSFER(vi, attr) ? -EDQUOT : 0;
-		if (err)
-			return err;
+	/* We do not support NTFS ACLs yet. */
+	if (ia_valid & (ATTR_UID | ATTR_GID | ATTR_MODE)) {
+		ntfs_warning(vi->i_sb, "Changes in user/group/mode are not "
+				"supported yet, ignoring.");
+		err = -EOPNOTSUPP;
+		goto out;
 	}
 
-	lock_kernel();
-
 	if (ia_valid & ATTR_SIZE) {
-		ntfs_error(vi->i_sb, "Changes in i_size are not supported "
-				"yet. Sorry.");
-		// TODO: Implement...
-		// err = vmtruncate(vi, attr->ia_size);
-		err = -EOPNOTSUPP;
-		if (err)
-			goto trunc_err;
+		if (attr->ia_size != i_size_read(vi)) {
+			ntfs_warning(vi->i_sb, "Changes in inode size are not "
+					"supported yet, ignoring.");
+			err = -EOPNOTSUPP;
+			// TODO: Implement...
+			// err = vmtruncate(vi, attr->ia_size);
+			if (err || ia_valid == ATTR_SIZE)
+				goto out;
+		} else {
+			/*
+			 * We skipped the truncate but must still update
+			 * timestamps.
+			 */
+			ia_valid |= ATTR_MTIME|ATTR_CTIME;
+		}
 	}
 
-	if (ia_valid & ATTR_UID)
-		vi->i_uid = attr->ia_uid;
-	if (ia_valid & ATTR_GID)
-		vi->i_gid = attr->ia_gid;
 	if (ia_valid & ATTR_ATIME)
 		vi->i_atime = attr->ia_atime;
 	if (ia_valid & ATTR_MTIME)
 		vi->i_mtime = attr->ia_mtime;
 	if (ia_valid & ATTR_CTIME)
 		vi->i_ctime = attr->ia_ctime;
-	if (ia_valid & ATTR_MODE) {
-		vi->i_mode = attr->ia_mode;
-		if (!in_group_p(vi->i_gid) &&
-				!capable(CAP_FSETID))
-			vi->i_mode &= ~S_ISGID;
-	}
 	mark_inode_dirty(vi);
-
-trunc_err:
-
-	unlock_kernel();
-
+out:
 	return err;
 }
 
