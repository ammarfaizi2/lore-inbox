Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVCOLpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVCOLpo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 06:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVCOLpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 06:45:44 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:64910 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261176AbVCOLpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 06:45:12 -0500
Date: Tue, 15 Mar 2005 06:44:58 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
In-Reply-To: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain>
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
 <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I've realized that my previous patch had too many problems with the way
the journaling system works.  So I went back to my first approach but
added the journal_head lock as one global lock to keep the buffer head
size smaller. I only added the state lock to the buffer head. I've tested
this for some time now, and it works well (for the test at least). I'll
recompile it with PREEMPT_DESKTOP to see if that works too.


-- Steve



diff -ur linux-2.6.11-final-V0.7.40-00.orig/fs/buffer.c linux-2.6.11-final-V0.7.40-00/fs/buffer.c
--- linux-2.6.11-final-V0.7.40-00.orig/fs/buffer.c	2005-03-02 02:38:10.000000000 -0500
+++ linux-2.6.11-final-V0.7.40-00/fs/buffer.c	2005-03-15 03:41:15.000000000 -0500
@@ -3003,6 +3003,9 @@
 		preempt_disable();
 		__get_cpu_var(bh_accounting).nr++;
 		recalc_bh_state();
+#ifdef CONFIG_PREEMPT_RT
+		spin_lock_init(&ret->b_jstate_lock);
+#endif
 		preempt_enable();
 	}
 	return ret;
diff -ur linux-2.6.11-final-V0.7.40-00.orig/fs/jbd/journal.c linux-2.6.11-final-V0.7.40-00/fs/jbd/journal.c
--- linux-2.6.11-final-V0.7.40-00.orig/fs/jbd/journal.c	2005-03-02 02:37:49.000000000 -0500
+++ linux-2.6.11-final-V0.7.40-00/fs/jbd/journal.c	2005-03-15 03:49:10.000000000 -0500
@@ -82,6 +82,8 @@

 static int journal_convert_superblock_v1(journal_t *, journal_superblock_t *);

+spinlock_t journal_head_lock = SPIN_LOCK_UNLOCKED;
+
 /*
  * Helper function used to manage commit timeouts
  */
diff -ur linux-2.6.11-final-V0.7.40-00.orig/include/linux/buffer_head.h linux-2.6.11-final-V0.7.40-00/include/linux/buffer_head.h
--- linux-2.6.11-final-V0.7.40-00.orig/include/linux/buffer_head.h	2005-03-02 02:37:45.000000000 -0500
+++ linux-2.6.11-final-V0.7.40-00/include/linux/buffer_head.h	2005-03-15 03:42:22.000000000 -0500
@@ -62,6 +62,13 @@
 	bh_end_io_t *b_end_io;		/* I/O completion */
  	void *b_private;		/* reserved for b_end_io */
 	struct list_head b_assoc_buffers; /* associated with another mapping */
+
+#ifdef CONFIG_PREEMPT_RT
+	/*
+	 * Fixme: This should be in the journal code.
+	 */
+	spinlock_t b_jstate_lock;	/* lock for journal state. */
+#endif
 };

 /*
diff -ur linux-2.6.11-final-V0.7.40-00.orig/include/linux/jbd.h linux-2.6.11-final-V0.7.40-00/include/linux/jbd.h
--- linux-2.6.11-final-V0.7.40-00.orig/include/linux/jbd.h	2005-03-02 02:38:19.000000000 -0500
+++ linux-2.6.11-final-V0.7.40-00/include/linux/jbd.h	2005-03-15 03:45:33.000000000 -0500
@@ -314,6 +314,13 @@
 TAS_BUFFER_FNS(RevokeValid, revokevalid)
 BUFFER_FNS(Freed, freed)

+#ifdef CONFIG_PREEMPT_RT
+extern spinlock_t journal_head_lock;
+#define PICK_SPIN_LOCK(otype,bit,name) spin_##otype(&bh->b_##name##_lock)
+#else
+#define PICK_SPIN_LOCK(otype,bit,name) bit_spin_##otype(bit,bh->b_state);
+#endif
+
 static inline struct buffer_head *jh2bh(struct journal_head *jh)
 {
 	return jh->b_bh;
@@ -326,24 +333,36 @@

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
+}
+#undef PICK_SPIN_LOCK
+
+#ifdef CONFIG_PREEMPT_RT
+static inline void jbd_lock_bh_journal_head(struct buffer_head *bh)
+{
+	spin_lock(&journal_head_lock);
 }

+static inline void jbd_unlock_bh_journal_head(struct buffer_head *bh)
+{
+	spin_unlock(&journal_head_lock);
+}
+#else /* !CONFIG_PREEMPT_RT */
 static inline void jbd_lock_bh_journal_head(struct buffer_head *bh)
 {
 	bit_spin_lock(BH_JournalHead, &bh->b_state);
@@ -353,6 +372,7 @@
 {
 	bit_spin_unlock(BH_JournalHead, &bh->b_state);
 }
+#endif /* CONFIG_PREEMPT_RT */

 struct jbd_revoke_table_s;

diff -ur linux-2.6.11-final-V0.7.40-00.orig/include/linux/spinlock.h linux-2.6.11-final-V0.7.40-00/include/linux/spinlock.h
--- linux-2.6.11-final-V0.7.40-00.orig/include/linux/spinlock.h	2005-03-14 06:00:54.000000000 -0500
+++ linux-2.6.11-final-V0.7.40-00/include/linux/spinlock.h	2005-03-15 03:40:31.000000000 -0500
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
