Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263467AbUJ3DhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbUJ3DhO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 23:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbUJ3DhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 23:37:14 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3006 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263467AbUJ3DgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 23:36:08 -0400
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20041030003122.03bcf01b@mango.fruits.de>
References: <20041029163155.GA9005@elte.hu>
	 <20041029191652.1e480e2d@mango.fruits.de> <20041029170237.GA12374@elte.hu>
	 <20041029170948.GA13727@elte.hu> <20041029193303.7d3990b4@mango.fruits.de>
	 <20041029172151.GB16276@elte.hu> <20041029172243.GA19630@elte.hu>
	 <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu>
	 <20041029233117.6d29c383@mango.fruits.de> <20041029212545.GA13199@elte.hu>
	 <20041030003122.03bcf01b@mango.fruits.de>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 23:36:03 -0400
Message-Id: <1099107364.1551.7.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-30 at 00:31 +0200, Florian Schmidt wrote:
> On Fri, 29 Oct 2004 23:25:45 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > will do so. btw: i think i'm a bit confused right now. What debugging
> > > features should i have enabled for this test?
> > 
> > this particular one (atomicity-checking) is always-enabled if you have
> > the -RT patch applied (it's a really cheap check).
> > 
> > for the 'application-triggered tracing' facility we talked about earlier
> > is only active if LATENCY_TRACING is enabled. In that case to turn the 
> > tracer on, call:
> [snip]
> 
> Ok,
> 
> .config attached,
> 
> running the patched jackd -R -P 60 -d alsa -p64 for a bit and provoking
> xruns via window wiggling :)
> 

Ingo, here are some of my traces with the same settings.  These do seem
to correspond to the xruns.  Many of them look tty related - could the
recent changes to the tty layer be responsible?  Possibly this has
nothing to do with RT preempt, but is an unrelated bug in -mm?  The
xruns do seem to correspond to display activity such as switching tabs
in gnome-terminal. 

jackd:1507 userspace BUG: scheduling in user-atomic context!
 [<c01069fc>] dump_stack+0x1c/0x20 (20)
 [<c02834d0>] schedule+0x70/0x100 (24)
 [<c010639b>] work_resched+0x6/0x17 (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c012e5d3>] .... print_traces+0x13/0x50
.....[<c01069fc>] ..   ( <= dump_stack+0x1c/0x20)

jackd:1507 userspace BUG: scheduling in user-atomic context!
 [<c01069fc>] dump_stack+0x1c/0x20 (20)
 [<c02834d0>] schedule+0x70/0x100 (24)
 [<c028465d>] down_write_mutex+0xbd/0x180 (36)
 [<c012cbf6>] __mutex_lock+0x36/0x40 (16)
 [<c012cc75>] _mutex_lock_irqsave+0x15/0x20 (16)
 [<c01f1237>] tty_ldisc_try+0x17/0x50 (20)
 [<c01f1287>] tty_ldisc_ref_wait+0x17/0xc0 (88)
 [<c01f21fd>] tty_write+0x7d/0x230 (68)
 [<c01546ac>] vfs_write+0xbc/0x110 (36)
 [<c01547b1>] sys_write+0x41/0x70 (44)
 [<c0106367>] syscall_call+0x7/0xb (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c012e5d3>] .... print_traces+0x13/0x50
.....[<c01069fc>] ..   ( <= dump_stack+0x1c/0x20)

jackd:1507 userspace BUG: scheduling in user-atomic context!
 [<c01069fc>] dump_stack+0x1c/0x20 (20)
 [<c02834d0>] schedule+0x70/0x100 (24)
 [<c010639b>] work_resched+0x6/0x17 (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c012e5d3>] .... print_traces+0x13/0x50
.....[<c01069fc>] ..   ( <= dump_stack+0x1c/0x20)

jackd:1507 userspace BUG: scheduling in user-atomic context!
 [<c01069fc>] dump_stack+0x1c/0x20 (20)
 [<c02834d0>] schedule+0x70/0x100 (24)
 [<c028465d>] down_write_mutex+0xbd/0x180 (36)
 [<c012cbf6>] __mutex_lock+0x36/0x40 (16)
 [<c012cc75>] _mutex_lock_irqsave+0x15/0x20 (16)
 [<c01f1237>] tty_ldisc_try+0x17/0x50 (20)
 [<c01f1287>] tty_ldisc_ref_wait+0x17/0xc0 (88)
 [<c01f21fd>] tty_write+0x7d/0x230 (68)
 [<c01546ac>] vfs_write+0xbc/0x110 (36)
 [<c01547b1>] sys_write+0x41/0x70 (44)
 [<c0106367>] syscall_call+0x7/0xb (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c012e5d3>] .... print_traces+0x13/0x50
