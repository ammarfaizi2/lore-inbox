Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbUKKPJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbUKKPJm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 10:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbUKKPIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 10:08:01 -0500
Received: from mail8.spymac.net ([195.225.149.8]:42388 "EHLO mail8")
	by vger.kernel.org with ESMTP id S262243AbUKKPDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 10:03:45 -0500
Message-ID: <41938D60.4070802@spymac.com>
Date: Thu, 11 Nov 2004 17:03:44 +0100
From: Gunther Persoons <gunther_persoons@spymac.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-0
References: <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu>
In-Reply-To: <20041111144414.GA8881@elte.hu>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>i have released the -V0.7.25-0 Real-Time Preemption patch, which can be
>downloaded from the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>
>this release includes fixes, new features and latency improvements.
>
>the biggest change is the threading of the lone remaining non-threaded
>external interrupt: the timer interrupt (IRQ#0).
>
>It was not threaded until now because unlike device interrupts the timer
>interrupt is quite deeply attached to Linux's architecture, driving
>process timing, profiling and the scheduler. I separated these into
>stuff that can be done from a thread context and stuff that needs to
>execute directly.
>
>Fortunately most of the expensive and latency-generating stuff could be
>pushed into the irq thread. As a side-effect this enabled the turning of
>rtc_lock and xtime_lock into a mutex. Also, it removed some ugly hacks
>from rtc.c and should improve worst-case latencies.
>
>the other bigger change is the reworking of the .config space. Instead
>of the deep hierarchy of hard-to-understand technical PREEMPT options,
>there's now a flattened out choice of 4 preemption models:
>
>                ( ) No Forced Preemption (Server)
>                ( ) Voluntary Kernel Preemption (Desktop)
>                ( ) Preemptible Kernel (Low-Latency Desktop)
>                (X) Complete Preemption (Real-Time)
>
>and updated help texts. Plus for the preemption models where it can be
>freely turned off, softirq and hardirq threading is an additional
>option.
>
>the third bigger change is the reworking of the tracer to make it easier
>to drive it from user-space. There are 3 runtime flags now:
>
> /proc/sys/kernel/trace_enabled           (default: 1)
> /proc/sys/kernel/trace_user_triggered    (default: 0)
> /proc/sys/kernel/trace_freerunning       (default: 0)
>
>semantics of user-triggered tracing: if enabled then any active tracing
>of wakeup and/or critical sections stops and userspace drives start/stop
>events via gettimeofday(0,1)/gettimeofday(0,0). The latter saves the
>current trace into /proc/latency_trace, the former clears the trace
>buffer and starts tracing anew. Doing another gettimeofday(0,1) on an
>already running tracer clears the trace and restarts it without saving
>the current trace into /proc/latency_trace. Doing a gettimeofday(0,0) on
>an already stopped tracer has no effect (i.e. /proc/latency_trace wont
>be saved a second time). The tracer does timing for userspace
>automatically the same way it does it for the built-in timing
>mechanisms, and it can be configured via the preempt_max_latency and
>preempt_tresh tunables.
>
>also, wakeup-timing, irq-off and preempt-off critical section timing can
>now be done at once again, the /proc/sys/kernel/preempt_wakeup_timing
>flag switches between the modes. (default: 1)
>
>other changes since -V0.7.24:
>
> - debug feature: added the RTC-debug patch sanitized by K.R. Foley,
>   plus further cleanups.
>
> - added upstream fix for kobject related crash, pointed out by Shane 
>   Shrybman.
>
> - cleanup: Kconfig help text fixes from Amit Shah
>
> - latency improvement: on UP-IOAPIC, when redirecting an interrupt, do
>   not ack the APIC. This is the method used for direct interrupts and
>   on UP it might as well work out fine. It is certainly faster than
>   masking/unmasking, making UP-IOAPIC the fastest PIC mode again.
>
> - livelock fix: the timer-irq threading unearthed a seqlock related
>   livelock scenario, which triggered in do_gettimeoffset() big-time. 
>   The solution is to serialize seqlock readers with writers _iff_ the 
>   seqlock status is 'invalid'. This is a rare event, but when it
>   happens it saves the day.
>
> - debugging helper: the /proc/sys/kernel/debug_direct_keyboard flag 
>   (default: 0) will hack the keyboard IRQ into being direct. NOTE: the 
>   keyboard in this mode should only be used to access SysRq 
>   functionality that is not possible via the threaded keyboard handler. 
>   The direct keyboard IRQ can crash the system.
>
> - new kernel profiling features: added profile=preempt to profile 
>   whether interrupts hit the kernel in preemptible mode or in a 
>   critical section. Added /proc/sys/kernel/prof_pid to profile a
>   specific PID only. (default: -1, meaning all tasks profiled) Added
>   /proc/irq/prof_cpu_mask back.
>
> - robustness improvement: do not report atomicity-warnings during
>   kernel oopses - it's more important to get the oops out to the
>   console.
>
>to create a -V0.7.25-0 tree from scratch, the patching order is:
>
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc1.bz2
>   http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/2.6.10-rc1-mm3.bz2
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc1-mm3-V0.7.25-0
>
>	Ingo
>
>  
>
Got 2 times a hard lock up with this one. Happened while i was typing 
something and downloading both after 15-20 minutes.
