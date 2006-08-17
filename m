Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWHQTIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWHQTIs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 15:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWHQTIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 15:08:48 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:18859 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750842AbWHQTIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 15:08:48 -0400
Subject: Re: [RFC][PATCH] Unify interface to persistent CMOS/RTC/whatever
	clock
From: john stultz <johnstul@us.ibm.com>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200608162247.41632.david-b@pacbell.net>
References: <200608162247.41632.david-b@pacbell.net>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 12:08:43 -0700
Message-Id: <1155841724.31755.58.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 22:47 -0700, David Brownell wrote:
> >         Almost every arch has some form of persistent clock (CMOS, RTC, etc)
> > which is normally used at boot time to initialize xtime and
> > wall_to_monotonic. As part of the timekeeping consolidation, I propose
> > the following generic interface to the arch specific persistent clock:
> 
> Hmm, this seems to ignore the RTC framework rather entirely, which
> seems to me like the wrong implementation approach.  You'd likely have
> noticed that if you had supported a few ARM boards.  :)

Good point. I've not spent enough time looking at the RTC code, and it
looks like it has potential to resolve some of the issues I'm looking
at. Although, how common is it really? Could we currently replace all
arches xtime initialization code with it? I suspect that would require
it to be built at all times. Would that be acceptable?

> Here's a fairly common scenario for an embedded system:  the battery
> backed clock is accessed through I2C or SPI, rather than an ISA style
> direct register access, so it's not accessible until after those driver
> stacks have initialized.

Yea. Although late initialization isn't that much of an issue in my
mind.

> Or similarly, the SOC family may have a powerful RTC ("arch specific")
> with alarm and system wakeup capabilities, but it may not be the system's
> battery backed clock ... so that RTC would be initialized from another one,
> which is accessed using I2C/SPI/etc.  (RTCs integrated on SOCs evidently
> have a hard time being as power-miserly as the discrete ones.)

SOC?

> The approach in this patch doesn't seem to play well with those scenarios,
> because it expects to do timekeeping setup long before the system's RTC is
> necessarily going to be available ... and doesn't have an answer for those
> cases where the RTC is unavailable before e.g. late_initcall().

That's fair. While the patch I just sent didn't consider these cases, I
don't think these scenarios break the intent of what I'm wanting to do.


> I'd be more interested in something that improves on CONFIG_RTC_HCTOSYS,
> and for example addresses the need to update the system wall time from
> such RTCs after resume, not just at boot time.

Agreed.

Basically what I'm trying to provide w/ read_persistent_clock() is:
1) A method for generic timekeeping to access a battery backed clock to
avoid potential suspend/resume ordering problems.
2) A generic interface to a low-res hardware driven clock for the
hangcheck-timer and other watchdog timers.
3) To cleanup the arch time initialization code and encapsulate xtime

Do you think the RTC interface is sufficient for this?

Thanks, I appreciate the feedback!
-john


