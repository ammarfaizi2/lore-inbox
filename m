Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263549AbUJ2W3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263549AbUJ2W3u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbUJ2W0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:26:08 -0400
Received: from mail.gmx.de ([213.165.64.20]:48787 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261446AbUJ2WOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 18:14:16 -0400
X-Authenticated: #4399952
Date: Sat, 30 Oct 2004 00:31:22 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041030003122.03bcf01b@mango.fruits.de>
In-Reply-To: <20041029212545.GA13199@elte.hu>
References: <20041029163155.GA9005@elte.hu>
	<20041029191652.1e480e2d@mango.fruits.de>
	<20041029170237.GA12374@elte.hu>
	<20041029170948.GA13727@elte.hu>
	<20041029193303.7d3990b4@mango.fruits.de>
	<20041029172151.GB16276@elte.hu>
	<20041029172243.GA19630@elte.hu>
	<20041029203619.37b54cba@mango.fruits.de>
	<20041029204220.GA6727@elte.hu>
	<20041029233117.6d29c383@mango.fruits.de>
	<20041029212545.GA13199@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004 23:25:45 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> > will do so. btw: i think i'm a bit confused right now. What debugging
> > features should i have enabled for this test?
> 
> this particular one (atomicity-checking) is always-enabled if you have
> the -RT patch applied (it's a really cheap check).
> 
> for the 'application-triggered tracing' facility we talked about earlier
> is only active if LATENCY_TRACING is enabled. In that case to turn the 
> tracer on, call:
[snip]

Ok,

.config attached,

running the patched jackd -R -P 60 -d alsa -p64 for a bit and provoking
xruns via window wiggling :)

mango:~# cat /proc/sys/kernel/trace_enabled 
2
mango:~# cat /proc/sys/kernel/preempt_max_latency 
75
mango:~# cat /proc/sys/kernel/preempt_thresh      
0

mango:~# cat /proc/latency_trace 
preemption latency trace v1.0.7 on 2.6.9-mm1-RT-V0.5.14-rt
-------------------------------------------------------
 latency: 75 us, entries: 54 (54)   |   [VP:0 KP:1 SP:1 HP:1 #CPUS:1]
    -----------------
    | task: jackd/1083, uid:1000 nice:0 policy:1 rt_prio:60
    -----------------
 => started at: try_to_wake_up+0x5a/0x110 <c01151ca>
 => ended at:   finish_task_switch+0x31/0xc0 <c0115691>
=======>
  834 80000000 0.000ms (+0.000ms): (39) ((115))
  834 80000000 0.000ms (+0.000ms): (1083) ((834))
  834 80000000 0.000ms (+0.000ms): preempt_schedule (try_to_wake_up)
  834 80000000 0.000ms (+0.000ms): preempt_schedule (__up_write)
  834 00000000 0.000ms (+0.000ms): preempt_schedule (up_write_mutex)
  834 80000000 0.000ms (+0.000ms): __schedule (preempt_schedule)
  834 80000000 0.000ms (+0.000ms): profile_hit (__schedule)
  834 80000000 0.000ms (+0.000ms): sched_clock (__schedule)
 1083 80000000 0.001ms (+0.000ms): __switch_to (__schedule)
 1083 80000000 0.001ms (+0.000ms): (834) ((1083))
 1083 80000000 0.001ms (+0.000ms): (115) ((39))
 1083 80000000 0.002ms (+0.000ms): finish_task_switch (__schedule)
 1083 80000000 0.002ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
 1083 80000000 0.002ms (+0.000ms): (1083) ((39))
 1083 00000000 0.003ms (+0.000ms): _mutex_unlock (kfree)
 1083 00000000 0.003ms (+0.000ms): up_mutex (kfree)
 1083 00000000 0.003ms (+0.000ms): up_write_mutex (kfree)
 1083 00000000 0.003ms (+0.000ms): __up_write (up_write_mutex)
 1083 00000000 0.003ms (+0.000ms): poll_freewait (sys_poll)
 1083 00000000 0.003ms (+0.000ms): remove_wait_queue (poll_freewait)
 1083 00000000 0.003ms (+0.000ms): _mutex_lock_irqsave (remove_wait_queue)
 1083 00000000 0.003ms (+0.000ms): __mutex_lock (_mutex_lock_irqsave)
 1083 00000000 0.003ms (+0.000ms): __might_sleep (__mutex_lock)
 1083 00000000 0.004ms (+0.000ms): down_mutex (__mutex_lock)
 1083 00000000 0.004ms (+0.000ms): down_write_mutex (__mutex_lock)
 1083 00000000 0.004ms (+0.000ms): __might_sleep (down_write_mutex)
 1083 00000000 0.004ms (+0.000ms): _mutex_unlock_irqrestore (remove_wait_queue)
 1083 00000000 0.004ms (+0.000ms): up_mutex (remove_wait_queue)
 1083 00000000 0.004ms (+0.000ms): up_write_mutex (remove_wait_queue)
 1083 00000000 0.004ms (+0.000ms): __up_write (up_write_mutex)
 1083 00000000 0.004ms (+0.000ms): fput (poll_freewait)
 1083 00000000 0.005ms (+0.000ms): free_pages (poll_freewait)
 1083 00000000 0.005ms (+0.000ms): __free_pages (poll_freewait)
 1083 00000000 0.005ms (+0.000ms): free_hot_page (poll_freewait)
 1083 00000000 0.006ms (+0.000ms): __free_pages_ok (free_hot_page)
 1083 00000000 0.006ms (+0.000ms): free_pages_bulk (__free_pages_ok)
 1083 00000000 0.006ms (+0.000ms): _mutex_lock_irqsave (free_pages_bulk)
 1083 00000000 0.006ms (+0.000ms): __mutex_lock (_mutex_lock_irqsave)
 1083 00000000 0.007ms (+0.000ms): __might_sleep (__mutex_lock)
 1083 00000000 0.007ms (+0.000ms): down_mutex (__mutex_lock)
 1083 00000000 0.007ms (+0.000ms): down_write_mutex (__mutex_lock)
 1083 00000000 0.007ms (+0.000ms): __might_sleep (down_write_mutex)
 1083 00000000 0.007ms (+0.000ms): bad_range (free_pages_bulk)
 1083 00000000 0.007ms (+0.000ms): bad_range (free_pages_bulk)
 1083 00000000 0.008ms (+0.000ms): _mutex_unlock_irqrestore (free_pages_bulk)
 1083 00000000 0.008ms (+0.000ms): up_mutex (free_pages_bulk)
 1083 00000000 0.008ms (+0.000ms): up_write_mutex (free_pages_bulk)
 1083 00000000 0.008ms (+0.004ms): __up_write (up_write_mutex)
 1083 00000000 0.013ms (+0.000ms): sys_gettimeofday (syscall_call)
 1083 00000000 0.013ms (+0.000ms): user_trace_stop (sys_gettimeofday)
 1083 80000000 0.013ms (+0.000ms): user_trace_stop (sys_gettimeofday)
 1083 80000000 0.013ms (+0.000ms): update_max_trace (user_trace_stop)
 1083 80000000 0.014ms (+0.000ms): _mmx_memcpy (update_max_trace)
 1083 80000000 0.014ms (+0.000ms): kernel_fpu_begin (_mmx_memcpy)



mango:~# chrt -p `pidof "IRQ 3"`
pid 118's current scheduling policy: SCHED_FIFO
pid 118's current scheduling priority: 99

mango:~# ps aux|grep jackd
tapas     1080  4.2  3.6 28244 28220 pts/1   SLl+ 00:22   0:18 jackd -R -P 60 -d alsa -p 64
mango:~# chrt -p 1080
pid 1080's current scheduling policy: SCHED_OTHER
pid 1080's current scheduling priority: 0
mango:~# chrt -p 1081
pid 1081's current scheduling policy: SCHED_OTHER
pid 1081's current scheduling priority: 0
mango:~# chrt -p 1082
pid 1082's current scheduling policy: SCHED_FIFO
pid 1082's current scheduling priority: 70
mango:~# chrt -p 1083
pid 1083's current scheduling policy: SCHED_FIFO
pid 1083's current scheduling priority: 60


and here's some syslog stuff:

Oct 30 00:20:32 mango kernel: Realtime LSM initialized (group 1002, mlock=1)
Oct 30 00:20:35 mango kernel: IRQ#3 thread RT prio: 43.
Oct 30 00:20:38 mango kernel: jackd:1019 userspace BUG: scheduling in user-atomic context!
Oct 30 00:20:38 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:20:38 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:20:38 mango kernel:  [irq_entries_start+43/128] work_resched+0x6/0x17 (-8124)
Oct 30 00:20:38 mango kernel: ---------------------------
Oct 30 00:20:38 mango kernel: | preempt count: 00000001 ]
Oct 30 00:20:38 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:20:38 mango kernel: ----------------------------------------
Oct 30 00:20:38 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:20:38 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:20:38 mango kernel: 
Oct 30 00:20:47 mango kernel: jackd:1019 userspace BUG: scheduling in user-atomic context!
Oct 30 00:20:47 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:20:47 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:20:47 mango kernel:  [irq_entries_start+43/128] work_resched+0x6/0x17 (-8124)
Oct 30 00:20:47 mango kernel: ---------------------------
Oct 30 00:20:47 mango kernel: | preempt count: 00000001 ]
Oct 30 00:20:47 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:20:47 mango kernel: ----------------------------------------
Oct 30 00:20:47 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:20:47 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:20:47 mango kernel: 
Oct 30 00:20:51 mango kernel: (IRQ 3/118/CPU#0): new 4 us maximum-latency wakeup.
Oct 30 00:20:51 mango kernel: (bash/867/CPU#0): new 6 us maximum-latency wakeup.
Oct 30 00:20:52 mango kernel: (bash/1035/CPU#0): new 7 us maximum-latency wakeup.
Oct 30 00:20:52 mango kernel: (ksoftirqd/0/2/CPU#0): new 8 us maximum-latency wakeup.
Oct 30 00:20:52 mango kernel: (ksoftirqd/0/2/CPU#0): new 13 us maximum-latency wakeup.
Oct 30 00:21:11 mango kernel: jackd:1019 userspace BUG: scheduling in user-atomic context!
Oct 30 00:21:11 mango kernel: (IRQ 12/15/CPU#0): new 19 us maximum-latency wakeup.
Oct 30 00:21:11 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:21:11 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:21:11 mango kernel:  [irq_entries_start+43/128] work_resched+0x6/0x17 (-8124)
Oct 30 00:21:11 mango kernel: ---------------------------
Oct 30 00:21:11 mango kernel: | preempt count: 00000001 ]
Oct 30 00:21:11 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:21:11 mango kernel: ----------------------------------------
Oct 30 00:21:11 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:21:11 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:21:11 mango kernel: 
Oct 30 00:21:11 mango kernel: (IRQ 12/15/CPU#0): new 75 us maximum-latency wakeup.
Oct 30 00:21:11 mango kernel: jackd:1019 userspace BUG: scheduling in user-atomic context!
Oct 30 00:21:11 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:21:11 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:21:11 mango kernel:  [irq_entries_start+43/128] work_resched+0x6/0x17 (-8124)
Oct 30 00:21:11 mango kernel: ---------------------------
Oct 30 00:21:11 mango kernel: | preempt count: 00000001 ]
Oct 30 00:21:11 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:21:11 mango kernel: ----------------------------------------
Oct 30 00:21:11 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:21:11 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:21:11 mango kernel: 
Oct 30 00:21:11 mango kernel: jackd:1019 userspace BUG: scheduling in user-atomic context!
Oct 30 00:21:11 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:21:11 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:21:11 mango kernel:  [irq_entries_start+43/128] work_resched+0x6/0x17 (-8124)
Oct 30 00:21:11 mango kernel: ---------------------------
Oct 30 00:21:11 mango kernel: | preempt count: 00000001 ]
Oct 30 00:21:11 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:21:11 mango kernel: ----------------------------------------
Oct 30 00:21:11 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:21:11 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:21:11 mango kernel: 
Oct 30 00:21:11 mango kernel: jackd:1019 userspace BUG: scheduling in user-atomic context!
Oct 30 00:21:11 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:21:11 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:21:11 mango kernel:  [irq_entries_start+43/128] work_resched+0x6/0x17 (-8124)
Oct 30 00:21:11 mango kernel: ---------------------------
Oct 30 00:21:11 mango kernel: | preempt count: 00000001 ]
Oct 30 00:21:11 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:21:11 mango kernel: ----------------------------------------
Oct 30 00:21:11 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:21:11 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:21:11 mango kernel: 
Oct 30 00:21:11 mango kernel: jackd:1019 userspace BUG: scheduling in user-atomic context!
Oct 30 00:21:11 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:21:11 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:21:11 mango kernel:  [irq_entries_start+43/128] work_resched+0x6/0x17 (-8124)
Oct 30 00:21:11 mango kernel: ---------------------------
Oct 30 00:21:11 mango kernel: | preempt count: 00000001 ]
Oct 30 00:21:11 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:21:11 mango kernel: ----------------------------------------
Oct 30 00:21:11 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:21:11 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:21:11 mango kernel: 
Oct 30 00:21:11 mango kernel: jackd:1019 userspace BUG: scheduling in user-atomic context!
Oct 30 00:21:11 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:21:11 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:21:11 mango kernel:  [irq_entries_start+43/128] work_resched+0x6/0x17 (-8124)
Oct 30 00:21:11 mango kernel: ---------------------------
Oct 30 00:21:11 mango kernel: | preempt count: 00000001 ]
Oct 30 00:21:11 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:21:11 mango kernel: ----------------------------------------
Oct 30 00:21:11 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:21:11 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:21:11 mango kernel: 
Oct 30 00:21:12 mango kernel: jackd:1019 userspace BUG: scheduling in user-atomic context!
Oct 30 00:21:12 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:21:12 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:21:12 mango kernel:  [irq_entries_start+43/128] work_resched+0x6/0x17 (-8124)
Oct 30 00:21:12 mango kernel: ---------------------------
Oct 30 00:21:12 mango kernel: | preempt count: 00000001 ]
Oct 30 00:21:12 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:21:12 mango kernel: ----------------------------------------
Oct 30 00:21:12 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:21:12 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:21:12 mango kernel: 
Oct 30 00:21:13 mango kernel: jackd:1019 userspace BUG: scheduling in user-atomic context!
Oct 30 00:21:13 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:21:13 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:21:13 mango kernel:  [irq_entries_start+43/128] work_resched+0x6/0x17 (-8124)
Oct 30 00:21:13 mango kernel: ---------------------------
Oct 30 00:21:13 mango kernel: | preempt count: 00000001 ]
Oct 30 00:21:13 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:21:13 mango kernel: ----------------------------------------
Oct 30 00:21:13 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:21:13 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:21:13 mango kernel: 
Oct 30 00:21:31 mango kernel: jackd:1019 userspace BUG: scheduling in user-atomic context!
Oct 30 00:21:31 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:21:31 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:21:31 mango kernel:  [irq_entries_start+43/128] work_resched+0x6/0x17 (-8124)
Oct 30 00:21:31 mango kernel: ---------------------------
Oct 30 00:21:31 mango kernel: | preempt count: 00000001 ]
Oct 30 00:21:31 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:21:31 mango kernel: ----------------------------------------
Oct 30 00:21:31 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:21:31 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:21:31 mango kernel: 
Oct 30 00:21:32 mango kernel: jackd:1019 userspace BUG: scheduling in user-atomic context!
Oct 30 00:21:32 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:21:32 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:21:32 mango kernel:  [irq_entries_start+43/128] work_resched+0x6/0x17 (-8124)
Oct 30 00:21:32 mango kernel: ---------------------------
Oct 30 00:21:32 mango kernel: | preempt count: 00000001 ]
Oct 30 00:21:32 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:21:32 mango kernel: ----------------------------------------
Oct 30 00:21:32 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:21:32 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:21:32 mango kernel: 
Oct 30 00:21:32 mango kernel: jackd:1019 userspace BUG: scheduling in user-atomic context!
Oct 30 00:21:32 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:21:32 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:21:32 mango kernel:  [irq_entries_start+43/128] work_resched+0x6/0x17 (-8124)
Oct 30 00:21:32 mango kernel: ---------------------------
Oct 30 00:21:32 mango kernel: | preempt count: 00000001 ]
Oct 30 00:21:32 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:21:32 mango kernel: ----------------------------------------
Oct 30 00:21:32 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:21:32 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:21:32 mango kernel: 
Oct 30 00:21:32 mango kernel: jackd:1019 userspace BUG: scheduling in user-atomic context!
Oct 30 00:21:32 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:21:32 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:21:32 mango kernel:  [irq_entries_start+43/128] work_resched+0x6/0x17 (-8124)
Oct 30 00:21:32 mango kernel: ---------------------------
Oct 30 00:21:32 mango kernel: | preempt count: 00000001 ]
Oct 30 00:21:32 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:21:32 mango kernel: ----------------------------------------
Oct 30 00:21:32 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:21:32 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:21:32 mango kernel: 
Oct 30 00:21:34 mango kernel: jackd:1019 userspace BUG: scheduling in user-atomic context!
Oct 30 00:21:34 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:21:34 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:21:34 mango kernel:  [irq_entries_start+43/128] work_resched+0x6/0x17 (-8124)
Oct 30 00:21:34 mango kernel: ---------------------------
Oct 30 00:21:34 mango kernel: | preempt count: 00000001 ]
Oct 30 00:21:34 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:21:34 mango kernel: ----------------------------------------
Oct 30 00:21:34 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:21:34 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:21:34 mango kernel: 
Oct 30 00:21:35 mango kernel: jackd:1019 userspace BUG: scheduling in user-atomic context!
Oct 30 00:21:35 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:21:35 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:21:35 mango kernel:  [irq_entries_start+43/128] work_resched+0x6/0x17 (-8124)
Oct 30 00:21:35 mango kernel: ---------------------------
Oct 30 00:21:35 mango kernel: | preempt count: 00000001 ]
Oct 30 00:21:35 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:21:35 mango kernel: ----------------------------------------
Oct 30 00:21:35 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:21:35 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:21:35 mango kernel: 
Oct 30 00:21:37 mango kernel: jackd:1019 userspace BUG: scheduling in user-atomic context!
Oct 30 00:21:37 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:21:37 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:21:37 mango kernel:  [irq_entries_start+43/128] work_resched+0x6/0x17 (-8124)
Oct 30 00:21:37 mango kernel: ---------------------------
Oct 30 00:21:37 mango kernel: | preempt count: 00000001 ]
Oct 30 00:21:37 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:21:37 mango kernel: ----------------------------------------
Oct 30 00:21:37 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:21:37 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:21:37 mango kernel: 
Oct 30 00:22:09 mango kernel: jackd:1019 userspace BUG: scheduling in user-atomic context!
Oct 30 00:22:09 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:22:09 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:22:09 mango kernel:  [irq_entries_start+43/128] work_resched+0x6/0x17 (-8124)
Oct 30 00:22:09 mango kernel: ---------------------------
Oct 30 00:22:09 mango kernel: | preempt count: 00000001 ]
Oct 30 00:22:09 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:22:09 mango kernel: ----------------------------------------
Oct 30 00:22:09 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:22:09 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:22:09 mango kernel: 
Oct 30 00:22:10 mango kernel: jackd:1019 userspace BUG: scheduling in user-atomic context!
Oct 30 00:22:10 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:22:10 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:22:10 mango kernel:  [kernel_config_data+5091/6569] io_schedule+0x13/0x20 (8)
Oct 30 00:22:10 mango kernel:  [do_hardirq+104/304] sync_page+0x38/0x50 (12)
Oct 30 00:22:10 mango kernel:  [kernel_config_data+5981/6569] __wait_on_bit_lock+0x5d/0x70 (32)
Oct 30 00:22:10 mango kernel:  [init_irq_proc+137/176] __lock_page+0x89/0xa0 (92)
Oct 30 00:22:10 mango kernel:  [__generic_file_aio_read+402/544] filemap_nopage+0x2b2/0x3e0 (60)
Oct 30 00:22:10 mango kernel:  [do_no_page+74/848] do_no_page+0xba/0x390 (68)
Oct 30 00:22:10 mango kernel:  [handle_mm_fault+207/416] handle_mm_fault+0xef/0x180 (48)
Oct 30 00:22:10 mango kernel:  [get_user_pages+169/912] get_user_pages+0x139/0x380 (60)
Oct 30 00:22:10 mango kernel:  [make_pages_present+108/192] make_pages_present+0x9c/0x110 (56)
Oct 30 00:22:10 mango kernel:  [do_mmap_pgoff+699/1808] do_mmap_pgoff+0x47b/0x700 (88)
Oct 30 00:22:10 mango kernel:  [old_mmap+149/304] old_mmap+0xc5/0xf0 (96)
Oct 30 00:22:10 mango kernel:  [irq_entries_start+3/128] syscall_call+0x7/0xb (-8124)
Oct 30 00:22:10 mango kernel: ---------------------------
Oct 30 00:22:10 mango kernel: | preempt count: 00000001 ]
Oct 30 00:22:10 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:22:10 mango kernel: ----------------------------------------
Oct 30 00:22:10 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:22:10 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:22:10 mango kernel: 
Oct 30 00:24:40 mango kernel: jackd:1083 userspace BUG: scheduling in user-atomic context!
Oct 30 00:24:40 mango kernel:  [show_registers+99/464] dump_stack+0x23/0x30 (20)
Oct 30 00:24:40 mango kernel:  [kernel_config_data+2090/6569] schedule+0x7a/0x120 (36)
Oct 30 00:24:40 mango kernel:  [irq_entries_start+43/128] work_resched+0x6/0x17 (-8124)
Oct 30 00:24:40 mango kernel: ---------------------------
Oct 30 00:24:40 mango kernel: | preempt count: 00000001 ]
Oct 30 00:24:40 mango kernel: | 1-level deep critical section nesting:
Oct 30 00:24:40 mango kernel: ----------------------------------------
Oct 30 00:24:40 mango kernel: .. [l_show+173/272] .... print_traces+0x1d/0x90
Oct 30 00:24:40 mango kernel: .....[show_registers+99/464] ..   ( <= dump_stack+0x23/0x30)
Oct 30 00:24:40 mango kernel: 
Oct 30 00:28:29 mango kernel: (IRQ 3/118/CPU#0): new 205 us maximum-latency wakeup.
