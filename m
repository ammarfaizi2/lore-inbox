Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbVBBSED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVBBSED (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 13:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVBBSEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 13:04:02 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:13529 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262284AbVBBSBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 13:01:33 -0500
Date: Wed, 2 Feb 2005 11:00:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.11-rc2] Move <linux/prio_tree.h> down in <linux/fs.h>
Message-ID: <20050202180057.GD15359@smtp.west.cox.net>
References: <20050201160642.GA15359@smtp.west.cox.net> <1107361283.12383.0.camel@localhost.localdomain> <20050202163421.GC15359@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202163421.GC15359@smtp.west.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 09:34:21AM -0700, Tom Rini wrote:
> On Wed, Feb 02, 2005 at 04:21:23PM +0000, David Woodhouse wrote:
> > On Tue, 2005-02-01 at 09:06 -0700, Tom Rini wrote:
> > > <linux/prio_tree.h> is unsafe for inclusion by userland apps, but it
> > > is in the userland-exposed portion of <linux/fs.h>.  It's only needed
> > > in the __KERNEL__ protected portion of the file, so move the #include
> > > down to there.
> > 
> > You accidentally posted this patch to the kernel list, not to the
> > maintainers of the libc-kernelheaders package. And you might as well
> > just remove the offending #include rather than moving it to a section of
> > the file which is never used.
> 
> Ignoring your hint for a moment, since __KERNEL__ is still scattered all
> over the place, and I haven't see anything (changeset-wise) adding "You
> must use libc-kernelheaders now" in Documentation/feature-removal-schedule.txt
> this is still an actual problem.  Thanks.
> 
> Feel free to correct me by getting something added to
> Documentation/feature-removal-schedule.txt :)

After talking with David a bit off-list, I'd like to ask that my
original patch get pushed in time for 2.6.11, and the following a bit
later (or now, that's fine too :)) (splitting the reverse was ~1400
lines in fs_kern.h in ~200 in fs.h).

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

 include/linux/fs_user.h |  197 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h      |  209 ++----------------------------------------------
 2 files changed, 209 insertions(+), 197 deletions(-)

--- 1.377/include/linux/fs.h	2005-01-25 14:43:48 -07:00
+++ edited/include/linux/fs.h	2005-02-02 10:42:06 -07:00
@@ -3,9 +3,13 @@
 
 /*
  * This file has definitions for some important file table
- * structures etc.
+ * structures etc.  Any userspace visiable changes must go into
+ * <linux/fs_user.h>
  */
 
+#include <linux/fs_user.h>
+
+#ifdef __KERNEL__
 #include <linux/config.h>
 #include <linux/linkage.h>
 #include <linux/limits.h>
@@ -16,9 +20,15 @@
 #include <linux/dcache.h>
 #include <linux/stat.h>
 #include <linux/cache.h>
-#include <linux/prio_tree.h>
 #include <linux/kobject.h>
+#include <linux/list.h>
+#include <linux/radix-tree.h>
+#include <linux/prio_tree.h>
+#include <linux/audit.h>
+#include <linux/init.h>
 #include <asm/atomic.h>
+#include <asm/semaphore.h>
+#include <asm/byteorder.h>
 
 struct iovec;
 struct nameidata;
@@ -28,201 +38,6 @@
 struct vm_area_struct;
 struct vfsmount;
 
