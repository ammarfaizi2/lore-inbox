Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVIGRXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVIGRXT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVIGRXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:23:19 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:47293 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751140AbVIGRXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:23:19 -0400
Date: Wed, 7 Sep 2005 10:23:15 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Tony Lindgren <tony@atomide.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050907172315.GB22849@us.ibm.com>
References: <20050904201054.GA4495@us.ibm.com> <20050904212616.B11265@flint.arm.linux.org.uk> <20050905053225.GA4294@in.ibm.com> <20050905054813.GC25856@us.ibm.com> <20050905063229.GB4294@in.ibm.com> <20050905064416.GD25856@us.ibm.com> <20050906205112.GA3038@us.ibm.com> <20050907081303.GC5804@atomide.com> <20050907155352.GD4590@us.ibm.com> <20050907170703.GA28387@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050907170703.GA28387@in.ibm.com>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.2005 [22:37:03 +0530], Srivatsa Vaddagiri wrote:
> On Wed, Sep 07, 2005 at 08:53:52AM -0700, Nishanth Aravamudan wrote:
> > 
> > - include/linux/timer.h
> > 	with definitions in kernel/timer.c
> > 
> > OR better in
> > - include/linux/ticksource.h
> > 	with definitions in kernel/ticksource.c?
> 
> > 
> > #define DYN_TICK_ENABLED	(1 << 1)
> > #define DYN_TICK_SUITABLE	(1 << 0)
> > 
> > #define DYN_TICK_MIN_SKIP	2

Another point. Why is this 2? I guess if you're going to make it 2, why
bother defining/checking it at all?

> > /* Abstraction of a tick source
> 
> I think "tick source" probably doesn't bring out the fact that we are
> also dealing with more than tick source here (@recover_time and 
> @set_all_cpus_idle). From this perspective, I feel that the original 
> 'dyn_tick_timer' name itself was better (atleast it captures the 
> 'dynamic' nature of ticks).

Yes, maybe you are right. dyn_tick_source, maybe?

> >  * @state: current state
> >  * @max_skip: current maximum number of ticks to skip
> >  * @init: initialization routine
> >  * @enable_dyn_tick: called via sysfs to enable interrupt skipping
> >  * @disable_dyn_tick: called via sysfs to disable interrupt
> >  * 				skipping
> >  * @set_all_cpus_idle: last cpu to go idle calls this, which should
> >  * 				disable any timesource (e.g. PIT on x86)
> >  * @recover_time: handler for returning from skipped ticks and keeping
> >  * 				time consistent
> >  */
> > struct tick_source {
> > 	unsigned int state;
> > 	unsigned long max_skip;
> > 	int (*init) (void);
> > 	void (*enable_dyn_tick) (void);
> > 	void (*disable_dyn_tick) (void);
> > 	unsigned long (*reprogram) (unsigned long); /* return number of ticks skipped */
> 
> How will it be able to return the number of ticks skipped? Or are you
> referring to max_skip here?

Yes, maybe this can be a void function... I was thinking more along the
lines of you can send whatever request you want to reprogram(), it does
what it can with the request (cuts it short if too long, ignores it if
too short) and then returns what it actually did.

> > 	unsigned long (*recover_time) (int, void *, struct pt_regs *); /* handler in arm */
> > 	/* following empty in UP */
> > 	void (*set_all_cpus_idle) (int);
> 
> Does 'set' in 'set_all_cpus_idle' signify anything?

It is the callback for the architecture when the last CPU goes locally
idle, so then system-wide idle code can be placed here (disable PIT on
x86). The name maybe wrong, though, you are right.

> > 	spinlock_t lock;
> 
> I think the 'lock' fits in nicely here.
> 
> > };
> > 
> > extern void tick_source_register(struct tick_source *new_tick_source);
> 
> I tend to prefer the original interface - dyn_tick_register - itself (since 
> as I said it captures the dynamic nature of the timer).
> 
> > extern struct tick_source *current_ticksource;
> 
> In x86-like architectures, there can be multiple ticksources that can
> be simultaneously active - ex: APIC and PIT. So one
> "current_ticksource" doesnt capture that fact?

