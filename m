Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVJKQ2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVJKQ2b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 12:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVJKQ2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 12:28:30 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:38859 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932208AbVJKQ2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 12:28:30 -0400
Subject: Re: 2.6.13-rt12: irqs hard off for 657 usecs
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051011112043.GB15995@elte.hu>
References: <1128724690.17981.57.camel@mindpipe>
	 <20051011112043.GB15995@elte.hu>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 12:28:25 -0400
Message-Id: <1129048106.12702.21.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-11 at 13:20 +0200, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Something appears to have disabled IRQs for 657 usecs.
> 
> how hard is it to reproduce this latency?

Very easy.  Here's the current max latency.

The max latency is close to the period of the timer IRQ.  So either it's
an instrumentation bug or something really disables IRQs for up to 1/HZ
seconds.

preemption latency trace v1.1.5 on 2.6.13-rt12
--------------------------------------------------------------------
 latency: 928 us, #1359/1359, CPU#0 | (M:rt VP:0, KP:1, SP:1 HP:1)
    -----------------
    | task: softirq-tasklet-7 (uid:0 nice:0 policy:1 rt_prio:1)
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
 kswapd0-100   0Dnh2    0us : __trace_start_sched_wakeup (try_to_wake_up)
 kswapd0-100   0Dnh2    1us : __trace_start_sched_wakeup <softirq--7> (62 0)
 kswapd0-100   0Dnh1    1us : preempt_schedule (__trace_start_sched_wakeup)
 kswapd0-100   0Dnh1    2us : try_to_wake_up <softirq--7> (62 73)
 kswapd0-100   0Dnh.    2us : check_raw_flags (try_to_wake_up)
 kswapd0-100   0Dnh.    3us : preempt_schedule (try_to_wake_up)
 kswapd0-100   0Dnh.    4us : wake_up_process_mutex (__up_mutex_waiter_savestate)
 kswapd0-100   0Dnh.    4us+: check_raw_flags (up_mutex)
 kswapd0-100   0Dn..    8us : memmove (cache_flusharray)
 kswapd0-100   0Dn..    8us : memcpy (memmove)
 kswapd0-100   0Dn..    9us : _spin_unlock (kmem_cache_free)
 kswapd0-100   0Dn..    9us : up_mutex (_spin_unlock)
 kswapd0-100   0Dnh.   10us : check_raw_flags (up_mutex)
 kswapd0-100   0Dn..   10us : clear_inode (dispose_list)
 kswapd0-100   0Dn..   11us : __might_sleep (clear_inode)
 kswapd0-100   0Dn..   12us : invalidate_inode_buffers (clear_inode)
 kswapd0-100   0Dn..   12us : inode_has_buffers (invalidate_inode_buffers)
 kswapd0-100   0Dn..   13us : __might_sleep (clear_inode)
 kswapd0-100   0Dn..   13us : ext3_clear_inode (clear_inode)
 kswapd0-100   0Dn..   14us : ext3_discard_reservation (ext3_clear_inode)
 kswapd0-100   0Dn..   15us : kfree (ext3_clear_inode)
 kswapd0-100   0Dn..   15us : _spin_lock (dispose_list)
 kswapd0-100   0Dn..   16us : _spin_unlock (dispose_list)
 kswapd0-100   0Dn..   17us : up_mutex (_spin_unlock)
 kswapd0-100   0Dnh.   17us : check_raw_flags (up_mutex)
 kswapd0-100   0Dn..   18us : wake_up_inode (dispose_list)
 kswapd0-100   0Dn..   18us : wake_up_bit (wake_up_inode)
 kswapd0-100   0Dn..   19us : bit_waitqueue (wake_up_bit)
 kswapd0-100   0Dn..   20us : __wake_up_bit (wake_up_bit)

