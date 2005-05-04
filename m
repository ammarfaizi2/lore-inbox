Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVEDVtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVEDVtm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 17:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVEDVtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 17:49:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:34030 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261690AbVEDVql
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 17:46:41 -0400
Message-ID: <427942B6.2030102@mvista.com>
Date: Wed, 04 May 2005 14:46:30 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Darren Hart <dvhltc@us.ibm.com>
CC: Nishanth Aravamudan <nacc@us.ibm.com>, john stultz <johnstul@us.ibm.com>,
       Liu Qi <liuqi@ict.ac.cn>,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Help with the high res timers
References: <E1DSl7F-0002v2-Ck@sc8-sf-web4.sourceforge.net> <20050503024336.GA4023@ict.ac.cn> <4277EEF7.8010609@mvista.com> <1115158804.13738.56.camel@cog.beaverton.ibm.com> <427805F8.7000309@mvista.com> <20050504001307.GF3372@us.ibm.com> <42790207.30709@mvista.com> <42791114.60109@us.ibm.com>
In-Reply-To: <42791114.60109@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darren Hart wrote:
> George Anzinger wrote:
>>  |First I want to express my joy that we are discussing these issues at
>>  some depth.
>>
~
>>  The point is, the standard, low res, timer code needs to be only
>>  minimally aware of the HR bits.  On the other hand, since the HR timer
>>  will be started on expiration of the low res timer, we need that
>>  expiration to be aligned with the clock in a stable, predictable long
>>  term way.  (For what its worth, we have yet to address NTP clock
>>  drifting in the HRT patch, so that is still a fly in this web of time.)
>>
> 
> You are still dependent on jiffies which is very unreliable do to lost 
> ticks, HZ vs ACTHZ, etc.  Even if you use a periodic tick, it seems the 
> HRT code would still benefit from a human-time soft-timers sub-system 
> that wasn't affected by such things.

Well, first we clean up jiffies WRT lost ticks.  We just don't have them with 
the HRT patch.  If you mean being late, just as John's code give the right time 
all the time so does the HRT time code.  The notion is that the TSC or the 
pm_counter can carry us over a couple of lost ticks as well as the between tick 
times.  So, we aren't affected by lost ticks and ACTHZ just is not part of the 
POSIX clocks & timers world.
> 
> 
>> >
~
>>  For what its worth, we have such a clock in HRT.  It is expressed in
>>  jiffies and arch_cycles, but jiffies is what is used today as the
>>  "standard" for internal system time.  This gets into the area of just
>>  how to express time in areas where you need to quickly get and compare
>>  the time.  After a lot of though, I decided to use arch_cycles rather
>>  than nanoseconds because arch_cycles are directly readable from the
>>  hardware.  Any other unit of time requires a conversion, and, as you
>>  know, usually requires 64-bits as well.  By staying with arch_cycles we
>>  avoid "most" of the conversion overhead.
>>
> 
> I can see why you might want to use arch_cycles, and at least it is an 
> absolute time.  Jiffies though is not.  Perhaps HRT could benefit from a 
> conversion to "milliseconds + arch_cycles" ?

Two points here, first, jiffies, once you convince yourself that the PIT is the 
gold time standard, IS the time.  It is the best time we have in the x86 world 
and in all other archs too.  That is what the arch time code is supposed to do. 
  Your milliseconds is, or should be, derived from jiffies or, in other archs, 
the same place jiffies is derived from, i.e. the time keeping "rock" on the 
mother board.  To account for things like NTP, we always grab arch_cycles, 
xtime, jiffies, and wall_to_monotonic under a read lock at the same time.  This 
allows us to peg one expression of time against another.

All that said, for HRT to work correctly, the timer must have a high resolution 
time contained in its structure.  Currently this is jiffies and arch_cycles. 
Further, we need to know that when that jiffies value arrives, we will get 
called ASAP, and not at some random time between that value and the next time it 
changes.  For repeating timers we use these values _after_ the timer expires to 
figure the next expire time, so if they are changed by the timer code, we are in 
trouble.
> 
>> >
>> >
~
>> > I think currently, we do something similar to next_timer_interrupt(),
>> > making sure we update the stored value whenever we add a new timer, if
>> > necessary. Except now, we will determine the next time to set the hw
>> > timer to go off every time we expire timers.
>>
>>
>>  Finding the next timer is a high overhead operation....
> 
> Perhaps it is now, but does it have to be?  The process scheduler used 
> to be full of O(N) algorithms to, but they were all converted to O(1) by 
> doing several incremental calculations instead of one huge one.  Perhaps 
> something similar could be done with timers by caching a couple of 
> timer expirations and modifying them as timers are added, removed, and 
> modified.  Just brainstorming here.

Believe me I did a lot of "brainstorming" around how to keep HR timers along 
with the LR timers.  Until just recently I had a different timer list in timer.c 
which was hashed on the low timer bits.  After much thought and finally 
realizing that MOST timers do NOT expire, I came to conclude that the current 
list is just right given what it is currently used for.  The stuff that is not 
O(1) in this structure is the cascading.  The reason this is not a big issue is 
just that most timers are removed prior to the cascade.

In the list structure I used to use, I had to order timers by expire time, 
accounting for both jiffies and arch_cycles.  Now HRT uses the same old cascade 
structure and the timer code, for the most part, ignores the arch_cycles member. 
  Only on expire is it discovered and the timer sent to the hrtime code where 
the timer is entered in to a very short list of timers that are to expire some 
time between now and the next jiffie.  This is a very simple O(N/2) list, but it 
is also really short.  (This is a simplified discussion.  The code is on the HRT 
web site and in the HRT CVS on that site for the curious.)
> 
>>
>> >
~
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
