Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273213AbRKSHbE>; Mon, 19 Nov 2001 02:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273261AbRKSHa5>; Mon, 19 Nov 2001 02:30:57 -0500
Received: from h00010256f583.ne.mediaone.net ([66.31.45.140]:59858 "EHLO
	portent.dyndns.org") by vger.kernel.org with ESMTP
	id <S273065AbRKSHak>; Mon, 19 Nov 2001 02:30:40 -0500
Message-Id: <200111190731.fAJ7VUs21238@portent.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
From: Lev Makhlis <mlev@despammed.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: Bug or feature? Priority in /proc/<pid>/stat for RT processes
Date: Mon, 19 Nov 2001 02:31:30 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111190601.fAJ616Q32518@saturn.cs.uml.edu>
In-Reply-To: <200111190601.fAJ616Q32518@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 01:01 am, Albert D. Cahalan wrote:
> Lev Makhlis writes:
> > I have noticed that when the scheduling policy of a process is SCHED_FIFO
> > or SCHED_RR, proc_pid_stat() in fs/proc/array.c still uses the counter
> > field in the task structure to calculate the priority in
> > /proc/<pid>/stat. For such processes, the counter field is ignored by the
> > scheduler in favour of the rt_priority field.  Thus, even though the
> > actual priority is available via sched_getparam(2), the priority in
> > /proc/<pid>/stat -- and, consequently, in the output of ps(1) and top(1)
> > -- seems to be, for SCHED_FIFO/SCHED_RR processes, a value that is not
> > representative at all of how the process is scheduled.
> >
> > I have thrown together a patch to address this, but I can't say I feel
> > entirely comfortable about scaling from 1..99 to -20..20.
>
> Do not do this. Just supply the raw value for ps(1) and top(1) to use.
> Also supply the scheduling policy type. You can tack this on the end
> of /proc/<pid>/stat and tell me when Linus accepts it so that I can
> make ps(1) and top(1) support the new info.

I agree scaling from 1.99 to 20..-20 wasn't a good idea, but I don't think
supplying the raw (1..99) value without any transformation at all would be
right either -- I think we need to reverse its sign, for the following
reason: 

If you look at what happens on other Unix platforms, the "direction"
of priority values can vary: usually, higher values mean lower priority,
but, for example, on Solaris, higher values mean higher priority.
But on any specific platform, the "direction" is consistent across
the different scheduling policies.  On Linux, it's "higher value = lower
priority" for the default timesharing policy, and therefore I think it should
be the same for the RT priorities.

I think the Right Thing would be to use a f(x) = c - x transormation,
where c could be 100, or 0, or -20, or -100, or something else.
-20 or -100 have the advantage of preserving the order relationship
between priorities across the scheduling policies.

The patch below uses c=-100 -- as an example.

-------------------------CUT------------------------------
--- linux-2.4.12/fs/proc/array.c        Sat Oct 13 13:09:29 2001
+++ linux/fs/proc/array.c       Mon Nov 19 01:33:20 2001
@@ -334,8 +334,12 @@

        /* scale priority and nice values from timeslices to -20..20 */
        /* to make it look like a "normal" Unix priority/nice value  */
-       priority = task->counter;
-       priority = 20 - (priority * 10 + DEF_COUNTER / 2) / DEF_COUNTER;
+       if ((task->policy & ~SCHED_YIELD) == SCHED_OTHER) {
+               priority = task->counter;
+               priority = 20 - (priority * 10 + DEF_COUNTER / 2) / 
DEF_COUNTER;
+       } else {
+               priority = -100 - task->rt_priority;
+       }
        nice = task->nice;

        read_lock(&tasklist_lock);
@@ -343,7 +347,7 @@
        read_unlock(&tasklist_lock);
        res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %lu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d\n",
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %d\n",
                task->pid,
                task->comm,
                state,
@@ -386,7 +390,8 @@
                task->nswap,
                task->cnswap,
                task->exit_signal,
-               task->processor);
+               task->processor,
+               task->policy & ~SCHED_YIELD);
        if(mm)
                mmput(mm);
        return res;