-/*
- * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
- * the file limit at runtime and only root can increase the per-process
- * nr_file rlimit, so it's safe to set up a ridiculously high absolute
- * upper limit on files-per-process.
- *
- * Some programs (notably those using select()) may have to be 
- * recompiled to take full advantage of the new limits..  
- */
-
-/* Fixed constants first: */
-#undef NR_OPEN
-#define NR_OPEN (1024*1024)	/* Absolute upper limit on fd num */
-#define INR_OPEN 1024		/* Initial setting for nfile rlimits */
-
-#define BLOCK_SIZE_BITS 10
-#define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)
-
-/* And dynamically-tunable limits and defaults: */
-struct files_stat_struct {
-	int nr_files;		/* read only */
-	int nr_free_files;	/* read only */
-	int max_files;		/* tunable */
-};
-extern struct files_stat_struct files_stat;
-
-struct inodes_stat_t {
-	int nr_inodes;
-	int nr_unused;
-	int dummy[5];
-};
-extern struct inodes_stat_t inodes_stat;
-
-extern int leases_enable, lease_break_time;
-
-#ifdef CONFIG_DNOTIFY
-extern int dir_notify_enable;
-#endif
-
-#define NR_FILE  8192	/* this can well be larger on a larger system */
-
-#define MAY_EXEC 1
-#define MAY_WRITE 2
-#define MAY_READ 4
-#define MAY_APPEND 8
-
-#define FMODE_READ 1
-#define FMODE_WRITE 2
-
-/* Internal kernel extensions */
-#define FMODE_LSEEK	4
-#define FMODE_PREAD	8
-#define FMODE_PWRITE	FMODE_PREAD	/* These go hand in hand */
-
-#define RW_MASK		1
-#define RWA_MASK	2
-#define READ 0
-#define WRITE 1
-#define READA 2		/* read-ahead  - don't block if no resources */
-#define SPECIAL 4	/* For non-blockdevice requests in request queue */
-#define READ_SYNC	(READ | (1 << BIO_RW_SYNC))
-#define WRITE_SYNC	(WRITE | (1 << BIO_RW_SYNC))
-#define WRITE_BARRIER	((1 << BIO_RW) | (1 << BIO_RW_BARRIER))
-
-#define SEL_IN		1
-#define SEL_OUT		2
-#define SEL_EX		4
-
-/* public flags for file_system_type */
-#define FS_REQUIRES_DEV 1 
-#define FS_BINARY_MOUNTDATA 2
-#define FS_REVAL_DOT	16384	/* Check the paths ".", ".." for staleness */
-#define FS_ODD_RENAME	32768	/* Temporary stuff; will go away as soon
-				  * as nfs_rename() will be cleaned up
-				  */
-/*
- * These are the fs-independent mount-flags: up to 32 flags are supported
- */
-#define MS_RDONLY	 1	/* Mount read-only */
-#define MS_NOSUID	 2	/* Ignore suid and sgid bits */
-#define MS_NODEV	 4	/* Disallow access to device special files */
-#define MS_NOEXEC	 8	/* Disallow program execution */
-#define MS_SYNCHRONOUS	16	/* Writes are synced at once */
-#define MS_REMOUNT	32	/* Alter flags of a mounted FS */
-#define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
-#define MS_DIRSYNC	128	/* Directory modifications are synchronous */
-#define MS_NOATIME	1024	/* Do not update access times. */
-#define MS_NODIRATIME	2048	/* Do not update directory access times */
-#define MS_BIND		4096
-#define MS_MOVE		8192
-#define MS_REC		16384
-#define MS_VERBOSE	32768
-#define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
-#define MS_ACTIVE	(1<<30)
-#define MS_NOUSER	(1<<31)
-
-/*
- * Superblock flags that can be altered by MS_REMOUNT
- */
-#define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK|MS_NOATIME|\
-			 MS_NODIRATIME)
-
-/*
- * Old magic mount flag and mask
- */
-#define MS_MGC_VAL 0xC0ED0000
-#define MS_MGC_MSK 0xffff0000
-
-/* Inode flags - they have nothing to superblock flags now */
-
-#define S_SYNC		1	/* Writes are synced at once */
-#define S_NOATIME	2	/* Do not update access times */
-#define S_APPEND	4	/* Append-only file */
-#define S_IMMUTABLE	8	/* Immutable file */
-#define S_DEAD		16	/* removed, but still open directory */
-#define S_NOQUOTA	32	/* Inode is not counted to quota */
-#define S_DIRSYNC	64	/* Directory modifications are synchronous */
-#define S_NOCMTIME	128	/* Do not update file c/mtime */
-#define S_SWAPFILE	256	/* Do not truncate: swapon got its bmaps */
-
-/*
- * Note that nosuid etc flags are inode-specific: setting some file-system
- * flags just means all the inodes inherit those flags by default. It might be
- * possible to override it selectively if you really wanted to with some
- * ioctl() that is not currently implemented.
- *
- * Exception: MS_RDONLY is always applied to the entire file system.
- *
- * Unfortunately, it is possible to change a filesystems flags with it mounted
- * with files in use.  This means that all of the inodes will not have their
- * i_flags updated.  Hence, i_flags no longer inherit the superblock mount
- * flags, so these have to be checked separately. -- rmk@arm.uk.linux.org
- */
-#define __IS_FLG(inode,flg) ((inode)->i_sb->s_flags & (flg))
-
-#define IS_RDONLY(inode) ((inode)->i_sb->s_flags & MS_RDONLY)
-#define IS_SYNC(inode)		(__IS_FLG(inode, MS_SYNCHRONOUS) || \
-					((inode)->i_flags & S_SYNC))
-#define IS_DIRSYNC(inode)	(__IS_FLG(inode, MS_SYNCHRONOUS|MS_DIRSYNC) || \
-					((inode)->i_flags & (S_SYNC|S_DIRSYNC)))
-#define IS_MANDLOCK(inode)	__IS_FLG(inode, MS_MANDLOCK)
-
-#define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
-#define IS_APPEND(inode)	((inode)->i_flags & S_APPEND)
-#define IS_IMMUTABLE(inode)	((inode)->i_flags & S_IMMUTABLE)
-#define IS_NOATIME(inode)	(__IS_FLG(inode, MS_NOATIME) || ((inode)->i_flags & S_NOATIME))
-#define IS_NODIRATIME(inode)	__IS_FLG(inode, MS_NODIRATIME)
-#define IS_POSIXACL(inode)	__IS_FLG(inode, MS_POSIXACL)
-
-#define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
-#define IS_NOCMTIME(inode)	((inode)->i_flags & S_NOCMTIME)
-#define IS_SWAPFILE(inode)	((inode)->i_flags & S_SWAPFILE)
-
-/* the read-only stuff doesn't really belong here, but any other place is
-   probably as bad and I don't want to create yet another include file. */
-
-#define BLKROSET   _IO(0x12,93)	/* set device read-only (0 = read-write) */
-#define BLKROGET   _IO(0x12,94)	/* get read-only status (0 = read_write) */
-#define BLKRRPART  _IO(0x12,95)	/* re-read partition table */
-#define BLKGETSIZE _IO(0x12,96)	/* return device size /512 (long *arg) */
-#define BLKFLSBUF  _IO(0x12,97)	/* flush buffer cache */
-#define BLKRASET   _IO(0x12,98)	/* set read ahead for block device */
-#define BLKRAGET   _IO(0x12,99)	/* get current read ahead setting */
-#define BLKFRASET  _IO(0x12,100)/* set filesystem (mm/filemap.c) read-ahead */
-#define BLKFRAGET  _IO(0x12,101)/* get filesystem (mm/filemap.c) read-ahead */
-#define BLKSECTSET _IO(0x12,102)/* set max sectors per request (ll_rw_blk.c) */
-#define BLKSECTGET _IO(0x12,103)/* get max sectors per request (ll_rw_blk.c) */
-#define BLKSSZGET  _IO(0x12,104)/* get block device sector size */
-#if 0
-#define BLKPG      _IO(0x12,105)/* See blkpg.h */
-
-/* Some people are morons.  Do not use sizeof! */
-
-#define BLKELVGET  _IOR(0x12,106,size_t)/* elevator get */
-#define BLKELVSET  _IOW(0x12,107,size_t)/* elevator set */
-/* This was here just to show that the number is taken -
-   probably all these _IO(0x12,*) ioctls should be moved to blkpg.h. */
-#endif
-/* A jump here: 108-111 have been used for various private purposes. */
-#define BLKBSZGET  _IOR(0x12,112,size_t)
-#define BLKBSZSET  _IOW(0x12,113,size_t)
-#define BLKGETSIZE64 _IOR(0x12,114,size_t)	/* return device size in bytes (u64 *arg) */
-
-#define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
-#define FIBMAP	   _IO(0x00,1)	/* bmap access */
-#define FIGETBSZ   _IO(0x00,2)	/* get the block size used for bmap */
-
-#ifdef __KERNEL__
-
-#include <linux/list.h>
-#include <linux/radix-tree.h>
-#include <linux/audit.h>
-#include <linux/init.h>
-#include <asm/semaphore.h>
-#include <asm/byteorder.h>
 
 /* Used to be a macro which just called the function, now just a function */
 extern void update_atime (struct inode *);
