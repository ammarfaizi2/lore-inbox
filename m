Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVC3Cra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVC3Cra (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 21:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVC3Cra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 21:47:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40172 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261162AbVC3CrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 21:47:10 -0500
Date: Tue, 29 Mar 2005 18:52:07 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: vherva@viasys.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.30-rc3 md/ext3 problems
Message-ID: <20050329215207.GE5018@logos.cnet>
References: <20050326162801.GA20729@logos.cnet> <20050328073405.GQ16169@viasys.com> <20050328165501.GR16169@viasys.com> <16968.40186.628410.152511@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <16968.40186.628410.152511@cse.unsw.edu.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 29, 2005 at 10:10:34AM +1000, Neil Brown wrote:
> On Monday March 28, vherva@vianova.fi wrote:
> > On Mon, Mar 28, 2005 at 10:34:05AM +0300, [Ville Herva] wrote:
> > > 
> > > I just upgraded from linux-2.4.21 + vserser 0.17 to 2.4.30rc3 + vserver
> > > 1.2.10. The box has been running stable with 2.4.21 + vserver 0.17/0.16 for
> > > a few years (uptime before reboot was nearly 400 days.)
> > > 
> > > The boot went fine, but after few hours I got 
> > > Message from syslogd@box at Sun Mar 27 22:07:00 2005 ...
> > > kernel: journal commit I/O error
> 
> I got that error on 2.4.30-rc1 a couple of times, and now cannot
> reproduce it :-(
> But if you got it too, then it wasn't just bad luck.
> 
> The ext3 code in 2.4.30-rc does have a few more checks for IO errors
> which will cause the journal to be aborted and produce this error, so
> I suspect that change which caused the problem is a change in ext3.
> However that doesn't mean the bug is there.
> 
> The extra code in ext3 seems to just check if buffer_uptodate is false
> after it has waited on a locked buffer, and triggers a journal abort
> if it isn't.  This should be perfectly safe, and I cannot find any
> logic error near by.  But nor can I find any errors that would cause a
> buffer returned from raid1 to not be uptodate (unless there really was
> an IO error).

Attached is the backout patch, for convenience.

--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="revert-ext3-eh.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/29 18:49:25-03:00 marcelo@logos.cnet 
#   Cset exclude: hifumi.hisashi@lab.ntt.co.jp|ChangeSet|20050226095914|25750
# 
# mm/filemap.c
#   2005/03/29 18:49:22-03:00 marcelo@logos.cnet +0 -0
#   Exclude
# 
# include/linux/jbd.h
#   2005/03/29 18:49:22-03:00 marcelo@logos.cnet +0 -0
#   Exclude
# 
# fs/jbd/transaction.c
#   2005/03/29 18:49:21-03:00 marcelo@logos.cnet +0 -0
#   Exclude
# 
# fs/jbd/journal.c
#   2005/03/29 18:49:21-03:00 marcelo@logos.cnet +0 -0
#   Exclude
# 
# fs/jbd/commit.c
#   2005/03/29 18:49:21-03:00 marcelo@logos.cnet +0 -0
#   Exclude
# 
# fs/ext3/super.c
#   2005/03/29 18:49:21-03:00 marcelo@logos.cnet +0 -0
#   Exclude
# 
# fs/ext3/fsync.c
#   2005/03/29 18:49:21-03:00 marcelo@logos.cnet +0 -0
#   Exclude
# 
diff -Nru a/fs/ext3/fsync.c b/fs/ext3/fsync.c
--- a/fs/ext3/fsync.c	2005-03-29 18:50:56 -03:00
+++ b/fs/ext3/fsync.c	2005-03-29 18:50:56 -03:00
@@ -69,7 +69,7 @@
 	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT3_MOUNT_WRITEBACK_DATA)
 		ret |= fsync_inode_data_buffers(inode);
 
-	ret |= ext3_force_commit(inode->i_sb);
+	ext3_force_commit(inode->i_sb);
 
 	return ret;
 }
diff -Nru a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	2005-03-29 18:50:56 -03:00
+++ b/fs/ext3/super.c	2005-03-29 18:50:56 -03:00
@@ -1608,13 +1608,12 @@
 
 static int ext3_sync_fs(struct super_block *sb)
 {
-	int err;
 	tid_t target;
 	
 	sb->s_dirt = 0;
 	target = log_start_commit(EXT3_SB(sb)->s_journal, NULL);
-	err = log_wait_commit(EXT3_SB(sb)->s_journal, target);
-	return err;
+	log_wait_commit(EXT3_SB(sb)->s_journal, target);
+	return 0;
 }
 
 /*
diff -Nru a/fs/jbd/commit.c b/fs/jbd/commit.c
--- a/fs/jbd/commit.c	2005-03-29 18:50:55 -03:00
+++ b/fs/jbd/commit.c	2005-03-29 18:50:55 -03:00
@@ -92,7 +92,7 @@
 	struct buffer_head *wbuf[64];
 	int bufs;
 	int flags;
-	int err = 0;
+	int err;
 	unsigned long blocknr;
 	char *tagp = NULL;
 	journal_header_t *header;
@@ -299,8 +299,6 @@
 			spin_unlock(&journal_datalist_lock);
 			unlock_journal(journal);
 			wait_on_buffer(bh);
-			if (unlikely(!buffer_uptodate(bh)))
-				err = -EIO;
 			/* the journal_head may have been removed now */
 			lock_journal(journal);
 			goto write_out_data;
