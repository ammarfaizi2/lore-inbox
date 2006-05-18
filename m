Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWERLvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWERLvw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 07:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWERLvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 07:51:52 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:50368 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751350AbWERLvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 07:51:51 -0400
Date: Thu, 18 May 2006 13:51:36 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Tim Mann <mann@vmware.com>
cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: Fix time going backward with clock=pit [1/2]
In-Reply-To: <20060517160428.62022efd@mann-lx.eng.vmware.com>
Message-ID: <Pine.LNX.4.64.0605181249020.17704@scrub.home>
References: <20060517160428.62022efd@mann-lx.eng.vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 17 May 2006, Tim Mann wrote:

> 2) do_timer_overflow was trying to detect the case where the counter
>    has wrapped since jiffies was incremented by checking whether the
>    timer interrupt is still pending in the PIC.  This is bogus for a
>    couple of reasons: (a) There is a window between the point where
>    the PIC interrupt is acknowledged and jiffies is incremented.  
>    (b) Most systems use the IOAPIC for interrupt routing now.  The
>    kernel has code that tries to also route the timer interrupt to the
>    PIC and acknowledge it there, but this does not appear to work; in
>    my testing on a couple of IOAPIC systems, do_timer_overflow always
>    thought a timer interrupt was pending.  Also, this code has the
>    same window as in (a).

Do you (or anyone else) have more information about this? If it's not 
possible to detect the underflow, it would mean that PIT isn't usable
as clock in these cases, as the clock would still jump around (just not 
visibly backwards).

>  	if( jiffies_t == jiffies_p ) {
>  		if( count > count_p ) {
>  			/* the nutcase */
> -			count = do_timer_overflow(count);
> +			count = count_p;
>  		}
>  	} else
>  		jiffies_p = jiffies_t;

IMO the else part is not correct. I think the whole think should look 
something like this:

	if (jiffies_t == jiffies_p) {
		if (count > count_p) {
			underflow or crappy timer;
		}
	} else {
		jiffies_p = jiffies_t;
		if (count > LATCH/2 && underflow)
			count -= LATCH;
	}

This would also basically solve the ordering problem, retrying the 
function would produce the correct result.

So we basically have two issues:
1. Fix the timekeeping to produce correct results.
2. Broken underflow handling.

If the second isn't fixable, it would make the whole thing practically 
unusable. I hope that it's at least detectable, so we don't use it as a 
clock, which would be IMO preferable instead of completely removing the 
underflow check (which would make the clock unreliable for everyone).

BTW another bug here is the wrong initialization of jiffies_p (it should 
be INITIAL_JIFFIES).

bye, Roman
