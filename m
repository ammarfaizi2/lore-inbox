Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316230AbSEKPKq>; Sat, 11 May 2002 11:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316231AbSEKPKp>; Sat, 11 May 2002 11:10:45 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:45859 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316230AbSEKPKm>; Sat, 11 May 2002 11:10:42 -0400
Subject: [PATCH] NTFS 2.0.7 release (small cleanup)
To: linux-kernel@vger.kernel.org (Linux Kernel)
Date: Sat, 11 May 2002 16:10:17 +0100 (BST)
Cc: linux-ntfs-dev@lists.sourceforge.net
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E176YVl-0001uM-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, I just submitted this patch updating ntfs to 2.0.7 to Linus
for inclusion. Patch is also available from the ntfs bitkeeper tree:
	bk://linux-ntfs.bkbits.net/ntfs-tng-2.5

This will update the following files:

 fs/ntfs/ChangeLog  |    9 +++
 fs/ntfs/Makefile   |    2 
 fs/ntfs/aops.c     |    6 --
 fs/ntfs/attraops.c |    1 
 fs/ntfs/file.c     |  120 +----------------------------------------------------
 fs/ntfs/mft.c      |    9 ---
 fs/ntfs/namei.c    |   37 ----------------
 fs/ntfs/ntfs.h     |    9 ---
 fs/ntfs/super.c    |   32 +++++---------
 9 files changed, 26 insertions(+), 199 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/05/11 1.539)
   NTFS 2.0.7 release: pure cleanups.

<aia21@cantab.net> (02/05/11 1.513.26.1)
   NTFS 2.0.7: minor cleanup, remove NULL struct initializers


diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Sat May 11 16:06:22 2002
+++ b/fs/ntfs/ChangeLog	Sat May 11 16:06:22 2002
@@ -28,6 +28,10 @@
 
 	- Remove much of the NULL struct element initializers.
 	- Various updates to make compatible with recent kernels.
+	- Remove defines of MAX_BUF_PER_PAGE and include linux/buffer_head.h
+	  in fs/ntfs/ntfs.h instead.
+	- Remove no longer needed KERNEL_VERSION checks. We are now in the
+	  kernel proper so they are no longer needed.
 
 2.0.6 - Major bugfix to make compatible with other kernel changes.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	Sat May 11 16:06:22 2002
+++ b/fs/ntfs/aops.c	Sat May 11 16:06:22 2002
@@ -29,12 +29,6 @@
 
 #include "ntfs.h"
 
-#define MAX_BUF_PER_PAGE (PAGE_CACHE_SIZE / 512)
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,8)
-#define page_buffers(page)	(page)->buffers
-#endif
-
 /**
  * end_buffer_read_file_async -
  *
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	Sat May 11 16:06:22 2002
+++ b/fs/ntfs/mft.c	Sat May 11 16:06:22 2002
@@ -25,8 +25,6 @@
 
 #include "ntfs.h"
 
-#define MAX_BUF_PER_PAGE (PAGE_CACHE_SIZE / 512)
-
 /**
  * __format_mft_record - initialize an empty mft record
  * @m:		mapped, pinned and locked for writing mft record
diff -Nru a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
--- a/fs/ntfs/ntfs.h	Sat May 11 16:06:22 2002
+++ b/fs/ntfs/ntfs.h	Sat May 11 16:06:22 2002
@@ -26,14 +26,11 @@
 
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,5)
-#	error The NTFS driver requires at least kernel 2.5.5.
-#endif
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/compiler.h>
 #include <linux/fs.h>
+#include <linux/buffer_head.h>
 #include <linux/nls.h>
 #include <linux/pagemap.h>
 #include <linux/smp.h>
@@ -48,10 +45,6 @@
 #include "layout.h"
 #include "attrib.h"
 #include "mft.h"
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-typedef long sector_t;
-#endif
 
 typedef enum {
 	NTFS_BLOCK_SIZE		= 512,
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Sat May 11 16:06:23 2002
+++ b/fs/ntfs/ChangeLog	Sat May 11 16:06:23 2002
@@ -24,6 +24,11 @@
 	- Want to use dummy inodes for address space i/o. We need some VFS
 	  changes first, which are currently under discussion.
 
+2.0.7 - Minor cleanups and updates for changes in core kernel code.
+
+	- Remove much of the NULL struct element initializers.
+	- Various updates to make compatible with recent kernels.
+
 2.0.6 - Major bugfix to make compatible with other kernel changes.
 
 	- Initialize the mftbmp address space properly now that there are more
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Sat May 11 16:06:23 2002
+++ b/fs/ntfs/Makefile	Sat May 11 16:06:23 2002
@@ -7,7 +7,7 @@
 
 obj-m   := $(O_TARGET)
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.6\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.7\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/attraops.c b/fs/ntfs/attraops.c
--- a/fs/ntfs/attraops.c	Sat May 11 16:06:23 2002
+++ b/fs/ntfs/attraops.c	Sat May 11 16:06:23 2002
@@ -43,6 +43,5 @@
 						   disk request queue. */
 	prepare_write:	NULL,			/* . */
 	commit_write:	NULL,			/* . */
