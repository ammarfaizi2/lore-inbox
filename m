Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261434AbSKHUSK>; Fri, 8 Nov 2002 15:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262327AbSKHUSK>; Fri, 8 Nov 2002 15:18:10 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:43232 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S261434AbSKHUSH>; Fri, 8 Nov 2002 15:18:07 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C0101F4F1@usslc-exch-4.slc.unisys.com>
From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
To: linux-kernel@vger.kernel.org
Subject: RE: [Linux-ia64] reader-writer livelock problem
Date: Fri, 8 Nov 2002 14:24:22 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the original post sent to the IA64 list.
Sorry if you have gotten this already:


This is a follow-up to the email thread I started on July 29th.
See http://www.cs.helsinki.fi/linux/linux-kernel/2002-30/0446.html
and the following discussion on LKML.

I'll summarize the problem again to refresh the issue.
Again, this is a correctness issue, not a performance one.

I am seeing a problem on medium-sized SMPs where user programs are
able to livelock the Linux kernel to such an extent that the
system appears dead.  With the help of some hardware debugging
tools, I was able to determine that the problem is caused by
the reader-preference reader/writer locks in the Linux kernel.
Under "heavy" reader contention, it is possible for the writer to
_never_ be able to acquire the lock since the read count never
drops to zero (since some reader always loses the cacheline after
acquiring the lock, and before it can release the lock, by which
time another reader has the lock).

I have seen this occur with at least two different reader locks,
without _trying_ to cause the problem, and I believe every reader
lock that is acquired by a system call is susceptible to this problem,
if the writer lock needs to be acquired by a processor.

A simple test-case is to run a process on every cpu in a gettimeofday()
loop.  With 16 IA64 processors doing this, the timer code takes longer
to acquire the writer lock than the 1ms between the 1KHz clock ticks,
which causes all the other interrupts directed to the BSP to get queued
up (since the timer is higher priority).  When this occurs, time
"stands still" -- calling gettimeofday() takes 0 time.

My initial suggestion was to make reader/writer locks "fair" by
setting a writer-pending bit.  However, that proposal was not
satisfactory for Linux because Linux *requires* reader-preference
reader locks because reader locks can be acquired recursively,
either through an explicit call-graph or an interrupt handler,
since interrupts are not disabled while holding a reader lock if
the interrupt handler only acquires a read lock.

There are quite a few options; I would like to hash these issues
out and determine the "best" solution.  The solutions, as I see
them, are:

1) Implement "fair" locks while providing the required semantics.
This would require pre-processor storage for the reference count,
so that a processor can acquire the reader lock if it already has
it (to prevent deadlock), and otherwise wait for a pending writer.
Costs: per-processor storage.  Writer has to wait for all the
reader reference counts to hit zero before proceeding (currently
only has to wait for the one "global" reference count).

2) Implement "scalable reader-writer locks".  See Wilson Hsieh's
paper at http://www.psg.lcs.mit.edu/papers/RWlocks.ps
This approach also requires per-processor storage, but solves the
problem in a slightly different (probably better) way.

Note that 1 and 2, in essence, convert every reader/writer lock
into a "big" reader/writer lock (see lib/brlock).

The downside here, of course, is that each lock is allocated
based on the compile-time constant for the maximum number of
processors in the system.  If a 128-byte cacheline is allocated
for every processor, that results in 4KB for each reader/writer
lock with just 32 processors.  While the memory consumption
does not disturb me, it does bother me that a driver compiled
for NR_CPUS=16 would not work with a kernel compiled with
NR_CPUS=32 (if there are > 16 CPUs).

The upside is that for read-mostly locks (> 99%) there is a
performance improvement.  Downside is that writers become more
expensive in the uncontested/lightly contested case.


3) Change the kernel to not allow reader locks to be acquired
recursively.  This change would bring Linux into line with most
other Unix-like operating systems, but requires a change in 
the locking mentality and could be difficult to get right at
this stage.  Long term, it is the most appealing to me,
even though it makes reader locks more expensive because
interrupts have to be disabled more frequently.

4) Change the reader/writer locks to be a recursive spinlock:
have a reference count and an "owner".  Processor can only
acquire the lock if a) reference count is 0, or b) reference
count is > 0 but it is the owner.

This change would only allow a single processor to be in the
critical section, but would allow it to recursively reenter.
This approach would not increase the storage requirements, and
would eliminate parallelism, but would guarantee fairness (and
slow is better than never).

5) Combination of 3&4: have "compatible" reader/writer locks
that act as #4, and new reader-writer locks that are fair (#3),
but cannot be acquired recursivly.

6) Some heuristic "hack" involving exponential backoff if a
writer is pending.  Not "guaranteed" to work.  If a writer is
pending, wait before trying to acquire the lock.  Problem is
that a cpu that already holds the reader lock will also delay
before acquiring the lock, even though it is the reason the
writer cannot acquire the lock.

The delays to use are going to be highly platform-specific
and also depend on the size of the critical section.


Other heuristics, such as using a per-processor reader-lock
count, fall apart when the contended lock is not the first
one acquired by the processor.

7) ???


I did implement #2 (without the gate MCS lock) on 2.4.x for IA64;
combined with the NMCS patch from IBM, I was unable to "hang"
the system.  For my prototype, I converted the big reader locks
into "normal" reader locks, since the regular locks now provided
the big-reader functionality.  There is still a lot of low-hanging
fruit in the prototype, but I just wanted to get something working.

The performance impact was negligible for a single processor, where
gettimeofday() ran about as fast, while stat() was around 0.2us
(10%) slower.  However, with 16 processors, gettimeofday did
not kill the clock, and stat() performance increased more than 5X,
but the big win was that the execution time was bounded: no
enormous outliers.  Note that with one processor, gettimeofday()
was called around 1200 times between clock ticks, and about the
same as a 16X (each call took longer on average) with the new
locking code.

Kevin Van Maren
