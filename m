Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbUKPXGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUKPXGS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 18:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbUKPXEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 18:04:37 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:22153 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261873AbUKPXDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:03:16 -0500
Message-ID: <419A8730.8030108@yahoo.com.au>
Date: Wed, 17 Nov 2004 10:03:12 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] sched: fix ->nr_uninterruptible handling
 bugs
References: <20041116113209.GA1890@elte.hu> <419A83FB.2080308@yahoo.com.au>
In-Reply-To: <419A83FB.2080308@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------090405010602040301020907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090405010602040301020907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:
> Ingo Molnar wrote:
> 
>> PREEMPT_RT on SMP systems triggered weird (very high) load average
>> values rather easily, which turned out to be a mainline kernel
>> ->nr_uninterruptible handling bug in try_to_wake_up().
>>
>> the following code:
>>
>>         if (old_state == TASK_UNINTERRUPTIBLE) {
>>                 old_rq->nr_uninterruptible--;
>>
>> potentially executes with old_rq potentially being != rq, and hence
>> updating ->nr_uninterruptible without the lock held. Given a
>> sufficiently concurrent preemption workload the count can get out of
>> whack and updates might get lost, permanently skewing the global 
>> count. Nothing except the load-average uses nr_uninterruptible() so this
>> condition can go unnoticed quite easily.
>>
> 
> Hi Ingo,
> Yes you're right.
> 
> I have another idea. Revert back to the old code, then just transfer
> the nr_uninterruptible count when migrating a task. That way, the
> rq's nr_uninterruptible field always is a measure of the number of
> uninterruptible tasks on it. What do you think?

Something like this:

--------------090405010602040301020907
Content-Type: text/x-patch;
 name="sched-nr_unint-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-nr_unint-fix.patch"




---

 linux-2.6-npiggin/kernel/sched.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff -puN kernel/sched.c~sched-nr_unint-fix kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-nr_unint-fix	2004-11-17 09:54:36.000000000 +1100
+++ linux-2.6-npiggin/kernel/sched.c	2004-11-17 10:01:49.000000000 +1100
@@ -981,14 +981,14 @@ static int try_to_wake_up(task_t * p, un
 	int cpu, this_cpu, success = 0;
 	unsigned long flags;
 	long old_state;
-	runqueue_t *rq, *old_rq;
+	runqueue_t *rq;
 #ifdef CONFIG_SMP
 	unsigned long load, this_load;
 	struct sched_domain *sd;
 	int new_cpu;
 #endif
 
-	old_rq = rq = task_rq_lock(p, &flags);
+	rq = task_rq_lock(p, &flags);
 	schedstat_inc(rq, ttwu_cnt);
 	old_state = p->state;
 	if (!(old_state & state))
@@ -1083,7 +1083,7 @@ out_set_cpu:
 out_activate:
 #endif /* CONFIG_SMP */
 	if (old_state == TASK_UNINTERRUPTIBLE) {
-		old_rq->nr_uninterruptible--;
+		rq->nr_uninterruptible--;
 		/*
 		 * Tasks on involuntary sleep don't earn
 		 * sleep_avg beyond just interactive state.
@@ -1608,8 +1608,12 @@ void pull_task(runqueue_t *src_rq, prio_
 {
 	dequeue_task(p, src_array);
 	src_rq->nr_running--;
-	set_task_cpu(p, this_cpu);
 	this_rq->nr_running++;
+	if (p->state == TASK_UNINTERRUPTIBLE) {
+		src_rq->nr_uninterruptible--;
+		this_rq->nr_uninterruptible++;
+	}
+	set_task_cpu(p, this_cpu);
 	enqueue_task(p, this_array);
 	p->timestamp = (p->timestamp - src_rq->timestamp_last_tick)
 				+ this_rq->timestamp_last_tick;

_

--------------090405010602040301020907--
