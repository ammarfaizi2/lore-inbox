Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbVJTWuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbVJTWuR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 18:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbVJTWuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 18:50:16 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:42168
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932525AbVJTWuO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 18:50:14 -0400
Subject: [ANNOUNCE] [PATCH] ktimers subsystem, reworked
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: LKML <linux-kernel@vger.kernel.org>
Cc: john stultz <johnstul@us.ibm.com>, George Anzinger <george@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 21 Oct 2005 00:52:39 +0200
Message-Id: <1129848759.16447.111.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new, much-cleaned up version of the ktimers subsystem.

We reworked the patch thoroughly and we hope to have addressed all 
points raised on lkml. Special thanks go to Andrew Morton and Arjan van 
de Ven for detailed code-review.

The new patch can be downloaded from:

2.6.14-rc4-mm1:
 http://www.tglx.de/projects/ktimers/patch-2.6.14-rc4-mm1-kt1.patch

2.6.14-rc5:
 http://www.tglx.de/projects/ktimers/patch-2.6.14-rc5-kt1.patch

The high-resolution timer combo patch including John Stultz's generic
time of day, the clockevents framework
is available too, at:

 http://www.tglx.de/projects/ktimers/patch-2.6.14-rc5-kthrt1.patch

along with the broken out version
 http://www.tglx.de/projects/ktimers/patch-2.6.14-rc5-kthrt1-broken-out.tar.bz2
and
 http://www.tglx.de/projects/ktimers/broken-out/



The text below is from Documentation/ktimers.txt, which will hopefully 
clarify most of the remaining conceptual issues raised on lkml.  
Comments, reviews, reports welcome!

ktimers - subsystem for high-precision kernel timers
----------------------------------------------------

This patch introduces a new subsystem for high-precision kernel timers.

Why two timer subsystems? After a lot of back and forth trying to
integrate high-precision and high-resolution features into the existing
timer framework, and after testing various such high-resolution timer
implementations in practice, we came to the conclusion that the timer
wheel code is fundamentally not suitable for such an approach. We
initially didnt believe this ('there must be a way to solve this'), and
we spent a considerable effort trying to integrate things into the timer
wheel, but we failed. There are several reasons why such integration is
impossible:

- the forced handling of low-resolution and high-resolution timers in
  the same way leads to a lot of compromises, macro magic and #ifdef
  mess. The timers.c code is very "tightly coded" around jiffies and
  32-bitness assumptions, and has been honed and micro-optimized for a
  narrow use case for many years - and thus even small extensions to it
  frequently break the wheel concept, leading to even worse
  compromises.

- the unpredictable [O(N)] overhead of cascading leads to delays which
  necessiate a more complex handling of high resolution timers, which
  decreases robustness. Such a design still led to rather large timing
  inaccuracies. Cascading is a fundamental property of the timer wheel
  concept, it cannot be 'designed out' without unevitabling degrading
  other portions of the timers.c code in an unacceptable way.

- the implementation of the current posix-timer subsystem on top of
  the timer wheel has already introduced a quite complex handling of
  the required readjusting of absolute CLOCK_REALTIME timers at
  settimeofday or NTP time - showing the rigidity of the timer wheel
  data structure.

- the timer wheel code is most optimal for use cases which can be
  identified as "timeouts". Such timeouts are usually set up to cover
  error conditions in various I/O paths, such as networking and block
  I/O. The vast majority of those timers never expire and are rarely
  recascaded because the expected correct event arrives in time so they
  can be removed from the timer wheel before any further processing of
  them becomes necessary. Thus the users of these timeouts can accept
  the granularity and precision tradeoffs of the timer wheel, and
  largely expect the timer subsystem to have near-zero overhead. Timing
  for them is not a core purpose, it's most a necessary evil to
  guarantee the processing of requests, which should be as cheap and
  unintrusive as possible.

The primary users of precision timers are user-space applications that
utilize nanosleep, posix-timers and itimer interfaces. Also, in-kernel
users like drivers and subsystems with a requirement for precise timed
events can benefit from the availability of a seperate high-precision
timer subsystem as well.

