Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVBXHPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVBXHPD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVBXHPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:15:03 -0500
Received: from smtp108.mail.sc5.yahoo.com ([66.163.170.6]:31418 "HELO
	smtp108.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261880AbVBXHO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:14:57 -0500
Subject: [PATCH 0/13] Multiprocessor CPU scheduler patches
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 24 Feb 2005 18:14:53 +1100
Message-Id: <1109229293.5177.64.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hope that you can include the following set of CPU scheduler
patches in -mm soon, if you have no other significant performance
work going on.

There are some fairly significant changes, with a few basic aims:
* Improve SMT behaviour
* Improve CMP behaviour, CMP/NUMA scheduling (ie. Opteron)
* Reduce task movement, esp over NUMA nodes.

They are not going to be very well tuned for most usages at the
moment (unfortunately dbt2/3-pgsql on OSDL isn't working, which
is a good one). So hopefully I can address regressions as they
come up.

There are a few problems with the scheduler currently:

Problem #1:
It has _very_ aggressive idle CPU pulling. Not only does it not
really obey imbalances, it is also wrong for eg. an SMT CPU
who's sibling is not idle. The reason this was done really is to
bring down idle time on some workloads (dbt2-pgsql, other
database stuff).

So I address this in the following ways; reduce special casing
for idle balancing, revert some of the recent moves toward even
more aggressive balancing.

Then provide a range of averaging levels for CPU "load averages",
and we choose which to use in which situation on a sched-domain
basis. This allows idle balancing to use a more instantaneous value
for calculating load, so idle CPUs need not wait many timer ticks
for the load averages to catch up. This can hopefully solve our
idle time problems.

Also, further moderate "affine wakeups", which can tend to move
most tasks to one CPU on some workloads and cause idle problems.

Problem #2:
The second problem is that balance-on-exec is not sched-domains
aware. This means it will tend to (for example) fill up two cores
of a CPU on one socket, then fill up two cores on the next socket,
etc. What we want is to try to spread load evenly across memory
controllers.

So make that sched-domains aware following the same pattern as
find_busiest_group / find_busiest_queue.

Problem #3:
Lastly, implement balance-on-fork/clone again. I have come to the
realisation that for NUMA, this is probably the best solution.
Run-cloned-child-last has run out of steam on CMP systems. What
it was supposed to do was provide a period where the child could
be pulled to another CPU before it starts running and allocating
memory. Unfortunately on CMP systems, this tends to just be to the
other sibling.

Also, having such a difference between thread and process creation
was not really ideal, so we balance on all types of fork/clone.
This really helps some things (like STREAM) on CMP Opterons, but
also hurts others, so naturally it is settable per-domain.

Problem #4:
Sched domains isn't very useful to me in its current form. Bring
it up to date with what I've been using. I don't think anyone other
than myself uses it so that should be OK.

Nick



