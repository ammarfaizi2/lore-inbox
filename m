Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWH2D2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWH2D2b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 23:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWH2D2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 23:28:31 -0400
Received: from science.horizon.com ([192.35.100.1]:16202 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932129AbWH2D2a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 23:28:30 -0400
Date: 28 Aug 2006 23:28:29 -0400
Message-ID: <20060829032829.28776.qmail@science.horizon.com>
From: linux@horizon.com
To: johnstul@us.ibm.com, zippel@linux-m68k.org
Subject: Re: Linux time code
Cc: linux-kernel@vger.kernel.org, linux@horizon.com, theotso@us.ibm.com
In-Reply-To: <1156804609.16398.17.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While its possible to smooth out the leapsecond (which would be useful
> to many folks), the problem is one's system would then diverge from UTC
> for that leapsecond. 

The Posix-mandated behaviour *requires* diverging from UTC for some
time period around the leap second.  All you can do is decide how
to schedule the divergence.

Note that any real clock diverges from UTC by some amount, and
POSIX's denial of leap seconds


> The idea he's proposing here is to keep both UTC and UTS as separate
> clock ids, allowing apps to choose which standard (well, I UTS isn't
> quite a standard) they want to follow.
> 
> I think this would be quite useful, as I've seen a number of requests
> where users don't want the leapsecond inconsistency, and others where
> they need to strictly follow UTC.

I think smoothing it out should be the default for Posix-specified things
like gettimeofday() and CLOCK_REALTIME, since that is, as I said, the
least insane way to deal with the contradictory POSIX requirements.

But also provide an explicit CLOCK_UTC and CLOCK_UTS for people who care
and want to be specific.  adjtimex() should stay UTC, since it returns leap
second information.

> I think having TAI would be nice too, but that requires quite a bit of
> infrastructure work (NTP distributing absolute leapsecond counts, etc).

Yes, but it would be damned nice.  To implement leap seconds at all,
you need to have notice of at least the next one.  The Olson time
zone files, which have a similar several-month advance-notice schedule,
include leap-second information.


Combining messages:
> With the new clocksource code, we can (currently just i386, but the
> architecture is generic and I'm working on the other arches) make use of
> continuous clocksources for accumulating time instead of having the deal
> with the problematic PIT (as well as the lost ticks issue).

If it's there, it's great, but what about i386EX embedded boards and
the like?  It's approximately manageable on uniprocessor, but can
I be sure there's always something (what?) better than the PIT on
*every* SMP system?

I need to study what you've done and see how to use it.

> Maybe I'm missing what you're proposing, but I think "that pit of
> madness" can now be avoided. :)

I'm just trying to start with the best possible worst-case situation,
and then improve on things from there.  Implement the robust slow path
first, then add fast paths for common cases.
