Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280388AbRKXWfL>; Sat, 24 Nov 2001 17:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280402AbRKXWfB>; Sat, 24 Nov 2001 17:35:01 -0500
Received: from [208.129.208.52] ([208.129.208.52]:4621 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S280388AbRKXWev>;
	Sat, 24 Nov 2001 17:34:51 -0500
Date: Sat, 24 Nov 2001 14:44:41 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched_[set|get]_affinity() syscall, 2.4.15-pre9
In-Reply-To: <Pine.LNX.4.33.0111231240320.3988-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0111241422030.1625-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2001, Ingo Molnar wrote:

>
> On Thu, 22 Nov 2001, Mark Hahn wrote:
>
> > only that it's nontrivial to estimate the migration costs, I think. at
> > one point, around 2.3.3*, there was some effort at doing this - or
> > something like it.  specifically, the scheduler kept track of how long
> > a process ran on average, and was slightly more willing to migrate a
> > short-slice process than a long-slice.  "short" was defined relative
> > to cache size and a WAG at dram bandwidth.
>
> yes. I added the avg_slice code, and i removed it as well - it was
> hopeless to get it right and it was causing bad performance for certain
> application sloads. Current CPUs simply do not support any good way of
> tracking cache footprint of processes. There are methods that are an
> approximation (eg. uninterrupted runtime and cache footprint are in a
> monotonic relationship), but none of the methods (including cache traffic
> machine counters) are good enough to cover all the important corner cases,
> due to cache aliasing, MESI-invalidation and other effects.

Uninterrupted run-time is a good approximation of a task's cache footprint.
It's true, it's not 100% successful, processes like :

for (;;);

are uncorrectly classified but it's still way better than the method we're
currently using ( PROC_CHANGE_PENALTY ).
By taking the avg :

AVG = (AVG + LAST) >> 1;

run-time in jiffies is 1) fast 2) has a nice hysteresis property 3) gives
you a pretty good estimation of the "nature" of the task.
I'm currently using it as 1) classification for load balancing between
CPUs 2) task's watermark value for your counter decay patch :

[kernel/timer.c]

        if (p->counter > p->avg_jrun)
            --p->counter;
        else if (++p->timer_ticks >= p->counter) {
            p->counter = 0;
            p->timer_ticks = 0;
            p->need_resched = 1;
        }

In this way I/O bound tasks have a counter decay behavior like the
standard scheduler while CPU bound ones preserve the priority inversion
proof.




- Davide


