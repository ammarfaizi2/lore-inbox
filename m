Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290965AbSC0Uwm>; Wed, 27 Mar 2002 15:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291169AbSC0Uwb>; Wed, 27 Mar 2002 15:52:31 -0500
Received: from zeus.kernel.org ([204.152.189.113]:14272 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S291620AbSC0UwS>;
	Wed, 27 Mar 2002 15:52:18 -0500
Message-ID: <3CA230A3.7F5CD1D4@mvista.com>
Date: Wed, 27 Mar 2002 12:50:43 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: high-res-timers-discourse@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Is CLOCK_REALTIME the same as the clock under gettimeofday()
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A re-reading of the standard (dammed nuisance), to get the man pages
right, uncovered the information that clock_nanosleep() with the
absolute
option is supposed to wake up at the specified time, regardless of
intervening calls to clock_settime() (all on CLOCK_REALTIME).  In
considering how to make this happen, I assumed that this also meant that
calls to settime() and adjtime() (i.e. ntp code) should also be
covered.  All this assumes that CLOCK_REALTIME and the gettimeofday()
clock are the same.

The way to do this IMHO, is to put these sleep requests in a linked list
and, each time the time is changed, run thru the list and cancel each
sleep and redo it.  The problem with this is the ntp stuff which makes
small adjustments each tick (10 ms).  I think this is too much overhead
for each tick so I am trying to come up with a new way that has less
overhead.

One possible solution is to disconnect CLOCK_REALTIME from the
gettimeofday() clock.  It could be, for example, connected to the uptime
clock (CLOCK_MONOTONIC) with an offset which would be added to get to
something close to the gettimeofday() clock.  The offset would be
calculated at boot time and then periodically from then on.  The period
could be something that keeps ntp drifting from causing a redo of the
clock_nanosleep() calls every tick, but still keeps the clock relatively
close, say every second or so (possibly this period could be changed or
configured).

Another solution to this issue is to program the clock_nanosleep() calls
to wake up a second or so prior to the requested time and then fine tune
the wake up to happen as close as possible to the requested time.  This
calculation might take into account the current ntp drift rate.

comments?
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
Preemption patch:http://www.kernel.org/pub/linux/kernel/people/rml
