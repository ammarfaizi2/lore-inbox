Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263372AbUCSAAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbUCRX5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:57:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:52930 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263349AbUCRXzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:55:42 -0500
Date: Thu, 18 Mar 2004 15:57:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: tiwai@suse.de, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-Id: <20040318155745.36d4785d.akpm@osdl.org>
In-Reply-To: <1079650437.11058.31.camel@watt.suse.com>
References: <40591EC1.1060204@geizhals.at>
	<20040318060358.GC29530@dualathlon.random>
	<s5hlllycgz3.wl@alsa2.suse.de>
	<20040318143205.6a9c4e89.akpm@osdl.org>
	<1079650437.11058.31.camel@watt.suse.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> > What we're doing here is walking (under spinlock) a ring of buffers
> > searching for unlocked dirty ones to write out.
> > 
> > Suppose the ring has thousands of locked buffers and there is a RT task
> > scheduling at 1kHz.  Each time need_resched() comes true we break out of
> > the search, schedule away and then restart the search from the beginning.
> > 
> Why not just put all the locked buffers onto a different list as you
> find them or lock them.  That way you can always make progress...

Coz that made me look at the code and hence rewrite the whole thing, damn
you.  It's definitely better, but is of scary scope.


diff -puN fs/jbd/commit.c~jbd-move-locked-buffers fs/jbd/commit.c
--- 25/fs/jbd/commit.c~jbd-move-locked-buffers	Thu Mar 18 15:01:18 2004
+++ 25-akpm/fs/jbd/commit.c	Thu Mar 18 15:53:05 2004
@@ -88,7 +88,6 @@ void journal_commit_transaction(journal_
 {
 	transaction_t *commit_transaction;
 	struct journal_head *jh, *new_jh, *descriptor;
-	struct journal_head *next_jh, *last_jh;
 	struct buffer_head *wbuf[64];
 	int bufs;
 	int flags;
@@ -222,38 +221,55 @@ void journal_commit_transaction(journal_
 	err = 0;
 	/*
 	 * Whenever we unlock the journal and sleep, things can get added
-	 * onto ->t_datalist, so we have to keep looping back to write_out_data
-	 * until we *know* that the list is empty.
+	 * onto ->t_sync_datalist, so we have to keep looping back to
+	 * write_out_data until we *know* that the list is empty.
 	 */
-write_out_data:
-
+	bufs = 0;
 	/*
 	 * Cleanup any flushed data buffers from the data list.  Even in
 	 * abort mode, we want to flush this out as soon as possible.
-	 *
-	 * We take j_list_lock to protect the lists from
-	 * journal_try_to_free_buffers().
 	 */
+write_out_data:
 	spin_lock(&journal->j_list_lock);
 
-write_out_data_locked:
-	bufs = 0;
-	next_jh = commit_transaction->t_sync_datalist;
-	if (next_jh == NULL)
-		goto sync_datalist_empty;
-	last_jh = next_jh->b_tprev;
-
-	do {
+	while (commit_transaction->t_sync_datalist) {
 		struct buffer_head *bh;
 
-		jh = next_jh;
-		next_jh = jh->b_tnext;
+		jh = commit_transaction->t_sync_datalist;
+		commit_transaction->t_sync_datalist = jh->b_tnext;
 		bh = jh2bh(jh);
-		if (!buffer_locked(bh)) {
+		if (buffer_locked(bh)) {
+			/*
+			 * We have a lock ranking problem..
+			 */
+			if (!jbd_trylock_bh_state(bh)) {
+				spin_unlock(&journal->j_list_lock);
+				schedule();
+				goto write_out_data;
+			}
+			__journal_unfile_buffer(jh);
+			__journal_file_buffer(jh, jh->b_transaction, BJ_Locked);
+			jbd_unlock_bh_state(bh);
+			if (need_resched()) {
+				spin_unlock(&journal->j_list_lock);
+				cond_resched();
+				goto write_out_data;
+			}
+		} else {
 			if (buffer_dirty(bh)) {
 				BUFFER_TRACE(bh, "start journal writeout");
 				atomic_inc(&bh->b_count);
 				wbuf[bufs++] = bh;
+				if (bufs == ARRAY_SIZE(wbuf)) {
+					jbd_debug(2, "submit %d writes\n",
+							bufs);
+					spin_unlock(&journal->j_list_lock);
+					ll_rw_block(WRITE, bufs, wbuf);
+					journal_brelse_array(wbuf, bufs);
+					cond_resched();
+					bufs = 0;
+					goto write_out_data;
+				}
 			} else {
 				BUFFER_TRACE(bh, "writeout complete: unfile");
 				/*
@@ -269,66 +285,53 @@ write_out_data_locked:
 				jbd_unlock_bh_state(bh);
 				journal_remove_journal_head(bh);
 				__brelse(bh);
-				if (need_resched() && commit_transaction->
-							t_sync_datalist) {
-					commit_transaction->t_sync_datalist =
-								next_jh;
-					if (bufs)
-						break;
+				if (need_resched()) {
 					spin_unlock(&journal->j_list_lock);
 					cond_resched();
 					goto write_out_data;
 				}
 			}
 		}
-		if (bufs == ARRAY_SIZE(wbuf)) {
-			/*
-			 * Major speedup: start here on the next scan
-			 */
-			J_ASSERT(commit_transaction->t_sync_datalist != 0);
-			commit_transaction->t_sync_datalist = jh;
-			break;
-		}
-	} while (jh != last_jh);
-
-	if (bufs || need_resched()) {
-		jbd_debug(2, "submit %d writes\n", bufs);
-		spin_unlock(&journal->j_list_lock);
-		if (bufs)
-			ll_rw_block(WRITE, bufs, wbuf);
-		cond_resched();
-		journal_brelse_array(wbuf, bufs);
-		spin_lock(&journal->j_list_lock);
-		goto write_out_data_locked;
 	}
 
 	/*
-	 * Wait for all previously submitted IO on the data list to complete.
+	 * Wait for all previously submitted IO to complete.
 	 */
-	jh = commit_transaction->t_sync_datalist;
-	if (jh == NULL)
-		goto sync_datalist_empty;
-
-	do {
+	while (commit_transaction->t_locked_list) {
 		struct buffer_head *bh;
-		jh = jh->b_tprev;	/* Wait on the last written */
+
+		jh = commit_transaction->t_locked_list->b_tprev;
 		bh = jh2bh(jh);
+		get_bh(bh);
 		if (buffer_locked(bh)) {
-			get_bh(bh);
 			spin_unlock(&journal->j_list_lock);
 			wait_on_buffer(bh);
 			if (unlikely(!buffer_uptodate(bh)))
 				err = -EIO;
+			spin_lock(&journal->j_list_lock);
+		}
+		if (!jbd_trylock_bh_state(bh)) {
 			put_bh(bh);
-			/* the journal_head may have been removed now */
-			goto write_out_data;
-		} else if (buffer_dirty(bh)) {
-			goto write_out_data_locked;
+			spin_unlock(&journal->j_list_lock);
+			schedule();
+			spin_lock(&journal->j_list_lock);
+			continue;
 		}
-	} while (jh != commit_transaction->t_sync_datalist);
-	goto write_out_data_locked;
-
-sync_datalist_empty:
+		if (buffer_jbd(bh) && jh->b_jlist == BJ_Locked) {
+			__journal_unfile_buffer(jh);
+			jh->b_transaction = NULL;
+			jbd_unlock_bh_state(bh);
+			journal_remove_journal_head(bh);
+		} else {
+			jbd_unlock_bh_state(bh);
+		}
+		put_bh(bh);
+		if (need_resched()) {
+			spin_unlock(&journal->j_list_lock);
+			cond_resched();
+			spin_lock(&journal->j_list_lock);
+		}
+	}
 	spin_unlock(&journal->j_list_lock);
 
 	journal_write_revoke_records(journal, commit_transaction);
diff -puN include/linux/jbd.h~jbd-move-locked-buffers include/linux/jbd.h
--- 25/include/linux/jbd.h~jbd-move-locked-buffers	Thu Mar 18 15:07:29 2004
+++ 25-akpm/include/linux/jbd.h	Thu Mar 18 15:09:46 2004
@@ -487,6 +487,12 @@ struct transaction_s 
 	struct journal_head	*t_reserved_list;
 
 	/*
+	 * Doubly-linked circular list of all buffers under writeout during
+	 * commit [j_list_lock]
+	 */
+	struct journal_head	*t_locked_list;
+
+	/*
 	 * Doubly-linked circular list of all metadata buffers owned by this
 	 * transaction [j_list_lock]
 	 */
@@ -1080,6 +1086,7 @@ static inline int jbd_space_needed(journ
 #define BJ_LogCtl	6	/* Buffer contains log descriptors */
 #define BJ_Reserved	7	/* Buffer is reserved for access by journal */
 #define BJ_Types	8
+#define BJ_Locked	9	/* Locked for I/O during commit */
  
 extern int jbd_blocks_per_page(struct inode *inode);
 
diff -puN fs/jbd/transaction.c~jbd-move-locked-buffers fs/jbd/transaction.c
--- 25/fs/jbd/transaction.c~jbd-move-locked-buffers	Thu Mar 18 15:10:21 2004
+++ 25-akpm/fs/jbd/transaction.c	Thu Mar 18 15:56:56 2004
@@ -1010,7 +1010,8 @@ int journal_dirty_data(handle_t *handle,
 			 * the write() data.
 			 */
 			if (jh->b_jlist != BJ_None &&
-					jh->b_jlist != BJ_SyncData) {
+					jh->b_jlist != BJ_SyncData &&
+					jh->b_jlist != BJ_Locked) {
 				JBUFFER_TRACE(jh, "Not stealing");
 				goto no_journal;
 			}
@@ -1048,7 +1049,7 @@ int journal_dirty_data(handle_t *handle,
 		 * committing transaction, so might still be left on that
 		 * transaction's metadata lists.
 		 */
-		if (jh->b_jlist != BJ_SyncData) {
+		if (jh->b_jlist != BJ_SyncData && jh->b_jlist != BJ_Locked) {
 			JBUFFER_TRACE(jh, "not on correct data list: unfile");
 			J_ASSERT_JH(jh, jh->b_jlist != BJ_Shadow);
 			__journal_unfile_buffer(jh);
@@ -1539,6 +1540,9 @@ void __journal_unfile_buffer(struct jour
 	case BJ_Reserved:
 		list = &transaction->t_reserved_list;
 		break;
+	case BJ_Locked:
+		list = &transaction->t_locked_list;
+		break;
 	}
 
 	__blist_del_buffer(list, jh);
@@ -1576,7 +1580,7 @@ __journal_try_to_free_buffer(journal_t *
 
 	spin_lock(&journal->j_list_lock);
 	if (jh->b_transaction != 0 && jh->b_cp_transaction == 0) {
-		if (jh->b_jlist == BJ_SyncData) {
+		if (jh->b_jlist == BJ_SyncData || jh->b_jlist == BJ_Locked) {
 			/* A written-back ordered data buffer */
 			JBUFFER_TRACE(jh, "release data");
 			__journal_unfile_buffer(jh);
@@ -1985,6 +1989,9 @@ void __journal_file_buffer(struct journa
 	case BJ_Reserved:
 		list = &transaction->t_reserved_list;
 		break;
+	case BJ_Locked:
+		list =  &transaction->t_locked_list;
+		break;
 	}
 
 	__blist_add_buffer(list, jh);

_

