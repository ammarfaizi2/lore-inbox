Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751913AbWCVBLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbWCVBLU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 20:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbWCVBLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 20:11:19 -0500
Received: from fmr20.intel.com ([134.134.136.19]:31972 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751913AbWCVBLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 20:11:16 -0500
Date: Tue, 21 Mar 2006 17:10:36 -0800
From: Valerie Henson <val_henson@linux.intel.com>
To: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Cc: Arjan van de Ven <arjan@linux.intel.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Zach Brown <zach.brown@oracle.com>
Subject: [RFC] [PATCH] Reducing average ext2 fsck time through fs-wide dirty bit]
Message-ID: <20060322011034.GP12571@goober>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am working on reducing the average time spent on fscking ext2 file
systems.  My initial take on the problem is to avoid fscking when the
file system is not being modified.  If we're not actively modifying
the file system when we crash, it seems intuitive that we could avoid
fsck on next mount.  The obvious way to implement this is to add a
clean/dirty bit to the superblock, check every so often to see if the
file system is not being written, sync out all outstanding writes, and
mark the file system clean.  On boot, fsck should check for the clean
bit and mark the file system as valid, thereby avoiding a full fsck.
I call this the fs-wide dirty bit solution.

Our intuition is not quite right on at least two points: (1) orphan
inodes, (2) preallocated blocks.  To solve the orphan inode problem, I
ported the ext3 orphan inode code to ext2.  Fsck does orphan inode
recovery without regard to whether the file system is ext2 or ext3, so
it Just Works with existing fsck.  Solving the preallocated blocks
problem is a little harder.  When ext2 preallocates blocks, it ends up
writing the block pointers and allocated bits to disk.  The extra
preallocated blocks are cleaned up when fsck checks the number of
blocks against i_size.  Adding all inodes with preallocated blocks to
the orphan inode list is obviously wrong.  Ted and Arjan both
suggested porting Mingming Cao's ext3 reservation window code to ext2
to solve this, which I will look into.

The combination of the orphan inode and preallocation blocks problem
led me to another idea: create in-memory-only allocation bitmaps for
both inodes and blocks.  These bitmaps would track blocks and inodes
allocated only for the life of this mount (or a file open) in memory
rather than on disk.  I haven't implemented this yet but I think it is
a promising approach.

The current version of the fs-wide dirty bit patch is included below.
This is an RFC-only patch.  It does not handle preallocated blocks, so
full fsck must still be run, and it still uses the orphan inode list
instead of an in-memory-only inode allocation bitmap.  I have only
tested it on UML; don't use it on any file system you consider
valuable.

Comments, criticisms, new ideas, old ideas I have forgotten, welcome.

Thanks to Zach Brown, Ted T'so, and Arjan Van de Ven for various
discussions and other help while I was writing these patches.

Patch is against 2.6.16-rc5-mm3.

-VAL

diff -x '*~' -uNr vanilla-linux/fs/ext2/balloc.c uml-clean/fs/ext2/balloc.c
--- vanilla-linux/fs/ext2/balloc.c	2006-03-07 16:17:00.000000000 -0800
+++ uml-clean/fs/ext2/balloc.c	2006-03-08 16:21:30.000000000 -0800
@@ -140,9 +140,10 @@
 	}
 }
 
-static int group_reserve_blocks(struct ext2_sb_info *sbi, int group_no,
+static int group_reserve_blocks(struct super_block *sb, int group_no,
 	struct ext2_group_desc *desc, struct buffer_head *bh, int count)
 {
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	unsigned free_blocks;
 
 	if (!desc->bg_free_blocks_count)
@@ -154,6 +155,7 @@
 		count = free_blocks;
 	desc->bg_free_blocks_count = cpu_to_le16(free_blocks - count);
 	spin_unlock(sb_bgl_lock(sbi, group_no));
+	ext2_mark_fs_dirty(sb);
 	mark_buffer_dirty(bh);
 	return count;
 }
@@ -170,6 +172,7 @@
 		desc->bg_free_blocks_count = cpu_to_le16(free_blocks + count);
 		spin_unlock(sb_bgl_lock(sbi, group_no));
 		sb->s_dirt = 1;
+		ext2_mark_fs_dirty(sb);
 		mark_buffer_dirty(bh);
 	}
 }
@@ -245,6 +248,7 @@
 		}
 	}
 
+	ext2_mark_fs_dirty(sb);
 	mark_buffer_dirty(bitmap_bh);
 	if (sb->s_flags & MS_SYNCHRONOUS)
 		sync_dirty_buffer(bitmap_bh);
@@ -378,7 +382,7 @@
 		goto io_error;
 	}
 
