Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269659AbUINSnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269659AbUINSnK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269415AbUINSlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:41:05 -0400
Received: from mx2.elte.hu ([157.181.151.9]:1496 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269165AbUINSa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:30:56 -0400
Date: Tue, 14 Sep 2004 20:32:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Eric St-Laurent <ericstl34@sympatico.ca>, Free Ekanayaka <free@agnula.org>,
       free78@tin.it, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>, luke@audioslack.com,
       nando@ccrma.stanford.edu,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Message-ID: <20040914183202.GA20316@elte.hu>
References: <OF85F4CCF4.D54BACFC-ON86256F0E.00510311-86256F0E.00510399@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF85F4CCF4.D54BACFC-ON86256F0E.00510311-86256F0E.00510399@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> So I have more relatively small delays in the same test period -
> almost twice as much with few that I can see are swap related. Most
> are network related. One very long trace > 70 msec - this is the third
> day I've had a single multiple millisecond trace in a run.

the big one is the tlb_flush_others() latency:

> 00010003 0.195ms (+0.000ms): do_nmi (flush_tlb_others)
> 00010003 0.195ms (+0.002ms): do_nmi (__trace)

> 00010003 1.193ms (+0.000ms): do_nmi (flush_tlb_others)
> 00010003 1.194ms (+0.001ms): do_nmi (__trace)

> ... the steps over the last millisecond get repeated for several cycles ...

this is similar to what i described in earlier emails - IPI passing 
getting held up by some IRQs-off activity on the other CPU. You can see 
what happened on the other CPU by doing this:

  grep ': do_nmi' lt.20 | grep -v flush_tlb_other

there's only one suspicious thing, roughly half into the trace:

  00010003 30.178ms (+0.004ms): do_nmi (run_timer_softirq)
  00010003 31.178ms (+0.001ms): do_nmi (run_timer_softirq)

so run_timer_softirq() was done - but we dont normally run that with
interrupts disabled ...

so maybe something else is holding up the IPI? Eventually the IPI
arrived so it could very well be just a 70 msec delay due to printing a
latency trace to the console. But ... maybe something odd is going on
that delays IPIs. To debug this further, could you do something like
this to kernel/latency.c's nmi_trace() function:

		if (cpu_online(cpu) && cpu != this_cpu) {
			__trace(eip, nmi_eips[cpu]);
			__trace(eip, irq_stat[cpu].apic_timer_irqs);
		}

this will add a third do_nmi entry to the trace, showing the APIC timer
interrupt counter on that other CPU. If this counter doesnt increase
during the ~70 ticks then that CPU had interrupts disabled permanently
and the IPI latency is normal. If the counter increases then the IPI
delay is unjustified and there's something bad going on ...

> A very long sequence (> 1500 traces) with non zero preempt values that
> end in "00". Does that mean we did not have any locks but could not
> schedule for other reasons?

no - it's 0x00000100 that is SOFTIRQ_OFFSET, so it's normal behavior.

The design is like this: the softirq and hardirq counts are 'merged'
into preempt_count(). spin_lock/unlock increases/decreases the
preempt_count() by 1. Softirq disabling increases the preempt_count() by
0x100 - hardirq entry increases the preempt_count() by 0x10000. This way
we have a nesting up to 255 and we are still able to tell from the
preempt_count() alone whether we are in a hardirq, or whether softirqs
are disabled.

For scheduling purposes all that matters is whether the preempt_count is
nonzero (in which case the kernel must not be preempted). But there are
other contexts too that need exclusion: softirqs will run asynchronously
even if the preempt_count is nonzero - as long as the bits covered by
SOFTIRQ_MASK (0xff00) are not set.

the selinux overhead looks interesting:

> avc_insert
> ==========
> 
> preemption latency trace v1.0.7 on 2.6.9-rc1-bk12-VP-S0
> -------------------------------------------------------
>  latency: 266 us, entries: 80 (80)   |   [VP:1 KP:1 SP:1 HP:1 #CPUS:2]
>     -----------------
>     | task: fam/2565, uid:0 nice:0 policy:0 rt_prio:0
>     -----------------
>  => started at: __spin_lock_irqsave+0x2b/0xb0
>  => ended at:   _spin_unlock_irqrestore+0x32/0x70
> =======>
> 00000001 0.000ms (+0.000ms): __spin_lock_irqsave (avc_has_perm_noaudit)
> 00000001 0.000ms (+0.000ms): __spin_lock_irqsave (<00000000>)
> 00000001 0.000ms (+0.204ms): avc_insert (avc_has_perm_noaudit)
> 00000001 0.204ms (+0.000ms): memcpy (avc_has_perm_noaudit)
> 00000001 0.204ms (+0.001ms): _spin_unlock_irqrestore (avc_has_perm_noaudit)

it seems a bit odd. avc_has_perm_noaudit() calls avc_insert(), and from
the entry to avc_insert(), to the memcpy() call done by
avc_has_perm_noaudit() there were 204 usecs spent. That's alot of time -
175 thousand cycles! Now if you check out the code between line 1009 and
1019 in security/selinux/avc.c, there's little that could cause this
amount of overhead. avc_insert() itself is rather simple - it does an
avc_claim_node() call which is an inlined function so it doesnt show up
in the trace. That function _might_ have called acv_reclaim_node() which
seems to do a linear scan over a list - i dont know how long that list
is typically but it could be long. Could you add "#define inline" near
the top of avc.c (but below the #include lines) so that we can see how
the overhead is distributed in the future?


> schedule
> ========
> 
> Have not talked about schedule in a while - this looks like something
> different than before. Appears to be some deep nesting of preempt
> disabling activities.

> ... gets even deeper nesting with the first value going up to 04010008
> while the system appears to send signals based on mouse input. None of
> the steps take very long, but with over 400 steps in the sequence it
> shows up in the trace record.

it could be tracing overhead - you've got inlining disabled in sched.c
(upon my request) and you've got the extra lines you added to find out
where the overhead is. Now that we know that DMA was (is?) a big
contributor to the mystic latencies you might want to remove those.

	Ingo