The ktimer subsystem is easily extended with high-resolution
capabilities, and patches for that exist and are maturing quickly. The
increasing demand for realtime and multimedia applications along with
other potential users for precise timers gives another reason to
separate the "timeout" and "precise timer" subsystems.

Another potential benefit is that such seperation allows for future
optimizations of the existing timer wheel implementation for the low
resolution and low precision use cases - once the precision-sensitive
APIs are separated from the timer wheel and are migrated over to
ktimers. E.g. we could decrease the frequency of the timeout subsystem
from 250 Hz to 100 HZ (or even smaller).

ktimer subsystem implementation details
---------------------------------------

the basic design considerations were:

- simplicity
- robust, extensible abstractions
- data structure not bound to jiffies or any other granularity
- simplification of existing, timing related kernel code

>From our previous experience with various approaches of high-resolution
timers another basic requirement was the immediate enqueueing and
ordering of timers at activation time. After looking at several possible
solutions such as radix trees and hashes, the red black tree was choosen
as the basic data structure. Rbtrees are available as a library in the
kernel and are used in various performance-critical areas of e.g. memory
management and file systems. The rbtree is solely used for the time
sorted ordering, while a seperate list is used to give the expiry code
fast access to the queued timers, without having to walk the rbtree.
(This seperate list is also useful for high-resolution timers where we
need seperate pending and expired queues while keeping the time-order
intact.)

The time-ordered enqueueing is not purely for the purposes of the
high-resolution timers extension though, it also simplifies the handling
of absolute timers based on CLOCK_REALTIME. The existing implementation
needed to keep an extra list of all armed absolute CLOCK_REALTIME timers
along with complex locking. In case of settimeofday and NTP, all the
timers (!) had to be dequeued, the time-changing code had to fix them up
one by one, and all of them had to be enqueued again. The time-ordered
enqueueing and the storage of the expiry time in absolute time units
removes all this complex and poorly scaling code from the posix-timer
implementation - the clock can simply be set without having to touch the
rbtree. This also makes the handling of posix-timers simpler in general.

The locking and per-CPU behavior of ktimers was mostly taken from the
existing timer wheel code, as it is mature and well suited. Sharing code
was not really a win, due to the different data structures. Also, the
ktimer functions now have clearer behavior and clearer names - such as
ktimer_try_to_cancel() and ktimer_cancel() [which are roughly equivalent
to del_timer() and del_timer_sync()] - and there's no direct 1:1 mapping
between them on the algorithmical level.

The internal representation of time values (ktime_t) is implemented via
macros and inline functions, and can be switched between a "hybrid
union" type and a plain "scalar" 64bit nanoseconds representation (at
compile time). The hybrid union type exists to optimize time conversions
on 32bit CPUs. This build-time-selectable ktime_t storage format was
implemented to avoid the performance impact of 64-bit multiplications
and divisions on 32bit CPUs. Such operations are frequently necessary to
convert between the storage formats provided by kernel and userspace
interfaces and the internal time format. (See include/linux/ktime.h for
further details.)

We used the high-resolution timer subsystem ontop of ktimers to verify
the ktimer implementation details in praxis, and we also ran the posix
timer tests in order to ensure specification compliance.

The ktimer patch converts the following kernel functionality to use
ktimers:

 - nanosleep
 - itimers
 - posix-timers

The conversion of nanosleep and posix-timers enabled the unification of
nanosleep and clock_nanosleep.

The code was successfully compiled for the following platforms:

 i386, x86_64, ARM, PPC, PPC64, IA64

The code was run-tested on the following platforms:

 i386(UP/SMP), x86_64(UP/SMP), ARM, PPC

ktimers were also integrated into the -rt tree, along with a
ktimers-based high-resolution timer implementation, so the ktimers code
got a healthy amount of testing and use in practice.

	Thomas Gleixner, Ingo Molnar