-	group_alloc = group_reserve_blocks(sbi, group_no, desc,
+	group_alloc = group_reserve_blocks(sb, group_no, desc,
 					gdp_bh, es_alloc);
 	if (group_alloc) {
 		ret_block = ((goal - le32_to_cpu(es->s_first_data_block)) %
@@ -414,7 +418,7 @@
 		desc = ext2_get_group_desc(sb, group_no, &gdp_bh);
 		if (!desc)
 			goto io_error;
-		group_alloc = group_reserve_blocks(sbi, group_no, desc,
+		group_alloc = group_reserve_blocks(sb, group_no, desc,
 						gdp_bh, es_alloc);
 	}
 	if (!group_alloc) {
@@ -500,6 +504,7 @@
 	}
 	write_unlock(&EXT2_I(inode)->i_meta_lock);
 
+	ext2_mark_fs_dirty(sb);
 	mark_buffer_dirty(bitmap_bh);
 	if (sb->s_flags & MS_SYNCHRONOUS)
 		sync_dirty_buffer(bitmap_bh);
diff -x '*~' -uNr vanilla-linux/fs/ext2/dir.c uml-clean/fs/ext2/dir.c
--- vanilla-linux/fs/ext2/dir.c	2006-03-07 16:25:43.000000000 -0800
+++ uml-clean/fs/ext2/dir.c	2006-03-08 16:21:30.000000000 -0800
@@ -67,6 +67,7 @@
 	struct inode *dir = page->mapping->host;
 	int err = 0;
 	dir->i_version++;
+	ext2_mark_fs_dirty(dir->i_sb);
 	page->mapping->a_ops->commit_write(NULL, page, from, to);
 	if (IS_DIRSYNC(dir))
 		err = write_one_page(page, 1);
diff -x '*~' -uNr vanilla-linux/fs/ext2/ext2.h uml-clean/fs/ext2/ext2.h
--- vanilla-linux/fs/ext2/ext2.h	2006-03-07 16:25:43.000000000 -0800
+++ uml-clean/fs/ext2/ext2.h	2006-03-16 22:17:05.000000000 -0800
@@ -66,6 +66,7 @@
 #endif
 	rwlock_t i_meta_lock;
 	struct inode	vfs_inode;
+	struct list_head i_orphan;	/* unlinked but open inodes */
 };
 
 /*
@@ -148,6 +149,14 @@
 	__attribute__ ((format (printf, 3, 4)));
 extern void ext2_update_dynamic_rev (struct super_block *sb);
 extern void ext2_write_super (struct super_block *);
+extern void ext2_prepare_super (struct super_block *);
+extern void __ext2_mark_fs_clean (struct super_block *);
+extern void ext2_mark_fs_dirty (struct super_block *);
+extern void ext2_mark_inode_dirty (struct inode *);
+extern void ext2_orphan_add(struct inode *);
+extern void ext2_orphan_del(struct inode *);
+/* XXX Gross */
+#define mark_inode_dirty(x) ext2_mark_inode_dirty(x)
 
 /*
  * Inodes and files operations
@@ -173,3 +182,7 @@
 /* symlink.c */
 extern struct inode_operations ext2_fast_symlink_inode_operations;
 extern struct inode_operations ext2_symlink_inode_operations;
+
+/* state.c */
+extern void ext2_dirtyd_start_thread(struct super_block *sb);
+extern void ext2_dirtyd_kill_thread(struct super_block *sb);
diff -x '*~' -uNr vanilla-linux/fs/ext2/ialloc.c uml-clean/fs/ext2/ialloc.c
--- vanilla-linux/fs/ext2/ialloc.c	2006-03-07 16:17:00.000000000 -0800
+++ uml-clean/fs/ext2/ialloc.c	2006-03-08 16:21:30.000000000 -0800
@@ -85,6 +85,7 @@
 	if (dir)
 		percpu_counter_dec(&EXT2_SB(sb)->s_dirs_counter);
 	sb->s_dirt = 1;
+	ext2_mark_fs_dirty(sb);
 	mark_buffer_dirty(bh);
 }
 
@@ -154,6 +155,7 @@
 			      "bit already cleared for inode %lu", ino);
 	else
 		ext2_release_inode(sb, block_group, is_directory);
+	ext2_mark_fs_dirty(sb);
 	mark_buffer_dirty(bitmap_bh);
 	if (sb->s_flags & MS_SYNCHRONOUS)
 		sync_dirty_buffer(bitmap_bh);
@@ -528,6 +530,7 @@
 	err = -ENOSPC;
 	goto fail;
 got:
+	ext2_mark_fs_dirty(sb);
 	mark_buffer_dirty(bitmap_bh);
 	if (sb->s_flags & MS_SYNCHRONOUS)
 		sync_dirty_buffer(bitmap_bh);
@@ -562,6 +565,7 @@
 	spin_unlock(sb_bgl_lock(sbi, group));
 
 	sb->s_dirt = 1;
