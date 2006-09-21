Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWIUTMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWIUTMV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 15:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWIUTMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 15:12:21 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:24166 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750964AbWIUTMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 15:12:19 -0400
Date: Thu, 21 Sep 2006 12:12:03 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, ocfs2-devel@oss.oracle.com,
       linux-kernel@vger.kernel.org
Subject: [git patches] ocfs2 updates
Message-ID: <20060921191203.GD32106@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
	Aside from a few small bug fixes, this set of patches contains the
following ocfs2 changes:

* Ocfs2 now supports ext2 file attributes. Thanks to Herbert Poetzl for that
  feature.

* Fix mtime updates on buffered writes so that they always happen.

* Block read ahead support - right now it's used by the directory code.

* A configfs fix - it was previously possible to create duplicate subsystem
  names.

* Unmarks ocfs2 as depending on EXPERIMENTAL

Please pull from 'upstream-linus' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/mfasheh/ocfs2.git

to receive the following updates:

 fs/Kconfig                   |    4 -
 fs/configfs/dir.c            |   32 +++++++++-
 fs/ocfs2/Makefile            |    1 
 fs/ocfs2/alloc.c             |   28 ++++++--
 fs/ocfs2/aops.c              |   83 ++++++++++----------------
 fs/ocfs2/buffer_head_io.c    |   95 ++++++++++++++++++++++--------
 fs/ocfs2/buffer_head_io.h    |    2 
 fs/ocfs2/cluster/heartbeat.c |    8 +-
 fs/ocfs2/dir.c               |   28 +++++---
 fs/ocfs2/dlm/dlmast.c        |   10 +--
 fs/ocfs2/dlmglue.c           |    9 ++
 fs/ocfs2/dlmglue.h           |    5 -
 fs/ocfs2/file.c              |    3 
 fs/ocfs2/inode.c             |   32 ++++++++--
 fs/ocfs2/inode.h             |    3 
 fs/ocfs2/ioctl.c             |  136 +++++++++++++++++++++++++++++++++++++++++++
 fs/ocfs2/ioctl.h             |   16 +++++
 fs/ocfs2/namei.c             |   32 ++++------
 fs/ocfs2/ocfs2_fs.h          |   24 +++++++
 fs/ocfs2/uptodate.c          |   21 ++++++
 fs/ocfs2/uptodate.h          |    2 
 21 files changed, 440 insertions(+), 134 deletions(-)

Adrian Bunk:
      fs/ocfs2/ioctl.c should #include "ioctl.h"

Herbert Poetzl:
      ocfs2: add ext2 attributes

Joel Becker:
      configfs: Prevent duplicate subsystem names.

Mark Fasheh:
      ocfs2: move nlink check in ocfs2_mknod()
      ocfs2: properly update i_mtime on buffered write
      ocfs2: implement directory read-ahead
      ocfs2: Remove EXPERIMENTAL dependency
      ocfs2: Don't print on unknown remote blocking call
      ocfs2: Remove overzealous BUG_ON()

Mathieu Avila:
      ocfs2: Fix heartbeat sector calculation

Tiger Yang:
      ocfs2: Fix directory link count checks in ocfs2_link()

diff --git a/fs/Kconfig b/fs/Kconfig
index 3f00a9f..5305816 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -325,8 +325,8 @@ #
 source "fs/xfs/Kconfig"
 
 config OCFS2_FS
-	tristate "OCFS2 file system support (EXPERIMENTAL)"
-	depends on NET && SYSFS && EXPERIMENTAL
+	tristate "OCFS2 file system support"
+	depends on NET && SYSFS
 	select CONFIGFS_FS
 	select JBD
 	select CRC32
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index df02545..816e8ef 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -86,6 +86,32 @@ static struct configfs_dirent *configfs_
 	return sd;
 }
 
+/*
+ *
+ * Return -EEXIST if there is already a configfs element with the same
+ * name for the same parent.
+ *
+ * called with parent inode's i_mutex held
+ */
+int configfs_dirent_exists(struct configfs_dirent *parent_sd,
+			   const unsigned char *new)
+{
+	struct configfs_dirent * sd;
+
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		if (sd->s_element) {
+			const unsigned char *existing = configfs_get_name(sd);
+			if (strcmp(existing, new))
+				continue;
+			else
+				return -EEXIST;
+		}
+	}
+
+	return 0;
+}
+
+
 int configfs_make_dirent(struct configfs_dirent * parent_sd,
 			 struct dentry * dentry, void * element,
 			 umode_t mode, int type)