--- /dev/null	2005-01-31 00:25:24.000000000 -0700
+++ b/include/linux/fs_user.h	2005-02-02 10:41:35.000000000 -0700
@@ -0,0 +1,197 @@
+#ifndef _LINUX_USER_FS_H
+#define _LINUX_USER_FS_H
+
+/*
+ * This file has definitions for some important file table
+ * structures, etc that userspace needs to see.
+ */
+
+#include <linux/types.h>
+
+/*
+ * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
+ * the file limit at runtime and only root can increase the per-process
+ * nr_file rlimit, so it's safe to set up a ridiculously high absolute
+ * upper limit on files-per-process.
+ *
+ * Some programs (notably those using select()) may have to be 
+ * recompiled to take full advantage of the new limits..  
+ */
+
+/* Fixed constants first: */
+#undef NR_OPEN
+#define NR_OPEN (1024*1024)	/* Absolute upper limit on fd num */
+#define INR_OPEN 1024		/* Initial setting for nfile rlimits */
+
+#define BLOCK_SIZE_BITS 10
+#define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)
+
+/* And dynamically-tunable limits and defaults: */
+struct files_stat_struct {
+	int nr_files;		/* read only */
+	int nr_free_files;	/* read only */
+	int max_files;		/* tunable */
+};
+extern struct files_stat_struct files_stat;
+
+struct inodes_stat_t {
+	int nr_inodes;
+	int nr_unused;
+	int dummy[5];
+};
+extern struct inodes_stat_t inodes_stat;
+
+extern int leases_enable, lease_break_time;
+
+#ifdef CONFIG_DNOTIFY
+extern int dir_notify_enable;
+#endif
+
+#define NR_FILE  8192	/* this can well be larger on a larger system */
+
+#define MAY_EXEC 1
+#define MAY_WRITE 2
+#define MAY_READ 4
+#define MAY_APPEND 8
+
+#define FMODE_READ 1
+#define FMODE_WRITE 2
+
+/* Internal kernel extensions */
+#define FMODE_LSEEK	4
+#define FMODE_PREAD	8
+#define FMODE_PWRITE	FMODE_PREAD	/* These go hand in hand */
+
+#define RW_MASK		1
+#define RWA_MASK	2
+#define READ 0
+#define WRITE 1
+#define READA 2		/* read-ahead  - don't block if no resources */
+#define SPECIAL 4	/* For non-blockdevice requests in request queue */
+#define READ_SYNC	(READ | (1 << BIO_RW_SYNC))
+#define WRITE_SYNC	(WRITE | (1 << BIO_RW_SYNC))
+#define WRITE_BARRIER	((1 << BIO_RW) | (1 << BIO_RW_BARRIER))
+
+#define SEL_IN		1
+#define SEL_OUT		2
+#define SEL_EX		4
+
+/* public flags for file_system_type */
+#define FS_REQUIRES_DEV 1 
+#define FS_BINARY_MOUNTDATA 2
+#define FS_REVAL_DOT	16384	/* Check the paths ".", ".." for staleness */
+#define FS_ODD_RENAME	32768	/* Temporary stuff; will go away as soon
+				  * as nfs_rename() will be cleaned up
+				  */
+/*
+ * These are the fs-independent mount-flags: up to 32 flags are supported
+ */
+#define MS_RDONLY	 1	/* Mount read-only */
+#define MS_NOSUID	 2	/* Ignore suid and sgid bits */
+#define MS_NODEV	 4	/* Disallow access to device special files */
+#define MS_NOEXEC	 8	/* Disallow program execution */
+#define MS_SYNCHRONOUS	16	/* Writes are synced at once */
+#define MS_REMOUNT	32	/* Alter flags of a mounted FS */
+#define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
+#define MS_DIRSYNC	128	/* Directory modifications are synchronous */
+#define MS_NOATIME	1024	/* Do not update access times. */
+#define MS_NODIRATIME	2048	/* Do not update directory access times */
+#define MS_BIND		4096
+#define MS_MOVE		8192
+#define MS_REC		16384
+#define MS_VERBOSE	32768
+#define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define MS_ACTIVE	(1<<30)
+#define MS_NOUSER	(1<<31)
+
+/*
+ * Superblock flags that can be altered by MS_REMOUNT
+ */
+#define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK|MS_NOATIME|\
+			 MS_NODIRATIME)
+
+/*
+ * Old magic mount flag and mask
+ */
+#define MS_MGC_VAL 0xC0ED0000
+#define MS_MGC_MSK 0xffff0000
+
+/* Inode flags - they have nothing to superblock flags now */
+
+#define S_SYNC		1	/* Writes are synced at once */
+#define S_NOATIME	2	/* Do not update access times */
+#define S_APPEND	4	/* Append-only file */
+#define S_IMMUTABLE	8	/* Immutable file */
+#define S_DEAD		16	/* removed, but still open directory */
+#define S_NOQUOTA	32	/* Inode is not counted to quota */
+#define S_DIRSYNC	64	/* Directory modifications are synchronous */
+#define S_NOCMTIME	128	/* Do not update file c/mtime */
+#define S_SWAPFILE	256	/* Do not truncate: swapon got its bmaps */
+
+/*
+ * Note that nosuid etc flags are inode-specific: setting some file-system
+ * flags just means all the inodes inherit those flags by default. It might be
+ * possible to override it selectively if you really wanted to with some
+ * ioctl() that is not currently implemented.
+ *
+ * Exception: MS_RDONLY is always applied to the entire file system.
+ *
+ * Unfortunately, it is possible to change a filesystems flags with it mounted
+ * with files in use.  This means that all of the inodes will not have their
+ * i_flags updated.  Hence, i_flags no longer inherit the superblock mount
+ * flags, so these have to be checked separately. -- rmk@arm.uk.linux.org
+ */
+#define __IS_FLG(inode,flg) ((inode)->i_sb->s_flags & (flg))
+
+#define IS_RDONLY(inode) ((inode)->i_sb->s_flags & MS_RDONLY)
+#define IS_SYNC(inode)		(__IS_FLG(inode, MS_SYNCHRONOUS) || \
+					((inode)->i_flags & S_SYNC))
+#define IS_DIRSYNC(inode)	(__IS_FLG(inode, MS_SYNCHRONOUS|MS_DIRSYNC) || \
+					((inode)->i_flags & (S_SYNC|S_DIRSYNC)))
+#define IS_MANDLOCK(inode)	__IS_FLG(inode, MS_MANDLOCK)
+
+#define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
+#define IS_APPEND(inode)	((inode)->i_flags & S_APPEND)
+#define IS_IMMUTABLE(inode)	((inode)->i_flags & S_IMMUTABLE)
+#define IS_NOATIME(inode)	(__IS_FLG(inode, MS_NOATIME) || ((inode)->i_flags & S_NOATIME))
+#define IS_NODIRATIME(inode)	__IS_FLG(inode, MS_NODIRATIME)
+#define IS_POSIXACL(inode)	__IS_FLG(inode, MS_POSIXACL)
+
+#define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
+#define IS_NOCMTIME(inode)	((inode)->i_flags & S_NOCMTIME)
+#define IS_SWAPFILE(inode)	((inode)->i_flags & S_SWAPFILE)
+
+/* the read-only stuff doesn't really belong here, but any other place is
+   probably as bad and I don't want to create yet another include file. */
+
+#define BLKROSET   _IO(0x12,93)	/* set device read-only (0 = read-write) */
+#define BLKROGET   _IO(0x12,94)	/* get read-only status (0 = read_write) */
+#define BLKRRPART  _IO(0x12,95)	/* re-read partition table */
+#define BLKGETSIZE _IO(0x12,96)	/* return device size /512 (long *arg) */
+#define BLKFLSBUF  _IO(0x12,97)	/* flush buffer cache */
+#define BLKRASET   _IO(0x12,98)	/* set read ahead for block device */
+#define BLKRAGET   _IO(0x12,99)	/* get current read ahead setting */
+#define BLKFRASET  _IO(0x12,100)/* set filesystem (mm/filemap.c) read-ahead */
+#define BLKFRAGET  _IO(0x12,101)/* get filesystem (mm/filemap.c) read-ahead */
+#define BLKSECTSET _IO(0x12,102)/* set max sectors per request (ll_rw_blk.c) */
+#define BLKSECTGET _IO(0x12,103)/* get max sectors per request (ll_rw_blk.c) */
+#define BLKSSZGET  _IO(0x12,104)/* get block device sector size */
+#if 0
+#define BLKPG      _IO(0x12,105)/* See blkpg.h */
+
+/* Some people are morons.  Do not use sizeof! */
+
+#define BLKELVGET  _IOR(0x12,106,size_t)/* elevator get */
+#define BLKELVSET  _IOW(0x12,107,size_t)/* elevator set */
+/* This was here just to show that the number is taken -
+   probably all these _IO(0x12,*) ioctls should be moved to blkpg.h. */
+#endif
+/* A jump here: 108-111 have been used for various private purposes. */
+#define BLKBSZGET  _IOR(0x12,112,size_t)
+#define BLKBSZSET  _IOW(0x12,113,size_t)
+#define BLKGETSIZE64 _IOR(0x12,114,size_t)	/* return device size in bytes (u64 *arg) */
+
+#define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
+#define FIBMAP	   _IO(0x00,1)	/* bmap access */
+#define FIGETBSZ   _IO(0x00,2)	/* get the block size used for bmap */
+#endif /* _LINUX_FS_USER_H */

-- 
Tom Rini
http://gate.crashing.org/~trini/