+	ext2_mark_fs_dirty(sb);
 	mark_buffer_dirty(bh2);
 	inode->i_uid = current->fsuid;
 	if (test_opt (sb, GRPID))
diff -x '*~' -uNr vanilla-linux/fs/ext2/inode.c uml-clean/fs/ext2/inode.c
--- vanilla-linux/fs/ext2/inode.c	2006-03-07 16:25:43.000000000 -0800
+++ uml-clean/fs/ext2/inode.c	2006-03-09 01:07:13.000000000 -0800
@@ -75,6 +75,7 @@
 
 	if (is_bad_inode(inode))
 		goto no_delete;
+	ext2_orphan_del(inode);
 	EXT2_I(inode)->i_dtime	= get_seconds();
 	mark_inode_dirty(inode);
 	ext2_update_inode(inode, inode_needs_sync(inode));
@@ -1121,6 +1122,7 @@
 	 */
 	for (n = 0; n < EXT2_N_BLOCKS; n++)
 		ei->i_data[n] = raw_inode->i_block[n];
+	INIT_LIST_HEAD(&ei->i_orphan);
 
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &ext2_file_inode_operations;
diff -x '*~' -uNr vanilla-linux/fs/ext2/Makefile uml-clean/fs/ext2/Makefile
--- vanilla-linux/fs/ext2/Makefile	2006-01-02 19:21:10.000000000 -0800
+++ uml-clean/fs/ext2/Makefile	2006-03-16 22:16:47.000000000 -0800
@@ -5,7 +5,7 @@
 obj-$(CONFIG_EXT2_FS) += ext2.o
 
 ext2-y := balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
-	  ioctl.o namei.o super.o symlink.o
+	  ioctl.o namei.o super.o symlink.o state.o
 
 ext2-$(CONFIG_EXT2_FS_XATTR)	 += xattr.o xattr_user.o xattr_trusted.o
 ext2-$(CONFIG_EXT2_FS_POSIX_ACL) += acl.o
diff -x '*~' -uNr vanilla-linux/fs/ext2/namei.c uml-clean/fs/ext2/namei.c
--- vanilla-linux/fs/ext2/namei.c	2006-03-07 16:25:43.000000000 -0800
+++ uml-clean/fs/ext2/namei.c	2006-03-10 01:23:52.000000000 -0800
@@ -267,6 +267,8 @@
 
 	inode->i_ctime = dir->i_ctime;
 	inode_dec_link_count(inode);
+	if (!inode->i_nlink)
+		ext2_orphan_add(inode);
 	err = 0;
 out:
 	return err;
@@ -328,6 +330,8 @@
 		if (dir_de)
 			new_inode->i_nlink--;
 		inode_dec_link_count(new_inode);
