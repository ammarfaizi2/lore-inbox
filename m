Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262576AbSJEUfK>; Sat, 5 Oct 2002 16:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbSJEUfK>; Sat, 5 Oct 2002 16:35:10 -0400
Received: from zero.aec.at ([193.170.194.10]:28682 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262576AbSJEUe6>;
	Sat, 5 Oct 2002 16:34:58 -0400
Date: Sat, 5 Oct 2002 22:40:13 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] struct timespec for stat - core changes 1/3
Message-ID: <20021005204013.GA15990@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These are the core changes to implement struct timespec.

Patches to convert all the file systems and drivers are comming in separate mail.

Linux currently uses second resolution (time_t) for st_[cam]time in stat(2).
This is a problem for highly parallel make -j, which cannot detect cases
when a make rule runs for less than a second. GNU make supports finer
grained timestamps for this on other OS, but Linux doesn't support it 
so far. This patch changes that. We also have several filesystems
in tree now that support better than second resolution for [cam]time in
their on disk inode (XFS,JFS,NFSv3 and VFAT). 

This patch extends the VFS and stat(2) to add nsec timestamps. 

Why nsecs? First to be compatible with Solaris and then when you add a new
32bit field then there is no reason to stop at msec. It just uses 
a POSIX struct timespec. This matches what the filesystems (NFSv3,JFS,XFS)
do. 

The real resolution is a jiffie current because it just uses xtime
instead of calling gettimeofday. In 2.5 that is 1ms, which should 
be hopefully good enough. If not we can change it later to use do_gettimeofday.
do-gettimeofday unfortunately takes a readlock currently on most architectures,
so before doing it it would be a good idea to fix at least i386 to use
lockless gettimeofday (implementations of that exist already). But xtime
should be good enough for now. 

I chose to reuse the "reserved for year 2036" fields in stat64 for nsec, because
y2036 will need many other system call and glibc changes anyways
(e.g. new time, new gettimeofday, glibc support) so adding a new stat64
by then won't be a big deal. The newer architectures have enough 

The current kernels fill the fields now reused for nsec always with 0,
so there is perfect compatibility.

On stat64 these fields are always there because everybody uses the glibc
layout. With stat on 64bit architectures it is unfortunately mixed.
The newer 64bit architectures use the stat64 layout. The older ones
unfortunately didn't reserve fields for this (this is mainly alpha) 
I think. For now alpha has no way to get at the nsec values. Fixing 
it probably requires a new stat64 call for alpha.

I had to add a preprocessor symbol for this case.

I fixed all the architectures for it.

The old utimes system call already supported timeval, so it works fine 
(that is ms instead of ns resolution, but should be good enough for now) 

I changed the inode and iattr fields to struct timespec.  and fixed all the
file systems and other code that accessed it. The rounding in general
is a bit crude from seconds - it should round, but they are currently
just truncated.

I didn't fix Intermezzo completely because it didn't compile at all.

This patch could in theory affect benchmarks a bit. Andrew Morton previously
did an optimization to put inodes only once a second onto the dirty list
when their [mca]time change. With this patch they will be put on the dirty
list each jiffie (1ms), so in the worst case 1000 times as often.  The
cost in this is mainly in taken the locks and putting the inode onto
the dirty list.  On many FS which do not have better than a second 
resolution this makes no sense, because they only change the value once a 
second anyways. If this should be a problem a new update_time file/inode
operation may need to be added. I didn't do this for now.

Patch for 2.5.40. Please apply.

-Andi

 fs/attr.c                  |    7 +++----
 fs/bad_inode.c             |    2 +-
 fs/binfmt_misc.c           |    2 +-
 fs/libfs.c                 |    2 +-
 fs/locks.c                 |    7 ++++---
 fs/open.c                  |   12 ++++++++----
 fs/pipe.c                  |    5 ++---
 fs/stat.c                  |   28 ++++++++++++++++++----------
 include/asm-arm/stat.h     |   14 ++++++++------
 include/asm-cris/stat.h    |   14 ++++++++------
 include/asm-i386/stat.h    |   12 ++++++------
 include/asm-ia64/stat.h    |    8 +++++---
 include/asm-m68k/stat.h    |    6 +++---
 include/asm-mips/stat.h    |    6 +++---
 include/asm-mips64/stat.h  |    8 +++++---
 include/asm-parisc/stat.h  |    8 +++++---
 include/asm-ppc/stat.h     |   14 ++++++++------
 include/asm-ppc64/stat.h   |   14 ++++++++------
 include/asm-s390/stat.h    |   14 ++++++++------
 include/asm-s390x/stat.h   |    8 +++++---
 include/asm-sh/stat.h      |   14 ++++++++------
 include/asm-sparc/stat.h   |   14 ++++++++------
 include/asm-sparc64/stat.h |    6 +++---
 include/asm-x86_64/stat.h  |    8 +++++---
 include/linux/fs.h         |   16 +++++++++-------
 include/linux/nfs_fs.h     |    8 ++++++++
 include/linux/nfsd/nfsfh.h |   10 +++++-----
 include/linux/stat.h       |    7 ++++---
 include/linux/time.h       |    4 ++++
 mm/filemap.c               |    7 +------
 mm/shmem.c                 |   18 +++++++++---------
 31 files changed, 174 insertions, 129 deletions

