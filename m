Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030430AbVLHDWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbVLHDWZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 22:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbVLHDWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 22:22:24 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:39062 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030430AbVLHDWX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 22:22:23 -0500
Subject: Re: 2.6.14-rt21: slow-running clock
From: john stultz <johnstul@us.ibm.com>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512080302.jB832PLx008014@sprite.physics.adelaide.edu.au>
References: <200512080302.jB832PLx008014@sprite.physics.adelaide.edu.au>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 19:22:21 -0800
Message-Id: <1134012141.10613.81.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-08 at 13:32 +1030, Jonathan Woithe wrote:
> > On Thu, 2005-12-08 at 09:24 +1030, Jonathan Woithe wrote:
> > > > Odd. I'm not sure why the acpi_pm wasn't chosen by default if it was
> > > > available and the TSC fell back to the c3tsc. It might be something in
> > > > the -RT tree that's changed that bit. Could you try the following and
> > > > see if it doesn't resolve the timekeeping problems you're seeing?
> > > > 
> > > > echo "acpi_pm" >  /sys/devices/system/clocksource/clocksource0/current_clocksource
> > > 
> > > Upon executing the above command the system time started behaving correctly
> > > once more.
> > Ok, something in the -rt patches is probably changing the selection
> > order.
> 
> Is there any way to change the clock source in a normal 2.6.14 kernel?  If
> there was I could force the source to c3tsc in that and see if the problem
> affects the c3tsc in vanilla kernels.

Not really, other then just at boot. And your options are only: tsc,
pit, pmtmr and hpet. The c3tsc is new w/ my timekeeping code.

> > > I'm also wondering whether this might be related to one other thing I
> > > noticed a week or so back (also reported to the list, but thus far no
> > > followups). If I enabled the (new) "High resolution timers" feature (as
> > > distinct from HPET), things like /usr/bin/sleep run for far longer than
> > > they should irrespective of machine load.  For example, "sleep 1" from bash
> > > actually delays 38 seconds, not 1 second as expected.
> > 
> > Does disabling the "High resolution timers" feature change the behavior
> > all?
> 
> I should clarify.  Everything I've given you thus far has been with the
> "high resolution timers" feature disabled.  Two or so weeks ago I tried
> enabling it and that's when "sleep 1" took 38 seconds to complete. 
> Disabling "high resoltion timers" at least made "sleep 1" behave somewhat
> saner.  I don't know if having the high res timers enabled affects the
> accuracy of the system clock however.  I'll test this tonight.

Ok. I think I've reproduced the issue on my laptop as well. It seems to
be a -rt issue only (I need to go back and test HRT too) as I do not see
the problem w/ my B13 patchset. 

Possibly we are getting preempted before entering or exiting C3 mode?
I'll need to look further. It isn't directly related to cpu load or
idleness (a cpu pegged box doesn't drift that badly), but it might be
io-related. 

> > > In other words, c3tsc wasn't there but tsc was.  In terms of time accuracy
> > > it seemed that with idle=poll the system time was kept accurately in this
> > > case as well.  I also noted in dmesg output the following:
> > > 
> > >   Time: tsc clocksource has been installed.
> > > 
> > > Unlike the normal case (where idle=poll was not specified) there was no
> > > mention of a "fallback" to a "C3-safe tsc".
> > 
> > Thats very interesting that idle=poll worked around the issue. More
> > digging will be necessary.
> 
> It possibly suggests that it's the c3tsc timer which is faulty as opposed to
> the tsc timer (or maybe it's just a mode thing).  Note that even with
> idle=poll it was the tsc timer (instead of the acpi_pm timer) which was
> selected, so "idle=poll" doesn't work around the timer selection issue.  It
> seems that there might be two separate problems: timer source selection and
> c3tsc accuracy.  Whether they are both present in vanilla 2.6.14 (or simply
> masked due to selection of acpi_pm) is not clear.

Ok, I might have have been confusing in my last mail. I think we're in
agreement and I understand the situation. I appreciate the
clarification.

Thanks again for the feedback!
-john

