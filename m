Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161573AbWHDXQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161573AbWHDXQf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 19:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161574AbWHDXQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 19:16:34 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:58780 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1161573AbWHDXQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 19:16:34 -0400
Subject: Re: [PATCH 08/10] -mm  clocksource: cleanup on -mm
From: Daniel Walker <dwalker@mvista.com>
To: john stultz <johnstul@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1154729795.5327.97.camel@localhost.localdomain>
References: <20060804032414.304636000@mvista.com>
	 <20060804032522.865606000@mvista.com>
	 <1154721210.5327.58.camel@localhost.localdomain>
	 <1154725862.12936.93.camel@c-67-188-28-158.hsd1.ca.comcast.net>
	 <1154729795.5327.97.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 16:16:22 -0700
Message-Id: <1154733383.12936.146.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 15:16 -0700, john stultz wrote:

> > I imagine the users of the interface would be compartmentalized. Taking
> > sched_clock as an example the output is only compared to itself and not
> > to output from other interfaces.
> 
> Agreed on both points. Although I suspect this point will need to be
> made explicit.

Yeah, that's a good idea.

> >  So if you correctly implement a clocksource structure for
> > your hardware you will at least expose a usable sched_clock() and
> > generic timeofday. Then if we add more users of the interface then more
> > functionality is exposed.
> 
> Well, this point might need some work. sched_clock has quite a different
> correctness/performance tradeoff when compared against timeofday. If one
> correctly implements a clocksource for something like the ACPI PM, I
> doubt they'd want to use it for sched_clock (due to its ~1us access
> latency). Additionally, since sched_clock doesn't require (for its
> original purpose, at least) the TSC synchronization that is essential
> for timekeeping, how will sched_clock determine which clocksource to use
> on a system were the TSC is unsyched and marked bad?

sched_clock would use the highest rated clock in the system, and if that
becomes unstable it uses jiffies. That could mean using the acpi_pm if
it's the highest rated clock. Some code would have the be added to force
sched_clock to use the tsc. 

I did some hackbench runs using the tsc vs. acpi_pm, and there was only
minimal differences (within the margin of error). It could be different
with other pm timers, but that was the result on mine. I also did some
tests of tsc vs. pit which showed some extensive differences. It added
10 seconds to "hackbench 80" . So I'm not entirely convinced that
acpi_pm is totally inappropriate as a fall back, in the case of
un-synced TSC. 

I wish I had an HPET to test.

> > Another instances of this is when instrumentation is needing a of fast
> > low level timestamp. In the past to accomplish this one would need a per
> > arch change to read a clock, then potentially duplicate a shift and mult
> > type computation in order to covert to nanosecond. One good example of
> > this is latency tracing in the -rt tree. I can imagine some good and
> > valid instrumentation having a long road of acceptable because the time
> > stamping portion would need to flow through several different arch and
> > potentially board maintainers.
> 
> This sounds reasonable, but also I'd question if sched_clock or
> get_cycles would be appropriate here. Further, if the mult/shift cost is
> acceptable, why not just use the timeofday as the cost will be similar.

get_cycles() isn't implemented on all arches. sched_clock() sometimes
returns jiffies converted to nanosecond depending on the arch (it does
this sometimes on i386 even). Also sched_clock() has the disadvantage of
converting to nanosecond each time it runs, which isn't always ideal.
get_cycles(), if it's implemented, doesn't come with a standard way to
find a) the clock it accesses b) the frequency of the clock. 

So they both have disadvantages over the clocksource interface.

> > I've also imagined that some usage of jiffies could be converted to use
> > this interface if it was appropriate. Since jiffies is hooked to the
> > tick, and the tick is getting more and more irregular, a clocksource
> > might be a relatively good replacement. 
> 
> Hmmm. That'd be a harder sell for me. Probably would want those users to
> move to the timeofday, or alternatively, drive jiffies off of the
> timekeeping code rather then the interrupt handler to ensure it stays
> synced (something I'm plotting once the timekeeping code settles down).

It's case by case. I wouldn't say all jiffies uses could use timeofday
calls, and I wouldn't say they could all use a clocksource. I'd imagine
some could be converted to a clocksource though.

I'd be interested to see any jiffies changes you make.

> > > I do feel making the abstraction clean and generic is a good thing just
> > > for code readability (and I very much appreciate your work here!), but
> > > I'm not really sure that the need for clocksource access outside the
> > > timekeeping subsystem has been well expressed. Do you have some other
> > > examples other then sched_clock that might show further uses for this
> > > abstraction?
> > 
> > I've converted latency tracing to an earlier version of the API , but I
> > don't have any other examples prepared. I think it's important to get
> > the API settled before I start converting anything else.
> 
> Again, I think your patch set looks good for the most part (its just the
> last few bits I worry about). I'm very much interested to see where you
> go with this, as I feel sched_clock (on i386 atleast) needs some love
> and attention and I'm excited to see new uses for the clocksource
> abstraction. However, I do want to make sure that we think the use cases
> out to avoid over-engineering the wrong bits.

Your questions are certainly appropriate, and I appreciate the review.
There's not to many other responses so far. 

Daniel