-	//truncatepage:	NULL,			/* . */
 };
 
diff -Nru a/fs/ntfs/file.c b/fs/ntfs/file.c
--- a/fs/ntfs/file.c	Sat May 11 16:06:23 2002
+++ b/fs/ntfs/file.c	Sat May 11 16:06:23 2002
@@ -24,127 +24,13 @@
 struct file_operations ntfs_file_ops = {
 	llseek:			generic_file_llseek,	/* Seek inside file. */
 	read:			generic_file_read,	/* Read from file. */
-	write:			NULL,			/* . */
-	readdir:		NULL,			/* . */
-	poll:			NULL,			/* . */
-	ioctl:			NULL,			/* . */
 	mmap:			generic_file_mmap,	/* Mmap file. */
 	open:			generic_file_open,	/* Open file. */
-	flush:			NULL,			/* . */
-	release:		NULL,			/* . */
-	fsync:			NULL,			/* . */
-	fasync:			NULL,			/* . */
-	lock:			NULL,			/* . */
-	readv:			NULL,			/* . */
-	writev:			NULL,			/* . */
-	sendpage:		NULL,			/* . */
-	get_unmapped_area:	NULL,			/* . */
 };
 
-struct inode_operations ntfs_file_inode_ops = {
-	create:		NULL,		/* . */
-	lookup:		NULL,		/* . */
-	link:		NULL,		/* . */
-	unlink:		NULL,		/* . */
-	symlink:	NULL,		/* . */
-	mkdir:		NULL,		/* . */
-	rmdir:		NULL,		/* . */
-	mknod:		NULL,		/* . */
-	rename:		NULL,		/* . */
-	readlink:	NULL,		/* . */
-	follow_link:	NULL,		/* . */
-	truncate:	NULL,		/* . */
-	permission:	NULL,		/* . */
-	revalidate:	NULL,		/* . */
-	setattr:	NULL,		/* . */
-	getattr:	NULL,		/* . */
-};
-
-#if 0
-/* NOTE: read, write, poll, fsync, readv, writev can be called without the big
- * kernel lock held in all filesystems. */
-struct file_operations {
-	struct module *owner;
-	loff_t (*llseek) (struct file *, loff_t, int);
-	ssize_t (*read) (struct file *, char *, size_t, loff_t *);
-	ssize_t (*write) (struct file *, const char *, size_t, loff_t *);
-	int (*readdir) (struct file *, void *, filldir_t);
-	unsigned int (*poll) (struct file *, struct poll_table_struct *);
-	int (*ioctl) (struct inode *, struct file *, unsigned int,
-			unsigned long);
-	int (*mmap) (struct file *, struct vm_area_struct *);
-	int (*flush) (struct file *);
-	int (*release) (struct inode *, struct file *);
-	int (*fsync) (struct file *, struct dentry *, int datasync);
-	int (*fasync) (int, struct file *, int);
-	int (*lock) (struct file *, int, struct file_lock *);
-	ssize_t (*readv) (struct file *, const struct iovec *, unsigned long,
-			loff_t *);
-	ssize_t (*writev) (struct file *, const struct iovec *, unsigned long,
-			loff_t *);
-	ssize_t (*sendpage) (struct file *, struct page *, int, size_t,
-			loff_t *, int);
-	unsigned long (*get_unmapped_area)(struct file *, unsigned long,
-			unsigned long, unsigned long, unsigned long);
-};
+struct inode_operations ntfs_file_inode_ops = {};
 
