Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbWA1Sv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbWA1Sv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 13:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWA1Sv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 13:51:27 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:28140 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932536AbWA1Sv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 13:51:26 -0500
Subject: Re: RCU latency regression in 2.6.16-rc1
From: Lee Revell <rlrevell@joe-job.com>
To: dipankar@in.ibm.com
Cc: paulmck@us.ibm.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1138471203.2799.13.camel@mindpipe>
References: <20060124081301.GC25855@elte.hu>
	 <1138090527.2771.91.camel@mindpipe> <20060124091730.GA31204@us.ibm.com>
	 <20060124092330.GA7060@elte.hu> <1138095856.2771.103.camel@mindpipe>
	 <20060124162846.GA7139@in.ibm.com> <20060124213802.GC7139@in.ibm.com>
	 <1138224506.3087.22.camel@mindpipe> <20060126191809.GC6182@us.ibm.com>
	 <1138388123.3131.26.camel@mindpipe>  <20060128170302.GB5633@in.ibm.com>
	 <1138471203.2799.13.camel@mindpipe>
Content-Type: text/plain
Date: Sat, 28 Jan 2006 13:51:23 -0500
Message-Id: <1138474283.2799.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-28 at 13:00 -0500, Lee Revell wrote:
> OK, now we are making progress.

I spoke too soon, it's not fixed:

preemption latency trace v1.1.5 on 2.6.16-rc1
--------------------------------------------------------------------
 latency: 4183 us, #3676/3676, CPU#0 | (M:rt VP:0, KP:0, SP:0 HP:0)
    -----------------
    | task: Xorg-2221 (uid:0 nice:0 policy:0 rt_prio:0)
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
evolutio-2877  0d.h6    1us : __trace_start_sched_wakeup (try_to_wake_up)
evolutio-2877  0d.h6    2us : __trace_start_sched_wakeup <<...>-2221> (73 0)
evolutio-2877  0d.h4    3us : wake_up_state (signal_wake_up)
evolutio-2877  0d.h.    4us : __wake_up (mousedev_notify_readers)
evolutio-2877  0d.h1    5us : __wake_up_common (__wake_up)
evolutio-2877  0d.h.    7us+: usb_submit_urb (hid_irq_in)
evolutio-2877  0d.h.   10us : hcd_submit_urb (usb_submit_urb)
evolutio-2877  0d.h1   11us : usb_get_dev (hcd_submit_urb)
evolutio-2877  0d.h1   11us : get_device (usb_get_dev)
evolutio-2877  0d.h1   12us : kobject_get (get_device)
evolutio-2877  0d.h1   13us : kref_get (kobject_get)
evolutio-2877  0d.h.   14us : usb_get_urb (hcd_submit_urb)
evolutio-2877  0d.h.   14us : kref_get (usb_get_urb)
evolutio-2877  0d.h.   16us : uhci_urb_enqueue (hcd_submit_urb)
evolutio-2877  0d.h1   17us : kmem_cache_alloc (uhci_urb_enqueue)
evolutio-2877  0d.h1   18us : usb_check_bandwidth (uhci_urb_enqueue)
evolutio-2877  0d.h1   19us : usb_calc_bus_time (usb_check_bandwidth)
evolutio-2877  0d.h1   20us : uhci_submit_common (uhci_urb_enqueue)
evolutio-2877  0d.h1   21us : uhci_alloc_td (uhci_submit_common)
evolutio-2877  0d.h1   22us+: dma_pool_alloc (uhci_alloc_td)
evolutio-2877  0d.h1   24us : uhci_alloc_qh (uhci_submit_common)
evolutio-2877  0d.h1   25us : dma_pool_alloc (uhci_alloc_qh)
evolutio-2877  0d.h1   27us : uhci_insert_tds_in_qh (uhci_submit_common)
evolutio-2877  0d.h1   28us : uhci_insert_qh (uhci_submit_common)
evolutio-2877  0d.h1   29us : usb_claim_bandwidth (uhci_urb_enqueue)
evolutio-2877  0d.h.   30us : usb_free_urb (usb_hcd_giveback_urb)
evolutio-2877  0d.h.   31us : kref_put (usb_free_urb)
evolutio-2877  0d.h1   32us : __wake_up (uhci_scan_schedule)
evolutio-2877  0d.h2   32us : __wake_up_common (__wake_up)
evolutio-2877  0d.h.   34us : rhine_interrupt (handle_IRQ_event)
evolutio-2877  0d.h.   35us : ioread16 (rhine_interrupt)
evolutio-2877  0d.h.   37us : ioread8 (rhine_interrupt)
evolutio-2877  0d.h.   39us+: via_driver_irq_handler (handle_IRQ_event)
evolutio-2877  0d.h1   41us : note_interrupt (__do_IRQ)
evolutio-2877  0d.h1   42us : end_8259A_irq (__do_IRQ)
evolutio-2877  0d.H.   45us : irq_exit (do_IRQ)
evolutio-2877  0d.s.   46us < (608)
evolutio-2877  0d.s.   47us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   48us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   49us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   51us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   52us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   53us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   54us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   55us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   56us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   57us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   59us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   60us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   61us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   62us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   63us : call_rcu_bh (rt_run_flush)
evolutio-2877  0d.s.   64us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   66us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   67us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   68us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   69us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   70us : call_rcu_bh (rt_run_flush)
evolutio-2877  0d.s.   72us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   73us : call_rcu_bh (rt_run_flush)
evolutio-2877  0d.s.   74us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   75us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   76us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   77us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   78us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   79us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   81us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   82us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   83us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   84us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   85us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   86us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   88us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   89us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   90us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   91us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   92us : call_rcu_bh (rt_run_flush)
evolutio-2877  0d.s.   93us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   94us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   95us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   97us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   98us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.   99us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.  100us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s.  101us : local_bh_enable (rt_run_flush)

