Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268754AbUILRQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268754AbUILRQE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 13:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268758AbUILRQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 13:16:04 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:18306 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268754AbUILROA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 13:14:00 -0400
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
From: Albert Cahalan <albert@users.sf.net>
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       john stultz <johnstul@us.ibm.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <413C1B13.27464.157279@rkdvmks1.ngate.uni-regensburg.de>
References: <413850B9.15119.BA95FD@rkdvmks1.ngate.uni-regensburg.de>
	 <413C1B13.27464.157279@rkdvmks1.ngate.uni-regensburg.de>
Content-Type: text/plain
Organization: 
Message-Id: <1095009073.1174.56.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Sep 2004 13:11:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-06 at 02:08, Ulrich Windl wrote:
> On 3 Sep 2004 at 11:07, Albert Cahalan wrote:

> > The kernel is broken if:
> > 
> > a. HZ is not really HZ
> 
> HZ is an integer however.

Yes, and this is the rate at which jiffies must tick.
At no time should jiffies be more than one tick away
from the value it would have according to HZ.

(where "tick" is the slower of the two)

> > b. Timekeeping is via 2 unrelated clocks. (jiffies+offset)
> 
> What do you do if one clock lacks resolution, and the other clock lacks digits? 
> The interrupt clock may suck, but the TSC sucks even more.

You choose one. If you have sucky hardware, that's the
best that can be done.

If by "lacks digits" you mean something like the 24-bit
cycle counter on the Alpha, faking a 64-bit counter is
not terribly hard. I've seen it done for the SHARC DSP.
You'll just need an interrupt before roll-over.

> > c. HZ is not an integer
> 
> HZ is HZ, but the true interrupt frequency is something completely different.

I could run the interrupts at 4152.0625 Hz and still
produce a jiffies tick at 1000.0000 Hz over the long
term. At any given point in time, jiffies won't be
off by more than 1 tick.

I could run the interrupts at 666 Hz too, and not be
off by more than 2 jiffies ticks.

Having the interrupt frequency be _almost_ equal to
the HZ value is kind of bad, because it tempts people to
equate them. When the frequencies are really different,
the errors and solutions become more obvious.

> > So on box using only clock ticks, steer jiffies
> > toward HZ using NTP (or default frequency error value).
> 
> Are you saying you are happy with a lcok that less than 1 HZ off? That would be -- 
> in a extreme case -- about 86000 seconds off per day.

Less than 1/HZ off, yes. That's 1 millisecond max error
over any time period from nanoseconds to years.

> > On a box with high-res time, use that instead, and make
> > jiffies follow it to satisfy various kernel-internal
> > uses of jiffies.
> 
> Make jiffies follow variable CPU clock? Are you serious?

You can not use a variable clock. End of story.

Well, if you do, you pay the price. (time goes crazy every
now and then, until a very-forgiving ntpd adjusts things)
This would not be a sane default.

If you want high-res time on a PC, your choices:

a. read the PIT registers (slow)
b. have a PC with the HPET
c. have a PC with a stable TSC
d. some ACPI PM thing?

If your hardware isn't suited for high-res time,
nothing will save you. Linux got along OK for a
decade without high-res time at all; you'll live.


