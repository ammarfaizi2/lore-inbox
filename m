Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268123AbUHQHAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268123AbUHQHAq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 03:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268127AbUHQHAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 03:00:46 -0400
Received: from [139.30.44.16] ([139.30.44.16]:56747 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S268123AbUHQHAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 03:00:23 -0400
Date: Tue, 17 Aug 2004 08:56:10 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: George Anzinger <george@mvista.com>
cc: Andrew Morton <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       albert@users.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       johnstul@us.ibm.com, david+powerix@blue-labs.org
Subject: Re: boot time, process start time, and NOW time
In-Reply-To: <412151CA.4060902@mvista.com>
Message-ID: <Pine.LNX.4.53.0408170851020.15157@gockel.physik3.uni-rostock.de>
References: <1087948634.9831.1154.camel@cube> <87smcf5zx7.fsf@devron.myhome.or.jp>
 <20040816124136.27646d14.akpm@osdl.org> <Pine.LNX.4.53.0408170055180.14122@gockel.physik3.uni-rostock.de>
 <412151CA.4060902@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Whoops, this generated quite some traffic while I was asleep.
I'll just comment on some of the posts in a single mail.)

On Mon, 16 Aug 2004, George Anzinger wrote:

> > George is absolutely right that it's more precise. However, it's also
> > inconsistent with the process start times which use plain uncorrected
> > jiffies. ps stumbles over this inconsistency.
> >
> > Simple fix: revert the patch below.
> > Complicated fix: correct process start times in fork.c (no patch 
provided,
> > too complicated for me to do).
> >
> > George?
>
> Hm...  That patch was for a reason...  It seems to me that doing 
anything shor
t
> of putting "xtime" (or better, clock_gettime() :)) in at fork time is 
not goin
g
> to fix anything.

Yep. I think that's the way to go.

>                   As written the start_time in the task_struct is fixed.  
If
> "now - uptime + time_from_boot_to_process_start" it is wandering, it 
must be t
he
> fault of "now - uptime".  Since this seems to be wandering, and we 
corrected
> uptime in the referenced patch, is it safe to assume that "now" is 
actually
> being computed from "jiffies" rather than a gettimeofday()?

No, it's not "now" which is wandering, but the difference between "uptime"
and "time_from_boot_to_process_start". The former gets corrected by ntp,
while the latter is computed from "jiffies" and thus uncorrected.



On Mon, 16 Aug 2004, john stultz wrote:

> Hmm. While that patch fixed the uptime proc entry, I thought the issue
> was with process start times. I'm looking at fixing the start_time
> assignment in proc_pid_stat(). My suspicion is that we need to use ACTHZ
> in jiffies64_to_clock_t().

No, we already fixed jiffies64_to_clock_t() by using TICK_NSEC instead of
HZ.



On Mon, 16 Aug 2004, George Anzinger wrote:

> I really don't see how the start_time that proc_pid_stat() is producing 
could be
> anything but a constant.  The complaint is that it moves, not that it is
> incorrect, right?

No, proc_pid_stat() indeed gives a constant. But userspace somehow has to
figure out what a value in "jiffies" means. Since "jiffies" started from 
zero
at boot time, "uptime" is needed for that. However, we "fixed" uptime to
get corrected by ntp, so that userspace now has a drifting notion of 
"jiffies".



On Tue, 16 Aug 2004, Albert Cahalan wrote:

> If you're interested in reducing (not solving)
> the problem for the 2.6.x series, you might change
> HZ to something that works better with the PIT.

No, that's not needed anymore. We've already started to account for the
difference, e.g. by using TICK_NSEC in jiffies64_to_clock_t().

Problem is, we are only halfway through the attempt to remove the use
of "jiffies" as a clock, so currently to incompatible time sources get 
mixed
up.

The other problem seems to be that this move away from "jiffies" seems to
happen on an ad-hoc basis whenever we encounter a problem, rather than
with a big picture in mind.
John Stultz once laid out a concept for a (coordinated) rewrite in 2.7,
and I think this still is a good idea.
