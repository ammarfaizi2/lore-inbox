Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317589AbSHTXog>; Tue, 20 Aug 2002 19:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317592AbSHTXof>; Tue, 20 Aug 2002 19:44:35 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:34187 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317589AbSHTXoY>; Tue, 20 Aug 2002 19:44:24 -0400
Subject: [BK-2.5 PATCH] NTFS 2.1.0 6/7: Intercept and abort i_size changes
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 21 Aug 2002 00:48:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17hIje-0001Kc-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-2.5

Thanks! The 6th changeset. Adding interception and abort of i_size changes,
since we don't implement resize at this point such changes were confusing
the driver badly.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |    1 
 fs/ntfs/ChangeLog                  |   12 ++++
 fs/ntfs/aops.c                     |    6 +-
 fs/ntfs/file.c                     |    5 +-
 fs/ntfs/inode.c                    |   91 +++++++++++++++++++++++++++++++++++++
 fs/ntfs/inode.h                    |    8 ++-
 6 files changed, 118 insertions(+), 5 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/08/20 1.486.1.3)
   NTFS: 2.1.0 - First steps towards write support: implement file overwrite.
   - Add configuration option for developmental write support with an
     appropriately scary configuration help text.
   - Initial implementation of fs/ntfs/aops.c::ntfs_writepage() and its
     helper fs/ntfs/aops.c::ntfs_write_block(). This enables mmap(2) based
     overwriting of existing files on ntfs. Note: Resident files are
     only written into memory, and not written out to disk at present, so
     avoid writing to files smaller than about 1kiB.
   - Initial implementation of fs/ntfs/aops.c::ntfs_prepare_write(), its
     helper fs/ntfs/aops.c::ntfs_prepare_nonresident_write() and their
     counterparts, fs/ntfs/aops.c::ntfs_commit_write(), and
     fs/ntfs/aops.c::ntfs_commit_nonresident_write(), respectively. Also,
     add generic_file_write() to the ntfs file operations (fs/ntfs/file.c).
     This enables write(2) based overwriting of existing files on ntfs.
     Note: As with mmap(2) based overwriting, resident files are only
     written into memory, and not written out to disk at present, so avoid
     writing to files smaller than about 1kiB.
   - Implement ->truncate (fs/ntfs/inode.c::ntfs_truncate()) and
     ->setattr() (fs/ntfs/inode.c::ntfs_setattr()) inode operations for
     files with the purpose of intercepting and aborting all i_size
     changes which we do not support yet. ntfs_truncate() actually only
     emits a warning message but AFAICS our interception of i_size changes
     elsewhere means ntfs_truncate() never gets called for i_size changes.
     It is only called from generic_file_write() when we fail in
     ntfs_prepare_{,nonresident_}write() in order to discard any
     instantiated buffers beyond i_size. Thus i_size is not actually
     changed so our warning message is enough. Unfortunately it is not
     possible to easily determine if i_size is being changed or not hence
     we just emit an appropriately worded error message.


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Tue Aug 20 23:58:14 2002
+++ b/Documentation/filesystems/ntfs.txt	Tue Aug 20 23:58:14 2002
@@ -252,6 +252,7 @@
 	- Initial implementation of file overwriting. (Writes to resident files
 	  are not written out to disk yet, so avoid writing to files smaller
 	  than about 1kiB.)
+	- Intercept/abort changes in file size as they are not implemented yet.
 2.0.25:
 	- Minor bugfixes in error code paths and small cleanups.
 2.0.24:
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Tue Aug 20 23:58:14 2002
+++ b/fs/ntfs/ChangeLog	Tue Aug 20 23:58:14 2002
@@ -38,6 +38,18 @@
 	  Note: As with mmap(2) based overwriting, resident files are only
 	  written into memory, and not written out to disk at present, so avoid
 	  writing to files smaller than about 1kiB.
+	- Implement ->truncate (fs/ntfs/inode.c::ntfs_truncate()) and
+	  ->setattr() (fs/ntfs/inode.c::ntfs_setattr()) inode operations for
+	  files with the purpose of intercepting and aborting all i_size
+	  changes which we do not support yet. ntfs_truncate() actually only
+	  emits a warning message but AFAICS our interception of i_size changes
+	  elsewhere means ntfs_truncate() never gets called for i_size changes.
+	  It is only called from generic_file_write() when we fail in
+	  ntfs_prepare_{,nonresident_}write() in order to discard any
+	  instantiated buffers beyond i_size. Thus i_size is not actually
+	  changed so our warning message is enough. Unfortunately it is not
+	  possible to easily determine if i_size is being changed or not hence
+	  we just emit an appropriately worded error message.
 
 2.0.25 - Small bug fixes and cleanups.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	Tue Aug 20 23:58:14 2002
+++ b/fs/ntfs/aops.c	Tue Aug 20 23:58:14 2002
@@ -1523,8 +1523,10 @@
 	 * exceeds i_size case, so this will never trigger which is fine.
 	 */
 	if (pos > vi->i_size) {
-		vi->i_size = pos;
-		mark_inode_dirty(vi);
+		ntfs_error(vi->i_sb, "Writing beyond the existing file size is "
+				"not supported yet. Sorry.");
+		// vi->i_size = pos;
+		// mark_inode_dirty(vi);
 	}
 	ntfs_debug("Done.");
 	return 0;
