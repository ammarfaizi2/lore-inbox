Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268486AbUHQWik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268486AbUHQWik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 18:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268488AbUHQWij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 18:38:39 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:34183 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268486AbUHQWiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 18:38:12 -0400
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, Andrew Morton <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       albert@users.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       david+powerix@blue-labs.org
In-Reply-To: <412285A5.9080003@mvista.com>
References: <1087948634.9831.1154.camel@cube>
	 <87smcf5zx7.fsf@devron.myhome.or.jp>
	 <20040816124136.27646d14.akpm@osdl.org>
	 <Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de>
	 <412285A5.9080003@mvista.com>
Content-Type: text/plain
Message-Id: <1092782243.2429.254.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 17 Aug 2004 15:37:24 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 15:24, George Anzinger wrote:
> Tim Schmielau wrote:
> > On Mon, 16 Aug 2004, Andrew Morton wrote:
> > 
> > 
> >>OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> >>
> >>>Albert Cahalan <albert@users.sf.net> writes:
> >>>
> >>>
> >>>>Even with the 2.6.7 kernel, I'm still getting reports of process
> >>>>start times wandering. Here is an example:
> >>>>
> >>>>   "About 12 hours since reboot to 2.6.7 there was already a
> >>>>   difference of about 7 seconds between the real start time
> >>>>   and the start time reported by ps. Now, 24 hours since reboot
> >>>>   the difference is 10 seconds."
> >>>>
> >>>>The calculation used is:
> >>>>
> >>>>   now - uptime + time_from_boot_to_process_start
> >>>
> >>>Start-time and uptime is using different source. Looks like the
> >>>jiffies was added bogus lost counts.
> >>>
> >>>quick hack. Does this change the behavior?
> >>
> >>Where did this all end up?  Complaints about wandering start times are
> >>persistent, and it'd be nice to get some fix in place...
> >>
> >>Thanks.
> >>
> > 
> > 
> > Seems my analysis of the problem wasn't perceived as such.
> > 
> > The problem is that in the above calculation 
> > 
> >   now - uptime + time_from_boot_to_process_start
> > 
> > "uptime" currently is an ntp-corrected precise time, while 
> > "time_from_boot_to_process_start" just is the free-running "jiffies"
> > value.
> 
> I see you think you have the solution, but I guess I am just dense here.  May be 
> you could help me to see the error of my ways.  Here is my thinking:
> 
> "now" is from gettimeofday() and as such is ntp corrected.
> "uptime" is also corrected.  In fact it is "now" + "wall_to_monotonic".  And 
> "wall_to_monotonic" is _only_ changed by do_settime() when the clock is set.
> "time_from_boot_to_process_start" is the same as "start_time" restated in 
> seconds, i.e. it is a constant.  So, either one or more of the above assumtions 
> is wrong, or  somebody is twiddling the clock.  Otherwise I don't see how the 
> start time can move at all.

The problem is start time is derived from task->start_time which is the
jiffies value at the time the process started. Thus interval calculated
by: (start_time = p->start_time - INITIAL_JIFFIES) or (run_time =
get_jiffies_64() - p->start_time) is not NTP adjusted. 

So both (uptime - run_time) or (boot_time + start_time) will have
problems. 

What needs to happen is task->start_time is changed to a timespec which
is set at fork time to be do_posix_clock_monotonic_gettime(). Then in
proc_pid_stat() we can calculate the appropriate user-jiffies value.


task->start_time is used at the following lines:

include/linux/sched.h: 460
kernel/fork.c: 964
fs/proc/array.h: 359
kernel/acct.c: 404
mm/oom_kill.c: 64

I'm stuck trying to fix the last two files at the moment. Please let me
know if you see any other uses.

thanks
-john


