Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269086AbVBFD0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269086AbVBFD0l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 22:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268623AbVBFD0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 22:26:40 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:19300 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269086AbVBFD0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 22:26:15 -0500
Message-ID: <42058E52.8030306@yahoo.com.au>
Date: Sun, 06 Feb 2005 14:26:10 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: bstroesser@fujitsu-siemens.com, roland@redhat.com, jdike@addtoit.com,
       blaisorblade_spam@yahoo.it, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] fix wait_task_inactive race (was Re: Race condition in ptrace)
References: <42021E35.8050601@fujitsu-siemens.com>	<4202C18F.5010605@yahoo.com.au>	<42036C2C.5040503@fujitsu-siemens.com>	<4203F40C.8040707@yahoo.com.au> <20050204143917.1f9507cb.akpm@osdl.org> <4204020F.2000501@yahoo.com.au> <42044D17.5040703@yahoo.com.au>
In-Reply-To: <42044D17.5040703@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------070507080205010708080905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070507080205010708080905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:

> Something like the following (untested) extension of Bodo's work
> could be the minimal fix for 2.6.11. As I've said though, I'd
> consider it a hack and prefer to do something about the locking.
> That could be done after 2.6.11 though. Depends how you feel.
> 

I think this is the right fix.

When a task is put to sleep, it is dequeued from the runqueue
while it is still running. The problem is that the runqueue
lock can be dropped and retaken in schedule() before the task
actually schedules off, and wait_task_inactive did not account
for this.

I introduced a new function to resolve this state, fixed
wait_task_inactive, and converted over an open coded test.

I did a quick audit of sched.c, and nothing else seems to have
made the same mistake.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


Question: why does wait_task_inactive have different semantics
for UP && PREEMPT than SMP && PREEMPT? I can see that the kthread
caler probably isn't used in the UP case, but technically it is
relying on behaviour that it doesn't get with UP and PREEMPT.
Looks like the ptrace.c caller won't care.

But still, can we either fix it or put a nice comment there?
Preferably fix, if this isn't a very performance critical path?


--------------070507080205010708080905
Content-Type: text/plain;
 name="sched-fixup-races.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-fixup-races.patch"




---

 linux-2.6-npiggin/kernel/sched.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff -puN kernel/sched.c~sched-fixup-races kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-fixup-races	2005-02-06 14:03:53.000000000 +1100
+++ linux-2.6-npiggin/kernel/sched.c	2005-02-06 14:06:43.000000000 +1100
@@ -298,6 +298,14 @@ static DEFINE_PER_CPU(struct runqueue, r
 #endif
 
 /*
+ * Is the task currently running or on the runqueue
+ */
+static int task_onqueue(runqueue_t *rq, task_t *p)
+{
+	return (p->array || task_running(rq, p));
+}
+
+/*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
  * explicitly disabling preemption.
@@ -836,7 +844,7 @@ static int migrate_task(task_t *p, int d
 	 * If the task is not on a runqueue (and not running), then
 	 * it is sufficient to simply update the task's cpu field.
 	 */
-	if (!p->array && !task_running(rq, p)) {
+	if (!task_onqueue(rq, p)) {
 		set_task_cpu(p, dest_cpu);
 		return 0;
 	}
@@ -867,7 +875,7 @@ void wait_task_inactive(task_t * p)
 repeat:
 	rq = task_rq_lock(p, &flags);
 	/* Must be off runqueue entirely, not preempted. */
-	if (unlikely(p->array)) {
+	if (unlikely(task_onqueue(rq, p))) {
 		/* If it's preempted, we yield.  It could be a while. */
 		preempted = !task_running(rq, p);
 		task_rq_unlock(rq, &flags);

_

--------------070507080205010708080905--

