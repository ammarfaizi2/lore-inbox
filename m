Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263563AbTCUHul>; Fri, 21 Mar 2003 02:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263564AbTCUHul>; Fri, 21 Mar 2003 02:50:41 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:18929 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S263563AbTCUHuj>;
	Fri, 21 Mar 2003 02:50:39 -0500
Message-ID: <3E7AC6C9.5000401@mvista.com>
Date: Fri, 21 Mar 2003 00:01:13 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joel Becker <Joel.Becker@oracle.com>
CC: john stultz <johnstul@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Clock monotonic  a suggestion
References: <3E7A59CD.8040700@mvista.com> <20030321025045.GX2835@ca-server1.us.oracle.com>
In-Reply-To: <20030321025045.GX2835@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:
> On Thu, Mar 20, 2003 at 04:16:13PM -0800, george anzinger wrote:
> 
>>Define CLOCK_MONOTONIC to be the same as
>>(gettimeofday() + wall_to_monotonic).
>>...
>>Both clocks will tick at the same rate, even under NTP corrections.
>>The conversion is a simple (well almost simple) add.
>>Both clocks will have the same resolution.
> 
> 
> 	The issue for CLOCK_MONOTONIC isn't one of resolution.  The
> issue is one of accuracy.  If the monotonic clock is ever allowed to
> have an offset or a fudge factor, it is broken.  Asking the monotonic
> clock for time must always, without fail, return the exact, accurate
> time since boot (or whatever sentinal time) in the the units monotonic
> clock is using.  This precludes gettimeofday().

To carry this to the absurd, it also precludes most anything other 
than a GPS or WWV based clock.  If we are to have any clock that is 
right (to its resolution) it will require help from NTP or some other 
standard (such as GPS).  From this point of view we are better off 
with gettimeofday() which is NTP corrected.

On might argue for a system the other way around, i.e. the monotonic 
clock is NTP corrected and used to derive gettimeofday by adding an 
offset.  Set time would then just set this offset.  I think this would 
work, but haven't found a really good argument for doing it this way, 
given that we already have gettimeofday set up to use NTP.

Buried in here is a need to rate correct the sub jiffie interpolation 
done by gettimeofday, but that has already been pointed out by others 
and should be done in any case.

> 	If the system is delayed (udelay() or such) by a driver or 
> something for 10 seconds, then you have this (assume gettimeofday is
> in seconds for simplicity):
> 
> 1    gettimeofday = 1000000000
> 2    driver delays 10s
> 3    gettimeofday = 1000000000
> 4    timer notices lag and adjusts

Uh, how is this done?  At this time there IS correction for delays up 
to about a second built into the gettimeofday() code.  You seem to be 
assuming that we can do better than this with clock monotonic.  Given 
the right hardware, this may even be possible, but why not correct 
gettimeofday in the same way?

> 5    gettimeofday = 1000000010
> 
> 	In the usual case, if a program calls gettimeofday() between 3
> and 4, the program gets the wrong time.  For most programs, this doesn't
> matter.  CLOCK_MONOTONIC is designed for those uses where it absolutely
> matters.  If an application queries CLOCK_MONOTONIC at 3.5, it must
> return 1000000010, not 1000000000.
> 
> Joel

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

