Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbVCLX3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVCLX3v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 18:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVCLXZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 18:25:33 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:14273 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262393AbVCLXWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 18:22:23 -0500
Date: Sat, 12 Mar 2005 23:20:53 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: mingo@elte.hu, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] break_lock forever broken
In-Reply-To: <20050311203427.052f2b1b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0503122311160.13909@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503111847450.9320@goblin.wat.veritas.com> 
    <20050311203427.052f2b1b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2005, Andrew Morton wrote:
> 
> This patch causes a CONFIG_PREEMPT=y, CONFIG_PREEMPT_BKL=y,
> CONFIG_DEBUG_PREEMPT=y kernel on a ppc64 G5 to hang immediately after
> displaying the penguins, but apparently not before having set the hardware
> clock backwards 101 years.
> 
> After having carefully reviewed the above description and having decided
> that these effects were not a part of the patch's design intent I have
> temporarily set it aside, thanks.

That was a Klingon patch, sorry, it escaped.  Hence the time warp.  Did
terrible things on i386 too once I tested it differently.  When dealing
with something like a completion, disaster to touch a field of the lock
once it's been unlocked.  Here's a replacement...


lock->break_lock is set when a lock is contended, but cleared only in
cond_resched_lock.  Users of need_lockbreak (journal_commit_transaction,
copy_pte_range, unmap_vmas) don't necessarily use cond_resched_lock on it.

So, if the lock has been contended at some time in the past, break_lock
remains set thereafter, and the fastpath keeps dropping lock unnecessarily.
Hanging the system if you make a change like I did, forever restarting a
loop before making any progress.  And even users of cond_resched_lock may
well suffer an initial unnecessary lockbreak.

There seems to be no point at which break_lock can be cleared when
unlocking, any point being either too early or too late; but that's okay,
it's only of interest while the lock is held.  So clear it whenever the
lock is acquired - and any waiting contenders will quickly set it again.
Additional locking overhead? well, this is only when CONFIG_PREEMPT is on.

Since cond_resched_lock's spin_lock clears break_lock, no need to clear it
itself; and use need_lockbreak there too, preferring optimizer to #ifdefs.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.11-bk8/kernel/sched.c	2005-03-11 13:33:09.000000000 +0000
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
--- 2.6.11-bk8/kernel/spinlock.c	2005-03-02 07:38:52.000000000 +0000
+++ linux/kernel/spinlock.c	2005-03-12 22:52:41.000000000 +0000
@@ -187,6 +187,8 @@ void __lockfunc _##op##_lock(locktype##_
 			cpu_relax();					\
 		preempt_disable();					\
 	}								\
+	if ((lock)->break_lock)						\
+		(lock)->break_lock = 0;					\
 }									\
 									\
 EXPORT_SYMBOL(_##op##_lock);						\
@@ -209,6 +211,8 @@ unsigned long __lockfunc _##op##_lock_ir
 			cpu_relax();					\
 		preempt_disable();					\
 	}								\
+	if ((lock)->break_lock)						\
+		(lock)->break_lock = 0;					\
 	return flags;							\
 }									\
 									\
