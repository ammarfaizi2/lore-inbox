Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316595AbSHGBBe>; Tue, 6 Aug 2002 21:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316599AbSHGBBe>; Tue, 6 Aug 2002 21:01:34 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:8399 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316595AbSHGBBb>; Tue, 6 Aug 2002 21:01:31 -0400
Subject: [BK-PATCH-2.5] NTFS 2.0.24: Cleanups
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 7 Aug 2002 02:05:04 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17cFG4-0007hW-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-tng-2.5

Thanks! This is just some cleanups, mostly the BUG_ON() cleanups from
Adam J. Richter. Just to relax a bit after the big changes in the
last ntfs update. (-;

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |    3 +++
 fs/ntfs/ChangeLog                  |   16 ++++++++++++++++
 fs/ntfs/Makefile                   |    2 +-
 fs/ntfs/attrib.c                   |   15 ++++++++++-----
 fs/ntfs/compress.c                 |    3 ++-
 fs/ntfs/file.c                     |    9 ++++++++-
 fs/ntfs/inode.c                    |    8 ++++++--
 fs/ntfs/super.c                    |   21 +++++++++++++++++----
 fs/ntfs/volume.h                   |    2 ++
 9 files changed, 65 insertions(+), 14 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/08/07 1.471)
   NTFS: 2.0.24 - Cleanups.
   - Treat BUG_ON() as ASSERT() not VERIFY(), i.e. do not use side effects
     inside BUG_ON(). (Adam J. Richter)
   - Split logical OR expressions inside BUG_ON() into individual BUG_ON()
     calls for improved debugging. (Adam J. Richter)
   - Add errors flag to the ntfs volume state, accessed via
     NVol{,Set,Clear}Errors(vol).
   - Do not allow read-write remounts of read-only volumes with errors.
   - Clarify comment for ntfs file operation sendfile which was added by
     Christoph Hellwig a while ago (just using generic_file_sendfile())
     to say that ntfs ->sendfile is only used for the case where the
     source data is on the ntfs partition and the destination is
     somewhere else, i.e. nothing we need to concern ourselves with.


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Wed Aug  7 01:48:11 2002
+++ b/Documentation/filesystems/ntfs.txt	Wed Aug  7 01:48:11 2002
@@ -247,6 +247,9 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.0.24:
+	- Small internal cleanups.
+	- Support for sendfile system call. (Christoph Hellwig)
 2.0.23:
 	- Massive internal locking changes to mft record locking. Fixes
 	  various race conditions and deadlocks.
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Wed Aug  7 01:48:11 2002
+++ b/fs/ntfs/ChangeLog	Wed Aug  7 01:48:11 2002
@@ -2,6 +2,22 @@
 	- Find and fix bugs.
 	- Enable NFS exporting of NTFS.
 
