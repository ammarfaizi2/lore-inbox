Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbUKKNm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbUKKNm0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 08:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbUKKNm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 08:42:26 -0500
Received: from mx1.elte.hu ([157.181.1.137]:7611 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262225AbUKKNmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 08:42:20 -0500
Date: Thu, 11 Nov 2004 15:44:14 +0100
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
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-0
Message-ID: <20041111144414.GA8881@elte.hu>
References: <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109160544.GA28242@elte.hu>
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


i have released the -V0.7.25-0 Real-Time Preemption patch, which can be
downloaded from the usual place:

    http://redhat.com/~mingo/realtime-preempt/

this release includes fixes, new features and latency improvements.

the biggest change is the threading of the lone remaining non-threaded
external interrupt: the timer interrupt (IRQ#0).

It was not threaded until now because unlike device interrupts the timer
interrupt is quite deeply attached to Linux's architecture, driving
process timing, profiling and the scheduler. I separated these into
stuff that can be done from a thread context and stuff that needs to
execute directly.

Fortunately most of the expensive and latency-generating stuff could be
pushed into the irq thread. As a side-effect this enabled the turning of
rtc_lock and xtime_lock into a mutex. Also, it removed some ugly hacks
from rtc.c and should improve worst-case latencies.

the other bigger change is the reworking of the .config space. Instead
of the deep hierarchy of hard-to-understand technical PREEMPT options,
there's now a flattened out choice of 4 preemption models:

                ( ) No Forced Preemption (Server)
                ( ) Voluntary Kernel Preemption (Desktop)
                ( ) Preemptible Kernel (Low-Latency Desktop)
                (X) Complete Preemption (Real-Time)

and updated help texts. Plus for the preemption models where it can be
freely turned off, softirq and hardirq threading is an additional
option.

the third bigger change is the reworking of the tracer to make it easier
to drive it from user-space. There are 3 runtime flags now:

 /proc/sys/kernel/trace_enabled           (default: 1)
 /proc/sys/kernel/trace_user_triggered    (default: 0)
 /proc/sys/kernel/trace_freerunning       (default: 0)

semantics of user-triggered tracing: if enabled then any active tracing
of wakeup and/or critical sections stops and userspace drives start/stop
events via gettimeofday(0,1)/gettimeofday(0,0). The latter saves the
current trace into /proc/latency_trace, the former clears the trace
buffer and starts tracing anew. Doing another gettimeofday(0,1) on an
already running tracer clears the trace and restarts it without saving
the current trace into /proc/latency_trace. Doing a gettimeofday(0,0) on
an already stopped tracer has no effect (i.e. /proc/latency_trace wont
be saved a second time). The tracer does timing for userspace
automatically the same way it does it for the built-in timing
mechanisms, and it can be configured via the preempt_max_latency and
preempt_tresh tunables.

also, wakeup-timing, irq-off and preempt-off critical section timing can
now be done at once again, the /proc/sys/kernel/preempt_wakeup_timing
flag switches between the modes. (default: 1)

other changes since -V0.7.24:

 - debug feature: added the RTC-debug patch sanitized by K.R. Foley,
   plus further cleanups.

 - added upstream fix for kobject related crash, pointed out by Shane 
   Shrybman.

 - cleanup: Kconfig help text fixes from Amit Shah

 - latency improvement: on UP-IOAPIC, when redirecting an interrupt, do
   not ack the APIC. This is the method used for direct interrupts and
   on UP it might as well work out fine. It is certainly faster than
   masking/unmasking, making UP-IOAPIC the fastest PIC mode again.

 - livelock fix: the timer-irq threading unearthed a seqlock related
   livelock scenario, which triggered in do_gettimeoffset() big-time. 
   The solution is to serialize seqlock readers with writers _iff_ the 
   seqlock status is 'invalid'. This is a rare event, but when it
   happens it saves the day.

 - debugging helper: the /proc/sys/kernel/debug_direct_keyboard flag 
   (default: 0) will hack the keyboard IRQ into being direct. NOTE: the 
   keyboard in this mode should only be used to access SysRq 
   functionality that is not possible via the threaded keyboard handler. 
   The direct keyboard IRQ can crash the system.

 - new kernel profiling features: added profile=preempt to profile 
   whether interrupts hit the kernel in preemptible mode or in a 
   critical section. Added /proc/sys/kernel/prof_pid to profile a
   specific PID only. (default: -1, meaning all tasks profiled) Added
   /proc/irq/prof_cpu_mask back.

 - robustness improvement: do not report atomicity-warnings during
   kernel oopses - it's more important to get the oops out to the
   console.

to create a -V0.7.25-0 tree from scratch, the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc1.bz2
   http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/2.6.10-rc1-mm3.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc1-mm3-V0.7.25-0

	Ingo
