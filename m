Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317834AbSFMVPC>; Thu, 13 Jun 2002 17:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317833AbSFMVPB>; Thu, 13 Jun 2002 17:15:01 -0400
Received: from ierw.net.avaya.com ([198.152.13.101]:5544 "EHLO
	ierw.net.avaya.com") by vger.kernel.org with ESMTP
	id <S317843AbSFMVPA>; Thu, 13 Jun 2002 17:15:00 -0400
Message-ID: <3D090B4D.4060104@avaya.com>
Date: Thu, 13 Jun 2002 15:14:53 -0600
From: "Bhavesh P. Davda" <bhavesh@avaya.com>
Organization: Avaya, Inc.
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] SCHED_FIFO and SCHED_RR scheduler fix, kernel 2.4.18
In-Reply-To: <Pine.LNX.4.44.0206132007010.8525-100000@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jun 2002 21:15:10.0531 (UTC) FILETIME=[668E4930:01C2131F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Ingo Molnar wrote:
> good catch, your observations are correct.

Thank you.

> btw., have you checked the 2.5 kernel's scheduler? It does all these
> things correctly: it queues freshly woken up tasks to the tail of the
> queue, it does not reschedule SCHED_FIFO tasks every timer tick and does
> not move RT tasks to the head of the queue in sys_setscheduler().

No I haven't. What prompted me to go with the kernel.org 2.4.18 kernel 
is the fact that the RedHat 7.3 2.4.18-3 kernel, with your O(1) 
scheduler patches besides hundreds of other patches any of which might 
also have changed the scheduler, doesn't honour SCHED_FIFO or SCHED_RR 
real-time priorities at all.

> in terms of 2.4.18, the timer and the setscheduler() change is OK, but i
> dont think we want the add_to_runqueue() change. It changes wakeup
> characteristics for non-RT tasks, it could affect any many-threads or
> many-processes application adversely. And we've been doing FIFO wakeups

I would think that the logical place to add any process to the runqueue 
would be the back of the runqueue. If all processes are ALWAYS added to 
the back of the runqueue, then every process is GUARANTEED to eventually 
be scheduled. No process will be starved indefinitely.

> like this for ages and nobody complained, so it's not that we are in a big
> hurry. Fundamental changes like this are fair game for the 2.5 kernel.
> [and we dont even know the full performance impact of this change even in
> 2.5, although it's been in since 2.5.3 or so. The full effect of things
> like this will show up during beta-testing of 2.6 i suspect.] Plus this
> change does not make *that* much of a difference - not many people use
> SCHED_FIFO tasks with the same priority, the typical usage is to sort the
> tasks by priority - this is one reason why there's a push to increase the
> number of RT priority levels to something like 1000 in the 2.5 kernel.  
> And if multiple SCHED_FIFO tasks have the same priority then exact
> scheduling is more like the matter of luck anyway.

The application that I am dealing with is a communications application 
with 86 SCHED_FIFO processes, crammed between priority levels 7-23, that 
depend on priority preemption using System V semaphores. The 2.2 kernel 
SCHED_FIFO behaviour was correct as far as a preempted SCHED_FIFO 
process being put in the back of the runqueue is concerned. But the 2.4 
kernel SCHED_FIFO behaviour was broken because of the add_to_runqueue() 
bug. That lead to our application grossly misbehaving under the 2.4.18 
scheduler.

As far as performance is concerned, putting the "if" test in 
update_process_times for SCHED_FIFO actually improved the performance of 
our application by 15%, as it would for any SCHED_FIFO centric 
application that relies on priority preemption where the average 
preemption time is > a timer tick.

Therefore, since my guess is that several applications out there depend 
on correct SCHED_FIFO and SCHED_RR behaviour as per the POSIX 
definition, I would like to request that my patch be applied to the 
2.4.19 kernel for people and companies who are reluctant to move to the 
2.5 series kernel for stability reasons.

Thank you.

- Bhavesh

-- 
Bhavesh P. Davda
Avaya Inc
Room B3-B03                     E-mail : bhavesh@avaya.com
1300 West 120th Avenue          Phone  : (303) 538-4438
Westminster, CO 80234           Fax    : (303) 538-3155

