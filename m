Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318297AbSHKHoS>; Sun, 11 Aug 2002 03:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318211AbSHKHnh>; Sun, 11 Aug 2002 03:43:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46086 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317898AbSHKH0p>;
	Sun, 11 Aug 2002 03:26:45 -0400
Message-ID: <3D5614E6.460814A5@zip.com.au>
Date: Sun, 11 Aug 2002 00:40:22 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 21/21] writeback correctness and peformance fixes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This is a performance and correctness fix against the writeback paths.

The writeback code has competing requirements.  Sometimes it is used
for "memory cleansing": kupdate, bdflush, writer throttling, page
allocator writeback, etc.  And sometimes this same code is used for
data integrity pruposes: fsync, msync, fdatasync, sync, umount, various
other kernel-internal uses.

The problem is: how to handle a dirty buffer or page which is currently
under writeback.

For memory cleansing, we just want to skip that buffer/page and go onto
the next one.  But for sync, we must wait on the old writeback and then
start new writeback.

mpage_writepages() is current correct for cleansing, but incorrect for
sync.  block_write_full_page() is currently correct for sync, but
inefficient for cleansing.

The fix is fairly simple.

- In mpage_writepages(), don't skip the page is it's a sync
  operation.

- In block_write_full_page(), skip the buffer if it is a sync
  operation.  And return -EAGAIN to tell the caller that the writeout
  didn't work out.  The caller must then set the page dirty again and
  move it onto mapping->dirty_pages.

  This is an extension of the writepage API: writepage can now return
  EAGAIN.  There are only three callers, and they have been updated.

  fail_writepage() and ext3_writepage() were actually doing this by
  hand.  They have been changed to return -EAGAIN.  NTFS will want to
  be able to return -EAGAIN from its writepage as well.

