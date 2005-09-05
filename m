Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVIEFsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVIEFsV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 01:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbVIEFsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 01:48:21 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:11219 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932208AbVIEFsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 01:48:21 -0400
Date: Sun, 4 Sep 2005 22:48:13 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ck list <ck@vds.kolivas.org>, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050905054813.GC25856@us.ibm.com>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050904212616.B11265@flint.arm.linux.org.uk> <20050905053225.GA4294@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905053225.GA4294@in.ibm.com>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.09.2005 [11:02:25 +0530], Srivatsa Vaddagiri wrote:
> On Sun, Sep 04, 2005 at 09:26:16PM +0100, Russell King wrote:
> > I'd be really surprised if any architecture couldn't use what ARM has
> > today - in other words, this is the only kernel-side interface:
> 
> Russel,
> 	I went thr' the ARM implementation and have some remarks (mostly
> from a SMP perspective):
> 
> 1. On a SMP platform, we want to let individual CPUs "sleep" independent of 
>    each other. What this mean is there has to be some way of tracking which
>    CPU's are sleeping currently, so that code like RCU ignores sleeping CPUs.
>    This was the reason nohz_cpu_mask bitmap was added. I don't see that
>    bitmap being updated at all in ARM implementation.

Admittedly, I don't think SMP ARM has been around all that long? Maybe
the existing code just has not been extended.

> 2. On architectures like x86 there is a separate jiffy interrupt source 
>    (PIT) which is used to update time-of-day. This is different from the
>    HZ timer interrupts used on each CPU (local apic timer). When all 
>    CPUs are idle and sleeping, we want to shut off this PIT timer as well.
>    That's why I added 'arch_all_cpus_idle' interface. One could argue that
>    this can be done as part of the dyn_tick->reprogram interface as well,
>    but I felt that having a separate arch_all_cpus_idle is cleaner and
>    makes it clear what its purpose is.

I'm not sure on this. It's going to be NULL for other architectures, or
end up being called by the reprogram() call for the last CPU to go idle,
right (presuming there isn't a separate TOD source, like in x86). I
think it is better to be in the reprogram() interface.

> 3. The fact that we want to manipulate the bitmap (set a bit when CPU is going
>    idle and unset it when it is waking up) _and_ the fact that want to take
>    some action when all CPUs are idle or when the first CPU is waking up, 
>    requires the use of a spinlock, which is again not present in the ARM 
>    implementation.

This might just be tied to the same UP capabilities, I'm not sure.

> 4. Again the fact that CPUs could be sleeping independent of each other
>    requires do_IRQ to check out whether the current CPU was sleeping as 
>    its first step. If the CPU was sleeping, it needs to unset itself
>    from the bitmap _and_ if we are coming out of "all-cpu-asleep" state,
>    the PIT timer needs to be restarted as well as time recovered. Note
>    that these two steps need not be undertaken if we were not in 
>    "all-cpus-asleep" state.

I agree; the latter can be in the arch-specific reprogram() code, just
like arch_all_cpus_idle() (which might be better named to
arch_set_all_cpus_idle()).

> I don't see provisions for all these in the current ARM
> implementation.  In fact the x86 patch that Tony/Con posted didnt take
> into account most of these as well, which is the reason I jumped in to
> fix the above issues.

I definitely appreciate you doing so; dyn-tick for x86 has clearly come
a long way in a short time.

> 5. Don't see how DYN_TICK_SKIPPING is being used. In SMP scenario,
>    it doesnt make sense since it will have to be per-cpu. The bitmap
>    that I talked of exactly tells that (whether a CPU is skipping
>    ticks or not).

I'll take a look at this.

> 6. S390 makes use of notifier mechanism to notify when CPUs are coming
>    in and out of idle state. Don't know how it will be used in other
>    arches. But obviously, if we are talking of unifying, we have to
>    provide one.

Couldn't that be part of the s390-specific init() code? That member is
non-existent in the ARM implementation either, but it should not be hard
to add? The only issue I see, though, is that the function which the
init() member points to should not be marked __init, as we could have an
empty pointer later on?

> I hope this makes clear why some of the rework happened, which
> in a way is extending the interface that ARM already has. Having
> said all these, I do agree that having a consistent interface 
> is good (for example: x86 has dyn_tick_state structure whereas
> ARM uses dyn_tick_timer strucuture itself to store the state etc).

I'm not sure on this last one, though, what part of the state can't
simply be represented by an integer with appropriate &-ing?

Thanks,
Nish
