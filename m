Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVCKUuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVCKUuJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 15:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVCKUtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 15:49:50 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:42122 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261697AbVCKUkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 15:40:23 -0500
Date: Fri, 11 Mar 2005 15:39:58 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
In-Reply-To: <20050311153817.GA32020@elte.hu>
Message-ID: <Pine.LNX.4.58.0503111440190.22043@localhost.localdomain>
References: <20050204100347.GA13186@elte.hu> <1108789704.8411.9.camel@krustophenia.net>
 <Pine.LNX.4.58.0503100323370.14016@localhost.localdomain>
 <Pine.LNX.4.58.0503100447150.14016@localhost.localdomain> <20050311095747.GA21820@elte.hu>
 <Pine.LNX.4.58.0503110508360.19798@localhost.localdomain> <20050311101740.GA23120@elte.hu>
 <Pine.LNX.4.58.0503110521390.19798@localhost.localdomain>
 <20050311024322.690eb3a9.akpm@osdl.org> <Pine.LNX.4.58.0503110754240.19798@localhost.localdomain>
 <20050311153817.GA32020@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Mar 2005, Ingo Molnar wrote:

>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > Here's the patch. It's probably more of an overkill wrt buffer heads,
> > but it seems to be the easiest solution.
>
> isnt there some ext3-private journal structure (journal-bh) linked off
> the bh? If the lock is in that structure then the overhead would only
> affect ext3.
>

OK, here it is (Yuck!).  I was able to use the journal head (private data
of the buffer head) for the state lock.  I just decided to have the
journal head lock be one global lock for all buffer heads, since it is
used to add and remove the journal private data from the buffer head, and
thus can't be stored in the journal private data.

The state lock is now in the journal private data but we must be careful
not to free this data before we unlock it. So here's what I've done.

  static inline void jbd_lock_bh_state(struct buffer_head *bh)
  {
	BUG_ON(!bh->b_private);
	atomic_inc(&bh2jh(bh)->b_state_wait_count);
	spin_lock(&bh2jh(bh)->b_state_lock);
  }

