Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318018AbSHVXPr>; Thu, 22 Aug 2002 19:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318040AbSHVXPr>; Thu, 22 Aug 2002 19:15:47 -0400
Received: from pc-62-31-66-89-ed.blueyonder.co.uk ([62.31.66.89]:32900 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318018AbSHVXPo>; Thu, 22 Aug 2002 19:15:44 -0400
Date: Fri, 23 Aug 2002 00:19:36 +0100
Message-Id: <200208222319.g7MNJaG09082@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 1/2] 2.4.20-pre4/ext3: Handle dirty buffers encountered unexpectedly.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ext3's internal debugging has always assumed that it was illegal for there to
be parallel IO on a buffer-head which it is trying to modify.  That's
reasonable --- if there is an IO collision, we end up with IOs hitting disk
out-of-order wrt the journal, so we lose recovery guarantees.

However, there are two cases where the test is a little over-zealous.  If
user space is performing inherently non-transactional writes (eg. tune2fs
adding a label to a live filesystem and writing to the buffered device
superblock location) then we can hit the ext3 assertion.

More seriously, since 2.4.11 the page cache can lock a buffer_head for read
even if the bh is already under journal control.  The tune2fs bug is very
rare: there have been no reports of it in Bugzilla or ext3-users lists, and
only one on 2.5 on linux-kernel.  But now, a dump(8) on a live filesystem
can also give rise to the same condition, and in testing, dump + fs activity
reproduces the assertion-failure VERY rapidly.

This patch changes the jbd get-write-access code to take the buffer_head
lock before testing the uptodate and dirty state of a bh, and relaxes the
handling of unexpectedly-dirty buffers to be a printk warning, not a
fatal error.  The lock will cure the dump(8) interaction, and the warning
means that we will still spot out-of-order writes, while not taking the
whole kernel down if we collide with a tune2fs(8).

The patch also removes a small potential hole in the recovery guarantees.  It
is not safe for a transaction to steal buffers from checkpoint mode until after
that transaction has committed.  Otherwise, a reboot at the wrong moment might
find the old copy of the buffer in the journal had been removed from the
recovery set before the new copy was written.

--- linux-ext3-2.4merge-2/include/linux/jbd.h.=K0000=.orig	Thu Aug 22 22:54:34 2002
+++ linux-ext3-2.4merge-2/include/linux/jbd.h	Thu Aug 22 23:43:16 2002
@@ -32,6 +32,14 @@
 
 #define journal_oom_retry 1
 
+/*
+ * Define JBD_PARANOID_WRITES to cause a kernel BUG() check if ext3
+ * finds a buffer unexpectedly dirty.  This is useful for debugging, but
+ * can cause spurious kernel panics if there are applications such as
+ * tune2fs modifying our buffer_heads behind our backs.
+ */
+#undef JBD_PARANOID_WRITES
+
 #ifdef CONFIG_JBD_DEBUG
 /*
  * Define JBD_EXPENSIVE_CHECKING to enable more expensive internal
@@ -730,6 +738,10 @@
 	schedule();						      \
 } while (1)
 
+extern void __jbd_unexpected_dirty_buffer(char *, int, struct journal_head *);
+#define jbd_unexpected_dirty_buffer(jh) \
+	__jbd_unexpected_dirty_buffer(__FUNCTION__, __LINE__, (jh))
+	
 /*
  * is_journal_abort
  *
--- linux-ext3-2.4merge-2/fs/jbd/transaction.c.=K0000=.orig	Thu Aug 22 22:53:28 2002
+++ linux-ext3-2.4merge-2/fs/jbd/transaction.c	Thu Aug 22 23:43:16 2002
@@ -539,76 +539,67 @@
 static int
 do_get_write_access(handle_t *handle, struct journal_head *jh, int force_copy) 
 {
+	struct buffer_head *bh;
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal = transaction->t_journal;
 	int error;
 	char *frozen_buffer = NULL;
 	int need_copy = 0;
-
+	int locked;
+	
 	jbd_debug(5, "buffer_head %p, force_copy %d\n", jh, force_copy);
 
 	JBUFFER_TRACE(jh, "entry");
 repeat:
+	bh = jh2bh(jh);
+
 	/* @@@ Need to check for errors here at some point. */
 
 	/*
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
 	 * AKPM: we have replaced all the lock_journal_bh_wait() stuff with a
 	 * simple lock_journal().  This code here will care for locked buffers.
 	 */
