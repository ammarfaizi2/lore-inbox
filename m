Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266237AbUHQAba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266237AbUHQAba (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 20:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266453AbUHQAba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 20:31:30 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:60655 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266237AbUHQAb0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 20:31:26 -0400
Message-ID: <412151CA.4060902@mvista.com>
Date: Mon, 16 Aug 2004 17:31:06 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: Andrew Morton <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       albert@users.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       johnstul@us.ibm.com, david+powerix@blue-labs.org
Subject: Re: boot time, process start time, and NOW time
References: <1087948634.9831.1154.camel@cube> <87smcf5zx7.fsf@devron.myhome.or.jp> <20040816124136.27646d14.akpm@osdl.org> <Pine.LNX.4.53.0408170055180.14122@gockel.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.53.0408170055180.14122@gockel.physik3.uni-rostock.de>
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
> 
> 
> 
> 
> The trouble seems to be due to the patch below, part of a larger cleanup
> (http://linus.bkbits.net:8080/linux-2.5/cset%403ef4851dGg0fxX58R9Zv8SIq9fzNmQ?nav=index.html|src/.|src/fs|src/fs/proc|related/fs/proc/proc_misc.c)
> by George.
> 
> Quoting from the changelog entry:
> 
> "Changes the uptime code to use the posix_clock_monotonic notion of 
> uptime instead of the jiffies.  This time will track NTP changes and so should 
> be better than your standard wristwatch (if your using ntp)."
> 
> George is absolutely right that it's more precise. However, it's also 
> inconsistent with the process start times which use plain uncorrected 
> jiffies. ps stumbles over this inconsistency.
> 
> Simple fix: revert the patch below.
> Complicated fix: correct process start times in fork.c (no patch provided, 
> too complicated for me to do).
> 
> George?

Hm...  That patch was for a reason...  It seems to me that doing anything short 
of putting "xtime" (or better, clock_gettime() :)) in at fork time is not going 
to fix anything.   As written the start_time in the task_struct is fixed.  If 
"now - uptime + time_from_boot_to_process_start" it is wandering, it must be the 
fault of "now - uptime".  Since this seems to be wandering, and we corrected 
uptime in the referenced patch, is it safe to assume that "now" is actually 
being computed from "jiffies" rather than a gettimeofday()?

Seems like that is where we should be changing things.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

