Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbVLMXjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbVLMXjc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 18:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVLMXjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 18:39:32 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:59638 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1030309AbVLMXjc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 18:39:32 -0500
Message-ID: <439F5B91.4010903@mvista.com>
Date: Tue, 13 Dec 2005 15:38:57 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
CC: Thomas Gleixner <tglx@linutronix.de>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
References: <17594.192.54.193.25.1134477932.squirrel@rousalka.dyndns.org>
In-Reply-To: <17594.192.54.193.25.1134477932.squirrel@rousalka.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Mailhot wrote:
> "This is your interpretation and I disagree.
> 
> If I set up a timer with a 24 hour interval, which should go off
> everyday at 6:00 AM, then I expect that this timer does this even when
> the clock is set e.g. by daylight saving. I think, that this is a
> completely valid interpretation and makes a lot of sense from a
> practical point of view. The existing implementation does it that way
> already, so why do we want to change this ?"

I think that there is a miss understanding here.  The kernel timers, 
at this time, do not know or care about daylight savings time.  This 
is not really a clock set but a time zone change which does not 
intrude on the kernels notion of time (that being, more or less UTC).
> 
> Please do not hardcode anywhere 1 day = 24h or something like this.
> Relative timers should stay relative not depend on DST.

As far as timers go, it is only the user who understands any 
abstraction above the second.  I.e. hour, day, min. all are 
abstractions done in user land.

There is, however, one exception, the leap second.  The kernel inserts 
this at midnight UTC and does use a fixed constant (86400) to find 
midnight.
> 
> If someone needs a timer that sets of everyday at the same (legal) time,
> make him ask for everyday at that time not one time + n x 24h.
> 
> Some processes need an exact legal hour
> Other processes need an exact duration

I think what we are saying is that ABS time flag says that the timer 
is supposed to expire at the given time "by the specified clock", 
however that time is arrived at, be it the initial time or the initial 
time plus one or more intervals.  We are NOT saying that these 
intervals are the same size, but only that the given clock says that 
they are the same size, thus any clock setting done during an interval 
can cause that interval to be of a different size.

Without the ABS time flag, we are talking about intervals (the initial 
and subsequent) that are NOT affected by clock setting and are thus as 
close to the requested duration as possible.
> 
> In a DST world that's not the same thing at all - don't assume one or the
> other, have coders request exactly what they need and everyone will be
> happy.

This is why the standard introduced the ABS time flag.  It does NOT, 
however, IMHO touch on the issue of time zone changes introduced by 
shifting into and out of day light savings time.
> 
> I can tell from experience trying to fix code which assumed one day = 24h
> is not fun at all. And yes sometimes the difference between legal and UTC
> time matters a lot.
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
