Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbTBJUaj>; Mon, 10 Feb 2003 15:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbTBJUaj>; Mon, 10 Feb 2003 15:30:39 -0500
Received: from packet.digeo.com ([12.110.80.53]:37618 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262038AbTBJUaE>;
	Mon, 10 Feb 2003 15:30:04 -0500
Date: Mon, 10 Feb 2003 12:40:00 -0800
From: Andrew Morton <akpm@digeo.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: mikulas@artax.karlin.mff.cuni.cz, andrea@suse.de, pavel@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: 2.0, 2.2, 2.4, 2.5: fsync buffer race
Message-Id: <20030210124000.456318e7.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0302100846090.2127-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302101723540.32095-100000@artax.karlin.mff.cuni.cz>
	<Pine.LNX.4.44.0302100846090.2127-100000@home.transmeta.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2003 20:39:41.0747 (UTC) FILETIME=[89AB2030:01C2D144]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> wrote:
>
> If you want to synchronously wait for dirty blocks, you should do 
> something like
> 
> 	lock_buffer();
> 	.. dirty buffer..
> 	mark_buffer_dirty();
> 	unlock_buffer();
> 
> 	ll_rw_block(..)

Almost all of the problematic code paths were doing this:

	alter_data_at(bh->b_data);
	mark_buffer_dirty(bh);
	if (IS_SYNC(inode)) {
		ll_rw_block(bh);
		wait_on_buffer(bh);
	}

and the bug is that if writeout was already underway, the new changes are not
committed to disk here.

The approach you describe here would involve changing that to:

	if (IS_SYNC(inode))
		lock_buffer(bh);
	alter_data_at(bh->b_data);
	mark_buffer_dirty(bh);
	if (IS_SYNC(inode)) {
		submit_bh(bh);
		wait_on_buffer(bh);
	}

which seems a bit odd.  Or perhaps

	lock_buffer(bh);
	alter_data_at(bh->b_data);
	mark_buffer_dirty(bh);
	if (IS_SYNC(inode)) {
		submit_bh(bh);
		wait_on_buffer(bh);
	} else {
		unlock_buffer(bh);
	}

which is nice.  But it'll suck for the non-IS_SYNC case due to undesirable
serialisation.

We don't need the buffer lock in there for serialisation because that is
handled at a higher level - usually i_sem.

I wrote the below patch to address this problem.





Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> points out a bug in
ll_rw_block() usage.

Typical usage is:

	mark_buffer_dirty(bh);
	ll_rw_block(WRITE, 1, &bh);
	wait_on_buffer(bh);

the problem is that if the buffer was locked on entry to this code sequence
(due to in-progress I/O), ll_rw_block() will not wait, and start new I/O.  So
this code will wait on the _old_ I/O, and will then continue execution,
leaving the buffer dirty.

It turns out that all callers were only writing one buffer, and they were all
waiting on that writeout.  So I added a new sync_dirty_buffer() function:

	void sync_dirty_buffer(struct buffer_head *bh)
	{
		lock_buffer(bh);
		if (test_clear_buffer_dirty(bh)) {
			get_bh(bh);
			bh->b_end_io = end_buffer_io_sync;
			submit_bh(WRITE, bh);
		} else {
			unlock_buffer(bh);
		}
	}

which allowed a fair amount of code to be removed, while adding the desired
data-integrity guarantees.

UFS has its own wrappers around ll_rw_block() which got in the way, so this
operation was open-coded in that case.



 fs/buffer.c                 |   18 ++++++++++++++++++
 fs/ext2/balloc.c            |   12 ++++--------
 fs/ext2/ialloc.c            |   12 ++++--------
 fs/ext2/inode.c             |    9 +++------
 fs/ext2/super.c             |    3 +--
 fs/ext2/xattr.c             |    9 +++------
 fs/ext3/super.c             |    6 ++----
 fs/jbd/commit.c             |    3 +--
 fs/jbd/journal.c            |    8 ++++----
 fs/jbd/transaction.c        |    6 ++----
 fs/jfs/jfs_imap.c           |    3 +--
 fs/jfs/jfs_mount.c          |    3 +--
 fs/jfs/namei.c              |    6 ++----
 fs/jfs/resize.c             |    9 +++------
 fs/minix/inode.c            |    3 +--
 fs/ntfs/super.c             |    3 +--
 fs/qnx4/inode.c             |    3 +--
 fs/reiserfs/journal.c       |    6 ++----
 fs/reiserfs/resize.c        |    3 +--
 fs/sysv/inode.c             |    3 +--
 fs/sysv/itree.c             |    6 ++----
 fs/udf/inode.c              |    3 +--
 fs/ufs/balloc.c             |   16 ++++++++--------
 fs/ufs/dir.c                |   18 ++++++------------
 fs/ufs/ialloc.c             |    2 ++
 fs/ufs/inode.c              |   12 ++++--------
 fs/ufs/truncate.c           |    3 +++
 include/linux/buffer_head.h |    1 +
 include/linux/hfs_sysdep.h  |    9 ++-------
 kernel/ksyms.c              |    1 +
 30 files changed, 86 insertions(+), 113 deletions(-)

diff -puN fs/buffer.c~ll_rw_block-fix fs/buffer.c
--- 25/fs/buffer.c~ll_rw_block-fix	Wed Feb  5 16:27:02 2003
+++ 25-akpm/fs/buffer.c	Wed Feb  5 16:27:03 2003
@@ -2622,6 +2622,24 @@ void ll_rw_block(int rw, int nr, struct 
 }
 
 /*
+ * For a data-integrity writeout, we need to wait upon any in-progress I/O
+ * and then start new I/O and then wait upon it.
+ */
+void sync_dirty_buffer(struct buffer_head *bh)
+{
+	WARN_ON(atomic_read(&bh->b_count) < 1);
+	lock_buffer(bh);
+	if (test_clear_buffer_dirty(bh)) {
+		get_bh(bh);
+		bh->b_end_io = end_buffer_io_sync;
+		submit_bh(WRITE, bh);
+		wait_on_buffer(bh);
+	} else {
+		unlock_buffer(bh);
+	}
+}
+
+/*
  * Sanity checks for try_to_free_buffers.
  */
 static void check_ttfb_buffer(struct page *page, struct buffer_head *bh)
diff -puN fs/ext2/balloc.c~ll_rw_block-fix fs/ext2/balloc.c
--- 25/fs/ext2/balloc.c~ll_rw_block-fix	Wed Feb  5 16:27:02 2003
+++ 25-akpm/fs/ext2/balloc.c	Wed Feb  5 16:27:03 2003
@@ -233,10 +233,8 @@ do_more:
 	}
 
 	mark_buffer_dirty(bitmap_bh);
