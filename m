Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275350AbTHMTWg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275352AbTHMTWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:22:36 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1533 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S275350AbTHMTWa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:22:30 -0400
Message-ID: <3F34208B.3000908@mvista.com>
Date: Fri, 08 Aug 2003 15:13:31 -0700
From: George Anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: fp38660@tux.appstate.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: How to schedule idle_task?
References: <3227.152.14.51.180.1060357468.squirrel@tux.appstate.edu>
In-Reply-To: <3227.152.14.51.180.1060357468.squirrel@tux.appstate.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Feng Pan wrote:
> Hi,
> 
> I am trying to force idle_task in schedule() but could not get it to work.
> Here is my requirement: I would like the scheduler to prevent any task
> with low priority (meaning lower than a cutoff point) from being scheduled
> to run, even if there are no high priority tasks running (when this
> happens, idle_task should be scheduled to run). They (the low priority
> tasks) have to wait until their dynamic priorities boosted to be able to
> run.
> 
> So here is what I added to schedule():
> 
> /*
>  * Default process to select..
>  */
> next = idle_task(this_cpu);
> c = -1000;
> list_for_each(tmp, &runqueue_head) {
>         p = list_entry(tmp, struct task_struct, run_list);
>         if (can_schedule(p, this_cpu)) {
>                 int weight = goodness(p, this_cpu, prev->active_mm);
>                 if (weight > c)
>                         c = weight, next = p;
>         }
> }
> 
> 
> // This is what I added:
> 
>         if((c > 2) && (c < CUTOFF_PRIORITY)) {
>                 //printk("LOW PRIORITY PROCESS (%d)\n", c);
>                 next = idle_task(this_cpu);
>         }
> 
> 
> // End
> 
> /* Do we need to re-calculate counters? */
> if (unlikely(!c))
> ...
> ...
> ...
> 
> 
> The problem is that once the idle_task is forced to run, no other tasks
> can be scheduled again, and the system hangs, even if there is another
> high priority task running. And if I uncomment the printk statement, the
> message is printed repeatly.
> 
> So the question is, how do I do this properly so that high priority tasks
> can still run?

Not to endorse what you are doing, but, the recalc will not be done 
until all the current times expire and you have put a floor on them 
ever expiring so the recalc will never be done...

SCHED_SPORADIC is not that simple.. :)


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

