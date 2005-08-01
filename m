Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVHATw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVHATw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 15:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVHATw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 15:52:58 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:23462 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261199AbVHATuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 15:50:13 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1122920564.6759.15.camel@localhost.localdomain>
References: <20050730160345.GA3584@elte.hu>
	 <1122920564.6759.15.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 01 Aug 2005 15:49:59 -0400
Message-Id: <1122925799.6759.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Here's a conversion of the bit_spin_locks to wait_on_bit.
Unfortunately, this doesn't have PI but it is better than just a normal
bit_spin_lock.

This patch applies cleanly to 2.6.13-rc3 (that's what I tried it on).  I
haven't done any benchmarking and I only booted this on a RT UP machine
so far. The RT part uses this portion.

So Stephen,  please take a look and let me know if this is something
that is suitable for the mainline?

Thanks,

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux_realtime_ernie/include/linux/jbd.h
===================================================================
--- linux_realtime_ernie/include/linux/jbd.h	(revision 266)
+++ linux_realtime_ernie/include/linux/jbd.h	(working copy)
@@ -324,36 +324,88 @@
 	return bh->b_private;
 }
 
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
+
+extern int jbd_lock_bh_sleep(void *notused);
+
 static inline void jbd_lock_bh_state(struct buffer_head *bh)
 {
-	bit_spin_lock(BH_State, &bh->b_state);
+	wait_on_bit_lock(&bh->b_state,BH_State,&jbd_lock_bh_sleep,
+			 TASK_UNINTERRUPTIBLE);
+	__acquire(bitlock);
 }
 
 static inline int jbd_trylock_bh_state(struct buffer_head *bh)
 {
-	return bit_spin_trylock(BH_State, &bh->b_state);
+	if (test_and_set_bit(BH_State, &bh->b_state))
+		return 0;
+	__acquire(bitlock);
+	return 1;
 }
 
 static inline int jbd_is_locked_bh_state(struct buffer_head *bh)
 {
-	return bit_spin_is_locked(BH_State, &bh->b_state);
+	return test_bit(BH_State, &bh->b_state);
 }
 
 static inline void jbd_unlock_bh_state(struct buffer_head *bh)
 {
-	bit_spin_unlock(BH_State, &bh->b_state);
+	clear_bit(BH_State, &bh->b_state);
+	smp_mb__after_clear_bit();
+	wake_up_bit(&bh->b_state, BH_State);
+	__release(bitlock);
 }
 
 static inline void jbd_lock_bh_journal_head(struct buffer_head *bh)
 {
-	bit_spin_lock(BH_JournalHead, &bh->b_state);
+	wait_on_bit_lock(&bh->b_state, BH_JournalHead, &jbd_lock_bh_sleep,
+			 TASK_UNINTERRUPTIBLE);
+	__acquire(bitlock);
 }
 
 static inline void jbd_unlock_bh_journal_head(struct buffer_head *bh)
 {
-	bit_spin_unlock(BH_JournalHead, &bh->b_state);
+	clear_bit(BH_JournalHead, &bh->b_state);
+	smp_mb__after_clear_bit();
+	wake_up_bit(&bh->b_state, BH_JournalHead);
+	__release(bitlock);
 }
 
+#else  /* ! (CONFIG_SMP || CONFIG_DEBUG_SPINLOCK || CONFIG_PREEMPT) */
+
+static inline void jbd_lock_bh_state(struct buffer_head *bh)
+{
+	__acquire(journal_bh_state_lock);
+}
+
+static inline int jbd_trylock_bh_state(struct buffer_head *bh)
+{
+	__acquire(journal_bh_state_lock);
+	return 1;
+}
+
+static inline int jbd_is_locked_bh_state(struct buffer_head *bh)
+{
+	return 1;
+}
+
+static inline void jbd_unlock_bh_state(struct buffer_head *bh)
+{
+	__release(journal_bh_state_lock);
+}
+
+static inline void jbd_lock_bh_journal_head(struct buffer_head *bh)
+{
+	__acquire(journal_bh_journal_lock);
+}
+
+static inline void jbd_unlock_bh_journal_head(struct buffer_head *bh)
+{
+	__release(journal_bh_journal_lock);
+}
+#endif /* (CONFIG_SMP || CONFIG_DEBUG_SPINLOCK || CONFIG_PREEMPT) */
+
+
 struct jbd_revoke_table_s;
 
 /**
Index: linux_realtime_ernie/fs/jbd/journal.c
===================================================================
--- linux_realtime_ernie/fs/jbd/journal.c	(revision 266)
+++ linux_realtime_ernie/fs/jbd/journal.c	(working copy)
@@ -80,6 +80,14 @@
 EXPORT_SYMBOL(journal_try_to_free_buffers);
 EXPORT_SYMBOL(journal_force_commit);
 
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
+int jbd_lock_bh_sleep(void *notused)
+{
+	schedule();
+	return 0;
+}
+#endif
+
 static int journal_convert_superblock_v1(journal_t *, journal_superblock_t *);
 
 /*