diff -burp -X ../KDIFX linux/fs/attr.c linux-2.5.40-work/fs/attr.c
--- linux/fs/attr.c	2002-08-10 11:22:34.000000000 +0200
+++ linux-2.5.40-work/fs/attr.c	2002-10-05 18:46:14.000000000 +0200
@@ -122,17 +122,16 @@ int notify_change(struct dentry * dentry
 	struct inode *inode = dentry->d_inode;
 	mode_t mode = inode->i_mode;
 	int error;
-	time_t now = CURRENT_TIME;
 	unsigned int ia_valid = attr->ia_valid;
 
 	if (!inode)
 		BUG();
 
-	attr->ia_ctime = now;
+	attr->ia_ctime = xtime;
 	if (!(ia_valid & ATTR_ATIME_SET))
-		attr->ia_atime = now;
+		attr->ia_atime = xtime;
 	if (!(ia_valid & ATTR_MTIME_SET))
-		attr->ia_mtime = now;
+		attr->ia_mtime = xtime;
 	if (ia_valid & ATTR_KILL_SUID) {
 		if (mode & S_ISUID) {
 			if (!(ia_valid & ATTR_MODE)) {
diff -burp -X ../KDIFX linux/fs/bad_inode.c linux-2.5.40-work/fs/bad_inode.c
--- linux/fs/bad_inode.c	2002-09-21 09:02:58.000000000 +0200
+++ linux-2.5.40-work/fs/bad_inode.c	2002-10-05 18:46:14.000000000 +0200
@@ -85,7 +85,7 @@ struct inode_operations bad_inode_ops =
 void make_bad_inode(struct inode * inode) 
 {
 	inode->i_mode = S_IFREG;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = xtime;
 	inode->i_op = &bad_inode_ops;	
 	inode->i_fop = &bad_file_ops;	
 }
diff -burp -X ../KDIFX linux/fs/binfmt_misc.c linux-2.5.40-work/fs/binfmt_misc.c
--- linux/fs/binfmt_misc.c	2002-09-21 09:02:58.000000000 +0200
+++ linux-2.5.40-work/fs/binfmt_misc.c	2002-10-05 18:46:14.000000000 +0200
@@ -383,7 +383,7 @@ static struct inode *bm_get_inode(struct
 		inode->i_gid = 0;
 		inode->i_blksize = PAGE_CACHE_SIZE;
 		inode->i_blocks = 0;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = xtime;
 	}
 	return inode;
 }
diff -burp -X ../KDIFX linux/fs/libfs.c linux-2.5.40-work/fs/libfs.c
--- linux/fs/libfs.c	2002-09-21 09:02:58.000000000 +0200
+++ linux-2.5.40-work/fs/libfs.c	2002-10-05 18:46:14.000000000 +0200
@@ -190,7 +190,7 @@ get_sb_pseudo(struct file_system_type *f
 		goto Enomem;
 	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
 	root->i_uid = root->i_gid = 0;
-	root->i_atime = root->i_mtime = root->i_ctime = CURRENT_TIME;
+	root->i_atime = root->i_mtime = root->i_ctime = xtime;
 	dentry = d_alloc(NULL, &d_name);
 	if (!dentry) {
 		iput(root);
diff -burp -X ../KDIFX linux/fs/locks.c linux-2.5.40-work/fs/locks.c
--- linux/fs/locks.c	2002-09-29 16:54:34.000000000 +0200
+++ linux-2.5.40-work/fs/locks.c	2002-10-05 18:46:14.000000000 +0200
@@ -1097,12 +1097,13 @@ out:
  * exclusive leases.  The justification is that if someone has an
  * exclusive lease, then they could be modifiying it.
  */
-time_t lease_get_mtime(struct inode *inode)
+void lease_get_mtime(struct inode *inode, struct timespec *time)
 {
 	struct file_lock *flock = inode->i_flock;
 	if (flock && IS_LEASE(flock) && (flock->fl_type & F_WRLCK))
-		return CURRENT_TIME;
-	return inode->i_mtime;
+		*time = xtime;
+	else
+		*time = inode->i_mtime;
 }
 
 /**
diff -burp -X ../KDIFX linux/fs/open.c linux-2.5.40-work/fs/open.c
--- linux/fs/open.c	2002-08-10 11:22:34.000000000 +0200
+++ linux-2.5.40-work/fs/open.c	2002-10-05 18:46:14.000000000 +0200
@@ -251,9 +251,11 @@ asmlinkage long sys_utime(char * filenam
 	/* Don't worry, the checks are done in inode_change_ok() */
 	newattrs.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_ATIME;
 	if (times) {
-		error = get_user(newattrs.ia_atime, &times->actime);
+		error = get_user(newattrs.ia_atime.tv_sec, &times->actime);
+		newattrs.ia_atime.tv_nsec = 0;
 		if (!error) 
-			error = get_user(newattrs.ia_mtime, &times->modtime);
+			error = get_user(newattrs.ia_mtime.tv_sec, &times->modtime);
+		newattrs.ia_mtime.tv_nsec = 0;
 		if (error)
 			goto dput_and_out;
 
@@ -302,8 +304,10 @@ asmlinkage long sys_utimes(char * filena
 		error = -EFAULT;
 		if (copy_from_user(&times, utimes, sizeof(times)))
 			goto dput_and_out;
-		newattrs.ia_atime = times[0].tv_sec;
-		newattrs.ia_mtime = times[1].tv_sec;
+		newattrs.ia_atime.tv_sec = times[0].tv_sec;
+		newattrs.ia_atime.tv_nsec = times[0].tv_usec * 1000;
+		newattrs.ia_mtime.tv_sec = times[1].tv_sec;
+		newattrs.ia_mtime.tv_nsec = times[1].tv_usec * 1000;
 		newattrs.ia_valid |= ATTR_ATIME_SET | ATTR_MTIME_SET;
 	} else {
 		if (current->fsuid != inode->i_uid &&
diff -burp -X ../KDIFX linux/fs/pipe.c linux-2.5.40-work/fs/pipe.c
--- linux/fs/pipe.c	2002-09-21 09:02:58.000000000 +0200
+++ linux-2.5.40-work/fs/pipe.c	2002-10-05 18:46:14.000000000 +0200
@@ -236,8 +236,7 @@ pipe_write(struct file *filp, const char
 	wake_up_interruptible(PIPE_WAIT(*inode));
 	kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
 
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-	mark_inode_dirty(inode);
+	inode_update_time(inode, 1);
 
 out:
 	up(PIPE_SEM(*inode));
@@ -566,7 +565,7 @@ static struct inode * get_pipe_inode(voi
 	inode->i_mode = S_IFIFO | S_IRUSR | S_IWUSR;
 	inode->i_uid = current->fsuid;
 	inode->i_gid = current->fsgid;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = xtime;
 	inode->i_blksize = PAGE_SIZE;
 	return inode;
 
diff -burp -X ../KDIFX linux/fs/stat.c linux-2.5.40-work/fs/stat.c
--- linux/fs/stat.c	2002-08-10 11:22:34.000000000 +0200
+++ linux-2.5.40-work/fs/stat.c	2002-10-05 18:46:14.000000000 +0200
@@ -129,9 +129,9 @@ static int cp_old_stat(struct kstat *sta
 		return -EOVERFLOW;
 #endif	
 	tmp.st_size = stat->size;
-	tmp.st_atime = stat->atime;
-	tmp.st_mtime = stat->mtime;
-	tmp.st_ctime = stat->ctime;
+	tmp.st_atime = stat->atime.tv_sec;
+	tmp.st_mtime = stat->mtime.tv_sec;
+	tmp.st_ctime = stat->ctime.tv_sec;
 	return copy_to_user(statbuf,&tmp,sizeof(tmp)) ? -EFAULT : 0;
 }
 
@@ -185,9 +185,14 @@ static int cp_new_stat(struct kstat *sta
 		return -EOVERFLOW;
 #endif	
 	tmp.st_size = stat->size;
-	tmp.st_atime = stat->atime;
-	tmp.st_mtime = stat->mtime;
-	tmp.st_ctime = stat->ctime;
+	tmp.st_atime = stat->atime.tv_sec;
+	tmp.st_mtime = stat->mtime.tv_sec;
+	tmp.st_ctime = stat->ctime.tv_sec;
+#ifdef STAT_HAVE_NSEC
+	tmp.st_atime_nsec = stat->atime.tv_nsec;
+	tmp.st_mtime_nsec = stat->mtime.tv_nsec;
+	tmp.st_ctime_nsec = stat->ctime.tv_nsec;
+#endif
 	tmp.st_blocks = stat->blocks;
 	tmp.st_blksize = stat->blksize;
 	return copy_to_user(statbuf,&tmp,sizeof(tmp)) ? -EFAULT : 0;
@@ -257,7 +262,7 @@ static long cp_new_stat64(struct kstat *
 {
 	struct stat64 tmp;
 
-	memset(&tmp, 0, sizeof(tmp));
+	memset(&tmp, 0, sizeof(struct stat64));
 	tmp.st_dev = stat->dev;
 	tmp.st_ino = stat->ino;
 #ifdef STAT64_HAS_BROKEN_ST_INO
@@ -268,9 +273,12 @@ static long cp_new_stat64(struct kstat *
 	tmp.st_uid = stat->uid;
 	tmp.st_gid = stat->gid;
 	tmp.st_rdev = stat->rdev;
-	tmp.st_atime = stat->atime;
-	tmp.st_mtime = stat->mtime;
-	tmp.st_ctime = stat->ctime;
+	tmp.st_atime = stat->atime.tv_sec;
+	tmp.st_atime_nsec = stat->atime.tv_nsec;
+	tmp.st_mtime = stat->mtime.tv_sec;
+	tmp.st_mtime_nsec = stat->mtime.tv_nsec;
+	tmp.st_ctime = stat->ctime.tv_sec;
+	tmp.st_ctime_nsec = stat->ctime.tv_nsec;
 	tmp.st_size = stat->size;
 	tmp.st_blocks = stat->blocks;
 	tmp.st_blksize = stat->blksize;
diff -burp -X ../KDIFX linux/include/asm-arm/stat.h linux-2.5.40-work/include/asm-arm/stat.h
--- linux/include/asm-arm/stat.h	2002-10-05 18:42:44.000000000 +0200
+++ linux-2.5.40-work/include/asm-arm/stat.h	2002-10-05 18:46:15.000000000 +0200
@@ -15,6 +15,8 @@ struct __old_kernel_stat {
 	unsigned long  st_ctime;
 };
 
+#define STAT_HAVE_NSEC 
+
 struct stat {
 	unsigned short st_dev;
 	unsigned short __pad1;
@@ -29,11 +31,11 @@ struct stat {
 	unsigned long  st_blksize;
 	unsigned long  st_blocks;
 	unsigned long  st_atime;
-	unsigned long  __unused1;
+	unsigned long  st_atime_nsec;
 	unsigned long  st_mtime;
-	unsigned long  __unused2;
+	unsigned long  st_mtime_nsec;
 	unsigned long  st_ctime;
-	unsigned long  __unused3;
+	unsigned long  st_ctime_nsec;
 	unsigned long  __unused4;
 	unsigned long  __unused5;
 };
@@ -82,13 +84,13 @@ struct stat64 {
 #endif
 
 	unsigned long	st_atime;
-	unsigned long	__pad5;
+	unsigned long	st_atime_nsec;
 
 	unsigned long	st_mtime;
-	unsigned long	__pad6;
+	unsigned long	st_mtime_nsec;
 
 	unsigned long	st_ctime;
-	unsigned long	__pad7;		/* will be high 32 bits of ctime someday */
+	unsigned long	st_ctime_nsec;
 
 	unsigned long long	st_ino;
 };
diff -burp -X ../KDIFX linux/include/asm-cris/stat.h linux-2.5.40-work/include/asm-cris/stat.h
--- linux/include/asm-cris/stat.h	2002-09-25 00:59:28.000000000 +0200
+++ linux-2.5.40-work/include/asm-cris/stat.h	2002-10-05 18:46:15.000000000 +0200
@@ -18,6 +18,8 @@ struct __old_kernel_stat {
 	unsigned long  st_ctime;
 };
 
+#define STAT_HAVE_NSEC 1
+
 struct stat {
 	unsigned short st_dev;
 	unsigned short __pad1;
@@ -32,11 +34,11 @@ struct stat {
 	unsigned long  st_blksize;
 	unsigned long  st_blocks;
 	unsigned long  st_atime;
-	unsigned long  __unused1;
+	unsigned long  st_atime_nsec;
 	unsigned long  st_mtime;
-	unsigned long  __unused2;
+	unsigned long  st_mtime_nsec;
 	unsigned long  st_ctime;
-	unsigned long  __unused3;
+	unsigned long  st_ctime_nsec;
 	unsigned long  __unused4;
 	unsigned long  __unused5;
 };
@@ -67,13 +69,13 @@ struct stat64 {
 	unsigned long	__pad4;		/* future possible st_blocks high bits */
 
 	unsigned long	st_atime;
-	unsigned long	__pad5;
+	unsigned long	st_atime_nsec;
 
 	unsigned long	st_mtime;
-	unsigned long	__pad6;
+	unsigned long	st_mtime_nsec;
 
 	unsigned long	st_ctime;
-	unsigned long	__pad7;		/* will be high 32 bits of ctime someday */
+	unsigned long	st_ctime_nsec;	/* will be high 32 bits of ctime someday */
 
 	unsigned long long	st_ino;
 };
diff -burp -X ../KDIFX linux/include/asm-i386/stat.h linux-2.5.40-work/include/asm-i386/stat.h
--- linux/include/asm-i386/stat.h	2002-06-09 07:27:00.000000000 +0200
+++ linux-2.5.40-work/include/asm-i386/stat.h	2002-10-05 18:46:15.000000000 +0200
@@ -29,11 +29,11 @@ struct stat {
 	unsigned long  st_blksize;
 	unsigned long  st_blocks;
 	unsigned long  st_atime;
-	unsigned long  __unused1;
+	unsigned long  st_atime_nsec;
 	unsigned long  st_mtime;
-	unsigned long  __unused2;
+	unsigned long  st_mtime_nsec;
 	unsigned long  st_ctime;
-	unsigned long  __unused3;
+	unsigned long  st_ctime_nsec;
 	unsigned long  __unused4;
 	unsigned long  __unused5;
 };
@@ -64,13 +64,13 @@ struct stat64 {
 	unsigned long	__pad4;		/* future possible st_blocks high bits */
 
 	unsigned long	st_atime;
-	unsigned long	__pad5;
+	unsigned long	st_atime_nsec;
 
 	unsigned long	st_mtime;
-	unsigned long	__pad6;
+	unsigned int	st_mtime_nsec;
 
 	unsigned long	st_ctime;
-	unsigned long	__pad7;		/* will be high 32 bits of ctime someday */
+	unsigned long	st_ctime_nsec;
 
 	unsigned long long	st_ino;
 };
diff -burp -X ../KDIFX linux/include/asm-ia64/stat.h linux-2.5.40-work/include/asm-ia64/stat.h
--- linux/include/asm-ia64/stat.h	2002-09-25 00:59:27.000000000 +0200
+++ linux-2.5.40-work/include/asm-ia64/stat.h	2002-10-05 18:46:15.000000000 +0200
@@ -17,16 +17,18 @@ struct stat {
 	unsigned long	st_rdev;
 	unsigned long	st_size;
 	unsigned long	st_atime;
-	unsigned long	__reserved0;	/* reserved for atime.nanoseconds */
+	unsigned long	st_atime_nsec;
 	unsigned long	st_mtime;
-	unsigned long	__reserved1;	/* reserved for mtime.nanoseconds */
+	unsigned long	st_mtime_nsec;
 	unsigned long	st_ctime;
-	unsigned long	__reserved2;	/* reserved for ctime.nanoseconds */
+	unsigned long	st_ctime_nsec;
 	unsigned long	st_blksize;
 	long		st_blocks;
 	unsigned long	__unused[3];
 };
 
+#define STAT_HAVE_NSEC 1
+
 struct ia64_oldstat {
 	unsigned int	st_dev;
 	unsigned int	st_ino;
diff -burp -X ../KDIFX linux/include/asm-m68k/stat.h linux-2.5.40-work/include/asm-m68k/stat.h
--- linux/include/asm-m68k/stat.h	2002-09-25 00:59:27.000000000 +0200
+++ linux-2.5.40-work/include/asm-m68k/stat.h	2002-10-05 18:46:15.000000000 +0200
@@ -66,13 +66,13 @@ struct stat64 {
 	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
 
 	unsigned long	st_atime;
-	unsigned long	__pad5;
+	unsigned long	st_atime_nsec;
 
 	unsigned long	st_mtime;
-	unsigned long	__pad6;
+	unsigned long	st_mtime_nsec;
 
 	unsigned long	st_ctime;
-	unsigned long	__pad7;		/* will be high 32 bits of ctime someday */
+	unsigned long	st_ctime_nsec;
 
 	unsigned long long	st_ino;
 };
diff -burp -X ../KDIFX linux/include/asm-mips/stat.h linux-2.5.40-work/include/asm-mips/stat.h
--- linux/include/asm-mips/stat.h	2002-09-25 00:59:27.000000000 +0200
+++ linux-2.5.40-work/include/asm-mips/stat.h	2002-10-05 18:46:15.000000000 +0200
@@ -37,11 +37,11 @@ struct stat {
 	 * but we don't have it under Linux.
 	 */
 	time_t		st_atime;
-	long		reserved0;
+	long		st_atime_nsec;
 	time_t		st_mtime;
-	long		reserved1;
+	long		st_mtime_nsec;
 	time_t		st_ctime;
-	long		reserved2;
+	long		st_ctime_nsec;
 	long		st_blksize;
 	long		st_blocks;
 	long		st_pad4[14];
diff -burp -X ../KDIFX linux/include/asm-mips64/stat.h linux-2.5.40-work/include/asm-mips64/stat.h
--- linux/include/asm-mips64/stat.h	2002-09-25 00:59:28.000000000 +0200
+++ linux-2.5.40-work/include/asm-mips64/stat.h	2002-10-05 18:46:15.000000000 +0200
@@ -74,13 +74,13 @@ struct stat {
 	 * but we don't have it under Linux.
 	 */
 	unsigned int	st_atime;
-	unsigned int	reserved0;	/* Reserved for st_atime expansion  */
+	unsigned int	st_atime_nsec;
 
 	unsigned int	st_mtime;
-	unsigned int	reserved1;	/* Reserved for st_mtime expansion  */
+	unsigned int	st_mtime_nsec;
 
 	unsigned int	st_ctime;
-	unsigned int	reserved2;	/* Reserved for st_ctime expansion  */
+	unsigned int	st_ctime_nsec;
 
 	unsigned int	st_blksize;
 	unsigned int	st_pad2;
@@ -88,4 +88,6 @@ struct stat {
 	unsigned long	st_blocks;
 };
 
+#define STAT_HAVE_NSEC 1
+
 #endif /* _ASM_STAT_H */
diff -burp -X ../KDIFX linux/include/asm-parisc/stat.h linux-2.5.40-work/include/asm-parisc/stat.h
--- linux/include/asm-parisc/stat.h	2002-09-25 00:59:27.000000000 +0200
+++ linux-2.5.40-work/include/asm-parisc/stat.h	2002-10-05 18:46:15.000000000 +0200
@@ -13,11 +13,11 @@ struct stat {
 	dev_t		st_rdev;
 	off_t		st_size;
 	time_t		st_atime;
-	unsigned int	st_spare1;
+	unsigned int	st_atime_nsec;
 	time_t		st_mtime;
-	unsigned int	st_spare2;
+	unsigned int	st_mtime_nsec;
 	time_t		st_ctime;
-	unsigned int	st_spare3;
+	unsigned int	st_ctime_nsec;
 	int		st_blksize;
 	int		st_blocks;
 	unsigned int	__unused1;	/* ACL stuff */
@@ -34,6 +34,8 @@ struct stat {
 	unsigned int	st_spare4[3];
 };
 
+#define STAT_HAVE_NSEC
+
 typedef __kernel_off64_t	off64_t;
 
 struct hpux_stat64 {
diff -burp -X ../KDIFX linux/include/asm-ppc/stat.h linux-2.5.40-work/include/asm-ppc/stat.h
--- linux/include/asm-ppc/stat.h	2002-09-25 00:59:27.000000000 +0200
+++ linux-2.5.40-work/include/asm-ppc/stat.h	2002-10-05 18:46:15.000000000 +0200
@@ -19,6 +19,8 @@ struct __old_kernel_stat {
 	unsigned long  st_ctime;
 };
 
+#define STAT_HAVE_NSEC 1
+
 struct stat {
 	dev_t		st_dev;
 	ino_t		st_ino;
@@ -31,11 +33,11 @@ struct stat {
 	unsigned long  	st_blksize;
 	unsigned long  	st_blocks;
 	unsigned long  	st_atime;
-	unsigned long  	__unused1;
+	unsigned long  	st_atime_nsec;
 	unsigned long  	st_mtime;
-	unsigned long  	__unused2;
+	unsigned long  	st_mtime_nsec;
 	unsigned long  	st_ctime;
-	unsigned long  	__unused3;
+	unsigned long  	st_ctime_nsec;
 	unsigned long  	__unused4;
 	unsigned long  	__unused5;
 };
@@ -56,11 +58,11 @@ struct stat64 {
 
 	long long st_blocks;		/* Number 512-byte blocks allocated. */
 	long st_atime;			/* Time of last access.  */
-	unsigned long int __unused1;
+	unsigned long st_atime_nsec;
 	long st_mtime;			/* Time of last modification.  */
-	unsigned long int __unused2;
+	unsigned long int st_mtime_nsec;
 	long st_ctime;			/* Time of last status change.  */
-	unsigned long int __unused3;
+	unsigned long int st_ctime_nsec;
 	unsigned long int __unused4;
 	unsigned long int __unused5;
 };
diff -burp -X ../KDIFX linux/include/asm-ppc64/stat.h linux-2.5.40-work/include/asm-ppc64/stat.h
--- linux/include/asm-ppc64/stat.h	2002-09-25 00:59:27.000000000 +0200
+++ linux-2.5.40-work/include/asm-ppc64/stat.h	2002-10-05 18:46:15.000000000 +0200
@@ -36,15 +36,17 @@ struct stat {
 	unsigned long  	st_blksize;
 	unsigned long  	st_blocks;
 	unsigned long  	st_atime;
-	unsigned long  	__unused1;
+	unsigned long  	st_atime_nsec;
 	unsigned long  	st_mtime;
-	unsigned long  	__unused2;
+	unsigned long  	st_mtime_nsec;
 	unsigned long  	st_ctime;
-	unsigned long  	__unused3;
+	unsigned long  	st_ctime_nsec;
 	unsigned long  	__unused4;
 	unsigned long  	__unused5;
 };
 
+#define STAT_HAVE_NSEC 1
+
 /* This matches struct stat64 in glibc2.1. */
 struct stat64 {
 	unsigned long st_dev; 		/* Device.  */
@@ -60,11 +62,11 @@ struct stat64 {
 
 	long st_blocks;			/* Number 512-byte blocks allocated. */
 	int   st_atime;			/* Time of last access.  */
-	unsigned int  __unused1;
+	int   st_atime_nsec;
 	int   st_mtime;			/* Time of last modification.  */
-	unsigned int  __unused2;
+	int   st_mtime_nsec;
 	int   st_ctime;			/* Time of last status change.  */
-	unsigned int   __unused3;
+	int   st_ctime_nsec;
 	unsigned int   __unused4;
 	unsigned int   __unused5;
 };
diff -burp -X ../KDIFX linux/include/asm-s390/stat.h linux-2.5.40-work/include/asm-s390/stat.h
--- linux/include/asm-s390/stat.h	2002-09-25 00:59:27.000000000 +0200
+++ linux-2.5.40-work/include/asm-s390/stat.h	2002-10-05 18:46:15.000000000 +0200
@@ -37,15 +37,17 @@ struct stat {
         unsigned long  st_blksize;
         unsigned long  st_blocks;
         unsigned long  st_atime;
-        unsigned long  __unused1;
+        unsigned long  st_atime_nsec;
         unsigned long  st_mtime;
-        unsigned long  __unused2;
+        unsigned long  st_mtime_nsec;
         unsigned long  st_ctime;
-        unsigned long  __unused3;
+        unsigned long  st_ctime_nsec;
         unsigned long  __unused4;
         unsigned long  __unused5;
 };
 
+#define STAT_HAVE_NSEC 1
+
 /* This matches struct stat64 in glibc2.1, hence the absolutely
  * insane amounts of padding around dev_t's.
  */
@@ -68,11 +70,11 @@ struct stat64 {
         unsigned long   __pad5;     /* future possible st_blocks high bits */
         unsigned long   st_blocks;  /* Number 512-byte blocks allocated. */
         unsigned long   st_atime;
-        unsigned long   __pad6;
+        unsigned long   st_atime_nsec;
         unsigned long   st_mtime;
-        unsigned long   __pad7;
+        unsigned long   st_mtime_nsec;
         unsigned long   st_ctime;
-        unsigned long   __pad8;     /* will be high 32 bits of ctime someday */
+        unsigned long   st_ctime_nsec;  /* will be high 32 bits of ctime someday */
         unsigned long long      st_ino;
 };
 
diff -burp -X ../KDIFX linux/include/asm-s390x/stat.h linux-2.5.40-work/include/asm-s390x/stat.h
--- linux/include/asm-s390x/stat.h	2002-09-25 00:59:27.000000000 +0200
+++ linux-2.5.40-work/include/asm-s390x/stat.h	2002-10-05 18:46:15.000000000 +0200
@@ -20,14 +20,16 @@ struct stat {
         unsigned long  st_rdev;
         unsigned long  st_size;
         unsigned long  st_atime;
-	unsigned long	__reserved0;	/* reserved for atime.nanoseconds */
+	unsigned long  st_atime_nsec;
         unsigned long  st_mtime;
-	unsigned long	__reserved1;	/* reserved for mtime.nanoseconds */
+	unsigned long  st_mtime_nsec;
         unsigned long  st_ctime;
-	unsigned long	__reserved2;	/* reserved for ctime.nanoseconds */
+	unsigned long  st_ctime_nsec;
         unsigned long  st_blksize;
         long           st_blocks;
         unsigned long  __unused[3];
 };
 
+#define STAT_HAVE_NSEC 1
+
 #endif
diff -burp -X ../KDIFX linux/include/asm-sh/stat.h linux-2.5.40-work/include/asm-sh/stat.h
--- linux/include/asm-sh/stat.h	2002-09-25 00:59:28.000000000 +0200
+++ linux-2.5.40-work/include/asm-sh/stat.h	2002-10-05 18:46:15.000000000 +0200
@@ -29,15 +29,17 @@ struct stat {
 	unsigned long  st_blksize;
 	unsigned long  st_blocks;
 	unsigned long  st_atime;
-	unsigned long  __unused1;
+	unsigned long  st_atime_nsec;
 	unsigned long  st_mtime;
-	unsigned long  __unused2;
+	unsigned long  st_mtime_nsec;
 	unsigned long  st_ctime;
-	unsigned long  __unused3;
+	unsigned long  st_ctime_nsec;
 	unsigned long  __unused4;
 	unsigned long  __unused5;
 };
 
+#define STAT_HAVE_NSEC 1
+
 /* This matches struct stat64 in glibc2.1, hence the absolutely
  * insane amounts of padding around dev_t's.
  */
@@ -81,13 +83,13 @@ struct stat64 {
 #endif
 
 	unsigned long	st_atime;
-	unsigned long	__pad5;
+	unsigned long	st_atime_nsec;
 
 	unsigned long	st_mtime;
-	unsigned long	__pad6;
+	unsigned long	st_mtime_nsec;
 
 	unsigned long	st_ctime;
-	unsigned long	__pad7;		/* will be high 32 bits of ctime someday */
+	unsigned long	st_ctime_nsec; 
 
 	unsigned long	__unused1;
 	unsigned long	__unused2;
diff -burp -X ../KDIFX linux/include/asm-sparc/stat.h linux-2.5.40-work/include/asm-sparc/stat.h
--- linux/include/asm-sparc/stat.h	2002-09-25 00:59:28.000000000 +0200
+++ linux-2.5.40-work/include/asm-sparc/stat.h	2002-10-05 18:46:15.000000000 +0200
@@ -28,16 +28,18 @@ struct stat {
 	unsigned short	st_rdev;
 	long		st_size;
 	long		st_atime;
-	unsigned long	__unused1;
+	unsigned long	st_atime_nsec;
 	long		st_mtime;
-	unsigned long	__unused2;
+	unsigned long	st_mtime_nsec;
 	long		st_ctime;
-	unsigned long	__unused3;
+	unsigned long	st_ctime_nsec;
 	long		st_blksize;
 	long		st_blocks;
 	unsigned long	__unused4[2];
 };
 
+#define STAT_HAVE_NSEC 1
+
 struct stat64 {
 	unsigned char	__pad0[6];
 	unsigned short	st_dev;
@@ -62,13 +64,13 @@ struct stat64 {
 	unsigned int	st_blocks;
 
 	unsigned int	st_atime;
-	unsigned int	__unused1;
+	unsigned int	st_atime_nsec;
 
 	unsigned int	st_mtime;
-	unsigned int	__unused2;
+	unsigned int	st_mtime_nsec;
 
 	unsigned int	st_ctime;
-	unsigned int	__unused3;
+	unsigned int	st_ctime_nsec;
 
 	unsigned int	__unused4;
 	unsigned int	__unused5;
diff -burp -X ../KDIFX linux/include/asm-sparc64/stat.h linux-2.5.40-work/include/asm-sparc64/stat.h
--- linux/include/asm-sparc64/stat.h	2002-09-25 00:59:27.000000000 +0200
+++ linux-2.5.40-work/include/asm-sparc64/stat.h	2002-10-05 18:46:15.000000000 +0200
@@ -69,13 +69,13 @@ struct stat64 {
 	unsigned int	st_blocks;
 
 	unsigned int	st_atime;
-	unsigned int	__unused1;
+	unsigned int	st_atime_nsec;
 
 	unsigned int	st_mtime;
-	unsigned int	__unused2;
+	unsigned int	st_mtime_nsec;
 
 	unsigned int	st_ctime;
-	unsigned int	__unused3;
+	unsigned int	st_ctime_nsec;
 
 	unsigned int	__unused4;
 	unsigned int	__unused5;
diff -burp -X ../KDIFX linux/include/asm-x86_64/stat.h linux-2.5.40-work/include/asm-x86_64/stat.h
--- linux/include/asm-x86_64/stat.h	2002-06-09 07:31:22.000000000 +0200
+++ linux-2.5.40-work/include/asm-x86_64/stat.h	2002-10-05 18:46:15.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _ASM_X86_64_STAT_H
 #define _ASM_X86_64_STAT_H
 
+#define STAT_HAVE_NSEC 1
+
 struct stat {
 	unsigned long	st_dev;
 	unsigned long	st_ino;
@@ -16,11 +18,11 @@ struct stat {
 	long		st_blocks;	/* Number 512-byte blocks allocated. */
 
 	unsigned long	st_atime;
-	unsigned long	__reserved0;	/* reserved for atime.nanoseconds */
+	unsigned long 	st_atime_nsec; 
 	unsigned long	st_mtime;
-	unsigned long	__reserved1;	/* reserved for atime.nanoseconds */
+	unsigned long	st_mtime_nsec;
 	unsigned long	st_ctime;
-	unsigned long	__reserved2;	/* reserved for atime.nanoseconds */
+	unsigned long   st_ctime_nsec;
   	long		__unused[3];
 };
 
diff -burp -X ../KDIFX linux/include/linux/fs.h linux-2.5.40-work/include/linux/fs.h
--- linux/include/linux/fs.h	2002-09-21 09:03:01.000000000 +0200
+++ linux-2.5.40-work/include/linux/fs.h	2002-10-05 18:46:15.000000000 +0200
@@ -253,9 +253,9 @@ struct iattr {
 	uid_t		ia_uid;
 	gid_t		ia_gid;
 	loff_t		ia_size;
-	time_t		ia_atime;
-	time_t		ia_mtime;
-	time_t		ia_ctime;
+	struct timespec	ia_atime;
+	struct timespec	ia_mtime;
+	struct timespec	ia_ctime;
 	unsigned int	ia_attr_flags;
 };
 
@@ -373,9 +373,9 @@ struct inode {
 	gid_t			i_gid;
 	kdev_t			i_rdev;
 	loff_t			i_size;
-	time_t			i_atime;
-	time_t			i_mtime;
-	time_t			i_ctime;
+	struct timespec		i_atime;
+	struct timespec		i_mtime;
+	struct timespec		i_ctime;
 	unsigned int		i_blkbits;
 	unsigned long		i_blksize;
 	unsigned long		i_blocks;
@@ -596,7 +596,7 @@ extern void posix_block_lock(struct file
 extern void posix_unblock_lock(struct file *, struct file_lock *);
 extern int posix_locks_deadlock(struct file_lock *, struct file_lock *);
 extern int __get_lease(struct inode *inode, unsigned int flags);
-extern time_t lease_get_mtime(struct inode *);
+extern void lease_get_mtime(struct inode *, struct timespec *time);
 extern int lock_may_read(struct inode *, loff_t start, unsigned long count);
 extern int lock_may_write(struct inode *, loff_t start, unsigned long count);
 
@@ -1307,6 +1307,8 @@ extern ssize_t block_write(struct file *
 extern int inode_change_ok(struct inode *, struct iattr *);
 extern int inode_setattr(struct inode *, struct iattr *);
 
+extern void inode_update_time(struct inode *inode, int ctime_too);
+
 static inline ino_t parent_ino(struct dentry *dentry)
 {
 	ino_t res;
diff -burp -X ../KDIFX linux/include/linux/nfs_fs.h linux-2.5.40-work/include/linux/nfs_fs.h
--- linux/include/linux/nfs_fs.h	2002-08-10 11:22:50.000000000 +0200
+++ linux-2.5.40-work/include/linux/nfs_fs.h	2002-10-05 18:46:15.000000000 +0200
@@ -426,6 +426,14 @@ nfs_time_to_secs(__u64 time)
 	return (time_t)(time >> 32);
 }
 
+
+static inline u32
+nfs_time_to_nsecs(__u64 time)
+{
+	return time & 0xffffffff;
+}
+
+
 /* NFS root */
 
 extern void * nfs_root_data(void);
diff -burp -X ../KDIFX linux/include/linux/nfsd/nfsfh.h linux-2.5.40-work/include/linux/nfsd/nfsfh.h
--- linux/include/linux/nfsd/nfsfh.h	2002-09-16 04:42:58.000000000 +0200
+++ linux-2.5.40-work/include/linux/nfsd/nfsfh.h	2002-10-05 18:46:15.000000000 +0200
@@ -270,8 +270,8 @@ fill_pre_wcc(struct svc_fh *fhp)
 
 	inode = fhp->fh_dentry->d_inode;
 	if (!fhp->fh_pre_saved) {
-		fhp->fh_pre_mtime = inode->i_mtime;
-			fhp->fh_pre_ctime = inode->i_ctime;
+		fhp->fh_pre_mtime = inode->i_mtime.tv_sec;
+		fhp->fh_pre_ctime = inode->i_ctime.tv_sec;
 			fhp->fh_pre_size  = inode->i_size;
 			fhp->fh_pre_saved = 1;
 	}
@@ -302,9 +302,9 @@ fill_post_wcc(struct svc_fh *fhp)
 		fhp->fh_post_blocks     = (inode->i_size+511) >> 9;
 	}
 	fhp->fh_post_rdev       = inode->i_rdev;
-	fhp->fh_post_atime      = inode->i_atime;
-	fhp->fh_post_mtime      = inode->i_mtime;
-	fhp->fh_post_ctime      = inode->i_ctime;
+	fhp->fh_post_atime      = inode->i_atime.tv_sec;
+	fhp->fh_post_mtime      = inode->i_mtime.tv_sec;
+	fhp->fh_post_ctime      = inode->i_ctime.tv_sec;
 	fhp->fh_post_saved      = 1;
 }
 #else
diff -burp -X ../KDIFX linux/include/linux/stat.h linux-2.5.40-work/include/linux/stat.h
--- linux/include/linux/stat.h	2002-06-09 07:28:50.000000000 +0200
+++ linux-2.5.40-work/include/linux/stat.h	2002-10-05 18:46:15.000000000 +0200
@@ -54,6 +54,7 @@
 #define S_IXUGO		(S_IXUSR|S_IXGRP|S_IXOTH)
 
 #include <linux/types.h>
+#include <linux/time.h>
 
 struct kstat {
 	unsigned long	ino;
@@ -64,9 +65,9 @@ struct kstat {
 	gid_t		gid;
 	dev_t		rdev;
 	loff_t		size;
-	time_t		atime;
-	time_t		mtime;
-	time_t		ctime;
+	struct timespec  atime;
+	struct timespec	mtime;
+	struct timespec	ctime;
 	unsigned long	blksize;
 	unsigned long	blocks;
 };
diff -burp -X ../KDIFX linux/include/linux/time.h linux-2.5.40-work/include/linux/time.h
--- linux/include/linux/time.h	2002-09-16 04:42:58.000000000 +0200
+++ linux-2.5.40-work/include/linux/time.h	2002-10-05 18:46:15.000000000 +0200
@@ -79,6 +79,10 @@ jiffies_to_timeval(unsigned long jiffies
 	value->tv_sec = jiffies / HZ;
 }
 
+static __inline__ int timespec_equal(struct timespec *a, struct timespec *b) 
+{ 
+	return (a->tv_sec == b->tv_sec) && (a->tv_nsec == b->tv_nsec);
+} 
 
 /* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
  * Assumes input in normal date format, i.e. 1980-12-31 23:59:59
diff -burp -X ../KDIFX linux/mm/filemap.c linux-2.5.40-work/mm/filemap.c
--- linux/mm/filemap.c	2002-09-29 16:54:35.000000000 +0200
+++ linux-2.5.40-work/mm/filemap.c	2002-10-05 19:20:25.000000000 +0200
@@ -1828,12 +1828,7 @@ generic_file_write_nolock(struct file *f
 		goto out;
 
 	remove_suid(file->f_dentry);
-	time_now = CURRENT_TIME;
-	if (inode->i_ctime != time_now || inode->i_mtime != time_now) {
-		inode->i_ctime = time_now;
-		inode->i_mtime = time_now;
-		mark_inode_dirty_sync(inode);
-	}
+	inode_update_time(inode, 1);
 
 	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
 	if (unlikely(file->f_flags & O_DIRECT)) {
diff -burp -X ../KDIFX linux/mm/shmem.c linux-2.5.40-work/mm/shmem.c
--- linux/mm/shmem.c	2002-09-21 09:03:01.000000000 +0200
+++ linux-2.5.40-work/mm/shmem.c	2002-10-05 18:46:15.000000000 +0200
@@ -331,7 +331,7 @@ static void shmem_truncate (struct inode
 	struct shmem_inode_info * info = SHMEM_I(inode);
 
 	down(&info->sem);
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	inode->i_ctime = inode->i_mtime = xtime;
 	spin_lock (&info->lock);
 	index = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	partial = inode->i_size & ~PAGE_CACHE_MASK;
@@ -795,7 +795,7 @@ struct inode *shmem_get_inode(struct sup
 		inode->i_rdev = NODEV;
 		inode->i_mapping->a_ops = &shmem_aops;
 		inode->i_mapping->backing_dev_info = &shmem_backing_dev_info;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = xtime;
 		info = SHMEM_I(inode);
 		spin_lock_init (&info->lock);
 		sema_init (&info->sem, 1);
@@ -922,7 +922,7 @@ shmem_file_write(struct file *file,const
 	status	= 0;
 	if (count) {
 		remove_suid(file->f_dentry);
-		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+		inode->i_ctime = inode->i_mtime = xtime;
 	}
 
 	while (count) {
@@ -1109,7 +1109,7 @@ static int shmem_mknod(struct inode *dir
 	int error = -ENOSPC;
 
 	if (inode) {
-		dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+		dir->i_ctime = dir->i_mtime = xtime;
 		d_instantiate(dentry, inode);
 		dget(dentry); /* Extra count - pin the dentry in core */
 		error = 0;
@@ -1139,7 +1139,7 @@ static int shmem_link(struct dentry *old
 {
 	struct inode *inode = old_dentry->d_inode;
 
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = xtime;
 	inode->i_nlink++;
 	atomic_inc(&inode->i_count);	/* New dentry reference */
 	dget(dentry);		/* Extra pinning count for the created dentry */
@@ -1183,7 +1183,7 @@ static int shmem_empty(struct dentry *de
 static int shmem_unlink(struct inode * dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = xtime;
 	inode->i_nlink--;
 	dput(dentry);	/* Undo the count from "create" - this does all the work */
 	return 0;
@@ -1213,7 +1213,7 @@ static int shmem_rename(struct inode * o
 
 	inode = new_dentry->d_inode;
 	if (inode) {
-		inode->i_ctime = CURRENT_TIME;
+		inode->i_ctime = xtime;
 		inode->i_nlink--;
 		dput(new_dentry);
 	}
@@ -1223,7 +1223,7 @@ static int shmem_rename(struct inode * o
 		new_dir->i_nlink++;
 	}
 
-	inode->i_ctime = old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
+	inode->i_ctime = old_dir->i_ctime = old_dir->i_mtime = xtime;
 	return 0;
 }
 
@@ -1274,7 +1274,7 @@ static int shmem_symlink(struct inode * 
 		page_cache_release(page);
 		up(&info->sem);
 	}
-	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	dir->i_ctime = dir->i_mtime = xtime;
 	d_instantiate(dentry, inode);
 	dget(dentry);
 	return 0;
