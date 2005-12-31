Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbVLaAvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbVLaAvO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 19:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVLaAvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 19:51:14 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:18363 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751183AbVLaAvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 19:51:12 -0500
Subject: Re: [patch] latency tracer, 2.6.15-rc7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20051230080032.GA26152@elte.hu>
References: <1135726300.22744.25.camel@mindpipe>
	 <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
	 <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu>
	 <20051229100233.GA12056@redhat.com> <20051229101736.GA2560@elte.hu>
	 <1135887072.6804.9.camel@mindpipe> <1135887966.6804.11.camel@mindpipe>
	 <20051229202848.GC29546@elte.hu> <1135908980.4568.10.camel@mindpipe>
	 <20051230080032.GA26152@elte.hu>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 19:51:09 -0500
Message-Id: <1135990270.31111.46.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 09:00 +0100, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > It seems that debug_smp_processor_id is being called a lot, even 
> > though I have a UP config, which I didn't see with the -rt kernel:
> 
> do you have CONFIG_DEBUG_PREEMPT enabled? (if yes then disable it)
> 
> > Was this optimized out on UP before?
> 
> no, because smp_processor_id() debugging is useful on UP too: it checks 
> whether smp_processor_id() is every called with preemption enabled, and 
> reports such bugs.

It seems that the networking code's use of RCU can cause 10ms+
latencies:

