Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbVCPJ55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVCPJ55 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 04:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbVCPJ55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 04:57:57 -0500
Received: from mx2.elte.hu ([157.181.151.9]:19857 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262311AbVCPJxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 04:53:41 -0500
Date: Wed, 16 Mar 2005 10:53:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: rostedt@goodmis.org, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: [patch 1/3] j_state_lock -> j_state_sem
Message-ID: <20050316095322.GA15460@elte.hu>
References: <Pine.LNX.4.58.0503140509170.697@localhost.localdomain> <Pine.LNX.4.58.0503141024530.697@localhost.localdomain> <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain> <20050315120053.GA4686@elte.hu> <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain> <20050315133540.GB4686@elte.hu> <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain> <20050316085029.GA11414@elte.hu> <20050316011510.2a3bdfdb.akpm@osdl.org> <20050316095155.GA15080@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316095155.GA15080@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch turns the j_state_lock spinlock into a mutex. 
Builds/boots/works fine on x86.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/fs/jbd/checkpoint.c.orig
+++ linux/fs/jbd/checkpoint.c
@@ -78,25 +78,24 @@ static int __try_to_free_cp_buf(struct j
 void __log_wait_for_space(journal_t *journal)
 {
 	int nblocks;
-	assert_spin_locked(&journal->j_state_lock);
 
 	nblocks = jbd_space_needed(journal);
 	while (__log_space_left(journal) < nblocks) {
 		if (journal->j_flags & JFS_ABORT)
 			return;
-		spin_unlock(&journal->j_state_lock);
+		up(&journal->j_state_sem);
 		down(&journal->j_checkpoint_sem);
 
 		/*
 		 * Test again, another process may have checkpointed while we
 		 * were waiting for the checkpoint lock
 		 */
-		spin_lock(&journal->j_state_lock);
+		down(&journal->j_state_sem);
 		nblocks = jbd_space_needed(journal);
 		if (__log_space_left(journal) < nblocks) {
-			spin_unlock(&journal->j_state_lock);
+			up(&journal->j_state_sem);
 			log_do_checkpoint(journal);
-			spin_lock(&journal->j_state_lock);
+			down(&journal->j_state_sem);
 		}
 		up(&journal->j_checkpoint_sem);
 	}
@@ -404,7 +403,7 @@ int cleanup_journal_tail(journal_t *jour
 	 * next transaction ID we will write, and where it will
 	 * start. */
 
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	spin_lock(&journal->j_list_lock);
 	transaction = journal->j_checkpoint_transactions;
 	if (transaction) {
@@ -426,7 +425,7 @@ int cleanup_journal_tail(journal_t *jour
 	/* If the oldest pinned transaction is at the tail of the log
            already then there's not much we can do right now. */
 	if (journal->j_tail_sequence == first_tid) {
-		spin_unlock(&journal->j_state_lock);
+		up(&journal->j_state_sem);
 		return 1;
 	}
 
@@ -445,7 +444,7 @@ int cleanup_journal_tail(journal_t *jour
 	journal->j_free += freed;
 	journal->j_tail_sequence = first_tid;
 	journal->j_tail = blocknr;
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 	if (!(journal->j_flags & JFS_ABORT))
 		journal_update_superblock(journal, 1);
 	return 0;
--- linux/fs/jbd/transaction.c.orig
+++ linux/fs/jbd/transaction.c
@@ -40,7 +40,7 @@
  *	new transaction	and we can't block without protecting against other
  *	processes trying to touch the journal while it is in transition.
  *
- * Called under j_state_lock
+ * Called under j_state_sem
  */
 
 static transaction_t *
@@ -109,21 +109,21 @@ alloc_transaction:
 repeat:
 
 	/*
-	 * We need to hold j_state_lock until t_updates has been incremented,
+	 * We need to hold j_state_sem until t_updates has been incremented,
 	 * for proper journal barrier handling
 	 */
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 repeat_locked:
 	if (is_journal_aborted(journal) ||
 	    (journal->j_errno != 0 && !(journal->j_flags & JFS_ACK_ERR))) {
-		spin_unlock(&journal->j_state_lock);
+		up(&journal->j_state_sem);
 		ret = -EROFS; 
 		goto out;
 	}
 
 	/* Wait on the journal's transaction barrier if necessary */
 	if (journal->j_barrier_count) {
-		spin_unlock(&journal->j_state_lock);
+		up(&journal->j_state_sem);
 		wait_event(journal->j_wait_transaction_locked,
 				journal->j_barrier_count == 0);
 		goto repeat;
@@ -131,7 +131,7 @@ repeat_locked:
 
 	if (!journal->j_running_transaction) {
 		if (!new_transaction) {
-			spin_unlock(&journal->j_state_lock);
+			up(&journal->j_state_sem);
 			goto alloc_transaction;
 		}
 		get_transaction(journal, new_transaction);
@@ -149,7 +149,7 @@ repeat_locked:
 
 		prepare_to_wait(&journal->j_wait_transaction_locked,
 					&wait, TASK_UNINTERRUPTIBLE);
-		spin_unlock(&journal->j_state_lock);
+		up(&journal->j_state_sem);
 		schedule();
 		finish_wait(&journal->j_wait_transaction_locked, &wait);
 		goto repeat;
@@ -176,7 +176,7 @@ repeat_locked:
 		prepare_to_wait(&journal->j_wait_transaction_locked, &wait,
 				TASK_UNINTERRUPTIBLE);
 		__log_start_commit(journal, transaction->t_tid);
-		spin_unlock(&journal->j_state_lock);
+		up(&journal->j_state_sem);
 		schedule();
 		finish_wait(&journal->j_wait_transaction_locked, &wait);
 		goto repeat;
@@ -225,7 +225,7 @@ repeat_locked:
 		  handle, nblocks, transaction->t_outstanding_credits,
 		  __log_space_left(journal));
 	spin_unlock(&transaction->t_handle_lock);
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 out:
 	if (new_transaction)
 		kfree(new_transaction);
@@ -321,7 +321,7 @@ int journal_extend(handle_t *handle, int
 
 	result = 1;
 
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 
 	/* Don't extend a locked-down transaction! */
 	if (handle->h_transaction->t_state != T_RUNNING) {
@@ -353,7 +353,7 @@ int journal_extend(handle_t *handle, int
 unlock:
 	spin_unlock(&transaction->t_handle_lock);
 error_out:
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 out:
 	return result;
 }
@@ -392,7 +392,7 @@ int journal_restart(handle_t *handle, in
 	J_ASSERT(transaction->t_updates > 0);
 	J_ASSERT(journal_current_handle() == handle);
 
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	spin_lock(&transaction->t_handle_lock);
 	transaction->t_outstanding_credits -= handle->h_buffer_credits;
 	transaction->t_updates--;
@@ -403,7 +403,7 @@ int journal_restart(handle_t *handle, in
 
 	jbd_debug(2, "restarting handle %p\n", handle);
 	__log_start_commit(journal, transaction->t_tid);
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 
 	handle->h_buffer_credits = nblocks;
 	ret = start_this_handle(journal, handle);
@@ -425,7 +425,7 @@ void journal_lock_updates(journal_t *jou
 {
 	DEFINE_WAIT(wait);
 
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	++journal->j_barrier_count;
 
 	/* Wait until there are no running updates */
@@ -443,12 +443,12 @@ void journal_lock_updates(journal_t *jou
 		prepare_to_wait(&journal->j_wait_updates, &wait,
 				TASK_UNINTERRUPTIBLE);
 		spin_unlock(&transaction->t_handle_lock);
-		spin_unlock(&journal->j_state_lock);
+		up(&journal->j_state_sem);
 		schedule();
 		finish_wait(&journal->j_wait_updates, &wait);
-		spin_lock(&journal->j_state_lock);
+		down(&journal->j_state_sem);
 	}
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 
 	/*
 	 * We have now established a barrier against other normal updates, but
@@ -472,9 +472,9 @@ void journal_unlock_updates (journal_t *
 	J_ASSERT(journal->j_barrier_count != 0);
 
 	up(&journal->j_barrier);
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	--journal->j_barrier_count;
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 	wake_up(&journal->j_wait_transaction_locked);
 }
 
@@ -1336,7 +1336,7 @@ int journal_stop(handle_t *handle)
 	}
 
 	current->journal_info = NULL;
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	spin_lock(&transaction->t_handle_lock);
 	transaction->t_outstanding_credits -= handle->h_buffer_credits;
 	transaction->t_updates--;
@@ -1366,7 +1366,7 @@ int journal_stop(handle_t *handle)
 					"handle %p\n", handle);
 		/* This is non-blocking */
 		__log_start_commit(journal, transaction->t_tid);
-		spin_unlock(&journal->j_state_lock);
+		up(&journal->j_state_sem);
 
 		/*
 		 * Special case: JFS_SYNC synchronous updates require us
@@ -1376,7 +1376,7 @@ int journal_stop(handle_t *handle)
 			err = log_wait_commit(journal, tid);
 	} else {
 		spin_unlock(&transaction->t_handle_lock);
-		spin_unlock(&journal->j_state_lock);
+		up(&journal->j_state_sem);
 	}
 
 	jbd_free_handle(handle);
@@ -1739,7 +1739,7 @@ static int journal_unmap_buffer(journal_
 	if (!buffer_jbd(bh))
 		goto zap_buffer_unlocked;
 
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	jbd_lock_bh_state(bh);
 	spin_lock(&journal->j_list_lock);
 
@@ -1776,7 +1776,7 @@ static int journal_unmap_buffer(journal_
 					journal->j_running_transaction);
 			spin_unlock(&journal->j_list_lock);
 			jbd_unlock_bh_state(bh);
-			spin_unlock(&journal->j_state_lock);
+			up(&journal->j_state_sem);
 			journal_put_journal_head(jh);
 			return ret;
 		} else {
@@ -1790,7 +1790,7 @@ static int journal_unmap_buffer(journal_
 					journal->j_committing_transaction);
 				spin_unlock(&journal->j_list_lock);
 				jbd_unlock_bh_state(bh);
-				spin_unlock(&journal->j_state_lock);
+				up(&journal->j_state_sem);
 				journal_put_journal_head(jh);
 				return ret;
 			} else {
@@ -1814,7 +1814,7 @@ static int journal_unmap_buffer(journal_
 		}
 		spin_unlock(&journal->j_list_lock);
 		jbd_unlock_bh_state(bh);
-		spin_unlock(&journal->j_state_lock);
+		up(&journal->j_state_sem);
 		journal_put_journal_head(jh);
 		return 0;
 	} else {
@@ -1833,7 +1833,7 @@ zap_buffer:
 zap_buffer_no_jh:
 	spin_unlock(&journal->j_list_lock);
 	jbd_unlock_bh_state(bh);
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 zap_buffer_unlocked:
 	clear_buffer_dirty(bh);
 	J_ASSERT_BH(bh, !buffer_jbddirty(bh));
--- linux/fs/jbd/commit.c.orig
+++ linux/fs/jbd/commit.c
@@ -144,9 +144,9 @@ static int journal_write_commit_record(j
 			"JBD: barrier-based sync failed on %s - "
 			"disabling barriers\n",
 			bdevname(journal->j_dev, b));
-		spin_lock(&journal->j_state_lock);
+		down(&journal->j_state_sem);
 		journal->j_flags &= ~JFS_BARRIER;
-		spin_unlock(&journal->j_state_lock);
+		up(&journal->j_state_sem);
 
 		/* And try again, without the barrier */
 		clear_buffer_ordered(bh);
@@ -211,7 +211,7 @@ void journal_commit_transaction(journal_
 	jbd_debug(1, "JBD: starting commit of transaction %d\n",
 			commit_transaction->t_tid);
 
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	commit_transaction->t_state = T_LOCKED;
 
 	spin_lock(&commit_transaction->t_handle_lock);
@@ -222,9 +222,9 @@ void journal_commit_transaction(journal_
 					TASK_UNINTERRUPTIBLE);
 		if (commit_transaction->t_updates) {
 			spin_unlock(&commit_transaction->t_handle_lock);
-			spin_unlock(&journal->j_state_lock);
+			up(&journal->j_state_sem);
 			schedule();
-			spin_lock(&journal->j_state_lock);
+			down(&journal->j_state_sem);
 			spin_lock(&commit_transaction->t_handle_lock);
 		}
 		finish_wait(&journal->j_wait_updates, &wait);
@@ -291,7 +291,7 @@ void journal_commit_transaction(journal_
 	journal->j_running_transaction = NULL;
 	commit_transaction->t_log_start = journal->j_head;
 	wake_up(&journal->j_wait_transaction_locked);
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 
 	jbd_debug (3, "JBD: commit phase 2\n");
 
@@ -806,16 +806,16 @@ restart_loop:
 	/*
 	 * This is a bit sleazy.  We borrow j_list_lock to protect
 	 * journal->j_committing_transaction in __journal_remove_checkpoint.
-	 * Really, __jornal_remove_checkpoint should be using j_state_lock but
+	 * Really, __jornal_remove_checkpoint should be using j_state_sem but
 	 * it's a bit hassle to hold that across __journal_remove_checkpoint
 	 */
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	spin_lock(&journal->j_list_lock);
 	commit_transaction->t_state = T_FINISHED;
 	J_ASSERT(commit_transaction == journal->j_committing_transaction);
 	journal->j_commit_sequence = commit_transaction->t_tid;
 	journal->j_committing_transaction = NULL;
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 
 	if (commit_transaction->t_checkpoint_list == NULL) {
 		__journal_drop_transaction(journal, commit_transaction);
--- linux/fs/jbd/journal.c.orig
+++ linux/fs/jbd/journal.c
@@ -148,7 +148,7 @@ int kjournald(void *arg)
 	/*
 	 * And now, wait forever for commit wakeup events.
 	 */
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 
 loop:
 	if (journal->j_flags & JFS_UNMOUNT)
@@ -159,10 +159,10 @@ loop:
 
 	if (journal->j_commit_sequence != journal->j_commit_request) {
 		jbd_debug(1, "OK, requests differ\n");
-		spin_unlock(&journal->j_state_lock);
+		up(&journal->j_state_sem);
 		del_timer_sync(journal->j_commit_timer);
 		journal_commit_transaction(journal);
-		spin_lock(&journal->j_state_lock);
+		down(&journal->j_state_sem);
 		goto loop;
 	}
 
@@ -174,9 +174,9 @@ loop:
 		 * be already stopped.
 		 */
 		jbd_debug(1, "Now suspending kjournald\n");
-		spin_unlock(&journal->j_state_lock);
+		up(&journal->j_state_sem);
 		refrigerator(PF_FREEZE);
-		spin_lock(&journal->j_state_lock);
+		down(&journal->j_state_sem);
 	} else {
 		/*
 		 * We assume on resume that commits are already there,
@@ -194,9 +194,9 @@ loop:
 						transaction->t_expires))
 			should_sleep = 0;
 		if (should_sleep) {
-			spin_unlock(&journal->j_state_lock);
+			up(&journal->j_state_sem);
 			schedule();
-			spin_lock(&journal->j_state_lock);
+			down(&journal->j_state_sem);
 		}
 		finish_wait(&journal->j_wait_commit, &wait);
 	}
@@ -214,7 +214,7 @@ loop:
 	goto loop;
 
 end_loop:
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 	del_timer_sync(journal->j_commit_timer);
 	journal->j_task = NULL;
 	wake_up(&journal->j_wait_done_commit);
@@ -230,16 +230,16 @@ static void journal_start_thread(journal
 
 static void journal_kill_thread(journal_t *journal)
 {
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	journal->j_flags |= JFS_UNMOUNT;
 
 	while (journal->j_task) {
 		wake_up(&journal->j_wait_commit);
-		spin_unlock(&journal->j_state_lock);
+		up(&journal->j_state_sem);
 		wait_event(journal->j_wait_done_commit, journal->j_task == 0);
-		spin_lock(&journal->j_state_lock);
+		down(&journal->j_state_sem);
 	}
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 }
 
 /*
@@ -408,15 +408,13 @@ repeat:
  *
  * Called with the journal already locked.
  *
- * Called under j_state_lock
+ * Called under j_state_sem
  */
 
 int __log_space_left(journal_t *journal)
 {
 	int left = journal->j_free;
 
-	assert_spin_locked(&journal->j_state_lock);
-
 	/*
 	 * Be pessimistic here about the number of those free blocks which
 	 * might be required for log descriptor control blocks.
@@ -433,7 +431,7 @@ int __log_space_left(journal_t *journal)
 }
 
 /*
- * Called under j_state_lock.  Returns true if a transaction was started.
+ * Called under j_state_sem.  Returns true if a transaction was started.
  */
 int __log_start_commit(journal_t *journal, tid_t target)
 {
@@ -460,9 +458,9 @@ int log_start_commit(journal_t *journal,
 {
 	int ret;
 
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	ret = __log_start_commit(journal, tid);
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 	return ret;
 }
 
@@ -481,7 +479,7 @@ int journal_force_commit_nested(journal_
 	transaction_t *transaction = NULL;
 	tid_t tid;
 
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	if (journal->j_running_transaction && !current->journal_info) {
 		transaction = journal->j_running_transaction;
 		__log_start_commit(journal, transaction->t_tid);
@@ -489,12 +487,12 @@ int journal_force_commit_nested(journal_
 		transaction = journal->j_committing_transaction;
 
 	if (!transaction) {
-		spin_unlock(&journal->j_state_lock);
+		up(&journal->j_state_sem);
 		return 0;	/* Nothing to retry */
 	}
 
 	tid = transaction->t_tid;
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 	log_wait_commit(journal, tid);
 	return 1;
 }
@@ -507,7 +505,7 @@ int journal_start_commit(journal_t *jour
 {
 	int ret = 0;
 
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	if (journal->j_running_transaction) {
 		tid_t tid = journal->j_running_transaction->t_tid;
 
@@ -522,7 +520,7 @@ int journal_start_commit(journal_t *jour
 		*ptid = journal->j_committing_transaction->t_tid;
 		ret = 1;
 	}
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 	return ret;
 }
 
@@ -535,25 +533,25 @@ int log_wait_commit(journal_t *journal, 
 	int err = 0;
 
 #ifdef CONFIG_JBD_DEBUG
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	if (!tid_geq(journal->j_commit_request, tid)) {
 		printk(KERN_EMERG
 		       "%s: error: j_commit_request=%d, tid=%d\n",
 		       __FUNCTION__, journal->j_commit_request, tid);
 	}
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 #endif
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	while (tid_gt(tid, journal->j_commit_sequence)) {
 		jbd_debug(1, "JBD: want %d, j_commit_sequence=%d\n",
 				  tid, journal->j_commit_sequence);
 		wake_up(&journal->j_wait_commit);
-		spin_unlock(&journal->j_state_lock);
+		up(&journal->j_state_sem);
 		wait_event(journal->j_wait_done_commit,
 				!tid_gt(tid, journal->j_commit_sequence));
-		spin_lock(&journal->j_state_lock);
+		down(&journal->j_state_sem);
 	}
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 
 	if (unlikely(is_journal_aborted(journal))) {
 		printk(KERN_EMERG "journal commit I/O error\n");
@@ -570,7 +568,7 @@ int journal_next_log_block(journal_t *jo
 {
 	unsigned long blocknr;
 
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	J_ASSERT(journal->j_free > 1);
 
 	blocknr = journal->j_head;
@@ -578,7 +576,7 @@ int journal_next_log_block(journal_t *jo
 	journal->j_free--;
 	if (journal->j_head == journal->j_last)
 		journal->j_head = journal->j_first;
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 	return journal_bmap(journal, blocknr, retp);
 }
 
@@ -675,7 +673,7 @@ static journal_t * journal_init_common (
 	init_MUTEX(&journal->j_checkpoint_sem);
 	spin_lock_init(&journal->j_revoke_lock);
 	spin_lock_init(&journal->j_list_lock);
-	spin_lock_init(&journal->j_state_lock);
+	init_MUTEX(&journal->j_state_sem);
 
 	journal->j_commit_interval = (HZ * JBD_DEFAULT_MAX_COMMIT_AGE);
 
@@ -955,14 +953,14 @@ void journal_update_superblock(journal_t
 		goto out;
 	}
 
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	jbd_debug(1,"JBD: updating superblock (start %ld, seq %d, errno %d)\n",
 		  journal->j_tail, journal->j_tail_sequence, journal->j_errno);
 
 	sb->s_sequence = cpu_to_be32(journal->j_tail_sequence);
 	sb->s_start    = cpu_to_be32(journal->j_tail);
 	sb->s_errno    = cpu_to_be32(journal->j_errno);
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 
 	BUFFER_TRACE(bh, "marking dirty");
 	mark_buffer_dirty(bh);
@@ -976,12 +974,12 @@ out:
 	 * any future commit will have to be careful to update the
 	 * superblock again to re-record the true start of the log. */
 
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	if (sb->s_start)
 		journal->j_flags &= ~JFS_FLUSHED;
 	else
 		journal->j_flags |= JFS_FLUSHED;
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 }
 
 /*
@@ -1343,7 +1341,7 @@ int journal_flush(journal_t *journal)
 	transaction_t *transaction = NULL;
 	unsigned long old_tail;
 
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 
 	/* Force everything buffered to the log... */
 	if (journal->j_running_transaction) {
@@ -1356,10 +1354,10 @@ int journal_flush(journal_t *journal)
 	if (transaction) {
 		tid_t tid = transaction->t_tid;
 
-		spin_unlock(&journal->j_state_lock);
+		up(&journal->j_state_sem);
 		log_wait_commit(journal, tid);
 	} else {
-		spin_unlock(&journal->j_state_lock);
+		up(&journal->j_state_sem);
 	}
 
 	/* ...and flush everything in the log out to disk. */
@@ -1377,12 +1375,12 @@ int journal_flush(journal_t *journal)
 	 * the magic code for a fully-recovered superblock.  Any future
 	 * commits of data to the journal will restore the current
 	 * s_start value. */
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	old_tail = journal->j_tail;
 	journal->j_tail = 0;
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 	journal_update_superblock(journal, 1);
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	journal->j_tail = old_tail;
 
 	J_ASSERT(!journal->j_running_transaction);
@@ -1390,7 +1388,7 @@ int journal_flush(journal_t *journal)
 	J_ASSERT(!journal->j_checkpoint_transactions);
 	J_ASSERT(journal->j_head == journal->j_tail);
 	J_ASSERT(journal->j_tail_sequence == journal->j_transaction_sequence);
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 	return err;
 }
 
@@ -1475,12 +1473,12 @@ void __journal_abort_hard(journal_t *jou
 	printk(KERN_ERR "Aborting journal on device %s.\n",
 		journal_dev_name(journal, b));
 
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	journal->j_flags |= JFS_ABORT;
 	transaction = journal->j_running_transaction;
 	if (transaction)
 		__log_start_commit(journal, transaction->t_tid);
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 }
 
 /* Soft abort: record the abort error status in the journal superblock,
@@ -1565,12 +1563,12 @@ int journal_errno(journal_t *journal)
 {
 	int err;
 
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	if (journal->j_flags & JFS_ABORT)
 		err = -EROFS;
 	else
 		err = journal->j_errno;
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 	return err;
 }
 
@@ -1585,12 +1583,12 @@ int journal_clear_err(journal_t *journal
 {
 	int err = 0;
 
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	if (journal->j_flags & JFS_ABORT)
 		err = -EROFS;
 	else
 		journal->j_errno = 0;
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 	return err;
 }
 
@@ -1603,10 +1601,10 @@ int journal_clear_err(journal_t *journal
  */
 void journal_ack_err(journal_t *journal)
 {
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	if (journal->j_errno)
 		journal->j_flags |= JFS_ACK_ERR;
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 }
 
 int journal_blocks_per_page(struct inode *inode)
--- linux/fs/ext3/super.c.orig
+++ linux/fs/ext3/super.c
@@ -1653,12 +1653,12 @@ static void ext3_init_journal_params(str
 	 * interval here, but for now we'll just fall back to the jbd
 	 * default. */
 
-	spin_lock(&journal->j_state_lock);
+	down(&journal->j_state_sem);
 	if (test_opt(sb, BARRIER))
 		journal->j_flags |= JFS_BARRIER;
 	else
 		journal->j_flags &= ~JFS_BARRIER;
-	spin_unlock(&journal->j_state_lock);
+	up(&journal->j_state_sem);
 }
 
 static journal_t *ext3_get_journal(struct super_block *sb, int journal_inum)
--- linux/include/linux/jbd.h.orig
+++ linux/include/linux/jbd.h
@@ -416,16 +416,16 @@ struct handle_s 
  *    j_list_lock
  *      ->jbd_lock_bh_journal_head()	(This is "innermost")
  *
- *    j_state_lock
+ *    j_state_sem
  *    ->jbd_lock_bh_state()
  *
  *    jbd_lock_bh_state()
  *    ->j_list_lock
  *
- *    j_state_lock
+ *    j_state_sem
  *    ->t_handle_lock
  *
- *    j_state_lock
+ *    j_state_sem
  *    ->j_list_lock			(journal_unmap_buffer)
  *
  */
@@ -442,7 +442,7 @@ struct transaction_s 
 	 * Transaction's current state
 	 * [no locking - only kjournald alters this]
 	 * FIXME: needs barriers
-	 * KLUDGE: [use j_state_lock]
+	 * KLUDGE: [use j_state_sem]
 	 */
 	enum {
 		T_RUNNING,
@@ -562,7 +562,7 @@ struct transaction_s 
  * @j_sb_buffer: First part of superblock buffer
  * @j_superblock: Second part of superblock buffer
  * @j_format_version: Version of the superblock format
- * @j_state_lock: Protect the various scalars in the journal
+ * @j_state_sem: Protect the various scalars in the journal
  * @j_barrier_count:  Number of processes waiting to create a barrier lock
  * @j_barrier: The barrier lock itself
  * @j_running_transaction: The current running transaction..
@@ -615,12 +615,12 @@ struct transaction_s 
 
 struct journal_s
 {
-	/* General journaling state flags [j_state_lock] */
+	/* General journaling state flags [j_state_sem] */
 	unsigned long		j_flags;
 
 	/*
 	 * Is there an outstanding uncleared error on the journal (from a prior
-	 * abort)? [j_state_lock]
+	 * abort)? [j_state_sem]
 	 */
 	int			j_errno;
 
@@ -634,10 +634,10 @@ struct journal_s
 	/*
 	 * Protect the various scalars in the journal
 	 */
-	spinlock_t		j_state_lock;
+	struct semaphore	j_state_sem;
 
 	/*
-	 * Number of processes waiting to create a barrier lock [j_state_lock]
+	 * Number of processes waiting to create a barrier lock [j_state_sem]
 	 */
 	int			j_barrier_count;
 
@@ -646,13 +646,13 @@ struct journal_s
 
 	/*
 	 * Transactions: The current running transaction...
-	 * [j_state_lock] [caller holding open handle]
+	 * [j_state_sem] [caller holding open handle]
 	 */
 	transaction_t		*j_running_transaction;
 
 	/*
 	 * the transaction we are pushing to disk
-	 * [j_state_lock] [caller holding open handle]
+	 * [j_state_sem] [caller holding open handle]
 	 */
 	transaction_t		*j_committing_transaction;
 
@@ -688,25 +688,25 @@ struct journal_s
 
 	/*
 	 * Journal head: identifies the first unused block in the journal.
-	 * [j_state_lock]
+	 * [j_state_sem]
 	 */
 	unsigned long		j_head;
 
 	/*
 	 * Journal tail: identifies the oldest still-used block in the journal.
-	 * [j_state_lock]
+	 * [j_state_sem]
 	 */
 	unsigned long		j_tail;
 
 	/*
 	 * Journal free: how many free blocks are there in the journal?
-	 * [j_state_lock]
+	 * [j_state_sem]
 	 */
 	unsigned long		j_free;
 
 	/*
 	 * Journal start and end: the block numbers of the first usable block
-	 * and one beyond the last usable block in the journal. [j_state_lock]
+	 * and one beyond the last usable block in the journal. [j_state_sem]
 	 */
 	unsigned long		j_first;
 	unsigned long		j_last;
@@ -739,24 +739,24 @@ struct journal_s
 	struct inode		*j_inode;
 
 	/*
-	 * Sequence number of the oldest transaction in the log [j_state_lock]
+	 * Sequence number of the oldest transaction in the log [j_state_sem]
 	 */
 	tid_t			j_tail_sequence;
 
 	/*
-	 * Sequence number of the next transaction to grant [j_state_lock]
+	 * Sequence number of the next transaction to grant [j_state_sem]
 	 */
 	tid_t			j_transaction_sequence;
 
 	/*
 	 * Sequence number of the most recently committed transaction
-	 * [j_state_lock].
+	 * [j_state_sem].
 	 */
 	tid_t			j_commit_sequence;
 
 	/*
 	 * Sequence number of the most recent transaction wanting commit
-	 * [j_state_lock]
+	 * [j_state_sem]
 	 */
 	tid_t			j_commit_request;
 
@@ -858,7 +858,7 @@ extern void		__wait_on_journal (journal_
  *
  * We need to lock the journal during transaction state changes so that nobody
  * ever tries to take a handle on the running transaction while we are in the
- * middle of moving it to the commit phase.  j_state_lock does this.
+ * middle of moving it to the commit phase.  j_state_sem does this.
  *
  * Note that the locking is completely interrupt unsafe.  We never touch
  * journal structures from interrupts.
@@ -1039,7 +1039,7 @@ extern int journal_blocks_per_page(struc
 
 /*
  * Return the minimum number of blocks which must be free in the journal
- * before a new transaction may be started.  Must be called under j_state_lock.
+ * before a new transaction may be started.  Must be called under j_state_sem.
  */
 static inline int jbd_space_needed(journal_t *journal)
 {
