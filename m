Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317261AbSFLAA1>; Tue, 11 Jun 2002 20:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317262AbSFLAA0>; Tue, 11 Jun 2002 20:00:26 -0400
Received: from [208.246.182.58] ([208.246.182.58]:3336 "EHLO inspiron.random")
	by vger.kernel.org with ESMTP id <S317261AbSFLAAY>;
	Tue, 11 Jun 2002 20:00:24 -0400
Date: Wed, 12 Jun 2002 02:00:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: Scheduler Bug (set_cpus_allowed)
Message-ID: <20020612000023.GS1322@inspiron.paqnet.com>
In-Reply-To: <20020606162028.E3193@w-mikek2.des.beaverton.ibm.com> <1023475007.1137.62.camel@sinai> <20020607232004.GA21253@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Jun 08, 2002 at 01:20:04AM +0200, J.A. Magallon wrote:
> 
> On 2002.06.07 Robert Love wrote:
> >
> >Anyhow, with this issue, I guess we need to fix it... I'll send a patch
> >to Linus.
> >
> 
> Plz, could you also post it in the list ? -aa will need also...

So far I merged this Ingo's fix into my tree, I will overview the other
parts soon (as worse next week).

diff -urNp frozen-ref/include/linux/sched_runqueue.h frozen/include/linux/sched_runqueue.h
--- frozen-ref/include/linux/sched_runqueue.h	Tue Jun 11 03:03:35 2002
+++ frozen/include/linux/sched_runqueue.h	Tue Jun 11 03:00:46 2002
@@ -57,7 +57,6 @@ struct prio_array {
  */
 struct runqueue {
 	spinlock_t lock;
-	spinlock_t frozen;
 	unsigned long nr_running, nr_switches, expired_timestamp;
 	long quiescent; /* RCU */
 	task_t *curr, *idle;
diff -urNp frozen-ref/kernel/sched.c frozen/kernel/sched.c
--- frozen-ref/kernel/sched.c	Tue Jun 11 03:03:35 2002
+++ frozen/kernel/sched.c	Tue Jun 11 03:01:29 2002
@@ -352,7 +352,7 @@ void sched_exit(task_t * p)
 #if CONFIG_SMP
 asmlinkage void schedule_tail(task_t *prev)
 {
-	spin_unlock_irq(&this_rq()->frozen);
+	spin_unlock_irq(&this_rq()->lock);
 }
 #endif
 
@@ -762,9 +762,6 @@ switch_tasks:
 	if (likely(prev != next)) {
 		rq->nr_switches++;
 		rq->curr = next;
-		spin_lock(&rq->frozen);
-		spin_unlock(&rq->lock);
-
 		context_switch(prev, next);
 
 		/*
@@ -774,10 +771,8 @@ switch_tasks:
 		 */
 		smp_mb();
 		rq = this_rq();
-		spin_unlock_irq(&rq->frozen);
-	} else {
-		spin_unlock_irq(&rq->lock);
 	}
+	spin_unlock_irq(&rq->lock);
 
 	reacquire_kernel_lock(current);
 	if (need_resched())
@@ -1539,7 +1534,6 @@ void __init sched_init(void)
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);
-		spin_lock_init(&rq->frozen);
 		INIT_LIST_HEAD(&rq->migration_queue);
 
 		for (j = 0; j < 2; j++) {

Andrea
