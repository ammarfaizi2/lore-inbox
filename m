Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271827AbRHUTVM>; Tue, 21 Aug 2001 15:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271180AbRHUTUx>; Tue, 21 Aug 2001 15:20:53 -0400
Received: from mail.haemimont.bg ([193.178.153.252]:71 "EHLO hsm-ms.hsmt")
	by vger.kernel.org with ESMTP id <S271827AbRHUTUi>;
	Tue, 21 Aug 2001 15:20:38 -0400
Message-ID: <3B82D104.DA604340@haemimont.bg>
Date: Tue, 21 Aug 2001 21:22:12 +0000
From: lucho <lucho@haemimont.bg>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: The round robin scheduling policy doesn't work
Content-Type: text/plain; charset=x-user-defined
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Aug 2001 19:21:44.0130 (UTC) FILETIME=[8359EA20:01C12A76]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The round robin scheduling policy does not work.

The kernel in question is 2.4.8 (i still haven't downloaded the 2.4.9).

Description:
Suppose there are several processes in RR mode, all with equal
priorities
(and all the remaining processes in the system are either SCHED_OTHER or
realtime but with
lower priorities) then in theory the scheduler should spin these
processes
(in round-robin manner), but in reality this does not hapen. Only one of
the processes
(in fact the first created) in question is given the entire CPU time,
though the others are not sleeping and have the same real-time priority.

The only ways for the process-monopolist to relinquish the CPU is to do
any
blocking syscall (and thus remove itself from the runqueue). The
sched_yield()
syscall does not work because it does not remove the current task from
the runqueue.

The following simple example code should demonstrate this odd behavior
of the scheduler:

int main()
{
    struct sched_param sp;

    sp.sched_priority = 1;
    sched_setscheduler(0, SCHED_RR, &sp);

    if(fork() == 0) {
        while(1) {
            printf("child\n");
            sched_yield();
        }
    }
    else {
        while(1) {
            printf("parent\n");
            sched_yield();
        }
    }

    return 0;
}

I investigated the problem by inserting printk()s at some points in the
schedule() function
in kernel/scheduler.c and managet to find out what's wrong. The reason
for this
wrong behavior seems to be the following piece of code in schedule():

    if (prev->state == TASK_RUNNING)
        goto still_running;

still_running_back:

    ........
    ........

still_running:
    if (!(prev->cpus_allowed & (1UL << this_cpu)))
        goto still_running_back;
    c = goodness(prev, this_cpu, prev->active_mm);
    next = prev;
    goto still_running_back;

which initializes the `c' variable with the current process goodness
(1001 in the example)
and the `next' - with `prev' regardless whether the timeslice of the
prev has expired
(current->counter == 0) or not. So the `list_for_each' loop over the
runqueue never chooses
any different task (because their goodnesses are never bigger than the
so initialized `c').

I didn't get why is that `stil_running' code necessary at all (at least
in uniprocessor system)
since the `list_for_all' loop will anyway go thru the prev task if it's
in running state
because it is certainly in the runqueue, but it rather makes the
scheduler a bit slower
because of the unnecessary two calculations of the prev's goodness.

I removed this code and rebuilt the kernel, and actually got the round
robin working
(i heavily tested it) i.e. then the scheduler really cycles through all
the SCHED_RR processes.

But still the yield() wasn't working (it was just like a NOP).

I found out that the erason for this is that the sys_sched_yield()
function just sets
current->need_resched which causes the schedule() to be called, but
schedule() looks at
the current->counter and when it's nonzero (when current is SCHED_RR
process),
it doesn't switch to other process.

So i added the code:

    if (current->policy == SCHED_RR)
        current->counter = 0;

in the sys_sched_yield() and now it works fine too.

I hope this bug report will be useful.
My name is Luchezar Belev.
Best regards.



