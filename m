Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161526AbWHDWQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161526AbWHDWQj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 18:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161530AbWHDWQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 18:16:39 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:15324 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161526AbWHDWQi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 18:16:38 -0400
Subject: Re: [PATCH 08/10] -mm  clocksource: cleanup on -mm
From: john stultz <johnstul@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1154725862.12936.93.camel@c-67-188-28-158.hsd1.ca.comcast.net>
References: <20060804032414.304636000@mvista.com>
	 <20060804032522.865606000@mvista.com>
	 <1154721210.5327.58.camel@localhost.localdomain>
	 <1154725862.12936.93.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 15:16:35 -0700
Message-Id: <1154729795.5327.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 14:11 -0700, Daniel Walker wrote:
> On Fri, 2006-08-04 at 12:53 -0700, john stultz wrote:
> > 
> > Hmmmm. Yea, some additional discussion here would probably be needed
> > 
> > At the moment, I'd prefer to keep the clocksource_adjust bits with the
> > timekeeping code, however I'd also prefer to remove the timekeeping
> > specific fields (cycle_last, cycle_interval, xtime_nsec, xtime_interval,
> > error) from the clocksource structure and instead keep them in a
> > timekeeping specific structure (which may also point to a clocksource).
> > 
> > This would keep a clean separation between the clocksource's abstraction
> > that keeps as little state as possible and the timekeeping code's
> > internal state. However the point you bring up above is an interesting
> > issue: Do all users of the generic clocksource structure want the
> > clocksource to be NTP adjusted? 
> 
> Since the output from the clocksource is a lowlevel timestamp I don't
> think the users of it would want it to be ntp adjusted. It would also be
> a little odd, since the ntp adjustment would be attached only to a
> single clock.
> 
> > If we allow for non-ntp adjusted access to the clocksources, we may have
> > consistency issues between users comparing say sched_clock() and
> > clock_gettime() intervals. Further, if those users do want NTP adjusted
> > counters, why aren't they just using the timekeeping subsystem?
> 
> I imagine the users of the interface would be compartmentalized. Taking
> sched_clock as an example the output is only compared to itself and not
> to output from other interfaces.

Agreed on both points. Although I suspect this point will need to be
made explicit.

> > This does put some question as to what exactly would be the uses of the
> > clocksource structure outside of the timekeeping realm. Sure,
> > sched_clock() is a reasonable example, although since sched_clock has
> > such specific latency needs (we probably shouldn't go touching off-chip
> > hardware on every sched_clock call) and can be careful to avoid TSC skew
> > unlike the timekeeping code, its selection algorithm is going to be very
> > arch specific. So I'm not sure its really an ideal use of the
> > clocksource interface (as its not too difficult to just keep sched_clock
> > arch specific).
> 
> Part of the reason to have a generic sched_clock() (and the generic
> clocksource interface in general) is to eliminate the inefficienty of
> duplicating shift and mult functionality in each arch (and on ARM it's
> per board).

Well, a coherent accumulation and NTP adjustment method for continuous
clocksources was a big motivator for the timekeeping work. Also the
quantity of duplicated arch specific time code is a bit larger then the
sched_clock(), but that itself isn't a mark against utilizing
clocksources for sched_clock().

>  So if you correctly implement a clocksource structure for
> your hardware you will at least expose a usable sched_clock() and
> generic timeofday. Then if we add more users of the interface then more
> functionality is exposed.

Well, this point might need some work. sched_clock has quite a different
correctness/performance tradeoff when compared against timeofday. If one
correctly implements a clocksource for something like the ACPI PM, I
doubt they'd want to use it for sched_clock (due to its ~1us access
latency). Additionally, since sched_clock doesn't require (for its
original purpose, at least) the TSC synchronization that is essential
for timekeeping, how will sched_clock determine which clocksource to use
on a system were the TSC is unsyched and marked bad?

> Another instances of this is when instrumentation is needing a of fast
> low level timestamp. In the past to accomplish this one would need a per
> arch change to read a clock, then potentially duplicate a shift and mult
> type computation in order to covert to nanosecond. One good example of
> this is latency tracing in the -rt tree. I can imagine some good and
> valid instrumentation having a long road of acceptable because the time
> stamping portion would need to flow through several different arch and
> potentially board maintainers.

This sounds reasonable, but also I'd question if sched_clock or
get_cycles would be appropriate here. Further, if the mult/shift cost is
acceptable, why not just use the timeofday as the cost will be similar.

> I've also imagined that some usage of jiffies could be converted to use
> this interface if it was appropriate. Since jiffies is hooked to the
> tick, and the tick is getting more and more irregular, a clocksource
> might be a relatively good replacement. 

Hmmm. That'd be a harder sell for me. Probably would want those users to
move to the timeofday, or alternatively, drive jiffies off of the
timekeeping code rather then the interrupt handler to ensure it stays
synced (something I'm plotting once the timekeeping code settles down).

> > I do feel making the abstraction clean and generic is a good thing just
> > for code readability (and I very much appreciate your work here!), but
> > I'm not really sure that the need for clocksource access outside the
> > timekeeping subsystem has been well expressed. Do you have some other
> > examples other then sched_clock that might show further uses for this
> > abstraction?
> 
> I've converted latency tracing to an earlier version of the API , but I
> don't have any other examples prepared. I think it's important to get
> the API settled before I start converting anything else.

Again, I think your patch set looks good for the most part (its just the
last few bits I worry about). I'm very much interested to see where you
go with this, as I feel sched_clock (on i386 atleast) needs some love
and attention and I'm excited to see new uses for the clocksource
abstraction. However, I do want to make sure that we think the use cases
out to avoid over-engineering the wrong bits.

thanks
-john


