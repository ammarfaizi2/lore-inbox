Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVCPKCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVCPKCJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 05:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVCPKCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 05:02:09 -0500
Received: from mx1.elte.hu ([157.181.1.137]:36778 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262312AbVCPJ6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 04:58:34 -0500
Date: Wed, 16 Mar 2005 10:57:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: rostedt@goodmis.org, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: [patch 3/3] remove bitlocks
Message-ID: <20050316095729.GC15460@elte.hu>
References: <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain> <20050315120053.GA4686@elte.hu> <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain> <20050315133540.GB4686@elte.hu> <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain> <20050316085029.GA11414@elte.hu> <20050316011510.2a3bdfdb.akpm@osdl.org> <20050316095155.GA15080@elte.hu> <20050316095322.GA15460@elte.hu> <20050316095359.GB15460@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316095359.GB15460@elte.hu>
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


this patch is a port of Steven Rostedt's bitlock-removal patch to
BK-curr. It changes the ext3 code to use wait_on_bit_lock() on
&jbd_lock_bh_sleep, instead of the bitlock primitives.

Builds/boots/works fine on x86.

From: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/fs/jbd/journal.c.orig
+++ linux/fs/jbd/journal.c
@@ -82,6 +82,17 @@ EXPORT_SYMBOL(journal_force_commit);
 
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
--- linux/include/linux/jbd.h.orig
+++ linux/include/linux/jbd.h
@@ -65,7 +65,6 @@ extern int journal_enable_debug;
 		}							\
 	} while (0)
 #else
-#define jbd_debug(f, a...)	/**/
 #endif
 
 extern void * __jbd_kmalloc (const char *where, size_t size, int flags, int retry);
@@ -324,34 +323,63 @@ static inline struct journal_head *bh2jh
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
--- linux/include/linux/spinlock.h.orig
+++ linux/include/linux/spinlock.h
@@ -522,78 +522,6 @@ extern int _atomic_dec_and_lock(atomic_t
 
 #define atomic_dec_and_lock(atomic,lock) __cond_lock(_atomic_dec_and_lock(atomic,lock))
 
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
-	preempt_disable();
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	while (test_and_set_bit(bitnum, addr)) {
-		while (test_bit(bitnum, addr)) {
-			preempt_enable();
-			cpu_relax();
-			preempt_disable();
-		}
-	}
-#endif
-	__acquire(bitlock);
-}
-
-/*
- * Return true if it was acquired
- */
-static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
-{
-	preempt_disable();	
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	if (test_and_set_bit(bitnum, addr)) {
-		preempt_enable();
-		return 0;
-	}
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
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	BUG_ON(!test_bit(bitnum, addr));
-	smp_mb__before_clear_bit();
-	clear_bit(bitnum, addr);
-#endif
-	preempt_enable();
-	__release(bitlock);
-}
-
-/*
- * Return true if the lock is held.
- */
-static inline int bit_spin_is_locked(int bitnum, unsigned long *addr)
-{
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	return test_bit(bitnum, addr);
-#elif defined CONFIG_PREEMPT
-	return preempt_count();
-#else
-	return 1;
-#endif
-}
-
 #define DEFINE_SPINLOCK(x) spinlock_t x = SPIN_LOCK_UNLOCKED
 #define DEFINE_RWLOCK(x) rwlock_t x = RW_LOCK_UNLOCKED
 
