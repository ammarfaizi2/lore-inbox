Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVADLio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVADLio (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 06:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVADLio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 06:38:44 -0500
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:29175 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261163AbVADLhg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 06:37:36 -0500
Message-Id: <6.0.0.20.2.20050104200330.020e0958@mailsv2.y.ecl.ntt.co.jp>
X-Mailer: QUALCOMM Windows Eudora Version 6J-Jr3
Date: Tue, 04 Jan 2005 20:34:09 +0900
To: akpm@osdl.org, sct@redhat.com, adilger@clusterfs.com
From: Hifumi Hisashi <hifumi.hisashi@lab.ntt.co.jp>
Subject: [PATCH] BUG on error handlings in Ext3 under I/O failure
  condition 
Cc: ext3-users@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello.

	I found bugs on error handlings in the functions arround the ext3 file
system, which cause inadequate completions of synchronous write I/O operations
when disk I/O failures occur.  Both 2.4 and 2.6 have this problem.

	I carried out following experiment:

1.  Mount a ext3 file system on a SCSI disk with ordered mode.
2.  Open a file on the file system with O_SYNC|O_RDWR|O_TRUNC|O_CREAT flag.
3.  Write 512 bytes data to the file by calling write() every 5 seconds, and
     examine return values from the syscall.
     from write().
4.  Disconnect the SCSI cable,  and examine messages from the kernel.

	After the SCSI cable is disconnected, write() must fail.  But the
result was different: write() succeeded for a while even though messages of
the kernel notified SCSI I/O error.

	By applying following modifications, the above problem was solved.
Please consider applying this patch to the mainline kernels.


Signed-off-by: Hisashi Hifumi  <hifumi.hisashi@lab.ntt.co.jp>


diff -Nru linux-2.6.10-bk6/fs/buffer.c linux-2.6.10-bk6_fix/fs/buffer.c
--- linux-2.6.10-bk6/fs/buffer.c	2004-12-25 06:34:58.000000000 +0900
+++ linux-2.6.10-bk6_fix/fs/buffer.c	2005-01-04 19:58:48.000000000 +0900
@@ -311,10 +311,10 @@
  {
  	struct inode * inode = dentry->d_inode;
  	struct super_block * sb;
-	int ret;
+	int ret, err;

  	/* sync the inode to buffers */
-	write_inode_now(inode, 0);
+	ret = write_inode_now(inode, 0);

  	/* sync the superblock to buffers */
  	sb = inode->i_sb;
@@ -324,7 +324,9 @@
  	unlock_super(sb);

  	/* .. finally sync the buffers to disk */
-	ret = sync_blockdev(sb->s_bdev);
+	err = sync_blockdev(sb->s_bdev);
+	if (!ret)
+		ret = err;
  	return ret;
  }

diff -Nru linux-2.6.10-bk6/fs/fs-writeback.c 
linux-2.6.10-bk6_fix/fs/fs-writeback.c
--- linux-2.6.10-bk6/fs/fs-writeback.c	2004-12-25 06:35:49.000000000 +0900
+++ linux-2.6.10-bk6_fix/fs/fs-writeback.c	2005-01-04 19:58:48.000000000 +0900
@@ -557,8 +557,9 @@
   *	dirty. This is primarily needed by knfsd.
   */

-void write_inode_now(struct inode *inode, int sync)
+int write_inode_now(struct inode *inode, int sync)
  {
+	int err = 0;
  	struct writeback_control wbc = {
  		.nr_to_write = LONG_MAX,
  		.sync_mode = WB_SYNC_ALL,
@@ -569,10 +570,11 @@

  	might_sleep();
  	spin_lock(&inode_lock);
-	__writeback_single_inode(inode, &wbc);
+	err = __writeback_single_inode(inode, &wbc);
  	spin_unlock(&inode_lock);
  	if (sync)
  		wait_on_inode(inode);
+	return err;
  }
  EXPORT_SYMBOL(write_inode_now);

@@ -641,8 +643,11 @@
  		need_write_inode_now = 1;
  	spin_unlock(&inode_lock);

-	if (need_write_inode_now)
-		write_inode_now(inode, 1);
+	if (need_write_inode_now) {
+		err2 = write_inode_now(inode, 1);
+		if (!err)
+			err = err2;
+	}
  	else
  		wait_on_inode(inode);

diff -Nru linux-2.6.10-bk6/fs/inode.c linux-2.6.10-bk6_fix/fs/inode.c
--- linux-2.6.10-bk6/fs/inode.c	2004-12-25 06:35:40.000000000 +0900
+++ linux-2.6.10-bk6_fix/fs/inode.c	2005-01-04 19:58:48.000000000 +0900
@@ -1035,7 +1035,7 @@
  		spin_unlock(&inode_lock);
  		if (!sb || (sb->s_flags & MS_ACTIVE))
  			return;
-		write_inode_now(inode, 1);
+		(void) write_inode_now(inode, 1);
  		spin_lock(&inode_lock);
  		inodes_stat.nr_unused--;
  		hlist_del_init(&inode->i_hash);
diff -Nru linux-2.6.10-bk6/fs/jbd/commit.c linux-2.6.10-bk6_fix/fs/jbd/commit.c
--- linux-2.6.10-bk6/fs/jbd/commit.c	2004-12-25 06:35:27.000000000 +0900
+++ linux-2.6.10-bk6_fix/fs/jbd/commit.c	2005-01-04 19:58:48.000000000 +0900
@@ -341,6 +341,9 @@
  	}
  	spin_unlock(&journal->j_list_lock);

+	if (err)
+		__journal_abort_hard(journal);
+
  	journal_write_revoke_records(journal, commit_transaction);

  	jbd_debug(3, "JBD: commit phase 2\n");
diff -Nru linux-2.6.10-bk6/include/linux/fs.h 
linux-2.6.10-bk6_fix/include/linux/fs.h
--- linux-2.6.10-bk6/include/linux/fs.h	2004-12-25 06:34:27.000000000 +0900
+++ linux-2.6.10-bk6_fix/include/linux/fs.h	2005-01-04 19:58:48.000000000 +0900
@@ -1341,7 +1341,7 @@
  		invalidate_inode_pages(inode->i_mapping);
  }
  extern void invalidate_inode_pages2(struct address_space *mapping);
