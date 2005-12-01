Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbVLAAGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbVLAAGc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVK3X6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:58:14 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:52898
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751299AbVK3X5p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:57:45 -0500
Subject: [patch 16/43] ktimer documentation
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:23 +0100
Message-Id: <1133395403.32542.459.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimer-documentation.patch)
- add ktimer docbook and design document

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 Documentation/DocBook/kernel-api.tmpl |    5 
 Documentation/ktimers.txt             |  239 ++++++++++++++++++++++++++++++++++
 2 files changed, 244 insertions(+)

Index: linux-2.6.15-rc2-rework/Documentation/DocBook/kernel-api.tmpl
===================================================================
--- linux-2.6.15-rc2-rework.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2.6.15-rc2-rework/Documentation/DocBook/kernel-api.tmpl
@@ -54,6 +54,11 @@
 !Ekernel/sched.c
 !Ekernel/timer.c
      </sect1>
+     <sect1><title>High-precision timers</title>
+!Iinclude/linux/ktime.h
+!Iinclude/linux/ktimer.h
+!Ekernel/ktimer.c
+     </sect1>
      <sect1><title>Internal Functions</title>
 !Ikernel/exit.c
 !Ikernel/signal.c
Index: linux-2.6.15-rc2-rework/Documentation/ktimers.txt
===================================================================
--- /dev/null
+++ linux-2.6.15-rc2-rework/Documentation/ktimers.txt
@@ -0,0 +1,239 @@
+
+ktimers - subsystem for high-precision kernel timers
+----------------------------------------------------
+
+This patch introduces a new subsystem for high-precision kernel timers.
+
+Why two timer subsystems? After a lot of back and forth trying to
+integrate high-precision and high-resolution features into the existing
+timer framework, and after testing various such high-resolution timer
+implementations in practice, we came to the conclusion that the timer
+wheel code is fundamentally not suitable for such an approach. We
+initially didnt believe this ('there must be a way to solve this'), and
+we spent a considerable effort trying to integrate things into the timer
+wheel, but we failed. There are several reasons why such integration is
+impossible:
+
+- the forced handling of low-resolution and high-resolution timers in
+  the same way leads to a lot of compromises, macro magic and #ifdef
+  mess. The timers.c code is very "tightly coded" around jiffies and
+  32-bitness assumptions, and has been honed and micro-optimized for a
+  narrow use case for many years - and thus even small extensions to it
+  frequently break the wheel concept, leading to even worse
+  compromises.
+
+- the unpredictable [O(N)] overhead of cascading leads to delays which
+  necessiate a more complex handling of high resolution timers, which
+  decreases robustness. Such a design still led to rather large timing
+  inaccuracies. Cascading is a fundamental property of the timer wheel
+  concept, it cannot be 'designed out' without unevitabling degrading
+  other portions of the timers.c code in an unacceptable way.
+
+- the implementation of the current posix-timer subsystem on top of
+  the timer wheel has already introduced a quite complex handling of
+  the required readjusting of absolute CLOCK_REALTIME timers at
+  settimeofday or NTP time - showing the rigidity of the timer wheel
+  data structure.
+
+- the timer wheel code is most optimal for use cases which can be
+  identified as "timeouts". Such timeouts are usually set up to cover
+  error conditions in various I/O paths, such as networking and block
+  I/O. The vast majority of those timers never expire and are rarely
+  recascaded because the expected correct event arrives in time so they
+  can be removed from the timer wheel before any further processing of
+  them becomes necessary. Thus the users of these timeouts can accept
+  the granularity and precision tradeoffs of the timer wheel, and
+  largely expect the timer subsystem to have near-zero overhead. Timing
+  for them is not a core purpose, it's most a necessary evil to
+  guarantee the processing of requests, which should be as cheap and
+  unintrusive as possible.
+
+The primary users of precision timers are user-space applications that
+utilize nanosleep, posix-timers and itimer interfaces. Also, in-kernel
+users like drivers and subsystems with a requirement for precise timed
+events can benefit from the availability of a seperate high-precision
+timer subsystem as well.
+
+The ktimer subsystem is easily extended with high-resolution
+capabilities, and patches for that exist and are maturing quickly. The
+increasing demand for realtime and multimedia applications along with
+other potential users for precise timers gives another reason to
+separate the "timeout" and "precise timer" subsystems.
+
+Another potential benefit is that such seperation allows for future
+optimizations of the existing timer wheel implementation for the low
+resolution and low precision use cases - once the precision-sensitive
+APIs are separated from the timer wheel and are migrated over to
+ktimers. E.g. we could decrease the frequency of the timeout subsystem
+from 250 Hz to 100 HZ (or even smaller).
+
+ktimer subsystem implementation details
+---------------------------------------
+
+the basic design considerations were:
+
+- simplicity
+- robust, extensible abstractions
+- data structure not bound to jiffies or any other granularity
+- simplification of existing, timing related kernel code
+
+From our previous experience with various approaches of high-resolution
+timers another basic requirement was the immediate enqueueing and
+ordering of timers at activation time. After looking at several possible
+solutions such as radix trees and hashes, the red black tree was choosen
+as the basic data structure. Rbtrees are available as a library in the
+kernel and are used in various performance-critical areas of e.g. memory
+management and file systems. The rbtree is solely used for the time
+sorted ordering, while a seperate list is used to give the expiry code
+fast access to the queued timers, without having to walk the rbtree.
+(This seperate list is also useful for high-resolution timers where we
+need seperate pending and expired queues while keeping the time-order
+intact.)
+
+The time-ordered enqueueing is not purely for the purposes of the
+high-resolution timers extension though, it also simplifies the handling
+of absolute timers based on CLOCK_REALTIME. The existing implementation
+needed to keep an extra list of all armed absolute CLOCK_REALTIME timers
+along with complex locking. In case of settimeofday and NTP, all the
+timers (!) had to be dequeued, the time-changing code had to fix them up
+one by one, and all of them had to be enqueued again. The time-ordered
+enqueueing and the storage of the expiry time in absolute time units
+removes all this complex and poorly scaling code from the posix-timer
+implementation - the clock can simply be set without having to touch the
+rbtree. This also makes the handling of posix-timers simpler in general.
+
+The locking and per-CPU behavior of ktimers was mostly taken from the
+existing timer wheel code, as it is mature and well suited. Sharing code
+was not really a win, due to the different data structures. Also, the
+ktimer functions now have clearer behavior and clearer names - such as
+ktimer_try_to_cancel() and ktimer_cancel() [which are roughly equivalent
+to del_timer() and del_timer_sync()] - and there's no direct 1:1 mapping
+between them on the algorithmical level.
+
+The internal representation of time values (ktime_t) is implemented via
+macros and inline functions, and can be switched between a "hybrid
+union" type and a plain "scalar" 64bit nanoseconds representation (at
+compile time). The hybrid union type exists to optimize time conversions
+on 32bit CPUs. This build-time-selectable ktime_t storage format was
+implemented to avoid the performance impact of 64-bit multiplications
+and divisions on 32bit CPUs. Such operations are frequently necessary to
+convert between the storage formats provided by kernel and userspace
+interfaces and the internal time format. (See include/linux/ktime.h for
+further details.)
+
+ktimers - rounding of timer values
+----------------------------------
+
+Why do we need rounding at all ?
+
+Firstly, the POSIX specification requires rounding to the resolution -
+whatever that means. The POSIX specification is quite imprecise on the
+details of rounding though, so a practical interpretation had to be
+found.
+
+The first question is which resolution value should be returned to the
+user by the clock_getres() interface.
+
+The simplest case is when the hardware is capable of 1 nsec resolution:
+in that case we can fulfill all wishes and there is no rounding :-)
+
+Another simple case is when the clock hardware has a limited resolution
+that the kernel wants to fully offer to user-space: in this case that
+limited resolution is returned to userspace.
+
+The hairy case is when the underlying hardware is capable of finer
+grained resolution, but the kernel is not willing to offer that
+resolution. Why would the kernel want to do that? Because e.g. the
+system could easily be DoS-ed with high-frequency timer interrupts. Or
+the kernel might want to cluster high-res timer interrupts into groups
+for performance reasons, so that extremely high interrupt rates are
+avoided. So the kernel needs some leeway in deciding the 'effective'
+resolution that it is willing to expose to userspace.
+
+In this case, the clock_getres() decision is easy: we want to return the
+'effective' resolution, not the 'theoretical' resolution. Thus an
+application programmer gets correct information about what granularity
+and accuracy to expect from the system.
+
+What is much less obvious in both the 'hardware is low-res' and 'kernel
+wants to offer low-res' cases is the actual behavior of timers, and
+where and how to round time values to the 'effective' resolution of the
+clock.
+
+For this we first need to see what types of expiries there exist for
+ktimers, and how rounding affects them. Ktimers have the following
+variants:
+
+- relative one-shot timers
+- absolute one-shot timers
+- relative interval timers
+- absolute interval timers
+
+Interval timers can be led back to one-shot timers: they are a series of
+one-shot timers with the same interval. Relative one-shot timers can be
+handled identically to absolute one-shot timers after adding the
+relative expiry time to the current time of the respective clock.
+
+We picked to handle two cases of rounding:
+
+- the rounding of the absolute value of the first expiry time
+- the rounding of the timer interval
+
+An alternative implementation would be to not round the interval and to
+implicitly round at every timer event, but it's not clear what the
+advantages would be from doing that. There are a couple of
+disadvantages:
+
+- the technique seems to contradict the standard's requirement that
+  'time values ... be rounded' (which the interval clearly is).
+
+- other OSs implement the rounding in the way we implemented it.
+
+- also, there is an application surprise factor, the 'do not round
+  intervals' technique can lead to the following sample sequence of
+  events:
+
+    Interval:   1.7ms
+    Resolution: 1ms
+
+    Event timeline:
+
+     2ms - 4ms - 6ms - 7ms - 9ms - 11ms - 12ms - 14ms - 16ms - 17ms ...
+
+  this 2,2,1,2,2,1...msec 'unpredictable and uneven' relative distance
+  of events could surprise applications.
+
+(as a sidenote, current POSIX APIs could be extended with a method of
+periodic timers to have an 'average' frequency, where there is no
+rounding of the interval. No such API exists at the moment.)
+
+ktimers - testing and verification
+----------------------------------
+
+We used the high-resolution timer subsystem ontop of ktimers to verify
+the ktimer implementation details in praxis, and we also ran the posix
+timer tests in order to ensure specification compliance.
+
+The ktimer patch converts the following kernel functionality to use
+ktimers:
+
+ - nanosleep
+ - itimers
+ - posix-timers
+
+The conversion of nanosleep and posix-timers enabled the unification of
+nanosleep and clock_nanosleep.
+
+The code was successfully compiled for the following platforms:
+
+ i386, x86_64, ARM, PPC, PPC64, IA64
+
+The code was run-tested on the following platforms:
+
+ i386(UP/SMP), x86_64(UP/SMP), ARM, PPC
+
+ktimers were also integrated into the -rt tree, along with a
+ktimers-based high-resolution timer implementation, so the ktimers code
+got a healthy amount of testing and use in practice.
+
+	Thomas Gleixner, Ingo Molnar

--

