Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVIESLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVIESLT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 14:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVIESLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 14:11:18 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:44477 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932337AbVIESLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 14:11:18 -0400
Date: Mon, 5 Sep 2005 11:11:11 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Con Kolivas <kernel@kolivas.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>, johnstul@us.ibm.com
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050905181111.GB17585@us.ibm.com>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050905070053.GA7329@in.ibm.com> <20050905165730.GI25856@us.ibm.com> <20050905172501.GA9132@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905172501.GA9132@in.ibm.com>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.09.2005 [22:55:01 +0530], Srivatsa Vaddagiri wrote:
> On Mon, Sep 05, 2005 at 09:57:30AM -0700, Nishanth Aravamudan wrote:
> > I think it's ok where it is. Currently, with x86, at least, you can have
> > an independent interrupt source and time source (not true for all archs,
> > of course, ppc64 being a good example, I think?) Perhaps "handler"
> 
> By "independent" do you mean driven by separate clocks? PPC64 does
> use decrementer as its interrupt source and Time-base-register as 
> its timesource AFAIK. Both are driven by the same clock I think.

Well, independent as in not the same, I meant. Let me think about it and
look at the code a bit, before making myself or anyone else more
confused. John, do you have any input on what I'm getting at? I know we
have discussed this before...

> > What may be useful is something similar to what John Stultz does in his
> > rework, attaching priorities to the various interrupt sources. For
> > example, on x86, if we have an HPET, then we should use it, if not, then
> > use APIC and PIT, but if the APIC doesn't exist in h/w, or is buggy
> > (perhaps determined via a calibration loop), then only use the PIT.
> 
> This logic is what the arch-code should follow in picking its interrupt
> source and is independent of dyn-tick. dyn-tick just works with whatever 
> arch-code has chosen as its interrupt source.

Yes, true. I didn't mean for the h/w interrupt source selection to be
part of the arch-independent code, but that we might need to include a
priority field in the interrupt_source structure to allow the
arch-dependent code to do so.

> > I agree. I guess max_skip, to me, is what the kernel thinks the
> > interrupt source should maximally skip by, not what the interrupt source
> > thinks it can do. So, I think it fits in fine with what you are saying
> > and with the code you have in the current patch.
> 
> Great!
> 
> > I was just wondering; I guess it makes sense, but did you check to see
> > if it ever *doesn't* get called? Like I said, __run_timers() [from how I
> 
> Haven't tested that, but I feel can happen in practice, since we dont
> control device interrupts.

Well, it would be interesting to see if there's any difference without
that function, or if it's even getting called.

> > base->timer_jiffies) [the condition in run_timer_softirq()] is not. How
> > much does it cost to raise the softirq, if it is going to return
> > immediately from the callback?
> 
> Don't know. It just felt nice to avoid any unnecessary invocations.

Yes, but it also might add a function which doesn't need to be. I'll
take a closer look at this too.

Thanks,
Nish
