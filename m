Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbVCNPvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbVCNPvb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 10:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVCNPvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 10:51:31 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:7819 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261541AbVCNPuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 10:50:21 -0500
Date: Mon, 14 Mar 2005 10:50:07 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
In-Reply-To: <Pine.LNX.4.58.0503140509170.697@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
References: <20050204100347.GA13186@elte.hu>  <1108789704.8411.9.camel@krustophenia.net>
  <Pine.LNX.4.58.0503100323370.14016@localhost.localdomain> 
 <Pine.LNX.4.58.0503100447150.14016@localhost.localdomain> 
 <20050311095747.GA21820@elte.hu>  <Pine.LNX.4.58.0503110508360.19798@localhost.localdomain>
  <20050311101740.GA23120@elte.hu>  <Pine.LNX.4.58.0503110521390.19798@localhost.localdomain>
  <20050311024322.690eb3a9.akpm@osdl.org>  <Pine.LNX.4.58.0503110754240.19798@localhost.localdomain>
  <20050311153817.GA32020@elte.hu>  <Pine.LNX.4.58.0503111440190.22043@localhost.localdomain>
  <1110574019.19093.23.camel@mindpipe> <1110578809.19661.2.camel@mindpipe>
 <Pine.LNX.4.58.0503140214360.697@localhost.localdomain>
 <Pine.LNX.4.58.0503140427560.697@localhost.localdomain>
 <Pine.LNX.4.58.0503140509170.697@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Mar 2005, Steven Rostedt wrote:
>
> On Mon, 14 Mar 2005, Steven Rostedt wrote:
> >
> > I just downloaded -40 and applied my patch, compiled it with
> > PREEMPT_DESKTOP and data=ordered, ran it and everything seems OK, except
> > I'm getting the following...
> >
> > BUG: Unable to handle kernel NULL pointer dereference at virtual address
> > 00000000
> >  printing eip:
> > c0213438
> > *pde = 00000000
>
> [snip]
>
> >
> >
> > I'll see if this happens without the patch, and if so, then I'll look into
> > this further.
> >
>
> Well, I took out my patch and this bug didn't happen, so I guess it's may
> fault!  OK, I'll dig into it further.
>

Here's a new patch. All I did was move BUFFER_FNS(JournalHead,journalhead)
to inside the #ifdef CONFIG_PREEMPT_RT and my oops went away !?!  This
really bothers me since it just declares some functions and is not used
with CONFIG_PREEMPT_RT off.  I have no idea what's going on.

Lee, can you see if this still crashes for you.


Thanks,

-- Steve


diff -ur linux-2.6.11-final-V0.7.40-00.orig/fs/jbd/journal.c linux-2.6.11-final-V0.7.40-00/fs/jbd/journal.c
--- linux-2.6.11-final-V0.7.40-00.orig/fs/jbd/journal.c	2005-03-02 02:37:49.000000000 -0500
+++ linux-2.6.11-final-V0.7.40-00/fs/jbd/journal.c	2005-03-14 09:46:41.000000000 -0500
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
diff -ur linux-2.6.11-final-V0.7.40-00.orig/fs/jbd/transaction.c linux-2.6.11-final-V0.7.40-00/fs/jbd/transaction.c
--- linux-2.6.11-final-V0.7.40-00.orig/fs/jbd/transaction.c	2005-03-02 02:37:53.000000000 -0500
+++ linux-2.6.11-final-V0.7.40-00/fs/jbd/transaction.c	2005-03-14 09:46:41.000000000 -0500
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
diff -ur linux-2.6.11-final-V0.7.40-00.orig/include/linux/jbd.h linux-2.6.11-final-V0.7.40-00/include/linux/jbd.h
--- linux-2.6.11-final-V0.7.40-00.orig/include/linux/jbd.h	2005-03-02 02:38:19.000000000 -0500
+++ linux-2.6.11-final-V0.7.40-00/include/linux/jbd.h	2005-03-14 09:46:57.000000000 -0500
@@ -324,6 +324,68 @@
 	return bh->b_private;
 }

+void journal_remove_journal_head(struct buffer_head *bh);
+
+#ifdef CONFIG_PREEMPT_RT
+
+BUFFER_FNS(JournalHead,journalhead)
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
@@ -354,6 +416,8 @@
 	bit_spin_unlock(BH_JournalHead, &bh->b_state);
 }

+#endif /* CONFIG_PREEMPT_RT */
+
 struct jbd_revoke_table_s;

 /**
@@ -918,7 +982,6 @@
  */
 struct journal_head *journal_add_journal_head(struct buffer_head *bh);
 struct journal_head *journal_grab_journal_head(struct buffer_head *bh);
-void journal_remove_journal_head(struct buffer_head *bh);
 void journal_put_journal_head(struct journal_head *jh);

 /*
diff -ur linux-2.6.11-final-V0.7.40-00.orig/include/linux/journal-head.h linux-2.6.11-final-V0.7.40-00/include/linux/journal-head.h
--- linux-2.6.11-final-V0.7.40-00.orig/include/linux/journal-head.h	2005-03-02 02:38:25.000000000 -0500
+++ linux-2.6.11-final-V0.7.40-00/include/linux/journal-head.h	2005-03-14 09:46:41.000000000 -0500
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
diff -ur linux-2.6.11-final-V0.7.40-00.orig/include/linux/spinlock.h linux-2.6.11-final-V0.7.40-00/include/linux/spinlock.h
--- linux-2.6.11-final-V0.7.40-00.orig/include/linux/spinlock.h	2005-03-14 06:00:54.000000000 -0500
+++ linux-2.6.11-final-V0.7.40-00/include/linux/spinlock.h	2005-03-14 09:46:41.053696484 -0500
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
