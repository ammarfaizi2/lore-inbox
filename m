Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315096AbSESTnJ>; Sun, 19 May 2002 15:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315050AbSESTly>; Sun, 19 May 2002 15:41:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18436 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315210AbSESTlR>;
	Sun, 19 May 2002 15:41:17 -0400
Message-ID: <3CE800B6.57F6B724@zip.com.au>
Date: Sun, 19 May 2002 12:44:54 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 13/15] fix ext3 buffer-stealing
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch from sct fixes a long-standing (I did it!) and rather complex
problem with ext3.

The problem is to do with buffers which are continually being dirtied
by an external agent.  I had code in there (for easily-triggerable
livelock avoidance) which steals the buffer from checkpoint mode and
reattaches it to the running transaction.  This violates ext3 ordering
requirements - it can permit journal space to be reclaimed before the
relevant data has really been written out.

Also, we do have to reliably get a lock on the buffer when moving it
between lists and inspecting its internal state.  Otherwise a competing
read from the underlying block device can trigger an assertion failure,
and a competing write to the underlying block device can confuse ext3
journalling state completely.


=====================================

--- 2.5.16/fs/jbd/transaction.c~ext3-no-steal	Sun May 19 11:49:49 2002
+++ 2.5.16-akpm/fs/jbd/transaction.c	Sun May 19 12:02:55 2002
@@ -518,6 +518,38 @@ void journal_unlock_updates (journal_t *
 }
 
 /*
+ * Report any unexpected dirty buffers which turn up.  Normally those
+ * indicate an error, but they can occur if the user is running (say)
+ * tune2fs to modify the live filesystem, so we need the option of
+ * continuing as gracefully as possible.  #
+ *
+ * The caller should already hold the journal lock and
+ * journal_datalist_lock spinlock: most callers will need those anyway
+ * in order to probe the buffer's journaling state safely.
+ */
+static void jbd_unexpected_dirty_buffer(struct journal_head *jh)
+{
+	struct buffer_head *bh = jh2bh(jh);
+	int jlist;
+	
+	if (buffer_dirty(bh)) {
+		/* If this buffer is one which might reasonably be dirty
+		 * --- ie. data, or not part of this journal --- then
+		 * we're OK to leave it alone, but otherwise we need to
+		 * move the dirty bit to the journal's own internal
+		 * JBDDirty bit. */
+		jlist = jh->b_jlist;
+		
+		if (jlist == BJ_Metadata || jlist == BJ_Reserved || 
+		    jlist == BJ_Shadow || jlist == BJ_Forget) {
+			if (test_clear_buffer_dirty(jh2bh(jh))) {
+				set_bit(BH_JBDDirty, &jh2bh(jh)->b_state);
+			}
+		}
+	}
+}
+
+/*
  * journal_get_write_access: notify intent to modify a buffer for metadata
  * (not data) update.
  *
@@ -538,72 +570,66 @@ void journal_unlock_updates (journal_t *
 static int
 do_get_write_access(handle_t *handle, struct journal_head *jh, int force_copy) 
 {
+	struct buffer_head *bh;
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal = transaction->t_journal;
 	int error;
 	char *frozen_buffer = NULL;
 	int need_copy = 0;
+	int locked;
 
 	jbd_debug(5, "buffer_head %p, force_copy %d\n", jh, force_copy);
 
 	JBUFFER_TRACE(jh, "entry");
 repeat:
+	bh = jh2bh(jh);
+
 	/* @@@ Need to check for errors here at some point. */
 
