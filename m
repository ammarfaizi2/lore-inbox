Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUIIPc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUIIPc2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 11:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUIIPc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 11:32:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9908 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265887AbUIIPcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 11:32:15 -0400
Date: Thu, 9 Sep 2004 17:33:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Lee Revell <rlrevell@joe-job.com>, Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Message-ID: <20040909153330.GB16804@elte.hu>
References: <OF08E1ED49.F0799581-ON86256F09.0070E65F-86256F09.0070E6A7@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF08E1ED49.F0799581-ON86256F09.0070E65F-86256F09.0070E6A7@raytheon.com>
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


> >.... Please disable IDE DMA and see
> >what happens (after hiding the PIO IDE codepath via
> >touch_preempt_timing()).

here is a list of a couple of more or less independent ideas regarding
your latency problems. (Some of these i might have suggested before.)

1)

we talked about external SMM events (handled by BIOS code and not
influenced/disabled by Linux) being a possible source of these 'mystic'
latencies. In SMP systems, there's a good likelyhood that SMM's are only
executed on CPU#0.

one good way to exclude SMM as a possibility would be to switch the CPUs
in the test. When you start an RT CPU-intense task to do the latency
test, is that task bound to any particular CPU? If yes and it's CPU#1,
then could you bind it to CPU#0? That would shift almost all kernel
activities to CPU#1. Likewise, could you set the
/proc/irq/*/smp_affinity masks to be '2' for all interrupts - to handle
all IRQs on CPU#1.

but i dont expect SMMs as the source of these latencies. BIOS writers
are supposed to fix up the TSC in SMM handlers to make them as seemless
as possible. So seeing frequent 500+ usec SMMs with no TSC fixup seems
weird.

2)

the maxcpus=1 workload-only (non-latencytest) test should also give an
important datapoint: is this phenomenon caused by SMP?

3)

it would still be nice if you could try the tests on a different type of
SMP hardware, as i cannot reproduce your results on 3 different types of
SMP hardware. E.g. one of my testsystems is a dual 466 MHz Celeron
(Mendocino) box, and the biggest latencies very closely track the UP
results reported by others - the highest latency in an IO-intense
workload is 192 usecs. The box is using IDE DMA. This system is roughly
half as fast as your 800+ MHz P3 box. I also have tried tests on a dual
P4 and a dual P3 - both have maximum latencies below 100 usecs and never
produce traces in weird places like the scheduler or copy_page_ll.

4)

your previous experiments have shown that disabling DRI in X does not
eliminate these weird latencies. Another DMA agent is IDE, which you are
testing now via the PIO-mode experiment. There's a third DMA agent:
audio cards do DMA too, have you tried to eliminate the audio component
of the test? Isnt there a latencytest mode that doesnt use an audio card
but /dev/rtc? [or just running the workloads without running latencytest
should be ok too to trigger the latency traces.]

	Ingo