.....[<c01069fc>] ..   ( <= dump_stack+0x1c/0x20)

jackd:1507 userspace BUG: scheduling in user-atomic context!
 [<c01069fc>] dump_stack+0x1c/0x20 (20)
 [<c02834d0>] schedule+0x70/0x100 (24)
 [<c028449c>] _down_write+0xcc/0x170 (32)
 [<c01131d3>] lock_kernel+0x23/0x30 (16)
 [<c01f22f0>] tty_write+0x170/0x230 (64)
 [<c01546ac>] vfs_write+0xbc/0x110 (36)
 [<c01547b1>] sys_write+0x41/0x70 (44)
 [<c0106367>] syscall_call+0x7/0xb (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c012e5d3>] .... print_traces+0x13/0x50
.....[<c01069fc>] ..   ( <= dump_stack+0x1c/0x20)

jackd:1507 userspace BUG: scheduling in user-atomic context!
 [<c01069fc>] dump_stack+0x1c/0x20 (20)
 [<c02834d0>] schedule+0x70/0x100 (24)
 [<c0119cba>] do_exit+0x29a/0x500 (24)
 [<c0119f56>] sys_exit+0x16/0x20 (12)
 [<c0106367>] syscall_call+0x7/0xb (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c012e5d3>] .... print_traces+0x13/0x50
.....[<c01069fc>] ..   ( <= dump_stack+0x1c/0x20)


However the longest latency recorded during all these xruns is 40-150 usecs:


preemption latency trace v1.0.7 on 2.6.9-mm1-RT-V0.5.14
-------------------------------------------------------
 latency: 48 us, entries: 26 (26)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: jackd/1629, uid:1000 nice:0 policy:1 rt_prio:10
    -----------------
 => started at: try_to_wake_up+0x4c/0x100 <c01126ec>
 => ended at:   finish_task_switch+0x27/0xb0 <c0112b77>
=======>
 1101 80000000 0.000ms (+0.000ms): (89) ((116))
 1101 80000000 0.000ms (+0.000ms): (1629) ((1101))
 1101 80000000 0.000ms (+0.000ms): preempt_schedule (try_to_wake_up)
 1101 80000000 0.001ms (+0.000ms): preempt_schedule (__up_write)
 1101 00000000 0.001ms (+0.000ms): preempt_schedule (up_write_mutex)
 1101 80000000 0.002ms (+0.000ms): __schedule (preempt_schedule)
 1101 80000000 0.002ms (+0.000ms): profile_hit (__schedule)
 1101 80000000 0.003ms (+0.002ms): sched_clock (__schedule)
 1629 80000000 0.005ms (+0.000ms): __switch_to (__schedule)
 1629 80000000 0.006ms (+0.000ms): (1101) ((1629))
 1629 80000000 0.006ms (+0.000ms): (116) ((89))
 1629 80000000 0.006ms (+0.000ms): finish_task_switch (__schedule)
 1629 80000000 0.007ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
 1629 80000000 0.007ms (+0.002ms): (1629) ((89))
 1629 00000000 0.010ms (+0.000ms): bad_range (free_pages_bulk)
 1629 00000000 0.010ms (+0.000ms): bad_range (free_pages_bulk)
 1629 00000000 0.011ms (+0.000ms): _mutex_unlock_irqrestore (free_pages_bulk)
 1629 00000000 0.011ms (+0.000ms): up_mutex (free_pages_bulk)
 1629 00000000 0.011ms (+0.000ms): up_write_mutex (free_pages_bulk)
 1629 00000000 0.012ms (+0.004ms): __up_write (up_write_mutex)
 1629 00000000 0.016ms (+0.000ms): sys_gettimeofday (syscall_call)
 1629 00000000 0.016ms (+0.000ms): user_trace_stop (sys_gettimeofday)
 1629 80000000 0.017ms (+0.000ms): user_trace_stop (sys_gettimeofday)
 1629 80000000 0.017ms (+0.000ms): update_max_trace (user_trace_stop)
 1629 80000000 0.018ms (+0.000ms): _mmx_memcpy (update_max_trace)
 1629 80000000 0.018ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)

We know that jackd prints from the realtime thread, and that in theory
this could be a problem, in practice it works OK.  Maybe some recent
changes to the tty layer made this problematic.

I think there was a patch posted to the JACK mailing list to print from
a separate thread, I will look into this.

Lee  


