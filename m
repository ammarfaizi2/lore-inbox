Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVCKS6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVCKS6w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 13:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVCKS5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 13:57:40 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:13358 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261308AbVCKSwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 13:52:46 -0500
Date: Fri, 11 Mar 2005 18:51:48 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] break_lock forever broken
Message-ID: <Pine.LNX.4.61.0503111847450.9320@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lock->break_lock is set when a lock is contended, but cleared only in
cond_resched_lock.  Users of need_lockbreak (journal_commit_transaction,
copy_pte_range, unmap_vmas) don't necessarily use cond_resched_lock on it.

So, if the lock has been contended at some time in the past, break_lock
remains set thereafter, and the fastpath keeps dropping lock unnecessarily.
Hanging the system if you make a change like I did, forever restarting a
loop before making any progress.

Should it be cleared when contending to lock, just the other side of the
cpu_relax loop?  No, that loop is preemptible, we don't want break_lock
set all the while the contender has been preempted.  It should be cleared
when we unlock - any remaining contenders will quickly set it again.

So cond_resched_lock's spin_unlock will clear it, no need for it to do
that; and use need_lockbreak there too, preferring optimizer to #ifdefs.

Or would you prefer the few need_lockbreak users to clear it in advance?
Less overhead, more errorprone.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.11-bk7/kernel/sched.c	2005-03-11 13:33:09.000000000 +0000
+++ linux/kernel/sched.c	2005-03-11 17:46:50.000000000 +0000
@@ -3753,14 +3753,11 @@ EXPORT_SYMBOL(cond_resched);
  */
 int cond_resched_lock(spinlock_t * lock)
 {
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
-	if (lock->break_lock) {
-		lock->break_lock = 0;
+	if (need_lockbreak(lock)) {
 		spin_unlock(lock);
 		cpu_relax();
 		spin_lock(lock);
 	}
-#endif
 	if (need_resched()) {
 		_raw_spin_unlock(lock);
 		preempt_enable_no_resched();
--- 2.6.11-bk7/kernel/spinlock.c	2005-03-02 07:38:52.000000000 +0000
+++ linux/kernel/spinlock.c	2005-03-11 17:46:50.000000000 +0000
@@ -163,6 +163,8 @@ void __lockfunc _write_lock(rwlock_t *lo
 
 EXPORT_SYMBOL(_write_lock);
 
+#define _stop_breaking(lock)
+
 #else /* CONFIG_PREEMPT: */
 
 /*
@@ -250,12 +252,19 @@ BUILD_LOCK_OPS(spin, spinlock);
 BUILD_LOCK_OPS(read, rwlock);
 BUILD_LOCK_OPS(write, rwlock);
 
+#define _stop_breaking(lock)						\
+	do {								\
+		if ((lock)->break_lock)					\
+			(lock)->break_lock = 0;				\
+	} while (0)
+
 #endif /* CONFIG_PREEMPT */
 
 void __lockfunc _spin_unlock(spinlock_t *lock)
 {
 	_raw_spin_unlock(lock);
 	preempt_enable();
+	_stop_breaking(lock);
 }
 EXPORT_SYMBOL(_spin_unlock);
 
@@ -263,6 +272,7 @@ void __lockfunc _write_unlock(rwlock_t *
 {
 	_raw_write_unlock(lock);
 	preempt_enable();
+	_stop_breaking(lock);
 }
 EXPORT_SYMBOL(_write_unlock);
 
@@ -270,6 +280,7 @@ void __lockfunc _read_unlock(rwlock_t *l
 {
 	_raw_read_unlock(lock);
 	preempt_enable();
+	_stop_breaking(lock);
 }
 EXPORT_SYMBOL(_read_unlock);
 
@@ -278,6 +289,7 @@ void __lockfunc _spin_unlock_irqrestore(
 	_raw_spin_unlock(lock);
 	local_irq_restore(flags);
 	preempt_enable();
+	_stop_breaking(lock);
 }
 EXPORT_SYMBOL(_spin_unlock_irqrestore);
 
@@ -286,6 +298,7 @@ void __lockfunc _spin_unlock_irq(spinloc
 	_raw_spin_unlock(lock);
 	local_irq_enable();
 	preempt_enable();
+	_stop_breaking(lock);
 }
 EXPORT_SYMBOL(_spin_unlock_irq);
 
@@ -294,6 +307,7 @@ void __lockfunc _spin_unlock_bh(spinlock
 	_raw_spin_unlock(lock);
 	preempt_enable();
 	local_bh_enable();
+	_stop_breaking(lock);
 }
 EXPORT_SYMBOL(_spin_unlock_bh);
 
@@ -302,6 +316,7 @@ void __lockfunc _read_unlock_irqrestore(
 	_raw_read_unlock(lock);
 	local_irq_restore(flags);
 	preempt_enable();
+	_stop_breaking(lock);
 }
 EXPORT_SYMBOL(_read_unlock_irqrestore);
 
@@ -310,6 +325,7 @@ void __lockfunc _read_unlock_irq(rwlock_
 	_raw_read_unlock(lock);
 	local_irq_enable();
 	preempt_enable();
+	_stop_breaking(lock);
 }
 EXPORT_SYMBOL(_read_unlock_irq);
 
@@ -318,6 +334,7 @@ void __lockfunc _read_unlock_bh(rwlock_t
 	_raw_read_unlock(lock);
 	preempt_enable();
 	local_bh_enable();
+	_stop_breaking(lock);
 }
 EXPORT_SYMBOL(_read_unlock_bh);
 
@@ -326,6 +343,7 @@ void __lockfunc _write_unlock_irqrestore
 	_raw_write_unlock(lock);
 	local_irq_restore(flags);
 	preempt_enable();
+	_stop_breaking(lock);
 }
 EXPORT_SYMBOL(_write_unlock_irqrestore);
 
@@ -334,6 +352,7 @@ void __lockfunc _write_unlock_irq(rwlock
 	_raw_write_unlock(lock);
 	local_irq_enable();
 	preempt_enable();
+	_stop_breaking(lock);
 }
 EXPORT_SYMBOL(_write_unlock_irq);
 
@@ -342,6 +361,7 @@ void __lockfunc _write_unlock_bh(rwlock_
 	_raw_write_unlock(lock);
 	preempt_enable();
 	local_bh_enable();
+	_stop_breaking(lock);
 }
 EXPORT_SYMBOL(_write_unlock_bh);
 
