Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264326AbUAHLsA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 06:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264334AbUAHLsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 06:48:00 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:52211 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264326AbUAHLr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 06:47:58 -0500
Date: Thu, 8 Jan 2004 17:18:51 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch] RCU for low latency [0/1]
Message-ID: <20040108114851.GA5128@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On akpm's prodding, I have been looking at scheduling latency
issues due to long running interrupts. Since RCU
callbacks are invoked from softirq context, it is one of the first
things needed investigation. I used a P4 2.4Ghz UP system with 256MB
memory and dbench 32 in a loop to generate a large number of RCU
updates and measured scheduling latency using amlat
(http://www.zipworld.com.au/~akpm/linux/schedlat.html#amlat).
All measurements were done with preemption enabled of course.

Vanilla 2.6.0-test8 kernel showed a latency of around 800 microseconds
with RCU callback batches as long as 1800 callbacks. Each of these
were essentially just dentries being returned to their slab and it turns
out that we can return on an avarage 4 objects per microsecond
in that system. Thus the longest RCU callback handling took
over 400 microseconds. Clearly for sub-500 microsecond latency,
we needed to do something about this.

I have a number of experimental patches that improves latency.
The first approach took advantage of UP kernel and by ensuring
that read-side critical sections of RCU users are not interrupted
by a handler that can update it. This showed good results -
consistently around 400 microseconds of latency. However since
people seem to care about latency in SMP too, there is another
set of patches that uses per-cpu kernel thread for RCU callback processing
pretty much like ksoftirqd. Beyond a certain limit, remaining
RCU callbacks are punted to the kernel thread which can be preempted
for better latency. I did consider keventd, but it turned out
to be problematic mainly because it can get starved and other
keventd work can block for long holding up RCU. One other
optimization I did at akpm's suggestion was to do the RCU
callback punting only if there is a RT priority task in
the runqueue of that CPU. This approach too showed good results
with latency limited to around 400 microseconds.

Of course, all these were done with one type of workload aimed
at generating RCU callbacks, it would be interesting to see
how they fair with other workloads. Yet another kernel thread
is icky, but can't see another way to allow RT tasks to run.
I have also been doing instrumentation to see where the rest
of the (non-rcu-related) latency is coming from, particularly
if there are long running irqs/softirqs and it apparently is not so.
It looks like consecutive interrupts at inopportune moments
is causing additional latency.

The actual RCU patches for low latency in SMP follows. A
kernel parementer rcubhlimit sets the maximum number of callbacks
invoked from softirq context before punting to krcud (default 256).
rcubhlimit = 0 indicates no krcud at all.

These are meant for latency investigations, not meant for inclusion
yet.

Thanks
Dipankar
