Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271932AbTHHVSi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 17:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271938AbTHHVSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 17:18:38 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:8109 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S271932AbTHHVSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 17:18:36 -0400
Date: Fri, 8 Aug 2003 23:18:45 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Feng Pan <fp38660@tux.appstate.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to schedule idle_task?
Message-ID: <20030808211845.GA26856@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Feng Pan <fp38660@tux.appstate.edu>,
	linux-kernel@vger.kernel.org
References: <3227.152.14.51.180.1060357468.squirrel@tux.appstate.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3227.152.14.51.180.1060357468.squirrel@tux.appstate.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 11:44:28AM -0400, Feng Pan wrote:
> Hi,
> 
> I am trying to force idle_task in schedule() but could not get it to work.
> Here is my requirement: I would like the scheduler to prevent any task
> with low priority (meaning lower than a cutoff point) from being scheduled
> to run, even if there are no high priority tasks running (when this
> happens, idle_task should be scheduled to run). They (the low priority
> tasks) have to wait until their dynamic priorities boosted to be able to
> run.

hmm, why not simply _not_scheduling_ the tasks you do
not want to be scheduled? (sounds weird?)

in the scheduler, you basically decide which task
is the chosen one, if you decide to exclude some tasks
from that decision, they will not run (be scheduled)

HTH,
Herbert 

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
> 
> btw, the kernel version is 2.4.21
> 
> Thanks
> 
> Feng
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
