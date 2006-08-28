Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWH1LkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWH1LkB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 07:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWH1LkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 07:40:01 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:10697 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964784AbWH1LkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 07:40:00 -0400
Date: Mon, 28 Aug 2006 13:39:49 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux@horizon.com
cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org, theotso@us.ibm.com
Subject: Re: Linux time code
In-Reply-To: <20060824023525.31199.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.64.0608281250060.6761@scrub.home>
References: <20060824023525.31199.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 23 Aug 2006, linux@horizon.com wrote:

> > Additionally creating UTS and UTC at the same time would be a bit
> > complicated. Your solution above isn't quite UTS, since it only handles
> > the leap insertion, however the insertion case is the one that causes
> > users most of the pain (since the clock goes backward), so it may very
> > well be good enough.
> 
> It's not that it's hard to implement leap deletion, but it's code
> on a moderately hot path (gettimeofday() is a very popular system
> call) that will, as far as anyone knows, never be used.
> 
> If you want the full version, try:
> 
> 	case CLOCK_UTS:
> 		/* Recommended for gettimeofday() & time() */
> 		/* See http://www.cl.cam.ac.uk/~mgk25/uts.txt */
> 		clock_gettime(CLOCK_TAI, tp);
> 		tp->tv_sec -= tai_minus_utc;
> 
> 		if (tp->tv_sec > next_leap_second) {
> 			tp->tv_sec += (next_leap_second & 1) ? -1 : 1;
> 
> 		} else if (next_leap_second - tp->tv_sec < 1000) {
> 			/* 1000 UTC/TAI seconds = 999 or 1001 UTS seconds */
> 			uint32_t offset = next_leap_second - tp->tv_sec + 1;
> 			offset *= MILLION;
> 			offset += (uint32_t)(BILLION - tp->tv_nsec)/1000;
> 			if (next_leap_second & 1) {
> 				/* Negative (deleted) leap second */
> 				if ((tp->tv_nsec += offset) >= BILLION) {
> 					tp->tv_nsec -= BILLION;
> 					tp->tv_sec++;
> 				}
> 			} else {
> 				/* Positive (inserted) leap second */
> 				if ((tp->tv_nsec -= offset) < 0) {
> 					tp->tv_nsec += BILLION;
> 					tp->tv_sec--;
> 				}
> 			}
> 		}
> 		break;

Doing something like for this for gettimeofday() is pretty much obsolete 
with the new time code. OTOH it's rather simple to smooth out the leap 
second now, you can set time_adjust and adjust MAX_TICKADJ and the clock 
will follow nicely.

bye, Roman
