Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSEHQmc>; Wed, 8 May 2002 12:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314685AbSEHQmb>; Wed, 8 May 2002 12:42:31 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:16657 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S314680AbSEHQm3>; Wed, 8 May 2002 12:42:29 -0400
Date: Wed, 8 May 2002 12:39:14 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O(1) scheduler gives big boost to tbench 192
Message-ID: <Pine.LNX.3.96.1020508122517.3449A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgive me if you feel I've clipped too much from your posting, I'm trying
to capture the points made by various folks without responding to each
message.

---------- Forwarded message ----------
From: Mike Kravetz <kravetz@us.ibm.com>
Date: Tue, 7 May 2002 15:13:56 -0700

I have experimented with reintroducing '__wake_up_sync' support
into the O(1) scheduler.  The modifications are limited to the
'try_to_wake_up' routine as they were before.  If the 'synchronous'
flag is set, then 'try_to_wake_up' trys to put the awakened task
on the same runqueue as the caller without forcing a reschedule.
If the task is not already on a runqueue, this is easy.  If not,
we give up.  Results, restore previous bandwidth results.

BEFORE
------
Pipe latency:    6.5185 microseconds
Pipe bandwidth: 86.35 MB/sec

AFTER
-----
Pipe latency:     6.5723 microseconds
Pipe bandwidth: 540.13 MB/sec

---------- Forwarded message ----------
From: Andrea Arcangeli <andrea@suse.de>

So my hypothesis about the sync wakeup in the below email proven to be right:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=102050009725367&w=2

Many thanks for verifying this.

Personally if the two tasks ends blocking waiting each other, then I
prefer them to be in the same cpu. That was the whole point of the
optimization. If the pipe buffer is large enough not to require reader
or writer to block, then we don't do the sync wakeup just now (there's a
detail with the reader that may block simply because the writer is slow
at writing, but it probably doesn't matter much). There are many cases
where a PAGE_SIZE of buffer gets filled in much less then a timeslice,
and for all those cases rescheduling the two tasks one after the other
in the same cpu is a win, just like the benchmark shows.  Think the
normal pipes we do from the shell, like a "| grep something", they are
very common and they all wants to be handled as a sync wakeups.  In
short when loads of data pass through the pipe with max bandwith, the
sync-wakeup is a definitive win. If the pipe never gets filled then the
writer never sync-wakeup, it just returns the write call asynchronously,
but of course the pipe doesn't get filled because it's not a
max-bandiwth scenario, and so the producer and the consumer are allowed
to scale in multiple cpus by the design of the workload.

Comments?

I would like if you could pass over your changes to the O(1) scheduler
to resurrect the sync-wakeup.

---------- Forwarded message ----------
From: Mike Kravetz <kravetz@us.ibm.com>
Date: Tue, 7 May 2002 15:43:22 -0700

I'm not sure if 'synchronous' is still being passed all the way
down to try_to_wake_up in your tree (since it was removed in 2.5).
This is based off a back port of O(1) to 2.4.18 that Robert Love
did.  The rest of try_to_wake_up (the normal/common path) remains
the same.

---------- Forwarded message ----------
From: Robert Love <rml@tech9.net>
Date: 07 May 2002 16:39:34 -0700

Hm, interesting.  When Ingo removed the sync variants of wake_up he did
it believing the load balancer would handle the case.  Apparently, at
least in this case, that assumption was wrong.

I agree with your earlier statement, though - this benchmark may be a
case where it shows up negatively but in general the balancing is
preferred.  I can think of plenty of workloads where that is the case. 
I also wonder if over time the load balancer would end up putting the
tasks on the same CPU.  That is something the quick pipe benchmark would
not show.

---------- Forwarded message ----------
From: Mike Kravetz <kravetz@us.ibm.com>
Date: Tue, 7 May 2002 16:48:57 -0700

On Tue, May 07, 2002 at 04:39:34PM -0700, Robert Love wrote:
> It is just for pipes we previously used sync, no?

That's the only thing I know of that used it.

I'd really like to know if there are any real workloads that
benefited from this feature, rather than just some benchmark.
I can do some research, but was hoping someone on this list
might remember.  If there is a valid workload, I'll propose
a patch.  However, I don't think we should be adding patches/
features just to help some benchmark that is unrelated to
real world use.

==== start original material ====

Got to change mailers...

Consider the command line:
  grep pattern huge_log_file | cut -f1-2,5,7 | sed 's/stuff/things/' |
  tee extract.tmp | less

Ideally I would like the pipes to run as fast as possible since I'm
waiting for results, using cache and one CPU where that is best, and using
all the CPUs needed if the machine is SMP and processing is complex. I
believe that the original code came closer to that ideal than the recent
code, and obviously I think the example is "valid workload" since I do
stuff like that every time I look for/at server problems.

I believe the benchmark shows a performance issue which will occur in
normal usage.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

