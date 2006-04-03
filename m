Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWDCTye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWDCTye (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 15:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWDCTye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 15:54:34 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:64488 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964861AbWDCTyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 15:54:33 -0400
Date: Mon, 3 Apr 2006 21:54:03 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: johnstul@us.ibm.com
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/5] clocksource patches
Message-ID: <Pine.LNX.4.64.0604031431220.25825@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It unfortunately took a bit longer when I planned, but here is now an 
update to the clocksource patches.
Patch 1 depends on the generic clocksource patches.
Patches 2-4 are a replacement for these patches in -mm:

time-use-clocksource-infrastructure-for-update_wall_time.patch
time-use-clocksource-infrastructure-for-update_wall_time-mark-few-functions-as-__init.patch
time-let-user-request-precision-from-current_tick_length.patch
time-use-clocksource-abstraction-for-ntp-adjustments.patch
time-introduce-arch-generic-time-accessors.patch

Patch 5 depends on the clocksource drivers.

Some more notes about the patches:

1. generic clocksource updates:
The most important change is probably clocksource_get_nsec_offset(), it 
returns the nsec part of the realtime clock and is adjusted once a second. 
Other time services can be built on top of this and also only have to be 
updated once a second via second_overflow(). I changed the return value to 
an unsigned long which gives us a 3 second window, which should be more 
than enough (anyone not allowing the timer interrupt for that long gets 
what he is asking for). This function should become clocksource specific 
so arch/clocks can optimize this function themselves (e.g. changing 
resolution, making some parameters constant). The generic clocksource 
currently still deals a bit too much with cycles, more of this should be 
moved into the clocksource drivers (using library functions).

I'm also still interested in opinions about different possibilities to 
organize the clocksource infrastructure (although I'd more appreciate 
pro/con arguments than outright rejections). One possibility here would be 
to also shorten the function names a bit (clocksource_ is a lot to type :) 
), cs_... or clock_... would IMO work too.

2. periodic clocksource update
I updated the error adjustment algorithm to be more robust and optimized 
it a bit for the more common cases. It does everything in 64bit right now, 
which is fine for 64bit archs and it allows resolutions of less then 
1nsec, but as long as e.g. gettimeofday() takes longer than 1nsec that's 
a little wasteful and nobody will see a difference if we "restrict" the 
resolution to 1nsec, which would allow to keep parts of it in 32bit.

I also kept it separate from the do_timer() callback and simply created a 
new callback function, which archs can use. This makes it less likely to 
break any existing setup and even allows to coexists both methods until 
archs have been completely converted.

The userspace version I used to test this can be found at
http://www.xs4all.nl/~zippel/ntp/clocktest.c


Another general comment from an arch/driver specific perspective: right 
now everything is rather concentrated on getting the time, but AFAICT it's 
more common that the subsystem which is used to read the time is also used 
as timer (i.e. for the scheduler tick), this means the clocksource driver 
should also include the interrupt setup. Consequently this means the 
update callback isn't sufficient anymore and we need at least something 
like start/stop callbacks. This also means the jiffie clocksource becomes 
basically obsolete, since every arch already needs at least a basic 
clocksource to provide the scheduler tick (which is setup via 
time_init()).
i386 is currently rather hardcoded to use the i8253 timer, but AFAIK it 
would be desirable to e.g. use HPET for that (especially for hrtimer). 
Something like TSC should internally use another clocksource to provide 
the timer interrupt. Anyway, i386 is quite a mess here right now and I can 
understand that you wanted to stay away from it with the generic 
gettimeofday infrastructure. :-)
This is not important right now, but I wanted to mention it, it's IMO
something to keep in mind for the next steps and what at least I'll 
look out for.

bye, Roman