+		if (!new_inode->i_nlink)
+			ext2_orphan_add(new_inode);
 	} else {
 		if (dir_de) {
 			err = -EMLINK;
diff -x '*~' -uNr vanilla-linux/fs/ext2/state.c uml-clean/fs/ext2/state.c
--- vanilla-linux/fs/ext2/state.c	1969-12-31 16:00:00.000000000 -0800
+++ uml-clean/fs/ext2/state.c	2006-03-16 21:41:30.000000000 -0800
@@ -0,0 +1,135 @@
+/*
+ * Kernel thread to keep track of clean/dirty state of ext2 file system
+ */
+#include "ext2.h"
+
+#define EXT2_DIRTY_TIMEOUT 1	/* Time in secs to check for dirty */
+#define EXT2_DIRTY_JIFFIES (EXT2_DIRTY_TIMEOUT * HZ)
+
+extern void sys_sync(void);	/* XXX Gross */
+
+/*
+ * ext2_update_state runs periodically to check to see if the file
+ * system has any ongoing write traffic.  If no one has written to the
+ * file system recently, then we sync the file system and check if any
+ * metadata writes occurred while we were doing the sync.  If no
+ * writes occurred, we go ahead and mark the file system clean.  Any
+ * operation that changes the metadata must first mark the file system
+ * dirty (via ext2_mark_fs_dirty()) before any other writes hit disk.
+ *
+ * For debugging and measurement, we are keeping some statistics on
+ * how often the file system is dirty/clean in any given period in the
+ * superblock.  They will go away if this hits production.
+ *
+ * FIXME: We are using sys_sync() here.  We really need to sync only
+ * this file system instead of all file systems.
+ */
+
+static void ext2_update_state(struct super_block *sb)
+{
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+	struct ext2_super_block *es = EXT2_SB(sb)->s_es;
+
+	lock_super(sb);
+	sb->s_dirt = 1;
+	if (sbi->s_dirty_lately == EXT2_FS_DIRTY) {
+		es->s_dirty_count =
+			cpu_to_le32(le32_to_cpu(es->s_dirty_count) + 1);
+		/* Reset our dirty flag for the next interval */
+		sbi->s_dirty_lately = EXT2_FS_CLEAN;
+	} else {
+		es->s_clean_count =
+			cpu_to_le32(le32_to_cpu(es->s_clean_count) + 1);
+		/*
+		 * This fs has not been written to recently.  If it is
+		 * currently marked dirty, sync all outstanding writes
+		 * and see if we are still clean.  If so, mark the fs
+		 * clean.
+		 */
+		if (es->s_fs_dirty != EXT2_FS_CLEAN) {
+			unlock_super(sb);
+			/* Sync all outstanding writes to file system */
+			sys_sync(); /* XXX Hack-o-rama - syncs all fs's */
+			lock_super(sb);
+			/* New writes may have occurred during the
+			 * sync, recheck */
+			if (sbi->s_dirty_lately == EXT2_FS_CLEAN)
+				__ext2_mark_fs_clean(sb);
+			else
+				printk(KERN_DEBUG "fs dirtied during sync\n");
+		}
+		/*
+		 * We don't flush the superblock if the file system
+		 * was already marked clean.  Otherwise we'll be
+		 * writing to the disk continuously while the file
+		 * system is idle.  This means the stats won't
+		 * necessarily get written to disk until the fs is
+		 * unmounted.
+		 */
+	}
+	unlock_super(sb);
+}
+
+static void ext2_print_stats(struct super_block *sb)
+{
+	struct ext2_super_block *es = EXT2_SB(sb)->s_es;
+	unsigned int clean, dirty, total, percent;
+
+	clean = le32_to_cpu(es->s_clean_count);
+	dirty = le32_to_cpu(es->s_dirty_count);
+	total = dirty + clean;
+
+	if (total == 0)
+		percent = 0;
+	else
+		percent = (clean * 100) / total;
+	/* XXX add fs mount point */
+	printk(KERN_DEBUG "ext2: dirty:%u clean:%u total:%u percent clean: %u\n",
+	       dirty, clean, total, percent);
+}
+
+static int ext2_dirtyd(void *arg)
+{
+	struct super_block *sb = (struct super_block *) arg;
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+
+	daemonize("ext2_dirtyd");
+
+	printk(KERN_INFO "ext2_dirtyd starting, interval %d seconds\n",
+	       EXT2_DIRTY_TIMEOUT);
+
+	init_waitqueue_head(&sbi->s_wait);
+	sbi->s_process = current;
+	ext2_print_stats(sb);
+
+	while (1) {
+		schedule_timeout_interruptible(EXT2_DIRTY_JIFFIES);
+		if (sbi->s_quit)
+			break;
+		if (freezing(current)) {
+			refrigerator();
+		}
+		ext2_update_state(sb);
+	} 
+
+	ext2_print_stats(sb);
+	sbi->s_done = 1;
+	wake_up(&sbi->s_wait);
+
+	return 0;
+}
+
+void ext2_dirtyd_start_thread(struct super_block *sb)
+{
+	kernel_thread(ext2_dirtyd, sb, CLONE_VM|CLONE_FS|CLONE_FILES);
+}
+
+void ext2_dirtyd_kill_thread(struct super_block *sb)
+{
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+
+	sbi->s_quit = 1;
+	wake_up_process(sbi->s_process);
+	wait_event(sbi->s_wait, sbi->s_done != 0);
+}
+
diff -x '*~' -uNr vanilla-linux/fs/ext2/super.c uml-clean/fs/ext2/super.c
--- vanilla-linux/fs/ext2/super.c	2006-03-07 16:25:43.000000000 -0800
+++ uml-clean/fs/ext2/super.c	2006-03-16 22:37:57.000000000 -0800
@@ -113,6 +113,7 @@
 	int i;
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 
+	ext2_dirtyd_kill_thread(sb);
 	ext2_xattr_put_super(sb);
 	if (!(sb->s_flags & MS_RDONLY)) {
 		struct ext2_super_block *es = sbi->s_es;
@@ -129,6 +130,7 @@
 	percpu_counter_destroy(&sbi->s_freeblocks_counter);
 	percpu_counter_destroy(&sbi->s_freeinodes_counter);
 	percpu_counter_destroy(&sbi->s_dirs_counter);
+	kfree(sbi->s_esp);
 	brelse (sbi->s_sbh);
 	sb->s_fs_info = NULL;
 	kfree(sbi);
@@ -164,6 +166,7 @@
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
 		rwlock_init(&ei->i_meta_lock);
+		INIT_LIST_HEAD(&ei->i_orphan);
 #ifdef CONFIG_EXT2_FS_XATTR
 		init_rwsem(&ei->xattr_sem);
 #endif
@@ -649,9 +652,23 @@
 	/*
 	 * Note: s_es must be initialized as soon as possible because
 	 *       some ext2 macro-instructions depend on its value
+	 *
+	 * We used to operate on the on-disk superblock directly
+	 * inside the buffer in the superblock bh.  However, now that
+	 * we need to do an asynchronous write of the superblock, we
+	 * have to allocate a separate in-memory buffer for the
+	 * superblock.  For simplicity, we allocate a buffer that is
+	 * as large as device block size and then set the sbi->s_es
+	 * pointer to the beginning of the superblock inside the
+	 * buffer. -VAL
 	 */
-	es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
-	sbi->s_es = es;
+	sbi->s_esp = kmalloc(bh->b_size, GFP_KERNEL);
+	if (!sbi->s_esp)
+		goto failed_sbi;
+	memcpy(sbi->s_esp, bh->b_data, bh->b_size);
+	sbi->s_es = (struct ext2_super_block *) sbi->s_esp + offset;
+	es = sbi->s_es;
+
 	sb->s_magic = le16_to_cpu(es->s_magic);
 
 	if (sb->s_magic != EXT2_SUPER_MAGIC)
@@ -726,6 +743,7 @@
 	/* If the blocksize doesn't match, re-read the thing.. */
 	if (sb->s_blocksize != blocksize) {
 		brelse(bh);
+		kfree(sbi->s_esp);
 
 		if (!sb_set_blocksize(sb, blocksize)) {
 			printk(KERN_ERR "EXT2-fs: blocksize too small for device.\n");
@@ -740,8 +758,13 @@
 			       "2nd try.\n");
 			goto failed_sbi;
 		}
-		es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
-		sbi->s_es = es;
+		sbi->s_esp = kmalloc(bh->b_size, GFP_KERNEL);
+		if (!sbi->s_esp)
+			goto failed_sbi;
+		memcpy(sbi->s_esp, bh->b_data, bh->b_size);
+		sbi->s_es = (struct ext2_super_block *) sbi->s_esp + offset;
+		es = sbi->s_es;
+
 		if (es->s_magic != cpu_to_le16(EXT2_SUPER_MAGIC)) {
 			printk ("EXT2-fs: Magic mismatch, very weird !\n");
 			goto failed_mount;
@@ -894,6 +917,8 @@
 				ext2_count_free_inodes(sb));
 	percpu_counter_mod(&sbi->s_dirs_counter,
 				ext2_count_dirs(sb));
+	INIT_LIST_HEAD(&sbi->s_orphan);
+	ext2_dirtyd_start_thread(sb); /* XXX be smarter about starting/stopping */
 	return 0;
 
 cantfind_ext2:
@@ -910,27 +935,79 @@
 	kfree(sbi->s_debts);
 failed_mount:
 	brelse(bh);
+	kfree(sbi->s_esp);
 failed_sbi:
 	sb->s_fs_info = NULL;
 	kfree(sbi);
 	return -EINVAL;
 }
 
+/*
+ * Helper function to copy the in-memory superblock into the buffer
+ * used to write it to disk.
+ */
+
+void ext2_prepare_super(struct super_block * sb)
+{
+	struct buffer_head *bh = EXT2_SB(sb)->s_sbh;
+	char *esp = EXT2_SB(sb)->s_esp;
+
+	lock_buffer(bh);
+	memcpy(bh->b_data, esp, bh->b_size);
+	unlock_buffer(bh);
+}
+
 static void ext2_commit_super (struct super_block * sb,
 			       struct ext2_super_block * es)
 {
+	struct buffer_head *bh = EXT2_SB(sb)->s_sbh;
+
 	es->s_wtime = cpu_to_le32(get_seconds());
-	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
+	ext2_prepare_super(sb);
+	mark_buffer_dirty(bh);
 	sb->s_dirt = 0;
 }
 
+static void ext2_end_async_io(struct buffer_head *bh, int uptodate)
+{
+	/* XXX Deal with failed write of dirty fs bit? */
+	if (uptodate)
+		set_buffer_uptodate(bh);
+	else
+		clear_buffer_uptodate(bh);
+	unlock_buffer(bh);
+}
+
+/*
+ * Submit the superblock for writing, but don't wait - we only need a
+ * write barrier here (has to hit disk after previous writes and
+ * before any subsequent writes).
+ */
+static
+void ext2_write_super_async(struct super_block *sb, struct ext2_super_block *es)
+{
+	struct buffer_head *bh = EXT2_SB(sb)->s_sbh;
+	char *esp = EXT2_SB(sb)->s_esp;
+
+	lock_buffer(bh);
+	bh->b_end_io = ext2_end_async_io;
+	clear_buffer_dirty(bh);
+	memcpy(bh->b_data, esp, bh->b_size);
+	submit_bh(WRITE_BARRIER, bh);
+	sb->s_dirt = 0;
+	/* bh unlocked in end io function */
+}
+	
 static void ext2_sync_super(struct super_block *sb, struct ext2_super_block *es)
 {
+	struct buffer_head *bh = EXT2_SB(sb)->s_sbh;
+
 	es->s_free_blocks_count = cpu_to_le32(ext2_count_free_blocks(sb));
 	es->s_free_inodes_count = cpu_to_le32(ext2_count_free_inodes(sb));
 	es->s_wtime = cpu_to_le32(get_seconds());
-	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
-	sync_dirty_buffer(EXT2_SB(sb)->s_sbh);
+	ext2_prepare_super(sb);
+	mark_buffer_dirty(bh);
+	sync_dirty_buffer(bh);
 	sb->s_dirt = 0;
 }
 
@@ -943,12 +1020,19 @@
  * flags to 0.  We need to set this flag to 0 since the fs
  * may have been checked while mounted and e2fsck may have
  * set s_state to EXT2_VALID_FS after some corrections.
+ *
+ * Now we are keeping a copy of the superblock elsewhere in memory
+ * (pointed to by sbi->s_es, and copying it into the buffer on need
+ * (see ext2_prepare_super()).  This is so we can use the superblock
+ * to contain the fs-wide dirty bit.  We need to be able to submit an
+ * asynchronous I/O to update this bit without having the superblock
+ * information change while it is in flight. -VAL
  */
 
 void ext2_write_super (struct super_block * sb)
 {
 	struct ext2_super_block * es;
-	lock_kernel();
+	lock_kernel(); /* XXX Need to lock_kernel() when writing sb?? */
 	if (!(sb->s_flags & MS_RDONLY)) {
 		es = EXT2_SB(sb)->s_es;
 
@@ -956,8 +1040,10 @@
 			ext2_debug ("setting valid to 0\n");
 			es->s_state = cpu_to_le16(le16_to_cpu(es->s_state) &
 						  ~EXT2_VALID_FS);
-			es->s_free_blocks_count = cpu_to_le32(ext2_count_free_blocks(sb));
-			es->s_free_inodes_count = cpu_to_le32(ext2_count_free_inodes(sb));
+			es->s_free_blocks_count =
+				cpu_to_le32(ext2_count_free_blocks(sb));
+			es->s_free_inodes_count =
+				cpu_to_le32(ext2_count_free_inodes(sb));
 			es->s_mtime = cpu_to_le32(get_seconds());
 			ext2_sync_super(sb, es);
 		} else
@@ -967,6 +1053,193 @@
 	unlock_kernel();
 }
 
+/*
+ * Functions for marking fs as dirty or clean with respect to ongoing
+ * write activity.  Note this is different from the fs valid bit,
+ * which determines whether the fs has been cleanly unmounted.
+ *
+ * sb->s_lock MUST be held while calling this function.
+ */
+
+static void
+__ext2_mark_super(struct super_block *sb, int state)
+{
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+	struct ext2_super_block *es = sbi->s_es;
+
+	if (sb->s_flags & MS_RDONLY)
+		return;
+	if (es->s_fs_dirty == state)
+		return;
+
+	es->s_fs_dirty = state;
+	es->s_wtime = cpu_to_le32(get_seconds());
+	/*
+	 * If it's dirty, don't update free block/inode counts -
+	 * that's expensive, and we have to rebuild them anyway.
+	 *
+	 * If it's clean, update the free block/inode counts, they
+	 * have to be correct now.
+	 */
+	if (state == EXT2_FS_DIRTY) {
+		printk(KERN_DEBUG "marking fs dirty\n");
+		sbi->s_dirty_lately = EXT2_FS_DIRTY;
+	} else {
+		printk(KERN_DEBUG "marking fs clean\n");
+		es->s_free_blocks_count =
+			cpu_to_le32(ext2_count_free_blocks(sb));
+		es->s_free_inodes_count =
+			cpu_to_le32(ext2_count_free_inodes(sb));
+		/* We only reset the dirty_lately flag in ext2_update_state */
+	}
+	ext2_write_super_async(sb, es);
+}
+
+static void
+__ext2_mark_fs_dirty(struct super_block *sb)
+{
+	__ext2_mark_super(sb, EXT2_FS_DIRTY);
+}
+	
+void
+__ext2_mark_fs_clean(struct super_block *sb)
+{
+	__ext2_mark_super(sb, EXT2_FS_CLEAN);
+}
+	
+/*
+ * This function must be called every time we modify file system
+ * metadata, and must be called BEFORE any write I/O is scheduled.
+ */
+
+void
+ext2_mark_fs_dirty(struct super_block *sb)
+{
+	/* XXX get around locking super every write ? */
+	lock_super(sb);
+	__ext2_mark_super(sb, EXT2_FS_DIRTY);
+	unlock_super(sb);
+}
+	
+/*
+ * Whenever we mark an inode dirty, we must also mark the file system
+ * dirty.
+ *
+ * XXX Currently mark_inode_dirty() is #defined as
+ * ext2_mark_inode_dirty(), hence the bogus use of
+ * __mark_inode_dirty().  I don't want to replace all instances of
+ * mark_inode_dirty until I'm sure this is what I want to do.
+ */
+
+static void
+__ext2_mark_inode_dirty(struct inode *inode)
+{
+	__ext2_mark_fs_dirty(inode->i_sb);
+	__mark_inode_dirty(inode, I_DIRTY);
+}
+
+void
+ext2_mark_inode_dirty(struct inode *inode)
+{
+	ext2_mark_fs_dirty(inode->i_sb);
+	__mark_inode_dirty(inode, I_DIRTY);
+}
+
+/*
+ * orphan inode stuff, stolen from ext3
+ *
+ * This is a temporary solution for the orphan inode problem.  The
+ * long term solution ought to be in-memory-only allocation bitmaps.
+ */
+
+static inline struct inode *orphan_list_entry(struct list_head *l)
+{
+	return &list_entry(l, struct ext2_inode_info, i_orphan)->vfs_inode;
+}
+
+static void dump_orphan_list(struct super_block *sb, struct ext2_sb_info *sbi)
+{
+	struct list_head *l;
+
+	printk(KERN_DEBUG "sb_info orphan list:\n");
+	list_for_each(l, &sbi->s_orphan) {
+		struct inode *inode = orphan_list_entry(l);
+		printk(KERN_DEBUG "  "
+		       "inode %s:%ld at %p: mode %o, nlink %d, next %d\n",
+		       inode->i_sb->s_id, inode->i_ino, inode,
+		       inode->i_mode, inode->i_nlink, 
+		       NEXT_ORPHAN(inode));
+	}
+}
+
+/*
+ * ext2_orphan_add() links an unlinked inode into a list of such
+ * inodes, starting at the superblock, in case we crash before the
+ * file is closed and deleted.
+ *
+ * We depend on the ext3 orphan recovery code in fsck to clean up.
+ */
+void ext2_orphan_add(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+	struct ext2_super_block *es = sbi->s_es;
+
+	lock_super(sb);
+	if (!list_empty(&EXT2_I(inode)->i_orphan)) {
+		unlock_super(sb);
+		return;
+	}
+	/* Insert this inode at the head of the on-disk orphan list... */
+	NEXT_ORPHAN(inode) = le32_to_cpu(es->s_last_orphan);
+	es->s_last_orphan = cpu_to_le32(inode->i_ino);
+	/* Add to in-memory list */
+	list_add(&EXT2_I(inode)->i_orphan, &EXT2_SB(sb)->s_orphan);
+	__ext2_mark_inode_dirty(inode);
+	dump_orphan_list(sb, EXT2_SB(sb));
+	unlock_super(sb);
+	return;
+}
+
+/*
+ * ext2_orphan_del() removes an unlinked inode from the list of such
+ * inodes stored on disk, because it is finally being cleaned up.
+ */
+void ext2_orphan_del(struct inode *inode)
+{
+	struct list_head *prev;
+	struct super_block *sb = inode->i_sb;
+	struct ext2_inode_info *ei = EXT2_I(inode);
+	struct ext2_sb_info *sbi;
+	unsigned long ino_next;
+
+	lock_super(sb);
+	if (list_empty(&ei->i_orphan)) {
+		unlock_super(sb);
+		return;
+	}
+
+	ino_next = NEXT_ORPHAN(inode);
+	prev = ei->i_orphan.prev;
+	sbi = EXT2_SB(sb);
+
+	list_del_init(&ei->i_orphan);
+
+	if (prev == &sbi->s_orphan) {
+		sbi->s_es->s_last_orphan = cpu_to_le32(ino_next);
+	} else {
+		struct inode *i_prev =
+			&list_entry(prev, struct ext2_inode_info,
+				    i_orphan)->vfs_inode;
+		NEXT_ORPHAN(i_prev) = ino_next;
+		__ext2_mark_inode_dirty(i_prev);
+	}
+	__ext2_mark_inode_dirty(inode);
+	dump_orphan_list(sb, EXT2_SB(sb));
+	unlock_super(sb);
+	return;
+}
+
 static int ext2_remount (struct super_block * sb, int * flags, char * data)
 {
 	struct ext2_sb_info * sbi = EXT2_SB(sb);
@@ -993,6 +1266,10 @@
 	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
 		((sbi->s_mount_opt & EXT2_MOUNT_POSIX_ACL) ? MS_POSIXACL : 0);
 
+	/* Superblock may have changed on disk, reread into memory copy */
+
+	memcpy(sbi->s_esp, sbi->s_sbh->b_data, sbi->s_sbh->b_size);
+
 	es = sbi->s_es;
 	if (((sbi->s_mount_opt & EXT2_MOUNT_XIP) !=
 	    (old_mount_opt & EXT2_MOUNT_XIP)) &&
diff -x '*~' -uNr vanilla-linux/fs/ext2/xattr.c uml-clean/fs/ext2/xattr.c
--- vanilla-linux/fs/ext2/xattr.c	2006-03-07 16:17:00.000000000 -0800
+++ uml-clean/fs/ext2/xattr.c	2006-03-08 16:21:30.000000000 -0800
@@ -345,6 +345,7 @@
 	lock_super(sb);
 	EXT2_SB(sb)->s_es->s_feature_compat |=
 		cpu_to_le32(EXT2_FEATURE_COMPAT_EXT_ATTR);
+	ext2_prepare_super(sb);
 	sb->s_dirt = 1;
 	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
 	unlock_super(sb);
diff -x '*~' -uNr vanilla-linux/include/linux/ext2_fs.h uml-clean/include/linux/ext2_fs.h
--- vanilla-linux/include/linux/ext2_fs.h	2006-01-02 19:21:10.000000000 -0800
+++ uml-clean/include/linux/ext2_fs.h	2006-03-16 22:26:50.000000000 -0800
@@ -117,6 +117,12 @@
 #endif
 
 /*
+ * Macro for dealing with orphan inode list
+ */
+
+#define NEXT_ORPHAN(inode) EXT2_I(inode)->i_dtime
+
+/*
  * Macro-instructions used to manage fragments
  */
 #define EXT2_MIN_FRAG_SIZE		1024
@@ -296,6 +302,15 @@
  */
 #define	EXT2_VALID_FS			0x0001	/* Unmounted cleanly */
 #define	EXT2_ERROR_FS			0x0002	/* Errors detected */
+/*
+ * Bits defining whether the file system is currently clean or not.
+ * Note that in file systems created by old code, the bit would be set
+ * to 0.  To be safe, we must define 0 as dirty and 1 as clean.
+ *
+ * XXX Should convert to state bits, but need to fix fsck first.
+ */
+#define EXT2_FS_CLEAN			1
+#define EXT2_FS_DIRTY			0
 
 /*
  * Mount flags
@@ -407,7 +422,12 @@
 	__u16	s_reserved_word_pad;
 	__le32	s_default_mount_opts;
  	__le32	s_first_meta_bg; 	/* First metablock block group */
-	__u32	s_reserved[190];	/* Padding to the end of the block */
+	__u32	s_journal_reserved[18];	/* Used by ext3 journaling */
+	__u8	s_fs_dirty;		/* Fs-wide dirty bit */
+	__u8	s_bytes_reserved[3];	/* Padding */
+	__u32	s_clean_count;		/* Intervals in which fs was clean */
+	__u32	s_dirty_count;		/* Intervals in which fs was dirty */
+	__u32	s_reserved[169];	/* Padding to the end of the block */
 };
 
 /*
diff -x '*~' -uNr vanilla-linux/include/linux/ext2_fs_sb.h uml-clean/include/linux/ext2_fs_sb.h
--- vanilla-linux/include/linux/ext2_fs_sb.h	2006-01-02 19:21:10.000000000 -0800
+++ uml-clean/include/linux/ext2_fs_sb.h	2006-03-16 22:27:57.000000000 -0800
@@ -34,7 +34,11 @@
 	unsigned long s_desc_per_block;	/* Number of group descriptors per block */
 	unsigned long s_groups_count;	/* Number of groups in the fs */
 	struct buffer_head * s_sbh;	/* Buffer containing the super block */
-	struct ext2_super_block * s_es;	/* Pointer to the super block in the buffer */
+	struct ext2_super_block * s_es;	/* Pointer to the in memory super block */
+	char * s_esp;			/* Pointer to kmalloc'd memory
+					 * containing ext2_super_block
+					 * - might be offset inside
+					 * buffer */
 	struct buffer_head ** s_group_desc;
 	unsigned long  s_mount_opt;
 	uid_t s_resuid;
@@ -53,6 +57,12 @@
 	struct percpu_counter s_freeinodes_counter;
 	struct percpu_counter s_dirs_counter;
 	struct blockgroup_lock s_blockgroup_lock;
+	wait_queue_head_t s_wait;
+	struct list_head s_orphan; /* For quick access to orphan inodes */
+	int s_dirty_lately;
+	unsigned int s_quit;
+	unsigned int s_done;
+	void * s_process;
 };
 
 #endif	/* _LINUX_EXT2_FS_SB */

