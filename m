Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVETHV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVETHV2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 03:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVETHV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 03:21:28 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:41653 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261329AbVETHVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 03:21:23 -0400
Message-ID: <428D8FEE.8030303@yahoo.com.au>
Date: Fri, 20 May 2005 17:21:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: chen Shang <shangcs@gmail.com>
CC: linux-kernel@vger.kernel.org, rml@tech9.net
Subject: Re: [PATCH] kernel <linux-2.6.11.10> kernel/sched.c
References: <855e4e4605051909561f47351@mail.gmail.com>	 <428D58E6.8050001@yahoo.com.au>	 <855e4e460505192117155577e@mail.gmail.com>	 <428D71F9.10503@yahoo.com.au> <855e4e46050520001215be7cde@mail.gmail.com>
In-Reply-To: <855e4e46050520001215be7cde@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chen Shang wrote:

>I minimized my patch and against to 2.6.12-rc4 this time, see below.
>
>The new schedstat fields are for the test propose only, so I removed
>them completedly from patch. Theoritically, requeue_task() is always
>cheaper than dequeue_task() followed by enqueue_task(). So, if 99% of
>priority recalculation trigger requeue_task(), it will save.
>
>In addition, my load is to build the kernel, which took around 30
>minutes with around 30% CPU usage on 2x2 processors (duel processors
>with HT enable).
>Here is the statistics:
>         
>CPU0: priority_changed (669 times), priority_unchanged(335,138 times)
>CPU1: priority_changed (784 times), priority_unchanged(342,419 times)
>CPU2: priority_changed (782 times), priority_unchanged(283,494 times)
>CPU3: priority_changed (872 times), priority_unchanged(365,865 times)
>
>

OK that gives you a good grounds to look at the patch, but _performance_
improvement is what is needed to get it included.

>Thanks,
>-chen
>
>
>/*=====Patch=====*/
>--- linux-2.6.12-rc4.orig/kernel/sched.c	2005-05-19 14:57:55.000000000 -0700
>+++ linux-2.6.12-rc4/kernel/sched.c	2005-05-19 23:47:22.000000000 -0700
>@@ -2613,7 +2613,7 @@
> 	struct list_head *queue;
> 	unsigned long long now;
> 	unsigned long run_time;
>-	int cpu, idx;
>+	int cpu, idx, prio;
> 
> 	/*
> 	 * Test if we are atomic.  Since do_exit() needs to call into
>@@ -2735,9 +2735,17 @@
> 			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;
> 
> 		array = next->array;
>-		dequeue_task(next, array);
>+		prio = next->prio;
>+		
> 		recalc_task_prio(next, next->timestamp + delta);
>-		enqueue_task(next, array);
>+
>+		if (unlikely(prio != next->prio))
>+		{
>+			dequeue_task(next, array);
>+			enqueue_task(next, array);
>+		}
>+		else
>+			requeue_task(next, array);
>

Coding style says
if (unlikely()) {
    ...
} else
    ...


