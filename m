Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWFFTmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWFFTmq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 15:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWFFTmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 15:42:46 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:8901 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751018AbWFFTmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 15:42:45 -0400
Subject: Re: clocksource
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606052226150.32445@scrub.home>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <Pine.LNX.4.64.0606050141120.17704@scrub.home>
	 <1149538810.9226.29.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606052226150.32445@scrub.home>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 12:42:35 -0700
Message-Id: <1149622955.4266.84.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 23:07 +0200, Roman Zippel wrote:
> Hi,
> 
> On Mon, 5 Jun 2006, john stultz wrote:
> 
> > On Mon, 2006-06-05 at 01:50 +0200, Roman Zippel wrote:
> > > Hi,
> > > 
> > > On Sun, 4 Jun 2006, Andrew Morton wrote:
> > > 
> > > > time-use-clocksource-infrastructure-for-update_wall_time.patch
> > > 
> > > I still disagree with the update_wall_time() changes, they should be kept 
> > > the new separate from this. 
> > 
> > Is this directly related to the next item (if so, how?), or just
> > preference? I'd really like to avoid having multiple code paths for the
> > timekeeping core, so I'd like to see this unified. I'm willing to
> > optimize out bits w/ constants and whatnot, but I worry it will be a
> > nightmare to maintain if we have multiple generic update_wall_time
> > implementations.
> 
> One "unified" version will only be worse. Keeping the new path separate 
> from the old path will only make things clearer and more flexible.
> Right now you have a mixture of old code, interpolator code and new 
> timekeeping code, which makes it a big mess.

Eh? Are we looking at the same code? Right now there is *no* mixture of
old code. The update_wall_time() function is the same for *all* arches,
and jiffies is the common clocksource. This allows us to use alternate
clocksources to move to continuous timekeeping, while allowing the
accumulation function to stay the same. I don't see what part of this
you consider messy.

Its true the interpolator code is still there, but not for long, as they
will be easy to convert since the clocksource structure is very similar.
And that's just *one* line of code in the function in question.



> > > The error algorithm is a somewhat old version 
> > > and can cause oscillation and thus a confused clock.
> > 
> > Would you mind elaborating on this? Which aspect of the error algorithm
> > is off? How does the clock become confused? Could you point to the line
> > numbers, etc?  I assume your last patchset contains the current version?
> 
> With large clock offsets the lookahead doesn't work correctly, basically 
> because it's already to late and it can cause overadjustment. Because of 
> this I do an extra lookahead in clocksource_bigadjust().

Do you have a hard example for this with numbers? I don't mean to be a
pain, but I don't see this right off.

With the current code in -mm I can run a test app that disables
interrupts for 2 seconds at a time over and over and I'm still keeping
synched w/ an NTP server within 30 microseconds.


> > > > time-let-user-request-precision-from-current_tick_length.patch
> > > 
> > > This is broken, as it simply throws away resolution depending on the 
> > > clock.
> > 
> > So if the clock shift value is less then 12 (SHIFT_SCALE - 10), this is
> > true, and currently that's only the jiffies case.
> > 
> > Just to be clear, are you then suggesting that the accumulation in
> > update_wall_time should be done in a fixed shifted nanosecond unit
> > regardless of the clock shift value? Is SHIFT_SCALE-10, good enough in
> > your mind for this?
> > 
> > That seems not too difficult to do, and can be done w/ an incremental
> > patch. I'll try to crank that out today.
>
> I'd prefer you'd just take the update function from my patch, it's nicely 
> optimized and I'll try to address any concern you have about it.

Even though as mentioned above I'm still in the dark on the need for it,
I spent a few hours last trying to convert the make_ntp_adj() in -mm to
use your bigadjust implementation. Unfortunately my attempts refuse to
boot. I'm not sure if this is the same problem that was keeping your
patchset from booting as well, or possibly just an implementation error
on my part.

I'll send a patch for your review shortly and maybe you can catch the
issue?

> For this I also I posted a userspace test program, so that I know how it 
> behaves, do you have something similiar for yours?

At your prodding awhile back I wrote a userspace simulator, but you
never commented on it.

Ok, so back to the critical issues:

1) You don't like the unified update_wall_time
2) Issue w/ the current make_ntp_adj and lost ticks.
3) NTP error may be limited to clock->shift resolution w/ the jiffies
clocksource (other clocksources have finer resolution then NTP's).


#1 I disagree with. I really think the unified approach is the way to
go, but I do understand the need to be conservative. This has gotten a
fair amount of testing in -mm with no issues reported. But its not too
hard to re-add the old update_wall_time(), so I could be convinced to
push the unification off w/ a second opinion. Again, this would be via
an incremental patch.

So for #2 I'm working on trying to get your implementation functioning,
but I still don't quite understand the reason. I think this can be
worked out w/ an incremental patch. I'll send you some separate mail
shortly on this.

I posted an incremental patch for #3 yesterday, but it needs more work,
and changes in #2 could affect it, so I'm focusing on #2 at them moment.
Even so, NTP's resolution is 0.2 picoseconds, and the jiffies
clocksource keeps an error resolution of 4 picoseconds, so I'm not sure
if that this is really a blocker.  Further if we do re-add the old
update_wall_time for issue #1, this would keep the jiffies clocksource
from being used commonly, so this wouldn't be an issue.


Your thoughts?
-john


