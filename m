Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268157AbUIGRBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268157AbUIGRBh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 13:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268223AbUIGQ76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:59:58 -0400
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:63567 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S268157AbUIGQzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:55:07 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Date: Tue, 7 Sep 2004 11:54:22 -0500
Message-ID: <OFD3DB738F.105F62D0-ON86256F08.005CDE25-86256F08.005CDE44@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 09/07/2004 11:54:23 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Results from this morning's test with -R1 and some follow up on
related messages.

Two runs with -R1 plus the following changes
 - a change to the ensonic driver to reduce latency
 - added mcount() calls in sched.c and timer_tsc.c
 - disabled inline functions in sched.c
The last two so we can see the steps a little more clearly.

The differences between the runs was:
 - first run had DRI and hardware acceleration enabled
 - second run disabled DRI / hardware acceleration
as suggested by Lee Revell.

>From Lee Revell <rlrevell@joe-job.com>
>This is looking more and more like a video driver problem:
>...
>The easiest way to eliminate this possibility is to disable DRI and set
>'Option "NoAccel"' in your X config.  Do you get the same mysterious
>latencies with this setting?

I am not sure I see any significant differences in latencies. Most of
the large delays occur during disk reads and the number of traces >
500 usec was over 100 in both tests (about 30 minutes each). There were
also more latency traces per minute during disk reads when DRI was
disabled. There were however none of the "find_next_bit" traces in the
NoAccel run with significant time delays so that may indicate some
display problems but not sure. See below for details.

Side Comment
============

If you look at the date / time of the traces, you will notice that
most occur in the latter part of the test. This is during the
"disk copy" and "disk read" parts of the testing. To illustrate, the
first 10 traces take about 20 minutes to collect; the last 90 are
collected in 15 and 9 minutes (first and second test).

It is also encouraging that the longest trace is < 800 usec in these
two runs. This is far better than what I saw a couple weeks ago.

Shortest trace
==============

preemption latency trace v1.0.5 on 2.6.9-rc1-VP-R1
--------------------------------------------------
 latency: 550 us, entries: 6 (6)
    -----------------
    | task: cat/6771, uid:0 nice:0 policy:0 rt_prio:0
    -----------------
 => started at: kmap_atomic+0x23/0xe0
 => ended at:   kunmap_atomic+0x7b/0xa0
=======>
00000001 0.000ms (+0.000ms): kmap_atomic (file_read_actor)
00000001 0.000ms (+0.000ms): page_address (file_read_actor)
00000001 0.000ms (+0.549ms): __copy_to_user_ll (file_read_actor)
00000001 0.550ms (+0.000ms): kunmap_atomic (file_read_actor)
00000001 0.550ms (+0.000ms): sub_preempt_count (kunmap_atomic)
00000001 0.550ms (+0.000ms): update_max_trace (check_preempt_timing)

The 1/2 msec latency in __copy_to_user_ll occurred a few more times
in both tests.

Find Next Bit
=============

It appears that -R1 has significantly fewer cases where the code in
find_next_bit is delayed. To summarize:

# grep find_next_bit lt040903/lt*/lt.* | grep '(+0.1' | wc -l
63
# grep find_next_bit lt040907/lt*/lt.* | grep '(+0.1' | wc -l
0

[counting number of trace entries w/ 100-199 usec latencies]

The runs on September 3 were with -Q9, today's (September 7) were
with -R1. Not sure why this changed, but it is encouraging. The
maximum with DRI / display acceleration was +0.069ms, the maximum
without DRI was +0.001ms.

Mark Offset TSC
===============

In a similar way, long latencies in mark_offset_tsc were significantly
reduced in -R1.
# grep _tsc lt040903/lt*/lt.* | grep '(+0.1' | wc -l
24
# grep _tsc lt040907/lt*/lt.* | grep '(+0.1' | wc -l
3

Two of the long delays were in the same trace in the following
sequence:

00010001 0.140ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
00010001 0.140ms (+0.000ms): spin_lock (timer_interrupt)
00010002 0.140ms (+0.000ms): spin_lock (<00000000>)
00010002 0.141ms (+0.000ms): mark_offset_tsc (timer_interrupt) [0]
00010002 0.141ms (+0.000ms): mark_offset_tsc (timer_interrupt) [1]
00010002 0.141ms (+0.000ms): spin_lock (mark_offset_tsc)
00010003 0.141ms (+0.000ms): spin_lock (<00000000>)
00010003 0.141ms (+0.131ms): mark_offset_tsc (timer_interrupt) [2]
00010003 0.273ms (+0.000ms): mark_offset_tsc (timer_interrupt) [3]
00010003 0.273ms (+0.000ms): spin_lock (mark_offset_tsc)
00010004 0.273ms (+0.000ms): spin_lock (<00000000>)
00010004 0.273ms (+0.145ms): mark_offset_tsc (timer_interrupt) [4]
00010004 0.419ms (+0.004ms): mark_offset_tsc (timer_interrupt) [5]
00010004 0.423ms (+0.002ms): mark_offset_tsc (timer_interrupt) [6]
00010004 0.425ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010004 0.425ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010003 0.426ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010003 0.426ms (+0.046ms): mark_offset_tsc (timer_interrupt)
00010003 0.472ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010002 0.472ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)

For reference, the steps in the code read (w/o comments):

        mcount(); [1]
        write_seqlock(&monotonic_lock);
        mcount(); [2]
        last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
        rdtsc(last_tsc_low, last_tsc_high);

        mcount(); [3]
        spin_lock(&i8253_lock);
        mcount(); [4]
        outb_p(0x00, PIT_MODE);     /* latch the count ASAP */
        mcount(); [5]

        count = inb_p(PIT_CH0);    /* read the latched count */
        mcount(); [6]
        count |= inb(PIT_CH0) << 8;
        mcount(); [7]
I numbered the traces / corresponding mcount() calls. If I labeled this
right, it appears the delays were in the rdtsc call and outb_p to
latch the count. Perhaps a hardware level delay taking place.

Clear Page Tables
=================

This is the longest single latency with the following traces:

# grep '(+0.6' lt040907/lt*/lt.*
lt040907/lt001.v3k1/lt.28:00000001 0.001ms (+0.635ms): clear_page_tables
(exit_mmap)
lt040907/lt002.v3k1/lt.75:00000001 0.001ms (+0.628ms): clear_page_tables
(exit_mmap)

__modify_IO_APIC_irq
====================

Not quite sure what is happening here, but this trace

preemption latency trace v1.0.5 on 2.6.9-rc1-VP-R1
--------------------------------------------------
 latency: 612 us, entries: 111 (111)
    -----------------
    | task: kblockd/0/10, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: __spin_lock_irqsave+0x4b/0xa0
 => ended at:   as_work_handler+0x5c/0xa0
=======>
00000001 0.000ms (+0.000ms): __spin_lock_irqsave (spin_lock_irq)
00000001 0.000ms (+0.000ms): generic_enable_irq (ide_do_request)
00000001 0.000ms (+0.000ms): __spin_lock_irqsave (generic_enable_irq)
00000001 0.000ms (+0.000ms): __spin_lock_irqsave (<00000000>)
00000002 0.001ms (+0.000ms): unmask_IO_APIC_irq (generic_enable_irq)
00000002 0.001ms (+0.000ms): __spin_lock_irqsave (unmask_IO_APIC_irq)
00000002 0.001ms (+0.000ms): __spin_lock_irqsave (<00000000>)
00000003 0.001ms (+0.000ms): __unmask_IO_APIC_irq (unmask_IO_APIC_irq)
00000003 0.002ms (+0.567ms): __modify_IO_APIC_irq (__unmask_IO_APIC_irq)
00010001 0.569ms (+0.000ms): do_nmi (smp_apic_timer_interrupt)
00010001 0.569ms (+0.002ms): do_nmi (sched_clock)
00010001 0.572ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010001 0.572ms (+0.000ms): profile_hook (profile_tick)
00010001 0.573ms (+0.000ms): read_lock (profile_hook)
00010002 0.573ms (+0.000ms): read_lock (<00000000>)
00010002 0.573ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 0.574ms (+0.000ms): profile_hit (nmi_watchdog_tick)
00000001 0.575ms (+0.000ms): smp_apic_timer_interrupt (as_work_handler)

is an example where __modify_IO_APIC_irq shows up with a long latency.
There were about a dozen long latencies (> 100 usec) in the two tests
run this morning, slightly fewer (6 vs 8) in the first test with DRI
and display accelaration turned on. This appears to be an increase
with -R1, tests over three days (-Q5 through -Q9) only had 4 long
latencies at this spot. [Hmm - that might be due to the change in
the way we compute / display the latencies]

Spin Lock
=========

We seem to have gotten stuck here in a spin lock...

 => started at: spin_lock+0x34/0x90
 => ended at:   journal_commit_transaction+0xa25/0x1c30
=======>
00000001 0.000ms (+0.559ms): spin_lock (journal_commit_transaction)

