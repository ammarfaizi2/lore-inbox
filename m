Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267679AbUHPOQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267679AbUHPOQV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 10:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267657AbUHPOPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 10:15:52 -0400
Received: from pD9517D3C.dip.t-dialin.net ([217.81.125.60]:52352 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S267678AbUHPOOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 10:14:20 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P2
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <1092662814.5082.2.camel@localhost>
References: <20040816023655.GA8746@elte.hu>
	 <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu>  <20040816120933.GA4211@elte.hu>
	 <1092662814.5082.2.camel@localhost>
Content-Type: text/plain
Message-Id: <1092665577.5362.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 16:12:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote :
> Ingo Molnar wrote :
> > here's -P2:
> > 
> >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P2
> > 
> > Changes since -P1:
> > 
> >  - trace interrupted kernel code (via hardirqs, NMIs and pagefaults)
> > 
> >  - yet another shot at trying to fix the IO-APIC/USB issues.
> > 
> >  - mcount speedups - tracing should be faster
> > 
> > 	Ingo
> 
> Same do_IRQ problem with P2, trace is here :
> http://www.undata.org/~thomas/swapper-P2.trace
> 
> Thomas
> 

Ok, maybe that was a false positive. In fact the trace corresponds to
some preempt violation occurring during the boot process :
preemption latency trace v1.0
-----------------------------
 latency: 136095 us, entries: 4000 (14818)
 process: swapper/1, uid: 0
 nice: 0, policy: 0, rt_priority: 0
=======>
When I reset preempt_max_latency to 100, /proc/latency_trace stays the
same, but the latency time reported is updated to reflect the new
preemtp_max_latency :
root@satellite thomas # diff trace1-P2 trace2-P2
3c3
<  latency: 136095 us, entries: 4000 (14818)
---
>  latency: 100 us, entries: 4000 (14818)

There still are weird things happening with irq handling, though. how
can generic_redirect_hardirq eat half a millisecond :

preemption latency trace v1.0
-----------------------------
 latency: 481 us, entries: 32 (32)
 process: swapper/0, uid: 0
 nice: 0, policy: 0, rt_priority: 0
=======>
 0.000ms (+0.000ms): do_IRQ (default_idle)
 0.000ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
 0.459ms (+0.459ms): generic_redirect_hardirq (do_IRQ)
 0.459ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
 0.459ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
 0.459ms (+0.000ms): mark_offset_tsc (timer_interrupt)
 0.465ms (+0.005ms): do_timer (timer_interrupt)
 0.465ms (+0.000ms): update_process_times (do_timer)
 0.465ms (+0.000ms): update_one_process (update_process_times)
 0.465ms (+0.000ms): run_local_timers (update_process_times)
 0.465ms (+0.000ms): raise_softirq (update_process_times)
 0.466ms (+0.000ms): scheduler_tick (update_process_times)
 0.466ms (+0.000ms): sched_clock (scheduler_tick)
 0.466ms (+0.000ms): update_wall_time (do_timer)
 0.466ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
 0.466ms (+0.000ms): profile_hook (timer_interrupt)
 0.466ms (+0.000ms): notifier_call_chain (profile_hook)
 0.467ms (+0.000ms): generic_note_interrupt (do_IRQ)
 0.467ms (+0.000ms): end_8259A_irq (do_IRQ)
 0.467ms (+0.000ms): enable_8259A_irq (do_IRQ)
 0.468ms (+0.000ms): do_softirq (do_IRQ)
 0.468ms (+0.000ms): __do_softirq (do_softirq)
 0.468ms (+0.000ms): wake_up_process (do_softirq)
 0.468ms (+0.000ms): try_to_wake_up (wake_up_process)
 0.468ms (+0.000ms): task_rq_lock (try_to_wake_up)
 0.468ms (+0.000ms): activate_task (try_to_wake_up)
 0.469ms (+0.000ms): sched_clock (activate_task)
 0.469ms (+0.000ms): recalc_task_prio (activate_task)
 0.469ms (+0.000ms): effective_prio (recalc_task_prio)
 0.469ms (+0.000ms): enqueue_task (activate_task)
 0.469ms (+0.000ms): preempt_schedule (try_to_wake_up)
 0.469ms (+0.000ms): check_preempt_timing (sub_preempt_count)

Is there any source of interruption not covered by your P2 patch ?

Thomas


