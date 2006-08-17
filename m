Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWHQU2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWHQU2c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 16:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWHQU2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 16:28:32 -0400
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:30858 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030250AbWHQU2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 16:28:31 -0400
From: David Brownell <david-b@pacbell.net>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC][PATCH] Unify interface to persistent CMOS/RTC/whatever clock
Date: Thu, 17 Aug 2006 13:28:23 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200608162247.41632.david-b@pacbell.net> <1155841724.31755.58.camel@cog.beaverton.ibm.com>
In-Reply-To: <1155841724.31755.58.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608171328.24344.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 August 2006 12:08 pm, john stultz wrote:
> On Wed, 2006-08-16 at 22:47 -0700, David Brownell wrote:
> > 
> > Hmm, this seems to ignore the RTC framework rather entirely, which
> > seems to me like the wrong implementation approach.  You'd likely have
> > noticed that if you had supported a few ARM boards.  :)
> 
> Good point. I've not spent enough time looking at the RTC code, and it
> looks like it has potential to resolve some of the issues I'm looking
> at. Although, how common is it really?

Increasingly so; it solves a lot of reinvent-the-wheel problems, much
like the recent generic time-of-day updates are doing.  And just like
with clocksource updates, not all architectures have converted yet!


> Could we currently replace all 
> arches xtime initialization code with it?

Not yet, I think, mostly because RTCs are still being converted to
that framework.

For ACPI PCs, I converted drivers/char/rtc.c to that framework (see:
http://article.gmane.org/gmane.linux.kernel/427493) covering most
hardware over the last few years.


> I suspect that would require 
> it to be built at all times. Would that be acceptable?

It's just a question of _which_ code to build all the time, right?
Having it be standardized core code would seem appropriate.


> > Here's a fairly common scenario for an embedded system:  the battery
> > backed clock is accessed through I2C or SPI, rather than an ISA style
> > direct register access, so it's not accessible until after those driver
> > stacks have initialized.
> 
> Yea. Although late initialization isn't that much of an issue in my
> mind.

... except that unless I traced the code wrong, your current patch is
initializing the (wall) clock extremely early ... ergo my comment about
assuming ISA style access.  I'm happy to call that a minor implementation
artifact though, since I haven't noticed any issues with "late" init
for the system wall clock either.


> > Or similarly, the SOC family may have a powerful RTC ("arch specific")
> > with alarm and system wakeup capabilities, but it may not be the system's
> > battery backed clock ... so that RTC would be initialized from another one,
> > which is accessed using I2C/SPI/etc.  (RTCs integrated on SOCs evidently
> > have a hard time being as power-miserly as the discrete ones.)
> 
> SOC?

System-On-Chip ... one chip has not just CPU+cache, but also memory controllers
and enough I/O that few external chips are needed.  The one in your cell phone
is probably Linux-capable; the one in your microwave probably isn't.  (For some
sophisticated examples, www.omap.com ... click the left menu then look at the
chips' block diagrams to see what cell phone CPUs look like.)


> > The approach in this patch doesn't seem to play well with those scenarios,
> > because it expects to do timekeeping setup long before the system's RTC is
> > necessarily going to be available ... and doesn't have an answer for those
> > cases where the RTC is unavailable before e.g. late_initcall().
> 
> That's fair. While the patch I just sent didn't consider these cases, I
> don't think these scenarios break the intent of what I'm wanting to do.

Not in the big picture, nope.  Which is why I called it an implementation
issue.  I've also noticed the mess of arch/platform specific clock setup
wierdness, and was glad to see you start fixing it.  :)


> > I'd be more interested in something that improves on CONFIG_RTC_HCTOSYS,
> > and for example addresses the need to update the system wall time from
> > such RTCs after resume, not just at boot time.
> 
> Agreed.

There's some ARM code to restore the jiffies-vs-rtc clock offset on resume,
which seems like a candidate for wider use.


> Basically what I'm trying to provide w/ read_persistent_clock() is:
> 1) A method for generic timekeeping to access a battery backed clock to
> avoid potential suspend/resume ordering problems.
> 2) A generic interface to a low-res hardware driven clock for the
> hangcheck-timer and other watchdog timers.
> 3) To cleanup the arch time initialization code and encapsulate xtime
> 
> Do you think the RTC interface is sufficient for this?

I think the resume side needs some tweaks, but basically yes.  (The
resume sequencing, like the suspend sequencing, is excessively dumb.
It'd probably be good to resume RTCs before drivers that care about
elapsed time, for example ... )

I'm not entirely sure I see RTC as a clocksource, but maybe that'd
make sense...

- Dave