preemption latency trace v1.1.5 on 2.6.15-rc7
--------------------------------------------------------------------
 latency: 10437 us, #12080/12080, CPU#0 | (M:rt VP:0, KP:0, SP:0 HP:0)
    -----------------
    | task: gam_server-21330 (uid:1000 nice:0 policy:0 rt_prio:0)
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
  <idle>-0     0d.s2    1us : __trace_start_sched_wakeup (try_to_wake_up)
  <idle>-0     0d.s2    1us : __trace_start_sched_wakeup <<...>-21330> (73 0)
  <idle>-0     0d.s.    2us : wake_up_process (process_timeout)
  <idle>-0     0d.s.    3us : tasklet_action (__do_softirq)
  <idle>-0     0d.s.    4us : rcu_process_callbacks (tasklet_action)
  <idle>-0     0d.s.    5us : __rcu_process_callbacks (rcu_process_callbacks)
  <idle>-0     0d.s.    5us : rcu_check_quiescent_state (__rcu_process_callbacks)
  <idle>-0     0d.s.    6us : __rcu_process_callbacks (rcu_process_callbacks)
  <idle>-0     0d.s.    7us : rcu_check_quiescent_state (__rcu_process_callbacks)
  <idle>-0     0d.s.    7us : rcu_do_batch (__rcu_process_callbacks)
  <idle>-0     0d.s.    8us : dst_rcu_free (rcu_do_batch)
  <idle>-0     0d.s.    9us : dst_destroy (dst_rcu_free)
  <idle>-0     0d.s.   11us : ipv4_dst_destroy (dst_destroy)
  <idle>-0     0d.s.   12us : kmem_cache_free (dst_destroy)
  <idle>-0     0d.s.   13us+: debug_smp_processor_id (kmem_cache_free)
  <idle>-0     0d.s.   15us : dst_rcu_free (rcu_do_batch)
  <idle>-0     0d.s.   16us : dst_destroy (dst_rcu_free)
  <idle>-0     0d.s.   16us : ipv4_dst_destroy (dst_destroy)
  <idle>-0     0d.s.   18us : kmem_cache_free (dst_destroy)
  <idle>-0     0d.s.   18us : debug_smp_processor_id (kmem_cache_free)
  <idle>-0     0d.s.   19us : dst_rcu_free (rcu_do_batch)
  <idle>-0     0d.s.   20us : dst_destroy (dst_rcu_free)

  [last 5 lines repeat ~2000 times]

  <idle>-0     0d.s. 10368us : ipv4_dst_destroy (dst_destroy)
  <idle>-0     0d.s. 10369us : kmem_cache_free (dst_destroy)
  <idle>-0     0d.s. 10370us : debug_smp_processor_id (kmem_cache_free)
  <idle>-0     0d.s. 10371us : dst_rcu_free (rcu_do_batch)
  <idle>-0     0d.s. 10371us : dst_destroy (dst_rcu_free)
  <idle>-0     0d.s. 10372us : ipv4_dst_destroy (dst_destroy)
  <idle>-0     0d.s. 10373us : kmem_cache_free (dst_destroy)
  <idle>-0     0d.s. 10373us : debug_smp_processor_id (kmem_cache_free)
  <idle>-0     0d.s. 10375us : debug_smp_processor_id (__do_softirq)
  <idle>-0     0d.s. 10375us : debug_smp_processor_id (__do_softirq)
  <idle>-0     0d.s. 10376us+: run_timer_softirq (__do_softirq)
  <idle>-0     0d.s. 10378us : rh_timer_func (run_timer_softirq)
  <idle>-0     0d.s. 10379us : usb_hcd_poll_rh_status (rh_timer_func)
  <idle>-0     0d.s. 10380us : uhci_hub_status_data (usb_hcd_poll_rh_status)
  <idle>-0     0d.s1 10381us : uhci_scan_schedule (uhci_hub_status_data)
  <idle>-0     0d.s1 10382us : uhci_get_current_frame_number (uhci_scan_schedule)
  <idle>-0     0d.s1 10384us : uhci_free_pending_qhs (uhci_scan_schedule)
  <idle>-0     0d.s1 10384us : uhci_free_pending_tds (uhci_scan_schedule)
  <idle>-0     0d.s1 10385us : uhci_remove_pending_urbps (uhci_scan_schedule)
  <idle>-0     0d.s1 10387us : uhci_transfer_result (uhci_scan_schedule)
  <idle>-0     0d.s2 10388us : uhci_result_common (uhci_transfer_result)
  <idle>-0     0d.s1 10390us : uhci_finish_completion (uhci_scan_schedule)
  <idle>-0     0d.s1 10391us : __wake_up (uhci_scan_schedule)
  <idle>-0     0d.s2 10391us : __wake_up_common (__wake_up)
  <idle>-0     0d.s1 10392us : check_fsbr (uhci_hub_status_data)
  <idle>-0     0d.s1 10394us+: uhci_check_ports (uhci_hub_status_data)
  <idle>-0     0d.s1 10398us : any_ports_active (uhci_hub_status_data)
  <idle>-0     0d.s. 10399us : mod_timer (usb_hcd_poll_rh_status)
  <idle>-0     0d.s. 10400us : __mod_timer (mod_timer)
  <idle>-0     0d.s. 10401us : lock_timer_base (__mod_timer)
  <idle>-0     0d.s1 10402us : internal_add_timer (__mod_timer)
  <idle>-0     0d.s. 10403us : i8042_timer_func (run_timer_softirq)
  <idle>-0     0d.s. 10404us : i8042_interrupt (i8042_timer_func)
  <idle>-0     0d.s. 10405us : mod_timer (i8042_interrupt)
  <idle>-0     0d.s. 10405us : __mod_timer (mod_timer)
  <idle>-0     0d.s. 10406us : lock_timer_base (__mod_timer)
  <idle>-0     0d.s1 10407us+: internal_add_timer (__mod_timer)
  <idle>-0     0d.s. 10411us : tasklet_action (__do_softirq)
  <idle>-0     0d.s. 10412us : rcu_process_callbacks (tasklet_action)
  <idle>-0     0d.s. 10412us : __rcu_process_callbacks (rcu_process_callbacks)
  <idle>-0     0d.s. 10413us : rcu_check_quiescent_state (__rcu_process_callbacks)
  <idle>-0     0d.s. 10414us : __rcu_process_callbacks (rcu_process_callbacks)
  <idle>-0     0d.s. 10414us : rcu_check_quiescent_state (__rcu_process_callbacks)
  <idle>-0     0d.s. 10415us+: debug_smp_processor_id (__do_softirq)
  <idle>-0     0dn.1 10417us < (2097760)
  <idle>-0     0dn.. 10418us : schedule (cpu_idle)
  <idle>-0     0dn.. 10419us : stop_trace (schedule)
  <idle>-0     0dn.. 10420us : profile_hit (schedule)
  <idle>-0     0dn.1 10421us : sched_clock (schedule)
  <idle>-0     0dn.2 10422us : debug_smp_processor_id (schedule)
  <idle>-0     0dn.2 10423us : recalc_task_prio (schedule)
  <idle>-0     0dn.2 10424us : effective_prio (recalc_task_prio)
  <idle>-0     0dn.2 10425us : requeue_task (schedule)
  <idle>-0     0d..2 10426us : debug_smp_processor_id (schedule)
   <...>-21330 0d..2 10430us : __switch_to (schedule)
   <...>-21330 0d..2 10431us+: debug_smp_processor_id (__switch_to)
   <...>-21330 0d..2 10433us : schedule <<idle>-0> (8c 73)
   <...>-21330 0d..1 10434us : trace_stop_sched_switched (schedule)
   <...>-21330 0d..2 10435us+: trace_stop_sched_switched <<...>-21330> (73 0)
   <...>-21330 0d..2 10437us : trace_stop_sched_switched (schedule)

