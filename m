Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbVJTXXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbVJTXXl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 19:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVJTXXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 19:23:41 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:40850 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964805AbVJTXXk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 19:23:40 -0400
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
From: john stultz <johnstul@us.ibm.com>
To: george@mvista.com
Cc: Daniel Walker <dwalker@mvista.com>, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       ganzinger@mvista.com, linux-kernel@vger.kernel.org
In-Reply-To: <435817F1.3000402@mvista.com>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
	 <Pine.LNX.4.64.0510190816380.30406@dhcp153.mvista.com>
	 <Pine.LNX.4.58.0510200238390.27683@localhost.localdomain>
	 <Pine.LNX.4.64.0510200759110.19738@dhcp153.mvista.com>
	 <435817F1.3000402@mvista.com>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 16:23:37 -0700
Message-Id: <1129850617.27168.192.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-20 at 15:19 -0700, George Anzinger wrote:
> Daniel Walker wrote:
> > On Thu, 20 Oct 2005, Steven Rostedt wrote:
> > 
> >>
> >> Yes, but that shouldn't make a difference.  NTP can slow down or speed up
> >> the clock, but it should never make it go backwards. Especially for a
> >> monotonic clock (as the name suggests).
> > 
> > 
> >     It looks like if ntp_adj held a big negative number you might end up 
> > with a smaller output . ntp_adj is signed too .. I don't know how 
> > ntp_adj is set though .
> > 
> >     I thought I remember George Anzinger speculating that ntp could 
> > cause the time to backwards , that's why I brought it up. Maybe if he's 
> > read he can clue us in ..
> > 
> I think John has changed this, but in the "old" code if ntp was correcting the clock such that less 
> than TICK_NSEC was added on a tick, AND, the time was read just prior to this tick the get_offset 
> code would return ~TICK_NSEC of offset which would mean that a read right after the tick might be 
> less than the one just prior to the tick.  The error, however, would be in the nanosecond area (no 
> where near a second).  Again, as I said, I think John has changed this in is code so that the 
> get_offset equivalent is also ntp corrected, thus eliminating the small back step.
> > 

Indeed. This is one of the bugs my patch addresses. NTP adjustments are
made as frequency adjustments for a entire interval, rather then fixed
value adjustments made at tick time. Thus time is accumulated in the
same way it is calculated in gettimeofday, avoiding time
inconsistencies. 

However, my code does require periodic_hook be called at least once per
rollover of the clocksource counter, so that we get a chance to
accumulate time properly. But considering the current code has issues if
we miss a single tick, I consider it an improvement. :)

thanks
-john


