Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263688AbUJ2XSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbUJ2XSW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263669AbUJ2XQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:16:12 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52678 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263641AbUJ2XMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:12:49 -0400
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20041029214602.GA15605@elte.hu>
References: <20041029170237.GA12374@elte.hu>
	 <20041029170948.GA13727@elte.hu> <20041029193303.7d3990b4@mango.fruits.de>
	 <20041029172151.GB16276@elte.hu> <20041029172243.GA19630@elte.hu>
	 <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu>
	 <20041029233117.6d29c383@mango.fruits.de> <20041029212545.GA13199@elte.hu>
	 <1099086166.1468.4.camel@krustophenia.net> <20041029214602.GA15605@elte.hu>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 19:12:46 -0400
Message-Id: <1099091566.1461.8.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 23:46 +0200, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Fri, 2004-10-29 at 23:25 +0200, Ingo Molnar wrote:
> > > > will do so. btw: i think i'm a bit confused right now. What debugging
> > > > features should i have enabled for this test?
> > > 
> > > this particular one (atomicity-checking) is always-enabled if you have
> > > the -RT patch applied (it's a really cheap check).
> > 
> > One more question, what do you recommend the priorities of the IRQ
> > threads be set to?  AIUI for xrun-free operation with JACK, all that
> > is needed is to set the RT priorities of the soundcard IRQ thread
> > highest, followed by the JACK threads, then the other IRQ threads.  Is
> > this correct?
> 
> correct. softirqs are not used by the sound subsystem so there's no
> ksoftirqd dependency.
> 

OK well I set all IRQ threads to SCHED_OTHER except the soundcard, which
is SCHED_FIFO, and I still get a LOT of xruns, compared to zero xruns
over tens of millions of cycles with T3.

rlrevell@mindpipe:~$ for p in `ps auxww | grep IRQ | grep -v grep | awk
'{print $2}'`; do chrt -p $p ;done
pid 647's current scheduling policy: SCHED_OTHER
pid 647's current scheduling priority: 0
pid 655's current scheduling policy: SCHED_OTHER
pid 655's current scheduling priority: 0
pid 678's current scheduling policy: SCHED_OTHER
pid 678's current scheduling priority: 0
pid 693's current scheduling policy: SCHED_OTHER
pid 693's current scheduling priority: 0
pid 831's current scheduling policy: SCHED_OTHER
pid 831's current scheduling priority: 0
pid 835's current scheduling policy: SCHED_FIFO  <-- soundcard irq
pid 835's current scheduling priority: 90

Here is the dmesg output.  It looks like the problem could be related to
jackd's printing from the realtime thread.  But, this has to be the
kernel's fault on some level, because with an earlier version I get no
xruns.

jackd:1726 userspace BUG: scheduling in user-atomic context!
 [<c01069fc>] dump_stack+0x1c/0x20 (20)
 [<c0283e60>] schedule+0x70/0x100 (24)
 [<c010639b>] work_resched+0x6/0x17 (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c012e833>] .... print_traces+0x13/0x50
.....[<c01069fc>] ..   ( <= dump_stack+0x1c/0x20)

jackd:1726 userspace BUG: scheduling in user-atomic context!
 [<c01069fc>] dump_stack+0x1c/0x20 (20)
 [<c0283e60>] schedule+0x70/0x100 (24)
 [<c0284e2c>] _down_write+0xcc/0x170 (32)
 [<c0113413>] lock_kernel+0x23/0x30 (16)
 [<c01f2570>] tty_write+0x170/0x230 (64)
 [<c01548ec>] vfs_write+0xbc/0x110 (36)
 [<c01549f1>] sys_write+0x41/0x70 (44)
 [<c0106367>] syscall_call+0x7/0xb (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c012e833>] .... print_traces+0x13/0x50
.....[<c01069fc>] ..   ( <= dump_stack+0x1c/0x20)

jackd:1726 userspace BUG: scheduling in user-atomic context!
 [<c01069fc>] dump_stack+0x1c/0x20 (20)
 [<c0283e60>] schedule+0x70/0x100 (24)
 [<c0119efa>] do_exit+0x29a/0x500 (24)
 [<c011a196>] sys_exit+0x16/0x20 (12)
 [<c0106367>] syscall_call+0x7/0xb (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c012e833>] .... print_traces+0x13/0x50
.....[<c01069fc>] ..   ( <= dump_stack+0x1c/0x20)

jackd:1731 userspace BUG: scheduling in user-atomic context!
 [<c01069fc>] dump_stack+0x1c/0x20 (20)
 [<c0283e60>] schedule+0x70/0x100 (24)
 [<c0119efa>] do_exit+0x29a/0x500 (24)
 [<c011a196>] sys_exit+0x16/0x20 (12)
 [<c0106367>] syscall_call+0x7/0xb (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c012e833>] .... print_traces+0x13/0x50
.....[<c01069fc>] ..   ( <= dump_stack+0x1c/0x20)

jackd:1736 userspace BUG: scheduling in user-atomic context!
 [<c01069fc>] dump_stack+0x1c/0x20 (20)
 [<c0283e60>] schedule+0x70/0x100 (24)
 [<c0119efa>] do_exit+0x29a/0x500 (24)
 [<c011a196>] sys_exit+0x16/0x20 (12)
 [<c0106367>] syscall_call+0x7/0xb (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c012e833>] .... print_traces+0x13/0x50
.....[<c01069fc>] ..   ( <= dump_stack+0x1c/0x20)

jackd:1775 userspace BUG: scheduling in user-atomic context!
 [<c01069fc>] dump_stack+0x1c/0x20 (20)
 [<c0283e60>] schedule+0x70/0x100 (24)
 [<c0119efa>] do_exit+0x29a/0x500 (24)
 [<c011a196>] (ksoftirqd/0/2/CPU#0): new 12 us maximum-latency wakeup.
(ksoftirqd/0/2/CPU#0): new 15 us maximum-latency wakeup.
(ksoftirqd/0/2/CPU#0): new 22 us maximum-latency wakeup.
(ksoftirqd/0/2/CPU#0): new 31 us maximum-latency wakeup.
(ksoftirqd/0/2/CPU#0): new 32 us maximum-latency wakeup.
(IRQ 1/693/CPU#0): new 39 us maximum-latency wakeup.
jackd:1787 userspace BUG: scheduling in user-atomic context!
 [<c01069fc>] dump_stack+0x1c/0x20 (20)
 [<c0283e60>] schedule+0x70/0x100 (24)
 [<c0119efa>] do_exit+0x29a/0x500 (24)
 [<c011a196>] sys_exit+0x16/0x20 (12)
 [<c0106367>] syscall_call+0x7/0xb (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c012e833>] .... print_traces+0x13/0x50
.....[<c01069fc>] ..   ( <= dump_stack+0x1c/0x20)

(ksoftirqd/0/2/CPU#0): new 42 us maximum-latency wakeup.
(desched/0/3/CPU#0): new 43 us maximum-latency wakeup.
(IRQ 15/678/CPU#0): new 44 us maximum-latency wakeup.
(IRQ 11/831/CPU#0): new 45 us maximum-latency wakeup.
(IRQ 11/831/CPU#0): new 52 us maximum-latency wakeup.
(IRQ 11/831/CPU#0): new 55 us maximum-latency wakeup.
jackd:1846 userspace BUG: scheduling in user-atomic context!
 [<c01069fc>] dump_stack+0x1c/0x20 (20)
 [<c0283e60>] schedule+0x70/0x100 (24)
 [<c0284acb>] schedule_timeout+0xbb/0xc0 (80)
 [<c012f11f>] futex_wait+0x10f/0x190 (168)
 [<c012f406>] do_futex+0x36/0x80 (32)
 [<c012f51a>] sys_futex+0xca/0xe0 (68)
 [<c0106367>] syscall_call+0x7/0xb (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c012e833>] .... print_traces+0x13/0x50
.....[<c01069fc>] ..   ( <= dump_stack+0x1c/0x20)

jackd:1846 userspace BUG: scheduling in user-atomic context!
 [<c01069fc>] dump_stack+0x1c/0x20 (20)
 [<c0283e60>] schedule+0x70/0x100 (24)
 [<c0119efa>] do_exit+0x29a/0x500 (24)
 [<c011a196>] sys_exit+0x16/0x20 (12)
 [<c0106367>] syscall_call+0x7/0xb (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c012e833>] .... print_traces+0x13/0x50
.....[<c01069fc>] ..   ( <= dump_stack+0x1c/0x20)

jackd:1854 userspace BUG: scheduling in user-atomic context!
 [<c01069fc>] dump_stack+0x1c/0x20 (20)
 [<c0283e60>] schedule+0x70/0x100 (24)
 [<c0119efa>] do_exit+0x29a/0x500 (24)
 [<c011a196>] sys_exit+0x16/0x20 (12)
 [<c0106367>] syscall_call+0x7/0xb (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c012e833>] .... print_traces+0x13/0x50
.....[<c01069fc>] ..   ( <= dump_stack+0x1c/0x20)

Lee



