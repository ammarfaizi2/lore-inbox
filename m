Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263300AbTJQEbW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 00:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbTJQEbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 00:31:22 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:46297 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263300AbTJQEbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 00:31:20 -0400
Subject: Re: decaying average for %CPU
From: Albert Cahalan <albert@users.sf.net>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3F8F6020.2040206@cyberone.com.au>
References: <1066358155.15931.145.camel@cube>
	 <3F8F5A53.50209@cyberone.com.au> <1066359629.15920.161.camel@cube>
	 <3F8F6020.2040206@cyberone.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1066364241.15931.180.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Oct 2003 00:17:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-16 at 23:21, Nick Piggin wrote:
> Albert Cahalan wrote:
> >On Thu, 2003-10-16 at 22:56, Nick Piggin wrote:
> >>Albert Cahalan wrote:
> >>
> >>>The UNIX standard requires that Linux provide
> >>>some measure of a process's "recent" CPU usage.
> >>>Right now, it isn't provided. You might run a
> >>>CPU hog for a year, stop it ("kill -STOP 42")
> >>>for a few hours, and see that "ps" is still
> >>>reporting 99.9% CPU usage. This is because the
> >>>kernel does not provide a decaying average.
> >>>
> >>I think the kernel provides enough info for userspace to do
> >>the job, doesn't it?
> >>
> >
> >I'm pretty sure not. Linux provides:
> >
> >per-process start time
> >current time
> >per-process total (lifetime) CPU usage
> >units of time measurement (awkwardly)
> >boot time
> 
> But your userspace program can calculate deltas in the total
> CPU statistics. Yep, its in /proc/stat.

Huh?

This isn't about "top", which displays % of CPU
time used over the refresh interval by reading
all the process data multiple times.

This is about programs like "ps", which read
everything and then spit out the output.

I hope you're not suggesting to read things
twice with a huge sleep(5) in the middle, or
to run some kind of daemon that polls /proc
once a second. That's far beyond horrid.

> >>From that you can compute %CPU over the whole
> >life of the process. This does not meet the
> >requirements of the UNIX standard.
> >
> >What we do for load average is about right,
> >except that per-process values can't all get
> >updated at the same time. So the algorithm
> >needs to be adjusted a bit to allow for that
> 
> load average is not CPU load though

Sure, but the algorithm is pretty close. Put in
a 1.0 when the CPU is used and a 0.0 when not,
and you have system-wide %CPU. To make that be
per-process instead, you need to adjust the
multiplier to account for a variable amount of
time since the process last ran. That involves
fixed-point exponentiation I guess, which might be
approximated with a polynomial or lookup table.

You can push the last step (only) out into
user-space, when the last-computed value is
adjusted for time spent since there last was
a state change between running and not. I've
doubts about this being a good idea though,
since it gives an ABI that prevents future
changes to the time constants.


