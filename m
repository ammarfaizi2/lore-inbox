Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751639AbVLADc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbVLADc7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 22:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbVLADc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 22:32:59 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:57555 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751637AbVLADc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 22:32:58 -0500
Date: Thu, 1 Dec 2005 04:32:43 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       george@mvista.com, johnstul@us.ibm.com
Subject: Re: [patch 00/43] ktimer reworked
In-Reply-To: <1133395019.32542.443.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.61.0512010118200.1609@scrub.home>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Dec 2005, Thomas Gleixner wrote:

> to address the naming debate: we do agree that 'struct ktimer' and 
> 'struct timer_list' is confusing and awkward - both are about timers.  
> Same goes for kernel/ktimer.c and kernel/timer.c.
> 
> but what we'd like to achieve as an end-result is the clear separation 
> of 'timer' vs. 'timeout' APIs. Our proposed end result would be to have 
> 'struct ktimer' for timers, and 'struct ktimeout' for timeouts.

Sorry, but calling it "ktimeout" would be completely wrong.

"timeout" is a rather imprecise term, which can have different meanings 
depending on the context, e.g. any timer usually has a "timeout value", 
but what is meant here is a "timeout timer". So basically this is supposed 
to be about "timer" vs "timeout timer". 
First, the problem here is these "timeout timer" are not restricted to 
just a single use case, so there is no reason to name them like this only 
because they are most commonly used as timeout timer in the kernel. There 
are many types of timer usages in the kernel and there is no reason to 
give every one of them their own API.
Second, "timer" is a generic term, which would include all types of timer  
and this suggests that this is a generally usable timer. The emphasis of 
this timer is to provide precise, high resolution timer, but this purpose 
is not reflected in the name at all.

This is a really bad choice in names, both are timer. timer_list is so far 
_the_ generic API for _any_ type of timer, this unlikely to change for 
some time, so restricting this via a new name is confusing and wrong. The 
focus of the new timer system is high resolution timer and a good name 
would include something which describes this purpose and would clearly 
distinguish it from the current common timer.
Calling them "timer" and "timeout" would completely reverse the rolls, 
which makes it completely wrong.

> - ptimer.c is smaller, for the price of making users of the APIs more
>   complex. ktimer.c carries more features and thus more code, so that
>   users can have simpler code.

What complexity are you talking about? Let's look at the itimer:

int it_real_fn(struct ptimer *timer)
{
        struct signal_struct *sig = container_of(timer, struct signal_struct, real_timer);

        send_group_sig_info(SIGALRM, SEND_SIG_PRIV, sig->tsk);

        if (sig->it_real_incr.tv64 == KTIME_ZERO)
                return 0;
        sig->real_timer.expires = ktime_add(timer->base->last_expired, sig->it_real_incr);
        return 1;
}

This looks really simple to me. The last few lines could be moved into the 
timer code, but I decided against it because this version leaves more 
flexibility to the user. Currently we have only few users, should we have 
more users we could for example change it to:

	return ptimer_rearm(timer, sig->it_real_incr);

But this is currently not needed, we can still refine the API as soon as
there are more users, so we see what is really needed. What my patch does 
is to provide the basic functionality upon which further improvements are 
possible.

Posix timer are OTOH indeed more complex, but here I left the complexity 
there instead of moving it into ptimer.

> - the ktimer subsystem is designed with the extensibility for high
>   resolution timers and dynamic ticks in mind, without having to do
>   further rewrites. The practical feasibility and cleanliness of the
>   ktimer approach has been proven since the very beginning, both the
>   -khrt and the -rt trees have carried those patches for months now,
>   with a real HRT implementation ontop of it. We believe that some
>   details that the ptimers patch-queue chopped off the ktimers codebase
>   will have to be reintroduced for HRT timers later on.

This is very vague. What kind of "further rewrites" will be required. What 
are the "details" you "believe" are so important.

> - the resolution handling is implemented without any jiffy relations and
>   resembles the behaviour of the current implementation. The first view
>   of more complexity has to be carefully weighed against the flexibility
>   for further extensions.

Again, what "further extensions"?
ptimer is not limited to jiffy resolutions, it's the resolution it 
_currently_ uses and it's the best currently possible with the current 
clock abstraction.

The resolution handling in your patch is overly complex, most of the 
rounding is off and sometimes even wrong. I explained the details of the 
rounding in the ktime_t patch and I would like to encourage you to pick up
from there and explain what the hell you're talking about.

> - ktimer is fully docbook documented and well commented. The ptimer
>   patchqueue was based off an older ktimer tree with less comments and
>   no documentation.

I intentionally left out some of the documentation, because I wanted some 
discussion about the implementation first and then update the 
documentation based on the discussion, so it reflects a common view 
instead of finishing the discussion before it even started.

> if there are any other substantial differences between the ptimer
> patchqueue and the current ktimer queue then please speak up. (there
> was no documentation of all ktimer->ptimer changes, so we might have
> missed something)

If there is anything unclear, you could just ask.

> The patch series is also available from 
> http://www.tglx.de/projects/ktimers/patch-2.6.15-rc2-kt-rework.tar.bz2

I don't want to go into the details here. Most of the initial cleanup 
patches could easily be done afterwards and are not critical enough to be 
done first, the ktimer part needs an explanation what the extra complexity 
is needed for and I explained above what I think about the last part.

BTW a quick test shows the overrun handling is still broken. timer_gettime 
seems to be broken now for these cases as well.

bye, Roman
