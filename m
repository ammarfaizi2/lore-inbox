Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWHXCf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWHXCf1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 22:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWHXCf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 22:35:27 -0400
Received: from science.horizon.com ([192.35.100.1]:34874 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1030216AbWHXCf0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 22:35:26 -0400
Date: 23 Aug 2006 22:35:25 -0400
Message-ID: <20060824023525.31199.qmail@science.horizon.com>
From: linux@horizon.com
To: johnstul@us.ibm.com, linux@horizon.com
Subject: Re: Linux time code
Cc: linux-kernel@vger.kernel.org, theotso@us.ibm.com, zippel@linux-m68k.org
In-Reply-To: <1156357786.5370.23.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I was talking about the UTS/leapsecond bits w/ Ted just the other day
>> and had a similar thought! To me it makes quite a bit of sense to
>> generate UTC and UTS from TAI, just as you do in the above, since UTC =
>> TAI + leapsecond offset, just as local time = GMT + timezone offset.

> However the difficulty would be that while NTP provides leapsecond +/-
> notifiers, it doesn't provide the absolute UTC offset from TAI. So there
> isn't a way for the kernel to generate TAI, from a UTC settimeofday
> call. Some method to distribute and inform the kernel of the absolute
> leapsecond offset (tai_minus_utc in your code above) would be necessary.

Well, there are several possibilities.  For the opinion of experts on
the subject see paper #7 from http://www.cis.udel.edu/~mills/ntp.html:

Levine, J., and D. Mills. Using the Network Time Protocol to transmit
International Atomic Time (TAI). Proc. Precision Time and Time Interval
(PTTI) Applications and Planning Meeting (Reston VA, November 2000).

http://www.cis.udel.edu/~mills/database/papers/leapsecond.{ps,pdf}

This describes an NTP extension to disseminate leap second times.

GPS broadcasts the absolute offset of UTC from GPS, which is itself
19 s from TAI, so you can get TAI.

You can also poll
ftp://time-b.nist.gov/pub/leap-seconds.list
every few months.  Note that a directory listing will
tell you if anything has changed, since that's a symlink
to the real file, whose name includes an update timestamp.

You can also just accumulate the +/- notifiers to figure out the offset.

I think this can be entered very easily using sysctl.

> Additionally creating UTS and UTC at the same time would be a bit
> complicated. Your solution above isn't quite UTS, since it only handles
> the leap insertion, however the insertion case is the one that causes
> users most of the pain (since the clock goes backward), so it may very
> well be good enough.

It's not that it's hard to implement leap deletion, but it's code
on a moderately hot path (gettimeofday() is a very popular system
call) that will, as far as anyone knows, never be used.

If you want the full version, try:

	case CLOCK_UTS:
		/* Recommended for gettimeofday() & time() */
		/* See http://www.cl.cam.ac.uk/~mgk25/uts.txt */
		clock_gettime(CLOCK_TAI, tp);
		tp->tv_sec -= tai_minus_utc;

		if (tp->tv_sec > next_leap_second) {
			tp->tv_sec += (next_leap_second & 1) ? -1 : 1;

		} else if (next_leap_second - tp->tv_sec < 1000) {
			/* 1000 UTC/TAI seconds = 999 or 1001 UTS seconds */
			uint32_t offset = next_leap_second - tp->tv_sec + 1;
			offset *= MILLION;
			offset += (uint32_t)(BILLION - tp->tv_nsec)/1000;
			if (next_leap_second & 1) {
				/* Negative (deleted) leap second */
				if ((tp->tv_nsec += offset) >= BILLION) {
					tp->tv_nsec -= BILLION;
					tp->tv_sec++;
				}
			} else {
				/* Positive (inserted) leap second */
				if ((tp->tv_nsec -= offset) < 0) {
					tp->tv_nsec += BILLION;
					tp->tv_sec--;
				}
			}
		}
		break;

Note that this code does not interact nicely with updates to tai_minus_utc
and next_leap_second.  An RCU-like scheme would involve a pre- and
post-leap tai_minus_utc, which lets you schedule a new leap by:

<wait for idle>
# At this point, everyone knows that next_leap_second has passed, and
# so pre_tai_utc is don't care
pre_tai_utc = post_tai_utc;
<wait for idle>
# Now next_leap_second is don't care.
next_leap_second = <announced time>
<wait for idle>
# Now post_tai_utc can be rewritten.
post_tai_utc++;

Which doesn't require any locking on the part of the reader, just not
blocking during the conversion.

> Overall, I like your idea quite a bit. Might we look forward to a
> patch? :)

Um, the UTS one I talked about, or the two-phase grab-raw and
convert-to-portable implementation technique?  If the latter,
can we come to some agreement about the questions asked therein?

There's a very nice implementation in PHK's FreeBSD timecounter code.
