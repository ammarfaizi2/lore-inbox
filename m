Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315245AbSGDXuX>; Thu, 4 Jul 2002 19:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSGDXtH>; Thu, 4 Jul 2002 19:49:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46093 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315218AbSGDXqx>;
	Thu, 4 Jul 2002 19:46:53 -0400
Message-ID: <3D24E063.50E71943@zip.com.au>
Date: Thu, 04 Jul 2002 16:55:15 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 23/27] JBD commit callback capability
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This is a patch which Stephen has applied to ext3's 2.4 repository. 
Originally written by Andreas, generalised somewhat by Stephen.

Add jbd callback mechanism, requested for InterMezzo.  We allow the jbd's
client to request notification when a given handle's IO finally commits to
disk, so that clients can manage their own writeback state asynchronously.




 fs/jbd/checkpoint.c  |    3 +-
 fs/jbd/commit.c      |   31 ++++++++++++++++++++----
 fs/jbd/journal.c     |    1 
 fs/jbd/transaction.c |   65 +++++++++++++++++++++++++++++++++++++++++----------
 include/linux/jbd.h  |   20 +++++++++++++++
 5 files changed, 102 insertions(+), 18 deletions(-)

--- 2.5.24/include/linux/jbd.h~jbd-callback	Thu Jul  4 16:17:32 2002
+++ 2.5.24-akpm/include/linux/jbd.h	Thu Jul  4 16:17:32 2002
@@ -250,6 +250,13 @@ static inline struct journal_head *bh2jh
 	return bh->b_private;
 }
 
+#define HAVE_JOURNAL_CALLBACK_STATUS
+struct journal_callback {
+	struct list_head jcb_list;
+	void (*jcb_func)(struct journal_callback *jcb, int error);
+	/* user data goes here */
+};
+
 struct jbd_revoke_table_s;
 
 /* The handle_t type represents a single atomic update being performed
@@ -280,6 +287,12 @@ struct handle_s 
 	   operations */
 	int			h_err;
 
+	/* List of application registered callbacks for this handle.
+	 * The function(s) will be called after the transaction that
+	 * this handle is part of has been committed to disk.
+	 */
+	struct list_head	h_jcb;
+
 	/* Flags */
 	unsigned int	h_sync:		1;	/* sync-on-close */
 	unsigned int	h_jdata:	1;	/* force data journaling */
@@ -399,6 +412,10 @@ struct transaction_s 
 
 	/* How many handles used this transaction? */
 	int t_handle_count;
+
+	/* List of registered callback functions for this transaction.
+	 * Called when the transaction is committed. */
+	struct list_head	t_jcb;
 };
 
 
