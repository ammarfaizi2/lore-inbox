Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTF0BW6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 21:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263279AbTF0BW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 21:22:58 -0400
Received: from fmr01.intel.com ([192.55.52.18]:5573 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S263250AbTF0BWz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 21:22:55 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH] Robust/priority-inheriting futexes for 2.5.67, take 6
Date: Thu, 26 Jun 2003 18:37:08 -0700
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AE03E82D@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Robust/priority-inheriting futexes for 2.5.67, take 6
Thread-Index: AcM8TJ6XXogAXf1pSsuRkbiqS1PZbQ==
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Jun 2003 01:37:08.0105 (UTC) FILETIME=[9F1B3F90:01C33C4C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all

This a new release of the prototype implementation that intends to
provide real-time futexes. Now we have a patch to NPTL to try
it. Bear in mind this is just a proof-of-concept, and is not
optimal, definitive or production ready. See below for some pretty
graphs on the priority inheritance process.

The patch below encloses a proposal on a way to do real-time
futexes that support priority-inheritance, priority-protection,
dead-owner recovery (more flexible than Sun's Robust Mutex
Extension) and dead lock detection, a sample implementation (sans
priority-protection) and a set of test programs along with a very
simple thread library to test it.

Note this is NOT a replacement for futexes, it is intended as a
complementary interface. rtfutexes cannot do things that normal
futexes can do because of the constraints that "real-time-ness"
(actually the current design) impose. 

I have been working on this for a while, and got input from many
different people in different companies who are interested in
these features (eg: Intel, Cisco, Montavista, OSDL ...).

Note: when you configure your kernel, make sure you have
preemption enabled as most of the "real-time"ness features that
this patch provide will work better (and as expected) with it.

Version 6 changelog

- Added the ability to disable robustness.
- Added the ability to unlock an rtfutex if you are not the
  owner.
- Work correctly when a waiting thread is woken up by a signal (in
  priority inheritance mode).
- Clean up docs here and there.
- ia64 support

Caveats:

- Priority protection not yet implemented.

- Many fixmes here and there that require answers

- Hook for properly acting when the priority of a waiting task is
  changed not implemented yet. 

- The tweak in wake_up_process() creates too much overhead, need
  to look for a better way to do it.

- The current design is starting to show its shortcomings, so
  there are many things that will probably change in the next
  release. One is going to be to properly separate futexes (wait
  queues for user space) from locks, as they are different
  entitities that require different things.

- Still based on 2.5.67 (need to change a bunch of things for
  that). You might want to apply Robert Love's patch 
  http://www.ussg.iu.edu/hypermail/linux/kernel/0306.2/1106.html
  to fix some scheduler problems that will cause deadlocks.

- requeue not implemented yet.

- PI still not works with SCHED_NORMAL ... not sure how to tackle
  this. I guess it can be done storing original priorities _and_
  policies in the task_struct and propagating the new ones ...

- Memory corruption in some stress cases that causes a kernel
  panic. Still unable to trace it down.

Check out kernel/rtfutex.c for a quick roadmap;
Documentation/rtfutex.txt for a longer series of rants and a
something more like a design reference (kind of out of
date). Documentation/rtfutex-api.txt describes how to call the
functions (in the test library, test/src/include/rtfutex.h is more
up-to-date).

You can get everything from (plus the NPTL patch) at

http://developer.osdl.org/dev/robustmutexes/

Scheduler fix patch at:

http://www.ussg.iu.edu/hypermail/linux/kernel/0306.2/1106.html

Build the test package with:

./bin/aaaa  # if you wiped ./configure
./configure --with-headers=RTFUTEX-PATCHED-LINUX-TREE/include
make
make run-tests > result
grep AUTO-RUN result

The priority inheritance tests (simple) are test-{11,12,22}, you
can run them like this:

cd src/
for pid in $$ $PPID; do chrt -p -f 20 $pid; done
./test-11 > 11-out
./do-plot 11-out

'do-plot' uses gnuplot to plot the output of the program, which is
basically a trace of the progress each thread does to reflect how
the priority inheritance is working (or how not). For example,
test-11:

http://developer.osdl.org/dev/robustmutexes/rtfutex-test-11-6.png

The TF thread runs in CPU1 (or other CPUs if more than dual
SMP). They serve as reference, the rest of the threads are bound
to CPU0. Priorities are TF > TB > TP > TL. TP starts at ~10s and
progresses more slowly than TF because it sleeps from time to
time. TL starts at ~20s, and progresses only when TP sleeps. Now
when TB is started at ~30s, it claims the lock that TL has, and
thus, boosts it up, so TP gets starved until ~50s, when TB times
out waiting and the situation goes back to normal.

Test 12 is similar, but now there are two TPs and the priorities
are TF > TB2 > TP2 > TB1 > TP1 > TL:

http://developer.osdl.org/dev/robustmutexes/rtfutex-test-12-6.png

When TB1 kicks in, TP1 is starved, then when TB2 does, TP2 lags
too and TL has the full CPU (from ~40 to ~50). 

Test 22 shows almost the same thing as test-11, but with signals
instead of timeouts cancelling the wait for the lock:

http://developer.osdl.org/dev/robustmutexes/rtfutex-test-22-6.png


Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)

