Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbUKIPE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbUKIPE0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 10:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbUKIPEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 10:04:25 -0500
Received: from mx2.elte.hu ([157.181.151.9]:54243 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261550AbUKIPED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 10:04:03 -0500
Date: Tue, 9 Nov 2004 17:05:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
Message-ID: <20041109160544.GA28242@elte.hu>
References: <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108165718.GA7741@elte.hu>
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


i have released the -V0.7.23 Real-Time Preemption patch, which can be
downloaded from the usual place:

    http://redhat.com/~mingo/realtime-preempt/

this release includes fixes, development/debugging improvements and
latency improvements and other speedups.

the biggest change is the reworked timing/tracing framework. Wakeup
timing became a compile-time thing and can be selected independently of
the preemption mode - i.e. it can now be used on near-vanilla !PREEMPT
kernels too, providing good wakeup-latency comparison of the various
preemption models.

irqs-off and preempt-off critical section timing/tracing can be selected
if wakeup timing is disabled, the two options can be selected separately
or together as well.

another improvement is that wakeup-timing now works correctly on SMP too
- the tracer 'follows' the highest-priority task in the system as it
gets bounced between CPUs and always traces the CPU where the task is
pending.

other changes since -V0.7.22:

 - semaphore livelock fix: feedback from Mark H. Johnson pinpointed a 
   bug in the down_trylock() semaphore code: if preempted in the wrong
   moment a lower-prio task could cause a higher-prio task to livelock
   indefinitely. This fix could solve the 'keventd looping' problem 
   reported by Mark.

   the fix is to make the down_trylock() code a bit simpler, but this
   also introduces the potential for down_trylock() to get 'spurious' 
   locking-rejects. Hopefully this wont be a big problem - we dont 
   really guarantee that down_trylock() succeeds - but code using higher
   semaphore counts to track resources could be negatively impacted by
   this. We'll see.

 - console assert fix: implemented a different type of fbcon
   RT-preemption handling variant, this could solve the assert reported
   by Amit Shah.

 - debugging improvement: implemented a sequence counter for max latency 
   traces. This has the advantage of solving the 'slow console on SMP
   problem': the latency-timing code used to get confused by another CPU 
   printing a timing message to a slow console and thus delaying that 
   other CPU. Now any latency that gets generated while a maximum is 
   printed is skipped.

 - further shrunk the non-debug size of struct rt_mutex by moving the 
   save_state logic into the debug paths - size is now 4 machine-words.

 - fixed CONFIG_HIGHMEM latencies: all atomic-kmap APIs are now wrapped 
   seemlessly and in a preemptible way.

 - implemented an IO-APIC register cache to speed up the IRQ-redirection
   latency hotpath. Also, made the POST flush a bit faster.

 - disable KGDB if PREEMPT_RT - it's broken for now.

 - move some runtime checks to under DEBUG_PREEMPT - this speeds up 
   CRITICAL_PREEMPT_TIMING.

to create a -V0.7.23 tree from scratch, the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc1.bz2
   http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/2.6.10-rc1-mm3.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc1-mm3-V0.7.23

	Ingo