-struct inode_operations {
-	int (*create) (struct inode *,struct dentry *,int);
-	struct dentry * (*lookup) (struct inode *,struct dentry *);
-	int (*link) (struct dentry *,struct inode *,struct dentry *);
-	int (*unlink) (struct inode *,struct dentry *);
-	int (*symlink) (struct inode *,struct dentry *,const char *);
-	int (*mkdir) (struct inode *,struct dentry *,int);
-	int (*rmdir) (struct inode *,struct dentry *);
-	int (*mknod) (struct inode *,struct dentry *,int,int);
-	int (*rename) (struct inode *, struct dentry *,
-			struct inode *, struct dentry *);
-	int (*readlink) (struct dentry *, char *,int);
-	int (*follow_link) (struct dentry *, struct nameidata *);
-	void (*truncate) (struct inode *);
-	int (*permission) (struct inode *, int);
-	int (*revalidate) (struct dentry *);
-	int (*setattr) (struct dentry *, struct iattr *);
-	int (*getattr) (struct dentry *, struct iattr *);
-};
-#endif
+struct file_operations ntfs_empty_file_ops = {};
 
-struct file_operations ntfs_empty_file_ops = {
-	llseek:			NULL,			/* . */
-	read:			NULL,			/* . */
-	write:			NULL,			/* . */
-	readdir:		NULL,			/* . */
-	poll:			NULL,			/* . */
-	ioctl:			NULL,			/* . */
-	mmap:			NULL,			/* . */
-	open:			NULL,			/* . */
-	flush:			NULL,			/* . */
-	release:		NULL,			/* . */
-	fsync:			NULL,			/* . */
-	fasync:			NULL,			/* . */
-	lock:			NULL,			/* . */
-	readv:			NULL,			/* . */
-	writev:			NULL,			/* . */
-	sendpage:		NULL,			/* . */
-	get_unmapped_area:	NULL,			/* . */
-};
-
-struct inode_operations ntfs_empty_inode_ops = {
-	create:		NULL,		/* . */
-	lookup:		NULL,		/* . */
-	link:		NULL,		/* . */
-	unlink:		NULL,		/* . */
-	symlink:	NULL,		/* . */
-	mkdir:		NULL,		/* . */
-	rmdir:		NULL,		/* . */
-	mknod:		NULL,		/* . */
-	rename:		NULL,		/* . */
-	readlink:	NULL,		/* . */
-	follow_link:	NULL,		/* . */
-	truncate:	NULL,		/* . */
-	permission:	NULL,		/* . */
-	revalidate:	NULL,		/* . */
-	setattr:	NULL,		/* . */
-	getattr:	NULL,		/* . */
-};
+struct inode_operations ntfs_empty_inode_ops = {};
 
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	Sat May 11 16:06:23 2002
+++ b/fs/ntfs/mft.c	Sat May 11 16:06:23 2002
@@ -114,13 +114,6 @@
 						   disk request queue. */
 	prepare_write:	NULL,			/* . */
 	commit_write:	NULL,			/* . */
-	bmap:		NULL,			/* Needed for FIBMAP.
-						   Don't use it. */
-	flushpage:	NULL,			/* . */
-	releasepage:	NULL,			/* . */
-#ifdef KERNEL_HAS_O_DIRECT
-	direct_IO:	NULL,			/* . */
-#endif
 };
 
 /**
diff -Nru a/fs/ntfs/namei.c b/fs/ntfs/namei.c
--- a/fs/ntfs/namei.c	Sat May 11 16:06:23 2002
+++ b/fs/ntfs/namei.c	Sat May 11 16:06:23 2002
@@ -103,43 +103,6 @@
 }
 
 struct inode_operations ntfs_dir_inode_ops = {
-	create:		NULL,		/* . */
 	lookup:		ntfs_lookup,	/* lookup directory. */
-	link:		NULL,		/* . */
-	unlink:		NULL,		/* . */
-	symlink:	NULL,		/* . */
-	mkdir:		NULL,		/* . */
-	rmdir:		NULL,		/* . */
-	mknod:		NULL,		/* . */
-	rename:		NULL,		/* . */
-	readlink:	NULL,		/* . */
-	follow_link:	NULL,		/* . */
-	truncate:	NULL,		/* . */
-	permission:	NULL,		/* . */
-	revalidate:	NULL,		/* . */
-	setattr:	NULL,		/* . */
-	getattr:	NULL,		/* . */
 };