[ etc ]
 
evolutio-2877  0d.s. 4079us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s. 4080us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s. 4081us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s. 4082us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s. 4083us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s. 4085us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s. 4086us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s. 4087us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s. 4088us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s. 4089us : local_bh_enable (rt_run_flush)
evolutio-2877  0d.s. 4091us : mod_timer (rt_secret_rebuild)
evolutio-2877  0d.s. 4092us : __mod_timer (mod_timer)
evolutio-2877  0d.s. 4092us : lock_timer_base (__mod_timer)
evolutio-2877  0d.s1 4093us+: internal_add_timer (__mod_timer)
evolutio-2877  0d.s. 4096us : process_timeout (run_timer_softirq)
evolutio-2877  0d.s. 4097us : wake_up_process (process_timeout)
evolutio-2877  0d.s. 4097us : try_to_wake_up (wake_up_process)
evolutio-2877  0d.s1 4099us : sched_clock (try_to_wake_up)
evolutio-2877  0d.s1 4099us : recalc_task_prio (try_to_wake_up)
evolutio-2877  0d.s1 4101us : effective_prio (recalc_task_prio)
evolutio-2877  0d.s1 4102us : try_to_wake_up <<...>-2847> (73 2)
evolutio-2877  0d.s1 4102us : enqueue_task (try_to_wake_up)
evolutio-2877  0d.s1 4104us : __trace_start_sched_wakeup (try_to_wake_up)
evolutio-2877  0d.H1 4106us : do_IRQ (c01123e4 0 0)
evolutio-2877  0d.h. 4106us : __do_IRQ (do_IRQ)
evolutio-2877  0d.h1 4107us+: mask_and_ack_8259A (__do_IRQ)
evolutio-2877  0d.h. 4111us : handle_IRQ_event (__do_IRQ)
evolutio-2877  0d.h. 4112us : timer_interrupt (handle_IRQ_event)
evolutio-2877  0d.h1 4112us+: mark_offset_tsc (timer_interrupt)
evolutio-2877  0d.h1 4119us : do_timer (timer_interrupt)
evolutio-2877  0d.h1 4120us : update_process_times (timer_interrupt)
evolutio-2877  0d.h1 4120us : account_system_time (update_process_times)
evolutio-2877  0d.h1 4121us : acct_update_integrals (account_system_time)
evolutio-2877  0d.h1 4122us : run_local_timers (update_process_times)
evolutio-2877  0d.h1 4122us : raise_softirq (run_local_timers)
evolutio-2877  0d.h1 4123us : rcu_pending (update_process_times)
evolutio-2877  0d.h1 4123us : __rcu_pending (rcu_pending)
evolutio-2877  0d.h1 4124us : __rcu_pending (rcu_pending)
evolutio-2877  0d.h1 4125us : rcu_check_callbacks (update_process_times)
evolutio-2877  0d.h1 4125us : idle_cpu (rcu_check_callbacks)
evolutio-2877  0d.h1 4126us : scheduler_tick (update_process_times)
evolutio-2877  0d.h1 4127us : sched_clock (scheduler_tick)
evolutio-2877  0d.h1 4128us : run_posix_cpu_timers (update_process_times)
evolutio-2877  0d.h1 4129us : smp_local_timer_interrupt (timer_interrupt)
evolutio-2877  0d.h1 4129us : profile_tick (smp_local_timer_interrupt)
evolutio-2877  0d.h1 4130us : profile_hit (profile_tick)
evolutio-2877  0d.h1 4131us : note_interrupt (__do_IRQ)
evolutio-2877  0d.h1 4132us : end_8259A_irq (__do_IRQ)
evolutio-2877  0d.h1 4132us : enable_8259A_irq (end_8259A_irq)
evolutio-2877  0d.H1 4134us : irq_exit (do_IRQ)
evolutio-2877  0d.s1 4135us < (608)
evolutio-2877  0d.s. 4136us+: wake_up_process (process_timeout)
evolutio-2877  0d.s. 4138us : i8042_timer_func (run_timer_softirq)
evolutio-2877  0d.s. 4139us : i8042_interrupt (i8042_timer_func)
evolutio-2877  0d.s. 4139us : mod_timer (i8042_interrupt)
evolutio-2877  0d.s. 4140us : __mod_timer (mod_timer)
evolutio-2877  0d.s. 4141us : lock_timer_base (__mod_timer)
evolutio-2877  0d.s1 4141us+: internal_add_timer (__mod_timer)
evolutio-2877  0d.s. 4145us : run_timer_softirq (__do_softirq)
evolutio-2877  0d.s. 4145us : hrtimer_run_queues (run_timer_softirq)
evolutio-2877  0d.s. 4146us : ktime_get_real (hrtimer_run_queues)
evolutio-2877  0d.s. 4147us : getnstimeofday (ktime_get_real)
evolutio-2877  0d.s. 4147us : do_gettimeofday (getnstimeofday)
evolutio-2877  0d.s. 4148us : get_offset_tsc (do_gettimeofday)
evolutio-2877  0d.s. 4149us : ktime_get (hrtimer_run_queues)
evolutio-2877  0d.s. 4150us : ktime_get_ts (ktime_get)
evolutio-2877  0d.s. 4151us : getnstimeofday (ktime_get_ts)
evolutio-2877  0d.s. 4151us : do_gettimeofday (getnstimeofday)
evolutio-2877  0d.s. 4152us : get_offset_tsc (do_gettimeofday)
evolutio-2877  0d.s. 4153us : set_normalized_timespec (ktime_get_ts)
evolutio-2877  0d.s. 4154us : tasklet_action (__do_softirq)
evolutio-2877  0d.s. 4155us : rcu_process_callbacks (tasklet_action)
evolutio-2877  0d.s. 4156us : __rcu_process_callbacks (rcu_process_callbacks)
evolutio-2877  0d.s. 4157us : __rcu_process_callbacks (rcu_process_callbacks)
evolutio-2877  0d.s1 4158us+: rcu_start_batch (__rcu_process_callbacks)
evolutio-2877  0dn.. 4160us : preempt_schedule_irq (need_resched)
evolutio-2877  0dn.. 4161us : schedule (preempt_schedule_irq)
evolutio-2877  0dn.. 4162us : stop_trace (schedule)
evolutio-2877  0dn.. 4163us : profile_hit (schedule)
evolutio-2877  0dn.1 4164us+: sched_clock (schedule)
evolutio-2877  0dn.2 4167us : recalc_task_prio (schedule)
evolutio-2877  0dn.2 4168us : effective_prio (recalc_task_prio)
evolutio-2877  0dn.2 4169us+: requeue_task (schedule)
   <...>-2221  0d..2 4174us+: __switch_to (schedule)
   <...>-2221  0d..2 4178us : schedule <evolutio-2877> (7d 73)
   <...>-2221  0d..1 4179us : trace_stop_sched_switched (schedule)
   <...>-2221  0d..2 4180us : trace_stop_sched_switched <<...>-2221> (73 0)
   <...>-2221  0d..2 4182us : schedule (schedule)

Lee


