Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbVF3Bvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbVF3Bvm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 21:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbVF3Bvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 21:51:42 -0400
Received: from unused.mind.net ([69.9.134.98]:25253 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262707AbVF3Bve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 21:51:34 -0400
Date: Wed, 29 Jun 2005 18:50:10 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
In-Reply-To: <20050629125657.GA29475@elte.hu>
Message-ID: <Pine.LNX.4.58.0506291730000.16060@echo.lysdexia.org>
References: <200506281927.43959.annabellesgarden@yahoo.de> <20050628202147.GA30862@elte.hu>
 <20050628203017.GA371@elte.hu> <200506290151.53675.annabellesgarden@yahoo.de>
 <20050629063439.GB12536@elte.hu> <20050629070058.GA15987@elte.hu>
 <Pine.LNX.4.58.0506290159050.12101@echo.lysdexia.org> <20050629125657.GA29475@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005, Ingo Molnar wrote:

> great! The SMP box running BurnP6 is another system, right? Could you 
> sum up the remaining regressions you are seeing under -RT? (the 
> latency.c warning is one, what others are remaining?)

Right.  I'm doing the bulk of my RT testing on three machines:

Home:  UP  Athlon  2GHz    VIA KT400   desktop, audio & MIDI dev
Work:  UP  Xeon    1.8GHz  Intel 845   video encoding & mcast streaming
Work:  SMT Xeon/HT 3.2GHz  Intel 865   desktop, video streaming testing

Here's the max wakeup latencies I'm seeing on each machine with -50-35:

Athlon   15us 
Xeon     22us
Xeon/HT  290us

In all fairness, the Xeon/HT machine is still running with the debug and 
trace options enabled, while the other two have all debug except wakeup 
latency timing disabled.

On UP, everything looks good.  No JACK xruns, even while running burnK7.  
Streaming with VLC from a Hauppauge card to UDP/multicast is almost
flawless (usually takes at least a day before any UDP packets are sent out
too late).  I only saw one warning in my logs on the Athlon box for the
whole -50 series, and that was in -50-15.  The non-HT Xeon box hasn't seen
any bug warnings since plist_init() on -48-33.

On SMT, everything works well under normal desktop load (X, wmaker, 10
dockapps, 10-20 xterms, and firefox).  VLC runs very smoothly when I'm not
stress-testing.  System responsiveness is much better than the 
vanilla kernels.  Wakeup latencies have decreased since the -48 series
(generally <100us, spiking to <300us now instead of generally <200us
spiking to <1000us).

When it comes to stress testing, I'm still finding conditions where CPU
hungry processes (like burnP6) can make the box completely unresponsive.  
So far, I've narrowed it down to the following conditions:  X is running
(xorg-6.8.2), along with two burnP6 instances, and X apps that are
actively updating the screen (like VLC or a collection of wmaker
dockapps).  If one of these conditions is absent, there's no meltdown.

I've been toying with a script to fire up two instances of burnP6, grab
some traces with your trace-it code, and kill off those burnP6 processes.  
The script generally takes the form:

#!/bin/bash
trace-it > trace1.out
sync
burn &
usleep 100000
trace-it > trace2.out
sync
burn &
usleep 100000
trace-it > trace2.out
sync
killall burn

I copied 'burnP6' to 'burn' so that the process name shows up in the 
traces.  Every time system response disappears, I never get any traces 
after the second burnP6 fires up.  Most of the time, I can still move the 
mouse pointer for a few minutes (with serio lost synchro warnings on the 
serial console) before it goes dead, too.  Keyboard is almost always lost.

The results of two tests (one resulting in a meltdown) are located at:

http://sysex.net/testing/2.6.12-RT-V0.7.50-35

The 'test' directory has some traces with X and burnP6 (no VLC or
dockapps)  running.  These traces have chunks of dead time ranging from
roughly 500 to 900 us.

The 'crash' directory has a trace with X, burnP6, and VLC running, and a
bug warning.  As soon as the second burnP6 instance started up, the system
showed no signs of being alive other than the mouse synchro warnings on
the serial console.

Overall, I would have to say that RT_PREEMPT is nearly ready for
primetime, especially for audio, MIDI, and video.  SMT needs some help
when it comes to doing anything that requires X.  I'm not sure about true
SMP, since I can't find a true SMP system to play with right now.

Great Work, Ingo!


Best Regards,
--ww