This part repeats:

 kswapd0-100   0Dn..   20us : destroy_inode (dispose_list)
 kswapd0-100   0Dn..   21us : inode_has_buffers (destroy_inode)
 kswapd0-100   0Dn..   22us : dummy_inode_free_security (destroy_inode)
 kswapd0-100   0Dn..   22us : ext3_destroy_inode (destroy_inode)
 kswapd0-100   0Dn..   23us : kmem_cache_free (ext3_destroy_inode)
 kswapd0-100   0Dn..   23us : __local_save_flags (kmem_cache_free)
 kswapd0-100   0Dn..   24us : _spin_lock (kmem_cache_free)
 kswapd0-100   0Dn..   24us : _spin_unlock (kmem_cache_free)
 kswapd0-100   0Dn..   25us : up_mutex (_spin_unlock)
 kswapd0-100   0Dnh.   25us : check_raw_flags (up_mutex)
 kswapd0-100   0Dn..   26us : clear_inode (dispose_list)
 kswapd0-100   0Dn..   27us : __might_sleep (clear_inode)
 kswapd0-100   0Dn..   27us : invalidate_inode_buffers (clear_inode)
 kswapd0-100   0Dn..   28us : inode_has_buffers (invalidate_inode_buffers)
 kswapd0-100   0Dn..   29us : __might_sleep (clear_inode)
 kswapd0-100   0Dn..   29us : ext3_clear_inode (clear_inode)
 kswapd0-100   0Dn..   30us : ext3_discard_reservation (ext3_clear_inode)
 kswapd0-100   0Dn..   31us : kfree (ext3_clear_inode)
 kswapd0-100   0Dn..   31us : _spin_lock (dispose_list)
 kswapd0-100   0Dn..   33us : _spin_unlock (dispose_list)
 kswapd0-100   0Dn..   33us : up_mutex (_spin_unlock)
 kswapd0-100   0Dnh.   34us : check_raw_flags (up_mutex)
 kswapd0-100   0Dn..   34us : wake_up_inode (dispose_list)
 kswapd0-100   0Dn..   35us : wake_up_bit (wake_up_inode)
 kswapd0-100   0Dn..   36us : bit_waitqueue (wake_up_bit)
 kswapd0-100   0Dn..   36us : __wake_up_bit (wake_up_bit)

 kswapd0-100   0Dn..   37us : destroy_inode (dispose_list)
 kswapd0-100   0Dn..   38us : inode_has_buffers (destroy_inode)

etc

