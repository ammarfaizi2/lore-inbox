Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVIDULE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVIDULE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 16:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVIDULE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 16:11:04 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:15584 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751098AbVIDULB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 16:11:01 -0400
Date: Sun, 4 Sep 2005 13:10:54 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050904201054.GA4495@us.ibm.com>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509031814.49666.kernel@kolivas.org>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.09.2005 [18:14:48 +1000], Con Kolivas wrote:
> On Sat, 3 Sep 2005 18:06, Russell King wrote:
> > On Sat, Sep 03, 2005 at 06:01:08PM +1000, Con Kolivas wrote:
> > > On Sat, 3 Sep 2005 17:58, Russell King wrote:
> > > > On Sat, Sep 03, 2005 at 04:13:10PM +1000, Con Kolivas wrote:
> > > > > Noone's ignoring you.
> > > > >
> > > > > What we need to do is ensure that dynamic ticks is working properly
> > > > > on x86 and worth including before anything else. If and when we
> > > > > confirm this it makes sense only then to try and merge code from the
> > > > > other 2 architectures to as much common code as possible as no doubt
> > > > > we'll be modifying other architectures we're less familiar with. At
> > > > > that stage we will definitely want to tread even more cautiously at
> > > > > that stage.
> > > >
> > > > dyntick has all the hallmarks of ending up another mess just like the
> > > > "generic" (hahaha) irq stuff in kernel/irq - it's being developed in
> > > > precisely the same way - by ignore non-x86 stuff.
> > > >
> > > > I can well see that someone will say "ok, this is ready, merge it"
> > > > at which point we then end up with multiple differing userspace
> > > > methods of controlling it depending on the architecture, but
> > > > multiple differing kernel interfaces as well.
> > > >
> > > > Indeed, you seem to be at the point where you'd like akpm to merge
> > > > it.  That sets alarm bells ringing if you haven't considered these
> > > > issues.
> > > >
> > > > I want to avoid that.  Just because a couple of people say "we'll
> > > > deal with that later" it's no guarantee that it _will_ happen.  I
> > > > want to ensure that ARM doesn't get fscked over again like it did
> > > > with the generic IRQ crap.
> > >
> > > Ok I'll make it clearer. We don't merge x86 dynticks to mainline till all
> > > are consolidated in -mm.
> >
> > Does this mean you're seriously going to rewrite bits of it after
> > you've spent what seems like months sorting out all the problems
> > currently being found?
> >
> > Excuse me for being stupid, but I somehow don't see that happening.
> > Those months would be effectively wasted effort, both on the side
> > of the people working on the patches and those testing them.
> 
> I've personally been on this code for 3 separate days in total and have no 
> deadline or requirement for this to go in ever so I should stop speaking on 
> behalf of the others.

To join in this conversation late:

I've got a few ideas that I think might help push Con's patch coalescing
efforts in an arch-independent fashion.

First of all, and maybe this is just me, I think it would be good to
make the dyn_tick_timer per-interrupt source, as opposed to each arch?
Thus, for x86, we would have a dyn_tick_timer structure for the PIT,
APIC, ACPI PM-timer and the HPET. These structures could be put in
arch-specific timer.c files (there currently is not one for x86, I
believe). Then, at compilation time, the appropriate structure would be
linked to the arch-generic code. That should make the arch-independent
code simple to implement (I do have some patches in the works, but it's
slow going, right now, sorry). I think ARM and s390 could perhaps use
this infrastructure as well?

Also, I am a bit confused by the use of "dynamic-tick" to describe these
changes. To me, these are all NO_IDLE_HZ implementations, as they are
only invoked from cpu_idle() (or their equivalent) routines. I know this
is true of s390 and the x86 code, and I believe it is true of the ARM
code? If it were dynamic-tick, I would think we would be adjusting the
timer interrupt frequency continuously (e.g., at the end of
__run_timers() and at every call to {add,mod,del}_timer()). I was
working on a patch which did some renaming to no_idle_hz_timer, etc.,
but it's mostly code churn :)

Con, wrt to the x86 implementation, I think the max_skip field should be
a member of the interrupt source (dyn_tick_timer) structure, as opposed
to the state. This would require dyn_tick_reprogram_timer() to change
slightly: either push the max_skip check into arch-specific code (and
then have arch_reprogram() return the actual number of jiffies
programmed to skip) or simply change the check conditional.

Also, what exactly the purpose of conditional_run_local_timers()? It
seems identical to run_local_timers(), except you check for inequality
before potentially raising the softirq. It seems like the conditional
check in run_timer_softirq() [the TIMER_SOFTIRQ callback] will achieve
the same thing? And, in fact, I think that conditional is always true?
At the end of __run_timers, base->timer_jiffies should be greater than
jiffies by 1.

In any case, sorry for all the words and no code... I will try and
rectify that soon. I think it *is* possible to do some architecting now,
so that other architectures can also easily implement no_idle_hz.

Thanks,
Nish
