Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUCRIdk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 03:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUCRIdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 03:33:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:62940 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262003AbUCRIdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 03:33:31 -0500
Date: Thu, 18 Mar 2004 00:33:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeffrey Siegal <jbs@quiotix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is fsync so much slower than O_SYNC?
Message-Id: <20040318003335.6bf3eb41.akpm@osdl.org>
In-Reply-To: <40587F90.1040903@quiotix.com>
References: <40587F90.1040903@quiotix.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Siegal <jbs@quiotix.com> wrote:
>
> This is on FC1 with Fedora/Red Hat's 2.4.22-1.2174.nptlsmp kernel, 
>  writing to an ext3 file system (journal=ordered) on a 7200rpm IDE drive.
> 
>  O_SYNC:
>  Creating
>  Starting
>  iter = 1000, latency = 8.413535ms
> 
>  O_DSYNC:
>  Creating
>  Starting
>  iter = 1000, latency = 8.429431ms
> 
>  fsync:
>  Creating
>  Starting
>  iter = 1000, latency = 34.499984ms
> 
>  fdatasync:
>  Creating
>  Starting
>  iter = 1000, latency = 35.568508ms

This is because ext3 is being dumb.  It is forcing a journal commit even
when the inode has not been altered.

Here's a moderately-tested 2.6 fix.  A 2.4 fix would be similar.


File overwrite:

	vmm:/mnt/hda5> ~/fsync-is-sucky 
	O_SYNC:
	Creating
	Starting
	iter = 1000, latency = 0.191464ms

	O_DSYNC:
	Creating
	Starting
	iter = 1000, latency = 0.181637ms

	fsync:
	Creating
	Starting
	iter = 1000, latency = 0.186326ms

	fdatasync:
	Creating
	Starting
	iter = 1000, latency = 0.193013ms

File append:

	vmm:/mnt/hda5> ~/fsync-is-sucky 1
	O_SYNC:
	Starting
	iter = 1000, latency = 6.169613ms

	O_DSYNC:
	Starting
	iter = 1000, latency = 6.131574ms

	fsync:
	Starting
	iter = 1000, latency = 6.140611ms

	fdatasync:
	Starting
	iter = 1000, latency = 6.111737ms



---

 25-akpm/fs/ext3/fsync.c     |   38 ++++++++++++++++++++++++++++----------
 25-akpm/fs/fs-writeback.c   |   36 +++++++++++++++++++++++++++++++-----
 25-akpm/include/linux/fs.h  |    1 +
 25-akpm/mm/page-writeback.c |    2 ++
 4 files changed, 62 insertions(+), 15 deletions(-)

diff -puN fs/ext3/fsync.c~ext3-fsync-speedup fs/ext3/fsync.c
--- 25/fs/ext3/fsync.c~ext3-fsync-speedup	2004-03-17 23:35:29.679572200 -0800
+++ 25-akpm/fs/ext3/fsync.c	2004-03-18 00:25:20.604882440 -0800
@@ -24,6 +24,8 @@
 
 #include <linux/time.h>
 #include <linux/fs.h>
+#include <linux/sched.h>
+#include <linux/writeback.h>
 #include <linux/jbd.h>
 #include <linux/ext3_fs.h>
 #include <linux/ext3_jbd.h>
@@ -38,29 +40,28 @@
  *
  * What we do is just kick off a commit and wait on it.  This will snapshot the
  * inode to disk.
- *
- * Note that there is a serious optimisation we can make here: if the current
- * inode is not part of j_running_transaction or j_committing_transaction
- * then we have nothing to do.  That would require implementation of t_ilist,
- * which isn't too hard.
  */
 
 int ext3_sync_file(struct file * file, struct dentry *dentry, int datasync)
 {
 	struct inode *inode = dentry->d_inode;
+	int ret = 0;
 
 	J_ASSERT(ext3_journal_current_handle() == 0);
 
+	smp_mb();		/* prepare for lockless i_state read */
+	if (!(inode->i_state & I_DIRTY))
+		goto out;
+
 	/*
 	 * data=writeback:
 	 *  The caller's filemap_fdatawrite()/wait will sync the data.
-	 *  ext3_force_commit() will sync the metadata
+	 *  sync_inode() will sync the metadata
 	 *
 	 * data=ordered:
 	 *  The caller's filemap_fdatawrite() will write the data and
-	 *  ext3_force_commit() will wait on the buffers.  Then the caller's
-	 *  filemap_fdatawait() will wait on the pages (but all IO is complete)
-	 *  Not pretty, but it works.
+	 *  sync_inode() will write the inode if it is dirty.  Then the caller's
+	 *  filemap_fdatawait() will wait on the pages.
 	 *
 	 * data=journal:
 	 *  filemap_fdatawrite won't do anything (the buffers are clean).
@@ -70,5 +71,22 @@ int ext3_sync_file(struct file * file, s
 	 *  (they were dirtied by commit).  But that's OK - the blocks are
 	 *  safe in-journal, which is all fsync() needs to ensure.
 	 */
-	return ext3_force_commit(inode->i_sb);
+	if (ext3_should_journal_data(inode)) {
+		ret = ext3_force_commit(inode->i_sb);
+		goto out;
+	}
+
+	/*
+	 * The VFS has written the file data.  If the inode is unaltered
+	 * then we need not start a commit.
+	 */
+	if (inode->i_state & (I_DIRTY_SYNC|I_DIRTY_DATASYNC)) {
+		struct writeback_control wbc = {
+			.sync_mode = WB_SYNC_ALL,
+			.nr_to_write = 0, /* sys_fsync did this */
+		};
+		ret = sync_inode(inode, &wbc);
+	}
+out:
+	return ret;
 }
