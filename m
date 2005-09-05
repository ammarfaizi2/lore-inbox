Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVIEQ7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVIEQ7F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVIEQ7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:59:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:60821 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932334AbVIEQ7D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:59:03 -0400
Date: Mon, 5 Sep 2005 09:57:30 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Con Kolivas <kernel@kolivas.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>, johnstul@us.ibm.com
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050905165730.GI25856@us.ibm.com>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050905070053.GA7329@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905070053.GA7329@in.ibm.com>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.09.2005 [12:30:53 +0530], Srivatsa Vaddagiri wrote:
> On Sun, Sep 04, 2005 at 01:10:54PM -0700, Nishanth Aravamudan wrote:
> > First of all, and maybe this is just me, I think it would be good to
> > make the dyn_tick_timer per-interrupt source, as opposed to each arch?
> 
> Nish, may be a good idea as it may make the code more cleaner (it will
> remove the 'if (cpu_has_local_apic())' kind of code that is there
> currently in x86).

Yes, exactly. I think those kind of interrupt-source specific code can
be handled by the interrupt-source :)

> However note that ARM currently has 'handler' member also part of it,
> which is used to recover time and that has nothing to do with
> interrupt source. Unless there is something like John's TOD, we still
> need to recover time in a arch-dependent fashion ..Where do you
> propose to have that 'handler' member?

I think it's ok where it is. Currently, with x86, at least, you can have
an independent interrupt source and time source (not true for all archs,
of course, ppc64 being a good example, I think?) Perhaps "handler"
should be called arch_recover_time() and may point to a timesource
function (currently PIT/TSC/ACPI_PM/HPET on x86, right?) which does the
appropriate catch-up for the time-related variables. In any case, since
most of the timesource code is lost-tick aware, I think it is possible.

> > Thus, for x86, we would have a dyn_tick_timer structure for the PIT,
> > APIC, ACPI PM-timer and the HPET. These structures could be put in
> 
> Does the ACPI PM-timer support generating interrupts also? Same question
> I have for HPET.

I think, as you figured out, the HPET can, but the ACPI_PM can not. John
might know for sure (I always end up asking him), have added him to the
Cc.

> 
> > arch-specific timer.c files (there currently is not one for x86, I
> > believe). Then, at compilation time, the appropriate structure would be
> > linked to the arch-generic code. That should make the arch-independent
> 
> I think this binding has to be done at run-time, instead of
> compile-time?  (since we may build in support for local APIC but not
> find one at run-time, in which case we have to fall back on PIT as
> interrupt source).

What may be useful is something similar to what John Stultz does in his
rework, attaching priorities to the various interrupt sources. For
example, on x86, if we have an HPET, then we should use it, if not, then
use APIC and PIT, but if the APIC doesn't exist in h/w, or is buggy
(perhaps determined via a calibration loop), then only use the PIT.

> > code simple to implement (I do have some patches in the works, but it's
> > slow going, right now, sorry). I think ARM and s390 could perhaps use
> > this infrastructure as well?
> > 
> > Also, I am a bit confused by the use of "dynamic-tick" to describe these
> > changes. To me, these are all NO_IDLE_HZ implementations, as they are
> > only invoked from cpu_idle() (or their equivalent) routines. I know this
> > is true of s390 and the x86 code, and I believe it is true of the ARM
> > code? If it were dynamic-tick, I would think we would be adjusting the
> > timer interrupt frequency continuously (e.g., at the end of
> > __run_timers() and at every call to {add,mod,del}_timer()). I was
> > working on a patch which did some renaming to no_idle_hz_timer, etc.,
> > but it's mostly code churn :)
> 
> Yes, the name 'dynamic-tick' is misleading!

Especially, to me, as the .config option is NO_IDLE_HZ. I prefer
referring to everything as interrupt_source or something similar, I
think (after looking more at the code), then it doesn't matter whether
it is being used for (what is technically) NO_IDLE_HZ or dynamic-tick.

> > Con, wrt to the x86 implementation, I think the max_skip field should be
> > a member of the interrupt source (dyn_tick_timer) structure, as opposed
> > to the state. This would require dyn_tick_reprogram_timer() to change
> 
> max_skip is dictated by two things - interrupt and the backing time source.
> In case of Local APIC, it may allow for ticks to be skipped upto few tens of
> seconds, but if we are using ACPI PM timer to recover time, then we can
> really skip not more than what the 24-bit PM timer allows for recovering time.
> (few seconds if I remember correctly). Do you agree?

I agree. I guess max_skip, to me, is what the kernel thinks the
interrupt source should maximally skip by, not what the interrupt source
thinks it can do. So, I think it fits in fine with what you are saying
and with the code you have in the current patch.

> > Also, what exactly the purpose of conditional_run_local_timers()? It
> > seems identical to run_local_timers(), except you check for
> > inequality before potentially raising the softirq. It seems like the
> > conditional check in run_timer_softirq() [the TIMER_SOFTIRQ
> > callback] will achieve the same thing? And, in fact, I think that
> > conditional is always true?
> 
> Nish, that was just an optimization for not raising the softirq at all
> if the CPU was woken up w/o having skipped any ticks (becasue of some
> external interrupt).

I was just wondering; I guess it makes sense, but did you check to see
if it ever *doesn't* get called? Like I said, __run_timers() [from how I
understand it], will always increment base->timer_jiffies to one more
than jiffies. So if we disable interrupts and come right back, that
conditional is still true, but time_after_eq(jiffies,
base->timer_jiffies) [the condition in run_timer_softirq()] is not. How
much does it cost to raise the softirq, if it is going to return
immediately from the callback?

Thanks,
Nish