-	/*
-	 * The buffer_locked() || buffer_dirty() tests here are simply an
-	 * optimisation tweak.  If anyone else in the system decides to
-	 * lock this buffer later on, we'll blow up.  There doesn't seem
-	 * to be a good reason why they should do this.
-	 */
-	if (jh->b_cp_transaction &&
-	    (buffer_locked(jh2bh(jh)) || buffer_dirty(jh2bh(jh)))) {
+	locked = test_and_set_bit(BH_Lock, &bh->b_state);
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
-			/* And pull it off BUF_DIRTY, onto BUF_CLEAN */
-			refile_buffer(jh2bh(jh));
+		__wait_on_buffer(bh);
+		lock_journal(journal);
+		goto repeat;
+	}
+	
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
 
-			/*
-			 * The buffer is now hidden from bdflush.   It is
-			 * metadata against the current transaction.
-			 */
-			JBUFFER_TRACE(jh, "steal from cp mode is complete");
+	if (buffer_dirty(bh)) {
+		spin_lock(&journal_datalist_lock);
+		/* First question: is this buffer already part of the
+		 * current transaction or the existing committing
+		 * transaction? */
+		if (jh->b_transaction) {
+			J_ASSERT_JH(jh, jh->b_transaction == transaction || 
+				    jh->b_transaction == journal->j_committing_transaction);
+			if (jh->b_next_transaction)
+				J_ASSERT_JH(jh, jh->b_next_transaction == transaction);
+			JBUFFER_TRACE(jh, "Unexpected dirty buffer");
+			jbd_unexpected_dirty_buffer(jh);
 		}
 		spin_unlock(&journal_datalist_lock);
-		unlock_buffer(jh2bh(jh));
-		lock_journal(journal);
-		goto repeat;
 	}
 
-	J_ASSERT_JH(jh, !buffer_locked(jh2bh(jh)));
+	unlock_buffer(bh);
 
 	error = -EROFS;
 	if (is_handle_aborted(handle)) 
@@ -1978,6 +1969,10 @@
 	__blist_add_buffer(list, jh);
 	jh->b_jlist = jlist;
 
+	/* The following list of buffer states needs to be consistent
+	 * with __jbd_unexpected_dirty_buffer()'s handling of dirty
+	 * state. */
+
 	if (jlist == BJ_Metadata || jlist == BJ_Reserved || 
 	    jlist == BJ_Shadow || jlist == BJ_Forget) {
 		if (atomic_set_buffer_clean(jh2bh(jh))) {
--- linux-ext3-2.4merge-2/fs/jbd/journal.c.=K0000=.orig	Thu Aug 22 22:53:04 2002
+++ linux-ext3-2.4merge-2/fs/jbd/journal.c	Thu Aug 22 23:43:16 2002
@@ -1485,6 +1485,49 @@
 	unlock_journal(journal);
 }
 
+
+/*
+ * Report any unexpected dirty buffers which turn up.  Normally those
+ * indicate an error, but they can occur if the user is running (say)
+ * tune2fs to modify the live filesystem, so we need the option of
+ * continuing as gracefully as possible.  #
+ *
+ * The caller should already hold the journal lock and
+ * journal_datalist_lock spinlock: most callers will need those anyway
+ * in order to probe the buffer's journaling state safely.
+ */
+void __jbd_unexpected_dirty_buffer(char *function, int line, 
+				 struct journal_head *jh)
+{
+	struct buffer_head *bh = jh2bh(jh);
+	int jlist;
+	
+	if (buffer_dirty(bh)) {
+		printk ("%sUnexpected dirty buffer encountered at "
+			"%s:%d (%s blocknr %lu)\n",
+			KERN_WARNING, function, line,
+			kdevname(bh->b_dev), bh->b_blocknr);
+#ifdef JBD_PARANOID_WRITES
+		J_ASSERT_BH (bh, !buffer_dirty(bh));
+#endif	
+		
+		/* If this buffer is one which might reasonably be dirty
+		 * --- ie. data, or not part of this journal --- then
+		 * we're OK to leave it alone, but otherwise we need to
+		 * move the dirty bit to the journal's own internal
+		 * JBDDirty bit. */
+		jlist = jh->b_jlist;
+		
+		if (jlist == BJ_Metadata || jlist == BJ_Reserved || 
+		    jlist == BJ_Shadow || jlist == BJ_Forget) {
+			if (atomic_set_buffer_clean(jh2bh(jh))) {
+				set_bit(BH_JBDDirty, &jh2bh(jh)->b_state);
+			}
+		}
+	}
+}
+
+
 int journal_blocks_per_page(struct inode *inode)
 {
 	return 1 << (PAGE_CACHE_SHIFT - inode->i_sb->s_blocksize_bits);
