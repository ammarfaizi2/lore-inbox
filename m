Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbVL3Nfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVL3Nfl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 08:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVL3Nfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 08:35:41 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:26606 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751261AbVL3Nfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 08:35:40 -0500
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
From: Daniel Walker <dwalker@mvista.com>
To: kus Kusche Klaus <kus@keba.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <AAD6DA242BC63C488511C611BD51F36732330D@MAILIT.keba.co.at>
References: <AAD6DA242BC63C488511C611BD51F36732330D@MAILIT.keba.co.at>
Content-Type: multipart/mixed; boundary="=-E3jCdCW09dCqTRwCrDQq"
Date: Fri, 30 Dec 2005 05:35:38 -0800
Message-Id: <1135949739.32431.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-E3jCdCW09dCqTRwCrDQq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


It looks like in ARM the cpu_idle() (and default_idle) get traced . So
for instance you'll get a situation when preemption is off, interrupts
are off, and then the cpu runs something like halt on x86. Then an
interrupt wakes up the cpu. 

I attached a patch that might fix the tracing. I tried to prevent the
tracing around when the cpu halts.

Daniel


On Fri, 2005-12-30 at 13:40 +0100, kus Kusche Klaus wrote:
> > From: Ingo Molnar
> > there seem to be leaked preempt counts:
> > 
> >   <idle>-0     0.n.1 8974us : touch_critical_timing (cpu_idle)
> > 
> > we should never have preemption disabled in cpu_idle(). To 
> > debug leaked 
> > preemption counts, enable CONFIG_DEBUG_PREEMPT.
> 
> Something really fishy is going on here: 
> That 9 ms latency seems to be really *idle* time!
> 
> * If the box is idle, I get that trace almost immediately, and
> almost always with close to 9 ms (system clock is 100 Hz, 
> i.e. 10 ms tick period).
> 
> * If the box is 100 % loaded, I don't get that trace. I get
> different traces from different processes, mostly shorter than
> 9 ms.
> 
> * If I load the box with work at regular intervals 
> and idle time in between, I get traces
> identical to the 9 ms idle trace, but consistently shorter.
> If I throw a flood ping with 1000 pkt/s against my box, the idle
> trace shows up with 800 or 900 microseconds, i.e. the idle time
> between packets.
> 
> Now, is the tracer wrong, or has the idle time a wrong status?
> 
> By the way, I had one trace today where the cat /proc/latency_trace
> itself showed up:
> 
>       \   /    |||||   \   |   /           
>      cat-3129  0D...    1us!: preempt_schedule_irq (svc_preempt)
>      cat-3129  0.... 5502us+: rt_up (l_start)
>      cat-3129  0D..1 5511us+: check_raw_flags (rt_up)
>      cat-3129  0...1 5514us+: rt_up (l_start)
>      cat-3129  0...1 5518us : sub_preempt_count_ti (rt_up)
> 
> What's happening in those 5 ms?
> 

--=-E3jCdCW09dCqTRwCrDQq
Content-Disposition: attachment; filename=fix_tracing_arm_idle_loop.patch
Content-Type: text/x-patch; name=fix_tracing_arm_idle_loop.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6.14/arch/arm/kernel/process.c
===================================================================
--- linux-2.6.14.orig/arch/arm/kernel/process.c
+++ linux-2.6.14/arch/arm/kernel/process.c
@@ -89,12 +89,12 @@ void default_idle(void)
 	if (hlt_counter)
 		cpu_relax();
 	else {
-		raw_local_irq_disable();
+		__raw_local_irq_disable();
 		if (!need_resched()) {
 			timer_dyn_reprogram();
 			arch_idle();
 		}
-		raw_local_irq_enable();
+		__raw_local_irq_enable();
 	}
 }
 
@@ -121,8 +121,10 @@ void cpu_idle(void)
 		if (!idle)
 			idle = default_idle;
 		leds_event(led_idle_start);
+		__preempt_enable_no_resched();
 		while (!need_resched())
 			idle();
+		preempt_disable();
 		leds_event(led_idle_end);
 		__preempt_enable_no_resched();
 		__schedule();

--=-E3jCdCW09dCqTRwCrDQq--

