Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVFQTbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVFQTbn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 15:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVFQTbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 15:31:43 -0400
Received: from unused.mind.net ([69.9.134.98]:21473 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262072AbVFQTaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 15:30:55 -0400
Date: Fri, 17 Jun 2005 12:28:24 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-Reply-To: <20050616173247.GA32552@elte.hu>
Message-ID: <Pine.LNX.4.58.0506171139570.32721@echo.lysdexia.org>
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com>
 <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com>
 <20050616173247.GA32552@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

My Xeon/HT box running -48-33 locked up after being up for three days.
This is better uptime than I've seen on this box since -47-19.

CONFIG_DETECT_SOFTLOCKUP and CONFIG_RT_DEADLOCK_DETECT are enabled.  
CONFIG_DEBUG_RT_LOCKING_MODE is disabled.

All of the HPET options are enabled.  I noticed your comments about HPET 
in the adeos thread.  Should I disable HPET if I don't have any specific 
need for it?

Fortunately, there were some dumps (all ns83820 tx related) left in the 
logs before the machine locked:

Jun 17 03:21:42 manzanita kernel: eth0: tx_timeout: tx_done_idx=50 free_idx=51 cmdsts=08000042
Jun 17 03:21:42 manzanita kernel: BUG: sleeping function called from invalid context softirq-timer/1 (13) at kernel/rt.c:1658
Jun 17 03:21:42 manzanita kernel: in_atomic():0 [20000000], irqs_disabled():536870912
Jun 17 03:21:42 manzanita kernel:  [<c0103eaa>] dump_stack+0x23/0x25 (20)
Jun 17 03:21:42 manzanita kernel:  [<c011b39a>] __might_sleep+0xde/0xf9 (36)
Jun 17 03:21:42 manzanita kernel:  [<c02fdae5>] _spin_lock_irq+0x3b/0x55 (32)
Jun 17 03:21:42 manzanita kernel:  [<df839291>] do_tx_done+0x24/0x1e2 [ns83820] (48)
Jun 17 03:21:42 manzanita kernel:  [<df839d41>] ns83820_tx_timeout+0x64/0xb1 [ns83820] (40)
Jun 17 03:21:42 manzanita kernel:  [<df839e23>] ns83820_tx_watch+0x95/0xb8 [ns83820] (40)
Jun 17 03:21:42 manzanita kernel:  [<c012856d>] run_timer_softirq+0x1e9/0x406 (64)
Jun 17 03:21:42 manzanita kernel:  [<c0124622>] ksoftirqd+0xe9/0x19d (32)
Jun 17 03:21:42 manzanita kernel:  [<c013436b>] kthread+0xab/0xd3 (48)
Jun 17 03:21:44 manzanita kernel:  [<c0101119>] kernel_thread_helper+0x5/0xb (1052196892)
Jun 17 03:21:44 manzanita kernel: ---------------------------
Jun 17 03:21:44 manzanita kernel: | preempt count: 20000001 ]
Jun 17 03:21:44 manzanita kernel: | 1-level deep critical section nesting:
Jun 17 03:21:44 manzanita kernel: ----------------------------------------
Jun 17 03:21:44 manzanita kernel: .. [<c013d513>] .... print_traces+0x1b/0x52
Jun 17 03:21:44 manzanita kernel: .....[<c0103eaa>] ..   ( <= dump_stack+0x23/0x25)
Jun 17 03:21:44 manzanita kernel: 
Jun 17 03:21:44 manzanita kernel: eth0: after: tx_done_idx=51 free_idx=51 cmdsts=00000000

Three additional dumps like this one follow at 03:21:51, 04:02:06, and 
04:06:26 before the machine locked.

I also regularly see high (>200us) wakeup latencies on the Xeon/HT, which
I don't see on the Athlon or non-HT Xeon systems.  Disabling IRQ balancing
doesn't seem to help.  It's been a while since the Xeon/HT box has seen a 
non-debug kernel, but in the past, that hasn't helped latencies by more 
than a few usec.

