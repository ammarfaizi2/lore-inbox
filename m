Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315277AbSGMSKe>; Sat, 13 Jul 2002 14:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSGMSKd>; Sat, 13 Jul 2002 14:10:33 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58120 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315277AbSGMSKc>; Sat, 13 Jul 2002 14:10:32 -0400
Date: Sat, 13 Jul 2002 11:15:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: What is supposed to replace clock_t?
In-Reply-To: <Pine.LNX.4.33.0207130949090.11082-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.44.0207131103410.16670-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Jul 2002, Tim Schmielau wrote:
>
> the log message to your patch that splits in-kernel HZ und user-level HZ
> mentions the "broken interfaces that still use 'clock_t'". And indeed,
> these interfaces are broken now, since some of them now wrap after 49
> days, while others wrap after 497 days.

clock_t is fundamentally broken partly because of the size issue (ie we're
fixed to a 32-bit clock_t on x86, and the 497 day thing is fundamental,
while the 49 day thing is just because I was lazy and didn't want to
bother with 64-bit divisions etc for the broken stuff).

The only sane interface is a seconds-based one, either like /proc/uptime
(ie ASCII floating point representation) or a mixed integer representation
like timeval/timespec where you have seconds and micro/nanoseconds
separately.

> My goal with the "> 497 days uptime patch" was to hide internal overflows
> within the kernel, so that every exported value wraps exactly when the
> number of _exported_ bits does not suffice to hold the true value.

That's something we should strive for, but I also think we should avoid
using the clock_t format at all, and give alternate representations (for
example, leave the broken clock_t representation in /proc/<pid>/stat
alone, and just add a _sane_ seconds-based thing in the much more readable
and parseable /proc/<pid>/status file.

Not all of the olf clock_t-based stuff is worth trying to fix up, imho.

> However, with the new divisor of 10 between internal and external time
> values this would now require most internal time values to be stored in
> >= 36 bit wide variables (i.e., 64 bit).

I agree. We should just make the internal jiffies be 64-bit. That's
already true for the "true" jiffy count, but it's simply not true for some
other things (process counters etc). That's a separate issue from the
fundamental brokenness of

> Then we could, of course, also extend the exported values where exported
> as text, only keeping binary interfaces as 'legacy interfaces'.

Many of the binary interfaces are perfectly fine. In fact, there are very
few binary interfaces that are fundamentally broken, the obvious one being
the "times()" system call that nobody actually uses any more. Fixing
"jiffies_to_timeval()" and friends to do the right thing for 64-bit
jiffies will make a lot of the binary interfaces (ie gettimeofday/select/
getrusage etc) just do the right thing.

I'd like to do this gradually, though. If you're interested, how about
just slowly migrating to a

	typedef u64 jiffies_t;

and slowly making the _internal_ stuff be 64-bit clean?

		Linus

