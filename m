Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbWHWS3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbWHWS3x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 14:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbWHWS3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 14:29:53 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:32690 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965095AbWHWS3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 14:29:52 -0400
Subject: Re: Linux time code
From: john stultz <johnstul@us.ibm.com>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>,
       "Theodore Ts'o" <theotso@us.ibm.com>
In-Reply-To: <20060823062546.12798.qmail@science.horizon.com>
References: <20060823062546.12798.qmail@science.horizon.com>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 11:29:45 -0700
Message-Id: <1156357786.5370.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 02:25 -0400, linux@horizon.com wrote:
> Oh, and if you're going to implement Posix gettimeofday(), have a look at
> Markus Kuhn's UTS proposal (http://www.cl.cam.ac.uk/~mgk25/uts.txt).
> Given that Posix mandates that days have 86400 seconds
> (http://www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap04.html#tag_04_14),
> but the UTC standard maintained by the BIPM
> (http://www.bipm.fr/en/scientific/tai/time_server.html) mandates
> that days sometimes have 86401 seconds, his system is arguably
> the least insane way to reconcile the irreconcilable.
> (See also http://www.cl.cam.ac.uk/~mgk25/volatile/ITU-R-TF.460-4.pdf)
> 
> E.g.  The follwing handles positive leap seconds (only).
> next_leap_second is the Posix timestamp of the next leap
> second (23:59:60), which is always a multiple of 86400.
> (http://hpiers.obspm.fr/eop-pc/earthor/utc/TAI-UTC_tab.html)
> 
> If you wanted to add the (strictly theoretical and never likely to be
> used) negative leap second code, you could distinguish negative leap
> seconds by the fact that next_leap_second is odd (congruent to -1
> mod 86400).
> 
> #define MILLION 1000000
> #define BILLION 1000000000
> 
> extern unsigned tai_minus_utc;	/* Currently 33 */
> extern time_t next_leap_second;	/* UTC time after which tai_minus_utc++ */
> 
> 	switch (clk_id) {
> 	case CLOCK_UTC:
> 		clock_gettime(CLOCK_TAI, tp);
> 		tp->tv_sec -= tai_minus_utc;
> 		/* Leap seconds per http://www.cl.cam.ac.uk/~mgk25/time/c/ */
> 		if (tp->tv_sec >= next_leap_second) {
> 			if (tp->tv_sec == next_leap_second)
> 				tp->tv_nsec += BILLION;
> 			tp->tv_sec--;
> 		}
> 		break;
> 	case CLOCK_UTS:
> 		/* Recommended for gettimeofday() & time() */
> 		/* See http://www.cl.cam.ac.uk/~mgk25/uts.txt */
> 		clock_gettime(CLOCK_TAI, tp);
> 		tp->tv_sec -= tai_minus_utc;
> 		if (tp->tv_sec > next_leap_second) {
> 			tp->tv_sec--;
> 		} else if (next_leap_second - tp->tv_sec < 1000) {
> 			/* 1000 UTC/TAI seconds = 999 UTS seconds */
> 			uint32_t offset = next_leap_second - tp->tv_sec + 1;
> 			offset *= MILLION;
> 			offset += (uint32_t)(BILLION - tp->tv_nsec)/1000;
> 			if ((tp->tv_nsec -= offset) < 0) {
> 				tp->tv_nsec += BILLION;
> 				tp->tv_sec--;
> 			}
> 		}
> 		break;
> 	}


I was talking about the UTS/leapsecond bits w/ Ted just the other day
and had a similar thought! To me it makes quite a bit of sense to
generate UTC and UTS from TAI, just as you do in the above, since UTC =
TAI + leapsecond offset, just as local time = GMT + timezone offset.

However the difficulty would be that while NTP provides leapsecond +/-
notifiers, it doesn't provide the absolute UTC offset from TAI. So there
isn't a way for the kernel to generate TAI, from a UTC settimeofday
call. Some method to distribute and inform the kernel of the absolute
leapsecond offset (tai_minus_utc in your code above) would be necessary.

Additionally creating UTS and UTC at the same time would be a bit
complicated. Your solution above isn't quite UTS, since it only handles
the leap insertion, however the insertion case is the one that causes
users most of the pain (since the clock goes backward), so it may very
well be good enough.

Overall, I like your idea quite a bit. Might we look forward to a
patch? :)

Roman: you're thoughts?

thanks
-john