@@ -136,8 +162,10 @@ static int create_dir(struct config_item
 	int error;
 	umode_t mode = S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO;
 
-	error = configfs_make_dirent(p->d_fsdata, d, k, mode,
-				     CONFIGFS_DIR);
+	error = configfs_dirent_exists(p->d_fsdata, d->d_name.name);
+	if (!error)
+		error = configfs_make_dirent(p->d_fsdata, d, k, mode,
+					     CONFIGFS_DIR);
 	if (!error) {
 		error = configfs_create(d, mode, init_dir);
 		if (!error) {
diff --git a/fs/ocfs2/Makefile b/fs/ocfs2/Makefile
index 7d3be84..9fb8132 100644
--- a/fs/ocfs2/Makefile
+++ b/fs/ocfs2/Makefile
@@ -16,6 +16,7 @@ ocfs2-objs := \
 	file.o 			\
 	heartbeat.o 		\
 	inode.o 		\
+	ioctl.o 		\
 	journal.o 		\
 	localalloc.o 		\
 	mmap.o 			\
diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index edaab05..f43bc5f 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -1717,17 +1717,29 @@ static int ocfs2_do_truncate(struct ocfs
 
 			ocfs2_remove_from_cache(inode, eb_bh);
 
-			BUG_ON(eb->h_suballoc_slot);
 			BUG_ON(el->l_recs[0].e_clusters);
 			BUG_ON(el->l_recs[0].e_cpos);
 			BUG_ON(el->l_recs[0].e_blkno);
-			status = ocfs2_free_extent_block(handle,
-							 tc->tc_ext_alloc_inode,
-							 tc->tc_ext_alloc_bh,
-							 eb);
-			if (status < 0) {
-				mlog_errno(status);
-				goto bail;
+			if (eb->h_suballoc_slot == 0) {
+				/*
+				 * This code only understands how to
+				 * lock the suballocator in slot 0,
+				 * which is fine because allocation is
+				 * only ever done out of that
+				 * suballocator too. A future version
+				 * might change that however, so avoid
+				 * a free if we don't know how to
+				 * handle it. This way an fs incompat
+				 * bit will not be necessary.
+				 */
+				status = ocfs2_free_extent_block(handle,
+								 tc->tc_ext_alloc_inode,
+								 tc->tc_ext_alloc_bh,
+								 eb);
+				if (status < 0) {
+					mlog_errno(status);
+					goto bail;
+				}
 			}
 		}
 		brelse(eb_bh);
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index f1d1c34..3d7c082 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -391,31 +391,28 @@ out:
 static int ocfs2_commit_write(struct file *file, struct page *page,
 			      unsigned from, unsigned to)
 {
-	int ret, extending = 0, locklevel = 0;
-	loff_t new_i_size;
+	int ret;
 	struct buffer_head *di_bh = NULL;
 	struct inode *inode = page->mapping->host;
 	struct ocfs2_journal_handle *handle = NULL;
+	struct ocfs2_dinode *di;
 
 	mlog_entry("(0x%p, 0x%p, %u, %u)\n", file, page, from, to);
 
 	/* NOTE: ocfs2_file_aio_write has ensured that it's safe for
-	 * us to sample inode->i_size here without the metadata lock:
+	 * us to continue here without rechecking the I/O against
+	 * changed inode values.
 	 *
 	 * 1) We're currently holding the inode alloc lock, so no
 	 *    nodes can change it underneath us.
 	 *
 	 * 2) We've had to take the metadata lock at least once
-	 *    already to check for extending writes, hence insuring
-	 *    that our current copy is also up to date.
+	 *    already to check for extending writes, suid removal, etc.
+	 *    The meta data update code then ensures that we don't get a
+	 *    stale inode allocation image (i_size, i_clusters, etc).
 	 */
-	new_i_size = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
-	if (new_i_size > i_size_read(inode)) {
-		extending = 1;
-		locklevel = 1;
-	}
 
-	ret = ocfs2_meta_lock_with_page(inode, NULL, &di_bh, locklevel, page);
+	ret = ocfs2_meta_lock_with_page(inode, NULL, &di_bh, 1, page);
 	if (ret != 0) {
 		mlog_errno(ret);
 		goto out;
@@ -427,23 +424,20 @@ static int ocfs2_commit_write(struct fil
 		goto out_unlock_meta;
 	}
 
-	if (extending) {
-		handle = ocfs2_start_walk_page_trans(inode, page, from, to);
-		if (IS_ERR(handle)) {
-			ret = PTR_ERR(handle);
-			handle = NULL;
-			goto out_unlock_data;
-		}
+	handle = ocfs2_start_walk_page_trans(inode, page, from, to);
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
+		goto out_unlock_data;
+	}
 
-		/* Mark our buffer early. We'd rather catch this error up here
-		 * as opposed to after a successful commit_write which would
-		 * require us to set back inode->i_size. */
-		ret = ocfs2_journal_access(handle, inode, di_bh,
-					   OCFS2_JOURNAL_ACCESS_WRITE);
-		if (ret < 0) {
-			mlog_errno(ret);
-			goto out_commit;
-		}
+	/* Mark our buffer early. We'd rather catch this error up here
+	 * as opposed to after a successful commit_write which would
+	 * require us to set back inode->i_size. */
+	ret = ocfs2_journal_access(handle, inode, di_bh,
+				   OCFS2_JOURNAL_ACCESS_WRITE);
+	if (ret < 0) {
+		mlog_errno(ret);
+		goto out_commit;
 	}
 
 	/* might update i_size */
@@ -453,37 +447,28 @@ static int ocfs2_commit_write(struct fil
 		goto out_commit;
 	}
 
-	if (extending) {
-		loff_t size = (u64) i_size_read(inode);
-		struct ocfs2_dinode *di =
-			(struct ocfs2_dinode *)di_bh->b_data;
+	di = (struct ocfs2_dinode *)di_bh->b_data;
 
-		/* ocfs2_mark_inode_dirty is too heavy to use here. */
-		inode->i_blocks = ocfs2_align_bytes_to_sectors(size);
-		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	/* ocfs2_mark_inode_dirty() is too heavy to use here. */
+	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	di->i_mtime = di->i_ctime = cpu_to_le64(inode->i_mtime.tv_sec);
+	di->i_mtime_nsec = di->i_ctime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
 
-		di->i_size = cpu_to_le64(size);
-		di->i_ctime = di->i_mtime = 
-				cpu_to_le64(inode->i_mtime.tv_sec);
-		di->i_ctime_nsec = di->i_mtime_nsec = 
-				cpu_to_le32(inode->i_mtime.tv_nsec);
+	inode->i_blocks = ocfs2_align_bytes_to_sectors((u64)(i_size_read(inode)));
+	di->i_size = cpu_to_le64((u64)i_size_read(inode));
 
-		ret = ocfs2_journal_dirty(handle, di_bh);
-		if (ret < 0) {
-			mlog_errno(ret);
-			goto out_commit;
-		}
+	ret = ocfs2_journal_dirty(handle, di_bh);
+	if (ret < 0) {
+		mlog_errno(ret);
+		goto out_commit;
 	}
 
-	BUG_ON(extending && (i_size_read(inode) != new_i_size));
-
 out_commit:
-	if (handle)
-		ocfs2_commit_trans(handle);
+	ocfs2_commit_trans(handle);
 out_unlock_data:
 	ocfs2_data_unlock(inode, 1);
 out_unlock_meta:
-	ocfs2_meta_unlock(inode, locklevel);
+	ocfs2_meta_unlock(inode, 1);
 out:
 	if (di_bh)
 		brelse(di_bh);
diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index 9a24adf..c903741 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -100,6 +100,9 @@ int ocfs2_read_blocks(struct ocfs2_super
 	mlog_entry("(block=(%llu), nr=(%d), flags=%d, inode=%p)\n",
 		   (unsigned long long)block, nr, flags, inode);
 
+	BUG_ON((flags & OCFS2_BH_READAHEAD) &&
+	       (!inode || !(flags & OCFS2_BH_CACHED)));
+
 	if (osb == NULL || osb->sb == NULL || bhs == NULL) {
 		status = -EINVAL;
 		mlog_errno(status);
@@ -140,6 +143,30 @@ int ocfs2_read_blocks(struct ocfs2_super
 		bh = bhs[i];
 		ignore_cache = 0;
 
+		/* There are three read-ahead cases here which we need to
+		 * be concerned with. All three assume a buffer has
+		 * previously been submitted with OCFS2_BH_READAHEAD
+		 * and it hasn't yet completed I/O.
+		 *
+		 * 1) The current request is sync to disk. This rarely
+		 *    happens these days, and never when performance
+		 *    matters - the code can just wait on the buffer
+		 *    lock and re-submit.
+		 *
+		 * 2) The current request is cached, but not
+		 *    readahead. ocfs2_buffer_uptodate() will return
+		 *    false anyway, so we'll wind up waiting on the
+		 *    buffer lock to do I/O. We re-check the request
+		 *    with after getting the lock to avoid a re-submit.
+		 *
+		 * 3) The current request is readahead (and so must
+		 *    also be a caching one). We short circuit if the
+		 *    buffer is locked (under I/O) and if it's in the
+		 *    uptodate cache. The re-check from #2 catches the
+		 *    case that the previous read-ahead completes just
+		 *    before our is-it-in-flight check.
+		 */
+
 		if (flags & OCFS2_BH_CACHED &&
 		    !ocfs2_buffer_uptodate(inode, bh)) {
 			mlog(ML_UPTODATE,
@@ -169,6 +196,14 @@ int ocfs2_read_blocks(struct ocfs2_super
 				continue;
 			}
 
+			/* A read-ahead request was made - if the
+			 * buffer is already under read-ahead from a
+			 * previously submitted request than we are
+			 * done here. */
+			if ((flags & OCFS2_BH_READAHEAD)
+			    && ocfs2_buffer_read_ahead(inode, bh))
+				continue;
+
 			lock_buffer(bh);
 			if (buffer_jbd(bh)) {
 #ifdef CATCH_BH_JBD_RACES
@@ -181,13 +216,22 @@ #else
 				continue;
 #endif
 			}
+
+			/* Re-check ocfs2_buffer_uptodate() as a
+			 * previously read-ahead buffer may have
+			 * completed I/O while we were waiting for the
+			 * buffer lock. */
+			if ((flags & OCFS2_BH_CACHED)
+			    && !(flags & OCFS2_BH_READAHEAD)
+			    && ocfs2_buffer_uptodate(inode, bh)) {
+				unlock_buffer(bh);
+				continue;
+			}
+
 			clear_buffer_uptodate(bh);
 			get_bh(bh); /* for end_buffer_read_sync() */
 			bh->b_end_io = end_buffer_read_sync;
-			if (flags & OCFS2_BH_READAHEAD)
-				submit_bh(READA, bh);
-			else
-				submit_bh(READ, bh);
+			submit_bh(READ, bh);
 			continue;
 		}
 	}
@@ -197,34 +241,39 @@ #endif
 	for (i = (nr - 1); i >= 0; i--) {
 		bh = bhs[i];
 
-		/* We know this can't have changed as we hold the
-		 * inode sem. Avoid doing any work on the bh if the
-		 * journal has it. */
-		if (!buffer_jbd(bh))
-			wait_on_buffer(bh);
-
-		if (!buffer_uptodate(bh)) {
-			/* Status won't be cleared from here on out,
-			 * so we can safely record this and loop back
-			 * to cleanup the other buffers. Don't need to
-			 * remove the clustered uptodate information
-			 * for this bh as it's not marked locally
-			 * uptodate. */
-			status = -EIO;
-			brelse(bh);
-			bhs[i] = NULL;
-			continue;
+		if (!(flags & OCFS2_BH_READAHEAD)) {
+			/* We know this can't have changed as we hold the
+			 * inode sem. Avoid doing any work on the bh if the
+			 * journal has it. */
+			if (!buffer_jbd(bh))
+				wait_on_buffer(bh);
+
+			if (!buffer_uptodate(bh)) {
+				/* Status won't be cleared from here on out,
+				 * so we can safely record this and loop back
+				 * to cleanup the other buffers. Don't need to
+				 * remove the clustered uptodate information
+				 * for this bh as it's not marked locally
+				 * uptodate. */
+				status = -EIO;
+				brelse(bh);
+				bhs[i] = NULL;
+				continue;
+			}
 		}
 
+		/* Always set the buffer in the cache, even if it was
+		 * a forced read, or read-ahead which hasn't yet
+		 * completed. */
 		if (inode)
 			ocfs2_set_buffer_uptodate(inode, bh);
 	}
 	if (inode)
 		mutex_unlock(&OCFS2_I(inode)->ip_io_mutex);
 
-	mlog(ML_BH_IO, "block=(%llu), nr=(%d), cached=%s\n", 
+	mlog(ML_BH_IO, "block=(%llu), nr=(%d), cached=%s, flags=0x%x\n", 
 	     (unsigned long long)block, nr,
-	     (!(flags & OCFS2_BH_CACHED) || ignore_cache) ? "no" : "yes");
+	     (!(flags & OCFS2_BH_CACHED) || ignore_cache) ? "no" : "yes", flags);
 
 bail:
 
diff --git a/fs/ocfs2/buffer_head_io.h b/fs/ocfs2/buffer_head_io.h
index 6ecb909..6cc2093 100644
--- a/fs/ocfs2/buffer_head_io.h
+++ b/fs/ocfs2/buffer_head_io.h
@@ -49,7 +49,7 @@ int ocfs2_read_blocks(struct ocfs2_super
 
 
 #define OCFS2_BH_CACHED            1
-#define OCFS2_BH_READAHEAD         8	/* use this to pass READA down to submit_bh */
+#define OCFS2_BH_READAHEAD         8
 
 static inline int ocfs2_read_block(struct ocfs2_super * osb, u64 off,
 				   struct buffer_head **bh, int flags,
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 504595d..305cba3 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -320,8 +320,12 @@ static int compute_max_sectors(struct bl
 		max_pages = q->max_hw_segments;
 	max_pages--; /* Handle I/Os that straddle a page */
 
-	max_sectors = max_pages << (PAGE_SHIFT - 9);
-
+	if (max_pages) {
+		max_sectors = max_pages << (PAGE_SHIFT - 9);
+	} else {
+		/* If BIO contains 1 or less than 1 page. */
+		max_sectors = q->max_sectors;
+	}
 	/* Why is fls() 1-based???? */
 	pow_two_sectors = 1 << (fls(max_sectors) - 1);
 
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index 3d494d1..04e0191 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -74,14 +74,14 @@ static int ocfs2_extend_dir(struct ocfs2
 int ocfs2_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
 	int error = 0;
-	unsigned long offset, blk;
-	int i, num, stored;
+	unsigned long offset, blk, last_ra_blk = 0;
+	int i, stored;
 	struct buffer_head * bh, * tmp;
 	struct ocfs2_dir_entry * de;
 	int err;
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct super_block * sb = inode->i_sb;
-	int have_disk_lock = 0;
+	unsigned int ra_sectors = 16;
 
 	mlog_entry("dirino=%llu\n",
 		   (unsigned long long)OCFS2_I(inode)->ip_blkno);
@@ -95,9 +95,8 @@ int ocfs2_readdir(struct file * filp, vo
 			mlog_errno(error);
 		/* we haven't got any yet, so propagate the error. */
 		stored = error;
-		goto bail;
+		goto bail_nolock;
 	}
-	have_disk_lock = 1;
 
 	offset = filp->f_pos & (sb->s_blocksize - 1);
 
@@ -113,16 +112,21 @@ int ocfs2_readdir(struct file * filp, vo
 			continue;
 		}
 
-		/*
-		 * Do the readahead (8k)
-		 */
-		if (!offset) {
-			for (i = 16 >> (sb->s_blocksize_bits - 9), num = 0;
+		/* The idea here is to begin with 8k read-ahead and to stay
+		 * 4k ahead of our current position.
+		 *
+		 * TODO: Use the pagecache for this. We just need to
+		 * make sure it's cluster-safe... */
+		if (!last_ra_blk
+		    || (((last_ra_blk - blk) << 9) <= (ra_sectors / 2))) {
+			for (i = ra_sectors >> (sb->s_blocksize_bits - 9);
 			     i > 0; i--) {
 				tmp = ocfs2_bread(inode, ++blk, &err, 1);
 				if (tmp)
 					brelse(tmp);
 			}
+			last_ra_blk = blk;
+			ra_sectors = 8;
 		}
 
 revalidate:
@@ -194,9 +198,9 @@ revalidate:
 
 	stored = 0;
 bail:
-	if (have_disk_lock)
-		ocfs2_meta_unlock(inode, 0);
+	ocfs2_meta_unlock(inode, 0);
 
+bail_nolock:
 	mlog_exit(stored);
 
 	return stored;
diff --git a/fs/ocfs2/dlm/dlmast.c b/fs/ocfs2/dlm/dlmast.c
index 42775e2..f13a4ba 100644
--- a/fs/ocfs2/dlm/dlmast.c
+++ b/fs/ocfs2/dlm/dlmast.c
@@ -367,12 +367,10 @@ int dlm_proxy_ast_handler(struct o2net_m
 			goto do_ast;
 	}
 
-	mlog(ML_ERROR, "got %sast for unknown lock!  cookie=%u:%llu, "
-		       "name=%.*s, namelen=%u\n", 
-		       past->type == DLM_AST ? "" : "b", 
-		       dlm_get_lock_cookie_node(cookie),
-		       dlm_get_lock_cookie_seq(cookie),
-		       locklen, name, locklen);
+	mlog(0, "got %sast for unknown lock!  cookie=%u:%llu, "
+	     "name=%.*s, namelen=%u\n", past->type == DLM_AST ? "" : "b", 
+	     dlm_get_lock_cookie_node(cookie), dlm_get_lock_cookie_seq(cookie),
+	     locklen, name, locklen);
 
 	ret = DLM_NORMAL;
 unlock_out:
diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 762eb1f..151b417 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -1330,6 +1330,7 @@ static void __ocfs2_stuff_meta_lvb(struc
 		cpu_to_be64(ocfs2_pack_timespec(&inode->i_ctime));
 	lvb->lvb_imtime_packed =
 		cpu_to_be64(ocfs2_pack_timespec(&inode->i_mtime));
+	lvb->lvb_iattr    = cpu_to_be32(oi->ip_attr);
 
 	mlog_meta_lvb(0, lockres);
 
@@ -1360,6 +1361,9 @@ static void ocfs2_refresh_inode_from_lvb
 	oi->ip_clusters = be32_to_cpu(lvb->lvb_iclusters);
 	i_size_write(inode, be64_to_cpu(lvb->lvb_isize));
 
+	oi->ip_attr = be32_to_cpu(lvb->lvb_iattr);
+	ocfs2_set_inode_flags(inode);
+
 	/* fast-symlinks are a special case */
 	if (S_ISLNK(inode->i_mode) && !oi->ip_clusters)
 		inode->i_blocks = 0;
@@ -2899,8 +2903,9 @@ void ocfs2_dump_meta_lvb_info(u64 level,
 	     be32_to_cpu(lvb->lvb_iuid), be32_to_cpu(lvb->lvb_igid),
 	     be16_to_cpu(lvb->lvb_imode));
 	mlog(level, "nlink %u, atime_packed 0x%llx, ctime_packed 0x%llx, "
-	     "mtime_packed 0x%llx\n", be16_to_cpu(lvb->lvb_inlink),
+	     "mtime_packed 0x%llx iattr 0x%x\n", be16_to_cpu(lvb->lvb_inlink),
 	     (long long)be64_to_cpu(lvb->lvb_iatime_packed),
 	     (long long)be64_to_cpu(lvb->lvb_ictime_packed),
-	     (long long)be64_to_cpu(lvb->lvb_imtime_packed));
+	     (long long)be64_to_cpu(lvb->lvb_imtime_packed),
+	     be32_to_cpu(lvb->lvb_iattr));
 }
diff --git a/fs/ocfs2/dlmglue.h b/fs/ocfs2/dlmglue.h
index 8f2d1db..243ae86 100644
--- a/fs/ocfs2/dlmglue.h
+++ b/fs/ocfs2/dlmglue.h
@@ -27,7 +27,7 @@
 #ifndef DLMGLUE_H
 #define DLMGLUE_H
 
-#define OCFS2_LVB_VERSION 2
+#define OCFS2_LVB_VERSION 3
 
 struct ocfs2_meta_lvb {
 	__be32       lvb_version;
@@ -40,7 +40,8 @@ struct ocfs2_meta_lvb {
 	__be64       lvb_isize;
 	__be16       lvb_imode;
 	__be16       lvb_inlink;
-	__be32       lvb_reserved[3];
+	__be32       lvb_iattr;
+	__be32       lvb_reserved[2];
 };
 
 /* ocfs2_meta_lock_full() and ocfs2_data_lock_full() 'arg_flags' flags */
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index a9559c8..2bbfa17 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -44,6 +44,7 @@ #include "extent_map.h"
 #include "file.h"
 #include "sysfile.h"
 #include "inode.h"
+#include "ioctl.h"
 #include "journal.h"
 #include "mmap.h"
 #include "suballoc.h"
@@ -1227,10 +1228,12 @@ const struct file_operations ocfs2_fops 
 	.open		= ocfs2_file_open,
 	.aio_read	= ocfs2_file_aio_read,
 	.aio_write	= ocfs2_file_aio_write,
+	.ioctl		= ocfs2_ioctl,
 };
 
 const struct file_operations ocfs2_dops = {
 	.read		= generic_read_dir,
 	.readdir	= ocfs2_readdir,
 	.fsync		= ocfs2_sync_file,
+	.ioctl		= ocfs2_ioctl,
 };
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 327a5b7..7bcf691 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -71,6 +71,26 @@ static int ocfs2_truncate_for_delete(str
 				    struct inode *inode,
 				    struct buffer_head *fe_bh);
 
+void ocfs2_set_inode_flags(struct inode *inode)
+{
+	unsigned int flags = OCFS2_I(inode)->ip_attr;
+
+	inode->i_flags &= ~(S_IMMUTABLE |
+		S_SYNC | S_APPEND | S_NOATIME | S_DIRSYNC);
+
+	if (flags & OCFS2_IMMUTABLE_FL)
+		inode->i_flags |= S_IMMUTABLE;
+
+	if (flags & OCFS2_SYNC_FL)
+		inode->i_flags |= S_SYNC;
+	if (flags & OCFS2_APPEND_FL)
+		inode->i_flags |= S_APPEND;
+	if (flags & OCFS2_NOATIME_FL)
+		inode->i_flags |= S_NOATIME;
+	if (flags & OCFS2_DIRSYNC_FL)
+		inode->i_flags |= S_DIRSYNC;
+}
+
 struct inode *ocfs2_ilookup_for_vote(struct ocfs2_super *osb,
 				     u64 blkno,
 				     int delete_vote)
@@ -260,7 +280,6 @@ int ocfs2_populate_inode(struct inode *i
 		inode->i_blocks =
 			ocfs2_align_bytes_to_sectors(le64_to_cpu(fe->i_size));
 	inode->i_mapping->a_ops = &ocfs2_aops;
-	inode->i_flags |= S_NOATIME;
 	inode->i_atime.tv_sec = le64_to_cpu(fe->i_atime);
 	inode->i_atime.tv_nsec = le32_to_cpu(fe->i_atime_nsec);
 	inode->i_mtime.tv_sec = le64_to_cpu(fe->i_mtime);
@@ -276,6 +295,7 @@ int ocfs2_populate_inode(struct inode *i
 
 	OCFS2_I(inode)->ip_clusters = le32_to_cpu(fe->i_clusters);
 	OCFS2_I(inode)->ip_orphaned_slot = OCFS2_INVALID_SLOT;
+	OCFS2_I(inode)->ip_attr = le32_to_cpu(fe->i_attr);
 
 	if (create_ino)
 		inode->i_ino = ino_from_blkno(inode->i_sb,
@@ -330,6 +350,9 @@ int ocfs2_populate_inode(struct inode *i
 	ocfs2_inode_lock_res_init(&OCFS2_I(inode)->ip_data_lockres,
 				  OCFS2_LOCK_TYPE_DATA, inode);
 
+	ocfs2_set_inode_flags(inode);
+	inode->i_flags |= S_NOATIME;
+
 	status = 0;
 bail:
 	mlog_exit(status);
@@ -1027,12 +1050,8 @@ struct buffer_head *ocfs2_bread(struct i
 	u64 p_blkno;
 	int readflags = OCFS2_BH_CACHED;
 
-#if 0
-	/* only turn this on if we know we can deal with read_block
-	 * returning nothing */
 	if (reada)
 		readflags |= OCFS2_BH_READAHEAD;
-#endif
 
 	if (((u64)block << inode->i_sb->s_blocksize_bits) >=
 	    i_size_read(inode)) {
@@ -1131,6 +1150,7 @@ int ocfs2_mark_inode_dirty(struct ocfs2_
 
 	spin_lock(&OCFS2_I(inode)->ip_lock);
 	fe->i_clusters = cpu_to_le32(OCFS2_I(inode)->ip_clusters);
+	fe->i_attr = cpu_to_le32(OCFS2_I(inode)->ip_attr);
 	spin_unlock(&OCFS2_I(inode)->ip_lock);
 
 	fe->i_size = cpu_to_le64(i_size_read(inode));
@@ -1169,6 +1189,8 @@ void ocfs2_refresh_inode(struct inode *i
 	spin_lock(&OCFS2_I(inode)->ip_lock);
 
 	OCFS2_I(inode)->ip_clusters = le32_to_cpu(fe->i_clusters);
+	OCFS2_I(inode)->ip_attr = le32_to_cpu(fe->i_attr);
+	ocfs2_set_inode_flags(inode);
 	i_size_write(inode, le64_to_cpu(fe->i_size));
 	inode->i_nlink = le16_to_cpu(fe->i_links_count);
 	inode->i_uid = le32_to_cpu(fe->i_uid);
diff --git a/fs/ocfs2/inode.h b/fs/ocfs2/inode.h
index 35140f6..4d1e539 100644
--- a/fs/ocfs2/inode.h
+++ b/fs/ocfs2/inode.h
@@ -56,6 +56,7 @@ struct ocfs2_inode_info
 	struct ocfs2_journal_handle	*ip_handle;
 
 	u32				ip_flags; /* see below */
+	u32				ip_attr; /* inode attributes */
 
 	/* protected by recovery_lock. */
 	struct inode			*ip_next_orphan;
@@ -142,4 +143,6 @@ int ocfs2_mark_inode_dirty(struct ocfs2_
 int ocfs2_aio_read(struct file *file, struct kiocb *req, struct iocb *iocb);
 int ocfs2_aio_write(struct file *file, struct kiocb *req, struct iocb *iocb);
 
+void ocfs2_set_inode_flags(struct inode *inode);
+
 #endif /* OCFS2_INODE_H */
diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
new file mode 100644
index 0000000..3663cef
--- /dev/null
+++ b/fs/ocfs2/ioctl.c
@@ -0,0 +1,136 @@
+/*
+ * linux/fs/ocfs2/ioctl.c
+ *
+ * Copyright (C) 2006 Herbert Poetzl
+ * adapted from Remy Card's ext2/ioctl.c
+ */
+
+#include <linux/fs.h>
+#include <linux/mount.h>
+
+#define MLOG_MASK_PREFIX ML_INODE
+#include <cluster/masklog.h>
+
+#include "ocfs2.h"
+#include "alloc.h"
+#include "dlmglue.h"
+#include "inode.h"
+#include "journal.h"
+
+#include "ocfs2_fs.h"
+#include "ioctl.h"
+
+#include <linux/ext2_fs.h>
+
+static int ocfs2_get_inode_attr(struct inode *inode, unsigned *flags)
+{
+	int status;
+
+	status = ocfs2_meta_lock(inode, NULL, NULL, 0);
+	if (status < 0) {
+		mlog_errno(status);
+		return status;
+	}
+	*flags = OCFS2_I(inode)->ip_attr;
+	ocfs2_meta_unlock(inode, 0);
+
+	mlog_exit(status);
+	return status;
+}
+
+static int ocfs2_set_inode_attr(struct inode *inode, unsigned flags,
+				unsigned mask)
+{
+	struct ocfs2_inode_info *ocfs2_inode = OCFS2_I(inode);
+	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_journal_handle *handle = NULL;
+	struct buffer_head *bh = NULL;
+	unsigned oldflags;
+	int status;
+
+	mutex_lock(&inode->i_mutex);
+
+	status = ocfs2_meta_lock(inode, NULL, &bh, 1);
+	if (status < 0) {
+		mlog_errno(status);
+		goto bail;
+	}
+
+	status = -EROFS;
+	if (IS_RDONLY(inode))
+		goto bail_unlock;
+
+	status = -EACCES;
+	if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
+		goto bail_unlock;
+
+	if (!S_ISDIR(inode->i_mode))
+		flags &= ~OCFS2_DIRSYNC_FL;
+
+	handle = ocfs2_start_trans(osb, NULL, OCFS2_INODE_UPDATE_CREDITS);
+	if (IS_ERR(handle)) {
+		status = PTR_ERR(handle);
+		mlog_errno(status);
+		goto bail_unlock;
+	}
+
+	oldflags = ocfs2_inode->ip_attr;
+	flags = flags & mask;
+	flags |= oldflags & ~mask;
+
+	/*
+	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
+	 * the relevant capability.
+	 */
+	status = -EPERM;
+	if ((oldflags & OCFS2_IMMUTABLE_FL) || ((flags ^ oldflags) &
+		(OCFS2_APPEND_FL | OCFS2_IMMUTABLE_FL))) {
+		if (!capable(CAP_LINUX_IMMUTABLE))
+			goto bail_unlock;
+	}
+
+	ocfs2_inode->ip_attr = flags;
+	ocfs2_set_inode_flags(inode);
+
+	status = ocfs2_mark_inode_dirty(handle, inode, bh);
+	if (status < 0)
+		mlog_errno(status);
+
+	ocfs2_commit_trans(handle);
+bail_unlock:
+	ocfs2_meta_unlock(inode, 1);
+bail:
+	mutex_unlock(&inode->i_mutex);
+
+	if (bh)
+		brelse(bh);
+
+	mlog_exit(status);
+	return status;
+}
+
+int ocfs2_ioctl(struct inode * inode, struct file * filp,
+	unsigned int cmd, unsigned long arg)
+{
+	unsigned int flags;
+	int status;
+
+	switch (cmd) {
+	case OCFS2_IOC_GETFLAGS:
+		status = ocfs2_get_inode_attr(inode, &flags);
+		if (status < 0)
+			return status;
+
+		flags &= OCFS2_FL_VISIBLE;
+		return put_user(flags, (int __user *) arg);
+	case OCFS2_IOC_SETFLAGS:
+		if (get_user(flags, (int __user *) arg))
+			return -EFAULT;
+
+		return ocfs2_set_inode_attr(inode, flags,
+			OCFS2_FL_MODIFIABLE);
+	default:
+		return -ENOTTY;
+	}
+}
+
diff --git a/fs/ocfs2/ioctl.h b/fs/ocfs2/ioctl.h
new file mode 100644
index 0000000..4a7c829
--- /dev/null
+++ b/fs/ocfs2/ioctl.h
@@ -0,0 +1,16 @@
+/*
+ * ioctl.h
+ *
+ * Function prototypes
+ *
+ * Copyright (C) 2006 Herbert Poetzl
+ *
+ */
+
+#ifndef OCFS2_IOCTL_H
+#define OCFS2_IOCTL_H
+
+int ocfs2_ioctl(struct inode * inode, struct file * filp,
+	unsigned int cmd, unsigned long arg);
+
+#endif /* OCFS2_IOCTL_H */
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 0673862..0d3e939 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -56,6 +56,7 @@ #include "inode.h"
 #include "journal.h"
 #include "namei.h"
 #include "suballoc.h"
+#include "super.h"
 #include "symlink.h"
 #include "sysfile.h"
 #include "uptodate.h"
@@ -310,13 +311,6 @@ static int ocfs2_mknod(struct inode *dir
 	/* get our super block */
 	osb = OCFS2_SB(dir->i_sb);
 
-	if (S_ISDIR(mode) && (dir->i_nlink >= OCFS2_LINK_MAX)) {
-		mlog(ML_ERROR, "inode %llu has i_nlink of %u\n",
-		     (unsigned long long)OCFS2_I(dir)->ip_blkno, dir->i_nlink);
-		status = -EMLINK;
-		goto leave;
-	}
-
 	handle = ocfs2_alloc_handle(osb);
 	if (handle == NULL) {
 		status = -ENOMEM;
@@ -331,6 +325,11 @@ static int ocfs2_mknod(struct inode *dir
 		goto leave;
 	}
 
+	if (S_ISDIR(mode) && (dir->i_nlink >= OCFS2_LINK_MAX)) {
+		status = -EMLINK;
+		goto leave;
+	}
+
 	dirfe = (struct ocfs2_dinode *) parent_fe_bh->b_data;
 	if (!dirfe->i_links_count) {
 		/* can't make a file in a deleted directory. */
@@ -643,11 +642,6 @@ static int ocfs2_link(struct dentry *old
 		goto bail;
 	}
 
-	if (inode->i_nlink >= OCFS2_LINK_MAX) {
-		err = -EMLINK;
-		goto bail;
-	}
-
 	handle = ocfs2_alloc_handle(osb);
 	if (handle == NULL) {
 		err = -ENOMEM;
@@ -661,6 +655,11 @@ static int ocfs2_link(struct dentry *old
 		goto bail;
 	}
 
+	if (!dir->i_nlink) {
+		err = -ENOENT;
+		goto bail;
+	}
+
 	err = ocfs2_check_dir_for_entry(dir, dentry->d_name.name,
 					dentry->d_name.len);
 	if (err)
@@ -1964,13 +1963,8 @@ restart:
 				}
 				num++;
 
-				/* XXX: questionable readahead stuff here */
 				bh = ocfs2_bread(dir, b++, &err, 1);
 				bh_use[ra_max] = bh;
-#if 0		// ???
-				if (bh)
-					ll_rw_block(READ, 1, &bh);
-#endif
 			}
 		}
 		if ((bh = bh_use[ra_ptr++]) == NULL)
@@ -1978,6 +1972,10 @@ #endif
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh)) {
 			/* read error, skip block & hope for the best */
+			ocfs2_error(dir->i_sb, "reading directory %llu, "
+				    "offset %lu\n",
+				    (unsigned long long)OCFS2_I(dir)->ip_blkno,
+				    block);
 			brelse(bh);
 			goto next;
 		}
diff --git a/fs/ocfs2/ocfs2_fs.h b/fs/ocfs2/ocfs2_fs.h
index c5b1ac5..3330a5d 100644
--- a/fs/ocfs2/ocfs2_fs.h
+++ b/fs/ocfs2/ocfs2_fs.h
@@ -114,6 +114,26 @@ #define OCFS2_HEARTBEAT_FL	(0x00000200)	
 #define OCFS2_CHAIN_FL		(0x00000400)	/* Chain allocator */
 #define OCFS2_DEALLOC_FL	(0x00000800)	/* Truncate log */
 
+/* Inode attributes, keep in sync with EXT2 */
+#define OCFS2_SECRM_FL		(0x00000001)	/* Secure deletion */
+#define OCFS2_UNRM_FL		(0x00000002)	/* Undelete */
+#define OCFS2_COMPR_FL		(0x00000004)	/* Compress file */
+#define OCFS2_SYNC_FL		(0x00000008)	/* Synchronous updates */
+#define OCFS2_IMMUTABLE_FL	(0x00000010)	/* Immutable file */
+#define OCFS2_APPEND_FL		(0x00000020)	/* writes to file may only append */
+#define OCFS2_NODUMP_FL		(0x00000040)	/* do not dump file */
+#define OCFS2_NOATIME_FL	(0x00000080)	/* do not update atime */
+#define OCFS2_DIRSYNC_FL	(0x00010000)	/* dirsync behaviour (directories only) */
+
+#define OCFS2_FL_VISIBLE	(0x000100FF)	/* User visible flags */
+#define OCFS2_FL_MODIFIABLE	(0x000100FF)	/* User modifiable flags */
+
+/*
+ * ioctl commands
+ */
+#define OCFS2_IOC_GETFLAGS	_IOR('f', 1, long)
+#define OCFS2_IOC_SETFLAGS	_IOW('f', 2, long)
+
 /*
  * Journal Flags (ocfs2_dinode.id1.journal1.i_flags)
  */
@@ -399,7 +419,9 @@ struct ocfs2_dinode {
 	__le32 i_atime_nsec;
 	__le32 i_ctime_nsec;
 	__le32 i_mtime_nsec;
-/*70*/	__le64 i_reserved1[9];
+	__le32 i_attr;
+	__le32 i_reserved1;
+/*70*/	__le64 i_reserved2[8];
 /*B8*/	union {
 		__le64 i_pad1;		/* Generic way to refer to this
 					   64bit union */
diff --git a/fs/ocfs2/uptodate.c b/fs/ocfs2/uptodate.c
index b8a00a7..9707ed7 100644
--- a/fs/ocfs2/uptodate.c
+++ b/fs/ocfs2/uptodate.c
@@ -206,7 +206,10 @@ static int ocfs2_buffer_cached(struct oc
 }
 
 /* Warning: even if it returns true, this does *not* guarantee that
- * the block is stored in our inode metadata cache. */
+ * the block is stored in our inode metadata cache. 
+ * 
+ * This can be called under lock_buffer()
+ */
 int ocfs2_buffer_uptodate(struct inode *inode,
 			  struct buffer_head *bh)
 {
@@ -226,6 +229,16 @@ int ocfs2_buffer_uptodate(struct inode *
 	return ocfs2_buffer_cached(OCFS2_I(inode), bh);
 }
 
+/* 
+ * Determine whether a buffer is currently out on a read-ahead request.
+ * ip_io_sem should be held to serialize submitters with the logic here.
+ */
+int ocfs2_buffer_read_ahead(struct inode *inode,
+			    struct buffer_head *bh)
+{
+	return buffer_locked(bh) && ocfs2_buffer_cached(OCFS2_I(inode), bh);
+}
+
 /* Requires ip_lock */
 static void ocfs2_append_cache_array(struct ocfs2_caching_info *ci,
 				     sector_t block)
@@ -403,7 +416,11 @@ out_free:
  *
  * Note that this function may actually fail to insert the block if
  * memory cannot be allocated. This is not fatal however (but may
- * result in a performance penalty) */
+ * result in a performance penalty)
+ *
+ * Readahead buffers can be passed in here before the I/O request is
+ * completed.
+ */
 void ocfs2_set_buffer_uptodate(struct inode *inode,
 			       struct buffer_head *bh)
 {
diff --git a/fs/ocfs2/uptodate.h b/fs/ocfs2/uptodate.h
index 01cd32d..2e73206 100644
--- a/fs/ocfs2/uptodate.h
+++ b/fs/ocfs2/uptodate.h
@@ -40,5 +40,7 @@ void ocfs2_set_new_buffer_uptodate(struc
 				   struct buffer_head *bh);
 void ocfs2_remove_from_cache(struct inode *inode,
 			     struct buffer_head *bh);
+int ocfs2_buffer_read_ahead(struct inode *inode,
+			    struct buffer_head *bh);
 
 #endif /* OCFS2_UPTODATE_H */
