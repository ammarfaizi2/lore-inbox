Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267650AbUHWKeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267650AbUHWKeR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 06:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267735AbUHWKeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 06:34:17 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:46006 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267650AbUHWK37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:29:59 -0400
Date: Mon, 23 Aug 2004 11:29:51 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/20] Re: [2.6-BK-URL] NTFS 2.1.17 release
In-Reply-To: <Pine.LNX.4.60.0408231129180.24220@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0408231129370.24220@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0408231055290.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128020.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231128550.24220@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0408231129180.24220@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 4/20 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/07/14 1.1784.3.21)
   NTFS: 2.1.16 - Implement access time updates in fs/ntfs/inode.c::ntfs_write_inode.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	2004-08-18 20:49:56 +01:00
+++ b/Documentation/filesystems/ntfs.txt	2004-08-18 20:49:56 +01:00
@@ -273,6 +273,12 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.1.16:
+	- Implement access time updates (including mtime and ctime).
+	- Implement fsync(2), fdatasync(2), and msync(2) system calls.
+	- Enable the readv(2) and writev(2) system calls.
+	- Enable access via the asynchronous io (aio) API by adding support for
+	  the aio_read(3) and aio_write(3) functions.
 2.1.15:
 	- Invalidate quotas when (re)mounting read-write.
 	  NOTE:  This now only leave user space journalling on the side.  (See
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-08-18 20:49:56 +01:00
+++ b/fs/ntfs/ChangeLog	2004-08-18 20:49:56 +01:00
@@ -26,13 +26,19 @@
 	- Enable the code for setting the NT4 compatibility flag when we start
 	  making NTFS 1.2 specific modifications.
 
-2.1.16 - WIP.
+2.1.16 - Implement access time updates, file sync, async io, and read/writev.
 
 	- Add support for readv/writev and aio_read/aio_write (fs/ntfs/file.c).
 	  This is done by setting the appropriate file operations pointers to
 	  the generic helper functions provided by mm/filemap.c.
 	- Implement fsync, fdatasync, and msync both for files (fs/ntfs/file.c)
 	  and directories (fs/ntfs/dir.c).
+	- Add support for {a,m,c}time updates to inode.c::ntfs_write_inode().
+	  Note, except for the root directory and any other system files opened
+	  by the user, the system files will not have their access times
+	  updated as they are only accessed at the inode level an hence the
+	  file level functions which cause the times to be updated are never
+	  invoked.
 
 2.1.15 - Invalidate quotas when (re)mounting read-write.
 
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	2004-08-18 20:49:56 +01:00
+++ b/fs/ntfs/Makefile	2004-08-18 20:49:56 +01:00
@@ -6,7 +6,7 @@
 	     index.o inode.o mft.o mst.o namei.o super.o sysctl.o unistr.o \
 	     upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.16-WIP\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.16\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-08-18 20:49:56 +01:00
+++ b/fs/ntfs/inode.c	2004-08-18 20:49:56 +01:00
@@ -622,7 +622,7 @@
 	si = (STANDARD_INFORMATION*)((char*)ctx->attr +
 			le16_to_cpu(ctx->attr->data.resident.value_offset));
 
-	/* Transfer information from the standard information into vfs_ino. */
+	/* Transfer information from the standard information into vi. */
 	/*
 	 * Note: The i_?times do not quite map perfectly onto the NTFS times,
 	 * but they are close enough, and in the end it doesn't really matter
@@ -2319,21 +2319,24 @@
  */
 int ntfs_write_inode(struct inode *vi, int sync)
 {
+	s64 nt;
 	ntfs_inode *ni = NTFS_I(vi);
-#if 0
 	attr_search_context *ctx;
-#endif
 	MFT_RECORD *m;
+	STANDARD_INFORMATION *si;
 	int err = 0;
+	BOOL modified = FALSE;
 
 	ntfs_debug("Entering for %sinode 0x%lx.", NInoAttr(ni) ? "attr " : "",
 			vi->i_ino);
 	/*
 	 * Dirty attribute inodes are written via their real inodes so just
-	 * clean them here.  TODO:  Take care of access time updates.
+	 * clean them here.  Access time updates are taken care off when the
+	 * real inode is written.
 	 */
 	if (NInoAttr(ni)) {
 		NInoClearDirty(ni);
+		ntfs_debug("Done.");
 		return 0;
 	}
 	/* Map, pin, and lock the mft record belonging to the inode. */
@@ -2342,8 +2345,7 @@
 		err = PTR_ERR(m);
 		goto err_out;
 	}
-#if 0
-	/* Obtain the standard information attribute. */
+	/* Update the access times in the standard information attribute. */
 	ctx = get_attr_search_ctx(ni, m);
 	if (unlikely(!ctx)) {
 		err = -ENOMEM;
@@ -2355,28 +2357,50 @@
 		err = -ENOENT;
 		goto unm_err_out;
 	}
-	// TODO:  Update the access times in the standard information attribute
-	// which is now in ctx->attr.
-	// - Probably want to have use sops->dirty_inode() to set a flag that
-	//   we need to update the times here rather than having to blindly do
-	//   it every time.  Or even don't do it here at all and do it in
-	//   sops->dirty_inode() instead.  Problem with this would be that
-	//   sops->dirty_inode() must be atomic under certain circumstances
-	//   and mapping mft records and such like is not atomic.
-	// - For atime updates also need to check whether they are enabled in
-	//   the superblock flags.
-	ntfs_warning(vi->i_sb, "Access time updates not implement yet.");
+	si = (STANDARD_INFORMATION*)((u8*)ctx->attr +
+			le16_to_cpu(ctx->attr->data.resident.value_offset));
+	/* Update the access times if they have changed. */
+	nt = utc2ntfs(vi->i_mtime);
+	if (si->last_data_change_time != nt) {
+		ntfs_debug("Updating mtime for inode 0x%lx: old = 0x%llx, "
+				"new = 0x%llx", vi->i_ino,
+				sle64_to_cpu(si->last_data_change_time),
+				sle64_to_cpu(nt));
+		si->last_data_change_time = nt;
+		modified = TRUE;
+	}
+	nt = utc2ntfs(vi->i_ctime);
+	if (si->last_mft_change_time != nt) {
+		ntfs_debug("Updating ctime for inode 0x%lx: old = 0x%llx, "
+				"new = 0x%llx", vi->i_ino,
+				sle64_to_cpu(si->last_mft_change_time),
+				sle64_to_cpu(nt));
+		si->last_mft_change_time = nt;
+		modified = TRUE;
+	}
+	nt = utc2ntfs(vi->i_atime);
+	if (si->last_access_time != nt) {
+		ntfs_debug("Updating atime for inode 0x%lx: old = 0x%llx, "
+				"new = 0x%llx", vi->i_ino,
+				sle64_to_cpu(si->last_access_time),
+				sle64_to_cpu(nt));
+		si->last_access_time = nt;
+		modified = TRUE;
+	}
 	/*
-	 * We just modified the mft record containing the standard information
-	 * attribute.  So need to mark the mft record dirty, too, but we do it
-	 * manually so that mark_inode_dirty() is not called again.
-	 * TODO:  Only do this if there was a change in any of the times!
+	 * If we just modified the standard information attribute we need to
+	 * mark the mft record it is in dirty.  We do this manually so that
+	 * mark_inode_dirty() is not called which would redirty the inode and
+	 * hence result in an infinite loop of trying to write the inode.
+	 * There is no need to mark the base inode nor the base mft record
+	 * dirty, since we are going to write this mft record below in any case
+	 * and the base mft record may actually not have been modified so it
+	 * might not need to be written out.
 	 */
-	if (!NInoTestSetDirty(ctx->ntfs_ino))
+	if (modified && !NInoTestSetDirty(ctx->ntfs_ino))
 		__set_page_dirty_nobuffers(ctx->ntfs_ino->page);
 	put_attr_search_ctx(ctx);
-#endif
-	/* Write this base mft record. */
+	/* Now the access times are updated, write the base mft record. */
 	if (NInoDirty(ni))
 		err = write_mft_record(ni, m, sync);
 	/* Write all attached extent mft records. */
@@ -2413,10 +2437,8 @@
 		goto err_out;
 	ntfs_debug("Done.");
 	return 0;
-#if 0
 unm_err_out:
 	unmap_mft_record(ni);
-#endif
 err_out:
 	if (err == -ENOMEM) {
 		ntfs_warning(vi->i_sb, "Not enough memory to write inode.  "
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-08-18 20:49:56 +01:00
+++ b/fs/ntfs/super.c	2004-08-18 20:49:56 +01:00
@@ -409,7 +409,7 @@
 #ifndef NTFS_RW
 	/* For read-only compiled driver, enforce all read-only flags. */
 	*flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
-#else /* ! NTFS_RW */
+#else /* NTFS_RW */
 	/*
 	 * For the read-write compiled driver, if we are remounting read-write,
 	 * make sure there are no volume errors and that no unsupported volume
@@ -479,28 +479,7 @@
 						"flags.  Run chkdsk.");
 		}
 	}
-	// TODO:  For now we enforce no atime and dir atime updates as they are
-	// not implemented.
-	if ((sb->s_flags & MS_NOATIME) && !(*flags & MS_NOATIME))
-		ntfs_warning(sb, "Atime updates are not implemented yet.  "
-				"Leaving them disabled.");
-	else if ((sb->s_flags & MS_NODIRATIME) && !(*flags & MS_NODIRATIME))
-		ntfs_warning(sb, "Directory atime updates are not implemented "
-				"yet.  Leaving them disabled.");
-	*flags |= MS_NOATIME | MS_NODIRATIME;
-#endif /* ! NTFS_RW */
-
-	// FIXME/TODO: If left like this we will have problems with rw->ro and
-	// ro->rw, as well as with sync->async and vice versa remounts.
-	// Note: The VFS already checks that there are no pending deletes and
-	// no open files for writing. So we only need to worry about dirty
-	// inode pages and dirty system files (which include dirty inodes).
-	// Either handle by flushing the whole volume NOW or by having the
-	// write routines work on MS_RDONLY fs and guarantee we don't mark
-	// anything as dirty if MS_RDONLY is set. That way the dirty data
-	// would get flushed but no new dirty data would appear. This is
-	// probably best but we need to be careful not to mark anything dirty
-	// or the MS_RDONLY will be leaking writes.
+#endif /* NTFS_RW */
 
 	// TODO: Deal with *flags.
 
@@ -2139,15 +2118,7 @@
 	ntfs_debug("Entering.");
 #ifndef NTFS_RW
 	sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
-#else
-	if (!(sb->s_flags & MS_NOATIME))
-		ntfs_warning(sb, "Atime updates are not implemented yet.  "
-				"Disabling them.");
-	else if (!(sb->s_flags & MS_NODIRATIME))
-		ntfs_warning(sb, "Directory atime updates are not implemented "
-				"yet.  Disabling them.");
-	sb->s_flags |= MS_NOATIME | MS_NODIRATIME;
-#endif
+#endif /* ! NTFS_RW */
 	/* Allocate a new ntfs_volume and place it in sb->s_fs_info. */
 	sb->s_fs_info = kmalloc(sizeof(ntfs_volume), GFP_NOFS);
 	vol = NTFS_SB(sb);
