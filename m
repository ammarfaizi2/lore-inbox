Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWGBCp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWGBCp1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 22:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWGBCp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 22:45:27 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:41388 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751168AbWGBCp0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 22:45:26 -0400
Subject: Re: 2.6.17-mm4
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jesse.brandeburg@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060701165713.71638e88.akpm@osdl.org>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	 <4807377b0606291053g602f3413gb3a60d1432a62242@mail.gmail.com>
	 <20060629120518.e47e73a9.akpm@osdl.org>
	 <4807377b0606301653n68bee302t33c2cc28b8c5040@mail.gmail.com>
	 <20060630171212.50630182.akpm@osdl.org>
	 <4807377b0606301717t35d783cbgad6d67daeb163f5a@mail.gmail.com>
	 <1151713862.16221.2.camel@localhost.localdomain>
	 <4807377b0607011033s3e329d7cy1081fb6c8be41e9b@mail.gmail.com>
	 <1151776582.18139.51.camel@localhost>
	 <20060701165713.71638e88.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 19:45:23 -0700
Message-Id: <1151808323.5646.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-01 at 16:57 -0700, Andrew Morton wrote:
> On Sat, 01 Jul 2006 10:56:22 -0700
> john stultz <johnstul@us.ibm.com> wrote:
> 
> > Andrew: While clearly there is the deeper issue of why interrupts are
> > enabled before they should be, I may still like to push the two-liner
> > above, since its a bit safer should someone accidentally enable
> > interrupts early again. Looking back in my patch history it was
> > previously in the order above until I switched it (I suspect
> > accidentally) in the C0 rework.
> > 
> I looked at doing this and there appeared to be interdependencies between
> these two functions.  In that timekeeping_init()'s behaviour would be
> different if time_init() hadn't run yet.
> 
> So are you really really sure?

timekeeping_init() is pretty straight forward:

	write_seqlock_irqsave(&xtime_lock, flags);
	clock = clocksource_get_next();
	clocksource_calculate_interval(clock, tick_nsec);
	clock->cycle_last = clocksource_read(clock);
	ntp_clear();
	write_sequnlock_irqrestore(&xtime_lock, flags);

We initialize the clock value and call ntp_clear.  The jiffies
clocksource will be used to start - other clocksources will be selected
as they become available.

Just to be sure, which inter-dependencies where you're thinking of?

thanks
-john