@@ -328,8 +326,6 @@
 			spin_unlock(&journal_datalist_lock);
 			unlock_journal(journal);
 			wait_on_buffer(bh);
-			if (unlikely(!buffer_uptodate(bh)))
-				err = -EIO;
 			lock_journal(journal);
 			spin_lock(&journal_datalist_lock);
 			continue;	/* List may have changed */
@@ -355,9 +351,6 @@
 	}
 	spin_unlock(&journal_datalist_lock);
 
-	if (err)
-		__journal_abort_hard(journal);
-
 	/*
 	 * If we found any dirty or locked buffers, then we should have
 	 * looped back up to the write_out_data label.  If there weren't
@@ -548,8 +541,6 @@
 		if (buffer_locked(bh)) {
 			unlock_journal(journal);
 			wait_on_buffer(bh);
-			if (unlikely(!buffer_uptodate(bh)))
-				err = -EIO;
 			lock_journal(journal);
 			goto wait_for_iobuf;
 		}
@@ -611,8 +602,6 @@
 		if (buffer_locked(bh)) {
 			unlock_journal(journal);
 			wait_on_buffer(bh);
-			if (unlikely(!buffer_uptodate(bh)))
-				err = -EIO;
 			lock_journal(journal);
 			goto wait_for_ctlbuf;
 		}
@@ -661,8 +650,6 @@
 		bh->b_end_io = journal_end_buffer_io_sync;
 		submit_bh(WRITE, bh);
 		wait_on_buffer(bh);
-		if (unlikely(!buffer_uptodate(bh)))
-			err = -EIO;
 		put_bh(bh);		/* One for getblk() */
 		journal_unlock_journal_head(descriptor);
 	}
@@ -674,9 +661,6 @@
 
 skip_commit: /* The journal should be unlocked by now. */
 
-	if (err)
-		__journal_abort_hard(journal);
-	
 	/* Call any callbacks that had been registered for handles in this
 	 * transaction.  It is up to the callback to free any allocated
 	 * memory.
diff -Nru a/fs/jbd/journal.c b/fs/jbd/journal.c
--- a/fs/jbd/journal.c	2005-03-29 18:50:55 -03:00
+++ b/fs/jbd/journal.c	2005-03-29 18:50:55 -03:00
@@ -582,10 +582,8 @@
  * Wait for a specified commit to complete.
  * The caller may not hold the journal lock.
  */
-int log_wait_commit (journal_t *journal, tid_t tid)
+void log_wait_commit (journal_t *journal, tid_t tid)
 {
-	int err = 0;
-
 	lock_kernel();
 #ifdef CONFIG_JBD_DEBUG
 	lock_journal(journal);
@@ -602,12 +600,6 @@
 		sleep_on(&journal->j_wait_done_commit);
 	}
 	unlock_kernel();
-
-	if (unlikely(is_journal_aborted(journal))) {
-		printk(KERN_EMERG "journal commit I/O error\n");
-		err = -EIO;
-	}
-	return err;
 }
 
 /*
@@ -1334,7 +1326,7 @@
 
 	/* Wait for the log commit to complete... */
 	if (transaction)
-		err = log_wait_commit(journal, transaction->t_tid);
+		log_wait_commit(journal, transaction->t_tid);
 
 	/* ...and flush everything in the log out to disk. */
 	lock_journal(journal);
diff -Nru a/fs/jbd/transaction.c b/fs/jbd/transaction.c
--- a/fs/jbd/transaction.c	2005-03-29 18:50:55 -03:00
+++ b/fs/jbd/transaction.c	2005-03-29 18:50:55 -03:00
@@ -1484,7 +1484,7 @@
 		 * to wait for the commit to complete.  
 		 */
 		if (handle->h_sync && !(current->flags & PF_MEMALLOC))
-			err = log_wait_commit(journal, tid);
+			log_wait_commit(journal, tid);
 	}
 	kfree(handle);
 	return err;
@@ -1509,7 +1509,7 @@
 		goto out;
 	}
 	handle->h_sync = 1;
-	ret = journal_stop(handle);
+	journal_stop(handle);
 out:
 	unlock_kernel();
 	return ret;
diff -Nru a/include/linux/jbd.h b/include/linux/jbd.h
--- a/include/linux/jbd.h	2005-03-29 18:50:55 -03:00
+++ b/include/linux/jbd.h	2005-03-29 18:50:55 -03:00
@@ -848,7 +848,7 @@
 
 extern int	log_space_left (journal_t *); /* Called with journal locked */
 extern tid_t	log_start_commit (journal_t *, transaction_t *);
-extern int	log_wait_commit (journal_t *, tid_t);
+extern void	log_wait_commit (journal_t *, tid_t);
 extern int	log_do_checkpoint (journal_t *, int);
 
 extern void	log_wait_for_space(journal_t *, int nblocks);
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	2005-03-29 18:50:55 -03:00
+++ b/mm/filemap.c	2005-03-29 18:50:55 -03:00
@@ -3261,12 +3261,7 @@
 			status = generic_osync_inode(inode, OSYNC_METADATA|OSYNC_DATA);
 	}
 	
-	/*
-	 * generic_osync_inode always returns 0 or negative value.
-	 * So 'status < written' is always true, and written should
-	 * be returned if status >= 0.
-	 */
-	err = (status < 0) ? status : written;
+	err = written ? written : status;
 out:
 
 	return err;

--W/nzBZO5zC0uMSeA--