- A sticky question is: how to tell the writeout code which mode it
  is operating in?  Cleansing or sync?

  It's such a tiny code change that I didn't have the heart to go and
  propagate a `mode' argument down every instance of writepages() and
  writepage() in the kernel.  So I passed it in via current->flags.

Incidentally, the occurrence of a locked-and-dirty buffer in
block_write_full_page() is fairly rare: normally the collision avoidance
happens at the address_space level, via PageWriteback.  But some
mappings (blockdevs, ext3 files, etc) have their dirty buffers written
out via submit_bh().  It is these buffers which can stall
block_write_full_page().

This wart will be pretty intrusive to fix.  ext3 needs to become fully
page-based (ugh.  It's a block-based journalling filesystem, and pages
are unnatural).  blockdev mappings are still written out by buffers
because that's how filesystems use them.  Putting _all_ metadata
(indirects, inodes, superblocks, etc) into standalone address_spaces
would fix that up.

- filemap_fdatawrite() sets PF_SYNC.  So filemap_fdatawrite() is the
  kernel function which will start writeback against a mapping for
  "data integrity" purposes, whereas the unexported, internal-only
  do_writepages() is the writeback function which is used for memory
  cleansing.  This difference is the reason why I didn't consolidate
  those functions ages ago...

- Lots of code paths had a bogus extra call to filemap_fdatawait(),
  which I previously added in a moment of weak-headedness.  They have
  all been removed.




 fs/buffer.c               |   31 ++++++++++++++++++++-----------
 fs/ext3/inode.c           |   19 ++++++++++---------
 fs/jfs/jfs_dmap.c         |    1 -
 fs/jfs/jfs_imap.c         |    2 --
 fs/jfs/jfs_logmgr.c       |    3 ---
 fs/jfs/jfs_txnmgr.c       |    1 -
 fs/jfs/jfs_umount.c       |    2 --
 fs/jfs/super.c            |    2 --
 fs/mpage.c                |   11 ++++++++++-
 fs/nfs/file.c             |    6 +-----
 fs/nfs/inode.c            |    1 -
 fs/nfsd/vfs.c             |    1 -
 fs/smbfs/file.c           |    1 -
 fs/smbfs/inode.c          |    1 -
 fs/udf/inode.c            |    3 ++-
 include/linux/sched.h     |    1 +
 include/linux/writeback.h |    9 +++++++++
 mm/filemap.c              |   34 +++++++++++++++++++++-------------
 mm/msync.c                |    5 +----
 mm/page-writeback.c       |   15 ++++++++++++---
 20 files changed, 87 insertions(+), 62 deletions(-)

--- 2.5.31/fs/buffer.c~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/fs/buffer.c	Sun Aug 11 00:20:45 2002
@@ -307,10 +307,7 @@ asmlinkage long sys_fsync(unsigned int f
 
 	/* We need to protect against concurrent writers.. */
 	down(&inode->i_sem);
-	ret = filemap_fdatawait(inode->i_mapping);
-	err = filemap_fdatawrite(inode->i_mapping);
-	if (!ret)
-		ret = err;
+	ret = filemap_fdatawrite(inode->i_mapping);
 	err = file->f_op->fsync(file, dentry, 0);
 	if (!ret)
 		ret = err;
@@ -345,10 +342,7 @@ asmlinkage long sys_fdatasync(unsigned i
 		goto out_putf;
 
 	down(&inode->i_sem);
-	ret = filemap_fdatawait(inode->i_mapping);
-	err = filemap_fdatawrite(inode->i_mapping);
-	if (!ret)
-		ret = err;
+	ret = filemap_fdatawrite(inode->i_mapping);
 	err = file->f_op->fsync(file, dentry, 1);
 	if (!ret)
 		ret = err;
@@ -1648,11 +1642,18 @@ void unmap_underlying_metadata(struct bl
  * the page lock, whoever dirtied the buffers may decide to clean them
  * again at any time.  We handle that by only looking at the buffer
  * state inside lock_buffer().
+ *
+ * If block_write_full_page() is called for regular writeback
+ * (called_for_sync() is false) then it will return -EAGAIN for a locked
+ * buffer.   This only can happen if someone has written the buffer directly,
+ * with submit_bh().  At the address_space level PageWriteback prevents this
+ * contention from occurring.
  */
 static int __block_write_full_page(struct inode *inode,
 			struct page *page, get_block_t *get_block)
 {
 	int err;
+	int ret = 0;
 	unsigned long block;
 	unsigned long last_block;
 	struct buffer_head *bh, *head;
@@ -1724,7 +1725,14 @@ static int __block_write_full_page(struc
 	do {
 		get_bh(bh);
 		if (buffer_mapped(bh) && buffer_dirty(bh)) {
-			lock_buffer(bh);
+			if (called_for_sync()) {
+				lock_buffer(bh);
+			} else {
+				if (test_set_buffer_locked(bh)) {
+					ret = -EAGAIN;
+					continue;
+				}
+			}
 			if (test_clear_buffer_dirty(bh)) {
 				if (!buffer_uptodate(bh))
 					buffer_error();
@@ -1733,8 +1741,7 @@ static int __block_write_full_page(struc
 				unlock_buffer(bh);
 			}
 		}
-		bh = bh->b_this_page;
-	} while (bh != head);
+	} while ((bh = bh->b_this_page) != head);
 
 	BUG_ON(PageWriteback(page));
 	SetPageWriteback(page);		/* Keeps try_to_free_buffers() away */
@@ -1774,6 +1781,8 @@ done:
 			SetPageUptodate(page);
 		end_page_writeback(page);
 	}
+	if (err == 0)
+		return ret;
 	return err;
 recover:
 	/*
--- 2.5.31/fs/mpage.c~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/fs/mpage.c	Sun Aug 11 00:20:35 2002
@@ -19,6 +19,7 @@
 #include <linux/highmem.h>
 #include <linux/prefetch.h>
 #include <linux/mpage.h>
+#include <linux/writeback.h>
 #include <linux/pagevec.h>
 
 /*
@@ -530,6 +531,7 @@ mpage_writepages(struct address_space *m
 	sector_t last_block_in_bio = 0;
 	int ret = 0;
 	int done = 0;
+	int sync = called_for_sync();
 	struct pagevec pvec;
 	int (*writepage)(struct page *);
 
@@ -546,7 +548,7 @@ mpage_writepages(struct address_space *m
 		struct page *page = list_entry(mapping->io_pages.prev,
 					struct page, list);
 		list_del(&page->list);
-		if (PageWriteback(page)) {
+		if (PageWriteback(page) && !sync) {
 			if (PageDirty(page)) {
 				list_add(&page->list, &mapping->dirty_pages);
 				continue;
@@ -565,6 +567,9 @@ mpage_writepages(struct address_space *m
 
 		lock_page(page);
 
+		if (sync)
+			wait_on_page_writeback(page);
+
 		if (page->mapping && !PageWriteback(page) &&
 					TestClearPageDirty(page)) {
 			if (writepage) {
@@ -579,6 +584,10 @@ mpage_writepages(struct address_space *m
 					pagevec_deactivate_inactive(&pvec);
 				page = NULL;
 			}
+			if (ret == -EAGAIN && page) {
+				__set_page_dirty_nobuffers(page);
+				ret = 0;
+			}
 			if (ret || (nr_to_write && --(*nr_to_write) <= 0))
 				done = 1;
 		} else {
--- 2.5.31/include/linux/sched.h~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/linux/sched.h	Sun Aug 11 00:20:35 2002
@@ -393,6 +393,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_FREEZE	0x00010000	/* this task should be frozen for suspend */
 #define PF_IOTHREAD	0x00020000	/* this thread is needed for doing I/O to swap */
 #define PF_FROZEN	0x00040000	/* frozen for system suspend */
+#define PF_SYNC		0x00080000	/* performing fsync(), etc */
 
 /*
  * Ptrace flags
--- 2.5.31/include/linux/writeback.h~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/linux/writeback.h	Sun Aug 11 00:20:35 2002
@@ -72,4 +72,13 @@ extern int nr_pdflush_threads;	/* Global
 				   read-only. */
 
 
+/*
+ * Tell the writeback paths that they are being called for a "data integrity"
+ * operation such as fsync().
+ */
+static inline int called_for_sync(void)
+{
+	return current->flags & PF_SYNC;
+}
+
 #endif		/* WRITEBACK_H */
--- 2.5.31/mm/filemap.c~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/mm/filemap.c	Sun Aug 11 00:20:47 2002
@@ -471,31 +471,38 @@ int fail_writepage(struct page *page)
 			SetPageReferenced(page);
 	}
 
-	/* Set the page dirty again, unlock */
-	set_page_dirty(page);
 	unlock_page(page);
-	return 0;
+	return -EAGAIN;		/* It will be set dirty again */
 }
 EXPORT_SYMBOL(fail_writepage);
 
 /**
- *  filemap_fdatawrite - walk the list of dirty pages of the given address space
- *                      and writepage() all of them.
+ * filemap_fdatawrite - start writeback against all of a mapping's dirty pages
+ * @mapping: address space structure to write
  *
- *  @mapping: address space structure to write
+ * This is a "data integrity" operation, as opposed to a regular memory
+ * cleansing writeback.  The difference between these two operations is that
+ * if a dirty page/buffer is encountered, it must be waited upon, and not just
+ * skipped over.
  *
+ * The PF_SYNC flag is set across this operation and the various functions
+ * which care about this distinction must use called_for_sync() to find out
+ * which behaviour they should implement.
  */
 int filemap_fdatawrite(struct address_space *mapping)
 {
-	return do_writepages(mapping, NULL);
+	int ret;
+
+	current->flags |= PF_SYNC;
+	ret = do_writepages(mapping, NULL);
+	current->flags &= ~PF_SYNC;
+	return ret;
 }
 
 /**
- *      filemap_fdatawait - walk the list of locked pages of the given address space
- *     	and wait for all of them.
- * 
- *      @mapping: address space structure to wait for
- *
+ * filemap_fdatawait - walk the list of locked pages of the given address
+ *                     space and wait for all of them.
+ * @mapping: address space structure to wait for
  */
 int filemap_fdatawait(struct address_space * mapping)
 {
@@ -504,8 +511,9 @@ int filemap_fdatawait(struct address_spa
 	write_lock(&mapping->page_lock);
 
         while (!list_empty(&mapping->locked_pages)) {
-		struct page *page = list_entry(mapping->locked_pages.next, struct page, list);
+		struct page *page;
 
+		page = list_entry(mapping->locked_pages.next,struct page,list);
 		list_del(&page->list);
 		if (PageDirty(page))
 			list_add(&page->list, &mapping->dirty_pages);
--- 2.5.31/fs/jfs/jfs_dmap.c~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/fs/jfs/jfs_dmap.c	Sun Aug 11 00:20:35 2002
@@ -325,7 +325,6 @@ int dbSync(struct inode *ipbmap)
 	/*
 	 * write out dirty pages of bmap
 	 */
-	filemap_fdatawait(ipbmap->i_mapping);
 	filemap_fdatawrite(ipbmap->i_mapping);
 	filemap_fdatawait(ipbmap->i_mapping);
 
--- 2.5.31/fs/jfs/jfs_imap.c~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/fs/jfs/jfs_imap.c	Sun Aug 11 00:20:35 2002
@@ -281,7 +281,6 @@ int diSync(struct inode *ipimap)
 	/*
 	 * write out dirty pages of imap
 	 */
-	filemap_fdatawait(ipimap->i_mapping);
 	filemap_fdatawrite(ipimap->i_mapping);
 	filemap_fdatawait(ipimap->i_mapping);
 
@@ -595,7 +594,6 @@ void diFreeSpecial(struct inode *ip)
 		jERROR(1, ("diFreeSpecial called with NULL ip!\n"));
 		return;
 	}
-	filemap_fdatawait(ip->i_mapping);
 	filemap_fdatawrite(ip->i_mapping);
 	filemap_fdatawait(ip->i_mapping);
 	truncate_inode_pages(ip->i_mapping, 0);
--- 2.5.31/fs/jfs/jfs_logmgr.c~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/fs/jfs/jfs_logmgr.c	Sun Aug 11 00:20:35 2002
@@ -965,9 +965,6 @@ int lmLogSync(log_t * log, int nosyncwai
 		 * We need to make sure all of the "written" metapages
 		 * actually make it to disk
 		 */
-		filemap_fdatawait(sbi->ipbmap->i_mapping);
-		filemap_fdatawait(sbi->ipimap->i_mapping);
-		filemap_fdatawait(sbi->direct_inode->i_mapping);
 		filemap_fdatawrite(sbi->ipbmap->i_mapping);
 		filemap_fdatawrite(sbi->ipimap->i_mapping);
 		filemap_fdatawrite(sbi->direct_inode->i_mapping);
--- 2.5.31/fs/jfs/jfs_txnmgr.c~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/fs/jfs/jfs_txnmgr.c	Sun Aug 11 00:20:35 2002
@@ -1165,7 +1165,6 @@ int txCommit(tid_t tid,		/* transaction 
 		 *
 		 * if ((!S_ISDIR(ip->i_mode))
 		 *    && (tblk->flag & COMMIT_DELETE) == 0) {
-		 *	filemap_fdatawait(ip->i_mapping);
 		 *	filemap_fdatawrite(ip->i_mapping);
 		 *	filemap_fdatawait(ip->i_mapping);
 		 * }
--- 2.5.31/fs/jfs/jfs_umount.c~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/fs/jfs/jfs_umount.c	Sun Aug 11 00:20:35 2002
@@ -112,7 +112,6 @@ int jfs_umount(struct super_block *sb)
 	 * Make sure all metadata makes it to disk before we mark
 	 * the superblock as clean
 	 */
-	filemap_fdatawait(sbi->direct_inode->i_mapping);
 	filemap_fdatawrite(sbi->direct_inode->i_mapping);
 	filemap_fdatawait(sbi->direct_inode->i_mapping);
 
@@ -159,7 +158,6 @@ int jfs_umount_rw(struct super_block *sb
 	 */
 	dbSync(sbi->ipbmap);
 	diSync(sbi->ipimap);
-	filemap_fdatawait(sbi->direct_inode->i_mapping);
 	filemap_fdatawrite(sbi->direct_inode->i_mapping);
 	filemap_fdatawait(sbi->direct_inode->i_mapping);
 
--- 2.5.31/fs/jfs/super.c~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/fs/jfs/super.c	Sun Aug 11 00:20:35 2002
@@ -146,7 +146,6 @@ static void jfs_put_super(struct super_b
 	 * We need to clean out the direct_inode pages since this inode
 	 * is not in the inode hash.
 	 */
-	filemap_fdatawait(sbi->direct_inode->i_mapping);
 	filemap_fdatawrite(sbi->direct_inode->i_mapping);
 	filemap_fdatawait(sbi->direct_inode->i_mapping);
 	truncate_inode_pages(sbi->direct_mapping, 0);
@@ -362,7 +361,6 @@ out_no_rw:
 		jERROR(1, ("jfs_umount failed with return code %d\n", rc));
 	}
 out_mount_failed:
-	filemap_fdatawait(sbi->direct_inode->i_mapping);
 	filemap_fdatawrite(sbi->direct_inode->i_mapping);
 	filemap_fdatawait(sbi->direct_inode->i_mapping);
 	truncate_inode_pages(sbi->direct_mapping, 0);
--- 2.5.31/fs/nfs/file.c~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/fs/nfs/file.c	Sun Aug 11 00:20:35 2002
@@ -279,10 +279,7 @@ nfs_lock(struct file *filp, int cmd, str
 	 * Flush all pending writes before doing anything
 	 * with locks..
 	 */
-	status = filemap_fdatawait(inode->i_mapping);
-	status2 = filemap_fdatawrite(inode->i_mapping);
-	if (!status)
-		status = status2;
+	status = filemap_fdatawrite(inode->i_mapping);
 	down(&inode->i_sem);
 	status2 = nfs_wb_all(inode);
 	if (!status)
@@ -308,7 +305,6 @@ nfs_lock(struct file *filp, int cmd, str
 	 */
  out_ok:
 	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
-		filemap_fdatawait(inode->i_mapping);
 		filemap_fdatawrite(inode->i_mapping);
 		down(&inode->i_sem);
 		nfs_wb_all(inode);      /* we may have slept */
--- 2.5.31/fs/nfs/inode.c~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/fs/nfs/inode.c	Sun Aug 11 00:20:35 2002
@@ -775,7 +775,6 @@ printk("nfs_setattr: revalidate failed, 
 	if (!S_ISREG(inode->i_mode))
 		attr->ia_valid &= ~ATTR_SIZE;
 
-	filemap_fdatawait(inode->i_mapping);
 	filemap_fdatawrite(inode->i_mapping);
 	error = nfs_wb_all(inode);
 	filemap_fdatawait(inode->i_mapping);
--- 2.5.31/fs/nfsd/vfs.c~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/fs/nfsd/vfs.c	Sun Aug 11 00:20:35 2002
@@ -496,7 +496,6 @@ inline void nfsd_dosync(struct file *fil
 	struct inode *inode = dp->d_inode;
 	int (*fsync) (struct file *, struct dentry *, int);
 
-	filemap_fdatawait(inode->i_mapping);
 	filemap_fdatawrite(inode->i_mapping);
 	if (fop && (fsync = fop->fsync))
 		fsync(filp, dp, 0);
--- 2.5.31/fs/smbfs/file.c~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/fs/smbfs/file.c	Sun Aug 11 00:20:35 2002
@@ -352,7 +352,6 @@ smb_file_release(struct inode *inode, st
 		/* We must flush any dirty pages now as we won't be able to
 		   write anything after close. mmap can trigger this.
 		   "openers" should perhaps include mmap'ers ... */
-		filemap_fdatawait(inode->i_mapping);
 		filemap_fdatawrite(inode->i_mapping);
 		filemap_fdatawait(inode->i_mapping);
 		smb_close(inode);
--- 2.5.31/fs/smbfs/inode.c~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/fs/smbfs/inode.c	Sun Aug 11 00:20:35 2002
@@ -650,7 +650,6 @@ smb_notify_change(struct dentry *dentry,
 			DENTRY_PATH(dentry),
 			(long) inode->i_size, (long) attr->ia_size);
 
-		filemap_fdatawait(inode->i_mapping);
 		filemap_fdatawrite(inode->i_mapping);
 		filemap_fdatawait(inode->i_mapping);
 
--- 2.5.31/mm/msync.c~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/mm/msync.c	Sun Aug 11 00:20:35 2002
@@ -145,10 +145,7 @@ static int msync_interval(struct vm_area
 			int err;
 
 			down(&inode->i_sem);
-			ret = filemap_fdatawait(inode->i_mapping);
-			err = filemap_fdatawrite(inode->i_mapping);
-			if (!ret)
-				ret = err;
+			ret = filemap_fdatawrite(inode->i_mapping);
 			if (flags & MS_SYNC) {
 				if (file->f_op && file->f_op->fsync) {
 					err = file->f_op->fsync(file, file->f_dentry, 1);
--- 2.5.31/mm/page-writeback.c~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/mm/page-writeback.c	Sun Aug 11 00:20:35 2002
@@ -350,10 +350,15 @@ int generic_vm_writeback(struct page *pa
 #if 0
 		if (!PageWriteback(page) && PageDirty(page)) {
 			lock_page(page);
-			if (!PageWriteback(page) && TestClearPageDirty(page))
-				page->mapping->a_ops->writepage(page);
-			else
+			if (!PageWriteback(page) && TestClearPageDirty(page)) {
+				int ret;
+
+				ret = page->mapping->a_ops->writepage(page);
+				if (ret == -EAGAIN)
+					__set_page_dirty_nobuffers(page);
+			} else {
 				unlock_page(page);
+			}
 		}
 #endif
 	}
@@ -395,6 +400,10 @@ int write_one_page(struct page *page, in
 		page_cache_get(page);
 		write_unlock(&mapping->page_lock);
 		ret = mapping->a_ops->writepage(page);
+		if (ret == -EAGAIN) {
+			__set_page_dirty_nobuffers(page);
+			ret = 0;
+		}
 		if (ret == 0 && wait) {
 			wait_on_page_writeback(page);
 			if (PageError(page))
--- 2.5.31/fs/ext3/inode.c~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/fs/ext3/inode.c	Sun Aug 11 00:20:45 2002
@@ -1344,10 +1344,11 @@ out_fail:
 
 	/*
 	 * We have to fail this writepage to avoid cross-fs transactions.
-	 * Put the page back on mapping->dirty_pages, but leave its buffer's
-	 * dirty state as-is.
+	 * Return EAGAIN so the caller will the page back on
+	 * mapping->dirty_pages.  The page's buffers' dirty state will be left
+	 * as-is.
 	 */
-	__set_page_dirty_nobuffers(page);
+	ret = -EAGAIN;
 	unlock_page(page);
 	return ret;
 }
@@ -1378,9 +1379,9 @@ static int ext3_releasepage(struct page 
 
 
 struct address_space_operations ext3_aops = {
-	.readpage	= ext3_readpage,		/* BKL not held.  Don't need */
-	.readpages	= ext3_readpages,		/* BKL not held.  Don't need */
-	.writepage	= ext3_writepage,		/* BKL not held.  We take it */
+	.readpage	= ext3_readpage,	/* BKL not held.  Don't need */
+	.readpages	= ext3_readpages,	/* BKL not held.  Don't need */
+	.writepage	= ext3_writepage,	/* BKL not held.  We take it */
 	.sync_page	= block_sync_page,
 	.prepare_write	= ext3_prepare_write,	/* BKL not held.  We take it */
 	.commit_write	= ext3_commit_write,	/* BKL not held.  We take it */
@@ -1405,9 +1406,9 @@ ext3_writepages(struct address_space *ma
 }
 
 struct address_space_operations ext3_writeback_aops = {
-	.readpage	= ext3_readpage,		/* BKL not held.  Don't need */
-	.readpages	= ext3_readpages,		/* BKL not held.  Don't need */
-	.writepage	= ext3_writepage,		/* BKL not held.  We take it */
+	.readpage	= ext3_readpage,	/* BKL not held.  Don't need */
+	.readpages	= ext3_readpages,	/* BKL not held.  Don't need */
+	.writepage	= ext3_writepage,	/* BKL not held.  We take it */
 	.writepages	= ext3_writepages,	/* BKL not held.  Don't need */
 	.sync_page	= block_sync_page,
 	.prepare_write	= ext3_prepare_write,	/* BKL not held.  We take it */
--- 2.5.31/fs/udf/inode.c~writeback-sync	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/fs/udf/inode.c	Sun Aug 11 00:20:35 2002
@@ -208,7 +208,8 @@ void udf_expand_file_adinicb(struct inod
 	mark_buffer_dirty_inode(bh, inode);
 	udf_release_data(bh);
 
-	inode->i_data.a_ops->writepage(page);
+	if (inode->i_data.a_ops->writepage(page) == -EAGAIN)
+		__set_page_dirty_nobuffers(page);
 	page_cache_release(page);
 
 	mark_inode_dirty(inode);

.
