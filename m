Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWDIXxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWDIXxp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 19:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbWDIXxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 19:53:44 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:58002 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750845AbWDIXxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 19:53:44 -0400
Message-ID: <44399E81.9050908@bigpond.net.au>
Date: Mon, 10 Apr 2006 09:53:37 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
References: <200604031459.51542.a1426z@gawab.com> <200604082331.56715.a1426z@gawab.com> <44387855.30004@bigpond.net.au> <200604090804.40867.a1426z@gawab.com>
In-Reply-To: <200604090804.40867.a1426z@gawab.com>
Content-Type: text/plain; charset=windows-1256; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 9 Apr 2006 23:53:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Peter Williams wrote:
>> Al Boldi wrote:
>>> This is especially visible in spa_no_frills, and spa_ws recovers from
>>> this lockup somewhat and starts exhibiting this problem as a choking
>>> behavior.
>>>
>>> Running '# top d.1 (then shift T)' on another vt shows this choking
>>> behavior as the proc gets boosted.
>> But anyway, based on the evidence, I think the problem is caused by the
>> fact that the eatm tasks are running to completion in less than one time
>> slice without sleeping and this means that they never have their
>> priorities reassessed. 
> 
> Yes.
> 
>> The reason that spa_ebs doesn't demonstrate the
>> problem is that it uses a smaller time slice for the first time slice
>> that a task gets. The reason that it does this is that it gives newly
>> forked processes a fairly high priority and if they're left to run for a
>> full 120 msecs at that high priority they can hose the system.  Having a
>> shorter first time slice gives the scheduler a chance to reassess the
>> task's priority before it does much damage.
> 
> But how does this explain spa_no_frills setting promotion to max not having 
> this problem?

I'm still puzzled by this.  The only thing I can think of is that the 
promotion mechanism is to simple in that it just moves all promotable 
tasks up one slot without regard for how long they've been on the queue. 
  Doing this was a deliberate decision based on the desire to minimize 
overhead and the belief that it wouldn't matter in the grand scheme of 
things.  I may do some experimenting with slightly more sophisticated 
version.

Properly done, promotion should hardly ever occur but the cost would be 
slightly more complex enqueue/dequeue operations.  The current version 
will do unnecessary promotions but it was felt this was more than 
compensated for by the lower enqueue/dequeue costs.  We'll see how a 
more sophisticated version goes in terms of trade offs.

> 
>> The reason that the other schedulers don't have this strategy is that I
>> didn't think that it was necessary.  Obviously I was wrong and should
>> extend it to the other schedulers.  It's doubtful whether this will help
>> a great deal with spa_no_frills as it is pure round robin and doesn't
>> reassess priorities except when nice changes of the task changes
>> policies.
> 
> Would it hurt to add it to spa_no_frills and let the children inherit it?

That would be the plan :-)

> 
>> This is one good reason not to use spa_no_frills on
>> production systems.
> 
> spa_ebs is great, but rather bursty.  Even setting max_ia_bonus=0 doesn't fix 
> that.   Is there a way to smooth it like spa_no_frills?

The principal determinant would be the smoothness of the yardstick. 
This is supposed to represent the task with the highest (recent) CPU 
usage rate per share and is used to determine how fairly CPU is being 
distributed among the currently active tasks.  Tasks are given a 
priority based on how their CPU usage rate per share compares to this 
yardstick.  This means that as the system load and/or type of task 
running changes the priorities of the tasks can change dramatically.

Is the burstiness that you're seeing just in the observed priorities or 
is it associated with behavioural burstiness as well?

> 
>> Perhaps you should consider creating a child
>> scheduler on top of it that meets your needs?
> 
> Perhaps.

Good.  I've been hoping that other interested parties might be 
encouraged by the small interface to SPA children to try different ideas 
for scheduling.

> 
>> Anyway, an alternative (and safer) way to reduce the effects of this
>> problem (while your waiting for me to do the above change) is to reduce
>> the size of the time slice.  The only bad effects of doing this is that
>> you'll do slightly worse (less than 1%) on kernbench.
> 
> Actually, setting timeslice to 5,50,100 gives me better performance on 
> kernbench.  After closer inspection, I found 120ms a rather awkward 
> timeslice whereas 5,50, and 100 exhibited a smoother and faster response, 
> which may be machine dependent, thus the need for an autotuner.

When I had the SPA schedulers fully instrumented I did some long term 
measurements of my work station and found that the average CPU burst for 
all tasks was only a few msecs.  The exceptions were some of the tasks 
involved in building kernels.  So the only bad effects of reducing the 
time slice will be causing those tasks to have more context switches 
than otherwise and this will slightly reduce their throughput.

One thing that could be played with here is to vary the time slice based 
on the priority.  This would be in the opposite direction to the normal 
scheduler with higher priority tasks (i.e. those with lower prio values) 
getting smaller time slices.  The rationale being:

1. stop tasks that have been given large bonuses from shutting out other 
tasks for too long, and
2. reduce the context switch rate for tasks that haven't received bonuses.

Because tasks that get large bonuses will have short CPU bursts they 
should not be adversely effected (if this is done properly) as they will 
(except in exceptional circumstances such as a change in behaviour) 
surrender the CPU voluntarily before their reduced time slice has 
expired.  Imaginative use of the available statistics could make this 
largely automatic but there would be a need to be aware that the 
statistics can be distorted by the shorter time slices.

On the other hand, giving tasks without bonuses longer time slices 
shouldn't adversely effect interactive performance as the interactive 
tasks will (courtesy of their bonuses) preempt them.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
