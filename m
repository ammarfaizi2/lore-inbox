Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269169AbUJKSbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269169AbUJKSbd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 14:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269003AbUJKSbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 14:31:33 -0400
Received: from soufre.accelance.net ([213.162.48.15]:59351 "EHLO
	soufre.accelance.net") by vger.kernel.org with ESMTP
	id S269176AbUJKS1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 14:27:38 -0400
Subject: [ANNOUNCE] RTAI/fusion real-time extension
From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Xenomai
Message-Id: <1097519246.1289.51.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 11 Oct 2004 20:27:26 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Introducing RTAI/fusion, a real-time extension to Linux 2.6.

After several references to this project on this list during some of
the various discussions on the low latency and real-time Linux issues,
time has probably come to present it more formally, at least for the
record.

-- Purpose and motivations:

Fusion is an ongoing development branch from the RTAI project, which
aims at filling the gap between the traditional co-kernel approach for
achieving bounded worst-case jitter, and the long-standing low latency
effort which reduces the average latency figures of vanilla Linux.

Just like for the low latency effort, our final goal is to move the
applications requiring real-time guarantees out of the kernel space
where the legacy co-kernel approach used to lock them into, and let
them benefit from the regular Linux programming model in user-space,
while still guaranteeing bounded worst-case latencies. RTAI/fusion
aims at complementing the low latency support for very demanding
real-time applications which require the maximum jitter to remain in
the range of a few tenths of microseconds with no exception whatever
the load conditions are, while still being runnable in user-space.

Strict determinism is the added-value brought by this work to the low
latency effort, for an admittedly narrow but still meaningful spectrum
of real-time applications whose requirements will always remain - we
think - too stringent to cope with the perturbations induced by the
fundamental GPOS nature of Linux. In this respect, our approach does
not attempt to change this nature, but rather to better cooperate with
it, so that a broader spectrum of real-time guarantees is eventually
covered. We strive at making it efficient, simple and palatable,
without requiring traumatic changes in the standard kernel design.

The second major goal of RTAI/fusion is to ease the migration of
applications running over traditional RTOS (such as VxWorks, pSOS+,
VRTX and the like) to Linux-based systems by providing efficient API
emulations over a RTOS abstraction layer. Since a vast majority of those
systems pretty much implement the same semantics and behaviours only
using different "window dressings" for their interfaces, it is possible
to modelize a generic set of basic features and later specialize them at
will, in order to mimic each API of interest.

It is not the first time that the RTAI project works on providing
real-time support in user-space while guaranteeing very low latencies:
RTAI's LXRT sub-system achieved this five years ago on x86, and this
technology still improves and has already been ported to 2.6 earlier
this year. However, the work I'm presenting here is aiming at a much
higher level of cooperation between the real-time extension and the
Linux kernel, blurring the interface boundaries in a way which would
allow applications with stringent real-time requirements to fully benefit
from the regular Linux programming model.

-- Basic concepts:

RTAI/fusion defines two real-time operation modes for the Linux tasks
it controls:

o the primary (or hardened) mode guarantees very low latencies by
yielding control of the real-time task to a co-scheduler whose
operations cannot be delayed by any regular Linux activity, including
interrupt masking. In this mode, the task appears to the kernel as
being aslept in TASK_INTERRUPTIBLE state, but it actually runs within
its original MMU context under the control of the co-scheduler. The
task enters this mode after initialization, and each time it calls a
blocking native RTAI services.  It leaves it to enter the secondary
mode only when it issues a regular Linux syscall. Typical worst-case
scheduling latencies in this mode are currently about 50 microseconds
under high load on mid range x86 hardware.

Via dynamic interception, some of the regular Linux syscalls can be
impersonated by pure RTAI counterparts, when doing so provides a real
benefit with respect to determinism. For instance, the regular
nanosleep syscall is wired to RTAI's high-precision timer for
sub-HZ accuracy and very low scheduling latency. The task keeps
running in (or possibly switches to) primary mode when such
substituted service is called.

o the secondary (or relaxed) mode still guarantees low latencies but
with higher worst-case figures though, depending on the underlying
granularity of the Linux kernel which controls it. This mode
additionally defers interrupts to be processed by Linux as long as the
real-time task is running. The latter technique greatly improves the
execution determinism needed by CPU-bound tasks running in secondary
mode, without impacting the interrupt latency for other tasks
operating in primary mode. Moreover, the interrupt shielding prevents
priority inversions caused by mutual exclusion constructs on SMP
configurations, e.g. when a non real-time activity running on a CPU
blocks a real-time task running on another CPU for an unbounded amount
of time, because it has been preempted by some asynchronous activity
(e.g. IRQ handling) while holding a contended lock.

Linux tasks controlled by RTAI/fusion are transparently and
automatically switched between the two operating modes during their
lifetime, according to the level of real-time service they ask for,
either strict RTAI (primary) or shielded Linux (secondary). Real-time
priorities are consistently kept across those migrations, so that a
real-time task controlled by the Linux kernel could still be granted a
higher priority than others managed by the co-scheduler when required.

-- The software:

RTAI/fusion is built over the Adeos layer for prioritizing hardware
interrupt processing, and further implementing the means of
cooperation between the real-time extension and the Linux kernel.

The real-time machinery is implemented as a loadable kernel module
which features a generic RTOS core, quite useful for mimicking any
kind of real-time API on top of it. Those real-time APIs - also
available as individual loadable modules - can be stacked over the
RTOS core, and further extend the global Linux syscall space with
their own set of exported services.

Source-wise, the whole RTAI/fusion codebase totally departs from the
previous RTAI architecture and implementation, since it is based on
the original codebase from the Xenomai project, which has merged with
RTAI lately.

-- Supported architectures:

RTAI/fusion currently runs on x86 (UP and SMP), and a recent port to
PPC is also available (UP only for now).  Additionally, the HYADES
project made the RTOS core run over ia64, and we plan to integrate
this port when it is released.

-- Future direction:

VP of course, and its march toward a fully preemptible kernel model.
Since RTAI/fusion's primary mode is already close to the hardware
limits, further improvements with respect to determinism will come
from the secondary one, and the ongoing work on voluntary preemption
is something we want to leverage. To this end, we are about to re-base
our effort on VP-enabled kernels by a proper port of Adeos, and we
hope to be able to send some useful feedback about them, so that we
could help ironing this work.

-- Where is the code?

Latest release (0.6):
http://download.gna.org/rtai/experimental/fusion-0.6.tar.bz2

-- Other links:

RTAI project: http://www.aero.polimi.it/~rtai/
Adeos project: http://www.gna.org/projects/adeos/
HYADES project: http://www.hyades-itea.org/

People interested in having more details about the RTAI/fusion
architecture might find those slides useful:
http://www.enseirb.fr/~kadionik/rmll2004/presentation/philippe_gerum.pdf
-- 

Philippe.

