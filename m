Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWGPPww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWGPPww (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 11:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWGPPww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 11:52:52 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:55169 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750983AbWGPPww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 11:52:52 -0400
Date: Sun, 16 Jul 2006 17:52:47 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: tglx@linutronix.de, Pavel Machek <pavel@ucw.cz>,
       Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
In-Reply-To: <1152828344.6845.96.camel@localhost>
Message-ID: <Pine.LNX.4.64.0607161448530.6761@scrub.home>
References: <200607092352.k69NqZuJ029196@harpo.it.uu.se> 
 <1152554328.5320.6.camel@localhost.localdomain>  <20060710180839.GA16503@elf.ucw.cz>
  <Pine.LNX.4.64.0607110035300.17704@scrub.home>  <1152571816.9062.29.camel@localhost.localdomain>
  <Pine.LNX.4.64.0607110054180.12900@scrub.home>  <1152605229.32107.88.camel@localhost.localdomain>
  <Pine.LNX.4.64.0607111120310.12900@scrub.home>  <1152616025.32107.151.camel@localhost.localdomain>
  <Pine.LNX.4.64.0607120039380.12900@scrub.home>  <1152664944.760.70.camel@cog.beaverton.ibm.com>
  <1152822433.24345.19.camel@localhost.localdomain> <1152828344.6845.96.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 13 Jul 2006, john stultz wrote:

> However, we do want precise timekeeping. Since there is a resolution
> difference between NTP's precision and the clocksources, keeping track
> of that error and adjusting for it is a desirable thing to do. 

I think it makes sense to focus not just on NTP, that's why I gave the 
example of per cpu clocks. Synchronizing time over the internet doesn't 
require that much precision, but it might also be used in a local network 
to keep machines as much as possible in sync.
Per cpu clocks would really push the limits. We could now chain clocks 
together where one central clock is controlled via NTP and attached to it 
run per cpu clocks, which could even run at different frequencies. Between 
these clocks one really wants to keep the error as small as technically 
possible, so that there is enough margin so that even in the worst cases 
it's rather unlikely that two threads on different cpus see widely 
different time values. The question would be now what is technically 
possible and what is needed to achieve it.

> Notice, for the high-precsion clocksource adjustments remember the
> granularity of the error we're keeping track of is nanoseconds shifted
> up by 32. That's way small.

BTW I chose that 32 mostly for convience, as it makes it easy to extract 
the nanosecond part. The current NTP code shoehorns various values into 
32bit using different scale values. Soonish this will be cleaned up to 
use 64bit values using a single scale value.

> So for a counter w/ a 4Ghz frequency and a shift value of 22 (similar to
> a TSC). Over 1 second, if there was no high-precision adjustment, you
> could get a *maximum* of error of ~1us (4b/2^22 = ~1024ns), which is a
> 1ppm drift, if left uncorrected.
> 
> Now, if we have high-precision adjustments, the question is "how fast
> should we fix that 1us error?". If the code assumes we're going to have
> a tick every 1 ms, it can make a stronger adjustment (of 10 mult units)
> which it will remove after the next tick. This however could cause
> problems if we lost ticks and that interrupt was delayed as we would
> overshoot.
> 
> Thus, if we assume that ticks will show up worse case, about once a
> second or two, we can make an adjustment of a single mult unit and
> assume that we'll correct it over the next second. This is what Roman
> was saying would be "slow adjustments", but I don't see it as too
> unacceptable. 

The error value can be a lot worse than 1us. time_adjust has a limit of 
0.5ms and NTP adjustments can be even worse than this. If the clock is now 
updated very infrequently, the clock can accumulate quite a lot of error 
before it starts changing its frequency. So if you limit the error 
correction to 1us per second it might take a very long time to reduce the 
error. You really have to keep the worst cases a bit in mind, even if they 
are rather unlikely.
BTW if you already know there will be no adjustment within the next ticks, 
the current code is very easy to change to deal with it, simply add a line 
"look_ahead = max(look_ahead, clock->min_look_ahead);" and the error 
adjustment will be spread over a longer period.
Also if you know that the average update frequency is that low, it might 
make sense to increase the shift value to get more precision for the error 
correction.

bye, Roman
