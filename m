Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268484AbUHQWZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268484AbUHQWZf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 18:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268477AbUHQWZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 18:25:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:36855 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266814AbUHQWZF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 18:25:05 -0400
Message-ID: <412285A5.9080003@mvista.com>
Date: Tue, 17 Aug 2004 15:24:37 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: Andrew Morton <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       albert@users.sourceforge.net, linux-kernel@vger.kernel.org,
       voland@dmz.com.pl, nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       johnstul@us.ibm.com, david+powerix@blue-labs.org
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
References: <1087948634.9831.1154.camel@cube> <87smcf5zx7.fsf@devron.myhome.or.jp> <20040816124136.27646d14.akpm@osdl.org> <Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau wrote:
> On Mon, 16 Aug 2004, Andrew Morton wrote:
> 
> 
>>OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>>
>>>Albert Cahalan <albert@users.sf.net> writes:
>>>
>>>
>>>>Even with the 2.6.7 kernel, I'm still getting reports of process
>>>>start times wandering. Here is an example:
>>>>
>>>>   "About 12 hours since reboot to 2.6.7 there was already a
>>>>   difference of about 7 seconds between the real start time
>>>>   and the start time reported by ps. Now, 24 hours since reboot
>>>>   the difference is 10 seconds."
>>>>
>>>>The calculation used is:
>>>>
>>>>   now - uptime + time_from_boot_to_process_start
>>>
>>>Start-time and uptime is using different source. Looks like the
>>>jiffies was added bogus lost counts.
>>>
>>>quick hack. Does this change the behavior?
>>
>>Where did this all end up?  Complaints about wandering start times are
>>persistent, and it'd be nice to get some fix in place...
>>
>>Thanks.
>>
> 
> 
> Seems my analysis of the problem wasn't perceived as such.
> 
> The problem is that in the above calculation 
> 
>   now - uptime + time_from_boot_to_process_start
> 
> "uptime" currently is an ntp-corrected precise time, while 
> "time_from_boot_to_process_start" just is the free-running "jiffies"
> value.

I see you think you have the solution, but I guess I am just dense here.  May be 
you could help me to see the error of my ways.  Here is my thinking:

"now" is from gettimeofday() and as such is ntp corrected.
"uptime" is also corrected.  In fact it is "now" + "wall_to_monotonic".  And 
"wall_to_monotonic" is _only_ changed by do_settime() when the clock is set.
"time_from_boot_to_process_start" is the same as "start_time" restated in 
seconds, i.e. it is a constant.  So, either one or more of the above assumtions 
is wrong, or  somebody is twiddling the clock.  Otherwise I don't see how the 
start time can move at all.
> 
> The problem is easily reproducible for me. It goes away if the change
> that rebased /proc/uptime on posix monotonic time and my followup patch to 
> fix the resulting rounding issues in jiffies64_to_clock_t() are backed out 
> with the following patch.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

