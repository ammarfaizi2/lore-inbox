Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264434AbRFICoa>; Fri, 8 Jun 2001 22:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264435AbRFICoV>; Fri, 8 Jun 2001 22:44:21 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:17029 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S264434AbRFICoQ>; Fri, 8 Jun 2001 22:44:16 -0400
Message-ID: <3B218BA8.6A8C2EB0@uow.edu.au>
Date: Sat, 09 Jun 2001 12:36:24 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jonathan Morton <chromi@cyberspace.org>
CC: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: VM Report was:Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.LNX.4.21.0106081701300.2422-100000@freak.distro.conectiva>,
		<15137.15472.264539.290588@gargle.gargle.HOWL> <l0313032bb7471092da13@[192.168.239.105]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Morton wrote:
> 
> [ Re-entering discussion after too long a day and a long sleep... ]
> 
> >> There is the problem in terms of some people want pure interactive
> >> performance, while others are looking for throughput over all else,
> >> but those are both extremes of the spectrum.  Though I suspect
> >> raw throughput is the less wanted (in terms of numbers of systems)
> >> than keeping interactive response good during VM pressure.
> >
> >And this raises a very very important point: raw throughtput wins
> >enterprise-like benchmarks, and the enterprise people are the ones who pay
> >most of hackers here. (including me and Rik)
> 
> Very true.  As well as the fact that interactivity is much harder to
> measure.  The question is, what is interactivity (from the kernel's
> perspective)?  It usually means small(ish) processes with intermittent
> working-set and CPU requirements.  These types of process can safely be
> swapped out when not immediately in use, but the kernel has to be able to
> page them in quite quickly when needed.  Doing that under heavy load is
> very non-trivial.

For the low-latency stuff, latency can be defined as
the worst-case time to schedule a userspace process in
response to an interrupt.

That metric is also appropriate in this case, (latency equals
interactivity), although here you don't need to be so fanatical
about the *worst case*.  A few scheduling blips here are less
fatal.

I have tools to measure latency (aka interactivity).  At
http://www.uow.edu.au/~andrewm/linux/schedlat.html#downloads
there is a kernel patch called `rtc-debug' which causes
the PC RTC to generate a stream of interrupts.  A user-space
task called `amlat' responds to those interrupts and
reads the RTC device.  The patched RTC driver can then
measure the elapsed time between the interrupt and the
read from userspace.  Voila: latency.

When you close the RTC device (by killing amlat), the RTC
driver will print out a histogram of the latencies.

`amlat' at present gives itself SCHED_RR policy and
runs under mlockall() - for your testing you'll need
to delete those lines.

So.  Simple apply rtc-debug, run `amlat' and kill it
when you've finished the workload.

The challenge will be to relate the latency histogram
to human-perceived interactivity.   I'm not sure of
the best way of doing that.  Perhaps monitor the 90th
percentile, and aim to keep it below 100 milliseconds.
Also, `amlat' should do a bit of disk I/O as well.
