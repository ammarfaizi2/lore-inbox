Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVCOSKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVCOSKN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVCOSJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:09:16 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:987 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261726AbVCOSGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:06:07 -0500
Date: Tue, 15 Mar 2005 13:05:57 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
In-Reply-To: <20050315133540.GB4686@elte.hu>
Message-ID: <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain>
References: <Pine.LNX.4.58.0503111440190.22043@localhost.localdomain>
 <1110574019.19093.23.camel@mindpipe> <1110578809.19661.2.camel@mindpipe>
 <Pine.LNX.4.58.0503140214360.697@localhost.localdomain>
 <Pine.LNX.4.58.0503140427560.697@localhost.localdomain>
 <Pine.LNX.4.58.0503140509170.697@localhost.localdomain>
 <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
 <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain> <20050315120053.GA4686@elte.hu>
 <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain> <20050315133540.GB4686@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Mar 2005, Ingo Molnar wrote:
>
> i'd go for removing bit-spinlocks altogether, in the upstream kernel. It
> would simplify things, besides making PREEMPT_RT simpler as well. The
> memory overhead is not a big issue i believe. (8 more bytes per ext3 bh,
> on x86)
>

Hi Ingo,

Damn! The answer was right there in front of my eyes! Here's the cleanest
solution. I forgot about wait_on_bit_lock.  I've converted all the locks
to use this instead.  We probably need to get priority inheritence working
on this too someday, but for now it's better than wasting memory or
getting into deadlocks.

-- Steve

diff -ur linux-2.6.11-final-V0.7.40-00.orig/fs/jbd/journal.c linux-2.6.11-final-V0.7.40-00/fs/jbd/journal.c
--- linux-2.6.11-final-V0.7.40-00.orig/fs/jbd/journal.c	2005-03-02 02:37:49.000000000 -0500
+++ linux-2.6.11-final-V0.7.40-00/fs/jbd/journal.c	2005-03-15 11:58:14.000000000 -0500
@@ -82,6 +82,17 @@

 static int journal_convert_superblock_v1(journal_t *, journal_superblock_t *);

+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
+/*
+ * Used in the locking of the bh_state and bh_journalhead bit locks.
+ */
+int jbd_lock_bh_sleep(void *notused)
+{
+	schedule();
+	return 0;
+}
+#endif
+
 /*
  * Helper function used to manage commit timeouts
  */
diff -ur linux-2.6.11-final-V0.7.40-00.orig/include/linux/jbd.h linux-2.6.11-final-V0.7.40-00/include/linux/jbd.h
--- linux-2.6.11-final-V0.7.40-00.orig/include/linux/jbd.h	2005-03-02 02:38:19.000000000 -0500
+++ linux-2.6.11-final-V0.7.40-00/include/linux/jbd.h	2005-03-15 11:58:40.000000000 -0500
@@ -324,34 +324,63 @@
 	return bh->b_private;
 }

+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
+int jbd_lock_bh_sleep(void *notused);
+#endif
+
 static inline void jbd_lock_bh_state(struct buffer_head *bh)
 {
-	bit_spin_lock(BH_State, &bh->b_state);
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
+	wait_on_bit_lock(&bh->b_state,BH_State,&jbd_lock_bh_sleep,TASK_UNINTERRUPTIBLE);
+#endif
+	__acquire(bitlock);
 }

 static inline int jbd_trylock_bh_state(struct buffer_head *bh)
 {
-	return bit_spin_trylock(BH_State, &bh->b_state);
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
+	if (test_and_set_bit(BH_State, &bh->b_state))
+		return 0;
+#endif
+	__acquire(bitlock);
+	return 1;
 }

 static inline int jbd_is_locked_bh_state(struct buffer_head *bh)
 {
-	return bit_spin_is_locked(BH_State, &bh->b_state);
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
+	return test_bit(BH_State, &bh->b_state);
+#else
+	return 1;
+#endif
 }

 static inline void jbd_unlock_bh_state(struct buffer_head *bh)
 {
-	bit_spin_unlock(BH_State, &bh->b_state);
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
+	clear_bit(BH_State, &bh->b_state);
+	smp_mb__after_clear_bit();
+	wake_up_bit(&bh->b_state, BH_State);
+#endif
+	__release(bitlock);
 }

 static inline void jbd_lock_bh_journal_head(struct buffer_head *bh)
 {
-	bit_spin_lock(BH_JournalHead, &bh->b_state);
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
+	wait_on_bit_lock(&bh->b_state,BH_JournalHead,&jbd_lock_bh_sleep,TASK_UNINTERRUPTIBLE);
+#endif
+	__acquire(bitlock);
 }

 static inline void jbd_unlock_bh_journal_head(struct buffer_head *bh)
 {
-	bit_spin_unlock(BH_JournalHead, &bh->b_state);
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
+	clear_bit(BH_JournalHead, &bh->b_state);
+	smp_mb__after_clear_bit();
+	wake_up_bit(&bh->b_state, BH_JournalHead);
+#endif
+	__release(bitlock);
 }

 struct jbd_revoke_table_s;
diff -ur linux-2.6.11-final-V0.7.40-00.orig/include/linux/spinlock.h linux-2.6.11-final-V0.7.40-00/include/linux/spinlock.h
--- linux-2.6.11-final-V0.7.40-00.orig/include/linux/spinlock.h	2005-03-14 06:00:54.000000000 -0500
+++ linux-2.6.11-final-V0.7.40-00/include/linux/spinlock.h	2005-03-15 12:19:11.032217736 -0500
@@ -774,67 +774,6 @@
 }))


-/*
- *  bit-based spin_lock()
- *
- * Don't use this unless you really need to: spin_lock() and spin_unlock()
- * are significantly faster.
- */
-static inline void bit_spin_lock(int bitnum, unsigned long *addr)
-{
-	/*
-	 * Assuming the lock is uncontended, this never enters
-	 * the body of the outer loop. If it is contended, then
-	 * within the inner loop a non-atomic test is used to
-	 * busywait with less bus contention for a good time to
-	 * attempt to acquire the lock bit.
-	 */
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
-	while (test_and_set_bit(bitnum, addr))
-		while (test_bit(bitnum, addr))
-			cpu_relax();
-#endif
-	__acquire(bitlock);
-}
-
-/*
- * Return true if it was acquired
- */
-static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
-{
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
-	if (test_and_set_bit(bitnum, addr))
-		return 0;
-#endif
-	__acquire(bitlock);
-	return 1;
-}
-
-/*
- *  bit-based spin_unlock()
- */
-static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
-{
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
-	BUG_ON(!test_bit(bitnum, addr));
-	smp_mb__before_clear_bit();
-	clear_bit(bitnum, addr);
-#endif
-	__release(bitlock);
-}
-
-/*
- * Return true if the lock is held.
- */
-static inline int bit_spin_is_locked(int bitnum, unsigned long *addr)
-{
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
-	return test_bit(bitnum, addr);
-#else
-	return 1;
-#endif
-}
-
 #define DEFINE_SPINLOCK(name) \
 	spinlock_t name __cacheline_aligned_in_smp = _SPIN_LOCK_UNLOCKED(name)

