Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268504AbUHQXJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268504AbUHQXJe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 19:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268509AbUHQXJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 19:09:33 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:64427 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S268504AbUHQXJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 19:09:07 -0400
Date: Wed, 18 Aug 2004 01:07:13 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: john stultz <johnstul@us.ibm.com>
cc: george anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       albert@users.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       david+powerix@blue-labs.org
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
In-Reply-To: <1092782243.2429.254.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.53.0408180051540.25366@gockel.physik3.uni-rostock.de>
References: <1087948634.9831.1154.camel@cube>  <87smcf5zx7.fsf@devron.myhome.or.jp>
  <20040816124136.27646d14.akpm@osdl.org> 
 <Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de> 
 <412285A5.9080003@mvista.com> <1092782243.2429.254.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2004, john stultz wrote:

> On Tue, 2004-08-17 at 15:24, George Anzinger wrote:
> > I see you think you have the solution, but I guess I am just dense here.  May be 
> > you could help me to see the error of my ways.  Here is my thinking:
> > 
> > "now" is from gettimeofday() and as such is ntp corrected.
> > "uptime" is also corrected.  In fact it is "now" + "wall_to_monotonic".  And 
> > "wall_to_monotonic" is _only_ changed by do_settime() when the clock is set.
> > "time_from_boot_to_process_start" is the same as "start_time" restated in 
> > seconds, i.e. it is a constant.  So, either one or more of the above assumtions 
> > is wrong, or  somebody is twiddling the clock.  Otherwise I don't see how the 
> > start time can move at all.

Start time indeed is a constant for each process, and doesn't drift. 
The problem trather is that a (slightly) wrong start time is assigned
to newly created processes.

> The problem is start time is derived from task->start_time which is the
> jiffies value at the time the process started. Thus interval calculated
> by: (start_time = p->start_time - INITIAL_JIFFIES) or (run_time =
> get_jiffies_64() - p->start_time) is not NTP adjusted. 
> 
> So both (uptime - run_time) or (boot_time + start_time) will have
> problems. 
> 
> What needs to happen is task->start_time is changed to a timespec which
> is set at fork time to be do_posix_clock_monotonic_gettime(). Then in
> proc_pid_stat() we can calculate the appropriate user-jiffies value.

Yep.

> task->start_time is used at the following lines:
> 
> include/linux/sched.h: 460
> kernel/fork.c: 964
> fs/proc/array.h: 359
> kernel/acct.c: 404
> mm/oom_kill.c: 64
> 
> I'm stuck trying to fix the last two files at the moment. Please let me
> know if you see any other uses.

Where's the problem with the last two of them?
I think I can do them if you fix the first three, so that I can see which
time source is going to replace jiffies here.


Tim
