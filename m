Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVIDUiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVIDUiE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 16:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVIDUiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 16:38:04 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:40153 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751170AbVIDUiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 16:38:03 -0400
Date: Sun, 4 Sep 2005 13:37:55 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Con Kolivas <kernel@kolivas.org>, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050904203755.GA25856@us.ibm.com>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050904212616.B11265@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050904212616.B11265@flint.arm.linux.org.uk>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.09.2005 [21:26:16 +0100], Russell King wrote:
> On Sun, Sep 04, 2005 at 01:10:54PM -0700, Nishanth Aravamudan wrote:
> > I've got a few ideas that I think might help push Con's patch coalescing
> > efforts in an arch-independent fashion.
> 
> Note that ARM contains cleanups on top of Tony's original work, on
> which the x86 version is based.
> 
> Basically, Tony submitted his ARM version, we discussed it, fixed up
> some locking problems and simplified it (it contained multiple
> structures which weren't necessary, even in multiple timer-based systems).

Make sense. Thanks for the quick feedback!

> I'd be really surprised if any architecture couldn't use what ARM has
> today - in other words, this is the only kernel-side interface:
> 
> #ifdef CONFIG_NO_IDLE_HZ
> 
> #define DYN_TICK_SKIPPING       (1 << 2)
> #define DYN_TICK_ENABLED        (1 << 1)
> #define DYN_TICK_SUITABLE       (1 << 0)
> 
> struct dyn_tick_timer {
>         unsigned int    state;                  /* Current state */
>         int             (*enable)(void);        /* Enables dynamic tick */
>         int             (*disable)(void);       /* Disables dynamic tick */
>         void            (*reprogram)(unsigned long); /* Reprograms the timer */
>         int             (*handler)(int, void *, struct pt_regs *);
> };
> 
> void timer_dyn_reprogram(void);
> #else
> #define timer_dyn_reprogram()   do { } while (0)
> #endif

That looks great! So I guess I'm just suggesting moving this from
include/asm-arch/mach/time.h to arch-independent headers? Perhaps
timer.h is the best place for now, as it already contains the
next_timer_interrupt() prototype (which probably should be in the #ifdef
with timer_dyn_reprogram()).

> > First of all, and maybe this is just me, I think it would be good to
> > make the dyn_tick_timer per-interrupt source, as opposed to each arch?
> > Thus, for x86, we would have a dyn_tick_timer structure for the PIT,
> > APIC, ACPI PM-timer and the HPET. These structures could be put in
> > arch-specific timer.c files (there currently is not one for x86, I
> > believe).
> 
> Each timer source should have its own struct dyn_tick_timer.  On x86,
> maybe it makes sense having a pointer in the init_timer_opts or timer_opts
> structures?

Well, I know John Stultz is not a big fan of timer_opts, and is trying
to get rid of it :) timer_opts is supposed to be for timesources, I
believe, which are distinct from interrupt sources (e.g., TSC, Cyclone,
etc.), whereas I think dyn-tick is dealing with interrupt sources. I
guess if hardware (like the acpi_pm) can do both, there could be some
sort of inter-hooking.

> > I think ARM and s390 could perhaps use this infrastructure as well?
> 
> ARM already has a well thought-out encapsulation which is 100% suited to
> its needs - which are essentially the same as x86 - the ability to select
> one of several timer sources at boot time.
> 
> I would suggest having a good look at the ARM implementation.  See:
>  include/asm-arm/mach/time.h (bit quoted above)
>  arch/arm/kernel/irq.c (to update system time before calling any irq handler)
>  arch/arm/kernel/time.c (initialisation and sysfs interface, etc)
>  arch/arm/mach-sa1100/time.c, arch/arm/mach-pxa/time.c, and
>  arch/arm/mach-omap1/time.c (dyntick machine class implementations).

Yeah, I took a quick look before sending out my mail, but obviously need
to study it more. Thanks for the pointers! I guess that the time.h,
irq.c and time.c bits could all (or mostly) be done in arch-independent
code? I agree that your encapsulation seems to be suited to most arch's
use of NO_IDLE_HZ.

Overall, though, do you agree it would be best to have the common code
in a common file? If so, I'll work harder on getting some patches out.

Thanks,
Nish