and here...

 => started at: __read_lock_irqsave+0x93/0xa0
 => ended at:   snd_pcm_lib_write1+0x3ba/0x600
=======>
00000001 0.000ms (+0.000ms): __read_lock_irqsave (read_lock_irq)
00000001 0.000ms (+0.000ms): spin_lock (snd_pcm_lib_write1)
00000002 0.000ms (+0.000ms): spin_lock (<00000000>)
00000002 0.000ms (+0.000ms): snd_pcm_update_hw_ptr (snd_pcm_lib_write1)
...
00000002 0.008ms (+0.000ms): snd_ensoniq_trigger (snd_pcm_do_stop)
00000002 0.009ms (+0.000ms): spin_lock (snd_ensoniq_trigger)
00000003 0.009ms (+0.549ms): spin_lock (<00000000>)

Overall there traces referring to spin_lock were...

# grep 'spin_lock (' lt040907/lt*/* | grep -v '+0.0' | wc -l
35
# grep 'spin_lock (' lt040903/lt*/* | grep -v '+0.0' | wc -l
11

More of these traces in -R1 than -Q9, but I am not sure if this is
significant or not.

Context Switch
==============

With the inlined functions disabled, and some extra debug code,
I saw context_switch appear > 800 times in the long latency traces.
Usually very fast (> 10 usec) but sometimes listed with some long
latencies (> 100 usec, 45 trace lines).
For example:

 => started at: schedule+0x5b/0x610
 => ended at:   schedule+0x385/0x610
...
0000002 0.004ms (+0.000ms): schedule (do_irqd)
00000002 0.005ms (+0.000ms): context_switch (schedule)
00000002 0.005ms (+0.000ms): dummy_cs_entry (context_switch)
00000002 0.005ms (+0.000ms): context_switch (schedule)
00000002 0.005ms (+0.000ms): dummy_cs_switch_mm (context_switch)
00000002 0.005ms (+0.111ms): context_switch (schedule)
00000002 0.116ms (+0.000ms): dummy_cs_unlikely_if (context_switch)
00000002 0.117ms (+0.000ms): context_switch (schedule)
00000002 0.117ms (+0.000ms): dummy_cs_switch_to (context_switch)
00000002 0.117ms (+0.029ms): context_switch (schedule)
00000002 0.147ms (+0.128ms): __switch_to (context_switch)
00000002 0.275ms (+0.001ms): dummy_cs_exit (context_switch)
00000002 0.277ms (+0.155ms): context_switch (schedule)
00000002 0.432ms (+0.000ms): finish_task_switch (schedule)
00000002 0.433ms (+0.000ms): smp_apic_timer_interrupt (finish_task_switch)
00010002 0.433ms (+0.137ms): profile_tick (smp_apic_timer_interrupt)
00010002 0.571ms (+0.000ms): profile_hook (profile_tick)
00010002 0.571ms (+0.000ms): read_lock (profile_hook)
00010003 0.571ms (+0.000ms): read_lock (<00000000>)
00010003 0.571ms (+0.000ms): notifier_call_chain (profile_hook)
00010002 0.572ms (+0.000ms): profile_hit (smp_apic_timer_interrupt)

The dummy_cs lines refer to calls I added to context_switch at each
step to read...

        dummy_cs_entry();
        if (unlikely(!mm)) {
                next->active_mm = oldmm;
                atomic_inc(&oldmm->mm_count);
                dummy_cs_lazy_tlb();
                enter_lazy_tlb(oldmm, next);
        } else {
                dummy_cs_switch_mm();
                switch_mm(oldmm, mm, next);
        }

        dummy_cs_unlikely_if();
        if (unlikely(!prev->mm)) {
                prev->active_mm = NULL;
                WARN_ON(rq->prev_mm);
                rq->prev_mm = oldmm;
        }

        /* Here we just switch the register state and the stack. */
        dummy_cs_switch_to();
        switch_to(prev, next, prev);

        dummy_cs_exit();
        return prev;

The switch_mm path of the if appears to be more costly time wise
than the lazy_tlb path. To see this from the detailed traces, try
something like...

grep -C2 'dummy_cs_switch_mm' lt040907/lt*/* | less -im
or
grep -C2 'dummy_cs_lazy_tlb' lt040907/lt*/* | less -im

Closing
=======

I will send copies of the traces (not to the mailing lists) in a few
minutes for review / analysis.

I also downloaded the -R8 patch and other associated patches and will
be building that soon.
  --Mark

