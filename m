Return-Path: <linux-kernel-owner+w=401wt.eu-S932706AbWLZQkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbWLZQkN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 11:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbWLZQkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 11:40:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53096 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932706AbWLZQkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 11:40:12 -0500
Date: Tue, 26 Dec 2006 17:37:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, Florin Iucha <florin@iucha.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc2
Message-ID: <20061226163713.GA9047@elte.hu>
References: <20061225224047.GB6087@iucha.net> <20061225225616.GA22307@iucha.net> <20061226022538.13ea8b3f.akpm@osdl.org> <20061226124019.GA3701@elte.hu> <20061226073610.1b86a7cc.randy.dunlap@oracle.com> <20061226162616.GA6756@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061226162616.GA6756@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > I've had at least one more occurrence of it:
> > 
> > [   78.804940] BUG: scheduling while atomic: kbd/0x20000000/3444
> > [   78.804944] 
> > [   78.804945] Call Trace:
> 
> ok, i can think of a simpler scenario: 
> add_preempt_count(PREEMPT_ACTIVE) /twice/, nested into each other.

doh - the BKL! That does a down() in a PREEMPT_ACTIVE section, which can 
trigger cond_resched(). The fix is to check for PREEMPT_ACTIVE in 
cond_resched(). (and only in cond_resched())

Updated fix (against -rc2) attached.

	Ingo

---------------------->
Subject: [patch] sched: fix cond_resched_softirq() offset
From: Ingo Molnar <mingo@elte.hu>

remove the __resched_legal() check: it is conceptually broken.
The biggest problem it had is that it can mask buggy cond_resched()
calls. A cond_resched() call is only legal if we are not in an
atomic context, with two narrow exceptions:

 - if the system is booting
 - a reacquire_kernel_lock() down() done while PREEMPT_ACTIVE is set

But __resched_legal() hid this and just silently returned whenever
these primitives were called from invalid contexts. (Same goes for
cond_resched_locked() and cond_resched_softirq()).

furthermore, the __legal_resched(0) call was buggy in that it caused
unnecessarily long softirq latencies via cond_resched_softirq(). (which
is only called from softirq-off sections, hence the code did nothing.)

the fix is to resurrect the efficiency of the might_sleep checks and to
only allow the narrow exceptions.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/sched.c |   18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -4617,17 +4617,6 @@ asmlinkage long sys_sched_yield(void)
 	return 0;
 }
 
-static inline int __resched_legal(int expected_preempt_count)
-{
-#ifdef CONFIG_PREEMPT
-	if (unlikely(preempt_count() != expected_preempt_count))
-		return 0;
-#endif
-	if (unlikely(system_state != SYSTEM_RUNNING))
-		return 0;
-	return 1;
-}
-
 static void __cond_resched(void)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
@@ -4647,7 +4636,8 @@ static void __cond_resched(void)
 
 int __sched cond_resched(void)
 {
-	if (need_resched() && __resched_legal(0)) {
+	if (need_resched() && !(preempt_count() & PREEMPT_ACTIVE) &&
+					system_state == SYSTEM_RUNNING) {
 		__cond_resched();
 		return 1;
 	}
@@ -4673,7 +4663,7 @@ int cond_resched_lock(spinlock_t *lock)
 		ret = 1;
 		spin_lock(lock);
 	}
-	if (need_resched() && __resched_legal(1)) {
+	if (need_resched() && system_state == SYSTEM_RUNNING) {
 		spin_release(&lock->dep_map, 1, _THIS_IP_);
 		_raw_spin_unlock(lock);
 		preempt_enable_no_resched();
@@ -4689,7 +4679,7 @@ int __sched cond_resched_softirq(void)
 {
 	BUG_ON(!in_softirq());
 
-	if (need_resched() && __resched_legal(0)) {
+	if (need_resched() && system_state == SYSTEM_RUNNING) {
 		raw_local_irq_disable();
 		_local_bh_enable();
 		raw_local_irq_enable();
