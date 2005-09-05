Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbVIEJZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbVIEJZW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 05:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVIEJZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 05:25:22 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:41162 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932349AbVIEJZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 05:25:21 -0400
Date: Mon, 5 Sep 2005 14:54:39 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050905092439.GA8038@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050905070053.GA7329@in.ibm.com> <20050905084425.B24051@flint.arm.linux.org.uk> <20050905081935.GB7924@in.ibm.com> <20050905093221.E24051@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905093221.E24051@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 09:32:21AM +0100, Russell King wrote:
> When you have a timer which constantly increments from 0 to MAX and
> wraps, and you can set the value to match to cause an interrupt,
> it makes more sense to handle it the way we're doing it (which
> incidentally leads to no loss of precision.)

> Calculating the number of ticks missed, updating the kernel time,
> and updating the timer match will cause problems with these - if
> the timer has already past the number of ticks you originally
> calculated, you may not get another interrupt for a long time.
> 
> So I don't actually think that your proposal will work for these
> (SA11x0 and PXA).

I presume you are referring to code as in omap_32k_timer_interrupt
which calculates lost ticks as well as updates wall-time and 
sets up the next interrupt (BTW doesnt 'now' need to be
refreshed everytime in the loop otherwise will cause the problem
you cite - may not get interrupt for a long time?). Tony,
that may have cause slow bootups for you :)

I am not saying that all the above be done from the callee. In fact
in case of ARM, the same handler can be called from dyn_tick_interrupt.
Having some form of 'dyn_tick_interrupt' makes sense because
it encapsulates functionalities like:

	- If CPU is not sleeping currently, return (which can happen in SMP)
	- Reset the CPU from the bitmap, under the cover of a spinlock
	- Recover wall-time if we are coming out of 'all-cpus-were-asleep'
	  state.  In case of ARM, dyn_tick_timer->handler could be called
	  for this purpose.

 
> This seems to only recover one tick.  What if multiple ticks were lost?

cur_timer->mark_offset() recovers the rest.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
