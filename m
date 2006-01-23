Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWAWXcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWAWXcJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 18:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWAWXcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 18:32:09 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:36340 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030211AbWAWXcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 18:32:08 -0500
Message-ID: <43D56774.1030406@bigpond.net.au>
Date: Tue, 24 Jan 2006 10:32:04 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paolo Ornati <ornati@fastwebnet.it>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.2 for  2.6.16-rc1 and 2.6.16-rc1-mm1
References: <43D00887.6010409@bigpond.net.au>	<20060121114616.4a906b4f@localhost>	<43D2BE83.1020200@bigpond.net.au> <20060123210918.54d4fc75@localhost>
In-Reply-To: <20060123210918.54d4fc75@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 23 Jan 2006 23:32:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati wrote:
> On Sun, 22 Jan 2006 10:06:43 +1100
> Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
> 
>>>---- spa_ebs: great! (as expected)
>>>
>>>(sched_fooler)
>>>  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>>> 5418 paolo     34   0  2392  288  228 R 51.4  0.1   1:06.47 a.out
>>> 5419 paolo     34   0  2392  288  228 R 43.7  0.1   0:54.60 a.out
>>> 5448 paolo     11   0  4952 1468  372 D  3.0  0.3   0:00.12 dd
>>>
>>>(transcode)
>>>  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>>> 5456 paolo     34   0  115m  18m 2432 R 51.9  3.7   0:23.34 transcode
>>> 5470 paolo     12   0 51000 4472 1872 S  5.7  0.9   0:02.38 tcdecode
>>> 5480 paolo     11   0  4948 1468  372 D  3.5  0.3   0:00.33 dd
>>>
>>>Very good DD test performance in both cases.
>>
>>Good.  How do you find the interactive responsiveness with this one?
> 
> 
> It seems geneally good.
> 
> However I've noticed that priority of X fluctuate a lot for unknown
> reasons...
> 
> When doing almost nothing it gets prio 6/7 but if I only move the
> cursor a bit it jumps up to ~29. 
> 
> If I'm running glxgears (with diret rendering ON) the priority stay to
> 6/7 and moving the cursor I'm only able to get priority 8.

This is a function of the "entitlement based" fairness part of the 
scheduler.  Conceptually, it allocates each SCHED_NORMAL task "shares" 
based on its nice value (19->1, 0->20, -20->420) and calculates an 
entitlement based on the ratio of a tasks shares and the total shares in 
play.  It then compares the task's recent average cpu usage rate with 
its entitlement and sets the dynamic priority so as to try and match the 
cpu usage rate to the entitlement.

To implement this concept efficiently (i.e. avoiding maths especially 
divides as much as possible) a slightly different approach is taken in 
practice.  For each run queue, a recent maximum average cpu usage rate 
per share for tasks on that queue (a yardstick) is kept and each tasks 
usage per share is compared to that.  If it is greater then it becomes 
the new yardstick and the task is given a base dynamic priority of 34 
and otherwise it is given a priority between 11 and 34 based in 
proportion to the ratio of its usage per share to the yardstick.

Tasks are also awarded an interactive bonus based on the amount of 
interactive sleeping that they've been doing recently and this is 
subtracted from the base priority.  The 11 point offset in the base 
priority is there to allow the bonus to be applied without encroaching 
on the RT priority range.

To cater for periods of inactivity the yardstick is decayed towards zero 
each tick.

In general, this means that the busiest task on the system (in terms of 
cpu usage per share) at any particular time will have a priority of (34 
- interactivity bonus) but when the system is idle this may not be the 
case if the yardstick had been quite high and hasn't yet decayed enough.

This is why when the system is idle the X priority jumps to 29 when you 
move the mouse as it is now the new yardstick even with a relatively low 
usage rate.  But when glxgears is running it becomes the yardstick with 
quite high cpu usage rate per share and when you move the mouse the X 
servers usage per share is still small compared to the yardstick so it 
retains a small priority value.

> 
> Under load X priority goes up and it suffers (cursor jumps a bit).
> 
> IOW: strangeness!
> 

I hope I've explained the strangeness :-) but I'm still concerned that 
the cursor is jumping a bit.  In general, the entitlement based 
mechanism is quite good for interactive response as most interactive 
tasks have very low CPU usage rates but under heavy load their usage 
rate per share can approach the yardstick (mainly because the yardstick 
tends to get smaller under load) so some help is required in the form of 
interactive bonuses.  It looks like this component still needs a little 
work.

One area that I'm looking at is reducing the time slice size for the 
first CPU run after a task is forked.  From the above it should be 
apparent that a task with recent average CPU usage rate of zero (such as 
a newly forked process) will get a priority of (11 - bonus).  This is 
usually a good thing as it means that these tasks have good latency but 
if they are CPU bound tasks they will block out most other runnable 
tasks for a full time slice which is quite long (120 msecs).  (The 
occasions where this effect would be most noticeable is when doing 
something like a kernel build where lots of CPU intensive tasks are 
being forked.)  Shortening this first time slice won't have much effect 
on non CPU intensive tasks as they would generally have voluntarily 
surrendered the CPU within in a few msecs anyway and it will allow the 
scheduler to give the CPU intensive tasks an appropriate priority early 
in their life.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
