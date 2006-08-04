Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161387AbWHDTxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161387AbWHDTxq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 15:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161388AbWHDTxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 15:53:46 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:34200 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161387AbWHDTxp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 15:53:45 -0400
Subject: Re: [PATCH 08/10] -mm  clocksource: cleanup on -mm
From: john stultz <johnstul@us.ibm.com>
To: dwalker@mvista.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20060804032522.865606000@mvista.com>
References: <20060804032414.304636000@mvista.com>
	 <20060804032522.865606000@mvista.com>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 12:53:30 -0700
Message-Id: <1154721210.5327.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 20:24 -0700, dwalker@mvista.com wrote:
> plain text document attachment (clocksource_api_cleanup_on_mm.patch)
> Some additional clean up only on the -mm tree. Moves the adjust
> functions into kernel/time/clocksource.c . 
> 
> These functions directly modify the clocksource multiplier based
> on ntp error. These adjustments will effect other users of that 
> clock. This hasn't been  addressed in my patch set, since it 
> needs some discussion.


Hmmmm. Yea, some additional discussion here would probably be needed

At the moment, I'd prefer to keep the clocksource_adjust bits with the
timekeeping code, however I'd also prefer to remove the timekeeping
specific fields (cycle_last, cycle_interval, xtime_nsec, xtime_interval,
error) from the clocksource structure and instead keep them in a
timekeeping specific structure (which may also point to a clocksource).

This would keep a clean separation between the clocksource's abstraction
that keeps as little state as possible and the timekeeping code's
internal state. However the point you bring up above is an interesting
issue: Do all users of the generic clocksource structure want the
clocksource to be NTP adjusted? 

If we allow for non-ntp adjusted access to the clocksources, we may have
consistency issues between users comparing say sched_clock() and
clock_gettime() intervals. Further, if those users do want NTP adjusted
counters, why aren't they just using the timekeeping subsystem?

This does put some question as to what exactly would be the uses of the
clocksource structure outside of the timekeeping realm. Sure,
sched_clock() is a reasonable example, although since sched_clock has
such specific latency needs (we probably shouldn't go touching off-chip
hardware on every sched_clock call) and can be careful to avoid TSC skew
unlike the timekeeping code, its selection algorithm is going to be very
arch specific. So I'm not sure its really an ideal use of the
clocksource interface (as its not too difficult to just keep sched_clock
arch specific).

I do feel making the abstraction clean and generic is a good thing just
for code readability (and I very much appreciate your work here!), but
I'm not really sure that the need for clocksource access outside the
timekeeping subsystem has been well expressed. Do you have some other
examples other then sched_clock that might show further uses for this
abstraction?

thanks
-john