-extern void write_inode_now(struct inode *, int);
+extern int write_inode_now(struct inode *, int);
  extern int filemap_fdatawrite(struct address_space *);
  extern int filemap_flush(struct address_space *);
  extern int filemap_fdatawait(struct address_space *);






diff -Nru linux-2.4.29-pre3-bk2/fs/ext3/fsync.c 
linux-2.4.29-pre3-bk2_fix/fs/ext3/fsync.c
--- linux-2.4.29-pre3-bk2/fs/ext3/fsync.c	2002-11-29 08:53:15.000000000 +0900
+++ linux-2.4.29-pre3-bk2_fix/fs/ext3/fsync.c	2005-01-04 19:58:32.000000000 +0900
@@ -69,7 +69,7 @@
  	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT3_MOUNT_WRITEBACK_DATA)
  		ret |= fsync_inode_data_buffers(inode);

-	ext3_force_commit(inode->i_sb);
+	ret |= ext3_force_commit(inode->i_sb);

  	return ret;
  }
diff -Nru linux-2.4.29-pre3-bk2/fs/ext3/super.c 
linux-2.4.29-pre3-bk2_fix/fs/ext3/super.c
--- linux-2.4.29-pre3-bk2/fs/ext3/super.c	2004-11-17 20:54:21.000000000 +0900
+++ linux-2.4.29-pre3-bk2_fix/fs/ext3/super.c	2005-01-04 19:58:32.000000000 +0900
@@ -1608,12 +1608,13 @@

  static int ext3_sync_fs(struct super_block *sb)
  {
+	int err;
  	tid_t target;

  	sb->s_dirt = 0;
  	target = log_start_commit(EXT3_SB(sb)->s_journal, NULL);
-	log_wait_commit(EXT3_SB(sb)->s_journal, target);
-	return 0;
+	err = log_wait_commit(EXT3_SB(sb)->s_journal, target);
+	return err;
  }

  /*
diff -Nru linux-2.4.29-pre3-bk2/fs/jbd/checkpoint.c 
linux-2.4.29-pre3-bk2_fix/fs/jbd/checkpoint.c
--- linux-2.4.29-pre3-bk2/fs/jbd/checkpoint.c	2002-11-29 08:53:15.000000000 +0900
+++ linux-2.4.29-pre3-bk2_fix/fs/jbd/checkpoint.c	2005-01-04 
19:58:32.000000000 +0900
@@ -142,7 +142,7 @@
  			spin_unlock(&journal_datalist_lock);
  			log_start_commit(journal, transaction);
  			unlock_journal(journal);
-			log_wait_commit(journal, tid);
+			(void) log_wait_commit(journal, tid);
  			goto out_return_1;
  		}

diff -Nru linux-2.4.29-pre3-bk2/fs/jbd/commit.c 
linux-2.4.29-pre3-bk2_fix/fs/jbd/commit.c
--- linux-2.4.29-pre3-bk2/fs/jbd/commit.c	2004-02-18 22:36:31.000000000 +0900
+++ linux-2.4.29-pre3-bk2_fix/fs/jbd/commit.c	2005-01-04 19:58:32.000000000 +0900
@@ -92,7 +92,7 @@
  	struct buffer_head *wbuf[64];
  	int bufs;
  	int flags;
-	int err;
+	int err = 0;
  	unsigned long blocknr;
  	char *tagp = NULL;
  	journal_header_t *header;
@@ -299,6 +299,8 @@
  			spin_unlock(&journal_datalist_lock);
  			unlock_journal(journal);
  			wait_on_buffer(bh);
+			if (unlikely(!buffer_uptodate(bh)))
+				err = -EIO;
  			/* the journal_head may have been removed now */
  			lock_journal(journal);
  			goto write_out_data;