Not really, though, right? Only one is registered to do the timer
callbacks? So, for x86, if you use the PIT ticksource, you only need to
be PIT aware, but if you use the APIC ticksource, then it needs to be
aware of the APIC and PIT (I believe you mentioned they are tied to each
other), but that's ticksource-specific. CMIIW, though, please.

> > #ifdef CONFIG_NO_IDLE_HZ /* which means CONFIG_DYNTICK is also on */
> > extern void set_tick_max_skip(unsigned long max_skip);
> > /* idle_reprogram_tick calls reprogram_tick calls current_ticksource->reprogram()
> >  * do we really need the first step? */
> 
> If 'idle_reprogram_tick' is the equivalent of 'idle_reprogram_timer' that is 
> in the latest patch published by Con, then I think we can avoid the first step 
> yes.

Yes, exactly.

> > extern void idle_reprogram_tick(void);
> > /* return number of ticks skipped, potentially for accounting purposes? */
> > extern unsigned long reprogram_tick(void);
> > 
> > extern struct tick_source * __init arch_select_tick_source(void);
> > extern void __init dyn_tick_init(void); /* calls select_tick_source(), verifies source is usable, then calls tick_source_register() */
> 
> I presume dyn_tick_init will be in arch-independent code. In that
> case, how does it "verify" that the source is usable? Seems like we
> need arch-hooks for this as well?

hrm, you are right. So then maybe the "usable" checks should be pushed
into arch_select_tick_source()?

<snip>

> > - sched.c / sched.h
> > 	/* do we want these elsewhere? */
> > 	cpumask_t no_idle_hz_cpumask;
> 
> Could be moved to timer.h/c?

Yes, that's what I was thinking. I just wasn't sure if there was a
specific reason for keeping them in sched.h/.c.

> > - each arch-specific file pair needs to provide:
> > 	arch_select_tick_source();
> > 	appropriate struct tick_source definitions, functions, etc.
> > 
> > - include/asm-i386/timer.h /* or ticksource.h */
> > 	with defines in arch/i386/timer.c /* or ticksource.c */
> > 
> > - include/asm-arm/arch-omap/timer.h /* or ticksource.h */
> > 	with definitions in arch/arm/mach-omap/timer.c /* or ticksource.c */
> > 
> > - include/asm-s390/timer.h /* or ticksource.h */
> > 	with definitions in arch/s390/timer.c /* or ticksource.c */
> 
> I somehow consider that we can retain what currently exists -
> include/asm-i386/dyn-tick.h and arch/i386/kernel/dyn-tick.c ..  IMO
> current abstraction of 'dyn_tick_timer' is good enough to unify all
> the ports of no-idle-hz. We probably need to just iron out the
> differences between how ARM and x86 defines this.

Maybe you are right. I don't like having a separate struct for the
state, though, and the dyn_tick_timer struct doesn't have a
recover_time() style member. If you look closely, my structure is
basically exactly what the x86 work has, just some different names
(don't need arch_ prefix, for instance, because it's clearly
dyn_tick_timer specific, etc.) I also would like to hear from the s390
folks about their issues/opinions.

> As far as the problem of multiple interrupt sources (like APIC, PIT,
> HPET) is concerned, it can be completely handled by the architecture
> code itself and it appropriately sets the 'reprogram_timer' member to
> point to APIC, PIT or HPET reprogramming routines. That would also
> avoid the 'if (cpu_has_local_apic())' kind of code that exists now.

Yes, true. I'm wondering, do we need to make the
current_ticksource/current_dyn_tick_timer per-CPU? I am just wondering
how to gracefully handle the SMP case. Or is that not a problem?

Thanks,
Nish
