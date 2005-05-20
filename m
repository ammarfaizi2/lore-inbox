Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVETD0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVETD0s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 23:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbVETD0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 23:26:48 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:32858 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261321AbVETD0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 23:26:36 -0400
Message-ID: <428D58E6.8050001@yahoo.com.au>
Date: Fri, 20 May 2005 13:26:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: chen Shang <shangcs@gmail.com>
CC: linux-kernel@vger.kernel.org, rml@tech9.net
Subject: Re: [PATCH] kernel <linux-2.6.11.10> kernel/sched.c
References: <855e4e4605051909561f47351@mail.gmail.com>
In-Reply-To: <855e4e4605051909561f47351@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chen Shang wrote:

>Given the frequency of schedule() calling, there is a margin to
>improve it. In step of recalculate task priority, it first dequeues
>from one priority queue, calls recalc_task_prio(), then enqueue the
>task into another priority queue. However, statistics shows only
>around 0.5% of recalculation changed task priority (see below). While
>rest of 99.5% of recalculation do not change priority, it is
>reasonably to use requeue_task() to avoid overhead of dequeue and
>enqueue on the same priority queue.
>
>The patch is implemented with above idea. Note, a new help function,
>change_queue_task(), to combine dequeue() and enqueue() to reduce one
>function call overhead. Two statistics fields, sched_prio_changed and
>sched_prio_unchanged, are added to provide statistic data on priority
>recalculation.
>
>Thanks,
>
>chen
>shangcs@gmail.com
>

Hi Chen,
With the added branch and the extra icache footprint, it isn't clear
that this would be a win.

Also, you didn't say where your statistics came from (what workload).

So you really need to start by demonstrating some increase on some workload.

Also, minor comments on the patch: please work against mm kernels, 
please follow
kernel coding style, and don't change schedstat output format in the 
same patch
(makes it easier for those with schedstat parsing tools).

> 
>+static void change_queue_task(struct task_struct *p, prio_array_t *array, 
>+							int old_prio)
>+{
>+	list_del(&p->run_list);
>+	if (list_empty(array->queue + old_prio))
>+		__clear_bit(old_prio, array->bitmap);
>+	
>+	sched_info_queued(p);
>+	list_add_tail(&p->run_list, array->queue + p->prio);
>+	__set_bit(p->prio, array->bitmap);
>+	p->array = array;
>+}
> /*
>  * Put task to the end of the run list without the overhead of dequeue
>  * followed by enqueue.
>@@ -2668,7 +2690,7 @@
> 	struct list_head *queue;
> 	unsigned long long now;
> 	unsigned long run_time;
>-	int cpu, idx;
>+	int cpu, idx, prio;
> 
> 	/*
> 	 * Test if we are atomic.  Since do_exit() needs to call into
>@@ -2787,9 +2809,19 @@
> 			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
> 
> 		array = next->array;
>-		dequeue_task(next, array);
>+		prio = next->prio;
> 		recalc_task_prio(next, next->timestamp + delta);
>-		enqueue_task(next, array);
>+		
>+		if (unlikely(prio != next->prio))
>+		{
>+			change_queue_task(next, array, prio);
>+			schedstat_inc(rq, sched_prio_changed);
>+		}
>+		else
>+		{
>+			requeue_task(next, array);
>+			schedstat_inc(rq, sched_prio_unchanged);
>+		}
> 	}
> 	next->activated = 0;
> switch_tasks:
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>


