Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSFJUEo>; Mon, 10 Jun 2002 16:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSFJUEn>; Mon, 10 Jun 2002 16:04:43 -0400
Received: from mx1.elte.hu ([157.181.1.137]:1184 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S315971AbSFJUEk>;
	Mon, 10 Jun 2002 16:04:40 -0400
Date: Mon, 10 Jun 2002 22:02:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: "David S. Miller" <davem@redhat.com>, Robert Love <rml@tech9.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler Bug (set_cpus_allowed)
In-Reply-To: <20020610115020.B1565@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0206102130060.29999-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mike,

On Mon, 10 Jun 2002, Mike Kravetz wrote:

> However, even with this code removed there are still some races in the
> scheduler.  Specifically, load_balance() can race with schedule() in the
> code around the call to context switch(). [...]

the fundamental problem is the dropping of the runqueue lock before doing
the context_switch(), which leaves the scheduler data structures in an
inconsistent state. Reintroducing rq->prev works, we had something like
that in 2.4, but i'd like to avoid such complexity as much as possible.

the fundamental problem is that the current rq->frozen code is broken,
unfortunately. It simply does not work, and in fact it never worked since
it was introduced in 2.5.7. Nothing synchronizes on rq->frozen, only the
rq-local CPU locks/unlocks it, so it has *zero* functional effect, it's an
expensive no-op.

I've removed it from the scheduler in the attached patch (against 2.5.21),
which in turn should also fix the race(s) Mike noticed.

the rq->frozen code was added for the sake of the Sparc port, which has a
legitim reason: it wants to do some more complex things (like calling into
the scheduler ...) in context_switch(). But i really dislike the effects
of this: it makes the context switch non-atomic, which triggers a set of
races and complexities.

David, would it be possible to somehow not recurse back into the scheduler
code (like wakeup) from within the port-specific switch_to() code? If
something like that absolutely has to be done then a better solution would
be to eg. introduce an arch-optional post-context-switch callback of
sorts, which would happen with the runqueue lock dropped. The overhead of
this solution can be controlled and it has no impact on the design of the
scheduler. No coding is needed on your side, i'll code it all up if it
solves your problems.

	Ingo

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.493   -> 1.494  
#	      kernel/sched.c	1.83    -> 1.84   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/10	mingo@elte.hu	1.494
# - get rid of rq->frozen, fix context switch races.
# --------------------------------------------
#
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Mon Jun 10 22:01:41 2002
+++ b/kernel/sched.c	Mon Jun 10 22:01:41 2002
@@ -135,7 +135,6 @@
  */
 struct runqueue {
 	spinlock_t lock;
-	spinlock_t frozen;
 	unsigned long nr_running, nr_switches, expired_timestamp;
 	signed long nr_uninterruptible;
 	task_t *curr, *idle;
@@ -403,7 +402,7 @@
 #if CONFIG_SMP || CONFIG_PREEMPT
 asmlinkage void schedule_tail(void)
 {
-	spin_unlock_irq(&this_rq()->frozen);
+	spin_unlock_irq(&this_rq()->lock);
 }
 #endif
 
@@ -828,9 +827,6 @@
 	if (likely(prev != next)) {
 		rq->nr_switches++;
 		rq->curr = next;
-		spin_lock(&rq->frozen);
-		spin_unlock(&rq->lock);
-
 		context_switch(prev, next);
 
 		/*
@@ -840,10 +836,8 @@
 		 */
 		mb();
 		rq = this_rq();
-		spin_unlock_irq(&rq->frozen);
-	} else {
-		spin_unlock_irq(&rq->lock);
 	}
+	spin_unlock_irq(&rq->lock);
 
 	reacquire_kernel_lock(current);
 	preempt_enable_no_resched();
@@ -1599,7 +1593,6 @@
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);
-		spin_lock_init(&rq->frozen);
 		INIT_LIST_HEAD(&rq->migration_queue);
 
 		for (j = 0; j < 2; j++) {