diff -puN fs/fs-writeback.c~ext3-fsync-speedup fs/fs-writeback.c
--- 25/fs/fs-writeback.c~ext3-fsync-speedup	2004-03-17 23:35:29.680572048 -0800
+++ 25-akpm/fs/fs-writeback.c	2004-03-18 00:32:32.548217072 -0800
@@ -131,13 +131,14 @@ static void write_inode(struct inode *in
  *
  * Called under inode_lock.
  */
-static void
+static int
 __sync_single_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	unsigned dirty;
 	struct address_space *mapping = inode->i_mapping;
 	struct super_block *sb = inode->i_sb;
 	int wait = wbc->sync_mode == WB_SYNC_ALL;
+	int ret;
 
 	BUG_ON(inode->i_state & I_LOCK);
 
@@ -158,14 +159,17 @@ __sync_single_inode(struct inode *inode,
 	spin_unlock(&mapping->page_lock);
 	spin_unlock(&inode_lock);
 
-	do_writepages(mapping, wbc);
+	ret = do_writepages(mapping, wbc);
 
 	/* Don't write the inode if only I_DIRTY_PAGES was set */
 	if (dirty & (I_DIRTY_SYNC | I_DIRTY_DATASYNC))
 		write_inode(inode, wait);
 
-	if (wait)
-		filemap_fdatawait(mapping);
+	if (wait) {
+		int err = filemap_fdatawait(mapping);
+		if (ret == 0)
+			ret = err;
+	}
 
 	spin_lock(&inode_lock);
 	inode->i_state &= ~I_LOCK;
@@ -189,6 +193,7 @@ __sync_single_inode(struct inode *inode,
 		}
 	}
 	wake_up_inode(inode);
+	return ret;
 }
 
 /*
@@ -493,10 +498,31 @@ void write_inode_now(struct inode *inode
 	if (sync)
 		wait_on_inode(inode);
 }
-
 EXPORT_SYMBOL(write_inode_now);
 
 /**
+ * sync_inode - write an inode and its pages to disk.
+ * @inode: the inode to sync
+ * @wbc: controls the writeback mode
+ *
+ * sync_inode() will write an inode and its pages to disk.  It will also
+ * correctly update the inode on its superblock's disty inode lists and will
+ * update inode->i_state.
+ *
+ * The caller must have a ref on the inode.
+ */
+int sync_inode(struct inode *inode, struct writeback_control *wbc)
+{
+	int ret;
+
+	spin_lock(&inode_lock);
+	ret = __sync_single_inode(inode, wbc);
+	spin_unlock(&inode_lock);
+	return ret;
+}
+EXPORT_SYMBOL(sync_inode);
+
+/**
  * generic_osync_inode - flush all dirty data for a given inode to disk
  * @inode: inode to write
  * @what:  what to write and wait upon
diff -puN include/linux/fs.h~ext3-fsync-speedup include/linux/fs.h
--- 25/include/linux/fs.h~ext3-fsync-speedup	2004-03-17 23:35:29.682571744 -0800
+++ 25-akpm/include/linux/fs.h	2004-03-17 23:35:29.687570984 -0800
@@ -919,6 +919,7 @@ static inline void mark_inode_dirty_sync
 	__mark_inode_dirty(inode, I_DIRTY_SYNC);
 }
 
+int sync_inode(struct inode *inode, struct writeback_control *wbc);
 
 /**
  * &export_operations - for nfsd to communicate with file systems
diff -puN mm/page-writeback.c~ext3-fsync-speedup mm/page-writeback.c
--- 25/mm/page-writeback.c~ext3-fsync-speedup	2004-03-17 23:35:29.683571592 -0800
+++ 25-akpm/mm/page-writeback.c	2004-03-17 23:35:29.688570832 -0800
@@ -486,6 +486,8 @@ void __init page_writeback_init(void)
 
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
+	if (wbc->nr_to_write <= 0)
+		return 0;
 	if (mapping->a_ops->writepages)
 		return mapping->a_ops->writepages(mapping, wbc);
 	return generic_writepages(mapping, wbc);

_