+2.0.24 - Cleanups.
+
+	- Treat BUG_ON() as ASSERT() not VERIFY(), i.e. do not use side effects
+	  inside BUG_ON(). (Adam J. Richter)
+	- Split logical OR expressions inside BUG_ON() into individual BUG_ON()
+	  calls for improved debugging. (Adam J. Richter)
+	- Add errors flag to the ntfs volume state, accessed via
+	  NVol{,Set,Clear}Errors(vol).
+	- Do not allow read-write remounts of read-only volumes with errors.
+	- Clarify comment for ntfs file operation sendfile which was added by
+	  Christoph Hellwig a while ago (just using generic_file_sendfile())
+	  to say that ntfs ->sendfile is only used for the case where the
+	  source data is on the ntfs partition and the destination is
+	  somewhere else, i.e. nothing we need to concern ourselves with.
+	- Add generic_file_write() as our ntfs file write operation.
+
 2.0.23 - Major bug fixes (races, deadlocks, non-i386 architectures).
 
 	- Massive internal locking changes to mft record locking. Fixes lock
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Wed Aug  7 01:48:11 2002
+++ b/fs/ntfs/Makefile	Wed Aug  7 01:48:11 2002
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.23\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.24\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	Wed Aug  7 01:48:11 2002
+++ b/fs/ntfs/attrib.c	Wed Aug  7 01:48:11 2002
@@ -110,7 +110,8 @@
 static inline BOOL ntfs_are_rl_mergeable(run_list_element *dst,
 		run_list_element *src)
 {
-	BUG_ON(!dst || !src);
+	BUG_ON(!dst);
+	BUG_ON(!src);
 
 	if ((dst->lcn < 0) || (src->lcn < 0))     /* Are we merging holes? */
 		return FALSE;
@@ -192,7 +193,8 @@
 	BOOL right;
 	int magic;
 
-	BUG_ON(!dst || !src);
+	BUG_ON(!dst);
+	BUG_ON(!src);
 
 	/* First, check if the right hand end needs merging. */
 	right = ntfs_are_rl_mergeable(src + ssize - 1, dst + loc + 1);
@@ -258,7 +260,8 @@
 	BOOL hole = FALSE;	/* Following a hole */
 	int magic;
 
-	BUG_ON(!dst || !src);
+	BUG_ON(!dst);
+	BUG_ON(!src);
 
 	/* disc => Discontinuity between the end of @dst and the start of @src.
 	 *         This means we might need to insert a hole.
@@ -362,7 +365,8 @@
 	BOOL right;
 	int magic;
 
-	BUG_ON(!dst || !src);
+	BUG_ON(!dst);
+	BUG_ON(!src);
 
 	/* First, merge the left and right ends, if necessary. */
 	right = ntfs_are_rl_mergeable(src + ssize - 1, dst + loc + 1);
@@ -423,7 +427,8 @@
 static inline run_list_element *ntfs_rl_split(run_list_element *dst, int dsize,
 		run_list_element *src, int ssize, int loc)
 {
-	BUG_ON(!dst || !src);
+	BUG_ON(!dst);
+	BUG_ON(!src);
 
 	/* Space required: @dst size + @src size + one new hole. */
 	dst = ntfs_rl_realloc(dst, dsize, dsize + ssize + 1);
diff -Nru a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c	Wed Aug  7 01:48:11 2002
+++ b/fs/ntfs/compress.c	Wed Aug  7 01:48:11 2002
@@ -467,7 +467,8 @@
 	 * Bad things happen if we get here for anything that is not an
 	 * unnamed $DATA attribute.
 	 */
-	BUG_ON(ni->type != AT_DATA || ni->name_len);
+	BUG_ON(ni->type != AT_DATA);
+	BUG_ON(ni->name_len);
 
 	pages = kmalloc(nr_pages * sizeof(struct page *), GFP_NOFS);
 
diff -Nru a/fs/ntfs/file.c b/fs/ntfs/file.c
--- a/fs/ntfs/file.c	Wed Aug  7 01:48:11 2002
+++ b/fs/ntfs/file.c	Wed Aug  7 01:48:11 2002
@@ -51,8 +51,15 @@
 struct file_operations ntfs_file_ops = {
 	.llseek		= generic_file_llseek,	/* Seek inside file. */
 	.read		= generic_file_read,	/* Read from file. */
+#ifdef NTFS_RW
+	.write		= generic_file_write,	/* Write to a file. */
+#endif
 	.mmap		= generic_file_mmap,	/* Mmap file. */
- 	.sendfile	= generic_file_sendfile,/* Zero-copy data send. */
+	.sendfile	= generic_file_sendfile,/* Zero-copy data send with the
+						   data source being on the
+						   ntfs partition. We don't
+						   need to care about the data
+						   destination. */
 	.open		= ntfs_file_open,	/* Open file. */
 };
 
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	Wed Aug  7 01:48:11 2002
+++ b/fs/ntfs/inode.c	Wed Aug  7 01:48:11 2002
@@ -278,7 +278,9 @@
 	ntfs_inode *ni = NTFS_I(inode);
 
 	ntfs_debug("Entering.");
-	BUG_ON(ni->page || !atomic_dec_and_test(&ni->count));
+	BUG_ON(ni->page);
+	if (!atomic_dec_and_test(&ni->count))
+		BUG();
 	kmem_cache_free(ntfs_big_inode_cache, NTFS_I(inode));
 }
 
@@ -299,7 +301,9 @@
 void ntfs_destroy_extent_inode(ntfs_inode *ni)
 {
 	ntfs_debug("Entering.");
-	BUG_ON(ni->page || !atomic_dec_and_test(&ni->count));
+	BUG_ON(ni->page);
+	if (!atomic_dec_and_test(&ni->count))
+		BUG();
 	kmem_cache_free(ntfs_inode_cache, ni);
 }
 
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Wed Aug  7 01:48:11 2002
+++ b/fs/ntfs/super.c	Wed Aug  7 01:48:11 2002
@@ -307,6 +307,23 @@
 
 	ntfs_debug("Entering with remount options string: %s", opt);
 
+#ifndef NTFS_RW
+	/* For read-only compiled driver, enforce all read-only flags. */
+	*flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+#else
+	/*
+	 * For the read-write compiled driver, if we are remounting read-write,
+	 * make sure there aren't any volume errors.
+	 */
+	if ((sb->s_flags & MS_RDONLY) && !(*flags & MS_RDONLY)) {
+		if (NVolErrors(vol)) {
+			ntfs_error(sb, "Volume has errors and is read-only."
+					"Cannot remount read-write.");
+			return -EROFS;
+		}
+	}
+#endif
+
 	// FIXME/TODO: If left like this we will have problems with rw->ro and
 	// ro->rw, as well as with sync->async and vice versa remounts.
 	// Note: The VFS already checks that there are no pending deletes and
@@ -323,10 +340,6 @@
 
 	if (!parse_options(vol, opt))
 		return -EINVAL;
-
-#ifndef NTFS_RW
-	*flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
-#endif
 
 	return 0;
 }
diff -Nru a/fs/ntfs/volume.h b/fs/ntfs/volume.h
--- a/fs/ntfs/volume.h	Wed Aug  7 01:48:11 2002
+++ b/fs/ntfs/volume.h	Wed Aug  7 01:48:11 2002
@@ -101,6 +101,7 @@
  * Defined bits for the flags field in the ntfs_volume structure.
  */
 typedef enum {
+	NV_Errors,		/* 1: Volume has errors, prevent remount rw. */
 	NV_ShowSystemFiles,	/* 1: Return system files in ntfs_readdir(). */
 	NV_CaseSensitive,	/* 1: Treat file names as case sensitive and
 				      create filenames in the POSIX namespace.
@@ -127,6 +128,7 @@
 }
 
 /* Emit the ntfs volume bitops functions. */
+NVOL_FNS(Errors)
 NVOL_FNS(ShowSystemFiles)
 NVOL_FNS(CaseSensitive)
 

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch26415
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
2DT//&\3$)H[^7PB?+$`D(@``
`
end