preemption latency trace v1.1.4 on 2.6.12-rc6-RT-V0.7.48-33-debug
--------------------------------------------------------------------
 latency: 255 us, #29/29, CPU#0 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:2)
    -----------------
    | task: X-3006 (uid:0 nice:0 policy:0 rt_prio:0)
    -----------------

                 _------=> CPU#            
                / _-----=> irqs-off        
               | / _----=> need-resched    
               || / _---=> hardirq/softirq 
               ||| / _--=> preempt-depth   
               |||| /                      
               |||||     delay             
   cmd     pid ||||| time  |   caller      
      \   /    |||||   \   |   /           
  <idle>-0     0Dnh.    0us : smp_reschedule_interrupt (c0100c8a 0 0)
  <idle>-0     0Dnh.    1us : preempt_schedule_irq (need_resched)
  <idle>-0     0Dnh.    1us : __schedule (preempt_schedule_irq)
  <idle>-0     0Dnh1    2us : sched_clock (__schedule)
  <idle>-0     0Dnh1    2us : _raw_spin_lock_irq (__schedule)
  <idle>-0     0Dnh1    2us : _raw_spin_lock_irqsave (__schedule)
  <idle>-0     0Dnh2    3us : _raw_spin_unlock (__schedule)
  <idle>-0     0Dnh1    3us : preempt_schedule (__schedule)
  <idle>-0     0Dnh1    3us : _raw_spin_lock (__schedule)
  <idle>-0     0Dnh2    4us : find_next_bit (__schedule)
  <idle>-0     0Dnh2    4us : _raw_spin_lock (__schedule)
  <idle>-0     0Dnh3    4us!: find_next_bit (__schedule)
  <idle>-0     0Dnh3  244us : find_next_bit (__schedule)
  <idle>-0     0Dnh3  245us : _raw_spin_unlock (__schedule)
  <idle>-0     0Dnh2  245us : preempt_schedule (__schedule)
  <idle>-0     0Dnh2  246us : find_next_bit (__schedule)
  <idle>-0     0Dnh2  246us : trace_array (__schedule)
  <idle>-0     0Dnh2  248us : trace_array <<...>-3006> (31 78)
  <idle>-0     0Dnh2  249us : trace_array <<...>-3367> (75 78)
  <idle>-0     0Dnh2  250us+: trace_array (__schedule)
   <...>-3006  0Dnh2  252us : __switch_to (__schedule)
   <...>-3006  0Dnh2  253us : __schedule <<idle>-0> (8c 31)
   <...>-3006  0Dnh2  254us : _raw_spin_unlock (__schedule)
   <...>-3006  0Dnh1  254us : trace_stop_sched_switched (__schedule)
   <...>-3006  0Dnh1  254us : trace_stop_sched_switched <<...>-3006> (31 0)
   <...>-3006  0Dnh1  254us : _raw_spin_lock (trace_stop_sched_switched)
   <...>-3006  0Dnh1  255us : trace_stop_sched_switched (__schedule)

preemption latency trace v1.1.4 on 2.6.12-rc6-RT-V0.7.48-33-debug
--------------------------------------------------------------------
 latency: 224 us, #37/37, CPU#1 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:2)
    -----------------
    | task: wmfortune-3144 (uid:500 nice:0 policy:0 rt_prio:0)
    -----------------

                 _------=> CPU#            
                / _-----=> irqs-off        
               | / _----=> need-resched    
               || / _---=> hardirq/softirq 
               ||| / _--=> preempt-depth   
               |||| /                      
               |||||     delay             
   cmd     pid ||||| time  |   caller      
      \   /    |||||   \   |   /           
  <idle>-0     1Dnh.    0us : smp_reschedule_interrupt (c0100c8a 0 0)
  <idle>-0     1Dnh.    0us : preempt_schedule_irq (need_resched)
  <idle>-0     1Dnh.    1us : __schedule (preempt_schedule_irq)
  <idle>-0     1Dnh1    1us : sched_clock (__schedule)
  <idle>-0     1Dnh1    2us : _raw_spin_lock_irq (__schedule)
  <idle>-0     1Dnh1    2us : _raw_spin_lock_irqsave (__schedule)
  <idle>-0     1Dnh2    3us : pull_rt_tasks (__schedule)
  <idle>-0     1Dnh2    3us : double_lock_balance (pull_rt_tasks)
  <idle>-0     1Dnh2    3us : _raw_spin_trylock (double_lock_balance)
  <idle>-0     1Dnh3    3us : pick_rt_task (pull_rt_tasks)
  <idle>-0     1Dnh3    4us!: find_next_bit (pick_rt_task)
  <idle>-0     1Dnh3  211us : _raw_spin_unlock (pull_rt_tasks)
  <idle>-0     1Dnh2  211us : preempt_schedule (pull_rt_tasks)
  <idle>-0     1Dnh2  212us : find_next_bit (pull_rt_tasks)
  <idle>-0     1Dnh2  212us : find_next_bit (pull_rt_tasks)
  <idle>-0     1Dnh2  212us : _raw_spin_unlock (__schedule)
  <idle>-0     1Dnh1  213us : preempt_schedule (__schedule)
  <idle>-0     1Dnh1  213us : _raw_spin_lock (__schedule)
  <idle>-0     1Dnh2  213us : find_next_bit (__schedule)
  <idle>-0     1Dnh2  213us : _raw_spin_lock (__schedule)
  <idle>-0     1Dnh3  214us : find_next_bit (__schedule)
  <idle>-0     1Dnh3  214us : find_next_bit (__schedule)
  <idle>-0     1Dnh3  215us : _raw_spin_unlock (__schedule)
  <idle>-0     1Dnh2  215us : preempt_schedule (__schedule)
  <idle>-0     1Dnh2  215us : find_next_bit (__schedule)
  <idle>-0     1Dnh2  216us : trace_array (__schedule)
  <idle>-0     1Dnh2  217us : trace_array <<...>-3144> (31 78)
  <idle>-0     1Dnh2  218us : trace_array (__schedule)
   <...>-3144  1Dnh2  220us : __switch_to (__schedule)
   <...>-3144  1Dnh2  221us : __schedule <<idle>-0> (8c 31)
   <...>-3144  1Dnh2  221us : _raw_spin_unlock (__schedule)
   <...>-3144  1Dnh1  222us : trace_stop_sched_switched (__schedule)
   <...>-3144  1Dnh1  222us : trace_stop_sched_switched <<...>-3144> (31 0)
   <...>-3144  1Dnh1  223us : _raw_spin_lock (trace_stop_sched_switched)
   <...>-3144  1Dnh1  224us : trace_stop_sched_switched (__schedule)

My build of -48-36 just completed.  I'll see how it behaves for me and 
keep you posted.


Best Regards,
--William Weston <weston@sysex.net>
