Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268314AbUIBNhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268314AbUIBNhU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 09:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268315AbUIBNhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 09:37:19 -0400
Received: from mx1.elte.hu ([157.181.1.137]:17054 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268314AbUIBNgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 09:36:52 -0400
Date: Thu, 2 Sep 2004 15:37:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>,
       Thomas Charbonnel <thomas@undata.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q7
Message-ID: <20040902133743.GA9096@elte.hu>
References: <OF4A93C101.C3FFA1E6-ON86256F03.004851E5@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF4A93C101.C3FFA1E6-ON86256F03.004851E5@raytheon.com>
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

> >In any case, please enable nmi_watchdog=1 so that we can see (in -Q7)
> >what happens on the other CPUs during such long delays.
> 
> Booted with nmi_watchdog=1, saw the kernel message indicating that
> NMI was checked OK.
> 
> The first trace looks something like this...
> 
> latency 518 us, entries: 79
> ...
> started at schedule+0x51/0x740
> ended at schedule+0x337/0x740
> 
> 00000001 0.000ms (+0.000ms): schedule (io_schedule)
> 00000001 0.000ms (+0.000ms): sched_clock (schedule)
> 00010001 0.478ms (+0.478ms): do_nmi (sched_clock)
> 00010001 0.478ms (+0.000ms): do_nmi (<08049b21>)
> 00010001 0.482ms (+0.003ms): profile_tick (nmi_watchdog_tick)
> ...
> and a few entries later ends up at do_IRQ (sched_clock).
> 
> The second trace goes from dequeue_task to __switch_to with a
> similar pattern - the line with do_nmi has +0.282ms duration and
> the line notifier_call_chain (profile_hook) as +0.135ms duration.
> 
> I don't see how this provides any additional information but will
> provide several additional traces when the test gets done in a few
> minutes.

thanks. The NMI gives us two kinds of information, both useful:

 - if the ratio of do_nmi()'s within such a section roughly matches the
   number of NMIs we'd expect during the sum of these sections then it 
   means that the delay is most likely wall-clock time and not some
   measurement artifact (RDTSC artifact or tracing bug). The NMI's are
   triggered (indirectly) by the PIT and the PIT is an independent clock
   that has a frequency that is independent of the rest of the system
   (independent of the CPU clock, DMA activities, IRQ load, etc.)

   since most of the codepaths in question (the scheduler's
   dequeue_task(), etc.) run with interrupts disabled the normal timer
   interrupts (smp_apic_timer_interrupt() and do_IRQ(00000000)) cannot 
   'sample' this codepath. Only the NMI can interrupt these codepaths.

 - the NMIs also sample what happens on the other CPU. In your above 
   trace this gives:

   > 00010001 0.478ms (+0.478ms): do_nmi (sched_clock)
   > 00010001 0.478ms (+0.000ms): do_nmi (<08049b21>)

   the other CPU was executing userspace code during the last NMI tick - 
   i.e. nothing that could be suspect. 'suspect' code would be some sort 
   kernel code that could in theory interact with this CPU's scheduler 
   code.

   this too is statistical sampling so we'll need as much of these 
   traces as possible.

some wacky guess based on the above single sampling point: it seems the
delays are real wall-clock delays, and the only thing matching the
theory so far is that DMA traffic on the memory bus somehow stalls this
CPU's memory traffic for up to 500 usecs. How could userspace running on
CPU#0 impact the kernel's scheduler code on CPU#1?

	Ingo