I have a counter of those that want/have the lock, and this informs the
journal_remove_journal_head that it should not free the jh.

  static void __journal_remove_journal_head(struct buffer_head *bh)
  {
	struct journal_head *jh = bh2jh(bh);

	J_ASSERT_JH(jh, jh->b_jcount >= 0);

	get_bh(bh);
	if (jh->b_jcount == 0) {
		if (jh->b_transaction == NULL &&
				jh->b_next_transaction == NULL &&
				jh->b_cp_transaction == NULL) {
  #ifdef CONFIG_PREEMPT_RT
			if (atomic_read(&jh->b_state_wait_count)) {
				BUG_ON(buffer_journalhead(bh));
				set_buffer_journalhead(bh);
			} else
  #endif
                        {


Here the state_wait_count is checked, and if > 0, then using the bit that
was originally used for locking the journal head, is set to inform the
unlocking of the state lock that it needs to be removed.

  static inline void jbd_unlock_bh_state(struct buffer_head *bh)
  {
	int rmjh = 0;

	BUG_ON(!atomic_read(&bh2jh(bh)->b_state_wait_count));
	atomic_dec(&bh2jh(bh)->b_state_wait_count);

	if (buffer_journalhead(bh)) {
		clear_buffer_journalhead(bh);
		rmjh = 1;
	}

	spin_unlock(&bh2jh(bh)->b_state_lock);

	if (rmjh)
		journal_remove_journal_head(bh);
  }

Now in the unlocking of the state lock, the journal head bit is tested and
if it is set, then the remove journal head function is called.


Maybe this isn't the cleanest solution, but it keeps the overhead on the
buffer heads down, so it's prefered over my last patch.

Once again, this has only been tested with full preemption enabled, but I
tried to keep it from changing the way non PREEMPT_RT works.

I'm leaving now for the weekend, so I won't be able to respond to anyone
till Monday.  I'll also run this patch over the weekend while compiling
the kernel in an endless loop

 while [ 1 ]; do
   make clean; make
 done

With kjournal running FIFO, to see if it survives.

Cheers,


-- Steve

diff -ur linux-2.6.11-rc4-V0.7.39-02.orig/fs/jbd/journal.c linux-2.6.11-rc4-V0.7.39-02/fs/jbd/journal.c
--- linux-2.6.11-rc4-V0.7.39-02.orig/fs/jbd/journal.c	2005-02-12 22:05:29.000000000 -0500
+++ linux-2.6.11-rc4-V0.7.39-02/fs/jbd/journal.c	2005-03-11 14:54:21.000000000 -0500
@@ -80,6 +80,10 @@
 EXPORT_SYMBOL(journal_try_to_free_buffers);
 EXPORT_SYMBOL(journal_force_commit);

+#ifdef CONFIG_PREEMPT_RT
+spinlock_t jbd_journal_head_lock = SPIN_LOCK_UNLOCKED;
+#endif
+
 static int journal_convert_superblock_v1(journal_t *, journal_superblock_t *);

 /*
@@ -1727,6 +1731,9 @@
 		jh = new_jh;
 		new_jh = NULL;		/* We consumed it */
 		set_buffer_jbd(bh);
+#ifdef CONFIG_PREEMPT_RT
+		spin_lock_init(&jh->b_state_lock);
+#endif
 		bh->b_private = jh;
 		jh->b_bh = bh;
 		get_bh(bh);
@@ -1767,26 +1774,34 @@
 		if (jh->b_transaction == NULL &&
 				jh->b_next_transaction == NULL &&
 				jh->b_cp_transaction == NULL) {
-			J_ASSERT_BH(bh, buffer_jbd(bh));
-			J_ASSERT_BH(bh, jh2bh(jh) == bh);
-			BUFFER_TRACE(bh, "remove journal_head");
-			if (jh->b_frozen_data) {
-				printk(KERN_WARNING "%s: freeing "
-						"b_frozen_data\n",
-						__FUNCTION__);
-				kfree(jh->b_frozen_data);
-			}
-			if (jh->b_committed_data) {
-				printk(KERN_WARNING "%s: freeing "
-						"b_committed_data\n",
-						__FUNCTION__);
-				kfree(jh->b_committed_data);
+#ifdef CONFIG_PREEMPT_RT
+			if (atomic_read(&jh->b_state_wait_count)) {
+				BUG_ON(buffer_journalhead(bh));
+				set_buffer_journalhead(bh);
+			} else
+#endif
+			{
+				J_ASSERT_BH(bh, buffer_jbd(bh));
+				J_ASSERT_BH(bh, jh2bh(jh) == bh);
+				BUFFER_TRACE(bh, "remove journal_head");
+				if (jh->b_frozen_data) {
+					printk(KERN_WARNING "%s: freeing "
+					       "b_frozen_data\n",
+					       __FUNCTION__);
+					kfree(jh->b_frozen_data);
+				}
+				if (jh->b_committed_data) {
+					printk(KERN_WARNING "%s: freeing "
+					       "b_committed_data\n",
+					       __FUNCTION__);
+					kfree(jh->b_committed_data);
+				}
+				bh->b_private = NULL;
+				jh->b_bh = NULL;	/* debug, really */
+				clear_buffer_jbd(bh);
+				__brelse(bh);
+				journal_free_journal_head(jh);
 			}
-			bh->b_private = NULL;
-			jh->b_bh = NULL;	/* debug, really */
-			clear_buffer_jbd(bh);
-			__brelse(bh);
-			journal_free_journal_head(jh);
 		} else {
 			BUFFER_TRACE(bh, "journal_head was locked");
 		}
diff -ur linux-2.6.11-rc4-V0.7.39-02.orig/fs/jbd/transaction.c linux-2.6.11-rc4-V0.7.39-02/fs/jbd/transaction.c
--- linux-2.6.11-rc4-V0.7.39-02.orig/fs/jbd/transaction.c	2005-02-12 22:05:50.000000000 -0500
+++ linux-2.6.11-rc4-V0.7.39-02/fs/jbd/transaction.c	2005-03-11 13:25:49.000000000 -0500
@@ -1207,11 +1207,17 @@

 	BUFFER_TRACE(bh, "entry");

+	/*
+	 * Is it OK to check to see if this isn't a jbd buffer outside of
+	 * locks? Now that jbd_lock_bh_state only works with jbd buffers
+	 * I sure hope so.
+	 */
+	if (!buffer_jbd(bh))
+		goto not_jbd;
+
 	jbd_lock_bh_state(bh);
 	spin_lock(&journal->j_list_lock);

-	if (!buffer_jbd(bh))
-		goto not_jbd;
 	jh = bh2jh(bh);

 	/* Critical error: attempting to delete a bitmap buffer, maybe?
@@ -1219,7 +1225,7 @@
 	if (!J_EXPECT_JH(jh, !jh->b_committed_data,
 			 "inconsistent data on disk")) {
 		err = -EIO;
-		goto not_jbd;
+		goto bad_jbd;
 	}

 	if (jh->b_transaction == handle->h_transaction) {
@@ -1274,9 +1280,11 @@
 		}
 	}

-not_jbd:
+
+bad_jbd:
 	spin_unlock(&journal->j_list_lock);
 	jbd_unlock_bh_state(bh);
+not_jbd:
 	__brelse(bh);
 	return err;
 }
diff -ur linux-2.6.11-rc4-V0.7.39-02.orig/include/linux/jbd.h linux-2.6.11-rc4-V0.7.39-02/include/linux/jbd.h
--- linux-2.6.11-rc4-V0.7.39-02.orig/include/linux/jbd.h	2005-02-12 22:07:18.000000000 -0500
+++ linux-2.6.11-rc4-V0.7.39-02/include/linux/jbd.h	2005-03-11 14:55:31.000000000 -0500
@@ -313,6 +313,7 @@
 BUFFER_FNS(RevokeValid, revokevalid)
 TAS_BUFFER_FNS(RevokeValid, revokevalid)
 BUFFER_FNS(Freed, freed)
+BUFFER_FNS(JournalHead,journalhead)

 static inline struct buffer_head *jh2bh(struct journal_head *jh)
 {
@@ -324,6 +325,66 @@
 	return bh->b_private;
 }

+void journal_remove_journal_head(struct buffer_head *bh);
+
+#ifdef CONFIG_PREEMPT_RT
+
+extern spinlock_t jbd_journal_head_lock;
+
+static inline void jbd_lock_bh_state(struct buffer_head *bh)
+{
+	BUG_ON(!bh->b_private);
+	atomic_inc(&bh2jh(bh)->b_state_wait_count);
+	spin_lock(&bh2jh(bh)->b_state_lock);
+}
+
+static inline int jbd_trylock_bh_state(struct buffer_head *bh)
+{
+	int ret;
+
+	BUG_ON(!bh->b_private);
+
+	if ((ret = spin_trylock(&bh2jh(bh)->b_state_lock)))
+		atomic_inc(&bh2jh(bh)->b_state_wait_count);
+
+	return ret;
+}
+
+static inline int jbd_is_locked_bh_state(struct buffer_head *bh)
+{
+	return bh2jh(bh) ? spin_is_locked(&bh2jh(bh)->b_state_lock) : 0;
+}
+
+static inline void jbd_unlock_bh_state(struct buffer_head *bh)
+{
+	int rmjh = 0;
+
+	BUG_ON(!atomic_read(&bh2jh(bh)->b_state_wait_count));
+	atomic_dec(&bh2jh(bh)->b_state_wait_count);
+
+	if (buffer_journalhead(bh)) {
+		clear_buffer_journalhead(bh);
+		rmjh = 1;
+	}
+
+	spin_unlock(&bh2jh(bh)->b_state_lock);
+
+	if (rmjh)
+		journal_remove_journal_head(bh);
+}
+
+static inline void jbd_lock_bh_journal_head(struct buffer_head *bh)
+{
+	spin_lock(&jbd_journal_head_lock);
+}
+
+static inline void jbd_unlock_bh_journal_head(struct buffer_head *bh)
+{
+	spin_unlock(&jbd_journal_head_lock);
+}
+
+#else /* !CONFIG_PREEMPT_RT */
+
 static inline void jbd_lock_bh_state(struct buffer_head *bh)
 {
 	bit_spin_lock(BH_State, &bh->b_state);
@@ -354,6 +415,8 @@
 	bit_spin_unlock(BH_JournalHead, &bh->b_state);
 }

+#endif /* CONFIG_PREEMPT_RT */
+
 struct jbd_revoke_table_s;

 /**
@@ -918,7 +981,6 @@
  */
 struct journal_head *journal_add_journal_head(struct buffer_head *bh);
 struct journal_head *journal_grab_journal_head(struct buffer_head *bh);
-void journal_remove_journal_head(struct buffer_head *bh);
 void journal_put_journal_head(struct journal_head *jh);

 /*
diff -ur linux-2.6.11-rc4-V0.7.39-02.orig/include/linux/journal-head.h linux-2.6.11-rc4-V0.7.39-02/include/linux/journal-head.h
--- linux-2.6.11-rc4-V0.7.39-02.orig/include/linux/journal-head.h	2005-02-12 22:07:39.000000000 -0500
+++ linux-2.6.11-rc4-V0.7.39-02/include/linux/journal-head.h	2005-03-11 15:14:07.774541864 -0500
@@ -80,6 +80,16 @@
 	 * [j_list_lock]
 	 */
 	struct journal_head *b_cpnext, *b_cpprev;
+
+	/*
+	 * Lock the state of the buffer head.
+	 */
+	spinlock_t b_state_lock;
+
+	/*
+	 * Count the processes that want/have the state lock.
+	 */
+	atomic_t b_state_wait_count;
 };

 #endif		/* JOURNAL_HEAD_H_INCLUDED */
diff -ur linux-2.6.11-rc4-V0.7.39-02.orig/include/linux/spinlock.h linux-2.6.11-rc4-V0.7.39-02/include/linux/spinlock.h
--- linux-2.6.11-rc4-V0.7.39-02.orig/include/linux/spinlock.h	2005-03-10 08:47:25.000000000 -0500
+++ linux-2.6.11-rc4-V0.7.39-02/include/linux/spinlock.h	2005-03-11 09:06:26.000000000 -0500
@@ -774,6 +774,10 @@
 }))


+#ifndef CONFIG_PREEMPT_RT
+
+/* These are just plain evil! */
+
 /*
  *  bit-based spin_lock()
  *
@@ -789,10 +793,15 @@
 	 * busywait with less bus contention for a good time to
 	 * attempt to acquire the lock bit.
 	 */
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
-	while (test_and_set_bit(bitnum, addr))
-		while (test_bit(bitnum, addr))
+	preempt_disable();
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	while (test_and_set_bit(bitnum, addr)) {
+		while (test_bit(bitnum, addr)) {
+			preempt_enable();
 			cpu_relax();
+			preempt_disable();
+		}
+	}
 #endif
 	__acquire(bitlock);
 }
@@ -802,9 +811,12 @@
  */
 static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
 {
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
-	if (test_and_set_bit(bitnum, addr))
+	preempt_disable();
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	if (test_and_set_bit(bitnum, addr)) {
+		preempt_enable();
 		return 0;
+	}
 #endif
 	__acquire(bitlock);
 	return 1;
@@ -815,11 +827,12 @@
  */
 static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
 {
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 	BUG_ON(!test_bit(bitnum, addr));
 	smp_mb__before_clear_bit();
 	clear_bit(bitnum, addr);
 #endif
+	preempt_enable();
 	__release(bitlock);
 }

@@ -828,12 +841,15 @@
  */
 static inline int bit_spin_is_locked(int bitnum, unsigned long *addr)
 {
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 	return test_bit(bitnum, addr);
+#elif defined CONFIG_PREEMPT
+	return preempt_count();
 #else
 	return 1;
 #endif
 }
+#endif /* CONFIG_PREEMPT_RT */

 #define DEFINE_SPINLOCK(name) \
 	spinlock_t name __cacheline_aligned_in_smp = _SPIN_LOCK_UNLOCKED(name)