Finally the timer interrupt saves the day:

 kswapd0-100   0Dnh.  859us : do_IRQ (c0150297 0 0)
 kswapd0-100   0Dnh1  861us+: mask_and_ack_8259A (__do_IRQ)
 kswapd0-100   0Dnh1  865us : check_raw_flags (mask_and_ack_8259A)
 kswapd0-100   0Dnh1  866us : preempt_schedule (mask_and_ack_8259A)
 kswapd0-100   0Dnh1  866us : redirect_hardirq (__do_IRQ)
 kswapd0-100   0Dnh.  867us : preempt_schedule (__do_IRQ)
 kswapd0-100   0Dnh.  868us : handle_IRQ_event (__do_IRQ)
 kswapd0-100   0Dnh.  869us : timer_interrupt (handle_IRQ_event)
 kswapd0-100   0Dnh1  869us+: mark_offset_pmtmr (timer_interrupt)
 kswapd0-100   0Dnh1  872us : preempt_schedule (mark_offset_pmtmr)
 kswapd0-100   0Dnh1  873us : do_timer (timer_interrupt)
 kswapd0-100   0Dnh1  874us : update_process_times (timer_interrupt)
 kswapd0-100   0Dnh1  874us : account_system_time (update_process_times)
 kswapd0-100   0Dnh1  876us : acct_update_integrals (account_system_time)
 kswapd0-100   0Dnh1  876us : update_mem_hiwater (account_system_time)
 kswapd0-100   0Dnh1  877us : run_local_timers (update_process_times)
 kswapd0-100   0Dnh1  878us : raise_softirq (run_local_timers)
 kswapd0-100   0Dnh1  878us : check_raw_flags (raise_softirq)
 kswapd0-100   0Dnh1  879us : rcu_pending (update_process_times)
 kswapd0-100   0Dnh1  880us : rcu_check_callbacks (update_process_times)
 kswapd0-100   0Dnh1  880us : rcu_try_flip (rcu_check_callbacks)
 kswapd0-100   0Dnh1  881us : check_raw_flags (rcu_try_flip)
 kswapd0-100   0Dnh1  882us : preempt_schedule (rcu_try_flip)
 kswapd0-100   0Dnh2  882us : __rcu_advance_callbacks (rcu_check_callbacks)
 kswapd0-100   0Dnh1  883us : check_raw_flags (rcu_check_callbacks)
 kswapd0-100   0Dnh1  884us : preempt_schedule (rcu_check_callbacks)
 kswapd0-100   0Dnh1  885us : __tasklet_schedule (rcu_check_callbacks)
 kswapd0-100   0Dnh1  885us : check_raw_flags (__tasklet_schedule)
 kswapd0-100   0Dnh1  886us : scheduler_tick (update_process_times)
 kswapd0-100   0Dnh1  887us : sched_clock (scheduler_tick)
 kswapd0-100   0Dnh2  888us : task_timeslice (scheduler_tick)
 kswapd0-100   0Dnh1  889us : preempt_schedule (scheduler_tick)
 kswapd0-100   0Dnh1  890us : smp_local_timer_interrupt (timer_interrupt)
 kswapd0-100   0Dnh.  891us : preempt_schedule (timer_interrupt)
 kswapd0-100   0Dnh1  892us : note_interrupt (__do_IRQ)
 kswapd0-100   0Dnh1  892us : enable_8259A_irq (__do_IRQ)
 kswapd0-100   0Dnh1  894us : check_raw_flags (enable_8259A_irq)
 kswapd0-100   0Dnh1  895us : preempt_schedule (enable_8259A_irq)
 kswapd0-100   0Dnh.  896us : preempt_schedule (__do_IRQ)
 kswapd0-100   0Dnh.  896us : irq_exit (do_IRQ)
 kswapd0-100   0Dnh1  897us : do_softirq (irq_exit)
 kswapd0-100   0Dnh1  898us : __do_softirq (do_softirq)
 kswapd0-100   0Dnh1  899us : trigger_softirqs (__do_softirq)
 kswapd0-100   0Dnh1  899us : wakeup_softirqd (trigger_softirqs)
 kswapd0-100   0Dnh1  900us : wake_up_process (wakeup_softirqd)
 kswapd0-100   0Dnh1  901us : check_preempt_wakeup (wake_up_process)
 kswapd0-100   0Dnh1  901us : try_to_wake_up (wake_up_process)
 kswapd0-100   0Dnh2  902us : activate_task (try_to_wake_up)
 kswapd0-100   0Dnh2  903us : sched_clock (activate_task)
 kswapd0-100   0Dnh2  904us : recalc_task_prio (activate_task)
 kswapd0-100   0Dnh2  905us : __recalc_task_prio (recalc_task_prio)
 kswapd0-100   0Dnh2  905us : __recalc_task_prio <<...>-3> (62 62)
 kswapd0-100   0Dnh2  906us : activate_task <<...>-3> (62 3)
 kswapd0-100   0Dnh2  907us : enqueue_task (activate_task)
 kswapd0-100   0Dnh2  908us : __trace_start_sched_wakeup (try_to_wake_up)
 kswapd0-100   0Dnh2  909us : preempt_schedule (__trace_start_sched_wakeup)
 kswapd0-100   0Dnh2  909us : try_to_wake_up <<...>-3> (62 73)
 kswapd0-100   0Dnh1  910us : check_raw_flags (try_to_wake_up)
 kswapd0-100   0Dnh1  910us : preempt_schedule (try_to_wake_up)
 kswapd0-100   0Dnh1  911us : wake_up_process (wakeup_softirqd)
 kswapd0-100   0Dnh1  912us : wakeup_softirqd (trigger_softirqs)
 kswapd0-100   0Dnh1  912us : wake_up_process (wakeup_softirqd)
 kswapd0-100   0Dnh1  913us : check_preempt_wakeup (wake_up_process)
 kswapd0-100   0Dnh1  913us : try_to_wake_up (wake_up_process)
 kswapd0-100   0Dnh1  915us : check_raw_flags (try_to_wake_up)
 kswapd0-100   0Dnh1  915us : preempt_schedule (try_to_wake_up)
 kswapd0-100   0Dnh1  916us : wake_up_process (wakeup_softirqd)
 kswapd0-100   0Dnh1  917us : check_raw_flags (do_softirq)
 kswapd0-100   0Dnh.  917us : preempt_schedule_irq (need_resched)
 kswapd0-100   0Dnh.  918us : __schedule (preempt_schedule_irq)
 kswapd0-100   0Dnh.  919us : profile_hit (__schedule)
 kswapd0-100   0Dnh1  920us : sched_clock (__schedule)
softirq--7     0Dnh2  923us : __switch_to (__schedule)
softirq--7     0Dnh2  924us : __schedule <kswapd0-100> (73 62)
softirq--7     0...1  925us : trace_stop_sched_switched (__schedule)
softirq--7     0Dnh2  926us : trace_stop_sched_switched <softirq--7> (62 0)
softirq--7     0Dnh2  927us : trace_stop_sched_switched (__schedule)


