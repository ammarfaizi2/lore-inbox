Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267417AbUHPE3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267417AbUHPE3l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 00:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267418AbUHPE3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 00:29:40 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:17390 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267417AbUHPE3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 00:29:36 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816042653.GA14738@elte.hu>
References: <1092382825.3450.19.camel@mindpipe>
	 <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe>
	 <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu>
	 <20040816022554.16c3c84a@mango.fruits.de>
	 <1092622121.867.109.camel@krustophenia.net> <20040816024314.GA8960@elte.hu>
	 <20040816030818.GA10685@elte.hu> <1092629953.810.23.camel@krustophenia.net>
	 <20040816042653.GA14738@elte.hu>
Content-Type: text/plain
Message-Id: <1092630624.810.30.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 00:30:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 00:26, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > > just to check this theory, could you make __check_and_rekey() an empty
> > > > function? This should still produce a working random driver, albeit at
> > > > much reduced entropy. If these latencies have a relationship to the
> > > > mlockall() issue then this change should have an effect.
> > > 
> > > hm, could you disable the random driver in the .config rather? It seems
> > > that adding to the entropy pool (from hardirq context) alone is quite
> > > expensive too.
> > > 
> > 
> > Can this be disabled in the .config?  I can't find an option for it.
> 
> oh well, indeed it cannot be disabled. Then i'd suggest to return early
> from extract_entropy(), without doing anything. That is the function
> that seems to introduce the worst overhead.
> 

Yes, I really seem to remember this could be disabled in the past...
maybe I am thinking of BSD/OS, or maybe this CONFIG_ option was removed.

This was caused by 'Actions -> Run -> rxvt':

preemption latency trace v1.0
-----------------------------
 latency: 409 us, entries: 300 (300)
 process: gnome-panel/7575, uid: 1000
 nice: 0, policy: 0, rt_priority: 0
=======>
 0.000ms (+0.000ms): __vma_link_rb (copy_mm)
 0.000ms (+0.000ms): rb_insert_color (copy_mm)
 0.000ms (+0.000ms): __rb_rotate_left (rb_insert_color)
 0.000ms (+0.000ms): copy_page_range (copy_mm)
 0.001ms (+0.000ms): pte_alloc_map (copy_page_range)
 0.205ms (+0.204ms): do_IRQ (common_interrupt)
 0.206ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
 0.209ms (+0.003ms): generic_redirect_hardirq (do_IRQ)
 0.210ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
 0.210ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
 0.210ms (+0.000ms): mark_offset_tsc (timer_interrupt)
 0.217ms (+0.006ms): do_timer (timer_interrupt)
 0.217ms (+0.000ms): update_process_times (do_timer)
 0.217ms (+0.000ms): update_one_process (update_process_times)
 0.217ms (+0.000ms): run_local_timers (update_process_times)
 0.218ms (+0.000ms): raise_softirq (update_process_times)
 0.218ms (+0.000ms): scheduler_tick (update_process_times)
 0.218ms (+0.000ms): sched_clock (scheduler_tick)
 0.219ms (+0.001ms): task_timeslice (scheduler_tick)
 0.220ms (+0.000ms): update_wall_time (do_timer)
 0.220ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 0.221ms (+0.000ms): generic_note_interrupt (do_IRQ)
 0.221ms (+0.000ms): end_8259A_irq (do_IRQ)
 0.222ms (+0.000ms): enable_8259A_irq (do_IRQ)
 0.223ms (+0.001ms): do_softirq (do_IRQ)
 0.223ms (+0.000ms): __do_softirq (do_softirq)
 0.224ms (+0.000ms): wake_up_process (do_softirq)
 0.224ms (+0.000ms): try_to_wake_up (wake_up_process)
 0.224ms (+0.000ms): task_rq_lock (try_to_wake_up)
 0.225ms (+0.000ms): activate_task (try_to_wake_up)
 0.225ms (+0.000ms): sched_clock (activate_task)
 0.225ms (+0.000ms): recalc_task_prio (activate_task)
 0.226ms (+0.000ms): effective_prio (recalc_task_prio)
 0.226ms (+0.000ms): enqueue_task (activate_task)
 0.227ms (+0.000ms): preempt_schedule (try_to_wake_up)
 0.228ms (+0.000ms): preempt_schedule (copy_page_range)

[...]

 0.399ms (+0.000ms): preempt_schedule (copy_page_range)
 0.400ms (+0.000ms): check_preempt_timing (touch_preempt_timing)

Lee

