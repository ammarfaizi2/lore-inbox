Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266482AbUHQAhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266482AbUHQAhY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 20:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUHQAhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 20:37:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:3575 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266482AbUHQAhT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 20:37:19 -0400
Message-ID: <41215334.7050203@mvista.com>
Date: Mon, 16 Aug 2004 17:37:08 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Tim Schmielau <tim@physik3.uni-rostock.de>, Andrew Morton <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       albert@users.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       david+powerix@blue-labs.org
Subject: Re: boot time, process start time, and NOW time
References: <1087948634.9831.1154.camel@cube>	 <87smcf5zx7.fsf@devron.myhome.or.jp>	 <20040816124136.27646d14.akpm@osdl.org>	 <Pine.LNX.4.53.0408170055180.14122@gockel.physik3.uni-rostock.de> <1092702077.2429.88.camel@cog.beaverton.ibm.com>
In-Reply-To: <1092702077.2429.88.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Mon, 2004-08-16 at 16:08, Tim Schmielau wrote:
> 
>>On Mon, 16 Aug 2004, Andrew Morton wrote:
>>
>>
>>>OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>>>
>>>>Albert Cahalan <albert@users.sf.net> writes:
>>>>
>>>>
>>>>>Even with the 2.6.7 kernel, I'm still getting reports of process
>>>>>start times wandering. Here is an example:
>>>>>
>>>>>   "About 12 hours since reboot to 2.6.7 there was already a
>>>>>   difference of about 7 seconds between the real start time
>>>>>   and the start time reported by ps. Now, 24 hours since reboot
>>>>>   the difference is 10 seconds."
>>>>>
>>>>>The calculation used is:
>>>>>
>>>>>   now - uptime + time_from_boot_to_process_start
>>>>
>>>>Start-time and uptime is using different source. Looks like the
>>>>jiffies was added bogus lost counts.
>>>>
>>>>quick hack. Does this change the behavior?
>>>
>>>Where did this all end up?  Complaints about wandering start times are
>>>persistent, and it'd be nice to get some fix in place...
>>
>>
>>
>>The trouble seems to be due to the patch below, part of a larger cleanup
>>(http://linus.bkbits.net:8080/linux-2.5/cset%403ef4851dGg0fxX58R9Zv8SIq9fzNmQ?nav=index.html|src/.|src/fs|src/fs/proc|related/fs/proc/proc_misc.c)
>>by George.
>>
>>Quoting from the changelog entry:
>>
>>"Changes the uptime code to use the posix_clock_monotonic notion of 
>>uptime instead of the jiffies.  This time will track NTP changes and so should 
>>be better than your standard wristwatch (if your using ntp)."
>>
>>George is absolutely right that it's more precise. However, it's also 
>>inconsistent with the process start times which use plain uncorrected 
>>jiffies. ps stumbles over this inconsistency.
>>
>>Simple fix: revert the patch below.
>>Complicated fix: correct process start times in fork.c (no patch provided, 
>>too complicated for me to do).
> 
> 
> Hmm. While that patch fixed the uptime proc entry, I thought the issue
> was with process start times. I'm looking at fixing the start_time
> assignment in proc_pid_stat(). My suspicion is that we need to use ACTHZ
> in jiffies64_to_clock_t().

I really don't see how the start_time that proc_pid_stat() is producing could be 
anything but a constant.  The complaint is that it moves, not that it is 
incorrect, right?
> 
> Something like the patch below.
> 
> thanks
> -john
> 
> ===== include/linux/times.h 1.6 vs edited =====
> --- 1.6/include/linux/times.h	2004-05-10 04:25:49 -07:00
> +++ edited/include/linux/times.h	2004-08-16 16:22:13 -07:00
> @@ -48,6 +48,7 @@
>  	 * but even this doesn't overflow in hundreds of years
>  	 * in 64 bits, so..
>  	 */
> +	x = (x * ACT_HZ)>>8;  /* compensate for ACT_HZ != HZ */
>  	x *= TICK_NSEC;
>  	do_div(x, (NSEC_PER_SEC / USER_HZ));
>  #endif
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

