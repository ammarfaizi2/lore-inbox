Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287793AbSAIQZQ>; Wed, 9 Jan 2002 11:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287804AbSAIQZH>; Wed, 9 Jan 2002 11:25:07 -0500
Received: from mx2.elte.hu ([157.181.151.9]:31158 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S287793AbSAIQYr>;
	Wed, 9 Jan 2002 11:24:47 -0500
Date: Wed, 9 Jan 2002 19:22:00 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Mike Kravetz <kravetz@us.ibm.com>,
        Anton Blanchard <anton@samba.org>, george anzinger <george@mvista.com>,
        Davide Libenzi <davidel@xmailserver.org>
Subject: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17
Message-ID: <Pine.LNX.4.33.0201091824570.5876-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this is the latest update of the O(1) scheduler:

	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-pre10-G1.patch

        http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-G1.patch

this patch contains fixes to the scheduler (mainly from Rusty Russel), and
it also contains a much reworked load-balancing code, triggered by Mike
Kravetz's analysis/numbers.

the previous load-balancer had a number of childhood problems, the biggest
problem was that it rebalanced runqueues way too often. Also, it sometimes
got into a load-balancing resonance. A usual 'make -j15' kernel compile on
an 8-way box generates about 70 thousand reschedules until it finishes.
Under the stock 2.5.2-pre10 kernel, about 20% of those reschedules were
CPU-unaffine, ie. they scheduled to a task that was load-balanced over
into this queue from another CPU.

With 2.5.2-pre10 + -G1, the number of total 'incorrect' reschedules is
down to 0.6%, and even the majority of those is caused by 'idle-pull'
rebalancing: a situation that inevitably causes an unaffine reschedule.
The number of 'unforced' unaffine reschedules is down to 0.2%.

fairness is equally good with both kernels, both the -G1 and the vanilla
kernel distribute CPU-using processes equally well between CPUs.

the new load balancer in the -G1 patch has the following logic:

there are two kinds of load-balancing activities, 'idle balancing' and
'fairness balancing'.

Idle balancing must happen if any CPU runs out of processes - in this case
it must find some new work or else it will stay idle and the CPU power
goes unused.

Fairness rebalancing must happen to even out the runqueues between CPUs -
to avoid a situation where eg. 5 processes are running on one CPU, and 1
process is running on the other CPU - the processes on CPU#0 will only see
20% of single-CPU performance.  The 'fair' distribution is to run 3-3
processes on both CPUs, so each process will get a fair 33% share of
single-CPU performance.

Whenever an idle rebalance situation happens, we try to find a new process
for the soon-to-be-idle CPU. The CPU searches all the other CPUs and takes
processes from the CPU that has the longest runqueue. The idle CPU pulls
only a *single* process - this is the minimum we must do to avoid the CPU
going idle.

Fairness rebalancing happens at a 250 msec pace, which 'rebalance tick'
happens on every CPU, every 250 msecs. In this case we will rebalance
multiple processes as well if needed. A commonly occuring situation is
that processes rush to a runqueue and go off the runqueue quickly. Such
'fluctuations' of runqueue lengths must not result in unnecessery
rebalancing. Thus the fairness rebalancing code uses a (simple & fast)
method of recording the runqueue length on any particular CPU in the last
rebalancing tick. The balancer takes the shorter runqueue length value of
the 'previous' and 'current' length, discarding the longer one as
statistical fluctuation. This mechanizm works pretty well: if a runqueue
is long during a long period of time, then the balancer will 'accept' that
the queue is long and will rebalance it. If the runqueue is only
temporarily long then the load-balancer will not balance it.

in essence the fairness rebalancer establishes an 'average runqueue
length' of sorts by sampling the runqueue length - without adding overhead
to the actual runqueue manipulation code (wake_up() & schedule()). There
exist more accurate methods of sampling runqueue length, but the current
method works pretty well already.

[ there is one possible improvement to this logic that i'll add, it's the
ability of the wakeup code to trigger an idle rebalance. The wakeup code
does not want to trigger a fairness rebalance, the fairness rebalance is
purely timer-driven, ]

anyway, here are some kernel compilation times in seconds, on an 8-way,
Xeon, 700 MHz, 2MB L2 cache box. [lower numbers are better, results are
the best results from 4 successive runs, kernel tree fully cached, exactly
the same kernel tree was compiled under every kernel]:

                                time make -j15 bzImage

2.4.17-vanilla:                 44.6 sec   +- 0.2 sec
2.5.2-pre9-vanilla:             45.3 sec   +- 0.2 sec
2.5.2-pre10-vanilla:            45.4 sec   +- 0.2 sec
2.5.2-pre10-G1:                 43.4 sec   +- 0.2 sec

ie. the -G1 kernel compiles kernels faster than any other kernel i tried.

Changes:

 - Rusty Russell: fix rebalance tick definition if HZ < 100 in UML.

 - Rusty Russell: check for new_mask in set_cpus_allowed(), to be sure.

 - Rusty Russell: clean up rq_ macros so that HT can be done by changing
   just one of the macros.

 - Rusty Russell: remove rq->cpu.

 - Rusty Russell: remove cacheline padding from runqueue_t, it's pointless
   now.

 - Rusty Russell: sched.c comment fixes.

 - increase minimum timeslice length by 10 msec.

 - fix comments in sched.h

	Ingo

