Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267535AbUHPLPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267535AbUHPLPQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 07:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267531AbUHPLPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 07:15:16 -0400
Received: from pD9517D05.dip.t-dialin.net ([217.81.125.5]:59268 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S267535AbUHPLPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 07:15:03 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P1
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816040515.GA13665@elte.hu>
References: <20040815115649.GA26259@elte.hu>
	 <20040816022554.16c3c84a@mango.fruits.de>
	 <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu>
	 <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu>
Content-Type: text/plain
Message-Id: <1092654819.5057.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 13:13:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote :
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Anyway, the change to sched.c fixes the mlockall bug, it works
> > perfectly now.  Thanks!
> 
> great! This fix also means that we've got one more lock-break in the
> ext3 journalling code and one more lock-break in dcache.c. I've released
> -P1 with the fix included:
> 
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P1
> 
> 	Ingo

Tested P1. The biggest offender on my system is still reiserfs'
search_by_key. The trace is made of a very long loop of :
 0.016ms (+0.000ms): reiserfs_in_journal (scan_bitmap_block)
 0.016ms (+0.000ms): find_next_zero_bit (scan_bitmap_block)
(...)
 0.977ms (+0.000ms): reiserfs_in_journal (scan_bitmap_block)
 0.977ms (+0.000ms): find_next_zero_bit (scan_bitmap_block)
with interrupts showing up in the trace from time to time.
Do you have plans to fix this, or should I switch to ext3 ?

Another point was the ACPI induced latency I was experiencing. I think
that P1 could help track this down. After a fresh boot on an ACPI
enabled kernel, once the initialization-related latency spikes are over,
I reset /proc/sys/kernel/preempt_max_latency to 100, and then I get a
100us latency_trace attributed to swapper/1:

preemption latency trace v1.0
-----------------------------
 latency: 100 us, entries: 4000 (14253)
 process: swapper/1, uid: 0
 nice: 0, policy: 0, rt_priority: 0
=======>
 0.000ms (+0.000ms): startup_8259A_irq (probe_irq_on)
 0.000ms (+0.000ms): enable_8259A_irq (startup_8259A_irq)
 0.001ms (+0.001ms): startup_8259A_irq (probe_irq_on)
 0.001ms (+0.000ms): enable_8259A_irq (startup_8259A_irq)
 0.002ms (+0.001ms): startup_8259A_irq (probe_irq_on)
 0.002ms (+0.000ms): enable_8259A_irq (startup_8259A_irq)
(...)

but the weird thing is that the latency sum goes way above those 100us,
the culprit being do_IRQ, regularly chewing up to 1ms !

(...)
 0.009ms (+0.000ms): enable_8259A_irq (startup_8259A_irq)
 0.011ms (+0.001ms): startup_8259A_irq (probe_irq_on)
 0.011ms (+0.000ms): enable_8259A_irq (startup_8259A_irq)
 0.954ms (+0.943ms): do_IRQ (common_interrupt)
-------------^
 0.954ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
 0.956ms (+0.002ms): generic_redirect_hardirq (do_IRQ)
 0.956ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
 0.957ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
 0.957ms (+0.000ms): mark_offset_tsc (timer_interrupt)
 0.962ms (+0.005ms): do_timer (timer_interrupt)
(...)
 119.027ms (+0.000ms): preempt_schedule (timer_interrupt)
 119.027ms (+0.000ms): preempt_schedule (timer_interrupt)
 119.027ms (+0.000ms): generic_note_interrupt (do_IRQ)
 119.027ms (+0.000ms): end_8259A_irq (do_IRQ)
 119.028ms (+0.000ms): enable_8259A_irq (do_IRQ)
 119.028ms (+0.000ms): preempt_schedule (do_IRQ)
 119.029ms (+0.000ms): preempt_schedule (do_IRQ)
 119.029ms (+0.000ms): do_softirq (do_IRQ)
 119.029ms (+0.000ms): __do_softirq (do_softirq)
 120.017ms (+0.987ms): do_IRQ (common_interrupt)
---------------^
 120.017ms (+0.000ms): mask_and_ack_8259A (do_IRQ)
 120.019ms (+0.002ms): preempt_schedule (do_IRQ)
 120.019ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
 120.019ms (+0.000ms): preempt_schedule (do_IRQ)
 120.020ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
(...)

You can find the full trace here :
http://www.undata.org/~thomas/swapper.trace

Do you have an idea of what's happening here ?

Thomas


