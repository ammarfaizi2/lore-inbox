Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbULIT7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbULIT7F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 14:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbULIT7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 14:59:05 -0500
Received: from mx1.elte.hu ([157.181.1.137]:48106 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261596AbULIT7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 14:59:00 -0500
Date: Thu, 9 Dec 2004 20:58:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041209195848.GC18840@elte.hu>
References: <OF737A0ECF.4ECB9A35-ON86256F65.006249D6@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF737A0ECF.4ECB9A35-ON86256F65.006249D6@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


on SMP, latencytest + all IRQ threads (and ksoftirqd) at prio 99 +
PREEMPT_RT is not comparable to PREEMPT_DESKTOP (with no IRQ threading).

The -RT kernel will 'split' hardirq and softirq workloads and migrate
them to different CPUs - giving them a higher total throughput. Also, on
PREEMPT_DESKTOP the IRQs will most likely go to one CPU only, and most
softirq processing will be concentrated on that CPU too. Furthermore, 
the -RT kernel will agressively distribute highprio RT tasks.

latencytest under your priority setup measures an _inverse_ scenario. (a
CPU hog executing at a lower priority than all IRQ traffic) I'd not be
surprised at all if it had higher latencies under -RT than under
PREEMPT_DESKTOP. It's not clear-cut which one 'wins' though: because
even this inverse scenario will have benefits in the -RT case: due to
SCHED_OTHER workloads not interfering with this lower-prio RT task as
much. But i'd expect there to be a constant moving of the 'benchmark
result' forward and backwards, even if -RT only improves things - this
is the nature of such an inverse priority setup.

so this setup generates two conflicting parameters which are inverse to
each other, and the 'sum' of these two parameters ends up fluctuating
wildly. Pretty much like the results you are getting. The two parameters
are: latency of the prio 30 task, and latency of the highprio tasks. The
better the -RT kernel gets, the better the prio 30 tasks's priorities
get relative to SCHED_OTHER tasks - but the worse they also get, due to
the better handling of higher-prio tasks. Where the sum ends, whether
it's a "win" or a "loss" depends on the workload, how much highprio
activity the lowprio threads generate, etc.

if you really want to put all IRQ traffic on the same priority level
then a fairer comparison would be to bind all IRQ (via smp_affinity) and
ksoftirq (via taskset) threads to CPU#0, and to bind latencytest's
CPU-loop to CPU#1. (and do the same in the PREEMPT_DESKTOP case)

	Ingo
