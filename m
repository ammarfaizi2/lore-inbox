Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbSKHULO>; Fri, 8 Nov 2002 15:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262327AbSKHULO>; Fri, 8 Nov 2002 15:11:14 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:44253 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S262326AbSKHULN>; Fri, 8 Nov 2002 15:11:13 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C0101F4F0@usslc-exch-4.slc.unisys.com>
From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
To: "'Matthew Wilcox'" <willy@debian.org>
Cc: "''Linus Torvalds ' '" <torvalds@transmeta.com>,
       "''Jeremy Fitzhardinge ' '" <jeremy@goop.org>,
       "''William Lee Irwin III ' '" <wli@holomorphy.com>,
       "''linux-ia64@linuxia64.org ' '" <linux-ia64@linuxia64.org>,
       "''Linux Kernel List ' '" <linux-kernel@vger.kernel.org>,
       "''rusty@rustcorp.com.au ' '" <rusty@rustcorp.com.au>,
       "''dhowells@redhat.com ' '" <dhowells@redhat.com>,
       "''mingo@elte.hu ' '" <mingo@elte.hu>
Subject: RE: [Linux-ia64] reader-writer livelock problem
Date: Fri, 8 Nov 2002 14:17:21 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> all that cacheline bouncing can't do your numa boxes any good.

It happens even on our non-NUMA boxes.  But that was the reason
behind developing MCS locks: they are designed to minimize the
cacheline bouncing due to lock contention, and become a win with
a very small number of processors contending the same spinlock.


> i hear x86-64 has a lockless gettimeofday.  maybe that's the solution.

I was using gettimeofday() as ONE example of the problem.
Fixing gettimeofday(), such as with frlocks (see, for example,
http://lwn.net/Articles/7388) fixes ONE occurance of the
problem.

Every reader/writer lock that an application can force
the kernel to acquire can have this problem.  If there
is enough time between acquires, it may take 32 or 64
processors to hang the system, but livelock WILL occur.

> it's really
> not the kernel's fault that your app is badly written.

There are MANY other cases where an application can force the
kernel to acquire a lock needed by other things.
The point is not whether the *application* is badly written,
but point is whether a bad application can mess up the kernel
by causing a livelock.


Spinlocks are a slightly different story.  While there isn't
the starvation issue, livelock can still occur if the kernel
needs to acquire the spinlock more often that it takes to
acquire.  This is why replacing the xtime_lock with a spinlock
fixes the reader/writer livelock, but not the problem: while
the writer can now get the spinlock, it can take an entire
clock tick to acquire/release it.  So the net behavior is the
same: with a 1KHz timer and with 1us cache-cache latency, 32
processors spinning on gettimeofday() using a spinlock would
have a similar result.

Kevin
