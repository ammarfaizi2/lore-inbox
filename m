Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422671AbWHYOzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422671AbWHYOzU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWHYOtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:49:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60032 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030192AbWHYOt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:49:29 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 01/18] [PATCH] BLOCK: Move functions out of buffer code [try #3]
Date: Fri, 25 Aug 2006 15:49:18 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060825144918.30722.6688.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060825144916.30722.90944.stgit@warthog.cambridge.redhat.com>
References: <20060825144916.30722.90944.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Move some functions out of the buffering code that aren't strictly buffering
specific.  This is a precursor to being able to disable the block layer.

 (*) Moved some stuff out of fs/buffer.c:

     (*) The file sync and general sync stuff moved to fs/sync.c.

     (*) The superblock sync stuff moved to fs/super.c.

     (*) do_invalidatepage() moved to mm/truncate.c.

     (*) try_to_release_page() moved to mm/filemap.c.

 (*) Moved some related declarations between header files:

     (*) declarations for do_invalidatepage() and try_to_release_page() moved
     	 to linux/mm.h.

     (*) __set_page_dirty_buffers() moved to linux/buffer_head.h.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/buffer.c                 |  174 -------------------------------------------
 fs/super.c                  |   31 ++++++++
 fs/sync.c                   |  113 ++++++++++++++++++++++++++++
 include/linux/buffer_head.h |    3 -
 include/linux/fs.h          |    1 
 include/linux/mm.h          |    4 +
 mm/filemap.c                |   30 +++++++
 mm/page-writeback.c         |    1 
 mm/truncate.c               |   26 ++++++
 9 files changed, 206 insertions(+), 177 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 71649ef..314b9c4 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -159,31 +159,6 @@ int sync_blockdev(struct block_device *b
 }
 EXPORT_SYMBOL(sync_blockdev);
 
-static void __fsync_super(struct super_block *sb)
-{
-	sync_inodes_sb(sb, 0);
-	DQUOT_SYNC(sb);
-	lock_super(sb);
-	if (sb->s_dirt && sb->s_op->write_super)
-		sb->s_op->write_super(sb);
-	unlock_super(sb);
-	if (sb->s_op->sync_fs)
-		sb->s_op->sync_fs(sb, 1);
-	sync_blockdev(sb->s_bdev);
-	sync_inodes_sb(sb, 1);
-}
-
-/*
- * Write out and wait upon all dirty data associated with this
- * superblock.  Filesystem data as well as the underlying block
- * device.  Takes the superblock lock.
- */
-int fsync_super(struct super_block *sb)
-{
-	__fsync_super(sb);
-	return sync_blockdev(sb->s_bdev);
-}
-
 /*
  * Write out and wait upon all dirty data associated with this
  * device.   Filesystem data as well as the underlying block
@@ -260,118 +235,6 @@ void thaw_bdev(struct block_device *bdev
 EXPORT_SYMBOL(thaw_bdev);
 
 /*
- * sync everything.  Start out by waking pdflush, because that writes back
- * all queues in parallel.
- */
-static void do_sync(unsigned long wait)
-{
-	wakeup_pdflush(0);
-	sync_inodes(0);		/* All mappings, inodes and their blockdevs */
-	DQUOT_SYNC(NULL);
-	sync_supers();		/* Write the superblocks */
-	sync_filesystems(0);	/* Start syncing the filesystems */
-	sync_filesystems(wait);	/* Waitingly sync the filesystems */
-	sync_inodes(wait);	/* Mappings, inodes and blockdevs, again. */
-	if (!wait)
-		printk("Emergency Sync complete\n");
-	if (unlikely(laptop_mode))
-		laptop_sync_completion();
-}
-
-asmlinkage long sys_sync(void)
-{
-	do_sync(1);
-	return 0;
-}
-
-void emergency_sync(void)
-{
-	pdflush_operation(do_sync, 0);
-}
-
-/*
- * Generic function to fsync a file.
- *
- * filp may be NULL if called via the msync of a vma.
- */
- 
-int file_fsync(struct file *filp, struct dentry *dentry, int datasync)
-{
-	struct inode * inode = dentry->d_inode;
-	struct super_block * sb;
-	int ret, err;
-
-	/* sync the inode to buffers */
-	ret = write_inode_now(inode, 0);
-
-	/* sync the superblock to buffers */
-	sb = inode->i_sb;
-	lock_super(sb);
-	if (sb->s_op->write_super)
-		sb->s_op->write_super(sb);
-	unlock_super(sb);
-
-	/* .. finally sync the buffers to disk */
-	err = sync_blockdev(sb->s_bdev);
-	if (!ret)
-		ret = err;
-	return ret;
-}
-
-long do_fsync(struct file *file, int datasync)
-{
-	int ret;
-	int err;
-	struct address_space *mapping = file->f_mapping;
-
-	if (!file->f_op || !file->f_op->fsync) {
-		/* Why?  We can still call filemap_fdatawrite */
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = filemap_fdatawrite(mapping);
-
-	/*
-	 * We need to protect against concurrent writers, which could cause
-	 * livelocks in fsync_buffers_list().
-	 */
-	mutex_lock(&mapping->host->i_mutex);
-	err = file->f_op->fsync(file, file->f_dentry, datasync);
-	if (!ret)
-		ret = err;
-	mutex_unlock(&mapping->host->i_mutex);
-	err = filemap_fdatawait(mapping);
-	if (!ret)
-		ret = err;
-out:
-	return ret;
-}
-
-static long __do_fsync(unsigned int fd, int datasync)
-{
-	struct file *file;
-	int ret = -EBADF;
-
-	file = fget(fd);
-	if (file) {
-		ret = do_fsync(file, datasync);
-		fput(file);
-	}
-	return ret;
-}
-
-asmlinkage long sys_fsync(unsigned int fd)
-{
-	return __do_fsync(fd, 0);
-}
-
-asmlinkage long sys_fdatasync(unsigned int fd)
-{
-	return __do_fsync(fd, 1);
-}
-
-/*
  * Various filesystems appear to want __find_get_block to be non-blocking.
  * But it's the page lock which protects the buffers.  To get around this,
  * we get exclusion from try_to_free_buffers with the blockdev mapping's
@@ -1551,35 +1414,6 @@ static void discard_buffer(struct buffer
 }
 
 /**
- * try_to_release_page() - release old fs-specific metadata on a page
- *
- * @page: the page which the kernel is trying to free
- * @gfp_mask: memory allocation flags (and I/O mode)
- *
- * The address_space is to try to release any data against the page
- * (presumably at page->private).  If the release was successful, return `1'.
- * Otherwise return zero.
- *
- * The @gfp_mask argument specifies whether I/O may be performed to release
- * this page (__GFP_IO), and whether the call may block (__GFP_WAIT).
- *
- * NOTE: @gfp_mask may go away, and this function may become non-blocking.
- */
-int try_to_release_page(struct page *page, gfp_t gfp_mask)
-{
-	struct address_space * const mapping = page->mapping;
-
-	BUG_ON(!PageLocked(page));
-	if (PageWriteback(page))
-		return 0;
-	
-	if (mapping && mapping->a_ops->releasepage)
-		return mapping->a_ops->releasepage(page, gfp_mask);
-	return try_to_free_buffers(page);
-}
-EXPORT_SYMBOL(try_to_release_page);
-
-/**
  * block_invalidatepage - invalidate part of all of a buffer-backed page
  *
  * @page: the page which is affected
@@ -1630,14 +1464,6 @@ out:
 }
 EXPORT_SYMBOL(block_invalidatepage);
 
-void do_invalidatepage(struct page *page, unsigned long offset)
-{
-	void (*invalidatepage)(struct page *, unsigned long);
-	invalidatepage = page->mapping->a_ops->invalidatepage ? :
-		block_invalidatepage;
-	(*invalidatepage)(page, offset);
-}
-
 /*
  * We attach and possibly dirty the buffers atomically wrt
  * __set_page_dirty_buffers() via private_lock.  try_to_free_buffers
diff --git a/fs/super.c b/fs/super.c
index 6d4e817..22c2fd1 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -219,6 +219,37 @@ static int grab_super(struct super_block
 	return 0;
 }
 
+/*
+ * Write out and wait upon all dirty data associated with this
+ * superblock.  Filesystem data as well as the underlying block
+ * device.  Takes the superblock lock.  Requires a second blkdev
+ * flush by the caller to complete the operation.
+ */
+void __fsync_super(struct super_block *sb)
+{
+	sync_inodes_sb(sb, 0);
+	DQUOT_SYNC(sb);
+	lock_super(sb);
+	if (sb->s_dirt && sb->s_op->write_super)
+		sb->s_op->write_super(sb);
+	unlock_super(sb);
+	if (sb->s_op->sync_fs)
+		sb->s_op->sync_fs(sb, 1);
+	sync_blockdev(sb->s_bdev);
+	sync_inodes_sb(sb, 1);
+}
+
+/*
+ * Write out and wait upon all dirty data associated with this
+ * superblock.  Filesystem data as well as the underlying block
+ * device.  Takes the superblock lock.
+ */
+int fsync_super(struct super_block *sb)
+{
+	__fsync_super(sb);
+	return sync_blockdev(sb->s_bdev);
+}
+
 /**
  *	generic_shutdown_super	-	common helper for ->kill_sb()
  *	@sb: superblock to kill
diff --git a/fs/sync.c b/fs/sync.c
index 955aef0..1de747b 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -10,11 +10,124 @@ #include <linux/writeback.h>
 #include <linux/syscalls.h>
 #include <linux/linkage.h>
 #include <linux/pagemap.h>
+#include <linux/quotaops.h>
+#include <linux/buffer_head.h>
 
 #define VALID_FLAGS (SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE| \
 			SYNC_FILE_RANGE_WAIT_AFTER)
 
 /*
+ * sync everything.  Start out by waking pdflush, because that writes back
+ * all queues in parallel.
+ */
+static void do_sync(unsigned long wait)
+{
+	wakeup_pdflush(0);
+	sync_inodes(0);		/* All mappings, inodes and their blockdevs */
+	DQUOT_SYNC(NULL);
+	sync_supers();		/* Write the superblocks */
+	sync_filesystems(0);	/* Start syncing the filesystems */
+	sync_filesystems(wait);	/* Waitingly sync the filesystems */
+	sync_inodes(wait);	/* Mappings, inodes and blockdevs, again. */
+	if (!wait)
+		printk("Emergency Sync complete\n");
+	if (unlikely(laptop_mode))
+		laptop_sync_completion();
+}
+
+asmlinkage long sys_sync(void)
+{
+	do_sync(1);
+	return 0;
+}
+
+void emergency_sync(void)
+{
+	pdflush_operation(do_sync, 0);
+}
+
+/*
+ * Generic function to fsync a file.
+ *
+ * filp may be NULL if called via the msync of a vma.
+ */
+int file_fsync(struct file *filp, struct dentry *dentry, int datasync)
+{
+	struct inode * inode = dentry->d_inode;
+	struct super_block * sb;
+	int ret, err;
+
+	/* sync the inode to buffers */
+	ret = write_inode_now(inode, 0);
+
+	/* sync the superblock to buffers */
+	sb = inode->i_sb;
+	lock_super(sb);
+	if (sb->s_op->write_super)
+		sb->s_op->write_super(sb);
+	unlock_super(sb);
+
+	/* .. finally sync the buffers to disk */
+	err = sync_blockdev(sb->s_bdev);
+	if (!ret)
+		ret = err;
+	return ret;
+}
+
+long do_fsync(struct file *file, int datasync)
+{
+	int ret;
+	int err;
+	struct address_space *mapping = file->f_mapping;
+
+	if (!file->f_op || !file->f_op->fsync) {
+		/* Why?  We can still call filemap_fdatawrite */
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = filemap_fdatawrite(mapping);
+
+	/*
+	 * We need to protect against concurrent writers, which could cause
+	 * livelocks in fsync_buffers_list().
+	 */
+	mutex_lock(&mapping->host->i_mutex);
+	err = file->f_op->fsync(file, file->f_dentry, datasync);
+	if (!ret)
+		ret = err;
+	mutex_unlock(&mapping->host->i_mutex);
+	err = filemap_fdatawait(mapping);
+	if (!ret)
+		ret = err;
+out:
+	return ret;
+}
+
+static long __do_fsync(unsigned int fd, int datasync)
+{
+	struct file *file;
+	int ret = -EBADF;
+
+	file = fget(fd);
+	if (file) {
+		ret = do_fsync(file, datasync);
+		fput(file);
+	}
+	return ret;
+}
+
+asmlinkage long sys_fsync(unsigned int fd)
+{
+	return __do_fsync(fd, 0);
+}
+
+asmlinkage long sys_fdatasync(unsigned int fd)
+{
+	return __do_fsync(fd, 1);
+}
+
+/*
  * sys_sync_file_range() permits finely controlled syncing over a segment of
  * a file in the range offset .. (offset+nbytes-1) inclusive.  If nbytes is
  * zero then sys_sync_file_range() will operate from offset out to EOF.
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 737e407..64b508e 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -190,9 +190,7 @@ extern int buffer_heads_over_limit;
  * Generic address_space_operations implementations for buffer_head-backed
  * address_spaces.
  */
-int try_to_release_page(struct page * page, gfp_t gfp_mask);
 void block_invalidatepage(struct page *page, unsigned long offset);
-void do_invalidatepage(struct page *page, unsigned long offset);
 int block_write_full_page(struct page *page, get_block_t *get_block,
 				struct writeback_control *wbc);
 int block_read_full_page(struct page*, get_block_t*);
@@ -302,4 +300,5 @@ static inline void lock_buffer(struct bu
 		__lock_buffer(bh);
 }
 
+extern int __set_page_dirty_buffers(struct page *page);
 #endif /* _LINUX_BUFFER_HEAD_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0599da8..cd7fc6a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1541,6 +1541,7 @@ extern int __filemap_fdatawrite_range(st
 extern long do_fsync(struct file *file, int datasync);
 extern void sync_supers(void);
 extern void sync_filesystems(int wait);
+extern void __fsync_super(struct super_block *sb);
 extern void emergency_sync(void);
 extern void emergency_remount(void);
 extern int do_remount_sb(struct super_block *sb, int flags,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 990957e..72867ac 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -766,7 +766,9 @@ int get_user_pages(struct task_struct *t
 		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);
 void print_bad_pte(struct vm_area_struct *, pte_t, unsigned long);
 
-int __set_page_dirty_buffers(struct page *page);
+extern int try_to_release_page(struct page * page, gfp_t gfp_mask);
+extern void do_invalidatepage(struct page *page, unsigned long offset);
+
 int __set_page_dirty_nobuffers(struct page *page);
 int redirty_page_for_writepage(struct writeback_control *wbc,
 				struct page *page);
diff --git a/mm/filemap.c b/mm/filemap.c
index b9a60c4..20a8a9b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2474,3 +2474,33 @@ generic_file_direct_IO(int rw, struct ki
 	}
 	return retval;
 }
+
+/**
+ * try_to_release_page() - release old fs-specific metadata on a page
+ *
+ * @page: the page which the kernel is trying to free
+ * @gfp_mask: memory allocation flags (and I/O mode)
+ *
+ * The address_space is to try to release any data against the page
+ * (presumably at page->private).  If the release was successful, return `1'.
+ * Otherwise return zero.
+ *
+ * The @gfp_mask argument specifies whether I/O may be performed to release
+ * this page (__GFP_IO), and whether the call may block (__GFP_WAIT).
+ *
+ * NOTE: @gfp_mask may go away, and this function may become non-blocking.
+ */
+int try_to_release_page(struct page *page, gfp_t gfp_mask)
+{
+	struct address_space * const mapping = page->mapping;
+
+	BUG_ON(!PageLocked(page));
+	if (PageWriteback(page))
+		return 0;
+
+	if (mapping && mapping->a_ops->releasepage)
+		return mapping->a_ops->releasepage(page, gfp_mask);
+	return try_to_free_buffers(page);
+}
+
+EXPORT_SYMBOL(try_to_release_page);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e630188..f75d033 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -29,6 +29,7 @@ #include <linux/smp.h>
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/buffer_head.h>
 
 /*
  * The maximum number of pages to writeout in a single bdflush/kupdate
diff --git a/mm/truncate.c b/mm/truncate.c
index cf1b015..081437d 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -16,6 +16,32 @@ #include <linux/buffer_head.h>	/* grr. t
 				   do_invalidatepage */
 
 
+/**
+ * do_invalidatepage - invalidate part of all of a page
+ * @page: the page which is affected
+ * @offset: the index of the truncation point
+ *
+ * do_invalidatepage() is called when all or part of the page has become
+ * invalidated by a truncate operation.
+ *
+ * do_invalidatepage() does not have to release all buffers, but it must
+ * ensure that no dirty buffer is left outside @offset and that no I/O
+ * is underway against any of the blocks which are outside the truncation
+ * point.  Because the caller is about to free (and possibly reuse) those
+ * blocks on-disk.
+ */
+void do_invalidatepage(struct page *page, unsigned long offset)
+{
+	void (*invalidatepage)(struct page *, unsigned long);
+	invalidatepage = page->mapping->a_ops->invalidatepage;
+#ifdef CONFIG_BLOCK
+	if (!invalidatepage)
+		invalidatepage = block_invalidatepage;
+#endif
+	if (invalidatepage)
+		(*invalidatepage)(page, offset);
+}
+
 static inline void truncate_partial_page(struct page *page, unsigned partial)
 {
 	memclear_highpage_flush(page, partial, PAGE_CACHE_SIZE-partial);