@@ -647,6 +664,9 @@ extern int	 journal_invalidatepage(journ
 extern int	 journal_try_to_free_buffers(journal_t *, struct page *, int);
 extern int	 journal_stop(handle_t *);
 extern int	 journal_flush (journal_t *);
+extern void	 journal_callback_set(handle_t *handle,
+				      void (*fn)(struct journal_callback *,int),
+				      struct journal_callback *jcb);
 
 extern void	 journal_lock_updates (journal_t *);
 extern void	 journal_unlock_updates (journal_t *);
--- 2.5.24/fs/jbd/checkpoint.c~jbd-callback	Thu Jul  4 16:17:32 2002
+++ 2.5.24-akpm/fs/jbd/checkpoint.c	Thu Jul  4 16:17:32 2002
@@ -592,7 +592,8 @@ void __journal_drop_transaction(journal_
 	J_ASSERT (transaction->t_log_list == NULL);
 	J_ASSERT (transaction->t_checkpoint_list == NULL);
 	J_ASSERT (transaction->t_updates == 0);
-	
+	J_ASSERT (list_empty(&transaction->t_jcb));
+
 	J_ASSERT (transaction->t_journal->j_committing_transaction !=
 					transaction);
 	
--- 2.5.24/fs/jbd/commit.c~jbd-callback	Thu Jul  4 16:17:32 2002
+++ 2.5.24-akpm/fs/jbd/commit.c	Thu Jul  4 16:17:32 2002
@@ -471,7 +471,7 @@ start_journal_io:
            transaction's t_log_list queue, and metadata buffers are on
            the t_iobuf_list queue.
 
-	   Wait for the transactions in reverse order.  That way we are
+	   Wait for the buffers in reverse order.  That way we are
 	   less likely to be woken up until all IOs have completed, and
 	   so we incur less scheduling load.
 	*/
@@ -563,8 +563,10 @@ start_journal_io:
 
 	jbd_debug(3, "JBD: commit phase 6\n");
 
-	if (is_journal_aborted(journal))
+	if (is_journal_aborted(journal)) {
+		unlock_journal(journal);
 		goto skip_commit;
+	}
 
 	/* Done it all: now write the commit record.  We should have
 	 * cleaned up our previous buffers by now, so if we are in abort
@@ -574,9 +576,10 @@ start_journal_io:
 	descriptor = journal_get_descriptor_buffer(journal);
 	if (!descriptor) {
 		__journal_abort_hard(journal);
+		unlock_journal(journal);
 		goto skip_commit;
 	}
-	
+
 	/* AKPM: buglet - add `i' to tmp! */
 	for (i = 0; i < jh2bh(descriptor)->b_size; i += 512) {
 		journal_header_t *tmp =
@@ -596,14 +599,32 @@ start_journal_io:
 		__brelse(bh);		/* One for getblk() */
 		journal_unlock_journal_head(descriptor);
 	}
-	lock_journal(journal);
 
 	/* End of a transaction!  Finally, we can do checkpoint
            processing: any buffers committed as a result of this
            transaction can be removed from any checkpoint list it was on
            before. */
 
-skip_commit:
+skip_commit: /* The journal should be unlocked by now. */
+
+	/* Call any callbacks that had been registered for handles in this
+	 * transaction.  It is up to the callback to free any allocated
+	 * memory.
+	 */
+	if (!list_empty(&commit_transaction->t_jcb)) {
+		struct list_head *p, *n;
+		int error = is_journal_aborted(journal);
+
+		list_for_each_safe(p, n, &commit_transaction->t_jcb) {
+			struct journal_callback *jcb;
+
+			jcb = list_entry(p, struct journal_callback, jcb_list);
+			list_del(p);
+			jcb->jcb_func(jcb, error);
+		}
+	}
+
+	lock_journal(journal);
 
 	jbd_debug(3, "JBD: commit phase 7\n");
 
--- 2.5.24/fs/jbd/journal.c~jbd-callback	Thu Jul  4 16:17:32 2002
+++ 2.5.24-akpm/fs/jbd/journal.c	Thu Jul  4 16:17:32 2002
@@ -58,6 +58,7 @@ EXPORT_SYMBOL(journal_sync_buffer);
 #endif
 EXPORT_SYMBOL(journal_flush);
 EXPORT_SYMBOL(journal_revoke);
+EXPORT_SYMBOL(journal_callback_set);
 
 EXPORT_SYMBOL(journal_init_dev);
 EXPORT_SYMBOL(journal_init_inode);
--- 2.5.24/fs/jbd/transaction.c~jbd-callback	Thu Jul  4 16:17:32 2002
+++ 2.5.24-akpm/fs/jbd/transaction.c	Thu Jul  4 16:17:32 2002
@@ -57,6 +57,7 @@ static transaction_t * get_transaction (
 	transaction->t_state = T_RUNNING;
 	transaction->t_tid = journal->j_transaction_sequence++;
 	transaction->t_expires = jiffies + journal->j_commit_interval;
+	INIT_LIST_HEAD(&transaction->t_jcb);
 
 	/* Set up the commit timer for the new transaction. */
 	J_ASSERT (!journal->j_commit_timer_active);
@@ -90,7 +91,14 @@ static int start_this_handle(journal_t *
 	transaction_t *transaction;
 	int needed;
 	int nblocks = handle->h_buffer_credits;
-	
+
+	if (nblocks > journal->j_max_transaction_buffers) {
+		printk(KERN_ERR "JBD: %s wants too many credits (%d > %d)\n",
+		       current->comm, nblocks,
+		       journal->j_max_transaction_buffers);
+		return -ENOSPC;
+	}
+
 	jbd_debug(3, "New handle %p going live.\n", handle);
 
 repeat:
@@ -200,6 +208,20 @@ repeat_locked:
 	return 0;
 }
 
+/* Allocate a new handle.  This should probably be in a slab... */
+static handle_t *new_handle(int nblocks)
+{
+	handle_t *handle = jbd_kmalloc(sizeof (handle_t), GFP_NOFS);
+	if (!handle)
+		return NULL;
+	memset(handle, 0, sizeof (handle_t));
+	handle->h_buffer_credits = nblocks;
+	handle->h_ref = 1;
+	INIT_LIST_HEAD(&handle->h_jcb);
+
+	return handle;
+}
+
 /*
  * Obtain a new handle.  
  *
@@ -226,14 +248,11 @@ handle_t *journal_start(journal_t *journ
 		handle->h_ref++;
 		return handle;
 	}
-	
-	handle = jbd_kmalloc(sizeof (handle_t), GFP_NOFS);
+
+	handle = new_handle(nblocks);
 	if (!handle)
 		return ERR_PTR(-ENOMEM);
-	memset (handle, 0, sizeof (handle_t));
 
-	handle->h_buffer_credits = nblocks;
-	handle->h_ref = 1;
 	current->journal_info = handle;
 
 	err = start_this_handle(journal, handle);
@@ -332,14 +351,11 @@ handle_t *journal_try_start(journal_t *j
 	
 	if (is_journal_aborted(journal))
 		return ERR_PTR(-EIO);
-	
-	handle = jbd_kmalloc(sizeof (handle_t), GFP_NOFS);
+
+	handle = new_handle(nblocks);
 	if (!handle)
 		return ERR_PTR(-ENOMEM);
-	memset (handle, 0, sizeof (handle_t));
 
-	handle->h_buffer_credits = nblocks;
-	handle->h_ref = 1;
 	current->journal_info = handle;
 
 	err = try_start_this_handle(journal, handle);
@@ -1348,6 +1364,28 @@ out:
 #endif
 
 /*
+ * Register a callback function for this handle.  The function will be
+ * called when the transaction that this handle is part of has been
+ * committed to disk with the original callback data struct and the
+ * error status of the journal as parameters.  There is no guarantee of
+ * ordering between handles within a single transaction, nor between
+ * callbacks registered on the same handle.
+ *
+ * The caller is responsible for allocating the journal_callback struct.
+ * This is to allow the caller to add as much extra data to the callback
+ * as needed, but reduce the overhead of multiple allocations.  The caller
+ * allocated struct must start with a struct journal_callback at offset 0,
+ * and has the caller-specific data afterwards.
+ */
+void journal_callback_set(handle_t *handle,
+			  void (*func)(struct journal_callback *jcb, int error),
+			  struct journal_callback *jcb)
+{
+	list_add_tail(&jcb->jcb_list, &handle->h_jcb);
+	jcb->jcb_func = func;
+}
+
+/*
  * All done for a particular handle.
  *
  * There is not much action needed here.  We just return any remaining
@@ -1411,7 +1449,10 @@ int journal_stop(handle_t *handle)
 			wake_up(&journal->j_wait_transaction_locked);
 	}
 
-	/* 
+	/* Move callbacks from the handle to the transaction. */
+	list_splice(&handle->h_jcb, &transaction->t_jcb);
+
+	/*
 	 * If the handle is marked SYNC, we need to set another commit
 	 * going!  We also want to force a commit if the current
 	 * transaction is occupying too much of the log, or if the

-
