Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVCRJZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVCRJZN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 04:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVCRJZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 04:25:12 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:49809 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261539AbVCRJXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 04:23:31 -0500
Date: Fri, 18 Mar 2005 04:23:24 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Andrew Morton <akpm@osdl.org>
cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: [PATCH] remove lame schedule in journal inverted_lock (was: Re:
 [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks)
In-Reply-To: <Pine.LNX.4.58.0503170406500.17019@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0503180415370.21994@localhost.localdomain>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
 <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain> <20050315120053.GA4686@elte.hu>
 <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain> <20050315133540.GB4686@elte.hu>
 <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain> <20050316085029.GA11414@elte.hu>
 <20050316011510.2a3bdfdb.akpm@osdl.org> <20050316095155.GA15080@elte.hu>
 <20050316020408.434cc620.akpm@osdl.org> <20050316101906.GA17328@elte.hu>
 <20050316024022.6d5c4706.akpm@osdl.org> <Pine.LNX.4.58.0503160600200.11824@localhost.localdomain>
 <20050316031909.08e6cab7.akpm@osdl.org> <Pine.LNX.4.58.0503160853360.11824@localhost.localdomain>
 <Pine.LNX.4.58.0503161141001.14087@localhost.localdomain>
 <Pine.LNX.4.58.0503161234350.14460@localhost.localdomain>
 <20050316131521.48b1354e.akpm@osdl.org> <Pine.LNX.4.58.0503170406500.17019@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

Since I haven't gotten a response from you, I'd figure that you may have
missed this, since the subject didn't change.  So I changed the subject to
get your attention, and I've resent this. Here's the patch to get rid of
the the lame schedule that was in fs/jbd/commit.c.   Let me know if this
patch is appropriate.

Thanks,

-- Steve


On Thu, 17 Mar 2005, Steven Rostedt wrote:

>
>
> On Wed, 16 Mar 2005, Andrew Morton wrote:
>
> > >  I guess one way to solve this is to add a wait queue here (before
> > >  schedule()), and have the one holding the lock to wake up all on the
> > >  waitqueue when they release it.
> >
> > yup.  A patch against mainline would be appropriate, please.
> >
>
> Hi Andrew,
>
> Here's the patch against 2.6.11.  I tested it, by adding (after making the
> patch) global spinlocks for jbd_lock_bh_state and jbd_lock_bh_journalhead.
> That way I have same scenerio as with Ingo's kernel, and I turned on
> NEED_JOURNAL_STATE_WAIT.  I'm still running that kernel so it looks like
> it works.  Making those two locks global causes this deadlock on kjournal
> much quicker, and I don't need to run on an SMP machine (since my SMP
> machines are currently being used for other tasks).
>
> Some comments on my patch.  I only implement the wait queue when
> bit_spin_trylock is an actual lock (thus creating the problem). I didn't
> want to add this code if it was needed (ie. !(CONFIG_SMP &&
> CONFIG_DEBUG_SPINLOCKS)).  So in bit_spin_trylock, I define
> NEED_JOURNAL_STATE_WAIT if bit_spin_trylock is really a lock.  When
> NEED_JOURNAL_STATE_WAIT is set, then the wait queue is set up in the
> journal code.
>
> Now the question is, should we make those two locks global? It would help
> Ingo's cause (and mine as well). But I don't know the impact on a large
> SMP configuration.  Andrew, since you have a 16xSMP machine, could you (if
> you have time) try out the effect of that. If you do have time, then I'll
> send you a patch that goes on top of this one to change the two locks into
> global spin locks.
>
> Ingo, where do you want to go from here? I guess we need to wait on what
> Andrew decides.
>
> -- Steve
>
>

diff -ur linux-2.6.11.orig/fs/jbd/commit.c linux-2.6.11/fs/jbd/commit.c
--- linux-2.6.11.orig/fs/jbd/commit.c	2005-03-02 02:38:25.000000000 -0500
+++ linux-2.6.11/fs/jbd/commit.c	2005-03-17 03:40:06.000000000 -0500
@@ -80,15 +80,33 @@

 /*
  * Try to acquire jbd_lock_bh_state() against the buffer, when j_list_lock is
- * held.  For ranking reasons we must trylock.  If we lose, schedule away and
- * return 0.  j_list_lock is dropped in this case.
+ * held.  For ranking reasons we must trylock.  If we lose put ourselves on a
+ * state wait queue and we'll be woken up when it is unlocked. Then we return
+ * 0 to try this again.  j_list_lock is dropped in this case.
  */
 static int inverted_lock(journal_t *journal, struct buffer_head *bh)
 {
 	if (!jbd_trylock_bh_state(bh)) {
+		/*
+		 * jbd_trylock_bh_state always returns true unless CONFIG_SMP or
+		 * CONFIG_DEBUG_SPINLOCK, so the wait queue is not needed there.
+		 * The bit_spin_locks in jbd_lock_bh_state need to be removed anyway.
+		 */
+#ifdef NEED_JOURNAL_STATE_WAIT
+		DECLARE_WAITQUEUE(wait, current);
 		spin_unlock(&journal->j_list_lock);
-		schedule();
+		add_wait_queue_exclusive(&journal_state_wait,&wait);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		/* Check to see if the lock has been unlocked in this short time */
+		if (jbd_is_locked_bh_state(bh))
+			schedule();
+		set_current_state(TASK_RUNNING);
+		remove_wait_queue(&journal_state_wait,&wait);
 		return 0;
+#else
+		/* This should never be hit */
+		BUG();
+#endif
 	}
 	return 1;
 }