@@ -326,6 +328,8 @@
  			spin_unlock(&journal_datalist_lock);
  			unlock_journal(journal);
  			wait_on_buffer(bh);
+			if (unlikely(!buffer_uptodate(bh)))
+				err = -EIO;
  			lock_journal(journal);
  			spin_lock(&journal_datalist_lock);
  			continue;	/* List may have changed */
@@ -351,6 +355,9 @@
  	}
  	spin_unlock(&journal_datalist_lock);

+	if (err)
+		__journal_abort_hard(journal);
+
  	/*
  	 * If we found any dirty or locked buffers, then we should have
  	 * looped back up to the write_out_data label.  If there weren't
@@ -541,6 +548,8 @@
  		if (buffer_locked(bh)) {
  			unlock_journal(journal);
  			wait_on_buffer(bh);
+			if (unlikely(!buffer_uptodate(bh)))
+				err = -EIO;
  			lock_journal(journal);
  			goto wait_for_iobuf;
  		}
@@ -602,6 +611,8 @@
  		if (buffer_locked(bh)) {
  			unlock_journal(journal);
  			wait_on_buffer(bh);
+			if (unlikely(!buffer_uptodate(bh)))
+				err = -EIO;
  			lock_journal(journal);
  			goto wait_for_ctlbuf;
  		}
@@ -650,6 +661,8 @@
  		bh->b_end_io = journal_end_buffer_io_sync;
  		submit_bh(WRITE, bh);
  		wait_on_buffer(bh);
+		if (unlikely(!buffer_uptodate(bh)))
+			err = -EIO;
  		put_bh(bh);		/* One for getblk() */
  		journal_unlock_journal_head(descriptor);
  	}
@@ -661,6 +674,9 @@

  skip_commit: /* The journal should be unlocked by now. */

+	if (err)
+		__journal_abort_hard(journal);
+
  	/* Call any callbacks that had been registered for handles in this
  	 * transaction.  It is up to the callback to free any allocated
  	 * memory.
diff -Nru linux-2.4.29-pre3-bk2/fs/jbd/journal.c 
linux-2.4.29-pre3-bk2_fix/fs/jbd/journal.c
--- linux-2.4.29-pre3-bk2/fs/jbd/journal.c	2004-11-17 20:54:21.000000000 +0900
+++ linux-2.4.29-pre3-bk2_fix/fs/jbd/journal.c	2005-01-04 
19:58:32.000000000 +0900
@@ -582,8 +582,10 @@
   * Wait for a specified commit to complete.
   * The caller may not hold the journal lock.
   */
