Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267970AbTCFJuh>; Thu, 6 Mar 2003 04:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267974AbTCFJua>; Thu, 6 Mar 2003 04:50:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:24544 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267970AbTCFJuY>;
	Thu, 6 Mar 2003 04:50:24 -0500
Date: Thu, 6 Mar 2003 02:00:44 -0800
From: Andrew Morton <akpm@digeo.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: rml@tech9.net, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch] "interactivity changes", sched-2.5.64-A4
Message-Id: <20030306020044.549df2a4.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0303060723050.2114-100000@localhost.localdomain>
References: <20030228202555.4391bf87.akpm@digeo.com>
	<Pine.LNX.4.44.0303060723050.2114-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Mar 2003 10:00:45.0403 (UTC) FILETIME=[415742B0:01C2E3C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> well, i took out the interactivity improvements from the 2.5.59-E6
> scheduler patch, to keep the pure HT-scheduler bits only, and havent added
> them back since. The two patch-sets (interactivity, and HT scheduler)
> interact heavily, so i did not post the patch separately, but here it goes
> as-is, against 2.5.64 - does it help your interactivity problems on UP
> setups?

Ah, this is the patch I thought I was testing last time ;) A bit more careful
this time:

- The tbench-starves-everything-on-uniprocessor problem (well, I'd have to
  say it is a bug) is fixed.

  When running a compilation against a `tbench 4' one would expect the
  compilation to be slowed down by maybe 4x.  It seems a little slower than
  that, but it is in that ballpark.  At least the compilation makes _some_
  progress now.

- The large performance shift with `contest io_load' is still there.

  This test times how long it takes to compile a kernel in the presence of
  massive streaming writeout to the same filesystem.

  2.5.64, UP, !preempt, ext3:
	Finished compiling kernel: elapsed: 409 user: 107 system: 11
	Finished io_load: elapsed: 409 user: 2 system: 37 loads: 16810

	Finished compiling kernel: elapsed: 283 user: 107 system: 10
	Finished io_load: elapsed: 286 user: 1 system: 17 loads: 7990

  2.5.66+sched-2.5.64-A4, UP, !preempt, ext3:
	Finished compiling kernel: elapsed: 910 user: 108 system: 12
	Finished io_load: elapsed: 912 user: 4 system: 75 loads: 35210

	Finished compiling kernel: elapsed: 940 user: 108 system: 12
	Finished io_load: elapsed: 940 user: 4 system: 78 loads: 36510
       
  The compilation took twice as long, and the streaming write made much
  more progress.

  Given that a monster `dd if=/dev/zero' takes only a few percent CPU
  anyway, it is quite odd that this is happening.

  Regardless of the fairness issue we want to maximise CPU utilisaton in
  this workload.  The above figures show that the total CPU utilisation has
  fallen from

	409 / (107+11+4+75) = 48% CPU
  and	283 / (107+10+1+17) = 48% CPU

  down to

	910 / (108+12+4+75) = 22% CPU
  and	940 / (108+12+4+78) = 21% CPU

  which is quite bad.

  I cannot explain this - why so much idle time?  It seems to happen with
  ext2 as well, so it may not be the weird interaction between kjournald, the
  CPU scheduler and the IO scheduler which I initially suspected.  Poor me.

- On the X server problem: The patch pretty much fixes it up.  I have to
  work pretty hard to make the UI flip into sucky mode, and it is much less
  severe.  I'd say it it acceptable.

  Renicing X to -10 makes it significantly better.  Text under moved
  windows gets redrawn promptly.  But renicing X is not a very adequate
  solution in my experience - I've found that when the email client goes off
  to parse a 1000-message folder the scheduler can decide to penalise it, and
  the application freezes up for some time.

Overall, yep, good patch and we should run with it.  I need to work out what
on earth has happened to the IO load balancing.  We only got that working
properly a few days back.