diff -ur linux-2.6.11.orig/fs/jbd/journal.c linux-2.6.11/fs/jbd/journal.c
--- linux-2.6.11.orig/fs/jbd/journal.c	2005-03-02 02:37:49.000000000 -0500
+++ linux-2.6.11/fs/jbd/journal.c	2005-03-17 03:47:40.000000000 -0500
@@ -80,6 +80,11 @@
 EXPORT_SYMBOL(journal_try_to_free_buffers);
 EXPORT_SYMBOL(journal_force_commit);

+#ifdef NEED_JOURNAL_STATE_WAIT
+EXPORT_SYMBOL(journal_state_wait);
+DECLARE_WAIT_QUEUE_HEAD(journal_state_wait);
+#endif
+
 static int journal_convert_superblock_v1(journal_t *, journal_superblock_t *);

 /*
diff -ur linux-2.6.11.orig/include/linux/jbd.h linux-2.6.11/include/linux/jbd.h
--- linux-2.6.11.orig/include/linux/jbd.h	2005-03-02 02:38:19.000000000 -0500
+++ linux-2.6.11/include/linux/jbd.h	2005-03-17 03:48:18.000000000 -0500
@@ -324,6 +324,20 @@
 	return bh->b_private;
 }

+#ifdef NEED_JOURNAL_STATE_WAIT
+/*
+ * The journal_state_wait is a wait queue that tasks will wait on
+ * if they fail to get the jbd_lock_bh_state while holding the j_list_lock.
+ * Instead of spinning on schedule, the task now adds itself to this wait queue
+ * and will be woken up when the jbd_lock_bh_state is released.
+ *
+ * Since the bit_spin_locks are only locks under CONFIG_SMP and
+ * CONFIG_DEBUG_SPINLOCK, this wait queue is only needed in those
+ * cases.
+ */
+extern wait_queue_head_t journal_state_wait;
+#endif
+
 static inline void jbd_lock_bh_state(struct buffer_head *bh)
 {
 	bit_spin_lock(BH_State, &bh->b_state);
@@ -342,6 +356,13 @@
 static inline void jbd_unlock_bh_state(struct buffer_head *bh)
 {
 	bit_spin_unlock(BH_State, &bh->b_state);
+#ifdef NEED_JOURNAL_STATE_WAIT
+	/*
+	 * There may be a task sleeping, and waiting to be woken up
+	 * when this is unlocked.
+	 */
+	wake_up(&journal_state_wait);
+#endif
 }

 static inline void jbd_lock_bh_journal_head(struct buffer_head *bh)
diff -ur linux-2.6.11.orig/include/linux/spinlock.h linux-2.6.11/include/linux/spinlock.h
--- linux-2.6.11.orig/include/linux/spinlock.h	2005-03-02 02:38:09.000000000 -0500
+++ linux-2.6.11/include/linux/spinlock.h	2005-03-17 03:39:13.024466071 -0500
@@ -527,6 +527,9 @@
  *
  * Don't use this unless you really need to: spin_lock() and spin_unlock()
  * are significantly faster.
+ *
+ * FIXME: These are evil and need to be removed. They are currently only
+ *  used by the journal code of ext3.
  */
 static inline void bit_spin_lock(int bitnum, unsigned long *addr)
 {
@@ -557,6 +560,13 @@
 {
 	preempt_disable();
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	/*
+	 * This is only used by the journal code of ext3 and if this
+	 * is set then we need to tell the journal code that it needs
+	 * a wait queue to keep kjournald from spinning on a lock.
+	 */
+#define NEED_JOURNAL_STATE_WAIT
+
 	if (test_and_set_bit(bitnum, addr)) {
 		preempt_enable();
 		return 0;
