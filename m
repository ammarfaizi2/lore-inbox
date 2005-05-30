Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVE3TO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVE3TO5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 15:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVE3TNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 15:13:50 -0400
Received: from mx2.elte.hu ([157.181.151.9]:42713 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261697AbVE3TMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 15:12:36 -0400
Date: Mon, 30 May 2005 21:12:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Pekka Enberg <penberg@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM] Machine Freezes while Running Crossover Office
Message-ID: <20050530191214.GA15776@elte.hu>
References: <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org> <84144f0205052911202863ecd5@mail.gmail.com> <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org> <1117399764.9619.12.camel@localhost> <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org> <1117466611.9323.6.camel@localhost> <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org> <FC5325FE-7730-4A66-BDA8-B6C035E6276F@mac.com> <Pine.LNX.4.58.0505301120290.1876@ppc970.osdl.org> <Pine.LNX.4.58.0505301123050.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505301123050.1876@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Mon, 30 May 2005, Linus Torvalds wrote:
> > 
> > So it's either a kernel scheduling problem, or Crossover running with RT 
> > priority and screwing up.
> 
> Btw, crossover being screwed up and runnign with RT priority would 
> also explain why stracing it makes the problem go away - the tracing 
> will cause the RT process to halt at system calls and yield to the 
> tracer, which isn't RT.
> 
> Of course, the same goes for a scheduler bug, so it's not like this 
> proves anything one way or the other, but considering that others 
> aren't reporting this problem with other programs..

Pekka, if none of the previous methods helps in better debugging this, 
then one of the easiest ways to catch scheduler latency bugs (e.g.  
related to sync wakeups, etc.) would be to try the -RT tree.

It has a built-in kernel/scheduler tracer that gets started upon wakeup 
and is stopped when the task finally runs. If we lose a preemption 
somewhere then this kernel should catch it. The -RT tree is development 
code, but should work fine on most systems. Here's a QuickStart:

1)
 download the latest patch from http://redhat.com/~mingo/realtime-preempt/

2)
 patch your 2.6.12-rc5 tree with it

3)
 copy your usual .config into this tree and do 'make oldconfig' - just 
 accept the default options it offers, except for the following two 
 cases: when it says "Preemption Mode", pick #1:

  1. No Forced Preemption (Server) (PREEMPT_NONE) (NEW)

 when it asks:

 Interrupts-off critical section latency timing (CRITICAL_IRQSOFF_TIMING) 

 pick 'y'.

 when it asks:

  Latency tracing (LATENCY_TRACE) [N/y/?] (NEW) y

 pick 'y' too.

4) compile & install your kernel as ususal and reboot into it.

now you'll be running a kernel with tracing built-in. The kernel comes 
with the 'wakeup-timing' feature enabled by default, which can be
started via:

   echo 0 > /proc/sys/kernel/preempt_max_latency

after this point you should get the maximum scheduling latencies 
reported to the syslog:

 [root@saturn ~]# echo 0 > /proc/sys/kernel/preempt_max_latency
 [root@saturn ~]# dmesg | tail
 (          IRQ 17-776  |#0): new 1 us maximum-latency wakeup.
 (     ksoftirqd/0-2    |#0): new 1 us maximum-latency wakeup.
 (       kjournald-820  |#0): new 1 us maximum-latency wakeup.
 (          IRQ 14-781  |#0): new 3 us maximum-latency wakeup.
 (     ksoftirqd/0-2    |#0): new 3 us maximum-latency wakeup.
 (          IRQ 17-776  |#0): new 12 us maximum-latency wakeup.
 (          IRQ 17-776  |#0): new 36 us maximum-latency wakeup.
 (          IRQ 17-776  |#0): new 38 us maximum-latency wakeup.
 (          IRQ 17-776  |#0): new 40 us maximum-latency wakeup.
 (          IRQ 17-776  |#0): new 70 us maximum-latency wakeup.
 [root@saturn ~]#

the kernel function trace of the largest latency will be under 
/proc/latency_trace:

 [root@saturn ~]# cat /proc/latency_trace
 preemption latency trace v1.1.4 on 2.6.12-rc5-RT-V0.7.47-15
 --------------------------------------------------------------------
 latency: 3048 us, #471/471, CPU#0 | (M:server VP:0, KP:0, SP:1 HP:1 #P:1)
    -----------------
    | task: ksoftirqd/0-2 (uid:0 nice:-10 policy:0 rt_prio:0)
    -----------------

                 _------=> CPU#
                / _-----=> irqs-off
               | / _----=> need-resched
               || / _---=> hardirq/softirq
               ||| / _--=> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
    head-3704  0dn..    0us : try_to_wake_up (wake_up_process)
    head-3704  0dn..    0us : try_to_wake_up <<...>-2> (6a 75):
    head-3704  0dn..    0us : wake_up_process (do_softirq)
    head-3704  0dn..    0us+< (608)
     cat-3709  0dnh.   46us+: do_nmi (memcpy)
     cat-3709  0dnh.   48us+: profile_hit (nmi_watchdog_tick)
     cat-3709  0dnh.  148us+: do_nmi (memcpy)
     cat-3709  0dnh.  150us+: profile_hit (nmi_watchdog_tick)
     cat-3709  0dn..  182us : smp_apic_timer_interrupt (c01b3b35 0 0)
     cat-3709  0dnh.  182us : irq_exit (apic_timer_interrupt)
     cat-3709  0dn..  182us : do_softirq (apic_timer_interrupt)
     cat-3709  0dn..  182us : __do_softirq (do_softirq)
     cat-3709  0dn..  183us+< (608)
     cat-3709  0dnh.  251us : do_nmi (memcpy)
  [...]

(if you have the APIC code and the NMI watchdog enabled then you'll also 
get a trace of userspace code looping in irqs-off sections.)

at this point try to reproduce the X hang. Do you get any large 
(3000-5000 usecs) latency reported? (assuming you can reproduce the hang 
under the -RT kernel)

(if you dont get any large latency reported by the tracer but the hangs 
still happen then there's still a way to get this debugged, by running 
the tracer in a free-running manually-triggered mode - i'll tell more 
about this if it becomes necessary.)

	Ingo
