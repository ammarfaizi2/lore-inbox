Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269251AbUJEPrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269251AbUJEPrK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 11:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269162AbUJEPrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:47:10 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:63414 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269297AbUJEPlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:41:32 -0400
Date: Tue, 5 Oct 2004 08:39:46 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Roland McGrath <roland@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] CPU time clock support in clock_* syscalls
In-Reply-To: <200410050515.i955Fa15004063@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0410050826400.26772@schroedinger.engr.sgi.com>
References: <200410050515.i955Fa15004063@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2004, Roland McGrath wrote:

> This is an alternative to Christoph Lameter's proposals.  I think it
> provides better functionality, and a more robust implementation.  (The last
> version of Christoph's patch I saw had a notable lack of necessary locking,
> for example.)  I am working on an expansion of this to implement timers
> too.  But since the code I've already finished and tested does more than
> the proposal that's been floated, it seemed appropriate to separate out the
> clock sampling functionality and post this.

Thanks for posting this. My last version of the patch for
CLOCK_*_CPUTIME_ID--as in the mm kernel now--has the necessary locking.
The version you saw was an early draft and you were not cc'ed on the
later version since I did not know about your
work. If there is any locking issue remaining please point that out.

Your work on providing access to other processes timers is certainly much
more comprehensive than my draft that I whipped up yesterday to get this
thing rollling....

> This patch implements CPU time clocks in the clock_* interface
> (posix-timers) for threads and processes (thread groups).  These are
> clockid_t values with the high bits set (i.e. negative), which encode a PID
> (which can be zero to indicate the caller), and a flag indicating a
> per-thread or per-process clock.

Having these bits restricts the numeric range from which you may
be able to obtain this information. pid is signed int. My patch preserves
the ability to use the full positive range of the int to access a
process clock.

Your approach means that only a part of the range may be used. What
happens if a pid of say 2^31-10 is used with your API?

> There are three flavors of clock supported, each in thread and process
> variants.  The PROF clock counts utime + stime; this is the same clock by
> which ITIMER_PROF is defined.  The VIRT clock counts just utime; this is
> the same clock by which ITIMER_VIRTUAL is defined.  These utime and stime
> are the same values reported e.g. by getrusage and times.  That is, the
> clock accumulates 1sec/HZ for each 1sec/HZ period in which that thread was
> running when the system timer interrupt came.  The final flavor of clock is
> SCHED, which uses time as reported by `sched_clock' and count the elapsed
> time that the thread was scheduled on the CPU.  For many platforms,
> sched_clock just uses jiffies (i.e. the system timer interrupt) and so this
> is the same as the PROF clock.  But when a high-resolution cycle counter is
> available (e.g. TSC on x86), then the SCHED clock records finer-grained and
> more accurate information, because it charges a thread for the time it was
> actually on a CPU between context switches, not the whole 1sec/HZ period.
> When examining the SCHED clocks of other threads that are currently
> scheduled on other CPUs, you only see the time accumulated as of the last
> timer interrupt or context switch, but when asking about the current thread
> it also adds in the current delta since the last context switch.

Does this approach take into consideration that the TSC or cputimer may be
different on each CPU of a SMP system? There are systems with
unsynchronized TSCs, that may have different processor speeds in one SMP
system or systems may reduce the clock frequency to save power.

> The PROF and VIRT clocks are the information that's traditionally available
> and used for getrusage, SIGPROF/SIGVTALRM, etc.  The SCHED clock is the
> best information available.  I figured I'd provide all three and let
> userland decide when it wants to use which.

Thats quite impressive. Thanks for posting this.
