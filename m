Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVIEGoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVIEGoW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 02:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVIEGoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 02:44:22 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:21668 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932258AbVIEGoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 02:44:22 -0400
Date: Sun, 4 Sep 2005 23:44:16 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ck list <ck@vds.kolivas.org>, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050905064416.GD25856@us.ibm.com>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050904212616.B11265@flint.arm.linux.org.uk> <20050905053225.GA4294@in.ibm.com> <20050905054813.GC25856@us.ibm.com> <20050905063229.GB4294@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905063229.GB4294@in.ibm.com>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.09.2005 [12:02:29 +0530], Srivatsa Vaddagiri wrote:
> On Sun, Sep 04, 2005 at 10:48:13PM -0700, Nishanth Aravamudan wrote:
> > Admittedly, I don't think SMP ARM has been around all that long?
> > Maybe the existing code just has not been extended.
> 
> Yeah, maybe ARM never cared for SMP. But we do care :)

I just took a look at arm/Kconfig and SMP is marked as EXPERIMENTAL &&
BROKEN. So I'm guessing that is the only reason for some of the
differences you mentioned (the differences are of course, valid and the
x86 SMP implementation makes sense to me to extend arch-independently).

> > I'm not sure on this. It's going to be NULL for other architectures,
> > or end up being called by the reprogram() call for the last CPU to
> > go idle, right (presuming there isn't a separate TOD source, like in
> > x86). I think it is better to be in the reprogram() interface.
> 
> Non-x86 could have it set to NULL, in which case it doesn't get
> called.  (I know the current code does not take care of this
> situation).  But having an explicit 'all_cpus_idle' interface may be
> good, since Tony talked of idling some devices when all CPUs are idle.
> So it probably has non-x86/PIT uses too.

OK, not a problem. I'll try and write up a general intsource.h file
(interrupt source header) tonight and tomorrow and send it to this list
to see if everybody agrees on what's in the structure and where the
arch-independent/dependent line lies.

> > > 6. S390 makes use of notifier mechanism to notify when CPUs are
> > >    coming in and out of idle state. Don't know how it will be used
> > >    in other arches. But obviously, if we are talking of unifying,
> > >    we have to provide one.
> > 
> > Couldn't that be part of the s390-specific init() code? That member
> > is non-existent in the ARM implementation either, but it should not
> > be hard to add? The only issue I see, though, is that the function
> > which the init() member points to should not be marked __init, as we
> > could have an empty pointer later on?
> 
> If we consider that only s390 needs it and other arch's dont, then it
> need not be even part of the init code. Basically the notifier list
> can be maintained by s390 in its arch-code entirely and have
> 'stop_hz_timer' call into dyn_tick_reprogram_timer (or something like
> that)? But I feel there will be other uses for the notifier list (I
> know the slab reap timer fires every two seconds and that may be
> unnecessary on idle CPUs if it is not reaping anything - perhaps it
> could use such a notifier to fire at longer intervals on idle CPUs?
> That may be true of other short-timers that kernel/drivers may be
> using. This is just a thought and may need more consideration before
> we put a notifier mechanism in arch-independent code).

Yeah, maybe we would be ok with keeping the notifier setup s390-specific
for now, and then extending the faculty to arch-independent code if we
find good (clean) reasons to do so. I'm not saying the slab reaping code
is insufficient, but I want to keep the structure and code as simple as
possible at first (in the design phase, at least).

> > I'm not sure on this last one, though, what part of the state can't
> > simply be represented by an integer with appropriate &-ing?
> 
> Everything can be represented in bits! I was just comparing
> composition of structures in ARM and x86. The state bitfield is part
> of 'struct dyn_tick_timer' itself in ARM while it is part of a
> separate structure (dyn_tick_state) in x86. Similar minor points need
> to be sorted out while unifying.

Heh, I agree :) I just wanted to make sure that I hadn't missed
something and there was a *specific* reason the x86 code was using a
separate structure. I actuall prefer keeping it tied to the interrupt
source; it's simpler to me.

Thanks,
Nish