diff -Nru a/fs/ntfs/file.c b/fs/ntfs/file.c
--- a/fs/ntfs/file.c	Tue Aug 20 23:58:14 2002
+++ b/fs/ntfs/file.c	Tue Aug 20 23:58:14 2002
@@ -63,7 +63,10 @@
 	.open		= ntfs_file_open,	/* Open file. */
 };
 
-struct inode_operations ntfs_file_inode_ops = {};
+struct inode_operations ntfs_file_inode_ops = {
+	.truncate	= ntfs_truncate,
+	.setattr	= ntfs_setattr,
+};
 
 struct file_operations ntfs_empty_file_ops = {};
 
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	Tue Aug 20 23:58:14 2002
+++ b/fs/ntfs/inode.c	Tue Aug 20 23:58:14 2002
@@ -21,6 +21,8 @@
 
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
+#include <linux/smp_lock.h>
+#include <linux/quotaops.h>
 
 #include "ntfs.h"
 #include "dir.h"
@@ -1924,5 +1926,94 @@
 	}
 	seq_printf(sf, ",mft_zone_multiplier=%i", vol->mft_zone_multiplier);
 	return 0;
+}
+
+/**
+ * ntfs_truncate - called when the i_size of an ntfs inode is changed
+ * @vi:		inode for which the i_size was changed
+ *
+ * We don't support i_size changes yet.
+ *
+ * Called with ->i_sem held.
+ */
+void ntfs_truncate(struct inode *vi)
+{
+	// TODO: Implement...
+	ntfs_warning(vi->i_sb, "Eeek: i_size may have changed! If you see "
+			"this right after a message from "
+			"ntfs_{prepare,commit}_{,nonresident_}write() then "
+			"just ignore it. Otherwise it is bad news.");
+	// TODO: reset i_size now!
+	return;
+}
+
+/**
+ * ntfs_setattr - called from notify_change() when an attribute is being changed
+ * @dentry:	dentry whose attributes to change
+ * @attr:	structure describing the attributes and the changes
+ *
+ * We have to trap VFS attempts to truncate the file described by @dentry as
+ * soon as possible, because we do not implement changes in i_size yet. So we
+ * abort all i_size changes here.
+ *
+ * Called with ->i_sem held.
+ *
+ * Basically this is a copy of generic notify_change() and inode_setattr()
+ * functionality, except we intercept and abort changes in i_size.
+ */
+int ntfs_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	struct inode *vi;
+	int err;
+	unsigned int ia_valid = attr->ia_valid;
+
+	vi = dentry->d_inode;
+
+	err = inode_change_ok(vi, attr);
+	if (err)
+		return err;
+
+	if ((ia_valid & ATTR_UID && attr->ia_uid != vi->i_uid) ||
+			(ia_valid & ATTR_GID && attr->ia_gid != vi->i_gid)) {
+		err = DQUOT_TRANSFER(vi, attr) ? -EDQUOT : 0;
+		if (err)
+			return err;
+	}
+
+	lock_kernel();
+
+	if (ia_valid & ATTR_SIZE) {
+		ntfs_error(vi->i_sb, "Changes in i_size are not supported "
+				"yet. Sorry.");
+		// TODO: Implement...
+		// err = vmtruncate(vi, attr->ia_size);
+		err = -EOPNOTSUPP;
+		if (err)
+			goto trunc_err;
+	}
+
+	if (ia_valid & ATTR_UID)
+		vi->i_uid = attr->ia_uid;
+	if (ia_valid & ATTR_GID)
+		vi->i_gid = attr->ia_gid;
+	if (ia_valid & ATTR_ATIME)
+		vi->i_atime = attr->ia_atime;
+	if (ia_valid & ATTR_MTIME)
+		vi->i_mtime = attr->ia_mtime;
+	if (ia_valid & ATTR_CTIME)
+		vi->i_ctime = attr->ia_ctime;
+	if (ia_valid & ATTR_MODE) {
+		vi->i_mode = attr->ia_mode;
+		if (!in_group_p(vi->i_gid) &&
+				!capable(CAP_FSETID))
+			vi->i_mode &= ~S_ISGID;
+	}
+	mark_inode_dirty(vi);
+
+trunc_err:
+
+	unlock_kernel();
+
+	return err;
 }
 
diff -Nru a/fs/ntfs/inode.h b/fs/ntfs/inode.h
--- a/fs/ntfs/inode.h	Tue Aug 20 23:58:14 2002
+++ b/fs/ntfs/inode.h	Tue Aug 20 23:58:14 2002
@@ -36,8 +36,8 @@
  * fields already provided in the VFS inode.
  */
 struct _ntfs_inode {
-	s64 initialized_size;	/* Copy from $DATA/$INDEX_ALLOCATION. */
-	s64 allocated_size;	/* Copy from $DATA/$INDEX_ALLOCATION. */
+	s64 initialized_size;	/* Copy from the attribute record. */
+	s64 allocated_size;	/* Copy from the attribute record. */
 	unsigned long state;	/* NTFS specific flags describing this inode.
 				   See ntfs_inode_state_bits below. */
 	unsigned long mft_no;	/* Number of the mft record / inode. */
@@ -244,6 +244,10 @@
 extern void ntfs_put_inode(struct inode *vi);
 
 extern int ntfs_show_options(struct seq_file *sf, struct vfsmount *mnt);
+
+extern void ntfs_truncate(struct inode *vi);
+
+extern int ntfs_setattr(struct dentry *dentry, struct iattr *attr);
 
 #endif /* _LINUX_NTFS_FS_INODE_H */
 

