Return-Path: <linux-kernel-owner+willy=40w.ods.org-S276147AbVBEEgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S276147AbVBEEgJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 23:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S276144AbVBEEgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 23:36:08 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:11400 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S276067AbVBEEfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 23:35:41 -0500
Message-ID: <42044D17.5040703@yahoo.com.au>
Date: Sat, 05 Feb 2005 15:35:35 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: bstroesser@fujitsu-siemens.com, roland@redhat.com, jdike@addtoit.com,
       blaisorblade_spam@yahoo.it, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Race condition in ptrace
References: <42021E35.8050601@fujitsu-siemens.com>	<4202C18F.5010605@yahoo.com.au>	<42036C2C.5040503@fujitsu-siemens.com>	<4203F40C.8040707@yahoo.com.au> <20050204143917.1f9507cb.akpm@osdl.org> <4204020F.2000501@yahoo.com.au>
In-Reply-To: <4204020F.2000501@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------030704040005090303040304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030704040005090303040304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:
> Andrew Morton wrote:
> 
>> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>

>>> Andrew, IMO this is another bug to hold 2.6.11 for.
>>
>>
>>
>> Sure.  I wouldn't consider Bodo's patch to be the one to use though..
> 
> 
> No. Something similar could be done that works on all architectures
> and all wait_task_inactive callers (and is confined to sched.c). That
> would still be more or less a hack to work around smtnice's unfortunate
> locking though.
> 

Something like the following (untested) extension of Bodo's work
could be the minimal fix for 2.6.11. As I've said though, I'd
consider it a hack and prefer to do something about the locking.
That could be done after 2.6.11 though. Depends how you feel.

Bodo, I wonder if this looks like a suitable fix for your problem?

--------------030704040005090303040304
Content-Type: text/plain;
 name="sched-fixup-locking.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-fixup-locking.patch"




---

 linux-2.6-npiggin/include/linux/init_task.h |    1 +
 linux-2.6-npiggin/include/linux/sched.h     |    1 +
 linux-2.6-npiggin/kernel/sched.c            |   12 ++++++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff -puN include/linux/sched.h~sched-fixup-locking include/linux/sched.h
--- linux-2.6/include/linux/sched.h~sched-fixup-locking	2005-02-05 15:24:00.000000000 +1100
+++ linux-2.6-npiggin/include/linux/sched.h	2005-02-05 15:24:39.000000000 +1100
@@ -533,6 +533,7 @@ struct task_struct {
 	unsigned long ptrace;
 
 	int lock_depth;		/* Lock depth */
+	int on_cpu;		/* Is the task on the CPU, or in a ctxsw */
 
 	int prio, static_prio;
 	struct list_head run_list;
diff -puN kernel/sched.c~sched-fixup-locking kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-fixup-locking	2005-02-05 15:24:02.000000000 +1100
+++ linux-2.6-npiggin/kernel/sched.c	2005-02-05 15:34:37.000000000 +1100
@@ -294,7 +294,7 @@ static DEFINE_PER_CPU(struct runqueue, r
 #ifndef prepare_arch_switch
 # define prepare_arch_switch(rq, next)	do { } while (0)
 # define finish_arch_switch(rq, next)	spin_unlock_irq(&(rq)->lock)
-# define task_running(rq, p)		((rq)->curr == (p))
+# define task_running(rq, p)		((p)->on_cpu)
 #endif
 
 /*
@@ -867,7 +867,7 @@ void wait_task_inactive(task_t * p)
 repeat:
 	rq = task_rq_lock(p, &flags);
 	/* Must be off runqueue entirely, not preempted. */
-	if (unlikely(p->array)) {
+	if (unlikely(p->array || p->on_cpu)) {
 		/* If it's preempted, we yield.  It could be a while. */
 		preempted = !task_running(rq, p);
 		task_rq_unlock(rq, &flags);
@@ -2805,11 +2805,18 @@ switch_tasks:
 		rq->curr = next;
 		++*switch_count;
 
+		next->on_cpu = 1;
 		prepare_arch_switch(rq, next);
 		prev = context_switch(rq, prev, next);
 		barrier();
 
 		finish_task_switch(prev);
+		/*
+		 * Some architectures release the runqueue lock before
+		 * context switching. Make sure this isn't reordered.
+		 */
+		smp_wmb();
+		prev->on_cpu = 0;
 	} else
 		spin_unlock_irq(&rq->lock);
 
@@ -4055,6 +4062,7 @@ void __devinit init_idle(task_t *idle, i
 	set_task_cpu(idle, cpu);
 
 	spin_lock_irqsave(&rq->lock, flags);
+	idle->on_cpu = 1;
 	rq->curr = rq->idle = idle;
 	set_tsk_need_resched(idle);
 	spin_unlock_irqrestore(&rq->lock, flags);
diff -puN include/linux/init_task.h~sched-fixup-locking include/linux/init_task.h
--- linux-2.6/include/linux/init_task.h~sched-fixup-locking	2005-02-05 15:24:56.000000000 +1100
+++ linux-2.6-npiggin/include/linux/init_task.h	2005-02-05 15:25:07.000000000 +1100
@@ -73,6 +73,7 @@ extern struct group_info init_groups;
 	.usage		= ATOMIC_INIT(2),				\
 	.flags		= 0,						\
 	.lock_depth	= -1,						\
+	.on_cpu		= 0,						\
 	.prio		= MAX_PRIO-20,					\
 	.static_prio	= MAX_PRIO-20,					\
 	.policy		= SCHED_NORMAL,					\

_

--------------030704040005090303040304--

