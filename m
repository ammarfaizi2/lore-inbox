Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263338AbVCKOkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbVCKOkm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 09:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbVCKOkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 09:40:42 -0500
Received: from cpe-24-94-57-164.stny.res.rr.com ([24.94.57.164]:58792 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263338AbVCKOkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 09:40:12 -0500
Date: Fri, 11 Mar 2005 09:40:08 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Andrew Morton <akpm@osdl.org>
cc: mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
In-Reply-To: <20050311024322.690eb3a9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503110754240.19798@localhost.localdomain>
References: <20050204100347.GA13186@elte.hu> <1108789704.8411.9.camel@krustophenia.net>
 <Pine.LNX.4.58.0503100323370.14016@localhost.localdomain>
 <Pine.LNX.4.58.0503100447150.14016@localhost.localdomain> <20050311095747.GA21820@elte.hu>
 <Pine.LNX.4.58.0503110508360.19798@localhost.localdomain> <20050311101740.GA23120@elte.hu>
 <Pine.LNX.4.58.0503110521390.19798@localhost.localdomain>
 <20050311024322.690eb3a9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here's the patch. It's probably more of an overkill wrt buffer heads, but
it seems to be the easiest solution.

I also put back some of the changes you made for the
bit_spin_locks, so that they act the same as the vanilla kernel if
PREEMPT_RT is not defined.  Now I only tested this with PREEMPT_RT
configured so I hope others can test it with it off. If I get time I'll do
that as well.

I patched this against linux-2.6.11-rc4-V0.7.39-02, so I hope it goes
easily into .40.

Lee,

 Could you see what the latencies are with kjournal with this patch
applied.

Thanks,

 -- Steve


diff -ur linux-2.6.11-rc4-V0.7.39-02.orig/fs/buffer.c linux-2.6.11-rc4-V0.7.39-02/fs/buffer.c
--- linux-2.6.11-rc4-V0.7.39-02.orig/fs/buffer.c	2005-02-12 22:06:54.000000000 -0500
+++ linux-2.6.11-rc4-V0.7.39-02/fs/buffer.c	2005-03-11 07:48:04.000000000 -0500
@@ -3002,6 +3002,10 @@
 		preempt_disable();
 		__get_cpu_var(bh_accounting).nr++;
 		recalc_bh_state();
+#ifdef CONFIG_PREEMPT_RT
+		spin_lock_init(&ret->b_jstate_lock);
+		spin_lock_init(&ret->b_jhead_lock);
+#endif
 		preempt_enable();
 	}
 	return ret;
diff -ur linux-2.6.11-rc4-V0.7.39-02.orig/include/linux/buffer_head.h linux-2.6.11-rc4-V0.7.39-02/include/linux/buffer_head.h
--- linux-2.6.11-rc4-V0.7.39-02.orig/include/linux/buffer_head.h	2005-02-12 22:05:10.000000000 -0500
+++ linux-2.6.11-rc4-V0.7.39-02/include/linux/buffer_head.h	2005-03-11 07:59:44.000000000 -0500
@@ -62,6 +62,14 @@
 	bh_end_io_t *b_end_io;		/* I/O completion */
  	void *b_private;		/* reserved for b_end_io */
 	struct list_head b_assoc_buffers; /* associated with another mapping */
+
+#ifdef CONFIG_PREEMPT_RT
+	/*
+	 * Fixme: This should be in the journal code.
+	 */
+	spinlock_t b_jstate_lock;	/* lock for journal state. */
+	spinlock_t b_jhead_lock;	/* lock for journal head. */
+#endif
 };

 /*
diff -ur linux-2.6.11-rc4-V0.7.39-02.orig/include/linux/jbd.h linux-2.6.11-rc4-V0.7.39-02/include/linux/jbd.h
--- linux-2.6.11-rc4-V0.7.39-02.orig/include/linux/jbd.h	2005-02-12 22:07:18.000000000 -0500
+++ linux-2.6.11-rc4-V0.7.39-02/include/linux/jbd.h	2005-03-11 07:57:47.000000000 -0500
@@ -314,6 +314,12 @@
 TAS_BUFFER_FNS(RevokeValid, revokevalid)
 BUFFER_FNS(Freed, freed)

+#ifdef CONFIG_PREEMPT_RT
+#define PICK_SPIN_LOCK(otype,bit,name) spin_##otype(&bh->b_##name##_lock)
+#else
+#define PICK_SPIN_LOCK(otype,bit,name) bit_spin_##otype(bit,bh->b_state);
+#endif
+
 static inline struct buffer_head *jh2bh(struct journal_head *jh)
 {
 	return jh->b_bh;
@@ -326,33 +332,34 @@

 static inline void jbd_lock_bh_state(struct buffer_head *bh)
 {
-	bit_spin_lock(BH_State, &bh->b_state);
+	PICK_SPIN_LOCK(lock,BH_State,jstate);
 }

 static inline int jbd_trylock_bh_state(struct buffer_head *bh)
 {
-	return bit_spin_trylock(BH_State, &bh->b_state);
+	return PICK_SPIN_LOCK(trylock,BH_State,jstate);
 }

 static inline int jbd_is_locked_bh_state(struct buffer_head *bh)
 {
-	return bit_spin_is_locked(BH_State, &bh->b_state);
+	return PICK_SPIN_LOCK(is_locked,BH_State,jstate);
 }

 static inline void jbd_unlock_bh_state(struct buffer_head *bh)
 {
-	bit_spin_unlock(BH_State, &bh->b_state);
+	PICK_SPIN_LOCK(unlock,BH_State,jstate);
 }

 static inline void jbd_lock_bh_journal_head(struct buffer_head *bh)
 {
-	bit_spin_lock(BH_JournalHead, &bh->b_state);
+	PICK_SPIN_LOCK(lock,BH_JournalHead,jhead);
 }

 static inline void jbd_unlock_bh_journal_head(struct buffer_head *bh)
 {
-	bit_spin_unlock(BH_JournalHead, &bh->b_state);
+	PICK_SPIN_LOCK(unlock,BH_JournalHead,jhead);
 }
+#undef PICK_SPIN_LOCK

 struct jbd_revoke_table_s;

diff -ur linux-2.6.11-rc4-V0.7.39-02.orig/include/linux/spinlock.h linux-2.6.11-rc4-V0.7.39-02/include/linux/spinlock.h
--- linux-2.6.11-rc4-V0.7.39-02.orig/include/linux/spinlock.h	2005-03-10 08:47:25.000000000 -0500
+++ linux-2.6.11-rc4-V0.7.39-02/include/linux/spinlock.h	2005-03-11 09:06:26.254317378 -0500
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