-	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ll_rw_block(WRITE, 1, &bitmap_bh);
-		wait_on_buffer(bitmap_bh);
-	}
+	if (sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(bitmap_bh);
 
 	group_release_blocks(desc, bh2, group_freed);
 	freed += group_freed;
@@ -466,10 +464,8 @@ got_block:
 	write_unlock(&EXT2_I(inode)->i_meta_lock);
 
 	mark_buffer_dirty(bitmap_bh);
-	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ll_rw_block(WRITE, 1, &bitmap_bh);
-		wait_on_buffer(bitmap_bh);
-	}
+	if (sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(bitmap_bh);
 
 	ext2_debug ("allocating block %d. ", block);
 
diff -puN fs/ext2/ialloc.c~ll_rw_block-fix fs/ext2/ialloc.c
--- 25/fs/ext2/ialloc.c~ll_rw_block-fix	Wed Feb  5 16:27:02 2003
+++ 25-akpm/fs/ext2/ialloc.c	Wed Feb  5 16:27:03 2003
@@ -146,10 +146,8 @@ void ext2_free_inode (struct inode * ino
 		mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
 	}
 	mark_buffer_dirty(bitmap_bh);
-	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ll_rw_block(WRITE, 1, &bitmap_bh);
-		wait_on_buffer(bitmap_bh);
-	}
+	if (sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(bitmap_bh);
 	sb->s_dirt = 1;
 error_return:
 	brelse(bitmap_bh);
@@ -485,10 +483,8 @@ repeat:
 	ext2_set_bit(i, bitmap_bh->b_data);
 
 	mark_buffer_dirty(bitmap_bh);
-	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ll_rw_block(WRITE, 1, &bitmap_bh);
-		wait_on_buffer(bitmap_bh);
-	}
+	if (sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(bitmap_bh);
 	brelse(bitmap_bh);
 
 	ino = group * EXT2_INODES_PER_GROUP(sb) + i + 1;
diff -puN fs/ext2/inode.c~ll_rw_block-fix fs/ext2/inode.c
--- 25/fs/ext2/inode.c~ll_rw_block-fix	Wed Feb  5 16:27:02 2003
+++ 25-akpm/fs/ext2/inode.c	Wed Feb  5 16:27:03 2003
@@ -443,10 +443,8 @@ static int ext2_alloc_branch(struct inod
 		 * But we now rely upon generic_osync_inode()
 		 * and b_inode_buffers.  But not for directories.
 		 */
-		if (S_ISDIR(inode->i_mode) && IS_DIRSYNC(inode)) {
-			ll_rw_block(WRITE, 1, &bh);
-			wait_on_buffer(bh);
-		}
+		if (S_ISDIR(inode->i_mode) && IS_DIRSYNC(inode))
+			sync_dirty_buffer(bh);
 		parent = nr;
 	}
 	if (n == num)
@@ -1208,8 +1206,7 @@ static int ext2_update_inode(struct inod
 		raw_inode->i_block[n] = ei->i_data[n];
 	mark_buffer_dirty(bh);
 	if (do_sync) {
-		ll_rw_block (WRITE, 1, &bh);
-		wait_on_buffer (bh);
+		sync_dirty_buffer(bh);
 		if (buffer_req(bh) && !buffer_uptodate(bh)) {
 			printk ("IO error syncing ext2 inode [%s:%08lx]\n",
 				sb->s_id, (unsigned long) ino);
diff -puN fs/ext2/super.c~ll_rw_block-fix fs/ext2/super.c
--- 25/fs/ext2/super.c~ll_rw_block-fix	Wed Feb  5 16:27:02 2003
+++ 25-akpm/fs/ext2/super.c	Wed Feb  5 16:27:03 2003
@@ -842,8 +842,7 @@ static void ext2_sync_super(struct super
 {
 	es->s_wtime = cpu_to_le32(get_seconds());
 	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
-	ll_rw_block(WRITE, 1, &EXT2_SB(sb)->s_sbh);
-	wait_on_buffer(EXT2_SB(sb)->s_sbh);
+	sync_dirty_buffer(EXT2_SB(sb)->s_sbh);
 	sb->s_dirt = 0;
 }
 
diff -puN fs/ext2/xattr.c~ll_rw_block-fix fs/ext2/xattr.c
--- 25/fs/ext2/xattr.c~ll_rw_block-fix	Wed Feb  5 16:27:02 2003
+++ 25-akpm/fs/ext2/xattr.c	Wed Feb  5 16:27:03 2003
@@ -774,8 +774,7 @@ ext2_xattr_set2(struct inode *inode, str
 		}
 		mark_buffer_dirty(new_bh);
 		if (IS_SYNC(inode)) {
-			ll_rw_block(WRITE, 1, &new_bh);
-			wait_on_buffer(new_bh); 
+			sync_dirty_buffer(new_bh);
 			error = -EIO;
 			if (buffer_req(new_bh) && !buffer_uptodate(new_bh))
 				goto cleanup;
@@ -865,10 +864,8 @@ ext2_xattr_delete_inode(struct inode *in
 		HDR(bh)->h_refcount = cpu_to_le32(
 			le32_to_cpu(HDR(bh)->h_refcount) - 1);
 		mark_buffer_dirty(bh);
-		if (IS_SYNC(inode)) {
-			ll_rw_block(WRITE, 1, &bh);
-			wait_on_buffer(bh);
-		}
+		if (IS_SYNC(inode))
+			sync_dirty_buffer(bh);
 		DQUOT_FREE_BLOCK(inode, 1);
 	}
 	EXT2_I(inode)->i_file_acl = 0;
diff -puN fs/ext3/super.c~ll_rw_block-fix fs/ext3/super.c
--- 25/fs/ext3/super.c~ll_rw_block-fix	Wed Feb  5 16:27:02 2003
+++ 25-akpm/fs/ext3/super.c	Wed Feb  5 16:27:03 2003
@@ -1627,10 +1627,8 @@ static void ext3_commit_super (struct su
 	es->s_wtime = cpu_to_le32(get_seconds());
 	BUFFER_TRACE(EXT3_SB(sb)->s_sbh, "marking dirty");
 	mark_buffer_dirty(EXT3_SB(sb)->s_sbh);
-	if (sync) {
-		ll_rw_block(WRITE, 1, &EXT3_SB(sb)->s_sbh);
-		wait_on_buffer(EXT3_SB(sb)->s_sbh);
-	}
+	if (sync)
+		sync_dirty_buffer(EXT3_SB(sb)->s_sbh);
 }
 
 
diff -puN fs/jbd/commit.c~ll_rw_block-fix fs/jbd/commit.c
--- 25/fs/jbd/commit.c~ll_rw_block-fix	Wed Feb  5 16:27:02 2003
+++ 25-akpm/fs/jbd/commit.c	Wed Feb  5 16:27:03 2003
@@ -607,8 +607,7 @@ start_journal_io:
 	{
 		struct buffer_head *bh = jh2bh(descriptor);
 		set_buffer_uptodate(bh);
-		ll_rw_block(WRITE, 1, &bh);
-		wait_on_buffer(bh);
+		sync_dirty_buffer(bh);
 		__brelse(bh);		/* One for getblk() */
 		journal_unlock_journal_head(descriptor);
 	}
diff -puN fs/jbd/journal.c~ll_rw_block-fix fs/jbd/journal.c
--- 25/fs/jbd/journal.c~ll_rw_block-fix	Wed Feb  5 16:27:02 2003
+++ 25-akpm/fs/jbd/journal.c	Wed Feb  5 16:27:03 2003
@@ -960,9 +960,10 @@ void journal_update_superblock(journal_t
 
 	BUFFER_TRACE(bh, "marking dirty");
 	mark_buffer_dirty(bh);
-	ll_rw_block(WRITE, 1, &bh);
 	if (wait)
-		wait_on_buffer(bh);
+		sync_dirty_buffer(bh);
+	else
+		ll_rw_block(WRITE, 1, &bh);
 
 	/* If we have just flushed the log (by marking s_start==0), then
 	 * any future commit will have to be careful to update the
@@ -1296,8 +1297,7 @@ static int journal_convert_superblock_v1
 	bh = journal->j_sb_buffer;
 	BUFFER_TRACE(bh, "marking dirty");
 	mark_buffer_dirty(bh);
-	ll_rw_block(WRITE, 1, &bh);
-	wait_on_buffer(bh);
+	sync_dirty_buffer(bh);
 	return 0;
 }
 
diff -puN fs/jbd/transaction.c~ll_rw_block-fix fs/jbd/transaction.c
--- 25/fs/jbd/transaction.c~ll_rw_block-fix	Wed Feb  5 16:27:02 2003
+++ 25-akpm/fs/jbd/transaction.c	Wed Feb  5 16:27:03 2003
@@ -1079,8 +1079,7 @@ int journal_dirty_data (handle_t *handle
 				atomic_inc(&bh->b_count);
 				spin_unlock(&journal_datalist_lock);
 				need_brelse = 1;
-				ll_rw_block(WRITE, 1, &bh);
-				wait_on_buffer(bh);
+				sync_dirty_buffer(bh);
 				spin_lock(&journal_datalist_lock);
 				/* The buffer may become locked again at any
 				   time if it is redirtied */
@@ -1361,8 +1360,7 @@ void journal_sync_buffer(struct buffer_h
 		}
 		atomic_inc(&bh->b_count);
 		spin_unlock(&journal_datalist_lock);
-		ll_rw_block (WRITE, 1, &bh);
-		wait_on_buffer(bh);
+		sync_dirty_buffer(bh);
 		__brelse(bh);
 		goto out;
 	}
diff -puN fs/jfs/jfs_imap.c~ll_rw_block-fix fs/jfs/jfs_imap.c
--- 25/fs/jfs/jfs_imap.c~ll_rw_block-fix	Wed Feb  5 16:27:02 2003
+++ 25-akpm/fs/jfs/jfs_imap.c	Wed Feb  5 16:27:03 2003
@@ -2980,8 +2980,7 @@ static void duplicateIXtree(struct super
 		j_sb->s_flag |= JFS_BAD_SAIT;
 
 		mark_buffer_dirty(bh);
-		ll_rw_block(WRITE, 1, &bh);
-		wait_on_buffer(bh);
+		sync_dirty_buffer(bh);
 		brelse(bh);
 		return;
 	}
diff -puN fs/jfs/jfs_mount.c~ll_rw_block-fix fs/jfs/jfs_mount.c
--- 25/fs/jfs/jfs_mount.c~ll_rw_block-fix	Wed Feb  5 16:27:02 2003
+++ 25-akpm/fs/jfs/jfs_mount.c	Wed Feb  5 16:27:03 2003
@@ -449,8 +449,7 @@ int updateSuper(struct super_block *sb, 
 	}
 
 	mark_buffer_dirty(bh);
-	ll_rw_block(WRITE, 1, &bh);
-	wait_on_buffer(bh);
+	sync_dirty_buffer(bh);
 	brelse(bh);
 
 	return 0;
diff -puN fs/jfs/namei.c~ll_rw_block-fix fs/jfs/namei.c
--- 25/fs/jfs/namei.c~ll_rw_block-fix	Wed Feb  5 16:27:02 2003
+++ 25-akpm/fs/jfs/namei.c	Wed Feb  5 16:27:03 2003
@@ -972,10 +972,8 @@ int jfs_symlink(struct inode *dip, struc
 #if 0
 				set_buffer_uptodate(bp);
 				mark_buffer_dirty(bp, 1);
-				if (IS_SYNC(dip)) {
-					ll_rw_block(WRITE, 1, &bp);
-					wait_on_buffer(bp);
-				}
+				if (IS_SYNC(dip))
+					sync_dirty_buffer(bp);
 				brelse(bp);
 #endif				/* 0 */
 				ssize -= copy_size;
diff -puN fs/jfs/resize.c~ll_rw_block-fix fs/jfs/resize.c
--- 25/fs/jfs/resize.c~ll_rw_block-fix	Wed Feb  5 16:27:02 2003
+++ 25-akpm/fs/jfs/resize.c	Wed Feb  5 16:27:03 2003
@@ -243,8 +243,7 @@ int jfs_extendfs(struct super_block *sb,
 
 		/* synchronously update superblock */
 		mark_buffer_dirty(bh);
-		ll_rw_block(WRITE, 1, &bh);
-		wait_on_buffer(bh);
+		sync_dirty_buffer(bh);
 		brelse(bh);
 
 		/*
@@ -512,15 +511,13 @@ int jfs_extendfs(struct super_block *sb,
 		memcpy(j_sb2, j_sb, sizeof (struct jfs_superblock));
 
 		mark_buffer_dirty(bh);
-		ll_rw_block(WRITE, 1, &bh2);
-		wait_on_buffer(bh2);
+		sync_dirty_buffer(bh2);
 		brelse(bh2);
 	}
 
 	/* write primary superblock */
 	mark_buffer_dirty(bh);
-	ll_rw_block(WRITE, 1, &bh);
-	wait_on_buffer(bh);
+	sync_dirty_buffer(bh);
 	brelse(bh);
 
 	goto resume;
diff -puN fs/minix/inode.c~ll_rw_block-fix fs/minix/inode.c
--- 25/fs/minix/inode.c~ll_rw_block-fix	Wed Feb  5 16:27:02 2003
+++ 25-akpm/fs/minix/inode.c	Wed Feb  5 16:27:03 2003
@@ -517,8 +517,7 @@ int minix_sync_inode(struct inode * inod
 	bh = minix_update_inode(inode);
 	if (bh && buffer_dirty(bh))
 	{
-		ll_rw_block(WRITE, 1, &bh);
-		wait_on_buffer(bh);
+		sync_dirty_buffer(bh);
 		if (buffer_req(bh) && !buffer_uptodate(bh))
 		{
 			printk ("IO error syncing minix inode [%s:%08lx]\n",
diff -puN fs/ntfs/super.c~ll_rw_block-fix fs/ntfs/super.c
--- 25/fs/ntfs/super.c~ll_rw_block-fix	Wed Feb  5 16:27:02 2003
+++ 25-akpm/fs/ntfs/super.c	Wed Feb  5 16:27:03 2003
@@ -505,8 +505,7 @@ hotfix_primary_boot_sector:
 			memcpy(bh_primary->b_data, bh_backup->b_data,
 					sb->s_blocksize);
 			mark_buffer_dirty(bh_primary);
-			ll_rw_block(WRITE, 1, &bh_primary);
-			wait_on_buffer(bh_primary);
+			sync_dirty_buffer(bh_primary);
 			if (buffer_uptodate(bh_primary)) {
 				brelse(bh_backup);
 				return bh_primary;
diff -puN fs/qnx4/inode.c~ll_rw_block-fix fs/qnx4/inode.c
--- 25/fs/qnx4/inode.c~ll_rw_block-fix	Wed Feb  5 16:27:03 2003
+++ 25-akpm/fs/qnx4/inode.c	Wed Feb  5 16:27:03 2003
@@ -44,8 +44,7 @@ int qnx4_sync_inode(struct inode *inode)
    	bh = qnx4_update_inode(inode);
 	if (bh && buffer_dirty(bh))
 	{
-		ll_rw_block(WRITE, 1, &bh);
-		wait_on_buffer(bh);
+		sync_dirty_buffer(bh);
 		if (buffer_req(bh) && !buffer_uptodate(bh))
 		{
 			printk ("IO error syncing qnx4 inode [%s:%08lx]\n",
diff -puN fs/reiserfs/journal.c~ll_rw_block-fix fs/reiserfs/journal.c
--- 25/fs/reiserfs/journal.c~ll_rw_block-fix	Wed Feb  5 16:27:03 2003
+++ 25-akpm/fs/reiserfs/journal.c	Wed Feb  5 16:27:03 2003
@@ -735,8 +735,7 @@ reiserfs_panic(s, "journal-539: flush_co
   }
 
   mark_buffer_dirty(jl->j_commit_bh) ;
-  ll_rw_block(WRITE, 1, &(jl->j_commit_bh)) ;
-  wait_on_buffer(jl->j_commit_bh) ;
+  sync_dirty_buffer(jl->j_commit_bh) ;
   if (!buffer_uptodate(jl->j_commit_bh)) {
     reiserfs_panic(s, "journal-615: buffer write failed\n") ;
   }
@@ -828,8 +827,7 @@ static int _update_journal_header_block(
     jh->j_first_unflushed_offset = cpu_to_le32(offset) ;
     jh->j_mount_id = cpu_to_le32(SB_JOURNAL(p_s_sb)->j_mount_id) ;
     set_buffer_dirty(SB_JOURNAL(p_s_sb)->j_header_bh) ;
-    ll_rw_block(WRITE, 1, &(SB_JOURNAL(p_s_sb)->j_header_bh)) ;
-    wait_on_buffer((SB_JOURNAL(p_s_sb)->j_header_bh)) ; 
+    sync_dirty_buffer(SB_JOURNAL(p_s_sb)->j_header_bh) ;
     if (!buffer_uptodate(SB_JOURNAL(p_s_sb)->j_header_bh)) {
       printk( "reiserfs: journal-837: IO error during journal replay\n" );
       return -EIO ;
diff -puN fs/reiserfs/resize.c~ll_rw_block-fix fs/reiserfs/resize.c
--- 25/fs/reiserfs/resize.c~ll_rw_block-fix	Wed Feb  5 16:27:03 2003
+++ 25-akpm/fs/reiserfs/resize.c	Wed Feb  5 16:27:03 2003
@@ -120,8 +120,7 @@ int reiserfs_resize (struct super_block 
 
 		mark_buffer_dirty(bitmap[i].bh) ;
 		set_buffer_uptodate(bitmap[i].bh);
-		ll_rw_block(WRITE, 1, &bitmap[i].bh);
-		wait_on_buffer(bitmap[i].bh);
+		sync_dirty_buffer(bitmap[i].bh);
 		// update bitmap_info stuff
 		bitmap[i].first_zero_hint=1;
 		bitmap[i].free_count = sb_blocksize(sb) * 8 - 1;
diff -puN fs/sysv/inode.c~ll_rw_block-fix fs/sysv/inode.c
--- 25/fs/sysv/inode.c~ll_rw_block-fix	Wed Feb  5 16:27:03 2003
+++ 25-akpm/fs/sysv/inode.c	Wed Feb  5 16:27:03 2003
@@ -265,8 +265,7 @@ int sysv_sync_inode(struct inode * inode
 
         bh = sysv_update_inode(inode);
         if (bh && buffer_dirty(bh)) {
-                ll_rw_block(WRITE, 1, &bh);
-                wait_on_buffer(bh);
+                sync_dirty_buffer(bh);
                 if (buffer_req(bh) && !buffer_uptodate(bh)) {
                         printk ("IO error syncing sysv inode [%s:%08lx]\n",
                                 inode->i_sb->s_id, inode->i_ino);
diff -puN fs/sysv/itree.c~ll_rw_block-fix fs/sysv/itree.c
--- 25/fs/sysv/itree.c~ll_rw_block-fix	Wed Feb  5 16:27:03 2003
+++ 25-akpm/fs/sysv/itree.c	Wed Feb  5 16:27:03 2003
@@ -15,10 +15,8 @@ enum {DIRECT = 10, DEPTH = 4};	/* Have t
 static inline void dirty_indirect(struct buffer_head *bh, struct inode *inode)
 {
 	mark_buffer_dirty_inode(bh, inode);
-	if (IS_SYNC(inode)) {
-		ll_rw_block (WRITE, 1, &bh);
-		wait_on_buffer (bh);
-	}
+	if (IS_SYNC(inode))
+		sync_dirty_buffer(bh);
 }
 
 static int block_to_path(struct inode *inode, long block, int offsets[DEPTH])
diff -puN fs/udf/inode.c~ll_rw_block-fix fs/udf/inode.c
--- 25/fs/udf/inode.c~ll_rw_block-fix	Wed Feb  5 16:27:03 2003
+++ 25-akpm/fs/udf/inode.c	Wed Feb  5 16:27:03 2003
@@ -1520,8 +1520,7 @@ udf_update_inode(struct inode *inode, in
 	mark_buffer_dirty(bh);
 	if (do_sync)
 	{
-		ll_rw_block(WRITE, 1, &bh);
-		wait_on_buffer(bh);
+		sync_dirty_buffer(bh);
 		if (buffer_req(bh) && !buffer_uptodate(bh))
 		{
 			printk("IO error syncing udf inode [%s:%08lx]\n",
diff -puN fs/ufs/balloc.c~ll_rw_block-fix fs/ufs/balloc.c
--- 25/fs/ufs/balloc.c~ll_rw_block-fix	Wed Feb  5 16:27:03 2003
+++ 25-akpm/fs/ufs/balloc.c	Wed Feb  5 16:27:03 2003
@@ -114,6 +114,7 @@ void ufs_free_fragments (struct inode * 
 	ubh_mark_buffer_dirty (USPI_UBH);
 	ubh_mark_buffer_dirty (UCPI_UBH);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
+		ubh_wait_on_buffer (UCPI_UBH);
 		ubh_ll_rw_block (WRITE, 1, (struct ufs_buffer_head **)&ucpi);
 		ubh_wait_on_buffer (UCPI_UBH);
 	}
@@ -199,6 +200,7 @@ do_more:
 	ubh_mark_buffer_dirty (USPI_UBH);
 	ubh_mark_buffer_dirty (UCPI_UBH);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
+		ubh_wait_on_buffer (UCPI_UBH);
 		ubh_ll_rw_block (WRITE, 1, (struct ufs_buffer_head **)&ucpi);
 		ubh_wait_on_buffer (UCPI_UBH);
 	}
@@ -228,10 +230,8 @@ failed:
 		memset (bh->b_data, 0, sb->s_blocksize); \
 		set_buffer_uptodate(bh); \
 		mark_buffer_dirty (bh); \
-		if (IS_SYNC(inode)) { \
-			ll_rw_block (WRITE, 1, &bh); \
-			wait_on_buffer (bh); \
-		} \
+		if (IS_SYNC(inode)) \
+			sync_dirty_buffer(bh); \
 		brelse (bh); \
 	}
 
@@ -364,10 +364,8 @@ unsigned ufs_new_fragments (struct inode
 				clear_buffer_dirty(bh);
 				bh->b_blocknr = result + i;
 				mark_buffer_dirty (bh);
-				if (IS_SYNC(inode)) {
-					ll_rw_block (WRITE, 1, &bh);
-					wait_on_buffer (bh);
-				}
+				if (IS_SYNC(inode))
+					sync_dirty_buffer(bh);
 				brelse (bh);
 			}
 			else
@@ -459,6 +457,7 @@ unsigned ufs_add_fragments (struct inode
 	ubh_mark_buffer_dirty (USPI_UBH);
 	ubh_mark_buffer_dirty (UCPI_UBH);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
+		ubh_wait_on_buffer (UCPI_UBH);
 		ubh_ll_rw_block (WRITE, 1, (struct ufs_buffer_head **)&ucpi);
 		ubh_wait_on_buffer (UCPI_UBH);
 	}
@@ -584,6 +583,7 @@ succed:
 	ubh_mark_buffer_dirty (USPI_UBH);
 	ubh_mark_buffer_dirty (UCPI_UBH);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
+		ubh_wait_on_buffer (UCPI_UBH);
 		ubh_ll_rw_block (WRITE, 1, (struct ufs_buffer_head **)&ucpi);
 		ubh_wait_on_buffer (UCPI_UBH);
 	}
diff -puN fs/ufs/dir.c~ll_rw_block-fix fs/ufs/dir.c
--- 25/fs/ufs/dir.c~ll_rw_block-fix	Wed Feb  5 16:27:03 2003
+++ 25-akpm/fs/ufs/dir.c	Wed Feb  5 16:27:03 2003
@@ -356,10 +356,8 @@ void ufs_set_link(struct inode *dir, str
 	dir->i_version++;
 	de->d_ino = cpu_to_fs32(dir->i_sb, inode->i_ino);
 	mark_buffer_dirty(bh);
-	if (IS_DIRSYNC(dir)) {
-		ll_rw_block (WRITE, 1, &bh);
-		wait_on_buffer(bh);
-	}
+	if (IS_DIRSYNC(dir))
+		sync_dirty_buffer(bh);
 	brelse (bh);
 }
 
@@ -457,10 +455,8 @@ int ufs_add_link(struct dentry *dentry, 
 	de->d_ino = cpu_to_fs32(sb, inode->i_ino);
 	ufs_set_de_type(sb, de, inode->i_mode);
 	mark_buffer_dirty(bh);
-	if (IS_DIRSYNC(dir)) {
-		ll_rw_block (WRITE, 1, &bh);
-		wait_on_buffer (bh);
-	}
+	if (IS_DIRSYNC(dir))
+		sync_dirty_buffer(bh);
 	brelse (bh);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	dir->i_version++;
@@ -508,10 +504,8 @@ int ufs_delete_entry (struct inode * ino
 			inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 			mark_inode_dirty(inode);
 			mark_buffer_dirty(bh);
-			if (IS_DIRSYNC(inode)) {
-				ll_rw_block(WRITE, 1, &bh);
-				wait_on_buffer(bh);
-			}
+			if (IS_DIRSYNC(inode))
+				sync_dirty_buffer(bh);
 			brelse(bh);
 			UFSD(("EXIT\n"))
 			return 0;
diff -puN fs/ufs/ialloc.c~ll_rw_block-fix fs/ufs/ialloc.c
--- 25/fs/ufs/ialloc.c~ll_rw_block-fix	Wed Feb  5 16:27:03 2003
+++ 25-akpm/fs/ufs/ialloc.c	Wed Feb  5 16:27:03 2003
@@ -124,6 +124,7 @@ void ufs_free_inode (struct inode * inod
 	ubh_mark_buffer_dirty (USPI_UBH);
 	ubh_mark_buffer_dirty (UCPI_UBH);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
+		ubh_wait_on_buffer (UCPI_UBH);
 		ubh_ll_rw_block (WRITE, 1, (struct ufs_buffer_head **) &ucpi);
 		ubh_wait_on_buffer (UCPI_UBH);
 	}
@@ -248,6 +249,7 @@ cg_found:
 	ubh_mark_buffer_dirty (USPI_UBH);
 	ubh_mark_buffer_dirty (UCPI_UBH);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
+		ubh_wait_on_buffer (UCPI_UBH);
 		ubh_ll_rw_block (WRITE, 1, (struct ufs_buffer_head **) &ucpi);
 		ubh_wait_on_buffer (UCPI_UBH);
 	}
diff -puN fs/ufs/inode.c~ll_rw_block-fix fs/ufs/inode.c
--- 25/fs/ufs/inode.c~ll_rw_block-fix	Wed Feb  5 16:27:03 2003
+++ 25-akpm/fs/ufs/inode.c	Wed Feb  5 16:27:03 2003
@@ -298,10 +298,8 @@ repeat:
 	}
 
 	mark_buffer_dirty(bh);
-	if (IS_SYNC(inode)) {
-		ll_rw_block (WRITE, 1, &bh);
-		wait_on_buffer (bh);
-	}
+	if (IS_SYNC(inode))
+		sync_dirty_buffer(bh);
 	inode->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(inode);
 out:
@@ -635,10 +633,8 @@ static int ufs_update_inode(struct inode
 		memset (ufs_inode, 0, sizeof(struct ufs_inode));
 		
 	mark_buffer_dirty(bh);
-	if (do_sync) {
-		ll_rw_block (WRITE, 1, &bh);
-		wait_on_buffer (bh);
-	}
+	if (do_sync)
+		sync_dirty_buffer(bh);
 	brelse (bh);
 	
 	UFSD(("EXIT\n"))
diff -puN fs/ufs/truncate.c~ll_rw_block-fix fs/ufs/truncate.c
--- 25/fs/ufs/truncate.c~ll_rw_block-fix	Wed Feb  5 16:27:03 2003
+++ 25-akpm/fs/ufs/truncate.c	Wed Feb  5 16:27:03 2003
@@ -284,6 +284,7 @@ next:;
 		}
 	}
 	if (IS_SYNC(inode) && ind_ubh && ubh_buffer_dirty(ind_ubh)) {
+		ubh_wait_on_buffer (ind_ubh);
 		ubh_ll_rw_block (WRITE, 1, &ind_ubh);
 		ubh_wait_on_buffer (ind_ubh);
 	}
@@ -351,6 +352,7 @@ static int ufs_trunc_dindirect (struct i
 		}
 	}
 	if (IS_SYNC(inode) && dind_bh && ubh_buffer_dirty(dind_bh)) {
+		ubh_wait_on_buffer (dind_bh);
 		ubh_ll_rw_block (WRITE, 1, &dind_bh);
 		ubh_wait_on_buffer (dind_bh);
 	}
@@ -415,6 +417,7 @@ static int ufs_trunc_tindirect (struct i
 		}
 	}
 	if (IS_SYNC(inode) && tind_bh && ubh_buffer_dirty(tind_bh)) {
+		ubh_wait_on_buffer (tind_bh);
 		ubh_ll_rw_block (WRITE, 1, &tind_bh);
 		ubh_wait_on_buffer (tind_bh);
 	}
diff -puN include/linux/buffer_head.h~ll_rw_block-fix include/linux/buffer_head.h
--- 25/include/linux/buffer_head.h~ll_rw_block-fix	Wed Feb  5 16:27:03 2003
+++ 25-akpm/include/linux/buffer_head.h	Wed Feb  5 16:27:03 2003
@@ -169,6 +169,7 @@ struct buffer_head *alloc_buffer_head(vo
 void free_buffer_head(struct buffer_head * bh);
 void FASTCALL(unlock_buffer(struct buffer_head *bh));
 void ll_rw_block(int, int, struct buffer_head * bh[]);
+void sync_dirty_buffer(struct buffer_head *bh);
 int submit_bh(int, struct buffer_head *);
 void write_boundary_block(struct block_device *bdev,
 			sector_t bblock, unsigned blocksize);
diff -puN include/linux/hfs_sysdep.h~ll_rw_block-fix include/linux/hfs_sysdep.h
--- 25/include/linux/hfs_sysdep.h~ll_rw_block-fix	Wed Feb  5 16:27:03 2003
+++ 25-akpm/include/linux/hfs_sysdep.h	Wed Feb  5 16:27:03 2003
@@ -155,13 +155,8 @@ static inline void hfs_buffer_dirty(hfs_
 }
 
 static inline void hfs_buffer_sync(hfs_buffer buffer) {
-	while (buffer_locked(buffer)) {
-		wait_on_buffer(buffer);
-	}
-	if (buffer_dirty(buffer)) {
-		ll_rw_block(WRITE, 1, &buffer);
-		wait_on_buffer(buffer);
-	}
+	if (buffer_dirty(buffer))
+		sync_dirty_buffer(buffer);
 }
 
 static inline void *hfs_buffer_data(const hfs_buffer buffer) {
diff -puN kernel/ksyms.c~ll_rw_block-fix kernel/ksyms.c
--- 25/kernel/ksyms.c~ll_rw_block-fix	Wed Feb  5 16:27:03 2003
+++ 25-akpm/kernel/ksyms.c	Wed Feb  5 16:27:03 2003
@@ -208,6 +208,7 @@ EXPORT_SYMBOL(close_bdev_excl);
 EXPORT_SYMBOL(__brelse);
 EXPORT_SYMBOL(__bforget);
 EXPORT_SYMBOL(ll_rw_block);
+EXPORT_SYMBOL(sync_dirty_buffer);
 EXPORT_SYMBOL(submit_bh);
 EXPORT_SYMBOL(unlock_buffer);
 EXPORT_SYMBOL(__wait_on_buffer);

_

