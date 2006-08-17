Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWHQVmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWHQVmF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 17:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWHQVmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 17:42:05 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:51109 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932374AbWHQVmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 17:42:03 -0400
Subject: Re: [RFC][PATCH] Unify interface to persistent CMOS/RTC/whatever
	clock
From: john stultz <johnstul@us.ibm.com>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200608171328.24344.david-b@pacbell.net>
References: <200608162247.41632.david-b@pacbell.net>
	 <1155841724.31755.58.camel@cog.beaverton.ibm.com>
	 <200608171328.24344.david-b@pacbell.net>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 14:42:00 -0700
Message-Id: <1155850921.31755.115.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 13:28 -0700, David Brownell wrote:
> On Thursday 17 August 2006 12:08 pm, john stultz wrote:
> > On Wed, 2006-08-16 at 22:47 -0700, David Brownell wrote:
> > > 
> > > Hmm, this seems to ignore the RTC framework rather entirely, which
> > > seems to me like the wrong implementation approach.  You'd likely have
> > > noticed that if you had supported a few ARM boards.  :)
> > 
> > Good point. I've not spent enough time looking at the RTC code, and it
> > looks like it has potential to resolve some of the issues I'm looking
> > at. Although, how common is it really?
> 
> Increasingly so; it solves a lot of reinvent-the-wheel problems, much
> like the recent generic time-of-day updates are doing.  And just like
> with clocksource updates, not all architectures have converted yet!

Is a breakdown somewhere of what is covered at this point? The two
letters followed by six number driver files make it difficult to see
which arches use what. :)

> > Could we currently replace all 
> > arches xtime initialization code with it?
> 
> Not yet, I think, mostly because RTCs are still being converted to
> that framework.

With a list of arches that are covered, I'll start working on patches to
do so.


> For ACPI PCs, I converted drivers/char/rtc.c to that framework (see:
> http://article.gmane.org/gmane.linux.kernel/427493) covering most
> hardware over the last few years.

Cool.

> > I suspect that would require 
> > it to be built at all times. Would that be acceptable?
> 
> It's just a question of _which_ code to build all the time, right?
> Having it be standardized core code would seem appropriate.

Yea. We also need to make sure every arch has something that will work
w/o special compile time config options.


> > > Here's a fairly common scenario for an embedded system:  the battery
> > > backed clock is accessed through I2C or SPI, rather than an ISA style
> > > direct register access, so it's not accessible until after those driver
> > > stacks have initialized.
> > 
> > Yea. Although late initialization isn't that much of an issue in my
> > mind.
> 
> ... except that unless I traced the code wrong, your current patch is
> initializing the (wall) clock extremely early ... ergo my comment about
> assuming ISA style access.  I'm happy to call that a minor implementation
> artifact though, since I haven't noticed any issues with "late" init
> for the system wall clock either.

Indeed. If we cannot initialize xtime early, that's not an issue.
settimeofday() will fix that up. However the suspend/resume ordering
issue is more difficult. On resume we need to have something usable
before we resume the timekeeping code in order to correctly increment
xtime and jiffies in one atomic action.

> > > Or similarly, the SOC family may have a powerful RTC ("arch specific")
> > > with alarm and system wakeup capabilities, but it may not be the system's
> > > battery backed clock ... so that RTC would be initialized from another one,
> > > which is accessed using I2C/SPI/etc.  (RTCs integrated on SOCs evidently
> > > have a hard time being as power-miserly as the discrete ones.)
> > 
> > SOC?
> 
> System-On-Chip ... one chip has not just CPU+cache, but also memory controllers
> and enough I/O that few external chips are needed.  The one in your cell phone
> is probably Linux-capable; the one in your microwave probably isn't.  (For some
> sophisticated examples, www.omap.com ... click the left menu then look at the
> chips' block diagrams to see what cell phone CPUs look like.)

Thanks for the clarification.

With regards to more powerful RTCs, those I don't really care too much
about. I just want access the battery backed clock for suspend/resume
and watchdog uses.


> > > I'd be more interested in something that improves on CONFIG_RTC_HCTOSYS,
> > > and for example addresses the need to update the system wall time from
> > > such RTCs after resume, not just at boot time.
> > 
> > Agreed.
> 
> There's some ARM code to restore the jiffies-vs-rtc clock offset on resume,
> which seems like a candidate for wider use.

Where is this code? I'm interested here, but I suspect for correctness
that bit should be under the control of the timekeeping core.


> > Basically what I'm trying to provide w/ read_persistent_clock() is:
> > 1) A method for generic timekeeping to access a battery backed clock to
> > avoid potential suspend/resume ordering problems.
> > 2) A generic interface to a low-res hardware driven clock for the
> > hangcheck-timer and other watchdog timers.
> > 3) To cleanup the arch time initialization code and encapsulate xtime
> > 
> > Do you think the RTC interface is sufficient for this?
> 
> I think the resume side needs some tweaks, but basically yes.  (The
> resume sequencing, like the suspend sequencing, is excessively dumb.
> It'd probably be good to resume RTCs before drivers that care about
> elapsed time, for example ... )

Ok. I'm not totally sold on it, but I'll start looking in more detail
here. Starting w/ i386 and possibly moving across the rest of the
arches.


> I'm not entirely sure I see RTC as a clocksource, but maybe that'd
> make sense...

Ehh. That's definitely not the direction I'm trying to go (although I
guess one could possibly do so). I just want the 3 items above. :)


thanks
-john

