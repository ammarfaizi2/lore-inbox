Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWH1Wgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWH1Wgw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 18:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWH1Wgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 18:36:52 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:65247 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964865AbWH1Wgv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 18:36:51 -0400
Subject: Re: Linux time code
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, theotso@us.ibm.com
In-Reply-To: <Pine.LNX.4.64.0608281250060.6761@scrub.home>
References: <20060824023525.31199.qmail@science.horizon.com>
	 <Pine.LNX.4.64.0608281250060.6761@scrub.home>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 15:36:49 -0700
Message-Id: <1156804609.16398.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 13:39 +0200, Roman Zippel wrote:
> On Thu, 23 Aug 2006, linux@horizon.com wrote:
> > > Additionally creating UTS and UTC at the same time would be a bit
> > > complicated. Your solution above isn't quite UTS, since it only handles
> > > the leap insertion, however the insertion case is the one that causes
> > > users most of the pain (since the clock goes backward), so it may very
> > > well be good enough.
> > 
> > It's not that it's hard to implement leap deletion, but it's code
> > on a moderately hot path (gettimeofday() is a very popular system
> > call) that will, as far as anyone knows, never be used.
> > 
> > If you want the full version, try:
> > 
> > 	case CLOCK_UTS:
> > 		/* Recommended for gettimeofday() & time() */
> > 		/* See http://www.cl.cam.ac.uk/~mgk25/uts.txt */
> > 		clock_gettime(CLOCK_TAI, tp);
> > 		tp->tv_sec -= tai_minus_utc;
> > 
> > 		if (tp->tv_sec > next_leap_second) {
> > 			tp->tv_sec += (next_leap_second & 1) ? -1 : 1;
> > 
> > 		} else if (next_leap_second - tp->tv_sec < 1000) {
> > 			/* 1000 UTC/TAI seconds = 999 or 1001 UTS seconds */
> > 			uint32_t offset = next_leap_second - tp->tv_sec + 1;
> > 			offset *= MILLION;
> > 			offset += (uint32_t)(BILLION - tp->tv_nsec)/1000;
> > 			if (next_leap_second & 1) {
> > 				/* Negative (deleted) leap second */
> > 				if ((tp->tv_nsec += offset) >= BILLION) {
> > 					tp->tv_nsec -= BILLION;
> > 					tp->tv_sec++;
> > 				}
> > 			} else {
> > 				/* Positive (inserted) leap second */
> > 				if ((tp->tv_nsec -= offset) < 0) {
> > 					tp->tv_nsec += BILLION;
> > 					tp->tv_sec--;
> > 				}
> > 			}
> > 		}
> > 		break;
> 
> Doing something like for this for gettimeofday() is pretty much obsolete 
> with the new time code. OTOH it's rather simple to smooth out the leap 
> second now, you can set time_adjust and adjust MAX_TICKADJ and the clock 
> will follow nicely.

While its possible to smooth out the leapsecond (which would be useful
to many folks), the problem is one's system would then diverge from UTC
for that leapsecond. 

The idea he's proposing here is to keep both UTC and UTS as separate
clock ids, allowing apps to choose which standard (well, I UTS isn't
quite a standard) they want to follow.

I think this would be quite useful, as I've seen a number of requests
where users don't want the leapsecond inconsistency, and others where
they need to strictly follow UTC.

I think having TAI would be nice too, but that requires quite a bit of
infrastructure work (NTP distributing absolute leapsecond counts, etc).

thanks
-john

