Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbVCNKqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVCNKqf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 05:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVCNKqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 05:46:35 -0500
Received: from mx2.elte.hu ([157.181.151.9]:979 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262109AbVCNKq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 05:46:28 -0500
Date: Mon, 14 Mar 2005 11:46:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] break_lock forever broken
Message-ID: <20050314104611.GA30392@elte.hu>
References: <Pine.LNX.4.61.0503111847450.9320@goblin.wat.veritas.com> <20050311203427.052f2b1b.akpm@osdl.org> <Pine.LNX.4.61.0503122311160.13909@goblin.wat.veritas.com> <20050314070230.GA24860@elte.hu> <42354562.1080900@yahoo.com.au> <20050314081402.GA26589@elte.hu> <42354A3F.4030904@yahoo.com.au> <1110789270.6288.53.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110789270.6288.53.camel@laptopd505.fenrus.org>
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


* Arjan van de Ven <arjan@infradead.org> wrote:

> as I said, since the cacheline just got dirtied, the write is just
> half a cycle which is so much in the noise that it really doesn't
> matter.

ok - the patch below is a small modification of Hugh's so that we clear
->break_lock unconditionally. Since this code is not inlined it ought to
have minimal icache impact too.

	Ingo

--
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
Signed-off-by: Ingo Molnar <mingo@elte.hu>

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
@@ -187,6 +187,7 @@ void __lockfunc _##op##_lock(locktype##_
 			cpu_relax();					\
 		preempt_disable();					\
 	}								\
+	(lock)->break_lock = 0;						\
 }									\
 									\
 EXPORT_SYMBOL(_##op##_lock);						\
@@ -209,6 +211,7 @@ unsigned long __lockfunc _##op##_lock_ir
 			cpu_relax();					\
 		preempt_disable();					\
 	}								\
+	(lock)->break_lock = 0;						\
 	return flags;							\
 }									\
 									\
