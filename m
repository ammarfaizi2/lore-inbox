Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWFKSKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWFKSKs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 14:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWFKSKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 14:10:48 -0400
Received: from silver.veritas.com ([143.127.12.111]:6540 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750738AbWFKSKr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 14:10:47 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,227,1146466800"; 
   d="scan'208"; a="39101898:sNHT25846328"
Date: Sun, 11 Jun 2006 19:10:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: "Robin H. Johnson" <robbat2@gentoo.org>
cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] tmpfs time granularity fix for [acm]time going backwards.
 Also VFS time granularity bug on creat(). (Repost, more content)
In-Reply-To: <20060611115421.GE26475@curie-int.vc.shawcable.net>
Message-ID: <Pine.LNX.4.64.0606111833220.15060@blonde.wat.veritas.com>
References: <20060611115421.GE26475@curie-int.vc.shawcable.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 Jun 2006 18:10:43.0228 (UTC) FILETIME=[5A9F1DC0:01C68D82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jun 2006, Robin H. Johnson wrote:
> [Please CC me on replies].
> 
> This patch should probably be included for 2.6.17, despite how long the
> bug has been around. It's a one-liner, with no side-effects.

Not sure about that: easy enough to include the tmpfs one-liner,
but there's quite a few more such fixes needed, not all certain.

> I noticed a strange behavior in a tmpfs file system the other day, while
> building packages - occasionally, and seemingly at random, make decided to
> rebuild a target. However only on tmpfs.
> 
> A file would be created, and if checked, it had a sub-second timestamp.
> However, after an utimes related call where sub-seconds should be set, they
> were zeroed instead. In the case that a file was created, and utimes(...,NULL)
> was used on it in the same second, the timestamp on the file moved backwards.
> 
> Puesdo-code of my testcase:
> 	int fd = creat(name,0644);
> 	fstat(fd,&st);
> 	printf("...[acm]time...",...)
> 	futime(fd,NULL);
> 	fstat(fd,&st);
> 	printf("...[acm]time...",...)
> 	close(fd);
> 
> Tested against: linus 2.6.13, linus 2.6.17-rc6.
> 
> Test output from a filesystem not supporting sub-second timestamps (ext3, reiserfs):
> creat:   m=1149891410.0 c=1149891410.0 a=1149891407.0
> futimes: m=1149891410.0 c=1149891410.0 a=1149891410.0
> 
> Test output from a filesystem supporting sub-second timestamps (jfs,xfs,ramfs):
> creat:   m=1149891452.928796249 c=1149891452.928796249 a=1149891452.928796249
> futimes: m=1149891452.928796249 c=1149891452.928796249 a=1149891452.928796249
> 
> Test output from the tmpfs filesystem before the fix:
> creat:   m=1149892052.562029884 c=1149892052.562029884 a=1149892052.562029884
> futimes: m=1149892052.0         c=1149892052.0         a=1149892052.0
> 
> Test output from the tmpfs filesystem with the patch below:
> creat:   m=1149892086.382150894 c=1149892086.382150894 a=1149892075.473249075
> futimes: m=1149892086.383150885 c=1149892086.383150885 a=1149892086.383150885
> 
> The output above of jfs/xfs/ramfs having identical ctime/mtime in the
> utime/creat calls is just co-incidence, my box is reasonably fast, on a
> slower machine, they do diverge more. My box is just fast enough that
> they happened in the same tick (I have HZ=1000).
> 
> After some digging, I found that this was being caused by tmpfs not having a
> time granularity set, thus inheriting the default 1s granularity.

That's a great little discovery, and a very good report and analysis:
thank you.  Seems tmpfs got missed when s_time_gran was added in 2.6.11,
and I (tmpfs maintainer) failed to notice that patch going past.

> NOTE: The further bug:
> I believe this also indicates there is another bug at the VFS layer,
> where the initial timestamp from the creat() operation did not have the
> granularity applied to it. I haven't traced this problem down yet,
> others that are more familiar with the VFS might have a bit better luck.
> Unless this is fixed, similar issues may crop up with other filesystems.
> It just needs a bit of code like this:
> inode->i_[acm]time = current_fs_time(inode->i_sb);

Indeed, there's more to it than just the one tmpfs fix.  Unfortunately,
alloc_super's default s_time_gran of 1000000000 ns is at variance with
CURRENT_TIME's granularity: lots of work was done to insert s_time_gran
values, some simple filesystems picked up the 1 via simple_fill_super,
others were converted over to CURRENT_TIME_SEC; but there's still
plenty of opportunity for error here.

Perhaps we could devise a debug WARN_ON somewhere to check consistent
granularity; but I don't have the ingenuity right now, and would need
an additional superblock field or flag to not spam the logs horribly.
Perhaps it's easier just to delete CURRENT_TIME, converting its users.

Setting that safety aside, the patch below (against 2.6.17-rc6) looks
to me like all that's currently needed in mainline - but ecryptfs and
reiser4 in the mm tree will also want fixing, and more discrepancies
are sure to trickle in later.

If anyone thinks tmpfs is the most important to fix (I would think
that, wouldn't I?), I can forward your fix to Linus ahead of the rest.
Or if people agree the patch below is good, I can sign it off and send;
or FS maintainers extract their own little parts.

Hugh

 arch/powerpc/platforms/cell/spufs/inode.c |    1 +
 fs/9p/vfs_super.c                         |    1 +
 fs/cifs/file.c                            |   14 +++++++-------
 fs/ext2/super.c                           |    2 +-
 fs/ext3/super.c                           |    2 +-
 fs/jfs/ioctl.c                            |    2 +-
 fs/ocfs2/dlm/dlmfs.c                      |    2 ++
 fs/ocfs2/super.c                          |    1 +
 fs/reiserfs/super.c                       |    2 +-
 ipc/mqueue.c                              |    1 +
 kernel/cpuset.c                           |    1 +
 mm/shmem.c                                |    1 +
 12 files changed, 19 insertions(+), 11 deletions(-)

--- 2.6.17-rc6/arch/powerpc/platforms/cell/spufs/inode.c	2006-06-06 04:11:43.000000000 +0100
+++ linux/arch/powerpc/platforms/cell/spufs/inode.c	2006-06-11 18:30:36.000000000 +0100
@@ -424,6 +424,7 @@ spufs_fill_super(struct super_block *sb,
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = SPUFS_MAGIC;
 	sb->s_op = &s_ops;
+	sb->s_time_gran = 1;
 
 	return spufs_create_root(sb, data);
 }
--- 2.6.17-rc6/fs/9p/vfs_super.c	2006-06-06 04:11:58.000000000 +0100
+++ linux/fs/9p/vfs_super.c	2006-06-11 18:30:36.000000000 +0100
@@ -88,6 +88,7 @@ v9fs_fill_super(struct super_block *sb, 
 	sb->s_blocksize = 1 << sb->s_blocksize_bits;
 	sb->s_magic = V9FS_MAGIC;
 	sb->s_op = &v9fs_super_ops;
+	sb->s_time_gran = 1;
 
 	sb->s_flags = flags | MS_ACTIVE | MS_SYNCHRONOUS | MS_DIRSYNC |
 	    MS_NOATIME;
--- 2.6.17-rc6/fs/cifs/file.c	2006-06-06 04:11:59.000000000 +0100
+++ linux/fs/cifs/file.c	2006-06-11 18:30:36.000000000 +0100
@@ -949,15 +949,15 @@ static ssize_t cifs_write(struct file *f
 
 	/* since the write may have blocked check these pointers again */
 	if (file->f_dentry) {
-		if (file->f_dentry->d_inode) {
-			file->f_dentry->d_inode->i_ctime = 
-			file->f_dentry->d_inode->i_mtime = CURRENT_TIME;
+		struct inode *inode = file->f_dentry->d_inode;
+		if (inode) {
+			inode->i_ctime = inode->i_mtime =
+				current_fs_time(inode->i_sb);
 			if (total_written > 0) {
-				if (*poffset > file->f_dentry->d_inode->i_size)
-					i_size_write(file->f_dentry->d_inode, 
-						     *poffset);
+				if (*poffset > inode->i_size)
+					i_size_write(inode, *poffset);
 			}
-			mark_inode_dirty_sync(file->f_dentry->d_inode);
+			mark_inode_dirty_sync(inode);
 		}
 	}
 	FreeXid(xid);
--- 2.6.17-rc6/fs/ext2/super.c	2006-06-06 04:11:59.000000000 +0100
+++ linux/fs/ext2/super.c	2006-06-11 18:30:36.000000000 +0100
@@ -1190,7 +1190,7 @@ out:
 	if (inode->i_size < off+len-towrite)
 		i_size_write(inode, off+len-towrite);
 	inode->i_version++;
-	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 	mutex_unlock(&inode->i_mutex);
 	return len - towrite;
--- 2.6.17-rc6/fs/ext3/super.c	2006-06-06 04:11:59.000000000 +0100
+++ linux/fs/ext3/super.c	2006-06-11 18:30:36.000000000 +0100
@@ -2638,7 +2638,7 @@ out:
 		EXT3_I(inode)->i_disksize = inode->i_size;
 	}
 	inode->i_version++;
-	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
 	ext3_mark_inode_dirty(handle, inode);
 	mutex_unlock(&inode->i_mutex);
 	return len - towrite;
--- 2.6.17-rc6/fs/jfs/ioctl.c	2006-06-06 04:12:04.000000000 +0100
+++ linux/fs/jfs/ioctl.c	2006-06-11 18:30:36.000000000 +0100
@@ -96,7 +96,7 @@ int jfs_ioctl(struct inode * inode, stru
 		jfs_inode->mode2 = flags;
 
 		jfs_set_inode_flags(inode);
-		inode->i_ctime = CURRENT_TIME_SEC;
+		inode->i_ctime = CURRENT_TIME;
 		mark_inode_dirty(inode);
 		return 0;
 	}
--- 2.6.17-rc6/fs/ocfs2/dlm/dlmfs.c	2006-06-06 04:12:05.000000000 +0100
+++ linux/fs/ocfs2/dlm/dlmfs.c	2006-06-11 18:30:36.000000000 +0100
@@ -529,6 +529,8 @@ static int dlmfs_fill_super(struct super
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = DLMFS_MAGIC;
 	sb->s_op = &dlmfs_ops;
+	sb->s_time_gran = 1;
+
 	inode = dlmfs_get_root_inode(sb);
 	if (!inode)
 		return -ENOMEM;
--- 2.6.17-rc6/fs/ocfs2/super.c	2006-06-06 04:12:05.000000000 +0100
+++ linux/fs/ocfs2/super.c	2006-06-11 18:30:36.000000000 +0100
@@ -1252,6 +1252,7 @@ static int ocfs2_initialize_super(struct
 	sb->s_flags |= MS_NOATIME;
 	/* this is needed to support O_LARGEFILE */
 	sb->s_maxbytes = ocfs2_max_file_offset(sb->s_blocksize_bits);
+	sb->s_time_gran = 1;
 
 	osb->sb = sb;
 	/* Save off for ocfs2_rw_direct */
--- 2.6.17-rc6/fs/reiserfs/super.c	2006-06-06 04:12:05.000000000 +0100
+++ linux/fs/reiserfs/super.c	2006-06-11 18:30:36.000000000 +0100
@@ -2241,7 +2241,7 @@ static ssize_t reiserfs_quota_write(stru
 	if (inode->i_size < off + len - towrite)
 		i_size_write(inode, off + len - towrite);
 	inode->i_version++;
-	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 	mutex_unlock(&inode->i_mutex);
 	return len - towrite;
--- 2.6.17-rc6/ipc/mqueue.c	2006-06-06 04:12:10.000000000 +0100
+++ linux/ipc/mqueue.c	2006-06-11 18:30:36.000000000 +0100
@@ -188,6 +188,7 @@ static int mqueue_fill_super(struct supe
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = MQUEUE_MAGIC;
 	sb->s_op = &mqueue_super_ops;
+	sb->s_time_gran = 1;
 
 	inode = mqueue_get_inode(sb, S_IFDIR | S_ISVTX | S_IRWXUGO, NULL);
 	if (!inode)
--- 2.6.17-rc6/kernel/cpuset.c	2006-06-06 04:12:10.000000000 +0100
+++ linux/kernel/cpuset.c	2006-06-11 18:30:36.000000000 +0100
@@ -371,6 +371,7 @@ static int cpuset_fill_super(struct supe
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = CPUSET_SUPER_MAGIC;
 	sb->s_op = &cpuset_ops;
+	sb->s_time_gran = 1;
 	cpuset_sb = sb;
 
 	inode = cpuset_new_inode(S_IFDIR | S_IRUGO | S_IXUGO | S_IWUSR);
--- 2.6.17-rc6/mm/shmem.c	2006-06-06 04:12:11.000000000 +0100
+++ linux/mm/shmem.c	2006-06-11 18:30:36.000000000 +0100
@@ -2102,6 +2102,7 @@ static int shmem_fill_super(struct super
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = TMPFS_MAGIC;
 	sb->s_op = &shmem_ops;
+	sb->s_time_gran = 1;
 
 	inode = shmem_get_inode(sb, S_IFDIR | mode, 0);
 	if (!inode)