-	/*
-	 * AKPM: neither bdflush nor kupdate run with the BKL.   There's
-	 * nothing we can do to prevent them from starting writeout of a
-	 * BUF_DIRTY buffer at any time.  And checkpointing buffers are on
-	 * BUF_DIRTY.  So.  We no longer assert that the buffer is unlocked.
-	 *
-	 * However.  It is very wrong for us to allow ext3 to start directly
-	 * altering the ->b_data of buffers which may at that very time be
-	 * undergoing writeout to the client filesystem.  This can leave
-	 * the filesystem in an inconsistent, transient state if we crash.
-	 * So what we do is to steal the buffer if it is in checkpoint
-	 * mode and dirty.  The journal lock will keep out checkpoint-mode
-	 * state transitions within journal_remove_checkpoint() and the buffer
-	 * is locked to keep bdflush/kupdate/whoever away from it as well.
-	 *
-	 * AKPM: we have replaced all the lock_journal_bh_wait() stuff with a
-	 * simple lock_journal().  This code here will care for locked buffers.
-	 */
-	/*
-	 * The buffer_locked() || buffer_dirty() tests here are simply an
-	 * optimisation tweak.  If anyone else in the system decides to
-	 * lock this buffer later on, we'll blow up.  There doesn't seem
-	 * to be a good reason why they should do this.
-	 */
-	if (jh->b_cp_transaction &&
-	    (buffer_locked(jh2bh(jh)) || buffer_dirty(jh2bh(jh)))) {
+	locked = test_set_buffer_locked(bh);
+	if (locked) {
+		/* We can't reliably test the buffer state if we found
+		 * it already locked, so just wait for the lock and
+		 * retry. */
 		unlock_journal(journal);
-		lock_buffer(jh2bh(jh));
-		spin_lock(&journal_datalist_lock);
-		if (jh->b_cp_transaction && buffer_dirty(jh2bh(jh))) {
-			/* OK, we need to steal it */
-			JBUFFER_TRACE(jh, "stealing from checkpoint mode");
-			J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
-			J_ASSERT_JH(jh, jh->b_frozen_data == NULL);
-
-			J_ASSERT(handle->h_buffer_credits > 0);
-			handle->h_buffer_credits--;
-
-			/* This will clear BH_Dirty and set BH_JBDDirty. */
-			JBUFFER_TRACE(jh, "file as BJ_Reserved");
-			__journal_file_buffer(jh, transaction, BJ_Reserved);
-
-			/*
-			 * The buffer is now hidden from bdflush.   It is
-			 * metadata against the current transaction.
-			 */
-			JBUFFER_TRACE(jh, "steal from cp mode is complete");
-		}
-		spin_unlock(&journal_datalist_lock);
-		unlock_buffer(jh2bh(jh));
+		wait_on_buffer(bh);
 		lock_journal(journal);
+		goto repeat;
 	}
 
-	J_ASSERT_JH(jh, !buffer_locked(jh2bh(jh)));
+	/* We now hold the buffer lock so it is safe to query the buffer
+	 * state.  Is the buffer dirty? 
+	 * 
+	 * If so, there are two possibilities.  The buffer may be
+	 * non-journaled, and undergoing a quite legitimate writeback.
+	 * Otherwise, it is journaled, and we don't expect dirty buffers
+	 * in that state (the buffers should be marked JBD_Dirty
+	 * instead.)  So either the IO is being done under our own
+	 * control and this is a bug, or it's a third party IO such as
+	 * dump(8) (which may leave the buffer scheduled for read ---
+	 * ie. locked but not dirty) or tune2fs (which may actually have
+	 * the buffer dirtied, ugh.)  */
+
+	if (buffer_dirty(bh)) {
+		spin_lock(&journal_datalist_lock);
+		/* First question: is this buffer already part of the
+		 * current transaction or the existing committing
+		 * transaction? */
+		if (jh->b_transaction) {
+			J_ASSERT_JH(jh,
+				jh->b_transaction == transaction || 
+				jh->b_transaction ==
+					journal->j_committing_transaction);
+			if (jh->b_next_transaction)
+				J_ASSERT_JH(jh, jh->b_next_transaction ==
+							transaction);
+			JBUFFER_TRACE(jh, "Unexpected dirty buffer");
+			jbd_unexpected_dirty_buffer(jh);
+ 		}
+ 		spin_unlock(&journal_datalist_lock);
+ 	}
+
+	unlock_buffer(bh);
 
 	error = -EROFS;
 	if (is_handle_aborted(handle)) 

-