-void log_wait_commit (journal_t *journal, tid_t tid)
+int log_wait_commit (journal_t *journal, tid_t tid)
  {
+	int err = 0;
+
  	lock_kernel();
  #ifdef CONFIG_JBD_DEBUG
  	lock_journal(journal);
@@ -600,6 +602,12 @@
  		sleep_on(&journal->j_wait_done_commit);
  	}
  	unlock_kernel();
+
+	if (unlikely(is_journal_aborted(journal))) {
+		printk(KERN_EMERG "journal commit I/O error\n");
+		err = -EIO;
+	}
+	return err;
  }

  /*
@@ -1326,7 +1334,7 @@

  	/* Wait for the log commit to complete... */
  	if (transaction)
-		log_wait_commit(journal, transaction->t_tid);
+		err = log_wait_commit(journal, transaction->t_tid);

  	/* ...and flush everything in the log out to disk. */
  	lock_journal(journal);
diff -Nru linux-2.4.29-pre3-bk2/fs/jbd/transaction.c 
linux-2.4.29-pre3-bk2_fix/fs/jbd/transaction.c
--- linux-2.4.29-pre3-bk2/fs/jbd/transaction.c	2004-08-08 
08:26:05.000000000 +0900
+++ linux-2.4.29-pre3-bk2_fix/fs/jbd/transaction.c	2005-01-04 
19:58:32.000000000 +0900
@@ -1484,7 +1484,7 @@
  		 * to wait for the commit to complete.
  		 */
  		if (handle->h_sync && !(current->flags & PF_MEMALLOC))
-			log_wait_commit(journal, tid);
+			err = log_wait_commit(journal, tid);
  	}
  	kfree(handle);
  	return err;
@@ -1509,7 +1509,7 @@
  		goto out;
  	}
  	handle->h_sync = 1;
-	journal_stop(handle);
+	ret = journal_stop(handle);
  out:
  	unlock_kernel();
  	return ret;
diff -Nru linux-2.4.29-pre3-bk2/include/linux/jbd.h 
linux-2.4.29-pre3-bk2_fix/include/linux/jbd.h
--- linux-2.4.29-pre3-bk2/include/linux/jbd.h	2004-11-17 20:54:22.000000000 +0900
+++ linux-2.4.29-pre3-bk2_fix/include/linux/jbd.h	2005-01-04 
19:58:32.000000000 +0900
@@ -848,7 +848,7 @@

  extern int	log_space_left (journal_t *); /* Called with journal locked */
  extern tid_t	log_start_commit (journal_t *, transaction_t *);
-extern void	log_wait_commit (journal_t *, tid_t);
+extern int	log_wait_commit (journal_t *, tid_t);
  extern int	log_do_checkpoint (journal_t *, int);

  extern void	log_wait_for_space(journal_t *, int nblocks);
diff -Nru linux-2.4.29-pre3-bk2/mm/filemap.c 
linux-2.4.29-pre3-bk2_fix/mm/filemap.c
--- linux-2.4.29-pre3-bk2/mm/filemap.c	2004-11-17 20:54:22.000000000 +0900
+++ linux-2.4.29-pre3-bk2_fix/mm/filemap.c	2005-01-04 19:58:32.000000000 +0900
@@ -3268,7 +3268,12 @@
  			status = generic_osync_inode(inode, OSYNC_METADATA|OSYNC_DATA);
  	}

-	err = written ? written : status;
+	/*
+	 * generic_osync_inode always returns 0 or negative value.
+	 * So 'status < written' is always true, and written should
+	 * be returned if status >= 0.
+	 */
+	err = (status < 0) ? status : written;
  out:

  	return err;





  Thanks,


----
Hisashi Hifumi  <hifumi.hisashi@lab.ntt.co.jp>
NTT Cyber Space Laboratories 

