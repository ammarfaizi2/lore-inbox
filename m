Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268868AbUI2T2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268868AbUI2T2P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 15:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268884AbUI2T2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 15:28:15 -0400
Received: from gw02.applegatebroadband.net ([207.55.227.2]:60911 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S268868AbUI2T2A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 15:28:00 -0400
Message-ID: <415B0C9E.5060000@mvista.com>
Date: Wed, 29 Sep 2004 12:27:26 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Ulrich Drepper <drepper@redhat.com>, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: Posix compliant CLOCK_PROCESS/THREAD_CPUTIME_ID V4
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com> <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com> <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com> <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com> <4159B920.3040802@redhat.com> <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com> <415AF4C3.1040808@mvista.com> <Pine.LNX.4.58.0409291054230.25276@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409291054230.25276@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Wed, 29 Sep 2004, George Anzinger wrote:
> 
> 
>>Christoph Lameter wrote:
>>
>>>George asked for a test program so I wrote one and debugged the patch.
>>>The test program uses syscall to bypass glibc processing. I have been
>>>working on a patch for glibc but that gets a bit complicated
>>>because backwards compatibility has to be kept. Maybe tomorrow.
>>>Found also that glibc allows the setting of these clocks so I also
>>>implemented that and used it in the test program.  Setting these
>>>clocks modifies stime and utime directly, which may not be such a good
>>>idea. Do we really need to be able to set these clocks?
>>
>>Another way of doing this is to save these values in the task structure.  If
>>null, use the direct value of stime, utime, if not, adjust by the saved value
>>(i.e. saved value would represent time zero).
> 
> 
> But this would require two additional int field in task_t just for that
> rarely used functionality.

Exactly.  What does the community want?  An alternative is to allocate a small 
block of memory for this and managed it from the posix-timers.c code.  It would 
only be referenced by get_clock and set_clock.  And be released by the 
exit_itimers() code.
> 
> 
>>Please, when sending patches, attach them.  This avoids problems with mailers,
>>on both ends, messing with white space.  They still appear in line, at least in
>>some mailers (mozilla in my case).
> 
> 
> The custom on lkml, for Linus and Andrew is to send them inline. I also
> prefer them inline. Will try to remember sending attachments when sending a
> patch to you.

I think they WILL be inline as well as attached if you attach them.  The 
difference is that in both presentations neither mailer will mess with white 
space.  This means that long lines will not be wrapped and tabs vs space will 
not be changed.

Try sending yourself one and see it this is not true for your mailer.

> 
>>As to the test program, what happens when you attempt to set up a timer on these
>>clocks?  (No, I don't think it should work, but we DO want to properly error
>>out.  And the test should verify that this happens.)  By the way, if you use the
>>support package from sourceforge, you will find a lot of test harness stuff.
> 
> 
> That is an interesting issue. If that would work correctly one could
> trigger an signal if more than a certain amount of cputime is used.
> It looks though that it will create an interrupt based on real time.
> 
> SuS says:
> 
>  Each implementation defines a set of clocks that can be used as timing
>  bases for per-process timers. All implementations support a clock_id of
>  CLOCK_REALTIME.
> 
> So restrict timer_create to CLOCK_REALTIME and CLOCK_MONOTONIC? Is it
> necessary to be able to derive a timer from a timer derives from those
> two?
> 
> something like the following (just inlined for the discussion ...)?

NO.  This is handled through the dispatch table (as set up when you register the 
clock).  You just supply a timer_create() function that returns the right error. 
  Likewise, attempts to use clock_nanosleep().  The issue with clock_nanosleep, 
however, is that it, at this time, is not sent through the dispatch table.  This 
should be changed to, again call the same error function.
> 
> --- linux-2.6.9-rc2.orig/kernel/posix-timers.c  2004-09-28 20:29:28.000000000 -0700
> +++ linux-2.6.9-rc2/kernel/posix-timers.c       2004-09-29 11:12:37.814713085 -0700
> @@ -585,8 +585,8 @@
>         sigevent_t event;
>         int it_id_set = IT_ID_NOT_SET;
> 
> -       if ((unsigned) which_clock >= MAX_CLOCKS ||
> -                               !posix_clocks[which_clock].res)
> +       if ((unsigned) which_clock != CLOCK_REALTIME &&
> +           (unsigned) which_clock != CLOCK_MONOTONIC)
>                 return -EINVAL;
> 
>         new_timer = alloc_posix_timer();
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

