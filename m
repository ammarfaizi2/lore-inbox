Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269210AbUIBWro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269210AbUIBWro (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269213AbUIBWpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:45:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:40326 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269210AbUIBWmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:42:11 -0400
Date: Fri, 3 Sep 2004 00:43:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: linux-kernel@vger.kernel.org, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q9
Message-ID: <20040902224347.GA28775@elte.hu>
References: <OF77CAEAC1.5B07194A-ON86256F03.006FD5A2-86256F03.006FD5AB@raytheon.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <OF77CAEAC1.5B07194A-ON86256F03.006FD5A2-86256F03.006FD5AB@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> [1] No cascade traces - several runs with this result - we should be
> OK here.

yeah, good. I think my analysis was correct: softirqd got delayed by
higher prio tasks and this caused a backlog in timer processing => hence
the 'storm' of cascade() calls. Now we may reschedule between cascade()
calls.

> [2] rtl8139 still showing some traces due to my use of
> netdev_backlog_granularity = 8. Had severe problems when it is 1.

i've just released -R0 which should fix these issues in theory.

> [3] I read what you said about hardware overhead, but the data seems
> to show latencies getting to "__switch_to" may be buried in some
> inline functions. A typical trace looks something like this...

> 
> 00000002 0.003ms (+0.000ms): dummy_switch_tasks (schedule)
> 00000002 0.003ms (+0.000ms): schedule (worker_thread)
> 00000002 0.003ms (+0.000ms): schedule (worker_thread)
> 00000002 0.004ms (+0.000ms): schedule (worker_thread)
> 00000002 0.004ms (+0.000ms): schedule (worker_thread)
> 00000002 0.004ms (+0.000ms): schedule (worker_thread)
> 00000002 0.004ms (+0.274ms): schedule (worker_thread)
> 04000002 0.279ms (+0.000ms): __switch_to (schedule)
> 
> dummy_switch_tasks refers to a function I added / called right after
> the label switch_tasks (in sched.c). The mcount() traces that follow
> are basically at each step leading up to the call to context_switch.
> Since context_switch is static inline, I assume it is not traced -
> please confirm. [...]

correct, inline functions are not traced. (Also, 'tail-merged' function
calls are not traced either - this can happen if a function calls
another one right at the end.)

> [...] I am considering adding mcount() calls inside context_switch to
> see if there is a step that has some long duration.

yeah. If you can isolate the overhead down to a specific line of code
that would implicate that particular piece of code quite heavily. But if
the latencies happen all around the place then it means that it's not
the code that is at fault, it's just an innocent bystander.

> [4] The go_idle path is also one that appears to have some long
> latencies. The following is an example - the trace of dummy_go_idle
> refers to the label named go_idle.
> 
> 00000002 0.002ms (+0.000ms): dummy_go_idle (schedule)
> 00000002 0.002ms (+0.060ms): schedule (io_schedule)
> 00000002 0.063ms (+0.069ms): load_balance_newidle (schedule)
> 00000002 0.133ms (+0.074ms): find_busiest_group (load_balance_newidle)
> 00000002 0.207ms (+0.034ms): find_next_bit (find_busiest_group)
> 00000002 0.242ms (+0.039ms): find_next_bit (find_busiest_group)
> 00000002 0.281ms (+0.070ms): find_busiest_queue (load_balance_newidle)
> 00000002 0.351ms (+0.071ms): find_next_bit (find_busiest_queue)
> 00000002 0.422ms (+0.069ms): double_lock_balance (load_balance_newidle)
> 00000003 0.492ms (+0.070ms): move_tasks (load_balance_newidle)

this is as if the CPU executed everything in 'slow motion'. E.g. the
cache being disabled could be one such reason - or some severe DMA or
other bus traffic.

the code being executed is completely benign - no locking, just
straightforward processing. No way can they take 60-70 usecs!

as if certain data structures were uncached or something like that. 
Although this theory can be excluded i think because the same code
doesnt execute slowly in other traces (and most likely not in the
normal, non-traced execution either).

in theory code tracing itself could perhaps generate some sort of bad
cache pattern that hits a sweet spot of the CPU. (very weak theory but
that's all that's left ...) Could you disable tracing (but keep the
preemption-timing on) and see whether you still get these 500+ usec
latencies reported? Switching /proc/sys/kernel/tracing_enabled off
should be enough.

> [5] mark_tsc_offset - some steps in that sequence are generating
> some long latencies. For example:
> 
> 04010003 0.011ms (+0.000ms): mark_offset_tsc (timer_interrupt)
> 04010003 0.011ms (+0.000ms): mark_offset_tsc (timer_interrupt)
> 04010003 0.011ms (+0.000ms): spin_lock (mark_offset_tsc)
> 04010004 0.011ms (+0.137ms): mark_offset_tsc (timer_interrupt)
> 04010004 0.149ms (+0.000ms): mark_offset_tsc (timer_interrupt)
> 04010004 0.149ms (+0.000ms): spin_lock (mark_offset_tsc)
> 04010005 0.149ms (+0.144ms): mark_offset_tsc (timer_interrupt)
> 04010005 0.294ms (+0.004ms): mark_offset_tsc (timer_interrupt)
> 04010005 0.298ms (+0.003ms): mark_offset_tsc (timer_interrupt)
> 04010005 0.301ms (+0.000ms): mark_offset_tsc (timer_interrupt)
> 04010005 0.301ms (+0.000ms): mark_offset_tsc (timer_interrupt)
> 04010004 0.301ms (+0.000ms): mark_offset_tsc (timer_interrupt)
> 04010004 0.301ms (+0.073ms): mark_offset_tsc (timer_interrupt)
> 04010004 0.375ms (+0.000ms): mark_offset_tsc (timer_interrupt)
> 04010003 0.375ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
> 
> I didn't see any feedback from the table I provided previously.
> Is this data helpful or should I take out the patch?

sent a mail separately, replying to your previous table. I think it's
useful, lets try to pin down what code there is between #03-#04.

> [6] spin_lock - may just be an SMP lock problem but here's a trace
> I don't recall seeing previously.
> 
> 00000002 0.008ms (+0.000ms): snd_ensoniq_trigger (snd_pcm_do_stop)
> 00000002 0.008ms (+0.344ms): spin_lock (snd_ensoniq_trigger)
> 00010003 0.353ms (+0.015ms): do_nmi (snd_ensoniq_trigger)
> 00010003 0.368ms (+0.006ms): do_nmi (update_one_process)
> 00010003 0.375ms (+0.000ms): profile_tick (nmi_watchdog_tick)
> 00010003 0.375ms (+0.000ms): profile_hook (profile_tick)
> 00010003 0.375ms (+0.121ms): read_lock (profile_hook)
> 00010004 0.496ms (+0.000ms): notifier_call_chain (profile_hook)
> 00010003 0.497ms (+0.068ms): profile_hit (nmi_watchdog_tick)
> 00000002 0.566ms (+0.000ms): snd_pcm_post_stop (snd_pcm_action_single)

it's hard to tell whether the overhead is the 'magic' overhead or
spinning on the lock. I've attached trace-spin.patch that shows us how
many times a spinlock had to spin before it got the lock. It will also
tell the precise time it took to execute the spinning function.

if we looped zero times and still it's high overhead then this again
implicates the 'magic' hw issue that interferes.

> [7] Not sure what to call it, I don't recall seeing this type of trace
> before either.
> 
>  => started at: __spin_lock_irqsave+0x39/0x90
>  => ended at:   as_work_handler+0x5c/0xa0
> =======>
> 00000001 0.000ms (+0.000ms): __spin_lock_irqsave (spin_lock_irq)
> 00000001 0.000ms (+0.000ms): generic_enable_irq (ide_do_request)
> 00000001 0.000ms (+0.000ms): __spin_lock_irqsave (generic_enable_irq)
> 00000002 0.000ms (+0.000ms): unmask_IO_APIC_irq (generic_enable_irq)
> 00000002 0.000ms (+0.000ms): __spin_lock_irqsave (unmask_IO_APIC_irq)
> 00000003 0.001ms (+0.000ms): __unmask_IO_APIC_irq (unmask_IO_APIC_irq)
> 00000003 0.001ms (+0.066ms): __modify_IO_APIC_irq (__unmask_IO_APIC_irq)
> 00000001 0.067ms (+0.001ms): smp_apic_timer_interrupt (as_work_handler)
> 00010001 0.069ms (+0.087ms): profile_tick (smp_apic_timer_interrupt)
> 00010001 0.157ms (+0.000ms): profile_hook (profile_tick)
> 00010001 0.157ms (+0.069ms): read_lock (profile_hook)
> 00010002 0.227ms (+0.000ms): notifier_call_chain (profile_hook)
> 00010001 0.227ms (+0.069ms): profile_hit (smp_apic_timer_interrupt)
> 00010001 0.297ms (+0.000ms): update_process_times
> (smp_apic_timer_interrupt)
> 00010001 0.297ms (+0.069ms): update_one_process (update_process_times)
> 00010001 0.367ms (+0.000ms): run_local_timers (update_process_times)
> 00010001 0.367ms (+0.069ms): raise_softirq (update_process_times)
> 00010001 0.437ms (+0.000ms): scheduler_tick (update_process_times)
> 00010001 0.437ms (+0.070ms): sched_clock (scheduler_tick)
> 00020001 0.507ms (+0.000ms): do_nmi (scheduler_tick)
> 00020001 0.508ms (+0.002ms): do_nmi (del_timer_sync)
> 00020001 0.511ms (+0.000ms): profile_tick (nmi_watchdog_tick)
> 00020001 0.511ms (+0.000ms): profile_hook (profile_tick)
> 00020001 0.511ms (+0.065ms): read_lock (profile_hook)
> 00020002 0.577ms (+0.000ms): notifier_call_chain (profile_hook)
> 00020001 0.577ms (+0.000ms): profile_hit (nmi_watchdog_tick)
> 00010001 0.578ms (+0.000ms): spin_lock (scheduler_tick)

this too seems to be 'magic' overhead just randomly in the middle of a
commonly executing function.

> [8] exit_mmap - there are a few traces referring to code in or
> called by exit_mmap. Here's an example.
> 
>  => started at: cond_resched_lock+0x6b/0x110
>  => ended at:   exit_mmap+0x155/0x1f0
> =======>
> 00000001 0.000ms (+0.000ms): touch_preempt_timing (cond_resched_lock)
> 00000001 0.000ms (+0.000ms): __bitmap_weight (unmap_vmas)
> 00000001 0.000ms (+0.000ms): vm_acct_memory (exit_mmap)
> 00000001 0.001ms (+0.629ms): clear_page_tables (exit_mmap)
> 00000001 0.631ms (+0.000ms): flush_tlb_mm (exit_mmap)
> 00000001 0.631ms (+0.000ms): free_pages_and_swap_cache (exit_mmap)

this should be a known latency: clear_page_tables() runs with preemption
disabled (a spinlock held).

	Ingo

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="trace-spin.patch"

--- linux/kernel/sched.c.orig2	
+++ linux/kernel/sched.c	
@@ -4926,9 +4926,11 @@ EXPORT_SYMBOL(__might_sleep);
 #define BUILD_LOCK_OPS(op, locktype)					\
 void __sched op##_lock(locktype *lock)					\
 {									\
+	unsigned long count = 0;					\
 	for (;;) {							\
 		if (likely(_raw_##op##_trylock(lock)))			\
 			break;						\
+		count++;						\
 		preempt_disable();					\
 		touch_preempt_timing();					\
 		preempt_enable();					\
@@ -4937,16 +4939,19 @@ void __sched op##_lock(locktype *lock)		
 		cpu_relax();						\
 	}								\
 	preempt_disable();						\
+	__trace((unsigned long)op##_lock, count);			\
 }									\
 									\
 EXPORT_SYMBOL(op##_lock);						\
 									\
 void __sched __##op##_lock_irqsave(locktype *lock, unsigned long *flags)\
 {									\
+	unsigned long count = 0;					\
 	for (;;) {							\
 		local_irq_save(*flags);					\
 		if (likely(_raw_##op##_trylock(lock)))			\
 			break;						\
+		count++;						\
 		local_irq_restore(*flags);				\
 									\
 		preempt_disable();					\
@@ -4957,6 +4962,7 @@ void __sched __##op##_lock_irqsave(lockt
 			(lock)->break_lock = 1;				\
 		cpu_relax();						\
 	}								\
+	__trace((unsigned long)__##op##_lock_irqsave, count);		\
 	preempt_disable();						\
 }									\
 									\

--jRHKVT23PllUwdXP--
