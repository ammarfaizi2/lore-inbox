Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVIEHB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVIEHB1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 03:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVIEHB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 03:01:27 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:47868 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932262AbVIEHB0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 03:01:26 -0400
Date: Mon, 5 Sep 2005 12:30:53 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Con Kolivas <kernel@kolivas.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050905070053.GA7329@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050904201054.GA4495@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 01:10:54PM -0700, Nishanth Aravamudan wrote:
> First of all, and maybe this is just me, I think it would be good to
> make the dyn_tick_timer per-interrupt source, as opposed to each arch?

Nish, may be a good idea as it may make the code more cleaner (it will
remove the 'if (cpu_has_local_apic())' kind of code that is there
currently in x86). However note that ARM currently has 'handler' member also 
part of it, which is used to recover time and that has nothing to do with 
interrupt source. Unless there is something like John's TOD, we still
need to recover time in a arch-dependent fashion ..Where do you
propose to have that 'handler' member?


> Thus, for x86, we would have a dyn_tick_timer structure for the PIT,
> APIC, ACPI PM-timer and the HPET. These structures could be put in

Does the ACPI PM-timer support generating interrupts also? Same question
I have for HPET.

> arch-specific timer.c files (there currently is not one for x86, I
> believe). Then, at compilation time, the appropriate structure would be
> linked to the arch-generic code. That should make the arch-independent

I think this binding has to be done at run-time, instead of compile-time?
(since we may build in support for local APIC but not find one at run-time, in 
which case we have to fall back on PIT as interrupt source).

> code simple to implement (I do have some patches in the works, but it's
> slow going, right now, sorry). I think ARM and s390 could perhaps use
> this infrastructure as well?
> 
> Also, I am a bit confused by the use of "dynamic-tick" to describe these
> changes. To me, these are all NO_IDLE_HZ implementations, as they are
> only invoked from cpu_idle() (or their equivalent) routines. I know this
> is true of s390 and the x86 code, and I believe it is true of the ARM
> code? If it were dynamic-tick, I would think we would be adjusting the
> timer interrupt frequency continuously (e.g., at the end of
> __run_timers() and at every call to {add,mod,del}_timer()). I was
> working on a patch which did some renaming to no_idle_hz_timer, etc.,
> but it's mostly code churn :)

Yes, the name 'dynamic-tick' is misleading!

> Con, wrt to the x86 implementation, I think the max_skip field should be
> a member of the interrupt source (dyn_tick_timer) structure, as opposed
> to the state. This would require dyn_tick_reprogram_timer() to change

max_skip is dictated by two things - interrupt and the backing time source.
In case of Local APIC, it may allow for ticks to be skipped upto few tens of
seconds, but if we are using ACPI PM timer to recover time, then we can
really skip not more than what the 24-bit PM timer allows for recovering time.
(few seconds if I remember correctly). Do you agree?


> Also, what exactly the purpose of conditional_run_local_timers()? It
> seems identical to run_local_timers(), except you check for inequality
> before potentially raising the softirq. It seems like the conditional
> check in run_timer_softirq() [the TIMER_SOFTIRQ callback] will achieve
> the same thing? And, in fact, I think that conditional is always true?

Nish, that was just an optimization for not raising the softirq at all
if the CPU was woken up w/o having skipped any ticks (becasue
of some external interrupt).


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