-
-#if 0
-struct inode_operations {
-	int (*create) (struct inode *,struct dentry *,int);
-	struct dentry * (*lookup) (struct inode *,struct dentry *);
-	int (*link) (struct dentry *,struct inode *,struct dentry *);
-	int (*unlink) (struct inode *,struct dentry *);
-	int (*symlink) (struct inode *,struct dentry *,const char *);
-	int (*mkdir) (struct inode *,struct dentry *,int);
-	int (*rmdir) (struct inode *,struct dentry *);
-	int (*mknod) (struct inode *,struct dentry *,int,int);
-	int (*rename) (struct inode *, struct dentry *,
-			struct inode *, struct dentry *);
-	int (*readlink) (struct dentry *, char *,int);
-	int (*follow_link) (struct dentry *, struct nameidata *);
-	void (*truncate) (struct inode *);
-	int (*permission) (struct inode *, int);
-	int (*revalidate) (struct dentry *);
-	int (*setattr) (struct dentry *, struct iattr *);
-	int (*getattr) (struct dentry *, struct iattr *);
-};
-#endif
 
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Sat May 11 16:06:23 2002
+++ b/fs/ntfs/super.c	Sat May 11 16:06:23 2002
@@ -1424,31 +1424,23 @@
 						   called from iget(). */
 	dirty_inode:	ntfs_dirty_inode,	/* VFS: Called from
 						   __mark_inode_dirty(). */
-	write_inode:	NULL,		/* VFS: Write dirty inode to disk. */
-	put_inode:	NULL,		/* VFS: Called whenever the reference
-					   count (i_count) of the inode is
-					   going to be decreased but before the
-					   actual decrease. */
-	delete_inode:	NULL,		/* VFS: Delete inode from disk. Called
-					   when i_count becomes 0 and i_nlink is
-					   also 0. */
+	//write_inode:	NULL,		/* VFS: Write dirty inode to disk. */
+	//put_inode:	NULL,		/* VFS: Called whenever the reference
+	//				   count (i_count) of the inode is
+	//				   going to be decreased but before the
+	//				   actual decrease. */
+	//delete_inode:	NULL,		/* VFS: Delete inode from disk. Called
+	//				   when i_count becomes 0 and i_nlink is
+	//				   also 0. */
 	put_super:	ntfs_put_super,	/* Syscall: umount. */
-	write_super:	NULL,		/* Flush dirty super block to disk. */
-	write_super_lockfs:	NULL,	/* ? */
-	unlockfs:	NULL,		/* ? */
+	//write_super:	NULL,		/* Flush dirty super block to disk. */
+	//write_super_lockfs:	NULL,	/* ? */
+	//unlockfs:	NULL,		/* ? */
 	statfs:		ntfs_statfs,	/* Syscall: statfs */
 	remount_fs:	ntfs_remount,	/* Syscall: mount -o remount. */
 	clear_inode:	ntfs_clear_big_inode,	/* VFS: Called when an inode is
 						   removed from memory. */
-	umount_begin:	NULL,		/* Forced umount. */
-	/*
-	 * These are NFSd support functions but NTFS is a standard fs so
-	 * shouldn't need to implement these manually. At least we can try
-	 * without and if it doesn't work in some way we can always implement
-	 * something here.
-	 */
-	fh_to_dentry:	NULL,		/* Get dentry for given file handle. */
-	dentry_to_fh:	NULL,		/* Get file handle for given dentry. */
+	//umount_begin:	NULL,		/* Forced umount. */
 	show_options:	ntfs_show_options, /* Show mount options in proc. */
 };
 

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This BitKeeper patch contains the following changesets:
aia21@cantab.net|ChangeSet|20020511140008|01977
aia21@cantab.net|ChangeSet|20020511112351|01997
aia21@cantab.net|ChangeSet|20020511110827|41648
## Wrapped with gzip_uu ##


begin 664 bkpatch17542
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
2?BQ#UYF$CF/]#^,JRQWW(@``
`
end
