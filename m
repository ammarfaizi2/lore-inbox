Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262366AbSKHUdH>; Fri, 8 Nov 2002 15:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262368AbSKHUdH>; Fri, 8 Nov 2002 15:33:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59406 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262366AbSKHUdC>;
	Fri, 8 Nov 2002 15:33:02 -0500
Date: Fri, 8 Nov 2002 20:39:42 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
Cc: "'Matthew Wilcox'" <willy@debian.org>,
       "''Linus Torvalds ' '" <torvalds@transmeta.com>,
       "''Jeremy Fitzhardinge ' '" <jeremy@goop.org>,
       "''William Lee Irwin III ' '" <wli@holomorphy.com>,
       "''linux-ia64@linuxia64.org ' '" <linux-ia64@linuxia64.org>,
       "''Linux Kernel List ' '" <linux-kernel@vger.kernel.org>,
       "''rusty@rustcorp.com.au ' '" <rusty@rustcorp.com.au>,
       "''dhowells@redhat.com ' '" <dhowells@redhat.com>,
       "''mingo@elte.hu ' '" <mingo@elte.hu>
Subject: Re: [Linux-ia64] reader-writer livelock problem
Message-ID: <20021108203942.P12011@parcelfarce.linux.theplanet.co.uk>
References: <3FAD1088D4556046AEC48D80B47B478C0101F4F0@usslc-exch-4.slc.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C0101F4F0@usslc-exch-4.slc.unisys.com>; from kevin.vanmaren@unisys.com on Fri, Nov 08, 2002 at 02:17:21PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 02:17:21PM -0600, Van Maren, Kevin wrote:
> > all that cacheline bouncing can't do your numa boxes any good.
> 
> It happens even on our non-NUMA boxes.  But that was the reason
> behind developing MCS locks: they are designed to minimize the
> cacheline bouncing due to lock contention, and become a win with
> a very small number of processors contending the same spinlock.

that's not my point... a resource occupies a number of cachelines;
bouncing those cachelines between processors is expensive.  if there's
a real workload that all the processors are contending for the same
resource, it's time to split up that resource.

> I was using gettimeofday() as ONE example of the problem.
> Fixing gettimeofday(), such as with frlocks (see, for example,
> http://lwn.net/Articles/7388) fixes ONE occurance of the
> problem.
> 
> Every reader/writer lock that an application can force
> the kernel to acquire can have this problem.  If there
> is enough time between acquires, it may take 32 or 64
> processors to hang the system, but livelock WILL occur.

not true.  every reader/writer lock which guards a global resource can
have this problem.  if the lock only guards your own task's resources,
there can be no problem. 

> There are MANY other cases where an application can force the
> kernel to acquire a lock needed by other things.

and i agree they should be fixed.

> Spinlocks are a slightly different story.  While there isn't
> the starvation issue, livelock can still occur if the kernel
> needs to acquire the spinlock more often that it takes to
> acquire.  This is why replacing the xtime_lock with a spinlock
> fixes the reader/writer livelock, but not the problem: while
> the writer can now get the spinlock, it can take an entire
> clock tick to acquire/release it.  So the net behavior is the
> same: with a 1KHz timer and with 1us cache-cache latency, 32
> processors spinning on gettimeofday() using a spinlock would
> have a similar result.

right.  so spinlocking this resource is also not good enough.  did
you see the "Voyager subarchitecture for 2.5.46" thread earlier this
week which discussed making it per-cpu?
http://www.uwsg.iu.edu/hypermail/linux/kernel/0211.0/1799.html
this seems like the right way to go to me.

-- 
Revolutions do not require corporate support.
